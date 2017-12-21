function K = getKcr(G,span,e,~)
%K = getKcr(G,span,e,~)
%���ܣ���ʹ�ջ�ϵͳ�ȶ����ٽ����棬ʹ�õݹ����
%���룺
%G���������ݺ���
%span����������K������
%e���������
%�����
%K���ٽ�����
    if nargin == 3
        k1 = span(1);
        k2 = span(2);
        F1=1+k1*G;
        F2=1+k2*G;
        p1=roots(cell2mat(F1.num));
        p2=roots(cell2mat(F2.num));
        if ~all(real(p1)<0) || all(real(p2)<0)
            fprintf('this span is not correct!');
            return;
        end
    end
    k1 = span(1);
    k2 = span(2);
    if abs(k1-k2)<e
        K=k1;
        return;
    end
    k=(k1+k2)/2;
    F=1+k*G;
    p=roots(cell2mat(F.num));
    if real(p)<0
        span(1)=k;
    else span(2)=k;
    end
    K = getKcr(G,span,e,1);   
end