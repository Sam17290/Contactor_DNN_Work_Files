clear all;
clc;

[v3,~,~]=xlsread('Estimated15_saved.csv');
Est=v3(1,:);
Meas=v3(2,:);

cnt =0;
pass = zeros(88,1);
for i= 1:length(Est)
   if Meas(i)==0 && Est(i) < 5
        cnt = cnt+1;
        pass(i) =1;
   end

   if Meas(i)==30 && Est(i) >= 25
        cnt = cnt+1;
        pass(i) =1;
   end
   
   if Meas(i)==10 && Est(i) >= 5 && Est(i) < 15
        cnt = cnt+1;
        pass(i) =1;
   end

   if Meas(i)==20 && Est(i) >= 15 && Est(i) < 25
        cnt = cnt+1;
        pass(i) =1;
   end   
end

Meas = Meas';
Est = Est';
accuracy = (cnt/88)*100;