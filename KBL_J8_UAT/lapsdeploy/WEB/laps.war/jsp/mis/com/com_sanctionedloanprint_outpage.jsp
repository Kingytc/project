<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
	ArrayList arrCol = null;
	ArrayList arrRow  = (ArrayList) session.getAttribute("sessionArrRow");
	
	String tempRowcount =  (String)request.getParameter("tempRowcount");
	int tempInteger=0;
	String rowsrange = (String)request.getParameter("rowsrange");
	
	String strDate=Helper.correctNull((String)request.getParameter("fromdate"));
	String strmonth="";
	String stryear="";
	if(!(strDate.equalsIgnoreCase("")))
	{
		strmonth=strDate.substring(3,5);
		stryear=strDate.substring(6,10);
	}
	
	String strsisrow="0";
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
      <td align="right"><b>M - 27</b></td>
    </tr>
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
      <td align="center"><b><b>STATEMENT OF LOANS / LIMITS SANCTIONED 
        BY <%=Helper.correctNull((String)request.getParameter("sanctionauth")).toUpperCase()%> UNDER THE DELEGATED AUTHORITY POWER</b></b></td>
    </tr>
    <tr> 
      <td align="center"><b>DURING THE MONTH OF <%=Helper.getMonths(Integer.parseInt(Helper.correctInt(strmonth)))%>&nbsp;<%=stryear%></b></td>
    </tr>
    <tr> 
      <td align="right" colspan="2">(Amount Rs. in Lacs)</td>
    </tr>
  </table>
