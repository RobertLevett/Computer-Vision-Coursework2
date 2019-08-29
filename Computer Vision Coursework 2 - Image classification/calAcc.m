function [acc] = calAcc(pred,actual)
total = 0;
for i=1:length(pred)
   if strcmp(pred{i},actual{i})
       total = total + 1;
   end
end
acc = total/length(pred);
end

