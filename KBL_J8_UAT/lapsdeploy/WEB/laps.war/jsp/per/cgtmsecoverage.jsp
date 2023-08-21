<%@include file="../share/directives.jsp"%>

<%String strCgAppNo=Helper.correctNull((String)hshValues.get("ApplicationExist"));//yes or n

String strCreatedBy=Helper.correctNull((String)hshValues.get("CreateBy"));
String strCreatedOn=Helper.correctNull((String)hshValues.get("CreateDate"));

java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
%>
<%
	String appno = Helper.correctNull((String) request.getParameter("appno"));
	if (appno.equals("")) 
	{
		appno = Helper.correctNull((String) hshValues.get("strAppno"));
	}
	if(appno.equals("")) 
	{
		appno = Helper.correctNull((String) request.getParameter("Applicationno"));
	}
	%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>CGTMSE Coverage</title>

</head>
<script>	
var currentDate="<%=Helper.getCurrentDateTime()%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varAppExist="<%=strCgAppNo%>";
var varAppDetNPA="<%=Helper.correctNull((String) hshValues.get("CG_AD_NPA"))%>";

function selection()
{
	var Npa="<%=Helper.correctNull((String) hshValues.get("Npa"))%>";
	var MicEntp="<%=Helper.correctNull((String) hshValues.get("MicEntp"))%>";
	var Newunit="<%=Helper.correctNull((String) hshValues.get("Newunit"))%>";
	var NewunitWO="<%=Helper.correctNull((String) hshValues.get("NewunitWO"))%>";
	var MSEunit="<%=Helper.correctNull((String) hshValues.get("MSEunit"))%>";
	var MSEunitWO="<%=Helper.correctNull((String) hshValues.get("MSEunitWO"))%>";
	var MSMEDunit="<%=Helper.correctNull((String) hshValues.get("MSMEDunit"))%>";
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
	

	var PrevCGTMSE="<%=Helper.correctNull((String) hshValues.get("PrevCGTMSE"))%>";
	var varCG_INTERNAL_RATING="<%=Helper.correctNull((String) hshValues.get("CG_INTERNAL_RATING"))%>";	
	var varAppDetNPA="<%=Helper.correctNull((String) hshValues.get("CG_AD_NPA"))%>";	
	
	if(IndustrySec=="001")
	{
		document.forms[0].IndustrySector[1].selected=true;
	}
	else if(IndustrySec=="002")
	{
		document.forms[0].IndustrySector[2].selected=true;
	}
	
	if(NatuIndustry=="001")
		{
			document.forms[0].NatureIndustry[1].selected=true;
		}
		else if(NatuIndustry=="002")
		{
			document.forms[0].NatureIndustry[2].selected=true;
		}
		else if(NatuIndustry=="003")
		{
			document.forms[0].NatureIndustry[3].selected=true;	
		}

	
		if(SocialCatgry=="SC")
		{
			document.forms[0].SocialCatgry[1].selected=true;
		}
		else if(SocialCatgry=="BC")
		{
			document.forms[0].SocialCatgry[2].selected=true;
		}
		else if(SocialCatgry=="ST")
		{
			document.forms[0].SocialCatgry[3].selected=true;
		}
		else if(SocialCatgry=="MBC")
		{
			document.forms[0].SocialCatgry[4].selected=true;
		}
		else if(SocialCatgry=="OC")
		{
			document.forms[0].SocialCatgry[5].selected=true;
		}
		

		if(legalId=="V")
		{
			document.forms[0].legalId[1].selected=true;
		}
		else if(legalId=="P")
		{
			document.forms[0].legalId[2].selected=true;
		}
		else if(legalId=="D")
		{
			document.forms[0].legalId[3].selected=true;
		}
		else if(legalId=="R")
		{
			document.forms[0].legalId[4].selected=true;
		}
		else if(legalId=="O")
		{
			document.forms[0].legalId[5].selected=true;
		}
		


	
	if(MinCommuity=="Y")
	{
		document.forms[0].MinCommuity[1].selected=true;
	}
	else if(MinCommuity=="N")
	{
		document.forms[0].MinCommuity[2].selected=true;
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

	
	if(Namescheme=="IHDS")
	{
		document.forms[0].Namescheme[1].selected=true;
	}
	else if(Namescheme=="MCS")
	{
		document.forms[0].Namescheme[2].selected=true;
	}
	if(checkBx=="V")
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

	if(MSMEDunit=="Y")
	{
		document.forms[0].MSMEDunit[1].selected=true;
	}
	else if(MSMEDunit=="N")
	{
		document.forms[0].MSMEDunit[2].selected=true;
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
	if(varCG_INTERNAL_RATING!="")
	{
		document.forms[0].sel_internalRating.value=varCG_INTERNAL_RATING;
	}
	else
	{
		document.forms[0].sel_internalRating.value="";
	}
}
function callCalender1(name)
{	
		showCal(appURL,name);
}
	

	function doEdit() 
	{
		var var_AadharNo="<%=Helper.correctNull((String)hshValues.get("UdyogAadharNo"))%>";
		if(var_AadharNo=="")
		{
			alert("Please fill Udyog Aadhaar Number in Customer Profile");	
			return false;
		}
		callDisable(false);
		disableControls(true,false,true,false,true);	
	}

	function doCancel()
	{
		
		if(ConfirmMsg('102'))
		{
			document.forms[0].action=appURL+"action/cgtmsecoverage.jsp";
			document.forms[0].hidBeanId.value = "supuser";
			document.forms[0].hidBeanGetMethod.value = "getCgtmse";
			document.forms[0].submit();
		}
		
	}
	function callonLoad()
	{
		callDisable(true);
		//disableControls(false,true,true,true,false);
	
				
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

function doClose()
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
function doSave()  
{
	if(document.forms[0].txt_cgtmse_coverage.value=="" || document.forms[0].txt_cgtmse_coverage.value=="0.00" )
	{
		ShowAlert(121,"Global CGTMSE Coverage of Borrower");
		document.forms[0].txt_cgtmse_coverage.focus();
		return;
	}
	
	if(document.forms[0].GF_ASF.value=="")
	{
		ShowAlert(111,"Whether GF/ASF is re-imbursable from O/o DC (Handicrafts), Govt of India!");
		document.forms[0].GF_ASF.focus();
		return;
	}

	if(document.forms[0].ArtisanCC.value=="")
	{
		ShowAlert(111,"Artisan Credit Card!");
		document.forms[0].ArtisanCC.focus();
		return;
	}
	if(document.forms[0].ArtisanCC.value=="Y")
	{
		if(document.forms[0].IdentyDC.value=="")
		{
			ShowAlert(111,"Details of Identity Card issued by DC!");
			document.forms[0].IdentyDC.focus();
			return;
		}
	}
	if(document.forms[0].JointFinance.value=="")
	{
		ShowAlert(111,"Whether the credit is sanctioned under Joint Finance scheme:");
		document.forms[0].JointFinance.focus();
		return;
	}
	if(document.forms[0].JointFinance.value=="Y")
	{
		if(document.forms[0].JFCGpan.value=="")
		{
			ShowAlert(121,"Joint Finance CGPan!");
			document.forms[0].JFCGpan.focus();
			return;
		}
	}
	/* if(document.forms[0].AsistBank.value=="")
	{
		ShowAlert(111,"Whether borrower already assisted by bank");
		document.forms[0].AsistBank.focus();
		return;
	} */

	if(document.forms[0].MicEntp.value=="")
	{
		ShowAlert(111,"Whether the unit Assisted is a Micro Enterprise and Guarantee cover is within Rs.5 lakh cap");
		document.forms[0].MicEntp.focus();
		return;
	}

	if(document.forms[0].NatureIndustry.value=="")
	{
		ShowAlert(111," Nature of Industry ");
		document.forms[0].NatureIndustry.focus();
		return;
	}

	if(document.forms[0].IndustrySector.value=="")
	{
		ShowAlert(111,"Industry Sector ");
		document.forms[0].IndustrySector.focus();
		return;
	}
	
	if(document.forms[0].NoEmp.value=="")
	{
		ShowAlert(121,"Number of Employees");
		document.forms[0].NoEmp.focus();
		return;
	}

	if(document.forms[0].ProjOptiSales.value=="")
	{
		ShowAlert(121,"Projected Optimum Sales/Turnover/Income/Receipt");
		document.forms[0].ProjOptiSales.focus();
		return;
	}

	if(document.forms[0].ProjOptiExport.value=="")
	{
		ShowAlert(121," Projected Optimum Exports");
		document.forms[0].ProjOptiExport.focus();
		return;
	}

	if(document.forms[0].MinCommuity.value=="")
	{
		ShowAlert(111,"Whether the chief Promoter/Individual belongs to Minority Community");
		document.forms[0].MinCommuity.focus();
		return;
	}

	if(document.forms[0].SocialCatgry.value=="")
	{
		ShowAlert(111,"Social Category!");
		document.forms[0].SocialCatgry.focus();
		return;
	}


	if(document.forms[0].Newunit.value=="")
	{
		ShowAlert(111,"Whether unit assisted is a new unit");
		document.forms[0].Newunit.focus();
		return;
	}
	if(document.forms[0].NewunitWO.value=="")
	{
		ShowAlert(111,"Whether the unit is Women Operated and/or Women Owned");
		document.forms[0].NewunitWO.focus();
		return;
	}
	if(document.forms[0].MSEunit.value=="")
	{
		ShowAlert(111,"Whether the unit Assisted is an MSE as per the MSMED Act 2006 definition of MSE");
		document.forms[0].MSEunit.focus();
		return;
	}
	if(document.forms[0].MSEunitWO.value=="")
	{
		ShowAlert(111,"Whether the unit is Women Operated and/or Women Owned");
		document.forms[0].MSEunitWO.focus();
		return;
	}
	if(document.forms[0].MSMEDunit.value=="")
	{
		ShowAlert(111,"Whether the unit Assisted is an MSE as per the MSMED Act 2006 definition of MSE");
		document.forms[0].MSMEDunit.focus();
		return;
	}
	if(document.forms[0].TC_PromoContrbtn.value=="")
	{
		ShowAlert(121,"Promoter Contribution!");
		document.forms[0].TC_PromoContrbtn.focus();
		return;
	}
	if(document.forms[0].TC_Subsidy.value=="")
	{
		ShowAlert(121,"Subsidy!");
		document.forms[0].TC_Subsidy.focus();
		return;
	}

	if(document.forms[0].TC_Others.value=="")
	{
		ShowAlert(121,"Others value !");
		document.forms[0].TC_Others.focus();
		return;
	}

	if(document.forms[0].TC_ProjCost.value=="")
	{
		ShowAlert(121,"Project Cost!");
		document.forms[0].TC_ProjCost.focus();
		return;
	}

	if(document.forms[0].TC_ProjOutlay.value=="")
	{
		ShowAlert(121,"Project Outlay!");
		document.forms[0].TC_ProjOutlay.focus();
		return;
	}

	

	/*if(document.forms[0].TL_CrdtAmt.value=="0.00")
	{
		ShowAlert(121,"TermLoan Credit Amount");
		document.forms[0].TL_CrdtAmt.focus();
		return;
	}*/

	/*if(document.forms[0].TL_AmtDisbursment.value=="0.00")
	{
		ShowAlert(121,"Amount Disbursment!");
		document.forms[0].TL_AmtDisbursment.focus();
		return;
	}*/

	/*if(document.forms[0].TL_OutsAmount.value=="0.00")
	{
		ShowAlert(121,"Outstanding Amount");
		document.forms[0].TL_OutsAmount.focus();
		return;
	}*/

	/*if(document.forms[0].TL_DtOutsAmnt.value=="")
	{
		ShowAlert(121,"Outstanding Amount Date");
		document.forms[0].TL_DtOutsAmnt.focus();
		return;
	}*/

	/*if(document.forms[0].TL_DtFstInsDue.value=="")
	{
		ShowAlert(121,"Date of first Installment Due!");
		document.forms[0].TL_DtFstInsDue.focus();
		return;
	}*/

	/*if(document.forms[0].TL_DtFstDisbursment.value=="")
	{
		ShowAlert(121,"Date of First Disbursment!");
		document.forms[0].TL_DtFstDisbursment.focus();
		return;
	}
	if(document.forms[0].TL_DtLstDisbursment.value=="")
	{
		ShowAlert(121,"Date of last Disbursment!");
		document.forms[0].TL_DtLstDisbursment.focus();
		return;
	}*/


	if(document.forms[0].legalId.value=="O")
	{
		if(document.forms[0].OtherIDName.value=="")
		{
			ShowAlert(121,"Other ID Name!");
			document.forms[0].OtherIDName.focus();
			return;
		}	
		if(document.forms[0].OtherIDNo.value=="")
		{
			ShowAlert(121,"Other ID number!");
			document.forms[0].OtherIDNo.focus();
			return;
		}	
	}

	if(document.forms[0].HandloomScheme.value=="Y")
	{
		if(document.forms[0].Namescheme.value=="")
		{
			ShowAlert(111,"Name of Scheme!");
			document.forms[0].Namescheme.focus();
			return;
		}
							
	}

	if(document.forms[0].HandloomScheme.value=="")
	{		
			ShowAlert(111,"Whether the credit is sanctioned under DC (Handloom) scheme for Handloom Weavers!");
			document.forms[0].HandloomScheme.focus();
			return;
		}
			
	if(document.forms[0].PrevCGTMSE.value=="")
	{		
			ShowAlert(111,"Whether Borrower Covered by CGTMSE previously!");
			document.forms[0].PrevCGTMSE.focus();
			return;
		}
	
	  
	if(document.forms[0].PrevCGTMSE.value=="Y")
	{
		if(document.forms[0].PrevCGPan.value=="")
		{
			ShowAlert(121,"Previous CGPAN!");
			document.forms[0].PrevCGPan.focus();
			return;
		}
		if(document.forms[0].availamt_gurantee.value=="")
		{
			ShowAlert(121,"Balance Amount available for Guarantee");
			document.forms[0].availamt_gurantee.focus();
			return;
		}
							
	}
	if(document.forms[0].HandloomScheme.value=="Y")
	{
	if(document.forms[0].checkBx.checked==false)
	{
		ShowAlert(111,"Verify CGTMSE!");
		document.forms[0].checkBx.focus();
		return;
	}
	}
	if(document.forms[0].AsistBank.value=="Y")
	{
	if(document.forms[0].Outstand_Amt.value=="")
	{
		ShowAlert(121,"Outstanding amount on date of sanction of credit facility");
		document.forms[0].Outstand_Amt.focus();
		return;
	}
	if(document.forms[0].sel_npa.value=="")
	{
		ShowAlert(111,"NPA");
		document.forms[0].sel_npa.focus();
		return;
	}
	}
	document.forms[0].cmdsave.disabled = true;
	
	document.forms[0].hidBeanId.value = "supuser";
	document.forms[0].hidSourceUrl.value = "/action/cgtmsecoverage.jsp";
	document.forms[0].hidBeanMethod.value = "updateData";	
	document.forms[0].hidBeanGetMethod.value = "getCgtmse";
	document.forms[0].action = appURL + "controllerservlet";
	document.forms[0].submit();

	 function cgpan()
	 {

	 }
}

function selScheme()
{  
	 if(document.forms[0].HandloomScheme.value=="")
	 {
		document.forms[0].Namescheme.value="";
		document.forms[0].checkBx.value="";
	 }
	if(document.forms[0].HandloomScheme.value=="Y")
	{
		document.all.selSch.style.visibility="visible";
		document.all.selSch.style.position="relative";
		document.all.selChK.style.visibility="visible";
		document.all.selChK.style.position="relative";
	}
	else
	{
		document.all.selSch.style.visibility="hidden";
		document.all.selSch.style.position="absolute";
		document.all.selChK.style.visibility="hidden";
		document.all.selChK.style.position="absolute";
		
	}
}
function leglOthr()
{ 
	 if(document.forms[0].legalId.value=="")
	 {
		document.forms[0].LegalIdNo.value="";
	 }
	if(document.forms[0].legalId.value=="O")
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
function CategoryPage()
{
	var varPage="RET";
	if(varPage=="RET")
	{
		document.all.WcClass.style.visibility="hidden";
		document.all.WcClass.style.position="absolute";

		document.all.crdt.style.visibility="hidden";
		document.all.crdt.style.position="absolute";
		
		document.all.mm.style.visibility="hidden";
		document.all.mm.style.position="absolute";

		document.all.wca.style.visibility="hidden";
		document.all.wca.style.position="absolute";

		document.all.wcs.style.visibility="hidden";
		document.all.wcs.style.position="absolute";
		
	}
	else
	{
		document.all.WcClass.style.visibility="visible";
		document.all.WcClass.style.position="relative";

		document.all.crdt.style.visibility="visible";
		document.all.crdt.style.position="relative";

		document.all.mm.style.visibility="visible";
		document.all.mm.style.position="relative";

		document.all.wca.style.visibility="visible";
		document.all.wca.style.position="relative";

		document.all.wcs.style.visibility="visible";
		document.all.wcs.style.position="relative";
	}
}
function leglOthr()
{ 
	 if(document.forms[0].legalId.value=="")
	 {
		document.forms[0].LegalIdNo.value="";
	 }
	if(document.forms[0].legalId.value=="O")
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
function doGenerateReport()
{ 	
	var var_AadharNo="<%=Helper.correctNull((String)hshValues.get("UdyogAadharNo"))%>";
	if(var_AadharNo=="")
	{
		alert("Please fill Udyog Aadhaar Number in Customer Profile");	
		return false;
	}
	if(varAppExist=="No")
	{
		alert("Please fill CGTMSE Tab and then Proceed !");	
		return false;
	}
		var appno = document.forms[0].appno.value;
		var comappid = document.forms[0].hidapplicantid.value;
		var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
		var title = "PrintFairReport";
		var xpos = 5;
		var ypos = 5;
		prop = prop + ",left="+xpos+",top="+ypos;
		var url=appUrl+"action/cgtmse_annexure.jsp?hidBeanId=supuser&hidBeanGetMethod=getRetailAnnexure&appno="+appno+"&comappid="+comappid;
		window.open(url,title,prop);
	
	
}
function PreCGpan()
{ 
	/*if(document.forms[0].PrevCGTMSE.value=="" || document.forms[0].PrevCGTMSE.value=="N" )
	 {
		document.forms[0].PrevCGPan.value="";
	 }*/
	
	if(document.forms[0].PrevCGTMSE.value=="Y")
	{ 
		
		document.all.prvcgpan.style.visibility="visible";
		document.all.prvcgpan.style.position="relative";
		document.all.idAvailAmt.style.visibility="visible";
		document.all.idAvailAmt.style.position="relative";
		
		
	}
	else
	{
		document.all.prvcgpan.style.visibility="hidden";
		document.all.prvcgpan.style.position="absolute";
		document.all.idAvailAmt.style.visibility="hidden";
		document.all.idAvailAmt.style.position="absolute";
		
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
}function IdCardEnable()
{
	
	if(document.forms[0].ArtisanCC.value=="Y")
	{
		
		document.all.idIssued.style.visibility="visible";
		document.all.idIssued.position="relative";
	}
	else
	{
	
		document.all.idIssued.style.visibility="hidden";
	    document.all.idIssued.position="absolute";
	}
	
	
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
</script>
<body onload="callonLoad(); selection(); CategoryPage(); selScheme(); leglOthr(); PreCGpan(); IdCardEnable(); CgpanEnable(); callOutstandAmt();">
<form class="normal" method="post">
<lapschoice:application />

<table width="95%" border="1" cellspacing="0" cellpadding="3"
	class="outertable" align="center" style="margin-left: 20px; margin-right: 20px; margin-top: 5px;">
<tr>
<td>
<table class="outertable" width="100%"  border="0" cellspacing="0" cellpadding="3" align="center">
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr class="dataheader">
		<td style="text-align: center" colspan="2">Borrower Details</td>
		<td></td>
	</tr>

	<tr>
		<td width="60%">CG PAN</td> 
		<td width="40%"><%=Helper.correctNull((String)hshValues.get("CGPan"))%></td>
	</tr>
	<tr>
		<td width="60%">MSE Registration Number</td>
		<td width="40%"><%=Helper.correctNull((String)hshValues.get("MSERegNo"))%></td>
	</tr>
	<tr>
		<td width="60%">Udyog Aadhaar Number(12 Digits)</td>
		<td width="40%"><%=Helper.correctNull((String)hshValues.get("UdyogAadharNo"))%></td>
	</tr>
	
	<tr>
		<td width="60%">Global CGTMSE Coverage of Borrower</td>
		<td width="40%"><input type="text" style="text-align: right;"  name="txt_cgtmse_coverage" onKeyPress="allowDecimals(this);" onBlur="roundtxt(this);" maxlength="20" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("CG_CGTMSE_COVERAGE"))))%>"></td>
	</tr>
	<!-- <tr>
		<td width="60%">Whether borrower already assisted by bank</td>
		<td width="40%"><select name="AsistBank" onchange="callOutstandAmt();">
			<option value="" selected>---select--</option>
			<option value="Y">Yes</option>
			<option value="N">No</option>

		</select></td>
	</tr> -->
	<tr id="idOutsamt">
	<td width="60%">Outstanding amount on date of sanction of credit facility</td>
	<td width="40%"><input type="text" style="text-align: right;"  name="Outstand_Amt" value="<%=Helper.correctNull((String)hshValues.get("CG_AD_OUSTANSDAMT"))%>" onKeyPress="allowDecimals(this);" onBlur="roundtxt(this);" maxlength="20" ></td>
	</tr>
	<tr id="idAsistNpa"><td width="60%">NPA</td><td width="40%"><select name="sel_npa">
	<option value="">--select--</option>
	<option value="Y">Yes</option>
	<option value="N">No</option>
	</select>
	</td>
	</tr>
	<tr>
		<td width="60%">Whether the unit Assisted is a Micro Enterprise and Guarantee
		cover is within Rs.5 lakh cap</td>
		<td width="40%"><select name="MicEntp">
			<option value="" selected>---select--</option>
			<option value="Y">Yes</option>
			<option value="N">No</option>

		</select></td>
	</tr>
	
	<tr>
		<td width="60%">Nature of Industry </td>
		<td width="40%"><select name="NatureIndustry" tabindex="17">
													<option value="">---select---</option>
													<lapschoice:StaticDataTag apptype="210" />
												</select> </td>
	</tr>
	<tr>
		<td width="60%">Industry Sector  </td>
		<td width="40%"><select name="IndustrySector" tabindex="17">
													<option value="">---select---</option>
													<lapschoice:StaticDataTag apptype="211" />
												</select> </td>
	</tr>
	<tr>
		<td width="60%">Number of Employees</td>
		<td width="40%"><input type="text" name="NoEmp"  maxlength="20" value="<%=Helper.correctNull((String)hshValues.get("NoEmp"))%>" onkeypress="allowInteger();"></td>
	</tr>
	
	<tr>
		<td width="60%">Projected Optimum Sales/Turnover/Income/Receipt</td>
		<td width="40%"><input type="text" style="text-align: right;"  name="ProjOptiSales" onKeyPress="allowDecimals(this);" onBlur="roundtxt(this);" maxlength="20" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("ProjOptiSales"))))%>"></td>
	</tr>


	<tr>
		<td width="60%">Projected Optimum Exports</td>
		<td width="40%"><input type="text" style="text-align: right;"  name="ProjOptiExport" onKeyPress="allowDecimals(this);" onBlur="roundtxt(this);" maxlength="20" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("ProjOptiExport"))))%>"></td>
	</tr>

	<tr>
		<td width="60%">Whether Borrower Covered by CGTMSE  previously</td>
		<td width="20%" colspan="2"><select name="PrevCGTMSE" onchange="PreCGpan();">
			<option value="" selected>---select--</option>
			<option value="Y">Yes</option>
			<option value="N">No</option>

		</select></td>
		<td width="20%"></td>
	</tr>
	<tr id="prvcgpan">
		<td width="60%">CGPAN Previous</td>
		<td width="20%" colspan="2"><input type="text" name="PrevCGPan" onkeypress="allowAlphaNumeric()"  maxlength="20" value="<%=Helper.correctNull((String)hshValues.get("PrevCGPan"))%>"></td>
		<td width="20%"></td>
	</tr>
	<tr id="idAvailAmt">
		<td width="60%">Balance Amount available for Guarantee</td>
		<td width="20%" colspan="2"><input type="text" style="text-align: right;" name="availamt_gurantee" value="<%=Helper.correctNull((String)hshValues.get("CG_HC_AVAIL_AMT"))%>" onKeyPress="allowDecimals(this);" onBlur="roundtxt(this);" maxlength="15"></td>
		<td width="20%"></td>
	</tr>
