<%@include file="../share/directives.jsp"%>
<%	ArrayList arrRow=null;
	arrRow = (ArrayList) hshValues.get("arrRow");%>
<html>
<head>
<script>
function callPage1(name,id,custorgscode,solid,classifi)
{
	var monid=document.forms[0].hidmontype.value;
	document.forms[0].cbsname.value=name;
	if(monid!="")
	{
		if(monid=="MONIT")
		{
			document.forms[0].cbsid.value=id;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/monsearch.jsp?id="+id+"&custorgscode="+custorgscode;
			document.forms[0].target="mainFrame";
			document.forms[0].submit();
		}
		else if(monid=="MONTHMONIT")
		{
			document.forms[0].cbsid.value=id;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mon_monthlyborrowersearch.jsp?id="+id+"&solid="+solid+"&classid="+classifi;
			document.forms[0].target="mainFrame";
			document.forms[0].submit();
		}
		else if(monid=="MONTHMONITREPORT")
		{ 		
		    document.forms[0].hidmontype.value=monid;
			document.forms[0].cbsid.value=id;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/monsearch.jsp?id="+id+"&monid="+monid;
			document.forms[0].target="mainFrame";
			document.forms[0].submit();
		}
		else if(monid=="MONITREVIEW")
		{
			document.forms[0].hidmontype.value=monid;
			document.forms[0].cbsid.value=id;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/tlr_reviewsearch.jsp?id="+id+"&custorgscode="+custorgscode+"&classid="+classifi;
			document.forms[0].target="mainFrame";
			document.forms[0].submit();
		}
		else if(monid=="POSTINSPEC")
		{
			 document.forms[0].hidmontype.value=monid;
			 document.forms[0].cbsid.value=id;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/post_monthlyinspection.jsp?id="+id+"&custorgscode="+custorgscode+"&classid="+classifi;
			document.forms[0].target="mainFrame";
			document.forms[0].submit();
		}
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="srchform" method ="post" class="normal">
  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable linebor">
    <%
   if(arrRow!=null && arrRow.size()>0 )
   {
	   ArrayList  arrData=null;	   
	   for(int i=0;i<arrRow.size();i++)
		   {
		   arrData=(ArrayList)arrRow.get(i);%> 
		   <tr class="datagrid"> 
      <td width="33%"><a href="javascript:callPage1('<%=Helper.encodeAmpersand(Helper.correctDoubleQuotesScript(Helper.replaceForJavaScriptString((String)arrData.get(0))))%>',
      																'<%=Helper.correctNull((String)arrData.get(1))%>',
      																'<%=Helper.correctNull((String)arrData.get(3))%>',
      																'<%=Helper.correctNull((String)arrData.get(4))%>',
      																'<%=Helper.correctNull((String)arrData.get(5))%>')" >
      																<b>&nbsp;&nbsp;<%=Helper.correctNull((String)arrData.get(0))%></b></a></td>
       
      <td width="26%" ><b>&nbsp;<%=Helper.correctNull((String)arrData.get(1))%>&nbsp;</b>
      </td>
      <td width="26%" ><b>&nbsp;<%=Helper.correctNull((String)arrData.get(2))%>&nbsp;</b>
      </td>
       </tr>
      <%}}else{%>   
    <tr class="datagrid"> 
      <td >&nbsp;</td>
      <td ></td>
      <td ></td>
    </tr>
    <tr class="datagrid"> 
      <td >&nbsp;</td>
      <td ></td>
      <td ></td>
    </tr>
    <tr class="datagrid"> 
      <td colspan="3" align="center">No Data Found</td>
    </tr>
    <tr class="datagrid"> 
      <td >&nbsp;</td>
      <td ></td>
      <td ></td>
    </tr>
    <tr class="datagrid"> 
      <td >&nbsp;</td>
      <td ></td>
      <td ></td>
    </tr>
    <%} %>
  </table>
  <lapschoice:hiddentag/>
<input type="hidden" name="cbsid" >
<input type="hidden" name="hidmontype" value="<%=request.getParameter("hidmontype")%>">
<input type="hidden" name="hidprinttype" value="<%=request.getParameter("hidprinttype")%>">
<input type="hidden" name="cbsname" value="">
</form>
</body>
</html>
