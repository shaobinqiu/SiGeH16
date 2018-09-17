clear%%%%plot F(T) 
all=load('./inf_ya/all_inf.txt');
T_max=2000;
T=10:10:T_max;
Fre=all(:,4:75)*10^12;%unit conversion
%Fre=repmat(all(1,4:75),90,1)*10^12;
h=6.63*10^(-34)/(1.6*10^(-19))/2/3.14; 
k=1.38*10^(-23)/(1.6*10^(-19));
n=3;%number of Si
F=[];
for ii=1:size(all,1)
   %if all(ii,2)==n
        ii
        f_T=[];
        for jj=1:size(T,2)
            f=all(ii,3);
            for kk=1:size(Fre,2)
                f=f+h*Fre(ii,kk)/2+k*T(jj)*log(1-exp(-h*Fre(ii,kk)/k/T(jj)));
            end
            f_T=[f_T, f];
        end
        F=[F;f_T];
    %end
end
figure
c=rand(size(F,1),3);
    for uu=1:size(F,1)
        plot(T,F(uu,:),'*-','color',c(uu,:))
        hold on
    end
    legend('show')
    title('contribution of  structurewith n_i Si')
    
    delta=[];
    for ll=1:size(F,2)-1
        delta=[delta F(:,ll+1)-F(:,ll)];
    end
    figure 
      for uu=1:size(delta,1)
        plot(T(1,1:size(delta,2)),delta(uu,:),'-','color',c(uu,:))
        hold on
      end