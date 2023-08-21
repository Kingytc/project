<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<lapschoice:handleerror />
<%
HashMap hshValues1=new HashMap();
if(hshValues!=null)
{
	hshValues1=(HashMap)hshValues.get("hshFinanceDet");	
}
String strInitialLoad = Helper.correctNull((String) request.getParameter("initial"));
String applicantid = Helper.correctNull((String) hshValues.get("hidApplId"));
ArrayList arrCol = new ArrayList();
ArrayList arrRow = new ArrayList();

String strapptype = "";
String apptype = "";
String app_status = Helper.correctNull((String) hshValues.get("app_status"));
String PageType = Helper.correctNull((String)hshValues.get("PageType"));	
String prd_type = Helper.correctNull((String)session.getAttribute("strProductType"));

java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);

String strDosevalue=Helper.correctNull((String) session
		.getAttribute("strDose"));
String schemetype="";
schemetype = Helper.correctNull((String) request.getParameter("schemetype"));

String cattype = Helper.correctNull((String) request.getParameter("cattype"));
String applevel = Helper.correctNull((String) request.getParameter("applevel"));
//System.out.println("applevel==="+applevel);			
cattype = Helper.correctNull((String) request.getParameter("cattype1"));
if (cattype.equals(""))
{
	cattype = Helper.correctNull((String) session.getAttribute("cattype"));
}
String ssitype = (String) request.getParameter("ssitype");
if (ssitype.equalsIgnoreCase("")) {
	ssitype = Helper.correctNull((String) hshValues	.get("hidSSIType"));
}
String strType = Helper.correctNull((String) session.getAttribute("link"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();

double db1=0.00,db2=0.00,db3=0.00,db4=0.00,db5=0.00,db6=0.00,db7=0.00,db8=0.00,db9=0.00,db10=0.00,db11=0.00,db12=0.00,db13=0.00;
if(hshValues1!=null)
{
db1=FwHelper.parseDouble(Helper.correctDouble((String) hshValues1
		.get("cumsavings")));
db2=Double.parseDouble(Helper.correctDouble((String) hshValues1
		.get("outstandingloan")));
db3=Double.parseDouble(Helper.correctDouble((String) hshValues1
		.get("intcollected")));
db4=Double.parseDouble(Helper.correctDouble((String) hshValues1
		.get("cashinhand")));
db5=Double.parseDouble(Helper.correctDouble((String) hshValues1
		.get("rfa")));
db6=Double.parseDouble(Helper.correctDouble((String) hshValues1
		.get("savingsbal")));
db7=Double.parseDouble(Helper.correctDouble((String) hshValues1
		.get("fines")));
db8=Double.parseDouble(Helper.correctDouble((String) hshValues1
		.get("deposits")));
db9=Double.parseDouble(Helper.correctDouble((String) hshValues1
		.get("bankloan")));
db10=Double.parseDouble(Helper.correctDouble((String) hshValues1
		.get("otherexpenditure")));
db11=Double.parseDouble(Helper.correctDouble((String) hshValues1
		.get("sourcetotal")));
db12=Double.parseDouble(Helper.correctDouble((String) hshValues1
		.get("usetotal")));
db13=Double.parseDouble(Helper.correctDouble((String) hshValues1
		.get("difference")));
}


%>

<%@page import="com.sai.fw.management.utils.FwHelper"%><html>
<head>
<title>SHG - Category of SHG</title>
<style>
.divCellContainer {
	width: 100%;
	height: 100px;
	overflow: auto;
}
</style>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>

<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
	
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varschemetype="<%=schemetype%>";
function doSave()
{   
	disableCommonButtons(true, true, true, true, false);
	document.forms[0].hidBeanId.value="agrSHGloan";
	document.forms[0].hidSourceUrl.value="/action/agr_shgfinanceposition.jsp";
	document.forms[0].hidBeanMethod.value="updateSHGFinancePositionDetails";
	document.forms[0].hidBeanGetMethod.value="getSHGFinancePositionDetails";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function disableCommonButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function disabledFields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  

	}
	
}


function doEdit()
{
	disabledFields(false);
	document.forms[0].txt_totalA.readOnly=true;
	document.forms[0].txt_totalB.readOnly=true;
	document.forms[0].txt_difference.readOnly=true;
	document.forms[0].hidAction.value ="update";
	disableCommonButtons(true, false, false, true, false);	
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getSHGFinancePositionDetails";
		document.forms[0].hidBeanId.value="agrSHGloan";
		document.forms[0].action=appUrl+"action/agr_shgfinanceposition.jsp";
		document.forms[0].submit(); 		
	}
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanId.value="agrSHGloan";
		document.forms[0].hidSourceUrl.value="action/agr_shgfinanceposition.jsp";	
		document.forms[0].hidBeanMethod.value="updateSHGFinancePositionDetails";
		document.forms[0].hidBeanGetMethod.value="getSHGFinancePositionDetails";
		document.forms[0].submit();		
	}
}

