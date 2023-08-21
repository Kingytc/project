<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	if (objValues instanceof java.util.HashMap) 
	{
		hshValues = (java.util.HashMap) objValues;
	}
	ArrayList vecData = new ArrayList();
	ArrayList vecRow = new ArrayList();
	int vecsize = 0;
	if (hshValues != null)
	{
		vecData = (ArrayList) hshValues.get("vecData");				
	}
	String strgroup = "";
	if (!strCategoryType.equalsIgnoreCase("")) {
		if (strCategoryType.equalsIgnoreCase("CORP")
				|| (strCategoryType.equalsIgnoreCase("SME"))) {
			strgroup = "Promoters";
		} else if (strCategoryType.equalsIgnoreCase("SSI")) {
			strgroup = "Banking Arrangement";
		}
	}
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	double dblcontilimittotal = 0.0, dblcontilimittotal1 = 0.0;
	double dblcontiostotal = 0.0, dblcontiostotal1 = 0.0;
	double dblfbwclimittotal = 0.0, dblfbwclimittotal1 = 0.0;
	double dblfbwcdptotal = 0.0, dblfbwcdptotal1 = 0.0;
	double dblfbwcostotal = 0.0, dblfbwcostotal1 = 0.0;
	double dbltllimittotal = 0.0, dbltllimittotal1 = 0.0;
	double dbltlostotal = 0.0, dbltlostotal1 = 0.0;
	double dblinvesttotal = 0.0, dblinvesttotal1 = 0.0;
	
	String strBorrowerType =Helper.correctNull((String)request.getParameter("hidBorrowerType"));
	java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	String strCategory=Helper.correctNull((String)request.getParameter("hidCategoryType"));
%>
<html>
<head>
<title>Commercial-Principal (s)</title>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
function callModFac(val)
{
	if(val=="s")
	{
		val="";
	}
	if(document.forms[0].sel_Bank.value!="")
	{
		 document.all.ifrFacilityDesc.src =appURL+"action/IframeGroupConcernFac.jsp?hidBeanId=executive&hidBeanGetMethod=getTLWCFacilitiesData&appno="+document.forms[0].hidappno.value+"&strModType="+document.forms[0].sel_Module.value+"&strFacType=1&val1="+val; 
	}
}

