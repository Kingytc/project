<%@ include file="../share/directives.jsp"%>
<%String strCreatedUser=Helper.correctNull((String)hshValues.get("strseccreatedby"));
String strUserID=Helper.correctNull((String)session.getAttribute("strUserId"));%>
<html>
<head>
<title>Security Ownership Change</title>
<script  LANGUAGE="JavaScript">
var appURL ="<%=ApplicationParams.getAppUrl()%>";
var varchangeflag="<%=Helper.correctNull((String)hshValues.get("strchangeflag"))%>";
var varapproveflag="<%=Helper.correctNull((String)hshValues.get("strapproveflag"))%>";
var varStatus="<%=Helper.correctNull((String)hshValues.get("strStatus"))%>";
var varname="<%=Helper.correctNull((String)hshValues.get("strname"))%>";
var varError="<%=Helper.correctNull((String)hshValues.get("strError"))%>";
function loadPage()
{
	if(varError!="")
	{
		alert("This Customer is not having  any link in these following approved proposals :"+varError +", where the security is attached");
	}
	if(varStatus!="" && !(varStatus=="Success" || varStatus=="CRequest"))
	{
		
		if(varStatus=="Revert")
		{
			alert("Your Modification has been Reverted");	
		}
		else if(varStatus=="Approve")
		{
			alert("Security OwnerShip changed from "+varname+" to "+document.forms[0].txt_secownername.value+" Successfully");	
		}
		else if(varStatus=="Reject")
		{
			alert("Your modification for Security Owner Ship request has been Rejected");	
		}

		if(document.forms[0].hidPageFrom.value=="inbox")
		{
			document.forms[0].action = appURL + "action/mainnav.jsp";
			document.forms[0].submit();
		}
		else
		{
		document.forms[0].hidBeanId.value = "securitymaster";
		document.forms[0].hidBeanGetMethod.value = "getSecurities";
		document.forms[0].action = appURL + "action/mainnav.jsp";
		document.forms[0].submit();
		}
	}
	if(varStatus=="Success")
	{
		alert("Your Request has been Submitted Successfully");	
	}
	else if(varStatus=="CRequest")
	{
		alert("Your Cancellation Request has been executed Successfully");	
	}
	
	disableFields(true);
	if(varchangeflag=="Y")
	{
		document.forms[0].cmdchangeownershiprequest.disabled=true;
		document.forms[0].cmdcancelrequest.disabled=false;
	}
	else
	{
		document.forms[0].cmdchangeownershiprequest.disabled=true;
		document.forms[0].cmdcancelrequest.disabled=true;
	}
	if(varapproveflag=="Y")
	{
		document.forms[0].cmdapprove.disabled=false;
		document.forms[0].cmdreject.disabled=false;
		document.forms[0].cmdrevertback.disabled=false;
		document.forms[0].cmdchangeownershiprequest.disabled=true;
		document.forms[0].cmdcancelrequest.disabled=true;
		document.forms[0].cmdcancelrequest.disabled=true;
	}
	else
	{
		document.forms[0].cmdapprove.disabled=true;
		document.forms[0].cmdreject.disabled=true;
		document.forms[0].cmdrevertback.disabled=true;
	}
	
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		if(document.forms[0].hidPageFrom.value=="inbox")
		{
			document.forms[0].action = appURL + "action/mainnav.jsp";
			document.forms[0].submit();
		}
		else
		{
			document.forms[0].hidBeanId.value = "securitymaster";
			document.forms[0].hidBeanGetMethod.value = "getSecurities";
			document.forms[0].action = appURL + "action/customer_securities.jsp";
			document.forms[0].submit();
		}
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
function doChangeOwnershipRequest()
{
	document.forms[0].hidAction.value ="change";
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanGetMethod.value="updateSecurityOwnerChange";
	document.forms[0].action=appURL+"action/setsecurityownerchange.jsp";
	document.forms[0].submit();
}
function doCancelRequest()
{
	if(confirm("Do you want to cancel this request"))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].hidBeanGetMethod.value="updateSecurityOwnerChange";
		document.forms[0].action=appURL+"action/setsecurityownerchange.jsp";
		document.forms[0].submit();
	}
}
function doApprove()
{
	document.forms[0].hidAction.value ="approve";
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanGetMethod.value="updateSecurityOwnerChange";
	document.forms[0].action=appURL+"action/setsecurityownerchange.jsp";
	document.forms[0].submit();
}
function doReject()
{
	if(confirm("Do you want to reject this change?"))
	{
		document.forms[0].hidAction.value ="reject";
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].hidBeanGetMethod.value="updateSecurityOwnerChange";
		document.forms[0].action=appURL+"action/setsecurityownerchange.jsp";
		document.forms[0].submit();
	}
}
function doRevertBack()
{
	document.forms[0].hidAction.value ="revert";
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanMethod.value="updateSecurityOwnerChange";
	document.forms[0].hidBeanGetMethod.value="updateSecurityOwnerChange";
	document.forms[0].action=appURL+"action/setsecurityownerchange.jsp";
	document.forms[0].submit();
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
	            <td class="page_flow">Home -&gt;  Security Owner Change</td>
	          </tr>
	          <tr><td>&nbsp;</td></tr>
	        </table>
        
	        <table width="90%" border="1px" cellspacing="0" cellpadding="3" class="outertable" align="center">
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
						    <td><textarea name="txt_secdesc" class="finaclefieldsbgcolor" cols="50" rows="4"><%=Helper.correctNull((String)hshValues.get("strsecdesc")) %></textarea></td>
					    </tr>
					    <tr>
					    <td colspan="4" class="dataheader">CHANGE OWNERSHIP TO</td>
					    </tr>
					    <tr>
						     <td>CUSTOMER NAME</td>
						    <td><input type="text" name="txt_newsecowner" value="<%=Helper.correctNull((String)hshValues.get("strnewappname")) %>" > 
						    <input type="hidden" name="txt_newsecownerid" value="<%=Helper.correctNull((String)hshValues.get("strnewapplapsid")) %>">
						    &nbsp;<span onClick="javascript:callAppIDHelp()" style="cursor:hand"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
															 border="0"></span></td>
							<td>CBS ID</td>
							<td><input type="text" name="txt_newsecownerCBSID" value="<%=Helper.correctNull((String)hshValues.get("strnewappcbsid")) %>" ></td> 
					    </tr>
					      <tr>
					    <td colspan="4">&nbsp;</td>
					    </tr>
					    <%if(Helper.correctNull((String)hshValues.get("strsecapprovedby")).equalsIgnoreCase("") && !Helper.correctNull((String)hshValues.get("strnewapplapsid")).equalsIgnoreCase("")){ %>
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
	  <lapschoice:combuttonnew btnnames='Change Ownership Request_Cancel Request_Approve_Reject_Revert Back'
		btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
		  <lapschoice:hiddentag pageid="<%=PageId%>"/> 
	  </td>
	  </tr>
	  <tr>
	  <td>&nbsp;</td>
	  </tr>
</table>
<input type="hidden" name="hidPageFrom" value="<%=Helper.correctNull((String)request.getParameter("strPageFrom")) %>">
</form>
</body>
</html>