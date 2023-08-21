    <%@include file="../share/directives.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script type="text/javascript">

function doOk()
{
	if(document.all.presentcomments.value == "")
	{
		alert("Enter the remarks for Deleting the document");
		document.all.presentcomments.focus();

	}
	else
	{
		window.opener.document.all.hidcomments.value = document.all.presentcomments.value;
		window.opener.doDelete();
		window.close();
	}

}
function doClose()
{
	window.close();
}
</script>
</head>
<body>

 <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td colspan="3" valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                      <tr class="dataheader"> 
                        <td><b>Remark/ Reason for Deleting the Terms and Condition</b></td>
                      </tr>
                      <tr> 
                        <td align="center" class="datagrid">
                        <textarea name="presentcomments" cols="95"  rows="15" wrap="VIRTUAL" ></textarea>
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
  <lapschoice:combuttonnew btnnames='Ok' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 

</body>
</html>