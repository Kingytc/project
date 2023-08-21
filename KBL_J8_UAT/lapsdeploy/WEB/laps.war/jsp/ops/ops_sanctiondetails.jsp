<%@ page import="com.sai.laps.helper.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<laps:handleerror />
<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}

			String Flag = Helper.correctNull((String) hshValues.get("Flag"));
			String FacilityID = "";
			FacilityID = Helper.correctNull((String) hshValues
					.get("facility_id"));
			if (FacilityID.equalsIgnoreCase("")) {
				FacilityID = "0";
			}

			String LoanFrequency = Helper.correctNull((String) hshValues
					.get("cbs_loan_frequency"));
			String NatureOfAdvance = Helper.correctNull((String) hshValues
					.get("cbs_natureof_advance"));
			String SanctionLevel = Helper.correctNull((String) hshValues
					.get("cbs_sanction_level"));
			String SanctionAuthority = Helper.correctNull((String) hshValues
					.get("cbs_sanction_authority"));
			String PaymentMethod = Helper.correctNull((String) hshValues
					.get("cbs_payment_method"));
			String SENT_FLAG = Helper.correctNull((String) hshValues
					.get("SENT_FLAG"));
			String checkData = Helper.correctNull((String) hshValues
					.get("checkData"));
			String app_check = Helper.correctNull((String) hshValues
					.get("app_check"));
			String borrowercategory = Helper.correctNull((String) hshValues
					.get("borrowercat"));
			String advancemode = Helper.correctNull((String) hshValues
					.get("advmode"));
			String advancetype = Helper.correctNull((String) hshValues
					.get("advtype"));
			String industrytype = Helper.correctNull((String) hshValues
					.get("indtype"));

			%>

<html>

<head>
<title>Tertiary Sanction Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>

<script type="text/javascript">
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var Facility_ID = "<%=FacilityID%>";
var Flag = "<%=Flag%>";
var sysdate="<%=Helper.getCurrentDateTime()%>";
var CBSFlag = "<%=SENT_FLAG%>";
var checkData = "<%=checkData%>";
var appstatus ="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>";
var app_check ="<%=app_check%>";
var varseltaxslab="<%=Helper.correctNull((String)hshValues.get("sel_taxslab"))%>";

var varsectorcode="<%=Helper.correctNull((String)hshValues.get("sel_sector_code"))%>";
var varsubsectorcode="<%=Helper.correctNull((String)hshValues.get("sel_subsector_code"))%>";
var varpurposeofadvance="<%=Helper.correctNull((String)hshValues.get("sel_purposeof_advance"))%>";
var varoperationmode="<%=Helper.correctNull((String)hshValues.get("sel_operation_mode"))%>";

function callDescHelp(id)
{	
	if(document.forms[0].cmdedit.disabled &&  document.forms[0].readFlag.value.toUpperCase()=="W")
	{
		var varQryString = appUrl+"action/ops_sanctionhelp.jsp?id="+id+"&pannocheck="+document.forms[0].hidTaxSlab.value+"&hidBeanId=additionalParameter&hidBeanGetMethod=getSearch";;
		var title = "CBS_DATAS_HELP";
		var prop = "scrollbars=no,width=650,height=400";	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);	
	}
}

function checkRating()
{
	if(CBSFlag=='true')
	{
		alert("Sanction Details has been sent to CBS");		
	}
	
	if(checkData=='NO')
	{
		document.forms[0].cmdCBS2.disabled=true;
	}
}

