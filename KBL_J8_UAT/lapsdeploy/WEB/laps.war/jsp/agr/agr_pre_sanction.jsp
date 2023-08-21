<%@include file="../share/directives.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>UBI</title>

<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "<%=ApplicationParams.getAppUrl()%>";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js">
</script>

<%String address1 = Helper.correctNull((String) hshValues.get("perapp_address1"));%>
<%String address4 = (String) Helper.correctNull((String)hshValues.get("address4"));
String City = (String) Helper.correctNull((String)hshValues.get("City"));
			String State = (String) Helper.correctNull((String)hshValues.get("State"));
			String Pincode = (String) Helper.correctNull((String)hshValues.get("Pincode"));
String strapplevel = Helper.correctNull((String)request.getParameter("applevel"));			
			%>
<%//String age = Helper.correctNull((String) hshValues.get("agecal"));%>

<%String edu = Helper.correctNull((String) hshValues.get("perapp_education"));
			String sel_refno = Helper.correctNull((String) hshValues.get("sel_refno"));
			
			String newage = Helper.correctNull((String) hshValues.get("strAge"));
			String strSaral = Helper.correctNull((String) request.getParameter("hidsaral"));
			String strSector=Helper.correctNull((String)request.getParameter("hidsector"));
			String strno="";
			if(strSaral.equals("saral"))
			{
				strno=Helper.correctNull((String) hshValues.get("inwardno"));
			}
			else
			{
				strno=Helper.correctNull((String) hshValues.get("appno"));
			}
//Added by Zahoorunnisa.S for button functionality
			
			String strstatus = Helper.correctNull((String) request.getParameter("hidstatus"));
			if (strstatus.equals(""))
				strstatus = Helper.correctNull((String) hshValues.get("status"));
						
				//end	
			%>


