proc l  {} {launch_simulation}
proc c  {} {relaunch_sim}
proc r  {} {restart; run all}
proc rr {} {restart}

set_property -name {xsim.simulate.log_all_signals} -value {true} \
  -objects [get_filesets sim_1]
