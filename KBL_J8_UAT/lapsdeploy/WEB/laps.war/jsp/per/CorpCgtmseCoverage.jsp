<%@include file="../share/directives.jsp"%>

<%
	String strCgAppNo = Helper.correctNull((String) hshValues
			.get("isThere"));//yes or n
	String strCreatedBy = Helper.correctNull((String) hshValues
			.get("CreateBy"));
	String strCreatedOn = Helper.correctNull((String) hshValues
			.get("CreateDate"));
	String strInstalment = Helper.correctNull((String) hshValues
			.get("Instalment"));
	String strSessionModuleType = Helper.correctNull(
			(String) session.getAttribute("sessionModuleType")).trim();
	String strTotalAmount = Helper.correctNull((String) hshValues
			.get("totalamount"));
	String strowned_by_women = Helper.correctNull((String) hshValues
			.get("owned_by_women"));	
	//out.println("****==="+strowned_by_women+"*********"+Helper.correctNull((String)hshValues.get("owned_by_women")));
	
	java.text.NumberFormat nf = java.text.NumberFormat
			.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>CGTMSE Coverage</title>

</head>
<style>
.datagrids {
	background-color: #d7b3e5;
	color: #942188;
	font-weight: normal;
	border-bottom: 0px #942188 solid;
	font-size: 11px;
	text-decoration: none;
}
</style>
<script>	
var currentDate="<%=Helper.getCurrentDateTime()%>";
var varAppExist="<%=strCgAppNo%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var varCGTMSEFlag="<%=Helper.correctNull((String) hshValues
							.get("strCGTMSEFlag"))%>";
var varPreviousCover="<%=Helper.correctNull((String) hshValues
							.get("strPreviousCGTMSECover"))%>";
var varModule="<%=Helper.correctNull((String) session
							.getAttribute("sessionModuleType"))%>";
var finaced_id="<%=Helper.correctNull((String) hshValues.get("finaced_id"))%>";
var varstrSessionModuleType="<%=strSessionModuleType%>";
var CG_FlagCheck="<%=Helper.correctNull((String) hshValues
									.get("CG_FlagCheck"))%>";
var varowned_by_women="<%=Helper.correctNull((String) hshValues
							.get("owned_by_women"))%>";
