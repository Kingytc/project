<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />        
<lapschoice:handleerror />
<%
ArrayList arrRecvRow = (ArrayList)hshValues.get("arrRow"); 
ArrayList arrRecvCol=new ArrayList();

String RefId = request.getParameter("hidapprefid");
%>
<html>
<head>
<title>NSDL Application - MailBox</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
	<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var varUserId = "<%=Helper.correctNull((String) session.getAttribute("strUserId"))%>";

function doReallocate(varrefid,presSolid)
{
	if(trim(document.forms[0].org_code.value)=="")
	{
		alert("Please Select Branch");
		return;
	}
		var flag = confirm("Do you wish to transfer the application from current org_scode '"+ presSolid+"' to the org_scode '"+document.forms[0].org_alphacode.value+"' ?");
		if (flag)
		{
			parent.document.forms[0].hidReferId.value=varrefid;
			parent.document.forms[0].org_code.value=document.forms[0].org_code.value;
			parent.document.forms[0].org_alphacode.value=document.forms[0].org_alphacode.value;
			parent.document.forms[0].hidBeanId.value="PSB59";
			parent.document.forms[0].hidBeanMethod.value="updateReallocationList";
			parent.document.forms[0].hidBeanGetMethod.value="getReallocationList";
			parent.document.forms[0].action=appUrl+"controllerservlet";
			parent.document.forms[0].hidSourceUrl.value="/action/np_reallocation.jsp";
			parent.document.forms[0].submit();
		}
		
}
function callOrgSearchPopUp()
{
	var prop = "scrollbars=no,width=450,height=450,top=100,left=250";
	var url=appUrl+"action/orgnamelist.jsp?hidBeanGetMethod=getDataHelp&pageModule=nsdl";
	window.open(url,"",prop);
}

function callAppStatusPopUp(varrefId,refId,Appnum)
{
		var	varQryString = appUrl+"action/nsdlShowAppDetails.jsp?hidBeanId=nsdl&hidBeanGetMethod=getReallocationList&strRefId="+varrefId+"&RefId="+varrefId+"&hidUserId="+varUserId+"&ApplicationNum="+Appnum
		+"&from=Realloc";	
		var title = "ApplicantionStatus";
		var prop = "scrollbars=yes,width=850,height=550";	
		var xpos = (screen.width - 500) / 2;
		var ypos = (screen.height - 400) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(varQryString,title,prop);
}

function callDocument(varrefId,refId)
{
	var	varQryString = appUrl+"action/nsdlViewDocument.jsp?hidBeanId=nsdl&hidBeanGetMethod=getDocumentList&strRefId="+varrefId+"&RefId="+refId;	
	var title = "ApplicantionStatus";
	var prop = "scrollbars=yes,width=850,height=550";	
	var xpos = (screen.width - 500) / 2;
	var ypos = (screen.height - 400) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(varQryString,title,prop);
}

</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<style>
.mailbox_container {
	width: 100%;
	height: 350px;
	overflow: auto;
}
</style>
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"	type="text/css">
</head>
<body>

<form name="mails" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center">
	<%if(arrRecvRow!=null && arrRecvRow.size()>0)
	{ 
	for(int k=0;k<arrRecvRow.size();k++)
	{
		arrRecvCol=(ArrayList)arrRecvRow.get(k);
	%>
		<tr class="datagrid">
			<td width="15%" align="center" ><%=Helper.correctNull((String)arrRecvCol.get(3)) %>&nbsp;
				<a href="#" onClick=""> Edit </a>
				<a href="#" onClick=""> Document </a>
			</td>
			<td width="10%" align="center" ><%=Helper.correctNull((String)arrRecvCol.get(6)) %>&nbsp;</td>
			<td width="10%" align="center" ><%=Helper.correctNull((String)arrRecvCol.get(4)) %>&nbsp;</td>
			<td width="10%" align="center" ><%=Helper.correctNull((String)arrRecvCol.get(5)) %>&nbsp;</td>
			<td width="10%" align="center" ><%=Helper.correctNull((String)arrRecvCol.get(7)) %>&nbsp;</td>
			<td width="15%" align="center">
			<table width="70%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td><input type="text" name="org_name" size="20" readonly
							value=""></td>
						<td id="org"><a href="#"
							onClick="javascript:callOrgSearchPopUp()"> <img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp_bk.gif"
							border="0"> </a></td>
					</tr>
			</table>
			</td>
			<td align="center" width="10%" ><input type="button" value="Reallocate" name="cmdReceive" onclick="doReallocate('<%=Helper.correctNull((String)arrRecvCol.get(3))%>',
			 																												'<%=Helper.correctNull((String)arrRecvCol.get(7))%>')" 
			style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:60" class="buttoncolor">&nbsp;</td>
		</tr>
	<%}}else{ %>
	<%for(int i=0;i<3;i++){ %>
	<tr  class="dataGridColor" >
		<td align="center">&nbsp;</td>
		<td align="center">&nbsp;</td>
		<td align="center">&nbsp;</td>
		<td align="center">&nbsp;</td>
		<td align="center">&nbsp;</td>
		<td align="center">&nbsp;</td>
		<td align="center">&nbsp;</td>
		<td align="center">&nbsp;</td>
	</tr>
	<%if(i==1) {%>
	<tr  class="dataGridColor" >
		<td colspan="8" align="center">&nbsp;-- No Record Found --&nbsp;</td>
	</tr>
	<%} %>
	<%}} %>
</table>
<input type="hidden" name="org_code" value="">
<input type="hidden" name="org_alphacode" value="">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidBeanId" value=""> 
<input type="hidden" name="hidBeanMethod" value=""> 
<input type="hidden" name="hidSourceUrl" value="">
<input type="hidden" name="hidReferId" value="">
<input type="hidden" name="mail_tousrid" value="">
</form>
</body>
</html>
