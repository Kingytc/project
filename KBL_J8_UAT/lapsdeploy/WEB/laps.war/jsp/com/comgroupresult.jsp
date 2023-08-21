<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>

<%
  ArrayList arrc=new ArrayList();
  arrc=(ArrayList)hshValues.get("arryRow");
  ArrayList arr=null; 
%>
<html>
<head>
<script>
  function callPage(id,industry)
{
  	document.forms[0].expid.value=id;
   	document.forms[0].exp_type.value=industry;
  	document.forms[0].mode.value="update";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comgroupmaster.jsp?hidBeanId=exposure&hidBeanGetMethod=getExpData";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="srchform" method ="post" class="normal">
  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
    <% for(int i=0;i<arrc.size();i++)
	{ 
		arr=(ArrayList)arrc.get(i);
		%>
    <tr class="datagrid"> 
     <!--  <td width="50%"><a href="javascript:callPage('<%=arr.get(0)%>','<%=arr.get(1)%>')" ><font size="1" face="MS Sans Serif">&nbsp;&nbsp;<b><%=arr.get(1)%></b></font></a></td> -->
      <td width="50%"><a href="javascript:callPage('<%=arr.get(0)%>','<%=arr.get(1)%>')" >&nbsp;&nbsp;<%=arr.get(2)%></a></td>
    </tr>
    <%}%>
  </table>
<input type="hidden" name="expid">
<input type="hidden" name="mode">
<input type="hidden" name="exp_type">
</form>
</body>
</html>
