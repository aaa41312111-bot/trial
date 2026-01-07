// 4-bit Up Counter with load and reset
module counter_4bit (
    input clk,          // Clock
    input rstn,         // Active-low reset
    input load,         // Load enable
    input [3:0] data,   // Data to load
    output reg [3:0] count  // Counter output
);
    always @(posedge clk or negedge rstn) begin
        if (!rstn)
            count <= 4'b0000;
        else if (load)
            count <= data;
        else
            count <= count + 1;
    end
endmodule