var strConstitution="<%=Helper.correctNull((String) hshValues.get("PERAPP_CONSTITUTION"))%>";
var strIndividual="<%=Helper.correctNull((String) hshValues.get("indinfo_caste"))%>"; 
var promoterCaste="<%=Helper.correctNull((String) hshValues.get("promoterCaste"))%>";							
</script>
<script type="text/javascript">
function checkflagOwmen()
{
	
}
function selection()
{
	var unit_Tri_Edu= "<%=Helper.correctNull((String) hshValues.get("CG_UNIT_ENGAGED"))%>"
	var Npa="<%=Helper.correctNull((String) hshValues.get("Npa"))%>";
	var MicEntp="<%=Helper.correctNull((String) hshValues.get("MicEntp"))%>";
	var Newunit="<%=Helper.correctNull((String) hshValues.get("Newunit"))%>";
	var NewunitWO="<%=Helper.correctNull((String) hshValues.get("NewunitWO"))%>";
	var MSEunit="<%=Helper.correctNull((String) hshValues.get("MSEunit"))%>";
	var MSEunitWO="<%=Helper.correctNull((String) hshValues.get("MSEunitWO"))%>";
	var ArtisanCC="<%=Helper.correctNull((String) hshValues.get("ArtisanCC"))%>";
	var GF_ASF="<%=Helper.correctNull((String) hshValues
									.get("GF_ASF"))%>";
	var TL_MarginMoney="<%=Helper.correctNull((String) hshValues
							.get("TL_MarginMoney"))%>";

	//var AsistBank="<%=Helper.correctNull((String) hshValues.get("AsistBank"))%>";
	var MinCommuity="<%=Helper.correctNull((String) hshValues
									.get("MinCommuity"))%>";
	
	var legalId="<%=Helper.correctNull((String) hshValues.get("legalId"))%>";

	var ColSec="<%=Helper.correctNull((String) hshValues
									.get("ColSec"))%>";
	var ThirdParty="<%=Helper.correctNull((String) hshValues.get("ThirdParty"))%>";

	var JointFinance="<%=Helper.correctNull((String) hshValues
									.get("JointFinance"))%>";
	

	var HandloomScheme="<%=Helper.correctNull((String) hshValues
							.get("HandloomScheme"))%>";

	var Namescheme="<%=Helper.correctNull((String) hshValues.get("Namescheme"))%>";
	var checkBx="<%=Helper.correctNull((String) hshValues.get("checkBx"))%>";

	var NatuIndustry="<%=Helper.correctNull((String) hshValues
							.get("NatureIndustry"))%>";
	var varTypeloan="<%=Helper.correctNull((String) hshValues
							.get("CG_TYPEOFLOAN"))%>";
	var varIndustrySec="<%=Helper.correctNull((String) hshValues
							.get("IndustrySector"))%>";
	var Sno="<%=Helper.correctNull((String) hshValues
							.get("strFacilitySno"))%>";
	var PrevCGTMSE="<%=Helper.correctNull((String) hshValues.get("PrevCGTMSE"))%>";
	var varAppDetNPA="<%=Helper.correctNull((String) hshValues
							.get("CG_APPDET_NPA"))%>";	
	var varFirstCharge="<%=Helper.correctNull((String) hshValues
							.get("CG_FIRSTCHARGE"))%>";	
	var varCG_INTERNAL_RATING="<%=Helper.correctNull((String) hshValues
							.get("CG_INTERNAL_RATING"))%>";
	var varCG_DEFAULTER="<%=Helper.correctNull((String) hshValues
									.get("CG_DEFAULTER"))%>";
	var sel_Existing="<%=Helper.correctNull((String) hshValues
									.get("CG_Existing"))%>";
	var Namescheme="<%=Helper.correctNull((String) hshValues.get("Namescheme"))%>";
	var varEducation="<%=Helper.correctNull((String) hshValues
									.get("CG_EDUCATION"))%>";
	var varNCGTC="<%=Helper.correctNull((String) hshValues.get("CG_NCGTC"))%>";
	var varLoanType="<%=Helper.correctNull((String) hshValues
									.get("CG_LOANTYPE"))%>";
	var SocialCatgry="<%=Helper.correctNull((String) hshValues
									.get("SocialCatgry"))%>";
	var varConstitution="<%=Helper.correctNull((String) hshValues
							.get("CG_CONSTITUTION"))%>";
	if(SocialCatgry!="")
		{					    
		document.forms[0].SocialCatgry.value=SocialCatgry;						
		}
	
	if(varowned_by_women!="")
	{
		document.forms[0].NewunitWO.value=varowned_by_women;
	}
	if(CG_FlagCheck=="Y")
	{
		PrevCGTMSE="Y";
	}	
	if(Namescheme!="")
	{
		document.forms[0].Namescheme.value=Namescheme;
	}
	/*if(legalId!="")
	{
		document.forms[0].legalId.value=legalId;
	}*/
	
	if(NatuIndustry!="")
		{
		    //alert("SSS1"+NatuIndustry);
			document.forms[0].NatureIndustry.value=NatuIndustry;
			//alert("NatureIndustry"+document.forms[0].NatureIndustry.value);
		}
	if(varTypeloan!="")
	{
		document.forms[0].TypeOfActivity.value=varTypeloan;
		//alert("SSS"+varTypeloan);
		//alert("TypeOfActivity"+document.forms[0].TypeOfActivity.value);
		
	}
	if(varIndustrySec!="")
	{
		//alert("lolol"+varIndustrySec);
		document.forms[0].IndustrySector.value=varIndustrySec;
		//alert("IndustrySector"+document.forms[0].IndustrySector.value);
	}
	
	/*if(AsistBank=="Y")
	{
		document.forms[0].AsistBank[1].selected=true;
	}
	else if(AsistBank=="N")
	{
		document.forms[0].AsistBank[2].selected=true;
	}*/
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
	/*if(varAppDetNPA=="Y")
	{
		document.forms[0].sel_npa[1].selected=true;
	}
	else if(varAppDetNPA=="N")
	{
		document.forms[0].sel_npa[2].selected=true;
	}*/
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
	if(varEducation=="Y")
	{
		document.forms[0].sel_Treagri[1].selected=true;
	}
	else if(varEducation=="N")
	{
		document.forms[0].sel_Treagri[2].selected=true;
	}
	if(varNCGTC=="Y")
	{
		document.forms[0].NewNCGTC[1].selected=true;
	}
	else if(varNCGTC=="N")
	{
		document.forms[0].NewNCGTC[2].selected=true;
	}
	/* if(varLoanType!="")
	{
		document.forms[0].sel_Loantype.value=varLoanType;
	} */
	if(varConstitution!="")
	{
		document.forms[0].sel_Constitution.value=varConstitution;
	}
	
	getindustryValues(varTypeloan);
	
	
	if(unit_Tri_Edu!=""){
		document.forms[0].unit_engaged.value=unit_Tri_Edu;
	}
	gettypeact(varIndustrySec);
}
function callCalender1(name)
{	
		showCal(appURL,name);
}
	

	function doEdit() 
	{
		if(document.forms[0].sel_facilitysno.value=="" || document.forms[0].sel_facilitysno.value=="0")
		{
			alert("Select Facility");
			return;
		}
		var var_AadharNo="<%=Helper.correctNull((String) hshValues
							.get("UdyogAadharNo"))%>";
		if(var_AadharNo=="")
		{
			alert("Please fill Udyog Aadhaar Number in Customer Profile");	
			return false;
		}
		var var_total_employees="<%=Helper.correctNull((String) hshValues
							.get("cominfo_total_employees"))%>";
		if(var_total_employees=="")
		{
			alert("Please fill Total Employees in Customer Profile");	
			return false;
		}
		var var_PERAPP_CONSTITUTION="<%=Helper.correctNull((String) hshValues
							.get("PERAPP_CONSTITUTION"))%>";
		if(var_PERAPP_CONSTITUTION!="01")
		{
			var var_indinfo_minority="<%=Helper.correctNull((String) hshValues
							.get("indinfo_minority"))%>";
			if(var_indinfo_minority=="")
			{
				alert("Please fill Whether majority of members/owners belong to minority community in Customer Profile");	
				return false;
			}
		}
		callDisable(false);
		disableControls(true,false,false,false,true,true);
		document.forms[0].txt_ourbankcover.readOnly=true;
		//document.forms[0].availamt_gurantee.readOnly=true;
		//document.forms[0].LegalIdNo.readOnly=true;
		document.forms[0].NoEmp.readOnly=true;
		var varCGPan="<%=Helper.correctNull((String) hshValues.get("PrevCGPan"))%>";
		var varCGPan_fixed="<%=Helper.correctNull((String) hshValues
							.get("PrevCGPan_Fix"))%>";
		document.forms[0].NewunitWO.disabled=true;
		
		if(varCGPan!="")
		{
			var temp= varCGPan.split("@");
			var tempval= varCGPan_fixed.split("@");
			var valuerlen=temp.length;
			var varlen=tempval.length;
			for(var j=0;j<varlen;j++)
			{
				for(var i=0;i<valuerlen;i++)
				{
					 if(temp[i]==undefined){temp[i]="";}
					// alert(tempval[j]+"=="+temp[i]);
					 if(tempval[j]==temp[i])
					 {
						 document.forms[0].chks[i].disabled=true;
						 document.forms[0].PrevCGPan[i].readOnly=true;
					 }
				 }
			}
		}
		 document.forms[0].MicEntp.disabled=true;
		 document.forms[0].unit_engaged.disabled=false;
	}

	function doCancel()
	{

		if(ConfirmMsg('102'))
		{
			document.forms[0].action=appURL+"action/CorpCgtmseCoverage.jsp";
			document.forms[0].hidBeanId.value = "supuser";
			document.forms[0].hidBeanGetMethod.value = "getCropCgtmse";
			document.forms[0].submit();
		}
		
		
	}
	function callonLoad()
	{		

		
		
			var facilityload="<%=Helper.correctNull((String) hshValues.get("facility"))%>";
			var facilityNature="<%=Helper.correctNull((String) hshValues
							.get("FacilityNature"))%>";
			var facilityCgtmse="<%=Helper.correctNull((String) hshValues
							.get("FacilityCgtmse"))%>";
			document.forms[0].sel_facilitysno.value=facilityload;
			var varsoccatageory="<%=Helper.correctNull((String) hshValues
									.get("CG_Existing"))%>";
			var NatuIndustry="<%=Helper.correctNull((String) hshValues
										.get("NatureIndustry"))%>";
			var varTypeloan="<%=Helper.correctNull((String) hshValues
										.get("CG_TYPEOFLOAN"))%>";
			var varIndustrySec="<%=Helper.correctNull((String) hshValues
										.get("IndustrySector"))%>";
			
		callDisable(true);
		if(document.forms[0].sel_facilitysno.value=="" || document.forms[0].sel_facilitysno.value=="0")
		{
			disableControls(true,true,true,true,false);
		}
		if(facilityCgtmse=="Y")
		{
			document.forms[0].cmdsave.disabled=false;
			Totalvalue();
			disableControls(false,true,true,true,false);
		}
	
		if((facilityCgtmse=="N")||(facilityCgtmse==""))
		{
			disableControls(true,true,true,true,false);
			if(document.forms[0].sel_facilitysno.value!="" && document.forms[0].sel_facilitysno.value!="0")
			{
				alert("This Facility does not cover under CGTMSE!");
				//callIFrame();
			}
			document.forms[0].sel_facilitysno.value='0';
		}
		if(facilityNature=="2" || facilityNature=="OD")
		{
			/*document.all.WcClass.style.visibility="hidden";
			document.all.WcClass.style.position="absolute";*/

			/*document.all.crdt.style.visibility="hidden";
			document.all.crdt.style.position="absolute";*/
			
			document.all.wcs.style.display="table-cell";

			document.all.tcs.style.display="none";
			document.all.tpo.style.display="none";
			document.all.tcp.style.display="none";	

		}
		if(facilityNature=="1" || facilityNature=="TL" || facilityNature=="DL")
		{
			/*document.all.TermLoanDet.style.visibility="hidden";
			document.all.TermLoanDet.style.position="absolute";*/

			document.all.tcs.style.display="table-row";
			
			document.all.tpo.style.display="table-row";
                                                                                                                                                                                       
			document.all.tcp.style.display="table-row";

			document.all.wcs.style.display="none";

		}		
		
		document.forms[0].sel_facilitysno.disabled=false;

		window.opener.document.forms[0].hidCGTMSE.value=varCGTMSEFlag;

		disableControls(false,true,true,true,false);
		//document.forms[0].cmdGenerateReport.disabled=false;
		//document.forms[0].cmdFinancialData.disabled=false;

		if(document.forms[0].btnenable.value=="N")
		{
			disableControls(true,true,true,true,false);
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
  
   var facilityNature="<%=Helper.correctNull((String) hshValues
							.get("FacilityNature"))%>";
	if(document.forms[0].sel_cgtmse_defaulter.value=="")
	{
		ShowAlert("112","Any of the Promoter(s)/Directors/Key management personnel in the CRILC/CIBIL/RBI list of defaulters ");
		document.forms[0].sel_cgtmse_defaulter.focus();
		return false;
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
	if(document.forms[0].ProjOptiSales.value=="")
	{
		ShowAlert(121,"Projected Optimum Sales/Turnover/Income/Receipt");
		document.forms[0].ProjOptiSales.focus();
		return;
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
	/*if(document.forms[0].AsistBank.value=="")
	{
		ShowAlert(111,"Whether borrower already assisted by bank");
		document.forms[0].AsistBank.focus();
		return;
	}*/
	if(document.forms[0].sel_Existing.value=="0")
	{
		ShowAlert(111,"Guarantee Amount wise financial Record Unit");
		document.forms[0].sel_Existing.focus();
		return;
	}
	

	if(document.forms[0].NatureIndustry.value=="")
	{
		ShowAlert(111," Nature of Industry ");
		document.forms[0].NatureIndustry.focus();
		return;
	}
	

	if(document.forms[0].IndustrySector.value==""||document.forms[0].IndustrySector.value=="s")
	{
		ShowAlert(111,"Industry Sector ");
		document.forms[0].IndustrySector.focus();
		return;
	}
	if(document.forms[0].TypeOfActivity.value==""||document.forms[0].TypeOfActivity.value=="s")
	{
		ShowAlert(111,"Type of Activity ");
		document.forms[0].TypeOfActivity.focus();
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

	/*if(document.forms[0].MinCommuity.value=="")
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
	}*/


	if(document.forms[0].Newunit.value=="")
	{
		ShowAlert(111,"Whether unit assisted is an new unit");
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
		ShowAlert(111,"Whether the Unit Assisted is a Micro Enterprise as per the MSMED Act 2006");
		document.forms[0].MSEunitWO.focus();
		return;
	}
	if(document.forms[0].selfirstcharge.value=="")
	{
		ShowAlert(111,"Whether first charge on Primary Securities is available");
		document.forms[0].selfirstcharge.focus();
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

	/*if(document.forms[0].legalId.value=="O")
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
	}*/

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
			document.forms[0].Namescheme.focus();
			return;
		}
			
	if(document.forms[0].PrevCGTMSE.value=="")
	{		
			ShowAlert(111,"Whether Borrower Covered by CGTMSE previously!");
			document.forms[0].PrevCGTMSE.focus();
			return;
	}

	if(varPreviousCover=="Y" && document.forms[0].PrevCGTMSE.value=="N")
	{
		alert(" Borrower Previously Covered under CGTMSE, so it should not be No.");
		document.forms[0].PrevCGTMSE.value="";
		document.forms[0].PrevCGTMSE.focus();
		return;
	}
	
	  
	if(document.forms[0].PrevCGTMSE.value=="Y")
	{
		if(document.forms[0].PrevCGPan.length==undefined)
		{
			if(document.forms[0].PrevCGPan.value=="")
			{
				ShowAlert(121,'Previous CGPAN!');
				document.forms[0].PrevCGPan.focus();
				return;
			}
		}
		else
		{
			for(var i=0;i<document.forms[0].PrevCGPan.length;i++)
			{
				if(document.forms[0].PrevCGPan[i].value=="")
				{
					ShowAlert(121,'Previous CGPAN!');
					document.forms[0].PrevCGPan[i].focus();
					return;
				}
		
			}
		}
	}

	if(document.forms[0].HandloomScheme.value=="Y")
	{
		if(document.forms[0].checkBx.checked==false)
		{
		ShowAlert(111,"Verify Whether the credit is sanctioned under DC (Handloom) scheme for Handloom Weavers!");
		document.forms[0].checkBx.focus();
		return;
		}
	}

	if(facilityNature=="1" || facilityNature=="TL" || facilityNature=="DL")
	{

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
		}*/
		/*if(document.forms[0].TL_DtLstDisbursment.value=="")
		{
			ShowAlert(121,"Date of last Disbursment!");
			document.forms[0].TL_DtLstDisbursment.focus();
			return;
		}*/
	}
	if(facilityNature=="2" || facilityNature=="OD")    	 
	{
		/*if(document.forms[0].OutsdNonFundBased.value=="")
		{
			ShowAlert(121,"Outstanding Non Fund Based");
			document.forms[0].OutsdNonFundBased.focus();
			return;
		}*/

		/*if(document.forms[0].OutsdFundBased.value=="")
		{
			ShowAlert(121,"OUTSTANDING FUND BASED!");
			document.forms[0].OutsdFundBased.focus();
			return;
		}*/

		/*if(document.forms[0].CrdtNonFundBased.value=="")
		{
			ShowAlert(121,"Credit Non Fund Based!");
			document.forms[0].CrdtNonFundBased.focus();
			return;
		}*/
		/*if(document.forms[0].CrdtFundBased.value=="")
		{
			ShowAlert(121,"Credit FundBased!");
			document.forms[0].CrdtFundBased.focus();
			return;
		}*/
		if(document.forms[0].WC_Assesse.value=="")
		{
			ShowAlert(121,"Working Capital Assessed!");
			document.forms[0].WC_Assesse.focus();
			return;
		}
		if(document.forms[0].TL_MarginMoney.value=="")
		{
			ShowAlert(111,"Margin Money!");
			document.forms[0].TL_MarginMoney.focus();
			return;
		}
	}

	/*if(document.forms[0].AsistBank.value=="Y")
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
	}*/
	/* if(document.forms[0].sel_Loantype.value=="")
	{
		ShowAlert(121,"Loan Type");
		document.forms[0].sel_Loantype.focus();
		return;
	} */
	/* if(document.forms[0].sel_Constitution.value=="")
	{
		ShowAlert(121,"Constitution");
		document.forms[0].sel_Constitution.focus();
		return;
	} */
	if(document.forms[0].sel_Treagri.value=="")
	{
		ShowAlert(111,"Training/Education/Agriculture");
		document.forms[0].sel_Treagri.focus();
		return;
	}
	if(document.forms[0].NewNCGTC.value=="")
	{
		ShowAlert(111,"NCGTC Mudra Guarantee Program");
		document.forms[0].NewNCGTC.focus();
		return;
	}
	checkParamVal();
	
document.forms[0].cmdsave.disabled = true;

	document.forms[0].hidAction.value = "insert";
	document.forms[0].hidBeanId.value = "supuser";
	document.forms[0].hidSourceUrl.value = "/action/CorpCgtmseCoverage.jsp";
	document.forms[0].hidBeanMethod.value = "updateCropCgtmse";	
	document.forms[0].hidBeanGetMethod.value = "getCropCgtmse";
	document.forms[0].action = appURL + "controllerservlet";
	document.forms[0].submit();
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
/*function leglOthr()
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
}*/

function callIFrame()
{	
	var facilityCgtmse="<%=Helper.correctNull((String) hshValues
							.get("FacilityCgtmse"))%>";
	document.forms[0].hidBeanId.value = "supuser";

	document.forms[0].hidBeanGetMethod.value = "getCropCgtmse";

	document.forms[0].action = appURL + "action/CorpCgtmseCoverage.jsp";

	document.forms[0].submit();
	if(document.forms[0].sel_facilitysno.value=="")
	{
		disableControls(true,true,true,true,true);
	}
	
	if(facilityCgtmse=="Y")
	{
		disableControls(false,true,true,true,false);
	}
	else
	{
		disableControls(true,true,true,true,true);
	}

}

function PreCGpan()
{ 
	/* if(document.forms[0].PrevCGTMSE.value=="" || document.forms[0].PrevCGTMSE.value=="N" )
	 {
		document.forms[0].PrevCGPan.value="";
	 }*/
	
	if(CG_FlagCheck=="Y" && document.forms[0].PrevCGTMSE.value=="N")
	{
		alert("One of the facilities of the proposal is covered under CGTMSE hence value cannot be changed to NO");
		document.forms[0].PrevCGTMSE[1].selected=true;
		return;
	}
	if(document.forms[0].PrevCGTMSE.value=="Y")
	{ 
		
		document.all.prvcgpan.style.display="table-row";
		//document.all.idAvailAmt.style.display="table-row";
		document.all.prvcgtmse1.style.display="table-row";
		document.all.prvcgtmse2.style.display="table-row";
		
		
	}
	else
	{
		document.all.prvcgpan.style.display="none";
		//document.all.idAvailAmt.style.display="none";
		document.all.prvcgtmse1.style.display="none";
		document.all.prvcgtmse2.style.display="none";
		
	}
}

function doGenerateReport()
{ 	var facilityCgtmse="<%=Helper.correctNull((String) hshValues
							.get("FacilityCgtmse"))%>";

	if(document.forms[0].sel_facilitysno.value=="" || document.forms[0].sel_facilitysno.value=="0")
	{
		alert("Select Facility");
		return;
	}
	var varAadharNo="<%=Helper.correctNull((String) hshValues
							.get("UdyogAadharNo"))%>";
	if(document.forms[0].sel_facilitysno.value=="" || document.forms[0].sel_facilitysno.value=="0")
	{
		return;
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

function doCgtmseFinancialData()
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
/*function callOutstandAmt()
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
		
}*/
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
/*function CgactivityEnable()
{
	if(document.forms[0].JointFinance.value!="")
	{
		document.all.idCgactivity.style.visibility="visible";
		document.all.idCgactivity.position="relative";
	}
	else
	{
		document.all.idCgactivity.style.visibility="hidden";
	    document.all.idCgactivity.position="absolute";
	}
}*/
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
		document.forms[0].hidSourceUrl.value = "/action/CorpCgtmseCoverage.jsp";
		document.forms[0].hidBeanMethod.value = "updateCropCgtmse";	
		document.forms[0].hidBeanGetMethod.value = "getCropCgtmse";
		document.forms[0].action = appURL + "controllerservlet";
		document.forms[0].submit();
	}
	
	
}


 function getindustryValues(val)
{
    var varnatureindustry=document.forms[0].NatureIndustry.value;
	document.all.ifrm.src=appURL+"action/ifrmmastervalnew.jsp?hidBeanGetMethod=getStatMasterValues&hidBeanId=facilities&strMastID=283&strMastVal="+varnatureindustry+"&strObjectName=TypeOfActivity+&strVal="+val;
}
 function gettypeact(val)
{   
	var vartypeactivity=document.forms[0].TypeOfActivity.value;
	document.all.ifrm1.src=appURL+"action/ifrmmastervalnew.jsp?hidBeanGetMethod=getStatMasterValues&hidBeanId=facilities&strMastID=211&strMastVal="+vartypeactivity+"&strObjectName=IndustrySector+&strVal="+val;
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
 var varParamVal="<%=Helper.correctNull((String) hshValues
									.get("strParamVal"))%>";
	var varcgAmt= document.forms[0].txt_cgtmse_coverage.value;
	var ourbankCov= document.forms[0].txt_ourbankcover.value;
	var totalcov=eval(varcgAmt)+eval(ourbankCov);
	var remainingbalance=eval(varParamVal)-eval(totalcov);
	//document.forms[0].availamt_gurantee.value=remainingbalance;
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

