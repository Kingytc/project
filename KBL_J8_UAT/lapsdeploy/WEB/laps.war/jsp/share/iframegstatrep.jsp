<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%
ArrayList vecCode =(ArrayList)hshValues.get("vecCodes");
ArrayList vecDesc =(ArrayList)hshValues.get("vecDesc");
ArrayList vecRangeFrom =(ArrayList)hshValues.get("vecRangeFrom");
ArrayList vecRangeTo =(ArrayList)hshValues.get("vecRangeTo");
%>


<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
a:hover {  color: #FF6600}
-->
</style>
<script>
function selectCategory(val)
{
if(document.forms[0].optcat.length==null)
{		if(document.forms[0].optcat.checked==true)
		{
		window.parent.document.forms[0].hidsubcatcode.value=document.forms[0].optcat.value;
		}
}
else
{
	if(document.forms[0].optcat[val].checked==true)
	{
	window.parent.document.forms[0].hidsubcatcode.value=document.forms[0].optcat[val].value;
	}
}
}



/*function showPage(appno)
{
var path="<%=ApplicationParams.getAppUrl()%>";

window.open(path+"action/perrunprint.jsp?hidBeanId=perrepprint&hidBeanMethod=getData&hidMethod=getRepDetails&hidAppno="+appno,"prns","scrollbars=Yes,toolbar=no,menubar=no,width=750,height=600,top=20,left=60");
}*/

</script>
</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<form name="prnfrm" method="post">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
    <%
for (int i=0;i<vecCode.size();i++)
{
%>
    <tr bgcolor="#FFFFFF"> 
      <td width="4%" align="left"> 
        <input type="radio" name="optcat" value="<%=vecCode.get(i)%>"  style="border-style:none" onClick="selectCategory(<%=i%>)">
      </td>
      <td width="40%" align="left"> 
        <div align="center"> 
          <input type="text" name="txtsubcat" size="25" value="<%=vecDesc.get(i)%>" readOnly style="border:0">
        </div>
      </td>
      <td width="30%" align="left"> 
        <div align="center"> 
          <input type="text" name="txtrangefrom" size="15" style="text-align:right;border:0" value="<%=vecRangeFrom.get(i)%>" readOnly>
        </div>
      </td>
      <td width="26%" align="left"> 
        <div align="center"> 
          <input type="text" name="txtrangeto" size="15" style="text-align:right;border:0"  value="<%=vecRangeTo.get(i)%>" readOnly>
        </div>
      </td>
    </tr>
    <%
}
%>
  </table>
</form>
</body>
</html>