function h = prism(strngon, n, varargin)
%PRISM Create a prism
%   PRISM('ngon', N, ...) creates an N-prism graphic object and returns its
%   handle. Note that the first argument should be the string 'ngon'.

if ~strcmp('ngon', strngon)
    error('The first argument of the function should be ''ngon''')
end

ang = reshape([1;1]*(0:n-1)*2*pi/n,1,[])';

vert = [repmat([0;1],n,1) sin(ang)/2 cos(ang)/2];
fac = [1:2:2*n-1; 2:2:2*n; % cap
    mod(repmat([1 0 2 3],n,1)+repmat(2*(0:n-1)',1,4),2*n)+ones(n,4) NaN*ones(n,n-4)];

h = patch('Vertices',vert,...
    'Faces',fac,...
    'FaceVertexCData',[0.2 0.2 0.8],...
    'LineStyle', 'none',...
    'FaceColor','flat',varargin{:});
end