function sendSanctionDetailsToCBS()
{
	if(app_check=="Y")
	{
		var facilityid=document.forms[0].sel_ram_facility.value;
		
		if(facilityid=='0')
		{
			alert("Select Facility Name");
			document.forms[0].sel_ram_facility.focus();
			return;
		}
		
		if(ConfirmMsg(159))
		 {	
			 var appno = document.forms[0].appno.value;
			 var com_appno = document.forms[0].com_appno.value;	
			 var scheme_code = "<%=Helper.correctNull((String)hshValues.get("scheme_code"))%>";
			 var FileName='SanctionDetails_'+scheme_code+'_'+com_appno;
			 var modtype= document.forms[0].modtype.value;
			 var prop = "scrollbars=no,width=650,height=500,top=25,left=180";
			 var url=appUrl+"action/"+FileName+".txt?appno="+appno+"&com_appno="+com_appno+"&mod_type="+modtype+"&sel_ram_facility="+facilityid+"&hidBeanGetMethod=corporateSanctionDetails&hidBeanId=FinacleBean";
			 window.open(url,"remarks",prop);
		 }
	}
	if(app_check=="N")
	{
		alert("Rejected Data Cannot be Send to CBS");
		return false;
	}
	if(app_check=="")
	{
		alert("Please Approve Before Sending to CBS");
		return false;
	}
}

function placevalues()
{		
	if(Facility_ID!='0')
	{
		document.forms[0].sel_ram_facility.value="<%=FacilityID%>";		
		document.forms[0].sel_taxslab.value=varseltaxslab;
		document.forms[0].sel_loan_frequency.value="<%=LoanFrequency%>";
		document.forms[0].sel_sectorcode.value=varsectorcode;
		document.forms[0].sel_subsector.value=varsubsectorcode;
		document.forms[0].select_purposeadvance.value=varpurposeofadvance;
		document.forms[0].sel_oprationmode.value=varoperationmode;				
		document.forms[0].sel_natureof_advance.value="<%=NatureOfAdvance%>";
		document.forms[0].sel_sanctionlevel.value="<%=SanctionLevel%>";
		document.forms[0].sel_sanctionauthority.value="<%=SanctionAuthority%>";
		document.forms[0].selmodepayment.value="<%=PaymentMethod%>";
		
		document.forms[0].selborrowercat.value="<%=borrowercategory%>";
		document.forms[0].seladvmode.value="<%=advancemode%>";
		document.forms[0].seladvtype.value="<%=advancetype%>";
		document.forms[0].selindtype.value="<%=industrytype%>";
		document.forms[0].cmdCBS2.disabled=false;
	}
	else
	{
		clearFields();
		document.forms[0].cmdCBS2.disabled=true;
	}		

	selOperative(document.forms[0].selmodepayment);
	disableFields(true);
	enableButtons(false,true,true,false,false,true);

	if(appstatus=="ca")
   	{
    	document.forms[0].cmdedit.disabled=true;
  	}
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].readOnly=val;		  
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
		  document.forms[0].elements[i].readOnly=val;		  
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
		  document.forms[0].elements[i].disabled=val;		  
		}
		document.forms[0].sel_ram_facility.disabled=false;
	}
	document.forms[0].txt_taxslab.readOnly=true;
	document.forms[0].txt_sectorcode.readOnly=true;
	document.forms[0].txt_subsectorcode.readOnly=true;
	document.forms[0].txt_purposeofadvance.readOnly=true;
	document.forms[0].txt_operationmode.readOnly=true;
	document.forms[0].txt_custtype.readOnly=true;
	document.forms[0].txt_healthcode.readOnly=true;
	document.forms[0].txt_freecode7.readOnly=true;
	document.forms[0].txt_existing_limit.readOnly=true;
	document.forms[0].txt_proposed_limit.readOnly=true;
	document.forms[0].txt_sanctioned_amt.readOnly=true;
	document.forms[0].txt_interest_rate.readOnly=true;
	document.forms[0].txt_mod_interestrate.readOnly=true;
}
	
