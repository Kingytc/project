<%@ include file="../share/directives.jsp"%>
<%

String strUserID=Helper.correctNull((String)session.getAttribute("strUserId"));

String strSecFlag=Helper.correctNull((String)hshValues.get("SEC_FLAG")); 

%>
<html>
<head>
<title>Security Creation / Modification Verification</title>
<script  LANGUAGE="JavaScript">
var appURL ="<%=ApplicationParams.getAppUrl()%>";
var varchangeflag="<%=Helper.correctNull((String)hshValues.get("strchangeflag"))%>";
var varapproveflag="<%=Helper.correctNull((String)hshValues.get("strapproveflag"))%>";
var varStatus="<%=Helper.correctNull((String)hshValues.get("strStatus"))%>";
var varname="<%=Helper.correctNull((String)hshValues.get("strname"))%>";
var varError="<%=Helper.correctNull((String)hshValues.get("strError"))%>";
var varsecid="<%=Helper.correctNull((String)hshValues.get("strsecid"))%>";
var varUserID="<%=strUserID%>";
var varCreatedUserID="<%=Helper.correctNull((String)hshValues.get("strseccreatedby"))%>";

function loadPage()
{
	if(varError!="")
	{
		alert("This Customer is not having  any link in these following approved proposals :"+varError +", where the security is attached");
	}
	if(varStatus!="" && !(varStatus=="Success" || varStatus=="CRequest"))
	{
		if(varStatus=="Revert" || varStatus=="Rollback")
		{
			alert("Your Modification has been Reverted");	
		}
		else if(varStatus=="Approve")
		{
			alert("Security Verification Approved Successfully");	
		}
		else if(varStatus=="Reject")
		{
			alert("Your Security Verification request has been Rejected");	
		}

			document.forms[0].action = appURL + "action/inboxmails.jsp?fromlink=mailbox&optformtype=SCM";
			document.forms[0].submit();
	}
	disableFields(true);
	if(varapproveflag=="Y")
	{
		document.forms[0].cmdapprove.disabled=false;
		document.forms[0].cmdreject.disabled=false;
		document.forms[0].cmdrevertback.disabled=false;
	}
	else
	{
		document.forms[0].cmdapprove.disabled=true;
		document.forms[0].cmdreject.disabled=true;
		document.forms[0].cmdrevertback.disabled=true;
	}

	if(varCreatedUserID==varUserID)
	{
		document.forms[0].cmdrollback.disabled=false;
	}
	else
	{
		document.forms[0].cmdrollback.disabled=true;
	}
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].cmdclose.disabled=true;
		document.forms[0].action = appURL + "action/inboxmails.jsp?fromlink=mailbox&optformtype=SCM";
		document.forms[0].submit();
	}
}
function callAppIDHelp()
{
	if(document.forms[0].hidDemoId.value!="" && varapproveflag=="N")
	{
		var value1=document.forms[0].hidDemoId.value;	
		var	varQryString = appURL+"action/perapplicantidhelp.jsp?appid="+value1+"&pageFrom=SOC";
		var title = "ApplicantIDHelp";
		var prop = "scrollbars=no,width=500,height=500";	
		var xpos = (screen.width - 400) / 2;
		var ypos = (screen.height - 300) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(varQryString,title,prop);
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
	  }
}

function doApprove()
{
	document.forms[0].hidAction.value ="approve";
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanGetMethod.value="updateSecurityApproval";
	document.forms[0].action=appURL+"action/setSecurityApprove.jsp";
	document.forms[0].submit();
}
function doReject()
{
	if(confirm("Do you want to reject this change?"))
	{
		document.forms[0].hidAction.value ="reject";
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].hidBeanGetMethod.value="updateSecurityApproval";
		document.forms[0].action=appURL+"action/setSecurityApprove.jsp";
		document.forms[0].submit();
	}
}
function doRevertBack()
{
	document.forms[0].hidAction.value ="revert";
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanMethod.value="updateSecurityApproval";
	document.forms[0].hidBeanGetMethod.value="updateSecurityApproval";
	document.forms[0].action=appURL+"action/setSecurityApprove.jsp";
	document.forms[0].submit();
}

