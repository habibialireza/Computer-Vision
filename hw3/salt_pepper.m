%input image is uint8
function output=salt_pepper(I,n)
    [s1 , s2] = size(I);
    r = rand(s1,s2);
    for i = 1:s1
        for j = 1:s2
            if r(i,j)<= n 
                sp = rand;
                if sp>=0.5
                    output(i,j)=255;
                else
                    output(i,j)=0;
                end
            else
                output(i,j)=I(i,j);
            end
        end
    end
end
