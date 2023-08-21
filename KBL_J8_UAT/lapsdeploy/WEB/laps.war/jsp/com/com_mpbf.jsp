<%@include file="../share/directives.jsp"%>
<%request.setAttribute("_cache_refresh", "true");%>
<%ArrayList vecRow = (ArrayList) hshValues.get("vecData");
			ArrayList vecCol = null;

			String strDesc = request.getParameter("pageval");
			double val1 = 0;
			int flag = 0;
			if (vecRow != null && vecRow.size() > 0) {
				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);
					if (vecCol != null) {
						for (int j = 11; j >= 0; j--) {
							double dblvalue =Math.abs(Double.parseDouble(Helper.correctDouble((String) vecCol.get(j))));
							if (dblvalue != 0) {
								flag = 1;
								if(val1<dblvalue)
									val1 = dblvalue;
							} else {
								flag = 0;
							}
						}
					}
				}
			}%>
<html>
<head>
<title>Financial</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "<%=ApplicationParams.getAppUrl()%>";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/com/finmain.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<Script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var stockmonth="<%=hshValues.get("com_mbpfstockmonth")%>";
var stockmonthfrom ="<%=hshValues.get("com_mbpfseasonfrom")%>";
var stockmonthto="<%=hshValues.get("com_mbpfseasonto")%>";

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
	document.forms[0].hidBeanGetMethod.value="getCashBudget";
	document.forms[0].action = appUrl+"action/com_cashbudget.jsp";
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

function enableButtons(bool1, bool2, bool3, bool4, bool5,bool6)
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
		enableButtons(false,true,true,true);
		disableFields(true);
		if(stockmonth!="null")
		{
			document.forms[0].selstockmonth.value=stockmonth;
		}
		else
		{
			document.forms[0].selstockmonth.value="S";
		}
				
		if(stockmonthfrom!="null")
		{
			document.forms[0].selmonthfrom.value=stockmonthfrom;
		}
		else
		{
			document.forms[0].selmonthfrom.value="S";
		}
		
		if(stockmonthto!="null")
		{
			document.forms[0].selmonthto.value=stockmonthto;
		}
		else
		{
			document.forms[0].selmonthto.value="S";
		}		
	}	
}

function doDelete()
{
	if(ConfirmMsg(101))
		{	
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidSourceUrl.value="/action/com_mpbf.jsp";
			document.forms[0].hidBeanId.value="comproposal";
			document.forms[0].hidBeanMethod.value="updatempbf";
			document.forms[0].hidBeanGetMethod.value="getmpbf";
			document.forms[0].action=appURL +"controllerservlet";
			document.forms[0].submit(); 
		}
}

function doCancel()
{
	if (ConfirmMsg(102))
	{
	document.forms[0].hidSourceUrl.value="/action/com_mpbf.jsp"
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanGetMethod.value="getmpbf";
	document.forms[0].hidBeanMethod.value="getmpbf";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	}
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
}

function disableFields(one)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}	  
		document.forms[0].txt_drawpower.readOnly=true;
		document.forms[0].txt_workcap.readOnly=true;
		document.forms[0].txt_pertonn.readOnly=true;
		document.forms[0].txt_peakvalue.readOnly=true;		
	} 	
}

function doEdit()
{
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	enableButtons(true,false,false,false,true,false); 
}

