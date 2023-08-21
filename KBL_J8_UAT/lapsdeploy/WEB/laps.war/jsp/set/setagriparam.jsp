<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>LAPS- Products </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
	 <script language="JavaScript1.2"> 
	 var appURL = "<%=ApplicationParams.getAppUrl()%>";
	 </script>
<script language="javascript">
function menuOptionDivMouseDown (url)
		{
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			document.forms[0].action=url;
			document.forms[0].submit();
					
		}
function callFinance()
{
        document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanGetMethod.value="getCoffeeData";
		document.forms[0].action=appURL+"action/coffeevaluationmaster.jsp";	
		document.forms[0].submit();
	
}
function callUgc()
{
        document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanGetMethod.value="getUGCData";
		document.forms[0].action=appURL+"action/UGCmaster.jsp";	
		document.forms[0].submit();
	
}
function doClose()
{
	document.forms[0].action=appURL+"action/setupnav.jsp";
	document.forms[0].submit();
}
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<script language="JavaScript1.2">
function callPage(page)
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+page;
	document.forms[0].submit();
}
function callPage1(page)
{
		document.forms[0].hidBeanId.value="setstatecity";
		document.forms[0].hidMethod.value="getData";
		document.forms[0].action=appURL+"action/setstate.jsp";
		document.forms[0].submit();
}

</script>
<form name="frmloanrpt" method="post" class="normal">
<table class="outertable" class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td>
	    <table class="outertable" class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colSpan=5> 
              <jsp:include page="../share/help.jsp" flush="true"/> 
            </td>
          </tr>
          <tr>
            <td  class="page_flow">Home -&gt; Setup -&gt; Retail &amp; Agriculture Products -&gt; Agri Parameters</td>
          </tr>
        </table>		
      </td>
    </tr>
 </table>
  <br>
  <br>
  <br>
  <table class="outertable border1" width="20%" border="0" cellspacing="0" cellpadding="5" align="center">
    <tr> 
    <td> 
       
              
                <table class="outertable" class="outertable" width="88%" border="0" cellspacing="0" cellpadding="15">
                  <tr> </tr>
                  <tr> 
                    <td><b><a href="javascript:callFinance()" >Coffee 
                      Parameters </a></b></td>
                  </tr>
                  <tr> 
                    <td  nowrap><b><a href="javascript:callUgc()" >UGC 
                      Parameters </a></b></td>
                  </tr>
                </table>
                <br>
              
              
            </td>
          </tr>
        </table>
    

  <br>
  
 <lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>


<lapschoice:hiddentag pageid='<%=PageId%>'/> 
</form>
</body>
</html>