function CibilrankVal()
{
	 if(eval(document.forms[0].cgtmse_cibil_msme_rank.value)<=0)
		{
			ShowAlert("112","CIBIL MSME Rank of the firm value between 1 and 10 ");
			document.forms[0].cgtmse_cibil_msme_rank.value="";
			document.forms[0].cgtmse_cibil_msme_rank.focus();
			return false;
		} else if(eval(document.forms[0].cgtmse_cibil_msme_rank.value)>=11)
		{
			ShowAlert("112","CIBIL MSME Rank of the firm value between 1 and 10 ");
			document.forms[0].cgtmse_cibil_msme_rank.value="";
			document.forms[0].cgtmse_cibil_msme_rank.focus();
			return false;
		}
}
function placeSocialCategory()
{
	//alert(promoterCaste);
	   if(strConstitution != "")
	   {
		   if(strConstitution == "01")
		   {
		       if(strIndividual == "001")
		       {
		    
		    	document.forms[0].SocialCatgry.value=strIndividual;
		       }
		   }
		   else 
		   {
			    if(promoterCaste == "01" )
			    {
			         if(promoterCaste == "001")
			         {
			    	document.forms[0].SocialCatgry.value=promoterCaste;
			         }
		        }
	        }
     }
	
} 
function chkCategory(){
	   if(strConstitution != "")
	   {
		 if(strConstitution == "01")
		 {      
		    if(strIndividual == "001")
		    {
		    	document.forms[0].SocialCatgry.value=strIndividual; 	
		    }
		  }
		   else
		   {
		      if(promoterCaste == "001")
		      {			    	
		    	document.forms[0].SocialCatgry.value=promoterCaste;		    
		      }
		   }
		
		 var category=document.forms[0].SocialCatgry.value;
		 
		 if((strIndividual == "001" || promoterCaste == "001") && category!="")
		 {
			 if(category!="001"){
				 alert("Social category is not matched with Customer Profile.Kindly choose correctly!!!");
				 document.forms[0].SocialCatgry.value="";
				 return;
			 }
		 }
		 
	   }
}
<%--CgactivityEnable();--%>
</script>
<body
	onload="callonLoad(); selection();selScheme();PreCGpan();  CgpanEnable();IdCardEnable(); placeSocialCategory()">