<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var selaccounttype="<%=Helper.correctNull((String)hshValues.get("regular_account"))%>";
var selaccreg="<%=Helper.correctNull((String)hshValues.get("terms_cond_complied"))%>";
var sel_borrower="<%=Helper.correctNull((String)hshValues.get("sel_borrower"))%>";
var sel_map="<%=Helper.correctNull((String)hshValues.get("sel_map"))%>";
var sel_construction="<%=Helper.correctNull((String)hshValues.get("sel_construction"))%>";
var sel_refno="<%=Helper.correctNull((String)hshValues.get("sel_refno"))%>";
var selexilimit="<%=Helper.correctNull((String)hshValues.get("pre_selexilimit"))%>";
currentDate = "<%=Helper.getCurrentDateTime()%>";
var varsaral="<%=strSaral%>";
var varOrgLevel="<%=strOrgLevel%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		//document.forms[0].cmdclose.disabled=false;		 
	}
	
	if(val=="edit")
	{	 
		
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
		 
	}
	
}
function doSave() 
{
	if(document.forms[0].txt_date.value=="")
	{
		ShowAlert('121','Date of Inspection');
		document.forms[0].txt_date.focus();
		return;
	}
	if(document.forms[0].inspname.value=="")
	{
		ShowAlert('121','Name of the Inspecting Officer');
		document.forms[0].inspname.focus();
		return;
	}
	if(document.forms[0].sel_exilimit.value=="s")
	{
		ShowAlert('111','The Details of Existing Limits');
		document.forms[0].sel_exilimit.focus();
		return;
	}
	if(document.forms[0].sel_exilimit.value=="y")
	{
		if(document.forms[0].txt_sanctionrefno.value=="")
		{
		alert("Enter sanction Ref. No.");
		document.forms[0].txt_sanctionrefno.focus();
		return false;
		}
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidSourceUrl.value="/action/agr_pre_sanction.jsp";
	document.forms[0].hidBeanMethod.value="updatePresanction";
	document.forms[0].hidBeanGetMethod.value="getPresanction";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function changerefno()
{	
   if(document.forms[0].sel_refno.value=="0")
   {
    document.forms[0].txt_sanctionrefno.value="";
     document.forms[0].txt_sanctiondate.value="";
      document.forms[0].txt_loansanction.value="";
      document.forms[0].txt_purpose.value="";
      document.forms[0].txt_sanctionautho.value="";
      document.forms[0].txt_loanamount.value="";
      document.forms[0].txt_datedisbursed.value="";
      document.forms[0].txt_amountoutstanding.value="";
      document.forms[0].txt_amountoverdue.value="";
      document.forms[0].sel_accounttype.value="y";
      document.forms[0].txt_detailirrgular.value="";
      document.forms[0].sel_accreg.value="y";
      document.forms[0].hidAction1.value ="insert";
     
	 
   }
   else{
  
	document.forms[0].hidAction1.value ="update";
	document.forms[0].hidvalue.value ="get";
    document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidSourceUrl.value="/action/agr_pre_sanction.jsp";
	document.forms[0].hidBeanMethod.value="getPresanction";
	document.forms[0].hidBeanGetMethod.value="getPresanction";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
	}
	disableCommandButtons("change");	
	
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	if(document.forms[0].sel_refno.value=="0")
	{
	document.forms[0].hidAction1.value ="insert";
	}
	else{
	document.forms[0].hidAction1.value ="update";
	}
	disableCommandButtons("edit");	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		//document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getPresanction";
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].action=appURL+"action/agr_pre_sanction.jsp";	
		document.forms[0].submit();
	}	
	
	//disableCommandButtons("load");
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}	 
	}
}
function callCalender(fname)
 {
 	if(document.forms[0].cmdsave.disabled!=true)
	{
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
 }
function placevalues()
{	
	

	//	disableCommandButtons("load");	
	document.forms[0].sel_refno.value="<%=sel_refno%>";	
	if(document.forms[0].sel_accreg.value!="")
	{
	 	document.forms[0].sel_accreg.value=selaccreg;
	}
	if(document.forms[0].sel_accounttype.value!="")
	{
	 	document.forms[0].sel_accounttype.value=selaccounttype;
	}
	if(document.forms[0].sel_borrower.value!="")
	{
		 document.forms[0].sel_borrower.value=sel_borrower;
	}
	if(document.forms[0].sel_map.value!="")
	{
	 	document.forms[0].sel_map.value=sel_map;
	}
	if(document.forms[0].sel_map.value=="")
	{
		 document.forms[0].sel_map.value="Y";
	}
	if(document.forms[0].sel_borrower.value=="")
	{
	 	document.forms[0].sel_borrower.value="Y";
	}
	if(document.forms[0].sel_construction.value!="")
	{
	 	document.forms[0].sel_construction.value=sel_construction;
	}
	if(document.forms[0].sel_construction.value=="")
	{
	 	document.forms[0].sel_construction.value="0";
	}
		if(document.forms[0].sel_accounttype.value=="")
	{
	 	document.forms[0].sel_accounttype.value="y";
	}
	if(document.forms[0].sel_accreg.value=="")
	{
	 	document.forms[0].sel_accreg.value="y";
	}
	if(selexilimit!="")
	{
		document.forms[0].sel_exilimit.value=selexilimit;
	}
	
	disableFields(true);
	showExistingLimit();

	//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh
	
	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		if("<%=strstatus%>"=="O"  &&  varright=="w"){
		    enableButtons(false,true,true,false,true);
		}else{
			enableButtons(true,true,true,true,true);	
		}
			
	}else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		
		enableButtons(true,true,true,true,true,true);
			
    }else{
		
		//Access through Branch Users
		if("<%=strapplevel%>" == "S"){
			enableButtons(true,true,true,true,true);
		}
	}

 
	
	//End
	
}
function doClose()
    {
	var con=ConfirmMsg('100');
	if(con)
	{
		if(document.forms[0].hidsaral && document.forms[0].hidsaral.value=="saral")
		{
				document.forms[0].action=appUrl+"action/mainnav.jsp";
				document.forms[0].submit();
		}
		else
		{
			document.forms[0].target="_parent";
			document.forms[0].action=appUrl+"action/retailpge.jsp";				
			document.forms[0].submit();
		}
		
	}
}

