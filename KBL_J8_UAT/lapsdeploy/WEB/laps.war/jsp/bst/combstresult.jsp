<%@include file="../share/directives.jsp"%>
<%
ArrayList arryCol=null;
ArrayList arryRow=(ArrayList)hshValues.get("arryRow");
int noofrows = Integer.parseInt(request.getParameter("noofrows"));
%>
<html>
<head>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
function callPage(id,appname,oldid)
{
 	document.forms[0].hid_comappid.value=oldid;
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/combst_appsearch.jsp?hidBeanId=broadsancterms&hidBeanGetMethod=getBSTAppnoData&id="+oldid+"&appname="+appname+"&com_id="+id;
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
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
      <td width="36%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="JavaScript:callPage('<%=arryCol.get(5)%>','<%=arryCol.get(1)%>','<%=arryCol.get(6)%>')" ><b>&nbsp;&nbsp;<%=arryCol.get(1)%></b></a></td>
      <td width="40%" align="center">&nbsp;&nbsp; <%=arryCol.get(7)%></td>
   </tr>
    <%
		}
   	} 	 
	}
	

 else
		{
			 %>
				  <tr class="datagrid"> 
	      <td width="41%" >&nbsp;</td>
	      <td width="20%" align="center" ></td>
		  
			  	  <td width="15%" align="left"></td>
				  <td width="21%" align="center"></td>
	     		   <td width="21%" align="center"></td>
	    </tr>
					   <tr class="datagrid"> 
	      <td width="41%" >&nbsp;</td>
	      <td width="20%" align="center" ></td>
		  
			  	  <td width="15%" align="left"></td>
				  <td width="21%" align="center"></td>
	     		   <td width="21%" align="center"></td>
	    </tr>
	    <tr class="datagrid"> 
	      <td width="41%" >&nbsp;</td>
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
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
