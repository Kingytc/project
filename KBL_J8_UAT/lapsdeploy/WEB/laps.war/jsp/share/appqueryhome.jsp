<%@include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
if(hshValues!=null)
{
	arrRow=(ArrayList)hshValues.get("arrRow");
}
String strOrgaLevel=Helper.correctNull(strOrgLevel);
String strOrgcode=Helper.correctNull(strOrgCode);
String strAppno=Helper.correctNull((String)request.getParameter("appno"));

String strCategory=Helper.correctNull((String)request.getParameter("hidCategoryType"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
if(strCategory.equals(""))
{
	strCategory=strSessionModuleType;
	session.setAttribute("sessionModuleType",strSessionModuleType);
}
if(strCategory.equals(""))
{
	strCategory=Helper.correctNull((String)hshValues.get("hidCategoryType"));
}
session.setAttribute("sessionModuleType",strCategory);
String strPgDist = Helper.correctNull(request.getParameter("hiPgDist"));
String loan_type=Helper.correctNull((String)hshValues.get("app_loantype"));
String StrDigiLoanType=Helper.correctNull((String)hshValues.get("StrDigiLoanType"));
String loantype="";
	if(loan_type.equalsIgnoreCase("P"))
	{
		loantype="Retail";
	}
	if(loan_type.equalsIgnoreCase("A"))
	{
		loantype="Agriculture";
	}

	if(loan_type.equalsIgnoreCase("c"))
	{
		loantype="Corporate";
	}
	if(loan_type.equalsIgnoreCase("T"))
	{
		loantype="Tertiary";
	}
	if(loan_type.equalsIgnoreCase("E"))
	{
		loantype="Short Review/Extension";
	}
	String strPrdtype = Helper.correctNull((String) session.getAttribute("strProductType"));
String PRD_CGTMSE = Helper.correctNull((String) hshValues.get("PRD_CGTMSE"));
String strUserid = Helper.correctNull((String) session.getAttribute("strUserId"));
%>
<html>
<head>
<title>Query/Reply</title>
<script>
var Appno="<%=strAppno%>";
var varUserID="<%=Helper.correctNull((String)session.getAttribute("strUserId"))%>";
var varCreatedUser="<%=Helper.correctNull((String) hshValues.get("strCreatedUser"))%>";
var varRepliedUser="<%=Helper.correctNull((String) hshValues.get("strRepliedUser"))%>";
var varOrgcode="<%=strOrgcode%>";
var varPageFrom="<%=Helper.correctNull((String)hshValues.get("strPageFrom"))%>";
var varQueryFlag="<%=Helper.correctNull((String)hshValues.get("strQueryFlag"))%>";
var varReplyFlag="<%=Helper.correctNull((String)hshValues.get("strReplyFlag"))%>";
var varOrgLevel="<%=strOrgLevel%>";
var strPrdType="<%=strPrdtype%>";
var varloantype="<%=loan_type%>";
function callOnLoad()
{
	disableFields(true);
	document.forms[0].cmdsendquery.disabled=true;
	document.forms[0].cmdclosequery.disabled=true;
	document.forms[0].cmdqueryreply.disabled=true;
	document.forms[0].cmdreopenquery.disabled=true;
	if(document.forms[0].btnenable.value=="N")
	{
		document.forms[0].cmdnew.disabled=true;
	}
	if(varQueryFlag=="Y")
	{
		if(varUserID==varCreatedUser)
			alert("Some Queries are in entered Status, Please click on send query to raise");
	}
	if(varReplyFlag=="Y")
	{
		if(varUserID==varRepliedUser)
			alert("Some Queries are in Send Status, Please click on Query Reply  to reply");
	}
	<% if((!strCategory.equals("PERM"))) { %>
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
	<%}%>
}
function enabledept()
{
	var orglevel = document.forms[0].sel_level.value;
	if(orglevel=="001000000000000")
	{
		document.all.hiddept1.style.display="table-cell";
	}
	else
	{
		document.all.hiddept1.style.display="none";
	}
	if(orglevel.substring(6,9)!="000" && orglevel.substring(9,15)=="000000")
	{
		document.all.hiddept2.style.display="table-cell";
	}
	else
	{
		document.all.hiddept2.style.display="none";
	}
}
function doNew()
{
	document.forms[0].hidAction.value="insert";
	enableButtons(true,true,false,true,false,true,true);
	disableFields(false);
}
function doEdit()
{
	document.forms[0].hidAction.value="update";
	enableButtons(true,true,false,true,false,true,true);
	disableFields(false);
	
	document.forms[0].txt_raisedby.readOnly=true;
	document.forms[0].txt_raisedon.readOnly=true;
	document.forms[0].txt_repliedby.readOnly=true;
	document.forms[0].txt_repliedon.readOnly=true;
	document.forms[0].txt_closedby.readOnly=true;
	document.forms[0].txt_closedon.readOnly=true;
	
	var varQueryStatus=document.forms[0].hid_queryStatus.value;
	if(varQueryStatus=="QS")
	{
		document.forms[0].hidAction.value="ReplyQuery";
		enableButtons(true,true,false,true,false,true,true);
		document.forms[0].cmdqueryreply.disabled=true;
		document.forms[0].sel_level.disabled=true;
		document.forms[0].seldepartment.disabled=true;
		document.forms[0].seldepartment1.disabled=true;
		document.forms[0].txt_query.disabled=true;
		
	}
}
function doSave()
{
	if(document.forms[0].sel_level.value=="")
	{
		alert("Select Query to be raised to Organisation");
		document.forms[0].sel_level.focus();
		return;
	}
	else if(document.forms[0].sel_level.value=="001000000000000" && document.forms[0].seldepartment.value=="")
	{
		alert("Select Department");
		document.forms[0].seldepartment.focus();
		return;
	}
	else if(((document.forms[0].sel_level.value).substring(6,9)!="000" && (document.forms[0].sel_level.value).substring(9,15)=="000000") && document.forms[0].seldepartment1.value=="")
	{
		alert("Select Department");
		document.forms[0].seldepartment1.focus();
		return;
	}
	else if(document.forms[0].txt_query.value=="")
	{
		alert("Enter Query");
		document.forms[0].txt_query.focus();
		return;
	}

	if(document.forms[0].txt_query.value!="")
	{
		val1=document.forms[0].txt_query.value;
		var arrCodePdtType=["'",'"'];
		for(var i=0;i<arrCodePdtType.length;i++){
			if(val1.indexOf(arrCodePdtType[i]) >= 0){
				alert("Special characters of ' and '' not allowed on this field");
				return;				
			}
		}
	}
	if(document.forms[0].txt_Reply_query.value!="")
	{
		val1=document.forms[0].txt_Reply_query.value;
		var arrCodePdtType=["'",'"'];
		for(var i=0;i<arrCodePdtType.length;i++){
			if(val1.indexOf(arrCodePdtType[i]) >= 0){
				alert("Special characters of ' and '' not allowed on this field");
				return;				
			}
		}
	}
	
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].sel_level.disabled=false;
	document.forms[0].seldepartment.disabled=false;
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="documentsupport";
	document.forms[0].hidBeanMethod.value="updateQueryData";
	document.forms[0].hidBeanGetMethod.value="getQueryData";
	document.forms[0].hidSourceUrl.value="/action/appqueryhome.jsp";
	document.forms[0].submit();
}
function doDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{
	document.forms[0].hidAction.value="delete";
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="documentsupport";
	document.forms[0].hidBeanMethod.value="updateQueryData";
	document.forms[0].hidBeanGetMethod.value="getQueryData";
	document.forms[0].hidSourceUrl.value="/action/appqueryhome.jsp";
	document.forms[0].submit();
	}
}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
	document.forms[0].hidBeanId.value="documentsupport";
	document.forms[0].hidBeanGetMethod.value="getQueryData";
	document.forms[0].action=appURL+"action/appqueryhome.jsp";
	document.forms[0].submit();
	 }
}
function doPrint()
{	
	var varQryString = appURL+"action/appprintquery.jsp?hidBeanId=perDeviation&hidBeanGetMethod=getPrintDetails&appno="+Appno;
	var title1 = "PrintQueryDetails";
	var prop1 = "scrollbars=yes,width=1200,height=600,menubar=yes,address=no,status=yes,left=0,top=0";	
	window.open(varQryString,title1,prop1);
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function disableFields(val)
{
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  if(document.forms[0].elements[i].type=='textarea'  )
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
		  if(document.forms[0].elements[i].type=='select-one' )
		  {
				document.forms[0].elements[i].disabled=val;
		  }
		  if(document.forms[0].elements[i].type=='text' )
		  {
				document.forms[0].elements[i].readOnly=val;
		  }
	  }
	  //document.forms[0].mail_tousrid.readOnly=true;
}
function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6,bool7)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdcancel.disabled=bool5;
	document.forms[0].cmdprint.disabled=false;
	document.forms[0].cmdclose.disabled=bool7;
}
function selectValues(val0,val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val17,val18,val19,val20,val21,val22,val23)
{
	//alert("val0===="+val0+"====val1==="+val1+"val2====="+val2+"====val3==="+val3+"=====val4==="+val4);
	//alert("val5===="+val5+"====val6==="+val6+"val7====="+val7+"====val8==="+val8+"=====val9==="+val9);
	//alert("val10===="+val10+"====val11==="+val11+"val17====="+val17+"====val18==="+val18+"=====val19==="+val19);
	//alert("val20===="+val20+"====val21==="+val21+"val22====="+val22+"====val23==="+val23);
	
	document.forms[0].hid_queryStatus.value=val5;
	document.forms[0].hid_parentid.value=val17;
	document.forms[0].cmdsendquery.disabled=true;
	document.forms[0].cmdclosequery.disabled=true;
	document.forms[0].cmdqueryreply.disabled=true;
	document.forms[0].cmdreopenquery.disabled=true;
	
	document.forms[0].cmdsendquery.disabled=true;
	document.forms[0].hidsno.value=val0;
	document.forms[0].sel_level.value=val1;
	if(document.forms[0].sel_level.value=="001000000000000")
	{
		document.forms[0].seldepartment.value=val2;
	}
	else if(val1.substring(6,9)!="000" && val1.substring(9,15)=="000000")
	{
		document.forms[0].seldepartment1.value=val2;
	}
	document.forms[0].txt_query.value=val3;
	document.forms[0].txt_Reply_query.value=val10;
	enabledept();
	
	enableButtons(true,true,true,true,true,true,false);
	document.forms[0].txt_raisedby.value=val4+"-"+val19;
	document.forms[0].txt_raisedon.value=val18;
	document.forms[0].txt_repliedby.value=val6+"-"+val20;
	document.forms[0].txt_repliedon.value=val7;
	document.forms[0].txt_closedby.value=val8+"-"+val21;
	document.forms[0].txt_closedon.value=val9;

	document.all.idreply.style.display="none";
	document.all.idreply1.style.display="none";
	document.all.idreply2.style.display="none";
	document.all.idreply3.style.display="none";
	document.all.idclose.style.display="none";
	document.all.idclose1.style.display="none";
	document.all.idclose2.style.display="none";
	document.all.idclose3.style.display="none";
	document.all.idraised.style.display="none";
	document.all.idraised1.style.display="none";
	document.all.idraised2.style.display="none";
	document.all.idraised3.style.display="none";
	if(val5=="QR")
	{
		document.all.idreply.style.display="table-cell";
		document.all.idreply1.style.display="table-cell";
		document.all.idreply2.style.display="table-cell";
		document.all.idreply3.style.display="table-cell";
		document.all.id_Qreply.style.display="table-cell"; 
		document.all.id_Qreply1.style.display="table-cell"; 
		document.forms[0].cmdqueryreply.disabled=true;
		if(val11=="Y" && val6!=varUserID)
		{
			document.forms[0].cmdclosequery.disabled=false;
			document.forms[0].cmdreopenquery.disabled=false;
		}
		document.all.idraised.style.display="table-cell";
		document.all.idraised1.style.display="table-cell";
		document.all.idraised2.style.display="table-cell";
		document.all.idraised3.style.display="table-cell";
	}
	else if(val5=="QC")
	{
		document.all.idreply.style.display="table-cell";
		document.all.idreply1.style.display="table-cell";
		document.all.idreply2.style.display="table-cell";
		document.all.idreply3.style.display="table-rcellow";
		document.all.idclose.style.display="table-cell";
		document.all.idclose1.style.display="table-cell";
		document.all.idclose2.style.display="table-cell";
		document.all.idclose3.style.display="table-cell";
		document.forms[0].cmdqueryreply.disabled=true;
		document.all.id_Qreply.style.display="table-cell"; 
		document.all.id_Qreply1.style.display="table-cell"; 
		document.all.idraised.style.display="table-cell";
		document.all.idraised1.style.display="table-cell";
		document.all.idraised2.style.display="table-cell";
		document.all.idraised3.style.display="table-cell";

	}
	else if(val5=="QS")
	{
		if(val1==varOrgcode)
		{
			if(varUserID!=val4)
			{
				enableButtons(true,false,true,false,true,true,false);
				document.all.id_Qreply.style.display="table-cell";
				document.all.id_Qreply1.style.display="table-cell";
				document.forms[0].cmdqueryreply.disabled=false;
				document.forms[0].txt_Reply_query.readOnly=true;
			}
			else
			{
				document.all.id_Qreply.style.display="none"; 
				document.all.id_Qreply1.style.display="none"; 
				document.forms[0].cmdqueryreply.disabled=true;
				document.forms[0].txt_Reply_query.readOnly=true;
			}
		}
		else
		{
			document.all.id_Qreply.style.display="none"; 
			document.all.id_Qreply1.style.display="none"; 
			document.forms[0].cmdqueryreply.disabled=true;
			document.forms[0].txt_Reply_query.readOnly=true;
		}
		document.forms[0].cmddelete.disabled=true;
		document.all.idraised.style.display="table-cell";
		document.all.idraised1.style.display="table-cell";
		document.all.idraised2.style.display="table-cell";
		document.all.idraised3.style.display="table-cell";
	}
	else if(val5=="QO")
	{
		document.all.idreply.style.display="table-cell";
		document.all.idreply1.style.display="table-cell";
		document.all.idreply2.style.display="table-cell";
		document.all.idreply3.style.display="table-cell";
		document.all.id_Qreply.style.display="table-cell"; 
		document.all.id_Qreply1.style.display="table-cell"; 
		document.all.idraised.style.display="table-cell";
		document.all.idraised1.style.display="table-cell";
		document.all.idraised2.style.display="table-cell";
		document.all.idraised3.style.display="table-cell";

		if(val11=="Y" && val6!=varUserID && val22=="0")
		{
			document.forms[0].cmdclosequery.disabled=false;
			document.forms[0].cmdreopenquery.disabled=false;
		}
		if(varUserID==val4 && val22=="0")
		{
			document.forms[0].cmdreopenquery.disabled=false;
		}
	}
	else if(val5=="QE")
	{
		document.all.idraised.style.display="none";
		document.all.idraised1.style.display="none";
		document.all.idraised2.style.display="none";
		document.all.idraised3.style.display="none";
		document.all.idreply.style.display="none";
		document.all.idreply1.style.display="none";
		document.all.idreply2.style.display="none";
		document.all.idreply3.style.display="none";
		document.all.id_Qreply.style.display="none";
		document.all.id_Qreply1.style.display="none";

		//if(document.forms[0].btnenable.value=="Y")
		{
			if(val23==varOrgcode){
			enableButtons(true,false,true,false,true,true,false);
			document.forms[0].cmdsendquery.disabled=false;
			document.all.idrec.style.display="table-cell";
			}
		}
		 
	}	
	if(varUserID==val4)
	{
		if(val5=="QR" || (val5=="QO" && val22=="0"))
		{
			 document.forms[0].cmdclosequery.disabled=false;
		}
		else
		{
			 document.forms[0].cmdclosequery.disabled=true;
		}
	}
}
function callUsersHelp()
{
	var usr_dept="";
	if(document.forms[0].sel_level.value=="001000000000000")
	{
		if(document.forms[0].seldepartment.value=="0")
		{
			ShowAlert(111,"Department");
			document.forms[0].seldepartment.focus();
			return;
		}
	}
	usr_dept=document.forms[0].seldepartment.value;
	
	var prop="scrollbars=no,width=400,height=350,top=100,left=250";
	var url=appURL+"action/QryUsersList.jsp?org_code="+document.forms[0].sel_level.value+"&usr_dept="+usr_dept+"&appno="+document.forms[0].appno.value+"&strModuleType=PER";
	window.open(url,"hai",prop);
}
function doSendQuery()
{
	/*if(document.forms[0].mail_tousrid.value=="")
	{
		ShowAlert(111,"Raised to");
		return;
	}
	else if(document.forms[0].hidmail_tousrid.value==varUserID)
	{
		alert("Sender cannot be a recipient");
		return;
	}*/
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidAction.value="SendQuery";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="documentsupport";
	document.forms[0].hidBeanMethod.value="updateQueryData";
	document.forms[0].hidBeanGetMethod.value="getQueryData";
	document.forms[0].hidSourceUrl.value="/action/appqueryhome.jsp";
	document.forms[0].submit();
}

