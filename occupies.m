clear%%%%%%%caculate the occupation of each point (sum with same probability)
table=load('Ge10_table.txt');
str=load('Ge10_str.txt');
str=[str;0 0 0 0 0 0 0 0 0 0];
a=0
occupy=zeros(size(str,1),size(str,2));
for ii=1:size(str)
     s=str(ii,:);
     s(s==0)=[];
     tmp=table(:,s);
     degen_s=[];
     if size(tmp,2)~=0
         for jj=1:size(tmp,1)
             t=sort(tmp(jj,:))
             degen_s=[degen_s;t];
         end
     else
         degen_s=zeros(1,10);
     end
     degen_s=unique(degen_s,'rows');
     a=a+size(degen_s,1)
     for kk=1:size(degen_s,1)
         for ll=1:size(str,2)
             if ismember(ll,degen_s(kk,:))==1
                 occupy(ii,ll)=occupy(ii,ll)+1;
             end
         end
     end
                 
end
save occupies.txt occupy -ascii



