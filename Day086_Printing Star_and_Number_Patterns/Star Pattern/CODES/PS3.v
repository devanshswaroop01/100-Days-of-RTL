module diamond #(parameter N = 5);

    integer i, j, space;

    initial begin
        space = N - 1;

        // Upper half
        for (i = 0; i < N; i = i + 1) begin

            for (j = 0; j < space; j = j + 1)
                $write(" ");

            for (j = 0; j <= i; j = j + 1)
                $write("* ");

            $display("");
            space = space - 1;
        end

        // Lower half
        space = 0;

        for (i = N; i > 0; i = i - 1) begin

            for (j = 0; j < space; j = j + 1)
                $write(" ");

            for (j = 0; j < i; j = j + 1)
                $write("* ");

            $display("");
            space = space + 1;
        end
    end

endmodule
