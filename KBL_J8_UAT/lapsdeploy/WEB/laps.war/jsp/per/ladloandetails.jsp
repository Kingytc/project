<%@include file="../share/directives.jsp"%>
<%int employeeretirementage = 0;
			String strIntType = "";
			String applicantid = "";
			String applicationno = "";
			String appstatus = "";
			String appname = "";
			String inwardno = "";
			String applevel = "";
			String strAppholder = "";
			String strbtnenable = "";
			String loanType="";
			String strApporgname="";
			String strAppstatus = "";
			String sanctionrefno="",strCbsaccno="",strAppType="",strRevalFlag="",strAccOpenDate="",strOpenFlag="";
			applicantid = Helper.correctNull((String) hshValues.get("hidapplicantid"));
			String strPrdLoanType = Helper.correctNull((String) hshValues.get("PRD_LOANTYPE"));
			String strapplicantNewid = "";
			if (hshValues.get("hshAppData") != null) {
				HashMap hshRecord = (HashMap) hshValues.get("hshAppData");
				strAppstatus = Helper.correctNull((String) hshRecord
						.get("app_status"));
				applicationno = Helper.correctNull((String) hshRecord
						.get("appno"));
				if(applicantid.equalsIgnoreCase(""))
				applicantid = Helper.correctNull((String) hshRecord
						.get("applicantid"));
				strapplicantNewid = Helper.correctNull((String) hshRecord.get("applicantnewid"));
				appstatus = Helper.correctNull((String) hshRecord
						.get("app_status"));
				appname = Helper
						.correctNull((String) hshRecord.get("app_name"));
				inwardno = Helper.correctNull((String) hshRecord
						.get("inwardno"));
				applevel = Helper.correctNull((String) hshRecord
						.get("applevel"));
				strbtnenable = Helper.correctNull((String) hshRecord
						.get("btnenable"));
				strAppholder = Helper.correctNull((String) hshRecord
						.get("applnholder"));
				
				loanType = Helper.correctNull((String) hshRecord
						.get("apploantype"));
				strApporgname = Helper.correctNull((String) hshRecord.get("apporgname"));
				
				sanctionrefno= Helper.correctNull((String) hshRecord.get("sanctionrefno"));
				strCbsaccno = Helper.correctNull((String) hshRecord.get("CBSACCOUNTNO"));
				strAppType = Helper.correctNull((String) hshRecord.get("ApplicantType"));
				strAccOpenDate = Helper.correctNull((String) hshRecord.get("strAccopenDate"));
				strOpenFlag = Helper.correctNull((String) hshRecord.get("strAccopenFlag"));
				strRevalFlag = Helper.correctNull((String) hshRecord.get("strRevalidationFlag"));
				
				if(strAppType.equalsIgnoreCase("S"))
				{
					strAppType="Restructure";
				}else if(strAppType.equalsIgnoreCase("R"))
				{
					strAppType="Renew";
				}else if(strAppType.equalsIgnoreCase("P"))
				{
					strAppType="Post Sanction";
				}else{
					strAppType="Fresh";
				}
			}
			if (applicantid.equalsIgnoreCase("")) {
				applicantid = Helper.correctNull((String) request
						.getParameter("hidapplicantid"));
			}
			if (applicationno.equalsIgnoreCase("")) {
				applicationno = Helper.correctNull((String) request
						.getParameter("appno"));
			}
			if (appstatus.equalsIgnoreCase("")) {
				appstatus = Helper.correctNull((String) request
						.getParameter("appstatus"));
			}
			if (appstatus.equalsIgnoreCase("op")) {
				appstatus = "Open/Pending";
			} else if (appstatus.equalsIgnoreCase("pa")) {
				appstatus = "Processed/Approved";

			} else if (appstatus.equalsIgnoreCase("pr")) {
				appstatus = "Processed/Rejected";
			} else if (appstatus.equalsIgnoreCase("ca")) {
				appstatus = "Closed/Approved";
			} else if (appstatus.equalsIgnoreCase("cr")) {
				appstatus = "Closed/Rejected";
			}
			else if (appstatus.equalsIgnoreCase("ol")) {
				appstatus = "Open/Lodged";
			}
			if (appname.equalsIgnoreCase("")) {
				appname = Helper.correctNull((String) request
						.getParameter("compname"));
			}
			strIntType = Helper.correctNull((String) hshValues
					.get("loaninttype"));

			String strappno1 = Helper.correctNull((String) hshValues
					.get("appno"));
			String strProductType = Helper.correctNull((String) hshValues
					.get("prd_type"));

			session.setAttribute("strProductType", strProductType);
			String prdcode = Helper.correctNull((String) hshValues
					.get("prdcode"));

			session.setAttribute("prdcode", prdcode);

			String maxterms = Helper.correctNull((String) hshValues
					.get("maxterms"));
			String Loanamt = Helper.correctDouble((String) hshValues
					.get("sancmount"));

			employeeretirementage = Integer.parseInt(Helper
					.correctInt((String) hshValues.get("serviceleft")));
			String strStaff = Helper.correctNull((String) hshValues
					.get("staff_flag"));
			session.setAttribute("staffloan", strStaff);
			session.setAttribute("strappno", applicationno);
			session.setAttribute("strappstatus", strAppstatus);
			session.setAttribute("strAppCreateDate", Helper.correctNull((String)hshValues.get("strAppCreateDate")));
			if(Helper.correctNull((String)hshValues.get("strAppCreateDate")).equalsIgnoreCase(""))
				session.setAttribute("strAppCreateDate",Helper.getCurrentDateTime());
	String strcategorytype = Helper.correctNull((String) request.getParameter("hidCategoryType"));
	String perapp_employment = Helper.correctNull((String) hshValues.get("perapp_employment"));
	String strCBSid=Helper.correctNull((String)hshValues.get("inward_cbsid"));
	String strOrgLevel1=Helper.correctNull((String) session.getAttribute("strOrgLevel"));
	session.setAttribute("perapp_employment", perapp_employment);
	session.setAttribute("sessionModuleType","LAD");
	session.setAttribute("strAppType",Helper.correctNull((String)hshValues.get("appProposalType")));
	String digiGoldFlag = Helper.correctNull((String) hshValues.get("subLoanType"));
	session.setAttribute("digiGoldFlag",digiGoldFlag);
	String strOption = "",strText="",strDescription="";
	String strMCLRtype = Helper.correctNull((String) hshValues.get("loan_mclrtype"));
	strDescription=Helper.correctNull((String) hshValues.get("strMCLRtypeDesc"));
	
	String modofpaymentflag = Helper.correctNull((String)hshValues.get("modofpaymentflag"));
	  System.out.println("mode of payment Flag for gold/deposit loan-->"+modofpaymentflag);
	
	if(!strMCLRtype.equalsIgnoreCase(""))
	{
		strDescription = strDescription+"-"+strMCLRtype.split("@")[1];
		strOption = strMCLRtype;
		/*strOption = strMCLRtype;
		strText = strMCLRtype.split("@")[0];
		if(strText.equalsIgnoreCase("O"))
			strDescription = "One day MCLR";
		else if(strText.equalsIgnoreCase("M"))
			strDescription = "Monthly MCLR";
		else if(strText.equalsIgnoreCase("Q"))
			strDescription = "Quartely MCLR";
		else if(strText.equalsIgnoreCase("H"))
			strDescription = "Half yearly MCLR";
		else if(strText.equalsIgnoreCase("Y"))
			strDescription = "Yearly MCLR";
		
		strDescription = strDescription+"-"+strMCLRtype.split("@")[1];*/
	}
			%>
