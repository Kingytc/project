<%@ page import="com.sai.laps.helper.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<lapschoice:handleerror />

<%		String strCategoryType = Helper.correctNull((String) request
					.getParameter("hidtype"));

			String strCons_Owner = Helper.correctNull((String) request
					.getParameter("hidCostitution"));

			if (strCategoryType == "") {
				strCategoryType = Helper.correctNull((String) hshValues
						.get("strCategoryType"));
			}
			java.text.NumberFormat nf = java.text.NumberFormat
					.getNumberInstance();
			nf.setGroupingUsed(false);
			nf.setMinimumFractionDigits(2);
			nf.setMaximumFractionDigits(2);

			String[] strtermName = new String[5];
			String[] strtermType = new String[5];
			String[] strnoInst = new String[5];
			String[] strInsamount = new String[5];
			String[] strstartDate = new String[5];

			strtermName = (String[]) hshValues.get("fil_term_name");
			strtermType = (String[]) hshValues.get("fil_sel_termtype");
			strnoInst = (String[]) hshValues.get("fil_no_instalments");
			strInsamount = (String[]) hshValues.get("fil_ins_amounts");
			strstartDate = (String[]) hshValues.get("fil_start_date");
			

			String[] strlastinsDate = new String[5];
			String[] strDisbursedate = new String[5];
			String[] strreceivedIns = new String[5];
			String[] strAmountIns = new String[5];
			String[] strLasrecDate = new String[5];
			String[] strpaymentDate = new String[5];

			strlastinsDate = (String[]) hshValues.get("fil_last_date");
			strDisbursedate = (String[]) hshValues.get("fil_disburse_date");
			strreceivedIns = (String[]) hshValues
					.get("fil_regnamenoinstalment_rec");
			strAmountIns = (String[]) hshValues.get("fil_amount_insreceived");
			strLasrecDate = (String[]) hshValues.get("fil_instale_date");
			strpaymentDate = (String[]) hshValues.get("fil_payment_date");

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

var fil_sel_enforce="<%=Helper.correctNull((String)hshValues.get("fil_sel_enforce"))%>";

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddel.disabled=true;
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	 
	}
	
	if(val=="edit")
	{	 
		document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddel.disabled=false;
		 document.forms[0].cmdapply.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	
		 disableFields(false);
	}
}

function clearValues()
{
	
	if(fil_sel_enforce=="n")
	for( i=0;i<=4;i++)		
	{	
		   document.forms[0].txt_term_name[i].value="";
			document.forms[0].sel_termtype[i].value="1";
			document.forms[0].txt_no_instalments[i].value="";
			document.forms[0].txt_ins_amount[i].value="";
			document.forms[0].txt_start_date[i].value="";
			
			document.forms[0].txt_last_date[i].value="";
			document.forms[0].txt_disburse_date[i].value="";
			document.forms[0].txt_noinstalment_rec[i].value="";
			document.forms[0].txt_amount_insreceived[i].value="";
			document.forms[0].txt_instale_date[i].value="";
			document.forms[0].txt_payment_date[i].value="";
		
	}
	
}

