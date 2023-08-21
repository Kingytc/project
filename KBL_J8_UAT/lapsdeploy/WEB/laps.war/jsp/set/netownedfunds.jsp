<%@ include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}%>
<html>
<head>
<title>Net Funds</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="javascript">
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varRecordflag = "<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
function whileLoading()
{
	disableFields(true);
	enableButtons(false,true,true,false);
}

function enableButtons(bool1,bool2,bool3,bool4)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;		
	document.forms[0].cmdclose.disabled=bool4;		
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
	}
	document.forms[0].mdate.disabled=true;
}

function doCancel()
{
	if(ConfirmMsg(102))
	{				
		document.forms[0].action=appUrl+"action/netownedfunds.jsp";	
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].hidBeanId.value="netownedfunds";			
		document.forms[0].submit();		
	}
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action = appUrl + "action/setupnav.jsp";
		document.forms[0].submit();
	}
}

function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,true);			
	document.forms[0].netownedfunds.focus();
}

function doSave()
{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidRecordflag.value = varRecordflag;
    document.forms[0].mdate.disabled=false;
	document.forms[0].hidBeanGetMethod.value="UpdateNetOwnedFundsData";
	document.forms[0].hidBeanId.value="netownedfunds";
	document.forms[0].action=appUrl+"action/netownedfunds.jsp";	
	document.forms[0].submit();
}

function callCalender(tname)
 {
	 if(document.forms[0].cmdedit.disabled)
		 showCal("<%=ApplicationParams.getAppUrl()%>",tname);
	}
</script>
</head>

<body onload="javascript:whileLoading()">

<form name="netfunds" method="post" class="normal">
<table class="outertable" width="100%">
	<tr>
		<td class="page_flow" >Home -&gt; Setup -&gt; Corporate Products
		-&gt; Net Owned Funds</td>
	</tr>
</table>
<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5"
	height="380"
	align="center">
	<tr>
		<td valign="top">
		<div align="left"></div>
		<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top">
				<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5">
					<tr>
						<td valign="middle">
						<table class="outertable" width="70%" border="0" cellspacing="0" cellpadding="5" align="center">
							<tr>
								<td>
								<table class="outertable border1" width="100%" border="0" cellspacing="1" cellpadding="5">
									<tr>
										<td width="38%">Bank Net Owned Funds&nbsp;&nbsp;&nbsp;<b>(Rs. in Crores)</b></td>
										<td width="20%">
										<%
											String mdate = "";
											String netownedfunds = Helper.correctNull((String) hshValues.get("netownedfunds"));
											String sinexposure = Helper.correctNull((String) hshValues.get("sinexposure"));
											String grpexposure = Helper.correctNull((String) hshValues.get("grpexposure"));
											String totbankcredit = Helper.correctNull((String) hshValues.get("totbankcredit"));
											String sininfra = Helper.correctNull((String) hshValues.get("singleborrinfra"));
											String grpinfra = Helper.correctNull((String) hshValues.get("groupborrinfra"));
											String oilcmpy = Helper.correctNull((String) hshValues.get("olicompany"));
											String netownedfunds_date = Helper.correctNull((String) hshValues.get("ownedfundsasno"));
											String totbankcredit_date = Helper.correctNull((String) hshValues.get("totbankcreditasno"));
											if ((netownedfunds.equals("0.00")) && (sinexposure.equals("0.00")) && (grpexposure.equals("0.00")))
												mdate = "";
											else
												mdate = Helper.correctNull((String) hshValues.get("mdate"));
											if (netownedfunds.equals("0.00"))
												netownedfunds = "";
											if (sinexposure.equals("0.00"))
												sinexposure = "";
											if (grpexposure.equals("0.00"))
												grpexposure = "";
										%> <lapschoice:CurrencyTag name="netownedfunds"
											value="<%=netownedfunds%>" size="15" maxlength="12" /></td>
										<td width="42%">
										<table class="outertable" width="50%" border="0" cellspacing="1" cellpadding="1">
											<tr>
												<td width="70%">as on</td>
												<td width="70%"><input type="text" name="netownedfunds_date" size="15" maxlength="10"
													style="text-align: left;"
													onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')"
													onKeyPress="notAllowedDouble();notAllowSpace()"
													value="<%=netownedfunds_date%>"></td>
												<td width="30%" align="center"><a
													href="javascript:callCalender('netownedfunds_date')"
													title="Click to view calender" border=0><img
													src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
													border="0"></a></td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td width="38%">Total Bank Credit as of previous year or
										previous quarter <b>(Rs. in Crores)</b></td>
										<td width="20%"><lapschoice:CurrencyTag name="totbankcredit"
											value='<%=totbankcredit%>' size="15" maxlength="12" /></td>
										<td width="42%">
										<table class="outertable" width="50%" border="0" cellspacing="1" cellpadding="1">
											<tr>
												<td width="70%">as on</td>
												<td width="70%"><input type="text" name="totbankcredit_date" size="15" maxlength="10"
													style="text-align: left;"
													onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')"
													onKeyPress="notAllowedDouble();notAllowSpace()"
													value="<%=totbankcredit_date%>"></td>
												<td width="30%" align="center"><a
													href="javascript:callCalender('totbankcredit_date')"
													title="Click to view calender" border=0><img
													src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
													border="0"></a></td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td width="38%">Single Borrower Exposure Limit</td>
										<td width="20%"><lapschoice:CurrencyTag name="sinexposure"
											value='<%=sinexposure%>' size="15"
											onBlur="checkPercentage(this)" /></td>
										<td width="42%">% of Bank Net Owned Funds</td>
									</tr>
									<tr>
										<td width="38%">Single Borrower with infrastructure</td>
										<td width="20%"><lapschoice:CurrencyTag name="sininfra"
											value='<%=sininfra%>' size="15"
											onBlur="checkPercentage(this)" /></td>
										<td width="42%">% of Bank Net Owned Funds</td>
									</tr>
									<tr>
										<td width="38%">Group Exposure Limit</td>
										<td width="20%"><lapschoice:CurrencyTag name="grpexposure"
											value='<%=grpexposure%>' size="15"
											onBlur="checkPercentage(this)" /></td>
										<td width="42%">% of Bank Net Owned Funds</td>
									</tr>
									<tr>
										<td width="38%">Group of Borrower with infrastructure
										Project</td>
										<td width="20%"><lapschoice:CurrencyTag name="grpinfra"
											value='<%=grpinfra%>' size="15"
											onBlur="checkPercentage(this)" /></td>
										<td width="42%">% of Bank Net Owned Funds</td>
									</tr>
									<tr>
										<td width="38%">For Oil Companies</td>
										<td width="20%"><lapschoice:CurrencyTag name="oilcmpy"
											value='<%=oilcmpy%>' size="15" onBlur="checkPercentage(this)" /></td>
										<td width="42%">% of Bank Net Owned Funds</td>
									</tr>
									<tr>
										<td width="38%">Modified Date</td>
										<td width="20%"><input type="text" name="mdate" size="15"
											value="<%=mdate%>" onblur="checkDate(this)"></td>
										<td width="42%">&nbsp;</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type ="hidden" name ="hidkeyid" value="set">
</form>
</body>
</html>
