 clear%%%%get(n_i,T,delta_mu)
%close all
inf=load('./inf.txt');

T_max=1200;
T=10:1:T_max;
n_si=[0.5:0.1:9.5];

n_str_max=zeros(size(n_si,2),size(T,2));

for ii=1:size(n_si,2)
    for jj=1:size(T,2)
        t=19901-(T(jj)-10)*10;
        dir=[1:8001]*19901+repmat(t,8001,1);
        Z_tep=inf(dir,:);
        u=1;d=size(Z_tep);
        for zz=1:13%%%%%%find n_si by using dichotomy
            if u-d==1 || Z_tep(fix((u+d)/2),3)==n_si(1,ii)
              f=fix((u+d)/2);
            else if Z_tep(fix((u+d)/2),3)<n_si(1,ii)
                         d=fix((u+d)/2);
                     else
                         u=fix((u+d)/2);
                     end
              end
        end
       [x,m]=max(Z_tep(f,4:74));
        n_str_max(ii,jj)=m;
    end
end
        
        