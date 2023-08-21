<%@ include file="../share/directives.jsp"%>
<%
	strCategoryType = Helper.correctNull((String) request
			.getParameter("hidCategoryType"));
	strSSIType = Helper.correctNull((String) request
			.getParameter("hidSSIType"));
	String strProposal = Helper.correctNull((String) hshValues
			.get("inward_proptype"));
	if (strProposal.equals("")) {
		strProposal = Helper.correctNull((String) request
				.getParameter("hidproposal"));
	}
	String strSector = Helper.correctNull((String) request
			.getParameter("hidsector"));
	if (strSector.equals(""))
		strSector = Helper.correctNull((String) hshValues
				.get("sectordesc"));
	String strSaral = Helper.correctNull((String) request
			.getParameter("hidsaral"));
	if (strSaral.equals(""))
		strSaral = "saral";
	String strappliedfor = Helper.correctNull((String) hshValues
			.get("borrowertype"));
	if (strappliedfor.equals(""))
		strappliedfor = Helper.correctNull((String) request
				.getParameter("appliedfor"));

	String strNew = Helper.correctNull((String) request
			.getParameter("new"));
	String strstatus = Helper.correctNull((String) request
			.getParameter("hidstatus"));
	if (strstatus.equals(""))
		strstatus = Helper
				.correctNull((String) hshValues.get("status"));
	String strappassign = Helper.correctNull((String) request
			.getParameter("hidappassign"));
	if (strappassign.equals(""))
		strappassign = Helper.correctNull((String) hshValues
				.get("assignusrid"));
	String strAppAtached = Helper.correctNull(request
			.getParameter("hidappatached"));
	if (strAppAtached.equals(""))
		strAppAtached = Helper.correctNull((String) hshValues
				.get("appatached"));

	String customername = Helper.correctNull((String) hshValues
			.get("customername"));
	String inwardno = Helper.correctNull((String) hshValues
			.get("inwardno"));
	String valuesin = Helper.correctNull((String) hshValues
			.get("valuesin"));
	String IsSaralhead = Helper.correctNull((String) hshValues
			.get("IsSaralhead"));
	String ISorghead = Helper.correctNull((String) hshValues
			.get("ISorghead"));
	String strAppOrgName = Helper.correctNull((String) hshValues
			.get("orgname"));
	String strIpAddress = Helper.correctNull((String) hshValues
			.get("ipaddress"));
	String strApploantype = Helper.correctNull((String) request
			.getParameter("apploantype"));
	String strApplevel = Helper.correctNull((String) request
			.getParameter("applevel"));

	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	arrRow = (ArrayList) hshValues.get("arrCibilaccountInfo");
	
	 //Added by Zahoorunnisa.S for button functionality
    String strapplevel = Helper.correctNull((String)request.getParameter("applevel"));
	if (strstatus.equals(""))
		strstatus = Helper.correctNull((String) hshValues.get("status"));
	//End
%>
<html>
<head>
<title>Activities</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<SCRIPT language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>

var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentdate="<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";
function Onloading()
{

//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh
	
	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		if("<%=strstatus%>"=="O" && varright=="w"){
			
			disableCommandButtons(false,true,true,true,true,false);
		}else{
			disableCommandButtons(true,true,true,true,true,false);	
		}
			
	}else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		
		disableCommandButtons(true,true,true,true,true,false);
			
    }else{
		
		if("<%=strapplevel%>" == "S"){
			disableCommandButtons(true,true,true,true,true,false);
			}
	}

	
	//End
	
	disablefields(true);

	
}

function disablefields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=val;
		}	  
	}
}

function enablebuttons(editbool,applybool,canbool,delbool,closebool)
{
	document.forms[0].cmdedit.disabled=editbool;
	document.forms[0].cmdsave.disabled=applybool;
	document.forms[0].cmdcancel.disabled=canbool;
	document.forms[0].cmddelete.disabled=delbool;
	document.forms[0].cmdclose.disabled=closebool;
}

function doEdit()
{
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value="update";
	disablefields(false);
	enablebuttons(true,false,false,false,true);
}

function doSave()
{
	if(!document.forms[0].acc_number.value=="")
	{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="inwardRegister"
	document.forms[0].hidBeanMethod.value="updateCibilaccountInfo";
	document.forms[0].hidBeanGetMethod.value="getDateCibilaccountInfo";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/app_cibilaccountinfo.jsp";
	document.forms[0].submit();
	}
	else
	{
		alert("Enter Account Number/ Credit Card Number");
		document.forms[0].acc_number.focus();
		
	}
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="inwardRegister"
		document.forms[0].hidBeanGetMethod.value="getDateCibilaccountInfo";
		document.forms[0].action=appUrl+"action/app_cibilaccountinfo.jsp";
		document.forms[0].submit();
	 }
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="inwardRegister"
		document.forms[0].hidBeanMethod.value="updateCibilaccountInfo";
		document.forms[0].hidBeanGetMethod.value="getDateCibilaccountInfo";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/app_cibilaccountinfo.jsp";
		document.forms[0].submit();
	}
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appUrl+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}

