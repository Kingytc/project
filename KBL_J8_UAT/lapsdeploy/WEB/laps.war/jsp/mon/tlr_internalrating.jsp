<%@include file="../share/directives.jsp"%>
<%
ArrayList arr = null;
ArrayList arrCol = new ArrayList();
int arrsize = 0;

if (hshValues != null) {
	arr = (ArrayList) hshValues.get("arrVal");
}

if (arr != null) {
	arrsize = arr.size();

}

String[] strprevious= new String[5];
String[] strcurrent= new String[5];

for(int i=0;i<strprevious.length;i++)
{
	strprevious[i]="";
	strcurrent[i]="";
}

if (arr != null) 
{
	for(int i =0;i<arr.size();i++)
	{	
		arrCol = (ArrayList) arr.get(i);
		
		strprevious[i] = Helper.correctNull((String)arrCol.get(0));
		strcurrent[i] = Helper.correctNull((String)arrCol.get(1));
	}	
}

%>
<html>
<head>
<title>Short Review Extension</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varslno="<%=Helper.correctNull((String)hshValues.get("rate_slno"))%>";
function placeValues()
{
	disableFields(true);
}

function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			else if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
		}
	}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="reviewtermloantwo"
		document.forms[0].hidBeanGetMethod.value="getInternalRatingData"
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/tlr_internalrating.jsp";
		document.forms[0].submit();
	 }
}
function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="reviewtermloantwo"
		document.forms[0].hidBeanMethod.value="updateInternalRatingData"
		document.forms[0].hidBeanGetMethod.value="getInternalRatingData"
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/tlr_internalrating.jsp";
 		document.forms[0].submit();
	 }
}
function callOtherLink(page,bean,method)
{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	
}
function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;

}
function doEdit()
{
		disableFields(false);
		enableButtons(true,true,false,false,false,true);
		document.forms[0].hidAction.value="edit";
}

function doSave()
{
	document.forms[0].hidBeanId.value="reviewtermloantwo"
	document.forms[0].hidBeanMethod.value="updateInternalRatingData"
	document.forms[0].hidBeanGetMethod.value="getInternalRatingData"
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/tlr_internalrating.jsp";
	document.forms[0].submit();
}

function doClose()
{
if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mon_borrowersearch.jsp?hidmontype=MONITREVIEW";
		document.forms[0].submit();
	}
	
}

function getValues()
{
		document.forms[0].hidBeanId.value="reviewtermloantwo"
		document.forms[0].hidBeanGetMethod.value="getInternalRatingData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/tlr_internalrating.jsp";
		document.forms[0].submit();
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="placeValues()">
<form name="otrmatters" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td><lapschoice:tlrtag pageid="14"
			reviewof='<%=Helper.correctNull((String)request.getParameter("reviewOf"))%>'
			valuesin='<%=Helper.correctNull((String)request.getParameter("valuesin"))%>' />
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>

		<td valign="top" colspan="5" class="page_flow">Home -&gt; Term Loan Review -&gt; Internal Credit Rating</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
			<tr>
				<td><lapschoice:MonitorReview /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<table width="80%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
<tr align="left">
   <td valign="top">
	<table width="78%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
	<tr>
		<td>&nbsp;</td>
		<td align="center"><b>PREVIOUS YEAR</b></td>
		<td align="center"><b>CURRENT YEAR</b></td>
	</tr>
	<tr align="center">
		<td align="left">Total score obtained</td>
		<td><input type="text" name="txt_lastyearscore" size="25" maxlength="6"
			onKeyPress="notAllowSplChar()" value="<%=Helper.correctNull((String)hshValues.get("tlr_prevyearscore"))%>"></td>
		<td><input type="text" name="txt_currentyearscore" size="25" maxlength="6"
			onKeyPress="notAllowSplChar()" value="<%=Helper.correctNull((String)hshValues.get("tlr_currentyearscore"))%>"></td>
	</tr>
	<tr align="center">
		<td align="left">Grade</td>
		<td><input type="text" name="txt_lastyeargrade" size="25" maxlength="15"
			onKeyPress="notAllowSplChar()" value="<%=Helper.correctNull((String)hshValues.get("tlr_prevyeargrade"))%>"></td>
		<td><input type="text" name="txt_currentyeargrade" size="25" maxlength="15"
			onKeyPress="notAllowSplChar()" value="<%=Helper.correctNull((String)hshValues.get("tlr_currentyeargrade"))%>"></td>
	</tr>
	<tr align="center">
		<td align="left">Risk definition</td>
		<td><input type="text" name="txt_lastyearrisk" size="25" maxlength="100"
			onKeyPress="notAllowSplChar()" value="<%=Helper.correctNull((String)hshValues.get("tlr_prevyearrisk"))%>">
		<td><input type="text" name="txt_currentyearrisk" size="25" maxlength="100"
			onKeyPress="notAllowSplChar()" value="<%=Helper.correctNull((String)hshValues.get("tlr_currentyearrisk"))%>"></td>
	</tr>
	<tr align="center">
		<td align="left" colspan="3"><b>PARAMETER</b></td>
	</tr>
	<tr align="center">
		<td align="left"><input type="hidden" name="txt_parameter"
			value="Borrower rating"> Borrower rating</td>
		<td><input type="text" name="txt_previous" size="25" maxlength="30"
			onKeyPress="notAllowSplChar()" value="<%=strprevious[0]%>"></td>
		<td><input type="text" name="txt_current" size="25" maxlength="30"
			onKeyPress="notAllowSplChar()" value="<%=strcurrent[0]%>"></td>
	</tr>
	<tr align="center">
		<td align="left"><input type="hidden" name="txt_parameter"
			value="Facility rating">Facility rating</td>
		<td><input type="text" name="txt_previous" size="25" maxlength="30"
			onKeyPress="notAllowSplChar()" value="<%=strprevious[1]%>"></td>
		<td><input type="text" name="txt_current" size="25" maxlength="30"
			onKeyPress="notAllowSplChar()" value="<%=strcurrent[1]%>"></td>
	</tr>
	<tr align="center">
		<td align="left"><input type="hidden" name="txt_parameter"
			value="Cash flow related parameters">Cash flow related parameters</td>
		<td><input type="text" name="txt_previous" size="25" maxlength="30"
			onKeyPress="notAllowSplChar()" value="<%=strprevious[2]%>"></td>
		<td><input type="text" name="txt_current" size="25" maxlength="30"
			onKeyPress="notAllowSplChar()" value="<%=strcurrent[2]%>"></td>
	</tr>
	<tr align="center">
		<td align="left"><input type="hidden" name="txt_parameter"
			value="Bussiness aspects"> Bussiness aspects</td>
		<td><input type="text" name="txt_previous" size="25" maxlength="30"
			onKeyPress="notAllowSplChar()" value="<%=strprevious[3]%>"></td>
		<td><input type="text" name="txt_current" size="25" maxlength="30"
			onKeyPress="notAllowSplChar()" value="<%=strcurrent[3]%>"></td>
	</tr>
	<tr align="center">
		<td align="left"><input type="hidden" name="txt_parameter"
			value="Total Marks with grade"> Total Marks with grade</td>
		<td><input type="text" name="txt_previous" size="25" maxlength="30"
			onKeyPress="notAllowSplChar()" value="<%=strprevious[4]%>"></td>
		<td><input type="text" name="txt_current" size="25" maxlength="30"
			onKeyPress="notAllowSplChar()" value="<%=strcurrent[4]%>"></td>
	</tr>
</table>
	</td>
   </tr>
</table><br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="reviewOf" value="<%=request.getParameter("reviewOf")%>">
</form>
</body>
</html>
