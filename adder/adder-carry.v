/*
    Problem:
    https://acm.sjtu.edu.cn/OnlineJudge/problem?problem_id=1250
 
    任务：掌握组合逻辑，完成一个超前进位加法器。
*/

module CLA(
        input [3:0] p, g, // p: pass on, g: generate
        input cin,
        output [3:0] c,
        output pm, gm
    );
    assign  c[0] = g[0]|p[0]&cin,
            c[1] = g[1]|p[1]&g[0]|p[1]&p[0]&cin,
            c[2] = g[2]|p[2]&g[1]|p[2]&p[1]&g[0]|p[2]&p[1]&p[0]&cin,
            c[3] = g[3]|p[3]&g[2]|p[3]&p[2]&g[1]|p[3]&p[2]&p[1]&g[0]|p[3]&p[2]&p[1]&p[0]&cin,
            pm = &p,
            gm = g[3]|p[3]&g[2]|p[3]&p[2]&g[1]|p[3]&p[2]&p[1]&g[0];
endmodule

module Add4(
        input [3:0] a, b,
        input cin,
        output [3:0] s,
        output cout, pm, gm
    );
    wire [3:0] p , g , c;
    assign p = a^b, g = a&b;
    CLA cla(.p(p), .g(g), .cin(cin), .c(c), .pm(pm), .gm(gm));
    assign s = p^{c[2:0], cin}, cout = c[3];
endmodule

module Add16(
        input [15:0] a, b,
        input cin,
        output [15:0] s,
        output cout
    );
    wire [3:0] p, g, c;
    Add4 add4(.a(a[3:0]), .b(b[3:0]), .cin(cin), .s(s[3:0]), .pm(p[0]), .gm(g[0]));
    Add4 add8(.a(a[7:4]), .b(b[7:4]), .cin(c[0]), .s(s[7:4]), .pm(p[1]), .gm(g[1]));
    Add4 add16(.a(a[11:8]), .b(b[11:8]), .cin(c[1]), .s(s[11:8]), .pm(p[2]), .gm(g[2]));
    Add4 add32(.a(a[15:12]), .b(b[15:12]), .cin(c[2]), .s(s[15:12]), .pm(p[3]), .gm(g[3]));
    CLA cla(.p(p), .g(g), .cin(cin), .c(c));
    assign cout = c[3];
endmodule

module Add(
        input       [31:0]          a,
        input       [31:0]          b,
        output      [31:0]          sum,
        output      carry
    );
    wire c16;
    Add16 add16(.a(a[15:0]), .b(b[15:0]), .cin(1'b0), .s(sum[15:0]), .cout(c16));
    Add16 add32(.a(a[31:16]), .b(b[31:16]), .cin(c16), .s(sum[31:16]),.cout(carry));

endmodule