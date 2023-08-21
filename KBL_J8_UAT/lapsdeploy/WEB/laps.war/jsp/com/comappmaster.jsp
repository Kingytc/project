<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%request.setAttribute("scode", "yyy");
			if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}%>
<html>
<head>
<title>Commercial-Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"> </script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var Apporg_name = "<%=Helper.correctNull((String)hshValues.get("Apporg_name"))%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
var varappstatus="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>"
var appURL="<%=ApplicationParams.getAppUrl()%>";
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
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";

function showCitySearch(varTextControl,varTextControl1,varHidControl,varHidControl1,varTextControl2,varHidControl2)
{		
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = "<%=ApplicationParams.getAppUrl()%>action/searchCity.jsp?hidcitycontrol="+varTextControl+"&hidstatecontrol="+varTextControl1+"&hidcitycodecontrol="+varHidControl+"&hidstatecodecontrol="+varHidControl1+"&hidcitycodecontrol="+varHidControl+"&hidstatecodecontrol="+varHidControl1;
		var title = "City";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
}
function callLink(page,bean,method)
{
  if(document.forms[0].comapp_id.value=="New")
  {
     ShowAlert('103');
     return;
  }
  if(document.forms[0].cmdsave.disabled==false)
  {
     ShowAlert('103');
     return;
  }
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}

function callRelationship()
{
	var varQryString = appURL+"action/perrelationship.jsp?hidBeanGetMethod=getreldetails&hidBeanId=commappmaster&comapp_id="+document.forms[0].comapp_id.value;
	var title = "RelationshipDetails";
	var prop = "scrollbars=yes,width=900,height=550,menubar=no";
	prop = prop + ",left=50,top=150";
    window.open(varQryString,title,prop);		
}

