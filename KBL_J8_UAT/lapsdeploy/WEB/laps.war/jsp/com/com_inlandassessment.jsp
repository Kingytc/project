<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	String strAppno = "", strFacCategory = "";
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	String appstatus = "",strAppstatus="",applevel="";
	
	if (hshValues.get("hshAppData") != null) 
	{
		HashMap hshRecord = (HashMap) hshValues.get("hshAppData");
		strAppno = Helper.correctNull((String) hshRecord.get("appno"));
		appstatus = Helper.correctNull((String) hshRecord.get("app_status"));
		strAppstatus = Helper.correctNull((String) hshRecord.get("app_status"));
		applevel = Helper.correctNull((String) hshRecord.get("applevel"));
	}
	
	if (appstatus.equalsIgnoreCase("")) 
	{
		appstatus = Helper.correctNull((String) request.getParameter("appstatus"));
	}
	if (strAppstatus.equalsIgnoreCase("op")
			|| strAppno.equalsIgnoreCase("new")) {
		appstatus = "Open/Pending";
	} else if (strAppstatus.equalsIgnoreCase("pa")) {
		appstatus = "Processed/Approved";
	} else if (strAppstatus.equalsIgnoreCase("pr")) {
		appstatus = "Processed/Rejected";
	} else if (strAppstatus.equalsIgnoreCase("ca")) {
		appstatus = "Closed/Approved";
	} else if (strAppstatus.equalsIgnoreCase("cr")) {
		appstatus = "Closed/Rejected";
	}
	String StrSchemeType=request.getParameter("strschemeType");
%>
<%
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=new ArrayList();
	ArrayList arrRowyr=new ArrayList();
	ArrayList arrColyr=new ArrayList();
	ArrayList arrColyr1 = new ArrayList();
	ArrayList arrColyr2 = new ArrayList();
	ArrayList arrColyr3 = new ArrayList();
	ArrayList arrColyr4 = new ArrayList();
	if(hshValues!=null)
	{
		arrRow = (ArrayList)hshValues.get("arrRow");
		arrRowyr = (ArrayList)hshValues.get("arrRowyr");
	}
	
	ArrayList arrCol1 = new ArrayList();
	ArrayList arrCol2 = new ArrayList();
	ArrayList arrCol3 = new ArrayList();
	ArrayList arrCol4 = new ArrayList();
	
	int count = arrRowyr.size();
	//out.println(hshValues);
%>
<%
	if (arrRow != null && arrRow.size() > 0) 
	{
		arrCol = (ArrayList) arrRow.get(0);
		arrCol1 = (ArrayList) arrRow.get(1);
		arrCol2 = (ArrayList) arrRow.get(2);
		arrCol3 = (ArrayList) arrRow.get(3);
		arrCol4 = (ArrayList) arrRow.get(4);
	}

//out.println(request.getParameter("strAssessment"));
%> 
<html>
<head>
<title>Inland Assessment</title>

<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varOrgLevel="<%=strOrgLevel%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var appno="<%=request.getParameter("appno")%>";
function doCancel()
{
	if (ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="comproposal";		
		document.forms[0].hidBeanGetMethod.value="getInlandAssessment";
		document.forms[0].action=appURL+"action/com_inlandassessment.jsp";
		document.forms[0].submit();
	}
}

function doEdit()
{	
	disablefields(false);
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value ="update"
	enableButtons(true,false,false,false,false,false);

	for(var i=0;i<document.forms[0].txt_sales.length;i++)
	{
		document.forms[0].txt_avgmonPurchases[i].disabled = true;
		document.forms[0].txt_LCrequirement[i].disabled = true;
	}
	
}