function callLink(page,bean,method)
{ 
	if (document.forms[0].hideditflag.value=="N")
	{
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

function callCalender(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		 showCal(appUrl,val);
	}
}

function doNew()
{
	disablefields(false);
    document.forms[0].hidAction.value ="insert";
    document.forms[0].acc_number.value="";
    disableCommandButtons(true,true,false,true,false,true);
}


function disableCommandButtons(cmdNew,cmdedit,cmdsave,cmdDelete,cmdcancel,cmdclose)
{  
	  document.forms[0].cmdnew.disabled =cmdNew;
	  document.forms[0].cmdedit.disabled=cmdedit;	  
	  document.forms[0].cmdsave.disabled=cmdsave;
	  document.forms[0].cmddelete.disabled=cmdDelete;
	  document.forms[0].cmdcancel.disabled=cmdcancel;
	  document.forms[0].cmdclose.disabled=cmdclose;
}


function selectValues(val1,val2)
{
	document.forms[0].acc_number.value=val1;
	document.forms[0].hid_slno.value=val2;
	
//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh
	
	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		if("<%=strstatus%>"=="O" && varright=="w"){
			
			disableCommandButtons(false,true,true,true,true,false);
		}else{
			disableCommandButtons(true,true,true,true,true,false);	
		}
			
	}else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		
		disableCommandButtons(true,true,true,true,true,false);
			
    }else{
		
		if("<%=strapplevel%>" == "S"){
			disableCommandButtons(true,true,true,true,true,false);
			}
	}

	
	//End
	
}
</script>
<!--<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">-->
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>

<body onload="Onloading()">
<form name="frmcilbilaccountinfo" method="post" class="normal">
<table width="32%" border="0" cellspacing="1" cellpadding="3">
	<tr>
		<td class="main_tab_inactive" align="center" width="50%"><a
			href="javascript:gotoTab(appUrl,'inwardRegister','getdata','appinwardreg.jsp')">Loan
		Application Register</a></td>
		<td class="main_tab_active" width="20%" align="center">Cibil</td>
		<td class="main_tab_inactive" width="30%" align="center"><a
			href="javascript:gotoTabpage(appUrl,'appcibilinterface.jsp')">Cibil
		Interface</a></td>
		<lapschoice:inward />
	</tr>
</table>
<br>
<br>
<table width="98%" border="0" cellspacing="0" cellpadding="5"
	align="center" class="outertable border1">
	<tr>
		<td valign="top">
		<table width="70%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="80%" border="0" cellspacing="0" cellpadding="5"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="5"
									class="outertable">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="outertable">
											<tr>
												<td>
												<table width="100%" border="0" cellspacing="1"
													cellpadding="7" class="outertable">
													<tr>
														<td>Account Number/ Credit Card Number</td>
														<td><input type="text" name="acc_number" value=""
															size="30" maxlength="29" onKeyPress="notAllowSplChar()">
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


<lapschoice:combuttonnew
	btnnames="New_Edit_Save_Delete_Cancel_Audit Trail"
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' />
<table width="80%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3"
			class="outertable">
			<tr class="dataHeader">
				<td width="5%">&nbsp;</td>
				<td align="center" width="15%">Account Number/ Credit Card
				Number</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<%
			if (arrRow.size() > 6) {
		%>
		<div class="cellContainer">
		<%
			}
		%>
		<table width="100%" border="0" cellspacing="1" cellpadding="0"
			class="outertable">
			<%
				String sel_val = null;
				if (arrRow != null && arrRow.size() > 0) {
					if (arrRow.size() > 0) {
						for (int i = 0; i < arrRow.size(); i++) {
							arrCol = (ArrayList) arrRow.get(i);
							sel_val = "";
			%>
			<tr class="datagrid">
				<td width="5%" align="center"><input type="radio"
					style="border: none" name="rdoUser"
					onClick="javascript:selectValues('<%=Helper.correctNull((String) arrCol.get(1))%>','<%=Helper.correctNull((String) arrCol.get(2))%>')">
				</td>
				<td width="15%" align="left">&nbsp;<%=Helper.correctNull((String) arrCol.get(1))%></td>
			</tr>
			<%
				}
					}
				} else {
			%>
			<tr class="datagrid">
				<td align="center" colspan="6">No Data Found</td>
			</tr>
			<%
				}
			%>
		</table>
		<%
			if (arrRow.size() > 6) {
		%>
		</div>
		<%
			}
		%>
		</td>
	</tr>
</table>
<input type="hidden" name="hid_slno" value="">
<input type="hidden" name="Application" value="<%=Helper.correctNull((String)request.getParameter("Application"))%>">
</form>
</body>
</html>