function doramdetails()
{
 	var varQryString = appURL+"action/ramparameters.jsp?hidBeanGetMethod=getRAMParameters&hidBeanId=LapsToRam&comapp_id="+document.forms[0].comapp_oldid.value;
	var title = "Ramdetails";
	var prop = "scrollbars=no,menubar=no,width=600,height=350";
	prop = prop + ",left=200,top=150";
    window.open(varQryString,title,prop);	
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
function checkId()
{
	var varcompId = new Array();
	var bool = true;
  	<lapschoice:commapplicantidlist /> 
	var comval = document.forms[0].comapp_companyid.value;
	if(id=="null")
	{
		for(var i=0;i<varcompId.length;i++)
		{
			if(varcompId[i].toUpperCase()== comval.toUpperCase())
			{
				alert("Already Exist,Try again");
				document.forms[0].comapp_companyid.value="";
				document.forms[0].comapp_companyid.focus();
				bool = false;				
			}
		}
	}
	return bool;
}
function callnbfc()
{
	if(document.forms[0].comapp_ownership.value=="nbfc")
	{
		document.all.od1.style.visibility="visible";
		document.all.od1.style.position="relative";
	 	document.all.od2.style.visibility="visible";
	 	document.all.od2.style.position="relative";
	 	document.all.od3.style.visibility="visible";
	 	document.all.od3.style.position="relative";
		document.all.od4.style.visibility="visible";
		document.all.od4.style.position="relative";
	}
	else
	{
		document.all.od1.style.visibility="hidden";
		document.all.od1.style.position="absolute";
		document.all.od2.style.visibility="hidden";
		document.all.od2.style.position="absolute";
		document.all.od3.style.visibility="hidden";
		document.all.od3.style.position="absolute";
		document.all.od4.style.visibility="hidden";
		document.all.od4.style.position="absolute";
	}
	
	if(document.forms[0].comapp_ownership.value=="OLP" || document.forms[0].comapp_ownership.value=="OCC")
	{
		for(var i=0;i<4;i++)
		{
			document.all.own[i].style.visibility="visible";
			document.all.own[i].style.position="relative";
		}
	}
	else
	{
		for(var i=0;i<4;i++)
		{
			document.all.own[i].style.visibility="hidden";
			document.all.own[i].style.position="absolute";
		}
	}
	if(document.forms[0].comapp_ownership.value=="OLP")
	{
		document.all.pub1.style.visibility="hidden";
		document.all.pub2.style.visibility="hidden";
		document.all.pub1.style.position="absolute";
		document.all.pub2.style.position="absolute";
		document.forms[0].sel_pubtype.value="S";
	}
	else if(document.forms[0].comapp_ownership.value=="OCC")
	{
		document.all.pub1.style.visibility="visible";
		document.all.pub2.style.visibility="visible";
		document.all.pub1.style.position="relative";
		document.all.pub2.style.position="relative";
	}
	else
	{
		document.all.pub1.style.visibility="hidden";
		document.all.pub2.style.visibility="hidden";
		document.all.pub1.style.position="absolute";
		document.all.pub2.style.position="absolute";
		document.forms[0].sel_pubtype.value="S";
		
	}
}
function buttonDisabled(val1,val2,val3,val4,val5,val6,val7,val8)
{
	document.forms[0].cmdedit.disabled=val1;
	document.forms[0].cmdsave.disabled=val2;
	document.forms[0].cmdcancel.disabled=val3;
    document.forms[0].cmddelete.disabled=val4;
    document.forms[0].cmdrenew.disabled=val5;
	document.forms[0].cmdclose.disabled=val6;   
	document.forms[0].cmd_reldet.disabled=val7;
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
function openGroup()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var prop = "scrollbars=no,width=450,height=300,,top=100,left=250";
		var url="<%=ApplicationParams.getAppUrl()%>action/grouphelp.jsp";
		window.open(url,"grouphelp",prop);
	}
}
function doEdit()
{
	disableFields(false);
	buttonDisabled(true,false,false,false,true,true,true,true);
	document.forms[0].comapp_group.readOnly=true;
	document.forms[0].comapp_id.readOnly=true;
	document.forms[0].comapp_scode.disabled=true;
    document.forms[0].comapp_regstate.disabled=true;
    document.forms[0].comapp_type.value=document.forms[0].comapp_commtype.value;
    document.forms[0].comapp_regcountry.readOnly=true;
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		placeValues();
	}
}
function doSave()
{
document.forms[0].hid_introname.value=document.forms[0].txt_introname.value;
	if(document.forms[0].comapp_commtype.value=="" )
	{
		ShowAlert(121,"Corporate Type");
		document.forms[0].comapp_commtype.selectedIndex=0;
		document.forms[0].comapp_commtype.focus();
		return;
	}
	if(trim(document.forms[0].comapp_companyname.value)=="" )
	{
		ShowAlert(121,"Company name");
		document.forms[0].comapp_companyname.value="";
		document.forms[0].comapp_companyname.focus();
		return;
	}
	if(trim(document.forms[0].comapp_commtype.value)=="" )
	{
		ShowAlert(121,"Company type");
		document.forms[0].comapp_commtype.value="";
		document.forms[0].comapp_commtype.focus();
		return;
	}
	if(document.forms[0].comapp_ownership.value=="")
	{
		ShowAlert(121,"Type of Ownership");
		document.forms[0].comapp_ownership.focus();
		return;
	}
	if(trim(document.forms[0].comapp_companyid.value)=="" )
	{
		ShowAlert(121,"BSR Code");
		document.forms[0].comapp_companyid.value="";
		document.forms[0].comapp_companyid.focus();
		return;
	}
	if(trim(document.forms[0].comapp_businessnature.value)=="" )
	{
		ShowAlert(121,"Line of Activity");
		document.forms[0].comapp_businessnature.value="";
		document.forms[0].comapp_businessnature.focus();
		return;
	}
	if(trim(document.forms[0].comapp_regadd1.value)=="" )
	{
		ShowAlert(121,"Registered Office Address1");
		document.forms[0].comapp_regadd1.value="";
		document.forms[0].comapp_regadd1.focus();
		return;
	}
	else if((trim(document.forms[0].comapp_regadd1.value)).length<15)
	{
		alert('Enter minimum 15 characters in address field');
		document.forms[0].comapp_regadd1.focus();
		return;
	}
	if(trim(document.forms[0].comapp_regadd2.value)=="" )
	{
		ShowAlert(121,"Registered Office Address2");
		document.forms[0].comapp_regadd2.value="";
		document.forms[0].comapp_regadd2.focus();
		return;
	}
	else if((trim(document.forms[0].comapp_regadd2.value)).length<15)
	{
		alert('Enter minimum 15 characters in address field');
		document.forms[0].comapp_regadd2.focus();
		return;
	}
	if(trim(document.forms[0].comapp_regpin.value)=="" )
	{
		ShowAlert(121,"Registered Office Pincode");
		document.forms[0].comapp_regpin.value="";
		document.forms[0].comapp_regpin.focus();
		return;
	}
	if(trim(document.forms[0].comapp_regcity.value)=="" )
	{
		ShowAlert(121,"Registered Office City");
		document.forms[0].comapp_regcity.value="";
		return;
	}
	if(trim(document.forms[0].comapp_regcountry.value)=="" )
	{
		ShowAlert(121,"Registered Office Country");
		document.forms[0].comapp_regcountry.value="";
		return;
	}
	else if(document.forms[0].comapp_hidregcountry.value=="")
	{
		ShowAlert(121,"Registered Office Country");
		document.forms[0].comapp_regcountry.value="";
		return;
	}
	if(document.forms[0].comapp_corpstructure.value=="")
	{
		ShowAlert(121,'PAN Number');
		document.forms[0].comapp_corpstructure.value="";
		document.forms[0].comapp_corpstructure.focus();
		return;
	}
	else if((document.forms[0].comapp_corpstructure.value).length<10)
	{
		alert('Enter Valid PAN Number');
		document.forms[0].comapp_corpstructure.focus();
		return;
	}
	if((trim(document.forms[0].comapp_commtype.value)=="SME") && ((trim(document.forms[0].comapp_smetype.value)=="0")))
	{
		ShowAlert(111,"SME Type");
		document.forms[0].comapp_smetype.value="0";
		document.forms[0].comapp_smetype.focus();
		return;
	}
	if(trim(document.forms[0].comapp_scode.value)=="" )
	{
		ShowAlert(121,"Application Received From");
		document.forms[0].comapp_orgname.value="";
		return;
	}
	else if(document.forms[0].comapp_orgname.value=="")
	{
		ShowAlert(121,"Application Received From");
		document.forms[0].comapp_orgname.value="";
		return;
	}
	if(document.forms[0].sel_staff.value=="" )
	{
		ShowAlert(111,"Trade Finance");
		document.forms[0].sel_staff.selectedIndex=0;
		document.forms[0].sel_staff.focus();
		return;
	}
	if(document.forms[0].sel_staff.value=="Y")
	{
	if(trim(document.forms[0].txt_ieccode.value)=="" )
	{
		ShowAlert(121,"IEC Code");
		document.forms[0].txt_ieccode.value="";
		document.forms[0].txt_ieccode.focus();
		return;
	}
	}	
	if(document.forms[0].comapp_id.value=="New")
	{
		document.forms[0].hidAction.value="insert";
	}
	else
	{
		document.forms[0].hidAction.value="update";
	}
	if(document.forms[0].sel_status.value!="0")
	{
		document.forms[0].hidstatus.value=document.forms[0].sel_status.options[document.forms[0].sel_status.selectedIndex].text;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].comapp_scode.disabled=false;
	document.forms[0].comapp_id.disabled=false;	
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].cmddelete.disabled=true;
	document.forms[0].hidBeanMethod.value="updateData";
	document.forms[0].hidSourceUrl.value="/action/comappmaster.jsp";
	document.forms[0].hidBeanId.value="commappmaster";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].method="post";
	document.forms[0].submit();
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value="delete";
			document.forms[0].comapp_id.disabled=false;
			document.forms[0].method="post";
			document.forms[0].hidBeanMethod.value="updateData";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/comappmastersearch.jsp";
			document.forms[0].cmddelete.disabled=true;
			document.forms[0].cmdsave.disabled=true;
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert(158);
	}
}
function doRenew()
{
	document.forms[0].method="post";
	document.forms[0].hidBeanGetMethod.value="renewComappMasterData";
	document.forms[0].hidBeanId.value="commappmaster";
	document.forms[0].action=appURL+"action/comappmaster.jsp";
	document.forms[0].submit();
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/comappmastersearch.jsp";
		document.forms[0].submit();
	}
}
function callDescHelp(page)
{	
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = appURL+"action/comindustrymasterhelp.jsp?page="+page;
		var title = "IndustryHelp";
		var prop = "scrollbars=no,width=650,height=400";	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);	
	}
}
function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}
function showSME()
{
	if(document.forms[0].comapp_commtype.value=="SME")
	{
	document.all.sme.style.visibility="visible";
	document.all.smetype.style.visibility="visible";
	
	}
	else
	{
	document.all.sme.style.visibility="hidden";
	document.all.smetype.style.visibility="hidden";
	document.forms[0].comapp_smetype.value="0";
	}
}
function showIEC()
{
 if(document.forms[0].sel_staff.value=="Y")
 {
  document.all.iec.style.visibility="visible";
  document.all.iec.style.position="relative";
  
 }
 else
 {
  document.forms[0].txt_ieccode.value="";
  document.all.iec.style.visibility="hidden";
  document.all.iec.style.position="absolute";
  
 }
}
function callCntrySearch(varTextControl,varHidControl)
{	
	if(document.forms[0].cmdedit.disabled)
	{
		var varQryString = appURL+"action/searchCountry.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getCountrySearchList"+"&hidcntrycontrol="+varTextControl+"&hidcntrycodecontrol="+varHidControl;
		var title = "Country";
		var prop = "scrollbars=no,width=650,height=400";	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);	
	}
}
function checkpanno(field)
{
	var panvalue=field.value;
	var regExp = /^[A-Za-z]$/;	
	var regExpnum = /^[0-9]$/;	
	if(panvalue!="")
	{
		for(var si=0;si<5;si++)
		{
			if (!panvalue.charAt(si).match(regExp))
			{
				alert('FIRST FIVE Characters should be ALPHABETS');
				field.value="";
				field.focus();
				break;
			}
		}
		for(var si=5;si<9;si++)
		{
			if (!panvalue.charAt(si).match(regExpnum))
			{
				alert('SIXTH TO NINTH CHARACTER MUST BE NUMBER');
				field.value="";
				field.focus();
				break;
			}
		}
		if(panvalue.length==10 && !(panvalue.charAt(9).match(regExp)))
		{
			alert('LAST character must be ALPHABET');
			field.value="";
			field.focus();
			return;
		}
	}
}
function fnSearchinwardno()
{
		var varCustprofile="CUSPROFILE";
		if(document.forms[0].cmdsave.disabled==false)
		{
			var varcategory="c";
			var varQryString = appURL+"action/searchAppinwradno.jsp?hidBeanId=inwardRegister&hidBeanGetMethod=getInwardnoSearchList&Category="+varcategory+"&Cusprofile="+varCustprofile;
			var title = "Acknowledgement";
			var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
			var xpos = (screen.width - 350) / 2;
			var ypos = (screen.height - 120) / 2;
			prop = prop + ",left=50,top=50";
			window.open(varQryString,title,prop);
		}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="placeValues();callnbfc();showSME();showIEC();">
<form name="appform" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Customer Profile -&gt; Company Details</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<table  width="60%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr align="center">
				<td class="main_tab_active">Company Details</td>
				<td align="center" class="main_tab_inactive"><a href="javascript:callLink('set_KYCNorms.jsp','mastapplicant','getKYCNormsdetails')"
					>KYC Norms</a></td>
				<td class="main_tab_inactive"><a href="javascript:callLink('comappFactoryDetails.jsp','commappmaster','getFactoryDetails')"
					> Branches</a></td>
				<td class="main_tab_inactive"><a
					href="javascript:callLink('comappdivision.jsp','commappmaster','getDivisionDetails')"
					>Division/ Sister/ Group Concerns</a></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
							<tr>
								<td>								
                          <table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
							<tr>
								<td colspan="4">
									<table width="100%" align="center" cellpadding="0" cellspacing="0" class="outertable">
									<tr>
										<td width="35%"><b>To copy the data from INWARD REGISTER</b></td>
										<td width="65%"><a href="#"
												onClick="fnSearchinwardno()"
												style="cursor:hand" tabindex="15"><img
												src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
												border="0" tabindex="81"></a></td>
									</tr> 
									</table>
								</td>
							</tr>
                            <tr> 
                              <td width="17%"> 
                                <input type="hidden" name="comapp_id" size="20" maxlength="23">Corporate Type <span class="mantatory">* </span></td>
                              <td width="23%"> 
                                <select name="comapp_commtype" tabindex="1"
											onchange="showSME()">
                                  <option Selected="selected" value="">--Select--</option>
                                  <option value="CORP">Corporate</option>
                                  <option value="SME">SME</option>
                                </select>
                              </td>
                              <td width="15%" id="sme">SME Type<span class="mantatory">*</span></td>
                              <td colspan="3" id="smetype"> 
                                <select name="comapp_smetype" tabindex="2">
                                  <option Selected="selected" value="0">--Select--</option>
                                  <option value="1">Micro</option>
                                  <option value="2">Small</option>
                                  <option value="3">Medium</option>
                                </select>
                              </td>
                            </tr>
                            <tr> 
                              <td width="17%">Company Name <span class="mantatory">*</span></td>
                              <td colspan="5"> 
                                <input type="text" name="comapp_companyname"
											size="80" maxlength="80" style="border-style:groove"
											value="<%=Helper.correctNull((String)hshValues.get("comapp_companyname"))%>"
											onKeyPress="notAllowedDouble()" tabindex="3">
                              </td>
                            </tr>
                            <tr> 
                              <td width="17%">Industry BSR Code<span class="mantatory">*</span></td>
                              <td colspan="5"> 
                                <input type="hidden" name="comapp_indcode"
											size="20" maxlength="23"
											style="text-align:left;border-style=groove" value="">
                                <input
											type="text" name="comapp_companyid" size="80" maxlength="125"
											style="text-align:left;border-style=groove"
											onKeyPress="notAllowedDouble();notAllowSpace()"
											onBlur="checkId()" tabindex="7" readOnly="readonly">
                                <span
											onClick="callDescHelp('applicantmaster')" style="cursor:hand"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0" tabindex="7"></span> 
                              </td>
                            </tr>
                            <tr> 
                              <td width="17%"><span class="interfacedata">CBS Customer 
                                ID</span></td>
                              <td width="23%"> 
                                <input type="text" name="comapp_cbsid"
											size="12" maxlength="10"
											style="text-align:left;border-style=groove"
											onKeyPress="allowInteger(this)"
											value="<%=Helper.correctNull((String)hshValues.get("cbs_companycode"))%>"
											tabindex="4">
                              </td>
                              <td width="17%"><span class="interfacedata">IRB Company Code</span></td>
                              <td colspan="3"> 
                                <input type="text" name="txt_irbcode"
											size="16" maxlength="14" onKeyPress="allowInteger(this)"
											value="<%=Helper.correctNull((String)hshValues.get("comapp_irbid"))%>">
                              </td>
                            </tr>
                            <tr> 
                              <td width="17%">Line of Activity <span class="mantatory">*</span></td>
                              <td width="23%"> 
                                <input type="text"
											name="comapp_businessnature" size="30" maxlength="125"
											style="text-align:left;border-style=groove"
											onKeyPress="notAllowedDouble()" tabindex="5">
                              </td>
                              <td width="17%">PAN Number <span class="mantatory">*</span></td>
                              <td colspan="3"> 
                                <input type="text" name="comapp_corpstructure"
											size="15" maxlength="10"
											style="text-align:left;border-style=groove"
											onKeyPress="allowAlphaNumeric()" onBlur="checkpanno(this)"
											tabindex="8">
                              </td>
                            </tr>
                            <tr> 
                              <td width="17%">ROC Number</td>
                              <td width="23%"> 
                                <input type="text" name="comapp_companyrole"
											size="30" maxlength="30"
											style="text-align:left;border-style=groove"
											onKeyPress="notAllowedDouble()" tabindex="9">
                              </td>
                              <td width="17%">Date of Incorporation</td>
                              <td colspan="3"> 
                                <table>
                                  <tr> 
                                    <td> 
                                      <input type="text" name="comapp_yrsinbusiness" size="12"
													maxlength="10" style="text-align:left;border-style=groove"
													onBlur="checkDate(this);checkmaxdate(this,currentDate)"
													tabindex="10">
                                      <a alt="Select date from calender"
													href="javascript:callCalender('comapp_yrsinbusiness')"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													width="21" height="18" border="0"></a></td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr> 
                              <td width="17%">Total Employees</td>
                              <td width="23%"> 
                                <input type="text" name="comapp_totemployees"
											size="7" maxlength="10"
											style="text-align:left;border-style=groove"
											onKeyPress="allowInteger(this);" tabindex="11">
                              </td>
                              <td width="17%">Type of Ownership<span class="mantatory">*</span></td>
                              <td> 
                                <select name="comapp_ownership" tabindex="12"
											onChange="callnbfc()">
                                  <option Selected="selected" value="">---Select---</option>
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
                                  <option value="S" selected="selected">&lt;---Select---&gt;</option>
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
											style="text-align:left;border-style=groove" onKeyPress=""
											readOnly="readonly" value="" tabindex="15">
                                <span
											onClick="openGroup()" style="cursor:hand"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0" tabindex="81"></span></td>
											
											<td width="17%" id="own" >Company Identification Number(CIN)</td>
                              <td width="17%" id="own"> 
                                <input type="text" name="txt_cin" maxlength="10"
											size="11" onkeypress="allowAlphaNumeric()"
											value="<%=Helper.correctNull((String)hshValues.get("comapp_cin"))%>"
											tabindex="13">
                              </td><td width="17%" id="own">&nbsp;</td><td id="own">&nbsp;</td>
                           
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
                                  <option selected="selected" value="S">------------select---------------</option>
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
											style="text-align:left;border-style=groove"
											onKeyPress="allowAlphabetsForName();notAllowedDouble()" tabindex="6">
                              </td>
                            </tr>
                            <tr> 
                              <td width="17%" >Industry Type</td>
                              <td width="23%" > 
                                <select name="scale" tabindex="18">
                                  <option value="0" selected="selected">----Select----</option>
                                  <option value="1">Services</option>
                                  <option value="2">Exports</option>
                                  <option value="3">Agriculture</option>
                                  <option value="4">Infrastructure</option>
                                  <option value="Trading">Trading</option>
                                  <option value="Manufacturing">Manufacturing</option>
                                </select>
                              </td>
                              <td nowrap="nowrap"  width="17%">Email Address</td>
                              <td colspan="4" > 
                                <input type="text" name="comapp_email"
											size="30" maxlength="30"
											style="text-align:left;border-style=groove"
											onKeyPress="notAllowedDouble()"
											onBlur="isEmailAddr(document.forms[0].comapp_email.value,document.forms[0].comapp_email)"
											tabindex="17">
                              </td>
                            </tr>
                            <tr> 
                              <td width="17%" >Application Recd. From <span class="mantatory">*</span></td>
                              <td colspan="6" > 
                                <input type="hidden" name="comapp_scode"
											tabindex="13" style="width:200">
                                <input type="text"
											name="comapp_orgname" size="55"
											value="<%=Helper.correctNull((String)hshValues.get("comapp_orgname"))%>">
                                <a href="#"
											onClick="showOrgSearch('<%=ApplicationParams.getAppUrl()%>','comapp_scode','comapp_orgname')"
											style="cursor:hand" tabindex="15"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0" tabindex="81"></a></td>
                            </tr>
                          </table>
								</td>
							</tr>

							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr class="dataheader">
										<td  colspan="2">Registered Office Address</td>
										<td  colspan="2">Corporate Address</td>
										<td  colspan="2">Administrative office address </td>
									</tr>
									<tr>
										<td  valign="top" width="10%">Address<span
											class="mantatory">*</span></td>
										<td  valign="top" width="24%"> <input
											type="text" name="comapp_regadd1" size="30" maxlength="200"
											tabindex="34"> </td>
										<td  valign="top" width="10%">Address</td>
										<td  valign="top" width="23%"><input type="text"
											name="comapp_crptaddress1" size="30" maxlength="50"
											style="border-style:groove" onKeyPress="notAllowedDouble()"
											value="<%=Helper.correctDoubleQuotesHtml((String)hshValues.get("comapp_crptaddress1"))%>"
											tabindex="17"></td>
										<td  width="10%">Address</td>
										<td width="23%"><input type="text" name="comapp_admadd1"
											size="30" maxlength="200" tabindex="42"
											value="<%=Helper.correctDoubleQuotesHtml((String)hshValues.get("comapp_admadd1"))%>">
										</td>
									</tr>
									<tr>
										<td  valign="top" width="10%">&nbsp;</td>
										<td  valign="top" width="24%"><input type="text"
											name="comapp_regadd2" size="30" maxlength="200" tabindex="35">
										</td>
										<td  valign="top" width="10%">&nbsp;</td>
										<td  valign="top" width="23%"><input type="text"
											name="comapp_crptaddress2" size="30" maxlength="50"
											style="border-style:groove" onKeyPress="notAllowedDouble()"
											tabindex="18"
											value="<%=Helper.correctDoubleQuotesHtml((String)hshValues.get("comapp_crptaddress2"))%>">
										</td>
										<td  width="10%">&nbsp;</td>
										<td width="23%"><input type="text" name="comapp_admadd2"
											size="30" maxlength="200" tabindex="43"></td>
									</tr>
									<tr>
										<td valign="top" width="10%">City<span
											class="mantatory">*</span></td>
										<td valign="top" width="24%">
										<input type="text" name="comapp_regcity" size="30" maxlength="30" tabindex="36"	onKeyPress="notAllowSplChar()"
											value="<%=Helper.correctNull((String)hshValues.get("comapp_regcity"))%>" readOnly>
											<span onClick="showCitySearch('comapp_regcity','comapp_regstate','hidcity3','hidstate3','comapp_regpin','hidzip')" style="cursor:hand">
											<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0" tabindex="36"></span></td>
										<td  valign="top" width="10%">City</td>
										<td  valign="top" width="23%"><input type="text"
											name="comapp_crptcity" size="30" maxlength="30"
											style="text-align:left;border-style=groove"
											onKeyPress="notAllowSplChar()" tabindex="19"
											value="<%=Helper.correctNull((String)hshValues.get("comapp_crptcity"))%>">
										</td>
										<td  width="10%">City</td>
										<td width="23%"><input type="text" name="comapp_admcity"
											size="30" maxlength="30" tabindex="44"
											onKeyPress="notAllowSplChar()"
											value="<%=Helper.correctNull((String)hshValues.get("hidcity4"))%>">
										</td>
									</tr>
									<tr>
										<td  valign="top" width="10%">State</td>
										<TD  valign="top" width="24%"><input type="text"
											name="comapp_regstate" style="width:160"
											value="<%=Helper.correctNull((String)hshValues.get("comapp_regstate"))%>"
											tabindex="38" readOnly="readonly"></td>
										<TD  valign="top" width="10%">State</td>
										<TD  valign="top" width="23%"><input type="text"
											name="comapp_crptstate" size="30"
											style="text-align:left;border-style=groove"
											onKeyPress="notAllowedDouble()" tabindex="20" maxlength="50"
											value="<%=Helper.correctNull((String)hshValues.get("comapp_crptstate"))%>">
										</td>
										<td width="10%" >State</td>
										<td width="23%"><input type="text" name="comapp_admstate"
											style="width:160" onClick="" tabindex="46"
											value="<%=Helper.correctNull((String)hshValues.get("hidstate4"))%>">
										</td>
									</tr>
									<tr>
										<td  valign="top" width="10%"><%=ApplicationParams.getZipName()%><span
											class="mantatory">*</span></td>
										<td  valign="top" width="24%"><input type="text"
											name="comapp_regpin" size="12"
											maxlength="<%=ApplicationParams.getZipValue()%>"
											onKeyPress="allowInteger()" tabindex="39"
											onBlur="zipvalidate(this,'<%=ApplicationParams.getZipValue()%>')">
										</td>
										<td  valign="top" width="10%"><%=ApplicationParams.getZipName()%></td>
										<td  valign="top" width="23%"><input type="text"
											name="comapp_crptpin" size="12"
											maxlength="<%=ApplicationParams.getZipValue()%>"
											style="text-align:left;border-style=groove"
											onKeyPress="allowInteger();"
											onBlur="zipvalidate(this,'<%=ApplicationParams.getZipValue()%>');"
											value="<%=Helper.correctNull((String)hshValues.get("comapp_crptpin"))%>"
											tabindex="23"></td>
										<td  width="10%"><%=ApplicationParams.getZipName()%></td>
										<td width="23%"><input type="text" name="comapp_admpin"
											size="12" maxlength="<%=ApplicationParams.getZipValue()%>"
											onKeyPress="allowInteger()" tabindex="47"
											onBlur="zipvalidate(this,'<%=ApplicationParams.getZipValue()%>')">
										</td>
									</tr>
									<tr>
										<td  valign="top" width="10%">Country <span
											class="mantatory">*</span></td>
										<td  valign="top" width="24%"><input type="text"
											name="comapp_regcountry"
											value="<%=Helper.correctNull((String)hshValues.get("regcountrydesc"))%>"
											size="30" maxlength="20" tabindex="40"
											onKeyPress="notAllowSplChar();notallowInteger()"> <input
											type="hidden" name="comapp_hidregcountry"
											value="<%=Helper.correctNull((String)hshValues.get("comapp_regcountry"))%>">
										 <a href="#"
											onClick="callCntrySearch('comapp_regcountry','comapp_hidregcountry')"
											style="cursor:hand" tabindex="8"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0" tabindex="21"></a></td>
										<td  valign="top" width="10%">&nbsp;</td>
										<td  valign="top" width="23%">&nbsp;</td>
										<td  width="10%">&nbsp;</td>
										<td width="23%">&nbsp;</td>
									</tr>
									<tr>
										<td  valign="top" width="10%">Phone No.</td>
										<td  valign="top" width="24%"><input type="text"
											name="comapp_regphone" onKeyPress="allowPhone()" size="25"
											maxlength="20" tabindex="40"></td>
										<td  valign="top" width="10%">Phone No.</td>
										<td  valign="top" width="23%"><input type="text"
											name="comapp_crptphone" size="25" maxlength="20"
											value="<%=Helper.correctNull((String)hshValues.get("comapp_crptphone"))%>"
											onKeyPress="allowPhone()" tabindex="24"></td>
										<td  width="10%">Phone No.</td>
										<td width="23%"><input type="text" name="comapp_admphone"
											size="25" maxlength="20" onKeyPress="allowPhone()"
											tabindex="48"></td>
									</tr>
									<tr>
										<td  valign="top" width="10%">Fax No</td>
										<td  valign="top" width="24%"><input type="text"
											name="comapp_regfax" onKeyPress="notAllowedDouble()"
											size="30" maxlength="20" tabindex="41"></td>
										<td  valign="top" width="10%">Fax No.</td>
										<td  valign="top" width="23%"><input type="text"
											name="comapp_crptfax" size="30" maxlength="20"
											value="<%=Helper.correctNull((String)hshValues.get("comapp_crptfax"))%>"
											onKeyPress="notAllowedDouble()" tabindex="25"></td>
										<td  width="10%">Fax No.</td>
										<td width="23%"><input type="text" name="comapp_admfax"
											size="30" maxlength="20" onKeyPress="notAllowedDouble()"
											tabindex="49"></td>
									</tr>
									<tr>
										<td  valign="top" width="10%">Premises</td>
										<td  valign="top" width="24%"><select
											name="comapp_regpremises" tabindex="37">
											<option value="0" selected="selected">----Select----</option>
											<option value="1">Owned</option>
											<option value="2">Leased</option>
											<option value="3">Rented</option>
										</select></td>
										<td  valign="top" width="10%">Premises</td>
										<td  valign="top" width="23%"><select
											name="comapp_corppremises" tabindex="21">
											<option value="0" selected="selected">--Select--</option>
											<option value="1">Owned</option>
											<option value="2">Leased</option>
											<option value="3">Rented</option>
										</select></td>
										<td  width="10%">&nbsp;</td>
										<td width="23%">&nbsp;</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td>
								
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                            <tr class="dataheader"> 
                              <td colspan="5"> CBS Data </td>
                            </tr>
                            <tr > 
                              <td >Introducer Title</td>
                              <td> 
                                <select name="txt_ititle">
                                  <option value="MR" selected="selected">Mr.</option>
                                  <option value="MS">Ms.</option>
                                  <option value="MRS">Mrs.</option>
                                  <option value="M/S">M/s.</option>
                                </select>
                              </td>
                              <td width="20%">Introducer Name</td>
                              <td width="27%"> 
                                <input type="text" name="txt_introname" size="30"
											maxlength="30" onkeyPress="allowAlphabetsForName()"
											value="<%=Helper.correctNull((String)hshValues.get("company_introname"))%>">
                                <input type="hidden" name="hid_introname">
                              </td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr > 
                              <td> Trade Finance <span class="mantatory">*</span></td>
                              <td> 
                                <select name="sel_staff" onChange="showIEC()">
                                  <option Selected="selected" value="">--Select--</option>
                                  <option value="Y">Yes</option>
                                  <option value="N">No</option>
                                </select>
                              </td>
                              <td width="20%">Status </td>
                              <td > 
                                <select name="sel_status">
                                  <option value="0">--Select--</option>
                                  <%String apptype = "26";%>
                                  <lapschoice:StaticDataNewTag apptype='<%=apptype%>' /> 
                                </select>
                              </td>
                            </tr>
                            <tr  id="iec"> 
                              <td> IEC Code <span class="mantatory">*</span></td>
                              <td> 
                                <input type="text" name="txt_ieccode" size="25" maxlength="20"
											value="<%=Helper.correctNull((String)hshValues.get("comapp_ieccode"))%>">
                              </td>
                              <td width="20%">&nbsp;</td>
                              <td >&nbsp;</td>
                            </tr>
                            <tr > 
                              <td> If Trade Finance yes Inland trade allowed</td>
                              <td> 
                                <select name="sel_inland">
                                  <option value="Y">Yes</option>
                                  <option value="N" selected="selected">No</option>
                                </select>
                              </td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                           
                            <tr align="center"> 
                              <td colspan="5">
                                  <INPUT TYPE="button" NAME="cmd_reldet"
											VALUE="Relationship Details" STYLE="width:250"
											CLASS="buttonOthers" ONCLICK="callRelationship()">
                               <%--  <INPUT
											TYPE="button" NAME="ramdetails" VALUE="IRB Details *"
											STYLE="color:#FF0000;" CLASS="buttonOthers"
											ONCLICK="doramdetails()"> --%>
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
</table><br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Renew_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="exist"> 
<input type="hidden" name="scode" value="yy"> 
<input type="hidden" name="strStatId1" value=""> 
<input type="hidden" name="hidsno" value="">
<input type="hidden" name="comapp_groupid" value="<%=Helper.correctNull((String)hshValues.get("comapp_groupid"))%>">
<input type="hidden" name="appflag" value="<%=Helper.correctNull((String)hshValues.get("appflag"))%>">
<input type="hidden" name="hidcity3" value="<%=Helper.correctNull((String)hshValues.get("hidcity3"))%>"> 
<input type="hidden" name="hidstate3" value="<%=Helper.correctNull((String)hshValues.get("hidstate3"))%>"> 
<input type="hidden" name="comapp_type"> 
<input type="hidden" name="comapp_oldid" value="<%=Helper.correctNull((String)hshValues.get("comapp_oldid"))%>">
<input type="hidden" name="hidappexist" value="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>"> 
<input type="hidden" name="hidstatus" value=""> 
<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
<input type="hidden" name="hidzip">
</form>
</body>
<script>
if(document.forms[0].appflag.value == "Y")
{
	alert("Applicant with the same Company Name  found in location "+Apporg_name);
}
</script>
</html>

