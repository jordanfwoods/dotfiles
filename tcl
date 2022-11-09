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
proc build  {{f -1} {g -1}} {
  # clear the global arguments...
  set argc 0; set argv ""
  if {[string equal $f "-h"] || [string equal $f "-1"]} {
    # help file usage
    puts "Usage Example:"
    puts "   build \[spw|cl\]\[fm\]00020200\[_##\] \[synth|impl|all\]"
  } else {
    # if both arguments are present, then set add both to argv
    if       {$f > -1 && $g > -1} {lappend argv $f $g; set argc 2
    # if only one argument is present, then just add the one to argv
    } elseif {$f > -1}            {set     argv $f   ; set argc 1}
    # run build_bitstream
    source -notrace ../../../build_bitstream.tcl
    # clear global arguments
    set argc 0; set argv ""
  }
}

set_property -name {xsim.simulate.log_all_signals} -value {true} \
  -objects [get_filesets sim_1]
