function destroytreed(tdhandles)
%DESTROYTREED Destroy TreeD graphic objects
%   DESTROYTREED(TDHANDLES) deletes graphic objects specified by TDHANDLES.
%   HANDLES should be a returned value of plottreed function.
%
%   See also PLOTTREED

nodenames = fieldnames(tdhandles);
node = tdhandles.(nodenames{1}).handle;
while ~strcmp('root', node.Tag) && ~isa(node, 'Axes')
    node = node.Parent;
end
h = findobj(node);
delete(h);

end

