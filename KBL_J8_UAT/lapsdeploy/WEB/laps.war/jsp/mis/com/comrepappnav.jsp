<%@ include file="../../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%
	String str_report = Helper.correctNull((String) request.getParameter("hidreportmis"));
%>
<html>
<head>
<title>LAPS-Application Forms Reports Navigation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function callFunction(pagename,param)
{
	document.forms[0].report.value=param;
  document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename+"?report="+param;
  document.forms[0].submit();
}


function openWindow(pagename)
{
	var url = "<%=ApplicationParams.getAppUrl()%>action/"+pagename;
	window.open(url,"report","scrollbars=yes,toolbars=Yes,menubar=Yes,width=800,height=500,left=2,top=10");
}

function doClose()
{
	if (ConfirmMsg("100"))
	{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/repnav.jsp";
	document.forms[0].submit();
	}
	
}

function menuOptionDivMouseDown (url) {
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			document.forms[0].action=url;
			document.forms[0].submit();
		}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style_tab.css" type="text/css">
</head>
<body>
 <form method=post action="" name="appReports" class="normal">
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
  <%if(str_report.equalsIgnoreCase("CGTMSE")){ %>
   <tr>
    <td class=page_flow>Home -&gt; Reports -&gt; CGTMSE Reports  </td>
  </tr>
  <%}else{ %>
  <tr>
    <td class=page_flow>Home -&gt; Reports -&gt; Corporate & Agriculture  Reports  </td>
  </tr>
  <%} %>
