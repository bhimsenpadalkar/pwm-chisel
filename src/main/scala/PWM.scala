import chisel3._
import chisel3.core.withClock

class PWM extends Module{

  val io = IO(new Bundle {
    val inc_duty = Input(UInt(1.W))
    val dec_duty = Input(UInt(1.W))
    val led_clk = Output(UInt(1.W))
    val led = Output(UInt(1.W))
    val duty_counter = Output(UInt(4.W))
  })

  val duty: UInt = 8.U

  val speed = Reg(UInt(5.W))

  io.led := Mux(io.duty_counter < duty, 1.U, 0.U)

//  speed := withClock(io.inc_duty.toBool().asClock()){Module(new Counter(5)).io.out}

  when(io.inc_duty === 0.U) {
    speed := speed - 1.U
  }.elsewhen(io.dec_duty === 0.U) {
    speed := speed + 1.U
  }

  io.led_clk := Module(new Counter(32)).io.out(speed.asUInt())

  io.duty_counter := withClock(io.led_clk.toBool().asClock()){Module(new Counter(4)).io.out}
}

class Counter(n: Int) extends Module {
  val io = IO(new Bundle{
    val out = Output(UInt(n.W))
  })

  val count = Reg(UInt(n.W))
  io.out := count
  when(true.B){
    count := count + 1.U
  }
}

object PWM extends App {
  chisel3.Driver.execute(args, () => new PWM)
}