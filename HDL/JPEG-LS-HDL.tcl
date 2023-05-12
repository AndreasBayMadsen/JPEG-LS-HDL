#*****************************************************************************************
# Vivado (TM) v2022.2 (64-bit)
#
# JPEG-LS-HDL.tcl: Tcl script for re-creating project 'JPEG-LS-HDL'
#
# IP Build 3669848 on Fri Oct 14 08:30:02 MDT 2022
#
# This file contains the Vivado Tcl commands for re-creating the project to the state*
# when this script was generated. In order to re-create the project, please source this
# file in the Vivado Tcl Shell.
#
# * Note that the runs in the created project will be configured the same way as the
#   original project, however they will not be launched automatically. To regenerate the
#   run results please launch the synthesis/implementation runs as needed.
#
#*****************************************************************************************
# Check file required for this script exists
proc checkRequiredFiles { origin_dir} {
  set files [list \
 "[file normalize "$origin_dir/ip/collector_bram/collector_bram.xci"]"\
 "[file normalize "$origin_dir/src/JPEG_LS_module.vhd"]"\
 "[file normalize "$origin_dir/src/collector.vhd"]"\
 "[file normalize "$origin_dir/src/context_modeller.vhd"]"\
 "[file normalize "$origin_dir/src/context_updater.vhd"]"\
 "[file normalize "$origin_dir/src/error_mapper.vhd"]"\
 "[file normalize "$origin_dir/src/fixed_predictor.vhd"]"\
 "[file normalize "$origin_dir/src/golomb_coder.vhd"]"\
 "[file normalize "$origin_dir/src/gradient.vhd"]"\
 "[file normalize "$origin_dir/src/k_calculator.vhd"]"\
 "[file normalize "$origin_dir/src/pipeline_module_1.vhd"]"\
 "[file normalize "$origin_dir/src/pipeline_module_3.vhd"]"\
 "[file normalize "$origin_dir/src/pipeline_module_4.vhd"]"\
 "[file normalize "$origin_dir/src/prediction_adder.vhd"]"\
 "[file normalize "$origin_dir/src/JPEG_LS_module_top_impl.vhd"]"\
 "[file normalize "$origin_dir/src/JPEG_LS_module_top.vhd"]"\
 "[file normalize "$origin_dir/src/btn_pulse.vhd"]"\
 "[file normalize "$origin_dir/ip/HWT_cam_sim_clk/HWT_cam_sim_clk.xci"]"\
 "[file normalize "$origin_dir/hw_tests/HWT_cam_sim.vhd"]"\
 "[file normalize "$origin_dir/src/debounce.vhd"]"\
 "[file normalize "$origin_dir/ip/output_buffer_bram/output_buffer_bram.xci"]"\
 "[file normalize "$origin_dir/src/output_buffer.vhd"]"\
 "[file normalize "$origin_dir/src/clk_divider.vhd"]"\
 "[file normalize "$origin_dir/src/uart_module.vhd"]"\
 "[file normalize "$origin_dir/src/output_uart_sender.vhd"]"\
 "[file normalize "$origin_dir/src/golomb_top.vhd"]"\
 "[file normalize "$origin_dir/hw_tests/no_border_low_res.coe"]"\
 "[file normalize "$origin_dir/hw_tests/HWT_collector.vhd"]"\
 "[file normalize "$origin_dir/ip/HWT_collector_bram/HWT_collector_bram.xci"]"\
 "[file normalize "$origin_dir/ip/HWT_collector_ila/HWT_collector_ila.xci"]"\
 "[file normalize "$origin_dir/ip/HWT_collector_clk/HWT_collector_clk.xci"]"\
 "[file normalize "$origin_dir/ip/context_modeller_bram/context_modeller_bram.xci"]"\
 "[file normalize "$origin_dir/ip/TB_HWT_cam_sim_bram/TB_HWT_cam_sim_bram.xci"]"\
 "[file normalize "$origin_dir/constr/timing.xdc"]"\
 "[file normalize "$origin_dir/constr/PYNQ-Z2 v1.0.xdc"]"\
 "[file normalize "$origin_dir/sim/TB_HWT_cam_sim.vhd"]"\
 "[file normalize "$origin_dir/src/collector.vhd"]"\
 "[file normalize "$origin_dir/src/fixed_predictor.vhd"]"\
 "[file normalize "$origin_dir/sim/TB_collector.vhd"]"\
 "[file normalize "$origin_dir/sim/TB_fixed_predictor.vhd"]"\
 "[file normalize "$origin_dir/sim/TB_golomb_coder.vhd"]"\
 "[file normalize "$origin_dir/sim/TB_gradient.vhd"]"\
 "[file normalize "$origin_dir/src/TB_output_buffer.vhd"]"\
 "[file normalize "$origin_dir/sim/TB_output_uart_sender.vhd"]"\
 "[file normalize "$origin_dir/sim/camera_simulator.vhd"]"\
 "[file normalize "$origin_dir/sim_cfg/TB_collector_behav.wcfg"]"\
 "[file normalize "$origin_dir/sim_cfg/TB_gradient_behav.wcfg"]"\
 "[file normalize "$origin_dir/sim_cfg/TB_golomb_coder_behav.wcfg"]"\
 "[file normalize "$origin_dir/sim_cfg/TB_context_modeller_behav.wcfg"]"\
 "[file normalize "$origin_dir/sim_cfg/TB_HWT_cam_sim_behav.wcfg"]"\
 "[file normalize "$origin_dir/sim_cfg/TB_output_buffer_behav.wcfg"]"\
 "[file normalize "$origin_dir/sim_cfg/TB_output_uart_sender_behav.wcfg"]"\
 "[file normalize "$origin_dir/sim/camera_simulator.vhd"]"\
 "[file normalize "$origin_dir/sim/TB_full_sim_impl.vhd"]"\
 "[file normalize "$origin_dir/sim/TB_full_sim.vhd"]"\
 "[file normalize "$origin_dir/sim/TB_pl_test.vhd"]"\
 "[file normalize "$origin_dir/sim_cfg/TB_full_sim_behav.wcfg"]"\
 "[file normalize "$origin_dir/sim_cfg/TB_pl_test_func_impl.wcfg"]"\
 "[file normalize "$origin_dir/sim_cfg/TB_full_sim_impl_func_synth.wcfg"]"\
 "[file normalize "$origin_dir/sim/TB_full_sim_synth.vhd"]"\
 "[file normalize "$origin_dir/sim/TB_golomb_coder_impl.vhd"]"\
 "[file normalize "$origin_dir/sim/TB_gradient_impl.vhd"]"\
 "[file normalize "$origin_dir/sim/TB_output_buffer_synth.vhd"]"\
 "[file normalize "$origin_dir/sim_cfg/TB_output_buffer_synth_func_synth.wcfg"]"\
 "[file normalize "$origin_dir/sim/TB_fixed_predictor_impl.vhd"]"\
  ]
  foreach ifile $files {
    if { ![file isfile $ifile] } {
      puts " Could not find remote file $ifile "
      set status false
    }
  }

  return $status
}
# Set the reference directory for source file relative paths (by default the value is script directory path)
set origin_dir [file dirname [info script]]

