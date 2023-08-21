<%@include file="../share/directives.jsp"%>
<%
	String nfiles = "";
	String type = "";
	String goodfile = "";
	String badfile = "";
	String badrow = "";
	String ramdetails = "N";

	HashMap hshRam = new HashMap();
	hshRam = (HashMap) hshValues.get("hshram");
	if (hshRam != null) {
		nfiles = Helper.correctNull((String) hshRam.get("nofiles"));
		type = Helper.correctNull((String) hshRam.get("type"));
		goodfile = Helper.correctNull((String) hshRam.get("goodfile"));
		badfile = Helper.correctNull((String) hshRam.get("badfile"));
		badrow = Helper.correctNull((String) hshRam.get("badrow"));
		ramdetails = Helper.correctNull((String) hshRam.get("ram"));
	}

	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMinimumFractionDigits(2);
	nf.setMaximumFractionDigits(2);
	nf.setGroupingUsed(false);

	String prd_loantype = Helper.correctNull((String) hshValues.get("prd_loantype"));
	String bstate = Helper.correctNull((String) hshValues.get("bstate"));
	String prd_type = Helper.correctNull((String) session.getAttribute("strProductType"));
	String strorgcode = Helper.correctNull((String) session.getAttribute("strOrgCode"));
	String strStaffFlag = Helper.correctNull((String) hshValues.get("StaffFlag"));
	String strStaffProduct = Helper.correctNull((String) hshValues.get("staffproduct"));
	String strHomeplusProduct = Helper.correctNull((String) hshValues.get("homeplusproduct"));
	String strPrincipalRatio = Helper.correctNull((String) hshValues.get("PrincipalRatio"));
	String strInterestRatio = Helper.correctNull((String) hshValues.get("InterestRatio"));
	String strInterestEMI = Helper.correctNull((String) hshValues.get("InterestEMI"));
	String strloan_filedon = Helper.correctNull((String) hshValues.get("loan_filedon"));
	String rating_score = Helper.correctNull((String) hshValues.get("rating_score"));
	String strScorePattern = Helper.correctNull((String) hshValues.get("scorepattern"));
	String comappid = Helper.correctNull((String) session.getAttribute("comappid"));
	String appno = Helper.correctNull((String) session.getAttribute("strappno"));
	String prdcode = Helper.correctNull((String) session.getAttribute("prdcode"));
	if(prd_loantype.equalsIgnoreCase(""))
		prd_loantype=Helper.correctNull((String)session.getAttribute("schemeCode"));
	String mortFlag="N";
	if((prd_type.equals("pM")||prd_type.equals("pI")) || prd_loantype.equals("OD"))
		mortFlag="Y";
	String staff_under=Helper.correctNull((String)hshValues.get("staff_under"));
	String strSanBranch=Helper.correctNull((String) hshValues.get("APPRAISAL_BRANCH"));
	String strMisDetailsCheck=Helper.correctNull((String) hshValues.get("MisDetails_check"));
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	String orglevel=Helper.correctNull((String)hshValues.get("strAppCreatedOrg"));
	String strConcession=Helper.correctNull((String)hshValues.get("DIGI_DEVIATION_ROI_CONC"));
	String strPenalty=Helper.correctNull((String)hshValues.get("DIGI_DEVIATION_ROI_PENALTY"));
	String appstatus=Helper.correctNull((String)request.getParameter("appstatus"));
	if(appstatus!=null){
		appstatus=Helper.correctNull((String) hshValues.get("app_status"));
		session.setAttribute("strappstatus",appstatus);
		if(appstatus.equalsIgnoreCase("op"))
		{
			appstatus = "Open/Pending";
		}
		else if(appstatus.equalsIgnoreCase("pa"))
		{
			appstatus = "Processed/Approved";
		}
		else if(appstatus.equalsIgnoreCase("pr"))
		{
			appstatus = "Processed/Rejected";
		}
		else if(appstatus.equalsIgnoreCase("ca"))
		{
			appstatus = "Closed/Approved";
		}
		else if(appstatus.equalsIgnoreCase("cr"))
		{
			appstatus = "Closed/Rejected";
		}
	}
	/*
	ArrayList arrCol = new ArrayList();
	ArrayList arrROI = new ArrayList();
	arrROI= (ArrayList) hshValues.get("arrROI");
	String strRoi="";

if(strStaffProduct.equalsIgnoreCase("Y")){ 
							if(prd_type.equalsIgnoreCase("pH"))
							{
								if(arrROI!=null && arrROI.size()>0)
								{
									for(int s=0;s<arrROI.size();s++)
									{		
										 arrCol=(ArrayList)arrROI.get(s);
										String  strRoiArr= String.valueOf(Double.parseDouble(Helper.correctDouble((String)arrCol.get(0)))+"-"+ Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))+ " in "+ String.valueOf(Helper.correctDouble((String)arrCol.get(2)))+"%"+"\n"; 
										 strRoi=strRoi+strRoiArr;
									}
								}
								else
								{
								strRoi=	 String.valueOf(Helper.correctDouble((String)hshValues.get("ROI")))+"%";
								}
							}
							else
							{ 
							strRoi= String.valueOf(Double.parseDouble(Helper.correctDouble((String)hshValues.get("strIntType")))+"-"+Double.parseDouble(Helper.correctDouble((String)hshValues.get("ROI"))))+"%";
							}
							}else{ 
						
					strRoi=	String.valueOf(Helper.correctDouble((String)hshValues.get("ROI")))+"%";
	}	
	*/
	
%>
<html>
<head>
<title>Appraisal - LoanDetails</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript">
var curdate = "<%=Helper.getCurrentDateTime()%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varpageid="<%=Helper.correctNull((String) hshValues.get("PageId"))%>";
var editlockflag="<%=hshValues.get("editlock")%>";
var bstate ="<%=bstate%>";
var prd_type="<%=prd_type%>";
var varPRDPURPOSE="<%=Helper.correctNull((String) hshValues.get("strPRDPURPOSE"))%>";
var currentDate= "<%=Helper.getCurrentDateTime()%>";
var strloan_filedon="<%=strloan_filedon%>";
var status="<%=Helper.correctNull((String) hshValues.get("app_status"))%>";
var eli_amt="<%=Helper.correctNull((String) hshValues.get("eligible_amt"))%>";
var rating="<%=rating_score%>";
var flagchk="<%=Helper.correctNull((String) hshValues.get("SENT_FLAG"))%>";
var propertyflagchk="<%=Helper.correctNull((String) hshValues.get("PROPERTY_FLAG"))%>";
var readflagchk="<%=Helper.correctNull((String) hshValues.get("READSENT_FLAG"))%>";
var nfiles="<%=nfiles%>";
var type="<%=type%>";
var goodfile="<%=goodfile%>";
var badfile="<%=badfile%>";
var badrow="<%=badrow%>";
var ramdetails="<%=ramdetails%>";
var stafflag="<%=strStaffFlag%>"
var staffproduct="<%=strStaffProduct%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var mortFlag = "<%=mortFlag %>";
var varstaff_under="<%=staff_under%>";
var varInterestCharged="<%=Helper.correctNull((String) hshValues.get("loan_interestcharged"))%>";
var varInterestHoliday="<%=Helper.correctNull((String) hshValues.get("loan_servised"))%>";
var moratorium="<%=Helper.correctInt((String)hshValues.get("loan_noofinstallment"))%>";
var varIntCalculated="<%=Helper.correctNull((String)hshValues.get("loan_intcalcmode"))%>";
var varAppType="<%=Helper.correctNull((String)session.getAttribute("strAppType"))%>";
var varProdPurpose="<%=Helper.correctNull((String)hshValues.get("strProdPurpose"))%>";
var varloanRepayment="<%=Helper.correctNull((String)hshValues.get("loan_repaymenttype"))%>";
var interest = "<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("mintrate"))))%>";
var varterm = "<%=Helper.correctInt((String) hshValues.get("lreqterms"))%>";
var eduDetails="<%=Helper.correctNull((String) hshValues.get("eduDetails"))%>";
var strVehDetails="<%=Helper.correctNull((String) hshValues.get("strVehDetails"))%>";
var varsanbranch="<%=strSanBranch%>";
var varVerifyWithCFR="<%=Helper.correctInt((String) hshValues.get("loan_VerifyWithCFR"))%>";
var varNamApprCFR="<%=Helper.correctInt((String) hshValues.get("loan_NamApprCFR"))%>";

