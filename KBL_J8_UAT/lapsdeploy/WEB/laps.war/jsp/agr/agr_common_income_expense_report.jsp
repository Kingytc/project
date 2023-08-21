<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>

<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
  
    ArrayList incomeGridData= new ArrayList();
    ArrayList expenseGridData= new ArrayList();
    if(hshValues.get("income")!=null)
    	incomeGridData=(ArrayList)hshValues.get("income");
    if(hshValues.get("expense")!=null)
    	expenseGridData=(ArrayList)hshValues.get("expense");
%>


<html>
<head>
<title>Income &amp; Expense</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/link.css" type="text/css">

<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL="<%=ApplicationParams.getAppUrl()%>";  
</script>
<script>


</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body>	
 <form method="post">

    
      <table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center">
          
        
        
         <tr> 
		 
            <td width="50%" bgcolor="#71694F" align="center"><b><font  color="#FFFFFF">Expenditure 
              On (All Values are in Rupeess)</font></b></td>
            <td  bgcolor="#71694F" align="center"><b><font  color="#FFFFFF">I 
              Year</font></b></td>
            <td  bgcolor="#71694F" align="center"><b><font  color="#FFFFFF">II 
              Year</font></b></td>
            <td  bgcolor="#71694F" align="center"><b><font  color="#FFFFFF">III 
              Year</font></b></td>
            <td  bgcolor="#71694F" align="center"><b><font  color="#FFFFFF">IV 
              Year</font></b></td>
            <td  bgcolor="#71694F" align="center"><b><font  color="#FFFFFF">V 
              Year</font></b></td>
            <td  bgcolor="#71694F" align="center"><b><font  color="#FFFFFF">VI 
              Year</font></b></td>
            <td  bgcolor="#71694F" align="center"><b><font  color="#FFFFFF">VII 
              Year</font></b></td>
            <td  bgcolor="#71694F" align="center"><b><font  color="#FFFFFF">VIII 
              Year</font></b></td>
          </tr>
                
        <%for(int i=0;i<=expenseGridData.size()-1;i++){ 
           ArrayList data=(ArrayList)expenseGridData.get(i);        
        %>
           
        <tr>                   
          <td width="50%"><%=data.get(3)%> </td>
          <td   align="center"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(4).toString())))%></td>
          <td  align="center"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(5).toString())))%> </td>
          <td  align="center"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(6).toString())))%> </td>
          <td  align="center"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(7).toString())))%> </td>
          <td   align="center"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(8).toString())))%></td>
          <td  align="center"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(9).toString())))%> </td>
          <td  align="center"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(10).toString())))%> </td>
          <td  align="center"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(11).toString())))%> </td>
         
        </tr>
        <%} %>
          <tr>                   
          <td width="50%"><b>Total</b> </td>
          <td   align="center"><%=hshValues.get("expenseYear1")%></td>
          <td   align="center"><%=hshValues.get("expenseYear2")%></td>
          <td   align="center"><%=hshValues.get("expenseYear3")%></td>
          <td   align="center"><%=hshValues.get("expenseYear4")%></td>
          <td   align="center"><%=hshValues.get("expenseYear5")%></td>
          <td   align="center"><%=hshValues.get("expenseYear6")%></td>
          <td   align="center"><%=hshValues.get("expenseYear7")%></td>
          <td   align="center"><%=hshValues.get("expenseYear8")%></td>
        </tr>
         <tr>       
        <td width="50%">&nbsp;</td>
          <td   align="center">&nbsp;</td>
          <td   align="center">&nbsp;</td>
          <td   align="center">&nbsp;</td>
          <td   align="center">&nbsp;</td>
          <td   align="center">&nbsp;</td>
          <td   align="center">&nbsp;</td>
          <td   align="center">&nbsp;</td>
          <td   align="center">&nbsp;</td>
       </tr>
        
        
        
          <tr> 
		 
            <td width="50%" bgcolor="#71694F" align="center"><b><font  color="#FFFFFF">Income 
              Details (All Values are in Rupees)</font></b></td>
            <td  bgcolor="#71694F" align="center"><b><font  color="#FFFFFF">I 
              Year</font></b></td>
            <td  bgcolor="#71694F" align="center"><b><font  color="#FFFFFF">II 
              Year</font></b></td>
            <td  bgcolor="#71694F" align="center"><b><font  color="#FFFFFF">III 
              Year</font></b></td>
            <td  bgcolor="#71694F" align="center"><b><font  color="#FFFFFF">IV 
              Year</font></b></td>
            <td  bgcolor="#71694F" align="center"><b><font  color="#FFFFFF">V 
              Year</font></b></td>
            <td  bgcolor="#71694F" align="center"><b><font  color="#FFFFFF">VI 
              Year</font></b></td>
            <td  bgcolor="#71694F" align="center"><b><font  color="#FFFFFF">VII 
              Year</font></b></td>
            <td  bgcolor="#71694F" align="center"><b><font  color="#FFFFFF">VIII 
              Year</font></b></td>
          </tr>
             
                
        <%for(int i=0;i<=incomeGridData.size()-1;i++){ 
           ArrayList data=(ArrayList)incomeGridData.get(i);        
        %>
           
        <tr> 
         
         
          <td width="50%"><%=data.get(3)%> </td>
          <td   align="center"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(4).toString())))%></td>
          <td  align="center"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(5).toString())))%> </td>
          <td  align="center"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(6).toString())))%> </td>
          <td  align="center"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(7).toString())))%> </td>
          <td   align="center"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(8).toString())))%></td>
          <td  align="center"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(9).toString())))%> </td>
          <td  align="center"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(10).toString())))%> </td>
          <td  align="center"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(11).toString())))%> </td>
         
        </tr>
        <%} %>
          <tr>                   
          <td width="50%"><b>Total</b> </td>
          <td   align="center"><%=hshValues.get("incomeYear1")%></td>
          <td   align="center"><%=hshValues.get("incomeYear2")%></td>
          <td   align="center"><%=hshValues.get("incomeYear3")%></td>
          <td   align="center"><%=hshValues.get("incomeYear4")%></td>
          <td   align="center"><%=hshValues.get("incomeYear5")%></td>
          <td   align="center"><%=hshValues.get("incomeYear6")%></td>
          <td   align="center"><%=hshValues.get("incomeYear7")%></td>
          <td   align="center"><%=hshValues.get("incomeYear8")%></td>
        </tr>
        
       
         
      
       <tr>       
        <td width="50%">&nbsp;</td>
          <td   align="center">&nbsp;</td>
          <td   align="center">&nbsp;</td>
          <td   align="center">&nbsp;</td>
          <td   align="center">&nbsp;</td>
          <td   align="center">&nbsp;</td>
          <td   align="center">&nbsp;</td>
          <td   align="center">&nbsp;</td>
          <td   align="center">&nbsp;</td>
       </tr>
       
       <tr>                   
          <td width="50%"><b>Income &amp; Expense </b></td>
          <td   align="center"><font color="red"><%=hshValues.get("total1")%></font></td>
          <td   align="center"><font color="red"><%=hshValues.get("total2")%></font></td>
          <td   align="center"><font color="red"><%=hshValues.get("total3")%></font></td>
          <td   align="center"><font color="red"><%=hshValues.get("total4")%></font></td>
          <td   align="center"><font color="red"><%=hshValues.get("total5")%></font></td>
          <td   align="center"><font color="red"><%=hshValues.get("total6")%></font></td>
          <td   align="center"><font color="red"><%=hshValues.get("total7")%></font></td>
          <td   align="center"><font color="red"><%=hshValues.get("total8")%></font></td>
        </tr>
      </table>
    
	</form>
</body>
</html>
