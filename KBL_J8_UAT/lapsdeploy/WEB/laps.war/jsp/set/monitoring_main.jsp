<%@ include file="../share/directives.jsp"%>
<html>
<head>
<title>LAPS- Products </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<script language="JavaScript1.2"> 
var appURL = "<%=ApplicationParams.getAppUrl()%>";
</script>
<script language="javascript">
function callWorkflow(pagename)
{
    document.forms[0].method="post";
	document.forms[0].hidBeanGetMethod.value="getWorkflowmonitoring";
	document.forms[0].hidBeanId.value="setproducts";
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();	
}
function callFunction(pagename)
{
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}

function callFunction1(page,bean,method)
{
	 
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>

<script language="JavaScript1.2">
function callPage(page)
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+page;
	document.forms[0].submit();
}
function doClose()
{
	callPage('setupnav.jsp');
}

</script>
<form name="frmloanrpt" class="normal">
<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td>
	    <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0" >
          
          <tr>
            <td valign="top" class="page_flow">Home 
               -&gt;Setup -&gt;Monitoring module</td>
          </tr>
        </table>		
      </td>
    </tr>
 </table>
<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
      <td>&nbsp;</td>
  </tr>
</table>
  <br>
  <br>
  <br>
  <table class="outertable"  width="40%" border="0" cellspacing="0" cellpadding="5" align="center">
    <tr> 
    <td> 
        <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0" align="center" height="0">
          <tr> 
            <td width="64%" height="0" valign="top" align="center"> <br>
              <center>
                <fieldset style="width:270;"> 
                <legend><span class="mantatory">MONITORING
                MODULE </span></legend><br>
                <fieldset style="width:180;"><br>
                <table class="outertable"  width="88%" border="0" cellspacing="0" cellpadding="15" align="center">
                  <tr> 
                    <td> 
                      <a href="javascript:callWorkflow('monitoring_alerts.jsp')" >Monitoring Alerts</a></td>
                  </tr>
				  <tr> 
                    <td>
                      <a href="javascript:callWorkflow('setprdworkflowcommon.jsp')">Flowpoints</a></td>
                  </tr>
               <!--    <tr> 
                    <td height="0" nowrap> <b> <a href="javascript:callFunction('npadelegatepower.jsp')" class="blackfont"><font
					size="1" face="MS Sans Serif"><b>Delegated Powers</b> </font></a> 
                      </b></td>
                  </tr>
				   <tr>
                   <td height="0">
                   <font size="1" face="MS Sans Serif"><b><A HREF="javascript:callFunction1('aggregate_means.jsp','npasetup','getaggregatemeansData')" class="blackfont">Aggregate Means</a></b></font></td>
				   </tr>
				   <tr>
                   <td height="0">
                   <font size="1" face="MS Sans Serif"><b><A HREF="javascript:callFunction1('Realisible_value.jsp','npasetup','getRealisible')" class="blackfont">Realisible values</a></b></font></td>
				   </tr>
				   <tr>
                   <td height="0">
                   <font size="1" face="MS Sans Serif"><b><A HREF="javascript:callFunction1('ageofnpa.jsp','npasetup','getAgeofNpa')" class="blackfont">Age of NPA</a></b></font></td>
		 		   </tr>
				   <tr>
                   <td height="0">
                   <font size="1" face="MS Sans Serif"><b><A HREF="javascript:callFunction1('npainterest.jsp','npasetup','getNpainterest')" class="blackfont">NPA Interest Master</a></b></font></td>
				   </tr>
				   <tr>
                   <td height="0">
                   <font size="1" face="MS Sans Serif"><b><A HREF="javascript:callFunction1('npamethodology.jsp','npasetup','getMethodology')" class="blackfont">Methodology</a></b></font></td>
				   </tr>
				   <tr>
                   <td height="0">
                   <font size="1" face="MS Sans Serif"><b><A HREF="javascript:callFunction1('legal_position.jsp','npasetup','getLegalPosition')" class="blackfont">Legal Position</a></b></font></td>
				   </tr>--> 
                </table>
                </fieldset> <br>  
                <br>
                </fieldset> 
              </center>
              <br>
            </td>
          </tr>
        </table>
    </td>
  </tr>
</table>
  <br>
  <div align="center">
  <lapschoice:combuttonnew 
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
</div>
<lapschoice:hiddentag pageid='<%=PageId%>' />
</form>
</body>
</html>