# Use origin directory path location variable, if specified in the tcl shell
if { [info exists ::origin_dir_loc] } {
  set origin_dir $::origin_dir_loc
}

# Set the project name
set _xil_proj_name_ "JPEG-LS-HDL"

# Use project name variable, if specified in the tcl shell
if { [info exists ::user_project_name] } {
  set _xil_proj_name_ $::user_project_name
}

variable script_file
set script_file "JPEG-LS-HDL.tcl"

# Help information for this script
proc print_help {} {
  variable script_file
  puts "\nDescription:"
  puts "Recreate a Vivado project from this script. The created project will be"
  puts "functionally equivalent to the original project for which this script was"
  puts "generated. The script contains commands for creating a project, filesets,"
  puts "runs, adding/importing sources and setting properties on various objects.\n"
  puts "Syntax:"
  puts "$script_file"
  puts "$script_file -tclargs \[--origin_dir <path>\]"
  puts "$script_file -tclargs \[--project_name <name>\]"
  puts "$script_file -tclargs \[--help\]\n"
  puts "Usage:"
  puts "Name                   Description"
  puts "-------------------------------------------------------------------------"
  puts "\[--origin_dir <path>\]  Determine source file paths wrt this path. Default"
  puts "                       origin_dir path value is \".\", otherwise, the value"
  puts "                       that was set with the \"-paths_relative_to\" switch"
  puts "                       when this script was generated.\n"
  puts "\[--project_name <name>\] Create project with the specified name. Default"
  puts "                       name is the name of the project from where this"
  puts "                       script was generated.\n"
  puts "\[--help\]               Print help information for this script"
  puts "-------------------------------------------------------------------------\n"
  exit 0
}

if { $::argc > 0 } {
  for {set i 0} {$i < $::argc} {incr i} {
    set option [string trim [lindex $::argv $i]]
    switch -regexp -- $option {
      "--origin_dir"   { incr i; set origin_dir [lindex $::argv $i] }
      "--project_name" { incr i; set _xil_proj_name_ [lindex $::argv $i] }
      "--help"         { print_help }
      default {
        if { [regexp {^-} $option] } {
          puts "ERROR: Unknown option '$option' specified, please type '$script_file -tclargs --help' for usage info.\n"
          return 1
        }
      }
    }
  }
}

# Set the directory path for the original project from where this script was exported
set orig_proj_dir "[file normalize "$origin_dir/vivado_project"]"

# Check for paths and files needed for project creation
set validate_required 0
if { $validate_required } {
  if { [checkRequiredFiles $origin_dir] } {
    puts "Tcl file $script_file is valid. All files required for project creation is accesable. "
  } else {
    puts "Tcl file $script_file is not valid. Not all files required for project creation is accesable. "
    return
  }
}

# Create project
create_project ${_xil_proj_name_} $origin_dir/vivado_project -part xc7z020clg400-1 -quiet -force

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Set project properties
set obj [current_project]
set_property -name "board_part" -value "tul.com.tw:pynq-z2:part0:1.0" -objects $obj
set_property -name "customized_default_ip_location" -value "/home/andreas/Desktop/ProfileProject/JPEG-LS-HDL/HDL/ip" -objects $obj
set_property -name "default_lib" -value "xil_defaultlib" -objects $obj
set_property -name "enable_resource_estimation" -value "0" -objects $obj
set_property -name "enable_vhdl_2008" -value "1" -objects $obj
set_property -name "ip_cache_permissions" -value "read write" -objects $obj
set_property -name "ip_output_repo" -value "$proj_dir/${_xil_proj_name_}.cache/ip" -objects $obj
set_property -name "mem.enable_memory_map_generation" -value "1" -objects $obj
set_property -name "platform.board_id" -value "pynq-z2" -objects $obj
set_property -name "revised_directory_structure" -value "1" -objects $obj
set_property -name "sim.central_dir" -value "$proj_dir/${_xil_proj_name_}.ip_user_files" -objects $obj
set_property -name "sim.ip.auto_export_scripts" -value "1" -objects $obj
set_property -name "simulator.activehdl_gcc_version" -value "9.3.0" -objects $obj
set_property -name "simulator.activehdl_version" -value "13.0" -objects $obj
set_property -name "simulator.ies_gcc_version" -value "6.2.0" -objects $obj
set_property -name "simulator.ies_version" -value "15.20.083" -objects $obj
set_property -name "simulator.modelsim_gcc_version" -value "7.4.0" -objects $obj
set_property -name "simulator.modelsim_version" -value "2022.2" -objects $obj
set_property -name "simulator.questa_gcc_version" -value "7.4.0" -objects $obj
set_property -name "simulator.questa_version" -value "2022.2" -objects $obj
set_property -name "simulator.riviera_gcc_version" -value "9.3.0" -objects $obj
set_property -name "simulator.riviera_version" -value "2022.04" -objects $obj
set_property -name "simulator.vcs_gcc_version" -value "9.2.0" -objects $obj
set_property -name "simulator.vcs_version" -value "S-2021.09" -objects $obj
set_property -name "simulator.xcelium_gcc_version" -value "9.3.0" -objects $obj
set_property -name "simulator.xcelium_version" -value "21.09.009" -objects $obj
set_property -name "simulator.xsim_gcc_version" -value "6.2.0" -objects $obj
set_property -name "simulator.xsim_version" -value "2022.2" -objects $obj
set_property -name "simulator_language" -value "Mixed" -objects $obj
set_property -name "sim_compile_state" -value "1" -objects $obj
set_property -name "target_language" -value "VHDL" -objects $obj
set_property -name "webtalk.activehdl_export_sim" -value "51" -objects $obj
set_property -name "webtalk.modelsim_export_sim" -value "51" -objects $obj
set_property -name "webtalk.questa_export_sim" -value "51" -objects $obj
set_property -name "webtalk.riviera_export_sim" -value "51" -objects $obj
set_property -name "webtalk.vcs_export_sim" -value "51" -objects $obj
set_property -name "webtalk.xsim_export_sim" -value "51" -objects $obj
set_property -name "webtalk.xsim_launch_sim" -value "665" -objects $obj
set_property -name "xpm_libraries" -value "XPM_CDC XPM_FIFO XPM_MEMORY" -objects $obj

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
set files [list \
 [file normalize "${origin_dir}/ip/collector_bram/collector_bram.xci"] \
 [file normalize "${origin_dir}/src/JPEG_LS_module.vhd"] \
 [file normalize "${origin_dir}/src/collector.vhd"] \
 [file normalize "${origin_dir}/src/context_modeller.vhd"] \
 [file normalize "${origin_dir}/src/context_updater.vhd"] \
 [file normalize "${origin_dir}/src/error_mapper.vhd"] \
 [file normalize "${origin_dir}/src/fixed_predictor.vhd"] \
 [file normalize "${origin_dir}/src/golomb_coder.vhd"] \
 [file normalize "${origin_dir}/src/gradient.vhd"] \
 [file normalize "${origin_dir}/src/k_calculator.vhd"] \
 [file normalize "${origin_dir}/src/pipeline_module_1.vhd"] \
 [file normalize "${origin_dir}/src/pipeline_module_3.vhd"] \
 [file normalize "${origin_dir}/src/pipeline_module_4.vhd"] \
 [file normalize "${origin_dir}/src/prediction_adder.vhd"] \
 [file normalize "${origin_dir}/src/JPEG_LS_module_top_impl.vhd"] \
 [file normalize "${origin_dir}/src/JPEG_LS_module_top.vhd"] \
 [file normalize "${origin_dir}/src/btn_pulse.vhd"] \
 [file normalize "${origin_dir}/ip/HWT_cam_sim_clk/HWT_cam_sim_clk.xci"] \
 [file normalize "${origin_dir}/hw_tests/HWT_cam_sim.vhd"] \
 [file normalize "${origin_dir}/src/debounce.vhd"] \
 [file normalize "${origin_dir}/ip/output_buffer_bram/output_buffer_bram.xci"] \
 [file normalize "${origin_dir}/src/output_buffer.vhd"] \
 [file normalize "${origin_dir}/src/clk_divider.vhd"] \
 [file normalize "${origin_dir}/src/uart_module.vhd"] \
 [file normalize "${origin_dir}/src/output_uart_sender.vhd"] \
 [file normalize "${origin_dir}/src/golomb_top.vhd"] \
 [file normalize "${origin_dir}/hw_tests/no_border_low_res.coe"] \
 [file normalize "${origin_dir}/hw_tests/HWT_collector.vhd"] \
 [file normalize "${origin_dir}/ip/HWT_collector_bram/HWT_collector_bram.xci"] \
 [file normalize "${origin_dir}/ip/HWT_collector_ila/HWT_collector_ila.xci"] \
 [file normalize "${origin_dir}/ip/HWT_collector_clk/HWT_collector_clk.xci"] \
]
add_files -norecurse -fileset $obj $files

