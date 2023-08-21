<%@include file="../share/directives.jsp"%>
<%String comapp_compname=Helper.correctNull((String)hshValues.get("comapp_compname"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Technical Inspection Page2</title>
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
		document.forms[0].hidBeanGetMethod.value="getTechnicalpage2";
		document.forms[0].action=appUrl +"action/TechnicalInspectionpage2.jsp";
		document.forms[0].submit(); 		
	}	
	disableFields(true);
	disableCommandButtons(false,true,true,true,false);
}

function doSave()
	{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidSourceUrl.value="/action/TechnicalInspectionpage2.jsp";
	document.forms[0].hidBeanId.value="Inspection";
	document.forms[0].hidBeanMethod.value="updateTechnicalpage2";
	document.forms[0].hidBeanGetMethod.value="getTechnicalpage2";
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
			document.forms[0].hidSourceUrl.value="/action/TechnicalInspectionpage2.jsp";
			document.forms[0].hidBeanId.value="Inspection";
			document.forms[0].hidBeanMethod.value="updateTechnicalpage2";
			document.forms[0].hidBeanGetMethod.value="getTechnicalpage2";
			document.forms[0].action=appUrl +"controllerservlet";
			document.forms[0].submit(); 
		}
	
}
function callLink(page,bean,method)
{	
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
<form name="tech2" action="" method="post" class="normal">
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td valign="top"> 
        <jsp:include page="../com/proposallinks.jsp" flush="true"> 
        <jsp:param name="pageid" value="14" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
    <tr>
    	<td class="page_flow">
    	Home-&gt; Corporate-&gt; Proposal-&gt; Credit / Inspection Report -&gt; Technical Inspection
    	</td>
    </tr>
  </table>
  <lapschoice:application /> <span style="visibility:hidden;position:absolute"><lapschoice:borrowertype /></span>
<lapstab:ComReportTab tabid="2" applevel='<%=Helper.correctNull((String)request.getParameter("applevel"))%>'/>
<table border="2" width="100%" cellspacing="0" cellpadding="0" class="outertable">
  <tr class="dataheader">
    <td width="100%" colspan="2">(3) Land and Building</td>
  </tr>
  <tr class="dataheader">
    <td>
      3.1&nbsp; Land
    </td>
    <td width="50%" >&nbsp;</td>
  </tr>
  <tr class="datagrid">
    <td valign="top" >
        3.1.1 Rented/Own
    </td>
    <td width="50%" ><textarea rows="4" name="txt_rent" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("land_rentedown"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td valign="top" >
        3.1.2 Whether mortgaged to Bank/any other financial institution
    </td>
    <td width="50%" ><textarea rows="4" name="txt_mort" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("whethermortgaged"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td valign="top" >
        3.1.3 Total area, purchase&nbsp;cost/taxes/rent
    </td>
    <td width="50%" ><textarea rows="4" name="txt_area" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("totalarea"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td valign="top">
        3.1.4 Development expenses on fencing, levelling, etc.
    </td>
    <td width="50%" ><textarea rows="4" name="txt_devexp" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("developmentcharges"))%></textarea></td>
  </tr>
  <tr class="dataheader">
    <td>
      3.2 Building
    </td>
    <td width="50%" ></td>
  </tr>
  <tr class="datagrid">
    <td>
        3.2.1. Built-up area
    </td>
    <td width="50%" ><textarea rows="4" name="txt_built" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("builtuparea"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td>
        3.2.2 Types of structures
    </td>
    <td width="50%" ><textarea rows="4" name="txt_struct" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("typesofstructures"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td>
        3.2.3 Adequacy of space for present use as well as for further expansion
    </td>
    <td width="50%" ><textarea rows="4" name="txt_adeq" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("adequencyofspace"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td>
        3.2.4 Deeds and records, if seen
    </td>
    <td width="50%" ><textarea rows="4" name="txt_deeds" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("deedsandrecords"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td>
        3.2.5 Godown facilities inside the premises
    </td>
    <td width="50%" ><textarea rows="4" name="txt_godown" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("godownfacilities"))%></textarea></td>
  </tr>
</table>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br/>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr> 
      <td width="33%" ><b>&nbsp;
        <a href="#" onclick="callLink('TechnicalInspectionpage1.jsp','Inspection','getTechnicalpage1')" class="blackfont"> 
           &lt;&lt; Prev </a>&nbsp;Pg.2/5 </b>
      </td>
      <td width="33%" align="center"><b> 
        <jsp:include page="../com/techlink.jsp" flush="true"/>
        </b></td>
      <td width="33%" align="right">&nbsp; 
        <b>Pg.2/5  &nbsp;<a href="#" onclick="callLink('TechnicalInspectionpage3.jsp','Inspection','getTechnicalpage3')" class="blackfont"> 
          Next &gt;&gt; </a></b>
      </td>
    </tr>
</table>

<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="comapp_compname" value="<%=comapp_compname%>">
</form>
</body>
</html>