</table>

</td>
</tr>

<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr class="dataheader">
		<td style="text-align: center" colspan="3">Promoters Details</td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td width="60%">Whether the chief Promoter/Individual belongs to Minority Community</td>
		<td width="20%" colspan="2"><select name="MinCommuity">
			<option value="" selected>---select--</option>
			<option value="Y">Yes</option>
			<option value="N">No</option>

		</select></td>
		<td width="20%"></td>
	</tr>
	<tr>
		<td width="60%">Social Category</td>
		<td width="20%" colspan="2"><select name="SocialCatgry">
			<option value="" selected>---select--</option>
			<option value="SC">SC</option>
			<option value="BC">BC</option>
			<option value="ST">ST</option>
			<option value="MBC">Most Backward</option>
			<option value="OC">Other Category</option>

		</select></td>
		<td width="20%"></td>
	</tr>
	<tr>
		<td width="60%">Legal ID</td>
		<td width="20%" colspan="2">
			<select name="legalId" onchange="leglOthr();">
			<option value="" selected>---select--</option>
			<option value="V">Voter Identity</option>
			<option value="P">Passport Number</option>
			<option value="D">Driving License</option>
			<option value="R">Most Ration Card Number</option>
			<option value="O">Others</option>

			</select>
		</td >
		<td width="20%" id="idDiv" style="margin-left:-25px;">ID No<input type="text"  name="LegalIdNo"  maxlength="20" value="<%=Helper.correctNull((String)hshValues.get("LegalIdNo"))%>" onkeypress="allowAlphaNumeric();"></td>
		
	</tr>
	
	<tr id="othrID">
		<td width="60%">(Other ID) Please specify</td>
		<td width="20%" colspan="2"><input type="text" style="text-align: right;"  name="OtherIDName" onkeypress="allowAlphabets();" maxlength="20" value="<%=Helper.correctNull((String) hshValues.get("OtherIDName"))%>"></td>
		<td width="20%">ID No<input type="text" style="text-align: right;"  name="OtherIDNo"  maxlength="20" value="<%=Helper.correctNull((String)hshValues.get("OtherIDNo"))%>" onkeypress="allowAlphaNumeric();"></td>
	</tr>
	<tr class="dataheader">
		<td style="text-align: center" colspan="3">Project Details Outlay</td>
		<td></td>
		<td></td>
	</tr>

	<tr>
		<td width="60%">Whether unit assisted is a new unit</td>
		<td width="20%" colspan="2"><select name="Newunit">
			<option value="" selected>---select--</option>
			<option value="Y">Yes</option>
			<option value="N">No</option>

		</select></td>
		<td width="20%"></td>
	</tr>

	<tr>
		<td width="60%">Whether the unit is Women Operated and/or Women Owned</td>
		<td width="20%" colspan="2"><select name="NewunitWO">
			<option value="" selected>---select--</option>
			<option value="Y">Yes</option>
			<option value="N">No</option>

		</select></td>
		<td width="20%"></td>
	</tr>

	<tr>
		<td width="60%">Whether the unit Assisted is an MSE as per the MSMED Act 2006
		definition of MSE</td>
		<td width="20%" colspan="2"><select name="MSEunit">
			<option value="" selected>---select--</option>
			<option value="Y">Yes</option>
			<option value="N">No</option>

		</select></td>
		<td width="20%"></td>
	</tr>
