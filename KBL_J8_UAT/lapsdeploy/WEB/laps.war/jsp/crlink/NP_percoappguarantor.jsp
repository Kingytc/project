<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*,java.io.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%

ArrayList arrRow=(ArrayList)hshValues.get("arrRow");
ArrayList arrCol=new ArrayList();
String loan_selecttype=Helper.correctNull(request.getParameter("loantype"));
if(loan_selecttype.length()==0)
{
	loan_selecttype=Helper.correctNull((String)hshValues.get("selecttype"));
}
String loanPrdType=Helper.correctNull((String) hshValues.get("prdcode"));
String pageType=Helper.correctNull((String)hshValues.get("pageType"));
String grpRights = Helper.correctNull((String) session.getAttribute("strGroupRights"));
String strEligibleRev = Helper.correctNull((String) session.getAttribute("strEligibleRev"));
String fromROInbox = Helper.correctNull((String)session.getAttribute("fromROInboxAgri"));
String PMAYValue=(String) session.getAttribute("PMAYValue");
String strApplicantMigval=Helper.correctNull((String)hshValues.get("ApplicantCBSIDMig"));
String strCanaraSyndBank=ApplicationParams.getStrCbsInterfaceflag();

String CIC_CheckFlag = Helper.correctNull((String)hshValues.get("CIC_CheckFlag"));
session.setAttribute("CIC_CheckFlag", CIC_CheckFlag);
String strCustCat = Helper.correctNull((String) hshValues.get("PERAPP_CUST_CATEGORY"));
String UniqueCustomerIdStatus=Helper.correctNull((String) hshValues.get("UniqueCustomerIdStatus"));
%>

<html>
<head>
<title>Personal - CoApplicant/Guarantor</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 300;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
</STYLE>

<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/nationalportal/psb59perapplicantdispco.js"> </script>
<script>
var strappeditsameregbranch="<%=session.getAttribute("HRBranchUserEdit")%>";
var loan_selecttype="<%=loan_selecttype%>";
var loan_prdType="<%=Helper.correctNull((String) hshValues.get("prdcode"))%>";
var pageType="<%=Helper.correctNull((String)hshValues.get("pageType"))%>";
var varstrBranchMigval="<%=Helper.correctNull((String)session.getAttribute("BranchMigValue"))%>";
var varApplicantMigVal="<%=strApplicantMigval%>";
var varUniqueCustomerIdStatus="<%=UniqueCustomerIdStatus%>";
function callRelation()
{
	if(document.forms[0].cmdapply.disabled!=true)
	{
		var purl = appURL+"action/relations.jsp";
		prop = "scrollbars=yes,width=300,height=400,statusbar=yes,menubar=no";	
		xpos = (screen.width - 600) / 2;
		ypos = (screen.height - 400) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		var title = "Print";
		window.open(purl,title,prop);
	}
}
function docalReload()
{
	if(pageType=="agri")
	{
	document.forms[0].hidBeanId.value="agriapplicant";
	document.forms[0].hidBeanGetMethod.value="getLoanProducts";
	document.forms[0].action=appURL+"action/agriLoanDetails_Canara.jsp";
	document.forms[0].submit();
	}
	else
	{
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].hidBeanGetMethod.value="getLoanProducts";
		document.forms[0].action=appURL+"action/perloandetails.jsp";
		document.forms[0].submit();
	}
}
function callhelp()
{

	    var varQryString = appURL+"/jsp/perhlp/hlp_applicantCoapp.jsp";
	    var title = "ApplicantDemographics";
		var prop = "scrollbars=no,width=600,height=450";	
		prop = prop + ",left=200,top=150";
		window.open(varQryString,title,prop);
}
function callCoAppIDHelp()
{
	if(document.forms[0].hidEditFlagfornsdl.value =="y")
	{
		return;
	}
			if(document.forms[0].seltype.value=="S")
			{
				alert("Select Applicant Type");
				return;
			}
			//hidapplicantid is available in Applicant Header Taglib
			var value1=document.forms[0].hidapplicantid.value;
			var apptype = document.forms[0].seltype.value;
			var	varQryString = appURL+"action/perapp_coappguar_serarchcustid.jsp?appno="+"<%=(String)request.getParameter("appno")%>"+"&pageType="+pageType;
			var title = "ApplicantIDHelp";
			var prop = "scrollbars=no,width=500,height=400";	
			var xpos = (screen.width - 450) / 2;
			var ypos = (screen.height - 400) / 2;
			prop = prop + ",left="+xpos+",top="+ypos;
			window.open(varQryString,title,prop);
}
function callPMAYFunction()
{
	document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].hidBeanGetMethod.value="getPmayDetails";
	document.forms[0].action=appURL+"action/pmaydetails.jsp";
	document.forms[0].submit();
	
}
function callApply()
{

	if(varUniqueCustomerIdStatus=="Y")
	{
		alert("Kindly Enter Unique Customer Id for Co-Applicant/Gurantor");
		return;
	}

	var len=document.forms[0].appid.length;
		var id = document.forms[0].hidCoDemoId.value;
		var cbsid = document.forms[0].hidCoDemoCBSId.value;
		var name= document.forms[0].txtloan_cname.value;
		var bool = false;
		if(name == "")
		{
		alert("Select CoApplicant/Guarantor Name");
		return;
		}
		
		if(len==null && cbsid==document.forms[0].cbsappid.value)
		{
		if(document.forms[0].hidAction.value !="update")
		{
			alert("Selected Data is already Available");
			//bool = true;
			//return;
		}
		}
		else
		{
			for(i=0;i<len;i++)
			{
				if(document.forms[0].hidAction.value !="update")
				{
					if(cbsid==document.forms[0].cbsappid[i].value)
					{
						alert("Selected Data is already Available");
					//bool = true;
					//return;
					}
				}
			}
			
		}
		if(document.forms[0].txt_custrelation.value =="")
		{
			alert("Select Customer Relationship");
			return;
		}
		document.forms[0].seltype.disabled=false;
		document.forms[0].hidBeanGetMethod.value="getCoAppGuarantor";
		document.forms[0].hidBeanMethod.value="updateCoAppGuarantor";
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].hidSourceUrl.value="/action/percoappguarantor.jsp";		
		document.forms[0].submit();
}
function callDelete()
{
		var atype = document.forms[0].seltype.value;
		var atext = "";
		if (atype=="g")
		{
		atext = "guarantor?";
		}
		else
		{
		atext = "co-applicant?";
		}
		if(confirm("Do you want to delete "+atext))
		{
		document.forms[0].seltype.disabled=false;
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanMethod.value="updateCoAppGuarantor";
		document.forms[0].hidBeanGetMethod.value="getCoAppGuarantor";
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/percoappguarantor.jsp";	
		document.forms[0].submit();
		}

}

