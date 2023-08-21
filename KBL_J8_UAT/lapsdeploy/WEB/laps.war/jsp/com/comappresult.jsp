<%@include file="../share/directives.jsp"%>
<%
ArrayList arrcomappid= new ArrayList();
ArrayList arrcomname= new ArrayList();
ArrayList arrcomid= new ArrayList();

ArrayList arryCol=null;
ArrayList arryRow=(ArrayList)hshValues.get("arryRow");

int noofrows = Integer.parseInt(request.getParameter("noofrows"));

if(hshValues != null && hshValues.size()>0)
{
  arrcomappid=(ArrayList)hshValues.get("arrcomappid");
  arrcomname= (ArrayList)hshValues.get("arrcomname");
  arrcomid=(ArrayList)hshValues.get("arrcomid");
}
%>
<html>
<head>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
  function callPage(id)
  {
  	if(document.forms[0].hidPageType.value=="UPL")
  	{
  		document.forms[0].comapp_id.value=id;
  		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/corpupload.jsp?custtype="+id;
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
  	}
  	else
  	{
	    document.forms[0].comapp_id.value=id;
  		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comappmaster.jsp?hidBeanId=commappmaster&hidBeanGetMethod=getData&scode=y";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body>
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>

<form name="srchform" method ="post" class="normal">
  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
 
 
   <%
	
	if(arryRow!=null)
	{
	int vecsize =arryRow.size();

	if(vecsize !=0)
   {
	if(noofrows > vecsize)
	{
		noofrows =vecsize;
	}
	for(int l=0;l<noofrows;l++)
	{ 
	arryCol=(ArrayList)arryRow.get(l);
	
	if(arryCol!=null)
      	{
%>
   <tr class="datagrid"> 
      <td width="37%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="JavaScript:callPage('<%=arryCol.get(0)%>')"><b>&nbsp;&nbsp;<%=arryCol.get(1)%></b></a></td>
      <td width="50%">&nbsp;&nbsp; <%=arryCol.get(2)%></td>
   </tr>
    <%
		}
   	} 	 
	}
	

 else
		{
			 %>
				  <tr class="datagrid"> 
	      <td width="41%">&nbsp;</td>
	      <td width="20%" align="center" ></td>
		  
			  	  <td width="15%" align="left"></td>
				  <td width="21%" align="center"></td>
	     		   <td width="21%" align="center"></td>
	    </tr>
					   <tr class="datagrid"> 
	      <td width="41%">&nbsp;</td>
	      <td width="20%" align="center" ></td>
		  
			  	  <td width="15%" align="left"></td>
				  <td width="21%" align="center"></td>
	     		   <td width="21%" align="center"></td>
	    </tr>
	    <tr class="datagrid"> 
	      <td width="41%">&nbsp;</td>
	      <td width="20%" align="center" >No Data Found</td>
		  
			  	  <td width="15%" align="left"></td>
				  <td width="21%" align="center"></td>
	     		   <td width="21%" align="center"></td>
	    </tr>
			<%
		}
		
	}
	%>
  </table>
<input type="hidden" name="comapp_id">
  	<input type="hidden" name="hidPageType" value="<%=request.getParameter("hidPageType")%>">

</form>
</body>
</html>