function doCloseQuery()
{
	if(document.forms[0].sel_level.value=="001000000000000" && varOrgcode=="001000000000000")
	{
		alert("You cannot close a query which is raised by another HO");
		return false;
	}
	document.forms[0].hidAction.value="CloseQuery";
	document.forms[0].hidBeanId.value="documentsupport";
	document.forms[0].hidBeanMethod.value="UpdateQueryDetails";
	document.forms[0].hidBeanGetMethod.value="getQueryData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/appqueryhome.jsp";
	document.forms[0].submit();
}
function doReopenQuery()
{
	/*document.forms[0].sel_level.disabled=false;
	document.forms[0].hidAction.value="ReOpenQuery";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="documentsupport";
	document.forms[0].hidBeanMethod.value="updateQueryData";
	document.forms[0].hidBeanGetMethod.value="getQueryData";
	document.forms[0].hidSourceUrl.value="/action/appqueryhome.jsp";
	document.forms[0].submit();*/

	document.forms[0].hidAction.value="ReOpenQuery";
	document.forms[0].txt_query.value="";
	document.forms[0].txt_query.readOnly=false;
	document.all.idraised.style.display="none";
	document.all.idraised1.style.display="none";
	document.all.idraised2.style.display="none";
	document.all.idraised3.style.display="none";
	document.all.idreply.style.display="none";
	document.all.idreply1.style.display="none";
	document.all.idreply2.style.display="none";
	document.all.idreply3.style.display="none";
	document.all.id_Qreply.style.display="none";
	document.all.id_Qreply1.style.display="none";
	enableButtons(true,true,false,true,false,true,true);
	document.forms[0].cmdsendquery.disabled=true;
	document.forms[0].cmdclosequery.disabled=true;
	document.forms[0].cmdqueryreply.disabled=true;
	document.forms[0].cmdreopenquery.disabled=true;
}

