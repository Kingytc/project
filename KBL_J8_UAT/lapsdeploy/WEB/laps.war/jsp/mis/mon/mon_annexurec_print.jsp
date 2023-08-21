
<%@include file="../../share/directives.jsp"%><%
     ArrayList arrRow  = null;
	
	arrRow =   (ArrayList)hshValues.get("arrRow");
	
	 		 
	 ArrayList arrCol = null;
	 
	String rowsrange = (String)request.getParameter("rowsrange");
	String tempRowcount =  (String)request.getParameter("tempRowcount");
	//double dbVal1 = 0.00;
	double dbVal2 = 0.00;
	double dbVal3 = 0.00;
	int tempInteger=0;
	
	session.setAttribute("sessionArrRow",arrRow);
	String StrStatus=Helper.correctNull((String)hshValues.get("status"));
	if(StrStatus.equalsIgnoreCase("Normal"))
	{
		StrStatus="";
	}
	
 %>
 <html>
 <head>
 <title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
 
<script>



var AppUrl="<%=ApplicationParams.getAppUrl()%>";
function nextRep()
{
	document.forms[0].action=AppUrl+"action/mon_annexurec_print.jsp";
	document.forms[0].hidMethod.value="getMonitoringReport";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].hidSourceUrl.value=AppUrl+"action/mon_annexurec_print.jsp";
	document.body.style.display="none";
	document.forms[0].submit();
		
}

function printpreview()
{
	
	var tempRowcount = "<%=(String)request.getParameter("tempRowcount")%>"
	var Org_level="<%=Helper.correctNull((String)hshValues.get("orgLevel"))%>"
	var Org_Name="<%=Helper.correctNull((String)hshValues.get("orgname"))%>"
	var Acct_class="<%=Helper.correctNull((String)hshValues.get("account_class"))%>"
	var Totoverdue="<%=Helper.correctNull((String)hshValues.get("totoverdue"))%>"
	
	var Parameter="<%=Helper.correctNull((String)hshValues.get("parameter"))%>"
	var Status="<%=Helper.correctNull((String)hshValues.get("status"))%>"
	window.open(AppUrl+"action/mon_annexurec_print_outpage.jsp?tempRowcount="+tempRowcount+"&Org_level="+Org_level+"&Org_Name="+Org_Name+"&Acct_class="+Acct_class+"&Totoverdue="+Totoverdue+"&Parameter="+Parameter+"&Status="+Status,"","scrollbars=Yes,toolbars=No,menubar=yes ,width=900, height=500,top=10,left=10");
	
}


</script>



</head>

<body >
<form class="normal" name= "orgfrm" method="post">
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="3">
    <tr> 
      <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>
    </tr>
    <tr> 
      <td align="center"><strong>Karnataka Bank Ltd.</strong></td>
    </tr>
   
    <tr> 
      <td align="center"><b> <%=Helper.correctNull((String)session.getAttribute("strOrgName"))%></b></td>
    </tr>
    
    <tr> 
      <td align="center">STATEMENT OF STRESSED ASSETS FOR <%=Helper.correctNull((String)hshValues.get("sectorval"))%> 
      </td>
    </tr>
    <tr> 
      <td align="center"><b>(<b> <%=Helper.correctNull((String)hshValues.get("account_class"))%></b> 
        ) <b><%=StrStatus%></b> ACCOUNTS AS OF <%=Helper.getCurrentDateTime()%></b></td>
    </tr>
	<tr> 
      <td align="center"><b><%=Helper.correctNull((String)hshValues.get("parameter"))%></b></td>
    </tr>
    <tr> 
      <td align="RIGHT">&nbsp;(All Values are in Lacs)</td>
    </tr>
  </table>
<div class="cellContainer">
  
   
          <table class="outertable border1" width="100%" border="0" cellspacing="0" cellpadding="3"  >
           
            <tr style="Font-weight:bold" > 
              <td rowspan="2" width="5%">Sr.No</td>
               <%if(!(Helper.correctNull((String)hshValues.get("orgLevel"))).equalsIgnoreCase("A")) {%>
              <td rowspan="2" width="10%">Branch</td>
              <%} %>
              <td rowspan="2" width="9%">Account Number</td>
              <td rowspan="2" width="16%" >Name of the Account</td>
              <td  rowspan="2" width="10%">Nature of Facility</td>
              <td colspan="2" align="center">Amount</td>
              <td  rowspan="2" width="11%">Excess / Overdues</td>
              <td  rowspan="2" width="11%">since when</td>
              <td  rowspan="2" width="11%">EAS - I / EAS - II / SMA</td>
              <td  rowspan="2" width="8%">
