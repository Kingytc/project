<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%String strCgAppNo=Helper.correctNull((String)hshValues.get("isThere"));//yes or n
String strCreatedBy=Helper.correctNull((String)hshValues.get("CreateBy"));
String strCreatedOn=Helper.correctNull((String)hshValues.get("CreateDate"));
String strInstalment = Helper.correctNull((String)hshValues.get("Instalment"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();


java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>NCGTC Coverage</title>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
</head>
<style>
.datagrids
{
	background-color:#d7b3e5;
	color:#942188;
	font-weight:normal;
	border-bottom:0px #942188 solid;
	font-size:11px;text-decoration:none;
}

.myselect {
  width: 200px;
  overflow: hidden;
  text-overflow: ellipsis;
}

.myselect option {
  white-space: nowrap;
  width: 100% border-bottom: 1px #ccc solid;
  /* This doesn't work. */
}
</style>

<script>	
var currentDate="<%=Helper.getCurrentDateTime()%>";
var varAppExist="<%=strCgAppNo%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var varCGTMSEFlag="<%=Helper.correctNull((String) hshValues.get("strCGTMSEFlag"))%>";
var varPreviousCover="<%=Helper.correctNull((String) hshValues.get("strPreviousCGTMSECover"))%>";
var varModule="<%=Helper.correctNull((String)session.getAttribute("sessionModuleType"))%>";
var finaced_id="<%=Helper.correctNull((String) hshValues.get("finaced_id"))%>";
var varstrSessionModuleType="<%=strSessionModuleType%>";
var strncgtcflag="<%=Helper.correctNull((String) hshValues.get("strncgtcflag"))%>";
</script>
<script type="text/javascript">
function selection()
{
	var Npa="<%=Helper.correctNull((String) hshValues.get("Npa"))%>";
	var MicEntp="<%=Helper.correctNull((String) hshValues.get("MicEntp"))%>";
	var Newunit="<%=Helper.correctNull((String) hshValues.get("Newunit"))%>";
	var NewunitWO="<%=Helper.correctNull((String) hshValues.get("NewunitWO"))%>";
	var MSEunit="<%=Helper.correctNull((String) hshValues.get("MSEunit"))%>";
	var MSEunitWO="<%=Helper.correctNull((String) hshValues.get("MSEunitWO"))%>";
	var ArtisanCC="<%=Helper.correctNull((String) hshValues.get("ArtisanCC"))%>";
	var GF_ASF="<%=Helper.correctNull((String) hshValues.get("GF_ASF"))%>";
	var TL_MarginMoney="<%=Helper.correctNull((String) hshValues.get("TL_MarginMoney"))%>";

	var AsistBank="<%=Helper.correctNull((String) hshValues.get("AsistBank"))%>";
	var MinCommuity="<%=Helper.correctNull((String) hshValues.get("MinCommuity"))%>";
	var SocialCatgry="<%=Helper.correctNull((String) hshValues.get("SocialCatgry"))%>";
	var legalId="<%=Helper.correctNull((String) hshValues.get("legalId"))%>";

	var ColSec="<%=Helper.correctNull((String) hshValues.get("ColSec"))%>";
	var ThirdParty="<%=Helper.correctNull((String) hshValues.get("ThirdParty"))%>";

	var JointFinance="<%=Helper.correctNull((String) hshValues.get("JointFinance"))%>";
	

	var HandloomScheme="<%=Helper.correctNull((String) hshValues.get("HandloomScheme"))%>";

	var Namescheme="<%=Helper.correctNull((String) hshValues.get("Namescheme"))%>";
	var checkBx="<%=Helper.correctNull((String) hshValues.get("checkBx"))%>";

	var NatuIndustry="<%=Helper.correctNull((String)hshValues.get("NatureIndustry"))%>";

	var IndustrySec="<%=Helper.correctNull((String)hshValues.get("IndustrySector"))%>";
	var Sno="<%=Helper.correctNull((String) hshValues.get("strFacilitySno"))%>";
	var PrevCGTMSE="<%=Helper.correctNull((String) hshValues.get("PrevCGTMSE"))%>";
	var varAppDetNPA="<%=Helper.correctNull((String) hshValues.get("CG_APPDET_NPA"))%>";	
	var varFirstCharge="<%=Helper.correctNull((String) hshValues.get("CG_FIRSTCHARGE"))%>";	
	var varCG_INTERNAL_RATING="<%=Helper.correctNull((String) hshValues.get("CG_INTERNAL_RATING"))%>";
	var varCG_DEFAULTER="<%=Helper.correctNull((String) hshValues.get("CG_DEFAULTER"))%>";
	var sel_Existing="<%=Helper.correctNull((String) hshValues.get("CG_Existing"))%>";
	var Namescheme="<%=Helper.correctNull((String) hshValues.get("Namescheme"))%>";
	
	if(Namescheme!="")
	{
		document.forms[0].Namescheme.value=Namescheme;
	}
	if(legalId!="")
	{
		document.forms[0].legalId.value=legalId;
	}
	if(IndustrySec!="")
	{
		document.forms[0].IndustrySector.value=IndustrySec;
	}
	
	if(NatuIndustry!="")
		{
			document.forms[0].NatureIndustry.value=NatuIndustry;
		}

	if(SocialCatgry!="")
	{
		document.forms[0].SocialCatgry.value=SocialCatgry;
	}

	if(AsistBank=="Y")
	{
		document.forms[0].AsistBank[1].selected=true;
	}
	else if(AsistBank=="N")
	{
		document.forms[0].AsistBank[2].selected=true;
	}
	if(ColSec=="N")
	{
		document.forms[0].ColSec[0].selected=true;
	}
	if(ThirdParty=="N")
	{
		document.forms[0].ThirdParty[0].selected=true;
	}
	if(JointFinance=="Y")
	{
		document.forms[0].JointFinance[1].selected=true;
	}
	else if(JointFinance=="N")
	{
		document.forms[0].JointFinance[2].selected=true;
	}
	
	if(HandloomScheme=="Y")
	{
		document.forms[0].HandloomScheme[1].selected=true;
	}
	else if(HandloomScheme=="N")
	{
		document.forms[0].HandloomScheme[2].selected=true;
	}

	
	/*if(Namescheme=="IHDS")
	{
		document.forms[0].Namescheme[1].selected=true;
	}
	else if(Namescheme=="MCS")
	{
		document.forms[0].Namescheme[2].selected=true;
	}*/
	if(checkBx=="Y")
	{
		document.forms[0].checkBx.checked=true;
	}
	
	if(MicEntp=="Y")
	{
		document.forms[0].MicEntp[1].selected=true;
	}
	else if(MicEntp=="N")
	{
		document.forms[0].MicEntp[2].selected=true;
	}


	if(Newunit=="Y")
	{
		document.forms[0].Newunit[1].selected=true;
	}
	else if(Newunit=="N")
	{
		document.forms[0].Newunit[2].selected=true;
	}

	if(NewunitWO=="Y")
	{
		document.forms[0].NewunitWO[1].selected=true;
	}
	else if(NewunitWO=="N")
	{
		document.forms[0].NewunitWO[2].selected=true;
	}

	if(MSEunit=="Y")
	{
		document.forms[0].MSEunit[1].selected=true;
	}
	else if(MSEunit=="N")
	{
		document.forms[0].MSEunit[2].selected=true;
	}

	if(MSEunitWO=="Y")
	{
		document.forms[0].MSEunitWO[1].selected=true;
	}
	else if(MSEunitWO=="N")
	{
		document.forms[0].MSEunitWO[2].selected=true;
	}

	if(ArtisanCC=="Y")
	{
		document.forms[0].ArtisanCC[1].selected=true;
	}
	else if(ArtisanCC=="N")
	{
		document.forms[0].ArtisanCC[2].selected=true;
	}

	if(GF_ASF=="Y")
	{
		document.forms[0].GF_ASF[1].selected=true;
	}
	else if(GF_ASF=="N")
	{
		document.forms[0].GF_ASF[2].selected=true;
	}

	if(TL_MarginMoney=="Y")
	{
		document.forms[0].TL_MarginMoney[1].selected=true;
	}
	else if(TL_MarginMoney=="N")
	{
		document.forms[0].TL_MarginMoney[2].selected=true;
	}
	if(Sno=="1")
	{
		document.forms[0].sel_facilitysno[1].selected=true;
	}
	else if(Sno=="2")
	{
		document.forms[0].sel_facilitysno[2].selected=true;
	}
	if(PrevCGTMSE=="Y")
	{
		document.forms[0].PrevCGTMSE[1].selected=true;
	}
	else if(PrevCGTMSE=="N")
	{
		document.forms[0].PrevCGTMSE[2].selected=true;
	}
	if(varAppDetNPA=="Y")
	{
		document.forms[0].sel_npa[1].selected=true;
	}
	else if(varAppDetNPA=="N")
	{
		document.forms[0].sel_npa[2].selected=true;
	}
	if(varFirstCharge!="")
	{
		document.forms[0].selfirstcharge.value=varFirstCharge;
	}
	if(varCG_INTERNAL_RATING!="")
	{
		document.forms[0].sel_internalRating.value=varCG_INTERNAL_RATING;
	}
	if(varCG_DEFAULTER!="")
	{
		document.forms[0].sel_cgtmse_defaulter.value=varCG_DEFAULTER;
	}
	if(sel_Existing!="")
	{
		document.forms[0].sel_Existing.value=sel_Existing;
	}

	getindustryValues(IndustrySec);
}

function callCalender1(name)
{	
	showCal(appURL,name);
}

function doEdit() 
{
	if(document.forms[0].sel_facility.value=="" || document.forms[0].sel_facility.value=="0")
	{
		alert("Select Facility");
		document.forms[0].sel_facility.focus();		
		return;
	}
	callDisable(false);
	document.forms[0].txt_udyogaadhaar.readOnly=true;
	disableControls(true,false,false,false,true,true);
}

function doCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].action=appURL+"action/corpNcgtcCoverage.jsp";
		document.forms[0].hidBeanId.value = "supuser";
		document.forms[0].hidBeanGetMethod.value = "getCorpNcgtc";
		document.forms[0].submit();
	}
}