function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="Delete";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].hidSourceUrl.value="/action/agr_pre_sanction.jsp";
		document.forms[0].hidBeanMethod.value="updatePresanction";
		document.forms[0].hidBeanGetMethod.value="getPresanction";	
		document.forms[0].submit();
	}
}

function doPrint()	
{
	if(("<%=strSaral%>"=="saral"))
	{
		var inwardno=document.forms[0].inwardno.value;
		var varsaral="<%=strSaral%>";
		var appname=document.forms[0].appname.value;
		var hidsector=document.forms[0].hidsector.value;
		var val=document.forms[0].sel_exilimit.value;
		var purl="<%=ApplicationParams.getAppUrl()%>action/agr_pre_sanction_report.jsp?hidBeanGetMethod=getPresanction&hidBeanId=appraisal&inwardno="+inwardno+"&presancreport=yes&val="+val+"&hidsaral="+varsaral+"&appname="+appname+"&hidsector="+hidsector;
	}
	else
	{
		var val=document.forms[0].sel_exilimit.value;
		//var orgname=document.forms[0].orgname.value;
		var appno=document.forms[0].appno.value;
		var inwardno=document.forms[0].inwardno.value;
		var purl="<%=ApplicationParams.getAppUrl()%>action/agr_pre_sanction_report.jsp?hidBeanGetMethod=getPresanction&hidBeanId=appraisal&appno="+appno+"&presancreport=yes&val="+val+"&inwardno="+inwardno;
	}
	prop='scrollbars=yes,menubar=yes,width=750,height=520';
	xpos=(screen.width-750)/2;
	ypos=(screen.height-520)/2;
	prop=prop+",xpos="+xpos+",ypos="+ypos;
	window.open(purl,'title',prop);
}
function showExistingLimit()
{
	if(document.forms[0].sel_exilimit.value=="y")
	{
		document.all.s1.style.visibility="visible";
		document.all.s1.style.position="relative";
		document.all.s2.style.visibility="visible";
		document.all.s2.style.position="relative";
		document.all.s3.style.visibility="visible";
		document.all.s3.style.position="relative";
		document.all.s4.style.visibility="visible";
		document.all.s4.style.position="relative";
		document.all.s5.style.visibility="visible";
		document.all.s5.style.position="relative";
		document.forms[0].sel_refno.disabled=false;
	}
	else if(document.forms[0].sel_exilimit.value=="n" || document.forms[0].sel_exilimit.value=="s")
	{
		document.all.s1.style.visibility="hidden";
		document.all.s1.style.position="absolute";
		document.all.s2.style.visibility="hidden";
		document.all.s2.style.position="absolute";
		document.all.s3.style.visibility="hidden";
		document.all.s3.style.position="absolute";
		document.all.s4.style.visibility="hidden";
		document.all.s4.style.position="absolute";
		document.all.s5.style.visibility="hidden";
		document.all.s5.style.position="absolute";
		document.forms[0].sel_refno.value="0";
	}
}	

function enableButtons(valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
}	
	
</script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css" />
</head>

