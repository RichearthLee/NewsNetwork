<%
Const runMode=0	'��վ����ģʽ��0Ϊ��̬��1Ϊ��̬��
Const sitePath=""	'��վ��Ŀ¼ ����:/cms
Const accessFilePath="data/#data.asp"	'access���ݿ��ļ�·��
Const dbType=0  '���ݿ����ͣ�0Ϊaccess��1Ϊsqlserver��
Const databaseServer="."  'sqlserver���ݿ��ַ
Const databaseName="aspcms"  'sqlserver���ݿ�����
Const databaseUser="sa"  'sqlserver���ݿ��˺�
Const databasepwd="sa"  'sqlserver���ݿ�����
Const fileExt=".html"	'�����ļ���չ����htm,html,asp��	
Const upLoadPath="upLoad"	'�ϴ��ļ�Ŀ¼
Const textFilter=""	'���ֹ���
Const tablePrefix="AspCms_"	'���ݿ�ǰ׺
Const upFileSize=20000	'�ϴ��ļ���С����KB
Const upFileWay=1	'�ϴ��ļ���ʽ����(1,������ϴ�,)
Const htmlDir="aspcms"	'�ĵ�HTMLĬ�ϱ���·��

'������
Const siteMode=1	'��վ״̬��0Ϊ�رգ�1Ϊ���У�
Const siteHelp="����վ����������ر���"	'��վ״̬��0Ϊ�رգ�1Ϊ���У�
Const admincode=0  '��̨��¼��֤�루0Ϊ�رգ�1������
Const switchFaq=0	'���Կ��أ�0Ϊ�رգ�1Ϊ������
Const switchFaqStatus=0 '������˿��أ�0Ϊ�����ã�1Ϊ���ã�
Const switchComments=1	'���ۿ��أ�0Ϊ�رգ�1Ϊ������
Const switchCommentsStatus=0	'��������Ƿ����ã�0Ϊ�����ã�1Ϊ���ã�


Const waterMark=0	'ˮӡ(0,1)
Const waterType=0	'ˮӡ����(0Ϊ���֣�1ͼƬ)
Const waterMarkFont="ˮӡʾ��"	'ˮӡ����
Const waterMarkPic="/images/logo.png"	'ˮӡͼƬ
Const waterMarkLocation="1"	'λ��

'�ʼ����� 
Const smtp_usermail="hzk520@126.com"	'�ʼ���ַ
Const smtp_user="hzk520"	'�ʼ��˺� 
Const smtp_password="hzk52019860626"	'�ʼ����� 
Const smtp_server="smtp.126.com"	'�ʼ�������

'���ѹ���
Const messageAlertsEmail="860227477@qq.com"	'�ʼ���ַ
Const messageReminded=1	'��������
Const orderReminded=1	'��������
Const commentReminded=1	'��������
Const applyReminded=1	'ӦƸ����

Const sortTypes="��ƪ,����,��Ʒ,����,��Ƹ,���,����"

 
Const dirtyStr="�ڳ�<br>����"

'���߿ͷ�
Const serviceStatus=1	'���߿ͷ���ʾ״̬
Const serviceStyle=2	'��ʽ
Const serviceLocation="left"	'��ʾλ��
Const serviceQQ="����֧��|123456 ��Ʒ��ѯ|8887443" 'QQ
'Const serviceEmail="234324324"	'����
'Const servicePhone="43244324324"	'�绰
Const serviceWangWang="����һ��|123456 ����2��|8887443"	'����
Const serviceContact="/about/?19.html"	'��ϵ��ʽ����
Const servicekfStatus=1	
Const servicekf=""	'

'53�ͷ�
Const service53kfStatus=0	'53KF��ʾ״̬
Const service53kf=0	'53KF����״̬
Const service53kfaccount="" '53KF�ʺ�
Const service53workid="" '53KF����
Const service53kfpasswd="" '53KF����


'�õ�Ƭ����a
Const slidestyle=0	'�õ�Ƭ��ʽ
Const slideImgs="/upLoad/slide/month_1208/201208231539493346.jpg, /upLoad/slide/month_1208/201208231539535499.jpg, /upLoad/slide/month_1208/201208231539582605.jpg, /upLoad/slide/month_1208/201208231540033542.jpg, /upLoad/slide/month_1208/201208231540071108.jpg,"	'ͼƬ��ַ
Const slideLinks="http://www.shhulu.com/content/?295.html, , , ,,"	'���ӵ�ַ
Const slideTexts=", , , ,,"	'����˵��
Const slideWidth="560"	'��
Const slideHeight="295"	'��
Const slideTextStatus=1	'����˵������
Const slideNum=5	'����˵������

'�õ�Ƭ����B
Const slidestyleB=0	'�õ�Ƭ��ʽ
Const slideImgsB=","	'ͼƬ��ַ
Const slideLinksB=","	'���ӵ�ַ
Const slideTextsB=","	'����˵��
Const slideWidthB="201"	'��
Const slideHeightB="201"	'��
Const slideTextStatusB=0	'����˵������
Const slideNumB=1	'����˵������

'�õ�Ƭ����C
Const slidestyleC=0	'�õ�Ƭ��ʽ
Const slideImgsC=","	'ͼƬ��ַ
Const slideLinksC=","	'���ӵ�ַ
Const slideTextsC=","	'����˵��
Const slideWidthC="202"	'��
Const slideHeightC="202"	'��
Const slideTextStatusC=1	'����˵������
Const slideNumC=1	'����˵������

'�õ�Ƭ����D
Const slidestyleD=1	'�õ�Ƭ��ʽ
Const slideImgsD=","	'ͼƬ��ַ
Const slideLinksD=","	'���ӵ�ַ
Const slideTextsD=","	'����˵��
Const slideWidthD="203"	'��
Const slideHeightD="203"	'��
Const slideTextStatusD=1	'����˵������
Const slideNumD=1	'����˵������


Const GoogleAPIKey=""
Const GoogleMapLat=30.593086
Const GoogleMapLng=114.30536



Const dirtyStrToggle=1



Const markPicWidth=""



Const markPicHeight=""



Const markPicAlpha=""

%>
