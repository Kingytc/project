<%@include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>

<%
	String strCatName = "";
	if (strCategoryType.equals("CORPORATE")
			|| strCategoryType.equals("CORP")
			|| strCategoryType.equals("SME")) {
		strCategoryType = "CORP";
		strCatName = "Corporate";

	} else if (strCategoryType.equals("OPS")) {
		strCatName = "Tertiary";
	}

	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMinimumFractionDigits(2);
	nf.setMaximumFractionDigits(2);
	nf.setGroupingUsed(false);
	ArrayList arrRow = (ArrayList) hshValues.get("arrData");
	int paramSize = 0;
	if (arrRow != null) {
		paramSize = arrRow.size();
	}
	String loantype = "",strintrate="",strint="";
	String loan_type = Helper.correctNull((String) hshValues
			.get("app_loantype"));

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
	String strProposalvalue = Helper.correctNull((String) request
			.getParameter("valuesin"));
	if (strProposalvalue.equalsIgnoreCase("C"))
		strProposalvalue = "(" + ApplicationParams.getCurrency()
				+ " in Crores)";
	else if (strProposalvalue.equalsIgnoreCase("L"))
		strProposalvalue = "(" + ApplicationParams.getCurrency()
				+ " in Lacs)";
	else if (strProposalvalue.equalsIgnoreCase("A"))
		strProposalvalue = "(" + ApplicationParams.getCurrency() + ")";
	String legalcomp = Helper.correctNull((String) hshValues
			.get("app_legalcomp"));
	String strPrdtype = Helper.correctNull((String) session.getAttribute("strProductType"));
	String strPRD_CGTMSE = Helper.correctNull((String) session.getAttribute("PRD_CGTMSE"));
String strb="",stra="";
	if (arrRow != null && arrRow.size() > 0) {

		for (int i = 0; i < arrRow.size(); i++) {
			ArrayList arrCol = (ArrayList) arrRow.get(i);
			out.println("arrCol======================="+arrCol);
			if (arrCol != null) {
// 				strint=Helper.correctNull((String) arrCol.get(0));
// 				strintrate=Helper.correctNull((String) arrCol.get(30));
// 				if(i==0)
// 				{
// 				stra=Helper.correctNull((String) arrCol.get(60));
// 				}
// 				else
// 				{
// 				strb=Helper.correctNull((String) arrCol.get(62));
// 				}
// 				out.println("stra======================="+stra);
// 				out.println("strb======================="+strb);
			}
		}
			}

%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/link.css" type="text/css" />
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css" />
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>

<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>



<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var paramSize="<%=paramSize%>";
var varcategory="<%=strCategoryType%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var facil_for = '';
var strPrdType="<%=strPrdtype%>";
var varpostsanc="<%=Helper.correctNull((String)session.getAttribute("strAppType"))%>";
var varReselect="<%=Helper.correctNull((String) hshValues.get("strReselectFlag"))%>";
var varReselectDesc="<%=Helper.correctNull((String) hshValues.get("strReselectDesc"))%>";
var varloantype="<%=loan_type%>";
var strPRD_CGTMSE="<%=strPRD_CGTMSE%>";
var varCGPan="<%=Helper.correctNull((String) hshValues.get("CGPan"))%>";
var cgtmsesplitup ="<%=(Double)hshValues.get("cgtMseSplitUp")%>";
var var_AadharNo="<%=Helper.correctNull((String)hshValues.get("PERAPP_UDYOG_AADHAR"))%>";
var varPRD_CGTMSE="<%=Helper.correctNull((String)session.getAttribute("PRD_CGTMSE"))%>";
var varparamval_CGTMSEint="<%=Helper.correctNull((String)hshValues.get("paramval_CGTMSEint"))%>";
var varCGTMSEcovLimit="<%=Helper.correctNull((String)hshValues.get("strCGTMSEcovLimit"))%>";
//var strintrate=<%=strintrate%>;
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
	}
	
	if(val=="edit")
	{	 
		
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	if(val=="rowcheck")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdsave.disabled=true;
		 document.forms[0].cmdcancel.disabled=true;		 
		 document.forms[0].cmdclose.disabled=false;	 
		 disableFields(false);
	}
	if(val=="rowselect")
	{	
	 
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
	}
	if(val=="disableall")
	{	
	 
		disableFields(true);
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
	}
	
	
}
function onLoading()
{
	//docheckintrateval();
	
	     if(paramSize!=0)
  		 {
   			disableCommandButtons("load");
   		 }
   		 else{
   		   disableCommandButtons("rowcheck");
   		 }	
	     if(document.forms[0].appstatus.value=="Processed/Approved" || document.forms[0].appstatus.value=="Closed/Approved")
	 	{
	    	 <%if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
	    	 if(strPrdType!="pG" && strPrdType!="pR")
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
	 		<%if(loan_type.equalsIgnoreCase("C") || loan_type.equalsIgnoreCase("A")){%>
	 		document.all.idfacdetail.style.visibility="visible";
	 		document.all.idfacdetail.style.position="relative";
	 		<%}}%>
	 	}
	 	else
	 	{
	 		<%if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
	 		document.all.idloanaccount.style.visibility="hidden";
	 		document.all.idloanaccount.style.position="absolute";
	 		document.all.idrestr.style.visibility="hidden";
 			document.all.idrestr.style.position="absolute";
 			//document.all.idCGTMSEtxn.style.visibility="hidden";
 			//document.all.idCGTMSEtxn.style.position="absolute";
	 		
	 		<%if(loan_type.equalsIgnoreCase("C") || loan_type.equalsIgnoreCase("A")){%>
	 		document.all.idfacdetail.style.visibility="hidden";
			document.all.idfacdetail.style.position="absolute";
			<%}}%>
	 	}
     if(document.forms[0].hidNonPoolFlag.value=="Y")
     {
    	 disableCommandButtons("disableall");
     }
        document.all.id1.style.visibility="hidden";
    	document.all.id1.style.position="absolute";

    	if(varpostsanc=="P")
    	{
	    	document.all.idexi1.style.display="none";
	    	document.all.idexi2.style.display="none";
	    	document.all.idprop1.style.display="none";
	    	document.all.idprop2.style.display="none";
	    	document.all.roi1.style.display="none";
	    	document.all.roi2.style.display="none";
	    	document.all.idsancamt1.style.display="none";
	    	document.all.idsancamt2.style.display="none";
	    	document.all.sroi1.style.display="none";
	    	document.all.sroi2.style.display="none";
    	}
}
function doEdit()
{
		
     document.forms[0].hidAction.value="update";
	 disableCommandButtons("edit");
	 document.forms[0].txt_facname.readOnly=true;
	 document.forms[0].txt_existlimit.readOnly=true;
	 document.forms[0].txt_roi.readOnly=true;
	 document.forms[0].txt_roiremarks.readOnly=true;
	 document.forms[0].txt_proposedlimit.readOnly=true;
	 if((document.forms[0].hidMSMEborrower.value=="Y") || (document.forms[0].hidfacheadid.value=="2") || (document.forms[0].hidfacheadid.value=="7" && document.forms[0].hidfacsubheadid.value=="31") || (document.forms[0].hidfacheadid.value=="7" && document.forms[0].hidfacsubheadid.value=="93"))
	 {
		 document.forms[0].txt_sanc_roi.readOnly=false;
	 }
	 else
	 {
		 document.forms[0].txt_sanc_roi.readOnly=false;
	 }
	 
	 if((document.forms[0].btnenable.value=="Y") && ((varpostsanc=="P") && (document.forms[0].hidEditFlag.value=="Y" && document.forms[0].hidParams.value!="")))
	 {
		 disableFields(true); 
		 document.forms[0].sel_status.disabled=false;
		 document.forms[0].txtarea_rejection.readOnly=false;
		 document.forms[0].txtarea_rejection.disabled=false;
		 var varPSterms = document.forms[0].hidParams.value.split("@");
		 for(var i=0;i<varPSterms.length;i++)
		 { 
			if(varPSterms[i] == "DLA"||varPSterms[i] == "INLIM")
			{
				document.forms[0].txt_sancamt.readOnly=false;
			}
			if(varPSterms[i] == "MRI"||varPSterms[i] == "BRTOMCLR")
			{
				 if((document.forms[0].hidMCLRFlag.value=="N")||(document.forms[0].hidfacheadid.value=="2") || (document.forms[0].hidfacheadid.value=="7" && document.forms[0].hidfacsubheadid.value=="31") || (document.forms[0].hidfacheadid.value=="7" && document.forms[0].hidfacsubheadid.value=="93"))
				 {
					 document.forms[0].txt_sanc_roi.readOnly=false;
				 }
				 else
				 {
					document.forms[0].txt_sanc_roi.readOnly=false;
				 }
				 
				 
				 document.forms[0].txt_dev_penality.readOnly=false;	
				 document.forms[0].txt_concession.readOnly=false;	
				 document.forms[0].txt_asper_circular.readOnly=false;	
				 document.forms[0].sel_reason.disabled=false;	
				 document.forms[0].sel_reason_con.disabled=false;	
				 document.forms[0].sel_reason_cir.disabled=false;
			}
			
		 }
	 }
}
function docheckintrateval(){
	 var varsancintrate=NanNumber(parseFloat(document.forms[0].txt_sanc_roi.value));
	 var varhidsancrate=NanNumber(parseFloat(document.forms[0].txt_roi.value));
	
	if(document.forms[0].txt_sanc_roi.value!="" && (eval(varhidsancrate)>eval(varsancintrate)||eval(varhidsancrate)<eval(varsancintrate))){
	    
	    document.all.id_roi2.style.visibility="visible";
	    document.all.id_roi2.style.position="relative";
	    
	    document.all.id_roi3.style.visibility="visible";
	    document.all.id_roi3.style.position="relative";
	    
	    document.all.id_roi4.style.visibility="visible";
	    document.all.id_roi4.style.position="relative";
	    
	    
	}
	else
	{
	    
	    document.all.id_roi2.style.visibility="hidden";
	    document.all.id_roi2.style.position="absolute";
	    
	    document.all.id_roi3.style.visibility="hidden";
	    document.all.id_roi3.style.position="absolute";
	    
	    document.all.id_roi4.style.visibility="hidden";
	    document.all.id_roi4.style.position="absolute";

			document.forms[0].txt_dev_penality.value="0.00";
			document.forms[0].txt_concession.value="0.00";
			document.forms[0].txt_asper_circular.value="0.00";
			document.forms[0].sel_reason.value="";
			document.forms[0].sel_reason_con.value="";
			document.forms[0].sel_reason_cir.value="";
	  
	    
	}
    
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
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='select-multiple')
	 	{
			document.forms[0].elements[i].disabled=val;
		}
		 
	}
	document.forms[0].txt_msmeexposure.readOnly = true;
}
function chkProposedAmt(obj)
{
var proposedamt = document.forms[0].txt_proposedlimit.value;
var sancamt = obj.value;
if(sancamt == "")
{
	sancamt=0;
}
	if(eval(proposedamt)<eval(sancamt))
	{
			alert("Sanction Amount cannot be greater than Proposed Loan Amount");
			document.forms[0].txt_sancamt.value="";
			document.forms[0].txt_sancamt.focus();
			return;
	}
	
	
}
function chkMainLimit(obj)
{
 if(document.forms[0].hidLimitName.value=="Sub")
 {
		var mainlimit = document.forms[0].hidMainSancAmt.value;
		var sancamt = obj.value;
		if(sancamt == "")
		{
			sancamt=0;
		}
		if(mainlimit == "")
		{
		  mainlimit=0;
		}
			if(eval(mainlimit)<eval(sancamt))
			{
					alert("Sub-Limit sanction amount cannot be greater than Main-Limit sanction amount");
					document.forms[0].txt_sancamt.value="";
					document.forms[0].txt_sancamt.focus();
					return;
			}
	
 }
}

