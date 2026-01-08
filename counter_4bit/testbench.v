module tb_counter_4bit;
    reg clk, rstn, load;
    reg [3:0] data;
    wire [3:0] count;

    counter_4bit uut (
        .clk(clk),
        .rstn(rstn),
        .load(load),
        .data(data),
        .count(count)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_counter_4bit);

        // Initialize
        clk = 0; rstn = 0; load = 0; data = 4'b0000;
        #10 rstn = 1;  // Release reset

        // Count up
        #100;

        // Load value
        load = 1; data = 4'b1010;
        #10 load = 0;

        // Continue counting
        #100;

        // Test reset
        #10 rstn = 0;
        #10 rstn = 1;

        #50 $display("Test completed");
        $finish;
    end

    initial begin
        $monitor("[%0t] count=0x%0h", $time, count);
    end
endmodule
