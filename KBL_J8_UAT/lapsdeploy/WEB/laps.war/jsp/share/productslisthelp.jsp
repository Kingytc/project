<%@include file="../share/directives.jsp"%>
<%
	String strApptype = ""; //= Helper.correctNull(request.getParameter("apptype"));
	if (strApptype.equalsIgnoreCase("")) {
		strApptype = Helper.correctNull((String) hshValues.get("apptype"));
	}
	ArrayList v = (ArrayList) hshValues.get("arryRow");
 	ArrayList arryCol = new ArrayList();
	String strStaffFlag = Helper.correctNull((String) request.getParameter("hidStaffFlag"));
	String appage = Helper.correctNull((String) request.getParameter("perapp_age"));
	String strApplId = Helper.correctNull((String) request.getParameter("comappid"));
	String strprdtype = Helper.correctNull((String) hshValues.get("appprdtype"));
	
	String strAppgender = Helper.correctNull((String) hshValues.get("app_gender"));
	String strAppEmploymnt = Helper.correctNull((String) hshValues.get("app_employment"));
	
%>

<html>
<head>
<style type="text/css">
DIV.cellContainer 
{	
  width: 100%; height: 325;
  overflow: auto;
}
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL="<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var apptype="<%=strApptype%>";
var appprdtype="<%=strprdtype%>";
var goldloancount="<%=Helper.correctNull((String) hshValues.get("countgoldloan")) %>";
var maxgoldloan="<%=Helper.correctNull((String) hshValues.get("maxgoldloan")) %>";
var varStaffVechChk="<%=Helper.correctNull((String)hshValues.get("strStaffVechChk"))%>";
var varExistingHousingLoanChk="<%=Helper.correctNull((String)hshValues.get("strExistingHousingLoanChk"))%>";
var varExistingSuvidhaLoanChk="<%=Helper.correctNull((String)hshValues.get("strExistingSuvidhaLoanChk"))%>";
var varConstDesc="<%=Helper.correctNull((String) hshValues.get("strConstDesc"))%>";
var varstakeHolder="<%=Helper.correctNull((String) hshValues.get("perapp_stakeheld_women"))%>";
var varprdschemcode="<%=Helper.correctNull((String) hshValues.get("SCHEME_CODE"))%>";
var varresidentstatus="<%=Helper.correctNull((String) hshValues.get("INDINFO_RESIDENT_STATUS"))%>";