<body onload="placevalues()">
<form name="appform" method="post" class="normal">
 <%if (strSaral.equalsIgnoreCase("saral")) {%>
	 		 <lapschoice:saralreportTag tabid="3" sector='<%=strSector%>'/>
			<lapschoice:inward /> 
			<%}%>

				<table width="100%" cellpadding="3" align="center" cellspacing="0" border="0" class="outertable border1">
				<tr>
				<td>
					<table width="100%" cellpadding="3" align="center" cellspacing="0" border="0" class="outertable">
							<tr>
								<td width="25%">Date of Inspection<b><span class="mantatory">*</span></b></td>
								<td width="14%"><input type="text" name="txt_date"
									value="<%=Helper.correctNull((String)hshValues.get("inspection_date"))%>"
									onblur="checkDate(this);checkmaxdate(this,currentDate)" /></td>
								<td width="61%"><a alt="Select date from calender" href="#"
									onclick="callCalender('txt_date')"
									onmouseover="window.status='Date Picker';return true;"
									onmouseout="window.status='';return true;"> <img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
									alt="Select date from calender" /></a></td>
							</tr>
							<tr>
								<td width="25%">Name of the Inspecting Officer:<b><span class="mantatory">*</span></b></td>
								<td width="14%" colspan="2">
								<input type="text" name="inspname" maxlength="30" size="40" value="<%=Helper.correctNull((String)hshValues.get("nameofinsp"))%>" />
								</td>
							</tr>
							<tr>
								<td width="24%">P.F Number of Inspecting Officer</td>
								<td width="14%" colspan="2">
								<b> <input type="text" name="inspanumb" maxlength="20" size="40" value="<%=Helper.correctNull((String)hshValues.get("panum"))%>" /> </b>
								</td>
							</tr>
							<%if(!(strSaral.equalsIgnoreCase("saral"))){ %>
							<tr>
								<td colspan="3"><b>Full Details of Applicant's </b></td>
							</tr>
							<%}%>
							<tr>
								<td colspan="3">
								
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                            <%if(!(strSaral.equalsIgnoreCase("saral"))){ %>
                            <tr> 
                              <td colspan="2">Full Name and Address</td>
                              <td width="75%">
                                <b> 
                                <input
											type="text" name="txt_appname"
											 size="40" readonly="readonly"
											value="<%=Helper.correctNull((String)hshValues.get("perapp_fname"))%>" />
                                </b> </td>
                            </tr>
                            <tr> 
                              <td colspan="2">&nbsp;</td>
                              <td width="75%"><b> 
                                <input
											type="text" name="add1" 
											 size="60" readonly="readonly"
											value="<%=address1%>" />
                                </b></td>
                            </tr>
                            <tr> 
                              <td colspan="2">&nbsp;</td>
                              <td width="75%"><b> 
                                <input
											type="text" name="add2" 
											 size="60" readonly="readonly"
											value="<%=address4%>" />
                                </b></td>
                            </tr>
                            <tr> 
                              <td colspan="2">&nbsp;</td>
                              <td width="75%"><b> 
                                <input
											type="text" name="add2" 
											 size="60" readonly="readonly"
											value="<%=City%>" />
                                </b></td>
                            </tr>
                            <tr> 
                              <td width="4%">&nbsp;</td>
                              <td width="21%">&nbsp;</td>
                              <td width="75%"><b> 
                                <input
											type="text" name="add2" 
											 size="60" readonly="readonly"
											value="<%=State%>-<%=Pincode%>" />
                                </b></td>
                            </tr>
                            <tr> 
                              <td colspan="2">Age and Education</td>
                              <td width="75%"> 
                                <input type="text" name="age_edu"
											 size="30" readonly="readonly"
											value="<%=newage%>  <%=edu%> " />
                              </td>
                            </tr>
                            <%} %>
                            <tr> 
                              <td colspan="2" valign="top">Brief Description Other 
                                Family Members</td>
                              <td width="75%"> 
                                <textarea cols="60" name="txt_famdesc"
											onkeypress="textlimit(this,249)" onKeyUp="textlimit(this,249)" rows="3"><%=Helper.correctNull((String) hshValues
							.get("other_family_members"))%></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td colspan="2">Present Income and Sources of Income</td>
                              <td width="75%"> 
                                <textarea cols="60" name="txt_presentincome"
											  rows="3" onkeypress="textlimit(this,249)" onKeyUp="textlimit(this,249)"><%=Helper.correctNull((String) hshValues
							.get("present_income_source"))%></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td colspan="2">Other Information</td>
                              <td width="75%"> 
                                <textarea cols="60" name="txt_otherinfo"
											onkeypress="textlimit(this,249)" onKeyUp="textlimit(this,249)" rows="3"><%=Helper.correctNull((String) hshValues
							.get("other_information"))%></textarea>
                              </td>
                            </tr>
                          </table>
								</td>
							</tr>
						</table>
						
			
				
						<table width="100%" cellpadding="3" cellspacing="3" border="0" class="outertable">
							<tr >
								<td width="25%">Whether borrower is from service area of branch</td>
								<td width="25%"><select name="sel_borrower">
									<option value="Y" selected="selected">Yes</option>
									<option value="N">No</option>
								</select></td>
								<td width="25%" valign="top">Revenue Map Obtained</td>
								<td width="25%"><select name="sel_map">
									<option value="Y" selected="selected">Yes</option>
									<option value="N">No</option>
								</select></td>
							</tr>
							<tr >
								<td colspan="4">&nbsp;</td>
							</tr>
							<tr >
								<td colspan="4"><font face="MS Sans Serif" size="1"><b>NEARBY
								LANDMARK FOR IDENTIFICATION : </b></td>
							</tr>
							<tr >
								<td width="25%">East</td>
								<td width="25%"><textarea name="txr_east" cols="40" rows="3"
									onkeypress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("txr_east"))%></textarea>
								</td>
								<td width="25%" valign="top">West</td>
								<td width="25%"><textarea name="txr_west" cols="40" rows="3"
									onkeypress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("txr_west"))%></textarea>
								</td>
							</tr>
							<tr >
								<td width="25%">North</td>
								<td width="25%"><textarea name="txr_north" cols="40" rows="3"
									onkeypress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("txr_north"))%></textarea>
								</td>
								<td width="25%" valign="top">South</td>
								<td width="25%"><textarea name="txr_south" cols="40" rows="3"
									onkeypress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("txr_south"))%></textarea>
								</td>
							</tr>
							<tr >
								<td colspan="2">Particulars of Land-Location,Fertility, Owned
								Land,Leased Land Under Cultivation,Uncultivable Land, Sources of
								Irrigation Particulars of Source :</td>
								<td colspan="2" valign="top"><textarea
									name="txt_landparticulars" style="text-align:left" cols="70"
									rows="5" onkeypress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("land_particulars"))%></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="2" valign="top">The Availability
								of Water From Source of Irrigation-Give Details:</td>
								<td colspan="2"><textarea name="txt_watersource" cols="70"
									rows="5" wrap="VIRTUAL" onkeypress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("water_avail_details"))%></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="2">Loan Amount Applied And Purpose And The Area To
								Be Benefited From The Proposed Developments:</td>
								<td colspan="2"><textarea name="txt_appliedamount" cols="70"
									rows="5" wrap="VIRTUAL" onkeypress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
									.get("benefit_area"))%></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="2">The Details of Crops Being Raised At Present And
								The Details of The Crops To Be Raised As Per The Proposed
								Development.</td>
								<td colspan="2"><textarea name="txt_detailscrops" cols="70"
									rows="5" wrap="VIRTUAL" onkeypress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("crops_details"))%></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="2">The Names of The Guarantor/s,Details of Assets,
								Land ,House ,Agricultural implements Etc. And Value of Each.</td>
								<td colspan="2"><textarea name="txt_applicantasset" cols="70"
									rows="5" wrap="VIRTUAL" onkeypress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("asset_details"))%></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="2">Type of Construction</td>
								<td colspan="2"><select name="sel_construction">
									<option value="0" selected="selected">--select--</option>
									<option value="1">RCC Construction</option>
									<option value="2">Mud &amp; Brick</option>
									<option value="3">Shed</option>
									<option value="4">Kacha</option>
									<option value="5">Tile roof houses</option>
								</select></td>
							</tr>
							<tr>
								<td colspan="2">Applicant/s Liabilities And Details of Charges
								On The Land</td>
								<td colspan="2"><textarea name="txt_liabilities" cols="70"
									rows="5" wrap="VIRTUAL" onkeypress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("liability_details"))%></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="2">What Arrangements Have Been Made By The
								Applicant For Expenses/ Crop Loan For Raising The Crops, In Case
								of Medium Term Loan Being Applied.</td>
								<td colspan="2"><textarea name="txt_appexpenses" cols="70"
									rows="5" wrap="VIRTUAL" onkeypress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("applicant_arrangements"))%></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="2">Comments In Details And Recommendation Regarding
								Technicalfeasibility And Economical Viability of The Proposal
								And Other Informations</td>
								<td colspan="2"><textarea name="txt_comrecomd" cols="70"
									rows="5" wrap="VIRTUAL" onkeypress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("recommendation"))%></textarea>
								</td>
							</tr>
						</table>
					
				
				
						<table width="100%" cellpadding="3" cellspacing="0" border="0" class="outertable">
							<tr>
								<td width="27%"><b>The Details of Existing Limits </b></td>
								<td width="73%"><select name="sel_exilimit"
									onchange="showExistingLimit()">
									<option value="s" selected="selected">&lt;---Select---&gt;</option>
									<option value="y">YES</option>
									<option value="n">NO</option>
								</select></td>
							</tr>
							<tr>
								<td colspan="2">
								
                          <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                            <tr id="s1">
										<td width="16%">Select Reference No</td>
										<td colspan="2"><select name="sel_refno"
											onchange="changerefno()">
											<option value="0" selected="selected">--New--</option>
											<lapschoice:sancrefno  appno = '<%=strno%>' saral = '<%=strSaral%>'/>
										</select></td>
										<td width="18%">&nbsp;</td>
										<td width="7%">&nbsp;</td>
										<td width="6%">&nbsp;</td>
										<td width="22%">&nbsp;</td>
										<td width="18%">&nbsp;</td>
									</tr>
									<tr id="s2">
										<td width="16%">Sanction Reference No.<b><span class="mantatory">*</span></b></td>
										<td colspan="2"><input name="txt_sanctionrefno" type="text"
											size="10" maxlength="10"
											value="<%=Helper.correctNull((String)hshValues.get("sanction_ref_no"))%>"
											onkeypress="allowNumber(this)" /></td>
										<td width="18%">Date</td>
										<td width="7%"><input name="txt_sanctiondate" type="text"
											size="10"
											value="<%=Helper.correctNull((String)hshValues.get("sanction_date"))%>"
											onblur="checkDate(this)" /></td>
										<td width="6%"><a alt="Select date from calender" href="#"
											onclick="callCalender('txt_sanctiondate')"
											onmouseover="window.status='Date Picker';return true;"
											onmouseout="window.status='';return true;"><img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											border="0" alt="Select date from calender" /></a></td>
										<td width="22%">Amount Of Loan Sanctioned</td>
										<td width="18%"><lapschoice:CurrencyTag
											name="txt_loansanction" size="10" maxlength="9"
											value='<%=Helper.correctNull((String)hshValues.get("sanction_amount"))%>' />
										</td>
									</tr>
									<tr id="s3">
										<td width="16%">Purpose</td>
										<td colspan="2"><input name="txt_purpose" type="text"
											size="20" maxlength="30"
											onkeypress="notAllowSplChar()"
											value="<%=Helper.correctNull((String)hshValues.get("loan_purpose"))%>" />
										</td>
										<td width="18%">Sanctioning Authority</td>
										<td colspan="2"><input name="txt_sanctionautho" type="text"
											size="20" maxlength="30"
											onkeypress="notAllowSplChar()"
											value="<%=Helper.correctNull((String)hshValues.get("sanction_authority"))%>" />
										</td>
										<td width="22%">Loan Amount Disbursed</td>
										<td width="18%"><lapschoice:CurrencyTag name="txt_loanamount"
											size="10" maxlength="9"
											value='<%=Helper.correctNull((String)hshValues.get("disbursed_amount"))%>' />
										</td>
									</tr>
									<tr id="s4">
										<td width="16%">Date Of Disbursement</td>
										<td width="7%"><input name="txt_datedisbursed" type="text"
											size="10"
											value="<%=Helper.correctNull((String)hshValues.get("disbursement_date"))%>"
											onblur="checkDate(this)" /></td>
										<td width="6%"><a alt="Select date from calender" href="#"
											onclick="callCalender('txt_datedisbursed')"
											onmouseover="window.status='Date Picker';return true;"
											onmouseout="window.status='';return true;"><img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											border="0" alt="Select date from calender" /></a></td>
										<td width="18%">Amount Outstanding</td>
										<td colspan="2"><lapschoice:CurrencyTag
											name="txt_amountoutstanding" size="10" maxlength="9"
											value='<%=Helper.correctNull((String)hshValues.get("outstanding_amount"))%>' />
										</td>
										<td width="22%">Amount Overdue</td>
										<td width="18%"><lapschoice:CurrencyTag
											name="txt_amountoverdue" size="10" maxlength="9"
											value='<%=Helper.correctNull((String)hshValues.get("overdue_amount"))%>' />
										</td>
									</tr>
									
                            <tr id="s5" valign="top"> 
                              <td width="16%">Whether Account Is Regular ?</td>
										
                              <td colspan="2"> 
                                <select name="sel_accounttype"
											value="<%=Helper.correctNull((String)hshValues.get("regular_account"))%>">
											<option value="y" selected="selected">YES</option>
											<option value="n">NO</option>
										</select> If Not,</td>
										
                              <td width="18%">Give Details Of Irregularities</td>
										
                              <td colspan="2"> 
                                <textarea name="txt_detailirrgular" cols="35" rows="5" onkeypress="textlimit(this,199)" onKeyUp="textlimit(this,199)" maxlength="200"><%=Helper.correctNull((String)hshValues.get("irregular_details"))%></textarea> 
										</td>
										
                              <td width="22%">Whether All The Terms &amp; Conditions 
                                Stipulated In The Sanction Advice Have Been Complied 
                                With ?</td>
										
                              <td width="18%"> 
                                <select name="sel_accreg"
											value="<%=Helper.correctNull((String)hshValues.get("terms_cond_complied"))%>">
											<option value='y' selected="selected">YES</option>
											<option value='n'>NO</option>
										</select></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