function checklength(){
    var textbox = document.getElementById("txtpincode");
    if(document.forms[0].txt_projectunitpincode.value!="" && textbox.value.length <6){
        alert("Pin code should be six digit");
        return;
    }
}

function callonLoad()
{		
	if(strncgtcflag!="")
	{
		window.opener.document.forms[0].hidncgtcflag.value=strncgtcflag;
	}
	if(document.forms[0].sel_projecttype.value=="0")
	{
		document.all.t1.style.visibility="hidden";
		document.all.t2.style.visibility="hidden";
		document.all.t1.style.position="absolute";
		document.all.t1.style.position="absolute";
	}
	else if(document.forms[0].sel_projecttype.value=="1")
	{
		document.all.t1.style.visibility="Visible";
		document.all.t1.style.position="relative";
		document.all.t2.style.visibility="hidden";
		document.all.t2.style.position="absolute";
	}
	else
	{
		document.all.t1.style.visibility="hidden";
		document.all.t1.style.position="absolute";
		document.all.t2.style.visibility="Visible";
		document.all.t2.style.position="relative";
	}
	callDisable(true);
	document.forms[0].sel_facility.disabled=false;
	document.forms[0].sel_projecttype.value="<%=Helper.correctNull((String)hshValues.get("CORP_TYPEOFPROJECT"))%>";
	
	if(document.forms[0].sel_projecttype.value=="")
	{
		document.forms[0].sel_projecttype.value="0";
	}
	getEnableproject();
	document.forms[0].sel_metro.value="<%=Helper.correctNull((String)hshValues.get("CORP_METROPROJECT"))%>";
	if(document.forms[0].sel_metro.value=="")
	{
		document.forms[0].sel_metro.value="0";
	}
	document.forms[0].sel_metroeligibility.value="<%=Helper.correctNull((String)hshValues.get("CORP_METROPROJELIGIBLE"))%>";
	if(document.forms[0].sel_metroeligibility.value=="")
	{
		document.forms[0].sel_metroeligibility.value="0";
	}
	document.forms[0].sel_industrysector.value="<%=Helper.correctNull((String)hshValues.get("CORP_INDUSTRYSECTOR"))%>";
	if(document.forms[0].sel_industrysector.value=="")
	{
		document.forms[0].sel_industrysector.value="0";
	}
	document.forms[0].sel_industryeligibility.value="<%=Helper.correctNull((String)hshValues.get("CORP_INDUSTRYSECTORELIGI"))%>";
	if(document.forms[0].sel_industryeligibility.value=="")
	{
		document.forms[0].sel_industryeligibility.value="0";
	}
	document.forms[0].sel_natureofproject.value="<%=Helper.correctNull((String)hshValues.get("CORP_PROJECTNATURE"))%>";
	if(document.forms[0].sel_natureofproject.value=="")
	{
		document.forms[0].sel_natureofproject.value="0";
	}
}

