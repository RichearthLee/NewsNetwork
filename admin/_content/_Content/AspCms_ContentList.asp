<!--#include file="AspCms_ContentFun.asp" -->
<%CheckAdmin("AspCms_ContentList.asp?sortType="&sortType)%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD><TITLE></TITLE>
<META http-equiv=Content-Type content="text/html; charset=gbk">
<LINK href="../../images/style.css" type=text/css rel=stylesheet>
<script language="javascript" type="text/javascript" src="../../js/getdate/WdatePicker.js"></script>
<script type="text/javascript" src="../../js/jquery.min.js"></script>
<script type="text/javascript" src="../../js/jquery.tinyTips.js"></script>
<script type="text/javascript">
		$(document).ready(function() {
			$('a.tTip').tinyTips('title');
			$('img.imgTip').tinyTips('title');
			$('img.tTip').tinyTips('title');
			$('h1.tagline').tinyTips('tinyTips are totally awesome!');
		});
		</script>
<link rel="stylesheet" type="text/css" media="screen" href="../../css/tinyTips.css" />
</HEAD>
<SCRIPT>
function SelAll(theForm){
		for ( i = 0 ; i < theForm.elements.length ; i ++ )
		{
			if ( theForm.elements[i].type == "checkbox" && theForm.elements[i].name != "SELALL" )
			{
				theForm.elements[i].checked = ! theForm.elements[i].checked ;
			}
		}
}
</SCRIPT>
<BODY>
<FORM name="" action="?" method="post">
<DIV class=searchzone>

<TABLE height=30 cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD height=30>���ࣺ<%LoadSelect "SortID","Aspcms_Sort","SortName","SortID",SortID, 0," and( sortid in(select ParentID from {prefix}Sort where 1=1 and SortType="&sortType&" order by SortOrder) or SortType="&sortType&")","���з���"%>
      �ؼ��ʣ�<INPUT class="input" size="16" name="keyword" value="<%=keyword%>">
      <INPUT class="button" type="submit" value="����" name="Submit" onClick="form.action='?<%="sortType="&sortType&"&sortid="&sortid&"&keyword="&keyword&"&page=&psize="&psize&"&order="&order&"&ordsc="&ordsc&""%>';">
      <INPUT onClick="location.href='<%=getPageName()%>?<%="sortType="&sortType%>'" type="button" value="ȫ��" class="button" /></TD>
    <TD align=right colSpan=2>
    <INPUT onClick="location.href='AspCms_ContentAdd.asp?<%="sortType="&sortType&"&sortid="&sortid&"&keyword="&keyword&"&page="&page&"&psize="&psize&"&order="&order&"&ordsc="&ordsc&""%>'" type="button" value="����<%=sortTypeName%>" class="button" > 
<%if sortType=3 then%>
	<INPUT onClick="location.href='../../_system/AspCms_PayMentSetting.asp'" type="button" value="���߶�������" class="button" >
<%end if%>
	<INPUT onClick="location.href='../_Spec/AspCms_Spec.asp?<%="sortType="&sortType&"&sortid="&sortid&""%>'" type="button" value="<%=sortTypeName%>��������" class="button" > 
    <INPUT onClick="location.href='<%=getPageName()%>?<%="sortType="&sortType&"&sortid="&sortid&"&keyword="&keyword&"&page="&page&"&psize="&psize&"&order="&order&"&ordsc="&ordsc&""%>'" type="button" value="ˢ��" class="button" /> 
</TD></TR></TBODY></TABLE></DIV>
<DIV class=listzone>
<TABLE cellSpacing=0 cellPadding=3 width="100%" align=center border=0>
  <TBODY>
  <TR class=list>
    <TD width=47 align="center" class=biaoti>ѡ��</TD>
    <TD width=46 align="center" class=biaoti>���</TD>
    <TD width="376" height=28 align="left" class=biaoti><span class="searchzone">����</span></TD>
    <TD width=63 align="center" class=biaoti><span class="searchzone">����</span></TD>
    <TD width=165 align="center" class=biaoti><span class="searchzone">����ʱ��</span></TD>
    <TD width=50 align="center" class=biaoti><span class="searchzone">����</span></TD>
    <TD width=44 align="center" class=biaoti><span class="searchzone">״̬</span></TD>
    <TD width=134 align="center" class=biaoti><span class="searchzone">����</span></TD>
    </TR>
	<%listContent%>
    </TBODY></TABLE>
</DIV>
<DIV class="piliang">
<INPUT onClick="SelAll(this.form)" type="checkbox" value="1" name="SELALL"> ȫѡ&nbsp;
<INPUT class="button" type="submit" value="ɾ��" onClick="if(confirm('ȷ��Ҫɾ����')){form.action='?action=del<%="&sortType="&sortType&"&sortid="&sortid&"&keyword="&keyword&"&page="&page&"&psize="&psize&"&order="&order&"&ordsc="&ordsc&""%>';}else{return false};"/>  
<INPUT class="button" type="submit" value="����" onClick="form.action='?action=off<%="&sortType="&sortType&"&sortid="&sortid&"&keyword="&keyword&"&page="&page&"&psize="&psize&"&order="&order&"&ordsc="&ordsc&""%>';"./>
<INPUT class="button" type="submit" value="����" onClick="form.action='?action=on<%="&sortType="&sortType&"&sortid="&sortid&"&keyword="&keyword&"&page="&page&"&psize="&psize&"&order="&order&"&ordsc="&ordsc&""%>';"/>
<INPUT class="button" type="submit" value="��������" onClick="form.action='?action=order<%="&sortType="&sortType&"&sortid="&sortid&"&keyword="&keyword&"&page="&page&"&psize="&psize&"&order="&order&"&ordsc="&ordsc&""%>';"/>

Ŀ�����:<%LoadSelect "moveSortID","Aspcms_Sort","SortName","SortID",getForm("id","get"), 0," and( sortid in(select ParentID from {prefix}Sort where 1=1 and SortType="&sortType&" order by SortOrder) or SortType="&sortType&")","��ѡ�����"%>
<INPUT class="button" type="submit" value="�ƶ�" onClick="form.action='?action=move<%="&sortType="&sortType&"&sortid="&sortid&"&keyword="&keyword&"&page="&page&"&psize="&psize&"&order="&order&"&ordsc="&ordsc&""%>';"/> <INPUT class="button" type="submit" value="����" onClick="form.action='?action=copy<%="&sortType="&sortType&"&sortid="&sortid&"&keyword="&keyword&"&page="&page&"&psize="&psize&"&order="&order&"&ordsc="&ordsc&""%>';"/> <input class="input" value="<%=now%>" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="WIDTH: 120px" name="Timeing"/><INPUT class="button" type="submit" value="��ʱ����" onClick="form.action='?action=rpost<%="&sortType="&sortType&"&sortid="&sortid&"&keyword="&keyword&"&page="&page&"&psize="&psize&"&order="&order&"&ordsc="&ordsc&""%>';"/>

</DIV>
</FORM>
</BODY></HTML>