<%@include file="../share/directives.jsp"%>
<%ArrayList arrRow = (ArrayList)hshValues.get("arrRow"); 
ArrayList arrCol=new ArrayList();

String str_report= Helper.correctNull((String) request.getParameter("report"));

%>
<html>
<head>
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var varStatus="<%=Helper.correctNull((String)hshValues.get("status"))%>";

function chkAppcount()
{
	var varRefID="";
	<%
	if(arrRow!=null&&arrRow.size()>0)
	{
		if(arrRow.size()>1)
		{
			for(int l=0; l<arrRow.size(); l++)
			{%>
				if(document.forms[0].chkbox["<%=l%>"].checked==true)
				{
					<%arrCol=(ArrayList) arrRow.get(l);
					if(arrCol!=null && arrCol.size()>0)
					{%>
						varRefID=varRefID+"<%=Helper.correctNull((String)arrCol.get(0))%>"+"@";
					<%}%>
				}
			<%}
		}
		else if(arrRow.size()==1)
		{%>
			if(document.forms[0].chkbox.checked==true)
			{
				<%arrCol=(ArrayList) arrRow.get(0);
				if(arrCol!=null && arrCol.size()>0)
				{%>
					varRefID=varRefID+"<%=Helper.correctNull((String)arrCol.get(0))%>"+"@";
				<%}%>
			}
		<%}}%>
		varRefID= varRefID.substring(0,varRefID.length-1);
		document.forms[0].hidRefId.value=varRefID;
}
function doReallocate()
{
	var varFacility_Flag=false;
	var checkbox_len=document.forms[0].chkbox;
	var checkbox_length=checkbox_len.length;

	if(document.forms[0].chkbox.checked==true)
	{
		varFacility_Flag=true;
	}
	for(var k=0;k<checkbox_length;k++)
	{
		if(document.forms[0].chkbox[k].checked==true)
		{
			varFacility_Flag=true;
		}
	}
	if(varFacility_Flag)
	{
		chkAppcount();
		if(document.forms[0].org_scode.value!="")
		{
			document.forms[0].hidReallocationFlag.value="reallocation";
			document.forms[0].hidBeanId.value="nsdl";
			document.forms[0].hidBeanMethod.value="updateNSDLApplicationReallocation";
			document.forms[0].hidBeanGetMethod.value="getNSDLApplications";
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/NsdlReallocation.jsp";
			document.forms[0].submit();
		}
		else
		{
			alert("Please Select Organisation");
			return;
			
		}
	}
	else
	{
		alert("Please check any application");
		return;	
	}
}
function callclose()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/nsdlnavigation.jsp";
	document.forms[0].submit();
}
function showOrganizationSearch(path, forgscode, forgname)
{
	var varQryString = path+"action/searchOrg.jsp?forgscode="+forgscode+"&forgname="+forgname;
	var title = "Organization";
	var prop = "scrollbars=yes,width=500,height=400,menubar=yes";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString,title,prop);
}
function callOnLoad()
{
	if(varStatus.toUpperCase()=="SUCCESS")
	{
		alert("Application is Reallocated successfully");
		//document.forms[0].action=appUrl+"action/mainnav.jsp";
		//document.forms[0].submit();
	}
}
function callAppStatusPopUp(varrefId)
{
		var	varQryString = appUrl+"action/nsdlShowAppDetails.jsp?hidBeanId=nsdl&hidBeanGetMethod=getNsdlShowApplicationDetails&strRefId="+varrefId+"&paramtype="+"<%=str_report%>";	
		var title = "ApplicantionStatus";
		var prop = "scrollbars=yes,width=850,height=550";	
		var xpos = (screen.width - 500) / 2;
		var ypos = (screen.height - 400) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(varQryString,title,prop);
}
function callDocument(varrefId)
{
	var	varQryString = appURL+"action/nsdlViewDocument.jsp?hidBeanId=nsdl&hidBeanGetMethod=getDocumentList&strRefId="+varrefId;	
	var title = "ApplicantionStatus";
	var prop = "scrollbars=yes,width=850,height=550";	
	var xpos = (screen.width - 500) / 2;
	var ypos = (screen.height - 400) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(varQryString,title,prop);
}
</script>
<style>
.mailbox_container {
	width: 100%;
	height: 350px;
	overflow: auto;
}
</style>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callOnLoad()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt; NSDL Applications -&gt; NSDL
		Application </td>
	</tr>
</table>

<form name="mails" method="post">

