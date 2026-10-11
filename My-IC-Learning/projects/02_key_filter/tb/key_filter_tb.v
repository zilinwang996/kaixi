`timescale 1ns / 1ps

module key_filter_tb;

    reg  sys_clk;
    reg  sys_rst_n;
    reg  key_in;
    wire key_flag;

    // 实例化模块
    key_filter u_key_filter (
        .sys_clk   (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in    (key_in),
        .key_flag  (key_flag)
    );

    // 生成时钟 (50MHz, 周期20ns)
    initial begin
        sys_clk = 0;
        forever #10 sys_clk = ~sys_clk;
    end

    // 测试流程
    initial begin
        sys_rst_n = 0;
        key_in    = 1;

        #100 sys_rst_n = 1;   // 释放复位

        #200 key_in = 0;      // 按下（无抖动，先简化）
        #500 key_in = 1;      // 松开

        #50_000 $stop;        // ? 已修改：等待50_000ns(50us)再结束仿真
    end

endmodule
