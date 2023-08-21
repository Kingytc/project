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
	String Totoverdue=(String)request.getParameter("Totoverdue");
	String Due_Date=(String)request.getParameter("Due_Date");
	ArrayList arrCol = new ArrayList();
	int tempInteger=0;
	double dbVal2 = 0.00;
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
	document.forms[0].action=AppUrl+"action/monitoring_sanctionprint.jsp";
	document.forms[0].hidMethod.value="getMonitoringSanction";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].hidSourceUrl.value=AppUrl+"action/monitoring_sanctionprint.jsp";
	document.body.style.display="none";
	document.forms[0].submit();
		
	//window.open(AppUrl+"action/mon_annexurec_print.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getMonitoringReport&sellevel="+sellevel+"&accountclasssel="+accountclasssel+"&rpselect1="+rpselect1+"&parameterselect="+parameterselect+"&txtlimitfrom="+txtlimitfrom+"&txtlimitto="+txtlimitto+"&txtoutstandingfrom="+txtoutstandingfrom+"&txtoutstandingto="+txtoutstandingto+"&txtexcessfrom="+txtexcessfrom+"&txtexcessto="+txtexcessto+"&limit="+limit+"&offset="+offset+"&tempTableCheck="+tempTableCheck,"","scrollbars=Yes,toolbars=No,menubar=no ,width=900 , height=800,top=10,left=10");
}





</script>
</head>

<body  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name= "orgfrm" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          
      <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg" width="30" height="20"></td>          		
        </tr>
        <tr> 
          <td align="center"><strong>Karnataka Bank Ltd.</strong></td>
        </tr>
         <tr> 
          <td align="center"><b> <%=Org_Name%>
          <%//=Helper.correctNull((String)session.getAttribute("strOrgName"))%></b></td>
        </tr> 
        <tr> 
          <td align="center">REPORT FOR</td>
        </tr>
        <tr> 
          
      <td align="center">NEW LIMITS SANCTIONED <%if(!(Due_Date.equalsIgnoreCase("All"))){ %>
      DURING - ( <%=Due_Date%> )
      <%} %>
      </td>
        </tr>
        <tr> 
         <td align="RIGHT">&nbsp;(All Values are in Lacs)</td>
        </tr>
 </table>
<div class="cellContainer">
  
    <table width="100%" border="0" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"   align="center">
      <tr> 
        <td> 
        <div id="top">
          <table width="100%" border="0" cellspacing="0" cellpadding="3"  nowrap>
           
            <tr style="Font-weight:bold" class="tblhead" > 
                <td width="5%">Sr.No</td>
                <td align="center"  width="10%">Date of Opening</td>
                <td align="center" width="14%">Account No.</td>
                <td align="center" width="26%">Account Name</td>
                <td align="center" width="8%">Amount</td>
                <td align="center" width="15%">Sanctioning Authority</td>
               <%if(!(Org_level.equalsIgnoreCase("A"))){ %>		
                <td align="center" width="22%"  >Branch</td>
              <%} %>
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
				
						<tr>
								
                <td align="center">&nbsp;<%=++tempInteger%></td>
                <td align="center">&nbsp;<%=Helper.correctNull((String)arrCol.get(0))%></td>
                <td align="center">&nbsp;<%=Helper.correctNull((String)arrCol.get(1))%></td>
                <td>&nbsp;<%=Helper.correctNull((String)arrCol.get(2))%></td>
                <td align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3)))))%></td>
			<%   dbVal2 = dbVal2 +Double.parseDouble(Helper.correctDouble((String)arrCol.get(3)));%>			
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(5))%></td>
             <%if(!(Org_level.equalsIgnoreCase("A"))){ %>						
                <td align="center">&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%></td>
				<%} %>	
						</tr>
			<%}}}
			%>
			<%if(arrRow!=null){ %>
		<tr style="Font-weight:bold"  bordercolor="#FFFFFF">
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td  align = "right"><b>Grand Total </b></td>  
			    <td  align = "right"><b><%=Helper.converToLakhs(Helper.formatDoubleValue(dbVal2))%></b>&nbsp;</td>
			    <td  align = "right">&nbsp;</td>
			   <%if(!(Org_level.equalsIgnoreCase("A"))){ %>		
			    <td  align = "right">&nbsp;</td>
			     <%} %>
		 </tr>
		<%}%>
		  </table>
		  </div>
        </td>
      </tr>
    </table>
  </div>
<br>
  
</form>
</body>
</html>
