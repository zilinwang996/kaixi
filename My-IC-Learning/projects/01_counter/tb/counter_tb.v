`timescale 1ns / 1ps

module led_flow_tb;

    // 1. 声明信号
    reg clk;
    reg rst;
    wire [7:0] led;

    // 2. 实例化被测模块
    led_flow uut (
        .clk(clk), 
        .rst(rst), 
        .led(led)
    );

    // 3. 产生时钟信号 (周期20ns, 50MHz)
    always #10 clk = ~clk;

    // 4. 产生复位信号和控制仿真结束
    initial begin
        // 初始化
        clk = 0;
        rst = 1;    // 拉高复位
        
        #200;       // 保持复位状态200ns
        
        rst = 0;    // 释放复位
        
        #100000;    // 仿真100us后停止
        $stop;      // 停止仿真
    end

endmodule