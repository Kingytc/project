<%@include file="../share/directives.jsp"%>
<%
String strpagetype=Helper.correctNull((String) request.getParameter("strpagetype")); 
if(strpagetype.equals("")){strpagetype="RA1";}
%>
<html>
<head>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
	<script type="text/javascript">
	
	</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	 <table width="37%" border="0" cellspacing="1" cellpadding="3" class="outertable">
															<tr>
															<td align="center" nowrap="nowrap"
																	<%if (strpagetype.equals("RA1")) {%> class="sub_tab_active"><b> 
																	<%}%>Capitalisation/Coverage/Liquidity Ratios<%if (!strpagetype.equals("RA1")) {%>
																class="sub_tab_inactive"><b> <a href="javascript:callFlowtype('RA1')">
															Capitalisation/Coverage/Liquidity Ratios	<%}%></a></b></td>
																<td align="center" nowrap="nowrap"
																	<%if (strpagetype.equals("RA2")) {%> class="sub_tab_active"><b> 
																	<%}%>Profitability/Turn over/ Operating<%if (!strpagetype.equals("RA2")) {%>
																class="sub_tab_inactive"><b> <a href="javascript:callFlowtype('RA2')">
															Profitability/Turn over/ Operating	<%}%></a></b></td>
																<td align="center" nowrap="nowrap"
																	<%if (strpagetype.equals("RA3")) {%> class="sub_tab_active"><b> 
																	<%}%>KALYPTO<%if (!strpagetype.equals("RA3")) {%>
																class="sub_tab_inactive"><b> <a href="javascript:callFlowtype('RA3')">
															KALYPTO	<%}%></a></b></td>
																
															</tr>
 </table>   
</body>		
</html>
	