<form class="normal" method="post">
<h1><%=strInstalment%></h1>
<!--<span style="display:none;"><lapschoice:borrowertype /></span> --> <lapschoice:application />

<table width="95%" border="1" cellspacing="0" cellpadding="3"
	class="outertable" align="center"
	style="margin-left: 20px; margin-right: 20px; margin-top: 5px;">
	<tr>
		<td>
		<table class="outertable" width="100%" border="0" cellspacing="0"
			cellpadding="3" align="center">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable" align="center">
					<%
						if (Helper.correctNull(
								(String) session.getAttribute("sessionModuleType"))
								.equalsIgnoreCase("RET")) {
					%>
					<input type="hidden" name="sel_facilitysno" value="1">
					<%
						} else {
					%>
					<tr>
						<td colspan="2">Facility &nbsp; &nbsp;<select
							name="sel_facilitysno" onchange="callIFrame();" id="sel_fac">
							<option value="0">--Select--</option>
							<lapschoice:ComMisDetailsTag
								apptype='<%=Helper.correctNull((String) request
								.getParameter("appno"))%>'
								page='CGTMSE' />
						</select></td>
						<td></td>
					</tr>
					<%
						}
					%>
					<tr class="dataheader">
						<td style="text-align: center" colspan="2">Borrower Details</td>
						<td></td>
					</tr>

					<tr>
						<td width="60%">CGPAN</td>
						<td width="40%"><%=Helper.correctNull((String) hshValues.get("CGPan"))%></td>
					</tr>
					<tr>
						<td width="60%">MSE Registration Number</td>
						<td width="40%"><%=Helper.correctNull((String) hshValues.get("MSERegNo"))%></td>
					</tr>
					<tr>
						<td width="60%">Udyog Aadhaar Number(12 Digits)</td>
						<td width="40%"><%=Helper.correctNull((String) hshValues
							.get("UdyogAadharNo"))%></td>
					</tr>
					<tr>
						<td width="60%">Guarantee Amount wise financial Record Unit</td>
						<td width="40%"><select name="sel_Existing">
							<option value="0">---select--</option>
							<option value="1">Existing</option>
							<option value="2">Green Field Unit</option>

						</select></td>
					</tr>
					<!-- <tr>
						<td width="60%">Type of Loan</td>
						<td width="40%"><select name="sel_Loantype">
							<option value="0">---select--</option>
							<option value="1">Term Loan</option>
							<option value="2">Working Capital Limit</option>
							<option value="3">Enhancement in WC</option>
							<option value="4">Renewal of Cover for WC</option>

						</select></td>
					</tr> -->
					<!--  <tr>
		<td width="60%">Whether borrower already assisted by bank</td>
		<td width="40%"><select name="AsistBank" onchange="callOutstandAmt();">
			<option value="" selected>---select--</option>
			<option value="Y">Yes</option>
			<option value="N">No</option>

		</select></td>
	</tr> -->
					<!--  <tr id="idOutsamt">
	<td width="60%">Outstanding amount on date of sanction of credit facility</td>
	<td width="40%"><input type="text" style="text-align: right;"  name="Outstand_Amt" value="<%=Helper.correctNull((String) hshValues
							.get("CG_APPDET_OUTSTAN_AMT"))%>" onKeyPress="allowDecimals(this);" onBlur="roundtxt(this);" maxlength="20"></td>
	</tr>
	<tr id="idAsistNpa"><td width="60%">NPA</td><td width="40%"><select name="sel_npa" onchange="validate(this,'N');">
	<option value="">--select--</option>
	<option value="Y">Yes</option>
	<option value="N">No</option>
	</select>
	</td>
	</tr>  -->
					<tr>
						<td width="60%">Whether the unit Assisted is a Micro
						Enterprise and Guarantee cover is within Rs.5 lakh cap<span
							class="mantatory"> * </span></td>
						<td width="40%"><select name="MicEntp"
						      onchange="validate(this,'Y');">
							<option value="" selected="selected">---select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>

						</select></td>
					</tr>

					  <tr>
						<td width="60%">Nature of Industry</td>
						<td width="40%"><select name="NatureIndustry"  tabindex="17" onchange="getindustryValues('');" >
							<option value="">---select---</option>
							<lapschoice:StaticDataNewTag apptype="210" />
						</select></td>
					</tr>
					<tr>
						<td width="60%">Type of Activity</td>
						<td width="40%"><select name="TypeOfActivity"  tabindex="17"
							onchange="gettypeact('');">
							<option value="">---select---</option>
							<lapschoice:StaticDataNewTag apptype="283" />
						</select></td>


					</tr>
					<tr>
						<td width="60%">Industry Sector</td>
						<td width="40%"><select name="IndustrySector"  tabindex="17">
							<option value="">---select---</option>
							<lapschoice:StaticDataNewTag apptype="211" />
						</select></td>
					</tr>  
					<tr>
						<td width="60%">Number of Employees</td>
						<td width="40%"><input type="text" name="NoEmp"
							maxlength="20"
							value="<%=Helper.correctNull((String) hshValues
							.get("cominfo_total_employees"))%>"
							onkeypress="allowInteger();"></td>
					</tr>

					<tr>
						<td width="60%">Whether unit is engaged in
						Training/Education/Agriculture</td>
						<td width="40%"><select name="sel_Treagri"
							onchange="validate(this,'N');">
							<option value="">--select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
					</tr>

					<tr>
						<td width="60%">Projected Optimum
						Sales/Turnover/Income/Receipt</td>
						<td width="40%"><input type="text" style="text-align: right;"
							name="ProjOptiSales" onKeyPress="allowDecimals(this);"
							onBlur="roundtxt(this);" maxlength="20"
							value="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("ProjOptiSales"))))%>"></td>
					</tr>


					<tr>
						<td width="60%">Projected Optimum Exports</td>
						<td width="40%"><input type="text" style="text-align: right;"
							name="ProjOptiExport" onKeyPress="allowDecimals(this);"
							onBlur="roundtxt(this);" maxlength="20"
							value="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("ProjOptiExport"))))%>"></td>
					</tr>
					<tr>
						<td width="60%">Whether Borrower Covered by CGTMSE previously</td>
						<td width="20%" colspan="2"><select name="PrevCGTMSE"
							onchange="PreCGpan();">
							<option value="" selected>---select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>

						</select></td>
						<td width="20%"></td>
					</tr>
					<tr id="prvcgpan">
						<td width="60%" valign="top">CGPAN Previous <span
							style="text-align: right"><a onClick="Addvaluer1();"><img
							src="<%=ApplicationParams.getAppUrl()%>img/add.png" border="0"></a>&nbsp;&nbsp;&nbsp;
						<a onClick="deleteRow1('idCGPAN','0');"><img
							src="<%=ApplicationParams.getAppUrl()%>img/cancel.png" width="10"
							height="10" border="0"></a></td>
						<td width="20%" colspan="2">
						<table width="100%" border="0" cellspacing="0" cellpadding="2"
							id="idCGPAN">
							<tr align="center" id="0">
								<td align="left"><input type="checkbox" name="chks"
									style="border: none;"> <input type="text"
									name="PrevCGPan" size="25"
									value="<%=Helper.correctNull((String) hshValues.get("PrevCGPan1"))%>"
									maxlength="30" onkeypress="allowAlphabetsAndSpaceInt(this)"></td>

							</tr>
						</table>
						<!-- <input type="text"  name="PrevCGPan"  value="<%=Helper.correctNull((String) hshValues.get("PrevCGPan"))%>"></td> -->
						<td width="20%"></td>
					</tr>
					<tr id="prvcgtmse1">
						<td width="60%">Our bank CGTMSE Coverage of the Borrower</td>
						<td width="40%"><input type="text" style="text-align: right;"
							name="txt_ourbankcover"
							value="<%=Helper.correctDouble((String) hshValues
							.get("dblCGTMSECover"))%>">&nbsp;</td>
					</tr>
					<tr id="prvcgtmse2">
						<td width="60%">Other bank CGTMSE Coverage of the Borrower</td>
						<td width="40%"><input type="text" style="text-align: right;"
							name="txt_cgtmse_coverage" onKeyPress="allowDecimals(this);"
							onBlur="checkParamVal();roundtxt(this);" maxlength="20"
							value="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("CG_CGTMSE_COVERAGE"))))%>"></td>
					</tr>
					<!--  <tr id="idAvailAmt">
		<td width="60%">Balance Amount available for Guarantee</td>
		<td width="20%" colspan="2"><input type="text" style="text-align: right;" name="availamt_gurantee" value="<%=Helper.correctNull((String) hshValues
							.get("CG_HANDICRAFT_AVAIL_AMT"))%>" onKeyPress="allowDecimals(this);" onBlur="roundtxt(this);" maxlength="20"></td>
		<td width="20%"></td>
	</tr> -->
					<!-- <tr>
						<td width="60%">Constitution</td>
						<td width="40%"><select name="sel_Constitution">
							<option value="0">---select--</option>
							<option value="1">Proprietary/Individual</option>
							<option value="2">Partnership Firm</option>
							<option value="3">Limited liability Partnership</option>
							<option value="4">Private Ltd.</option>
							<option value="5">Public Ltd.</option>
							<option value="6">Hindu Undivided Family</option>
							<option value="7">Trust</option>
							<option value="8">Society/Co op Society</option>

						</select></td>
					</tr> -->
					<tr>
						<td width="60%">Internal Rating</td>
						<td width="40%"><select name="sel_internalRating" id="">
							<option value="" selected>---select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
					</tr>
					<tr>
						<td width="60%">Is any of the Promoter(s)/Directors/Key
						management personnel in the CRILC/CIBIL/RBI list of defaulters ?<span
							class="mantatory"> * </span></td>
						<td width="40%"><select name="sel_cgtmse_defaulter">
							<option value="" selected>---select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
					</tr>

					<tr>
						<td width="60%">CIBIL MSME Rank of the firm value between 1
						and 10</td>
						<td width="20%" colspan="2"><input type="text"
							style="text-align: right;" name="cgtmse_cibil_msme_rank"
							onBlur="CibilrankVal();"
							value="<%=Helper.correctNull((String) hshValues
							.get("CG_CIBIL_MSME_RANK"))%>"
							maxlength="2"></td>
					</tr>
					<tr>
						<td width="60%">Repayments due within an Year in Rs Lakhs</td>
						<td width="20%" colspan="2"><input type="text"
							style="text-align: right;" name="cgtmse_rep_year"
							value="<%=Helper.correctNull((String) hshValues
							.get("CG_REPAY_YEAR"))%>"
							onKeyPress="allowDecimals(this);" onBlur="roundtxt(this);"
							maxlength="20"></td>
					</tr>
				</table>

				</td>
			</tr>

			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable" align="center">
					<tr class="dataheader" style="display: none;">
						<td style="text-align: center" colspan="3">Promoters Details</td>
						<td></td>
						<td></td>
					</tr>
					<tr style="display: none;">
						<td width="60%">Whether the chief Promoter/Individual belongs
						to Minority Community</td>
						<td width="20%" colspan="2"><select name="MinCommuity">
							<option value="" selected>---select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>

						</select></td>
						<td width="20%"></td>
					</tr>
					<tr>
						<td width="60%">Social Category</td>
						<td width="20%" colspan="2"><select name="SocialCatgry" onchange="chkCategory()" >
							<option value="" selected>---select--</option>
							<lapschoice:StaticDataTag apptype="242" />
						</select></td>
						<td width="20%"></td>
					</tr>
					
					
					<tr><td>Whether unit is engaged in Training/Education/Agriculture</td>
					<td width="20%" colspan="2"><select name="unit_engaged" disabled onchange="validate(this,'N');">
							<option value="" selected>---select--</option>
							<option value="Y" >Yes</option>
							<option value="N" >No</option>
							</select></td>
						<td width="20%"></td>
					<td></td>
					</tr>
					<!-- <tr>
						<td width="60%">Social Category</td>
						<td width="20%" colspan="2"><select name="SocialCatgry">
							<option value="" selected>---select--</option>
							<lapschoice:StaticDataTag apptype="242" />
						</select></td>
						<td width="20%"></td>
					</tr>  -->
					<!--  <tr>
		<td width="60%">Legal ID</td>
		<td width="20%" colspan="2">
			<select name="legalId" onchange="leglOthr();">
			<option value="" selected>---select--</option>
			<lapschoice:StaticDataTag apptype="54" />

			</select>
		</td >
		<td width="20%" id="idDiv" style="margin-left:-25px;" nowrap="nowrap">ID No<input type="text" style="text-align: right;"  name="LegalIdNo"  maxlength="20" value="<%=Helper.correctNull((String) hshValues.get("LegalIdNo"))%>" onkeypress="allowAlphaNumeric()"></td>
		
	</tr>
	
	<tr id="othrID" >
		<td width="60%">(Other ID) Please specify</td>
		<td width="20%" colspan="2"><input type="text" style="text-align: right;"  name="OtherIDName" onkeypress="allowAlphabets();" maxlength="20" value="<%=Helper.correctNull((String) hshValues
									.get("OtherIDName"))%>"></td>
		<td width="20%" nowrap="nowrap">ID No<input type="text" style="text-align: right;"  name="OtherIDNo"  maxlength="20" value="<%=Helper.correctNull((String) hshValues.get("OtherIDNo"))%>" onkeypress="allowAlphaNumeric()"></td>
	</tr> -->
					<tr class="dataheader">
						<td style="text-align: center" colspan="3">Project Details
						Outlay</td>
						<td></td>
						<td></td>
					</tr>

					<tr>
						<td width="60%">Whether unit assisted is an new unit</td>
						<td width="20%" colspan="2"><select name="Newunit">
							<option value="" selected>---select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>

						</select></td>
						<td width="20%"></td>
					</tr>

					<tr>
						<td width="60%">Whether the unit is Women Operated and/or
						Women Owned</td>
						<td width="20%" colspan="2"><select name="NewunitWO"
							onchange="checkflagOwmen()">
							<option value="" selected>---select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>

						</select></td>
						<td width="20%"></td>
					</tr>

					<tr>
						<td width="60%">Whether the credit facility is covered under
						NCGTC Mudra Guarantee Program</td>
						<td width="20%" colspan="2"><select name="NewNCGTC"
							onchange="validate(this,'N');">
							<option value="">--select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
						<td width="20%"></td>
					</tr>

					<tr>
						<td width="60%">Whether the Unit Assisted is an MSE as per the MSMED Act 2020</td>
						<td width="20%" colspan="2"><select name="MSEunit"
							onchange="validate(this,'Y');">
							<option value="" selected>---select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>

						</select></td>
						<td width="20%"></td>
					</tr>
					<tr>
						<td width="60%">Whether the Unit Assisted is a Micro
						Enterprise as per the MSMED Act 2006</td>
						<td width="20%" colspan="2"><select name="MSEunitWO">
							<option value="" selected>---select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>

						</select></td>
						<td width="20%"></td>
					</tr>
					<tr>
						<td width="60%">Whether first charge on Primary Securities is
						available</td>
						<td width="20%" colspan="2"><select name="selfirstcharge"
							onchange="validate(this,'Y');">
							<option value="" selected>---select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>

						</select></td>
						<td width="20%"></td>
					</tr>

					<tr>
						<td width="60%">Collateral Security Taken</td>
						<td width="20%" colspan="2"><select name="ColSec"
							onchange="validate(this,'N')">
							<option value="N" selected>NO</option>
						</select></td>
						<td width="20%"></td>
					</tr>
					<tr>
						<td width="60%">Third Party Guarantee</td>
						<td width="20%" colspan="2"><select name="ThirdParty"
							onchange="validate(this,'N')">
							<option value="N" selected>NO</option>
						</select></td>
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
					<tr class="dataheader" style="text-align: center;">
						<td colspan="2">Joint Finance</td>
						<td></td>
					</tr>
					<tr>
						<td width="60%">Whether the credit is sanctioned under Joint
						Finance scheme:</td>
						<td width="40%"><select name="JointFinance"
							onchange="CgpanEnable();">
							<option value="" selected>---select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
					</tr>
					<tr id="idCgpan">
						<td width="60%">Joint CGPAN (Existing Cgpan of this
						borrower) </td>
						<td width="40%"><input type="text"
							onkeypress="allowAlphaNumeric()" name="JFCGpan"
							value="<%=Helper.correctNull((String) hshValues.get("JFCGpan"))%>"></td>
					</tr>

					<tr class="dataheader" style="text-align: center;">
						<td colspan="2">Handicrafts</td>
						<td></td>
					</tr>

					<tr>
						<td width="60%">Whether the credit is sanctioned Under
						Artisan credit Card (ACC) Scheme for Handicraft Artisans operated
						by DC(Handicrafts),Govt of India</td>
						<td width="40%"><select name="ArtisanCC"
							onchange="IdCardEnable();">
							<option value="" selected>---select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
					</tr>
					<tr id="idIssued">
						<td width="60%">Details of Identity Card issued by DC</td>
						<td width="40%"><input type="text" name="IdentyDC"
							maxlength="15" onkeypress="allowAlphaNumeric();"
							value="<%=Helper.correctNull((String) hshValues.get("IdentyDC"))%>">
						<input type="text" name="IssueDate" size="16"
							onBlur="checkDate(this);checkmaxdate(this,currentDate)"
							value="<%=Helper.correctNull((String) hshValues.get("IssueDate"))%>">
						<a alt="Select date from calender" href="#"
							onClick="callCalender('IssueDate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender"></a></td>
					</tr>
					<tr>
						<td width="60%">Whether GF/ASF is re-imbursable from O/o DC
						(Handicrafts), Govt of India</td>
						<td width="40%"><select name="GF_ASF">
							<option value="" selected>---select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>

						</select></td>
					</tr>



					<tr class="dataheader" style="text-align: center;">
						<td colspan="2">Handloom</td>
						<td></td>
					</tr>
					<tr>
						<td width="60%">Whether the credit is sanctioned under DC
						(Handloom) scheme for Handloom Weavers</td>
						<td width="40%"><select name="HandloomScheme"
							onchange="selScheme();">
							<option value="" selected>---select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>

						</select></td>
					</tr>
					<tr id="selSch">
						<td width="60%">Please select the name of the Scheme :</td>
						<td width="40%"><select name="Namescheme">
							<option value="">---select---</option>
							<lapschoice:StaticDataTag apptype="241" />
						</select></td>
					</tr>
					<tr id="selChK">
						<td width="60%" colspan="2"><input type="checkbox"
							name="checkBx" value="Y">We certify that the credit
						facility being covered under CGTMSE and for which reimbursement of
						GF/ASF in being availed adheres to all guidelines as issued by
						Office of DC(Handloom) from time to time for sanction of Credit
						under the respective schemes.</td>
						<td width="40%"></td>
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
						<td colspan="4" style="text-align: center;">Means of Finance</td>
						<td></td>
						<td></td>
						<td></td>
					</tr>


					<tr id="tcs" class="datagrids">
						<td width="60%" colspan="2" style="text-align: center;">Term
						Credit Sanctioned</td>
						<td width="40%"></td>

					</tr>

					<tr>
						<td colspan="2">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable" align="center" id="wcs">
							<tr class="datagrids">
								<td width="60%" colspan="2" style="text-align: center;">Working
								Capital limit Sanctioned</td>
								<td width="40%"></td>

							</tr>
							<tr>
								<td width="60%">Whether provided As margin money Term Loan</td>
								<td width="40%"><select name="TL_MarginMoney">
									<option value="" selected>---select--</option>
									<option value="Y">Yes</option>
									<option value="N">No</option>
								</select></td>

							</tr>

							<tr>
								<td width="60%">Working Capital Assessed</td>
								<td width="40%"><input type="text" name="WC_Assesse"
									style="text-align: right;" onBlur="roundtxt(this);"
									onKeyPress="allowDecimals(this);" maxlength="20"
									value="<%=nf.format(Double
							.parseDouble(Helper
									.correctDouble((String) hshValues
											.get("WC_Assesse"))))%>"></td>

							</tr>
						</table>
						</td>
					</tr>

					<tr>
						<td width="60%">Promoters Contribution</td>
						<td width="40%"><input type="text" style="text-align: right;"
							name="TC_PromoContrbtn" onKeyPress="allowDecimals(this);"
							onBlur="roundtxt(this);" maxlength="20"
							value="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("TC_PromoContrbtn"))))%>"></td>

					</tr>

