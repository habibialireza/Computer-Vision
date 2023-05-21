%clc;clear all;
%x is the path string of the pgm file 
%y is the array corresponding to the pgm file
function y = pgmppmread(x)
%x='./1/sample.pgm';
F = fopen(x);
content = fread(F);
fclose(F);
text=fileread(x);
if(text(1)=='P' && text(2)=='5')
flag = 0;
i = 4;
rows="";
cols="";
while 1
    if(content(i)==32)
        %fprintf('if%d\n',i);
        i=i+1;
        while content(i)~=32
            cols=[cols,text(i)];
            i=i+1;
        end
        break
    end
    rows=[rows,text(i)];
    i=i+1;    
end

rsize = size(rows);
i = rsize(2);
rows_main = 0;
for c = 2:rsize(2)
    rows_main = rows_main + str2num(rows(c)) * 10^(i-2);
    i = i-1;
end

csize = size(cols);
i = csize(2);
cols_main = 0;
for c = 2:csize(2)
    cols_main = cols_main + str2num(cols(c)) * 10^(i-2);
    i = i-1;
end
i = 1;
while content(i)~=10
    i = i + 1;
end

content = content(i+1:end);
y = reshape(content,rows_main,cols_main);
y = rot90(rot90(rot90(y)));
y = (cast(y,'uint8'));
end


if(text(1)=='P' && text(2)=='6')
flag = 0;
i = 4;
rows="";
cols="";
while 1
    if(content(i)==32)
        i=i+1;
        while content(i)~=32
            cols=[cols,text(i)];
            i=i+1;
        end
        break
    end
    rows=[rows,text(i)];
    i=i+1;    
end

rsize = size(rows);
i = rsize(2);
rows_main = 0;
for c = 2:rsize(2)
    rows_main = rows_main + str2num(rows(c)) * 10^(i-2);
    i = i-1;
end

csize = size(cols);
i = csize(2);
cols_main = 0;
for c = 2:csize(2)
    cols_main = cols_main + str2num(cols(c)) * 10^(i-2);
    i = i-1;
end
i = 1;
while content(i)~=10
    i = i + 1;
end

content = content(i+1:end);
r = content(1:3:end);
g = content(2:3:end);
b = content(3:3:end);

r = reshape(r,rows_main,cols_main);
g = reshape(g,rows_main,cols_main);
b = reshape(b,rows_main,cols_main);
img = zeros(rows_main,cols_main,3);
img (:,:,1)=r;
img (:,:,2)=g;
img (:,:,3)=b;
y = rot90(rot90(rot90(img)));
y = (cast(y,'uint8'));
end


end

