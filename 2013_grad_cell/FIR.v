module FIR( clk, rst, data_valid, data,fir_valid, fir_d);
input clk, rst;
input data_valid;
input [15:0] data;

output reg fir_valid;
output [15:0] fir_d;

reg [6:0] cnt;
reg signed[15:0] x [31:0];
wire signed [35:0] tmp;
integer i;
`include "./dat/FIR_coefficient.dat"

assign tmp = ( x[0]+x[31])*FIR_C00 + ( x[1]+x[30])*FIR_C01 + ( x[2]+x[29])*FIR_C02 + ( x[3]+x[28])*FIR_C03 + ( x[4]+x[27])*FIR_C04
           + ( x[5]+x[26])*FIR_C05 + ( x[6]+x[25])*FIR_C06 + ( x[7]+x[24])*FIR_C07 + ( x[8]+x[23])*FIR_C08 + ( x[9]+x[22])*FIR_C09
           + (x[10]+x[21])*FIR_C10 + (x[11]+x[20])*FIR_C11 + (x[12]+x[19])*FIR_C12 + (x[13]+x[18])*FIR_C13 + (x[14]+x[17])*FIR_C14
           + (x[15]+x[16])*FIR_C15;

assign fir_d = (tmp >>> 16) + (tmp[35]);

always @(posedge clk or posedge rst)begin
    if(rst)begin
        fir_valid <= 'h0;
        cnt <= 'h0;
        for(i=0;i<32;i=i+1)begin
            x[i] <= 'h0;
        end
    end
    else begin
        if(data_valid)begin
            x[31] <= data;
            for(i=0;i<31;i=i+1)begin
                x[i] <= x[i+1];
            end
            if(cnt == 32)begin
                fir_valid <= 'h1;
                cnt <= 'h0;
            end
            else begin
                cnt <= cnt + 'h1;
            end
        end
    end
end

endmodule
