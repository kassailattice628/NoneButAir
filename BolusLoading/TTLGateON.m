function TTLGateON
global gatet
global loopint
global ui
global T

if get(ui.ongate,'value')==1
    T = timer('TimerFCN','TTLFCN;');
    if get(ui.onloop,'value')==1% loop on
        set(T, 'period',gatet+loopint,'ExecutionMode','fixedRate');
        start(T)
    else % single shot
        set(T, 'period', gatet,'ExecutionMode','singleShot');
        start(T);
        set(ui.ongate,'value',0);
    end
end