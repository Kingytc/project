<%@include file="../share/directives.jsp"%>
<html>
<head>
<%
	String strOrgaLevel=Helper.correctNull(strOrgLevel);
	String strOrgcode=Helper.correctNull(strOrgCode);
	String strAppno=Helper.correctNull((String)request.getParameter("appno"));
	String strPageName=Helper.correctNull((String)request.getParameter("pagename"));
%>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
	<SCRIPT LANGUAGE="JavaScript">
	var varPage="<%=strPageName%>";
	function doOk()
	{
		if (document.forms[0].producthelp.value !="")
		{
			if(varPage=="MSME")
			{
				window.opener.document.forms[0].hid_Branch.value=document.forms[0].producthelp.value;
				window.opener.document.forms[0].txt_Branch.value=document.forms[0].producthelp[document.forms[0].producthelp.selectedIndex].text;
			}
			else
			{
				  window.opener.document.forms[0].org_code.value=document.forms[0].producthelp.value;
				  window.opener.document.forms[0].org_name.value=document.forms[0].producthelp[document.forms[0].producthelp.selectedIndex].text;
				  if(window.opener.document.forms[0].org_name.value=="HEAD OFFICE"){
						
					  window.opener.document.all.deprt1.style.visibility="visible";
					  window.opener.document.all.deprt1.style.position="relative";
					  window.opener.document.all.deprt2.style.visibility="visible";
					  window.opener.document.all.deprt2.style.position="relative";
					}else{
						window.opener.document.all.deprt1.style.visibility="hidden";
						window.opener.document.all.deprt1.style.position="absolute";
						window.opener.document.all.deprt2.style.visibility="hidden";
						window.opener.document.all.deprt2.style.position="absolute";
					}
			}
		  window.close();
		}
		else
		{
			ShowAlert("111","Organisation Name");
		}
		window.opener.document.forms[0].mail_tousrid.value="";
	}
	function doClose()
	{
		window.close();
	}
   </SCRIPT>
</head>
<body>
	<form name="productlisthelp" method="post" class="normal">
    <table width="30%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
      <tr align="center" class="dataheader">
        <td><b>Select Organisation</b></td>
      </tr>
      <tr>
        <td>
          <table border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
            <tr> 
              <td> 
                <table align="center" cellspacing="0" cellpadding="0" align="center" class="outertable">
                  <tr align="center"> 
                    <td> 
                      <select name="producthelp" size="13" onDblClick="doOk()" style="width:200">
                        <lapschoice:banklisthelp orglevel='<%=strOrgaLevel%>' appno='<%=strAppno%>' orgcode='<%=strOrgcode%>' pagename='<%=strPageName %>'/> 
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
  <lapschoice:combuttonnew btnnames='Ok' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
</form>
</body>
</html>
