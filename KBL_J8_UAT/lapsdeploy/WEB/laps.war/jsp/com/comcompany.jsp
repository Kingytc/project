<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
if (objValues instanceof java.util.HashMap) {
	hshValues = (java.util.HashMap) objValues;
}
request.setAttribute("scode", "yyy");
%>
<html>
<head>
<title>Customer Profile</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var Apporg_name = "<%=Helper.correctNull((String)hshValues.get("Apporg_name"))%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
var varappstatus="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var id="<%=hshValues.get("comapp_id")%>";
var cmpid="<%=hshValues.get("comapp_companyid")%>";
  var busnature="<%=Helper.correctNull((String)hshValues.get("comapp_businessnature"))%>";
  var corpstruct="<%=Helper.correctNull((String)hshValues.get("comapp_corpstructure"))%>";
  var cmprole="<%=Helper.correctNull((String)hshValues.get("comapp_companyrole"))%>";
  var yrinbus="<%=Helper.correctNull((String)hshValues.get("comapp_yrsinbusiness"))%>";
  var varcomappscode="<%=Helper.correctNull((String)hshValues.get("comapp_scode"))%>";
  var varcompanystatus="<%=Helper.correctNull((String)hshValues.get("company_status"))%>";
  var varcompanystaff="<%=Helper.correctNull((String)hshValues.get("company_staff"))%>";  
  if(yrinbus=="01/01/1900")
  {
  yrinbus="";
  } 
  var owner="<%=Helper.correctNull((String)hshValues.get("comapp_ownership"))%>";
  var totemp="<%=Helper.correctNull((String)hshValues.get("comapp_totemployees"))%>";
  var contact="<%=Helper.correctNull((String)hshValues.get("comapp_contact"))%>";
  var email="<%=Helper.correctNull((String)hshValues.get("comapp_email"))%>";
  var group = "<%=Helper.correctNull((String)hshValues.get("comapp_group"))%>";
  var prem1 = "<%=Helper.correctNull((String)hshValues.get("comapp_corppremises"))%>";
  var prem3 = "<%=Helper.correctNull((String)hshValues.get("comapp_regpremises"))%>";
  var regaddr1="<%=Helper.replaceForJavaScriptString((String)hshValues.get("comapp_regadd1"))%>";
  var regaddr2="<%=Helper.replaceForJavaScriptString((String)hshValues.get("comapp_regadd2"))%>";
  var regcity="<%=Helper.correctNull((String)hshValues.get("comapp_regcity"))%>";
  var regstate="<%=Helper.correctNull((String)hshValues.get("comapp_regstate"))%>";
  var regphone="<%=Helper.correctNull((String)hshValues.get("comapp_regphone"))%>";
  var regfax="<%=Helper.correctNull((String)hshValues.get("comapp_regfax"))%>";
  var regpin="<%=Helper.correctNull((String)hshValues.get("comapp_regpin"))%>";
  var regdealing="<%=Helper.correctNull((String)hshValues.get("comapp_regdeal"))%>";
  var comapp_indcode="<%=Helper.correctNull((String)hshValues.get("comapp_indcode"))%>";
  var comapp_commtype="<%=Helper.correctNull((String)hshValues.get("comapp_commtype"))%>";
  if (comapp_commtype=="")
  {
	  var comapp_commtype="<%=Helper.correctNull((String)hshValues.get("comapp_comtype"))%>";
  }  
var industry ="<%=Helper.correctNull((String)hshValues.get("scale"))%>";
var admadd2="<%=Helper.replaceForJavaScriptString((String)hshValues.get("comapp_admadd2"))%>";
var admphone="<%=Helper.correctNull((String)hshValues.get("comapp_admphone"))%>";
var admfax="<%=Helper.correctNull((String)hshValues.get("comapp_admfax"))%>";
var admpin="<%=Helper.correctNull((String)hshValues.get("comapp_admpin"))%>";
var capi="<%=Helper.correctNull((String)hshValues.get("auth_captial"))%>";
var capitotal = capi;
var varinland="<%=Helper.correctNull((String)hshValues.get("company_inland"))%>";
var title="<%=Helper.correctNull((String)hshValues.get("company_introtitle"))%>";
var subcap="<%=Helper.correctNull((String)hshValues.get("comapp_subcapital"))%>";
var smetype="<%=Helper.correctNull((String)hshValues.get("comapp_smetype"))%>";
var varpubtype="<%=Helper.correctNull((String)hshValues.get("comapp_pubtype"))%>";

