<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
	<%
		String strdesk=Helper.correctNull(request.getParameter("rdodesk"));
		ArrayList arryCol=null;
		ArrayList arryRow=(ArrayList)hshValues.get("arryRow");
	%>

<html>

<head>
<title>searchresults</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript">
function callLink(appid,appstat,compstat)
{
	var appstatus = appstat;
	document.forms[0].hidAppType.value="";
	document.forms[0].radLoan.value="Y";
	document.forms[0].page.value="ep";
	document.forms[0].appno.value=appid;
	document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].hidBeanGetMethod.value="getLoanProducts";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perloandetails.jsp?appstatus="+appstatus;
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}

</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="isearch" method="post">
<!--<table width="100%" border="0" cellpadding="1" cellspacing="0">-->

<%
	if(arryRow!=null && arryRow.size()>0)
	{
		for(int i=0;i<arryRow.size();i++)
		{
			arryCol=(ArrayList)arryRow.get(i);
			if(arryCol!=null)
			{
			
%>
  <!--<tr>
    <td><a href="JavaScript:callLink('<%=arryCol.get(0)%>')"><%=arryCol.get(0)%></a></td>
    <td><%=arryCol.get(1)%>&nbsp;<%=arryCol.get(2)%>&nbsp;<%=arryCol.get(3)%></td>
    <td><%=arryCol.get(4)%></td>
  </tr>
  -->

   
  <table width="100%" border="0" cellspacing="1" cellpadding="2" bordercolorlight="#EBEBF8" bordercolordark="#82829F">
    <tr> 
      <td width="12%"><font size="1" face="MS Sans Serif"><b><a href="JavaScript:callLink('<%=arryCol.get(0)%>','<%=arryCol.get(4)%>','<%=arryCol.get(5)%>')" class="blackfont"><%=arryCol.get(0)%></a></b></font></td>
      <td width="18%"><font size="1" face="MS Sans Serif"><%=arryCol.get(1)%> 
        </font></td>
      <td width="15%"><font size="1" face="MS Sans Serif"><%=arryCol.get(2)%></font></td>
      <td width="11%"><font size="1" face="MS Sans Serif"><%=arryCol.get(3)%></font></td>
      <td width="13%"><font size="1" face="MS Sans Serif"><%=arryCol.get(4)%></font></td>
      <td width="14%"><font size="1" face="MS Sans Serif"><%=arryCol.get(5)%></font></td>
      <%
			 if(strdesk.equalsIgnoreCase("M"))
			{
	   %>
      <td width="7%"><font size="1" face="MS Sans Serif"><%=arryCol.get(6)%> </font></td>
      <td width="10%"><font size="1" face="MS Sans Serif"><%=arryCol.get(7)%> 
        </font></td>
      <%
			}   
	   %>
    </tr>
  </table>
<%
			}
		}
	}
%>
	<INPUT TYPE="hidden" name="hidAppType">
	<INPUT TYPE="hidden" name="hidBeanId">
	<INPUT TYPE="hidden" name="hidBeanGetMethod">
	<input type="hidden" name="radLoan" >
	<input type="hidden" name="page">
	<input type="hidden" name="appno">

</form>
</body>
</html>
