<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%ArrayList arrRow=null;
ArrayList arrCol=new ArrayList();
java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
nf.setMinimumFractionDigits(2);
nf.setMaximumFractionDigits(2);
nf.setGroupingUsed(false);%>
<html>
<head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function disabledButton(val)
{
	if(val=="load")
	{
		document.forms[0].cmdnew.disabled=false;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
		
	}
	if(val=="edit")
	{
		document.forms[0].cmdnew.disabled=true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=false;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=false;
	}
	if(val=="radio")
	{
		document.forms[0].cmdnew.disabled=true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=false;
	}
}
function doSave()
{

if(trim(document.forms[0].minpoint_scored.value)=="" )
	{
	alert("Enter Minimum Points Scored");
 		document.forms[0].minpoint_scored.focus();
 		return;
	}

if(trim(document.forms[0].maxpoint_scored.value)=="" )
	{
	alert("Enter Maximum Points Scored");
 		document.forms[0].maxpoint_scored.focus();
 		return;
	}
	if(eval(document.forms[0].minpoint_scored.value)>eval(document.forms[0].maxpoint_scored.value))
	{
		ShowAlert(115,"Maximum  Points Scored","Minimum  Points Scored");
		document.forms[0].minpoint_scored.value="";
		document.forms[0].maxpoint_scored.focus();
		return;
	}
	
	if(trim(document.forms[0].min_runledger.value)=="")
	{
	alert("Enter Minimum O/S R.L ");
 		document.forms[0].min_runledger.focus();
 		return;
	}
		if(trim(document.forms[0].max_runledger.value)=="")
	{
	alert("Enter Maximum O/S R.L");
 		document.forms[0].max_runledger.focus();
 		return;
	}
	if(eval(document.forms[0].min_runledger.value)>eval(document.forms[0].max_runledger.value))
	{
		ShowAlert(115,"Maximum O/S R.L (%)","Minimum O/S R.L (%)");
		document.forms[0].minpoint_scored.value="";
		document.forms[0].maxpoint_scored.focus();
		return;
	}
		
	if(trim(document.forms[0].rate_interest.value)=="")
	{
	alert("Enter Rate of Applicable Interest");
 		document.forms[0].rate_interest.focus();
 		return;
	}
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidBeanId.value="npasetup";
	document.forms[0].hidBeanMethod.value="updateMethodology";
	document.forms[0].hidBeanGetMethod.value="getMethodology";
	document.forms[0].hidSourceUrl.value="action/npamethodology.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
if(ConfirmMsg(101))
		{
	document.forms[0].hidBeanId.value="npasetup";
	document.forms[0].hidAction.value="delete";
	document.forms[0].hidBeanMethod.value="updateMethodology";
	document.forms[0].hidBeanGetMethod.value="getMethodology";
	document.forms[0].hidSourceUrl.value="action/npamethodology.jsp";
	//document.forms[0].action=appUrl+"action/npamethodology.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
	}
	
}
function doCancel()
{

if(ConfirmMsg(102))
	{
	document.forms[0].hidAction.value="";
	document.forms[0].hidBeanId.value="npasetup";
	document.forms[0].hidBeanGetMethod.value="getMethodology";
	//document.forms[0].hidSourceUrl.value="action/npamethodology.jsp";
	document.forms[0].action=appUrl+"action/npamethodology.jsp";
	document.forms[0].submit();
	}
}
function call_page(url)
{
	document.location=appUrl+"action/"+url;
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}
function doNew()
{
	document.forms[0].hidAction.value="insert";
	disabledButton("edit");
	disabledFields(false);
}
function doEdit()
{
	document.forms[0].hidAction.value="update";
	disabledButton("edit");
	disabledFields(false);
}	
function disabledFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=val;
		}
	}
}
function onLoading()
{
	disabledButton("load");
	disabledFields(true);
}
function selectValues(val1,val2,val3,val4,val5,val6)
{
	document.forms[0].hidsno.value=val1;
	document.forms[0].minpoint_scored.value=val2;
	document.forms[0].maxpoint_scored.value=val3;
	document.forms[0].min_runledger.value=val4;
	document.forms[0].max_runledger.value=val5;
	document.forms[0].rate_interest.value=val6;
	
	disabledButton("radio");
}
</script>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body onload="onLoading()">
	<form action="" name="ageform" class="normal">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>		
      <td class="page_flow">Home -&gt; Setup -&gt; NPA -&gt; Methodology</td>
	</tr>
