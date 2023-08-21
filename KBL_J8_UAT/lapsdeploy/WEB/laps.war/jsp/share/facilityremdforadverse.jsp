<%@include file="../share/directives.jsp"%>
<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<%
	
	String strSector = Helper.correctNull((String) request
			.getParameter("hidsector"));
	String strSaral = Helper.correctNull((String) request
			.getParameter("hidsaral"));
	String strApploantype = Helper.correctNull((String) request
			.getParameter("apploantype"));
	String strApplevel = Helper.correctNull((String) request
			.getParameter("applevel"));

	String strValuesin = Helper.correctNull((String) request
			.getParameter("valuesin"));

	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
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
	String strProposal = Helper.correctNull(request
			.getParameter("hidproposal"));
	 //Added by Zahoorunnisa.S for button functionality
    String strapplevel = Helper.correctNull((String)request.getParameter("applevel"));
	String strstatus = Helper.correctNull((String) request.getParameter("hidstatus"));
	if (strstatus.equals(""))
		strstatus = Helper.correctNull((String) hshValues.get("status"));
	
	//End
%>
<%ArrayList vecRow = new ArrayList();
ArrayList vecCol= new ArrayList();

ArrayList vecRow1 = new ArrayList();
ArrayList vecCol1= new ArrayList();
if(hshValues!=null)
{
vecRow = (ArrayList) hshValues.get("vecRow");
}
if(hshValues!=null)
{
vecRow1 = (ArrayList) hshValues.get("vecRow1");
}
String strappno = Helper.correctNull((String) request
		.getParameter("appno"));
%>
<html>
<head>
<title>Facility For Recommendation</title>


<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varOrgLevel="<%=strOrgLevel%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";

var strCOM_PAGETYPE = "<%=Helper.correctNull((String) hshValues.get("COM_PAGETYPE"))%>";
 
var appstatus = "<%=Helper.correctNull((String)request.getParameter("status"))%>";

var currentdate= "<%=Helper.getCurrentDateTime()%>";

function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
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
		if(document.forms[0].elements[i].type=='select-one'  )
		{
			document.forms[0].elements[i].disabled=val;
		}
	}
}

function onloading()
{	  
	disableFields(true);
	document.forms[0].sel_nonfund.disabled = false;
	document.forms[0].sel_nonfund.value = strCOM_PAGETYPE;
	funhidefield();
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons(true,true,false,false,false,true);
	document.forms[0].sel_date1.disabled = true; 
	document.forms[0].sel_date2.disabled = true; 
	document.forms[0].sel_date3.disabled = true; 
	
}

function doSave()
{	
	if(document.forms[0].sel_nonfund.value=="1" || document.forms[0].sel_nonfund.value=="4")
	{
		if(document.forms[0].sel_date1.value=="0")
		{
			alert("Select the Year");
			document.forms[0].sel_date1.focus();	
			return;
		}
		else if(document.forms[0].txt_lcamt.value=="")
		{
			alert("Enter Sanction Amount");
			document.forms[0].txt_lcamt.focus();
			return;
		}
	}
	if(document.forms[0].sel_nonfund.value=="2")
	{
		if(document.forms[0].sel_date2.value=="0")
		{
			alert("Select the Year");
			document.forms[0].sel_date2.focus();	
			return;
		}
		else if(document.forms[0].txt_bclamt.value=="")
		{
			alert("Enter Sanction Amount");
			document.forms[0].txt_bclamt.focus();
			return;
		}
	}
	if(document.forms[0].sel_nonfund.value=="3")
	{
		if(document.forms[0].sel_date3.value=="0")
		{
			alert("Select the Year");
			document.forms[0].sel_date3.focus();	
			return;
		}
		else if(document.forms[0].txt_bglamt.value=="")
		{
			alert("Enter Sanction Amount");
			document.forms[0].txt_bglamt.focus();
			return;
		}
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].sel_date1.disabled = false; 
	document.forms[0].sel_date2.disabled = false; 
	document.forms[0].sel_date3.disabled = false; 
	document.forms[0].sel_nonfund.disabled=false;
	document.forms[0].hidBeanId.value="compro";		
	document.forms[0].hidSourceUrl.value="/action/facilityremdforadverse.jsp";
	document.forms[0].hidBeanMethod.value="updatecom_nonfundloanlcdata";
	document.forms[0].hidBeanGetMethod.value="getcom_nonfundloanlcdata";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doDelete()
{
	document.forms[0].sel_nonfund.disabled=false;
		if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value ="delete";
			document.forms[0].hidBeanMethod.value="updatecom_nonfundloanlcdata";
			document.forms[0].hidBeanGetMethod.value="getcom_nonfundloanlcdata";	
			document.forms[0].hidBeanId.value="compro";
			document.forms[0].hidSourceUrl.value="action/facilityremdforadverse.jsp";	
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();	
		}	
    }

