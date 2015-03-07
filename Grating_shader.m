function Grating_shader(i)
global sobj
global recobj
global figUIobj
% ProceduralGaborDemo in "PsychDemos" was modified.
%{
 ProceduralGaborDemo([benchmark=0][, nonsymmetric=0])
 By default - if the optional 'nonsymmetric' flag is not provided or set
 to zero - only symmetric circular gabors are drawn. If the flag is set to
 1 then gabors with an aspect ratio ~= 1, ie., elliptical gabors, are
 drawn as well. Restricting drawing to symmetric gabors allows for an
 additional speedup in drawing (about 15% on a MacBookPro 2nd generation),
 so this may be interesting if you are in "need for speed(TM)".
 At a default setting of benchmark==0, it just shows nicely drawn gabor.
%}

% Make sure this is running on OpenGL Psychtoolbox:
AssertOpenGL;

%stim position
%[left, top, right, bottom]����
x1 = sobj.pos(1,sobj.Y(i))-sobj.stimsz(1)/2;
y1 = sobj.pos(2,sobj.X(i))-sobj.stimsz(2)/2;
x2 = sobj.pos(1,sobj.Y(i))+sobj.stimsz(1)/2;
y2 = sobj.pos(2,sobj.X(i))+sobj.stimsz(2)/2;
sobj.position_cord = [x1,y1,x2,y2];
%%
%%%%%%%%%% Initial stimulus params for the gabor patch %%%%%%%%%%
% Temporal Grating Frequency %
sobj.shiftSpd = round(sobj.frameRate/sobj.shiftSpd2);%�[���͊ۂ�

phase = 0; %%%%%����̎��͂���������K�v���聨while loop �̒� phase �̒�`���Q��%%%%
% Spatial Frequency
freq = sobj.gratFreq2/Deg2Pix(1,sobj.MonitorDist);
% Size %
res= sobj.stimsz; % GUI �ł� deg, ���� pixel �ɕϊ�
% Patch size of Gabor
sc = res(1)*0.15;% (1-exp(-1)); % Stim Size �ɂ��킹�ē����悤�ɂ��Ă��� 0.15�͂�������
contrast = 100.0;

%background offset �� 0.5 �������ageruto 0-255 (���� 127) no sine wave ��������D
color_offset = 0.5 * ones(1,3);

%%
switch sobj.pattern
    case {'Sin','Rect'}
        color_stim = (sobj.stimcol + 1) /(255 + 1); % 255 �Ŋ����Ƃ��Ƃ��܂����� +1�@�͊���Z�p
    case 'Gabor'
        color_stim =[];
end

tex_id = make_grating_texture(color_offset);

% sRect, tecture ����؂�o��
center = zeros(1,2);
[center(1),center(2)] = RectCenter(sobj.RECT); % window �̒��S
%[,sourceRect]
sRect = round([center(1) - res(1)/2, center(2) - res(2)/2, center(1) + res(1)/2, center(2) + res(2)/2]);

%%
% Grating Direction Angle: sobj.angle
if sobj.shiftDir < 9 % direction angle ���߂�
    list= sobj.angle_deg;
    sobj.angle = list(sobj.shiftDir);
elseif sobj.shiftDir >= 9;
    switch sobj.shiftDir
        case 9 %Order8
            list= sobj.angle_deg;
            sobj.list_order = 1:8;
            i_list = rem(recobj.cycleNum,8);
            if i_list ==0
                i_list = 8;
            end
        case 10 %Rand8
            list= sobj.angle_deg;
            i_list = RandCycle2(recobj.cycleNum,length(list));%�Ȃ��� sobj.list_order ������Ă���
        case 11 %Rand16
            list = sobj.angle16_deg;
            i_list = RandCycle2(recobj.cycleNum,length(list));
    end
    sobj.angle = list(sobj.list_order(i_list));
end

%%
% offscreen �� 1���ڏ���
switch sobj.pattern
    case {'Sin','Rect'}
        ang = 180 - sobj.angle;
    case 'Gabor' % Gabor �̂Ƃ��́CSineWave, SquareWave �̂Ƃ��͊p�x�̒�`�̂܂�肩�������΂������̂�
        ang = 180 + sobj.angle;
end
draw_tex(tex_id, sRect, ang, color_stim, phase, freq, sc, contrast);
%%
%photo sensor �p
Screen('FillRect', sobj.wPtr, 255, [0 0 40 40]);
%pause(0.001) %���ꂪ�Ȃ��Ɠ����Ȃ��H�H�H
trigger_AIFV;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if recobj.delayTTL2/1000 <= sobj.delayPTB %TTL2 �̌� stim
    while toc(recobj.STARTloop) - recobj.RecStartTimeToc <= recobj.delayTTL2/1000;%wait TTL2 delay (include delay TTL2 == 0)
    end
    if get(figUIobj.TTL2, 'value') ==0 % for Laser
        recobj.tTTL2 = trigger_rec(2) -  recobj.RecStartTimeToc;
    else
        recobj.tTTL2 = 0;
    end
    % onscreen �� �P���ڒ񎦂��ă^�C�}�[�X�^�[�g
    [sobj.vbl_2, sobj.OnsetTime_2, sobj.FlipTimeStamp_2] = Screen(sobj.wPtr, 'Flip', sobj.vbl_1+sobj.delayPTB);% put some delay for PTB
    sobj.sFlipTimeStamp_2=toc(recobj.STARTloop);
    stim_monitor;
elseif recobj.delayTTL2/1000 > sobj.delayPTB %grating �̓r���� TTL2�o���Ȃ��C������D�D
    disp('ERROR!!');
    recobj.delayTTL2 = 0;
    sobj.delayPTB = 0;
end

% �h�����Ԃ́Csobj.flipNum�Œ�`���Ă���̂�
for count = 1:sobj.flipNum
    phase = count/sobj.shiftSpd*360;
    draw_tex(tex_id,sRect,ang, color_stim, phase, freq, sc, contrast);
    Screen('FillRect', sobj.wPtr, 255, [0 0 40 40]);
    Screen('Flip', sobj.wPtr);
end

disp(['AITrig; ', sobj.pattern, ': #', num2str(recobj.cycleNum)]);
%stim_OFF
Screen('FillRect', sobj.wPtr, sobj.bgcol);
[sobj.vbl_3, sobj.OnsetTime_3, sobj.FlipTimeStamp_3] = Screen(sobj.wPtr, 'Flip', sobj.vbl_2+sobj.duration);
sobj.sFlipTimeStamp_3=toc(recobj.STARTloop);
stim_monitor_reset;