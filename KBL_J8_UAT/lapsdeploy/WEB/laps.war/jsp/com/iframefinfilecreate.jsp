<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%

String strgraphname=request.getParameter("hidgraphname");
String strgraphcode=request.getParameter("hidgraphcode");
String strgraphtype=request.getParameter("hidgraphtype");

String strinterim=request.getParameter("hidinterim");
String strmost=request.getParameter("hidmost");
String strprev=request.getParameter("hidprev");
String strlast=request.getParameter("hidlast");

String strParam1=request.getParameter("hidParam1");
String strParam2=request.getParameter("hidParam2");
String strParam3=request.getParameter("hidParam3");
String strParam4=request.getParameter("hidParam4");

String strDesc=request.getParameter("hiddesc");

String strContent="";

strContent="4&"+strinterim+"&"+strmost+"&"+strprev+"&"+strlast+"&"+strParam1+"&"+strParam2+"&"+strParam3+"&"+strParam4+"&Value (in Rs.)&bar&"+strgraphname+" - "+strDesc+".grh";

%>
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>
<script>
var path ="<%=ApplicationParams.getAppUrl()%>";
function onloading()
{
if('<%=strContent%>'!="")
	{
			document.forms[0].action=path+"controllerservlet";
			document.forms[0].hidBeanId.value="graphicalreports";
			document.forms[0].hidBeanMethod.value="getData";
			document.forms[0].hidMethod.value="getCreateFile";
			document.forms[0].hidgraphname.value="<%=strgraphname%>";
			document.forms[0].hidgraphtype.value="<%=strgraphtype%>";
			document.forms[0].hidfilecontent.value="<%=strContent%>";
			document.forms[0].hidSourceUrl.value="/action/iframeshowrisk.jsp";
			document.forms[0].submit();
	}
}
	
</script>
<BODY onload="onloading()" method="post">
<form name="frmfilecreate">

<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidMethod">
<input type="hidden" name="hidSourceUrl">
<input type="hidden" name="hidgraphname">
<input type="hidden" name="hidgraphtype">
<input type="hidden" name="hidfilecontent">

</form>
</BODY>
</HTML>
