<%@ include file="../share/directives.jsp"%>
<%
String strPage = Helper.correctNull((String)request.getParameter("page"));

String pagename = Helper.correctNull((String)request.getParameter("pagename"));
%>
<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
var pagename = "<%=pagename%>";

function getSelectedValue()
{
	var varValue=document.forms[0].appidhelp.value;
	if(varValue!="")
	{
		var varArr= varValue.split("$");	
		
			if("<%=strPage%>"=="industry")
			{
			   	window.opener.document.forms[0].hidindcode.value=varArr[0];
				window.opener.document.forms[0].txt_bsrcode.value=varArr[1];
				window.opener.document.forms[0].exp_bsrdesc.value=varArr[2];
				window.opener.document.forms[0].exp_bsrmaxexp.value=varArr[3];
				window.opener.document.forms[0].exp_bsrexpirydate.value=varArr[4];
				
			}
			
		
		window.close();
	}
	else
	{
		alert("select a particular description")
	}
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
</head>
<body >
<form name="myfrm" class="normal">
  <table width="30%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable border1">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
          <tr> 
            <td ><b>Select 
              Industrial Code</b></td>
          </tr>
          <tr> 
            <td><select name="appidhelp" size="15" onDblClick="getSelectedValue()" style="width:400">
              <lapschoice:industrymasterhelp/>
            </select></td>
          </tr>
          <tr> 
            <td> 
              <table width="10%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
                <tr valign="top"> 
                  <td width="20%"> 
                    <input type=button 
							 value="OK" class="buttonothers" name="createbtn" tabindex="21" onClick="getSelectedValue()">
                  </td>
                  <td width="20%"> 
                    <input type=button class="buttonClose" value="Close" name="closebtn" tabindex="25"  onClick=window.close()>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  
<input type=hidden name="hidPageName" value="comindlist.jsp" >
<INPUT TYPE="hidden" name="hidAudit" value="<%=Helper.correctNull((String)hshValues.get("oldVal"))%>" >
<input type = "hidden" name = "hidAction">
<input type="hidden" name="grpcode" value="<%=Helper.correctNull((String)request.getParameter("grpcode"))%>">
</form>
<p>&nbsp;</p>
</body>
</html>
