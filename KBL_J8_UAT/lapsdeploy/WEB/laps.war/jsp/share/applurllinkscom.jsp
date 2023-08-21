<%@include file="../share/directives.jsp"%>
<%int pageid = Integer.parseInt(request.getParameter("pageid"));
			String cattype = Helper.correctNull((String) request.getParameter("cattype"));
			String applevel = Helper.correctNull((String) request.getParameter("applevel"));
			//System.out.println("applevel==="+applevel);			
			if (cattype.equals("") && pageid == 1) {
				cattype = Helper.correctNull((String) request.getParameter("cattype1"));
			}
			if (cattype.equals(""))
			{
				cattype = Helper.correctNull((String) session.getAttribute("cattype"));
			}
			String ssitype = (String) request.getParameter("ssitype");
			if (ssitype.equalsIgnoreCase("")) {
				ssitype = Helper.correctNull((String) hshValues	.get("hidSSIType"));
			}
			String strType = Helper.correctNull((String) session.getAttribute("link"));
			String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
			String strFinancialReq=Helper.correctNull((String)session.getAttribute("strFinancialReq")).trim();
			String strcgssdType=Helper.correctNull((String)session.getAttribute("strcgssdType")).trim();
			String strNCGTCFg=Helper.correctNull((String)session.getAttribute("strncgtcflag")).trim();
			String strncgtcbankscheme=Helper.correctNull((String)session.getAttribute("strncgtcbankscheme")).trim();
			%>
