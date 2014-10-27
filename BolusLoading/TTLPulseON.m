function TTLPulseON
global dio
global ui
if get(ui.onpulse,'value')==1
    putvalue(dio,1);
else
    putvalue(dio,0);
    set(ui.onpulse,'value',0);
end