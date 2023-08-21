<%@ include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%	String strType = Helper.correctNull(request.getParameter("hidval"));
	String strWrkflowtype = Helper.correctNull(request.getParameter("wrk_flowtype1"));
	if (strWrkflowtype.equals("")) {
		strWrkflowtype = "fixed";
	}
	ArrayList v = null;
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	if (strType.equalsIgnoreCase("show_terms") || strType.equalsIgnoreCase("update_terms")) 
	{
		v = (ArrayList) hshValues.get("vecVal");
	}
	int vecsize = 0;
	if (v != null) {
		vecsize = v.size();
	}
	String strmaxresttenure=Helper.correctNull((String) session.getAttribute("strmaxresttenure"));
	%>
<html>
<head>
<title>Setup(Products)</title>
<script>
var val = "<%=request.getParameter("hidval")%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var button;
var workid   = new Array();
var termfrom = new Array();
var termto   = new Array();
var termint  = new Array();
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var strtype= "<%=strType%>";
var varStaffPrd="<%=Helper.correctNull((String) hshValues.get("strStaffPrd"))%>";
var varRuleID="<%=Helper.correctNull((String) hshValues
								.get("ruleid"))%>";
function loadValues()
{
if(strtype == "update_terms" || strtype == "show_terms")
	{
	document.forms[0].amtfrom.value="<%=Helper.correctNull((String) hshValues.get("rangefrom"))%>";
	document.forms[0].amtto.value="<%=Helper.correctNull((String) hshValues.get("rangeto"))%>";
	document.forms[0].tenorfrom.value="<%=Helper.correctNull((String) hshValues.get("tenorfrom"))%>";
	document.forms[0].tenorto.value="<%=Helper.correctNull((String) hshValues.get("tenorto"))%>";
	document.forms[0].ruleid.value="<%=Helper.correctNull((String) hshValues
								.get("ruleid"))%>";
	document.forms[0].select_rule.value="<%=Helper.correctNull((String) hshValues
								.get("ruleid"))%>";
	document.forms[0].sel_inttype.value="<%=Helper.correctNull((String) hshValues
								.get("sel_inttype"))%>";
	document.forms[0].sel_inttype1.value="<%=Helper.correctNull((String) hshValues
								.get("sel_inttype1"))%>";
	enableButtons(true,false,true,true,false,true);
	getRangeValues();
	}
else
	{
	enableButtons(false,true,true,true,false,true);
	}
