module MUX4x1 #(
    parameter   DATA_WIDTH = 16
) (
    input   wire    [1:0]               select,
    input   wire    [DATA_WIDTH-1:0]    in0,
    input   wire    [DATA_WIDTH-1:0]    in1,
    input   wire    [DATA_WIDTH-1:0]    in2,
    input   wire    [DATA_WIDTH-1:0]    in3,
    output  reg     [DATA_WIDTH-1:0]    out
);

always @(*) begin
    case (select)
        2'b00:  out = in0;
        2'b01:  out = in1;
        2'b10:  out = in2;
        2'b11:  out = in3; 
    endcase
end
    
endmodule