function callRelationship()
{
	var existing="e";
	var exist;
	var varQryString = appURL+"action/perrelationship.jsp?hidBeanGetMethod=getreldetails&hidBeanId=commappmaster&comapp_id="+document.forms[0].comapp_id.value+"&exist="+existing;
	var title = "RelationshipDetails";
	var prop = "scrollbars=yes,width=900,height=550";
	prop = prop + ",left=50,top=150";
    window.open(varQryString,title,prop);	
}
function dorocdetails()
{
	var varQryString = appURL+"action/rocdetails.jsp?hidBeanGetMethod=getrocdetails&hidBeanId=commappmaster&exist=e&comapp_id="+document.forms[0].comapp_id.value;
	var title = "ROCDetails";
	var prop = "scrollbars=yes,menubar=yes,width=900,height=550";
	prop = prop + ",left=50,top=150";
    window.open(varQryString,title,prop);	
}
function disall()
{
	buttonDisabled(true,true,true,true,false);
	disableFields(true);
}
function buttonDisabled(val1,val2,val3,val4,val5)
{
	document.forms[0].cmdedit.disabled=val1;
	document.forms[0].cmdsave.disabled=val2;
	document.forms[0].cmdcancel.disabled=val3;
    document.forms[0].cmddelete.disabled=val4;
	document.forms[0].cmdclose.disabled=val5;   
}