function onLoading()
{
	disableCommandButtons("load");
	
	if(fil_sel_enforce=="y")
	{
	
	  document.forms[0].sel_enforce.value=fil_sel_enforce;	
	
	  document.all.a1.style.visibility="visible";	
	   document.all.a2.style.visibility="visible";	
	}
	else
	{
	 
		document.forms[0].sel_enforce.value='n'	
		document.all.a1.style.visibility="hidden";
		document.all.a2.style.visibility="hidden";
	}
	
	<%for(int b=0;b<5;b++)
	{
		strtermName[b]=Helper.correctNull((String)strtermName[b]);
		strtermType[b]=Helper.correctNull((String)strtermType[b]);
		strnoInst[b]=Helper.correctNull((String)strnoInst[b]);
		strInsamount[b]=Helper.correctDouble((String)strInsamount[b]);
		strstartDate[b]=Helper.correctNull((String)strstartDate[b]);
		
		if(!strtermName[b].equalsIgnoreCase(""))
		{
		%>
			var strtermName="<%=strtermName[b]%>";
			var strtermType="<%=strtermType[b]%>";
			var strnoInst="<%=strnoInst[b]%>";
			var strInsamount="<%=Helper.formatDoubleValue(Double.parseDouble(strInsamount[b]))%>";
			var strstartDate="<%=strstartDate[b]%>";
			var sel="<%=b%>";
			
			document.forms[0].txt_term_name[sel].value=strtermName;
			document.forms[0].sel_termtype[sel].value=strtermType;
			document.forms[0].txt_no_instalments[sel].value=strnoInst;
			document.forms[0].txt_ins_amount[sel].value=strInsamount;
			document.forms[0].txt_start_date[sel].value=strstartDate;
		<%}
	}%>
	
	<%for(int d=0;d<5;d++)
	{
		strlastinsDate[d]=Helper.correctNull((String)strlastinsDate[d]);
		strDisbursedate[d]=Helper.correctNull((String)strDisbursedate[d]);
		strreceivedIns[d]=Helper.correctNull((String)strreceivedIns[d]);
		strAmountIns[d]=Helper.correctDouble((String)strAmountIns[d]);
		strLasrecDate[d]=Helper.correctNull((String)strLasrecDate[d]);
		strpaymentDate[d]=Helper.correctNull((String)strpaymentDate[d]);

		if(!strlastinsDate[d].equalsIgnoreCase(""))
		{
		%>
			var strlastinsDate="<%=strlastinsDate[d]%>";
			var strDisbursedate="<%=strDisbursedate[d]%>";
			var strreceivedIns="<%=strreceivedIns[d]%>";
			var strAmountIns="<%=Helper.formatDoubleValue(Double.parseDouble(strAmountIns[d]))%>";
			var strLasrecDate="<%=strLasrecDate[d]%>";
			var strpaymentDate="<%=strpaymentDate[d]%>";
			var sel1="<%=d%>";
			
			document.forms[0].txt_last_date[sel1].value=strlastinsDate;
			document.forms[0].txt_disburse_date[sel1].value=strDisbursedate;
			document.forms[0].txt_noinstalment_rec[sel1].value=strreceivedIns;
			document.forms[0].txt_amount_insreceived[sel1].value=strAmountIns;
			document.forms[0].txt_instale_date[sel1].value=strLasrecDate;
			document.forms[0].txt_payment_date[sel1].value=strpaymentDate;
		<%}
	}%>
	
	selCredit();
	clearValues();
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
	    document.forms[0].hidSourceUrl.value="/action/34PointsFormat_page3.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanGetMethod.value="get34pointspage3Data";
		document.forms[0].hidBeanMethod.value="get34pointspage3Data";
		document.forms[0].action=appUrl +"controllerservlet"; 
		document.forms[0].submit(); 		
	}	
	
	disableCommandButtons("load");
}

function doSave()
	{
	document.forms[0].hidSourceUrl.value="/action/34PointsFormat_page3.jsp";
	document.forms[0].hidBeanId.value="npa";
	document.forms[0].hidBeanMethod.value="update34pointspage3Data";
	document.forms[0].hidBeanGetMethod.value="get34pointspage3Data";
	document.forms[0].action=appUrl+"controllerservlet"; 
	document.forms[0].submit();
	}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	
		if(document.forms[0].elements[i].type=='select-one' )
		  {
 				document.forms[0].elements[i].disabled=val;
		  }  
		   if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}  
		 
	}
	for(var i=0;i<5;i++)
	{
	document.forms[0].txt_start_date[i].readOnly=true;
	document.forms[0].txt_last_date[i].readOnly=true;
	document.forms[0].txt_disburse_date[i].readOnly=true;
	document.forms[0].txt_instale_date[i].readOnly=true;
	document.forms[0].txt_payment_date[i].readOnly=true;
	}
}
function doClose()
	{
	if(ConfirmMsg('100'))
		{
		document.forms[0].method="post";	
		document.forms[0].action=appUrl+"action/"+"mainnav.jsp";
		document.forms[0].submit();
		}
	}
	
