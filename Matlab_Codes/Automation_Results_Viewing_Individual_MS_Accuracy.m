clear all;
clc;

[v3,~,~]=xlsread('Estimated8_saved_IMS.csv');
[v4,~,~]=xlsread('Measured_Data_Stalling.csv');

Est=v3(:,1);
Meas_1=v4(:,1);
Meas_2=v4(:,2);
Meas_3=v4(:,3);

cnt1 = 1;
cnt2 = 1;
cnt3 = 1;
for i=1:length(Est)
  if rem(i,3)==1
      Est_1(cnt1) = Est(i);
      cnt1 = cnt1+1;
  end
  
  if rem(i,3)==2
      Est_2(cnt2) = Est(i);
      cnt2 = cnt2+1;
  end
  
  if rem(i,3)==0
      Est_3(cnt3) = Est(i);
      cnt3 = cnt3+1;
  end  
end

cnt =0;
pass = zeros(88,1);
for i= 1:length(Meas_1)
   if Meas_1(i)==0 && Est_1(i) < 0.5
        flag1 = 1;
   else
       flag1 = 0;
   end

   if Meas_1(i)==1 && Est_1(i) >= 0.5 
        flag2 = 1;
   else
       flag2 = 0;
   end   

   if Meas_2(i)==0 && Est_2(i) < 0.5
       flag3 = 1;
   else
       flag3 =0;
   end

   if Meas_2(i)==1 && Est_2(i) >= 0.5
       flag4 = 1;
   else
       flag4 = 0;
   end      
   
   if Meas_3(i)==0 && Est_3(i) < 0.5
       flag5 = 1;
   else
       flag5 =0;
   end

   if Meas_3(i)==1 && Est_3(i) >= 0.5
       flag6 = 1;
   else
       flag6 = 0;
   end   
   
   flag = flag1+flag2+flag3+flag4+flag5+flag6;
   
   if flag == 3
      cnt = cnt+1;
      pass(i) = 1;
   end
end

Est_1 = Est_1';
Est_2 = Est_2';
Est_3 = Est_3';
accuracy = (cnt/88)*100;