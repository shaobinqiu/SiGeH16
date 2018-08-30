clear

all=load('allC10.txt');
allfre=load('allfrequency.txt');
allfre=allfre*10^12;%unit conversion

alls=[];
for ii=1:size(all,1)
    E0=all(find(all(:,1)==ii-1),:);
        alls=[alls
            E0];
end%sort by n_Si    [n_Si    degeneracy    E_vasp    deltaH]

all_sortH=sortrows(alls,4);%just sort by deltaH

T=10:10:2000;
h=6.63*10^(-34)/(1.6*10^(-19))/2/3.14; 
k=1.38*10^(-23)/(1.6*10^(-19));

Z_all=[];
for ii= 1:size(T,2)
    Z=[];
for jj=1:size(alls,1)
    z=exp(-alls(jj,4)/k/T(ii));
    for kk=1:size(allfre,2)
        z=z*(exp(-h*allfre(jj,kk)/(2*k*T(ii)))/(1-exp(-h*allfre(jj,kk)/(k*T(ii)))));
    end
    Z=[Z;z];
end
Z_all=[Z_all   Z];
end%%% Z = sum(g_i*z_i)        z_i from $9.7 wangzhicheng

E_n=[];
for ll=1:size(Z_all,2)
    en=Z_all(:,ll)'*(alls(:,1).*alls(:,2))/(Z_all(:,ll)'*alls(:,2));
    E_n=[E_n en];
end%expectation of n_Si
%plot(T,E_n)

Z_all_norm=Z_all;
for xx=1:size(Z_all,2)
    Z_all_norm(:,xx)=Z_all(:,xx)/(Z_all(:,xx)'*alls(:,2));
end%normalization

Z_n=[];
for ss=0:10
    z_n=zeros(1,size(T,2));
    for tt=1:size(Z_all_norm,1)
        if alls(tt,1)==ss
            z_n=z_n+alls(tt,2)*Z_all_norm(tt,:);
        end
    end
    Z_n=[Z_n ;z_n];
end%sum the Z of same n_Si

c=rand(11,3);
    for uu=1:size(Z_n,1)
        plot(T,Z_n(uu,:),'*-','color',c(uu,:))
        hold on
    end
    legend('show')