function disableControls(cmdEdit,cmdApply,cmdDelete,cmdCancel,cmdClose)
{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdApply;
	document.forms[0].cmddelete.disabled=cmdDelete;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
}

function callDisable(one)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].readOnly=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
		  document.forms[0].elements[i].readOnly=one;
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=one;
		}
	}
	
}

	function callCalender(val)
	{
		if(document.forms[0].cmdsave.disabled==false)
		{
			 showCal(appUrl,val);
		}
	}

function doClose()
{
	if(varModule=="RET")
	{	
		var con=ConfirmMsg('100');
		var page=window.opener.document.forms[0].page1.value;
		if(con)
		{
			if(page.toUpperCase()!="NR")
			{
				window.opener.document.forms[0].radLoan.value="Y";
				window.opener.document.forms[0].hidBeanGetMethod.value="getLoanProducts";
				window.opener.document.forms[0].hidBeanId.value="perapplicant";
				if(window.opener.document.forms[0].hidCategoryType.value=="LAD")
				{
					window.opener.document.forms[0].action=appURL+"action/ladloandetails.jsp";	
				}
				else
				{
					window.opener.document.forms[0].action=appURL+"action/perloandetails.jsp";	
				}
				window.opener.document.forms[0].submit();
			}
			window.close();
		}
	}
	else
	{
		var con=ConfirmMsg('100');
		if(con)
		{
			var subno=0;
	
			var factype = window.opener.document.forms[0].factype.value;
			var hidAction = window.opener.document.forms[0].hidAction.value;
			{
				window.opener.document.forms[0].hideditflag.value="no";
				if(!isNaN(window.opener.document.forms[0].selsubsno.value))
				{
					 subno = parseInt(window.opener.document.forms[0].selsubsno.value);
				}
				if(!subno)
				{
					subno=0;
				}
				if((subno==0) && (factype="sublimit") && (hidAction =="update"))
				{
					window.opener.document.forms[0].factype.value = "facility";
				}
				window.opener.document.forms[0].hidBeanId.value="facilities";
				window.opener.document.forms[0].hidBeanGetMethod.value="getFacilityData";
				window.opener.document.forms[0].action=appUrl+"action/facilities.jsp";	
				window.opener.document.forms[0].method="post";
				window.opener.document.forms[0].submit();
			}
			window.close();
		}
	}
}
function doSave()
{
	var textbox = document.getElementById("txtpincode");
	var facilityNature="<%=Helper.correctNull((String) hshValues.get("FacilityNature"))%>";
	document.forms[0].hidAction.value="insert";
	if(document.forms[0].sel_facility.value=="0")
	{
		alert("Select Facility");
		document.forms[0].sel_facility.focus();
		return;
	}
	else if(document.forms[0].sel_projecttype.value=="0")
	{
		alert("Select Project Type");
		document.forms[0].sel_projecttype.focus();
		return;
	}
	else if(document.forms[0].sel_projecttype.value=="1" && document.forms[0].txt_greenfield.value=="")
	{
		alert("Please Enter New employment likely to be generated in case of greenfield projects");
		document.forms[0].txt_greenfield.focus();
		return;
	}
	else if(document.forms[0].sel_projecttype.value=="2" && document.forms[0].txt_brownfield.value=="")
	{
		alert("Please Enter Additional employment likely to be generated in case of brownfield");
		document.forms[0].txt_brownfield.focus();
		return;
	}
	else if(document.forms[0].sel_metro.value=="0")
	{
		alert("Select project is in any of the metropolitan cities");
		document.forms[0].sel_metro.focus();
		return;
	}
	else if(document.forms[0].sel_industrysector.value=="0")
	{
		alert("Select Industry Sector");
		document.forms[0].sel_industrysector.focus();
		return;
	}
	/*else if(document.forms[0].txt_udyogaadhaar.value=="")
	{
		alert("Enter Aadhaar");
		document.forms[0].txt_udyogaadhaar.focus();
		return;
	}*/
	else if(document.forms[0].txt_projectunitpincode.value=="")
	{
		alert("Enter Project unit pin code");
		document.forms[0].txt_projectunitpincode.focus();
		return;
	}
	else if(document.forms[0].txt_projectunitpincode.value!="" && textbox.value.length <6){
        alert("Pin code should be six digit");
        return;
    }
	else if(document.forms[0].sel_natureofproject.value=="0")
	{
		alert("Select the Nature of Project");
		document.forms[0].sel_natureofproject.focus();
		return;
	}
	else
	{
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].sel_industryeligibility.disabled=false;
		document.forms[0].sel_metroeligibility.disabled=false;
		document.forms[0].hidAction.value = "insert";
		document.forms[0].hidBeanId.value = "supuser";
		document.forms[0].hidSourceUrl.value = "/action/corpNcgtcCoverage.jsp";
		document.forms[0].hidBeanMethod.value = "updateCorpNcgtc";	
		document.forms[0].hidBeanGetMethod.value = "getCorpNcgtc";
		document.forms[0].action = appURL + "controllerservlet";
		document.forms[0].submit();
	}
}

