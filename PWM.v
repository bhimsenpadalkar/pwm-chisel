module Counter( // @[:@3.2]
  input        clock, // @[:@4.4]
  input        reset, // @[:@5.4]
  output [3:0] io_out // @[:@6.4]
);
  reg [3:0] count; // @[PWM.scala 49:22:@8.4]
  reg [31:0] _RAND_0;
  wire [4:0] _T_12; // @[PWM.scala 53:30:@15.6]
  wire [3:0] _T_13; // @[PWM.scala 53:30:@16.6]
  wire [3:0] _GEN_0; // @[PWM.scala 51:23:@11.4]
  assign _T_12 = count + 4'h1; // @[PWM.scala 53:30:@15.6]
  assign _T_13 = _T_12[3:0]; // @[PWM.scala 53:30:@16.6]
  assign io_out = count; // @[PWM.scala 50:10:@9.4]
  always @(posedge clock) begin
        count <= _T_13;
  end
endmodule
module PWM( // @[:@20.2]
  input        clock, // @[:@21.4]
  input        reset, // @[:@22.4]
  input        io_inc_duty, // @[:@23.4]
  input        io_dec_duty, // @[:@23.4]
  output       io_led_clk, // @[:@23.4]
  output       io_led, // @[:@23.4]
  output [3:0] io_duty_counter // @[:@23.4]
);
  wire  Counter_clock; // @[PWM.scala 37:30:@30.4]
  wire  Counter_reset; // @[PWM.scala 37:30:@30.4]
  wire [3:0] Counter_io_out; // @[PWM.scala 37:30:@30.4]
  Counter Counter ( // @[PWM.scala 37:30:@30.4]
    .clock(Counter_clock),
    .reset(Counter_reset),
    .io_out(Counter_io_out)
  );
  assign io_led_clk = 1'h1; // @[PWM.scala 41:14:@34.4]
  assign io_led = io_duty_counter < 4'h8; // @[PWM.scala 34:10:@27.4]
  assign io_duty_counter = Counter_io_out; // @[PWM.scala 37:21:@33.4]
  assign Counter_clock = io_inc_duty; // @[:@31.4]
  assign Counter_reset = reset; // @[:@32.4]
endmodule