# Set 'sources_1' fileset file properties for remote files
set file "$origin_dir/ip/collector_bram/collector_bram.xci"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "generate_files_for_reference" -value "0" -objects $file_obj
set_property -name "registered_with_manager" -value "1" -objects $file_obj
if { ![get_property "is_locked" $file_obj] } {
  set_property -name "synth_checkpoint_mode" -value "Singular" -objects $file_obj
}

set file "$origin_dir/src/JPEG_LS_module.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/src/collector.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/src/context_modeller.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/src/context_updater.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/src/error_mapper.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/src/fixed_predictor.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/src/golomb_coder.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/src/gradient.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/src/k_calculator.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/src/pipeline_module_1.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/src/pipeline_module_3.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/src/pipeline_module_4.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/src/prediction_adder.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/src/JPEG_LS_module_top_impl.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/src/JPEG_LS_module_top.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/src/btn_pulse.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/ip/HWT_cam_sim_clk/HWT_cam_sim_clk.xci"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "generate_files_for_reference" -value "0" -objects $file_obj
set_property -name "registered_with_manager" -value "1" -objects $file_obj
if { ![get_property "is_locked" $file_obj] } {
  set_property -name "synth_checkpoint_mode" -value "Singular" -objects $file_obj
}

set file "$origin_dir/hw_tests/HWT_cam_sim.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/src/debounce.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/ip/output_buffer_bram/output_buffer_bram.xci"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "generate_files_for_reference" -value "0" -objects $file_obj
if { ![get_property "is_locked" $file_obj] } {
  set_property -name "generate_synth_checkpoint" -value "0" -objects $file_obj
}
set_property -name "registered_with_manager" -value "1" -objects $file_obj

set file "$origin_dir/src/output_buffer.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/src/clk_divider.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/src/uart_module.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/src/output_uart_sender.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/src/golomb_top.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/hw_tests/HWT_collector.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj
set_property -name "is_enabled" -value "0" -objects $file_obj

set file "$origin_dir/ip/HWT_collector_bram/HWT_collector_bram.xci"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "generate_files_for_reference" -value "0" -objects $file_obj
set_property -name "is_enabled" -value "0" -objects $file_obj
set_property -name "registered_with_manager" -value "1" -objects $file_obj

set file "$origin_dir/ip/HWT_collector_ila/HWT_collector_ila.xci"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "generate_files_for_reference" -value "0" -objects $file_obj
set_property -name "is_enabled" -value "0" -objects $file_obj
set_property -name "registered_with_manager" -value "1" -objects $file_obj

set file "$origin_dir/ip/HWT_collector_clk/HWT_collector_clk.xci"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "generate_files_for_reference" -value "0" -objects $file_obj
set_property -name "is_enabled" -value "0" -objects $file_obj
set_property -name "registered_with_manager" -value "1" -objects $file_obj


# Set 'sources_1' fileset file properties for local files
# None

# Set 'sources_1' fileset properties
set obj [get_filesets sources_1]
set_property -name "dataflow_viewer_settings" -value "min_width=16" -objects $obj
set_property -name "top" -value "JPEG_LS_module_top_impl" -objects $obj
set_property -name "top_auto_set" -value "0" -objects $obj

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
set files [list \
 [file normalize "${origin_dir}/ip/context_modeller_bram/context_modeller_bram.xci"] \
]
add_files -norecurse -fileset $obj $files

# Set 'sources_1' fileset file properties for remote files
set file "$origin_dir/ip/context_modeller_bram/context_modeller_bram.xci"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "generate_files_for_reference" -value "0" -objects $file_obj
set_property -name "registered_with_manager" -value "1" -objects $file_obj
if { ![get_property "is_locked" $file_obj] } {
  set_property -name "synth_checkpoint_mode" -value "Singular" -objects $file_obj
}


