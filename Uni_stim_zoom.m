function Uni_stim_zoom(i,col)
%For lateral inhibition (2 point stim) or Zoom (1point stim)
%���S�n�_�� position_poler�ŁC�ɍ��W�Ō��߂��ʒu�Ɏh�����o��

global sobj
global recobj
global figUIobj

%%%%%%%%%%%%%%%%
% stim position (and luminace for BW fine mapping) 
sobj.position_cord2 = position_polar2(i,sobj.shiftDir);
% header �ۑ��p�� �h���ʒu�� stim1 �̂��̂Ƃ��ĕۑ�
sobj.position_cord = sobj.position_cord2;

%%%%%%%%%%%%%%%%
%pause(0.001)%�Ȃ��� trigger �ł��Ȃ��H�i����Ȃ��j
%Rec start, Rec Time;
trigger_AIFV
%%%%%%%%%%%%%%%
Screen(sobj.shape, sobj.wPtr, col, sobj.position_cord2);
%PhotoSensor (left, up)     Timing Checker
if recobj.cycleNum > 0
    Screen('FillRect', sobj.wPtr, 255, [0 0 40 40]);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if recobj.delayTTL2/1000 <= sobj.delayPTB
    while toc(recobj.STARTloop) - recobj.RecStartTimeToc <= recobj.delayTTL2/1000;%wait TTL2 delay (include delay TTL2 == 0)
    end
    if get(figUIobj.TTL2, 'value') == 0
        recobj.tTTL2 = trigger_rec(2) -  recobj.RecStartTimeToc;
    else %FV trigger �̂Ƃ��� TTL2 ���ɒ@���Ȃ��Ă悢
        recobj.tTTL2 = 0;
    end
    [sobj.vbl_2, sobj.OnsetTime_2, sobj.FlipTimeStamp_2] = Screen(sobj.wPtr, 'Flip', sobj.vbl_1+sobj.delayPTB);% put some delay for PTB
    sobj.sFlipTimeStamp_2=toc(recobj.STARTloop);
    stim_monitor;
elseif recobj.delayTTL2/1000> sobj.delayPTB
    [sobj.vbl_2, sobj.OnsetTime_2, sobj.FlipTimeStamp_2] = Screen(sobj.wPtr, 'Flip', sobj.vbl_1+sobj.delayPTB);% put some delay for PTB
    stim_monitor;
    while toc(recobj.STARTloop) - recobj.RecStartTimeToc <= recobj.delayTTL2/1000;%wait TTL2 delay
    end
    if get(figUIobj.TTL2, 'value') == 0
        recobj.tTTL2 = trigger_rec(2) -  recobj.RecStartTimeToc;
    else %FV trigger �̂Ƃ��� TTL2 ���ɒ@���Ȃ��Ă悢
        recobj.tTTL2 = 0;
    end
end

disp(['AITrig; ',sobj.pattern, ': #', num2str(recobj.cycleNum)]);
%stim_OFF
Screen('FillRect', sobj.wPtr, sobj.bgcol);
[sobj.vbl_3, sobj.OnsetTime_3, sobj.FlipTimeStamp_3] = Screen(sobj.wPtr, 'Flip', sobj.vbl_2+sobj.duration); %%% sobj.duration ���Ԍo�ߌ� monitor stim off
sobj.sFlipTimeStamp_3=toc(recobj.STARTloop);
stim_monitor_reset;

