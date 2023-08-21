<%@include file = "../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<%
    ArrayList gridData= new ArrayList();
    if(hshValues.get("vecData")!=null)
    	gridData=(ArrayList)hshValues.get("vecData");
%>


<html>
<head>
<title>Loan Requirements</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/agr/agr_common_income.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<SCRIPT LANGUAGE="JavaScript">
var appURL="<%=ApplicationParams.getAppUrl()%>";  
</script>
<script>


</SCRIPT>

</head>
<body onload="onloading()">	
 
<form name="appform" method="post" class="normal">	
								
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
  <tr> 
    <td> 
     <table width="98%" border="0" cellspacing="1" cellpadding="2"  class="outertable" align="center">
          <tr class="dataheader"> 
            <td width="44%"  align="center"><b>Income 
              Details </b></td>
            <td width="7%"  align="center"><b>I 
              Year</b></td>
            <td width="7%"  align="center"><b>II 
              Year</b></td>
            <td width="7%"  align="center"><b>III 
              Year</b></td>
            <td width="7%"  align="center"><b>IV 
              Year</b></td>
            <td width="7%"  align="center"><b>V 
              Year</b></td>
            <td width="7%"  align="center"><b>VI 
              Year</b></td>
            <td width="7%"  align="center"><b>VII 
              Year</b></td>
            <td width="7%"  align="center"><b>VIII 
              Year</b></td>
          </tr>
          <tr> 
            <td width="44%" align="center"> 
              <input type="text" name="txt_agr_common_incomeandexpense" size="30" maxlength="100">
            </td>
            <td width="7%">
              <input type="text" name="txt_agr_common_year1" size="11" maxlength="8" onblur="roundtxt(this)" onKeyPress="allowDecimals(this)" style="text-align: right">
            </td>
            <td width="7%"> 
              <input type="text" name="txt_agr_common_year2" size="11" maxlength="8" onblur="roundtxt(this)" onKeyPress="allowDecimals(this)" style="text-align: right">
            </td>
            <td width="7%"> 
              <input type="text" name="txt_agr_common_year3" size="11" maxlength="8" onblur="roundtxt(this)" onKeyPress="allowDecimals(this)" style="text-align: right">
            </td>
            <td width="7%"> 
              <input type="text" name="txt_agr_common_year4" size="11" maxlength="8" onblur="roundtxt(this)" onKeyPress="allowDecimals(this)" style="text-align: right">
            </td>
            <td width="7%"> 
              <input type="text" name="txt_agr_common_year5" size="11" maxlength="8" onblur="roundtxt(this)" onKeyPress="allowDecimals(this)" style="text-align: right">
            </td>
            <td width="7%" align="center"> 
              <input type="text" name="txt_agr_common_year6" size="11" maxlength="8" onblur="roundtxt(this)" onKeyPress="allowDecimals(this)" style="text-align: right">
            </td>
            <td width="7%" align="center"> 
              <input type="text" name="txt_agr_common_year7" size="11" maxlength="8" onblur="roundtxt(this)" onKeyPress="allowDecimals(this)" style="text-align: right">
            </td>
            <td width="7%" align="center"> 
              <input type="text" name="txt_agr_common_year8" size="11" maxlength="8"  onblur="roundtxt(this)" onKeyPress="allowDecimals(this)" style="text-align: right">
            </td>
          </tr>
        </table>
    </td>
  </tr>
  <tr> 
    <td> 
        <lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
   
    </td>
  </tr>
  <tr> 
    <td> 
      <table width="98%" border="0" cellspacing="1" cellpadding="2" >
          <tr class="dataheader"> 
		  <td width="4%">&nbsp;</td>
            <td width="50%"  align="center"><b>Income 
              Details </b></td>
            <td   align="center"><b>I 
              Year</b></td>
            <td   align="center"><b>II 
              Year</b></td>
            <td   align="center"><b>III 
              Year</b></td>
            <td   align="center"><b>IV 
              Year</b></td>
            <td   align="center"><b>V 
              Year</b></td>
            <td   align="center"><b>VI 
              Year</b></td>
            <td   align="center"><b>VII 
              Year</b></td>
            <td   align="center"><b>VIII 
              Year</b></td>
                 </tr>
            
        <%for(int i=0;i<=gridData.size()-1;i++){ 
           ArrayList data=(ArrayList)gridData.get(i);        
        %>
           
        <tr class="datagrid"> 
         
          <td width="4%">
              <input type="radio" name="radio_seqno" onclick="selectValues(this.value)" value="<%=data.get(1)%>" style="border-style:none">
           </td>
          <td width="50%"><%=data.get(3)%> </td>
          <td   align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(4).toString())))%></td>
          <td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(5).toString())))%> </td>
          <td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(6).toString())))%> </td>
          <td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(7).toString())))%> </td>
          <td   align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(8).toString())))%></td>
          <td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(9).toString())))%> </td>
          <td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(10).toString())))%> </td>
          <td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(11).toString())))%> </td>
         
        </tr>
         
        <%} %>
        <tr class="dataheader">
            <td width="4%">&nbsp;</td>
            <td width="50%">Total</td>
            <td   align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_agr_total_year1"))))%></td>
            <td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_agr_total_year2"))))%> </td>
            <td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_agr_total_year3"))))%></td>
            <td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_agr_total_year4"))))%></td>
            <td   align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_agr_total_year5"))))%></td>
            <td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_agr_total_year6"))))%></td>
            <td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_agr_total_year7"))))%></td>
            <td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_agr_total_year8"))))%></td>
          </tr>
      </table>
    </td>
  </tr>
</table>	
			


<lapschoice:agrihiddentag pageid='<%=PageId%>'/>
<INPUT TYPE="hidden" name="seqno" > 
<INPUT TYPE="hidden" name="agr_common_producttype" > 
<INPUT TYPE="hidden" name="type"  value="I"> 
 <iframe height="0" width="0" id="ifrm" frameborder="0"
	style="border:0"></iframe>
	</form>
</body>
</html>
