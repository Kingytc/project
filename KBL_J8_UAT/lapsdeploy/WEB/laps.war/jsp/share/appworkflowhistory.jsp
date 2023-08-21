<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrFromUsr = (ArrayList) hshValues.get("arrFromUsr");
	ArrayList arrToUsr = (ArrayList) hshValues.get("arrToUsr");
	ArrayList arrFromflow = (ArrayList) hshValues.get("arrFromflow");
	ArrayList arrToflow = (ArrayList) hshValues.get("arrToflow");
	ArrayList arrDate = (ArrayList) hshValues.get("arrDate");
	ArrayList arrMailtype = (ArrayList) hshValues.get("arrMailType");

	if (Helper.correctNull((String) session.getAttribute("link")).equals(""))
		session.setAttribute("link", "PROP");

	String prd_type = Helper.correctNull((String) session.getAttribute("strProductType"));
	if(prd_type.equalsIgnoreCase(""))
	{
		session.setAttribute("strProductType", Helper.correctNull((String)hshValues.get("strPrdtype")));
	}
	
	session.setAttribute("prdcode", Helper.correctNull((String)hshValues.get("app_prdcode")));
	String chkstatus = Helper.correctNull((String) hshValues.get("Stateflag"));
	String loantype = "";
	String loan_type = Helper.correctNull((String) hshValues.get("app_loantype"));
	String legalcomp = Helper.correctNull((String) hshValues.get("app_legalcomp"));
	String strMigrationFlag= Helper.correctNull((String) hshValues.get("app_migration"));

	if (loan_type.equalsIgnoreCase("P")) {
		loantype = "Retail";
	}
	if (loan_type.equalsIgnoreCase("A")) {
		loantype = "Agriculture";
	}
	if (loan_type.equalsIgnoreCase("T")) {
		loantype = "Tertiary";
	}
	if (loan_type.equalsIgnoreCase("c")) {
		if (strCategoryType.equalsIgnoreCase("ASSI")
				|| strCategoryType.equalsIgnoreCase("ASBI")) {
			loantype = "Tertiary";
		} else {
			loantype = "Corporate";
		}
	}
	String PRD_CGTMSE = Helper.correctNull((String) hshValues.get("PRD_CGTMSE"));
	String strprdtype = Helper.correctNull((String) hshValues.get("prd_staffprd"));
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	String strAppstatus = Helper.correctNull((String)hshValues.get("appstatus"));
	session.setAttribute("appstatus",Helper.correctNull((String)hshValues.get("appstatus")));
	String appid = Helper.correctNull((String)hshValues.get("hidDemoId"));
	if(appid.equals(""))
		appid = Helper.correctNull((String)hshValues.get("hidapplicantid"));
	
	if(strSessionModuleType.equalsIgnoreCase(""))
	{
	 strSessionModuleType=Helper.correctNull((String)request.getParameter("ModuleType")).trim();
	 session.setAttribute("sessionModuleType",strSessionModuleType);
	}
	if(strSessionModuleType.equalsIgnoreCase(""))
	{
	 strSessionModuleType=Helper.correctNull((String)request.getParameter("hidCategoryType")).trim();
	 session.setAttribute("sessionModuleType",strSessionModuleType);
	}
	//out.println("aedsf"+strSessionModuleType)
	session.setAttribute("strAppType",Helper.correctNull((String)hshValues.get("app_renew_flag")));
	session.setAttribute("strPageID_PS", Helper.correctNull((String) hshValues.get("Page_Id_PS")));
	//out.println("&&&&&&&&&&"+Helper.correctNull((String) hshValues.get("Page_Id_PS")));
	session.setAttribute("strModifyterms", Helper.correctNull((String) hshValues.get("strModifyterms")));
	session.setAttribute("strProductType", Helper.correctNull((String) hshValues.get("strPrdtype")));
	session.setAttribute("schemeCode", Helper.correctNull((String) hshValues.get("strLoanType")));
	session.setAttribute("PRD_CGTMSE", Helper.correctNull((String) hshValues.get("PRD_CGTMSE")));
	
	session.removeAttribute("HouseEdit_Flag");
	session.removeAttribute("valuationFlag");
	session.removeAttribute("VehicleEdit_Flag");
	
	String strPSTerms="";
	
	if(Helper.correctNull((String) hshValues.get("strModifyterms")).equalsIgnoreCase("REODWC@"))
	{
		strPSTerms="Y";
	}
	else if(Helper.correctNull((String) hshValues.get("strModifyterms")).contains("REODWC@"))
	{
		strPSTerms="Y";
	}
	
%>
<html>
<head>
<title>Personal - Work Flow</title>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var chkstatus="<%=chkstatus%>";
var varappstatus="";
var varloantype="<%=loan_type%>";
var strPrdType="<%=prd_type%>";
var strPRDCGTMSE="<%=PRD_CGTMSE%>";

function callAppraisal()
{	
	var com_appno= document.forms[0].hidAppNo.value;
	if(appno.length!=0)
	{		
		window.open(appURL+"action/perappsanctionsanction.jsp?appno="+com_appno,"AppraisalSanction", "scrollbars=yes,toolbars=No,menubar=no,width=600,height=450,top=0,left=0");
	}
}


