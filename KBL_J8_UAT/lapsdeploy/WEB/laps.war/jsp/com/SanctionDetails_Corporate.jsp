<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<laps:handleerror />
<%
if (objValues instanceof java.util.HashMap) 
{
	hshValues = (java.util.HashMap) objValues;
}

java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);

String Flag = Helper.correctNull((String)hshValues.get("Flag"));
String FacilityID="";
FacilityID=Helper.correctNull((String)hshValues.get("facility_id"));
if(FacilityID.equalsIgnoreCase(""))
{
	FacilityID="0";
}
String TaxSlab = Helper.correctNull((String)hshValues.get("cbs_taxslab"));
String LoanFrequency = Helper.correctNull((String)hshValues.get("cbs_loan_frequency"));
String SectorCode = Helper.correctNull((String)hshValues.get("cbs_sector_code"));
String SubSectorCode = Helper.correctNull((String)hshValues.get("cbs_subsector_code"));
String PurposeOfAdvance = Helper.correctNull((String)hshValues.get("cbs_purposeof_advance"));
String OperationMode = Helper.correctNull((String)hshValues.get("cbs_operation_mode"));
String NatureOfAdvance = Helper.correctNull((String)hshValues.get("cbs_natureof_advance"));
String SanctionLevel = Helper.correctNull((String)hshValues.get("cbs_sanction_level"));
String SanctionAuthority = Helper.correctNull((String)hshValues.get("cbs_sanction_authority"));
String PaymentMethod = Helper.correctNull((String)hshValues.get("cbs_payment_method"));
String borrowercategory=Helper.correctNull((String)hshValues.get("borrowercat"));
String advancemode=Helper.correctNull((String)hshValues.get("advmode"));
String advancetype=Helper.correctNull((String)hshValues.get("advtype"));
String industrytype=Helper.correctNull((String)hshValues.get("indtype"));
String SENT_FLAG =  Helper.correctNull((String)hshValues.get("SENT_FLAG"));
String checkData = Helper.correctNull((String)hshValues.get("checkData"));
String app_check=Helper.correctNull((String)hshValues.get("app_check"));

String strProposalin="";
strProposalin=Helper.correctNull((String)hshValues.get("proposalin"));

if(strProposalin.equalsIgnoreCase("C"))
	strProposalin="Crores";
else
	strProposalin="Lacs";
%>

<html>

<head>
<title>Sanction Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>

<script type="text/javascript">

var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var Facility_ID = "<%=FacilityID%>";
var Flag = "<%=Flag%>";
var sysdate="<%=Helper.getCurrentDateTime()%>";
var CBSFlag = "<%=SENT_FLAG%>";
var checkData = "<%=checkData%>";
var appstatus ="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>";
var app_check ="<%=app_check%>";