function rejectFun()
{
    if((varpostsanc!="P") && (document.forms[0].sel_status.value=="R"))
    {
	 document.forms[0].txt_sanc_roi.value="";
     document.forms[0].txt_sanc_roiremarks.value="";
	 document.forms[0].txt_sancamt.value="";
	} 
	
		
    if(document.forms[0].hidLimitName.value=="Sub")
    {
         if(document.forms[0].hidMainStatus.value=="R" && document.forms[0].sel_status.value=="A")
	     {
		      //alert("Cannot approve the Sub-limit unless Main-limit is Approved");
		      alert("Sublimit cannot be sanctioned for the rejected main limit.");
		      document.forms[0].sel_status.value="";
		      return;
	     }
	     if(document.forms[0].hidMainStatus.value=="")
	     {
		      alert("Main-limit must be approved");
		      document.forms[0].sel_status.value="";
		      return;
	     }
    }

}
function doSave()
{
	if( varPRD_CGTMSE=="Y"  )
	{
	     if(varCGTMSEcovLimit=="Y")
			{
				alert("Total CGTMSE Interest rate should not exceed "+varparamval_CGTMSEint+"%");
				return;
			}
	}
	 var varsancintrate=NanNumber(parseFloat(document.forms[0].txt_sanc_roi.value));
	 var varhidsancrate=NanNumber(parseFloat(document.forms[0].txt_roi.value));
	if(eval(varhidsancrate)>eval(varsancintrate)||eval(varhidsancrate)<eval(varsancintrate)){
	     var bflag=checksancinterate();
	     if(bflag==false)
	     {
		     return;
	     }
		}
	if(eval(varhidsancrate)!=eval(varsancintrate)){
		document.forms[0].txt_hidden_flag.value="Y";
	}
	if(document.forms[0].hidIntType.value!="Flo" && false)
	{
		if(parseFloat(document.forms[0].txt_sanc_roi.value)< parseFloat(document.forms[0].hidsanc_roi.value))
		{
			alert("The Sanctioned Rate of interest cannot be lesser than the defined Interest rate of "+document.forms[0].hidsanc_roi.value+"%");
			document.forms[0].txt_sanc_roi.focus();
			return false;
		}
	}
	  if(document.forms[0].sel_status.value=="")
	  {
		ShowAlert('111',"Decision");
		return;
	  }
	  if(document.forms[0].sel_status.value=="R")
	  {
	    if(document.forms[0].txtarea_rejection.value=="")
	     {
		   ShowAlert('111',"Reason for Rejection");
		   return;
	     }
	  }

	  if(document.forms[0].sel_status.value=="A")
	  {
		 if(document.forms[0].hidfacCGTMSE.value=="Y")
		 {
			 
			var varparamval_CGTMSEint=document.forms[0].hidparamval_intrate.value;
			/* if(document.forms[0].hidappCGTMSEintrate.value=="Y")
			{
				
				alert("Total CGTMSE Interest rate should not exceed "+varparamval_CGTMSEint+"%");
				return;	
			}*/
			var varCGTMSECoveramt=eval(document.forms[0].hidappCGTMSEcovlimit.value);
			var varhidcgtmselimit=document.forms[0].hidparamval_maxlimit.value;
		
			
		<%--<%if (arrRow != null && arrRow.size() > 0) {

				for (int i = 0; i < arrRow.size(); i++) {
					ArrayList arrCol = (ArrayList) arrRow.get(i);
					{
					if(Helper.correctNull((String)arrCol.get(48)).equalsIgnoreCase("Y")){
					if(arrRow.size()>1){%>
					if(document.forms[0].opt_radio[<%=i%>].checked==false)
					{
						varCGTMSECoveramt=eval(varCGTMSECoveramt)+eval(document.forms[0].hidsancamt[<%=i%>].value);
					}
					<%}%>
					
			<%}}}}%>
         	varCGTMSECoveramt=eval(varCGTMSECoveramt)+eval(document.forms[0].txt_sancamt.value);
			if(eval(varCGTMSECoveramt)>eval(document.forms[0].hidparamval_maxlimit.value))
			{
				alert("CGTMSE Coverage of the borrower should not exceed "+document.forms[0].hidparamval_maxlimit.value);
				return;
			}--%>


         	varCGTMSECoveramt=eval(varCGTMSECoveramt)+eval(document.forms[0].txt_sancamt.value);
			if(parseFloat(varCGTMSECoveramt)>eval(document.forms[0].hidparamval_maxlimit.value))
			{
				alert("CGTMSE Coverage of the borrower should not exceed "+document.forms[0].hidparamval_maxlimit.value);
				return;
			}
			if(parseFloat(document.forms[0].txt_sancamt.value)>=parseFloat(500000))
			{
				 if(varCGPan=="" || varCGPan=="NOPAN" )
				 {
					 alert("PAN is mandatory for loan amount of Rs.5 lakh and above for coverage under CGTMSE");
					 return;
				 }
			}
			
			if(var_AadharNo=="")
			{
				alert("Please fill Udyog Aadhaar Number in Customer Profile");	
				return false;
			} 	
		 }
	  }

	  
	   if(document.forms[0].sel_status.value=="A")
	   {

		   
		   if(checktrim(document.forms[0].txt_sancamt.value)=="0.00" ||checktrim(document.forms[0].txt_sancamt.value)=="" )
		   {
		     ShowAlert('121',"Sanction Amount");
		     document.forms[0].txt_sancamt.focus();
		     return false;
		   }
		   if(facil_for!='NF')
		   {
			   if(checktrim(document.forms[0].txt_roi.value)=="0")
			   {
			    	alert("Interest value should not be 0 %");
			       return false;
			   }
	   		if(checktrim(document.forms[0].txt_sanc_roi.value)=="")
			{
	    	  ShowAlert('121',"Sanctioned Rate of Interest");
		 	 document.forms[0].txt_sanc_roi.focus();
		 	 return false;
	 		 }
		     
		   if(checktrim(document.forms[0].txt_sanc_roi.value)=="0" || checktrim(document.forms[0].txt_sanc_roi.value)=="0.00")
			{
	    	  ShowAlert("You cannot Sanction a facility with 0% Rate of Interest");
		 	 document.forms[0].txt_sanc_roi.focus();
		 	 return false;
	 		}
		   }
		   else
		   {
			   if(checktrim(document.forms[0].txt_roi.value)=="0"||checktrim(document.forms[0].txt_roi.value)=="0.00")
			   {
			    	alert("Interest value should not be 0 %");
			       return false;
			   }
		   }

		   if(document.forms[0].hidMisDetails_check.value=="Y"){
		   if(parseFloat(document.forms[0].txt_sancamt.value)!=parseFloat(document.forms[0].hidSancAmt.value))
		   {
			   if(confirm("If Sanction limit is modified user needs to reselect the activity code in MIS details tab for recalculation. Do you want to proceed?"))
			   {
				    document.forms[0].hidparam.value ="MISDEL";
			   }
			   else
			   {
				   document.forms[0].txt_sancamt.value=document.forms[0].hidSancAmt.value;
				 	 return;
			   }
		   }
		   }
      }

	   if(document.forms[0].hidIntType.value=="Flo" && document.forms[0].sel_status.value=="A")
		{
					if(document.forms[0].hidROIType.value=="O")
						document.forms[0].hidBSSval.value=roundVal(parseFloat(NanNumber(document.forms[0].txt_sanc_roi.value)) - (parseFloat(NanNumber(document.forms[0].hidMCLRspread.value))+parseFloat(NanNumber(document.forms[0].hidCRP.value))));
					else
						document.forms[0].hidCRP.value=roundVal(parseFloat(NanNumber(document.forms[0].txt_sanc_roi.value)) - (parseFloat(NanNumber(document.forms[0].hidMCLRspread.value))+parseFloat(NanNumber(document.forms[0].hidBSSval.value))));
		}
	   var str_reasonfor ="";
		for(var i=0;i<document.forms[0].sel_reason.options.length;i++)
		{
			if(document.forms[0].sel_reason.options[i].selected)
			{				
				str_reasonfor=str_reasonfor+document.forms[0].sel_reason.options[i].value+"@";
			}		
		}


		var selreason2 = "";
		
			for(var i=0;i<document.forms[0].sel_reason_con.options.length;i++)
			{
				if(document.forms[0].sel_reason_con.options[i].selected)
				{		
					selreason2=selreason2+document.forms[0].sel_reason_con.options[i].value+"@";
						
				}		
			}
		
		var selreason3 = "";
		
			for(var i=0;i<document.forms[0].sel_reason_cir.options.length;i++)
			{
				if(document.forms[0].sel_reason_cir.options[i].selected)
				{			
					selreason3=selreason3+document.forms[0].sel_reason_cir.options[i].value+"@";

				}		
			}
		
		document.forms[0].hidsel_reasonfor.value=str_reasonfor;
		document.forms[0].hidsel_reasonforconc.value=selreason2;
		document.forms[0].hidsel_reasonforcircular.value=selreason3;
        var varsancintrate=NanNumber(parseFloat(document.forms[0].txt_sanc_roi.value));
	    var varhidsancrate=NanNumber(parseFloat(document.forms[0].txt_roi.value));
	
	  if(document.forms[0].txt_sanc_roi.value!="" && (eval(varhidsancrate)>eval(varsancintrate)||eval(varhidsancrate)<eval(varsancintrate))){
	  
		if(document.forms[0].txt_dev_penality.value!="0.00" && document.forms[0].txt_dev_penality.value!="" && document.forms[0].txt_dev_penality.value!="0" && document.forms[0].txt_dev_penality.value!="undefined")
		   {
	          if(document.forms[0].hidsel_reasonfor.value==""){
	              alert("Select Reason for Deviation/Penalty");
	              return;
	          }

		   }
		   if(document.forms[0].txt_concession.value!="0.00" &&document.forms[0].txt_concession.value!=""&&document.forms[0].txt_concession.value!="0" )
		   {
	          if(document.forms[0].hidsel_reasonforconc.value==""){
	              alert("Select Reason for Concession");
	              return;
	          }

		   }
		   if(document.forms[0].txt_asper_circular.value!="0.00" && document.forms[0].txt_asper_circular.value!=""&& document.forms[0].txt_asper_circular.value!="0" )
		   {
	          if(document.forms[0].hidsel_reasonforcircular.value==""){
	              alert("Select Reason for modification of Interest as per circular");
	              return;
	          }

		   }
	}
		
	  <%  if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
	  
	  if(document.forms[0].txt_intrate_effroi.value==""){
          alert("Enter Interest Rate Effective Date");
          return;
      }
	  <%}%>
		
	  
	  
	   document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidRecordflag.value = varRecordFlag;
	    document.forms[0].hidBeanId.value="commworkflow";
	    document.forms[0].hidBeanMethod.value="updateTermsofSanctionFacilityData";
		document.forms[0].hidBeanGetMethod.value="getTermsofSanctionFacilityData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_termsofsanction.jsp";
		document.forms[0].submit();
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="com_termsofsanction.jsp";
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getTermsofSanctionFacilityData";
		document.forms[0].action=appURL +"action/com_termsofsanction.jsp";
	    document.forms[0].submit();	
	}	

}
function doClose()
{
	if(ConfirmMsg(100))
	{
		
	}
}
function doDelete()
{
	
	   if(ConfirmMsg(101))
		{	
			document.forms[0].hidAction.value ="delete";
			document.forms[0].action=appURL+"action/ControllerServlet";		
			document.forms[0].hidBeanMethod.value="updateTermsofSanctionFacilityData";
			document.forms[0].hidBeanGetMethod.value="getTermsofSanctionFacilityData";
			document.forms[0].hidBeanId.value="commworkflow";
			document.forms[0].hidSourceUrl.value="action/com_termsofsanction.jsp";	
			document.forms[0].method="post";			
			document.forms[0].submit();	
		}
    
	else
	{
		ShowAlert(158);
	}
}


