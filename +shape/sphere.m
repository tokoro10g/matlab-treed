function h = sphere(varargin)
%SPHERE Create a sphere
%   SPHERE(...) creates a sphere graphic object.

n = 50;

theta = (-n:2:n)/n*pi;
phi = (-n:2:n)'/n*pi/2;
cosphi = cos(phi); cosphi(1) = 0; cosphi(n+1) = 0;
sintheta = sin(theta); sintheta(1) = 0; sintheta(n+1) = 0;

x = cosphi*cos(theta);
y = cosphi*sintheta;
z = sin(phi)*ones(1,n+1);

x = x + 1;

p = surf2patch(x,y,z);

h = patch('Vertices',p.vertices,...
    'Faces',p.faces,...
    'FaceVertexCData',[0.2 0.2 0.8],...
    'LineStyle', 'none',...
    'FaceColor','flat',varargin{:});
end

