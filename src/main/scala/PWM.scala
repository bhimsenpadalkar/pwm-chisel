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

  io.led := Mux(io.duty_counter < duty, 1.U, 0.U)

  io.duty_counter := withClock(io.led_clk.toBool().asClock()){Module(new Counter(4)).io.out}

  io.led_clk := Module(new Counter(32)).io.out(25)
}

class Counter(n: Int) extends Module {
  val io = IO(new Bundle{
    val out = Output(UInt(n.W))
  })

  val count = RegInit(0.U(n.W))
  io.out := count
  when(true.B){
    count := count + 1.U
  }
}

object PWM extends App {
  chisel3.Driver.execute(args, () => new PWM)
}