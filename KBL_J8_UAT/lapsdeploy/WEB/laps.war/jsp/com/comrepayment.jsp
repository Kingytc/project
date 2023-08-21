<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			ArrayList vec = null;
			int vecsize = 0;

			if (hshValues != null) {
				vec = (ArrayList) hshValues.get("vecVal");
			}

			if (vec != null) {
				vecsize = vec.size();
			}
			String strBorrowerType = Helper.correctNull((String) request
					.getParameter("hidBorrowerType"));
			String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();

			%>
<html>
<head>
<title>Commercial</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var len="<%=vecsize%>";
function callClose()
{
	var cattype=document.forms[0].cattype.value;
	var id=document.forms[0].id.value;
 if((cattype=="ASSI")||(cattype=="ASBI"))
        {
       if(ConfirmMsg(100))
	 { 
		document.forms[0].action=appURL+"action/agrsearch.jsp?&id="+document.forms[0].id.value;
		document.forms[0].submit();
	 }
		}
		if((cattype=="SSI")||(cattype=="CORP"))
        {
        if(ConfirmMsg(100))
	 {
		document.forms[0].action=appURL+"action/comsearch.jsp?&id="+document.forms[0].id.value;
		document.forms[0].submit();
	 }
		}
}

function placeValues()
{	
		disableFields(true);
		//enableButtons(false,true,true,true);	
			
}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{

	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;

}

function disableFields(val)
	{
		
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
		
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			else if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			else if(document.forms[0].elements[i].type=="select-one")
			{
			  document.forms[0].elements[i].disabled=val;		  
			}

		}
	}
function doCancel()
{
	
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanGetMethod.value="getRepayData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comrepayment.jsp";
		document.forms[0].submit();
	 }
	
}
function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanMethod.value="updateinsData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comrepayment.jsp";
		document.forms[0].submit();
	 }
		
}
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true);
}
function doSave()
{
	var flag = validate();
	disableFields(false);
	if(flag )
	{
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanMethod.value="updateinsData";
		document.forms[0].hidBeanGetMethod.value="getRepayData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comrepayment.jsp";
		document.forms[0].submit();
		}

	else	
	{
			alert("Enter values in Name/Company Field");
	}
}


function  validate()
{ 
		var flag;	
		for (m=0;m<len;m++)
		{			
			if(document.forms[0].loan[m].value != "")
			{						
					return true ;			
			}
			else
					flag = false; 
		}		
return flag;

}