for(var i=0;i<document.forms[0].elements.length;i++)
	{
	if(document.forms[0].elements[i].type=="text")
		{
		document.forms[0].elements[i].readOnly=true;
		}	
	}

}
function loadUsedApp()
{
	if(document.forms[0].checkApp.value=="Yes")
	{
		document.forms[0].cmdnew.disabled=true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdclose.disabled=false;
		if(val=="existing")
			{
			ShowAlert(144);
			}
	}
	if(document.forms[0].wrk_flowtype1.value=="floating")
	{
		if((strtype == "show_terms" || strtype=="update_terms"))
		{
			enableButtons(true,false,true,true,false,true);
		}
		else
		{
			enableButtons(false,true,true,true,false,true);
		}
	}
}
function callFlowtype(type)
{
	if(!document.forms[0].cmdsave.disabled)
	{
		ShowAlert(103);
	}
	else
	{
		
		document.forms[0].wrk_flowtype1.value=type;
		document.forms[0].action=appUrl+"action/setintterms.jsp?wrk_flowtype1="+type+"&varStaffPrd="+varStaffPrd+"&hidBeanId=setproducts&hidBeanGetMethod=interestTerm";
		document.forms[0].submit();
	}
}
function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
	document.forms[0].cmddelete.disabled=bool6;
}
function doNew()
{
	if(document.forms[0].hidSpreadFlag.value=="Y")
	{
		alert("Spread Updation is pending");
		return;
	}
	varRecordFlag="N";
	changlbl('a');
}
function doEdit()
{
	if(document.forms[0].hidSpreadFlag.value=="Y")
	{
		alert("Spread Updation is pending");
		return;
	}
	changlbl('e');
}
function changlbl(par)
{
if(par =="a")
	{
	if(document.forms[0].sel_inttype.value=="")
	{
		alert("Select Interest Type");
		return;	
	}
	document.all.labelchange.innerText="";
	document.all.labelhelp.style.visibility="hidden";
	for(i=0;i<=4;i++)
		{
		document.forms[0].from[i].value="";
		document.forms[0].to[i].value="";	
		document.forms[0].txtcreditrskpremium[i].value="";
		document.forms[0].txtbustratpremium[i].value="";
		}
	document.forms[0].amtfrom.value="";
	document.forms[0].amtto.value="";
	document.forms[0].sel_inttype.disabled=true;
	button="a";
	enableButtons(true,true,false,false,true,true);
	}
else if(par=="e")
	{
		if(document.forms[0].select_rule.value == "")
		{
		alert("Select Interest Range");
		return;
		}
		button="e";
		enableButtons(true,true,false,false,true,false);
	}	
for(var i=0;i<document.forms[0].elements.length;i++)
	{
	if(document.forms[0].elements[i].type=="text")
		{
		document.forms[0].elements[i].readOnly=false;
		}
	}
document.forms[0].select_rule.disabled=false;
document.forms[0].prdCode.readOnly=true;
document.forms[0].prdType.readOnly=true;
document.forms[0].prdStatus.readOnly=true;
document.forms[0].prdCat.readOnly=true;
document.forms[0].prdSubCat.readOnly=true;
document.forms[0].prdRangeFrom.readOnly=true;
document.forms[0].prdRangeTo.readOnly=true;
document.forms[0].prdTerm.readOnly=true;
}
function doSave()
{
var flag = true;
if (document.forms[0].wrk_flowtype1.value == "" )
	{
	document.forms[0].wrk_flowtype1.value = "floating"
	}
if(parseFloat(document.forms[0].amtfrom.value) > parseFloat(document.forms[0].prdRangeTo.value) || parseFloat(document.forms[0].amtfrom.value) < parseFloat(document.forms[0].prdRangeFrom.value) )
	{
	alert("Amount Range Should Be Between Product Amount Range");
	return;
	}
if(parseFloat(document.forms[0].amtto.value) > parseFloat(document.forms[0].prdRangeTo.value) )
	{
	alert("Amount Range Should Be Between Product Amount Range");
	return;
	}
if(parseFloat(document.forms[0].amtto.value) <  parseFloat(document.forms[0].amtfrom.value))
	{
	alert("The From Range Should Be Less Than To Range For a Interest Range");
	return;
	}
	{
	if (document.all.labelhelp.style.visibility == "hidden")
		{
		if (document.forms[0].amtfrom.value != "" && document.forms[0].amtto.value != "")
			{
			work="<%=strWrkflowtype%>";
			if (work == "")
				{
				work="floating";
				}
			var flag="false";
			for(var i=0;i<document.forms[0].from.length;i++)
				{
				if(document.forms[0].from[i].value != "")
					{
					flag="true";
					if(parseFloat(document.forms[0].from[i].value) > parseFloat(document.forms[0].to[i].value))
						{
						alert("From Range should Be Lesser Than To Range");
						return ;
						}
					}
				if(document.forms[0].from[i].value != "" && document.forms[0].txtcreditrskpremium[i].value == "")
				{
					alert("Enter Credit Business  Premium Rate");
					return;
				}
				
				if(document.forms[0].from[i].value != "" && document.forms[0].txtbustratpremium[i].value == "")
				{
					if(document.forms[0].sel_inttype1.value=="O")
						alert("Enter Business Strategic Premium  Rate");
					else
						alert("Enter Fixed Spread  Rate");
					return;
				}

				if(flag=="false")
				{
					alert("Enter Range slab");
					return;
				}
				
				}
			document.forms[0].cmdsave.disabled = true;
			document.forms[0].sel_inttype.disabled=false;
			document.forms[0].hidRecordflag.value=varRecordFlag;
			document.forms[0].hidBeanId.value="setproducts";
			document.forms[0].hidval.value="insert_terms";
			document.forms[0].hidBeanMethod.value="getOtherinterestTerm";
			document.forms[0].hidSourceUrl.value="/action/setinterestrate.jsp";
			document.forms[0].action=appUrl+"controllerservlet?work="+work;
			document.forms[0].submit();
			}
		else
			{
			alert("Enter the range");
			}
	}
	if(document.all.labelhelp.style.visibility != "hidden")
	{
		if (document.forms[0].select_rule.value != "0")
		{
			if (document.forms[0].amtfrom.value != "" && document.forms[0].amtto.value != "" )
			{	
				
				for(var i=0;i<document.forms[0].from.length;i++)
					{

					if(document.forms[0].wrk_flowtype1.value=="floating" && document.forms[0].from[i].value != "" && document.forms[0].txtcreditrskpremium[i].value == "")
					{
						alert("Enter Credit Business  Premium Rate");
						document.forms[0].txtcreditrskpremium[i].focus();
						return;
					}
					
					if(document.forms[0].wrk_flowtype1.value=="floating" && document.forms[0].from[i].value != "" && document.forms[0].txtbustratpremium[i].value == "")
					{
						if(document.forms[0].sel_inttype1.value=="O")
							alert("Enter Business Strategic Premium  Rate");
						else
							alert("Enter Fixed Spread  Rate");
						document.forms[0].txtbustratpremium[i].focus();
						return;
					}
					
					}

				if(document.forms[0].amtfrom.value=="")
				{
					ShowAlert('121',"Amount Range From  ");
				 	return;
				}
				if(document.forms[0].amtto.value=="")
				{
					ShowAlert('121',"Amount Range TO  ");
				 	return;
				}
				if(document.forms[0].tenorfrom.value=="")
				{
					ShowAlert('121',"Tenor Range From");
				 	return;
				}
				if(document.forms[0].tenorto.value=="")
				{
					ShowAlert('121',"Tenor Range From");
				 	return;
				}
				document.forms[0].cmdsave.disabled = true;
				document.forms[0].hidRecordflag.value=varRecordFlag;
				document.forms[0].ruleid.value = document.forms[0].select_rule.value;
				work="<%=strWrkflowtype%>";
				document.forms[0].action=appUrl+"controllerservlet?work="+work;
				document.forms[0].hidBeanId.value="setproducts";
				document.forms[0].hidval.value="update_terms";
				document.forms[0].hidBeanMethod.value="getOtherinterestTerm";
				document.forms[0].hidSourceUrl.value="/action/setinterestrate.jsp";
				document.forms[0].submit();
			}
			else
			{
				alert("Enter The Range");					
			}
		}
		else
		{
			alert("Select a Rule To Update");
		}
	}
}
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(document.forms[0].select_rule.value==0)
		{
		  alert("Select the Interest Range");
		  return;
		}
		if(confirm("Do you really want to delete the Interest Range ?"))
		{
			document.forms[0].hidBeanId.value="setproducts";
			document.forms[0].method="post";
			document.forms[0].hidBeanMethod.value="deleteTerms";	
			document.forms[0].action=appUrl+"controllerservlet";		
			document.forms[0].hidSourceUrl.value="/action/setinterestrate.jsp";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert(158);
	}
}
function getvalues()
{
	if( document.forms[0].select_rule.value != "0")
	{
	document.forms[0].ruleid.value = document.forms[0].select_rule.value;
	var	id=document.forms[0].select_rule.options[document.forms[0].select_rule.selectedIndex].text;
	arr=id.split("---");
	document.forms[0].amtfrom.value=arr[0];
	document.forms[0].amtto.value=arr[1];
	document.forms[0].tenorfrom.value=arr[2];
	document.forms[0].tenorto.value=arr[3];
	work=document.forms[0].wrk_flowtype1.value;
	document.forms[0].action=appUrl+"action/setinterestrate.jsp?work="+work;
	document.forms[0].hidBeanId.value="setproducts";
	document.forms[0].hidBeanGetMethod.value="getOtherinterestTerm";
	document.forms[0].hidval.value="show_terms";
	document.forms[0].submit();
	}	
}


