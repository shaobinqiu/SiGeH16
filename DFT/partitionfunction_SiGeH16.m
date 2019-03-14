 clear%%%%
% % close all
all=load('../inf_ya/all_inf.txt');
degener=load('../Ge10_degener.txt');
all_inf=[all(:,1:3) degener];
save all_inf_DFT.txt all_inf -ascii
T_max=1000;
dT=10;
T=10:dT:T_max;
Fre=all(:,4:75)*10^12;%unit conversion
save frequency.txt Fre -ascii
Fre=repmat(all(1,4:75),90,1)*10^12;
%delta_mu=[-1.5:0.001:-0.7];%%mu_Si-mu_Ge
n_mu_T=[];
dmu=0.001;
delta_mu=[-1.5:dmu:-0.8];%%plot predict phase diagram 

n_str_max=zeros(size(delta_mu,2),T_max/10);
for zz=1:size(delta_mu,2)
    zz
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
        Z_all_norm(:,xx)=Z_all(:,xx).*degener/(Z_all(:,xx)'*degener);
    end%normalization
    [x,m]=max(Z_all_norm);
    for ww=1:size(x,2)
        if x(1,ww)>0.3%%%%structure which is more than 30% and dominant
            n_str_max(zz,ww)=m(1,ww);
        else
            n_str_max(zz,ww)=0;
        end
    end
    E_n=[];
    for ll=1:size(Z_all,2)
        en=Z_all(:,ll)'*(all(:,2).*degener)/(Z_all(:,ll)'*degener);
        E_n=[E_n en];
    end
    n_mu_T=[n_mu_T;E_n];
end
save n_mu_T.txt n_mu_T -ascii

%plot%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%
%plot n_i(delta_mu, T)
%%%%%%%%%%
figure
set(gcf,'color','white');
n_mu_T= imrotate(n_mu_T,90);
image(n_mu_T,'CDataMapping','scaled')
title('n_{Si}(\Delta\mu, T)')
xlabel('\mu_{Si}-\mu_{Ge}(eV)')
ylabel('Temperature(K)')
colorbar
n_x=5;
n_y=5;
xl={};
for ii=1:n_x
    xl=[xl num2str(min(delta_mu)+(ii-1)*(max(delta_mu)-min(delta_mu))/(n_x-1))]; 
end
yl={};
for ii=1:n_y
    yl=[yl num2str(max(T)-(ii-1)*max(T)/(n_y-1))]; 
end
set(gca,'XTick',1:(size(n_mu_T,2)-1)/(n_x-1):size(n_mu_T,2));
set(gca,'XTicklabel',xl)
set(gca,'YTick',1:(size(n_mu_T,1)-1)/(n_y-1):size(n_mu_T,1));
set(gca,'YTicklabel',yl)
for ii=1:10
    alpha=ii-0.5;
    line_alpha=[];
    for ii=1:size(n_mu_T,1)
        for jj=1:size(n_mu_T,2)-1
            if n_mu_T(ii,jj)<=alpha && n_mu_T(ii,jj+1)>=alpha
                line_alpha=[line_alpha;ii,jj];
            end
        end
    end
    hold on 
    plot(line_alpha(:,2),line_alpha(:,1),'r-','MarkerSize',1)
end

            
 