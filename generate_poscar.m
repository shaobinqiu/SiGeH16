clear
P=load('Ge10H16.txt');

 str=load('Ge10_str.txt');
 str=[str;0 0 0 0 0 0 0 0 0 0];
 Lat=[20 0 0
     0 20 0
     0 0 20];
      
      
 N_Si=[] ;    
 for ii=1:size(str,1)
     p=P;
     s=str(ii,:);
     s(s==0)=[];
     sub=P(s,:);
     p(s,:)=[];
     pos=[sub;p]/Lat-floor([sub;p]/Lat)+repmat( [0.5 0.5 0.5] , size(P,1) , 1 );
     
     d=[size(sub,1) size(p,1)-16 16];
     n=['POSCAR_SiGe/POSCAR-',num2str(ii)];
     fid=fopen(n,'w+');
     fprintf(fid,'SiGeH16 \n');
     fprintf(fid,'%g\n',1);
     fprintf(fid,'%-4.6f     %-4.6f     %-4.6f\n',Lat');
     fprintf(fid,'Si Ge H\n');
     fprintf(fid,'%g     %g       %g\n',d');
     fprintf(fid,'Direct\n');
     for vv=1:size(pos,1)
         fprintf(fid,'%-4.6f     %-4.6f     %-4.6f      \n',pos(vv,:)');
     end
     fclose(fid);
     
     N_Si=[N_Si;size(sub,1)];
 end
 save ./inf_ya/N_Si.txt N_Si -ascii
          
 
      