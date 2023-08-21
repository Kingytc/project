<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>LAPS- Products </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
	 <script language="JavaScript1.2"> 
	 var appURL = "<%=ApplicationParams.getAppUrl()%>";
	 </script>
	 <SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<style type="text/css">
.newbg{background:#dccada;padding:5px;color:#000;}
.newbg a{color:#000;} .newbg a:hover{color:#942188;}
</style>
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
	document.forms[0].action=appURL+"action/setupnav.jsp";
	document.forms[0].submit();
}
</script>
<form name="frmloanrpt" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr>
            <td class="page_flow">Home -&gt; Setup -&gt; State - City</td>
          </tr>
        </table>		
      </td>
    </tr>
 </table>

  <br>
  <br>
  <br>
  <table width="25%" border="0" cellspacing="0" align="center" class="outertable newbg" cellpadding="15">
                  <tr> <td>
                <table width="98%" border="0" cellspacing="0" align="center" class="outertable" cellpadding="7">
                  <tr> </tr>
                  <tr> 
                    <td><b><a href="javascript:callPage('setstate.jsp')" >State</a></b></td>
                  </tr>
                  <tr> 
                    <td height="0" nowrap><b><a href="javascript:callPage('setcity.jsp')" >City</a></b></td>
                  </tr>
                  <tr> 
                    <td height="0" nowrap><b><a href="javascript:callPage('districtmaster.jsp')" >District</a></b></td>
                  </tr>
                  <tr> 
                    <td height="0" nowrap><b><a href="javascript:callPage('townmaster.jsp')" >Town</a></b></td>
                  </tr>
                  
                  <tr style="display: none">
                    <td height="0"><b>
                    <a href="javascript:callPage('setbplmaster.jsp')" >Below Poverty Line Master 
                       </a></b></td>
                  </tr>
                  </table>
                  </td></tr>
                  </table>  
                  <br>   
          <table border="0" cellspacing="0" cellpadding="3" align="center">
            <tr>
            <td width="46%"> 
                
                  <lapschoice:combuttonnew btnnames="" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
                
            </td>
          </tr>
        </table>
        <lapschoice:hiddentag pageid='<%=PageId%>'/> 
</form>
</body>
</html>

