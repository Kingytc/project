<%@ include file="../../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>

<%
     ArrayList arrRow  = null;
	
	arrRow =   (ArrayList)hshValues.get("arrRow");
	
	 		 
	 ArrayList arrCol = null;
	 
	String rowsrange = (String)request.getParameter("rowsrange");
	String tempRowcount =  (String)request.getParameter("tempRowcount");
	double dbVal1 = 0.00;
	double dbVal2 = 0.00;
	double dbVal3 = 0.00;
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
	document.forms[0].action=AppUrl+"action/monitoring_sanctionprint.jsp";
	document.forms[0].hidMethod.value="getMonitoringSanction";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].hidSourceUrl.value=AppUrl+"action/monitoring_sanctionprint.jsp";
	document.body.style.display="none";
	document.forms[0].submit();
		
	//window.open(AppUrl+"action/mon_annexurec_print.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getMonitoringReport&sellevel="+sellevel+"&accountclasssel="+accountclasssel+"&rpselect1="+rpselect1+"&parameterselect="+parameterselect+"&txtlimitfrom="+txtlimitfrom+"&txtlimitto="+txtlimitto+"&txtoutstandingfrom="+txtoutstandingfrom+"&txtoutstandingto="+txtoutstandingto+"&txtexcessfrom="+txtexcessfrom+"&txtexcessto="+txtexcessto+"&limit="+limit+"&offset="+offset+"&tempTableCheck="+tempTableCheck,"","scrollbars=Yes,toolbars=No,menubar=no ,width=900 , height=800,top=10,left=10");
}

function doPrintPreview()
{
	
	var tempRowcount = "<%=(String)request.getParameter("tempRowcount")%>"
	var Org_level="<%=Helper.correctNull((String)hshValues.get("Orglevel"))%>"
	var Org_Name="<%=Helper.correctNull((String)hshValues.get("Org_Name"))%>"
	var Acct_class="<%=Helper.correctNull((String)hshValues.get("account_class"))%>"
	var Totoverdue="<%=Helper.correctNull((String)hshValues.get("totoverdue"))%>"
	var Due_Date="<%=Helper.correctNull((String)hshValues.get("txtDate"))%>"
	window.open(AppUrl+"action/monitoring_sanctionprint_outpage.jsp?tempRowcount="+tempRowcount+"&Org_level="+Org_level+"&Org_Name="+Org_Name+"&Acct_class="+Acct_class+"&Totoverdue="+Totoverdue+"&Due_Date="+Due_Date,"","scrollbars=Yes,toolbars=No,menubar=yes ,width=900, height=500,top=10,left=10");
	
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

<body  >
<form name= "orgfrm" method="post" class="normal">
<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>          		
        </tr>
        <tr> 
          <td align="center"><strong>Karnataka Bank Ltd.</strong></td>
        </tr>
         <tr> 
          <td align="center"><b> <%=Helper.correctNull((String)hshValues.get("Org_Name"))%>
          <%//=Helper.correctNull((String)session.getAttribute("strOrgName"))%> </b></td>
        </tr> 
        <tr> 
          <td align="center">REPORT FOR</td>
        </tr>
      
        <tr> 
     	<td align="center">NEW LIMITS SANCTIONED 
     	 <%if(!(Helper.correctNull((String)hshValues.get("txtDate")).trim().equalsIgnoreCase("All"))) 
     	 { %>
     	 DURING  ( <%=Helper.correctNull((String)hshValues.get("txtDate"))%> )
     	 <%} %> 
     	 </td>
        </tr>
		<tr> 
         <td align="RIGHT">&nbsp;(All Values are in Lacs)</td>
        </tr>
 </table>
<div class="cellContainer">
  
   <table class="outertable border1"  width="100%" border="0" cellspacing="0" cellpadding="0"   align="center">
      <tr> 
        <td height="3"> 
         <table class="outertable border1"  width="100%" border="0" cellspacing="0" cellpadding="3"  >
           
            <tr class="dataheader"> 
              <td width="3%">Sr.No</td>
              <td width="10%" align="center">Date of Opening</td>
                <td width="15%" align="center">Account No.</td>
               <td width="32%" align="center">Account Name</td>
              <td align="center" width="10%">Amount</td>
              <td align="center" width="20%">Sanctioning Authority</td>
               <%if(!(Helper.correctNull((String)hshValues.get("Orglevel"))).equalsIgnoreCase("A")) {%>
              <td width="25%" align="center">Branch</td>
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
				
						<tr class="datagrid">
								
              <td align="center">&nbsp;<%=++tempInteger%></td>
              <td align="center">&nbsp;<%=Helper.correctNull((String)arrCol.get(0))%></td>
              <td>&nbsp;<%=Helper.correctNull((String)arrCol.get(1))%></td>
              <td>&nbsp;<%=Helper.correctNull((String)arrCol.get(2))%></td>
              <td align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3)))))%></td>
			<%   dbVal2 = dbVal2 +Double.parseDouble(Helper.correctDouble((String)arrCol.get(3)));%>			
			<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(5))%></td>
             <%if(!(Helper.correctNull((String)hshValues.get("Orglevel"))).equalsIgnoreCase("A")) {%>					
              <td>&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%></td>
				<%} %>	
						</tr>
			<%}}}%>
			<%if(arrRow!=null){ %>
		<tr class="dataheader">
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			  <td  align = "right"><b>Grand Total </b></td>  
			  <td  align = "right"><b><%=Helper.converToLakhs(Helper.formatDoubleValue(dbVal2))%></b>&nbsp;</td>
			  <td>&nbsp;</td>
			  <%if(!(Helper.correctNull((String)hshValues.get("Orglevel"))).equalsIgnoreCase("A")) {%>
			  <td  align = "right">&nbsp;</td>
			  <%} %>
		 </tr>
		<%}%>
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
 <input type="hidden" name="accountclasssel" value="<%=(String)request.getParameter("accountclasssel")%>">
 <input type="hidden" name="parameterselect" value="<%=(String)request.getParameter("parameterselect")%>">
 <input type="hidden" name="txtfromamt" value="<%=(String)request.getParameter("txtfromamt")%>">
 <input type="hidden" name="txttoamt" value="<%=(String)request.getParameter("txttoamt")%>">
 <input type="hidden" name="txtoutstandingfrom" value="<%=(String)request.getParameter("txtoutstandingfrom")%>">
 <input type="hidden" name="txtoutstandingto" value="<%=(String)request.getParameter("txtoutstandingto")%>">
 <input type="hidden" name="txtDate" value="<%=(String)request.getParameter("txtDate")%>">
<input type="hidden" name="orglevel" value="<%=(String)request.getParameter("orglevel")%>">
<input type="hidden" name="rpselect1" value="<%=(String)request.getParameter("rpselect1")%>">
<input type="hidden" name="rowsrange" value="<%=(String)request.getParameter("rowsrange")%>">
<input type="hidden" name="tempRowcount" value="<%=tempInteger%>">
<input type="hidden" name="hidOrgCode" value="<%=(String)request.getParameter("hidOrgCode")%>">
<input type="hidden" name="limit" value="<%=(String)hshValues.get("limit")%>" >
<input type="hidden" name="offset" value="<%=(String)hshValues.get("offset")%>" >
<input type="hidden" name="tempTableCheck" value="<%=(String)hshValues.get("tempTableCheck")%>" >
<input type="hidden" name="hidOrgName" value="<%=(String)hshValues.get("Org_Name")%>">
<input type="hidden" name="hidaccclass_text" value="<%=Helper.correctNull((String)hshValues.get("account_class"))%>">

</form>
</body>
</html>
