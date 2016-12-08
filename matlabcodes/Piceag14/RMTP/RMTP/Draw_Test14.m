%  Robust multi-objective test problems                                      %
%                                                                            %
%  Developed in MATLAB R2011b(7.13)                                          %
%                                                                            %
%  Author and programmer: Seyedali Mirjalili                                 %
%                                                                            %
%         e-Mail: ali.mirjalili@gmail.com                                    %
%                 seyedali.mirjalili@griffithuni.edu.au                      %
%                                                                            %
%       Homepage: http://www.alimirjalili.com                                %
%                                                                            %
%   Main paper:                                                              %
%   S. Mirjalili, A. Lewis,                                                  %
%   Novel Frameworks for Creating Robust Multi-objective Benchmark Problems, %
%   Information Sciences,  Vol. 300 , pp. 158–192, 2015,                     %
%                DOI: http://dx.doi.org/10.1016/j.ins.2014.12.037            %
%                                                                            %

% Bechmark function name in the paper: Test14
clc
clear all

%Draw Search space

%[X,Y] = meshgrid(0:0.01:1,-1/100+0.5:0.02/100:1/100+0.5);
%[X,Y] = meshgrid(0:0.01:1,-1/100:0.02/100:1/100);

[X,Y] = meshgrid(0:0.01:1,0:0.01:1);


[M N]=size(X);
Z=zeros(M,N);
for i=1:M
    for j=1:N
        L=[X(i,j) Y(i,j) 0 0 0];
        o=Test14(L);
        o1(i,j)=o(1,1);
        o2(i,j)=o(1,2);
    end
end
figure
surfc(X,Y,o1,'LineStyle','none')
shading interp
box('on');
grid('off');
axis tight
%colormap('Gray');
%light;
%lighting phong;
%camlight headlight
%camlight left
%shading interp
set(0, 'DefaultAxesFontName', 'Times')
set(gca,'FontAngle','italic')


%figure
hold on
surfc(X,Y,o2,'LineStyle','none')
shading interp
box('on');
grid('off');
axis tight
%colormap('Gray');
%light;
%lighting phong;
%camlight headlight
%camlight left
%shading interp
set(0, 'DefaultAxesFontName', 'Times')
set(gca,'FontAngle','italic')

xlabel('x1');
ylabel('x2');

%Draw objective space

x=0:0.005:1;
dim=size(x,2);

y=zeros(1,dim);

figure
hold on

n=6;
period=1/(pi*n);


for N=1:n
    clear LF
    clear LS
    index=0;
    for i=1:dim
        index=index+1;
        
        PS=[x(i) 0 0 0 0];
        RS=[x(i) 1 0 0 0 ];
        PF(:,index)=Test14(PS);
        RF(:,index)=Test14(RS);
        
        LS=[x(i) N*pi*period 0 0 0];
        LF(:,index)=Test14(LS);
        
    end
    index=0;
    for inew=1:dim-1
        index=index+1;
        flag=0;
        for j=1:index
            if Dominates(PF(:,j)', PF(:,inew)')
                flag=1;
            end
        end
        if flag==0
            %line([LF(1,inew) LF(1,inew+1)],[LF(2,inew) LF(2,inew+1)] , 'Color', 'k', 'LineWidth',4)
            line([LF(1,inew) LF(1,inew+1)],[LF(2,inew) LF(2,inew+1)] , 'Color', 'k')
        else
            if mod(inew,4)==0
                %  line([LF(1,inew) LF(1,inew+1)],[LF(2,inew) LF(2,inew+1)] , 'Color', 'k','LineStyle', '-.', 'MarkerSize',1)
            end
        end
    end
    
end

My_RF=zeros(2,dim);
My_RF(1,1)=0;
My_RF(1,dim)=0;

for i=1:dim
    if i==1
        My_RF(1,i)=LF(1,i);
        My_RF(2,i)= 1*(abs(LF(2,i)-LF(2,i+1))+abs(LF(1,i)-LF(1,i+1)));
    end
    
    if i==dim
        My_RF(1,i)=LF(1,i);
        My_RF(2,i)= 1*(abs(LF(2,i)-LF(2,i-1))+abs(LF(1,i)-LF(1,i-1)));
    end
    
    if i~=1 && i~=dim
        My_RF(1,i)=LF(1,i);
        My_RF(2,i)= 1*(abs(LF(2,i)-LF(2,i-1))+abs(LF(2,i)-LF(2,i+1))+...
            abs(LF(1,i)-LF(1,i-1))+abs(LF(1,i)-LF(1,i+1)));
    end
end


% figure
%plot(PF(1,:),PF(2,:),'rx');
for i=1:dim-1
    
    line([My_RF(1,i) My_RF(1,i+1)],[My_RF(2,i) My_RF(2,i+1)] , 'Color', [1 0 0])
    %plot(My_RF(1,i),My_RF(2,i),'Marker','.','MarkerSize',15,'Color',[0.5 0.5 0.5]);
    
    hold on
end
%plot(PF(1,:),PF(2,:),'rx');

index=0;
for i=1:dim-1
    index=index+1;
    flag=0;
    for j=1:index
        if Dominates(PF(:,j)', PF(:,i)')
            flag=1;
        end
    end
    if  flag==0;
        % line([PF(1,i) PF(1,i+1)],[PF(2,i) PF(2,i+1)] , 'Color', 'k', 'LineWidth',4)
        line([PF(1,i) PF(1,i+1)],[PF(2,i) PF(2,i+1)] , 'Color', 'k')
        flag=1;
    else
        if mod(i,4)==0
            %line([PF(1,i) PF(1,i+1)],[PF(2,i) PF(2,i+1)] , 'Color', 'k','LineStyle', '-.', 'MarkerSize',1)
        end
    end
    %line([PF(1,i) PF(1,i+1)],[PF(2,i) PF(2,i+1)] , 'Color', 'k')
    hold on
    
end

box on
xlabel('f1');
ylabel('f2');
zlabel('f3');
set(gca,'FontAngle','italic')
%
%
%
%   for i=1:dim-1
%
%      line([RF_01(1,i) RF_01(1,i+1)],[RF_01(2,i) RF_01(2,i+1)] , 'Color', 'k')
%      hold on
%
%   end
%
%     for i=1:dim-1
%
%      line([RF_007(1,i) RF_007(1,i+1)],[RF_007(2,i) RF_007(2,i+1)] , 'Color', 'k')
%      hold on
%
%     end
%
%       for i=1:dim-1
%
%      line([RF_008(1,i) RF_008(1,i+1)],[RF_008(2,i) RF_008(2,i+1)] , 'Color', 'k')
%      hold on
%
%       end
%
%         for i=1:dim-1
%
%      line([RF_009(1,i) RF_009(1,i+1)],[RF_009(2,i) RF_009(2,i+1)] , 'Color', 'k')
%      hold on
%         end
%
%         xlabel('o_1');
%         ylabel('o_2');
%
%


