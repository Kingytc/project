<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	String strrepay = Helper.correctNull((String) hshValues.get("com_otherrepay"));
String strbankschemeflag = Helper.correctNull((String) hshValues.get("strbankschemeflag"));
String strbankschemegeclflag= Helper.correctNull((String) hshValues.get("strbankschemegeclflag"));
session.setAttribute("com_svanidhi", Helper.correctNull((String)hshValues.get("COM_SVANIDHITYPE")));

%>
<html>
<head>
<title>Setup(Corporate & Agriculture Products) - Other Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%
	String strProductType = Helper.correctNull((String) session.getAttribute("strProductType"));
%>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script>
var scheme = "<%=Helper.correctNull((String) hshValues.get("schemetype"))%>";
var fac_id ="<%=Helper.correctNull(request.getParameter("fac_id"))%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var strprd_ho="<%=Helper.correctNull((String)hshValues.get("COM_HO_POWER"))%>";
var strprd_ro="<%=Helper.correctNull((String)hshValues.get("COM_RO_POWER"))%>";
var strprd_clpu="<%=Helper.correctNull((String)hshValues.get("COM_CLPU_POWER"))%>";
var strprd_branch="<%=Helper.correctNull((String)hshValues.get("COM_BRANCH_POWER"))%>";
var strprd_sanc="<%=Helper.correctNull((String)hshValues.get("COM_SANC_DAYS"))%>";
var strprd_reValid="<%=Helper.correctNull((String)hshValues.get("COM_REVALID_DAYS"))%>";
var strprd_notAvailed="<%=Helper.correctNull((String)hshValues.get("COM_NOTAVAILED_DAYS"))%>";
var strbankschemeflag="<%=strbankschemeflag%>";
var strbankschemegeclflag="<%=strbankschemegeclflag%>";
var vargecl="<%=Helper.correctNull((String)hshValues.get("COM_GECLTYPE"))%>";
var varSchemeType="<%=Helper.correctNull((String)hshValues.get("COM_BANKSCHEME"))%>";
var varSvanidhiType="<%=Helper.correctNull((String)hshValues.get("COM_SVANIDHITYPE"))%>";
	
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
	    if(document.forms[0].elements[i].type=="text") 
		{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-multiple')
	 	{
			document.forms[0].elements[i].disabled=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
	}
}
function enableButtons( bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;		
	document.forms[0].cmdclose.disabled=bool5;
}
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,false);
	document.forms[0].hidAction.value ="update";
}
function doSave()
{
	var repaytype="";
	subIndex=0;
	if(document.forms[0].sel_loanacc.value=="N")
	{
		if(document.forms[0].sel_limitnodetype.value=="S")
		{
			ShowAlert('111',"Limit Node Type");
			document.forms[0].sel_limitnodetype.focus();
			return;
		}
	}
	for(var i=0;i<document.forms[0].sel_repay.options.length;i++)
	{
		if(i!=0 &&  i < 6)
		subIndex=2;
		if(document.forms[0].sel_repay.options[i].selected)
		{		
			repaytype=repaytype+document.forms[0].sel_repay.options[i].value.substring(0,subIndex)+"@";
		}		
	}
	 if(document.forms[0].prd_sanc_days.value==""||document.forms[0].prd_sanc_days.value==null){
		 alert("Enter Sanction Validity ");
		 document.forms[0].prd_sanc_days.focus();
		 return;
	 }
	 if(document.forms[0].prd_revalid_days.value==""||document.forms[0].prd_revalid_days.value==null){
		 alert("Enter Revalidation Validity ");
		 document.forms[0].prd_revalid_days.focus();
		 return;
	 }
	 if(document.forms[0].prd_notavailed_days.value==""||document.forms[0].prd_notavailed_days.value==null){
		 alert("Enter Facility is not Availed/Revalidated");
		 document.forms[0].prd_notavailed_days.focus();
		 return;
	 }
	 if(strbankschemeflag=="Y"){
		 if(document.forms[0].txt_cgssd.value==""){
			 alert("Enter the %CGSSD");
			 document.forms[0].txt_cgssd.focus();
			 return;
		 }
	 }
	 if(strbankschemegeclflag=="Y"){
		 if(document.forms[0].sel_gecl.value==""){
				ShowAlert(111,"Gecl type");
			 document.forms[0].sel_gecl.focus();
			 return;
		 }
		 
		 if(document.forms[0].sel_gecl.value=="GECL1"){
			 if(document.forms[0].txt_lmtogborrower.value==""){
				 ShowAlert(121,"Maximum eligible limit to the borrower");
				 document.forms[0].txt_lmtogborrower.focus();
				 return;
		    }
			 if(document.forms[0].txt_limitnoc.value==""){
				 ShowAlert(121,"Maximum eligible limit without NOC from others");
				 document.forms[0].txt_limitnoc.focus();
				 return;
			 }
			 if(document.forms[0].txt_lmtogborrowerrest.value==""){
				 ShowAlert(121,"Balance outstanding as on 29/02/2020");
				 document.forms[0].txt_lmtogborrowerrest.focus();
				 return;
			 }
		 }

		 if(document.forms[0].sel_gecl.value=="GECL2"){
			 if(document.forms[0].txt_limitmlis.value==""){
				 ShowAlert(121,"Total eligible limit from entire MLI's");
				 document.forms[0].txt_limitmlis.focus();
				 return;
		    }
			 if(document.forms[0].txt_limitbank.value==""){
				 ShowAlert(121,"Total eligible limit with our Bank");
				 document.forms[0].txt_limitbank.focus();
				 return;
			 }
		 }	
		 if(document.forms[0].sel_gecl.value=="GECL3"){
			 if(document.forms[0].txt_lmtogborrowermlis.value==""){
				 ShowAlert(121,"Total eligible limit from entire MLI's");
				 document.forms[0].txt_lmtogborrowermlis.focus();
				 return;
		    }
			 if(document.forms[0].txt_lmtogborrowerbank.value==""){
				 ShowAlert(121,"Total eligible limit with our Bank");
				 document.forms[0].txt_lmtogborrowerbank.focus();
				 return;
			 }
		 }
		 if(document.forms[0].sel_gecl.value=="GECL4"){
			 if(document.forms[0].txt_lmtpropandrecomended.value==""||document.forms[0].txt_lmtpropandrecomended.value=="0.00"){
				 ShowAlert(121,"Limit Proposed and Recomended");
				 document.forms[0].txt_lmtpropandrecomended.focus();
				 return;
		    }
		 }
		 
	 }
	 if(varSchemeType=="064"){
		 if(document.forms[0].sel_SvanidhiType.selectedIndex==0){
			 ShowAlert(121,"Svanidhi Type");
			 document.forms[0].sel_SvanidhiType.focus();
			 return;
		 }
		  
	 }
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].repaytype.value = repaytype;
    document.forms[0].hidAction.value ="update";
	document.forms[0].hidBeanId.value="corporatefacility"
	document.forms[0].hidBeanMethod.value="updateotherdet";
	document.forms[0].hidBeanGetMethod.value="getDataotherdet";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/otherdetails.jsp";
	document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="Delete";
		document.forms[0].hidBeanId.value="corporatefacility"
		document.forms[0].hidBeanMethod.value="updateotherdet";
		document.forms[0].hidBeanGetMethod.value="getDataotherdet";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/otherdetails.jsp";
		document.forms[0].submit();
	}
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="corporatefacility"
		document.forms[0].hidBeanMethod.value="updateotherdet";
		document.forms[0].hidBeanGetMethod.value="getDataotherdet";
		document.forms[0].hidSourceUrl.value="/action/otherdetails.jsp";
		document.forms[0].submit();
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/"+"comfacilityhome.jsp";
		document.forms[0].submit();
	}
}
function placevalues()
{
	var sel_repay1= "<%=strrepay%>";
	var str_repay_temp =sel_repay1.split("@");
	for(var i=0;i<str_repay_temp.length;i++)
	{
		var selvaluerepay=str_repay_temp[i];
		for(var j=0;j<document.forms[0].sel_repay.options.length;j++)
		{
			if(document.forms[0].sel_repay.options[j].value.substring(0,2)==selvaluerepay)
			{
				document.forms[0].sel_repay.options[j].selected=true;
			}
		}
	}
	var comlienexposure = "<%=Helper.correctNull((String) hshValues.get("com_lienexposure"))%>";
	var comotherroi = "<%=Helper.correctNull((String) hshValues.get("com_otherroi"))%>";
	var com_renewal = "<%=Helper.correctNull((String) hshValues.get("com_renewal"))%>";
	var comotherpeak = "<%=Helper.correctNull((String) hshValues.get("com_otherpeak"))%>";
	var comotheragri = "<%=Helper.correctNull((String) hshValues.get("com_otheragri"))%>";
	var comotherwarehouse = "<%=Helper.correctNull((String) hshValues.get("com_otherwarehouse"))%>";
	var comotherbookdbt = "<%=Helper.correctNull((String) hshValues.get("com_otherbookdbt"))%>";
	var comotherdbplc = "<%=Helper.correctNull((String) hshValues.get("com_otherdbplc"))%>";
	var comothercheque = "<%=Helper.correctNull((String) hshValues.get("com_othercheque"))%>";
	var comotherusance = "<%=Helper.correctNull((String) hshValues.get("com_otherusance"))%>";
	var comotherchk = "<%=Helper.correctNull((String) hshValues.get("com_otherchk"))%>";
	var comdscr = "<%=Helper.correctNull((String) hshValues.get("com_DSCR"))%>";
	var comloanacc = "<%=Helper.correctNull((String) hshValues.get("COM_LOANACC"))%>";
	var comsubvention = "<%=Helper.correctNull((String) hshValues.get("com_subvention"))%>";
	var comlimitnodetype="<%=Helper.correctNull((String)hshValues.get("com_limtnodetype"))%>";
	if(comdscr!="")
	{
		document.forms[0].sel_DSCR.value=comdscr;
	}
	else
	{
		document.forms[0].sel_DSCR.value="S";
	}
	if(comloanacc!="")
	{
		document.forms[0].sel_loanacc.value=comloanacc;
	}
	else
	{
		document.forms[0].sel_loanacc.value="Y";
	}
	if(vargecl!=""){
		document.forms[0].sel_gecl.value=vargecl;
		
	}
	if(scheme=="aQ")
	{
		document.all.subven1.style.visibility="visible";
		document.all.subven1.style.position="relative";
		document.all.subven2.style.visibility="visible";
		document.all.subven2.style.position="relative";
	}
	else
	{
		document.all.subven1.style.visibility="hidden";
		document.all.subven1.style.position="absolute";
		document.all.subven2.style.visibility="hidden";
		document.all.subven2.style.position="absolute";
	}
	if(comsubvention!="")
	{
		document.forms[0].sel_subvention.value=comsubvention;
	}
	else
	{
		document.forms[0].sel_subvention.value="N";
	}
	var comBEP = "<%=Helper.correctNull((String) hshValues.get("com_BEP"))%>";
	var comExpformula = "<%=Helper.correctNull((String) hshValues.get("com_expformula"))%>";
	var comMinclauseroi = "<%=Helper.correctNull((String) hshValues.get("com_minclauseroi"))%>";
	var commarginold = "<%=Helper.correctNull((String) hshValues.get("com_marginold"))%>";
	var comMachinery = "<%=Helper.correctNull((String) hshValues.get("com_machinery"))%>";
	var comprocessingcharge = "<%=Helper.correctNull((String) hshValues.get("com_processingcharge"))%>";
	var cominterestcircular = "<%=Helper.correctNull((String) hshValues.get("com_interestcircular"))%>";
	var warehouseplace = "<%=Helper.correctNull((String) hshValues.get("com_warehouseplace"))%>";
	disableFields(true);
	enableButtons(false,true,true,true,false);
	if(comlimitnodetype!="")
	{
		document.forms[0].sel_limitnodetype.value=comlimitnodetype;
	}
	else
	{
		document.forms[0].sel_limitnodetype.value="S";
	}
	showLimitNodeType();
	showSvanidhiType();
	 document.forms[0].prd_HO.value=strprd_ho;
	 document.forms[0].prd_RO.value=strprd_ro;
	 document.forms[0].prd_CLPU.value=strprd_clpu;
	 document.forms[0].prd_branch.value=strprd_branch;
	 document.forms[0].sel_SvanidhiType.value=varSvanidhiType;
	 if(strprd_sanc!=""||strprd_sanc!="null")
		 document.forms[0].prd_sanc_days.value=strprd_sanc;
	 else
		 document.forms[0].prd_sanc_days.value="";
	 if(strprd_reValid!=""||strprd_reValid!="null")
		 document.forms[0].prd_revalid_days.value=strprd_reValid;
	 else
		 document.forms[0].prd_revalid_days.value="";
	 if(strprd_notAvailed!=""||strprd_notAvailed!=null)
		 document.forms[0].prd_notavailed_days.value=strprd_notAvailed;
	 else
		 document.forms[0].prd_notavailed_days.value="";
	document.forms[0].prd_skip_value.style.visibility="hidden";
	document.forms[0].prd_skip_value.style.position="absolute";
	 showDescRev(strprd_ho,'HO');
	 showDescRev(strprd_ro,'RO');
	 showDescRev(strprd_clpu,'CLPU');
	 showDescRev(strprd_branch,'branch');
	 
	 
	 
}
function showLimitNodeType()
{
	if(document.forms[0].sel_loanacc.value=="N")
	{
		document.all.id_LNType1.style.visibility="visible";
		document.all.id_LNType1.style.position="relative";
		document.all.id_LNType2.style.visibility="visible";
		document.all.id_LNType2.style.position="relative";
	}else{
		document.all.id_LNType1.style.visibility="hidden";
		document.all.id_LNType1.style.position="absolute";
		document.all.id_LNType2.style.visibility="hidden";
		document.all.id_LNType2.style.position="absolute";
	}
}
function showDescRev(id,val){
	var varType=val;
	if(varType=="HO"){
		for(i=0;i<document.forms[0].prd_skip_value.length;i++)
		{	
			if(id == document.forms[0].prd_skip_value[i].value)
			{
				document.forms[0].prd_skip_value.selectedIndex=i;
				document.forms[0].prd_ho_descr.value=document.forms[0].prd_skip_value.options[document.forms[0].prd_skip_value.selectedIndex].text
			}
		}
	}
	if(varType=="RO"){
		for(i=0;i<document.forms[0].prd_skip_value.length;i++)
		{	
			if(id == document.forms[0].prd_skip_value[i].value)
			{
				document.forms[0].prd_skip_value.selectedIndex=i;
				document.forms[0].prd_ro_descr.value=document.forms[0].prd_skip_value.options[document.forms[0].prd_skip_value.selectedIndex].text
			}
		}
	}
	if(varType=="CLPU"){
		for(i=0;i<document.forms[0].prd_skip_value.length;i++)
		{	
			if(id == document.forms[0].prd_skip_value[i].value)
			{
				document.forms[0].prd_skip_value.selectedIndex=i;
				document.forms[0].prd_CLPU_descr.value=document.forms[0].prd_skip_value.options[document.forms[0].prd_skip_value.selectedIndex].text
			}
		}
	}
	if(varType=="branch"){
		for(i=0;i<document.forms[0].prd_skip_value.length;i++)
		{	
			if(id == document.forms[0].prd_skip_value[i].value)
			{
				document.forms[0].prd_skip_value.selectedIndex=i;
				document.forms[0].prd_branch_descr.value=document.forms[0].prd_skip_value.options[document.forms[0].prd_skip_value.selectedIndex].text
			}
		}
	}
}
function checkmaxdays(){
	 if(document.forms[0].prd_sanc_days.value==""||document.forms[0].prd_sanc_days.value==null){
		 alert("Enter Sanction Validity ");
		 document.forms[0].prd_sanc_days.focus();
		 return;
	 }
	 if(document.forms[0].prd_revalid_days.value==""||document.forms[0].prd_revalid_days.value==null){
		 alert("Enter Revalidation Validity ");
		 document.forms[0].prd_revalid_days.focus();
		 return;
	 }

	if(parseInt(document.forms[0].prd_notavailed_days.value,10)<parseInt(document.forms[0].prd_sanc_days.value,10))
	 {
		 alert("Facility is not Availed/Revalidated Days should be greater than Sanction Validity Days");
		 document.forms[0].prd_notavailed_days.value="";
		 document.forms[0].prd_notavailed_days.focus();
		 return;
	 }
	
	if(parseInt(document.forms[0].prd_notavailed_days.value,10)<parseInt(document.forms[0].prd_revalid_days.value,10))
	 {
		 alert("Facility is not Availed/Revalidated Days should be greater than Revalidation Validity Days");
		 document.forms[0].prd_notavailed_days.value="";
		 document.forms[0].prd_notavailed_days.focus();
		 return;
	 }
}

