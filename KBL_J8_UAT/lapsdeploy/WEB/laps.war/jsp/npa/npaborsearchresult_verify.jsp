<%@include file="../share/directives.jsp"%>
<% 
	ArrayList arrList=null;
	arrList = (ArrayList) hshValues.get("arrRow");
%>
<html>
<head>
<script>
function callPage1(id,name,org)
{
	if(id!="")
	{
		document.forms[0].hidCBSID.value=id;
		document.forms[0].hidname.value=name;
		document.forms[0].hidOrgName.value=org;
		document.forms[0].hidBeanId.value="borrowersearch";
		document.forms[0].hidBeanGetMethod.value="getNPAverfAccountDetails";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/npaverfaccountdetails.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="srchform" method ="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">   
   <%
   if( arrList!=null && arrList.size()>0)
   {
	   int arrSize=arrList.size();	   
	   ArrayList  arrData=null;
	   for(int i=0;i<arrSize;i++)
		   {
		   arrData=(ArrayList)arrList.get(i);%> 
		    <tr class="datagrid"> 
      <td width="33%"><a href="javascript:callPage1('<%=Helper.correctNull((String)arrData.get(0))%>','<%=Helper.correctNull((String)arrData.get(1))%>','<%=Helper.correctNull((String)arrData.get(2))%>')"><b>&nbsp;&nbsp;<%=Helper.correctNull((String)arrData.get(0))%></b></a></td>
      <td width="26%"> 
       <b>&nbsp;<%=Helper.correctNull((String)arrData.get(1))%>&nbsp;</b>
      </td>
      <td width="41%">&nbsp;<%=Helper.correctNull((String)arrData.get(2))%>&nbsp;</td>
       </tr>
      <%}}else{%>   
    <tr class="datagrid"> 
      <td>&nbsp;</td>
      <td align="center" ></td>
      <td  align="left"></td>
    </tr>
    <tr class="datagrid"> 
      <td>&nbsp;</td>
      <td align="center" >No Data Found</td>
      <td  align="left"></td>
    </tr>
    <tr class="datagrid"> 
      <td>&nbsp;</td>
      <td align="center" >&nbsp;</td>
      <td  align="left"></td>
    </tr>
    <%} %>
  </table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidCBSID">
<input type="hidden" name="hidname">
<input type="hidden" name="hidOrgName">
</form>
</body>
</html>
