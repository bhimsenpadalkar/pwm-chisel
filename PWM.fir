;buildInfoPackage: chisel3, version: 3.1.3, scalaVersion: 2.11.12, sbtVersion: 1.1.1, builtAtString: 2018-09-12 19:37:29.007, builtAtMillis: 1536781049007
circuit PWM : 
  module Counter : 
    input clock : Clock
    input reset : UInt<1>
    output io : {out : UInt<32>}
    
    reg count : UInt<32>, clock @[PWM.scala 38:18]
    io.out <= count @[PWM.scala 39:10]
    when UInt<1>("h01") : @[PWM.scala 40:15]
      node _T_10 = add(count, UInt<1>("h01")) @[PWM.scala 41:20]
      node _T_11 = tail(_T_10, 1) @[PWM.scala 41:20]
      count <= _T_11 @[PWM.scala 41:11]
      skip @[PWM.scala 40:15]
    
  module Counter_1 : 
    input clock : Clock
    input reset : UInt<1>
    output io : {out : UInt<4>}
    
    reg count : UInt<4>, clock @[PWM.scala 38:18]
    io.out <= count @[PWM.scala 39:10]
    when UInt<1>("h01") : @[PWM.scala 40:15]
      node _T_10 = add(count, UInt<1>("h01")) @[PWM.scala 41:20]
      node _T_11 = tail(_T_10, 1) @[PWM.scala 41:20]
      count <= _T_11 @[PWM.scala 41:11]
      skip @[PWM.scala 40:15]
    
  module PWM : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip inc_duty : UInt<1>, flip dec_duty : UInt<1>, led_clk : UInt<1>, led : UInt<1>, duty_counter : UInt<4>}
    
    reg speed : UInt<5>, clock @[PWM.scala 16:18]
    node _T_16 = lt(io.duty_counter, UInt<4>("h08")) @[PWM.scala 18:33]
    node _T_19 = mux(_T_16, UInt<1>("h01"), UInt<1>("h00")) @[PWM.scala 18:16]
    io.led <= _T_19 @[PWM.scala 18:10]
    node _T_21 = eq(io.inc_duty, UInt<1>("h00")) @[PWM.scala 22:20]
    when _T_21 : @[PWM.scala 22:29]
      node _T_23 = add(speed, UInt<1>("h01")) @[PWM.scala 23:20]
      node _T_24 = tail(_T_23, 1) @[PWM.scala 23:20]
      speed <= _T_24 @[PWM.scala 23:11]
      skip @[PWM.scala 22:29]
    else : @[PWM.scala 24:35]
      node _T_26 = eq(io.dec_duty, UInt<1>("h00")) @[PWM.scala 24:26]
      when _T_26 : @[PWM.scala 24:35]
        node _T_28 = sub(speed, UInt<1>("h01")) @[PWM.scala 25:20]
        node _T_29 = asUInt(_T_28) @[PWM.scala 25:20]
        node _T_30 = tail(_T_29, 1) @[PWM.scala 25:20]
        speed <= _T_30 @[PWM.scala 25:11]
        skip @[PWM.scala 24:35]
    inst Counter of Counter @[PWM.scala 28:23]
    Counter.clock <= clock
    Counter.reset <= reset
    node _T_31 = dshr(Counter.io.out, speed) @[PWM.scala 28:47]
    node _T_32 = bits(_T_31, 0, 0) @[PWM.scala 28:47]
    io.led_clk <= _T_32 @[PWM.scala 28:14]
    node _T_33 = bits(io.led_clk, 0, 0) @[PWM.scala 30:49]
    node _T_34 = asClock(_T_33) @[PWM.scala 30:59]
    inst Counter_1 of Counter_1 @[PWM.scala 30:69]
    Counter_1.clock <= _T_34
    Counter_1.reset <= reset
    io.duty_counter <= Counter_1.io.out @[PWM.scala 30:19]
    