function calBankFun()
{
	if(document.forms[0].sel_Bank.value=="Our")
	{
		//document.forms[0].txt_Bank.value="Karnataka Bank";
	}
}
function selectValues(val0,val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16,val17,val18,val19,val20,val21,val22,val23,val24,val25,val26,val27,val28,val29,val30)
{
	document.forms[0].sel_Module.value=val21;
	document.forms[0].hidAction.value = "edit";	
	document.forms[0].selsno.value = val0;
	appno=document.forms[0].appno.value;
	document.forms[0].sel_Bank.value=val11;
	calBankFun();
	if(document.forms[0].sel_Bank.value=="Our")
	{
		document.forms[0].sel_Facility.value=val1;
		setIdNature(val1);
		document.forms[0].sel_FacilityType.value=val20;
	}
	else
	{
		document.forms[0].txt_Facility.value=val1;
		document.forms[0].hidFacSNo.value="";
		document.forms[0].sel_FacilityType.value=val20;
	}
	document.forms[0].idno.value=val0;
	document.forms[0].txt_OSAsOnDate.value=val2;
	document.forms[0].sel_BnkType.value=val3;
	document.forms[0].sel_IntType.value=val4;
	document.forms[0].sel_CreditType.value=val5;
	document.forms[0].txt_SancRefNo.value=val6;
	document.forms[0].txt_SancDate.value=val7;
	document.forms[0].txt_DueDate.value=val8;
	document.forms[0].txtArea_Arrears.value=val9;
	document.forms[0].sel_CompName.value=val10;
	document.forms[0].txt_Limit.value=val14;
	document.forms[0].txt_OS.value=val15;
	document.forms[0].txt_SpreadVal.value=val16;
	document.forms[0].txtarea_Remarks.value=val17;
	document.forms[0].txt_monthlyins.value=val22;
	document.forms[0].hidFacSNo.value=val19;
	document.forms[0].txt_cbsappno.value=val23;
	document.forms[0].sel_FacilityNew.value=val18;
	document.forms[0].txt_bank_intrate.value=val24;
	if(val21=="p")
	{
		document.forms[0].com_banksel_repaytype.length=6;
		document.forms[0].com_banksel_repaytype.options[1] = new Option('EMI','1');
		document.forms[0].com_banksel_repaytype.options[2] = new Option('Non-EMI','2');
		document.forms[0].com_banksel_repaytype.options[3] = new Option('On Demand','12');
		document.forms[0].com_banksel_repaytype.options[4] = new Option('On Due Date','8');
		document.forms[0].com_banksel_repaytype.options[5] = new Option('Equal Monthly Installment','13');
		document.forms[0].com_banksel_repaytype.options[6] = new Option('2 Yearly Equal Installment','14');
	}
	else
	{
		document.forms[0].com_banksel_repaytype.length=11;
		document.forms[0].com_banksel_repaytype.options[1] = new Option('EMI','E');
		document.forms[0].com_banksel_repaytype.options[2] = new Option('Non-EMI','NE');
		document.forms[0].com_banksel_repaytype.options[3] = new Option('On Demand','OD');
		document.forms[0].com_banksel_repaytype.options[4] = new Option('As Per LC Terms','LC');
		document.forms[0].com_banksel_repaytype.options[5] = new Option('As Per Contract Terms','CO');
		document.forms[0].com_banksel_repaytype.options[6] = new Option('As Per BG Rules','BG');
		document.forms[0].com_banksel_repaytype.options[7] = new Option('On Due Date','DD');
		document.forms[0].com_banksel_repaytype.options[8] = new Option('From the proceeds of PSC \ by realization of bill','PC');
		document.forms[0].com_banksel_repaytype.options[9] = new Option('By Realization of Export Bills','PS');
		document.forms[0].com_banksel_repaytype.options[10] = new Option('By Realization of Respective Bills','PR');
		document.forms[0].com_banksel_repaytype.options[11] = new Option('As per TCBG Rules','TG');
	}
	document.forms[0].com_banksel_repaytype.value=val25;
	document.forms[0].txt_bank_drwpower.value=val26;
	document.forms[0].txt_prestatus.value=val27;
	document.forms[0].txt_Exposure.value=val28;
	document.forms[0].txtArea_purpose.value=val29;
	document.forms[0].txtArea_repayment.value=val30;
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		disableCommandButtons(false,true,true,true,false);
	}
}
function doSave()
{
	if(document.forms[0].sel_CompName.value=="")
	{
		ShowAlert(111,"Company Name");
		document.forms[0].sel_CompName.focus();
		return;
	}
	if(document.forms[0].sel_Bank.value=="")
	{
		ShowAlert(111,"Bank");
		document.forms[0].sel_Bank.focus();
		return;
	}
	else if(document.forms[0].sel_Bank.value=="Our")
	{
		if(document.forms[0].sel_Module.value=="")
		{
			ShowAlert(111,"Module");
			document.forms[0].sel_Module.focus();
			return;
		}
		if(document.forms[0].sel_FacilityNew.value=="")
		{
			ShowAlert(111,"Facility");
			document.forms[0].sel_FacilityNew.focus();
			return;
		}
	}
	else if(document.forms[0].sel_Bank.value=="Other")
	{
		if(document.forms[0].sel_FacilityType.value=="")
		{
			ShowAlert(111,"Type of Facility");
			document.forms[0].sel_FacilityType.focus();
			return;
		}
		if(document.forms[0].txt_Bank.value=="")
		{
			ShowAlert(121,"Name of the Bank");
			document.forms[0].txt_Bank.focus();
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
	if(document.forms[0].sel_CreditType.value=="")
	{
		ShowAlert(111,"Type of Credit");
		document.forms[0].sel_CreditType.focus();
		return;
	}
	document.forms[0].sel_Bank.disabled=false;
	
	if(document.forms[0].sel_Bank.value=="Our")
	{
		 document.forms[0].sel_Module.disabled=false;
	}
	if(document.forms[0].txt_DueDate.value=="")
	{
	ShowAlert(121,"Due Date");
	document.forms[0].txt_DueDate.focus();
	return;
	}
	/*if(document.forms[0].sel_CreditType.value=="E")
	{
		if(document.forms[0].txt_cbsappno.value=="")
		{
		alert("Please Enter the CBS Account No");
		document.forms[0].txt_cbsappno.focus();
		return;
		}
	}*/
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].sel_CompName.disabled=false;
	document.forms[0].sel_Facility.disabled=false;
	document.forms[0].sel_BnkType.disabled=false;
	document.forms[0].sel_IntType.disabled=false;
	document.forms[0].sel_CreditType.disabled=false;
	document.forms[0].sel_Facility.disabled=false;
	document.forms[0].sel_FacilityType.disabled=false;
	document.forms[0].sel_Bank.disabled=false;
	document.forms[0].hidBeanId.value="executive";
	document.forms[0].hidSourceUrl.value="/action/comgroupcompanies.jsp";
	document.forms[0].hidBeanMethod.value="updateData7";
	document.forms[0].hidBeanGetMethod.value="getData7";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function disableCommandButtons(valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmddelete.disabled=true;
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmdclose.disabled=valclose;
}
function doEdit()
{
	disableFields(false);
	document.forms[0].hidflag.value ="edit";
	document.forms[0].hidAction.value ="update";
	if(document.forms[0].sel_Bank.value=="Our")
	{
		if(document.forms[0].sel_CreditType.value=="P")
		{
			document.forms[0].txt_Bank.value="Karnataka Bank";
			document.forms[0].txt_Bank.readOnly=true;
			document.forms[0].sel_Bank.disabled=true;
			document.forms[0].sel_Facility.disabled=true;
			document.forms[0].txt_Limit.readOnly=true;
			document.forms[0].txt_Exposure.readOnly=true;
			document.forms[0].txt_OS.focus();
			document.forms[0].sel_Module.disabled=true;
			disableCommandButtons(true,false,false,true,true);
		}
		else
		{
			disableCommandButtons(true,false,false,false,true);
			document.forms[0].sel_Bank.focus();
		}
	}
	else
	{
		disableCommandButtons(true,false,false,false,true);
		document.forms[0].sel_Bank.focus();
	}
	document.forms[0].sel_CompName.disabled=true;
	document.forms[0].sel_CreditType.disabled=true;
	document.forms[0].sel_Bank.disabled=true;
	document.forms[0].txt_Limit.readOnly=true;
	document.forms[0].txt_OS.readOnly=true;
	document.forms[0].txt_OSAsOnDate.readOnly=true;
	document.forms[0].txt_bank_drwpower.readOnly=true;
	document.forms[0].txt_Exposure.readOnly=true;
	document.forms[0].sel_Module.disabled=true;
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="executive";
		document.forms[0].hidBeanGetMethod.value="getData7";
		document.forms[0].action=appURL+"action/comgroupcompanies.jsp";
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
	document.forms[0].sel_FacilityNew.readOnly=true;
	document.forms[0].sel_CompName.disabled=true;
	document.forms[0].txt_cbsappno.readOnly=true;
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].sel_Bank.disabled=false;
		   	document.forms[0].hidAction.value ="delete";		
			document.forms[0].hidBeanMethod.value="updateData7";
			document.forms[0].hidBeanId.value="executive";
			document.forms[0].hidBeanGetMethod.value="getData7";
			document.forms[0].action=appURL+"action/ControllerServlet";	
			document.forms[0].hidSourceUrl.value="/action/comgroupcompanies.jsp";			
			document.forms[0].method="post";			
			document.forms[0].submit();	
		}	
	}
	else
	{
		ShowAlert(158);
	}
}
function onloading()
{
	disableFields(true);
	//document.forms[0].sel_Bank.value=="Our";
	document.forms[0].sel_Bank.disabled=true;
	document.forms[0].sel_Bank.value=="Our";
	document.forms[0].cmdedit.disabled=true;
	
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/corppge.jsp";
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
function callLink(page,bean,method)
{ 
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidAction.value="";
	 	document.forms[0].hidBeanGetMethod.value=method;
	 	document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].action=appURL+"action/"+page;
	 	document.forms[0].submit();
	}
	else 
	{
		ShowAlert(103);
	}
}
function setIdNature(varFac)
{
	if(varFac!="")
	{
		var varFacArr=new Array();
		varFacArr=varFac.split("~");
		if(varFacArr.length>1)
		{
			document.forms[0].hidFacSNo.value=varFacArr[0];
			document.forms[0].sel_FacilityType.value=varFacArr[1];
			
			if(document.forms[0].sel_FacilityType.value=="2")
			{
				document.all.id_monthlyins.style.display="table-cell";
				document.all.id_monthlyinsval.style.display="table-cell";
			}
			else
			{
				document.all.id_monthlyins.style.display="none";
				document.all.id_monthlyinsval.style.display="none";
			}
			 
		}
	}
}