function doSave()
{	
	if(document.forms[0].selstockmonth.value=="S")
	 {
		alert("select Month of Stock");
		document.forms[0].selstockmonth.focus();
		return;
	 }
	 if(document.forms[0].selmonthfrom.value=="S")
	 {
		alert("select seasonal from month");
		document.forms[0].selmonthfrom.focus();
		return;
	 }
	 if(document.forms[0].selmonthto.value=="S")
	 {
		alert("select seasonal to month");
		document.forms[0].selmonthto.focus();
		return;
	 }
	 document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updatempbf";
	document.forms[0].hidBeanGetMethod.value="getmpbf";
	document.forms[0].hidSourceUrl.value="/action/com_mpbf.jsp"
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function IRBRating()
{
	document.forms[0].action="action/ramreports.jsp";
	document.forms[0].submit();
}
function callpertonn()
{
		var tottonn=document.forms[0].txt_tottonnes.value;
		if(document.forms[0].txt_tottonnes.value=="")
		{
			tottonn="0.00";
		}
		var tottonnrupees=document.forms[0].txt_tonnesvalue.value;
		if(document.forms[0].txt_tonnesvalue.value!="")
		{
			document.forms[0].txt_pertonn.value=NanNumber(eval(tottonn)*eval(tottonnrupees));
			roundtxt(document.forms[0].txt_pertonn);
		}
		else
		{
			document.forms[0].txt_pertonn.value="0.0"
		}		
}
function calldrawingpower()
{
	var pertonn=document.forms[0].txt_pertonn.value;
	var sundry=document.forms[0].txt_sundry.value;
	if(document.forms[0].txt_sundry.value=="")
	{
		sundry="0.00";
	}
	var margin=document.forms[0].txt_marginvalue.value;
	if(document.forms[0].txt_marginvalue.value=="")
	{
		margin="0.00";
	}
	document.forms[0].txt_drawpower.value=NanNumber(eval(pertonn)-eval(sundry)-eval(margin));
	roundtxt(document.forms[0].txt_drawpower);
	wcRecommended();	
}
function wcRecommended()
{	
	var closbal="<%=val1%>";
	var drawingpow=document.forms[0].txt_drawpower.value;	
	if(document.forms[0].txt_drawpower.value=="")
	{
		drawingpow="0.00";
	}
	if(eval(closbal)<eval(drawingpow))
	{
		document.forms[0].txt_workcap.value=eval(closbal);
		roundtxt(document.forms[0].txt_workcap);
	}
	else
	{
		document.forms[0].txt_workcap.value=eval(drawingpow);
		roundtxt(document.forms[0].txt_workcap);
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
<br>
<span class="page_flow">Home -&gt;
Commercial Proposal -&gt; Financial Analysis -&gt; Assessment -&gt;
Assessment of Working Capital Limits -&gt;Cash Budget Method</span><br>
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
						<td class="sub_tab_inactive"><a href="javascript:callTab('wcassessment')"><b>Working Capital Assessment</b></a></td>
						<td class="sub_tab_active">MPBF</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="79%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
					<tr>
						<td valign="top">
						<table width="95%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable linebor">
							<tr class="dataheader">
								<td colspan="3" align="center"><b>Calculation of MPBF</b></td>
							</tr>
							<tr class="datagrid">
								<td colspan="3" >Peak Level Cash Deficit is<input
									type="text" name="txt_cshdeficit" size="10" maxlength="7"
									value="<%=Helper.correctNull((String)hshValues.get("com_mbpfcshdeficit")) %>"
									onKeyPress="allowNumber(this)" style="text-align:right">
								&nbsp;as of <input type="text" size="10" maxlength="7"
									name="txt_cshdeficitof"
									value="<%=Helper.correctNull((String)hshValues.get("com_mbpfcshdeficitof")) %>"
									style="text-align:left"> and Peak Build up of stock is in month
								of <select name="selstockmonth">
									<option value="S" selected>&lt;--Select --&gt;</option>
									<option value="1">Jan</option>
									<option value="2">Feb</option>
									<option value="3">Mar</option>
									<option value="4">Apr</option>
									<option value="5">May</option>
									<option value="6">Jun</option>
									<option value="7">Jul</option>
									<option value="8">Aug</option>
									<option value="9">Sep</option>
									<option value="10">Oct</option>
									<option value="11">Nov</option>
									<option value="12">Dec</option>
								</select></td>
							</tr>
							<tr class="dataheader">
								<td colspan="3"><b>Drawing Power on the Basis of
								Peak Build up of stock is as follows: </b></td>
							</tr>
							<tr class="datagrid">
								<td colspan="3">
								<p>Peak Level of Stock Build up during the season from <select
									name="selmonthfrom">
									<option value="S" selected>&lt;--Select --&gt;</option>
									<option value="1">Jan</option>
									<option value="2">Feb</option>
									<option value="3">Mar</option>
									<option value="4">Apr</option>
									<option value="5">May</option>
									<option value="6">Jun</option>
									<option value="7">Jul</option>
									<option value="8">Aug</option>
									<option value="9">Sep</option>
									<option value="10">Oct</option>
									<option value="11">Nov</option>
									<option value="12">Dec</option>
								</select> to <select name="selmonthto">
									<option value="S" selected>&lt;--Select --&gt;</option>
									<option value="1">Jan</option>
									<option value="2">Feb</option>
									<option value="3">Mar</option>
									<option value="4">Apr</option>
									<option value="5">May</option>
									<option value="6">Jun</option>
									<option value="7">Jul</option>
									<option value="8">Aug</option>
									<option value="9">Sep</option>
									<option value="10">Oct</option>
									<option value="11">Nov</option>
									<option value="12">Dec</option>
								</select> (Year) <input type="text" size="10"
									name="txt_mpbfyear" maxlength="4"
									onKeyPress="allowNumber(this)"
									value="<%=Helper.correctNull((String)hshValues.get("com_mbpfseasonyear"))%>">
								for <input type="text" size="10" name="txt_tottonnes"
									value="<%=Helper.correctNull((String)hshValues.get("com_mbpftotaltonnes")) %>"
									maxlength="7" onKeyPress="allowNumber(this)"
									style="text-align:right">Tonnes @ <b><%=ApplicationParams.getCurrency()%> in Lacs</b><laps:CurrencyTag
									size="10" maxlength="7" name="txt_tonnesvalue"
									onKeyPress="allowNumber(this)" style="text-align:right"
									value='<%=Helper.correctNull((String)hshValues.get("com_mbpftonnesrupees"))%>'
									onBlur='callpertonn();calldrawingpower()' />Per Tonn</p>
								</td>
							</tr>
							<tr class="datagrid">
								<td width="40%">Total Stock Holding</td>
								<td width="10%"><b><%=ApplicationParams.getCurrency()%> in Lacs</b></td>
								<td width="50%"><input type="text" size="10" maxlength="7"
									name="txt_pertonn"
									value="<%=Helper.correctNull((String)hshValues.get("com_mbpfpertonn")) %>"
									onKeyPress="allowNumber(this)" style="text-align:right"
									onblur="calldrawingpower()"></td>
							</tr>
							<tr class="datagrid">
								<td width="40%">Less : Sundry Creditors</td>
								<td width="10%"><b><%=ApplicationParams.getCurrency()%> in Lacs</b></td>
								<td width="50%"><input type="text" size="10" maxlength="7"
									name="txt_sundry" onKeyPress="allowNumber(this)"
									style="text-align:right"
									value="<%=Helper.correctNull((String)hshValues.get("com_mbpfsundry")) %>"
									onblur="calldrawingpower();wcRecommended()"
									onchange="calldrawingpower();wcRecommended()"></td>
							</tr>
							<tr class="datagrid">
								<td width="40%">Less: Margin on the above @ <input type="text"
									name="txt_marginper" size="10" maxlength="3"
									value="<%=Helper.correctNull((String)hshValues.get("com_mbpfmarginper")) %>"
									onKeyPress="allowNumber(this)" style="text-align:right"
									onblur="calldrawingpower()">%</td>
								<td width="10%"><b><%=ApplicationParams.getCurrency()%> in Lacs</b></td>
								<td width="50%"><input type="text" size="10" maxlength="7"
									name="txt_marginvalue"
									value="<%=Helper.correctNull((String)hshValues.get("com_mbpfmarginvalue")) %>"
									onKeyPress="allowNumber(this)" style="text-align:right"
									onblur="calldrawingpower()"></td>
							</tr>
							<tr class="datagrid">
								<td width="40%">Drawing Power for the Stock</td>
								<td width="10%"><b><%=ApplicationParams.getCurrency()%> in Lacs</b></td>
								<td width="50%"><input type="text" size="10" maxlength="7"
									name="txt_drawpower" onKeyPress="allowNumber(this)"
									style="text-align:right"
									value="<%=Helper.correctNull((String)hshValues.get("com_mbpfdp")) %>">
								</td>
							</tr>
							<tr class="datagrid">
								<td width="40%">Peak Value of Closing Balance</td>
								<td width="10%"><b><%=ApplicationParams.getCurrency()%> in Lacs</b></td>
								<td width="50%"><input type="text" size="10"
									maxlength="7" name="txt_peakvalue" onKeyPress="allowNumber(this)"
									style="text-align:right"
									value="<%=val1%>"></td>
							</tr>
							<tr class="datagrid">
								<td width="40%">Working Capital Eligible</td>
								<td width="10%"><b><%=ApplicationParams.getCurrency()%> in Lacs</b></td>
								<td width="50%"><input type="text" size="10"
									maxlength="7" name="txt_workcap" onKeyPress="allowNumber(this)"
									style="text-align:right"
									value="<%=Helper.correctNull((String)hshValues.get("com_mbpfwc")) %>"></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td width="60%" valign="top"><textarea
									name="txt_assessmentoflimit" cols="110" wrap="VIRTUAL"
									rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("com_limitassessmnent_comments"))%></textarea>
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
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="flowtype"> 
<input type="hidden" name="yearfrom" value="1">
	
</form>

<script language="javascript1.2">
editor_generate('txt_assessmentoflimit');
</script>
</body>
</html>
