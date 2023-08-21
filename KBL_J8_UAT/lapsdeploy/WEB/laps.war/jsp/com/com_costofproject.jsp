<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			ArrayList vecOthers = null;
			vecOthers = (ArrayList) hshValues.get("vecOthers");
			ArrayList vecIncurred = new ArrayList();
			ArrayList vecTobeIncurred = new ArrayList();
			ArrayList vecTotal = new ArrayList();

			java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);
			String dblTotalCapital1 = "";
			String dblTotalCapital2 = "";
			String dblTotalCapital3 = "";
			String dblTotalCost1 = "";
			String dblTotalCost2 = "";
			String dblTotalCost3 = "";
			String dblTotal1 = "";
			String dblTotal2 = "";
			String dblTotal3 = "";

			int vecsize = 0;
			if (hshValues != null) {
				vecIncurred = (ArrayList) hshValues.get("vecIncurred");
				vecTobeIncurred = (ArrayList) hshValues.get("vecTobeIncurred");
				vecTotal = (ArrayList) hshValues.get("vecTotal");

				if (hshValues.size() > 0) {
					dblTotalCapital1 = jtn.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("dblTotalCapital1"))));
					dblTotalCapital2 = jtn.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("dblTotalCapital2"))));
					dblTotalCapital3 = jtn.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("dblTotalCapital3"))));
					dblTotalCost1 = jtn.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("dblTotalCost1"))));
					dblTotalCost2 = jtn.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("dblTotalCost2"))));
					dblTotalCost3 = jtn.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("dblTotalCost3"))));
					dblTotal1 = jtn.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("dblTotal1"))));
					dblTotal2 = jtn.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("dblTotal2"))));
					dblTotal3 = jtn.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("dblTotal3"))));
				}
			} else {
				hshValues = new HashMap();
			}
			if (vecIncurred != null) {
				vecsize = vecIncurred.size();
			}
			String strIncurred[] = new String[28];
			String strTobeIncurred[] = new String[28];
			String strTotal[] = new String[28];
			String strOthers[] = new String[28];

			if (vecsize == 0) {
				for (int i = 0; i < 28; i++) {
					strIncurred[i] = "";
					strTobeIncurred[i] = "";
					strTotal[i] = "";
					strOthers[i] = "";
				}
			} else {
				for (int i = 0; i < 28; i++) {
					strIncurred[i] = (jtn.format(Double.parseDouble((String) vecIncurred.get(i))));
					strTobeIncurred[i] = (jtn.format(Double.parseDouble((String) vecTobeIncurred.get(i))));
					strTotal[i] = (jtn.format(Double.parseDouble((String) vecTotal.get(i))));
					strOthers[i] = Helper.correctNull((String) vecOthers.get(i));
				}
			}
			String category = Helper.correctNull((String) request.getParameter("hidcatory"));
			String Valuesin = Helper.correctNull((String) request.getParameter("valuesin"));%>
<html>
<head>
<title>Commercial-Principal (s)</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
	<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function callLink(page,bean,method)
{	
	if (document.forms[0].cmdsave.disabled  )
	{
		document.forms[0].hidPageSource.value="";
			document.forms[0].hidAction.value="";
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

 function doSave()
 {
	 document.forms[0].cmdsave.disabled=true;
	 document.forms[0].hidBeanId.value="bankapp";
	 document.forms[0].hidBeanMethod.value="updateCostofData";
	 document.forms[0].hidBeanGetMethod.value="getCostofData";
	 document.forms[0].action="action/controllerservlet";
	 document.forms[0].hidSourceUrl.value="action/com_costofproject.jsp";	
	 document.forms[0].submit();
 }

  function disableCommandButtons(cmdEdit,cmdSave,cmdCancel,cmdDelete,cmdClose)
  {
	  document.forms[0].cmdedit.disabled=cmdEdit;
	  document.forms[0].cmdsave.disabled=cmdSave;
	  document.forms[0].cmdcancel.disabled=cmdCancel;
	  document.forms[0].cmddelete.disabled=cmdDelete;	
	  document.forms[0].cmdclose.disabled=cmdClose; 	
  }  
  function doEdit()
  { 
	disableCommandButtons(false,true,true,true,false);	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
	document.forms[0].txt_total1.readOnly=true;
	document.forms[0].txt_total2.readOnly=true;
	document.forms[0].txt_total3.readOnly=true;
	document.forms[0].txt_total12.readOnly=true;
	document.forms[0].txt_total13.readOnly=true;
	document.forms[0].txt_total14.readOnly=true;
	document.forms[0].txt_total122.readOnly=true;
	document.forms[0].txt_total123.readOnly=true;
	document.forms[0].txt_total124.readOnly=true;	
 }

  function doCancel()
  {
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="bankapp";
		 document.forms[0].hidBeanGetMethod.value="getCostofData";
		document.forms[0].action=appUrl+"action/com_costofproject.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
		 disableCommandButtons(true,false,false,false,true);
		 disableFields(true);
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
	  }	  
  }

  function doDelete()
  {
	  if(varRecordFlag=="Y")
		{
			if(ConfirmMsg(101))
			 {
				document.forms[0].hidAction.value ="delete";
				document.forms[0].hidBeanId.value="bankapp";
				 document.forms[0].hidBeanMethod.value="updateCostofData";
				 document.forms[0].hidBeanGetMethod.value="getCostofData";
				document.forms[0].action="action/controllerservlet";
				document.forms[0].hidSourceUrl.value="action/com_costofproject.jsp";
				document.forms[0].submit();
			 }
        }
      else
	  {
		ShowAlert(158);
	  }
 }
function doprint()
  {	
	   document.forms[0].hidPageSource.value="COP";
		var purl  = "<%=ApplicationParams.getAppUrl()%>action/costprint.jsp?hidBeanId=bankapp&&hidBeanGetMethod=getData&appno="+document.forms[0].appno.value+"&hidPageSource=COP";
		var prop = 'scrollbars=yes,menubar=yes,width=775,height=520';	
		var xpos = (screen.width - 775) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);	
  }