function callDescHelp(varsubfacFlag)
{
	var varstrSessionModuleType=document.forms[0].sel_Module.value;
	var apptype="GCF";
	if(varstrSessionModuleType!="")
	{
		if(document.forms[0].cmdsave.disabled==false)
		{
			var varQryString = appURL+"action/facilitieslisthelp.jsp?hidBeanId=appeditlock&hidBeanGetMethod=getProductList&strFrom="+apptype+"&strModuleType="+varstrSessionModuleType;
			var title = "ProductsSearch";
			var prop = "scrollbars=no,width=700,height=430,status=yes";	
			prop = prop + ",left=50,top=50";		
			window.open(varQryString,title,prop);
		}
	}
	else
	{
      alert("Select Module Type");
      document.forms[0].sel_Module.focus();
      return;
	}
}

function callexisec()
{
 var btnenable=document.forms[0].btnenable.value;
	var hidAppNo=document.forms[0].hidappno.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidCommentPage=groupconcernFac&appstatus="+appstatus+"&btnenable="+btnenable;
	window.open(url,"Comments",prop);
}
function callRepayMentComments()
{
var btnenable=document.forms[0].btnenable.value;
	var hidAppNo=document.forms[0].hidappno.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidCommentPage=groupconcernRepay&appstatus="+appstatus+"&btnenable="+btnenable;
	window.open(url,"Comments",prop);	
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
<body onLoad="onloading();">
<form name="frmpri" method="post" class="normal">
  <iframe height="0" width="0" id="ifrm" frameborder="0" style="border:0"></iframe>
  <%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){
	  if(!strSessionModuleType.equalsIgnoreCase("RET")){%>
  <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="subpageid" value="103" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%}else{%>

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="3" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<table width="100%">
  		
  		<tr>
  			<td>
<table border="0" cellspacing="2" cellpadding="3"
			align="left" class="outertable">
			<tr>
			<td class="sub_tab_inactive" id="prin"><b><b><a
					href="#" onclick="javascript:callLink('combankingfi.jsp','bankappfi','getData')">  Existing  Banking Details</a></b></b></td>
		    <td class="sub_tab_active" id="prin" nowrap><b>  Guarantor / Group concern </b></td>
			</tr>
			</table>
			</td>
			</tr>
			</table>
	
<%}
	  }else{ %>
	 <%if(strSessionModuleType.equalsIgnoreCase("RET")){ %> 
        <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="12" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; 
       Retail(including schematic) -&gt; Application -&gt; Banking Arrangement-&gt;Group Concerns </td>
    </tr>
  </table>
  <%} else if(strSessionModuleType.equalsIgnoreCase("DIGI")) { %>
	  
	  	<jsp:include page="../share/applurllinkerdigi.jsp" flush="true"> 
	        <jsp:param name="pageid" value="12" />
	        </jsp:include>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
	    <tr> 
	     <td class="page_flow">Home -&gt; Digi Retail -&gt; Application -&gt; Banking Arrangement -&gt; Existing Banking Details </td>
	    </tr>
	  </table>
	<% }
	 else
	 { %>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">
		<%
			if (strCategoryType.equalsIgnoreCase("SRE")) {
		%> Home -&gt;Corporate &amp; SME -&gt; Short Review/Extension -&gt;
		Group Concerns <%
			} else if (strCategoryType.equalsIgnoreCase("STL")) {
		%> Home -&gt;Corporate &amp; SME -&gt; Short Term Loan -&gt; Group
		Concerns <%
			} else if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%> Home -&gt; Agriculture -&gt; Application-&gt;Co-Applicant / Guarantor-&gt; <%=strgroup%>
		Group Concerns <%
 	}else
 	{%>
 		Home -&gt; Corporate &amp; SME -&gt; Application-&gt;Co-Applicant / Guarantor-&gt; <%=strgroup%>-&gt;
		Group Concerns
 	<%}
 %>
		</td>
	</tr>
</table>
<%} %>
<span style="display: none;"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr align="center">
		<td valign="bottom">
		 <%if(strSessionModuleType.equalsIgnoreCase("RET") || strSessionModuleType.equalsIgnoreCase("DIGI")){ 
		 %> 
		 <table border="0" cellspacing="2" cellpadding="3"
			align="left" class="outertable">
			<tr>
			<td class="sub_tab_inactive" id="prin"><b><b><a
					href="#" onclick="javascript:callLink('combankingfi.jsp','bankappfi','getData')">  Existing  Banking Details</a></b></b></td>
		    <td class="sub_tab_active" id="prin" nowrap><b>  Guarantor / Group concern </b></td>
			</tr>
			</table>
		 <%}else { %>
		<table border="0" cellspacing="2" cellpadding="3" align="left" class="outertable">
			<tr>
				<td class="sub_tab_inactive" id="prin"><b> <a
					href="#" onclick="javascript:callLink('compromoters.jsp','compro','getProData')">Co-Applicant / Guarantor
				</a></b></td>
				<%
					if (strSessionModuleType.equalsIgnoreCase("CORP")
							|| strSessionModuleType.equalsIgnoreCase("SME")) {
				%>
				<!-- <td class="sub_tab_inactive" id="prin"><b><b><a
					href="#" onclick="javascript:callLink('com_companybackground.jsp','compro','getCompanyBackground')">Promoter
				Company / Group Companies Background</a></b></b></td> -->
				<% } %>
				<td class="sub_tab_active" id="prin" nowrap><b>Group Concerns</b></td>
				<td class="sub_tab_inactive" nowrap="nowrap"><b><b><a href="javascript:callLink('com_shareholdpattern.jsp','executive','getDataShareHoldPattern')">Share Holding Pattern</a></b></b></td>
				<td class="sub_tab_inactive" nowrap="nowrap"><b><b><a href="javascript:callLink('com_promocomments.jsp','compro','getgroupcomments')">Comments</a></b></b></td>
			</tr>
		</table>
		<%} %>
		</td>
	</tr>
