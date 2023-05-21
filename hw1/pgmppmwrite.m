function  pgmppmwrite(I,x)
%pgm
if ndims(I)==2
    imsize = size(I);
    rows=imsize(1);
    cols=imsize(2);
    pgmheader=sprintf('P5 %d %d 255\n',cols,rows);
    f =fopen(x,'w');
    fwrite(f,pgmheader);
    for i=1:imsize(1)
        for j=1:imsize(2)
            fwrite(f,I(i,j));
        end
    end
    fclose(f);
end
%ppm
if ndims(I)==3
    imsize = size(I);
    rows=imsize(1);
    cols=imsize(2);
    ppmheader=sprintf('P6 %d %d 255\n',cols,rows);
    f =fopen(x,'w');
    fwrite(f,ppmheader);
    for i=1:imsize(1)
        for j=1:imsize(2)
            fwrite(f,I(i,j,1));
            fwrite(f,I(i,j,2));
            fwrite(f,I(i,j,3));
        end
    end
fclose(f);
end
end