%clear all;
I = imread('F:\uni\term 8\cv\hw3\hw3\Q2\Dataset\Images\im_40.png');
index = 40;
%make gray and remove noise and make circles go away :)
I=rgb2gray(I);
I = myfilt(I);

for i = 1:600
    for j = 1:600
        if I(i,j)==0 %|| I(i,j)==76
            I(i,j)=255;
        end
    end
end
I1 = I;
for i = 1:600
    for j = 1:600
        if I(i,j)~=76 && I(i,j)~=255 %|| I(i,j)==76
            I(i,j)=76;
        end
    end
end
%imtool(I);
%{
circleL = imread('F:\uni\term 8\cv\hw3\hw3\Q2\temp01.bmp');
circleM = imread('F:\uni\term 8\cv\hw3\hw3\Q2\temp02.bmp');
circleS = imread('F:\uni\term 8\cv\hw3\hw3\Q2\temp03.bmp');
for i = 1:64
    for j = 1:64
        if circleL(i,j)<76 %|| I(i,j)==76
            circleL(i,j)=76;
        end
    end
end
for i = 1:52
    for j = 1:52
        if circleM(i,j)<76 %|| I(i,j)==76
            circleM(i,j)=76;
        end
    end
end
for i = 1:36
    for j = 1:36
        if circleS(i,j)<76 %|| I(i,j)==76
            circleS(i,j)=76;
        end
    end
end
%}
circlesS = 0;
circorsS=[];
for i = 31:568
    for j = 31:568
        if I(i,j)==76 %|| I(i,j)==76
            if(I(i+23,j+23)==255 && I(i-23,j+23)==255 && I(i+23,j-23)==255 && I(i-23,j-23)==255)
                [lil , lel]=size(circorsS);
                if (lil == 0 ) || (lil ~= 0)% && abs(circorsS(end) - j) >10 && abs(circorsS(end-1) - i) >10) 
                    circlesS = circlesS + 1;
                    circorsS = [circorsS i j];
                    for ii = i-30:i+37
                        for jj = j-30:j+37
                            if ii<601 && jj<601
                                I(ii,jj)=255;
                            end
                        end
                    end
               end
            end
        end
    end
end


circlesM = 0;
circorsM=[];
for i = 40:558
    for j = 40:558
        if I(i,j)==76 %|| I(i,j)==76
            if(I(i+29,j+29)==255 && I(i-29,j+29)==255 && I(i+29,j-29)==255 && I(i-29,j-29)==255)
                [lil , lel]=size(circorsM);
                if (lil == 0 ) || (lil ~= 0 )%&& abs(circorsM(end) - j) >10 && abs(circorsM(end-1) - i) >10) 
                    circlesM = circlesM + 1;
                    circorsM = [circorsM i j];
                    for ii = i-39:i+45
                        for jj = j-39:j+45
                            if ii<601 && jj<601
                                I(ii,jj)=255;
                            end
                        end
                    end
               end
            end
        end
    end
end


circlesL = 0;
circorsL=[];
for i = 50:551
    for j = 50:551
        if I(i,j)==76 %|| I(i,j)==76
            if(I(i+36,j+36)==255 && I(i-36,j+36)==255 && I(i+36,j-36)==255 && I(i-36,j-36)==255)
                [lil , lel]=size(circorsL);
                if (lil == 0 ) || (lil ~= 0 )%&& (abs(circorsL(end) - j) >10 && abs(circorsL(end-1) - i) >10) 
                    circlesL = circlesL + 1;
                    circorsL = [circorsL i j];
                    for ii = i-49:i+54
                        for jj = j-49:j+54
                            if ii<601 && jj<601
                               I(ii,jj)=255;
                            end
                        end
                    end
               end
            end
        end
    end
end



for i = 1:600
    for j = 1:600
        if I1(i,j)==29;
            I1(i,j)=255;
        else
            I1(i,j)=0;
        end
    end
