
function  IGD  = calculateIGD(PF,fit);
% calculate IGD metric 
% fit: popSize*M  
% PF: pfSize*M  

[popSize, M]= size(fit);
pfSize =  size(PF,1);

for i=1:pfSize
  for j=1:popSize
      D(i,j) = norm(PF(i,:)-fit(j,:),2); 
  end 
  Dmin(i,:) = min(D(i,:));  
end

IGD = sqrt(sum(Dmin.^2))/pfSize;

%{
function [ IGD ] = calculateIGD( Ref, P1 )                
                IGD2=0;
                mn = min(Ref);
                mx = max(Ref);
              
                %disp(mx);
                normalized_P1 = gdivide((gsubtract(P1,mn)),(mx - mn));
                %disp(max(normalized_P1));
                %disp(min(normalized_P1));
                normalized_Ref = gdivide((gsubtract(Ref,mn)),(mx - mn));

                for i=1:size(Ref,1)
                    temp2=bsxfun(@minus,normalized_Ref(i,:),normalized_P1);
                    temp2=power(temp2,2);
                    temp2=sum(temp2,2);
                    temp2=sqrt(temp2);
                    IGD2=IGD2+power(min(temp2),2);
                end

                IGD=sqrt(IGD2)/size(Ref,1);                
end
%}