var varStaVeri="<%=Helper.correctInt((String) hshValues.get("status_verified1"))%>";
var varDDRAppFlag="<%=Helper.correctInt((String) hshValues.get("strDDRAppFlag"))%>";
var varDDRGeneralInfo="<%=Helper.correctInt((String) hshValues.get("strDDRGeneralInfo"))%>";
var varCersaiCheck="<%=Helper.correctNull((String) hshValues.get("LOAN_CERSAI_CHECK"))%>";
var varTermflag="<%=Helper.correctNull((String) hshValues.get("app_termflag"))%>";
var varorglevel="<%=orglevel%>";
var strSessionModuleType="<%=strSessionModuleType%>";
var strRecFacility="<%=Helper.correctNull((String) hshValues.get("recalculate_facility"))%>";

var varloan_costloanprd="<%=Helper.correctInt((String) hshValues.get("loan_costloanprd"))%>";
var varper_margin_total_fund="<%=Helper.correctInt((String) hshValues.get("per_margin_total_fund"))%>";
var varSanctionAuth="<%=Helper.correctNull((String) hshValues.get("appraisal_sancauth"))%>";
var appstatus="<%=appstatus%>";
//Method for calling the RAM TO LAPS 


function createFlatFile(ARG)
{
	if(confirm("Send Loan Details to IRB ?"))
	{
	document.forms[0].hidAction.value="WRITE SCORING";	
	document.forms[0].hidBeanId.value="LapsToRam";
	if(ARG=="RET-EDU")
	{
		document.forms[0].hidPROD.value="EDU";
	}
	if(ARG=="RET-CUS")
	{
	document.forms[0].hidPROD.value="CUS";
	}
	document.forms[0].hidBeanGetMethod.value="getloandetails";
	document.forms[0].action=appUrl+"action/loandetails.jsp";
	document.forms[0].submit();
	}
}

function ShowReport(page)
{
	var appno = document.forms[0].appno.value;
	var url = "<%=ApplicationParams.getAppUrl()%>action/"+page+"?appno="+appno;
	var title = "PrintFairReport";
	var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}

function callappHomeloan()
{
	var appno = document.forms[0].appno.value;
	var comappid = document.forms[0].hidapplicantid.value;
	var strOrgCode="<%=strorgcode%>";
	var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
	var title = "PrintFairReport";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	var url=appUrl+"action/retailprocessnotegeneral.jsp?hidBeanId=documentresults&hidBeanGetMethod=getData&appno="+appno+"&comappid="+comappid;
	window.open(url,title,prop);	
}

 /*function showprocessnote(page)
  {
	var com_appno = document.forms[0].hidAppNo.value;
	var url = "<%//=ApplicationParams.getAppUrl()%>action/"+page+"?hidBeanId=documentresults&hidBeanGetMethod=getData&appno="+com_appno;
	var title = "FairReport";
	var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
  }*/
  
function showprocessnote(page)
{
	  if(varTermflag=="Y")
	  {
			alert("Changes made in Terms & Conditions. \n Kindly revisit and select appropriate conditions for the proposal.");
			return;
	  }
	  if(document.forms[0].sel_amount.value=="S")
	  {
		  alert("Select Amount to be shown in");
		  return;
	  }
	var appno = document.forms[0].appno.value;
	var comappid = document.forms[0].hidapplicantnewid.value;
	var strOrgCode="<%=strorgcode%>";
	var prop = "scrollbars=yes,width=850,height=550,menubar=yes";
	var title = "PrintFairReport";
	var xpos = 100;
	var ypos = 55;
	prop = prop + ",left="+xpos+",top="+ypos;
	var url=appUrl+"action/"+page+"?hidBeanId=documentresults&hidBeanGetMethod=getRetailProcessNote&appno="+appno+"&comappid="+comappid+"&strAmountVal="+document.forms[0].sel_amount.value;
	window.open(url,title,prop);
}

function callappGoldloan()
{
	var appno=document.forms[0].appno.value;
	var title = "Gold_ornaments_appraiser_print";
	var purl="<%=ApplicationParams.getAppUrl()%>action/agr_goldprint.jsp?hidBeanGetMethod=getgolddetailsprint&hidBeanId=agrotherassets&appno="+appno;
	prop='scrollbars=yes,menubar=yes,width=750,height=520';
	xpos=(screen.width-750)/2;
	ypos=(screen.height-520)/2;
	prop=prop+",xpos="+xpos+",ypos="+ypos;
	window.open(purl,title,prop);
}

function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].value="";		  
		}
		else if (document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].value="0";	
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
}

function callCalender1()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appUrl,'appraisaldate');
	}
}
function callCalender2()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appUrl,'sanctiondate');
	}
}

function callCalender(name) {

	if (document.forms[0].cmdsave.disabled == false) {

		showCal(appURL, name);
	}
}	
function disablefields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=true;
			if(document.forms[0].elements[i].name=="txt_inspremiumamt")
				document.forms[0].elements[i].readOnly=val;
			if(document.forms[0].elements[i].name=="txt_CFRdev_refno")
				document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}		
	}
	document.forms[0].appraisedby.readOnly=true;
	document.forms[0].txt_sanction_amount.readOnly=val;
	document.forms[0].txt_sanction_amount.disabled=val;
	document.forms[0].txt_sancrefno.readOnly=val;
	//document.forms[0].txt_intrefno.readOnly=val;
}

function enableButtons( bool2, bool3, bool4, bool5,bool6)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}


