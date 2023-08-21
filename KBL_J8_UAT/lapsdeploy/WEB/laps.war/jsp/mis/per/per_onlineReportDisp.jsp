<%@ include file="../../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<%//=hshValues%>

<%
ArrayList arrCol=new ArrayList();
ArrayList arrRow=(ArrayList)hshValues.get("arrRow");
  String align="left";
  String strName="";
	String strName1="";
	int cnt=0;
	int sno=0;
	int i=0;
   int totcount=0;
   int totcountnew=0;
%>

<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
var outlabel="<%= hshValues.get("labels")%>";
var per="<%= hshValues.get("txtDate")%>";
var textlabel="";


var datalen ="<%= arrRow.size()%>";
function doClose()
{
	window.close();
}

function doPrintPreview()
{
	if (datalen > 0){

	win = window.open("","","scrollbars=yes,toolbars=Yes,menubar=Yes,width=800,height=450,left=60,top=40");
	
	win.document.write("<head>");
	win.document.write("<title>LAPS</title>");
	win.document.write("<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>");
	win.document.write("<link rel='stylesheet'	href='<%=ApplicationParams.getAppUrl()%>css/report.css'	type='text/css'>");
	win.document.write("</head>");
	
	win.document.write("<body bgcolor='#FFFFFF' text='#000000'>");
	
	win.document.write("<table width='100%' border='0' cellspacing='0' cellpadding='3'>");
	win.document.write("<tr>");
	win.document.write("<td align='center'><img src='"+'<%=ApplicationParams.getAppUrl()%>'+"img/kbl_newlogo.jpg'"+"></td>");          		
	win.document.write("</tr>");
	win.document.write("<tr>");
	win.document.write("<td align='center'><strong>Karnataka Bank Ltd.</strong></td>");
	win.document.write("</tr>");
	win.document.write("<tr>");
	win.document.write("<td align='center'><b>"+'<%=Helper.correctNull((String)hshValues.get("Org_Name"))%>'+"</b></td>");
	win.document.write("</tr>");
	win.document.write("</table>");
        
	win.document.write("<center>");
	win.document.write("<TABLE border='0'>");
	win.document.write("<TR>");
	win.document.write("<TD width='20%'><strong><center>"+'<%=SetupParams.getSetupParams("OnlineAppStatus",Helper.correctNull((String)hshValues.get("strStatus")))%>'+" Application Status Report for "+'<%=SetupParams.getSetupParams("OnlinePrdCodeDesc",Helper.correctNull((String)hshValues.get("loantype")))%>' +"</center></strong></TD>");
	win.document.write("</TR>");
	win.document.write("</TABLE>")
	win.document.write("</center>");
	
	win.document.write("<TABLE border='0'>");
	win.document.write("<TR>");
	win.document.write("<TD width='20%'><font size='1' face='MS Sans Serif'><B>Generated By :</B></font></TD>");
	win.document.write("<TD ><font size='1' face='MS Sans Serif'>"+'<%=(String)hshValues.get("genby")%>'+"</font></TD>");
	win.document.write("</TR>");
	win.document.write("<TR>");
	win.document.write("<TD width='20%'><font size='1' face='MS Sans Serif'><B>Generated On :</B></font></TD>");
	win.document.write("<TD ><font size='1' face='MS Sans Serif'>"+'<%=(String)hshValues.get("txtSaveDate")%>'+"</font></TD>");
	win.document.write("</TR>");
	win.document.write("<TR>");
	win.document.write("<TD > </TD>");
	win.document.write("<TD > </TD>");
	win.document.write("</TR>");
	win.document.write("<TR>");
	win.document.write("<TD > </TD>");
	win.document.write("<TD > </TD>");
	win.document.write("</TR>");
	win.document.write("<TR>");
	win.document.write("<TD > </TD>");
	win.document.write("<TD > </TD>");
	win.document.write("</TR>");
	win.document.write("</TABLE>");
	
	var agln="";
			<%
			 int totcount1=arrRow.size();
			totcountnew=totcount1-1;
			if (arrRow.size() > 0)
			{
				for(int i1=0;i1<arrRow.size();i1++)
				{ 
					sno=i;
					  arrCol=(ArrayList)arrRow.get(i1);
					  strName=Helper.correctNull((String)arrCol.get(16));
					  if(!strName.equalsIgnoreCase(strName1))
					  	{
					  	if(i1!=0){%>
					  	win.document.write("<table class='outertable'  width='80%' border='0' cellspacing='0' cellpadding='3' align='center'>");
					  	win.document.write("<tr>");		
					  	win.document.write("<td align='right'>");
					  	win.document.write("<B>"+ "Total Applications = &nbsp"+"</b>");
					  	win.document.write("<b>"+"<%=cnt%>" + "</b>");
					  	win.document.write("</td>");
					  	win.document.write("</tr>");
					  	win.document.write("</TABLE>");
			  		<% }
					  	cnt=0;
					  	} 
					  strName1=strName;
				  		if(strName.equalsIgnoreCase(strName1))
				  		{
				  			cnt++;
				  		}
				%>
				win.document.write("<table class='outertable'  width='80%' border='0' cellspacing='0' cellpadding='3' align='center'>");
				win.document.write("<tr>");
				win.document.write("<td align='left'>");
				win.document.write("<div align='left'>"+"Application Status:"+'&nbsp;'+"<%=Helper.correctNull((String)arrCol.get(16))%>"+ "</div>");
				win.document.write("</td>");
				win.document.write("</tr>");
				win.document.write("</TABLE>");
				win.document.write("<div id='top'>");
				win.document.write("<table class='outertable'  width='80%' border='0' cellspacing='0' cellpadding='3' align='center'>");
				<%if(!Helper.correctNull((String)arrCol.get(15)).equalsIgnoreCase("")){%>
				win.document.write("<tr>");
				win.document.write("<td align='right' colspan='7'>");
				win.document.write("<div align='right'>"+"Application Status:"+'&nbsp;'+"<%=Helper.correctNull((String)arrCol.get(15))%>"+ "</div>");
				win.document.write("</td>");
				win.document.write("</tr>");
		 		 <%}%>
				win.document.write("<tr>");
				win.document.write("<td align='center'>");
				win.document.write("<div align='center'>"+"S.No" +'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td align='center'>");
				win.document.write("<div align='center'>"+"Reference No" +'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td align='center'>");
				win.document.write("<div align='center'>"+"Company Name" +'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td align='center'>");
				win.document.write("<div align='center'>"+"City" +'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td align='center'>");
				win.document.write("<div align='center'>"+"Constitution" +'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td align='center'>");
				win.document.write("<div align='center'>"+"Contact Person" +'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td align='center'>");
				win.document.write("<div align='center'>"+"Phone No" +'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("</tr>");	
				win.document.write("<tr>");
				win.document.write("<td align='center'>");
				win.document.write("<div align='center'>"+"<%=i1+1%>"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td align='center'>");
				win.document.write("<div align='center'>"+"<%=Helper.correctNull((String)arrCol.get(0))%>"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td align='center'>");
				win.document.write("<div align='center'>"+"<%=Helper.correctNull((String)arrCol.get(1))%>"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td align='center'>");
				win.document.write("<div align='center'>"+"<%=Helper.correctNull((String)arrCol.get(3))%>"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td align='center'>");
				win.document.write("<div align='center'>"+"<%=Helper.correctNull((String)arrCol.get(2))%>"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td align='center'>");
				win.document.write("<div align='center'>"+"<%=Helper.correctNull((String)arrCol.get(6))%>"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td align='center'>");
				win.document.write("<div align='center'>"+"<%=Helper.correctNull((String)arrCol.get(4))%>"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("</tr>");
				win.document.write("<tr>");
				win.document.write("<td align='center' rowspan='5'>");
				win.document.write("<div align='center'>"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td rowspan='5' colspan='2' valign='top'>");
				win.document.write("<div align='left'>"+"Purpose Of Loan :"+'&nbsp;'+ "</div>");
				win.document.write("<div align='left'>"+"<%=Helper.correctNull((String)arrCol.get(5))%>"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td>");
				win.document.write("<div>"+"LOA Present"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td align='center'>");
				win.document.write("<div align='center'>"+"<%=Helper.correctNull((String)arrCol.get(8))%>"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td>");
				win.document.write("<div>"+"Term Loan"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td align='right'>");
				win.document.write("<div align='right'>"+"<%=Helper.correctNull((String)arrCol.get(12))%>"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("</tr>");
				win.document.write("<tr>");	
				win.document.write("<td>");
				win.document.write("<div>"+"LOA Proposed"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td align='center'>");
				win.document.write("<div align='center'>"+"<%=Helper.correctNull((String)arrCol.get(9))%>"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td>");
				win.document.write("<div>"+"Working Capital"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td align='right'>");
				win.document.write("<div align='right'>"+"<%=Helper.correctNull((String)arrCol.get(13))%>"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("</tr>");
				win.document.write("<tr>");	
				win.document.write("<td>");
				win.document.write("<div>"+"DOI"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td align='center'>");
				win.document.write("<div>"+"<%=Helper.correctNull((String)arrCol.get(7))%>"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td align='center'>");
				win.document.write("<div align='center'>"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td align='center'>");
				win.document.write("<div align='center'>"+""+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("</tr>");
				win.document.write("<tr>");	
				win.document.write("<td>");
				win.document.write("<div>"+"Networth"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td align='right'>");
				win.document.write("<div align='right'>"+"<%=Helper.correctNull((String)arrCol.get(10))%>"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td align='center'>");
				win.document.write("<div align='center'>"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td>");
				win.document.write("<div align='center'>"+""+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("</tr>");
				win.document.write("<tr>");	
				win.document.write("<td>");
				win.document.write("<div>"+"As on"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td align='center'>");
				win.document.write("<div align='center'>"+"<%=Helper.correctNull((String)arrCol.get(11))%>"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td>");
				win.document.write("<div>"+"Total :"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("<td align='right'>");
				win.document.write("<div align='right'>"+"<%=Helper.correctNull((String)arrCol.get(14))%>"+'&nbsp;'+ "</div>");
				win.document.write("</td>");
				win.document.write("</tr>");
				win.document.write("</table>");	
				win.document.write("</div>");	
				win.document.write("</br>");	
		<%if(i1==totcountnew){
			  	%>
			  	win.document.write("<table class='outertable'  width='80%' border='0' cellspacing='0' cellpadding='3' align='center'>");
			  	win.document.write("<tr>");		
			  	win.document.write("<td align='right'>");
			  	win.document.write("<B>"+ "Total Applications = &nbsp");
			  	win.document.write("<b>"+"<%=cnt%>" + "</b>");
			  	win.document.write("</td>");
			  	win.document.write("</tr>");
			  	win.document.write("</TABLE>");
		<% }	
		}
			}%>
  win.document.write("<TABLE border='0' cellspacing='0' cellpadding='3'>");
	win.document.write("<tr>");		
	win.document.write("<td align='left'>");
	win.document.write("<b>No of Applications = &nbsp;</b>");
	win.document.write("<b>"+"<%=totcount1%>" + "</b>");
	win.document.write("</td>");
	win.document.write("</tr>");
	win.document.write("</TABLE>");
	win.document.write("</body>");
	win.document.write("</html>");
	}
}

function printData()
{
         <%
         strName="";
     	strName1="";
     	cnt=0;
     	sno=0;
     	i=0;
         totcount=arrRow.size();
         totcountnew=totcount-1;
		  for(i=0;i<totcount;i++)
		  {
			  sno=i;
			  arrCol=(ArrayList)arrRow.get(i);
			  strName=Helper.correctNull((String)arrCol.get(16));
			  if(!strName.equalsIgnoreCase(strName1))
			  	{
			  	if(i!=0){%>
		  		document.write("<table class='outertable'  width='80%' border='0' cellspacing='0' cellpadding='3' align='center'>");
				document.write("<tr>");		
				document.write("<td align='right'>");
				document.write("<B>"+ "Total Applications = &nbsp;"+"</b>");
				document.write("<b>"+"<%=cnt%>" + "</b>");
				document.write("</td>");
				document.write("</tr>");
				document.write("</TABLE>");
	  		<% }
			  	cnt=0;
			  	} 
			  strName1=strName;
		  		if(strName.equalsIgnoreCase(strName1))
		  		{
		  			cnt++;
		  		}
		  %>
		 			document.write("<table class='outertable'  width='80%' border='0' cellspacing='0' cellpadding='3' align='center'>");
					document.write("<tr>");
					document.write("<td>");
					document.write("<div>"+'&nbsp;'+"<B>Branch Name:"+"<%=strName%>"+ "</div>");
					document.write("</td>");
					document.write("</tr>");
					document.write("</TABLE>");
		 		 	document.write("<div id='top'>");
		 			document.write("<table class='outertable'  width='80%' border='0' cellspacing='0' cellpadding='3' align='center'>");
				<%if(!Helper.correctNull((String)arrCol.get(15)).equalsIgnoreCase("")){%>
					document.write("<tr>");
					document.write("<td align='right' colspan='7'>");
					document.write("<div align='right'>"+"Application Status:"+'&nbsp;'+"<%=Helper.correctNull((String)arrCol.get(15))%>"+ "</div>");
					document.write("</td>");
					document.write("</tr>");
		 		 <%}%>
					 document.write("<tr>");
					document.write("<td align='center'>");
					document.write("<div align='center'>"+"S.No" +'&nbsp;'+ "</div>");
					document.write("</td>");
					document.write("<td align='center'>");
					document.write("<div align='center'>"+"Reference No" +'&nbsp;'+ "</div>");
					document.write("</td>");
					document.write("<td align='center'>");
					document.write("<div align='center'>"+"Company Name" +'&nbsp;'+ "</div>");
					document.write("</td>");
					document.write("<td align='center'>");
					document.write("<div align='center'>"+"City" +'&nbsp;'+ "</div>");
					document.write("</td>");
					document.write("<td align='center'>");
					document.write("<div align='center'>"+"Constitution" +'&nbsp;'+ "</div>");
					document.write("</td>");
					document.write("<td align='center'>");
					document.write("<div align='center'>"+"Contact Person" +'&nbsp;'+ "</div>");
					document.write("</td>");
					document.write("<td align='center'>");
					document.write("<div align='center'>"+"Phone No" +'&nbsp;'+ "</div>");
					document.write("</td>");
					document.write("</tr>");	
					document.write("<tr>");
					document.write("<td align='center'>");
					document.write("<div align='center'>"+"<%=i+1%>"+'&nbsp;'+ "</div>");
					document.write("</td>");
					document.write("<td align='center'>");
					document.write("<div align='center'>"+"<%=Helper.correctNull((String)arrCol.get(0))%>"+'&nbsp;'+ "</div>");
					document.write("</td>");
					document.write("<td align='center'>");
					document.write("<div align='center'>"+"<%=Helper.correctNull((String)arrCol.get(1))%>"+'&nbsp;'+ "</div>");
					document.write("</td>");
					document.write("<td align='center'>");
					document.write("<div align='center'>"+"<%=Helper.correctNull((String)arrCol.get(3))%>"+'&nbsp;'+ "</div>");
					document.write("</td>");
					document.write("<td align='center'>");
					document.write("<div align='center'>"+"<%=Helper.correctNull((String)arrCol.get(2))%>"+'&nbsp;'+ "</div>");
					document.write("</td>");
					document.write("<td align='center'>");
					document.write("<div align='center'>"+"<%=Helper.correctNull((String)arrCol.get(6))%>"+'&nbsp;'+ "</div>");
					document.write("</td>");
					document.write("<td align='center'>");
					document.write("<div align='center'>"+"<%=Helper.correctNull((String)arrCol.get(4))%>"+'&nbsp;'+ "</div>");
					document.write("</td>");
			document.write("</tr>");
			document.write("<tr>");
			document.write("<td align='center' rowspan='5'>");
			document.write("<div align='center'>"+'&nbsp;'+ "</div>");
			document.write("</td>");
			document.write("<td rowspan='5' colspan='2' valign='top'>");
			document.write("<div align='left'>"+"Purpose Of Loan :"+'&nbsp;'+ "</div>");
			document.write("<div align='left'>"+"<%=Helper.correctNull((String)arrCol.get(5))%>"+'&nbsp;'+ "</div>");
			document.write("</td>");
			document.write("<td>");
			document.write("<div>"+"LOA Present"+'&nbsp;'+ "</div>");
			document.write("</td>");
			document.write("<td align='center'>");
			document.write("<div align='center'>"+"<%=Helper.correctNull((String)arrCol.get(8))%>"+'&nbsp;'+ "</div>");
			document.write("</td>");
			document.write("<td>");
			document.write("<div>"+"Term Loan"+'&nbsp;'+ "</div>");
			document.write("</td>");
			document.write("<td align='right'>");
			document.write("<div align='right'>"+"<%=Helper.correctNull((String)arrCol.get(12))%>"+'&nbsp;'+ "</div>");
			document.write("</td>");
			document.write("</tr>");
			document.write("<tr>");	
			document.write("<td>");
			document.write("<div>"+"LOA Proposed"+'&nbsp;'+ "</div>");
			document.write("</td>");
			document.write("<td align='center'>");
			document.write("<div align='center'>"+"<%=Helper.correctNull((String)arrCol.get(9))%>"+'&nbsp;'+ "</div>");
			document.write("</td>");
			document.write("<td>");
			document.write("<div>"+"Working Capital"+'&nbsp;'+ "</div>");
			document.write("</td>");
			document.write("<td align='right'>");
			document.write("<div align='right'>"+"<%=Helper.correctNull((String)arrCol.get(13))%>"+'&nbsp;'+ "</div>");
			document.write("</td>");
			document.write("</tr>");
			document.write("<tr>");	
			document.write("<td>");
			document.write("<div>"+"DOI"+'&nbsp;'+ "</div>");
			document.write("</td>");
			document.write("<td align='center'>");
			document.write("<div>"+"<%=Helper.correctNull((String)arrCol.get(7))%>"+'&nbsp;'+ "</div>");
			document.write("</td>");
			document.write("<td align='center'>");
			document.write("<div align='center'>"+'&nbsp;'+ "</div>");
			document.write("</td>");
			document.write("<td align='center'>");
			document.write("<div align='center'>"+'&nbsp;'+ "</div>");
			document.write("</td>");
			document.write("</tr>");
			document.write("<tr>");	
			document.write("<td>");
			document.write("<div>"+"Networth"+'&nbsp;'+ "</div>");
			document.write("</td>");
			document.write("<td align='right'>");
			document.write("<div align='right'>"+"<%=Helper.correctNull((String)arrCol.get(10))%>"+'&nbsp;'+ "</div>");
			document.write("</td>");
			document.write("<td align='center'>");
			document.write("<div align='center'>"+'&nbsp;'+ "</div>");
			document.write("</td>");
			document.write("<td>");
			document.write("<div align='center'>"+""+'&nbsp;'+ "</div>");
			document.write("</td>");
			document.write("</tr>");
			document.write("<tr>");	
			document.write("<td>");
			document.write("<div>"+"As on"+'&nbsp;'+ "</div>");
			document.write("</td>");
			document.write("<td align='center'>");
			document.write("<div align='center'>"+"<%=Helper.correctNull((String)arrCol.get(11))%>"+'&nbsp;'+ "</div>");
			document.write("</td>");
			document.write("<td>");
			document.write("<div>"+"Total :"+'&nbsp;'+ "</div>");
			document.write("</td>");
			document.write("<td align='right'>");
			document.write("<div align='right'>"+"<%=Helper.correctNull((String)arrCol.get(14))%>"+'&nbsp;'+ "</div>");
			document.write("</td>");
			document.write("</tr>");
			document.write("</table>");	
			document.write("</div>");	
			document.write("</br>");			
		  <%
		  if(i==totcountnew){
			  	%>
	  		document.write("<table class='outertable'  width='80%' border='0' cellspacing='0' cellpadding='3' align='center'>");
			document.write("<tr>");		
			document.write("<td align='right'>");
			document.write("<B>"+ "Total Applications = &nbsp;</b>");
			document.write("<b>"+"<%=cnt%>" + "</b>");
			document.write("</td>");
			document.write("</tr>");
			document.write("</TABLE>");
		<% }
		  }
		  
		%>
        document.write("<table class='outertable'  width='100%' border='0' cellspacing='0' cellpadding='3'>" );
		document.write("<tr>");		
		document.write("<td align='left' >");
		document.write("<b>No of Applications = &nbsp;</b>");
		document.write("<b>"+"<%=totcount%>" + "</b>");
		document.write("</td>");
		document.write("</tr>");		
			
}
	           


</script>
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/style.css"	type="text/css">
</head>

<body >
<form name= "orgfrm" method="post" class="normal">
 <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="3" >
        <tr>
          <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td>          		
        </tr>
        <tr> 
          <td align="center"><strong>Karnataka Bank Ltd.</strong></td>
        </tr>
         <tr> 
          <td align="center"><%=Helper.correctNull((String)hshValues.get("Org_Name"))%></td>
        </tr>
        <%if(Helper.correctNull((String)hshValues.get("loantype")).trim().length()== 1){ %>
        <tr> 
          <td align="center"><b><%=SetupParams.getSetupParams("OnlineAppStatus",Helper.correctNull((String)hshValues.get("strStatus")))%> Application  Status Report for <%=SetupParams.getSetupParams("OnlinePrdCodeDesc",Helper.correctNull((String)hshValues.get("loantype")))%></b></td>
        </tr>
        <%}else{
        	String strLoanType = Helper.correctNull((String)hshValues.get("loantype")).trim().replaceAll(",","");
        	String strDesc = "";
        	int j = Helper.correctNull((String)hshValues.get("loantype")).trim().length();
        	char c=0;
        	for(i=0;i<strLoanType.trim().length();i++){
        	
        		c = strLoanType.charAt(i);
        		strDesc = strDesc + SetupParams.getSetupParams("OnlinePrdCodeDesc", Character.toString(c)) + " & ";
        }
        	strDesc = strDesc.substring(0,strDesc.length()-3);
        %>
        <tr> 
          <td align="center"><b><%=SetupParams.getSetupParams("OnlineAppStatus",Helper.correctNull((String)hshValues.get("strStatus")))%> Application  Status Report for <%=strDesc%></b></td>
        </tr>
        <%}%>
        <tr><td>
      <table width="100%"  cellspacing="0" cellpadding="0"  align="center">
      <tr> 
        <td height="3"> 
            <script>         
			printData();
 		</script>
        </td>
      </tr>
    </table>

<br>
<lapschoice:combuttonnew btnnames="Print Preview" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
</form>
</body>
</html>
