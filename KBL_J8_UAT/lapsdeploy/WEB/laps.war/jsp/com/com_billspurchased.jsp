<%@include file="../share/directives.jsp"%>
<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<%
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	arrRow = (ArrayList) hshValues.get("arrRow");
	String strSector = Helper.correctNull((String) request
			.getParameter("hidsector"));
	String strSaral = Helper.correctNull((String) request
			.getParameter("hidsaral"));
	String strApploantype = Helper.correctNull((String) request
			.getParameter("apploantype"));
	String strApplevel = Helper.correctNull((String) request
			.getParameter("applevel"));
	String strProposal = Helper.correctNull(request
			.getParameter("hidproposal"));
	String strValuesin = Helper.correctNull((String) request
			.getParameter("valuesin"));
	String strappno = Helper.correctNull((String) request
			.getParameter("appno"));

	if (strValuesin.equals("L")) {
		strValuesin = " in Lacs";
	} else if (strValuesin.equals("C")) {
		strValuesin = " in Crores";
	} else {
		strValuesin = "";
	}
	String strappholder = Helper.correctNull((String) request
			.getParameter("appholder"));
	String strappliedfor = Helper.correctNull((String) request
			.getParameter("appliedfor"));
	//Added by Zahoorunnisa.S for button functionality
	String strstatus = Helper.correctNull((String) request
			.getParameter("hidstatus"));
  
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	if (strstatus.equals(""))
		strstatus = Helper
				.correctNull((String) hshValues.get("status"));

	String strapplevel = Helper.correctNull((String) request
			.getParameter("applevel"));
	//end

	String desc[] = { "Inland Bills under LC",
			"Inland bills under collection (Non-LC)",
			"Export Bills under LC - sight",
			"Export Bills under LC - usance",
			"Export Bills under collection (Non-LC)  - sight",
			"Export Bills under collection (Non-LC)  - usance",
			"Local Bills sent on Collection",
			"Returns, if any & when reimbursement",
			"Export Bills sent on Collection",
			"Export Bills on advance payment basis", "ITT received","Export Bills under Direct","Returns, if any & when reimbursement"};

	int arraySize = desc.length;

	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	nf.setGroupingUsed(false);
%>

<html>
<head>
<title>Facility For Recommendation</title>


<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varOrgLevel="<%=strOrgLevel%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varInlandexp="<%=Helper.correctNull((String) hshValues.get("strInlandexp"))%>";
var varright= "<%=Helper.correctNull(
							(String) session.getAttribute("strGroupRights"))
							.charAt(18)%>";

function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}
 
function selectValues(val1,val2,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16,val17,
		val18,val19,val20,val21,val22,val23,val24,val25,val26,val27,val28,val29,val30,val31,val32,val33,val34,val35,val36,val37)
{
	document.forms[0].hidAppno.value = val1;
	document.forms[0].hidsno.value = val2;
	
	document.forms[0].txt_sanc_limit.value = val5;
	document.forms[0].txt_number1.value = val6;
	document.forms[0].txt_amount1.value = val7;
	document.forms[0].txt_number2.value = val8;
	document.forms[0].txt_amount2.value = val9;
	document.forms[0].txt_number3.value = val10;
	document.forms[0].txt_amount3.value = val11;
	document.forms[0].txt_number4.value = val12;
	document.forms[0].txt_amount4.value = val13;
	document.forms[0].txt_number5.value = val14;
	document.forms[0].txt_amount5.value = val15;
	document.forms[0].txt_number6.value = val16;
	document.forms[0].txt_amount6.value = val17;
	document.forms[0].txt_number7.value = val18;
	document.forms[0].txt_amount7.value = val19;
	document.forms[0].txt_number8.value = val20;
	document.forms[0].txt_amount8.value = val21;
	document.forms[0].txt_number9.value = val22;
	document.forms[0].txt_amount9.value = val23;
	document.forms[0].txt_number10.value = val24;
	document.forms[0].txt_amount10.value = val25;
	document.forms[0].txt_number11.value = val26;
	document.forms[0].txt_amount11.value = val27;
	if(val31=="1")
	{
		document.forms[0].txt_excess.value = val28;
	}else{
		document.forms[0].txt_Expexcess.value = val28;
	}
	document.forms[0].txtar_comments.value = val29;
	document.forms[0].sel_date.value = val30;
	document.forms[0].sel_Inlandexp.value = val31;
	document.forms[0].txtadvpayment_comments.value = val32;
	document.forms[0].txt_number12.value = val33;
	document.forms[0].txt_amount12.value = val34;
	document.forms[0].txt_number13.value = val35;
	document.forms[0].txt_amount13.value = val36;
	document.forms[0].txtidpms_comments.value = val37;
	
	disableFields(true);
//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh

//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A")
	{
//If the Application is in open status
		if("<%=strstatus%>"=="O"  &&  varright=="w")
		{
		    enableButtons(true,false,true,false,false,false);
		}
		else
		{
			enableButtons(true,true,true,true,true,false);	
		}			
	}
	else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == "")
	{		
		enableButtons(true,true,true,true,true,false);
	}
	else
	{		
		if("<%=strapplevel%>" == "S")
		{
			enableButtons(true,true,true,true,true,false);
		}
		else
		{
			if(document.forms[0].btnenable.value=="Y")
			{
				enableButtons(true,false,true,false,false,false);
			}
			else
			{				
				enableButtons(true,true,true,true,true,false);
			}
	    }
	}
	//End
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text'  )
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=='textarea'  )
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		
	}
	if(document.forms[0].sel_date.type=='select-one'  )
	{
		document.forms[0].sel_date.disabled=val;
	}
}