function checkRating()
{
	/*if(Flag=='0')
	{
		alert("Risk Rating is not done for this Application");
		disableFields(true);
		enableButtons(true,true,true,true,true,true);
		this.close();
	}*/
	
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
			 
			 var prop = "scrollbars=no,width=650,height=500,top=25,left=180";
			 var url=appUrl+"action/"+FileName+".txt?appno="+appno+"&com_appno="+com_appno+"&sel_ram_facility="+facilityid+"&hidBeanGetMethod=corporateSanctionDetails&hidBeanId=FinacleBean";
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

function sendCustomerProfileToCBS() 
{
	if(ConfirmMsg(159))
	 {	
		 var appno = document.forms[0].appno.value;
		 var com_appno = document.forms[0].com_appno.value;			 
		 var FileName='CustomerDetails_'+com_appno;
		 
		 var prop = "scrollbars=no,width=650,height=500,top=25,left=180";
		 var url=appUrl+"action/"+FileName+".txt?appno="+appno+"&com_appno="+com_appno+"&hidBeanGetMethod=CoporateCustomerProfile&hidBeanId=FinacleBean";
		 window.open(url,"remarks",prop);
	 }
}


function placevalues()
{		
	if(Facility_ID!='0')
	{
		document.forms[0].sel_ram_facility.value="<%=FacilityID%>";		
		document.forms[0].sel_taxslab.value="<%=TaxSlab%>";
		document.forms[0].sel_loan_frequency.value="<%=LoanFrequency%>";
		document.forms[0].sel_sectorcode.value="<%=SectorCode%>";
		document.forms[0].sel_subsector.value="<%=SubSectorCode%>";
		document.forms[0].select_purposeadvance.value="<%=PurposeOfAdvance%>";
		document.forms[0].sel_oprationmode.value="<%=OperationMode%>";		
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
	
	if(document.forms[0].readFlag.value.toUpperCase()=="R")
	{
		document.forms[0].cmdCBS2.disabled=true;
	}
	if(appstatus=="ca")
	{
		document.forms[0].cmdedit.disabled=true;
	}else{
		
		document.forms[0].cmdedit.disabled=false;
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
	document.forms[0].txt_custtype.readOnly=true;
	document.forms[0].txt_healthcode.readOnly=true;
	document.forms[0].txt_freecode7.readOnly=true;
}
	
function doEdit()
{
	var facilityid=document.forms[0].sel_ram_facility.value;
	if(facilityid!='0' && facilityid!='')
	{
		disableFields(false);
		enableButtons(true,false,false,false,true,true);
    	document.forms[0].txt_existing_limit.readOnly="true";
		document.forms[0].txt_proposed_limit.readOnly="true";
		document.forms[0].txt_sanctioned_amt.readOnly="true";
		document.forms[0].txt_interest_rate.readOnly="true";
		document.forms[0].txt_mod_interestrate.readOnly="true";
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
	document.forms[0].cmdapprove.disabled=bool2;
	document.forms[0].cmdreject.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;		
}
function doCancel()
{
	if(ConfirmMsg(102))
	 {		
		document.forms[0].hidBeanId.value="additionalParameter";
		document.forms[0].hidBeanGetMethod.value="getCorporateSanctionDetails";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/SanctionDetails_Corporate.jsp";
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
function doApprove()
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
	
	/*if(eval(document.forms[0].txt_sanctioned_amt.value) > eval(document.forms[0].txt_proposed_limit.value))
	{				
		alert("Sanction Amount Cannot be greater than proposed Amount");
		document.forms[0].txt_sanctioned_amt.focus();
		return;		
	}*/
		
	if(document.forms[0].sel_taxslab.value == '0')
	{
		alert("Select Tax Slab");
		document.forms[0].sel_taxslab.focus();
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
	
	if(document.forms[0].sel_sectorcode.value == '0')
	{
		alert("Select Sector Code");
		document.forms[0].sel_sectorcode.focus();
		return;
	}
	
	if(document.forms[0].sel_subsector.value == '0')
	{
		alert("Select Sub Sector Code");
		document.forms[0].sel_subsector.focus();
		return;
	}
	
	if(document.forms[0].select_purposeadvance.value == '0')
	{
		alert("Select Purpose of Advance");
		document.forms[0].select_purposeadvance.focus();
		return;
	}
	
	if(document.forms[0].sel_oprationmode.value == '0')
	{
		alert("Select Operation Mode");
		document.forms[0].sel_oprationmode.focus();
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
	
	/*if(document.forms[0].txt_loan_startdate.value == '')
	{
		alert("Enter Loan Start Date");
		document.forms[0].txt_loan_startdate.focus();
		return;
	}*/
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
		
		len = document.forms[0].sel_sectorcode.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].sel_sectorcode.options[i].selected==true)
			 {
				 document.forms[0].sel_sectorcode1.value = document.forms[0].sel_sectorcode.options[i].text; 
				break;
			 }
		}			
		
		len = document.forms[0].select_purposeadvance.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].select_purposeadvance.options[i].selected==true)
			 {
				 document.forms[0].select_purposeadvance1.value = document.forms[0].select_purposeadvance.options[i].text; 
				break;
			 }
		}			
		
		len = document.forms[0].sel_subsector.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].sel_subsector.options[i].selected==true)
			 {
				 document.forms[0].sel_subsector1.value = document.forms[0].sel_subsector.options[i].text; 
				break;
			 }
		}	
		
		len = document.forms[0].sel_oprationmode.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].sel_oprationmode.options[i].selected==true)
			 {
				 document.forms[0].sel_oprationmode1.value = document.forms[0].sel_oprationmode.options[i].text; 
				break;
			 }
		}	
		
		len = document.forms[0].sel_natureof_advance.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].sel_natureof_advance.options[i].selected==true)
			 {
				 document.forms[0].sel_natureof_advance1.value = document.forms[0].sel_natureof_advance.options[i].text; 
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
		
		len = document.forms[0].sel_natureof_advance.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].sel_natureof_advance.options[i].selected==true)
			 {
				 document.forms[0].sel_natureof_advance1.value = document.forms[0].sel_natureof_advance.options[i].text; 
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
		
		len = document.forms[0].sel_taxslab.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].sel_taxslab.options[i].selected==true)
			 {
				 document.forms[0].sel_taxslab1.value = document.forms[0].sel_taxslab.options[i].text; 
				break;
			 }
		}
		
		len = document.forms[0].selmodepayment.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].selmodepayment.options[i].selected==true)
			 {
				 document.forms[0].selmodepayment1.value = document.forms[0].selmodepayment.options[i].text; 
				break;
			 }
		}
		
		len = document.forms[0].sel_loan_frequency.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].sel_loan_frequency.options[i].selected==true)
			 {
				 document.forms[0].sel_loan_frequency1.value = document.forms[0].sel_loan_frequency.options[i].text; 
				break;
			 }
		}
		
		document.forms[0].hidAction.value="Approve";
		
		document.forms[0].hidBeanId.value="additionalParameter";
		document.forms[0].hidBeanMethod.value="updateCorporateSanctionDetails";
		document.forms[0].hidBeanGetMethod.value="getCorporateSanctionDetails";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/SanctionDetails_Corporate.jsp";
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
		
		len = document.forms[0].sel_sectorcode.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].sel_sectorcode.options[i].selected==true)
			 {
				 document.forms[0].sel_sectorcode1.value = document.forms[0].sel_sectorcode.options[i].text; 
				break;
			 }
		}			
		
		len = document.forms[0].select_purposeadvance.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].select_purposeadvance.options[i].selected==true)
			 {
				 document.forms[0].select_purposeadvance1.value = document.forms[0].select_purposeadvance.options[i].text; 
				break;
			 }
		}			
		
		len = document.forms[0].sel_subsector.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].sel_subsector.options[i].selected==true)
			 {
				 document.forms[0].sel_subsector1.value = document.forms[0].sel_subsector.options[i].text; 
				break;
			 }
		}	
		
		len = document.forms[0].sel_oprationmode.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].sel_oprationmode.options[i].selected==true)
			 {
				 document.forms[0].sel_oprationmode.value = document.forms[0].sel_oprationmode.options[i].text; 
				break;
			 }
		}	
		
		len = document.forms[0].sel_natureof_advance.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].sel_natureof_advance.options[i].selected==true)
			 {
				 document.forms[0].sel_natureof_advance1.value = document.forms[0].sel_natureof_advance.options[i].text; 
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
		
		len = document.forms[0].sel_natureof_advance.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].sel_natureof_advance.options[i].selected==true)
			 {
				 document.forms[0].sel_natureof_advance1.value = document.forms[0].sel_natureof_advance.options[i].text; 
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
		
		len = document.forms[0].sel_taxslab.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].sel_taxslab.options[i].selected==true)
			 {
				 document.forms[0].sel_taxslab1.value = document.forms[0].sel_taxslab.options[i].text; 
				break;
			 }
		}
		
		len = document.forms[0].selmodepayment.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].selmodepayment.options[i].selected==true)
			 {
				 document.forms[0].selmodepayment1.value = document.forms[0].selmodepayment.options[i].text; 
				break;
			 }
		}
		
		len = document.forms[0].sel_loan_frequency.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].sel_loan_frequency.options[i].selected==true)
			 {
				 document.forms[0].sel_loan_frequency1.value = document.forms[0].sel_loan_frequency.options[i].text; 
				break;
			 }
		}
		
		
		document.forms[0].hidAction.value="reject";
		document.forms[0].hidBeanId.value="additionalParameter";
		document.forms[0].hidBeanMethod.value="updateCorporateSanctionDetails";
		document.forms[0].hidBeanGetMethod.value="getCorporateSanctionDetails";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/SanctionDetails_Corporate.jsp";
		document.forms[0].submit();
	 }
}
function doDelete()
{
	/*if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="additionalParameter";
		document.forms[0].hidBeanMethod.value="updateCorporateSanctionDetails";
		document.forms[0].hidBeanGetMethod.value="getCorporateSanctionDetails";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/SanctionDetails_Corporate.jsp";
		document.forms[0].submit();
	 }*/
}


