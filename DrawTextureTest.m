function DrawTextureTest
ListenChar(2);
AssertOpenGL;
%����function
%myKeyCheck;
try
  screenNumber=max(Screen('Screens'));
  [expWin, rect]=Screen('OpenWindow', screenNumber, [255 255 255], [100, 200, 700, 600]);
  
  %��ʂ̒��S���W
  [mx, my]=RectCenter(rect);
  
  %�\���}�[�N�̍s��i20�~20�j�����
  FixCr=ones(20,20)*255;
  FixCr(10:11,:)=0;
  FixCr(:,10:11)=0;
  fixcross = Screen('MakeTexture',expWin,FixCr);
  
  %�ȉ��̂V�s�̂����ꂩ�P�s�݂̂�L���ɂ��Ď��s���Ă݂Ă��������B
  Screen('DrawTexture', expWin, fixcross);
  %Screen('DrawTexture', expWin, fixcross,[],[mx-10, my-10, mx+10, my+10]);
  %Screen('DrawTexture', expWin, fixcross,[5, 5, 20, 20],[mx-10, my-10, mx+10, my+10]);
  %Screen('DrawTexture', expWin, fixcross,[5, 5, 20, 20],[mx-50, my-50, mx+50, my+50]);
  %Screen('DrawTexture', expWin, fixcross,[5, 5, 20, 20],[mx, my, mx+100, my+100]);
  %Screen('DrawTexture', expWin, fixcross,[5, 5, 20, 20],[mx, my, mx+100, my+100], 30);
  %Screen('DrawTexture', expWin, fixcross,[],[mx-50, my-50, mx+50, my+50], 45);
  
  %��ʂɒ掦as
  Screen('Flip', expWin);
  
  %�����̃L�[�������܂ŉ�ʂ���Ȃ�
  KbWait([], 3);
  
  %�I������
  Screen('CloseAll');
  ShowCursor;
  ListenChar(0);
catch
  Screen('CloseAll');
  ShowCursor;
  ListenChar(0);
end