<div class="cellContainer">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"   align="center">
      <tr> 
        <td> 
		<div id="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="3"  >
              <tr style="Font-weight:bold"  class="tblhead"> 
                <td align="center" rowspan="2">Sr. No.</td>
                <td align="center" rowspan="2">Date of Sanction</td>
                <td align="center" rowspan="2">Name of the Borrower</td>
                <%if(!(Helper.correctNull((String)request.getParameter("sellevel")).equalsIgnoreCase("A"))){ %>
                <td align="center" rowspan="2">Branch</td>
                <%} %>
                <td align="center" rowspan="2">Financial worth</td>
                <td align="center" colspan="3">Name of allied / sister concern 
                  &amp; Amount</td>
                <td align="center" rowspan="2">Seg-ment</td>
                <td colspan="2" align="center">Nature of limit</td>
                <td align="center" rowspan="2">Fresh / Renewal / Enhancement</td>
                <td align="center" rowspan="2">Rate of Interest (%)</td>
                <td align="center" rowspan="2">Margin (%)</td>
                <td align="center" rowspan="2">Details of securities &amp; collateral 
                </td>
              </tr>
              <tr style="Font-weight:bold"  class="tblhead"> 
                <%if(!(Helper.correctNull((String)request.getParameter("sellevel")).equalsIgnoreCase("A"))){ %>
                <%} %>
                <td align="center">Name</td>
                <td align="center">Fund Based</td>
                <td align="center">Non-Fund Based</td>
                <td align="center">Fund Based</td>
                <td align="center">Non Fund Based</td>
              </tr>
              <%
            double  dblProp=0.0;
            double dblExist=0.0;
            String strtype="";
            if(arrRow!=null && arrRow.size()>0)
			{
				Iterator it = arrRow.iterator();
				 tempInteger = Integer.parseInt(tempRowcount);
				for(int i=0;it.hasNext();i++)
				{
					arrCol = (ArrayList) it.next();
					if(arrCol!=null)
					{
					
						dblProp=Double.parseDouble(Helper.correctDouble((String)arrCol.get(10)));
						dblExist=Double.parseDouble(Helper.correctDouble((String)arrCol.get(9)));
						
						if(dblExist==0.00)
						{
							strtype="Fresh";
						}
						else if((dblExist!=0.00) && (dblProp==dblExist))
						{
							strtype="Renewal";							
						}
						else if((dblExist!=0.00) && (dblProp < dblExist))
						{
							strtype="Renewal";							
						}
						else if((dblExist!=0.00) && (dblProp > dblExist))
						{
							strtype="Enhance";							
						}
						
						strsisrow=Helper.correctNull((String)arrCol.get(12));
					%>
              <tr > 
                <td><%=++tempInteger%>&nbsp;</td>
                <td><%=Helper.correctNull((String)arrCol.get(0))%>&nbsp;</td>
                <td><%=Helper.correctNull((String)arrCol.get(1))%>&nbsp;</td>
                <%if(!(Helper.correctNull((String)request.getParameter("sellevel")).equalsIgnoreCase("A"))){ %>
                <td><%=Helper.correctNull((String)arrCol.get(2))%></td>
                <%} %>
                <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))%>&nbsp;</td>
                <td align="right" > 
                  <div id="top1"> 
                    <table width="100%" border="0"  >
                      <%
			ArrayList arrSis = new ArrayList();
			arrSis = (ArrayList)arrCol.get(8);
			int sisSize = arrSis.size();
				if(arrSis!=null && sisSize>0)
			{
			for(int j=0;j<sisSize;j++)
			{
				ArrayList arrSisRecords = new ArrayList();
				arrSisRecords = (ArrayList)arrSis.get(j); 
			%>
                      <tr> 
                        <td valign="top"><%=j+1%>&nbsp;.&nbsp;<%=Helper.correctNull((String) arrSisRecords.get(2))%></td>
                      </tr>
                      <%
			}
			}
			%>
                    </table>
                  </div>
                </td>
                <td align="right"> 
                  <div id="top1"> 
                    <table width="100%" border="0">
                      <%
			arrSis = new ArrayList();
			arrSis = (ArrayList)arrCol.get(8);
			sisSize = arrSis.size();
				if(arrSis!=null && sisSize>0)
			{
			for(int j=0;j<sisSize;j++)
			{
				ArrayList arrSisRecords = new ArrayList();
				arrSisRecords = (ArrayList)arrSis.get(j); 
			%>
                      <tr> 
                        <td valign="bottom" align="right" >&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrSisRecords.get(0))))%> 
                        </td>
                      </tr>
                      <%
			}
			}
			%>
                    </table>
                  </div>
                </td>
                <td align="right" > 
                  <div id="top1"> 
                    <table width="100%" border="0">
                      <%
			arrSis = new ArrayList();
			arrSis = (ArrayList)arrCol.get(8);
			sisSize = arrSis.size();
				if(arrSis!=null && sisSize>0)
			{
			for(int j=0;j<sisSize;j++)
			{
				ArrayList arrSisRecords = new ArrayList();
				arrSisRecords = (ArrayList)arrSis.get(j); 
			%>
                      <tr> 
                        <td align="right" ><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrSisRecords.get(1))))%> 
                        </td>
                      </tr>
                      <%
			}
			}
			%>
                    </table>
                  </div>
                </td>
                <%if(Helper.correctNull((String)arrCol.get(11)).equalsIgnoreCase("P")){ %>
                <td align="center">Retail</td>
                <%}else if(Helper.correctNull((String)arrCol.get(11)).equalsIgnoreCase("A")){ %>
                <td align="center">Agriculture</td>
                <%}else if(Helper.correctNull((String)arrCol.get(11)).equalsIgnoreCase("T")||Helper.correctNull((String)arrCol.get(11)).equalsIgnoreCase("HC")){ %>
                <td align="center">Tertiary</td>
                <%}else if(Helper.correctNull((String)arrCol.get(11)).equalsIgnoreCase("C")){ %>
                <td align="center">Corporate</td>
                <%}%>
                <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%>&nbsp;</td>
                <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))%>&nbsp;</td>
                <%if((Helper.correctNull((String)arrCol.get(11)).equalsIgnoreCase("P")) || (Helper.correctNull((String)arrCol.get(11)).equalsIgnoreCase("A"))){ %>
                <td align="center">Fresh</td>
                <%}else{ %>
                <td align="center"><%=strtype%></td>
                <%} %>
                <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))%>&nbsp;</td>
                <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7))))%>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <%}}}else {%>
              <tr style="Font-weight:bold" class="tblhead"> 
                <td colspan="13" align="center"><b>No Data Found</b> </td>
              </tr>
              <%} %>
            </table>
		    </div>
        </td>
      </tr>
    </table>
	
	  <table width="100%" border="0">
	  <%if(arrRow!=null && arrRow.size()!=Double.parseDouble(rowsrange)) {%> 
  <tr>
    <td>Please Find enclosed copies of Process Note(s),Sanction advice(s), etc.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right"><%=Helper.correctNull((String)request.getParameter("sanctionauth"))%></td>
  </tr>
  <%}%>
</table>
	  
  </div>
  <br>
</form>
</body>
</html>