# Set 'sources_1' fileset file properties for local files
# None

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
set files [list \
 [file normalize "${origin_dir}/ip/TB_HWT_cam_sim_bram/TB_HWT_cam_sim_bram.xci"] \
]
add_files -norecurse -fileset $obj $files

# Set 'sources_1' fileset file properties for remote files
set file "$origin_dir/ip/TB_HWT_cam_sim_bram/TB_HWT_cam_sim_bram.xci"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "generate_files_for_reference" -value "0" -objects $file_obj
set_property -name "registered_with_manager" -value "1" -objects $file_obj
if { ![get_property "is_locked" $file_obj] } {
  set_property -name "synth_checkpoint_mode" -value "Singular" -objects $file_obj
}


# Set 'sources_1' fileset file properties for local files
# None

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# Empty (no sources present)

# Set 'constrs_1' fileset properties
set obj [get_filesets constrs_1]

# Create 'full_system' fileset (if not found)
if {[string equal [get_filesets -quiet full_system] ""]} {
  create_fileset -constrset full_system
}

# Set 'full_system' fileset object
set obj [get_filesets full_system]

# Add/Import constrs file and set constrs file properties
set file "[file normalize "$origin_dir/constr/timing.xdc"]"
set file_added [add_files -norecurse -fileset $obj [list $file]]
set file "$origin_dir/constr/timing.xdc"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets full_system] [list "*$file"]]
set_property -name "file_type" -value "XDC" -objects $file_obj

# Add/Import constrs file and set constrs file properties
set file "[file normalize "$origin_dir/constr/PYNQ-Z2 v1.0.xdc"]"
set file_added [add_files -norecurse -fileset $obj [list $file]]
set file "$origin_dir/constr/PYNQ-Z2 v1.0.xdc"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets full_system] [list "*$file"]]
set_property -name "file_type" -value "XDC" -objects $file_obj
set_property -name "used_in" -value "implementation" -objects $file_obj
set_property -name "used_in_synthesis" -value "0" -objects $file_obj

# Set 'full_system' fileset properties
set obj [get_filesets full_system]

# Create 'block_constr' fileset (if not found)
if {[string equal [get_filesets -quiet block_constr] ""]} {
  create_fileset -constrset block_constr
}

# Set 'block_constr' fileset object
set obj [get_filesets block_constr]

# Set 'block_constr' fileset properties
set obj [get_filesets block_constr]

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

# Set 'sim_1' fileset object
set obj [get_filesets sim_1]
# Empty (no sources present)

# Set 'sim_1' fileset properties
set obj [get_filesets sim_1]
set_property -name "top" -value "output_uart_sender" -objects $obj
set_property -name "top_arch" -value "Behavioral" -objects $obj
set_property -name "top_file" -value "src/output_uart_sender.vhd" -objects $obj
set_property -name "top_lib" -value "xil_defaultlib" -objects $obj

# Create 'block_tests' fileset (if not found)
if {[string equal [get_filesets -quiet block_tests] ""]} {
  create_fileset -simset block_tests
}

# Set 'block_tests' fileset object
set obj [get_filesets block_tests]
set files [list \
 [file normalize "${origin_dir}/sim/TB_HWT_cam_sim.vhd"] \
 [file normalize "${origin_dir}/src/collector.vhd"] \
 [file normalize "${origin_dir}/src/fixed_predictor.vhd"] \
 [file normalize "${origin_dir}/sim/TB_collector.vhd"] \
 [file normalize "${origin_dir}/sim/TB_fixed_predictor.vhd"] \
 [file normalize "${origin_dir}/sim/TB_golomb_coder.vhd"] \
 [file normalize "${origin_dir}/sim/TB_gradient.vhd"] \
 [file normalize "${origin_dir}/src/TB_output_buffer.vhd"] \
 [file normalize "${origin_dir}/sim/TB_output_uart_sender.vhd"] \
 [file normalize "${origin_dir}/sim/camera_simulator.vhd"] \
 [file normalize "${origin_dir}/sim_cfg/TB_collector_behav.wcfg"] \
 [file normalize "${origin_dir}/sim_cfg/TB_gradient_behav.wcfg"] \
 [file normalize "${origin_dir}/sim_cfg/TB_golomb_coder_behav.wcfg"] \
 [file normalize "${origin_dir}/sim_cfg/TB_context_modeller_behav.wcfg"] \
 [file normalize "${origin_dir}/sim_cfg/TB_HWT_cam_sim_behav.wcfg"] \
 [file normalize "${origin_dir}/sim_cfg/TB_output_buffer_behav.wcfg"] \
 [file normalize "${origin_dir}/sim_cfg/TB_output_uart_sender_behav.wcfg"] \
]
add_files -norecurse -fileset $obj $files

# Set 'block_tests' fileset file properties for remote files
set file "$origin_dir/sim/TB_HWT_cam_sim.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets block_tests] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/src/collector.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets block_tests] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/src/fixed_predictor.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets block_tests] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/sim/TB_collector.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets block_tests] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/sim/TB_fixed_predictor.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets block_tests] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/sim/TB_golomb_coder.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets block_tests] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/sim/TB_gradient.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets block_tests] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/src/TB_output_buffer.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets block_tests] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/sim/TB_output_uart_sender.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets block_tests] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/sim/camera_simulator.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets block_tests] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj


# Set 'block_tests' fileset file properties for local files
# None

# Set 'block_tests' fileset properties
set obj [get_filesets block_tests]
set_property -name "nl.mode" -value "funcsim" -objects $obj
set_property -name "top" -value "TB_HWT_cam_sim" -objects $obj
set_property -name "top_lib" -value "xil_defaultlib" -objects $obj
set_property -name "xsim.simulate.runtime" -value "1ms" -objects $obj

# Create 'full_simulation' fileset (if not found)
if {[string equal [get_filesets -quiet full_simulation] ""]} {
  create_fileset -simset full_simulation
}

# Set 'full_simulation' fileset object
set obj [get_filesets full_simulation]
set files [list \
 [file normalize "${origin_dir}/sim/camera_simulator.vhd"] \
 [file normalize "${origin_dir}/sim/TB_full_sim_impl.vhd"] \
 [file normalize "${origin_dir}/sim/TB_full_sim.vhd"] \
 [file normalize "${origin_dir}/sim/TB_pl_test.vhd"] \
 [file normalize "${origin_dir}/sim_cfg/TB_full_sim_behav.wcfg"] \
 [file normalize "${origin_dir}/sim_cfg/TB_pl_test_func_impl.wcfg"] \
 [file normalize "${origin_dir}/sim_cfg/TB_full_sim_impl_func_synth.wcfg"] \
 [file normalize "${origin_dir}/sim/TB_full_sim_synth.vhd"] \
]
add_files -norecurse -fileset $obj $files

