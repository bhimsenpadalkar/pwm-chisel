;buildInfoPackage: chisel3, version: 3.1.3, scalaVersion: 2.11.12, sbtVersion: 1.1.1, builtAtString: 2018-09-12 19:37:29.007, builtAtMillis: 1536781049007
circuit PWM : 
  module Counter : 
    input clock : Clock
    input reset : UInt<1>
    output io : {out : UInt<4>}
    
    reg count : UInt<4>, clock with : (reset => (reset, UInt<4>("h00"))) @[PWM.scala 28:22]
    io.out <= count @[PWM.scala 29:10]
    when UInt<1>("h01") : @[PWM.scala 30:15]
      node _T_11 = add(count, UInt<1>("h01")) @[PWM.scala 31:20]
      node _T_12 = tail(_T_11, 1) @[PWM.scala 31:20]
      count <= _T_12 @[PWM.scala 31:11]
      skip @[PWM.scala 30:15]
    
  module Counter_1 : 
    input clock : Clock
    input reset : UInt<1>
    output io : {out : UInt<32>}
    
    reg count : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[PWM.scala 28:22]
    io.out <= count @[PWM.scala 29:10]
    when UInt<1>("h01") : @[PWM.scala 30:15]
      node _T_11 = add(count, UInt<1>("h01")) @[PWM.scala 31:20]
      node _T_12 = tail(_T_11, 1) @[PWM.scala 31:20]
      count <= _T_12 @[PWM.scala 31:11]
      skip @[PWM.scala 30:15]
    
  module PWM : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip inc_duty : UInt<1>, flip dec_duty : UInt<1>, led_clk : UInt<1>, led : UInt<1>, duty_counter : UInt<4>}
    
    node _T_15 = lt(io.duty_counter, UInt<4>("h08")) @[PWM.scala 16:33]
    node _T_18 = mux(_T_15, UInt<1>("h01"), UInt<1>("h00")) @[PWM.scala 16:16]
    io.led <= _T_18 @[PWM.scala 16:10]
    node _T_19 = bits(io.led_clk, 0, 0) @[PWM.scala 18:49]
    node _T_20 = asClock(_T_19) @[PWM.scala 18:59]
    inst Counter of Counter @[PWM.scala 18:69]
    Counter.clock <= _T_20
    Counter.reset <= reset
    io.duty_counter <= Counter.io.out @[PWM.scala 18:19]
    inst Counter_1 of Counter_1 @[PWM.scala 20:23]
    Counter_1.clock <= clock
    Counter_1.reset <= reset
    node _T_21 = bits(Counter_1.io.out, 25, 25) @[PWM.scala 20:47]
    io.led_clk <= _T_21 @[PWM.scala 20:14]
    
