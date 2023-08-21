<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
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
//	out.println("orgLevel------------------>"+Helper.correctNull((String)hshValues.get("orgLevel")));
//	out.println("orgname------------------>"+Helper.correctNull((String)hshValues.get("orgname")));

String strstatus=Helper.correctNull((String)hshValues.get("status"));
if(strstatus.equalsIgnoreCase("Normal"))
{
	strstatus="";
}
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
function nextRep()
{
	var Org_level="<%=Helper.correctNull((String)hshValues.get("orgLevel"))%>"
	var org_name="<%=Helper.correctNull((String)hshValues.get("orgname"))%>"
	document.forms[0].action=AppUrl+"action/mon_overstressedaccount_print.jsp";
	document.forms[0].hidMethod.value="getMonitoringReportOthers";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].hidSourceUrl.value=AppUrl+"action/mon_overstressedaccount_print.jsp?Org_level="+Org_level+"&org_name="+org_name;
	document.body.style.display="none";
	document.forms[0].submit();
		
	//window.open(AppUrl+"action/mon_annexurec_print.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getMonitoringReport&sellevel="+sellevel+"&accountclasssel="+accountclasssel+"&rpselect1="+rpselect1+"&parameterselect="+parameterselect+"&txtlimitfrom="+txtlimitfrom+"&txtlimitto="+txtlimitto+"&txtoutstandingfrom="+txtoutstandingfrom+"&txtoutstandingto="+txtoutstandingto+"&txtexcessfrom="+txtexcessfrom+"&txtexcessto="+txtexcessto+"&limit="+limit+"&offset="+offset+"&tempTableCheck="+tempTableCheck,"","scrollbars=Yes,toolbars=No,menubar=no ,width=900 , height=800,top=10,left=10");
}

function printpreview()
{
	
	var tempRowcount = "<%=(String)request.getParameter("tempRowcount")%>"
	var Org_level="<%=Helper.correctNull((String)hshValues.get("orgLevel"))%>"
	var Org_Name="<%=Helper.correctNull((String)hshValues.get("orgname"))%>"
	var Parameter="<%=Helper.correctNull((String)hshValues.get("parameter"))%>"
	var Status="<%=Helper.correctNull((String)hshValues.get("status"))%>"
	window.open(AppUrl+"action/mon_overstressedaccount_print_outpage.jsp?tempRowcount="+tempRowcount+"&Org_level="+Org_level+"&Org_Name="+Org_Name+"&Parameter="+Parameter+"&Status="+Status,"","scrollbars=Yes,toolbars=No,menubar=yes ,width=900, height=500,top=10,left=10");
	
}


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
          <td align="center"><b> <%=Helper.correctNull((String)session.getAttribute("strOrgName"))%> Branch</b></td>
        </tr> 
        <tr> 
          <td align="center">&nbsp;</td>
        </tr>
        <tr> 
      <td align="center">Position of over Stressed <b><%=strstatus%></b> Accounts <b><%=Helper.correctNull((String)hshValues.get("parameter"))%></b></td>
        </tr>
          <tr> 
      <td align="center">of (&nbsp;<b><%=Helper.correctNull((String)hshValues.get("orgname"))%></b>&nbsp;)&nbsp; as on <%=Helper.getCurrentDateTime()%></td>
        </tr>
        <tr> 
         <td align="RIGHT">&nbsp;(All Values are in Lacs)</td>
        </tr>
 </table>
