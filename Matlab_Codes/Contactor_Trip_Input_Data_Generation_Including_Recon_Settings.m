clear all;
clc;

[v3,~,vt3]=xlsread('SLG_Faults_Final_Overall_Contactor_Data.csv');
fr=v3(:,2);
fa=v3(:,3);
fd=v3(:,4);
Tr_st = v3(:,9);

%SPIM PSLF Speeds Manipulation
 for i=384:384
 formatSpeca = 'Case%d.csv';
 output_filea = sprintf(formatSpeca,i);
 A=readmatrix(output_filea);
  
  N1 = A(:,1);
  va = A(:,2);
  vb = A(:,2);
  vc = A(:,2);
  
  tvpos=A(:,1);
  vpos = A(:,2);
  
  ttr = A(:,7);
  sig1=A(:,8);
  sig2=A(:,9);
  sig3=A(:,10);
  
temp = i;
tstep = N1(3)-N1(2);

 t(1)=0;
  for i=1:(length(va)-1)
   t(i+1) = t(i)+tstep;   
  end

for i = 1:length(va)
vd(i) = (sqrt(2/3))*(va(i)*sin(377*t(i))+vb(i)*sin(377*t(i)-2*pi/3)+vc(i)*sin(377*t(i)+2*pi/3));
vq(i) = (sqrt(2/3))*(va(i)*cos(377*t(i))+vb(i)*cos(377*t(i)-2*pi/3)+vc(i)*cos(377*t(i)+2*pi/3));
end

vd = vd';
vq=vq';

for i = 1:length(va)
   v1(i) = sqrt(vd(i)*vd(i)+vq(i)*vq(i));
end

 for i=1:200000
    xfinal1(i) = v1(1); 
 end
 
 for i=1:(200000+length(v1))-1
    if i<=200000
       xfinal(i) =xfinal1(i);  
    end
    if i>200000
       xfinal(i) = v1(i-200000+1); 
    end
 end

  %a = 0.0001;
  a = 0.01;
 xfilt = filter(a, [1, a-1], xfinal);
 
  cnt=1;
  for i=65000:length(xfilt)
     xfinal1(cnt)=xfilt(i);
     cnt=cnt+1;
  end
  xfinal1=xfinal1';

len = 1750;

for m2=1:len
    j = len-m2+1;
    if sig1(j)~=0 || sig2(j)~=0 || sig3(j)~=0
        break;
    end
end

TTRC(temp) = ttr(j)-fa(temp);

n=j+417;

 min = abs(tvpos(1) -  ttr(j));
 indx = 1;
 for h=1:length(tvpos)
     if min > abs(tvpos(h) -  ttr(j))
        min =  abs(tvpos(h) -  ttr(j));
        indx = h;
     end
 end


vmag(temp) = vpos(indx)/vpos(300);
 
Sp1 = sort(xfinal1/xfinal(1));
Sp2 = sort(vpos/vpos(300));  
Vnadir(temp) = Sp2(1); 
 
figure()
 plot(ttr,sig1)
 hold on
  plot(ttr,sig2)
  hold on
   plot(ttr,sig3)
   ylim([-0.05,1.05])
 end

 ttrc_new = 2.0766;
 ttrc_debug = (ttrc_new - fa(temp))*1;
 
 min = abs(tvpos(1) -  ttrc_new);
 indx = 1;
 for i=1:length(tvpos)
     if min > abs(tvpos(i) -  ttrc_new)
        min =  abs(tvpos(i) -  ttrc_new);
        indx = i;
     end
 end
 
 vmag_new = vpos(indx)/vpos(300);
 
 Vnadir= Vnadir';
 TTRC = TTRC';
 vmag=vmag';