function resized_image = My_Imresize_1(Input_Image, Resizing_Factor)
    siz = size(Input_Image);
    h = round(siz(1) * Resizing_Factor);
    w = round(siz(2) * Resizing_Factor);
    resized_image = zeros(h, w);
    for i = 1:h
        for j = 1:w
            x = round(i / Resizing_Factor);
            y = round(j / Resizing_Factor);
            if x < 1
               x = 1;
            elseif x > siz(1)
               x = siz(1);
            end
            if y < 1
               y = 1;
            elseif y > siz(2)
               y = siz(2);
            end
            resized_image(i, j) = Input_Image(x, y);
        end
    end
end