function onchangeval()
{
	if(document.forms[0].sel_gecl.value=="GECL1")
	{
		document.all.idgecl1.style.visibility="visible";
		document.all.idgecl1.style.position="relative";
		document.all.idgecl2.style.visibility="hidden";
		document.all.idgecl2.style.position="absolute";
		document.all.idgecl3.style.visibility="hidden";
		document.all.idgecl3.style.position="absolute";
		document.all.idgecl4.style.visibility="hidden";
		document.all.idgecl4.style.position="absolute";
		document.all.idgecl5.style.visibility="visible";
		document.all.idgecl5.style.position="relative";
		document.all.idgecl6.style.visibility="hidden";
		document.all.idgecl6.style.position="absolute";
		document.all.idgecl7.style.visibility="hidden";
		document.all.idgecl7.style.position="absolute";
		document.all.idgecl8.style.visibility="hidden";
		document.all.idgecl8.style.position="absolute";
		
	}
	else if(document.forms[0].sel_gecl.value=="GECL2")
	{
		document.all.idgecl2.style.visibility="visible";
		document.all.idgecl2.style.position="relative";
		document.all.idgecl1.style.visibility="hidden";
		document.all.idgecl1.style.position="absolute";
		document.all.idgecl3.style.visibility="hidden";
		document.all.idgecl3.style.position="absolute";
		document.all.idgecl4.style.visibility="hidden";
		document.all.idgecl4.style.position="absolute";
		document.all.idgecl5.style.visibility="hidden";
		document.all.idgecl5.style.position="absolute";
		document.all.idgecl6.style.visibility="hidden";
		document.all.idgecl6.style.position="absolute";
		document.all.idgecl7.style.visibility="hidden";
		document.all.idgecl7.style.position="absolute";
		document.all.idgecl8.style.visibility="hidden";
		document.all.idgecl8.style.position="absolute";
		
	}else if(document.forms[0].sel_gecl.value=="GECL3")
	{
		document.all.idgecl3.style.visibility="visible";
		document.all.idgecl3.style.position="relative";
		document.all.idgecl1.style.visibility="hidden";
		document.all.idgecl1.style.position="absolute";
		document.all.idgecl2.style.visibility="hidden";
		document.all.idgecl2.style.position="absolute";
		document.all.idgecl4.style.visibility="hidden";
		document.all.idgecl4.style.position="absolute";
		document.all.idgecl5.style.visibility="hidden";
		document.all.idgecl5.style.position="absolute";
		document.all.idgecl6.style.visibility="hidden";
		document.all.idgecl6.style.position="absolute";
		document.all.idgecl7.style.visibility="hidden";
		document.all.idgecl7.style.position="absolute";
		document.all.idgecl8.style.visibility="hidden";
		document.all.idgecl8.style.position="absolute";
	}
	else if(document.forms[0].sel_gecl.value=="GECL4")
	{
		document.all.idgecl4.style.visibility="visible";
		document.all.idgecl4.style.position="relative";
		document.all.idgecl1.style.visibility="hidden";
		document.all.idgecl1.style.position="absolute";
		document.all.idgecl2.style.visibility="hidden";
		document.all.idgecl2.style.position="absolute";
		document.all.idgecl3.style.visibility="hidden";
		document.all.idgecl3.style.position="absolute";
		document.all.idgecl5.style.visibility="hidden";
		document.all.idgecl5.style.position="absolute";
		document.all.idgecl6.style.visibility="hidden";
		document.all.idgecl6.style.position="absolute";
		document.all.idgecl7.style.visibility="hidden";
		document.all.idgecl7.style.position="absolute";
		document.all.idgecl8.style.visibility="hidden";
		document.all.idgecl8.style.position="absolute";
		
	}

	else if(document.forms[0].sel_gecl.value=="GECL -1 extension")
	{
		document.all.idgecl1.style.visibility="hidden";
		document.all.idgecl1.style.position="absolute";
		document.all.idgecl2.style.visibility="hidden";
		document.all.idgecl2.style.position="absolute";
		document.all.idgecl3.style.visibility="hidden";
		document.all.idgecl3.style.position="absolute";
		document.all.idgecl4.style.visibility="hidden";
		document.all.idgecl4.style.position="absolute";
		document.all.idgecl5.style.visibility="hidden";
		document.all.idgecl5.style.position="absolute";
		document.all.idgecl6.style.visibility="visible";
		document.all.idgecl6.style.position="relative";
		document.all.idgecl7.style.visibility="hidden";
		document.all.idgecl7.style.position="absolute";
		document.all.idgecl8.style.visibility="hidden";
		document.all.idgecl8.style.position="absolute";
	}


	else if(document.forms[0].sel_gecl.value=="GECL -2 extension")
	{
		document.all.idgecl1.style.visibility="hidden";
		document.all.idgecl1.style.position="absolute";
		document.all.idgecl2.style.visibility="hidden";
		document.all.idgecl2.style.position="absolute";
		document.all.idgecl3.style.visibility="hidden";
		document.all.idgecl3.style.position="absolute";
		document.all.idgecl4.style.visibility="hidden";
		document.all.idgecl4.style.position="absolute";
		document.all.idgecl5.style.visibility="hidden";
		document.all.idgecl5.style.position="absolute";
		document.all.idgecl6.style.visibility="hidden";
		document.all.idgecl6.style.position="absolute";
		document.all.idgecl7.style.visibility="visible";
		document.all.idgecl7.style.position="relative";
		document.all.idgecl8.style.visibility="hidden";
		document.all.idgecl8.style.position="absolute";
	}



	else if(document.forms[0].sel_gecl.value=="GECL -3 extension")
	{
		document.all.idgecl1.style.visibility="hidden";
		document.all.idgecl1.style.position="absolute";
		document.all.idgecl2.style.visibility="hidden";
		document.all.idgecl2.style.position="absolute";
		document.all.idgecl3.style.visibility="hidden";
		document.all.idgecl3.style.position="absolute";
		document.all.idgecl4.style.visibility="hidden";
		document.all.idgecl4.style.position="absolute";
		document.all.idgecl5.style.visibility="hidden";
		document.all.idgecl5.style.position="absolute";
		document.all.idgecl6.style.visibility="hidden";
		document.all.idgecl6.style.position="absolute";
		document.all.idgecl7.style.visibility="hidden";
		document.all.idgecl7.style.position="absolute";
		document.all.idgecl8.style.visibility="visible";
		document.all.idgecl8.style.position="relative";
	}
	
	
	else{
		document.all.idgecl1.style.visibility="hidden";
		document.all.idgecl1.style.position="absolute";
		document.all.idgecl2.style.visibility="hidden";
		document.all.idgecl2.style.position="absolute";
		document.all.idgecl3.style.visibility="hidden";
		document.all.idgecl3.style.position="absolute";
		document.all.idgecl4.style.visibility="hidden";
		document.all.idgecl4.style.position="absolute";
		document.all.idgecl5.style.visibility="hidden";
		document.all.idgecl5.style.position="absolute";
		document.all.idgecl6.style.visibility="hidden";
		document.all.idgecl6.style.position="absolute";
		document.all.idgecl7.style.visibility="hidden";
		document.all.idgecl7.style.position="absolute";
		document.all.idgecl8.style.visibility="hidden";
		document.all.idgecl8.style.position="absolute";
	}
}
function showSvanidhiType(){
	
	
	if(varSchemeType=="064"){
		
		document.all.idSvanidhi.style.visibility="visible";
		document.all.idSvanidhi.style.position="relative";
		
		
	}else{
		document.all.idSvanidhi.style.visibility="hidden";
		document.all.idSvanidhi.style.position="absolute";
	}
}
</script>
</head>
<body onload="placevalues();onchangeval()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url=""><script language="JavaScript">
if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div></div>
<form name="documentsfrm" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td>
		<jsp:include page="../share/help.jsp" flush="true"/>
		<jsp:include page="../share/menus.jsp" flush="true"/>
	</td>
