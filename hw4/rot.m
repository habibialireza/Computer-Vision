function solved = rot(out_height,out_width,pieces,foldername)
%C:\Users\alire\Desktop\cvhw4\Q4\Puzzle_1_1200_1920
output = rgb2gray(imread(strcat(foldername,'\Rotated_',string(pieces),'\Output.tif')));
output2 = (imread(strcat(foldername,'\Rotated_',string(pieces),'\Output.tif')));
output3 = im2double(imread(strcat(foldername,'\Rotated_',string(pieces),'\Output.tif')));

patchs = cell(pieces-4,1);
patchs2 = cell(pieces-4,1);
for num = 1:pieces-4
       
        patchs{num} = rgb2gray(imread(strcat(foldername,'\Rotated_',string(pieces),'\Patch_',string(num),'.tif')));
        patchs2{num} = (imread(strcat(foldername,'\Rotated_',string(pieces),'\Patch_',string(num),'.tif')));
        patchs3{num} = im2double(imread(strcat(foldername,'\Rotated_',string(pieces),'\Patch_',string(num),'.tif')));

end


r=5;
patchsize=sqrt(out_height*out_width/pieces);

%make first row
%*****************************************************************
for k = 0:patchsize:out_width-(3*patchsize)
%bestnow = inf;%0;%
%k
  %  bestindex = 1;
    comps = zeros(1,pieces-4);
    temp = zeros(1,4);
for i = 1:pieces-4
    %comp edges
   
    temp(1,1) = norm(reshape(output3(1:patchsize,patchsize+k,:),patchsize,3)- reshape(patchs3{i}(:,1,:),patchsize,3));
    temp(1,2) = norm(reshape(output3(1:patchsize,patchsize+k,:),patchsize,3)- reshape(flip(patchs3{i}(1,:,:)),patchsize,3));
    temp(1,3) = norm(reshape(output3(1:patchsize,patchsize+k,:),patchsize,3)- reshape(flip(patchs3{i}(:,patchsize,:)),patchsize,3));
    temp(1,4) = norm(reshape(output3(1:patchsize,patchsize+k,:),patchsize,3)- reshape(patchs3{i}(patchsize,:,:),patchsize,3));
    [min1, bestin] = min(temp);
    if bestin == 2
        patchs3{i}=imrotate(patchs3{i},90);
        patchs2{i}=imrotate(patchs2{i},90);
    end

    if bestin == 3
    patchs3{i}=imrotate(patchs3{i},180);
    patchs2{i}=imrotate(patchs2{i},180);
    end
    
        
    if bestin == 4
    patchs3{i}=imrotate(patchs3{i},270);
    patchs2{i}=imrotate(patchs2{i},270);
    
    end



    comps(1,i)=min1;
    %comps(5,i)=comp;
    %comps(6,i)=comp;

    %comp = norm(reshape(output3(1:240,240+k,:),240,3)- reshape(patchs3{i}(:,1,:),240,3));
   % comps(3,i)=(comp);

    %comp = psnr(output(1:240,240+k,:),patchs{i}(:,1,:));
    %comp = pdist2(output(1:240,240,:), patchs{i}(:,1,:), 'euclidean');
    %comp = norm(reshape(output(1:240,240+k,:),240,3)- reshape(patchs{i}(:,1,:),240,3));
end
%comps
for dont_go_here = []
scaled_comp = normalize(comps, 2,'norm',1);
compsmain = sum(scaled_comp, 1);
[minimumValue, bestindex] = min(compsmain);
end
[minimumValue, bestindex] = min(comps);
   % if comp < bestnow
       
       % bestnow = comp;
    %end
%end

output2(1:patchsize,patchsize+1+k:patchsize*2+k,:) = patchs2{bestindex};
output3(1:patchsize,patchsize+1+k:patchsize*2+k,:) = patchs3{bestindex};
output(1:patchsize,patchsize+1+k:patchsize*2+k) = patchs{bestindex};
imshow(output2)
end

%make first col**********************************************************

for k = 0:patchsize:out_height-(3*patchsize)
%bestnow = inf;%0;%
%k
  %  bestindex = 1;
    comps = zeros(1,pieces-4);
for i = 1:pieces-4
    %comp edges
     %comp = norm(reshape(output3(patchsize+k,1:patchsize,:),patchsize,3)- reshape(patchs3{i}(1,:,:),patchsize,3));
    
    
    temp(1,1) = norm(reshape(output3(patchsize+k,1:patchsize,:),patchsize,3)- reshape(patchs3{i}(1,:,:),patchsize,3));
    temp(1,2) = norm(reshape(output3(patchsize+k,1:patchsize,:),patchsize,3)- reshape(flip(patchs3{i}(:,1,:)),patchsize,3));
    temp(1,3) = norm(reshape(output3(patchsize+k,1:patchsize,:),patchsize,3)- reshape(patchs3{i}(:,patchsize,:),patchsize,3));
    temp(1,4) = norm(reshape(output3(patchsize+k,1:patchsize,:),patchsize,3)- reshape(flip(patchs3{i}(patchsize,:,:)),patchsize,3));
    [min1, bestin] = min(temp);
    if bestin == 2
        patchs3{i}=imrotate(patchs3{i},-90);
        patchs2{i}=imrotate(patchs2{i},-90);
    end

    if bestin == 4
    patchs3{i}=imrotate(patchs3{i},180);
    patchs2{i}=imrotate(patchs2{i},180);
    
    end
    
        
    if bestin == 3
    patchs3{i}=imrotate(patchs3{i},90);
    patchs2{i}=imrotate(patchs2{i},90);
    
    end

    comps(1,i)=min1;
    
    %comps(5,i)=comp;
    %comps(6,i)=comp;
