<%@include file="../share/directives.jsp"%>

<html>
<head>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">

	
	function getSelectedValue()
	{
		if(document.forms[0].grouphelp.selectedIndex==-1)
		{
			alert("Select Group name ");
			return;
		}
		val=document.forms[0].grouphelp.options[document.forms[0].grouphelp.selectedIndex].text;
		id=document.forms[0].grouphelp.options[document.forms[0].grouphelp.selectedIndex].value;
		window.opener.document.forms[0].txt_group.value = val;
		window.opener.document.forms[0].hid_groupid.value = id;
		window.close();
	
			
	}
	function doOk()
	{
		getSelectedValue();
	}
function doClose()
{
	window.close();
}

	</SCRIPT>
<style type="text/css">
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
<title>Group</title></head>
<body>
	<form name="grouphelp" method="post" class="normal">
  <table width="30%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
          <tr> 
            <td ><b>Select 
              Group </b></td>
          </tr>
          <tr> 
            <td> 
              <select name="grouphelp" size="15" onDblClick="getSelectedValue()" style="width:400">
                <option value=""><--- None ---></option>
				<lapschoice:grouphelp/> 
              </select>
            </td>
          </tr>
          <tr> 
            <td> 
              <lapschoice:combuttonnew btnnames='Ok'
													btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
                </tr>
              </table>
            </td>
          </tr>
        </table>
  
  <!--These hidden variable need to be  in the parent form -->
</form>
</body>
</html>
