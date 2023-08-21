<%@ include file="../share/directives.jsp"%>
<html>
<head>
<title>LAPS- Products </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script language="JavaScript1.2"> 
var appURL = "<%=ApplicationParams.getAppUrl()%>";
</script>
<script language="javascript">
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
function doClose()
{
	callPage('setupnav.jsp');
}
</script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="">
<script language="JavaScript1.2">
function callPage(page)
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+page;
	document.forms[0].submit();
}


</script>
<form name="frmloanrpt" class="normal">
 <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class=page_flow>Home -&gt; Setup -&gt; Corporate Products -&gt; Modification in Sanction Terms</td>
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
  <table class="outertable"  width="40%" border="0" cellspacing="0" cellpadding="5"  align="center">
    <tr> 
    <td> 
        <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0" align="center" height="0">
          <tr> 
            <td width="64%" height="0" valign="top"> <br>
              <center>
                <fieldset style="width:270;"> 
                <legend> <span class="mantatory">Modification in Sanction Terms</span>
                </legend><br>
                <fieldset style="width:180"><br>
                <table class="outertable"  width="88%" border="0" cellspacing="0" cellpadding="15">
                 <tr> 
                    <td> 
                      <a href="javascript:callFunction('setmst_limit.jsp')" >Limit Master</a></td>
                  </tr>
				  <tr> 
                    <td> 
                      <a href="javascript:callFunction1('setmst_workflow.jsp','modsancterms','getMstWorkflowMasterData')" >Flowpoints</a></td>
                  </tr>
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
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
   <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="prdtype" value="M"> 
</form>
</body>
</html>
