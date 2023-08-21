<%@ include file="../share/directives.jsp"%>
<%int totsize=0;
String mode=Helper.correctNull((String)hshValues.get("mode"));
ArrayList g1 = new ArrayList();%>
<html>
<head>
<script>
  function callPage(id,compname)
  {
	select_cat = document.forms[0].select_cat.value;	
	hidPageType = document.forms[0].hidPageType.value;
	From_date=document.forms[0].From_date.value;
	To_date=document.forms[0].To_date.value;
	var hidNpaPageType = document.forms[0].hidNpaPageType.value;	
	document.forms[0].comapp_id.value=id;
	 document.forms[0].comapp_compname.value = compname ;
	 if(select_cat=="Retail")
	 {
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/persearch.jsp?applicantoldid="+id+"&appname="+compname;	
		document.forms[0].target="mainFrame";
	 }	
	 else if(select_cat=="CommercialApplication" || select_cat=="CommercialProposal")
	 {
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comsearch.jsp?id="+id;
		document.forms[0].target="mainFrame";
	 }
	  else if(select_cat=="TertiaryApplication" || select_cat=="TertiaryProposal")
	  {
	  	document.forms[0].hidCategoryType.value="OPS";
	  	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrsearch.jsp?applicantoldid="+id+"&appname="+compname;
		document.forms[0].target="mainFrame";
	  }
		document.forms[0].submit();
  }
   function callUserPage(id)
   {			  
		select_cat=document.forms[0].select_cat.value;
		From_date=document.forms[0].From_date.value;
		To_date=document.forms[0].To_date.value;	
		var page="comrunappaudit.jsp";
		var url = "<%=ApplicationParams.getAppUrl()%>action/"+page+"?select_cat="+select_cat+"&From_date="+From_date+"&To_date="+To_date+"&hidBeanGetMethod=getDataHelp&user_id="+id;
		var title = "AuditReport";
		var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
		var xpos = 5;
		var ypos = 5;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(url,title,prop);		
  }	  
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="srchform" method ="post" class="normal">
  <table class="outertable linebor"  width="100%" border="0" cellspacing="0" cellpadding="3">	
	<%if (mode.equals("user"))
	{	
	ArrayList	v = (ArrayList) hshValues.get("vecval");
	if(v!=null)
		{
		int vecsize =v.size();	
		if (vecsize != 0) 
			{							
			for(int l=0;l<vecsize;l++)
				{ 
				g1 = (ArrayList)v.get(l);%>
    			<tr class="datagrid"> 
      			<td width="44%"><a href="javascript:callUserPage('<%=Helper.correctNull((String)g1.get(2))%>')" ><b>&nbsp;&nbsp;<%=Helper.correctNull((String)g1.get(0))%></b></a></td>
	 			<td width="33%">&nbsp;&nbsp;<%=Helper.correctNull((String)g1.get(1))%></td>
    			</tr>
    			<%}}else{%>
		 	<tr class="datagrid">
					<td width="41%" >&nbsp;</td>
					<td width="20%" align="center"></td>
					<td width="15%" align="left"></td>
					<td width="21%" align="center"></td>
					<td width="21%" align="center"></td>
				</tr>
				<tr class="datagrid">
					<td width="41%" >&nbsp;</td>
					<td width="20%" align="center"></td>
					<td width="15%" align="left"></td>
					<td width="21%" align="center"></td>
					<td width="21%" align="center"></td>
				</tr>
				<tr class="datagrid">
					<td width="41%" >&nbsp;</td>
					<td width="20%" align="center">No Data Found</td>
					<td width="15%" align="left"></td>
					<td width="21%" align="center"></td>
					<td width="21%" align="center"></td>
				</tr>
			<%}
			}
		}
	else
		{
		ArrayList	v = (ArrayList) hshValues.get("vecval");
		if(v!=null)
			{
			int vecsize =v.size();
			if (vecsize != 0) 
				{
				for(int l=0;l<vecsize;l++)
					{ 
					g1 = (ArrayList)v.get(l);%>
    				<tr class="datagrid"> 
       				<td width="44%"><a href="javascript:callPage('<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.encodeAmpersand((String)g1.get(1))%>')" ><b><%=Helper.correctNull((String)g1.get(1))%>&nbsp;&nbsp;</b></a></td>
      				<td width="33%">&nbsp;&nbsp;<%=Helper.correctNull((String)g1.get(2))%></td>
				    </tr>
    				<%}}else{%>
				<tr class="datagrid">
					<td width="41%" >&nbsp;</td>
					<td width="20%" align="center"></td>
					<td width="15%" align="left"></td>
					<td width="21%" align="center"></td>
					<td width="21%" align="center"></td>
				</tr>
				<tr class="datagrid">
					<td width="41%" >&nbsp;</td>
					<td width="20%" align="center"></td>
					<td width="15%" align="left"></td>
					<td width="21%" align="center"></td>
					<td width="21%" align="center"></td>
				</tr>
				<tr class="datagrid">
					<td width="41%" >&nbsp;</td>
					<td width="20%" align="center">No Data Found</td>
					<td width="15%" align="left"></td>
					<td width="21%" align="center"></td>
					<td width="21%" align="center"></td>
				</tr>
				<%}}}%>
  </table>
<input type="hidden" name="comapp_id">
<input type="hidden" name="comapp_compname">
<input type="hidden" name="comapp_compid">
<input type="hidden" name="comapp_ssiid">
 <input type="hidden" name="hidPageType" value="<%=Helper.correctNull((String)request.getParameter("hidPageType"))%>"> 
 <input type="hidden" name="hidCategoryType" value=""> 
 <input type="hidden" name="hidSSIType" value=""> 
 <input type="hidden" name="hidNpaPageType" value="<%=Helper.correctNull((String)request.getParameter("hidNpaPageType"))%>"> 

  <input type="hidden" name="select_cat" value="<%=Helper.correctNull((String)request.getParameter("select_cat"))%>"> 

  <input type="hidden" name="From_date" value="<%=Helper.correctNull((String)request.getParameter("From_date"))%>"> 

<input type="hidden" name="To_date" value="<%=Helper.correctNull((String)request.getParameter("To_date"))%>"> 






</form>
</body>
</html>
