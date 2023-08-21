<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>

<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
java.text.DecimalFormat nf = new java.text.DecimalFormat();
nf.setGroupingUsed(true);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);

String loantype=Helper.correctNull((String)hshValues.get("loan_selecttype"));
String strEmployment=Helper.correctNull((String)hshValues.get("strEmployment"));
String strprdcode=(String)session.getAttribute("productcode");

%>
<html>
<head>
<title>Proposed Asset</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
a:hover {  color: #FF3300}
-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 350;
  overflow: auto;
}
#s{
margin-left: 102%;
}
#bs{
margin-left: 102%;
}
a:hover {  color: #FF3300}
</STYLE>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>

<script>
var strappeditsameregbranch="<%=session.getAttribute("HRBranchUserEdit")%>";
var appURL  ="<%=ApplicationParams.getAppUrl()%>"; 
var loantype="<%=Helper.correctNull((String)hshValues.get("loan_selecttype"))%>";
var strEmployment="<%=Helper.correctNull((String)hshValues.get("strEmployment"))%>";
var prdcode="<%=strprdcode%>";
var varAppHolder="<%=Helper.correctNull((String)hshValues.get("strAppHolder"))%>";
var varUserId="<%=Helper.correctNull((String)hshValues.get("strUsrid"))%>";
var varAppno="<%=Helper.correctNull((String)hshValues.get("strAppno"))%>";


	function calldetail1()
	{
	
		//if (document.forms[0].cibil.value=="S")
		//{
			//alert("Please fill the additional details page");
			//ShowAlert('103');
			//return;
		//}else{		
		 if(!document.forms[0].cmdapply.disabled)
		{
			ShowAlert('103');
			return;
		}
		else
		{
		document.forms[0].hidBeanId.value="NationalPortal";
		document.forms[0].hidBeanGetMethod.value="getprocessData2";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/NP_securitydetails.jsp";
		document.forms[0].hidAppType.value="";
		document.forms[0].submit();
		}

	//}	
		
		
	}

	function calldetail2()
	{
		
		if(!document.forms[0].cmdapply.disabled)
		{
			ShowAlert('103');
			return;
		}
		else
		{
		document.forms[0].hidBeanId.value="printapp";
		document.forms[0].hidBeanGetMethod.value="getprocessData3";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perprocessnotedata2.jsp";
		document.forms[0].hidAppType.value="";
		document.forms[0].submit();
		}
		
	}
	var strvalue="";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var income_salaried="<%=Helper.correctNull((String)hshValues.get("income_salaried"))%>";
//alert(appURL);
function placeValues()
{// alert("income_salaried=="+income_salaried);
	//income_salaried=Math.round(income_salaried);
	//alert("income_salaried=="+income_salaried);
	disableFields(true);
	//document.forms[0].eligibleamount.disabled = true;
	<% if(!Helper.correctNull((String)hshValues.get("finstatement_borr")).equalsIgnoreCase("")){ %>
	document.forms[0].finstatementbor.value =  "<%=Helper.correctNull((String)hshValues.get("finstatement_borr"))%>"
	<%} %>
	<% if(!Helper.correctNull((String)hshValues.get("salary_certificate")).equalsIgnoreCase("")){%>
	document.forms[0].salarycer.value =  "<%=Helper.correctNull((String)hshValues.get("salary_certificate"))%>"
	<%}%>
	<%if(!Helper.correctNull((String)hshValues.get("undertaking_letter")).equalsIgnoreCase("")){ %>
	document.forms[0].undertaking.value = "<%=Helper.correctNull((String)hshValues.get("undertaking_letter"))%>"
	<%}if(!Helper.correctNull((String)hshValues.get("declaration")).equalsIgnoreCase("")){%>
	document.forms[0].declaration.value =  "<%=Helper.correctNull((String)hshValues.get("declaration"))%>"
	<%}%>
	document.forms[0].incomeproof.value =  "<%=Helper.correctNull((String)hshValues.get("income_proof"))%>"
	document.forms[0].cibil.value =  "<%=Helper.correctNull((String)hshValues.get("cibil"))%>"
	<%if(!Helper.correctNull((String)hshValues.get("per_asst_class")).equalsIgnoreCase("")){ %>
	document.forms[0].sel_asstclass.value="<%=Helper.correctNull((String)hshValues.get("per_asst_class"))%>";
	<%}%>
	
	if(prdcode=="962" || prdcode=="963" || prdcode=="964" || prdcode=="979")
	{
	document.forms[0].sel_existnewcust.value="<%=Helper.correctNull((String)hshValues.get("per_existnewcust"))%>";
	document.forms[0].sel_giudelines.value="<%=Helper.correctNull((String)hshValues.get("per_giudelines"))%>";
	}
	
	if(prdcode=="963" || prdcode=="964")
	{
	document.forms[0].sel_bybank.value="<%=Helper.correctNull((String)hshValues.get("per_bybank"))%>";
	}
	if(prdcode=="965" || prdcode=="966" || prdcode=="977" || prdcode=="978" || prdcode=="949" || prdcode=="950" || prdcode=="947" || prdcode=="948" || prdcode=="651" || prdcode=="654" || prdcode=="655")
	{
	<%if(!Helper.correctNull((String)hshValues.get("per_letterenclosed")).equalsIgnoreCase("")){ %>
	document.forms[0].sel_letterenclosed.value="<%=Helper.correctNull((String)hshValues.get("per_letterenclosed"))%>";
	<%}if(!Helper.correctNull((String)hshValues.get("per_feespaid")).equalsIgnoreCase("")){ %>
	document.forms[0].sel_feespaid.value="<%=Helper.correctNull((String)hshValues.get("per_feespaid"))%>";
	<%}if(!Helper.correctNull((String)hshValues.get("per_estimatexpense")).equalsIgnoreCase("")){%>
	document.forms[0].sel_estimatexpense.value="<%=Helper.correctNull((String)hshValues.get("per_estimatexpense"))%>";
	<%}if(!Helper.correctNull((String)hshValues.get("per_submitappl")).equalsIgnoreCase("")){%>
	document.forms[0].sel_submitappl.value="<%=Helper.correctNull((String)hshValues.get("per_submitappl"))%>";
	<%}if(!Helper.correctNull((String)hshValues.get("per_completstatus")).equalsIgnoreCase("")){%>
	document.forms[0].sel_completstatus.value="<%=Helper.correctNull((String)hshValues.get("per_completstatus"))%>";
	<%}if(!Helper.correctNull((String)hshValues.get("per_repayloan")).equalsIgnoreCase("")){%>
	document.forms[0].sel_repayloan.value="<%=Helper.correctNull((String)hshValues.get("per_repayloan"))%>";
	<%}if(!Helper.correctNull((String)hshValues.get("per_completstudy")).equalsIgnoreCase("")){%>
	document.forms[0].sel_completstudy.value="<%=Helper.correctNull((String)hshValues.get("per_completstudy"))%>";
	<%}if(!Helper.correctNull((String)hshValues.get("per_deviation")).equalsIgnoreCase("")){%>
	document.forms[0].sel_deviation.value="<%=Helper.correctNull((String)hshValues.get("per_deviation"))%>";
	<%}%>
	}
	
	var strincome_proof="<%=Helper.correctNull((String)hshValues.get("income_proof"))%>";
	
	if(strincome_proof!="")
	{
		
			document.forms[0].incomeproof.value=strincome_proof;
	}
	else
	{
	document.forms[0].incomeproof.value="N";
	}
	
	
	//sathiya
	var strcibil="<%=Helper.correctNull((String)hshValues.get("cibil"))%>";
	
	if(strcibil!="")
	{
		
			document.forms[0].cibil.value=strcibil;
	}
	else
	{
	document.forms[0].cibil.value="S";
	}
	
	
	
	if (document.forms[0].appstatus.value != "Open/Pending")
	{
		alert("Cannot modify --> APPROVED APPLICATION !!!")
		callDisableControls(true,true,true,true,false)
	}else if(strappeditsameregbranch!="")
	{
		if(strappeditsameregbranch=="disablefalse")
		{
			callDisableControls(false,true,true,true,false);
		}
		else if(strappeditsameregbranch=="disabletrue")
		{
			callDisableControls(true,true,true,true,false);
		}
	}
}

function getCustomername()
{
	if(prdcode=="962" || prdcode=="963" || prdcode=="964" || prdcode=="979")
	{
	if(document.forms[0].sel_existnewcust.value=="1")
	{ 
		document.all.custname.style.visibility="visible";
		document.all.custname.style.position="relative";
		document.all.exist.style.visibility="hidden";
		document.all.exist.style.position="absolute";
	}
	else if(document.forms[0].sel_existnewcust.value=="0")
	{
		document.all.custname.style.visibility="hidden";
		document.all.custname.style.position="absolute";
		document.all.exist.style.visibility="visible";
		document.all.exist.style.position="relative";
	}
	else
	{
		document.all.custname.style.visibility="hidden";
		document.all.custname.style.position="absolute";
		document.all.exist.style.visibility="hidden";
		document.all.exist.style.position="absolute";
		
	}
	}
}

function callDisableControls(cmdEdit,cmdApply,cmdDelete,cmdCancel,cmdClose)
{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdapply.disabled=cmdApply;
	document.forms[0].cmddel.disabled=cmdDelete;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
}
function disableFields(val)
{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
				 document.forms[0].elements[i].readOnly=val;		  
			}
			else if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			document.forms[0].eligibleamount.readOnly = true;
			if(loantype=="H")
			{
			document.forms[0].incomesalary.readOnly = true;
			document.forms[0].incomebusiness.readOnly = true;
			document.forms[0].incomeagri.readOnly = true;
			document.forms[0].cutbacksalary.readOnly = true;
			document.forms[0].cutbackbusiness.readOnly = true;
			document.forms[0].cutbackagri.readOnly = true;
			document.forms[0].marginsalary.readOnly = true;
			document.forms[0].marginbusiness.readOnly = true;
			document.forms[0].marginagri.readOnly = true;
			document.forms[0].amtrequestedprocess1.readOnly = true;
			document.forms[0].agecriteria.readOnly = true;
			}
		}
		document.forms[0].finstatementbor.disabled = true;
		document.forms[0].salarycer.disabled = true;
		document.forms[0].undertaking.disabled = true;
		document.forms[0].declaration.disabled = true;
		document.forms[0].incomeproof.disabled = true;
		document.forms[0].cibil.disabled = true;
		document.forms[0].total.readOnly=true;
		document.forms[0].average.readOnly=true;
}
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,true,true);
	document.forms[0].finstatementbor.disabled = false;
		document.forms[0].salarycer.disabled = false;
		document.forms[0].undertaking.disabled = false;
		document.forms[0].declaration.disabled = false;
		document.forms[0].incomeproof.disabled = false;
		document.forms[0].cibil.disabled = false;
		//document.forms[0].eligibleamount.disabled = true;
		document.forms[0].sel_asstclass.disabled = false;

		if(prdcode=="962" || prdcode=="963" || prdcode=="964" || prdcode=="979")
		{
		document.forms[0].sel_existnewcust.disabled = false;
		document.forms[0].sel_giudelines.disabled = false;
		}
		if(prdcode=="963" || prdcode=="964")
		{
		document.forms[0].sel_bybank.disabled = false;
		}
		if(prdcode=="965" || prdcode=="966" || prdcode=="977" || prdcode=="978" || prdcode=="949" || prdcode=="950" || prdcode=="947" || prdcode=="948" || prdcode=="651" || prdcode=="654" || prdcode=="655")
		{
		document.forms[0].sel_letterenclosed.disabled = false;
		document.forms[0].sel_feespaid.disabled = false;
		document.forms[0].sel_estimatexpense.disabled = false;
		document.forms[0].sel_submitappl.disabled = false;
		document.forms[0].sel_completstatus.disabled = false;
		document.forms[0].sel_repayloan.disabled = false;
		document.forms[0].sel_completstudy.disabled = false;
		document.forms[0].sel_deviation.disabled = false;
		}

}
function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanMethod.value="updateSupply";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comrawsupply.jsp";
		document.forms[0].submit();
	 }
		
}
function doApply()
{

	if(varAppHolder!=varUserId&&varAppno!="")
	{	
		alert("Your Not The Holder of the Application to Modify The Application");
		return;
	}
	else{
	
		document.forms[0].year3.disabled=false;
		document.forms[0].year2.disabled=false;
		document.forms[0].year1.disabled=false;
		document.forms[0].total.disabled=false;
		document.forms[0].average.disabled=false;
		document.forms[0].latest.disabled=false;
		document.forms[0].incomeproof.disabled = false;




		
		if ((document.forms[0].cibil.value=="")||(document.forms[0].cibil.value=="S"))
		{
		alert("Select CIBIL Test (Y/N)");
		}
		else
		{


			if ((document.forms[0].sel_asstclass.value=="")||(document.forms[0].sel_asstclass.value=="S"))
			{
			alert("Select Assest Clasiification Value");
			document.forms[0].sel_asstclass.focus();
			return;
			}


			if ((document.forms[0].txt_procssno.value==""))
			{
			alert("Enter the Process Note Number");
			document.forms[0].txt_procssno.focus();
			return;
			}

			
		var flag=validate();
		if(document.forms[0].average.value=="")
		{
			document.forms[0].average.value="0";
		}
		if(document.forms[0].latest.value=="")
		{
			document.forms[0].latest.value="0";
		}
		if(document.forms[0].year3.value=="")
		{
			document.forms[0].year3.value=0;
		}
		if(document.forms[0].year2.value=="")
		{
			document.forms[0].year2.value=0;
		}
		if(document.forms[0].year1.value=="")
		{
			document.forms[0].year1.value=0;
		}
		if(flag)
		{
		//document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="NationalPortal"
		document.forms[0].hidBeanMethod.value="updateProcessData";
		document.forms[0].hidBeanGetMethod.value="getprocessData1";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/NP_perprocessnotedata.jsp";
		document.forms[0].submit();
		}
		}
		
	}		
}
function  validate()
{ 
return true;

}

