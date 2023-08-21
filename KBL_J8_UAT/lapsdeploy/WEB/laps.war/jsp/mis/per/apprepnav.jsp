<%@ include file="../../share/directives.jsp"%>
<html>
<head>
<title>LAPS-Setup Reports Navigation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function callFunction(pagename,param)
{
	document.forms[0].hidreportmis.value=param;
  	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename+"?report="+param;
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
<form class="normal">
<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td class="page_flow">Home -&gt; Retail -&gt; Reports</td>
  </tr>
</table>
  <table class="outertable border1 tableBg"  width="100%" border="0" cellspacing="0" cellpadding="5"  align="center">
    <tr> 
      <td valign="top"> 
        <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable" align="center">
          <tr> 
            <td  valign="top" colspan="2" align="center">Retail Application Form Reports</td>
          </tr>
          <tr> 
            <td valign="top" width="50%" align="center">
                <table class="outertable"  width="50%" border="0" cellspacing="0" cellpadding="5" align="center">
                  <tr class="dataheader"> 
                    <td valign="top"><b>Application</b></td>
                    </tr>
                    <tr>
                    <td>
                        <table class="outertable"  width="94%" border="0" cellspacing="2" cellpadding="10" align="center">
                          <tr> 
                            <td class="menubackflow"><a href="JavaScript:callFunction('perrepappstatus.jsp','')">
                            Application Status Pending/Approved/Rejected/Lodged</a></td>
                          </tr>
                          <tr> 
                            <td class="menubackflow"><a href="javaScript:callFunction('perrepuserstatus.jsp','')">
                              Userwise Status of Pending/Approved/Rejected/Lodged</a></td>
                          </tr>
                          <!--<tr> 
                            <td class="menubackflow"><a href="JavaScript:callFunction('perrepappsanction.jsp','')">
                            Userwise Retails and Staff Applications or Agriculture Sanctioned/Rejection/Pending</a></td>
                          </tr>
                          --><tr> 
                            <td class="menubackflow"><a href="JavaScript:callFunction('perrepapptrack.jsp','')">
                            Application Tracking</a></td>
                          </tr>
                          <tr> 
                            <td class="menubackflow"><a href="JavaScript:callFunction('perrepappstillopen.jsp','')">
                            Turnaround time Report</a></td>
                          </tr>                          
                          <tr>
                            <td class="menubackflow"><a href="JavaScript:callFunction('perrepappproduct.jsp','')">
                            Productwise status Report</a></td>
                          </tr>                          
                          <tr>
                            <td class="menubackflow"><a href="JavaScript:callFunction('perrepprddisposal.jsp','')">
                            Productwise Disposal of loan applications</a></td>
                          </tr>                        
                          <tr>
                            <td class="menubackflow"><a href="JavaScript:callFunction('perrepusrcount.jsp','')">
                            Individual User Disposal of loan Application</a></td>
                          </tr>
                        <!--  <tr>
                            <td class="menubackflow"><a href="JavaScript:callFunction('perrepappstatus.jsp','C')"> 
                              State / City Wise Application Status Pending/Approved/Rejected</a></td>
                          </tr>                         
                        --></table>
                    </td>
                  </tr>
                  <tr> 
                    <td valign="top" width="51%">
                        <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="4" align="center">
                          <tr class="dataheader"> 
                            <td valign="top">Summary</td>
                            </tr>
                            <tr>
                            <td>
                                <table class="outertable"  width="94%" border="0" cellspacing="0" cellpadding="8" align="center">
                                  <tr> 
                                    <td class="menubackflow"><a href="JavaScript:callFunction('perrepappproductwise.jsp','')">
                                    Productwise Performance status</a></td>
                                  </tr>
                                  <tr> 
                                    <td class="menubackflow"><a href="javaScript:callFunction('perrepappstatuswise.jsp','')">
                                    Disposal of applications summary</a></td>
                                  </tr>   
                                </table>                             
                            </td>
                          </tr>
                        </table>                     
                    </td>
                  </tr>
                      <tr> 
                    <td valign="top" width="51%">
                        <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="4" align="center">
                          <tr class="dataheader"> 
                            <td valign="top">Digi-Retail</td>
                            </tr>
                            <tr>
                            <td>
                                <table class="outertable"  width="94%" border="0" cellspacing="0" cellpadding="8" align="center">
                                  <tr> 
                                    <td class="menubackflow"><a href="JavaScript:callFunction('perrepappemandate.jsp','')">
                                    Pending Digital Loan Application Report</a></td>
                                  </tr>
                                 
                                </table>                             
                            </td>
                          </tr>
                        </table>                     
                    </td>
                  </tr>
                </table>              
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table><br>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type="hidden" name="hidPage">
  <input type="hidden" name="hidusr_id">
  <input type="hidden" name="hidreportmis"/>
</form>
</body>
</html>