function selectValues(facname,existlimit,proposedlimit,roi,facsno,sancroi,sancstatus,effpostroidate,sancamt,facheadid,facintremarks,facsancintremarks,limitname,faccategory,fac_for,reasonrej,postsancparams,editflag,facsubheadid,mclrspread,msmeborrower,msmeexposure,mclrflag,intType,BSSval,hidappCGTMSEintrate,hidparamval_intrate,hidappCGTMSEcovlimit,hidparamval_maxlimit,hidfacCGTMSE,hidMisCheck,hidCRP,hidROI,fac_approi,fac_devpenlity,fac_concession,fac_asper_cir,hidsel_reasonfor,hidintflag,hidsel_reasonforconc,hidsel_reasonforcircular)
{

	
	alert("txt_intrate_effroi"+effpostroidate+"========varpostsanc==========="+varpostsanc+"====sancroi=="+sancroi+"======hidsel_reasonforcircular======="+hidsel_reasonforcircular);
	if(varpostsanc=="P")
		{
		document.forms[0].txt_intrate_effroi.value=effpostroidate;
		}
	
	if(varReselect=="Y")
	{
		alert(varReselectDesc+" is not Available. \n So You aren't allowed for sanction with this facility.\n Please Reselect any alternative facilities in Facilities tab")
		return;
	}
	if(postsancparams!="" && document.forms[0].appstatus.value=="Open/Pending")
	{
		document.forms[0].sel_status.length=2;
		document.forms[0].sel_status.options[0] = new Option('--Select--','');
		document.forms[0].sel_status.options[1] = new Option('Approve','A');
	}
	else
	{
		document.forms[0].sel_status.length=3;
		document.forms[0].sel_status.options[0] = new Option('--Select--','');
		document.forms[0].sel_status.options[1] = new Option('Approve','A');
		document.forms[0].sel_status.options[2] = new Option('Reject','R');
	}
	facil_for = fac_for;
    document.forms[0].txt_facname.value=facname;
	document.forms[0].txt_existlimit.value=existlimit;
	document.forms[0].txt_proposedlimit.value=proposedlimit;
	document.forms[0].txt_roi.value=roi;
	document.forms[0].hidfacid.value=facsno;
	document.forms[0].txt_sanc_roi.value=sancroi;
	document.forms[0].hidsanc_roi.value=sancroi;
    document.forms[0].sel_status.value=sancstatus;
	document.forms[0].txt_sancamt.value=sancamt;
	document.forms[0].hidSancAmt.value=sancamt;
	document.forms[0].hidfacheadid.value=facheadid;
	document.forms[0].hidfacsubheadid.value=facsubheadid;
	document.forms[0].txt_roiremarks.value=facintremarks;
    document.forms[0].txt_sanc_roiremarks.value=facsancintremarks;
    document.forms[0].hidLimitName.value=limitname;
    document.forms[0].txtarea_rejection.value=reasonrej;
    document.forms[0].hidParams.value=postsancparams;
    document.forms[0].hidEditFlag.value=editflag;
    document.forms[0].hidMCLRspread.value=mclrspread;
    document.forms[0].hidMSMEborrower.value=msmeborrower;
    document.forms[0].txt_msmeexposure.value=msmeexposure;
    document.forms[0].hidMCLRFlag.value=mclrflag;
    document.forms[0].hidBSSval.value=BSSval;
    document.forms[0].hidIntType.value=intType;
    document.forms[0].hidappCGTMSEintrate.value=hidappCGTMSEintrate;
    document.forms[0].hidparamval_intrate.value=hidparamval_intrate;
    document.forms[0].hidappCGTMSEcovlimit.value=hidappCGTMSEcovlimit;
    document.forms[0].hidparamval_maxlimit.value=hidparamval_maxlimit;
    document.forms[0].hidfacCGTMSE.value=hidfacCGTMSE;
    document.forms[0].hidMisDetails_check.value=hidMisCheck;
    document.forms[0].hidCRP.value=hidCRP;
    document.forms[0].hidROIType.value=hidROI;
	document.forms[0].txt_dev_penality.value=fac_devpenlity;
	document.forms[0].txt_concession.value=fac_concession;
	document.forms[0].txt_asper_circular.value=fac_asper_cir;
	document.forms[0].txt_hidden_flag.value=hidintflag;

	
	var selreason = document.forms[0].hidsel_reasonfor.value.split("@");
	for(var j=0;j<selreason.length;j++)
	{
		for(var i=0;i<document.forms[0].sel_reason.options.length;i++)
		{
			if(document.forms[0].sel_reason.options[i].value==selreason[j])
			{			
				document.forms[0].sel_reason.options[i].selected=true;

				break;
			}		
		}
	}
	
	var selreason2 = document.forms[0].hidsel_reasonforconc.value.split("@");
	for(var j=0;j<selreason2.length;j++)
	{
		for(var i=0;i<document.forms[0].sel_reason_con.options.length;i++)
		{
			if(document.forms[0].sel_reason_con.options[i].value==selreason2[j])
			{			
				document.forms[0].sel_reason_con.options[i].selected=true;

				break;
			}		
		}
	}
	var selreason3 = document.forms[0].hidsel_reasonforcircular.value.split("@");
	for(var j=0;j<selreason3.length;j++)
	{
		for(var i=0;i<document.forms[0].sel_reason_cir.options.length;i++)
		{
			if(document.forms[0].sel_reason_cir.options[i].value==selreason3[j])
			{			
				document.forms[0].sel_reason_cir.options[i].selected=true;

				break;
			}		
		}
	}
	
    if(document.forms[0].hidMSMEborrower.value == "Y")
    {
    	document.all.idmsme1.style.display = "table-cell";
    	document.all.idmsme2.style.display = "table-cell";
    	document.forms[0].txt_msmeexposure.readOnly = true;
    }
    else
    {
    	document.all.idmsme1.style.display = "none";
    	document.all.idmsme2.style.display = "none";
    }
    
   if(document.forms[0].btnenable.value=="Y")
	{
    	if(!(faccategory=="R" && varcategory=="ADC"))
    	{
			disableCommandButtons("rowselect");
    	}
    	else
    	{
    		disableCommandButtons("rowcheck");
    	}
    	if(varpostsanc=="P" && document.forms[0].hidEditFlag.value=="N" && postsancparams=="")
    	{
        	document.forms[0].cmdedit.disabled=true;
    	}
	}
    if(document.forms[0].hidNonPoolFlag.value=="Y")
    {
   	 disableCommandButtons("disableall");
    }
    hidRejection();
    if(facil_for=='NF')
	 {
		 document.all.roi1.style.display="none";
		 document.all.roi2.style.display="none";
		 document.all.sroi1.style.display="none";
		 document.all.sroi2.style.display="none";
	 }else{
		 document.all.roi1.style.display="table-cell";
		 document.all.roi2.style.display="table-cell";
		 document.all.sroi1.style.display="table-cell";
		 document.all.sroi2.style.display="table-cell";
	 }

   if(varpostsanc=="P")
	{
	   if(document.forms[0].hidParams.value=="")
		{
	    	document.all.idexi1.style.display="table-cell";
	    	document.all.idexi2.style.display="table-cell";
	    	document.all.idexi1.style.display="table-cell";
	    	document.all.idprop2.style.display="table-cell";
	    	document.all.roi1.style.display="table-cell";
	    	document.all.roi2.style.display="table-cell";
	    	document.all.idsancamt1.style.display="table-cell";
	    	document.all.idsancamt2.style.display="table-cell";
	    	document.all.sroi1.style.display="table-cell";
	    	document.all.sroi2.style.display="table-cell";
		}
		else
		{
	    	document.all.idexi1.style.display="none";
	    	document.all.idexi2.style.display="none";
	    	document.all.idprop1.style.display="none";
	    	document.all.idprop2.style.display="none";
	    	document.all.roi1.style.display="none";
	    	document.all.roi2.style.display="none";
	    	document.all.idsancamt1.style.display="none";
	    	document.all.idsancamt2.style.display="none";
	    	document.all.sroi1.style.display="none";
	    	document.all.sroi2.style.display="none";
		}
    	 var varPSterms2=postsancparams.split("@");
    	 for(var i=0;i<varPSterms2.length;i++)
		 { 
			if(varPSterms2[i] == "DLA"||varPSterms2[i] == "INLIM")
			{
				document.all.idprop1.style.display="table-cell";
		    	document.all.idprop2.style.display="table-cell";
		    	document.all.idsancamt1.style.display="table-cell";
		    	document.all.idsancamt2.style.display="table-cell";	
			}
			if(varPSterms2[i] == "MRI"||varPSterms2[i] == "BRTOMCLR")
			{
				document.all.roi1.style.display="table-cell";
		    	document.all.roi2.style.display="table-cell";
		    	document.all.sroi1.style.display="table-cell";
				document.all.sroi2.style.display="table-cell";
			}
			
		 }
	}
	{
	 	docheckintrateval();
	}

}


