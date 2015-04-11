function autoFlowChart(mFile)

% autoFlowChart('driverFlowChart.m')
% autoFlowChart('rayRK4.m')
%mFile = 'test2.m';
%mFile = 'IwenoL1b.m';
[subFunction, subFunctionIndex,Mmain] = getSubFunc(mFile);

M = numel(subFunction);
cm = zeros(M);
cm(Mmain,:) = subFunctionIndex;
%keyboard
subFun = cell(1,M);
for m = 1:M
    if m ~= Mmain
        [tempFunc, tempIdex,~] = getSubFunc(subFunction,m,Mmain);
        cm(m,:) = tempIdex;
    end
end

bg2 = biograph(cm,subFunction);
get(bg2.nodes,'ID');
% view(bg2); 
g = biograph.bggui(bg2);
f = figure;
copyobj(g.biograph.hgAxes,f);
%f = get(g.biograph.hgAxes, 'Parent');
%print(f, '-djpeg', [mFile(1:end-2) '_flowChart.jpeg'])

%find and close the biograph viewer
child_handles = allchild(0);
names = get(child_handles,'Name');
k = find(strncmp('Biograph Viewer', names, 15));
close(child_handles(k))
end
function [Name,temp,m] = getSubFunc(mFile,varargin)

if isempty(varargin)
    [fList,~] = matlab.codetools.requiredFilesAndProducts(mFile);
    gettingSubfunction = 0;
else ~isempty(varargin);
    gettingSubfunction = 1;
    m = varargin{1};
    Mmain = varargin{2};
    funFile = mFile(m);
    M = numel(mFile);
    [fList,~] = matlab.codetools.requiredFilesAndProducts(funFile);
end

numFunctions = numel(fList);
Name = cell(1,numFunctions);

for i = 1:numFunctions
    temp = strsplit(fList{i},'/'); Name{i} = temp{end};
end

if gettingSubfunction
    temp = cellfun(@(s) strfind(funFile, s), Name,'UniformOutput',false);
    temp = ~cellfun(@isempty,temp);
    subFunctionIndex = zeros(size(mFile));
    subFunctionIndex(temp) = temp;
    temp = subFunctionIndex;
    %temp(Mmain) = 1; 
    %temp(m) = 0;
else
    temp = cellfun(@(s) strfind(mFile, s), Name,'UniformOutput',false);
    temp = ~cellfun(@isempty,temp);
    m = find(temp);
end

end