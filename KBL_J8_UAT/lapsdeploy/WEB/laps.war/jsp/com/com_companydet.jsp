<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<% request.setAttribute("_cache_refresh", "true"); %>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<%
//out.println(hshValues);
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String dateofincorp = Helper.correctNull((String)hshValues.get("dateofincorp"));
if (dateofincorp.equals("01/01/1900"))
{	dateofincorp = ""; }
String strapplevel = Helper.correctNull((String)request.getParameter("applevel"));
String strstatus = Helper.correctNull((String) request.getParameter("hidstatus"));
String strSaral = Helper.correctNull((String) request.getParameter("hidsaral"));
String strProposal=Helper.correctNull((String)request.getParameter("hidproposal"));
String extlastrate=Helper.correctNull((String)hshValues.get("extlastrate"));
String extcurrate=Helper.correctNull((String)hshValues.get("extcurrate"));
ArrayList VecFactory=new ArrayList();
VecFactory=(ArrayList)hshValues.get("vecRow");
int VecFact=0;
if(VecFactory!=null)
{
	VecFact=VecFactory.size();
}
if(!strCategoryType.equalsIgnoreCase(""))
{
	session.removeAttribute("cattype");
	session.setAttribute("cattype",strCategoryType);
}
String strBrchInwname=Helper.correctNull((String) hshValues.get("com_npabranch"));
String strHOcheck=Helper.correctNull((String) hshValues.get("headoffice"));
session.setAttribute("Propformat",Helper.correctNull((String)hshValues.get("com_format")));
String appstatus=Helper.correctNull((String)request.getParameter("appstatus"));
if(appstatus!=null){
	appstatus=Helper.correctNull((String) hshValues.get("app_status"));
	session.setAttribute("strappstatus",appstatus);
	if(appstatus.equalsIgnoreCase("op"))
	{
		appstatus = "Open/Pending";
	}
	else if(appstatus.equalsIgnoreCase("pa"))
	{
		appstatus = "Processed/Approved";
	}
	else if(appstatus.equalsIgnoreCase("pr"))
	{
		appstatus = "Processed/Rejected";
	}
	else if(appstatus.equalsIgnoreCase("ca"))
	{
		appstatus = "Closed/Approved";
	}
	else if(appstatus.equalsIgnoreCase("cr"))
	{
		appstatus = "Closed/Rejected";
	}
}
session.setAttribute("strRatingTabHide",Helper.correctNull((String)hshValues.get("strRatingTabHide")));
String strSanBranch=Helper.correctNull((String) hshValues.get("com_sancbranch"));
session.setAttribute("strAppType",Helper.correctNull((String)hshValues.get("app_renew_flag")));
session.setAttribute("PRD_CGTMSE", Helper.correctNull((String) hshValues.get("PRD_CGTMSE")));
String orglevel=Helper.correctNull((String)hshValues.get("strAppCreatedOrg"));
session.setAttribute("strcgssdType", Helper.correctNull((String) hshValues.get("strcgssdavailable")));
session.setAttribute("APP_LOANSUBTYPE_DIGI", Helper.correctNull((String) hshValues.get("APP_LOANSUBTYPE_DIGI")));
String strParams=Helper.correctNull((String)session.getAttribute("strModifyterms"));	
session.setAttribute("restgeclmandatorychk",Helper.correctNull((String)hshValues.get("strgeclrestasseschk")));

String strNCGTCFg=Helper.correctNull((String)session.getAttribute("strncgtcflag")).trim();
String strncgtcbankscheme=Helper.correctNull((String)session.getAttribute("strncgtcbankscheme")).trim();


%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js">
</script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentdate= "<%=Helper.getCurrentDateTime()%>";
var appstatus="<%=appstatus%>";
var proposalfrmt="<%=Helper.correctNull((String)hshValues.get("com_format"))%>";
var strncgtcflag="<%=strNCGTCFg%>";
var strncgtcbankscheme="<%=strncgtcbankscheme%>";
var varAmountvalue="<%=Helper.correctNull((String)hshValues.get("com_amountvalue"))%>";
var varProposalType="<%=Helper.correctNull((String)session.getAttribute("strAppType"))%>";
	
