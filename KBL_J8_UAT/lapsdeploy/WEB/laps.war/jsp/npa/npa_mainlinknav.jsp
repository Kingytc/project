<%@include file="../share/directives.jsp"%>
<%String npatype=Helper.correctNull((String)hshValues.get("npatype"));

String strCategory=Helper.correctNull((String)request.getParameter("hidCategoryType"));%>
<HTML>
<HEAD>
<TITLE>POSTDISBBURSAL - NPA</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style_tab.css" type="text/css">
<script language="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var type="<%=npatype%>";
var varCategory="<%=strCategory%>";

function callFunction(page)
{
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}

function callFunction1(pagename, linktype)
{
	if(linktype=="PROV")
	{
		document.forms[0].hidBeanId.value = "borrowersearch";
		document.forms[0].hidBeanGetMethod.value = "getNPAProvisioning";
	}
	document.forms[0].action = appURL+"action/"+pagename+"?hidCategoryType="+linktype;
	document.forms[0].submit();
}

function callFunction2(pagename,pagetype,module)
{
	document.forms[0].hidmoduletype.value=module;
	document.forms[0].workflow.value="N";	
	document.forms[0].hidPageType.value = pagetype;
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}
function doClose()
{
	document.forms[0].action = appURL+"action/mainnav.jsp";
	document.forms[0].submit();
}
function callLoad()
{
	if(varCategory=="NPAPROV")
	{
		document.all.idnpalink1.style.display="inline";
		document.all.idnpalink.style.display="none";
	}
	else
	{
		document.all.idnpalink1.style.display="none";
		document.all.idnpalink.style.display="inline";
	}
}
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
</HEAD>
<BODY onload="callLoad();">
<form name="myform" method="post" class="normal">
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td class="lightbandcolor">&nbsp;</td>
	</tr>
	<tr>
		<td class="darkbandcolor">&nbsp;</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
	<tr> 
    	<td>
	  		<table width="100%" border="0" cellspacing="0" cellpadding="5" height="150" class="outertable" id="idnpalink">
    			<tr> 
      				<td width="33%">
      					<table width="20%" border="0" cellspacing="0" cellpadding="5" class="outertable">
      					 <tr> 
                        		<td class="menubackflow"><A HREF="javascript:callFunction2('npaborrowersearch2.jsp','NPA','STAT')">Status Note</A></td>
                      		</tr>
          					<tr> 
                        		<td class="menubackflow"><A HREF="javascript:callFunction2('npaborrowersearch2.jsp','NPA','OTSCO')">Compromise Proposal</A></td>
                      		</tr>
                    		<tr> 
                        		<td class="menubackflow"><A HREF="javascript:callFunction2('npaborrowersearch2.jsp','NPA','SARFI')">SARFAESI Proposal</A></td>
                      		</tr>
                            <tr> 
                        		<td class="menubackflow"><A HREF="javascript:callFunction2('npaborrowersearch2.jsp','NPA','SUIT')">Filing of SUIT</A></td>
                      		</tr>
	                    	<tr> 
                        		<td class="menubackflow"><A HREF="javascript:callFunction2('npaborrowersearch2.jsp','NPA','PAWO')">Write off</A></td>
                      		</tr>
                    	</table>
                  	</td>
                 </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="5" height="150" class="outertable" id="idnpalink1">
    			<tr> 
      				<td width="33%">
      					<table width="30%" border="0" cellspacing="0" cellpadding="5" class="outertable">
      						 <tr> 
                        		<td class="menubackflow" nowrap="nowrap"><b><A HREF="javascript:callFunction1('npaborrowersearch.jsp','NPA')">Request for MOC</A></b></td>
                      		</tr>
                      		<tr> 
                        		<td class="menubackflow" nowrap="nowrap"><b><A HREF="javascript:callFunction1('npa_borrowerseach_verification.jsp','NPAVERF')">Request for MOC Verification</A></b></td>
                      		</tr>
          					<tr> 
                        		<td class="menubackflow" nowrap="nowrap"><b><A HREF="javascript:callFunction1('npaprovisioning.jsp','PROV')">NPA down gradation / Provisioning</A></b></td>
                      		</tr>
                      		<tr> 
                        		<td class="menubackflow" nowrap="nowrap"><b><A HREF="javascript:callFunction('npaprovisioning_old.jsp')">NPA Reports(OLD)</A></b></td>
                      		</tr>
                      		<tr> 
                        		<td class="menubackflow" nowrap="nowrap"><b><A HREF="javascript:callFunction('npareportsecuritywise.jsp')">NPA Reports(old)-Security wise</A></b></td>
                      		</tr>
                      		<tr> 
                        		<td class="menubackflow" nowrap="nowrap"><b><A HREF="javascript:callFunction('npareportaccountwisesecuritywise.jsp')">NPA Reports-Account Wise/Security Wise</A></b></td>
                      		</tr>

                    	</table>
                  	</td>
                 </tr>
            </table>
        </td>
    </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td class="darkbandcolor">&nbsp;</td>
	</tr>
	<tr>
		<td class="lightbandcolor">&nbsp;</td>
	</tr>
</table><br>
<lapschoice:combuttonnew btnenable=''/> 
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidmoduletype" value="">
<input type="hidden" name="com_apptype" value="C">
<input type="hidden" name="workflow">
<input type="hidden" name="hidPageType" value="NPA">
</form>
</BODY>
</HTML>