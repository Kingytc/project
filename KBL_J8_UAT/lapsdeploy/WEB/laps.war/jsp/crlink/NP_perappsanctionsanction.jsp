<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>

<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="strOrgCode" class="java.lang.String" scope="session" />
<%
//out.println(hshValues);
HashMap hshRecord1 = (HashMap) hshValues.get("hshRecord1");

ArrayList arrApplicantDoc =(ArrayList) hshValues.get("arrApplicantDoc");
//out.println(arrApplicantDoc);
ArrayList arrInternalDoc =(ArrayList) hshValues.get("arrApplicantDoc");
ArrayList arrInternalNotSubDoc =(ArrayList) hshValues.get("arrInternalNotSubDoc");
//out.println(arrInternalNotSubDoc);
ArrayList arrInternalNotRemarks =(ArrayList) hshValues.get("arrInternalNotRemarks");
HashMap hshRecord2 = (HashMap) hshValues.get("hshRecord2");
HashMap hshRecord3 = (HashMap) hshValues.get("hshRecord3");
HashMap hshRecord4 = (HashMap) hshValues.get("hshRecord4");
ArrayList arrTerms =(ArrayList)hshValues.get("arrTerms");
ArrayList arrCoApp = (ArrayList)hshRecord3.get("coapplname");
ArrayList arrGuarantor = (ArrayList)hshRecord4.get("guarantorname");
String	strNote1 =" ";
String	strNote2 =" ";
String	strNote3 =" ";
String	strNote4 =" ";
String strSchedule = "";

String  strCoApp =" ";

if(hshRecord2.size()>0)
{
	strNote1= Helper.correctNull((String)hshRecord2.get("appsanc_note"));
	strNote2= Helper.correctNull((String)hshRecord2.get("appsanc_authority"));
	strNote3= Helper.correctNull((String)hshRecord2.get("appsanc_disbursement"));
	strNote4= Helper.correctNull((String)hshRecord2.get("appsanc_commencing"));
	strSchedule= Helper.correctNull((String)hshRecord2.get("schedule"));

}

String strOrgLevel=Helper.correctNull((String)session.getAttribute("strOrgLevel"));
String org_level=Helper.correctNull((String)hshRecord1.get("org_level"));
int i=0;

java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);

String strLOAN_SELECTTYPE = Helper.correctNull((String)hshRecord1.get("LOAN_SELECTTYPE")); 
String strPrdcode = Helper.correctNull((String)hshRecord1.get("prdcode"));
String strCPCBranch = Helper.correctNull((String)hshRecord1.get("strCPCBranch"));

