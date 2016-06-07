function handle = modifytreed(handle, target, value)
%MODIFYTREED Modify the property of TreeD cell structure
%   MODIFYTREED(handle, target, value)
if strcmp(':scale', target)
    tr = handle.transform.Children;
    for k = 1:size(tr, 1)
        if strcmp(tr(k).Tag, 'localtrans')
            tr(k).Matrix = makehgtform('scale', value);
        elseif strcmp(tr(k).Tag, 'pretrans')
            tr(k).Matrix = makehgtform('translate', [value(1) 0 0]);
        end
    end
elseif strcmp(':transform', target)
    handle.transform.Matrix = makehgtform(value{:});
end
end

