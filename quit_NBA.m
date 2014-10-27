function quit_NBA
global sobj
global daq

if sobj.ScrNum ~= 0
Screen('Close', sobj.wPtr);
delete(daq.ai);
%delete daq.ao
putvalue(daq.dio,[0 0]);
delete(daq.dio);
clear daq;
daqreset;
end
close all;