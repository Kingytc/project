<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
  ArrayList arrcomappid=(ArrayList)hshValues.get("arrcomappid");
  ArrayList arrcomname= (ArrayList)hshValues.get("arrcomname");
  ArrayList arrcomid=(ArrayList)hshValues.get("arrcomid");
  //out.println(arrcomappid);
 // out.println(arrcomid);
%>
<html>
<head>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";

  function callPage(id,pagename,methodname,param,tabname)
  {
	if(methodname=="getGeneralDetails")
	{
		document.forms[0].hidparam.value =param;
	}
	if(pagename=="com_insrep_page1.jsp")
	{
		document.forms[0].otherGetMethod.value ="proposal";
	}

	document.forms[0].method="post";	
	document.forms[0].hidTabName.value=tabname;	
	document.forms[0].hidMethod.value=methodname;
	document.forms[0].target="mainFrame";
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
	/* document.forms[0].comapp_id.value=id;
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/com_insrep_page1.jsp?hidBeanId=commappmaster&hidBeanGetMethod=getData";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();*/
  }
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body bgcolor="#EEEAE3" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="srchform" method ="post">
  <table width="100%" border="0" cellspacing="1" cellpadding="3" bordercolorlight="#EBEBF8" bordercolordark="#82829F">
    <% for(int i=0;i<arrcomappid.size();i++){ %>
    <tr > 
      <td width="50%"><a href="javascript:callPage('<%=arrcomappid.get(i)%>','com_insrep_page1.jsp','getGeneralDetails','PurposeofInspection^DateofSubmissionofReport^DateofInspection^Name^Name1^Designation^Designation1','INSPECTIONREPORTFIRST')" class="blackfont"><font size="1" face="MS Sans Serif"><b>&nbsp;&nbsp;<%=arrcomname.get(i)%></b></font></a></td>
      <td width="50%"><font size="1" face="MS Sans Serif">&nbsp;&nbsp;<%=arrcomid.get(i)%></font></td>
    </tr>
    <%}%>
  </table>
<input type="text" name="comapp_id" >
<input type="hidden" name="hidOtherMethod" value="">
<INPUT TYPE="hidden" NAME="hidparam" VALUE="">
<input type="hidden" name="hidTabName"  VALUE="" >
<INPUT TYPE="hidden" NAME="hidMethod" VALUE="">
<input type="hidden" name="otherGetMethod" value="">
<input type="text" name="appno" value="ABCIABCI0000004" >
<input type="text" name="txt_insdate" value="01/02/2000" >




</form>
</body>
</html>