function doCancel()
{
	if (ConfirmMsg(102))
	{
		for(i=0;i<=4;i++)
		{
		  document.forms[0].from[i].value="";
		  document.forms[0].to[i].value="";	
		  document.forms[0].txtbustratpremium[i].value="";	
		  document.forms[0].txtcreditrskpremium[i].value="";	
		}
		document.forms[0].amtfrom.value="";
		document.forms[0].amtto.value="";
		document.forms[0].tenorfrom.value="";
		document.forms[0].tenorto.value="";
	    for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=true;
			}
		}
		document.all.labelchange.innerText="Select Interest Range";
		document.all.labelhelp.style.visibility="visible";
		varRuleID="";
		document.forms[0].select_rule.value="";
		document.forms[0].sel_inttype.value="";
		document.forms[0].sel_inttype.disabled=false;
		enableButtons(false,true,true,true,false,true);
	}
}
function callOtherTab(url)
{
	
	if(!document.forms[0].cmdsave.disabled)
	{
		ShowAlert(103);
	}
	else
	{
		 if(url=="setproducts.jsp" ||  url=="prodinterest.jsp" || url=="prodsanclimit.jsp")
		 {
			document.forms[0].hidBeanGetMethod.value="getData";
		 }
		 if(url=="setprdauth.jsp")
		 {
			 document.forms[0].hidBeanGetMethod.value="getAuthorityData";
		 }
		 
		 if(url=="setprddoc.jsp")
		 {
			 document.forms[0].hidBeanGetMethod.value="getDocData";
		 }

		 if(url=="setprdworkflow.jsp")
		 {
			 document.forms[0].hidBeanGetMethod.value="getWorkflowData";
		 }
	 document.forms[0].prd_code.value=document.forms[0].prdCode.value;
	 document.forms[0].action=appUrl+"action/"+url;
	 document.forms[0].submit();
	}
}
function checkPeriod(objName)
{
//var fixedto=document.forms[0].prdTerm.value;
var fixedto="<%=strmaxresttenure%>";
var userto=parseInt(objName.value);
if(userto > fixedto)
	{
	alert("Repayment Period should not be greater than Max. Repayment Period or Restructure Repayment period");
	objName.value = "";
	objName.focus();
	}
}
function doClose()
{
	 if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/setsearchproducts.jsp";
		 document.forms[0].submit();
	 }
}	
function getRangeValues()
{
	if(document.forms[0].sel_inttype1.value=="O")
	{
		document.all.idbsp.innerHTML="Business Strategic Premium";
	}
	else
	{
		document.all.idbsp.innerHTML="Fixed Spread";
	}
	document.all.ifrminterest.src=appUrl+"action/iframeinttypes.jsp?hidBeanGetMethod=getOtherinterestTypes&hidBeanId=setproducts&prdCode="+document.forms[0].prd_code.value+"&inttype="+document.forms[0].wrk_flowtype1.value+"&interestfor="+document.forms[0].sel_inttype.value+"&strRule="+varRuleID+"&strROIType="+document.forms[0].sel_inttype1.value;
}	
function clearfields()
{
	for(i=0;i<=8;i++)
	{
	  document.forms[0].from[i].value="";
	  document.forms[0].to[i].value="";	
	  document.forms[0].txtbustratpremium[i].value="";	
	  document.forms[0].txtcreditrskpremium[i].value="";	
	}
	document.forms[0].amtfrom.value="";
	document.forms[0].amtto.value="";
	document.forms[0].tenorfrom.value="";
	document.forms[0].tenorto.value="";
    for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].readOnly=true;
		}
	}
	document.all.labelchange.innerText="Select Interest Range";
	document.all.labelhelp.style.visibility="visible";
	varRuleID="";
	document.forms[0].select_rule.value="";
	enableButtons(false,true,true,true,false,true);
}
function clearreftype()
{
	document.forms[0].sel_inttype1.value="";
}
</script>
</head>
<body onLoad="loadValues();loadUsedApp()">
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
<form name="documentsfrm" method="post" class="normal">
<lapstab:setproductstab tabid="8" prdtype='<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>'/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Retail &amp; Agriculture Products -&gt; Products -&gt; Interest and Terms -&gt; Other Rates
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td colspan="4">
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td colspan="6">
								<fieldset>
								<table width="100%" border="0" cellspacing="0" cellpadding="3" 	class="outertable">
									<tr>
										<td><lapschoice:products /></td>
									</tr>
								</table>
								</fieldset>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td colspan="4">
						<table width="40%" border="0" cellspacing="1" cellpadding="3" class="outertable">
							<tr>
								<td align="center" class="sub_tab_inactive"> <a href="javascript:callFlowtype('fixed')">Fixed Rate</a></td>
								<td align="center" class="sub_tab_inactive"> <a href="javascript:callFlowtype('floating')">Floating Rate</a></td>
								<td align="center" class="sub_tab_active"> Other Rates</td>
							</tr>
						</table>
						<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
							<tr><td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
						<tr>
								<td width="15%">Interest type</td>
								<td width="85%"><select name=sel_inttype tabindex="1" onchange="clearfields();clearreftype();">
									<option value="">--------------Select--------------</option>
									<lapschoice:interesttype appmodule="P"  appvalue='<%=request.getParameter("prdCode")%>'/>
								</select></td>
							</tr>
							<tr>
								<td width="15%">Reference type</td>
								<td width="85%"><select name=sel_inttype1 tabindex="1" onchange="clearfields();getRangeValues();">
									<option value="">--------------Select--------------</option>
									<lapschoice:interesttype appmodule="R"  appvalue='<%=request.getParameter("prdCode")%>'/>
								</select></td>
							</tr>
							<tr>
								<td width="15%"><span
									id="labelchange">Select Interest Range </span></td>
								<td width="85%"><select name="select_rule" id="labelhelp"
									onchange="getvalues()" tabindex="1">
									<option value="">--------------Select--------------</option>
								</select></td>
							</tr>
						</table>						
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td width="14%">Amount Range From &nbsp;<b><span class="mantatory">*</span></b>
								<td width="10%"><lapschoice:CurrencyTag name="amtfrom"
									maxlength="18" tabindex="2" size="18" /></td>
								<td width="14%">Amount Range To &nbsp;<b><span class="mantatory">*</span></b>
								<td width="10%"><lapschoice:CurrencyTag name="amtto"
									maxlength="18" tabindex="3" size="18" /></td>
									
								<td width="14%">Tenor Range From &nbsp;<b><span class="mantatory">*</span></b>
								<td width="10%"><input type="text" name="tenorfrom"
									maxlength="3" style="text-align: right;" size="5"  onkeypress="allowNumber(this)" onBlur="checkPeriod(this)"/></td>
								<td width="14%">Tenor Range To &nbsp;<b><span class="mantatory">*</span></b>
								<td width="10%"><input type="text" name="tenorto"
									maxlength="3"  style="text-align: right;" size="5"  onkeypress="allowNumber(this)"  onBlur="checkPeriod(this)"/></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
				</tr>
				</table>
				<br>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr class="dataheader">
						<td width="5%">
						<div align="center">S.No</div>
						</td>
						<td width="12%">
						<div align="center">Range From</div>
						</td>
						<td width="12%">
						<div align="center">Range To</div>
						</td>
						<td width="15%" align="center" nowrap="nowrap">Credit Risk Premium</td>
						<td width="15%" align="center" nowrap="nowrap"><span id="idbsp">Business Strategic Premium </span></td>
					</tr>
					<%ArrayList g1 = null;
						for (int l = 0; l < 9; l++) {
							int colSize = 0;
							if (l < vecsize) {
								g1 = (ArrayList) v.get(l);
								if (g1 != null) {
									colSize = g1.size();
								}
							}
							if (colSize > 0) {%>
					<tr class="datgrid" >
						<td width="5%" align="center"> <input type=hidden name="line"
							value="<%=l + 1%>"><%=l + 1%></td>
						<td width="15%">
						<div align="center"><input type="text" name="from"
							maxlength="8" style="text-align: right" tabindex="<%=(4 * l) + 4%>"
							onKeyPress="allowAdjustment(this)" size="12"
							value="<%=Helper.correctNull((String) g1.get(0))%>">
						</div>
						</td>
						<td width="15%">
						<div align="center"><input type="text" name="to"
							maxlength="11" style="text-align: right" tabindex="<%=(4 * l) + 5%>"
							onKeyPress="allowAdjustment(this)" size="12" 
							value="<%=Helper.correctNull((String) g1.get(1))%>">
						</div>
						</td>
							
						<td align="center">
						<input type="text" name="txtcreditrskpremium" onBlur="roundtxt(this);checkPercentage(this);" style="text-align: right;" size="12"  
						onkeypress="allowNumber(this)" value='<%=Helper.correctNull((String) g1.get(2))%>'/></td>
						<td align="center">
						<input type="text" name="txtbustratpremium" onBlur="roundtxt(this);checkPercentage(this);"  
						style="text-align: right;" size="12"  onkeypress="allowNumber(this)" value='<%=Helper.correctNull((String) g1.get(3))%>'/>
						<input type="hidden" name="baserate">
						<input type="hidden" name="total">
						<input type="hidden" name="adjust"></td>
					</tr>
					<%} else {%>
					<tr class="datagrid">
						<td width="5%">
						<div align="center">
						<input type=hidden name="line" value="<%=l + 1%>"><%=l + 1%></div>
						</td>
						<td width="18%">
						<div align="center"><input type="text" name="from"
							maxlength="8" style="text-align: right" tabindex="<%=(4 * l) + 4%>"
							onKeyPress="allowAdjustment(this)" size="12"></div>
						</td>
						<td width="20%">
						<div align="center"><input type="text" name="to"
							maxlength="8" style="text-align: right" tabindex="<%=(4 * l) + 5%>"
							onKeyPress="allowAdjustment(this)"  size="12">
						</div>
						</td>						
						<td align="center"><input type="text" name="txtcreditrskpremium" onBlur="roundtxt(this);checkPercentage(this);" 
						 onkeypress="allowNumber(this)" size="12" style="text-align: right;"/></td>
						<td align="center"><input type="text" name="txtbustratpremium" onBlur="roundtxt(this);checkPercentage(this);" 
						  onkeypress="allowNumber(this)" size="12" style="text-align: right;"/>
						  <input type="hidden" name="baserate">
						  <input type="hidden" name="total">
						<input type="hidden" name="adjust"></td>
						
					</tr>
					<%}}%>
				</table>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/> 							
<input type="hidden" name="prd_code" value="<%=request.getParameter("prdCode")%>">
<input type="hidden" name="wrk_flowtype1" value="<%=strWrkflowtype%>">
<input type="hidden" name="checkApp" value="<%=request.getParameter("checkApp")%>"> 
<input type="hidden" name="hidval"> 
<input type="hidden" name="ruleid">
<input type="hidden" name="hidSpreadFlag" value="<%=Helper.correctNull((String)request.getParameter("hidSpreadFlag")) %>">
<input type="hidden" name="prd_choose" value="<%=request.getParameter("prd_choose")%>">
<input type="hidden" name="hidProductType" value="<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>">
<iframe name="ifrminterest" width="0" height="0" border="0"></iframe>
</form>
</body>
</html>
