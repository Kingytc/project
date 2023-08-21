<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			String strcomid = Helper.correctNull((String) request.getParameter("id1"));
			String strcomid1 = Helper.correctNull((String) request.getParameter("hid_comappid1"));%>
<html>
<head>
<title>Retail - NRI Details(s)</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var Empcontract = "<%=Helper.correctNull((String)hshValues.get("APPNRI_EMP_CONT"))%>";
var provisionalrenew = "<%=Helper.correctNull((String)hshValues.get("APPNRI_PROV_RENEW"))%>";
var wlflg = "<%=Helper.correctNull((String)hshValues.get("APPNRI_WL_FLG"))%>";
var varRecordflag ="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function callonLoad()
{		
    disablefields(true);
    if(document.forms[0].readFlag.value=="r")
	{
		enableButtons(true,true,true,true,false);
		
	}
	else
	{   
		if(appstatus=="true")
		  {
			enableButtons(true,true,true,true,false);
		  }
		  else
		  {
	       enableButtons(false, true, true, true, false);
		  }

	}
	
	if(wlflg!="")
	{
		document.forms[0].sel_workpermit.value=Empcontract;
	}
	if(provisionalrenew!="")
	{
		document.forms[0].sel_provrenewal.value=provisionalrenew;
	}
	if(Empcontract!="")
	{
		document.forms[0].txt_empcontract.value=Empcontract;
	}
}
function checkfiledate1(obj)
{
	var pagedate=obj.value;
	var pgdt=pagedate.substring(0,2);
	var pgmon=pagedate.substring(3,5);
	var pgyear=pagedate.substring(6,10);
	var pgdt=pgmon+"/"+pgdt+"/"+pgyear;
	var currentdt=document.forms[0].txt_dtissue.value;
	if(document.forms[0].txt_validupto.value != ""){
		if(currentdt!="")
		{
			var curdt=currentdt.substring(0,2);
			var curmon=currentdt.substring(3,5);
			var curyear=currentdt.substring(6,10);
			var curdt=curmon+"/"+curdt+"/"+curyear;
			if(document.forms[0].txt_dtissue.value!="" && document.forms[0].txt_validupto.value!=""){
				if(Date.parse(pgdt) < Date.parse(curdt))
				{
					alert("Valid upto date should not be Less than  Issue Date");
					document.forms[0].txt_validupto.value="";
					document.forms[0].txt_validupto.focus();
				} 
			}
	  }
	  else
	  {
			alert("Enter the Issue Date");
			document.forms[0].txt_dtissue.focus();
	  }
	 }
}
function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].value="";		  
		}
		else if (document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].value="0";	
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
}

function disablefields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
	}
}

function doSave()
{	
	enableButtons(false, true, true, true, false);
	document.forms[0].hidRecordflag.value = varRecordflag;
	document.forms[0].hidBeanId.value="refdetails";
	document.forms[0].hidBeanMethod.value="updatenriData";
	document.forms[0].hidBeanGetMethod.value="getnriData";
	document.forms[0].hidSourceUrl.value="/action/nridetails.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function doClose()
{
	window.close();
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidAction.value="Cancel";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanId.value="refdetails";
		document.forms[0].hidBeanGetMethod.value="getnriData";
		document.forms[0].hidSourceUrl.value="/action/nridetails.jsp";		
		document.forms[0].submit();
	}
}

function doNew() 
{
	ClearFields();
	document.forms[0].hidAction.value="New";
   	enableButtons(true, false, false, false, true);
   	disablefields(false);   	
}

function doEdit() 
{
   	document.forms[0].hidAction.value="Edit"
	enableButtons(true, false, false, false, true);
	disablefields(false);
}
   