function doEdit()
{
	var facilityid=document.forms[0].sel_ram_facility.value;
	if(facilityid!='0' && facilityid!='')
	{
		disableFields(false);
		enableButtons(true,false,false,false,true,true);
	}
	else
	{
		alert("Select Facility Name to Edit");
		document.forms[0].sel_ram_facility.focus();
		return;
	}
	
	document.forms[0].cmdCBS2.disabled=true;
}
function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdapply.disabled=bool2;
	document.forms[0].cmdrej.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;		
}
function doCancel()
{
	if(ConfirmMsg(102))
	 {		
		document.forms[0].hidBeanId.value="additionalParameter";
		document.forms[0].hidBeanGetMethod.value="getTertiarySanctionDetails";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/ops_sanctiondetails.jsp";
		document.forms[0].submit();
	 }
	
}
function doClose()
{	
	if(ConfirmMsg(100))
	{
		this.close();
	}	
}
function doSave()
{		
	var facilityid=document.forms[0].sel_ram_facility.value;
	
	if(facilityid=='0')
	{
		alert("Select Facility Name");
		document.forms[0].sel_ram_facility.focus();
		return;
	}
	
	if(document.forms[0].txt_sanctioned_amt.value == '0.00')
	{
		alert("Enter Sanction Amount");
		document.forms[0].txt_sanctioned_amt.focus();
		return;
	}
	
/*	if(eval(document.forms[0].txt_sanctioned_amt.value) > eval(document.forms[0].txt_proposed_limit.value))
	{				
		alert("Sanction Amount Cannot be greater than proposed Amount");
		document.forms[0].txt_sanctioned_amt.focus();
		return;		
	}*/
		
	if(document.forms[0].txt_taxslab.value == '')
	{
		alert("Select Tax Slab");
		//document.forms[0].sel_taxslab.focus();
		return;
	}
	
	if(document.forms[0].txt_flows.value == '')
	{
		alert("Enter No. Of Flows");
		document.forms[0].txt_flows.focus();
		return;
	}
	
	if(document.forms[0].sel_loan_frequency.value == '0')
	{
		alert("Select Loan Frequency");
		document.forms[0].sel_loan_frequency.focus();
		return;
	}
	
	if(document.forms[0].txt_loanperiod.value == '')
	{
		alert("Enter Loan Period");
		document.forms[0].txt_loanperiod.focus();
		return;
	}
	
	if(document.forms[0].txt_sectorcode.value == '')
	{
		alert("Select Sector Code");
		//document.forms[0].sel_sectorcode.focus();
		return;
	}
	
	if(document.forms[0].txt_subsectorcode.value=="")
	{
		alert("Select Sub Sector Code");
		//document.forms[0].sel_subsector.focus();
		return;
	}
	
	if(document.forms[0].txt_purposeofadvance.value=="")
	{
		alert("Select Purpose of Advance");
		//document.forms[0].select_purposeadvance.focus();
		return;
	}
	
	if(document.forms[0].txt_operationmode.value=="")
	{
		alert("Select Operation Mode");
		//document.forms[0].sel_oprationmode.focus();
		return;
	}
	
	if(document.forms[0].sel_natureof_advance.value == '0')
	{
		alert("Select Nature of Advance");
		document.forms[0].sel_natureof_advance.focus();
		return;
	}
	
	if(document.forms[0].sel_sanctionlevel.value == '0')
	{
		alert("Select Sanction Level");
		document.forms[0].sel_sanctionlevel.focus();
		return;
	}
	
	if(document.forms[0].sel_sanctionauthority.value == '0')
	{
		alert("Select Sanction Authority");
		document.forms[0].sel_sanctionauthority.focus();
		return;
	}
	
	if(document.forms[0].txt_sanction_refno.value == '')
	{
		alert("Enter Sanction Ref.No");
		document.forms[0].txt_sanction_refno.focus();
		return;
	}
	
	if(document.forms[0].selmodepayment.value == '0')
	{
		alert("Select Payment Method");
		document.forms[0].selmodepayment.focus();
		return;
	}
	
	if(document.forms[0].selmodepayment.value == 'E' && document.forms[0].txt_operativeaccno.value == '')
	{
		alert("Enter Operating A/C No");
		document.forms[0].txt_operativeaccno.focus();
		return;
	}
	if(trimtxt(document.forms[0].selborrowercat.value)=="s")
	{
		ShowAlert('121','Borrower Category');
		document.forms[0].selborrowercat.focus();
		return;
	}
	if(trimtxt(document.forms[0].seladvmode.value)=="s")
	{
		ShowAlert('121','Mode of Advance');
		document.forms[0].seladvmode.focus();
		return;
	}
	if(trimtxt(document.forms[0].seladvtype.value)=="s")
	{
		ShowAlert('121','Type of Advance');
		document.forms[0].seladvtype.focus();
		return;
	}
	if(trimtxt(document.forms[0].selindtype.value)=="s")
	{
		ShowAlert('121','Industry Type');
		document.forms[0].selindtype.focus();
		return;
	}
	if(trimtxt(document.forms[0].txt_custtype.value)=="")
	{
		ShowAlert('121','CBS Customer Type');
		document.forms[0].txt_custtype.focus();
		return;
	}
	if(trimtxt(document.forms[0].txt_healthcode.value)=="")
	{
		ShowAlert('121','CBS Health Code');
		document.forms[0].txt_healthcode.focus();
		return;
	}
	if(trimtxt(document.forms[0].txt_freecode7.value)=="")
	{
		ShowAlert('121','CBS Free Code7(District)');
		document.forms[0].txt_freecode7.focus();
		return;
	}
	
	if(trimtxt(document.forms[0].txt_mod_interestrate.value)=="" || trimtxt(document.forms[0].txt_mod_interestrate.value)=="0.00")
	{
		ShowAlert('121','Sanctioned Rate of Interest');
		document.forms[0].txt_mod_interestrate.focus();
		return;
	}
	if(facilityid!='0' && facilityid!='')
	{
		
		var len = document.forms[0].sel_ram_facility.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].sel_ram_facility.options[i].selected==true)
			 {
				 document.forms[0].sel_ram_facility1.value = document.forms[0].sel_ram_facility.options[i].text; 
				break;
			 }
		}
		 
		len = document.forms[0].sel_sanctionlevel.length;
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].sel_sanctionlevel.options[i].selected==true)
			 {
				 document.forms[0].sel_sanctionlevel1.value = document.forms[0].sel_sanctionlevel.options[i].text; 
				break;
			 }
		}
		
		len = document.forms[0].sel_sanctionauthority.length;
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].sel_sanctionauthority.options[i].selected==true)
			 {
				 document.forms[0].sel_sanctionauthority1.value = document.forms[0].sel_sanctionauthority.options[i].text; 
				break;
			 }
		}
		document.forms[0].hidBeanId.value="additionalParameter";
		document.forms[0].hidBeanMethod.value="updateTertiarySanctionDetails";
		document.forms[0].hidBeanGetMethod.value="getTertiarySanctionDetails";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/ops_sanctiondetails.jsp";
		document.forms[0].submit();	
	}	
	
}
function doReject()
{
	if(ConfirmMsg(161))
	 {
		var len = document.forms[0].sel_ram_facility.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].sel_ram_facility.options[i].selected==true)
			 {
				 document.forms[0].sel_ram_facility1.value = document.forms[0].sel_ram_facility.options[i].text; 
				break;
			 }
		}
		 
		len = document.forms[0].sel_sanctionlevel.length;
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].sel_sanctionlevel.options[i].selected==true)
			 {
				 document.forms[0].sel_sanctionlevel1.value = document.forms[0].sel_sanctionlevel.options[i].text; 
				break;
			 }
		}
		
		len = document.forms[0].sel_sanctionauthority.length;
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].sel_sanctionauthority.options[i].selected==true)
			 {
				 document.forms[0].sel_sanctionauthority1.value = document.forms[0].sel_sanctionauthority.options[i].text; 
				break;
			 }
		}
		
		document.forms[0].hidAction.value="reject";
		document.forms[0].hidBeanId.value="additionalParameter";
		document.forms[0].hidBeanMethod.value="updateTertiarySanctionDetails";
		document.forms[0].hidBeanGetMethod.value="getTertiarySanctionDetails";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/ops_sanctiondetails.jsp";
		document.forms[0].submit();
	 }
}