<html>
<head>
<title>Personal - Applicant</title>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/per/perloandetails.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var strOrgcode="<%=Helper.correctNull((String) session.getAttribute("strOrgCode"))%>";
var str_appno1 ="<%=strappno1%>";
var varfrom="<%=Helper.correctNull((String)hshValues.get("rfrom"))%>";
var varto="<%=Helper.correctNull((String)hshValues.get("rangeto"))%>";
var varIntType ="<%= Helper.correctNull((String)hshValues.get("loaninttype"))%>";
var varRepayType ="<%= Helper.correctNull((String)hshValues.get("repaymenttype"))%>";
var loan_repaycapacity ="<%=Helper.correctNull((String)hshValues.get("loan_repaycapacity"))%>";
var maxterms1="<%=maxterms%>";
var category="<%=Helper.correctNull((String)hshValues.get("perapp_category"))%>";
var age="<%=Helper.correctNull((String)hshValues.get("perapp_age"))%>";
var count=0;
var varcbsid="<%=strCBSid%>";
var varto="<%=Helper.correctNull((String)hshValues.get("prd_rangeto"))%>";
var offeredmargin="<%=Helper.correctNull((String)hshValues.get("offeredmargin"))%>";
var varinwardnorequired="<%=Helper.correctNull((String)hshValues.get("inwardnorequired"))%>";
var installment = '<%=Helper.correctNull((String)hshValues.get("loan_periodicity"))%>';
var varpageid="<%=Helper.correctNull((String)hshValues.get("PageId"))%>";
var varRecordFlag="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
var varEmpStatus="<%=perapp_employment%>";
var varPrdType="<%=strProductType%>";
var varDocRecvd ="<%= Helper.correctNull((String)hshValues.get("loan_docrecvd"))%>";
var varDocReceivedNew="";
var varsponseragency="<%=Helper.correctNull((String) hshValues.get("sponseragency"))%>";
var varsubsidytype="<%=Helper.correctNull((String) hshValues.get("subsidytype"))%>";
var subsidy="<%=Helper.correctNull((String) hshValues.get("loan_govt"))%>";
var scheme="<%=Helper.correctNull((String) hshValues.get("govt_scheme"))%>";
var varSpecialCust="<%=Helper.correctNull((String)hshValues.get("loan_specialcust"))%>";
var strOrgLevel="<%=strOrgLevel1%>";
var varApplicantId="<%=applicantid%>";
var varprdtype="";
var varAppType="<%=Helper.correctNull((String)session.getAttribute("strAppType"))%>";
var varMCLRType="<%=Helper.correctNull((String) hshValues.get("loan_mclrtype"))%>";
var varOtherDepFlag="<%=Helper.correctNull((String) hshValues.get("strOtherDepFlag"))%>";
var varappraisalFlag="<%=Helper.correctNull((String) hshValues.get("appraisalFlag"))%>";
var varAlertForGL="<%=Helper.correctNull((String) hshValues.get("AlertForGL"))%>";
var agencyname="<%=Helper.correctNull((String) hshValues.get("LOAN_AGENCYNAME"))%>";
var APP_PERM_NO="<%=Helper.correctNull((String)hshValues.get("APP_PERM_NO"))%>";
var varQueryStatus="<%=Helper.correctNull((String)hshValues.get("Query_Status"))%>";
var varInterestType="<%=Helper.correctNull((String)hshValues.get("strROIType"))%>";
var val="<%=Helper.correctNull((String) hshValues.get("loan_modeofpay"))%>";
var modaccnum="<%=Helper.correctNull((String) hshValues.get("loan_operativeaccno"))%>";
var modofpaymentflag="<%=modofpaymentflag%>";
var ExposureChklimit= "<%=Helper.correctNull((String)hshValues.get("strdblExplimit"))%>";
var Explimitchk= "<%=Helper.correctNull((String)hshValues.get("strExplimitchk"))%>";
var varPancount="<%=Helper.correctNull((String)hshValues.get("Pancount"))%>";
var varPanCheck="<%=Helper.correctNull((String)hshValues.get("strPanCheck"))%>";
var Expcheck="<%=Helper.correctNull((String)hshValues.get("strChecklimit"))%>";
function disgold()
{
	var producttype=document.forms[0].prd_type.value;
	if(producttype=="aH" || producttype=="pG")
	{
		document.all.g1.style.visibility="visible";
	}
	else
	{
		document.all.g1.style.visibility="hidden";
	}
}

function callOnLoad()
{	
	if(document.forms[0].appno.value=="new")
	{	
		callDisableControls(true,false,true,true,false);
		document.all.id_permsearch.style.visibility="hidden";
		document.all.id_permsearch.style.position="absolute";
		document.forms[0].hideditflag.value="Y";
		placeValues();
		document.forms[0].hidAction.value="insert";
		if(document.forms[0].txtprd_desc.value=="---")
		{
			document.forms[0].txtprd_desc.value="";
		}
		disablefields(false);
		document.forms[0].appno.readOnly=true;
		document.forms[0].appname.readOnly=true;
		document.forms[0].appstatus.readOnly=true;

		document.forms[0].selectgovt.disabled = true;
		document.forms[0].schemetype.disabled = true;
		document.forms[0].sel_subsidytype.disabled = true;
		document.forms[0].sub.disabled = true;
		document.forms[0].sel_sponser_agency.disabled = true;
		document.forms[0].txt_agency.disabled = true;
		
		document.all.applsearch.style.visibility="visible";
		document.all.applsearch.style.position="relative";
		
	}
	else if(document.forms[0].btnenable.value =="Y")
	{
		document.all.applsearch.style.visibility="hidden";
		document.all.applsearch.style.position="absolute";
		
		callDisableControls(false,true,true,true,false);
		placeValues();
		disablefields(true);
	}
	else
	{
		document.all.applsearch.style.visibility="hidden";
		document.all.applsearch.style.position="absolute";
		
		callDisableControls(true,true,true,true,false);
		placeValues();
		disablefields(true);
	}
	calculateLoanAmount();

    if(subsidy!="")
	{
		document.forms[0].selectgovt.value=subsidy;
		/*To store the value in the "Scheme Type " field*/
		if(scheme!="")
		{
			document.forms[0].schemetype.value=scheme;
		}
		else
		{
			document.forms[0].schemetype.value=0;
		}
		/*To store the value in the "Sponsor Agency" field*/
		if(varsponseragency!="")
		{
			document.forms[0].sel_sponser_agency.value=varsponseragency;
			if(varsponseragency=="DRDA")
			{
				document.all.s4.style.visibility="hidden";	
		    	document.all.s4.style.position="relative";
			}
		}
		else
		{
			document.forms[0].sel_sponser_agency.value="0";
		}
		/*To store the value in the "Govt. Sponsor Scheme" field*/
		if(varsubsidytype!="")
		{
			
			document.forms[0].sel_subsidytype.value=varsubsidytype;
			
		}
		else
		{
			document.forms[0].sel_subsidytype.value="0";
		}
	}
	else
	{
		document.forms[0].selectgovt.value=2;
	}

	if(varAlertForGL == "Y")
	{
		alert("Since the proposal should be revised with new gold rates as per today, Gold ornaments details were updated and Appraisal -> Loan Details, MIS details were deleted.");
	}
	if (varMCLRType != "")
	{
		document.forms[0].sel_mclrtype.value = varMCLRType;
	}
	else 
	{
		document.forms[0].sel_mclrtype.value = "";
	}
	if(APP_PERM_NO!="")
	{
		document.all.id_permLetter.style.visibility="visible";
	    document.all.id_permLetter.style.position="relative";
	    document.all.deattach.style.visibility="visible";
	    document.all.deattach.style.position="relative";
		//document.forms[0].cmdpermissionletter.disabled=false;
	}
	else
	{
		document.all.id_permLetter.style.visibility="hidden";
	    document.all.id_permLetter.style.position="absolute";
	    document.all.deattach.style.visibility="hidden";
	    document.all.deattach.style.position="absolute";
		//document.forms[0].cmdpermissionletter.disabled=true;
	}
	/*
	* To store the value in the "Mode of payment" field // new application created on live date or  after live date,Mode of Payment has to come,NEW - New one
	*/
	if(modofpaymentflag == "EOP" || modofpaymentflag == "NEW")
	
	 { 
		var modpay="";
		if(val=="")
		{
			document.forms[0].selmodepayment.value='E';
		}
		else if (modaccnum == "" && val=="N")
		{
			document.forms[0].selmodepayment.value="E";
			modpay="E";
		}
		else{
			document.forms[0].selmodepayment.value=val;
			}
		if(val=="E" || val=="")
		{
			document.forms[0].txt_operativeaccno.disabled=false;
			document.all.opnolabel.style.visibility="visible";
			document.all.opnolabel.style.position="relative";
			document.all.opnovalue.style.visibility="visible";
			document.all.opnovalue.style.position="relative";
		}
		else
		{
			if(modpay =="E"){
				document.forms[0].txt_operativeaccno.disabled=false;
				document.all.opnolabel.style.visibility="visible";
				document.all.opnolabel.style.position="relative";
				document.all.opnovalue.style.visibility="visible";
				document.all.opnovalue.style.position="relative";
				}else{
					document.forms[0].txt_operativeaccno.disabled=true;
			    	document.all.opnolabel.style.visibility="hidden";
			    	document.all.opnolabel.style.position="absolute";
					document.all.opnovalue.style.visibility="hidden";
					document.all.opnovalue.style.position="absolute";
					}
			
		}

		}
}
function selOperative(obj)
{
	var val=obj.value;
	
	if(val=="E")
	{
		document.forms[0].txt_operativeaccno.disabled=false;
		document.all.opnolabel.style.visibility="visible";
		document.all.opnolabel.style.position="relative";
		
		document.all.opnovalue.style.visibility="visible";
		document.all.opnovalue.style.position="relative";
	}
	else
	{
		document.forms[0].txt_operativeaccno.disabled=true;
		document.forms[0].txt_operativeaccno.value="";
		document.all.opnolabel.style.visibility="hidden";
		document.all.opnolabel.style.position="absolute";
		
		document.all.opnovalue.style.visibility="hidden";
		document.all.opnovalue.style.position="absolute";
	}
}

