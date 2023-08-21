<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<laps:handleerror />
<%ArrayList vecRow = (ArrayList) hshValues.get("vecRow");
			ArrayList vecCol = new ArrayList();
			java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			nf.setGroupingUsed(false);
%>

<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<style>
.td,tr{font-family: "MS Sans Serif";
	font-size: 11px;
	}


</style>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/link.css" type="text/css" />
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css" />
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>

<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdnew.disabled =false;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddel.disabled=true;
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdnew.disabled =true;
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddel.disabled=true;
		 document.forms[0].cmdapply.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	if(val=="radioselect")
	{	 
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddel.disabled=false;
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}	  
}
function selectValues(val1,val2,val3,val4,val5,i,size)
{
	document.forms[0].hid_strsno.value=val1;
	document.forms[0].txt_account_no.value=val2;
	document.forms[0].txt_document_name.value=val3;
	document.forms[0].txt_dateofdbc.value=val4;
	document.forms[0].txt_amount_dbc.value=val5;
	if(size==1)
	{
		document.forms[0].txt_remarks_dbc.value=document.forms[0].hidremarks.value;
	}
	else
	{
		document.forms[0].txt_remarks_dbc.value=document.forms[0].hidremarks[i].value;
	}
	
    disableCommandButtons("radioselect");
	
}
function doNew()
{
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");	
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidSourceUrl.value="/action/mon_dbcregister.jsp";
		document.forms[0].hidBeanId.value="Register";
		document.forms[0].hidBeanGetMethod.value="getDBC";
		document.forms[0].hidBeanMethod.value="updateDBC";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 		
	}	
	
	disableCommandButtons("load");
}

function doSave()
{
	if(document.forms[0].txt_account_no.value=="")
	{
		ShowAlert(121,'Account No');
		document.forms[0].txt_account_no.focus();
		return;
	}
		document.forms[0].hidSourceUrl.value="/action/mon_dbcregister.jsp";
		document.forms[0].hidBeanId.value="Register";
		document.forms[0].hidBeanMethod.value="updateDBC";
		document.forms[0].hidBeanGetMethod.value="getDBC";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/mon_dbcregister.jsp";
		document.forms[0].hidBeanId.value="Register";
		document.forms[0].hidBeanMethod.value="updateDBC";
		document.forms[0].hidBeanGetMethod.value="getDBC";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}		  
		 
	}
	document.forms[0].txt_dateofdbc.readOnly=true;
	
	
}
function onLoading()
{
		
		disableCommandButtons("load");
}
function doClose()
	{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/mainnav.jsp";
		document.forms[0].submit();
		
	}
}	
function callCalender(name)
{
	if(document.forms[0].cmdapply.disabled==false)
	{
		showCal(appUrl,name);
		
	}
}

function callLink(page,bean,method)
		{
		
		 if (document.forms[0].cmdapply.disabled)
			{
				document.forms[0].hidSourceUrl.value=page;
				document.forms[0].hidBeanGetMethod.value=method;
				document.forms[0].hidBeanId.value=bean;
				document.forms[0].action=appUrl+"action/"+page;
				document.forms[0].submit();
			}
		else
			{
				ShowAlert(103);
			}
		}
		
		
		
</script>

</head>
<body text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0" font-family="arial" font-size="11px"
	onload="onLoading()">
<form name="safaeri2" method="post">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
				<tr>
					<td>
						<laps:monitortag pageid="3"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>

		<td valign="top" colspan=5><b><i><font
			face="Times New Roman, Times, serif" size="3">Home -&gt;
		Monitoring-&gt; DBC Register</font></i></b></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="1" cellpadding="3">
	<tr>

		<td colspan="4" align="center"><b>DBC Register</b></td>
	</tr>
	<tr>

		<td>Account No.</td>
		<td><input type="text" name="txt_account_no" size="25" maxlength="16"
			value=""></td>

		<td>Document Name</td>

		<td width="4%"><font size="1" face="MS Sans Serif"></font></td>
		<td><input type="text" name="txt_document_name" size="50"
			style="text-align:left" maxlength="40" value=""></td>

	</tr>
	<tr>

		<td>Date of DBC</td>

		<td><input type="text" name="txt_dateofdbc" size="12" maxlength="25"
			value="" onBlur="checkDate(this)"> <a href="#" onClick="callCalender('txt_dateofdbc')"
			title="Click to view calender" border=0><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			border="0" tabindex="23"></a></td>


		<td>Amount of DBC</td>
		<td><font size="1" face="MS Sans Serif"><b><%=ApplicationParams.getCurrency()%></b></font></td>
		<td><lapschoice:CurrencyTag name="txt_amount_dbc" maxlength="12" value=''/></td>
	</tr>
	<tr>

		<td>Remarks</td>
		<td><textarea rows="2" name="txt_remarks_dbc" cols="50"
			onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>
