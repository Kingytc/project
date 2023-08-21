<%@include file="../../share/directives.jsp"%><%
     ArrayList arrRow  = null;
	
	arrRow =   (ArrayList)hshValues.get("arrRow");
	
	 ArrayList arrCol = null;
	 
	String rowsrange = (String)request.getParameter("rowsrange");
	String tempRowcount =  (String)request.getParameter("tempRowcount");
	int tempInteger=0;
	session.setAttribute("sessionArrRow",arrRow);
	
	String strDate1=Helper.correctNull((String)request.getParameter("fromdate"));
	String strmonth="";
	String stryear="";
	if(!(strDate.equalsIgnoreCase("")))
	{
		strmonth=strDate1.substring(3,5);
		stryear=strDate1.substring(6,10);
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
	document.forms[0].action=AppUrl+"action/com_sanctionedloan_print.jsp";
	document.forms[0].hidMethod.value="getSanctionedloanReport";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].hidSourceUrl.value=AppUrl+"action/com_sanctionedloan_print.jsp";
	document.body.style.display="none";
	document.forms[0].submit();
}

function printpreview()
{
	var tempRowcount = "<%=(String)request.getParameter("tempRowcount")%>"
	var org_name = "<%=Helper.correctNull((String)request.getParameter("org_name"))%>"
	var varloantype = "<%=Helper.correctNull((String)request.getParameter("varloantype"))%>"
	var vartxtDate = "<%=Helper.correctNull((String)request.getParameter("vartxtDate"))%>"
	var sellevel = "<%=Helper.correctNull((String)request.getParameter("sellevel"))%>"
	var rowsrange = "<%=Helper.correctNull((String)request.getParameter("rowsrange"))%>"
	var fromdate = "<%=Helper.correctNull((String)request.getParameter("fromdate"))%>"
	var sanctionauth= "<%=Helper.correctNull((String)request.getParameter("sanctionauth"))%>"
	
	window.open(AppUrl+"action/com_sanctionedloanprint_outpage.jsp?tempRowcount="+tempRowcount
	+"&org_name="+org_name
	+"&varloantype="+varloantype
	+"&sellevel="+sellevel
	+"&rowsrange="+rowsrange
	+"&fromdate="+fromdate
	+"&sanctionauth="+sanctionauth
	,"","scrollbars=Yes,toolbars=No,menubar=Yes ,width=900 , height=800,top=10,left=10")
}

</script>



</head>

<body  >
<form class="normal" name= "orgfrm" method="post">
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr> 
      <td align="right"><b>M - 27</b></td>
    </tr>
    <tr> 
      <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>
    </tr>
    <tr> 
      <td align="center" ><strong>Karnataka Bank Ltd.</strong></td>
    </tr>
    <tr> 
      <td align="center"><b> <%=Helper.correctNull((String)hshValues.get("orgname")) %></b> 
    </tr>
    <tr> 
      <td align="center" colspan="2"><b>STATEMENT OF LOANS / LIMITS SANCTIONED 
        BY <%=Helper.correctNull((String)request.getParameter("sanctionauth")).toUpperCase()%> 
        UNDER THE DELEGATED AUTHORITY POWER</b></td>
    </tr>
    <tr> 
      <td align="center" colspan="2"><b>DURING THE MONTH OF <%=Helper.getMonths(Integer.parseInt(Helper.correctInt(strmonth)))%>&nbsp;<%=stryear%></b></td>
    </tr>
    <tr> 
      <td align="center" colspan="2"><b></b></td>
    </tr>
    <tr> 
      <td align="RIGHT" colspan="2">(Amount Rs. in Lacs)</td>
    </tr>
  </table>
