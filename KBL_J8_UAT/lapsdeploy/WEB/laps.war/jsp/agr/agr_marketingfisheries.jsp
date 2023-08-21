<%@include file="../share/directives.jsp"%>
<%
String schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
%>
<html>
<head>
<title>Technical Data</title>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var txr_boatdetails= "<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)hshValues.get("agr_fishboat")))%>"
var txr_nets = "<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)hshValues.get("agr_fishNets")))%>" 
var txr_fishfeed = "<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)hshValues.get("agr_fishFeed" )))%>" 
var txr_fingerlings= "<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)hshValues.get("agr_fishFingerlings")))%>" 
var txr_fishconsuming = "<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)hshValues.get("agr_fishFishConsuming")))%>" 
var txr_arrangement= "<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)hshValues.get("agr_fishpreservation")))%>"  
var txr_transport = "<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)hshValues.get("agr_fishTransport")))%>" 
var txr_demand= "<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)hshValues.get("agr_fishDemand")))%>"
var projecttype = "<%=Helper.correctNull((String)hshValues.get("af_projecttype"))%>" 
var schemetype="<%=schemetype%>";
</script>

<script>
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function callLink(page,bean,method)
{	
	 document.forms[0].hidAction.value="";
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}

function onloading()
{	  
	disableFields(true);
	if(projecttype=="")
	{
		document.forms[0].selprojecttype.value=0;
	}
	else
	{
		document.forms[0].selprojecttype.value=projecttype;
	}
	document.forms[0].txr_boatdetails.value=txr_boatdetails;
	document.forms[0].txr_nets.value=txr_nets;
	document.forms[0].txr_fishfeed.value=txr_fishfeed;
	document.forms[0].txr_fingerlings.value=txr_fingerlings;
	document.forms[0].txr_fishconsuming.value=txr_fishconsuming;
	document.forms[0].txr_arrangement.value=txr_arrangement;
	document.forms[0].txr_transport.value=txr_transport;
	document.forms[0].txr_demand.value=txr_demand;
	
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=schemetype;
	
	if(appstatus=="Open/Pending")
	{
		
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
			
			enableButtons(false, true, true, true, false);	
		}
		else
		{
			enableButtons( true, true, true, true, false);	
		}
	}
	else
	{
		enableButtons(true, true, true, true, false);	
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
function doSave()
{   
	if(document.forms[0].selprojecttype.value=="0")
	{
		 ShowAlert(111,"Project Type");
	       document.forms[0].selprojecttype.focus();
	       return false;
	}
	enableButtons(true, true, true, true, true, false);	
	document.forms[0].hidBeanId.value="fishersinvest";		
	document.forms[0].hidSourceUrl.value="/action/agr_marketingfisheries.jsp";
	document.forms[0].hidBeanMethod.value="updatemarketingfisheries";
	document.forms[0].hidBeanGetMethod.value="getmarketingfisheries";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doEdit()
{
 	disableFields(false);
	document.forms[0].hideditflag.value ="edit";
	document.forms[0].hidAction.value ="insert";
	enableButtons(true, false, false, false, false, true);		
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="fishersinvest";
		document.forms[0].hidBeanGetMethod.value="getmarketingfisheries";
		document.forms[0].action=appURL+"action/agr_marketingfisheries.jsp";
		document.forms[0].submit(); 		
	}	
}



function doClose()
{
	if( ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/"+"retailpge.jsp";				
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
	 	if(document.forms[0].elements[i].type=='checkbox')
	 	{
			document.forms[0].elements[i].disabled=one;
	 	}
	 	if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=one;
		}	
		  
	}
}

function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanId.value="fishersinvest";
		document.forms[0].hidSourceUrl.value="action/agr_marketingfisheries.jsp";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updatemarketingfisheries";
		document.forms[0].hidBeanGetMethod.value="getmarketingfisheries";
			
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}