end
temps = cell(10,1);
for num = 0:9
        %fname = sprintf('F:\uni\term 8\cv\hw3\hw3\Q2\%s.bmp',num);
        temps{num+1} = imread(strcat('F:\uni\term 8\cv\hw3\hw3\Q2\',string(num),'.bmp'));
        %figure,imshow(temps{num+1});
end

bestL = [];
if circlesL~=0
    ind=1;
    measL=0;
    bestL = zeros(0,circlesL);
for loool = 1:circlesL
    measL=0;
    for num=1:10
    tempmeasL = psnr(temps{num},I1(circorsL(ind)-23:circorsL(ind)+32,circorsL(ind+1)-22:circorsL(ind+1)+18));
    if tempmeasL>measL
        measL = tempmeasL;
        bestL(loool) = num-1;
    end
    temp2=imrotate(temps{num},45);
    tempmeasL = psnr(temp2,I1(circorsL(ind)-23-6:circorsL(ind)+32+7,circorsL(ind+1)-22-14:circorsL(ind+1)+18+14));
    if tempmeasL>measL
        measL = tempmeasL;
        bestL(loool) = num-1;
    end
    temp2=imrotate(temps{num},-45);
    tempmeasL = psnr(temp2,I1(circorsL(ind)-23-6:circorsL(ind)+32+7,circorsL(ind+1)-22-14:circorsL(ind+1)+18+14));
    if tempmeasL>measL
        measL = tempmeasL;
        bestL(loool) = num-1;
    end
    end
    ind = ind + 2;
    if loool~=circlesL
    lines = strcat(string(circorsL(ind-2)),',',string(circorsL(ind-2)),',','number = ',string(bestL(loool)));
    filename = strcat('F:\uni\term 8\cv\hw3\hw3\Q2\coord',string(index),'.txt');
    fileID = fopen(filename,'a');
    fprintf(fileID,'%s\n',lines);
    end
end
end


bestM = [];
if circlesM~=0
    ind=1;
    measM=0;
    bestM = zeros(0,circlesM);
for loool = 1:circlesM
    measM=0;
    for num=1:10
    tempmeasM = psnr(imresize(temps{num},37/46),I1(circorsM(ind)-floor(23*37/46)-1:circorsM(ind)+ceil(32*37/46),circorsM(ind+1)-floor(22*37/46):circorsM(ind+1)+ceil(18*37/46)));
    if tempmeasM>measM
        measM = tempmeasM;
        bestM(loool) = num-1;
    end
    temp2=imrotate(imresize(temps{num},37/46),45);
    tempmeasM = psnr(temp2,I1(circorsM(ind)-floor(23*37/46)-1-5-5:circorsM(ind)+ceil(32*37/46)+5-5,circorsM(ind+1)-floor(22*37/46)-12+4:circorsM(ind+1)+ceil(18*37/46)+11+4));
    if tempmeasM>measM
        measM = tempmeasM;
        bestM(loool) = num-1;
    end
    temp2=imrotate(imresize(temps{num},37/46),-45);
    tempmeasM = psnr(temp2,I1(circorsM(ind)-floor(23*37/46)-1-5-5:circorsM(ind)+ceil(32*37/46)+5-5,circorsM(ind+1)-floor(22*37/46)-12+4:circorsM(ind+1)+ceil(18*37/46)+11+4));
    if tempmeasM>measM
        measM = tempmeasM;
        bestM(loool) = num-1;
    end
    end
    ind = ind + 2;
    if loool~=circlesM
    lines = strcat(string(circorsM(ind-2)),',',string(circorsM(ind-2)),',','number = ',string(bestM(loool)));
    filename = strcat('F:\uni\term 8\cv\hw3\hw3\Q2\coord',string(index),'.txt');
    fileID = fopen(filename,'a');
    fprintf(fileID,'%s\n',lines);
    end
end
end


bestS = [];
if circlesS~=0
    ind=1;
    measS=0;
    bestS = zeros(0,circlesS);
for loool = 1:circlesS
    measS=0;
    for num=1:10
    tempmeasS = psnr(imresize(temps{num},27/46),I1(circorsS(ind)-16+7-1:circorsS(ind)+17+7-2,circorsS(ind+1)-13+1-3:circorsS(ind+1)+12+1-4));
    if tempmeasS>measS
        measS = tempmeasS;
        bestS(loool) = num-1;
    end
    temp2=imrotate(imresize(temps{num},27/46),-45);
    tempmeasS = psnr(temp2,I1(circorsS(ind)-floor((23+6)*27/46)-1-2:circorsS(ind)+ceil((32+7)*27/46)-2,circorsS(ind+1)-floor((22+14)*27/46)-1:circorsS(ind+1)+ceil((18+14)*27/46)));
    if tempmeasS>measS
        measS = tempmeasS;
        bestS(loool) = num-1;
    end
    temp2=imrotate(imresize(temps{num},27/46),-45);
    tempmeasS = psnr(temp2,I1(circorsS(ind)-floor((23+6)*27/46)-1-2:circorsS(ind)+ceil((32+7)*27/46)-2,circorsS(ind+1)-floor((22+14)*27/46)-1:circorsS(ind+1)+ceil((18+14)*27/46)));
    if tempmeasS>measS
        measS = tempmeasS;
        bestS(loool) = num-1;
    end
    end
    ind = ind + 2;
    if loool~=circlesS
    lines = strcat(string(circorsS(ind-2)),',',string(circorsS(ind-2)),',','number = ',string(bestS(loool)));
    filename = strcat('F:\uni\term 8\cv\hw3\hw3\Q2\coord',string(index),'.txt');
    fileID = fopen(filename,'a');
    fprintf(fileID,'%s\n',lines);
    end
end
end