function selectSubValues(facname,existlimit,proposedlimit,roi,facsno,sancroi,sancstatus,effpostroidate,sancamt,facheadid,facintremarks,facsancintremarks,mainlimitsancamt,mainsancstatus,limitname,faccategory,fac_for,reasonrejct,postsanc,Editflag,facsubheadid,mclrspread,msmeborrower,msmeexposure,mclrflag,inttype,BSSval,hidappCGTMSEintrate,hidparamval_intrate,hidappCGTMSEcovlimit,hidparamval_maxlimit,hidfacCGTMSE,hidMisCheck,hidCRP,hidROI,fac_approi,fac_devpenlity,fac_concession,fac_asper_cir,hidsel_reasonfor,hidintflag,hidsel_reasonforconc,hidsel_reasonforcircular)

{

	var date=effpostroidate;
	alert(date);
	alert("txt_intrate_effroi"+document.forms[0].txt_intrate_effroi.value+"=============="+effpostroidate);
	if(varpostsanc=="P")
		{
		document.forms[0].txt_intrate_effroi.value=effpostroidate;
		}
	
	if(postsanc!="" && document.forms[0].appstatus.value=="Open/Pending")
	{
		document.forms[0].sel_status.length=2;
		document.forms[0].sel_status.options[0] = new Option('<--Select-->','');
		document.forms[0].sel_status.options[1] = new Option('Approve','A');
	}
	else
	{
		document.forms[0].sel_status.length=3;
		document.forms[0].sel_status.options[0] = new Option('--Select--','');
		document.forms[0].sel_status.options[1] = new Option('Approve','A');
		document.forms[0].sel_status.options[2] = new Option('Reject','R');
	}
	facil_for = fac_for;
    document.forms[0].txt_facname.value=facname;
	document.forms[0].txt_existlimit.value=existlimit;
	document.forms[0].txt_proposedlimit.value=proposedlimit;
	document.forms[0].txt_roi.value=roi;
	document.forms[0].hidfacid.value=facsno;
	document.forms[0].txt_sanc_roi.value=sancroi;
	document.forms[0].hidsanc_roi.value=sancroi;
    document.forms[0].sel_status.value=sancstatus;
    document.forms[0].txt_sancamt.value=sancamt;
    document.forms[0].hidSancAmt.value=sancamt;
	document.forms[0].hidfacheadid.value=facheadid;
	document.forms[0].hidfacsubheadid.value=facsubheadid;
	document.forms[0].txt_roiremarks.value=facintremarks;
	document.forms[0].txt_sanc_roiremarks.value=facsancintremarks;
	document.forms[0].hidLimitName.value=limitname;
	document.forms[0].hidMainStatus.value=mainsancstatus;
	document.forms[0].hidMainSancAmt.value=mainlimitsancamt;
	document.forms[0].txtarea_rejection.value=reasonrejct;
	document.forms[0].hidParams.value=postsanc;
	document.forms[0].hidEditFlag.value=Editflag;
	document.forms[0].hidMCLRspread.value=mclrspread;
    document.forms[0].hidMSMEborrower.value=msmeborrower;
    document.forms[0].txt_msmeexposure.value=msmeexposure;
    document.forms[0].hidMCLRFlag.value=mclrflag;
    document.forms[0].hidBSSval.value=BSSval;
    document.forms[0].hidIntType.value=inttype;

    document.forms[0].hidappCGTMSEintrate.value=hidappCGTMSEintrate;
    document.forms[0].hidparamval_intrate.value=hidparamval_intrate;
    document.forms[0].hidappCGTMSEcovlimit.value=hidappCGTMSEcovlimit;
    document.forms[0].hidparamval_maxlimit.value=hidparamval_maxlimit;
    document.forms[0].hidfacCGTMSE.value=hidfacCGTMSE;
    document.forms[0].hidMisDetails_check.value=hidMisCheck;

    document.forms[0].hidCRP.value=hidCRP;
    document.forms[0].hidROIType.value=hidROI;

	document.forms[0].txt_dev_penality.value=fac_devpenlity;
	document.forms[0].txt_concession.value=fac_concession;
	document.forms[0].txt_asper_circular.value=fac_asper_cir;
	
	

		
		
		
	var selreason = document.forms[0].hidsel_reasonfor.value.split("@");
	for(var j=0;j<selreason.length;j++)
	{
		for(var i=0;i<document.forms[0].sel_reason.options.length;i++)
		{
			if(document.forms[0].sel_reason.options[i].value==selreason[j])
			{			
				document.forms[0].sel_reason.options[i].selected=true;

				break;
			}		
		}
	}
	var selreason2 = document.forms[0].hidsel_reasonforconc.value.split("@");
	for(var j=0;j<selreason2.length;j++)
	{
		for(var i=0;i<document.forms[0].sel_reason_con.options.length;i++)
		{
			if(document.forms[0].sel_reason_con.options[i].value==selreason2[j])
			{			
				document.forms[0].sel_reason_con.options[i].selected=true;

				break;
			}		
		}
	}
	var selreason3 = document.forms[0].hidsel_reasonforcircular.value.split("@");
	for(var j=0;j<selreason3.length;j++)
	{
		for(var i=0;i<document.forms[0].sel_reason_cir.options.length;i++)
		{
			if(document.forms[0].sel_reason_cir.options[i].value==selreason3[j])
			{			
				document.forms[0].sel_reason_cir.options[i].selected=true;

				break;
			}		
		}
	}
    if(document.forms[0].hidMSMEborrower.value == "Y")
    {
    	document.all.idmsme1.style.display = "table-cell";
    	document.all.idmsme2.style.display = "table-cell";
    	document.forms[0].txt_msmeexposure.readOnly = true;
    }
    else
    {
    	document.all.idmsme1.style.display = "none";
    	document.all.idmsme2.style.display = "none";
    }
    
	if(document.forms[0].btnenable.value=="Y")
	{
		if(!(faccategory=="R" && varcategory=="ADC"))
    	{
			disableCommandButtons("rowselect");
    	}
    	else
    	{
    		disableCommandButtons("rowcheck");
    	}

    	if(document.forms[0].hidEditFlag.value=="Y" && postsanc=="")
    	{
        	document.forms[0].cmdedit.disabled=true;
    	}
	}
	if(document.forms[0].hidNonPoolFlag.value=="Y")
    {
   	 disableCommandButtons("disableall");
    }
	hidRejection();
	if(facil_for=='NF')
	 {
		 document.all.roi1.style.display="none";
		 document.all.roi2.style.display="none";
		 document.all.sroi1.style.display="none";
		 document.all.sroi2.style.display="none";
	 }else{
		 document.all.roi1.style.display="table-cell";
		 document.all.roi2.style.display="table-cell";
		 document.all.sroi1.style.display="table-cell";
		 document.all.sroi2.style.display="table-cell";
	 }

	if(varpostsanc=="P")
	{
		if(document.forms[0].hidParams.value=="")
		{
	    	document.all.idexi1.style.display="table-cell";
	    	document.all.idexi2.style.display="table-cell";
	    	document.all.idprop1.style.display="table-cell";
	    	document.all.idprop2.style.display="table-cell";
	    	document.all.roi1.style.display="table-cell";
	    	document.all.roi2.style.display="table-cell";
	    	document.all.idsancamt1.style.display="table-cell";
	    	document.all.idsancamt2.style.display="table-cell";
	    	document.all.sroi1.style.display="table-cell";
	    	document.all.sroi2.style.display="table-cell";
		}
		else
		{
	    	document.all.idexi1.style.display="none";
	    	document.all.idexi2.style.display="none";
	    	document.all.idprop1.style.display="none";
	    	document.all.idprop2.style.display="none";
	    	document.all.roi1.style.display="none";
	    	document.all.roi2.style.display="none";
	    	document.all.idsancamt1.style.display="none";
	    	document.all.idsancamt2.style.display="none";
	    	document.all.sroi1.style.display="none";
	    	document.all.sroi2.style.display="none";
		}

    	var varPSterms1=postsanc.split("@");
   	 for(var i=0;i<varPSterms1.length;i++)
		 { 
			if(varPSterms1[i] == "DLA"||varPSterms1[i] == "INLIM")
			{
				document.all.idprop1.style.display="table-cell";
		    	document.all.idprop2.style.display="table-cell";
		    	document.all.idsancamt1.style.display="table-cell";
		    	document.all.idsancamt2.style.display="table-cell";	
			}
			if(varPSterms1[i] == "MRI"||varPSterms1[i] == "BRTOMCLR")
			{
				document.all.roi1.style.display="table-cell";
		    	document.all.roi2.style.display="table-cell";
		    	document.all.sroi1.style.display="table-cell";
				document.all.sroi2.style.display="table--cell";
			}
			
		 }
	}
	
}