</td>
</tr>
</table>						
				
	
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail_Print" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<!--<input type="hidden" name="comapp_id" value="" /> -->
<input type="hidden" name="hidAction1" /> 
<input type="hidden" name="hidvalue" /> 
<input type="hidden" name="hidsno" value=""/>
<input type="hidden" name="auditflag" value="<%=Helper.correctNull((String)hshValues.get("audit_flag"))%>">
<%if(strSaral.equals("saral")){ %>
	<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<%}else{ %>
<lapschoice:agrihiddentag pageid='<%=PageId%>'/> 
<%} %>
</form>

<script language="javascript1.2">
//editor_generate('txt_landparticulars');
//editor_generate('txt_watersource');
//editor_generate('txt_appliedamount');
//editor_generate('txt_detailscrops');
//editor_generate('txt_applicantasset');
//editor_generate('txt_liabilities');
//editor_generate('txt_appexpenses');
//editor_generate('txt_comrecomd');
if(parent.menuFrame && parent.mainFrame)
{
	if(parent.menuFrame.document.forms[0].applevel && parent.mainFrame.document.forms[0].applevel)
	{
		parent.mainFrame.document.forms[0].applevel.value=parent.menuFrame.document.forms[0].applevel.value;
	}
	if(parent.menuFrame.document.forms[0].btnenable && parent.mainFrame.document.forms[0].btnenable)
	{
		parent.mainFrame.document.forms[0].btnenable.value=parent.menuFrame.document.forms[0].btnenable.value;
	}
}

if(document.forms[0].btnenable && document.forms[0].btnenable.value=="N")
{//For the users, in the application created organisation other than SARAL throgh link
	enableButtons(true,true,true,true,false);
}


//If access through the Loan Application Register and its at Branch 
if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
	//If the Application is in open status
	if("<%=strstatus%>"=="O"  &&  varright=="w"){
	    enableButtons(false,true,true,false,true);
	}else{
		enableButtons(true,true,true,true,true);	
	}
		
}else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
	
	enableButtons(true,true,true,true,true,true);
		
}else{
	
	//Access through Branch Users
	if("<%=strapplevel%>" == "S"){
		enableButtons(true,true,true,true,true);
	}
}
</script>
</body>
</html>

