function SelectSaveFile
global recobj

if isfield(recobj,'dirname') == 0
    [recobj.fname,recobj.dirname] = uiputfile('*.*');
else %��x�t�H���_��I�����Ă���ꍇ�͓����t�H���_�ł��ŏ��ɊJ��
    recobj.fname = uiputfile('*.*','Select File to Write',recobj.dirname);
end

%�g���q�͂���
pat = regexptranslate('wildcard', '.*');
if recobj.fname ~= 0
    recobj.fname = regexprep(recobj.fname, pat,'');
end

