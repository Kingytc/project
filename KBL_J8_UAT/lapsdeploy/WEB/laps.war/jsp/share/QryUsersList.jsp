<%@include file="../share/directives.jsp"%>
<html>
<head>
<SCRIPT LANGUAGE="JavaScript">
	function doOk()
	{
		if (document.forms[0].selusrdet.value !="")
		{
			var varuserdata=document.forms[0].selusrdet.value;
			var varArr= varuserdata.split("~");
			window.opener.document.forms[0].mail_tousrid.value=document.forms[0].selusrdet.options[document.forms[0].selusrdet.selectedIndex].text;
			window.opener.document.forms[0].hidmail_tousrid.value=	varArr[0];		
			window.close();
		}
		else
		{
			ShowAlert("111","User Name");
		}
	}
	function doClose()
	{
		window.close();
	}
   </SCRIPT>
</head>
<body>
	<form name="frm" method="post" class="normal">
  <table width="50%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr align="center" class="dataheader">
      <td><b>Select Recipient</b></td>
    </tr>
    <tr>
      <td>
        <table border="0" cellspacing="0" cellpadding="15" align="center" class="outertable">
          <tr> 
            <td> 
              <table align="center" cellspacing="0" cellpadding="0" class="outertable">
                <tr> 
                  <td> 
                    <select name="selusrdet" size="13" onDblClick="doOk()" style="width:370">
                    <lapschoice:qryuserslist /> 
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
 <br>
 <lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
