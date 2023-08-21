<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	String strAppno = "", strFacCategory = "";
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	String appstatus = "",strAppstatus="",applevel="";
	
	if (hshValues.get("hshAppData") != null) 
	{
		HashMap hshRecord = (HashMap) hshValues.get("hshAppData");
		strAppno = Helper.correctNull((String) hshRecord.get("appno"));
		appstatus = Helper.correctNull((String) hshRecord.get("app_status"));
		strAppstatus = Helper.correctNull((String) hshRecord.get("app_status"));
		applevel = Helper.correctNull((String) hshRecord.get("applevel"));
	}
	
	if (appstatus.equalsIgnoreCase("")) 
	{
		appstatus = Helper.correctNull((String) request.getParameter("appstatus"));
	}
	if (strAppstatus.equalsIgnoreCase("op")
			|| strAppno.equalsIgnoreCase("new")) {
		appstatus = "Open/Pending";
	} else if (strAppstatus.equalsIgnoreCase("pa")) {
		appstatus = "Processed/Approved";
	} else if (strAppstatus.equalsIgnoreCase("pr")) {
		appstatus = "Processed/Rejected";
	} else if (strAppstatus.equalsIgnoreCase("ca")) {
		appstatus = "Closed/Approved";
	} else if (strAppstatus.equalsIgnoreCase("cr")) {
		appstatus = "Closed/Rejected";
	}
%>
<%
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=new ArrayList();
	ArrayList arrRowyr=new ArrayList();
	ArrayList arrColyr=new ArrayList();
	ArrayList arrColyr1 = new ArrayList();
	ArrayList arrColyr2 = new ArrayList();
	ArrayList arrColyr3 = new ArrayList();
	ArrayList arrColyr4 = new ArrayList();
	ArrayList arrColyr5 = new ArrayList();
	ArrayList arrColyr6 = new ArrayList();
	ArrayList arrColyr7 = new ArrayList();
	ArrayList arrColyr8 = new ArrayList();
	ArrayList arrColyr9 = new ArrayList();
	ArrayList arrColyr10 = new ArrayList();
	ArrayList arrColyr11 = new ArrayList();
	ArrayList arrColyr12 = new ArrayList();
	ArrayList arrColyr13 = new ArrayList();
	if(hshValues!=null)
	{
		arrRow = (ArrayList)hshValues.get("arrRow");
		arrRowyr = (ArrayList)hshValues.get("arrRowyr");
		String finYear  = Helper.correctNull((String)hshValues.get("COM_CF_FINYEAR"));
	}
	String COM_ASSESSMENTTYPE=Helper.correctNull((String)session.getAttribute("COM_ASSESSMENTTYPE"));
	
	ArrayList arrCol1 = new ArrayList();
	ArrayList arrCol2 = new ArrayList();
	ArrayList arrCol3 = new ArrayList();
	ArrayList arrCol4 = new ArrayList();
	ArrayList arrCol5 = new ArrayList();
	
%>
<%
	if (arrRow != null && arrRow.size() > 0) 
	{
		arrCol = (ArrayList) arrRow.get(0);
		arrCol1 = (ArrayList) arrRow.get(1);
		arrCol2 = (ArrayList) arrRow.get(2);
		arrCol3 = (ArrayList) arrRow.get(3);
		arrCol4 = (ArrayList) arrRow.get(4);
		arrCol5 = (ArrayList) arrRow.get(5);
	}

//out.println(arrRowyr);
%> 
<html>
<head>
<title>Cash Flow</title>

<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varOrgLevel="<%=strOrgLevel%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var appno="<%=request.getParameter("appno")%>";
var yearCount="<%=Helper.correctNull((String) hshValues.get("yr_count"))%>";
var unit_no="<%=Helper.correctNull((String) hshValues.get("unit_no1"))%>";

function doCancel()
{
	if (ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="comproposal";		
		document.forms[0].hidBeanGetMethod.value="getCashFlow";
		document.forms[0].action=appURL+"action/com_cashflow.jsp";
		document.forms[0].submit();
	}
}