function selScheme()
{
	if(document.forms[0].HandloomScheme.value=="Y")
	{
		document.all.selSch.style.display="table-row";
		document.all.selChK.style.display="table-row";
	}
	else
	{
		document.all.selSch.style.display="none";
		document.all.selChK.style.display="none";
		
	}
}

function leglOthr()
{
	if(document.forms[0].legalId.value=="")
	{
		document.forms[0].LegalIdNo.value="";
	}
	if(document.forms[0].legalId.value=="99")
	{
		document.forms[0].LegalIdNo.value="";
		document.all.othrID.style.visibility="visible";
		document.all.othrID.style.position="relative";
		document.all.idDiv.style.visibility="hidden";
		document.all.idDiv.style.position="absolute";
	}
	else
	{
		document.all.othrID.style.visibility="hidden";
		document.all.othrID.style.position="absolute";
		document.all.idDiv.style.visibility="visible";
		document.all.idDiv.style.position="relative";
	}
}

function callIFrame()
{	
	var appno = document.forms[0].appno.value;
	var facilityNcgtc=document.forms[0].sel_facility.value;
	document.forms[0].txt_udyogaadhaar.value="<%=Helper.correctNull((String)hshValues.get("UdyogAadharNo"))%>";
	document.all.ifrm.src=appURL+"action/iframeCorpNcgtc.jsp?hidBeanGetMethod=getCorpNcgtc&hidBeanId=supuser&strappno="+appno+"&facilityNcgtc="+facilityNcgtc;
}

