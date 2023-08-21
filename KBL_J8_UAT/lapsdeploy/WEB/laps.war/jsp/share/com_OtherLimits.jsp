<%@include file="../share/directives.jsp"%>
<%@ page import="com.sai.laps.helper.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
%>
<%ArrayList vecRow = new ArrayList();
ArrayList vecCol= new ArrayList();

if(hshValues!=null)
{
vecRow = (ArrayList) hshValues.get("vecRow");
}
String strappno = Helper.correctNull((String) request
		.getParameter("appno"));
%>
<html>
<head>
<title>Other Limits</title>


<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varOrgLevel="<%=strOrgLevel%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";

var strCOM_PAGETYPE = "<%=Helper.correctNull((String) hshValues.get("COM_PAGETYPE"))%>";
 
var appstatus = "<%=Helper.correctNull((String)request.getParameter("status"))%>";

var currentdate= "<%=Helper.getCurrentDateTime()%>";

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
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons(true,true,false,false,false,true);
	document.forms[0].sel_date1.disabled = true; 
	
}

function doSave()
{	
	if(document.forms[0].sel_date1.value=="0")
	{
		alert("Select the Year");
		document.forms[0].sel_date1.focus();	
		return;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].sel_date1.disabled = false; 
	document.forms[0].sel_nonfund.disabled=false;
	document.forms[0].hidBeanId.value="compro";		
	document.forms[0].hidSourceUrl.value="/action/com_OtherLimits.jsp";
	document.forms[0].hidBeanMethod.value="updateOtherLimits";
	document.forms[0].hidBeanGetMethod.value="getOtherLimits";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doDelete()
{
	document.forms[0].sel_nonfund.disabled=false;
		if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value ="delete";
			document.forms[0].hidBeanMethod.value="updateOtherLimits";
			document.forms[0].hidBeanGetMethod.value="getOtherLimits";	
			document.forms[0].hidBeanId.value="compro";
			document.forms[0].hidSourceUrl.value="action/com_OtherLimits.jsp";	
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
		document.forms[0].hidBeanGetMethod.value="getOtherLimits";
		document.forms[0].action=appURL+"action/com_OtherLimits.jsp";
		
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
	document.forms[0].hidBeanGetMethod.value="getOtherLimits";		
	document.forms[0].action=appURL+"action/"+"com_OtherLimits.jsp?type="+vartype;
	document.forms[0].submit();
}

function checkYear()
{
	<%
	if (vecRow != null && vecRow.size() > 0) {
		if (vecRow.size() > 0) {
			for (int i = 0; i < vecRow.size(); i++) {
				vecCol = (ArrayList) vecRow.get(i);
			String yearslno= Helper.correctNull((String) vecCol.get(5));
	%>
		var yearslno="<%=yearslno %>";	

		var selYear=document.forms[0].sel_date1.value; 

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

function selectValues(val1,val2,val3,val4,val5)
{
	
	document.forms[0].hidsno.value=val1;
	document.forms[0].txt_lcdpno.value=val2;
	
	document.forms[0].txt_lcdpamt.value=val3;
	document.forms[0].txt_Comments.value=val4;
	document.forms[0].sel_date1.value=val5;

	if(document.forms[0].btnenable.value=="Y")
	{
		enableButtons(true,false,true,false,true,false);	
	}	
	document.forms[0].sel_nonfund.disabled=true;
	
}


</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url=""><script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>
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
	}
%>
<table border="0" cellspacing="1" cellpadding="3" width="90%"
	class="outertable">
	<tr>

		<td class="sub_tab_inactive" align="center"><b> <a href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getOthersDetails','com_others.jsp')"
			onMouseOut="window.status='';return true;">Business Operation</a> </b></td>
		<td class="sub_tab_inactive" align="center"><b> <a href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','facilities','getComments','com_termloancomments.jsp?hidPage=term')"
			onMouseOut="window.status='';return true;">Term Loan</a> </b></td>
		<td class="sub_tab_inactive" align="center"><b> <a href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getOdCcLimits','facilityremdforbusiess.jsp')"
			onMouseOut="window.status='';return true;">Conduct of Working
		Capital Facilities</a> </b></td>
		<td class="sub_tab_inactive" align="center"><b> <a href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','compro','getcom_nonfundloanlcdata','facilityremdforadverse.jsp')"
			onMouseOut="window.status='';return true;">Non Funded Loans</a> </b></td>
		<td class="sub_tab_active" align="center"><b>Others</b></td>
		<td class="sub_tab_inactive" align="center"><b> <a href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','compro','getFinancialComments','com_otherfaccomments.jsp?hidPage=otherfac')"
			onMouseOut="window.status='';return true;">Overall Comments</a> </b></td>

		<td class="sub_tab_inactive" align="center"><b> <a href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','facilities','getComments','comments_transaction.jsp?hidPage1=commentsTrans')"
			onMouseOut="window.status='';return true;">Comments on
		Transaction in the existing accounts</a> </b></td>
	</tr>
</table>
<br>
<table width="70%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">

			<tr>
				<td>Type</td>
				<td><select name="sel_nonfund" onchange="changetype()">
					<option value="">--select--</option>
					<option value="1" selected="selected">Import Collection
					Bills</option>
					<option value="2">Goods Loan</option>
					<option value="3">Ware house Receipt Loan</option>
					<option value="4">Cheque Discounted</option>
					<option value="5">Inland Bills Discounted</option>
				</select></td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<table width="70%" border="0" cellspacing="0" cellpadding="3"
	class="outertable border1" align="center" id="hidlc">
	<tr>
		<td colspan="3">
		<table width="100%" border="0" cellspacing="1" cellpadding="2"
			class="outertable" align="center">
			<tr>
				<td>Select the year<span class="mantatory">*</span> <select
					name="sel_date1" onchange="checkYear()">
					<option value="0">--select--</option>
					<laps:AgrFinancialYear appno="<%=strappno%>" page="" />
				</select></td>
			</tr>
			<tr class="dataheader">
				<td width="15%">&nbsp;</td>
				<td width="10%">No</td>
				<td width="10%">Amount</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><input type="text" name="txt_lcdpno" size="10"
					maxlength="10" onkeypress="allowInteger()"
					style="text-align: right;"></td>
				<td><input type="text" name="txt_lcdpamt" size="15"
					maxlength="15" onkeypress="allowDecimals(this)"
					onblur="roundtxt(this)" style="text-align: right;"></td>

			</tr>


			<tr>
				<td>Comments</td>

				<td colspan="2"><textarea NAME="txt_Comments" COLS="40"
					ROWS="4"
					onKeyPress="notAllowSplChar();notAllowSplChar1(this); textlimit(this,3999)"
					onkeyup="notAllowSplChar();notAllowSplChar1(this);textlimit(this,3999)"
					onkeydown="notAllowSplChar();notAllowSplChar1(this)"></textarea></td>
			</tr>

		</table>
		</td>
	</tr>
</table>

<table width="70%" border="0" cellspacing="1" cellpadding="3"
	class="outertable" align="center">
	<tr>
		<td><lapschoice:combuttonnew
			btnnames='New_Edit_Save_Cancel_Delete'
			btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />

		</td>
	</tr>
</table>

<table width="70%" border="0" cellspacing="1" cellpadding="3"
	class="outertable" align="center" id="hidsbcl1">
	<tr class="dataheader" align="center">
		<td width="5%">&nbsp;</td>
		<td width="5%">S.No</td>
		<td width="45%">Descriptions</td>
		<td width="15%" nowrap="nowrap">No</td>
		<td width="15%" nowrap="nowrap">Amount</td>
	</tr>
</table>

<table width="70%" border="0" cellspacing="1" cellpadding="3"
	class="outertable" align="center">
	<tr class="dataheader">

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
			onClick="javascript:selectValues('<%=Helper.correctNull((String) vecCol.get(0))%>',
											'<%=Helper.correctNull((String) vecCol.get(2))%>',
											'<%=Helper.correctNull((String) vecCol.get(3))%>',
											'<%=Helper.replaceForJavaScriptString((String) vecCol.get(4))%>',
											'<%=Helper.correctNull((String) vecCol.get(5))%>')"></td>
		<td width="5%"><%=i+1 %></td>
		<%if(pagename.equalsIgnoreCase("1"))
					{
					pgtype="Import Collection bills";
					
					}
					else if(pagename.equalsIgnoreCase("2"))
					{
						pgtype="Goods Loan";
					}
					else if(pagename.equalsIgnoreCase("3"))
					{
						pgtype="Warehouse Receipt Loan";
					}
					else if(pagename.equalsIgnoreCase("4"))
					{
						pgtype="Cheques Discounted";
					}
					else if(pagename.equalsIgnoreCase("5"))
					{
						pgtype="Inland Bills Discounted";
					}
					else
					{
						pgtype="";
					}
					 %>
		<td width="45%"><%=pgtype%></td>
		<td width="15%" align="right"><%=Helper.checkDecimal((String) vecCol.get(2))%></td>
		<td width="15%" align="right"><%=Helper.checkDecimal((String) vecCol.get(3))%></td>
	</tr>
	<%}
												}else{
												
												%>
	<tr class="datagrid">
		<td colspan="5" align="center">No Data Found</td>
	</tr>
	<%} %>
</table>


<lapschoice:hiddentag pageid="<%=PageId%>" /> <input type="hidden"
	name="cattype" value="<%=strCategoryType%>"> <input
	type="hidden" name="ssitype" value="<%=strSSIType%>"> <input
	type="hidden" name="hidsno" value=""> <input type="hidden"
	name="busOperation_text" value=""></form>
</body>
</html>


