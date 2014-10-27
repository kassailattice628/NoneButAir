function Grating_stim(i)

global sobj
global recobj
global figUIobj

pause(0.001)

trigger_AIFV;
for ii=1:sobj.mDFs
    %monitor stim ON
    x1 = sobj.pos(1,sobj.Y(i))-sobj.stimsz(1)/2;
    y1 = sobj.pos(2,sobj.X(i))-sobj.stimsz(2)/2;
    x2 = sobj.pos(1,sobj.Y(i))+sobj.stimsz(1)/2;
    y2 = sobj.pos(2,sobj.X(i))+sobj.stimsz(2)/2;
    sobj.position_cord = [x1,y1,x2,y2];
    Screen('DrawTexture',sobj.wPtr,sobj.tex(sobj.movieFrameIndices(ii)),[],sobj.position_cord);
    %PhotoSensor用
    Screen('FillRect', sobj.wPtr, 255, [0 0 40 40]);
    if recobj.delayTTL2/1000 <= sobj.delayPTB
        while toc(recobj.STARTloop) - recobj.RecStartTimeToc <= recobj.delayTTL2/1000;%wait TTL2 delay (include delay TTL2 == 0)
        end
        if get(figUIobj.TTL2, 'value') ==0
            recobj.tTTL2 = trigger_rec(2) -  recobj.RecStartTimeToc;
        else
            recobj.tTTL2 = 0;
        end
        if ii == 1
            %[sobj.vbl_2, sobj.OnsetTime_2, sobj.FlipTimeStamp_2] = Screen(sobj.wPtr, 'Flip', sobj.OnsetTime_1+sobj.delayPTB);% put some delay for PTB
            [sobj.vbl_2, sobj.OnsetTime_2, sobj.FlipTimeStamp_2] = Screen(sobj.wPtr, 'Flip', sobj.vbl_1+sobj.delayPTB);% put some delay for PTB
            sobj.sFlipTimeStamp_2=toc(recobj.STARTloop);
            stim_monitor;
        else
            Screen('Flip',sobj.wPtr);
        end

    elseif recobj.delayTTL2/1000 > sobj.delayPTB %grating の途中で TTL2出せない気がする．．
        disp('ERROR!!');
        recobj.delayTTL2 = 0;
        sobj.delayPTB = 0;
    end
end

disp(['AITrig: #', num2str(recobj.cycleNum)]);

%monitor stim OFF
disp({'Grating'; ['AITrig: #', num2str(recobj.cycleNum)]});
Screen('FillRect', sobj.wPtr, sobj.bgcol);
%[sobj.vbl_3, sobj.OnsetTime_3, sobj.FlipTimeStamp_3] = Screen(sobj.wPtr, 'Flip', sobj.OnsetTime_2+sobj.duration); %%% sobj.duration 時間経過後 monitor stim off
[sobj.vbl_3, sobj.OnsetTime_3, sobj.FlipTimeStamp_3] = Screen(sobj.wPtr, 'Flip', sobj.vbl_2+sobj.duration);
sobj.sFlipTimeStamp_3=toc(recobj.STARTloop);
stim_monitor_reset;

Priority(0);

