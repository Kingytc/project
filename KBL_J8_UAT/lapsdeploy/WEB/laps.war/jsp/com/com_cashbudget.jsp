<%@include file="../share/directives.jsp"%>
<%
			ArrayList vecRow = (ArrayList) hshValues.get("vecData");
			ArrayList vecCol = null;%>
<html>
<head>
<title>Financial</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/com/finmain.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>	
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<Script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";

function callLink(page,bean,method)
{		
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appUrl+"action/"+page;
	 document.forms[0].submit();	
}

 function callApplicantTab(page)
  { 
   	  if(page=="company")
	  { 
		  document.forms[0].hidBeanGetMethod.value="getData";
		  document.forms[0].action=appUrl+"action/comcompany.jsp";
	  }
	  if(page=="proposal")
	  {
		  document.forms[0].hidBeanGetMethod.value="getProposal";
		  document.forms[0].action=appUrl+"action/comproposal.jsp";
	  }
	 
		  document.forms[0].submit();	
  }
  
function callLink12(page,method)
{	
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].action=appUrl+"action/"+page+"?pageval=RA";
	document.forms[0].submit();	 
}

function callCashFlow(page,flowtype)
{
	document.forms[0].action = appUrl+"action/"+page;
	document.forms[0].hidBeanId.value="comformula";
	document.forms[0].hidBeanGetMethod.value="GetCashFlowData";	
	document.forms[0].submit();	 
}

function ratingmodel()
{
	document.forms[0].hidBeanId.value="comratingana";
	document.forms[0].hidBeanGetMethod.value = "getRatingModel";
	document.forms[0].action=appUrl+"action/comratingmodel.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
function ratinganalysis()
{
	document.forms[0].hidBeanId.value="comratingana";
	document.forms[0].hidBeanGetMethod.value = "";
	document.forms[0].access.value = "B";
	document.forms[0].action=appUrl+"action/comratinganalysis.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function callTab(str)
{
  	document.forms[0].hidBeanId.value="comproposal";
    document.forms[0].hidBeanGetMethod.value = "getmpbf";
	document.forms[0].action = appUrl+"action/com_mpbf.jsp";
	document.forms[0].submit();
}  

function callAssessment()
{	
	document.forms[0].hidBeanId.value="combobassessment";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action = appUrl+"action/bobassessment.jsp?pageval=TO";
	document.forms[0].submit();
}

function doClose()
{
	    document.forms[0].action=appUrl+"action/comproposalsearch.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
}

function disableFields(one)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}		  		
	} 
	for(var j=0;j<12;j++)
	{
		document.forms[0].txt_totcashinflow[j].readOnly=true;
		document.forms[0].txt_totoutflow[j].readOnly=true;
		document.forms[0].txt_netflow[j].readOnly=true;
		document.forms[0].txt_closbal[j].readOnly=true;	
	}
	
}
function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled = bool5;
}