function ValidateOpearativeAcc()
{
	var varOperAcc=document.forms[0].txt_operativeaccno.value;
	if(varOperAcc.length!=16)
	{
		alert("Please Enter Valid Operative Account Number");
		return;
	}
	else if(varOperAcc!="")
	{
		if(document.forms[0].cmdsave.disabled==false)
		{
			document.forms[0].cmdsave.disabled=true;
			document.all.ifrmcheckduplicate.src = appURL+"action/ifrmcersaiIDcheckduplicate.jsp?hidBeanGetMethod=getcersaiIDCheckDuplicate&hidBeanId=securitymaster&strPage=Prop&strrowindexname=txt_operativeaccno&strAccNo="+document.forms[0].txt_operativeaccno.value;
		}
	}
}
function placeValues()
{
	if(document.forms[0].prd_type.value=="pR")
	{
		//document.forms[0].selectinttype.value="1";
		document.forms[0].sel_peridicity.value="n";
		document.forms[0].txtloan_reqterms.value="12";
		//getrepayment();
		document.forms[0].txt_installments.value="0";
		document.forms[0].selrepaymenttype.value="12";
		document.all.idinttype1.style.visibility="hidden";
		document.all.idinttype2.style.visibility="hidden";
		document.all.idint1.style.visibility="hidden";
		document.all.idint2.style.visibility="hidden";
		document.all.idperiod.style.visibility="hidden";
		document.all.idperiod1.style.visibility="hidden";
		document.all.idperiod2.style.visibility="hidden";
		document.all.idmargin.style.visibility="visible";
		document.all.id_secdisp.innerText="(Securities to be entered in Deposit Details page)";
		if(document.forms[0].hiddeposittype.value=="H"||document.forms[0].hiddeposittype.value=="F")
		{
			document.all.idinttype1.style.visibility="visible";
			document.all.idinttype1.style.position="relative";
			document.all.idinttype2.style.visibility="visible";
			document.all.idinttype2.style.position="relative";

			document.all.idint1.style.visibility="visible";
			document.all.idint1.style.position="relative";
			document.all.idint2.style.visibility="visible";
			document.all.idint2.style.position="relative";
		}
		else if(varOtherDepFlag=="Y" && document.forms[0].hiddeposittype.value=="G")
		{
			document.all.idinttype1.style.visibility="visible";
			document.all.idinttype1.style.position="relative";
			document.all.idinttype2.style.visibility="visible";
			document.all.idinttype2.style.position="relative";

			document.all.idint1.style.visibility="visible";
			document.all.idint1.style.position="relative";
			document.all.idint2.style.visibility="visible";
			document.all.idint2.style.position="relative";
		}
	}
	if(document.forms[0].prd_type.value=="pG")
	{
		document.forms[0].sel_peridicity.value="n";
		document.all.idperiod1.style.visibility="hidden";
		document.all.idperiod1.style.position="absolute";
		document.all.idperiod2.style.visibility="hidden";
		document.all.idperiod2.style.position="absolute";
		document.all.idmargin.style.visibility="visible";
		document.all.id_secdisp.innerText="(Securities to be entered in Gold Ornaments page)";
		
	}
	if(document.forms[0].prd_type.value=="aR")
	{
		document.forms[0].selectinttype.value="1";
		document.forms[0].sel_peridicity.value="n";
		document.forms[0].txtloan_reqterms.value="12";
		//getrepayment();
		document.forms[0].txt_installments.value="0";
	}
	document.all.idperiod.style.visibility="hidden";
	document.all.idperiod.style.position="absolute";
			if(varDocRecvd!="")
			{
				document.forms[0].sel_docreceived.value=varDocRecvd;
			}
			else
			{
				document.forms[0].sel_docreceived.value="0";
			}
			if(varSpecialCust!="")
			{
				document.forms[0].sel_SpecialCust.value=varSpecialCust;
			}
			else
			{
				document.forms[0].sel_SpecialCust.value="N";
			}
	/** To store the value in the "Periodicity of Installments" field*/
	if (installment != "")
	{
		document.forms[0].sel_peridicity.value = installment;
	}
	else 
	{
		document.forms[0].sel_peridicity.value = "m";
	}
	/** For storing the option values based on the value of periodicity of installments*/
	//getrepayment();
	/*To store the value in the "Repayment Type" field*/

	if(varRepayType!="")
	{
		document.forms[0].selrepaymenttype.value=varRepayType;
	}
	else
	{
		document.forms[0].selrepaymenttype.value="0";
	}
	/** To store the value in the "Facility Type" field*/
	if("<%=Helper.correctNull((String)hshValues.get("loan_facility"))%>"=="")
	{
		document.forms[0].sel_facilitytype.value='0';
	}
	else
	{
		document.forms[0].sel_facilitytype.value='<%=Helper.correctNull((String)hshValues.get("loan_facility"))%>';
	}
	displaySpecify();
}


function callCalculateInterest()
{
	var varIntType=document.forms[0].selectinttype.value ;	
	if(varIntType!="" && varIntType !=3 && varIntType !=0 )
	{	
		callCalculate();
	}
}


function doHelp()     
{
	var hlpvar = appURL+"phlp/loan_appretail_apploanproduct.htm";
  	var title = "ApplicantLoanProduct";
  	var prop = "scrollbars=yes,width=600,height=450";	
  	prop = prop + ",left=50,top=150";
  	window.open(hlpvar,title,prop);
}

function showAckSearch()
{		
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = appURL+"action/searchAppinwradno.jsp?hidBeanId=inwardRegister&hidBeanGetMethod=getInwardnoSearchList&Category=p&CBSid="+varcbsid;
		var title = "Acknowledgement";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}	
}

