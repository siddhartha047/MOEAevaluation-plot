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

% Bechmark function name in the paper: Test17
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
        o=Test17(L);
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


%Draw objective space

x=0:0.005:1;
dim=size(x,2);

y=zeros(1,dim);

index=0;

for i=1:dim
    index=index+1;
    
    PS=[x(i) 0 0 0 0];
    PF(:,index)=Test17(PS);
    %RF_01(:,index)=MTP1_RF(PS,[0.01 0.02 0.02 0.02 0.02]);
    % RF_007(:,index)=MTP1_RF(PS,[0.007 0.014 0.014 0.014 0.014 ]);
    % RF_008(:,index)=MTP1_RF(PS,[0.008 0.016 0.016 0.016 0.016]);
    % RF_009(:,index)=MTP1_RF(PS,[0.009 0.018 0.018 0.018 0.018]);
    
end

My_RF=zeros(2,dim);
My_RF(1,1)=0;
My_RF(1,dim)=0;

for i=1:dim
    if i==1
        My_RF(1,i)=PF(1,i);
        My_RF(2,i)= 3*2*(abs(PF(2,i)-PF(2,i+1))+abs(PF(1,i)-PF(1,i+1)));
    end
    
    if i==dim
        My_RF(1,i)=PF(1,i);
        My_RF(2,i)= 3*2*(abs(PF(2,i)-PF(2,i-1))+abs(PF(1,i)-PF(1,i-1)));
    end
    
    if i~=1 && i~=dim
        My_RF(1,i)=PF(1,i);
        My_RF(2,i)= 3*(abs(PF(2,i)-PF(2,i-1))+abs(PF(2,i)-PF(2,i+1))+...
            abs(PF(1,i)-PF(1,i-1))+abs(PF(1,i)-PF(1,i+1)));
    end
end


figure
%plot(PF(1,:),PF(2,:),'rx');
for i=1:dim-1
    
    line([My_RF(1,i) My_RF(1,i+1)],[My_RF(2,i) My_RF(2,i+1)] , 'Color', [1 0 0])
    %       plot(My_RF(1,i),My_RF(2,i),'Marker','.','MarkerSize',15,'Color',[0.5 0.5 0.5]);
    
    hold on
end

for i=1:dim-1
    
    line([PF(1,i) PF(1,i+1)],[PF(2,i) PF(2,i+1)] , 'Color', 'k')
    hold on
    
end

box on
xlabel('f_1');
ylabel('f_2');
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