function callOnload()
{
	<% if(strSessionModuleType.equalsIgnoreCase("DIGI"))
	{ %>
		var apistatus="<%=Helper.correctNull((String)hshValues.get("apistatus"))%>";
		var apistatusdesc="<%=Helper.correctNull((String)hshValues.get("apistatusdesc"))%>";
		if(apistatus!="")
		{
			alert(apistatus+". "+apistatusdesc);
		}
	<% } %>
	
	if(document.forms[0].appstatus.value == "Processed/Approved" || document.forms[0].appstatus.value == "Closed/Approved")
 	{
		<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){
		
		if(!strSessionModuleType.equalsIgnoreCase("RET") && Helper.correctNull((String)hshValues.get("com_proposalsanctype")).equalsIgnoreCase("P")){%>
			document.forms[0].cmdprocessprint.value="Permission Letter to Branch";
			document.forms[0].cmdprocessprint1.value="Permission Letter to Borrower";
		<%}
		else if(strSessionModuleType.equalsIgnoreCase("RET")){%>
		document.forms[0].cmdprocessprint.value="Permission Letter to Borrower";
		document.forms[0].cmdprocessprint1.value="Permission Letter to Branch";
	<%}}%>
 		if(chkstatus=="1")
 		{	
 		alert("Application is Sanctioned");
 		}
		if(varloantype.toUpperCase()=="P")
		{
			document.all["cmdprocessprint"].style.visibility="visible";
		}
		else if(varloantype.toUpperCase()=="C")
		{
			//document.all["annexureb"].style.visibility="visible";
			//document.all["annexurea"].style.visibility="visible";
			
			//document.all["terms_condt"].style.visibility="visible";
			//document.all["sanctionadvice"].style.visibility="visible";
		}
		else if(varloantype.toUpperCase()=="U")//Short Term Loan
		{
			//document.all["terms_condt"].style.visibility="visible";
			//document.all["sanctionadvice"].style.visibility="visible";
		}
		else if(varloantype.toUpperCase()=="H")//Adhoc Limit
		{
			//document.all["terms_condt"].style.visibility="visible";
			//document.all["sanctionadvice"].style.visibility="visible";
		}
		else if(varloantype.toUpperCase()=="T")
		{
			if("<%=strSSIType%>"=="WADV")
				document.all["cmdteritiary"].style.visibility="hidden";
		}
		else if(varloantype.toUpperCase()=="A")
		{
			if("<%=prd_type%>"=="aH")
			document.all["cmdprocessprint"].style.visibility="visible";
		}
	} 
	else if(varloantype.toUpperCase()=="P")
	{
		document.all["cmdprocessprint"].style.visibility="hidden";
		if(strPrdType!="pG"  && strPrdType!="pR")
		{
		document.all["cmdprocessprint1"].style.visibility="hidden";
		}
	}
	else if(varloantype.toUpperCase()=="C")//corporate
	{
		//document.all["terms_condt"].style.visibility="hidden";
		//document.all["sanctionadvice"].style.visibility="hidden";

		//document.all["annexureb"].style.visibility="hidden";
		//document.all["annexurea"].style.visibility="hidden";
	}
	else if(varloantype.toUpperCase()=="U")//Short Term Loan
	{
		//document.all["terms_condt"].style.visibility="hidden";
		//document.all["sanctionadvice"].style.visibility="hidden";
	}
	else if(varloantype.toUpperCase()=="H")//Adhoc Loan
	{
		//document.all["terms_condt"].style.visibility="hidden";
		//document.all["sanctionadvice"].style.visibility="hidden";
	}
	else if(varloantype.toUpperCase()=="T")//Tertiary
	{
		//document.all["terms_condt"].style.visibility="hidden";
		//document.all["sanctionadvice"].style.visibility="hidden";
		//document.all["terms_condt"].style.position="absolute";
		//document.all["sanctionadvice"].style.position="absolute";
		
		if("<%=strSSIType%>"=="WADV")
			document.all["cmdteritiary"].style.visibility="hidden";
	}
	else if(varloantype.toUpperCase()=="A")
	{
		if("<%=prd_type%>"=="aH")
		document.all["cmdprocessprint"].style.visibility="hidden";
	}
	if(document.forms[0].appstatus.value=="Processed/Approved" || document.forms[0].appstatus.value=="Closed/Approved")
	{
		if(strPrdType!="pG"  && strPrdType!="pR")
		{
			document.all.idloanaccount.style.visibility="visible";
			document.all.idloanaccount.style.position="relative";
			document.all.idrestr.style.visibility="visible";
			document.all.idrestr.style.position="relative";
			document.all.idCGTMSEtxn.style.visibility="visible";
			document.all.idCGTMSEtxn.style.position="relative";	
		}
		else
		{
			document.all.idloanaccount.style.visibility="hidden";
			document.all.idloanaccount.style.position="absolute";
			document.all.idrestr.style.visibility="hidden";
			document.all.idrestr.style.position="absolute";
			//document.all.idCGTMSEtxn.style.visibility="hidden";
			//document.all.idCGTMSEtxn.style.position="absolute";	
				
		}
		if(varloantype.toUpperCase()=="C" || varloantype.toUpperCase()=="A")
		{	
			document.all.idfacdetail.style.visibility="visible";
			document.all.idfacdetail.style.position="relative";
		}
	}
	else
	{
		document.all.idloanaccount.style.visibility="hidden";
		document.all.idloanaccount.style.position="absolute";
		document.all.idrestr.style.visibility="hidden";
		document.all.idrestr.style.position="absolute";
		//document.all.idCGTMSEtxn.style.visibility="hidden";
		//document.all.idCGTMSEtxn.style.position="absolute";	

		if(varloantype.toUpperCase()=="C" || varloantype.toUpperCase()=="A")
		{
			document.all.idfacdetail.style.visibility="hidden";
			document.all.idfacdetail.style.position="absolute";
		}
	}
	if("<%=strSessionModuleType%>"=="DIGI")
	{
		if( (strPrdType=="pH" || strPrdType=="pA" || strPrdType=="pB" || strPrdType=="pM") && (document.forms[0].appstatus.value == "Processed/Approved" || document.forms[0].appstatus.value == "Closed/Approved") )
		{
			document.all["cmdprocessprint"].style.visibility="visible";
			document.all["cmdprocessprint1"].style.visibility="visible";
		}
		else
		{
			document.all["cmdprocessprint"].style.visibility="hidden";
			document.all["cmdprocessprint1"].style.visibility="hidden";
		}
	}
}
function callLoanAccount()
{
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="getLoanAccountData";
	document.forms[0].action=appURL+"action/apploanaccount.jsp";
	document.forms[0].submit();
}
function callFacDetail()
{
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="getFacilityDetailsData";
	document.forms[0].action=appURL+"action/appfacilitydetails.jsp";
	document.forms[0].submit();
}
function callQueries()
{
		 document.forms[0].hidBeanGetMethod.value="getQueryData";
		 document.forms[0].hidBeanId.value="documentsupport";
		 document.forms[0].action=appURL+"action/appqueryhome.jsp";
		 document.forms[0].submit();
}
function callOtherTab(val)
{
	var strCatType="<%=strCategoryType%>";
	if(val=="action")
	{
		document.forms[0].hidBeanGetMethod.value="getAction";
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].cattype.value=strCatType;
		document.forms[0].action=appURL+"action/appworkflowaction.jsp";
		document.forms[0].submit();
	}
	if(val=="actiondigi")
	{
		document.forms[0].hidBeanGetMethod.value="getAction";
		document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].action=appURL+"action/permworkflowaction.jsp";
		document.forms[0].submit();
	}
	if(val=="drawdownschedule")
	{
		if (varloantype == "C"||true)
		{
		 document.forms[0].hidBeanId.value="commworkflow";
		 document.forms[0].hidBeanGetMethod.value="getDrawDownSchedule";
		 document.forms[0].action=appURL+"action/drawdownschedule.jsp";
		 document.forms[0].submit();
	 	}
		else
		{
                alert("Draw Down Schedule to be Entered only for Project Loans");
                return;
        }
	}
	if(val=="sanction")
	{
		document.forms[0].hidBeanGetMethod.value="getTermsofSanctionFacilityData";
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].cattype.value=strCatType;
		document.forms[0].action=appURL+"action/com_termsofsanction.jsp";
		document.forms[0].submit();
	}
	if(val=="comments")
	{
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getWorkFlowComments";
		document.forms[0].action=appURL+"action/appworkflowcomment.jsp";
		document.forms[0].submit();
	}
	if(val=="legcomp")
	{
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getlegalComplianceData";
		document.forms[0].action=appURL+"action/legalcompliance.jsp";
		document.forms[0].submit();
	}
	if(val=="restrfacdetails")
	{
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getRestrFacilityDetails";
		document.forms[0].action=appURL+"action/apprestructureaccountdetails.jsp";
		document.forms[0].submit();
	}
	if(val=="CGTMSE_TXN")
	{
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getCGTMSE_txndet";
		document.forms[0].action=appURL+"action/app_CGTMSE_txnDet.jsp";
		document.forms[0].submit();
	}
}

