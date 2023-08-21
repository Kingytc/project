<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%
	ArrayList arryRow=(ArrayList)hshValues.get("arrRow");
	ArrayList arryCol;

	
%>

<html>
<head>
<script>
function readXML()
{	var appno;
	var appname;
	var appstatus;
	document.forms[0].method="post";
	
	if("<%=request.getParameter("filetype")%>" != "companydtls")
	{
	appno = parent.document.forms[0].appno.value;
	appname = parent.document.forms[0].appname.value;
	appstatus = parent.document.forms[0].appstatus.value;
	}

	if("<%=request.getParameter("filetype")%>" == "companydtls")
	{
	document.forms[0].hidSourceUrl.value = "action/comappmastersearch.jsp"
	}
	
	if("<%=request.getParameter("filetype")%>" == "collateral")
	{
	document.forms[0].hidSourceUrl.value = "action/commcollateral.jsp?hidBeanGetMethod=getCollateral&appno="+appno+"&appname="+appname+"&appstatus="+appstatus;
	document.forms[0].hidappno.value=appno;
	}
	
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
	
}
</script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body bgcolor="#EEEAE3" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="f1" action="<%=ApplicationParams.getAppUrl()%>controllerservlet" method="post">
  <table width="100%" border="0" cellspacing="1" cellpadding="3" bordercolorlight="#EBEBF8" bordercolordark="#82829F">
    <%
      if(arryRow!=null)
	  {
		for(int i=0;i<arryRow.size();i++)
	  {
		  arryCol=(ArrayList)arryRow.get(i);
%>
    <tr > 
      <td width="14%" align="center"><b><font face="MS Sans Serif" size="1" color="#333333"> 
        <input type="radio" name="chkVal" value="<%=Helper.correctNull((String)arryCol.get(0))%>" onclick="readXML()">
        </font></b></td>
      <td width="52%"><b><font size="1" face="MS Sans Serif" color="#333333"><%=Helper.correctNull((String)arryCol.get(0))%></font></b></td>
      <td width="34%"><b><font size="1" face="MS Sans Serif" color="#333333"><%=Helper.correctNull((String)arryCol.get(1))%></font></b></td>
    </tr>
    <%
	  }
	  }
	  %>
  </table>
  <input type="hidden" name="filetype" value="<%=request.getParameter("filetype")%>">
  <input type="hidden" name="hidBeanId" value="offlinedata">
<input type=hidden name="hidBeanMethod" value="updateOffline">
<input type="hidden" name="hidSourceUrl" value="">
<input type="hidden" name="hidappno" value="">

</form>
</body>
</html>
