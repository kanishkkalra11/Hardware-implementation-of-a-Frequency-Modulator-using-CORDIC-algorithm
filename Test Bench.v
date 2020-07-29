`timescale 1ns / 1ps

module CORDIC_tb();

parameter bits = 16;
reg clock, reset;
wire [bits-1:0] wave, ledsine;

CORDIC uut(reset, clock, ledsine, wave);

initial
begin
    clock = 0;
    reset = 1;
end

always #0.1 clock = !clock;

endmodule