function doClose()
{
	if(varloantype.toUpperCase()=="P" || varloantype.toUpperCase()=="A")
	{
		if(ConfirmMsg(100))
		{
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/retailpge.jsp";
			document.forms[0].submit();
		}
	}
	var cattype=document.forms[0].cattype.value;
    if(cattype=="OPS")
    {
    	if(ConfirmMsg(100))
	 	{
			document.forms[0].action=appURL+"action/agrpage.jsp";
		 	document.forms[0].submit();
	 	}
	}
	if((cattype=="CORP")||(cattype=="SME")||(cattype=="SRE")||(cattype=="STL") ||(cattype=="ADC"))
    {
    	if(ConfirmMsg(100))
	 	{
			document.forms[0].action=appURL+"action/corppge.jsp";
		 	document.forms[0].submit();
	 	}
	}	
}

function ShowReport(page)
{
	var com_appno = document.forms[0].hidAppNo.value;
	var url = "<%=ApplicationParams.getAppUrl()%>action/"+page+"?appno="+com_appno;
	var title = "Retail Process Note";
	var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}
  
function ShowReport1(page)
{
	var com_appno = document.forms[0].hidAppNo.value;
	var url = "<%=ApplicationParams.getAppUrl()%>action/"+page+"?hidBeanId=processNote&hidBeanGetMethod=getRetailSanctionletterHouse&appno="+com_appno;
	var title="Retail_Process_Note_1";
	var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}