function PreCGpan()
{ 
	if(document.forms[0].PrevCGTMSE.value=="Y")
	{ 
		document.all.prvcgpan.style.display="table-row";
		document.all.idAvailAmt.style.display="table-row";
		document.all.prvcgtmse1.style.display="table-row";
		document.all.prvcgtmse2.style.display="table-row";
	}
	else
	{
		document.all.prvcgpan.style.display="none";
		document.all.idAvailAmt.style.display="none";
		document.all.prvcgtmse1.style.display="none";
		document.all.prvcgtmse2.style.display="none";
	}
}

function doGenerateReport()
{ 	
	var facilityCgtmse="<%=Helper.correctNull((String) hshValues.get("FacilityCgtmse"))%>";

	if(document.forms[0].sel_facilitysno.value=="" || document.forms[0].sel_facilitysno.value=="0")
	{
		alert("Select Facility");
		return;
	}
	var varAadharNo="<%=Helper.correctNull((String)hshValues.get("UdyogAadharNo"))%>";
	if(document.forms[0].sel_facilitysno.value=="" || document.forms[0].sel_facilitysno.value=="0")
	{
		return;
	}
	if(varAadharNo=="")
	{
		alert("Please fill Udyog Aadhaar Number in Customer Profile");	
		return false;
	}
	if(varAppExist=="NO" && (document.forms[0].sel_facilitysno.value!="" || document.forms[0].sel_facilitysno.value!="0"))
	{
		alert("Please fill CGTMSE Coverage page and then Proceed !");	
		return false;
	}
	if(facilityCgtmse=="Y")
	{
		var appno = document.forms[0].appno.value;
		var comappid = document.forms[0].hidapplicantnewid.value;
		var facilityload=document.forms[0].sel_facilitysno.value;
		var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
		var title = "PrintFairReport";
		var xpos = 5;
		var ypos = 5;
		prop = prop + ",left="+xpos+",top="+ypos;
		if(varModule=="RET")
			var url=appUrl+"action/cgtmse_annexure.jsp?hidBeanId=supuser&hidBeanGetMethod=getRetailAnnexure&appno="+appno+"&comappid="+comappid;
		else
			var url=appUrl+"action/CorpCgtmse_annexure.jsp?hidBeanId=supuser&hidBeanGetMethod=getCropCgtmseAnnexure&appno="+appno+"&comappid="+comappid+"&facilityload="+facilityload;	
		window.open(url,title,prop);
	
	}
	else if(facilityCgtmse=="N")
	{
		alert("This Facility is not in CGTMSE!");
	}
	else
	{
		alert("Select Facility!");
	}
}

function doFinancialData()
{
	var appno = document.forms[0].appno.value;
	var comappid = document.forms[0].hidapplicantnewid.value;
	var finaced_id= document.forms[0].hidfinanceid.value;
	var url=appUrl+"action/retailfin.jsp?hidBeanId=financial&hidBeanGetMethod=getRetailData&appno="+appno+"&finaced_id="+finaced_id;	  
	var title = "FinancialData";
	var prop = "scrollbars=yes,width=900,height=650,menubar=yes";
	prop = prop + ",left=50,top=150";
	window.open(url,title,prop);
}

