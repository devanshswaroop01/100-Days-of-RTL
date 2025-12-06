module staircase;

    integer n = 6;
    integer i, j, k;

    initial begin
        
        // Loop for rows
        for (i = 1; i <= n; i = i + 1) begin
            
            // Conditional operator: same as C++ (i % 2 != 0 ? i+1 : i)
            if (i % 2 != 0)
                k = i + 1;       // odd → k = i + 1
            else
                k = i;           // even → k = i

            // Print k stars
            for (j = 0; j < k; j = j + 1)
                $write(" * ");

            $display("");   // New line
        end

    end

endmodule
