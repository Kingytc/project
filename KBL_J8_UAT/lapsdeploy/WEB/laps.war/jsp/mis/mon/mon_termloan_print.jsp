<%@ include file="../../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>

<%
     ArrayList arrRow  = null;
	
	arrRow =   (ArrayList)hshValues.get("arrRow");
	
	 		 
	 ArrayList arrCol = null;
	 
	String rowsrange = (String)request.getParameter("rowsrange");
	String tempRowcount =  (String)request.getParameter("tempRowcount");
	int tempInteger=0;
	
	session.setAttribute("sessionArrRow",arrRow);
	
	
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
function doNext()
{
	document.forms[0].action=AppUrl+"action/mon_termloan_print.jsp";
	document.forms[0].hidMethod.value="getTermLoanReviewReport";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].hidSourceUrl.value=AppUrl+"action/mon_termloan_print.jsp";
	document.body.style.display="none";
	document.forms[0].submit();
}
function doPrintPreview()
{
	
	var tempRowcount = "<%=(String)request.getParameter("tempRowcount")%>"
	var org_name = "<%=Helper.correctNull((String)request.getParameter("org_name"))%>"
	var varstatus = "<%=Helper.correctNull((String)request.getParameter("varstatus"))%>"
	var vartxtDate = "<%=Helper.correctNull((String)request.getParameter("vartxtDate"))%>"
	var sellevel = "<%=Helper.correctNull((String)request.getParameter("sellevel"))%>"
	window.open(AppUrl+"action/mon_termloanprint_outpage.jsp?tempRowcount="+tempRowcount+"&org_name="+org_name+"&varstatus="+varstatus+"&sellevel="+sellevel
	,"","scrollbars=Yes,toolbars=No,menubar=Yes ,width=900 , height=800,top=10,left=10")
}
function doPrevious()
{
	history.back();
}
function doClose()
{
	window.close();
}

</script>



</head>

<body>
<form name= "orgfrm" method="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
    <tr> 
      <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>
    </tr>
    <tr> 
      <td align="center"><strong>Karnataka Bank Ltd.</strong></td>
    </tr>
    <tr> 
      <td align="center"><b> <%=Helper.correctNull((String)hshValues.get("orgname")) %></b> 
    </tr>
    <tr> 
      <td align="center"><b>Status Of Term Loan Review Note Report</b></td>
    </tr>
    <tr> 
      <td align="center"></td>
    </tr>
    <tr> 
      <td align="center"><b></b></td>
    </tr>
    <tr> 
      <td align="RIGHT">&nbsp;</td>
    </tr>
  </table>
<div class="cellContainer">
  
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1"  align="center">
      <tr> 
        <td height="3"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" >
          
            <tr class="dataheader"> 
              <td>Sr.No</td>
              <td>Name of the Customer</td>
              <td>CBS ID</td>
              <td>Review Due</td>
              <%if(Helper.correctNull((String)request.getParameter("varstatus")).equalsIgnoreCase("PA")){ %>
              
              <td>Reviewed on</td>
              <td>Approved By</td>
              
              <%}else if(Helper.correctNull((String)request.getParameter("varstatus")).equalsIgnoreCase("OP")){%>
              
              <td>Applied on</td>
              <td>Pending With</td>
              
              <%}%>
              
              <%if(!(Helper.correctNull((String)request.getParameter("sellevel")).equalsIgnoreCase("A"))){ %>
              <td>Branch</td>
              <%}%>
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
				
			<tr class="datagrid">
	              <td><%=++tempInteger%>&nbsp;</td>
				  <td><%=Helper.correctNull((String)arrCol.get(0))%>&nbsp;</td>			
	              <td><%=Helper.correctNull((String)arrCol.get(1))%>&nbsp;</td>
	              <td><%=Helper.correctNull((String)arrCol.get(2))%>&nbsp;</td>
                  
                  <%if(Helper.correctNull((String)request.getParameter("varstatus")).equalsIgnoreCase("PA")){ %>
                  
                  <td><%=Helper.correctNull((String)arrCol.get(3))%>&nbsp;</td> 
                   <td><%=Helper.correctNull((String)arrCol.get(4))%>&nbsp;</td> 
                  
                   <%}else if(Helper.correctNull((String)request.getParameter("varstatus")).equalsIgnoreCase("OP")){%>
                  
                  <td><%=Helper.correctNull((String)arrCol.get(3))%>&nbsp;</td> 
                   <td><%=Helper.correctNull((String)arrCol.get(4))%>&nbsp;</td> 
                  
                  <%}%>
                  <%if(!(Helper.correctNull((String)request.getParameter("sellevel")).equalsIgnoreCase("A"))){ %>
                   <td><%=Helper.correctNull((String)arrCol.get(5))%>&nbsp;</td> 
                   <%}%>
  			 </tr>
			<%}}}%>
		  </table>
        </td>
      </tr>
    </table>
  </div>
  <br>
<%if(!tempRowcount.equals("0"))
			{%>
<lapschoice:combuttonnew btnnames="Previous_Print Preview"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
							<%} else if(arrRow!=null && arrRow.size()==Double.parseDouble(rowsrange)) 
			 {%> 
<lapschoice:combuttonnew btnnames="Previous_Print Preview_Next"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
							<%}else{ %>
<lapschoice:combuttonnew btnnames="Print Preview"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
			<%} %>				 
   <lapschoice:hiddentag pageid='<%=PageId%>'/>
 
  
<input type="hidden" name="sellevel" value="<%=(String)request.getParameter("sellevel")%>">
<input type="hidden" name="txtlimitfrom" value="<%=(String)request.getParameter("txtlimitfrom")%>">
<input type="hidden" name="txtlimitto" value="<%=(String)request.getParameter("txtlimitto")%>">
<input type="hidden" name="rpselect1" value="<%=(String)request.getParameter("rpselect1")%>">
<input type="hidden" name="rowsrange" value="<%=(String)request.getParameter("rowsrange")%>">
<input type="hidden" name="tempRowcount" value="<%=tempInteger%>">
<input type="hidden" name="limit" value="<%=(String)hshValues.get("limit")%>" >
<input type="hidden" name="offset" value="<%=(String)hshValues.get("offset")%>" >
<input type="hidden" name="tempTableCheck" value="<%=(String)hshValues.get("tempTableCheck")%>" >
<input type="hidden" name="org_name" value="<%=(String)hshValues.get("orgname")%>">
<input type="hidden" name="varstatus" value="<%=(String)request.getParameter("varstatus")%>">
<input type="hidden" name="fromdate" value="<%=(String)request.getParameter("fromdate")%>">
<input type="hidden" name="todate" value="<%=(String)request.getParameter("todate")%>">

</form>
</body>
</html>
