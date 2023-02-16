onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/clk_i
add wave -noupdate /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/rst_ni
add wave -noupdate -expand /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/commit_sbe_i
add wave -noupdate /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/commit_ack_i
add wave -noupdate /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/priv_lvl_i
add wave -noupdate -expand /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_config_i
add wave -noupdate /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_wait_o
add wave -noupdate /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_fault_o
add wave -noupdate -color Red /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_filter_i/priv_lvl_i
add wave -noupdate -color Red -expand -subitemconfig {{/ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_filter_i/log_o[1]} {-color Red} {/ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_filter_i/log_o[0]} {-color Red}} /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_filter_i/log_o
add wave -noupdate -color Red /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_filter_i/cfi_o
add wave -noupdate -color Gold -expand -subitemconfig {{/ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_queue_ctrl_i/log_i[1]} {-color Gold} {/ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_queue_ctrl_i/log_i[0]} {-color Gold}} /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_queue_ctrl_i/log_i
add wave -noupdate -color Gold /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_queue_ctrl_i/log_cfi_i
add wave -noupdate -color Gold /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_queue_ctrl_i/log_ack_i
add wave -noupdate -color Gold /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_queue_ctrl_i/queue_full_i
add wave -noupdate -color Gold /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_queue_ctrl_i/queue_push_o
add wave -noupdate -color Gold /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_queue_ctrl_i/queue_data_o
add wave -noupdate -color Gold /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_queue_ctrl_i/cfi_halt_o
add wave -noupdate -color Blue /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_queue_i/full_o
add wave -noupdate -color Blue /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_queue_i/empty_o
add wave -noupdate -color Blue -radix unsigned /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_queue_i/usage_o
add wave -noupdate -color Blue /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_queue_i/data_i
add wave -noupdate -color Blue /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_queue_i/push_i
add wave -noupdate -color Blue /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_queue_i/data_o
add wave -noupdate -color Blue /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_queue_i/pop_i
add wave -noupdate -color Magenta /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_backend_dummy_i/log_i
add wave -noupdate -color Magenta /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_backend_dummy_i/queue_empty_i
add wave -noupdate -color Magenta /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_backend_dummy_i/queue_pop_o
add wave -noupdate -color Magenta /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_backend_dummy_i/cfi_fault_o
add wave -noupdate -color Magenta /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_backend_dummy_i/curr_state
add wave -noupdate -color Magenta /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_backend_dummy_i/counter_q
add wave -noupdate -color Magenta /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/cfi_stage_i/cfi_backend_dummy_i/log_q
add wave -noupdate -color {Sky Blue} -radix unsigned /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/csr_regfile_i/cfi_mactive_q
add wave -noupdate -color {Sky Blue} -radix unsigned /ariane_tb/dut/i_host_domain/i_cva6_subsystem/i_ariane_wrap/i_ariane/csr_regfile_i/cfi_mwait_q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0} {{Cursor 2} {183456610 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 573
configure wave -valuecolwidth 267
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {201442552 ps}
