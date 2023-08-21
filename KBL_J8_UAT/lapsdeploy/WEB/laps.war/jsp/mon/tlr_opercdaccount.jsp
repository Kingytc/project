<%@include file="../share/directives.jsp"%>
<%
java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);

%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<style>
</style>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css" />
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>


<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
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
	if(document.forms[0].cmdsave.disabled==false)
	 {  
	  showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	 } 
 }


function onLoading()
{

	//disableCommandButtons("load");
	disableFields(true);
}
function doDelete()
{
	   if(ConfirmMsg(101))
		{	
			document.forms[0].hidAction.value ="delete";
			document.forms[0].action=appURL+"action/ControllerServlet";		
			document.forms[0].hidBeanMethod.value="updateCDAccountData";
			document.forms[0].hidBeanGetMethod.value="getCDAccountData";
			document.forms[0].hidBeanId.value="reviewtermloantwo";
			document.forms[0].hidSourceUrl.value="action/tlr_opercdaccount.jsp";	
			document.forms[0].method="post";			
			document.forms[0].submit();	
		}
}
function doEdit()
{ 	
	if(document.forms[0].reviewOf.value=="")
	{
		alert("Select Review of");
		return;
	}	
    document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
}
function callDescHelp(page)
{	
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = appURL+"action/comindustrymasterhelp.jsp?page="+page;
		var title = "IndustryHelp";
		var prop = "scrollbars=no,width=650,height=400";	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);	
	}
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="tlr_opercdaccount.jsp";
		document.forms[0].hidBeanId.value="reviewtermloantwo";
		document.forms[0].hidBeanGetMethod.value="getCDAccountData";
		document.forms[0].action=appURL +"action/tlr_opercdaccount.jsp";
	    document.forms[0].submit();	
	}	
}
function doSave()
{
	    document.forms[0].hidBeanId.value="reviewtermloantwo";
	    document.forms[0].hidBeanMethod.value="updateCDAccountData";
		document.forms[0].hidBeanGetMethod.value="getCDAccountData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/tlr_opercdaccount.jsp";
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
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}		  
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].disabled=val;
		}
		 
	}

	
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mon_borrowersearch.jsp?hidmontype=MONITREVIEW";
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
			document.forms[0].action=appURL+"action/"+page;
			document.forms[0].submit();
		}
	else
		{
			ShowAlert(103);
		}
}
function callOtherLink(page,bean,method)
{
	if(!document.forms[0].reviewYear.value=="")
	{
		document.forms[0].reviewOf.disabled=false;
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		alert("Select Review Year");
	}
}


</script>

</head>

<body onload="onLoading()">
<form name="safaeri3" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<lapschoice:tlrtag pageid="8" reviewof='<%=Helper.correctNull((String)request.getParameter("reviewOf"))%>' valuesin='<%=Helper.correctNull((String)request.getParameter("valuesin"))%>'/>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>

		<td valign="top" colspan="5" class="page_flow">Home -&gt; Term Loan - Review -&gt; Operations of Account -&gt; CD Account</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
			<tr>
				<td><lapschoice:MonitorReview /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr align="center">
		<td>
		<table width="30%" border="0" cellspacing="1" cellpadding="3" align="left" class="outertable">
			<tr>
				<td width="15%" align="center" class="sub_tab_active">
				<b>CD Account</b></td>	
				<td width="15%" align="center" class="sub_tab_inactive">
							<b> <a
							href="JavaScript:callOtherLink('tlr_opertlaccount.jsp','reviewtermloantwo','getTLAccountData')"
							>TL Account</a></b> </td>									
			</tr>
		</table>
		</td>
	</tr>
</table><br>
 <table width="55%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable border1">
 <tr>
   <td>
 <table width="90%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
    <tr>
      <td width="55%">Maximum Debit</td>
        <td> <lapschoice:CurrencyTag name="txt_maxdebit" size="22"
							maxlength="12" value='<%=Helper.correctNull((String)hshValues.get("tlr_maxdebit")) %>' /> </td>
      </tr>
      <tr> 
        <td>Minimum Debit</td>
        <td> <lapschoice:CurrencyTag name="txt_mindebit" size="22"
							maxlength="12"  value='<%=Helper.correctNull((String)hshValues.get("tlr_mindebit")) %>' /></td>
      </tr>
      <tr> 
        <td>Maximum Credit</td>
        <td> <lapschoice:CurrencyTag name="txt_maxcredit" size="22"
							maxlength="12" value='<%=Helper.correctNull((String)hshValues.get("tlr_maxcredit")) %>' /> </td>
      </tr>
      <tr> 
        <td>Minimum Credit</td>
        <td> <lapschoice:CurrencyTag name="txt_mincredit" size="22"
							maxlength="12" value='<%=Helper.correctNull((String)hshValues.get("tlr_mincredit")) %>'/></td>
      </tr>
      <tr> 
        <td>No. of Days in Debit</td>
        <td> 
          <input type="text" name="txt_noofdaysdebit" size="22"
			onKeyPress="allowInteger(this)" maxlength="10" value="<%=Helper.correctNull((String)hshValues.get("tlr_noofdaysdebit")) %>">
        </td>
      </tr>
   <%if(!Helper.correctNull((String)request.getParameter("reviewOf")).equals("0")){ %>   
      <tr> 
        <td>No. of Days in Credit</td>
        <td> 
          <input type="text" name="txt_noofdayscredit" size="22"
			onKeyPress="allowInteger(this)" maxlength="10" value="<%=Helper.correctNull((String)hshValues.get("tlr_noofdayscredit")) %>">
        </td>
      </tr>
     <%} %> 
   </table>
   </td>
  </tr>
</table>
   <br>
  <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
 <br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="reviewOf" value="<%=request.getParameter("reviewOf")%>">
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("AuditFlag"))%>">
 </form>
</body>
</html>