function callOtherTab(val)
{
	var strCatType="<%=strCategoryType%>";
	 if(val=="history")
	 {
		 document.forms[0].hidBeanGetMethod.value="getHistory";
		 document.forms[0].action=appURL+"action/appworkflowhistory.jsp";
		 document.forms[0].submit();
	 }
	if(val=="action")
	{
		document.forms[0].hidBeanGetMethod.value="getAction";
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].cattype.value=strCatType;
		document.forms[0].action=appURL+"action/appworkflowaction.jsp";
		document.forms[0].submit();
	}
	if(val=="comments")
	{
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getWorkFlowComments";
		document.forms[0].action=appURL+"action/appworkflowcomment.jsp";
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
	if(val=="Queries")
	{
		document.forms[0].hidBeanGetMethod.value="getQueryData";
		 document.forms[0].hidBeanId.value="documentsupport";
		 document.forms[0].action=appURL+"action/appqueryhome.jsp";
		 document.forms[0].submit();
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
function hidRejection()
{
	if(document.forms[0].sel_status.value=='R')
	{
	//	document.all.txtarea_rejection.style.visibility="hidden";
		//document.all.txtarea_rejection.style.position="absolute";
		document.all.id1.style.visibility="visible";
		document.all.id1.style.position="relative";
	}
	else
	{
		//document.all.txtarea_rejection.style.visibility="visible";
		//document.all.txtarea_rejection.style.position="relative";
		document.all.id1.style.visibility="hidden";
		document.all.id1.style.position="absolute";
	}

	if(varpostsanc=="P")
	{

		if(document.forms[0].hidParams.value=="")
		{
	    	document.all.idexi1.style.display="table-cell";
	    	document.all.idexi2.style.display="table-cell";
	    	document.all.idprop1.style.display="table-cell";
	    	document.all.idprop2.style.display="table-cell";
	    	document.all.roi1.style.display="table-cell";
	    	document.all.roi2.style.display="table-cell";
	    	document.all.idsancamt1.style.display="table-cell";
	    	document.all.idsancamt2.style.display="table-cell";
	    	document.all.sroi1.style.display="table-cell";
	    	document.all.sroi2.style.display="table-cell";
		}
		else
		{
	    	document.all.idexi1.style.display="none";
	    	document.all.idexi2.style.display="none";
	    	document.all.idprop1.style.display="none";
	    	document.all.idprop2.style.display="none";
	    	document.all.roi1.style.display="none";
	    	document.all.roi2.style.display="none";
	    	document.all.idsancamt1.style.display="none";
	    	document.all.idsancamt2.style.display="none";
	    	document.all.sroi1.style.display="none";
	    	document.all.sroi2.style.display="none";
		}

    	var varPSterms3 = document.forms[0].hidParams.value.split("@");
		 for(var i=0;i<varPSterms3.length;i++)
		 { 
			if(varPSterms3[i] == "DLA"||varPSterms3[i] == "INLIM")
			{
				document.all.idprop1.style.display="table-cell";
		    	document.all.idprop2.style.display="table-cell";
		    	document.all.idsancamt1.style.display="table-cell";
		    	document.all.idsancamt2.style.display="table-cell";	
			}
			if(varPSterms3[i] == "MRI"||varPSterms3[i] == "BRTOMCLR")
			{
				document.all.roi1.style.display="table-cell";
		    	document.all.roi2.style.display="table-cell";
		    	document.all.sroi1.style.display="table-cell";
				document.all.sroi2.style.display="table-cell";
			}
			
		 }
	}
	
}
function checkZero(obj)
{
	if(parseFloat(obj.value) <= 0)
	{
		alert("The Sanctioned Rate of interest value should be greater than zero");
		obj.focus();
		obj.value = "";
		return false;
	}
}

function checkminIntrate(obj)
{

	if(document.forms[0].hidIntType.value=="Flo")
	{
		
		var vardeviationAmt=eval(document.forms[0].txt_roi.value) - eval(document.forms[0].hidMCLRspread.value)-eval(document.forms[0].hidCRP.value);
		if(document.forms[0].hidROIType.value!="O")
			vardeviationAmt=eval(document.forms[0].txt_roi.value) - eval(document.forms[0].hidMCLRspread.value)-eval(document.forms[0].hidBSSval.value);
		
		if(parseFloat(vardeviationAmt)>parseFloat(document.forms[0].hidIntDevLimit.value))
		{
			vardeviationAmt=parseFloat(document.forms[0].hidIntDevLimit.value);
		}
		var vardiff=parseFloat(NanNumber(document.forms[0].txt_roi.value))-parseFloat(vardeviationAmt);
		vardiff=roundVal(vardiff);
		if(parseFloat(document.forms[0].txt_sanc_roi.value) < parseFloat(vardiff))
		{
			alert("Interest Rate should not less than "+vardiff);
			document.forms[0].txt_sanc_roi.value="";
			document.forms[0].txt_sanc_roi.focus();
			return;
		}
	}
	else
	{

		if(document.forms[0].hidMSMEborrower.value == "N")
		{
			if(parseFloat(obj.value) < parseFloat(document.forms[0].hidMCLRspread.value))
			{
				alert("The Sanctioned Rate of interest cannot be lesser than the MCLR spread value of "+document.forms[0].hidMCLRspread.value+"%");
				obj.focus();
				obj.value = "";
				return false;
			}
		}
		else
		{
			if(parseFloat(obj.value) < parseFloat(document.forms[0].txt_roi.value))
			{
				alert("The Sanctioned Rate of interest cannot be lesser than the defined Interest rate of "+document.forms[0].txt_roi.value+"%");
				obj.focus();
				obj.value = "";
				return false;
			}
		}
	}
}
function checksancinterate()
{

	if(document.forms[0].txt_dev_penality.value==""){
		document.forms[0].txt_dev_penality.value="0.00";
	}
	if(document.forms[0].txt_concession.value==""){
		document.forms[0].txt_concession.value="0.00";
	}
	if(document.forms[0].txt_asper_circular.value==""){
		document.forms[0].txt_asper_circular.value="0.00";
	}
	
var varapplicabl_roi=parseFloat(document.forms[0].txt_roi.value);
var vardeviation=parseFloat(document.forms[0].txt_dev_penality.value);
var varconcession=parseFloat(document.forms[0].txt_concession.value);
var varasper_circular=parseFloat(document.forms[0].txt_asper_circular.value);
var varsancintrate=parseFloat(document.forms[0].txt_sanc_roi.value);

var vartot_applicable_roi=0.00;
vartot_applicable_roi=parseFloat(varapplicabl_roi)+parseFloat(vardeviation)-parseFloat(varconcession)+parseFloat(varasper_circular);
if(document.forms[0].txt_sanc_roi.value!="" ){
if(varsancintrate!=vartot_applicable_roi){
	//alert("total of applicable ROI + Deviation/Penalty-Concession +- As per circular does not tally with Sanctioned ROI");
	//return false;
}
}
}


function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		if(name=='txt_receiptcpc')
		{
			if(strOrgLevel == "R" || strOrgLevel == "C")
			{
				showCal(appURL,name);
			}
			else
			{
				alert("For CPC/RO/HO use Only");
			}
		}
		else if(name=='txt_receiptclpu')
		{
			if(strOrgLevel == "D")
			{
				showCal(appURL,name);
			}
			else
			{
				alert("For CLPU use Only");
			}
		}
		else if(name=='txt_receiptroho')
		{
			if((strOrgLevel == "R" || strOrgLevel == "C") && strOrgcode!="001001000000000")
			{
				showCal(appURL,name);
			}
			else
			{
				alert("For RO/HO use Only");
			}
		}
		else
		{
			showCal(appURL,name);
		}
	}
}
</script>
</head>
<body onload="onLoading();docheckintrateval();">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url=""><script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>
<form name="safaeri3" method="post" class="normal">
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
			<jsp:param name="subpageid" value="116" />
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
		<td>
		<%
			if (loan_type.equalsIgnoreCase("E")
					|| loan_type.equalsIgnoreCase("U")
					|| loan_type.equalsIgnoreCase("H")
					|| loan_type.equalsIgnoreCase("T")) {
		%> <jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="15" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <span style="display: none;"><lapschoice:borrowertype /></span>
		<%
			} else if (loan_type.equalsIgnoreCase("C")
					|| loan_type.equalsIgnoreCase("A")) {
		%> <jsp:include page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <span style="display: none;"><lapschoice:borrowertype /></span>
		<%
			}
		%>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<%
		if (strCategoryType.equalsIgnoreCase("SRE")) {
	%>
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Short
		Review/Extension -&gt;WorkFlow -&gt;Proposed facility Approve/Reject</td>
	</tr>
	<%
		} else if (strCategoryType.equalsIgnoreCase("STL")) {
	%>
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Short
		Term Loan -&gt;WorkFlow -&gt;Proposed facility Approve/Reject</td>
	</tr>
	<%
		} else if (strCategoryType.equalsIgnoreCase("ADC")) {
	%>
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Ad hoc
		Limit -&gt;WorkFlow -&gt;Proposed facility Approve/Reject</td>
	</tr>
	<%
		} else if (strCategoryType.equalsIgnoreCase("OPS")) {
	%>
	<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Application
		-&gt;WorkFlow -&gt;Proposed facility Approve/Reject</td>
	</tr>
	<%
		} else {
	%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt;
		Proposal -&gt; WorkFlow -&gt; Proposed facility Approve/Reject</td>
	</tr>
	<%
		}
	%>

