function y = trigger_rec(i)
global daq
global recobj
global sobj
if i == 1;
    dtrig = [1 0];%AI only
elseif i == 2
    dtrig = [0 1];%TTL only
elseif i == 3
    dtrig = [1 1];%AI and TTL
end

if sobj.ScrNum ~= 0
    putvalue(daq.dio, dtrig); 
end
y = toc(recobj.STARTloop);