function getSelectedValue(val,val2)
{	
	var varproducthelp=val;
	var varValue=val;
	var varArr= varValue.split("$");
	var varpurposeid = varArr[11];
	
	if(varArr[2]=="pB" && window.opener.document.forms[0].hidstrApptype.value=="Fresh" && varArr[14]=="OD" )
	{
		alert("Creation of Fresh Business quick loan is restricted vide HO: CREDIT: CIRCULAR: GF: 7:79:2021-22 dated 30.12.2021.");
		return;
	}
	
	if(varArr[2]=="pS" && document.forms[0].hidCategoryType.value!="LAD")
	{
		if(varArr[22]=="P" && window.opener.document.forms[0].hidPhysicalFlag.value=="Y")
		{
			alert("Physical form of loan against share limit exceeds for this borrower");
			return;
		}
		else if(varArr[22]=="D" && window.opener.document.forms[0].hidDematFlag.value=="Y")
		{
			alert("Demat form of loan against share limit exceeds for this borrower");
			return;
		}
		window.opener.document.forms[0].hidSharetype.value=varArr[22];
	}

	if(varArr[2]=="pA" && varArr[10]=="TSCQV" && varStaffVechChk=="Y")
	{
		//alert("The Customer is already enjoying vehicle loan Under TSCQV scheme");
		//return;
	}
	if(varArr[2]=="pH" && varpurposeid=="T" && varExistingHousingLoanChk !="Y")
	{
		alert("Home Top up Loan will Eligible only for Existing Housing Loan Customers");
		return;
	}
	if(varArr[2]=="pV" && varExistingSuvidhaLoanChk =="Y")
	{
		alert("The Customer is not eligible for this Loan, he is already enjoying Loan under Suvidha OD scheme");
		return;
	}

	if(document.forms[0].hidCategoryType.value=="LAD" && varArr[2]=="pR" && varArr[10]=="ANDQ" && varresidentstatus=="N")
	{
		alert("Deposit loan product with Scheme Code- 'ANDQ' can  be selected only for NRI customers and not for general customers");
		return;
	}
	alert(val2);
	if(val2=="Y")
	{
		window.opener.document.forms[0].sel_wht_cgtmse.value="Y";
		window.opener.document.forms[0].sel_wht_cgtmse.disabled=true;
	}
	window.opener.document.forms[0].hidPrdReselectFlag.value="";
	window.opener.document.forms[0].hidpurpose.value=varArr[11];
	window.opener.document.forms[0].hidHoliday.value=varArr[12];
	window.opener.document.forms[0].hidProductID.value=varArr[0];
	window.opener.document.forms[0].prd_type.value=varArr[2];	
	window.opener.document.forms[0].minterm.value=varArr[9];	
	window.opener.document.forms[0].txt_schemecode.value=varArr[10];	
	window.opener.document.forms[0].hidprdbankscheme.value=varArr[20];
	window.opener.document.forms[0].hidODFlag.value=varArr[14];
	if(varArr[2].charAt(0)=="a")
	{
		window.opener.document.forms[0].hidApploanType.value="A";
	}
	else
	{
		window.opener.document.forms[0].hidApploanType.value="P";
	}
	
	if(varArr[8]!="" && document.forms[0].hidappage.value !="")
	{
		if(parseInt(document.forms[0].hidappage.value) <= parseInt(varArr[7]))
		{
			alert("The applicant is not eligible based on age");
			return;
		}
	}
				
	window.opener.document.forms[0].txtloan_modintrate.readOnly=true;
	window.opener.document.forms[0].txtprd_desc.value=varArr[3];
	window.opener.document.forms[0].hidPrincipalRatio.value=varArr[4];
	window.opener.document.forms[0].hidInterestRatio.value=varArr[5];
	window.opener.document.forms[0].hidStaffProduct.value=varArr[6];
	window.opener.document.forms[0].hidstaff_under.value=varArr[15];
	if(document.forms[0].hidStaffFlag.value=="Y" && document.forms[0].hidCategoryType.value=="RET" && 
		NanNumber(parseFloat(varArr[4]))>0 && NanNumber(parseFloat(varArr[5]))>0)
	{
		window.opener.document.all.interestEMI1.style.visibility="visible";
		window.opener.document.all.interestEMI2.style.visibility="visible";
		window.opener.document.all.interestEMI3.style.visibility="visible";
		window.opener.document.all.idcooperative.style.visibility="visible";
		window.opener.document.forms[0].co_operative.value="2";
		
		if(NanNumber(parseInt(document.forms[0].hidServiceLeft.value))>0  && NanNumber(parseInt(document.forms[0].hidServiceLeft.value))>=NanNumber(parseFloat(varArr[1])))
		{
			window.opener.document.forms[0].repayperiod.value=varArr[1];
			window.opener.document.forms[0].periods.value=varArr[1];
			if(varArr[2]=="pR" || varArr[2]=="pG")	
			{
				window.opener.document.forms[0].txtloan_reqterms.value=varArr[1];
			}
			//window.opener.document.forms[0].txtloan_reqterms.value=varArr[1];
		}
		else if(NanNumber(parseInt(document.forms[0].hidServiceLeft.value))==0)
		{
			window.opener.document.forms[0].repayperiod.value=varArr[1];
			window.opener.document.forms[0].periods.value=varArr[1];	
			if(varArr[2]=="pR" || varArr[2]=="pG")	
			{
				window.opener.document.forms[0].txtloan_reqterms.value=varArr[1];
			}
			//window.opener.document.forms[0].txtloan_reqterms.value=varArr[1];
		}
		else
		{
			if(parseInt(document.forms[0].hidServiceLeft.value)<0)
			{
				alert("The applicant is retired, so not eligible for this product");
				return;
			}
			else
			{
				window.opener.document.forms[0].repayperiod.value=document.forms[0].hidServiceLeft.value;
				window.opener.document.forms[0].periods.value=document.forms[0].hidServiceLeft.value;
				//window.opener.document.forms[0].txtloan_reqterms.value=document.forms[0].hidServiceLeft.value;
				if(varArr[2]=="pR" || varArr[2]=="pG")	
				{
					window.opener.document.forms[0].txtloan_reqterms.value=document.forms[0].hidServiceLeft.value;
				}
			}
		}

	}
	else
	{
		window.opener.document.all.interestEMI1.style.visibility="hidden";
		window.opener.document.all.interestEMI2.style.visibility="hidden";
		window.opener.document.all.interestEMI3.style.visibility="hidden";
		window.opener.document.forms[0].repayperiod.value=varArr[1];	
		//window.opener.document.forms[0].periods.value=varArr[1];
		if(varArr[2]=="pR" || varArr[2]=="pG")	
		{
			window.opener.document.forms[0].txtloan_reqterms.value=varArr[1];
		}
		//window.opener.document.forms[0].txtloan_reqterms.value=varArr[1];
	}
	if(varArr[9]=="1")
	{
			document.all.ifrms.src=appURL+"action/ifrm_nscloancheck.jsp?&hidBeanGetMethod=getNSCloancheck&hidBeanId=perapplicant&currdate="+currdate+"&strApplicantid="+<%=strApplId%>;
	}
	window.opener.document.forms[0].txtloan_amtreqd.value="";
	window.opener.document.forms[0].txtloan_costloanprd.value="";
	if(document.forms[0].hidCategoryType.value!="LAD")
	{
		window.opener.document.forms[0].txtloan_reqterms.value="";
		window.opener.document.forms[0].txt_vehage.value="";
	}
	//window.opener.document.forms[0].txtloan_tradein.value="";
	//window.opener.document.forms[0].txtloan_loantrade.value="";
	//window.opener.document.forms[0].txtnetTradeIn.value="";
	window.opener.document.forms[0].txtloan_downpay.value="";
	//window.opener.document.forms[0].actLoanValRatio.value="";
	//window.opener.document.forms[0].txtloan_recmdamt.value="";
	window.opener.document.forms[0].txtmonPay.value="0.00";
	if(document.forms[0].hidCategoryType.value=="AGR")
	{
		window.opener.document.all.measurementtype.style.visibility="visible";
		window.opener.document.all.Measurementtype1.style.visibility="visible";
	}
	else
	{
		window.opener.document.all.measurementtype.style.visibility="hidden";
		window.opener.document.all.Measurementtype1.style.visibility="hidden";
	}
	window.opener.document.forms[0].txtloan_amtreqd.focus();
	
	if(document.forms[0].hidCategoryType.value=="LAD" && varArr[2]=="pR")
	{
		window.opener.document.forms[0].selectinttype.value="1";
		window.opener.document.forms[0].sel_peridicity.value="n";
		window.opener.document.forms[0].txtloan_reqterms.value="12";
		//window.opener.getrepayment();
		window.opener.document.forms[0].txt_installments.value="0";
		window.opener.document.forms[0].selrepaymenttype.value="12";
		window.opener.document.all.idinttype1.style.visibility="hidden";
		window.opener.document.all.idinttype1.style.position="absolute";
		window.opener.document.all.idinttype2.style.visibility="hidden";
		window.opener.document.all.idinttype2.style.position="absolute";
		window.opener.document.all.idint1.style.visibility="hidden";
		window.opener.document.all.idint2.style.visibility="hidden";
		window.opener.document.all.idperiod.style.visibility="hidden";
		window.opener.document.all.idperiod1.style.visibility="hidden";
		window.opener.document.all.idperiod2.style.visibility="hidden";
		window.opener.document.all.idmargin.style.visibility="hidden";
		window.opener.document.all.idmclr1.style.visibility="hidden";
		window.opener.document.all.idmclr2.style.visibility="hidden";
		window.opener.document.all.id_secdisp.innerText="(Securities to be entered in Deposit Details page)";

		if(varArr[19]=="H"||varArr[19]=="F")
		{
			window.opener.document.all.idinttype1.style.visibility="visible";
			window.opener.document.all.idinttype1.style.position="relative";
			window.opener.document.all.idinttype2.style.visibility="visible";
			window.opener.document.all.idinttype2.style.position="relative";
			window.opener.document.forms[0].selectinttype.value="0";


			window.opener.document.all.idint1.style.visibility="visible";
			window.opener.document.all.idint1.style.position="relative";
			window.opener.document.all.idint2.style.visibility="visible";
			window.opener.document.all.idint2.style.position="relative";
		}

		window.opener.document.forms[0].hiddeposittype.value=varArr[19];
		//window.opener.document.forms[0].hiddepsitloanfor.value=varArr[20];
	}
	if(document.forms[0].hidCategoryType.value=="LAD" && varArr[2]=="pG")
	{

		window.opener.document.forms[0].selectinttype.value="0";
		window.opener.document.forms[0].txtloan_intrate.value="";
		window.opener.document.forms[0].txtloan_modintrate.value="";
		window.opener.document.forms[0].txtmarginoffered.value="";
		window.opener.document.forms[0].selrepaymenttype.value="0";
		window.opener.document.forms[0].txtloan_sancamt.value="";
		window.opener.document.forms[0].txtloan_recmdamt.value="";
		window.opener.document.forms[0].sel_mclrtype.value="";

		
		window.opener.document.forms[0].sel_peridicity.value="n";
		//window.opener.getrepayment();
		window.opener.document.all.idinttype1.style.visibility="visible";
		window.opener.document.all.idinttype2.style.visibility="visible";
		window.opener.document.all.idint1.style.visibility="visible";
		window.opener.document.all.idint2.style.visibility="visible";
		window.opener.document.all.idperiod1.style.visibility="hidden";
		window.opener.document.all.idperiod1.style.position="absolute";
		window.opener.document.all.idperiod2.style.visibility="hidden";
		window.opener.document.all.idperiod2.style.position="absolute";
		window.opener.document.all.idmargin.style.visibility="hidden";
		window.opener.document.all.id_secdisp.innerText="(Securities to be entered in Gold Ornaments page)";
	}
	if(document.forms[0].hidCategoryType.value=="LAD" && varArr[2]=="aR")
	{
		window.opener.document.forms[0].selectinttype.value="1";
		window.opener.document.forms[0].sel_peridicity.value="n";
		window.opener.document.forms[0].txtloan_reqterms.value="12";
		//window.opener.getrepayment();
		window.opener.document.forms[0].txt_installments.value="0";
		window.opener.document.forms[0].selrepaymenttype.value="12";
	}
	if(document.forms[0].hidCategoryType.value!="LAD")
	{
		window.opener.document.forms[0].selectinttype.value="0";
		window.opener.document.forms[0].txtloan_intrate.value="";
		window.opener.document.forms[0].txtloan_modintrate.value="";
		window.opener.document.forms[0].txt_installments.value="0";
		window.opener.document.forms[0].txt_repaycapacity.value="";
		window.opener.document.forms[0].txtloan_downpay.value="";
		window.opener.document.forms[0].txtMarginpercent.value="";
		window.opener.document.forms[0].txtmarginoffered.value="";
		window.opener.document.forms[0].txtmonPay.value="";
		window.opener.document.forms[0].txtloan_sancamt.value="";
		window.opener.document.forms[0].txtloan_upfrontfee.value="";
		window.opener.document.forms[0].txtloan_procfee.value="";
		window.opener.document.forms[0].hidPrdFlag.value="N";
		if(varArr[2]=="pI")
		{
			window.opener.document.forms[0].txtloan_costloanprd.readOnly=true;
		}
		window.opener.callInterestCharged();
	
	if((appprdtype=='H' || appprdtype=='S') && varpurposeid=='H')
	{
		window.opener.document.all.idhous.style.visibility = "visible";
		window.opener.document.all.idhous.style.position = "relative";

		window.opener.document.all.idage.style.visibility = "visible";
		window.opener.document.all.idage.style.position = "relative";

		window.opener.document.all.idveh.style.visibility = "hidden";
		window.opener.document.all.idveh.style.position = "absolute";
		
		window.opener.document.forms[0].hidvehAge.value=varArr[13];
	
	}
	else if((appprdtype=='A' || appprdtype=='S') && varpurposeid=='U')
	{
		window.opener.document.all.idveh.style.visibility = "visible";
		window.opener.document.all.idveh.style.position = "relative";

		window.opener.document.all.idage.style.visibility = "visible";
		window.opener.document.all.idage.style.position = "relative";

		window.opener.document.all.idhous.style.visibility = "hidden";
		window.opener.document.all.idhous.style.position = "absolute";
		
		window.opener.document.forms[0].hidvehAge.value=varArr[13];
	}
	else if(varArr[21]=="2")
	{
		window.opener.document.all.idveh.style.visibility = "visible";
		window.opener.document.all.idveh.style.position = "relative";

		window.opener.document.all.idage.style.visibility = "visible";
		window.opener.document.all.idage.style.position = "relative";

		window.opener.document.all.idhous.style.visibility = "hidden";
		window.opener.document.all.idhous.style.position = "absolute";
		window.opener.document.forms[0].hidvehAge.value=varArr[13];
		window.opener.document.forms[0].hidvehicletype.value=varArr[21];
	}
	else
	{
		window.opener.document.all.idhous.style.visibility = "hidden";
		window.opener.document.all.idhous.style.position = "absolute";
		
		window.opener.document.all.idveh.style.visibility = "hidden";
		window.opener.document.all.idveh.style.position = "absolute";

		window.opener.document.all.idage.style.visibility = "hidden";
		window.opener.document.all.idage.style.position = "absolute";
		window.opener.document.forms[0].hidvehicletype.value="";
	}

	window.opener.document.forms[0].hidMCLRTableCode.value="";
	window.opener.document.forms[0].hidbusstrategicpremium.value="";
	window.opener.document.forms[0].hidcreditrskpremium.value="";
	window.opener.document.forms[0].hidCRP.value="";
	window.opener.document.forms[0].hidBSP.value="";
	window.opener.document.forms[0].sel_mclrtype.value="";
	
	}
	if(document.forms[0].hidCategoryType.value!="LAD")
	{
		if(appprdtype=='P')
		{
		window.opener.document.all.costproject1.style.visibility = "hidden";
		window.opener.document.all.costproject1.style.position = "absolute";

		window.opener.document.all.costproject2.style.visibility = "hidden";
		window.opener.document.all.costproject2.style.position = "absolute";

		window.opener.document.all.costproject3.style.visibility = "hidden";
		window.opener.document.all.costproject3.style.position = "absolute";

		window.opener.document.all.costproject4.style.visibility = "hidden";
		window.opener.document.all.costproject4.style.position = "absolute";

		window.opener.document.all.costproject5.style.visibility = "visible";
		window.opener.document.all.costproject5.style.position = "relative";
		}
	 	else
	 	{
		window.opener.document.all.costproject1.style.visibility = "visible";
		window.opener.document.all.costproject1.style.position = "relative";
	
	   	window.opener.document.all.costproject2.style.visibility = "visible";
		window.opener.document.all.costproject2.style.position = "relative";
	
		window.opener.document.all.costproject3.style.visibility = "visible";
		window.opener.document.all.costproject3.style.position = "relative";
	
		window.opener.document.all.costproject4.style.visibility = "visible";
		window.opener.document.all.costproject4.style.position = "relative";
	
		window.opener.document.all.costproject5.style.visibility = "hidden";
		window.opener.document.all.costproject5.style.position = "absolute";
	 	}

	//added by bhaskar for Label Change of Cost of project
	  if(varArr[2]=="pI")
		{
	      window.opener.document.all.cpl.innerText="Total Value of securities";
		}
		else if(varArr[2]=="pL")
		{
			window.opener.document.all.cpl.innerText="Total Gross Rent";
		}
		else if(varArr[2]=="pA")
		{
			 window.opener.document.all.cpl.innerText="Cost of the Vehicle";
		}
		else if(varArr[2]=="pE")
		{
			 window.opener.document.all.cpl.innerText="Total Education Cost";
		}
		else if(varArr[2]=="pS")
		{
			 window.opener.document.all.cpl.innerText="Total value of Shares";
		}
		else if(varArr[2]=="pM" || (varArr[2]=="pH" && varpurposeid=='T'))
		{
			 window.opener.document.all.cpl.innerText="Market Value of property";
		}
		else if(varArr[2]=="pU" && varArr[14]=="OD")
		{
			window.opener.document.all.cpl.innerText="Cost of machineries/equipment/ Stock/Book Debts";
		}
		else if(varArr[2]=="pB")
		{
			window.opener.document.all.cpl.innerText="Total 2 Years of GST Return";
		}
		else if(varArr[2]=="pI")
		{
			 window.opener.document.all.cpl.innerText="Total value of Shares";
		}
		else
		{
			window.opener.document.all.cpl.innerText="Cost of the Project";
		}

	    if(varArr[2]=="pL")
	    {

	    	window.opener.document.all.leas.style.visibility = "visible";
			window.opener.document.all.leas.style.position = "relative";
			window.opener.document.forms[0].txtloan_costloanprd.readOnly=true;
			window.opener.document.all.idlease1.style.display = "table-row";
	    }
	    else  
	    {

	       	window.opener.document.all.leas.style.visibility = "hidden";
			window.opener.document.all.leas.style.position = "absolute";
			if(varArr[2]=="pI"  && varArr[14]!="OD")
			{
				window.opener.document.forms[0].txtloan_costloanprd.readOnly=false;
			}
			window.opener.document.all.idlease1.style.display = "none";
	    }
	    //Added by Kishan
	     if(varArr[2]=="pM" && varArr[14] == "OD")
	     {
	    	 window.opener.document.forms[0].hidmortflag.value = "Y";
	    	 window.opener.document.all.idrepay.style.visibility = "hidden";
	    	 window.opener.document.all.idrepay.style.position = "absolute";
	    	 window.opener.document.all.idrepay1.style.visibility = "hidden";
	    	 window.opener.document.all.idrepay1.style.position = "absolute";
	    	 window.opener.document.all.idrepay2.style.visibility = "hidden";
	    	 window.opener.document.all.idrepay2.style.position = "absolute";
	 		
	    	 window.opener.document.all.idemi1.style.visibility = "hidden";
	    	 window.opener.document.all.idemi1.style.position = "absolute";
	    	 window.opener.document.all.idemi2.style.visibility = "hidden";
	    	 window.opener.document.all.idemi2.style.position = "absolute";
	    	 window.opener.document.all.idemi3.style.visibility = "hidden";
	    	 window.opener.document.all.idemi3.style.position = "absolute";

	    	 window.opener.document.all.lbl_periodicity.style.visibility = "hidden";
	    	 window.opener.document.all.lbl_periodicity.style.position = "absolute";
	    	 window.opener.document.all.txt_periodicity.style.visibility = "hidden";
	    	 window.opener.document.all.txt_periodicity.style.position = "absolute";
	    	 window.opener.document.all.lbl_repaytype.style.visibility = "visible";
	    	 window.opener.document.all.lbl_repaytype.style.position = "relative";
	 		window.opener.document.all.txt_repaytype.style.visibility = "visible";
	 		window.opener.document.all.txt_repaytype.style.position = "relative";
	     }
	     else {
	    	 window.opener.document.forms[0].hidmortflag.value = "N";
	    	 window.opener.document.all.idrepay.style.visibility = "visible";
	    	 window.opener.document.all.idrepay.style.position = "relative";
	    	 window.opener.document.all.idrepay1.style.visibility = "visible";
	    	 window.opener.document.all.idrepay1.style.position = "relative";
	    	 window.opener.document.all.idrepay2.style.visibility = "visible";
	    	 window.opener.document.all.idrepay2.style.position = "relative";
	 		
	    	 window.opener.document.all.idemi1.style.visibility = "visible";
	    	 window.opener.document.all.idemi1.style.position = "relative";
	    	 window.opener.document.all.idemi2.style.visibility = "visible";
	    	 window.opener.document.all.idemi2.style.position = "relative";
	    	 window.opener.document.all.idemi3.style.visibility = "visible";
	    	 window.opener.document.all.idemi3.style.position = "relative";

	    	 window.opener.document.all.lbl_periodicity.style.visibility = "visible";
	    	 window.opener.document.all.lbl_periodicity.style.position = "relative";
	    	 window.opener.document.all.txt_periodicity.style.visibility = "visible";
	    	 window.opener.document.all.txt_periodicity.style.position = "relative";
	    	 window.opener.document.all.lbl_repaytype.style.visibility = "visible";
	    	 window.opener.document.all.lbl_repaytype.style.position = "relative";
	    	 window.opener.document.all.txt_repaytype.style.visibility = "visible";
	    	 window.opener.document.all.txt_repaytype.style.position = "relative";
	     }
	     window.opener.document.forms[0].txt_metloanpremium.value="";
	     window.opener.document.forms[0].txt_premium_tenor.value="";
	     window.opener.document.forms[0].txt_premium_loan_amt.value="";
	     window.opener.document.forms[0].txt_premium_Account_no.value="";
	     window.opener.document.forms[0].sel_Funded_Comp_Name.value="";
	     window.opener.document.forms[0].sel_Processed_Type.value="";
	}
	if(window.opener.document.forms[0].hidStaffProduct.value=="Y")
	{
		if(varArr[2]=="pC")
			window.opener.document.forms[0].sel_interestcharge.value="4";
		else
			window.opener.document.forms[0].sel_interestcharge.value="3";
		window.opener.document.forms[0].hidPrincipalRepay.value=varArr[17];
		window.opener.document.forms[0].hidInterestRepay.value=varArr[18];
	}	

	if(varArr[2]=="pC" || varArr[2]=="pJ"|| varArr[2]=="pN" || varArr[2]=="pV")
	{
		window.opener.document.all.costproject1.style.visibility = "hidden";
		window.opener.document.all.costproject1.style.position = "absolute";

		window.opener.document.all.costproject2.style.visibility = "hidden";
		window.opener.document.all.costproject2.style.position = "absolute";

		window.opener.document.all.costproject3.style.visibility = "hidden";
		window.opener.document.all.costproject3.style.position = "absolute";

		window.opener.document.all.costproject4.style.visibility = "hidden";
		window.opener.document.all.costproject4.style.position = "absolute";

		window.opener.document.all.costproject5.style.visibility = "visible";
		window.opener.document.all.costproject5.style.position = "relative";
	}
	 else
	 {
		 window.opener.document.all.costproject1.style.visibility = "visible";
		 window.opener.document.all.costproject1.style.position = "relative";
	
		 window.opener.document.all.costproject2.style.visibility = "visible";
		 window.opener.document.all.costproject2.style.position = "relative";
	
		 window.opener.document.all.costproject3.style.visibility = "visible";
		 window.opener.document.all.costproject3.style.position = "relative";
	
		 window.opener.document.all.costproject4.style.visibility = "visible";
		 window.opener.document.all.costproject4.style.position = "relative";
	
		 window.opener.document.all.costproject5.style.visibility = "hidden";
		 window.opener.document.all.costproject5.style.position = "absolute";
	 }

	var varArr1= varArr[16].split("@");
	for(var i=0;i<varArr1.length-1;i++)
	{
		window.opener.document.forms[0].selrepaymenttype.length=varArr1.length;

		if(i==0)
		{
			window.opener.document.forms[0].selrepaymenttype.options[0].text="<--select-->";	
			window.opener.document.forms[0].selrepaymenttype.options[0].value="0";
		}
		
		var selValue=varArr1[i];
	
		if("1"==selValue)	
		{	
			window.opener.document.forms[0].selrepaymenttype.options[i+1].text="EMI";	
			window.opener.document.forms[0].selrepaymenttype.options[i+1].value=selValue;
		}			
		else if("2"==selValue)
		{			
			window.opener.document.forms[0].selrepaymenttype.options[i+1].text="Non-EMI";	
			window.opener.document.forms[0].selrepaymenttype.options[i+1].value=selValue;
		}
		else if("12"==selValue)
		{			
			window.opener.document.forms[0].selrepaymenttype.options[i+1].text="On Demand";	
			window.opener.document.forms[0].selrepaymenttype.options[i+1].value=selValue;
		}
		else if("8"==selValue)
		{			
			window.opener.document.forms[0].selrepaymenttype.options[i+1].text="On Due Date";	
			window.opener.document.forms[0].selrepaymenttype.options[i+1].value=selValue;
		}			
		else if("13"==selValue)
		{			
			window.opener.document.forms[0].selrepaymenttype.options[i+1].text="Equal Monthly Installment";	
			window.opener.document.forms[0].selrepaymenttype.options[i+1].value=selValue;
		}
		else if("14"==selValue)
		{			
			window.opener.document.forms[0].selrepaymenttype.options[i+1].text="2 Yearly Equal Installment";	
			window.opener.document.forms[0].selrepaymenttype.options[i+1].value=selValue;
		}
		
	}

	//if(varArr[2]=="pH")
	//{
     // window.opener.document.all.idhouse.style.display="table-row";
	//}
	//else
	//{
		//window.opener.document.all.idhouse.style.display="none";
	//}
			//end
			
			
	if(document.forms[0].hidCategoryType.value!="LAD")
	{		
		if(varArr[2]=="pU" && window.opener.varSHGcustomer=="Y")
		{
			window.opener.document.all.idshgdet.style.display="table";
			window.opener.document.forms[0].cmdshgdetails.disabled=true;
			
		}
		else
		{
			window.opener.document.all.idshgdet.style.display="none";
		}
	}	
	
	window.opener.document.forms[0].sel_interesttype.value="";
	window.opener.document.all.idmclr1.style.visibility="hidden";
	window.opener.document.all.idmclr1.style.position="absolute";
	window.opener.document.all.idmclr2.style.visibility="hidden";
	window.opener.document.all.idmclr2.style.position="absolute";
	window.opener.varInterestType="";
	window.opener.loadInterestType();		
		
	window.close();
}
function doClose()
{
	window.close();
}
function doSearch()
{
	var goldloanflag = false;
	if(document.forms[0].hidCategoryType.value.toUpperCase()=="AGR" && document.forms[0].prd_type.value=="H")
		goldloanflag = true;
	else if(document.forms[0].hidCategoryType.value.toUpperCase()=="LAD" && document.forms[0].prd_type.value=="G")
		goldloanflag = true;
	var goldloan = parseInt(goldloancount);
	var maxgold = parseInt(maxgoldloan);
 	if(goldloanflag == true)
 	{
		if(goldloan >= maxgold) {
			alert('You have exceeded maximum utilization limit of Gold Loan Proposals.');
			document.forms[0].prd_type.value="0";
			document.forms[0].prd_type.focus();
			return;
		}
 	}
	if(document.forms[0].prd_type.value=="U")
	{
		if(window.opener.document.forms[0].hidconstitution.value=="01" || window.opener.document.forms[0].hidconstitution.value=="02")
		{
			<%if(strAppgender.equalsIgnoreCase("F")&& !(strAppEmploymnt.equalsIgnoreCase("1"))){ %>
			<%} else {%>
			alert("This Product will eligible only for Non - Salaried women.");
			document.forms[0].prd_type.value="0";
			document.forms[0].prd_type.focus();
			return;
			<%}%>
		}
		else if(parseInt(window.opener.document.forms[0].hidconstitution.value)>=183 && parseInt(window.opener.document.forms[0].hidconstitution.value)<=191)
		{
			if(!(parseInt(window.opener.document.forms[0].hidconstitution.value)==183||parseInt(window.opener.document.forms[0].hidconstitution.value)==186||
					parseInt(window.opener.document.forms[0].hidconstitution.value)==189))
			{
				alert("This Product will eligible only for following groups "+varConstDesc);
				document.forms[0].prd_type.value="0";
				document.forms[0].prd_type.focus();
				return;
			}
		}
		else
		{
			if(varstakeHolder!="Y")
			{
				alert("Check Whether majority of shareholding  field in Customer profile- Demographics");
				document.forms[0].prd_type.value="0";
				document.forms[0].prd_type.focus();
				return;
			}	
		}
	}

	if(document.forms[0].prd_type.value=="S" && window.opener.document.forms[0].hidconstitution.value!="01")
	{
		alert("This Product Eligible only for individuals");
		document.forms[0].prd_type.value="0";
		document.forms[0].prd_type.focus();
		return;
	}
	
	if(document.forms[0].prd_type.value=="E")
	{
		<%if(strAppEmploymnt.equalsIgnoreCase("10")){%>
		<%} else {%>
		alert("This Product will eligible only for Students.");
		document.forms[0].prd_type.value="0";
		document.forms[0].prd_type.focus();
		return;
		<%}%>
	}

	if((window.opener.document.forms[0].hidNSDLFlag.value=="Y") && (document.forms[0].prd_type.value!="0") && (document.forms[0].prd_type.value!="E"))
	{
		if(confirm("Attached LAR created for NSDL Vidhyalakshmi Loan Request,you cannot use this LAR for other than Education Loan Schemes,Would you like to proceed with another LAR?"))
		{
			window.opener.document.forms[0].txt_appinwardno.value = "";
			window.opener.document.forms[0].txt_receivedRH.value = "";
			window.opener.document.forms[0].hidNSDLFlag.value = "";
		}
		else
		{
			document.forms[0].prd_type.value="0";
			return;
		}
	}
	
	var prdtype="";
	if(document.forms[0].prd_type.value=="0")
	{
		alert("Select Product Category");
		document.forms[0].prd_type.focus();
		return;
	}
	var bowid=document.forms[0].comappid.value;
	var orgscode1 = document.forms[0].orgscode1.value;
	var orgcode1 = document.forms[0].orgcode1.value;
	var orglevel1 = document.forms[0].orglevel1.value;
	prdname=document.forms[0].prd_type.value;
	document.forms[0].hidBeanId.value="appeditlock";
	document.forms[0].hidBeanGetMethod.value="getProductList";
	document.forms[0].action=appURL+"action/productslisthelp.jsp?prdtype="+prdtype+"&prdname="+prdname+"&orgscode="+orgscode1+"&orgcode="+orgcode1+"&orglevel="+orglevel1;
	document.forms[0].submit();

}
function loadprdcategory(){
	if(document.forms[0].hidCategoryType.value.toUpperCase()=="AGR")
 	{
	 	document.forms[0].prd_type.length=22;
	 	document.forms[0].prd_type.options[1] = new Option('Poultry Boiler','A');
	 	document.forms[0].prd_type.options[2] = new Option('Bullock Cart','B');
        document.forms[0].prd_type.options[3] = new Option('Crop Loans','C');
        document.forms[0].prd_type.options[4] = new Option('Diary Farming','D');
        document.forms[0].prd_type.options[5] = new Option('Animal Rearing','E');
        document.forms[0].prd_type.options[6] = new Option('Farm Machinery','F');
        document.forms[0].prd_type.options[7] = new Option('Gobar Gas Plant','G');
        document.forms[0].prd_type.options[8] = new Option('Gold Loan','H');
        document.forms[0].prd_type.options[9] = new Option('Consumption Loan','I');
        document.forms[0].prd_type.options[10] = new Option('Sericulture','J');
        document.forms[0].prd_type.options[11] = new Option('Loan Against Warehouse Receipts','L');
        document.forms[0].prd_type.options[12] = new Option('Vehicle Loan','M');
        document.forms[0].prd_type.options[13] = new Option('Fisheries','N');
        document.forms[0].prd_type.options[14] = new Option('Poultry Layering','P');
        document.forms[0].prd_type.options[15] = new Option('Plantation Term Loan','Q');
        document.forms[0].prd_type.options[16] = new Option('Loan Against deposit','R');
		document.forms[0].prd_type.options[17] = new Option('Minor Irrigation','U');
		document.forms[0].prd_type.options[18] = new Option('Common Product','K');
		document.forms[0].prd_type.options[19] = new Option('Union General Crcmdedit Card','V');
		document.forms[0].prd_type.options[20] = new Option('Purchase of fodder','T');
		document.forms[0].prd_type.options[21] = new Option('Union Bhumiheen Card','W');
        document.forms[0].prd_type.options[22] = new Option('Coffee Plantation','O'); 
     }
  	if(document.forms[0].hidCategoryType.value.toUpperCase()=="RET")
	{
		 document.forms[0].prd_type.length=15;
		document.forms[0].prd_type.options[1] = new Option('Housing Loan','H');
		document.forms[0].prd_type.options[2] = new Option('Vehicle Loan','A');
		document.forms[0].prd_type.options[3] = new Option('Mortgage Loan','M');
		document.forms[0].prd_type.options[4] = new Option('Salaried Person','P');
		document.forms[0].prd_type.options[5] = new Option('Mahila Udyog','U');
        document.forms[0].prd_type.options[6] = new Option('Ravi Kiran','K');
        document.forms[0].prd_type.options[7] = new Option('Education Loan','E');
        document.forms[0].prd_type.options[8] = new Option('Leased Loan','L');
        document.forms[0].prd_type.options[9] = new Option('Instacash Loan','I');
        document.forms[0].prd_type.options[10] = new Option('Staff Loan','SL'); 
        document.forms[0].prd_type.options[11] = new Option('Clean Loan','C');     
        document.forms[0].prd_type.options[12] = new Option('NSC Loan','N');
        document.forms[0].prd_type.options[13] = new Option('Suvidha','V');
        document.forms[0].prd_type.options[14] = new Option('General Loan','J');
        document.forms[0].prd_type.options[15] = new Option('Loan Against Shares','S');
        document.forms[0].prd_type.options[16] = new Option('Business Quick Loan','B');
 	}
  	else{
  		document.forms[0].prd_type.value="0";
  	}
  	if(document.forms[0].hidCategoryType.value.toUpperCase()=="LAD")
 	{
  		document.forms[0].prd_type.length=2;
  		document.forms[0].prd_type.options[1] = new Option('Gold Loans','G');
  		document.forms[0].prd_type.options[2] = new Option('Loan against Deposits','R');
 	}
  	if(appprdtype!=""){
  		document.forms[0].prd_type.value=appprdtype;
  	}
}
</SCRIPT>
<body onload="loadprdcategory();">
<form name="productlisthelp" method="post" class="normal">
<table width="98%" border="0" cellspacing="2" cellpadding="2" class="outertable" align="center">
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellpadding="3" cellspacing="0">
			<tr align="center" class="dataheader">
				<td colspan="2" align="right"><b>Products</b>&nbsp;</td>
				<td align="left">&nbsp;<select name="prd_type" onchange="doSearch()" >
				<option value="0">--Select---</option>
				</select></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<div class="cellcontainer">
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<%String inside = "N";
			String strStaffproduct = "";
			if (v != null) {
				int vecsize = v.size();
				int intRowNumber = 1;
				for (int l = 0; l < vecsize; l++) {
					inside = "Y";
					arryCol = (ArrayList) v.get(l);
					String strConcat = "";
					String val = "$";
					String val1 = "-";
					strConcat = (String) arryCol.get(1) + val1
							+ (String) arryCol.get(2) + val1
							+ (String) arryCol.get(3) + val1
							+ (String) arryCol.get(4)+ val1
							+ (String) arryCol.get(12)+val1+ (String) arryCol.get(14);

					//Hide Staff loans for non staff customers
					strStaffproduct = Helper.correctNull(
							(String) arryCol.get(9)).trim();
					if (!(strStaffFlag.trim().equalsIgnoreCase("N") && strStaffproduct
							.equalsIgnoreCase("Y"))) {

						%>
	<tr valign="top" class="datagrid">
		<td width="3%"><b><%=intRowNumber++%>.</b></td>
		<td width="97%" align="left"><a
			href="javascript:getSelectedValue('<%=(String)arryCol.get(0)%><%=val%>
												<%=(String)arryCol.get(5)%><%=val%>
												<%//=(String)arryCol.get(6)%><%//=val%>
												<%=(String)arryCol.get(6)%><%=val%>
												<%=strConcat%><%=val%>
												<%=(String)arryCol.get(7)%><%=val%>
												<%=(String)arryCol.get(8)%><%=val%>
												<%=(String)arryCol.get(9)%><%=val%>
												<%=(String)arryCol.get(10)%><%=val%>
												<%=(String)arryCol.get(11)%><%=val%>
												<%=(String)arryCol.get(13)%><%=val%>
												<%=(String)arryCol.get(12)%><%=val%>
												<%=(String)arryCol.get(15)%><%=val%>
												<%=(String)arryCol.get(16)%><%=val%>
												<%=(String)arryCol.get(17)%><%=val%>
												<%=(String)arryCol.get(18)%><%=val%>
												<%=(String)arryCol.get(19)%><%=val%>
												<%=(String)arryCol.get(20)%><%=val%>
												<%=(String)arryCol.get(21)%><%=val%>
												<%=(String)arryCol.get(22)%><%=val%>
												<%=(String)arryCol.get(23)%><%=val%>
												<%=(String)arryCol.get(24)%><%=val%>
												<%=(String)arryCol.get(26)%><%=val%>
												<%=(String)arryCol.get(27)%>','<%=(String)arryCol.get(28)%>')"
			class="blackfont" align="center"><b><%=(String) arryCol.get(1)%><%=val1%><%=(String) arryCol.get(2)%><%=val1%><%=(String) arryCol.get(14)%><%=val1%><%=(String) arryCol.get(3)%><%=val1%><%=(String) arryCol.get(4)%>
		<%=val1%><%=(String) arryCol.get(12)%><%=val1%><%=(String) arryCol.get(25)%></b></a></td>
	</tr>
	<%}
				}
			}

			%>

	<%if (inside.equals("N")) {

			%>
	<tr class="datagrid">
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr class="datagrid">
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr valign="top" class="datagrid">
		<td colspan="2" width="15%" align="center"><b>No Data Found for the
		selected criteria</b></td>
	</tr>
	<%}%>
	<tr class="datagrid">
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr class="datagrid">
		<td colspan="2">&nbsp;</td>
	</tr>