<table width="95%" border="0" cellspacing="1" cellpadding="3"
	align="center"  class="viewcolor">
	<thead>
	<tr class="dataheader" class="title" >
		<th width="5%">&nbsp;</th>
		<th width="12%" nowrap="nowrap" align="center">Reference ID</th>
		<th width="7%" nowrap="nowrap" align="center">Applicant ID</th>
		<th width="15%" nowrap="nowrap" align="center">Applicant Name</th>
		<th width="8%" nowrap="nowrap" align="center">Branch SolID</th>
		<th width="12%" nowrap="nowrap" align="center">Branch Name</th>
		<th width="12%" nowrap="nowrap" align="center">Branch Region</th>
		<th width="8%" nowrap="nowrap" align="center">Received Date</th>
		
		<%if(str_report.equalsIgnoreCase("Update_App")){ %>
		<th width="8%" nowrap="nowrap" align="center">Application No.</th>
		<th width="7%" nowrap="nowrap" align="center">Status</th>
		<th width="7%" nowrap="nowrap" align="center">Proposal No.</th>
		<%} %>
		
	</tr>
	</thead>
	<%
	int a=0;
	if(arrRow!=null && arrRow.size()>0)
	{ 
		for(int k=0;k<arrRow.size();k++){ 
		arrCol=(ArrayList)arrRow.get(k);
		a=a+1;
		%>
		<tr class="datagrid">
						
			<%if(str_report.equalsIgnoreCase("Realloc")){ %>
			<td align="center">&nbsp;<input type="checkbox" name="chkbox" style="border: none;"> &nbsp;</td>
			<%}else if(str_report.equalsIgnoreCase("Update_App")){ %>
			<td align="center">&nbsp;<%=a%></td>
			<%} %>
			
			<td><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;&nbsp;&nbsp;
				<a onClick="javascript:callAppStatusPopUp('<%=Helper.correctNull((String)arrCol.get(0)) %>')"> <img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"> </a>&nbsp;&nbsp;
							<a href="#"
							onClick="javascript:callDocument('<%=Helper.correctNull((String)arrCol.get(0)) %>')"> <img
							src="<%=ApplicationParams.getAppUrl()%>/img/nsdl_docview.png"
							border="0"> </a>
			</td>
			<td><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</td>
			<td><%=Helper.correctNull((String)arrCol.get(2)) %>&nbsp;</td>
			<td><%=Helper.correctNull((String)arrCol.get(5)) %>&nbsp;</td>
			<td><%=Helper.correctNull((String)arrCol.get(6)) %>&nbsp;</td>
			<td><%=Helper.correctNull((String)arrCol.get(7)) %>&nbsp;</td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(4)) %>&nbsp;</td>
			<%if(str_report.equalsIgnoreCase("Update_App")){ %>
			<td><%=Helper.correctNull((String)arrCol.get(8)) %>&nbsp;</td>
			<td><%=Helper.correctNull((String)arrCol.get(9)) %>&nbsp;</td>
			<td><%=Helper.correctNull((String)arrCol.get(10)) %>&nbsp;</td>
			<%} %>
		</tr>
	<%}}else{ %>
	<%for(int i=0;i<3;i++){ %>
	<tr class="datagrid">
		<td align="center">&nbsp;</td>
		<td align="center">&nbsp;</td>
		<td align="center">&nbsp;</td>
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
	<tr class="datagrid">
		<td colspan="8" align="center">&nbsp;-- No Record Found --&nbsp;</td>
	</tr>
	<%} %>
	<%}} %>
	<%if(arrRow!=null && arrRow.size()>0 && str_report.equalsIgnoreCase("Realloc")){ %>
	<tr class="datagrid" align="center">
		<td colspan="5">
		<table width="80%" border="0" cellspacing="1" cellpadding="3" class="viewcolor">
			<tr  class="datagrid">
				<td>Select Organisation</td>
				<td>
				<table width="70%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td><input type="text" name="org_name" size="35" readonly
							value=""></td>
						<td id="org">
						<a href="#" onClick="showOrganizationSearch('<%=ApplicationParams.getAppUrl()%>','org_scode','org_name')"
					style="cursor: hand">
					<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" ></a>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
		<td colspan="6"><input type="button" value="Reallocate the Application" name="cmdReceive" onclick="doReallocate()" class="buttonStyle">&nbsp;</td>
	</tr>
	<%} %>
</table>
<br>
<table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr valign="middle">
		<td><input type="button" name="cmdclose" value="Close"
			class="buttonClose" onClick="callclose();"
></td>
	</tr>
</table>
<input type="hidden" name="hidRefId" value=""> 
<input type="hidden" name="org_code" value="">
<input type="hidden" name="org_scode" value="">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidBeanId" value=""> 
<input type="hidden" name="hidBeanMethod" value=""> 
<input type="hidden" name="hidSourceUrl" value="">
<input type="hidden" name="hidReallocationFlag" value="">
</form>
</body>
</html>
