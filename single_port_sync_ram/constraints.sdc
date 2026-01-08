# Basic SDC Constraints Template
# Clock definition
create_clock -name clk -period 10.0 [get_ports clk]

# Clock uncertainty
set_clock_uncertainty 0.5 [get_clocks clk]

# Input delays (relative to clock)
set_input_delay -clock clk -max 2.0 [all_inputs]
set_input_delay -clock clk -min 0.5 [all_inputs]

# Output delays (relative to clock)
set_output_delay -clock clk -max 2.0 [all_outputs]
set_output_delay -clock clk -min 0.5 [all_outputs]

# False paths (if any)
# set_false_path -from [get_ports reset]

# Multicycle paths (if any)
# set_multicycle_path 2 -from [get_pins reg1/*] -to [get_pins reg2/*]
