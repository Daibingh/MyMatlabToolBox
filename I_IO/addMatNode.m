function addMatNode(mat, docNode, name)
%addMatNode(mat, docNode, fatureNode, name)
%���ܣ�������ĸ��ڵ������mat�ڵ�
%���룺
%mat�����ݾ���
%docNode��������xml����
%fatureNode�����ڵ�
%name��Mat�ڵ������
fatureNode = docNode.getDocumentElement; %��ȡ���ڵ�
[m, n] = size(mat);
matNode = docNode.createElement(name); %����mat�ڵ�
matNode.setAttribute('type_id','opencv-matrix'); %����mat�ڵ�����
rows = docNode.createElement('rows'); %�����нڵ�
rows.appendChild(docNode.createTextNode(sprintf('%d',m))); %�����ı��ڵ㣬����Ϊ�е��ӽڵ�
matNode.appendChild(rows); %���нڵ���Ϊmat�ӽڵ�

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