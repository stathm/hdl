# ***************************************************************************
# ***************************************************************************
# Copyright 2018 (c) Analog Devices, Inc. All rights reserved.
#
# In this HDL repository, there are many different and unique modules, consisting
# of various HDL (Verilog or VHDL) components. The individual modules are
# developed independently, and may be accompanied by separate and unique license
# terms.
#
# The user should read each of these license terms, and understand the
# freedoms and responsibilities that he or she has by using this source/core.
#
# This core is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE.
#
# Redistribution and use of source or resulting binaries, with or without modification
# of this file, are permitted under one of the following two license terms:
#
#   1. The GNU General Public License version 2 as published by the
#      Free Software Foundation, which can be found in the top level directory
#      of this repository (LICENSE_GPL2), and also online at:
#      <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>
#
# OR
#
#   2. An ADI specific BSD license, which can be found in the top level directory
#      of this repository (LICENSE_ADIBSD), and also on-line at:
#      https://github.com/analogdevicesinc/hdl/blob/master/LICENSE_ADIBSD
#      This will allow to generate bit files and not release the source code,
#      as long as it attaches to an ADI device.
#
# ***************************************************************************
# ***************************************************************************

source $ad_hdl_dir/library/jesd204/scripts/jesd204.tcl

set NUM_OF_LANES 8
set NUM_OF_CHANNELS 2
set SAMPLE_WIDTH 16

set DAC_DATA_WIDTH [expr $NUM_OF_LANES * 32]
set CHANNEL_DATA_WIDTH [expr $DAC_DATA_WIDTH / $NUM_OF_CHANNELS]

# dac peripherals

# JESD204 PHY layer peripheral
ad_ip_instance axi_adxcvr axi_ad9136_xcvr [list \
  CONFIG.NUM_OF_LANES $NUM_OF_LANES \
  CONFIG.QPLL_ENABLE 1 \
  CONFIG.TX_OR_RX_N 1 \
]

# JESD204 link layer peripheral
adi_axi_jesd204_tx_create axi_ad9136_jesd $NUM_OF_LANES

# JESD204 transport layer peripheral
ad_ip_instance ad_ip_jesd204_tpl_dac ad9136_tpl_core [list \
  CONFIG.NUM_LANES $NUM_OF_LANES \
  CONFIG.NUM_CHANNELS $NUM_OF_CHANNELS \
  CONFIG.CHANNEL_WIDTH $SAMPLE_WIDTH \
]

ad_ip_instance util_upack axi_ad9136_upack [list \
  CONFIG.CHANNEL_DATA_WIDTH $CHANNEL_DATA_WIDTH \
  CONFIG.NUM_OF_CHANNELS $NUM_OF_CHANNELS \
]

ad_ip_instance axi_dmac axi_ad9136_dma [list \
  CONFIG.DMA_TYPE_SRC 0 \
  CONFIG.DMA_TYPE_DEST 1 \
  CONFIG.DMA_DATA_WIDTH_SRC 64 \
  CONFIG.DMA_DATA_WIDTH_DEST 256 \
]

# shared transceiver core

ad_ip_instance util_adxcvr util_daq2_xcvr [list \
  CONFIG.RX_NUM_OF_LANES 0 \
  CONFIG.TX_NUM_OF_LANES $NUM_OF_LANES \
  CONFIG.TX_LANE_INVERT [expr 0x0f] \
]

ad_connect  sys_cpu_resetn util_daq2_xcvr/up_rstn
ad_connect  sys_cpu_clk util_daq2_xcvr/up_clk

# reference clocks & resets

create_bd_port -dir I tx_ref_clk_0
create_bd_port -dir I tx_device_clk_0

ad_xcvrpll  tx_ref_clk_0 util_daq2_xcvr/qpll_ref_clk_*
ad_xcvrpll  tx_ref_clk_0 util_daq2_xcvr/cpll_ref_clk_*
ad_xcvrpll  axi_ad9136_xcvr/up_pll_rst util_daq2_xcvr/up_qpll_rst_*
ad_xcvrpll  axi_ad9136_xcvr/up_pll_rst util_daq2_xcvr/up_cpll_rst_*

