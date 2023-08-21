<%@include file="../share/directives.jsp"%>
<%
ArrayList arrflowpoint = (ArrayList) hshValues.get("arrflowpoint");
ArrayList arrMinclass = (ArrayList) hshValues.get("prd_minclass");
ArrayList arrWrkflwname = (ArrayList) hshValues.get("wrk_flowname");

ArrayList arrMaxclass = (ArrayList) hshValues.get("arrMaxclass");
ArrayList arrAction = (ArrayList) hshValues.get("arrAction");


ArrayList arrParam = (ArrayList) hshValues.get("arrParam");
String strDEV_SUBTYPE=Helper.correctNull((String)hshValues.get("DEV_SUBTYPE"));	
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String loan_type = Helper.correctNull((String) hshValues.get("app_loantype"));
String strProposalType = Helper.correctNull((String)session.getAttribute("strAppType"));
ArrayList arrBankRow1=(ArrayList)hshValues.get("arrDoc");
String strPrdLoanType=Helper.correctNull((String)hshValues.get("strPrdLoanType"));
String loanType=Helper.correctNull((String)hshValues.get("StrLoanTYpe"));
String StrDigiLoanType=Helper.correctNull((String)hshValues.get("StrDigiLoanType"));
if(StrDigiLoanType.equalsIgnoreCase("PR")&& !StrDigiLoanType.equalsIgnoreCase("DIGI")){
	strSessionModuleType="DIGI";
}
%>
<html>
<head>
<title>Work Flow</title>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varorghead="<%=Helper.correctNull((String) hshValues.get("orghead"))%>";
var varusrfunction="<%=Helper.correctNull((String) hshValues.get("usrfunction"))%>";
var varApproverejectBy="<%=Helper.correctNull((String) hshValues.get("ApproveRejectedby"))%>";
var strUserId='<%=(String) session.getAttribute("strUserId")%>';
var usr_class="";
var varStatus="<%=Helper.correctNull((String)hshValues.get("status"))%>";
var varApproveFlag="<%=Helper.correctNull((String)hshValues.get("strApproveFlag"))%>";
var varRejectFlag="<%=Helper.correctNull((String)hshValues.get("strRejectFlag"))%>";
var varSendFlag="<%=Helper.correctNull((String)hshValues.get("strBasicInfoFlag"))%>";
var varEnableFlag="<%=Helper.correctNull((String)hshValues.get("strEnableFlag"))%>";
var varloantype="<%=loan_type%>";
var varperm_ho_value="<%=Helper.correctNull((String)hshValues.get("PERM_HO_VALUE"))%>";
var varcon_Asses="<%=Helper.correctNull((String)hshValues.get("Int_con_Asses"))%>";
var varperm_fuinance="<%=Helper.correctNull((String)hshValues.get("PERM_FINANCE"))%>";

var varParamA="<%=Helper.correctNull((String)hshValues.get("ParamA"))%>";
var varParamB="<%=Helper.correctNull((String)hshValues.get("ParamB"))%>";

var varquery_status="<%=Helper.correctNull((String)hshValues.get("QUERY_STATUS"))%>";
var vardoc_status="<%=Helper.correctNull((String)hshValues.get("DOCUMNET_STATUS"))%>";

