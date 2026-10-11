module led_flow(
    input clk,
    input rst,
    output reg [7:0] led
);

    reg [24:0] cnt;

    always @(posedge clk)
    begin
        if (rst == 1)
        begin
            cnt <= 0;
            led <= 8'b0000_0001;
        end
        else
        begin
            if (cnt == 25'd99)
            begin
                cnt <= 0;
                led <= {led[6:0], led[7]};
            end
            else
                cnt <= cnt + 1;
        end
    end

endmodule