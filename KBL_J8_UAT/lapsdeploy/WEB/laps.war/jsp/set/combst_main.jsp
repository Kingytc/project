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

function callWorkflow(pagename)
{
    document.forms[0].method="post";
	document.forms[0].hidBeanGetMethod.value="getWorkflowBST";
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
function doClose()
{
	callPage('setupnav.jsp');
}
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body >

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
      <td>
	    <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0" >
          
          <tr>
            <td valign="top" class="page_flow">Home 
              -&gt; Setup -&gt; Corporate Products ->
              Broad Terms Proposal</td>
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
        <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr> 
            <td width="64%" height="0" valign="top"> <br>
              <center>
                <fieldset > 
                <legend><b><span class="mantatory">Broad Terms Proposal</span>
                 </b></legend><br>
                <fieldset style="width:180"><br>
                <table class="outertable"  width="88%" border="0" cellspacing="0" cellpadding="15">
				  <tr> 
                    <td><b> 
                      <a href="javascript:callWorkflow('setprdworkflowbst.jsp')" ><b>Flowpoints</b></a></b></td>
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
  <div align="center">
  <lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
  </div>
   <lapschoice:hiddentag pageid='<%=PageId%>'/> 
</form>
</body>
</html>
