<%@include file="../../share/directives.jsp"%>
<html>
<head>
<title>LAPS-Setup Reports Navigation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
 <script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="javascript">
<!--
//-->
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function callFunction(pagename)
{
  document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
  document.forms[0].submit();
}

function doClose()
{
	if (ConfirmMsg("100"))
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/repnav.jsp";
		document.forms[0].submit();
	}
	
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style_tab.css" type="text/css">
</head>
<body>
<form method=post class="normal" name="appReports">
<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" colSpan=5>
				<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
                  <td class="page_flow">Home -&gt; NPA -&gt; Reports</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>     
        <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="4" align="center">
          <tr> 
            <td align="center" valign="top" colspan="2">NPA Application Form Reports</td>
          </tr>
          <tr> 
            <td align="center" valign="top" width="49%">               
                <table class="outertable" width="40%" border="0" cellspacing="0" cellpadding="0" align="center">
                  <tr class="dataheader"> 
                    <td valign="top">Application</td>
                    </tr>
                    <tr>
                    <td>
                        <table class="outertable" width="94%" border="0" cellspacing="0" cellpadding="8" align="center">
						<tr> 
                            <td class="menubackflow"><a href="javaScript:callFunction('npawriteoffreport.jsp')">NPA written off</a></td>
                          </tr>
                          <tr> 
                            <td class="menubackflow"><a href="javaScript:callFunction('npaotscoreport.jsp')">NPA Compromise settlement</a></td>
                          </tr>
                          <tr> 
                            <td class="menubackflow"><a href="javaScript:callFunction('npasuitreport.jsp')">NPA Details of Legal cases</a></td>
                          </tr>                         
                           <tr> 
                            <td class="menubackflow"><a href="javaScript:callFunction('npadecreedcasesreport.jsp')">Decreed cases</a></td>
                          </tr>
                           <tr> 
                            <td class="menubackflow"><a href="javaScript:callFunction('npadecreedstatusreport.jsp')">Status of Decree execution petition</a></td>
                          </tr>
                           <tr> 
                            <td class="menubackflow"><a href="javaScript:callFunction('npasuitadvocatereport.jsp')">Advocate wise reports</a></td>
                          </tr>
                           <tr> 
                            <td class="menubackflow"><a href="javaScript:callFunction('npasaraesireport.jsp')">Details of Sarfaesi cases</a></td>
                          </tr>                       
                        </table>
                    </td>
                  </tr>
                </table>              
            </td>
          </tr>
        </table>     
<br>
<lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/> 		
<br>
<input type="hidden" name="hidPage"> 
<input type="hidden" name="hidusr_id">
</form>
</body>
</html>
