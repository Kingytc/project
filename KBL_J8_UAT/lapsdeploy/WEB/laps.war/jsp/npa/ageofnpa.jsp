<%@include file="../share/directives.jsp"%>
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
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
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
	if(trim(document.forms[0].minage_npa.value)=="" )
	{
		alert("Enter Minimum Age of NPA");
		document.forms[0].minage_npa.focus();
		return;
	}

if(trim(document.forms[0].maxage_npa.value)=="" )
	{
	alert("Enter Maximum Age of NPA");
 		document.forms[0].maxage_npa.focus();
 		return;
	}
	
	if(trim(document.forms[0].points_npa.value)=="")
	{
	alert("Enter Points of NPA");
 		document.forms[0].points_npa.focus();
 		return;
	}

	if(eval(document.forms[0].minage_npa.value)>eval(document.forms[0].maxage_npa.value))
	{
		ShowAlert(115,"Maximum Age of NPA","Minimum Age of NPA");
		document.forms[0].minage_npa.value="";
		document.forms[0].maxage_npa.focus();
		return;
	}
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidBeanId.value="npasetup";
	document.forms[0].hidBeanMethod.value="updateAgeofNpa";
	document.forms[0].hidBeanGetMethod.value="getAgeofNpa";
	document.forms[0].hidSourceUrl.value="action/ageofnpa.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if (ConfirmMsg("101"))
		{
			document.forms[0].hidBeanId.value="npasetup";
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanMethod.value="updateAgeofNpa";
			document.forms[0].hidBeanGetMethod.value="getAgeofNpa";
			document.forms[0].hidSourceUrl.value="action/ageofnpa.jsp";
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert(158);
	}
}
function doCancel()
{
if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value="";	
	document.forms[0].hidBeanId.value="npasetup";
	document.forms[0].hidBeanGetMethod.value="getAgeofNpa";
	//document.forms[0].hidSourceUrl.value="action/ageofnpa.jsp";
	document.forms[0].action=appUrl+"action/ageofnpa.jsp";
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
function selectValues(val1,val2,val3,val4)
{
	document.forms[0].hidsno.value=val1;
	document.forms[0].minage_npa.value=val2;
	document.forms[0].maxage_npa.value=val3;
	document.forms[0].points_npa.value=val4;
	
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
		<td class="page_flow">Home -&gt; Setup -&gt; Age of NPA</td>
	</tr>
</table>
<table width="60%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable border1">
	<tr>
		<td>
<table align="center" width="100%" border="0" cellspacing="3" cellpadding="3"  class="outertable">

	<tr class="dataheader">
		<td colspan="2" align="center"><b>Age of NPA</b></td>
	</tr>
	<tr>
		<td> Minimum Age of NPA<b><span class="mantatory">*&nbsp;</span></b></td>
		<td>&nbsp; <input type="text" name="minage_npa" value="" onBlur="allowInteger();"; maxlength="3" size="8"></td>
	</tr>

	<tr>
		<td>Maximum Age of NPA<b><span class="mantatory">*&nbsp;</span></b></td>
		<td>&nbsp; <input type="text" name="maxage_npa" value="" onBlur="allowInteger();"  maxlength="3" size="8"></td>
	</tr>

	<tr>
		<td >Points of NPA<b><span class="mantatory">*&nbsp;</span></b></td>
		<td>&nbsp; <input type="text" name="points_npa" value="" onBlur="allowInteger();"  maxlength="3" size="8"></td>
	</tr>
</table>
</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
		<tr>
			<td valign="top">
			
			<table width="58%" border="0" cellspacing="0" align="center" cellpadding="3" class="outertable linebor">
				<tr  class="dataheader">
					<td width="4%">&nbsp;</td>
					<td width="18%" align="center"><b>Minimum Age of NPA</b></td>
					<td width="18%" align="center"><b>Maximum Age of NPA</b></td>
					<td width="18%" align="center"><b> Points of NPA</b></td>
				</tr>
				<%	arrRow=(ArrayList)hshValues.get("arrRow");
				if (arrRow != null && arrRow.size() > 0) {
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);%>
				<tr  class="datagrid">
					<td width="4%" align=center><input
						type="radio" style="border:none" name="radiobutton"
						value="radiobutton"
						onClick="selectValues('<%=Helper.correctNull((String)arrCol.get(0))%>',
													'<%=Helper.correctNull((String)arrCol.get(1))%>','<%=Helper.correctNull((String)arrCol.get(2))%>'
                            	,'<%=Helper.correctNull((String)arrCol.get(3))%>')">
					</td>
					<td width="18%">&nbsp;<%=Helper.correctNull((String) arrCol.get(1))%></td>
					<td width="18%">&nbsp;<%=Helper.correctNull((String) arrCol.get(2))%></td>
					<td width="18%" align="right">&nbsp;<%=Helper.correctNull((String) arrCol.get(3))%></td>
				</tr>
				<%}} else {%>
				<tr align="center" class="datagrid">
					<td colspan="6">No Data Found</td>
				</tr>
				<%}%>
			</table>			
			</td>
		</tr>
	</table>
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type=hidden name="hidsno" value="<%=Helper.correctNull((String)hshValues.get("npa_sno")) %>">
<input type ="hidden" name ="hidkeyid" value="set">
</form>
</body>
</html>
