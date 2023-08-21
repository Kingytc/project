<%@include file="../share/directives.jsp"%>

<%
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();

	String strSSIType = Helper.correctNull((String) request
			.getParameter("hidSSIType"));
	String strCategoryType = Helper.correctNull((String) request
			.getParameter("hidCategoryType"));

	if (strCategoryType.equals("CORPORATE")) {
		strCategoryType = "CORP";
	}
	//out.println("--------------->"+hshValues);
%>

<html>
<head>
<title>Property Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";

function placevalues()
{
	disableCommandButtons("load");
}

function doNew()
{
	disableFields(false);
	disableCommandButtons("new");
	document.forms[0].hidAction.value ="insert";
	document.forms[0].txt_address.value ="";
	document.forms[0].txt_visitdate.value="";
	document.forms[0].txt_address.focus();	
}	
	

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
	document.forms[0].txt_address.focus();		
}

function doSave()
{
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidSourceUrl.value="/action/com_creditmortgageddetail.jsp";
		document.forms[0].hidBeanMethod.value="updateCreditMoragageDetails";
		document.forms[0].hidBeanGetMethod.value="getCreditMoragageDetails";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appURL+"action/com_creditmortgageddetail.jsp";
		document.forms[0].hidBeanGetMethod.value="getCreditMoragageDetails";
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].submit();
	}	
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value="Delete";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanMethod.value="updateCreditMoragageDetails";
	document.forms[0].hidBeanGetMethod.value="getCreditMoragageDetails";	
	document.forms[0].hidSourceUrl.value="/action/com_creditmortgageddetail.jsp";
	document.forms[0].submit();
	}
}

function doClose()
{
	if (ConfirmMsg(100))
	{
	window.close();
	}
}

function selectValues(val1, val2, val3, val4)
{
	document.forms[0].txt_CreditMoragageappno.value =val1;
    document.forms[0].hidsno.value =val2;
	document.forms[0].txt_address.value =val3;
	document.forms[0].txt_visitdate.value =val4;
	if(document.forms[0].readFlag.value.toUpperCase()=="W")
	{
	disableCommandButtons("radioselect");
	}
}

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdnew.disabled =false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
		document.forms[0].cmdedit.disabled=true;		 
	}
	if(val=="edit")
	{	 
		 document.forms[0].cmdnew.disabled =true;
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	if(val=="radioselect")
	{	 
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=false;
	}	  
	if(val=="disableall")
	{
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
	if(val=="new")
	{	 
		 document.forms[0].cmdnew.disabled =true;
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
}  
	
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=!val;
		}	 
	}
}

function clearfields()
{
	document.forms[0].txtname.value="";
	document.forms[0].txt_age.value="";
}

function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		 showCal(appURL,fname);
	}
}

function callLink(page,bean,method)
{
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}

function onloading()
{	  
	document.forms[0].hidAction.value ="";
	disableCommandButtons('load');
	disableFields(true);
}
function callLink(page,bean,method)
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
	
function show_CreditAuditProcess()
{


}

function doPrint()
{		
		
		
		var appno="<%=Helper.correctNull((String) request
									.getParameter("appno"))%>";
		var appname=document.forms[0].appname.value;
		var purl ="<%=ApplicationParams.getAppUrl()%>action/com_creditprocessauditprint.jsp?hidBeanGetMethod=getCreditProcessAudit&hidBeanId=commworkflow&appno="+appno+"&flag="+"Report"+"&app_name="+appname					
		var prop = 'scrollbars=yes,menubar=yes,width=750,height=520';	
		var xpos = (screen.width - 750) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);
}
</script>
</head>
<body onload="onloading()">
<form name="frmdocumentregister" method="post" class="normal"><br>

<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="2"
	class="outertable border1">
	<tr>
		<td width="60%" align="center">
		<table width="100%" border="0" cellspacing="3" cellpadding="3"
			class="outertable">
			<tr>
				<td class="sub_tab_inactive" align="center"><b><a
					href="javascript:callLink('com_creditprocessaudit.jsp','commworkflow','getCreditProcessAudit')"
					class="blackfont">Credit Process Audit</a></b></td>
				<td class="sub_tab_active" align="center"><b>Property
				Details</b></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			align="center" class="outertable">
			<tr>
				<td align="left" width="18%">Address of the Property</td>
				<td align="left" width="34%"><input type="text" tabindex="1"
					name="txt_address" maxlength="199" size="50"></td>
				<td align="left" width="18%">Date of visit</td>
				<td align="left" width="34%">
				<table width="55%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><input type="text" name="txt_visitdate" tabindex="5"
							size="12" maxlength="10" onBlur="checkDate(this);"> <a
							alt="Select date from calender" href="#"
							onClick="callCalender('txt_visitdate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="6"></a></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<lapschoice:combuttonnew btnnames="New_Edit_Save_Delete_Cancel_Print"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />

<table width="100%" border="0" cellspacing="1" cellpadding="0"
	class="outertable">
	<tr>
		<td>

		<table width="100%" border="0" cellspacing="1" cellpadding="2"
			class="outertable">
			<tr class="dataheader">
				<td width="3%" align="center"></td>
				<td width="87%" align="center"><b>Address of the Property </b></td>
				<td width="10%" align="center"><b>Date of visit</b></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="52">
		<div class="cellcontainer">

		<table width="100%" border="0" cellspacing="1" cellpadding="2"
			class="outertable">
			<%
				arrCol = new ArrayList();
				arrRow = (ArrayList) hshValues.get("arrRow");

				if (arrRow != null && arrRow.size() > 0) {
					for (int i = 0; i < arrRow.size(); i++) {
						arrCol = (ArrayList) arrRow.get(i);
			%>
			<tr class="datagrid">
				<td width="3%" align="center"><input type="radio"
					style="border: none" name="radiobutton" value="radiobutton"
					onClick="javascript:selectValues(
											    '<%=Helper.correctNull((String) arrCol.get(0))%>',
												'<%=Helper.correctNull((String) arrCol.get(1))%>',
												'<%=Helper.correctNull((String) arrCol.get(2))%>',
												'<%=Helper.correctNull((String) arrCol.get(3))%>'
												)">
				</td>

				<td width="87%" align="left">&nbsp;<%=Helper.correctNull((String) arrCol.get(2))%></td>
				<td width="10%" align="center">&nbsp;<%=Helper.correctNull((String) arrCol.get(3))%></td>
			</tr>
			<%
				}
				}
			%>
			<tr>
				<td width="3%" align="center">&nbsp;</td>
				<td width="87%" align="left">&nbsp;</td>
				<td width="10%" align="left">&nbsp;</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
</table>


<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="hidsno"> <input type="hidden"
	name="txt_CreditMoragageappno"
	value="<%=Helper.correctNull((String) hshValues
							.get("CreditMoragageDetails_appno"))%>"></form>
</body>
</html>
