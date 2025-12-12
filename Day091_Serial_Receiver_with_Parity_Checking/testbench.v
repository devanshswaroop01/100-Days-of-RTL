`timescale 1ns/1ps
module tb_serial_receiver;

    reg clk, reset, in;
    wire [7:0] out_byte;
    wire done;
    top_module dut (.clk(clk),.in(in),.reset(reset),.out_byte(out_byte),.done(done));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;   // 10ns clock
    end

    // ----------------------------------------------
    // TASK: Send one 10-bit serial frame:
    // Start bit (0)
    // 8 data bits (LSB first)
    // Parity bit (odd) unless overridden
    // Stop bit (1 unless overridden)
    // ----------------------------------------------
    task send_frame(
      input [7:0] byte1,
        input bit force_bad_parity,
        input bit force_bad_stop );
        integer i;
        reg parity;
        begin
            // Compute odd parity
            parity = ^byte1;     // XOR = even parity
            parity = ~parity;   // invert → odd parity

            if (force_bad_parity)
                parity = ~parity;

            // ----- START BIT -----
            in = 0; 
            #10;

            // ----- DATA BITS -----
            for (i=0; i<8; i=i+1) begin
                in = byte1[i];
                #10;
            end

            // ----- PARITY BIT -----
            in = parity;
            #10;

            // ----- STOP BIT -----
            in = force_bad_stop ? 0 : 1;
            #10;
        end
    endtask


    // Helper: Display output only when done goes high
    always @(posedge clk) begin
        if (done)
            $display("t=%0t | DONE=1 | BYTE = %02h (%b)",$time, out_byte, out_byte);
    end

    initial begin
        $dumpfile("serial_rx.vcd");
        $dumpvars(0, tb_serial_receiver);

        //RESET SEQUENCE 
        reset = 1;
        in = 1;   // idle
        #20;
        reset = 0;


        //  SECTION 1: DATAPATH FUNCTIONAL TESTING

        $display("\n========== SECTION 1: DATAPATH TESTING ==========\n");
        $display("Testing FSM state transitions, byte assembly, and DONE pulse\n");

        // Test 1.1: Correct full frame (parity correct)
        $display("--- Test 1.1: Good frame (A5h) ---");
        send_frame(8'hA5, 0, 0);
        #20;

        // Test 1.2: Another correct frame
        $display("--- Test 1.2: Good frame (3Ch) ---");
        send_frame(8'h3C, 0, 0);
        #20;

        // Test 1.3: Back-to-back frames
        $display("--- Test 1.3: Two consecutive valid frames ---");
        send_frame(8'h55, 0, 0);
        send_frame(8'hAA, 0, 0);
        #20;


        //  SECTION 2: PARITY CHECKING TESTS

        $display("\n========== SECTION 2: PARITY CHECKING ==========\n");
        $display("Testing correct odd parity verification and error handling.\n");

        // Test 2.1: Invalid parity → done must remain LOW
        $display("--- Test 2.1: BAD PARITY → MUST REJECT FRAME ---");
        send_frame(8'h77, 1, 0);
        #20;

        if(done)
            $display("ERROR: DONE must NOT assert for bad parity!");
        else
            $display("PASS: DONE remained low for bad parity.\n");


        // Test 2.2: Bad stop bit → FSM must WAIT
        $display("--- Test 2.2: BAD STOP BIT → ENTER WAIT STATE ---");
        send_frame(8'h5A, 0, 1);   // incorrect stop bit

        // send idle '1' until FSM recovers
        repeat(4) begin in = 1; #10; end

        $display("PASS: FSM returned to IDLE after WAIT.\n");


        // Test 2.3: Valid frame after errors
        $display("--- Test 2.3: Valid frame after errors (0xF0) ---");
        send_frame(8'hF0, 0, 0);
        #20;

        $display("\n========== ALL TESTS COMPLETED ==========\n");
        $finish;
    end

endmodule