function callonLoad()
{
	if(ramdetails!="N")
	{
		if((!(nfiles=="" && type=="")) &&(goodfile!="" && badfile!=""))
			{
				if(nfiles=="0")
				nfiles="0"+" (No Files In The Folder To Import)";
				if(badfile=="0")badrow="0";			
				
				alert("\n\nFlat File Type :"+type+"\n\n"+"Total No Of Files :"+nfiles +" \n Read File(s) :"+goodfile +"\n  Bad File(s) :"+badfile+"\n Bad Row No:"+badrow);
			}
	}
	if(readflagchk=="true")
	{
	alert("Network Connectivity Error Occured While Reading Rating Parameters from IRB !!");
	}
	
	if(flagchk=="false" && propertyflagchk=="false")
	{
		alert("Loan details had been sent to IRB");
	}
	if(flagchk=="true")
	{
		alert("Network Connectivity Error Occured While Sending Rating Parameters to IRB !!");
	}
	if(flagchk=="false" && propertyflagchk=="true")
	{
		if(prd_type=='pH')
		{
			alert("Flat file cannot be generated, Since Values not entered in the proposed asset tab");
		}
		if(prd_type=='pM')
		{
			alert("Flat file cannot be generated, Since Values not entered in the proposed asset tab");
		}
		if(prd_type=='pD')
		{
			alert("Flat file cannot be generated, Since Values not entered in the proposed asset tab");
		}
		if(prd_type=='pA')
		{
			alert("Flat file cannot be generated, Since Values not entered in the proposed asset tab");
		}
		if(prd_type=='pE')
		{
			alert("Flat file cannot be generated, Since Values not entered in details for education loan tab");
		}
	}
	
	disablefields(true);
	document.forms[0].txt_EMI.readOnly=true;
	checkEligibility();
	document.forms[0].sel_SancLevel.value="<%=Helper.correctNull((String) hshValues.get("appraisal_sanclevel"))%>";
	document.forms[0].sel_SancAuth.value="<%=Helper.correctNull((String) hshValues.get("appraisal_sancauth"))%>";
	document.forms[0].sel_SancDept.value="<%=Helper.correctNull((String) hshValues.get("appraisal_department"))%>";
	var sancdept="<%=Helper.correctNull((String) hshValues.get("appraisal_department"))%>";

	var varclphcheck="<%=Helper.correctNull((String)hshValues.get("clphchk"))%>";
	if(appstatus!="Open/Pending")
	{
		if(varclphcheck=="Y" && sancdept=="012"){
			document.forms[0].sel_SancDept.value="018";
	}
	}else{
		document.forms[0].sel_SancDept.value="<%=Helper.correctNull((String) hshValues.get("appraisal_department"))%>";
	}
	if(document.forms[0].sel_SancDept.value=="")
	{
		document.forms[0].sel_SancDept.value="s";
	}
	if(varCersaiCheck != "")
		 document.forms[0].sel_CERSAI_check.value=varCersaiCheck;
		else
	     document.forms[0].sel_CERSAI_check.value="S";
	disableDetailandServices();
	funsancrefno();
	funsanctiondept(document.forms[0].sel_SancAuth.value,'N');
	document.forms[0].sel_amount.disabled=false;
	if(varsanbranch!="")
	{
		document.forms[0].sel_SancBranch.value =varsanbranch;
	}
	if(varloanRepayment!="1")
	{
		document.all.id_EMI.style.display="none";
		document.all.id_EMIVal.style.display="none";
	}

	if(varAppType=="F" || varAppType=="R"|| varAppType=="S")
	{
		if(varVerifyWithCFR=="Y")
		{
			document.forms[0].CFR_verified.value=varVerifyWithCFR;
			document.forms[0].Namein_CFR.value=varNamApprCFR;
			
			document.all.id_CFR3.style.display = "none";
			
		}else if(varVerifyWithCFR=="N")
		{	
			document.forms[0].CFR_verified.value=varVerifyWithCFR;
			document.all.id_CFR1.style.display = "none";
			document.all.id_CFR2.style.display = "none";
			document.all.id_CFR3.style.display = "none";
		}
		else if(varVerifyWithCFR=="NA")
		{	
			document.forms[0].CFR_verified.value=varVerifyWithCFR;
			document.all.id_CFR1.style.display = "none";
			document.all.id_CFR2.style.display = "none";
			document.all.id_CFR3.style.display = "none";
		}else
		{	
			document.forms[0].CFR_verified.value="S";
			document.forms[0].Namein_CFR.value="S";
			document.all.id_CFR1.style.display = "none";
			document.all.id_CFR2.style.display = "none";
			document.all.id_CFR3.style.display = "none";
		}
		
		if(varStaVeri=="A")
		{
			document.forms[0].status_verified.value=varStaVeri;
			document.all.id_status.innerText="CFR Deviation Approved By";
			document.all.id_statusdate.innerText="Approved Date";
			document.all.app1.style.display = "table-row";
			
		}else if(varStaVeri=="R")
		{
			document.forms[0].status_verified.value=varStaVeri;
			document.all.id_status.innerText="CFR Deviation Rejected By";
			document.all.id_statusdate.innerText="Rejected Date";
			document.all.app1.style.display = "table-row";
		}
		else
		{
			document.all.app1.style.display = "none";
		}
			
		CheckCFR_verified();
		CheckCFR_name();
	}
	else
	{
		document.all.id_CFR.style.display = "none";
		document.all.id_CFR3.style.display = "none";
		document.all.app1.style.display = "none";
	}

	if(strSessionModuleType=="DIGI" && prd_type=="pC")
	{
		document.forms[0].cmdedit.disabled=true;
	}

	if(strSessionModuleType=="DIGI")
	{
		document.all.id_RepayCapacity.style.display = "none";
		document.all.id_RepayCapacityVal.style.display = "none";

		
	}

}





function CheckCFR_verified()
{
	if(document.forms[0].CFR_verified.value=="Y")
	{
		document.all.id_CFR1.style.display = "table-cell";
		document.all.id_CFR2.style.display = "table-cell";
	}
	else
	{
		document.all.id_CFR1.style.display = "none";
		document.all.id_CFR2.style.display = "none";
		document.all.id_CFR3.style.display = "none";
		document.all.app1.style.display = "none";

	}
}

function CheckCFR_name()
{
	if(document.forms[0].Namein_CFR.value=="Y")
	{
		document.all.id_CFR3.style.display = "table-row";	
	}
	else
	{
		document.all.id_CFR3.style.display = "none";
		document.all.app1.style.display = "none";	
	}
}

function status_ver()
{
	
	if(document.forms[0].status_verified.value=="A")
	{
		document.all.app1.style.display = "table-row";
		document.all.id_status.innerText="CFR Deviation Approved By";
		document.all.id_statusdate.innerText="Approved Date";
		document.forms[0].hid_userid1.value="";
		document.forms[0].txt_userid1.value="";
		document.forms[0].appref_Appr_date.value="";
		
	}else if(document.forms[0].status_verified.value=="R")
	{
		document.all.app1.style.display = "table-row";
		document.all.id_status.innerText="CFR Deviation Rejected By";
		document.all.id_statusdate.innerText="Rejected Date";
		document.forms[0].hid_userid1.value="";
		document.forms[0].txt_userid1.value="";
		document.forms[0].appref_Appr_date.value="";
	}
	else if(document.forms[0].status_verified.value==""||document.forms[0].status_verified.value=="S")
	{
		document.all.app1.style.display = "none";	
		document.forms[0].hid_userid1.value="";
		document.forms[0].txt_userid1.value="";
		document.forms[0].appref_Appr_date.value="";
	}
}


function doEdit()
{
	if(strSessionModuleType=="DIGI")
	{
		if(prd_type == "pH")
			{
				if(varPRDPURPOSE != "HC")
				{
					if(varPRDPURPOSE != "T")
					{
						if( (varper_margin_total_fund!=varloan_costloanprd))
						{
							alert("Cost of Project and Source of Margin values are not equal");
							return;
						}
					}
				}
			}
		/*if(strRecFacility=="N" && prd_type=="pH")
		{
			alert("Please Click on recalculate button");
			return;
		}*/
	}
	
	
	if(status =="pa")
	{
	document.forms[0].appraisaldate.readOnly=true;
	document.forms[0].appraisedby.readOnly=true;
	document.forms[0].txt_schemefor.readOnly=true;
	document.forms[0].txt_sanction_amount.readOnly=true;
	}
	else
	{
	enableButtons(true, false, false, true,false);
	disablefields(false);
	document.forms[0].hidAction.value="edit";
	if(varorglevel=="C"||varorglevel=="D")
		document.forms[0].txt_perbranch.readOnly=true;
	if(varAppType=="P")
	{
		document.forms[0].txt_sanction_amount.readOnly = true;
		var varPSterms = document.forms[0].hidPSterms.value.split("@");
		for(var i=0;i<varPSterms.length;i++)
		{
			if(varPSterms[i] == "DLA" || varPSterms[i] == "SLILA")
			{
				document.forms[0].txt_sanction_amount.readOnly = false;
			}
		}
	}
	}
}

