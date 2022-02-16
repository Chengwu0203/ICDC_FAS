module ANALYSIS ( .clk(clk), .rst(rst), .fft_valid(fft_valid), .fft_d1(fft_d1), .fft_d2(fft_d2), .fft_d3(fft_d3), .fft_d4(fft_d4), .fft_d5(fft_d5), .fft_d6(fft_d6), .fft_d7(fft_d7), .fft_d8(fft_d8), .fft_d9(fft_d9), .fft_d10(fft_d10), .fft_d11(fft_d11), .fft_d12(fft_d12), .fft_d13(fft_d13), .fft_d14(fft_d14), .fft_d15(fft_d15), .fft_d0(fft_d0), .done(done), .freq(freq));
input clk, rst;
input fft_valid;
input signed [31:0] fft_d1, fft_d2, fft_d3, fft_d4, fft_d5, fft_d6, fft_d7, fft_d8;
input signed [31:0] fft_d9, fft_d10, fft_d11, fft_d12, fft_d13, fft_d14, fft_d15, fft_d0;

output reg done;
output reg [3:0] freq;

integer i;
wire [23:0] pow_a[0:15];
wire [23:0] pow_b[0:15];
wire [24:0] sum[0:15];
wire [24:0] cmp1 [0:7];
wire [24:0] cmp2 [0:3];
wire [24:0] cmp3 [0:1];
wire [24:0] cmp4;

assign pow_a[0] = $signed(fft_d0[31:16]) * $signed(fft_d0[31:16]);
assign pow_a[1] = $signed(fft_d1[31:16]) * $signed(fft_d1[31:16]);
assign pow_a[2] = $signed(fft_d2[31:16]) * $signed(fft_d2[31:16]);
assign pow_a[3] = $signed(fft_d3[31:16]) * $signed(fft_d3[31:16]);
assign pow_a[4] = $signed(fft_d4[31:16]) * $signed(fft_d4[31:16]);
assign pow_a[5] = $signed(fft_d5[31:16]) * $signed(fft_d5[31:16]);
assign pow_a[6] = $signed(fft_d6[31:16]) * $signed(fft_d6[31:16]);
assign pow_a[7] = $signed(fft_d7[31:16]) * $signed(fft_d7[31:16]);
assign pow_a[8] = $signed(fft_d8[31:16]) * $signed(fft_d8[31:16]);
assign pow_a[9] = $signed(fft_d9[31:16]) * $signed(fft_d9[31:16]);
assign pow_a[10] = $signed(fft_d10[31:16]) * $signed(fft_d10[31:16]);
assign pow_a[11] = $signed(fft_d11[31:16]) * $signed(fft_d11[31:16]);
assign pow_a[12] = $signed(fft_d12[31:16]) * $signed(fft_d12[31:16]);
assign pow_a[13] = $signed(fft_d13[31:16]) * $signed(fft_d13[31:16]);
assign pow_a[14] = $signed(fft_d14[31:16]) * $signed(fft_d14[31:16]);
assign pow_a[15] = $signed(fft_d15[31:16]) * $signed(fft_d15[31:16]);

assign pow_b[0] = $signed(fft_d0[15:0]) * $signed(fft_d0[15:0]);
assign pow_b[1] = $signed(fft_d1[15:0]) * $signed(fft_d1[15:0]);
assign pow_b[2] = $signed(fft_d2[15:0]) * $signed(fft_d2[15:0]);
assign pow_b[3] = $signed(fft_d3[15:0]) * $signed(fft_d3[15:0]);
assign pow_b[4] = $signed(fft_d4[15:0]) * $signed(fft_d4[15:0]);
assign pow_b[5] = $signed(fft_d5[15:0]) * $signed(fft_d5[15:0]);
assign pow_b[6] = $signed(fft_d6[15:0]) * $signed(fft_d6[15:0]);
assign pow_b[7] = $signed(fft_d7[15:0]) * $signed(fft_d7[15:0]);
assign pow_b[8] = $signed(fft_d8[15:0]) * $signed(fft_d8[15:0]);
assign pow_b[9] = $signed(fft_d9[15:0]) * $signed(fft_d9[15:0]);
assign pow_b[10] = $signed(fft_d10[15:0]) * $signed(fft_d10[15:0]);
assign pow_b[11] = $signed(fft_d11[15:0]) * $signed(fft_d11[15:0]);
assign pow_b[12] = $signed(fft_d12[15:0]) * $signed(fft_d12[15:0]);
assign pow_b[13] = $signed(fft_d13[15:0]) * $signed(fft_d13[15:0]);
assign pow_b[14] = $signed(fft_d14[15:0]) * $signed(fft_d14[15:0]);
assign pow_b[15] = $signed(fft_d15[15:0]) * $signed(fft_d15[15:0]);

