%This is the main file of GRNG, it includes several parts below each with an
%annotation on the top


% URNG generate random number
result=zeros(10000,1);
%x_axis=zeros(10000,1);
in_array=zeros(10000,1);
for z=1:10000    
in=rand();    %this part generate random 64 bit number in [0.1]
Bitwidth=64;
count=0;
tempin=in;
randnum=zeros(1,Bitwidth);
while(Bitwidth)
    count=count+1;
    if(count>Bitwidth)
        Bitwidth=0;
    end
    tempin=tempin*2;
    if tempin>1
        randnum(count)=1;
        tempin=tempin-1;
    elseif(tempin==1)
        randnum(count)=1;
        Bitwidth=0;
    else
       randnum(count)=0;    
    end
end
for i=1:32        %this is to inverse the randnum nuber binary bit to make it MSB->LSB
    temp=randnum(i);
    randnum(i)=randnum(65-i);
    randnum(65-i)=temp;
end
for i=1:11      %because of the limition precision of random number, bit 0-10 are all 0s
  randnum(i)=round(rand());     %give random value to the 0-10 bits
  if i==1
      signbit=randnum(1);
  end
  in=in+randnum(i)*2^(-65+i);    %add these value to decimal "in"
  
end
in_array(z)=in;

% LZD part
LZDoutput=zeros(1,6);
LZDinput=randnum(4:64);
for i=1:61
    if LZDinput(62-i)==0
       position=i;break
    end
end
LZDoutput_part1=de2bi(position,5);
LZDoutput_part2=LZDinput(61-position);
LZDoutput(2:6)=LZDoutput_part1;
LZDoutput(1)=LZDoutput_part2;    %LZD output 5 bit of '0' position, plus 1 bit of following bit

%ROM_trans and offset part
ROM_tran_in=LZDoutput;
ROM_tran_out=zeros(1,7);
if bi2de(ROM_tran_in(2:6))==1 
    if ROM_tran_in(1)==0
        ROM_tran_out=[0,0,0,0,0,0,0];
        segment=1;         %segment is presented in decimal
    elseif ROM_tran_in(1)==1
        ROM_tran_out=[0,0,0,0,0,1,0];
        segment=2;
    end
elseif bi2de(ROM_tran_in(2:6))==2
    if ROM_tran_in(1)==0
        ROM_tran_out=[0,0,0,0,0,0,1];
        segment=3;
    elseif ROM_tran_in(1)==1
        ROM_tran_out=[0,0,0,0,1,0,1];
        segment=4;
    end
elseif bi2de(ROM_tran_in(2:6))==3
    if ROM_tran_in(1)==0
        ROM_tran_out=[0,0,0,0,0,1,1];
        segment=5;
    elseif ROM_tran_in(1)==1
        ROM_tran_out=[0,0,0,1,0,1,1];
        segment=6;
    end
elseif bi2de(ROM_tran_in(2:6))==4
    if ROM_tran_in(1)==0
        ROM_tran_out=[0,0,0,0,1,1,1];
        segment=7;
    elseif ROM_tran_in(1)==1
        ROM_tran_out=[0,0,1,0,1,1,1];
        segment=8;
    end
elseif bi2de(ROM_tran_in(2:6))==5
    if ROM_tran_in(1)==0
        ROM_tran_out=[0,0,0,1,1,1,1];
        segment=9;
    elseif ROM_tran_in(1)==1
        ROM_tran_out=[0,1,0,1,1,1,1];
        segment=10;
    end
elseif bi2de(ROM_tran_in(2:6))>=6
        segment=10;
    if ROM_tran_in(1)==0
        ROM_tran_out=[0,0,1,1,1,1,1];
    elseif ROM_tran_in(1)==1
        ROM_tran_out=[1,0,1,1,1,1,1];
    end
end
offset=randnum(2:3);       %ROM_trans output the coresponding 7 bit segment
%segment=de2bi(bi2de(offset)+bi2de(ROM_trans_output),7);   %didn't use
%offset

%find coefficients ROM 1    % responding to ROM_Coef
 Coef2=trans_a(segment,1);
 Coef1=trans_a(segment,2);
 Coef0=trans_a(segment,3);


%Mask to 0 part
feedMask=randnum(4:18);
Maskinput=feedMask;   
if position >=47
    overlap=position-47;
    for i=0:overlap
        Maskinput(15-i)=0;
    end
end
for i=1:7      %this part is to reverse the maskoutput
    temp=Maskinput(i);
    Maskinput(i)=Maskinput(16-i);
    Maskinput(16-i)=temp;
end
Maskoutput=Maskinput;
Maskoutput_de=0;
 for i=1:15    %transform the Maskoutput to decimal
   Maskoutput_de=Maskoutput_de+Maskoutput(i)*1/(2*(2^(15-i))); 
 end
% logical part
%x_axis(z)=Maskoutput_de/Bxa(segment)+boundary(segment);   %this is to make the 15bit input be the x_axis
temp1=Maskoutput_de*Coef2;
temp2=temp1+Coef1;
temp3=Maskoutput_de*temp2;
result(z)=temp3+Coef0;

% 2's Complement
if signbit==1
   result(z)=-result(z);
end
%save input.txt -ascii in_array;
end
   
%plot(x_axis,result,'o');
histogram(result);
%save output.txt -ascii result;
test=kstest(result);