<HTML>
<HEAD>
<TITLE>Application Form Navigation</TITLE>
<script language="JavaScript">
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var cattype="<%=cattype%>";
var strNCGTCFg="<%=strNCGTCFg%>";
var strncgtcbankscheme="<%=strncgtcbankscheme%>";
function gotoPage(pagename)
{
	if(document.forms[0].appno.value == "new" || document.forms[0].appno.value == "")
	{
		ShowAlert(103);
		return;
	}
	if(document.forms[0].hidncgtcflag && document.forms[0].hidbankscheme)
	{
		if(document.forms[0].hidbankscheme.value=="069" && document.forms[0].hidncgtcflag.value=="N")
		{
			alert("Please Fill the KBL Aarogya page");
			return;
		}
	}
	if(document.forms[0].hidCGTMSE)
	{
		if(document.forms[0].hid_cgtmse_applicable.value=="Y")
		{
			if(document.forms[0].hidCGTMSE.value=="N")
			{
				alert("Please Fill the CGTMSE Coverage page");
				return;
			}
		}
	}
	if(document.forms[0].hidChecklist)
	{
		if(document.forms[0].hidChecklist.value=="N")
		{
			alert("Please Fill the CheckList Document");
			return;
		}
	}
	//vindhya begin
	if(document.forms[0].hidcheckenwr && document.forms[0].hidenwrbankschemecode)
	{
	if(document.forms[0].hidenwrbankschemecode.value=="074" &&  document.forms[0].hidcheckenwr.value=="N")
	{
		alert("Please Fill the eNWR Details");
		return;
	}}
	if(document.forms[0].freezeflag)
	{
	if(document.forms[0].freezeflag.value=="Y")
	{
		if(document.forms[0].varPanCheck.value=="Y")
		{ 
			if(document.forms[0].sessionmodule.value!="AGR")
			{
				
					if(document.forms[0].sessionmodule.value=="CORP")
					{					
							if(document.forms[0].Explimitchk.value=="F")
							 {
								 if (document.forms[0].varPancount.value=="N")
								{
								 alert(" Please obtain PAN number of the Applicants (including co-applicant/Joint borrower/Co-applicant) Co-Obligant/guarantor and capture in CBS for exposure (includes existing and proposed limit) of Rs."+document.forms[0].Expcheck.value+"/- and above ");
									return;
								}	 
							}				
					
					}
					else if(document.forms[0].sessionmodule.value=="RET")
					{			
					 if(document.forms[0].Explimitchk.value=="F")
						 {
							 if (document.forms[0].varPancount.value=="N")
							{
							 alert("Please obtain PAN number of the Applicants (including co-applicant/Joint borrower/Co-applicant) Co-Obligant/guarantor and capture in CBS for exposure (includes existing and proposed limit) of Rs."+document.forms[0].Expcheck.value+"/- and above ");
								return;
							}	 
						}
					}	
			
				 
			}
			if(document.forms[0].sessionmodule.value=="AGR")
			{
				if(document.forms[0].Expmainactcheck.value>0)
				{	
				 if(document.forms[0].Explimitagrchk.value=="F")
					 {
						if (document.forms[0].varPancount.value=="N")
						{
						 	alert("Please obtain PAN number of the Applicants (including co-applicant/Joint borrower/Co-applicant) Co-Obligant/guarantor and capture in CBS for exposure (includes existing and proposed limit) of "+document.forms[0].Expcheck.value+"/- and above ");
							return;
						}	 
					}
				}
				else
				{
					if(document.forms[0].Explimitagrchk.value=="F")
					 {
						 if (document.forms[0].varPancount.value=="N")
						{
						 	alert("Please obtain PAN number of the Applicants (including co-applicant/Joint borrower/Co-applicant) Co-Obligant/guarantor and capture in CBS for exposure (includes existing and proposed limit) of Rs."+document.forms[0].Expcheck.value+"/- and above ");
							return;
						}	 
					}
				}	
			
			}
			
		}
	}	}	
	//vindhya end
	if(document.forms[0].cmdsave)
	{
		if(document.forms[0].cmdsave.disabled == false)
		{
			ShowAlert(103);
			return;
		}
	}
	if(pagename=="facilities.jsp")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/facilities.jsp?hidBeanGetMethod=getFacilityData&hidBeanId=facilities";
	}
	else if(pagename=="ops_facilities.jsp")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/ops_facilities.jsp?hidBeanGetMethod=getOPSFacilityData&hidBeanId=facilities";
	}
	else if(pagename=="compromoters.jsp" || pagename=="comstl_guarantee.jsp")
	{
	  	document.forms[0].hidBeanId.value="compro";
		document.forms[0].hidBeanGetMethod.value="getValues";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;		
	}
	else if(pagename=="com_capitalstructure.jsp")
	{
	  	document.forms[0].hidBeanId.value="compro";
		document.forms[0].hidBeanGetMethod.value="getCapitalStructure";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/com_capitalstructure.jsp";
	}
	else if(pagename=="com_securities.jsp")
	{
	
	  	document.forms[0].hidBeanId.value="comsecurities";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/com_securities.jsp";
	}
	else if(pagename=="comactivities.jsp")
	{
		document.forms[0].hidBeanId.value="compro";
		document.forms[0].hidBeanMethod.value="getActivity";
		document.forms[0].hidBeanGetMethod.value="getActivity";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comactivities.jsp";
	}
	else if(pagename=="appworkflowhistory.jsp")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appworkflowhistory.jsp?hidBeanGetMethod=getHistory";
	}
	else if(pagename=="financial.jsp")
	{
//alert("financialtabcalled")
document.forms[0].hidBeanId.value="facilities";
document.forms[0].hidBeanGetMethod.value="getFinancialtype";
//document.forms[0].hidBeanMethod.value="getData";
document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/financial.jsp";
document.forms[0].submit();	
	}
	else if(pagename=="comequity.jsp")
	{
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanGetMethod.value="getEquity";
		document.forms[0].action=appUrl+"action/comequity.jsp";
	}
	else if(pagename=="com_industryanalysis.jsp")
	{
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanGetMethod.value="get_Others";
		document.forms[0].action=appUrl+"action/com_industryanalysis.jsp?hidpage=Industry";
	}
	else if(pagename=="combanking.jsp")
	{
		document.forms[0].hidBeanId.value="bankapp"
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/combanking.jsp";
	}
	else if(pagename=="appnotes.jsp")
	{
	   document.forms[0].hidBeanGetMethod.value="getData";
	   document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appnotes.jsp?cattype="+cattype;
	}
	else if(pagename=="comorg.jsp")
	{
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanGetMethod.value="getOrgData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comorg.jsp";
	}
	else if(pagename=="facilityrecmdforsanc.jsp")
	{		
	    document.forms[0].hidBeanId.value="inwardRegister"
		document.forms[0].hidBeanGetMethod.value="getbrrecmdfacility";
		document.forms[0].action=appURL+"action/facilityrecmdforsanc.jsp";		
	}
	else if(pagename=="com_termloancomments.jsp")
	{		
		//document.forms[0].hidPage.value="term";
	    document.forms[0].hidBeanId.value="facilities"
		document.forms[0].hidBeanGetMethod.value="getComments";
		document.forms[0].action=appURL+"action/com_termloancomments.jsp?hidPage=term";		
	}	
	else if(pagename=="ssi_above10_industryactivity.jsp")
	{
		callFunction('ssi_above10_industryactivity.jsp','getGeneralDetails','ExistingIndustrialActivity^ProposedIndustrialActivity','IndustryActivity');
	}
	else if(pagename=="ssiab10_technicalfeasb.jsp")
	{
		callFunctionTab('ssiab10_technicalfeasb.jsp','getGeneralData','TechnicalFeasibility^Nameoftheproducts^ManufacturingProcessInBrief^Noofworkingdaysinmonth^Noofshiftsinday','TechnicalFeasibility','getSSIProductData');
	}	
	else if(pagename=="ssiab10_ecnomic_feasibility.jsp")
	{
		callFunctionTab('ssiab10_ecnomic_feasibility.jsp','getGeneralData','Marketing^ProductItemCodeNo^NameMajorcustomers^Region/Area^ExtentofcompetitionandNoOfUnits^Howdoesunitmeet/propose^Pricaandquality^Unitsellingdirecttocutomers','Economicfeasibility','no');
	}
	else if(pagename=="ssi_above10_costofprojectincurred.jsp")
	{
		callFunction('ssi_above10_costofprojectincurred.jsp','getCostofProject','LAND^BULIDING^INDIGENOUSPLANTMC^IMPORTEDPLANTMC^TOOLSSPARES^TESTEQUIPMENTS^MISCFIXEDASSETS^INSTALLATIONCHRG^PRELIMEXPEMSES^PREOPTEXPENSES^BUILDINGCONTINGENCIES^PLANTMACHCONTINGENCIES^FIXEDASSETSCONTINGENCIES^MARGINWCREQ','getCostofProject');
	}
	else if(pagename=="ssi_above10_occupationguaranteedetails.jsp")
	{
		callFunction('ssi_above10_occupationguaranteedetails.jsp','getGuarantorDetails','','GuarantorDetails');
	}
	else if(pagename=="ssi_appendix2_landbuilding.jsp")
	{
		callFunction('ssi_appendix2_landbuilding.jsp','getGeneralDetails','LandLocation^LandArea^LandFreeHoldLeaseHold^PurchasePriceOfLand^RentForLeaseLand^LandTermsOfLease^LandYearlyGroundRent^BuildingLocation^BuildingOwnedOrLease^PurchasePriceOfBuilding^RentForLeaseOrRentedBuilding^BuildingTermsOfLease','AppendixIILandAndBuilding');
	}
	else if(pagename=="ssi_upto10lakh_applicantbackground.jsp")
	{
		callFunction('ssi_upto10lakh_applicantbackground.jsp','getApplicantBakgroundDetails','','ApllicantBackground');
	}
	else if(pagename=="ssi_upto10lakh_meansoffinancing.jsp")
	{
		callFunction('ssi_upto10lakh_meansoffinancing.jsp','getGeneralDetails','PromotersContribution^SubsidyIfAvailable^SeedCapital^LoanWCTL','Upto10LakhMeansOfFinancing');
	}
	else if(pagename=="ssi_securities.jsp")
	{
		document.forms[0].action = appURL+"action/"+pagename;
	}
	else if(pagename=="ssi_above50lakhs_govtenquiry.jsp")
	{
		callFunction('ssi_above50lakhs_govtenquiry.jsp','getGeneralDetails','GovernmentEnquirtyOrProceedings^DetailsOfPendingLitigation^PromotersOrDirectorsInsolvent','GovtEnquiry');
	}
	else if(pagename=="demograph.jsp")
	{
	   document.forms[0].hidBeanId.value="ssidemographics";
		document.forms[0].hidBeanGetMethod.value="getCorresRec";
		document.forms[0].action = appURL+"action/"+pagename;
	}
	else if(pagename=="ops_demographics.jsp")
	{
	   	document.forms[0].hidBeanId.value="ssidemographics";
		document.forms[0].hidBeanGetMethod.value="getOpsdemograph";
		document.forms[0].action = appURL+"action/"+pagename;
	}
	else if(pagename=="ops_creditreport.jsp")
	{
	   	document.forms[0].hidBeanId.value="lapsReport";
		document.forms[0].hidBeanGetMethod.value="getCreditreport1";
		document.forms[0].action = appURL+"action/"+pagename;
	}
	else if(pagename=="comfintype.jsp")
	{
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].hidBeanGetMethod.value="getFinancialtype";
		document.forms[0].action=appURL+"action/"+pagename+"?val=cma";
	}
	else if(pagename=="com_lapstoirb.jsp")
	{
		document.forms[0].action = appURL+"action/"+pagename;		
	}
	else if(pagename=="ops_applicantdisp.jsp")
	{
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action = appURL+"action/"+pagename;		
	}
	else if(pagename=="com_companydet.jsp" || pagename=="comtermsandcond.jsp")
	{
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action = appURL+"action/"+pagename;		
	}	
	else if(pagename=="combankingfi.jsp" )
	{
		document.forms[0].hidBeanId.value="bankappfi";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appURL+"action/"+pagename;
	}
	else if(pagename=="com_facilitydet.jsp" )
	{
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanGetMethod.value="getSecurityCharges";
		document.forms[0].action=appURL+"action/"+pagename;
	}
	else if(pagename=="exec_page1.jsp" )
	{
		document.forms[0].hidBeanId.value="executive";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appURL+"action/"+pagename;
	}
	else if(pagename=="com_auditobserv.jsp" )
	{
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanGetMethod.value="getDataComment";
		document.forms[0].action=appURL+"action/"+pagename+"?type=7";
	}	
	else if(pagename=="comsre_financial.jsp" || pagename=="adc_financials.jsp")
	{
		document.forms[0].hidBeanId.value="executive";
		document.forms[0].hidBeanGetMethod.value="getDataFinancial";
		document.forms[0].action=appURL+"action/"+pagename;
	}	
	else if(pagename=="comdynamiccashflow.jsp" )
	{
		document.forms[0].hidBeanId.value="comformula";
		document.forms[0].hidBeanGetMethod.value="getDateFincommentsData";
		document.forms[0].action=appURL+"action/"+pagename+"?flowtype=CA";
	}	
	else if(pagename=="adc_bankingdetails.jsp" )
	{
		document.forms[0].hidBeanId.value="adhoc";
		document.forms[0].hidBeanGetMethod.value="getBankingDetails";
		document.forms[0].action=appURL+"action/"+pagename;
	}	
	else if(pagename=="adc_comments.jsp" )
	{
		document.forms[0].hidBeanId.value="adhoc";
		document.forms[0].hidBeanGetMethod.value="getComments";
		document.forms[0].action=appURL+"action/"+pagename;
	}	
	else if(pagename=="adc_recommendations.jsp" )
	{
		document.forms[0].hidBeanId.value="adhoc";
		document.forms[0].hidBeanGetMethod.value="getRecommendations";
		document.forms[0].action=appURL+"action/"+pagename;
	}	
	else if(pagename=="adc_limitcomments.jsp" )
	{
		document.forms[0].hidBeanId.value="adhoc";
		document.forms[0].hidBeanGetMethod.value="getLimitSought";
		document.forms[0].action=appURL+"action/"+pagename;
	}
	else if(pagename=="agrlandholdings.jsp")
	{
			document.forms[0].hidBeanId.value="agrlandholdings";
			document.forms[0].hidBeanGetMethod.value="getData";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrlandholdings.jsp";
			//document.forms[0].hidAppType.value="";
			//document.forms[0].submit();
	}
	//Added by Arsath for new page Fin - Grp Concerns
	else if(pagename=="com_financialgrpconc.jsp" )
	{
		document.forms[0].hidBeanId.value="comassestsliab";
		document.forms[0].hidBeanGetMethod.value="getFinangrpconcern";
		document.forms[0].action=appURL+"action/"+pagename;
	}
	else if(pagename=="com_istakeover.jsp" )
	{
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanGetMethod.value="gettakeover";
		document.forms[0].action=appURL+"action/"+pagename;
	}
	else if(pagename=="comdocuments.jsp")
	{
		document.forms[0].hidBeanId.value="commdocument";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appUrl+"action/appdocumentsappl.jsp?hidAppDoc=A";
	}
	else if(pagename=="com_externalrating.jsp")
	{
		document.forms[0].hidBeanId.value="compro";
		document.forms[0].hidBeanGetMethod.value="getcom_externalratingdata";
		document.forms[0].action=appUrl+"action/com_externalrating.jsp";
	}

	else if(pagename=="securitiesMasterPage.jsp")
	{
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].hidBeanGetMethod.value="getSecurityValuesDetails";
		document.forms[0].action=appURL+"action/securitiesMasterPage.jsp";
	}	
	else if(pagename=="appqueryhome.jsp")
	{
		document.forms[0].hidBeanId.value="documentsupport";
		document.forms[0].hidBeanGetMethod.value="getQueryData";
		document.forms[0].action=appURL+"action/appqueryhome.jsp";
	}	
	

	document.forms[0].method="post"
	document.forms[0].submit();
}

