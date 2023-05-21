clc;clear all;close all;
I=imread('sample.ppm');
isize = size(I);
ycenter=isize(1)/2;
xcenter=isize(2)/2;

for x = 1:isize(2)
    for y = 1:isize(1)
        if(((x-xcenter)^2)/(400*400))+(((y-ycenter)^2)/(200*200)) <=1 && (((x-xcenter)^2)/(200*200))+(((y-ycenter)^2)/(400*400)) <=1
                I(y,x,:)=255;
        end
        if(((x-xcenter)^2)/(400*400))+(((y-ycenter)^2)/(200*200)) <=1 && (((x-xcenter)^2)/(200*200))+(((y-ycenter)^2)/(400*400)) >=1
                I(y,x,:)=255-I(y,x,:);
        end
        if(((x-xcenter)^2)/(400*400))+(((y-ycenter)^2)/(200*200)) >=1 && (((x-xcenter)^2)/(200*200))+(((y-ycenter)^2)/(400*400)) >=1
                I(y,x,:)=I(y,x,1)/3+I(y,x,2)/3+I(y,x,3)/3;
        end
                
    end
end