function onloading()
{	  
	 //disableCommandButtons(true,false,false,false,true);
	 disableFields(true);
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appUrl+"action/combstpge.jsp";
		document.forms[0].submit();
	}
}
function callTermAssesement(beanid,methodname,pagename,type)
{
		
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].flowtype.value=type;
		document.forms[0].submit();
	
}
function gototab(beanid,methodname,pagename,type)
{
		
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].flowtype.value=type;
		document.forms[0].submit();
	
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
<form name="frmpri" method="post" class="normal">
<%if (category.equalsIgnoreCase("bst")) {%> <lapstab:applurllinkbst
	pageid="3" category='<%=category%>' valuesin='<%=Valuesin%>' />
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Broad
		Terms of Proposal -&gt; Cost of the project</td>
	</tr>
</table>
<lapschoice:BST /> <%} else {%>
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
Proposal -&gt; Financial Analysis -&gt; Assessment -&gt; Term Loan
Assessment -&gt; Cost of Project</span><br>
<span style="display: none;"><lapschoice:borrowertype /></span> <lapschoice:application />
<%}%> <%if (!(category.equalsIgnoreCase("bst"))) { %> <jsp:include page="../com/com_commentstab.jsp"
	flush="true">
	<jsp:param name="tabid" value="3" />
</jsp:include>
<table width="95%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="40%" border="0" cellspacing="1" cellpadding="3"
			class="outertable">
			<tr align="center">
				<td class="sub_tab_active"><b>Cost of Project</b></td>
				<td class="sub_tab_inactive"><a
					href="javascript:callTermAssesement('comproposal','getSourceOfMargin','com_contlimitcomment.jsp','3')"><b>Term
				loan assessment</b></a></td>
				<td class="sub_tab_inactive"><a
					href="javascript:gotoTab(appUrl,'comrepayschedule','getTermFinanceFac','com_fac_repayment.jsp')"><b>Repayment
				Schedule</b></a></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%}%>