</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="999" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
      <td class="page_flow">Home -> Agriculture -> Other Details
       </td>
	</tr>
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="204" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>	
<table width="98%"  border="0" cellpadding="3" cellspacing="1" class="outertable border1" align="center">
<tr>
<td>
  <table width="100%"  border="0" cellpadding="3" cellspacing="1" class="outertable">
    <tr class="dataheader"> 
      <td colspan="2">
        <b>Name &amp; Address of supplier 
        details</b></td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
   <tr>
   	 <td width="16%">Project Type&nbsp;<b><span
											class="mantatory">*</span></b></td>
     <td width="29%"> 
            <select  name="selprojecttype" onChange="" style="">
                	<option value="0">&lt;-- Select --&gt;</option>
                    <option value="1">Inland Fishery</option>
                    <option value="2">Marine Fishery</option>                          
            </select>
     </td>
     <td colspan="2">&nbsp;</td>
   </tr>
    <tr> 
      <td width="16%">Boat</td>
      <td width="29%"> 
        <textarea name="txr_boatdetails" cols="50" rows="3" onKeyUp="textlimit(this,3999)" onkeyPress="notAllowSingleQuote();textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("agr_fishboat"))%></textarea>
      </td>
      <td width="20%">Nets/Twins/Floats</td>
      <td width="29%"> 
        <textarea name="txr_nets" cols="50" rows="3" onKeyUp="textlimit(this,3999)" onkeyPress="notAllowSingleQuote();textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("agr_fishNets"))%></textarea>
      </td>
    </tr>
    <tr> 
      <td width="16%">Fish Feed</td>
      <td width="29%"> 
        <textarea name="txr_fishfeed" cols="50" rows="3" onKeyUp="textlimit(this,3999)" onkeyPress="notAllowSingleQuote();textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("agr_fishFeed"))%></textarea>
      </td>
      <td width="20%"  >Fingerlings</td>
      <td width="29%" > 
        <textarea name="txr_fingerlings" cols="50" rows="3" onKeyUp="textlimit(this,3999)" onkeyPress="notAllowSingleQuote();textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("agr_fishFingerlings"))%></textarea>
      </td>
    </tr>
    <tr class="dataheader"> 
      <td colspan="4"><b>Marketing Facilities</b></td>
    </tr>
    <tr>
    	<td>Experience in Pisciculture</td>
      <td>
        <textarea name="txtarea_experience" cols="50" rows="3" onKeyUp="textlimit(this,3999)"onkeyPress="notAllowSingleQuote();textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("agr_experience"))%></textarea>
      </td>
      <td>Processing Arrangement</td>
      <td>
        <textarea name="txtarea_processing" cols="50" rows="3" onKeyUp="textlimit(this,3999)" onkeyPress="notAllowSingleQuote();textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("agr_processing"))%></textarea>
      </td>
    </tr>
    <tr>
    	<td>Transport Agreement</td>
      <td>
        <textarea name="txr_transport" cols="50" rows="3"onKeyUp="textlimit(this,3999)" onkeyPress="notAllowSingleQuote();textlimit(this,3999)" ><%=Helper.correctNull((String)hshValues.get("agr_fishTransport"))%></textarea>
      </td>
      <td>Marketing Arrangement</td>
      <td>
        <textarea name="txtarea_marketing" cols="50" rows="3" onKeyUp="textlimit(this,3999)" onkeyPress="notAllowSingleQuote();textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("agr_marketing"))%></textarea>
      </td>
    </tr>
    <tr > 
      <td>Fish Consuming centers</td>
      <td>
        <textarea name="txr_fishconsuming" cols="50" rows="3" onKeyUp="textlimit(this,3999)" onkeyPress="notAllowSingleQuote();textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("agr_fishFishConsuming"))%></textarea>
      </td>
      <td>Arrangement for preservation</td>
      <td>
        <textarea name="txr_arrangement" cols="50" rows="3" onKeyUp="textlimit(this,3999)" onkeyPress="notAllowSingleQuote();textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("agr_fishpreservation"))%></textarea>
      </td>
    </tr>
    <tr >
      <td>Demand of fish in general</td>
      <td>
        <textarea name="txr_demand" cols="50" rows="3" onKeyUp="textlimit(this,3999)" onkeyPress="notAllowSingleQuote();textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("agr_fishDemand"))%></textarea>
      </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table>
  </td>
 </tr>
</table>
<br/>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid="<%=PageId%>"/>
</form>
</body>
</html>