<%-- <tr>
						<td width="60%">Promoter's contribution in the entity (in % terms)</td>
						<td width="40%"><input type="text" style="text-align: right;"
							name="TC_PromoEntity" onKeyPress="allowDecimals(this);"
							onBlur="roundtxt(this);" maxlength="20"
							value="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("TC_PromoEntity"))))%>"></td>

					</tr>  --%>
					
					<tr>
						<td width="60%">Subsidy/Equity Support</td>
						<td width="40%"><input type="text" name="TC_Subsidy"
							style="text-align: right;" onBlur="roundtxt(this);"
							onKeyPress="allowDecimals(this);" maxlength="20"
							value="<%=nf.format(Double
							.parseDouble(Helper
									.correctDouble((String) hshValues
											.get("TC_Subsidy"))))%>"></td>

					</tr>


					<tr>
						<td width="60%">Others</td>
						<td width="40%"><input type="text" name="TC_Others"
							style="text-align: right;" onBlur="roundtxt(this);"
							onKeyPress="allowDecimals(this);" maxlength="20"
							value="<%=nf.format(Double
							.parseDouble(Helper
									.correctDouble((String) hshValues
											.get("TC_Others"))))%>"></td>

					</tr>


					<tr id="tcp">
						<td width="60%">Project Cost</td>
						<td width="40%"><input type="text" style="text-align: right;"
							name="TC_ProjCost" onKeyPress="allowDecimals(this);"
							onBlur="roundtxt(this);" maxlength="20"
							value="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("TC_ProjCost"))))%>"></td>

					</tr>


					<tr id="tpo">
						<td width="60%">Project Outlay</td>
						<td width="40%"><input type="text" name="TC_ProjOutlay"
							style="text-align: right;" onBlur="roundtxt(this);"
							onKeyPress="allowDecimals(this);" maxlength="20"
							value="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("TC_ProjOutlay"))))%>"></td>

					</tr>



				</table>
				</td>
			</tr>

			<!-- Term Loan Details-->

			<!-- Table of Credit to be Guaranteed-->

			<!-- Outstanding Facility Table  -->

			<!-- Button Portion in table -->
			<tr>
				<td>
				<table width="12%" border="0" cellspacing="0" cellpadding="0"
					align="center" class="outertable">

					<%
						if (strSessionModuleType.equals("RET")) {
					%>
					<tr>
						<lapschoice:combuttonnew
							btnnames='Edit_Save_Delete_Cancel_Generate Report_CGTMSE Financial Data'
							btnenable='<%=Helper.correctNull((String) request
								.getParameter("btnenable"))%>' />
					</tr>
					<%
						} else {
					%>
					<tr>
						<lapschoice:combuttonnew
							btnnames='Edit_Save_Delete_Cancel_Generate Report_CGTMSE Financial Data'
							btnenable='<%=Helper.correctNull((String) request
								.getParameter("btnenable"))%>' />
					</tr>
					<%
						}
					%>
				</table>

				</td>
			</tr>

		</table>
		</td>
	</tr>
</table>






<lapschoice:hiddentag pageid="<%=PageId%>" /> <input type="hidden"
	name="hidUsername"
	value="<%=Helper.correctNull((String) session
							.getAttribute("strUserName"))%>">
<input type="hidden" name="hidOrgcode"
	value="<%=Helper.correctNull((String) session
							.getAttribute("strOrgCode"))%>">
<input type="hidden" name="hidCreatedOn" value="<%=strCreatedOn%>">
<input type="hidden" name="hidCreatedBy" value="<%=strCreatedBy%>">
<input type="hidden" name="hidCondtion" value="<%=strCgAppNo%>">
<INPUT TYPE="hidden" NAME="hidfinanceid"
	value="<%=Helper.correctInt((String) hshValues.get("finace_id"))%>">



<input type="hidden" name="hidFacility"
	value="<%=Helper.correctNull((String) hshValues.get("facility"))%>">
<iframe name="ifrm" width="0" height="0" border="0"></iframe></form>
<iframe name="ifrm1" width="0" height="0" border="0"></iframe></form>
</body>
</html>
