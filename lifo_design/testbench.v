`timescale 1ns / 1ps

module lifo_tb;

    // Parameters for the LIFO
    parameter WIDTH = 16;
    parameter DEPTH = 4; // Set a smaller depth for testing

    // Testbench signals
    reg clk;
    reg rst;
    reg push;
    reg pop;
    reg [WIDTH-1:0] data_in;
    wire [WIDTH-1:0] data_out;
    wire empty;
    wire full;

    // Instantiate the LIFO module
    top #(
        .WIDTH(WIDTH),
        .DEPTH(DEPTH)
    ) uut (
        .clk(clk),
        .rst(rst),
        .push(push),
        .pop(pop),
        .data_in(data_in),
        .data_out(data_out),
        .empty(empty),
        .full(full)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    // Test sequence
    initial begin
        // Initialize signals
        rst <= 1;
        push <= 0;
        pop <= 0;
        data_in <= 0;

        // Wait for a few clock cycles
        #10;

        // Release reset
        rst <= 0;
        
      for (integer i = 0; i < 20; i = i + 1) begin
            @(posedge clk);
        	if ($random % 2) begin
        		push <= $random;
              	pop <= 0;
              	data_in <= $random;
            end else begin
        		pop  <= $random;
              	push <= 0;
            end
        
        $display("[%0t] ABC Operation push=%0d pop=%0d data_in=0x%0h empty=%0b full=%0b", $time, push, pop, data_in, empty, full);                        
        end

        #100;
        $finish;
    end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end

endmodule