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
{
var count=1;
var j=0;
var mon_names=new Array("January","February","March","April","May","June","July","August","September","October","November","December");
parent.frames.document.forms[0].elements["sel_target"].length=2;  
<%  
String[] month_names={"January","February","March","April","May","June","July","August","September","October","November","December"};
	      if(target != null) {
	      if (target.size() > 0)
		  {
	    	String fromdate = null;
			String strName=null;
			String strvalue=null;
			int year =0;
			int month=0;
			for(int i=0;i<target.size();i++)
			{
				targetCol = (ArrayList)target.get(i);
				if(targetCol != null) {
				 fromdate = Helper.correctNull((String)targetCol.get(0));
				 // //System.out.println(fromdate);
				 strName="";
				 strvalue="";
				 year = Integer.parseInt(fromdate.substring(6,10));
				 month=Integer.parseInt(fromdate.substring(3,5));
				 if(month <= 3)
				 {
					 year--;
				 }
			 		strName = month_names[month-1];
					strvalue=Integer.toString(month);
			%>
				 var yr=<%=year%>;
				 if(parent.frames.document.forms[0].txt_yearfrom.value==yr)				 
				 {
				 	parent.frames.document.forms[0].elements["sel_target"].length=count+2;
					parent.frames.document.forms[0].elements["sel_target"].options[count+1].text="<%=strName%>";
					parent.frames.document.forms[0].elements["sel_target"].options[count+1].value="<%=strvalue%>";
					count++;
				}
				
		
	      <%}}}else{%>			
				
			 parent.frames.document.forms[0].elements["sel_target"].length=2;
	    	  
	    	
			<%}}%>
			
			  parent.frames.document.forms[0].elements["sel_month"].options.length=12-(parent.frames.document.forms[0].elements["sel_target"].options.length-2)+1;
			//  parent.frames.document.forms[0].elements["sel_month"].options.length=14;
			for(var i=4,count=0;;i++)
			{
				if(i==13)
				{
					i=1;
				}
				for(j=0;j<parent.frames.document.forms[0].elements["sel_target"].options.length;j++)
				{
					if(parent.frames.document.forms[0].elements["sel_target"].options[j].value==i)
					{
						break;
					}
				}
				if(j==parent.frames.document.forms[0].elements["sel_target"].options.length)
				{
					parent.frames.document.forms[0].elements["sel_month"].options[count+1].text=mon_names[i-1];
					parent.frames.document.forms[0].elements["sel_month"].options[count+1].value=i;
					count++;
				}
				if(i==3)
				{
					break;
				}
			}			
			
				
}

</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="bfrm" method="post"></form>
</body>
</html>