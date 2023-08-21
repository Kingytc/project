<%@include file="../share/directives.jsp"%>
<%String comapp_compname = Helper.correctNull((String) hshValues.get("comapp_compname"));%>

<html>
<head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css" />
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function disableCommandButtons(edit,del,save,cancel,close)
{
		document.forms[0].cmdedit.disabled=edit;
		document.forms[0].cmddelete.disabled=del;
		document.forms[0].cmdsave.disabled=save;
		document.forms[0].cmdcancel.disabled=cancel;
		document.forms[0].cmdclose.disabled=close;
}
function onLoading()
{	
	disableFields(true);
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons(true,false,false,false,true);	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="Inspection";
		document.forms[0].hidBeanGetMethod.value="getTechnicalpage5";
		document.forms[0].action=appUrl +"action/TechnicalInspectionpage5.jsp";
		document.forms[0].submit(); 		
	}	
}

function doDelete()
{	
		if(ConfirmMsg(101))
		{	
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidSourceUrl.value="/action/TechnicalInspectionpage5.jsp";
			document.forms[0].hidBeanId.value="Inspection";
			document.forms[0].hidBeanMethod.value="updateTechnicalpage5";
			document.forms[0].hidBeanGetMethod.value="getTechnicalpage5";
			document.forms[0].action=appUrl +"controllerservlet";
			document.forms[0].submit(); 
		}
	
}
function doSave()
	{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidSourceUrl.value="/action/TechnicalInspectionpage5.jsp";
	document.forms[0].hidBeanId.value="Inspection";
	document.forms[0].hidBeanMethod.value="updateTechnicalpage5";
	document.forms[0].hidBeanGetMethod.value="getTechnicalpage5";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
	}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}		 
	}
}
function doPrint()
{		
		var appno="<%=request.getParameter("appno")%>";
		var CompanyName="<%=hshValues.get("companyname")%>";						
		var purl ="<%=ApplicationParams.getAppUrl()%>action/techinsreport.jsp?hidBeanGetMethod=printgetTechnicalpage&hidBeanId=Inspection&appno="+appno+"&CompanyName="+CompanyName;
		var prop = 'scrollbars=yes,menubar=yes,width=750,height=520';	
		var xpos = (screen.width - 750) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);
}


function callLink(page,bean,method)
		{
		
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
		}

function doClose()
	{
	if(ConfirmMsg('100'))
		{
		document.forms[0].method="post";	
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
		}
	}
</script>
</head>
<body onload="onLoading()">
<form name="tech5" action="" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top"><jsp:include
			page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="14" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<span class="page_flow">Home-&gt;
