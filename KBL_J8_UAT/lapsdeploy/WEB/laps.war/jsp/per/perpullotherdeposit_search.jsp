<%@include file="../share/directives.jsp"%>
<%			ArrayList arryCol = null;
			ArrayList arryRow = null;
			if(hshValues!=null&&hshValues.size()>0)
			{
				arryRow=(ArrayList) hshValues.get("arryRow");
			}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Other Deposit Details Search</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<script type="text/javascript">
function doAppend()
{
	var varAcNo="",varmaturitydate="",varcurrentdate="";
	<%
	String strmaturitydate="",strcurrentdate="";
	if(arryRow!=null&&arryRow.size()>0)
	{
		if(arryRow.size()>1)
		{
			for(int l=0; l<arryRow.size(); l++)
			{%>
			
			if(document.forms[0].chk_OthDepDet["<%=l%>"].checked==true)
			{
				<%arryCol=(ArrayList) arryRow.get(l);
				if(arryCol!=null)
				{%>
				varmaturitydate="<%=Helper.correctNull((String)arryCol.get(5))%>";
				varcurrentdate="<%=Helper.getCurrentDateTime()%>";
				//varmaturitydate="13/05/2021";
			   varmaturitydate=changeDateformat(varmaturitydate);
				varcurrentdate=changeDateformat(varcurrentdate);
				if(Date.parse(varmaturitydate)<Date.parse(varcurrentdate)){
					alert("Selected deposit due date is already over. Kindly make necessary modifications in FINACLE and then re select the deposit in LAPS");
					document.forms[0].chk_OthDepDet["<%=l%>"].checked=false;
				}
				if(document.forms[0].chk_OthDepDet["<%=l%>"].checked==true)
				{
				varAcNo=varAcNo+"<%=Helper.correctNull((String)arryCol.get(3))%>"+"~";
				}
				<%}%>
			}				
				
			<%}
		}
		else if(arryRow.size()==1)
		{%>
		if(document.forms[0].chk_OthDepDet.checked==true)
		{
			<%arryCol=(ArrayList) arryRow.get(0);
			if(arryCol!=null)
			{%>
		
			varmaturitydate="<%=Helper.correctNull((String)arryCol.get(5))%>";
			varcurrentdate="<%=Helper.getCurrentDateTime()%>";
			//varmaturitydate="12/05/2021";
		   varmaturitydate=changeDateformat(varmaturitydate);
			varcurrentdate=changeDateformat(varcurrentdate);
			if(Date.parse(varmaturitydate)<Date.parse(varcurrentdate)){
				alert("Selected deposit due date is already over. Kindly make necessary modifications in FINACLE and then re select the deposit in LAPS");
				document.forms[0].chk_OthDepDet.checked=false;
				
			}
			if(document.forms[0].chk_OthDepDet.checked==true)
			{
			varAcNo=varAcNo+"<%=Helper.correctNull((String)arryCol.get(3))%>"+"~";
			}
							<%}%>
		}
		<%}
	}
	%>
	window.parent.document.all.selaccno.value=varAcNo;
}
</script>
<body>
<form name="pullsearch" method="post" class="normal">
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="outertable">
	<%
		if(arryRow!=null)
		{
			int vecsize=arryRow.size();
			if(vecsize!=0)
			{
				for(int l=0; l<vecsize; l++)
				{
					arryCol=(ArrayList) arryRow.get(l);
					if(arryCol!=null)
					{
						int strSNo=l+1;
							%>
	<tr class="datagrid">
		<td width="3%" align="center">
			<input type="checkbox" onclick="doAppend();" name="chk_OthDepDet" value="<%=Integer.toString(strSNo)%>" style="border-style:none">
		</td>
		<td width="12%" align="left">&nbsp;<%=Helper.correctNull((String)arryCol.get(0))%></td>
		<td width="15%" align="center"><%=Helper.correctNull((String)arryCol.get(10))%></td>
		<td width="20%" align="center"><%=Helper.correctNull((String)arryCol.get(3))%></td>
		<td width="15%" align="right"><%=Helper.checkDecimal((String)arryCol.get(7))%></td>
		<td width="15%" align="center"><%=Helper.correctNull((String)arryCol.get(5))%></td>
		<td width="20%" align="center"><%=Helper.checkDecimal((String)arryCol.get(9))%></td>

	</tr>
	<%}}}}else{%>
	<tr><td colspan="5">&nbsp;</td></tr>
	<tr><td colspan="5">&nbsp;</td></tr>
	<tr><td colspan="5" align="center">&nbsp;No Data Found</td></tr>
	<tr><td colspan="5">&nbsp;</td></tr>
	<tr><td colspan="5">&nbsp;</td></tr>
	<%}%>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>