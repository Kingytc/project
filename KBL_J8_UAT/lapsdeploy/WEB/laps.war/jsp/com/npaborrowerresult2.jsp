<%@include file="../share/directives.jsp"%>
<% 
	ArrayList arrList=null;
	arrList = (ArrayList) hshValues.get("arrRow");
	String moduletype=Helper.correctNull((String)hshValues.get("moduletype"));
	int noofrows = Integer.parseInt(request.getParameter("noofrows"));
%>
<html>
<head>
<script>
function callPage1(name,id,bor_type,classifi)
{
	var module=document.forms[0].moduletype.value;
	document.forms[0].cbsid.value=id;
	/*if(module=="OTSCO")
	{	
		document.forms[0].action="<%//=ApplicationParams.getAppUrl()%>action/CompromiseProposal_generalinfo.jsp?appid="+id+"&hidborrowertype="+bor_type+"&hidmoduletype="+module+"&appname="+name;
	}
	else if(module=="SARFI")
	{
		document.forms[0].action="<%//=ApplicationParams.getAppUrl()%>action/SarfaeriProposal_page1.jsp?appid="+id+"&hidborrowertype="+bor_type+"&hidmoduletype="+module+"&appname="+name;
	}
	else if(module=="PAWO")
	{
		document.forms[0].action="<%//=ApplicationParams.getAppUrl()%>action/prudential_general.jsp?appid="+id+"&hidborrowertype="+bor_type+"&hidmoduletype="+module+"&appname="+name;
	}
	else if(module=="SUIT")
	{
		document.forms[0].action="<%//=ApplicationParams.getAppUrl()%>action/34PointsFormat_page1.jsp?appid="+id+"&hidborrowertype="+bor_type+"&hidmoduletype="+module+"&appname="+name;
	}*/
	if(module=="STAT")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/npa_monthlyborrowersearch.jsp?hidapplicantid="+id+"&apptype="+bor_type+"&hidmoduletype="+module+"&appname="+name+"&classid="+classifi;	
	}
	else
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/npasearch.jsp?appid="+id+"&hidborrowertype="+bor_type+"&hidmoduletype="+module+"&appname="+name+"&classid="+classifi;
	}
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
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
	   if(noofrows > arrSize)
		{
			noofrows =arrSize;
		}
	   for(int i=0;i<noofrows;i++)
		   {
		   arrData=(ArrayList)arrList.get(i);%> 
		    <tr class="datagrid"> 
      <td width="33%"><a href="javascript:callPage1('<%=Helper.encodeAmpersand(Helper.replaceForJavaScriptString(Helper.correctNull((String)arrData.get(0))))%>','<%=Helper.correctNull((String)arrData.get(1))%>','C','<%=Helper.correctNull((String)arrData.get(5))%>')"><b>&nbsp;&nbsp;<%=Helper.correctNull((String)arrData.get(0))%></b></a></td>
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
      <td align="center" ></td>
      <td  align="left"></td>
    </tr>
    <tr class="datagrid"> 
      <td>No Data Found</td>
      <td align="center" >&nbsp;</td>
      <td  align="left"></td>
    </tr>
    <%} %>
  </table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="cbsid">
<input type="hidden" name="moduletype" value="<%=moduletype%>">
</form>
</body>
</html>
