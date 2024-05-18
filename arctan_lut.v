module arctan_lut #(
    parameter   DATA_WIDTH = 16,
                ROM_DEPTH = 10,
                NO_MUX = 4
) (
    input   wire    [$clog2(NO_MUX)-1:0]    itter_select,
    output  wire    [DATA_WIDTH-1:0]        out1,
    output  wire    [DATA_WIDTH-1:0]        out2,
    output  wire    [DATA_WIDTH-1:0]        out3,
    output  wire    [DATA_WIDTH-1:0]        out4
);

/*reg [DATA_WIDTH-1:0]    MEM     [0:ROM_DEPTH-1];

initial begin
    $readmemb("atan_rom.txt",MEM);
end

MUX4x1  #(.DATA_WIDTH(DATA_WIDTH))  MUX1 (.select(itter_select), .in0(MEM[0]), .in1(MEM[4]), .in2(MEM[8]), .in3('b0), .out(out1));
MUX4x1  #(.DATA_WIDTH(DATA_WIDTH))  MUX2 (.select(itter_select), .in0(MEM[1]), .in1(MEM[5]), .in2(MEM[9]), .in3('b0), .out(out2));
MUX4x1  #(.DATA_WIDTH(DATA_WIDTH))  MUX3 (.select(itter_select), .in0(MEM[2]), .in1(MEM[6]), .in2(MEM[10]), .in3('b0), .out(out3));
MUX4x1  #(.DATA_WIDTH(DATA_WIDTH))  MUX4 (.select(itter_select), .in0(MEM[3]), .in1(MEM[7]), .in2('b0), .in3('b0), .out(out4));*/

MUX4x1  #(.DATA_WIDTH(DATA_WIDTH)
)  MUX1 (
    .select(itter_select), 
    .in0('b0110010010000), 
    .in1('b0000011111111), 
    .in2('b0000000001111), 
    .in3('b0), 
    .out(out1)
    );

MUX4x1  #(.DATA_WIDTH(DATA_WIDTH)
)  MUX2 (
    .select(itter_select), 
.in0('b0011101101011), 
.in1('b0000001111111), 
.in2('b0000000000111), 
.in3('b0), 
.out(out2)
);

MUX4x1  #(.DATA_WIDTH(DATA_WIDTH)
)  MUX3 (
    .select(itter_select), 
.in0('b0001111101011), 
.in1('b0000000111111), 
.in2('b0), 
.in3('b0), 
.out(out3)
);

MUX4x1  #(.DATA_WIDTH(DATA_WIDTH)
)  MUX4 (
    .select(itter_select), 
.in0('b0000111111101), 
.in1('b0000000011111), 
.in2('b0), 
.in3('b0), 
.out(out4)
);

endmodule