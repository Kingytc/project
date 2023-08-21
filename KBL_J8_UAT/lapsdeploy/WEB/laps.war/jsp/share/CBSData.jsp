<%@include file="../share/directives.jsp"%>
	<%
			java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
			nf.setMinimumFractionDigits(2);
			nf.setMaximumFractionDigits(2);
			nf.setGroupingUsed(false);
			String strAppNumfrombean = Helper.correctNull((String)hshValues.get("strApplicationNumber"));
			String sanctionAmt=Helper.correctDouble((String)hshValues.get("strLoanAmount"));
			if(!sanctionAmt.equalsIgnoreCase(""))
			{
				sanctionAmt=nf.format(Double.parseDouble(Helper.correctDouble((String)sanctionAmt)));
			}
			String strMPBFAmt=Helper.correctDouble((String)hshValues.get("strMPBFAmt"));
			if(!strMPBFAmt.equalsIgnoreCase(""))
			{
				strMPBFAmt=nf.format(Double.parseDouble(Helper.correctDouble((String)strMPBFAmt)));
			}
			String strProductType=Helper.correctNull((String)hshValues.get("strProductType"));
%>
<%
			HashMap hshRec8 = new HashMap();
			hshRec8 = (HashMap)hshValues.get("hshRecord8");
				
			String strApplicationNumber = "";
			String strFreeCode6 = "";
			String strFreeCode7 = "";
			String strFreeCode8 = "";
			String strModeOfOperation = "";
			String strDrawingPowerInd = "";
			String strDrawingPower = "";
			String strAdvanceNature = "";
			String strCashMargin = "";
			String strAdvanceType = "";
			String strAdvanceMode = "";
			String strAdvancePurpose = "";
			String strFreeCode3 = "";
			String strSecurityCode = "";
			String strintrate="";
			String strloanamt="",strstaticvalue="",strlbrcode="",strmodeofadv="",strprdtype="";
			
			strApplicationNumber = Helper.correctNull((String)hshValues.get("appno"));
			strFreeCode6 = Helper.correctNull((String)hshValues.get("freecode6"));
			strFreeCode7 = Helper.correctNull((String)hshValues.get("freecode7"));
			strFreeCode8 = Helper.correctNull((String)hshValues.get("freecode8"));
			strModeOfOperation = Helper.correctNull((String)hshValues.get("modeofoper"));
			strDrawingPowerInd = Helper.correctNull((String)hshValues.get("drwingpwrind"));
			strDrawingPower = Helper.correctNull((String)hshValues.get("drwingpwr"));
			if(!strDrawingPower.equalsIgnoreCase(""))
			{
				strDrawingPower=nf.format(Double.parseDouble(Helper.correctDouble((String)strDrawingPower)));
			}
			strAdvanceNature = Helper.correctNull((String)hshValues.get("strAdvanceNature"));
			strCashMargin = Helper.correctNull((String)hshValues.get("strCashMargin"));
			strAdvanceType = Helper.correctNull((String)hshValues.get("strAdvanceType"));
			strAdvanceMode = Helper.correctNull((String)hshValues.get("strAdvanceMode"));
			strAdvancePurpose = Helper.correctNull((String)hshValues.get("strAdvancePurpose"));
			strFreeCode3 = Helper.correctNull((String)hshValues.get("strFreeCode3"));
			strSecurityCode = Helper.correctNull((String)hshValues.get("strSecurityCode"));
			strintrate=Helper.correctNull((String)hshValues.get("INTRATEFREQ"));
			strloanamt=Helper.correctNull((String)hshValues.get("stramtreq"));
			strstaticvalue=Helper.correctNull((String)hshValues.get("strsecval"));
			strlbrcode=Helper.correctNull((String)hshValues.get("strlbrcode"));
			strmodeofadv=Helper.correctNull((String)hshValues.get("strmodeofadv"));
			strprdtype=Helper.correctNull((String)hshValues.get("strprdtype"));
			String strLoanType=Helper.correctNull((String)request.getParameter("apploantype"));
			String strFacilitySno=Helper.correctNull((String)hshValues.get("strFacilitySno"));
			String strORGlevel=Helper.correctNull((String)session.getAttribute("strOrgLevel"));
			String StrScheme=Helper.correctNull((String)hshValues.get("strscheme"));
			String schemecode=Helper.correctNull((String)hshValues.get("facility_schemecode"));
			if(!schemecode.equalsIgnoreCase(""))
				StrScheme=schemecode;
			String schemeglsubcode=Helper.correctNull((String)hshValues.get("facility_glsubheadcode"));
			String strfreecode3val=Helper.correctNull((String)hshValues.get("freecode3val"));
			String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
			String strPageParam = Helper.correctNull((String) session.getAttribute("strModifyterms")).trim();
//out.println("hshValues+"+hshValues);
%>
<html>
<head>
<title>CBS Data </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varLoanType="<%=strLoanType%>";
var varorglevel="<%=strORGlevel%>";
var varModule="<%=strCategoryType%>";
var varSchemecode="<%=StrScheme%>";
var varschemecodenew="<%=schemecode%>";
var varCashMargin="<%=strCashMargin%>";
var sel_schemeheadcode="<%=schemeglsubcode%>";
var varfreecode3val="<%=strfreecode3val%>";
var varSecCoverageValue="<%=Helper.correctNull((String)hshValues.get("strSecCoverage"))%>";
var varFacHeadId="<%=Helper.correctNull((String)hshValues.get("FACILITY_HEADID"))%>";
var varSubFacHeadId="<%=Helper.correctNull((String)hshValues.get("FACILITY_ID"))%>";
var varFieldfreeze="<%=Helper.correctNull((String)hshValues.get("strFieldFreeze"))%>";
var varPostSanc="<%=Helper.correctNull((String)session.getAttribute("strAppType"))%>";
var varEditFlag="<%=Helper.correctNull((String) hshValues.get("strEditFlag"))%>";
var varProductType="<%=strProductType%>";
var varprodpurpose="<%=Helper.correctNull((String) hshValues.get("prdpurpose"))%>";
var varstrSessionModuleType="<%=strSessionModuleType%>";

