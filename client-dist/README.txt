client-dist\  ���� �ͻ��˲�� + �������ݵķ����غ�
============================================================
���Ŀ¼��Ķ����ᱻ tools\sync-client.ps1 ͬ�������ͻ���Ŀ¼����
��Ҳ���Ҫ��������ֻҪ�� step2 �� start.cmd�������� + ���� + ���¿ͻ��� + �������
����˫�� tools\���¿ͻ���.bat��

Ŀ¼˵��
  plugin\   ������壨ͬ�����ͻ��˸�Ŀ¼��
              Hook.dll            ���
              Launcher.exe        �����
              stringpool053_zh.txt �����ı���
              garbled053_zh.txt    ����������滻��
              ����˵��.txt          ����ҿ���˵��
              config.ini           ����ʱ���õ�Ĭ��ֵ��ֻ�ڿͻ��˻�û��ʱд�룩
  data\     �ͻ������ݣ������ͻ���������·������
              wz\String.wz   ->  �ͻ���\wz\String.wz
              Data\Quest\Say.img -> �ͻ���\Data\Quest\Say.img
              ������ͻ��˰� wz ���ڸ�Ŀ¼������ wz\ ��Ŀ¼���ű����Զ�д����Ŀ¼�Ƿݣ�
  tools\    ͬ���ű�
              sync-client.ps1   ������ͬ���߼�
              ���¿ͻ���.bat     ˫����ڣ����/�ͻ��������
              make-manifest.ps1  ��������������嵥��ά�����ã�
  client-dist.txt     �汾 / ˵�� / �ͻ���������У�� / keep_existing / backup_keep
  client-dist.sha256  ÿ���ļ��� sha256��make-manifest.ps1 ���ɣ����ָģ�
  client-dir.txt      �ű��Լ����µĿͻ���Ŀ¼�������ļ�����Ҫ�ύ�� git��

��������
  1. ��Ҫ���µ��ļ��Ž� plugin\ / data\��data �°��ͻ������·���ڣ�
  2. ��  tools\make-manifest.ps1 -Version 1.1.3 -Tag client-v1.1.3   �������� sha256 + ͳ�ƣ�
  3. git add / commit / push����Ҫ�Ļ��� tag��client-vX.Y.Z��
  4. ����´��� start.cmd �ͻ��Զ�ͬ����ȥ����������ӡ�����˼����ļ���

ע��
  * ������� Map.wz / Character.wz / Sound.wz / Mob.wz ���ּ��� MB �� ���� ����"��װ��"���£�
    ����"ÿ�θ���"���£�����ֿ���ʷ��������������ᱬ����
  * config.ini Ĭ��"ֻ��������"���ͻ������оͲ�������Ĭ��ֵд�� config.ini.new��
    ���ڴ������г��°汾������������
  * �ͻ���������У�飨client_exe_sha256��������Ĳ�����ַ������ض��ͻ��˰汾����ģ�
    �Բ��ϻᾯ�棻�������Բ��Ͼ;ܾ����£��� client-dist.txt �� client_exe_strict �ĳ� 1��
  * �ͻ���Ŀ¼��� _backup_client\ �Ǹ���ǰ�ı��ݺ���־��������ʱɾ����������� backup_keep��

�����ļ������ơ�����Ҳ�Ĺ�������û���Ӹɾ����� 100% ȷ�ϣ��Լ�����Ҫ��Ҫ�Ž� data\��
  Data\Etc\ScriptInfo.img        4820 -> 4799
  Data\Item\Etc\0416.img         137928 -> 137700
  Data\Npc\1061011.img           14720 -> 14667
  Data\Npc\9010000.img           9557 -> 9497
  Data\String\Npc.img            501866 -> 134434   �������࣬ȷ�����ǲ�������ģ