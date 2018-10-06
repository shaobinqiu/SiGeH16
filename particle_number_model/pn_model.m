clear%%%%%particle number model 
close all
all=load('../inf_ya/all_inf.txt');
degener=load('../Ge10_degener.txt');
E=all(:,3);
x=[all(:,2), repmat(10,90,1)-all(:,2), repmat(16,90,1)]
[B,BINT,R]=regress(E(1:20,:),x(1:20,:));%%%%%xB=E
E_pred=x*B;

x_nonrep=unique(x,'rows');%%%if we know x(:,[3 5 6 8]), all of x we can get
all_PNM=zeros(size(x_nonrep,1),4);%%%%[i, n_si, E_pred, degener]
f_DFT_to_PNM=zeros(90,2);%%%we can know the structure correspond to which one in BEM
for ii=1:size(x,1)
    for jj=1:size(x_nonrep,1)
        if x(ii,:)==x_nonrep(jj,:)
            f_DFT_to_PNM(ii,:)=[ii,jj];
            all_PNM(jj,1:3)=[jj, all(ii,2), E_pred(ii,1)];
            all_PNM(jj,4)=all_PNM(jj,4)+degener(ii,1);
        end
    end
end
save all_PNM.txt all_PNM -ascii
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
plot(E,E_pred,'b*')
hold on 
plot(E,E,'r-')
figure
plot(R)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