function doNew()
{
	
	if(document.forms[0].sel_nonfund.value=="")
	{
		alert("please select the Type");
		document.forms[0].sel_nonfund.focus();
		return;
	}
	
	disableFields(false);
    document.forms[0].hidAction.value ="insert";
    disableCommandButtons(true,true,false,true,false,true);
   	document.forms[0].sel_nonfund.disabled=true;
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="compro";
		document.forms[0].hidBeanGetMethod.value="getcom_nonfundloanlcdata";
		document.forms[0].action=appURL+"action/facilityremdforadverse.jsp";
		
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


function changetype()
{
	
	vartype =document.forms[0].sel_nonfund.value;
	document.forms[0].hidBeanId.value="compro";
	document.forms[0].hidBeanGetMethod.value="getcom_nonfundloanlcdata";		
	document.forms[0].action=appURL+"action/"+"facilityremdforadverse.jsp?type="+vartype;
	document.forms[0].submit();
	funhidefield();
}

function funhidefield()
{
	if(document.forms[0].sel_nonfund.value=="1" || document.forms[0].sel_nonfund.value=="4")
	{		
		document.all.hidlc.style.visibility="visible";
		document.all.hidlc.style.position="relative";
		document.all.hidlc1.style.visibility="visible";
		document.all.hidlc1.style.position="relative";		
		document.all.hidsbgl.style.visibility="hidden";
		document.all.hidsbgl.style.position="absolute";
		document.all.hidsbgl1.style.visibility="hidden";
		document.all.hidsbgl1.style.position="absolute";

		document.all.hidsbcl.style.visibility="hidden";
		document.all.hidsbcl.style.position="absolute";
		document.all.hidsbcl1.style.visibility="hidden";
		document.all.hidsbcl1.style.position="absolute";

		if(document.forms[0].sel_nonfund.value=="1")
		{
			document.all.import1.style.display="none";
			document.all.import2.style.display="none";
			document.all.im1.style.display="none";
			document.all.inland1.style.display="table-row";
			document.all.inland2.style.display="table-row";
			document.all.in1.style.display="table-cell";
		}
		else if(document.forms[0].sel_nonfund.value=="4")
		{
			document.all.import1.style.display="table-row";
			document.all.import2.style.display="table-row";
			document.all.im1.style.display="table-cell";
			document.all.inland1.style.display="none";
			document.all.inland2.style.display="none";
			document.all.in1.style.display="none";
		}
		
		document.forms[0].hidBeanId.value="compro";
		document.forms[0].hidBeanGetMethod.value="getcom_nonfundloanlcdata";
		
	}
	else if(document.forms[0].sel_nonfund.value=="2")
	{
		document.all.hidsbcl.style.visibility="visible";
		document.all.hidsbcl.style.position="relative";
		document.all.hidsbcl1.style.visibility="visible";
		document.all.hidsbcl1.style.position="relative";
		
		document.all.hidlc.style.visibility="hidden";
		document.all.hidlc.style.position="absolute";
		document.all.hidlc1.style.visibility="hidden";
		document.all.hidlc1.style.position="absolute";
		
		document.all.hidsbgl.style.visibility="hidden";
		document.all.hidsbgl.style.position="absolute";
		document.all.hidsbgl1.style.visibility="hidden";
		document.all.hidsbgl1.style.position="absolute";
		
		document.forms[0].hidBeanId.value="compro";
		document.forms[0].hidBeanGetMethod.value="getcom_nonfundloanlcdata";
		
	}
	else if(document.forms[0].sel_nonfund.value=="3")
	{
		
		
		document.all.hidlc.style.visibility="hidden";
		document.all.hidlc.style.position="absolute";
		document.all.hidlc1.style.visibility="hidden";
		document.all.hidlc1.style.position="absolute";
		
		document.all.hidsbcl.style.visibility="hidden";
		document.all.hidsbcl.style.position="absolute";
		document.all.hidsbcl1.style.visibility="hidden";
		document.all.hidsbcl1.style.position="absolute";
		
		document.all.hidsbgl.style.visibility="visible";
		document.all.hidsbgl.style.position="relative";
		document.all.hidsbgl1.style.visibility="visible";
		document.all.hidsbgl1.style.position="relative";
		
	}
	else
	{
		document.all.hidlc.style.visibility="hidden";
		document.all.hidlc.style.position="absolute";
		document.all.hidlc1.style.visibility="hidden";
		document.all.hidlc1.style.position="absolute";
		
		document.all.hidsbcl.style.visibility="hidden";
		document.all.hidsbcl.style.position="absolute";
		document.all.hidsbcl1.style.visibility="hidden";
		document.all.hidsbcl1.style.position="absolute";
		
		document.all.hidsbgl.style.visibility="hidden";
		document.all.hidsbgl.style.position="absolute";
		document.all.hidsbgl1.style.visibility="hidden";
		document.all.hidsbgl1.style.position="absolute";
	}
	
}
function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16,val17)
{
	if(val2==1 || val2==4)
	{
	
	document.forms[0].hidsno.value=val1;
	document.forms[0].txt_lcamt.value=val3;
	
	document.forms[0].txt_lcdpno.value=val4;
	document.forms[0].txt_lcdpamt.value=val5;
	document.forms[0].txt_lcdano.value=val6;
	document.forms[0].txt_lcdaamt.value=val7;
	document.forms[0].txt_imlcdano.value=val8;
	document.forms[0].txt_imlcdaamt.value=val9;
	document.forms[0].txt_imlcdpno.value=val10;
	document.forms[0].txt_imlcdpamt.value=val11;
	document.forms[0].txt_devano.value=val12;
	document.forms[0].txt_devamt.value=val13;
	document.forms[0].txt_occasionano.value=val14;
	document.forms[0].txt_Commentslc.value=val15;
	document.forms[0].sel_date1.value=val16;
	document.forms[0].txt_CommentsPerformance.value=val17;
	
	}
	else if(val2==2)
	{
		
		document.forms[0].hidsno.value=val1;
		document.forms[0].txt_bclamt.value=val3;  
		document.forms[0].txt_lcbuyersno.value=val4;
		document.forms[0].txt_lcbuyersamt.value=val5;
		document.forms[0].txt_nlcbuyersno.value=val6;
		document.forms[0].txt_nlcbuyersamt.value=val7;
		document.forms[0].txt_dvbuyersno.value=val8;
		document.forms[0].txt_dvbuyersamt.value=val9;
		document.forms[0].txt_sacremarks.value=val15;
		document.forms[0].sel_date2.value=val16;
		document.forms[0].txt_CommentsPerformancebc.value=val17;
	}
	else if(val2==3)
	{
		
		document.forms[0].hidsno.value=val1;
		document.forms[0].txt_bglamt.value=val3;  
		document.forms[0].txt_gurissued.value=val4;
		document.forms[0].txt_aggregateamt.value=val5;
		document.forms[0].txt_guarantessno.value=val6;
		document.forms[0].txt_totaamt.value=val7;
		document.forms[0].txt_remarks.value=val15;
		document.forms[0].sel_date3.value=val16;
		document.forms[0].txt_CommentsPerformancebg.value=val17;
	}
	if(document.forms[0].btnenable.value=="Y")
	{
	enableButtons(true,false,true,false,true,false);	
	}	
	document.forms[0].sel_nonfund.disabled=true;
}