function callFunction(pagename,methodname,param,tabname)
{
	if(methodname=="getGeneralDetails")
	{
		document.forms[0].hidparam.value =param;
	}
	if( document.forms[0].cmdsave.disabled == false)
	{
		ShowAlert('103');
		return;
	}
	document.forms[0].method="post";
	document.forms[0].hidBeanId.value="comssiaboveten"
	document.forms[0].hidTabName.value=tabname;		
	document.forms[0].hidMethod.value=methodname;
	document.forms[0].hidBeanMethod.value="";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();	
}
function callFunction1(pagename,getmethod)
{
	if( document.forms[0].cmdsave.disabled == false)
	{
		ShowAlert('103');
		return;
	}
	document.forms[0].hidBeanMethod.value="";
	document.forms[0].hidOtherMethod.value=getmethod;
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].method="post";	
	document.forms[0].submit();
}

function callFunction2(pagename,getmethod)
{
	document.forms[0].hidBeanId.value="compro"
	document.forms[0].hidBeanGetMethod.value="getActivity";
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();	
}
function callFunctionTab(pagename,methodname,param,tabname,othermethod)
{
	if(methodname=="getGeneralData")
	{
		document.forms[0].hidparam.value =param;
	}
	document.forms[0].method="post";	
	document.forms[0].hidTabName.value=tabname;
	document.forms[0].hidBeanGetMethod.value="getData";

	document.forms[0].hidMethod.value=methodname;
	document.forms[0].hidOtherMethod.value=othermethod;
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}
function callBankAccounts()
{
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].method="post"
	document.forms[0].action=appURL+"action/ssi_financialbnkacc.jsp";
	document.forms[0].submit();
}

