<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%
	
ArrayList target =(ArrayList)hshValues.get("vecVal");
ArrayList targetCol=new ArrayList();



%>

<html>
<head>
<title>Purpose check</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaSc ript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>
var target_exi= "<%//=Helper.correctNull((String)hshValues.get("target_exi"))%>";
var path="<%=ApplicationParams.getAppUrl()%>";
function loadValues()
{  <%  
	      if(target != null) {
	      if (target.size() > 0)
		  {
	    	String fromdate = null;
			String strName=null;
			String strvalue=null;
			int year =0;
			int count=1;
			ArrayList array_year=new ArrayList();
	    	for(int i=0;i<target.size();i++)
			{
				targetCol = (ArrayList)target.get(i);
				if(targetCol != null) 
				{
					 fromdate = Helper.correctNull((String)targetCol.get(0));
					 strName="";
					 strvalue="";
					 year = Integer.parseInt(fromdate.substring(6,10));
					 if(Integer.parseInt(fromdate.substring(3,5)) <= 3)
					 {
						 year--;
					 }
					
					 if(!array_year.contains(Integer.toString(year)))
					 {
						 array_year.add(Integer.toString(year));
					 }
				}
			}
	    %>
	    parent.frames.document.forms[0].elements["sel_year"].length="<%=array_year.size()+2%>";
	    <%
	    	for(int i=0;i<array_year.size();i++)
	    	{
					strName =array_year.get(i).toString() + "-" + Integer.toString(Integer.parseInt(array_year.get(i).toString())+1);
					strvalue=array_year.get(i).toString();%>
					parent.frames.document.forms[0].elements["sel_year"].options["<%=i+2%>"].text="<%=strName%>";
					parent.frames.document.forms[0].elements["sel_year"].options["<%=i+2%>"].value="<%=strvalue%>";
		<%
		    }
		 }
		    else{ %>			
				
			 parent.frames.document.forms[0].elements["sel_year"].length=2;
	    	  
	    	
			<%}}%>
			
			
				
}

</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="bfrm" method="post"></form>
</body>
</html>