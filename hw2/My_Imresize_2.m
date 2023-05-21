

function resized_image = My_Imresize_2(Input_Image, Resizing_Factor)
    siz = size(Input_Image);
    h = round(siz(1) * Resizing_Factor);
    w = round(siz(2) * Resizing_Factor);
    resized_image = zeros(h, w);
    Ratio = (siz(1) - 1) / (h - 1);
    Ratio = (siz(2) - 1) / (w - 1);
    for i = 1:h
        for j = 1:w
            x = i * Ratio + 1;
            y = j * Ratio + 1;
            x1 = floor(x);
            x2 = ceil(x);
            y1 = floor(y);
            y2 = ceil(y);
            if x1 < 1
               x1 = 1;
            end
            if y1 < 1
               y1 = 1;
            end
            if x2 > siz(1)
               x2 = siz(1);
            end
            if y2 > siz(2)
               y2 = siz(2);
            end
            final = (x2 - x) * (y2 - y) * Input_Image(x1, y1) + (x2 - x) * (y - y1) * Input_Image(x1, y2) + (x - x1) * (y2 - y) * Input_Image(x2, y1) + (x - x1) * (y - y1) * Input_Image(x2, y2);
            resized_image(i, j) = final;
        end
    end
end
