clear
%1:8 SiH	GeH	SiSi	SiGe	GeGe	Sinum	Genum	Hnum	9:11 deg	 gap	E_DFT
inf_1=load('/home/qiusb/Desktop/temp/WYT/SiGe_energy/SiGe10.txt');
inf_2=load('/home/qiusb/Desktop/temp/WYT/SiGe_energy/SiGe14.txt');
inf_3=load('/home/qiusb/Desktop/temp/WYT/SiGe_energy/SiGe18.txt');
inf_4=load('/home/qiusb/Desktop/temp/WYT/SiGe_energy/SiGe221D.txt');
inf_5=load('/home/qiusb/Desktop/temp/WYT/SiGe_energy/SiGe222D.txt');
inf_6=load('/home/qiusb/Desktop/temp/WYT/SiGe_energy/SiGe223D.txt');
inf_7=load('/home/qiusb/Desktop/temp/WYT/SiGe_energy/SiGe10_90.txt');%%%1:5 columns = 0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%BEM
index=[1:5];%
B_all=[];
N_i=[0];
n=0;
for ii=1:6
    name=['inf_', num2str(ii)];
    inf=eval(name);
N_i=[N_i size(inf,1)+n];
n=N_i(end);
end
inf_all=[inf_1;inf_2;inf_3;inf_4;inf_5;inf_6];
c=[];
for kk=1:size(inf_all,1)
    c=[c;inf_all(kk,index) zeros(1,6)];
    temp=0;
    for ll=1:size(N_i,2)-1
        if kk<=N_i(ll+1)
            temp=temp+1;
        end
    end
    c(kk,5+7-temp)=1;
end
%c=inf_all(:,index);
[B_a,BINT_a,R_a]=regress(inf_all(:,11), c);%%%%%xB=E
E_pred_a=c*B_a;
R_a_peratom=[];
%%%%%%%%%%%%%%%delete the stange one
% s=[];
% for jj=1:size(R_a,1)
%     R_a_peratom=[R_a_peratom;R_a(jj,1)/sum(inf_all(jj,6:8))];
%      if abs(R_a(jj,1))>0.04
%         s=[s;jj];
%      end
% end
%R_a(s,:)=[];
%%%%%%%%%%%%%%%%%%%
figure 
set(gcf,'color','w')
x=N_i(6);
y=N_i(7);


hist(R_a,200)
h=findobj(gca,'Type','patch');
h.FaceColor = [0.6 0.6 0.6];
h.EdgeColor = [0.6 0.6 0.6];
xlim([-0.02 0.04])
xlabel('\delta E / eV')
hold on 
hist(R_a(x:y,1),200)



figure
set(gcf,'color','w')
fill([-240, -240, -180, -180], [-240, -180, -180, -240],  [0.95 0.95 0.95])
hold on 
fill([-180, -240, -240, -150, -150, -180], [-180, -180, -150, -150, -240, -240],  [0.99 0.95 0.95])    
hold on 
fill([-150, -240, -240, -115, -115, -150], [-150, -150, -115, -115, -240, -240],  [0.95 0.99 0.95])    
hold on 
fill([-115, -240, -240, -80, -80, -115], [-115, -115, -80, -80, -240, -240],  [0.95 0.95 0.99])    
hold on 

sy=['*', 'o', 'v', '^', '+', 's'];
for ii=1:size(N_i,2)-1
plot(inf_all(N_i(ii)+1:N_i(ii+1),11),E_pred_a(N_i(ii)+1:N_i(ii+1),1),sy(1))
hold on
end
a=[min(inf_all(:,11))*1.05, max(inf_all(:,11))*0.95];
plot(a,a,'r-')
xlabel('E_{DFT} / eV')
ylabel('E_{BEM} / eV')
text(-235,-190,'Si_xGe_{22-x}','Color','k','FontSize',14)
text(-205,-160,'Si_xGe_{18-x}','Color','k','FontSize',14)
text(-175,-130,'Si_xGe_{14-x}','Color','k','FontSize',14)
text(-140,-95,'Si_xGe_{10-x}','Color','k','FontSize',14)


% s=[];
% for ii=1:size(R_a,1)
%     if abs(R_a(ii,1))>0.04
%         s=[s;ii];
%     end
% end
% sort([ N_i+repmat(385,1,size(N_i,2)), N_i+repmat(386,1,size(N_i,2)),N_i, N_i+repmat(1,1,size(N_i,2))])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%calculate \delta H
% color=[0,0,1;
%    1 0 1
%     0,1,1;
%     0.5 ,1,0.5 ;
%     1,0.5,1;
%     1,0.5 ,0;
%     1,0,0;
%     0 1 0];
% symbol=['*', '^',  'd', 'x',  '<', '>' ,'s'];  
% close all
% figure
% for ii=[2:6]
%     name=['inf_', num2str(ii)];
%     inf=eval(name);
%     delta_H=[];
%     for jj=1:size(inf,1)
%         delta_H=[delta_H; inf(jj,11)-(inf(jj,6)*inf(end,11)+inf(jj,7)*inf(1,11))/max(inf(:,7))];
%     end
%     K = convhull(inf(:,6),delta_H);
%     rm_K=[size(K,1)];
%     for kk=1:size(K,1)
%         if delta_H(K(kk))>0.01
%             rm_K=[rm_K;kk];
%         end
%     end
%     K(rm_K)=[];
%   
%     set(gcf,'color','w')    
%     %plot(inf(:,6),delta_H,symbol(ii),'Color',color(ii,:))
%     xlim([min(inf(:,7)), max(inf(:,7))])
%     xlabel('The number of silicon atom')
%     ylabel('Formation Enthapy (eV)')
% 
%     hold on
%     plot(inf(K,6),delta_H(K),'-','LineWidth',2,'Color',color(ii,:))
%     hold on 
%     legend('SiGe14','SiGe18','SiGe221D','SiGe222D','SiGe223D')
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%plot gap
% figure   
% set(gcf,'color','w')    
% xlim([0, 7])
% for ii=[1:6]
%     name=['inf_', num2str(ii)];
%     inf=eval(name); 
%     hold on
%     plot(repmat(ii,size(inf,1),1),inf(:,10),'*')    
% end
% xl1={'SiGe10';'SiGe14';'SiGe18';'SiGe221D';'SiGe222D';'SiGe223D'}; 
% set(gca,'XTick',1:6);
% set(gca,'XTicklabel',xl1)
% h = gca;
% th=rotateticklabel(h, 45,8,'demo');%调用下面的函数，坐标倾斜45度,字体大小8
% ylabel('gap (eV)','fontsize',8,'fontweight','bold')
% hold on 
% legend('SiGe14','SiGe18','SiGe221D','SiGe222D','SiGe223D')


















