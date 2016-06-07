function handle = null(varargin)
%NULL Create a handle of null shape
%   NULL(...) returns hggroup(...). This shape is normally used for
%   defining a group of shapes to be transformed.
    handle = hggroup(varargin{:});
end

