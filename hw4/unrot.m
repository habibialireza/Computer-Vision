function solved = unrot(out_height,out_width,pieces,foldername)
%C:\Users\alire\Desktop\cvhw4\Q4\Puzzle_1_1200_1920
output = rgb2gray(imread(strcat(foldername,'\Unrotated_',string(pieces),'\Output.tif')));
output2 = (imread(strcat(foldername,'\Unrotated_',string(pieces),'\Output.tif')));
output3 = im2double(imread(strcat(foldername,'\Unrotated_',string(pieces),'\Output.tif')));

patchs = cell(pieces-4,1);
patchs2 = cell(pieces-4,1);
for num = 1:pieces-4
       
        patchs{num} = rgb2gray(imread(strcat(foldername,'\Unrotated_',string(pieces),'\Patch_',string(num),'.tif')));
        patchs2{num} = (imread(strcat(foldername,'\Unrotated_',string(pieces),'\Patch_',string(num),'.tif')));
        patchs3{num} = im2double(imread(strcat(foldername,'\Unrotated_',string(pieces),'\Patch_',string(num),'.tif')));

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
for i = 1:pieces-4
    %comp edges
   for dont_go_here = []
    BW1 = edge([output(1:patchsize,patchsize-1+k:patchsize+k),patchs{i}(:,1)],'canny');
    BW2 = edge([output(1:patchsize,patchsize+k),patchs{i}(:,1:2)],'canny');
    comp = norm(BW1(:,2)-BW2(:,2));
    comps(1,i)=comp;
    %comps(5,i)=comp;
   
    lbp1 = extractLBPFeatures([output(1:patchsize,patchsize-1+k:patchsize+k),patchs{i}(:,1)],'Upright',false);
    lbp2 = extractLBPFeatures([output(1:patchsize,patchsize+k),patchs{i}(:,1:2)],'Upright',false);
    comp = norm(lbp1-lbp2);
    comps(2,i)=comp;
   
    his1r = imhist(output2(1:patchsize,patchsize-(patchsize/r)+k:patchsize+k,1));
    his1g = imhist(output2(1:patchsize,patchsize-(patchsize/r)+k:patchsize+k,2));
    his1b = imhist(output2(1:patchsize,patchsize-(patchsize/r)+k:patchsize+k,3));
   
    his2r = imhist(patchs2{i}(:,1:(patchsize/r),1));
    his2g = imhist(patchs2{i}(:,1:(patchsize/r),3));
    his2b = imhist(patchs2{i}(:,1:(patchsize/r),3));
   
    compr = norm(his1r-his2r);
    compg = norm(his1g-his2g);
    compb = norm(his1b-his2b);
   
    comps(3,i)=(compr+compg+compb)/3;
    end
    comp = norm(reshape(output3(1:patchsize,patchsize+k,:),patchsize,3)- reshape(patchs3{i}(:,1,:),patchsize,3));
    
    comps(1,i)=comp;
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
   for dont_go_here = []
    BW1 = edge([output(patchsize-1+k:patchsize+k,1:patchsize);patchs{i}(1,:)],'canny');
    BW2 = edge([output(patchsize+k,1:patchsize);patchs{i}(1:2,:)],'canny');
    comp = norm(BW1(:,2)-BW2(:,2));
    comps(1,i)=comp;
    %comps(5,i)=comp;
   
    lbp1 = extractLBPFeatures([output(patchsize-1+k:patchsize+k,1:patchsize);patchs{i}(1,:)],'Upright',false);
    lbp2 = extractLBPFeatures([output(patchsize+k,1:patchsize);patchs{i}(1:2,:)],'Upright',false);
    comp = norm(lbp1-lbp2);
    comps(2,i)=comp;
   
    his1r = imhist(output2(patchsize-(patchsize/r)+k:patchsize+k,1:patchsize,1));
    his1g = imhist(output2(patchsize-(patchsize/r)+k:patchsize+k,1:patchsize,2));
    his1b = imhist(output2(patchsize-(patchsize/r)+k:patchsize+k,1:patchsize,3));
   
    his2r = imhist(patchs2{i}(1:(patchsize/r),:,1));
    his2g = imhist(patchs2{i}(1:(patchsize/r),:,3));
    his2b = imhist(patchs2{i}(1:(patchsize/r),:,3));
   
    compr = norm(his1r-his2r);
    compg = norm(his1g-his2g);
    compb = norm(his1b-his2b);
   
    comps(3,i)=(compr+compg+compb)/3;
    end
    comp = norm(reshape(output3(patchsize+k,1:patchsize,:),patchsize,3)- reshape(patchs3{i}(1,:,:),patchsize,3));
    comps(1,i)=comp;
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
for i = 1:pieces-4
    %comp edges
   for dont_go_here = []
    BW1 = edge([output(patchsize-1+k:patchsize+k,1+k1:patchsize+k1);patchs{i}(1,:)],'canny');
    BW2 = edge([output(patchsize+k,1+k1:patchsize+k1);patchs{i}(1:2,:)],'canny');
   %comp = norm(BW1(:,2)-BW2(:,2));
   % comps(1,i)=comp;
    %comps(5,i)=comp;
    BW11 = edge([output(1+k+patchsize:2*patchsize+k,-1+k1:+k1),patchs{i}(:,1)],'canny');
    BW22 = edge([output(1+k+patchsize:2*patchsize+k,k1),patchs{i}(:,1:2)],'canny');
    comp = norm(BW11(:,2)-BW22(:,2)) +  norm(BW1(:,2)-BW2(:,2));
    comps(1,i)=comp;


   
    lbp1 = extractLBPFeatures([output(patchsize-1+k:patchsize+k,1+k1:patchsize+k1);patchs{i}(1,:)],'Upright',false);
    lbp2 = extractLBPFeatures([output(patchsize+k,1+k1:patchsize+k1);patchs{i}(1:2,:)],'Upright',false);
    

    lbp11 = extractLBPFeatures([output(1+k+patchsize:2*patchsize+k,-1+k1:k1),patchs{i}(:,1)],'Upright',false);
    lbp22 = extractLBPFeatures([output(1+k+patchsize:2*patchsize+k,k1),patchs{i}(:,1:2)],'Upright',false);
    comp = norm(lbp1-lbp2)+norm(lbp11-lbp22);
    comps(2,i)=comp;
   
    his1r = imhist(output2(patchsize+k-(patchsize/r):patchsize+k,1+k1:patchsize+k1,1));
    his1g = imhist(output2(patchsize+k-(patchsize/r):patchsize+k,1+k1:patchsize+k1,2));
    his1b = imhist(output2(patchsize+k-(patchsize/r):patchsize+k,1+k1:patchsize+k1,3));
   
    his2r = imhist(patchs2{i}(1:(patchsize/r),:,1));
    his2g = imhist(patchs2{i}(1:(patchsize/r),:,3));
    his2b = imhist(patchs2{i}(1:(patchsize/r),:,3));
   
    compr = norm(his1r-his2r);
    compg = norm(his1g-his2g);
    compb = norm(his1b-his2b);
   
    his11r = imhist(output2(1+k+patchsize:2*patchsize+k,-(patchsize/r)+k1:k1,1));
    his11g = imhist(output2(1+k+patchsize:2*patchsize+k,-(patchsize/r)+k1:k1,2));
    his11b = imhist(output2(1+k+patchsize:2*patchsize+k,-(patchsize/r)+k1:k1,3));
   
    his22r = imhist(patchs2{i}(:,1:(patchsize/r),1));
    his22g = imhist(patchs2{i}(:,1:(patchsize/r),3));
    his22b = imhist(patchs2{i}(:,1:(patchsize/r),3));
   
    compr1 = norm(his11r-his22r);
    compg1 = norm(his11g-his22g);
    compb1 = norm(his11b-his22b);
   
    comps(3,i)=(compr1+compg1+compb1)/3 + (compr+compg+compb)/3;
    %end
   end
    comp = norm(reshape(output3(patchsize+k,1+k1:patchsize+k1,:),patchsize,3)- reshape(patchs3{i}(1,:,:),patchsize,3));

    %end
    comp1 = norm(reshape(output3(1+k+patchsize:2*patchsize+k,k1,:),patchsize,3)- reshape(patchs3{i}(:,1,:),patchsize,3));

    comps(1,i)=comp+comp1;
    %comps(5,i)=comp+comp1;
    %comps(6,i)=comp+comp1;
    %comment end here
    
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