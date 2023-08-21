<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
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
<title>Turn Over Method</title>

<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varOrgLevel="<%=strOrgLevel%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var appno="<%=request.getParameter("appno")%>";
var COM_TO_combo0="<%=Helper.correctNull((String) hshValues.get("COM_TO_combo0"))%>";
var COM_TO_combo1="<%=Helper.correctNull((String) hshValues.get("COM_TO_combo1"))%>";
var COM_TO_combo2="<%=Helper.correctNull((String) hshValues.get("COM_TO_combo2"))%>";
var COM_TO_combo3="<%=Helper.correctNull((String) hshValues.get("COM_TO_combo3"))%>";
var COM_TO_combo4="<%=Helper.correctNull((String) hshValues.get("COM_TO_combo4"))%>";
function doCancel()
{
	if (ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="comproposal";		
		document.forms[0].hidBeanGetMethod.value="getturnoverMethod";
		document.forms[0].action=appURL+"action/com_turnovermethod.jsp";
		document.forms[0].submit();
	}
}

function doEdit()
{	
	disablefields(false);
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value ="update"
	enableButtons(true,false,false,false,false,false);

	for(var i=0;i<document.forms[0].txt_year.length;i++)
	{
		document.forms[0].txt_percentaccptSales[i].readOnly=true;
		document.forms[0].txt_minMargin[i].readOnly=true;
		document.forms[0].txt_eligibleFin[i].readOnly=true;
		document.forms[0].txt_eligibleBankfin[i].readOnly=true;
		document.forms[0].txt_permisibleBankfin[i].readOnly=true;
		document.forms[0].txt_surplus[i].readOnly=true;
		document.forms[0].txt_Requiredmargin[i].readOnly=true;
	}
}