var varSancDeptSaved = "<%=Helper.correctNull((String)hshValues.get("com_sancdept"))%>";
var varsanbranch="<%=strSanBranch%>";
var varorglevel1="<%=Helper.correctNull((String)session.getAttribute("strOrgLevel"))%>";
var varwcdpn_available="<%=Helper.correctNull((String)hshValues.get("wcdpn_available"))%>";
var sancauthoritySaved="<%=Helper.correctNull((String)hshValues.get("com_sancauthority"))%>";
var varVerifyWithCFR="<%=Helper.correctNull((String) hshValues.get("COM_CFR_VERIFIED"))%>";
var varNamApprCFR="<%=Helper.correctNull((String) hshValues.get("COM_CFR_BORNAME"))%>";
var varStaVeri="<%=Helper.correctInt((String) hshValues.get("status_verified1"))%>";
var APP_PERM_NO="<%=Helper.correctNull((String)hshValues.get("APP_PERM_NO"))%>";
var varorglevel="<%=orglevel%>";
var vargeclavailable="<%=Helper.correctNull((String)hshValues.get("strgeclavailable"))%>";
var varDPN2020="<%=Helper.correctNull((String)hshValues.get("strDPN2020"))%>";
var appnofortest="<%=Helper.correctNull((String)request.getParameter("appno"))%>";
var checkprocesscharges="<%=Helper.correctNull((String)hshValues.get("checkprocesscharges"))%>";
function callCalender(fname)
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		showCal(appURL,fname);
	}
}
function disablefields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=val;
		}	  
		else if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		else if(document.forms[0].elements[i].type=='select-multiple')
		{
			document.forms[0].elements[i].disabled=val;
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}		
	}
}
function dateDOBCheck(objname)
{
	var mycurrdate = new Date(currdate.substring(6,10),currdate.substring(3,5)-1,currdate.substring(0,2));	
  	var DOB =  objname.value
    var mydobdate = new Date(DOB.substring(6,10),DOB.substring(3,5)-1,DOB.substring(0,2));
	if (mydobdate > mycurrdate)
	{
		alert("Date should not be greater  to current date");
		objname.focus();
		objname.value="";
		return;
	}	
}
function compareDate()
{
	var d1 = document.forms[0].dob.value;
	d1 = changeDateformat(d1);	
	var currdate = "<%=Helper.getCurrentDateTime()%>";
	currdate = changeDateformat(currdate);
	if(document.forms[0].dob.value != "")
	{
		if( d1 > currdate )
		{
			alert(" NPA should not be greater than current date");
			document.forms[0].dob.value = "";
			document.forms[0].dob.focus();	
		}
	}
}
function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdcomments.disabled=bool6;
}
function call_page(url)
{
	if (document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].action=appURL+"action/"+url;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}	
}
function change_select()
{
	if(document.forms[0].select_asset.value != "Standard" && document.forms[0].select_asset.value != "N.A.")
	{
		document.all.labelchange.innerText="NPA Since";
		document.all.showtext.style.visibility = "visible";
	}
	else
	{
		document.all.labelchange.innerText="";
		document.all.showtext.style.visibility = "hidden";
	}
}
function show_details()
{
	asset = "<%=Helper.correctNull((String)hshValues.get("asset"))%>";
	if (asset != "")
	{
		document.forms[0].select_asset.value ="<%=Helper.correctNull((String)hshValues.get("asset"))%>";
		document.forms[0].txt_npa.value ="<%=Helper.correctNull((String)hshValues.get("npa"))%>";
	}
}
function placevalues()
{
	
	if(checkprocesscharges=="Y")
	{
		
		document.forms[0].txt_procfee.value="0.00";
	}
	disablefields(true);
	if(appstatus=="Open/Pending")
	{
		enableButtons(false,true,true,false,true,false);
	}
	else
	{
		enableButtons(true,true,true,false,true,false);
	}
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		if("<%=strstatus%>"=="O" && varright=="w"){
		    enableButtons(true,true,true,true,true,false);
		}else{
			enableButtons(true,true,true,false,true,false);	
		}
	}else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		enableButtons(true,true,true,false,true,true);
    }else{
		if("<%=strapplevel%>" == "S"){
			<%if(!strCategoryType.equalsIgnoreCase("OPS"))
			{
				%>
			enableButtons(true,true,true,false,true,false);
		<%	}
			else
			{%>
				  enableButtons(true,true,true,false,true,false);
		<%	}%>
		}else{
			if(document.forms[0].btnenable.value=="Y"){
				enableButtons(false,true,true,false,true,false);
				
			}else {
				enableButtons(true,true,true,false,true,false);
			}
		}
	}
	if(document.forms[0].hidNonPoolFlag.value=="Y")
	{
		enableButtons(true,true,true,false,true,false);
	}
	var type='<%=strCategoryType%>';
	var brnhrecdate="<%=Helper.correctNull((String)hshValues.get("com_submittedto"))%>";	
	var proposalfrmt="<%=Helper.correctNull((String)hshValues.get("com_format"))%>";
	var assetclasify="<%=Helper.correctNull((String)hshValues.get("com_asset"))%>";
	var sancauthority="<%=Helper.correctNull((String)hshValues.get("com_sancauthority"))%>";
	var sancdept="<%=Helper.correctNull((String)hshValues.get("com_sancdept"))%>";
	var varclphcheck="<%=Helper.correctNull((String)hshValues.get("clphchk"))%>";
	if(appstatus!="Open/Pending")
	{
		if(varclphcheck=="Y" && sancdept=="012"){
		sancdept="018";
	}
	}else{
		var sancdept="<%=Helper.correctNull((String)hshValues.get("com_sancdept"))%>";
	}
	var sancLevel="<%=Helper.correctNull((String)hshValues.get("com_sanclevel"))%>";
	var varPropsalSancType="<%=Helper.correctNull((String)hshValues.get("com_proposalsanctype"))%>";
	var varCersaiID="<%=Helper.correctNull((String)hshValues.get("COM_CERSAI_VERIFIED"))%>";
	document.forms[0].sel_amount.value =varAmountvalue;

	if(vargeclavailable=="Y")
	{
		document.forms[0].sel_proposalformat.length=2;
		document.forms[0].sel_proposalformat.options[0] = new Option('----select----','s');
	 	document.forms[0].sel_proposalformat.options[1] = new Option('KBL - GECL Process Note','7');
	}
	if(varDPN2020=="Y")
	{
		document.forms[0].sel_proposalformat.length=2;
		document.forms[0].sel_proposalformat.options[0] = new Option('----select----','s');
	 	document.forms[0].sel_proposalformat.options[1] = new Option('Interest Deferment DPN 2020','8');
	}
	if(varProposalType=="R")
	{
		
		document.forms[0].sel_proposalformat.length=5;
		document.forms[0].sel_proposalformat.options[0] = new Option('----select----','s');
	 	document.forms[0].sel_proposalformat.options[1] = new Option('Simplified Renewal Process Note','12');
	 	document.forms[0].sel_proposalformat.options[2] = new Option('EC - Board Format','1');
	 	document.forms[0].sel_proposalformat.options[3] = new Option('100% Cash Margin','3');
	 	document.forms[0].sel_proposalformat.options[4] = new Option('Other than EC - Board','4');
	 	document.forms[0].sel_proposalformat.options[5] = new Option('Short Notes','5');
	}
	
	if(brnhrecdate!="")
	{
	document.forms[0].sel_proposalsubmit.value =brnhrecdate;
	}
	if(proposalfrmt!="")
	{
	document.forms[0].sel_proposalformat.value =proposalfrmt;
	}
	if(sancdept!="")
	{
	document.forms[0].sel_SancDept.value =sancdept;
	}
	if(sancLevel!="")
	{
	document.forms[0].sel_SancLevel.value =sancLevel;
	}
	if(varAmountvalue=="")
	{
	document.forms[0].sel_amount.value ="s";
	}
	if(varCersaiID!="")
	{
	document.forms[0].CERSAI_verified.value =varCersaiID;
	}
	else{
	document.forms[0].CERSAI_verified.value="";
	}
	if(varPropsalSancType!="")
	{
		document.forms[0].sel_sanctiontype.value =varPropsalSancType;
	}
	else
	{
		document.forms[0].sel_sanctiontype.value ="0";
	}
	funsancrefno();
	funsanctiondept(sancauthority,'N');
	if(varsanbranch!="")
	{
		document.forms[0].sel_SancBranch.value =varsanbranch;
	}
	if(varProposalType=="P")
	{
		 <%if(Helper.correctNull((String)session.getAttribute("strModifyterms")).contains("@MODPROCESSCHARG@") ) {%>
		document.all.idprocfee.style.display="table-cell";
		document.all.idprocfee1.style.display="table-cell";
		<%}else{%>
		document.all.idprocfee.style.display="none";
		document.all.idprocfee1.style.display="none";
		<%}%>
	}
	else
	{
		document.all.idprocfee.style.display="table-cell";
		document.all.idprocfee1.style.display="table-cell";
	}
	if(varProposalType=="F" || varProposalType=="R"|| varProposalType=="S")
	{
	//CFR
	if(varVerifyWithCFR=="Y")
	{
		document.forms[0].CFR_verified.value=varVerifyWithCFR;
		document.forms[0].Namein_CFR.value=varNamApprCFR;
		
		document.all.id_CFR3.style.display = "none";
		
	}else if(varVerifyWithCFR=="N")
	{	
		document.forms[0].CFR_verified.value=varVerifyWithCFR;
		document.all.id_CFR1.style.display = "none";
		document.all.id_CFR2.style.display = "none";
		document.all.id_CFR3.style.display = "none";
	}else if(varVerifyWithCFR=="NA")
	{	
		document.forms[0].CFR_verified.value=varVerifyWithCFR;
		document.all.id_CFR1.style.display = "none";
		document.all.id_CFR2.style.display = "none";
		document.all.id_CFR3.style.display = "none";
	}else
	{	
		document.forms[0].CFR_verified.value="S";
		document.forms[0].Namein_CFR.value="S";
		document.all.id_CFR1.style.display = "none";
		document.all.id_CFR2.style.display = "none";
		document.all.id_CFR3.style.display = "none";
	}
	
	if(varStaVeri=="A")
	{
		document.forms[0].status_verified.value=varStaVeri;
		document.all.id_status.innerText="CFR Deviation Approved By";
		document.all.id_statusdate.innerText="Approved Date";
		document.all.app1.style.display = "table-row";
		
	}else if(varStaVeri=="R")
	{
		document.forms[0].status_verified.value=varStaVeri;
		document.all.id_status.innerText="CFR Deviation Rejected By";
		document.all.id_statusdate.innerText="Rejected Date";
		document.all.app1.style.display = "table-row";
	}
	else
	{
		document.all.id_CFR3.style.display="none";
		document.all.app1.style.display = "none";
	}
		
	CheckCFR_verified();
	CheckCFR_name();
	document.all.idperm.style.display = "table-row";
	}
	else
	{
		document.all.idCFR.style.display="none";
		document.all.id_CFR3.style.display="none";
		document.all.app1.style.display = "none";
		document.all.idperm.style.display = "none";
	}
	if(APP_PERM_NO!="")
	{
		
		document.all.id_permLetter.style.visibility="visible";
	    document.all.id_permLetter.style.position="relative";
	    document.all.deattach.style.visibility="visible";
	    document.all.deattach.style.position="relative";
	}
	else
	{
		document.all.id_permLetter.style.visibility="hidden";
	    document.all.id_permLetter.style.position="absolute";
	    document.all.deattach.style.visibility="hidden";
	    document.all.deattach.style.position="absolute";
	}
}