<div class="cellContainer">
  
    
          <table class="outertable border1" width="100%" border="0" cellspacing="0" cellpadding="3"  >
            <tr > 
              <td align="center" rowspan="2">Sr. No.</td>
              <td align="center" rowspan="2">Date of Sanction</td>
              <td align="center" rowspan="2">Name of the Borrower</td>
              <%if(!(Helper.correctNull((String)request.getParameter("sellevel")).equalsIgnoreCase("A"))){ %>
              <td align="center" rowspan="2">Branch</td>
              <%} %>
              <td align="center" rowspan="2">Financial worth</td>
              <td align="center" colspan="3">Name of allied / sister concern &amp; 
                Amount</td>
              <td align="center" rowspan="2">Seg-ment</td>
              <td colspan="2" align="center">Nature of limit</td>
              <td align="center" rowspan="2">Fresh / Renewal / Enhancement</td>
              <td align="center" rowspan="2">Rate of Interest (%)</td>
              <td align="center" rowspan="2">Margin (%)</td>
              <td align="center" rowspan="2">Details of securities &amp; collateral 
              </td>
            </tr>
            <tr > 
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
					%>
            <tr > 
              <td><%=++tempInteger%>&nbsp;</td>
              <td><%=Helper.correctNull((String)arrCol.get(0))%>&nbsp;</td>
              <td><%=Helper.correctNull((String)arrCol.get(1))%>&nbsp;</td>
              <%if(!(Helper.correctNull((String)request.getParameter("sellevel")).equalsIgnoreCase("A"))){ %>
              <td><%=Helper.correctNull((String)arrCol.get(2))%></td>
              <%} %>
              <td align="right" > <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))%></td>
              <td align="right" rowspan="1"> 
                <div id="top1"> 
                  <table class="outertable" width="100%" border="0"  >
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
                  <table class="outertable" width="100%" border="0">
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
                  <table class="outertable" width="100%" border="0">
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
            <%}}} else {%>
            <tr> 
              <td colspan="15" align="center"> <b>No Data Found</b> </td>
            </tr>
            <%} %>
          </table>
        </td>
      </tr>
    </table>
  </div>
  <br>
  <table class="outertable border1" border="0" cellspacing="0" cellpadding="0"  align="center">
    <tr> 
      <td height="17"> 
        <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr> 
		
			
			<%if(!tempRowcount.equals("0"))
			{%>
			
			 <td width='45%'>
			<div align='center'>
			 <input type='button' name='Button2322532' value='<<< Previous' class="buttonothers" onclick='history.back()'>
			  </div>
			 </td>
			<%}%> 
			
            <td width="45%"> 
              <div align="center"> 
                <input type="button" name="Button232253" value="Close"  onClick="window.close()" class="buttonclose">
              </div>
            </td>
            <td width="55%"> 
              <div align="center"> 
                <input type="button" name="Button2322532" value="Print Preview" class="buttonothers" onclick="printpreview()">
				
				
              </div>
            </td>
			<td width="55%"> 
              <div align="center"> 
			 <%if(arrRow!=null && arrRow.size()==Double.parseDouble(rowsrange)) 
			 {%> 
			<input type="button" name="Button2322532" value="Next >>>" class="buttonothers" onclick="nextRep()">
        	<%}%>	
			</div>
            </td>
		
		  </tr>
        
  </table>
  </td>
  </tr>
  </table><br>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
 <input type="hidden" name="hidMethod">
 
  
<input type="hidden" name="sellevel" value="<%=(String)request.getParameter("sellevel")%>">
<input type="hidden" name="rpselect1" value="<%=(String)request.getParameter("rpselect1")%>">
<input type="hidden" name="rowsrange" value="<%=(String)request.getParameter("rowsrange")%>">
<input type="hidden" name="tempRowcount" value="<%=tempInteger%>">
<input type="hidden" name="limit" value="<%=(String)hshValues.get("limit")%>" >
<input type="hidden" name="offset" value="<%=(String)hshValues.get("offset")%>" >
<input type="hidden" name="org_name" value="<%=(String)hshValues.get("orgname")%>">
<input type="hidden" name="varloantype" value="<%=(String)request.getParameter("varloantype")%>">
<input type="hidden" name="fromdate" value="<%=(String)request.getParameter("fromdate")%>">
<input type="hidden" name="todate" value="<%=(String)request.getParameter("todate")%>">
<input type="hidden" name="sanctionlevel" value="<%=(String)request.getParameter("sanctionlevel")%>">
<input type="hidden" name="moduleType" value="<%=(String)hshValues.get("ModuleType")%>" >
<input type="hidden" name="sanctionauth" value="<%=(String)request.getParameter("sanctionauth")%>">
</form>
</body>
</html>
