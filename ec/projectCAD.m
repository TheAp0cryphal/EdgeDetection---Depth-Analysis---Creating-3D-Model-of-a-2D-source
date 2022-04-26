load('../data/PnP.mat');

P = estimate_pose(x, X);
[K, R, t] = estimate_params(P);
figure
imshow(image);
hold on;
s = size(X,2);

c = P*[X; ones(1, s)];

%Convertign 3D points to 2D

c = c ./ c(3,:);
plot3(c(1,:), c(2,:), c(3,:), 'ro', 'MarkerSize', 10);
plot(x(1,:), x(2,:), 'g.', 'MarkerSize', 10);
hold off

figure
trimesh(cad.faces, cad.vertices(:, 1), cad.vertices(:, 2), cad.vertices(:, 3), 'EdgeColor', 'cyan');

proj = P*[cad.vertices.'; ones(1, size(cad.vertices, 1))];
proj = proj ./ proj(3, :);


hold on
imshow(image)
face = cad.faces(:,1:2);
patch('Faces', face, 'Vertices', [proj(1,:).', proj(2,:).'], 'EdgeColor', 'red');
hold off

