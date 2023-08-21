<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" type="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
     ArrayList arrRow  = (ArrayList) session.getAttribute("sessionArrRow");
	String tempRowcount =  (String)request.getParameter("tempRowcount");
	String Org_level = (String)request.getParameter("Org_level");
	String Org_Name = (String)request.getParameter("Org_Name");
	String Acct_class=(String)request.getParameter("Acct_class");
	String Parameter=(String)request.getParameter("Parameter");
	String Status=(String)request.getParameter("Status");
	if(Status.equalsIgnoreCase("Normal"))
	{
		Status="";
	}
	ArrayList arrCol = new ArrayList();
	int tempInteger=0;
	//double dbVal1 = 0.00;
	double dbVal2 = 0.00;
	double dbVal3 = 0.00;
 %>
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
		
	//window.open(AppUrl+"action/mon_annexurec_print.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getMonitoringReport&sellevel="+sellevel+"&accountclasssel="+accountclasssel+"&rpselect1="+rpselect1+"&parameterselect="+parameterselect+"&txtlimitfrom="+txtlimitfrom+"&txtlimitto="+txtlimitto+"&txtoutstandingfrom="+txtoutstandingfrom+"&txtoutstandingto="+txtoutstandingto+"&txtexcessfrom="+txtexcessfrom+"&txtexcessto="+txtexcessto+"&limit="+limit+"&offset="+offset+"&tempTableCheck="+tempTableCheck,"","scrollbars=Yes,toolbars=No,menubar=no ,width=900 , height=800,top=10,left=10");
}




</script>

<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css"
	type="text/css">
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
      <td align="center"><b><%=Org_Name%> <%//=Helper.correctNull((String)session.getAttribute("strOrgName"))%> 
        </b></td>
    </tr>
    <tr> 
      <td align="left">MINUTES OF AQMC FOR <%=Helper.getCurrentDateTime()%>(&nbsp;<b><%=Acct_class%></b>&nbsp;) <b><%=Status%></b> ACCOUNTS <b><%=Parameter%></b></td>
    </tr>
	<tr> 
         <td align="RIGHT">&nbsp;(All Values are in Lacs)</td>
        </tr>
  </table>
<div class="cellContainer">
  
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1"   align="center">
      <tr> 
        <td height="3"> 
          <table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="3"  >
           
            <tr style="Font-weight:bold"  bordercolor="#FFFFFF"> 
              <td rowspan="2" width="5%">Sr.No</td>
            <%if(!(Org_level.equalsIgnoreCase("A"))){ %>		
              <td rowspan="2" width="5%">Branch</td>
               <%} %>
               <td rowspan="2" width="10%">Account Number</td>
              <td rowspan="2" width="10%">Name of the Account</td>
              <td  rowspan="2" width="8%">Nature of Facility</td>
              <td colspan="2" align="center" width="28%">Amount</td>
              <td  rowspan="2" width="10%">Excess / Overdues</td>
              <td  rowspan="2" width="4%">since when</td>
             <td  rowspan="2" width="8%">EAS - I / II / SMA</td>
             <td  rowspan="2" width="6%">Remarks</td>
			  <td  rowspan="2" width="10%">Action 
                initiated for regularisation</td>
			<td  rowspan="2" width="10%">Plan of Action, with specific reference to compliance of previous directives, suggested by the Asset Quality Management Committee</td>	
		  </tr>
			<tr style="Font-weight:bold"  bordercolor="#FFFFFF">
			  <td width="14%">Limit</td>
              <td width="14%">O/s</td>
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
			<%if(!(Org_level.equalsIgnoreCase("A"))){ %>						
              <td>&nbsp;<%=Helper.correctNull((String)arrCol.get(0))%></td>
				<%} %>				
				<td>&nbsp;<%//=Helper.correctNull((String)arrCol.get(9))%><%=Helper.correctNull((String)arrCol.get(7))%></td>
              <td>&nbsp;<%=Helper.correctNull((String)arrCol.get(1))%></td>
								
              <td>&nbsp;<%=Helper.correctNull((String)arrCol.get(2))%></td>
								
              <td align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3)))))%>
			  <%  // dbVal1 = dbVal1 +Double.parseDouble(Helper.correctDouble((String)arrCol.get(3)));
						%>
								
              <td align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4)))))%></td>
								<%   dbVal2 = dbVal2 +Double.parseDouble(Helper.correctDouble((String)arrCol.get(4)));
			%>
              <td align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5)))))%>
			   <%   dbVal3 = dbVal3 +Double.parseDouble(Helper.correctDouble((String)arrCol.get(5)));%>
			  			  </td>
								
              <td>&nbsp;<%=Helper.correctNull((String)arrCol.get(6))%></td>
								
             <td>&nbsp;<%=Helper.correctNull((String)arrCol.get(10))%></td>
								
              <td>&nbsp;<%=Helper.correctNull((String)arrCol.get(9))%></td>
			  <td>&nbsp; </td>
			  <td>&nbsp; </td>
						</tr>
			<%}}}
			%>
			<%if(arrRow!=null){ %>
		<tr style="Font-weight:bold"  bordercolor="#FFFFFF">
			<td>&nbsp;</td>
			<%if(!(Org_level.equalsIgnoreCase("A"))){ %>
			<td>&nbsp;</td>
			 <%} %>
			<td  align = "right" >&nbsp;</td>
			<td  align = "right" >&nbsp;</td>
			    <td><b>Grand Total</b></td>
			<td  align = "right" nowrap><b><%//=Helper.converToLakhs(Helper.formatDoubleValue(dbVal1))%></b></td>
			<td  align = "right" nowrap><b><%=Helper.converToLakhs(Helper.formatDoubleValue(dbVal2))%></b></td>
			<td  align = "right" nowrap><b><%=Helper.converToLakhs(Helper.formatDoubleValue(dbVal3))%></b></td>
			 <td>&nbsp; </td>
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
  
</form>
</body>
</html>