function onloading()
{	  
	//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh
	
	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		if("<%=strstatus%>"=="O"  &&  varright=="w"){
			if(document.forms[0].btnenable.value=="Y")
			{
		    enableButtons(false,true,true,true,true,false);
			}
		}else{
			enableButtons(true,true,true,true,true,false);	
		}
			
	} else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		
		enableButtons(true,true,true,true,true,false);
			
    }else{
		
		if("<%=strapplevel%>" == "S"){
			enableButtons(true,true,true,true,true,false);
		}
	}
	document.forms[0].sel_Inlandexp.value=varInlandexp;
	//End
	disableFields(true);
	if(document.forms[0].hidNonPoolFlag.value=="Y")
	{
		disableCommandButtons(true,true,true,true,true,false);
	}
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction1.value ="update";
	document.forms[0].hideditflag.value="Y";
	disableCommandButtons(true,true,false,true,false,true);
	document.forms[0].sel_date.disabled = true; 
	
}

function doSave()
{	
	document.forms[0].sel_Inlandexp.disabled=false;
	if(document.forms[0].sel_date.value=="")
	{
		alert("Select the year");
		document.forms[0].sel_date.focus();	
		return;
	}
	else if(document.forms[0].txt_sanc_limit.value=="" || document.forms[0].txt_sanc_limit.value=="0.00"|| document.forms[0].txt_sanc_limit.value=="0")
	{
		alert("Enter Sanction Limit");
		document.forms[0].txt_sanc_limit.focus();
		return;
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].sel_date.disabled = false;
		document.forms[0].hidBeanId.value="inwardRegister";		
		document.forms[0].hidSourceUrl.value="/action/com_billspurchased.jsp";
		document.forms[0].hidBeanMethod.value="updateBillsPurchasedDetails";
		document.forms[0].hidBeanGetMethod.value="getBillsPurchasedDetails";
		document.forms[0].action=appURL+"controllerservlet?hidbustype=BP";
		document.forms[0].submit();
}

function doDelete()
{
	 if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction1.value ="delete";
		document.forms[0].hidBeanMethod.value="updateBillsPurchasedDetails";
		document.forms[0].hidBeanGetMethod.value="getBillsPurchasedDetails";	
		document.forms[0].hidBeanId.value="inwardRegister";
		document.forms[0].hidSourceUrl.value="action/com_billspurchased.jsp";	
		document.forms[0].action=appURL+"controllerservlet?hidbustype=BP";
		document.forms[0].submit();	
	 }	
}

function doNew()
{
	disableFields(false);
    document.forms[0].hidAction1.value ="insert";
    document.forms[0].hideditflag.value="Y";
    disableCommandButtons(true,true,false,true,false,true);
    document.forms[0].sel_Inlandexp.disabled=true;
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction1.value ="";
		document.forms[0].hidBeanId.value="inwardRegister";
		document.forms[0].hidBeanGetMethod.value="getBillsPurchasedDetails";
		document.forms[0].action=appURL+"action/com_billspurchased.jsp";
		document.forms[0].submit();
	}
}
   
 function disableCommandButtons(cmdnew,cmdedit,cmdapply,cmddel,cmdcancel,cmdclose)
 {  
	  document.forms[0].cmdnew.disabled =cmdnew;
	  document.forms[0].cmdedit.disabled=cmdedit;	  
	  document.forms[0].cmdsave.disabled=cmdapply;
	  document.forms[0].cmddelete.disabled=cmddel;
	  document.forms[0].cmdcancel.disabled=cmdcancel;
	  document.forms[0].cmdclose.disabled=cmdclose;
 }
 function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function enableButtons(valnew,valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdnew.disabled=valnew;
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
}

