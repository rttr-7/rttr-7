module haar_lift_test;


reg clk;
reg reset;
reg start,start2;

reg [15:0]im11,im11_2;
reg [15:0]im21,im21_2;


wire data_occur,data_occur2;
wire [15:0]dxy_detail,dxy_detail2;
wire [15:0]dxy_approx,dxy_approx2;


reg [15:0]mem[0:65535];
reg [15:0]mem1[0:16383];

integer file_id,file_id1,file_id_hex,file_id_2,file_id1_2,k,k1;

integer k2,k12;

haar_lift haar_lift_inst1(.clk(clk),
                    .reset(reset),
                    .start(start),
                    .im11(im11),
                    .im21(im21),
                    .dxy_detail(dxy_detail),
                    .dxy_approx(dxy_approx),
                    .data_occur(data_occur)
                    );
                    
                    
haar_lift haar_lift_inst2(.clk(clk),
                    .reset(reset),
                    .start(start2),
                    .im11(im11_2),
                    .im21(im21_2),
                    .dxy_detail(dxy_detail2),
                    .dxy_approx(dxy_approx2),
                    .data_occur(data_occur2)
                    );


                    
                    
                    
                    
initial 
begin 
clk=0;
reset=0;
start=0;
start2=0;
end


always 
#20 clk=~clk;


initial
begin 
$readmemh("haar_image_textfile.txt",mem);
file_id=$fopen("detail_haar.txt");
file_id_hex=$fopen("detail_haar_hex.txt");
file_id1=$fopen("approx_haar.txt");

file_id_2=$fopen("detail_haar2.txt");
file_id1_2=$fopen("approx_haar2.txt");


end






initial 
begin 

#200; 

  
  for (k1=0;k1<65280;k1=k1+512)
  begin 
  
  @(negedge clk)
   begin 
       start=0;
       start2=0;
    for (k=k1;k<256+k1;k=k+2)
    begin    
       
    @(negedge clk)  
    begin 
                        
                        reset=1; 
                        start=1; 
                        start2=0;
                        im11=mem[k];
                        im21=mem[k+1];
                        
   end
   end
   
   end
   
  end
  
   
       

       
@(negedge clk) start=0; $fclose(file_id);$fclose(file_id1);$fclose(file_id_hex);
#1000;

$readmemb("detail_haar_hex.txt",mem1);


for (k12=0;k12<16320;k12=k12+256)
  begin 
  
  @(negedge clk)
   begin 
       start=0;
       start2=0;
    for (k2=k12;k2<128+k12;k2=k2+2)
    begin    
       
    @(negedge clk)  
    begin 
                        
                        reset=1; 
                        start=0; 
                        start2=1;
                        im11_2=mem1[k2];
                        im21_2=mem1[k2+1];
                        
   end
   end
   
   end
   
  end
  
  
  
  
  @(negedge clk) start2=0;
  
  $fclose(file_id_2);$fclose(file_id1_2);
  $finish;
            
end
 
       

always @(negedge clk)
begin 

if(data_occur)
begin 
$fdisplay(file_id,"%d",dxy_detail);
$fdisplay(file_id_hex,"%b",dxy_detail);
$fdisplay(file_id1,"%d",dxy_approx);
$display("%d",dxy_detail);
$display("%d",dxy_approx);
end

if(data_occur2)
begin 
$fdisplay(file_id_2,"%d",dxy_detail2);
$fdisplay(file_id1_2,"%d",dxy_approx2);
$display("%d",dxy_detail2);
$display("%d",dxy_approx2);
end





end
 


endmodule 
                    

