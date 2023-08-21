<%@include file="../share/directives.jsp"%>
<%String comapp_compname=Helper.correctNull((String)hshValues.get("comapp_compname"));
%>
<html>
<head>
<title>TECHNICAL INSPECTION REPORT</title>
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
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons(true,false,false,false,true);	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="Inspection";
		document.forms[0].hidBeanGetMethod.value="getTechnicalpage4";
		document.forms[0].action=appUrl +"action/TechnicalInspectionpage4.jsp";
		document.forms[0].submit(); 		
	}	
}

function doSave()
	{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidSourceUrl.value="/action/TechnicalInspectionpage4.jsp";
	document.forms[0].hidBeanId.value="Inspection";
	document.forms[0].hidBeanMethod.value="updateTechnicalpage4";
	document.forms[0].hidBeanGetMethod.value="getTechnicalpage4";
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
function doDelete()
{	
		if(ConfirmMsg(101))
		{	
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidSourceUrl.value="/action/TechnicalInspectionpage4.jsp";
			document.forms[0].hidBeanId.value="Inspection";
			document.forms[0].hidBeanMethod.value="updateTechnicalpage4";
			document.forms[0].hidBeanGetMethod.value="getTechnicalpage4";
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
<form name="tech4" action="" method="post" class="normal">
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
  Proposal-&gt; Credit / Inspection Report -&gt; Technical Inspection</span><br>
  <lapschoice:application /> <span style="visibility:hidden;position:absolute"><lapschoice:borrowertype /></span>
<lapstab:ComReportTab tabid="2" applevel='<%=Helper.correctNull((String)request.getParameter("applevel"))%>'/>
<br>
<table border="0" width="100%" cellspacing="0" cellpadding="0" class="outertable linebor">
  <tr class="dataheader">
    <td width="45%" colspan="2" align="center">(7) Raw Materials</td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>7.1 Availability -places/prices/quality; seasonal availability, whether available in
        quota with full details</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_rawmatavilable" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("rawmaterial_availability"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>7.2 Arrangements, if any, for bought out parts/ components</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_rawmatarrangements" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("rawmaterial_arrangements"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>7.3 Suppliers</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_suppliers" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("suppliers"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>7.4 Credit available</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_credit" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("creditavailable"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>7.5 Frequency of purchase and time gap between placing of order and delivery</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_frequency" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("frquencyofpurchase"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>7.6 Imported Raw materials and their percentage</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_imported" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("imported_rawmaterial"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>7.7 For Imported materials, whether license obtained/available and applied for</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_importedlicense" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("rawmaterial_license"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>7.8 Value of import license on hand</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_importlicensehand" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("valueof_importlicense"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>7.9 Storage/godown/warehousing arrangements</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_storage" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("storage"))%></textarea></td>
  </tr>
</table>
<table border="0" width="100%"  cellspacing="0" cellpadding="0" class="outertable linebor">
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>7.10 Inspection of existing inventories and components about adequacy/excess(quantity)
        and condition(quality)</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_inspection" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("inspection"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>7.11 Insurance Cover</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_insurance" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("insurance_cover"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>7.12 Old stock accumulation and arrangements/plan for utilisation/disposal</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_oldstock" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("oldstockaccumulation"))%></textarea></td>
  </tr>
</table>

<table border="0" width="100%" cellspacing="0" cellpadding="0" class="outertable linebor">
  <tr class="dataheader">
    <td width="45%" colspan="2" align="center">(8) Marketing</td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <p>8.1 Demand</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <blockquote>
          <blockquote>
            <p>8.1.1&nbsp; Local/up-country/export (detail of exports and imports)</p>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_exportimport" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("export_import"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <blockquote>
          <blockquote>
            <p>8.1.2 Competitors - Main Competitors</p>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_competitors" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("competitors"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <blockquote>
          <blockquote>
            <p>8.1.3 <small>Presence of Substitutes, if any</small></p>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_substitutes" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("presenceofsubstitutes"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <blockquote>
          <blockquote>
            <p>8.1.4 Present and future demand</p>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_demand" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("present_futuredemand"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <blockquote>
          <blockquote>
            <p>8.1.5 Arrangement of publicity, if any</p>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_publicity" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("arrangementofpublicity"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <blockquote>
          <blockquote>
            <p>8.1.6 Previous performance (year wise / month wise)</p>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_prevperfomance" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("previousperformance"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ><blockquote>
      <blockquote>
        <blockquote>
          <blockquote>
            <p>8.1.7 Targets-Comments&nbsp; on achievability.</p>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
    </td>
    <td width="45%" ><textarea rows="4" name="txt_targets" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"> <%=Helper.correctNull((String)hshValues.get("targets"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="45%"  ></td>
    <td width="45%" ></td>
  </tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br/>

<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr> 
	
      <td width="33%" ><b>&nbsp;
        <a href="javascript:callLink('TechnicalInspectionpage3.jsp','Inspection','getTechnicalpage3')" > 
           &lt;&lt; Prev </a>&nbsp;Pg.4/5 </b>
      </td>
      
      <td width="33%" align="center"><b> 
        <jsp:include page="../com/techlink.jsp" flush="true"/> 
        </b></td>
      <td width="33%">&nbsp; 
        <div align="right"><b>Pg.4/5  &nbsp;<a href="javascript:callLink('TechnicalInspectionpage5.jsp','Inspection','getTechnicalpage5')" > 
          Next &gt;&gt; </a></b></div>
      </td>
    </tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="comapp_compname" value="<%=comapp_compname%>">
</form>
</body>
</html>
