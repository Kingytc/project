<%@include file="../share/directives.jsp"%>
<%
java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);
String stryear=Helper.correctNull((String)request.getParameter("mon_year"));
if(!stryear.equalsIgnoreCase(""))
{
	stryear=Helper.correctNull((String)hshValues.get("mon_year"));
}
String strmonth=Helper.correctNull((String)request.getParameter("mon_month"));

if(!strmonth.equalsIgnoreCase(""))
{
	strmonth=Helper.correctNull((String)hshValues.get("mon_month"));
}
String strmsod=Helper.correctNull((String)request.getParameter("mon_msod"));
if(strmsod.equalsIgnoreCase(""))
{
	strmsod=Helper.correctNull((String)hshValues.get("mon_msod"));
}			
String strstock=Helper.correctNull((String)request.getParameter("mon_stock"));
if(strstock.equalsIgnoreCase(""))
{
	strstock=Helper.correctNull((String)hshValues.get("mon_stock"));
}
String strbkdebts=Helper.correctNull((String)request.getParameter("mon_bkdebts"));
if(strbkdebts.equalsIgnoreCase(""))
{
	strbkdebts=Helper.correctNull((String)hshValues.get("mon_bkdebts"));
}
String strqpr=Helper.correctNull((String)request.getParameter("mon_qpr"));
if(strqpr.equalsIgnoreCase(""))
{
	strqpr=Helper.correctNull((String)hshValues.get("mon_qpr"));
}
%>
<html>
<head>
<title>ubi</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
}
function callCalender(fname)
 {
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 }


function onLoading()
{
	disableCommandButtons("load");
	
		
	
	
}
function doDelete()
{
	if(ConfirmMsg(101))
		{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updateinventory";
		document.forms[0].hidBeanGetMethod.value="getinventory";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidSourceUrl.value="action/mon_inventory.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
		}
}
function doEdit()
{ 	
	disableFields(false);
    document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");	
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="mon_inventory.jsp";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidBeanGetMethod.value="getinventory";
		document.forms[0].action=appUrl+"action/mon_inventory.jsp";
	    document.forms[0].submit();	
	}	
	
	disableCommandButtons("load");
}
function doSave()
	{
	   document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidBeanMethod.value="updateinventory";
		document.forms[0].hidBeanGetMethod.value="getinventory";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/mon_inventory.jsp";
		document.forms[0].submit();
	}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
			  
		 
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/mainnav.jsp";
		document.forms[0].submit();
		
	}
}
function callLink(page,bean,method)
{
	
	 if (document.forms[0].cmdsave.disabled)
		{
			document.forms[0].hidSourceUrl.value=page;
			document.forms[0].hidBeanGetMethod.value=method;
			document.forms[0].hidBeanId.value=bean;
			document.forms[0].action=appUrl+"action/"+page;
			document.forms[0].submit();
		}
	else
		{
			ShowAlert(103);
		}
}


function call_page(url,method)
{
	
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].method="post";

	if(url=="mon_currentassetfinanced.jsp")
	{
		document.forms[0].hidBeanId.value="mmrcommon";
	}
	else if(url=="mon_accountwisedetails.jsp")
	{
		document.forms[0].hidBeanId.value="mmrcommon";
	}
	
	else
	{
		document.forms[0].hidBeanId.value="mmrcommon";
	}
	document.forms[0].action=appUrl+"action/"+url;
	document.forms[0].submit();
}

