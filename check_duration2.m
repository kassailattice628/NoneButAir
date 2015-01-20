function check_duration2
global sobj
global recobj
global figUIobj

sobj.duration = sobj.flipNum*sobj.m_int;
set(figUIobj.stimDur,'string',['flips = ',num2str(floor(sobj.duration*1000)),' ms']);

sobj.duration2 = sobj.flipNum2*sobj.m_int;
set(figUIobj.stimDur2,'string',['flips = ',num2str(floor(sobj.duration2*1000)),' ms']);

sobj.delayPTB = sobj.delayPTBflip*sobj.m_int;
set(figUIobj.delayPTB,'string',['flips = ',num2str(floor(sobj.delayPTB*1000)),' ms']);

sobj.delayPTB2 = sobj.delayPTBflip2*sobj.m_int;
set(figUIobj.delayPTB2,'string',['flips = ',num2str(floor(sobj.delayPTB2*1000)),' ms']);

if (sobj.duration*1000 + sobj.delayPTB*1000 > recobj.rect) || (sobj.duration2*1000 + sobj.delayPTB2*1000 > recobj.rect)
    errordlg('Stim. duration is longer than Recording time !!');
    sobj.flipNum = 75;
    set(figUIobj.flipNum, 'string', 75);
    sobj.flibNum2 = 75;
    set(figUIobj.flipNum2, 'string', 75);
    sobj.delayPTBflip = 20;
    set(figUIobj.delayPTBflip, 'string', 20);
    sobj.delayPTBflip2 = 20;
    set(figUIobj.delayPTBflip2, 'string', 20);
    
    sobj.duration = sobj.flipNum*sobj.m_int;
    sobj.duration2 = sobj.flibNum2*sobj.m_int;
    sobj.delayPTB = sobj.delayPTBflip*sobj.m_int;
    sobj.delayPTB2 = sobj.delayPTBflip2*sobj.m_int;
    
    recobj.rect = 2000; %ms
    set(figUIobj.rect, 'string', 2000);
    
    check_duration2;
end

