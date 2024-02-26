module haar_lift_re_test1;


reg clk;
reg reset;
reg start;

reg [15:0]im11,im21;


wire data_occur;

wire [15:0]dxy_detail;
wire [15:0]dxy_approx;


reg [15:0]mem[0:16383];
reg [15:0]mem1[0:16383];

integer k1;

integer file_id1,file_id2;


haar_lift_reprocess haar_lift_inst1(.clk(clk),
                    .reset(reset),
                    .start(start),
                    .im11(im11),
                    .im21(im21),
                    .x1(dxy_detail),
                    .y1(dxy_approx),
                    .data_occur(data_occur)
                    );
                    
                    



                    
                    
                    
                    
initial 
begin 
clk=0;
reset=0;
start=0;

end


always 
#20 clk=~clk;


initial
begin 
$readmemh("haar_re_image_high1.txt",mem);
$readmemh("haar_re_image_low1.txt",mem1);

file_id1=$fopen("x1cord_haar1.txt");
file_id2=$fopen("y1cord_haar1.txt");

end



initial
begin 


#200; 

  for (k1=0;k1<16384;k1=k1+1)
  begin 
  
  @(negedge clk)
   begin 
                               
                        reset=1; 
                        start=1; 
                        im11=mem[k1];
                        im21=mem1[k1];
                        
   end
   end
   
  
   
   #100; start=0; 
     
   $fclose(file_id1);
   $fclose(file_id2);
   $finish;
   
   
   
  end 


always @(negedge clk)
begin 

if(data_occur)
begin 
$fdisplay(file_id1,"%d",dxy_detail);
$fdisplay(file_id2,"%d",dxy_approx);

$display("%d",dxy_detail);
$display("%d",dxy_approx);
end







end
 



endmodule 
                    