function callEdit()
{
	document.forms[0].hidEditFlagfornsdl.value ="y";
	document.forms[0].seltype.disabled=false;
	document.forms[0].txtrelation.readOnly=true;  
	document.forms[0].hidAction.value="update";
	document.forms[0].txt_custrelation.disabled=false; 
	disabledButtons(true,false,false,true,true,true)
}

function callAdd()
{
	document.forms[0].seltype.disabled=false;
	document.forms[0].txtrelation.value="";
	document.forms[0].seltype.value="S";
	document.forms[0].txtloan_cname.value="";
	document.forms[0].txt_custrelation.value="";
	document.forms[0].hidDemoId.value="";
	document.forms[0].hidAction.value="insert";
	disabledButtons(true,false,false,true,true,true)

	document.forms[0].txt_custrelation.disabled=false;     
}
function callDisableControls(cmdEdit,cmdApply,cmdDelete,cmdCancel,cmdClose,editflag)
{
	document.forms[0].cmdAdd.disabled=cmdEdit;
	document.forms[0].cmdapply.disabled=cmdApply;
	document.forms[0].cmdDelete.disabled=cmdDelete;
	document.forms[0].cmdCancel.disabled=cmdCancel;
	document.forms[0].cmdClose.disabled=cmdClose;
	document.forms[0].cmdEdit.disabled=editflag;
}

function disabledButtons(a,b,c,d,e,f){
	document.forms[0].cmdAdd.disabled=a;
	document.forms[0].cmdapply.disabled=b;
	document.forms[0].cmdCancel.disabled=c;
	document.forms[0].cmdDelete.disabled=d;
	document.forms[0].cmdClose.disabled=e;
	document.forms[0].cmdEdit.disabled=f;
}

