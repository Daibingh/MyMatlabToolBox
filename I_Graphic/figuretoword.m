function figuretoword(h,str)
%�ú��������Ƶ�ͼ��ճ����ָ����Word�ļ��Ĺ������֮��
%������
%h-----ͼ����
%str---Word�ļ�ȫ·��
% �ж�Word�Ƿ��Ѿ��򿪣����Ѵ򿪣����ڴ򿪵�Word�н��в���������ʹ�Word
try
    % ��Word�������Ѿ��򿪣���������Word
    Word = actxGetRunningServer('Word.Application');
catch
    % ����һ��Microsoft Word�����������ؾ��Word
    Word = actxserver('Word.Application'); 
end;

% ����Word������Ϊ�ɼ�״̬
set(Word, 'Visible', 1);     %��Word.Visible = 1;
Document = Word.Documents.Open(str);    % �½�һ���հ��ĵ�

Selection = Word. Selection;    % ����Word��������Selection�ӿڵľ��
print(h,'-dmeta');    %��ͼ�θ��Ƶ�������
Selection.Paste;    % �ڵ�ǰ���λ�ô�����������ϵ�ͼƬ����ʽΪǶ��ʽ
Selection.TypeParagraph;    % �س�������һ��
% Selection.PasteSpecial;    % �ڵ�ǰ���λ�ô�����������ϵ�ͼƬ����ʽΪ���������Ϸ�
Document.Save;
end