function doClose()
{
	window.close();
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}	
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=!val;
		}	 
	}
	document.forms[0].txt_LoanDisbBranch.readOnly=true;
	document.forms[0].sel_LBRCode.disabled=true;
	document.forms[0].sel_advancepurpose.disabled=true;
	document.forms[0].sel_advancenature.disabled=true;
	document.forms[0].sel_advancetype.disabled=true;
	document.forms[0].sel_advancemode.disabled=true;
	document.forms[0].selintrate.disabled=true;
}

function doSave()
{
	if(document.forms[0].sel_mode.value=="0")
	{
		ShowAlert(111,"Mode of Operation");
		document.forms[0].sel_mode.focus();
		return;
	}
	if(document.forms[0].sel_power_indicator.value=="0")
	{
		ShowAlert(111,"Drawing Power Indicator");
		document.forms[0].sel_power_indicator.focus();
		return;
	}
	if(document.forms[0].txt_drawingpower.value=="")
	{
		ShowAlert(121,"Drawing Power");
		document.forms[0].txt_drawingpower.focus();
		return;
	}

	if (document.forms[0].sel_power_indicator.value =="M")
	{
		if(document.forms[0].txt_drawingpower.value=="")
		{
			ShowAlert(121,"Drawing Power");
			document.forms[0].txt_drawingpower.focus();
			return;
		}
	}
	if(document.forms[0].sel_freecode3.value=="")
	{
		ShowAlert(111,"Freecode 3");
		document.forms[0].sel_freecode3.focus();
		return;
	}
	if(document.forms[0].sel_freecode6.value=="")
	{
		ShowAlert(111,"Freecode 6");
		document.forms[0].sel_freecode6.focus();
		return;
	}
	if(document.forms[0].sel_freecode7.value=="")
	{
		ShowAlert(111,"Freecode 7");
		document.forms[0].sel_freecode7.focus();
		return;
	}
	if(document.forms[0].sel_freecode8.value=="")
	{
		ShowAlert(111,"Freecode 8");
		document.forms[0].sel_freecode8.focus();
		return;
	}
	if(document.forms[0].sel_advancenature.value=="")
	{
		ShowAlert(111,"Nature of Advance");
		document.forms[0].sel_advancenature.focus();
		return;
	}
	if(document.forms[0].sel_advancetype.value=="")
	{
		ShowAlert(111,"Type of Advance");
		document.forms[0].sel_advancetype.focus();
		return;
	}
	if(document.forms[0].sel_advancepurpose.value=="")
	{
		ShowAlert(111,"Purpose of Advance");
		document.forms[0].sel_advancepurpose.focus();
		return;
	}
	if(document.forms[0].txt_LoanDisbBranch.value=="")
	{
		ShowAlert(121,"Loan Disbursing Branch");
		document.forms[0].txt_LoanDisbBranch.focus();
		return;
	}
	if(document.forms[0].txt_gistofsecurities.value=="")
	{
		ShowAlert(121,"Gist of securities");
		document.forms[0].txt_gistofsecurities.focus();
		return;
	}
	if(varPostSanc!="P")
	{
		if(document.forms[0].sel_lapscode1.value=="")
		{
			ShowAlert(121,"LAPS CODE 1");
			document.forms[0].sel_lapscode1.focus();
			return;
		}
		if(document.forms[0].sel_lapscode2.value=="")
		{
			ShowAlert(121,"LAPS CODE 2");
			document.forms[0].sel_lapscode2.focus();
			return;
		}
		if(document.forms[0].sel_lapscode3.value=="")
		{
			ShowAlert(121,"LAPS CODE 3");
			document.forms[0].sel_lapscode3.focus();
			return;
		}
        var lapscd1 =document.forms[0].sel_lapscode1.value;
                var dpval = "<%=strDrawingPower%>";
                var dpval1 = parseInt(dpval);
        if(varProductType=="pG"||varProductType=="pR")
        if(lapscd1 == "1")
        {
        document.forms[0].sel_lapscode1.value="99"
        }
        if(dpval1 <  1000000)
        if(lapscd1 == "1")
        {
        document.forms[0].sel_lapscode1.value="99"
        }
        if(dpval1 >  10000000)
        if(lapscd1 == "1")
        {
        document.forms[0].sel_lapscode1.value="99"
        }
	}
	
	document.forms[0].hidFreeCode7Desc.value=document.forms[0].sel_freecode7.options[document.forms[0].sel_freecode7.selectedIndex].text;
	document.forms[0].hidFreeCode8Desc.value=document.forms[0].sel_freecode8.options[document.forms[0].sel_freecode8.selectedIndex].text;
	if(varLoanType=="C" || varLoanType=="A")
	{
		document.forms[0].sel_facilitysno.disabled=false;
	}
	<%if(!strLoanType.equalsIgnoreCase("")){ %>
	var schemecode=document.forms[0].hidScheme.value;
	if(schemecode=="DGDQ" ||schemecode=="ODGEN" ||schemecode=="ODPS" ||schemecode=="ODPSA" ||schemecode=="ODAG" ||schemecode=="ODSEC")
	{
		if(document.forms[0].selschemehead.value=="S")
		{
			alert("Select GL Sub Head Code");
			document.forms[0].selschemehead.focus();
			return;
		}
	}
	<%}%>
	document.forms[0].cmdsave.disabled=true;
	enablefields(false);
	document.forms[0].txt_LoanDisbBranch.readOnly=false;
	document.forms[0].sel_LBRCode.disabled=false;
	document.forms[0].sel_power_indicator.disabled=false;
	document.forms[0].sel_advancepurpose.disabled=false;
	document.forms[0].sel_advancenature.disabled=false;
	document.forms[0].sel_advancetype.disabled=false;
	document.forms[0].sel_advancemode.disabled=false;
	document.forms[0].selintrate.disabled=false;
	document.forms[0].sel_freecode3.disabled=false;
	//document.forms[0].sel_freecode6.disabled=false;
	//document.forms[0].sel_freecode7.disabled=false;
	//document.forms[0].sel_freecode8.disabled=false;
	document.forms[0].hidBeanId.value="FinacleBean";
	document.forms[0].hidBeanGetMethod.value="getCBSDetails";
	document.forms[0].hidBeanMethod.value="updateCBSDetails";
	document.forms[0].hidSourceUrl.value="/action/CBSData.jsp"
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}	
function enablefields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
		{
		if(document.forms[0].elements[i].type=='select-one')
			{
			document.forms[0].elements[i].disabled=val;
			}
		if(document.forms[0].elements[i].type=='text')
			{
			document.forms[0].elements[i].readOnly=val;
			}
		if(document.forms[0].elements[i].type=='textarea')
			{
			document.forms[0].elements[i].readOnly=val;
			}
		}
	document.forms[0].txt_LoanDisbBranch.readOnly=true;
	document.forms[0].sel_LBRCode.disabled=true;
	document.forms[0].sel_advancepurpose.disabled=true;
	document.forms[0].sel_advancenature.disabled=true;
	document.forms[0].sel_advancetype.disabled=true;
	document.forms[0].sel_advancemode.disabled=true;
	document.forms[0].selintrate.disabled=true;
}	
function CallOnload()
{
	var mode = "<%=strModeOfOperation%>";
	var drawpwrind = "<%=strDrawingPowerInd%>";
	var drawpwr = "<%=strDrawingPower%>";
	var freec6 = "<%=strFreeCode6%>";
	var advnature = "<%=strAdvanceNature%>";
	var advtype = "<%=strAdvanceType%>";
	var advmode = "<%=strAdvanceMode%>";
	var advpurpose = "<%=strAdvancePurpose%>";
	var freec3 = "<%=strFreeCode3%>";
	var seccode = "<%=strSecurityCode%>";
	var intratefreq="<%=strintrate%>";
	var lbrcode="<%=strlbrcode%>";
	var varlapscode1="<%=Helper.correctNull((String)hshValues.get("LAPS_CODE_1"))%>";
	var varlapscode2="<%=Helper.correctNull((String)hshValues.get("LAPS_CODE_2"))%>";
	var varlapscode3="<%=Helper.correctNull((String)hshValues.get("LAPS_CODE_3"))%>";
	var modeofadv="<%=strmodeofadv%>";
	var prdtype="<%=strprdtype%>";
	var varFacilitySno="<%=strFacilitySno%>";
	var varLoanType="<%=strLoanType%>";
	//alert("varLoanType+"+varLoanType+"+varProductType+"+varProductType);
	var varMISFlag="<%=Helper.correctNull((String)hshValues.get("strMISFlag"))%>";
	if((varFacilitySno!="0" && varLoanType!=""))
	{
		document.forms[0].sel_facilitysno.value=varFacilitySno;
		if(varSchemecode == "DGDQ")
		{
			document.forms[0].sel_facilitybankscheme.options[0]=new Option('DGDQ',"DGDQ");
		}
		else if(varSchemecode == "ODGEN" || varSchemecode == "ODPS")
		{
			document.forms[0].sel_facilitybankscheme.options[0]=new Option('ODGEN',"ODGEN");
			document.forms[0].sel_facilitybankscheme.options[1]=new Option('ODPS',"ODPS");
		}
		else if(varSchemecode == "ODPSA" || varSchemecode == "ODAG")
		{
			document.forms[0].sel_facilitybankscheme.options[0]=new Option('ODPSA',"ODPSA");
			document.forms[0].sel_facilitybankscheme.options[1]=new Option('ODAG',"ODAG");
		}
		else if(varSchemecode == "ODSEC")
		{
			document.forms[0].sel_facilitybankscheme.options[0]=new Option('ODSEC',"ODSEC");
		}

		<%if(!(strLoanType.equalsIgnoreCase(""))) 
		{%>
		funglsubcode();
		//funglsubcode1();
		<%}%>
		if((varSchemecode!="" || varSchemecode!="S"))
		{
			document.forms[0].sel_facilitybankscheme.value=varSchemecode;	
		}

		if(varMISFlag!="Y")
		{
			alert("Please Fill MIS Details");
			document.forms[0].hidBeanId.value = "mis";
			document.forms[0].hidBeanGetMethod.value = "getMISDetails";
			document.forms[0].action = appURL + "action/misdetails.jsp";
			document.forms[0].submit();
		}
	}
	else{
		<%if(!(strLoanType.equalsIgnoreCase(""))) 
		{%>
		funglsubcode1();
		//funglsubcode();
		<%}%>
	}
	if(mode != "")
	{
		document.forms[0].sel_mode.value = "<%=strModeOfOperation%>";
	}
	else
	{
		document.forms[0].sel_mode.value = "0";
	}
	if(drawpwrind != "" && drawpwrind != "0")
	{
		document.forms[0].sel_power_indicator.value = "<%=strDrawingPowerInd%>";
	}
	else
	{
		if(varProductType=="pG"||varProductType=="pR"||varProductType=="pI")
		{
			document.forms[0].sel_power_indicator.value="D";
		}
		else if(varSchemecode == "ODKCC")
		{
			document.forms[0].sel_power_indicator.value ="M";
		}
		else
		{
			document.forms[0].sel_power_indicator.value = "0";
		}
	}
	document.forms[0].txt_drawingpower.value = "<%=strDrawingPower%>";
	
	if(freec6 != "")
	{
		document.forms[0].sel_freecode6.value = freec6;
	}
	else
	{
		document.forms[0].sel_freecode6.value = "0";
	}
	
	document.forms[0].sel_LBRCode.value=lbrcode;
	document.forms[0].sel_lapscode1.value=varlapscode1;
	document.forms[0].sel_lapscode2.value=varlapscode2;
	document.forms[0].sel_lapscode3.value=varlapscode3;
	document.forms[0].sel_advancenature.value = advnature;
	document.forms[0].sel_advancetype.value = advtype;
	document.forms[0].sel_advancepurpose.value = advpurpose;
	document.forms[0].sel_freecode3.value = freec3;
	document.forms[0].sel_securitycode.value = seccode;
	document.forms[0].selintrate.value = intratefreq;
	document.forms[0].sel_advancemode.value = modeofadv;
	
	if(prdtype == "OD")
	{
		document.forms[0].sel_advancepurpose.value = "01";
	}
	else
	{
		document.forms[0].sel_advancepurpose.value = "10";
	}		
	getFreeCode7();
	natureofadv();
	enablefields(true);
	if(varLoanType=="C" || varLoanType=="A")
	{
		document.forms[0].sel_facilitysno.disabled=false;
	}
	if((varLoanType!="")&& sel_schemeheadcode!="")
	{
		document.forms[0].selschemehead.value=sel_schemeheadcode;
	}
	//alert("varLoanType+"+varLoanType+"varprodpurpose+"+varprodpurpose+"+varfreecode3val+"+varfreecode3val+"+varProductType+"+varProductType);
	if(varprodpurpose=="3" && varfreecode3val == "111")
	{	
		document.forms[0].sel_freecode3.value = varfreecode3val;
		document.forms[0].sel_freecode3.disabled = true;
	}
	else if(varfreecode3val != ""){
		document.forms[0].sel_freecode3.value = varfreecode3val;
	}
	if(((varLoanType=="C" || varLoanType=="A"|| varLoanType=="P") && (varPostSanc=="P")) && (document.forms[0].btnenable.value=="Y"))
	{
		document.all.idBranch.style.display="none";
		var boolflag=false;
		var varPSterms = document.forms[0].hidPostSancParams.value.split("@");
		for(var i=0;i<varPSterms.length;i++)
		{
			if(varPSterms[i] == "CHBRANCH"||varPSterms[i] == "CHDPOWER"||varPSterms[i] == "CHSCHEMECODE")
			{
				boolflag=true;
			}
			if(varPSterms[i] == "CHBRANCH")
			{
				document.all.idBranch.style.display="inline";
			}
			
		}
		if( document.forms[0].hidPostSancParams.value == "")
		{
			document.all.idBranch.style.display="inline";
		}
		if(varEditFlag=="N" && document.forms[0].hidPostSancParams.value=="" && document.forms[0].sel_facilitysno.value!="")
		{
			boolflag=true;
		}
		if(boolflag)
		{
			document.forms[0].cmdedit.disabled=false;
		}
		else
		{
			document.forms[0].cmdedit.disabled=true;
		}
	}
	else
	{
		document.all.idBranch.style.display="inline";
	}
	if(varFacHeadId == "5" && varSubFacHeadId == "48")
	{
		document.forms[0].selschemehead.value = "70044";
		document.forms[0].selschemehead.disabled = true;
	}

	if(varstrSessionModuleType=="DIGI" && varProductType=="pC")
	{
		document.forms[0].cmdedit.disabled=true;
	}
}
function doEdit()
{

	if(varLoanType=="C" || varLoanType=="A")
	{
		if(document.forms[0].sel_facilitysno.value=="")
		{
			ShowAlert(111,"Facility");
			document.forms[0].sel_facilitysno.focus();
			return;
		}
	}
	document.forms[0].hidAction.value="update";
	document.forms[0].cmdsave.disabled=false;
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmddelete.disabled=false;
	document.forms[0].cmdclose.disabled=true;
	document.forms[0].cmdcancel.disabled=false;
	enablefields(false);
	document.forms[0].txt_drawingpower.readOnly=true;
	document.forms[0].sel_LBRCode.disabled=true;
	document.forms[0].sel_advancepurpose.disabled=true;
	if((varModule=="CORP" ||  varModule=="AGR") && (varCashMargin == "Y" && varFacHeadId == "6" && varSubFacHeadId == "41"))
	document.forms[0].sel_advancenature.disabled=true;
	else if((varModule=="CORP" ||  varModule=="AGR") && (varFacHeadId == "6" && varSubFacHeadId == "41"))
	document.forms[0].sel_advancenature.disabled=true;
	else if(varLoanType == "P")
	document.forms[0].sel_advancenature.disabled=true;	
	else
	document.forms[0].sel_advancenature.disabled=false;	
	document.forms[0].sel_advancemode.disabled=true;
	document.forms[0].sel_advancetype.disabled=true;
	document.forms[0].selintrate.disabled=true;

	if(varLoanType=="C" || varLoanType=="A")
	{
		document.forms[0].sel_facilitysno.disabled=true;
	}
	if(varprodpurpose=="3" && varfreecode3val == "111")
	{
		document.forms[0].sel_freecode3.disabled = true;	
	}
	if(varSchemecode == "ODKCC")
	{
		document.forms[0].sel_power_indicator.disabled=true;
		document.forms[0].txt_drawingpower.readOnly=false;
	}
	if(varFieldfreeze=="Y")
	{
		document.forms[0].sel_power_indicator.disabled=true;
		document.forms[0].txt_drawingpower.readOnly=true;
	}

	if(((varLoanType=="C" || varLoanType=="A"|| varLoanType=="P") && (varPostSanc=="P")) && (document.forms[0].btnenable.value=="Y"))
	{
		var boolflag=false;
		var varDPower="",varSchemeCode="";
		var varPSterms = document.forms[0].hidPostSancParams.value.split("@");
		for(var i=0;i<varPSterms.length;i++)
		{
			if(varPSterms[i] == "CHBRANCH"||varPSterms[i] == "CHDPOWER"||varPSterms[i] == "CHSCHEMECODE")
			{
				boolflag=true;
			}
			if(varPSterms[i] == "CHDPOWER")
			{
				varDPower="Y";
			}
			if(varPSterms[i] == "CHSCHEMECODE")
			{
				varSchemeCode="Y";
			}
			document.forms[0].cmddelete.disabled=true;

		}
		if( document.forms[0].hidPostSancParams.value=="" && document.forms[0].sel_facilitysno.value!="")
		{
			enablefields(false);
			if(varLoanType=="C" || varLoanType=="A")
			{
				if(varCashMargin == "Y" && varFacHeadId == "6" && varSubFacHeadId == "41")
				{
					document.forms[0].sel_advancenature.disabled=true;
				}
				else if(varFacHeadId == "6" && varSubFacHeadId == "41")
				{
					document.forms[0].sel_advancenature.disabled=true;
				}
				else
				{
					document.forms[0].sel_advancenature.disabled=false;
				}
			}
		}
		if(boolflag)
		{
			enablefields(true);
		}

		if(varDPower=="Y")
		{
			document.forms[0].sel_power_indicator.disabled=false;
		}
		if(varSchemeCode=="Y")
		{
			document.forms[0].sel_facilitybankscheme.disabled=false;
			document.forms[0].selschemehead.disabled=false;
		}
	}
	if(varFacHeadId == "5" && varSubFacHeadId == "48")
	{
		document.forms[0].selschemehead.value = "70044";
		document.forms[0].selschemehead.disabled = true;
	}

	document.forms[0].sel_freecode6.disabled=true;
	document.forms[0].sel_freecode7.disabled=true;
	document.forms[0].sel_freecode8.disabled=true;
}

