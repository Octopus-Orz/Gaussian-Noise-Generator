%Referred from paper[23], I calculated the error max which is used to
%calculate limit of segmentation using the method of minimax.

prev_e=0;
for i=10:180      %the values in boundaries deviates severly, so choose in between interval
    x=linspace(0.5+i*0.0025,0.5+(i+1)*0.0025,10); % divide the interval(0.5,1)into 100 segments
    y=ICDF(x);
    p2=polyfit(x,y,2);
    g2=polyval(p2,x);
    E_max=abs(max(y-g2));
    E_max=max(prev_e,E_max);
    prev_e=E_max;
   % fprintf('%1.11f\n',E_max);
end
