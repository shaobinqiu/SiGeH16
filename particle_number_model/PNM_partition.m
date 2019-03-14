clear%%%bond energy model
% % close all
all_inf=load('./all_PNM.txt');
h=6.63*10^(-34)/(1.6*10^(-19))/2/3.14; 
k=1.38*10^(-23)/(1.6*10^(-19));
T_max=1000;
dT=10;
T=10:dT:T_max;
n_mu_T=[];
dmu=0.001;
delta_mu=[-1.5:dmu:-0.7];%%plot predict phase diagram n_str_max=zeros(size(delta_mu,2),T_max/10);
 [n_mu_T, n_str_max]=PF_nfre(all_inf, T, delta_mu, 0.3);
%%%%%%%%%
%plot n_i(delta_mu, T)
%%%%%%%%%%
figure
set(gcf,'color','white');
n_mu_T= imrotate(n_mu_T,90);
 image(n_mu_T,'CDataMapping','scaled')
%imshow(n_mu_T,[])
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n_mu_T= imrotate(n_mu_T,270);
n_Si=[0.5:0.1:9.5];
n_str_max=zeros(size(n_Si,2),size(T,2));
delta_mu1=zeros(size(n_Si,2),size(T,2));
err=0;
p=[];
for zz=1:size(n_Si,2)
    zz
Z_all_inf=[];
for ii=1:size(T,2)
    
%         d=1;u=size(n_mu_T,1);
%         for bb=1:16
%         if n_Si(1,zz)<n_mu_T(round(0.5*(u+d)),ii)
%          u=floor(0.5*(u+d));
%         else
%            d=floor(0.5*(u+d));
%         end
%         end
%          if u~=1 && u~=size(n_mu_T,1)
%              delta_mu1(zz,ii)=min(delta_mu)+(u-1)*dmu;
%          end
    
    for yy=1:size(n_mu_T,1)-1
        if n_Si(1,zz)>=n_mu_T(yy,ii) && n_Si(1,zz)<=n_mu_T(yy+1,ii)
           delta_mu1(zz,ii)=min(delta_mu)+(yy-1)*dmu;
        end
    end
    if delta_mu1(zz,ii)==0
        err=err+1;
    end%%%could find n_Si
H=all_inf(:,2)*delta_mu1(zz,ii)-all_inf(:,3);
H=H-max(H)*ones(size(H,1),1);
H=-H;
        z_i=[];
        for rr=1:size(H,1)
            z=exp(-H(rr,1)/k/T(ii));
            z_i=[z_i;z];
        end
Z_all_inf=[Z_all_inf   z_i];
end%%% Z = sum(g_i*z_i)        z_i from $9.7 wangzhicheng

Z_all_inf_norm=Z_all_inf;
for xx=1:size(Z_all_inf,2)
    Z_all_inf_norm(:,xx)=Z_all_inf(:,xx).*all_inf(:,4)/(Z_all_inf(:,xx)'*all_inf(:,4));
end%normalization

[x,m]=max(Z_all_inf_norm);
p=[p;x];
for ww=1:size(x,2)
if x(1,ww)>0.3%%%%structure which is more than 30% and dominant
n_str_max(zz,ww)=m(1,ww);
else
n_str_max(zz,ww)=0;
end
end

end
err
 n_str_max= imrotate(n_str_max,90);
 p= imrotate(p,90);
% delta_mu1= imrotate(delta_mu1,90);

 te=unique(n_str_max);
 n_str_max_p=zeros(size(n_str_max,1),size(n_str_max,2));
  for ii=1:size(n_str_max,1)
     for jj=1:size(n_str_max,2)
       n_str_max_p(ii,jj)=find(te==n_str_max(ii,jj));
     end
  end
  bon=[];
 for xx=1:size(n_str_max,1)-1
     xx
     for yy=1:size(n_str_max,2)
         if n_str_max(xx,yy) ~= n_str_max(xx+1,yy)
             bon=[bon;xx yy];
         end
     end
 end
  
  
 figure 
 set(gcf,'color','white');
 image(n_str_max_p,'CDataMapping','scaled')
 title('predict phase(>30%)')
xlabel('n_{V}')
ylabel('Temperature(K)')
colorbar
n_x=5;
n_y=5;
xl={};
for ii=1:n_x
    xl=[xl num2str(roundn((min(n_Si)+(ii-1)*(max(n_Si)-min(n_Si))/(n_x-1))/max(all_inf(:,2)),-2))]; 
end
yl={};
for ii=1:n_y
    yl=[yl num2str(max(T)-(ii-1)*max(T)/(n_y-1))]; 
end
set(gca,'XTick',1:(size(n_str_max_p,2)-1)/(n_x-1):size(n_str_max_p,2));
set(gca,'XTicklabel',xl)
set(gca,'YTick',1:(size(n_str_max_p,1)-1)/(n_y-1):size(n_str_max_p,1));
set(gca,'YTicklabel',yl)
