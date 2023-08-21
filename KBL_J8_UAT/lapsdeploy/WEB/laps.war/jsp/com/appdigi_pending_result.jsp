<%@include file="../share/directives.jsp"%>
<%

ArrayList g1 = new ArrayList();
ArrayList g2 = new ArrayList();
ArrayList v1=new ArrayList();
int noofrows1=0,noofrows=0;
	v1 = (ArrayList) hshValues.get("vecval");
	String strType="";
	if(v1!=null)
	{
		int vecsize1 =v1.size();
		if(vecsize1 !=0)
      	{
        	 noofrows =vecsize1;
		}
	}
	
	String strhidcategory = Helper.correctNull((String)hshValues.get("hidCategoryType"));
	strhidcategory="DIGI";
%>
<html>
<head>
<script>

var varqueryType="<%=Helper.correctNull((String)hshValues.get("strqueryType"))%>";
var varhidcategory = "<%=strhidcategory%>";

function callPage(varappno,varQueryID)
{
		document.forms[0].appno.value=varappno;
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appl_digitalisation_decision.jsp?hidBeanId=DigitalAppInterface&hidBeanGetMethod=getDigiDecisionDetail&strPageFrom=inbox&hidsno="+varQueryID+"&hidType="+varqueryType+"&hidCategoryType="+varhidcategory;
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body>
<form name="srchform" method ="post" class="normal">
  <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
	<% 
	ArrayList	v = (ArrayList) hshValues.get("vecval");
	
	if(v!=null)
	{
	int vecsize =v.size();

	if(vecsize !=0)
   {
	for(int l=0;l<noofrows;l++)
	{ 
		g1 = (ArrayList)v.get(l);
	%>
    <tr class="datagrid"> 
       <td width="20%"><a href="#" onclick="javascript:callPage('<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)g1.get(0)))%>','<%=Helper.correctNull((String)g1.get(5))%>')"><b>&nbsp;&nbsp;<%=Helper.correctNull((String)g1.get(0))%></b></a></td>
       <td width="20%">&nbsp;&nbsp;<%=Helper.correctNull((String)g1.get(1))%></td>
	   <td width="20%">&nbsp;&nbsp;<%=Helper.correctNull((String)g1.get(2))%></td>
  	   <td width="20%">&nbsp;&nbsp;<%=Helper.correctNull((String)g1.get(3))%></td>
  	   <td width="20%">&nbsp;&nbsp;<%=Helper.correctNull((String)g1.get(4))%></td>
    </tr>
    <%
	 }
	}
	 else
		{
			 %>
			  <tr class="datagrid"> 
           	      <td width="37%" align="center">&nbsp;</td>
		  	  	  <td width="12%" align="left"></td>
				  <td width="33%" align="center"></td>
             </tr>
      	    <tr class="datagrid"> 
        	      <td align="center" colspan="3">No Data Found</td>
    	    </tr>
    	    <tr class="datagrid"> 
	              <td width="37%">&nbsp;</td>
		 	  	  <td width="12%" align="left"></td>
				  <td width="33%" align="center"></td>
             </tr>
	   <%
	 }
		
 }
		
		%>
</table>

<input type="hidden" name="appno">
<input type="hidden" name="comapp_id">
<input type="hidden" name="comapp_compname">
<input type="hidden" name="hidPageType" value="<%=Helper.correctNull((String)request.getParameter("hidPageType"))%>"> 
<input type="hidden" name="select_cat" value="<%=Helper.correctNull((String)request.getParameter("cat"))%>">
<input type="hidden" name="srch_txtval" value="<%=Helper.correctNull((String)request.getParameter("bow_name"))%>">
</form>
</body>
</html>
