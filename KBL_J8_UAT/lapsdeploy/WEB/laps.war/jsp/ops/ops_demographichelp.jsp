<%@include file="../share/directives.jsp"%>
<%
	String strAppid=Helper.correctNull(request.getParameter("hidappid"));
	if(strAppid.trim().equals(""))
	{
		strAppid = Helper.correctNull((String)request.getParameter("appid"));
	}
	String strApptype=Helper.correctNull(request.getParameter("apptype"));%>
<html>
<head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript">
var varapptype="<%=strApptype%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function doOk()
{
	
	var varValue=document.forms[0].appidhelp.value;
	if(varValue!="")
	{
	var varArr= varValue.split("$");
	window.opener.document.forms[0].hidCoDemoId.value=varArr[0];
	window.opener.document.forms[0].txtloan_cname.value=varArr[1];
	window.opener.document.forms[0].cmdsave.disabled=false;
	window.close();
  	}
}
function doClose()
{
	window.close();
}
	</SCRIPT>
</head>
<body class="tabactivenew">
<form name="productlisthelp" method="post" class="normal">
  <table border="1" cellspacing="0" cellpadding="3" align="center" class="outertable">
    <tr> 
      <td> 
        <table width="45%" border="0" cellspacing="1" cellpadding="5" align="center" class="outertable">
          <tr class="dataheader"> 
            <td><b>Select Applicant (Applicant - Applicant ID)</b></td>
          </tr>
          <tr> 
            <td> 
              <table align="center">
                <tr> 
                  <td> 
                    <select name="appidhelp" size="20" onDblClick="doOk()" style="width:450">
                      <lapschoice:appidlisthelp  appid='<%=strAppid%>'/>
					  </select>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
              </table>
            </td>
          </tr>
        </table>
        <br>
        <lapschoice:combuttonnew btnnames='Ok' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
        <br> 
  <!--These hidden variable need to be  in the parent form -->
<lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type="hidden" name="hidid" >

  
</form>
</body>
</html>
