function TTLLoop
global ui

if get(ui.onloop,'value')==1
    set(ui.onloop,'string','Loop','BackGroundColor','g');
else
    set(ui.onloop,'string','Loop-off','BackGroundColor','w');
end