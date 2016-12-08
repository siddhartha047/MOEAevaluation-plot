function s=calculateSU(P1,dim)                
                fmax=max(P1,[],1);
                %if(~all(fmax))
                fmax=fmax+.000001;
                %end
                fmin=min(P1);
                C2=rand(10000,dim);
                C2=bsxfun(@times,C2,(fmax-fmin));
                C2=bsxfun(@rdivide,C2,(fmax-fmin));
                
                P2=bsxfun(@minus,P1,fmin);
                P2=bsxfun(@rdivide,P2,(fmax-fmin));
                SU2=0;
                
                for i=1:size(C2,1)
                    temp2=bsxfun(@minus,C2(i,:),P2);
                    temp2=power(temp2,2);
                    temp2=sum(temp2,2);
                    temp2=sqrt(temp2);
                    SU2=SU2+min(temp2);
                end
                s=SU2/size(C2,1);

end