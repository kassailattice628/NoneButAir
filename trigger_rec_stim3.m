function trigger_rec_stim3
global daq
global recobj
global figUIobj
global sobj

tTTL = tic;%start timing counter

if get(figUIobj.TTL2, 'value') == 1 %<- trigger for FV
    % P0.0 for AI Trigger, P0.1 for FV Trigger (need only 1st cycle)
    if recobj.cycleNum == 1- recobj.prestim;
        putvalue(daq.dio,[1 1]); % FV10 and AI start
         sobj.RecStartTime = sobj.vbl_1; 
    else
        putvalue(daq.dio,[1 0]); % Trigger for only AI
    end

else % TTL2 at evelry cycle
    if recobj.delayTTL2 ~= 0
        while toc(recobj.tAI) <= recobj.delayTTL2/1000;%wait TTL2 delay
        end
        putvalue(daq.dio,[1 1]); % TTL2 and AI start
        recobj.tTTL2 = toc(tTTL);
    end
end



