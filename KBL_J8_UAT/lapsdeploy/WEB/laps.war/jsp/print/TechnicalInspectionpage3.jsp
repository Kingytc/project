<%@include file="../share/directives.jsp"%>
<%String comapp_compname=Helper.correctNull((String)hshValues.get("comapp_compname"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Technical Inspection Page3</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
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
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons(true,false,false,false,true);	
	disableFields(false);
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="Inspection";
		document.forms[0].hidBeanGetMethod.value="getTechnicalpage3";
		document.forms[0].action=appUrl +"action/TechnicalInspectionpage3.jsp";
		document.forms[0].submit(); 		
	}	
}

function doSave()
	{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidSourceUrl.value="/action/TechnicalInspectionpage3.jsp";
	document.forms[0].hidBeanId.value="Inspection";
	document.forms[0].hidBeanMethod.value="updateTechnicalpage3";
	document.forms[0].hidBeanGetMethod.value="getTechnicalpage3";
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
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		} 
	}
}
function doDelete()
{	
		if(ConfirmMsg(101))
		{	
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidSourceUrl.value="/action/TechnicalInspectionpage3.jsp";
			document.forms[0].hidBeanId.value="Inspection";
			document.forms[0].hidBeanMethod.value="updateTechnicalpage3";
			document.forms[0].hidBeanGetMethod.value="getTechnicalpage3";
			document.forms[0].action=appUrl +"controllerservlet";
			document.forms[0].submit(); 
		}
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
<form name="tech3" action="" method="post" class="normal">
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td valign="top" colSpan=5> 
        <jsp:include page="../com/proposallinks.jsp" flush="true"> 
        <jsp:param name="pageid" value="14" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
  </table>
   <span class="page_flow">Home-&gt; Corporate-&gt; 
  Proposal-&gt; Credit / Inspection Report -&gt; Technical Inspection </span><br>
  <lapschoice:application /> <span style="visibility:hidden;position:absolute"><lapschoice:borrowertype /></span>
<lapstab:ComReportTab tabid="2" applevel='<%=Helper.correctNull((String)request.getParameter("applevel"))%>'/>
<br>
<table border="0" width="100%" cellspacing="0" cellpadding="0" class="outertable linebor">
  <tr class="dataheader">
    <td width="45%" colspan="2" align="center"><p >(4) Plant &amp;
    Machinery</td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>4.1 Itemwise particulars, capacities, power requirement and cost of existing and
        proposed machinery</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_particulars" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("particulars"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>4.2 Condition of Machines</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_machine" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("conditionsofmachine"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>4.3 Satisfactory arrangements for maintenance and repairs</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_arrange" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("SATISFACTORYARRANGEMENTS"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>4.4 In case of Imported machines, availability of repair, facilities and spare parts</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_imported" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("IMPORTEDMACHINES"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>4.5 Comments on balancing of capacities and on need, if any, for acquiring balancing
        equipments</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_comments1" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("COMMENTSONBALANCING"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>4.6 Comments on adequacy of machines for planned production</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_comments2" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("COMMENTSONADEQUACY"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>4.7 Availability of new machinery required; Comments on quotations/suppliers, etc.</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_avail" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("AVAILABILITY"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>4.8 Comments on layout</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_layout" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("COMMENTSONLAYOUT"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>4.9 Whether hypothecated to Bank/ any other institution</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_hypothec" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("WHETHERHYPOTHECATED"))%></textarea></td>
  </tr>
</table>

<table border="1" width="100%" cellspacing="0" cellpadding="0" class="outertable linebor">
  <tr class="datagrid">
    <td width="45%"  >(5) Products (Brief particualrs
    of products manufactured and their applications/uses)</td>
    <td width="45%" ><textarea rows="4" name="txt_products" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("PRODUCTS_PARTICULARS"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  >(6) Production</td>
    <td width="45%" ></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>6.1 Operations/processes involved (Brief description, if and when necessary, for
        projecting the picture of the Industry to a non-technical person)</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_operations" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("OPERATIONS_PROCESSES"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>6.2 Rates of the production per hour/day</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><input type="text" name="txt_rates" onKeyPress="allowInteger()" maxlength="8" value="<%=Helper.correctNull((String)hshValues.get("RATESOFTHEPRODUCTION"))%>" size="20">
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>6.3 Number of shifts</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><input type="text" name="txt_shifts" size="20" maxlength="5" onKeyPress="allowInteger()" value="<%=Helper.correctNull((String)hshValues.get("NUMBEROFSHIFTS"))%>"></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>6.4 Quantities produced (yearwise/monthwise)</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><p >Month Wise
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    <input type="text" name="txt_monthwise" size="10" maxlength="5" onKeyPress="allowInteger()" 
    value="<%=Helper.correctNull((String)hshValues.get("QUANTITIESPRODUCED_MONTH"))%>">&nbsp;&nbsp;&nbsp; Year Wise 
    <input type="text" name="txt_yearwise" size="10" maxlength="5" onKeyPress="allowInteger()" 
    value="<%=Helper.correctNull((String)hshValues.get("QUANTITIESPRODUCED_YEAR"))%>"></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>6.5 Comments on achievement of more production</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_achievement" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("COMMENTSONACHIEVEMENT"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>6.6 Quality; compare with other products</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_quality" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("QUALITY"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>6.7 Testing and Quality Control Facilities</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_testing" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("TESTINGANDQUALITYCONTROL"))%></textarea></td>
  </tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr> 
	<tr> 
      <td width="33%" ><b>&nbsp;
        <a href="javascript:callLink('TechnicalInspectionpage2.jsp','Inspection','getTechnicalpage2')" class="blackfont"> 
           &lt;&lt; Prev </a>&nbsp;Pg.3/5 </b>
      </td>
     
      <td width="33%" align="center"><b> 
        <jsp:include page="../com/techlink.jsp" flush="true"/> 
        </b></td>
      <td width="33%">&nbsp; 
        <div align="right"><b>Pg.3/5  &nbsp;<a href="javascript:callLink('TechnicalInspectionpage4.jsp','Inspection','getTechnicalpage4')" class="blackfont"> 
          Next &gt;&gt; </a></b></div>
      </td>
    </tr>
</table>


<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="comapp_compname" value="<%=comapp_compname%>">
</form>
</body>
</html>