function selApplicant()
{
	var varshowField="";
	var len=document.forms[0].appid.length;
	if(len==null)
	{
	document.forms[0].hidCoDemoCBSId.value=document.forms[0].cbsappid.value;
	document.forms[0].hidCoDemoId.value=document.forms[0].appid.value;
	document.forms[0].seltype.value=document.forms[0].coapptype.value;
	document.forms[0].txtloan_cname.value=document.forms[0].coappname.value;
	document.forms[0].txtrelation.value=document.forms[0].corelation.value;
	document.forms[0].txt_custrelation.value=document.forms[0].cbsmigcorelation.value;
	varshowField=document.forms[0].cbsmigshow.value;
	}
	else
	{
		for(i=0;i<len;i++)
		{
		if(document.forms[0].appid[i].checked==true)
		{
		document.forms[0].hidCoDemoCBSId.value=document.forms[0].cbsappid[i].value;
		document.forms[0].hidCoDemoId.value=document.forms[0].appid[i].value;
		document.forms[0].seltype.value=document.forms[0].coapptype[i].value;
		document.forms[0].txtloan_cname.value=document.forms[0].coappname[i].value;
		document.forms[0].txtrelation.value=document.forms[0].corelation[i].value;
		document.forms[0].txt_custrelation.value=document.forms[0].cbsmigcorelation[i].value;
		varshowField=document.forms[0].cbsmigshow[i].value;
		break;
		}
		}
	}
	//alert(document.forms[0].txt_custrelation.value);
	if((document.forms[0].txt_custrelation.value !="") || (varshowField=="YES"))
	{
		document.all.cbsrelationship.style.visibility="visible";
		document.all.cbsrelationship.style.position="relative";
		
	}
	else
	{
		document.all.cbsrelationship.style.visibility="hidden";
		document.all.cbsrelationship.style.position="absolute";
	}
	document.forms[0].cmdDelete.disabled=false;
	
	var appstatus=document.forms[0].appstatus.value;
	if(appstatus=="Closed/Approved" || appstatus=="Processed/Approved")
	{
		document.forms[0].cmdDelete.disabled=true;
		document.forms[0].cmdEdit.disabled = true;
	}
	else
	{
		document.forms[0].cmdEdit.disabled = false;
	}

	if(loan_prdType == "975" || loan_prdType == "935" || loan_prdType == "985" || loan_prdType == "940" || loan_prdType == "651" || loan_prdType == "654" || loan_prdType == "655" || pageType=="agri")
	{
		document.all.cbsrelationship.style.visibility="visible";
		document.all.cbsrelationship.style.position="relative";
		
	}
	else
	{
		document.all.cbsrelationship.style.visibility="hidden";
		document.all.cbsrelationship.style.position="absolute";
	}

}

function callProposedAsset()
{
	if(!document.forms[0].cmdapply.disabled)
	{
		ShowAlert('103');
	}
	else
	{
		//document.forms[0].hidBeanId.value="perpropertydetails";
		//document.forms[0].hidBeanGetMethod.value="getData";
	if(loan_selecttype=="H" || (loan_selecttype=="C"&& (loan_prdType=="965" || loan_prdType=="966"  || loan_prdType=="977" || loan_prdType=="978" || loan_prdType=="985" || loan_prdType=="940"
		|| loan_prdType=="949" || loan_prdType=="950"  || loan_prdType=="947" || loan_prdType=="948" || loan_prdType=="651" || loan_prdType=="654" || loan_prdType=="655" )))
	{
		//if(document.forms[0].trapEdit.value.toUpperCase()!="TE")
		//{
		document.forms[0].action=appURL+"action/perpropertydetails.jsp";
		document.forms[0].submit();
		//}
	}else if(loan_selecttype=="V")
	{
		var varappid="a"+document.forms[0].hidapplicantid.value;
		document.forms[0].hidBeanId.value="percollateral";
		document.forms[0].hidBeanGetMethod.value="getBoatAuto";
		document.forms[0].action=appURL+"action/perappvehicle.jsp?selapptype="+varappid;
		document.forms[0].submit();
	}
	}
}


function callEmployer()
{
	
	if(!document.forms[0].cmdapply.disabled)
	{
		ShowAlert('103');
	}
	else
	{
		document.forms[0].hidBeanGetMethod.value="getEmployer";
		document.forms[0].action=appURL+"action/peremployerdisp.jsp?applnt=P";
		document.forms[0].submit();
	}
}

function callIncomeExpenses()
{
	if(!document.forms[0].cmdapply.disabled)
	{
		ShowAlert('103');
	}
	else
	{
		document.forms[0].hidAppType.value="";
			document.forms[0].hidBeanGetMethod.value="getIncome";
			document.forms[0].action=appURL+"action/perincexpensesdisp.jsp?applnt=P";
			document.forms[0].submit();
	}
	
}

function loanDetails()
{	
	if(!document.forms[0].cmdapply.disabled)
	{
		ShowAlert('103');
	}
	else
	{
		document.forms[0].hidBeanGetMethod.value="getLoanProducts";
		document.forms[0].hidBeanId.value="NationalPortal";
	
	if(pageType=="agri")
	{
		<%if(strCanaraSyndBank.equalsIgnoreCase("S")){%>
  		document.forms[0].action=appURL+"action/agriLoanDetails.jsp";
  		<%}else{%>
  		document.forms[0].action=appURL+"action/agriLoanDetails_Canara.jsp";
  		<%}%>
	}
	else
	{	
		document.forms[0].action=appURL+"action/NP_Perloandetails.jsp";
	}
		document.forms[0].submit();
	}
}

