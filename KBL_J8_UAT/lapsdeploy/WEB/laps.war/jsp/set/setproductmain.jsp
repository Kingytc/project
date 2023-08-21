<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld" %>
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

function dohlp()     
{
  var hlpvar = appURL+"phlp/setup_retailprod.htm";
  var title = "RetailProducts";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body >


<script language="JavaScript1.2">
function doClose(page)
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/setupnav.jsp";
	document.forms[0].submit();
}
function callPage(page)
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+page;
	document.forms[0].submit();
}
</script>
<form name="frmloanrpt" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr>
            <td valign="top" colSpan=5 class="page_flow">Home 
               -&gt;Setup -&gt; Retail &amp; Agriculture Products </td>
          </tr>
        </table>		
      </td>
    </tr>
 </table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
  <tr>
      <td>&nbsp;</td>
  </tr>
</table>
  <br>
  <br>
  <br>
  <table width="40%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
    <tr> 
    <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
          <tr> 
            <td width="64%" height="0" valign="top"> <br>
              <center>
                <fieldset style="width:270;height:177;"> 
                <legend>Products</legend><br>
                <fieldset ><br>
                <table width="88%" border="0" cellspacing="0" cellpadding="15" class="outertable">
                  <tr> </tr>
                  <tr> 
                    <td><a href="javascript:callPage('categorymaster.jsp')" >Category 
                      Master</a></td>
                  </tr>
                  <tr>
                    <td height="0" nowrap><a href="javascript:callPage('setmodtermscond.jsp')" >Terms 
                      and Conditions</a></td>
                  </tr>
                  <!--<tr>
                    <td height="0"><font size="1" face="MS Sans Serif"><b><a href="javascript:callPage('prodinterestrate.jsp')" class="blackfont">Interest 
                      Rates </a></b></font></td>
                  </tr>-->
                  <tr> 
                    <td height="0"><a href="javascript:callPage('setsearchproducts.jsp')" >Products</a></td>
                  </tr>
                  <!--
                  <tr> 
                    <td height="0"><font size="1" face="MS Sans Serif"><b><a href="javascript:callPage('floatbaserate.jsp')" class="blackfont">Base 
                      Interest Rate</a></b></font></td>
                  </tr>-->
                  <!-- <tr> 
                    <td height="0"><font size="1" face="MS Sans Serif"><b><a href="javascript:callPage('setuprate.jsp')" class="blackfont">Step 
                      Up Interest Rate</a></b></font></td>
                  </tr> -->
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

</form>
</body>
</html>
