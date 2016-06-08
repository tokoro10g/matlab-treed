function modifytreed(tdhandle, property, value)
%MODIFYTREED Modify the property of TreeD object
%   MODIFYTREED(TDHANDLE, PROPERTY, VALUE) modifies the property of TreeD
%   object. TDHANDLE specifies which object to be modified. PROPERTY must
%   be one of the following character strings:
%   
%      ':scale'            : Adjusts the scale of the object. VALUE should
%                            be a non-zero 1 x 3 vector.
%
%                            e.g. MODIFYTREED(tdh, ':scale', [0.1 0.1 1])
%
%      ':transform'        : Changes the transformation matrix. VALUE must
%                            be a cell array which contains argument list
%                            that can be passed to hgtransform function.
%
%                            e.g. MODIFYTREED(tdh, ':transform', ...
%                                     { 'xrotate', pi/6, ...
%                                       'translate', [1 1 0] })
%
%      Properties of patch : Modifies the properties of the graphic object
%                            such as color, transparency, or visibility.
%                            See patch for more details.
%
%   See also PLOTTREED, PATCH, HGTRANSFORM

% pre-defined properties
if strcmp(':scale', property)
    tr = tdhandle.transform.Children;
    for k = 1:size(tr, 1)
        if strcmp(tr(k).Tag, 'localtrans')
            tr(k).Matrix = makehgtform('scale', value);
        elseif strcmp(tr(k).Tag, 'pretrans')
            tr(k).Matrix = makehgtform('translate', [value(1) 0 0]);
        end
    end
elseif strcmp(':transform', property)
    tdhandle.transform.Matrix = makehgtform(value{:});
else % otherwise
    args = tdhandle.args;
    found = false;
    for k = 1:2:size(args, 2)
        if strcmp(property, args{k})
            found = true;
            args(k+1) = {value};
        end
    end
    if ~found
        args = [args {property value}];
    end
    set(tdhandle.handle, args{:});
end
end

