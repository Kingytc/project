<%@ page import="com.sai.laps.helper.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<%
String appno=Helper.correctNull((String)request.getParameter("appno"));
String pageid = Helper.correctNull((String)request.getParameter("pageid"));
String strProductType= "";
strProductType = Helper.correctNull((String)session.getAttribute("strProductType"));
String strcategorytype=Helper.correctNull((String)request.getParameter("hidCategoryType"));

//System.out.println("================================================"+strProductType);
%>
<html>
<head>
<title>LAPS</title>
<script language="JavaScript">
function dopage()
{
	document.all.f2.style.visibility="visible";
	document.all.f2.style.position="relative";
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<frameset rows="148,*" frameborder="NO" border="0" framespacing="0" cols="1">
	<frame name="menuFrame" scrolling="no" noresize src="TopLevelframe1.jsp?hidBeanId=dynamictabs&hidBeanGetMethod=getAppraisalTabData&hidCategoryType=<%=strcategorytype%>&appno=<%=appno%>">
	<%if(strProductType.equalsIgnoreCase("aC")){%>
 <frame id="f2" name="mainFrame" src="agr_pre_sanction.jsp?hidBeanId=appraisal&hidBeanMethod=&hidBeanGetMethod=getPresanction&initial=yes&appno=<%=appno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aD")){%>
 <frame id="f2" name="mainFrame" src="agr_pre_sanction.jsp?hidBeanId=appraisal&hidBeanMethod=&hidBeanGetMethod=getPresanction&initial=yes&appno=<%=appno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aF")){%>
 <frame id="f2" name="mainFrame" src="agr_pre_sanction.jsp?hidBeanId=appraisal&hidBeanMethod=&hidBeanGetMethod=getPresanction&initial=yes&appno=<%=appno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aB")){%>
 <frame id="f2" name="mainFrame" src="agr_pre_sanction.jsp?hidBeanId=appraisal&hidBeanMethod=&hidBeanGetMethod=getPresanction&initial=yes&appno=<%=appno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aL")){%>
 <frame id="f2" name="mainFrame" src="agr_pre_sanction.jsp?hidBeanId=appraisal&hidBeanMethod=&hidBeanGetMethod=getPresanction&initial=yes&appno=<%=appno%>" >
<%}else if(strProductType.equalsIgnoreCase("aM")){%>
 <frame id="f2" name="mainFrame" src="agr_pre_sanction.jsp?hidBeanId=appraisal&hidBeanMethod=&hidBeanGetMethod=getPresanction&initial=yes&appno=<%=appno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aT")){%>
 <frame id="f2" name="mainFrame" src="agr_pre_sanction.jsp?hidBeanId=appraisal&hidBeanMethod=&hidBeanGetMethod=getPresanction&initial=yes&appno=<%=appno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aS")){%>
 <frame id="f2" name="mainFrame" src="agr_pre_sanction.jsp?hidBeanId=appraisal&hidBeanMethod=&hidBeanGetMethod=getPresanction&initial=yes&appno=<%=appno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aK")){%>
 <frame id="f2" name="mainFrame" src="agr_pre_sanction.jsp?hidBeanId=appraisal&hidBeanMethod=&hidBeanGetMethod=getPresanction&initial=yes&appno=<%=appno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aG")){%>
 <frame id="f2" name="mainFrame" src="agr_pre_sanction.jsp?hidBeanId=appraisal&hidBeanMethod=&hidBeanGetMethod=getPresanction&initial=yes&appno=<%=appno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aQ")){%>
 <frame id="f2" name="mainFrame" src="agr_pre_sanction.jsp?hidBeanId=appraisal&hidBeanMethod=&hidBeanGetMethod=getPresanction&initial=yes&appno=<%=appno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aE")){%>
 <frame id="f2" name="mainFrame" src="agr_pre_sanction.jsp?hidBeanId=appraisal&hidBeanMethod=&hidBeanGetMethod=getPresanction&initial=yes&appno=<%=appno%>" >
 <%}else if(strProductType.equalsIgnoreCase("aJ")){%>
 <frame id="f2" name="mainFrame" src="agr_pre_sanction.jsp?hidBeanId=appraisal&hidBeanMethod=&hidBeanGetMethod=getPresanction&initial=yes&appno=<%=appno%>" >
<%}else if(strProductType.equalsIgnoreCase("aU")){%>
 <frame id="f2" name="mainFrame" src="agr_pre_sanction.jsp?hidBeanId=appraisal&hidBeanMethod=&hidBeanGetMethod=getPresanction&initial=yes&appno=<%=appno%>" >
<%}else if(strProductType.equalsIgnoreCase("aH")){%>
 <frame id="f2" name="mainFrame" src="agr_gold_eligibility.jsp?hidBeanId=agriapprisal&hidBeanMethod=&hidBeanGetMethod=getagrigloddata&initial=yes&appno=<%=appno%>" >
<%} else if(strProductType.equalsIgnoreCase("aI")){%>
 <frame id="f2" name="mainFrame" src="agr_pre_sanction.jsp?hidBeanId=appraisal&hidBeanMethod=&hidBeanGetMethod=getPresanction&initial=yes&appno=<%=appno%>" >
<%} else if(strProductType.equalsIgnoreCase("aR")){%>
 <frame id="f2" name="mainFrame" src="agr_fd_eligibility.jsp?hidBeanId=agriapprisal&hidBeanMethod=&hidBeanGetMethod=getagrifddata&initial=yes&appno=<%=appno%>" >
<%}else if(strProductType.equalsIgnoreCase("aN")){%>
 <frame id="f2" name="mainFrame" src="agr_pre_sanction.jsp?hidBeanId=appraisal&hidBeanMethod=&hidBeanGetMethod=getPresanction&initial=yes&appno=<%=appno%>" >
<%} else if(strProductType.equalsIgnoreCase("aP")){%>
 <frame id="f2" name="mainFrame" src="agr_pre_sanction.jsp?hidBeanId=appraisal&hidBeanMethod=&hidBeanGetMethod=getPresanction&initial=yes&appno=<%=appno%>" >
<%} else if(strProductType.equalsIgnoreCase("aA")){%>
<frame id="f2" name="mainFrame" src="agr_pre_sanction.jsp?hidBeanId=appraisal&hidBeanMethod=&hidBeanGetMethod=getPresanction&initial=yes&appno=<%=appno%>" >
 <%} else if(strProductType.equalsIgnoreCase("aV")){%>
<frame id="f2" name="mainFrame" src="agr_pre_sanction.jsp?hidBeanId=appraisal&hidBeanMethod=&hidBeanGetMethod=getPresanction&initial=yes&appno=<%=appno%>" >
 <%} else if(strProductType.equalsIgnoreCase("aW")){%>
<frame id="f2" name="mainFrame" src="agr_pre_sanction.jsp?hidBeanId=appraisal&hidBeanMethod=&hidBeanGetMethod=getPresanction&initial=yes&appno=<%=appno%>" >
  <%} else if(strProductType.equalsIgnoreCase("aO")){%>
<frame id="f2" name="mainFrame" src="agr_pre_sanction.jsp?hidBeanId=appraisal&hidBeanMethod=&hidBeanGetMethod=getPresanction&initial=yes&appno=<%=appno%>" >
 
<%}%> 
</frameset>

<noframes>
<body text="#000000" onload="dopage()">
<form>
<input type="text" name="appno" value="<%=appno%>">
</form>
</body>
</noframes>

</html>