function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="NationalPortal"
		document.forms[0].hidBeanGetMethod.value="getprocessData1";
		//document.forms[0].action=appURL+"controllerservlet";
		//document.forms[0].hidSourceUrl.value="/action/perprocessnotedata.jsp";
		document.forms[0].action=appURL+"action/NP_perprocessnotedata.jsp";
		document.forms[0].submit();
	 }
}
function callLink(page,bean,method)
{	
	if (document.forms[0].cmdapply.disabled)
	{
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
function doAudit()
{

}

function doClose()
{
	alert("soma in close");
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appURL+"action/"+"perexisting.jsp";
		document.forms[0].submit();
	}
	
}


function enableButtons(bool1,bool2,bool3,bool4,bool5)
{

	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdapply.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;

}


 function callApplicantTab(page)
  { 
   	
	if (document.forms[0].cmdapply.disabled)
	{
	  if(page=="company")
	  { 
		  document.forms[0].hidBeanGetMethod.value="getData";
		  document.forms[0].action=appURL+"action/comcompany.jsp";
	  }
	  if(page=="proposal")
	  {
		  document.forms[0].hidBeanGetMethod.value="getProposal";
		  document.forms[0].action=appURL+"action/comproposal.jsp";
	  }
	    	  if(page=="facilities")
	  {
		  document.forms[0].hidBeanMethod.value="getFacilityData";
		  document.forms[0].hidBeanId.value="facilities";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/facilities.jsp";
	  }
		  document.forms[0].submit();
	 }
	else
	{
		ShowAlert(103);
	}
	
	
  }

function callTerms()
{
	if(!document.forms[0].cmdapply.disabled)
		{
			ShowAlert('103');
			return;
		}
	document.forms[0].sel_termstype.value="C";
		document.forms[0].hidBeanId.value="NationalPortal";
	document.forms[0].hidBeanGetMethod.value="getTerms";
	
	document.forms[0].action=appURL+"action/NP_borrapptermsandcondns.jsp";
	document.forms[0].submit();

}
function callAppraisal()
	{
		
		if(!document.forms[0].cmdapply.disabled)
		{
			ShowAlert('103');
			return;
		}
		else
		{
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidPageValue.value="Retail";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/NP_perappsanctionsanction.jsp";
		document.forms[0].hidAppType.value="";
		document.forms[0].submit();
		}
		
	}
	
function calnotzero()
{
	var year3=	document.forms[0].year3.value;
	var year2=	document.forms[0].year2.value;
	var year1=	document.forms[0].year1.value;
	var zero="0";
	
	/*if(year3=="")
	{
		alert("Enter Value");
		document.forms[0].year3.focus();
	}*/
	if(eval(year3) <= eval(zero) || year3=="")
		{
			//alert("Enter Value > Zero in Pre Year3");
			document.forms[0].year3.focus();
			return false;
		}	

	
	if(eval(year2) <= eval(zero) ||year2=="")
	{
		//alert("Enter Value > Zero in Pre Year2");
		document.forms[0].year2.focus();
		return false;
	}	
	
	if(eval(year1) <= eval(zero) || year1=="")
	{
		//alert("Enter Value > Zero in Pre Year1");
		document.forms[0].year1.focus();
		return false;
	}	

}	
function calcaverage()
{	
var year3=	document.forms[0].year3.value;
var year2=	document.forms[0].year2.value;
var year1=	document.forms[0].year1.value;
if(year3=="0" || year3=="0.0" || year3=="0.00")
{
	year3="";
}
if(year2=="0" || year2=="0.0" || year2=="0.00")
{
	year2="";
}
if(year1=="0" || year1=="0.0" || year1=="0.00")
{
	year1="";
}

var total="0";
var average="0";
	if(year3!="" && year2==""&& year1=="")
	{
		total=eval(total)+eval(year3);
		average=total;
	}
	if(year3=="" && year2!=""&& year1=="")
	{
		total=eval(total)+eval(year2);
		average=total;
	}
	if(year3=="" && year2==""&& year1!="")
	{
		total=eval(total)+eval(year1);
		average=total;
	}
	if(year3!="" && year2!=""&& year1=="")
	{
		total=eval(year2)+eval(year3);
		average=eval(total)/2;
	}
	if(year3!="" && year2==""&& year1!="")
	{
		total=eval(year1)+eval(year3);
		average=eval(total)/2;
	}
	if(year3=="" && year2!=""&& year1!="")
	{
		total=eval(year1)+eval(year2);
		average=eval(total)/2;
	}
	if(year3!="" && year2!=""&& year1!="")
	{
		total=eval(year1)+eval(year2)+eval(year3);
		average=eval(total)/3;
	}
	document.forms[0].total.value=total;
	document.forms[0].average.value=average;
}
function mandartory()
{
if(strEmployment=="Business")
	{
		if(document.forms[0].latest.value=="")
		{
			if(document.forms[0].average.value!="0")
			{		
				alert("Enter the Latest Income");
				document.forms[0].latest.focus();
				return false;
			}	
		}
	}
}

function disableincomedet()
{
	document.forms[0].year3.disabled=true;
	document.forms[0].year2.disabled=true;
	document.forms[0].year1.disabled=true;
	document.forms[0].total.disabled=true;
	document.forms[0].average.disabled=true;
	document.forms[0].latest.disabled=true;
	document.forms[0].incomeproof.disabled = true;
	document.forms[0].sel_asstclass.disabled = true;

	if(prdcode=="962" || prdcode=="963" || prdcode=="964" || prdcode=="979")
	{
	document.forms[0].sel_existnewcust.disabled = true;
	document.forms[0].sel_giudelines.disabled = true;
	}
	if(prdcode=="963" || prdcode=="964")
	{
	document.forms[0].sel_bybank.disabled = true;
	}
	if(prdcode=="965" || prdcode=="966" || prdcode=="977" || prdcode=="978" || prdcode=="949" || prdcode=="950" || prdcode=="947" || prdcode=="948" || prdcode=="651" || prdcode=="654" || prdcode=="655")
	{
	document.forms[0].sel_letterenclosed.disabled = true;
	document.forms[0].sel_feespaid.disabled = true;
	document.forms[0].sel_estimatexpense.disabled = true;
	document.forms[0].sel_submitappl.disabled = true;
	document.forms[0].sel_completstatus.disabled = true;
	document.forms[0].sel_repayloan.disabled = true;
	document.forms[0].sel_completstudy.disabled = true;
	document.forms[0].sel_deviation.disabled = true;
	}
}




function showappholder()
{
	if((document.forms[0].hid_appholder.value=="N") || (document.forms[0].appstatus.value=="Processed/Rejected") || (document.forms[0].appstatus.value=="Processed/Approved"))
	{
		callDisableControls(true,true,true,true,false);
	}
}



</script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>

<body  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="placeValues();disableincomedet();funEDappstatus();showappholder();getCustomername();" class="bgcolor">
<jsp:include page="../share/help.jsp" flush="true"> 
</jsp:include>

<form method="post" >
  <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td> 
        <jsp:include page="../nationalportal/ApplurllinkNP.jsp" flush="true"> 
        <jsp:param name="pageid" value="10" />
        </jsp:include>
         </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td height="20"><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>Home 
        </i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i> 
        </i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt; 
        Retail</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        <font face="Times New Roman" size="3"><b><i></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        <font face="Times New Roman" size="3"><b><i>-&gt; Existing </i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt;</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        </i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font face="Times New Roman" size="3"><b><i>Process Note</i></b></font></td>
    </tr>
  </table>
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr> 
      <td> <laps:application /> </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" class="outertablecolor">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" height="100%">
          <tr> 
            <td valign="top"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td height="20" class="outertablecolor"> 
        <table width="50%" border="0" cellspacing="3" cellpadding="3" align="left">
          <tr align="center"> 
            <td width="50%" class="tabinactive"><b><font size="1" face="MS Sans Serif" ><a href="javascript:callTerms()" class="blackfont">Terms 
              and Conditions</a></font></b></td>
            <td width="30%" class="tabinactive"><b><font size="1" face="MS Sans Serif"><a href="javascript:callAppraisal()" class="blackfont">Appraisal</a></font></b></td>
		    <td width="30%" class="tabactive"><b><font size="1" face="MS Sans Serif" color="#FFFFFF">Process Note</font></b></td>
          </tr>
        </table>
      </td>
    </tr>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td>
                    <table width="70%" border="0" cellspacing="3" cellpadding="3" align="left">
                      <tr> 
                        <td width="15%" align="center" id="prm" class="tabactive"> 
                          <b><font size="1" face="MS Sans Serif" color="#FFFFFF">Additional Details</font></b></td>
                        <td width="15%" align="center" id="com2" class="tabinactive"><a href="JavaScript:calldetail1()" class="blackfont"><b><font size="1" face="MS Sans Serif">
                        Security Details </font></b></a></td><!--
                        <td width="15%" align="center" id="com2" class="tabinactive"> 
                          <a href="JavaScript:calldetail2()" class="blackfont"><b><font size="1" face="MS Sans Serif">Take Over </font></b></a></td>
						  
                        --><td width="15%" align="center"> <font size="1" face="MS Sans Serif" color="#FF0000">All 
                          Values are in Rs</font></td>
                      </tr>
                    </table>
					
                  </td>
                </tr>
                <tr>
                  <td>
                    <table border="1" cellspacing="0" cellpadding="3" width="100%" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
                      <tr> 
                        <td>
                       
                        <div Class = "cellContainer">
                        
						  <table width="100%" border="0" cellspacing="0" cellpadding="2">
                            <tr>  
                            <td width="16%" height="60" style="visibility:hidden"><font size="1" face="MS Sans Serif">Proof of Income
                               <select name="incomeproof" >
                                    <option value="S">Select</option>
                                    <option value="A">Income Tax Assessment</option>
                                    <option value="R">Income Tax Return</option>
									<option value="C">Latest Salary Certificate</option>
									<option value="B">Balance Sheets/Profit and Loss accounts</option>
									<option value="O">AF 452 (OG 15)</option>
									<option value="N" selected>Not Submitted</option>
							</select>
                                  </font></td>
                              <td colspan="3" height="60" style="visibility:hidden"> 
                                <table width="96%" border="0">
                                  <tr> 
                                    <td width="13%"> 
                                      <div align="center"><font size="1" face="MS Sans Serif"><b>Pre Year - 3</b></font></div>
                                    </td>
                                    <td width="13%"> 
                                      <div align="center"><font size="1" face="MS Sans Serif"><b>Pre Year - 2</b></font></div>
                                    </td>
                                    <td width="15%"> 
                                      <div align="center"><font size="1" face="MS Sans Serif"><b>Pre Year - 1</b></font></div>
                                    </td>
                                    <td width="20%"> 
                                      <div align="center"><font size="1" face="MS Sans Serif"><b>Total for last 3 years</b></font></div>
                                    </td>
                                    <td width="18%"> 
                                      <div align="center"><font size="1" face="MS Sans Serif"><b>Average Income </b></font></div>
                                    </td>
                                    <td width="21%"> 
                                      <div align="center"><font size="1" face="MS Sans Serif"><b>Latest Income </b></font></div>
                                    </td>
                                  </tr>
                                  <tr > 
                                    <td width="13%" style="visibility:hidden"> 
                                      <div align="center"> 
                                        <input type="text" name="year3" size="10"  maxlength="10"  onBlur="calcaverage();calnotzero()" onKeyPress="allowDecimals(this.value)" value="<%=Helper.correctNull((String)hshValues.get("year3_income"))%>" style="text-align:right">
                                      </div>
                                    </td>
                                    <td width="13%" style="visibility:hidden"> 
                                      <div align="center"> 
                                        <input type="text" name="year2" size="10"  maxlength="10" onBlur="calcaverage();calnotzero()" onKeyPress="allowDecimals(this.value)" value="<%=Helper.correctNull((String)hshValues.get("year2_income"))%>" style="text-align:right">
                                      </div>
                                    </td>
                                    <td width="15%" style="visibility:hidden"> 
                                      <div align="center"> 
                                        <input type="text" name="year1" size="10"  maxlength="10" onBlur="calcaverage();calnotzero()" onKeyPress="allowDecimals(this.value)" value="<%=Helper.correctNull((String)hshValues.get("year1_income"))%>" style="text-align:right">
                                      </div>
                                    </td>
                                    <td width="20%" style="visibility:hidden"> 
                                      <div align="center"> 
                                        <input type="text" name="total" size="10"  maxlength="10"  onKeyPress="allowDecimals(this.value)" value="<%=Helper.correctNull((String)hshValues.get("total_income"))%>" style="text-align:right" readOnly>
                                      </div>
                                    </td>
                                    <td width="18%" style="visibility:hidden"> 
                                      <div align="center"> 
                                        <input type="text" name="average" size="10"  maxlength="10"  onKeyPress="allowDecimals(this.value)" value="<%=Helper.correctNull((String)hshValues.get("average_income"))%>" style="text-align:right" readOnly>
                                      </div>
                                    </td>
                                    <td width="21" style="visibility:hidden"> 
                                      <div align="center"> 
                                        <input type="text" name="latest" size="10"  onBlur="mandartory()" maxlength="10"  onKeyPress="allowDecimals(this.value)" value="<%=Helper.correctNull((String)hshValues.get("latest_income"))%>" style="text-align:right">
                                      </div>
                                    </td>
                                  </tr>
                                </table>
                               
                              </td>
                              <td width="15%">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="30%" class="tabactive"><font size="1" face="MS Sans Serif"  color="#FFFFFF"><b>Particulars</b></font></td>
                              <td width="22%" class="tabactive" > 
                                <div align="center" id="bs"><font size="1" face="MS Sans Serif" color="#FFFFFF"><b>Borrower</b></font></div>
                              </td>
                              <td width="16%"  class="tabactive"> 
                                <div align="center"><font size="1" face="MS Sans Serif" color="#FFFFFF"><!-- <b>Surety</b> --></font></div>
                              </td>
                              
                            </tr>
                            <tr> 
                              <td width="16%"><font size="1" face="MS Sans Serif">Financial 
                                Statement for last 3 years (For Business Class)</font></td>
                              <td width="22%"> 
                                <div align="center" id="s" > 
								
                                  <select name="finstatementbor" >
                                    <option value="S" selected>Select</option>
                                    <option value="SU">Submitted</option>
                                    <option value="NS">Not Submitted</option>
									<option value="NA">Not Applicable</option>
                                  </select>
                                </div>
                              </td>
                              <td width="16%"> 
                                <div align="center"><font size="1" face="MS Sans Serif"> 
								<!--  tis field is hidden as per Mr.Katti request 24/07/2009<textarea name="finstatementsurety" cols="70" onKeyDown="textlimit(this,this.form.countdown,3900);" 
onKeyUp="textlimit(this,this.form.countdown,3900);" readonly="readonly" rows="3"><%=Helper.correctNull((String)hshValues.get("finstatement_surety"))%></textarea>-->
                                <!--   <select name="finstatementsurety" >
                                    <option value="S" selected>Select</option>
                                    <option value="SU">Submitted</option>
                                    <option value="NS">Not Submitted</option>
                                  </select> -->
                                  </font></div>
                              </td>
                              <td width="31%">&nbsp;</td>
                            </tr>
                            <tr> 
                              <!-- <td width="16%"><font size="1" face="MS Sans Serif">Net 
                                worth as per ADV 80A</font></td>
                              <td width="22%"> 
                                <div align="center"> 
                                  <input type="text" name="nwbor" size="13"  maxlength="10"  onKeyPress="allowDecimals(this.value)" value="<%=Helper.correctNull((String)hshValues.get("networth_borr"))%>" style="text-align:right">
                                </div>
                              </td>
                              <td width="16%"> 
                                <div align="center"> 
								<textarea name="nwsurety" cols="70" readonly="readonly" rows="3"><//=Helper.correctNull((String)hshValues.get("networth_surety"))%></textarea>
                                  
                                </div>
                              </td> -->
                              <td width="31%">&nbsp; </td>
                            </tr>
                            <tr> 
                              <td width="16%"><font size="1" face="MS Sans Serif">Salary 
                                Certificate </font></td>
                              <td width="22%"> 
                                <div align="center" id="s"> 
                                  <select name="salarycer">
                                    <option value="S" selected>Select</option>
                                    <option value="SU">Submitted</option>
                                    <option value="NS">Not Submitted</option>
									<option value="NA">Not Applicable</option>
                                  </select>
                                </div>
                              </td>
                            </tr>
                            <tr> 
                              <td width="16%"><font face="MS Sans Serif" size="1">Under-taking 
                                letter from the employer (for the salaried class)</font></td>
                              <td width="22%"> 
                                <div align="center" id="s"> 
                                  <select name="undertaking" >
                                    <option value="S" selected>Select</option>
                                    <option value="SU">Submitted</option>
                                    <option value="NS">Not Submitted</option>
									<option value="NA">Not Applicable</option>
                                  </select>
                                </div>
                              </td>
                              <td width="16%">&nbsp;</td>
                              <td width="31%">&nbsp; </td>
                            </tr>
                            <tr> 
                              <td colspan="2"  ><font size="1" face="MS Sans Serif">Whether 
                                waiver of surety is sought,if so, justify the 
                                reasons for recommending/considering the same</font> 
                              </td>
                              <td colspan="2"  > 
                                <textarea name="waiver" cols="70" onKeyDown="textlimit(this,this.form.countdown,3900);" 
onKeyUp="textlimit(this,this.form.countdown,3900);" readonly="readonly" rows="3"><%=Helper.correctNull((String)hshValues.get("waiver_surety"))%></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td colspan="2"  ><font size="1" face="MS Sans Serif">Margin 
                                money how met</font></td>
                              <td colspan="2"  > 
                                <textarea name="marginmoney" cols="70" readonly="readonly" rows="2" onKeyDown="textlimit(this,this.form.countdown,3900);" 
onKeyUp="textlimit(this,this.form.countdown,3900);"><%=Helper.correctNull((String)hshValues.get("margin_money"))%></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td colspan="2"  ><font size="1" face="MS Sans Serif">Eligible 
                                Amount</font></td>
                              <td colspan="2"  > 
                                <input type="text" name="eligibleamount" size="13"  maxlength="10"  readOnly onKeyPress="allowDecimals(this.value)" value="<%=Helper.correctNull((String)hshValues.get("eligible_amount"))%>" style="text-align:right" >
                              </td>
                            </tr>
                            <tr> 
                              <td colspan="4"  > 
                              <%if(loantype.trim().equalsIgnoreCase("H"))
                            	  { %>
                            	  
                            	   
                                <table width="77%" border="1" align="center" cellspacing="0" cellpadding="1" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  class="tabinactive">
                                  <tr class="tabactive"> 
                                    <td width="28%"> 
                                      <div align="center"><b><font size="1" face="MS Sans Serif" color= "#FFFFFF">Particulars</font></b></div>
                                    </td>
                                    <td width="23%"> 
                                      <div align="center"><b><font size="1" face="MS Sans Serif" color= "#FFFFFF">For 
                                        Salaried/Pension Class</font></b></div>
                                    </td>
                                    <td width="23%">  
                                      <div align="center"><b><font size="1" face="MS Sans Serif" color= "#FFFFFF">For 
                                        Business Class</font></b></div>
                                    </td>
                                    <td width="26%"> 
                                      <div align="center"><b><font size="1" face="MS Sans Serif" color= "#FFFFFF">For 
                                        Agriculturist </font></b></div>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="28%"> 
                                      <div align="left"><font size="1" face="MS Sans Serif" >As 
                                        per Income Criteria</font></div>
                                    </td>
                                   
                                    
                                    <td width="23%"> 
                                      <div align="center"> 
                                        <input type="text" name="incomesalary" readOnly size="10"  maxlength="10"   value="<%=Helper.correctNull((String)hshValues.get("income_salaried"))%>" style="text-align:right">
                                      </div>
                                    </td>
                                    
                                    <td width="23%"> 
                                      <div align="center"> 
                                        <input type="text" name="incomebusiness" readOnly size="10"  maxlength="10"   value="<%=Helper.correctNull((String)hshValues.get("income_business"))%>" style="text-align:right">
                                      </div>
                                    </td>
                                    <td width="26%"> 
                                      <div align="center"> 
                                        <input type="text" name="incomeagri" readOnly size="10"  maxlength="10"  value="<%//=Helper.correctNull((String)hshValues.get("income_agriculturist"))%>" style="text-align:right">
                                      </div>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="28%"> 
                                      <div align="left"><font size="1" face="MS Sans Serif">As 
                                        per Cutback Criteria</font></div>
                                    </td>
                                    <td width="23%"> 
                                      <div align="center"> 
                                        <input type="text" name="cutbacksalary" readOnly size="10"  maxlength="10"  value="<%=Helper.correctNull((String)hshValues.get("CUTBACK"))%>" style="text-align:right">
                                      </div>
                                    </td>
                                    <td width="23%"> 
                                      <div align="center"> <%//String cutback=Helper.correctNull((String)hshValues.get("cutbackc"));
                                     
                                      						//String cutbackcriteria="";
                                      					//	if(!cutback.trim().equalsIgnoreCase("0"))	
                                      					//		{
                                      					//			cutbackcriteria=cutback;
                                      					///			
                                      					//		}else if(cutback.trim().equalsIgnoreCase("0"))	
                                      					//		{
                                      					//			cutbackcriteria=Helper.correctNull((String)hshValues.get("cutback_business"));
                                      								
                                      					//		}
                                      					
                                      							%>
                                        <input type="text" name="cutbackbusiness" readOnly size="10"  maxlength="10"   value="<%=Helper.correctNull((String)hshValues.get("CUTBACK1"))%>" style="text-align:right">
                                      </div>
                                    </td>
                                    <td width="26%"> 
                                      <div align="center"> 
                                        <input type="text" name="cutbackagri" readOnly size="10"  maxlength="10"   value="<%//=Helper.correctNull((String)hshValues.get("cutback_agriculturist"))%>" style="text-align:right">
                                      </div>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="28%" height="23"> 
                                      <div align="left"><font size="1" face="MS Sans Serif">As per Cost of Project/Margin Criteria</font></div>
                                    </td>
                                    <td width="23%" height="23"> 
                                      <div align="center"> 
                                        <input type="text" name="marginsalary" readOnly size="10"  maxlength="10"   value="<%=Helper.correctNull((String)hshValues.get("margin_salaried"))%>" style="text-align:right">
                                      </div>
                                    </td>
                                    <td width="23%" height="23"> 
                                      <div align="center"> 
                                        <input type="text" name="marginbusiness" readOnly size="10"  maxlength="10"   value="<%=Helper.correctNull((String)hshValues.get("margin_business"))%>" style="text-align:right">
                                      </div>
                                    </td>
                                    <td width="26%" height="23"> 
                                      <div align="center"> 
                                        <input type="text" name="marginagri" readOnly size="10"  maxlength="10"   value="<%//=Helper.correctNull((String)hshValues.get("margin_agriculturist"))%>" style="text-align:right">
                                      </div>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="28%" height="19"><font size="1" face="MS Sans Serif">Proposed Loan Amount</font></td>
                                    <td align="center" height="19"><div align="center"> 
                                        <input type="text" name="amtrequestedprocess1" readOnly size="10"  maxlength="10"   value="<%=Helper.correctDouble((String)hshValues.get("amtrequestedprocess1"))%>" style="text-align:right">
                                      </div>
                                     
                                      </td>
                                      <td>&nbsp;</td>
                                      <td>&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td width="28%" height="19"><font size="1" face="MS Sans Serif">Age 
                                      Criteria</font></td>
                                    <td colspan="3" height="19"> 
                                      <input type="text" name="agecriteria" readOnly size="40"  maxlength="200"   value="<%=Helper.correctNull((String)hshValues.get("age_criteria"))%>">
                                    </td>
                                  </tr>
                                </table>
                                <%
                                }
                                %>
                              </td>
                            </tr>
                           <!--  <tr> 
                              <td colspan="2"><font size="1" face="MS Sans Serif">Repayment 
                                period requested</font></td>
                              <td colspan="2"> 
                                <input type="text" name="repayment" size="20"  maxlength="200"   value="<%//=Helper.correctNull((String)hshValues.get("repayment_requested"))%>">
                              </td>
                            </tr> -->
                            <tr> 
                              <td colspan="2" ><font size="1" face="MS Sans Serif">Whether 
                                the applicant has given a declatration that he/she 
                                does not own a house</font></td>
                              <td colspan="2"  > 
                                <select name="declaration" >
                                  <option value="S" selected>Select</option>
                                  <option value="Y">Yes</option>
                                  <option value="N">No</option>
								  <option value="A">Not Applicable</option>
                                </select>
                              </td>
                              
                            </tr>
                            <tr>
                            <td colspan="2" ><font size="1" face="MS Sans Serif">Whether 
                                CIBIL/RBI/ECGC List Verified<b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></font></td>
                              <td colspan="2"  > 
                                <select name="cibil" >
                                  <option value="S" selected>Select</option>
                                  <option value="Y">Yes</option>
                                  <option value="N">No</option>
                                </select>
                              </td>
                              </tr>
                                <tr>
                            <td colspan="2" ><font size="1" face="MS Sans Serif">Asset Classification  
                              <b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></font></td>
                              <td colspan="2"  > 
                                <select name="sel_asstclass" >
                                  <option value="S" selected>Select</option>
                                  <option value="Stand">Standard</option>
                                  <option value="Sub">Sub Standard</option>
                                </select>
                              </td>
                              </tr>
                              
                              
                               <tr>
                            <td colspan="2" ><font size="1" face="MS Sans Serif">Process Note No
                              <b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></font></td>
                              <td colspan="2"  > 
                               <input type="text" name="txt_procssno" size="20"  maxlength="200"   value="<%=Helper.correctNull((String)hshValues.get("per_processno"))%>">
                              </td>
                              </tr>
                           
                           <%if(strprdcode.equals("962") || strprdcode.equals("963") || strprdcode.equals("964") || strprdcode.equals("979")) {%>   
                            <tr>
                            <td colspan="2" ><font size="1" face="MS Sans Serif">Whether Existing or New Customer</font></td>
                              <td colspan="2"  > 
                                <select name="sel_existnewcust" onchange="getCustomername();">
                                  <option value="3" selected>Select</option>
                                  <option value="0">Existing</option>
                                  <option value="1">New</option>
                                  <option value="2">Not Applicable</option>
                                </select>
                              </td>
                              </tr>
                              
                              <tr id="custname">
                            <td colspan="2" ><font size="1" face="MS Sans Serif">If New,The Name of Present Banker and the reason for availing the facility from us</font></td>
                              <td colspan="2"  > 
                               <input type="text" name="txt_custname" size="30"  maxlength="40"   value="<%=Helper.correctNull((String)hshValues.get("per_custname"))%>">
                              </td>
                              </tr>
                              <tr id="exist">
                            <td colspan="2" ><font size="1" face="MS Sans Serif">Nature of Dealing</font></td>
                              <td colspan="2"  > 
                               <input type="text" name="txt_custname_exist" size="30"  maxlength="40"   value="<%=Helper.correctNull((String)hshValues.get("per_existdealing"))%>">
                              </td>
                              </tr>
                              
                              <tr>
                            <td colspan="2" ><font size="1" face="MS Sans Serif">Whether all the rules & Extant Guidelines Applicable to the Scheme are complied with</font></td>
                              <td colspan="2"  > 
                                <select name="sel_giudelines" >
                                  <option value="3" selected>Select</option>
                                  <option value="0">Yes</option>
                                  <option value="1">No</option>
                                  <option value="2">Not Applicable</option>
                                </select>
                              </td>
                              </tr>
                             <%} %>
                             
                             <%if(strprdcode.equals("963") || strprdcode.equals("964")) {%> 
                              <tr>
                            <td colspan="2" ><font size="1" face="MS Sans Serif">Whether the Total CutBack is within the NORM Fixed by Bank</font></td>
                              <td colspan="2"  > 
                                <select name="sel_bybank" >
                                  <option value="3" selected>Select</option>
                                  <option value="0">Yes</option>
                                  <option value="1">No</option>
                                  <option value="2">Not Applicable</option>
                                </select>
                              </td>
                              </tr>
                              <%} %>
                              
                            <%if(strprdcode.equals("965") || strprdcode.equals("966") || strprdcode.equals("977") || strprdcode.equals("978") || 
                            		strprdcode.equals("950") || strprdcode.equals("949") || strprdcode.equals("947") || strprdcode.equals("948") || strprdcode.equals("651") || strprdcode.equals("654") || strprdcode.equals("655")) {%>  
                               <tr>
                            <td colspan="2" ><font size="1" face="MS Sans Serif">Whether admission letter copy enclosed</font></td>
                              <td colspan="2"  > 
                                <select name="sel_letterenclosed" >
                                  <option value="3" selected>Select</option>
                                  <option value="0">Yes</option>
                                  <option value="1">No</option>
                                  <option value="2">Not Applicable</option>
                                </select>
                              </td>
                              </tr>
                              
                               <tr>
                            <td colspan="2" ><font size="1" face="MS Sans Serif">Whether student paid Ist year Ist Semester/1 term fees</font></td>
                              <td colspan="2"  > 
                                <select name="sel_feespaid" >
                                  <option value="3" selected>Select</option>
                                  <option value="0">Yes</option>
                                  <option value="1">No</option>
                                  <option value="2">Not Applicable</option>
                                </select>
                              </td>
                              </tr>
                              
                               <tr>
                            <td colspan="2" ><font size="1" face="MS Sans Serif">Whether estimate of expenditure obtained from college/institution submitted</font></td>
                              <td colspan="2"  > 
                                <select name="sel_estimatexpense" >
                                  <option value="3" selected>Select</option>
                                  <option value="0">Yes</option>
                                  <option value="1">No</option>
                                  <option value="2">Not Applicable</option>
                                </select>
                              </td>
                              </tr>
                              
                               <tr>
                            <td colspan="2" ><font size="1" face="MS Sans Serif">Whether student submitted application in AF-562 and obtained admission on the basis of merit through selection process</font></td>
                              <td colspan="2"  > 
                                <select name="sel_submitappl" >
                                  <option value="3" selected>Select</option>
                                  <option value="0">Yes</option>
                                  <option value="1">No</option>
                                  <option value="2">Not Applicable</option>
                                </select>
                              </td>
                              </tr>
                              
                               <tr>
                            <td colspan="2" ><font size="1" face="MS Sans Serif">Whether it is completed in all respects</font></td>
                              <td colspan="2"  > 
                                <select name="sel_completstatus" >
                                  <option value="3" selected>Select</option>
                                  <option value="0">Yes</option>
                                  <option value="1">No</option>
                                  <option value="2">Not Applicable</option>
                                </select>
                              </td>
                              </tr>
                              
                               <tr>
                            <td colspan="2" ><font size="1" face="MS Sans Serif">Parent / guardian of the student borrower shall join the transaction as joint borrower / co-obligant and shall be liable for repayment of the loan</font></td>
                              <td colspan="2"  > 
                                <select name="sel_repayloan" >
                                  <option value="3" selected>Select</option>
                                  <option value="0">Yes</option>
                                  <option value="1">No</option>
                                  <option value="2">Not Applicable</option>
                                </select>
                              </td>
                              </tr>
                              
                               <tr>
                            <td colspan="2" ><font size="1" face="MS Sans Serif">Education loan applicants for Rs. 4 lac and above shall invariably furnish PAN from IT authorities before availing loans. The PAN card will serve the dual purpose of KYC / identification of the student and facilitate tracking the students after completion of their studies as also payment of the tax to the Govt. when they get gainful employment after completion of the study</font></td>
                              <td colspan="2"  > 
                                <select name="sel_completstudy" >
                                  <option value="3" selected>Select</option>
                                  <option value="0">Yes</option>
                                  <option value="1">No</option>
                                  <option value="2">Not Applicable</option>
                                </select>
                              </td>
                              </tr>
                              
                               <tr>
                            <td colspan="2" ><font size="1" face="MS Sans Serif">Education loans are to be granted by the branches situated in proximity of the permanent residence/place of domicile of the student/parent/guardian. No deviation shall be made in this regard</font></td>
                              <td colspan="2"  > 
                                <select name="sel_deviation" >
                                  <option value="3" selected>Select</option>
                                  <option value="0">Yes</option>
                                  <option value="1">No</option>
                                  <option value="2">Not Applicable</option>
                                </select>
                              </td>
                              </tr>
                             <%} %> 
                              
                          </table>
							</div>
                        </td>
                      </tr>
                    </table>

                  </td>
                </tr>
              </table>
  <%String strappno = request.getParameter("appno");
  %>
    <lapschoice:combuttons  apporgcode="<%=strappno%>" strSource=""/>
<table>
<tr>
<td>
<input type="hidden" name="countdown" value="3900">
<input type="hidden" name="propertytype" value="<%=((String)hshValues.get("prop_type"))%>" >
<input type="hidden" name="hidstageprop" value="<%=((String)hshValues.get("prop_stage"))%>" >
<input type="hidden" name="hidqtyconst" value= "<%=((String)hshValues.get("prop_quality"))%>" >
<input type="hidden" name="hidlocationval" value= "<%=((String)hshValues.get("prop_loc_status"))%>" >
<input type="hidden" name="hidamenities" value= "<%=((String)hshValues.get("prop_amenity"))%>" >
<input type="hidden" name="hidmarketability" value = "<%=((String)hshValues.get("prop_market"))%>">

<INPUT TYPE="hidden" name="hidCoDemoId" value="<%=(String)request.getParameter("hidCoDemoId")%>" >
  <INPUT TYPE="hidden" name="hidDemoId" value="<%=(String)request.getParameter("hidDemoId")%>">
  <INPUT TYPE="hidden" name="hidGuaDemoId" value="<%=(String)request.getParameter("hidGuaDemoId")%>">
  <INPUT TYPE="hidden" name="hidAppType" value="">
<input type="hidden" name="hidAction" >
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidSourceUrl">
<INPUT TYPE="hidden" name="hidBeanGetMethod">
<input type="hidden" name="hideditflag" >
<input type="hidden" name="trapEdit" >
<input type="hidden" name="hidEditMode" >
<input type="hidden" name="hidEditLock" >

<INPUT TYPE="hidden" name="hiPgDist" value="P">
<INPUT TYPE="hidden" name="radLoan" value="Y">
<INPUT TYPE="hidden" name="page" value="ep">
<INPUT TYPE="hidden" name="hidApp_type" value="A">
<INPUT TYPE="hidden" name="hidauto_type">
<INPUT TYPE="hidden" name="newappid">
<INPUT TYPE="hidden" name="newapptype">
 <input type="hidden" name="sel_termstype"value="">
 <input type="hidden" name="hidPageValue">
</td>
</tr>
</form>
</body>
</html>