function callCancel()
{
	document.forms[0].hidBeanGetMethod.value="getCoAppGuarantor";
	document.forms[0].hidBeanId.value="NationalPortal";
	document.forms[0].action=appURL+"action/NP_percoappguarantor.jsp";
	document.forms[0].submit();
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/perexisting.jsp";
		document.forms[0].submit();
	}
}

function onloading()
{
	if(strappeditsameregbranch!="")
	{
		if(strappeditsameregbranch=="disablefalse")
		{
			callDisableControls(false,true,true,true,false,true);
		}
		else if(strappeditsameregbranch=="disabletrue")
		{
			callDisableControls(true,true,true,true,false,true);
		}
	}		
var appstatus=document.forms[0].appstatus.value;

if(appstatus=="Closed/Approved" || appstatus=="Processed/Approved")
{
	disabledButtons(true,true,true,true,false,true);
}


if((document.forms[0].appstatus.value=="Processed/Rejected") || (document.forms[0].appstatus.value=="Processed/Approved"))
{
	disabledButtons(true,true,true,true,false,true);
}


}

function callnomineesdetails()
{
	if(document.forms[0].cmdapply.disabled==false)
	{
		ShowAlert(103);
		return;
	}
	else
	{
	document.forms[0].hidBeanId.value="agrlandholdings";
	document.forms[0].hidBeanGetMethod.value="getnomineesmembersData";
	document.forms[0].action=appURL+"action/agri_nominees.jsp";
	document.forms[0].submit();
	}
}



function showappholder()
{
	document.getElementById("img_loadder").style.display="none";
	if((document.forms[0].hid_appholder.value=="N") || (document.forms[0].appstatus.value=="Processed/Rejected") || (document.forms[0].appstatus.value=="Processed/Approved"))
	{
		callDisableControls(true,true,true,true,false,true);
	}	
}


function callResturcture()
{
	if(document.forms[0].cmdapply.disabled==false)
	{
		ShowAlert(103);
		return;
	}
	else
	{
	document.forms[0].hidBeanId.value="agriapplicant";
	document.forms[0].hidBeanGetMethod.value="getRestructureLoan";
	document.forms[0].action=appURL+"action/Agr_RestructureDetails.jsp";
	document.forms[0].submit();
	}
}

function callEligibleReview()
{
	if(document.forms[0].cmdapply.disabled == false)
	{	
		ShowAlert(103);
		return;
	}
	else
	{
	document.getElementById("img_loadder").style.display="block";
	document.forms[0].hidBeanId.value="perapplicant";
	if(pageType=="agri")
	{
		document.forms[0].hidBeanGetMethod.value="get_Canara_EligibleRev";
		document.forms[0].action=appURL+"action/eligiblereviewAgri.jsp";
	}
	else
	{
		document.forms[0].hidBeanGetMethod.value="getEligibleRev";
		document.forms[0].action=appURL+"action/eligiblereview.jsp";	
	}
	document.forms[0].submit();
	}
}

