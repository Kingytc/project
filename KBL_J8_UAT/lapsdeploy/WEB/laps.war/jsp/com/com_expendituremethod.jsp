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
	
	//Added by Kishan
	String[] strCombo = new String[5];
	for(int i=0;i<5;i++)
	{
		strCombo[i] = Helper.correctNull((String) hshValues.get("COM_EXP_Combo"+i));
		if(strCombo[i].equals(""))
			strCombo[i]="S";
	}
	
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
	ArrayList arrCol5 = new ArrayList();
	ArrayList arrCol6 = new ArrayList();
	ArrayList arrCol7 = new ArrayList();
	ArrayList arrCol8 = new ArrayList();
	ArrayList arrCol9 = new ArrayList();
	
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
%> 
<html>
<head>
<title>Expenditure Method</title>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varOrgLevel="<%=strOrgLevel%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var appno="<%=request.getParameter("appno")%>";
var COM_TO_combo0="<%=Helper.correctNull((String) hshValues.get("COM_EXP_Combo0"))%>";
var COM_TO_combo1="<%=Helper.correctNull((String) hshValues.get("COM_EXP_Combo1"))%>";
var COM_TO_combo2="<%=Helper.correctNull((String) hshValues.get("COM_EXP_Combo2"))%>";
var COM_TO_combo3="<%=Helper.correctNull((String) hshValues.get("COM_EXP_Combo3"))%>";
var COM_TO_combo4="<%=Helper.correctNull((String) hshValues.get("COM_EXP_Combo4"))%>";
function doCancel()
{
	if (ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="comproposal";		
		document.forms[0].hidBeanGetMethod.value="getexpenditureMethod";
		document.forms[0].action=appURL+"action/com_expendituremethod.jsp";
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
function doEdit()
{	
	disablefields(false);
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value ="update"
	enableButtons(true,false,false,false,false,false);

	for(var i=0;i<document.forms[0].txt_year.length;i++)
	{
		document.forms[0].txt_eligibleExpnd[i].readOnly=true;
		document.forms[0].txt_permisibleFin[i].readOnly=true; 
	}
}

function doSave()
{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updexpenditureMethod";
	document.forms[0].hidBeanGetMethod.value="getexpenditureMethod";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_expendituremethod.jsp";
	document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanMethod.value="updexpenditureMethod";
		document.forms[0].hidBeanGetMethod.value="getexpenditureMethod";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_expendituremethod.jsp";
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
		var accptSale1 = parseFloat(document.forms[0].txt_accptprojExp[0].value);
		var accptSale2 = parseFloat(document.forms[0].txt_accptprojExp[1].value);
		var accptSale3 = parseFloat(document.forms[0].txt_accptprojExp[2].value);
		var accptSale4 = parseFloat(document.forms[0].txt_accptprojExp[3].value);
		var accptSale5 = parseFloat(document.forms[0].txt_accptprojExp[4].value);

		var opercycle1=   parseFloat(document.forms[0].txt_operationCycle[0].value);
		var opercycle2=   parseFloat(document.forms[0].txt_operationCycle[1].value);
		var opercycle3=   parseFloat(document.forms[0].txt_operationCycle[2].value);
		var opercycle4=   parseFloat(document.forms[0].txt_operationCycle[3].value);
		var opercycle5=   parseFloat(document.forms[0].txt_operationCycle[4].value); 
	
		var eligibleExpnd1 =NanNumber((accptSale1/365)*opercycle1); 
		var eligibleExpnd2 =NanNumber((accptSale2/365)*opercycle2); 
		var eligibleExpnd3 =NanNumber((accptSale3/365)*opercycle3); 
		var eligibleExpnd4 =NanNumber((accptSale4/365)*opercycle4); 
		var eligibleExpnd5 =NanNumber((accptSale5/365)*opercycle5); 

		document.forms[0].txt_eligibleExpnd[0].value =roundVal(eligibleExpnd1); 
		document.forms[0].txt_eligibleExpnd[1].value =roundVal(eligibleExpnd2); 
		document.forms[0].txt_eligibleExpnd[2].value =roundVal(eligibleExpnd3); 
		document.forms[0].txt_eligibleExpnd[3].value =roundVal(eligibleExpnd4); 
		document.forms[0].txt_eligibleExpnd[4].value =roundVal(eligibleExpnd5); 
		
		document.forms[0].txt_permisibleFin[0].value =roundVal(eligibleExpnd1*0.75); 
		document.forms[0].txt_permisibleFin[1].value =roundVal(eligibleExpnd2*0.75);
		document.forms[0].txt_permisibleFin[2].value =roundVal(eligibleExpnd3*0.75); 
		document.forms[0].txt_permisibleFin[3].value =roundVal(eligibleExpnd4*0.75); 
		document.forms[0].txt_permisibleFin[4].value =roundVal(eligibleExpnd5*0.75); 
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

	<% for(int i=0;i<5;i++) { %>
	 document.forms[0].combo[<%=i%>].value="<%=strCombo[i]%>";
	 <% } %>

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
 		Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Financial Analysis -&gt; Assessment -&gt; Expenditure Method
<span style="display:none"><lapschoice:borrowertype /></span> 
<lapschoice:application/>
	</td>
</tr>
</table>
  	<jsp:include page="../com/com_commentstab.jsp" flush="true">
		<jsp:param name="tabid" value="10" />
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
										<td width="15%" align="center"><input type="text" name="txt_year" size="15" onKeyPress="allowAlpaNumeric(this)" maxlength="15" value="<%=Helper.correctNull((String)arrColyr.get(0))%>"></td>
										 <%}else {%>
										 <td width="15%" align="center"><input type="text" name="txt_year" size="15" onKeyPress="allowAlpaNumeric(this)" maxlength="15" onBlur=""></td>
										 <%}%>
										 <%
											if (arrRowyr != null && arrRowyr.size() > 0) 
											{
												arrColyr1 = (ArrayList) arrRowyr.get(1);
										%> 
										<td width="15%" align="center"><input type="text" name="txt_year" size="15" onKeyPress="allowAlpaNumeric(this)" maxlength="15" value="<%=Helper.correctNull((String)arrColyr1.get(0))%>"></td>
										<%}else {%>
										 <td width="15%" align="center"><input type="text" name="txt_year" size="15" onKeyPress="allowAlpaNumeric(this)" maxlength="15" onBlur=""></td>
										 <%}%>
										 <%
											if (arrRowyr != null && arrRowyr.size() > 0) 
											{
												arrColyr2 = (ArrayList) arrRowyr.get(2);
										%> 
										<td width="15%" align="center"><input type="text" name="txt_year" size="15" onKeyPress="allowAlpaNumeric(this)" maxlength="15" value="<%=Helper.correctNull((String)arrColyr2.get(0))%>"></td>
										<%}else {%>
										 <td width="15%" align="center"><input type="text" name="txt_year" size="15" onKeyPress="allowAlpaNumeric(this)" maxlength="15" onBlur=""></td>
										 <%}%>
										 <%
											if (arrRowyr != null && arrRowyr.size() > 0) 
											{
												arrColyr3 = (ArrayList) arrRowyr.get(3);
										%> 
										<td width="15%" align="center"><input type="text" name="txt_year" size="15" onKeyPress="allowAlpaNumeric(this)" maxlength="15" value="<%=Helper.correctNull((String)arrColyr3.get(0))%>"></td>
										<%}else {%>
										 <td width="15%" align="center"><input type="text" name="txt_year" size="15" onKeyPress="allowAlpaNumeric(this)" maxlength="15" onBlur=""></td>
										 <%}%>
										 <%
											if (arrRowyr != null && arrRowyr.size() > 0) 
											{
												arrColyr4 = (ArrayList) arrRowyr.get(4);
										%> 
										<td width="15%" align="center"><input type="text" name="txt_year" size="15" onKeyPress="allowAlpaNumeric(this)" maxlength="15" value="<%=Helper.correctNull((String)arrColyr4.get(0))%>"></td>
										<%}else {%>
										 <td width="15%" align="center"><input type="text" name="txt_year" size="15" onKeyPress="allowAlpaNumeric(this)" maxlength="15" onBlur=""></td>
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
										<td width="25%">Projected expenditure </td>
										<%
										if (arrRow != null && arrRow.size() > 0) 
										{
										%> 
										<td width="15%" align="center"><input  type="text" size="15" name="txt_projExp" style="text-align:right;" onkeypress="allowNumber(this)" onblur="roundtxt(this)" maxlength="10" value="<%=Helper.correctNull((String)arrCol.get(0))%>"/></td>
							        	<td width="15%" align="center"><input  type="text" size="15" name="txt_projExp" style="text-align:right;" onkeypress="allowNumber(this)" onblur="roundtxt(this)" maxlength="10" value="<%=Helper.correctNull((String)arrCol1.get(0))%>"/></td>
							        	<td width="15%" align="center"><input  type="text" size="15" name="txt_projExp" style="text-align:right;" onkeypress="allowNumber(this)" onblur="roundtxt(this)" maxlength="10" value="<%=Helper.correctNull((String)arrCol2.get(0))%>"/></td> 
							        	<td width="15%" align="center"><input  type="text" size="15" name="txt_projExp" style="text-align:right;" onkeypress="allowNumber(this)" onblur="roundtxt(this)" maxlength="10" value="<%=Helper.correctNull((String)arrCol3.get(0))%>"/></td>
							        	<td width="15%" align="center"><input  type="text" size="15" name="txt_projExp" style="text-align:right;" onkeypress="allowNumber(this)" onblur="roundtxt(this)" maxlength="10" value="<%=Helper.correctNull((String)arrCol4.get(0))%>"/></td>
							        	<%}else {%>
							        	<td width="15%" align="center"><input  type="text" size="15" name="txt_projExp" style="text-align:right;" onkeypress="allowNumber(this)" onblur="roundtxt(this)" maxlength="10" value="0.00"/></td>
							        	<td width="15%" align="center"><input  type="text" size="15" name="txt_projExp" style="text-align:right;" onkeypress="allowNumber(this)" onblur="roundtxt(this)" maxlength="10" value="0.00"/></td>
							        	<td width="15%" align="center"><input  type="text" size="15" name="txt_projExp" style="text-align:right;" onkeypress="allowNumber(this)" onblur="roundtxt(this)" maxlength="10" value="0.00"/></td> 
							        	<td width="15%" align="center"><input  type="text" size="15" name="txt_projExp" style="text-align:right;" onkeypress="allowNumber(this)" onblur="roundtxt(this)" maxlength="10" value="0.00"/></td>
							        	<td width="15%" align="center"><input  type="text" size="15" name="txt_projExp" style="text-align:right;" onkeypress="allowNumber(this)" onblur="roundtxt(this)" maxlength="10" value="0.00"/></td>
							        	<%}%>  	
									</tr>
									<tr class="datagrid">
										<td width="3%" align="center">2.</td>
										<td width="25%">Accepted projected expenditure</td>
										<%
										if (arrRow != null && arrRow.size() > 0) 
										{
										%> 
										<td width="15%" align="center"><input type="text" name="txt_accptprojExp" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)arrCol.get(1))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_accptprojExp" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)arrCol1.get(1))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_accptprojExp" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)arrCol2.get(1))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_accptprojExp" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)arrCol3.get(1))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_accptprojExp" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)arrCol4.get(1))%>"></td>
										<%}else {%>
										<td width="15%" align="center"><input type="text" name="txt_accptprojExp" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_accptprojExp" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_accptprojExp" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_accptprojExp" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_accptprojExp" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
									</tr>
									<tr class="datagrid">
										<td width="3%" align="center">3.</td>
										<td width="25%">Operational cycle(45/60/75/90 days)</td>
										<%
										if (arrRow != null && arrRow.size() > 0) 
										{
										%> 
										<td width="15%" align="center"><input type="text" name="txt_operationCycle" size="15" style="text-align: right;" onKeyPress="allowInteger(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)arrCol.get(2))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_operationCycle" size="15" style="text-align: right;" onKeyPress="allowInteger(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)arrCol1.get(2))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_operationCycle" size="15" style="text-align: right;" onKeyPress="allowInteger(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)arrCol2.get(2))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_operationCycle" size="15" style="text-align: right;" onKeyPress="allowInteger(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)arrCol3.get(2))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_operationCycle" size="15" style="text-align: right;" onKeyPress="allowInteger(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)arrCol4.get(2))%>"></td>
										<%}else {%>
										<td width="15%" align="center"><input type="text" name="txt_operationCycle" size="15" style="text-align: right;" onKeyPress="allowInteger(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_operationCycle" size="15" style="text-align: right;" onKeyPress="allowInteger(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_operationCycle" size="15" style="text-align: right;" onKeyPress="allowInteger(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_operationCycle" size="15" style="text-align: right;" onKeyPress="allowInteger(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_operationCycle" size="15" style="text-align: right;" onKeyPress="allowInteger(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
									</tr>
									<tr class="datagrid">
										<td width="3%" align="center">4.</td>
										<td width="25%">Eligible expenditure</td>
										<%
										if (arrRow != null && arrRow.size() > 0) 
										{
										%> 
										<td width="15%" align="center"><input type="text" name="txt_eligibleExpnd" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)arrCol.get(3))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_eligibleExpnd" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)arrCol1.get(3))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_eligibleExpnd" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)arrCol2.get(3))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_eligibleExpnd" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)arrCol3.get(3))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_eligibleExpnd" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)arrCol4.get(3))%>"></td>
										<%}else {%>
										<td width="15%" align="center"><input type="text" name="txt_eligibleExpnd" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_eligibleExpnd" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_eligibleExpnd" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_eligibleExpnd" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_eligibleExpnd" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
									</tr>
									<tr class="datagrid">
										<td width="3%" align="center">5.</td>
										<td width="25%">Permisible finance (75 % of eligible expenditure)</td>
										<%
										if (arrRow != null && arrRow.size() > 0) 
										{
										%> 
										<td width="15%" align="center"><input type="text" name="txt_permisibleFin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)arrCol.get(4))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_permisibleFin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)arrCol1.get(4))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_permisibleFin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)arrCol2.get(4))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_permisibleFin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)arrCol3.get(4))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_permisibleFin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="<%=Helper.correctNull((String)arrCol4.get(4))%>"></td>
										<%}else {%>
										<td width="15%" align="center"><input type="text" name="txt_permisibleFin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_permisibleFin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_permisibleFin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_permisibleFin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_permisibleFin" size="15" class="derivedFld" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="calculation();roundtxt(this);" value="0.00"></td>
										<%}%>
									</tr>
									<tr class="datagrid">
										<td width="3%" align="center">6.</td>
										<td width="25%">Limits sought</td>
										<%
										if (arrRow != null && arrRow.size() > 0) 
										{
										%> 
										<td width="15%" align="center"><input type="text" name="txt_limitSought" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.correctNull((String)arrCol.get(5))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_limitSought" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.correctNull((String)arrCol1.get(5))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_limitSought" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.correctNull((String)arrCol2.get(5))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_limitSought" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.correctNull((String)arrCol3.get(5))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_limitSought" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.correctNull((String)arrCol4.get(5))%>"></td>
										<%}else {%>
										<td width="15%" align="center"><input type="text" name="txt_limitSought" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_limitSought" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_limitSought" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_limitSought" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_limitSought" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="0.00"></td>
										<%}%>
									</tr>
									<tr class="datagrid">
										<td width="3%" align="center">7.</td>
										<td width="25%">Limit proposed</td>
										<%
										if (arrRow != null && arrRow.size() > 0) 
										{
										%> 
										<td width="15%" align="center"><input type="text" name="txt_limitProposed" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.correctNull((String)arrCol.get(6))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_limitProposed" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.correctNull((String)arrCol1.get(6))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_limitProposed" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.correctNull((String)arrCol2.get(6))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_limitProposed" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.correctNull((String)arrCol3.get(6))%>"></td>
										<td width="15%" align="center"><input type="text" name="txt_limitProposed" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="<%=Helper.correctNull((String)arrCol4.get(6))%>"></td>
										<%}else {%>
										<td width="15%" align="center"><input type="text" name="txt_limitProposed" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_limitProposed" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_limitProposed" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_limitProposed" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="0.00"></td>
										<td width="15%" align="center"><input type="text" name="txt_limitProposed" size="15" style="text-align: right;" onKeyPress="allowNumber(this)" maxlength="10" onBlur="roundtxt(this)" value="0.00"></td>
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
	<input type="hidden" name="hidCommentPage" value="expenditure">
</form>
</body>
</html>