function placevalues()
{
	var appstatus="<%=session.getAttribute("appstatus")%>";
	if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
	{
	 	
	 	enableButtons(true,true,true,false);
	}
	else
	{
	enableButtons(false,true,true,true,false);
	disableFields(true);
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
		{	
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidSourceUrl.value="/action/com_cashbudget.jsp";
			document.forms[0].hidBeanId.value="comproposal";
			document.forms[0].hidBeanMethod.value="updateCashBudget";
			document.forms[0].hidBeanGetMethod.value="getCashBudget";
			document.forms[0].action=appUrl +"controllerservlet";
			document.forms[0].submit(); 
		}

}
function doCancel()
{

	if (ConfirmMsg(102))
	{
	document.forms[0].hidBeanGetMethod.value="getCashBudget";
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].action=appUrl+"action/com_cashbudget.jsp"
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

function doEdit()
{
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	enableButtons(true,false,false,false,false); 
	
}

function doSave()
{	
	enableButtons(true,true,true,false);
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateCashBudget";
	document.forms[0].hidBeanGetMethod.value="getCashBudget";
	document.forms[0].hidSourceUrl.value="/action/com_cashbudget.jsp"
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function IRBRating()
{
	document.forms[0].action="action/ramreports.jsp";
	document.forms[0].submit();
}

function callcashinflow()
{
	for(var i=0;i<12;i++)
	{
		var mainprd=document.forms[0].txt_mainprd[i].value;
		if(document.forms[0].txt_mainprd[i].value=="")
		{
			mainprd="0.00";
		}
		var subprd=document.forms[0].txt_subprd[i].value;
		if(document.forms[0].txt_subprd[i].value=="")
		{
			subprd="0.00";
		}
		var nonoperinc=document.forms[0].txt_nonoperinc[i].value;
		if(document.forms[0].txt_nonoperinc[i].value=="")
		{
			nonoperinc="0.00";
		}
		var others1=document.forms[0].txt_others1[i].value;
		if(document.forms[0].txt_others1[i].value=="")
		{
			others1="0.00";
		}
		var others2=document.forms[0].txt_others2[i].value;
		if(document.forms[0].txt_others2[i].value=="")
		{
			others2="0.00";
		}
		document.forms[0].txt_totcashinflow[i].value=NanNumber(eval(mainprd)+eval(subprd)+eval(nonoperinc)+eval(others1)+eval(others2));
	}
}
function callcashoutflow()
{
	for(var i=0;i<12;i++)
	{
		var purchase=document.forms[0].txt_purchase[i].value;
		if(document.forms[0].txt_purchase[i].value=="")
		{
			purchase="0.00";
		}
		var freight=document.forms[0].txt_freight[i].value;
		if(document.forms[0].txt_freight[i].value=="")
		{
			freight="0.00";
		}
		var travel=document.forms[0].txt_travel[i].value;
		if(document.forms[0].txt_travel[i].value=="")
		{
			travel="0.00";
		}
		var sal=document.forms[0].txt_sal[i].value;
		if(document.forms[0].txt_sal[i].value=="")
		{
			sal="0.00";
		}
		var miscexpenses=document.forms[0].txt_miscexpenses[i].value;
		if(document.forms[0].txt_miscexpenses[i].value=="")
		{
			miscexpenses="0.00";
		}
		var interest=document.forms[0].txt_interest[i].value;
		if(document.forms[0].txt_interest[i].value=="")
		{
			interest="0.00";
		}
		var others=document.forms[0].txt_others[i].value;
		if(document.forms[0].txt_others[i].value=="")
		{
			others="0.00";
		}
		document.forms[0].txt_totoutflow[i].value=NanNumber(eval(purchase)+eval(freight)+eval(travel)+eval(sal)+eval(miscexpenses)+eval(interest)+eval(others));
	}
}

function callnetinflow()
{
	for(var i=0;i<12;i++)
	{
		var totinflow=document.forms[0].txt_totcashinflow[i].value;
		if(document.forms[0].txt_totcashinflow[i].value=="")
		{
			totinflow="0.00";
		}
		var totoutflow=document.forms[0].txt_totoutflow[i].value;
		if(document.forms[0].txt_totoutflow[i].value=="")
		{
			totoutflow="0.00";
		}
		document.forms[0].txt_netflow[i].value=NanNumber(eval(totinflow)-eval(totoutflow));
	}
}
function callclosingbal()
{
	for(var i=0;i<12;i++)
	{
		var openingbal=document.forms[0].txt_openbal[i].value;
		if(document.forms[0].txt_openbal[i].value=="")
		{
			openingbal="0.00";
		}
		var netinflow=document.forms[0].txt_netflow[i].value;
		if(document.forms[0].txt_netflow[i].value=="")
		{
			netinflow="0.00";
		}
		document.forms[0].txt_closbal[i].value=NanNumber(eval(openingbal)+eval(netinflow));	
	}
}

function gototab(beanid,methodname,pagename,flowtype)
{
	document.forms[0].hidBeanId.value=beanid;
	document.forms[0].hidBeanGetMethod.value=methodname;
	document.forms[0].flowtype.value=flowtype;
	document.forms[0].action=appURL+"action/"+pagename;
	document.forms[0].submit();	
}
</script>
</head>
<body onload="placevalues()">
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
<form method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colSpan=5 height="16"><jsp:include
			page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="8" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<span class="page_flow">Home -&gt;
Commercial Proposal -&gt; Financial Analysis -&gt; Assessment -&gt;
Assessment of Working Capital Limits -&gt; Cash Budget Method</span><br>
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application />
<lapschoice:FinAnalysisTag tabid="5" />
<jsp:include page="../com/com_commentstab.jsp" flush="true">
							<jsp:param name="tabid" value="1" />
						</jsp:include>
<lapschoice:ComAssessmentTab subtabid="6" assessmenttype="CBM" />
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="30%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<tr align="center">
						<td class="sub_tab_active"><b>Working Capital Assessment</b></td>
						<td class="sub_tab_inactive"><b><a href="javascript:callTab('MPBF')">MPBF </a></b></td>
					</tr>
				</table>
				</td>
			</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable linebor">
							<tr class="dataheader">
								<td colspan="14" align="center"><b>Working Capital Assessment for Seasonal Industries</b></td>
							</tr>
							<tr class="dataheader">
								<td width="5%">Particulars</td>
								<td width="8%">&nbsp;</td>								
                        		<td width="7%">Apr</td>
								<td width="7%">May</td>
								<td width="7%">Jun</td>
								<td width="7%">Jul</td>
								<td width="7%">Aug</td>
								<td width="7%">Sep</td>
								<td width="7%">Oct</td>
								<td width="7%">Nov</td>
								<td width="7%">Dec</td>
								<td width="7%">Jan</td>
								<td width="7%">Feb</td>
								<td width="10%">Mar</td>
							</tr>
							<tr class="datagrid">
								<td width="5%"><b>&nbsp;</b></td>
								<td width="8%">&nbsp;</td>
							<%
							if (vecRow != null && vecRow.size()> 17) {
				

					for (int j = 0; j < 12; j++) {
						vecCol = (ArrayList) vecRow.get(17);

						%>
								<td width="7%"><input type="text" name="txt_year" size="5"
									maxlength="4"
									value='<%=Helper.correctNull((String)vecCol.get(j))%>'></td>
								<%}
			} else {
				for (int x = 0; x < 12; x++) {%>
								<td width="7%"><input type="text" name="txt_year" size="5"
									maxlength="4" value=""/></td>
								<%}
			}%>
							<tr class="datagrid">
								<td width="5%">&nbsp;</td>
								<td width="8%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="10%">&nbsp;</td>
							</tr>
							<tr class="dataheader">
								<td width="5%"><b>Opening Balance</b></td>
								<td width="8%">&nbsp;</td>
								<%if (vecRow != null && vecRow.size() > 0) {

				for (int i = 0; i < 1; i++) {
					for (int j = 0; j < 12; j++) {
						vecCol = (ArrayList) vecRow.get(i);

						%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_openbal" size="10"
									maxlength="10"
									value='<%=Helper.correctNull((String)vecCol.get(j))%>'
									onBlur="callnetinflow()" /></td>
								<%}
				}

			} else {
				for (int x = 0; x < 12; x++) {%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_openbal" size="10"
									maxlength="10" onBlur="callnetinflow()"/></td>
								<%}
			}%>
							</tr>
							<tr class="dataheader">
								<td width="5%"><b>Cash Inflow</b></td>
								<td width="8%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="10%">&nbsp;</td>
							</tr>
							<tr class="dataheader">
								<td width="5%">&nbsp;</td>
								<td width="8%">1.<strong> Sales Realisation</strong></td>

								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="10%">&nbsp;</td>
							</tr>
							<tr class="datagrid">
								<td width="5%">&nbsp;</td>
								<td width="8%">1.1 Main Products</td>
								<%if (vecRow != null && vecRow.size() > 0) {
				for (int i = 1; i < 2; i++) {

					for (int j = 0; j < 12; j++) {
						vecCol = (ArrayList) vecRow.get(i);

						%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_mainprd" size="10"
									maxlength="10"
									value='<%=Helper.correctNull((String)vecCol.get(j))%>'
									onBlur="callcashinflow();callnetinflow()"/></td>
								<%}
				}
			} else {
				for (int x = 0; x < 12; x++) {%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_mainprd" size="10"
									maxlength="10" onBlur="callcashinflow();callnetinflow()"/></td>
								<%}
			}%>
							</tr>
							<tr class="datagrid">
								<td width="5%">&nbsp;</td>
								<td width="8%">1.2 Sub- Products</td>
								<%if (vecRow != null && vecRow.size() > 0) {
				for (int i = 2; i < 3; i++) {

					for (int j = 0; j < 12; j++) {
						vecCol = (ArrayList) vecRow.get(i);

						%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_subprd" size="10"
									maxlength="10"
									value='<%=Helper.correctNull((String)vecCol.get(j))%>'
									onBlur="callcashinflow();callnetinflow()"/></td>
								<%}
				}
			} else {
				for (int x = 0; x < 12; x++) {%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_subprd" size="10"
									maxlength="10" onBlur="callcashinflow();callnetinflow()"/></td>
								<%}
			}%>

							</tr>
							<tr class="datagrid">
								<td width="5%">&nbsp;</td>
								<td width="8%">2. Non-operational Income</td>
								<%if (vecRow != null && vecRow.size() > 0) {
				for (int i = 3; i < 4; i++) {

					for (int j = 0; j < 12; j++) {
						vecCol = (ArrayList) vecRow.get(i);

						%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_nonoperinc" size="10"
									maxlength="10"
									value='<%=Helper.correctNull((String)vecCol.get(j))%>'
									onBlur="callcashinflow();callnetinflow()"/></td>
								<%}
				}
			} else {
				for (int x = 0; x < 12; x++) {%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_nonoperinc" size="10"
									maxlength="10" onBlur="callcashinflow();callnetinflow()"/></td>
								<%}
			}%>
							</tr>
							<tr class="datagrid">
								<td width="5%">&nbsp;</td>
								<td width="8%">3. Others-I</td>
								<%if (vecRow != null && vecRow.size() > 0) {
				for (int i = 4; i < 5; i++) {

					for (int j = 0; j < 12; j++) {
						vecCol = (ArrayList) vecRow.get(i);

						%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_others1" size="10"
									maxlength="10"
									value='<%=Helper.correctNull((String)vecCol.get(j))%>'
									onBlur="callcashinflow();callnetinflow()"/></td>
								<%}
				}

			} else {
				for (int x = 0; x < 12; x++) {%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_others1" size="10"
									maxlength="10" onBlur="callcashinflow();callnetinflow()"/></td>
								<%}
			}%>
							</tr>
							<tr class="datagrid">
								<td width="5%">&nbsp;</td>
								<td width="8%">4. Others-II</td>
								<%if (vecRow != null && vecRow.size() > 0) {
				for (int i = 5; i < 6; i++) {
					for (int j = 0; j < 12; j++) {
						vecCol = (ArrayList) vecRow.get(i);

						%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_others2" size="10"
									maxlength="10"
									value='<%=Helper.correctNull((String)vecCol.get(j))%>'
									onBlur="callcashoutflow()"/></td>
								<%}
				}
			} else {
				for (int x = 0; x < 12; x++) {%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_others2" size="10"
									maxlength="10" onBlur="callcashoutflow()"/></td>
								<%}
			}%>
							</tr>
							<tr class="dataheader">
								<td width="5%"><b>Total Cash Inflow</b></td>
								<td width="8%">&nbsp;</td>
								<%if (vecRow != null && vecRow.size() > 0) {
				for (int i = 6; i < 7; i++) {

					for (int j = 0; j < 12; j++) {
						vecCol = (ArrayList) vecRow.get(i);

						%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_totcashinflow"
									size="10" maxlength="10"
									value='<%=Helper.correctNull((String)vecCol.get(j))%>' /></td>
								<%}
				}
			} else {
				for (int x = 0; x < 12; x++) {%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_totcashinflow"
									size="10" maxlength="10" /></td>
								<%}
			}%>
							</tr>
							<tr class="datagrid">
								<td width="5%">&nbsp;</td>
								<td width="8%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="10%">&nbsp;</td>
							</tr>
							<tr class="dataheader">
								<td width="5%"><b>Cash Outflow</b></td>
								<td width="8%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="10%">&nbsp;</td>
							</tr>
							<tr class="datagrid">
								<td width="5%">&nbsp;</td>
								<td width="8%">1. Purchases</td>
								<%if (vecRow != null && vecRow.size() > 0) {
				for (int i = 7; i < 8; i++) {

					for (int j = 0; j < 12; j++) {
						vecCol = (ArrayList) vecRow.get(i);

						%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_purchase" size="10"
									maxlength="10"
									value='<%=Helper.correctNull((String)vecCol.get(j))%>'
									onBlur="callcashoutflow()"/></td>
								<%}
				}
			} else {
				for (int x = 0; x < 12; x++) {%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_purchase" size="10"
									maxlength="10"
									onBlur="callcashoutflow();callnetinflow();callclosingbal()" /></td>
								<%}
			}%>
							</tr>
							<tr class="datagrid">
								<td width="5%">&nbsp;</td>
								<td width="8%">2. Freight &amp; Forwarding Charges</td>
								<%if (vecRow != null && vecRow.size() > 0) {
				for (int i = 8; i < 9; i++) {

					for (int j = 0; j < 12; j++) {
						vecCol = (ArrayList) vecRow.get(i);

						%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_freight" size="10"
									maxlength="10"
									value='<%=Helper.correctNull((String)vecCol.get(j))%>'
									onBlur="callcashoutflow();callnetinflow()" /></td>
								<%}
				}
			} else {
				for (int x = 0; x < 12; x++) {%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_freight" size="10"
									maxlength="10"
									onBlur="callcashoutflow();callnetinflow();callclosingbal()" /></td>
								<%}
			}%>
							</tr>
							<tr class="datagrid">
								<td width="5%">&nbsp;</td>
								<td width="8%">3. Travelling</td>
								<%if (vecRow != null && vecRow.size() > 0) {
				for (int i = 9; i < 10; i++) {

					for (int j = 0; j < 12; j++) {
						vecCol = (ArrayList) vecRow.get(i);

						%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_travel" size="10"
									maxlength="10"
									value='<%=Helper.correctNull((String)vecCol.get(j))%>'
									onBlur="callcashoutflow();callnetinflow()" /></td>
								<%}
				}
			} else {
				for (int x = 0; x < 12; x++) {%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_travel" size="10"
									maxlength="10"
									onBlur="callcashoutflow();callnetinflow();callclosingbal()" /></td>
								<%}
			}%>
							</tr>
							<tr class="datagrid">
								<td width="5%">&nbsp;</td>
								<td width="8%">4. Salary</td>
								<%if (vecRow != null && vecRow.size() > 0) {
				for (int i = 10; i < 11; i++) {

					for (int j = 0; j < 12; j++) {
						vecCol = (ArrayList) vecRow.get(i);

						%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_sal" size="10"
									maxlength="10"
									value='<%=Helper.correctNull((String)vecCol.get(j))%>'
									onBlur="callcashoutflow();callnetinflow()" /></td>
								<%}
				}
			} else {
				for (int x = 0; x < 12; x++) {%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_sal" size="10"
									maxlength="10"
									onBlur="callcashoutflow();callnetinflow();callclosingbal()" /></td>
								<%}
			}%>
							</tr>
							<tr class="datagrid">
								<td width="5%">&nbsp;</td>
								<td width="8%">5. Misc. Expenses</td>
								<%if (vecRow != null && vecRow.size() > 0) {
				for (int i = 11; i < 12; i++) {

					for (int j = 0; j < 12; j++) {
						vecCol = (ArrayList) vecRow.get(i);

						%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_miscexpenses"
									size="10" maxlength="10"
									value='<%=Helper.correctNull((String)vecCol.get(j))%>'
									onBlur="callcashoutflow();callnetinflow()" /></td>
								<%}
				}
			} else {
				for (int x = 0; x < 12; x++) {%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_miscexpenses"
									size="10" maxlength="10"
									onBlur="callcashoutflow();callnetinflow();callclosingbal()" /></td>
								<%}
			}%>
							</tr>
							<tr class="datagrid">
								<td width="5%">&nbsp;</td>
								<td width="8%">6. Interest</td>
								<%if (vecRow != null && vecRow.size() > 0) {
				for (int i = 12; i < 13; i++) {

					for (int j = 0; j < 12; j++) {
						vecCol = (ArrayList) vecRow.get(i);

						%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_interest" size="10"
									maxlength="10"
									value='<%=Helper.correctNull((String)vecCol.get(j))%>'
									onBlur="callcashoutflow();callnetinflow()" /></td>
								<%}
				}
			} else {
				for (int x = 0; x < 12; x++) {%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_interest" size="10"
									maxlength="10"
									onBlur="callcashoutflow();callnetinflow();callclosingbal()" /></td>
								<%}
			}%>
							</tr>
							<tr class="datagrid">
								<td width="5%">&nbsp;</td>
								<td width="8%">7. Others</td>
								<%if (vecRow != null && vecRow.size() > 0) {
				for (int i = 13; i < 14; i++) {

					for (int j = 0; j < 12; j++) {
						vecCol = (ArrayList) vecRow.get(i);

						%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_others" size="10"
									maxlength="10"
									value='<%=Helper.correctNull((String)vecCol.get(j))%>'
									onBlur="callcashoutflow();callnetinflow();callclosingbal()" /></td>
								<%}
				}
			} else {
				for (int x = 0; x < 12; x++) {%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_others" size="10"
									maxlength="10"
									onBlur="callcashoutflow();callnetinflow();callclosingbal()" /></td>
								<%}
			}%>
							</tr>
							<tr class="dataheader">
								<td width="5%"><b>Total Cash Outflow</b></td>
								<td width="8%">&nbsp;</td>
								<%if (vecRow != null && vecRow.size() > 0) {
				for (int i = 14; i < 15; i++) {

					for (int j = 0; j < 12; j++) {
						vecCol = (ArrayList) vecRow.get(i);

						%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_totoutflow" size="10"
									maxlength="10"
									value='<%=Helper.correctNull((String)vecCol.get(j))%>' /></td>
								<%}
				}
			} else {
				for (int x = 0; x < 12; x++) {%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_totoutflow" size="10"
									maxlength="10" /></td>
								<%}
			}%>

							</tr>
							<tr class="dataheader">
								<td width="5%"><b>Net Inflow</b></td>
								<td width="8%">&nbsp;</td>
								<%if (vecRow != null && vecRow.size() > 0) {
				for (int i = 15; i < 16; i++) {

					for (int j = 0; j < 12; j++) {
						vecCol = (ArrayList) vecRow.get(i);

						%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_netflow" size="10"
									maxlength="10"
									value='<%=Helper.correctNull((String)vecCol.get(j))%>'
									onBlur="callnetinflow()"/></td>
								<%}
				}
			} else {
				for (int x = 0; x < 12; x++) {%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_netflow" size="10"
									maxlength="10" onBlur="callnetinflow()"/></td>
								<%}
			}%>

							</tr>
							<tr class="dataheader">
								<td width="5%"><b>Closing Balance</b></td>
								<td width="8%">&nbsp;</td>
								<%if (vecRow != null && vecRow.size() > 0) {
				for (int i = 16; i < 17; i++) {

					for (int j = 0; j < 12; j++) {
						vecCol = (ArrayList) vecRow.get(i);

						%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_closbal" size="10"
									maxlength="10"
									value='<%=Helper.correctNull((String)vecCol.get(j))%>' /></td>
								<%}}
			} else {
				for (int x = 0; x < 12; x++) {%>
								<td width="7%"><lapschoice:CurrencyTag name="txt_closbal" size="10"
									maxlength="10" /></td>
								<%}}%>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
 <input type="hidden" name="flowtype"> 
 <input	type="hidden" name="yearfrom" value="1">
 </form>
</body>
</html>