function doSave()
{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updturnoverMethod";
	document.forms[0].hidBeanGetMethod.value="getturnoverMethod";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_turnovermethod.jsp";
	document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanMethod.value="updturnoverMethod";
		document.forms[0].hidBeanGetMethod.value="getturnoverMethod";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_turnovermethod.jsp";
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
		if(document.forms[0].btnenable.value=="Y")
 		{
			enableButtons(false,true,true,false,true,true);
 			
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
	for(var i=0;i<document.forms[0].txt_year.length;i++)
	{
		var accptSale1 = parseFloat(document.forms[0].txt_accptprojSales[0].value);
		var accptSale2 = parseFloat(document.forms[0].txt_accptprojSales[1].value);
		var accptSale3 = parseFloat(document.forms[0].txt_accptprojSales[2].value);
		var accptSale4 = parseFloat(document.forms[0].txt_accptprojSales[3].value);
		var accptSale5 = parseFloat(document.forms[0].txt_accptprojSales[4].value);


		var actMargin1 = parseFloat(document.forms[0].txt_actualMargin[0].value);
		var actMargin2 = parseFloat(document.forms[0].txt_actualMargin[1].value);
		var actMargin3 = parseFloat(document.forms[0].txt_actualMargin[2].value);
		var actMargin4 = parseFloat(document.forms[0].txt_actualMargin[3].value);
		var actMargin5 = parseFloat(document.forms[0].txt_actualMargin[4].value);
	
	
		var percentaccptSales1 =NanNumber(accptSale1/4); 
		var percentaccptSales2 =NanNumber(accptSale2/4); 
		var percentaccptSales3 =NanNumber(accptSale3/4); 
		var percentaccptSales4 =NanNumber(accptSale4/4); 
		var percentaccptSales5 =NanNumber(accptSale5/4); 

		document.forms[0].txt_percentaccptSales[0].value =roundVal(percentaccptSales1);
		document.forms[0].txt_percentaccptSales[1].value =roundVal(percentaccptSales2);
		document.forms[0].txt_percentaccptSales[2].value =roundVal(percentaccptSales3); 
		document.forms[0].txt_percentaccptSales[3].value =roundVal(percentaccptSales4);
		document.forms[0].txt_percentaccptSales[4].value =roundVal(percentaccptSales5);
		
		var minMargin1 =NanNumber(accptSale1*0.05); 
		var minMargin2 =NanNumber(accptSale2*0.05); 
		var minMargin3 =NanNumber(accptSale3*0.05); 
		var minMargin4 =NanNumber(accptSale4*0.05); 
		var minMargin5 =NanNumber(accptSale5*0.05); 

		document.forms[0].txt_minMargin[0].value =roundVal(minMargin1); 
		document.forms[0].txt_minMargin[1].value =roundVal(minMargin2); 
		document.forms[0].txt_minMargin[2].value =roundVal(minMargin3);  
		document.forms[0].txt_minMargin[3].value =roundVal(minMargin4);  
		document.forms[0].txt_minMargin[4].value =roundVal(minMargin5);  

		var eligibleFin1 =NanNumber(parseFloat(document.forms[0].txt_percentaccptSales[0].value)-parseFloat(document.forms[0].txt_minMargin[0].value)); 
		var eligibleFin2 =NanNumber(parseFloat(document.forms[0].txt_percentaccptSales[1].value)-parseFloat(document.forms[0].txt_minMargin[1].value));
		var eligibleFin3 =NanNumber(parseFloat(document.forms[0].txt_percentaccptSales[2].value)-parseFloat(document.forms[0].txt_minMargin[2].value));
		var eligibleFin4 =NanNumber(parseFloat(document.forms[0].txt_percentaccptSales[3].value)-parseFloat(document.forms[0].txt_minMargin[3].value));
		var eligibleFin5 =NanNumber(parseFloat(document.forms[0].txt_percentaccptSales[4].value)-parseFloat(document.forms[0].txt_minMargin[4].value));

		document.forms[0].txt_eligibleFin[0].value =roundVal(eligibleFin1); 
		document.forms[0].txt_eligibleFin[1].value =roundVal(eligibleFin2); 
		document.forms[0].txt_eligibleFin[2].value =roundVal(eligibleFin3);  
		document.forms[0].txt_eligibleFin[3].value =roundVal(eligibleFin4);  
		document.forms[0].txt_eligibleFin[4].value =roundVal(eligibleFin5);  

		var eligibleBankfin1 =NanNumber(parseFloat(document.forms[0].txt_percentaccptSales[0].value)-parseFloat(document.forms[0].txt_actualMargin[0].value)); 
		var eligibleBankfin2 =NanNumber(parseFloat(document.forms[0].txt_percentaccptSales[1].value)-parseFloat(document.forms[0].txt_actualMargin[1].value));
		var eligibleBankfin3 =NanNumber(parseFloat(document.forms[0].txt_percentaccptSales[2].value)-parseFloat(document.forms[0].txt_actualMargin[2].value));
		var eligibleBankfin4 =NanNumber(parseFloat(document.forms[0].txt_percentaccptSales[3].value)-parseFloat(document.forms[0].txt_actualMargin[3].value));
		var eligibleBankfin5 =NanNumber(parseFloat(document.forms[0].txt_percentaccptSales[4].value)-parseFloat(document.forms[0].txt_actualMargin[4].value));

		document.forms[0].txt_eligibleBankfin[0].value =roundVal(eligibleBankfin1); 
		document.forms[0].txt_eligibleBankfin[1].value =roundVal(eligibleBankfin2); 
		document.forms[0].txt_eligibleBankfin[2].value =roundVal(eligibleBankfin3);  
		document.forms[0].txt_eligibleBankfin[3].value =roundVal(eligibleBankfin4);  
		document.forms[0].txt_eligibleBankfin[4].value =roundVal(eligibleBankfin5);
	
		if(parseFloat(document.forms[0].txt_eligibleFin[0].value) < parseFloat(document.forms[0].txt_eligibleBankfin[0].value))
		{
			document.forms[0].txt_permisibleBankfin[0].value=document.forms[0].txt_eligibleFin[0].value;
		}
		else
		{
			document.forms[0].txt_permisibleBankfin[0].value=document.forms[0].txt_eligibleBankfin[0].value;
		}
		if(parseFloat(document.forms[0].txt_eligibleFin[1].value) < parseFloat(document.forms[0].txt_eligibleBankfin[1].value))
		{
			document.forms[0].txt_permisibleBankfin[1].value=document.forms[0].txt_eligibleFin[1].value;
		}
		else
		{
			document.forms[0].txt_permisibleBankfin[1].value=document.forms[0].txt_eligibleBankfin[1].value;
		}
		if(parseFloat(document.forms[0].txt_eligibleFin[2].value) < parseFloat(document.forms[0].txt_eligibleBankfin[2].value))
		{
			document.forms[0].txt_permisibleBankfin[2].value=document.forms[0].txt_eligibleFin[2].value;
		}
		else
		{
			document.forms[0].txt_permisibleBankfin[2].value=document.forms[0].txt_eligibleBankfin[2].value;
		}
		if(parseFloat(document.forms[0].txt_eligibleFin[3].value) < parseFloat(document.forms[0].txt_eligibleBankfin[3].value))
		{
			document.forms[0].txt_permisibleBankfin[3].value=document.forms[0].txt_eligibleFin[3].value;
		}
		else
		{
			document.forms[0].txt_permisibleBankfin[3].value=document.forms[0].txt_eligibleBankfin[3].value;
		}
		if(parseFloat(document.forms[0].txt_eligibleFin[4].value) < parseFloat(document.forms[0].txt_eligibleBankfin[4].value))
		{
			document.forms[0].txt_permisibleBankfin[4].value=document.forms[0].txt_eligibleFin[4].value;
		}
		else
		{
			document.forms[0].txt_permisibleBankfin[4].value=document.forms[0].txt_eligibleBankfin[4].value;
		}

		var limitProposed1 = NanNumber(parseFloat(document.forms[0].txt_limitProposed[0].value)*(25/100));
		var limitProposed2 = NanNumber(parseFloat(document.forms[0].txt_limitProposed[1].value)*(25/100));
		var limitProposed3 = NanNumber(parseFloat(document.forms[0].txt_limitProposed[2].value)*(25/100));
		var limitProposed4 = NanNumber(parseFloat(document.forms[0].txt_limitProposed[3].value)*(25/100));
		var limitProposed5 = NanNumber(parseFloat(document.forms[0].txt_limitProposed[4].value)*(25/100));

		document.forms[0].txt_Requiredmargin[0].value =roundVal(limitProposed1); 
		document.forms[0].txt_Requiredmargin[1].value =roundVal(limitProposed2); 
		document.forms[0].txt_Requiredmargin[2].value =roundVal(limitProposed3);  
		document.forms[0].txt_Requiredmargin[3].value =roundVal(limitProposed4);  
		document.forms[0].txt_Requiredmargin[4].value =roundVal(limitProposed5);

		var surplus1 =NanNumber(parseFloat(document.forms[0].txt_actualMargin[0].value)-parseFloat(document.forms[0].txt_Requiredmargin[0].value));
		var surplus2 =NanNumber(parseFloat(document.forms[0].txt_actualMargin[1].value)-parseFloat(document.forms[0].txt_Requiredmargin[1].value));
		var surplus3 =NanNumber(parseFloat(document.forms[0].txt_actualMargin[2].value)-parseFloat(document.forms[0].txt_Requiredmargin[2].value));
		var surplus4 =NanNumber(parseFloat(document.forms[0].txt_actualMargin[3].value)-parseFloat(document.forms[0].txt_Requiredmargin[3].value));
		var surplus5 =NanNumber(parseFloat(document.forms[0].txt_actualMargin[4].value)-parseFloat(document.forms[0].txt_Requiredmargin[4].value));

		document.forms[0].txt_surplus[0].value =roundVal(surplus1); 
		document.forms[0].txt_surplus[1].value =roundVal(surplus2); 
		document.forms[0].txt_surplus[2].value =roundVal(surplus3);  
		document.forms[0].txt_surplus[3].value =roundVal(surplus4);  
		document.forms[0].txt_surplus[4].value =roundVal(surplus5);
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

function funcombo()
{
	if(COM_TO_combo0!="")
	{
		 document.forms[0].combo[0].value=COM_TO_combo0;
	}
	else
	{
		document.forms[0].combo[0].value="S";
	}
	if(COM_TO_combo1!="")
	{
		 document.forms[0].combo[1].value=COM_TO_combo1;
	}
	else
	{
		 document.forms[0].combo[1].value="S";
	}
	if(COM_TO_combo2!="")
	{
		 document.forms[0].combo[2].value=COM_TO_combo2;
	}
	else
	{
		 document.forms[0].combo[2].value="S";
	}
	if(COM_TO_combo3!="")
	{
		 document.forms[0].combo[3].value=COM_TO_combo3;
	}
	else
	{
		 document.forms[0].combo[3].value="S";
	}
	if(COM_TO_combo4!="")
	{
		 document.forms[0].combo[4].value=COM_TO_combo4;
	}
	else
	{
		 document.forms[0].combo[4].value="S";
	}

}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="calculation();placevalues();funcombo()">
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
		<jsp:param name="tabid" value="9" />
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
                              <td width="22%">Particulars</td>
                              <%
											if (arrRowyr != null && arrRowyr.size() > 0) 
											{
												arrColyr = (ArrayList) arrRowyr.get(0);
										%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_year" size="15" onKeyPress="allowAlpaNumeric(this)" maxlength="15" value="<%=Helper.correctNull((String)arrColyr.get(0))%>">
                              </td>
                              <%}else {%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_year" size="15" onKeyPress="allowAlpaNumeric(this)" maxlength="15" onBlur="">
                              </td>
                              <%}%>
                              <%
											if (arrRowyr != null && arrRowyr.size() > 0) 
											{
												arrColyr1 = (ArrayList) arrRowyr.get(1);
										%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_year" size="15" onKeyPress="allowAlpaNumeric(this)" maxlength="15" value="<%=Helper.correctNull((String)arrColyr1.get(0))%>">
                              </td>
                              <%}else {%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_year" size="15" onKeyPress="allowAlpaNumeric(this)" maxlength="15" onBlur="">
                              </td>
                              <%}%>
                              <%
											if (arrRowyr != null && arrRowyr.size() > 0) 
											{
												arrColyr2 = (ArrayList) arrRowyr.get(2);
										%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_year" size="15" onKeyPress="allowAlpaNumeric(this)" maxlength="15" value="<%=Helper.correctNull((String)arrColyr2.get(0))%>">
                              </td>
                              <%}else {%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_year" size="15" onKeyPress="allowAlpaNumeric(this)" maxlength="15" onBlur="">
                              </td>
                              <%}%>
                              <%
											if (arrRowyr != null && arrRowyr.size() > 0) 
											{
												arrColyr3 = (ArrayList) arrRowyr.get(3);
										%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_year" size="15" onKeyPress="allowAlpaNumeric(this)" maxlength="15" value="<%=Helper.correctNull((String)arrColyr3.get(0))%>">
                              </td>
                              <%}else {%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_year" size="15" onKeyPress="allowAlpaNumeric(this)" maxlength="15" onBlur="">
                              </td>
                              <%}%>
                              <%
											if (arrRowyr != null && arrRowyr.size() > 0) 
											{
												arrColyr4 = (ArrayList) arrRowyr.get(4);
										%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_year" size="15" onKeyPress="allowAlpaNumeric(this)" maxlength="15" value="<%=Helper.correctNull((String)arrColyr4.get(0))%>">
                              </td>
                              <%}else {%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_year" size="15" onKeyPress="allowAlpaNumeric(this)" maxlength="15" onBlur="">
                              </td>
                              <%}%>
                            </tr>
                            
                            
                            
                         <tr class="dataheader">
						<td colspan="2">&nbsp;</td>
						<td width="14%" align="center"><select name="combo">
							<option value="S" selected="selected">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited</option>
							<option value="p">Projection</option>
						</select></td>
						<td width="13%" align="center"><select name="combo">
							<option value="S" selected="selected">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited</option>
							<option value="p">Projection</option>
						</select></td>
						<td width="14%" align="center"><select name="combo">
							<option value="S" selected="selected">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited</option>
							<option value="p">Projection</option>
						</select></td>
						<td width="14%" align="center"><select name="combo">
							<option value="S" selected="selected">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited</option>
							<option value="p">Projection</option>
						</select></td>

						<td width="13%" align="center"><select name="combo">
							<option value="S" selected="selected">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited</option>
							<option value="p">Projection</option>
						</select></td>
					</tr>
                            
                            
                            
                            <tr class="datagrid"> 
                              <td width="3%" align="center">1.</td>
                              <td width="25%">Projected Sales </td>
                              <%
										if (arrRow != null && arrRow.size() > 0) 
										{
										%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_projSales" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(0)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_projSales" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(0)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_projSales" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(0)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_projSales" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(0)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_projSales" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(0)))%>">
                              </td>
                              <%} else {%>
                              <td width="15%" align="center">
                                <input  type="text" size="15" name="txt_projSales" style="text-align:right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" tabindex="" value="0.00"/>
                              </td>
                              <td width="15%" align="center">
                                <input  type="text" size="15" name="txt_projSales" style="text-align:right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" tabindex="" value="0.00"/>
                              </td>
                              <td width="15%" align="center">
                                <input  type="text" size="15" name="txt_projSales" style="text-align:right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" tabindex="" value="0.00"/>
                              </td>
                              <td width="15%" align="center">
                                <input  type="text" size="15" name="txt_projSales" style="text-align:right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" tabindex="" value="0.00"/>
                              </td>
                              <td width="15%" align="center">
                                <input  type="text" size="15" name="txt_projSales" style="text-align:right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" tabindex="" value="0.00"/>
                              </td>
                              <%}%>
                            </tr>
                            <tr class="datagrid"> 
                              <td width="3%" align="center">2.</td>
                              <td width="25%">Accepted projected Sales</td>
                              <%
										if (arrRow != null && arrRow.size() > 0) 
										{
											
										%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_accptprojSales" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(1)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_accptprojSales" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(1)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_accptprojSales" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(1)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_accptprojSales" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(1)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_accptprojSales" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(1)))%>">
                              </td>
                              <%} else {%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_accptprojSales" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_accptprojSales" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_accptprojSales" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_accptprojSales" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_accptprojSales" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <%}%>
                            </tr>
                            <tr class="datagrid"> 
                              <td width="3%" align="center">3.</td>
                              <td width="25%">25% of accepted sales</td>
                              <%
										if (arrRow != null && arrRow.size() > 0) 
										{
											
										%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_percentaccptSales" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(2)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_percentaccptSales" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(2)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_percentaccptSales" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(2)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_percentaccptSales" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(2)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_percentaccptSales" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(2)))%>">
                              </td>
                              <%} else {%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_percentaccptSales" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_percentaccptSales" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_percentaccptSales" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_percentaccptSales" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_percentaccptSales" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <%}%>
                            </tr>
                            <tr class="datagrid"> 
                              <td width="3%" align="center">4.</td>
                              <td width="25%">Minimum Margin required (5% of accepted 
                                sales)</td>
                              <%
										if (arrRow != null && arrRow.size() > 0) 
										{
											
										%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_minMargin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(3)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_minMargin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(3)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_minMargin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(3)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_minMargin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(3)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_minMargin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(3)))%>">
                              </td>
                              <%} else {%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_minMargin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_minMargin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_minMargin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_minMargin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_minMargin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <%}%>
                            </tr>
                            <tr class="datagrid"> 
                              <td width="3%" align="center">5.</td>
                              <td width="25%">Eligible Finance as per Norms</td>
                              <%
										if (arrRow != null && arrRow.size() > 0) 
										{
											
										%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_eligibleFin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(4)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_eligibleFin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(4)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_eligibleFin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(4)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_eligibleFin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(4)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_eligibleFin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(4)))%>">
                              </td>
                              <%} else {%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_eligibleFin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_eligibleFin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_eligibleFin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_eligibleFin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_eligibleFin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <%}%>
                            </tr>
                            <tr class="datagrid"> 
                              <td width="3%" align="center">6.</td>
                              <td width="25%">Actual Margin available in the System</td>
                              <%
										if (arrRow != null && arrRow.size() > 0) 
										{
											
										%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_actualMargin" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(5)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_actualMargin" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(5)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_actualMargin" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(5)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_actualMargin" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(5)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_actualMargin" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(5)))%>">
                              </td>
                              <%} else {%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_actualMargin" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_actualMargin" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_actualMargin" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_actualMargin" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_actualMargin" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <%}%>
                            </tr>
                            <tr class="datagrid"> 
                              <td width="3%" align="center">7.</td>
                              <td width="25%">Eligible Bank Finance as per availability 
                                of actual Margin</td>
                              <%
										if (arrRow != null && arrRow.size() > 0) 
										{
											
										%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_eligibleBankfin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(6)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_eligibleBankfin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(6)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_eligibleBankfin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(6)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_eligibleBankfin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(6)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_eligibleBankfin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(6)))%>">
                              </td>
                              <%} else {%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_eligibleBankfin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_eligibleBankfin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_eligibleBankfin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_eligibleBankfin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_eligibleBankfin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <%}%>
                            </tr>
                            <tr class="datagrid"> 
                              <td width="3%" align="center">8.</td>
                              <td width="25%">Permissible Bank Finance </td>
                              <%
										if (arrRow != null && arrRow.size() > 0) 
										{
											
										%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_permisibleBankfin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(7)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_permisibleBankfin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(7)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_permisibleBankfin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(7)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_permisibleBankfin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(7)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_permisibleBankfin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(7)))%>">
                              </td>
                              <%} else {%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_permisibleBankfin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_permisibleBankfin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_permisibleBankfin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_permisibleBankfin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_permisibleBankfin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00">
                              </td>
                              <%}%>
                            </tr>
                            <tr class="datagrid"> 
                              <td width="3%" align="center">9.</td>
                              <td width="25%">Limits sought</td>
                              <%
										if (arrRow != null && arrRow.size() > 0) 
										{
											
										%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_limitSought" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(8)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_limitSought" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(8)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_limitSought" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(8)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_limitSought" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(8)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_limitSought" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(8)))%>">
                              </td>
                              <%} else {%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_limitSought" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_limitSought" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_limitSought" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_limitSought" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_limitSought" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="0.00">
                              </td>
                              <%}%>
                            </tr>
                            <tr class="datagrid"> 
                              <td width="3%" align="center">10.</td>
                              <td width="25%">Limit proposed</td>
                              <%
										if (arrRow != null && arrRow.size() > 0) 
										{
											
										%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_limitProposed" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this);calculation()" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(9)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_limitProposed" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this);calculation()" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(9)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_limitProposed" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this);calculation()" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(9)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_limitProposed" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this);calculation()" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(9)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_limitProposed" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this);calculation()" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(9)))%>">
                              </td>
                              <%} else {%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_limitProposed" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this);calculation()" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_limitProposed" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this);calculation()" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_limitProposed" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this);calculation()" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_limitProposed" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this);calculation()" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_limitProposed" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this);calculation()" value="0.00">
                              </td>
                              <%}%>
                            </tr>
                              <tr class="datagrid"> 
                              <td width="3%" align="center">11.</td>
                              <td width="25%">Required Margin</td>
                              <%
										if (arrRow != null && arrRow.size() > 0) 
										{
											
										%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_Requiredmargin" size="15" style="text-align: right;" class="derivedFld" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(11)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_Requiredmargin" size="15" style="text-align: right;" class="derivedFld" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(11)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_Requiredmargin" size="15" style="text-align: right;" class="derivedFld" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(11)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_Requiredmargin" size="15" style="text-align: right;" class="derivedFld" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(11)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_Requiredmargin" size="15" style="text-align: right;" class="derivedFld" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(11)))%>">
                              </td>
                              <%} else {%>
                              <td width="15%" align="center">
                                <input type="text" name="txt_Requiredmargin" size="15" style="text-align: right;" class="derivedFld" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_Requiredmargin" size="15" style="text-align: right;" class="derivedFld" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_Requiredmargin" size="15" style="text-align: right;" class="derivedFld" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_Requiredmargin" size="15" style="text-align: right;" class="derivedFld" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text" name="txt_Requiredmargin" size="15" style="text-align: right;" class="derivedFld" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="0.00">
                              </td>
                              <%}%>
                            </tr>
                            <tr class="datagrid"> 
                              <td width="3%" align="center">12.</td>
                              <td width="25%">Surplus/Shortfall(-) in required 
                                Margin</td>
                              <%
										if (arrRow != null && arrRow.size() > 0) 
										{
											
										%>
                              <td width="15%" align="center">
                                <input type="text"   name="txt_surplus" size="15" style="text-align: right;" class="derivedFld" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(10)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text"   name="txt_surplus" size="15" style="text-align: right;" class="derivedFld" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(10)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text"  name="txt_surplus" size="15" style="text-align: right;" class="derivedFld" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(10)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text"  name="txt_surplus" size="15" style="text-align: right;" class="derivedFld" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(10)))%>">
                              </td>
                              <td width="15%" align="center">
                                <input type="text"  name="txt_surplus" size="15" style="text-align: right;" class="derivedFld" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(10)))%>">
                              </td>
                              <%} else {%>
                              <td width="15%" align="center">
                                <input type="text"  name="txt_surplus" size="15"  class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text"  name="txt_surplus" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text"  name="txt_surplus" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text"  name="txt_surplus" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="0.00">
                              </td>
                              <td width="15%" align="center">
                                <input type="text"  name="txt_surplus" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="0.00">
                              </td>
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
	<INPUT TYPE="hidden" NAME="hidPageSource" VALUE="COP"> 
	<input type="hidden" name="pagefrom">
	<INPUT TYPE="hidden" name="strAssessment" value = "<%=request.getParameter("strAssessment")%>">
	<input type="hidden" name="hidCommentPage" value="turnover">
</form>
</body>
</html>