<table width="100%" border="0" cellspacing="0" cellpadding="5"
	class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="2"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td valign="top" colspan="3">
								<table width="100%" border="0" cellspacing="0" cellpadding="5"
									class="outertable linebor">
									<tr>
										<td width="33%"><b>Cost of Project and Source of
										Finance</b></td>
										<td width="28%">&nbsp;</td>
										<td width="23%">&nbsp;</td>
										<td width="16%">&nbsp;</td>
									</tr>
									<tr class="dataheader">
										<td width="33%">a) Cost of Project</td>
										<td width="28%" align="center">Already incurred in Lacs</td>
										<td width="23%" align="center">To be incurred</td>
										<td width="16%" align="center">Total</td>
									</tr>
									<tr class="datagrid">
										<td width="33%"><input type="hidden" name="rowid1"
											value="1">Land</td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred1" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[0]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred1" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[0]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[0]%>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td width="33%"><input type="hidden" name="rowid2"
											value="2"> Site Development</td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred2" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[1]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred2" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[1]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[1]%>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td width="33%"><input type="hidden" name="rowid3"
											value="3">Buildings</td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred3" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[2]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred3" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[2]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[2]%>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td width="33%">Plant and Machinery (incl. Stores and
										Spares)</td>
										<td width="28%">&nbsp;</td>
										<td width="23%">&nbsp;</td>
										<td width="16%" align="right">&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td width="33%">
										<blockquote><input type="hidden" name="rowid4"
											value="4"> Imported CIF</blockquote>
										</td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred4" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[3]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred4" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[3]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[3]%>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td width="33%">
										<blockquote><input type="hidden" name="rowid5"
											value="5"> Import Duty</blockquote>
										</td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred5" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[4]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred5" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[4]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[4]%>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td width="33%">
										<blockquote><input type="hidden" name="rowid6"
											value="6"> Indigenous</blockquote>
										</td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred6" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[5]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred6" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[5]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[5]%>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td width="33%"><input type="hidden" name="rowid7"
											value="7"> Transportation Charges</td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred7" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[6]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred7" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[6]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[6]%>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td width="33%"><input type="hidden" name="rowid8"
											value="8"> Other Fixed Assests</td>

										<td width="28%" align="center"><input type="text"
											name="txt_incurred8" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[7]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred8" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[7]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[7]%>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td width="33%"><input type="hidden" name="rowid9"
											value="9"> Tech Knowhow, Engg. Fee and Expenses</td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred9" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[8]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred9" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[8]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[8]%>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td width="33%"><input type="hidden" name="rowid10"
											value="10"> Preliminary and pre-operative Expenses</td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred10" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[9]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred10" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[9]%>" maxlength="11"></td>

										<td width="16%" align="right"><%=strTotal[9]%>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td width="33%"><input type="hidden" name="rowid11"
											value="11"> <input type="text" name="others1"
											size="40" style="text-align: left" onKeyPress=""
											value="<%=strOthers[10]%>" maxlength="50"></td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred11" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[10]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred11" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[10]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[10]%>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td width="33%"><input type="hidden" name="rowid12"
											value="12"> <input type="text" name="others2"
											size="40" style="text-align: left" onKeyPress=""
											value="<%=strOthers[11]%>" maxlength="50"></td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred12" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[11]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred12" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[11]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[11]%>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td width="33%"><input type="hidden" name="rowid13"
											value="13"> <input type="text" name="others3"
											size="40" style="text-align: left" onKeyPress=""
											value="<%=strOthers[12]%>" maxlength="50"></td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred13" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[12]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred13" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[12]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[12]%>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td width="33%"><input type="hidden" name="rowid14"
											value="14"> <input type="text" name="others4"
											size="40" style="text-align: left" onKeyPress=""
											value="<%=strOthers[13]%>" maxlength="50"></td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred14" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[13]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred14" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[13]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[13]%>&nbsp;</td>
									</tr>

									<tr class="datagrid">
										<td width="33%"><input type="hidden" name="rowid15"
											value="15"> Provision for Contingencies Incl. Prices
										escalation etc.</td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred15" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[14]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred15" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[14]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[14]%>&nbsp;</td>
									</tr>
									<tr class="dataheader">
										<td width="33%"><b>Total Capital Cost of the Scheme</b></td>
										<td width="28%" align="center"><b> <input type="text"
											name="txt_total1" size="15" style="text-align: right;"
											onKeyPress="allowNumber(this)" value="<%=dblTotalCapital1%>"
											readOnly="readonly"> </b></td>
										<td width="23%" align="center"><b> <input type="text"
											name="txt_total2" size="15" style="text-align: right;"
											onKeyPress="allowNumber(this)" value="<%=dblTotalCapital2%>">
										</b></td>
										<td width="16%" align="right"><b> <input type="text"
											name="txt_total3" size="15" style="text-align: right;"
											onKeyPress="allowNumber(this)" value="<%=dblTotalCapital3%>">
										</b></td>
									</tr>
									<tr class="dataheader">
										<td width="33%"><b> <input type="hidden"
											name="rowid16" value="16"> Margin for Working capital
										</b></td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred16" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[15]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred16" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[15]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[15]%>&nbsp;</td>
									</tr>
									<tr class="dataheader">
										<td width="33%"><b>Total Cost of the Scheme</b></td>
										<td width="28%" align="center"><b> <input type="text"
											name="txt_total12" size="15" style="text-align: right;"
											onKeyPress="allowNumber(this)" value="<%=dblTotalCost1%>">
										</b></td>
										<td width="23%" align="center"><b> <input type="text"
											name="txt_total13" size="15" style="text-align: right;"
											onKeyPress="allowNumber(this)" value="<%=dblTotalCost2%>">
										</b></td>
										<td width="16%" align="right"><b> <input type="text"
											name="txt_total14" size="15" style="text-align: right;"
											onKeyPress="allowNumber(this)" value="<%=dblTotalCost3%>">
										</b></td>
									</tr>
									<tr>
										<td width="33%">&nbsp;</td>
										<td width="28%">&nbsp;</td>
										<td width="23%">&nbsp;</td>
										<td width="16%">&nbsp;</td>
									</tr>
									<tr class="dataheader">
										<td width="33%" align="center">b) Source of Finance <input
											type="hidden" name="rowid223" value="223"></td>
										<td width="28%" align="center">Already Tied Up</td>
										<td width="23%" align="center">To be Tied Up</td>
										<td width="16%" align="center">Total</td>
									</tr>
									<tr class="datagrid">
										<td width="33%"><input type="hidden" name="rowid17"
											value="17"> Equity</td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred17" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[16]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred17" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[16]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[16]%>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td width="33%"><input type="hidden" name="rowid18"
											value="18"> Promoters contribution</td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred18" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[17]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred18" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[17]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[17]%>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td width="33%"><input type="hidden" name="rowid19"
											value="19"> Loans</td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred19" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[18]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred19" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[18]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[18]%>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td width="33%"><input type="hidden" name="rowid20"
											value="20"> Borrowings from Promoters/ Directors.
										Friends and relatives</td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred20" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[19]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred20" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[19]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[19]%>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td width="33%"><input type="hidden" name="rowid21"
											value="21"> Internal Generation</td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred21" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[20]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred21" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[20]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[20]%>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td width="33%"><input type="hidden" name="rowid22"
											value="22"> Bonds / Debentures and others debt
										instruments</td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred22" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[21]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred22" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[21]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[21]%>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td width="33%"><input type="hidden" name="rowid23"
											value="23"> Deferred Credit from Suppliers/Bankers</td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred23" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[22]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred23" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[22]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[22]%>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td width="33%"><input type="hidden" name="rowid24"
											value="24"> Venture Capital</td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred24" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[23]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred24" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[23]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[23]%>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td width="33%"><input type="hidden" name="rowid25"
											value="25"> Other Sources (Pl. specify)</td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred25" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[24]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred25" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[24]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[24]%>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td width="33%"><input type="hidden" name="rowid26"
											value="26"> <input type="text" name="others5"
											size="40" style="text-align: left" onKeyPress=""
											value="<%=strOthers[25]%>" maxlength="50"></td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred26" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[25]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred26" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[25]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[25]%></td>
									</tr>
									<tr class="datagrid">
										<td width="33%"><input type="hidden" name="rowid27"
											value="27"> <input type="text" name="others6"
											size="40" style="text-align: left" onKeyPress=""
											value="<%=strOthers[26]%>" maxlength="50"></td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred27" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[26]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred27" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[26]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[26]%></td>
									</tr>
									<tr class="datagrid">
										<td width="33%"><input type="hidden" name="rowid28"
											value="28"> <input type="text" name="others7"
											size="40" style="text-align: left" onKeyPress=""
											value="<%=strOthers[27]%>" maxlength="50"></td>
										<td width="28%" align="center"><input type="text"
											name="txt_incurred28" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)" value="<%=strIncurred[27]%>"
											maxlength="11"></td>
										<td width="23%" align="center"><input type="text"
											name="txt_tobeincurred28" size="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											value="<%=strTobeIncurred[27]%>" maxlength="11"></td>
										<td width="16%" align="right"><%=strTotal[27]%></td>
									</tr>
									<tr class="dataheader">
										<td width="33%"><b>Total</b></td>
										<td width="28%" align="center"><input type="text"
											name="txt_total122" size="15" style="text-align: right;"
											onKeyPress="allowNumber(this)" value="<%=dblTotal1%>"></td>
										<td width="23%" align="center"><b> <input type="text"
											name="txt_total123" size="15" style="text-align: right;"
											onKeyPress="allowNumber(this)" value="<%=dblTotal2%>">
										</b></td>
										<td width="16%" align="right"><b> <input type="text"
											name="txt_total124" size="15" style="text-align: right;"
											onKeyPress="allowNumber(this)" value="<%=dblTotal3%>">
										</b></td>
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
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="hidflag" value=""> <input type="hidden" name="selsno"
	value=""> <input type="hidden" name="hidval"> <input
	type="hidden" name="hiddesc"> <INPUT TYPE="hidden"
	NAME="hidPageSource" VALUE="COP"> <input type="hidden"
	name="flowtype" /></form>
</body>
</html>