function ShowReport2(page)
{
	var com_appno = document.forms[0].hidAppNo.value;
	var url = "<%=ApplicationParams.getAppUrl()%>action/"+page+"?hidBeanId=documentresults&hidBeanGetMethod=getData&appno="+com_appno;
	var title="Retail_Process_Note_2";
	var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}

function menuOptionDivMouseDown (url) 
{
	document.currentMenu.style.display='none';
	document.currentMBarOpt.style.border='1px solid lightgrey';
	document.menuIsActive = false;
	document.forms[0].action=url;
	document.forms[0].submit();
}

function ShowCheckList()
{	
	var appno = document.forms[0].appno.value;
	var appname=document.forms[0].appname.value;
	var url = "<%=ApplicationParams.getAppUrl()%>action/checklist.jsp?appno="+appno+"&appname="+appname;
	var title="CheckListReport";
	var prop = "scrollbars=yes,width=395,height=420";
	var xpos = 170;
	var ypos = 100;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}
function ShowCasfFlow()
{	
	var appno = document.forms[0].appno.value;
	var appname=document.forms[0].appname.value;
	var url = "<%=ApplicationParams.getAppUrl()%>action/comruncashflowbob.jsp?hidBeanId=comrepcashflowbob&hidBeanMethod=getData&hidMethod=getRowsCols&hidAppno="+appno
	var title = "CashFlow";
	var prop = "scrollbars=yes,width=800,height=550";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}

function AudBankReprt()
{	
	var appno = document.forms[0].appno.value;
	var appname=document.forms[0].appname.value;
	var url = "<%=ApplicationParams.getAppUrl()%>action/auditorbankrep.jsp?appno="+appno+"&appname="+appname;
	var title = "";
	var prop = "scrollbars=yes,width=1395,height=1420";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
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
  
function dohlp()     
{
  var hlpvar = appURL+"phlp/loan_appretail_workflow_his.htm";
  var title = "History";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}

function doSancAnnexureA()
{		
	if(varloantype.toUpperCase()=="C")
	{
		var appno=document.forms[0].appno.value;
		var title = "Corporate_Sanction_Letter";
		var CompanyName="<%=request.getParameter("appname")%>";						
		var purl ="<%=ApplicationParams.getAppUrl()%>action/com_sancannexureone.jsp?hidBeanGetMethod=getCorpSanLetterAnnexureone&hidBeanId=sanctionadvice&appno="+appno+"&borrowername="+CompanyName;
		var prop = 'scrollbars=yes,menubar=yes,width=750,height=520';	
		var xpos = (screen.width - 750) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,title,prop);
	}
}	
function doSancAnnexureB()
{		
	if(varloantype.toUpperCase()=="C")
	{
		var appno=document.forms[0].appno.value;
		var title = "Corporate_Sanction_Letter";
		var CompanyName="<%=request.getParameter("appname")%>";						
		var purl ="<%=ApplicationParams.getAppUrl()%>action/corporatesanctionletter.jsp?hidBeanGetMethod=getCorpSanLetterAnnexuretwo&hidBeanId=sanctionadvice&appno="+appno+"&borrowername="+CompanyName;
		var prop = 'scrollbars=yes,menubar=yes,width=750,height=520';	
		var xpos = (screen.width - 750) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,title,prop);
	}
	/*if(varloantype.toUpperCase()=="T")
	{
		var appno=document.forms[0].appno.value;
		var CompanyName="<%=request.getParameter("appname")%>";		
		var title = "Tertiary_Sanction_Letter";				
		var purl ="<%=ApplicationParams.getAppUrl()%>action/ops_sanctionletter.jsp?hidBeanGetMethod=getTertiarySanctionletter&hidBeanId=sanctionadvice&appno="+appno+"&borrowername="+CompanyName;
		var prop = 'scrollbars=yes,menubar=yes,width=750,height=520';	
		var xpos = (screen.width - 750) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,title,prop);
	}*/
}

function doTeritiaryNote()
{
	var appno=document.forms[0].appno.value;
	var title = "Tertiary_Process_Note";
	var purl ="<%=ApplicationParams.getAppUrl()%>action/tertiaryprocessnote.jsp?hidBeanGetMethod=getTertiaryProcessNote&hidBeanId=processNote&appno="+appno;
	var prop = 'scrollbars=yes,menubar=yes,width=750,height=520';	
	var xpos = (screen.width - 750) / 2;
	var ypos = (screen.height - 520) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
} 

