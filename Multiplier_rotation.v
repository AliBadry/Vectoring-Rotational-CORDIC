module Multiplier_rotation #(
    parameter INT_SIZE = 16,
              FRAC_SIZE = 16
) (
    input   wire signed [INT_SIZE+FRAC_SIZE-1:0] in1, in2,
    input   wire                                 cond,
    output  wire signed [INT_SIZE+FRAC_SIZE-1:0] out
);
localparam DATA_WIDTH = INT_SIZE+FRAC_SIZE;

  wire signed [2*DATA_WIDTH-1:0] res;

  assign res = cond? -in1*in2 : in1*in2;
  assign out = res>>FRAC_SIZE;
endmodule