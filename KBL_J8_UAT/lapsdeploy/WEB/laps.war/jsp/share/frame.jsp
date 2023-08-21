<%@ page import="java.net.InetAddress"%>
<%@ page import="com.sai.laps.helper.*"%>
<html>
<% 
String strTitle="";
strTitle="\t\""+session.getAttribute("strUserId")+"\"\t\""+session.getAttribute("strOrgName")+"\"";
%>
<head>
<link rel="icon" href="<%=com.sai.laps.helper.ApplicationParams.getAppUrl()%>img/favicon.ico" type="image/x-icon">
<link rel="shortcut icon" href="<%=com.sai.laps.helper.ApplicationParams.getAppUrl()%>img/favicon.ico" />
<title>KBL&nbsp;&nbsp;&nbsp;  " <%=(InetAddress.getLocalHost().getHostAddress().equalsIgnoreCase("172.31.14.147"))?"UAT SERVER":""%> <%=strTitle%>    "</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<script language="JavaScript">
var  varUserID="<%=Helper.correctNull((String)session.getAttribute("strUserId"))%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
window.onbeforeunload=function callUnLoad()
{
	if((window.event.clientX<0)||(window.event.clientY<0))
 	{
	 	var varQryString = "<%=ApplicationParams.getAppUrl()%>action/iframeMultiLogins.jsp?hidBeanId=authenticate&val=exit&hidPage=Navigation&hidusr_id="+varUserID;
		window.open(varQryString,"title","scrollbars=yes,status=1,menubar=no,resizable,location=0,toolbar=0,width="+(screen.width-13)+",height="+(screen.height-85)+",left=0,top=0");
	}
}




</script>
</head>

<frameset rows="100,*" frameborder="NO" border="0" framespacing="0" cols="*"> 
  <frame name="topFrame" scrolling="NO" noresize src="topframe.jsp" >
  <frame name="mainFrame" src="mainnav.jsp" ></frameset>
<noframes> 
</noframes> 
</html>
