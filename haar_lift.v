module      haar_lift(clk,
                    reset,
                    start,
                    im11,
                    im21,
                    dxy_detail,
                    dxy_approx,
                    data_occur);
                    
                    
                    
input clk;
input reset;

input start;


input [15:0]im11;
input [15:0]im21;

output data_occur;
output [15:0]dxy_detail;
output [15:0]dxy_approx;

reg data_occur;
wire [15:0]dxy_detail;
wire [15:0]dxy_approx;



reg [15:0]im11t;
reg [15:0]im21t;


assign dxy_detail=(data_occur)?(im11t+im21t):16'd0;
assign dxy_approx[14:0]=(data_occur && im11t > im21t)?(im11t-im21t):
                  (data_occur && im11t < im21t)?(im21t-im11t):16'd0;


assign dxy_approx[15]=(data_occur && im11t > im21t)?(1'b0):
                  (data_occur && im11t < im21t)?(1'b1):1'b0;
                  


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
                    