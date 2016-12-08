function []=DrawRobustnessSurface (PF_temp,dim,amplitude)

My_RF=zeros(3,dim);
My_RF(1,1)=0;
My_RF(1,dim)=0;
My_RF(2,1)=0;
My_RF(2,dim)=0;

index=0;
for i=2:dim-1
     for j=2:dim-1
         index=index+1;
         
        My_RF(1,index)=PF_temp(i,j,1);
        My_RF(2,index)=PF_temp(i,j,2);
        My_RF(3,index)= amplitude*(abs(PF_temp(i,j,3)-PF_temp(i-1,j,3))+ abs(PF_temp(i,j,3)-PF_temp(i+1,j,3))+ abs(PF_temp(i,j,3)-PF_temp(i,j-1,3))+ abs(PF_temp(i,j,3)-PF_temp(i,j+1,3))+...
                            abs(PF_temp(i,j,2)-PF_temp(i-1,j,2))+ abs(PF_temp(i,j,2)-PF_temp(i+1,j,2))+ abs(PF_temp(i,j,2)-PF_temp(i,j-1,2))+ abs(PF_temp(i,j,2)-PF_temp(i,j+1,2))+...
                            abs(PF_temp(i,j,1)-PF_temp(i-1,j,1))+ abs(PF_temp(i,j,1)-PF_temp(i+1,j,1))+ abs(PF_temp(i,j,1)-PF_temp(i,j-1,1))+ abs(PF_temp(i,j,1)-PF_temp(i,j+1,1)));
     end
end



dim2=dim-2;
c=1;
 for i=1:size(My_RF,2)-1
     if mod(i,dim2)==0
         c=c+1;
         line([My_RF(1,i) My_RF(1,c*dim2+mod(i,dim2))],...
             [My_RF(2,i) My_RF(2,c*dim2+mod(i,dim2))]...
             , [My_RF(3,i) My_RF(3,c*dim2+mod(i,dim2))] , 'Color', 'r')
     end
     hold on
     if mod(i,dim2)~=0
         line(My_RF(1,i:i+1),My_RF(2,i:i+1), My_RF(3,i:i+1) , 'Color', 'r' )
         if c<dim2
             line([My_RF(1,i) My_RF(1,c*dim2+mod(i,dim2))],...
             [My_RF(2,i) My_RF(2,c*dim2+mod(i,dim2))]...
             , [My_RF(3,i) My_RF(3,c*dim2+mod(i,dim2))] , 'Color', 'r')
         end
        
     end
     
 end