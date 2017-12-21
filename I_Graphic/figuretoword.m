function figuretoword(h,str)
%该函数将绘制的图像粘贴到指定的Word文件的光标所在之处
%参数：
%h-----图像句柄
%str---Word文件全路径
% 判断Word是否已经打开，若已打开，就在打开的Word中进行操作，否则就打开Word
try
    % 若Word服务器已经打开，返回其句柄Word
    Word = actxGetRunningServer('Word.Application');
catch
    % 创建一个Microsoft Word服务器，返回句柄Word
    Word = actxserver('Word.Application'); 
end;

% 设置Word服务器为可见状态
set(Word, 'Visible', 1);     %或Word.Visible = 1;
Document = Word.Documents.Open(str);    % 新建一个空白文档

Selection = Word. Selection;    % 返回Word服务器的Selection接口的句柄
print(h,'-dmeta');    %将图形复制到剪贴板
Selection.Paste;    % 在当前光标位置处插入剪贴板上的图片，版式为嵌入式
Selection.TypeParagraph;    % 回车，另起一段
% Selection.PasteSpecial;    % 在当前光标位置处插入剪贴板上的图片，版式为浮于文字上方
Document.Save;
end