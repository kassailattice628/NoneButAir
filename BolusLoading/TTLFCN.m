function TTLFCN
global gatet
global dio
global T
global ui

if get(ui.ongate,'value')==1
    %ON
    putvalue(dio,1);
    if get(ui.onloop, 'value') == 1
        disp('Loop TTL_ON');
    else
        disp('Single TTL_ON');
    end
    %TTLéùë±éûä‘
    pause(gatet);
    putvalue(dio,0);
    if get(ui.onloop, 'value') == 1
        disp('Loop TTL_OFF');
    else
        disp('Single TTL_OFF');
    end

else % gate êÿÇ¡ÇΩÇÁ Timer stop
    stop(T);
    delete(T)
    putvalue(dio,0);
    disp('OFF');
    set(ui.ongate,'value',0);
    set(ui.onloop, 'string','Loop-off','value',0, 'BackGroundColor','w');
end


