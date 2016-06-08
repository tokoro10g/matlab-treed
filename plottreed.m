function tdhandles = plottreed(tree, varargin)
%PLOTTREED Plot TreeD cell structure
%   TDHANDLES = PLOTTREED(TREE) plots TreeD cell structure TREE on figure.
%
%   TDHANDLES = PLOTTREED(TREE, 'Parent', TDHANDLE) plots TreeD cell
%   structure under TDHANDLE.
%
%   See also MODIFYTREED, DESTROYTREED, PRINTTREED

root = struct;
root.id = 'root';
root.handle = [];
root.transform = hgtransform('Tag', 'root');
root.scale = [0 0 0];

if nargin > 2
    if strcmp('Parent', varargin{1})
        set(root.transform, 'Parent', varargin{2}.transform, ...
            'Matrix', makehgtform('translate', [varargin{2}.scale(1) 0 0]));
    end
end

tdhandles = processlevel(tree,root);

end

function tdhandles = processlevel(tree, parent, varargin)

n = size(tree, 1);
if nargin > 2
    tdhandles = varargin{1};
else
    tdhandles = struct;
end

% iterate over nodes
for k = 1:n
    if isa(tree{k,1}, 'function_handle')
        func = tree{k,1};
        props = tree{k,2};
        
        args = {};
        transform = {};
        children = {};
        id = 'node'; % default ID
        id_found = false;
        
        if isequal(func, @shape.null)
            scale = [0 0 0];
        else
            scale = [1 1 1];
        end
        
        % iterate over properties
        for l = 1:size(props, 1)
            key = props{l,1};
            value = props{l,2};
            if ischar(key)
                if strcmp(':id', key)
                    id = value;
                    id_found = true;
                elseif strcmp(':transform', key)
                    tmp = value';
                    transform = [transform, tmp{:}];
                elseif strcmp(':scale', key)
                    scale = value;
                else
                    args = [args key value];
                end
            elseif isa(key, 'function_handle')
                children = [children; props(l,:)];
            else
                error('%s\nCell location: (%d,1) in Node %s','The key of each property must be a string.',l,char(func))
            end
        end
        
        % process node
        hpretrans = hgtransform('Parent', parent.transform, 'Tag', 'pretrans', ...
            'Matrix', makehgtform('translate', [parent.scale(1) 0 0]));
        
        htrans = hgtransform('Parent', hpretrans, 'Tag', 'trans', ...
            'Matrix', makehgtform(transform{:}));
        
        if isequal(func, @shape.null)
            args = [args, {'Parent', htrans, 'Tag', 'localtrans'}];
        else
            hlocaltrans = hgtransform('Parent', htrans, 'Tag', 'localtrans', ...
                'Matrix', makehgtform('scale', scale));
            args = [args, {'Parent', hlocaltrans}];
        end
        
        handle = func(args{:});
        
        % check for invalid ID
        if id_found && ~isvarname(id)
            newid = matlab.lang.makeValidName(id);
            warning('Node ID ''%s'' is invalid. Renamed to ''%s''.', id, newid);
            id = newid;
            clear newid
        end
        % resolve duplicated IDs
        ids = matlab.lang.makeUniqueStrings(['node'; fieldnames(tdhandles); id]);
        if ~strcmp(id, ids{end})
            if id_found
                warning('Node ID ''%s'' already exists. Renamed to ''%s''.', id, ids{end});
            else
                warning('Node ID is not specified. Set to ''%s''.\nCell location: (%d,1)', ids{end}, k);
            end
            id = ids{end};
        end
        
        tdhandles.(id).id = id;
        tdhandles.(id).handle = handle;
        tdhandles.(id).function = func;
        tdhandles.(id).args = args(1:end-2);
        tdhandles.(id).transform = htrans;
        tdhandles.(id).scale = scale;
        tdhandles.(id).parent_id = parent.id;
        
        % process children
        if size(children, 1) > 0
            tdhandles = processlevel(children, tdhandles.(id), tdhandles);
        end
    else
        error('%s\nCell location: (%d,1)','The first element of each node must be a function_handler.',k)
    end
end

end