function  GD  = calculateGD(PF,fit);
% calculate GD metric 
% fit: popSize*M     
% PF: pfSize*M       

[popSize, M]= size(fit);  
pfSize =  size(PF,1);

for i=1:popSize
  for j=1:pfSize
      D(i,j) = norm(fit(i,:)-PF(j,:),2); 
  end
  Dmin(i,:) = min(D(i,:));   
end

GD = sqrt(sum(Dmin.^2))/popSize;


%{
function [ GD ] = calculateGD( Ref, P1)    
    


    GD2=0;
    mn = min(Ref);
    mx = max(Ref);
    %disp(mn);
    %disp(mx);
    
    
    normalized_P1 = gdivide((gsubtract(P1,mn)),(mx - mn));
    %disp(max(normalized_P1));
    %disp(min(normalized_P1));
    normalized_Ref = gdivide((gsubtract(Ref,mn)),(mx - mn));
    
    for i=1:size(P1,1)
        temp2=bsxfun(@minus,normalized_P1(i,:),normalized_Ref);
        temp2=power(temp2,2);
        temp2=sum(temp2,2);
        temp2=sqrt(temp2);
        GD2=GD2+power(min(temp2),2);
    end
    
    GD=sqrt(GD2)/size(P1,1);
    
end
%}