function doFactoryDetails()
{
	var existing="e";
	var exist;
	var varQryString = appURL+"action/comappFactoryDetailsExt.jsp?hidBeanGetMethod=getFactoryDetails&hidBeanId=commappmaster&comapp_id="+document.forms[0].comapp_id.value+"&exist="+existing;
	var title = "IndustrialDetails";
	var prop = "scrollbars=yes,width=900,height=550";
	prop = prop + ",left=50,top=150";
	window.open(varQryString,title,prop);	
}
function doDivisionDetails()
{
	var existing="e";
	var exist;
	var varQryString = appURL+"action/comappdivisionExt.jsp?hidBeanGetMethod=getDivisionDetails&hidBeanId=commappmaster&comapp_id="+document.forms[0].comapp_id.value+"&exist="+existing;
	var title = "DivisionDetails";
	var prop = "scrollbars=yes,width=900,height=550";
	prop = prop + ",left=50,top=150";
    window.open(varQryString,title,prop);	
}
function callApplicantTab(page)
{
	if(page=="facilities")
	{
		document.forms[0].hidBeanMethod.value="getFacilityData";
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/facilities.jsp";
	}	  
	if(page=="proposal")
	{
		document.forms[0].hidBeanGetMethod.value="getProposal";
		document.forms[0].action=appUrl+"action/comproposal.jsp";
	}
	document.forms[0].submit();
} 
function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
        document.forms[0].hidBeanId.value="";
	    document.forms[0].action=appURL+"action/"+"corppge.jsp";	
		document.forms[0].submit();
	}
}
function callsubnbfc()
{
	var subnbfc1="<%= Helper.correctNull((String)hshValues.get("comapp_subnbfc"))%>";
	
	if(subnbfc1=="DT")
	{
	document.forms[0].subnbfc.value="DT"
	}
	else if(subnbfc1=="NDT")
	{
	document.forms[0].subnbfc.value="NDT"
	}
	else if(subnbfc1=="S")
	{
	document.forms[0].subnbfc.value="S";
	}
} 
function placeValues()
{
	if(id=="null")
	{
		document.forms[0].comapp_id.value="New";
		document.forms[0].comapp_id.readOnly=true;
		document.forms[0].comapp_orgname.readOnly=true;
		document.forms[0].comapp_scode.readOnly=true;
		document.forms[0].comapp_regcountry.readOnly=true;
		buttonDisabled(true,false,true,true,true,false,true,true)
		document.forms[0].cmd_reldet.disabled = true;
		document.forms[0].ramdetails.disabled=true;
		varcomappscode = "<%=(String)session.getAttribute("strOrgShortCode")%>";
		document.forms[0].comapp_scode.value=varcomappscode;
		document.forms[0].sel_status.value="999";
		return;
	}
	document.forms[0].comapp_id.value=id;
	document.forms[0].comapp_commtype.value=comapp_commtype;
	document.forms[0].comapp_companyid.value=cmpid;
	document.forms[0].comapp_businessnature.value=busnature;
	document.forms[0].comapp_corpstructure.value=corpstruct;
	document.forms[0].comapp_companyrole.value=cmprole;
	document.forms[0].comapp_yrsinbusiness.value=yrinbus;
	document.forms[0].comapp_ownership.value=owner;
	document.forms[0].comapp_totemployees.value=totemp;
	document.forms[0].comapp_contact.value=contact;
	document.forms[0].comapp_email.value=email;
	document.forms[0].comapp_group.value=group;
	document.forms[0].comapp_corppremises.value=prem1;
	document.forms[0].comapp_regpremises.value=prem3;
	document.forms[0].comapp_regadd1.value=regaddr1;
	document.forms[0].comapp_regadd2.value=regaddr2;
	document.forms[0].comapp_regphone.value=regphone;
	document.forms[0].comapp_regfax.value=regfax;
	document.forms[0].comapp_regpin.value=regpin;
	document.forms[0].comapp_dealing.value=regdealing;
	document.forms[0].comapp_indcode.value=comapp_indcode;
	document.forms[0].scale.value=industry;
	document.forms[0].comapp_admadd2.value=admadd2;
	document.forms[0].comapp_admphone.value=admphone;
	document.forms[0].comapp_admfax.value=admfax;
	document.forms[0].comapp_admpin.value=admpin;	
	if(varcomappscode!="")
	{
		document.forms[0].comapp_scode.value=varcomappscode;
	}
	else
	{
		document.forms[0].comapp_scode.value="s";
	}
	if(varcompanystatus!="")
	{
		document.forms[0].sel_status.value=varcompanystatus;
	}
	else
	{
		document.forms[0].sel_status.value="0";
	}
	if(varcompanystaff!="")
	{
		document.forms[0].sel_staff.value=varcompanystaff;
	}
	else
	{
		document.forms[0].sel_staff.value="2";
	}
	if(varinland!="")
	{
		document.forms[0].sel_inland.value=varinland;
	}
	else
	{
		document.forms[0].sel_inland.value="2";
	}
	if(title!="")
	{
		document.forms[0].txt_ititle.value=title;
	}
	else
	{
		document.forms[0].txt_ititle.value="MR";
	}
	if(smetype!="")
	{
		document.forms[0].comapp_smetype.value=smetype;
	}
	else
	{
		document.forms[0].comapp_smetype.value="0";
	}
	if(varpubtype!="")
	{
		document.forms[0].sel_pubtype.value=varpubtype;
	}
	else
	{
		document.forms[0].sel_pubtype.value="S";
	}
	disableFields(true);
	document.forms[0].comapp_regstate.disabled=true;
	
	if(varappstatus=="true")
	{
		alert("Cannot Modify the Profile since application has been approved or rejected");
		buttonDisabled(true,true,true,true,false,false,false,false);
	}
	else
	{
		buttonDisabled(false,true,true,true,true,false,false,false);
	}
	callsubnbfc();
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=="text") 
		{
			document.forms[0].elements[i].readOnly=val;
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;
		}
	}
	document.forms[0].comapp_companyid.readOnly=true;
	document.forms[0].comapp_orgname.readOnly=true;
	document.forms[0].comapp_scode.readOnly=true;
}
function callnbfc()
{
	if(document.forms[0].comapp_ownership.value=="nbfc")
	{
		document.all.od1.style.visibility="visible";
	 	document.all.od2.style.visibility="visible";
	 	document.all.od3.style.visibility="visible";
		document.all.od4.style.visibility="visible";
	}
	else
	{
		document.all.od1.style.visibility="hidden";
		document.all.od2.style.visibility="hidden";
		document.all.od3.style.visibility="hidden";
		document.all.od4.style.visibility="hidden";
	}
		
	if(document.forms[0].comapp_ownership.value=="OLP")
	{
		document.all.pub1.style.visibility="hidden";
		document.all.pub2.style.visibility="hidden";
		document.forms[0].sel_pubtype.value="S";
	}
	else if(document.forms[0].comapp_ownership.value=="OCC")
	{
		document.all.pub1.style.visibility="visible";
		document.all.pub2.style.visibility="visible";
	}
	else
	{
		document.all.pub1.style.visibility="hidden";
		document.all.pub2.style.visibility="hidden";
		document.forms[0].sel_pubtype.value="S";
		
	}
}
</script>
</head>
<body  onload="placeValues();disall();callnbfc();">
<form name="appform" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colSpan=5> <jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<%if(strCategoryType.equalsIgnoreCase("SRE")){%>
	<tr>
		<td class=page_flow>Home -&gt;Corporate &amp; SME -&gt; Short Review/Extension  -&gt; Applicant-&gt;  Customer Profile</td>
	</tr>
	<%}else if(strCategoryType.equalsIgnoreCase("STL")){ %>
	<tr>
		<td class=page_flow>Home -&gt;Corporate &amp; SME -&gt; Short Term Loan  -&gt; Applicant-&gt;  Customer Profile</td>
	</tr>
	<%}else if(strCategoryType.equalsIgnoreCase("ADC")){ %>
	<tr>
		<td class=page_flow>Home -&gt; Corporate &amp; SME -&gt; Ad hoc Limit -&gt; Applicant -&gt;  Customer Profile</td>
	</tr>
	<%}else{%>
	<tr>
		<td class=page_flow>Home -&gt; Corporate &amp; SME -&gt;Application -&gt; Applicant -&gt; Customer Profile</td>
	</tr>
	<%} %>
