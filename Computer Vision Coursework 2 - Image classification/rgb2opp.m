function [opp_img] = rgb2opp(img)
R  = img(:,:,1);
G  = img(:,:,2);
B  = img(:,:,3);
%convert to opponent space
O1 = (R-G)./sqrt(2);
O2 = (R+G-2*B)./sqrt(6);
O3 = (R+G+B)./sqrt(3);

opp_img(:,:,1) = O1;
opp_img(:,:,2) = O2;
opp_img(:,:,3) = O3;

end

