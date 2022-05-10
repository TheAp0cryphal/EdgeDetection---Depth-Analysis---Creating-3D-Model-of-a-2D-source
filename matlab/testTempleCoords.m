load('../data/someCorresp.mat')
load('../data/intrinsics.mat')
Img1 = imread('../data/im1.PNG');
Img2 = imread('../data/im2.PNG');
F = eightpoint(pts1, pts2, M);

%epipolarMatchGUI(Img1, Img2, F);


load('../data/templeCoords.mat')
num = size(pts1,1);

%Essential Matrix from intrinstics and F
E = essentialMatrix(F,K1,K2) 
disp(E);

P1 = [eye(3), zeros(3,1)]; %Identity Matrix [1 0 0 0; 0 1 0 0; 0 0 1 0] 
potentialP2  = camera2(E);

for i = 1:size(pts1,1)
    [pts2] = epipolarCorrespondence(Img1, Img2, F, pts1(i,:));
    x(i,:) = pts2;
end


%triangulate the 4 potential camera2 points


for i = 1:4 
 T = triangulate(K1*P1, pts1, K2*potentialP2(:,:,i), x);
     if all(T(3,:) > 0)
        T_ = T;
        F = potentialP2(:,:,i);
    end
end

R1=P1(1:3,1:3);
t1=P1(:,4);
R2=F(1:3,1:3);
t2=F(:,4);

save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
plot3(T_(1,:),T_(2,:),T_(3,:),'.');
axis equal
%}