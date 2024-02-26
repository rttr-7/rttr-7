module      haar_lift_reprocess(clk,
                    reset,
                    start,
                    im11,
                    im21,
                    x1,
                    y1,
                    data_occur);
                    
                    
                    
input clk;
input reset;

input start;


input [15:0]im11;
input [15:0]im21;

output data_occur;
output [15:0]x1;
output [15:0]y1;

reg data_occur;

wire [15:0]x1;
wire [15:0]y1;

wire signbit;
wire [15:0]high_v;
wire [15:0]low_v;

wire [15:0]x1_val;
wire [15:0]y1_val;


reg [15:0]im11t;
reg [15:0]im21t;



assign x1=x1_val>>1;
assign y1=y1_val>>1;

assign signbit=im21t[15];
assign high_v=im11t;
assign low_v={1'b0,im21t[14:0]};

assign x1_val=(data_occur && signbit)?(high_v-low_v):
				(data_occur && ~signbit)?(high_v+low_v):16'd0;

assign y1_val=(data_occur && signbit)?(high_v+low_v):
				(data_occur && ~signbit)?(high_v-low_v):16'd0;
				





                  


always @(posedge clk)
begin 

if(~reset)
begin 

im11t<=16'd0;
im21t<=16'd0;
data_occur<=1'b0;
end

else if(start)
begin 
im11t<=im11;
im21t<=im21;
data_occur<=1'b1;
end

else
begin 
im11t<=16'd0;
im21t<=16'd0;
data_occur<=1'b0;
end

end





endmodule 
                    
