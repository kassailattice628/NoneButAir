function Test_RandImgs(i)
%Imgs Folder ���̉摜�i256 ��ށj�̂��� sobj.ImageNum �̉摜�i128*128�j
%�����_���ɒ񎦂���i�摜�� fixed pos �ɓK���ɌX�����Ē�
global sobj
global recobj
global figUIobj
AssertOpenGL;

%Select Image
if recobj.cycleNum == 1 %�͂��߂Ɏg���摜�Z�b�g��I��
    sobj.list_img = randperm(256);
    sobj.set_list_img = zeros(2,sobj.ImageNum);
    sobj.set_list_img(1,:) = sobj.list_img(1:sobj.ImageNum);%�g���摜�O���珇�ԂɑI��ŁC���̃��X�g���u���b�N���ƂɃ����_�����Ďg����
    a = sobj.ImageNum/8;
    amari = rem(sobj.ImageNum,8);
    dirlist = 0:45:315;
    sobj.set_list_img(2,:) = [repmat(dirlist,1,fix(a)), dirlist(1:amari)];
    %�ʐ^�̉摜�͌X���Ȃ�
    sobj.set_list_img(2,sobj.set_list_img(1,:) >= 241) = 0;
end
i_list = RandCycle2(recobj.cycleNum, sobj.ImageNum);

sobj.img_i = sobj.set_list_img(1,sobj.list_order(i_list));%�g���摜�̔ԍ�
%�e�摜�ɂ��āC�K���ɌX���Ďg���i�����͏c���̍\�����������̂ŁCrandamize �����ق�����������
sobj.angle = sobj.set_list_img(2,sobj.list_order(i_list));

%�摜�t�@�C�����̎擾
imgFolder = ['Imgs',filesep];
imgFileList = dir([imgFolder 'Im*.tif']);
imgFileName = char(imgFileList(sobj.img_i).name); % �摜�̃t�@�C�����i�t�H���_���Ȃ��j
imgFileName2 = [imgFolder imgFileName];
%�摜�ǂݍ���
imgdata = imread(imgFileName2, 'TIFF');
%�e�N�X�`����
imgtex = Screen('MakeTexture',sobj.wPtr,imgdata);

%Position: [left, top, right, bottom]����
x1 = sobj.pos(1,sobj.Y(i))-size(imgdata,1)/2;
y1 = sobj.pos(2,sobj.X(i))-size(imgdata,2)/2;
x2 = sobj.pos(1,sobj.Y(i))+size(imgdata,1)/2;
y2 = sobj.pos(2,sobj.X(i))+size(imgdata,2)/2;
sobj.position_cord = [x1,y1,x2,y2];

%%%%%%%%%%%%%%%%
%pause(0.001)%�Ȃ��� trigger �ł��Ȃ��H�i����Ȃ��j
%Rec start, Rec Time;
trigger_AIFV
%%%%%%%%%%%%%%%

%�����ɉ摜�o�́���
Screen('DrawTexture', sobj.wPtr, imgtex, [], sobj.position_cord,sobj.angle);%�g�储��яk���͂ǂ����悤���H

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