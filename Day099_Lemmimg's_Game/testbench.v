`timescale 1ns/1ps
module tb_lemmings;

    reg clk;
    reg areset;
    reg bump_left, bump_right;
    reg ground;
    reg dig;
    wire walk_left, walk_right, aaah, digging;


    top_module dut(
        .clk(clk),
        .areset(areset),
        .bump_left(bump_left),
        .bump_right(bump_right),
        .ground(ground),
        .dig(dig),
        .walk_left(walk_left),
        .walk_right(walk_right),
        .aaah(aaah),
        .digging(digging)
    );

    // Clock generator
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 100MHz equivalent
    end

    // Utility task to print outputs
    task show;
        $display("t=%0t | WL=%0b WR=%0b AA=%0b DIG=%0b | ground=%0b bumpL=%0b bumpR=%0b dig=%0b",
            $time, walk_left, walk_right, aaah, digging,
            ground, bump_left, bump_right, dig);
    endtask


    // MAIN TEST SEQUENCE
    initial begin
        $dumpfile("lemmings.vcd");
        $dumpvars(0, tb_lemmings);

        // 1) RESET → WALK LEFT
        $display("\n===== TEST 1: RESET → LEFT WALK =====");
        areset = 1;
        ground = 1;
        dig = 0;
        bump_left = 0;
        bump_right = 0;
        #10 show();

        areset = 0;
        #10 show();   // Should be walking left


        // 2) WALK LEFT → BUMP LEFT → WALK RIGHT
        $display("\n===== TEST 2: BUMP LEFT → TURN RIGHT =====");
        bump_left = 1;
        #10 show();
        bump_left = 0;
        #10 show();


        // 3) DIGGING
        $display("\n===== TEST 3: DIGGING =====");
        dig = 1;
        #10 show();

        dig = 0;
        #10 show();


        // 4) FALL 20 cycles → SURVIVE
        $display("\n===== TEST 4: FALL 20 CYCLES → SURVIVE =====");
        ground = 0;
        repeat(20) begin
            #10 show();
        end

        // Hit ground again → should return to walking (NO splat)
        ground = 1;
        #10 show();


        // 5) FALL 21 cycles → SPLAT
        $display("\n===== TEST 5: FALL 21 CYCLES → SPLAT =====");
        areset = 1; #10; areset = 0;

        ground = 0;
        repeat(21) begin
            #10 show();
        end

        ground = 1;  // Landing after >20 cycles
        #10 show();  // THIS should be SPLAT (all outputs = 0 forever)

        // Stay more cycles → still splat
        repeat(5) begin
            #10 show();
        end

        $display("\n===== TESTBENCH COMPLETED =====");
        $finish;
    end

endmodule