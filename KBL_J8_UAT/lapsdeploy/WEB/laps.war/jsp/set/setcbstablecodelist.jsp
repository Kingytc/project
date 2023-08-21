<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld" %>
<%
int intArray_Size =Integer.parseInt(Helper.correctInt((String) request
		.getParameter("Array_size")));
int intCount =Integer.parseInt(Helper.correctInt((String) request
		.getParameter("intNum")));

String strfrom=Helper.correctNull((String) request.getParameter("strfrom"));
String pagefrom=Helper.correctNull((String) request.getParameter("pagefrom"));
%>
<html>
<head>

<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
	<SCRIPT LANGUAGE="JavaScript">
	

	function getSelectedValue()
	{
		var varArraySize=<%=intArray_Size%>;
		var varCount=<%=intCount%>;
		var varstrfrom="<%=strfrom%>";
		if(varstrfrom=="intrate")
		{
			if (document.forms[0].producthelp.value !="")
			{
				for(var i=0;i<varArraySize;i++)
				 {
				 if(i==varCount){
				window.opener.document.forms[0].tablecode_gen[i].value=document.forms[0].producthelp.value;
				window.close();
				}
				}
				 
			}
			else
			{
				ShowAlert("111","Table Code");
			}
		}
		else
		{
		if (document.forms[0].producthelp.value !="")
		{
			for(var i=0;i<varArraySize;i++)
			 {
			 if(i==varCount){
			window.opener.document.forms[0].tablecode[i].value=document.forms[0].producthelp.value;
			window.close();
			}
			}
			 
		}
		else
		{
			ShowAlert("111","Table Code");
		}
		}
	}
	
   </SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<title>LAPS</title>
</head>
<body>
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
	<form name="productlisthelp" method="post" class="normal"><br>
<table width="98%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
    <tr>
      <td><table width="98%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
        <tr>
          <td><table width="100%" border="0" cellspacing="3" cellpadding="0" class="outertable">
            <tr class="dataheader">
              <td>&nbsp;<b>Select CBS Table Code</b></td>
            </tr>
            <tr>
              <td><select name="producthelp" size="13" onDblClick="getSelectedValue()" style="width:100%;">
              <%if(pagefrom.equalsIgnoreCase("corp"))
            	  {
            	%>
            	 <laps:StaticDataNewTag apptype="126" /> 
            	 <% }else
            	  {%>
            	   <laps:CBSStaticDataNewTag apptype="28" /> 
            	  <%}%>
                
              </select></td>
            </tr>
          </table></td>
        </tr>
      </table></td>
    </tr>
  </table><br>
<table border="1" cellspacing="0" cellpadding="0" align="center" class="outertable">
  <tr>
    <td>  <table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
   <tr valign="top"> 
	<td align="center" > 
      <input type="button" class="buttonOthers" value="OK" name="createbtn" tabindex="21" onClick="getSelectedValue()">
            </td>
		<td align="center" > 
            <input type="button"  class="buttonClose"  value="Close" name="closebtn" tabindex="25"  onClick="window.close()">
          </td>
	</tr>
       </table></td>
  </tr>
</table>
</form>
</body>
</html>