function doDelete()
{
if(ConfirmMsg(101))
		{	
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidSourceUrl.value="/action/34PointsFormat_page3.jsp";
			document.forms[0].hidBeanId.value="npa";
			document.forms[0].hidBeanMethod.value="update34pointspage3Data";
			document.forms[0].hidBeanGetMethod.value="get34pointspage3Data";
			document.forms[0].action=appUrl +"controllerservlet";
			document.forms[0].submit(); 
		}


}	

function callLink(page,bean,method)
{
  if (document.forms[0].cmdapply.disabled)
	{
		document.forms[0].hidSourceUrl.value=page;
		//alert(document.forms[0].hidSourceUrl);
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].hidmoduletype.value="SUIT";
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
		
		 }
	else
	{
		ShowAlert(103);
	}
		}
function callCalender(name)
{
	if(document.forms[0].cmdapply.disabled==false)
	{
		showCal(appUrl,name);
		
	}
}
function selCredit()
{
	if(document.forms[0].sel_enforce.value=="y")
	{
		document.all.a1.style.visibility="visible";
		document.all.a1.style.position="relative";
		document.all.a2.style.visibility="visible";
		document.all.a2.style.position="relative";
	}
	else
	{
		document.all.a1.style.visibility="hidden";
		//document.forms[0].txt_security.value="";
		document.all.a1.style.position="absolute";
		document.all.a2.style.visibility="hidden";
		document.all.a2.style.position="absolute";
	}
}


</script>
</head>
<body text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0" font-family="arial" font-size="11px"
	onload="onLoading()">
<form name="34pointsFormatpage3" method="post">

<table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
				<tr>
					<td>
						<lapstab:suiturltag pageid="3"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><lapschoice:npaapplication />
		<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />
		</td>
	</tr>
