function addMatNode(mat, docNode, name)
%addMatNode(mat, docNode, fatureNode, name)
%功能：向给定的父节点中添加mat节点
%输入：
%mat：数据矩阵
%docNode：创建的xml对象
%fatureNode：父节点
%name：Mat节点的名称
fatureNode = docNode.getDocumentElement; %获取根节点
[m, n] = size(mat);
matNode = docNode.createElement(name); %创建mat节点
matNode.setAttribute('type_id','opencv-matrix'); %设置mat节点属性
rows = docNode.createElement('rows'); %创建行节点
rows.appendChild(docNode.createTextNode(sprintf('%d',m))); %创建文本节点，并作为行的子节点
matNode.appendChild(rows); %将行节点作为mat子节点

cols = docNode.createElement('cols');
cols.appendChild(docNode.createTextNode(sprintf('%d',n)));
matNode.appendChild(cols);

dt = docNode.createElement('dt');
dt.appendChild(docNode.createTextNode('d'));
matNode.appendChild(dt);

data = docNode.createElement('data');
for i=1:m
    for j=1:n
        data.appendChild(docNode.createTextNode(sprintf('%.16f ',mat(i,j))));
    end
    data.appendChild(docNode.createTextNode(sprintf('\n')));
end
matNode.appendChild(data);
fatureNode.appendChild(matNode);
end