</table>

  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5"  align="center">
    <tr> 
      <td valign="top"> 
       <%if(str_report.equalsIgnoreCase("CGTMSE")){ %>
            <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr> 
            <td colspan="3" align="center" valign="top">CGTMSE Application Reports</td>
          </tr>
           <tr> 
         <td>&nbsp; </td>
          </tr>
          <tr>
		 <td width="100%" valign="top" align="center"> 
       <table class="outertable border1 tableBg" width="50%" border="0" cellspacing="0" cellpadding="0" align="center" >
                    <tr class="dataheader"> 
                      <td valign="top">Reports</td>
                      </tr>
                      <tr>
                      <td>
                        <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="10">
                         <tr>
                         <TD class="menubackflow" nowrap="nowrap"><a href="javascript:callFunction('cgtmse_Enhancement_report.jsp','register_rep')">
                         	CGTMSE Register Report</a></TD>
                      </tr>
                         <tr>
                         <TD class="menubackflow" nowrap="nowrap"><a href="javascript:callFunction('cgtmse_Enhancement_report.jsp','guarant_rep')">
                         	CGTMSE Guaranteed Report</a></TD>
                      </tr>
                         <tr>
					<td class="menubackflow" nowrap="nowrap"><a href="javascript:callFunction('cgtmse_Enhancement_report.jsp','enchancement')">CGTMSE Enhancement Report</a></td> 
					</tr>
					<tr>
					<td class="menubackflow nowrap="nowrap"><a href="javascript:callFunction('cgtmse_Enhancement_report.jsp','od')">CGTMSE Reduction Report</a></td></tr>
                    <tr>
                     <td class="menubackflow nowrap="nowrap"><a href="javascript:callFunction('cgtmse_Enhancement_report.jsp','ca')">CGTMSE Daily Report
                     </a></td></tr> 
                   </table>
                        <br>
                      </td>
                    </tr>
                    <tr>
                      
                   
                    </tr>
                    <tr> </tr>
                  </table>
                  <br>           
            </td>            
          </tr>
        </table>
        <%}else{ %>
               <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr> 
            <td colspan="3" align="center" valign="top">Commercial Application Form Reports</td>
          </tr>
           <tr> 
         <td>&nbsp; </td>
          </tr>
		  <tr> 
        <td width="0%" valign="top"  style="visibility:hidden">Utilities</td>
        </tr><tr><td style="visibility:hidden">
                <table class="outertable" width="91%" border="0" cellspacing="0" cellpadding="10" align="center">
                  <tr> 
                    <td class="menubackflow"><b><a href="JavaScript:callFunction('comrepappdel.jsp')">Deleted 
                      Applications</a></b></td>
                  </tr>
                  <tr> 
                    <td class="menubackflow"><b><a href="Javascript:callFunction('comrepprint.jsp')">Print 
                      Application</a></b></td>
                  </tr>
				  <tr> 
                    <td class="menubackflow"><b><a href="Javascript:callFunction('comrepport.jsp')">PortFolio 
                      Analysis</a></b></td>
                  </tr>
                  <tr> 
                    <td class="menubackflow"><b><a href="Javascript:callFunction('comrepcashflow.jsp')">Cash 
                      Flow </a></b></td>
                  </tr>
                  <tr>
                    <td class="menubackflow"><b><a href="#" onClick="JavaScript:openWindow('comrepappstocklvl.jsp')">Stock 
                      Level Report</a></b></td>
                  </tr>
                </table>
                <br>
               <span class="dataheader">Summary</span>
                <table class="outertable" width="90%" border="0" cellspacing="0" cellpadding="10" align="center"  style="visibility:hidden">
                  <tr> 
                    <td class="menubackflow"><b><a href="JavaScript:callFunction('comrepappstatuswise.jsp')">Status 
                      Wise Summary</a></b></td>
                  </tr>
				   <tr style="visibility:hidden">
                              
                    <td class="menubackflow"><b><a href="JavaScript:callFunction('comrepborr.jsp')">Advances 
                      List </a></b></td>
                            </tr>
                </table>
            </td>
		 <td width="100%" valign="top" align="center"> 
       <table class="outertable" width="50%" border="0" cellspacing="0" cellpadding="0" align="center" >
                    <tr class="dataheader"> 
                      <td valign="top">Application</td>
                      </tr>
                      <tr>
                      <td>
                        <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="10">
                            <tr>                             
                            <td class="menubackflow"><a href="JavaScript:callFunction('comrepappstatus.jsp','')">
                            Application Status Pending/Approved/Rejected/Lodged </a></td>
                            </tr>
                            <tr>
                            <td class="menubackflow"><a href="JavaScript:callFunction('comrepuserstatus.jsp','')">
                            Userwise Status of Pending/Approved/Rejected/Lodged</a></td>
                            </tr>
                            <tr>                              
                            <td class="menubackflow"><a href="JavaScript:callFunction('comrepapptrack.jsp','')">
                            Proposal Tracking</a></td>
                            </tr>
                            <tr>                              
                            <td class="menubackflow"><a href="JavaScript:callFunction('comrepappstillopen.jsp','')">
                            Turnaround time Report</a></td>
                            </tr>
                            <!--<tr>
                            <td class="menubackflow"><a href="JavaScript:callFunction('comrepappstatus.jsp','C')">
                            State / City Wise Application Search</a></td>
                            </tr>
                          --></table>
                        <br>
                      </td>
                    </tr>
                    <tr> </tr>
                  </table>
                  <br>           
            </td>            
            <td width="0%" valign="top"  style="visibility:hidden">
              <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td valign="top" width="33%"><br>
                    Review
                      <table class="outertable" width="91%" border="0" cellspacing="0" cellpadding="10">
                        <tr> 
                          <td class="menubackflow"><b><a href="JavaScript:callFunction('comrepappinterestmod.jsp')">
                          Interest Modified Report</a></b></td>
                        </tr>
                        <tr> 
                          <td class="menubackflow"><a href="JavaScript:callFunction('comrepappefficiency.jsp')">
                          Efficiency Report</a></td>
                        </tr>
                        <tr> 
                          <td class="menubackflow"><a href="JavaScript:callFunction('comrepdoc.jsp')">
                          Document Review</a></td>
                        </tr>
                        <tr> 
                          <td class="menubackflow"><a href="#" onClick="JavaScript:openWindow('repdocumentrenew.jsp')">
                          Document Renewal </a></td>
                        </tr>
                        <tr>
                          <td class="menubackflow"><a href="JavaScript:callFunction('comrepborlist.jsp')">
                          Borrowers List </a></td>
                        </tr>
                      </table>
                  </td>
                </tr>
                <tr> 
                  <td>
                   Exception
                      <table class="outertable" width="90%" border="0" cellspacing="0" cellpadding="10" align="center">
                        <tr> 
                          <td class="menubackflow"><a href="JavaScript:callFunction('comrepapprevexcep.jsp')">
                          Reviewer Exception</a></td>
                        </tr>
                        <tr> 
                          <td class="menubackflow"><a href="JavaScript:callFunction('comrepappexception.jsp')">
                          Application Exception</a></td>
                        </tr>
                      </table>
                  </td>
                </tr>
              </table>        
            </td>
          </tr>
        </table>
        <%} %>
        <lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>  
      </td>
    </tr>
  </table>    
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type="hidden" name="hidPage">
  <input type="hidden" name="hidusr_id">
  <input type="hidden" name="report">
</form>
</body>
</html>