Corporate-&gt; Proposal-&gt; Credit / Inspection Report -&gt; Technical
Inspection </span><br>
<lapschoice:application /> <span style="visibility:hidden;position:absolute"><lapschoice:borrowertype /></span>
<lapstab:ComReportTab tabid="2"	applevel='<%=Helper.correctNull((String)request.getParameter("applevel"))%>' />
<br>
<table border="0" width="100%" cellspacing="0" cellpadding="0" class="outertable linebor">
	<tr align="center" class="dataheader">
		<td width="45%" colspan="2" align="center"><b>8.2 Arrangements</b></td>
	</tr>
	<tr class="datagrid">
		<td width="45%"  >8.2.1 Agency/ Commission
		agent/ Salesman</td>
		<td width="45%" ><textarea rows="4" name="txt_agency"
			cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String) hshValues
							.get("agency_salesman"))%></textarea></td>
	</tr>
	<tr class="datagrid">
		<td width="45%"  >8.2.2 Direct to wholesalers
		/retailers/consumers(order-book/file position)</td>
		<td width="45%" ><textarea rows="4" name="txt_direct"
			cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String) hshValues
							.get("wholesalers_retailer_consumer"))%></textarea></td>
	</tr>
	<tr class="datagrid">
		<td width="45%"  >8.2.3 Area/Places covered;
		major buyers and orderbook position</td>
		<td width="45%" ><textarea rows="4" name="txt_areaplaces"
			cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String) hshValues
							.get("area_places_covered"))%></textarea></td>
	</tr>
	<tr class="datagrid">
		<td width="45%"  >8.2.4 Government orders
		(D.G.S. &amp; D. C.S.D. (I),Railways,etc)</td>
		<td width="45%" ><textarea rows="4" name="txt_govtorders"
			cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String) hshValues
							.get("government_orders"))%></textarea></td>
	</tr>
	<tr class="datagrid">
		<td width="45%"  >(<b>9) Profitability</b>
		(Yearly/Monthly profitability estimate showing expenses under
		main&nbsp;&nbsp;&nbsp; heads In the alternative, costing of unit
		product)</td>
		<td width="45%" ><textarea rows="4" name="txt_profit"
			cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String) hshValues
							.get("profitability"))%></textarea></td>
	</tr>
	<tr class="dataheader">
		<td width="81%" align="center" colspan="2">(<b>10)
		Management </b>(Know-how(Collect bio-data information of all important
		persons working at the unit))<br>
		<b>Capabilities of following in Production, marketing, Man management,
		financial management, general management and quality control</b></td>
	</tr>
	<tr class="datagrid">
		<td width="45%"  >10.1 Directors</td>
		<td width="45%" ><textarea rows="4" name="txt_mngmt"
			cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String) hshValues.get("directors"))%></textarea></td>
	</tr>
	<tr class="datagrid">
		<td width="45%"  >10.2 Partners</td>
		<td width="45%" ><textarea rows="4" name="txt_partners"
			cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String) hshValues.get("partners"))%></textarea></td>
	</tr>
	<tr class="datagrid">
		<td width="45%"  >10.3 Important Executives</td>
		<td width="45%" ><textarea rows="4" name="txt_executives"
			cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String) hshValues
							.get("important_executives"))%></textarea></td>
	</tr>
</table>

<table border="0" width="100%"  cellspacing="0"	cellpadding="0" class="outertable linebor">
	<tr class="datagrid">
		<td width="45%"  >(<b>11) Conclusion</b></td>
		<td width="45%" ><textarea rows="4" name="txt_conclusion"
			cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String) hshValues.get("conclusion"))%></textarea></td>
	</tr>
	<tr class="datagrid">
		<td width="45%"  >11.1 Comments on technical
		feasibility&nbsp; of the project</td>
		<td width="45%" ><textarea rows="4"
			name="txt_techfeasibility" cols="50"
			onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String) hshValues
							.get("technical_feasibility"))%></textarea></td>
	</tr>
	<tr class="datagrid">
		<td width="45%"  >11.2 Comments on&nbsp;
		economic viability of the project</td>
		<td width="45%" ><textarea rows="4" name="txt_ecoviability"
			cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String) hshValues
							.get("economic_viability"))%></textarea></td>
	</tr>
	<tr class="datagrid">
		<td width="45%"  >11.3 General Comments</td>
		<td width="45%" ><textarea rows="4" name="txt_general"
			cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String) hshValues
							.get("general_comments"))%></textarea></td>
	</tr>
	<tr class="datagrid" height="10%">
		<td width="45%">(<b>12) Name</b></td>
		<td width="45%" ><input type="text" name="txt_name" maxlength="50" size="25" value="<%=Helper.correctNull((String) hshValues
							.get("general_name"))%>"></td>
	</tr>
	<tr class="datagrid" height="10%">
		<td width="45%"  >(<b>13) Designation</b></td>
		<td width="45%" ><input type="text" name="txt_design" maxlength="50" size="25" value="<%=Helper.correctNull((String) hshValues
							.get("general_designation"))%>"></td>
	</tr>
</table>

<br />
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Print' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br> 
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td width="33%" ><b>&nbsp;
		<a
			href="javascript:callLink('TechnicalInspectionpage4.jsp','Inspection','getTechnicalpage4')"
			class="blackfont"> &lt;&lt; Prev </a>&nbsp;Pg.5/5</b></td>
		<td width="33%" ><b> <jsp:include
			page="../com/techlink.jsp" flush="true"/>
	</b></td>

	</tr>
</table>

<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="comapp_compname"	value="<%=comapp_compname%>">
</form>
</body>
</html>
