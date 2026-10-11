module key_filter (
    input        sys_clk,
    input        sys_rst_n,
    input        key_in,
    output reg   key_flag
);

    // 参数：20ms 计数最大值（假设 50MHz 时钟）
    parameter CNT_MAX = 20'd999_999;

    reg        stable_key;
    reg [19:0] cnt;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            stable_key <= 1'b1;
            key_flag   <= 1'b0;
            cnt        <= 20'd0;
        end
        else if (key_in != stable_key) begin
            cnt <= 20'd0;
        end
        else if (cnt == CNT_MAX) begin
            stable_key <= key_in;
            key_flag   <= 1'b1;
        end
        else begin
            cnt <= cnt + 1'b1;
            key_flag <= 1'b0;
        end
    end

endmodule