function status_ver()
{
	if(document.forms[0].status_verified.value=="A")
	{
		document.all.app1.style.display = "table-row";
		document.all.id_status.innerText="CFR Deviation Approved By";
		document.all.id_statusdate.innerText="Approved Date";
		document.forms[0].hid_userid2.value="";
		document.forms[0].txt_userid2.value="";
		document.forms[0].appref_Appr_date.value="";
		
	}else if(document.forms[0].status_verified.value=="R")
	{
		document.all.app1.style.display = "table-row";
		document.all.id_status.innerText="CFR Deviation Rejected By";
		document.all.id_statusdate.innerText="Rejected Date";
		document.forms[0].hid_userid2.value="";
		document.forms[0].txt_userid2.value="";
		document.forms[0].appref_Appr_date.value="";
	}
	else if(document.forms[0].status_verified.value==""||document.forms[0].status_verified.value=="S")
	{
		document.all.app1.style.display = "none";
		document.forms[0].hid_userid2.value="";
		document.forms[0].txt_userid2.value="";
		document.forms[0].appref_Appr_date.value="";	
	}
}

function doCancel()
{
	if (ConfirmMsg(102))
	{
		document.forms[0].action=appURL+"action/com_companydet.jsp";
		document.forms[0].submit();
	}
}
function doEdit()
{	
	disablefields(false);
	document.forms[0].txt_userid2.readOnly=true;
	document.forms[0].dev_prop_no.readOnly=true;
	document.forms[0].sanctiondate.readOnly=true;
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value ="insert"
		if(checkprocesscharges=="Y")
		{
	      document.forms[0].txt_procfee.readOnly=true;
		}
	enableButtons(true,false,false,false,false,false);
	if(varorglevel=="C"||varorglevel=="D")
		document.forms[0].txt_perbranch.readOnly=true;
}
function doSave()
{
	if(document.forms[0].sel_proposalformat.value=="s")
	{
		ShowAlert('111', "Proposal format"); 	
		document.forms[0].sel_proposalformat.focus();
		return;	
	}
	
	if(document.forms[0].sel_SancDept.value=="s")
	{
		ShowAlert('111', "Sanctioning Department"); 	
		document.forms[0].sel_SancDept.focus();
		return;	
	}
	if(document.forms[0].sel_proposalformat.value=="1" && document.forms[0].sel_SancDept.value=="015" && document.forms[0].txt_CSLMSNO.value=="")
	{
		ShowAlert('121', "CS - LMC NO"); 	
		document.forms[0].txt_CSLMSNO.focus();
		return;	
	}
	
	if(document.forms[0].sel_SancDept.value=="010" || document.forms[0].sel_SancDept.value=="008" || document.forms[0].sel_SancDept.value=="013" || document.forms[0].sel_SancDept.value=="014"|| document.forms[0].sel_SancDept.value=="015"|| document.forms[0].sel_SancDept.value=="016")
	{
		if(document.forms[0].sel_SancBranch.value=="")
		{
			alert("Select Sanctioning Branch");
			document.forms[0].sel_SancBranch.focus();
			return;
		}
	}
	if(document.forms[0].sel_SancLevel.value=="s" ||document.forms[0].sel_SancLevel.value=="")
	{
		ShowAlert('111', "Sanctioning Level"); 	
		document.forms[0].sel_SancLevel.focus();
		return;	
	}
	
	if(document.forms[0].sel_SancAuth.value=="s" || document.forms[0].sel_SancAuth.value=="")
	{
		ShowAlert('111', "Sanctioning Authority"); 	
		document.forms[0].sel_SancAuth.focus();
		return;	
	}
	if(document.forms[0].sel_SancAuth.value=="14"||document.forms[0].sel_SancAuth.value=="15"||document.forms[0].sel_SancAuth.value=="16"){
		if(document.forms[0].txt_sancrefno.value==""){
				ShowAlert(121,"Sanction Reference No");
				document.forms[0].txt_sancrefno.focus();
				return ;
		}
		if(document.forms[0].sanctiondate.value==""){
				ShowAlert(111,"Sanction date");
				document.forms[0].sanctiondate.focus();
				return ;
		}
	}
	else
	{
		document.forms[0].txt_sancrefno.value="";
		document.forms[0].sanctiondate.value="";
	}
	if(!(document.forms[0].sel_SancAuth.value=="14"||document.forms[0].sel_SancAuth.value=="15"||document.forms[0].sel_SancAuth.value=="16"||
			document.forms[0].sel_SancAuth.value=="24"||document.forms[0].sel_SancAuth.value=="48"||document.forms[0].sel_SancAuth.value=="50"||document.forms[0].sel_SancAuth.value=="49"||document.forms[0].sel_SancAuth.value=="52")){
		document.forms[0].txt_griddate.value="";
	}
	if(document.forms[0].txt_sector.value=="")
	{
		ShowAlert('121', "Sector Priority / Non-Priority"); 	
		document.forms[0].txt_sector.focus();
		return;	
	}
	if(varProposalType=="P")
	{
		if(document.forms[0].sel_sanctiontype.value=="0")
		{
			ShowAlert('111', "Proposal Sanction Type"); 	
			document.forms[0].sel_sanctiontype.focus();
			return;	
		}
	}
	else
	{
		if(document.forms[0].txt_procfee.value=="")
		{
			ShowAlert('121', "Processing Fee"); 	
			document.forms[0].txt_procfee.focus();
			return;	
		}
	}

	if(varSancDeptSaved =="008" || varSancDeptSaved == "010"|| varSancDeptSaved == "013"|| varSancDeptSaved == "014"|| varSancDeptSaved == "015"|| varSancDeptSaved == "016")
	{
		var varCurrDept = document.forms[0].sel_SancDept.value;
		if(varCurrDept == "006" || varCurrDept == "007" || varCurrDept == "011")
		{
			if(confirm("Change in Sanctioning Department will delete the MCLR entries of all the facilities. Do you want to continue?"))
			{document.forms[0].hidDeptChange.value="Y";}
			else
			{return;}
		}
	}
	if(varwcdpn_available == "Y")
	{
		if(sancauthoritySaved != "" && sancauthoritySaved != document.forms[0].sel_SancAuth.value)
		{
			if(confirm("Change in Sanctioning Authority will delete the MCLR entries of all the WCDPN facilities. Do you want to continue?"))
			{document.forms[0].hidSancAuthChange.value="Y";}
			else
			{return;}
		}
	}

	if((sancauthoritySaved != document.forms[0].sel_SancAuth.value) && (sancauthoritySaved=="14"||sancauthoritySaved=="15"||sancauthoritySaved=="16"))
	{
		document.forms[0].hidSancAuth.value="Y";
	}

	if(varProposalType=="F" || varProposalType=="R"|| varProposalType=="S")
	{
		if(document.forms[0].CFR_verified.value=="N"||document.forms[0].CFR_verified.value=="S"||document.forms[0].CFR_verified.value=="NA")
		{
			document.forms[0].Namein_CFR.value="S";
			document.forms[0].txt_CFRdev_refno.value="";
			document.forms[0].status_verified.value="S";
			document.forms[0].hid_userid2.value="";
			document.forms[0].appref_Appr_date.value="";
		}else if(document.forms[0].Namein_CFR.value=="N")
		{
			document.forms[0].txt_CFRdev_refno.value="";
			document.forms[0].status_verified.value="S";
			document.forms[0].hid_userid2.value="";
			document.forms[0].appref_Appr_date.value="";
			
		}
		
		if(document.forms[0].CFR_verified.value=="")
		{
			ShowAlert('111',"Whether verified with Central Fraud Registry?");
			document.forms[0].CFR_verified.focus();
			return false;
		}
		if(document.forms[0].CFR_verified.value=="Y")
		{
			if(document.forms[0].Namein_CFR.value=="")
			{
				ShowAlert('111',"Whether Applicant/Co-applicant/Guarantor/Proprietor/Partner name appears in CFR ");
				document.forms[0].Namein_CFR.focus();
				return false;
			}
			else if(document.forms[0].Namein_CFR.value=="Y")
			{
				if(document.forms[0].txt_CFRdev_refno.value=="")
				{ 
					ShowAlert('121',"CFR Deviation Reference number");
					document.forms[0].txt_CFRdev_refno.focus();
					return false;
				}
			}
		}
		if(document.forms[0].CERSAI_verified.value==""){
			ShowAlert('111',"Whether CERSAI data base checked ?");
			document.forms[0].CERSAI_verified.focus();
			return false;
		}
		if(document.forms[0].Namein_CFR.value=="Y" && document.forms[0].status_verified.value=="S")
		{

			alert("Select CFR Deviation approval Status");
			document.forms[0].status_verified.focus();
			return
		}
		
		if(document.forms[0].status_verified.value=="A" && document.forms[0].txt_userid2.value=="")
		{
			alert("Enter the CFR Deviation Approved User");
			document.forms[0].txt_userid2.focus();
			return;
		}else if(document.forms[0].status_verified.value=="R" && document.forms[0].txt_userid2.value=="")
		{
			alert("Enter the CFR Deviation Rejected User");
			document.forms[0].txt_userid2.focus();
			return
		}
		else if(document.forms[0].status_verified.value=="A" && document.forms[0].appref_Appr_date.value=="")
		{
			alert("Select CFR Deviation Approved Date");
			document.forms[0].appref_Appr_date.focus();
			return;
		}else if(document.forms[0].status_verified.value=="R" && document.forms[0].appref_Appr_date.value=="")
		{
			alert("Select CFR Deviation Rejected Date");
			document.forms[0].appref_Appr_date.focus();
			return
		}
		 
			
	}

	if(varorglevel=="C"||varorglevel=="D")
	{
		if(document.forms[0].hid_perbranch.value=="")
		{
			ShowAlert('111', "Proposal pertains to the branch"); 	
			document.forms[0].txt_perbranch.focus();
			return;	
		}
		/*else if(varorglevel=="D")
		{
			if(document.forms[0].hidAppOrgcode.value.substring(0,9)!=document.forms[0].hid_perbranchcode.value.substring(0,9))
			{
				alert("Branch Should be with in RLPC"); 
				document.forms[0].hid_perbranchcode.value="";
				document.forms[0].hid_perbranch.value="";
				document.forms[0].txt_perbranch.value="";	
				document.forms[0].txt_perbranch.focus();
				return;	
			}
		}*/
	}
	
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateCompany";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].hidSourceUrl.value="/action/com_companydet.jsp";
	document.forms[0].submit();
}
function doDelete()
{
	var varCurrDept = document.forms[0].sel_SancDept.value;
	if(!varCurrDept == "")
	{
		if(confirm("Since there is a chance of Changing the Sanctioning Department, MCLR entries of all the facilities will be deleted. Do you want to continue?"))
		{document.forms[0].hidDeptChange.value="Y";}
		else
		{return;}
	}
	if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appURL+"action/ControllerServlet";	
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateCompany";	
	document.forms[0].hidBeanGetMethod.value="getData";				
	document.forms[0].hidSourceUrl.value="action/com_companydet.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();	
	}
}
function dohlp()     
{
  	var hlpvar = appURL+"phlp/corp_propobriefbg.htm";
  	var title = "BorrowerDemographics";
  	var prop = "scrollbars=yes,width=600,height=450";	
  	prop = prop + ",left=50,top=150";
  	window.open(hlpvar,title,prop);
}
function doClose()
{
	var cattype=document.forms[0].cattype.value;
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
}
function doComments()
{
	var btnenable=document.forms[0].btnenable.value;
	var strAppno = document.forms[0].hidAppNo.value;
	var pagetype = document.forms[0].hidCommentPage.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/com_bankingcomments.jsp?hidBeanId=facilities&hidBeanGetMethod=getComments&appno="+strAppno+"&hidPage1="+pagetype+"&btnenable="+btnenable+"&appstatus="+appstatus;
	window.open(url,"Comments",prop);
}
function funsancrefno()
{
	if((document.forms[0].sel_SancAuth.value=="15") || (document.forms[0].sel_SancAuth.value=="16")||(document.forms[0].sel_SancAuth.value=="14"))
	{
		document.all.sanrefno.style.display = "table-cell";
		document.all.sanrefval.style.display = "table-cell";
		document.all.sancdate1.style.display = "table-cell";
		document.all.sancdate2.style.display = "table-cell";	
	}
	else
	{
		document.all.sanrefno.style.display = "none";
		document.all.sanrefval.style.display = "none";
		document.all.sancdate1.style.display = "none";
		document.all.sancdate2.style.display = "none";	
		
	}		
	if((document.forms[0].sel_SancAuth.value=="24") || (document.forms[0].sel_SancAuth.value=="14")|| (document.forms[0].sel_SancAuth.value=="15")||
			(document.forms[0].sel_SancAuth.value=="16")||(document.forms[0].sel_SancAuth.value=="48")||(document.forms[0].sel_SancAuth.value=="50") ||(document.forms[0].sel_SancAuth.value=="49"))
	{
		document.all.idgriddate.style.display = "table-cell";
		document.all.idgriddate1.style.display = "table-cell";
	}
	else
	{
		document.all.idgriddate.style.display = "none";
		document.all.idgriddate1.style.display = "none";
		
	}

	if((document.forms[0].sel_SancAuth.value=="24") || (document.forms[0].sel_SancAuth.value=="16")||(document.forms[0].sel_SancAuth.value=="14")||(varorglevel1=="C"))
	{
		document.all.idintrefno.style.display = "table-cell";
		document.all.idintrefno1.style.display = "table-cell";
	}
	else
	{
		document.all.idintrefno.style.display = "none";
		document.all.idintrefno1.style.display = "none";
	}
	
			
}
function funchange(){
	if((document.forms[0].sel_SancAuth.value=="15") || (document.forms[0].sel_SancAuth.value=="16")||(document.forms[0].sel_SancAuth.value=="14"))
	{
		document.forms[0].txt_sancrefno.value="";
		document.forms[0].sanctiondate.value="";
	}
}
function funsanctiondept(varfname,val)
{
	/*if(document.forms[0].hidAppProcessAt.value!="012" && document.forms[0].sel_SancDept.value=="012" && val=="Y")
	{
		alert("Option is Applicable only for RLPC created Proposal");
		document.forms[0].sel_SancDept.value="s";
		return;
	}*/
	var varsancdept=document.forms[0].sel_SancDept.value;
	if((varsancdept=="008") || (varsancdept=="010")|| (varsancdept=="013")|| (varsancdept=="014")|| (varsancdept=="015")|| (varsancdept=="016"))
	{
		document.all.idsanbranch.style.display="table-cell";
		funsancbranchvalues();
	}
	else{
		document.all.idsanbranch.style.display="none";
		document.forms[0].sel_SancBranch.value="";
	}
	document.all.ifrmsancauthority.src=appURL+"action/iframesancauthority.jsp?hidBeanGetMethod=getSancAuthority&hidBeanId=comproposal&sancdept="+varsancdept+"&sancauth="+varfname;

	if(varsancdept=="015") 
	{
		document.all.id_CSLMSNO.style.visibility="visible";
	    document.all.id_CSLMSNO.style.position="relative";
	    document.all.id_CSLMSNO1.style.visibility="visible";
	    document.all.id_CSLMSNO1.style.position="relative";
	}
	else
	{
		document.all.id_CSLMSNO.style.visibility="hidden";
	    document.all.id_CSLMSNO.style.position="absolute";
	    document.all.id_CSLMSNO1.style.visibility="hidden";
	    document.all.id_CSLMSNO1.style.position="absolute";
	    document.forms[0].txt_CSLMSNO.value="";
	}

}
function funsancbranchvalues()
{
	var varsancdept=document.forms[0].sel_SancDept.value;
	document.all.ifrmsancbranch.src=appURL+"action/ifrmsancbranches.jsp?hidBeanGetMethod=getSancBranches&hidBeanId=comproposal&sancdept="+varsancdept+"&sancbranch="+varsanbranch;
}