function callOutstandAmt()
{
	if(document.forms[0].AsistBank.value=="Y")
	{
		document.all.idOutsamt.style.visibility="visible";
		document.all.idOutsamt.style.position="relative";
		document.all.idAsistNpa.style.visibility="visible";
		document.all.idAsistNpa.style.position="relative";
	}
	else
	{
		document.all.idOutsamt.style.visibility="hidden";
		document.all.idOutsamt.style.position="absolute";
		document.all.idAsistNpa.style.visibility="hidden";
		document.all.idAsistNpa.style.position="absolute";
	}
}

function CgpanEnable()
{
	if(document.forms[0].JointFinance.value=="Y")
	{
		document.all.idCgpan.style.visibility="visible";
		document.all.idCgpan.position="relative";
	}
	else
	{
		document.all.idCgpan.style.visibility="hidden";
	    document.all.idCgpan.position="absolute";
	}
}

function IdCardEnable()
{
	if(document.forms[0].ArtisanCC.value=="Y")
	{
		document.all.idIssued.style.display="table-row";
	}
	else
	{
		document.all.idIssued.style.display="none";
	}
}

function doDelete()
{
	if(ConfirmMsg('101'))
	{
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidBeanId.value = "supuser";
		document.forms[0].hidAction.value = "delete";
		document.forms[0].hidSourceUrl.value = "/action/corpNcgtcCoverage.jsp";
		document.forms[0].hidBeanMethod.value = "updateCorpNcgtc";	
		document.forms[0].hidBeanGetMethod.value = "getCorpNcgtc";
		document.forms[0].action = appURL + "controllerservlet";
		document.forms[0].submit();
	}
}

function getindustryValues(val)
{
	document.all.ifrm.src=appURL+"action/ifrmmasterval.jsp?hidBeanGetMethod=getStatMasterValues&hidBeanId=facilities&strMastID=211&strMastVal="+document.forms[0].NatureIndustry.value+"&strObjectName=IndustrySector+&strVal="+val;
}
function validate(obj,val1)
{
	
	if(obj.value=="Y" && val1=="N")
	{
		alert("Value should not be Yes to cover under CGTMSE");
		obj.value="";
		return;	
	}
	if(obj.value=="N" && val1=="Y")
	{
		alert("Value should not be No to cover under CGTMSE");
		obj.value="";
		return;	
	}
}
function Addvaluer1(){

	if(document.forms[0].cmdsave.disabled==false)
	{	
	var tab  = document.getElementById("idCGPAN");
	var rowsLength = tab.rows.length;
	if(rowsLength<=200)
	{
		var new_Row    = tab.insertRow(rowsLength);
		
		var rwlength=rowsLength;
		new_Row.id=""+rowsLength;
		var previous_RowCells=tab.rows[rowsLength-1].cells; 
		for(i=0;i<previous_RowCells.length;i++)
		{
			var new_RowCell=new_Row.insertCell(i);
			new_RowCell.innerHTML=previous_RowCells[i].innerHTML;
			new_RowCell.align="left";
			var new_CellElement=new_RowCell.childNodes[0];
			if(i==0)
	        {
	        	new_RowCell.align="left";
	        }
			for(var j=0;j<new_RowCell.childNodes.length;j++)
			{
				if(new_RowCell.childNodes[j].type=="text")
				{
					new_RowCell.childNodes[j].value="";
					new_RowCell.childNodes[j].readOnly=false;
				}
			}
			 
		}
	}
	else
	{
		alert("Cannot add more rows");
	}
	//ClearFields();
}
}

function deleteRow1(tabid,tdcount)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var tab = document.getElementById(tabid);
		var rowsLength = tab.rows.length;
		var varCheckedFlag=false;
		if(rowsLength>=1)
		{
			for(var i=0;i<rowsLength;i++)
			{
				var current_row = tab.rows[i];
				var chkbox = current_row.cells[tdcount].childNodes[0];
				if(chkbox != null && chkbox.checked == true)
				{
					if(tabid=="idCGPAN" && rowsLength=="1")
					{
						document.forms[0].PrevCGPan.value="";  
					    chkbox.checked=false; 
					    return;
					}
					else
					{
						tab.deleteRow(i);
						rowsLength--;
						i--;
					}

					if(!varCheckedFlag)
					{
						varCheckedFlag=true;
					}
				}
			}
			if(!varCheckedFlag)
			{
				alert("Please select the check box for deletion");
			}
		}
	}
}


function Totalvalue()
{
	var varCGPan="<%=Helper.correctNull((String) hshValues.get("PrevCGPan"))%>";
	if(varCGPan!="")
	{
		var temp= varCGPan.split("@");
		var valuerlen=temp.length;
			for(var i=0;i<valuerlen;i++)
			{
				 Addvaluer1();
				 if(temp[i]==undefined){temp[i]="";}
				 if(valuerlen==1)
				 {
					 document.forms[0].PrevCGPan[i].value=temp[i];
				 }else
				 {
					 document.forms[0].PrevCGPan[i].value=temp[i];
			    }
			 }
	}
	
	else
	{
		 Addvaluer1();
	}
deleteRow("idCGPAN");
}

