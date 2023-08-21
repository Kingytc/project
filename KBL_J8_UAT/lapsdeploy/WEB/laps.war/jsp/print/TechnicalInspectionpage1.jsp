<%@include file="../share/directives.jsp"%>
<%
String comapp_compname = Helper.correctNull((String)hshValues.get("comapp_compname"));
String strappholder = Helper.correctNull((String)request.getParameter("appholder"));
String strappliedfor=Helper.correctNull((String)request.getParameter("appliedfor"));
%>
<html>
<head>
<title>TECHNICAL INSPECTION REPORT</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var PURPOSEOFREPORT1="<%=hshValues.get("PURPOSEOFREPORT1")%>";
var PURPOSEOFREPORT2="<%=hshValues.get("PURPOSEOFREPORT2")%>";
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
	appstatus=document.forms[0].appstatus.value;	
	if(PURPOSEOFREPORT1!="null")
	{
		document.forms[0].pur1.value=PURPOSEOFREPORT1;
	}
	else
	{
		document.forms[0].pur1.value="0";
	}
	if(PURPOSEOFREPORT2!="null")
	{
		document.forms[0].pur2.value=PURPOSEOFREPORT2;
	}
	else
	{
		document.forms[0].pur2.value="0";
	}	
	disableFields(true);
}
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appUrl,name);		
	}
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value="insert";
	disableCommandButtons(true,false,false,false,true);	
	disableFields(false);
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="Inspection";
		document.forms[0].hidBeanGetMethod.value="getTechnicalpage1";
		document.forms[0].action=appUrl +"action/TechnicalInspectionpage1.jsp";
		document.forms[0].submit(); 		
	}	
	
	disableCommandButtons(false,true,true,true,false);
	disableFields(true);
	document.forms[0].pur1.value="0";
	document.forms[0].pur2.value="0";	 
}

function doSave()
	{
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidSourceUrl.value="/action/TechnicalInspectionpage1.jsp";
		document.forms[0].hidBeanId.value="Inspection";
		document.forms[0].hidBeanMethod.value="updateTechnicalpage1";
		document.forms[0].hidBeanGetMethod.value="getTechnicalpage1";
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
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
	 	}	  
		
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
	 	}	 	
	}
	document.forms[0].insp_date.readOnly=true;
}

