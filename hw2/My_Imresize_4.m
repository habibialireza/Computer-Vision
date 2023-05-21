%baraye in soal man az tabdile wavelte estefadeh shodeh ast
%dar in function ebteda tasvir ra be moalefeh haye wavelet bar asase
%wavelete haar tabdil kardam. sepas az ravesh bicubic barayed afzayesh size
%moalefeh ha estefadeh kardam va sepas ba estefadeh az moalefeh hayed jadid
%tabdile mojake maakoos gereftam va tasvire resize shode ra return kardam
%in ravesh az nazare zamane ejra awli amal mikonad
function resized_image = My_Imresize_4(input_image)
factor = 2;
[LL, HL, LH, HH] = dwt2(input_image, 'haar');
LL = imresize(LL, factor, 'bicubic');
HL = imresize(HL, factor, 'bicubic');
LH = imresize(LH, factor, 'bicubic');
HH = imresize(HH, factor, 'bicubic');
output_image = idwt2(LL, HL, LH, HH, 'haar');
resized_image = (output_image);