# Set 'full_simulation' fileset file properties for remote files
set file "$origin_dir/sim/camera_simulator.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets full_simulation] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/sim/TB_full_sim_impl.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets full_simulation] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/sim/TB_full_sim.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets full_simulation] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/sim/TB_pl_test.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets full_simulation] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/sim/TB_full_sim_synth.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets full_simulation] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj


# Set 'full_simulation' fileset file properties for local files
# None

# Set 'full_simulation' fileset properties
set obj [get_filesets full_simulation]
set_property -name "nl.mode" -value "funcsim" -objects $obj
set_property -name "sim_mode" -value "post-implementation" -objects $obj
set_property -name "top" -value "TB_full_sim_impl" -objects $obj
set_property -name "top_auto_set" -value "0" -objects $obj
set_property -name "top_lib" -value "xil_defaultlib" -objects $obj

# Create 'block_synth_tests' fileset (if not found)
if {[string equal [get_filesets -quiet block_synth_tests] ""]} {
  create_fileset -simset block_synth_tests
}

# Set 'block_synth_tests' fileset object
set obj [get_filesets block_synth_tests]
set files [list \
 [file normalize "${origin_dir}/sim/TB_golomb_coder_impl.vhd"] \
 [file normalize "${origin_dir}/sim/TB_gradient_impl.vhd"] \
 [file normalize "${origin_dir}/sim/TB_output_buffer_synth.vhd"] \
 [file normalize "${origin_dir}/sim_cfg/TB_output_buffer_synth_func_synth.wcfg"] \
 [file normalize "${origin_dir}/sim/TB_fixed_predictor_impl.vhd"] \
]
add_files -norecurse -fileset $obj $files

# Set 'block_synth_tests' fileset file properties for remote files
set file "$origin_dir/sim/TB_golomb_coder_impl.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets block_synth_tests] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/sim/TB_gradient_impl.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets block_synth_tests] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/sim/TB_output_buffer_synth.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets block_synth_tests] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/sim/TB_fixed_predictor_impl.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets block_synth_tests] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj


# Set 'block_synth_tests' fileset file properties for local files
# None

# Set 'block_synth_tests' fileset properties
set obj [get_filesets block_synth_tests]
set_property -name "nl.mode" -value "funcsim" -objects $obj
set_property -name "sim_mode" -value "post-synthesis" -objects $obj
set_property -name "top" -value "TB_golomb_coder_impl" -objects $obj
set_property -name "top_auto_set" -value "0" -objects $obj
set_property -name "top_lib" -value "xil_defaultlib" -objects $obj

# Adding sources referenced in BDs, if not already added
if { [get_files btn_pulse.vhd] == "" } {
  import_files -quiet -fileset sources_1 "$origin_dir/src/btn_pulse.vhd"
}
if { [get_files HWT_cam_sim_clk.xci] == "" } {
  import_files -quiet -fileset sources_1 "$origin_dir/ip/HWT_cam_sim_clk/HWT_cam_sim_clk.xci"
}
if { [get_files HWT_cam_sim.vhd] == "" } {
  import_files -quiet -fileset sources_1 "$origin_dir/hw_tests/HWT_cam_sim.vhd"
}
if { [get_files debounce.vhd] == "" } {
  import_files -quiet -fileset sources_1 "$origin_dir/src/debounce.vhd"
}
if { [get_files output_buffer_bram.xci] == "" } {
  import_files -quiet -fileset sources_1 "$origin_dir/ip/output_buffer_bram/output_buffer_bram.xci"
}
if { [get_files output_buffer.vhd] == "" } {
  import_files -quiet -fileset sources_1 "$origin_dir/src/output_buffer.vhd"
}
if { [get_files clk_divider.vhd] == "" } {
  import_files -quiet -fileset sources_1 "$origin_dir/src/clk_divider.vhd"
}
if { [get_files uart_module.vhd] == "" } {
  import_files -quiet -fileset sources_1 "$origin_dir/src/uart_module.vhd"
}
if { [get_files output_uart_sender.vhd] == "" } {
  import_files -quiet -fileset sources_1 "$origin_dir/src/output_uart_sender.vhd"
}
if { [get_files context_modeller_bram.xci] == "" } {
  import_files -quiet -fileset sources_1 "$origin_dir/ip/context_modeller_bram/context_modeller_bram.xci"
}
if { [get_files collector_bram.xci] == "" } {
  import_files -quiet -fileset sources_1 "$origin_dir/ip/collector_bram/collector_bram.xci"
}
if { [get_files collector.vhd] == "" } {
  import_files -quiet -fileset sources_1 "$origin_dir/src/collector.vhd"
}
if { [get_files context_modeller.vhd] == "" } {
  import_files -quiet -fileset sources_1 "$origin_dir/src/context_modeller.vhd"
}
if { [get_files context_updater.vhd] == "" } {
  import_files -quiet -fileset sources_1 "$origin_dir/src/context_updater.vhd"
}
if { [get_files error_mapper.vhd] == "" } {
  import_files -quiet -fileset sources_1 "$origin_dir/src/error_mapper.vhd"
}
if { [get_files fixed_predictor.vhd] == "" } {
  import_files -quiet -fileset sources_1 "$origin_dir/src/fixed_predictor.vhd"
}
if { [get_files golomb_coder.vhd] == "" } {
  import_files -quiet -fileset sources_1 "$origin_dir/src/golomb_coder.vhd"
}
if { [get_files gradient.vhd] == "" } {
  import_files -quiet -fileset sources_1 "$origin_dir/src/gradient.vhd"
}
if { [get_files k_calculator.vhd] == "" } {
  import_files -quiet -fileset sources_1 "$origin_dir/src/k_calculator.vhd"
}
if { [get_files pipeline_module_1.vhd] == "" } {
  import_files -quiet -fileset sources_1 "$origin_dir/src/pipeline_module_1.vhd"
}
if { [get_files pipeline_module_3.vhd] == "" } {
  import_files -quiet -fileset sources_1 "$origin_dir/src/pipeline_module_3.vhd"
}
if { [get_files pipeline_module_4.vhd] == "" } {
  import_files -quiet -fileset sources_1 "$origin_dir/src/pipeline_module_4.vhd"
}
if { [get_files prediction_adder.vhd] == "" } {
  import_files -quiet -fileset sources_1 "$origin_dir/src/prediction_adder.vhd"
}
if { [get_files JPEG_LS_module.vhd] == "" } {
  import_files -quiet -fileset sources_1 "$origin_dir/src/JPEG_LS_module.vhd"
}


