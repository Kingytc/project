<%@include file="../share/directives.jsp"%>
<%
	String strAppid=Helper.correctNull(request.getParameter("hidcusgroupid"));
	ArrayList arrRow= new ArrayList();
	ArrayList arrCol=new ArrayList();
	
	if(hshValues!=null)
	{
		arrRow=(ArrayList)hshValues.get("arryRow");
	}
	int intRowSize = 0;
	if(arrRow != null && arrRow.size() > 0)
	{
		intRowSize = arrRow.size();
	}
	else
	{
		intRowSize = 0;
	}
	%>
<html>
<head>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function doSearch()
{
	var txtval=document.forms[0].bow_name.value;
	var txtlen=txtval.length;
	var rdovalue="";
	for(var i=0;i<document.forms[0].radiobutton.length;i++)
	{
		if(document.forms[0].radiobutton[i].checked==true)
		{
			rdovalue=document.forms[0].radiobutton[i].value;
		}
	}
	if(rdovalue==""||rdovalue==null)
	{
		alert("Please choose the Search Criteria");
		document.forms[0].bow_name.value="";
		return;
	}
    if(txtlen==0)
	{
		alert("Enter ID");
	    document.forms[0].bow_name.focus();
	    return;
	}
	document.forms[0].hidBeanGetMethod.value="getCusGroupApplicantIDHelp";
	document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].action=appURL+"action/cusgroup_applicantidhelp.jsp";
	document.forms[0].submit();
}
function selectApplicant(val1,val2,val3,val4,val5,val6,val7)
{
	if(val7=="Y")
	{
		alert("The Applicant already Attached to "+val5 +" group, So you cannot add this Applicant");
		return;
	}
	window.opener.document.forms[0].hidAppID.value=val1;
	window.opener.document.forms[0].hidAppName.value=val2;
	window.opener.document.forms[0].hidAppCBSID.value=val3;
	window.opener.document.forms[0].hidAppOLDID.value=val4;

	window.opener.document.forms[0].hidAction.value="add";
	window.opener.document.forms[0].hidBeanId.value="mastapplicant";
	window.opener.document.forms[0].hidBeanMethod.value="updateCusGroupMembersMgmt";
	window.opener.document.forms[0].hidBeanGetMethod.value="getCusGroupMembersMgmt";
	window.opener.document.forms[0].action=appURL+"controllerservlet";
	window.opener.document.forms[0].hidSourceUrl.value="/action/setcusgroupmem_mgt.jsp";
	window.opener.document.forms[0].submit();
	window.close();
}
function onRadioClick()
{
	document.forms[0].bow_name.readOnly=false;			
	document.forms[0].bow_name.value="";
	document.forms[0].bow_name.focus();
}
function enableSearch(myform)
{
	if(window.event && window.event.keyCode==13)
		doSearch();
	else
		return true;
}
function doClose()
{
	window.close();
}
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="cusgrouplisthelp" method="post" class="normal"><br>
<table width="80%" border="0" cellspacing="0" cellpadding="5"
	class="outertable" align="center">
	<tr>
		<td>
		<table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="1">
			<tr>
				<td>
				<table width="300" border="0" cellspacing="0" cellpadding="5"
					align="center" class="outertable">
					<tr class="datagrid">
						<td width="16%" nowrap="nowrap"><input type="radio"
							name="radiobutton" value="LAPSID" style="border-style: none"
							onClick="onRadioClick()"> LAPS Applicant ID</td>
						<td width="16%" nowrap="nowrap"><input type="radio"
							name="radiobutton" value="CBSID" style="border-style: none"
							onClick="onRadioClick()"> CBS Applicant ID</td>
						<td width="16%" nowrap="nowrap"><input type="radio"
							name="radiobutton" value="NAME" style="border-style: none"
							onClick="onRadioClick()"> Name</td>
						<td width="16%"><input type="text" name="bow_name"
							onKeypress="enableSearch(this.form)"></td>
						<td>&nbsp;&nbsp;&nbsp; <input type="button" name="Submit"
							value="Search" class="buttonStyle" onClick="doSearch();">
						</td>
					</tr>
					<tr class="dataheader">
						<td colspan="5">Select Applicant (Applicant - Applicant ID)</td>
					</tr>
					<%if(arrRow!=null && arrRow.size()>0){
					for(int i=0;i<arrRow.size();i++){
					arrCol=new ArrayList();
					arrCol=(ArrayList)arrRow.get(i);%>
					<tr>
						<td colspan="5"><a
							href="javascript:selectApplicant('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(1))%>','<%=Helper.correctNull((String)arrCol.get(2))%>','<%=Helper.correctNull((String)arrCol.get(3))%>','<%=Helper.correctNull((String)arrCol.get(4))%>','<%=Helper.correctNull((String)arrCol.get(5))%>','<%=Helper.correctNull((String)arrCol.get(6))%>')"
							class="blackfont"> <%=Helper.correctNull((String)arrCol.get(2))+" - "+Helper.correctNull((String)arrCol.get(1))%></a></td>
					</tr>
					<%}}else{%>
					<tr>
						<td colspan="5" align="center">- No Record Found - &nbsp;</td>
					</tr>
					<% }%>
					<tr>
						<td colspan="5">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="5">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="5">&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="hidid"> <input type="hidden" name="appid"
	value="<%=Helper.correctNull(request.getParameter("appid"))%>">
</form>
</body>
</html>
