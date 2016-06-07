function h = box(varargin)
%BOX Create a box
%   BOX(...) creates a box object and returns its handle.

vert = [repmat([0;1],4,1) [1 1; 1 1; -1 1; -1 1; -1 -1; -1 -1; 1 -1; 1 -1]/2];
fac = [1:2:7; 2:2:8; % cap
    mod(repmat([1 0 2 3],4,1)+repmat(2*(0:3)',1,4),8)+ones(4,4)];

h = patch('Vertices',vert,...
    'Faces',fac,...
    'FaceVertexCData',[0.2 0.2 0.8],...
    'LineStyle', 'none',...
    'FaceColor','flat',varargin{:});

end

