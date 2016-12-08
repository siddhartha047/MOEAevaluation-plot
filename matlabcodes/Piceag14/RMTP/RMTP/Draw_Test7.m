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

% Bechmark function name in the paper: Test7
clc
clear all

%Draw Search space

[X,Y] = meshgrid(0:0.01:2);


[M N]=size(X);
Z=zeros(M,N);
for i=1:M
    for j=1:N
        L=[X(i,j) Y(i,j)];
        o=Test7(L);
        o1(i,j)=o(1,1);
        o2(i,j)=o(1,2);
    end
end
figure
surfc(X,Y,o1,'LineStyle','none')
%shading interp
box('on');
grid('off');
axis tight
%colormap('Gray');
%light;
%lighting phong;
%camlight headlight
%camlight left
shading interp
set(0, 'DefaultAxesFontName', 'Times')
set(gca,'FontAngle','italic')

%figure
hold on
surfc(X,Y,o2,'LineStyle','none')
%shading interp
box('on');
grid('off');
axis tight
%colormap('Gray');
%light;
%lighting phong;
%camlight headlight
%camlight left
shading interp
set(0, 'DefaultAxesFontName', 'Times')
set(gca,'FontAngle','italic')

% xlabel('x1');
% xlabel('x2');
%Draw objective space

x=0.03:0.01:1.99;



dim=size(x,2);

y=zeros(1,dim);

index=0;

for i=1:dim
    index=index+1;
    
    PS=[x(i) 0.5 0 0 0];
    LS=[x(i) 1.5 0 0 0];
    
    PF(:,index)=Test7(PS);
    LF(:,index)=Test7(LS);
    
    %RF_03(:,index)=MTP3_RF(PS,[0.03 0.03 0.06 0.06 0.06]);
    % LRF_03(:,index)=MTP3_RF(LS,[0.03 0.03 0.06 0.06 0.06]);
    %             RF_005(:,index)=MTP3_RF(PS,[0.005 0.010 0.010 0.010 0.010 ])
    %             RF_006(:,index)=MTP3_RF(PS,[0.006 0.012 0.012 0.012 0.012])
    %             RF_007(:,index)=MTP3_RF(PS,[0.007 0.014 0.014 0.014 0.014])
    
end

%grid on
My_RF=zeros(2,dim);
My_RF(1,1)=0;
My_RF(1,dim)=0;

for i=2:dim-1
    My_RF(1,i)=LF(1,i);
    My_RF(2,i)= 25*(abs(LF(2,i)-LF(2,i-1))+abs(LF(2,i)-LF(2,i+1))+...
        abs(LF(1,i)-LF(1,i-1))+abs(LF(1,i)-LF(1,i+1)));
end

figure

for i=2:dim-2
    
    line([My_RF(1,i) My_RF(1,i+1)],[My_RF(2,i) My_RF(2,i+1)] , 'Color', 'r')
    hold on
end

%plot(PF(1,:),PF(2,:),'rx');

for i=1:dim-1
    
    line([PF(1,i) PF(1,i+1)],[PF(2,i) PF(2,i+1)] , 'Color', 'k')
    hold on
    line([LF(1,i) LF(1,i+1)],[LF(2,i) LF(2,i+1)] , 'Color', 'k')
    
end

%

%   for i=1:dim-1
%
%      line([RF_03(1,i) RF_03(1,i+1)],[RF_03(2,i) RF_03(2,i+1)] , 'Color', 'k')
%      hold on
%      line([LRF_03(1,i) LRF_03(1,i+1)],[LRF_03(2,i) LRF_03(2,i+1)] , 'Color', 'k')
%
%   end
% %
ylim ([-1 1.6])
box on
xlabel('f_1');
ylabel('f_2');