function selOperative(obj)
{
	var val=obj.value;
	
	if(val=="E")
	{
		document.forms[0].txt_operativeaccno.disabled=false;
		document.all.opnolabel.style.visibility="visible";
		document.all.opnolabel.style.position="relative";
		document.all.opnovalue.style.visibility="visible";
		document.all.opnovalue.style.position="relative";
	}
	else
	{
		document.forms[0].txt_operativeaccno.disabled=true;
		document.forms[0].txt_operativeaccno.value="";
		document.all.opnolabel.style.visibility="hidden";
		document.all.opnolabel.style.position="absolute";
		document.all.opnovalue.style.visibility="hidden";
		document.all.opnovalue.style.position="absolute";
	}
}

function getSanctionDetails()
{
	var facilityid=document.forms[0].sel_ram_facility.value;
	if(facilityid!='0' && facilityid!='')
	{	
		document.forms[0].hidBeanId.value="additionalParameter";
		document.forms[0].hidBeanGetMethod.value="getCorporateSanctionDetails";		
		document.forms[0].action=appUrl+"action/SanctionDetails_Corporate.jsp";
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
		document.forms[0].sel_loan_frequency.value="0";
		document.forms[0].sel_sectorcode.value="0";
		document.forms[0].sel_subsector.value="0";
		document.forms[0].select_purposeadvance.value="0";		
		document.forms[0].sel_oprationmode.value="0";		
		document.forms[0].sel_natureof_advance.value="0";
		document.forms[0].sel_sanctionlevel.value="0";
		document.forms[0].sel_sanctionauthority.value="0";
		document.forms[0].selmodepayment.value="0";
		
		document.forms[0].txt_existing_limit.value="";
		document.forms[0].txt_proposed_limit.value="";
		document.forms[0].txt_sanctioned_amt.value="";
		//document.forms[0].txt_requested_amt.value="";
		document.forms[0].txt_sanctioned_amt.value="";
		document.forms[0].txt_interest_rate.value="";
		document.forms[0].txt_mod_interestrate.value="";		
		document.forms[0].txt_flows.value="";
		document.forms[0].txt_loanperiod.value="";		
		document.forms[0].txt_sanction_refno.value="";		
		document.forms[0].txt_operativeaccno.value="";
		//document.forms[0].txt_loan_startdate.value="";
		//document.forms[0].txt_freetext7.value="";
		document.forms[0].txt_custtype.value="";
		document.forms[0].txt_healthcode.value="";
		document.forms[0].txt_freecode7.value="";
}

function callCalender(fname)
{
 	if(document.forms[0].cmdapprove.disabled==false)
 	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}
function callDescHelp(id)
{	
	if(document.forms[0].cmdedit.disabled)
	{
		var varQryString = appUrl+"action/ops_sanctionhelp.jsp?id="+id+"&hidBeanId=additionalParameter&hidBeanGetMethod=getSearch";;
		var title = "CBS_DATAS_HELP";
		var prop = "scrollbars=no,width=650,height=400";	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);	
	}
}

