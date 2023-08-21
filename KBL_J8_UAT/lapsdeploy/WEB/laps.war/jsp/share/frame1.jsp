<%@ page import="com.sai.laps.helper.*"%>
<%
String strProductType= "";
strProductType = Helper.correctNull((String)session.getAttribute("strProductType"));
String strcategorytype=Helper.correctNull((String)request.getParameter("hidCategoryType"));
String strAppno=Helper.correctNull((String)request.getParameter("appno"));

//System.out.println("=============================================================="+request.getParameter("appno"));
//System.out.println("=============================================================="+session.getAttribute("strappno"));
%>
<html>
<head>
<title>LAPS</title>
<script language="JavaScript">
var varcattype="<%=strcategorytype%>";
function dopage()
{
	document.all.f1.style.visibility="visible";
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<frameset rows="122,*" frameborder="NO" border="0" framespacing="0" cols="1">	
<frame name="menuFrame" scrolling="no" noresize  src="TopLevelframe.jsp?hidCategoryType=<%=strcategorytype%>&appno=<%=strAppno%>">
 <%if(strProductType.equalsIgnoreCase("aC")){%>
 <frame id="f1" name="mainFrame" src="agrlandholdings.jsp?hidBeanId=agrlandholdings&hidBeanGetMethod=getData&initial=yes&appno=<%=strAppno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aD")){%>
 <frame id="f1" name="mainFrame" src="agrlandholdings.jsp?hidBeanId=agrlandholdings&hidBeanMethod=&hidBeanGetMethod=getData&initial=yes&appno=<%=strAppno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aH")){%>
 <frame id="f1" name="mainFrame" src="agrlandholdings.jsp?hidBeanId=agrlandholdings&hidBeanMethod=&hidBeanGetMethod=getData&initial=yes&appno=<%=strAppno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aR")){%>
 <frame id="f1" name="mainFrame" src="agrlandholdings.jsp?hidBeanId=agrlandholdings&hidBeanMethod=&hidBeanGetMethod=getData&initial=yes&appno=<%=strAppno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aF")){%>
 <frame id="f1" name="mainFrame" src="agrlandholdings.jsp?hidBeanId=agrlandholdings&hidBeanMethod=&hidBeanGetMethod=getData&initial=yes&appno=<%=strAppno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aB")){%>
 <frame id="f1" name="mainFrame" src="agrlandholdings.jsp?hidBeanId=agrlandholdings&hidBeanMethod=&hidBeanGetMethod=getData&initial=yes&appno=<%=strAppno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aL")){%>
 <frame id="f1" name="mainFrame" src="agrlandholdings.jsp?hidBeanId=agrlandholdings&hidBeanMethod=&hidBeanGetMethod=getData&initial=yes&appno=<%=strAppno%>" >
<%}else if(strProductType.equalsIgnoreCase("aM")){%>
 <frame id="f1" name="mainFrame" src="agrlandholdings.jsp?hidBeanId=agrlandholdings&hidBeanMethod=&hidBeanGetMethod=getData&initial=yes&appno=<%=strAppno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aP")){%>
 <frame id="f1" name="mainFrame" src="agrlandholdings.jsp?hidBeanId=agrlandholdings&hidBeanMethod=&hidBeanGetMethod=getData&initial=yes&appno=<%=strAppno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aT")){%>
 <frame id="f1" name="mainFrame" src="agrlandholdings.jsp?hidBeanId=agrlandholdings&hidBeanMethod=&hidBeanGetMethod=getData&initial=yes&appno=<%=strAppno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aQ")){%>
 <frame id="f1" name="mainFrame" src="agrlandholdings.jsp?hidBeanId=agrlandholdings&hidBeanMethod=&hidBeanGetMethod=getData&initial=yes&appno=<%=strAppno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aS")){%>
 <frame id="f1" name="mainFrame" src="agrlandholdings.jsp?hidBeanId=agrlandholdings&hidBeanMethod=&hidBeanGetMethod=getData&initial=yes&appno=<%=strAppno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aK")){%>
 <frame id="f1" name="mainFrame" src="agrlandholdings.jsp?hidBeanId=agrlandholdings&hidBeanMethod=&hidBeanGetMethod=getData&initial=yes&appno=<%=strAppno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aG")){%>
 <frame id="f1" name="mainFrame" src="agrlandholdings.jsp?hidBeanId=agrlandholdings&hidBeanMethod=&hidBeanGetMethod=getData&initial=yes&appno=<%=strAppno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aE")){%>
 <frame id="f1" name="mainFrame" src="agrlandholdings.jsp?hidBeanId=agrlandholdings&hidBeanMethod=&hidBeanGetMethod=getData&initial=yes&appno=<%=strAppno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aA")){%>
 <frame id="f1" name="mainFrame" src="agrlandholdings.jsp?hidBeanId=agrlandholdings&hidBeanMethod=&hidBeanGetMethod=getData&initial=yes&appno=<%=strAppno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aI")){%>
 <frame id="f1" name="mainFrame" src="agrlandholdings.jsp?hidBeanId=agrlandholdings&hidBeanMethod=&hidBeanGetMethod=getData&initial=yes&appno=<%=strAppno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aJ")){%>
 <frame id="f1" name="mainFrame" src="agrlandholdings.jsp?hidBeanId=agrlandholdings&hidBeanMethod=&hidBeanGetMethod=getData&initial=yes&appno=<%=strAppno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aU")){%>
 <frame id="f1" name="mainFrame" src="agrlandholdings.jsp?hidBeanId=agrlandholdings&hidBeanMethod=&hidBeanGetMethod=getData&initial=yes&appno=<%=strAppno%>" >
 <%} else if(strProductType.equalsIgnoreCase("aN")){%>
 <frame id="f1" name="mainFrame" src="agrlandholdings.jsp?hidBeanId=agrlandholdings&hidBeanMethod=&hidBeanGetMethod=getData&initial=yes&appno=<%=strAppno%>" >
 <%} else if(strProductType.equalsIgnoreCase("aO")){%>
 <frame id="f1" name="mainFrame" src="agrlandholdings.jsp?hidBeanId=agrlandholdings&hidBeanMethod=&hidBeanGetMethod=getData&initial=yes&appno=<%=strAppno%>" >
 <%} else if(strProductType.equalsIgnoreCase("aV")){%>
 <frame id="f1" name="mainFrame" src="agrlandholdings.jsp?hidBeanId=agrlandholdings&hidBeanMethod=&hidBeanGetMethod=getData&initial=yes&appno=<%=strAppno%>" >
 <%} else if(strProductType.equalsIgnoreCase("aW")){%>
 <frame id="f1" name="mainFrame" src="agrlandholdings.jsp?hidBeanId=agrlandholdings&hidBeanMethod=&hidBeanGetMethod=getData&initial=yes&appno=<%=strAppno%>" >
 
 <%} %>
</frameset>
<noframes>
<body text="#000000" onload="dopage()">
<form>
<input type="text" name="appno" value="<%=Helper.correctNull((String)request.getParameter("appno"))%>">
</form>
</body>
</noframes>
</html>
