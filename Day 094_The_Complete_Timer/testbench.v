`timescale 1ns/1ps

module tb_clock_timer;

    reg clk, reset, data, ack;
    wire [3:0] count;
    wire counting, done;
    top_module dut (.clk(clk),.reset(reset),.data(data),.ack(ack),.count(count),.counting(counting),.done(done));

    initial begin
        clk = 0;
        forever #5 clk = ~clk; //10ns clock period
    end


    // TASK: Send one bit into the FSM
    task send_bit(input bit b);
        begin
            data = b;
            #10;   // 1 clock cycle
        end
    endtask

    // ---------------------------------------------------------
    // TASK: Send command sequence S=1101 + 4-bit delay
    // Format:
    //    Prefix: 1 1 0 1
    //    Delay bits: b3 b2 b1 b0  (MSB first)
    // ---------------------------------------------------------
    task send_command(input [3:0] delay_val);
        integer i;
        begin
            $display("\nSending Start Sequence 1101 and delay = %0d", delay_val);

            // S detection: 1 1 0
            send_bit(1);
            send_bit(1);
            send_bit(0);

            // last data to enter B0 (the "1" that triggers B0)
            send_bit(1);

            // Now B0..B3 shift in delay bits MSB→LSB
            for (i=3; i>=0; i=i-1) begin
                send_bit(delay_val[i]);
            end
        end
    endtask

    // ------------------------------------------
    // TASK: Wait until done goes HIGH
    // ------------------------------------------
    task wait_for_done;
        begin
            while (!done) #10;
            $display("DONE asserted at t=%0t, count=%0d", $time, count);
        end
    endtask

    initial begin
        $dumpfile("clock_timer.vcd");
        $dumpvars(0, tb_clock_timer);

        // ---------------- RESET TEST ----------------
        $display("\n========== TEST 0: Reset Behavior ==========");
        reset = 1;
        data  = 1;
        ack   = 0;
        #20;
        reset = 0;
        #20;

        // ---------------- COMMAND TEST 1 ----------------
        // Delay = 4'b0101 = 5 → Timer should run 5000 cycles
        $display("\n========== TEST 1: Delay = 5 ==========");
        send_command(4'b0101);  // Send delay = 5

        // Wait until done
        wait_for_done;

        // Now acknowledge
        ack = 1; #10; ack = 0;

        // ---------------- COMMAND TEST 2 ----------------
        // Delay = 4'b0001 = 1 → Timer runs 1000 cycles
        $display("\n========== TEST 2: Delay = 1 ==========");
        send_command(4'b0001);

        wait_for_done;

        ack = 1; #10; ack = 0;

        // ---------------- COMMAND TEST 3 ----------------
        // Delay = 4'b1111 = 15 → Timer runs 15000 cycles
        $display("\n========== TEST 3: Delay = 15 ==========");
        send_command(4'b1111);

        wait_for_done;

        ack = 1; #10; ack = 0;

        $display("\n========== ALL TESTS PASSED ==========");
        $finish;
    end

endmodule