// if you want to change the integer and fractional size, make sure to modify the localparameters of pi and cos_val to be suitable for the representation
module rotation_cordic #(
    parameter   INT_SIZE = 3,
                FRAC_SIZE = 12,
                NO_STAGES = 3,
                NO_ITERATIONS = 10
) (
    input   wire                                        clk, 
    input   wire                                        rst_n,
    input   wire                                        enable,
    input   wire    signed    [INT_SIZE+FRAC_SIZE-1:0]  theta_in,
    input   wire    signed    [INT_SIZE+FRAC_SIZE-1:0]  mag_in,
    output  reg     signed    [INT_SIZE+FRAC_SIZE-1:0]  final_real,
    output  reg     signed    [INT_SIZE+FRAC_SIZE-1:0]  final_imag,
    output  wire                                        data_valid
);
localparam  DATA_WIDTH = INT_SIZE+FRAC_SIZE,
            pi = 15'd12868,//3.14159*(2**FRAC_SIZE),
            half_pi = (pi/2),
            cos_val = 15'd2487,//0.6072533210*(2**FRAC_SIZE),
            NO_ITERATIONS_PER_STAGE = 4;
//===============================internal signals=========================//
//--------initial status signals--------//
reg                                     direction;      // 1:negative   0:positive
reg                                     x_cond;         // 1:negative   0:positive     

                                                        // using the variable with size of (NO_STAGES) as
reg             [NO_STAGES-2:0]         x_cond_reg;     // each cycle new inputs will be processed independant
                                                        // on the previous inputs, so status of each input should be preserved

wire            [NO_STAGES-2:0]         enable_del;
wire    signed  [DATA_WIDTH-1:0]        mag_in_reg      [0:NO_STAGES-2]; //to register the magnitude and align the right inputs with its operation

//-------------itteration signals----------//
reg             [NO_ITERATIONS:0]       directions;
reg     signed  [DATA_WIDTH-1:0]        x           [0:NO_ITERATIONS];
reg     signed  [DATA_WIDTH-1:0]        y           [0:NO_ITERATIONS];
reg     signed  [DATA_WIDTH-1:0]        theta       [0:NO_ITERATIONS];
wire    signed  [DATA_WIDTH-1:0]        arctan      [0:NO_ITERATIONS];
integer                                 i;

reg             [NO_STAGES-2:0]         directions_reg;
reg     signed  [DATA_WIDTH-1:0]        x_reg       [0:NO_STAGES-2];
reg     signed  [DATA_WIDTH-1:0]        y_reg       [0:NO_STAGES-2];
reg     signed  [DATA_WIDTH-1:0]        theta_reg   [0:NO_STAGES-2];

wire    signed  [DATA_WIDTH-1:0]        unfinal_real; //to form the final comparison in the end of the iterations
wire    signed  [DATA_WIDTH-1:0]        unfinal_imag; //to form the final comparison in the end of the iterations

//========================================================================//

//=======================determining the initial status signals===================//
//------combinational logic---------//
always @(*) begin
    direction = 1'b0;
    x_cond = 1'b0;
    if(theta_in[DATA_WIDTH-1]) begin
        direction = 1'b0;
    end
    else begin
        direction = 1'b1;
    end
    
    if((theta_in > ($signed(half_pi))) | ((theta_in) < -($signed(half_pi)))) begin
        x_cond = 1'b1;
    end
    else begin
        x_cond = 1'b0;
    end
end

//------registering the status signals-----//
always @(posedge clk or negedge rst_n) begin
    if(!rst_n | !enable) begin
        x_cond_reg      <= 'b0;
    end
    else if(enable) begin
        x_cond_reg      <= {x_cond_reg[NO_STAGES-3:0], x_cond};
    end
end
//========================================================================//

//=================first cycle itterations===============================//

always @(*) begin
    x[0] = ((theta_in > ($signed(half_pi))) | ((theta_in) < -($signed(half_pi))))? 'b0: cos_val;
    y[0] = ((theta_in > ($signed(half_pi))) | ((theta_in) < -($signed(half_pi))))? (direction? -cos_val: cos_val) : 'b0 ;
    theta[0] = ((theta_in > ($signed(half_pi))) | ((theta_in) < -($signed(half_pi))))? (direction? theta_in-half_pi: theta_in+half_pi): theta_in;
    directions[0] = direction;

    for (i =0 ;i<NO_ITERATIONS_PER_STAGE ; i = i+1) begin
        x[i+1] = directions[i]? x[i]-(y[i]>>>i) : x[i]+(y[i]>>>i);
        y[i+1] = directions[i]? y[i]+(x[i]>>>i) : y[i]-(x[i]>>>i);
        theta[i+1] = directions[i]? theta[i]-arctan[i] : theta[i]+arctan[i];
        directions[i+1] = theta[i+1][DATA_WIDTH-1]? 1'b0 : 1'b1;
    end
