module root(
    input  [31:0] number,
    output reg [31:0] sq_root, cube_root );

    always@(number) begin
        find_sq_root(number, sq_root);
        find_cube_root(number, cube_root);  

        $display("\n \t\t Square Root of %0d is %0d", number, sq_root);
        $display(" \t\t Cube Root of   %0d is %0d ", number, cube_root);
    end

    task find_sq_root;
        input  [31:0] num;
        output [31:0] res;

        integer i;
        begin
            res = 0;
            for (i = 0; i < 3; i = i + 1) begin
                if (i*i <= num)
                    res = i;
                else
                    disable find_sq_root;   
            end
        end
    endtask
 
    task find_cube_root;
        input  [31:0] num;
        output [31:0] res;

        integer i;
        begin
      res = 0;
          for (i = 0; i < 3; i = i + 1) begin
                if (i*i*i <= num)
                    res = i;
                else
                    disable find_cube_root;
            end
          end
          endtask
      endmodule