function doCancel()
{
	if (ConfirmMsg('102')) {
	document.forms[0].hidBeanId.value="FinacleBean";
	document.forms[0].hidBeanGetMethod.value="getCBSDetails";
	document.forms[0].action=appURL+"action/CBSData.jsp";
	document.forms[0].submit();
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].sel_facilitysno.disabled=false;
		document.forms[0].hidAction.value="Delete";
		document.forms[0].hidBeanId.value="FinacleBean"
		document.forms[0].hidBeanMethod.value="updateCBSDetails";
		document.forms[0].hidBeanGetMethod.value="getCBSDetails"
		document.forms[0].hidSourceUrl.value="/action/CBSData.jsp"
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
function getdrawingPower(flag)
{
	if(document.forms[0].sel_power_indicator.value =="E"){
		document.forms[0].txt_drawingpower.readOnly=true;
		document.forms[0].txt_drawingpower.value = "<%= sanctionAmt  %>";
	}else if (document.forms[0].sel_power_indicator.value =="M"){
		document.forms[0].txt_drawingpower.readOnly=false;
	}else if (document.forms[0].sel_power_indicator.value =="D"){
		document.forms[0].txt_drawingpower.value="<%=strMPBFAmt%>";
		document.forms[0].txt_drawingpower.readOnly=true;
	}else{
		if(flag=="Y")
		{
			document.forms[0].txt_drawingpower.value = "0";
		}
		document.forms[0].txt_drawingpower.readOnly=false;
	}
}
function natureofadv()
{
	var loanamt="<%=strloanamt%>";
	var staticvalue="<%=strstaticvalue%>";
	if(varModule=="CORP" || varModule=="AGR")
	{
		if(varCashMargin == "Y" && varFacHeadId == "6" && varSubFacHeadId == "41")
		{
			document.forms[0].sel_advancenature.value="01";
		}
		else if(varFacHeadId == "6" && varSubFacHeadId == "41")
		{
			document.forms[0].sel_advancenature.value="02";
		}
		else
		{
			document.forms[0].sel_advancenature.value='<%=strAdvanceNature%>';
		}
	}
	else
	{
		if(parseFloat(varSecCoverageValue)==0.00)
		{
			document.forms[0].sel_advancenature.value="03";
		}
		else if(parseFloat(varSecCoverageValue)>=100.00)
		{
			document.forms[0].sel_advancenature.value="01";
		}
		else 
		{
			document.forms[0].sel_advancenature.value="02";
		}
		if(varProductType=="pG"||varProductType=="pR")
		{
			document.forms[0].sel_advancenature.value="01";
		}
		document.forms[0].sel_advancenature.disabled=true;
	}	
}
function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
}