function doSave()
{	

	//if(strSessionModuleType=="DIGI")
	{
		calcemi();
	}

	if(varAppType=="F" || varAppType=="R"|| varAppType=="S")
	{
		if(document.forms[0].CFR_verified.value=="N"||document.forms[0].CFR_verified.value=="S"||document.forms[0].CFR_verified.value=="NA")
		{
			document.forms[0].Namein_CFR.value="S";
			document.forms[0].txt_CFRdev_refno.value="";
			document.forms[0].status_verified.value="S";
			document.forms[0].hid_userid1.value="";
			document.forms[0].appref_Appr_date.value="";
		}else if(document.forms[0].Namein_CFR.value=="N")
		{
			document.forms[0].txt_CFRdev_refno.value="";
			document.forms[0].status_verified.value="S";
			document.forms[0].hid_userid1.value="";
			document.forms[0].appref_Appr_date.value="";
			
		}
		
		if(document.forms[0].CFR_verified.value=="S")
		{
			ShowAlert('111',"Whether verified with Central Fraud Registry?");
			document.forms[0].CFR_verified.focus();
			return false;
		}
	    else if(document.forms[0].sel_CERSAI_check.value=="S")
		{
			 ShowAlert(111,'Whether CERSAI data base checked?');
			 document.forms[0].sel_CERSAI_check.focus();
			 return;
		}
		else if(document.forms[0].CFR_verified.value=="Y" && document.forms[0].Namein_CFR.value=="S")
		{
			ShowAlert('111',"Whether Applicant/Co-applicant/Guarantor/Proprietor/Partner name appears in CFR ");
			document.forms[0].Namein_CFR.focus();
			return false;
		}
		else if(document.forms[0].Namein_CFR.value=="Y" && document.forms[0].txt_CFRdev_refno.value=="")
		{
			ShowAlert('121',"CFR Deviation Reference number");
			document.forms[0].txt_CFRdev_refno.focus();
			return false;
		}
		else if(document.forms[0].Namein_CFR.value=="Y" && document.forms[0].status_verified.value=="S")
		{
	
			alert("Select CFR Deviation approval Status");
			document.forms[0].status_verified.focus();
			return false;
		}
		else if(document.forms[0].status_verified.value=="A" && document.forms[0].txt_userid1.value=="")
		{
			alert("Enter the CFR Deviation Approved User Name");
			document.forms[0].txt_userid1.focus();
			return false;
		}
		else if(document.forms[0].status_verified.value=="R" && document.forms[0].txt_userid1.value=="")
		{
			alert("Enter the CFR Deviation Rejected User Name");
			document.forms[0].txt_userid1.focus();
			return false;
		}
		else if(document.forms[0].status_verified.value=="A" && document.forms[0].appref_Appr_date.value=="")
		{
			alert("Select CFR Deviation Approved Date");
			document.forms[0].appref_Appr_date.focus();
			return false;
		}else if(document.forms[0].status_verified.value=="R" && document.forms[0].appref_Appr_date.value=="")
		{
			alert("Select CFR Deviation Rejected Date");
			document.forms[0].appref_Appr_date.focus();
			return false;
		}
	
	}
	
	if(interest=="0.00")
	{
		alert("Interest Rate should not be Zero");
		return false;
	}
	checkEligibility();
	document.forms[0].hidRecordflag.value=varRecordFlag;
	if(document.forms[0].appraisaldate.value=="")
	{
		alert("Enter the Appraisal Date");
		document.forms[0].appraisaldate.focus();
		return false;
	}	
	else if(document.forms[0].appraisedby.value=="")
	{
		alert("Enter Appraiser's Name");
		return false;
	}
	else if(document.forms[0].sel_SancLevel.value=="")
	{
		ShowAlert(111,"Sanction Level");
		document.forms[0].sel_SancLevel.focus();
		return false;
	}
	else if(document.forms[0].sel_SancDept.value==""||document.forms[0].sel_SancDept.value=="s")
	{
		ShowAlert(111,"Sanctioning Department");
		document.forms[0].sel_SancDept.focus();
		return false;
	}
	else if(document.forms[0].sel_SancDept.value=="010" || document.forms[0].sel_SancDept.value=="008" || document.forms[0].sel_SancDept.value=="013" || document.forms[0].sel_SancDept.value=="014"|| document.forms[0].sel_SancDept.value=="015"|| document.forms[0].sel_SancDept.value=="016")
		{
			if(document.forms[0].sel_SancBranch.value=="")
			{
				alert("Select Sanctioning Branch");
				document.forms[0].sel_SancBranch.focus();
				return false;
			}
		}
	 if(document.forms[0].sel_SancAuth.value=="" || document.forms[0].sel_SancAuth.value=="s")
	{
		ShowAlert(111,"Sanctioning Authority");
		document.forms[0].sel_SancAuth.focus();
		return false;
	}
	
	else if(document.forms[0].sel_SancAuth.value!=""||document.forms[0].sel_SancAuth.value!="s"){
		if(document.forms[0].sel_SancAuth.value=="15"||document.forms[0].sel_SancAuth.value=="16"||document.forms[0].sel_SancAuth.value=="14"){
			if(document.forms[0].txt_sancrefno.value==""){
				ShowAlert(121,"Sanction Reference No");
				document.forms[0].txt_sancrefno.focus();
				return false;
			}
			if(document.forms[0].sanctiondate.value==""){
				ShowAlert(111,"Sanction date");
				document.forms[0].sanctiondate.focus();
				return false;
			}
		}
	}
	else if((document.forms[0].sel_SancDept.value=="010" || document.forms[0].sel_SancDept.value=="008" || document.forms[0].sel_SancDept.value=="013" || document.forms[0].sel_SancDept.value=="014") && document.forms[0].sel_SancBranch.value=="")
	{
		alert("Select Sanctioning Branch");
		document.forms[0].sel_SancBranch.focus();
		return false;
	}

	 if(( varSanctionAuth!= document.forms[0].sel_SancAuth.value) && (varSanctionAuth=="14"||varSanctionAuth=="15"||varSanctionAuth=="16"))
		{
			document.forms[0].hidSancAuth.value="Y";
		}
	 if(varorglevel=="C"||varorglevel=="D")
		{
			if(document.forms[0].hid_perbranch.value=="")
			{
				ShowAlert('111', "Proposal pertains to the branch"); 	
				document.forms[0].txt_perbranch.focus();
				return;	
			}
			else if(varorglevel=="D")
			{
				/*if(document.forms[0].hidAppOrgcode.value.substring(0,9)!=document.forms[0].hid_perbranchcode.value.substring(0,9))
				{
					alert("Branch Should be with in RLPC"); 
					document.forms[0].hid_perbranchcode.value="";
					document.forms[0].hid_perbranch.value="";
					document.forms[0].txt_perbranch.value="";	
					document.forms[0].txt_perbranch.focus();
					return;	
				}*/
			}
		}	
		<%if(strMisDetailsCheck.equalsIgnoreCase("Y")){%>
		if(parseFloat(document.forms[0].txt_sanction_amount.value)!= parseFloat(document.forms[0].hidSancAmt.value))
		{
		 if(confirm("If Sanction limit is modified user needs to reselect the activity code in MIS details tab for recalculation. Do you want to proceed?"))
			 document.forms[0].hidparam.value ="MISDEL";
		 else
		 {
			  document.forms[0].txt_sanction_amount.value=document.forms[0].hidSancAmt.value;
			  return false;
		 }
		}
		<%}%>
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidRecordflag.value=varRecordFlag;
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].hidBeanMethod.value="insertdates";
		document.forms[0].hidBeanGetMethod.value="getloandetails";
		document.forms[0].hidSourceUrl.value="/action/loandetails.jsp";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();		

}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
	document.forms[0].hidBeanGetMethod.value="getloandetails";
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].action=appUrl+"action/loandetails.jsp";
	document.forms[0].submit();
	}
}

function doClose()
{
	var con = ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appUrl+"action/retailpge";
	   	document.forms[0].submit();
	}
}

function checkEligibility()
{
	
	{
		if(document.forms[0].txt_sanction_amount.value!="")
		{
			document.all.ifrm.src=appUrl+"action/iframeeligibility.jsp?hidBeanGetMethod=checkEligibility&hidBeanId=perapplicant&appno="+document.forms[0].appno.value+"&txt_sanction_amount="+document.forms[0].txt_sanction_amount.value;
		}
	}
}
function callUsersHelp()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var prop="scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appUrl+"action/selectusers1.jsp?hidBeanId=appraisal&hidBeanGetMethod=getuserslist";
		window.open(url,"",prop);
	}
}
function callUsersHelp1()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = appURL+"action/setUserSearch.jsp?pagefrom=CFRDet";
		var title = "Users";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
}

function callOtherTab(val)
{
	if (document.forms[0].cmdsave.disabled)
	{
		if(val=="checklist")
		{
		document.forms[0].hidBeanId.value="appraisal";		
		document.forms[0].hidBeanGetMethod.value="getDataQuestParameters";
		document.forms[0].action=appUrl+"action/appraisalconfirm.jsp";	
		document.forms[0].submit();
		 }
		 else
		 {
		 ShowAlert(103);
		 }
     }	
} 
	
function readretailscoring()
{
	if(confirm("Import Retail Scoring?"))
	{		
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].hidAction.value="READ SCORING";		
		document.forms[0].hidBeanGetMethod.value="getloandetails";
		document.forms[0].hidSourceUrl.value="/action/loandetails.jsp";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
}
function callRecalculateEligibility()
{

	alert("Rate Of Interest: "+varRoi+"\n\n"+"Concession Interest: "+varConcession+"\n\n"+"Penalty Interest: "+varPenalty);
 	return;
}