function callView(DocName,Appid,cibilidv,reportName)
{
	if(reportName =="IDV" && cibilidv =="NO")
	{
		alert("IDV Report Not Available.");
		return;
	}
	//var	varQryString = appURL+"action/iframecreditreportView.jsp?hidBeanId=cibilInterface&hidBeanGetMethod=viewTUEFData&viewReport=yes&fileno="+
						//DocName+"&hidinwardId=12345&txtperapp_appid="+Appid+"&htmlNumbers=371";
	var	varQryString = appURL+"action/iframecreditreportView.jsp?hidBeanId=cibilInterface&hidBeanGetMethod=viewCIBILIDVData&UserOption="+reportName+"&filename="+DocName+"&newApi="+cibilidv+"&txtperapp_appid="+Appid;
	var prop = "scrollbars=yes,width=1200,height=550,menubar=yes,toolbar=yes";	
	var xpos = (screen.width - 1200) / 2;
	var ypos = (screen.height - 550) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(varQryString,'title',prop);
}
function callChangeRelation()
{
	//alert(document.forms[0].txt_custrelation.value);
	if(document.forms[0].hidApplicantrel.value =="SOW" && document.forms[0].seltype.value =="c")
	{
		if(loan_prdType == "975" || loan_prdType == "935" || loan_prdType == "985" || loan_prdType == "940" || loan_prdType == "651" || loan_prdType == "654" || loan_prdType == "655" || pageType=="agri")
		{
			alert("Relationship is Invalid.Please Select Relationship in Borrower Page Correctly.");
			document.forms[0].txt_custrelation.value="";
			return;
		}
	}
	if(document.forms[0].hidApplicantrel.value =="JOF" && document.forms[0].seltype.value =="c")
	{
		if(document.forms[0].txt_custrelation.value !="JOO")
		{
			alert("Co-borrower Relation should be JOO.");
			document.forms[0].txt_custrelation.value="";
			return;
		}
	}
	if(document.forms[0].hidApplicantrel.value =="JAF" && document.forms[0].seltype.value =="c")
	{
		if(document.forms[0].txt_custrelation.value !="JAO")
		{
			alert("Co-borrower Relation should be JAO.");
			document.forms[0].txt_custrelation.value="";
			return;
		}
	}
	//alert(document.forms[0].txt_custrelation.value);
	if(document.forms[0].seltype.value =="g")
	{
		if(document.forms[0].txt_custrelation.value !="GUA")
		{
			alert("Relationship is Invalid.Please Select Relationship Guarantor Only");
			document.forms[0].txt_custrelation.value="";
			return;
		}
	}
			
}
function getCicScoreEdu()
{
	var appnumber="<%=(String)request.getParameter("appno")%>";
	var url=appURL+"action/cicScore_hevp.jsp?hidBeanId=perapplicant&hidBeanGetMethod=hevpCicScoreRecords&appnumber="+appnumber; 
	var prop="scrollbars=yes,menubar=yes,width=1200,height=600,top=30,left=30";
	window.open(url,"hai",prop);
	
	/*var varCibilLapsId="demo";
	var	varQryString = appURL+"action/cicScore_hevp.jsp?hidBeanId=perapplicant&hidBeanGetMethod=hevpCicScoreRecords&txtperapp_appid="+varCibilLapsId+"&appnumber="+appnumber;
	var prop = "scrollbars=yes,width=1200,height=550,menubar=yes,toolbar=yes";	
	var xpos = (screen.width - 1200) / 2;
	var ypos = (screen.height - 550) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(varQryString,'title',prop);	*/
}
function getRiskAnalysis()
{
	var appnumber="<%=(String)request.getParameter("appno")%>";
	var url=appURL+"action/Agri_RiskAnalysis.jsp?hidBeanId=agriapplicant&hidBeanGetMethod=getRiskAnalysis_Agri&appnumber="+appnumber; 
	var prop="scrollbars=yes,menubar=yes,width=1200,height=600,top=30,left=30";
	window.open(url,"hai",prop);

}
</script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body  text="#000000"  vlink="#330000" alink="#330000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="onloading();showappholder()" class="bgcolor">
<jsp:include page="../share/help.jsp" flush="true"> </jsp:include>
<form name="appform" method="post" action="">
  <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td id="mainlnk1"> 
      <%if(pageType.equals("agri")){ %>
      <jsp:include page="../agri/Applurllinkagri.jsp" flush="true" > 
        <jsp:param name="pageid" value="1" />
        </jsp:include>
      <%}else{ %>
        <jsp:include page="../nationalportal/ApplurllinkNP.jsp" flush="true" > 
        <jsp:param name="pageid" value="1" />
        </jsp:include>
        <%} %>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
    <%if(pageType.equals("agri")){%>
    <td class="bredcrumb">Home <span class="bredcrumbArw">&gt; </span> &nbsp; Agriculture <span class="bredcrumbArw"> &gt; </span> &nbsp; <%
 	if (session.getAttribute("link").equals("EXI")
 			|| session.getAttribute("link").equals("App")) {
 		out.print("Existing");
 	} else {
 		out.print("New");

 	}
 %> <span class="bredcrumbArw"> &gt; </span> &nbsp; Applicant</td>
    <%} else{%>
       <td class="bredcrumb">Home <span class="bredcrumbArw">&gt; </span> &nbsp; Retail <span class="bredcrumbArw"> &gt; </span> &nbsp; <%
 	
 %> <span class="bredcrumbArw"> &gt; </span> &nbsp; Applicant</td> <%} %>
    </tr>
  </table>
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr> 
      <td id="mainlnk1"> <lapschoice:application /> </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertablecolor">
    <tr> 
      <td colspan="2" valign="bottom"> 
        <table width="60%" border="0" cellspacing="3" cellpadding="3" align="left">
          <tr align="center"> 
            <td width="15%" class="tabinactive"><b><font size="1" face="MS Sans Serif"><a href="JavaScript:loanDetails()" class="blackfont">LoanProduct</a></font></b></td>
