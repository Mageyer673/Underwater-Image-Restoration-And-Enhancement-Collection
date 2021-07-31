function imrestored = main2(doDegradation,inpath,v1)
% Stretch is only applied on saturation, value channel's Approximate decomposition in level 1.

% I_in=imread('.\images\test12.png');
pwd0=cd('..');
[I_in,imref] = load_image(doDegradation,inpath);     
cd(pwd0);
I = im2double(I_in);
I = rgb2hsv(I);
namewavelet = 'sym3';
n = 3;
[imheight imwidth ~] = size(I);
for i = 2:3
    [c,s]= wavedec2(I(:,:,i),n,namewavelet);
    [H,V,D] = detcoef2('a',c,s,1);
    A = appcoef2(c,s,namewavelet,1);
    A = strechimage1(A,v1);
    I_out(:,:,i-1) = idwt2(A,H,V,D,namewavelet);
end
I_out= imresize(I_out, [imheight imwidth], 'nearest');
imfinal(:,:,1) = I(:,:,1);
imfinal(:,:,2) = I_out(:,:,1);
imfinal(:,:,3) = I_out(:,:,2);
I_out = hsv2rgb(imfinal);
imrestored = im2uint8(I_out);
end

function Is = strechimage1(data,s)
    % s=0.003;
    bins=2000;
    [ht,b]=imhist(data,bins);
    [m,n]=size(data);
    d=cumsum(ht)./double(m*n);
    lmin=1;lmax=bins;
    while lmin<bins
         if d(lmin)>s
             break;
         end    
         lmin=lmin+1;
    end    
    while lmax>1
         if d(lmax)<=1-s
             break;
         end    
         lmax=lmax-1;
    end
    
    Is=((data-b(lmin))./(b(lmax)-b(lmin))); 
    Is(find(Is>1))=1;
    Is(find(Is<0))=0;
    
    end