function gototab(beanid,methodname,pagename)
{
	if(document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function getrepayment()
{
	if(document.forms[0].sel_peridicity.value =="m")
	{	
		if(document.forms[0].selectinttype.value=="3")
		{
			document.forms[0].selrepaymenttype.length=2;
			document.forms[0].selrepaymenttype.options[0].value="0";
			document.forms[0].selrepaymenttype.options[0].text="<-------- Select -------->";
			document.forms[0].selrepaymenttype.options[1].value="11";
			document.forms[0].selrepaymenttype.options[1].text="Slab";
		}
		else
		{
			document.forms[0].selrepaymenttype.length=10;
			document.forms[0].selrepaymenttype.options[0].value="0";
			document.forms[0].selrepaymenttype.options[0].text="<-------- Select -------->";
			document.forms[0].selrepaymenttype.options[1].value="1";
			document.forms[0].selrepaymenttype.options[1].text="Equated Monthly Installment";
			document.forms[0].selrepaymenttype.options[2].value="2";
			document.forms[0].selrepaymenttype.options[2].text="Structured Repayment Schedule";
			document.forms[0].selrepaymenttype.options[3].value="3";
			document.forms[0].selrepaymenttype.options[3].text="Graduated installments";
			document.forms[0].selrepaymenttype.options[4].value="4";
			document.forms[0].selrepaymenttype.options[4].text="Step Up";
			document.forms[0].selrepaymenttype.options[5].value="5";
			document.forms[0].selrepaymenttype.options[5].text="Step Down";
			document.forms[0].selrepaymenttype.options[6].value="6";
			document.forms[0].selrepaymenttype.options[6].text="Taper Down";
			document.forms[0].selrepaymenttype.options[7].value="7";
			document.forms[0].selrepaymenttype.options[7].text="Balloon";
			document.forms[0].selrepaymenttype.options[8].value="9";
			document.forms[0].selrepaymenttype.options[8].text="Flip Method";
			document.forms[0].selrepaymenttype.options[9].value="10";
			document.forms[0].selrepaymenttype.options[9].text="Equal Installments";
		}
	}
	else if(document.forms[0].sel_peridicity.value =="q" || document.forms[0].sel_peridicity.value =="h" || document.forms[0].sel_peridicity.value =="y")
	{		
		document.forms[0].selrepaymenttype.length=10;
		document.forms[0].selrepaymenttype.options[0].value="0";
		document.forms[0].selrepaymenttype.options[0].text="<-------- Select -------->";
		document.forms[0].selrepaymenttype.options[1].value="2";
		document.forms[0].selrepaymenttype.options[1].text="Structured Repayment Schedule";
		document.forms[0].selrepaymenttype.options[2].value="3";
		document.forms[0].selrepaymenttype.options[2].text="Graduated installments";
		document.forms[0].selrepaymenttype.options[3].value="4";
		document.forms[0].selrepaymenttype.options[3].text="Step Up";
		document.forms[0].selrepaymenttype.options[4].value="5";
		document.forms[0].selrepaymenttype.options[4].text="Step Down";
		document.forms[0].selrepaymenttype.options[5].value="6";
		document.forms[0].selrepaymenttype.options[5].text="Taper Down";
		document.forms[0].selrepaymenttype.options[6].value="7";
		document.forms[0].selrepaymenttype.options[6].text="Balloon";
		document.forms[0].selrepaymenttype.options[7].value="9";
		document.forms[0].selrepaymenttype.options[7].text="Flip Method";
		document.forms[0].selrepaymenttype.options[8].value="10";
		document.forms[0].selrepaymenttype.options[8].text="Equal Installments";
	}
	else if(document.forms[0].sel_peridicity.value =="n")
	{
		document.forms[0].selrepaymenttype.length=4;
		document.forms[0].selrepaymenttype.options[0].value="0";
		document.forms[0].selrepaymenttype.options[0].text="<-------- Select -------->";
		document.forms[0].selrepaymenttype.options[1].value="12";
		document.forms[0].selrepaymenttype.options[1].text="OverDraft";
		document.forms[0].selrepaymenttype.options[2].value="8";
		document.forms[0].selrepaymenttype.options[2].text="Bullet";
		document.forms[0].selrepaymenttype.options[3].value="14";
		document.forms[0].selrepaymenttype.options[3].text="2 Yearly Equal Installment";
	}
}

function moratperiod()
{
	if(document.forms[0].txt_installments.value=='0')
	{
		document.forms[0].interestservised.value="s"; 
	    document.forms[0].interestservised.disabled=true;	
	}
	else
	{
		var varrepayperiod="";
		var varmoratorium="";
		varrepayperiod=document.forms[0].txtloan_reqterms.value;
		varmoratorium=document.forms[0].txt_installments.value;
		if(eval(varrepayperiod)<=eval(varmoratorium))
		{
			alert("Initial Holiday/Gestation/ Moratorium Period cannot be greater than Repayment Period");
			document.forms[0].txt_installments.value="";
			document.forms[0].txt_installments.focus();
			return false;
		}
		else
		{
			document.forms[0].interestservised.disabled=false;	
		}
	}
	//The following function is called to recalculate the EMI
	callSanc();
}

function selsub()
{
    if(document.forms[0].selectgovt.value == "1")
	 {
    	document.all.s1.style.visibility="visible";
    	document.all.s1.style.position="relative";    		
    	document.all.s2.style.visibility="visible";
    	document.all.s2.style.position="relative";
    	if(varsponseragency=="DRDA")
		{
	    	document.all.s4.style.visibility="hidden";
	    	document.all.s4.style.position="relative";	
	    	document.forms[0].txt_agency.disabled=false;
		}
    	else
    	{
    		document.all.s4.style.visibility="visible";
        	document.all.s4.style.position="relative";
    	}
    	if(document.forms[0].sel_sponser_agency.value=="DRDA")
    	{
    		document.all.s4.style.visibility="hidden";
	    	document.all.s4.style.position="relative";
	    	document.forms[0].txt_agency.disabled=false;
    	}
    }
    else
  	{
    	document.all.s1.style.visibility="hidden";
    	document.all.s1.style.position="absolute";
    	document.all.s2.style.visibility="hidden";
    	document.all.s2.style.position="absolute";
    	document.all.s4.style.visibility="hidden";
    	document.all.s4.style.position="absolute";

   	}
}
function doSearch()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = appURL+"action/devproposal_search.jsp?hidBeanId=perlimitofloan&hidBeanGetMethod=getPermissionPropSearch";   
		var title = "Permission No";
		var prop = "scrollbars=yes,width=650,height=450,menubar=no";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,"PermissionNo",prop);

	}
}
function doPermissionLetter()
{
	var permappno=document.forms[0].dev_prop_no.value;
	var prop = "scrollbars=yes,width=650,height=500,top=25,left=180";
	var url=appURL+"action/permissionletter.jsp?hidBeanId=perDeviation&hidBeanGetMethod=getPermissionLetterData&appno="+permappno;
	window.open(url,"",prop);
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
</SCRIPT>
</head>
<body onload="loadRepaymentType();callOnLoad();disabledvalues();callOnAmtReqstd();selsub();loadInterestType();">
<form name="appform" method="post" class="normal">
<iframe height="0" width="0" id="ifrmrepayment" frameborder="0" style="border: 0"></iframe>
<iframe height="0" width="0" id="ifrm" frameborder="0" style="border:0"></iframe> 
<iframe height="0" width="0" id="ifrm1" frameborder="0" style="border:0"></iframe>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<%if(digiGoldFlag.equals("PJ")){ %>
	<tr>
		<td class="page_flow"> <i>Home -&gt; Digi Loan Against Gold Ornaments &amp; Deposits
		-&gt; Applicant -&gt; Loan Product</i>  </td>
	</tr>
	<%}else{ %>
	<tr>
		<td class="page_flow"> <i>Home -&gt; Loan Against Gold Ornaments &amp; Deposits
		-&gt; Applicant -&gt; Loan Product</i>  </td>
	</tr>
	<%} %>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
	<tr class="applicationheader">
		<td width="14%"> Proposal No :</td>
		<td width="20%">&nbsp;<input type="hidden" name="appno" size="20"
			value="<%=applicationno%>" readonly="readonly"><%=applicationno%></td>
		<td width="14%"> Applicant Name:</td>
		<td width="27%">&nbsp;<input type="hidden" name="appname"
			 size="80" readonly="readonly"
			value="<%=appname%>"><%=appname%> </td>
		<td width="11%"> Status:</td>
		<td width="19%">&nbsp;<input type="hidden" name="appstatus"
			 size="20" readonly="readonly"
			value="<%=appstatus%>"><%=appstatus%>  <input type="hidden"
			name="hidapplicantid" value="<%=applicantid%>"> <input type="hidden"
			name="hidDemoId" value="<%=applicantid%>"> <input type="hidden"
			name="inwardno" value="<%=inwardno%>"> <input type="hidden"
			name="appholder" value="<%=strAppholder%>"> <input type="hidden"
			name="btnenable" value="<%=strbtnenable%>"> <input type="hidden"
			name="applevel" value="<%=applevel%>">
			<input type="hidden" name="strappstatus" size="20" readonly="readonly"	value="<%=strAppstatus%>">
			<input type="hidden" name="hidRepayType" value="<%=Helper.correctNull((String) hshValues
			.get("repaymenttype"))%>">
			<input type="hidden" name="hidapplicantnewid" value="<%=strapplicantNewid%>">
			</td>
			<%if(appstatus.equalsIgnoreCase("Processed/Approved")||appstatus.equalsIgnoreCase("Closed/Approved")){ %>
		<td nowrap="nowrap" width="7%">&nbsp;<b>Whether Send to CBS Done : &nbsp;</b></td>
		<td nowrap="nowrap">&nbsp;<%=strOpenFlag%></td>
		<%} %>
	</tr>
	<tr class="applicationheader">
		<td nowrap="nowrap"><b>Application Holder:</b></td>
		<td nowrap="nowrap">&nbsp;<%=strAppholder%></td>
		<td nowrap="nowrap"><b>App. Recd. from:</b></td>
		<td nowrap="nowrap">&nbsp;<%=strApporgname%></td>
		<td nowrap="nowrap"><b>Application No :</b></td>
		<td nowrap="nowrap">&nbsp;<%=inwardno%></td>
		<%if(appstatus.equalsIgnoreCase("Processed/Approved")||appstatus.equalsIgnoreCase("Closed/Approved")){ %>
		<td nowrap="nowrap" width="7%">&nbsp;<b>Date of Account Opening:</b></td>
		<td nowrap="nowrap">&nbsp;<%=strAccOpenDate %></td>
		<%} %>
	</tr>
	<tr class="applicationheader">
	<td nowrap="nowrap"><b>Sanction / Rejected Reference No:</b></td>
	<td>&nbsp;<%=sanctionrefno%></td>
		<td nowrap="nowrap"><b>CBS Account No:</b>&nbsp;</td>
		<td>&nbsp;<%=strCbsaccno%></td>
		<td nowrap="nowrap"><b>Proposal Type :</b>&nbsp;</td>
		<td>&nbsp;<%=strAppType%></td>
		<%if(appstatus.equalsIgnoreCase("Processed/Approved")||appstatus.equalsIgnoreCase("Closed/Approved")){
			if(!strRevalFlag.equalsIgnoreCase("")){ %>
			<td nowrap="nowrap">&nbsp;<b>Revalidation Status:</b></td>
			<td nowrap="nowrap"><%=strRevalFlag %></td>
			<%}else{%>
				<td nowrap="nowrap" colspan="2">&nbsp;</td>
				<%}} %>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="bottom">
		<table width="93%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="left">
			<tr align="center">
				<td><jsp:include page="../per/applicanttab.jsp" flush="true">
					<jsp:param name="linkid" value="1" />
				</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td>
								<table width="97%" border="0" cellspacing="0" cellpadding="4" class="outertable border1" align="center">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
										<%if(Helper.correctNull((String)hshValues.get("appProposalType")).equalsIgnoreCase("R")){ %>
											<tr>
											<td colspan="3"><span class="mantatory">Existing Proposal No : <%=Helper.correctNull((String)hshValues.get("strParentAppno")) %> [Rs : <%=Helper.correctDouble((String)hshValues.get("strParentSancamt")) %>]</span></td>
											<td colspan="2"><span class="mantatory">Existing CBS Account No : <%=Helper.correctNull((String)hshValues.get("exstrCBSAccNo")) %></span></td>
											</tr>
											<%} %>
											<tr>
												<td width="21%">Application No:<span class="mantatory">*&nbsp;</span></td>
												<td width="4%">&nbsp;</td>
												<td><input type="text" name="txt_appinwardno"
													size="20" maxlength="15" tabindex=""
													onKeyPress="allowInteger(this)"
													value="<%=Helper.correctNull((String)hshValues.get("appinwardno"))%>"
													readOnly="readonly"> 
													<span id="applsearch" onClick="showAckSearch()"
													style="cursor:hand"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" ></span></td>
											<td nowrap="nowrap">Party File No.&nbsp;<input type="text" name="txt_fileNo"
															maxlength="10" tabindex="1" size="10"
															value="<%=Helper.correctNull((String) hshValues
									.get("loan_fileno"))%>">
														&nbsp;&nbsp;Scheme Code</td>
										  <td> 
                                            <input type="text" name="txt_schemecode" 
															size="10"
															value="<%=Helper.correctNull((String)hshValues.get("schemecode"))%>"></td>
											</tr>
											<tr>
												<td nowrap="nowrap" colspan="2">Documents Received from Agriculturist<span class="mantatory">* </span></td>
												<td align="left">
												<select name="sel_docreceived" tabindex="23" onchange="displaySpecify();clearPrdDesc();">
													<option value="0">--Select--</option>
													<option value="1">RTC</option>
													<option value="2">Declaration by Applicant</option>
													<option value="3">Other Agri Documents</option>
													<option value="4">General</option>
												</select></td>
												<td nowrap="nowrap" id="id_lbldocspecify" colspan="2">Specify&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="text" name="txt_specify" size="25" maxlength="30"
													value="<%=Helper.correctNull((String)hshValues.get("loan_docspecify"))%>"></td>
												<td nowrap="nowrap" id="id_txtdocspecify">
												</td>
											</tr>
											<tr>
												<td valign="top" width="21%">Loan Product<font
													color="#FF0000">*</font></td>
												<td valign="top" width="4%">&nbsp;</td>
												<td colspan="4" valign="top"><input type="text"
													name="txtprd_desc" size="120" maxlength="100"
													value="<%=Helper.correctNull((String)hshValues.get("category"))%>-<%=Helper.correctNull((String)hshValues.get("subcategory"))%>-<%=Helper.correctNull((String)hshValues.get("rfrom"))%>-<%=Helper.correctNull((String)hshValues.get("rangeto"))%>-<%=Helper.correctNull((String)hshValues.get("schemecode"))%>-<%=Helper.correctNull((String) hshValues.get("PRD_DESC"))%>">
												<span onClick="checkDocRec();" style="cursor:hand"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="2"></span></td>
											</tr>
											<tr>
												<td width="21%">Amount Requested <span class="mantatory">*&nbsp;</span></td>
												<td width="4%"><%=ApplicationParams.getCurrency()%></td>
												<td width="21%">
												<div align="left"><lapschoice:CurrencyTag
													name="txtloan_amtreqd" maxlength="12"
													value='<%=Helper.correctNull((String)hshValues.get("amtreqd"))%>'
													tabindex="3" size="15"
													onChange="callOnAmtReqstd();getInterestValue();calculateLoanAmount()" /></div>
												</td>

												<td align="left" width="19%" id="idinttype1">Interest Type</td>
												<td width="35%" id="idinttype2">
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0" class="outertable">
													<tr>
														<td><select name="selectinttype"
															onChange="loadInterestType();getInterestValue();disabledvalues()"
															tabindex="4">
															<%if (strIntType.trim().equals("Select")) {%>
															<option value="0" selected="selected">----Select----</option>
															<%} else {%>
															<option value="0">----Select----</option>
															<%}if (strIntType.trim().equals("Fixed")) {%>
															<option value="1" selected="selected">Fixed</option>
															<%} else {%>
															<option value="1">Fixed</option>
															<%}if (strIntType.trim().equals("Floating")) {%>
															<option value="2" selected="selected">Floating</option>
															<%} else {%>
															<option value="2">Floating</option>
															<%}%>
														</select></td>
														<td id="sel1"><input type="hidden" name="sel_steptype"
															value="1" /></td>
													</tr>
												</table>
												</td>
											</tr>
											<tr>
											<td id="idmclr1" nowrap="nowrap"> Reference Type</td>
											<td>&nbsp;</td>	
														<td id="idmclr2" style="visibility: visible" ><select
															name="sel_mclrtype" onchange="getInterestValue();callIntcalcmode();disabledvalues();">
															<option value=""><--select--></option>
															<%if(appstatus.equalsIgnoreCase("Open/Pending") || appstatus.equalsIgnoreCase("")){ %>
															<lapschoice:MCLRTag/>
															<%}else{ %>
															<option value="<%=strOption%>"><%=strDescription%></option>
															<%} %>
														</select></td>
											<td id="idint3" nowrap="nowrap"> ROI Type</td>
											<td id="idint4"><select name="sel_interesttype" onchange="getInterestValue();callIntcalcmode();disabledvalues();">
												</select></td>
											</tr>
											<tr>
												<td width="21%">Security Value<span class="mantatory">*</span></td>
												<td width="4%"><%=ApplicationParams.getCurrency()%></td>
												<td width="21%"><lapschoice:CurrencyTag
													name="txtloan_costloanprd" size="15" maxlength="12" other="readOnly"
													value='<%=Helper.correctNull((String)hshValues.get("cloanprd"))%>'
													onChange="calculateLoanAmount();getInterestValue();callOnAmtReqstd();"
													tabindex="6"/></td>

												<td align="left" width="19%" id="idint1">Interest Rate Defined p.a. %</td>
												<td valign="top" width="35%" id="idint2">
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0" class="outertable">
													<tr>
														<td width="19%"><lapschoice:CurrencyTag
															name="txtloan_intrate" size="8"
															value='<%=Helper.correctDouble((String)hshValues.get("loan_intrate"))%>' /></td>
														<td width="15%">Modified&nbsp;</td>
														<td width="15%"><lapschoice:CurrencyTag
															name="txtloan_modintrate" size="8" maxlength="5"
															other="readOnly"
															value='<%=Helper.correctDouble((String)hshValues.get("mintrate"))%>' />
														</td>
														<td width="51%" nowrap="nowrap">p.a %</td>
													</tr>
												</table>
												</td>
											</tr>

											<tr id="idperiod">
												<td>Initial Holiday/Gestation/ Moratorium Period (in Months)</td>
												<td>&nbsp;</td>
												<td valign="top"><input type="text" name="txt_installments"
													size="5" onBlur="moratperiod()" maxlength="3"
													value="<%=Helper.correctNull((String)hshValues.get("loan_noofinstallment"))%>"
													onKeyPress="allowNumber(document.forms[0].txt_installments)"
													tabindex="9"></td>
												<td width="19%">Repayment Period (in months)<span class="mantatory">*&nbsp;</span></td>
												<td width="35%" align="left"><input type="text"
													name="txtloan_reqterms" size="10" style="text-align:right"
													value="<%=Helper.correctNull((String)hshValues.get("lreqterms"))%>"
													onKeyPress="allowNumber(document.forms[0].txtloan_reqterms)"
													onblur="getInterestValue()" maxlength="3" tabindex="10"></td>
											</tr>
											<tr>
												<input type="hidden" name="sel_facilitytype" value="0">
												<td id="idperiod1" colspan="2">Periodicity of Installments <span class="mantatory">* </span></td>
												<td width="15%" id="idperiod2"><select name="sel_peridicity"
													onChange="interestselect();" tabindex="14">
													<option value="s" selected="selected">Select</option>
													<option value="m" selected="selected">Monthly</option>
													<option value="q">Quarterly</option>
													<option value="h">Half-Yearly</option>
													<option value="y">Yearly</option>
													<option value="n">Not Applicable</option>
												</select></td>
											</tr>
											<tr>
												<td colspan="4"><span class="mantatory" id="id_secdisp">&nbsp;</span></td>
											</tr>

											<tr>
												
												<td>Purpose of Loan <span class="mantatory">*&nbsp;</span></td>
												<td>&nbsp;</td>
												<td colspan="2"><textarea name="txtloan_purposeofloan" 
                                                    onKeyPress="textlimit(this,1999)" 
                                                    onKeyUp="textlimit(this,1999)"
													cols="90" rows="5" tabindex="21"><%=Helper.correctNull((String) hshValues
												.get("loanpurposeofloan"))%></textarea>
												</td>
											</tr>											
											<tr id="idmargin">
												<td>Minimum Margin</td>
												<td><%=ApplicationParams.getCurrency()%></td>
												<td><lapschoice:CurrencyTag name="txtloan_downpay" size="15"
													maxlength="12" other="readOnly"
													value='<%=Helper.correctNull((String)hshValues.get("downpay"))%>' /></td>
												<td>Minimum Margin Percent</td>
												<td>
												<lapschoice:CurrencyTag name="txtMarginpercent"
													size="5"
													value='<%=Helper.correctNull((String)hshValues.get("margin_perct"))%>'
													other="readonly" /> (% ) </td>
											</tr>
											<tr>
												<td colspan="2">Special Customer</td>
												<td>
													<select name="sel_SpecialCust">
														<option value="Y">Yes</option>
														<option value="N" selected="selected">No</option>
													</select>
												</td>
												<td>Processing Fee (Excluding TAX)&nbsp;</td>
												<%if(strStaff.equalsIgnoreCase("02")) { %>
													<td><input type="hidden" name="txtloan_procfee" value="">
													<b><span class="mantatory">Waived&nbsp;</span></b></td>
												<%} else { %>
												<td><b> <lapschoice:CurrencyTag
													name="txtloan_procfee" size="15" other="readOnly"
													value='<%=Helper.correctNull((String)hshValues.get("procfee"))%>' /></b></td>
												<%} %>
													
											</tr>
											<tr>
												<td nowrap="nowrap" width="21%">Margin Offered by Borrower</td>
												<td width="3%"><%=ApplicationParams.getCurrency()%></td>
												<td> <lapschoice:CurrencyTag
													name="txtmarginoffered" size="15" maxlength="12"
													other="readOnly"
													value='<%=Helper.correctNull((String)hshValues.get("offeredmargin"))%>' />
												</td>
												<td nowrap="nowrap">Repayment Type <span class="mantatory">* </span></td>
												<td align="left"><select name="selrepaymenttype"
													onChange="showRepayment();" tabindex="22">
												</select></td>
											</tr>
											<!-- Added by Arsath on 01/08/2013 given by Prakash -->											
											<tr>
											<td>Govt. Sponsor Scheme <span class="mantatory">*&nbsp;</span></td>
											<td>&nbsp;</td>
											<td colspan="2"><select name="selectgovt"
											onChange="selsub();" tabindex="16">
											<option value="">--Select--</option>
											<option value="1">Yes</option>
											<option value="2">No</option>
											</select></td>
											</tr>
											<tr id="s1">											
											<td>Scheme Type</td>
											<td>&nbsp;</td>
											<td valign="middle"><select name="schemetype" tabindex="17" STYLE="width:180px;">
											<option value="0">---select---</option>
											<lapschoice:StaticDataTag apptype="11"  tagType="<%=strAppstatus%>"/>
											</select> </td>											
											<td>Sponsor Agency</td>
											<td>
											<select name="sel_sponser_agency" tabindex="19">
											<option value="0">--Select--</option>
											<%
											String apptype = "3";
											%>
											<lapschoice:StaticDataTag apptype='<%=apptype%>' />
											</select>
											</td>																	
											</tr>
											<tr id="s2">											
											<td>Subsidy type</td>
											<td>&nbsp;</td>
											<td valign="middle"><select name="sel_subsidytype" tabindex="20">
											<option value="0">--Select--</option>
											<%
											apptype = "5";
											%>
											<lapschoice:StaticDataTag apptype='<%=apptype%>' />
											</select></td>											
											<td>Subsidy Amount</td>
											<td>
											<lapschoice:CurrencyTag name="sub"
											size="20" maxlength="10" onBlur="checkamt()"
											value='<%=Helper.correctNull((String)hshValues.get("loan_sub"))%>' tabindex="18"/> </td>							
											</tr>	
											<tr id="s4">
												<td colspan="2" nowrap="nowrap">Name of the agency</td>
												<td><input type="text" name="txt_agency"
													size="20" maxlength="10"
													value='<%=Helper.correctNull((String)hshValues.get("AGENCYNAME"))%>'
													tabindex="18" /></td>
													
													
											</tr>
											
																					
											<!-- End -->
											<tr>
												<td width="21%"><input type="hidden" name="interestservised"
													value="s" /> <input type="hidden" name="sel_interestcharge"
													value="1" /> <input type="hidden" name="selectgovt1"
													value="2" /> <input type="hidden" name="schemetype1"
													value="0" /> <input type="hidden" name="sub1" value="0" /> <input
													type="hidden" name="sel_sponser_agency1" value="0" /> <input
													type="hidden" name="sel_subsidytype1" value="0" /> <input
													type="hidden" name="txt_repaycapacity"
													value='<%=Helper.correctNull((String)hshValues.get("loan_repaycapacity"))%>'>
												 
												<input type="hidden" name="txtmonPay"
													value='<%=Helper.correctNull((String)hshValues.get("monthpay"))%>' />
												<input type="hidden" name="txtloan_sancamt"
													value="<%=Loanamt%>" /> <input type="hidden"
													name="txtloan_docfee"
													value='<%=Helper.correctNull((String)hshValues.get("docfee"))%>' />
												<input type="hidden" name="txtloan_recmdamt" size="15"
													value='<%=Helper.correctNull((String)hshValues.get("ramount"))%>' />
												<input type="hidden" name="sel_secured" value="s" /> <input
													type="hidden" name="txt_secured" value="0.0" /> <!--<input
													type="hidden" name="selmodepayment" value="N" /> -->
												<input type="hidden" name="measurementtype" value="c" /> <span
													id="calc1"></span> <span id="calc2"></span> <span
													id="amort1"></span> <span id="amort2"></span> <span
													id="interestEMI1"></span> <span id="interestEMI2"></span> <span
													id="interestEMI3"></span> <span id="Measurementtype1"></span>
													<input type="hidden" name="amort">
												</td>
												<td width="4%">&nbsp;</td>
											</tr>
											<tr class=""> 
								      			<td width="20%">Permission Proposal No</td>&nbsp;
								      			<td width="10%" colspan="8"><input type="text" name="dev_prop_no" size="12" readOnly="readonly" value="<%=Helper.correctNull((String)hshValues.get("APP_PERM_NO"))%>"> 
								      				<b><a id="id_permsearch"> <span onClick="doSearch()" style="cursor: hand"><img
															src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
															border="0" tabindex=""></span></a></b>
												&nbsp;&nbsp;&nbsp;&nbsp; <a id="id_permLetter"><span onClick="doPermissionLetter()" style="cursor: hand"> Permission Letter</span></a> 
												&nbsp;&nbsp; <img id="deattach" alt="De-attach" src="<%=ApplicationParams.getAppUrl()%>img/delete.png" onclick="doRemove()" style="cursor:hand"/>&nbsp;
												</td>
												
								          
								          </tr>
								          
								          
								          <tr class=""> 
												
								          <%if(modofpaymentflag.equalsIgnoreCase("EOP") || modofpaymentflag.equalsIgnoreCase("NEW"))    // new application created on live date or  after live date,Mode of Payment has to come,NEW - New one
													{%>
								        
								          
								        
													<td>Mode of Payment<b><span class="mantatory">*&nbsp;</span></b></td>
												<td ><select name="selmodepayment"
													tabindex="24" onChange="selOperative(this)"
													onBlur="validateAccno()">
													<option value="0" selected="selected">&lt;----Select----&gt;</option>
													<!-- <option value="S">Recover From Salary</option>
													<option value="P">Post Dated Cheque</option>
													<option value="E" >Transfer from Saving/Current a/c</option>
													<option value="D">Electronic Cheque Clearing(ECS)</option>
													<option value="N">Cash Recovery</option> -->
													<lapschoice:StaticDataNewTag apptype="217" />
												</select></td>
												
								          
								          <td>&nbsp;</td>
											<td align="left" id="opnolabel">Operative Account Number</td>
												<td id="opnovalue"><input type="text"
													name="txt_operativeaccno" id="opaccno" onKeyPress="allowInteger(this)" onBlur="ValidateOpearativeAcc()"
													value="<%=Helper.correctNull((String) hshValues
							.get("loan_operativeaccno"))%>"
													disabled="disabled" maxlength="16"></td>
													 <% }%>
								          </tr>
								         
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>

							<tr>
								<td>
								<table width="97%" border="0" cellspacing="0" cellpadding="4" class="outertable border1"
									align="center">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
											<tr>
												<td colspan="5">
												<table width="100%" border="0" cellspacing="0"
													cellpadding="2" class="outertable">
													<tr>
														<td width="22%"><font color="#CC0000">Application Received
														on * </font>(dd/mm/yyyy)</td>
														<td width="24%">
														<table border="0" width="20%" cellspacing="0"
															cellpadding="3" class="outertable">
															<tr>
																<td><input type="text" name="txt_receivedRH" size="11"
																	value="<%=Helper.correctNull((String)hshValues.get("loan_receivedate"))%>"
																	onBlur="checkDate(this);checkmaxdate(this,currentDate)"
																	maxlength="12"></td>
																<%--<td><a alt="Select date from calender" href="#"
																	onClick="callCalender('txt_receivedRH')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border="0" alt="Select date from calender" tabindex="29"></a></td> --%>
															</tr>
														</table>
														</td>
														<td width="16%"><font color="#CC0000">Processed On </font><font
															color="#FF0000">*</font> (dd/mm/yyyy)</td>
														<td width="38%">
														<table border="0" width="30%" cellspacing="0"
															cellpadding="3" class="outertable">
															<tr>
																<td><%String strDateprocessed = "";
			if (Helper.correctNull((String) hshValues.get("loanfiledon"))
					.equalsIgnoreCase("")) {
				strDateprocessed = Helper.getCurrentDateTime();
			} else
				strDateprocessed = Helper.correctNull((String) hshValues
						.get("loanfiledon"));

			%> <input type="text" name="txtloan_filedon" size="11"
																	value="<%=strDateprocessed%>"
																	onBlur="checkDate(this);checkval(document.forms[0].txtloan_filedon.value)"
																	maxlength="12"></td>
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
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'
	btnnames='Edit_Save_Cancel_Delete_Audit Trail' /> 
