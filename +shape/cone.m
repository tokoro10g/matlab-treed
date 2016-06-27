function h = cone(strngon, n, varargin)
%CONE Create a cone
%   CONE('ngon', N, ...) creates an N-cone graphic object and returns its
%   handle. Note that the first argument should be the string 'ngon'.

if ~strcmp('ngon', strngon)
    error('The first argument of the function should be ''ngon''')
end

ang = ((0:n-1)*2*pi/n)';

vert = [1 0 0; zeros(n,1) sin(ang)/2 cos(ang)/2];
fac = [2:n+1;
    ones(n,1) repmat([2 3],n,1)+([1;1]*(0:n-1))' NaN*ones(n,n-3)];
fac(n+1,3) = 2;

h = patch('Vertices',vert,...
    'Faces',fac,...
    'FaceVertexCData',[0.2 0.2 0.8],...
    'LineStyle', 'none',...
    'FaceColor','flat',varargin{:});
end