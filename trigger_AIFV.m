function trigger_AIFV
global daq
global recobj
global sobj

%%%%%% get FV time of recording start timing%%%%%%%
Screen('FillRect', sobj.wPtr, sobj.bgcol);
%%%%%% absolute timer start %%%%%%
[sobj.vbl_1,sobj.OnsetTime_1, sobj.FlipTimeStamp_1] = Screen(sobj.wPtr, 'Flip');
if recobj.cycleNum == - recobj.prestim+1
    recobj.STARTloop= tic;
    if sobj.ScrNum ~= 0;
        putvalue(daq.dio,[1 1]); % FV10 and AI start
    end
else
    recobj.tRec = trigger_rec(1);
end

recobj.RecStartTimeToc = toc(recobj.STARTloop);%start timing counter
if recobj.cycleNum == - recobj.prestim+1
    recobj.RecStartTime = sobj.vbl_1;
    recobj.sRecStartTime = recobj.RecStartTimeToc;
end