function doEdit()
{	
	disablefields(false);
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value ="update"
	enableButtons(true,false,false,false,false,false);

	for(var i=0;i<document.forms[0].txt_year.length;i++)
	{
		document.forms[0].txt_costofLand[0].readOnly=true;
		document.forms[0].txt_premiumFSI[0].readOnly=true;
		document.forms[0].txt_constrCost[0].readOnly=true;
		document.forms[0].txt_marketExpn[0].readOnly=true;
		document.forms[0].txt_adminExpn[0].readOnly=true;
		document.forms[0].txt_interest[0].readOnly=true;
		document.forms[0].txt_repayment[0].readOnly=true;
		document.forms[0].txt_provisionofTax[0].readOnly=true;

		document.forms[0].txt_promoterEquity[0].readOnly=true;
		document.forms[0].txt_bankFinance[0].readOnly=true;
		document.forms[0].txt_saleProceeds[0].readOnly=true;
		document.forms[0].txt_others[0].readOnly=true;
		
		document.forms[0].txt_sourceoffinTot[i].readOnly=true;
		document.forms[0].txt_apploffinTot[i].readOnly=true;
		document.forms[0].txt_closingBal[i].readOnly=true;
		if(i > 1)
		{
			document.forms[0].txt_openingBal[i].readOnly=true;
		}
		if(yearCount>1)
		{
			document.forms[0].txt_costofLand[1].readOnly=true;
			document.forms[0].txt_premiumFSI[1].readOnly=true;
			document.forms[0].txt_constrCost[1].readOnly=true;
			document.forms[0].txt_marketExpn[1].readOnly=true;
			document.forms[0].txt_adminExpn[1].readOnly=true;
			document.forms[0].txt_interest[1].readOnly=true;
			document.forms[0].txt_repayment[1].readOnly=true;
			document.forms[0].txt_provisionofTax[1].readOnly=true;
			document.forms[0].txt_unsecLoan[1].readOnly=true;
			document.forms[0].txt_promoterEquity[1].readOnly=true;
			document.forms[0].txt_bankFinance[1].readOnly=true;
			document.forms[0].txt_saleProceeds[1].readOnly=true;
			document.forms[0].txt_others[1].readOnly=true;
			document.forms[0].txt_finothers[1].readOnly=true;
		}
		if(unit_no==1)
		{
			document.forms[0].txt_costofLand[1].readOnly=false;
			document.forms[0].txt_premiumFSI[1].readOnly=false;
			document.forms[0].txt_constrCost[1].readOnly=false;
			document.forms[0].txt_marketExpn[1].readOnly=false;
			document.forms[0].txt_adminExpn[1].readOnly=false;
			document.forms[0].txt_interest[1].readOnly=false;
			document.forms[0].txt_repayment[1].readOnly=false;
			document.forms[0].txt_provisionofTax[1].readOnly=false;
			document.forms[0].txt_unsecLoan[1].readOnly=false;
			document.forms[0].txt_promoterEquity[1].readOnly=false;
			document.forms[0].txt_bankFinance[1].readOnly=false;
			document.forms[0].txt_saleProceeds[1].readOnly=false;
			document.forms[0].txt_others[1].readOnly=false;
			document.forms[0].txt_finothers[1].readOnly=false;
		}
	}
	
}

function doSave()
{
	if(document.forms[0].sel_finYear.value=="")
	{
		alert("Select Financial Year");
		document.forms[0].sel_finYear.focus();
		return;
	}
	 for(var i=0;i<document.forms[0].txt_year.length;i++)
	{
		if(document.forms[0].sel_finYear.value=="new")
		{
			if(document.forms[0].txt_finYear.value=="")
			{
				alert("Enter Financial Year");
				document.forms[0].txt_finYear.focus();
				return;
			}
		}
	}
	
	/*	if(document.forms[0].txt_year[2].value=="")
		{
			alert("Enter Financial Year (Months)");
			document.forms[0].txt_year[2].focus();
			return;
		}
		if(document.forms[0].txt_year[i].value!="")
		{
			if(document.forms[0].txt_promoterEquity[i].value=="" || document.forms[0].txt_promoterEquity[i].value=="0.00")
			{
				alert("Enter Promoter Equity values for Financial Year entered");
				document.forms[0].txt_promoterEquity[i].focus();
				return;
			}
			if(document.forms[0].txt_costofLand[i].value=="" || document.forms[0].txt_costofLand[i].value=="0.00")
			{
				alert("Enter Cost of Land value for Financial Year entered");
				document.forms[0].txt_costofLand[i].focus();
				return;
			}
		}
		if(document.forms[0].txt_sourceoffinTot[0].value=="0.00")
		{
			alert("Enter Expenses upto date value of Promoters Equity");
			document.forms[0].txt_promoterEquity[1].focus();
			return;
		}
		if(document.forms[0].txt_apploffinTot[0].value=="0.00")
		{
			alert("Enter Expenses upto date value of Cost of Land");
			document.forms[0].txt_costofLand[1].focus();
			return;
		}
		
	}*/
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidAction.value="update";
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateCashFlow";
	document.forms[0].hidBeanGetMethod.value="getCashFlow";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_cashflow.jsp";
	document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	 {
		if (document.forms[0].sel_finYear.value =="")
		 {
			 alert("Select financial year you want to delete");
			 document.forms[0].sel_finYear.focus();
			 return;
		 }
		document.forms[0].hidAction.value="delete";
		document.forms[0].sel_finYear1.value=document.forms[0].sel_finYear.value;
	 	document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanMethod.value="updateCashFlow";
		document.forms[0].hidBeanGetMethod.value="getCashFlow";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_cashflow.jsp";
		document.forms[0].submit();
	 }	
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/corppge.jsp";
		document.forms[0].submit();
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
function placevalues()
{
	disablefields(true);
	if(appstatus=="Open/Pending")
	{
		document.forms[0].sel_finYear.disabled=false;
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
		enableButtons(false,true,true,false,true,false);
		}
		else
		{
			enableButtons(true,true,true,false,true,false);
		}
		
		}
	
	else
	{
		enableButtons(true,true,true,false,true,false);
	}

	var val="<%=Helper.correctNull((String)hshValues.get("COM_CF_FINYEAR"))%>";
	if(val == "")
	{
		//disableFields(true);
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
		enableButtons(false,true,true,true,false,false);
		}
		else
		{
			enableButtons(true,true,true,false,true,false);
		}			
	}
	else
	{
		document.forms[0].sel_finYear.value= val;	
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
		enableButtons(false,true,true,false,false,false);
		}
		else
		{
			enableButtons(true,true,true,false,true,false);
		}
		//disableFields(true);
	}
	document.forms[0].sel_finYear.value= val;	
}