%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 370;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
a:hover {  color: #FF3300}
textarea {  font-family: "MS Sans Serif"; font-size: 10px; border-style: groove; color: #003399}
</STYLE>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT>

var appURL="<%=ApplicationParams.getAppUrl()%>";
var editflag=1;
var editlockflag="<%=hshValues.get("editlock")%>";
var strvalue="/jsp/perhlp/help.jsp";
var strappeditsameregbranch="<%=session.getAttribute("HRBranchUserEdit")%>";
var strOrgLevel="<%=strOrgLevel%>";
var org_level="<%=org_level%>";
var varcpc = "<%=strCPCBranch%>"; 
var varAppHolder="<%=Helper.correctNull((String)hshValues.get("strAppHolder"))%>";
var varuserId="<%=Helper.correctNull((String)hshValues.get("strUserId"))%>";
var varAppno="<%=Helper.correctNull((String)hshValues.get("appno"))%>";

function callprocess()
	{
		
		if(!document.forms[0].cmdapply.disabled)
		{
			ShowAlert('103');
			return;
		}
		else
		{
		document.forms[0].hidBeanId.value="NationalPortal";
		document.forms[0].hidBeanGetMethod.value="getprocessData1";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/NP_perprocessnotedata.jsp";
		document.forms[0].hidAppType.value="";
		document.forms[0].submit();
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
function ShowReport(page)
  {
	var appno = document.forms[0].appno.value;
	var url = "<%=ApplicationParams.getAppUrl()%>action/"+page+"?appno="+appno+"&hidPageValue=Retail";
	var title = "PrintFairReport";
	var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
  }
  
  function onloading()
{  
	  var varRecomOff = "<%=Helper.correctNull((String)hshRecord2.get("appsanc_recommofficer"))%>";
	  var varSancOff = "<%=Helper.correctNull((String)hshRecord2.get("appsanc_sancofficer"))%>";
	  var varRecomOff1 = "<%=Helper.correctNull((String)hshRecord2.get("appsanc_recommofficer1"))%>";
	  var varSancOff1 = "<%=Helper.correctNull((String)hshRecord2.get("appsanc_sancofficer1"))%>";
	  var varRecomOff2 = "<%=Helper.correctNull((String)hshRecord2.get("appsanc_recommofficer2"))%>";
	  var varSancOff2 = "<%=Helper.correctNull((String)hshRecord2.get("appsanc_sancofficer2"))%>";
	  var varRecomOff3 = "<%=Helper.correctNull((String)hshRecord2.get("appsanc_recommofficer3"))%>";
	  var varSancOff3 = "<%=Helper.correctNull((String)hshRecord2.get("appsanc_sancofficer3"))%>";
	  

	  if(varRecomOff == "0"){
		  document.forms[0].txt_recofficer.value = "Deselect";
	  }else{
		  document.forms[0].txt_recofficer.value = varRecomOff;
	  }

	  if(varSancOff == "0"){
		  document.forms[0].txt_sanctionofficer.value = "Deselect";
	  }else{
		  document.forms[0].txt_sanctionofficer.value = varSancOff;
	  }

	  if(varRecomOff1 == "0"){
		  document.forms[0].txt_recofficer1.value = "Deselect";
	  }else{
		  document.forms[0].txt_recofficer1.value = varRecomOff1;
	  }

	  if(varSancOff1 == "0"){
		  document.forms[0].txt_sanctionofficer1.value = "Deselect";
	  }else{
		  document.forms[0].txt_sanctionofficer1.value = varSancOff1;
	  }

	  if(varRecomOff2 == "0"){
		  document.forms[0].txt_recofficer2.value = "Deselect";
	  }else{
		  document.forms[0].txt_recofficer2.value = varRecomOff2;
	  }

	  if(varSancOff2 == "0"){
		  document.forms[0].txt_sanctionofficer2.value = "Deselect";
	  }else{
		  document.forms[0].txt_sanctionofficer2.value = varSancOff2;
	  }


	  if(varRecomOff2 == "0"){
		  document.forms[0].txt_recofficer3.value = "Deselect";
	  }else{
		  document.forms[0].txt_recofficer3.value = varRecomOff3;
	  }

	  if(varSancOff2 == "0"){
		  document.forms[0].txt_sanctionofficer3.value = "Deselect";
	  }else{
		  document.forms[0].txt_sanctionofficer3.value = varSancOff3;
	  }
	  
	 
     
		if (document.forms[0].appstatus.value != "Open/Pending")
	{
		disableCommandButtons(true);
		alert("unable to modify APPROVED APPLICATION !!!")
	}
		else
	{
	document.forms[0].cmdedit.disabled=false;
	if(document.forms[0].cmdedit.disabled)
	editflag=0;
	doAfterEdit();
	//document.forms[0].facilitytype.value="<%=Helper.correctNull((String)hshRecord2.get("appsanc_facility"))%>";
	document.forms[0].recofficer.disabled = true;
	document.forms[0].sanctionofficer.disabled = true;
	document.forms[0].recofficer1.disabled = true;
	document.forms[0].sanctionofficer1.disabled = true;
	document.forms[0].recofficer2.disabled = true;
	document.forms[0].sanctionofficer2.disabled = true;
	
	}

	//	funEDappstatus();
	
}

function doAfterEdit()
{
  var editcheck="<%=request.getParameter("hideditflag")%>";
    if(editcheck=="yes")
	  {
		  if(editlockflag=="y")
		  {
			  disableCommandButtons("edit");
		  }
		  else
		  {
			  readOnlyFields(true);
			  ShowAlert(128);
			  disableCommandButtons("load");
		  }
	  }
	  else
	  {
		  readOnlyFields(true);
		  disableCommandButtons("load");
	  }
	  
	 if(strappeditsameregbranch!="")
	{
		if(strappeditsameregbranch=="disablefalse")
		{ 	if(editcheck=="yes")
			{
				callDisableControls(true,false,true,false,false);	
			}else{
				callDisableControls(false,true,true,true,false);				
			}
		}
		else if(strappeditsameregbranch=="disabletrue")
		{
			callDisableControls(true,true,true,true,false);
		}
	}
}

function readOnlyFields(flag)
{
	document.forms[0].txt_note1.readOnly=flag;
	document.forms[0].txt_note2.readOnly=flag;
	document.forms[0].txt_note3.readOnly=flag;
	document.forms[0].txt_note4.readOnly=flag;
	//document.forms[0].facilitytype.disabled=flag;
	document.forms[0].schedule.readOnly=flag;
}

function disableCommandButtons(val)
{
  if(val=="load")
  {
	  if(editflag==1)
	  {
		  document.forms[0].cmdedit.disabled=false;
	  }

	  document.forms[0].cmdapply.disabled=true;
	  document.forms[0].cmdcancel.disabled=true;
	//  document.forms[0].cmdaudit.disabled = false;
	  document.forms[0].cmdclose.disabled=false;
  }
  if(val=="edit")
  {
	 document.forms[0].cmdedit.disabled=true;
	 document.forms[0].cmdapply.disabled=false;
	 document.forms[0].cmdcancel.disabled=false;
	// document.forms[0].cmdaudit.disabled = true;
	 document.forms[0].cmdclose.disabled=true;
  }
}


function doEdit()
{
	document.forms[0].hidPageValue.value="Retail";
	document.forms[0].hideditflag.value="yes";
	document.forms[0].hidBeanId.value="NationalPortal";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action=appURL+"action/NP_perappsanctionsanction.jsp";
	document.forms[0].method="post"; 
	document.forms[0].submit();

}

function doApply()
{		

	if(varAppHolder!=varuserId&&varAppno!="")
	{
		
		alert("Your Not The Holder of the Application to Modify The Application");
		return;

	}
	else{
	
//document.forms[0].txt_note1.value="";
//document.forms[0].txt_note2.value="";
var recofficer = document.forms[0].recofficer.value.split("-");
var recclass=recofficer[1];
var rename=recofficer[0];
var  sanctionofficer=document.forms[0].sanctionofficer.value.split("-");
var sanname=sanctionofficer[0];
var sanclass=sanctionofficer[1];

var recofficer1 = document.forms[0].recofficer1.value.split("-");
var recclass1=recofficer1[1];
var rename1=recofficer1[0];
var  sanctionofficer1=document.forms[0].sanctionofficer1.value.split("-");
var sanname1=sanctionofficer1[0];
var sanclass1=sanctionofficer1[1];

var recofficer2 = document.forms[0].recofficer2.value.split("-");
var recclass2=recofficer2[1];
var rename2=recofficer2[0];
var  sanctionofficer2=document.forms[0].sanctionofficer2.value.split("-");
var sanname2=sanctionofficer2[0];
var sanclass2=sanctionofficer2[1];

//why it is checking with "R" is in some case region office user itself will create
//applications so on that time region office user ie., rec and sec officer cannot apply in appraisal screen.so user from region office cannot 
//sanction that application

if(org_level!="R" && varcpc!="Y")
{
	if((document.forms[0].recofficer.value=="") || (document.forms[0].recofficer.value=="0"))
		{
			alert("Branch:Select Recommending  Officer"); 
			return;
		}
	
	if((document.forms[0].sanctionofficer.value=="")||	(document.forms[0].sanctionofficer.value=="0"))
		{
			alert("Branch:Select Sanctioning Officer"); 
			return;
		}
}
if(varcpc=="Y")
{
	if((document.forms[0].txt_recofficer3.value=="") || (document.forms[0].txt_recofficer3.value=="0"))
		{
			alert("CPC : Select Recommending  Officer"); 
			return;
		}
	
	if((document.forms[0].txt_sanctionofficer3.value=="")||	(document.forms[0].txt_sanctionofficer3.value=="0"))
		{
			alert("CPC : Select Sanctioning Officer"); 
			return;
		}
}

/*if(document.forms[0].recofficer1.value=="")
	{
		alert("Region:Select Recommending  Officer");
		return;
	}

if(document.forms[0].sanctionofficer1.value=="")
	{
		alert("Region:Select Sanctioning Officer");
		return;
	}
if(document.forms[0].recofficer2.value=="")
	{
		alert("HeadOffice:Select Recommending  Officer");
		return;
	}

if(document.forms[0].sanctionofficer2.value=="")
	{
		alert("HeadOffice:Select Sanctioning Officer");
		return;
	}
*/
if(org_level!="R")
{
	if(recclass<=100)
	{
			alert("Branch:Select Recommending Officer with class pts more than 100");
			document.forms[0].recofficer.value="";
	}
	if(sanclass<=100)
	{
			alert("Branch:Select Sanctioning Officer with class pts more than 100");
			document.forms[0].sanctionofficer.value="";
	}
}
if(recclass1<=100)
{
		alert("Region:Select Recommending Officer with class pts more than 100");
		document.forms[0].recofficer1.value="";
}
if(sanclass1<=100)
{
		alert("Region:Select Sanctioning Officer with class pts more than 100");
		document.forms[0].sanctionofficer1.value="";
}
if(recclass2<=100)
{
		alert("HeadOffice:Select Recommending Officer with class pts more than 100");
		document.forms[0].recofficer2.value="";
}
if(sanclass2<=100)
{
		alert("HeadOffice:Select Sanctioning Officer with class pts more than 100");
		document.forms[0].sanctionofficer2.value="";
}

/*if(org_level!="R")
{
	if(rename==sanname)
		{
			alert("Branch:Recommending  Officer & Sanctioning Officer cant be same person");
			document.forms[0].recofficer.value="";
			document.forms[0].sanctionofficer.value="";
			return;
		}
}	

if(	document.forms[0].recofficer1.value!="" && 	document.forms[0].sanctionofficer1.value!="")	
{	
	if(rename1==sanname1)
	{
		alert("Region:Recommending  Officer & Sanctioning Officer cant be same person");
		document.forms[0].recofficer1.value="";
		document.forms[0].sanctionofficer1.value="";
		return;
	}
}
if(	document.forms[0].recofficer2.value!="" && 	document.forms[0].sanctionofficer2.value!="")	
{
	if(rename2==sanname2)
	{
		alert("HeadOffice:Recommending  Officer & Sanctioning Officer cant be same person");
		document.forms[0].recofficer2.value="";
		document.forms[0].sanctionofficer2.value="";
		return;
	}
}*/		
if(document.forms[0].schedule.value=="")
	{
	alert("Enter Terms of Release");
		document.forms[0].schedule.focus();
		return;
	}

		document.forms[0].recofficer.disabled = false;
		document.forms[0].sanctionofficer.disabled = false;
		document.forms[0].recofficer1.disabled = false;
		document.forms[0].sanctionofficer1.disabled = false;
		document.forms[0].recofficer2.disabled = false;
		document.forms[0].sanctionofficer2.disabled = false;
		document.forms[0].hidPageValue.value="Retail";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="NationalPortal";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].hidSourceUrl.value="/action/NP_perappsanctionsanction.jsp";
		document.forms[0].submit();
}
}
function doCancel()
{
	if(ConfirmMsg('102'))
	{		
		document.forms[0].hideditflag.value="no";
		document.forms[0].action=appURL+"action/NP_perappsanctionsanction.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();

	}
}

function doHelp()
{
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


function callTerms()
{
	if(!document.forms[0].cmdapply.disabled)
		{
			ShowAlert('103');
			return;
		}
	///	document.forms[0].hidBeanId.value="apptermscond";
	////document.forms[0].hidBeanGetMethod.value="getTerms";
	
	///document.forms[0].action=appURL+"action/borrapptermsandcondns.jsp";
	/////document.forms[0].submit();

	document.forms[0].sel_termstype.value="C";
	document.forms[0].hidBeanId.value="NationalPortal";
	document.forms[0].hidBeanGetMethod.value="getTerms";
	document.forms[0].action=appURL+"action/NP_borrapptermsandcondns.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();




	
}

function ShowPrint(page)
  {
	
	appno=document.forms[0].appno.value;
		
var purl ="<%=ApplicationParams.getAppUrl()%>action/eduprint.jsp?hidBeanGetMethod=getPrintData&hidBeanId=edustudent&appno="+appno;

	
		var prop = 'scrollbars=yes,menubar=yes,width=775,height=520';	
		var xpos = (screen.width - 775) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);
  }
function callUsersHelp(value,level)
{	
	var val=value;
	var velev_type=level;

	if(val=="1")
	{
		var prop="scrollbars=no,width=300,height=300,top=100,left=250";
		var url="<%=ApplicationParams.getAppUrl()%>action/recommuserlist.jsp?org_code="+document.forms[0].org_code.value+"&val="+value;
		window.open(url,"hai",prop);
	}
	else if(val=="2")
	{
		var prop="scrollbars=no,width=300,height=300,top=100,left=250";
		var url="<%=ApplicationParams.getAppUrl()%>action/recommuserlist.jsp?org_code="+document.forms[0].org_code.value+"&val="+value;
		window.open(url,"hai",prop);
	}else{
	var prop="scrollbars=no,width=300,height=300,top=100,left=250";
		var url="<%=ApplicationParams.getAppUrl()%>action/recommuserlist.jsp?org_code="+document.forms[0].org_code.value+"&val="+value+"&velev_type="+velev_type;
		window.open(url,"hai",prop);
	}
	
}
function callComittee()
{
	var appno =document.forms[0].appno.value ;
	var url = "<%=ApplicationParams.getAppUrl()%>action/per_RLCAC.jsp?hidBeanId=appraisalsanc&hidBeanGetMethod=getRLCAC&appno="+appno;
	var title = "checklistHomeLoan";
	var prop = "scrollbars=yes,width=900,height=550,menubar=yes";
	var xpos = 80;
	var ypos = 65;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}

function callLRF()
{
	var appno =document.forms[0].appno.value ;
	var url = "<%=ApplicationParams.getAppUrl()%>action/per_LRF.jsp?hidBeanId=appraisalsanc&hidBeanGetMethod=getLRF&appno="+appno;
	var title = "checklistHomeLoan";
	var prop = "scrollbars=yes,width=900,height=550,menubar=yes";
	var xpos = 80;
	var ypos = 65;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}
function callEduLRF()
{
	var appno =document.forms[0].appno.value ;
	var url = "<%=ApplicationParams.getAppUrl()%>action/per_LRF_Edudet.jsp?hidBeanId=appraisalsanc&hidBeanGetMethod=getEduLoanFormat&appno="+appno;
	var title = "checklistHomeLoan";
	var prop = "scrollbars=yes,width=900,height=550,menubar=yes";
	var xpos = 80;
	var ypos = 65;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}
//Added Keerthika
function callNewEduLRF()
{
	var appno =document.forms[0].appno.value ;
	var url = "<%=ApplicationParams.getAppUrl()%>action/per_LRF_NewEdudet.jsp?hidBeanId=appraisalsanc&hidBeanGetMethod=getNewEduLoanFormat&appno="+appno;
	var title = "checklistHomeLoan";
	var prop = "scrollbars=yes,width=900,height=550,menubar=yes";
	var xpos = 80;
	var ypos = 65;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}

function callHomeLRF()
{
	var appno =document.forms[0].appno.value ;
	var url = "<%=ApplicationParams.getAppUrl()%>action/per_LRF_Homedet.jsp?hidBeanId=appraisalsanc&hidBeanGetMethod=getLRF_housing&appno="+appno;
	var title = "checklistHomeLoan";
	var prop = "scrollbars=yes,width=900,height=550,menubar=yes";
	var xpos = 80;
	var ypos = 65;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}


function showappholder()
{
	if((document.forms[0].hid_appholder.value=="N") || (document.forms[0].appstatus.value=="Processed/Rejected") || (document.forms[0].appstatus.value=="Processed/Approved"))
	{
		callDisableControls(true,true,true,true,false);
	}
}
function showReport1(page)
{
	var appno ="<%=request.getParameter("appno")%>" ;
	var url="<%=ApplicationParams.getAppUrl()%>action/"+page+"?appno="+appno+"&hidBeanId=appbeanJr&hidBeanGetMethod=getProcessNotes&userid="+document.forms[0].hidUserId.value;
	var title = "ProcessNotescontless20";
	var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}
function showLrfEduDoc()
{
	var page="per_LRF_Edu.jsp";
	url="<%=ApplicationParams.getAppUrl()%>action/"+page+"?appno="+<%=request.getParameter("appno")%>+"&hidBeanId=appraisalsanc&hidBeanGetMethod=getEduLoanReviewFormat";
	var title = "LRF";
	var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}

//Added By Keerthika.K for New LRF Format
function showNewLrfEduDoc()
{
	var appno ="<%=request.getParameter("appno")%>" ;
	var url = "<%=ApplicationParams.getAppUrl()%>action/hevNewEdupretaillrf.jsp?hidBeanId=appraisalsanc&hidBeanGetMethod=getHEVPNewEduLoanReviewFormat&appno="+appno;
	var title = "checklistHomeLoan";
	var prop = "scrollbars=yes,width=900,height=550,menubar=yes";
	var xpos = 80;
	var ypos = 65;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}

</script>
</head>
<body class="bgcolor" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="onloading();showappholder()">
<jsp:include page="../share/help.jsp" flush="true"> </jsp:include>
<form method="post" name="frm1">
  <div align="center"> 
    <table width="100%" border="1" cellspacing="0" cellpadding="0" class="outertablecolor" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
      <tr> 
        <td  colspan="2"> 
          <jsp:include page="../nationalportal/ApplurllinkNP.jsp" flush="true"> 
          <jsp:param name="pageid" value="10" />
          </jsp:include>
        </td>
      </tr>
    </table>
  </div>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td height="20"><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>Home 
        </i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i> 
        </i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt; 
        Retail</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        <font face="Times New Roman" size="3"><b><i></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        <font face="Times New Roman" size="3"><b><i>-&gt; Existing </i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt;</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        </i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font face="Times New Roman" size="3"><b><i>Appraisal</i></b></font></td>
    </tr>
  </table>
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr> 
      <td id="mainlnk1"> <lapschoice:application /> </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td height="20" class="outertablecolor"> 
        <table width="50%" border="0" cellspacing="3" cellpadding="3" align="left">
          <tr align="center"> 
            <td width="50%" class="tabinactive"><b><font size="1" face="MS Sans Serif"><a href="javascript:callTerms()" class="blackfont">Terms 
              and Conditions</a></font></b></td>
            <td width="30%" class="tabactive"><b><font size="1" face="MS Sans Serif" color="#FFFFFF">Appraisal</font></b></td>
            <td width="30%" class="tabinactive"><b><font size="1" face="MS Sans Serif"><a href="javascript:callprocess()" class="blackfont">Process 
              Note</a></font></b></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
 <br />
 
 <table width="96%" cellpadding="3" cellspacing="0" border="1" align="center" style="margin:0 auto;">
 	<tr>
 		<td>
 			<table width="100%" border="1" cellspacing="1" cellpadding="5" bordercolor="#000000" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                            <tr> 
                              <td colspan="6" valign="top"> 
                                <table width="100%" border="0" cellspacing="2" cellpadding="2">
                                  <tr class="tabactive"> 
                                    <td width="13%"><font color="#FFFFFF"><b></b></font></td>
                                    <td width="51%"><b><font color="#FFFFFF" size="1" face="MS Sans Serif">Name</font></b></td>
                                    <td width="36%" align="center" valign="top"><font color="#FFFFFF" size="1" face="MS Sans Serif"> 
                                      <b>Net Worth</b></font></td>
                                  </tr>
                                  <%
			//out.println(hshValues.get("vecReport"));
			Vector vecReport=new Vector();
					int vecRsize=0;
			if (hshValues != null)
			 {
			   vecReport = (Vector)hshValues.get("vecReport");
			 }
			
			 if(vecReport!=null)
			{
				vecRsize =vecReport.size();
				
			}
			Vector b1=null;
			 		for (int l=0;l<vecRsize;l++)
					 {
						int colSize=0;
						 if(l<vecRsize)
						 {
							 b1 = (Vector)vecReport.elementAt(l);							

							if(b1!=null)
							{
							   colSize = b1.size();
       						}
						 }
						
											
						 if(colSize>0)	
						  {

			
			
			%>
                                  <tr bgcolor="#FFFFFF"> 
                                    <td width="13%"><font face="MS Sans Serif" size="1"><b><%=Helper.correctNull((String)b1.elementAt(0))%></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
                                    <td width="51%"><font face="MS Sans Serif" size="1" color="Blue"><%=Helper.correctNull((String)b1.elementAt(1))%></font></td>
                                    <td width="36%" align="right"><font face="MS Sans Serif" size="1" color="Blue"><%=Helper.correctNull((String)b1.elementAt(16))%> 
                                      </font></td>
                                  </tr>
                                  <%
			}
		}
			
			
			%>
                                </table>
                              </td>
                            
                          </table>
 		</td>
 	</tr>
 	<tr>
 		<td >
 			<table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tr> 
                                    <td width="35%" valign="top"> 
                                      <table width="100%" border="0" cellspacing="1" cellpadding="3">
                                        <tr class="tabactive"> 
                                          <td width="35%" height="20"><font color="#FFFFFF" size="1" face="MS Sans Serif"><b>Purpose 
                                            of Loan</b></font></td>
                                          <td width="35%" height="20" align="center"><font color="#FFFFFF">&nbsp;</font></td>
                                          <td width="35%" height="20" align="center"><font color="#FFFFFF">&nbsp;</font></td>
                                        </tr>
                                        <!-- <tr class="tabactive"> 
											  <td width="35%" height="20"><font color="#FFFFFF" size="1" face="MS Sans Serif"><b>Description 
                                                  </b></font></td>
                                                 <td width="35%" height="20" align="center"><b><font color="#FFFFFF" size="1" face="MS Sans Serif">&nbsp;</font></b></td>
                                                <td width="35%" height="20" align="center"><b><font color="#FFFFFF" size="1" face="MS Sans Serif">&nbsp;</font></b></td>
                                                <td width="" height="20" align="center"><b><font color="#FFFFFF" size="1" face="MS Sans Serif">Description</font></b></td> 
										      </tr>
                                              <tr> 
                                                <td width="35%" align="center" bgcolor="#FFFFFF"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)hshRecord1.get("prd_desc"))%></font></td>
												 <td width="35%" align="center" bgcolor="#FFFFFF"><font size="1" face="MS Sans Serif"><%//=Helper.correctNull((String)hshRecord1.get("catdesc"))%></font></td>
                                                <td width="35%" align="center" bgcolor="#FFFFFF"><font size="1" face="MS Sans Serif"><%//=Helper.correctNull((String)hshRecord1.get("subcatdesc"))%></font></td>
                                              </tr> 
                                              <tr> 
                                                <td align="center" width="35%">&nbsp;</td>
                                                <td align="center" width="35%">&nbsp;</td>
                                                <td align="center" width="35%">&nbsp;</td>
                                              </tr>-->
                                        <tr class="tabactive"> 
                                          <!-- <td width="35%" align="center"><b><font color="#FFFFFF" size="1" face="MS Sans Serif">Facility</font></b></td> -->
                                          <td width="35%" height="20">
                                          <font color="#FFFFFF" size="1" face="MS Sans Serif"><b>Description </b></font></td>
                                          <td width="35%" align="center"><b><font color="#FFFFFF" size="1" face="MS Sans Serif">Limit 
                                            </font></b></td>
                                          <td width="35%" align="center"><b><font color="#FFFFFF" size="1" face="MS Sans Serif">Total 
                                            Cost</font></b></td>
                                          </b></font></tr>
                                        <tr> 
                                          <td width="35%" align="center" bgcolor="#FFFFFF"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)hshRecord1.get("prd_desc"))%></font></td>
                                          <!--  <td width="35%" align="center" bgcolor="#FFFFFF"> 
                                                  <select name="facilitytype">
                                                    <option value="S" selected>&lt;-- 
                                                    Select --&gt;</option>
                                                    <option value="Term Loan">Term 
                                                    Loan</option>
                                                    <option value="Demand Loan">Demand 
                                                    Loan</option>
                                                    <option value="Over Draft">Over 
                                                    Draft</option>
                                                  </select> </td> -->
                                          <td width="35%" align="center" bgcolor="#FFFFFF"><font size="1" face="MS Sans Serif"><%=ApplicationParams.getCurrency()%><%=Helper.correctNull((String)hshRecord1.get("loan_recmdamt"))%></font></td>
                                          <td width="35%" align="center" bgcolor="#FFFFFF"><font size="1" face="MS Sans Serif"><%=ApplicationParams.getCurrency()%><%=Helper.correctNull((String)hshRecord1.get("loan_costloanprd"))%></font></td>
                                        </tr>
                                        <tr> 
                                          <td align="center" width="35%">&nbsp;</td>
                                          <td align="center" width="35%">&nbsp;</td>
                                          <td align="center" width="35%">&nbsp;</td>
                                        </tr>
                                        <tr> 
                                          <td colspan="3" class="tabactive"><font color="#FFFFFF" size="1" face="MS Sans Serif"><b>RATE 
                                            OF INTEREST</b></font></td>
                                        </tr>
                                        <tr> 
                                          <td colspan="3" bgcolor="#FFFFFF"><font size="1" face="MS Sans Serif"> 
                                            <%=Helper.correctNull((String)hshRecord1.get("loan_modintrate"))%> 
                                            </font></td>
                                        </tr>
                                        <tr> 
                                          <td align="center" width="35%">&nbsp;</td>
                                          <td align="center" width="35%">&nbsp;</td>
                                          <td align="center" width="35%">&nbsp;</td>
                                        </tr>
                                        <tr class="tabactive"> 
                                          <td width="35%"><font color="#FFFFFF" size="1" face="MS Sans Serif"><b>Terms 
                                            of Release (First Schedule)</b></font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                                          <td width="35%" align="center"><font color="#FFFFFF">
                                            <textarea name="schedule" cols="40" wrap="VIRTUAL" rows="3" onKeypress="textlimit(this,'3990')"><%=strSchedule%></textarea>
                                            </font></td>
                                          <td width="35%" align="center"><font color="#FFFFFF">&nbsp; 
                                            </font></td>
                                        </tr>
                                        <tr class="tabactive"> 
                                          <td width="35%"><font color="#FFFFFF" size="1" face="MS Sans Serif"><b>Repayment 
                                            Schedule</b></font></td>
                                          <td width="35%" align="center"><font color="#FFFFFF">&nbsp;</font></td>
                                          <td width="35%" align="center"><font color="#FFFFFF">&nbsp;</font></td>
                                        </tr>
                                        <tr class="tabactive"> 
                                          <td width="35%" align="center"><font size="1" face="MS Sans Serif"><b><font color="#FFFFFF" size="1" face="MS Sans Serif">EMI 
                                            </font></b></font></td>
                                          <td width="35%" align="center"><b><font color="#FFFFFF" size="1" face="MS Sans Serif">Period</font></b></td>
                                          <td width="35%" align="center"><font color="#FFFFFF"><b>Moratorium 
                                            Period</b></font></td>
                                        </tr>
                                        <tr> 
                                          <%
											  String loanemi = Helper.correctNull((String)hshRecord1.get("loan_emi"));
											  if(loanemi.equals("0.0") || loanemi.equals("0") || loanemi.equals("0.00"))
											  {
											  loanemi="";
											  }
											  else
											  {
											  loanemi = ApplicationParams.getCurrency() + " " + loanemi;
											  }
											  %>
                                          <td width="35%" align="center" bgcolor="#FFFFFF"><font size="1" face="MS Sans Serif"><%=loanemi%></font></td>
                                          <td width="35%" align="center" bgcolor="#FFFFFF"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)hshRecord1.get("loan_reqterms"))%> 
                                            months</font> </td>
                                          <td width="35%" align="center" bgcolor="#FFFFFF"><%=Helper.correctNull((String)hshRecord1.get("loan_moro"))%>&nbsp;months</td>
                                        </tr>
                                        <tr> 
                                          <td align="center" width="35%">&nbsp;</td>
                                          <td align="center" width="35%">&nbsp;</td>
                                          <td align="center" width="35%">&nbsp;</td>
                                        </tr>
                                        <tr> 
                                          <td colspan="3" class="tabactive"><font size="1" face="MS Sans Serif"><b><font color="#FFFFFF" size="1" face="MS Sans Serif">Commencing 
                                            From </font></b><font size="1" face="MS Sans Serif"><font color="#FFFFFF">(If 
                                            'repayment type' selected is other 
                                            than EMI then also enter amount of 
                                            installment , if applicable)</font></font></font></td>
                                        </tr>
                                        <tr> 
                                          <td colspan="3"><font size="1" face="MS Sans Serif"> 
                                            From &nbsp;
                                            <input type="text" name="txt_note4" size="12" maxlength="10" 
													value="<%=Helper.correctNull((String)hshRecord1.get("emidate"))%>">
                                            &nbsp;To&nbsp;
                                            <input type="text" name="txt_note33" size="12" maxlength="10" 
													value="<%=Helper.correctNull((String)hshRecord1.get("strToDate"))%>">
                                            </font></td>
                                        </tr>
                                        <tr> 
                                          <td><font size="1" face="MS Sans Serif">&nbsp;</font></td>
                                          <td>&nbsp;</td>
                                          <td>&nbsp;</td>
                                        </tr>
                                        <!-- <tr class="tabactive"> 
                                          <td><font color="#FFFFFF" size="1" face="MS Sans Serif"><b>Risk 
                                            Rating </b></font></td>
                                          <td align="center"><font color="#FFFFFF">&nbsp;</font></td>
                                          <td align="center"><font color="#FFFFFF">&nbsp;</font></td>
                                        </tr>
                                        <tr class="tabactive"> 
                                          <td align="center"><font size="1" face="MS Sans Serif"><b><font color="#FFFFFF" size="1" face="MS Sans Serif">Score</font></b></font></td>
                                          <td align="center"><b><font color="#FFFFFF" size="1" face="MS Sans Serif">Grade</font></b></td>
                                          <td align="center"><font color="#FFFFFF"><b></b></font></td>
                                        </tr>
                                        <%
													String rating = Helper.correctNull((String)hshValues.get("score"));
													if(rating.equals("0.0") || rating.equals("0"))
													{
													rating = "";
													}
					
												%>
                                        <tr bgcolor="#FFFFFF"> 
                                          <td align="center"><font size="1" face="MS Sans Serif"><%=rating%></font></td>
                                          <td align="center"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)hshValues.get("grade"))%></font></td>
                                          <td align="center">&nbsp;</td>
                                        </tr>-->
                                      </table>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                          </table>
 		</td>
 	</tr>
 	<tr style="visibility:hidden;position:absolute"> 
                        <td class="tabactive" ><font color="#FFFFFF" size="1" face="MS Sans Serif"> 
                          <b>Securities / Documents :</b></font></td>
                      </tr>
                      <%
							int x = 1;
							  if(arrInternalDoc.size()>0)
							{
								  for(  i=0;i<arrInternalDoc.size();i++)
								{
							%>
                      <tr bgcolor="#FFFFFF" style="visibility:hidden;position:absolute"> 
                        <td><font face="MS Sans Serif" size="1"><%=x++%>) 
                          <%=Helper.correctNull((String)arrInternalDoc.get(i))%> 
                          </font></td>
                      </tr>
                      <%
								}
							}
							else
							{
								%>
                      <tr bgcolor="#FFFFFF" style="visibility:hidden;position:absolute"> 
                        <td ><font face="MS Sans Serif" size="1">
                          <center>
                            ---NIL--- 
                          </center>
                          </font></td>
                      </tr>
                      <%
							}
							%>
                      <tr class="tabactive" style="visibility:hidden;position:absolute"> 
                        <td ><font color="#FFFFFF" size="1" face="MS Sans Serif"><b>Documents 
                          to be submitted</b></font></td>
                      </tr>
                      <%
							int z = 1;
							  if(arrInternalNotSubDoc.size()>0)
							{
								  for( i=0;i<arrInternalNotSubDoc.size();i++)
								{
							%>
                      <tr bgcolor="#FFFFFF" style="visibility:hidden;position:absolute"> 
                        <td ><font face="MS Sans Serif" size="1"><%=z++%>) 
                          <%=Helper.correctNull((String)arrInternalNotSubDoc.get(i))%> 
                          </font></td>
                      </tr>
                      <%
								}
							}	
							else
							{
								%>
                      <tr bgcolor="#FFFFFF" style="visibility:hidden;position:absolute"> 
                        <td ><font face="MS Sans Serif" size="1">
                          <center>
                            ---NIL--- 
                          </center>
                          </font></td>
                      </tr>
                      <%
							}
							
							%>
                      <tr> 
                        <td  class="tabactive" ><font color="#FFFFFF" size="1" face="MS Sans Serif"><b>Other 
                          Terms &amp; conditions :</b></font></td>
                      </tr>
                      <%
							int j=0,k=1;
							if(arrTerms.size()>0)
							{
								for(j=0;j<arrTerms.size();j++)
								{
								%>
                      <tr bgcolor="#FFFFFF"> 
                        <td > <font size="1" face="MS Sans Serif"><%=k++%>) 
                          <%=Helper.breakText((String)arrTerms.get(j),100)%></font> 
                        </td>
                      </tr>
                      <%
								}
							}
							else
							{
								%>
                      <tr bgcolor="#FFFFFF"> 
                        <td ><font face="MS Sans Serif" size="1">
                          <center>
                            ---NIL--- 
                          </center>
                          </font></td>
                      </tr>
                      <%
							}			

							%>
                      <tr > 
                        <td  class="tabactive"><font color="#FFFFFF" size="1" face="MS Sans Serif"><b>Appraisal 
                          Note :</b></font></td>
                      </tr>
                      <tr > 
                        <td > 
                          <textarea name="txt_note1" cols="100" wrap="VIRTUAL"  rows="5" onKeypress="textlimit(this,'3990')"><%=strNote1%></textarea>
                        </td>
                      </tr>
                      <tr > 
                        <td  class="tabactive"><font color="#FFFFFF" size="1" face="MS Sans Serif">Comments 
                          of Sanctioning Authority :</font></td>
                      </tr>
                      <tr> 
                        <td  > 
                          <textarea name="txt_note2" cols="100" wrap="VIRTUAL" rows="5" onKeypress="textlimit(this,'3990')"><%=strNote2%></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td  class="tabactive"><font color="#FFFFFF" size="1" face="MS Sans Serif"> 
                          Disbursement Mode :</font></td>
                      </tr>
                      <tr> 
                        <td  > 
                          <textarea name="txt_note3" cols="100" wrap="VIRTUAL" rows="5" onKeyPress="textlimit(this,'3990')"><%=strNote3%></textarea>
                        </td>
                      </tr>
 	<tr>
 		<td>
 			<table border="0" cellpadding="3" cellspacing="0" width="100%">
 			
 			<tr>
 			<td colspan="3">&nbsp;</td>
 			</tr>
 			
 				<tr> 
                        <td ><font color="#000000" size="1" face="MS Sans Serif"><b>Branch</b> 
                          </font></td>
                        <td  ><font color="#000000" size="1" face="MS Sans Serif"> 
                          <b>Recommending Officer:</b></font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b> 
                          <input type="text" name="txt_recofficer" size="20"   maxlength="20" readonly="readonly">
                          <%if(!strOrgLevel.equalsIgnoreCase("R") && !strOrgLevel.equalsIgnoreCase("C") && strCPCBranch.equals("N"))
                                {%>
                          <a href="#" onClick="javascript:callUsersHelp(1)"> <b class="blackfont">?</b></a> 
                          <%} %>
                          <input type="hidden" name="recofficer" value = "<%=Helper.correctNull((String)hshRecord2.get("appsanc_recommofficer"))%>">
                        </td>
                        <td ><font color="#000000" size="1" face="MS Sans Serif"> 
                          <b>Sanctioning/Recommending Officer:</b></font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b> 
                          <input type="text" name="txt_sanctionofficer" size="20"   maxlength="20" readonly="readonly">
                          <%if(!strOrgLevel.equalsIgnoreCase("R") && !strOrgLevel.equalsIgnoreCase("C") && strCPCBranch.equals("N"))
                                {%>
                          <a href="#" onClick="javascript:callUsersHelp(2)"> <b class="blackfont">? 
                          </b></a> 
                          <%} %>
                          <input type="hidden" name="sanctionofficer" value = "<%=Helper.correctNull((String)hshRecord2.get("appsanc_sancofficer"))%>">
                        </td>
                        
                      
                      </tr>
                      
                      
                      
                      
                      
                      
                      
                      <tr> 
                        <td ><font color="#000000" size="1" face="MS Sans Serif"><b>CPC</b> 
                          </font></td>
                        <td  ><font color="#000000" size="1" face="MS Sans Serif"> 
                          <b>Recommending Officer:</b></font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b> 
                          <input type="text" name="txt_recofficer3" size="20"   maxlength="20" readonly="readonly">
                          <%if(!strOrgLevel.equalsIgnoreCase("R") && !strOrgLevel.equalsIgnoreCase("C") && strCPCBranch.equals("Y"))
                                {%>
                          <a href="#" onClick="javascript:callUsersHelp('7','CPC')"> <b class="blackfont">?</b></a> 
                          <%} %>
                          <input type="hidden" name="recofficer3" value = "<%=Helper.correctNull((String)hshRecord2.get("appsanc_recommofficer3"))%>">
                        </td>
                        <td ><font color="#000000" size="1" face="MS Sans Serif"> 
                          <b>Sanctioning/Recommending Officer:</b></font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b> 
                          <input type="text" name="txt_sanctionofficer3" size="20"   maxlength="20" readonly="readonly">
                          <%if(!strOrgLevel.equalsIgnoreCase("R") && !strOrgLevel.equalsIgnoreCase("C") && strCPCBranch.equals("Y"))
                                {%>
                          <a href="#" onClick="javascript:callUsersHelp('8','CPC')"> <b class="blackfont">? 
                          </b></a> 
                          <%} %>
                          <input type="hidden" name="sanctionofficer3" value = "<%=Helper.correctNull((String)hshRecord2.get("appsanc_sancofficer3"))%>">
                        </td>
                        
                      
                      </tr>
                      
                                      
                      
                      
                      
                      
                      <!-- recommending & Sanctioning officer 1 and 2  -->
                      <tr> 
                        <td ><font color="#000000" size="1" face="MS Sans Serif"><b>Region 
                          </b></font></td>
                        <td ><font color="#000000" size="1" face="MS Sans Serif"> 
                          <b>Recommending Officer:</b></font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b> 
                          <input type="text" name="txt_recofficer1" size="20"   maxlength="20" readonly="readonly">
                          <%if(strOrgLevel.equalsIgnoreCase("R"))
                                {%>
                          <a href="#" onClick="javascript:callUsersHelp(3)"><b class="blackfont">? 
                          </b></a> 
                          <%} %>
                          <input type="hidden" name="recofficer1" value = "<%=Helper.correctNull((String)hshRecord2.get("appsanc_recommofficer1"))%>">
                        </td>
                        <td><font color="#000000" size="1" face="MS Sans Serif"> 
                          <b>Sanctioning/Recommending Officer:</b></font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b> 
                          <input type="text" name="txt_sanctionofficer1" size="20"   maxlength="20" readonly="readonly">
                          <%if(strOrgLevel.equalsIgnoreCase("R"))
                                {%>
                          <a href="#" onClick="javascript:callUsersHelp(4)"><b class="blackfont">? 
                          </b></a> 
                          <%} %>
                          <input type="hidden" name="sanctionofficer1" value = "<%=Helper.correctNull((String)hshRecord2.get("appsanc_sancofficer1"))%>">
                        </td>
                       
                       
                      </tr>
                      
                      
                      
                      <tr> 
                        <td ><font color="#000000" size="1" face="MS Sans Serif"> 
                          <b>HeadOffice</b></font></td>
                        <td ><font color="#000000" size="1" face="MS Sans Serif"> 
                          <b>Recommending Officer:</b></font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b> 
                          <input type="text" name="txt_recofficer2" size="20"   maxlength="20" readonly="readonly">
                          <%if(strOrgLevel.equalsIgnoreCase("C")|| strOrgLevel.equalsIgnoreCase("F"))
                                {%>
                          <a href="#" onClick="javascript:callUsersHelp(5)"><b class="blackfont">? 
                          </b></a> 
                          <%} %>
                          <input type="hidden" name="recofficer2" value = "<%=Helper.correctNull((String)hshRecord2.get("appsanc_recommofficer2"))%>">
                        </td>
                        <td ><font color="#000000" size="1" face="MS Sans Serif"> 
                          <b>Sanctioning Officer:</b></font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b> 
                          <input type="text" name="txt_sanctionofficer2" size="20"   maxlength="20" readonly="readonly">
                          <%if(strOrgLevel.equalsIgnoreCase("C")|| strOrgLevel.equalsIgnoreCase("F"))
                                {%>
                          <a href="#" onClick="javascript:callUsersHelp(6)"><b class="blackfont">? 
                          </b></a> 
                          <%} %>
                          <input type="hidden" name="sanctionofficer2" value = "<%=Helper.correctNull((String)hshRecord2.get("appsanc_sancofficer2"))%>">
                        </td>
                        
                      </tr>
                      <tr align="center">  
                        <td colspan="4" > 
                          <input type="button" name="cmdcancel2" value="Appraisal cum sanction memo" onClick="ShowReport('appcumsanction.jsp')" style="width:100 length:100" class="buttoncolor">
                          <!--<input type="button" name="cmdComittee" value="RLCAC 1 and RLCAC 2" onclick="callComittee()"  class="buttoncolor" >
                           --><%if (strPrdcode.equalsIgnoreCase("962") || strPrdcode.equalsIgnoreCase("963") || strPrdcode.equalsIgnoreCase("964") || strPrdcode.equalsIgnoreCase("985") || strPrdcode.equalsIgnoreCase("940") || strPrdcode.equalsIgnoreCase("979")) {%>
                           <input type="button" name="cmdloanreview" value="LOAN REVIEW DETAILS" onclick="callLRF()"  class="buttoncolor" >
                           <%} %>
                           
						 <%if(strPrdcode.equalsIgnoreCase("965") || strPrdcode.equalsIgnoreCase("966") || strPrdcode.equalsIgnoreCase("977") || strPrdcode.equalsIgnoreCase("978") || 
								 strPrdcode.equalsIgnoreCase("949") || strPrdcode.equalsIgnoreCase("950") || strPrdcode.equalsIgnoreCase("947") || strPrdcode.equalsIgnoreCase("948") || strPrdcode.equalsIgnoreCase("651") || strPrdcode.equalsIgnoreCase("654") || strPrdcode.equalsIgnoreCase("655")) {%>
						  <% if(Helper.correctNull((String)hshValues.get("strShowNewLRF")).equalsIgnoreCase("N")){%>
                           <input type="button" name="cmdeduloanreview" value="LOAN REVIEW EDU DETAILS" onclick="callEduLRF()" class="buttoncolor">
						 <%} if(Helper.correctNull((String)hshValues.get("strShowNewLRF")).equalsIgnoreCase("Y")){%>
						 <input type="button" name="neweduloanreview" value=" NEW LOAN REVIEW EDU DETAILS " onClick="callNewEduLRF('per_LRF_NewEdudet.jsp')" class="buttoncolor">
                           <%}} %>
                           
                           <%if(strPrdcode.equalsIgnoreCase("973") || strPrdcode.equalsIgnoreCase("974") || strPrdcode.equalsIgnoreCase("975") || strPrdcode.equalsIgnoreCase("935")) {%>
                           <input type="button" name="cmdloanreview1" value="LOAN REVIEW DETAILS" onclick="callHomeLRF()"  class="buttoncolor" >
                           <%} %>

                       </td>
                      </tr>
					  <tr align="center"> 
					    <td colspan="4"><font size="1" face="MS Sans Serif"> 
					      <input type="button" name="eduprocessnote" value="Print Process Note"  class="buttoncolor" onClick="showReport1('pereduprocessnote.jsp')">
					      </font>
                           
					      <%if(strPrdcode.equalsIgnoreCase("965") || strPrdcode.equalsIgnoreCase("966") || strPrdcode.equalsIgnoreCase("977") || strPrdcode.equalsIgnoreCase("978") ||
					    		  strPrdcode.equalsIgnoreCase("950") || strPrdcode.equalsIgnoreCase("949") || strPrdcode.equalsIgnoreCase("947") || strPrdcode.equalsIgnoreCase("948") || strPrdcode.equalsIgnoreCase("651") || strPrdcode.equalsIgnoreCase("654") || strPrdcode.equalsIgnoreCase("655")){ %>
					       <font size="1" face="MS Sans Serif"> 
					        <% if(Helper.correctNull((String)hshValues.get("strShowNewLRF")).equalsIgnoreCase("N")){%>
					      <input type="button" name="lrfedudocument" value="  LRF  "  class="buttoncolor" onClick="showLrfEduDoc('per_LRF_Edu.jsp')">
					      <%} if(Helper.correctNull((String)hshValues.get("strShowNewLRF")).equalsIgnoreCase("Y")){%>
					      <input type="button" name="newlrfedudocument" value=" NEW LRF  " class="buttoncolor" onClick="showNewLrfEduDoc('hevpretaillrf.jsp')">
					      </font>
					      <%}} %>
					</td>
					  </tr>
 			</table>
 		</td>
 				
 	</tr>
 	<tr>
 		<td>&nbsp;</td>
 				
 	</tr>
 </table>
 
 <!--<table width="100%" border="0" cellspacing="1" cellpadding="0">
                      <tr> 
                        <td colspan="6"> 
                          
                      </tr>
                      <tr> 
                        <td colspan="6"> 
                          
                        </td>
                      </tr>
                      
                      
                      
                         <tr align="center"> 
                              <td colspan="4">&nbsp;<FONT face="MS Sans Serif" size="1" COLOR="#000000"><b>For 
                                Education Loans, take a print out by clicking  the  "Print Education" button apart from apprisal print  and annex it</b></FONT></td>
                              <td colspan="3" > <input type="button" name="cmdcancel3" value="Print For Education" onClick="ShowPrint('eduprint.jsp')" style="width:150" class="buttoncolor"> 
                              </td>
                            </tr> 
                    </table>-->
 
  <%String strappno = request.getParameter("appno");%>
  <lapschoice:combuttons  apporgcode="<%=strappno%>" strSource=""/> 
  <td width="15%"> 
    <div align="center"> </div>
  </td>
  <input type="hidden" name="appno" value="<%=request.getParameter("appno") %>">
  <input type="hidden" name="hidmaxterm" value="<%=request.getParameter("hidmaxterm") %>">
  <input type="hidden" name="hidBeanId">
  <input type="hidden" name="hidBeanMethod">
  <input type="hidden" name="hidSourceUrl">
  <input type="hidden" name="hideditflag">
  <input type="hidden" name="hidBeanGetMethod" value="getData">
  <input TYPE="hidden" name="trapEdit"  value="<%=Helper.correctNull((String)hshValues.get("trapEdit"))%>">
  <input TYPE="hidden" name="hidEditMode" value="<%=Helper.correctNull((String)hshValues.get("hidEditMode"))%>">
  <input TYPE="hidden" name="hidCoDemoId" value="<%=request.getParameter("hidCoDemoId")%>" >
  <input TYPE="hidden" name="hidDemoId" value="<%=request.getParameter("hidDemoId")%>">
  <input TYPE="hidden" name="hidGuaDemoId" value="<%=request.getParameter("hidGuaDemoId")%>">
  <input TYPE="hidden" name="hidAppType"value="<%=Helper.correctNull((String)hshValues.get("hidAppType"))%>">
  <input TYPE="hidden" name="radLoan" value="Y">
  <input TYPE="hidden" name="hidauto_type">
  <input TYPE="hidden" name="hiPgDist" value="P">
  <input type="hidden" name="hidEditLock">
  <input type="hidden" name="org_code" value="<%=strOrgCode%>">
    <input type="hidden" name="org_level" value="CPC">
    
    <input type="hidden" name="sel_termstype"value="">
    <input type="hidden" name="hidPageValue">
    <input type="hidden" name="hidUserId" value="<%=(String)session.getAttribute("strUserId")%>">
</form>
</body>
</html>