</table>
<%} %>
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
										<td align="center">Company Name <span class="mantatory">*</span></td>
										<td align="center">Bank <span class="mantatory">*</span></td>
										<td align="center" id="id_Module">Module <span class="mantatory">*</span></td>
										<!--<td align="center" id="id_FacTypeLbl">Type of Facility <span class="mantatory">*</span></td>
										 <td align="center" id="id_BnkNameLbl">Name of the Bank <span class="mantatory">*</span></td>
										<td align="center" id="id_TypeLbl">Type <span class="mantatory">*</span></td> -->
										<td align="center" colspan="2">Facility <span class="mantatory">*</span></td>
									</tr>
									<tr align="center" class="datagrid">
										 <%if(strCategory.equalsIgnoreCase("RET") || strCategory.equalsIgnoreCase("DIGI") ){ %> 
										  <td> 
                                           <select name="sel_CompName" >
                                           <option selected value="">&lt;--Select--&gt;</option>
                                           <%
                                           	String strAppType="C','G','O','P";
                                           %>
				                            <lapschoice:coappguarantorsec apptype="<%=strAppType%>"  pagetype="GC"/>
								              </select>
								            </td>
										 <%}else{ %>
										<td align="center">
											<select name="sel_CompName" class="selectwidth" tabindex="1">
												<%
												String appidval = request.getParameter("appno");
												String strcompanyname = request.getParameter("appname");
											%>
				                                  <option value="">&lt;---select---&gt;</option>
				                                 <lapschoice:ComPromotors appno="<%=appidval%>" />
											</select>
										</td>
										 <%} %>
										<td align="center">
											<select name="sel_Bank" class="selectwidth" onChange="javascript:calBankFun()" tabindex="2">
											<!-- 	<option value="">--select--</option>  -->
												<option value="Our">Karnataka Bank</option>
											<!-- 	<option value="Other">Other bank</option> -->
											</select>
										</td>
								<td align="center" id="id_ModuleVal">
											<select name="sel_Module" class="selectwidth"  tabindex="1">
											<option value="">--select--</option>
											<option value="p">Retail</option>
											<option value="c">Corporate</option>
											<option value="a">Agriculture</option>
											</select>
								</td>
										<td align="center" id="id_FacTypeTxt" style="visibility:hidden;position:absolute">
											<select name="sel_FacilityType" class="selectwidth" onChange="javascript:calBankFun()" tabindex="3">
												<option value="">--select--</option>
												<option value="1">Working Capital</option>
												<option value="2">Term Loan</option>
											</select>
										</td>
										<!-- <td align="center" id="id_BnkNameTxt">
											<input type="text" name="txt_Bank" value="" size="30" readOnly="readonly" tabindex="4"
												maxlength="50" onBlur="calSelectBank()"
												onKeyPress="notAllowSplChar()">
										</td> 
										<td align="center" id="id_TypeTxt">
											<select name="sel_Type" tabindex="5">
												<option value="" selected="selected">---Select---</option>
												<option value="F">Funded</option>
												<option value="N">NonFunded</option>												
											</select>
										</td>-->
									<!-- 	<td align="center" colspan="2" id="id_FacilityTxt">
											<input type="text" name="txt_Facility" size="40" tabindex="6"
												maxlength="50" onKeyPress="notAllowSplChar()">
										</td>
									
											<!-- <select name="sel_Facility" tabindex="7" onChange="setIdNature(this.value);" style="width:250px" >
											<option value="" selected="selected">---Select---</option>											
											</select> -->
												<td align="center" colspan="2" id="id_FacilitySel">
											<input type="text" name="sel_FacilityNew" readonly="readonly" size="30"/>
											<input type="hidden" name="sel_Facility"/>
											<span onClick="callDescHelp()" style="cursor: hand;display: none;"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="2"></span>	
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
								<tr align="center" class="dataheader">
									<td align="center">Limit <span class="mantatory">*</span></td>
									<td align="center">Outstanding <span class="mantatory">*</span></td>
									<td align="center">Outstanding as on Date <span class="mantatory">*</span></td>
									<td align="center"  id="id_monthlyins">Monthly Installment</td>
									<td align="center">Banking Type <span class="mantatory">*</span></td>
									<td align="center">Interest Type <span class="mantatory">*</span></td>
									<td align="center">Spread Value <span class="mantatory">*</span></td>
								</tr>
								<tr align="center" class="datagrid">
									<td align="center">
										<lapschoice:CurrencyTag name="txt_Limit" maxlength="15" size="12" tabindex="8" onKeyPress="allowDecimals(this)" style="text-align:right" onBlur="roundtxt(this)" other="readOnly" />
									</td>
									<td align="center">
										<lapschoice:CurrencyTag name="txt_OS" maxlength="15" size="12" tabindex="9" onKeyPress="allowDecimals(this)" style="text-align:right" onBlur="roundtxt(this)" other="readOnly" />
									</td>
									<td align="center">
										<table>
										<tr>
											<td>
												<input type="text" name="txt_OSAsOnDate" tabindex="11"
													onBlur="checkDate(this);checkmaxdate(this,currdate)">
											</td>
											<td width="34%"><a alt="Select date from calender" tabindex="10"
												href="javascript:callCalender('txt_OSAsOnDate')"><img
												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
												border="0"></a>
											</td>
										</tr>
										</table>
									</td>
									<td align="center" id="id_monthlyinsval">
										<input type="text" name="txt_monthlyins" value="" size="12" style="text-align: right;" tabindex="13" maxlength="15" onKeyPress="allowDecimal(this,2)"  onblur="roundtxt(this)">
									</td>
									<td align="center">
										<select name="sel_BnkType" tabindex="11">
											<option value="">--Select--</option>
											<option value="S">Sole</option>
											<option value="C">Consortium</option>
											<option value="M">Multiple</option>
										</select>
									</td>
									<td align="center">
										<select name="sel_IntType" tabindex="12">
											<option value="">--Select--</option>
											<option value="BR">Base Rate</option>
											<option value="MCLR">MCLR</option>
											<option value="BRLEC">BR linked Export Credit</option>
											<option value="MCLEC">MCLR linked Export Credit</option>
											<option value="BPLR">BPLR</option>	
											<option value="LIBOR">LIBOR</option>
											<option value="EURIBOR">EURIBOR</option>
											<option value="EUROLIBOR">EUROLIBOR</option> 
											<option value="COMMI">Commission</option>
											<option value="NOTAP">Not Applicable</option>
											<option value="ST">6 Months Treasury Bill</option>			
											<option value="GS">10 Year Government Security</option>				
										</select>
									</td>
									<td align="center">
										<lapschoice:CurrencyTag name="txt_SpreadVal" maxlength="6" size="12" tabindex="13" style="text-align:right" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);checkPercentage(this);" />
									</td>
								</tr>
								</table>
							</td>
						</tr>
						 <tr>
							<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
								<tr align="center" class="dataheader">
									<td align="center" width="20%">Interest Rate&nbsp;%</td>
									<td align="center" width="20%">Repayment Type</td>
									<td align="center" width="20%">Drawing Power</td>
									<td align="center" width="40%">Present Status</td>	
									<td align="center" width="40%">Exposure</td>
								</tr>
								<tr align="center" class="datagrid">
								<td width="20%"><input type="text" name="txt_bank_intrate" maxlength="5" size="15" style=" text-align: right" onkeypress="allowNumber(this)" onblur="checkPercentage(this);roundtxt(this)"></td>
								<td width="20%">
									<select name="com_banksel_repaytype"  style="width:150px">
										<option value="0" selected>----Select----</option>
									             									
									</select>
								</td>
								<td width="20%"><input type="text" name="txt_bank_drwpower" maxlength="15" size="25" style=" text-align: right" onkeypress="allowNumber(this)" onblur="roundtxt(this)"></td>
                              	<td align="center"><input type="text" name="txt_prestatus" maxlength="100" size="35" style=" text-align: left" ></td>
                              	<td align="center"><input type="text" name="txt_Exposure" maxlength="100" size="35" style=" text-align: left" ></td>
                              	</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
								<tr align="center" class="dataheader">
									<td align="center">Type of Credit</td>
									<td align="center">Sanction Reference Number</td>
									<td align="center">Sanctioned Date</td>
									<td align="center">Due Date <span class="mantatory">*</span></td>
									<td align="center">CBS Account No <span class="mantatory">*</span></td>
								</tr>
								<tr align="center" class="datagrid">
									<td align="center">
										<select name="sel_CreditType" disabled="disabled" tabindex="14">
											<option value="" selected>--select--</option>
											<option value="E">Existing</option>
											<option value="P">Proposed</option>
										</select>
									</td>
									<td align="center"><input type="text" name="txt_SancRefNo" value="" size="30" tabindex="15" maxlength="30" onKeyPress="notAllowSingleAndDoubleQuote()"></td>
									<td align="center">
										<table>
										<tr>
											<td>
												<input type="text" name="txt_SancDate" tabindex="17"
													onBlur="checkDate(this);checkmaxdate(this,document.forms[0].txt_DueDate.value)">
											</td>
											<td width="34%"><a alt="Select date from calender" tabindex="16"
												href="javascript:callCalender('txt_SancDate')"><img
												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
												border="0"></a>
											</td>
										</tr>
										</table>
									</td>
									<td align="center">
										<table>
										<tr>
											<td>
												<input type="text" name="txt_DueDate" tabindex="18"
													onBlur="checkDate(this);checkmindate(this,document.forms[0].txt_SancDate.value)">
											</td>
											<td width="34%"><a alt="Select date from calender" tabindex="17"
												href="javascript:callCalender('txt_DueDate')"><img
												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
												border="0"></a>
											</td>
										</tr>
										</table>
									</td>
									<td align="center"><input type="text" name="txt_cbsappno" value="" size="30" readOnly="readonly" tabindex="13" maxlength="40" onkeypress="allowAlphaNumeric();"></td>
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
										<td align="center">Purpose</td>
										<td align="center">Repayment Comments</td>
									</tr>
									<tr align="center" class="datagrid">
										<td align="center">
											<textarea name="txtArea_Arrears" cols="50" style="text-align:left" tabindex="18" rows="3" onKeyPress="textlimit(document.forms[0].txtArea_Arrears,499)" onKeyUp="textlimit(this,499)"></textarea>
										</td>
										<td align="center">
											<textarea name="txtarea_Remarks" cols="50" style="text-align:left" tabindex="19" rows="3" onKeyPress="textlimit(document.forms[0].txtarea_Remarks,499)" onKeyUp="textlimit(this,499)"></textarea>
										</td>
										<td><textarea name="txtArea_purpose" cols="50" style="text-align:left" tabindex="16" rows="3" onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)" wrap="VIRTUAL"></textarea></td>
										<td><textarea name="txtArea_repayment" cols="50" style="text-align:left" tabindex="16" rows="3" onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)" wrap="VIRTUAL"></textarea></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
							<td>&nbsp;</td>
							</tr>
							<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' /><br>
							<tr style="display: none;">
								<td>
									<table width="25%" align="center" border="0" cellpadding="2" cellspacing="0">
									<tr>
										<td><input type="button" name="coll_exifac" class="buttonstyle" value="Comments on Existing Credit Facility" onClick="callexisec()"></td>
										<td><input type="button" name="coll_exifac" class="buttonstyle" value="Comments on Repayment" onClick="callRepayMentComments()"></td>
									</tr>
									</table>
								</td>
							</tr>
							<tr><td>&nbsp;&nbsp;</td></tr>
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
									<tr class="dataheader">
										<td width="3%">&nbsp;</td>
										<!-- <td width="19%" align="center">Company Name</td> -->
										<td width="21%" align="center">Facility</td>
										<td width="19%" align="center">Limit</td>
										<td width="10%" align="center">Banking Type</td>
										<td width="10%" align="center">Type of Credit</td>
										<td width="10%" align="center">Limit Type</td>
										<td width="10%" align="center">Nature of Limit</td>
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
											if(Helper.correctNull((String) vecRow.get(11)).equalsIgnoreCase("Our"))
											{
												strBank=Helper.correctNull((String)vecRow.get(18));
											}
											else
											{
												strBank=Helper.correctNull((String)vecRow.get(1));
											}
											String strBnkType=Helper.correctNull((String) vecRow.get(3));
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
											String strCreditType=Helper.correctNull((String) vecRow.get(5));
											if(strCreditType.equalsIgnoreCase("E"))
											{
												strCreditType="Existing";
											}
											else if(strCreditType.equalsIgnoreCase("P"))
											{
												strCreditType="Proposed";
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
														'<%=Helper.correctNull((String)vecRow.get(7))%>',
														'<%=Helper.correctNull((String)vecRow.get(8))%>',
														'<%=Helper.correctNull((String)vecRow.get(9))%>',
														'<%=Helper.correctNull((String)vecRow.get(10))%>',
														'<%=Helper.correctNull((String)vecRow.get(11))%>',
														'<%=Helper.correctNull((String)vecRow.get(12))%>',
														'<%=Helper.correctNull((String)vecRow.get(13))%>',
														'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.get(14))))%>',
														'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.get(15))))%>',
														'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.get(16))))%>',
														'<%=Helper.correctNull((String)vecRow.get(17))%>',
														'<%=Helper.correctNull((String)vecRow.get(18))%>',
														'<%=Helper.correctNull((String)vecRow.get(19))%>',
														'<%=Helper.correctNull((String)vecRow.get(20))%>','<%=Helper.correctNull((String)vecRow.get(21))%>',
														'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.get(22))))%>','<%=Helper.correctNull((String)vecRow.get(23))%>',
														'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.get(24))))%>','<%=Helper.correctNull((String)vecRow.get(25))%>',
														'<%=nf.format(Double.parseDouble((String)vecRow.get(26)))%>','<%=Helper.correctNull((String)vecRow.get(27))%>','<%=Helper.correctNull((String)vecRow.get(28))%>'
														,'<%=Helper.correctNull((String)vecRow.get(29))%>','<%=Helper.correctNull((String)vecRow.get(30))%>')">
											<input type="hidden" name="hid" value="<%=strSno%>">
										</td>
										<!-- <td align="left">&nbsp;<%=Helper.correctNull((String)vecRow.get(10))%></td> -->
										<td align="left">&nbsp;<%=strBank%></td>
										<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) vecRow.get(14))))%>&nbsp;</td>
										<td align="left">&nbsp;<%=strBnkType%></td>
										<td align="left">&nbsp;<%=strCreditType%></td>
										<td align="left">&nbsp;<%=Helper.correctNull((String) vecRow.get(31))%></td>
										<td align="left">&nbsp;<%=Helper.correctNull((String) vecRow.get(32))%></td>
									</tr>
									<%	}
									}
									if(vecsize<=0)
									{
									%>
									<tr class="datagrid">
										<td colspan="7" align="center">--No Records Found--</td>
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
		</td>
	</tr>
</table>
<br>
	<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidpageflag" value="cgc">
<input type="hidden" name="selsno" value="">
<input type="hidden" name="hidval">
<input type="hidden" name="hiddesc">
<input type="hidden" name="appnum">
<input type="hidden" name="num" value="<%=request.getParameter("appno")%>">
<input type="hidden" name="hidappnoNew" value="<%=request.getParameter("appno")%>">
<input type="hidden" name="cho" value="<%//=Helper.correctNull((String)hshValues.get("com_compdtid"))%>">
<input type="hidden" name="comapp_compid" value="<%=request.getParameter("comapp_compid")%>">
<input type="hidden" name="otherGenTable" value="">
<INPUT TYPE="hidden" NAME="hidPageSource" VALUE="">
<input type="hidden" name="sel_divID1">
<input type="hidden" name="hidCompName" value="<%=request.getParameter("appname")%>">
<input type="hidden" name="hidflag" value="">
<input type="hidden" name="comapp_compname" value="<%=request.getParameter("comapp_compname")%>">
<input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
<input type="hidden" name="ssitype" value="<%=strSSIType%>"> 
<input type="hidden" name="id" value="<%=strBorrowerType%>">
<input type="hidden" name="hidAppId" value="<%=Helper.correctNull((String)hshValues.get("hidAppId"))%>">
<input type="hidden" name="idno" value="">
<input type="hidden" name="type" value="G">
<input type="hidden" name="hidFacSNo" value="">
<iframe height="0" width="0" id="ifrFacilityDesc" frameborder="0" style="border:0" ></iframe>
<input type="hidden" name="hidappno" value="<%=Helper.correctNull((String)request.getParameter("appno")) %>">
</form>
</body>
</html>