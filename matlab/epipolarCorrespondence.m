function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)

% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2

x1 = pts1(:, 1); %x coordinates of image1
y1 = pts1(:, 2); %y coordinates of image1

pts1 = ([pts1,1].');
epiLine = F*pts1;
scale = norm(epiLine(1:2));
epiLine = epiLine/scale;


w=18;


im1_frame = double(im1((y1-w):(y1+w), (x1-w):(x1+w)));
prev_error = inf;

frame = round(cross(epiLine,[-epiLine(2) epiLine(1) epiLine(2)*x1-epiLine(1)*y1]')); 

for i=frame(1)-20:frame(1)+20
    
	for j=frame(2)-20:frame(2)+20 
        
        im2_frame = double(im2(j-w:j+w,i-w:i+w));
        
        curr_error = norm(sqrt((im1_frame - im2_frame).^2));
        
        if curr_error < prev_error
            
            prev_error=curr_error;
            x2=i;
            y2=j;
            pts2 = [x2, y2, 1];
            
        end   
	end
end

end