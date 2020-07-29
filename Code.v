`timescale 1ns / 1ps

module CORDIC (reset, clock, ledsine, wave);

parameter bits = 16;
parameter temp = 'b0111110100000000;
input reset, clock;
reg signed [bits-1:0] sine;  //temporary output
output reg [bits-1:0] wave, ledsine;   //pmod output, leds output
parameter ordinate='b0000000000000000;  //
parameter abscissa='b0100101111100101;  //32000/1.647
reg signed [31:0] theta;   //angle
reg [10:0] A;   //register to decrease frequency
initial
begin
    A = 0;
    theta = 'b00000000000000000000000000000000;
end
always @ (posedge clock)
begin
    A = A + 1;
end
reg signed [bits:0]x[0:bits-1];    //vectors
reg signed [bits:0]y[0:bits-1];
reg signed [31:0]z[0:bits-1];
reg [1:0] quadrant;

// Look-up table of tan inverse
wire signed [31:0] taninv[0:30];
assign taninv[00] = 'b00100000000000000000000000000000, // tan inverse(2^0)
    taninv[01] = 'b00010010111001000000010100011101, // tan inverse(2^-1)
    taninv[02] = 'b00001001111110110011100001011011, // tan inverse(2^-2)
    taninv[03] = 'b00000101000100010001000111010100,
    taninv[04] = 'b00000010100010110000110101000011,
    taninv[05] = 'b00000001010001011101011111100001,
    taninv[06] = 'b00000000101000101111011000011110,
    taninv[07] = 'b00000000010100010111110001010101,
    taninv[08] = 'b00000000001010001011111001010011,
    taninv[09] = 'b00000000000101000101111100101110,
    taninv[10] = 'b00000000000010100010111110011000,
    taninv[11] = 'b00000000000001010001011111001100,
    taninv[12] = 'b00000000000000101000101111100110,
    taninv[13] = 'b00000000000000010100010111110011,
    taninv[14] = 'b00000000000000001010001011111001,
    taninv[15] = 'b00000000000000000101000101111100,
    taninv[16] = 'b00000000000000000010100010111110,
    taninv[17] = 'b00000000000000000001010001011111,
    taninv[18] = 'b00000000000000000000101000101111,
    taninv[19] = 'b00000000000000000000010100010111,
    taninv[20] = 'b00000000000000000000001010001011,
    taninv[21] = 'b00000000000000000000000101000101,
    taninv[22] = 'b00000000000000000000000010100010,
    taninv[23] = 'b00000000000000000000000001010001,
    taninv[24] = 'b00000000000000000000000000101000,
    taninv[25] = 'b00000000000000000000000000010100,
    taninv[26] = 'b00000000000000000000000000001010,
    taninv[27] = 'b00000000000000000000000000000101,
    taninv[28] = 'b00000000000000000000000000000010,
    taninv[29] = 'b00000000000000000000000000000001,
    taninv[30] = 'b00000000000000000000000000000000;

// bring all the angles between -90 and +90 deg as cordic algorithm is valid only in that range
always @ (posedge A[10], negedge reset)
begin
    if (!reset)
    begin
        x[0]<=0;
        y[0]<=0;
        z[0]<=0;
    end
    else
    begin
        quadrant = theta[31:30];
        case(quadrant)
            2'b00,  //first quadrant
            2'b11: // fourth quadrant; no changes needed for these quadrants
            begin
                x[0] <= abscissa;
                y[0] <= ordinate;
                z[0] <= theta;
            end
            2'b01:  //second quadrant
            begin
                x[0] <= -ordinate;
                y[0] <= abscissa;
                z[0] <= {2'b00,theta[29:0]}; // subtract pi/2 for angle in this quadrant
            end
            2'b10:   //third quadrant
            begin
                x[0] <= ordinate;
                y[0] <= -abscissa;
                z[0] <= {2'b11,theta[29:0]}; // add pi/2 to angles in this quadrant
            end
        endcase
        theta = theta + 'b00000000101101100001000000000000; //increment angle
    end
end

// generate the stages for 16 iterations, actual sine value computation
genvar i;
generate
for (i=0; i<(bits-1); i=i+1)
begin: hasa_diga_eebowai
    wire zsign;
    wire signed [bits:0] x1, y1;
    assign x1 = x[i] >>> i;
    assign y1 = y[i] >>> i;
    assign zsign = z[i][31]; //sign of current angle rotation
    always @ (posedge A[10], negedge reset)
    begin
        if (!reset)
        begin
            x[i+1]<=0;
            y[i+1]<=0;
            z[i+1]<=0;
        end
        else
        begin
            // add/subtract shifted data(main formulae)
            x[i+1] <= zsign ? x[i] + y1 : x[i] - y1;
            y[i+1] <= zsign ? y[i] - x1 : y[i] + x1;
            z[i+1] <= zsign ? z[i] + taninv[i] : z[i] - taninv[i];
        end
    end
end
endgenerate

//Final outputs and taking care of the glitches
always @ (posedge A[10])
begin
    if (quadrant == 2'b00)
    begin
        sine = y[bits-1];
        if ((sine>16'hdd50) && (sine<16'hffc5))
        begin
            wave = sine[14:0] - 64000 ;
            ledsine = sine[14:0] - 64000 ;
        end
        else
        begin
            wave = sine[14:0] + 32000 ;
            ledsine = sine[14:0] + 32000 ;
        end
    end
    else if (quadrant == 2'b01)
    begin
        sine = y[bits-1];    
        if ((sine<16'h22a3) && (sine>16'h0032))
        begin
            wave = sine[14:0] + 32000 ;
            ledsine = sine[14:0] + 32000 ;
        end
        else
        begin
            wave = sine[14:0] + 32000;
            ledsine = sine[14:0] + 32000;  
        end
    end 
    else if (quadrant == 2'b10)
    begin
        sine = y[bits-1];
        if ((sine<16'h22a3) && (sine>16'h0032))
        begin
            wave = sine[14:0] + 32000 ;
            ledsine = sine[14:0] + 32000 ;
        end
        else
        begin
            wave = sine[14:0];
            ledsine = sine[14:0];    
        end
    end
    else
    begin
        sine = y[bits-1];
        if ((sine>16'hdd50) && (sine<16'hffc5))
        begin
            wave = sine[14:0] - 64000 ;
            ledsine = sine[14:0] - 64000 ;
        end
        else
        begin
            wave = sine[14:0];
            ledsine = sine[14:0];       
        end
    end
end

endmodule