# Proc to create BD BD_pl_test
proc cr_bd_BD_pl_test { parentCell } {
# The design that will be created by this Tcl proc contains the following 
# module references:
# HWT_cam_sim, JPEG_LS_module, btn_pulse, output_buffer, output_uart_sender, debounce



  # CHANGE DESIGN NAME HERE
  set design_name BD_pl_test

  common::send_gid_msg -ssname BD::TCL -id 2010 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

  create_bd_design $design_name

  set bCheckIPsPassed 1
  ##################################################################
  # CHECK IPs
  ##################################################################
  set bCheckIPs 1
  if { $bCheckIPs == 1 } {
     set list_check_ips "\ 
  xilinx.com:ip:blk_mem_gen:8.4\
  xilinx.com:ip:util_vector_logic:2.0\
  "

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

  }

  ##################################################################
  # CHECK Modules
  ##################################################################
  set bCheckModules 1
  if { $bCheckModules == 1 } {
     set list_check_mods "\ 
  HWT_cam_sim\
  JPEG_LS_module\
  btn_pulse\
  output_buffer\
  output_uart_sender\
  debounce\
  "

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

  if { $bCheckIPsPassed != 1 } {
    common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
    return 3
  }

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set LED0 [ create_bd_port -dir O LED0 ]
  set LED1 [ create_bd_port -dir O LED1 ]
  set LED2 [ create_bd_port -dir O LED2 ]
  set LED3 [ create_bd_port -dir O LED3 ]
  set clk [ create_bd_port -dir I -type clk clk ]
  set en [ create_bd_port -dir I -type clk en ]
  set rst [ create_bd_port -dir I rst ]
  set uart_tx [ create_bd_port -dir O uart_tx ]

  # Create instance: HWT_cam_sim_0, and set properties
  set block_name HWT_cam_sim
  set block_cell_name HWT_cam_sim_0
  if { [catch {set HWT_cam_sim_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $HWT_cam_sim_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [list \
    CONFIG.image_height {240} \
    CONFIG.image_width {320} \
  ] $HWT_cam_sim_0


  # Create instance: JPEG_LS_module_0, and set properties
  set block_name JPEG_LS_module
  set block_cell_name JPEG_LS_module_0
  if { [catch {set JPEG_LS_module_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $JPEG_LS_module_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [list \
    CONFIG.image_height {240} \
    CONFIG.image_width {320} \
  ] $JPEG_LS_module_0


  # Create instance: PL_test_cam_rom, and set properties
  set PL_test_cam_rom [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 PL_test_cam_rom ]
  set_property -dict [list \
    CONFIG.Byte_Size {8} \
    CONFIG.Coe_File {/home/andreas/Desktop/ProfileProject/JPEG-LS-HDL/HDL/hw_tests/no_border_low_res.coe} \
    CONFIG.EN_SAFETY_CKT {true} \
    CONFIG.Fill_Remaining_Memory_Locations {true} \
    CONFIG.Load_Init_File {true} \
    CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
    CONFIG.Use_Byte_Write_Enable {true} \
    CONFIG.Use_RSTA_Pin {true} \
    CONFIG.Write_Depth_A {65536} \
    CONFIG.Write_Width_A {32} \
    CONFIG.use_bram_block {Stand_Alone} \
  ] $PL_test_cam_rom


  # Create instance: btn_pulse_0, and set properties
  set block_name btn_pulse
  set block_cell_name btn_pulse_0
  if { [catch {set btn_pulse_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $btn_pulse_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: output_buffer_0, and set properties
  set block_name output_buffer
  set block_cell_name output_buffer_0
  if { [catch {set output_buffer_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $output_buffer_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: output_uart_sender_0, and set properties
  set block_name output_uart_sender
  set block_cell_name output_uart_sender_0
  if { [catch {set output_uart_sender_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $output_uart_sender_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: reset_btn, and set properties
  set block_name debounce
  set block_cell_name reset_btn
  if { [catch {set reset_btn [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $reset_btn eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [list \
    CONFIG.C_OPERATION {not} \
    CONFIG.C_SIZE {1} \
  ] $util_vector_logic_0


  # Create interface connections
  connect_bd_intf_net -intf_net HWT_cam_sim_0_BRAM_interface [get_bd_intf_pins HWT_cam_sim_0/BRAM_interface] [get_bd_intf_pins PL_test_cam_rom/BRAM_PORTA]

  # Create port connections
  connect_bd_net -net HWT_cam_sim_0_href [get_bd_pins HWT_cam_sim_0/href] [get_bd_pins JPEG_LS_module_0/href]
  connect_bd_net -net HWT_cam_sim_0_pclk [get_bd_pins HWT_cam_sim_0/pclk] [get_bd_pins JPEG_LS_module_0/pclk] [get_bd_pins btn_pulse_0/clk] [get_bd_pins output_buffer_0/pclk] [get_bd_pins output_uart_sender_0/pclk]
  connect_bd_net -net HWT_cam_sim_0_pixel [get_bd_pins HWT_cam_sim_0/pixel] [get_bd_pins JPEG_LS_module_0/pixel]
  connect_bd_net -net HWT_cam_sim_0_vsync [get_bd_pins HWT_cam_sim_0/vsync] [get_bd_pins JPEG_LS_module_0/vsync]
  connect_bd_net -net JPEG_LS_module_0_encoded_b [get_bd_pins output_buffer_0/encoded_b]
  connect_bd_net -net JPEG_LS_module_0_encoded_g [get_bd_pins output_buffer_0/encoded_g]
  connect_bd_net -net JPEG_LS_module_0_encoded_r [get_bd_pins output_buffer_0/encoded_r]
  connect_bd_net -net JPEG_LS_module_0_encoded_size_b [get_bd_pins output_buffer_0/encoded_size_b]
  connect_bd_net -net JPEG_LS_module_0_encoded_size_g [get_bd_pins output_buffer_0/encoded_size_g]
  connect_bd_net -net JPEG_LS_module_0_encoded_size_r [get_bd_pins output_buffer_0/encoded_size_r]
  connect_bd_net -net JPEG_LS_module_0_new_pixel [get_bd_pins JPEG_LS_module_0/new_pixel] [get_bd_pins output_buffer_0/new_pixel]
  connect_bd_net -net JPEG_LS_module_0_valid_data [get_bd_pins JPEG_LS_module_0/valid_data] [get_bd_pins output_buffer_0/valid_data]
  connect_bd_net -net axi_gpio_0_gpio2_io_o [get_bd_pins HWT_cam_sim_0/resetn] [get_bd_pins JPEG_LS_module_0/resetn] [get_bd_pins output_buffer_0/resetn] [get_bd_pins output_uart_sender_0/resetn] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net btn_pulse_0_out1 [get_bd_pins HWT_cam_sim_0/enable] [get_bd_pins btn_pulse_0/out1]
  connect_bd_net -net clk_0_1 [get_bd_ports clk] [get_bd_pins HWT_cam_sim_0/clk] [get_bd_pins output_uart_sender_0/clk] [get_bd_pins reset_btn/clk]
  connect_bd_net -net en_1 [get_bd_ports en] [get_bd_pins btn_pulse_0/in1]
  connect_bd_net -net output_buffer_0_dout [get_bd_pins output_buffer_0/dout] [get_bd_pins output_uart_sender_0/dout]
  connect_bd_net -net output_buffer_0_end_of_data [get_bd_ports LED0] [get_bd_pins output_buffer_0/end_of_data] [get_bd_pins output_uart_sender_0/end_of_data]
  connect_bd_net -net output_buffer_0_new_data_ready [get_bd_ports LED3] [get_bd_pins output_buffer_0/new_data_ready] [get_bd_pins output_uart_sender_0/new_data_ready]
  connect_bd_net -net output_buffer_0_read_allowed [get_bd_ports LED1] [get_bd_pins output_buffer_0/read_allowed] [get_bd_pins output_uart_sender_0/read_allowed]
  connect_bd_net -net output_uart_sender_0_request_next [get_bd_ports LED2] [get_bd_pins output_buffer_0/request_next] [get_bd_pins output_uart_sender_0/request_next]
  connect_bd_net -net output_uart_sender_0_sig [get_bd_ports uart_tx] [get_bd_pins output_uart_sender_0/sig]
  connect_bd_net -net reset_btn_sig_out [get_bd_pins reset_btn/sig_out] [get_bd_pins util_vector_logic_0/Op1]
  connect_bd_net -net sig_in_0_1 [get_bd_ports rst] [get_bd_pins reset_btn/sig_in]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
  close_bd_design $design_name 
}
# End of cr_bd_BD_pl_test()
cr_bd_BD_pl_test ""
set_property REGISTERED_WITH_MANAGER "1" [get_files BD_pl_test.bd ] 
set_property SYNTH_CHECKPOINT_MODE "Hierarchical" [get_files BD_pl_test.bd ] 


# Create wrapper file for BD_pl_test.bd
make_wrapper -files [get_files BD_pl_test.bd] -import -top

set idrFlowPropertiesConstraints ""
catch {
 set idrFlowPropertiesConstraints [get_param runs.disableIDRFlowPropertyConstraints]
 set_param runs.disableIDRFlowPropertyConstraints 1
}

# Create 'synth_1' run (if not found)
if {[string equal [get_runs -quiet synth_1] ""]} {
    create_run -name synth_1 -part xc7z020clg400-1 -flow {Vivado Synthesis 2022} -strategy "Vivado Synthesis Defaults" -report_strategy {No Reports} -constrset block_constr
} else {
  set_property strategy "Vivado Synthesis Defaults" [get_runs synth_1]
  set_property flow "Vivado Synthesis 2022" [get_runs synth_1]
}
set obj [get_runs synth_1]
set_property set_report_strategy_name 1 $obj
set_property report_strategy {Vivado Synthesis Default Reports} $obj
set_property set_report_strategy_name 0 $obj
# Create 'synth_1_synth_report_utilization_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs synth_1] synth_1_synth_report_utilization_0] "" ] } {
  create_report_config -report_name synth_1_synth_report_utilization_0 -report_type report_utilization:1.0 -steps synth_design -runs synth_1
}
set obj [get_report_configs -of_objects [get_runs synth_1] synth_1_synth_report_utilization_0]
if { $obj != "" } {

}
set obj [get_runs synth_1]
set_property -name "constrset" -value "block_constr" -objects $obj
set_property -name "auto_incremental_checkpoint" -value "1" -objects $obj
set_property -name "strategy" -value "Vivado Synthesis Defaults" -objects $obj

# set the current synth run
current_run -synthesis [get_runs synth_1]

# Create 'impl_1' run (if not found)
if {[string equal [get_runs -quiet impl_1] ""]} {
    create_run -name impl_1 -part xc7z020clg400-1 -flow {Vivado Implementation 2022} -strategy "Vivado Implementation Defaults" -report_strategy {No Reports} -constrset block_constr -parent_run synth_1
} else {
  set_property strategy "Vivado Implementation Defaults" [get_runs impl_1]
  set_property flow "Vivado Implementation 2022" [get_runs impl_1]
}
set obj [get_runs impl_1]
set_property set_report_strategy_name 1 $obj
set_property report_strategy {Vivado Implementation Default Reports} $obj
set_property set_report_strategy_name 0 $obj
# Create 'impl_1_init_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_init_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_init_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps init_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_init_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj
set_property -name "options.max_paths" -value "10" -objects $obj
set_property -name "options.report_unconstrained" -value "1" -objects $obj

}
# Create 'impl_1_opt_report_drc_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_drc_0] "" ] } {
  create_report_config -report_name impl_1_opt_report_drc_0 -report_type report_drc:1.0 -steps opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_drc_0]
if { $obj != "" } {

}
# Create 'impl_1_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj
set_property -name "options.max_paths" -value "10" -objects $obj
set_property -name "options.report_unconstrained" -value "1" -objects $obj

}
# Create 'impl_1_power_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_power_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_power_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps power_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_power_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj
set_property -name "options.max_paths" -value "10" -objects $obj
set_property -name "options.report_unconstrained" -value "1" -objects $obj

}
# Create 'impl_1_place_report_io_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_io_0] "" ] } {
  create_report_config -report_name impl_1_place_report_io_0 -report_type report_io:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_io_0]
if { $obj != "" } {

}
# Create 'impl_1_place_report_utilization_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_utilization_0] "" ] } {
  create_report_config -report_name impl_1_place_report_utilization_0 -report_type report_utilization:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_utilization_0]
if { $obj != "" } {

}
# Create 'impl_1_place_report_control_sets_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_control_sets_0] "" ] } {
  create_report_config -report_name impl_1_place_report_control_sets_0 -report_type report_control_sets:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_control_sets_0]
if { $obj != "" } {
set_property -name "options.verbose" -value "1" -objects $obj

}
# Create 'impl_1_place_report_incremental_reuse_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_0] "" ] } {
  create_report_config -report_name impl_1_place_report_incremental_reuse_0 -report_type report_incremental_reuse:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_1_place_report_incremental_reuse_1' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_1] "" ] } {
  create_report_config -report_name impl_1_place_report_incremental_reuse_1 -report_type report_incremental_reuse:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_1]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_1_place_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_place_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj
set_property -name "options.max_paths" -value "10" -objects $obj
set_property -name "options.report_unconstrained" -value "1" -objects $obj

}
# Create 'impl_1_post_place_power_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_post_place_power_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_post_place_power_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps post_place_power_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_post_place_power_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj
set_property -name "options.max_paths" -value "10" -objects $obj
set_property -name "options.report_unconstrained" -value "1" -objects $obj

}
# Create 'impl_1_phys_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_phys_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_phys_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps phys_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_phys_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj
set_property -name "options.max_paths" -value "10" -objects $obj
set_property -name "options.report_unconstrained" -value "1" -objects $obj

}
# Create 'impl_1_route_report_drc_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_drc_0] "" ] } {
  create_report_config -report_name impl_1_route_report_drc_0 -report_type report_drc:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_drc_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_methodology_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_methodology_0] "" ] } {
  create_report_config -report_name impl_1_route_report_methodology_0 -report_type report_methodology:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_methodology_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_power_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_power_0] "" ] } {
  create_report_config -report_name impl_1_route_report_power_0 -report_type report_power:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_power_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_route_status_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_route_status_0] "" ] } {
  create_report_config -report_name impl_1_route_report_route_status_0 -report_type report_route_status:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_route_status_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_route_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_timing_summary_0]
if { $obj != "" } {
set_property -name "options.max_paths" -value "10" -objects $obj
set_property -name "options.report_unconstrained" -value "1" -objects $obj

}
# Create 'impl_1_route_report_incremental_reuse_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_incremental_reuse_0] "" ] } {
  create_report_config -report_name impl_1_route_report_incremental_reuse_0 -report_type report_incremental_reuse:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_incremental_reuse_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_clock_utilization_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_clock_utilization_0] "" ] } {
  create_report_config -report_name impl_1_route_report_clock_utilization_0 -report_type report_clock_utilization:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_clock_utilization_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_bus_skew_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_bus_skew_0] "" ] } {
  create_report_config -report_name impl_1_route_report_bus_skew_0 -report_type report_bus_skew:1.1 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_bus_skew_0]