function deleteRow(tableid)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var table=document.getElementById(tableid);
		var rowCount=table.rows.length; 
		
		if(rowCount==1){
	       alert("Atleast one data is needed");
	       return;
		}
		else{
			 table.deleteRow(rowCount-1);
		}
	}
}
function checkParamVal()
{
	var varParamVal="<%=Helper.correctNull((String) hshValues.get("strParamVal"))%>";
	var varcgAmt= document.forms[0].txt_cgtmse_coverage.value;
	var ourbankCov= document.forms[0].txt_ourbankcover.value;
	var totalcov=eval(varcgAmt)+eval(ourbankCov);
	var remainingbalance=eval(varParamVal)-eval(totalcov);
	document.forms[0].availamt_gurantee.value=remainingbalance;
	if(eval(totalcov)>eval(varParamVal))
	{
		alert("Exceeded maximum coverage for loans sanctioned under CGTMSE");
		document.forms[0].cmdsave.disabled=true;
		return;
	}
	else
	{
		document.forms[0].cmdsave.disabled=false;
	}
}

function getchangeValues(){
	if((document.forms[0].NatureIndustry.value!="")&&(document.forms[0].IndustrySector.value==""||document.forms[0].IndustrySector.value=="s")){

		alert("please select the industry sector");
		document.forms[0].IndustrySector.focus();
		return;
		
	}
}

function getEnableproject()
{
	if(document.forms[0].sel_projecttype.value!="0")
	{
		if(document.forms[0].sel_projecttype.value=="1")
		{
			document.all.t1.style.visibility="visible";
			document.all.t1.style.position="relative";
			document.all.t2.style.visibility="hidden";
			document.all.t2.style.position="absolute";
		}
		else
		{
			document.all.t1.style.visibility="hidden";
			document.all.t1.style.position="absolute";
			document.all.t2.style.visibility="Visible";
			document.all.t2.style.position="relative";
		}
	}
}

function getIndustrysector()
{
	if(document.forms[0].sel_industrysector.value!="0")
	{
		if(document.forms[0].sel_industrysector.value=="1")
		{
			document.forms[0].sel_industryeligibility.value="1";
		}
		else
		{
			document.forms[0].sel_industryeligibility.value="2";
		}
		document.forms[0].sel_industryeligibility.disabled=true;
	}
}

function getEnableMetro()
{
	if(document.forms[0].sel_metro.value!="0")
	{
		if(document.forms[0].sel_metro.value=="1")
		{
			document.forms[0].sel_metroeligibility.value="2";
		}
		else
		{
			document.forms[0].sel_metroeligibility.value="1";
		}
		document.forms[0].sel_metroeligibility.disabled=true;
	}
}



</script>
<body onload="callonLoad()" >
<form class="normal" method="post">
 <h1><%=strInstalment%></h1>
<!--<span style="display:none;"><lapschoice:borrowertype /></span> -->
<lapschoice:application/>

<table width="95%" border="1" cellspacing="0" cellpadding="3"
	class="outertable" align="center" style="margin-left: 20px; margin-right: 20px; margin-top: 5px;">