function doSanctionAdvice()
{
	if(varloantype.toUpperCase()=="C")
	{
		var appno=document.forms[0].appno.value;
		var title = "Corporate_Sanction_Advice";
		var cattype=document.forms[0].cattype.value;
		var CompanyName="<%=request.getParameter("appname")%>";						
		var purl ="<%=ApplicationParams.getAppUrl()%>action/TertiarySanctionAdvice.jsp?hidBeanGetMethod=getCorporateSanctionAdvice&hidBeanId=sanctionadvice&appno="+appno+"&borrowername="+CompanyName+"&cattype1="+cattype;
		var prop = 'scrollbars=yes,menubar=yes,width=750,height=520';	
		var xpos = (screen.width - 750) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,title,prop);
	}
	if(varloantype.toUpperCase()=="U")//Short Term Loan
	{
    	var appno=document.forms[0].appno.value;
		var title = "Corporate_Sanction_Advice";
		var cattype=document.forms[0].cattype.value;
		var CompanyName="<%=request.getParameter("appname")%>";						
		var purl ="<%=ApplicationParams.getAppUrl()%>action/comstl_sanctionadvice.jsp?hidBeanGetMethod=getShortTermLoanLimitSanctionAdvice&hidBeanId=sanctionadvice&appno="+appno+"&borrowername="+CompanyName+"&cattype1="+cattype;
		var prop = 'scrollbars=yes,menubar=yes,width=750,height=520';	
		var xpos = (screen.width - 750) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,title,prop);
	}
	if(varloantype.toUpperCase()=="H")//Adhoc Loan
	{
		var appno=document.forms[0].appno.value;
		var title = "Corporate_Sanction_Advice";
		var cattype=document.forms[0].cattype.value;
		var CompanyName="<%=request.getParameter("appname")%>";						
		var purl ="<%=ApplicationParams.getAppUrl()%>action/adc_sanctionadvice.jsp?hidBeanGetMethod=getAdhocLimitSanctionAdvice&hidBeanId=sanctionadvice&appno="+appno+"&borrowername="+CompanyName+"&cattype1="+cattype;
		var prop = 'scrollbars=yes,menubar=yes,width=750,height=520';	
		var xpos = (screen.width - 750) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,title,prop);
	}
	if(varloantype.toUpperCase()=="T")
	{
		var appno=document.forms[0].appno.value;
		var title = "Tertiary_Sanction_Advice";
		var cattype=document.forms[0].cattype.value;
		var CompanyName="<%=request.getParameter("appname")%>";						
		var purl ="<%=ApplicationParams.getAppUrl()%>action/TertiarySanctionAdvice.jsp?hidBeanGetMethod=getTertiarySanctionAdvice&hidBeanId=sanctionadvice&appno="+appno+"&borrowername="+CompanyName+"&cattype1="+cattype;
		var prop = 'scrollbars=yes,menubar=yes,width=750,height=520';	
		var xpos = (screen.width - 750) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,title,prop);
	}
}  
function doTermsandcondt()
{
		var appno=document.forms[0].appno.value;
		var title = "Terms_And_Conditions";
		var CompanyName="<%=request.getParameter("appname")%>";						
		var purl ="<%=ApplicationParams.getAppUrl()%>action/cor_termsandconditions.jsp?hidBeanGetMethod=getTermsConditions&hidBeanId=commworkflow&appno="+appno+"&borrowername="+CompanyName;
		var prop = 'scrollbars=yes,menubar=yes,width=750,height=520';	
		var xpos = (screen.width - 750) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,title,prop);
}
function ShowReport3(page)
{
	var com_appno = document.forms[0].hidAppNo.value;
	var url = "<%=ApplicationParams.getAppUrl()%>action/"+page+"?hidBeanId=sanctionadvice&hidBeanGetMethod=getStaffLoanSanctionAdvice&appno="+com_appno;
	var title = "Sanction_Letter";
	var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
	
}
function ShowReport4(page)
{
	var com_appno = document.forms[0].hidAppNo.value;
	var url = "<%=ApplicationParams.getAppUrl()%>action/"+page+"?hidBeanId=documentresults&hidBeanGetMethod=getSanctionLetterData&appno="+com_appno+"&hidapplicantid="+document.forms[0].hidapplicantid.value;
	var title = "Sanction_Letter";
	var prop = "scrollbars=yes,width=900,height=550,menubar=yes";
	var xpos = (screen.width - 810) / 2;
	var ypos = (screen.height - 668) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}

function doCorpSancletter(val)
{		
	if(varloantype.toUpperCase()=="C" || varloantype.toUpperCase()=="A")
	{
		if(val == "br")
		{
			var appno=document.forms[0].appno.value;
			var title = "Corp_Sanc_Letter_Branch";
			var CompanyName="<%=request.getParameter("appname")%>";						
			var purl ="<%=ApplicationParams.getAppUrl()%>action/corpsanclettertobranch.jsp?hidBeanGetMethod=getCorpSanctiondata&hidBeanId=sanctionadvice&appno="+appno+"&borrowername="+CompanyName+"&type="+"BR";
			var prop = 'scrollbars=yes,menubar=yes,width=850,height=580';	
			var xpos = (screen.width - 850) / 2;
			var ypos = (screen.height - 580) / 2;
			prop = prop + ",left="+xpos+",top="+ypos;
			window.open(purl,title,prop);
		}
		else
		{
			var appno=document.forms[0].appno.value;
			var title = "Corp_Sanc_Letter_Borrower";
			var CompanyName="<%=request.getParameter("appname")%>";						
			var purl ="<%=ApplicationParams.getAppUrl()%>action/corpsanclettertoborrower.jsp?hidBeanGetMethod=getCorpSanctiondata&hidBeanId=sanctionadvice&appno="+appno+"&borrowername="+CompanyName+"&type="+"BO";
			var prop = 'scrollbars=yes,menubar=yes,width=850,height=580';	
			var xpos = (screen.width - 850) / 2;
			var ypos = (screen.height - 580) / 2;
			prop = prop + ",left="+xpos+",top="+ypos;
			window.open(purl,title,prop);	
		}
	}
}