<tr>
		<td width="60%">Whether the Unit Assisted is a Micro Enterprise as per the MSMED Act 2006</td>
		<td width="20%" colspan="2"><select name="MSEunitWO">
			<option value="" selected>---select--</option>
			<option value="Y">Yes</option>
			<option value="N">No</option>

		</select></td>
		<td width="20%"></td>
	</tr>

	<tr>
		<td width="60%">Whether first charge on Primary Securities is available </td>
		<td width="20%" colspan="2"><select name="MSMEDunit">
			<option value="" selected>---select--</option>
			<option value="Y">Yes</option>
			<option value="N">No</option>

		</select></td>
		<td width="20%"></td>
	</tr>	
	<tr>
		<td width="60%">Collateral Security Taken</td>
		<td width="20%" colspan="2">
			<select name="ColSec"><option value="N" selected>NO</option></select>
		</td>
		<td width="20%"></td>
	</tr>
	<tr>
		<td width="60%">Third Party Guarantee</td>
		<td width="20%" colspan="2">
		<select name="ThirdParty"><option value="N" selected>NO</option></select>
		</td>
		<td width="20%"></td>
	</tr>

</table>
</td>
</tr>
<!-- Handicraft Tables -->
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr class="dataheader"  style="text-align:center;">
		<td colspan="2">Joint Finance</td>
		<td></td>
	</tr>
	<tr>
		<td width="60%">Whether the credit is sanctioned under Joint Finance scheme:</td>
		<td width="40%"><select name="JointFinance" onchange="CgpanEnable();">
			<option value="" selected>---select--</option>
			<option value="Y">Yes</option>
			<option value="N">No</option>
		</select></td>
	</tr>
	<tr id="idCgpan">
		<td width="60%">Joint Cgpan (Existing Cgpan of this borrower) </td>
		<td width="40%"><input type="text" onkeypress="allowAlphaNumeric()" name="JFCGpan"  maxlength="20" value="<%=Helper.correctNull((String)hshValues.get("JFCGpan"))%>"></td>
	</tr>
	
	<tr class="dataheader"  style="text-align:center;">
		<td colspan="2">Handicrafts</td>
		<td></td>
	</tr>

	<tr>
		<td width="60%">Whether the credit is sanctioned Under Artisan credit Card
		(ACC) Scheme for Handicraft Artisans operated by DC(Handicrafts),Govt
		of India</td>
		<td width="40%"><select name="ArtisanCC" onchange="IdCardEnable();">
			<option value="" selected>---select--</option>
			<option value="Y">Yes</option>
			<option value="N">No</option>
		</select></td>
	</tr>
	<tr id="idIssued">
		<td width="60%">Details of Identity Card number issued by DC</td>
		<td width="40%"><input type="text" name="IdentyDC" maxlength="15" onkeypress="allowAlphaNumeric()" value="<%=Helper.correctNull((String)hshValues.get("IdentyDC"))%>"></td>
	</tr>
	<tr>
		<td width="60%">Whether GF/ASF is re-imbursable from O/o DC (Handicrafts),
		Govt of India</td>
		<td width="40%"><select name="GF_ASF">
			<option value="" selected>---select--</option>
			<option value="Y">Yes</option>
			<option value="N">No</option>

		</select></td>
	</tr>


	
	
	<tr class="dataheader"  style="text-align:center;">
		<td colspan="2">Handloom</td>
		<td></td>
	</tr>
	<tr>
		<td width="60%">Whether the credit is sanctioned under DC  (Handloom) scheme for Handloom Weavers</td>
		<td  width="40%"><select name="HandloomScheme" onchange="selScheme();">
			<option value="" selected>---select--</option>
			<option value="Y">Yes</option>
			<option value="N">No</option>

		</select></td>
	</tr>
	<tr id="selSch">
		<td width="60%">Please select the name of the Scheme :</td>
		<td  width="40%"><select name="Namescheme">
			<option value="" selected>---select--</option>
			<option value="IHDS">Integrated handloom development scheme</option>
			<option value="MCS">Mega cluster scheme (varanashi/murshidabad)</option>

		</select></td>
	</tr>
	<tr id="selChK">
		<td  width="60%" colspan="2"><input type="checkbox" name="checkBx" value="V">We certify that the credit facility being covered under CGTMSE and for which reimbursement of GF/ASF in being availed adheres to all guidelines as issued by Office of DC(Handloom) from time to time for sanction of Credit under the respective schemes.</td>
		<td width="40%"></td>
	</tr>
	
	<tr>
		<td  width="60%">Internal Rating</td>
		<td  width="40%"><select name="sel_internalRating">
			<option value="" selected>---select--</option>
			<option value="Y">Yes</option>
			<option value="N">No</option>
		</select></td>
	</tr>