function printEligibility()
{
	var appno=document.forms[0].appno.value;
	var subcategory="<%=Helper.correctNull((String) hshValues.get("subcategory"))%>";
	var title = "EligiablePrintout";
	var purl="<%=ApplicationParams.getAppUrl()%>action/per_eligiblityprint.jsp?hidBeanGetMethod=checkEligibility&hidBeanId=perapplicant&appno="+document.forms[0].appno.value
											+"&txt_sanction_amount="+document.forms[0].txt_sanction_amount.value
											+"&subcategory="+subcategory;
	prop='scrollbars=yes,menubar=yes,width=750,height=520';
	xpos=(screen.width-750)/2;
	ypos=(screen.height-400)/2;
	prop=prop+",xpos="+xpos+",ypos="+ypos;
	window.open(purl,title,prop);
}
function callEligibility()
{
	if(prd_type=="pE")
	{
		if(eduDetails!="Y")
		{
			alert("Please fill Loan Particulars----->Details of Education loan");
			return;
		}
	}
	else if(prd_type=="pA")
	{
		if(strVehDetails!="Y")
		{
			alert("Please fill Loan Particulars----->Proposed/Offered Asset Tab");
			return;
		}
	}
	
	var appno = document.forms[0].appno.value;
	var prdcode="<%=prdcode%>";
	var comappid = document.forms[0].hidapplicantid.value;
	document.forms[0].comappid.value=comappid;
	var	varQryString = appURL+"action/checkeligibility.jsp?hidBeanGetMethod=getEligibility&hidBeanId=checkeligibility&appno="+appno+"&prd_type="+prd_type+"&prdcode="+prdcode+"&comappid="+comappid;
	var title = "Check_Eligibility";
	var prop = "scrollbars=yes,width=950,height=450,menubar=yes";
	var wid="950";
	var hei="400";
	var xpos = (screen.width - wid) / 2;
	var ypos = (screen.height - hei) / 4;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(varQryString,title,prop);
}
function callRestrucAnnexure(page)
{
	
	var appno = document.forms[0].appno.value;
	var comappid = document.forms[0].hidapplicantnewid.value;
	var strOrgCode="<%=strorgcode%>";
	var prop = "scrollbars=yes,width=1000,height=550,menubar=yes";
	var title = "PrintFairReport";
	var xpos = 100;
	var ypos = 55;
	prop = prop + ",left="+xpos+",top="+ypos;
	var url=appUrl+"action/"+page+"?hidBeanId=appraisal&hidBeanGetMethod=getRestruceAnnexure&appno="+appno+"&appid="+comappid;
	window.open(url,title,prop);

	
}

function disableDetailandServices()
{
	if(prd_type=="pG"||prd_type=="pR")
	{
		document.all.id_EMI.style.display="none";
		document.all.id_RepayCapacity.style.display="none";
		document.all.id_AvailRepayPeriod.style.display="none";
		document.all.id_Networth.style.display="none";
		document.all.id_EMIVal.style.display="none";
		document.all.id_RepayCapacityVal.style.display="none";
		if(document.all.id_AvailRepayPeriodVal.length>1)
		{
			for(var i=0;i<document.all.id_AvailRepayPeriodVal.length;i++)
			{
				document.all.id_AvailRepayPeriodVal[i].style.display="none";
				document.all.id_NetworthVal[i].style.display="none";
			}
		}
		else
		{
			document.all.id_AvailRepayPeriodVal.style.display="none";
			document.all.id_NetworthVal.style.display="none";
		}
	}
	if(mortFlag=='Y'){
		document.all.id_EMI.style.display="none";
		document.all.id_RepayCapacity.style.display="none";
		document.all.id_EMIVal.style.display="none";
		document.all.id_RepayCapacityVal.style.display="none";
	}
	else
	{
		document.all.id_EMI.style.display="table-cell";
		document.all.id_RepayCapacity.style.display="table-cell";
		document.all.id_AvailRepayPeriod.style.display="table-cell";
		document.all.id_Networth.style.display="table-cell";
		document.all.id_EMIVal.style.display="table-cell";
		document.all.id_RepayCapacityVal.style.display="table-cell";
		if(document.all.id_AvailRepayPeriodVal.length>1)
		{
			for(var i=0;i<document.all.id_AvailRepayPeriodVal.length;i++)
			{
				document.all.id_AvailRepayPeriodVal[i].style.display="table-cell";
				document.all.id_NetworthVal[i].style.display="table-cell";
			}
		}
		else
		{
			document.all.id_AvailRepayPeriodVal.style.display="table-cell";
			document.all.id_NetworthVal.style.display="table-cell";
		}
	}
}
function calcemi()
{	
		var varrate = "";
		var denominator ="";
		var varnumerator = "";
		var varemi = "";	
		if(interest=="0.00")
		{
			alert("Interest Rate should not be zero");
			return;
		}
		varrate=parseFloat(eval(interest))/(12*100);
		denominator=Math.pow(varrate+1,(parseInt(varterm)-parseInt(moratorium)))-1;	
		varnumerator=varrate*Math.pow(varrate+1,(parseInt(varterm)-parseInt(moratorium)));
		toamt =document.forms[0].txt_sanction_amount.value;
		if(varInterestCharged == "2" && moratorium > 0 && varInterestHoliday=="n")
		{
			if(varIntCalculated=="C")
			{
				var tmp =  (1+(parseFloat(interest) / 1200));		
				toamt  = 	roundVal(toamt *(Math.pow(tmp,moratorium)));
			}else if(varIntCalculated=="S")
			{
				toamt = roundVal(toamt + ((toamt*moratorium*parseFloat(interest)))/1200);
			}
		}
		if(varloanRepayment=="1")
		{
			varemi=Math.ceil(((varnumerator/denominator)*toamt));
		}
		else
		{
			varemi=parseFloat(toamt)/parseInt(parseInt(varterm)-parseInt(moratorium));
		}
		if(isNaN(varemi) || varemi=="Infinity")
		{
			varemi="0";
		}
		else
		{
			varemi=roundVal(varemi);
		}
		document.forms[0].txt_EMI.value=varemi;

		
		if(staffproduct == "Y" && (prd_type == "pH" || prd_type == "pA"))
		{

			var varPrinRatio = NanNumber(parseFloat(document.forms[0].hidPrincipalRepay.value));
			var varIntRatio = NanNumber(parseFloat(document.forms[0].hidInterestRepay.value));
			<%--if(prd_type == "pH")
			{
				moratorium="<%=Helper.correctInt((String)hshValues.get("loan_noofinstallment"))%>";
				if(varstaff_under=="1")
				{
					varterm="270";
				}else{
					varterm="180";
				}
				varterm=parseFloat(varterm)-parseFloat(moratorium);
			}
			varemi=Math.ceil(toamt/varterm);--%>

			varemi = parseFloat(toamt) / (varPrinRatio - parseFloat(moratorium));
			document.forms[0].txt_EMI.value=roundVal(Math.round(varemi));
		}
		if((staffproduct == "Y"))
		{
			if(parseInt(varterm)!=0)
			{
				varemi = parseFloat(toamt) / parseFloat(parseInt(varterm)-parseInt(moratorium));
			}
			else
			{
				varemi="0";
			}
			document.forms[0].txt_EMI.value=varemi;
		}

}
function setDisableSave()
{
	document.forms[0].cmdsave.disabled=true;
}
function funsancrefno()
{
	if((document.forms[0].sel_SancAuth.value=="15") || (document.forms[0].sel_SancAuth.value=="16")||(document.forms[0].sel_SancAuth.value=="14"))
	{
		document.all.sanrefno.style.display = "table-cell";
		document.all.sanrefval.style.display = "table-cell";
		document.all.sancdate1.style.display = "table-cell";
		document.all.sancdate2.style.display = "table-cell";	
	}
	else
	{
		document.all.sanrefno.style.display = "none";
		document.all.sanrefval.style.display = "none";
		document.all.sancdate1.style.display = "none";
		document.all.sancdate2.style.display = "none";	
		
	}		
}
function funchange(){
	if((document.forms[0].sel_SancAuth.value=="15") || (document.forms[0].sel_SancAuth.value=="16")||(document.forms[0].sel_SancAuth.value=="14"))
	{
		document.forms[0].txt_sancrefno.value="";
		document.forms[0].sanctiondate.value="";
	}
}
function funsanctiondept(varfname,val)
{
	/*if(document.forms[0].hidAppProcessAt.value!="6" && document.forms[0].sel_SancDept.value=="012" && val=="Y")
	{
		alert("Option is Applicable only for RLPC created Proposal");
		document.forms[0].sel_SancDept.value="s";
		return;
	}*/
	var varsancdept=document.forms[0].sel_SancDept.value;
	if((varsancdept=="008") || (varsancdept=="010")|| (varsancdept=="013")|| (varsancdept=="014")|| (varsancdept=="015")|| (varsancdept=="016"))
	{
		document.all.idsanbranch.style.display="table-cell";
		funsancbranchvalues();
	}
	else{
		document.all.idsanbranch.style.display="none";
		document.forms[0].sel_SancBranch.value="";
	}
	document.all.ifrmsancauthority.src=appURL+"action/iframesancauthority.jsp?hidBeanGetMethod=getSancAuthority&hidBeanId=comproposal&sancdept="+varsancdept+"&sancauth="+varfname;
	
}
function funsancbranchvalues()
{
	var varsancdept=document.forms[0].sel_SancDept.value;
	document.all.ifrmsancbranch.src=appURL+"action/ifrmsancbranches.jsp?hidBeanGetMethod=getSancBranches&hidBeanId=comproposal&sancdept="+varsancdept+"&sancbranch="+varsanbranch;
	/*if(document.forms[0].sel_SancDept.value=="010")
 	{
		document.forms[0].sel_SancBranch.length=3;
		document.forms[0].sel_SancBranch.options[1] = new Option('RFD','RFD');
		document.forms[0].sel_SancBranch.options[2] = new Option('MCFD','MCFD');
		document.forms[0].sel_SancBranch.options[3] = new Option('ASG','ASG');
 	}
	else if(document.forms[0].sel_SancDept.value=="008")
 	{
		document.forms[0].sel_SancBranch.length=2;
		document.forms[0].sel_SancBranch.options[1] = new Option('LCFD','LCFD');
		document.forms[0].sel_SancBranch.options[2] = new Option('Forex Support','FS');
 	}
	else if(document.forms[0].sel_SancDept.value=="013")
 	{
		document.forms[0].sel_SancBranch.length=2;
		document.forms[0].sel_SancBranch.options[1] = new Option('RFD','RFD');
		document.forms[0].sel_SancBranch.options[2] = new Option('ASG','ASG');
 	}
	else if(document.forms[0].sel_SancDept.value=="014")
 	{
		document.forms[0].sel_SancBranch.length=1;
		document.forms[0].sel_SancBranch.options[1] = new Option('MCFD','MCFD');
 	}
	else if(document.forms[0].sel_SancDept.value=="015")
 	{
		document.forms[0].sel_SancBranch.length=3;
		document.forms[0].sel_SancBranch.options[1] = new Option('Large Corporate','LC');
		document.forms[0].sel_SancBranch.options[2] = new Option('Mid Corporate','MD');
		document.forms[0].sel_SancBranch.options[3] = new Option('Forex/FSG','FF');
 	}
	else if(document.forms[0].sel_SancDept.value=="016")
 	{
		document.forms[0].sel_SancBranch.length=3;
		document.forms[0].sel_SancBranch.options[1] = new Option('Retail','RET');
		document.forms[0].sel_SancBranch.options[2] = new Option('MSME','MSME');
		document.forms[0].sel_SancBranch.options[3] = new Option('Agri/ASG','AA');
 	}
	else
	{
		document.forms[0].sel_SancBranch.value="";
	}*/
}
function getinterest()
{
	if(strSessionModuleType!="DIGI")
	{
		if(prd_type!="pR")
		{
			//document.all.ifrminterest.src=appUrl+"action/iframesancinterset.jsp?hidBeanGetMethod=getInterestRate&hidBeanId=perapplicant&hidProductID="+document.forms[0].prdcode.value+"&inttype="+document.forms[0].hidInterestType.value+"&recamt="+document.forms[0].txt_sanction_amount.value+"&terms="+varterm+"&morterms="+moratorium+"&varProductType="+prd_type;
		}
	}
}
function doPrint()
{ 	
	if(varDDRAppFlag=="N")
	{
		alert("Enter all Applicant's Details in  Due Diligence Report -> Due Diligence - Applicant Info tab ");
		return;
	}
	if(varDDRGeneralInfo=="N")
	{
		alert("Enter Details in  Due Diligence Report -> Due Diligence - Security Info tab ");
		return;
	}
	/*if(document.forms[0].sel_amount.value=="S")
	  {
		  alert("Select Amount to be shown in");
		  return;
	  }*/
	var stappno = document.forms[0].appno.value;
	var title = "Due_Diligence_ReportPrint";
	var purl=appURL+"action/Due_Diligence_Report.jsp?hidBeanGetMethod=getdueReportprint&hidBeanId=documentsupport&appno="+stappno+"&strAmountVal="+document.forms[0].sel_amount.value+"&StrModule=RET";
	prop='scrollbars=yes,menubar=yes,width=1050,height=620';
	xpos=300;
	ypos=150;
	prop=prop+",xpos="+xpos+",ypos="+ypos;
	window.open(purl,title,prop);
}
function showOrganizationSearch(path, forgscode, forgname,forgcode)
{
	
		var varQryString = path+"action/searchOrg.jsp?forgscode="+forgscode+"&forgname="+forgname+"&forgcode="+forgcode;
		var title = "Organization";
		var prop = "scrollbars=yes,width=500,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad()">
<form name="appform" method="post" class="normal">
<%if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>

<% if(strSessionModuleType.equalsIgnoreCase("DIGI")) { %>
<jsp:include page="../share/applurllinkerdigi.jsp" flush="true">
<jsp:param name="pageid" value="10" /></jsp:include>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Digi Retail -&gt; Appraisal -&gt; Loan Details</td>
	</tr>
</table>
<% } else { %>
<jsp:include page="../share/Applurllinkper.jsp" flush="true">
<jsp:param name="pageid" value="10" /></jsp:include>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Appraisal -&gt; Loan Details</td>
	</tr>
</table>
<% } %>

<lapschoice:application />
<jsp:include page="../share/apprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="1" />
		</jsp:include>
<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
			<jsp:param name="subpageid" value="112" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<jsp:include page="../share/postsanctionapprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="1" />
		</jsp:include>
<%} %>


		<br>

