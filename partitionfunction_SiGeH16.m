clear%%%%

all=load('./inf_ya/all_inf.txt');
degener=load('Ge10_degener.txt');
occupy=load('occupies.txt');
sro=load('sro.txt');
allfre=all(:,4:75)*10^12;%unit conversion
%allfre=repmat(all(1,4:75),90,1)*10^12;

H=all(:,3)-(all(:,2)*all(89,3)+(10*ones(90,1)-all(:,2))*all(90,3))/10;%deltaH

T=10:10:2000;
h=6.63*10^(-34)/(1.6*10^(-19))/2/3.14; 
k=1.38*10^(-23)/(1.6*10^(-19));

Z_all=[];
for ii= 1:size(T,2)
    Z=[];
for jj=1:size(all,1)
    z=exp(-H(jj,1)/k/T(ii));
    for kk=1:size(allfre,2)
        z=z*(exp(-h*allfre(jj,kk)/(2*k*T(ii)))/(1-exp(-h*allfre(jj,kk)/(k*T(ii)))));
    end
    Z=[Z;z];
end
Z_all=[Z_all   Z];
end%%% Z = sum(g_i*z_i)        z_i from $9.7 wangzhicheng



E_n=[];
for ll=1:size(Z_all,2)
    en=Z_all(:,ll)'*(all(:,2).*degener)/(Z_all(:,ll)'*degener);
    E_n=[E_n en];
end%expectation of n_Si
figure(1)
plot(T,E_n)

Z_all_norm=Z_all;
for xx=1:size(Z_all,2)
    Z_all_norm(:,xx)=Z_all(:,xx)/(Z_all(:,xx)'*degener);
end%normalization

Z_n=[];
for ss=0:10
    z_n=zeros(1,size(T,2));
    for tt=1:size(Z_all_norm,1)
        if all(tt,2)==ss
            z_n=z_n+degener(tt,1)*Z_all_norm(tt,:);
        end
    end
    Z_n=[Z_n ;z_n];
end%sum the Z of same n_Si
figure(2)
c=rand(11,3);
    for uu=1:size(Z_n,1)
        plot(T,Z_n(uu,:),'*-','color',c(uu,:))
        hold on
    end
    legend('show')
    
 figure(3)
O_T=occupy'*Z_all_norm;
for ss=1:2%size(O_T,1)
    plot(T,O_T(ss,:),'*-','color',c(ss,:))
        hold on
    end
    legend('show')

figure(4)
