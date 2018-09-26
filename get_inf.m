clear%%%%[delta_mu   T    n_si    z_i*g_i]        93 columns
all=load('./inf_ya/all_inf.txt');
degener=load('Ge10_degener.txt');

delete(gcp('nocreate'))
CoreNum=4; %调用的处理器个数
parpool('local',CoreNum);

T_max=2000;
T=T_max:-10:10;
Fre=all(:,4:75)*10^12;%unit conversion
Fre=repmat(all(1,4:75),90,1)*10^12;

n_mu_T=[];
%delta_mu=[-1.5:0.001:-0.7];%%mu_Si-mu_Ge
delta_mu=[-1.5:0.01:-0.7];%%plot predict phase diagram 

inf=[];
tic
parfor zz=1:size(delta_mu,2)
    zz
H=all(:,2)*delta_mu(1,zz)-all(:,3);
H=H-max(H)*ones(size(H,1),1);
H=-H;
for ii= 1:size(T,2)
z_i=partitionf(H,Fre,T(ii));
z_i_normal=z_i.*degener/(z_i'*degener);
E_n=all(:,2)'*z_i_normal;
inf=[inf;[delta_mu(1,zz)   T(ii)    E_n    z_i_normal' ]];
end%%% Z = sum(g_i*z_i)        z_i from $9.7 wangzhicheng
end
toc
% save inf.txt inf -ascii
P=[];
for ii=1:size(delta_mu,2)
    p=[];
    for jj=1:size(T,2)
        p=[p;inf((ii-1)*size(T,2)+jj,3)];
    end
    P=[P p];
end
image(P,'CDataMapping','scaled')
delete(gcp('nocreate'))