function getFreeCode7()
{
	var freec7 = "<%=strFreeCode7%>";
	var strParentRefNo= document.forms[0].sel_freecode6.value;	
	document.forms[0].hidParentLevel.value = "1";
	document.all.ifrm.src=appURL+"action/iframeappfreecode7.jsp?hidBeanId=FinacleBean&hidBeanGetMethod=getFreeCodeData&strLevel=1&strParentRefNo="+strParentRefNo+"&selFreeCodeVal="+freec7;
	var varfreecode7 = document.forms[0].sel_freecode7.value;
	var varfreecode8 = document.forms[0].sel_freecode8.value;
	if(varfreecode7 != "")
	{
		for(var i=0;i<document.forms[0].sel_freecode7.length;i++)
		{
			document.forms[0].sel_freecode7.options[i]=null;
		}	
		document.forms[0].sel_freecode7.options[0].value = "";
		document.forms[0].sel_freecode7.options[0].text = "--Select--";
	}
	getFreeCode8();
}
function getFreeCode8()
{
	var freec8 = "<%=strFreeCode8%>";
	
	var strParentRefNo= document.forms[0].sel_freecode7.value;

	if(strParentRefNo=="")
	{
		strParentRefNo="<%=strFreeCode7%>";
	}
	
	document.forms[0].hidParentLevel.value = "2";
	document.all.ifrm1.src=appURL+"action/iframeappfreecode8.jsp?hidBeanId=FinacleBean&hidBeanGetMethod=getFreeCodeData&strLevel=2&strParentRefNo="+strParentRefNo+"&selFreeCodeVal="+freec8;
}
function changeFreeCode7()
{
	if(document.forms[0].sel_freecode6.value == ""){
		document.forms[0].sel_freecode7.value == "";
		document.forms[0].sel_freecode8.value == "";
	}
	var strParentRefNo= document.forms[0].sel_freecode6.value;	
	document.forms[0].hidParentLevel.value = "1";
	
	document.all.ifrm.src=appURL+"action/iframeappfreecode7.jsp?hidBeanId=FinacleBean&hidBeanGetMethod=getFreeCodeData&strLevel=1&strParentRefNo="+strParentRefNo;
	var varfreecode7 = document.forms[0].sel_freecode7.value;
	var varfreecode8 = document.forms[0].sel_freecode8.value;
	changeFreeCode8("");
}
function changeFreeCode8(Refno)
{	
	var strParentRefNo= Refno;
	if(strParentRefNo=="")
	{
		strParentRefNo="0";
	}	
	document.forms[0].hidParentLevel.value = "2";
	document.all.ifrm1.src=appURL+"action/iframeappfreecode8.jsp?hidBeanId=FinacleBean&hidBeanGetMethod=getFreeCodeData&strLevel=2&strParentRefNo="+strParentRefNo;
}
function showOrganizationSearch(path, forgscode, forgname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = path+"action/searchOrg.jsp?forgscode="+forgscode+"&forgname="+forgname+"&fpageFrom=CBS";
		var title = "Organization";
		var prop = "scrollbars=yes,width=500,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
}
function setText7()
{
	document.forms[0].hidFreeCode7FinVal.value=document.forms[0].sel_freecode7.options[document.forms[0].sel_freecode7.selectedIndex].text;
}
function setText8()
{
	document.forms[0].hidFreeCode8FinVal.value=document.forms[0].sel_freecode8.options[document.forms[0].sel_freecode8.selectedIndex].text;
}
function callMISDetails()
{
	document.forms[0].hidBeanId.value="mis";
	document.forms[0].hidBeanGetMethod.value="getMISDetails";
	document.forms[0].action=appURL+"action/misdetails.jsp";
	document.forms[0].submit();
}
function callIFrame()
{
	document.forms[0].hidBeanId.value="FinacleBean";
	document.forms[0].hidBeanGetMethod.value="getCBSDetails";
	document.forms[0].action=appURL+"action/CBSData.jsp";
	document.forms[0].submit();
}
<%if(!(strLoanType.equalsIgnoreCase(""))) 
{%>
function selglsubcode(varSchemecode)
{
	document.all.ifrmsubcode.src=appURL+"action/iframesubheadcode.jsp?hidBeanGetMethod=getSchemesubheadCodeData&hidBeanId=setproducts&schemecode="+varSchemecode+"&subheadcode="+sel_schemeheadcode;
	
}
function funglsubcode()
{

	if(document.forms[0].sel_facilitysno.value!="")
	{
		if(varSchemecode=="DGDQ" || varSchemecode=="ODGEN" || varSchemecode=="ODPS" || varSchemecode=="ODPSA" || varSchemecode=="ODAG"|| varSchemecode=="ODSEC")
		{
			document.all.glsubcode1.style.display = "block";
			document.all.glsubcode2.style.display = "block";
			document.all.glsubcode3.style.display = "block";
			document.all.glsubcode4.style.display = "block";
			if(document.forms[0].hidScheme.value!="")
			{
				selglsubcode(document.forms[0].hidScheme.value);
			}
			else
			{
				selglsubcode(document.forms[0].sel_facilitybankscheme.value);
			}
			
		}else{
			document.all.glsubcode1.style.display = "none";
			document.all.glsubcode2.style.display = "none";
			document.all.glsubcode3.style.display = "none";
			document.all.glsubcode4.style.display = "none";
		}

	}
	
}
function funglsubcode1()
{
	sel_schemeheadcode="";
	if(document.forms[0].sel_facilitysno.value!="")
	{
		if(varSchemecode=="DGDQ" || varSchemecode=="ODGEN" || varSchemecode=="ODPS" || varSchemecode=="ODPSA" || varSchemecode=="ODAG" || varSchemecode=="ODSEC"|| varSchemecode=="ODSECPS")
		{
			document.all.glsubcode1.style.display = "block";
			document.all.glsubcode2.style.display = "block";
			document.all.glsubcode3.style.display = "block";
			document.all.glsubcode4.style.display = "block";
			selglsubcode(document.forms[0].sel_facilitybankscheme.value);
		}else{
			document.all.glsubcode1.style.display = "none";
			document.all.glsubcode2.style.display = "none";
			document.all.glsubcode3.style.display = "none";
			document.all.glsubcode4.style.display = "none";
		}

	}
	
}
<%}%>
function chkenterval()
{
	document.forms[0].txt_gistofsecurities.value=(document.forms[0].txt_gistofsecurities.value).replace(/(\r\n|\n|\r)/gm," ");
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="CallOnload();getdrawingPower('N');">
<form method="post" class="normal" >
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){
	if(!strSessionModuleType.equalsIgnoreCase("RET")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="26" />
			<jsp:param name="subpageid" value="111" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%}
else{%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="8" />
			<jsp:param name="subpageid" value="118" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<table width="30%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3" align="left" class="outertable">
		<tr align="center">
		<%//if (strPageParam.contains("@CHBRANCH@")
		//&& (strPageParam.contains("@DLA@")
				//|| strPageParam.contains("@DLP@")
				//|| strPageParam.contains("@MIS@"))) { %>
			<td width="50%" class="sub_tab_inactive">
				<a href="JavaScript:callMISDetails();" onMouseOut="window.status='';return true;"
					onMouseOver="window.status='MIS Details';return true;">MIS Details</a>
			</td>
			<%//} %>
			<td width="50%" class="sub_tab_active" nowrap="nowrap">CBS Details</td>
		</tr>
		</table>
	</td>
</tr>
</table>
	
<%}}
else{ %>
<%if(strSessionModuleType.equalsIgnoreCase("RET")||strSessionModuleType.equalsIgnoreCase("LAD")) 
{%>
	<jsp:include page="../share/Applurllinkper.jsp" flush="true">
	<jsp:param name="pageid" value="11" /></jsp:include>
<%}else if(strSessionModuleType.equalsIgnoreCase("DIGI")) 
{%>
	<jsp:include page="../share/applurllinkerdigi.jsp" flush="true">
	<jsp:param name="pageid" value="11" /></jsp:include>
<%}
	else
{ %>
			 
			<jsp:include page="../com/proposallinks.jsp" flush="true"> 
              <jsp:param name="pageid" value="26" />
			   <jsp:param name="cattype" value="<%=strCategoryType%>" />
			  <jsp:param name="ssitype" value="<%=strSSIType%>" />		
			  </jsp:include>
			  
<%} %>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<%if(strLoanType.equalsIgnoreCase("P")) 
		{%>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; MIS/CBS Details -&gt; CBS Details</td>
		
		<%}else if(strLoanType.equalsIgnoreCase("C"))
		{ %>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Corporate &amp; SME -&gt;&nbsp;Proposal&nbsp;-&gt;&nbsp;MIS/CBS Details -&gt; CBS Details</td>
		<%}
		else if(strLoanType.equalsIgnoreCase("A"))
		{ %>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Agriculture -&gt;&nbsp;Proposal&nbsp;-&gt;&nbsp;MIS/CBS Details -&gt; CBS Details</td>
		<%}
		else if(strLoanType.equalsIgnoreCase("D"))
		{ %>
		<td class="page_flow">Home -&gt; Digi Retail -&gt; MIS/CBS Details -&gt; CBS Details</td>
		<%} %>
	</tr>
</table>
<lapschoice:application />
<table width="30%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3" align="left" class="outertable">
		<tr align="center">
			<td width="50%" class="sub_tab_inactive">
				<a href="JavaScript:callMISDetails();" onMouseOut="window.status='';return true;"
					onMouseOver="window.status='MIS Details';return true;">MIS Details</a>
			</td>
			<td width="50%" class="sub_tab_active" nowrap="nowrap">CBS Details</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<%} %>
