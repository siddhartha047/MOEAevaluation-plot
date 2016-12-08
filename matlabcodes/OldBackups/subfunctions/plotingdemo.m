filename='E:\Thesis lab experiment documents\algorithm\Results(2,5,8D)\NSGAIII-DTLZ2(2)-Run0.txt'

a= load(filename);
[m,n]=size(a);
x=a(1:m,1);
y=a(1:m,2);
scatter(x,y);