<%/*
	Module Name:	Terms and Conditions
	Page Name:		apptermsandcond.jsp
	Descripion:		
	Created By:		Pradeep Kumar V
*/%>
<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Remarks </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
	function doOk()
	{
		if(trimtxt(document.forms[0].presentcomments.value)!="")
		{
		window.opener.document.forms[0].hidcomments.value = document.forms[0].presentcomments.value;
		window.opener.doDelete()
		window.close();
		}
		else
		{
			alert("Enter the remarks for Deleting the document");
			document.forms[0].presentcomments.focus();
		}

	}
	function doClose()
	{
		window.close();
	}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="commentsform" method="post" action="<%=ApplicationParams.getAppUrl()%>controllerservlet" class="normal">
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
  </form>
</body>
</html>


