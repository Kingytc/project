<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

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
<script>
  function callPage(id)
  {
    document.forms[0].comapp_id.value=id;
  	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrappmaster.jsp?hidBeanId=commappmaster&hidBeanGetMethod=getData&scode=y";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
	
  }
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body bgcolor="#EEEAE3" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="srchform" method ="post">
  <table width="100%" border="0" cellspacing="1" cellpadding="3" bordercolorlight="#EBEBF8" bordercolordark="#82829F">
 
 
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
   <tr> 
      <td width="37%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="JavaScript:callPage('<%=arryCol.get(0)%>')" class="blackfont"><b>&nbsp;&nbsp;<%=arryCol.get(1)%></b></a></td>
      <td width="50%">&nbsp;&nbsp; <%=arryCol.get(2)%></td>
   </tr>
    <%
		}
   	} 	 
	}
	

 else
		{
			 %>
				  <tr > 
	      <td width="41%" class="blackfont">&nbsp;</td>
	      <td width="20%" align="center" ></td>
		  
			  	  <td width="15%" align="left"></td>
				  <td width="21%" align="center"></td>
	     		   <td width="21%" align="center"></td>
	    </tr>
					   <tr > 
	      <td width="41%" class="blackfont">&nbsp;</td>
	      <td width="20%" align="center" ></td>
		  
			  	  <td width="15%" align="left"></td>
				  <td width="21%" align="center"></td>
	     		   <td width="21%" align="center"></td>
	    </tr>
	    <tr > 
	      <td width="41%" class="blackfont">&nbsp;</td>
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

</form>
</body>
</html>
