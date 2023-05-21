function output_image = My_Imresize_3(Input_Image, Resizing_Factor)
Input_Image = im2double(Input_Image);
[h, w] = size(Input_Image);
h2 = round(h * Resizing_Factor);
w2 = round(w * Resizing_Factor);
output_image = zeros(h2, w2);
for i = 1:h2
    for j = 1:w2
        x = (i)/Resizing_Factor;
        y = (j)/Resizing_Factor;        
        if x < 1  
        x=1;
        end
        if x>w -1
        x=w-1;
        end
        if y < 1  
        y=1;
        end
        if y>h -1
        y=h-1;
        end
        distances = zeros(4,1);
        distances(1)=sqrt((x-floor(x))^2 + (y-floor(y))^2);
        distances(2)=sqrt((x-floor(x))^2+(floor(y)+1-y)^2);
        distances(3)=sqrt((floor(x)+1-x)^2 + (y-floor(y))^2);
        distances(4)=sqrt((floor(x)+1-x)^2 + (floor(y)+1-y)^2);
        sum_distances = sum(distances);
        if sum_distances > 0
        weights = distances ./ sum_distances;
        output_image(i,j) = weights(1) * Input_Image(floor(x),floor(y)) + weights(2) * Input_Image(floor(x),floor(y)+1) + weights(3) * Input_Image(floor(x)+1,floor(y)) + weights(4) * Input_Image(floor(x)+1,floor(y)+1);
        else
        output_image(i,j) = Input_Image(x,y);
        end
    end
end
end
%output_image = uint8(output_image);