</table>
<span style="display:none;"><lapschoice:borrowertype /></span><lapschoice:application />
<lapstab:ComfacilityTab tabid="2"/>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td height="260">
				<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td>								
									  <table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
                            <tr> 
                              <td width="17%"> 
                                <input type="hidden" name="comapp_id" size="20" maxlength="23">
                                Corporate Type <span
											class="mantatory"><b>*</b> </span></td>
                              <td width="23%"> 
                                <select name="comapp_commtype" tabindex="1"
											onchange="showSME()">
                                  <option Selected value="">--Select--</option>
                                  <option value="CORP">Corporate</option>
                                  <option value="SME">SME</option>
                                </select>
                              </td>
                              <td width="15%" id="sme">SME Type<span class="mantatory"><b>*</b></span></td>
                              <td colspan="3" id="smetype"> 
                                <select name="comapp_smetype"
											tabindex="2">
                                  <option Selected value="0">--Select--</option>
                                  <option value="1">Micro</option>
                                  <option value="2">Small</option>
                                  <option value="3">Medium</option>
                                </select>
                              </td>
                            </tr>
                            <tr> 
                              <td width="17%">Company Name <span class="mantatory"><b>*</b></span></td>
                              <td colspan="5"> 
                                <input type="text" name="comapp_companyname"
											size="80" maxlength="80" style=border-style=groove
											value="<%=Helper.correctNull((String)hshValues.get("comapp_companyname"))%>"
											onKeyPress="notAllowedDouble()" tabindex="3">
                              </td>
                            </tr>
                            <tr> 
                              <td width="17%">Industry BSR Code<span class="mantatory"><b>*</b></span></td>
                              <td colspan="5"> 
                                <input type="hidden" name="comapp_indcode"
											size="20" maxlength="23"
											style=text-align:left;border-style=groove value="">
                                <input
											type="text" name="comapp_companyid" size="80" maxlength="125"
											style=text-align:left;border-style=groove
											onKeyPress="notAllowedDouble();notAllowSpace()"
											onBlur="checkId()" tabindex="7" readOnly>
                              </td>
                            </tr>
                            <tr> 
                              <td width="17%"><span class="mantatory"><b>CBS Customer 
                                ID</b></span></td>
                              <td width="23%"> 
                                <input type="text" name="comapp_cbsid"
											size="12" maxlength="10"
											style=text-align:left;border-style=groove
											onKeyPress="allowInteger(this)"
											value="<%=Helper.correctNull((String)hshValues.get("cbs_companycode"))%>"
											tabindex="4">
                              </td>
                              <td width="17%"><b><font color="#0000FF">IRB Company 
                                Code</font></b></td>
                              <td colspan="3"> 
                                <input type="text" name="txt_irbcode"
											size="16" maxlength="14" onKeyPress="allowInteger(this)"
											value="<%=Helper.correctNull((String)hshValues.get("comapp_irbid"))%>">
                              </td>
                            </tr>
                            <tr> 
                              <td width="17%">Line of Activity <span class="mantatory"><b>*</b></span></td>
                              <td width="23%"> 
                                <input type="text"
											name="comapp_businessnature" size="30" maxlength="125"
											style=text-align:left;border-style=groove
											onKeyPress="notAllowedDouble()" tabindex="5">
                              </td>
                              <td width="17%">PAN Number <span class="mantatory">*</span></td>
                              <td colspan="3"> 
                                <input type="text" name="comapp_corpstructure"
											size="15" maxlength="10"
											style=text-align:left;border-style=groove
											onKeyPress="allowAlphaNumeric()" onBlur="checkpanno(this)"
											tabindex="8">
                              </td>
                            </tr>
                            <tr> 
                              <td width="17%">ROC Number</td>
                              <td width="23%"> 
                                <input type="text" name="comapp_companyrole"
											size="30" maxlength="30"
											style=text-align:left;border-style=groove
											onKeyPress="notAllowedDouble()" tabindex="9">
                              </td>
                              <td width="17%">Date of Incorporation</td>
                              <td colspan="3"> 
                                <table class="outertable">
                                  <tr> 
                                    <td> 
                                      <input type="text" name="comapp_yrsinbusiness" size="12"
													maxlength="10" style=text-align:left;border-style=groove
													onBlur="checkDate(this);checkmaxdate(this,currentDate)"
													tabindex="10">
                                      </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr> 
                              <td width="17%">Total Employees</td>
                              <td width="23%"> 
                                <input type="text" name="comapp_totemployees"
											size="7" maxlength="10"
											style=text-align:left;border-style=groove
											onKeyPress="allowInteger(this);" tabindex="11">
                              </td>
                              <td width="17%">Type of Ownership<span class="mantatory"><b>*</b></span></td>
                              <td> 
                                <select name="comapp_ownership" tabindex="12"
											onChange="callnbfc()">
                                  <option Selected value="">---Select---</option>
                                  <option value="OO">Others</option>
                                  <option value="IN">Individual</option>
                                  <option value="OLP">Private Limited Company</option>
                                  <option value="OCC">Public Limited Company</option>
                                  <option value="OP">Partnership</option>
                                  <option value="OLC">Joint Borrowers</option>
                                  <option value="OS">Sole Proprietor</option>
                                  <option value="Jo">Joint Venture</option>
                                  <option value="sub">Wholly owned subsidiary</option>
                                  <option value="TR">Trusts</option>
                                  <option value="nbfc">NBFC</option>
                                  <option value="HUF">H.U.F</option>
                                </select>
                              </td>
                              <td id="pub1">Type</td>
                              <td id="pub2"> 
                                <select name="sel_pubtype">
                                  <option value="S" selected>&lt;---Select---&gt;</option>
                                  <option value="C">Closely Held</option>
                                  <option value="W">Widely Held</option>
                                </select>
                              </td>
                            </tr>
                            <tr> 
                              <td width="17%">Group</td>
                              <td width="23%"> 
                                <input type="text" name="comapp_group"
											size="30" maxlength="20"
											style=text-align:left;border-style=groove onKeyPress=""
											readOnly value="" tabindex="15">
                               </td>
                              <td width="17%" id="od1">RBI No.</td>
                              <td id="od2"> 
                                <input type="text" name="txt_rbino"
											size="20"
											value="<%=Helper.correctNull((String)hshValues.get("comapp_rbino"))%>"
											tabindex="13">
                              </td>
                              <td id="od4">Sub Categories of NBFC</td>
                              <td id="od3"> 
                                <select name="subnbfc" tabindex="14">
                                  <option selected value="S">------------select---------------</option>
                                  <option value="DT">Deposit taking</option>
                                  <option value="NDT">Non Deposit taking</option>
                                </select>
                              </td>
                            </tr>
                            <tr> 
                              <td width="17%">Banking Since</td>
                              <td width="23%"> 
                                <input type="text" name="comapp_dealing"
											onKeyPress="notAllowedDouble()" size="30" maxlength="30"
											onBlur="" tabindex="16">
                              </td>
                              <td width="17%">Contact Name</td>
                              <td colspan="3"> 
                                <input type="text"
											name="comapp_contact" size="40" maxlength="50"
											style=text-align:left;border-style=groove
											onKeyPress="notAllowedDouble()" tabindex="6">
                              </td>
                            </tr>
                            <tr> 
                              <td width="17%" >Industry Type</td>
                              <td width="23%" > 
                                <select name="scale" tabindex="18">
                                  <option value="0" selected>----Select----</option>
                                  <option value="1">Services</option>
                                  <option value="2">Exports</option>
                                  <option value="3">Agriculture</option>
                                  <option value="4">Infrastructure</option>
                                  <option value="Trading">Trading</option>
                                  <option value="Manufacturing">Manufacturing</option>
                                </select>
                              </td>
                              <td nowrap  width="17%">Email Address</td>
                              <td colspan="4" > 
                                <input type="text" name="comapp_email"
											size="30" maxlength="30"
											style=text-align:left;border-style=groove
											onKeyPress="notAllowedDouble()"
											onBlur="isEmailAddr(document.forms[0].comapp_email.value,document.forms[0].comapp_email)"
											tabindex="17">
                              </td>
                            </tr>
                            <tr> 
                              <td width="17%" >Application Recd. From <b><span class="mantatory">*</span></b></td>
                              <td colspan="6" > 
                                <input type="hidden" name="comapp_scode"
											tabindex="13" style="width:200">
                                <input type="text"
											name="comapp_orgname" size="55"
											value="<%=Helper.correctNull((String)hshValues.get("comapp_orgname"))%>">
                              </td>
                            </tr>
                          </table>
								</td>
							</tr>

							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td height="25" colspan="2"><b>Registered Office Address</b></td>
										<td height="25" colspan="2"><b>Corporate Address</b></td>
										<td height="25" colspan="2"><b>Administrative office address </b></td>
									</tr>
									<tr>
										<td align="left" valign="top" width="10%">Address<span
											class="mantatory"><b>*</b></span></td>
										<td align="left" valign="top" width="24%"><b> <input
											type="text" name="comapp_regadd1" size="30" maxlength="200"
											tabindex="34"> </b></td>
										<td align="left" valign="top" width="10%">Address</td>
										<td align="left" valign="top" width="23%"><input type="text"
											name="comapp_crptaddress1" size="30" maxlength="50"
											style=border-style=groove onKeyPress="notAllowedDouble()"
											value="<%=Helper.correctDoubleQuotesHtml((String)hshValues.get("comapp_crptaddress1"))%>"
											tabindex="17"></td>
										<td align="left" width="10%">Address</td>
										<td width="23%"><input type="text" name="comapp_admadd1"
											size="30" maxlength="200" tabindex="42"
											value="<%=Helper.correctDoubleQuotesHtml((String)hshValues.get("comapp_admadd1"))%>">
										</td>
									</tr>
									<tr>
										<td align="left" valign="top" width="10%">&nbsp;</td>
										<td align="left" valign="top" width="24%"><input type="text"
											name="comapp_regadd2" size="30" maxlength="200" tabindex="35">
										</td>
										<td align="left" valign="top" width="10%">&nbsp;</td>
										<td align="left" valign="top" width="23%"><input type="text"
											name="comapp_crptaddress2" size="30" maxlength="50"
											style=border-style=groove onKeyPress="notAllowedDouble()"
											tabindex="18"
											value="<%=Helper.correctDoubleQuotesHtml((String)hshValues.get("comapp_crptaddress2"))%>">
										</td>
										<td align="left" width="10%">&nbsp;</td>
										<td width="23%"><input type="text" name="comapp_admadd2"
											size="30" maxlength="200" tabindex="43"></td>
									</tr>
									<tr>
										<td align="left" valign="top" width="10%">City<span
											class="mantatory"><b>*</b></span></td>
										<td align="left" valign="top" width="24%"><input type="text"
											name="comapp_regcity" size="30" maxlength="30" tabindex="36"
											onKeyPress="notAllowSplChar()"
											value="<%=Helper.correctNull((String)hshValues.get("comapp_regcity"))%>"
											readOnly></td>
										<td align="left" valign="top" width="10%">City</td>
										<td align="left" valign="top" width="23%"><input type="text"
											name="comapp_crptcity" size="30" maxlength="30"
											style=text-align:left;border-style=groove
											onKeyPress="notAllowSplChar()" tabindex="19"
											value="<%=Helper.correctNull((String)hshValues.get("comapp_crptcity"))%>">
										</td>
										<td align="left" width="10%">City</td>
										<td width="23%"><input type="text" name="comapp_admcity"
											size="30" maxlength="30" tabindex="44"
											onKeyPress="notAllowSplChar()"
											value="<%=Helper.correctNull((String)hshValues.get("hidcity4"))%>">
										</td>
									</tr>
									<tr>
										<td align="left" valign="top" width="10%">State</td>
										<TD align="left" valign="top" width="24%"><input type="text"
											name="comapp_regstate" style="width:160"
											value="<%=Helper.correctNull((String)hshValues.get("comapp_regstate"))%>"
											tabindex="38" readOnly></td>
										<TD align="left" valign="top" width="10%">State</td>
										<TD align="left" valign="top" width="23%"><input type="text"
											name="comapp_crptstate" size="30"
											style=text-align:left;border-style=groove
											onKeyPress="notAllowedDouble()" tabindex="20" maxlength="50"
											value="<%=Helper.correctNull((String)hshValues.get("comapp_crptstate"))%>">
										</td>
										<td width="10%" align="left">State</td>
										<td width="23%"><input type="text" name="comapp_admstate"
											style="width:160" onClick="" tabindex="46"
											value="<%=Helper.correctNull((String)hshValues.get("hidstate4"))%>">
										</td>
									</tr>
									<tr>
										<td align="left" valign="top" width="10%"><%=ApplicationParams.getZipName()%><span
											class="mantatory"><b>*</b></span></td>
										<td align="left" valign="top" width="24%"><input type="text"
											name="comapp_regpin" size="12"
											maxlength="<%=ApplicationParams.getZipValue()%>"
											onKeyPress="allowInteger()" tabindex="39"
											onBlur="zipvalidate(this,'<%=ApplicationParams.getZipValue()%>')">
										</td>
										<td align="left" valign="top" width="10%"><%=ApplicationParams.getZipName()%></td>
										<td align="left" valign="top" width="23%"><input type="text"
											name="comapp_crptpin" size="12"
											maxlength="<%=ApplicationParams.getZipValue()%>"
											style=text-align:left;border-style=groove
											onKeyPress="allowInteger();"
											onBlur="zipvalidate(this,'<%=ApplicationParams.getZipValue()%>');"
											value="<%=Helper.correctNull((String)hshValues.get("comapp_crptpin"))%>"
											tabindex="23"></td>
										<td align="left" width="10%"><%=ApplicationParams.getZipName()%></td>
										<td width="23%"><input type="text" name="comapp_admpin"
											size="12" maxlength="<%=ApplicationParams.getZipValue()%>"
											onKeyPress="allowInteger()" tabindex="47"
											onBlur="zipvalidate(this,'<%=ApplicationParams.getZipValue()%>')">
										</td>
									</tr>
									<tr>
										<td align="left" valign="top" width="10%">Country</td>
										<td align="left" valign="top" width="24%"><input type="text"
											name="comapp_regcountry"
											value="<%=Helper.correctNull((String)hshValues.get("regcountrydesc"))%>"
											size="30" maxlength="20" tabindex="40"
											onKeyPress="notAllowSplChar();notallowInteger()"> <input
											type="hidden" name="comapp_hidregcountry"
											value="<%=Helper.correctNull((String)hshValues.get("comapp_regcountry"))%>">
										</td>
										<td align="left" valign="top" width="10%">&nbsp;</td>
										<td align="left" valign="top" width="23%">&nbsp;</td>
										<td align="left" width="10%">&nbsp;</td>
										<td width="23%">&nbsp;</td>
									</tr>
									<tr>
										<td align="left" valign="top" width="10%">Phone No.</td>
										<td align="left" valign="top" width="24%"><input type="text"
											name="comapp_regphone" onKeyPress="allowPhone()" size="25"
											maxlength="20" tabindex="40"></td>
										<td align="left" valign="top" width="10%">Phone No.</td>
										<td align="left" valign="top" width="23%"><input type="text"
											name="comapp_crptphone" size="25" maxlength="20"
											value="<%=Helper.correctNull((String)hshValues.get("comapp_crptphone"))%>"
											onKeyPress="allowPhone()" tabindex="24"></td>
										<td align="left" width="10%">Phone No.</td>
										<td width="23%"><input type="text" name="comapp_admphone"
											size="25" maxlength="20" onKeyPress="allowPhone()"
											tabindex="48"></td>
									</tr>
									<tr>
										<td align="left" valign="top" width="10%">Fax No</td>
										<td align="left" valign="top" width="24%"><input type="text"
											name="comapp_regfax" onKeyPress="notAllowedDouble()"
											size="30" maxlength="20" tabindex="41"></td>
										<td align="left" valign="top" width="10%">Fax No.</td>
										<td align="left" valign="top" width="23%"><input type="text"
											name="comapp_crptfax" size="30" maxlength="20"
											value="<%=Helper.correctNull((String)hshValues.get("comapp_crptfax"))%>"
											onKeyPress="notAllowedDouble()" tabindex="25"></td>
										<td align="left" width="10%">Fax No.</td>
										<td width="23%"><input type="text" name="comapp_admfax"
											size="30" maxlength="20" onKeyPress="notAllowedDouble()"
											tabindex="49"></td>
									</tr>
									<tr>
										<td align="left" valign="top" width="10%">Premises</td>
										<td align="left" valign="top" width="24%"><select
											name="comapp_regpremises" tabindex="37">
											<option value="0" selected>----Select----</option>
											<option value="1">Owned</option>
											<option value="2">Leased</option>
											<option value="3">Rented</option>
										</select></td>
										<td align="left" valign="top" width="10%">Premises</td>
										<td align="left" valign="top" width="23%"><select
											name="comapp_corppremises" tabindex="21">
											<option value="0" selected>--Select--</option>
											<option value="1">Owned</option>
											<option value="2">Leased</option>
											<option value="3">Rented</option>
										</select></td>
										<td align="left" width="10%">&nbsp;</td>
										<td width="23%">&nbsp;</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td>
								
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                            <tr> 
                              <td colspan="5"><b> CBS Data </b></td>
                            </tr>
                            <tr align="left"> 
                              <td align="left">Introducer Title</td>
                              <td> 
                                <select name="txt_ititle">
                                  <option value="MR" selected>Mr.</option>
                                  <option value="MS">Ms.</option>
                                  <option value="MRS">Mrs.</option>
                                  <option value="M/S">M/s.</option>
                                </select>
                              </td>
                              <td width="20%">Introducer Name</td>
                              <td width="27%"> 
                                <input type="text" name="txt_introname" size="30"
											maxlength="30"
											value="<%=Helper.correctNull((String)hshValues.get("company_introname"))%>">
                                <input type="hidden" name="hid_introname">
                              </td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr align="left"> 
                              <td> Trade Finance <span class="mantatory"><b>*</b></span></td>
                              <td> 
                                <select name="sel_staff" onChange="showIEC()">
                                  <option Selected value="">--Select--</option>
                                  <option value="Y">Yes</option>
                                  <option value="N">No</option>
                                </select>
                              </td>
                              <td width="20%">Status </td>
                              <td > 
                                <select name="sel_status">
                                  <option value="0">--Select--</option>
                                  <%String apptype = "26";			%>
                                  <lapschoice:StaticDataNewTag apptype='<%=apptype%>' /> 
                                </select>
                              </td>
                            </tr>
                            <tr align="left" id="iec"> 
                              <td> IEC Code <span class="mantatory"><b>*</b></span></td>
                              <td> 
                                <input type="text" name="txt_ieccode" size="25"
											maxlength="20"
											value="<%=Helper.correctNull((String)hshValues.get("comapp_ieccode"))%>">
                              </td>
                              <td width="20%">&nbsp;</td>
                              <td >&nbsp;</td>
                            </tr>
                            <tr align="left"> 
                              <td> If Trade Finance yes Inland trade allowed</td>
                              <td> 
                                <select name="sel_inland">
                                  <option value="Y">Yes</option>
                                  <option value="N" selected>No</option>
                                </select>
                              </td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
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
		<table width="60%" cellpadding="0" cellspacing="0" border="0" class="outertable border1" align="center">
		<TR ALIGN="center"> 
                                <TD> 
		<table width="100%" cellpadding="3" cellspacing="1" border="0" class="outertable">
		<TR ALIGN="center"> 
                                <TD> 
                                    <INPUT TYPE="button" NAME="FactoryDetails"	VALUE="Factory/ Branches/ Godowns Details/ Sales depots/Outlets"
											 CLASS="buttonOthers" ONCLICK="doFactoryDetails()"></td>
                                  <td>  <INPUT TYPE="button" NAME="DivisonDetails"	VALUE="Division Details"
											CLASS="buttonOthers" ONCLICK="doDivisionDetails()"></td>
                                    <td><INPUT TYPE="button" NAME="cmd_reldet" VALUE="Relationship Details"
											 CLASS="buttonOthers" ONCLICK="callRelationship()">
                                </TD>
        </TR>
        </table>
        </TD>
        </TR>
        </table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="otherGenTable" value="">
<input type="hidden" name="scode" value="yy">
	</form>
</body>
</html>