var varprocess_date="<%=Helper.correctNull((String)hshValues.get("DEV_PROCESSDATE"))%>";
var varrec_Comments="<%=Helper.correctNull((String)hshValues.get("strComments"))%>";
var varProposalFlag="<%=Helper.correctNull((String)hshValues.get("strProposalFlag"))%>";
var strRemarksFlag="0";
var strPrdType="<%=Helper.correctNull((String) hshValues.get("prd_type"))%>"
var varSessionModuleType="<%=strSessionModuleType%>";
var varcbsstatus="<%=Helper.correctNull((String)hshValues.get("ctrcustflag"))%>";
var varsanction="<%=Helper.correctNull((String)hshValues.get("strsanction"))%>";
var varmisapp="<%=Helper.correctNull((String)hshValues.get("MISDetails"))%>";
var varCBSDetails="<%=Helper.correctNull((String)hshValues.get("CBSDetails"))%>";
var strCoAppFreezeflag="<%=Helper.correctNull((String)hshValues.get("strCoAppFreezeflag"))%>";
var varSecurityFlag="<%=Helper.correctNull((String)hshValues.get("strSecuirtyFlag"))%>";
var varcbsaccno="<%=Helper.correctNull((String) hshValues.get("CBS_ACCOUNTNO"))%>";
var varstrFlowDateFlag="<%=Helper.correctNull((String)hshValues.get("strFlowDateFlag"))%>";
var varSendToCBSFlag = "<%=Helper.correctNull((String) hshValues.get("strSendToCBSFlag"))%>";
var varbirdata="<%=Helper.correctNull((String) hshValues.get("strbirdata"))%>";
var varcomment="<%=Helper.correctNull((String)hshValues.get("perm_sanccomments"))%>";
var varrecalculateFacility="<%=Helper.correctNull((String)hshValues.get("LOAN_RECALCULATE_FACILITY"))%>";
var varalertMsg="<%=Helper.correctNull((String) hshValues.get("resultmsg"))%>";
var varLeadstatus="<%=Helper.correctNull((String)hshValues.get("strLeadStatus"))%>";
var varamberApproval= "<%=Helper.correctNull((String)hshValues.get("amberApproval"))%>";
var strAmberCheck="<%=Helper.correctNull((String)hshValues.get("strAmberCheck"))%>";
var strUsrClass="<%=Helper.correctNull((String)hshValues.get("strUsrClass"))%>";
var strClassAuth="<%=Helper.correctNull((String)hshValues.get("strClassAuth"))%>";
var strUsrFctn="<%=Helper.correctNull((String)hshValues.get("strUsrFctn"))%>";
var varcbsid="<%=Helper.correctNull((String)hshValues.get("perCbsId"))%>";
var varRoiUpdate="<%=Helper.correctNull((String)hshValues.get("RoiUpdate"))%>";
var varCersai="<%=Helper.correctNull((String)hshValues.get("Cersai"))%>";
var varDigiSubType="<%=Helper.correctNull((String)hshValues.get("StrLoanTYpe"))%>";
var varPrdLoanType="<%=strPrdLoanType%>";
var varNonEMIPrd="<%=Helper.correctNull((String)hshValues.get("strNonEMIPrd")) %>";
var varRNEcheckflag="<%=Helper.correctNull((String)hshValues.get("strRNEcheckflag")) %>";
var varCReditRisk="<%=Helper.correctNull((String)hshValues.get("strCReditRisk")) %>";
var Varcersaidate="<%=Helper.correctNull((String)hshValues.get("cersaidate"))%>";
var VARSECCERSAIREFNO= "<%=Helper.correctNull((String)hshValues.get("SEC_CERSAIREFNO"))%>";
var VARSECSEARCHPERFORMDATE= "<%=Helper.correctNull((String)hshValues.get("SEC_SEARCHPERFORM_DATE"))%>";	
var Vargstcheck="<%=Helper.correctNull((String)hshValues.get("strgstcheck"))%>";
var VarSECALREADYMORTG="<%=Helper.correctNull((String)hshValues.get("SEC_ALREADY_MORTG"))%>";
var Varpmayexp="<%=Helper.correctNull((String)hshValues.get("pmayexp"))%>";
var Varseccroptype="<%=Helper.correctNull((String)hshValues.get("sec_croptype"))%>";
var Appholdercheck="<%=Helper.correctNull((String) hshValues.get("Appholdercheck"))%>";
var varpmayAlert="<%=Helper.correctNull((String)hshValues.get("pmayAlert"))%>";
var persend="<%=Helper.correctNull((String)hshValues.get("persend"))%>";
var sessionModuleType='<%=(String) session.getAttribute("sessionModuleType")%>';
function callQueries()
{
		 document.forms[0].hidBeanGetMethod.value="getQueryData";
		 document.forms[0].hidBeanId.value="documentsupport";
		 document.forms[0].action=appURL+"action/appqueryhome.jsp";
		 document.forms[0].submit();
}
function callOnload()
{	
	if(varStatus=="SUCCESS" ||varStatus=="success")
	{
		alert("Your application has been sent successfully");
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
	if(document.forms[0].org_name.value=="HEAD OFFICE"){

		document.all.deprt1.style.visibility="visible";
		document.all.deprt1.style.position="relative";
		document.all.deprt2.style.visibility="visible";
		document.all.deprt2.style.position="relative";
	}else{
		document.all.deprt1.style.visibility="hidden";
		document.all.deprt1.style.position="absolute";
		document.all.deprt2.style.visibility="hidden";
		document.all.deprt2.style.position="absolute";
	}
	
	document.forms[0].cmdpermit.disabled=true;
	document.forms[0].cmdreject.disabled=true;
	document.forms[0].cmdundo.disabled=true;
	document.forms[0].cmdAdditionalparameter.disabled=true;
	
	if(document.forms[0].appstatus.value=="op" || document.forms[0].appstatus.value=="Open/Pending" )
	{
		if(document.forms[0].btnenable.value.toUpperCase()=='Y')
		{
			document.forms[0].cmdpermit.disabled=false;
			document.forms[0].cmdreject.disabled=false;
		}

		if(varApproveFlag=="N")
		{
			document.forms[0].cmdpermit.disabled=true;
		}
		if(varRejectFlag=="N")
		{
			document.forms[0].cmdreject.disabled=true;
		}
	    if(varorghead=='Y' && document.forms[0].btnenable.value.toUpperCase()=='N')
		{
			document.forms[0].cmdsend.disabled=true;
			document.all["idorgselect"].style.visibility="hidden";
		}
		else
		{
			if(varusrfunction=="Delegated Authority")
			{
				document.all["idorgselect"].style.visibility="visible";
			}
			else
			{
				document.all["idorgselect"].style.visibility="hidden";
			}
		}

		if(strPrdType=="pC")
		{
			document.forms[0].cmdpermit.disabled=true;
			document.forms[0].cmdAdditionalparameter.disabled=true;
		}
	    
	}
	else
	{
    	if(varusrfunction=="Delegated Authority")
		{
			document.all["idorgselect"].style.visibility="visible";
		}
		else
		{
			document.all["idorgselect"].style.visibility="hidden";
		}

	}	
	if(document.forms[0].appstatus.value=="pa" || document.forms[0].appstatus.value=="pr" || document.forms[0].appstatus.value=="Processed/Approved" || document.forms[0].appstatus.value=="Processed/Rejected")
	{
		document.forms[0].txt_sanctioncomments.readOnly=true;
		if(varprocess_date!="Y" && varApproverejectBy==strUserId)
		{
	    	document.forms[0].cmdundo.disabled=false;
		}		
		for(var i=0;i<document.forms[0].optflowpnt.length;i++)
		{
			if(document.forms[0].txtmail_toflowpoint[i].value<9)
			{
				document.forms[0].optflowpnt[i].disabled=true;
			}
		}

		//digi - send to cbs
		if(document.forms[0].appholder.value==strUserId && document.forms[0].appstatus.value=="Processed/Approved" && varcbsaccno == "")
		{
			document.forms[0].cmdAdditionalparameter.disabled=false;
		}
		else
		{
			document.forms[0].cmdAdditionalparameter.disabled=true;
		}
			
		if(document.forms[0].btnenable.value=="Y")
		{
			if(document.forms[0].appholder.value==strUserId && (document.forms[0].appstatus.value=="Processed/Approved") && varcbsaccno == "")
			{
				document.forms[0].cmdAdditionalparameter.disabled=false;
			}
			else
			{
				document.forms[0].cmdAdditionalparameter.disabled=true;
			}
		}
		if(varSendToCBSFlag=="Y")
		{
			//document.forms[0].cmdAdditionalparameter.disabled=true;
			document.forms[0].cmdundo.disabled=true;
		}
	}	
	if(document.forms[0].appstatus.value=="ca")
	{
		document.forms[0].txt_sanctioncomments.readOnly=true;
	    document.forms[0].cmdundo.disabled=true;
	    document.forms[0].cmdsend.disabled=true;
		document.forms[0].cmdAdditionalparameter.disabled=true;
	}
	if(document.forms[0].appstatus.value=="cr")
	{
		document.forms[0].txt_sanctioncomments.readOnly=true;
	    document.forms[0].cmdundo.disabled=true;
	    document.forms[0].cmdsend.disabled=true;
		document.forms[0].cmdAdditionalparameter.disabled=true;
	}
	if(varProposalFlag=="Y")
	{
		document.forms[0].cmdundo.disabled=true;
	}
	if(varSessionModuleType!="DIGI")
	{
		document.all.sanComments.style.visibility="visible";
		document.all.sanComments.style.position="relative";
	}
	else
	{
		document.all.sanComments.style.visibility="visible";
		document.all.sanComments.style.position="relative";
	}
	if(varSessionModuleType=="DIGI")
	{
	if(document.forms[0].appstatus.value=="Processed/Approved" || document.forms[0].appstatus.value=="Closed/Approved")
	{
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

		document.forms[0].cmdpermit.disabled=true;
    	document.forms[0].cmdreject.disabled=true;
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
	}
	if(sessionModuleType=="PERM")	 
	 {
		if(persend=="Y")	
		{
			document.forms[0].cmdsend.disabled=false;	
		} 
		else if(persend=="N")
		{
			document.forms[0].cmdsend.disabled=true;	
		} 
	 }
}
function callOrgHelp()
{
		var prop = "scrollbars=no,width=300,height=300,top=100,left=250";
		var url=appURL+"action/orgnamelist.jsp?appno="+document.forms[0].appno.value;
		window.open(url,"",prop);
}
function callUsersHelp()
{
	if(document.forms[0].org_name.value=="HEAD OFFICE")
	{
		if(document.forms[0].usr_department.value=="0")
		{
			ShowAlert(111,"Department");
			document.forms[0].usr_department.focus();
			return;
		}
	}
	usr_dept=document.forms[0].usr_department.value;
	if(document.forms[0].readFlag.value.toUpperCase()=="W")
	{
		if(usr_class=="")
		{
			ShowAlert(111,"Flowpoint");	
			return;
		}
		var prop="scrollbars=no,width=400,height=350,top=100,left=250";
		var url=appURL+"action/wrkflowuserlist.jsp?usr_class="+usr_class+"&org_code="+document.forms[0].org_code.value+"&usr_dept="+usr_dept;
		window.open(url,"hai",prop);
	}
}
function doSend()
{	
	<%if(!strSessionModuleType.equalsIgnoreCase("DIGI")){%>
	if(varcon_Asses!="Y" && varParamA=="Y")
	{
		alert("Please Fill Interest concession Assessment");
		return;
	}

	if(varperm_fuinance!="Y" && varParamA=="Y")
	{
		alert("Please Fill Gist of Balance Sheet Analysis tab");
		return;
	}
	
	if(varSendFlag!="Y" )
	{
		alert("Please Fill Basic Information tab");
		return;
	}
	if(varquery_status!="Y")
	{
		alert("Queries raised, Kindly close before forwarding");
		return;
	}
	<%if(arrParam!=null && arrParam.size()>0){
		if(arrParam.contains("29")||arrParam.contains("30")||arrParam.contains("14")||arrParam.contains("15")||arrParam.contains("47")||arrParam.contains("48")){%>
	if(vardoc_status=="N")
	{
		alert("Required to attach any one of the Document for the Sanction");
		return;
	}
	<%}}%>
	<%}%>
		var logUserId=document.forms[0].txt_usrid.value;
	    var senId=document.forms[0].hidmail_tousrid.value;
	    if(trim(logUserId)==trim(senId))
	    {
	     alert("From User and Recipient User are Same");
	     return false;
	    }
		if(usr_class=="" )
		{
			ShowAlert(111,"Flowpoint");
			return;
		}
		if(document.forms[0].mail_tousrid.value=="")
		{
			ShowAlert(111,"Recipient");
			return;
		}	

		if(strRemarksFlag!="1")
		{
			if(confirm("Do you want to enter any remarks"))
			{
				strRemarksFlag="1";
				document.forms[0].hideditoption.value="Y";
				callRemarks();
				return;
			}
		}

		/*if(varrecalculateFacility=="N" && varSessionModuleType=="DIGI" && strPrdType=="pH"){
			alert("Please click on recalculate eligibility button");
			return false;
		}*/
		
		document.forms[0].cmdsend.disabled=true;
		document.forms[0].hidSourceUrl.value="/action/permworkflowaction.jsp"; 
		document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].hidBeanGetMethod.value="getAction";
		document.forms[0].hidBeanMethod.value="updateAction";
		document.forms[0].hidAction.value="send";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
}
function doUndo()
{	
	document.forms[0].cmdsend.disabled=true;
	document.forms[0].hidSourceUrl.value="/action/permworkflowhistory.jsp"; 
	document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].hidBeanGetMethod.value="getHistory";
	document.forms[0].hidBeanMethod.value="updateAction";
	document.forms[0].hidAction.value="undo";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function goUndo()
{

	document.forms[0].hidAction.value="undo";
	document.forms[0].hidBeanMethod.value="updateDigiSanctionDetails";
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="getHistory";
	document.forms[0].hidSourceUrl.value="/action/appworkflowhistory.jsp"; 
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function showSanctionDetails()
{

	if(document.forms[0].hidKFSDetails.value!="1")
	{
		alert("Please Enter Key Fact Statment Details");
		return;
	}
	
	if(varNonEMIPrd != "N")
	{
		if(strPrdType!="pG" && strPrdType!="pR")
		{
			if(varPrdLoanType!="OD" && varstrFlowDateFlag=="N")
			{
				alert("Please Enter Installment start date in Workflow -> Loan Account Details tab");
				return;
			}
		}
	}
	<%if(arrBankRow1!=null && arrBankRow1.size()>0)
	{
		if(!arrBankRow1.contains("COCTC"))
		{%>
			alert("Please Upload COCTC Document in DocumentsPost sanction Document Attachment tab");
			return;

			
		
	<%}if(loanType.equalsIgnoreCase("pR")){
		if(!arrBankRow1.contains("COCSV")){%>
		alert("Please Upload COCSV Document in DocumentsPost sanction Document Attachment tab");
		return;

	<%}}}else{%>
		alert("Please Upload Attachment in DocumentsPost sanction Document Attachment tab");
		return;
	<% } %>
	
	if(ConfirmMsg(159))
	{ 
		if(strPrdType=="pA")
		{
			document.forms[0].hidAction.value="manualCBS";
			document.forms[0].hidBeanId.value="commworkflow";
			document.forms[0].hidBeanGetMethod.value="manualloanAccountCreationService";
			document.forms[0].action=appURL+"action/appworkflowhistory.jsp";
			document.forms[0].submit();
			document.getElementById("form_blur").style.visibility="visible";
			document.getElementById("progress").style.visibility="visible";			
		}
		else
		{
			document.forms[0].moduleType.value="manualCBS";
			document.forms[0].hidBeanId.value="commworkflow";
			document.forms[0].hidBeanGetMethod.value="getAction";
			document.forms[0].hidAction.value="flatfile";
			document.forms[0].action=appURL+"action/appworkflowhistory.jsp";
			document.forms[0].submit();
		}
	}
}

function doClose()
{
	if( ConfirmMsg(100) )
	{
	    document.forms[0].action=appURL+"action/mainnav.jsp";	
		document.forms[0].submit();
	}
}

function callOtherTab(val)
{
	 if(val=="history")
	 {
		 document.forms[0].hidBeanGetMethod.value="getHistory";
		 document.forms[0].hidBeanId.value="perDeviation";
		 document.forms[0].action=appURL+"action/permworkflowhistory.jsp";
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
	 if(val=="recommendations")
	 {
			 document.forms[0].hidBeanGetMethod.value="getRecommendations";
			 document.forms[0].hidBeanId.value="perDeviation";
			document.forms[0].action=appURL+"action/permworkflowrecomments.jsp";
			document.forms[0].submit();
	 }
	 if(val=="historydigi")
	 {
		 document.forms[0].hidBeanGetMethod.value="getHistory";
		 document.forms[0].hidBeanId.value="commworkflow";
		 document.forms[0].action=appURL+"action/appworkflowhistory.jsp";
		 document.forms[0].submit();
	 }
	 if(val=="CGTMSE_TXN")
	 {
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getCGTMSE_txndet";
		document.forms[0].action=appURL+"action/app_CGTMSE_txnDet.jsp";
		document.forms[0].submit();
	 }
	 if(val=="legcomp")
	 {
		document.forms[0].app_loantype.value=varapptype;
		document.forms[0].app_legalcomp.value=varapptype;
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
}
function doPermit()
{

	if(document.forms[0].txt_sanctioncomments.value=="")
	{
		document.forms[0].txt_sanctioncomments.focus();
		ShowAlert("121","Sanctioning Authority Comments");
		return false;
	}
	
	if(varperm_ho_value!="Y" && varParamB=="Y")
	{
		alert("Required to Fill HO/RO Remarks at Interest concession Assessment tab");
		return;
	}

	if(varSendFlag!="Y" )
	{
		alert("Please Basic Information-> Basic Information tab");
		return;
	}
	if(varEnableFlag!="Y" )
	{
		alert("Please Unselect the disabled parameters--> Permission Parameters tab");
		return;
	}
	
	if(varquery_status!="Y")
	{
		alert("All the Queries yet to get the reply.Please Ensure all the queries are in Closed status.");
		return;
	}
	<%if(arrParam!=null && arrParam.size()>0){
		if(arrParam.contains("29")||arrParam.contains("30")||arrParam.contains("14")||arrParam.contains("15")||arrParam.contains("47")||arrParam.contains("48")){%>
	if(vardoc_status=="N")
	{
		alert("Required to attach any one of the Document for the Sanction");
		return;
	}
	<%}}%>
	if(varrec_Comments!="Y")
	{
		alert("Required to Fill Subject and Recommendation at Recommendations tab");
		return;
	}
	
	
	document.forms[0].cmdpermit.disabled=true;
	document.forms[0].hidAction.value="approve";
	document.forms[0].hidBeanMethod.value="updateAction";
	document.forms[0].hidBeanGetMethod.value="getHistory";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].hidSourceUrl.value="/action/permworkflowhistory.jsp"; 
	document.forms[0].submit();	
}

function goSubmit()
{
	if(varpmayAlert == 'N')
	{
		alert("Kindly Change the Govt.scheme in Loan Product Tab");
		return;
	}
	if(Varseccroptype == 'Y')
	{
		alert("Kindly Select Crop type in Home -> Securities -> Property Details");
		return;
	}
	if(Varpmayexp == 'Y' && strPrdType=="pH")
	{
		alert("Selected PMAY Scheme Expired");
		return;
	}	
	if(VarSECALREADYMORTG == 'Y')
	{
		alert("Kindly Select Whether property offered is already mortgaged to our Bank field in Home -> Securities -> Property Details ");
		return;
	}	
	
	if(Vargstcheck == 'Y' && strPrdType=="pA")
	{
		alert("Please Confirm We have verified the proforma invoice and confirm that availability of GST No.in the proforma invoice and matches with GST No, date, amount and model in the proforma invoice entered in Application/LAPS in Verification -> Loan Products");
		return;
	}	
	if(VARSECCERSAIREFNO == 'Y')
	{
		alert("Kindly Enter CERSAI Search Ref. No field in Home -> Securities -> Property Details ");
		return;
	}

	if(VARSECSEARCHPERFORMDATE == 'Y')
	{
		alert("Kindly Enter CERSAI search Date  field in Home -> Securities -> Property Details ");
		return;
	}
	if(Varcersaidate == 'Y')
	{
		alert("CERSAI search Date for Attached Securities Expired.! please modify in Home -> Securities -> Property Details ");
		return;
	}
	if(varcbsid==""){
		alert("Please update CBS Id in Loan Product --> Verification");
		return;
	}
	if(varCReditRisk=="Y"){
		alert("Credit risk Premium and Bussiness Strategic premium is zero.Please click Roi Update in loan product");
		return;
	}
	if(varLeadstatus=="N")
	{
		alert("Entered Lead no is not available in LMS");
		return;
	}
	else if(varLeadstatus!="" && varLeadstatus!="6")
	{
		alert("Status of the Lead number is not in 'In Process' status in LMS. Please update in LMS and then sanction the proposal.");
		return;
	}

	if(varRoiUpdate=="Y" && strPrdType=="pH" || varRoiUpdate=="Y" && strPrdType=="pA")
	{
		alert("Please click Roi Update in loan product")
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].hidBeanGetMethod.value="getLoanProducts";
		document.forms[0].action=appURL+"action/perDigiLoandetails.jsp";
		document.forms[0].submit();
		return;
	}
	
	
	if(varcbsstatus=="N")
	{
		alert("Please fill Verification Tab");
		return false;	
	}


	if(varamberApproval!="YN"){
	alert("Amber Approval Required");
	return;
	}
	if(varNonEMIPrd != "N")
	{
		if(varRNEcheckflag=="N" && varPrdLoanType!="OD")
		{
			alert("Loan Amount & Installment amount should be tallied");
			return;	
		}
	}
	
	
	if(parseInt(strUsrClass) < parseInt(strClassAuth))
	{
		alert("User does not have Minimum class power");
		return;
	}
	if(varsanction!="Y")
	{
		alert("Please Enter Values in Appraisal -> Loan Details");
		return false;	
	}
	
	if(varmisapp!="Y")
	{
		alert("Please Enter Values in MIS/CBS Details -> MIS Details");
		return false;	
	}
	if(varCBSDetails.toUpperCase()!="Y")
	{
		alert("Please Enter Values in MIS/CBS Details -> CBS Details");
		return;
	}

	if(varSecurityFlag!="N" )
	{
		alert("Please Attach and freeze the Securities for this Proposal");
		return;
	}
	if((strCoAppFreezeflag=="N" || strCoAppFreezeflag==""))
	  {
		 alert("Please Freeze Co-Applicant / Guarantor in Loan Particulars tab");
		 return false;
	  }
	
	if(varbirdata!="Y")
	{
		alert("Please Enter Values in BIR Details -> BIR Details");
		return false;
	}

	if(document.forms[0].txt_sanctioncomments.value=="")
	{
		  alert("Please fill Sanctioning Comments")
		return false;
	}
	
	if(varCersai!="Exist")
	{	
		alert("Please complete Proposal Terms Tab");
		return false;
		}

	var letters=/^[0-9a-zA-Z. ]+$/;
	if(!document.forms[0].txt_sanctioncomments.value.match(letters)){
	alert("Please input only alphanumeric characters  in comment box");
		return false;
		}
	
	
	document.forms[0].hidAction.value="submit";
	document.forms[0].hidBeanMethod.value="updateDigiSanctionDetails";
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="getHistory";
	document.forms[0].hidSourceUrl.value="/action/appworkflowhistory.jsp"; 
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	
}

function goReject()
{
	
	if(document.forms[0].txt_sanctioncomments.value=="")
	{
		  alert("Please fill Sanctioning Comments")
		return false;
		}
	
	document.forms[0].hidAction.value="reject";
	document.forms[0].hidBeanMethod.value="updateDigiSanctionDetails";
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="getHistory";
	document.forms[0].hidSourceUrl.value="/action/appworkflowhistory.jsp"; 
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
} 



 function doReject()
{
	document.forms[0].hidAction.value="reject";
	document.forms[0].hidBeanMethod.value="updateAction";
	document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].hidBeanGetMethod.value="getHistory";
	document.forms[0].hidSourceUrl.value="/action/permworkflowhistory.jsp"; 
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function setValues(idx,size)
{	
	if(size>1)
	{
		usr_class=document.forms[0].prd_maxclass[idx].value;	
		document.forms[0].mail_tousrid.value="";
		document.forms[0].mail_toflowpoint.value=document.forms[0].txtmail_toflowpoint[idx].value;
	}
	else
	{
		usr_class=document.forms[0].prd_maxclass.value;	
		document.forms[0].mail_tousrid.value="";
		document.forms[0].mail_toflowpoint.value=document.forms[0].txtmail_toflowpoint.value;
	}
}
function callRemarks()
{
	var prop = "scrollbars=no,width=650,height=500,top=25,left=180";
	var url=appURL+"action/workflowcomm.jsp?hidappno="+document.forms[0].appno.value+"&hiduserid="+strUserId+"&hidtoUser="+document.forms[0].mail_tousrid.value+"&editoption="+document.forms[0].hideditoption.value+"&hidtousrid="+document.forms[0].hidmail_tousrid.value;
	window.open(url,"remarks",prop);
}
function callLoanAccount()
{
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="getLoanAccountData";
	document.forms[0].action=appURL+"action/apploanaccount.jsp";
	document.forms[0].submit();
}
function permissionundo()
{
	if(document.forms[0].appstatus.value=="pa" || document.forms[0].appstatus.value=="pr" || document.forms[0].appstatus.value=="Processed/Approved" || document.forms[0].appstatus.value=="Processed/Rejected")
	{
		if(varprocess_date!="Y" && varApproverejectBy==strUserId && Appholdercheck==strUserId )
		{
	    	document.forms[0].cmdundo.disabled=false;
		}
		else
		{
			document.forms[0].cmdundo.disabled=true;
		}
	}
}

</script>
</head>
<body onLoad="callOnload();permissionundo();">
<div id="progress" style="position:absolute; width:106px; visibility:hidden; height:19px; z-index:9999999; left: 550px; top: 250px">
<img src="<%=ApplicationParams.getAppUrl()%>img/processing2.gif"></div>
<div class="overlay" id="form_blur" style="position:absolute; visibility:hidden;"></div>
<form name="frmworkflow" method="post" class="normal">
    	<%if(strSessionModuleType.equalsIgnoreCase("DIGI")) {%>
		<%if(strProposalType.equalsIgnoreCase("P")){ 
			if(!strSessionModuleType.equalsIgnoreCase("RET")){%>
			<jsp:include page="../com/postsanctionlinks.jsp" flush="true">
				<jsp:param name="pageid" value="7" />
				<jsp:param name="subpageid" value="114" />
				<jsp:param name="cattype" value="<%=strCategoryType%>" />
				<jsp:param name="ssitype" value="<%=strSSIType%>" />
			</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
			<%}else{%>
				<jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
				<jsp:param name="pageid" value="9" />
				<jsp:param name="subpageid" value="120" />
				<jsp:param name="cattype" value="<%=strCategoryType%>" />
				<jsp:param name="ssitype" value="<%=strSSIType%>" />
				</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
			<%}
			}else{ %>
			<%if(strSessionModuleType.equalsIgnoreCase("RET")||strSessionModuleType.equalsIgnoreCase("LAD")) { %> 
				<jsp:include page="../share/Applurllinkper.jsp" flush="true">
				<jsp:param name="pageid" value="7" /></jsp:include> 
 			<%}else if (strSessionModuleType.equalsIgnoreCase("DIGI")) {%>
 				<jsp:include page="../share/applurllinkerdigi.jsp" flush="true">
				<jsp:param name="pageid" value="7" />
				</jsp:include>
			<%}%>
		<%}}else{ %>
			<jsp:include page="../share/devurllinker.jsp" flush="true">
		    <jsp:param name="pageid" value="7" />
			</jsp:include>
		<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<%if(strSessionModuleType.equalsIgnoreCase("DIGI")) {%>
			<td class="page_flow">Home -&gt; Digi Retail -&gt;Application -&gt; WorkFlow -&gt; Action</td>
		<%}else{ %>
			<td class="page_flow">Home -&gt; Permission -&gt; Proposal -&gt; WorkFlow -&gt; Action</td>
		<%} %>
	</tr>
</table>
<%if(!strSessionModuleType.equalsIgnoreCase("DIGI")) {%>
<lapschoice:ApplDevHeaderTag />
<%} else{%>
<lapschoice:application /> 
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="50%" border="0" cellspacing="1" cellpadding="3"
			class="outertable">
			 <%if(strSessionModuleType.equalsIgnoreCase("DIGI")) {%>
			 <tr align="center">
					<td class="sub_tab_inactive"><a href="javascript:callOtherTab('historydigi')">History</a></td>
					<td class="sub_tab_inactive"><a  href="#" onClick="javascript:callQueries()">Queries</a></td>
					<td class="sub_tab_active">Action</td>
					<%if (Helper.correctNull((String)session.getAttribute("PRD_CGTMSE")).equalsIgnoreCase("Y")){ %>
						<td class="sub_tab_inactive" id="idCGTMSEtxn"><a href="javascript:callOtherTab('CGTMSE_TXN')">CGTMSE Transaction Details</a></td>
					<%} else { %>
						<td id="idCGTMSEtxn" style="display: none;"><input type="hidden"></td>
					<%} %>
						<td class="sub_tab_inactive"><a href="javascript:callOtherTab('drawdownschedule')">Draw Down Schedule</a></td>
						<td class="sub_tab_inactive"><a href="#" onClick="javascript:callRemarks()">Remarks</a></td>
					
					<%if (Helper.correctNull((String) hshValues.get("app_legalcomp")).equalsIgnoreCase("Y")){ %>
						<td class="sub_tab_inactive" nowrap><a href="#" onClick="javascript:callOtherTab('legcomp')">Legal Compliance Certificate</a></td>
					<% }%>
					
						<td class="sub_tab_inactive" id="idloanaccount"  nowrap="nowrap"><a href="#" onClick="javascript:callLoanAccount()">Loan Account Details</a></td>
					
					<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("S")){ %>
						<td id="idrestr" class="sub_tab_inactive" nowrap="nowrap"><a href="#" onclick="javascript:callOtherTab('restrfacdetails')">Restructure Effective Date</a></td>
					<%}else{ %>
						<td  style="display: none;"><input type="hidden" id="idrestr"></td>
					<%} %>
					
			</tr>
			 <%}else{ %>
				<tr align="center">
					<td class="sub_tab_inactive"><a
						href="javascript:callOtherTab('history')">History</a></td>
					<td class="sub_tab_inactive"><a href="javascript:callOtherTab('recommendations')">Permitting Department Recommendations</a></td>
					<td class="sub_tab_active">Action</td>
					<td class="sub_tab_inactive"><a href="#" onClick="javascript:callRemarks()">Remarks</a></td>
				</tr>
			<%} %>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable">
	<tr>
		<td width="47%" valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable">
			<tr>
				<td height="161" valign="top">
				<table width="100%" border="0" cellspacing="1" cellpadding="3"
					class="outertable">
					<tr class="dataheader">
						<td width="18%" align="center">Current Flowpoint</td>
						<td width="13%" class="datagrid" align="center"><b><%=Helper.correctNull((String) hshValues.get("dev_toflowpoint"))%>&nbsp;</b>
						<td width="16%" align="center">Received On</td>
						<td width="13%" class="datagrid" align="center"><b><%=Helper.correctNull((String) hshValues.get("dev_sentdate"))%>&nbsp;</b>
						<td width="12%" align="center">Due On</td>
						<td width="13%" class="datagrid" align="center"><b><%=Helper.correctNull((String) hshValues.get("dueon_date"))%>&nbsp;</b>
				</table>
				<table width="100%" border="0" cellspacing="1" cellpadding="3"
					class="outertable">
					<tr>
						<td valign="top">
						<%if(!strSessionModuleType.equalsIgnoreCase("DIGI")) {%>
						
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable linebor">
							<tr class="dataheader">
								<td width="7%" align="center">Select</td>
								<td width="10%" align="center">Flowpoints</td>
								<td width="10%" align="center">Min. Class</td>
								<td width="73%" align="center">Actions</td>
							</tr>

							<%
								if (arrMinclass != null && arrMinclass.size() > 0) {

									for (int i = 0; i < arrMinclass.size(); i++) {
							%>

							<tr class="datagrid">

								<td align="center"><input type="radio" name="optflowpnt" value=""  
									style="border-style: none"
									onClick="setValues(<%=i%>,<%=arrMinclass.size()%>);"></td>

								<td width="10%" align="center"><%=Helper.correctNull((String) arrflowpoint.get(i))%>
								<input type="hidden" name="txtmail_toflowpoint"
									value="<%=Helper.correctNull((String) arrflowpoint.get(i))%>">
								</td>
								<td width="10%"><%=Helper.correctNull((String) arrMinclass.get(i))%>
								<input type="hidden" name="prd_maxclass"
									value="<%=Helper.correctNull((String) arrMinclass.get(i))%>">
								<input type="hidden" name="prd_maxclass1"
									value="<%=Helper.correctNull((String) arrMinclass.get(i))%>">
								</td>
								<td width="73%" align="left"><%=Helper.correctNull((String) arrWrkflwname
											.get(i))%>
								<input type="hidden" name="wrk_flowname"
									value="<%=Helper.correctNull((String) arrWrkflwname
											.get(i))%>">
								</td>
							</tr>

							<%
								}
								}
							%>

						</table>
						<%}else{ %>
						<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
											<tr>
												<td valign="top">
												<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
													<tr class="dataheader">
														<td width="7%" align="center">Select</td>
														<td width="10%" align="center">Flowpoints</td>
														<td width="10%" align="center">Min. Class</td>
														<td width="73%" align="center">Actions</td>
													</tr>
														   <%if (arrflowpoint != null && arrflowpoint.size() > 0) {
																	for (int i = 0; i < arrflowpoint.size(); i++) {%>
															<tr class="datagrid">
																<td><input type="radio"
																	name="optflowpnt" value="" style="border-style:none"
																	onClick="setValues(<%=i%>,<%=arrflowpoint.size()%>);"></td>
																<td width="10%" bgcolor="" align="center">
																<%=Helper.correctNull((String) arrflowpoint.get(i))%>
																<input type="hidden" name="txtmail_toflowpoint" 
																	value="<%=Helper.correctNull((String) arrflowpoint.get(i))%>">
																</td>
																<td width="10%" align="left">
																<%=Helper.correctNull((String) arrMaxclass.get(i))%>
																<input type="hidden" name="prd_maxclass" value="<%=Helper.correctNull((String) arrMaxclass.get(i))%>">
																<input type="hidden" name="prd_maxclass1" value="<%=Helper.correctNull((String) arrMaxclass.get(i))%>">
																</td>
																<td width="73%" align="left">
																<%=Helper.correctNull((String) arrAction.get(i))%>
																<input type="hidden" name="wrk_flowname" value="<%=Helper.correctNull((String) arrAction.get(i))%>">
																</td>
															</tr>
															<%}			}
															%>
														</table>
														</td>
													</tr>
												</table>
												<%} %>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable">
			<tr>
				<td width="42%" valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="outertable">
					<tr>
						<td valign="top">

						<table width="93%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td width="30%" nowrap>Select Organisation</td>
								<td width="70%"><input type="text" name="org_name"
									size="35" readonly="readonly" value="<%=strOrgName%>"><span
									id="idorgselect"> <a href="#"
									onClick="javascript:callOrgHelp()"> <img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0"> </a></span></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>

				<td align="right" valign="top" width="58%">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>

								<td id="deprt1" width="16%">Department<span
									class="mantatory">*&nbsp;</span></td>

								<td id="deprt2" width="15%"><select name="usr_department">
									<option value="0">---Select---</option>

									<lapschoice:CBSStaticDataNewTag apptype='20' />
								</select></td>

								<td width="21%" align="center">Select Recipient</td>

								<td width="48%"><input type="text" name="mail_tousrid"
									size="37" readonly="readonly" value=""> <input
									type="hidden" name="hidmail_tousrid"> <a href="#"
									onClick="javascript:callUsersHelp()"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0"> </a></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			 <td>			
			</tr>
		</table>
		</td>
	</tr>
</table>
<table>
<tr id="sanComments">
				<td colspan="2">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="outertable">
					<tr>
						<td nowrap>Sanctioning Authority Comments<b><span class="mantatory">*&nbsp;</span></b></td>
						<td><textarea name="txt_sanctioncomments" cols="150" rows="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("perm_sanccomments")) %></textarea></td>
					</tr>
				</table>
				</td>
			</tr>
</table>

<%if(!strSessionModuleType.equalsIgnoreCase("DIGI")) {%>
	<lapschoice:combuttonnew btnnames='Permit_Reject_Undo_Send'  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' /> 
	<input type="hidden" name="cmdAdditionalparameter">
<%} else{%>
	<lapschoice:combuttonnew btnnames='Send'  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' /> 
 
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr align="center" >
 <td></td>
  <td><input type="button" class="buttonOthers" name="cmdpermit" value="Approve" onclick="goSubmit()"> &nbsp;
  <input type="button" class="buttonClose" name="cmdreject" value="Reject" onclick="goReject()"> &nbsp;
   <input type="button" class="buttonClose" name="cmdundo" value="Undo" onclick="goUndo()"> &nbsp;
    <input type="button" name="cmdAdditionalparameter" class="buttonStyle" value="Send To CBS" onClick="showSanctionDetails()">&nbsp;
  </td> 
</tr>
</table>


<%} %>
<input type="hidden" name="org_code" value="<%=strOrgCode%>">
<input type="hidden" name="mail_touserclass">
 <input type="hidden" name="mail_fromflowpoint" value="<%=Helper.correctNull((String) hshValues.get("dev_toflowpoint"))%>">
 <input type="hidden" name="mail_toflowpoint"> 
 <input type="hidden" name="hidcurrflowpoint" value="<%=Helper.correctNull((String) hshValues.get("dev_toflowpoint"))%>">
 <input type="hidden" name="txt_usrid" value="<%=session.getAttribute("strUserId")%>">
<input type="hidden" name="cmdsave" disabled="disabled">
<input type="hidden" name="hideditoption" value="N">
<input type="hidden" name="remarksFlag" value="false">
<input type="hidden" name="moduleType">
<input type="hidden" name="hidKFSDetails" value="<%=Helper.correctNull((String)hshValues.get("strKFSDetails"))%>">

<lapschoice:hiddentag pageid='' /></form>
</body>
</html>
