<%@include file="../share/directives.jsp"%>
<%
String hidmontype1=Helper.correctNull((String)request.getParameter("hidmontype"));
String cbsid1=Helper.correctNull((String)request.getParameter("cbsid"));
String printtype=Helper.correctNull((String)request.getParameter("hidprinttype"));
%>
<html>
<head>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varmontype="<%=hidmontype1%>";
var id="<%=cbsid1%>";
var varprinttype="<%=printtype%>";
var varcustorgscode="<%=Helper.correctNull((String)request.getParameter("custorgscode"))%>"
var varOrgShortCode = "<%=Helper.correctNull((String)session.getAttribute("strOrgShortCode"))%>";

function callPage(accno,id,accstatus)
{
	if(varmontype=="MONTHMONITREPORT")
	{
	        document.forms[0].cbsaccno.value=accno;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mon_monthlyborrowersearch.jsp?id="+id+"&varprinttype="+varprinttype;
			document.forms[0].target="mainFrame";
			document.forms[0].submit();	
	}
	else if(varmontype=="MONITREVIEW")
	{
		 	document.forms[0].cbsaccno.value=accno;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mon_reviewnoteserch.jsp?id="+id+"&varprinttype="+varprinttype;
			document.forms[0].target="mainFrame";
			document.forms[0].hidBeanId.value="reviewtermloan";
			document.forms[0].hidBeanGetMethod.value="getReviewYearAndStatus";
			document.forms[0].submit();
	}
	else
	{
		if(accstatus=="O")
		{
			if(varcustorgscode!=varOrgShortCode)
			{
				accstatus="C";
			}
		}
		 document.forms[0].cbsaccno.value=accno;
		 document.forms[0].statusflag.value=accstatus;
		 document.forms[0].hidBeanGetMethod.value="getLimitRegister";
		 document.forms[0].hidBeanId.value="Register";
		 document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/limit_register.jsp?";//cbsaccno="+accno+"&statusflag="+accstatus;
		 document.forms[0].target="mainFrame";
		 document.forms[0].submit();
	}	 
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>  
<body>
<form name=srchform class="normal">
 <table width="100%" border="0" cellspacing="1" cellpadding="1" class="outertable linebor">
    <% 
   ArrayList vec = (ArrayList)hshValues.get("vecval");
    ArrayList vec1=null;
  	if(vec!=null)
	{
	int vecsize =vec.size();
	for(int i=0;i<vecsize;i++)
	{ 
		vec1=(ArrayList)vec.get(i);
		%>
   
     <tr class="datagrid">
      <td width="9%" align="center"><a href ="javascript:callPage('<%=Helper.correctNull((String)vec1.get(0))%>', '<%=Helper.correctNull((String)vec1.get(1))%>', '<%=Helper.correctNull((String)vec1.get(3))%>')"><%=Helper.correctNull((String)vec1.get(0))%></a></td>
     	<td width="18%" align="center"><%=Helper.correctNull((String)vec1.get(1))%>&nbsp;</td>
      <td width="20%" align="left"><%=Helper.correctNull((String)vec1.get(2))%>&nbsp;</td>    
    </tr>
    <%}
	}%>
  </table>
  <lapschoice:hiddentag/>
<input type="hidden" name="appname">
<input type="hidden" name="cbsaccno" value="">
<input type="hidden" name="statusflag" value="">
<input type="hidden" name="hidmontype" value="<%=request.getParameter("hidmontype")%>">
<input type="hidden" name="hidprinttype" value="<%=request.getParameter("hidprinttype")%>">
<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)request.getParameter("id"))%>">
<input type="hidden" name="cbsname" value="<%=Helper.correctNull((String)request.getParameter("cbsname"))%>">
<input type="hidden" name="custorgscode" value="<%=Helper.correctNull((String)request.getParameter("custorgscode"))%>">

</form>
</body>
</html>