</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 200;
  overflow: auto;
}
</STYLE>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>

<body onLoad="placevalues();checkRating()">
<form  name=form1 class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
      <td valign="bottom" align="center" ><b>SANCTION 
        DETAILS
       
        </b></td>
  </tr>
  <tr>
        
      <td valign="bottom" align="right" > <b>*</b>&nbsp;All 
        Fields are mandatory. Fill the field(s) before you press Save Button 
        &nbsp;&nbsp;&nbsp; </td>
  </tr>  
  </table>
  <laps:application /> 
  <table width="100%" border="0" cellspacing="0" cellpadding="2" align="center" 
 class="outertable border1">
    <%
  String apptype="";
  %>
    <tr> 
      <td >Facility Name </td>
      <td > 
        <select name="sel_ram_facility" onChange="getSanctionDetails()">
          <option value="0">Select</option>
          <laps:ramfacility /> 
        </select>
      </td>
      <td >Existing Limit </td>
      <td><b>Rs.</b>&nbsp; 
        <input type="text" name="txt_existing_limit" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("facility_existing"))))%>">
        &nbsp;<%=strProposalin%> </td>
    </tr>
    <tr> 
      <td >Proposed Limit </td>
      <td ><b>Rs.</b>&nbsp; 
        <input type="text" name="txt_proposed_limit" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("facility_proposed"))))%>">
        &nbsp;<%=strProposalin%> </td>
      <td >Sanctioned Loan Amount </td>
      <td><b>Rs.</b>&nbsp; 
        <input type="text" name="txt_sanctioned_amt"  value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("facility_sancamt"))))%>">
        &nbsp;<%=strProposalin%> </td>
    </tr>
    <%--   <tr> 
      <td > Rating </td>
      <td >  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
          <input type="text" name="txt_rating" value="<%=Helper.correctNull((String)hshValues.get("facility_rating"))%>">
       
      </td>
    </tr>--%>
    <tr> 
      <td >Rate of Interest </td>
      <td > 
        <input type="text" name="txt_interest_rate" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("facility_interestrate"))))%>">
      </td>
      <td >Sanctioned Rate of Interest</td>
      <td> 
        <input type="text" name="txt_mod_interestrate" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("facility_sancinterest"))))%>">
      </td>
    </tr>
    <tr> 
      <td >No Of Flows</td>
      <td> 
        <input type="text" name="txt_flows" maxlength="5" value="<%=Helper.correctNull((String)hshValues.get("cbs_noofflows"))%>">
      </td>
      <td>Sanction Ref.No</td>
      <td> 
        <input type="text" name="txt_sanction_refno" maxlength="15" value="<%=Helper.correctNull((String)hshValues.get("cbs_sanction_refno"))%>">
      </td>
    </tr>
    <tr> 
      <td > Tax Slab </td>
      <td  colspan="3"> 
        <select name="sel_taxslab">
          <%apptype="25"; %>
          <option value="0">Select </option>
          <laps:StaticDataNewTag apptype='<%=apptype%>'/> 
        </select>
      </td>
    </tr>
    <tr> 
      <td  >Sector Code</td>
      <td colspan="3" > 
        <select name="sel_sectorcode">
          <option value="0">Select </option>
          <% apptype="18"; %>
          <laps:StaticDataNewTag apptype='<%=apptype%>'/> 
        </select>
      </td>
    </tr>
    <tr> 
      <td  >Sub Sector Code</td>
      <td  colspan="3"> 
        <select name="sel_subsector">
          <option value="0">Select </option>
          <%apptype="19"; %>
          <laps:StaticDataNewTag apptype='<%=apptype%>'/> 
        </select>
      </td>
    </tr>
    <tr> 
      <td  >Purpose Of Advance</td>
      <td  colspan="3"> 
        <select name="select_purposeadvance">
          <option value="0">Select </option>
          <% apptype="22"; %>
          <laps:StaticDataNewTag apptype='<%=apptype%>'/> 
        </select>
      </td>
    </tr>
    <tr> 
      <td  >Operation Mode</td>
      <td   colspan="3"> 
        <select name="sel_oprationmode">
          <option value="0">Select</option>
          <% apptype="16"; %>
          <laps:StaticDataNewTag apptype='<%=apptype%>'/> 
        </select>
      </td>
    </tr>
    <tr> 
      <td  >Nature Of Advance</td>
      <td  colspan="3" > 
        <select name="sel_natureof_advance">
          <option value="0" selected>Select</option>
          <option value="001">Secured</option>
          <option value="002">Partly Secured</option>
          <option value="003">Unsecured</option>
        </select>
      </td>
    </tr>
    <tr> 
      <td >Loan Frequency</td>
      <td> 
        <select name="sel_loan_frequency">
          <option value="0" selected>Select</option>
          <option value="M">Monthly</option>
          <option value="Q">Quarterly</option>
          <option value="H">Half Yearly</option>
          <option value="Y">Yearly</option>
          <option value="N">Not Applicable</option>
        </select>
      </td>
      <td>Loan period</td>
      <td> 
        <input type="text" name="txt_loanperiod" maxlength="5" value="<%=Helper.correctNull((String)hshValues.get("cbs_loan_period"))%>">
        &nbsp;Months </td>
    </tr>
    <tr> 
      <td  >Sanction Level</td>
      <td> 
        <select name="sel_sanctionlevel">
          <option value="0">Select </option>
          <%apptype="20"; %>
          <laps:StaticDataNewTag apptype='<%=apptype%>'/> 
        </select>
      </td>
      <td>Sanction Authority</td>
      <td> 
        <select name="sel_sanctionauthority">
          <option value="0">Select </option>
          <% apptype="21"; %>
          <laps:StaticDataNewTag apptype='<%=apptype%>'/> 
        </select>
      </td>
    </tr>
    <tr> 
      <td>Payment Method</td>
      <td> 
        <select name="selmodepayment" tabindex="18" onChange="selOperative(this)">
          <option value="0" selected>Select</option>
          <option value="S">Recover From Salary</option>
          <option value="P">Post Dated Cheque</option>
          <option value="E">Transfer from Saving/Current a/c</option>
          <option value="D">Electronic Cheque Clearing(ECS)</option>
          <!-- <option value="B">Bill to the Employer</option> -->
          <option value="N">Cash Recovery</option>
          <!--  <option value="T">Recover Shortfall Amt by Granting TOD</option>
            <option value="5"><font face="MS Sans Serif" size="1">Anyother</option> -->
        </select>
      </td>
      <td   id="opnolabel">Operating A/C No</td>
      <td   id="opnovalue"> 
        <input type="text" name="txt_operativeaccno" maxlength="16" value="<%=Helper.correctNull((String)hshValues.get("cbs_operating_accno"))%>">
      </td>
    </tr>
    <tr> 
      <td  >Borrower Category</td>
      <td > 
        <select name="selborrowercat">
          <option value="s" selected>Select</option>
          <%apptype = "24";%>
          <laps:StaticDataNewTag apptype='<%=apptype%>' /> 
        </select>
      </td>
      <td >Mode of Advance</td>
      <td > 
        <select name="seladvmode">
          <option value="s" selected>Select</option>
          <%apptype = "48";%>
          <laps:StaticDataNewTag apptype='<%=apptype%>' /> 
        </select>
      </td>
    </tr>
    <tr> 
      <td  >Type of Advance</td>
      <td colspan="3" > 
        <select name="seladvtype">
          <option value="s" selected>Select</option>
          <%apptype = "49";%>
          <laps:StaticDataNewTag apptype='<%=apptype%>' /> 
        </select>
      </td>
    </tr>
    <tr> 
      <td >Industry Type<b></b> </td>
      <td > 
        <select name="selindtype">
          <option value="s" selected>Select</option>
          <%apptype = "50";%>
          <laps:StaticDataNewTag apptype='<%=apptype%>' /> 
        </select>
      </td>
      <td >CBS Customer Type<b><font size="1" face="MS Sans Serif"
			color="#FF0000">*</b></td>
      <td > 
        <input type="hidden" name="hidcusttype" value="<%=Helper.correctNull((String)hshValues.get("customertype"))%>">
        <input type="text" name="txt_custtype" size="45" maxlength="5"
			value="<%=Helper.correctNull((String)hshValues.get("customertypedesc"))%>">
        <b><span	onClick="callDescHelp('67')" style="cursor:hand"><font size="1"
											face="MS Sans Serif"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"></span></b></td>
    </tr>
    <tr> 
      <td >CBS Health Code<b><font size="1" face="MS Sans Serif"
			color="#FF0000">*</b></td>
      <td width="9%"> 
        <input type="hidden" name="hidhealthcode" value="<%=Helper.correctNull((String)hshValues.get("healthcode"))%>">
        <input type="text" name="txt_healthcode" size="45" maxlength="5"
			value="<%=Helper.correctNull((String)hshValues.get("healthcodedesc"))%>">
        <b><span	onClick="callDescHelp('68')" style="cursor:hand"><font size="1"
											face="MS Sans Serif"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"></span></b></td>
      <td >CBS Free Code5(District)<b><font size="1" face="MS Sans Serif"
			color="#FF0000">*</b></td>
      <td > 
        <input type="hidden" name="hidfreecode7" value="<%=Helper.correctNull((String)hshValues.get("freecode7"))%>">
        <input type="text" name="txt_freecode7" size="45" maxlength="5"
			value="<%=Helper.correctNull((String)hshValues.get("freecode7desc"))%>">
        <b><span	onClick="callDescHelp('69')" style="cursor:hand"><font size="1"
											face="MS Sans Serif"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0" ></span></b></td>
    </tr>
    <tr> 
      <td  colspan="5"> 
        <div align="center"> 
        <laps:combuttonnew btnnames='Edit _Approve_Reject_Cancel' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
          <!-- <input type="button" name="cmdedit" value="Edit " onClick="doEdit()" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:100">
          <input type="button" name="cmdapply" value="Approve" onClick="doSave()" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:100">
          <input type="button" name="cmdrej" value="Reject" onClick="doReject()" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:100">
          <input type="button" name="cmdcancel" value="Cancel" onClick="doCancel()" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:100">
          <input type="button" name="cmdclose" value="Close" onClick="doClose()" style="background-color:#CC3300;color:white;font-size=10;font-family:mssansserif;width:100;font-weight:bold" > 
         <input type="button" name="cmddel" value="Delete" onClick="doDelete()" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:100">-->
        </div>
      </td>
    </tr>
    <tr> 
      <td  colspan="5"> 
        <div align="center"> 
          <!--  <input type="button" name="cmdCBS1" value="SEND CUSTOMER PROFILE TO CBS" onClick="sendCustomerProfileToCBS()" style="background-color:#CC3300;color:white;font-size=10;font-family:mssansserif;width:250;font-weight:bold" > -->
          <input type="button" name="cmdCBS2" value="SEND SANCTION DETAILS TO CBS" onClick="sendSanctionDetailsToCBS()" style="background-color:#CC3300;color:white;font-size=10;font-family:mssansserif;width:250;font-weight:bold" >
        </div>
      </td>
    </tr>
  </table>
	<input type="hidden" name="hidAction" value="">
	<input type="hidden" name="sel_ram_facility1">
<input type="hidden" name="sel_sectorcode1">
<input type="hidden" name="sel_subsector1">
<input type="hidden" name="select_purposeadvance1">
<input type="hidden" name="sel_oprationmode1">
<input type="hidden" name="sel_natureof_advance1">
<input type="hidden" name="sel_sanctionlevel1">
<input type="hidden" name="sel_sanctionauthority1">
<input type="hidden" name="sel_taxslab1">
<input type="hidden" name="selmodepayment1">
<input type="hidden" name="sel_loan_frequency1">
	<input type="hidden" name="hidBeanId" value="">
	<input type="hidden" name="hidBeanMethod" value="">
	<input type="hidden" name="hidBeanGetMethod"  value="">
	<input type="hidden" name="hidSourceUrl" value="">	 
	<input type="hidden" name="hidAppType" value="C">
	<input type="hidden" name="com_appno" value="<%=Helper.correctNull((String)hshValues.get("com_appno"))%>">
	<%-- 
	<input type="hidden" name="hidDemoId" value="<%//=Helper.correctNull((String)hshValues.get("hidDemoId"))%>">
--%>
</form>
</body>

</html>



