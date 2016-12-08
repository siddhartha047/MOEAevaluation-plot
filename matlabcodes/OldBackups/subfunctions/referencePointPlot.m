subplot(2,2,1);

[m,n]=size(Global)
x=Global(1:m,1);
y=Global(1:m,2);
z=Global(1:m,3);
scatter3(x,y,z,'black');


%%hold on
subplot(2,2,2);

[m,n]=size(Active)
x=Active(1:m,1);
y=Active(1:m,2);
z=Active(1:m,3);
scatter3(x,y,z,'green');

subplot(2,2,3);

[m,n]=size(Reduction)
x=Reduction(1:m,1);
y=Reduction(1:m,2);
z=Reduction(1:m,3);
scatter3(x,y,z,'red');

subplot(2,2,4);

[m,n]=size(Smoothed)
x=Smoothed(1:m,1);
y=Smoothed(1:m,2);
z=Smoothed(1:m,3);
scatter3(x,y,z,'blue');