<table width="95%" border="0" cellpadding="3" cellspacing="0" class="outertable border1" align="center">	
	<tr>
		<td valign="top">
<table width="100%" border="0" cellpadding="3" cellspacing="0" class="outertable" align="center">	
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
			<tr>
				<td width="15%">Product</td>
				<td width="85%"><%=Helper.correctNull((String) hshValues.get("prodcategory"))%> - <%=Helper.correctNull((String) hshValues.get("subcategory"))%> - <%=Helper.correctNull((String) hshValues.get("prd_desc"))%></td>
			</tr>
			<tr>
				<td width="15%">Margin</td>
				<td width="85%"><%=Helper.correctNull((String) hshValues.get("loan_margin"))%> %</td>
			</tr>
			<tr>
				<td width="15%">Purpose of Loan</td>
				<td width="85%"><%=Helper.correctNull((String) hshValues.get("loan_purposeofloan"))%></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td><b>Loan Details</b></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
			<%
				if (strStaffProduct.trim().equals("Y")) {
			%>
			<tr class="dataheader">
				<td align="center"><b>Loan Amount Applied </b></td>
				<td align="center"><b>Rate of Interest</b></td>
				<td align="center"  id="id_EMI"><b>Principal EMI (monthly)
				Rs.</b></td>
				<td align="center"><b>Repayment Period (In
				Months)</b></td>
				<td align="center" id="id_RepayCapacity"><b>Repayment Capacity (%)</b></td>
				</tr>
			<tr class="datagrid">
				<td align="center"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("amtreqd"))))%>
				</td>
				<td align="center"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("mintrate"))))%>%
				</td>
				<td align="center"  id="id_EMIVal">
				<lapschoice:CurrencyTag name="txt_EMI" value='<%=Helper.correctNull((String) hshValues.get("emi"))%>' other="readOnly" />&nbsp;</td>
				<td align="center"><%=Helper.correctNull((String) hshValues.get("lreqterms"))%>
				</td>
				<td align="center" id="id_RepayCapacityVal"><lapschoice:CurrencyTag name="txt_repaycapacity" value='<%=Helper.correctDouble((String) hshValues.get("repaycapacity_staff"))%>'
					other="readOnly" />&nbsp;</td>
			</tr>
			<%
				} else {
			%>
			<tr class="dataheader">
				<td align="center"><b>Loan Amount Applied </b></td>
				<td align="center"><b>Rate of Interest</b></td>
				<td align="center" id="id_EMI"><b>EMI (monthly) Rs</b></td>
				<td align="center"><b>Repayment Period (In
				Months)</b></td>
				<td align="center" id="id_RepayCapacity"><b>Repayment Capacity (%)</b></td>
			</tr>
			<tr class="datagrid">
				<td align="center"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("amtreqd"))))%>
				</td>
				<td align="center"><span id="id_interest"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("mintrate"))))%></span>%
				</td>
				<td align="center" id="id_EMIVal"><lapschoice:CurrencyTag name="txt_EMI"
					value='<%=Helper.correctDouble((String) hshValues.get("emi"))%>'
					other="readOnly" /></td>
				<td align="center"><%=Helper.correctNull((String) hshValues.get("lreqterms"))%>
				</td>
				<td align="center" id="id_RepayCapacityVal"><lapschoice:CurrencyTag name="txt_repaycapacity" value='<%=Helper.correctDouble((String) hshValues.get("repaycapacity"))%>'
					other="readOnly" />&nbsp;</td>
			</tr>
			<%
				}
			%>
		</table>
		</td>
	</tr>
	<tr>
		<td><b>Experience and Service</b></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
			<tr class="dataheader">
				<td align="center" nowrap="nowrap"><b>Type</b></td>
				<td align="center" nowrap="nowrap"><b>Name</b></td>
				<td align="center" nowrap="nowrap"><b>Relationship</b></td>
				<td align="center" nowrap="nowrap"><b>Date of Birth</b></td>
				<td align="center" nowrap="nowrap"><b>Age</b></td>
				<td align="center" nowrap="nowrap" id="id_AvailRepayPeriod"><b>Available
				Repayment Period (in Months) </b></td>
				<td align="center" nowrap="nowrap" id="id_Networth"><b>Networth 
				</b></td>
			</tr>
			<%
				ArrayList vecReport = new ArrayList();
				int vecRsize = 0;
				if (hshValues != null) {
					vecReport = (ArrayList) hshValues.get("vecReport");
				}
				if (vecReport != null) {
					vecRsize = vecReport.size();
				}
				ArrayList b1 = null;
				if (vecRsize != 0) {
					for (int l = 0; l < vecRsize; l++) {
						int colSize = 0;
						if (l < vecRsize) {
							b1 = (ArrayList) vecReport.get(l);
							if (b1 != null) {
								colSize = b1.size();
							}
						}
						if (colSize > 0) {
							int intService = Integer.parseInt(Helper
									.correctInt((String) b1.get(8)));
							if (intService < 0) {
								intService = 0;
							}
			%>
			<tr class="datagrid">
				<td nowrap="nowrap"><%=Helper.correctNull((String) b1.get(0))%></td>
				<td><%=Helper.correctNull((String) b1.get(1))%></td>
				<td nowrap="nowrap"><%=Helper.correctNull((String) b1.get(5))%></td>
				<td nowrap="nowrap" align="center"><%=Helper.correctNull((String) b1.get(6))%></td>
				<td><%=Helper.correctNull((String) b1.get(7))%></td>
				<td nowrap="nowrap" id="id_AvailRepayPeriodVal"><%=intService%></td>
				<td nowrap="nowrap" align="right" id="id_NetworthVal"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) b1.get(9))))%>
				</td>
			</tr>
			<%
				}
					}
				}else{%>
				<tr class="datagrid">
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td id="id_AvailRepayPeriodVal">&nbsp;</td>
				<td id="id_NetworthVal">&nbsp;</td>
				<td>&nbsp;</td>
				</tr>
			<% }%>			
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%%" border="0" cellspacing="0" cellpadding="4"
			class="outertable">
			<tr>
				<td width="15%">Date of Appraisal</td>
				<td width="15%">
				<table border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>						
					<td>
					<input type="text" name="appraisaldate" maxlength="10" 
					onBlur="checkDate(this);checkmaxdate(this,currentDate);getinterest();" size="12"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("apprisal_Date"))%>">
						</td>
						<td>&nbsp;&nbsp;</td>
						<td><a alt="Select date from calender" href="#"
							onClick="callCalender1()"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" align="middle"></a></td>
					</tr>
				</table>
				</td>
				<td width="15%" nowrap="nowrap">Appraised by</td>
				<td width="35%">
				<table border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td><input type="text" name="appraisedby" size="30" maxlength="30" readonly="readonly" value="<%=Helper.correctNull((String) hshValues.get("username"))%>">
						<input type="hidden" name="txt_userid" size="10" maxlength="30" readonly="readonly" value="<%=Helper.correctNull((String) hshValues.get("Apprised_by"))%>">
						<b><span onClick="callUsersHelp()" style="cursor: hand"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="81"></span></b></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>Sanction Level</td>
				<td>
					<select name="sel_SancLevel" >
						<option value="">--Select--</option>
						<lapschoice:CBSStaticDataNewTag apptype="14" />
					</select>
				</td>
				<td>Sanctioning Department</td>
				<td>
				<table width="40%" border="0" cellspacing="0" cellpadding="3" class="outertable">
				<tr>
				<td>
				<select name="sel_SancDept"  onchange="funsanctiondept('s','Y');">
				<option value="s">--Select--</option>
				<lapschoice:CBSStaticDataNewTag apptype="26" />
				</select>
				</td>
				<td id="idsanbranch">
				<select name="sel_SancBranch" >
				<option value="">--Select--</option>
				</select>
				</td>
				</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td width="15%" rowspan="2">Recommendation</td>
				<td width="15%" rowspan="2"><textarea name="txt_schemefor"
					cols="50" rows="4" onkeyup="textlimitcorp1(this,300);" onkeydown="textlimitcorp1(this,300);"><%=Helper.correctNull((String) hshValues.get("apprised_scheme"))%> 
			</textarea>
			</td>
				<td>Sanctioning Authority</td>
				<td>
					<select name="sel_SancAuth" onChange="funsancrefno();funchange();">
						<option value="">--Select--</option>
						<lapschoice:CBSStaticDataNewTag apptype="15" />
					</select>
				</td>	
				
			</tr>
			<tr>
				<td id="sanrefno">Sanction Reference No.<b><span class="mantatory">*</span></b></td>
				<td id="sanrefval"><input type="text" name="txt_sancrefno" size="37" maxlength="50"	value="<%=Helper.correctNull((String) hshValues.get("appraisal_sancrefno"))%>"></td>			
			</tr>
			<tr id="id_CFR">
				<td> Whether verfied with Central Fraud Registry ? &nbsp;</td>
				<td><select name="CFR_verified"  onchange="CheckCFR_verified()">
					<option value="S" >&lt;----Select----&gt;</option>
					<option value="Y">Yes</option>
					<option value="N" >No</option>
					<option value="NA" >Not Applicable</option>
				</select></td>
				<td id="id_CFR1"> Whether Applicant/Co-applicant/Guarantor/Proprietor/Partner name appears in CFR ? &nbsp; </td>
				<td id="id_CFR2"><select name="Namein_CFR" onchange="CheckCFR_name()">
					<option value="S" >&lt;----Select----&gt;</option>
					<option value="Y">Yes</option>
					<option value="N">No</option>
				</select>
				</td>
		</tr>
		<tr>
						<td>Whether CERSAI data base checked ?</td>
						<td><select name="sel_CERSAI_check" onChange=""	tabindex="23">
									<option value="S" selected="selected">--select--</option>
									<option value="Y">Yes</option>
									<option value="N">No</option>
									<option value="NA">Not Applicable</option>
								</select></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
		</tr>
		<tr id="id_CFR3">
				<td>CFR Deviation Reference number &nbsp;</td>
				<td><input type="text" name="txt_CFRdev_refno" maxlength="25" value="<%=Helper.correctNull((String) hshValues.get("loan_RefNoCFR"))%>">  </td>
				<td> Status &nbsp;</td>
				<td><select name="status_verified" onchange="status_ver()">
					<option value="S" >&lt;----Select----&gt;</option>
					<option value="A">Approved</option>
					<option value="R" >Rejected</option>
				</select></td>
				
		</tr>
		<%if (orglevel.equals("C")||orglevel.equals("D")){ %>
		<tr>
				<td>Proposal pertains to the branch</td>
				<td><input type="hidden" name="hid_perbranch" value="<%=Helper.correctNull((String) hshValues.get("strBranchCode"))%>">
					<input type="hidden" name="hid_perbranchcode" value="<%=Helper.correctNull((String) hshValues.get("strBranchOrgCode"))%>">
					<input type="text" name="txt_perbranch" value="<%=Helper.correctNull((String) hshValues.get("strBranchName"))%>"> 
					<b><a href="#" onClick="showOrganizationSearch('<%=ApplicationParams.getAppUrl()%>','hid_perbranch','txt_perbranch','hid_perbranchcode')"
					style="cursor: hand">
					<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" ></a></b></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
	</tr>
	<%} %>
		<tr id="app1">
			<td id="id_status">&nbsp;</td>
			<td width="35%">
				<table border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td><input type="text" name="txt_userid1" size="30" maxlength="30" readonly="readonly" value="<%=Helper.correctNull((String) hshValues.get("appuserid"))%>">
						<input type="hidden" name="hid_userid1" size="10" maxlength="30" readonly="readonly" value="<%=Helper.correctNull((String) hshValues.get("loan_appr_userid1"))%>">
						<b><span onClick="callUsersHelp1()" style="cursor: hand"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="81"></span></b></td>
					</tr>
				</table>
			</td>
			<td id="id_statusdate">&nbsp;</td>
			<td><input type="text" name="appref_Appr_date" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("loan_Appr_date"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate);" maxlength="10" tabindex="15">
		    				<a alt="Select date from calender" href="#"
							onClick="callCalender('appref_Appr_date')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> 
			</td>
		</tr>
		<tr>
				<td>&nbsp;&nbsp;</td><td>&nbsp;&nbsp;</td>
				<td id="sancdate1">Sanction date <b><span class="mantatory">*</span></b></td>	
				<td id="sancdate2">
					<input type="text" name="sanctiondate" maxlength="10" 
					onBlur="checkDate(this);checkmaxdate(this,currentDate);" size="12"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("appref_sancdate"))%>">
				  	&nbsp;<a alt="Select date from calender" href="#"
					onClick="callCalender2()"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender" align="middle"></a></td>
			</tr>
			
			<%
				if (strHomeplusProduct.equalsIgnoreCase("Y")) {
			%>
			<tr>
				<td>Insurance Premium Amount</td>
				<td><lapschoice:CurrencyTag name="txt_inspremiumamt"
					maxlength="15"
					value='<%=Helper.correctNull((String) hshValues.get("premium_amount"))%>' />
				</td>
			</tr>
			<%
				} else {
			%>
			
			<%
				}
			%>	
			<tr>
