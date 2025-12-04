set_property -name {xsim.simulate.log_all_signals} -value {true} \
  -objects [get_filesets sim_1]
# Simulation shortcut commands
proc tc {f} { set_property top $f [get_filesets sim_1]
              set_property top_lib xil_defaultlib [get_filesets sim_1]
            }
proc cc {f} { close_sim
              set_property top $f [get_filesets sim_1]
              set_property top_lib xil_defaultlib [get_filesets sim_1]
              launch_sim
            }
proc l  {} {launch_simulation}
proc c  {} {relaunch_sim}
proc cr {} {relaunch_sim; run all}
proc r  {} {restart; run all}
proc rr {} {restart}
proc reload {}       { source -notrace ~/.tcl }
# Call the build script from the GUI.
proc build  {args} {
  # clear the global arguments...
  set argc 0; set argv ""
  # Add all input arguments to global list...
  foreach x $args { lappend argv $x; set argc [expr $argc + 1] }
  # run build_bitstream
  source -notrace ../../../build_bitstream.tcl
  # clear global arguments
  set argc 0; set argv ""
}
