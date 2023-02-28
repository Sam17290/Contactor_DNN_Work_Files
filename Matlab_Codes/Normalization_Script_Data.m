clear all;
clc;

[v3,~,~]=xlsread('C:\Users\gvijayis\Desktop\SLG_Faults_Final_Overall_Contactor_Data.csv');

P40=v3(:,2);  %FR
P5=v3(:,3);  %FA
P6=v3(:,4);  %FD
P7=v3(:,5);  %FN
P8=v3(:,9);  %ST
P9=v3(:,13);  %TMS


j=1;
for i=1:350
   P0(j) = P40(i);
   P1(j) = P5(i);
   P2(j) = P6(i);
   P3(j) = P7(i);
   P4(j) = P8(i);
   P10(j) = P9(i);
   j=j+1;
end

h=1;
for j=351:384
   M0(h) = P40(j);
   M1(h) = P5(j);
   M2(h) = P6(j);
   M3(h) = P7(j);
   M4(h) = P8(j);
   M10(h) = P9(j);
   h=h+1;
end

% j=1;
% for i=2:length(P15)
%    P17(j) = P15(i);
%    j=j+1;
% end
% 
% j=1;
% for i=2:length(P16)
%    P18(j) = P16(i);
%    j=j+1;
% end

P0 = P0';  %FR
P1 = P1';  %FA
P2 = P2';  %FD
P3 = P3';  %FN
P4 = P4';  %ST
P10 = P10'; %TMS
% P15 = P15'; %TMS
% P16 = P16'; %TMS

M0 = M0';  %FR
M1 = M1';  %FA
M2 = M2';  %FD
M3 = M3';  %FN
M4 = M4';  %ST
M10 = M10'; %TMS

Mp0 = mean(P0);
Mp1 = mean(P1);
Mp2 = mean(P2);
 Mp3 = mean(P3);
 Mp4 = mean(P4);
 Mp5 = mean(P10);

 Std0 = std(P0);
Std1 = std(P1);
Std2 = std(P2);
 Std3 = std(P3);
 Std4 = std(P4);
 Std5 = std(P10);
 
% Mp1 = 0.9979; 
% Mp2 = 0.0841;
% Mp3 = 0.8296; 
% Mp4 = 1.7634;  
% 
% Std1 = 0.0012;
% Std2 = 0.0097;
% Std3 = 0.0623;  
% Std4 = 1.0825; 
% 
%  Atr_norm = (P1 - Mp1)/Std1;
%  Btr_norm = (P2 - Mp2)/Std2;
%  Ctr_norm = (P3 - Mp3)/Std3;
%  Dtr_norm = (P4 - Mp4)/Std4;

 Atr_norm = (P1 - Mp1)/(Std1);
 Btr_norm = (P2 - Mp2)/(Std2); %350 cases normalization
 Ctr_norm = (P3 - Mp3)/(Std3);
 Dtr_norm = (P4 - Mp4)/(Std4);
 Etr_norm = (P0 - Mp0)/(Std0);
  Ftr_norm = (P10 - Mp5)/(Std5);
  
M0_norm = (M1 - Mp1)/(Std1);
 M1_norm = (M2 - Mp2)/(Std2); %350 cases normalization
 M2_norm = (M3 - Mp3)/(Std3);
 M3_norm = (M4 - Mp4)/(Std4);
 M4_norm = (M0 - Mp0)/(Std0);
  M10_norm = (M10 - Mp5)/(Std5);


%  for i =1:30
% M0_norm(i) = (M1(i) - Mp1)/(Std1);
%  M1_norm(i) = (M2(i) - Mp2)/(Std2); %350 cases normalization
%  M2_norm(i) = (M3(i) - Mp3)/(Std3);
%  M3_norm(i) = (M4(i) - Mp4)/(Std4);
%  M4_norm(i) = (M0(i) - Mp0)/(Std0);
%   M10_norm(i) = (M10(i) - Mp5)/(Std5);
%  end
 