<div class="cellContainer">
  
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outetable border1"  align="center">
      <tr> 
        <td height="3"> 
          <table width="100%" border="0" class="outetable border1" cellspacing="0" cellpadding="3"  >
           
            <tr style="Font-weight:bold"  bordercolor="#FFFFFF"> 
              <td rowspan="2" width="5%">Sr.No</td>
              <%if(!(Helper.correctNull((String)hshValues.get("orgLevel"))).equalsIgnoreCase("A")) {%>
              <td rowspan="2" width="10%">Branch</td>
              <%} %>
               <td rowspan="2" width="9%">Account Number</td>
              <td rowspan="2" width="17%">Name of the Account</td>
              <td  rowspan="2" width="11%">Nature of Facility</td>
              <td colspan="2" align="center">Amount</td>
              <td  rowspan="2" width="10%">Excess / Overdues</td>
              <td  rowspan="2" width="8%">since when</td>
             <!-- <td  rowspan="2" width="11%">EAS - I / II / SMA</td>-->
              <!-- <td  rowspan="2" width="10%">Reason</td>-->
			  <td  rowspan="2" width="10%">Action initiated 
                for regularisation</td>
			</tr>
			<tr style="Font-weight:bold"  bordercolor="#FFFFFF">
			  <td width="10%">Limit</td>
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
				
						<tr bordercolor="#DEDACF">
								
              <td>&nbsp;<%=++tempInteger%></td>
							 <%if(!(Helper.correctNull((String)hshValues.get("orgLevel"))).equalsIgnoreCase("A")) {%>	
              <td>&nbsp;<%=Helper.correctNull((String)arrCol.get(0))%></td>
					<%} %>			
			  <td>&nbsp;<%=Helper.correctNull((String)arrCol.get(9))%></td>
              <td>&nbsp;<%=Helper.correctNull((String)arrCol.get(1))%></td>
								
              <td>&nbsp;<%=Helper.correctNull((String)arrCol.get(2))%></td>
								
              <td align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3)))))%></td>
					 <% //  dbVal1 = dbVal1 +Double.parseDouble(Helper.correctDouble((String)arrCol.get(3)));
						%>			
              <td align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4)))))%></td>
					<%   dbVal2 = dbVal2 +Double.parseDouble(Helper.correctDouble((String)arrCol.get(4)));
			%>			
              <td align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5)))))%></td>
						<%   dbVal3 = dbVal3 +Double.parseDouble(Helper.correctDouble((String)arrCol.get(5)));
			%>	
								
              <td>&nbsp;<%=Helper.correctNull((String)arrCol.get(6))%></td>
								
              <!--<td width="11%">&nbsp;<%//=Helper.correctNull((String)arrCol.get(7))%></td>-->
								
             <!--  <td>&nbsp;<%//=Helper.correctNull((String)arrCol.get(8))%></td>-->
			  <td>&nbsp; </td>
						</tr>
			<%}}}%>
			<%if(arrRow!=null){ %>
		<tr style="Font-weight:bold"  bordercolor="#FFFFFF">
			  <td>&nbsp;</td>
			   <%if(!(Helper.correctNull((String)hshValues.get("orgLevel"))).equalsIgnoreCase("A")) {%>
			  <td>&nbsp;</td>
			   <%} %>
			  <td>&nbsp;</td>
			   <td>&nbsp;</td>
			  <td  align = "right"><b>Grand Total </b></td>  
			  <td  align = "right"><b><%//=Helper.converToLakhs(Helper.formatDoubleValue(dbVal1))%></b>&nbsp;</td>
			  <td  align = "right"><b><%=Helper.converToLakhs(Helper.formatDoubleValue(dbVal2))%></b>&nbsp;</td>
			  <td  align = "right"><b><%=Helper.converToLakhs(Helper.formatDoubleValue(dbVal3))%></b></td>
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
  <table border="1" cellspacing="0" cellpadding="0"  bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  align="center">
    <tr> 
      <td height="17"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr> 
		
			
			<%if(!tempRowcount.equals("0"))
			{%>
			
			 <td width='45%'>
			<div align='center'>
			 <input type='button' name='Button2322532' value='<<< Previous' style='background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:100;font-weight:bold' onclick='history.back()'>
			  </div>
			 </td>
			<%}%> 
			
            <td width="45%"> 
              <div align="center"> 
                <input type="button" name="Button232253" value="Close"  onClick="window.close()" style="background-color:#CC3300;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
              </div>
            </td>
            <td width="55%"> 
              <div align="center"> 
                <input type="button" name="Button2322532" value="Print Preview" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:100;font-weight:bold" onclick="printpreview()">
				
				
              </div>
            </td>
			<td width="55%"> 
              <div align="center"> 
			 <%if(arrRow!=null && arrRow.size()==Double.parseDouble(rowsrange)) 
			 {%> 
			<input type="button" name="Button2322532" value="Next >>>" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:100;font-weight:bold" onclick="nextRep()">
        	<%}%>	
			</div>
            </td>
		
		  </tr>
        </table>
      </td>
    </tr>
  </table>
 <input type="hidden" name="hidBeanId" value="perrepappstatus" >
 <input type="hidden" name="hidBeanMethod">
 <input type="hidden" name="hidBeanGetMethod">
 <input type="hidden" name="hidSourceUrl">
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
  <input type="hidden" name="org_name" value="<%=(String)hshValues.get("orgname")%>" >
  <input type="hidden" name="accstatus"  value="<%=(String)request.getParameter("accstatus")%>">
<input type="hidden" name="hidparameterselect_text" value="<%=Helper.correctNull((String)hshValues.get("parameter"))%>">
<input type="hidden" name="hidaccountstatus_text" value="<%=Helper.correctNull((String)hshValues.get("status"))%>">
<input type="hidden" name="schemecode" value="<%=Helper.correctNull((String)hshValues.get("schemecode"))%>">
</form>
</body>
</html>