<%
				if (loan_selecttype.equalsIgnoreCase("H") ||  loan_selecttype.equalsIgnoreCase("V"))//|| (loan_selecttype.equalsIgnoreCase("C") && (loanPrdType.equals("765") || loanPrdType.equals("966") || loanPrdType.equals("977") || loanPrdType.equals("978") || loanPrdType.equals("985")))) {
					{
				%>
				            <td width="15%"  height="16" class="tabinactive" ><b><font size="1" face="ms sans serif"><a href="javascript:callProposedAsset()" class="blackfont">Proposed  Asset</a></font></b></td>
            <%}%>
             <td width="15%" id="employertdbtn1" class="tabactive"  ><font face="MS Sans Serif" size="1"><b><font color="#FFFFFF">Co-Applicant 
              / Guarantor</font></b></font></td>
              <%if(pageType.equals("agri")){ %>
              <% if((loanPrdType.equalsIgnoreCase("840")) || (loanPrdType.equalsIgnoreCase("812")) || (loanPrdType.equalsIgnoreCase("895")))
					{
					%>
              <td width="15%" height="16" class="tabinactive"><font
					face="MS Sans Serif" size="1"><b><font color="#CCCCCC"><a
					href="JavaScript:callnomineesdetails()" class="blackfont">Nominees Details</a></font></b></font></td>
					<%}%>
              <%}%>
				
				<% if(loanPrdType.equalsIgnoreCase("838"))
												{
												%>
						
					 <td width="15%" height="16" class="tabinactive"><font
					face="MS Sans Serif" size="1"><b><font color="#CCCCCC"><a
					href="JavaScript:callResturcture()" class="blackfont">Restructure Details</a></font></b></font></td>
					
					<%}%>
					
				<td width="15%" height="16" class="tabinactive"><font
					face="MS Sans Serif" size="1"><b><font color="#CCCCCC"><a
					href="JavaScript:callEligibleReview()" class="blackfont"> Eligible for Review </a></font></b></font></td>
					 <%if((loan_selecttype.equalsIgnoreCase("H")) && (PMAYValue.equalsIgnoreCase("1"))){%>
				<td width="15%" height="16" class="tabinactive"><b><font
					size="1" face="ms sans serif"><a
					href="javascript:callPMAYFunction()" class="blackfont">PMAY House Details</a></font></b></td>
				<%} %>				
		</tr>
        </table>
      </td>
    </tr>
    <tr><td align="center"><img id="img_loadder" src="<%=ApplicationParams.getAppUrl()%>/img/loading.gif"/ style="height: 50px;" ></td></tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center" class="outertablecolor">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr align="center"> 
                  <td colspan="2"> 
                    <p>&nbsp;</p>
                    <table width="61%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
                      <tr> 
                        <td width="29%"> 
                          <div align="left"><font face="MS Sans Serif" size="1">Select 
                            Applicant Type</font></div>
                        </td>
                        <td width="71%"> 
                          <div align="left"> 
                            <select name="seltype" style="width:100" disabled>
                              <option value="S" selected>&lt;-- Select --&gt;</option>
                              <option value="c">Co-Applicant</option>
                              <option value="g">Guarantor</option>
                               <option value="d">Director/Partner</option>
                          <%if(strCustCat.equalsIgnoreCase("C")){ %>
                          <option value="AU">Authorized Signatory</option>
                          <%} %>
                            </select>
                          </div>
                        </td>
                      </tr>
                      <tr> 
                        <td width="29%"> 
                          <div align="left"><font size="1" face="MS Sans Serif">Name 
                            of the Person<font size="1" face="MS Sans Serif" color="#FF0000">*</font></font></div>
                        </td>
                        <td width="71%"> 
                          <div align="left">
                            <input type="text" name="txtloan_cname" size="50" readOnly>
                            <span onClick="javascript:callCoAppIDHelp()" style="cursor:hand"><font face="MS Sans Serif" size="1"><b>
                            <img src="<%=ApplicationParams.getAppUrl()%>img/Search.png" style="border: none" align="middle" height="25px">                     
                            </b></font></span></div>
                        </td>
                      </tr>
					   <tr> 
                        <td width="29%"> 
                          <div align="left"><font face="MS Sans Serif" size="1">Relationship with the Applicant</font></div>
                        </td>
                        <td width="71%"> 
                          <div align="left">
                            <input type="text" name="txtrelation" size="25" readOnly>
                             <span onClick="javascript:callRelation()" style="cursor:hand"><font face="MS Sans Serif" size="1"><b>
                             <img src="<%=ApplicationParams.getAppUrl()%>img/Search.png" style="border: none" align="middle" height="25px">                    
                            </b></font></span>
                          </div>
                        </td>
                      </tr>
                     
                      <tr id="cbsrelationship" >  
                        <td width="29%"> 
                          <div align="left"><font face="MS Sans Serif" size="1">Customer Relationship</font></div>
                        </td>
                        <td width="71%"> 
                          <div align="left" >
                            <select name="txt_custrelation" style="width:100" 
								tabindex="5" onchange="callChangeRelation()" disabled>
								<option value="">---Select---</option>
								<lapschoice:StaticDataTag  apptype="41"/>
							</select>
                          </div>
                        </td>
                      </tr>
                    </table>
                   
                    <br>
                    <table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
                      <tr> 
                        <td> 
                          <table border="0" cellspacing="0" cellpadding="2" align="center">
                          
                            <tr valign="top"> 
                              <td> 
                                <input type="button" name="cmdAdd" value="Add" style="width:50" class="buttoncolor" onClick="callAdd()">
                              </td>
                              <td> 
                                <input type="button" name="cmdEdit" value="Edit" style="width:50" class="buttoncolor" onClick="callEdit()">
                              </td>
                              <td> 
                                <input type="button" name="cmdapply" value="Apply" style="width:50" class="buttoncolor"  onClick="callApply()" disabled>
                              </td>
                              <td> 
                                <input type="button" name="cmdCancel" value="Cancel" style="width:50" class="buttoncolor"  onClick="callCancel()" disabled>
                              </td>
                              <td> 
                                <input type="button" name="cmdDelete" value="Delete" style="width:50" class="buttoncolor"   onClick="callDelete()" disabled>
                              </td>
                              <td> 
                                <input type="button" name="cmdHelp" value="Help" style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="callhelp()">
                              </td>
                              <td> 
                                <div align="center"> 
                                  <input type="button" name="cmdClose" value="Close" onClick="doClose()" style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
                                </div>
                              </td>
                              <%if(strCustCat.equalsIgnoreCase("C")){ %>
                              
                              <%}else{ %>
                               <td> 
                                <div align="center"> 
                                  <input type="button" name="cmdCicScore" value="Link CIC Score" onClick="getCicScoreEdu()" style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:100">
                                </div>
                              </td>
                              <%} %>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr align="center"> 
                  <td colspan="2"> 
                    <table width="90%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
                      <tr> 
                        <td valign="top"> 
                          <div align="left"> 
                            <table width="100%" border="0" >
                              <tr> 
                                <td width="5%" class="tabactive">&nbsp;</td>
                                <td width="15%" class="tabactive"> 
                                  <div align="center"><font color="#FFFFFF"><font face="MS Sans Serif" size="1">Name 
                                    of the Person</font></font></div>
                                </td>
                                <td width="15%" class="tabactive"> 
                                  <div align="center"><font color="#FFFFFF"><font face="MS Sans Serif" size="1">Type</font></font></div>
                                </td>
                                <td width="15%" class="tabactive"> 
                                  <div align="center"><font color="#FFFFFF" face="MS Sans Serif" size="1">Relationship</font></div>
                                </td>
                                <%if(!Helper.correctNull((String)hshValues.get("NOCIBIL")).equalsIgnoreCase("NOCIBIL") &&(arrRow.size()>0)){ %>
                                <td width="15%" class="tabactive"> 
                                  <div align="center"><font color="#FFFFFF" face="MS Sans Serif" size="1">CIBIL Score</font></div>
                                </td>
                                 <td width="15%" class="tabactive"> 
                                  <div align="center"><font color="#FFFFFF" face="MS Sans Serif" size="1">Personal CIBIL Score</font></div>
                                </td>
                                <td width="15%" class="tabactive"> 
                                  <div align="center"><font color="#FFFFFF" face="MS Sans Serif" size="1">CIBIL Report</font></div>
                                </td>
                                <%} %>
                              </tr>
                              <%
					if(arrRow.size()>0)
					{
						for(int i=0;i<arrRow.size();i++)
						{
						arrCol = (ArrayList)arrRow.get(i);
					%>
                              <tr> 
                                <td width="5%"  bgcolor="#FFFFFF" align="left"> <font size="1" face="MS Sans Serif"> 
                                  <input type="radio" name="appid" value="<%=arrCol.get(0)%>" style="border-style:NONE" onClick="selApplicant()">
                                    <input type="hidden" name="cbsappid" value="<%=arrCol.get(4)%>" >
                                  </font></td>
                                <td width="15%"  bgcolor="#FFFFFF" align="center"><font size="1" face="MS Sans Serif"> 
                                  &nbsp; 
                                  <input type="hidden" name="coappname" value="<%=arrCol.get(1)%>">
                                  <%=arrCol.get(1)%></font></td>
                                <td width="15%"  bgcolor="#FFFFFF" align="center"><font size="1" face="MS Sans Serif"> 
                                  &nbsp; 
                                  <input type="hidden" name="coapptype" value="<%=arrCol.get(2)%>">
                                  <%
					  String type = (String)arrCol.get(2);
					  if(type.equals("c"))
					  {
					  type="Co-Applicant";
					  }
					  else if (type.equals("g"))
					  {
					  type="Guarantor";
					  }
					  else if(type.equals("A"))
					  {
						  type ="Authorized Signatory";
					  }
					  else
					  {
						  type ="Director/Partner";
					  }
					  out.println(type);

					  %>
                                  </font></td>
                                <td width="15%"  bgcolor="#FFFFFF" align="center"><font size="1" face="MS Sans Serif"> 
                                  &nbsp; 
                                  <input type="hidden" name="corelation" value="<%=Helper.correctNull((String)arrCol.get(3))%>">
                                  <input type="hidden" name="cbsmigcorelation" value="<%=Helper.correctNull((String)arrCol.get(8))%>">
                                  <%=Helper.correctNull((String)arrCol.get(3))%></font>
                                  <input type="hidden" name="cbsmigshow" value="<%=Helper.correctNull((String)arrCol.get(9))%>">
                                  </td>
                                  
                                   <%if(!Helper.correctNull((String)hshValues.get("NOCIBIL")).equalsIgnoreCase("NOCIBIL")){ %>
                                <td width="15%"  bgcolor="#FFFFFF" align="center"><font size="1" face="MS Sans Serif"> 
                                  <b>&nbsp;<%=Helper.correctNull((String)arrCol.get(5))%></b>
                                   </font></td>
                                  <td width="15%"  bgcolor="#FFFFFF" align="center"><font size="1" face="MS Sans Serif"> 
                                  <b>&nbsp;<%=Helper.correctNull((String)arrCol.get(7))%></b>
                                   </font></td>
                                   <td width="15%"  bgcolor="#FFFFFF" > 
                                  <input type="button" name="cmdView" value="CIR Report" 
                                  style="width:70" class="buttoncolor" onClick="callView('<%=Helper.correctNull((String)arrCol.get(6))%>',
                                  '<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(10))%>','CIR');">
                                  <input type="button" name="cmdView" value="IDV Report" 
                                  style="width:70" class="buttoncolor" onClick="callView('<%=Helper.correctNull((String)arrCol.get(6))%>',
                                  '<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(10))%>','IDV');">  </td>
                                  <%} %>
                              </tr>
                              <%
					}
					}else
					{
					%>
                              <input type="hidden" name="coapptype" value="">
                              <input type="hidden" name="coappname" value="">
                              <input type="hidden" name="appid" value="">
                               <input type="hidden" name="cbsappid" value="">
                              <input type="hidden" name="corelation" value="">
                              <input type="hidden" name="cbsmigcorelation" value="">
                              <input type="hidden" name="cbsmigshow" value="">
                              <%
					}
					%>
                            </table>
                          </div>
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
  <INPUT TYPE="hidden" name="hidEditFlagfornsdl">
  <INPUT TYPE="hidden" name="hidApp_type" value='A'>
  <input type="hidden" name="hidBeanMethod" >
  <input type="hidden" name="hidBeanId" >
  <input type="hidden" name="hidSourceUrl" >
  <input type="hidden" name="hidBeanGetMethod" >
  <INPUT TYPE="hidden" name="page" value="ep">
 <INPUT TYPE="hidden" name="hidAppType">
  <INPUT TYPE="hidden" name="hiPgDist" value="P">
  <INPUT TYPE="hidden" name="radLoan" value="Y">
  <!--- modified for proposed by harini-->
  <input type="hidden" name="hideditflag" >
  <input type="hidden" name="hidAction" >
  <input type="hidden" name="trapEdit" >
  <INPUT TYPE="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)request.getParameter("hidDemoId"))%>">
  <INPUT TYPE="hidden" name="hidCoDemoId" value="">
  <INPUT TYPE="hidden" name="hidCoDemoCBSId" value="">
   <INPUT TYPE="hidden" name="hidDemoCBSId" value="">
  
  <input type="hidden" name="bowid" value ="<%=Helper.correctNull((String)session.getAttribute("bowid"))%>" >
<INPUT TYPE="hidden" name="loantype" value="<%=Helper.correctNull((String)request.getParameter("selecttype"))%>">
<INPUT TYPE="hidden" name="hidauto_type" value="C">
<input type="hidden" name="pageType" value="<%=Helper.correctNull((String)hshValues.get("pageType"))%>">
<input type="hidden" name="hidApplicantrel" value="<%=Helper.correctNull((String)hshValues.get("ApplicantRelation")) %>" >
</form>
</body>
</html>
 