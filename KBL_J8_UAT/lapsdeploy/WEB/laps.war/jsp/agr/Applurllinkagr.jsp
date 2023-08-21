<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@page import="com.sai.fw.management.utils.FwUtils"%>
<lapschoice:handleerror />
<%
			int intLandHoldings=0;
			int intLandHoldingsSecurity=0;
			int intExpectedIncomeandExpenditure=0;
			int intGovtSchemes=0;
			int intfinancialyr=0;
			int intPhysical=0;
			
			String agr_prd_type = Helper.correctNull((String) session.getAttribute("strFacilityAgr")).trim();
			int pageid = FwUtils.parseInt(request.getParameter("pageid"));
			String strSchemeType = "";
			String strselectedscheme=Helper.correctNull((String)request.getParameter("schemetype"));
			strSchemeType=Helper.getfacilitySchemetype(strselectedscheme);
			String schemetype= Helper.correctNull((String)request.getParameter("schemetype"));
			String strFacSNo=Helper.getfacilitySno(schemetype);
			String facility=strFacSNo.concat("-"+strSchemeType);
			String prd_type =Helper.correctNull((String) session.getAttribute("strProductType")).trim();
			String loantype=Helper.correctNull((String)request.getParameter("apploantype"));
			if(prd_type.equalsIgnoreCase(""))
			{
				prd_type = Helper.correctNull((String)request.getParameter("agrscheme"));
			}
			String productcode = "";
			if (prd_type.length() > 0)
				productcode = prd_type.substring(0, 1);

			String grpRights = Helper.correctNull((String) session.getAttribute("strGroupRights"));

			String strSubvention = Helper.correctNull((String) request.getParameter("hid_subvention"));
			if(strSubvention.equalsIgnoreCase(""))
			{
				strSubvention = Helper.correctNull((String) hshValues.get("com_subvention"));
			}
			String strAppflag = Helper.correctNull((String) request.getParameter("strAppflag"));
			String strPageFlow = "";
			String strDosevalue = Helper.correctNull((String) session.getAttribute("strDose"));
			String strgovtsponsor = Helper.correctNull((String) hshValues.get("strgovtsponsor"));
			if(strgovtsponsor.equalsIgnoreCase(""))
			{
				strgovtsponsor=Helper.correctNull((String) session.getAttribute("strgovtsponsor"));
			}
			session.setAttribute("strgovtsponsor",strgovtsponsor);
			String strLoanType=Helper.correctNull((String) hshValues.get("strLoanType"));
			if(strLoanType.equalsIgnoreCase(""))
			{
				strLoanType=Helper.correctNull((String) session.getAttribute("strLoanType"));
			}
			session.setAttribute("strLoanType",strLoanType);
			if (pageid == 50) {
				strPageFlow = "General Details";
			} //else if (pageid == 51) {
				//strPageFlow = " Land Holdings Security";
			//} 
			else if (pageid == 52) {
				if (prd_type.trim().equalsIgnoreCase("aB")
						|| prd_type.trim().equalsIgnoreCase("aT")
						|| prd_type.trim().equalsIgnoreCase("aE"))
					strPageFlow = "Scale of Finance";
				else 
					strPageFlow = "Crop Assessment";
			} else if (pageid == 53)
				strPageFlow = "Cost of Rising per Plant";
			else if (pageid == 54)
				strPageFlow = "Nursery Assessment";
			else if (pageid == 55)
				strPageFlow = "Scale of Finance";
			else if (pageid == 56)
				strPageFlow = "Assessment For Fisheries";
			else if (pageid == 57)
				strPageFlow = "Agency Details";
			else if (pageid == 58)
				strPageFlow = "Tobacco Details";
			else if (pageid == 59)
				strPageFlow = "Farm Mechanisation Implements";
			else if (pageid == 60)
				strPageFlow = "Expected Income & Expenditure";
			else if (pageid == 61)
				strPageFlow = "Income From Custom Hire Service ";
			else if (pageid == 62)
				strPageFlow = "Meeting Details";
			else if (pageid == 64)
				strPageFlow = "Credit Rating";
			else if (pageid == 63)
				strPageFlow = " Group Finance - Financial Position";
			else if (pageid == 64)
				strPageFlow = "Live Stock";
			else if (pageid == 65)
				strPageFlow = "Financial Data";
			else if (pageid == 66)
				strPageFlow = "Milk Flow Chart";
			else if (pageid == 67)
				strPageFlow = "Details of Produce Pledged";
			else if (pageid == 68)
				strPageFlow = "Dose I Details";
			else if (pageid == 69)
				strPageFlow = "Dose II Details";
			else if (pageid == 70)
				strPageFlow = "Plant Details";
			else if (pageid == 71)
				strPageFlow = "Estimated Cost";
			else if (pageid == 72)
				strPageFlow = "Projected Income";
			else if (pageid == 73)
				strPageFlow = "Financial Analysis";
			else if (pageid == 74)
				strPageFlow = "Cost of Project";
			else if (pageid == 75)
				strPageFlow = "Herd Projection Chart";
			else if (pageid == 76)
				strPageFlow = "Project Cost";
			else if (pageid == 77)
				strPageFlow = "Income And Expenses";
			else if (pageid == 78)
				strPageFlow = "Income";
			else if (pageid == 79)
				strPageFlow = "Vehicle Details";
			else if (pageid == 80)
				strPageFlow = "Term Loan Assessment";
			else if (pageid == 81)
				strPageFlow = "Financial Analysis";
			else if (pageid == 82)
				strPageFlow = "Land Details";
			else if (pageid == 83)
				strPageFlow = "Details of Milk Collection";
			else if (pageid == 84)
				strPageFlow = "Land Levelling";
			else if (pageid == 85)
				strPageFlow = "Sheep Agent Details";
			/*else if (pageid == 86)
				strPageFlow = "Cost of Cultivation";*/
			else if (pageid == 87)
				strPageFlow = "Sand Casting";
			else if (pageid == 88)
				strPageFlow = "Soil Reclamation";
			else if (pageid == 89)
				strPageFlow = "Total Income & Expenditure";
			else if (pageid == 90)
				strPageFlow = "Dose III Details";
			else if (pageid == 91)
				strPageFlow = "Income Details";
			else if (pageid == 92)
				strPageFlow = "Crop Assessment";
			else if (pageid == 93)
				strPageFlow = "Minor Irrigation";
			else if (pageid == 94)
				strPageFlow = "Supplier Details";
			else if (pageid == 95)
				strPageFlow = "Land Development Details";
			else if (pageid == 96)
				strPageFlow = "Legal Opinion";
			else if (pageid == 97)
				strPageFlow = "Tech Data";
			else if (pageid == 98)
				strPageFlow = "Economic Data";
			else if (pageid == 99)
				strPageFlow = "Non Recurring Expense";
			else if (pageid == 100)
				strPageFlow = "Recurring Expense";
			else if (pageid == 101)
				strPageFlow = "Flock Replacement";
			else if (pageid == 102)
				strPageFlow = "State of Expense";
			else if (pageid == 103)
				strPageFlow = "State of Income";
			else if (pageid == 104)
				strPageFlow = "Proposed Land Details";
			else if (pageid == 105)
				strPageFlow = "Cash Flow";
			else if (pageid == 106)
				strPageFlow = "IRR Calc";
			else if (pageid == 107)
				strPageFlow = "Govt Schemes";
			else if (pageid == 108)
				strPageFlow = "Live Stock Details";
			else if (pageid == 109)
				strPageFlow = "Technical Data";
			else if (pageid == 110)
				strPageFlow = "Economic Data";
			else if (pageid == 111)
				strPageFlow = "Milk FlowChart";
			else if (pageid == 112)
				strPageFlow = "Cattle Chart";
			else if (pageid == 113)
				strPageFlow = "Income and Expenses";
			else if (pageid == 114)
				strPageFlow = "Godown Details";
			else if (pageid == 115)
				strPageFlow = "Technical Details";
			else if(pageid==116)
				strPageFlow="Particulars";
			else if(pageid==117)
				strPageFlow="Income";
			else if(pageid==118)
				strPageFlow="Expenses";
			else if(pageid==119)
				strPageFlow="Proposed Asset";
			else if(pageid==120)
				strPageFlow="Drying Yard";
			/*else if(pageid==121)
				strPageFlow="Repayment";*/
			else if(pageid==128)
				strPageFlow="Cost of Investment";
			else if(pageid==129)
				strPageFlow="Financial Data";
			else if(pageid==124)
				strPageFlow="Herd Production Chart";
			else if(pageid==125)
				strPageFlow="Income Statement";
			else if(pageid==126)
				strPageFlow="Recurring expenditure";
			else if(pageid==127)
				strPageFlow="Financial Analysis";
			else if (pageid==122)
				strPageFlow="Recuring Expenses";
			else if (pageid==123)
				strPageFlow="Herd Projection Chart";
			else if (pageid==63)
				strPageFlow="Group Finance - Financial Position";
			else if (pageid==207)
				strPageFlow="Existing Inc Other than crop";
			else if (pageid==208)
				strPageFlow="Fencing";
			else if (pageid==209)
				strPageFlow="Farm Forestry";
			else if (pageid==224)
				strPageFlow="Income statement";
			else if (pageid==210)
				strPageFlow="SHG Assessment";
			else if (pageid==211)
				strPageFlow="Net Income";
			else if (pageid==212)
				strPageFlow="Goods Details";
			else if (pageid==213)
				strPageFlow="Interest Subvention Details";
			
			
			String strCategoryType = Helper.correctNull((String) request.getParameter("hidCategoryType"));
			strCategoryType.trim();
			if (strCategoryType.equalsIgnoreCase("CORPORATE")) {
				strCategoryType = "CORP";
			}else if (strCategoryType.equalsIgnoreCase("")) {
				strCategoryType = Helper.correctNull((String) hshValues.get("hidCategoryType"));
				if (strCategoryType.equalsIgnoreCase("CORPORATE")) {
					strCategoryType = "CORP";
				}
			}
			
			String strSSIType = Helper.correctNull((String) request.getParameter("hidSSIType"));
			if (strSSIType.equalsIgnoreCase("")) {
				strSSIType = Helper.correctNull((String) hshValues.get("hidSSIType"));
			}
			
			String facility_count = Helper.correctNull((String) hshValues.get("facility_count"));
			%>
			