</table>
<table width="50%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
	<tr>
		<td>
  <table align="center" width="100%" border="0" cellspacing="3" cellpadding="3" class="outertable">
    <tr class="dataheader"> 
      <td colspan="2" align="center"><b>Methodologies</b></td>
    </tr>
    <tr> 
      <td> 
        <div align="left">Minimum Points Scored</div>
      </td>
      <td>&nbsp; 
        <input type="text" name="minpoint_scored" value="" onKeyPress="allowInteger()" maxlength="3" size="8">
      </td>
    </tr>
    <tr> 
      <td>Maximum Points Scored</td>
      <td>&nbsp; 
        <input type="text" name="maxpoint_scored" value="" onKeyPress="allowInteger()"  maxlength="3" size="8">
      </td>
    </tr>
    <tr> 
      <td>Minimum O/S R.L (%)</td>
      <td>&nbsp; 
        <input type="text" name="min_runledger" value="" onKeyPress="allowInteger()" onBlur="checkPercentage(this);" maxlength="3" size="8">
      </td>
    </tr>
    <tr> 
      <td>Maximum O/S R.L (%) </td>
      <td>&nbsp;
        <input type="text" name="max_runledger" value="" onKeyPress="allowInteger()"  onBlur="checkPercentage(this);" maxlength="3" size="8">
      </td>
    </tr>
    <tr>
      <td>&nbsp;Rate of Applicable Interest</td>
      <td>&nbsp;
        <input type="text" name="rate_interest" value="" onKeyPress="allowInteger();" onBlur="checkPercentage(this);" maxlength="5" size="8">
      </td>
    </tr>
  </table>
  </td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
		<tr >
			<td valign="top">
			<table width="64%" border="0" cellspacing="0" align="center" cellpadding="3" class="outertable linebor">
				<tr class="dataheader">
					<td>&nbsp;</td>
					<td  align="center"><b>Minimum Points Scored</b></td>
					<td align="center"><b>Maxium Points Scored</b></td>
					<td  align="center"><b> Minimum O/S R.L (%)</b></td>
					<td   align="center"><b> Maximum O/S R.L (%)</b></td>
					<td   align="center"><b> Rate of Applicable Interest</b></td>
				</tr>
				<%	arrRow=(ArrayList)hshValues.get("arrRow");
				if (arrRow.size() > 0 && arrRow != null) {
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);

					%>
				<tr class="datagrid">
					<td width="4%" align=center> <input
						type="radio" style="border:none" name="radiobutton"
						value="radiobutton"
						onClick="selectValues('<%=Helper.correctNull((String)arrCol.get(0))%>',
													'<%=Helper.correctNull((String)arrCol.get(1))%>','<%=Helper.correctNull((String)arrCol.get(2))%>'
                            	,'<%=Helper.correctNull((String)arrCol.get(3))%>','<%=Helper.correctNull((String)arrCol.get(4))%>','<%=Helper.correctNull((String)arrCol.get(5))%>')">
					</td>
					<td width="12%">&nbsp;<%=Helper.correctNull((String) arrCol.get(1))%></td>
					<td width="12%">&nbsp;<%=Helper.correctNull((String) arrCol.get(2))%></td>
					<td width="12%" align="right">&nbsp;<%=Helper.correctNull((String) arrCol.get(3))%></td>
					<td width="12%" align="right">&nbsp;<%=Helper.correctNull((String) arrCol.get(4))%></td>
					<td width="12%" align="right">&nbsp;<%=Helper.correctNull((String) arrCol.get(5))%></td>
				</tr>
				<%}} else {%>
				<tr align="center" class="datagrid">
					<td  colspan="6">No Data Found</td>
				</tr>
				<%}%>
			</table>
			</td>
		</tr>
	</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type=hidden name="hidsno" value="<%=Helper.correctNull((String)hshValues.get("npamethod_sno")) %>">
<input type ="hidden" name ="hidkeyid" value="set">
</form>
</body>
</html>
