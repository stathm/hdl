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

# AD9136_FMC_EBZ

set_property  -dict {PACKAGE_PIN  AD10} [get_ports tx_ref_clk_p]                                      ; ## D04  FMC_HPC_GBTCLK0_M2C_P
set_property  -dict {PACKAGE_PIN  AD9 } [get_ports tx_ref_clk_n]                                      ; ## D05  FMC_HPC_GBTCLK0_M2C_N

set_property  -dict {PACKAGE_PIN  AF2 } [get_ports tx_data_p[0]]                                      ; ## A38  FMC_HPC_DP5_C2M_P
set_property  -dict {PACKAGE_PIN  AF1 } [get_ports tx_data_n[0]]                                      ; ## A39  FMC_HPC_DP5_C2M_N
set_property  -dict {PACKAGE_PIN  AE4 } [get_ports tx_data_p[1]]                                      ; ## B36  FMC_HPC_DP6_C2M_P
set_property  -dict {PACKAGE_PIN  AE3 } [get_ports tx_data_n[1]]                                      ; ## B37  FMC_HPC_DP6_C2M_N
set_property  -dict {PACKAGE_PIN  AH2 } [get_ports tx_data_p[2]]                                      ; ## A34  FMC_HPC_DP4_C2M_P
set_property  -dict {PACKAGE_PIN  AH1 } [get_ports tx_data_n[2]]                                      ; ## A35  FMC_HPC_DP4_C2M_N
set_property  -dict {PACKAGE_PIN  AD2 } [get_ports tx_data_p[3]]                                      ; ## B32  FMC_HPC_DP7_C2M_P
set_property  -dict {PACKAGE_PIN  AD1 } [get_ports tx_data_n[3]]                                      ; ## B33  FMC_HPC_DP7_C2M_N
set_property  -dict {PACKAGE_PIN  AK2 } [get_ports tx_data_p[4]]                                      ; ## A30  FMC_HPC_DP3_C2M_P
set_property  -dict {PACKAGE_PIN  AK1 } [get_ports tx_data_n[4]]                                      ; ## A31  FMC_HPC_DP3_C2M_N
set_property  -dict {PACKAGE_PIN  AJ4 } [get_ports tx_data_p[5]]                                      ; ## A26  FMC_HPC_DP2_C2M_P
set_property  -dict {PACKAGE_PIN  AJ3 } [get_ports tx_data_n[5]]                                      ; ## A27  FMC_HPC_DP2_C2M_N
set_property  -dict {PACKAGE_PIN  AK6 } [get_ports tx_data_p[6]]                                      ; ## A22  FMC_HPC_DP1_C2M_P
set_property  -dict {PACKAGE_PIN  AK5 } [get_ports tx_data_n[6]]                                      ; ## A23  FMC_HPC_DP1_C2M_N
set_property  -dict {PACKAGE_PIN  AK10} [get_ports tx_data_p[7]]                                      ; ## C02  FMC_HPC_DP0_C2M_P
set_property  -dict {PACKAGE_PIN  AK9 } [get_ports tx_data_n[7]]                                      ; ## C03  FMC_HPC_DP0_C2M_N

set_property  -dict {PACKAGE_PIN  AG21  IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports tx_sync_p]      ; ## D07  FMC_HPC_LA01_P
set_property  -dict {PACKAGE_PIN  AH21  IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports tx_sync_n]      ; ## D08  FMC_HPC_LA01_N
set_property  -dict {PACKAGE_PIN  AF20  IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports tx_sysref_p]    ; ## G06  FMC_HPC_LA00_P
set_property  -dict {PACKAGE_PIN  AG20  IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports tx_sysref_n]    ; ## G07  FMC_HPC_LA00_N

set_property  -dict {PACKAGE_PIN  AH24  IOSTANDARD LVCMOS25} [get_ports spi_en]                       ; ## D12  FMC_HPC_LA05_N

set_property  -dict {PACKAGE_PIN  AH19  IOSTANDARD LVCMOS25} [get_ports spi_clk]                      ; ## G09  FMC_HPC_LA03_P
set_property  -dict {PACKAGE_PIN  AJ19  IOSTANDARD LVCMOS25} [get_ports spi_mosi]                     ; ## G10  FMC_HPC_LA03_N
set_property  -dict {PACKAGE_PIN  AJ20  IOSTANDARD LVCMOS25} [get_ports spi_miso]                     ; ## H10  FMC_HPC_LA04_P
set_property  -dict {PACKAGE_PIN  AK20  IOSTANDARD LVCMOS25} [get_ports spi_csn_dac]                  ; ## H11  FMC_HPC_LA04_N
set_property  -dict {PACKAGE_PIN  AH23  IOSTANDARD LVCMOS25} [get_ports spi_csn_clk]                  ; ## D11  FMC_HPC_LA05_P

set_property  -dict {PACKAGE_PIN  AJ23  IOSTANDARD LVCMOS25} [get_ports dac_txen[0]]                  ; ## H13  FMC_HPC_LA07_P
set_property  -dict {PACKAGE_PIN  AJ24  IOSTANDARD LVCMOS25} [get_ports dac_txen[1]]                  ; ## H14  FMC_HPC_LA07_N

# clocks

# Maximum lane supported by the ZC706
create_clock -name tx_ref_clk   -period  3.875 [get_ports tx_ref_clk_p]
