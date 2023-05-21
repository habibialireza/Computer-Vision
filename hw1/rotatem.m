%clc;clear all;close all;
%teta in radians
%teta = 0.52; 
%I=imread('sample.ppm');
function rotatem(I,teta) 
%I = im2double(I);
rotation_matrix=zeros(2,2);
rotation_matrix(1,1)=cos(teta);
rotation_matrix(1,2)=-sin(teta);
rotation_matrix(2,1)=sin(teta);
rotation_matrix(2,2)=cos(teta);
inverse_rotation_matrix=inv(rotation_matrix);
isize = size(I);

h=isize(1);
w=isize(2);
rotated_im = zeros(round(abs(cos(teta)*h)+abs(sin(teta)*w)),round(abs(sin(teta)*h)+abs(cos(teta)*w)),isize(3),'uint8');
if teta<=pi/2 
h1=round(w*sin(teta));
w1=0;
elseif teta<=pi
a=teta-pi/2;
h1=round(abs(w*sin(teta))+abs((h*cos(teta))));
w1=round(w*sin(a));
elseif alpha<=pi*3/2
h1=-round(h*cos(teta));
w1=round(abs(h*sin(teta)+abs((w*cos(teta)))));
else 
h1=0;
w1=-round(h*sin(teta));
end
for x=1:round(abs(cos(teta)*h)+abs(sin(teta)*w))
    for y=1:round(abs(sin(teta)*h)+abs(cos(teta)*w))
        a = [x-h1 y-w1]/inverse_rotation_matrix;
        x1=round(a(1));
        y1=round(a(2));
        if  x1 > 0 && x1 <= isize(1) && y1 > 0 && y1 <= isize(2)
        rotated_im(x,y,:)=I(x1,y1,:);
        end
    end
end
imshow(rotated_im,[])
end


