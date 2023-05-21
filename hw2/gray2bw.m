function J = gray2bw(I)
%I = im2double(imread('F:\uni\term 8\cv\hw2\hw2\Q2\House.tif'));
siz = size(I);
J = zeros(siz);
I = im2double(I);
for i = 1:siz(1)
    for j = 1:siz(2)
    if (log(1/((I(i,j)-0)^2))) > log(1/((I(i,j)-1)^2))
        J(i,j) = 0;
    else
        J(i,j) = 1;
    end
    
    end
end
end