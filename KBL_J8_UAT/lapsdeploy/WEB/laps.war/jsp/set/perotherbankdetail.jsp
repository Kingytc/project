<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	if (objValues instanceof java.util.HashMap) 
	{
		hshValues = (java.util.HashMap) objValues;
	}
//out.println("hshValues====="+hshValues);
	ArrayList vecData = new ArrayList();
	ArrayList vecRow = new ArrayList();
	int vecsize = 0;
	if (hshValues != null)
	{
		vecData = (ArrayList) hshValues.get("vecData");				
	}
	String strBorrowerType =Helper.correctNull((String)request.getParameter("hidBorrowerType"));
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	String strCategory=Helper.correctNull((String)request.getParameter("hidCategoryType"));
	String strProfilestatus = Helper.correctNull((String) hshValues
			.get("strProfilestatus"));
	String strEmployment=(String)session.getAttribute("strEmployment");
	String hidfacname = Helper.correctNull((String) hshValues.get("strFacname"));
	String strPageName=Helper.correctNull((String)hshValues.get("strIncompletepage"));
	
	String pageid = request.getParameter("pageid");
	String strapptype = Helper.correctNull((String)request.getParameter("corp"));
	%>
<html>
<head>
<title>Commercial-Principal (s)</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var varstrCategory="<%=strCategory%>";
function calBankFun()
{
	if(document.forms[0].sel_FacilityType.value=="" || document.forms[0].sel_FacilityType.value=="1" )
	{
	document.all.id_monthlyinsval.style.visibility = "hidden";
	document.all.id_monthlyinsval.style.position="absolute";
	document.all.id_monthlyins.style.visibility = "hidden";
	document.all.id_monthlyins.style.position="absolute";
	}
	else
	{
	document.all.id_monthlyinsval.style.visibility="visible";
	document.all.id_monthlyinsval.style.position="relative";
	document.all.id_monthlyins.style.visibility="visible";
	document.all.id_monthlyins.style.position="relative";
	}
	var seltype=document.forms[0].sel_FacilityType.value;
	if(trim(seltype)=="2")
	{
		document.forms[0].sel_Type.value="F";
		document.forms[0].sel_Type.disabled=true;
	}
	else
	{
		document.forms[0].sel_Type.disabled=false;
	}
}
function selectValues(val0,val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16,val17,val18,val19,val20,val21,val22,val23,val24,val25,val26,val27,val28,val29,val30,val31)
{
	document.forms[0].hidAction.value = "edit";	
	document.forms[0].selsno1.value = val0;
	document.forms[0].txt_Facility.value=val1;
	document.forms[0].idno.value=val0;
	document.forms[0].sel_FacilityType.value=val1;
	document.forms[0].txt_Facility.value=val2;
	document.forms[0].txt_OSAsOnDate.value=val3;
	document.forms[0].sel_IntType.value=val4;
	document.forms[0].sel_BnkType.value=val5;
	document.forms[0].txt_DueDate.value=val6;
	document.forms[0].txtArea_Arrears.value=val7;
	document.forms[0].txt_Bank.value=val8;
	document.forms[0].sel_Type.value=val9;
	document.forms[0].txt_Limit.value=val10;
	document.forms[0].txt_OS.value=val11;
	document.forms[0].txt_SpreadVal.value=val12;
	document.forms[0].txtarea_Remarks.value=val13;
	document.forms[0].txt_monthlyins.value=val14;
	document.forms[0].sel_BnkType.value=val5;
	document.forms[0].txt_InterestRate.value=val15;	
	document.forms[0].com_banksel_repaytype.value=val16;
	document.forms[0].txt_bank_drwpower.value=val17;
	document.forms[0].hid_LeadBankcode.value=val18;
	document.forms[0].txt_LeadBank.value=val19;
	document.forms[0].hid_Bankcode.value=val20;
	document.forms[0].hidAppid.value=val21;
	document.forms[0].sel_loanpurpose.value=val22;
	document.forms[0].txt_secDesc.value=val23;
	document.forms[0].txt_secValue.value=val24;

	document.forms[0].txt_NatureLitig.value=val25;
	document.forms[0].txt_DateLitig.value=val26;
	document.forms[0].txt_claimAmount.value=val27;
	document.forms[0].txt_otherClaim.value=val28;
	document.forms[0].txt_presentpos.value=val29;
	document.forms[0].sel_litigation.value=val30;
	document.forms[0].txt_StartDate.value=val31;
	litigchange();
	
	if(document.forms[0].readFlag.value=="r")
	{
		disableCommandButtons(true,true,true,true,true,false);
	}
	else
	{    
		 if(appstatus=="true")
		  {
			 disableCommandButtons(true,true,true,true,true,false);
		  }
		  else
		  {
			  
	          disableCommandButtons(true,false,true,true,true,false);
		  }
	}
	calBankFun();
	callLeadBank();
	document.forms[0].sel_Type.disabled=true;
}
function doSave()
{

	if(document.forms[0].sel_FacilityType.value=="")
	{
		ShowAlert(111,"Type of Facility");
		document.forms[0].sel_FacilityType.focus();
		return;
	}
	if(document.forms[0].txt_Bank.value=="")
	{
		ShowAlert(111,"Name of the Bank");
		return;
	}
	if(document.forms[0].sel_Type.value=="")
	{
		ShowAlert(111,"Type");
		document.forms[0].sel_Type.focus();
		return;
	}
	if(document.forms[0].txt_Facility.value=="")
	{
		ShowAlert(121,"Facility");
		document.forms[0].txt_Facility.focus();
		return;
	}
	if(document.forms[0].sel_loanpurpose.value=="")
	{
		ShowAlert(121,"Purpose of loan");
		document.forms[0].sel_loanpurpose.focus();
		return;
	}
	if(document.forms[0].txt_Limit.value=="")
	{
		ShowAlert(121,"Limit");
		document.forms[0].txt_Limit.focus();
		return;
	}
	if(document.forms[0].txt_OS.value=="")
	{
		ShowAlert(121,"Outstanding");
		document.forms[0].txt_OS.focus();
		return;
	}
	if(document.forms[0].txt_OSAsOnDate.value=="")
	{
		ShowAlert(121,"Outstanding as on Date");
		document.forms[0].txt_OSAsOnDate.focus();
		return;
	}
	if(document.forms[0].sel_BnkType.value=="")
	{
		ShowAlert(111,"Banking Type");
		document.forms[0].sel_BnkType.focus();
		return;
	}
	if(document.forms[0].sel_IntType.value=="")
	{
		ShowAlert(111,"Interest Type");
		document.forms[0].sel_IntType.focus();
		return;
	}
	if(document.forms[0].txt_SpreadVal.value=="")
	{
		ShowAlert(121,"Spread Value");
		document.forms[0].txt_SpreadVal.focus();
		return;
	}
	if(document.forms[0].txt_StartDate.value=="")
	{
		ShowAlert(111,"Start Date");
		document.forms[0].txt_StartDate.focus();
		return;
	}
	if(document.forms[0].txt_DueDate.value=="")
	{
		ShowAlert(111,"Due Date");
		document.forms[0].txt_DueDate.focus();
		return;
	}
	if(document.forms[0].com_banksel_repaytype.value=="0")
	{
		ShowAlert(111,"Repayment Type");
		document.forms[0].com_banksel_repaytype.focus();
		return;
	}
	if(document.forms[0].txt_secDesc.value=="")
	{
		ShowAlert(121,"Security Description");
		document.forms[0].txt_secDesc.focus();
		return;
	}
	if(document.forms[0].txt_secValue.value=="")
	{
		ShowAlert(121,"Security Value");
		document.forms[0].txt_secValue.focus();
		return;
	}
	if(document.forms[0].sel_litigation.value=="S")
	{
		ShowAlert(111,"Whether Litigation");
		document.forms[0].sel_litigation.focus();
		return;
	}
	if(document.forms[0].sel_litigation.value=="Y")
	{
		if(document.forms[0].txt_NatureLitig.value=="")
		{
			ShowAlert(121,"Nature of Litigation");
			document.forms[0].txt_NatureLitig.focus();
			return;
		}
		if(document.forms[0].txt_DateLitig.value=="")
		{
			ShowAlert(121,"Date of Litigation");
			document.forms[0].txt_DateLitig.focus();
			return;
		}
		if(document.forms[0].txt_claimAmount.value=="")
		{
			ShowAlert(121,"Claim amount");
			document.forms[0].txt_claimAmount.focus();
			return;
		}
		if(document.forms[0].txt_otherClaim.value=="")
		{
			ShowAlert(121,"Other claims");
			document.forms[0].txt_otherClaim.focus();
			return;
		}
		if(document.forms[0].txt_presentpos.value=="")
		{
			ShowAlert(121,"Present position");
			document.forms[0].txt_presentpos.focus();
			return;
		}	
	}
	else
	{
		document.forms[0].txt_NatureLitig.value="";
		document.forms[0].txt_DateLitig.value="";
		document.forms[0].txt_claimAmount.value="";
		document.forms[0].txt_otherClaim.value="";
		document.forms[0].txt_presentpos.value="";
	}
	
	
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].hidSourceUrl.value="/action/perotherbankdetail.jsp";
	document.forms[0].hidBeanMethod.value="updateBankdetail";
	document.forms[0].hidBeanGetMethod.value="getBankdetail";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function disableCommandButtons(valnew,valedit,valapply,valcancel,valdel,valclose,valcomment)
{
	document.forms[0].cmdnew.disabled =valnew;
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmdclose.disabled=valclose;
	document.forms[0].cmdcomments.disabled=valcomment;
}
function doEdit()
{
	disableFields(false);
	var seltype=document.forms[0].sel_FacilityType.value;
	if(trim(seltype)=="2")
	{
		document.forms[0].sel_Type.value="F";
		document.forms[0].sel_Type.disabled=true;
	}
	else
	{
		document.forms[0].sel_Type.disabled=false;
	}
	document.forms[0].hidflag.value ="edit";
	document.forms[0].hidAction.value ="update";
	disableCommandButtons(true,true,false,false,false,true,false);
	document.forms[0].txt_LeadBank.readOnly=true;
	document.forms[0].txt_Bank.readOnly=true;
}
function doNew()
{
	disableFields(false);
	disableCommandButtons(true,true,false,false,true,true,false);
	document.forms[0].txt_Bank.value="";
	document.forms[0].hideditflag.value="Y";	  
	document.forms[0].hidAction.value ="insert";	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].checked=false;
		}
	}
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidBeanGetMethod.value="getBankdetail";
		document.forms[0].action=appURL+"action/perotherbankdetail.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
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
		if(document.forms[0].elements[i].type=='textarea')
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=(!val);		  
		} 
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		  
		} 
	}
}
function doDelete()
{
	
		if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value ="delete";		
			document.forms[0].hidBeanMethod.value="updateBankdetail";
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getBankdetail";
			document.forms[0].action=appURL+"action/ControllerServlet";	
			document.forms[0].hidSourceUrl.value="/action/perotherbankdetail.jsp";			
			document.forms[0].method="post";			
			document.forms[0].submit();	
		}	
	
}
function onloading()
{
	disableFields(true);
	if(document.forms[0].readFlag.value=="r")
	{
		disableCommandButtons(true,true,true,true,true,false);
	}
	else
	{    
		 if(appstatus=="true")
		  {
			 disableCommandButtons(true,true,true,true,true,false);
		  }
		  else
		  {
			  
	          disableCommandButtons(false,true,true,true,true,false);
		  }
	}
	calBankFun();
	callLeadBank();
	document.forms[0].sel_Type.disabled=true;
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mastersearchper.jsp";
		document.forms[0].submit();
	}
}

