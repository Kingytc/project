<%@include file="../share/directives.jsp"%>
<%ArrayList g1 = new ArrayList();
int noofrows = Integer.parseInt(request.getParameter("noofrows"));%>
<html>
<head>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varcategorytype="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>";
function callPage(compname,uniqoldid)
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrsearch.jsp?applicantoldid="+uniqoldid+"&appname="+compname;
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="srchform" method ="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">	
	<%ArrayList v = (ArrayList) hshValues.get("vecval");
			if (v != null) {
				int vecsize = v.size();

				if (vecsize != 0) {
					if (noofrows > vecsize) {
						noofrows = vecsize;
					}
					for (int l = 0; l < noofrows; l++) {
						g1 = (ArrayList) v.get(l);%>
    <tr class="datagrid"> 
       <td width="40%">
       	<a href="javascript:callPage('<%=Helper.encodeAmpersand(Helper.replaceForJavaScriptString((String)g1.get(0)))%>',
       								'<%=Helper.correctNull((String)g1.get(4))%>')" >
       	<b>&nbsp;&nbsp;<%=Helper.correctNull((String)g1.get(0))%></b></a></td>
       <td width="10%">&nbsp;&nbsp;<%=Helper.correctNull((String)g1.get(5))%></td>
       <td width="10%">&nbsp;&nbsp;<%=Helper.correctNull((String)g1.get(4))%></td>
	   <td width="10%">&nbsp;&nbsp;<%=Helper.correctNull((String)g1.get(1))%></td>
	   <td width="30%"><%=Helper.correctNull((String)g1.get(2))%>&nbsp;	   
       </td>
    </tr>
    <%}}else{%>
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
	   <%}}%>
  </table>
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>"> 
</form>
</body>
</html>
