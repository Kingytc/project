<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
	ArrayList arrCol = null;
	ArrayList arrRow  = (ArrayList) session.getAttribute("sessionArrRow");
	
	String tempRowcount =  (String)request.getParameter("tempRowcount");
	int tempInteger=0;
	
 %>
 <html>
 <head>
 <title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css"
	type="text/css">
 
<script>

var AppUrl="<%=ApplicationParams.getAppUrl()%>";

</script>
</head>

<body  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name= "orgfrm" method="post">
 <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>          		
        </tr>
        <tr> 
          <td align="center"><strong>Karnataka Bank Ltd.</strong></td>
        </tr>
         <tr> 
          <td align="center"><b> <%=Helper.correctNull((String)request.getParameter("org_name")) %></b>
        </tr> 
        <tr> 
          <td align="center"><b>Status Of Term Loan Review Note Report</b></td>
        </tr>
        <tr>
        <td align="center">&nbsp;</td>
        </tr>
		<tr> 
         <td align="right">&nbsp;</td>
        </tr>
 </table>
<div class="cellContainer">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1"   align="center">
      <tr> 
        <td height="3"> 
          <table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="3"  >
          
            <tr style="Font-weight:bold"  bordercolor="#FFFFFF"> 
              <td>Sr.No</td>
              <td>Name of the Customer</td>
              <td>Account No.</td>
              <td>Review Due</td>
              <%if(Helper.correctNull((String)request.getParameter("varstatus")).equalsIgnoreCase("PA")){ %>
              
              <td>Reviewed on</td>
              <td>Approved By</td>
              
              <%}else if(Helper.correctNull((String)request.getParameter("varstatus")).equalsIgnoreCase("OP")){%>
              
              <td>Applied on</td>
              <td>Pending With</td>
              
              <%}%>
               <%if(!(Helper.correctNull((String)request.getParameter("sellevel")).equalsIgnoreCase("A"))){ %>
              <td>Branch</td>
              <%}%>
			</tr>
		
			
			<%if(arrRow!=null)
			{
				Iterator it = arrRow.iterator();
				 tempInteger = Integer.parseInt(tempRowcount);
				for(int i=0;it.hasNext();i++)
				{
					arrCol = (ArrayList) it.next();
					if(arrCol!=null)
					{%>
				
			<tr bordercolor="#DEDACF">
	              <td><%=++tempInteger%>&nbsp;</td>
				  <td><%=Helper.correctNull((String)arrCol.get(0))%>&nbsp;</td>			
	              <td><%=Helper.correctNull((String)arrCol.get(1))%>&nbsp;</td>
	              <td><%=Helper.correctNull((String)arrCol.get(2))%>&nbsp;</td>
                  
                  <%if(Helper.correctNull((String)request.getParameter("varstatus")).equalsIgnoreCase("PA")){ %>
                  
                  <td><%=Helper.correctNull((String)arrCol.get(3))%>&nbsp;</td> 
                   <td><%=Helper.correctNull((String)arrCol.get(4))%>&nbsp;</td> 
                  
                   <%}else if(Helper.correctNull((String)request.getParameter("varstatus")).equalsIgnoreCase("OP")){%>
                  
                  <td><%=Helper.correctNull((String)arrCol.get(3))%>&nbsp;</td> 
                   <td><%=Helper.correctNull((String)arrCol.get(4))%>&nbsp;</td> 
                  
                  <%}%>
                   <%if(!(Helper.correctNull((String)request.getParameter("sellevel")).equalsIgnoreCase("A"))){ %>
                   <td><%=Helper.correctNull((String)arrCol.get(5))%>&nbsp;</td> 
                   <%}%>
  			 </tr>
			<%}}}%>
		  </table>
        </td>
      </tr>
    </table>
  </div>
  <br>
</form>
</body>
</html>