<tr>
<td>
<table class="outertable" width="100%"  border="0" cellspacing="0" cellpadding="3" align="center">
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr>
	<td colspan="3">&nbsp;</td>
	</tr>
	<tr >
		<td colspan="3" >Facility <span class="mantatory">*</span>&nbsp; &nbsp;<select name="sel_facility" onchange="callIFrame();" id="sel_fac">
				<option value="0" >--Select--</option>
                <lapschoice:ComMisDetailsTag apptype='<%=Helper.correctNull((String)request.getParameter("appno")) %>'  page='NCGTC'/>
				</select></td>
		<td></td>
	</tr>
	<tr>
	<td colspan="3">&nbsp;</td>
	</tr>
	<tr class="dataheader">
		<td width="40%" style="text-align: center">Details of the Project</td>
		<td width="30%" style="text-align: center">Project description</td>
		<td width="30%" style="text-align: center">Eligibility</td>
	</tr>

	<tr>
		<td width="40%">Type of the Project <span class="mantatory">*</span></td> 
		<td width="30%"><select name="sel_projecttype" onchange="getEnableproject()"  class='myselect'>
			<option value="0">---Select---</option>
			<lapschoice:StaticDataTag apptype="270" tagType=""/>
		</select></td>
		<td width="30%">&nbsp;</td>
	</tr>
	<tr id="t1">
		<td>New employment likely to be generated in case of greenfield projects <span class="mantatory">*</span>&nbsp;</td>
		<td><input type="text" name="txt_greenfield" onKeyPress="allowInteger(this)" value="<%=Helper.correctNull((String)hshValues.get("CORP_GREENFIELD"))%>" maxlength="5" onkeyPress="allowAlphaNumericnotdot()">&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr id="t2">
		<td>Additional employment likely to be generated in case of brownfield <span class="mantatory">*</span>&nbsp;</td>
		<td><input type="text" name="txt_brownfield" onKeyPress="allowInteger(this)" value="<%=Helper.correctNull((String)hshValues.get("CORP_BROWNFIELD"))%>" maxlength="5" onkeyPress="allowNumber(this)">&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>Whether the project is in any of the metropolitan cities  Ahmedabad, Bengaluru, Hyderabad, Chennai, Kolkata, Mumbai, New Delhi and Pune <span class="mantatory">*</span>&nbsp;</td>
		<td><select name="sel_metro" onchange="getEnableMetro()" class='myselect'>
			<option value="0">---Select---</option>
			<lapschoice:StaticDataTag apptype="271" tagType=""/>
		</select>&nbsp;</td>
		<td><select name="sel_metroeligibility" class='myselect'>
			<option value="0">---Select---</option>
			<lapschoice:StaticDataTag apptype="272" tagType=""/>
		</select>&nbsp;</td>
	</tr>
	<tr>
		<td>Industry Sector <span class="mantatory">*</span>&nbsp;</td>
		<td><select name="sel_industrysector" onchange="getIndustrysector()" class='myselect'>
			<option value="0">---Select---</option>
			<lapschoice:StaticDataTag apptype="273" tagType=""/>
		</select>&nbsp;</td>
		<td><select name="sel_industryeligibility" class='myselect'>
			<option value="0">---Select---</option>
			<lapschoice:StaticDataTag apptype="274" tagType=""/>
		</select>&nbsp;</td>
	</tr>
		<tr>
		<td>Udyog Aadhaar Number(12 Digits)   &nbsp;</td>
		<td><input type="text" name="txt_udyogaadhaar" maxlength="12" value="" onKeyPress="allowInteger(this)">&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td width="60%">Project unit pin code <span class="mantatory">*</span></td>
		<td width="40%"><input type="text" id="txtpincode" name="txt_projectunitpincode" onblur="checklength()" value="<%=Helper.correctNull((String)hshValues.get("CORP_PROJECTUNITPIN"))%>" maxlength="6" onKeyPress="allowInteger(this)"></td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td width="60%">Nature of the Project <span class="mantatory">*</span></td>
		<td width="40%"><select name="sel_natureofproject" class='myselect'>
			<option value="0">---Select---</option>
			<lapschoice:StaticDataTag apptype="275" tagType=""/>
		</select></td>
	</tr>
	
</table>
</td>
</tr>
</table>

<!-- Term Loan Details-->

<!-- Table of Credit to be Guaranteed-->

<!-- Outstanding Facility Table  -->

<!-- Button Portion in table -->
			
</td>
</tr>

</table>
<br>
<table width="12%" border="0" cellspacing="0" cellpadding="0"	align="center" class="outertable">

       <%if(strSessionModuleType.equals("RET")){%>
		<tr>
	<lapschoice:combuttonnew btnnames='Edit_Save_Delete_Cancel' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />	
	</tr>
	<%}else{%>
      <tr>
	<lapschoice:combuttonnew btnnames='Edit_Save_Delete_Cancel' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />	
	</tr>
	<%} %>		
	</table>




					
<lapschoice:hiddentag pageid="<%=PageId %>" /> 
<input type="hidden" name="hidUsername" value="<%=Helper.correctNull((String)session.getAttribute("strUserName"))%>"> 
<input type="hidden" name="hidOrgcode" value="<%=Helper.correctNull((String)session.getAttribute("strOrgCode"))%>">
 <input type="hidden" name="hidCreatedOn" value="<%=strCreatedOn%>" >
<input type="hidden" name="hidCreatedBy" value="<%=strCreatedBy%>" >
<input type="hidden" name="hidCondtion" value="<%=strCgAppNo%>" >
<INPUT TYPE="hidden" NAME="hidfinanceid" value="<%=Helper.correctInt((String) hshValues.get("finace_id"))%>">
<input type="hidden" name="sel_facilitysno" value="1">


<input type="hidden" name="hidFacility" value="<%=Helper.correctNull((String) hshValues.get("facility"))%>" >
<iframe name="ifrm" width="0" height="0" border="0"></iframe>
</form>
</body>
</html>
