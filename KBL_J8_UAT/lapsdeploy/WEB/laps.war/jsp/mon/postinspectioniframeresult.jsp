<%@include file="../share/directives.jsp"%>
<%ArrayList arrRow=new ArrayList();
ArrayList arrCol=null;	
arrRow=(ArrayList)hshValues.get("arrRow");%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
function loaddata()
{
	<%	String strflag=Helper.correctNull((String)(hshValues.get("flag")));
		if(strflag.equalsIgnoreCase("false"))
		{%>
			alert("Reports Not Generated for the year Given");
		<%}%>
}	

function callgeneral(year,month,org_code,statusflag,postins_no,type,cbsid)
{		
	document.forms[0].hidBeanId.value="postinspection";
	document.forms[0].hidBeanGetMethod.value="getPostInspectionReport";
	if(type=="R")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/postinspection_retail_report.jsp?&hidpostins_no="+postins_no+"&hidreviewtype="+type;
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(type=="A")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/followupInspectionReport.jsp?&hidpostins_no="+postins_no+"&hidreviewtype="+type;
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(type=="C")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mon_inspectionreport.jsp?hidpostins_no="+postins_no+"&hidreviewtype="+type;
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}	
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="loaddata()">
<form name="framresult" method="post" class="normal">
  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
    <%
   String Months[]={"","January","February","March","April","May","June","July","August","September","October","November","December"};
    arrRow=(ArrayList)hshValues.get("arrRow");
		if(arrRow!=null && arrRow.size()>0 )
		{
			for(int i=0;i<arrRow.size();i++)
			{
			arrCol = (ArrayList)arrRow.get(i);
			if(arrCol!=null && arrCol.size()>0)
			{%>
	<tr class="datagrid">
      <td>
      <a href="javascript:callgeneral('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(1))%>','<%=Helper.correctNull((String)arrCol.get(3))%>','<%=Helper.correctNull((String)arrCol.get(4))%>','<%=Helper.correctNull((String)arrCol.get(5))%>','<%=Helper.correctNull((String)arrCol.get(6))%>','<%=Helper.correctNull((String)arrCol.get(7))%>')">
      <b><%=Helper.correctNull((String)arrCol.get(0))%>&nbsp; - &nbsp;<%
      String str=Helper.correctNull((String)arrCol.get(1));
      int mon=Integer.parseInt(str);%>
      <%=Months[mon]%>&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp; <%=Helper.correctNull((String)arrCol.get(2))%>&nbsp; -&nbsp;&nbsp; <%=Helper.correctNull((String)arrCol.get(8)) %>
      </b></a>
      </td>
      </tr> 
     <%}}}%>
		</table> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)request.getParameter("cbsid"))%>">
<input type="hidden" name="cbsname" value="<%=Helper.correctNull((String)request.getParameter("cbsname"))%>">
</form>
</body>
</html>