<lapschoice:hiddentag  pageid="<%=PageId%>"/> 
<INPUT TYPE="hidden" name="hidProductID" value="<%=Helper.correctNull((String)hshValues.get("prdcode"))%>"> 
<INPUT TYPE="hidden" name="page1" value="<%=Helper.correctNull((String)hshValues.get("page"))%>"> 
<INPUT TYPE="hidden" name="hidAppType"> 
<INPUT TYPE="hidden" name="radLoan"> 
<INPUT TYPE="hidden" name="hidpurpose"> 
<input type="hidden" name="radLoan1" value=""> 
<input type="hidden" name="orgscode" value="<%=Helper.correctNull((String)session.getAttribute("strOrgShortCode"))%>">
<input type="hidden" name="orgcode" value="<%=Helper.correctNull((String)session.getAttribute("strOrgCode"))%>">
<input type="hidden" name="orglevel" value="<%=Helper.correctNull((String)session.getAttribute("strOrgLevel"))%>">
<input type="hidden" name="grouprights" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights"))%>">
<input type="hidden" name="hidStaffFlag" value="<%=Helper.correctNull((String)hshValues.get("staff_flag"))%>"> 
<input type="hidden" name="hidServiceLeft" value="<%=employeeretirementage%>">
<input type="hidden" name="prdid1" value=""> <input type="hidden"
	name="prd_type" value="<%=strProductType%>"> <input type="hidden"
	name="hidrepayment" value="12"> <input type="hidden"
	name="hidPrincipalRatio"
	value="<%=Helper.correctNull((String)hshValues.get("PrincipalRatio"))%>">
