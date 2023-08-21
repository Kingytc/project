<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%
	
ArrayList arrSecurity =(ArrayList)hshValues.get("arrSec");
ArrayList arrCol=new ArrayList();
ArrayList arrInsu =(ArrayList)hshValues.get("arrInsu");
ArrayList arrCol1=new ArrayList();



%>

<html>
<head>
<title>Purpose check</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaSc ript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>
var securitynature= "<%=Helper.correctNull((String)hshValues.get("strsecurity"))%>";
var Insurance= "<%=Helper.correctNull((String)hshValues.get("Insurance"))%>";
var path="<%=ApplicationParams.getAppUrl()%>";
function loadValues()
{
	
	      <%  
	      if(arrSecurity != null) {
	      if (arrSecurity.size() > 0)
		  {
	    	  %>
	    	 
			parent.frames.document.forms[0].elements["sel_securitynature"].length="<%=arrSecurity.size()+1%>";
	    	
			<%for(int i=0;i<arrSecurity.size();i++)
			{
				arrCol = (ArrayList)arrSecurity.get(i);
				if(arrCol != null) {
				
				String strId = Helper.correctNull((String)arrCol.get(3))+"~"+Helper.correctNull((String)arrCol.get(2));
				String strName = Helper.correctNull((String)arrCol.get(0))+"-"+Helper.correctNull((String)arrCol.get(1))+"-"+Helper.correctNull((String)arrCol.get(2)); 
				
				
				%>			
				parent.frames.document.forms[0].elements["sel_securitynature"].options["<%=i+1%>"].text="<%=strName%>";
				parent.frames.document.forms[0].elements["sel_securitynature"].options["<%=i+1%>"].value="<%=strId%>";
				
				
				
				
				
	      <%}}}else{%>			
				
			 parent.frames.document.forms[0].elements["sel_securitynature"].length=1;
	
	    	
			<%}}%>
			
			 <%  
	      if(arrInsu != null) {
	      if (arrInsu.size() > 0)
		  {
	    	  %>
	    	 
			parent.frames.document.forms[0].elements["selinsurance"].length="<%=arrInsu.size()%>";
	    	
			<%for(int i=0;i<arrInsu.size();i++)
			{
				arrCol1 = (ArrayList)arrInsu.get(i);
				if(arrCol1 != null) {
				
				String strId1 = Helper.correctNull((String)arrCol1.get(0));//+"-"+Helper.correctNull((String)arrCol1.get(4))+"-"+Helper.correctNull((String)arrCol1.get(2));
				String strName1 = Helper.correctNull((String)arrCol1.get(3))+"-"+Helper.correctNull((String)arrCol1.get(1))+"-"+Helper.correctNull((String)arrCol1.get(2)); 
				
				
				%>			
				parent.frames.document.forms[0].elements["selinsurance"].options["<%=i%>"].text="<%=strName1%>";
				parent.frames.document.forms[0].elements["selinsurance"].options["<%=i%>"].value="<%=strId1%>";
				var insuranceno=parent.frames.document.forms[0].hidinsuranceno.value;
				if(insuranceno=="")
				{
					parent.frames.document.forms[0].hidinsuranceno.value="<%=Helper.correctNull((String)arrCol1.get(0))%>"+"~"+"<%=Helper.correctNull((String)arrCol1.get(4))%>"+"~"+"<%=Helper.correctNull((String)arrCol1.get(2))%>"+"@";
				}
				else
				{
					parent.frames.document.forms[0].hidinsuranceno.value=parent.frames.document.forms[0].hidinsuranceno.value+"<%=Helper.correctNull((String)arrCol1.get(0))%>"+"~"+"<%=Helper.correctNull((String)arrCol1.get(4))%>"+"~"+"<%=Helper.correctNull((String)arrCol1.get(2))%>"+"@";
				}
				
				
				
				
				
	      <%}}}else{%>
	      	parent.frames.document.forms[0].elements["selinsurance"].length=0;
	      	
	      	
	      <%}}%>
			
			
				
}

</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="bfrm" method="post"></form>
</body>
</html>