</table>
</td>
</tr>



<!-- -Mean of Finance -->
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr class="dataheader">
		<td colspan="4" style="text-align:center;">Means of Finance</td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td width="35%" colspan="2" style="text-align: center;">Term Credit Sanctioned</td>
		<td width="15%"></td>
		<td width="35%" colspan="4" style="text-align:center;"></td>
		<td width="15%"></td>
	</tr>


	<tr>
		<td width="35%">Promoters Contribution</td>
		<td width="15%"><input type="text"  style="text-align: right;" name="TC_PromoContrbtn" onKeyPress="allowDecimals(this);" onBlur="roundtxt(this);" maxlength="20" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("TC_PromoContrbtn"))))%>"></td>
		<td width="35%"></td>
		<td width="15%"></td>
	</tr>

	<tr>
		<td width="35%">Subsidy/Equity Support</td>
		<td width="15%"><input type="text" name="TC_Subsidy"  style="text-align: right;" onBlur="roundtxt(this);" onKeyPress="allowDecimals(this);" maxlength="20" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("TC_Subsidy"))))%>"></td>
		<td  width="35%"></td>
		<td width="15%"></td>
	</tr>


	<tr>
		<td width="35%">Others</td>
		<td width="15%"><input type="text" name="TC_Others" style="text-align: right;" onBlur="roundtxt(this);" onKeyPress="allowDecimals(this);" maxlength="20" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("TC_Others"))))%>"></td>
		<td width="35%"></td>
		<td width="15%"></td>
	</tr>


	<tr>
		<td width="35%">Project Cost</td>
		<td width="15%"><input type="text" style="text-align: right;"  name="TC_ProjCost" onKeyPress="allowDecimals(this);" onBlur="roundtxt(this);" maxlength="20" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("TC_ProjCost"))))%>"></td>
		<td  width="35%"></td>
		<td  width="15%"></td>
	</tr>


	<tr>
		<td width="35%">Project Outlay</td>
		<td width="15%"><input type="text" name="TC_ProjOutlay" style="text-align: right;" onBlur="roundtxt(this);" onKeyPress="allowDecimals(this);" maxlength="20" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("TC_ProjOutlay"))))%>"></td>
		<td width="35%"></td>
		<td  width="15%"></td>
	</tr>
		<tr id="wcs">
		<td width="35%" colspan="2" style="text-align: center;">Working Capital limit Sanctioned</td>
		<td width="15%"></td>
		<td width="35%"></td>
		<td width="15%"></td>
	</tr>
	<tr id="mm">
		<td width="35%">Whether provided As margin money Term Loan</td>
		<td width="15%"><select name="TL_MarginMoney">
			<option value="" selected>---select--</option>
			<option value="Y">Yes</option>
			<option value="N">No</option>

		</select></td>
		<td  width="35%"></td>
		<td  width="15%"></td>
	</tr>
	
	<tr id="wca">
		<td width="35%">Working Capital Assessed</td>
		<td width="15%"><input type="text" name="WC_Assesse" style="text-align: right;" onBlur="roundtxt(this);" onKeyPress="allowDecimals(this);" maxlength="20" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("WC_Assesse"))))%>"></td>
		<td  width="35%"></td>
		<td  width="15%"></td>
	</tr>
	
	
	
	