function doQueryReply()
{
	if(document.forms[0].txt_Reply_query.value=="")
	{
		alert("Please enter Reply");
		document.forms[0].txt_Reply_query.focus();
		return false;
	}
		document.forms[0].hidAction.value="reply";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="documentsupport";
		document.forms[0].hidBeanMethod.value="UpdateQueryDetails";
		document.forms[0].hidBeanGetMethod.value="getQueryData";
		document.forms[0].hidSourceUrl.value="/action/appqueryhome.jsp";
		document.forms[0].submit();
}
function chkorg()
{
	if(document.forms[0].sel_level.value==varOrgcode)
	{
		alert("You cannot raise a query with in a organisation");
		document.forms[0].sel_level.value="";
		document.forms[0].sel_level.focus();
	}
}
function callOtherTab(val)
{
	var strCatType="<%=strCategoryType%>";
	if(document.forms[0].cmdsave.disabled)
	{	
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
	if(val=="history")
	{
		 document.forms[0].hidBeanGetMethod.value="getHistory";
		 document.forms[0].action=appURL+"action/appworkflowhistory.jsp";
		 document.forms[0].submit();
	}
	if(val=="legcomp")
	{
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getlegalComplianceData";
		document.forms[0].action=appURL+"action/legalcompliance.jsp";
		document.forms[0].submit();
	}
	if(val=="facdetail")
	{
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getFacilityDetailsData";
		document.forms[0].action=appURL+"action/appfacilitydetails.jsp";
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
	 if(val=="history_perm")
	 {
		 document.forms[0].hidBeanGetMethod.value="getHistory";
		 document.forms[0].hidBeanId.value="perDeviation";
		 document.forms[0].action=appURL+"action/permworkflowhistory.jsp";
		 document.forms[0].submit();
	 }
	 if(val=="recommendations")
		{
			 document.forms[0].hidBeanGetMethod.value="getRecommendations";
			 document.forms[0].hidBeanId.value="perDeviation";
			document.forms[0].action=appURL+"action/permworkflowrecomments.jsp";
			document.forms[0].submit();
		}
	 if(val=="action_perm")
		{
			document.forms[0].hidBeanGetMethod.value="getAction";
			document.forms[0].hidBeanId.value="perDeviation";
			document.forms[0].action=appURL+"action/permworkflowaction.jsp";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
}
function callLoanAccount()
{
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="getLoanAccountData";
	document.forms[0].action=appURL+"action/apploanaccount.jsp";
	document.forms[0].submit();
}


</script>
</head>
<body onload="callOnLoad();">
<form name="frm" method="post" class="normal">
    <% if(strCategory.equals("PERM")) { %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/devurllinker.jsp" flush="true">
			<jsp:param name="pageid" value="6" />
		</jsp:include></td>
	</tr>
	
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Permission -&gt; Proposal -&gt;
		Queries</td>
	</tr>
</table>
<lapschoice:ApplDevHeaderTag /> <br>
<% } %>
<% if(!strCategory.equals("PERM")) {
     if(strCategory.equalsIgnoreCase("RET") ||strCategory.equals("LAD")){%>
      	 <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
      	<jsp:param name="pageid" value="7" />
      	</jsp:include> 
      	
    <%}else if(strCategory.equalsIgnoreCase("CORP")  || strCategory.equalsIgnoreCase("AGR")){ %>
      	<jsp:include page="../com/proposallinks.jsp" flush="true"> 
      	<jsp:param name="pageid" value="7" />
      	<jsp:param name="cattype" value="<%=strCategoryType%>" />
      	<jsp:param name="ssitype" value="<%=strSSIType%>" />
      	</jsp:include>
      	<span style="display:none;"><lapschoice:borrowertype /></span> 
	<%}%>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <%if(strSessionModuleType.equals("AGR")){%>
	 <tr>
		 <td class="page_flow"> Home -&gt; Agriculture -&gt; Proposal -&gt; WorkFlow -&gt; Queries</td>
	</tr>
	<%}
	else if(strSessionModuleType.equals("LAD"))
    {
    %> 
    <tr>
    <td class="page_flow"> Home -&gt; Loan Against Gold Ornaments &amp; Deposits -&gt; WorkFlow -&gt; Queries</td></tr>
    <%}else if (strSessionModuleType.equalsIgnoreCase("RET")) {%>
	<tr>
		 <td class="page_flow">Home -&gt; Retail  -&gt;Application -&gt; WorkFlow -&gt;
		Queries</td>
	</tr> 
	<%} else if (strCategoryType.equalsIgnoreCase("DIGI")) {%>
		<tr>
		<td><jsp:include page="../share/applurllinkerdigi.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
		</jsp:include></td></tr>
		<tr><td class="page_flow">Home -&gt; Digi Retail -&gt;Application -&gt; WorkFlow -&gt;
		Queries</td>
	</tr>
    <%}else{%>
 	<tr>
      <td class="page_flow"> Home -&gt; Corporate &amp;SME -&gt; Proposal -&gt; WorkFlow -&gt; Queries</td>
    </tr>
 	<%}%> 
</table>
<lapschoice:application/>
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="bottom">
		<% if((!strCategory.equals("PERM"))) { %>
			<table border="0" cellspacing="1" cellpadding="3" class="outertable" width="80%">
				<tr align="center">
					<td class="sub_tab_inactive"><a href="javascript:callOtherTab('history')">History</a></td>					
					<!--  <td class="sub_tab_inactive"><a href="javascript:callOtherTab('comments')">Comments</a></td> -->
					 <td class="sub_tab_active">Queries</td>
					 <%if(strCategory.equalsIgnoreCase("CORP") || strCategory.equalsIgnoreCase("AGR"))
			        { %>
					  <td id="action" class="sub_tab_inactive" nowrap="nowrap"><a href="#" onclick="javascript:callOtherTab('sanction')">Proposed facility Approve/Reject</a></td>
					  <%}%>
				<% if (strSessionModuleType.equalsIgnoreCase("DIGI") && !(strPrdtype.equalsIgnoreCase("pB")|| strPrdtype.equalsIgnoreCase("pM"))) { %>
					<td class="sub_tab_inactive"><a href="javascript:callOtherTab('actiondigi')">Action</a></td>
				<%} else if (StrDigiLoanType.equalsIgnoreCase("PR") && !(strPrdtype.equalsIgnoreCase("pB")|| strPrdtype.equalsIgnoreCase("pM"))){%>
					<td class="sub_tab_inactive"><a href="javascript:callOtherTab('actiondigi')">Action</a></td>
					<%} else{%>
					<td class="sub_tab_inactive"><a href="javascript:callOtherTab('action')">Action</a></td>
				<%} %>					<%
					if((Helper.correctNull((String)session.getAttribute("appstatus")).equalsIgnoreCase("pa")) || (Helper.correctNull((String)session.getAttribute("appstatus")).equalsIgnoreCase("ca")))
					{
					if (Helper.correctNull((String)session.getAttribute("PRD_CGTMSE")).equalsIgnoreCase("Y")){ %>
					<td class="sub_tab_inactive" id="idCGTMSEtxn"><a href="javascript:callOtherTab('CGTMSE_TXN')">CGTMSE Transaction Details</a></td>
					<%} else { %>
					<td id="idCGTMSEtxn" style="display: none;"><input type="hidden"></td>
					<% } } %>
					<%if(!Helper.correctNull((String)hshValues.get("strLoanType")).equalsIgnoreCase("OD")){ %>
						<td class="sub_tab_inactive"><a href="javascript:callOtherTab('drawdownschedule')">Draw Down Schedule</a></td>
					<%} %>
					<td class="sub_tab_inactive"><a href="javascript:callOtherTab('remarks')">Remarks</a></td>
					<%if (Helper.correctNull((String) hshValues.get("app_legalcomp")).equalsIgnoreCase("Y")){ %>
					<td class="sub_tab_inactive" nowrap="nowrap"><a href="#" onClick="javascript:callOtherTab('legcomp')">Legal Compliance Certificate</a></td>
					<%} %>	
					<td class="sub_tab_inactive" id="idloanaccount"  nowrap="nowrap"><a href="#" onClick="javascript:callLoanAccount()">Loan Account Details</a></td>
					<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("S")){ %>
				<td id="idrestr" class="sub_tab_inactive" nowrap="nowrap"><a
					href="#" onclick="javascript:callOtherTab('restrfacdetails')">Restructure Effective Date</a></td>
					<%}else{ %>
					<td  style="display: none;"><input type="hidden" id="idrestr"></td>
					<%} %>
					<% if(loan_type.equalsIgnoreCase("C") || loan_type.equalsIgnoreCase("A")) {%>
					<td class="sub_tab_inactive" id="idfacdetail"  nowrap="nowrap"><a href="#" onclick="javascript:callOtherTab('facdetail')">Facility Details</a></td> 			
					<% } %>	
				</tr>
			</table>
			<%} %>
		</td>
	</tr>
</table>
<br>
<table width="70%" border="0" cellspacing="0" cellpadding="3"
	class="outertable border1" align="center">
	<tr>
		<td>
		<table width="85%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr>
				<td width="10%" nowrap="nowrap">Query to be raised to Organisation</td>
				<td width="90%"><select name="sel_level" tabindex="1"
					onchange="enabledept();chkorg();">
					<option selected value="">---Select---</option>
					<%if(!strOrgaLevel.equalsIgnoreCase("D")){%>
					<option value="<%=strOrgCode %>"><%=strOrgName %></option>
					<%}%>
					<lapschoice:banklisthelp orglevel='<%=strOrgaLevel%>'
						appno='<%=strAppno%>' orgcode='<%=strOrgcode%>' />
				</select></td>
			</tr>
			<tr id="hiddept1" style="display: none;">
				<td>Department&nbsp;</td>
				<td><select name="seldepartment" style="width: 125px;">
					<option value=""><-- Select --></option>
					 <lapschoice:CBSStaticDataNewTag apptype='20' />
			</tr>
			<tr id="hiddept2" style="display: none;">
				<td>Department&nbsp;</td>
				<td><select name="seldepartment1" style="width: 125px;">
					<option value=""><-- Select --></option>
					 <lapschoice:CBSStaticDataNewTag apptype='130' />
			</tr>
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2">
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr>
			<td valign="top" width="5%">Query</td>
				<td width="45%"><textarea name="txt_query" cols="100" rows="13"
					onKeyPress="textlimit(this,3999);" onKeyUp="textlimit(this,3999);"
					tabindex="4"></textarea></td>
					
				<td valign="top"  id="id_Qreply" width="5%" style="display: none;">Reply</td>
				<td  id="id_Qreply1" width="45%" style="display: none;"><textarea name="txt_Reply_query" cols="100" rows="13"
					onKeyPress="textlimit(this,3999);" onKeyUp="textlimit(this,3999)" 
					tabindex="4"></textarea></td>
			</tr>
			<tr>
			<td id="idraised" style="display: none;">Raised By</td>
			<td id="idraised1" style="display: none;"><input type="text" name="txt_raisedby" size="50"></td>
			<td id="idreply" style="display: none;">Replied By</td>
				<td id="idreply1" style="display: none;"><input type="text" name="txt_repliedby" size="35"></td>
			</tr>
			<tr>
				<td id="idraised2" style="display: none;">Raised On</td>
				<td id="idraised3" style="display: none;"><input type="text" name="txt_raisedon" size="50"></td>
				<td id="idreply2" style="display: none;">Replied On</td>
				<td id="idreply3" style="display: none;"><input type="text" name="txt_repliedon" size="35"></td>
			</tr>
			<tr>
				<td id="idclose" style="display: none;">Closed By</td>
				<td  id="idclose1" style="display: none;"><input type="text" name="txt_closedby" size="50"></td>
			</tr>
			<tr>
				<td id="idclose2" style="display: none;">Closed On</td>
				<td id="idclose3" style="display: none;"><input type="text" name="txt_closedon" size="35"></td>
			</tr>
			
			</table>
				</td>
			</tr>
			<tr id="idrec" style="display: none;">
<!--				<td>Raised to</td>-->
<!--				<td><input type="text" name="mail_tousrid" size="37"-->
<!--					readonly="readonly"> <input type="hidden"-->
<!--					name="hidmail_tousrid"> <a href="#"-->
<!--					onClick="javascript:callUsersHelp()"><img-->
<!--					src="<%//=ApplicationParams.getAppUrl()%>/img/search_corp.gif"-->
<!--					border="0"> </a>&nbsp;</td>-->
			</tr>
			<tr>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<br>
<lapschoice:combuttonnew
	btnnames="New_Edit_Save_Cancel_Delete_Send Query_Query Reply_Close Query_ReOpen Query_Print"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<br>

<table width="98%" border="0" cellspacing="1" cellpadding="3"
	class="outertable" align="center">
	<tr class="dataheader" align="center">
		<td width="2%">&nbsp;</td>
		<td width="5%">S.No</td>
		<td width="15%">Query</td>
		<td width="10%">Created By</td>
		<td width="10%">Created On</td>
		<td width="10%">Status</td>
		<td width="10%">Raised On</td>
		<td width="10%">Query Raised to Organisation</td>
		<td width="14%">Reply</td>
		<td width="9%">Replied by</td>
		<td width="9%">Replied on</td>
	</tr>
	<%if(arrRow!=null && arrRow.size()>0)
				{
				int a=0;
				String x="";
				for(int i=0;i<arrRow.size();i++)
				{
					arrCol=(ArrayList)arrRow.get(i);
					String intgroup=Helper.correctNull((String)arrCol.get(17));
					System.out.println("arrCol====="+arrCol);
				%>
				
		<%if(intgroup.equals("0")){ %>		
		<tr class="datagrid">
		<td align="center"><input type="radio" name="sno"
			style="border-style: none"
			
			onclick="selectValues('<%=Helper.correctNull((String)arrCol.get(0)) %>','<%=Helper.correctNull((String)arrCol.get(1)) %>','<%=Helper.correctNull((String)arrCol.get(2)) %>','<%= Helper.replcaeNewLine( Helper.correctDoubleQuotesHtml((String)arrCol.get(3))) %>','<%=Helper.correctNull((String)arrCol.get(6)) %>','<%=Helper.correctNull((String)arrCol.get(7)) %>','<%= Helper.replcaeNewLine(Helper.correctDoubleQuotesHtml((String)arrCol.get(10))) %>','<%=Helper.correctNull((String)arrCol.get(11)) %>','<%=Helper.correctNull((String)arrCol.get(12)) %>','<%=Helper.correctNull((String)arrCol.get(13)) %>','<%=Helper.replcaeNewLine( Helper.correctDoubleQuotesHtml((String)arrCol.get(14))) %>','<%=Helper.correctNull((String)arrCol.get(15)) %>','<%=Helper.correctNull((String)arrCol.get(17)) %>','<%=Helper.correctNull((String)arrCol.get(8)) %>','<%=Helper.correctNull((String)arrCol.get(4)) %>','<%=Helper.correctNull((String)arrCol.get(16)) %>','<%=Helper.correctNull((String)arrCol.get(18)) %>','<%=Helper.correctNull((String)arrCol.get(19)) %>','<%=Helper.correctNull((String)arrCol.get(20)) %>');"></td>
		<td align="center"><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;</td>
		<td><%=Helper.correctDoubleQuotesHtml((String)arrCol.get(3)) %>&nbsp;</td>
		<td><%=Helper.correctNull((String)arrCol.get(6)) %> - <%=Helper.correctNull((String)arrCol.get(4)) %> &nbsp;</td>
		<td align="center"><%=Helper.correctNull((String)arrCol.get(5)) %>
		&nbsp;</td>
		<td align="center">
		<%if(Helper.correctNull((String)arrCol.get(7)).equalsIgnoreCase("QE")){ %>
		Query Entered <%}else if(Helper.correctNull((String)arrCol.get(7)).equalsIgnoreCase("QS")){ %>
		Query Sent <%}else if(Helper.correctNull((String)arrCol.get(7)).equalsIgnoreCase("QR")){ %>
		Query Replied <%}else if(Helper.correctNull((String)arrCol.get(7)).equalsIgnoreCase("QC")){ %>
		Query Closed  <%}else if(Helper.correctNull((String)arrCol.get(7)).equalsIgnoreCase("QO")){ %>
		Query Re-Open <%}%> &nbsp;</td>
		<td align="center"><%=Helper.correctNull((String)arrCol.get(8)) %>
		&nbsp;</td>
		<td><%=Helper.correctNull((String)arrCol.get(9)) %>&nbsp;</td>
		<%if(Helper.correctNull((String)arrCol.get(7)).equalsIgnoreCase("QS")){ 
			if(Helper.correctNull((String)arrCol.get(6)).equalsIgnoreCase(strUserid)){%>
			<td><font color="#3f3f40">&nbsp;</font></td>
			<td><font color="#3f3f40">&nbsp;</font></td>
			<td><font color="#3f3f40">&nbsp;</font></td>
			<%}else{ %>
			<td><%=Helper.correctNull((String)arrCol.get(14)) %>&nbsp;</td>
			<td><%=Helper.correctNull((String)arrCol.get(10)) %> - <%=Helper.correctNull((String)arrCol.get(16)) %>&nbsp;</td>
			<td><%=Helper.correctNull((String)arrCol.get(11)) %>&nbsp;</td>
		<%}}else{ %>
		<td><%=Helper.correctNull((String)arrCol.get(14)) %>&nbsp;</td>
		<td><%=Helper.correctNull((String)arrCol.get(10)) %> - <%=Helper.correctNull((String)arrCol.get(16)) %>&nbsp;</td>
		<td><%=Helper.correctNull((String)arrCol.get(11)) %>&nbsp;</td>
		<%} %>
		
		
	</tr>
	<%} else { %>
	
		<tr class="datagrid">
			<td align="center"><font color="#3f3f40"><input type="radio" name="sno"
				style="border-style: none"
				onclick="selectValues('<%=Helper.correctNull((String)arrCol.get(0)) %>','<%=Helper.correctNull((String)arrCol.get(1)) %>','<%=Helper.correctNull((String)arrCol.get(2)) %>','<%= Helper.replcaeNewLine( Helper.correctDoubleQuotesHtml((String)arrCol.get(3))) %>','<%=Helper.correctNull((String)arrCol.get(6)) %>','<%=Helper.correctNull((String)arrCol.get(7)) %>','<%= Helper.replcaeNewLine(Helper.correctDoubleQuotesHtml((String)arrCol.get(10))) %>','<%=Helper.correctNull((String)arrCol.get(11)) %>','<%=Helper.correctNull((String)arrCol.get(12)) %>','<%=Helper.correctNull((String)arrCol.get(13)) %>','<%=Helper.replcaeNewLine( Helper.correctDoubleQuotesHtml((String)arrCol.get(14))) %>','<%=Helper.correctNull((String)arrCol.get(15)) %>','<%=Helper.correctNull((String)arrCol.get(17)) %>','<%=Helper.correctNull((String)arrCol.get(8)) %>','<%=Helper.correctNull((String)arrCol.get(4)) %>','<%=Helper.correctNull((String)arrCol.get(16)) %>','<%=Helper.correctNull((String)arrCol.get(18)) %>','<%=Helper.correctNull((String)arrCol.get(19)) %>','<%=Helper.correctNull((String)arrCol.get(20)) %>');">
			</font>	
				</td>
			<td align="right"><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp; </font> </td>
			<td><font color="#3f3f40"><%=Helper.correctDoubleQuotesHtml((String)arrCol.get(3)) %>&nbsp; </font></td>
			<td><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(6)) %> - <%=Helper.correctNull((String)arrCol.get(4)) %> &nbsp;</font></td>
			<td align="center"><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(5)) %></font>	&nbsp;</td>
			<td align="center"><font color="#3f3f40">
			<%if(Helper.correctNull((String)arrCol.get(7)).equalsIgnoreCase("QE")){ %>
			Query Entered <%}else if(Helper.correctNull((String)arrCol.get(7)).equalsIgnoreCase("QS")){ %>
			Query Sent <%}else if(Helper.correctNull((String)arrCol.get(7)).equalsIgnoreCase("QR")){ %>
			Query Replied <%}else if(Helper.correctNull((String)arrCol.get(7)).equalsIgnoreCase("QC")){ %>
			Query Closed  <%}else if(Helper.correctNull((String)arrCol.get(7)).equalsIgnoreCase("QO")){ %>
			Query Re-Open <%}%> &nbsp;</font></td>
			<td align="center"><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(8)) %>&nbsp;</font></td>
			<td><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(9)) %>&nbsp;</font></td>
		<%if(Helper.correctNull((String)arrCol.get(7)).equalsIgnoreCase("QS")){ 
			if(Helper.correctNull((String)arrCol.get(6)).equalsIgnoreCase(strUserid)){%>
			<td><font color="#3f3f40">&nbsp;</font></td>
			<td><font color="#3f3f40">&nbsp;</font></td>
			<td><font color="#3f3f40">&nbsp;</font></td>
			<%}else{ %>
			<td><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(14)) %>&nbsp;</td>
			<td><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(10)) %> - <%=Helper.correctNull((String)arrCol.get(16)) %>&nbsp;</td>
			<td><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(11)) %>&nbsp;</td>
		<%}}else{ %>
		<td><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(14)) %>&nbsp;</td>
		<td><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(10)) %> - <%=Helper.correctNull((String)arrCol.get(16)) %>&nbsp;</td>
		<td><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(11)) %>&nbsp;</td>
		<%} %>
		</tr>
	<%} %>
	
	<%}}else{ 
				for(int i=0;i<4;i++){%>
	<%if(i==2){ %>
	<tr class="datagrid">
		<td colspan="11" align="center">-- No Record Found --</td>
		<%} %>
	
	<tr class="datagrid">
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>

	<%}}%>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="hidsno">
<input type="hidden" name="hid_parentid">
<input type="hidden" name="hid_queryStatus">
<% if(!(strCategory.equalsIgnoreCase("CORP")  || strCategory.equalsIgnoreCase("AGR"))) { %>
<input type="hidden" name="hidCategoryType" value="<%= strCategory%>">
<%} %>
<input type="hidden" name="cattype" value="<%=strCategoryType%>">
</form>
</body>
</html>