Parameters(Loan / Renewal / Insp / Doc / Others)</td>
			  <td  rowspan="2" width="5%">Action 
                initiated for regularisation</td>
			</tr>
			<tr >
			  <td width="11%">Limit</td>
              <td width="11%">O/s</td>
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
				
						<tr >
								
              <td><%=++tempInteger%>&nbsp;</td>
			 <%if(!(Helper.correctNull((String)hshValues.get("orgLevel"))).equalsIgnoreCase("A")) {%>					
              <td><%=Helper.correctNull((String)arrCol.get(0))%>&nbsp;</td>
				<%} %>	
			  <td><%///=Helper.correctNull((String)arrCol.get(9))%><%=Helper.correctNull((String)arrCol.get(7))%>&nbsp;</td>			
              <td><%=Helper.correctNull((String)arrCol.get(1))%>&nbsp;</td>
								
              <td>&nbsp;<%=Helper.correctNull((String)arrCol.get(2))%></td>
								
              <td align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3)))))%></td>
					 <%   //dbVal1 = dbVal1 +Double.parseDouble(Helper.correctDouble((String)arrCol.get(3)));
						%>			
              <td align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4)))))%></td>
					<%   dbVal2 = dbVal2 +Double.parseDouble(Helper.correctDouble((String)arrCol.get(4)));
			%>			
              <td align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5)))))%></td>
						<%   dbVal3 = dbVal3 +Double.parseDouble(Helper.correctDouble((String)arrCol.get(5)));
			%>		
              <td><%=Helper.correctNull((String)arrCol.get(6))%>&nbsp;</td>
								
             <td width="11%">&nbsp;<%=Helper.correctNull((String)arrCol.get(10))%></td>
								
             <td>&nbsp;<%=Helper.correctNull((String)arrCol.get(9))%></td>
            
                 
              <td>&nbsp;</td>  
             
              			  
						</tr>
			<%}}}%>
			<%if(arrRow!=null){ %>
		<tr >
			  <td>&nbsp;</td>
			   <%if(!(Helper.correctNull((String)hshValues.get("orgLevel"))).equalsIgnoreCase("A")) {%>
			  <td>&nbsp;</td>
			   <%} %>
			  <td>&nbsp;</td>
			  <td>&nbsp; </td>
			  <td  align = "right"><b>Grand Total </b></td>  
			  <td  align = "right"><b><%//=Helper.converToLakhs(Helper.formatDoubleValue(dbVal1))%></b>&nbsp;</td>
			  <td  align = "right"><b><%=Helper.converToLakhs(Helper.formatDoubleValue(dbVal2))%></b>&nbsp;</td>
			  <td  align = "right"><b><%=Helper.converToLakhs(Helper.formatDoubleValue(dbVal3))%></b></td>
			  <td>&nbsp; </td>
			  <td>&nbsp; </td>
			 	  <td>&nbsp; </td>
			  <td>&nbsp; </td>
		 </tr>
		<%}%>
		  </table>
        </td>
      </tr>
    </table>
  </div>
  <br>
  <table class="outertable border1" border="0" cellspacing="0" cellpadding="0"   align="center">
    <tr> 
      <td height="17"> 
        <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr> 
		
			
			<%if(!tempRowcount.equals("0"))
			{%>
			
			 <td width='45%'>
			<div align='center'>
			 <input type='button' name='Button2322532' value='<<< Previous' 
class="buttonothers" onclick='history.back()'>
			  </div>
			 </td>
			<%}%> 
			
            <td width="45%"> 
              <div align="center"> 
                <input type="button" name="Button232253" value="Close"  onClick="window.close()" 
class="buttonclose">
              </div>
            </td>
            <td width="55%"> 
              <div align="center"> 
                <input type="button" name="Button2322532" value="Print Preview" 
class="buttonothers" onclick="printpreview()">
				
				
              </div>
            </td>
			<td width="55%"> 
              <div align="center"> 
			 <%if(arrRow!=null && arrRow.size()==Double.parseDouble(rowsrange)) 
			 {%> 
			<input type="button" name="Button2322532" value="Next >>>" 
class="buttonothers"  onclick="nextRep()">
        	<%}%>	
			</div>
            </td>
		
		  </tr>
        </table>
      
</td>
</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
 <input type="hidden" name="hidMethod">
 
  
 <input type="hidden" name="sellevel" value="<%=(String)request.getParameter("sellevel")%>">
 <input type="hidden" name="accountclasssel" value="<%=(String)request.getParameter("accountclasssel")%>">
 <input type="hidden" name="parameterselect" value="<%=(String)request.getParameter("parameterselect")%>">
 <input type="hidden" name="txtlimitfrom" value="<%=(String)request.getParameter("txtlimitfrom")%>">
 <input type="hidden" name="txtlimitto" value="<%=(String)request.getParameter("txtlimitto")%>">
 <input type="hidden" name="txtoutstandingfrom" value="<%=(String)request.getParameter("txtoutstandingfrom")%>">
 <input type="hidden" name="txtoutstandingto" value="<%=(String)request.getParameter("txtoutstandingto")%>">
 <input type="hidden" name="txtexcessfrom" value="<%=(String)request.getParameter("txtexcessfrom")%>">
<input type="hidden" name="txtexcessto" value="<%=(String)request.getParameter("txtexcessto")%>">
<input type="hidden" name="rpselect1" value="<%=(String)request.getParameter("rpselect1")%>">
<input type="hidden" name="rowsrange" value="<%=(String)request.getParameter("rowsrange")%>">
<input type="hidden" name="tempRowcount" value="<%=tempInteger%>">
<input type="hidden" name="limit" value="<%=(String)hshValues.get("limit")%>" >
<input type="hidden" name="offset" value="<%=(String)hshValues.get("offset")%>" >
<input type="hidden" name="tempTableCheck" value="<%=(String)hshValues.get("tempTableCheck")%>" >
<input type="hidden" name="org_name" value="<%=(String)hshValues.get("orgname")%>">
<input type="hidden" name="hidaccclass_text" value="<%=Helper.correctNull((String)hshValues.get("account_class"))%>">
<input type="hidden" name="accstatus"  value="<%=(String)request.getParameter("accstatus")%>">
<input type="hidden" name="hidparameterselect_text" value="<%=Helper.correctNull((String)hshValues.get("parameter"))%>">
<input type="hidden" name="hidaccountstatus_text" value="<%=Helper.correctNull((String)hshValues.get("status"))%>">
<input type="hidden" name="schemecode" value="<%=Helper.correctNull((String)hshValues.get("schemecode"))%>">
</form>
</body>
</html>