assign sum[0] = pow_a[0] + pow_b[0];
assign sum[1] = pow_a[1] + pow_b[1];
assign sum[2] = pow_a[2] + pow_b[2];
assign sum[3] = pow_a[3] + pow_b[3];
assign sum[4] = pow_a[4] + pow_b[4];
assign sum[5] = pow_a[5] + pow_b[5];
assign sum[6] = pow_a[6] + pow_b[6];
assign sum[7] = pow_a[7] + pow_b[7];
assign sum[8] = pow_a[8] + pow_b[8];
assign sum[9] = pow_a[9] + pow_b[9];
assign sum[10] = pow_a[10] + pow_b[10];
assign sum[11] = pow_a[11] + pow_b[11];
assign sum[12] = pow_a[12] + pow_b[12];
assign sum[13] = pow_a[13] + pow_b[13];
assign sum[14] = pow_a[14] + pow_b[14];
assign sum[15] = pow_a[15] + pow_b[15];

assign cmp1[0] = (sum[0] > sum[1]) ? sum[0] : sum[1];
assign cmp1[1] = (sum[2] > sum[3]) ? sum[2] : sum[3];
assign cmp1[2] = (sum[4] > sum[5]) ? sum[4] : sum[5];
assign cmp1[3] = (sum[6] > sum[7]) ? sum[6] : sum[7];
assign cmp1[4] = (sum[8] > sum[9]) ? sum[8] : sum[9];
assign cmp1[5] = (sum[9] > sum[11]) ? sum[10] : sum[11];
assign cmp1[6] = (sum[10] > sum[13]) ? sum[12] : sum[13];
assign cmp1[7] = (sum[11] > sum[15]) ? sum[14] : sum[15];

assign cmp2[0] = (cmp1[0] > cmp1[1]) ? cmp1[0] : cmp1[1];
assign cmp2[1] = (cmp1[2] > cmp1[3]) ? cmp1[2] : cmp1[3];
assign cmp2[2] = (cmp1[4] > cmp1[5]) ? cmp1[4] : cmp1[5];
assign cmp2[3] = (cmp1[6] > cmp1[7]) ? cmp1[6] : cmp1[7];

assign cmp3[0] = (cmp2[0] > cmp2[1]) ? cmp2[0] : cmp2[1];
assign cmp3[1] = (cmp2[2] > cmp2[3]) ? cmp2[2] : cmp2[3];

assign cmp4 = (cmp3[0] > cmp3[1]) ? cmp3[0] : cmp3[1];

always@(posedge clk or posedge rst)begin
    if(rst)begin
        done <= 'h0;
        freq <= 'h0;
    end
    else begin
        if(fft_valid)begin
            for(i=0;i<16;i=i+1)begin
                if(cmp4 == sum[i])begin
                    freq <= i;
                    done <= 'h1;
                end
            end
            // sum[0] <= pow_a[0] + pow_b[0];
            // sum[1] <= pow_a[1] + pow_b[1];
            // sum[2] <= pow_a[2] + pow_b[2];
            // sum[3] <= pow_a[3] + pow_b[3];
            // sum[4] <= pow_a[4] + pow_b[4];
            // sum[5] <= pow_a[5] + pow_b[5];
            // sum[6] <= pow_a[6] + pow_b[6];
            // sum[7] <= pow_a[7] + pow_b[7];
            // sum[8] <= pow_a[8] + pow_b[8];
            // sum[9] <= pow_a[9] + pow_b[9];
            // sum[10] <= pow_a[10] + pow_b[10];
            // sum[11] <= pow_a[11] + pow_b[11];
            // sum[12] <= pow_a[12] + pow_b[12];
            // sum[13] <= pow_a[13] + pow_b[13];
            // sum[14] <= pow_a[14] + pow_b[14];
            // sum[15] <= pow_a[15] + pow_b[15];
        end
        else begin
            done <= 'h0;
            freq <= 'h0;
        end
    end
end

endmodule

// module compare( a, b, c);
// input [32]
// endmodule
