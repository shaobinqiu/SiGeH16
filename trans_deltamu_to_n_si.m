% clear%%%%get(n_i,T,delta_mu)
% %close all
% all=load('./inf_ya/all_inf.txt');
% degener=load('Ge10_degener.txt');
% T_max=1200;
% T=10:1:T_max;
% Fre=repmat(all(1,4:75),90,1)*10^12;
% n_mu_T=load('n_mu_T.txt');
%  Fre=all(:,4:75)*10^12;%unit conversion
%  n_mu_T=load('n_mu_T_vib.txt');
% 
% 
% n_Si=[0.5:0.01:9.5];
% 
% delete(gcp('nocreate'))
% CoreNum=3; %调用的处理器个数
% parpool('local',CoreNum);
% 
% n_str_max=zeros(size(n_Si,2),size(T,2));
% delta_mu=zeros(size(n_Si,2),size(T,2));
% err=0;
% p=[];
% for zz=1:size(n_Si,2)
%     zz
% Z_all=[];
% parfor ii=1:size(T,2)
%     for yy=1:size(n_mu_T,1)-1
%         if n_Si(1,zz)>=n_mu_T(yy,ii) && n_Si(1,zz)<=n_mu_T(yy+1,ii)
%            delta_mu(zz,ii)=-1.5+(yy-1)*0.001;
%         end
%     end
%     if delta_mu(zz,ii)==0
%         err=err+1;
%     end%%%could find n_si
% H=all(:,2)*delta_mu(zz,ii)-all(:,3);
% H=H-max(H)*ones(size(H,1),1);
% H=-H;
% z_i=partitionf(H,Fre,T(ii));
% Z_all=[Z_all   z_i];
% end%%% Z = sum(g_i*z_i)        z_i from $9.7 wangzhicheng
% 
% Z_all_norm=Z_all;
% for xx=1:size(Z_all,2)
%     Z_all_norm(:,xx)=Z_all(:,xx).*degener/(Z_all(:,xx)'*degener);
% end%normalization
% 
% [x,m]=max(Z_all_norm);
% p=[p;x];
% for ww=1:size(x,2)
% if x(1,ww)>0.3%%%%structure which is more than 30% and dominant
% n_str_max(zz,ww)=m(1,ww);
% else
% n_str_max(zz,ww)=0;
% end
% end
% 
% end
% err

% delete(gcp('nocreate'))
% save n_str_max_ni_T_vib.txt n_str_max -ascii
% save p_vib.txt p -ascii
%  n_str_max= imrotate(n_str_max,90);
%  p= imrotate(p,90);
% delta_mu= imrotate(delta_mu,90);
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
 image(delta_mu,'CDataMapping','scaled')
 hold on
% plot(bon(:,2),bon(:,1),'r.','MarkerSize',1)
  for ii=1:11
    text(-70,ii*100,num2str(1200-ii*100),'FontSize',10)
    
end
for ii=1:9
text(ii*100-15,1240,num2str((0.5+ii*1)/10),'FontSize',10)
end
% text(100,1000,'2','FontSize',10)
% text(420,1050,'53','FontSize',10)
% text(550,1100,'70','FontSize',10)
% text(660,1100,'76','FontSize',10)
% text(750,1000,'85','FontSize',10)
% text(830,1000,'88','FontSize',10)
% text(860,300,'89','FontSize',10)
% text(15,600,'90','FontSize',10)
text(-50,0,'T/K','FontSize',12)
text(950,1200,'n','FontSize',12)
title('predict phase(>30%)')
 axis off