<input type="hidden" name="hidInterestRatio"
	value="<%=Helper.correctNull((String)hshValues.get("InterestRatio"))%>">
<input type="hidden" name="hidStaffProduct"
	value="<%=Helper.correctNull((String)hshValues.get("staffproduct"))%>">
<input type="hidden" name="repayperiod"
	value="<%=Helper.correctNull((String) hshValues.get("maxterms")) %>"> <INPUT
	TYPE="hidden" name="hidApploanType" value=""> <input type="hidden"
	name="hidrangefrom"> <input type="hidden" name="hidrangeto" value=""> <input
	type="hidden" name="hidserviceamount"> <input type="hidden"
	name="hidexserviceyear"
	value="<%=Helper.correctNull((String)hshValues.get("perapp_exserviceyear"))%>">
<input type="hidden" name="hidyearsinbuss"
	value="<%=Helper.correctNull((String)hshValues.get("peremp_yearsinbuss"))%>">
<input type="hidden" name="hidtotalyear"> <input type="hidden"
	name="hidminservice"> <input type="hidden" name="hidmaxservice"> <input
	type="hidden" name="hidselexservice"
	value="<%=Helper.correctNull((String)hshValues.get("perapp_selexservice"))%>">
<input type="hidden" name="hidinteresttype" value="Select"> <input
	type="hidden" name="hidinterest"
	value="<%=Helper.correctNull((String)hshValues.get("loaninttype"))%>">
