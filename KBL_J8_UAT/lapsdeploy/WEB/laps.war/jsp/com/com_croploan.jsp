<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<% 
String strBorrowerType =Helper.correctNull((String)request.getParameter("hidBorrowerType"));
String strAssessmentType= Helper.correctNull((String)hshValues.get("assessmenttype"));
double strtenor= Double.parseDouble(Helper.correctDouble((String)hshValues.get("strtenor")));
%>
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	String cattype = (String) request.getParameter("cattype");
	String ssitype = (String) request.getParameter("ssitype");
	String strSessionModule="";
	strSessionModule=Helper.correctNull((String)request.getParameter("sessionModuleType"));
	if(strSessionModule.equalsIgnoreCase("")){
		strSessionModule=Helper.correctNull((String)session.getAttribute("sessionModuleType"));
	}
	ArrayList arrData=new ArrayList();
	ArrayList arrData1=new ArrayList();
	arrData=(ArrayList)hshValues.get("arrData");	
	ArrayList arrMaster=new ArrayList();
	arrMaster=(ArrayList)hshValues.get("arrMasterValues");	
	String mastEntry_list=Helper.correctNull((String)hshValues.get("MastEntryList"));
	String StrSchemeType=request.getParameter("strschemeType");
	String strAssessType=Helper.correctNull((String)hshValues.get("strAssessType"));
%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<%  java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMinimumFractionDigits(2);
	nf.setMaximumFractionDigits(2);
	nf.setGroupingUsed(false);%>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var mastEntry_list="<%=mastEntry_list%>";
var appno="<%=(String) request.getParameter("appno")%>";

