

set_false_path -to    [get_registers *axi_dmac*cdc_sync_stage1*]
set_false_path -from  [get_registers *axi_dmac*cdc_sync_fifo_ram*]
set_false_path -from  [get_registers *axi_dmac*eot_mem*]
set_false_path -from  [get_registers *axi_dmac*burst_len_mem*]
set_false_path -from  [get_registers *axi_dmac*cdc_sync_stage2*]      -to [get_registers *axi_dmac*up_rdata*]
set_false_path -from  [get_registers *axi_dmac*id*]                   -to [get_registers *axi_dmac*up_rdata*]
set_false_path -from  [get_registers *axi_dmac*address*]              -to [get_registers *axi_dmac*up_rdata*]

# Reset manager
set_false_path \
  -from [get_registers {*|axi_dmac_transfer:i_transfer|axi_dmac_reset_manager:i_reset_manager|do_reset}] \
  -to   [get_registers {*|axi_dmac_transfer:i_transfer|axi_dmac_reset_manager:i_reset_manager|reset_gen[*].reset_shift[*]}]

set_false_path \
  -from [get_registers {*|axi_dmac_transfer:i_transfer|axi_dmac_reset_manager:i_reset_manager|reset_gen[*].reset_shift[0]}] \
  -to   [get_registers {*|axi_dmac_transfer:i_transfer|axi_dmac_reset_manager:i_reset_manager|reset_gen[*].reset_shift[3]}]

set_false_path \
  -from [get_registers {*|axi_dmac_transfer:i_transfer|axi_dmac_reset_manager:i_reset_manager|reset_gen[*].reset_shift[0]}] \
  -to   [get_registers {*|axi_dmac_regmap:i_regmap|up_rdata[*]}]

