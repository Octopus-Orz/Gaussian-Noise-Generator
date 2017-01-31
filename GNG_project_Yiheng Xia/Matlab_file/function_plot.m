x=linspace(0,1);
y=ICDF(x);
p=polyfit(x,y,2);
x1=linspace(0.5,0.6);
g=polyval(p,x1);
figure
plot(x,y,'r')
hold on
plot(x1,g,'b')
hold off