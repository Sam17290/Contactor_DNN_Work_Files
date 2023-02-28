clear all;
clc;

[v3,~,vt3]=xlsread('SLG_Faults_Final_Overall_Contactor_Data.csv');
fr=v3(:,2);
fa=v3(:,3);
fd=v3(:,4);
Tr_st = v3(:,9);

%SPIM PSLF Speeds Manipulation
 for i=351:384
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



 % figure()
% %   plot(xfinal1/xfinal1(1));
% %   hold on
  %  plot(vpos/vpos(1));

   %vratch(temp) = (vpos(500)-vpos(400))/vpos(400);

for m1=1:length(ttr)
   if sig1(m1)~=0 || sig2(m1)~=0 ||sig3(m1)~=0
       break;
   end 
end

TTT(temp) =  ttr(m1)-fa(temp); 
 
flag1=0;
flag2=0;
flag3=0;
for m=1:length(ttr)
   if sig1(m)~=0
      flag1=1;
   end
   if sig2(m)~=0
      flag2=1;
   end
   if sig3(m)~=0
      flag3=1;
   end
   
  flag = flag1+flag2+flag3; 
   if flag>=1
       break;
   end
end

% for m1=1:length(ttr)
%    if ttr(m1) >= fd(temp)+fa(temp) && ttr(m1)<fd(temp)+fa(temp)+0.02
%       if sig1(m1)~=0 || sig2(m1)~=0 ||sig3(m1)~=0
%          break;
%       end
%    end
% end 
 
% for n=1:length(tvpos)
%    if tvpos(n)==ttr(m-1)
%       break; 
%    end
% end

n=m+417;

vmag(temp) = vpos(n)/vpos(300);
 
Sp1 = sort(xfinal1/xfinal(1));
Sp2 = sort(vpos/vpos(300));  
Vnadir(temp) = Sp2(1);

% figure()
% % plot(tvpos,vpos/vpos(1))
% % hold on
% plot(ttr,sig1)
% hold on
% plot(ttr,sig2)
% hold on
% plot(ttr,sig3)
 end

 Vnadir= Vnadir';
 TTT = TTT';
 vmag=vmag';
 %vratch = vratch';