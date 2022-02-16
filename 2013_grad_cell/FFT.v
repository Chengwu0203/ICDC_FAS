module FFT( clk, rst, fir_valid, fir_d, fft_valid, fft_d1, fft_d2, fft_d3, fft_d4, fft_d5, fft_d6, fft_d7, fft_d8, fft_d9, fft_d10, fft_d11, fft_d12, fft_d13, fft_d14, fft_d15, fft_d0);
input clk, rst;
input fir_valid;
input [15:0] fir_d;

output reg fft_valid;
output [31:0] fft_d1, fft_d2, fft_d3, fft_d4, fft_d5, fft_d6, fft_d7, fft_d8;
output [31:0] fft_d9, fft_d10, fft_d11, fft_d12, fft_d13, fft_d14, fft_d15, fft_d0;

integer i;
reg [3:0] cnt;
reg [31:0] fir_x[0:15];
wire [31:0] y_t1_re [0:15];
wire [31:0] y_t2_re [0:15];
wire [31:0] y_t3_re [0:15];
wire [32:0] y_t4_re [0:15];
wire [31:0] y_t1_im [0:15];
wire [31:0] y_t2_im [0:15];
wire [31:0] y_t3_im [0:15];
wire [32:0] y_t4_im [0:15];
wire signed [31:0] w_re [0:7];
wire signed [31:0] w_im [0:7];

assign w_re[0] = 32'h00010000;
assign w_re[1] = 32'h0000EC83;
assign w_re[2] = 32'h0000B504;
assign w_re[3] = 32'h000061F7;
assign w_re[4] = 32'h00000000;
assign w_re[5] = 32'hFFFF9E09;
assign w_re[6] = 32'hFFFF4AFC;
assign w_re[7] = 32'hFFFF137D;

assign w_im[0] = 32'h00000000;
assign w_im[1] = 32'hFFFF9E09;
assign w_im[2] = 32'hFFFF4AFC;
assign w_im[3] = 32'hFFFF137D;
assign w_im[4] = 32'hFFFF0000;
assign w_im[5] = 32'hFFFF137D;
assign w_im[6] = 32'hFFFF4AFC;
assign w_im[7] = 32'hFFFF9E09;

// stage 1
genvar j;
generate
    for(j=0;j<8;j=j+1)begin: btf1
        butterfly b0( .clk(clk), .rst(rst), .a(fir_x[j]), .b(0), .c(fir_x[j+8]), .d(0), .wn_re(w_re[j]), .wn_im(w_im[j]), .fft_a_re(y_t1_re[j]), .fft_a_im(y_t1_im[j]), .fft_b_re(y_t1_re[j+8]), .fft_b_im(y_t1_im[j+8]));
    end
endgenerate
// stage 2
generate
    for(j=0;j<4;j=j+1)begin: btf2

        butterfly b0( .clk(clk), .rst(rst), .a(y_t1_re[j]), .b(y_t1_im[j]), .c(y_t1_re[j+4]), .d(y_t1_im[j+4]), .wn_re(w_re[2*j]), .wn_im(w_im[2*j]), .fft_a_re(y_t2_re[j]), .fft_a_im(y_t2_im[j]), .fft_b_re(y_t2_re[j+4]), .fft_b_im(y_t2_im[j+4]));

        butterfly b1( .clk(clk), .rst(rst), .a(y_t1_re[j+8]), .b(y_t1_im[j+8]), .c(y_t1_re[j+12]), .d(y_t1_im[j+12]), .wn_re(w_re[2*j]), .wn_im(w_im[2*j]), .fft_a_re(y_t2_re[j+8]), .fft_a_im(y_t2_im[j+8]), .fft_b_re(y_t2_re[j+12]), .fft_b_im(y_t2_im[j+12]));

    end