<br>
<iframe height="0" width="0" name="ifrmsubcode" frameborder="0" style="border:0"></iframe>
<iframe height="0" width="0" id="ifrm" frameborder="0" style="border:0" ></iframe>
<iframe height="0" width="0" id="ifrm1" frameborder="0" style="border:0" ></iframe>
<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center">
<tr>
	<td valign="top">
		<table width="98%" cellspacing="0" cellpadding="2" border="0" class="outertable" align="center">
			<%if(strLoanType.equalsIgnoreCase("C") || strLoanType.equalsIgnoreCase("A") ){ %>
				<tr>
				<td>
				Facility &nbsp; &nbsp;
				</td>
				<TD>
				<select name="sel_facilitysno" tabindex="1" onchange="callIFrame();">
				<option value="" selected="selected">--Select--</option>
                <lapschoice:ComMisDetailsTag apptype='<%=Helper.correctNull((String)request.getParameter("appno")) %>'  page='mis'/>
				</select>
				</td>
				<td colspan="2">
				<table width="98%" cellspacing="0" cellpadding="2" border="0" class="outertable" align="center"  id="schemecodediv">
				<tr>
				<td><div id="glsubcode1">Select Scheme Code</div>
				</td>
				<td><div id="glsubcode2">
				<select name="sel_facilitybankscheme" tabindex="2" onchange="funglsubcode1()">
				<option value="S" >--Select--</option>
				</select></div>
				</td>
				<td><div id="glsubcode3">
				Select GL Sub Head Code <b><span class="mantatory">*&nbsp;</span></b></div>
				</td>
				<td><div id="glsubcode4">
				<select name="selschemehead" tabindex="3" >
				<option value="S" >--Select--</option>
				</select></div>
				</td>
				</tr>
				</table>
				</td>
				</tr>
				<%}else{ %>
				<input type="hidden" name="sel_facilitysno" value="1">
				<tr>
				<td >
				<div id="glsubcode1">Select Scheme Code</div>
				</td>
				<td><div id="glsubcode2">
				<select name="sel_facilitybankscheme" tabindex="2" onchange="funglsubcode1()">
				<option value="S" >--Select--</option>
				</select></div>
				</td>
				<td><div id="glsubcode3">
				Select GL Sub Head Code <b><span class="mantatory">*&nbsp;</span></b></div>
				</td>
				<td><div id="glsubcode4">
				<select name="selschemehead" tabindex="3" >
				<option value="S" >--Select--</option>
				</select></div>
				</td>
				</tr>
				<%} %>
		<tr>
		<td width="20%">Nature of Advance <b><span class="mantatory">*&nbsp;</span></b></td>
			<td width="30%">
				<select name="sel_advancenature" tabindex="1" style="width: 90%">
     				<option value="" selected="selected">--Select--</option>
					<lapschoice:CBSStaticDataNewTag apptype="21" />
    			</select>
    		</td>
			<td width="20%">Mode of Operation <b><span class="mantatory">*&nbsp;</span></b></td>
			<td width="30%">
				<select name="sel_mode" tabindex="1" style="width: 90%">
     				<option value="0" selected="selected">--Select--</option>
					<lapschoice:CBSStaticDataNewTag apptype="17" />
    			</select>
    		</td>
		</tr>
		<tr>
			<td>Drawing Power Indicator <b><span class="mantatory">*&nbsp;</span></b></td>
			<td>
				<select name="sel_power_indicator" onChange="getdrawingPower('Y');" tabindex="3" style="width: 90%">
      				<option value="0" selected="selected">--Select--</option>
					<lapschoice:CBSStaticDataNewTag apptype="16" />
     			</select>
     		</td>
     		<td>Type of Advance <b><span class="mantatory">*&nbsp;</span></b></td>
			<td>
				<select name="sel_advancetype" tabindex="1" style="width: 90%">
     				<option value="" selected="selected">--Select--</option>
					<lapschoice:CBSStaticDataNewTag apptype="22" />
    			</select>
    		</td>
		</tr>
		<tr>
			<td>Drawing Power <b><span class="mantatory">*&nbsp;</span></b></td>
			<td>
				<input type="text" tabindex="5" name="txt_drawingpower" size="41" onkeypress="allowInteger()" maxlength="40" value="">
			</td>
			<td>Mode of Advance</td>
			<td>
				<select name="sel_advancemode" tabindex="1" style="width: 90%">
     				<option value="" selected="selected">--Select--</option>
					<lapschoice:CBSStaticDataNewTag apptype="23" />
    			</select>
    		</td>
		</tr>
		<tr>
			<td>Interest Rate Frequency&nbsp;</td>
			<td><select name="selintrate" tabindex="18">
				<option value="M" selected="selected">Monthly</option>
				<option value="Q">Quartely</option>
				<option value="H">Half-yearly</option>
				<option value="Y">Yearly</option>
			</select></td>
			<td>Purpose of Advance <b><span class="mantatory">*&nbsp;</span></b></td>
			<td>
				<select name="sel_advancepurpose" tabindex="1" style="width: 90%">
     				<option value="" selected="selected">--Select--</option>
					<lapschoice:CBSStaticDataNewTag apptype="24" />
    			</select>
    		</td>
		</tr>
		<tr>
			<td>Free Code 3 <b><span class="mantatory">*&nbsp;</span></b></td>
      		<td> 
       			<select name="sel_freecode3" tabindex="2" style="width: 90%">
      				<option value="" selected="selected" >--Select--</option>
					<lapschoice:StaticDataNewTag apptype="129" />
    			</select>
			</td>
			<td width="20%">
				LBR Code
			</td>
			<td>
				<select name="sel_LBRCode" style="width: 90%">
				<option value="">--Select--</option>
				<lapschoice:MISDataTag apptype="21"/>
				</select>
			</td>
			</tr>
		<tr>
			<td>Free Code 6 <b><span class="mantatory">*&nbsp;</span></b></td>
      		<td> 
       			<select name="sel_freecode6" tabindex="2" onchange="changeFreeCode7()" style="width: 90%">
      				<option value="0" selected="selected" >--Select--</option>
					<lapschoice:StaticDataNewTag apptype="127" />
    			</select>
			</td>
			<td>Loan Disbursing Branch <b><span class="mantatory">*&nbsp;</span></b></td>
			<td>
				<input type="hidden" name="hid_LoanDisbBranch" value="<%=Helper.correctNull((String)hshValues.get("strOrgCode"))%>">
				<input type="text" name="txt_LoanDisbBranch" size="38" value="<%=Helper.correctNull((String)hshValues.get("strOrgName"))%>">
				<b><a href="#" onClick="showOrganizationSearch('<%=ApplicationParams.getAppUrl()%>','hid_LoanDisbBranch','txt_LoanDisbBranch')" id="idBranch"
					style="cursor: hand">
					<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" ></a></b>
    		</td>
		</tr>
		<tr>
			<td>Free Code 7 <b><span class="mantatory">*&nbsp;</span></b></td>
      		<td> 
       			<select name="sel_freecode7" tabindex="4" onchange="changeFreeCode8(document.forms[0].sel_freecode7.value);setText7();" style="width: 90%">
      				<option value="" selected="selected">--Select--</option> 
    			</select>
			</td>
			<td >Gist of Securities<span class="mantatory">*&nbsp;</span> <input type="hidden" name="sel_securitycode" value=""></td>
			<td rowspan="3"><textarea name="txt_gistofsecurities" rows="3" cols="40" onKeyPress="textlimitcorp1(this,'240');if(event.keyCode==13){return false;}"  onkeyup="textlimitcorp1(this,240);" onkeydown="textlimitcorp1(this,240);"
				 wrap="VIRTUAL" onblur="chkenterval();textlimitcorp1(this,'240');"><%=Helper.correctNull((String)hshValues.get("CER_GISTOFSECURITUES"))%></textarea></td>
			<!--<td>Security Code <b><span class="mantatory">*&nbsp;</span></b></td>
      		<td> 
       			<select name="sel_securitycode" tabindex="6" style="width: 90%">
      				<option value="" selected="selected">--Select--</option>
      				<lapschoice:CBSStaticDataNewTag apptype="25" />
    			</select>
			</td>-->
		</tr>
		<tr>
			<td>Free Code 8 <b><span class="mantatory">*&nbsp;</span></b></td>
      		<td> 
       			<select name="sel_freecode8" tabindex="6" onchange="setText8();" style="width: 90%">
      				<option value="" selected="selected">--Select--</option>
    			</select>
			</td>
			<td>&nbsp;</td>
		</tr>
		<Tr><td colspan="3">&nbsp;</td></Tr>
		<tr>
			<td>LAPS code 1 <b><span class="mantatory">*&nbsp;</span></b></td>
			<td>
				<select name="sel_lapscode1" tabindex="1" style="width: 90%">
     				<option value="" selected="selected">--Select--</option>
					<lapschoice:StaticDataNewTag apptype="183" />
    			</select>
    		</td>
			<td>LAPS code 2 <b><span class="mantatory">*&nbsp;</span></b></td>
			<td>
				<select name="sel_lapscode2" tabindex="1" style="width: 90%">
     				<option value="" selected="selected">--Select--</option>
					<lapschoice:StaticDataNewTag apptype="184" />
    			</select>
    		</td>
		</tr>
		<tr>
			<td>LAPS code 3 <b><span class="mantatory">*&nbsp;</span></b></td>
			<td>
				<select name="sel_lapscode3" tabindex="1" style="width: 90%">
     				<option value="" selected="selected">--Select--</option>
					<lapschoice:StaticDataNewTag apptype="185" />
    			</select>
    		</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidappno" value="<%=strAppNumfrombean%>"> 
<input type="hidden" name="Applicationno" value="<%=strAppNumfrombean%>">
<input type="hidden" name="hidParentLevel">
<input type="hidden" name="hidRefNo" value="">
<input type="hidden" name="hidFreeCode7">
<input type="hidden" name="hidFreeCode8">
<input type="hidden" name="hidFreeCode7FinVal">
<input type="hidden" name="hidFreeCode8FinVal">
<input type="hidden" name="hidFreeCode7Desc">
<input type="hidden" name="hidFreeCode8Desc">
<iframe height="0" width="0" id="ifrmpropFac" frameborder=0 style="border: 0"></iframe>
<input type="hidden" name="hidappno1" value="<%=Helper.correctNull((String)request.getParameter("appno"))%>">
<input type="hidden" name="hidScheme" value="<%=StrScheme%>"> 
<input type="hidden" name="hidFacSno" value="<%=Helper.correctNull((String)hshValues.get("strFacilitySno"))%>">
<input type="hidden" name="hidPostSancParams" value="<%=Helper.correctNull((String)hshValues.get("strPostSancParam"))%>">
<input type="hidden" name="hidForexFac" value="<%=Helper.correctNull((String)hshValues.get("strForexFacility"))%>">
</form>
</body>
</html>
