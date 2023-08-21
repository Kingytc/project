<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<% 
	//String strMail = request.getParameter("hidmail"); 
	//String strPerMail = request.getParameter("hidpermail"); 
	//String strComMail = request.getParameter("hidcommail"); 
%>
<frameset rows="48,*" frameborder="NO" border="0" framespacing="0" cols="*"> 
  <frame name="topFrame" scrolling="NO" noresize src="topframe.jsp" >
 <frame name="mainFrame" src="navigation.jsp">
  
  <!--<%
if(strMail.equalsIgnoreCase("NotAvail"))
{
%>
  <frame name="mainFrame" src="navigation.jsp">
  <%
}
else
{
%>
  <%
}
%>-->
</frameset>
<noframes> 
<body bgcolor="#FFFFFF" text="#000000">

</body>
</noframes> 
</html>
