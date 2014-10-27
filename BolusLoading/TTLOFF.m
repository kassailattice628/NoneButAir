function TTLOFF
global ui
global T
global dio

if isempty(T)
else
    if isvalid(T)
    else
        if strcmp(T.Running,'on')
            stop(T);
            delete(T);
            clear T;
        end
    end
end
putvalue(dio,0);
disp('TTL_OFF');
set(ui.onpulse,'value',0);
set(ui.ongate,'value',0);
set(ui.onloop, 'string','Loop-off','value',0, 'BackGroundColor','w');