</script>
</head>
<body  onload="onLoading()">
<form name="safaeri3" method="post">

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapschoice:monthlymonitortag pageid="5"/>
					</td>
				</tr>
				<tr>
					<td class="Page_Flow">
						Home -&gt; Monitoring-&gt; 
  Monthly Monitoring -&gt;Accountwise Details -&gt;QPR-&gt; Levels of Inventory
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
						<lapschoice:MonthlyMonitor />

 <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
    <tr> 
      <td valign="bottom"> 
        <table width="60%" border="0" cellspacing="3" cellpadding="3" align="left" class="outertable">
          <tr> 
            <td width="20%" class="sub_tab_inactive" align="center" id="prin" ><b><a href="javascript:call_page('mon_accountwisedetails.jsp','getAccountwise')" >Account-Wise Details</a></b> </td>
            <%if(Helper.correctNull((String)hshValues.get("mon_msod")).equalsIgnoreCase("y"))
		 				 {%>
            <td width="20%"  class="sub_tab_inactive"  align="center" id="prin"><b><a href="javascript:call_page('mon_msodestimates.jsp','getmsodestimate')" >MSOD</a>
               </b></td>
            <%} 
              if( Helper.correctNull((String)hshValues.get("mon_qpr")).equalsIgnoreCase("y")){%>
            <td width="20%" class="sub_tab_active"  align="center" id="prin"><b><a href="javascript:call_page('mon_qprperformance.jsp','getQprPerformance')" >QPR
              </a></b></td>
              <%}

		  %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
 
						<lapschoice:MonQPRTag  pageid="4"/>
						<lapschoice:Monitor strSource="MMR"/>
					
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable" >
  <tr class="dataHeader" > 
    <td colspan="4">LEVELS OF INVENTORY/RECEIVABLES/SUNDRY CREDITORS</td>
  </tr>
  <tr class="dataHeader"> 
    <td width="16%">&nbsp;</td>
    <td width="29%"align="center">At the end of last year</td>
    <td width="22%"align="center">At the current quarter ending</td>
    <td width="33%"align="center">Estimates at the end of current year</td>
  </tr>
  <tr class="dataGrid"> 
    <td width="16%">o.Inventory</td>
    <td width="29%"align="center">
      <lapschoice:CurrencyTag  name="txt_inlastyear" onKeyPress="allowNumber(document.forms[0].txt_inlastyear)" size="15" maxlength="12" style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("mon_inlastyear"))%>'/>							 
      </td>
    <td width="22%"align="center">
       <lapschoice:CurrencyTag  name="txt_inquarter" onKeyPress="allowNumber(document.forms[0].txt_inquarter)" size="15" maxlength="12" style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("mon_inquarter"))%>'/>						
    </td>
    <td width="33%"align="center">
     <lapschoice:CurrencyTag  name="txt_incuryear" onKeyPress="allowNumber(document.forms[0].txt_incuryear)" size="15" maxlength="12" style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("mon_incuryear"))%>'/>
    </td>
  </tr>
  <tr class="dataGrid"> 
    <td width="16%">p.Receivables</td>
    <td width="29%"align="center">
     <lapschoice:CurrencyTag name="txt_reclastyear" onKeyPress="allowNumber(document.forms[0].txt_reclastyear)" size="15" maxlength="12" style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("mon_reclastyear"))%>'/>
    </td>
    <td width="22%"align="center">
       <lapschoice:CurrencyTag name="txt_recquarter" onKeyPress="allowNumber(document.forms[0].txt_recquarter)" size="15" maxlength="12" style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("mon_recquarter"))%>'/>
    </td>
    <td width="33%"align="center">
      <lapschoice:CurrencyTag name="txt_reccuryear" onKeyPress="allowNumber(document.forms[0].txt_reccuryear)" size="15" maxlength="12" style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("mon_reccuryear"))%>'/>
    </td>
  </tr>
  <tr class="dataGrid">
    <td width="16%">q.Sundry Creditors</td>
    <td width="29%"align="center">
       <lapschoice:CurrencyTag name="txt_sunlastyear" onKeyPress="allowNumber(document.forms[0].txt_sunlastyear)" size="15" maxlength="12" style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("mon_sunlastyear"))%>'/>
    </td>
    <td width="22%"align="center">
      <lapschoice:CurrencyTag name="txt_sunquarter" onKeyPress="allowNumber(document.forms[0].txt_sunquarter)" size="15" maxlength="12" style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("mon_sunquarter"))%>'/>
    </td>
    <td width="33%"align="center">
      <lapschoice:CurrencyTag name="txt_suncuryear" onKeyPress="allowNumber(document.forms[0].txt_suncuryear)" size="15" maxlength="12" style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("mon_suncuryear"))%>'/>
    </td>
  </tr>
</table>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
	<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="mon_accno" value="<%=Helper.correctNull((String)request.getParameter("mon_accno")) %>">
<input type="hidden" name="cbsaccno" value="<%=request.getParameter("cbsaccno")%>">

<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)request.getParameter("cbsid"))%>">
<input type="hidden" name="mon_year" value="<%=Helper.correctNull((String)request.getParameter("mon_year"))%>">
<input type="hidden" name="mon_month" value="<%=Helper.correctNull((String)request.getParameter("mon_month"))%>">
<input type="hidden" name="cbsname" value="<%=Helper.correctNull((String)request.getParameter("cbsname"))%>">
<input type="hidden" name="mon_msod" value="<%=strmsod%>">
<input type="hidden" name="mon_stock" value="<%=strstock%>">
<input type="hidden" name="mon_bkdebts" value="<%=strbkdebts%>">
<input type="hidden" name="mon_qpr" value="<%=strqpr%>">


<input type="hidden" name="mon_checkqpr" value="<%=strqpr%>">
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>">

</form>
</body>
</html>

