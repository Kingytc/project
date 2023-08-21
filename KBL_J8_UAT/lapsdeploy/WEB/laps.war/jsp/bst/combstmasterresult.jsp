<%@include file="../share/directives.jsp"%>
<%

ArrayList arryCol=null;
ArrayList arryRow=(ArrayList)hshValues.get("arryRow");

int noofrows = Integer.parseInt(request.getParameter("noofrows"));

%>
<html>
<head>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
function callPage(id)
{
    document.forms[0].hid_comappid.value=id;
 	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/combst_custinfo.jsp?hidBeanId=broadsancterms&hidBeanGetMethod=getBSTCustomerDetailsData&link=N";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
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
      <td width="37%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="JavaScript:callPage('<%=arryCol.get(5)%>')"><b>&nbsp;&nbsp;<%=arryCol.get(1)%></b></a></td>
      <td width="50%">&nbsp;&nbsp; <%=arryCol.get(7)%></td>
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
<input type="hidden" name="hid_comappid">
  	<input type="hidden" name="hidPageType" value="<%=request.getParameter("hidPageType")%>">

</form>
</body>
</html>