end
/*assign  x[0] = ((theta_in > ($signed(half_pi))) | ((theta_in) < -($signed(half_pi))))? 'b0: cos_val;
assign  y[0] = ((theta_in > ($signed(half_pi))) | ((theta_in) < -($signed(half_pi))))? (direction? -cos_val: cos_val) : 'b0 ;
assign  theta[0] = ((theta_in > ($signed(half_pi))) | ((theta_in) < -($signed(half_pi))))? (direction? theta_in-half_pi: theta_in+half_pi): theta_in;
assign  directions[0] = direction;

assign  x[1] = directions[0]? x[0]-y[0] : x[0]+y[0];
assign  y[1] = directions[0]? y[0]+x[0] : y[0]-x[0];
assign  theta[1] = directions[0]? theta[0]-arctan[0] : theta[0]+arctan[0];
assign  directions[1] = theta[1][DATA_WIDTH-1]? 1'b0 : 1'b1;

assign  x[2] = directions[1]? x[1]-(y[1]>>>1) : x[1]+(y[1]>>>1);
assign  y[2] = directions[1]? y[1]+(x[1]>>>1) : y[1]-(x[1]>>>1);
assign  theta[2] = directions[1]? theta[1]-(arctan[1]) : theta[1]+(arctan[1]);
assign  directions[2] = theta[2][DATA_WIDTH-1]? 1'b0 : 1'b1;

assign  x[3] = directions[2]? x[2]-(y[2]>>>2) : x[2]+(y[2]>>>2);
assign  y[3] = directions[2]? y[2]+(x[2]>>>2) : y[2]-(x[2]>>>2);
assign  theta[3] = directions[2]? theta[2]-(arctan[2]) : theta[2]+(arctan[2]);
assign  directions[3] = theta[3][DATA_WIDTH-1]? 1'b0 : 1'b1;

assign  x[4] = directions[3]? x[3]-(y[3]>>>3) : x[3]+(y[3]>>>3);
assign  y[4] = directions[3]? y[3]+(x[3]>>>3) : y[3]-(x[3]>>>3);
assign  theta[4] = directions[3]? theta[3]-(arctan[3]) : theta[3]+(arctan[3]);
assign  directions[4] = theta[4][DATA_WIDTH-1]? 1'b0 : 1'b1;*/

always @(posedge clk or negedge rst_n) begin
    if(!rst_n | !enable) begin
        directions_reg[0] <= 1'b0;
        x_reg[0] <= 'b0;
        y_reg[0] <= 'b0;
        theta_reg[0] <= 'b0;
    end
    else if(enable) begin
        directions_reg[0] <= directions[NO_ITERATIONS_PER_STAGE];
        x_reg[0] <= x[NO_ITERATIONS_PER_STAGE];
        y_reg[0] <= y[NO_ITERATIONS_PER_STAGE];
        theta_reg[0] <= theta[NO_ITERATIONS_PER_STAGE];
    end
end

//=======================================================================//

//=================second cycle itterations===============================//

always @(*) begin
    x[NO_ITERATIONS_PER_STAGE+1] = directions_reg[0]? x_reg[0]-(y_reg[0]>>>NO_ITERATIONS_PER_STAGE) : x_reg[0]+(y_reg[0]>>>NO_ITERATIONS_PER_STAGE);
    y[NO_ITERATIONS_PER_STAGE+1] = directions_reg[0]? y_reg[0]+(x_reg[0]>>>NO_ITERATIONS_PER_STAGE) : y_reg[0]-(x_reg[0]>>>NO_ITERATIONS_PER_STAGE);
    theta[NO_ITERATIONS_PER_STAGE+1] = directions_reg[0]? theta_reg[0]-(arctan[NO_ITERATIONS_PER_STAGE]) : theta_reg[0]+(arctan[NO_ITERATIONS_PER_STAGE]);
    directions[NO_ITERATIONS_PER_STAGE+1] = theta[NO_ITERATIONS_PER_STAGE+1][DATA_WIDTH-1]? 1'b0 : 1'b1;

    for (i =NO_ITERATIONS_PER_STAGE+1 ;i<2*NO_ITERATIONS_PER_STAGE ; i = i+1) begin
        x[i+1] = directions[i]? x[i]-(y[i]>>>i) : x[i]+(y[i]>>>i);
        y[i+1] = directions[i]? y[i]+(x[i]>>>i) : y[i]-(x[i]>>>i);
        theta[i+1] = directions[i]? theta[i]-arctan[i] : theta[i]+arctan[i];
        directions[i+1] = theta[i+1][DATA_WIDTH-1]? 1'b0 : 1'b1;
    end
