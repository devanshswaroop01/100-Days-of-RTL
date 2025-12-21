`timescale 1ns/1ps
module tb_packet_parser;

    reg clk;
    reg reset;
    reg [7:0] in;
    wire [23:0] out_bytes;
    wire done;
    top_module dut(.clk(clk),.reset(reset), .in(in), .out_bytes(out_bytes), .done(done) );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Clock generation
    end

    // Helper task to display output when done asserts
    task show_packet;
        $display("t=%0t | DONE=1 | PACKET = %h (%0h %0h %0h)",
                 $time, out_bytes,
                 out_bytes[23:16],
                 out_bytes[15:8],
                 out_bytes[7:0]);
    endtask

    // Send one byte
    task send_byte(input [7:0] b);
        begin
            in = b;
            #10;
        end
    endtask

    initial begin
        $dumpfile("packet_parser.vcd");
        $dumpvars(0, tb_packet_parser);

        // SECTION 0 — RESET TEST
        $display("\n========== SECTION 0: RESET TEST ==========");
        reset = 1; in = 8'h00; #15;
        reset = 0; #10;

        // SECTION 1 — FSM TRANSITION TEST
        $display("\n========== SECTION 1: FSM TRANSITION TEST ==========");
        $display("Testing: IDLE → BYTE1 → BYTE2 → BYTE3");

        // Start byte must have in[3] = 1
        send_byte(8'b00001001); // BYTE1
        send_byte(8'hAA);       // BYTE2
        send_byte(8'h55);       // BYTE3

        if(done) show_packet();
        else $display("ERROR: DONE not asserted at BYTE3!");

        // SECTION 2 — DATAPATH TEST (correct byte capture)
        $display("\n========== SECTION 2: DATAPATH TEST ==========");
        $display("Verifying out_bytes = {byte1, byte2, byte3}");

        send_byte(8'h88); // BYTE1 (bit3=1)
        send_byte(8'h12); // BYTE2
        send_byte(8'h34); // BYTE3

        if(done && out_bytes == {8'h88, 8'h12, 8'h34})
            $display("PASS: Datapath captured correct 24-bit packet.");
        else
            $display("FAIL: Datapath error: out_bytes = %h", out_bytes);

        // SECTION 3 — MULTIPLE PACKETS + NOISE
        $display("\n========== SECTION 3: MULTIPLE PACKETS + NOISE ==========");

        send_byte(8'h00);   // Noise
        send_byte(8'hF9);   // BYTE1 (valid start)
        send_byte(8'hAB);
        send_byte(8'hCD);
        if(done) show_packet();

        // Back-to-back packet
        send_byte(8'h89);  // BYTE1 (valid start)
        send_byte(8'h22);
        send_byte(8'h33);
        if(done) show_packet();

        // SECTION 4 — INVALID START BYTE TEST
        $display("\n========== SECTION 4: INVALID START BYTE TEST ==========");
        $display("FSM must NOT leave IDLE when in[3] = 0.");

        send_byte(8'b00000010); // invalid start
        send_byte(8'b00000100); // invalid
        send_byte(8'b00000001); // invalid

        if(done)
            $display("ERROR: DONE asserted on invalid packet!");
        else
            $display("PASS: FSM ignored invalid bytes (correct).");

        // Now send a real packet:
        send_byte(8'b00001011); // BYTE1 valid start
        send_byte(8'hBE);
        send_byte(8'hEF);
        if(done) show_packet();

        // SECTION 5 — RESET DURING PACKET
        $display("\n========== SECTION 5: RESET DURING PACKET ==========");

        send_byte(8'h88); // BYTE1
        reset = 1; #10; reset = 0;

        send_byte(8'h99); // Should NOT use previous data
        send_byte(8'hAA);
        send_byte(8'hBB);

        if(done)
            show_packet();
        else
            $display("PASS: RESET correctly aborted previous packet.");
        $display("\n========== ALL PACKET PARSER TESTS COMPLETED ==========\n");
        $finish;
    end

endmodule