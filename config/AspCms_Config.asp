<%
Const runMode=0	'网站运行模式（0为动态，1为静态）
Const sitePath=""	'网站总目录 例如:/cms
Const accessFilePath="data/#data.asp"	'access数据库文件路径
Const dbType=0  '数据库类型（0为access；1为sqlserver）
Const databaseServer="."  'sqlserver数据库地址
Const databaseName="aspcms"  'sqlserver数据库名称
Const databaseUser="sa"  'sqlserver数据库账号
Const databasepwd="sa"  'sqlserver数据库密码
Const fileExt=".html"	'生成文件扩展名（htm,html,asp）	
Const upLoadPath="upLoad"	'上传文件目录
Const textFilter=""	'文字过滤
Const tablePrefix="AspCms_"	'数据库前缀
Const upFileSize=20000	'上传文件大小限制KB
Const upFileWay=1	'上传文件方式设置(1,无组件上传,)
Const htmlDir="aspcms"	'文档HTML默认保存路径

'开关类
Const siteMode=1	'网站状态（0为关闭，1为运行）
Const siteHelp="本网站因程序升级关闭中"	'网站状态（0为关闭，1为运行）
Const admincode=0  '后台登录验证码（0为关闭，1开启）
Const switchFaq=0	'留言开关（0为关闭，1为开启）
Const switchFaqStatus=0 '留言审核开关（0为不启用，1为启用）
Const switchComments=1	'评论开关（0为关闭，1为开启）
Const switchCommentsStatus=0	'评论审核是否启用（0为不启用，1为启用）


Const waterMark=0	'水印(0,1)
Const waterType=0	'水印类型(0为文字，1图片)
Const waterMarkFont="水印示例"	'水印文字
Const waterMarkPic="/images/logo.png"	'水印图片
Const waterMarkLocation="1"	'位置

'邮件设置 
Const smtp_usermail="hzk520@126.com"	'邮件地址
Const smtp_user="hzk520"	'邮件账号 
Const smtp_password="hzk52019860626"	'邮件密码 
Const smtp_server="smtp.126.com"	'邮件服务器

'提醒功能
Const messageAlertsEmail="860227477@qq.com"	'邮件地址
Const messageReminded=1	'留言提醒
Const orderReminded=1	'订单提醒
Const commentReminded=1	'评论提醒
Const applyReminded=1	'应聘提醒

Const sortTypes="单篇,文章,产品,下载,招聘,相册,链接"

 
Const dirtyStr="黑车<br>传销"

'在线客服
Const serviceStatus=1	'在线客服显示状态
Const serviceStyle=2	'样式
Const serviceLocation="left"	'显示位置
Const serviceQQ="技术支持|123456 产品咨询|8887443" 'QQ
'Const serviceEmail="234324324"	'邮箱
'Const servicePhone="43244324324"	'电话
Const serviceWangWang="销售一号|123456 销售2号|8887443"	'旺旺
Const serviceContact="/about/?19.html"	'联系方式链接
Const servicekfStatus=1	
Const servicekf=""	'

'53客服
Const service53kfStatus=0	'53KF显示状态
Const service53kf=0	'53KF申请状态
Const service53kfaccount="" '53KF帐号
Const service53workid="" '53KF工号
Const service53kfpasswd="" '53KF密码


'幻灯片设置a
Const slidestyle=0	'幻灯片样式
Const slideImgs="/upLoad/slide/month_1208/201208231539493346.jpg, /upLoad/slide/month_1208/201208231539535499.jpg, /upLoad/slide/month_1208/201208231539582605.jpg, /upLoad/slide/month_1208/201208231540033542.jpg, /upLoad/slide/month_1208/201208231540071108.jpg,"	'图片地址
Const slideLinks="http://www.shhulu.com/content/?295.html, , , ,,"	'链接地址
Const slideTexts=", , , ,,"	'文字说明
Const slideWidth="560"	'宽
Const slideHeight="295"	'高
Const slideTextStatus=1	'文字说明开关
Const slideNum=5	'文字说明开关

'幻灯片设置B
Const slidestyleB=0	'幻灯片样式
Const slideImgsB=","	'图片地址
Const slideLinksB=","	'链接地址
Const slideTextsB=","	'文字说明
Const slideWidthB="201"	'宽
Const slideHeightB="201"	'高
Const slideTextStatusB=0	'文字说明开关
Const slideNumB=1	'文字说明开关

'幻灯片设置C
Const slidestyleC=0	'幻灯片样式
Const slideImgsC=","	'图片地址
Const slideLinksC=","	'链接地址
Const slideTextsC=","	'文字说明
Const slideWidthC="202"	'宽
Const slideHeightC="202"	'高
Const slideTextStatusC=1	'文字说明开关
Const slideNumC=1	'文字说明开关

'幻灯片设置D
Const slidestyleD=1	'幻灯片样式
Const slideImgsD=","	'图片地址
Const slideLinksD=","	'链接地址
Const slideTextsD=","	'文字说明
Const slideWidthD="203"	'宽
Const slideHeightD="203"	'高
Const slideTextStatusD=1	'文字说明开关
Const slideNumD=1	'文字说明开关


Const GoogleAPIKey=""
Const GoogleMapLat=30.593086
Const GoogleMapLng=114.30536



Const dirtyStrToggle=1



Const markPicWidth=""



Const markPicHeight=""



Const markPicAlpha=""

%>
