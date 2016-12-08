a=linspace(0,2,12)
b=fliplr(linspace(0,4,12))

[r,c]=size(a);

for i=1:c
   fprintf('{%0.2f,%0.2f},\n',a(1,i),b(1,i));
end