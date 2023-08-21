<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%
	
ArrayList vecPurpose =(ArrayList)hshValues.get("vecVal");
ArrayList vecCol=new ArrayList();



%>

<html>
<head>
<title>Purpose check</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaSc ript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>
var scheme_exi= "<%=Helper.correctNull((String)hshValues.get("scheme_exi"))%>";
var path="<%=ApplicationParams.getAppUrl()%>";
function loadValues()
{
	
	      <%  
	      if(vecPurpose != null) {
	      if (vecPurpose.size() > 0)
		  {
	    	  %>
	    	 
			parent.frames.document.forms[0].elements["selectterm"].length="<%=vecPurpose.size()+2%>";
	    	
			<%for(int i=0;i<vecPurpose.size();i++)
			{
				vecCol = (ArrayList)vecPurpose.get(i);
				if(vecCol != null) {
				
				String strId = Helper.correctNull((String)vecCol.get(0));
				String strName = Helper.correctNull((String)vecCol.get(1)); 
				//strName = strName+" - "+Helper.correctNull((String)vecCol.get(2));
				
				%>			
				parent.frames.document.forms[0].elements["selectterm"].options["<%=i+2%>"].text="<%=strName%>";
				parent.frames.document.forms[0].elements["selectterm"].options["<%=i+2%>"].value="<%=strId%>";
				
				
				
				
				
	      <%}}}else{%>			
				
			 parent.frames.document.forms[0].elements["selectterm"].length=2;
	    	  
	    	
			<%}}%>
			if(scheme_exi != "")
			{
				parent.frames.document.forms[0].elements["selectterm"].value=scheme_exi;
			}
			else
			{
				parent.frames.document.forms[0].elements["selectterm"].value="";
			}
			
				
}

</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="bfrm" method="post"></form>
</body>
</html>


