function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.

w = (windowSize-1)/2
im1 = double(im1);
im2 = double(im2);
row = size(im1 , 1);
col = size(im1 , 2);
var = zeros(row, col);

for i=w:row                                                
    for j=w:col                                            
        filter1=im1(i-w+1:i+w-1,j-w+1:j+w-1, 1);                        
        for j1 = j:min([j+maxDisp,col-w])                         
            filter2=im2(i-w+1:i+w-1,j1-w+1:j1+w-1, 1);               
            diff(j1-j+1) = sum(abs(filter1-filter2), 'all');                                                                      
        end
        [~ ,argmin] = min(diff);                      
        var(i,j) = argmin;                              
    end 
end
dispM = var/maxDisp;   