function callMDSanction()
{
	var com_appno = document.forms[0].hidAppNo.value;
	var com_appid = "<%=appid %>";
	var pgType = "MDSanction";
	var purl 	= "<%=ApplicationParams.getAppUrl()%>action/com_MDSanction.jsp?hidBeanGetMethod=getProposalMDSanction&hidBeanId=lapsReport&appno="+com_appno+"&appid="+com_appid+"&pgType="+pgType;
	var title 	= "MDSanctionFormat";
	var prop 	= "scrollbars=yes,width=1200,height=550,menubar=yes";
	var xpos 	= 5;
	var ypos 	= 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}
function ShowKFS(page)
{
	var com_appno = document.forms[0].hidAppNo.value;
	var url = "<%=ApplicationParams.getAppUrl()%>action/"+page+"?hidBeanId=documentresults&hidBeanGetMethod=getKeyFactStatementData&appno="+com_appno+"&hidapplicantid="+document.forms[0].hidapplicantid.value;
	var title = "Sanction_Letter";
	var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
	var xpos = (screen.width - 810) / 2;
	var ypos = (screen.height - 668) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}
function doPermissionletter()
{
	var com_appno = document.forms[0].hidAppNo.value;
	var com_appid = "<%=appid %>";
	var pgType = "MDSanction";
	var purl 	= "<%=ApplicationParams.getAppUrl()%>action/com_permissionletterformclr.jsp?hidBeanGetMethod=getMCLRPermissionLetter&hidBeanId=lapsReport&strDetails=MCLR&appno="+com_appno;
	var title 	= "MDSanctionFormat";
	var prop 	= "scrollbars=yes,width=900,height=550,menubar=yes";
	var xpos 	= 5;
	var ypos 	= 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);	
}
function doPermissionletter1()
{
	var com_appno = document.forms[0].hidAppNo.value;
	var com_appid = "<%=appid %>";
	var pgType = "MDSanction";
	var purl 	= "<%=ApplicationParams.getAppUrl()%>action/com_EBLRAnnexure.jsp?hidBeanGetMethod=getMCLRPermissionLetter&hidBeanId=lapsReport&strDetails=EBLR&appno="+com_appno;
	var title 	= "MDSanctionFormat";
	var prop 	= "scrollbars=yes,width=900,height=550,menubar=yes";
	var xpos 	= 5;
	var ypos 	= 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);	
}
function doCreditsanction()
{
	var appno=document.forms[0].appno.value;
	var purl = appURL+"action/appworkflowcredit.jsp?hidBeanGetMethod=getCorpSanctiondata&hidBeanId=sanctionadvice&strFormat=postsanc&appno="+appno;
	var prop = "scrollbars=Yes,width=900,height=600,top=100,left=250";
	window.open(purl,"Creditsanction",prop);
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../htm/link.css" type="text/css">
<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 250;
	overflow: auto;
}
</STYLE>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="callOnload()">
<form name="frmworkflow" method="post" class="normal">
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){
	if(!strSessionModuleType.equalsIgnoreCase("RET")){ %>
	<!-- //shiva -->
	
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
			<jsp:param name="subpageid" value="113" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="9" />
			<jsp:param name="subpageid" value="119" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
	<tr><td id="idfacdetail"></td></tr>
</table>
<%}}else{  %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<%
			if (strSessionModuleType.equalsIgnoreCase("RET")||strSessionModuleType.equalsIgnoreCase("LAD")) {
		%> <jsp:include page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
		</jsp:include> <%
 	} if (strSessionModuleType.equalsIgnoreCase("DIGI")) {
		%> <jsp:include page="../share/applurllinkerdigi.jsp" flush="true">
		<jsp:param name="pageid" value="7" />
	</jsp:include> <%
	} 	else if (loan_type.equalsIgnoreCase("E")
 			|| loan_type.equalsIgnoreCase("U")
 			|| loan_type.equalsIgnoreCase("H")
 			|| loan_type.equalsIgnoreCase("T")) {
 %> <jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="15" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <span style="display: none;"><lapschoice:borrowertype /></span> <%
 	} else if (loan_type.equalsIgnoreCase("C") || loan_type.equalsIgnoreCase("A")) {
 %> <jsp:include page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <span style="display: none;"><lapschoice:borrowertype /></span> <%
 	}
 %>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	 <%if(strSessionModuleType.equals("AGR")){%>
	 <tr>
		<td class="page_flow">Home -&gt; Agriculture-&gt; Proposal -&gt; WorkFlow -&gt;
		History</td>
	</tr>
	<%}else if (strCategoryType.equalsIgnoreCase("SRE")) {%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt;  Application -&gt; WorkFlow -&gt; History</td>
	</tr>
	<%} else if (strCategoryType.equalsIgnoreCase("STL")) {%>
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Short
		Term Loan -&gt; WorkFlow -&gt; History</td>
	</tr>
	<%} else if (strCategoryType.equalsIgnoreCase("ADC")) {%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Ad hoc
		Limit -&gt; WorkFlow -&gt; History</td>
	</tr>
	<%} else if (strCategoryType.equalsIgnoreCase("LAD")) {%>
	<tr>
		<td class="page_flow">Home -&gt; Loan Against Gold Ornaments &amp;
		Deposits -&gt; WorkFlow -&gt; History</td>
	</tr>
		<%} else if (strCategoryType.equalsIgnoreCase("OPS")) {%>
	<tr>
		<td class="page_flow">Home -&gt;Tertiary -&gt; Application -&gt; WorkFlow -&gt; History</td>
	</tr>
	<%} else if (strCategoryType.equalsIgnoreCase("AGR")) {%>
	<tr>
		<td class="page_flow">Home -&gt;Agriculture -&gt; Application -&gt; WorkFlow -&gt; History</td>
	</tr>
	<%} else if (strCategoryType.equalsIgnoreCase("RET")) {%>
	<tr>
		<td class="page_flow">Home -&gt; Retail(including schematic)  -&gt;Application -&gt; WorkFlow -&gt;
		History</td>
	</tr>
	<%} else if (strCategoryType.equalsIgnoreCase("DIGI")) {%>
	<tr>
		<td class="page_flow">Home -&gt; Digi Retail -&gt;Application -&gt; WorkFlow -&gt;
		History</td>
	</tr>
	<%} else {%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; WorkFlow -&gt;
		History</td>
	</tr>
	<%}%>
</table>
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr>
		<td valign="bottom">
		<table border="0" cellspacing="1" cellpadding="3" class="outertable" width="80%">
			<tr align="center">
				<td class="sub_tab_active">History</td>
				<!-- <td class="sub_tab_inactive"><a href="javascript:callOtherTab('comments')">Comments</a></td> -->
				<td class="sub_tab_inactive"><a  href="#" onClick="javascript:callQueries()">Queries</a></td>
				<%if (loan_type.equalsIgnoreCase("C")
							|| loan_type.equalsIgnoreCase("T")
							|| loan_type.equalsIgnoreCase("H")
							|| loan_type.equalsIgnoreCase("U")
							|| loan_type.equalsIgnoreCase("E")
							|| loan_type.equalsIgnoreCase("A")) { %>
				<td class="sub_tab_inactive" nowrap><a href="javascript:callOtherTab('sanction')" > Proposed facility Approve/Reject</a></td>
				<%}%>
				<% if (strSessionModuleType.equalsIgnoreCase("DIGI") && !(prd_type.equalsIgnoreCase("pB")|| prd_type.equalsIgnoreCase("pM"))) { %>
					<td class="sub_tab_inactive"><a href="javascript:callOtherTab('actiondigi')">Action</a></td>
				<%} else{%>
					<td class="sub_tab_inactive"><a href="javascript:callOtherTab('action')">Action</a></td>
				<%} %>
				
				<%
				if((strAppstatus.equalsIgnoreCase("pa")) || (strAppstatus.equalsIgnoreCase("ca")) || (strAppstatus.equalsIgnoreCase("op")))
				{
				if (PRD_CGTMSE.equalsIgnoreCase("Y")){ %>
				<td class="sub_tab_inactive" id="idCGTMSEtxn"><a href="javascript:callOtherTab('CGTMSE_TXN')">CGTMSE Transaction Details</a></td>
				<%} else { %>
					<td id="idCGTMSEtxn" style="display: none;"><input type="hidden"></td>
				<% } }  %>
				<td class="sub_tab_inactive"><a href="javascript:callOtherTab('drawdownschedule')">Draw Down Schedule</a></td>
				<td class="sub_tab_inactive"><a href="javascript:callOtherTab('remarks')">Remarks</a></td>
				<%if (legalcomp.equalsIgnoreCase("Y")){ %>
				<td class="sub_tab_inactive" nowrap><a href="javascript:callOtherTab('legcomp')">Legal Compliance Certificate</a></td>
				<%} %>
				<td class="sub_tab_inactive" id="idloanaccount"  nowrap="nowrap"><a href="#" onClick="javascript:callLoanAccount()">Loan Account Details</a></td>
				<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("S")){ %>
				<td id="idrestr" class="sub_tab_inactive" nowrap="nowrap"><a
					href="#" onclick="javascript:callOtherTab('restrfacdetails')">Restructure Effective Date</a></td>
				<%}else{ %>
				<td  style="display: none;"><input type="hidden" id="idrestr"></td>
				<%} 
				if(loan_type.equalsIgnoreCase("C") || loan_type.equalsIgnoreCase("A")) {%>
				<td class="sub_tab_inactive" id="idfacdetail"  nowrap="nowrap"><a href="#" onClick="javascript:callFacDetail()">Facility Details</a></td> 
				<% } %>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1">
					<tr>
						<td valign="top">History
						<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
							<tr>
								<td width="47%" valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
											<tr class="dataheader">
												<td width="15%" align="center">From Flowpoint</td>
												<td width="19%" align="center">Sent By</td>
												<td width="16%" align="center">Sent On</td>
												<td width="15%" align="center">To Flowpoint</td>
												<td width="20%" align="center">Sent To</td>
												<td width="15%" align="center">Mail Type</td>
											</tr>									
													<%if(arrFromUsr!=null && arrFromUsr.size()>0){
													
													for (int i = 0; i < arrFromUsr.size(); i++) {%>
													<tr class="datagrid">
														<td width="15%" align="center"><%=Helper.correctNull((String) arrFromflow.get(i))%>
														</td>
														<td width="19%">&nbsp;&nbsp;<%=Helper.correctNull((String) arrFromUsr.get(i))%></td>
														<td width="16%" align="center"><%=Helper.correctNull((String) arrDate.get(i))%>
														</td>
														<td width="15%" align="center"><%=Helper.correctNull((String) arrToflow.get(i))%>
														</td>
														<td width="20%">&nbsp;&nbsp;<%=Helper.correctNull((String) arrToUsr.get(i))%>
														</td>
														<td width="15%" align="center"><%=Helper.correctNull((String) arrMailtype.get(i))%>
														&nbsp;</td>
													</tr>
													<%}}%>
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
						<table width="0%" border="0" cellspacing="0" cellpadding="3"
							align="center" class="outertable">
							<%
								if (loan_type.equalsIgnoreCase("P")){
									if(prd_type.equalsIgnoreCase("pG")||prd_type.equalsIgnoreCase("pR")){
									  %>
							<tr>
								<td><input type="button" name="cmdprocessprint"
									value="Letter of Sanction to Borrower"
									onClick="ShowReport4('sanctionletter_GL.jsp')" class="buttonOthers"<%if(strMigrationFlag.equalsIgnoreCase("Y")){ %>disabled="disabled"<%} %>>
								</td>
							</tr>
									 <%
									}
									else{
									%>
							<tr>
								<td><input type="button" name="cmdprocessprint"
									value="Letter of Sanction to Borrower"
									onClick="ShowReport4('sanctionletter.jsp')" class="buttonOthers"<%if(strMigrationFlag.equalsIgnoreCase("Y")){ %>disabled="disabled"<%} %>>
								</td>
								<td><input type="button" name="cmdprocessprint1"
									value="Letter of Sanction to Branch"
									onClick="ShowReport4('sanctionlettertobranch.jsp')" class="buttonOthers"<%if(strMigrationFlag.equalsIgnoreCase("Y")){ %>disabled="disabled"<%} %>>
								</td>
							</tr>
							 <%}%>

							<%} %>
						</table>
						<%
							if ((strSessionModuleType.equalsIgnoreCase("CORP")||strSessionModuleType.equalsIgnoreCase("AGR")) && ((strAppstatus.equalsIgnoreCase("pa")) || (strAppstatus.equalsIgnoreCase("ca")))) {
						%>
							<table width="0%" border="0" cellspacing="0" cellpadding="2" align="center" class="outertable">
							<tr>
								<td align="center">
  									<input type="button" name="btn_MDSanction" value="MD Sanction to EC"
  									onclick="callMDSanction();" class="buttonOthers" style="width: 120px" <%if(strMigrationFlag.equalsIgnoreCase("Y")){ %>disabled="disabled"<%} %>>
  								</td>
  								<%if(strPSTerms.equalsIgnoreCase("Y")){ %>
  								<td><input type="button" name="cmdpostprocessprint"
									value="Permission Letter for Short Review" class="buttonOthers" 
									onClick="doCreditsanction();"></td>
  								<%}{ %>
								<td><input type="button" name="cmdprocessprint"
									value="Sanction Letter to Branch" class="buttonOthers" 
									onClick="doCorpSancletter('br');" <%if(strMigrationFlag.equalsIgnoreCase("Y")){ %>disabled="disabled"<%} %>></td>
								<td><input type="button" name="cmdprocessprint1"
									value="Sanction Letter to Borrower" class="buttonOthers"
									onClick="doCorpSancletter('bo');" <%if(strMigrationFlag.equalsIgnoreCase("Y")){ %>disabled="disabled"<%} %>></td>
									<%} %>
							</tr>
						</table>
						<%} %>
						
						<table width="0%" border="0" cellspacing="0" cellpadding="2" align="center" class="outertable">
							<tr>
							<%if((Helper.correctNull((String)hshValues.get("strMCLRFlag")).equalsIgnoreCase("Y"))&&(strAppstatus.equalsIgnoreCase("pa")||strAppstatus.equalsIgnoreCase("ca")))
							{%>
								<td><input type="button" name="cmdprocessprint2"
									value="Permission Letter for MCLR" class="buttonOthers" 
									onClick="doPermissionletter();"></td>
							<%}
							if((Helper.correctNull((String)hshValues.get("strEBLRFlag")).equalsIgnoreCase("Y"))&&(strAppstatus.equalsIgnoreCase("pa")||strAppstatus.equalsIgnoreCase("ca")))
							{%>
							<td><input type="button" name="cmdprocessprint2"
								value="Permission Letter for EBLR" class="buttonOthers" 
								onClick="doPermissionletter1();"></td>
						<%} %>
						</table>
						<table width="0%" border="0" cellspacing="0" cellpadding="0"
							class="outertable" align="center">
							<tr>
								<td>
								<table width="0%" border="0" cellspacing="0" cellpadding="2" class="outertable">
									<tr valign="top">
										<td height="2" align="center">
										<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
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
<lapschoice:hiddentag pageid='<%=PageId%>'/>
 <input	type="button" name="cmdsave" disabled="disabled" style="visibility: hidden"> 
 <input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String) request.getParameter("hidDemoId"))%>">
<INPUT TYPE="hidden" name="hidAppNo" VALUE=<%=Helper.correctNull((String) request.getParameter("appno"))%>>
<INPUT TYPE="hidden" name="radLoan" value="Y"> 
<input type="hidden" name="cattype" value="<%=strCategoryType%>"></form>
</body>
</html>
