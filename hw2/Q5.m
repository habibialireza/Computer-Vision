clc;clear;close all; 
Key=rng; 
I=imread('F:\uni\term 8\cv\hw2\hw2\Q5\Image_2.tif'); 
bit8=bitget(I,8)==1; 
bitflat = reshape(bit8,[1,numel(bit8)]); 
secretimg=imread ('F:\uni\term 8\cv\hw2\hw2\Q5\Image_1.tif'); 
secret=reshape(secretimg,[1,numel(secretimg)]);
for i=1:size(secret,2) 
     for j=1:8
     bitflat(1,8*(i-1)+j)=bitget(secret(1,i),j); 
     end
end 
random_pattern=(round(rand(size(bitflat)))==1); 
random_pattern_image= xor(bitflat,random_pattern);
temp=reshape(random_pattern_image, [size(bit8,1), size(bit8,2)]); 
result=bitset(I,1,temp); 
imshow(result,[]);  
save('.\Key','Key'); 
 
 
load('.\Key'); 
rng(Key) 
LSB=(bitget(result,1)==1); 
LSBflat=reshape(LSB,[1, numel(LSB)]); 
msg=zeros([274,418,3],'uint8'); 
msgflat=reshape(msg, [1, numel(msg)]); 
random_pattern=round(rand(size(LSBflat))); 
LSBflat=xor(LSBflat,random_pattern); 
for i=1:size(msgflat,2)
    for j=1:8    
    msgflat(1,i)=bitset(msgflat(1,i),j,LSBflat(1,8*(i-1)+j));
    end
end  
Extracted_Secret_Sessage=reshape(msgflat,[274,418,3]); 
figure,imshow(Extracted_Secret_Sessage,[]);