function doSave()
{
	for(var i=0;i<document.forms[0].txt_sales.length;i++)
	{
		document.forms[0].txt_avgmonPurchases[i].disabled = false;
		document.forms[0].txt_LCrequirement[i].disabled = false;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updInlandAssessment";
	document.forms[0].hidBeanGetMethod.value="getInlandAssessment";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_inlandassessment.jsp";
	document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanMethod.value="updInlandAssessment";
		document.forms[0].hidBeanGetMethod.value="getInlandAssessment";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_inlandassessment.jsp";
		document.forms[0].submit();
	 }	
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/corppge.jsp";
		document.forms[0].submit();
	}
}

function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdcomments.disabled=bool6;
}
function placevalues()
{
	disablefields(true);
	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
		enableButtons(false,true,true,false,true,false);
		}
		else
		{
			enableButtons(true,true,true,false,true,false);
		}
		
	}
	else
	{
		enableButtons(true,true,true,false,true,false);
	}
	for(var i=0;i<document.forms[0].txt_sales.length;i++)
	{
		document.forms[0].txt_avgmonPurchases[i].disabled = true;
		document.forms[0].txt_LCrequirement[i].disabled = true;
	}
}

function callCalender(fname)
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}

function disablefields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=val;
		}	  
		else if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		else if(document.forms[0].elements[i].type=='select-multiple')
		{
			document.forms[0].elements[i].disabled=val;
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}		
	}
	
}
function calculation()
{
	for(var i=0;i<document.forms[0].txt_sales.length;i++)
	{
		var projPurchases1 = parseFloat(document.forms[0].txt_projPurchases[0].value);
		var projPurchases2 = parseFloat(document.forms[0].txt_projPurchases[1].value);
		var projPurchases3 = parseFloat(document.forms[0].txt_projPurchases[2].value);
		var projPurchases4 = parseFloat(document.forms[0].txt_projPurchases[3].value);
		var projPurchases5 = parseFloat(document.forms[0].txt_projPurchases[4].value);
	
		var avgPurchases1 =NanNumber(projPurchases1/12); 
		var avgPurchases2 =NanNumber(projPurchases2/12); 
		var avgPurchases3 =NanNumber(projPurchases3/12); 
		var avgPurchases4 =NanNumber(projPurchases4/12); 
		var avgPurchases5 =NanNumber(projPurchases5/12); 

		document.forms[0].txt_avgmonPurchases[0].value =roundVal(avgPurchases1);
		document.forms[0].txt_avgmonPurchases[1].value =roundVal(avgPurchases2);
		document.forms[0].txt_avgmonPurchases[2].value =roundVal(avgPurchases3); 
		document.forms[0].txt_avgmonPurchases[3].value =roundVal(avgPurchases4);
		document.forms[0].txt_avgmonPurchases[4].value =roundVal(avgPurchases5);

		var crdPeriod1 = parseFloat(document.forms[0].txt_creditPeriod[0].value);
		var crdPeriod2 = parseFloat(document.forms[0].txt_creditPeriod[1].value);
		var crdPeriod3 = parseFloat(document.forms[0].txt_creditPeriod[2].value);
		var crdPeriod4 = parseFloat(document.forms[0].txt_creditPeriod[3].value);
		var crdPeriod5 = parseFloat(document.forms[0].txt_creditPeriod[4].value);

		var transitPeriod1 = parseFloat(document.forms[0].txt_transitPeriod[0].value);
		var transitPeriod2 = parseFloat(document.forms[0].txt_transitPeriod[1].value);
		var transitPeriod3 = parseFloat(document.forms[0].txt_transitPeriod[2].value);
		var transitPeriod4 = parseFloat(document.forms[0].txt_transitPeriod[3].value);
		var transitPeriod5 = parseFloat(document.forms[0].txt_transitPeriod[4].value);
		
		var lcReq1 =NanNumber(avgPurchases1*(crdPeriod1+transitPeriod1)); 
		var lcReq2 =NanNumber(avgPurchases2*(crdPeriod2+transitPeriod2)); 
		var lcReq3 =NanNumber(avgPurchases3*(crdPeriod3+transitPeriod3)); 
		var lcReq4 =NanNumber(avgPurchases4*(crdPeriod4+transitPeriod4)); 
		var lcReq5 =NanNumber(avgPurchases5*(crdPeriod5+transitPeriod5)); 

		document.forms[0].txt_LCrequirement[0].value =roundVal(lcReq1); 
		document.forms[0].txt_LCrequirement[1].value =roundVal(lcReq2); 
		document.forms[0].txt_LCrequirement[2].value =roundVal(lcReq3);  
		document.forms[0].txt_LCrequirement[3].value =roundVal(lcReq4);  
		document.forms[0].txt_LCrequirement[4].value =roundVal(lcReq5);  

	}
}
function doComments()
{
	var btnenable=document.forms[0].btnenable.value;
	var strAppno =appno;
	var pagetype = document.forms[0].hidCommentPage.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/com_comments.jsp?hidBeanId=comproposal&hidBeanGetMethod=getDataComments&pagetype="+pagetype+"&strAppno="+strAppno+"&appstatus="+appstatus+"&btnenable="+btnenable;
	window.open(url,"Comments",prop);
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="calculation();placevalues();">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">
if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>
<form method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
  <tr> 
	<td valign="top" colSpan=5>
           	<jsp:include page="../com/proposallinks.jsp" flush="true"> 
			<jsp:param name="pageid" value="41" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />			
			</jsp:include>
   </td>
 </tr>
 <tr>
 	<td class="page_flow">
 		Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Financial Analysis -&gt; Assessment -&gt; Turn Over Method
<span style="display:none"><lapschoice:borrowertype /></span> 
<lapschoice:application/>
	</td>
</tr>
</table>
  	<jsp:include page="../com/com_commentstab.jsp" flush="true">
		<jsp:param name="tabid" value="32" />
	</jsp:include>	      
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td valign="top" colspan="3">
								<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable linebor">
									<tr class="dataheader"><td align="right" colspan="7"><b>All Values are in <%=Helper.correctNull((String)hshValues.get("strValuesin")) %></b></td></tr>
									<tr class="dataheader">
										<td width="3%">&nbsp;</td>
										<td width="22%">Accepted for the year ending</td>
										<%
											if (arrRowyr != null && arrRowyr.size() > 0 && count>0) 
											{
												arrColyr = (ArrayList) arrRowyr.get(0);
										%> 
										<td width="15%" align="center"><input type="text"  name="txt_year1" size="12" onKeyPress="allowNumber(this)" onBlur="checkDate(this);" maxlength="12" value="<%=Helper.correctNull((String)arrColyr.get(0))%>">
											<a alt="Select date from calender" href="#" onClick="callCalender('txt_year1')" onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
											alt="Select date from calender" tabindex="29"></a>
										</td>
										 <%}else {%>
										 <td width="15%" align="center"><input type="text" name="txt_year1" size="12" onBlur="checkDate(this);" maxlength="12" tabindex="15">
						    				<a alt="Select date from calender" href="#" onClick="callCalender('txt_year1')" onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
											alt="Select date from calender" tabindex="29"></a>
										</td>
										 <%}%>
										 <%
											if (arrRowyr != null && arrRowyr.size() > 0 && count>1) 
											{
												arrColyr1 = (ArrayList) arrRowyr.get(1);
										%> 
										<td width="15%" align="center"><input type="text" name="txt_year2" size="12" onKeyPress="allowNumber(this)" onBlur="checkDate(this);" maxlength="12" value="<%=Helper.correctNull((String)arrColyr1.get(0))%>">
											<a alt="Select date from calender" href="#" onClick="callCalender('txt_year2')" onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
											alt="Select date from calender" tabindex="29"></a>
										</td>
										<%}else {%>
										 <td width="15%" align="center"><input type="text" name="txt_year2" size="12" onBlur="checkDate(this);" maxlength="12" tabindex="15">
						    				<a alt="Select date from calender" href="#" onClick="callCalender('txt_year2')" onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
											alt="Select date from calender" tabindex="29"></a>
										</td>
										 <%}%>
										 <%
											if (arrRowyr != null && arrRowyr.size() > 0 && count>2) 
											{
												arrColyr2 = (ArrayList) arrRowyr.get(2);
										%> 
										<td width="15%" align="center"><input type="text" name="txt_year3" size="12" onKeyPress="allowNumber(this)" onBlur="checkDate(this);" maxlength="12" value="<%=Helper.correctNull((String)arrColyr2.get(0))%>">
											<a alt="Select date from calender" href="#" onClick="callCalender('txt_year3')" onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
											alt="Select date from calender" tabindex="29"></a>
										</td>
										<%}else {%>
										 <td width="15%" align="center"><input type="text" name="txt_year3" size="12" onBlur="checkDate(this);" maxlength="12" tabindex="15">
						    				<a alt="Select date from calender" href="#" onClick="callCalender('txt_year3')" onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
											alt="Select date from calender" tabindex="29"></a>
										</td>
										 <%}%>
										 <%
											if (arrRowyr != null && arrRowyr.size() > 0 && count>3) 
											{
												arrColyr3 = (ArrayList) arrRowyr.get(3);
										%> 
										<td width="15%" align="center"><input type="text" name="txt_year4" size="12" onKeyPress="allowNumber(this)" onBlur="checkDate(this);" maxlength="12" value="<%=Helper.correctNull((String)arrColyr3.get(0))%>">
											<a alt="Select date from calender" href="#" onClick="callCalender('txt_year4')" onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
											alt="Select date from calender" tabindex="29"></a>
										</td>
										<%}else {%>
										 <td width="15%" align="center"><input type="text" name="txt_year4" size="12" onBlur="checkDate(this);" maxlength="12" tabindex="15">
						    				<a alt="Select date from calender" href="#" onClick="callCalender('txt_year4')" onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
											alt="Select date from calender" tabindex="29"></a>
										</td>
										 <%}%>
										 <%
											if (arrRowyr != null && arrRowyr.size() > 0 && count>4) 
											{
												arrColyr4 = (ArrayList) arrRowyr.get(4);
										%> 
										<td width="15%" align="center"><input type="text" name="txt_year5" size="12" onKeyPress="allowNumber(this)" onBlur="checkDate(this);" maxlength="12" value="<%=Helper.correctNull((String)arrColyr4.get(0))%>">
											<a alt="Select date from calender" href="#" onClick="callCalender('txt_year5')" onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
											alt="Select date from calender" tabindex="29"></a>
										</td>
										<%}else {%>
										<td width="15%" align="center"><input type="text" name="txt_year5" size="12" onBlur="checkDate(this);" maxlength="12" tabindex="15">
						    				<a alt="Select date from calender" href="#" onClick="callCalender('txt_year5')" onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
											alt="Select date from calender" tabindex="29"></a>
										</td>
										 <%}%>
									</tr>
									
									<tr class="datagrid">
										<td width="3%" align="center">1.</td>
										<td width="25%">Sales </td>
										<%
										if (arrRow != null && arrRow.size() > 0) 
										{
										%>
										<td width="15%" align="center"><input type="text" name="txt_sales" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(0)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_sales" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(0)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_sales" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(0)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_sales" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(0)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_sales" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(0)))%>"></td>
										<%} else {%>
											<td width="15%" align="center"><input  type="text" size="12" name="txt_sales" style="text-align:right;" onkeypress="allowNumber(this)" onblur="roundtxt(this);" tabindex="" value="0.00"/></td>
								        	<td width="15%" align="center"><input  type="text" size="12" name="txt_sales" style="text-align:right;" onkeypress="allowNumber(this)" onblur="roundtxt(this);" tabindex="" value="0.00"/></td>
								        	<td width="15%" align="center"><input  type="text" size="12" name="txt_sales" style="text-align:right;" onkeypress="allowNumber(this)" onblur="roundtxt(this);" tabindex="" value="0.00"/></td> 
								        	<td width="15%" align="center"><input  type="text" size="12" name="txt_sales" style="text-align:right;" onkeypress="allowNumber(this)" onblur="roundtxt(this);" tabindex="" value="0.00"/></td>
								        	<td width="15%" align="center"><input  type="text" size="12" name="txt_sales" style="text-align:right;" onkeypress="allowNumber(this)" onblur="roundtxt(this);" tabindex="" value="0.00"/></td>      
										<%}%>	
									</tr>
									<tr class="datagrid">
										<td width="3%" align="center">2.</td>
										<td width="25%">Purchases</td>
										<%
										if (arrRow != null && arrRow.size() > 0) 
										{
											
										%>
										<td width="15%" align="center"><input type="text" name="txt_purchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(1)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_purchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(1)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_purchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(1)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_purchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(1)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_purchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(1)))%>"></td>
										<%} else {%>
										<td width="15%" align="center"><input type="text" name="txt_purchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_purchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_purchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_purchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_purchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="roundtxt(this);" value="0.00"></td>
										<%}%>
									</tr>
									<tr class="datagrid">
										<td width="3%" align="center">3.</td>
										<td width="25%">Projected purchases under LC</td>
										<%
										if (arrRow != null && arrRow.size() > 0) 
										{
											
										%>
										<td width="15%" align="center"><input type="text" name="txt_projPurchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(2)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_projPurchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(2)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_projPurchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(2)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_projPurchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(2)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_projPurchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(2)))%>"></td>
										<%} else {%>
										<td width="15%" align="center"><input type="text" name="txt_projPurchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_projPurchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_projPurchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_projPurchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_projPurchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
										
									</tr>
									<tr class="datagrid">
										<td width="3%" align="center">4.</td>
										<td width="25%">Avg. monthly purchases under LC</td>
										<%
										if (arrRow != null && arrRow.size() > 0) 
										{
											
										%>
										<td width="15%" align="center"><input type="text" name="txt_avgmonPurchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(3)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_avgmonPurchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(3)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_avgmonPurchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(3)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_avgmonPurchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(3)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_avgmonPurchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(3)))%>"></td>
										<%} else {%>
										<td width="15%" align="center"><input type="text" name="txt_avgmonPurchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_avgmonPurchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_avgmonPurchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_avgmonPurchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_avgmonPurchases" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
									</tr>
									<tr class="datagrid">
										<td width="3%" align="center">5.</td>
										<td width="25%">Normal credit period (in months)</td>
										<%
										if (arrRow != null && arrRow.size() > 0) 
										{
											
										%>
										<td width="15%" align="center"><input type="text" name="txt_creditPeriod" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(4)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_creditPeriod" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(4)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_creditPeriod" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(4)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_creditPeriod" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(4)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_creditPeriod" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(4)))%>"></td>
										<%} else {%>
										<td width="15%" align="center"><input type="text" name="txt_creditPeriod" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_creditPeriod" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_creditPeriod" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_creditPeriod" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_creditPeriod" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
									</tr>
									<tr class="datagrid">
										<td width="3%" align="center">6.</td>
										<td width="25%">Transit Period (in months)</td>
										<%
										if (arrRow != null && arrRow.size() > 0) 
										{
											
										%>
										<td width="15%" align="center"><input type="text" name="txt_transitPeriod" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(5)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_transitPeriod" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(5)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_transitPeriod" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(5)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_transitPeriod" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(5)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_transitPeriod" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(5)))%>"></td>
										<%} else {%>
										<td width="15%" align="center"><input type="text" name="txt_transitPeriod" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_transitPeriod" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_transitPeriod" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_transitPeriod" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_transitPeriod" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
									</tr>
									<tr class="datagrid">
										<td width="3%" align="center">7.</td>
										<td width="25%">LC requirement </td>
										<%
										if (arrRow != null && arrRow.size() > 0) 
										{
											
										%>
										<td width="15%" align="center"><input type="text" name="txt_LCrequirement" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(6)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_LCrequirement" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(6)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_LCrequirement" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(6)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_LCrequirement" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(6)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_LCrequirement" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(6)))%>"></td>
										<%} else {%>
										<td width="15%" align="center"><input type="text" name="txt_LCrequirement" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_LCrequirement" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_LCrequirement" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_LCrequirement" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_LCrequirement" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
									</tr>
									<tr class="datagrid">
										<td width="3%" align="center">8.</td>
										<td width="25%">Applied limit </td><%
										if (arrRow != null && arrRow.size() > 0) 
										{
											
										%>
										<td width="15%" align="center"><input type="text" name="txt_appliedLimit" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(7)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_appliedLimit" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(7)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_appliedLimit" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(7)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_appliedLimit" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(7)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_appliedLimit" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(7)))%>"></td>
										<%} else {%>
										<td width="15%" align="center"><input type="text" name="txt_appliedLimit" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_appliedLimit" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_appliedLimit" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_appliedLimit" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_appliedLimit" size="12" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="7" onBlur="roundtxt(this);" value="0.00"></td>
										<%}%>
									</tr>
									<tr class="datagrid">
										<td width="3%" align="center">9.</td>
										<td width="25%">Recommended limit </td>
										<%
										if (arrRow != null && arrRow.size() > 0) 
										{
											
										%>
										<td width="15%" align="center"><input type="text" name="txt_recomdLimit" size="12" style="text-align: right;" onKeyPress="allowNumber(this);" maxlength="7" onBlur="roundtxt(this)" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(8)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_recomdLimit" size="12" style="text-align: right;" onKeyPress="allowNumber(this);" maxlength="7" onBlur="roundtxt(this)" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(8)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_recomdLimit" size="12" style="text-align: right;" onKeyPress="allowNumber(this);" maxlength="7" onBlur="roundtxt(this)" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(8)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_recomdLimit" size="12" style="text-align: right;" onKeyPress="allowNumber(this);" maxlength="7" onBlur="roundtxt(this)" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(8)))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_recomdLimit" size="12" style="text-align: right;" onKeyPress="allowNumber(this);" maxlength="7" onBlur="roundtxt(this)" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(8)))%>"></td>
										<%} else {%>
										<td width="15%" align="center"><input type="text" name="txt_recomdLimit" size="12" style="text-align: right;" onKeyPress="allowNumber(this);" maxlength="7" onBlur="roundtxt(this)" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_recomdLimit" size="12" style="text-align: right;" onKeyPress="allowNumber(this);" maxlength="7" onBlur="roundtxt(this)" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_recomdLimit" size="12" style="text-align: right;" onKeyPress="allowNumber(this);" maxlength="7" onBlur="roundtxt(this)" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_recomdLimit" size="12" style="text-align: right;" onKeyPress="allowNumber(this);" maxlength="7" onBlur="roundtxt(this)" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_recomdLimit" size="12" style="text-align: right;" onKeyPress="allowNumber(this);" maxlength="7" onBlur="roundtxt(this)" value="0.00"></td>
										<%}%>
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
	<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Comments' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	<lapschoice:hiddentag pageid='<%=PageId%>' /> 

	<input type="hidden" name="hidflag" value=""> 
	<input type="hidden" name="selsno" value=""> 
	<input type="hidden" name="hidval"> 
	<input type="hidden" name="hiddesc"> 
	<INPUT TYPE="hidden" NAME="hidPageSource" VALUE="AOI"> 
	<input type="hidden" name="pagefrom">
	<INPUT TYPE="hidden" name="strschemeType" value = "<%=StrSchemeType%>">
	<INPUT TYPE="hidden" name="strAssessment" value = "<%=request.getParameter("strAssessment")%>">
	<input type="hidden" name="hidCommentPage" value="inlandComments">
</form>
</body>
</html>