<!--			<td nowrap="nowrap"> Interest Deviation Reference No.</td>-->
<!--			<td> <input type="text" name="txt_intrefno" maxlength="20" value="<%=Helper.correctNull((String) hshValues.get("strIntRefNo"))%>">&nbsp;</td>-->
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td width="15%" nowrap="nowrap">Sanctioning Loan Amount</td>
				<td width="35%"><lapschoice:CurrencyTag
					name="txt_sanction_amount" maxlength="15" onChange="setDisableSave()"
					onBlur="getinterest();calcemi();checkEligibility();"
					value='<%=Helper.correctNull((String) hshValues.get("sanction_amount"))%>' /></td>		
		</table>
		</td>
	</tr>
		

	<%if(!prd_type.equalsIgnoreCase("pR")&&!prd_type.equalsIgnoreCase("pG")){ %>
	<tr>
		<td><br>
		<table width="60%" border="0" align="center" cellpadding="3"
			cellspacing="0" class="outertable">
			<tr>
			<td>Amount to be shown in &nbsp;<select name="sel_amount"><option value="R">Rupees</option><option value="L">Lakhs</option><option value="C">Crores</option></select></td>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="2">
					<tr valign="top">
					<%if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
						<td align="center"><input type="button" name="cmdhomeprint" value="Process Note" onClick="showprocessnote('retailprocessnote.jsp')" class="buttonStyle"></td>
						<td align="center"><input type="button" name="cmdDDRprint" value="Due Diligence Report" onClick="doPrint()" class="buttonStyle"></td>
						<%}else{ %>
						<td align="center"><input type="button" name="cmdprocessnoteprint" value="Post Sanction Process Note" onClick="showprocessnote('retailprocessnote_postsanction.jsp')" class="buttonStyle"></td>
						<%}
						if(!(strStaffProduct.trim().equalsIgnoreCase("Y") || Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P"))){ %>
						<td align="center"><input type="button" name="cmdcheckprint" value="Check Eligibility" onClick="callEligibility();" class="buttonOthers"></td>
						<%} 
						if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P") && (Helper.correctNull((String)hshValues.get("govt_scheme")).equalsIgnoreCase("078")||Helper.correctNull((String)hshValues.get("govt_scheme")).equalsIgnoreCase("079"))){ %>
						<td align="center"><input type="button" name="cmdcheckprint" value="Check Eligibility" onClick="callEligibility();" class="buttonOthers"></td>
						<%} %>
						<!--  <%//if(Helper.correctNull((String)session.getAttribute("retrestructureval")).equalsIgnoreCase("Y")){ %>
					<td align="center"><input type="button" name="cmdcheckprint" value="Restructure Annexure" onClick="callRestrucAnnexure('com_resturctur_annexure.jsp');" class="buttonStyle"></td>
						<%//} %>-->
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<%}else if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
	<tr>
		<td align="center">
		Amount to be shown in &nbsp;<select name="sel_amount"><option value="R">Rupees</option><option value="L">Lakhs</option><option value="C">Crores</option></select>
		&nbsp;&nbsp;&nbsp;<input type="button" name="cmdhomeprint" value="Process Note" onClick="showprocessnote('processnote_GLDL.jsp')" class="buttonStyle"></td>
	</tr>
	<%} %>
	
	<tr>
	<td>
		</td>
	</tr>