<HTML>
<HEAD>
<TITLE>Application Form Navigation</TITLE>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript">
var pageid=parseInt("<%=pageid%>");
var strAppflag="<%=strAppflag%>";
var strSchemeType="<%=strSchemeType%>";
var loantype="<%=loantype%>";
function gotoLink(pagename)
{		
	if(document.forms[0].cmdsave.disabled == false )
	{
		ShowAlert(103);
		return;
	}
	if(pagename=="agr_economicdata.jsp")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_economicdata.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	if(pagename=="agr_dairycattlechart.jsp")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_dairycattlechart.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	if(pagename=="dairyfarmingappraisal.jsp")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/dairyfarmingappraisal.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	if(pagename=="agr_appraisalconfirmgovt.jsp")
	{
		document.forms[0].hidBeanId.value="insreport";
		document.forms[0].hidBeanGetMethod.value="getDataQuestParameters";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_appraisalconfirmgovt.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	if(pagename=="agr_poultry_irr.jsp")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_poultry_irr.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	if(pagename=="agr_poultrycashflow.jsp")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_poultrycashflow.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	if(pagename=="agr_legal_opinion.jsp")
	{
		document.forms[0].hidBeanId.value="agriloanassessment";
		document.forms[0].hidBeanGetMethod.value="getLegalOpinionData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_legal_opinion.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	if(pagename=="agr_poultry_broilertech.jsp")
	{
		document.forms[0].hidBeanId.value="agriloanassessment";
		document.forms[0].hidBeanGetMethod.value="getpoultrytechdata";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_poultry_broilertech.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	if(pagename=="agr_poultry_broilerfin.jsp")
	{
		document.forms[0].hidBeanId.value="agriloanassessment";
		document.forms[0].hidBeanGetMethod.value="getpoultrybroilerfindata";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_poultry_broilerfin.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();			
	}
	if(pagename=="agr_poultry_broinonrec.jsp")
	{
		document.forms[0].hidBeanId.value="agriloanassessment";
		document.forms[0].hidBeanGetMethod.value="getbroinonrecurringData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_poultry_broinonrec.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	//if(pagename=="agr_poultry_broirec.jsp")
	//{
	//	document.forms[0].hidBeanId.value="agriloanassessment";
	//	document.forms[0].hidBeanGetMethod.value="getbroirecurringData";
	//	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_poultry_broirec.jsp";
	//	document.forms[0].target="mainFrame";
	//	document.forms[0].submit();
			
	//}
	if(pagename=="agr_poultry_broiflockrep.jsp")
	{
		document.forms[0].hidBeanId.value="agriloanassessment";
		document.forms[0].hidBeanGetMethod.value="getbroiagrflock";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_poultry_broiflockrep.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	if(pagename=="agr_poultry_broiflowchart.jsp")
	{
		document.forms[0].hidBeanId.value="agriloanassessment";
		document.forms[0].hidBeanGetMethod.value="getpoultrybroiflowchartData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_poultry_broiflowchart.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	if(pagename=="agr_poultry_broilerinc.jsp")
	{
		document.forms[0].hidBeanId.value="agriloanassessment";
		document.forms[0].hidBeanGetMethod.value="getpoultrybroiincomeflowData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_poultry_broilerinc.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	if(pagename=="agr_reclamationofsoil.jsp")
	{
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidBeanGetMethod.value="getSoilReclamation";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_reclamationofsoil.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	if(pagename=="agr_hortiincexp.jsp")
	{
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidBeanGetMethod.value="getHorticultureIncomeExp";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_hortiincexp.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}	
	if(pagename=="agr_hortifinancialprogramme.jsp")
	{
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidBeanGetMethod.value="getHortiFinancialProgramme";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_hortifinancialprogramme.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}	
	if(pagename=="agr_sandcasting.jsp")
	{
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidBeanGetMethod.value="getSandCasting";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_sandcasting.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	
	if(pagename=="agr_onfarmdevelopment.jsp")
	{
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidBeanGetMethod.value="getOnFarmDevelopment";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_onfarmdevelopment.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	
	if(pagename=="agr_sheepagentdetails.jsp")
	{
		document.forms[0].hidBeanId.value="agrnursery";
		document.forms[0].hidBeanGetMethod.value="getSheepAgentDetails";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_sheepagentdetails.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	
	if(pagename=="agr_milkcollection.jsp")
	{
		document.forms[0].hidBeanId.value="agrnursery";
		document.forms[0].hidBeanGetMethod.value="getMilkCollection";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_milkcollection.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	if(pagename=="agr_sheepfinancialAnalysis.jsp")
	{
		document.forms[0].hidBeanId.value="agrfarmmachinery";
		document.forms[0].hidBeanGetMethod.value="getSheepFinancialAnalysis";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_sheepfinancialAnalysis.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	if(pagename=="agrlanddetails.jsp")
	{
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidBeanGetMethod.value="getLandDetails";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrlanddetails.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	
	if(pagename=="agr_fisheriesexcavation.jsp")
	{
		document.forms[0].hidBeanId.value="agrnursery";
		document.forms[0].hidBeanGetMethod.value="getFisheriesExcavation";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_fisheriesexcavation.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	if(pagename=="agr_sheepincome.jsp")
	{
		document.forms[0].hidBeanId.value="agrnursery";
		document.forms[0].hidBeanGetMethod.value="getSheepIncome";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_sheepincome.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	if(pagename=="perappvehicle.jsp")
	{
		document.forms[0].hidBeanGetMethod.value="getBoatAuto";
		document.forms[0].hidBeanId.value="percollateral";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perappvehicle.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	if(pagename=="perappvehicleagri.jsp")
	{
		document.forms[0].hidBeanGetMethod.value="getAgriAuto";
		document.forms[0].hidBeanId.value="percollateral";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perappvehicleagri.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	if(pagename=="agr_sericultureincexp.jsp")
	{
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidBeanGetMethod.value="getSericultureIncomeExp";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_sericultureincexp.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	if(pagename=="agr_sericultureincstatement.jsp")
	{
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidBeanGetMethod.value="getSericultureIncomeStatement";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_sericultureincstatement.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	if(pagename=="agr_sheepherdprojchart.jsp")
	{
		document.forms[0].hidBeanId.value="agrnursery";
		document.forms[0].hidBeanGetMethod.value="getSheepHerdProjectionChart";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_sheepherdprojchart.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	
	if(pagename=="agr_sericultureprojcost.jsp")
	{
		document.forms[0].schemetype.value=document.forms[0].sel_scheme.value;
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidBeanGetMethod.value="getSericultreProjectDetails";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_sericultureprojcost.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	if(pagename=="agr_sheeprearcostofproj.jsp")
	{
		document.forms[0].hidBeanId.value="agrnursery";
		document.forms[0].hidBeanGetMethod.value="getSheepRearingCostOfProject";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_sheeprearcostofproj.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}

	if(pagename=="agr_hortifinancialanalysis.jsp")
	{
		document.forms[0].hidBeanId.value="agrnursery";
		document.forms[0].hidBeanGetMethod.value="getHorticultureFinancialAnalysis";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_hortifinancialanalysis.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	
	if(pagename=="agr_hortiprojectedincome.jsp")
	{
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidBeanGetMethod.value="getHortiProjectedIncome";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_hortiprojectedincome.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}	
	if(pagename=="agr_horticulturecostofdevelopment.jsp")
	{
		document.forms[0].schemetype.value=document.forms[0].sel_scheme.value;
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidBeanGetMethod.value="getHortiCostOfDevelopmentDetails";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_horticulturecostofdevelopment1.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}	
	if(pagename=="agr_horticultureplantdetails.jsp")
	{
	   document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidBeanGetMethod.value="getHortiData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_horticultureplantdetails.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}	
	if(pagename=="agr_shgfinanceposition.jsp")
	{
		document.forms[0].hidBeanId.value="agrSHGloan";
		document.forms[0].hidBeanGetMethod.value="getSHGFinancePositionDetails";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_shgfinanceposition.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}	
	if(pagename=="agrSHGotherfinancialposition.jsp")
	{
		document.forms[0].hidBeanId.value="agrSHGloan";
		document.forms[0].hidBeanGetMethod.value="getSHGOtherFinancePositionDetails";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrSHGotherfinancialposition.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}	
	if(pagename=="agrSHGcorpusofgroup.jsp")
	{
		document.forms[0].hidBeanId.value="agrSHGloan";
		document.forms[0].hidBeanGetMethod.value="getSHGCorpusDetails";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrSHGcorpusofgroup.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}	
	if(pagename=="agr_capldetails.jsp")
	{
		document.forms[0].hidBeanId.value="agriculture";
		document.forms[0].hidBeanGetMethod.value="getcapldata";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_capldetails.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}	
	if(pagename=="agr_capl_goodsdetails.jsp")
	{
		document.forms[0].hidBeanId.value="agriculture";
		document.forms[0].hidBeanGetMethod.value="getcaplGoodsdata";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_capl_goodsdetails.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}	
	if(pagename=="agrSHGmeetingdetail.jsp")
	{
		//document.forms[0].hidBeanId.value="agrSHGloan";
		//document.forms[0].hidBeanGetMethod.value="getSHGMeetingDetails";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrSHGmeetingdetail.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}	
	if(pagename=="agrSHGcreditrating.jsp")
	{
			//document.forms[0].hidBeanId.value="agrSHGloan";
			//document.forms[0].hidBeanGetMethod.value="getCreditRatingDetails";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrSHGcreditrating.jsp";
			document.forms[0].target="mainFrame";
			document.forms[0].submit();
			
	}	
	if(pagename=="agrlandholdings.jsp")
	{
			document.forms[0].hidBeanId.value="agrlandholdings";
			document.forms[0].hidBeanGetMethod.value="getData";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrlandholdings.jsp";
			document.forms[0].target="mainFrame";
			document.forms[0].submit();
			
	}	
	if(pagename=="agrfinancialyears.jsp")
	{
			document.forms[0].hidBeanId.value="agrnursery";
			document.forms[0].hidBeanGetMethod.value="getAgriFinancialYear";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrfinancialyears.jsp";
			document.forms[0].target="mainFrame";
			document.forms[0].submit();
			
	}	
	if(pagename=="agrPhysicalStatement.jsp")
	{
		document.forms[0].hidBeanId.value="agrnursery";
		document.forms[0].hidBeanGetMethod.value="getAgriFinancialYear";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrPhysicalStatement.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="agrlandholdingssecurity.jsp")
	{
			document.forms[0].hidBeanId.value="agrlandholdings";
			document.forms[0].hidBeanGetMethod.value="getLandHoldingsSecurity";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrlandholdingssecurity.jsp";
			document.forms[0].target="mainFrame";
			document.forms[0].submit();
	}
	else if(pagename=="agrcropassessment.jsp")
	{
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidBeanGetMethod.value="getCropAssessmentDetails";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrcropassessment.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="agr_intSubvention.jsp")
	{
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidBeanGetMethod.value="getInterestSubventionDetails";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_intSubvention.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="agr_croppingpattern.jsp")
	{
			if(loantype=="A")
			{
				document.forms[0].schemetype.value=document.forms[0].sel_scheme.value;
			}
			else{
				document.forms[0].schemetype.value=" ";
			}
			document.forms[0].hidBeanId.value="agrcrops";
			document.forms[0].hidBeanGetMethod.value="getCroppingPatterns";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_croppingpattern.jsp";
			document.forms[0].target="mainFrame";
			document.forms[0].submit();
	}
	else if(pagename=="agrcostofrising.jsp")
	{
		document.forms[0].hidBeanId.value="agrnursery";
		document.forms[0].hidBeanGetMethod.value="getCostOfRising";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrcostofrising.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=='agrfisheries.jsp')
	{
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidBeanGetMethod.value="getFisheriesDetails";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrfisheries.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=='agr_fisherywcassessment.jsp')
	{
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidBeanGetMethod.value="getFisheriesDetails";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_fisherywcassessment.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	
	else if(pagename=='agrnurseryassessment.jsp')
	{
		document.forms[0].hidBeanId.value="agrnursery";
		document.forms[0].hidBeanGetMethod.value="getNurseryAssessment";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrnurseryassessment.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=='agrnurseryloanassess.jsp')
	{
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidBeanGetMethod.value="getCropAssessmentDetails";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrnurseryloanassess.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="agrtieupagencydetails.jsp")
	{
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidBeanGetMethod.value="getAgencyDetails";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrtieupagencydetails.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="agrtobaccodetails.jsp")
	{
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidBeanGetMethod.value="getTobaccoDetails";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrtobaccodetails.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="agrfarmmachinerydetails.jsp")
	{
			document.forms[0].hidBeanId.value="agrfarmmachinery";
			document.forms[0].hidBeanGetMethod.value="getFarmMachineryDetails";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrfarmmachinerydetails.jsp";
			document.forms[0].target="mainFrame";
			document.forms[0].submit();
	}
	else if(pagename=="agrfarmincomehire.jsp")
	{
			document.forms[0].hidBeanId.value="agrfarmmachinery";
			document.forms[0].hidBeanGetMethod.value="getIncomeHireDetails";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrfarmincomehire.jsp";
			document.forms[0].target="mainFrame";
			document.forms[0].submit();
	}
    else if(pagename=="agrlivestockdetails.jsp")
	{
		//document.forms[0].hidBeanId.value="agrlandholdings";
		//document.forms[0].hidBeanGetMethod.value="getDataLiveStock";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrlivestockdetails.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="agr_diaryfindata.jsp")
	{
			//document.forms[0].hidBeanId.value="agrlandholdings";
			//document.forms[0].hidBeanGetMethod.value="getdiaryfinData";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_diaryfindata.jsp";
			document.forms[0].target="mainFrame";
			document.forms[0].submit();
	}
	else if(pagename=="agr_LDCows.jsp")
	{
			//document.forms[0].hidBeanId.value="agrlandholdings";
			//document.forms[0].hidBeanGetMethod.value="getLDdata";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_LDCows.jsp";
			document.forms[0].target="mainFrame";
			document.forms[0].submit();
	}
	else if(pagename=="agrSHGdose1.jsp")
	{
			document.forms[0].hidPageId.value	=	"Dose1";
			document.forms[0].hidBeanId.value="agrSHGloan";
			document.forms[0].hidBeanGetMethod.value="getDoseDetails";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrSHGdose1.jsp";
			document.forms[0].target="mainFrame";
			document.forms[0].submit();
	}
	else if(pagename=="agrSHGdose2.jsp")
	{
			document.forms[0].hidPageId.value	=	"Dose2";
			document.forms[0].hidBeanId.value="agrSHGloan";
			document.forms[0].hidBeanGetMethod.value="getDose1Details";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrSHGdose2.jsp";
			document.forms[0].target="mainFrame";
			document.forms[0].submit();
	}
	else if(pagename=="agrSHGdose3.jsp")
	{
			document.forms[0].hidPageId.value	=	"Dose3";
			document.forms[0].hidBeanId.value="agrSHGloan";
			document.forms[0].hidBeanGetMethod.value="getDose1Details";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrSHGdose3.jsp";
			document.forms[0].target="mainFrame";
			document.forms[0].submit();
	}
	else if(pagename=="agr_minorirrigation.jsp")
	{
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidBeanGetMethod.value="getfarmMechMinorIrrig";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_minorirrigation.jsp?tabid=P";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="otherassets.jsp")
	{
		document.forms[0].hidBeanId.value="perpropertydetails";
		document.forms[0].hidBeanGetMethod.value="getOtherAssetData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/otherassets.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="agrkissangreencardinc.jsp")
	{
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidBeanGetMethod.value="getGreenCardIncDetails";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrkissangreencardinc.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="agr_landdevelopmentdetails.jsp")
	{
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidBeanGetMethod.value="getLandDevelopment";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_landdevelopmentdetails.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="agr_rituliabscaleoffinance.jsp")
	{
		
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_rituliabscaleoffinance.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="agr_godowndetails.jsp")
	{
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidBeanGetMethod.value="getGodownDetails";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_godowndetails.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="agr_techdetails.jsp")
	{
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidBeanGetMethod.value="getTechDetails";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_techdetails.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="agr_loanparticulars.jsp")
	{
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidBeanGetMethod.value="getLoanRequirementsData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_loanparticulars.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="agr_income.jsp")
	{
		document.forms[0].hidBeanId.value="agrcommon";
		document.forms[0].hidBeanGetMethod.value="getIncome";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_income.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="agr_expense.jsp")
	{
		document.forms[0].hidBeanId.value="agrcommon";
		document.forms[0].hidBeanGetMethod.value="getExpense";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_expense.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="perpropertydetails.jsp")
	{
		document.forms[0].hidBeanId.value="perpropertydetails";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perpropertydetails.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="agr_dryingyard.jsp")
	{
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidBeanGetMethod.value="getDryingYard";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_dryingyard.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="agr_repayment.jsp")
	{
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidBeanGetMethod.value="getPlantationRepayment";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_repayment.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="agr_dairycostofinvestment.jsp")
	{
		document.forms[0].schemetype.value=document.forms[0].sel_scheme.value;
		document.forms[0].hidBeanId.value="agrnursery";
		document.forms[0].hidBeanGetMethod.value="getDairyCostofInvestment";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_dairycostofinvestment.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="agr_dairyfinancialdata.jsp")
	{
		document.forms[0].schemetype.value=document.forms[0].sel_scheme.value;
		document.forms[0].hidBeanId.value="agrnursery";
		document.forms[0].hidBeanGetMethod.value="getDairyFinancialData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_dairyfinancialdata.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="agr_dairyherdproductionchart.jsp")
	{
		document.forms[0].schemetype.value=document.forms[0].sel_scheme.value;
		document.forms[0].hidBeanId.value="agrnursery";
		document.forms[0].hidBeanGetMethod.value="getDairyHerdProductionChart";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_dairyherdproductionchart.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="agr_dairyincomestatement.jsp")
	{
		document.forms[0].schemetype.value=document.forms[0].sel_scheme.value;
		document.forms[0].hidBeanId.value="agrnursery";
		document.forms[0].hidBeanGetMethod.value="getDairyIncomeStatement";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_dairyincomestatement.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="agr_dairyrecurringexpenditure.jsp")
	{
		document.forms[0].schemetype.value=document.forms[0].sel_scheme.value;
		document.forms[0].hidBeanId.value="agrnursery";
		document.forms[0].hidBeanGetMethod.value="getDairyRecurringExpenditure";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_dairyrecurringexpenditure.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="agr_dairyfinancialanalysis.jsp")
	{
		document.forms[0].hidBeanId.value="agrnursery";
		document.forms[0].hidBeanGetMethod.value="getDairyFinancialAnalysis";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_dairyfinancialanalysis.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename == "agr_fishery_particulars.jsp")
	{
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidBeanGetMethod.value="getFisheryParticularsData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_fishery_particulars.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename == "agr_fishersinvest.jsp")
	{
		document.forms[0].hidBeanId.value="fishersinvest";
		document.forms[0].hidBeanGetMethod.value="getfishersinvest";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_fishersinvest.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename == "agr_common_loanrequirements.jsp")
	{
		document.forms[0].hidBeanId.value="agrcommon";
		document.forms[0].hidBeanGetMethod.value="getLoanRequirementsData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_common_loanrequirements.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename == "agr_marketingfisheries.jsp")
	{
		document.forms[0].hidBeanId.value="fishersinvest";
		document.forms[0].hidBeanGetMethod.value="getmarketingfisheries";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_marketingfisheries.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename == "agrMachBoatSurplus.jsp")
	{
		document.forms[0].hidBeanId.value="agriculture";
		document.forms[0].hidBeanGetMethod.value="getCatchesSurplusList";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrMachBoatSurplus.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename == "agrMachBoatOPExpenses.jsp")
	{
		document.forms[0].hidBeanId.value="agriculture";
		document.forms[0].hidBeanGetMethod.value="getOperatingExpenses";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrMachBoatOPExpenses.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename == "agr_bullockdata.jsp")
	{
		document.forms[0].hidBeanId.value="agriculture";
		document.forms[0].hidBeanGetMethod.value="getbullockdata";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_bullockdata.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename == "agr_bullockfinancialdata.jsp")
	{
		document.forms[0].hidBeanId.value="agriculture";
		document.forms[0].hidBeanGetMethod.value="getBullockFinancial";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_bullockfinancialdata.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename == "agr_bullock_particulars.jsp")
	{
		document.forms[0].hidBeanId.value="agriculture";
		document.forms[0].hidBeanGetMethod.value="getBullockParticulars";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_bullock_particulars.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}else if(pagename=="agr_gobartechdata.jsp")
	{
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidBeanGetMethod.value="getgobartechdata";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_gobartechdata.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="agr_agriprogram.jsp")
	{
		document.forms[0].hidBeanId.value="bankappfi";
		document.forms[0].hidBeanGetMethod.value="getFinProgramme";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_agriprogram.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	else if(pagename=="agr_existingincomeotherthancrop.jsp")
	{
		document.forms[0].hidBeanId.value="bankappfi";
		document.forms[0].hidBeanGetMethod.value="getExsincotherthancrop";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_existingincomeotherthancrop.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	else if(pagename=="agr_fencing.jsp")
	{
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidBeanGetMethod.value="getFencingdet";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_fencing.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	else if(pagename=="agr_farmforestry.jsp")
	{
		document.forms[0].hidBeanId.value="agrfarmmachinery";
		document.forms[0].hidBeanGetMethod.value="getFarmForestrydet";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_farmforestry.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
			
	}
	else if(pagename=="com_shgassessment.jsp")
	{
	  	document.forms[0].hidBeanId.value="compro";
		document.forms[0].hidBeanGetMethod.value="getSHGAssessment";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/com_shgassessment.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename == "agr_netincome.jsp")
	{
		document.forms[0].hidBeanId.value="agriculture";
		document.forms[0].hidBeanGetMethod.value="getNetincome";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_netincome.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="com_farmbudget.jsp")
	{
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanGetMethod.value="getFarmBudget";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/com_farmbudget.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="per_dssassessment.jsp")
	{
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanGetMethod.value="getDSS";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/per_dssassessment.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="DSCR.jsp")
	{
		document.forms[0].hidBeanId.value="dscr";
		document.forms[0].hidBeanGetMethod.value="getDataForDSCR";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/DSCR.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
}
function callAgriTabs()
{
	var strSeldSchemeType=document.forms[0].sel_scheme.options[document.forms[0].sel_scheme.selectedIndex].value;
	var SchemeTypeArr=new Array();
	var SchemeTypeDesc="";
	SchemeTypeArr=strSeldSchemeType.split("-");
	if(SchemeTypeArr.length>1)
	{
		SchemeTypeDesc=SchemeTypeArr[1];
	}
	if(SchemeTypeDesc=="aS")
	{
		document.forms[0].schemetype.value=document.forms[0].sel_scheme.value;
		document.forms[0].hidBeanId.value="agrSHGloan";
		document.forms[0].hidBeanGetMethod.value="getSHGFinancePositionDetails";
		document.forms[0].action = appUrl+"action/agr_shgfinanceposition.jsp";
		document.forms[0].submit();
	}
	else
	{	
		document.forms[0].schemetype.value=document.forms[0].sel_scheme.value;
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action = appUrl+"action/agrlandholdings.jsp";
		document.forms[0].submit();
	}
	
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</HEAD>
<BODY>
<%if(loantype.equalsIgnoreCase("A")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td align="left" width="15%" nowrap>&nbsp;&nbsp;Select the Scheme Type </td> &nbsp;
		<td align="left" width="85%"><select name="sel_scheme" onchange="callAgriTabs()">
		<%String strappno = request.getParameter("appno");		%> 
		<option value="0" >--Select--</option>
			<lapschoice:AgriSchemes appno='<%=strappno%>' /> 
<!--				<option value="aV" selected>Land Development</option>			-->
	</select></td>
	</tr>
</table>
<br>
<%} else{%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr><td>&nbsp;</td></tr>
</table>
<%} %>
<%if(loantype.equalsIgnoreCase("P")){ %>
<table width="100%" border="0" cellspacing="1" cellpadding="3">
	<tr>
<%if (pageid == 60 && intExpectedIncomeandExpenditure==0) {
				%>
	<td width="10%" align="center" class="main_tab_active" nowrap>Income From Crops</td>
	<% intExpectedIncomeandExpenditure++;} else if(intExpectedIncomeandExpenditure==0){
				%>
	<td width="10%" align="center" nowrap class="main_tab_inactive"><a
		href="javascript:gotoLink('agr_croppingpattern.jsp')"
		>Income From Crops</a></td>
	<%}
if (pageid == 207) {

	%>
<td width="10%" align="center" class="main_tab_active" nowrap>Existing Inc Other than crop
</td>
<%} else {
	%>
<td width="10%" align="center" nowrap class="main_tab_inactive"><a
href="javascript:gotoLink('agr_existingincomeotherthancrop.jsp')">Existing Inc Other than crop</a></td>
<%}	
if (pageid == 19) {
	%>
<td width="10%" align="center" class="main_tab_active" nowrap>Farm Budget
</td>
<%} else {
	%>
<td width="10%" align="center" nowrap class="main_tab_inactive"><a
href="javascript:gotoLink('com_farmbudget.jsp')">Farm Budget</a></td>
<%}if (pageid == 109) {
	%>
	<td width="10%" align="center" class="main_tab_active" nowrap>Debt Servicing statement
	</td>
	<%} else {
		%>
	<td width="10%" align="center" nowrap class="main_tab_inactive"><a
	href="javascript:gotoLink('per_dssassessment.jsp')">Debt Servicing statement</a></td>
	<%}	
	if(pageid==7){ %>
						<td width="10%" class="sub_tab_active" nowrap style="text-align: center">DSCR</td>
						<%}else { %>				
			          	<td width="10%" class="sub_tab_inactive" nowrap style="text-align: center"> <a href="#" onclick="javascript:gotoLink('DSCR.jsp')"
							onMouseOut="window.status='';return true;" onMouseOver="window.status='ASSESSMENT';return true;"> 
			            	DSCR</a> 
			            </td>															
					<%}%>
	</tr>
	</table>
<%}else{ %>
<table width="100%" border="0" cellspacing="1" cellpadding="3">
	<tr>
	<%StringTokenizer agrprdtypesplit= new StringTokenizer(agr_prd_type,"@");
				//while(agrprdtypesplit.hasMoreTokens())			
				{
					//prd_type=Helper.getfacilitySchemetype((String)agrprdtypesplit.nextToken());
					prd_type=strSchemeType;
					
					{ %> 
		<%
			if (pageid == 50 && intLandHoldings==0) {
		%>
			<td width="10%" align="center" class="main_tab_active" nowrap>General Details</td>
			<% intLandHoldings++;} else if(intLandHoldings==0)   { %>
			<td width="10%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('agrlandholdings.jsp')">General Details</a></td>
			<%intLandHoldings++; }
			//if (pageid == 51 && intLandHoldingsSecurity==0) { 
				
			if (!prd_type.trim().equalsIgnoreCase("aQ") && !strSchemeType.trim().equalsIgnoreCase("aQ")) {
				if(!strLoanType.trim().equalsIgnoreCase("OD")){
			if (pageid == 51) {
		%>
			<td width="10%" align="center" class="main_tab_active" nowrap>Physical and Financial Programme</td>
			<%} else { %>
			<td width="10%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('agr_agriprogram.jsp')">Physical and Financial Programme</a></td>
			<% }}}
			%> 
			
			<!-- <td width="10%" align="center" class="main_tab_active" nowrap>Land
		Holdings Security</td> -->
		<%// intLandHoldingsSecurity++;} else if(intLandHoldingsSecurity==0) {

				%>
		<!--  <td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('agrlandholdingssecurity.jsp')"
			class="main_tab_inactive">Land Holdings Security</a></td>-->
		<% //intLandHoldingsSecurity++;}%>
		<%if (pageid == 60 && intExpectedIncomeandExpenditure==0) {
				%>
	<td width="10%" align="center" class="main_tab_active" nowrap>Income From Crops</td>
	<% intExpectedIncomeandExpenditure++;} else if(intExpectedIncomeandExpenditure==0){
				%>
	<td width="10%" align="center" nowrap class="main_tab_inactive"><a
		href="javascript:gotoLink('agr_croppingpattern.jsp')"
		>Income From Crops</a></td>
	<% intExpectedIncomeandExpenditure++;}
		
		if (pageid == 207) {

			%>
<td width="10%" align="center" class="main_tab_active" nowrap>Existing Inc Other than crop
</td>
<%} else {
			%>
<td width="10%" align="center" nowrap class="main_tab_inactive"><a
	href="javascript:gotoLink('agr_existingincomeotherthancrop.jsp')">Existing Inc Other than crop</a></td>
<%}		
		if (prd_type.trim().equalsIgnoreCase("aS") && strSchemeType.trim().equalsIgnoreCase("aS")) { %>
		<%if (pageid == 63) {%>
		<td width="14%" align="center" nowrap class="main_tab_active">Group Finance - Financial Position</td>
		<%} else{ %>
		<td width="14%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('agr_shgfinanceposition.jsp')">Group Finance - Financial Position</a></td>
		<%}
				if (pageid == 210) {%>
		<td width="14%" align="center" nowrap class="main_tab_active" >SHG Assessment</td>
		<%} else { %>
			<td width="14%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('com_shgassessment.jsp')">SHG Assessment</a></td>
<%}}%>
		<!-- <%if (prd_type.trim().equalsIgnoreCase("aY") && strSchemeType.trim().equalsIgnoreCase("aY")) {
	
		if (pageid == 209) {

	%>
<td width="10%" align="center" class="main_tab_active" nowrap>Farm Forestry
</td>
<%} else {
	%>
<td width="10%" align="center" nowrap class="main_tab_inactive"><a
href="javascript:gotoLink('agr_farmforestry.jsp')">Farm Forestry</a></td>
<%}	} %> -->	
		
		
		
		
		
			<%if(prd_type.trim().equalsIgnoreCase("aQ") && strSchemeType.trim().equalsIgnoreCase("aQ")){
					 if(pageid==52) { %>
							<td width="10%" align="center" class="main_tab_active" nowrap>Assessment of Limit</td>
							<%}else { %>
							<td width="10%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('agrcropassessment.jsp')">Assessment of Limit</a></td>
					<%  }	
					 //if(strSubvention.trim().equalsIgnoreCase("Y")){
					 if(pageid==213) { %>
						<td width="10%" align="center" class="main_tab_active" nowrap>Interest Subvention Details</td>
						<%}else { %>
						<td width="10%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('agr_intSubvention.jsp')">Interest Subvention Details</a></td>
				<%  }
					 //}
					 }
				if(prd_type.trim().equalsIgnoreCase("aU") && strSchemeType.trim().equalsIgnoreCase("aU")){
							 if(pageid==52) { %>
							<td width="10%" align="center" class="main_tab_active" nowrap>Crop Assessment</td>
							<%}else { %>
							<td width="10%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('agrcropassessment.jsp')">Crop Assessment</a></td>
					<%  }}
				if (prd_type.trim().equalsIgnoreCase("aL") &&  strSchemeType.trim().equalsIgnoreCase("aL")) {
					if (pageid == 104) {

					%>
		<td width="10%" align="center" class="main_tab_active" nowrap>Proposed Land
		Details</td>
		<%} else {

					%>
		<td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('agrlanddetails.jsp')">Proposed Land
		Details</a></td>
		<%}

				}

				if (prd_type.trim().equalsIgnoreCase("aP") && strSchemeType.trim().equalsIgnoreCase("aP")) {
					if (pageid == 79) {

					%>
		<td width="10%" align="center" class="main_tab_active" nowrap>Vehicle
		Details</td>
		<%} else {

					%>
		<td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('perappvehicleagri.jsp')">Vehicle
		Details</a></td>
		<%}if (pageid == 61) {

			%>
<td width="10%" align="center" class="main_tab_active" nowrap>Income
From Custom Hire Service</td>
<%} else {

			%>
<td width="10%" align="center" nowrap class="main_tab_inactive"><a
	href="javascript:gotoLink('agrfarmincomehire.jsp')"
	>Income From Custom Hire Service</a></td>
<%}

				}

				// if (prd_type.trim().equalsIgnoreCase("aG")) {
					//if (pageid == 74) {

%>
		<!--  <td width="10%" align="center" class="main_tab_active" nowrap>Cost of
		Project</td>
		<%//} else {

					%>
		<td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('agr_sheeprearcostofproj.jsp')"
			class="main_tab_inactive">Cost of Project</a></td>-->
		<%//}

				//}

				//if (prd_type.trim().equalsIgnoreCase("aG")) {
					//if (pageid == 75) {

					%>
		<!--<td width="10%" align="center" class="main_tab_active" nowrap>Herd
		Projection Chart</td>
		<%//} else {

					%>
		<td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('agr_sheepherdprojchart.jsp')"
			class="main_tab_inactive">Herd Projection Chart</a></td>
		<%//}

				//}
				if (prd_type.trim().equalsIgnoreCase("aG") && strSchemeType.trim().equalsIgnoreCase("aG")) {
					//if (pageid == 78) {

					%>
		<td width="10%" align="center" class="main_tab_active" nowrap>Income</td>
		<%//} else {

					%>
		<td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('agr_sheepincome.jsp')"
			class="main_tab_inactive">Income</a></td>-->
		<%//}
					if (pageid == 114) {

						%>
			<td width="10%" align="center" class="main_tab_active" nowrap>Godown Details</td>
			<%} else {

						%>
			 <td width="10%" align="center" nowrap class="main_tab_inactive"><a
				href="javascript:gotoLink('agr_godowndetails.jsp')"
				>Godown Details</a></td>
			<%}		
		if (pageid == 115) {

			%>
<td width="10%" align="center" class="main_tab_active" nowrap>Technical Details</td>
<%} else {

			%>
 <td width="10%" align="center" nowrap class="main_tab_inactive"><a
	href="javascript:gotoLink('agr_techdetails.jsp')"
	>Technical Details</a></td>
<%}	
		if (pageid == 116) {

			%>
<td width="10%" align="center" class="main_tab_active" nowrap>Loan Particulars</td>
<%} else {

			%>
 <td width="10%" align="center" nowrap class="main_tab_inactive"><a
	href="javascript:gotoLink('agr_loanparticulars.jsp')"
	>Loan Particulars</a></td>
<%}	
		if (pageid == 117) {

			%>
<td width="10%" align="center" class="main_tab_active" nowrap>Godown Income</td>
<%} else {

			%>
 <td width="10%" align="center" nowrap class="main_tab_inactive"><a
	href="javascript:gotoLink('agr_income.jsp')"
	>Godown Income</a></td>
<%}	
		if (pageid == 118) {

			%>
<td width="10%" align="center" class="main_tab_active" nowrap> GodownExpenses</td>
<%} else {

			%>
 <td width="10%" align="center" nowrap class="main_tab_inactive"><a
	href="javascript:gotoLink('agr_expense.jsp')"
	>Godown Expenses</a></td>
<%}	
				}
				//if (prd_type.trim().equalsIgnoreCase("aG")) {
					//if (pageid == 81) {

					%>
		<!-- <td width="10%" align="center" class="main_tab_active" nowrap>Financial
		Analysis</td>
		<%//} else {

					%>
		<td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('agr_sheepfinancialAnalysis.jsp')"
			class="main_tab_inactive">Financial Analysis</a></td>-->
		<%//}

				//}


			
				if (prd_type.trim().equalsIgnoreCase("aH") && strSchemeType.trim().equalsIgnoreCase("aH")) {
					if (pageid == 70) {

					%>
		<td width="10%" align="center" class="main_tab_active" nowrap>Plant
		Details</td>
		<%} else {

					%>
		<td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('agr_horticultureplantdetails.jsp')"
			>Plant Details</a></td>
		<%}

				}
				if (prd_type.trim().equalsIgnoreCase("aH") && strSchemeType.trim().equalsIgnoreCase("aH")) {
					if (pageid == 71) {

					%>
		<td width="10%" align="center" class="main_tab_active" nowrap>Estimated
		Cost</td>
		<%} else {

					%>
		<td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('agr_horticulturecostofdevelopment.jsp')"
			>Estimated Cost</a></td>
		<%}

				}

				if (prd_type.trim().equalsIgnoreCase("aH") && strSchemeType.trim().equalsIgnoreCase("aH")) {

			
			
					if (pageid == 72) {

					%>
		<td width="10%" align="center" class="main_tab_active" nowrap>Projected
		Income</td>
		<%} else {

					%>
		<td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('agr_hortiprojectedincome.jsp')"
			>Projected Income</a></td>
		<%}

					if (pageid == 89) {

					%>
		<td width="10%" align="center" class="main_tab_active" nowrap>Total
		Income & Expenditure</td>
		<%} else {

					%>
		<td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('agr_hortiincexp.jsp')"
			>Total Income & Expenditure</a></td>
		<%}

				}
				if (prd_type.trim().equalsIgnoreCase("aV") && strSchemeType.trim().equalsIgnoreCase("aV")) {
					//if (pageid == 105) 
					//{%>
						<!--  <td width="10%" align="center" class="main_tab_active" nowrap>Proposed Land Details</td>
					<%//} 
					//else 
					//{%>
						 <td width="10%" align="center" nowrap class="main_tab_inactive">
						<a href="javascript:gotoLink('agrlanddetails.jsp')"
							class="main_tab_inactive">Proposed Land Details</a></td>
				 
					<%//}
					if (pageid == 95) {

					%>
		<td width="10%" align="center" class="main_tab_active" nowrap>Land
		Development Details</td>
		<%} else {

					%>
		<td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('agr_landdevelopmentdetails.jsp')"
			>Land Development Details</a></td>
		<%}
					if (pageid == 84) {

					%>
		<td width="10%" align="center" class="main_tab_active" nowrap>Land
		Levelling</td>
		<%} else {

					%>
		<td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('agr_onfarmdevelopment.jsp')"
			>Land Levelling</a></td>
		<%}

				}
				if (prd_type.trim().equalsIgnoreCase("aV") && strSchemeType.trim().equalsIgnoreCase("aV")) {
					if (pageid == 87) {

					%>
		<td width="10%" align="center" class="main_tab_active" nowrap>Sand
		Casting/Soil Filling</td>
		<%} else {

					%>
		<td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('agr_sandcasting.jsp')"
			>Sand Casting/Soil Filling</a></td>
		<%}

				}
				if (prd_type.trim().equalsIgnoreCase("aV") && strSchemeType.trim().equalsIgnoreCase("aV")) {
					if (pageid == 88) {

					%>
		<td width="10%" align="center" class="main_tab_active" nowrap>Soil
		Reclamation</td>
		<%} else {

					%>
		<td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('agr_reclamationofsoil.jsp')"
			>Soil Reclamation</a></td> 
		<%}if (pageid == 120) {

			%>
		<td width="10%" align="center" class="main_tab_active" nowrap>Drying Yard</td>
<%} else {

			%>
<td width="10%" align="center" nowrap class="main_tab_inactive"><a
	href="javascript:gotoLink('agr_dryingyard.jsp')"
	>Drying Yard</a></td>
<%}
		
		
		if (pageid == 208) {

			%>
		<td width="10%" align="center" class="main_tab_active" nowrap>Fencing</td>
<%} else {

			%>
<td width="10%" align="center" nowrap class="main_tab_inactive"><a
	href="javascript:gotoLink('agr_fencing.jsp')"
	>Fencing</a></td> --> <%}}%>

				<%
				if (prd_type.trim().equalsIgnoreCase("aK") && strSchemeType.trim().equalsIgnoreCase("aK")) {
					if (pageid == 67) {

					%>
		<td width="10%" align="center" class="main_tab_active" nowrap>Details of
		Produce Pledged</td>
		<%} else {

					%>
		<td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('agr_capldetails.jsp')"
			>Details of Produce Pledged</a></td>
		<%}	if (pageid == 212) { %>
			<td width="10%" align="center" class="main_tab_active" nowrap>Goods Details</td>
			<%} else {
			
						%>
			<td width="10%" align="center" nowrap class="main_tab_inactive"><a
				href="javascript:gotoLink('agr_capl_goodsdetails.jsp')" >Goods Details</a></td>
			<%}
				}
				if (prd_type.trim().equalsIgnoreCase("aN") && strSchemeType.trim().equalsIgnoreCase("aN")) {
					if (pageid == 53) {

					%>
		<td width="10%" align="center" class="main_tab_active" nowrap>Gobar Gas Plant Details</td>
		<%} else {

					%>
		<td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('agr_gobartechdata.jsp')"
			>Gobar Gas Plant Details</a></td>
		<%}
				}
				/*if (prd_type.trim().equalsIgnoreCase("aE") && strSchemeType.trim().equalsIgnoreCase("aE")) {
					if (pageid == 80) {*/

					%>
		<!--<td width="10%" align="center" class="main_tab_active" nowrap>Term Loan
		Assessment</td>
		<%//} //else {
					%>
		<!--<td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('agr_fisheriesexcavation.jsp')"
			class="main_tab_inactive">Term Loan Assessment</a></td>-->
		<%/*}
				}
				if (prd_type.trim().equalsIgnoreCase("aE") && strSchemeType.trim().equalsIgnoreCase("aE")) {
					if (pageid == 56) {*/
					%>
		<!--<td width="10%" align="center" class="main_tab_active" nowrap>Assessment
		For Fisheries</td>-->
		<%/*} else {*/
						%>
		<!--<td width="10%" align="center" nowrap class="main_tab_inactive"><%if (prd_type.trim().equalsIgnoreCase("aE")) { %>
		<a href="javascript:gotoLink('agr_fisherywcassessment.jsp')"
			class="main_tab_inactive">Assessment For Fisheries</a>--> <%/*} else {*/

						%> <!--<a href="javascript:gotoLink('agrfisheries.jsp')"
			class="main_tab_inactive">Assessment For Fisheries</a> <%}%></td>-->
		<%//}
				//}

			if (prd_type.trim().equalsIgnoreCase("aT") && strSchemeType.trim().equalsIgnoreCase("aT")) {
				
			if (pageid == 150) {%>
				<td width="10%" align="center" class="main_tab_active" nowrap>Technical Data</td>
			<%} else {%>
				<td width="10%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('agr_bullockdata.jsp')">Technical Data</a></td>
			<%}%>
			
			<%if (pageid == 151) {%>
				<td width="10%" align="center" class="main_tab_active" nowrap>Particulars</td>
			<%} else {%>
				<td width="10%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('agr_bullock_particulars.jsp')">Particulars</a></td>
			<%}%>
			<!-- 
			<%if (pageid == 152) {%>
				<td width="10%" align="center" class="main_tab_active" nowrap>Financial Data</td>
			<%} else {%>
				<td width="10%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('agr_bullockfinancialdata.jsp')">Financial Data</a></td>
			<%}%>
			 -->
				
			<%}%>

			<%	if (prd_type.trim().equalsIgnoreCase("aI") && strSchemeType.trim().equalsIgnoreCase("aI")) {
					if (pageid == 76) {

					%>
		<td width="10%" align="center" class="main_tab_active" nowrap>Project
		Cost</td>
		<%} else {

					%>
		<td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('agr_sericultureprojcost.jsp')"
			>Project Cost</a></td>
		<%}
				}
				//if (prd_type.trim().equalsIgnoreCase("aI") && strSchemeType.trim().equalsIgnoreCase("aI")) {
				//	if (pageid == 77) {

					%>
		<!--  <td width="10%" align="center" class="main_tab_active" nowrap>Income And
		Expenses</td>
		<%//} else {

					%>
		<td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('agr_sericultureincexp.jsp')"
			>Income And Expenses</a></td>  -->
		<%//}
			//	}
				if (prd_type.trim().equalsIgnoreCase("aI") && strSchemeType.trim().equalsIgnoreCase("aI")) {
					if (pageid == 224) {

					%>
		<td width="10%" align="center" class="main_tab_active" nowrap>Income statement</td>
		<%} else {

					%>
		<td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('agr_sericultureincstatement.jsp')"
			>Income statement</a></td>
		<%}
				}

				if (prd_type.trim().equalsIgnoreCase("aB") && strSchemeType.trim().equalsIgnoreCase("aB")) {
					if (pageid == 58) {

					%>
		<td width="10%" align="center" class="main_tab_active" nowrap>Tobacco
		Details</td>
		<%} else {

					%>
		<td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('agrtobaccodetails.jsp')"
			>Tobacco Details</a></td>
		<%}
				}
				if (!(prd_type.trim().equalsIgnoreCase("aX")
						|| prd_type.trim().equalsIgnoreCase("aJ")
						||prd_type.trim().equalsIgnoreCase("aE")
						|| prd_type.trim().equalsIgnoreCase("aG")
						|| prd_type.trim().equalsIgnoreCase("aN")
						|| prd_type.trim().equalsIgnoreCase("aM")
						|| prd_type.trim().equalsIgnoreCase("aD")
						|| prd_type.trim().equalsIgnoreCase("aK")
						|| prd_type.trim().equalsIgnoreCase("aH")
						|| prd_type.trim().equalsIgnoreCase("aR")
						|| prd_type.trim().equalsIgnoreCase("aL")
						|| prd_type.trim().equalsIgnoreCase("aP")
						|| prd_type.trim().equalsIgnoreCase("aY")
						|| prd_type.trim().equalsIgnoreCase("aV") || prd_type
						.trim().equalsIgnoreCase("aO"))) {
					if (pageid == 52) {

						%>
		<!--  <td width="10%" align="center" class="main_tab_active" nowrap>-->
		<%if ((prd_type.trim().equalsIgnoreCase("aB") || prd_type.trim().equalsIgnoreCase("aT"))  && (strSchemeType.trim().equalsIgnoreCase("aB") || strSchemeType.trim().equalsIgnoreCase("aT"))) { %> 
		<!--Scale of Finance--> <%} else { %> <!-- Crop Assessment--> <%}%><!--  </td>-->
		<%} else { %>
		<%if (! (prd_type.trim().equalsIgnoreCase("aF") && strSchemeType.trim().equalsIgnoreCase("aF"))){ %>
		<!--  <td width="10%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('agrcropassessment.jsp')" class="main_tab_inactive"> -->
		<%}if ((prd_type.trim().equalsIgnoreCase("aB") || prd_type.trim().equalsIgnoreCase("aT"))  && (strSchemeType.trim().equalsIgnoreCase("aB") || strSchemeType.trim().equalsIgnoreCase("aT"))) { %> <!-- Scale of Finance-->
		<%} else {%>   <%if (! (prd_type.trim().equalsIgnoreCase("aF") && strSchemeType.trim().equalsIgnoreCase("aF"))){ %><!--  Crop Assessment--> <%}}%><!-- </td>-->
		<%}}
				if (prd_type.trim().equalsIgnoreCase("aM") && strSchemeType.trim().equalsIgnoreCase("aM")){	
					if (pageid == 59) {

					%>
		<td width="10%" align="center" class="main_tab_active" nowrap>Farm
		Mechanisation Implements</td>
		<%} else {

					%>
		<td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('agrfarmmachinerydetails.jsp')"
			>Farm Mechanisation Implements</a></td>
		<%}
					if (pageid == 61) {

					%>
		<td width="10%" align="center" class="main_tab_active" nowrap>Income
		From Custom Hire Service</td>
		<%} else {

					%>
		<td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('agrfarmincomehire.jsp')"
			>Income From Custom Hire Service</a></td>
		<%}
				}
				
				if (prd_type.trim().equalsIgnoreCase("aO") && strSchemeType.trim().equalsIgnoreCase("aO")) {
					if (pageid == 93) {

					%>
		<td width="10%" align="center" class="main_tab_active" nowrap>Minor Irrigation</td>
		<%} else {

					%>
		<td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('agr_minorirrigation.jsp')"
			>Minor Irrigation</a></td>
		<%}
					if (pageid == 94) {

					%>
		<td width="10%" align="center" class="main_tab_active" nowrap>Supplier
		Details</td>
		<%} else {

					%>
		<td width="10%" align="center" nowrap class="main_tab_inactive"><a
			href="javascript:gotoLink('otherassets.jsp')">Supplier
		Details</a></td>
		<%}}
				if ((prd_type.trim().equalsIgnoreCase("aX")) && (strSchemeType.trim().equalsIgnoreCase("aX"))){
					if (pageid == 92) {
						%>
						<!--<td width="10%" align="center" class="main_tab_active" nowrap>Crop Assessment</td>-->
						<%
							} else {
						%>
						<!-- <td width="10%" align="center" nowrap class="main_tab_inactive">
							<a
							href="javascript:gotoLink('agr_rituliabscaleoffinance.jsp')"
							class="main_tab_inactive">Crop Assessment</a>
									
							</td> -->
						<%
					}
					if (pageid == 63)
					{
						%>
						<td width="10%" align="center" class="main_tab_active" nowrap>Group Finance</td>
						<%
							} else {
						%>
						<td width="10%" align="center" nowrap class="main_tab_inactive">
						<a
							href="javascript:gotoLink('agr_shgfinanceposition.jsp')"
							>Group Finance</a>
							</td>
						<%}
				}
if (prd_type.trim().equalsIgnoreCase("aA") && strSchemeType.trim().equalsIgnoreCase("aA"))
					
				{
	if (pageid == 106) 
	{%>
		
		<td width="10%" align="center" class="main_tab_active" nowrap>IRR Calc</td>
	<%} 
	else 
	{%>
		<td width="10%" align="center" nowrap class="main_tab_inactive">
		<a href="javascript:gotoLink('agr_poultry_irr.jsp')"
			>IRR Calc</a></td>
	<%}
	if (pageid == 105) 
	{%>
		
		<td width="10%" align="center" class="main_tab_active" nowrap>Cash Flow</td>
	<%} 
	else 
	{%>
		<td width="10%" align="center" nowrap class="main_tab_inactive">
		<a href="javascript:gotoLink('agr_poultrycashflow.jsp')"
			>Cash Flow</a></td>
	<%}
	
				}
		if (prd_type.trim().equalsIgnoreCase("aE") && strSchemeType.trim().equalsIgnoreCase("aE"))
					
				{
					if (pageid == 96) 
					{%>
<!--						<td width="10%" align="center" class="main_tab_active" nowrap>Legal Opinion</td>-->
					<%} 
					else 
					{%>
					<!-- 	<td width="10%" align="center" nowrap class="main_tab_inactive">
						<a href="javascript:gotoLink('agr_legal_opinion.jsp')"
							>Legal Opinion</a></td> -->
					<%}

					if (pageid == 97) 
					{ %>
						<td width="10%" align="center" class="main_tab_active" nowrap>Tech Data</td>
					<%} 
					else 
					{%>
						<td width="10%" align="center" nowrap class="main_tab_inactive">
						<a href="javascript:gotoLink('agr_poultry_broilertech.jsp')"
							>Tech Data</a></td>
					<%}
					if (pageid == 98) 
					{%>
						<td width="10%" align="center" class="main_tab_active" nowrap>Economic Data</td>
					<%} 
					else 
					{%>
						<td width="10%" align="center" nowrap class="main_tab_inactive">
						<a href="javascript:gotoLink('agr_poultry_broilerfin.jsp')"
							>Economic Data</a></td>
					<%}
					//if (pageid == 99) 
					//{%>
<!--						<td width="10%" align="center" class="main_tab_active" nowrap>Non Recurring Expense</td>-->
					<%//} 
				//	else 
				//	{%>
<!--						<td width="10%" align="center" nowrap class="main_tab_inactive">-->
<!--						<a href="javascript:gotoLink('agr_poultry_broinonrec.jsp')"-->
<!--							>Non Recurring Expense</a></td>-->
					<%//}%>
					</tr>
					
					<tr>
						
					<%
					if (pageid == 101) 
					{%>
						<td width="10%" align="center" class="main_tab_active" nowrap>Flock Replacement</td>
					<%} 
					else 
					{%>
						<td width="10%" align="center" nowrap class="main_tab_inactive">
						<a href="javascript:gotoLink('agr_poultry_broiflockrep.jsp')"
							>Flock Replacement</a></td>
					<%}
					if (pageid == 102) 
					{%>
					
						<td width="10%" align="center" class="main_tab_active" nowrap>State of Expense</td>
					<%} 
					else 
					{%>
					
						<td width="10%" align="center" nowrap class="main_tab_inactive">
						<a href="javascript:gotoLink('agr_poultry_broiflowchart.jsp')"
							>State of Expense</a></td>
					<%}
					if (pageid == 103) 
					{%>
						
						<td width="10%" align="center" class="main_tab_active" nowrap>State of Income</td>
					<%} 
					else 
					{%>
						<td width="10%" align="center" nowrap class="main_tab_inactive">
						<a href="javascript:gotoLink('agr_poultry_broilerinc.jsp')"
							>State of Income</a></td>
					<%}
					if(!(prd_type.trim().equalsIgnoreCase("aE"))){
					if (pageid == 105) 
					{%>
						
						<td width="10%" align="center" class="main_tab_active" nowrap>Cash Flow</td>
					<%} 
					else 
					{%>
						<td width="10%" align="center" nowrap class="main_tab_inactive">
						<a href="javascript:gotoLink('agr_poultrycashflow.jsp')"
							>Cash Flow</a></td>
					<%}
					}
					if(!(prd_type.trim().equalsIgnoreCase("aE"))){
					if (pageid == 106) 
					{%>
						
						<td width="10%" align="center" class="main_tab_active" nowrap>IRR Calc</td>
					<%} 
					else 
					{%>
						<td width="10%" align="center" nowrap class="main_tab_inactive">
						<a href="javascript:gotoLink('agr_poultry_irr.jsp')"
							>IRR Calc</a></td>
					<%}
					}
				}
		if (prd_type.trim().equalsIgnoreCase("aD") && strSchemeType.trim().equalsIgnoreCase("aD"))
			
		{ 
		//if (pageid == 122) 
					//{%>
						<!--<td width="10%" align="center" class="main_tab_active" nowrap>Legal Opinion</td>-->
					<%//} 
					//else 
					//{%>
						<!--<td width="10%" align="center" nowrap class="main_tab_inactive">
						<a href="javascript:gotoLink('agr_legal_opinion.jsp')"
							class="main_tab_inactive">Legal Opinion</a></td>-->
					<%  //}
					if (pageid == 128) 
					{%>
						<td width="10%" align="center" class="main_tab_active" nowrap>Cost of Investment</td>
					<%} 
					else 
					{%>
						<td width="10%" align="center" nowrap class="main_tab_inactive">
						<a href="javascript:gotoLink('agr_dairycostofinvestment.jsp')"
							>Cost of Investment</a></td>
					<%}
					if (pageid == 129) 
					{%>
						<td width="10%" align="center" class="main_tab_active" nowrap>Financial Data</td>
					<%} 
					else 
					{%>
						<td width="10%" align="center" nowrap class="main_tab_inactive">
						<a href="javascript:gotoLink('agr_dairyfinancialdata.jsp')"
							>Financial Data</a></td>
					<%}
					if (pageid == 124) 
					{%>
						<td width="10%" align="center" class="main_tab_active" nowrap>Herd Production Chart</td>
					<%} 
					else 
					{%>
						<td width="10%" align="center" nowrap class="main_tab_inactive">
						<a href="javascript:gotoLink('agr_dairyherdproductionchart.jsp')"
							>Herd Production Chart</a></td>
					<%}
					
					
		//if (pageid == 108) 
		//{%>
			 <!-- <td width="10%" align="center" class="main_tab_active" nowrap>Live Stock Details</td> -->
		<%//} 
		//else 
		//{%>
			<!-- <td width="10%" align="center" nowrap class="main_tab_inactive">
			<a href="javascript:gotoLink('livestockdetails.jsp')"
				class="main_tab_inactive">Live Stock Details</a></td>-->
		<%//}
		
		if (pageid == 125) 
		{%>
			<td width="10%" align="center" class="main_tab_active" nowrap>Income Statement</td>
		<%} 
		else 
		{%>
			<td width="10%" align="center" nowrap class="main_tab_inactive">
			<a href="javascript:gotoLink('agr_dairyincomestatement.jsp')"
				>Income Statement</a></td>
		<%}
		if (pageid == 126) 
		{%>
			</tr><tr><td width="10%" align="center" class="main_tab_active" nowrap>Recurring expenditure</td>
		<%} 
		else 
		{%>
			<tr><td width="10%" align="center" nowrap class="main_tab_inactive">
			<a href="javascript:gotoLink('agr_dairyrecurringexpenditure.jsp')"
				>Recurring expenditure</a></td>
		<%}
		
		if (pageid == 127) 
		{%>
			<td width="10%" align="center" class="main_tab_active" nowrap>Financial Analysis</td>
		<%} 
		else 
		{ %>
			<td width="10%" align="center" nowrap class="main_tab_inactive">
			<a href="javascript:gotoLink('agr_dairyfinancialanalysis.jsp')"
				>Financial Analysis</a></td></tr>
		<%}
		
		//if (pageid == 109) 
		//{%>
			<!-- <td width="10%" align="center" class="main_tab_active" nowrap>Technical Data</td> -->
		<%//} 
		//else 
		//{%>
			<!--<td width="10%" align="center" nowrap class="main_tab_inactive">
			<a href="javascript:gotoLink('agr_economicdata.jsp')"
				class="main_tab_inactive">Technical Data</a></td>-->
		<%//}
		//if (pageid == 110) 
		//{%>
			<!--  <td width="10%" align="center" class="main_tab_active" nowrap>Economic Data</td>-->
		<%//} 
		//else 
		//{%>
		
			<!--  <td width="10%" align="center" nowrap class="main_tab_inactive">
			<a href="javascript:gotoLink('agr_diaryfindata.jsp')"
				class="main_tab_inactive">Economic Data</a></td>-->
		<%//}
		//if (pageid == 111) 
		//{%><!--  </tr>
					<tr>
			<td width="10%" align="center" class="main_tab_active" nowrap>Milk Flowchart</td> -->
		<%//} 
		//else 
		//{%><!--</tr>
					<tr>
			<td width="10%" align="center" nowrap class="main_tab_inactive">
			<a href="javascript:gotoLink('agr_LDCows.jsp')"
				class="main_tab_inactive">Milk Flowchart</a></td>-->
		<%//}
		//if (pageid == 112) 
		//{%>
			<!--<td width="10%" align="center" class="main_tab_active" nowrap>Cattle Chart</td> -->
		<%//} 
		//else 
		//{%>
			<!--<td width="10%" align="center" nowrap class="main_tab_inactive">
			<a href="javascript:gotoLink('agr_dairycattlechart.jsp')"
				class="main_tab_inactive">Cattle Chart</a></td> -->
		<%//}
		//if (pageid == 113) 
		//{%>
			<!--  <td width="10%" align="center" class="main_tab_active" nowrap>Income and Expenses</td>-->
		<%//} 
		//else 
		//{%>
			<!--<td width="10%" align="center" nowrap class="main_tab_inactive">
			<a href="javascript:gotoLink('dairyfarmingappraisal.jsp')"
				class="main_tab_inactive">Income and Expenses</a></td>-->
		<%//}
		//if (pageid == 105) 
		//{%>
			
			<!--<td width="10%" align="center" class="main_tab_active" nowrap>Cash Flow</td>-->
		<%//} 
		//else 
		//{%>
			<!--<td width="10%" align="center" nowrap class="main_tab_inactive">
			<a href="javascript:gotoLink('agr_poultrycashflow.jsp')"
				class="main_tab_inactive">Cash Flow</a></td>-->
		<%//}
		//if (pageid == 106) 
		//{%>
			
			<!--<td width="10%" align="center" class="main_tab_active" nowrap>IRR Calc</td>-->
		<%//} 
		//else 
		//{%>
			<!--<td width="10%" align="center" nowrap class="main_tab_inactive">
			<a href="javascript:gotoLink('agr_poultry_irr.jsp')"
				class="main_tab_inactive">IRR Calc</a></td>-->
		<%//}
			
	}
		%>
		<%if(prd_type.equalsIgnoreCase("aF") && strSchemeType.trim().equalsIgnoreCase("aF")){ %>			
			<%if (pageid == 119) {%>
			<td width="10%" align="center" class="main_tab_active" nowrap>Proposed Asset</td>
			<%}else {%>
			<td width="10%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('perpropertydetails.jsp')" >Proposed Asset</a></td>
			<%}if (pageid == 115) {%>
			<!--  <td width="10%" align="center" class="main_tab_active" nowrap>Technical Details</td>-->
			<%}else {%>
 			<!-- <td width="10%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('agr_techdetails.jsp')" class="main_tab_inactive">Technical Details</a></td>-->
			<%}if (pageid == 116) {%>
			<td width="10%" align="center" class="main_tab_active" nowrap>Loan Particulars</td>
			<%}else {%>
 			<td width="10%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('agr_loanparticulars.jsp')">Loan Particulars</a></td>
			<%}if (pageid == 117) {%>
			<td width="10%" align="center" class="main_tab_active" nowrap>Income</td>
			<%}else {%>
 			<td width="10%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('agr_income.jsp')">Income</a></td>
			<%}if (pageid == 118) {%>
			<td width="10%" align="center" class="main_tab_active" nowrap>Expenses</td>
			<%}else {%>
			 <td width="10%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('agr_expense.jsp')">Expenses</a></td>
			<%}} %>
			
			<%if(prd_type.equalsIgnoreCase("aR") && strSchemeType.trim().equalsIgnoreCase("aR")){ %>			
			<%if (pageid == 122) {%>
			<td width="10%" align="center" class="main_tab_active" nowrap>Recuring Expenses</td>
			<%}else {%>
			<td width="10%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('agr_sheeprearcostofproj.jsp')">Recuring Expenses</a></td>
			<%}if (pageid == 123) {%>
			<td width="10%" align="center" class="main_tab_active" nowrap>Herd Projection Chart</td>
			<%}else {%>
 			<td width="10%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('agr_sheepherdprojchart.jsp')">Herd Projection Chart</a></td>
			<%}if (pageid == 78) {%>
			<td width="10%" align="center" class="main_tab_active" nowrap>Income</td>
			<%}else {%>
 			<td width="10%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('agr_sheepincome.jsp')">Income</a></td>
			<%}if (pageid == 73) {%>
			<td width="10%" align="center" class="main_tab_active" nowrap>Financial Analysis</td>
			<%}else {%>
 			<td width="10%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('agr_sheepfinancialAnalysis.jsp')">Financial Analysis</a></td>
			<%}} %>
			<% if(prd_type.equalsIgnoreCase("aJ") && strSchemeType.trim().equalsIgnoreCase("aJ")){ // For Fisheries%>
			<%if (pageid == 201) {%>
				<td width="10%" align="center" class="main_tab_active" nowrap>Proposed Development</td>
			<%}else { %>	
				<td width="10%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('agr_fishery_particulars.jsp')">Proposed Development</a></td>
			<%} if (pageid == 202) {%>
				<td width="10%" align="center" class="main_tab_active" nowrap>Fisheries Investment</td>
			<%}else { %>	
				<td width="10%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('agr_fishersinvest.jsp')">Fisheries Investment</a></td>
			<%}%>
			<!-- 
			<% if (pageid == 203) {%>	
				<td width="10%" align="center" class="main_tab_active" nowrap>Particulars</td>
			<%}else { %>	
				<td width="10%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('agr_common_loanrequirements.jsp')">Particulars</a></td>
			<%}%> -->
			<% if (pageid == 204) {%>	
				<td width="10%" align="center" class="main_tab_active" nowrap>Other Details</td>
			<%}else { %>	
				<td width="10%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('agr_marketingfisheries.jsp')">Other Details</a></td>
			<%} if (pageid == 205) {%>	
				<td width="10%" align="center" class="main_tab_active" nowrap>Income</td>
			<%}else { %>	
				<td width="10%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('agrMachBoatSurplus.jsp')">Income</a></td>
			<%} if (pageid == 206) {%>
				<td width="10%" align="center" class="main_tab_active" nowrap>Expenditure</td>
			<%}else { %>	
				<td width="10%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('agrMachBoatOPExpenses.jsp')">Expenditure</a></td>
			<!-- Added by Arsath on 05/03/2014 for Net Income page in Fisheries -->
			<%}if (pageid == 211) {%>
			<td width="10%" align="center" class="main_tab_active" nowrap>Net Income</td>
			<%}else { %>	
			<td width="10%" align="center" nowrap class="main_tab_inactive"><a href="javascript:gotoLink('agr_netincome.jsp')">Net Income</a></td>
			<%}%>
			
			
			<%}// end of aJ (fisheries) if
			
					}//end of while
					
				
				} %>
			<% 
		if(strgovtsponsor.equalsIgnoreCase("1")){
			if(!(prd_type.trim().equalsIgnoreCase("aE"))){
		if(pageid == 107)
		{%>
		<td width="10%" align="center" class="main_tab_active" nowrap>Govt Schemes</td>
		<%}
		else
		{ %>
		<td width="10%" align="center" nowrap class="main_tab_inactive">
		<a href="javascript:gotoLink('agr_appraisalconfirmgovt.jsp')"
			>Govt Schemes</a></td>
		<%}}}%>		
	
</table>
<%} %>
<input type="hidden" name="hiPgDist" value="P">
<input type="hidden" name="pageid" value="<%=pageid%>">
<input type="hidden" name="strAppflag" value="<%=strAppflag%>">
<input type="hidden" name="hidPageId" value="">
<input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
<input type="hidden" name="ssitype" value="<%=strSSIType%>">
<input type="hidden" name="schemetype" value="<%=schemetype%>">
<input type="hidden" name="hidCategoryType" value="<%=strCategoryType%>">

</BODY>
</HTML>