<table border="0" cellspacing="0" cellpadding="0"
	class="outertable border1"
	align="center">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="2" align="center">
			<tr valign="top">
				<td><input type="button" name="cmdnew" value="New"
					class="buttonStyle"
					onClick="doNew()"></td>
				<td><input type="button" name="cmdedit" value="Edit"
					class="buttonStyle"
					onClick="doEdit()"></td>
				<td><input type="button" name="cmdapply" value="Save"
					class="buttonStyle"
					onClick="doSave()"></td>
				<td><input type="button" name="cmdcancel" value="Cancel"
					class="buttonStyle"
					onClick="doCancel()"></td>
				<td><input type="button" name="cmddel" value="Delete"
					class="buttonStyle"
					onClick="doDelete()"></td>
				<td><input type="button" name="cmdhelp" value="Help"
					class="buttonHelp"
					onClick="dohlpp()"></td>
				<td align="center"><input type="button" name="cmdclose"
					value="Close" onClick="doClose()"
					class="buttonClose">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<tr align="center">
	<td colspan="2">
	<div class="cellContainer">
	<table width="100%" border="1" cellspacing="0" cellpadding="0"
		bgcolor="#DEDACF" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
		align="center">
		<tr>
			<td valign="top">
			<div align="left">
			<table width="98.3%" border="1" cellspacing="0" cellpadding="0">
				<tr>
					<td width="4%" class="tabactivenew">&nbsp;</td>
					<td width="16%" class="tabactivenew" align="center"><b>Account No.</b></td>
					<td width="16%" class="tabactivenew" align="center"><b>Document Name</b></td>
					<td width="16%" class="tabactivenew" align="center"><b>Date of DBC</b></td>
					<td width="16%" class="tabactivenew" align="center"><b>Amount of DBC</b></td>
					<td width="30%"  class="tabactivenew" align="center"><b>Remarks</b></td>
				</tr>
				</table>
				<div style="overflow-y:scroll;height:150px;">
				<table width="100%" border="1" cellspacing="0" cellpadding="0">
				<%vecRow = (ArrayList) hshValues.get("vecRow");
			if (vecRow.size() > 0 && vecRow != null) {
				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);

					%>
				<tr>
					<td width="4%" align=center><font size="1" face="MS Sans Serif"> <input
						type="radio" style="border:none" name="radiobutton"
						value="radiobutton"
						onClick="selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
													'<%=Helper.correctNull((String)vecCol.get(1))%>','<%=Helper.correctNull((String)vecCol.get(2))%>',
													'<%=Helper.correctNull((String)vecCol.get(3))%>','<%=Helper.correctNull((String)vecCol.get(4))%>',
                            	'<%=i%>','<%=vecRow.size()%>')">
                            	<input type="hidden" name="hidremarks" value="<%=Helper.correctNull((String)vecCol.get(5))%>">
					</font></td>
					<td width="16%">&nbsp;<%=Helper.correctNull((String) vecCol.get(1))%></td>
					<td width="16%">&nbsp;<%=Helper.correctNull((String) vecCol.get(2))%></td>
					<td width="16%">&nbsp;<%=Helper.correctNull((String) vecCol.get(3))%></td>
					<td width="16%" align="right">&nbsp;<%=Helper.correctNull((String) vecCol.get(4))%></td>
					<td width="30%"><%=Helper.correctNull((String) vecCol.get(5))%></td>
				</tr>
				<%}
			} else {

			%>
				<tr>
					<td align center colspan="10"><font size="1" face="MS Sans Serif">No
					Data Found</font></td>
				</tr>
				<%}

			%>
			</table>
			</div>
			</div>
			</td>
		</tr>
	</table>
	</div>
	</td>
</tr>
<input type="hidden" name="borrowername"
	value="<%=Helper.correctNull((String)request.getParameter("borrowername"))%>">
<input type="hidden" name="hidborrowertype"
	value="<%=Helper.correctNull((String)request.getParameter("hidborrowertype"))%>">
<input type="hidden" name="hidAction" /> 
<input type="hidden" name="hidBeanId" /> 
<input type="hidden" name="hidBeanMethod" value="" />
<input type="hidden" name="hidBeanGetMethod" value="" /> 
<input type="hidden" name="hidSourceUrl" /> 
 <input	type="hidden" name="comapp_id"
	value="<%=(String)request.getParameter("comapp_id")%>">
	<input type="hidden" name="hid_strsno" value="<%=Helper.correctNull((String)hshValues.get("dbc_sno"))%>"/>

</form>
</body>
</html>