</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<lapschoice:application />
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr>
		<td valign="bottom">
		<table border="0" cellspacing="1" cellpadding="3" align="left"
			class="outertable" width="80%">
			<tr align="center">
				<td class="sub_tab_inactive" id="action"><a
					href="javascript:callOtherTab('history')">History</a></td>
					<!-- <td class="sub_tab_inactive"><a
					href="javascript:callOtherTab('comments')">Comments</a></td> -->
					<td class="sub_tab_inactive"><a
					href="javascript:callOtherTab('Queries')">Queries</a></td>
				<td class="sub_tab_active" nowrap="nowrap">Proposed
				facility Approve/Reject</td>
				<td class="sub_tab_inactive"><a
					href="javascript:callOtherTab('action')">Action</a></td>
					<%
					if((Helper.correctNull((String)session.getAttribute("appstatus")).equalsIgnoreCase("pa")) || (Helper.correctNull((String)session.getAttribute("appstatus")).equalsIgnoreCase("ca")))
					{
					if (Helper.correctNull((String)session.getAttribute("PRD_CGTMSE")).equalsIgnoreCase("Y")){ %>
				<td class="sub_tab_inactive" id="idCGTMSEtxn"><a href="javascript:callOtherTab('CGTMSE_TXN')">CGTMSE Transaction Details</a></td>
				<%} else { %>
					<td id="idCGTMSEtxn" style="display: none;"><input type="hidden"></td>
				<% } } %>
					<td class="sub_tab_inactive"><a
					href="javascript:callOtherTab('drawdownschedule')">Draw Down Schedule</a></td>
					
				<td class="sub_tab_inactive"
					><a
					href="javascript:callOtherTab('remarks')">Remarks</a></td>
				<%
					if (Helper.correctNull((String) hshValues.get("app_legalcomp"))
							.equalsIgnoreCase("Y")) {
				%>
				<td class="sub_tab_inactive" nowrap="nowrap"><a
					href="#" onClick="javascript:callOtherTab('legcomp')">Legal
				Compliance Certificate</a></td>
				<%
					}
				%>
				<td class="sub_tab_inactive" id="idloanaccount"  nowrap="nowrap"><a href="#"
					onClick="javascript:callLoanAccount()">Loan Account Details</a></td>
					
				<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("S")){ %>
				<td id="idrestr" class="sub_tab_inactive" nowrap="nowrap"><a
					href="#" onclick="javascript:callOtherTab('restrfacdetails')">Restructure Effective Date</a></td>
					<%}else{ %>
					<td  style="display: none;"><input type="hidden" id="idrestr"></td>
					<%} %>
				<%
					if (loan_type.equalsIgnoreCase("C")
							|| loan_type.equalsIgnoreCase("A")) {
				%>
				<td class="sub_tab_inactive" id="idfacdetail"  nowrap="nowrap"><a href="#"
					onClick="javascript:callFacDetail()">Facility Details</a></td>
				<%
					}
				%>
				<td>&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="80%" border="0" cellspacing="0" cellpadding="3"
			class="outertable border1" align="center">
			<tr>
				<td valign="top">
				<table width="80%" border="0" cellspacing="0" cellpadding="3"
					class="outertable" align="center">
					<tr>
						<td valign="top">
						<table width="78%" border="0" cellspacing="1" cellpadding="3"
							align="center" class="outertable">
							<tr>
								<td width="17%" nowrap="nowrap">Nature of facilities</td>
								<td width="33%" nowrap="nowrap"><input
									type="text" name="txt_facname" size="35"
									style="text-align: left" onKeyPress="formattext()"> <input
									type="hidden" name="hidfacid" value=""><input
									type="hidden" name="hidfacheadid" value="">
									<input type="hidden" name="hidfacsubheadid" value=""></td>
								<td width="19%" nowrap="nowrap"  id="idmsme1">Borrower's MSME Exposure</td>
								<td width="31%" nowrap="nowrap"  id="idmsme2"><input type="text"
									name="txt_msmeexposure" style="text-align: right" size="24"
									onKeyPress="allowNumber(this)" maxlength="15" value="">
								</td>

							</tr>
							<tr>
								<td width="17%" nowrap="nowrap" id="idexi1">Existing Limit</td>
								<td width="33%" nowrap="nowrap"  id="idexi2"><input type="text"
									name="txt_existlimit" style="text-align: right"
									onKeyPress="allowNumber(this)" maxlength="15"
									class="interfacefields" value=""></td>
								<td width="19%" nowrap="nowrap"  id="idprop1">Proposed Limit</td>
								<td width="31%" nowrap="nowrap"  id="idprop2"><input type="text"
									name="txt_proposedlimit" style="text-align: right" size="24"
									onKeyPress="allowNumber(this)" maxlength="15" value="">
								<input type="hidden" name="hidMainSancAmt" value=""> <input
									type="hidden" name="hidLimitName" value=""> <input
									type="hidden" name="hidMainStatus" value=""></td>
							</tr>
							<tr>
								<td width="17%" nowrap="nowrap" id="roi1">Rate of Interest</td>
								<td width="33%" nowrap="nowrap" id="roi2"><input type="text"
									name="txt_roi" size="8" style="text-align: right"
									onKeyPress="allowNumber(this)" maxlength="15"
									class="interfacefields" value=""> <input type="hidden"
									name="txt_roiremarks" size="30" style="text-align: left"
									onKeyPress="" maxlength="100" class="interfacefields" value=""></td>
								<td width="19%" nowrap="nowrap" id="idsancamt1">Amount Sanctioned</td>
								<td width="31%" nowrap="nowrap"  id="idsancamt2"><input type="text"
									style="text-align: right" name="txt_sancamt" size="24"
									maxlength="100" value="" onKeyPress="allowNumber(this)"
									onBlur="chkProposedAmt(this);chkMainLimit(this);roundtxt(this)"></td>
							</tr> 
							<tr>
								<td width="17%" nowrap="nowrap" id="sroi1">Sanctioned Rate of Interest
								(%)</td>
								<td width="33%" nowrap="nowrap" id="sroi2"><input type="text"
									name="txt_sanc_roi" style="text-align: right"
									onKeyPress="allowNumber(this)" onBlur="checkPercentage(this);checkZero(this);checkminIntrate(this);docheckintrateval();"
									size="8" maxlength="15" value=""> <input type="hidden"
									name="txt_sanc_roiremarks" style="text-align: left"
									onKeyPress="" onBlur="" size="30" maxlength="100" value=""></td>

								<td width="19%" nowrap="nowrap">Decision</td>
								<td width="31%" nowrap="nowrap"><select name="sel_status"
									onChange="rejectFun();hidRejection();">
									<option value="">--Select--</option>
									<option value="A">Approve</option>
									<option value="R">Reject</option>
								</select></td>

							</tr>
							
							
							<tr id="id_roi2">
							<td width="17%" nowrap="nowrap" >Deviation/Penalty&nbsp;<span class="mantatory">(+)</span></td>
								<td width="33%" nowrap="nowrap" ><input type="text"
									name="txt_dev_penality" style="text-align: right"
									onKeyPress="allowNegativeNumber(this)" onBlur="roundtxt(this);checkPercentage(this);" 
									size="8" maxlength="5" value=""> </td>
									
								<td width="19%" nowrap="nowrap">Reason for Deviation/Penalty</td>
								<td width="31%" nowrap="nowrap"><select  multiple="multiple" name="sel_reason">
								<%if(Helper.correctNull((String) hshValues
			                     .get("app_loantype")).equalsIgnoreCase("C")){ %>
							   <lapstab:reasonformodification attrval="corp" apptype="D" />
							   <%}else{ %>
							  <lapstab:reasonformodification attrval="agr" apptype="D" />
							  <%} %>
									
								</select></td>
									
							</tr>
							<tr id="id_roi3">
								<td width="17%" nowrap="nowrap" >Concession&nbsp;<span class="mantatory">(-)</span></td>
								<td width="33%" nowrap="nowrap" ><input type="text"
									name="txt_concession" style="text-align: right"
									onKeyPress="allowNegativeNumber(this)" onBlur="roundtxt(this);checkPercentage(this);"
									size="8" maxlength="5" value=""> </td>
									
									<td width="19%" nowrap="nowrap">Reason for Concession</td>
								<td width="31%" nowrap="nowrap"><select  multiple="multiple" name="sel_reason_con">
								<%if(Helper.correctNull((String) hshValues
			                     .get("app_loantype")).equalsIgnoreCase("C")){ %>
							   <lapstab:reasonformodification attrval="corp" apptype="C"/>
							   <%}else{ %>
							  <lapstab:reasonformodification attrval="agr" apptype="C" />
							  <%} %>
								</select></td>
							</tr>
							<tr id="id_roi4">
							<td width="17%" nowrap="nowrap" >As per Circular&nbsp;<span class="mantatory">(+/-)</span></td>
							<td><laps:CurrencyTag  name="txt_asper_circular"
					           value='' size="8" maxlength="5" onBlur="roundtxt(this);checkPercentage(this);" /></td>
					           <td width="19%" nowrap="nowrap">Reason for modification of Interest as per circular</td>
								<td width="31%" nowrap="nowrap"><select  multiple="multiple" name="sel_reason_cir">
									 <%if(Helper.correctNull((String) hshValues
			                     .get("app_loantype")).equalsIgnoreCase("C")){ %>
							   <lapstab:reasonformodification attrval="corp" apptype="A" />
							   <%}else{ %>
							  <lapstab:reasonformodification attrval="agr" apptype="A" />
							  <%} %>
								</select></td>
							</tr>
							<tr id="id1">
								<td>Reason for Rejection <span class="mantatory">*</span></td>
								<td colspan="3"><textarea rows="2" cols="70" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"
									name="txtarea_rejection"></textarea></td>
							</tr>
							
							<tr id="postroi">
								<%  if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
	
	   <td><font color="#CC0000">Interest Rate Effective Date</font> (dd/mm/yyyy)&nbsp;<b><span class="mantatory">*</span></b></td>
														<td>
														<table border="0" cellspacing="0" cellpadding="3"
															class="outertable">
															<tr>
																
																
														<td><input type="text" name="txt_intrate_effroi"  size="10" onBlur="checkDate(this);checkmaxdate(this,document.forms[0].txt_intrate_effroi.value);" value="">&nbsp;
														<a alt="Select date from calender" href="#" onClick="callCalender('txt_intrate_effroi');"
														onMouseOver="window.status='Date Picker';return true;"
														onMouseOut="window.status='';return true;"><img
														src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
														border="0" alt="Select date from calender"></a></td>
												<%} %>
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
			btnnames='Edit_Save_Cancel_Delete_Audit Trail'
			btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
		<lapschoice:hiddentag pageid='<%=PageId%>' /> <br>
		</td>
	</tr>