</table>
<table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="2">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			align="center">
			<tr>
				<td>
				<table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="5">
					<tr>
						<td WIDTH="53%">15.Whether credit facility (ies) were subsequently
						renewed and / or enhanced. If so, <br>
						give detailed particulars thereof as follows: -<br>
						<br>
						</td>
						<td WIDTH="47%"><select name="sel_enforce"
							onChange="selCredit();">
							<option value="y">Yes</option>
							<option value="n">No</option>
						</select></td>
					</tr>
					<tr>
						<td colspan="3" id="a1">
						<table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="5">
							<tr>
								<td colspan="5">Details of colletral security</td>
							</tr>
							<tr align="center">
								<td width="20%">Name of term loan</td>
								<td width="20%">Type of term loan</td>
								<td width="20%">No of instalments</td>
								<td width="20%">Instalment amount</td>
								<td width="20%">Start Date</td>
							</tr>
							<%for (int i = 0; i < 5; i++) {

				if (strtermName[i] != null && strtermName[i] != "") {
					//System.out.println("==-=-=-=-=-=-0=-=" + strtermName[i]);

					%>
							<tr>
								
                        <td width="20%" height="41">
<input type="text" name="txt_term_name"
									size="35" maxlength="50"
									value="<%//=Helper.correctNull(location[i])%>"></td>
								
                        <td width="20%" height="41"> 
                          <select name="sel_termtype" tabindex="5">
                            <option value="1" selected>select</option>
                            <option value="2">Short Term</option>
                            <option value="3">medium Term</option>
                            <option value="4">Long Term</option>
                          </select>
                        </td>
                        <td width="20%" height="41">
<input type="text" name="txt_no_instalments"
									onKeyPress="allowInteger()" size="35" maxlength="4"
									value="<%//=Helper.correctNull(owner[i])%>"></td>
								
                        <td width="20%" height="41">
<input type="text" name="txt_ins_amount"
									onKeyPress="allowInteger()" size="35" maxlength="9" style="text-align:right"
									value="<%//=Helper.correctNull(owner[i])%>"></td>
								
                        <td width="20%" height="41">
<input type="text" name="txt_start_date"
									size="15" maxlength="25"
									value="<%//=Helper.correctNull(date[i])%>"> <a href="#" onClick="callCalender('txt_start_date[<%=i%>]')"
							TITLE="Click to view calender" BORDER=0><IMG
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							BORDER="0" TABINDEX="23"></a></td>
							</tr>
							<%}

				else {%>
							<tr>
								<td width="20%"><input type="text" name="txt_term_name"
									size="35" maxlength="50"
									value="<%//=Helper.correctNull(location[i])%>""></td>
								<td width="20%"><SELECT NAME="sel_termtype" TABINDEX="5"
									ONCHANGE="">
									<OPTION VALUE="1">select</OPTION>
									<OPTION VALUE="2">Short Term</OPTION>
									<OPTION VALUE="3">medium Term</OPTION>
									<OPTION VALUE="4">Long Term</OPTION>
								</SELECT></td>
								<td width="20%"><input type="text" name="txt_no_instalments"
									onKeyPress="allowInteger()" size="35" maxlength="4"
									value="<%//=Helper.correctNull(owner[i])%>""></td>
								<td width="20%"><input type="text" name="txt_ins_amount" style="text-align:right"
									onKeyPress="allowInteger()" size="35" maxlength="9"
									value="<%//=Helper.correctNull(owner[i])%>"></td>
								<td width="20%"><input type="text" name="txt_start_date"
									size="15" maxlength="25"
									value="<%//=Helper.correctNull(date[i])%>"> <a href="#" onClick="callCalender('txt_start_date[<%=i%>]')"
							TITLE="Click to view calender" BORDER=0><IMG
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							BORDER="0" TABINDEX="23"></a></td>
							</tr>
							<%}
			}

			%>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td id="a2">
				<table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="5">
					<tr>
						<td colspan="6">&nbsp;</td>
					</tr>
					<tr align="center">
						<td width="20%">Last instalment end date</td>
						<td width="15%">Date of loan first disbursed</td>
						<td width="15%">No of instalments received</td>
						<td width="20%">Amount of instalment received</td>
						<td width="15%">Date of last instalment received</td>
						<td width="15%">Date from when default in payment is started</td>
					</tr>
					<%for (int i = 0; i < 5; i++) {
				if (strlastinsDate[i] != null && strlastinsDate[i] != "") {

					%>
					<tr>
						<td width="20%"><INPUT TYPE="text" NAME="txt_last_date" SIZE="15"
							MAXLENGTH="25" VALUE="<%//=Helper.correctNull(location[i])%>">
							<a href="#" onClick="callCalender('txt_last_date[<%=i%>]')"
							TITLE="Click to view calender" BORDER=0><IMG
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							BORDER="0" TABINDEX="23"></a></td>
						<td width="15%"><input type="text" name="txt_disburse_date"
							size="15" maxlength="15"
							value="<%//=Helper.correctNull(descript[i])%>">
							<a href="#" onClick="callCalender('txt_disburse_date[<%=i%>]')"
							TITLE="Click to view calender" BORDER=0><IMG
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							BORDER="0" TABINDEX="23"></a></td>
						<td width="15%"><input type="text" name="txt_noinstalment_rec"
							onKeyPress="allowInteger()" size="35" maxlength="4"
							value="<%//=Helper.correctNull(owner[i])%>"></td>
						<td width="20%"><input type="text" name="txt_amount_insreceived" style="text-align:right"
							onKeyPress="allowInteger()" size="35" maxlength="9"
							value="<%//=Helper.correctNull(owner[i])%>"></td>
						<td width="15%"><input type="text" name="txt_instale_date"
							size="15" maxlength="25"
							value="<%//=Helper.correctNull(date[i])%>"> <a href="#" onClick="callCalender('txt_instale_date[<%=i%>]')"
							TITLE="Click to view calender" BORDER=0><IMG
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							BORDER="0" TABINDEX="23"></a></td>
						<td width="15%"><input type="text" name="txt_payment_date"
							size="15" maxlength="25"
							value="<%//=Helper.correctNull(date[i])%>"> <a href="#" onClick="callCalender('txt_payment_date[<%=i%>]')"
							TITLE="Click to view calender" BORDER=0><IMG
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							BORDER="0" TABINDEX="23"></a></td>
					</tr>
					<%}

				else {%>
					<tr>
						<td width="20%"><input type="text" name="txt_last_date" size="15"
							maxlength="25" value="<%//=Helper.correctNull(location[i])%>"">
							<a href="#" onClick="callCalender('txt_last_date[<%=i%>]')"
							TITLE="Click to view calender" BORDER=0><IMG
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							BORDER="0" TABINDEX="23"></a></td>
						<td width="15%"><input type="text" name="txt_disburse_date"
							size="15" maxlength="15"
							value="<%//=Helper.correctNull(descript[i])%>"">
							<a href="#" onClick="callCalender('txt_disburse_date[<%=i%>]')"
							TITLE="Click to view calender" BORDER=0><IMG
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							BORDER="0" TABINDEX="23"></a></td>
						<td width="15%"><input type="text" name="txt_noinstalment_rec"
							onKeyPress="allowInteger()" size="35" maxlength="4"
							value="<%//=Helper.correctNull(owner[i])%>""></td>
						<td width="20%"><input type="text" name="txt_amount_insreceived" style="text-align:right"
							onKeyPress="allowInteger()" size="35" maxlength="9"
							value="<%//=Helper.correctNull(owner[i])%>""></td>
						<td width="15%"><input type="text" name="txt_instale_date"
							size="15" maxlength="25"
							value="<%//=Helper.correctNull(date[i])%>""> <a href="#" onClick="callCalender('txt_instale_date[<%=i%>]')"
							TITLE="Click to view calender" BORDER=0><IMG
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							BORDER="0" TABINDEX="23"></a></td>
						<td width="15%"><input type="text" name="txt_payment_date"
							size="15" maxlength="25"
							value="<%//=Helper.correctNull(date[i])%>""> <a href="#" onClick="callCalender('txt_payment_date[<%=i%>]')"
							TITLE="Click to view calender" BORDER=0><IMG
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							BORDER="0" TABINDEX="23"></a></td>
					</tr>
					<%}
			}

			%>
				</table>
				</td>
			</tr>
			<tr>
				<td>
				<!--<table width="100%" border="1" cellspacing="0" cellpadding="3">
					<tr>
						<td colspan="3">23.Interest occrued in the account facility wise:
						-</td>
						<td align="right"><b>(Rs. in actuals);-</b></td>
					</tr>
					<tr>
						<td>Nature</td>
						<td>Interest recovered up to ___________</td>
						<td>Interest in Dummy Ledger From <input type="text"
							name="textfield3" size="5"> to <input type="text"
							name="textfield4" size="5"></td>
						<td>Total Interest Payable as on ________________</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</table>-->
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="12%" border="0" cellspacing="0" cellpadding="0"
class="outertable border1"
	align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2">
			<tr>
				<td align="center"><input type="button" name="cmdedit" value="Edit"
					class="buttonStyle"
					onclick="doEdit()"></td>
				<td align="center"><input type="button" name="cmdapply"
					value="Save"
					class="buttonStyle"
					onclick="doSave()"></td>
				<td align="center"><input type="button" name="cmdcancel"
					value="Cancel"
					class="buttonStyle"
					onclick="doCancel()"></td>
				<td align="center"><input type="button" name="cmddel" value="Delete"
					class="buttonStyle"
					onclick="doDelete()"></td>
				<!-- <td align="center"><input type="button" name="cmdhelp" value="Help"
					style="background-color:#009966;cursor:help;;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
					onclick="doHelp()"></td> -->
				<td align="center"><input type="button" name="cmdclose"
					value="Close"
					style="background-color:#CC3300;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
					onclick="doClose()"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<input type="hidden" name="hidAction" /> 
<input type="hidden"	name="hidBeanId" />
 <input type="hidden" name="hidBeanMethod" value="" />
<input type="hidden" name="hidBeanGetMethod" value="" />
 <input	type="hidden" name="hidSourceUrl" /> 
 <input type="hidden"	name="hidCostitution" value="<%=strCons_Owner%>" />
  <input	type="hidden" name="hidappno"	value="<%=(String)request.getParameter("appno")%>">
	<input type="hidden" name="hidmoduletype" value="SUIT" />
<input type="hidden" name="comapp_id" value="<%=(String)request.getParameter("comapp_id")%>">
</form>
</body>
</html>
