<%@include file="../share/directives.jsp"%>
<%
    
    ArrayList gridData= new ArrayList();
    if(hshValues.get("vecData")!=null)
    	gridData=(ArrayList)hshValues.get("vecData");
    String schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
%>
<html>
<head>
<title>Loan Requirements</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/agr/agr_common_loanrequirements.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<SCRIPT LANGUAGE="JavaScript">
var appURL="<%=ApplicationParams.getAppUrl()%>";  
var schemetype="<%=schemetype%>";
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">	
 
<form name="appform" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="999" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
      <td><i><b><font face="Times New Roman" size="3">Home -> Agriculture -> Cropping 
        Pattern Details</font></b></i></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="203" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>	
<br/>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
  <tr> 
    <td>							
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
  <tr> 
    <td> 
      <table width="98%" border="0" cellspacing="1" cellpadding="3" class="outertable">
        <tr class="dataheader"> 
          <td align="center"><b>Particulars<b>&nbsp;<span
											class="mantatory">*</span></b></b></td>
           <td align="center"><b>Type</b></td>
          <td width="9%"  align="center"><b>No. of Units</b>&nbsp;<b><span
											class="mantatory">*</span></b></td>
          <td width="12%"  align="center"><b>Unit Cost</b>&nbsp;<b><span
											class="mantatory">*</span></b></td>
          <td width="15%"  align="center"><b>Amount</b></td>
        </tr>
        <tr> 
          <td > 
            <input type="text" name="txt_agrcommon_particulars" size="75" maxlength="100">
          </td>
          
           <td  align="center"> 
            <select name="sel_agrcommon_type"><option value="Recurring" align="left">Recurring</option>
                   <option value="Non Recurring" align="left" >Non Recurring</option>
            </select>
          </td>
          
          <td width="9%" align="center"> 
            <input type="text" name="txt_agrcommon_units" size="5" maxlength="4" onKeyPress="allowNumber(this)" onchange="doCal()" >
          </td>
          <td width="12%" align="center"> 
            <input type="text" name="txt_agrcommon_unitcost"  onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" onchange="doCal()" style="text-align:right" size="15" maxlength="8">
          </td>
          <td width="15%" align="center"> 
            <input type="text" name="txt_agrcommon_amount" size="18" maxlength="15" readonly="readonly" style="text-align:right">
          </td>
        </tr>
      </table>
    <br/>
    
    <lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
    <br/>

     
      <table width="98%" border="0" cellspacing="1" cellpadding="3" class="outertable">
        <tr class="dataheader">    
          <td width="4%">&nbsp;</td>   
          <td width="50%"><b>Particulars</b></td>
          <td width="10%"><b>Type</b></td>
          <td width="9%" align="center"><b>No. of Units</b></td>
          <td width="12%" align="center"><b>Unit Cost</b></td>
          <td width="15%" align="center"><b>Amount</b></td>
        </tr>
                
        <%
        double dblTotcost1=0;
        double dblRecurringcost=0;
        double dblNonRecurringcost=0;
        int flag = 0;
        int flag_total = 0;
        for(int i=0;i<=gridData.size()-1;i++){ 
           ArrayList data=(ArrayList)gridData.get(i);    
           
           dblTotcost1 = dblTotcost1+Double.parseDouble(data.get(6).toString());
           
          String type=Helper.correctNull((String)data.get(3));
          if (type.equalsIgnoreCase("Non Recurring"))
          {
        	  dblNonRecurringcost=dblNonRecurringcost+Double.parseDouble(data.get(6).toString());
        	  flag = 1;flag_total =1;
        	  %>
        	   <tr> 
         
          <td width="4%">
              <input type="radio" name="radio_seqno" onclick="selectValues(this.value)" value="<%=data.get(1)%>" style="border-style:none">
           </td>
          <td width="50%"><%=data.get(2)%> </td>
            <td width="10%" align="left">&nbsp;<%=data.get(3)%></td>
          <td width="9%" align="center">&nbsp;<%=data.get(4)%> </td>
          <td width="12%" align="center">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(5).toString())))%> </td>
              <td width="15%" style="text-align:right"">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(6).toString())))%> </td>
            
        </tr>
        <%
          }
          }
        %>
        <% if(flag == 1){%>
          <tr> 
         <td width="4%">&nbsp;</td>
          <td width="50%">&nbsp;</td>
          <td width="10%" align="center">&nbsp;</td>
          <td width="9%" align="center">&nbsp;</td>
            <td width="50%" align="center"><b>Subtotal NonRecurring</b></td>
          <td   style="text-align:right""><%=Helper.formatDoubleValue(dblNonRecurringcost)%></td>

          </tr>
          <%} %>
        
        	  <%
        	   dblTotcost1=0;
               dblNonRecurringcost=0;
               flag= 0;
              for(int i=0;i<=gridData.size()-1;i++){ 
                 ArrayList data=(ArrayList)gridData.get(i);    
                 
                 dblTotcost1 = dblTotcost1+Double.parseDouble(data.get(6).toString());
                 
                String type=Helper.correctNull((String)data.get(3));
          
          if (type.equalsIgnoreCase("Recurring"))
          {
        	  dblRecurringcost=dblRecurringcost+Double.parseDouble(data.get(6).toString());
        	  flag=1;flag_total =1;
           %>
        	   <tr> 
         
          <td width="4%">
              <input type="radio" name="radio_seqno" onclick="selectValues(this.value)" value="<%=data.get(1)%>" style="border-style:none">
           </td>
          <td width="50%"><%=data.get(2)%> </td>
            <td width="10%" align="left">&nbsp;<%=data.get(3)%></td>
          <td width="9%" align="center">&nbsp;<%=data.get(4)%> </td>
          <td width="12%" align="center">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(5).toString())))%> </td>
              <td width="15%" style="text-align:right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(6).toString())))%> </td>
            
        </tr>
          
        	  <%
          }
        %>
           
       
        <%} %>
        <% if(flag == 1){%>
       <tr>
            <td width="4%">&nbsp;</td>
             <td width="50%">&nbsp;</td>
             <td width="10%" align="center">&nbsp;</td>
             <td width="9%" align="center">&nbsp;</td>
            <td width="50%" align="center"><b>Subtotal Recurring</b></td>
            
            <td   style="text-align:right"><%=Helper.formatDoubleValue(dblRecurringcost)%></td>
          </tr>
      
      <%} %>
       <% if(flag_total == 1){%>
         <tr>
          <td width="4%">&nbsp;</td>
          <td width="50%">&nbsp;</td>
          <td width="10%" align="center">&nbsp;</td>
          <td width="9%" align="center">&nbsp;</td>
          <td width="12%" align="center"><b>Total</b>&nbsp;</td>
          <td width="15%" style="text-align:right"><font color="Blue"><%=Helper.formatDoubleValue(dblTotcost1) %>&nbsp;</font></td>
        </tr>
        <% }%>
      </table>
    </td>
  </tr>
</table>
</td>
</tr>
</table>	
<INPUT TYPE="hidden" name="seqno" > 
<INPUT TYPE="hidden" name="sel_agrcommon_type_text" value=""> 			
<lapschoice:hiddentag pageid="<%=PageId%>"/>
<iframe height="0" width="0" id="ifrm" frameborder=0 style="border:0"></iframe>
</form>
</body>
</html>