function onloading()
{	  
	disabledFields(true);
	disableCommonButtons(false, true, true, false, false);
	//if(document.forms[0].hidMakerFlag.value=="Y")
	//{
	//	disableCommonButtons(false, true, true, false, false);	
	//}
	//else
	//{
	//	disableCommonButtons(true, true, true, true, false);	
	//}
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=varschemetype;
}

function computeTotalA()
{
	var Cumulative=	document.forms[0].txt_cumulativeSavings.value;
	var Interest=	document.forms[0].txt_interestCollected.value;
	var RFA_Matching=	document.forms[0].txt_RFA.value;
	var Fines=	document.forms[0].txt_fines.value;
	var Bank=	document.forms[0].txt_bankLoan.value;

	document.forms[0].txt_totalA.value = eval(Cumulative)+eval(Interest)+eval(RFA_Matching) +eval(Fines)+eval(Bank);
	document.forms[0].txt_difference.value = eval(document.forms[0].txt_totalA.value) - eval(document.forms[0].txt_totalB.value);
}

function computeTotalB()
{
	var outstanding=	document.forms[0].txt_outstandingLoans.value;
	var cashInHand=	document.forms[0].txt_cashInHand.value;
	var savingsBal=	document.forms[0].txt_savingsBal.value;
	var deposits=	document.forms[0].txt_deposits.value;
	var otherExpenditure=	document.forms[0].txt_otherExpenditure.value;

	document.forms[0].txt_totalB.value	=	eval(outstanding)+eval(cashInHand)+eval(savingsBal) + eval(deposits)+eval(otherExpenditure);
	document.forms[0].txt_difference.value	=eval(document.forms[0].txt_totalA.value) - eval(document.forms[0].txt_totalB.value);
}
function callOtherTab()
{
	if(document.forms[0].cmdEdit.disabled == true && document.forms[0].cmdApply.disabled != true)
	{
		ShowAlert(103);
	}
	else
	{
	  	document.forms[0].hidBeanId.value="agrSHGloan"; 
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrSHGotherfinancialposition.jsp?hidBeanGetMethod=getSHGOtherFinancePositionDetails";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
} 

function callLink(page)
{	
	 //document.forms[0].hidAction.value="";
	 document.forms[0].hidBeanGetMethod.value="getSHGCorpusDetails";
	document.forms[0].hidBeanId.value="agrSHGloan";
	 document.forms[0].action=appUrl+"action/"+page;
	 document.forms[0].submit();
}
--></script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
DIV.cellContainer {
	width: 100%;
	height: 250;
	overflow: auto;
}
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading()">
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
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="999" />
			<jsp:param name="cattype" value="<%=cattype%>" />
			<jsp:param name="ssitype" value="<%=ssitype%>" />
		</jsp:include></td>
	</tr>
</table>
<table>
	
	<tr>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Group Finance - &gt; Financial Position</td>
	</tr>
	
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="63" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>

<table width="98%" border="0" cellspacing="0" cellpadding="5"
	class="outertable border1" align="center" >

	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="3" cellpadding="3" class="outertable">
					<tr class="dataheader">
						<td nowrap colspan="2" align="center">Source Of Funds(A)</td>
						<td nowrap colspan="2" align="center">Use Of Funds(B)</td>
					</tr>
					<tr>
						<td nowrap>Cumulative Savings</td>
						<td nowrap><input type="text" name="txt_cumulativeSavings"
							size="20" tabindex="1" onKeyPress="allowNumber(this)"
							maxlength="15" style="text-align: right"
							value="<%=nf.format(db1)%>"
							onBlur="roundtxt(this);computeTotalA()"></td>
						<td nowrap>Outstanding Loans</td>
						<td nowrap><input type="text" name="txt_outstandingLoans"
							size="20" style="text-align: right" tabindex="6"
							onKeyPress="allowNumber(this)" maxlength="15"
							value="<%=nf.format(db2)%>"
							onBlur="roundtxt(this);computeTotalB()"></td>
					</tr>
					<tr>
						<td nowrap>Interest Collected</td>
						<td nowrap><input type="text" name="txt_interestCollected"
							size="20" style="text-align: right" tabindex="2"
							onKeyPress="allowNumber(this)" maxlength="15"
							value="<%=nf.format(db3)%>"
							onBlur="roundtxt(this);computeTotalA()"></td>
						<td nowrap>Cash in Hand</td>
						<td nowrap><input type="text" name="txt_cashInHand" size="20"
							style="text-align: right" tabindex="7"
							onKeyPress="allowNumber(this)" maxlength="15"
							value="<%=nf.format(db4)%>"
							onBlur="roundtxt(this);computeTotalB()"></td>
					</tr>
					<tr>
						<td nowrap>Revolving Fund</td>
						<td nowrap><input type="text" name="txt_RFA" size="20"
							style="text-align: right" tabindex="3"
							onKeyPress="allowNumber(this)" maxlength="15"
							value="<%=nf.format(db5)%>"
							onBlur="roundtxt(this);computeTotalA()"></td>
						<td nowrap>Savings A/c Balance</td>
						<td nowrap><input type="text" name="txt_savingsBal" size="20"
							style="text-align: right" tabindex="8"
							onKeyPress="allowNumber(this)" maxlength="15"
							value="<%=nf.format(db6)%>"
							onBlur="roundtxt(this);computeTotalB()"></td>
					</tr>
					<tr>
						<td nowrap>Fines &amp; Penalties</td>
						<td nowrap><input type="text" name="txt_fines" size="20"
							style="text-align: right" tabindex="4"
							onKeyPress="allowNumber(this)" maxlength="15"
							value="<%=nf.format(db7)%>"
							onBlur="roundtxt(this);computeTotalA()"></td>
						<td nowrap>Deposits, if any</td>
						<td nowrap><input type="text" name="txt_deposits" size="20"
							style="text-align: right" tabindex="9"
							onKeyPress="allowNumber(this)" maxlength="15"
							value="<%=nf.format(db8)%>"
							onBlur="roundtxt(this);computeTotalB()"></td>
					</tr>
					<tr>
						<td nowrap>Bank Loan, etc.</td>
						<td nowrap><input type="text" name="txt_bankLoan" size="20"
							style="text-align: right" tabindex="5"
							onKeyPress="allowNumber(this)" maxlength="15"
							value="<%=nf.format(db9)%>"
							onBlur="roundtxt(this);computeTotalA()"></td>
						<td nowrap>Other expenditures</td>
						<td nowrap><input type="text" name="txt_otherExpenditure"
							size="20" style="text-align: right" tabindex="10"
							onKeyPress="allowNumber(this)" maxlength="15"
							value="<%=nf.format(db10)%>"
							onBlur="roundtxt(this);computeTotalB()"></td>
					</tr>
					<tr>
						<td nowrap="nowrap"><B>Total (A)</B></td>
						<td nowrap><input type="text" name="txt_totalA" size="18"
							style="text-align: right;"
							onKeyPress="allowNumber(this)" maxlength="15"
							value="<%=nf.format(db11)%>"
							onBlur="roundtxt(this)"></td>
						<td nowrap>Total (B)</td>
						<td nowrap><input type="text" name="txt_totalB" size="18"
							style="text-align: right;"
							onKeyPress="allowNumber(this)" maxlength="15"
							value="<%=nf.format(db12)%>"
							onBlur="roundtxt(this)"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td><B> Difference between Sources &amp; Uses of Funds (A)
				- (B), if any: </B> <input type="text" name="txt_difference" size="25"
					style="text-align: right;"
					onKeyPress="allowNumber(this)" maxlength="15"
					value="<%=nf.format(db13)%>"
					onBlur="roundtxt(this)"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
 <input
	type="hidden" name="hidAction" value=""> <input type="hidden"
	name="hidBeanId" value=""> <input type="hidden"
	name="hidBeanMethod" value=""> <input type="hidden"
	name="hidBeanGetMethod" value=""> <input type="hidden"
	name="hidSourceUrl" value=""> <input type="hidden"
	name="hidApp_type" value="A"> <input type="hidden"
	name="selsno" value=""> <input type="hidden" name="page"
	value=""> <INPUT TYPE="hidden" name="trapEdit"
	value="<%=Helper.correctNull((String) hshValues.get("trapEdit"))%>">
<INPUT TYPE="hidden" name="hidEditMode"
	value="<%=Helper.correctNull((String) hshValues
									.get("hidEditMode"))%>">
<input type="hidden" name="hidCoDemoId"
	value="<%=request.getParameter("hidCoDemoId")%>"> <input
	type="hidden" name="hidDemoId"
	value="<%=request.getParameter("hidDemoId")%>"> <input
	type="hidden" name="hidAppType"
	value="<%=Helper.correctNull((String) hshValues.get("hidAppType"))%>">
<input type="hidden" name="hidGuaDemoId"
	value="<%=request.getParameter("hidGuaDemoId")%>"> <input
	type="hidden" name="hidpagetype" value="<%=PageType%>"> <input
	type="hidden" name="hidcroptype" value="PR">
	
	</form>
</body>
</html>