function checkYear(num)
{
	<%
	if (vecRow != null && vecRow.size() > 0) {
		if (vecRow.size() > 0) {
			for (int i = 0; i < vecRow.size(); i++) {
				vecCol = (ArrayList) vecRow.get(i);
			String yearslno= Helper.correctNull((String) vecCol.get(15));
	%>
		var yearslno="<%=yearslno %>";	

		if(num=='1')
			var selYear=document.forms[0].sel_date1.value; 
		else if(num=='2')
			var selYear=document.forms[0].sel_date2.value; 
		else if(num=='3')
			var selYear=document.forms[0].sel_date3.value; 

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


function chkcnt(varpage,val)
{
	var val1="",val2="",val3="";
	if(varpage=="IMIN")
	{
		if(document.forms[0].sel_nonfund.value=="1")
		{
			varpage="INLC";
		}
		else if(document.forms[0].sel_nonfund.value=="4")
		{
			varpage="IMLC";
		}
		
	}
	if(varpage=="INLC")
	{
		if(val=="No")
		{
			val1=document.forms[0].txt_lcdpno.value;
			val2=document.forms[0].txt_lcdano.value;
			if(val1=="")
			{
				val1="0";
			}
			if(val2=="")
			{
				val2="0";
			}

			val3=eval(val1)+eval(val2);
			if(eval(val3)<eval(document.forms[0].txt_devano.value))
			{
				alert("Devolvement no sholud not be more than Inland LC Total");
				document.forms[0].txt_devano.value="";
				document.forms[0].txt_devano.focus();
				return;
			}
		}
		else
		{
			val1=document.forms[0].txt_lcdpamt.value;
			val2=document.forms[0].txt_lcdaamt.value;
			if(val1=="")
			{
				val1="0";
			}
			if(val2=="")
			{
				val2="0";
			}

			val3=eval(val1)+eval(val2);

			if(eval(val3)<eval(document.forms[0].txt_devamt.value))
			{
				alert("Devolvement Amount sholud not be more than Inland LC Total");
				document.forms[0].txt_devamt.value="";
				document.forms[0].txt_devamt.focus();
				return;
			}
		}
	}
	else if(varpage=="IMLC")
	{
		if(val=="No")
		{
			val1=document.forms[0].txt_imlcdano.value;
			val2=document.forms[0].txt_imlcdpno.value;
			if(val1=="")
			{
				val1="0";
			}
			if(val2=="")
			{
				val2="0";
			}

			val3=eval(val1)+eval(val2);

			if(eval(val3)<eval(document.forms[0].txt_devano.value))
			{
				alert("Devolvement no sholud not be more than Import LC Total");
				document.forms[0].txt_devano.value="";
				document.forms[0].txt_devano.focus();
				return;
			}
		}
		else
		{
			val1=document.forms[0].txt_imlcdaamt.value;
			val2=document.forms[0].txt_imlcdpamt.value;
			if(val1=="")
			{
				val1="0";
			}
			if(val2=="")
			{
				val2="0";
			}

			val3=eval(val1)+eval(val2);

			if(eval(val3)<eval(document.forms[0].txt_devamt.value))
			{
				alert("Devolvement Amount sholud not be more than Import LC Total");
				document.forms[0].txt_devamt.value="";
				document.forms[0].txt_devamt.focus();
				return;
			}
		}
	}
	else if(varpage=="BYCR")
	{
		if(val=="No")
		{
			val1=document.forms[0].txt_lcbuyersno.value;
			val2=document.forms[0].txt_nlcbuyersno.value;
			if(val1=="")
			{
				val1="0";
			}
			if(val2=="")
			{
				val2="0";
			}

			val3=eval(val1)+eval(val2);

			if(eval(val3)<eval(document.forms[0].txt_dvbuyersno.value))
			{
				alert("Devolvement no sholud not be more than Buyers Credit Total");
				document.forms[0].txt_dvbuyersno.value="";
				document.forms[0].txt_dvbuyersno.focus();
				return;
			}
		}
		else
		{
			val1=document.forms[0].txt_lcbuyersamt.value;
			val2=document.forms[0].txt_nlcbuyersamt.value;
			if(val1=="")
			{
				val1="0";
			}
			if(val2=="")
			{
				val2="0";
			}

			val3=eval(val1)+eval(val2);

			if(eval(val3)<eval(document.forms[0].txt_dvbuyersamt.value))
			{
				alert("Devolvement Amount sholud not be more than Buyers Credit Total");
				document.forms[0].txt_dvbuyersamt.value="";
				document.forms[0].txt_dvbuyersamt.focus();
				return;
			}
		}
	}
	else if(varpage=="BAGU")
	{
		if(val=="No")
		{
			if(eval(document.forms[0].txt_gurissued.value)<eval(document.forms[0].txt_guarantessno.value))
			{
				alert("No Guarantee invoked should not be greater than Guarantee issued");
				document.forms[0].txt_guarantessno.value="";
				document.forms[0].txt_guarantessno.focus();
				return;
			}
		}
		else
		{
			if(eval(document.forms[0].txt_aggregateamt.value)<eval(document.forms[0].txt_totaamt.value))
			{
				alert("Guarantee invoked amount should not be greater than Aggregate Amount");
				document.forms[0].txt_totaamt.value="";
				document.forms[0].txt_totaamt.focus();
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
<body onload="onloading()">
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
		<jsp:param name="subpageid" value="127" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
		<jsp:param name="ssitype" value="<%=strSSIType%>" />
	</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
	</td>
</tr>
</table>
<%}else{
	if (strApploantype.equalsIgnoreCase("c")||strApploantype.equalsIgnoreCase("a")) {
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
	<td class="page_flow">Home&nbsp;-&gt;&nbsp;Agriculture-&gt;&nbsp;Proposal&nbsp;-&gt;
		&nbsp;Business Turn Over&nbsp;-&gt;&nbsp;Non Funded Loans</td>
	<%}else{ %>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Corporate&nbsp;&amp;&nbsp;SME&nbsp;-&gt;&nbsp;Proposal&nbsp;-&gt;
		&nbsp;Business Turn Over&nbsp;-&gt;&nbsp;Non Funded Loans</td>
		<%} %>	
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%
	}else if (strApploantype.equalsIgnoreCase("P")) {
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
		<td valign="top"><jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="12" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Adhoc
		Limit -&gt; Business Turn Over -&gt; Adverse Features</td>
	</tr>
	<tr>
		<td><span style="display: none"> <lapschoice:borrowertype /></span>
		<lapschoice:application /></td>
	</tr>
</table>
<%
	}}
%>
<table border="0" cellspacing="1" cellpadding="3" width="90%"
	class="outertable">
	<tr>
	
			  <td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getOthersDetails','com_others.jsp')"
			onMouseOut="window.status='';return true;">Business Operation</a> </b></td>
		<td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','facilities','getComments','com_termloancomments.jsp?hidPage=term')"
			onMouseOut="window.status='';return true;">Term Loan</a> </b></td>
		<td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getOdCcLimits','facilityremdforbusiess.jsp')"
			onMouseOut="window.status='';return true;">Conduct of Working Capital Facilities</a> </b></td>
		<td class="sub_tab_active" align="center"><b>
		Non Funded Loans</b></td>
		<td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','compro','getOtherLimits','com_OtherLimits.jsp')"
			onMouseOut="window.status='';return true;">Others</a> </b></td>
			
		<td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','compro','getFinancialComments','com_otherfaccomments.jsp?hidPage=otherfac')"
			onMouseOut="window.status='';return true;">Overall Comments</a> </b></td>
			
		<td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','facilities','getComments','comments_transaction.jsp?hidPage1=commentsTrans')"
			onMouseOut="window.status='';return true;">Comments on Transaction in the existing accounts</a> </b></td>
	</tr>
</table>
<br>
		<table width="70%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center">
			<tr>
				<td>
				<table width="100%" border="1" cellspacing="0" cellpadding="3" class="outertable" align="center">
				
						<tr>
						<td> Type</td>
						    <td> <select  name="sel_nonfund" onchange="changetype()">
						         <option value="">--select--</option>
						          <option value="1" selected="selected">Inland LC Limit</option>
						          <option value="4">Import LC Limit</option>
						          <option value="2">Buyers credit limit</option>
						          <option value="3">Bank Guarantee Limit</option>				          
						         </select>
						   	</td>
					   </tr>
					   </table>
			   </td>
		    </tr>
		</table>
		
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center" >
			<tr>
				<td>
				<table width="70%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center" id="hidlc">
				<tr>
				<td>
				<table width="100%" border="1" cellspacing="1" cellpadding="3" class="outertable" align="center">
				<tr><td colspan="3">
					<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable" align="center">
						<tr>
						<td>Select the year<span class="mantatory">*</span>
						<select name="sel_date1"  onchange="checkYear('1')">
     					<option value="0">--select--</option>
     					<laps:AgrFinancialYear appno="<%=strappno%>" page="" />
     					</select></td></tr>
					</table>
				</td></tr>
						<tr class="dataheader" ><td id="in1"> Sanctioned Inland LC Limit Amount</td>   <td id="im1"> Sanctioned Import LC Limit Amount</td>
						<td colspan="2"><input type="text" name="txt_lcamt" size="18" maxlength="15" onkeypress="allowDecimals(this)" onblur="roundtxt(this)" style="text-align: right;"> </td>  
						</tr>
						<tr class="dataheader" >
							<td width="20%" >  &nbsp;</td>
							<td width="10%">No</td>
							<td width="10%"> Amount</td>
						</tr>
						<tr id="inland1">
						    <td>Inland LC (DP) </td>
						    <td><input type="text" name="txt_lcdpno" size="10" maxlength="10" onkeypress="allowInteger()" style="text-align: right;" onblur="chkcnt('INLC','No')"> </td>
						    <td><input type="text" name="txt_lcdpamt" size="15" maxlength="15" onkeypress="allowDecimals(this)" onblur="roundtxt(this);chkcnt('INLC','Amt')" style="text-align: right;"> </td>
						   
					   </tr>
					   
					   <tr id="inland2">
						    <td>Inland LC (DA) </td>
						    <td><input type="text" name="txt_lcdano" size="10" maxlength="10" onkeypress="allowInteger()" style="text-align: right;" onblur="chkcnt('INLC','No')"> </td>
						    <td><input type="text" name="txt_lcdaamt" size="15" maxlength="15" onkeypress="allowDecimals(this)" onblur="roundtxt(this);chkcnt('INLC','Amt')" style="text-align: right;"> </td>
						   
					   </tr>
					   
					    <tr id="import1">
						    <td>Import LC (DA) </td>
						    <td><input type="text" name="txt_imlcdano" size="10" maxlength="10" onkeypress="allowInteger()" style="text-align: right;" onblur="chkcnt('INLC','No')"> </td>
						    <td><input type="text" name="txt_imlcdaamt" size="15" maxlength="15" onkeypress="allowDecimals(this)" onblur="roundtxt(this);chkcnt('IMLC','Amt')"style="text-align: right;"> </td>
						   
					   </tr>
					   
					    <tr id="import2">
						    <td>Import LC (DP) </td>
						    <td><input type="text" name="txt_imlcdpno" size="10" maxlength="10" onkeypress="allowInteger()" style="text-align: right;" onblur="chkcnt('INLC','No')"> </td>
						    <td><input type="text" name="txt_imlcdpamt" size="15" maxlength="15" onkeypress="allowDecimals(this)" onblur="roundtxt(this);chkcnt('IMLC','Amt')"style="text-align: right;"> </td>
						   
					   </tr>
					   <tr>
					        <td>Devolvement if any</td>
					  	    <td><input type="text" name="txt_devano" size="10" maxlength="10" onkeypress="allowInteger()" style="text-align: right;" onblur="chkcnt('IMIN','No')"> </td>
						    <td><input type="text" name="txt_devamt" size="15" maxlength="15" onkeypress="allowDecimals(this)" onblur="roundtxt(this);chkcnt('IMIN','Amt')"style="text-align: right;"> </td>
					   </tr>
					    <tr>
					        <td>No. of occasion excesses permitted</td>
					  	    <td ><input type="text" name="txt_occasionano" size="10" maxlength="10" onkeypress="allowInteger()" style="text-align: right;"> </td>
					  	    <td></td>
					   </tr>
					    <tr>
					        <td >Comments about the retirement of bills received under LC</td>
					    
					  	   <td colspan="2"><textarea NAME="txt_Commentslc" COLS="40" ROWS="4" onKeyPress="notAllowSplChar();notAllowSplChar1(this); textlimit(this,3999)"  onkeyup="notAllowSplChar();notAllowSplChar1(this);textlimit(this,3999)" onkeydown="notAllowSplChar();notAllowSplChar1(this)"></textarea></td>
					   </tr>
					   <tr>
					        <td>Comments on performance</td>
					    
					  	   <td colspan="2"><textarea NAME="txt_CommentsPerformance" COLS="40" ROWS="4" onKeyPress="notAllowSplChar();notAllowSplChar1(this); textlimit(this,3999)"  onkeyup="notAllowSplChar();notAllowSplChar1(this);textlimit(this,3999)" onkeydown="notAllowSplChar();notAllowSplChar1(this)"></textarea></td>
					   </tr>
					   </table>
					   </td>
					   </tr>
					   </table>
			  
		
		
		
				<table width="70%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center" id="hidsbgl">
				 <tr>
				<td>
				<table width="100%" border="1" cellspacing="1" cellpadding="3" class="outertable" align="center">
				
				<tr><td colspan="2">
					<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable" align="center">
						<tr>
						<td>Select the year<span class="mantatory">*</span>
						<select name="sel_date3" onchange="checkYear('3')">
     					<option value="0">--select--</option>
     					<laps:AgrFinancialYear appno="<%=strappno%>" page="" />
     					</select></td></tr>
					</table>
				</td></tr>
				
				  <tr class="dataheader">
				  <td colspan="">Sanctioned Bank Guarantee Limit</td>
				  <td colspan=""><input type="text" name="txt_bglamt" size="18" maxlength="15" onkeypress="allowDecimals(this)" onblur="roundtxt(this)" style="text-align: right;"> </td> 
				  </tr>
				  <tr>
				  <td>No. of guarantees issued</td>
				  <td><input type="text" name="txt_gurissued" size="10" maxlength="15" onkeypress="allowInteger()" style="text-align: right;"  onblur="chkcnt('BAGU','No')"> </td>
	              </tr>
	              <tr>
				  <td>Aggregate amount</td>
				  <td><input type="text" name="txt_aggregateamt" size="10" maxlength="15" onkeypress="allowDecimals(this)" onblur="roundtxt(this);chkcnt('BAGU','Amt');" style="text-align: right;"> </td>
	              </tr>
	               <tr>
				  <td>No. of Guarantees invoked</td>
				  <td><input type="text" name="txt_guarantessno" size="10" maxlength="15" onkeypress="allowInteger()"  style="text-align: right;"  onblur="chkcnt('BAGU','No')"> </td>
	              </tr>
	              
	              <tr>
				  <td>Total Amount of Guarantees invoked</td>
				  <td><input type="text" name="txt_totaamt" size="10" maxlength="15" onkeypress="allowDecimals(this)" onblur="roundtxt(this);chkcnt('BAGU','Amt');" style="text-align: right;"> </td>
	              </tr>
	               <tr>
					        <td >Remarks on Guarantees Invoked. Reasons,<br> present status of such guarantees</td>
					    
					  	   <td colspan="2"><textarea NAME="txt_remarks"COLS="40" ROWS="4"  onKeyPress="notAllowSplChar();notAllowSplChar1(this); textlimit(this,3999)"   onkeyup="notAllowSplChar();notAllowSplChar1(this);textlimit(this,3999)" onkeydown="notAllowSplChar();notAllowSplChar1(this)"></textarea></td>
					   </tr>
		
		 		 <tr>
					        <td>Comments on performance</td>
					    
					  	   <td colspan="2"><textarea NAME="txt_CommentsPerformancebg" COLS="40" ROWS="4" onKeyPress="notAllowSplChar();notAllowSplChar1(this); textlimit(this,3999)"  onkeyup="notAllowSplChar();notAllowSplChar1(this);textlimit(this,3999)" onkeydown="notAllowSplChar();notAllowSplChar1(this)"></textarea></td>
					   </tr>
					   
		    </table>
		    </td>
		    </tr>
		    </table>
		
	
				<table width="70%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center" id="hidsbcl">
				  <tr>
				<td>
				<table width="100%" border="1" cellspacing="1" cellpadding="3" class="outertable" align="center">
				
				<tr><td colspan="3">
					<table width="100%" border="1" cellspacing="1" cellpadding="2" class="outertable" align="center">
						<tr>
									<td>Select the year<span class="mantatory">*</span>
									<select name="sel_date2" onchange="checkYear('2')">
     									<option value="0">--select--</option>
      									<laps:AgrFinancialYear appno="<%=strappno%>" page="" />
     									 </select></td></tr>
					</table>
				</td></tr>
				
				  <tr class="dataheader">
				  
				     <td colspan="">Sanctioned Buyers credit limit</td>
				      <td colspan="2"><input type="text" name="txt_bclamt" size="18" maxlength="15" onkeypress="allowDecimals(this)" onblur="roundtxt(this)" style="text-align: right;"> </td>
				  </tr>
				  <tr class="dataheader" >
					  <td>&nbsp;</td>
					  <td>No</td>
					  <td>Amount</td>
				  </tr>
		            <tr>
						    <td>Buyers credit for LC bills </td>
						    <td><input type="text" name="txt_lcbuyersno" size="10" maxlength="10" onkeypress="allowInteger()" style="text-align: right;" onblur="chkcnt('BYCR','No')"> </td>
						    <td><input type="text" name="txt_lcbuyersamt" size="15" maxlength="15" onkeypress="allowDecimals(this)" onblur="roundtxt(this);chkcnt('BYCR','Amt')"style="text-align: right;"> </td>
						   
					   </tr>
					   <tr>
						    <td>Buyers credit for Non LC bills</td>
						    <td><input type="text" name="txt_nlcbuyersno" size="10" maxlength="10" onkeypress="allowInteger()" style="text-align: right;" onblur="chkcnt('BYCR','No')"> </td>
						    <td><input type="text" name="txt_nlcbuyersamt" size="15" maxlength="15" onkeypress="allowDecimals(this)" onblur="roundtxt(this);chkcnt('BYCR','Amt')"style="text-align: right;"> </td>
						   
					   </tr>
					   <tr>
						    <td>Devolvement</td>
						    <td><input type="text" name="txt_dvbuyersno" size="10" maxlength="10" onkeypress="allowInteger()" style="text-align: right;" onblur="chkcnt('BYCR','No')"> </td>
						    <td><input type="text" name="txt_dvbuyersamt" size="15" maxlength="15" onkeypress="allowDecimals(this)" onblur="roundtxt(this);chkcnt('BYCR','Amt')" style="text-align: right;"> </td>
						   
					   </tr>
		
		               <tr>
					        <td >Remarks </td>
					    
					  	   <td colspan="2"><textarea NAME="txt_sacremarks"COLS="40" ROWS="4"  onKeyPress="notAllowSplChar();notAllowSplChar1(this); textlimit(this,3999)"   onkeyup="notAllowSplChar();notAllowSplChar1(this);textlimit(this,3999)" onkeydown="notAllowSplChar();notAllowSplChar1(this)"></textarea></td>
					   </tr>
					     <tr>
					        <td>Comments on performance</td>
					    
					  	   <td colspan="2"><textarea NAME="txt_CommentsPerformancebc" COLS="40" ROWS="4" onKeyPress="notAllowSplChar();notAllowSplChar1(this); textlimit(this,3999)"  onkeyup="notAllowSplChar();notAllowSplChar1(this);textlimit(this,3999)" onkeydown="notAllowSplChar();notAllowSplChar1(this)"></textarea></td>
					   </tr>
		</table>
	</td>
	</tr>
	</table>
	
	 </td>
		    </tr>
		 	
		</table>
		<br>
		<table width="70%" border="0" cellspacing="1" cellpadding="3" class="outertable"align="center" >
				  <tr >
				  <td>
		<lapschoice:combuttonnew
						btnnames='New_Edit_Save_Cancel_Delete_Audit Trail'
						btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
				
		</td>
			</tr>
			</table>
			<br>
			<table width="70%" border="0" cellspacing="1" cellpadding="3" class="outertable"align="center" id="hidlc1" >
				<tr class="dataheader"  align="center" >
				     <td width="5%">&nbsp;</td>
				     <td width="5%">S.No</td>
				     <td width="45%">Descriptions</td>
				     <td width="15%" nowrap="nowrap"> Sanctioned  Amount</td>
				  </tr>
				 </table>
				 <table width="70%" border="0" cellspacing="1" cellpadding="3" class="outertable"align="center" id="hidsbgl1">
				<tr class="dataheader" align="center">
				     <td width="5%">&nbsp;</td>
				     <td width="5%">S.No</td>
				     <td width="45%">Descriptions</td>
				     <td width="15%" nowrap="nowrap"> Bank Guarantee Limit Amount</td>
				     </tr>
				     </table>
				      <table width="70%" border="0" cellspacing="1" cellpadding="3" class="outertable"align="center" id="hidsbcl1">
				<tr class="dataheader" align="center" >
				     <td width="5%">&nbsp;</td>
				     <td width="5%">S.No</td>
				     <td width="45%">Descriptions</td>
				     <td width="15%" nowrap="nowrap"> Buyers credit limit Amount</td>
				  </tr>
				  </table>
				  
				     <table width="70%" border="0" cellspacing="1" cellpadding="3" class="outertable"align="center" >
				<tr class="dataheader" >
				 
				  <%
				 String pgtype=null;
				 String pagename=Helper.correctNull((String) hshValues.get("COM_PAGETYPE"));
				  
				
										if (vecRow != null && vecRow.size() > 0) {
											
												for (int i = 0; i < vecRow.size(); i++) {
													vecCol = (ArrayList) vecRow.get(i);
					%>
					<tr class="datagrid">
					
										<td width="5%" align="center"><input type="radio"
											style="border: none" name="rdoUser"
											onClick="javascript:selectValues(
											'<%=Helper.correctNull((String) vecCol.get(0))%>',
											'<%=Helper.correctNull((String) vecCol.get(1))%>',
											'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) vecCol.get(2))))%>',
											'<%=Helper.correctNull((String) vecCol.get(3))%>',
											'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) vecCol.get(4))))%>',
											'<%=Helper.correctNull((String) vecCol.get(5))%>',
											'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) vecCol.get(6))))%>',
											'<%=Helper.correctNull((String) vecCol.get(7))%>',
											'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) vecCol.get(8))))%>',
											'<%=Helper.correctNull((String) vecCol.get(9))%>',
											'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) vecCol.get(10))))%>',
											'<%=Helper.correctNull((String) vecCol.get(11))%>',
											'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) vecCol.get(12))))%>',
											'<%=Helper.replaceForJavaScriptString((String) vecCol.get(13))%>',
											'<%=Helper.correctNull((String) vecCol.get(14))%>',
											'<%=Helper.correctNull((String) vecCol.get(15))%>',
											'<%=Helper.correctNull((String) vecCol.get(16))%>')"></td>
					<td width="5%"><%=i+1 %></td>
					<%if(pagename.equalsIgnoreCase("1"))
					{
					pgtype="Inland LC Limit";
					
					}
					else if(pagename.equalsIgnoreCase("2"))
					{
						pgtype="Buyers credit limit";
					}
					else if(pagename.equalsIgnoreCase("3"))
					{
						pgtype="Bank Guarantee Limit";
					}
					else if(pagename.equalsIgnoreCase("4"))
					{
						pgtype="Import LC Limit";
					}
					else
					{
						pgtype="";
					}
					 %>
					<td width="45%"><%=pgtype%></td>
					<td width="15%"align="right"><%=Helper.checkDecimal((String) vecCol.get(2))%></td>
					</tr>
				  <%}
												}else{
												
												%>
												<tr class="datagrid">
												<td colspan="4" align="center">No Data Found</td>
												</tr>
				     <%} %>
				  </table>
				  
			
				  
				
						
<lapschoice:hiddentag pageid="<%=PageId%>" /> 
	<input type="hidden"name="cattype" value="<%=strCategoryType%>"> 
	<input type="hidden" name="ssitype" value="<%=strSSIType%>"> 
	<input type="hidden" name="hidsno" value=""> 
	<input type="hidden"name="busOperation_text" value="">
</form>
</body>
</html>

		   
					