function comparedate(date1,date2)
{	
	var pgdt=changeDateformat(date1);
	var maxdt=changeDateformat(date2);
	if(pgdt.value!="")
	{
		if(Date.parse(pgdt) > Date.parse(maxdt))
		{
			alert("To Date cannot be lesser than From Date");
			document.forms[0].txt_todate.value="";
			document.forms[0].txt_todate.focus();								
		}			
	}
}

function funInlandExp()
{
	var varInland=document.forms[0].sel_Inlandexp.value;
	
	if(varInland=="2")
	{
		document.all.IDEXP.style.visibility="visible";
		document.all.IDEXP.style.position="relative";

		document.all.IDEXP1.style.visibility="visible";
		document.all.IDEXP1.style.position="relative";

		document.all.IDEXP2.style.visibility="visible";
		document.all.IDEXP2.style.position="relative";


		document.all.IDEXP3.innerHTML="Comments on EDPMS (Position shall be Discussed)";
		
		document.all.IDINL.style.visibility="hidden";
		document.all.IDINL.style.position="absolute";

		document.all.IDINL1.style.visibility="hidden";
		document.all.IDINL1.style.position="absolute";

		document.all.IDINL2.style.visibility="hidden";
		document.all.IDINL2.style.position="absolute";
		
		
	}
	else
	{
		document.all.IDINL.style.visibility="visible";
		document.all.IDINL.style.position="relative";

		document.all.IDINL1.style.visibility="visible";
		document.all.IDINL1.style.position="relative";

		document.all.IDINL2.style.visibility="visible";
		document.all.IDINL2.style.position="relative";

		

		document.all.IDEXP.style.visibility="hidden";
		document.all.IDEXP.style.position="absolute";

		document.all.IDEXP1.style.visibility="hidden";
		document.all.IDEXP1.style.position="absolute";

		document.all.IDEXP2.style.visibility="hidden";
		document.all.IDEXP2.style.position="absolute";


		document.all.IDEXP3.innerHTML="Comments on IDPMS (Position shall be Discussed)";
		
		
			
	}

	
	
	
}
function funload()
{
	var varInland=document.forms[0].sel_Inlandexp.value;
	if((varInland=="2")||(varInland=="1"))
	{
		if(document.forms[0].btnenable.value=="Y")
		{
		enableButtons(false,true,true,true,true,false);	
		}
	}
	else
	{
		enableButtons(true,true,true,true,true,false);	
	}

	if(document.forms[0].hidNonPoolFlag.value=="Y")
	{
		disableCommandButtons(true,true,true,true,true,false);
	}
}

function funcaldata()
{
	document.forms[0].hidBeanId.value="inwardRegister";
	document.forms[0].hidBeanGetMethod.value="getBillsPurchasedDetails";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_billspurchased.jsp";
	document.forms[0].submit();
	
}

