<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Terms &amp; Conditions</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="97%" border="0" cellspacing="0" cellpadding="3" align="center">
<tr> 
         
      

		<td colspan="4" align="center"><img width="60%"
					src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg"> <br><b>KARNATAKA BANK LTD.</b><br>
		<%=Helper.correctNull((String) hshValues
							.get("RespectiveBranch"))%>&nbsp;&nbsp;Branch
		</td>

	</tr>
</table>
<laps:application  /> 
<table width="97%" border="0" cellspacing="0" cellpadding="3" align="center">
 
  <tr> 
  <tr> 
    <td valign="top" width="3%">&nbsp;</td>
    <td valign="top" colspan="4">
      <div align="center"><b>TERMS AND CONDITIONS:</b></div>
    </td>
  </tr>
  <%
                    ArrayList arr18=new ArrayList();
                    ArrayList arr19=new ArrayList();
                    int arrSize15=0;
                    arr18=(ArrayList)hshValues.get("arrRow");
               
                    if(arr18!=null){
                    	
                        arrSize15=  arr18.size();
                           }

                  for(int i=0;i<arrSize15;i++)
                  {
                	  arr19=(ArrayList)arr18.get(i); 
                 
                    		
                    %>
  <tr> 
    <td valign="top" width="3%">&nbsp;<%=i+1 %>.</td>
    <td valign="top" colspan="4">&nbsp;<%=Helper.formatTextAreaData((String)arr19.get(0)) %></td>
  </tr>
  <%
                  }
                    %>
</table>
</body>
</html>