function callLink(page,bean,method)
{	
	if (document.forms[0].cmdsave.disabled)
	{
		if(page=="com_costofproject.jsp")
		{
			 document.forms[0].hidPageSource.value="COP";
		}
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
function callApplicantTab(page)
{ 
	if (document.forms[0].cmdapply.disabled)
	{   	

	  if(page=="company")
	  { 
		  document.forms[0].hidBeanGetMethod.value="getData";
		  document.forms[0].action=appURL+"action/comcompany.jsp";
	  }
	  if(page=="proposal")
	  {
		  document.forms[0].hidBeanGetMethod.value="getProposal";
		  document.forms[0].action=appURL+"action/comproposal.jsp";
	  }
	 	  	  if(page=="facilities")
	  {
		  document.forms[0].hidBeanMethod.value="getFacilityData";
		  document.forms[0].hidBeanId.value="facilities";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/facilities.jsp";
	  }

	  
		  document.forms[0].submit();
	 }
	else
	{
		ShowAlert(103);
	}
	
	
  }


var strvalue="corp_bankargreploan.htm";
function doHelp()     
{
  var hlpvar = appURL+"phlp/corp_bankargreploan.htm";
  var title = "RepaymentOfLoans";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onLoad="placeValues()">
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
<form name="frmpri" method="post" class="normal"> <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable"> 
<tr> <td valign="top" colSpan="5"><jsp:include
			page="../share/applurllinkscom.jsp" flush="true"> <jsp:param name="pageid" value="3" /> 
<jsp:param name="cattype" value="<%=strCategoryType%>" /> <jsp:param name="ssitype" value="<%=strSSIType%>" /> 
</jsp:include></td></tr> </table><table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable"> 

<%if(strSessionModuleType.equalsIgnoreCase("AGR")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr> 
 <td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; 
Banking Arrangement -&gt; Repayment of Existing Loans</td>
</tr>
</table>
<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr> 
 <td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; 
Banking Arrangement -&gt; Repayment of Existing Loans</td>
</tr>
</table>
<%} %>
<span style="display:none"><lapschoice:borrowertype /></span> 
<lapschoice:application /> <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable"> 
<tr> <td> <table border="0" cellspacing="2" cellpadding="3" align="left" class="outertable"  width="60%"> 
<tr align="center"> <% if (!strCategoryType.equals("STL")) {%> <td width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"> 
<b> <a href="#" onclick="javascript:callLink('com_operdet.jsp','comproposal','getBankingDetails')">Banking 
Arrangement </a> </b> </td><%} %>
<!-- <td width="15%" nowrap="nowrap"  align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:callLink('combanking.jsp','bankapp','getData')">Working 
Capital</a></b></td>-->
<td nowrap="nowrap" width="15%" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:callLink('combankingfi.jsp','bankappfi','getData')">Existing Facilities</a></b></td>
<td  nowrap="nowrap" width="15%" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankapp','getBankingdetailsData','com_bankingdetails.jsp')">Banking Details </a></b></td>
					<%if (strCategoryType.equals("CORP") || strCategoryType.equals("SME")) {

			%> <td width="15%" align="center" id="prin" nowrap class="sub_tab_active"><b>Repayment 
of Existing Loans</b></td><%}

			%> </tr> </table></td></tr> </table><table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1"> 
<tr> <td valign="top"> <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable"> 
<tr> <td valign="top"> <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable"> 
<tr> <td valign="top"> <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable"> 
<tr> <td> <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable"> 
<tr> <td> <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"> 
<tr align="center" class="dataheader"> <td width="5%">S.No</td><td width="22%">Bank's 
Name</td><td width="19%">Repayment Schedule</td><td width="15%">Commencing From</td><td width="20%">Repayment 
upto</td><td width="20%">Whether rescheduled</td><td width="24%">Remarks</td></tr> 
<%ArrayList g1 = null;

			for (int l = 0; l < vecsize; l++) {

				int colSize = 0;

				if (l < vecsize) {
					g1 = (ArrayList) vec.get(l);

					if (g1 != null) {
						colSize = g1.size();
					}
				}

				if (colSize > 0) {

					%> <tr align="center"> <td width="5%"><%=l + 1%></td><td width="22%" ALIGN="LEFT">
<input type="hidden" name="loan" size="25" value="<%=Helper.correctNull((String)g1.get(0))%>" maxlength="49"><%=Helper.correctNull((String) g1.get(1))%> 
<input type="hidden" name="loan"></td><td width="19%"><textarea name="repay" cols="20" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"><%=Helper.correctNull((String) g1
											.get(3))%></textarea> 
<input type="hidden" name="repay" size="25"></td><td width="15%"><textarea name="from" cols="20" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"><%=Helper.correctNull((String) g1
											.get(4))%></textarea> 
<input type="hidden" name="from" size="25"></td><td width="20%"><textarea name="to" cols="20" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"><%=Helper.correctNull((String) g1
											.get(5))%></textarea> 
<input type="hidden" name="to" size="25"></td><td><%String sel = Helper.correctNull((String) g1.get(6));

					%> <select name="sel_reschedule"> <%if (sel.equalsIgnoreCase("yes")) {

					%> <option selected value="yes">Yes</option> 
<%} else {

					%> <option value="Yes">Yes</option> <%}

					%> <%if (sel.equalsIgnoreCase("No")) {

					%> <option selected value="no">No</option> 
<%} else {

					%> <option value="no">No</option> <%}

					%> </select> <input type="hidden" name="sel_reschedule"
													value=""></td><td width="24%"><textarea name="details" cols="25" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"><%=Helper.correctNull((String) g1
											.get(7))%></textarea> 
<input type="hidden" name="details" size="25"></td></tr> <%} else {

					%> <tr align="center"> <td width="5%"><%=l + 1%></td><td width="22%" ALIGN="LEFT"><input type="text" name="loan" size="25"
													maxlength="49"></td><td width="19%"><textarea name="repay" cols="20" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"></textarea> 
</td><td width="15%"><textarea name="from" cols="20" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"
													onBlur="checkDate(this)"></textarea></td><td width="20%"><textarea name="to" cols="20" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"></textarea></td><td><select name="sel_reschedule" size="2"> 
<option value="yes">Yes</option> <option value="no">No</option> </select></td><td width="24%"><textarea name="details" cols="25" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"></textarea> 
</td></tr> <%}
			}

			%> </table></td></tr> </table></td></tr> </table></td></tr> 
</table></td></tr> </table></td></tr> </table><br> <lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/> <INPUT TYPE="hidden" NAME="hidPageSource" VALUE=""> 
<INPUT TYPE="hidden" NAME="hidMethod" VALUE=""> <input type="hidden" name="hidappno" value="<%=request.getParameter("appno") %>"> 
</form>
</body>
</html>