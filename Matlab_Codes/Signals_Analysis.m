clear all;
clc;

% [v3,~,~]=xlsread('Contactor_Tripped_Cases_Data_Testing_W_Norm_Final.csv');

for i=31:34
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
 
  tipos=A(:,1);
  ipos = A(:,4);
  
  len = length(ipos);
  
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
 
 t1(1)=0;
 
  cnt=1;
  cnt3 =1;
  for i=65000:length(xfilt)
%      t1(cnt3+1) = t1(cnt3)+0.00012; 
     xfinal1(cnt)=xfilt(i);
     cnt=cnt+1;
     cnt3=cnt3+1;
  end
  xfinal1=xfinal1';


%   figure()
%   plot(tvpos, vpos/7.199);
%   title('PSCAD Generated Feeder Head Voltage using FFT')
%  xlabel('Time in secs')
% ylabel('Voltage in pu')
% xlim([0.95,1.5])
%  ylim([0.7, 1.05])
 
   %vratch(temp) = (vpos(500)-vpos(400))/vpos(400);

 
Sp1 = sort(xfinal1/xfinal(1));
Sp2 = sort(vpos/vpos(300));  
Vnadir(temp) = Sp2(1); 
 
% figure()
% plot(ttr,sig1)
% hold on
% plot(ttr,sig2)
% hold on
% plot(ttr,sig3)
% xlabel('Time in secs')
% xlabel('Signal')
% legend('Seg 1','Seg 2','Seg 3')
% xlim([1.95,2.16])
% ylim([-0.1,1.1])

% figure()
% plot(tvpos,vpos/7.199)


%I69 = sort(ipos);4585
I69_st(temp) = ipos(len-1);
 end

 Vnadir= Vnadir';
 I69_st = I69_st';

