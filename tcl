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
proc build  {{f -1}} { if {$f > -1} {set argv $f; set argc 1;}
                       source -notrace ../../../build_bitstream.tcl
                       set argc 0; set argv ""; }

set_property -name {xsim.simulate.log_all_signals} -value {true} \
  -objects [get_filesets sim_1]