endgenerate
// stage 3
generate
    for(j=0;j<2;j=j+1)begin: btf3

        butterfly b0( .clk(clk), .rst(rst), .a(y_t2_re[j]), .b(y_t2_im[j]), .c(y_t2_re[j+2]), .d(y_t2_im[j+2]), .wn_re(w_re[4*j]), .wn_im(w_im[4*j]), .fft_a_re(y_t3_re[j]), .fft_a_im(y_t3_im[j]), .fft_b_re(y_t3_re[j+2]), .fft_b_im(y_t3_im[j+2]));

        butterfly b1( .clk(clk), .rst(rst), .a(y_t2_re[j+4]), .b(y_t2_im[j+4]), .c(y_t2_re[j+6]), .d(y_t2_im[j+6]), .wn_re(w_re[4*j]), .wn_im(w_im[4*j]), .fft_a_re(y_t3_re[j+4]), .fft_a_im(y_t3_im[j+4]), .fft_b_re(y_t3_re[j+6]), .fft_b_im(y_t3_im[j+6]));

        butterfly b2( .clk(clk), .rst(rst), .a(y_t2_re[j+8]), .b(y_t2_im[j+8]), .c(y_t2_re[j+10]), .d(y_t2_im[j+10]), .wn_re(w_re[4*j]), .wn_im(w_im[4*j]), .fft_a_re(y_t3_re[j+8]), .fft_a_im(y_t3_im[j+8]), .fft_b_re(y_t3_re[j+10]), .fft_b_im(y_t3_im[j+10]));

        butterfly b3( .clk(clk), .rst(rst), .a(y_t2_re[j+12]), .b(y_t2_im[j+12]), .c(y_t2_re[j+14]), .d(y_t2_im[j+14]), .wn_re(w_re[4*j]), .wn_im(w_im[4*j]), .fft_a_re(y_t3_re[j+12]), .fft_a_im(y_t3_im[j+12]), .fft_b_re(y_t3_re[j+14]), .fft_b_im(y_t3_im[j+14]));

    end
endgenerate
// stage 4
assign y_t4_re[0] = y_t3_re[0] + y_t3_re[1];
assign y_t4_im[0] = y_t3_im[0] + y_t3_im[1];
assign y_t4_re[1] = y_t3_re[0] - y_t3_re[1];
assign y_t4_im[1] = y_t3_im[0] - y_t3_im[1];

assign y_t4_re[2] = y_t3_re[2] + y_t3_re[3];
assign y_t4_im[2] = y_t3_im[2] + y_t3_im[3];
assign y_t4_re[3] = y_t3_re[2] - y_t3_re[3];
assign y_t4_im[3] = y_t3_im[2] - y_t3_im[3];

assign y_t4_re[4] = y_t3_re[4] + y_t3_re[5];
assign y_t4_im[4] = y_t3_im[4] + y_t3_im[5];
assign y_t4_re[5] = y_t3_re[4] - y_t3_re[5];
assign y_t4_im[5] = y_t3_im[4] - y_t3_im[5];

assign y_t4_re[6] = y_t3_re[6] + y_t3_re[7];
assign y_t4_im[6] = y_t3_im[6] + y_t3_im[7];
assign y_t4_re[7] = y_t3_re[6] - y_t3_re[7];
assign y_t4_im[7] = y_t3_im[6] - y_t3_im[7];

assign y_t4_re[8] = y_t3_re[8] + y_t3_re[9];
assign y_t4_im[8] = y_t3_im[8] + y_t3_im[9];
assign y_t4_re[9] = y_t3_re[8] - y_t3_re[9];
assign y_t4_im[9] = y_t3_im[8] - y_t3_im[9];

assign y_t4_re[10] = y_t3_re[10] + y_t3_re[11];
assign y_t4_im[10] = y_t3_im[10] + y_t3_im[11];
assign y_t4_re[11] = y_t3_re[10] - y_t3_re[11];
assign y_t4_im[11] = y_t3_im[10] - y_t3_im[11];