function selOperative(obj)
{
	var val=obj.value;
	
	if(val=="E")
	{
		document.forms[0].txt_operativeaccno.disabled=false;
		document.all.opnolabel.style.visibility="visible";
		document.all.opnovalue.style.visibility="visible";
	}
	else
	{
		document.forms[0].txt_operativeaccno.disabled=true;
		document.forms[0].txt_operativeaccno.value="";
		document.all.opnolabel.style.visibility="hidden";
		document.all.opnovalue.style.visibility="hidden";
	}
}

function getSanctionDetails()
{
	var facilityid=document.forms[0].sel_ram_facility.value;
	if(facilityid!='0' && facilityid!='')
	{	
		document.forms[0].hidBeanId.value="additionalParameter";
		document.forms[0].hidBeanGetMethod.value="getTertiarySanctionDetails";		
		document.forms[0].action=appUrl+"action/ops_sanctiondetails.jsp";
		document.forms[0].submit();
	}
	else
	{			
		clearFields();
	}
}

function clearFields()
{
		document.forms[0].sel_ram_facility.value="0";
		document.forms[0].sel_taxslab.value="0";
		document.forms[0].txt_taxslab.value="";
		document.forms[0].sel_loan_frequency.value="0";
		document.forms[0].sel_sectorcode.value="0";
		document.forms[0].txt_sectorcode.value="";
		document.forms[0].sel_subsector.value="0";
		document.forms[0].txt_subsectorcode.value="";
		document.forms[0].select_purposeadvance.value="0";	
		document.forms[0].txt_purposeofadvance.value="";		
		document.forms[0].sel_oprationmode.value="0";
		document.forms[0].txt_operationmode.value="";		
		document.forms[0].sel_natureof_advance.value="0";
		document.forms[0].sel_sanctionlevel.value="0";
		document.forms[0].sel_sanctionauthority.value="0";
		document.forms[0].selmodepayment.value="0";
		
		document.forms[0].txt_existing_limit.value="";
		document.forms[0].txt_proposed_limit.value="";
		document.forms[0].txt_sanctioned_amt.value="";
		document.forms[0].txt_interest_rate.value="";
		document.forms[0].txt_mod_interestrate.value="";		
		document.forms[0].txt_flows.value="";
		document.forms[0].txt_loanperiod.value="";		
		document.forms[0].txt_sanction_refno.value="";		
		document.forms[0].txt_operativeaccno.value="";
		document.forms[0].txt_freetext7.value="";
}

