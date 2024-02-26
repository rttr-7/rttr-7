clc
close all;
warning off;
delete *.txt;


disp('<strong>----------------------------------</strong>');
disp('<strong>Greetings from Verilog Course Team</strong>');
disp('<strong>Website:www.verilogcourseteam.com</strong>');
disp('<strong>Email:info@verilogcourseteam.com</strong>');
disp('<strong>WhatsApp @ +91 790 456 8 456</strong>');
disp('<strong>----------------------------------</strong>');
pause(1);

disp('<strong>***************************************************************************************************</strong>');
disp('<strong>HAAR CLASSIFIERS BASED DETECTION OF FACE FROM IMAGE INPUT USING COMBINATION VERILOG HDL WITH MATLAB</strong>');
disp('<strong>***************************************************************************************************</strong>');
pause(2);
HEADER

for k=1:wresize
    for k1=1:wresize

         dd=img1(k,k1);

         s1=dec2hex(dd,2);
         fprintf(ff,'%s',s1);
         fprintf(ff,'\t');
      
    end 
    
end
fclose(ff);
disp('<strong>---------------------------------------------------------</strong>');
disp('<strong>SAVING IMAGE INTO PIXEL VALUES IN haar_image_textfile.txt</strong>');
disp('<strong>---------------------------------------------------------</strong>');
pause(5);
%%
disp('<strong>------------------------------------------------------------------</strong>');
disp('<strong>Calling ModelSim Software using the Keyword hdldaemon(socket,4999)</strong>');
disp('<strong>------------------------------------------------------------------</strong>');
pause(5);
hdldaemon('socket',4999);
ff={'vlib work','vlog haar_lift_test.v haar_lift.v','vsim haar_lift_test','view wave','add wave -r /*','run -all','exit'};
vsim('socketsimulink','4449','tclstart',ff);
hdldaemon('kill');
pause;
%%
data=textread('detail_haar.txt');
data1=reshape(data,[128 128]);
LL=data1';
data_a=textread('approx_haar.txt');
data1_a=reshape(data_a,[128 128]);
data1_a=data1_a';

bin_data=data1_a>=32768;
[locr locc]=find(bin_data);

for k=1:length(locr) 
data1_a(locr(k),locc(k))=32768-data1_a(locr(k),locc(k));
end
         
HH=data1_a;

data=textread('detail_haar2.txt');
data1=reshape(data,[64 64]);
LL2=data1';
data_a=textread('approx_haar2.txt');
data1_a=reshape(data_a,[64 64]);
data1_a=data1_a';

bin_data=data1_a>=32768;
[locr locc]=find(bin_data);
img_val=(ori_img);
for k=1:length(locr)  
data1_a(locr(k),locc(k))=32768-data1_a(locr(k),locc(k));
end
        
HH2=data1_a;
final_dwt1=[LL2 HH2; HH2 HH2];
final_dwt=[final_dwt1 HH; HH HH];
a=LL2;
b=HH2;
[r c]=size(a);
ff1=fopen('haar_re_image_high.txt','w');
ff2=fopen('haar_re_image_low.txt','w');
for k1=1:r
    for k2=1:c

        b1=b(k1,k2);
        a1=a(k1,k2);
        if ( a1 > 0)
            a1bin=dec2hex(a1,4);
        else
            a1bin1=['1',dec2bin(abs(a1),15)];
            a12=bin2dec(a1bin1);
            a1bin=dec2hex(a12,4);
        end

        if ( b1 > 0)
            b1bin=dec2hex(b1,4);
            
        else
            b1bin1=['1',dec2bin(abs(b1),15)];
            b12=bin2dec(b1bin1);
            b1bin=dec2hex(b12,4);
        end
        
         fprintf(ff1,'%s',a1bin);
         fprintf(ff1,'\t');
         
         fprintf(ff2,'%s',b1bin);
         fprintf(ff2,'\t');
 
    end
    
end

fclose(ff1);
fclose(ff2);
%%
a=LL;
b=HH;
[r c]=size(a);
ff1=fopen('haar_re_image_high1.txt','w');
ff2=fopen('haar_re_image_low1.txt','w');

for k1=1:r
    
    for k2=1:c
 
        b1=b(k1,k2);
        a1=a(k1,k2);
        
        if ( a1 > 0)
            
            a1bin=dec2hex(a1,4);
            
        else
            a1bin1=['1',dec2bin(abs(a1),15)];
            a12=bin2dec(a1bin1);
            a1bin=dec2hex(a12,4);
        end
 
        if ( b1 > 0)
            
            b1bin=dec2hex(b1,4);
            
        else
            b1bin1=['1',dec2bin(abs(b1),15)];
            b12=bin2dec(b1bin1);
            b1bin=dec2hex(b12,4);
        end
        
         fprintf(ff1,'%s',a1bin);
         fprintf(ff1,'\t');
         
         fprintf(ff2,'%s',b1bin);
         fprintf(ff2,'\t');
   
    end
    
end

fclose(ff1);
fclose(ff2);
%%
disp('<strong>------------------------------------------------------------------</strong>');
disp('<strong>Calling ModelSim Software using the Keyword hdldaemon(socket,4999)</strong>');
disp('<strong>------------------------------------------------------------------</strong>');
pause(5);
hdldaemon('socket',4999);
ff={'vlog haar_lift_re_test.v   haar_lift_reprocess.v','vsim haar_lift_re_test','view wave','add wave -r /*','run -all','exit'};
vsim('socketsimulink','4449','tclstart',ff);
hdldaemon('kill')
pause;
%%
disp('<strong>------------------------------------------------------------------</strong>');
disp('<strong>Calling ModelSim Software using the Keyword hdldaemon(socket,4999)</strong>');
disp('<strong>------------------------------------------------------------------</strong>');
pause(5);
hdldaemon('socket',4999);
ff={'vlog  haar_lift_re_test1.v  haar_lift_reprocess.v','vsim haar_lift_re_test1','view wave','add wave -r /*','run -all','exit'};
vsim('socketsimulink','4449','tclstart',ff);
pause
%%
datax=textread('x1cord_haar1.txt');
datay=textread('y1cord_haar1.txt');
x1=datax(1:16384);
y1=datay(1:16384);
i1=1;
for k=1:128:16384-127
    
    outx{i1}=datax(k:k+127);
    outy{i1}=datay(k:k+127);
    i1=i1+1;
end
for k1=1:128
    
    xs=outx{k1};
    ys=outy{k1};
    km=1;
    for kk=1:128
        
        out(1,km)=xs(kk);
        out(1,km+1)=ys(kk);
        km=km+2;
    end
    
outw(k1,1:256)=out;
end
%%
datax=textread('x1cord_haar.txt');
datay=textread('y1cord_haar.txt');
x1=datax(1:4096);
y1=datay(1:4096);

i1=1;
for k=1:64:4096-63
    
    outx{i1}=datax(k:k+63);
    outy{i1}=datay(k:k+63);
    i1=i1+1;
end

for k1=1:64
    
    xs=outx{k1};
    ys=outy{k1};
    km=1;
    for kk=1:64
        
        out(1,km)=xs(kk);
        out(1,km+1)=ys(kk);
        km=km+2;
    end
end

%%
disp('<strong>----------------------------------------------------------</strong>');
disp('<strong>DISPLAYING FACE DETECTED OUTPUT FROM THE GIVEN INPUT IMAGE</strong>');
disp('<strong>----------------------------------------------------------</strong>');
pause(5);
process((img_val));




