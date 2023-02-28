clear all;
clc;

% [v3,~,vt3]=xlsread('C:\ASU\Contactor_Trip_Work_August_2021\New_Data_Generation_With_0.5micro_Time_Step\Contactor_Data_Generation\Final_Results_New\PSLF\Contactor_Trip_Data_Small_Time_Step_Final.csv');
% fr=v3(:,2);
% fa=v3(:,3);
% fd=v3(:,4);
% fn=v3(:,5);
% Tr_st = v3(:,9);

%SPIM PSLF Speeds Manipulation
 for i=1:384
 formatSpeca = 'out%d.csv';
 output_filea = sprintf(formatSpeca,i);
 A=readmatrix(output_filea);
  
  N1 = A(:,1);
  va = A(:,2);
  vb = A(:,2);
  vc = A(:,2);
  
  tvpos=A(:,1);
  vpos = A(:,2);

temp=i;
 
j=1;
for h=600:length(vpos)
   vpslf(j)=vpos(h);
   j=j+1;
end

Sp2 = sort(vpslf/vpos(600));  
Vnadir(temp) = Sp2(1);   
  
 end
 
 Vnadir= Vnadir';