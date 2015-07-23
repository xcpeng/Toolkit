function plot_my_life
x=0:0.01:25;
y=zeros(length(x),1);
z=y;
q=y;
for i=1:length(x)
    if x(i)<6
        y(i)=0.2*x(i)+0.8 ;
        z(i) = 0.2;
        q(i)=y(i);
    elseif x(i)<8
        t=x(i);
        y(i)=0.14*t*t +(0.1-0.14*12)*t + 2-(36*0.14+6*(0.1-0.14*12));
        z(i) =0.24*t+(0.1-0.14*12) ;
        q(i)=y(i);
    elseif x(i)<11
        y(i)=(3.2-2.76)*x(i)/3 + 3.2-11*(3.2-2.76)/3;
        z(i) = (3.2-2.76)/3;
        q(i)=y(i);
    elseif x(i)<13
        y(i)=0.5*x(i) + (3.2-0.5*11);
        z(i)=0.5;
        q(i)=y(i);
    elseif x(i)<14
        y(i) = 2*x(i) + 4.2-2*13 ;
        z(i) =2;
        q(i)=y(i);
    elseif x(i)<18
        y(i) =0.4*x(i) + 6.2 - 0.4*14;
        z(i) = 0.4;
    elseif x(i)<19
        y(i) = x(i) + 7.8 - 18;
        z(i) =1;
    elseif x(i)<22
        y(i) = 0.2*x(i) + 8.8 - 0.2*19;
        z(i) =0.2;
    elseif x(i)<23
        y(i) =0.8*x(i) + 9.4 - 0.8*22;
        z(i) = 0.8;
    elseif x(i)<23.5
        y(i) = 3*x(i) + 10.2 - 3*(23);
        z(i) =3;
    elseif x(i)<24
        y(i) = 0.4*x(i) + 11.7-0.4*23.5;
        z(i) =0.4;
    elseif x(i)<25
        y(i)=3*x(i) + 11.9 -3*24;
        z(i) = 3;
    end;
    
end
y(i) = 14.9;
z =z+0.5;
plot(x,y,'-r',x,z,'-g');
xlabel('Age of Brother Chao')
ylabel('Growth Value');
title('Growth Curve of Xingchao Peng');



legend('Growth Curve','Growth Ratio');

%h=area(y,0);
%p=get(h,'EdgeColor');
%set(h,'EdgeColor','red');
end