</table>
</div>
</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnenable="Y" />
<input type="hidden" name="comappid" value="<%=Helper.correctNull((String) request.getParameter("comappid"))%>">
<input type="hidden" name="apptype" value="<%=Helper.correctNull((String)request.getParameter("apptype"))%>">
<input type="hidden" name="hidBeanId" value="appeditlock"> 
<input type="hidden" name="hidBeanGetMethod" value="getProductList"> 
<input type="hidden" name="orgscode1" value="<%=Helper.correctNull((String)session.getAttribute("strOrgShortCode"))%>">
<input type="hidden" name="orgcode1" value="<%=Helper.correctNull((String)session.getAttribute("strOrgCode"))%>">
<input type="hidden" name="orglevel1" value="<%=Helper.correctNull((String)session.getAttribute("strOrgLevel"))%>">
<input type="hidden" name="hidStaffFlag" value="<%=Helper.correctNull((String)request.getParameter("hidStaffFlag"))%>">
<input type="hidden" name="hidServiceLeft" value="<%=Helper.correctNull((String)request.getParameter("hidServiceLeft"))%>">
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>"> 
<input type="hidden" name="DocReceived" value="<%=Helper.correctNull((String)request.getParameter("DocReceived"))%>"> 
<INPUT TYPE="hidden" name="bowid" value="<%//=bowid%>"> 
<input type="hidden" name="hidappage" value="<%=appage%>"> 
<iframe height="0" width="0" id="ifrms" frameborder="0" style="border:0"></iframe>
</form>
</body>
</html>
