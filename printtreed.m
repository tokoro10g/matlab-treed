function printtreed(tree)
%PRINTTREED Gracefully print TreeD cell structure
%   PRINTTREED(tree) prints out TreeD cell structure better than DISP or
%   CELLDISP function. This function is useful when examining generated
%   TreeD cell structure.

if isempty(inputname(1))
    disp('tree = {')
else
    disp([inputname(1) ' = {'])
end

printlevel(tree, 1);
disp('}')

end

function printlevel(tree, k)
n = size(tree, 1);

for l = 1:n
    if isa(tree{l,1}, 'function_handle')
        disp([indent(k) '@' char(tree{l,1}) ' {'])
        props = tree{l,2};
        for m = 1:size(props, 1)
            key = props{m,1};
            value = props{m,2};
            if isa(key, 'function_handle')
                printlevel(props(m,:), k+1);
            else
                valuestr = value2str(value);
                disp([indent(k+1) '''' key ''', ' valuestr ';'])
            end
        end
        disp([indent(k) '}'])
    else
    end
end

end

function s = indent(k)
s = repmat(' ', 1, 4*k);
end

function s = value2str(value)
if ischar(value)
    s = ['''' value ''''];
elseif isnumeric(value)
    if isscalar(value)
        s = num2str(value);
    elseif ismatrix(value)
        s = mat2str(value);
    end
elseif iscell(value)
    s = '{ ';
    h = size(value, 1);
    w = size(value, 2);
    for k = 1:h
        if k == 1
            s = [s value2str(value{k,1})];
        else
            s = [s '; ' value2str(value{k,1})];
        end
        for l = 2:w
            s = [s ', ' value2str(value{k,l})];
        end
    end
    s = [s ' }'];
end
end