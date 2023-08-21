<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<%
  String strTitle="";
  if(request.getParameter("cat_id").equals("0"))
  {
	  strTitle="Select the product category";
  }
  else
  {
	  strTitle="Select the product subcategory";
  }
%>
<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
function doOk()
{
	var strcat_id="<%=request.getParameter("cat_id")%>";
	if(document.forms[0].selectCategory.selectedIndex==-1)
	{
		alert("<%=strTitle%>");
		return;
	}
	if(strcat_id=="0")
	{
		window.opener.document.forms[0].cat_id.value=document.forms[0].selectCategory.value;
		window.opener.document.forms[0].catname.value=document.forms[0].selectCategory.options[document.forms[0].selectCategory.selectedIndex].text;
		window.opener.document.forms[0].prd_catid.value="";
		window.opener.document.forms[0].scatname.value="";
	}
	else
	{
		window.opener.document.forms[0].prd_catid.value=document.forms[0].selectCategory.value;
		window.opener.document.forms[0].scatname.value=document.forms[0].selectCategory.options[document.forms[0].selectCategory.selectedIndex].text;
	}
	window.close();
}

function doClose()
{
	window.close();
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body >
<form name="myfrm" class="normal">
  <table class="outertable border1"  width="45%" border="0" cellspacing="0" cellpadding="1" height="100" align="center" >
    <tr> 
      <td valign="top" height="240"> 
        <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0" height="8" align="center">
          <tr> 
            <td height="7"> 
              <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td colspan="4" height="2"> 
                    <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr> 
                        <td colspan="10"> 
                          <table class="outertable border1"  width="100%" border="0" cellspacing="0" cellpadding="0" >
                            <tr> 
                              <td height="257"> 
                                <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="4">
                                  <tr class="dataheader"> 
                                    <td height="15" colspan="2"><%=strTitle%></td>
                                  </tr>
                                  <tr> 
                                    <td height="201" colspan="2"> 
                                      <div align="center"> 
                                        <select name="selectCategory" size="10" style="width:400;height:250" onclick="document.forms[0].cmdok.disabled=false" onDblclick="doOk()">
                                          <laps:catagories /> 
                                        </select>
                                      </div>
                                    </td>
                                  </tr>
                                  <tr> 
                                 <lapschoice:combuttonnew btnnames="Ok"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
                                  </tr>
                                </table>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
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
</form>
<p>&nbsp;</p></body>
</html>