# connections (dac)

ad_xcvrcon  util_daq2_xcvr axi_ad9136_xcvr axi_ad9136_jesd {} tx_device_clk_0
ad_connect  tx_device_clk_0 ad9136_tpl_core/link_clk
ad_connect  tx_device_clk_0 axi_ad9136_upack/dac_clk

ad_connect  axi_ad9136_jesd/tx_data ad9136_tpl_core/link

ad_ip_instance xlconcat ad9136_data_concat [list \
  CONFIG.NUM_PORTS $NUM_OF_CHANNELS
]

for {set i 0} {$i < $NUM_OF_CHANNELS} {incr i} {
  ad_ip_instance xlslice ad9136_enable_slice_$i [list \
		CONFIG.DIN_WIDTH $NUM_OF_CHANNELS \
		CONFIG.DIN_FROM $i \
		CONFIG.DIN_TO $i \
  ]

  ad_ip_instance xlslice ad9136_valid_slice_$i [list \
    CONFIG.DIN_WIDTH $NUM_OF_CHANNELS \
    CONFIG.DIN_FROM $i \
    CONFIG.DIN_TO $i \
  ]

  ad_connect ad9136_tpl_core/enable ad9136_enable_slice_$i/Din
  ad_connect ad9136_tpl_core/dac_valid ad9136_valid_slice_$i/Din

  ad_connect ad9136_enable_slice_$i/Dout axi_ad9136_upack/dac_enable_$i
  ad_connect ad9136_valid_slice_$i/Dout axi_ad9136_upack/dac_valid_$i
  ad_connect axi_ad9136_upack/dac_data_$i ad9136_data_concat/In$i
}

ad_connect ad9136_tpl_core/dac_ddata ad9136_data_concat/dout

ad_connect  tx_device_clk_0 axi_ad9136_fifo/dac_clk
ad_connect  axi_ad9136_jesd_rstgen/peripheral_reset axi_ad9136_fifo/dac_rst
ad_connect  axi_ad9136_upack/dac_valid axi_ad9136_fifo/dac_valid
ad_connect  axi_ad9136_upack/dac_data axi_ad9136_fifo/dac_data
ad_connect  ad9136_tpl_core/dac_dunf axi_ad9136_fifo/dac_dunf
ad_connect  sys_cpu_clk axi_ad9136_fifo/dma_clk
ad_connect  sys_cpu_reset axi_ad9136_fifo/dma_rst
ad_connect  sys_cpu_clk axi_ad9136_dma/m_axis_aclk
ad_connect  sys_cpu_resetn axi_ad9136_dma/m_src_axi_aresetn
ad_connect  axi_ad9136_fifo/dma_xfer_req axi_ad9136_dma/m_axis_xfer_req
ad_connect  axi_ad9136_fifo/dma_ready axi_ad9136_dma/m_axis_ready
ad_connect  axi_ad9136_fifo/dma_data axi_ad9136_dma/m_axis_data
ad_connect  axi_ad9136_fifo/dma_valid axi_ad9136_dma/m_axis_valid
ad_connect  axi_ad9136_fifo/dma_xfer_last axi_ad9136_dma/m_axis_last

# interconnect (cpu)

ad_cpu_interconnect 0x44A60000 axi_ad9136_xcvr
ad_cpu_interconnect 0x44A00000 ad9136_tpl_core
ad_cpu_interconnect 0x44A90000 axi_ad9136_jesd
ad_cpu_interconnect 0x7c420000 axi_ad9136_dma

# interconnect (mem/dac)

ad_mem_hp1_interconnect sys_cpu_clk sys_ps7/S_AXI_HP1
ad_mem_hp1_interconnect sys_cpu_clk axi_ad9136_dma/m_src_axi

# interrupts

ad_cpu_interrupt ps-10 mb-15 axi_ad9136_jesd/irq
ad_cpu_interrupt ps-12 mb-13 axi_ad9136_dma/irq

ad_connect  axi_ad9136_fifo/bypass GND
