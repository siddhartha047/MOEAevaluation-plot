function [ P1 ] = readReferenceFileofSize( a,N)
               
                fid2 = fopen(a,'r');  % Open text file

                InputText=textscan(fid2,'%s','delimiter','\n');

                cell=InputText{1};
                %disp(cell(:,:));
                [m,n]=size(InputText{1});%m=num of row

                j1=1;

                format long;

                P1=[];

                while j1<=m

                    s=InputText{1}(j1);
                    b=cell2mat(s);
                    if(strcmp(b,'')==false)
                        c=[];
                        while true
                            [str b]= strtok(b);
                            if(strcmp(b,'')==true)
                                break; 
                            end
                            v=str2double(str);
                            c=cat(2,c,v);
                        end
                        P1=cat(1,P1,c);
                        j1=j1+1;
                    else
                        j1=j1+1;
                        break;
                    end
                end

                %format short;
                %disp(P1(:,:));

                P1=nondominated(P1);
                fclose(fid2);
end

