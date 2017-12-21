function readXML(file)
%readXML(file)
%功能：解析opencv保存的xml文件中的Mat数据，并保存到data.mat中
%输入：
%file：xml文件名
theStruct = parseXML(file);
num =1;
N = length(theStruct.Children);
for i=1:N
    if ~isempty(theStruct.Children(i).Attributes) && strcmp(theStruct.Children(i).Attributes.Name, 'type_id') &&  strcmp(theStruct.Children(i).Attributes.Value, 'opencv-matrix')
        %         varName{num} = theStruct.Children(i).Name;
        %         varName{num} = strrep(varName{num},'-','_');
        for j=1:length(theStruct.Children(i).Children)
            if strcmp(theStruct.Children(i).Children(j).Name,'rows')
                m = str2double(theStruct.Children(i).Children(j).Children.Data);
            elseif strcmp(theStruct.Children(i).Children(j).Name,'cols')
                n = str2double(theStruct.Children(i).Children(j).Children.Data);
            elseif strcmp(theStruct.Children(i).Children(j).Name, 'dt')
                dt = theStruct.Children(i).Children(j).Children.Data;
            elseif strcmp(theStruct.Children(i).Children(j).Name,'data')
                str = theStruct.Children(i).Children(j).Children.Data;
                str = strtrim(str);
                temp_cell = regexp(str, '\s+', 'split');
                temp = zeros(length(temp_cell),1);
                for k=1:length(temp)
                    temp(k) = str2double(temp_cell{k});
                end
            end
        end
        if strcmp(dt, 'd')
            varName{num} = theStruct.Children(i).Name;
            varName{num} = strrep(varName{num},'-','_');
            temp1 = reshape(temp, m,n);
            eval([varName{num}, '=temp1;']);
            num = num +1;
        end
    end
end
save('data.mat',varName{1});
if length(varName) > 1
    for i=2:length(varName)
        save('data.mat', varName{i}, '-append');
    end
end
disp('数据保存到data.mat成功！');
end

function theStruct = parseXML(filename)
% PARSEXML Convert XML file to a MATLAB structure.
try
    tree = xmlread(filename);
catch
    error('Failed to read XML file %s.',filename);
end

% Recurse over child nodes. This could run into problems
% with very deeply nested trees.
try
    theStruct = parseChildNodes(tree);
catch
    error('Unable to parse XML file %s.',filename);
end
end


% ----- Local function PARSECHILDNODES -----
function children = parseChildNodes(theNode)
% Recurse over node children.
children = [];
if theNode.hasChildNodes
    childNodes = theNode.getChildNodes;
    numChildNodes = childNodes.getLength;
    allocCell = cell(1, numChildNodes);
    
    children = struct(             ...
        'Name', allocCell, 'Attributes', allocCell,    ...
        'Data', allocCell, 'Children', allocCell);
    
    for count = 1:numChildNodes
        theChild = childNodes.item(count-1);
        children(count) = makeStructFromNode(theChild);
    end
end
end

% ----- Local function MAKESTRUCTFROMNODE -----
function nodeStruct = makeStructFromNode(theNode)
% Create structure of node info.

nodeStruct = struct(                        ...
    'Name', char(theNode.getNodeName),       ...
    'Attributes', parseAttributes(theNode),  ...
    'Data', '',                              ...
    'Children', parseChildNodes(theNode));

if any(strcmp(methods(theNode), 'getData'))
    nodeStruct.Data = char(theNode.getData);
else
    nodeStruct.Data = '';
end
end

% ----- Local function PARSEATTRIBUTES -----
function attributes = parseAttributes(theNode)
% Create attributes structure.

attributes = [];
if theNode.hasAttributes
    theAttributes = theNode.getAttributes;
    numAttributes = theAttributes.getLength;
    allocCell = cell(1, numAttributes);
    attributes = struct('Name', allocCell, 'Value', ...
        allocCell);
    
    for count = 1:numAttributes
        attrib = theAttributes.item(count-1);
        attributes(count).Name = char(attrib.getName);
        attributes(count).Value = char(attrib.getValue);
    end
end
end