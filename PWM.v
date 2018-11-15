module Counter( // @[:@3.2]
  input         clock, // @[:@4.4]
  output [31:0] io_out // @[:@6.4]
);
  reg [31:0] count; // @[PWM.scala 38:18:@8.4]
  reg [31:0] _RAND_0;
  wire [32:0] _T_10; // @[PWM.scala 41:20:@11.6]
  assign _T_10 = count + 32'h1; // @[PWM.scala 41:20:@11.6]
  assign io_out = count; // @[PWM.scala 39:10:@9.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  count = _RAND_0[31:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    count <= _T_10[31:0];
  end
endmodule
module Counter_1( // @[:@16.2]
  input        clock, // @[:@17.4]
  output [3:0] io_out // @[:@19.4]
);
  reg [3:0] count; // @[PWM.scala 38:18:@21.4]
  reg [31:0] _RAND_0;
  wire [4:0] _T_10; // @[PWM.scala 41:20:@24.6]
  assign _T_10 = count + 4'h1; // @[PWM.scala 41:20:@24.6]
  assign io_out = count; // @[PWM.scala 39:10:@22.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  count = _RAND_0[3:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    count <= _T_10[3:0];
  end
endmodule
module PWM( // @[:@29.2]
  input        clock, // @[:@30.4]
  input        reset, // @[:@31.4]
  input        io_inc_duty, // @[:@32.4]
  input        io_dec_duty, // @[:@32.4]
  output       io_led_clk, // @[:@32.4]
  output       io_led, // @[:@32.4]
  output [3:0] io_duty_counter // @[:@32.4]
);
  wire  Counter_clock; // @[PWM.scala 28:23:@52.4]
  wire [31:0] Counter_io_out; // @[PWM.scala 28:23:@52.4]
  wire  Counter_1_clock; // @[PWM.scala 30:69:@60.4]
  wire [3:0] Counter_1_io_out; // @[PWM.scala 30:69:@60.4]
  reg [4:0] speed; // @[PWM.scala 16:18:@34.4]
  reg [31:0] _RAND_0;
  wire  _T_21; // @[PWM.scala 22:20:@38.4]
  wire [5:0] _T_23; // @[PWM.scala 23:20:@40.6]
  wire [4:0] _T_24; // @[PWM.scala 23:20:@41.6]
  wire  _T_26; // @[PWM.scala 24:26:@45.6]
  wire [5:0] _T_28; // @[PWM.scala 25:20:@47.8]
  wire [5:0] _T_29; // @[PWM.scala 25:20:@48.8]
  wire [4:0] _T_30; // @[PWM.scala 25:20:@49.8]
  wire [4:0] _GEN_0; // @[PWM.scala 24:35:@46.6]
  wire [31:0] _T_31; // @[PWM.scala 28:47:@55.4]
  Counter Counter ( // @[PWM.scala 28:23:@52.4]
    .clock(Counter_clock),
    .io_out(Counter_io_out)
  );
  Counter_1 Counter_1 ( // @[PWM.scala 30:69:@60.4]
    .clock(Counter_1_clock),
    .io_out(Counter_1_io_out)
  );
  assign _T_21 = io_inc_duty == 1'h0; // @[PWM.scala 22:20:@38.4]
  assign _T_23 = speed + 5'h1; // @[PWM.scala 23:20:@40.6]
  assign _T_24 = _T_23[4:0]; // @[PWM.scala 23:20:@41.6]
  assign _T_26 = io_dec_duty == 1'h0; // @[PWM.scala 24:26:@45.6]
  assign _T_28 = speed - 5'h1; // @[PWM.scala 25:20:@47.8]
  assign _T_29 = $unsigned(_T_28); // @[PWM.scala 25:20:@48.8]
  assign _T_30 = _T_29[4:0]; // @[PWM.scala 25:20:@49.8]
  assign _GEN_0 = _T_26 ? _T_30 : speed; // @[PWM.scala 24:35:@46.6]
  assign _T_31 = Counter_io_out >> speed; // @[PWM.scala 28:47:@55.4]
  assign io_led_clk = _T_31[0]; // @[PWM.scala 28:14:@57.4]
  assign io_led = io_duty_counter < 4'h8; // @[PWM.scala 18:10:@37.4]
  assign io_duty_counter = Counter_1_io_out; // @[PWM.scala 30:19:@63.4]
  assign Counter_clock = clock; // @[:@53.4]
  assign Counter_1_clock = io_led_clk; // @[:@61.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  speed = _RAND_0[4:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (_T_21) begin
      speed <= _T_24;
    end else begin
      if (_T_26) begin
        speed <= _T_30;
      end
    end
  end
endmodule