assign y_t4_re[12] = y_t3_re[12] + y_t3_re[13];
assign y_t4_im[12] = y_t3_im[12] + y_t3_im[13];
assign y_t4_re[13] = y_t3_re[12] - y_t3_re[13];
assign y_t4_im[13] = y_t3_im[12] - y_t3_im[13];

assign y_t4_re[14] = y_t3_re[14] + y_t3_re[15];
assign y_t4_im[14] = y_t3_im[14] + y_t3_im[15];
assign y_t4_re[15] = y_t3_re[14] - y_t3_re[15];
assign y_t4_im[15] = y_t3_im[14] - y_t3_im[15];
// fft output
assign fft_d0  = { y_t4_re[0][23:8], y_t4_im[0][23:8]};
assign fft_d8  = { y_t4_re[1][23:8], y_t4_im[1][23:8]};
assign fft_d4  = { y_t4_re[2][23:8], y_t4_im[2][23:8]};
assign fft_d12 = { y_t4_re[3][23:8], y_t4_im[3][23:8]};
assign fft_d2  = { y_t4_re[4][23:8], y_t4_im[4][23:8]};
assign fft_d10 = { y_t4_re[5][23:8], y_t4_im[5][23:8]};
assign fft_d6  = { y_t4_re[6][23:8], y_t4_im[6][23:8]};
assign fft_d14 = { y_t4_re[7][23:8], y_t4_im[7][23:8]};
assign fft_d1  = { y_t4_re[8][23:8], y_t4_im[8][23:8]};
assign fft_d9  = { y_t4_re[9][23:8], y_t4_im[9][23:8]};
assign fft_d5  = { y_t4_re[10][23:8], y_t4_im[10][23:8]};
assign fft_d13 = { y_t4_re[11][23:8], y_t4_im[11][23:8]};
assign fft_d3  = { y_t4_re[12][23:8], y_t4_im[12][23:8]};
assign fft_d11 = { y_t4_re[13][23:8], y_t4_im[13][23:8]};
assign fft_d7  = { y_t4_re[14][23:8], y_t4_im[14][23:8]};
assign fft_d15 = { y_t4_re[15][23:8], y_t4_im[15][23:8]};
/////////////
always@(posedge clk or posedge rst)begin
    if(rst)begin
        cnt <= 'h0;
        fft_valid <= 1'h0;
        for(i=0;i<16;i=i+1)begin
            fir_x[i] <= 'h0;
        end
    end
    else begin
        if(fir_valid)begin
            fir_x[cnt] <= {{8{fir_d[15]}}, fir_d, 8'h0};
            cnt <= cnt + 'h1;
        end
        if(cnt == 15)begin
            fft_valid <= 1'h1;
        end
        else begin
            fft_valid <= 1'h0;
        end
    end
end

endmodule

module butterfly( clk, rst, a, b, c, d, wn_re, wn_im, fft_a_re, fft_a_im, fft_b_re, fft_b_im);
input clk, rst;
input signed [31:0] a, b, c, d;
input signed [31:0] wn_re, wn_im;

output reg signed [31:0] fft_a_re, fft_a_im, fft_b_re, fft_b_im;

reg signed [32:0] sub_ac, sub_db, sub_bd;
reg signed [64:0] mul_re_1, mul_re_2, mul_im_1, mul_im_2;
reg signed [65:0] tmp_re, tmp_im;

always@(*)begin
fft_a_re <= a + c;
fft_a_im <= b + d;

sub_ac <= a - c;
sub_db <= d - b;
sub_bd <= b - d;

mul_re_1 <= sub_ac * wn_re;
mul_re_2 <= sub_db * wn_im;
tmp_re <= mul_re_1 + mul_re_2;
fft_b_re <= tmp_re >>> 16;

mul_im_1 <= sub_ac * wn_im;
mul_im_2 <= sub_bd * wn_re;
tmp_im <= mul_im_1 + mul_im_2;
fft_b_im <= tmp_im >>> 16;
end

endmodule