function doSave() 
{		
	<%if(strtenor>12){ %>
	  for(var i=0;i<document.forms[0].txt_elig_recomm.length;i++)
	  {
		  if(document.forms[0].txt_elig_recomm[i].value=="" || document.forms[0].txt_elig_recomm[i].value=="0.00")
		  {
			  alert("Please Enter Limit Recommended for Five Years");
			  return false;
		  }
	  }
	<%}else{%>
	    if(document.forms[0].txt_elig_recomm.value=="" || document.forms[0].txt_elig_recomm.value=="0.00")
	    {
		  alert("Please Enter Limit Recommended");
		  return false;
	    }
	<%}%>
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidBeanId.value = "comproposal";
		document.forms[0].hidBeanGetMethod.value = "updateCropLoan";			
		document.forms[0].action = appUrl+"action/com_croploan.jsp";
		document.forms[0].method = "post";
		document.forms[0].submit();
}
function doEdit() {	
	document.forms[0].hidAction.value = "update";
	disabledFields(false);
	enableButtons(true,false,false,false,true,false);
}
function doCancel() {
	if (ConfirmMsg(102)) {		
		document.forms[0].hidBeanGetMethod.value ="getCropLoan";
		document.forms[0].hidBeanId.value = "comproposal";
		document.forms[0].action = appUrl+"action/com_croploan.jsp";
		document.forms[0].submit();
	}
}
function doDelete() {
	if (ConfirmMsg(101)) {
		document.forms[0].hidAction.value = "delete";	
		document.forms[0].hidBeanId.value = "comproposal";		
		document.forms[0].hidBeanGetMethod.value = "updateCropLoan";		
		document.forms[0].action = appUrl+"action/com_croploan.jsp";		
		document.forms[0].submit();
	}
}
function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{	
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
	document.forms[0].cmdcomments.disabled=bool6;
}
function placeValues() 
{
	if(mastEntry_list=="0")
	{
		alert("Data not feed in Corp Loan Master.");
	}	
	disabledFields(true);
	if (document.forms[0].appstatus.value == "Open/Pending") 
	{
		if(document.forms[0].btnenable.value=="Y")
		{	
			enableButtons(false,true,true,true,false,false);
		}
		else
		{
			enableButtons(true,true,true,true,false,false);
		}
	} else {
		enableButtons(true,true,true,true,false,true);
	}

	if(document.forms[0].hidAssessment.value=="130")
	{
		document.all.idcrop.style.display="table";
		document.all.idothers.style.display="none";
		document.all.idcrop1.style.display="table-row";
		document.all.idothers1.style.display="none";
	}
	else
	{
		document.all.idothers.style.display="table";
		document.all.idcrop.style.display="none";
		document.all.idothers1.style.display="table-row";
		document.all.idcrop1.style.display="none";
	}
}
function doComments()
{
	var hidDemoId=document.forms[0].strappno.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidDemoId+"&hidCommentPage=croploan";
	window.open(url,"Comments",prop);
}
function chkamountval(val)
{
		var pcsamount=NanNumber(parseFloat(val.value));
		var eligible="300000";
		if(pcsamount!="")
		{
			if(parseFloat(pcsamount)>parseFloat(eligible))
			{
				alert("The Amount should not exceed 3 Lakhs");
				val.value="";
				val.focus();
					
			}
		}
}
function chkrecmtamt(val1,val2)
{
	var varpcsamt=NanNumber(parseFloat(val2.value));
	var varrecmtamt=NanNumber(parseFloat(val1.value));
	var eligibleamt="300000";
	var vareligiblelmt=parseFloat(eligibleamt)-parseFloat(varpcsamt);
	if(parseFloat(varrecmtamt)>parseFloat(vareligiblelmt))
	{
		alert("The Amount should not exceed Rs."+vareligiblelmt);
		val1.value="";
		val1.focus();
	}
}
function chksanamt(val3,val4)
{
	var varsanamt=NanNumber(parseFloat(val3.value));
	var varrecamt=NanNumber(parseFloat(val4.value));
	if(parseFloat(varsanamt)>parseFloat(varrecamt))
	{
		alert("The Limit Sanctioned Amount should not exceed the Limit Recommended Amount");
		val3.value="";
		val3.focus();
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placeValues()">
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
<form  method="post" class="">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="41" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<span class="page_flow">Home -&gt; Corporate &amp; SME -&gt;
Proposal -&gt; Assessment -&gt; Assessment of Limit</span><br>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<jsp:include page="../com/com_commentstab.jsp" flush="true">
<jsp:param name="tabid" value="12" />
</jsp:include>
<br>
<table width="80%" border="0" cellspacing="0" cellpadding="0"
	align="center">

	<tr>
		<td>
		<table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="0"
			align="center"></table><tr>
			<td>
		<table width="100%" border="0" cellspacing="1"  cellpadding="1" class="outertable" align="center" id="idcrop">
			<tr class="dataheader">
				<td width="10%" align="center">Crops</td>
				<td width="9%" align="center">Area in acres</td>
				<td width="9%" align="center">Scale of Finance<br>per acre</td>
				<td width="10%" align="center">Limit as per <br> scale of finance</td>
				<td width="9.99%" align="center">Eligible limit</td>
				<td width="10%" align="center">Loan with JGSUB</td>
				<td width="10%" align="center">Loan with PACS</td>
				<td width="10%" align="center">Limit recommended <span class="mantatory">*</span></td>
				<td width="10%" align="center">Limit sanctioned</td>
			</tr>
			<%
			if(arrData!=null && arrData.size()>0) 
			{
				double total=0.0;
				for(int j=0;j<arrData.size();j++)
				{
					arrData1=(ArrayList)arrData.get(j);
					double area=Double.parseDouble(Helper.correctDouble((String)arrData1.get(5)));
					double scale_fin=Double.parseDouble(Helper.correctDouble((String)arrData1.get(6)));
					double limit_scaleoffin=area*scale_fin;
					total=total+limit_scaleoffin;
				%>
					<tr class="datagrid">
						<td>&nbsp;<%=Helper.correctNull((String)arrData1.get(2))%>&nbsp;</td>
						<td align='right'><%=nf.format(Double.parseDouble((Helper.correctDouble((String)arrData1.get(5)))))%>&nbsp;</td>
						<td align='right'><%=nf.format(Double.parseDouble((Helper.correctDouble((String)arrData1.get(6)))))%>&nbsp;</td>
						<td align='right'><%=nf.format(limit_scaleoffin)%>&nbsp;</td>
						<td align='right'><%=nf.format(limit_scaleoffin)%>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				<%
				}
				%>
				<tr class="datagrid">
					<td colspan="4" align='right'>
					<b>Total</b>
					</td>
					<td align='right'>
					<b><%=nf.format(total)%>&nbsp;</b>
					</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<%
				double ph_expenses=0.0;
				double frm_maintainance=0.0;
				double sec_year=0.0;
				double thrd_year=0.0;
				double fourth_year=0.0;
				double fifth_year=0.0;
				
				double ph_expenses_value=0.0;
				double frm_maintainance_value=0.0;
				double total_value=0.0;
				double sec_year_value=0.0;
				double thrd_year_value=0.0;
				double fourth_year_value=0.0;
				double fifth_year_value=0.0;
				
				
				if(arrMaster!=null)
				{
					if(arrMaster.size()>0)
					{
						ph_expenses=Double.parseDouble(Helper.correctDouble((String)arrMaster.get(0)));
						frm_maintainance=Double.parseDouble(Helper.correctDouble((String)arrMaster.get(1)));
						sec_year=Double.parseDouble(Helper.correctDouble((String)arrMaster.get(2)));
						thrd_year=Double.parseDouble(Helper.correctDouble((String)arrMaster.get(3)));
						fourth_year=Double.parseDouble(Helper.correctDouble((String)arrMaster.get(4)));
						fifth_year=Double.parseDouble(Helper.correctDouble((String)arrMaster.get(5)));
						
						ph_expenses_value=Double.parseDouble(nf.format(((ph_expenses*total)/100.00)));
						frm_maintainance_value=Double.parseDouble(nf.format(((frm_maintainance*total)/100.00)));
						total_value=total+ph_expenses_value+frm_maintainance_value;
						sec_year_value=Double.parseDouble(nf.format((total_value*(sec_year/100.00))))+total_value;
						thrd_year_value=Double.parseDouble(nf.format((sec_year_value*(thrd_year/100.00))))+sec_year_value;
						fourth_year_value=Double.parseDouble(nf.format((thrd_year_value*(fourth_year/100.00))))+thrd_year_value;
						fifth_year_value=Double.parseDouble(nf.format((fourth_year_value*(fifth_year/100.00))))+fourth_year_value;
					}
				}
				
				%>
				
				<tr class="datagrid">
					<td width='39.60%' align='left' colspan="4">
					&nbsp;<%= nf.format(ph_expenses) %>% towards Post harvest / house hold expense / consumption 
					</td>
					<td align='right' width='10%'>
					<%=nf.format(ph_expenses_value)%>&nbsp;
					</td>
					<td width="10%">&nbsp;</td>
					<td width="10%">&nbsp;</td>
					<td width="10%">&nbsp;</td>
					<td width="10%">&nbsp;</td>
				</tr>
				<tr class="datagrid">
					<td align='left' colspan="4">
					&nbsp;<%=nf.format(frm_maintainance)%>% towards farm maintenance 
					</td>
					<td align='right'>
					<%=nf.format(frm_maintainance_value)%>&nbsp;
					</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr class="datagrid">
					<td align='left' colspan="4">
					&nbsp;Eligible Limit of Crop  Loan for the First year  
					</td>
					<td align='right'>
					<%=nf.format(total_value)%>&nbsp;
					</td>
					<td ><input type="text" name="txt_loan_jgsuds" size="15" onKeyPress="allowNumber(this)" maxlength="15" value="<%=nf.format(Double.parseDouble((Helper.correctDouble((String)hshValues.get("jgsud0")))))%>" style="text-align:right;height: 20px;" onBlur="roundtxt(this);"></td>
					<td ><input type="text" name="txt_loan_pcs" size="15" onKeyPress="allowNumber(this)" maxlength="15" value="<%=nf.format(Double.parseDouble((Helper.correctDouble((String)hshValues.get("pcsval0")))))%>" style="text-align:right;height: 20px;" onBlur="roundtxt(this);"></td>
					<td align="center"><input type="text" name="txt_elig_recomm" size="15" onKeyPress="allowNumber(this)" maxlength="15" value="<%=nf.format(Double.parseDouble((Helper.correctDouble((String)hshValues.get("recommval0")))))%>" style="text-align:right;height: 20px;" onBlur="roundtxt(this);"></td>
					<td align="center"><input type="text" name="txt_elig_sanc" size="15" onKeyPress="allowNumber(this)" maxlength="15" value="<%=nf.format(Double.parseDouble((Helper.correctDouble((String)hshValues.get("sancval0")))))%>" style="text-align:right;height: 20px;" onBlur="roundtxt(this);"></td>
					<input type="hidden" name="txt_elig_flag" value="0">
				</tr>
				<%if(strtenor>12){ %>
				<tr class="datagrid">
					<td align='left' colspan="4">
					&nbsp;Limit for the Second Year (<%=nf.format(sec_year)%>% on First Year Limit) 
					</td>
					<td align='right'>
					<%=nf.format(sec_year_value)%>&nbsp;
					</td>
					<td ><input type="text" name="txt_loan_jgsuds" size="15" onKeyPress="allowNumber(this)" maxlength="15" value="<%=nf.format(Double.parseDouble((Helper.correctDouble((String)hshValues.get("jgsud1")))))%>" style="text-align:right;height: 20px;" onBlur="roundtxt(this);"></td>
					<td ><input type="text" name="txt_loan_pcs" size="15" onKeyPress="allowNumber(this)" maxlength="15" value="<%=nf.format(Double.parseDouble((Helper.correctDouble((String)hshValues.get("pcsval1")))))%>" style="text-align:right;height: 20px;" onBlur="roundtxt(this);"></td>
					<td align="center"><input type="text" name="txt_elig_recomm" size="15" onKeyPress="allowNumber(this)" maxlength="15" value="<%=nf.format(Double.parseDouble((Helper.correctDouble((String)hshValues.get("recommval1")))))%>" style="text-align:right;height: 20px;" onBlur="roundtxt(this);"></td>
					<td align="center"><input type="text" name="txt_elig_sanc" size="15" onKeyPress="allowNumber(this)" maxlength="15" value="<%=nf.format(Double.parseDouble((Helper.correctDouble((String)hshValues.get("sancval1")))))%>" style="text-align:right;height: 20px;" onBlur="roundtxt(this);"></td>
					<input type="hidden" name="txt_elig_flag" value="1">
				</tr>
				<tr class="datagrid">
					<td align='left' colspan="4">
					&nbsp;Limit for the Third Year (<%=nf.format( thrd_year) %>% on Second Year Limit)
					</td>
					<td align='right'>
					<%=nf.format(thrd_year_value)%>&nbsp;
					</td>
					<td ><input type="text" name="txt_loan_jgsuds" size="15" onKeyPress="allowNumber(this)" maxlength="15" value="<%=nf.format(Double.parseDouble((Helper.correctDouble((String)hshValues.get("jgsud2")))))%>" style="text-align:right;height: 20px;" onBlur="roundtxt(this);"></td>
					<td ><input type="text" name="txt_loan_pcs" size="15" onKeyPress="allowNumber(this)" maxlength="15" value="<%=nf.format(Double.parseDouble((Helper.correctDouble((String)hshValues.get("pcsval2")))))%>" style="text-align:right;height: 20px;" onBlur="roundtxt(this);"></td>
					<td align="center"><input type="text" name="txt_elig_recomm" size="15" onKeyPress="allowNumber(this)" maxlength="15" value="<%=nf.format(Double.parseDouble((Helper.correctDouble((String)hshValues.get("recommval2")))))%>" style="text-align:right;height: 20px;" onBlur="roundtxt(this);"></td>
					<td align="center"><input type="text" name="txt_elig_sanc" size="15" onKeyPress="allowNumber(this)" maxlength="15" value="<%=nf.format(Double.parseDouble((Helper.correctDouble((String)hshValues.get("sancval2")))))%>" style="text-align:right;height: 20px;" onBlur="roundtxt(this);"></td>					
					<input type="hidden" name="txt_elig_flag" value="2">
				</tr>
				<tr class="datagrid">
					<td  align='left' colspan="4">
					&nbsp;Limit for the Fourth Year (<%=nf.format(fourth_year)%>% on Third Year Limit)    
					</td>
					<td align='right'>
					<%=nf.format(fourth_year_value)%>&nbsp;
					</td>
					<td ><input type="text" name="txt_loan_jgsuds" size="15" onKeyPress="allowNumber(this)" maxlength="15" value="<%=nf.format(Double.parseDouble((Helper.correctDouble((String)hshValues.get("jgsud3")))))%>" style="text-align:right;height: 20px;" onBlur="roundtxt(this);"></td>
					<td ><input type="text" name="txt_loan_pcs" size="15" onKeyPress="allowNumber(this)" maxlength="15" value="<%=nf.format(Double.parseDouble((Helper.correctDouble((String)hshValues.get("pcsval3")))))%>" style="text-align:right;height: 20px;" onBlur="roundtxt(this);"></td>
					<td align="center"><input type="text" name="txt_elig_recomm" size="15" onKeyPress="allowNumber(this)" maxlength="15" value="<%=nf.format(Double.parseDouble((Helper.correctDouble((String)hshValues.get("recommval3")))))%>" style="text-align:right;height: 20px;" onBlur="roundtxt(this);"></td>
					<td align="center"><input type="text" name="txt_elig_sanc" size="15" onKeyPress="allowNumber(this)" maxlength="15" value="<%=nf.format(Double.parseDouble((Helper.correctDouble((String)hshValues.get("sancval3")))))%>" style="text-align:right;height: 20px;" onBlur="roundtxt(this);"></td>
					<input type="hidden" name="txt_elig_flag" value="3">
				</tr>
				<tr class="datagrid">
					<td align='left' colspan="4">
					&nbsp;Limit for the Fifth Year (<%=nf.format(fifth_year)%>% on Fourth Year Limit) 
					</td>
					<td align='right'>
					<%=nf.format(fifth_year_value)%>&nbsp;
					</td>
					<td ><input type="text" name="txt_loan_jgsuds" size="15" onKeyPress="allowNumber(this)" maxlength="15" value="<%=nf.format(Double.parseDouble((Helper.correctDouble((String)hshValues.get("jgsud4")))))%>" style="text-align:right;height: 20px;" onBlur="roundtxt(this);"></td>
					<td ><input type="text" name="txt_loan_pcs" size="15" onKeyPress="allowNumber(this)" maxlength="15" value="<%=nf.format(Double.parseDouble((Helper.correctDouble((String)hshValues.get("pcsval4")))))%>" style="text-align:right;height: 20px;" onBlur="roundtxt(this);"></td>
					<td align="center"><input type="text" name="txt_elig_recomm" size="15" onKeyPress="allowNumber(this)" maxlength="15" value="<%=nf.format(Double.parseDouble((Helper.correctDouble((String)hshValues.get("recommval4")))))%>" style="text-align:right;height: 20px;" onBlur="roundtxt(this);"></td>
					<td align="center"><input type="text" name="txt_elig_sanc" size="15" onKeyPress="allowNumber(this)" maxlength="15" value="<%=nf.format(Double.parseDouble((Helper.correctDouble((String)hshValues.get("sancval4")))))%>" style="text-align:right;height: 20px;" onBlur="roundtxt(this);"></td>
					<input type="hidden" name="txt_elig_flag" value="4">
				</tr>
				<%}
					}
			%>
			
		</table>
		
		<table width="100%" border="0" cellspacing="1"  cellpadding="1" class="outertable" align="center" id="idothers">
			<tr class="dataheader">
				<td width="10%" align="center">Nature of Activity</td>
				<td width="9%" align="center">No. of Units</td>
				<td width="9%" align="center">Scale of Finance</td>
				<td width="10%" align="center">Limit as per <br> scale of finance</td>
				<td width="9.99%" align="center">Eligible limit</td>
			</tr>
			<%
			if(arrData!=null && arrData.size()>0) 
			{
				double total=0.0,limit_scaleoffin=0.0;
				for(int j=0;j<arrData.size();j++)
				{
					arrData1=(ArrayList)arrData.get(j);
					limit_scaleoffin+=Double.parseDouble((Helper.correctDouble((String)arrData1.get(9))));
				%>
					<tr class="datagrid">
						<td>&nbsp;<%=Helper.correctNull((String)arrData1.get(2))%>&nbsp;</td>
						<td align='right'><%=nf.format(Double.parseDouble((Helper.correctDouble((String)arrData1.get(15)))))%>&nbsp;</td>
						<td align='right'><%=nf.format(Double.parseDouble((Helper.correctDouble((String)arrData1.get(6)))))%>&nbsp;</td>
						<td align='right'><%=nf.format(Double.parseDouble((Helper.correctDouble((String)arrData1.get(7)))))%>&nbsp;</td>
						<td align='right'><%=nf.format(Double.parseDouble((Helper.correctDouble((String)arrData1.get(9)))))%>&nbsp;</td>
					</tr>
				<%
				}
				%>
				<tr class="datagrid">
					<td colspan="4" align='right'>
					<b>Total</b>
					</td>
					<td align='right'>
					<b><%=nf.format(limit_scaleoffin)%>&nbsp;</b>
					</td>
				</tr>
				<%} %>
				</table>
		
		</td>
	</tr>
</table>
<br>
<table width="40%" border="0" cellspacing="0"  cellpadding="3" class="outertable" align="center">
	<tr id="idcrop1">
	<td>
	<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Comments_Cancel" btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
	</td>
	</tr>
	<tr  id="idothers1" align="center">
	<td><input type="button" name="cmdclose1" value="Close" class="buttonClose" onclick="doClose();"></td>
	</tr>
</table>
<input type="hidden" name="hidAction"> <input type="hidden"
	name="hidBeanId"> <input type="hidden" name="hidBeanMethod"
	value=""> <input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidSourceUrl"> <input type="hidden"
	name="hidassesttype"> <input type="hidden" name="strappno"
	value="<%=Helper.correctNull(request.getParameter("appno"))%>">
<input type="hidden" name="hidvarid">
<input TYPE="hidden" name="pageval" value = "">
<input type="hidden" name="pagefrom"> 
<INPUT TYPE="hidden" name="strAssessment" value = "<%=request.getParameter("strAssessment")%>">
<INPUT TYPE="hidden" name="strschemeType" value = "<%=StrSchemeType%>">
<INPUT TYPE="hidden" name="hidAssessment" value = "<%=strAssessType%>">
   <input type="hidden" name="hidCommentPage" value="croploan">
</form>
</body>
</html>	