function doDelete()
{	
		if(ConfirmMsg(101))
		{	
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidSourceUrl.value="/action/TechnicalInspectionpage1.jsp";
			document.forms[0].hidBeanId.value="Inspection";
			document.forms[0].hidBeanMethod.value="updateTechnicalpage1";
			document.forms[0].hidBeanGetMethod.value="getTechnicalpage1";
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
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
</head>

<body onload="onLoading()">
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
<form name="tech1" action="" method="post" class="normal">

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
  <span class="page_flow">Home -&gt; Corporate & SME -&gt; 
  Proposal -&gt; Credit / Inspection Report -&gt; Technical Inspection<br>
  <lapschoice:application /><span style="visibility:hidden;position:absolute"><lapschoice:borrowertype /></span>
<lapstab:ComReportTab tabid="2" applevel='<%=Helper.correctNull((String)request.getParameter("applevel"))%>' applied='<%=strappliedfor%>'/>
<br>
<table border="0" width="100%" cellspacing="0" cellpadding="0" class="outertable linebor">
  <tr class="dataheader">
    <td width="77%" colspan="2">(1) Purpose of Report
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    
    <select name="pur1" size="1" >
	 <option value="0" selected>Select</option>
      <option value="1">Existing Project</option>
      <option value="2">New Project (Appraisal)</option>
      <option value="3">Sick Unit</option>
    </select>&nbsp;
   
    <select name="pur2" size="1">
	 <option value="0" selected>Select</option>
      <option value="1">Routine Appraisal</option>
      <option value="2">Assessment</option>
      <option value="3">Expansion Scheme</option>
      <option value="4">Appraising</option>
      <option value="5">Evaluating nuring programme</option>
    </select> 
    &nbsp; Date of Inspection
              <input type="text" name="insp_date" size="11"
				maxlength="10" tabindex="3" onBlur="checkDate(this);checkmaxdate(this,currentDate);"
				value="<%=Helper.correctNull((String)hshValues.get("DATEOFINSPECTION"))%>"><a href="#" onClick="callCalender('insp_date')"
				title="Click to view calender" border=0>
				<img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="4"></a>
  </tr>
  <tr class="dataheader">
    <td width="33%">(2) Infrastructure Location Factors</td>
    <td width="43%"></td>
  </tr>
  <tr class="datagrid">
    <td width="41%" ><blockquote>
      <p>2.1 Raw Material Sources</p>
    </blockquote>
    </td>
    <td width="49%" ><textarea rows="4" name="txt_rawmat" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("RAWMATERIAL"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="41%" ><blockquote>
      <p>2.2 Water Arrangements (State quantum for Industries with High requirement of water
      storage arrangements)</p>
    </blockquote>
    </td>
    <td width="49%" ><textarea rows="4" name="txt_water" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("WATERARRANGEMANTS"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="41%" ><blockquote>
      <p>2.3 Power(availability, required and sanctioned load/Power
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Shortage/cuts,standby generator)</p>
    </blockquote>
    </td>
    <td width="49%" ><textarea rows="4" name="txt_power" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("POWER"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="41%" ><blockquote>
      <p>2.4 Fuel</p>
    </blockquote>
    </td>
    <td width="49%" ><textarea rows="4" name="txt_fuel" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("FUEL"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="41%" ><blockquote>
      <p>2.5 Transportation and Communications(Distance from railway station/highway/our
      branch)</p>
    </blockquote>
    </td>
    <td width="49%" ><textarea rows="4" name="txt_trans" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("TRANSPORTATION"))%></textarea></td>
  </tr>
  <tr class="dataheader">
    <td width="100%" colspan="2" ><blockquote>
      <p>2.6 Manpower</p>
    </blockquote>
    </td>
  </tr>
  <tr class="datagrid">
    <td width="41%" >&nbsp;<blockquote>
      <blockquote>
        <p>2.6.1 Skilled/Unskilled</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="49%" ><textarea rows="4" name="txt_skill" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("MANPOWER"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="41%">&nbsp;<blockquote>
      <blockquote>
        <p>2.6.2 Prevalent wage rates</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="49%"><textarea rows="4" name="txt_wage" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("PREVALENTWAGERATES"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="41%" ><blockquote>
      <blockquote>
        <p>2.6.3 Labour relations, incidence of strike/ go slow/lockouts etc..</p>
      </blockquote>
    </blockquote>
    </td>
    <td width="49%" ><textarea rows="4" name="txt_labour" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("LABOURRELATION"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="41%" ><blockquote>
      <p>2.7 Market for Products</p>
    </blockquote>
    </td>
    <td width="49%" ><textarea rows="4" name="txt_market" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("MARKETFORPRODUCTS"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="41%" ><blockquote>
      <p>2.8 Workshop Facilities for Repairs</p>
    </blockquote>
    </td>
    <td width="49%" ><textarea rows="4" name="txt_workshop" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("WORKSHOPFACILITIES"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="41%" ><blockquote>
      <p>2.9 Any Other Special Features such as special
      &nbsp;&nbsp;&nbsp;&nbsp;
      facilities/concession available in the place/area</p>
    </blockquote>
    </td>
    <td width="49%" ><textarea rows="4" name="txt_special" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("SPECIALFEATURES"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="41%" ><blockquote>
      <p>2.10 Banking Facilities</p>
    </blockquote>
    </td>
    <td width="49%" ><textarea rows="4" name="txt_bank" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("BANKINGFACILITIES"))%></textarea></td>
  </tr>
  <tr class="datagrid">
    <td width="41%" ><blockquote>
      <p>2.11 Effluent disposal and drainage;Pollution control and&nbsp;&nbsp;&nbsp; environment
      safeguard measures; permission of Pollution Control Authorities</p>
    </blockquote>
    </td>
    <td width="49%" ><textarea rows="4" name="txt_eff" cols="50" onkeypress="textlimit(this,3800)" onKeyUp="textlimit(this,3800)"><%=Helper.correctNull((String)hshValues.get("POLLUTION"))%></textarea></td>
  </tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br/>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr> 
      <td width="33%" align="left">&nbsp;</td>
      <td width="33%" align="center"><b>
        <jsp:include page="../com/techlink.jsp" flush="true"/> 
        </b></td>
      <td width="33%">&nbsp; 
        <div align="right"><b>Pg.1/5  &nbsp;<a href="javascript:callLink('TechnicalInspectionpage2.jsp','Inspection','getTechnicalpage2')" class="blackfont"> 
          Next &gt;&gt; </a></b></div>
      </td>
    </tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="comapp_compname" value="<%=comapp_compname%>">
</form>
</body>
</html>
