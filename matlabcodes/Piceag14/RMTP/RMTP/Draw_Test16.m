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

% Bechmark function name in the paper: Test16
clc
clear all

%Draw Search space

[X,Y] = meshgrid(0:0.01:1); 


[M N]=size(X);
Z=zeros(M,N);
for i=1:M
    for j=1:N
        L=[X(i,j) Y(i,j) 0 0 0];
        o=Test16(L);
        o1(i,j)=o(1,1);
        o2(i,j)=o(1,2);
        o3(i,j)=o(1,3);
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
%shading interp
set(0, 'DefaultAxesFontName', 'Times') 
set(gca,'FontAngle','italic')

hold on
%figure
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
%shading interp
set(0, 'DefaultAxesFontName', 'Times') 
set(gca,'FontAngle','italic')

hold on
%figure
surfc(X,Y,o3,'LineStyle','none')
%shading interp
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


x=0:0.04:1;
y=0:0.04:1;

dim=size(x,2);


index=0;

for i=1:dim
    for j=1:dim
       % for k=1:11
            index=index+1;
            
            PS=[x(i) y(j) 0 0 0];
            PF(:,index)=Test16(PS);
           % RF(:,index)=MTP5_RF(PS,[0.01 0.01 0.02 0.02 0.02]);
           PF_temp(i,j,:)=PF(:,index)';
       % end
    end
end

%figure
%surf(PF(1,:),PF(2,:),PF(3,:));

figure
% DrawRobustnessSurface (PF_temp,dim,2)
%plot3(PF(1,:),PF(2,:),PF(3,:),'rx');

index=0;
c=1;
 for i=1:size(PF,2)-1
     index=index+1;
     flag=0;
     if mod(i,dim)==0
         for j=1:index
            if Dominates(PF(:,j)',PF(:,i)')
             flag=1;
            end
         end
         c=c+1;
         if flag==0
         line([PF(1,i) PF(1,c*dim+mod(i,dim))],...
             [PF(2,i) PF(2,c*dim+mod(i,dim))]...
             , [PF(3,i) PF(3,c*dim+mod(i,dim))] , 'Color', 'k')
         end
     end
     hold on
     flag=0;
     if mod(i,dim)~=0
         for j=1:index
            if Dominates(PF(:,j)',PF(:,i)')
             flag=1;
            end
         end
         if flag==0
         line(PF(1,i:i+1),PF(2,i:i+1), PF(3,i:i+1) , 'Color', 'k' )
         end
         
          flag=0;
         if c<dim
            for j=1:index
                if Dominates(PF(:,j)',PF(:,i)')
                flag=1;
                end
            end
             if flag==0
             line([PF(1,i) PF(1,c*dim+mod(i,dim))],...
             [PF(2,i) PF(2,c*dim+mod(i,dim))]...
             , [PF(3,i) PF(3,c*dim+mod(i,dim))] , 'Color', 'k')
             end
         end
        
     end
     
 end
 
 
box on
xlabel('f1');
ylabel('f2');
zlabel('f3');
view([127 32]);
 