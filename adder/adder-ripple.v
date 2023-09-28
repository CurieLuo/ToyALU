/*
    Problem:
    https://acm.sjtu.edu.cn/OnlineJudge/problem?problem_id=1250
 
    任务：掌握组合逻辑，完成一个加法器。
*/

module Add(
        input       [31:0]          a,
        input       [31:0]          b,
        output      [31:0]          sum,
        output carry
    );
    wire [32:0] c;
    assign c[0]=0;

    genvar i;
    generate
        for (i=0;i<=31;i=i+1) begin:add
            assign sum[i]=a[i]^b[i]^c[i],
                c[i+1]=(a[i]&b[i])|((a[i]|b[i])&c[i]);
        end
    endgenerate
    assign carry=c[32];

endmodule