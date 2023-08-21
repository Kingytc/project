<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />        
<lapschoice:handleerror />
<%
String strRefId = Helper.correctNull((String)hshValues.get("strRefId"));
if(!strRefId.equalsIgnoreCase(""))
{
	strRefId = Helper.correctNull((String)hshValues.get("strRefId"));
}
if(!strRefId.equalsIgnoreCase(""))
{
	strRefId=(String) session.getAttribute("SANDISREFIF");
}
String	strSchemeName= Helper.correctNull((String)request.getParameter("hidschemeName")).trim();
	
//String strSancFlag = Helper.correctNull((String) hshValues.get("SANCTION_FLAG")); 

String strSancFlag = Helper.correctNull((String) hshValues.get("SANCFLAG"));

%>

<html>
<head>
<title>National Portal - Sanction / Disbursement Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var refId = "<%=strRefId%>";
var SancFlag = "<%=strSancFlag%>";
var varSchemeName = "<%=strSchemeName%>";



function onLoadPage()
{
	gotoPage('psb59Sanction.jsp');
}

function gotoPage(pagename)
{	
	
		if(pagename=="psb59Sanction.jsp")
		{
			
			document.forms[0].hidApplicantId.value = refId;
			document.forms[0].hidReferId.value = refId;
			document.forms[0].hidschemeName.value = varSchemeName;

			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getPSB59SanctionDetails";
			document.forms[0].action = appURL+"action/psb59Sanction.jsp";
			document.forms[0].submit();
		}
		else if(pagename=="psb59Disbursement.jsp")
		{
			if("<%=strRefId%>"=="")
			{
				alert("Kindly Save the Sanction Details");
				return;
			}
			else if("<%=strSancFlag%>"=="")
			{
				alert("Kindly Authorize the Sanction Details");
				return;
			}
			else
			{

				alert(varSchemeName);
				document.forms[0].hidApplicantId.value = refId;
				document.forms[0].hidReferId.value = refId;
				document.forms[0].hidschemeName.value = varSchemeName;
				document.forms[0].hidBeanId.value="NationalPortal";
				document.forms[0].hidBeanGetMethod.value="getNP_Dsibursment";
				document.forms[0].action = appURL+"action/psb59Disbursement.jsp";
				document.forms[0].submit();
			}
		}
		else
		{
          return false;
		}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/NationalPortal.css" type="text/css">
<style>

</style>

</head>
<body onload=onLoadPage();>
<form name="" method="post"> 
 <table width="100%" cellspacing="1" border="0" cellpadding="0" align="center" >
	<tbody>
		<tr class="accord-header" >
			<td width="50%" align="center" nowrap> 
            <b><a href="javascript:gotoPage('psb59Sanction.jsp')" class="bluefont">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
            Update Sanction Details</a></b></font>
            </td>
            <td width="50%" align="center" nowrap> 
            <b><a href="javascript:gotoPage('psb59Disbursement.jsp')" class="bluefont">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
            Update Disbursement Details</a></b></font>
            </td>									
		</tr>							
	</tbody>
</table>

  <input type="hidden" name="hidBeanId" value="">
    <input type="hidden" name="hidBeanGetMethod" value="">
    <input type="hidden" name="hidBeanMethod" value="">
    <input type="hidden" name="hidApplicantId" value="">
    <input type="hidden" name="hidschemeId" value="">
    <input type="hidden" name="hidschemeName" value="">
     <input type="hidden" name="hidSourceUrl" value="">
     <input type="hidden" name="hidReferId" value="">
</form>								
</body>
</html>