function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}
function doComments()
{
	var hidDemoId=document.forms[0].hidDemoId.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getBankComments&hidDemoId="+hidDemoId+"&hidCommentPage=otherbank";
	window.open(url,"Comments",prop);
}
function callBankmaster(id)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
			var varQryString = appURL+"action/ops_sanctionhelp.jsp?hidBeanGetMethod=getSearch&hidBeanId=additionalParameter&pagename=CusBanking&id="+id;
			var title = "Bank_Master";
			var prop = "scrollbars=no,width=650,height=400";
			var xpos = "50";
			var ypos = "50";
			prop = prop+","+xpos+","+ypos+",left=200,top=200";
			window.open(varQryString,title,prop);
	}
}
function callBankmasterNew(id)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
			var varQryString = appURL+"action/ops_sanctionhelp.jsp?hidBeanGetMethod=getSearch&hidBeanId=additionalParameter&pagename=CusBanking&id="+id+"&LeadBank=Y";
			var title = "Bank_Master";
			var prop = "scrollbars=no,width=650,height=400";
			var xpos = "50";
			var ypos = "50";
			prop = prop+","+xpos+","+ypos+",left=200,top=200";
			window.open(varQryString,title,prop);
	}
}
function callLeadBank()
{
	if(document.forms[0].sel_BnkType.value=="C" )
	{
	document.all.idleaderbankname.style.visibility = "visible";
	document.all.idleaderbankname.style.position="relative";
	document.all.idleaderbankname1.style.visibility = "visible";
	document.all.idleaderbankname1.style.position="relative";
	}
	else
	{
	document.all.idleaderbankname.style.visibility="hidden";
	document.all.idleaderbankname.style.position="absolute";
	document.all.idleaderbankname1.style.visibility="hidden";
	document.all.idleaderbankname1.style.position="absolute";
	}
}

