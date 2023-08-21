<%@include file="../share/directives.jsp"%>
<%

ArrayList g1 = new ArrayList();
ArrayList g2 = new ArrayList();
int noofrows = Integer.parseInt(request.getParameter("noofrows"));
ArrayList v1=new ArrayList();
int noofrows1=0;
	v1 = (ArrayList) hshValues.get("vecval");
	String strType="";
	if(v1!=null)
	{
		int vecsize1 =v1.size();
		if(vecsize1 !=0)
      	{
        	if(noofrows > vecsize1)
        	{
		    	noofrows1 =vecsize1;
		    }
		}
	}
%>
<html>
<head>
<script>
function callPage1(id,compname,cattype,oldid,democuststatus,cbsstatus,cbsid,comapp_newid)
{
	
}
function callPage(compname,cbsid)
{
	var hidPageType = document.forms[0].hidPageType.value;
	var Type = "<%=strType%>";
	document.forms[0].comapp_compname.value = compname ;
	var Flag=false;
	
		if(document.forms[0].select_cat.value=="1")
		{
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/permsearch.jsp?id="+document.forms[0].srch_txtval.value+"&name="+compname+"&cbsid="+cbsid;
		}
		else
		{
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/permsearch.jsp?name="+compname+"&cbsid="+cbsid;
		}
			document.forms[0].target="mainFrame";
			document.forms[0].submit();
			
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body>
<form name="srchform" method ="post" class="normal">
  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<% 
	ArrayList	v = (ArrayList) hshValues.get("vecval");
	
	if(v!=null)
	{
	int vecsize =v.size();

	if(vecsize !=0)
   {
	if(noofrows > vecsize)
	{
		noofrows =vecsize;
	}
	for(int l=0;l<noofrows;l++)
	{ 
		g1 = (ArrayList)v.get(l);

	
	%>
    <tr class="datagrid"> 
       <td width="37%"><a href="#" onclick="javascript:callPage('<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)g1.get(0)))%>','<%=Helper.correctNull((String)g1.get(1))%>')"><b>&nbsp;&nbsp;<%=Helper.correctNull((String)g1.get(0))%></b></a></td>
       <td width="12%">&nbsp;&nbsp;<%=Helper.correctNull((String)g1.get(1))%></td>
	   <td width="33%">&nbsp;&nbsp;<%=Helper.correctNull((String)g1.get(2))%></td>
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
<input type="hidden" name="comapp_id">
<input type="hidden" name="comapp_compname">
<input type="hidden" name="hidPageType" value="<%=Helper.correctNull((String)request.getParameter("hidPageType"))%>"> 
<input type="hidden" name="select_cat" value="<%=Helper.correctNull((String)request.getParameter("cat"))%>">
<input type="hidden" name="srch_txtval" value="<%=Helper.correctNull((String)request.getParameter("bow_name"))%>">
</form>
</body>
</html>