<input type="hidden" name="hidifrminterestrates"
	value="<%=Helper.correctNull((String)hshValues.get("strslabintrate"))%>">
<input type="hidden" name="hidifrmtoamt"
	value="<%=Helper.correctNull((String)hshValues.get("strslabtoamt"))%>">
<input type="hidden" name="hidifrminteresttype">
<input type="hidden" name="minterm">
<input type="hidden" name="sel_intcalcmode">
<input type="hidden" name="comappid" value= "<%=Helper.correctNull((String) hshValues.get("hidapplicantid"))%>">
<INPUT TYPE="hidden" name="hidDeleteDeviationFlag">
<INPUT TYPE="hidden" name="hidOldProductCode" value="<%=Helper.correctNull((String) hshValues.get("prdcode"))%>">
<INPUT TYPE="hidden" name="hidEmployment" value="<%=Helper.correctNull((String) hshValues.get("perapp_employment"))%>">
<input type="hidden" name="hidInterestIndexId" value="<%=Helper.correctNull((String) hshValues.get("loan_interestid"))%>">
<input type="hidden" name="hidBaserate" value="<%=Helper.correctNull((String) hshValues.get("loan_baserate"))%>">
<input type="hidden" name="hidHoliday" value="<%=Helper.correctInt((String)hshValues.get("prd_holiday"))%>">
<input type="hidden" name="hidmortflag" value="N"  id="costproject1">
<input type="hidden" name="hidstaff_under" value=""  id="costproject2">
<input type="hidden" name="sel_take_over" value=""  id="costproject3">
<input type="hidden" name="hidPrdFlag"  value=""  id="costproject4">
<input type="hidden" name="hidPrincipalRepay"  id="costproject5">
<input	type="hidden" name="apploantype" value="<%=loanType%>">
<input type="hidden" name="hidtakeoveravail" value="<%=Helper.correctNull((String) hshValues.get("TakeOverAvailFlag"))%>">
<input type="hidden" name="hidcreditrskpremium" value="<%=Helper.correctNull((String) hshValues.get("loan_creditrskval"))%>">
<input type="hidden" name="hidbusstrategicpremium" value="<%=Helper.correctNull((String) hshValues.get("loan_busstatval"))%>">
<input type="hidden" name="hidMCLRTableCode" value="<%=Helper.correctNull((String) hshValues.get("loan_mclrtabcode"))%>">
<input type="hidden" name="hiddeposittype" value="<%=Helper.correctNull((String) hshValues.get("prd_deposittype"))%>">
<input type="hidden" name="hiddepsitloanfor" value="<%=Helper.correctNull((String) hshValues.get("prd_depositloanfor"))%>">
<input type="hidden" name="hidInterestRepay">
<input type="hidden" name="hidprdbankscheme" value="<%=Helper.correctNull((String) hshValues.get("strprdbankscheme"))%>">
<input type="hidden" name="hidNSDLFlag" id="idnsdl1">
<input type="hidden" name="hidNSDLRefNo" value="" id="idnsdl2"> 
<input type="hidden" name="hidinwardAmt" value="<%=Helper.correctDouble((String)hshValues.get("strInwardReqAmt")) %>">
<input type="hidden" name="hidLARbankscheme" value="<%=Helper.correctNull((String) hshValues.get("strLARbankscheme"))%>">
<input type="hidden" name=hidPrdReselectFlag value="<%=Helper.correctNull((String)hshValues.get("strReselectprd"))%>">
<input type="hidden" name="hidODFlag" value="<%=strPrdLoanType %>">
<input type="hidden" name="hidPMAYDet" value="<%=Helper.correctNull((String) hshValues.get("strPMAYDet"))%>">
<input type="hidden" name="hidAppCGStatus">
<input type="hidden" name="hidCIBILDet" value="<%=Helper.correctNull((String) hshValues.get("strCIBILDetails"))%>">
<input type="hidden" name="hidCRIFDet" value="<%=Helper.correctNull((String) hshValues.get("strCRIFDetails"))%>">
<iframe height="0" width="0" id="ifrminterest" frameborder="0" style="border: 0"></iframe>
<input type="hidden" name="hidScore" value="<%=Helper.correctNull((String)hshValues.get("loan_roiscore")) %>">
<input type="hidden" name="hidOtherDepFlag" value="<%=Helper.correctNull((String)hshValues.get("strOtherDepFlag")) %>">
<input type="hidden" name="hidCRP" value="<%=Helper.correctNull((String) hshValues.get("loan_crp"))%>">
<input type="hidden" name="hidBSP" value="<%=Helper.correctNull((String) hshValues.get("loan_bsp"))%>">
<input type="hidden" name="hiddeviated_amount" value="">
<input type="hidden" name="hidoperativeacc" value="<%=Helper.correctNull((String) hshValues.get("loan_operativeaccno"))%>">
<iframe height="0" width="0" id="ifrmcheckduplicate" frameborder="0"	style="border: 0"></iframe>

<input type="hidden" name="freezeflag" value="N"> <!--pan check -->
<input type="hidden" name="ExposureChklimit" value=""> <!--pan check -->
<input type="hidden" name="Explimitchk" value=""> <!--pan check -->
<input type="hidden" name="varPancount" value="Y"> <!--pan check -->
<input type="hidden" name="varPanCheck" value="N"> <!--pan check -->
<input type="hidden" name="ExposureChklimitagr" value=""> <!--pan check -->
<input type="hidden" name="Explimitagrchk" value=""> <!--pan check -->
<input type="hidden" name="Expmainactcheck" value=""> <!--pan check -->
<input type="hidden" name="Expcheck" value=""> <!--pan check -->
<input type="hidden" name="sessionmodule" value="<%=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim()%>"> 

</form>
</body>
</html>