</tr>
</table>
<lapstab:setproductstabcorp tabid="5" />
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td class="page_flow">Home -&gt; Setup -&gt; Corporate &amp; Agri Products -&gt; Facility Creation -&gt; Other Details</td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="5">
		<tr>
			<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5">
				<tr>
					<td valign="top">
						<table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="0">
						<tr>
							<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
								<tr>
									<td><lapschoice:facility /></td>
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
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td>
		<table width="100%" border="0" class="outertable border1" cellspacing="1" cellpadding="3" align="center">
		<tr>
			<td>
				<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
				<tr class="datagrid">
					<td width="25%" rowspan="4">&nbsp;Repayment Type</td>
					<td WIDTH="25%" rowspan="4">
						<select name="sel_repay" multiple="multiple" size="5">
							<option value="S">--Select--</option>
							<option value="M">Monthly</option>
							<option value="Q">Quarterly</option>
							<option value="H">Half-Yearly</option>
							<option value="Y">Yearly</option>
							<option value="L">Lump-sum</option>
							<option value="Sup">Step-up</option>
							<option value="SDwn">Step-Down</option>
							<option value="C">Customise</option>
						</select>
					</td>
					<td width="25%">&nbsp;Whether DSCR is need</td>
					<td WIDTH="25%">
						<select name="sel_DSCR">
							<option value="S" selected="selected">-Select-</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select>
					</td>
				</tr>
				<tr class="datagrid">
				<td width="25%">&nbsp;Whether Loan account opening is there</td>
					<td WIDTH="25%">
						<select name="sel_loanacc" onchange="showLimitNodeType()">
							<option value="Y" selected>Yes</option>
							<option value="N">No</option>
						</select>
					</td>
				</tr>
				<tr class="datagrid">
				<td width="25%" id="id_LNType1">&nbsp;Select Limit Node Type</td>
					<td WIDTH="25%" id="id_LNType2">
						<select name="sel_limitnodetype" >
							<option value="S"><--Select--></option>
							  <lapschoice:StaticDataTag apptype="152"/> 
						</select>
					</td>
				</tr>
				<tr class="datagrid">
					<td width="25%" id="subven1">&nbsp;Whether Interest Subvention applicable </td>
					<td width="25%" id="subven2">
						<select name="sel_subvention">
							<option value="Y" >Yes</option>
							<option value="N" selected>No</option>
						</select>
					</td>
				</tr>
				
				<tr class="datagrid" id="idSvanidhi">
					<td width="25%" >&nbsp;Svanidhi Type </td>
					<td width="25%" >
						<select name="sel_SvanidhiType">
						<option value=""><--Select--></option>
							<option value="1" >PM Svanidhi 1.0</option>
							<option value="2" >PM Svanidhi 2.0</option>
							<option value="3" >PM Svanidhi 3.0</option>
						</select>
					</td>
				</tr>
				<tr class="datagrid">
				<td colspan="4">
				<table width="70%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="">
				<tr> 
                    <td width="47%" >Minimum Class Power for HO
                    </td>
                    <td width="29%" > 
                      <input type="hidden" name="prd_HO1" size="12"  maxlength="4" disabled onKeyPress="allowInteger()" style="text-align:right">
                      <select name="prd_HO" onChange="showDescRev(document.forms[0].prd_HO.value,'HO')">
                        <option value="">&lt;---Select---&gt;</option>
                        <lapschoice:usersclass /> 
                      </select>
                     </td>
                    <td width="24%" >                                       
                        <input type="text" name="prd_ho_descr" size="50"  maxlength="4" style="text-align:left">
                    </td>
                  </tr>
                   <tr> 
                    <td width="47%" >Minimum Class Power for RO
                    </td>
                    <td width="29%" > 
                      <input type="hidden" name="prd_RO1" size="12"  maxlength="4" disabled onKeyPress="allowInteger()" style="text-align:right">
                      <select name="prd_RO" onChange="showDescRev(document.forms[0].prd_RO.value,'RO')">
                        <option value="">&lt;---Select---&gt;</option>
                        <lapschoice:usersclass /> 
                      </select>
                     </td>
                    <td width="24%" >                                       
                        <input type="text" name="prd_ro_descr" size="50"  maxlength="4" style="text-align:left">
                    </td>
                  </tr>
					<tr>
                       <td width="35%" >Minimum Class Power for CLPU
                       </td>
                       <td width="29%" > 
                         <input type="hidden" name="prd_CLPU1" size="12"  maxlength="4" disabled onKeyPress="allowInteger()" style="text-align:right">
                         <select name="prd_CLPU" onChange="showDescRev(document.forms[0].prd_CLPU.value,'CLPU')">
                           <option value="">&lt;---Select---&gt;</option>
                           <lapschoice:usersclass /> 
                         </select>
                        </td>
                       <td width="24%" >                                       
                           <input type="text" name="prd_CLPU_descr" size="50"  maxlength="4" style="text-align:left">
                       </td>
                     </tr>
					 <tr> 
                         <td width="35%" >Minimum Class Power for Branch
                         </td>
                         <td width="29%" > 
                           <input type="hidden" name="prd_branch1" size="12"  maxlength="4" disabled onKeyPress="allowInteger()" style="text-align:right">
                           <select name="prd_branch" onChange="showDescRev(document.forms[0].prd_branch.value,'branch')">
                             <option value="">&lt;---Select---&gt;</option>
                             <lapschoice:usersclass /> 
                           </select>
                          </td>
                         <td width="24%" >                                       
                             <input type="text" name="prd_branch_descr" size="50"  maxlength="4" style="text-align:left">
                         </td>
                       </tr>
                       <tr>
	                       <td width="35%" nowrap="nowrap">Sanction Validity
	                       </td>
	                       <td width="29%" > 
	                         <input type="text" name="prd_sanc_days" size="15" maxlength="3" readonly="readonly" onKeyPress="allowInteger()" style="text-align:right">days
	                        </td>
	                      <td width="24%" nowrap="nowrap">&nbsp; </td>     
                       </tr>
                        <tr>
                           <td width="35%" nowrap="nowrap">Revalidation Validity
                           </td>
                           <td width="29%" >                                       
                               <input type="text" name="prd_revalid_days" size="15"  maxlength="3" readonly="readonly" onKeyPress="allowInteger()" style="text-align:right">days
                           </td>
                         <td width="24%" nowrap="nowrap">&nbsp; </td>  
                       </tr>
                       <tr>
                           <td width="35%" nowrap="nowrap">Facility is not availed/revalidated
                           </td>
                           <td width="29%" > 
                             <input type="text" name="prd_notavailed_days" size="15"  maxlength="3" readonly="readonly" onKeyPress="allowInteger();"  style="text-align:right">days
                            </td>
                           <td width="24%" nowrap="nowrap">&nbsp; </td>   
                         </tr>
                       <tr> 
                         <td colspan="3" >
                           <select name="prd_skip_value" style="width:100">
                             <option value="">&lt;---Select---&gt;</option>
                             <lapschoice:usersclassdesc /> 
                           </select>
                           </td>
                       </tr>
                       <%if(strbankschemeflag.equalsIgnoreCase("Y")){%>
                       <tr>
                           <td width="35%" nowrap="nowrap">% of CGSSD&nbsp;<b><span class="mantatory">*&nbsp;</span></b> </td>
                           <td width="29%" >                                       
                               <input type="text" name="txt_cgssd" size="15"  maxlength="3" readonly="readonly" onBlur="roundtxt(this);checkPercentage(this);" onKeyPress="allowInteger()" style="text-align:right" value="<%=Helper.correctNull((String) hshValues.get("COM_CGSSDPERC"))%>">(%)
                           </td>
                         <td width="24%" nowrap="nowrap">&nbsp; </td>  
                       </tr>
                       <%} %>
                       
                       <%if(strbankschemegeclflag.equalsIgnoreCase("Y")){%>
                       <tr>
                         <td >Select Gecl Type</td>
                         <td>
                           <select name="sel_gecl" style="width:100" onchange="onchangeval();">
                             <option value="">---Select---</option>
                             <option value="GECL1">GECL1</option>
							<option value="GECL2">GECL2</option>
                       		<option value="GECL3">GECL3</option>
                       		<option value="GECL4">GECL4</option>
                       		<option value="GECL -1 extension">GECL -1 extension</option>
							<option value="GECL -2 extension">GECL -2 extension</option>
                       		<option value="GECL -3 extension">GECL -3 extension</option>
                        
                           </select>
                           </td>
                           
                           
                       </tr>
                       
                       <tr id="idgecl1">
                       <td nowrap="nowrap" width="25%"> Maximum eligible limit to the borrower </td>
						<td nowrap="nowrap"><input type="text" name="txt_lmtogborrower" value="<%=Helper.correctNull((String) hshValues.get("COM_GECL1_MAXLIMITBORRO"))%>" style="text-align:right" size="15" maxlength="10"  onkeypress="allowNumber(this)"> (%)
						<td nowrap="nowrap" width="25%">Maximum eligible limit without NOC from others </td>
						<td nowrap="nowrap"><input type="text" name="txt_limitnoc" value="<%=Helper.correctNull((String) hshValues.get("COM_GECL1_MAXLIMITNOC"))%>" style="text-align:right" size="15" maxlength="10"  onkeypress="allowNumber(this)"> (%)
                       </tr>
                          <tr id="idgecl2">
                       <td nowrap="nowrap" width="25%"> Total eligible limit from entire MLI's</td>
						<td nowrap="nowrap"><input type="text" name="txt_limitmlis" value="<%=Helper.correctNull((String) hshValues.get("COM_GECL2_ELGLIMITMLIS"))%>" style="text-align:right" size="15" maxlength="10"  onkeypress="allowNumber(this)"> (%)
						<td nowrap="nowrap" width="25%"> Total eligible limit with our Bank</td>
						<td nowrap="nowrap"><input type="text" name="txt_limitbank" value="<%=Helper.correctNull((String) hshValues.get("COM_GECL2_ELIGLIMITBANK"))%>" style="text-align:right" size="15" maxlength="10"  onkeypress="allowNumber(this)"> (%)
						</tr>
                         <tr id="idgecl3">
                       <td nowrap="nowrap" width="25%">Maximum eligible limit to the borrower from entire MLIs</td>
						<td nowrap="nowrap"><input type="text" name="txt_lmtogborrowermlis" value="<%=Helper.correctNull((String) hshValues.get("COM_GECL3_MAXLIMITBORROMLIS"))%>" style="text-align:right" size="15" maxlength="10"  onkeypress="allowNumber(this)"> (%)
						<td nowrap="nowrap" width="25%">Maximum eligible limit to the borrower with our Bank</td>
						<td nowrap="nowrap"><input type="text" name="txt_lmtogborrowerbank" value="<%=Helper.correctNull((String) hshValues.get("COM_GECL3_MAXLIMITBANK"))%>" style="text-align:right" size="15" maxlength="10"  onkeypress="allowNumber(this)"> (%)
						</tr>
						<tr id="idgecl4">
                       <td nowrap="nowrap" width="25%">Maximum limit sanctioned under GECL 4 including proposed and existing limit</td>
						<td nowrap="nowrap"><input type="text" name="txt_lmtpropandrecomended" value="<%=Helper.correctNull((String) hshValues.get("COM_GECL4_LIMITPROPOSED"))%>" style="text-align:right" size="15" maxlength="10"  onKeyPress="allowNumber(this)" onBlur="roundtxt(this);">
						<td nowrap="nowrap" width="25%">&nbsp;</td>
						<td nowrap="nowrap">&nbsp;</td>
						</tr>

                        <tr id="idgecl5">
                       <td nowrap="nowrap" width="25%">Balance outstanding as on 29.02.2020</td>
						<td nowrap="nowrap"><input type="text" name="txt_lmtogborrowerrest" value="<%=Helper.correctNull((String) hshValues.get("COM_BAL_OUTSTANDING"))%>" style="text-align:right" size="15" maxlength="10"  onkeypress="allowNumber(this)"> (%)
						</tr>
						
						
						<tr id="idgecl6">
                        <td nowrap="nowrap" width="25%">Maximum eligible Finance </td>
						<td nowrap="nowrap"><input type="text" name="txt_max_eli_fin_gecl1ext" value="<%=Helper.correctNull((String) hshValues.get("COM_GECL1EXT_MAXELGFINANCE"))%>" style="text-align:right" size="15" maxlength="10"  onkeypress="allowNumber(this)"> (%)
                        <td nowrap="nowrap" width="25%"> Eligible finance under GECL 1 extension </td>
						<td nowrap="nowrap"><input type="text" name="txt_eli_fin_gecl1ext" value="<%=Helper.correctNull((String) hshValues.get("COM_GECL1EXT_ELGFINANCE"))%>" style="text-align:right" size="15" maxlength="10"  onkeypress="allowNumber(this)"> (%)
						
                       </tr>
                       
                       
                       <tr id="idgecl7">
                        <td nowrap="nowrap" width="25%">Total eligible limit with our Bank</td>
						<td nowrap="nowrap"><input type="text" name="txt_max_eli_fin_gecl2ext" value="<%=Helper.correctNull((String) hshValues.get("COM_GECL2EXT_MAXELGFINANCE"))%>" style="text-align:right" size="15" maxlength="10"  onkeypress="allowNumber(this)"> (%)
                        <td nowrap="nowrap" width="25%"> Eligible finance under GECL 2 extension </td>
						<td nowrap="nowrap"><input type="text" name="txt_eli_fin_gecl2ext" value="<%=Helper.correctNull((String) hshValues.get("COM_GECL2EXT_ELGFINANCE"))%>" style="text-align:right" size="15" maxlength="10"  onkeypress="allowNumber(this)"> (%)
						
                       </tr>
                       
                       
                       
                       <tr id="idgecl8">
                        <td nowrap="nowrap" width="25%">Total eligible limit with our Bank</td>
						<td nowrap="nowrap"><input type="text" name="txt_max_eli_fin_gecl3ext" value="<%=Helper.correctNull((String) hshValues.get("COM_GECL3EXT_MAXELGFINANCE"))%>" style="text-align:right" size="15" maxlength="10"  onkeypress="allowNumber(this)"> (%)
                        <td nowrap="nowrap" width="25%"> Eligible finance under GECL 3 extension </td>
						<td nowrap="nowrap"><input type="text" name="txt_eli_fin_gecl3ext" value="<%=Helper.correctNull((String) hshValues.get("COM_GECL3EXT_ELGFINANCE"))%>" style="text-align:right" size="15" maxlength="10"  onkeypress="allowNumber(this)"> (%)
						
                       </tr>
                       
                       
                       <%} %>
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
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="prd_code" value="<%=Helper.correctNull(request.getParameter("fac_id"))%>">
<input type="hidden" name="checkApp" value="<%=request.getParameter("checkApp")%>">
<input type="hidden" name="repaytype">
<input type="hidden" name="fac_id1" value="<%=Helper.correctNull(request.getParameter("fac_id"))%>">
<input type="hidden" name="hidindtype" value="">
<input type="hidden" name="hidAgrScheme" value="<%=Helper.correctNull((String)request.getParameter("hidAgrScheme"))%>">
</form>
</body>
</html>