function CheckCFR_verified()
{
	if(document.forms[0].CFR_verified.value=="Y")
	{
		document.all.id_CFR1.style.display = "table-cell";
		document.all.id_CFR2.style.display = "table-cell";
	}
	else
	{
		document.forms[0].Namein_CFR.value="";
		document.forms[0].txt_CFRdev_refno.value="";
		document.all.id_CFR1.style.display = "none";
		document.all.id_CFR2.style.display = "none";
		document.all.id_CFR3.style.display = "none";
		document.all.app1.style.display = "none";
	}
}

function CheckCFR_name()
{
	if(document.forms[0].Namein_CFR.value=="Y")
	{
		document.all.id_CFR3.style.display = "table-row";

	}
	else
	{
		document.forms[0].txt_CFRdev_refno.value="";
		document.all.id_CFR3.style.display = "none";
		document.all.app1.style.display = "none";
	}
}
function callUsersHelp1()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = appURL+"action/setUserSearch.jsp?pagefrom=CFRDet1";
		var title = "Users";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
}
function doPermissionLetter()
{
	var permappno=document.forms[0].dev_prop_no.value;
	var prop = "scrollbars=yes,width=650,height=500,top=25,left=180";
	var url=appURL+"action/permissionletter.jsp?hidBeanId=perDeviation&hidBeanGetMethod=getPermissionLetterData&appno="+permappno;
	window.open(url,"",prop);
}
function doSearch()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var hidAppNo=document.forms[0].hidAppNo.value;
		var varQryString = appURL+"action/devproposal_search.jsp?hidBeanId=perlimitofloan&hidBeanGetMethod=getPermissionPropSearch&strappno="+hidAppNo+"&appnofortest="+appnofortest;   
		var title = "Permission No";
		var prop = "scrollbars=yes,width=650,height=450,menubar=no";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,"PermissionNo",prop);

	}
}
function doRemove()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		document.all.id_permLetter.style.visibility="hidden";
	    document.all.id_permLetter.style.position="absolute";
	    document.all.deattach.style.visibility="hidden";
	    document.all.deattach.style.position="absolute";
    	document.forms[0].dev_prop_no.value="";
	}
}
function showOrganizationSearch(path, forgscode, forgname,forgcode)
{
	
		var varQryString = path+"action/searchOrg.jsp?forgscode="+forgscode+"&forgname="+forgname+"&forgcode="+forgcode;
		var title = "Organization";
		var prop = "scrollbars=yes,width=500,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	
}
</script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
</head>
<body onLoad="placevalues();">
<form name="frmpri" method = "post" class="normal">
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="8" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%}else{
	if(strCategoryType.equalsIgnoreCase("CORP") || strCategoryType.equalsIgnoreCase("SME") || strCategoryType.equalsIgnoreCase("AGR")){%>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td valign="top" >
        <jsp:include page="../com/proposallinks.jsp" flush="true"> 
        <jsp:param name="pageid" value="1" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
  </table>
 <%}else if (strCategoryType.equalsIgnoreCase("SRE") || strCategoryType.equalsIgnoreCase("STL")){ %>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td valign="top" >
        <jsp:include page="../share/applurllinkscom.jsp" flush="true">         
        <jsp:param name="pageid" value="4" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
    </table>
    <%} %>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <%if(strSessionModuleType.equalsIgnoreCase("AGR")){%>
    <tr>
	<td class="page_flow">Home -&gt;Agriculture -&gt; Proposal  -&gt; Basic Information </td>
    </tr>
   <%}else if(strCategoryType.equalsIgnoreCase("SRE")){%>
    <tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Short Review/Extension  -&gt; Basic Information </td>
	</tr>
    <%}else{%>
     <tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Short Term Loan  -&gt; Basic Information </td>
	</tr>
    <%}%>
  </table>
  <span style="display:none;"><lapschoice:borrowertype /></span> <lapschoice:application/>
  <%} %>
    <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
    <tr> 
      <td valign="top">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="6" class="outertable">
            	<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable border1">

		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
			<%					if (strHOcheck.equalsIgnoreCase("H")) {
				%>
				<td>Proposal received at HO/RO/CLPH with branch recommendations</td>
				<td><input type="text" name="txt_branchrecmmd_date"
					value="<%=Helper.correctNull((String) hshValues
							.get("com_branchrcvddate"))%>"
					maxlength="10" size="12"
					alt="Select date from calender" href="#"
					onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>');checkmindate(this,'<%=Helper.correctNull((String)hshValues.get("inward_appliedon"))%>');"><a
					onClick="callCalender('txt_branchrecmmd_date')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a></td>
				<td>Proposal received at HO/RO with complete information</td>
				<td><input type="text" name="txt_information_date"
					value="<%=Helper.correctNull((String) hshValues
							.get("com_branchcompletedate"))%>"
					maxlength="10" size="12"
					alt="Select date from calender" href="#"
					onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>');checkmindate(this,'<%=Helper.correctNull((String)hshValues.get("inward_appliedon"))%>');"><a
					onClick="callCalender('txt_information_date')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a></td>
			</tr>
				<%	}%>
			<tr>
				<td>For the meeting</td>
				<td><input type="text" TABINDEX="3"	name="meeting" size="37" maxlength="50"	value="<%=Helper.correctNull((String) hshValues
							.get("com_meeting"))%>">
				</td>
				<td>Meeting Date</td>
				<td><input type="text" name="txt_meeting_date"
					value="<%=Helper.correctNull((String) hshValues
							.get("com_meetingdate"))%>"
					maxlength="10" size="12"
					alt="Select date from calender" href="#"
					onBlur="checkDate(this);">&nbsp;<a style="vertical-align: middle"
					onClick="callCalender('txt_meeting_date')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a></td>
			</tr>
			<tr>
				<td>Proposal Submitted To</td>
				<td><select name="sel_proposalsubmit" disabled="disabled">
					<option value="s">--Select--</option>
					<lapschoice:StaticDataNewTag apptype="21"/>
					</select></td>
				<td>Proposal Format<span class="mantatory"><b>*</b></span></td>
				<td width="31%">
				<select name="sel_proposalformat" style="width:150px;" tabindex="5">
					<option value="s" selected>----select----</option>
						<option value="1">EC - Board Format</option>
						<option value="3">100% Cash Margin</option>
						<option value="4">Other than EC - Board</option>
						<option value="5">Short Notes</option>
						<!-- <option value="6">MD Sanction</option> -->
				</select>
				
				<select name="sel_amount" tabindex="5">
					<option value="s" selected>----select----</option>
						<option value="R">Rupees</option>
						<option value="L">Lakhs</option>
						<option value="C">Crores</option>
				</select>
				
				</td>
				
			</tr>
			<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
			<tr>
			<td>Proposal Sanction Type&nbsp;<span class="mantatory"><b>*</b></span></td>
			<td><select name="sel_sanctiontype">
			<option value="0"><--Select--></option>
			<option value="P">Permission</option>
			<option value="S">Sanction</option>
			</select> </td>
			</tr>
			<%}else{ %>
			<tr><td><input type="hidden" name="sel_sanctiontype" value="">
			<%} %>
			<tr>
			<td>Branch Party File No.</td>
			<td><input type="text" name="txt_partyno"
					value="<%=Helper.correctNull((String) hshValues
							.get("com_partyfileno"))%>" maxlength="15" size="37" onKeyPress="notAllowSplChar(this)"> </td>
			<td>RO / HO Party File No.</td>
			<td><input type="text" name="txt_hopartyno"
					value="<%=Helper.correctNull((String) hshValues
							.get("com_roho"))%>" maxlength="15" size="37" onKeyPress="notAllowSplChar(this)"> </td>
			</tr>
			<tr>		
			<td>Sanctioning Department<span class="mantatory"><b>*</b></span></td>
			<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
			<td>
			<select name="sel_SancDept"  onchange="funsanctiondept('s','Y');">
			<option value="s">--Select--</option>
			<lapschoice:CBSStaticDataNewTag apptype="26" />
			</select>
			</td>
			<td id="idsanbranch">
			<select name="sel_SancBranch" >
			<option value="">--Select--</option>
			</select>
			</td>
			</tr>
			</table>
			</td>	
			<td id="id_CSLMSNO" width="20%">CS - LMC NO<span class="mantatory"><b>*</b></span></td>
			<td id="id_CSLMSNO1" width="10%"><input type="text" name="txt_CSLMSNO" value="<%=Helper.correctNull((String) hshValues
							.get("COM_CSLMSNO"))%>"></td>
			</tr>
			<tr>
			<td>Sanction intimation Mode<span class="mantatory"><b>*</b></span></td>
			<td><select name="sel_SancLevel" style="width:200px;">
			<option value="s">--Select--</option>
				<lapschoice:CBSStaticDataNewTag apptype="14" />		
			</select></td>				
			</tr>
			<tr>
				<td>Advances as on</td>
				<td><input type="text" name="txt_advances_date"
					value="<%=Helper.correctNull((String) hshValues
							.get("com_advanceason"))%>"
					maxlength="10" size="15"
					alt="Select date from calender" href="#"
					onBlur="checkDate(this);">&nbsp;<a style="vertical-align: middle; "
					onClick="callCalender('txt_advances_date')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a>&nbsp;&nbsp;
					<laps:CurrencyTag name="txt_advamount"
					value='<%=Helper.correctNull((String) hshValues
							.get("com_advanceamt"))%>' size="12" maxlength="12" onBlur="roundtxt(this)" /></td>
					<td>Deposits as on</td>
				<td><input type="text" name="txt_deposits_date"
					value="<%=Helper.correctNull((String) hshValues
							.get("com_depositason"))%>"
					maxlength="10" size="15"
					alt="Select date from calender" href="#"
					onBlur="checkDate(this);">&nbsp;<a style="vertical-align: middle"
					onClick="callCalender('txt_deposits_date')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a>
			<laps:CurrencyTag  name="txt_depositamount"
					value='<%=Helper.correctNull((String) hshValues
							.get("com_depositamt"))%>' size="12" maxlength="12" onBlur="roundtxt(this)" /></td>
			</tr>
			<tr>
				<td>NPA at the <%=strBrchInwname%> 	
				as on</td> 
				<td><input type="text" name="txt_npadate"
					value="<%=Helper.correctNull((String) hshValues
							.get("com_npaason"))%>"
					maxlength="10" size="15"
					alt="Select date from calender" href="#"
					onBlur="checkDate(this);">&nbsp;<a style="vertical-align: middle"
					onClick="callCalender('txt_npadate')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a>&nbsp;&nbsp;
		<laps:CurrencyTag  name="txt_npaamount"
					value='<%=Helper.correctNull((String) hshValues
							.get("com_npaamt"))%>' size="12" maxlength="12" onBlur="roundtxt(this)" /></td>
					<td >Sector - Priority/Non-Priority <span class="mantatory"><b>*</b></span></td>
					<td><input type="text" name="txt_sector" size="37" maxlength="50"	value="<%=Helper.correctNull((String) hshValues.get("com_sector"))%>">
				</td>
			</tr>
			<tr>
				<td>Inspection Rating as on	</td>
				<td><input type="text" name="txt_inspectiondate"
					value="<%=Helper.correctNull((String) hshValues
							.get("com_inspectiondate"))%>"
					maxlength="10" size="15"
					alt="Select date from calender" href="#"
					onBlur="checkDate(this);">&nbsp;<a style="vertical-align: middle"
					onClick="callCalender('txt_inspectiondate')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a>&nbsp;&nbsp;
					<input type="text" name="txt_inspectionamount" value='<%=Helper.correctNull((String) hshValues.get("com_inspectionamount"))%>' size="12" maxlength="50"   onkeypress="allowAlphaNumeric()">
							</td>

			<td>Sanctioning Authority<span class="mantatory"><b>*</b></span></td>
			<td>
			<select name="sel_SancAuth" onChange="funsancrefno();funchange()"  style="width:200px;" >
			<option value="s">--Select--</option>
			<!--<lapschoice:CBSStaticDataNewTag apptype="15" />
			--></select>
			</td>
			</tr>
			<tr>
				<td>Date of the process note</td>
					<td><input type="text" name="txt_processnotedate"
					value="<%=Helper.correctNull((String) hshValues.get("com_processnotedate"))%>"
					maxlength="10" size="15"
					alt="Select date from calender" href="#"
					onBlur="checkDate(this);">&nbsp;<a style="vertical-align: middle"
					onClick="callCalender('txt_processnotedate')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a>&nbsp;&nbsp;
					</td>	
					<td id="sanrefno">Sanction Reference No.<b><span class="mantatory">*</span></b></td>
				<td id="sanrefval"><input type="text" TABINDEX="3"	name="txt_sancrefno" size="37" maxlength="50"	value="<%=Helper.correctNull((String) hshValues.get("com_sancrefno"))%>"></td>			
			</tr>
			<tr>
				<td>&nbsp;&nbsp;</td><td>&nbsp;&nbsp;</td>
				<td id="sancdate1">Sanction date <b><span class="mantatory">*</span></b></td>	
				<td id="sancdate2">
					<input type="text" name="sanctiondate" maxlength="10" 
					onBlur="checkDate(this);checkmaxdate(this,currentDate);" size="12"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("COM_SANREF_SANCDATE"))%>">
				  	&nbsp;<a alt="Select date from calender" href="#"
					onClick="callCalender('sanctiondate')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender" align="middle"></a></td>
			</tr>
			<tr>
				<td>
					Permitted Exposure for Individual
				</td>
				<td>
					<laps:CurrencyTag name="txt_individual" value='<%=Helper.correctNull((String) hshValues.get("com_individual"))%>' size="12" maxlength="12" onBlur="roundtxt(this)" />
				</td>
				<td valign="top">
					Basis for Selection of above Sanctioning Authority
				</td>
				<td valign="top">
					<textarea rows="3" cols="50" name="ta_comments" onKeyPress="textlimit(this,3999)" wrap="VIRTUAL" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String) hshValues.get("com_comments"))%></textarea>
				</td>
			</tr>
			<tr>
				<td>
					Permitted Exposure for Group
				</td>
				<td>
				<laps:CurrencyTag name="txt_group" value='<%=Helper.correctNull((String) hshValues.get("com_group"))%>' size="12" maxlength="12" onBlur="roundtxt(this)" />
				</td>
				<td id="idprocfee">Processing Charges &nbsp;<span class="mantatory"><b>*</b></span></td>
				<td id="idprocfee1"><laps:CurrencyTag name="txt_procfee" value='<%=Helper.correctNull((String) hshValues.get("com_processingfee"))%>' size="15" maxlength="12" onBlur="roundtxt(this)" /></td>
			</tr>
			<tr>
				<td  id="idgriddate">
					 Discussed and cleared in the Credit approval GRID dated
				</td>
				<td id="idgriddate1"><input type="text" name="txt_griddate"
					value="<%=Helper.correctNull((String) hshValues.get("com_griddate"))%>"
					maxlength="10" size="15"
					alt="Select date from calender" href="#"
					onBlur="checkDate(this);">&nbsp;<a style="vertical-align: middle"
					onClick="callCalender('txt_griddate')"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a>&nbsp;&nbsp;
					</td>
				<td nowrap="nowrap" id="idintrefno"> Interest Deviation Reference Number</td>
			<td id="idintrefno1"> <input type="text" name="txt_intrefno" size="30" maxlength="20" value="<%=Helper.correctNull((String) hshValues.get("com_interest_refno"))%>">&nbsp;</td>
			</tr>
			
			<tr id="idCFR">
				<td> Whether verified with Central Fraud Registry ? &nbsp;<span class="mantatory"><b>*</b></span></td>
				<td><select name="CFR_verified"  onchange="CheckCFR_verified()">
					<option value="">&lt;----Select----&gt;</option>
					<option value="Y">Yes</option>
					<option value="N" >No</option>
					<option value="NA" >Not Applicable</option>
				</select></td>
				<td id="id_CFR1"> Whether Applicant/Co-applicant/Guarantor/Proprietor/Partner <br> name appears in CFR ? &nbsp;<span class="mantatory"><b>*</b></span> </td>
				<td id="id_CFR2"><select name="Namein_CFR"  onchange="CheckCFR_name()">
					<option value="">&lt;----Select----&gt;</option>
					<option value="Y">Yes</option>
					<option value="N">No</option>
					</select>
				</td>			
			</tr>
			<tr id="">
				<td> Whether CERSAI data base checked ? &nbsp;<span class="mantatory"><b>*</b></span></td>
				<td><select name="CERSAI_verified"  onchange="">
					<option value="">&lt;----Select----&gt;</option>
					<option value="Y">Yes</option>
					<option value="N" >No</option>
					<option value="NA" >Not Applicable</option>
				</select></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
							
			</tr>
			<tr id="id_CFR3">
				<td>CFR Deviation Reference number &nbsp;<span class="mantatory"><b>*</b></span> </td>
				<td><input type="text" name="txt_CFRdev_refno" value="<%=Helper.correctNull((String) hshValues.get("COM_CFR_DEV_RENFO"))%>" maxlength="20">  </td>
				<td> Deviation approval Status &nbsp;<span class="mantatory"><b>*</b></span></td>
				<td><select name="status_verified" onchange="status_ver()">
					<option value="S" >&lt;----Select----&gt;</option>
					<option value="A">Approved</option>
					<option value="R">Rejected</option>
				</select></td>
				
		</tr>
		<tr id="app1">
			<td id="id_status">&nbsp;</td>
			<td width="35%">
				<table border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td><input type="text" name="txt_userid2" value="<%=Helper.correctNull((String) hshValues.get("appuserid"))%>">
						<input type="hidden" name="hid_userid2" value="<%=Helper.correctNull((String) hshValues.get("loan_appr_userid1"))%>">
						<b><span onClick="callUsersHelp1()" style="cursor: hand"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="81"></span></b></td>
					</tr>
				</table>
			</td>
			<td id="id_statusdate">&nbsp;</td>
			<td><input type="text" name="appref_Appr_date" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("loan_Appr_date"))%>"
							onBlur="checkDate(this);checkmaxdate(this,currentdate);" maxlength="10" tabindex="15">
		    				<a alt="Select date from calender" href="#"
							onClick="callCalender('appref_Appr_date')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> 
			</td>
		</tr>
		<tr id="idperm"> 
      			<td width="20%">Permission Proposal No</td>
      			<td width="10%" colspan="3"><input type="text" name="dev_prop_no" size="12" readOnly="readonly" value="<%=Helper.correctNull((String)hshValues.get("APP_PERM_NO"))%>"> 
      				<b><a> <span onClick="doSearch()" style="cursor: hand"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0" tabindex=""></span></a></b>
				&nbsp;&nbsp;&nbsp;&nbsp; <a id="id_permLetter"  href="#" onClick="JavaScript:doPermissionLetter()"><span style="cursor: hand"> Permission Letter</span></a>
				&nbsp;&nbsp; <img id="deattach" alt="De-attach" src="<%=ApplicationParams.getAppUrl()%>img/delete.png" onclick="doRemove()" style="cursor:hand"/>&nbsp;
				 </td>
          </tr>
		<%if (orglevel.equals("C")||orglevel.equals("D")){ %>
		<tr>
				<td>Proposal pertains to the branch</td>
				<td><input type="hidden" name="hid_perbranch" value="<%=Helper.correctNull((String) hshValues.get("strBranchCode"))%>">
					<input type="hidden" name="hid_perbranchcode" value="<%=Helper.correctNull((String) hshValues.get("strBranchOrgCode"))%>">
					<input type="text" name="txt_perbranch" value="<%=Helper.correctNull((String) hshValues.get("strBranchName"))%>"> 
					<b><a href="#" onClick="showOrganizationSearch('<%=ApplicationParams.getAppUrl()%>','hid_perbranch','txt_perbranch','hid_perbranchcode')"
					style="cursor: hand">
					<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" ></a></b></td>
	</tr>
	<%} %>
        </table>
      </td>
   
  </table>
  </td>
  </tr>
  </table>

<iframe height="0" width="0" name="ifrmsancauthority" frameborder="0" style="border:0"></iframe>
<iframe height="0" width="0" name="ifrmsancbranch" frameborder="0" style="border:0"></iframe>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Comments_Audit Trail'  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="cattype" value="<%=strCategoryType%>">
<input type="hidden" name="hidCommentPage" value="breifbackground"> 
<input type="hidden" name="hidDeptChange" value=""> 
<input type="hidden" name="hidSancAuthChange" value="">
<input type="hidden" name="hidSancAuth" value="">  
<input type="hidden" name="hidAppNo" value="<%=Helper.correctNull((String)request.getParameter("appno"))%>"> 
<input type="hidden" name="hidratingTabHideAppl" value="<%=Helper.correctNull((String)session.getAttribute("strRatingTabHide")).trim()%>">
<input type="hidden" name="hidncgtcflag" value="<%=Helper.correctNull((String)session.getAttribute("strncgtcflag")) %>">
<input type="hidden" name="hidbankscheme" value="<%=Helper.correctNull((String)session.getAttribute("strncgtcbankscheme")) %>">
</form>
</body>
</html>