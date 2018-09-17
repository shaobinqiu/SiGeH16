clear%%%%
close all
all=load('./inf_ya/all_inf.txt');
degener=load('Ge10_degener.txt');
occupy=load('occupies.txt');
sro=load('sro.txt');

T_max=1300;
T=10:10:T_max;
Fre=all(:,4:75)*10^12;%unit conversion
%Fre=repmat(all(1,4:75),90,1)*10^12;

n_mu_T=[];
delta_mu=[-1.5:0.01:-0.7];%%mu_Si-mu_Ge

n_str_max=zeros(size(delta_mu,2),T_max/10);
tic
for zz=35%1:size(delta_mu,2)
H=all(:,2)*delta_mu(1,zz)-all(:,3);
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
n_str_max(zz,:)=x;

E_n=[];
for ll=1:size(Z_all,2)
    en=Z_all(:,ll)'*(all(:,2).*degener)/(Z_all(:,ll)'*degener);
    E_n=[E_n en];
end
n_mu_T=[n_mu_T;E_n];
end

%%%%%%%%%%
%plot n_i(delta_mu, T)
%%%%%%%%%%
% figure
% set(gcf,'color','white');
% n_mu_T= imrotate(n_mu_T,90);
% image(n_mu_T,'CDataMapping','scaled')
% axis off
% title('n_{Si}(\Delta\mu, T)')
% text(85,140,'\mu_{Si}-\mu_{Ge}/ev','FontSize',14);
% text(-10,0,'T/K','FontSize',14);
% colorbar
% for ii=1:6
%     text(-7,ii*20-10,num2str(1400-ii*200),'FontSize',10)
%     
% end
% for ii=1:8
% text(ii*10-2,136,num2str(-1.5+ii*0.1),'FontSize',10)
% end
%%%%%%%%%%%

%%%%%%%%%%%
%plot n_Si(T)
%%%%%%%%%%%
% figure
% set(gcf,'color','white');
% plot(T,E_n)
% title('n_{Si}(\Delta=-1.15ev)')
% xlabel('T/k')
% ylabel('n_{Si}','Rotation',0)
%%%%%%%%%%%

%%%%%%%%%%%
%plot z_i(T) 10k 300k 600k 900k
%%%%%%%%%%%
% dir=[1,30,60,90];
% for xx=1:size(dir,2)
% figure 
% set(gcf,'color','white');
% bar([1:90],Z_all_norm(:,dir(1,xx)).*degener)
% sum(Z_all_norm(:,dir(1,xx)).*degener)
% title(['T=',num2str(dir(1,xx)*10),'k'])
% ylabel('p','Rotation',0)
% end
%%%%%%%%%%%%







