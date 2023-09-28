/*
    Problem:
    https://acm.sjtu.edu.cn/OnlineJudge/problem?problem_id=1250
 
    任务：掌握组合逻辑，完成一个超前进位加法器。
*/

module CLA(
        input [3:0] p,g,
        input cin,
        output [3:0] c,
        output pm,gm
    );
    assign  c[0]=g[0]|p[0]&cin,
            c[1]=g[1]|p[1]&g[0]|p[1]&p[0]&cin,
            c[2]=g[2]|p[2]&g[1]|p[2]&p[1]&g[0]|p[2]&p[1]&p[0]&cin,
            c[3]=g[3]|p[3]&g[2]|p[3]&p[2]&g[1]|p[3]&p[2]&p[1]&g[0]|p[3]&p[2]&p[1]&p[0]&cin,
            pm=&p,
            gm=g[3]|p[3]&g[2]|p[3]&p[2]&g[1]|p[3]&p[2]&p[1]&g[0];
endmodule

module Add4(
        input [3:0] a,b,
        input cin,
        output [3:0] s,
        output cout,pm,gm
    );
    wire [3:0] p = a^b, g = a&b, c;
    CLA cla(.p(p),.g(g),.cin(cin).c(c),.pm(pm),.gm(gm));
    assign s = p^{c[2:0],cin}, cout = c[3];
endmodule

module Add(
        input       [31:0]          a,
        input       [31:0]          b,
        output reg  [31:0]          sum
    );
    // wire [31:0] c;
    // wire [31:0] s;
    // assign c[0]=0;
    // genvar i;

    // generate
    //     for (i=0;i<=31;i=i+1) begin:add
    //         assign s[i]=a[i]^b[i]^c[i];
    //         if (i<31)
    //             assign c[i+1]=(a[i]&b[i])|((a[i]|b[i])&c[i]);
    //     end
    // endgenerate
    // always @(*) begin
    //     #1 //must have delay!!!
    //      sum=s;
    //     $finish();
    // end



endmodule