function callCalender(fname)
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
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
function calculation()
{
	var k=0;
	var opBal=0;
	for(var i=0;i<document.forms[0].txt_year.length;i++)
	{
		if(document.forms[0].sel_finYear.value=="new" && yearCount>0)
		{
			//document.forms[0].txt_openingBal[2].value=document.forms[0].hid_closingBal.value;
		}
		else
		{
			document.forms[0].txt_openingBal[2].value=document.forms[0].txt_closingBal[1].value;
		}
		k=i; --k;
		
		if(i > 1 && document.forms[0].txt_year[3].value!="")
		{
		//	opBal=NanNumber(parseFloat(document.forms[0].txt_closingBal[k].value));
		//	document.forms[0].txt_openingBal[i].value=roundVal(opBal);

			document.forms[0].txt_openingBal[3].value=roundVal(NanNumber(parseFloat(document.forms[0].txt_closingBal[2].value)));
		}
		if(i > 1 && document.forms[0].txt_year[4].value!="")
		{
			opBal=NanNumber(parseFloat(document.forms[0].txt_closingBal[k].value));
			document.forms[0].txt_openingBal[4].value=roundVal(NanNumber(parseFloat(document.forms[0].txt_closingBal[3].value)));
		}
		if(i > 1 && document.forms[0].txt_year[5].value!="")
		{
			opBal=NanNumber(parseFloat(document.forms[0].txt_closingBal[k].value));
			document.forms[0].txt_openingBal[5].value=roundVal(NanNumber(parseFloat(document.forms[0].txt_closingBal[4].value)));
		}
		
		var openingbal = NanNumber(parseFloat(document.forms[0].txt_openingBal[1].value)+parseFloat(document.forms[0].txt_openingBal[2].value)+
				 parseFloat(document.forms[0].txt_openingBal[3].value)+parseFloat(document.forms[0].txt_openingBal[4].value)+
				 parseFloat(document.forms[0].txt_openingBal[5].value));

		//document.forms[0].txt_openingBal[0].value = roundVal(openingbal);

		var promoterEquity = NanNumber(parseFloat(document.forms[0].txt_promoterEquity[1].value)+parseFloat(document.forms[0].txt_promoterEquity[2].value)+
							 parseFloat(document.forms[0].txt_promoterEquity[3].value)+parseFloat(document.forms[0].txt_promoterEquity[4].value)+
							 parseFloat(document.forms[0].txt_promoterEquity[5].value));

		document.forms[0].txt_promoterEquity[0].value = roundVal(promoterEquity);

		var bankFinance = NanNumber(parseFloat(document.forms[0].txt_bankFinance[1].value)+parseFloat(document.forms[0].txt_bankFinance[2].value)+
							 parseFloat(document.forms[0].txt_bankFinance[3].value)+parseFloat(document.forms[0].txt_bankFinance[4].value)+
							 parseFloat(document.forms[0].txt_bankFinance[5].value));

		document.forms[0].txt_bankFinance[0].value = roundVal(bankFinance);

		

		var saleProceeds = NanNumber(parseFloat(document.forms[0].txt_saleProceeds[1].value)+parseFloat(document.forms[0].txt_saleProceeds[2].value)+
							 parseFloat(document.forms[0].txt_saleProceeds[3].value)+parseFloat(document.forms[0].txt_saleProceeds[4].value)+
							 parseFloat(document.forms[0].txt_saleProceeds[5].value));

		document.forms[0].txt_saleProceeds[0].value = roundVal(saleProceeds);

		var others = NanNumber(parseFloat(document.forms[0].txt_others[1].value)+parseFloat(document.forms[0].txt_others[2].value)+
				 parseFloat(document.forms[0].txt_others[3].value)+parseFloat(document.forms[0].txt_others[4].value)+
				 parseFloat(document.forms[0].txt_others[5].value));

		document.forms[0].txt_others[0].value = roundVal(others);

		var sourceoffinTot = NanNumber(parseFloat(document.forms[0].txt_promoterEquity[i].value)+parseFloat(document.forms[0].txt_bankFinance[i].value)+
							 parseFloat(document.forms[0].txt_saleProceeds[i].value)+parseFloat(document.forms[0].txt_unsecLoan[i].value)+
							 parseFloat(document.forms[0].txt_others[i].value)+parseFloat(document.forms[0].txt_openingBal[i].value));
			
		document.forms[0].txt_sourceoffinTot[i].value = roundVal(sourceoffinTot);



		var costofLand = NanNumber(parseFloat(document.forms[0].txt_costofLand[1].value)+parseFloat(document.forms[0].txt_costofLand[2].value)+
				 				parseFloat(document.forms[0].txt_costofLand[3].value)+parseFloat(document.forms[0].txt_costofLand[4].value)+
						 		parseFloat(document.forms[0].txt_costofLand[5].value));	

		document.forms[0].txt_costofLand[0].value = roundVal(costofLand);

		var premiumFSI = NanNumber(parseFloat(document.forms[0].txt_premiumFSI[1].value)+parseFloat(document.forms[0].txt_premiumFSI[2].value)+
		 						parseFloat(document.forms[0].txt_premiumFSI[3].value)+parseFloat(document.forms[0].txt_premiumFSI[4].value)+
			  					parseFloat(document.forms[0].txt_premiumFSI[5].value));

		document.forms[0].txt_premiumFSI[0].value = roundVal(premiumFSI);

		var constrCost = NanNumber(parseFloat(document.forms[0].txt_constrCost[1].value)+parseFloat(document.forms[0].txt_constrCost[2].value)+
		 						parseFloat(document.forms[0].txt_constrCost[3].value)+parseFloat(document.forms[0].txt_constrCost[4].value)+
		 						parseFloat(document.forms[0].txt_constrCost[5].value));

		document.forms[0].txt_constrCost[0].value = roundVal(constrCost);

		var marketExpn = NanNumber(parseFloat(document.forms[0].txt_marketExpn[1].value)+parseFloat(document.forms[0].txt_marketExpn[2].value)+
		 						parseFloat(document.forms[0].txt_marketExpn[3].value)+parseFloat(document.forms[0].txt_marketExpn[4].value)+
		 						parseFloat(document.forms[0].txt_marketExpn[5].value));

		document.forms[0].txt_marketExpn[0].value = roundVal(marketExpn);

		var adminExpn = NanNumber(parseFloat(document.forms[0].txt_adminExpn[1].value)+parseFloat(document.forms[0].txt_adminExpn[2].value)+
		 						parseFloat(document.forms[0].txt_adminExpn[3].value)+parseFloat(document.forms[0].txt_adminExpn[4].value)+
		 						parseFloat(document.forms[0].txt_adminExpn[5].value));

		document.forms[0].txt_adminExpn[0].value = roundVal(adminExpn);

		var interest = NanNumber(parseFloat(document.forms[0].txt_interest[1].value)+parseFloat(document.forms[0].txt_interest[2].value)+
		 						parseFloat(document.forms[0].txt_interest[3].value)+parseFloat(document.forms[0].txt_interest[4].value)+
		 						parseFloat(document.forms[0].txt_interest[5].value));

		document.forms[0].txt_interest[0].value = roundVal(interest);

		var repayment = NanNumber(parseFloat(document.forms[0].txt_repayment[1].value)+parseFloat(document.forms[0].txt_repayment[2].value)+
		 						parseFloat(document.forms[0].txt_repayment[3].value)+parseFloat(document.forms[0].txt_repayment[4].value)+
		 						parseFloat(document.forms[0].txt_repayment[5].value));

		document.forms[0].txt_repayment[0].value = roundVal(repayment);

		var provisionofTax = NanNumber(parseFloat(document.forms[0].txt_provisionofTax[1].value)+parseFloat(document.forms[0].txt_provisionofTax[2].value)+
			 					parseFloat(document.forms[0].txt_provisionofTax[3].value)+parseFloat(document.forms[0].txt_provisionofTax[4].value)+
		 						parseFloat(document.forms[0].txt_provisionofTax[5].value));

		document.forms[0].txt_provisionofTax[0].value = roundVal(provisionofTax);

		var finothers = NanNumber(parseFloat(document.forms[0].txt_finothers[1].value)+parseFloat(document.forms[0].txt_finothers[2].value)+
					parseFloat(document.forms[0].txt_finothers[3].value)+parseFloat(document.forms[0].txt_finothers[4].value)+
					parseFloat(document.forms[0].txt_finothers[5].value));

		document.forms[0].txt_finothers[0].value = roundVal(finothers);

		var apploffinTot = NanNumber(parseFloat(document.forms[0].txt_costofLand[i].value)+parseFloat(document.forms[0].txt_premiumFSI[i].value)+
				 				parseFloat(document.forms[0].txt_constrCost[i].value)+parseFloat(document.forms[0].txt_marketExpn[i].value)+
				 				parseFloat(document.forms[0].txt_adminExpn[i].value)+parseFloat(document.forms[0].txt_interest[i].value)+
				 				parseFloat(document.forms[0].txt_repayment[i].value)+parseFloat(document.forms[0].txt_provisionofTax[i].value)+
				 				parseFloat(document.forms[0].txt_finothers[i].value));

		document.forms[0].txt_apploffinTot[i].value = roundVal(apploffinTot);

		var closingBal = NanNumber(parseFloat(document.forms[0].txt_sourceoffinTot[i].value)-parseFloat(document.forms[0].txt_apploffinTot[i].value));

		document.forms[0].txt_closingBal[i].value = roundVal(closingBal);

		var unsecLoan = NanNumber(parseFloat(document.forms[0].txt_unsecLoan[1].value)+parseFloat(document.forms[0].txt_unsecLoan[2].value)+
				 parseFloat(document.forms[0].txt_unsecLoan[3].value)+parseFloat(document.forms[0].txt_unsecLoan[4].value)+
				 parseFloat(document.forms[0].txt_unsecLoan[5].value));

		document.forms[0].txt_unsecLoan[0].value = roundVal(unsecLoan);

	}
/*	for(var i=document.forms[0].txt_year.length;i>1;i--)
	{
		if(document.forms[0].txt_year[i-1].value!="")
		{
			document.forms[0].hid_closingBal.value=document.forms[0].txt_closingBal[i-1].value;
			i=1;
		}
	}
*/	
	
	

}