function viewSecurity()
{
	var varQryString = "<%=ApplicationParams.getAppUrl()%>action/security_detailsdisp.jsp?hidBeanId=securitymaster&hidBeanGetMethod=getSecuritiesbySecId&pagefrom=secmailbox&hidsecid="+varsecid+"&hidsectype="+document.forms[0].hidsectype.value;
	var title = "City";
	var prop = "scrollbars=yes,width=950,height=500,menubar=yes";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString,title,prop);

}
function doRollback()
{
	if(confirm("Do you want to Rolback this change?"))
	{
		document.forms[0].hidAction.value ="rollback";
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].hidBeanGetMethod.value="updateSecurityApproval";
		document.forms[0].action=appURL+"action/setSecurityApprove.jsp";
		document.forms[0].submit();
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad ="loadPage()" >
<form method="post" class="normal">
 <table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
          <tr>
            <td>
		    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	          <tr>
	            <td class="page_flow">Home -&gt;  Security Creation / Modification Verification</td>
	          </tr>
	          <tr><td>&nbsp;</td></tr>
	        </table>
        
	        <table width="90%" border="1" cellspacing="0" cellpadding="3" class="outertable" align="center">
	        <tr>
	        	<td>
			        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
					    <tr>
					       	 <td class="dataheader" align="center" colspan="4">Security Details&nbsp;</td>
					    </tr>
					    <tr>
						    <td>SECURITY OWNER NAME</td>
						    <td><input type="text" name="txt_secownername" size="40" value="<%=Helper.correctNull((String)hshValues.get("strexappname")) %>" class="finaclefieldsbgcolor">
						    <input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)hshValues.get("strexappid")) %>"></td>
						    <td>CBS ID</td>
						    <td><input type="text" name="txt_ownercbsid" value="<%=Helper.correctNull((String)hshValues.get("strexappcbsid")) %>" class="finaclefieldsbgcolor"></td>
					    </tr>
					    <tr>
						     <td>SECURITY ID</td>
						    <td><input type="text" name="txt_secid" value="<%=Helper.correctNull((String)hshValues.get("strsecid")) %>" class="finaclefieldsbgcolor">&nbsp;</td>
						    <td>SECURITY VALUE</td>
						    <td colspan="3"><input type="text" name="txt_secvalue" value="<%=Helper.correctNull((String)hshValues.get("strsecvalue")) %>" class="finaclefieldsbgcolor" style="text-align=right;"></td>
					    </tr>
					    <tr>
						     <td>SECURITY TYPE</td>
						    <td><input type="text" name="txt_sectype" value="<%=Helper.correctNull((String)hshValues.get("strsecname")) %>" class="finaclefieldsbgcolor" size="60"></td>
						    <td>SECURITY CLASSIFICATION</td>
						    <td><input type="text" name="txt_secclassification" value="<%=Helper.correctNull((String)hshValues.get("strsectype")) %>" class="finaclefieldsbgcolor"></td>
					    </tr>
					    <tr>
					     <td>SECURITY DESCRIPTION</td>
						    <td><textarea name="txt_secdesc" class="finaclefieldsbgcolor" cols="50" rows="4" onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String)hshValues.get("strsecdesc")) %></textarea></td>
					    	<td colspan="2" align="center"> <input type="button" value="View Security"  name="btn_viewSec" class="buttonStyle" onclick="viewSecurity()"> </td>
					    </tr>
					   <tr>
					    <td colspan="4">&nbsp;</td>
					    </tr>
			
				<%if(strSecFlag.equals("V")) { %>
				 	    <tr align="center">
					    <td colspan="4" class="dataheader">Modification Details</td>
					    </tr>
					  
					  	<tr class="dataheader" align="center">
					     	<td>Security Parameter </td>
					     	<td >Existing Value</td>
					     	<td colspan="2">Modified Value</td>
					     </tr> 
					    <%if(!Helper.correctNull((String)hshValues.get("SEC_SECURITYVALUE_OLD")).equalsIgnoreCase("") ){ %>
					     <tr class="datagrid" align="center">
					     	<td>Security Value </td>
			     			<td><%=Helper.correctNull((String)hshValues.get("SEC_SECURITYVALUE_OLD"))%></td>
				     		<td colspan="2"><%=Helper.correctNull((String)hshValues.get("SEC_SECURITYVALUE_NEW"))%></td>
					     </tr> 
					     <%} %>
					     
					     <%if(!Helper.correctNull((String)hshValues.get("SEC_AMTCHARGED_OLD")).equalsIgnoreCase("") ){ %>
					     <tr class="datagrid" align="center">
					     	<td>Amount Charged to other institution </td>
			     			<td><%=Helper.correctNull((String)hshValues.get("SEC_AMTCHARGED_OLD"))%></td>
				     		<td colspan="2"> <%=Helper.correctNull((String)hshValues.get("SEC_AMTCHARGED_NEW"))%></td>
					     </tr> 
					     <%} %>
					     
					     <%if(!Helper.correctNull((String)hshValues.get("SEC_VALUERNAME_OLD")).equalsIgnoreCase("") ){ %>
					     <tr class="datagrid" align="center">
					     	<td>Valuer Name</td>
				     		<td ><%=Helper.correctNull((String)hshValues.get("SEC_VALUERNAME_OLD"))%></td>
				     		<td colspan="2"><%=Helper.correctNull((String)hshValues.get("SEC_VALUERNAME_NEW"))%></td>
					     </tr> 
					     <%} %>
					      <%if(!Helper.correctNull((String)hshValues.get("SEC_VALUATIONDATE_OLD")).equalsIgnoreCase("") ){ %>
					     <tr class="datagrid" align="center">
					     	<td>Date of Valuation </td>
				     		<td><%=Helper.correctNull((String)hshValues.get("SEC_VALUATIONDATE_OLD"))%></td>
				     		<td colspan="2"><%=Helper.correctNull((String)hshValues.get("SEC_VALUATIONDATE_NEW"))%></td>
					     </tr> 
					     <%} %>
					      <%if(!Helper.correctNull((String)hshValues.get("SEC_VALUERVALUE_OLD")).equalsIgnoreCase("") ){ %>
					     <tr class="datagrid" align="center">
					     	<td>Value as per valuation </td>
				     		<td><%=Helper.correctNull((String)hshValues.get("SEC_VALUERVALUE_OLD"))%></td>
				     		<td colspan="2"><%=Helper.correctNull((String)hshValues.get("SEC_VALUERVALUE_NEW"))%></td>
					     </tr> 
					     <%} %>
					      <%if(!Helper.correctNull((String)hshValues.get("SEC_SALEVALUE_OLD")).equalsIgnoreCase("") ){ %>
					     <tr class="datagrid" align="center">
					     	<td>Forced sale value </td>
				     		<td><%=Helper.correctNull((String)hshValues.get("SEC_SALEVALUE_OLD"))%></td>
				     		<td colspan="2"><%=Helper.correctNull((String)hshValues.get("SEC_SALEVALUE_NEW"))%></td>
					     </tr> 
					     <%} %>
					     <tr>
					  		  <td colspan="4">&nbsp;</td>
					     </tr>
				    
					    
					     <%if(!Helper.correctNull((String)hshValues.get("SEC_COMMENTS")).equalsIgnoreCase("") ){ %>
					     <tr>
					     	<td>Reason for Modification </td>
					     	<td colspan="2">
					     		 <table width="95%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
					     		 <tr>
					     		 <td width="45%"> <textarea rows="3" cols="50"  onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)" readonly="readonly" class="finaclefieldsbgcolor"><%=Helper.correctNull((String)hshValues.get("SEC_COMMENTS"))%></textarea> </td>
					     		 </tr>
					     		 </table>
					     	 </td>
					     </tr> 
					     <%} %>
					  
				<% } %>	
				
					     
					    <tr>
					    <td colspan="4">&nbsp;</td>
					    </tr>
					    <%if(Helper.correctNull((String)hshValues.get("strsecapprovedby")).equalsIgnoreCase("") ){ %>
					    <tr>
					    <td colspan="4"><font color="red" size="2px">Status : Not yet Received</font></td>
					    </tr>
					    <%}else if(!Helper.correctNull((String)hshValues.get("strsecapprovedby")).equalsIgnoreCase("")){ %>
					     <tr>
					     <td colspan="4"><font color="green" size="2px"><b> Status : Received by <%=Helper.correctNull((String)hshValues.get("strsecapprovedby")) %> - <%=Helper.correctNull((String)hshValues.get("strReceived")) %></b></font></td>
					    </tr>
					    <%} %>
			        </table>
	       		 </td>
	        </tr>
	        </table>
        	</td>
        </tr>
 </table>
        
  
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
    <tr>
    <td>
	  <lapschoice:combuttonnew btnnames='Approve_Reject_Revert Back_Rollback'
		btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
		  <lapschoice:hiddentag pageid="<%=PageId%>"/> 
	  </td>
	  </tr>
	  <tr>
	  <td>&nbsp;</td>
	  </tr>