function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function callCalender(fname)
{
	var action  =document.forms[0].hidAction.value;
	if(action =="New" || action =="Edit")
	{
		showCal(appUrl,fname);
	}
}
function doDelete()
	{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
		{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"controllerservlet";	
		document.forms[0].hidBeanMethod.value="updatenriData";
		document.forms[0].hidBeanGetMethod.value="getnriData";
		document.forms[0].hidBeanId.value="refdetails";
		document.forms[0].hidSourceUrl.value="/action/nridetails.jsp";	
		document.forms[0].method="post";	
		document.forms[0].submit();		
		}
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="callonLoad()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Customer Profile -&gt; Demographics -&gt; NRI Details
	</tr>	
</table>
<table width="98%" border="0" cellpadding="5" cellspacing="0" class="outertable border1" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td>
				<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td>
						<table width="98%" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td>Visa Valid up to</td>
								<td>
								<table width="12%" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td><input type="text" name="txt_visavaliddate" size="11"
											maxlength="50" tabindex="1"
											value="<%=Helper.correctNull((String)hshValues.get("APPNRI_VISAUPTO"))%>"
											onBlur="dateretireCheck(document.forms[0].txt_visavaliddate);">
										</td>
										<td><a href="#"
											onClick="callCalender('document.forms[0].txt_visavaliddate')"
											title="Click to view calender" border=0><img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											border="0" tabindex="2"></a></td>
									</tr>
								</table>
								</td>
								<td>Visa Particulars</td>
								<td><textarea name="txt_visaparticulars" cols="40" rows="2" onKeyPress="textlimit(this,349)" onKeyUp="textlimit(this,349)"
									tabindex="3"><%=Helper.correctNull((String) hshValues
							.get("APPNRI_VISADESC"))%></textarea></td>
							</tr>
							<tr>
								<td>Passport Number</td>
								<td><input type="text" name="txt_passportno" size="35"
									maxlength="120" tabindex="4"
									value="<%=Helper.correctNull((String)hshValues.get("perapp_passport"))%>">
								</td>
								<td>Passport Issued by</td>
								<td><input type="text" name="txt_passportissuby" size="35"
									maxlength="120" tabindex="5"
									value="<%=Helper.correctNull((String)hshValues.get("perapp_passissue"))%>">
								</td>
							</tr>
							<tr>
								<td>Date of Issue (Date)</td>
								<td><input type="text" name="txt_dateofissue" size="11"
									maxlength="50" tabindex="6"
									value="<%=Helper.correctNull((String)hshValues.get("perapp_passissuedt"))%>"
									onBlur="dateretireCheck(document.forms[0].txt_dateofissue);"></td>
								<td>Date of Expiry (Date)</td>
								<td><input type="text" name="txt_dateofexpiry" size="11"
									maxlength="50" tabindex="8"
									value="<%=Helper.correctNull((String)hshValues.get("perapp_passexpiry"))%>"
									onBlur="dateretireCheck(document.forms[0].txt_dateofexpiry);">
								&nbsp; </td>
							</tr>
							<tr>
								<td>Overseas Address</td>
								<td> <textarea
									name="txt_overseasaddress" cols="40" rows="2" onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)" tabindex="9"><%=Helper.correctNull((String) hshValues
							.get("APPNRI_OVERSEA_ADD"))%></textarea> </td>
								<td>Employment Contract</td>
								<td> <select
									name="txt_empcontract" tabindex="10">
									<option value="0" selected>Yes</option>
									<option value="1">No</option>
								</select> </td>
							</tr>
							<tr>
								<td>Contract Valid up to</td>
								<td>
								<table width="12%" cellspacing="0" cellpadding="3">
									<tr>
										<td><input type="text" name="txt_contractvaliddate" size="11"
											maxlength="50" tabindex="11"
											value="<%=Helper.correctNull((String)hshValues.get("APPNRI_CONTRACTDT"))%>"
											onBlur="dateretireCheck(document.forms[0].txt_contractvaliddate)">
										</td>
										<td><a href="#"
											onClick="callCalender('document.forms[0].txt_contractvaliddate')"
											title="Click to view calender" border=0><img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											border="0" tabindex="12"></a></td>
									</tr>
								</table>
								</td>
								<td>Balance Period in Contract</td>
								<td> <input type="text"
									name="txt_balanceperiod" size="20" maxlength="50" tabindex="13"
									value="<%=Helper.correctNull((String)hshValues.get("APPNRI_BALAPRD_CONT"))%>">
								</td>
							</tr>
							<tr>
								<td>Terms of Contract</td>
								<td> <textarea
									name="txt_termsofcontract" cols="40" rows="2" onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)" tabindex="14"><%=Helper.correctNull((String) hshValues
							.get("APPNRI_TERMS_CONT"))%></textarea> </td>
								<td>Nature of Employment</td>
								<td> <textarea
									name="txt_natureemploy" cols="40" rows="2" onkeyup="textlimitcorp1(this,100);" onkeydown="textlimitcorp1(this,100);" tabindex="15"><%=Helper.correctNull((String) hshValues
							.get("APPNRI_EMPLOYNAT"))%></textarea>
								</td>
							</tr>
							<tr>
								<td>Provision for Renewal</td>
								<td> <select
									name="sel_provrenewal"  tabindex="16">
									<option value="0" selected>Yes</option>
									<option value="1">No</option>
								</select> </td>
								<td>Renewal Details</td>
								<td><textarea name="txt_renewal" cols="40" rows="2" onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)"
									tabindex="17"><%=Helper.correctNull((String) hshValues
							.get("APPNRI_RENE_DET"))%></textarea></td>
							</tr>
							<tr>
								<td>Work Permit/Labour Card No</td>
								<td> <select
									name="sel_workpermit"  tabindex="18">
									<option value="0" selected>Yes</option>
									<option value="1">No</option>
								</select> </td>
								<td>Work Permit No/Labour Card No</td>
								<td><input type="text" name="txt_workpermitno" size="20"
									maxlength="50" tabindex="19"
									value="<%=Helper.correctNull((String)hshValues.get("APPNRI_WL_NO"))%>">
								</td>
							</tr>
							<tr>
								<td>Date of issue</td>
								<td>
								<table width="12%" cellspacing="0" cellpadding="3">
									<tr>
										<td><input type="text" name="txt_dtissue" size="11"
											maxlength="50"  tabindex="20"
											value="<%=Helper.correctNull((String)hshValues.get("APPNRI_ISSUEDT"))%>"
											onBlur="dateretireCheck(document.forms[0].txt_dtissue);"></td>
										<td><a href="#"
											onClick="callCalender('document.forms[0].txt_dtissue')"
											title="Click to view calender" border=0><img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											border="0" tabindex="21"></a></td>
									</tr>
								</table>
								</td>
								<td>Issuing Authority</td>
								<td><input type="text" name="txt_issuingauthority" size="20"
									maxlength="50" tabindex="22"
									value="<%=Helper.correctNull((String)hshValues.get("APPNRI_ISSAUTH"))%>">
								</td>
							</tr>
							<tr>
								<td>Valid Up to</td>
								<td>
								<table width="12%" cellspacing="0" cellpadding="3">
									<tr>
										<td><input type="text" name="txt_validupto" size="11"
											maxlength="50" tabindex="23"
											value="<%=Helper.correctNull((String)hshValues.get("APPNRI_VAILDUPTO"))%>"
											onBlur="checkDate(this);checkfiledate1(this);dateretireCheck(document.forms[0].txt_validupto)"></td>
										<td><a href="#"
											onClick="callCalender('document.forms[0].txt_validupto')"
											title="Click to view calender" border=0><img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											border="0" tabindex="24"></a></td>
									</tr>
								</table>
								</td>
								<td>Terms of Permit/ Labour card</td>
								<td><textarea name="txt_termsofpermit" cols="40" rows="2" onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)"
									tabindex="25"><%=Helper.correctNull((String) hshValues
							.get("APPNRI_TERM_WL"))%></textarea></td>
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
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hid_comappid1" value="<%=Helper.correctNull((String)request.getParameter("hid_comappid1"))%>">
<input type="hidden" name="hid_comappid" value="<%=Helper.correctNull((String)hshValues.get("APPNRI_ID"))%>">
<input type="hidden" name="hid_appnriid" value="<%=Helper.correctNull((String)hshValues.get("APPNRI_ID"))%>">
<input type="hidden" name="hidappstatus" value="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>">
<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
</form>
</body>
</html>
