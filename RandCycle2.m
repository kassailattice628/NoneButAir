function amari = RandCycle2(cyclenum,n_cycle)
%�T�C�N����������Z���āC�]���o�́Damari == 1 �̂Ƃ��ɁC�����_�}�C�Y
%cyclenum: ���݂̃T�C�N����
%n_cycle: �T�C�N��������̐�
%�����_���������x�N�g���� sobj.list_order �ɓ����

global sobj
amari = rem(cyclenum, n_cycle);

if amari == 1% randomize
    %1 cycle ���̓����_���x�N�g����ۑ�
    sobj.list_order = randperm(n_cycle);
end
if amari == 0;
    amari = n_cycle;
end