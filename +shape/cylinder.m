function handle = cylinder(varargin)
%CYLINDER Create a cylinder
%   CYLINDER(...) returns the graphic handle of a created cylinder.
args = [{'ngon', 200} varargin];
handle = shape.prism(args{:});
end