function litigchange()
{
	if(document.forms[0].sel_litigation.value=="Y")
	{
		document.all.litigData.style.visibility = "visible";
		document.all.litigData.style.position="relative";
	}
	else if(document.forms[0].sel_litigation.value=="N")
	{
		document.all.litigData.style.visibility = "hidden";
		document.all.litigData.style.position="absolute";
	}
	else
	{
		document.forms[0].sel_litigation.value="S";
		document.all.litigData.style.visibility = "hidden";
		document.all.litigData.style.position="absolute";
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<style>
.selectwidth
{
	width: 150px;
}
</style>
</head>
<body onLoad="onloading();litigchange()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="frmpri" method="post" class="normal">
 
<%if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equals("")) { %>
 
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Customer
		Profile -&gt; Facilities with Other Bank </td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
			<tr>
		<td><jsp:include page="../share/Cusurllink.jsp" flush="true">
			<jsp:param name="pageid" value="11" />
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="strProfilestatus" value="<%=strProfilestatus%>" />
			<jsp:param name="hidfacname" value="<%=hidfacname%>" />
			<jsp:param name="hidincompletedpagename" value="<%=strPageName%>" />
			</jsp:include></td>
	</tr>
		</table>
		</td>
	</tr>
</table>

<% } else {  %>

<%
if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ 
if(!strSessionModuleType.equalsIgnoreCase("RET")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="subpageid" value="115" />
			<jsp:param name="subsubpageid" value="11" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<% }else{%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="subsubpageid" value="11"/>
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %>
<jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value=""/>
			<jsp:param name="subsubpageid" value="11"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include>
<%}else{ %>
<%if(strapptype.equalsIgnoreCase("C")){ %>
 <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="cattype" value="CORP" />
			<jsp:param name="ssitype" value="" />
			<jsp:param name="applevel" value="A" />
		</jsp:include>
		</td>
	</tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Application -&gt; Applicant -&gt; Customer Profile -&gt; Facilities with Other Bank </td>
	</tr>
  </table>
  <%} else if(strSessionModuleType.equalsIgnoreCase("DIGI")){ %>
 <jsp:include page="../share/applurllinkerdigi.jsp" flush="true"> 
        <jsp:param name="pageid" value="<%=pageid%>" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; 
       Digi Retail -&gt; Application -&gt; Applicant/Guarantor -&gt; Facilities with Other Bank </td>
    </tr>
  </table> 
  <%}  else if(strapptype.equalsIgnoreCase("R")){ %>
 <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="<%=pageid%>" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; 
       Retail -&gt; Application -&gt; Applicant/Guarantor -&gt; Facilities with Other Bank </td>
    </tr>
  </table> 
  <%} %>
<lapschoice:application />
	
 <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
	<%if(strapptype.equalsIgnoreCase("C")){ %>
		<tr>
		<lapstab:ComfacilityTab tabid="2" />
		</tr>
		<%}%>
		<%if(strapptype.equalsIgnoreCase("C") || strapptype.equalsIgnoreCase("R")){ %>
			<tr>
		<td><jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value="11"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include></td>
			</tr>
			<%} %>
		</table>
		</td>
	</tr>
</table>
<%} %>


<% } %>

  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
									<tr align="center" class="dataheader">
										<td align="center" >Type of Facility</td>
										<td align="center" >Name of the Bank <span class="mantatory">*</span></td>
										<td align="center" >Type <span class="mantatory">*</span></td>
										<td align="center" colspan="2">Facility <span class="mantatory">*</span></td>
										<td align="center">Purpose of Loan <span class="mantatory">*</span></td>
									<td align="center">Limit <span class="mantatory">*</span></td>
									<td align="center">Outstanding <span class="mantatory">*</span></td>
									</tr>
									<tr align="center" class="datagrid">
																
										<td align="center" id="id_FacTypeTxt">
											<select name="sel_FacilityType" class="selectwidth" onChange="javascript:calBankFun()" tabindex="1">
												<option value="" selected>--select--</option>
												<option value="1">Working Capital</option>
												<option value="2">Term Loan</option>
											</select>
										</td>
										<td align="center">
											<input type="text" name="txt_Bank" value="" size="30" readOnly="readonly"  
												maxlength="50"  onKeyPress="notAllowSingleAndDoubleQuote();notAllowSplChar()"
												 tabindex="2">
												 <input type="hidden" name="hid_LeadBankcode" value="">
										<a href="#" onClick="callBankmaster('147')" style="cursor: hand">
										<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
										</a>
									</td>
										<td align="center" id="id_TypeTxt">
											<select name="sel_Type" tabindex="3">
												<option value="" selected>---Select---</option>
												<option value="F">Funded</option>
												<option value="N">NonFunded</option>
											</select>
										</td>
										<td align="center" colspan="2" id="id_FacilityTxt">
											<input type="text" name="txt_Facility" size="40" tabindex="4" 
												maxlength="50" 
												onKeyPress="notAllowSplChar();notAllowSingleAndDoubleQuote()">
										</td>
										<td align="center">
											<select name="sel_loanpurpose">
												<option value="">---Select---</option>
												<option value="1">Agro processing</option>
												<option value="2">Agriculture Infrastructure</option>
												<option value="3">Others</option>
												<option value="4">Advance Against for Physical form</option>
												<option value="5">Advance Against for Demat form</option>
												<option value="6">Stand Up India</option>
												<option value="G">GECL 1/3</option>
		        			                    <option value="P">ParyaTan</option>
											</select>
										</td>
										<td align="center">
										<lapschoice:CurrencyTag name="txt_Limit"
											maxlength="15" size="12" tabindex="5"
											onKeyPress="allowDecimals(this)" style="text-align:right"
											onBlur="roundtxt(this)" other="readOnly" />
									</td>
									<td align="center">
										<lapschoice:CurrencyTag name="txt_OS"
											maxlength="15" size="12" tabindex="6"
											onKeyPress="allowDecimals(this)" style="text-align:right"
											onBlur="roundtxt(this)" other="readOnly" />
									</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
								<tr align="center" class="dataheader">
									
									<td align="center">Outstanding as on Date <span class="mantatory">*</span></td>
									<td align="center" id="id_monthlyins">Monthly Installment</td>
									<td align="center">Banking Type <span class="mantatory">*</span></td>
									<td align="center" id="idleaderbankname">Name of the Leader Bank</td>
									<td align="center">Interest Type <span class="mantatory">*</span></td>
									<td align="center">Spread Value <span class="mantatory">*</span></td>
								</tr>
								<tr align="center" class="datagrid">
									
									<td align="center">
										<table>
										<tr>
											<td>
												<input type="text" name="txt_OSAsOnDate" tabindex="7"
													onBlur="checkDate(this);checkmaxdate(this,currdate)" maxlength="12" size="12">
											</td>
											<td width="34%"><a style="vertical-align: middle" alt="Select date from calender" tabindex="8"
												href="javascript:callCalender('txt_OSAsOnDate')"><img
												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
												border="0"></a>
											</td>
										</tr>
										</table>
									</td>
									<td align="center" id="id_monthlyinsval">
										<input type="text" name="txt_monthlyins" value="" size="12" tabindex="13" maxlength="15" onKeyPress="allowDecimal(this,2)"  onblur="roundtxt(this)" tabindex="8">
									</td>
									<td align="center">
										<select name="sel_BnkType" tabindex="9" onchange="callLeadBank()">
											<option value="">--Select--</option>
											<option value="S">Sole</option>
											<option value="C">Consortium</option>
											<option value="M">Multiple</option>
										</select>
									</td>
									<td align="center"  id="idleaderbankname1">
											<input type="text" name="txt_LeadBank"  size="30" readOnly="readonly"  
												maxlength="50"  onKeyPress="notAllowSingleAndDoubleQuote();notAllowSplChar()"
												 tabindex="10">
												 <input type="hidden" name="hid_Bankcode" value="">
										<a href="#" onClick="callBankmasterNew('147')" style="cursor: hand">
										<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
										</a>
									</td>
									<td align="center">
										<select name="sel_IntType" tabindex="11">
											<option value="">--Select--</option>
											<option value="BR">Base Rate</option>
											<option value="MCLR">MCLR</option>
											<option value="BRLEC">BR linked Export Credit</option>
											<option value="MCLEC">MCLR linked Export Credit</option>
											<option value="EBLEC">EBLR linked export credit</option>
											<option value="BPLR">BPLR</option>
											<option value="LIBOR">LIBOR</option>
											<option value="EURIBOR">EURIBOR</option>
											<option value="EUROLIBOR">EUROLIBOR</option> 
											<option value="COMMI">Commission</option>
											<option value="NOTAP">Not Applicable</option>
											<option value="ST">6 Months Treasury Bill</option>			
											<option value="GS">10 Year Government Security</option>
											<option value="FTBR">FBIL-TERM MIBOR</option>
									   </select>
									</td>
									<td align="center">
										<lapschoice:CurrencyTag name="txt_SpreadVal"
											maxlength="6" size="8" tabindex="12"
											style="text-align:right" onKeyPress="allowDecimals(this)"
											onBlur="roundtxt(this);checkPercentage(this);" />
									</td>
										</tr>
										</table>
									</td>																													
								</tr>
								</table>
							</td>
						</tr>
						
						   <tr>
							<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
								<tr align="center" class="dataheader">
									<td align="center">Interest Rate </td>
									<td align="center">Start Date <span class="mantatory">*</span></td>
									<td align="center">Due Date <span class="mantatory">*</span></td>
									<td align="center" width="20%">Repayment Type <span class="mantatory">*</span></td>
									<td align="center" width="20%">Drawing Power</td>
															 
								</tr>
								<tr align="center" class="datagrid">
								<td align="center">
										<lapschoice:CurrencyTag name="txt_InterestRate"
											maxlength="6" size="8" tabindex="13"
											style="text-align:right" onKeyPress="allowDecimals(this)"
											onBlur="roundtxt(this);checkPercentage(this);" />
									</td>
									<td>
												<input type="text" name="txt_StartDate" tabindex="16"
													onBlur="checkDate(this);checkmaxdate(this,document.forms[0].txt_DueDate.value);" maxlength="12" size="12">
											
											
											<a style="vertical-align: middle" alt="Select date from calender" tabindex="14"
												href="javascript:callCalender('txt_StartDate')"><img
												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
												border="0"></a>
											</td>	
									<td>
												<input type="text" name="txt_DueDate" tabindex="16"
													onBlur="checkDate(this);checkmindate(this,document.forms[0].txt_StartDate.value);" maxlength="12" size="12">
											
											
											<a style="vertical-align: middle" alt="Select date from calender" tabindex="14"
												href="javascript:callCalender('txt_DueDate')"><img
												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
												border="0"></a>
											</td>								
									<td width="20%"><select name="com_banksel_repaytype"  style="width:150px" tabindex="15">
											<option value="0" selected>----Select----</option>
											<option value="E">EMI</option>
											<option value="NE">Non-EMI</option>	
											<option value="OD">On Demand</option>
											     		<option value="LC">As Per LC Terms</option>
											     		<option value="CO">As Per Contract Terms</option>
											     		<option value="BG">As Per BG Rules</option>										
											          	<option value="DD">On Due Date</option>
											          	<option value="PC" title="From the proceeds of PSC / by realization of bill">From the proceeds of PSC \ by realization of bill</option>
								          				<option value="PS" title="By Realization of Export Bills">By Realization of Export Bills</option>
								          				<option value="PR" title="By Realization of Respective Bills">By Realization of Respective Bills</option>
								          				<option value="TG" title="As per TCBG Rules">As per TCBG Rules</option>
											
										             									
										</select></td>
										<td width="20%"><input type="text" name="txt_bank_drwpower" maxlength="15" size="25" style=" text-align: right" onkeypress="allowNumber(this)" onblur="roundtxt(this)" tabindex="16"></td>										
                             
								</tr>
								</table>
								</td>
								</tr>
						
						<tr>
							<td>
							<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
								<tr align="center" class="dataheader">
									<td align="center" width="50%">Security Description <span class="mantatory">*</span> </td>
									<td align="center" width="30%">Security Value <span class="mantatory">*</span></td>
									<td align="center" width="20%">Whether Litigation <span class="mantatory">*</span></td>
								</tr>
								<tr align="center" class="datagrid">
								<td width="50%"><input type="text" name="txt_secDesc" size="80"></td>	
								<td width="30%"><input type="text" name="txt_secValue" size="20" onKeyPress="allowDecimals(this)"
											onBlur="roundtxt(this);"  style="text-align: right"> </td>		
								<td width="20%">
									<select name="sel_litigation" tabindex="9" onchange="litigchange()">
											<option value="S" selected="selected">--Select--</option>
											<option value="Y">Yes</option>
											<option value="N">No</option>
										</select>
								 </td>
								</tr>							
							</table>
							</td>
						</tr>
						<tr id="litigData">
						<td >
							<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
							<tr align="center" class="dataheader">
									<td align="center" >Nature of Litigation <span class="mantatory">*</span> </td>
									<td align="center" >Date of Litigation <span class="mantatory">*</span></td>
									<td align="center" >Claim amount(Rs.) <span class="mantatory">*</span></td>
									<td align="center" >Other claims <span class="mantatory">*</span></td>
								 	<td align="center" >Present position <span class="mantatory">*</span></td>
								 
							</tr>
							<tr align="center" class="datagrid" >
								<td ><input type="text" name="txt_NatureLitig" ></td>	
								<td ><input type="text" name="txt_DateLitig" >
										<a style="vertical-align: middle" alt="Select date from calender" tabindex="14"
												href="javascript:callCalender('txt_DateLitig')"><img
												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
												border="0"></a></td>	
								<td ><input type="text" name="txt_claimAmount"  maxlength="20" onKeyPress="allowDecimals(this)"	onBlur="roundtxt(this);"  style="text-align: right" ></td>	
								<td ><input type="text" name="txt_otherClaim" maxlength="20" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);"  style="text-align: right"></td>	
								<td ><input type="text" name="txt_presentpos" ></td>	
								
							</tr>
							</table>
						</td>
						</tr>						
						<tr>
							<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
									<tr align="center" class="dataheader">
										<td align="center">Arrears if any</td>
										<td align="center">Remarks</td>
									</tr>
									<tr align="center" class="datagrid">
										<td align="center">
											<textarea name="txtArea_Arrears" cols="70" style="text-align:left" tabindex="17"
												rows="3" onKeyPress="textlimit(document.forms[0].txtArea_Arrears,3999)" onKeyUp="textlimit(this,3999)"></textarea>
										</td>
										<td align="center">
											<textarea name="txtarea_Remarks" cols="70" style="text-align:left" tabindex="18"
												rows="3" onKeyPress="textlimit(document.forms[0].txtarea_Remarks,3999)" onKeyUp="textlimit(this,3999)"></textarea>
										</td>
									</tr>
									
								</table>
								</td>
							</tr>
							<tr>
							<td>&nbsp;</td>
							</tr>
							
							<%if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equals("")) { %>	
							
							<lapschoice:combuttonnew btnnames="New_Edit_Save_Delete_Cancel_Audit Trail_Comments"
								btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' /><br>
							
							<% }  else { %>
							<span style="display: none; "><div >
								<!-- <lapschoice:combuttonnew btnnames="New_Edit_Save_Delete_Cancel_Audit Trail_Comments"
								btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' /><br> -->
							</div> </span><br>
								<lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
						 <% } %>
							
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
									<tr class="dataheader">
										<td width="3%">&nbsp;</td>
										<td width="19%" align="center">Name of the Bank</td>
										<td width="21%" align="center">Facility</td>
										<td width="19%" align="center">Limit</td>
										<td width="19%" align="center">Banking Type</td>
										<td width="19%" align="center">Due Date</td>
									</tr>
									<%
									if (vecData != null)
									{
										vecsize = vecData.size();
									}
									String strSno = "";
									double strLFE = 0.00;
									double strLNFE = 0.00;
									double strLFP = 0.00;
									double strLNFP = 0.00;
									double strOSF = 0.00;
									double strOSNF = 0.00;
									for (int i = 0; i < vecsize; i++)
									{
										vecRow = (ArrayList) vecData.get(i);
										if (vecRow != null && vecRow.size() > 0)
										{
											strSno = Helper.correctDouble((String) vecRow.get(0));
											String strBank="";
											
											String strBnkType=Helper.correctNull((String) vecRow.get(5));
											if(strBnkType.equalsIgnoreCase("S"))
											{
												strBnkType="Sole";
											}
											else if(strBnkType.equalsIgnoreCase("C"))
											{
												strBnkType="Consortium";
											}
											else if(strBnkType.equalsIgnoreCase("M"))
											{
												strBnkType="Multiple";
											}
											
									%>
									<tr class="datagrid">
										<td align="center">
											<input type="radio" name="sno" style="border-style:none"
												onClick="selectValues('<%=Helper.correctInt((String)vecRow.get(0))%>',
														'<%=Helper.correctNull((String)vecRow.get(1))%>',
														'<%=Helper.correctNull((String)vecRow.get(2))%>',
														'<%=Helper.correctNull((String)vecRow.get(3))%>',
														'<%=Helper.correctNull((String)vecRow.get(4))%>',
														'<%=Helper.correctNull((String)vecRow.get(5))%>',
														'<%=Helper.correctNull((String)vecRow.get(6))%>',
														'<%=Helper.replaceForJavaScriptString((String)vecRow.get(7))%>',
														'<%=Helper.correctNull((String)vecRow.get(8))%>',
														'<%=Helper.correctNull((String)vecRow.get(9))%>',
														'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.get(10))))%>',
														'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.get(11))))%>',
														'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.get(12))))%>',
														'<%=Helper.replaceForJavaScriptString((String)vecRow.get(13))%>',
														'<%=Helper.correctNull((String)vecRow.get(14))%>',
														'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.get(15))))%>',
														'<%=Helper.correctNull((String)vecRow.get(16))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecRow.get(17))))%>',
														'<%=(Helper.correctNull((String)vecRow.get(18)))%>',
														'<%=(Helper.correctNull((String)vecRow.get(19)))%>',
														'<%=(Helper.correctNull((String)vecRow.get(20)))%>',
														'<%=(Helper.correctNull((String)vecRow.get(21)))%>',
														'<%=(Helper.correctNull((String)vecRow.get(22)))%>',
														'<%=(Helper.correctNull((String)vecRow.get(23)))%>',
														'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.get(24))))%>',
														'<%=(Helper.correctNull((String)vecRow.get(25)))%>',
														'<%=(Helper.correctNull((String)vecRow.get(26)))%>',
														'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.get(27))))%>',
														'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.get(28))))%>',
														'<%=(Helper.correctNull((String)vecRow.get(29)))%>',
														'<%=(Helper.correctNull((String)vecRow.get(30)))%>',
														'<%=(Helper.correctNull((String)vecRow.get(31)))%>'
														)">
											<input type="hidden" name="hid" value="<%=strSno%>">
										</td>
										<td align="left">&nbsp;<%=Helper.correctNull((String)vecRow.get(8))%></td>
										<td align="left">&nbsp;<%=Helper.correctNull((String)vecRow.get(2))%></td>
										<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.get(10))))%></td>
										<td align="left">&nbsp;<%=strBnkType%></td>
										<td align="left">&nbsp;<%=Helper.correctNull((String)vecRow.get(6))%></td>
									</tr>
									<%	}
									}
									if(vecsize<=0)
									{
									%>
									<tr class="datagrid">
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td align="center">--No Records Found--</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<%
									}
									%>
									
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
  <input type="hidden" name="hidflag" value="">
  <input type="hidden" name="selsno1" value="">
  <input type="hidden" name="hidval">
  <input type="hidden" name="hiddesc">
  <input type="hidden" name="comapp_compname" value="<%=request.getParameter("comapp_compname")%>">
  <input type="hidden" name="comapp_compid" value="<%=request.getParameter("comapp_compid")%>">
  <input type="hidden" name="hidPageSource" value="">
  <input type="hidden" name="hidDemoId"	value="<%=Helper.correctNull((String) request.getParameter("hidDemoId"))%>">
  <input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
  <input type="hidden" name="ssitype" value="<%=strSSIType%>"> 
  <input type="hidden" name="id" value="<%=strBorrowerType%>">
  <input type="hidden" name="hidAppId" value="<%=Helper.correctNull((String)hshValues.get("hidAppId"))%>">
  <input type="hidden" name="idno" value="">
  <input type="hidden" name="type" value="T">
  <input type="hidden" name="hidFacSNo" value="">
  <input type="hidden" name="hidappno" value="<%=Helper.correctNull((String)request.getParameter("appno")) %>">
  <input type="hidden" name="hidFacID">
  <input type="hidden" name="hidPageType" value="otherbank">
  <input type="hidden" name="hidappstatus" value="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>"> 
  <input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
  <iframe height="0" width="0" id="ifrFacilityDesc" frameborder="0" style="border:0" ></iframe>
  <input type="hidden" name="txtperapp_appid" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>"> 
<input type="hidden" name="hidfacname"	value="<%=hidfacname%>">
<input type="hidden" name="hidAppid">
</form>
</body>
</html>