</table>
</td>
</tr>
<!-- Term Loan Details-->

<!-- Table of Credit to be Guaranteed-->
<tr>
<td>
<table id="crdt" width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr class="dataheader">
		<td style="text-align: center;" colspan="2">Credits to be Guaranteed</td>
		<td width="40%"></td>
	</tr>

	<tr>
		<td width="60%">Fund Based</td>
		<td width="40%"><input type="text" name="CrdtFundBased" style="text-align: right;" onBlur="roundtxt(this);" onKeyPress="allowDecimals(this);" maxlength="20" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("CrdtFundBased"))))%>"></td>
	</tr>
	<tr>
		<td width="60%">Non-Fund Based</td>
		<td width="40%"><input type="text" name="CrdtNonFundBased" style="text-align: right;" onBlur="roundtxt(this);" onKeyPress="allowDecimals(this);" maxlength="20" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("CrdtNonFundBased"))))%>"></td>
	</tr>
</table>
</td>
</tr>
<!-- Outstanding Facility Table  -->
<tr id="WcClass">
<td>
<table  width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr class="dataheader">
		<td style="text-align: center;" colspan="2">Outstanding Facilities</td>
		<td width="40%"></td>
	</tr>

	<tr>
		<td width="60%">Outstanding Fund Based Facility</td>
		<td width="40%"><input type="text" name="OutsdFundBased" style="text-align: right;" onBlur="roundtxt(this);" onKeyPress="allowDecimals(this);" maxlength="20" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("OutsdFundBased"))))%>">
		<label style="margin-left: 10px;">As On: </label><input type="text" name="OFBDt" value="<%=Helper.correctNull((String)hshValues.get("OFBDt"))%>" onkeyup="dateDOBCheck();"><a style="vertical-align: middle"  alt="Select date from calender" href="#"
											onClick="callCalender1('OFBDt')"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											border='0' alt="Select date from calender"></a>
		
		
		</td>
	</tr>
	<tr>
		<td width="60%">Outstanding Non-Fund Based Facility</td>
		<td width="40%"><input type="text" name="OutsdNonFundBased" style="text-align: right;" onBlur="roundtxt(this);" onKeyPress="allowDecimals(this);" maxlength="20" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("OutsdNonFundBased"))))%>">
		<label style="margin-left: 10px;">As On: </label><input type="text" name="ONFBdT" value="<%=Helper.correctNull((String)hshValues.get("ONFBdT"))%>" onblur="checkDate(this)"><a style="vertical-align: middle"  alt="Select date from calender" href="#"
											onClick="callCalender1('ONFBdT')"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											border='0' alt="Select date from calender" ></a>
		
		
		
		</td>
	</tr>
</table>
</td>
</tr>
<!-- Button Portion in table -->
<tr>
<td>
		<table width="12%" border="0" cellspacing="0" cellpadding="0"	align="center" class="outertable">
			<tr>
				<lapschoice:combuttonnew btnnames='Edit_Save_Delete_Cancel_Generate Report' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />	
			</tr>
		</table>
		
</td>
</tr>

</table>
</td>
</tr>
</table>





					
<lapschoice:hiddentag pageid="<%=PageId %>" /> 
<input type="hidden" name="hidUsername" value="<%=Helper.correctNull((String)session.getAttribute("strUserName"))%>"> 
<input type="hidden" name="hidOrgcode" value="<%=Helper.correctNull((String)session.getAttribute("strOrgCode"))%>">
 <input type="hidden" name="hidCreatedOn" value="<%=strCreatedOn%>" >
<input type="hidden" name="hidCreatedBy" value="<%=strCreatedBy%>" >
<input type="hidden" name="hidCondtion" value="<%=strCgAppNo%>" >
<input type="hidden" name="hidappno" value="<%=request.getParameter("appno")%>"> 
<input type="hidden" name="strappno" value="<%=appno%>">
</form>
</body>
</html>
