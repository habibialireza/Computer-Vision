I = imread('F:\uni\term 8\cv\hw3\hw3\Q1\Cameraman.tif');
sum1 = sum(sum(I));
J = imgaussfilt(I, 3);
sum2 = sum(sum(J));
mean_kernel = fspecial('average', [3 3]);
J2 = imfilter(I, mean_kernel);
sum3 = sum(sum(J2));


