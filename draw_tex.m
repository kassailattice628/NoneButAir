function draw_tex(tex_id,sRect,angle, color_stim, phase, freq, sc, contrast)
%Screen('DrawTexture', windowPointer, texturePointer [,sourceRect] [,destinationRect] [,rotationAngle] [, filterMode] [, globalAlpha] [, modulateColor] [, textureShader] [, specialFlags] [, auxParameters]);
% %% default value %%
%[,sourceRect]: full texture, <����� texture �̈ꕔ��؂����Ďg���ꍇ�g��>
%[,destinationRect]: center, <texture ���o���ꏊ>
%[,RoutationAngle]: 0 deg = upright, <texture �̌X�� (deg)>
%[,filterMode]:1, <texture �g��/�k���\���̍ۂ̐F�̌v�Z: 0:Nearest neighbor, 1:Biliniear,
%2:BL nearest mipmap, 3:Trilinear filtering across mipmap, 4:NN for nearest mipmap
%5:NN with linear interpolation between mipmap levels.
%Mipmap filtering is only supportedfor GL_TEXTURE_2D textures (specialFlags)
%[,globalAlpha]: 1, <�����x:0�i�����j~ 1�i�s�����j�͈̔͂Ŏg�p> (alpha-cahnnel ���w�肵�Ă�ꍇ�͂����Z�����j
%[,modulateColor]: white <�w�肷��� globalAlpha �͖���. eg:[128,255,0] ���� G-ch �� alpha �͂��̂܂�. 
%B-ch �� 0 �����Z�����D R-ch �� 128/255 �����Z����� intensity �� 50 % �ɂȂ�
%[, textureShader](optional):
%[, specialFlags](optional):
%[, auxParameters](optinoal):
global sobj

switch sobj.pattern
    case {'Sin','Rect'}
        Screen('DrawTexture', sobj.wPtr,tex_id, sRect, sobj.position_cord, angle, [],[],color_stim,[],[], [phase, freq, contrast, 0]);
    case 'Gabor'
        aspectratio = 1;
        Screen('DrawTexture', sobj.wPtr,tex_id, sRect, sobj.position_cord, angle, [],[],color_stim,[],kPsychDontDoRotation, [phase, freq, sc, contrast, aspectratio, 0, 0, 0]);
        %Screen('DrawTexture', sobj.wPtr,tex_id, sRect, sobj.position_cord, angle, [],[],[],[],kPsychDontDoRotation, [phase, freq, sc, contrast, aspectratio, 0, 0, 0]);

end