if { $obj != "" } {
set_property -name "options.warn_on_violation" -value "1" -objects $obj

}
# Create 'impl_1_post_route_phys_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_post_route_phys_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps post_route_phys_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "options.max_paths" -value "10" -objects $obj
set_property -name "options.report_unconstrained" -value "1" -objects $obj
set_property -name "options.warn_on_violation" -value "1" -objects $obj

}
# Create 'impl_1_post_route_phys_opt_report_bus_skew_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_bus_skew_0] "" ] } {
  create_report_config -report_name impl_1_post_route_phys_opt_report_bus_skew_0 -report_type report_bus_skew:1.1 -steps post_route_phys_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_bus_skew_0]
if { $obj != "" } {
set_property -name "options.warn_on_violation" -value "1" -objects $obj

}
set obj [get_runs impl_1]
set_property -name "constrset" -value "block_constr" -objects $obj
set_property -name "strategy" -value "Vivado Implementation Defaults" -objects $obj
set_property -name "steps.write_bitstream.args.readback_file" -value "0" -objects $obj
set_property -name "steps.write_bitstream.args.verbose" -value "0" -objects $obj

# set the current impl run
current_run -implementation [get_runs impl_1]
catch {
 if { $idrFlowPropertiesConstraints != {} } {
   set_param runs.disableIDRFlowPropertyConstraints $idrFlowPropertiesConstraints
 }
}

