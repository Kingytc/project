<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%ArrayList eiAmountData=new ArrayList();
 if(hshValues.get("equalInsData")!=null){
	 eiAmountData=(ArrayList)hshValues.get("equalInsData");	 
 }%>
<html>
<head>
<title>Repayment Schedule</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="">
<form name=amtfrm class="normal">
  <iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <tr> 
      <td align="center"><b>Repayment Schedule </b></td>
    </tr>
    <tr> 
      <td> 
        <table width="98.3%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable linebor">
          <tr class="dataheader"> 
            <td width="7%" > <b>Month</b></td>
            <td width="16%" > <b>Original Loan Amount OS</b></td>			  
            <td width="19%" > <b>Instalment amount</b></td>
          </tr>
          </table>          
          <table  width="98.3%" cellspacing="1" cellpadding="3" align="center" class="outertable linebor">
          <% for(int i=0;i<=eiAmountData.size()-1;i++){
        	  ArrayList eiData=(ArrayList)eiAmountData.get(i);
          %>
          <tr class="datagrid"> 
            <td width="7%" align="center"> 
              <input name="txt_terms" type="text" value="<%=eiData.get(0)%>" size="2" readOnly>
            </td>
            <td width="16%" align="center"> 
              <input name="txt_originalOSamt" type="text" value="<%=eiData.get(1)%>" size="15" readOnly style="text-align:right" maxlength="12">
            </td>           
            <td width="19%" align="center"> 
              <input name="txt_actualprincipalamt" type="text" value="<%=eiData.get(2)%>" size="15" onBlur="" onKeyPress="allowDecimals(this)" readOnly style="text-align:right" maxlength="12">
			</td>
          </tr>
        <%}%> 
        </table>
      </td>
    </tr>
  </table> 
  <br>
<INPUT TYPE="hidden" name="appno" value="<%=Helper.correctNull((String)hshValues.get("appno"))%>">
<INPUT TYPE="hidden" name="txtloan_modintrate" value="<%=Helper.correctNull((String)hshValues.get("txtloan_modintrate"))%>">
<INPUT TYPE="hidden" name="txtloan_reqterms" value="<%=Helper.correctNull((String)hshValues.get("txtloan_reqterms"))%>">
<INPUT TYPE="hidden" name="txtloan_sancamt" value="<%=Helper.correctNull((String)hshValues.get("txtloan_sancamt"))%>">
<INPUT TYPE="hidden" name="hidBeanGetMethod" value="">
<INPUT TYPE="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidSourceUrl" value="repaymentschedule.jsp">
<input type="hidden" name="hidAppType" value="">
<input type="hidden" name="hidAction" value="">
<input type="hidden" name="hidrepaymenttype" value="">
<input type="hidden" name="hidmonthsfrom" value="">
<input type="hidden" name="hidmonthsto" value="">
<input type="hidden" name="hidtotalamt" value="">
<input type="hidden" name="hidstartterms" value="<%=hshValues.get("hidstartterms")%>">
<input type="hidden" name="hidendterms" value="">
<input type="hidden" name="radLoan" value="">
<input type="hidden" name="page" value="">
<input type="hidden" name="hidSerFlag" value="">
</form>
</body>
</html>
