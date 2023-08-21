<%@include file="../share/directives.jsp"%>
<%String strMessage = "";
			ArrayList arrEligicriteria = new ArrayList();
			if (hshValues.get("arrEligicriteria") != null) 
			{
				arrEligicriteria = (ArrayList) hshValues.get("arrEligicriteria");
			}
			if (arrEligicriteria != null && arrEligicriteria.size() > 0)
			{
				for (int i = 0; i < arrEligicriteria.size(); i++)
				{	
					strMessage += Helper.correctNull((String) arrEligicriteria.get(i)) + "<br>";
				}
			}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>UBI</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>
</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
  <tr>
		<td>
		
      <table width="90%" border="1" cellpadding="3" cellspacing="0"  align="center" class="outertable">
        <tr>
				<td>
				
            <table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
              <tr> 
                <td align="center" colspan="4"><img
							src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"
							width="75" height="75"></td>
              </tr>
              <tr align="center" > 
                <td colspan="4"> <b>KARNATAKA BANK LTD.</b><br>
                  <b><%=Helper.correctNull((String) hshValues.get("orgname"))%> 
                 <%strOrgLevel.equalsIgnoreCase("B");
                  {%>
                  </b><b><%=Helper.correctNull((String)hshValues.get("branchname"))%></b><br>
                  <%}%>
                </td>
              </tr>
              <tr> 
                <td align="center" colspan="4"><b> <%=Helper.correctNull((String) hshValues.get("orgadd1"))%>,&nbsp; 
                  <%=Helper.correctNull((String) hshValues.get("orgadd2"))%>,&nbsp; 
                  <%=Helper.correctNull((String) hshValues.get("orgcity"))%>,&nbsp; 
                  <%=Helper.correctNull((String) hshValues.get("orgstate"))%>-&nbsp; 
                  <%=Helper.correctNull((String) hshValues.get("orgzip"))%>&nbsp; 
                  .<br>
                  Tel No : <%=Helper.correctNull((String) hshValues.get("orgphone"))%></b> 
                  <hr />
                </td>
              </tr>
              <tr> 
                <td colspan="2" align="center">&nbsp;</td>
                <td width="20%" align="center"><b>Application No.</b></td>
                <td width="26%"><%=Helper.correctNull((String) request.getParameter("appno"))%></td>
              </tr>
              <tr> 
                <td width="6%"><b>Product :</b></td>
                <td colspan="3"><%=Helper.correctNull((String) request.getParameter("subcategory"))%></td>
              </tr>
              <tr> 
                <td colspan="2"></td>
              </tr>
              <tr> 
                <td colspan="4">&nbsp;</td>
              </tr>
              <tr> 
                <td colspan="5" align="center" > 
                  <table width="1000%" border="0" align="center" class="outertable">
                    <tr> 
                      <td><%=strMessage%></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</body>
</html>
