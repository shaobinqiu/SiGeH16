clear
str=load('Ge10_str.txt');
str=[str;zeros(1,10)];
molecule=load('Ge10H16.txt');
D_M=neighbor(molecule(1:10,:),1);
r=unique(D_M);
sro=zeros(90,3);
for  ii=1:size(str,1)
    for jj=1:size(D_M,1)
        for kk=2:size(r,1)-1
            n=0;
            s=0;
            for ll=1:size(D_M,2)
                if D_M(jj,ll)==r(kk)
                    if ismember(ll,str(ii,:))==1
                        s= s-1;
                    else
                        s= s+1;
                    end
                   n=n+1;
                end
            end
            sro(ii,kk-1)= sro(ii,kk-1)+s/n;
            if ismember(n,[2,3,4])==0
                hhh
            end
        end
        
    end
end
sro=sro/10;
save sro.txt sro -ascii