end

/*assign  x[5] = directions_reg[0]? x_reg[0]-(y_reg[0]>>>4) : x_reg[0]+(y_reg[0]>>>4);
assign  y[5] = directions_reg[0]? y_reg[0]+(x_reg[0]>>>4) : y_reg[0]-(x_reg[0]>>>4);
assign  theta[5] = directions_reg[0]? theta_reg[0]-(arctan[4]) : theta_reg[0]+(arctan[4]);
assign  directions[5] = theta[5][DATA_WIDTH-1]? 1'b0 : 1'b1;

assign  x[6] = directions[5]? x[5]-(y[5]>>>5) : x[5]+(y[5]>>>5);
assign  y[6] = directions[5]? y[5]+(x[5]>>>5) : y[5]-(x[5]>>>5);
assign  theta[6] = directions[5]? theta[5]-(arctan[5]) : theta[5]+(arctan[5]);
assign  directions[6] = theta[6][DATA_WIDTH-1]? 1'b0 : 1'b1;

assign  x[7] = directions[6]? x[6]-(y[6]>>>6) : x[6]+(y[6]>>>6);
assign  y[7] = directions[6]? y[6]+(x[6]>>>6) : y[6]-(x[6]>>>6);
assign  theta[7] = directions[6]? theta[6]-(arctan[6]) : theta[6]+(arctan[6]);
assign  directions[7] = theta[7][DATA_WIDTH-1]? 1'b0 : 1'b1;

assign  x[8] = directions[7]? x[7]-(y[7]>>>7) : x[7]+(y[7]>>>7);
assign  y[8] = directions[7]? y[7]+(x[7]>>>7) : y[7]-(x[7]>>>7);
assign  theta[8] = directions[7]? theta[7]-(arctan[7]) : theta[7]+(arctan[7]);
assign  directions[8] = theta[8][DATA_WIDTH-1]? 1'b0 : 1'b1;*/

always @(posedge clk or negedge rst_n) begin
    if(!rst_n | !enable) begin
        directions_reg[1] <= 1'b0;
        x_reg[1] <= 'b0;
        y_reg[1] <= 'b0;
        theta_reg[1] <= 'b0;
    end
    else if(enable) begin
        directions_reg[1] <= directions[2*NO_ITERATIONS_PER_STAGE];
        x_reg[1] <= x[2*NO_ITERATIONS_PER_STAGE];
        y_reg[1] <= y[2*NO_ITERATIONS_PER_STAGE];
        theta_reg[1] <= theta[2*NO_ITERATIONS_PER_STAGE];
    end
end

//=======================================================================//

//=================third cycle itterations===============================//

always @(*) begin
    x[2*NO_ITERATIONS_PER_STAGE+1] = directions_reg[1]? x_reg[1]-(y_reg[1]>>>2*NO_ITERATIONS_PER_STAGE) : x_reg[1]+(y_reg[1]>>>2*NO_ITERATIONS_PER_STAGE);
    y[2*NO_ITERATIONS_PER_STAGE+1] = directions_reg[1]? y_reg[1]+(x_reg[1]>>>2*NO_ITERATIONS_PER_STAGE) : y_reg[1]-(x_reg[1]>>>2*NO_ITERATIONS_PER_STAGE);
    theta[2*NO_ITERATIONS_PER_STAGE+1] = directions_reg[1]? theta_reg[1]-(arctan[2*NO_ITERATIONS_PER_STAGE]) : theta_reg[1]+(arctan[2*NO_ITERATIONS_PER_STAGE]);
    directions[2*NO_ITERATIONS_PER_STAGE+1] = theta[2*NO_ITERATIONS_PER_STAGE+1][DATA_WIDTH-1]? 1'b0 : 1'b1;

    for (i =2*NO_ITERATIONS_PER_STAGE+1 ;i<NO_ITERATIONS ; i = i+1) begin
        x[i+1] = directions[i]? x[i]-(y[i]>>>i) : x[i]+(y[i]>>>i);
        y[i+1] = directions[i]? y[i]+(x[i]>>>i) : y[i]-(x[i]>>>i);
        theta[i+1] = directions[i]? theta[i]-arctan[i] : theta[i]+arctan[i];
        directions[i+1] = theta[i+1][DATA_WIDTH-1]? 1'b0 : 1'b1;
    end