</table>
</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail'	btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<iframe height="0" width="0" name="ifrmsancauthority" frameborder="0" style="border:0"></iframe>
<iframe height="0" width="0" name="ifrmsancbranch" frameborder="0" style="border:0"></iframe>
<input type="hidden" name="radLoan" value="Y">
<input type="hidden" name="prdcode"	value="<%=Helper.correctNull((String) hshValues.get("prdcode"))%>">
<input type="hidden" name="hidValid" value="Y">
<input type="hidden" name="txt_loantype" value="<%=strHomeplusProduct%>">
<input type="hidden" name="hidvalue"> 
<input type="hidden" name="hidPROD">
<input type="hidden" name="hidSancAuth">
<input type="hidden" name="comappid">
<input type="hidden" name="hidPrincipalRepay" value="<%=Helper.correctInt((String) hshValues.get("strMaxRepaymentperiodPrin"))%>">
<input type="hidden" name="hidInterestRepay" value="<%=Helper.correctInt((String) hshValues.get("strMaxRepaymentperiodIntr"))%>">
<input type="hidden" name="hidmclrrate" value="<%=Helper.correctDouble((String) hshValues.get("loan_mclrrate"))%>">
<input type="hidden" name="hidInterestType" value="<%=Helper.correctNull((String) hshValues.get("loan_inttype"))%>">
<input type="hidden" name="hidPSterms" value="<%=Helper.correctNull((String) hshValues.get("strModifyterms"))%>">
<input type="hidden" name="hidcreditrskpremium" value="<%=Helper.correctNull((String) hshValues.get("loan_creditrskval"))%>">
<input type="hidden" name="hidbusstrategicpremium" value="<%=Helper.correctNull((String) hshValues.get("loan_busstatval"))%>">
<input type="hidden" name="sel_mclrtype" value="<%=Helper.correctNull((String) hshValues.get("loan_mclrtype"))%>">
<input type="hidden" name="hidInterestIndexId" value="<%=Helper.correctNull((String) hshValues.get("loan_interestid"))%>">
<input type="hidden" name="txtloan_modintrate" value="<%=Helper.correctNull((String) hshValues.get("mintrate"))%>">
<input type="hidden" name="hiddevintRate" value="<%=Helper.correctNull((String) hshValues.get("dblDevIntRate"))%>">
<iframe name="ifrm" width="0" height="0" border="0"></iframe>
<iframe name="ifrminterest" width="0" height="0" border="0"></iframe>
<input type="hidden" name="hidSancAmt" value="<%=Helper.correctNull((String) hshValues.get("sanction_amount"))%>">
</form>
</body>
</html>