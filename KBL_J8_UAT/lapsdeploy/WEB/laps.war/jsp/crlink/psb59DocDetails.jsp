<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />        
<lapschoice:handleerror />
<%
session.setAttribute("CURRENT_TAB","DOC_DETAILS");
ArrayList arrRow = (ArrayList)hshValues.get("arrRow"); 
ArrayList arrCol=new ArrayList();
String strApplicationRefNo=Helper.correctNull((String)hshValues.get("hidApplicantId"));
%>

<html>
<head>
<title>National Portal - Documents</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRefid= "<%=strApplicationRefNo%>";

function callclose()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
	document.forms[0].submit();
}

function callOnLoad()
{

}
function SelectValues(sno,docType)
{
	//document.all.ifrm.src=appURL+"action/ifrmnsdllViewDocument.jsp?hidBeanId=nsdl&hidBeanGetMethod=viewAttachedDocument&strRefId="+refid+"&hidSno="+sno;
    var refid = varRefid;
	var appUrl="<%=ApplicationParams.getAppUrl()%>";
	var url = appURL+"action/ifrmnsdllViewDocument.jsp?hidBeanId=NationalPortal&hidBeanGetMethod=NP_viewAttachedDocument&strRefId="+refid+"&hidSno="+sno;
	var title = "Documents";
	var prop = "scrollbars=yes,width=750,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}
function SelectValuesview(sno,docType)
{
	//document.all.ifrm.src=appURL+"action/ifrmnsdllViewDocument.jsp?hidBeanId=nsdl&hidBeanGetMethod=viewAttachedDocument&strRefId="+refid+"&hidSno="+sno;
    var refid = varRefid;
	var appUrl="<%=ApplicationParams.getAppUrl()%>";
	var url = appURL+"action/ifrmnsdllViewDocument.jsp?hidBeanId=NationalPortal&hidBeanGetMethod=Nationalportaldocdownload&hidAction=DownloadExcelNP&strRefId="+refid+"&hidSno="+sno+"&download=Y";
	var title = "Documents";
	var prop = "scrollbars=yes,width=750,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}
</script>
<%-- <link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"> --%>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/NationalPortal.css" type="text/css">
<style>
.mailbox_container
{
	width: 100%;
	height: 350px;
	overflow: auto;
}
</style>

</head>
<body onload="callOnLoad()">
<form name="docVerForm" method="post" action="" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td valign="top" colSpan="5"> 
      <jsp:include page="../crlink/PSB59ApplicationDetails.jsp" flush="true" /> 
    </td>
  </tr>
</table> 
<table width="98%" border="0" cellpadding="3" cellspacing="0" bordercolorlight="#cccccc" bordercolordark="#FFFFFB" class="shadow" align="center">
<tr><td>     
<table width="100%" cellspacing="0" cellpadding="3" align="center" class="shadow">        
<tr class="dataheader" align="center">
	<td >
	<font size="2"><b>DOCUMENT DETAILS</b></font></td></tr>
	<tr></tr>
	<tr>
	<td>
	<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
		    <td width="10%" nowrap="nowrap"  align="center"> Document List</td>
			<td width="10%" nowrap="nowrap"  align="center"> Document Type</td>
        	<td width="10%" nowrap="nowrap"  align="center"> Type</td>
			<!-- <td width="10%" nowrap="nowrap"  align="center"> Document View</td> -->
			<td width="10%" nowrap="nowrap"  align="center"> Download Document </td>
	  </tr>
	 <% if(arrRow != null && arrRow.size() > 0){
       for(int i = 0; i < arrRow.size(); i++){
			arrCol = (ArrayList) arrRow.get(i);
			if (arrCol != null && arrCol.size() > 0) {
			String extension = Helper.correctNull((String)arrCol.get(3));
			%>
		<tr height="30px">
		    <td align="center"><%=Helper.correctNull((String)arrCol.get(0)) %></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(2)) %></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(1)) %></td>
			<%if(extension.equalsIgnoreCase("pfd")) { %>
			<td align="center" width="4%"><img src="<%=ApplicationParams.getAppUrl()%>/img/printer.png" alt="Save" name="img_save" onClick="SelectValues('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(2))%>')">
					      </td><%}else{ %>
		 <td align="center" width="4%"><img src="<%=ApplicationParams.getAppUrl()%>/img/printer.png" alt="Save" name="img_save" onClick="SelectValuesview('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(2))%>')">
					      </td>
					      
		</tr>
		<%}}}%>
			<%}else{ %>
			<tr  height="50px">
				<td colspan="10" align="center">-- No Record Found --&nbsp;</td>
			</tr>
			<%} %>
	</table>
	</td>
	</tr>
</table>
</td></tr>
</table>

<input type="hidden" name="hidUserId" value="">
<table border="0" cellspacing="0" cellpadding="0"  align="center">
      <tr valign="middle"> 
       <td> 
		<input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="callclose();">
	
          
        </td></tr></table>

</form>
</body>
</html>