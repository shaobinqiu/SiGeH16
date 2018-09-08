clear%%%%

all=load('./inf_ya/all_inf.txt');
degener=load('Ge10_degener.txt');
occupy=load('occupies.txt');
sro=load('sro.txt');


T_max=13000;
T=10:10:T_max;
Fre=all(:,4:75)*10^12;%unit conversion
%Fre=repmat(all(1,4:75),90,1)*10^12;

n_mu_T=[];
n_str_max=zeros(200,T_max/10);
for zz=1:200
delta_mu=-2+0.01*zz;%%mu_Si-mu_Ge
H=all(:,2)*delta_mu-all(:,3);
H=H-max(H)*ones(size(H,1),1);
H=-H;

Z_all=[];
for ii= 1:size(T,2)
z_i=partitionf(H,Fre,T(ii));
Z_all=[Z_all   z_i];
end%%% Z = sum(g_i*z_i)        z_i from $9.7 wangzhicheng

Z_all_norm=Z_all;
for xx=1:size(Z_all,2)
    Z_all_norm(:,xx)=Z_all(:,xx)/(Z_all(:,xx)'*degener);
end%normalization

[x,m]=max(Z_all_norm);
n_str_max(zz,:)=m;


E_n=[];
for ll=1:size(Z_all,2)
    en=Z_all(:,ll)'*(all(:,2).*degener)/(Z_all(:,ll)'*degener);
    E_n=[E_n en];
end%expectation of n_Si
% figure(1)
% plot(T,E_n)
% title('number of Si')

n_mu_T=[n_mu_T;E_n];
end
figure(2)
image(n_mu_T*6)


% Z_all_norm=Z_all;
% for xx=1:size(Z_all,2)
%     Z_all_norm(:,xx)=Z_all(:,xx)/(Z_all(:,xx)'*degener);
% end%normalization
% 
% Z_n=[];
% for ss=0:10
%     z_n=zeros(1,size(T,2));
%     for tt=1:size(Z_all_norm,1)
%         if all(tt,2)==ss
%             z_n=z_n+degener(tt,1)*Z_all_norm(tt,:);
%         end
%     end
%     Z_n=[Z_n ;z_n];
% end%sum the Z of same n_Si
% figure(2)
% c=rand(11,3);
%     for uu=1:11%1:size(Z_n,1)
%         plot(T,Z_n(uu,:),'*-','color',c(uu,:))
%         hold on
%     end
%     legend('show')
%     title('contribution of  structurewith n_i Si')
%     
%  figure(3)
% O_T=occupy'*Z_all_norm;
% for ss=1:size(O_T,1)
%     plot(T,O_T(ss,:),'-','color',c(ss,:))
%         hold on
%     end
%     legend('show')
%     title('occupy of each point')
% 
% figure(4)
% for tt=1:size(sro,1)
%     sro(tt,:)=sro(tt,:)*degener(tt,1);
% end
% sro_T=sro'*Z_all_norm;
% for uu=1:2%size(sro_T,1)
%     plot(T,sro_T(uu,:),'-','color',c(uu,:))
%         hold on
%     end
%     legend('show')
%     title('sro')
% 
% %%%%free energy
% T_i=1000;
% F=[];
% for vv=1:size(all,1)
%     f=H(vv,1);
%     for xx=1:size(allfre,2)
%         f=f+h*allfre(vv,xx)*0.5+k*T_i*log(1-exp(-h*allfre(vv,xx)/k/T_i));
% 
%     end
%     F=[F;f];
% end
% figure(5)
% plot(all(:,2),F,'*')
% title('free energy')




