# Change current directory to project folder
cd [file dirname [info script]]

puts "INFO: Project created:${_xil_proj_name_}"
# Create 'drc_1' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "drc_1" ] ] ""]} {
create_dashboard_gadget -name {drc_1} -type drc
}
set obj [get_dashboard_gadgets [ list "drc_1" ] ]
set_property -name "reports" -value "impl_1#impl_1_route_report_drc_0" -objects $obj

# Create 'methodology_1' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "methodology_1" ] ] ""]} {
create_dashboard_gadget -name {methodology_1} -type methodology
}
set obj [get_dashboard_gadgets [ list "methodology_1" ] ]
set_property -name "reports" -value "impl_1#impl_1_route_report_methodology_0" -objects $obj

# Create 'power_1' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "power_1" ] ] ""]} {
create_dashboard_gadget -name {power_1} -type power
}
set obj [get_dashboard_gadgets [ list "power_1" ] ]
set_property -name "reports" -value "impl_1#impl_1_route_report_power_0" -objects $obj

# Create 'timing_1' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "timing_1" ] ] ""]} {
create_dashboard_gadget -name {timing_1} -type timing
}
set obj [get_dashboard_gadgets [ list "timing_1" ] ]
set_property -name "reports" -value "impl_1#impl_1_route_report_timing_summary_0" -objects $obj

# Create 'utilization_1' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "utilization_1" ] ] ""]} {
create_dashboard_gadget -name {utilization_1} -type utilization
}
set obj [get_dashboard_gadgets [ list "utilization_1" ] ]
set_property -name "reports" -value "synth_1#synth_1_synth_report_utilization_0" -objects $obj
set_property -name "run.step" -value "synth_design" -objects $obj
set_property -name "run.type" -value "synthesis" -objects $obj

# Create 'utilization_2' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "utilization_2" ] ] ""]} {
create_dashboard_gadget -name {utilization_2} -type utilization
}
set obj [get_dashboard_gadgets [ list "utilization_2" ] ]
set_property -name "reports" -value "impl_1#impl_1_place_report_utilization_0" -objects $obj

move_dashboard_gadget -name {utilization_1} -row 0 -col 0
move_dashboard_gadget -name {power_1} -row 1 -col 0
move_dashboard_gadget -name {drc_1} -row 2 -col 0
move_dashboard_gadget -name {timing_1} -row 0 -col 1
move_dashboard_gadget -name {utilization_2} -row 1 -col 1
move_dashboard_gadget -name {methodology_1} -row 2 -col 1
