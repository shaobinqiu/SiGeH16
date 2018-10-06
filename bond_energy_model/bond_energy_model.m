clear%%%%%bond energy model 
close all
all=load('../inf_ya/all_inf.txt');
degener=load('../Ge10_degener.txt');
x=zeros(90,8);%%%Si Ge H Si_Si Ge_Ge Si_Ge Si_H Ge_H
for ii=1:90
    poscar=import_poscar(['../POSCAR_SiGe/POSCAR-',num2str(ii)]);
    x(ii,1:3)=poscar.atomcount;
    positions=(poscar.coords-floor(poscar.coords))*poscar.lattice;
    for jj=1:10
         position_jj=positions(jj,:);
        if jj<=poscar.atomcount(1,1);%%%Si          
            for kk=1:size(positions,1)
                if 1<sqrt(sum((position_jj-positions(kk,:)).^2)) && sqrt(sum((position_jj-positions(kk,:)).^2))<3
                    if kk<=poscar.atomcount(1,1)
                        x(ii,4)=x(ii,4)+1;
                    else if kk<=poscar.atomcount(1,1)+poscar.atomcount(2,1)
                            x(ii,6)=x(ii,6)+1;
                        else
                            x(ii,7)=x(ii,7)+1;
                        end
                    end
                end
            end
        else%%%Ge
            for kk=1:size(positions,1)
                if 1<sqrt(sum((position_jj-positions(kk,:)).^2))  && sqrt(sum((position_jj-positions(kk,:)).^2))<3                    
                    if kk<=poscar.atomcount(1,1)
                        x(ii,6)=x(ii,6)+1;
                    else if kk<=poscar.atomcount(1,1)+poscar.atomcount(2,1)
                            x(ii,5)=x(ii,5)+1;
                        else
                            x(ii,8)=x(ii,8)+1;
                        end
                    end
                end
            end            
        end
    end
                    
end
x(:,4:6)=x(:,4:6)/2;
%a=sum(x');%%%%%%%verif ==54

E=all(:,3);
[B,BINT,R]=regress(E,x);%%%%%xB=E
E_pred=x*B;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
plot(E,E_pred,'b*')
hold on 
plot(E,E,'r-')
figure
plot(R)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_nonrep=unique(x,'rows');%%%if we know x(:,[3 5 6 8]), all of x we can get
all_BEM=zeros(63,4);%%%%[i, n_si, E_pred, degener]
f_DFT_to_BEM=zeros(90,2);%%%we can know the structure correspond to which one in BEM
for ii=1:size(x,1)
    for jj=1:size(x_nonrep,1)
        if x(ii,:)==x_nonrep(jj,:)
            f_DFT_to_BEM(ii,:)=[ii,jj];
            all_BEM(jj,1:3)=[jj, all(ii,2), E_pred(ii,1)];
            all_BEM(jj,4)=all_BEM(jj,4)+degener(ii,1);
        end
    end
end
save all_BEM.txt all_BEM -ascii