function callInvestment()
{
	document.forms[0].method="post"
	document.forms[0].hidBeanGetMethod.value="getInvestMent";
	document.forms[0].action=appURL+"action/ssi_financialinvst.jsp";
	document.forms[0].submit();
}
function callInsurancePolicy()
{
	document.forms[0].method="post"
	document.forms[0].hidBeanGetMethod.value="getPolicy";
	document.forms[0].action=appURL+"action/ssi_financialinspol.jsp";
	document.forms[0].submit();
}
function callPersonalProp()
{
	document.forms[0].method="post"
	document.forms[0].hidBeanGetMethod.value="getProperty";
	document.forms[0].action=appURL+"action/ssi_financialperpro.jsp";
	document.forms[0].submit();
}
function callLiabilities()
{
	document.forms[0].method="post"
	document.forms[0].hidBeanGetMethod.value="getLiability";
	document.forms[0].action=appURL+"action/ssi_financialliab.jsp";
	document.forms[0].submit();
}
function menuOptionDivMouseDown (url) 
{
	if(document.forms[0].cmdsave.disabled == true)
	{
	document.currentMenu.style.display='none';
	document.currentMBarOpt.style.border='1px solid lightgrey';
	document.menuIsActive = false;
	document.forms[0].action=url;
	document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}
function menuOptionDivClick (url) 
{
	if(document.forms[0].cmdsave.disabled == true)
	{
	document.currentMenu.style.display='none';
	document.currentMBarOpt.style.border='1px solid lightgrey';
	document.menuIsActive = false;
	document.forms[0].action=url;
	document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}
function doClose()
{
	if( ConfirmMsg(100) )
	{
		if(cattype=="OPS")
		{
			document.forms[0].action=appUrl+"action/agrpage.jsp";
		}
		else
		{
			document.forms[0].method="post";
			var type="<%=strType.trim()%>";
			document.forms[0].action=appURL+"action/"+"corppge.jsp";
		}
		document.forms[0].submit();
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</HEAD>
<BODY leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%if (!cattype.equals("OPS")) {
	if (cattype.equals("SRE") || cattype.equals("STL") || cattype.equals("ADC")) {%>
<table width="100%" border="0" cellpadding="0" cellspacing="1"
	class="outertable">
	<tr>
		<td align="center" >&nbsp;&nbsp;<span class="red"><b>(Rs. in Rupees)&nbsp;</b></span>
		</td>
	</tr>
	<%} else {%>
	<tr>
		<td align="center" >&nbsp;&nbsp;<span class="red"><b>(Rs. in Rupees)&nbsp;</b></span>
		</td>
		<td width="5%"><lapschoice:appltolbar strModule="2" /></td>
	</tr>
	<%}%>
</table><%}%> 
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="outertable"> <tr align="center"> 
<%if ((cattype.equals("CORP")) || ((cattype.equals("CORPORATE"))) || (cattype.equals("SME")) || (cattype.equals("AGR"))) {%> <%if (pageid == 1) {%> 
<td class="main_tab_active" WIDTH="10%" nowrap="nowrap">Applicant</td>
<%} else {%> 
<td class="main_tab_inactive" WIDTH="10%" nowrap="nowrap"><a href="javascript:gotoPage('facilities.jsp')"  title="Applicant"> Applicant </a> </td>
<%}%> 
<%if (pageid == 2) {%> 
<td class="main_tab_active" WIDTH="10%" nowrap="nowrap"> Co-Applicant / Guarantor</td>
<%} else {%> 
<td class="main_tab_inactive" WIDTH="10%" nowrap="nowrap"><a href="javascript:gotoPage('compromoters.jsp')" title="Co-Applicant / Guarantor">Co-Applicant / Guarantor</a> </td>
<%}%> 
<%if (pageid == 3) {%> 
<td class="main_tab_active" WIDTH="10%" nowrap="nowrap">Banking Arrangement </td>
<%} else {%> 
<td class="main_tab_inactive" WIDTH="10%" nowrap="nowrap"><a href="javascript:gotoPage('combankingfi.jsp')"  title="Banking Arrangement"> Banking Arrangement</a></td>
<%}%> 

<%if (pageid == 33) {%> 
<td class="main_tab_active" WIDTH="10%" nowrap="nowrap">Security Master </td>
<%} else {%> 
<td class="main_tab_inactive" WIDTH="10%" nowrap="nowrap"><a href="javascript:gotoPage('securitiesMasterPage.jsp')"  title="Security Master">Security Master</a></td>
<%}%>

<!--  <%if (pageid == 10) {%> 
<td class="main_tab_active" WIDTH="10%" nowrap="nowrap"> Financial Model</td>
<%} else {%> 
<td class="main_tab_inactive" WIDTH="10%" nowrap="nowrap"><a href="javascript:gotoPage('comfintype.jsp')"  title="Financial type">Financial Model</a> </td>
<%}%> -->
<%if(strSessionModuleType.trim().equalsIgnoreCase("AGR")){ 
	if(strFinancialReq.equalsIgnoreCase("Y")) {
		if (pageid == 6) { %>
		<td class="main_tab_active" WIDTH="10%" nowrap="nowrap"> Financial</td>
		<%} else { %>
		<td class="main_tab_inactive" WIDTH="10%" nowrap="nowrap"> 
		<a href="javascript:gotoPage('financial.jsp')" title="Financial">Financial</a> </td>
		<%}
 	}
} else { 
	if(!strcgssdType.equalsIgnoreCase("Y")){
		if (pageid == 6) { %>
	<td class="main_tab_active" WIDTH="10%" nowrap="nowrap"> Financial</td>
	<%} else { %>
	<td class="main_tab_inactive" WIDTH="10%" nowrap="nowrap"> 
	<a href="javascript:gotoPage('financial.jsp')" title="Financial">Financial</a> </td>
	<%} }}%> 


<%if(strSessionModuleType.trim().equalsIgnoreCase("AGR")){%> 
       
		<%if (pageid == 999) {%> 
		<td width="9%" align="center" nowrap="nowrap" class="main_tab_active"> Agriculture</td>
		 <%} else {%>  
		 <td width="9%" align="center" nowrap="nowrap" class="main_tab_inactive"><a
			href="javascript:gotoPage('agrlandholdings.jsp')" class="darkTabColor">Agriculture</a></td>
		 <%}}%>
<!-- 
<%if (pageid == 4) {%> 
<td class="main_tab_active" WIDTH="10%" nowrap="nowrap"> Products</td>
<%} else {%>
<td class="main_tab_inactive" WIDTH="10%" nowrap="nowrap"> <a href="javascript:gotoPage('comactivities.jsp')" title="Products"> Products</a></td>
<%}%> 
<%if (pageid == 5) {%> 
<td class="main_tab_active" WIDTH="10%" nowrap="nowrap"> Org. &amp; Emp.  </td>
<%} else {%> 
<td class="main_tab_inactive" WIDTH="10%" nowrap="nowrap"><a href="javascript:gotoPage('comorg.jsp')" title="Organisation & Employees"> Org. &amp; Emp.</a></td>
<%}%>  -->


<%
if(!strcgssdType.equalsIgnoreCase("Y")){
if (pageid == 112) {
%>
<td class="main_tab_active" WIDTH="12%" nowrap="nowrap"><b>Financial-Group Concerns / Borrower
</b></td>
<%
} else {
%>
<td class="main_tab_inactive" WIDTH="12%" nowrap="nowrap"><b> <a
href="javascript:gotoPage('com_financialgrpconc.jsp')">Financial-Group Concerns / Borrower</a> </b></td>
<%
}}
%>
<%
if (pageid == 41) {
%>
<td class="main_tab_active" WIDTH="12%" nowrap="nowrap"><b>Take Over Norms
</b></td>
<%
} else {
%>
<td class="main_tab_inactive" WIDTH="12%" nowrap="nowrap"><b> <a
href="javascript:gotoPage('com_istakeover.jsp')">Take
Over Norms </a> </b></td>
<%
}
%>

<%
if (pageid == 77) {
%>
<TD CLASS="MAIN_TAB_ACTIVE" WIDTH="12%" NOWRAP><B>Documents</B></TD>
<%
} else {
%>
<td class="main_tab_inactive" WIDTH="12%" NOWRAP> <a href="javascript:gotoPage('comdocuments.jsp')" 
					onMouseOut="window.status='';return true;" 
					onMouseOver="window.status='Documents';return true;"
				> <b>Documents</b></a></td>
<%
}
%>

<!-- <%
if (pageid == 88) {
%>
<TD CLASS="MAIN_TAB_ACTIVE" WIDTH="12%" NOWRAP><B>Queries</B></TD>
<%
} else {
%>
<td class="main_tab_inactive" WIDTH="12%" NOWRAP> <a href="javascript:gotoPage('appqueryhome.jsp')" 
					onMouseOut="window.status='';return true;" 
					onMouseOver="window.status='Documents';return true;"
				> <b>Queries</</b></a></td>
<%
}
%> -->
<!-- <%if (pageid == 111) {%> 
<td class="main_tab_active" WIDTH="10%" nowrap="nowrap">External Rating</td>
<%} else {%> 
<td class="main_tab_inactive" WIDTH="10%" nowrap="nowrap"><a href="javascript:gotoPage('com_externalrating.jsp')" title="External Rating"> External Rating </a></td>
<%}%>-->
<%//if (pageid == 8) {%> 
<!--  <td class="main_tab_active" WIDTH="10%" nowrap="nowrap">Other Info.</td>
<%//} else {%> 

<td class="main_tab_inactive" WIDTH="10%"><a href="javascript:gotoPage('com_industryanalysis.jsp')" title="Other Information"> Other Info. </a></td>
<!-- 
<td class="main_tab_inactive" WIDTH="10%" nowrap="nowrap"><a href="javascript:gotoPage('comequity.jsp')" title="Other Information"> Other Info. </a></td>
 -->
<%//}%> 
<!-- 

 -->
<%} else if (cattype.equals("OPS")) {%> 
<%if (pageid == 1) {%> 
<td class="main_tab_active" WIDTH="10%">Applicant</td>
<%} else {%> 
<td class="main_tab_inactive" WIDTH="10%"><a href="javascript:gotoPage('ops_facilities.jsp')" title="Applicant"> Applicant </a></td>
<%}%> 
<%if (pageid == 2) {%> 
<td class="main_tab_active" WIDTH="10%">Co-Applicant / Guarantor </td>
<%} else {%> 
<td class="main_tab_inactive" WIDTH="10%"><a href="javascript:gotoPage('ops_applicantdisp.jsp')" title="Co-Applicant/ Guarantor">Co - Applicant / Guarantor</a></td>
<%}%>	
<%if (pageid == 12) {%> 
<td class="main_tab_active" WIDTH="10%">Proposed / Offered Asset </td>
<%} else {%> 
<td class="main_tab_inactive" WIDTH="10%"><a href="javascript:gotoPage('ssi_appendix2_landbuilding.jsp')" title="Proposed / Offered Asset">Proposed / Offered Asset</a></td>
<%}%> 
 
<%if (pageid == 4) {%> 
<td class="main_tab_active" WIDTH="10%">Ind. Activity</td>
<%} else {%> 
<td class="main_tab_inactive" WIDTH="10%"><a href="javascript:gotoPage('ssi_above10_industryactivity.jsp')" title="Industrial Activity"> Ind. Activity </a></td>
<%}%> 
<%if (pageid == 5) {%> 
<td class="main_tab_active" WIDTH="10%">Tech. Feasibility</td>
<%} else {%> 
<td class="main_tab_inactive" WIDTH="10%"><a
			href="javascript:gotoPage('ssiab10_technicalfeasb.jsp')"
			 title="Technical Feasibilty">Tech.Feasibility </a></td>
<%}%> 
<%if (pageid == 3) {%> 
<td class="main_tab_active" WIDTH="10%">Eco.Feasibility</td>
<%} else {%> 
<td class="main_tab_inactive" WIDTH="10%"><a
			href="javascript:gotoPage('ssiab10_ecnomic_feasibility.jsp')"
			 title="Economic Feasibility"> Eco. Feasibility </a></td>
<%}%> 
<%if (pageid == 6) {%> 
<td class="main_tab_active" WIDTH="10%">Financials</td>
<%} else {%> 
<td class="main_tab_inactive" WIDTH="10%"><a
			href="javascript:gotoPage('financial.jsp')" 
			title="Financials"> Financials</a> </td>
<%}%> 
<%if (pageid == 20) {%> 
<td class="main_tab_active" WIDTH="10%">Cost &amp; Means</td>
<%} else {	%> 
<td class="main_tab_inactive" WIDTH="10%"><a
			href="javascript:gotoPage('ssi_above10_costofprojectincurred.jsp')"
			 title="Cost & Means of Finance">Cost &amp; Means </a></td>
<%}%>	
</tr> <tr align="center"> 
<%if (pageid == 10) {%> 
	<td class="main_tab_active" WIDTH="10%">Reports </td>
<%} else {%> <td  class="main_tab_inactive" WIDTH="10%"><a href="javascript:gotoPage('ops_creditreport.jsp')" title="Reports">Reports</a></td>
<%}%>	
<%if (pageid == 18) {%> 
<td class="main_tab_active" WIDTH="10%">Credit Rating Details</td>
<%} else {%> 
<td class="main_tab_inactive" WIDTH="10%"> <a href="javascript:gotoTab(appURL,'ADV1151','getMeansCapital','adv_meanscapital.jsp')" title="Credit Rating Details">Credit Rating Details </a></td>
<%}%> 
<%if (pageid == 14) {%> <td class="main_tab_active" WIDTH="10%">Audit 
Observations  </td>
<%} else {%> 
<td class="main_tab_inactive" WIDTH="10%"> 
<a href="javascript:gotoTab(appURL,'comproposal','getDataComment','com_auditobserv.jsp')" title="Audit Observations">Audit 
Observations</a> </td>
<%}%> 
<%if (pageid == 17) {%> <td class="main_tab_active" WIDTH="10%">Take 
Over Norms  </td><%} else {%> <td class="main_tab_inactive" WIDTH="10%"> 
<a href="javascript:gotoTab(appURL,'comproposal','gettakeover','com_istakeover.jsp')" title="Take Over Norms">Take 
Over Norms </a>  </td><%}%> <%if (pageid == 13) {%> <td class="main_tab_active" WIDTH="10%">Fin. 
Analysis  </td><%} else {%> <td class="main_tab_inactive" WIDTH="10%"> 
<a href="javascript:gotoTabpage(appURL,'ops_generatefinanalysis.jsp')" title="Financial Analysis">Fin. 
Analysis </a> </td><%}%> <%if (pageid == 9) {%> <td class="main_tab_active" WIDTH="10%" nowrap="nowrap">T&amp;C 
/ Sec. Documents  </td><%} else {%> <td class="main_tab_inactive" WIDTH="10%" nowrap="nowrap"> 
<a href="javascript:gotoTabpage(appURL,'comtermsandcond.jsp')" title="T & C / Sec. Documents" >T&amp;C 
/ Sec. Documents</a>  </td><%}%> <%if (pageid == 31) {%> <td class="main_tab_active" WIDTH="10%">Check 
List </td><%} else {%> <td class="main_tab_inactive" WIDTH="10%"> <a href="javascript:gotoTab(appURL,'govtsponschklist','getgovtQuestParameters','ops_checklist.jsp')" title="Check List">Check 
List </a> </td><%}%> <%if (ssitype.equalsIgnoreCase("WADV")) { %> <%if (pageid == 19) {%> 
<td class="main_tab_active" WIDTH="10%"> ADV1151 </td><%} else {%> <td class="main_tab_inactive" WIDTH="10%"> 
<a href="javascript:gotoTab(appURL,'ADV1151','getadvBorrowingPower','adv_borrowingpower.jsp')" title="ADV1151">ADV1151</a></td><%}%> 
<%}%> <%if (pageid == 15) {%> <td class="main_tab_active" WIDTH="10%">WorkFlow 
</td><%} else {%> <td class="main_tab_inactive" WIDTH="10%"> <a	href="javascript:gotoTab(appURL,'commworkflow','getHistory','appworkflowhistory.jsp')" title="WorkFlow">WorkFlow</a> 
 </td><%}%> 
<%} else if (cattype.equalsIgnoreCase("SRE")) {%> 
<%if (pageid == 1) {%> 
<td class="main_tab_active" WIDTH="10%">Applicant</td>
<%} else {%> 
<td class="main_tab_inactive" WIDTH="10%"><a
			href="javascript:gotoPage('facilities.jsp')" 
			title="Applicant"> Applicant </a></td>
<%}%> 
<%if (pageid == 2) {%> 
	<td class="main_tab_active" WIDTH="10%"> Co-Applicant / Guarantor</td>
<%} else {%>
	<td class="main_tab_inactive" WIDTH="10%"><a href="javascript:gotoPage('compromoters.jsp')" title="Co-Applicant / Guarantor">Co - Applicant / Guarantor</a></td>
<%}%> 
<%if (pageid == 3) {%> 
<td class="main_tab_active" WIDTH="10%"> Banking Arrangement</td>
<%} else {%> 
<td class="main_tab_inactive" WIDTH="10%"><a href="javascript:gotoPage('combankingfi.jsp')" title="Banking Arrangement"> Banking Arrangement</a></td>
<%}%> 
<%if (pageid == 4) {%>
<td class="main_tab_active" WIDTH="10%"> Basic Information </td>
<%} else {%> 
<td class="main_tab_inactive" WIDTH="10%"> <a href="javascript:gotoPage('com_companydet.jsp')" title="Brief Background"> Basic Information </a></td>
<%}%> 
<%if (pageid == 10) {%>
<td class="main_tab_active" WIDTH="10%"> Financial</td>
<%} else {%>
<td class="main_tab_inactive" WIDTH="10%">  <a href="javascript:gotoPage('comsre_financial.jsp')"  title="Financial"> Financial</a></td>
<%}%> 
<%if (pageid == 14) {%>
<td class="main_tab_active" WIDTH="10%"> 
Audit Observations </td>
<%} else {%>
<td class="main_tab_inactive" WIDTH="10%"> 
 <a href="javascript:gotoPage('com_auditobserv.jsp')"  title="Audit Observations">Audit Observations </a> 
</td>
<%}%> 
<%if (pageid == 9) {%>
<td class="main_tab_active" WIDTH="10%">Terms 
&amp; Conditions </td>
<%} else {%>
<td class="main_tab_inactive" WIDTH="10%">  <a href="javascript:gotoPage('comtermsandcond.jsp','')" title="Terms &amp; Conditions">Terms &amp; Conditions</a> </td>
<%}%>
 <!--The saral tab will be enbled only for saral user when they are creating application in saral level--> 
<% if(cattype.equals("SRE")  &&  (applevel.equals("S"))){%> 
<%if (pageid == 16) {%> 
<td class="main_tab_active" WIDTH="10%">SARAL </td>
<%} else {%> 
<td class="main_tab_inactive" WIDTH="10%"> <a href="javascript:gotoPage('facilityrecmdforsanc.jsp')" title="SARAL">SARAL</a> </td>
<%}%> 
<% } %>	
<%if (pageid == 8) {%>
<td class="main_tab_active" WIDTH="10%"> Process Note</td>
<%} else {%>
<td class="main_tab_inactive" WIDTH="10%">  <a href="javascript:gotoPage('exec_page1.jsp')"  title="Process Note">Process Note</a></td>
<%}%> 
<%if (pageid == 15) {%> 
<td class="main_tab_active" WIDTH="10%">WorkFlow </td><%} else {%> <td class="main_tab_inactive" WIDTH="10%"> 
<a
			href="javascript:gotoPage('appworkflowhistory.jsp')"
			 title="WorkFlow">WorkFlow</a>  </td><%}%> <%} else if (cattype.equalsIgnoreCase("STL")) {%> 
<%if (pageid == 1) {%> <td class="main_tab_active" WIDTH="10%">Applicant 
</td><%} else {%> <td class="main_tab_inactive" WIDTH="10%"><a
			href="javascript:gotoPage('facilities.jsp')" 
			title="Applicant">Applicant </a></td><%}%> <%if (pageid == 2) {%><td class="main_tab_active" WIDTH="10%"> 
Co-Applicant / Guarantor</td><%} else {%><td class="main_tab_inactive" WIDTH="10%"> <a href="javascript:gotoPage('compromoters.jsp') "
			 title="Co-Applicant / Guarantor">Co - Applicant / Guarantor</a> </td><%}%> <%if (pageid == 7) {%> 
<td class="main_tab_active" WIDTH="10%">Security</td><%} else {%><td class="main_tab_inactive" WIDTH="10%"> 
 <a href="javascript:gotoPage('com_securities.jsp')"
			 title="Security">Security</a></td><%}%> <%if (pageid == 10) {%> 
<td class="main_tab_active" WIDTH="10%">Financial</td><%} else {%> <td class="main_tab_inactive" WIDTH="10%"> 
<a href="javascript:gotoPage('comsre_financial.jsp')"
			 title="Financial">Financial</a></td><%}%> <%if (pageid == 4) {%> 
<td class="main_tab_active" WIDTH="10%">Basic Information</td><%} else {%><td class="main_tab_inactive" WIDTH="10%"> 
 <a
			href="javascript:gotoPage('com_companydet.jsp')" 
			title="Brief Background"> Basic Information</a> </td><%}%> 
<%if (pageid == 3) {%><td class="main_tab_active" WIDTH="10%"> Banking Details 
</td><%} else {%><td class="main_tab_inactive" WIDTH="10%"> <a
			href="javascript:gotoPage('combankingfi.jsp')" 
			title="Banking Details">Banking Details</a></td><%}%> 
<%if (pageid == 9) {%> <td class="main_tab_active" WIDTH="10%" nowrap="nowrap">T&amp;C / Sec. 
Documents </td><%} else {%> <td class="main_tab_inactive" WIDTH="10%" nowrap="nowrap"> 
<a
			href="javascript:gotoPage('comtermsandcond.jsp','')"
			 title="T&amp;C / Sec. Documents" >T&amp;C / Sec. Documents</a> 
</td><%}%> <%if (pageid == 11) {%><td class="main_tab_active" WIDTH="10%"> 
Comments</td><%} else {%> <td class="main_tab_inactive" WIDTH="10%"> 
<a
			href="javascript:gotoPage('comdynamiccashflow.jsp')"
			 title="Comments">Comments</a></td><%}%> <!--The saral tab will be enbled only for saral user when they are creating application in saral level--> 
<% if(cattype.equals("STL")&&(applevel.equals("S")) ){%> <%if (pageid == 16) {%><td class="main_tab_active" WIDTH="10%"> 
SARAL </td><%} else {%><td class="main_tab_inactive" WIDTH="10%">  <a
				href="javascript:gotoPage('facilityrecmdforsanc.jsp')" 
				title="SARAL">SARAL</a> </td><%}%> <% } %> 
<%if (pageid == 8) {%> <td class="main_tab_active" WIDTH="10%">Process Note</td><%} else {%><td class="main_tab_inactive" WIDTH="10%"> 
 <a
			href="javascript:gotoPage('exec_page1.jsp')" 
			title="Process Note">Process Note</a></td><%}%> <%if (pageid == 15) {%><td class="main_tab_active" WIDTH="10%"> 
WorkFlow </td><%} else {%> <td class="main_tab_inactive" WIDTH="10%"> 
<a
			href="javascript:gotoPage('appworkflowhistory.jsp')"
			 title="WorkFlow">WorkFlow</a> </td><%}%> <%} else if (cattype.equalsIgnoreCase("ADC")) {%> 
<%if (pageid == 1) {%> <td class="main_tab_active" WIDTH="10%">Applicant 
</td><%} else {%> <td class="main_tab_inactive" WIDTH="10%"><a
			href="javascript:gotoPage('facilities.jsp')" 
			title="Applicant">Applicant </a> </td><%}%> <%if (pageid == 2) {%> 
<td class="main_tab_active" WIDTH="10%"> Co-Applicant / Guarantor</td><%} else {%><td class="main_tab_inactive" WIDTH="10%"> 
<a href="javascript:gotoPage('compromoters.jsp') "
			 title="Co-Applicant / Guarantor">Co - Applicant / Guarantor</a></td><%}%> <%if (pageid == 7) {%><td class="main_tab_active" WIDTH="10%"> 
Security</td><%} else {%><td class="main_tab_inactive" WIDTH="10%">  
<a href="javascript:gotoPage('com_securities.jsp')"
			 title="Security">Security</a></td><%}%> <%if (pageid == 10) {%><td class="main_tab_active" WIDTH="10%">Banking 
Details</td><%} else {%> <td class="main_tab_inactive" WIDTH="10%"> <a
			href="javascript:gotoPage('adc_bankingdetails.jsp')"
			 title="Banking Details">Banking Details</a> </td><%}%> 
<%if (pageid == 3) {%><td class="main_tab_active" WIDTH="10%"> Financial</td><%} else {%> 
<td class="main_tab_inactive" WIDTH="10%"> <a href="javascript:gotoPage('adc_financials.jsp')"
			 title="Financial"> Financial</a></td><%}%> <%if (pageid == 5) {%><td class="main_tab_active" WIDTH="10%">Value 
of Account</td><%} else {%><td class="main_tab_inactive" WIDTH="10%">  
<a href="javascript:gotoPage('adc_comments.jsp')"
			 title="Value of Account">Value of Account</a></td><%}%> 
<%if (pageid == 11) {%><td class="main_tab_active" WIDTH="10%"> Limit Sought</td><%} else {%> 
<td class="main_tab_inactive" WIDTH="10%"> <a
			href="javascript:gotoPage('adc_limitcomments.jsp')" 
			title="Limit Sought">Limit Sought</a></td><%}%> <%if (pageid == 9) {%> 
<td class="main_tab_active" WIDTH="10%" nowrap="nowrap">T&amp;C / Sec. Documents  </td><%} else {%> 
<td class="main_tab_inactive" WIDTH="10%" nowrap="nowrap"> <a
			href="javascript:gotoPage('comtermsandcond.jsp','')"
			 title="T&amp;C / Sec. Documents">T&amp;C / Sec. Documents</a> 
</td><%}%> <!--The saral tab will be enbled only for saral user when they are creating application --> 
<% if(cattype.equals("ADC") &&  (applevel.equals("S")) )
		  {
		   %> <%if (pageid == 16) {%> <td class="main_tab_active" WIDTH="10%">SARAL 
</td><%} else {%><td class="main_tab_inactive" WIDTH="10%">  <a
				href="javascript:gotoPage('facilityrecmdforsanc.jsp')" 
				title="SARAL">SARAL</a> </td><%}%> <% } %> 
<%if (pageid == 12) {%><td class="main_tab_active" WIDTH="10%"> Business Turn 
Over</td><%} else {%><td class="main_tab_inactive" WIDTH="10%">  <a href="javascript:gotoPage('com_termloancomments.jsp')"
			 title="Financial"> Business Turn Over</a> </td><%}%>	
<%if (pageid == 8) {%><td class="main_tab_active" WIDTH="10%"> Process Note 
</td><%} else {%> <td class="main_tab_inactive" WIDTH="10%"> <a
			href="javascript:gotoPage('exec_page1.jsp')" 
			title="Process Note">Process Note</a> </td><%}%> <%if (pageid == 15) {%> 
<td class="main_tab_active" WIDTH="10%">WorkFlow </td><%} else {%><td class="main_tab_inactive" WIDTH="10%"> 
 <a
			href="javascript:gotoPage('appworkflowhistory.jsp')"
			 title="WorkFlow">WorkFlow</a> </td><%}%> <%}%></tr> </table><input type="hidden" name="hidappval" value=""/> 

</BODY>
</HTML>
