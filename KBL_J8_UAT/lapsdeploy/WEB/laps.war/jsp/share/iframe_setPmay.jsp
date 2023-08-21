<%@include file="../share/directives.jsp"%>
<%
ArrayList arrRow=(ArrayList)hshValues.get("arrRow");
ArrayList arrCol=new ArrayList();
String strSubCategory=Helper.correctNull((String)request.getParameter("strSubCategory"));

String strPageFrom=Helper.correctNull((String)request.getParameter("strPageFrom"));

%>
<html>
<head>
<title>PMAY Classification</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>

function loadValues()
{
	<%
	if(strPageFrom.equalsIgnoreCase("Master")){
	 if (arrRow!=null && arrRow.size() > 0)
	 {%>	
			 parent.frames.document.forms[0].sel_pmay.length ="<%=arrRow.size()+2%>";
			 parent.frames.document.forms[0].sel_pmay.options[0].text="-----select-----";
			 parent.frames.document.forms[0].sel_pmay.options[0].value="";
			 parent.frames.document.forms[0].sel_pmay.options[1].text="-----new-----";
			 parent.frames.document.forms[0].sel_pmay.options[1].value="0";	
			 
		<%for(int i=0;i<arrRow.size();i++)
			{
				arrCol=(ArrayList)arrRow.get(i);
				String strCode=Helper.correctNull((String)arrCol.get(0));
				String strClassificationDesc=Helper.correctNull((String)arrCol.get(1));
			%>		
		    parent.frames.document.forms[0].sel_pmay.options[<%=i+2%>].text="<%=strClassificationDesc%>";
			parent.frames.document.forms[0].sel_pmay.options[<%=i+2%>].value="<%=strCode%>";
			
		<%	}
		if(!strSubCategory.equalsIgnoreCase("")){%>
		parent.frames.document.forms[0].sel_pmay.value="<%=strSubCategory%>";
	 <%}}else{%>
	 parent.frames.document.forms[0].sel_pmay.length ="2";
	 parent.frames.document.forms[0].sel_pmay.options[0].text="-----select-----";
	 parent.frames.document.forms[0].sel_pmay.options[0].value="";
	 parent.frames.document.forms[0].sel_pmay.options[1].text="-----new-----";
	 parent.frames.document.forms[0].sel_pmay.options[1].value="0";	
	 
	 <%}}else{
		  if (arrRow!=null && arrRow.size() > 0)
		 { %>	
				 parent.frames.document.forms[0].sel_house_cat.length ="<%=arrRow.size()+1%>";
				 parent.frames.document.forms[0].sel_house_cat.options[0].text="<-----select----->";
				 parent.frames.document.forms[0].sel_house_cat.options[0].value="";	
				 
			<%for(int i=0;i<arrRow.size();i++)
				{
					arrCol=(ArrayList)arrRow.get(i);
					String strCode=Helper.correctNull((String)arrCol.get(0));
					String strClassificationDesc=Helper.correctNull((String)arrCol.get(1));
				%>		
			    parent.frames.document.forms[0].sel_house_cat.options[<%=i+1%>].text="<%=strClassificationDesc%>";
				parent.frames.document.forms[0].sel_house_cat.options[<%=i+1%>].value="<%=strCode%>";
				
			<%	}
			if(!strSubCategory.equalsIgnoreCase("")){%>
			parent.frames.document.forms[0].sel_house_cat.value="<%=strSubCategory%>";
		 <%}}else{%>
		 parent.frames.document.forms[0].sel_house_cat.length ="1";
		 parent.frames.document.forms[0].sel_house_cat.options[0].text="<-----select----->";
		 parent.frames.document.forms[0].sel_house_cat.options[0].value="";
		 
		 <%}%>

<%}%>

}

</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
<<input type="hidden" name="hidsubcat" value="<%=strSubCategory %>">
</body>
</html>