%comment ednd here
    

    %comp = norm(reshape(output3(1:240,240+k,:),240,3)- reshape(patchs3{i}(:,1,:),240,3));
   % comps(3,i)=(comp);

    %comp = psnr(output(1:240,240+k,:),patchs{i}(:,1,:));
    %comp = pdist2(output(1:240,240,:), patchs{i}(:,1,:), 'euclidean');
    %comp = norm(reshape(output(1:240,240+k,:),240,3)- reshape(patchs{i}(:,1,:),240,3));
end
%comps
for dont_go_here = []
scaled_comp = normalize(comps, 2,'norm',1);
compsmain = sum(scaled_comp, 1);
[minimumValue, bestindex] = min(compsmain);
end
[minimumValue, bestindex] = min(comps);
   % if comp < bestnow
       
       % bestnow = comp;
    %end
%end

output2(patchsize+1+k:patchsize*2+k,1:patchsize,:) = patchs2{bestindex};
output3(patchsize+1+k:patchsize*2+k,1:patchsize,:) = patchs3{bestindex};
output(patchsize+1+k:patchsize*2+k,1:patchsize) = patchs{bestindex};
imshow(output2)
end



%make others ******************************************************

for k1 = patchsize:patchsize:out_width-(patchsize)
for k = 0:patchsize:out_height-(2*patchsize)
%bestnow = inf;%0;%
%k
  %  bestindex = 1;
    comps = zeros(1,pieces-4);
    temp2 = zeros(1,4);
for i = 1:pieces-4
    %comp edges
  


    temp(1,1) = norm(reshape(output3(1+k+patchsize:2*patchsize+k,k1,:),patchsize,3)- reshape(patchs3{i}(:,1,:),patchsize,3));
    temp(1,2) = norm(reshape(output3(1+k+patchsize:2*patchsize+k,k1,:),patchsize,3)- reshape(flip(patchs3{i}(1,:,:)),patchsize,3));
    temp(1,3) = norm(reshape(output3(1+k+patchsize:2*patchsize+k,k1,:),patchsize,3)- reshape(flip(patchs3{i}(:,patchsize,:)),patchsize,3));
    temp(1,4) = norm(reshape(output3(1+k+patchsize:2*patchsize+k,k1,:),patchsize,3)- reshape(patchs3{i}(patchsize,:,:),patchsize,3));
    

    temp2(1,1) = norm(reshape(output3(patchsize+k,1+k1:patchsize+k1,:),patchsize,3)- reshape(patchs3{i}(1,:,:),patchsize,3));
    temp2(1,2) = norm(reshape(output3(patchsize+k,1+k1:patchsize+k1,:),patchsize,3)- reshape(flip(patchs3{i}(:,1,:)),patchsize,3));
    temp2(1,3) = norm(reshape(output3(patchsize+k,1+k1:patchsize+k1,:),patchsize,3)- reshape(patchs3{i}(:,patchsize,:),patchsize,3));
    temp2(1,4) = norm(reshape(output3(patchsize+k,1+k1:patchsize+k1,:),patchsize,3)- reshape(flip(patchs3{i}(patchsize,:,:)),patchsize,3));
    
    temp(1,1) = temp(1,1)+temp2(1,1);
    temp(1,2) = temp(1,2)+temp2(1,3);
    temp(1,3) = temp(1,3)+temp2(1,4);
    temp(1,4) = temp(1,4)+temp2(1,2);
    
  

    [min1, bestin] = min(temp);
    if bestin == 2
        patchs3{i}=imrotate(patchs3{i},90);
        patchs2{i}=imrotate(patchs2{i},90);
    end

    if bestin == 3
    patchs3{i}=imrotate(patchs3{i},180);
    patchs2{i}=imrotate(patchs2{i},180);
    end
      
    if bestin == 4
    patchs3{i}=imrotate(patchs3{i},270);
    patchs2{i}=imrotate(patchs2{i},270);    
    end
    comps(1,i)=min1;
end
    %comps(5,i)=comp+comp1;
    %comps(6,i)=comp+comp1;
    %comment end here
    
    %comp = norm(reshape(output3(1:240,240+k,:),240,3)- reshape(patchs3{i}(:,1,:),240,3));
   % comps(3,i)=(comp);

    %comp = psnr(output(1:240,240+k,:),patchs{i}(:,1,:));
    %comp = pdist2(output(1:240,240,:), patchs{i}(:,1,:), 'euclidean');
    %comp = norm(reshape(output(1:240,240+k,:),240,3)- reshape(patchs{i}(:,1,:),240,3));

[minimumValue, bestindex] = min(comps);
if k1==out_width-(patchsize) && k == out_height-(2*patchsize)
    break;
end
output2(patchsize+1+k:patchsize*2+k,1+k1:patchsize+k1,:) = patchs2{bestindex};
output3(patchsize+1+k:patchsize*2+k,1+k1:patchsize+k1,:) = patchs3{bestindex};
output(patchsize+1+k:patchsize*2+k,1+k1:patchsize+k1) = patchs{bestindex};
imshow(output2),title(strcat('k1 = ',string(k1),' k = ',string(k),' ind = ',string(bestindex)));drawnow;

end



solved=output2;
end