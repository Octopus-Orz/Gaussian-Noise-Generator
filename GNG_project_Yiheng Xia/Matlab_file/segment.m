% this file is to test the limit of segmentation, referred from paper"Hierachical segmentation
%schemes for function evaluation"
% Test contition includes Emax calculated from Emax.m in the folder
% Test result is in segment.txt in the folder. I followed the three limit segments in
% the text file when doing the segmentation.
a=0.5;b=0.95;  
x1=a;x2=b;m=1;d=2;ulp=4e-03;done=0;check_x2=0;prev_x2=a;oscillating=0;

u=zeros(128,1);
t=1;
while(~done)
    x=linspace(x1,x2,1000);
    f=ICDF(x);
    p=polyfit(x,f,2);
    g=polyval(p,x);
    error=abs(max(f-g));
   if(error<= 0.000005)
       if(x2==b)
         u(t)=x2;
         done=1;
       else
          if(oscillating)
             u(m)=x2;
             prev_x2=x2;
             x1=x2;
             x2=b;
             m=m+1;
             oscillating=0;
          else
             change_x2 = abs(x2-prev_x2)/2;
             prev_x2=x2;
             if(change_x2>ulp)
                 x2=x2+change_x2;
             else
                 x2=x2+ulp;
             end
          end
       end
   else
       change_x2 = abs(x2-prev_x2)/2;
       prev_x2 = x2;
       if(change_x2>ulp)
           x2=x2-change_x2;
       else
           x2=x2-ulp;
           if(check_x2==x2)
               oscillating =1;
           else
               check_x2=x2;
           end
       end
   end
   t=t+1;
end
    dlmwrite('segment.txt',u);