function checkYear()
{
	<%
	if (arrRow != null && arrRow.size() > 0) {
		if (arrRow.size() > 0) {
			for (int i = 0; i < arrRow.size(); i++) {
				arrCol = (ArrayList) arrRow.get(i);
			String yearslno= Helper.correctNull((String) arrCol.get(27));
	%>
		var yearslno="<%=yearslno %>";	
		var selYear=document.forms[0].sel_date.value; 
		if(yearslno==selYear)
		{
			alert("Already data exist for the selected year");
			document.forms[0].cmdsave.disabled=true;
			return;
		}
		else
		{
			document.forms[0].cmdsave.disabled=false;
		}

	<%} } } %>
	
	
}
function chkcnt(varPage,val)
{
	if(varPage=="INL")
	{
		var var1="",var2="",var3="",var4="";
		if(val=="No")
		{
	
			var1=document.forms[0].txt_number1.value;
			var2=document.forms[0].txt_number2.value;
			var3=document.forms[0].txt_number7.value;
			if(var1=="")
			{
				var1="0";
			}
			if(var2=="")
			{
				var1="0";
			}
			if(var3=="")
			{
				var1="0";
			}
	
			var4=eval(var1)+eval(var2)+eval(var3);
			
			if(eval(var4)<eval(document.forms[0].txt_number8.value))
			{
				alert("No of returned should not be greater than the total inland bills");
				document.forms[0].txt_number8.value="";
				document.forms[0].txt_number8.focus();
				return;
			}
		}
		else
		{
			var1=document.forms[0].txt_amount1.value;
			var2=document.forms[0].txt_amount2.value;
			var3=document.forms[0].txt_amount7.value;
			if(var1=="")
			{
				var1="0";
			}
			if(var2=="")
			{
				var1="0";
			}
			if(var3=="")
			{
				var1="0";
			}
	
			var4=eval(var1)+eval(var2)+eval(var3);
			
			if(eval(var4)<eval(document.forms[0].txt_amount8.value))
			{
				alert("No of returned Amount should not be greater than the total inland bills Amount");
				document.forms[0].txt_amount8.value="";
				document.forms[0].txt_amount8.focus();
				return;
			}
		}
	}
	else
	{
		var var1="",var2="",var3="",var4="",val5="",val6="",val7="",val8="",val9="";
		if(val=="No")
		{
	
			var1=document.forms[0].txt_number3.value;
			var2=document.forms[0].txt_number4.value;
			var3=document.forms[0].txt_number5.value;
			var4=document.forms[0].txt_number6.value;
			var5=document.forms[0].txt_number9.value;
			var6=document.forms[0].txt_number10.value;
			var7=document.forms[0].txt_number11.value;
			var8=document.forms[0].txt_number12.value;
			if(var1=="")
			{
				var1="0";
			}
			if(var2=="")
			{
				var1="0";
			}
			if(var3=="")
			{
				var1="0";
			}
			if(var4=="")
			{
				var4="0";
			}
			if(var5=="")
			{
				var5="0";
			}
			if(var6=="")
			{
				var6="0";
			}
			if(var7=="")
			{
				var7="0";
			}
			if(var8=="")
			{
				var8="0";
			}
	
			var9=eval(var1)+eval(var2)+eval(var3)+eval(var4)+eval(var5)+eval(var6)+eval(var7)+eval(var8);
			
			if(eval(var9)<eval(document.forms[0].txt_number13.value))
			{
				alert("No of returned should not be greater than the total Export bills");
				document.forms[0].txt_number13.value="";
				document.forms[0].txt_number13.focus();
				return;
			}
		}
		else
		{
			var1=document.forms[0].txt_amount3.value;
			var2=document.forms[0].txt_amount4.value;
			var3=document.forms[0].txt_amount5.value;
			var4=document.forms[0].txt_amount6.value;
			var5=document.forms[0].txt_amount9.value;
			var6=document.forms[0].txt_amount10.value;
			var7=document.forms[0].txt_amount11.value;
			var8=document.forms[0].txt_amount12.value;
			if(var1=="")
			{
				var1="0";
			}
			if(var2=="")
			{
				var1="0";
			}
			if(var3=="")
			{
				var1="0";
			}
			if(var4=="")
			{
				var4="0";
			}
			if(var5=="")
			{
				var5="0";
			}
			if(var6=="")
			{
				var6="0";
			}
			if(var7=="")
			{
				var7="0";
			}
			if(var8=="")
			{
				var8="0";
			}
	
			var9=eval(var1)+eval(var2)+eval(var3)+eval(var4)+eval(var5)+eval(var6)+eval(var7)+eval(var8);
			
			if(eval(var9)<eval(document.forms[0].txt_amount13.value))
			{
				alert("No of returned amount should not be greater than the total Export bills");
				document.forms[0].txt_amount13.value="";
				document.forms[0].txt_amount13.focus();
				return;
			}
		}
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading();funInlandExp();funload()">
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
<form method="post" name="frmbrrecmd" class="normal">
<%
if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
class="outertable">
<tr>
	<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
		<jsp:param name="pageid" value="9" />
		<jsp:param name="subpageid" value="126" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
		<jsp:param name="ssitype" value="<%=strSSIType%>" />
	</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
	</td>
</tr>
</table>
<%}else{
	if (strSaral.equalsIgnoreCase("saral")) {
%> <lapschoice:saralreportTag tabid="8" sector="<%=strSector%>"
	applied="<%=strappliedfor%>" proposal="<%=strProposal%>" /> <lapschoice:inward />
<%
	} else if (strApploantype.equalsIgnoreCase("c")||strApploantype.equalsIgnoreCase("a")) {
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="15" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
	     <%if(strSessionModuleType.equals("AGR")){%>
	<td class="page_flow">Home&nbsp;-&gt;&nbsp;Agriculture&nbsp;-&gt;&nbsp;Proposal&nbsp;-&gt;
		&nbsp;Business Turn Over&nbsp;-&gt;&nbsp;Conduct of Working Capital Facilities&nbsp;-&gt;&nbsp;Bills Purchased</td>
	<%}else{ %>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Corporate&nbsp;&amp;&nbsp;SME&nbsp;-&gt;&nbsp;Proposal&nbsp;-&gt;
		&nbsp;Business Turn Over&nbsp;-&gt;&nbsp;Conduct of Working Capital Facilities&nbsp;-&gt;&nbsp;Bills Purchased</td>
		<%} %>	
		
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%
	} else if (strApploantype.equalsIgnoreCase("T")) {
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<b><i>Home -&gt; Tertiary -&gt; Application -&gt; Reports -&gt;
Recommendation by Branch</i></b> <span style="display: none"><lapschoice:borrowertype /></span>
<lapschoice:application /> <lapstab:TerReportTab tabid="3"
	applevel="<%=strApplevel%>" applied="<%=strappliedfor%>" /> <%
 	} else if (strApploantype.equalsIgnoreCase("P")) {
 %>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable border1">
	<tr>
		<td id="mainlnk1"><jsp:include page="../share/Applurllinkper.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><b><i>Home -&gt; Retail -&gt; <%=(String) session.getAttribute("pgeLabel")%>
		-&gt; Appraisal -&gt; Recommendation by Branch</i></b></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td id="mainlnk1"><lapschoice:application /></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable border1">
	<tr>
		<td><jsp:include page="../share/apprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="12" />
		</jsp:include></td>
	</tr>
</table>
<%
	}

	else if ((strCategoryType.equals("ADC"))) {
%>
<table border="0" width="100%" class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../share/menus.jsp"
			flush="true"/>
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="12" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Adhoc
		Limit -&gt; Business Turn Over -&gt; Business Operation</td>
	</tr>
	<tr>
		<td><span style="display: none"> <lapschoice:borrowertype /></span>
		<lapschoice:application /></td>
	</tr>
</table>
<%
	}}
%>
<table border="0" cellspacing="1" cellpadding="3" class="outertable"
	width="90%">
	<tr>
	<td class="sub_tab_inactive" align="center"><b> <a href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getOthersDetails','com_others.jsp')"
			onMouseOut="window.status='';return true;">Business Operation</a> </b></td>
		<td class="sub_tab_inactive" align="center"><b> <a href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','facilities','getComments','com_termloancomments.jsp?hidPage=term')"
			onMouseOut="window.status='';return true;">Term Loan</a> </b></td>
		<td class="sub_tab_active" " align="center"><b> Conduct of
		Working Capital Facilities</b></td>
		<td class="sub_tab_inactive" align="center"><b> <a href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','compro','getcom_nonfundloanlcdata','facilityremdforadverse.jsp')"
			onMouseOut="window.status='';return true;">Non Funded Loans</a> </b></td>
		<td class="sub_tab_inactive" align="center"><b> <a href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','compro','getFinancialComments','com_otherfaccomments.jsp?hidPage=otherfac')"
			onMouseOut="window.status='';return true;">Overall Comments</a> </b></td>
		
		<td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','facilities','getComments','comments_transaction.jsp?hidPage=commentsTrans')"
			onMouseOut="window.status='';return true;">Comments on Transaction in the existing accounts</a> </b></td>
	</tr>
</table>
<table border="0" cellspacing="1" cellpadding="3" class="outertable"
	width="60%">
	<tr>
		<td class="sub_tab_inactive" align="center"><b> <a href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getOdCcLimits','facilityremdforbusiess.jsp?hidbustype=AF')"
			onMouseOut="window.status='';return true;">OD / CC Limit</a> </b></td>

		<td class="sub_tab_inactive" align="center"><b> <a href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getPackingCredit','com_packingcredit.jsp')"
			onMouseOut="window.status='';return true;">BPC &amp; PC /
		Shipping Loan</a> </b></td>
		<td class="sub_tab_active" " align="center" nowrap="nowrap"><b>Bills
		Purchased</b></td>

	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable border1">
	<tr>
		<td><br>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="70%" border="0" cellspacing="0" cellpadding="0"
							align="center" class="outertable border1">
							<tr>
								<td>
								<table width="45%" border="0" cellspacing="0" cellpadding="3"
									class="outertable">
									
									<tr>
										<td >Select Inland/ Export Bills </td>
										<td>
											<select name="sel_Inlandexp" onchange="funInlandExp();funcaldata()">
											<option value="">---Select---</option>
											<option value="1">Inland Bills</option>
											<option value="2">Export Bills</option>
											</select>
										 </td>
										 
									 </tr>
									
									<tr>
									     <td>Select the year<b><span class="mantatory">*&nbsp;</span></b> </td>
									     <td>
										<select name="sel_date" onchange="checkYear()">
     										<option value="">-- Select -- </option>
     									 <laps:AgrFinancialYear appno="<%=strappno%>" page="" />
     									 </select></td>
     								</tr>
     								<tr>
										<td >Sanctioned Limit&nbsp;&nbsp;&nbsp;</td>
										<td> <input
											type="text" name="txt_sanc_limit" size="20"
											style="text-align: right" maxlength="12" onKeyPress="allowNumber(this)"
											onBlur="roundtxt(this);">
										</td>
										 
									</tr>
									
									
									
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="3"
									class="outertable">
									<tr class="dataheader">
										<td width="50%">&nbsp;</td>
										<td width="25%" align="center"><b>Number</b></td>
										<td width="25%" align="center"><b>Amount</b></td>
									</tr>
										
									</table>
									
									<table width="100%" border="1" cellspacing="0" cellpadding="3" class="outertable" id="IDINL">
																										
									<%
										for (int i = 0; i < arraySize; i++) {
											
											if((i==0)||(i==1)||(i==6)||(i==7))
											{
									%>
									<tr>
										<td width="50%"><%=desc[i]%></td>
										<td align="center" width="25%"><input type="text"
											name="txt_number<%=i + 1%>" size="15"
											onKeyPress="allowInteger()" maxlength="7" onblur="chkcnt('INL','No')"></td>
										<td align="center" width="25%"><input type="text"
											name="txt_amount<%=i + 1%>" style="text-align: right" size="15"
											onKeyPress="allowNumber(this)" maxlength="12"
											onBlur="roundtxt(this);chkcnt('INL','Amt')"></td>
									</tr>
									<%
										}
										}
									%>
									<tr>
										<td>No. of occasion excesses permitted</td>
										<td align="center"><input type="text" name="txt_excess"
											size="15" onKeyPress="allowInteger()" maxlength="7"></td>
										<td>&nbsp;</td>
									</tr>
									
									</table>
									<tr>
									<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3"class="outertable" id="IDEXP">


									<%
										for (int i = 0; i < arraySize; i++) {
											
											if((i==2)||(i==3)||(i==4)||(i==5)||(i==8)||(i==9)||(i==10)||(i==11)||(i==12))
											{
									%>
									<tr>
										<td width="50%"><%=desc[i]%></td>
										<td align="center" width="25%"><input type="text"
											name="txt_number<%=i + 1%>" size="15"
											onKeyPress="allowInteger()" maxlength="7" onblur="chkcnt('EXP','No')"></td>
										<td align="center" width="25%"><input type="text"
											name="txt_amount<%=i + 1%>" style="text-align: right"
											size="15" onKeyPress="allowNumber(this)" maxlength="12"
											onBlur="roundtxt(this);chkcnt('EXP','Amt');"></td>
									</tr>
									<%
										}
										}
									%>
									<tr>
										<td>No. of occasion excesses permitted</td>
										<td align="center"><input type="text" name="txt_Expexcess"
											size="15" onKeyPress="allowInteger()" maxlength="7"></td>
										<td>&nbsp;</td>
									</tr>

								</table>
								</td>
									</tr>
									<tr>
									<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td><b>Comments</b></td>
										<td colspan="2" align="center"><textarea
											name="txtar_comments" cols="48" rows="3"
											ONKEYUP="textlimit(this,99);"
											ONKEYDOWN="textlimit(this,99);"
											ONKEYPRESS="textlimit(this,99);notAllowSingleAndDoubleQuote()" onKeyUp="textlimit(this,99)"></textarea></td>
									</tr>
									<tr>
										<td><span  id="IDEXP3">Details of Advance Payment received and remain Unadjusted as on date</span></td>
										<td colspan="2" align="center"><textarea
											name="txtidpms_comments" cols="48" rows="3"
											ONKEYUP="textlimit(this,99);"
											ONKEYDOWN="textlimit(this,99);"
											ONKEYPRESS="textlimit(this,99);notAllowSingleAndDoubleQuote()" onKeyUp="textlimit(this,99)"></textarea></td>
									</tr>
									<tr>
										<td>Details of Advance Payment received and remain Unadjusted as on date</td>
										<td colspan="2" align="center"><textarea
											name="txtadvpayment_comments" cols="48" rows="3"
											ONKEYUP="textlimit(this,99);"
											ONKEYDOWN="textlimit(this,99);"
											ONKEYPRESS="textlimit(this,99);notAllowSingleAndDoubleQuote()" onKeyUp="textlimit(this,99)"></textarea></td>
									</tr>
									</table>
								
								</td>
							</tr>
						</table>
						<br>
						<lapschoice:combuttonnew
							btnnames='New_Edit_Save_Cancel_Delete_Audit Trail'
							btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
						<br>
						<table width="70%" border="0" cellspacing="0" cellpadding="0"
							align="center" class="outertable border1">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="3"
									class="outertable" id="IDINL1">
									<tr class="dataheader">
										<td width="5%">&nbsp;</td>
										<td align="center" width="30%"><b>Inland Bills under LC - Number</b></td>
										<td align="center" width="30%"><b>Inland Bills under LC - Amount</b></td>
										<td align="center" width="35%"><b>Amount (<%=ApplicationParams.getCurrency()%><%=strValuesin%>)</b></td>
									</tr>
								</table>
								
								
								<table width="100%" border="0" cellspacing="1" cellpadding="3"
									class="outertable" id="IDEXP1">
									<tr class="dataheader">
										<td width="5%">&nbsp;</td>
										<td align="center" width="30%"><b>Export Bills under LC - sight</b></td>
										<td align="center" width="30%"><b>Export Bills under LC - Amount</b></td>
										<td align="center" width="35%"><b>Amount (<%=ApplicationParams.getCurrency()%><%=strValuesin%>)</b></td>
									</tr>
								</table>
								
								
								
								<table width="100%" border="0" cellspacing="1" cellpadding="3"
									class="outertable" id="IDINL2">
									<%
										if (arrRow != null && arrRow.size() > 0) {
											for (int i = 0; i < arrRow.size(); i++) {
												arrCol = (ArrayList) arrRow.get(i);
									%>
									<tr class="datagrid">
										<td width="5%" align="center"><input type="radio"
											style="border: none" name="rdoUser"
											onClick="javascript:selectValues(
							'<%=Helper.correctNull((String) arrCol.get(0))%>',
							'<%=Helper.correctNull((String) arrCol.get(1))%>',
							'<%=Helper.formatDoubleValue(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(2))))%>',
							'<%=Helper.correctNull((String) arrCol.get(3))%>',
							'<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(4))))%>',
							'<%=Helper.correctNull((String) arrCol.get(5))%>',
							'<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(6))))%>',
							'<%=Helper.correctNull((String) arrCol.get(7))%>',
							'<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(8))))%>',
							'<%=Helper.correctNull((String) arrCol.get(9))%>',
							'<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(10))))%>',
							'<%=Helper.correctNull((String) arrCol.get(11))%>',
							'<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(12))))%>',
							'<%=Helper.correctNull((String) arrCol.get(13))%>',
							'<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(14))))%>',
							'<%=Helper.correctNull((String) arrCol.get(15))%>',
							'<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(16))))%>',
							'<%=Helper.correctNull((String) arrCol.get(17))%>',
							'<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(18))))%>',
							'<%=Helper.correctNull((String) arrCol.get(19))%>',
							'<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(20))))%>',
							'<%=Helper.correctNull((String) arrCol.get(21))%>',
							'<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(22))))%>',
							'<%=Helper.correctNull((String) arrCol.get(23))%>',
							'<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(24))))%>',
							'<%=Helper.correctNull((String) arrCol.get(25))%>',
							'<%=Helper.replaceForJavaScriptString((String) arrCol.get(26))%>',
							'<%=Helper.correctNull((String) arrCol.get(27))%>',
							'<%=Helper.correctNull((String) arrCol.get(28))%>','<%=Helper.correctNull((String) arrCol.get(29))%>',
							'<%=Helper.correctNull((String) arrCol.get(30))%>','<%=Helper.correctNull((String) arrCol.get(31))%>',
							'<%=Helper.correctNull((String) arrCol.get(32))%>','<%=Helper.correctNull((String) arrCol.get(33))%>','<%=Helper.correctNull((String) arrCol.get(34))%>')">
										</td>
										<td width="30%" align="left" >&nbsp;<%=Helper.correctNull((String) arrCol.get(3))%></td>
										<td width="30%" align="right" >&nbsp;<%=Helper.checkDecimal(Helper.correctNull((String) arrCol.get(4)))%></td>
										<td width="35%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(2))))%></td>
									</tr>
									<%
										}
										} else {
									%>
									<tr class="datagrid">
										<td align="center" colspan="6">No Data Found</td>
									</tr>
									<%
										}
									%>
								</table>
								
								<table width="100%" border="0" cellspacing="1" cellpadding="3"
									class="outertable" id="IDEXP2">
									<%
										if (arrRow != null && arrRow.size() > 0) {
											for (int i = 0; i < arrRow.size(); i++) {
												arrCol = (ArrayList) arrRow.get(i);
									%>
									<tr class="datagrid">
										<td width="5%" align="center"><input type="radio"
											style="border: none" name="rdoUser"
											onClick="javascript:selectValues(
							'<%=Helper.correctNull((String) arrCol.get(0))%>',
							'<%=Helper.correctNull((String) arrCol.get(1))%>',
							'<%=Helper.formatDoubleValue(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(2))))%>',
							'<%=Helper.correctNull((String) arrCol.get(3))%>',
							'<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(4))))%>',
							'<%=Helper.correctNull((String) arrCol.get(5))%>',
							'<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(6))))%>',
							'<%=Helper.correctNull((String) arrCol.get(7))%>',
							'<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(8))))%>',
							'<%=Helper.correctNull((String) arrCol.get(9))%>',
							'<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(10))))%>',
							'<%=Helper.correctNull((String) arrCol.get(11))%>',
							'<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(12))))%>',
							'<%=Helper.correctNull((String) arrCol.get(13))%>',
							'<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(14))))%>',
							'<%=Helper.correctNull((String) arrCol.get(15))%>',
							'<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(16))))%>',
							'<%=Helper.correctNull((String) arrCol.get(17))%>',
							'<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(18))))%>',
							'<%=Helper.correctNull((String) arrCol.get(19))%>',
							'<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(20))))%>',
							'<%=Helper.correctNull((String) arrCol.get(21))%>',
							'<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(22))))%>',
							'<%=Helper.correctNull((String) arrCol.get(23))%>',
							'<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(24))))%>',
							'<%=Helper.correctNull((String) arrCol.get(25))%>',
							'<%=Helper.replaceForJavaScriptString((String) arrCol.get(26))%>',
							'<%=Helper.correctNull((String) arrCol.get(27))%>',
							'<%=Helper.correctNull((String) arrCol.get(28))%>','<%=Helper.correctNull((String) arrCol.get(29))%>',
							'<%=Helper.correctNull((String) arrCol.get(30))%>','<%=Helper.correctNull((String) arrCol.get(31))%>',
							'<%=Helper.correctNull((String) arrCol.get(32))%>','<%=Helper.correctNull((String) arrCol.get(33))%>','<%=Helper.correctNull((String) arrCol.get(34))%>')">
										</td>
										<td width="30%" align="left" >&nbsp;<%=Helper.correctNull((String) arrCol.get(7))%></td>
										<td width="30%" align="right" >&nbsp;<%=Helper.checkDecimal(Helper.correctNull((String) arrCol.get(8)))%></td>
										<td width="35%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(2))))%></td>
									</tr>
									<%
										}
										} else {
									%>
									<tr class="datagrid">
										<td align="center" colspan="6">No Data Found</td>
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
<lapschoice:hiddentag pageid="<%=PageId%>" /> <input type="hidden"
	name="hidsno" value=""> <input type="hidden" name="hidAction1"
	value=""> <input type="hidden" name="hiddisclength"
	value="<%=arraySize%>"> <input type="hidden" name="hidAppno"
	value="<%=strappno%>"> <input type="hidden" name="cattype"
	value="<%=strCategoryType%>"> <input type="hidden"
	name="ssitype" value="<%=strSSIType%>"></form>
</body>
</html>