</table>
<table width="99%" border="0" cellspacing="1" cellpadding="3"
	align="center" class="outertable">
	<tr align="center" class="dataheader">
		<td width="3%">&nbsp;</td>
		<td width="5%">S.No</td>
		<td width="15%">Facility Head</td>
		<td width="15%">Nature of facilities</td>
		<td width="10%">Type of Limit</td>
		<td width="10%">Nature of Limit</td>
		<td width="10%">Existing Limit</td>
		<td width="10%">Proposed Limit</td>
		<td width="12%">Sanctioned Amount <%=strProposalvalue%></td>
		<td width="13%">Decision</td>
	</tr>
	<%
		String strSubLimit = "",strreason="",srrintflag="",strreason1="",strreason2="",strintdate="";
		String strLimitName = "";
		String strPreCategory = "";
		String strCurCat = "";
		String strCategory = "",strFactype="";
		if (arrRow != null && arrRow.size() > 0) {

			for (int i = 0; i < arrRow.size(); i++) {
				ArrayList arrCol = (ArrayList) arrRow.get(i);
				if (arrCol != null) {
					strCurCat = Helper.correctNull((String) arrCol.get(13));
					strCategory = Helper.correctNull((String) arrCol
							.get(13));
					String strGroup = Helper.correctNull((String) arrCol
							.get(11));

					String status = Helper.correctNull((String) arrCol
							.get(31));
					if (status.trim().equalsIgnoreCase("A"))
						status = "Approve";
					else if (status.trim().equalsIgnoreCase("R"))
						status = "Reject";

					if (strGroup.trim().equals("0")) {
						strLimitName = "Main";
						
					strFactype=Helper.correctNull((String) arrCol.get(13));

					if(strFactype.equalsIgnoreCase("R"))
						strFactype="Regular Limit";
					else if(strFactype.equalsIgnoreCase("A"))
						strFactype="Adhoc Limit";
					else if(strFactype.equalsIgnoreCase("D"))
						strFactype="Additional Limit";
					else if(strFactype.equalsIgnoreCase("O"))
						strFactype="One time Limit";
					strreason=Helper.correctNull((String) arrCol.get(53));
					srrintflag=Helper.correctNull((String) arrCol.get(54));
					strreason1=Helper.correctNull((String) arrCol.get(55));
					strreason2=Helper.correctNull((String) arrCol.get(56));
						if (strPreCategory.equalsIgnoreCase("")) {
							strPreCategory = strCurCat;
							
							
	%>
	<%
		} 
						
						String effectivedate="";
						if(Helper.correctNull((String)arrCol.get(60))!=null)
						{
							effectivedate=Helper.correctNull((String)arrCol.get(60));
						}
						else
						{
							effectivedate=Helper.correctNull((String)arrCol.get(61));
						}
						out.println("effectivedate=====1======"+effectivedate);
	%>
	<tr class="datagrid">
		<td><input type="radio" style="border: none" name="opt_radio"
			value=""
			onClick="selectValues('<%=Helper
													.correctNull((String) arrCol
															.get(3))%>',
			'<%=Helper
													.correctNull((String) arrCol
															.get(6))%>',
			'<%=Helper
													.correctNull((String) arrCol
															.get(7))%>',
			'<%=Helper.correctNull((String) arrCol
											.get(18))%>',
			'<%=Helper.correctNull((String) arrCol
											.get(10))%>',
			'<%=Helper.correctNull((String) arrCol
											.get(30))%>',
			'<%=Helper.correctNull((String) arrCol
											.get(31))%>',
											'<%=(effectivedate)%>',
			'<%=Helper.correctNull((String) arrCol
											.get(32))%>',
			'<%=Helper
													.correctNull((String) arrCol
															.get(0))%>',
			'<%=Helper.correctNull((String) arrCol
											.get(25))%>',
			'<%=Helper.correctNull((String) arrCol
											.get(33))%>',
			'<%=strLimitName%>',
			'<%=Helper.correctNull((String)arrCol.get(13))%>',
			'<%=Helper.correctNull((String)arrCol.get(34))%>',
			'<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)arrCol.get(35)))%>',
			'<%=Helper.correctNull((String)arrCol.get(36))%>',
			'<%=Helper.correctNull((String)arrCol.get(37))%>',
			'<%=Helper.correctNull((String)arrCol.get(2))%>',
			'<%=Helper.correctNull((String)arrCol.get(38))%>',
			'<%=Helper.correctNull((String)arrCol.get(39))%>',
			'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(40))))%>',
			'<%=Helper.correctNull((String)arrCol.get(41))%>',
			'<%=Helper.correctNull((String)arrCol.get(42))%>',
			'<%=Helper.correctNull((String)arrCol.get(43))%>',
			'<%=Helper.correctNull((String)arrCol.get(44))%>',
			'<%=Helper.correctNull((String)arrCol.get(45))%>',
			'<%=Helper.correctNull((String)arrCol.get(46))%>',
			'<%=Helper.correctNull((String)arrCol.get(47))%>',
			'<%=Helper.correctNull((String)arrCol.get(48))%>',
			'<%=Helper.correctNull((String)arrCol.get(57))%>',
			'<%=Helper.correctNull((String)arrCol.get(58))%>',
			'<%=Helper.correctNull((String)arrCol.get(59))%>',
			'<%=Helper.correctNull((String)arrCol.get(49))%>',
			'<%=Helper.correctNull((String)arrCol.get(50))%>',
			'<%=Helper.correctNull((String)arrCol.get(51))%>',
			'<%=Helper.correctNull((String)arrCol.get(52))%>',
			'<%=Helper.correctNull((String)arrCol.get(53))%>',
			'<%=Helper.correctNull((String)arrCol.get(54))%>')">
		</td>
		<td align="center"><%=Helper.correctNull((String) arrCol
											.get(10))%></td>
		<td><%=Helper
													.correctNull((String) arrCol
															.get(1))%></td>
		<td><%=Helper
													.correctNull((String) arrCol
															.get(3))%></td>
		<td>Main-Limit</td>
		<td><%=strFactype %>&nbsp;</td>
		<td align="right"><%=nf.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(6))))%> &nbsp;</td>
		<td align="right"><%=nf.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(7))))%>&nbsp;</td>
		<td align="right"><%=nf.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(32))))%>&nbsp;
		<input type="hidden" name="hidsancamt" value="<%=Helper.correctDouble((String) arrCol.get(32)) %>"></td>
		<td><%=status%>&nbsp;</td>
	</tr>
	<%
		} else {
String effectivedate="";
						strLimitName = "Sub";
						if ((!strGroup.equals(strSubLimit))
								&& (!strGroup.trim().equals("0"))) {

							strSubLimit = strGroup;
							
							if(Helper.correctNull((String)arrCol.get(62))!=null)
							{
								effectivedate=Helper.correctNull((String)arrCol.get(62));
							}
							else
							{
								effectivedate=Helper.correctNull((String)arrCol.get(61));
							}
	%>
	<%} %>
	<tr >
		<td><input type="radio" style="border:none" name="opt_radio" value=""
			onClick="selectSubValues('<%= Helper.correctNull((String)arrCol.get(3))%>',
			'<%= Helper.correctNull((String)arrCol.get(6))%>',
			'<%= Helper.correctNull((String)arrCol.get(7))%>',
			'<%= Helper.correctNull((String)arrCol.get(16))%>',
			'<%= Helper.correctNull((String)arrCol.get(10))%>',
			'<%= Helper.correctNull((String)arrCol.get(30))%>',
			'<%= Helper.correctNull((String)arrCol.get(31))%>',
			,'<%=effectivedate%>',
			'<%= Helper.correctNull((String)arrCol.get(32))%>',
			'<%= Helper.correctNull((String)arrCol.get(0))%>',
			'<%= Helper.correctNull((String)arrCol.get(25))%>',
			'<%= Helper.correctNull((String)arrCol.get(33))%>',
			'<%= Helper.correctNull((String)arrCol.get(34))%>',
			'<%= Helper.correctNull((String)arrCol.get(35))%>',
			'<%= strLimitName%>',
			'<%= Helper.correctNull((String)arrCol.get(13))%>',
			'<%=Helper.correctNull((String)arrCol.get(36))%>',
			'<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)arrCol.get(37)))%>',
			'<%=Helper.correctNull((String)arrCol.get(38))%>',
			'<%=Helper.correctNull((String)arrCol.get(39))%>',
			'<%=Helper.correctNull((String)arrCol.get(2))%>',
			'<%=Helper.correctNull((String)arrCol.get(40))%>',
			'<%=Helper.correctNull((String)arrCol.get(41))%>',
			'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(42))))%>',
			'<%=Helper.correctNull((String)arrCol.get(43))%>','<%=Helper.correctNull((String)arrCol.get(44))%>','<%=Helper.correctNull((String)arrCol.get(45))%>'
			,'<%=Helper.correctNull((String)arrCol.get(46))%>','<%=Helper.correctNull((String)arrCol.get(47))%>',
			'<%=Helper.correctNull((String)arrCol.get(48))%>','<%=Helper.correctNull((String)arrCol.get(49))%>',
			'<%=Helper.correctNull((String)arrCol.get(50))%>','<%=Helper.correctNull((String)arrCol.get(51))%>',
			'<%=Helper.correctNull((String)arrCol.get(52))%>','<%=Helper.correctNull((String)arrCol.get(53))%>',
			'<%=Helper.correctNull((String)arrCol.get(55))%>','<%=Helper.correctNull((String)arrCol.get(56))%>',
			'<%=Helper.correctNull((String)arrCol.get(57))%>','<%=Helper.correctNull((String)arrCol.get(58))%>',
			'<%=Helper.correctNull((String)arrCol.get(59))%>','<%=Helper.correctNull((String)arrCol.get(60))%>'
			,'<%=Helper.correctNull((String)arrCol.get(61))%>')">
		</td>
		<td align="center"><%=Helper.correctNull((String) arrCol
											.get(10))%></td>
		<td><%=Helper
													.correctNull((String) arrCol
															.get(1))%></td>
		<td><%=Helper
													.correctNull((String) arrCol
															.get(3))%> 
				<%
				strFactype=Helper.correctNull((String) arrCol.get(13));

				if(strFactype.equalsIgnoreCase("R"))
					strFactype="Regular Limit";
				else if(strFactype.equalsIgnoreCase("A"))
					strFactype="Adhoc Limit";
				else if(strFactype.equalsIgnoreCase("D"))
					strFactype="Additional Limit";
				else if(strFactype.equalsIgnoreCase("O"))
					strFactype="One time Limit";										
				 status = Helper.correctNull((String) arrCol
						.get(31));
				if (status.trim().equalsIgnoreCase("A"))
					status = "Approve";
				else if (status.trim().equalsIgnoreCase("R"))
					status = "Reject";
 %>
		</td>
		<td>Sub-Limit</td>
		<td><%=strFactype %>&nbsp;</td>
		<td align="right">(<%=nf.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(6))))%>) &nbsp;</td>
		<td align="right">(<%=nf.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(7))))%>)&nbsp;</td>
		<td align="right">(<%=nf.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(32))))%>) &nbsp;
		<input type="hidden" name="hidsancamt" value="<%=Helper.correctDouble((String) arrCol.get(32)) %>"></td></td>
		<td><%=status%>&nbsp;</td>
	</tr>


	<%
		}
				}
			}
		} else {
	%>
	<tr>
		<td colspan="7" align="center">No Data</td>
	</tr>
	<%
		}
	%>