function displayData()
{	
	if(document.forms[0].sel_finYear.value=="new")
	{
		disablefields(false);

		for(var i=0;i<document.forms[0].txt_year.length;i++)
		{
			document.forms[0].txt_costofLand[0].readOnly=true;
			document.forms[0].txt_premiumFSI[0].readOnly=true;
			document.forms[0].txt_constrCost[0].readOnly=true;
			document.forms[0].txt_marketExpn[0].readOnly=true;
			document.forms[0].txt_adminExpn[0].readOnly=true;
			document.forms[0].txt_interest[0].readOnly=true;
			document.forms[0].txt_repayment[0].readOnly=true;
			document.forms[0].txt_provisionofTax[0].readOnly=true;
			document.forms[0].txt_unsecLoan[0].readOnly=true;
			document.forms[0].txt_promoterEquity[0].readOnly=true;
			document.forms[0].txt_bankFinance[0].readOnly=true;
			document.forms[0].txt_saleProceeds[0].readOnly=true;
			document.forms[0].txt_others[0].readOnly=true;
			
			document.forms[0].txt_sourceoffinTot[i].readOnly=true;
			document.forms[0].txt_apploffinTot[i].readOnly=true;
			document.forms[0].txt_closingBal[i].readOnly=true;
			document.forms[0].txt_openingBal[i].readOnly=true;

			if(yearCount>0)
			{
				document.forms[0].txt_costofLand[1].readOnly=true;
				document.forms[0].txt_premiumFSI[1].readOnly=true;
				document.forms[0].txt_constrCost[1].readOnly=true;
				document.forms[0].txt_marketExpn[1].readOnly=true;
				document.forms[0].txt_adminExpn[1].readOnly=true;
				document.forms[0].txt_interest[1].readOnly=true;
				document.forms[0].txt_repayment[1].readOnly=true;
				document.forms[0].txt_provisionofTax[1].readOnly=true;
				document.forms[0].txt_unsecLoan[1].readOnly=true;
				document.forms[0].txt_promoterEquity[1].readOnly=true;
				document.forms[0].txt_bankFinance[1].readOnly=true;
				document.forms[0].txt_saleProceeds[1].readOnly=true;
				document.forms[0].txt_others[1].readOnly=true;
				document.forms[0].txt_finothers[1].readOnly=true;
			}
		}
		document.all.txt_finYear.style.visibility="visible";
		document.all.txt_finYear.style.position="relative";
		makeNull();
		document.forms[0].txt_openingBal[2].value=document.forms[0].hid_closingBal.value;
	}
	
	else
	{
		document.all.txt_finYear.style.visibility="hidden";
		document.all.txt_finYear.style.position="absolute";
		
		document.forms[0].sel_finYear1.value=document.forms[0].sel_finYear.value;
		document.forms[0].hidBeanId.value="comproposal";		
		document.forms[0].hidBeanGetMethod.value="getCashFlow";
		document.forms[0].action="action/com_cashflow.jsp";
		document.forms[0].submit();
	}
	enableButtons(true,false,false,false,false,false);
}
function makeNull()
{
	for(var i=0;i<document.forms[0].txt_year.length;i++)
		{
			document.forms[0].txt_year[2].value="";
			document.forms[0].txt_year[3].value="";
			document.forms[0].txt_year[4].value="";
			document.forms[0].txt_year[5].value="";
			document.forms[0].txt_openingBal[0].value="0.00";
			document.forms[0].txt_openingBal[1].value="0.00";
			document.forms[0].txt_openingBal[3].value="0.00";
			document.forms[0].txt_openingBal[4].value="0.00";
			document.forms[0].txt_openingBal[5].value="0.00";
			document.forms[0].txt_promoterEquity[i].value="0.00";
			document.forms[0].txt_bankFinance[i].value="0.00";
			document.forms[0].txt_unsecLoan[i].value="0.00";
			document.forms[0].txt_saleProceeds[i].value="0.00";
			document.forms[0].txt_sourceoffinTot[i].value="0.00";
			document.forms[0].txt_costofLand[i].value="0.00";
			document.forms[0].txt_premiumFSI[i].value="0.00";
			document.forms[0].txt_constrCost[i].value="0.00";
			document.forms[0].txt_marketExpn[i].value="0.00";
			document.forms[0].txt_adminExpn[i].value="0.00";
			document.forms[0].txt_interest[i].value="0.00";
			document.forms[0].txt_repayment[i].value="0.00";
			document.forms[0].txt_provisionofTax[i].value="0.00";
			document.forms[0].txt_apploffinTot[i].value="0.00";
			document.forms[0].txt_closingBal[i].value="0.00";
			document.forms[0].txt_others[i].value="0.00";
			document.forms[0].txt_finothers[i].value="0.00";
		}
}
function doComments()
{
	var btnenable=document.forms[0].btnenable.value;
	var strAppno =appno;
	var pagetype = document.forms[0].hidCommentPage.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/com_comments.jsp?hidBeanId=comproposal&hidBeanGetMethod=getDataComments&pagetype="+pagetype+"&strAppno="+strAppno+"&appstatus="+appstatus+"&btnenable="+btnenable;
	window.open(url,"Comments",prop);
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placevalues();">

<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">
if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>

<form method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
  <tr> 
	<td valign="top" colSpan=5>
           	<jsp:include page="../com/proposallinks.jsp" flush="true"> 
			<jsp:param name="pageid" value="8" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />			
			</jsp:include>
   </td>
 </tr>
 <tr>
 	<td class="page_flow">
 		Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Assessment -&gt; Cash Flow
<span style="display:none"><lapschoice:borrowertype /></span> 
<lapschoice:application/>
	</td>
</tr>
</table>
  	<jsp:include page="../com/com_commentstab.jsp" flush="true">
		<jsp:param name="tabid" value="11" />
	</jsp:include>      
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td valign="top" colspan="3">
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
									<tr class="dataheader"><td align="right" colspan="7"><b>All Values are in <%=Helper.correctNull((String)hshValues.get("strValuesin")) %></b></td></tr>
									<tr class="dataheader"> 
				                        <td width="20%">Financial Year</td>
				                        <td width="80%" colspan="6">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				                          <select name="sel_finYear" onChange="displayData();">
				                            <option value =''>----Select----</option>
				                            <option value ='new'>New</option>
				                            <laps:yearSelectTag/>
				                          </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				                       <input type="text" name="txt_finYear" size="15" onKeyPress="allowAlpaNumeric(this)" maxlength="15" style="visibility: hidden;position: absolute;"></td>
				                    </tr>
									<tr class="dataheader">
										<td width="20%" rowspan="2" align="center">Particulars</td>
										<td width="12%" rowspan="2" align="center">Projected<input type="hidden" name="txt_year" size="8" value="Projected"></td>
										<td width="12%" rowspan="2" align="center">Expenses upto date<input type="hidden" name="txt_year" size="8" value="Expenses upto date"></td>
										<td width="56%" colspan="12" align="center">Financial Year</td>
									</tr>
									<tr class="dataheader">
										<%
											if (arrRowyr != null && arrRowyr.size() > 0) 
											{
												arrColyr2 = (ArrayList) arrRowyr.get(2);
										%>
										<td width="12%" align="center"><input type="text" name="txt_year" size="15" onKeyPress="" maxlength="15" value="<%=Helper.correctNull((String)arrColyr2.get(0))%>"></td>
										<%}else {%>
										<td width="12%" align="center"><input type="text" name="txt_year" size="15" onKeyPress="" maxlength="15" ></td>
										<%}%>
										
										<%
											if (arrRowyr != null && arrRowyr.size() > 0) 
											{
												arrColyr3 = (ArrayList) arrRowyr.get(3);
										%>
										<td width="12%" align="center"><input type="text" name="txt_year" size="15" onKeyPress="" maxlength="15" value="<%=Helper.correctNull((String)arrColyr3.get(0))%>"></td>
										<%}else {%>
										<td width="12%" align="center"><input type="text" name="txt_year" size="15" onKeyPress="" maxlength="15" ></td>
										<%}%>
										
										<%
											if (arrRowyr != null && arrRowyr.size() > 0) 
											{
												arrColyr4 = (ArrayList) arrRowyr.get(4);
										%>
										<td width="12%" align="center"><input type="text" name="txt_year" size="15" onKeyPress="" maxlength="15" value="<%=Helper.correctNull((String)arrColyr4.get(0))%>"></td>
										<%}else {%>
										<td width="12%" align="center"><input type="text" name="txt_year" size="15" onKeyPress="" maxlength="15" ></td>
										<%}%>
										
										<%
											if (arrRowyr != null && arrRowyr.size() > 0) 
											{
												arrColyr5 = (ArrayList) arrRowyr.get(5);
										%>
										<td width="12%" align="center"><input type="text" name="txt_year" size="15" onKeyPress="" maxlength="15" value="<%=Helper.correctNull((String)arrColyr5.get(0))%>"></td>
										<%}else {%>
										<td width="12%" align="center"><input type="text" name="txt_year" size="15" onKeyPress="" maxlength="15" ></td>
										<%}%>
										
								   </tr>		
										
									<tr class="datagrid">
										<td width="25%" colspan="15"><b>SOURCES OF FINANCE</b></td>
									</tr>
									
									<tr class="datagrid">
										<td width="30%">Opening Balance</td>
										<%if (arrRow != null && arrRow.size() > 0) {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totopeningBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("Tot_opnBal"))%>">
											<input type="hidden" name="txt_openingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(0)))%>">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_openingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(0)))%>"></td>
										<td width="5%" align="center"><input type="text" readonly="readonly" name="txt_openingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(0)))%>"></td>
										<td width="5%" align="center"><input type="text" readonly="readonly" name="txt_openingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(0)))%>"></td>
										<td width="5%" align="center"><input type="text" readonly="readonly" name="txt_openingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(0)))%>"></td>
										<td width="5%" align="center"><input type="text" readonly="readonly" name="txt_openingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol5.get(0)))%>"></td>
										<%}else {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totopeningBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
											<input type="hidden" name="txt_openingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_openingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" readonly="readonly" name="txt_openingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" readonly="readonly" name="txt_openingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" readonly="readonly" name="txt_openingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" readonly="readonly" name="txt_openingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
								   </tr>
								   
								   <tr class="datagrid">
										<td width="30%">Promoters Equity</td>
										<%if (arrRow != null && arrRow.size() > 0) {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totpromoterEquity" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("Tot_proEqt"))%>">
											<input type="hidden" name="txt_promoterEquity" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(1)))%>">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_promoterEquity" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(1)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_promoterEquity" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(1)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_promoterEquity" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(1)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_promoterEquity" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(1)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_promoterEquity" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol5.get(1)))%>"></td>
										<%}else {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totpromoterEquity" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
											<input type="hidden" name="txt_promoterEquity" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_promoterEquity" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_promoterEquity" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_promoterEquity" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_promoterEquity" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_promoterEquity" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
								   </tr>
								   
								   <tr class="datagrid">
										<td width="30%">Bank Finance</td>
										<%if (arrRow != null && arrRow.size() > 0) {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totbankFinance" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("Tot_bnkFin"))%>">
											<input type="hidden" name="txt_bankFinance" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(2)))%>">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_bankFinance" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(2)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_bankFinance" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(2)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_bankFinance" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(2)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_bankFinance" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(2)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_bankFinance" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol5.get(2)))%>"></td>
										<%}else {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totbankFinance" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
											<input type="hidden" name="txt_bankFinance" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_bankFinance" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_bankFinance" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_bankFinance" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_bankFinance" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_bankFinance" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
								   </tr>
								   
								   <tr class="datagrid">
										<td width="30%">Unsecured Loan</td>
										<%if (arrRow != null && arrRow.size() > 0) {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totunsecLoan" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("Tot_unsec"))%>">
											<input type="hidden" name="txt_unsecLoan" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(3)))%>">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_unsecLoan" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(3)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_unsecLoan" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(3)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_unsecLoan" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(3)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_unsecLoan" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(3)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_unsecLoan" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol5.get(3)))%>"></td>
										<%}else {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totunsecLoan" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">	
											<input type="hidden" name="txt_unsecLoan" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_unsecLoan" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_unsecLoan" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_unsecLoan" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_unsecLoan" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_unsecLoan" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
								   </tr>
								   
								   <tr class="datagrid">
										<td width="30%">Advance Received</td>
										<%if (arrRow != null && arrRow.size() > 0) {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totsaleProceeds" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("Tot_saleProc"))%>">
											<input type="hidden" name="txt_saleProceeds" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(4)))%>">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_saleProceeds" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(4)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_saleProceeds" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(4)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_saleProceeds" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(4)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_saleProceeds" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(4)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_saleProceeds" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol5.get(4)))%>"></td>
										<%}else {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totsaleProceeds" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
											<input type="hidden" name="txt_saleProceeds" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_saleProceeds" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_saleProceeds" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_saleProceeds" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_saleProceeds" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_saleProceeds" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
								   </tr>
								   <tr class="datagrid">
										<td width="30%">Sale proceeds net of Advance</td>
										<%if (arrRow != null && arrRow.size() > 0) {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totothers" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("Tot_other"))%>">
											<input type="hidden" name="txt_others" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(16)))%>">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_others" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(16)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_others" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(16)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_others" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(16)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_others" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(16)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_others" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol5.get(16)))%>"></td>
										<%}else {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totothers" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
											<input type="hidden" name="txt_others" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_others" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_others" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_others" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_others" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_others" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
								   </tr>
								   <tr class="datagrid">
										<td width="30%" align="right">TOTAL</td>
										<%if (arrRow != null && arrRow.size() > 0) {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totsourceoffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("Tot_sofTot"))%>">
											<input type="hidden" name="txt_sourceoffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(5)))%>">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_sourceoffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(5)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_sourceoffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(5)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_sourceoffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(5)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_sourceoffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(5)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_sourceoffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol5.get(5)))%>"></td>
										<%}else {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totsourceoffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">	
											<input type="hidden" name="txt_sourceoffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_sourceoffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_sourceoffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_sourceoffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_sourceoffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_sourceoffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
								   </tr>
								   
								   <tr class="datagrid">
										<td width="30%" colspan="15"><b>APPLICATION OF FINANCE</b></td>
								   </tr>
								   
								   <tr class="datagrid">
										<td width="30%">Cost of Land</td>
										<%if (arrRow != null && arrRow.size() > 0) {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totcostofLand" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("Tot_costLand"))%>">
											<input type="hidden" name="txt_costofLand" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(6)))%>">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_costofLand" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(6)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_costofLand" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(6)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_costofLand" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(6)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_costofLand" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(6)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_costofLand" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol5.get(6)))%>"></td>
										<%}else {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totcostofLand" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
											<input type="hidden" name="txt_costofLand" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_costofLand" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_costofLand" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_costofLand" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_costofLand" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_costofLand" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
								   </tr>
								   
								   <tr class="datagrid">
										<td width="30%">Premium FSI & Approval Cost</td>
										<%if (arrRow != null && arrRow.size() > 0) {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totpremiumFSI" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("Tot_premiumfsi"))%>">
											<input type="hidden" name="txt_premiumFSI" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(7)))%>">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_premiumFSI" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(7)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_premiumFSI" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(7)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_premiumFSI" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(7)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_premiumFSI" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(7)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_premiumFSI" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol5.get(7)))%>"></td>
										<%}else {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totpremiumFSI" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
											<input type="hidden" name="txt_premiumFSI" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_premiumFSI" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_premiumFSI" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_premiumFSI" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_premiumFSI" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_premiumFSI" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
								   </tr>
								   
								   <tr class="datagrid">
										<td width="30%">Construction Cost</td>
										<%if (arrRow != null && arrRow.size() > 0) {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totconstrCost" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("Tot_constcost"))%>">
											<input type="hidden" name="txt_constrCost" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(8)))%>">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_constrCost" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(8)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_constrCost" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(8)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_constrCost" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(8)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_constrCost" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(8)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_constrCost" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol5.get(8)))%>"></td>
										<%}else {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totconstrCost" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">	
											<input type="hidden" name="txt_constrCost" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_constrCost" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_constrCost" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_constrCost" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_constrCost" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_constrCost" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
								   </tr>
								   
								   <tr class="datagrid">
										<td width="30%">Marketing Expenses</td>
										<%if (arrRow != null && arrRow.size() > 0) {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totmarketExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("Tot_marketexp"))%>">
											<input type="hidden" name="txt_marketExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(9)))%>">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_marketExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(9)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_marketExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(9)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_marketExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(9)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_marketExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(9)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_marketExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol5.get(9)))%>"></td>
										<%}else {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totmarketExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">	
											<input type="hidden" name="txt_marketExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_marketExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_marketExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_marketExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_marketExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_marketExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
								   </tr>
								   
								   <tr class="datagrid">
										<td width="30%">Administrative Expenses</td>
										<%if (arrRow != null && arrRow.size() > 0) {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totadminExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("Tot_adminexp"))%>">
											<input type="hidden" name="txt_adminExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(10)))%>">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_adminExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(10)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_adminExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(10)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_adminExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(10)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_adminExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(10)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_adminExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol5.get(10)))%>"></td>
										<%}else {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totadminExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
											<input type="hidden" name="txt_adminExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_adminExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_adminExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_adminExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_adminExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_adminExpn" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
								   </tr>
								   
								   <tr class="datagrid">
										<td width="30%">Others</td>
										<%if (arrRow != null && arrRow.size() > 0) {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totfinothers" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("Tot_otherFin"))%>">
											<input type="hidden" name="txt_finothers" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(17)))%>">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_finothers" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(17)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_finothers" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(17)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_finothers" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(17)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_finothers" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(17)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_finothers" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol5.get(17)))%>"></td>
										<%}else {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totfinothers" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">	
											<input type="hidden" name="txt_finothers" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_finothers" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_finothers" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_finothers" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_finothers" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_finothers" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
								   </tr>
								   
								   <tr class="datagrid">
										<td width="30%">Interest</td>
										<%if (arrRow != null && arrRow.size() > 0) {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totinterest" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("Tot_interest"))%>">
											<input type="hidden" name="txt_interest" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(11)))%>">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_interest" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(11)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_interest" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(11)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_interest" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(11)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_interest" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(11)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_interest" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol5.get(11)))%>"></td>
										<%}else {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totinterest" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
											<input type="hidden" name="txt_interest" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_interest" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_interest" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_interest" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_interest" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_interest" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
								   </tr>
								   
								   <tr class="datagrid">
										<td width="30%">Repayment</td>
										<%if (arrRow != null && arrRow.size() > 0) {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totrepayment" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("Tot_repayment"))%>">
											<input type="hidden" name="txt_repayment" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(12)))%>">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_repayment" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(12)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_repayment" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(12)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_repayment" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(12)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_repayment" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(12)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_repayment" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol5.get(12)))%>"></td>
										<%}else {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totrepayment" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
											<input type="hidden" name="txt_repayment" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_repayment" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_repayment" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_repayment" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_repayment" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_repayment" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
								   </tr>
								   
								   <tr class="datagrid">
										<td width="30%">Provision of tax</td>
										<%if (arrRow != null && arrRow.size() > 0) {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totprovisionofTax" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("Tot_provTax"))%>">
											<input type="hidden" name="txt_provisionofTax" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(13)))%>">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_provisionofTax" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(13)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_provisionofTax" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(13)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_provisionofTax" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(13)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_provisionofTax" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(13)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_provisionofTax" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol5.get(13)))%>"></td>
										<%}else {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totprovisionofTax" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
											<input type="hidden" name="txt_provisionofTax" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_provisionofTax" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_provisionofTax" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_provisionofTax" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_provisionofTax" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_provisionofTax" size="15" onKeyPress="allowNumber(this)" style="text-align: right;"  maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
								   </tr>
								   
								   <tr class="datagrid">
										<td width="30%" align="right">TOTAL</td>
										<%if (arrRow != null && arrRow.size() > 0) {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totapploffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("Tot_appfinTot"))%>">	
											<input type="hidden" name="txt_apploffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(14)))%>">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_apploffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(14)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_apploffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(14)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_apploffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(14)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_apploffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(14)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_apploffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol5.get(14)))%>"></td>
										<%}else {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totapploffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">	
											<input type="hidden" name="txt_apploffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_apploffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_apploffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_apploffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_apploffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_apploffinTot" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
								   </tr>
								   <tr class="datagrid">
										<td width="30%" align="right">Closing Balance</td>
										<%if (arrRow != null && arrRow.size() > 0) {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totclosingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("Tot_closingBal"))%>">
											<input type="hidden" name="txt_closingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(15)))%>">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_closingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(15)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_closingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(15)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_closingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(15)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_closingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(15)))%>"></td>
										<td width="5%" align="center"><input type="text" name="txt_closingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol5.get(15)))%>"></td>
										<%}else {%>
										<td width="5%" align="center">
											<input type="text" name="txt_totclosingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">	
											<input type="hidden" name="txt_closingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
										</td>
										<td width="5%" align="center"><input type="text" name="txt_closingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_closingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_closingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_closingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="5%" align="center"><input type="text" name="txt_closingBal" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" class="derivedFld" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
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
</table>
	<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Comments_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	<lapschoice:hiddentag pageid='<%=PageId%>' /> 
	
	
	<input type="hidden" name="hidflag" value=""> 
	<input type="hidden" name="selsno" value=""> 
	<input type="hidden" name="hidval"> 
	<input type="hidden" name="hiddesc"> 
	<INPUT TYPE="hidden" NAME="hidPageSource" VALUE="CF"> 
	<input type="hidden" name="sel_finYear1"> 
	<input type="hidden" name="hidCommentPage" value="cashflow">
	<INPUT TYPE="hidden" name="strAssessment" value = "<%=COM_ASSESSMENTTYPE%>">
	<input type="hidden" name="hid_closingBal" value="<%=Helper.correctNull((String)hshValues.get("com_cf_closingbalance"))%>"> 
	<input type="hidden" name="hid_closingBalance" value="0.00"> 
</form>
</body>
</html>