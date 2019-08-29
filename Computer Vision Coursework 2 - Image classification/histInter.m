function [intersection] = histInter(h1,h2)
test = 0;
for i=1:length(h2)
   test = test + min(h1(i), h2(i));
end
    test = 1-(test/sum(h2));
    intersection = test;
end