</table>
<input type="hidden" name="hidParams"> 
<input type="hidden" name="hidEditFlag"> 
<input type="hidden" name="hidMCLRspread"> 
<input type="hidden" name="hidMSMEborrower"> 
<input type="hidden" name="hidMCLRFlag"> 
<input type="hidden" name="cattype" value="<%=strCategoryType%>">
<input type="hidden" name="hidBSSval"> 
<input type="hidden" name="hidIntType"> 
<input type="hidden" name="hidIntDevLimit" value="<%= Helper.correctNull((String) hshValues.get("strIntDevLimit"))%>"> 
<input type="hidden" name="hidappCGTMSEintrate"> 
<input type="hidden" name="hidparamval_intrate"> 
<input type="hidden" name="hidappCGTMSEcovlimit"> 
<input type="hidden" name="hidparamval_maxlimit"> 
<input type="hidden" name="hidfacCGTMSE">
<input type="hidden" name="hidSancAmt" value=""> 
<input type="hidden" name="hidMisDetails_check">
<input type="hidden" name="hidsanc_roi" value="">
<input type="hidden" name="hidCRP" value="">
<input type="hidden" name="hidROIType" value="">
 <input type="hidden" name="hidsel_reasonfor" value="<%=strreason%>">
 <input type="hidden" name="txt_hidden_flag" value="<%=srrintflag%>">
  <input type="hidden" name="hidsel_reasonforconc" value="<%=strreason1%>">
 <input type="hidden" name="hidsel_reasonforcircular" value="<%=strreason2%>">
 

</form>
</body>
</html>