function callCalender(fname)
{
 	if(document.forms[0].cmdapply.disabled==false)
 	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}

</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>

<body text="#000000"
	onLoad="placevalues();checkRating()">
<jsp:include page="../share/help.jsp" flush="true"/>

<form name=form1 class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="bottom" align="center"><b>SANCTION DETAILS </b></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td valign="bottom" align="right">
		<b>*</b>&nbsp;All Fields are mandatory.
		Fill the field(s) before you press Save Button &nbsp;&nbsp;&nbsp; </td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<%String apptype = "";

			%>
	<tr>
		<td colspan="2" align="left">Facility Name</td>
		<td width="77%" align="left"><select name="sel_ram_facility"
			onChange="getSanctionDetails()">
			<option value="0">Select</option>
			<laps:terfacility />
		</select></td>
	</tr>
	<tr>
		<td width="17%" align="left">Existing Limit</td>
		<td width="6%"><b><%=ApplicationParams.getCurrency()%></b></td>
		<td width="77%" align="left"><input type="text"
			name="txt_existing_limit" size="20" maxsize="15"
			value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("facility_existing"))))%>">
		&nbsp;</td>
	</tr>
	<tr>
		<td width="17%" align="left">Proposed Limit</td>
		<td width="6%"><b><%=ApplicationParams.getCurrency()%></b></td>
		<td width="77%" align="left"><input type="text"
			name="txt_proposed_limit" size="20" maxsize="10"
			value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("facility_proposed"))))%>">
		&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2">Operation Mode</td>
		<td width="77%" align="left"><input type="hidden"
			name="sel_oprationmode"> <input type="text" name="txt_operationmode"
			size="35"
			value="<%=Helper.correctNull((String)hshValues.get("cbs_operation_mode"))%>">
		<b><span onClick="callDescHelp('16')" style="cursor:hand"><font
			size="1" face="MS Sans Serif"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
			border="0" tabindex="7"></span></b></td>
	</tr>
	<tr>
		<td width="17%" align="left">Sanctioned Loan Amount</td>
		<td width="6%" align="left"><b><%=ApplicationParams.getCurrency()%></b>&nbsp;</td>
		<td width="77%" align="left">
		 <input type="text" name="txt_sanctioned_amt"  value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("facility_sancamt"))))%>">
		</td>
	</tr>
	<tr>
		<td align="left" colspan="2">Rate of Interest</td>
		<td width="77%" align="left"><input type="text"
			name="txt_interest_rate" maxlength="5"
			value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("facility_interestrate"))))%>">
		</td>
	</tr>
	<tr>
		<td colspan="2" height="35">Sanctioned Rate of Interest</td>
		<td width="77%" height="35">
		<input type="text"
			name="txt_mod_interestrate"
			value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("facility_sancinterest"))))%>"></td>
	</tr>
	<tr>
		<td colspan="2" align="left">Tax Slab</td>
		<td width="77%" align="left"><input type="hidden" name="sel_taxslab">
		<input type="text" name="txt_taxslab" size="35"
			value="<%=Helper.correctNull((String)hshValues.get("cbs_taxslab"))%>">
		<b><span onClick="callDescHelp('25')" style="cursor:hand"><font
			size="1" face="MS Sans Serif"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
			border="0" tabindex="7"></span></b>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2" align="left">No Of Flows</td>
		<td width="77%" align="left"><input type="text" name="txt_flows"
			maxlength="3" onkeypress="allowInteger()"
			value="<%=Helper.correctNull((String)hshValues.get("cbs_noofflows"))%>">
		</td>
	</tr>
	<tr>
		<td align="left" colspan="2">Loan Frequency</td>
		<td width="77%" align="left"><select name="sel_loan_frequency">
			<option value="0" selected>Select</option>
			<option value="M">Monthly</option>
			<option value="Q">Quarterly</option>
			<option value="H">Half Yearly</option>
			<option value="Y">Yearly</option>
			<option value="N">Not Applicable</option>
		</select></td>
	</tr>
	<tr>
		<td colspan="2">Free Text 7</td>
		<td width="77%"><input type="text" name="txt_freetext7" maxlength="5"
			value="<%=Helper.correctNull((String)hshValues.get("FreeText7"))%>">
		<input type="hidden" name="hidfreetext7"
			value="<%=Helper.correctNull((String)hshValues.get("FreeText7"))%>" />

		<b><span onClick="callDescHelp('6')" style="cursor:hand"><font
			size="1" face="MS Sans Serif"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
			border="0" tabindex="7"></span></b> &nbsp;</td>
	</tr>
	<tr>
		<td colspan="2">Sector Code</td>
		<td width="77%"><input type="hidden" name="sel_sectorcode" size="20"
			maxlength="23" style=text-align:left;border-style=groove value=""> <input
			type="text" name="txt_sectorcode" size="45"
			value="<%=Helper.correctNull((String)hshValues.get("cbs_sector_code"))%>">
		<b><span onClick="callDescHelp('18')" style="cursor:hand"><font
			size="1" face="MS Sans Serif"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
			border="0" tabindex="7"></span></b></td>
	</tr>
	<tr>
		<td colspan="2">Sub Sector Code</td>
		<td width="77%" align="left"><input type="hidden" name="sel_subsector">
		<input type="text" name="txt_subsectorcode" size="45"
			value="<%=Helper.correctNull((String)hshValues.get("cbs_subsector_code"))%>">
		<b><span onClick="callDescHelp('19')" style="cursor:hand"><font
			size="1" face="MS Sans Serif"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
			border="0" tabindex="7"></span></b></td>
	</tr>
	<tr>
		<td colspan="2">Purpose Of Advance</td>
		<td width="77%" align="left"><input type="hidden"
			name="select_purposeadvance"> <input type="text"
			name="txt_purposeofadvance" size="45"
			value="<%=Helper.correctNull((String)hshValues.get("cbs_purposeof_advance"))%>">
		<b><span onClick="callDescHelp('22')" style="cursor:hand"><font
			size="1" face="MS Sans Serif"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
			border="0" tabindex="7"></span></b></td>
	</tr>
	<tr>
		<td colspan="2">Nature Of Advance</td>
		<td width="77%"><select name="sel_natureof_advance">
			<option value="0">Select</option>
			<option value="001">Secured</option>
			<option value="002">Partly Secured</option>
			<option value="003">Unsecured</option>
		</select></td>
	</tr>
	<tr>
		<td colspan="2">Sanction Level</td>
		<td width="77%" align="left"><select name="sel_sanctionlevel">
			<option value="0">Select</option>
			<%apptype = "20";

			%>
			<laps:StaticDataNewTag apptype='<%=apptype%>' />
		</select></td>
	</tr>
	<tr>
		<td colspan="2">Sanction Authority</td>
		<td width="77%" align="left"><select name="sel_sanctionauthority">
			<option value="0">Select</option>
			<%apptype = "21";

			%>
			<laps:StaticDataNewTag apptype='<%=apptype%>' />
		</select></td>
	</tr>
	<tr>
		<td colspan="2">Sanction Ref.No</td>
		<td width="77%" height="35"><input type="text"
			name="txt_sanction_refno" maxlength="15"
			value="<%=Helper.correctNull((String)hshValues.get("cbs_sanction_refno"))%>">
		</td>
	</tr>
	<tr>
		<td colspan="2">Payment Method</td>
		<td width="77%">
		<div align="left"><select name="selmodepayment" tabindex="18"
			onChange="selOperative(this)">
			<option value="0" selected>Select</option>
			<option value="S">Recover From Salary</option>
			<option value="P">Post Dated Cheque</option>
			<option value="E">Transfer from Saving/Current a/c</option>
			<option value="D">Electronic Cheque Clearing(ECS)</option>
			<option value="N">Cash Recovery</option>
		</select></div>
		</td>
	</tr>
	<tr>
		<td colspan="2" id="opnolabel">Operating A/C No</td>
		<td width="77%" id="opnovalue" align="left"><input type="text"
			name="txt_operativeaccno" maxlength="16"
			value="<%=Helper.correctNull((String)hshValues.get("cbs_operating_accno"))%>">
		</td>
	</tr>
	<tr>
		<td colspan="2">Loan period</td>
		<td width="77%" align="left"><input type="text" name="txt_loanperiod"
			maxlength="3" onkeypress="allowInteger()"
			value="<%=Helper.correctNull((String)hshValues.get("cbs_loan_period"))%>">
		&nbsp;Months</td>
	</tr>
	<tr>
		<td colspan="2">Borrower Category</td>
		<td width="77%"><select name="selborrowercat">
			<option value="s" selected>Select</option>
			<%apptype = "24";%>
			<laps:StaticDataNewTag apptype='<%=apptype%>' />
		</select></td>
	</tr>
	<tr>
		<td colspan="2">Mode of Advance</td>
		<td width="77%"><select name="seladvmode">
			<option value="s" selected>Select</option>
			<%apptype = "48";%>
			<laps:StaticDataNewTag apptype='<%=apptype%>' />
		</select></td>
	</tr>
	<tr>
		<td colspan="2">Type of Advance</td>
		<td width="77%"><select name="seladvtype">
			<option value="s" selected>Select</option>
			<%apptype = "49";%>
			<laps:StaticDataNewTag apptype='<%=apptype%>' />
		</select></td>
	</tr>
	<tr>
		<td colspan="2">Industry Type<b></b></td>
		<td width="77%"><select name="selindtype">
			<option value="s" selected>Select</option>
			<%apptype = "50";%>
			<laps:StaticDataNewTag apptype='<%=apptype%>' />
		</select></td>
	</tr>
	<tr>
		<td width="13%" colspan="2">CBS Customer Type<b>*</b></td>
		<td width="30%"><input type="hidden" name="hidcusttype"
			value="<%=Helper.correctNull((String)hshValues.get("customertype"))%>">
		<input type="text" name="txt_custtype" size="50" maxlength="5"
			value="<%=Helper.correctNull((String)hshValues.get("customertypedesc"))%>">
		<b><span onClick="callDescHelp('67')" style="cursor:hand"><font
			size="1" face="MS Sans Serif"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
			border="0"></span></b></td>
	</tr>
	<tr>
		<td width="13%" colspan="2">CBS Health Code<b>*</b></td>
		<td width="30%"><input type="hidden" name="hidhealthcode"
			value="<%=Helper.correctNull((String)hshValues.get("healthcode"))%>">
		<input type="text" name="txt_healthcode" size="50" maxlength="5"
			value="<%=Helper.correctNull((String)hshValues.get("healthcodedesc"))%>">
		<b><span onClick="callDescHelp('68')" style="cursor:hand"><font
			size="1" face="MS Sans Serif"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
			border="0"></span></b></td>
	</tr>
	<tr>
		<td width="13%" colspan="2">CBS Free Code5(District)<b>*</b></td>
		<td width="30%"><input type="hidden" name="hidfreecode7"
			value="<%=Helper.correctNull((String)hshValues.get("freecode7"))%>">
		<input type="text" name="txt_freecode7" size="50" maxlength="5"
			value="<%=Helper.correctNull((String)hshValues.get("freecode7desc"))%>">
		<b><span onClick="callDescHelp('69')" style="cursor:hand"><font
			size="1" face="MS Sans Serif"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
			border="0"></span></b></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
		<td width="77%">&nbsp;</td>
	</tr>
	<tr align="center">
		<td colspan="3">
		<table width='0%' border='1' cellspacing='0' cellpadding='0' class='outertable' align='center'>
		<tr>
		<td>
		<table width='0%' border='0' cellspacing='0' cellpadding='3'>
		<tr valign='top'>
		<td>
		<input type="button" name="cmdedit" value="Edit" onClick="doEdit()"
			class="buttonStyle">
			</td>
			<td>
		<input type="button" name="cmdapply" value="Approve" onClick="doSave()"	class="buttonStyle"	>
			</td>
			<td>
		<input type="button" name="cmdrej" value="Reject" onClick="doReject()" class="buttonStyle">
			</td>
			<td>
		<input type="button" name="cmdcancel" value="Cancel" onClick="doCancel()" class="buttonStyle">
			</td>
			<td>
		<input type="button" name="cmdclose" value="Close" onClick="doClose()" class="buttonClose">
			</td>
			</tr>
			</table>
			</td>
			</tr>
			</table>
		</td>
	</tr>
	<tr align="center">
		<td colspan="3"><input type="button" name="cmdCBS2"
			value="SEND SANCTION DETAILS TO CBS"
			onClick="sendSanctionDetailsToCBS()"
			style="background-color:#CC3300;color:white;font-size=10;font-family:mssansserif;width:250;font-weight:bold">
		</td>
	</tr>
</table>
<laps:hiddentag/>
<input type="hidden" name="sel_ram_facility1"> <input type="hidden"
	name="sel_sanctionlevel1"> <input type="hidden"
	name="sel_sanctionauthority1">  <input type="hidden" name="hidAppType"
	value="C"> <input type="hidden" name="hidTaxSlab"
	value="<%=Helper.correctNull((String)hshValues.get("hidtaxslab"))%>"> <input
	type="hidden" name="appno"
	value="<%=(String)session.getAttribute("appno")%>"> <input
	type="hidden" name="com_appno"
	value="<%=Helper.correctNull((String)hshValues.get("com_appno"))%>"> 
<input type="hidden" name="modtype" value="ops"> <input type="hidden"
	name="readFlag"
	value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
<%-- 
<input
	type="hidden" name="hidDemoId"
	value="<%//=Helper.correctNull((String)hshValues.get("hidDemoId"))%>">

--%>
</form>
</body>

</html>