</table>
<input type="hidden" name="hidPageFrom" value="<%=Helper.correctNull((String)request.getParameter("strPageFrom")) %>">
<input type="hidden" name="hidSEC_AMTCHARGED_OLD" value="<%=Helper.correctNull((String)hshValues.get("SEC_AMTCHARGED_OLD")) %>">
<input type="hidden" name="hidSEC_AMTCHARGED_NEW" value="<%=Helper.correctNull((String)hshValues.get("SEC_AMTCHARGED_NEW")) %>">
<input type="hidden" name="txt_SECURITYVALUE_OLD" value="<%=Helper.correctNull((String)hshValues.get("SEC_SECURITYVALUE_OLD")) %>">
<input type="hidden" name="txt_SECURITYVALUE_NEW" value="<%=Helper.correctNull((String)hshValues.get("SEC_SECURITYVALUE_NEW")) %>">
<input type="hidden" name="txt_VALUERNAME_OLD" value="<%=Helper.correctNull((String)hshValues.get("SEC_VALUERNAME_OLD")) %>">
<input type="hidden" name="txt_VALUERNAME_NEW" value="<%=Helper.correctNull((String)hshValues.get("SEC_VALUERNAME_NEW")) %>">
<input type="hidden" name="txt_VALUATIONDATE_OLD" value="<%=Helper.correctNull((String)hshValues.get("SEC_VALUATIONDATE_OLD")) %>">
<input type="hidden" name="txt_VALUATIONDATE_NEW" value="<%=Helper.correctNull((String)hshValues.get("SEC_VALUATIONDATE_NEW")) %>">
<input type="hidden" name="txt_VALUERCODE_OLD" value="<%=Helper.correctNull((String)hshValues.get("SEC_VALUERCODE_OLD")) %>">
<input type="hidden" name="txt_VALUERCODE_NEW" value="<%=Helper.correctNull((String)hshValues.get("SEC_VALUERCODE_NEW")) %>">

<input type="hidden" name="txt_VALUERVALUE_OLD" value="<%=Helper.correctNull((String)hshValues.get("SEC_VALUERVALUE_OLD")) %>">
<input type="hidden" name="txt_VALUERVALUE_NEW" value="<%=Helper.correctNull((String)hshValues.get("SEC_VALUERVALUE_NEW")) %>">
<input type="hidden" name="txt_SALEVALUE_OLD" value="<%=Helper.correctNull((String)hshValues.get("SEC_SALEVALUE_OLD")) %>">
<input type="hidden" name="txt_SALEVALUE_NEW" value="<%=Helper.correctNull((String)hshValues.get("SEC_SALEVALUE_NEW")) %>">

<input type="hidden" name="hidSEC_FLAG" value="<%=Helper.correctNull((String)hshValues.get("SEC_FLAG")) %>">
<input type="hidden" name="hidsectype" value="<%=Helper.correctNull((String)hshValues.get("cus_sec_type")) %>">




</form>
</body>
</html>