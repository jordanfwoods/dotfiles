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

set_property -name {xsim.simulate.log_all_signals} -value {true} \
  -objects [get_filesets sim_1]