end
/*assign  x[9] = directions_reg[1]? x_reg[1]-(y_reg[1]>>>8) : x_reg[1]+(y_reg[1]>>>8);
assign  y[9] = directions_reg[1]? y_reg[1]+(x_reg[1]>>>8) : y_reg[1]-(x_reg[1]>>>8);
assign  theta[9] = directions_reg[1]? theta_reg[1]-(arctan[8]) : theta_reg[1]+(arctan[8]);
assign  directions[9] = theta[9][DATA_WIDTH-1]? 1'b0 : 1'b1;

assign  x[10] = directions[9]? x[9]-(y[9]>>>9) : x[9]+(y[9]>>>9);
assign  y[10] = directions[9]? y[9]+(x[9]>>>9) : y[9]-(x[9]>>>9);
assign  theta[10] = directions[9]? theta[9]-(arctan[9]) : theta[9]+(arctan[9]);
assign  directions[10] = theta[10][DATA_WIDTH-1]? 1'b0 : 1'b1;*/

always @(posedge clk or negedge rst_n) begin
    if (!rst_n | !enable) begin
        final_real <= 'b0;
        final_imag <= 'b0;
    end
    else if(enable) begin
        final_real <= unfinal_real;
        final_imag <= unfinal_imag;
    end
end
//=======================================================================//
//==================instantiation of the ROM============================//
arctan_lut #( .DATA_WIDTH(DATA_WIDTH), .ROM_DEPTH(NO_ITERATIONS), .NO_MUX(4)) LUT1 ( .itter_select(2'b0), .out1(arctan[0]), .out2(arctan[1]), .out3(arctan[2]), .out4(arctan[3]));
arctan_lut #( .DATA_WIDTH(DATA_WIDTH), .ROM_DEPTH(NO_ITERATIONS), .NO_MUX(4)) LUT2 ( .itter_select(2'b1), .out1(arctan[4]), .out2(arctan[5]), .out3(arctan[6]), .out4(arctan[7]));
arctan_lut #( .DATA_WIDTH(DATA_WIDTH), .ROM_DEPTH(NO_ITERATIONS), .NO_MUX(4)) LUT3 ( .itter_select(2'b10), .out1(arctan[8]), .out2(arctan[9]), .out3(arctan[10]));

Multiplier_rotation #(.INT_SIZE(INT_SIZE), .FRAC_SIZE(FRAC_SIZE)) MUL1 (.in1(x[NO_ITERATIONS]), .in2(mag_in_reg[1]), .cond(x_cond_reg[1]), .out(unfinal_real));
Multiplier_rotation #(.INT_SIZE(INT_SIZE), .FRAC_SIZE(FRAC_SIZE)) MUL2 (.in1(y[NO_ITERATIONS]), .in2(mag_in_reg[1]), .cond(x_cond_reg[1]), .out(unfinal_imag));

delay_unit #( .DATA_WIDTH(1)) DEL1 (.clk(clk), .reset(rst_n), .enable(enable), .in_data(enable), .out_data(enable_del[0]));
delay_unit #( .DATA_WIDTH(1)) DEL2 (.clk(clk), .reset(rst_n), .enable(enable), .in_data(enable_del[0]), .out_data(enable_del[1]));
delay_unit #( .DATA_WIDTH(1)) DEL3 (.clk(clk), .reset(rst_n), .enable(enable), .in_data(enable_del[1]), .out_data(data_valid));

delay_unit #( .DATA_WIDTH(DATA_WIDTH)) DEL4 (.clk(clk), .reset(rst_n), .enable(enable), .in_data(mag_in), .out_data(mag_in_reg[0]));
delay_unit #( .DATA_WIDTH(DATA_WIDTH)) DEL5 (.clk(clk), .reset(rst_n), .enable(enable), .in_data(mag_in_reg[0]), .out_data(mag_in_reg[1]));
//======================================================================//

endmodule