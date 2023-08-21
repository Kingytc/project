<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<html>
<head>
<title>KARNATAKA BANK LTD.</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="0" cellpadding="2"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3" bordercolor="#999999">
        <tr> 
          <td align="right" colspan="3">&nbsp;</td>
        </tr>
        <tr> 
          <td align="center" colspan="3"><img
					src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>
        </tr>
        <tr> 
            <td align="center" colspan="3"><b>KARNATAKA BANK LTD.</b></td>
        </tr>
        <tr> 
          <td align="center" colspan="3"><b><%=Helper.correctNull((String)hshValues.get("branchname"))%></b></td>
        </tr>
        <tr> 
          <td align="center" colspan="3"><b>Tertiary Process Note</b></td>
        </tr>
        <tr> 
          <td ALIGN="LEFT" colspan="2"><b>Application for loan of </b></td>
          <td ALIGN="LEFT" width="59%">Rs. <%=Helper.checkDecimal(Helper.correctNull((String)hshValues.get("proposed")))%></td>
        </tr>
        <tr> 
          <td colspan="2"><b>Name of the Account</b></td>
          <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("Title"))%>&nbsp;<%=Helper.correctNull((String)hshValues.get("appname"))%></td>
        </tr>
        <tr> 
          <td colspan="3">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="2"><b>1. Name of the Applicant </b></td>
          <td width="59%"><%=Helper.correctNull((String)hshValues.get("Title"))%>&nbsp;<%=Helper.correctNull((String)hshValues.get("appname"))%></td>
        </tr>
        <tr> 
          <td colspan="2" valign="top"><b>2. Address</b></td>
          <td width="59%">&nbsp; <b><%=Helper.correctNull((String) hshValues.get("perapp_address1"))%></b><br>
            &nbsp; <b><%=Helper.correctNull((String) hshValues.get("perapp_address2"))%></b><br>
            &nbsp; <b><%=Helper.correctNull((String) hshValues.get("perapp_city"))%> 
            -<b><%=Helper.correctNull((String) hshValues.get("perapp_zip"))%></b></b><br>
            &nbsp; <b><%=Helper.correctNull((String) hshValues.get("perapp_state"))%></b><br>
          </td>
        </tr>
       <tr> 
          <td colspan="2"><b>&nbsp;Phone / Mobile No.</b></td>
          <td width="59%"><%=Helper.correctNull((String)hshValues.get("perapp_permphone"))%>&nbsp;-&nbsp;<%=Helper.correctNull((String)hshValues.get("perapp_mobile"))%></td>
        </tr>
        <tr> 
          <td colspan="2"><b>3. Constitution</b></td>
          <td width="59%"><%=Helper.correctNull((String)hshValues.get("constitution"))%></td>
        </tr>
        <tr> 
          <td colspan="2"><b>4. Means of the Applicant </b></td>
          <td width="59%"><%=Helper.checkDecimal(Helper.correctDouble((String) hshValues.get("CR_Total_MEANS")))%></td>
        </tr>
        <tr> 
          <td colspan="2"><b>5. Name of the Govt Sponsored scheme </b></td>
          <td width="59%"><%=Helper.correctNull((String)hshValues.get("govscheme"))%></td>
        </tr>
        <tr> 
          <td colspan="3"><b>6. Repayment Programme </b></td>
        </tr>
        <tr> 
          <td colspan="3"> 
            <table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="3">
              <tr> 
                <td width="20%" rowspan="2" align="center"><b>Facility</b></td>
                <td align="center" colspan="2"><b>Existing</b></td>
                <td width="13%" rowspan="2" align="center"><b>Recommended</b></td>
                <td width="11%" rowspan="2" align="center"><b>Interest %</b></td>
                 <td width="12%" rowspan="2" align="center"><b>Margin %</b></td>
                 <td width="12%" rowspan="2" align="center"><b>Security</b></td>
                <td width="9%" rowspan="2" align="center"><b>Subsidy, if any</b></td>
                <td width="4%" rowspan="2" align="center"><b>Amt of instalment</b></td>
                <td width="5%" rowspan="2" align="center"><b>Purpose</b></td>
                <td width="9%" rowspan="2" align="center"><b>Total repayment period</b></td>
              
                  
              </tr>
              <tr> 
                <td width="9%" align="center"><b>Limit</b></td>
                <td width="8%" align="center"><b>O/s</b></td>
              </tr>
             
             <%
            
										ArrayList arrCol=new ArrayList();
										ArrayList arrRow=(ArrayList)hshValues.get("arrrows");
										String strmaxrowspan=(String)hshValues.get("introwspan");
										if(arrRow!=null && arrRow.size()>0)
										{
 							    			for(int i=0;i<arrRow.size();i++)
											{
 							    				arrCol=(ArrayList)arrRow.get(i);
 							    				
 							    				int introwspan = Integer.parseInt(Helper
 							   						.correctInt((String) arrCol.get(11)));
 							    				
 							    			  			
 							    				
									%>
				<tr> 
                <td rowspan="<%=introwspan%>"><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</td>
                <td rowspan="<%=introwspan%>"><%=Helper.correctNull((String)arrCol.get(2)) %>&nbsp;</td>
                <td rowspan="<%=introwspan%>"><%=Helper.correctNull((String)arrCol.get(3)) %>&nbsp;</td>
                <td rowspan="<%=introwspan%>"><%=Helper.correctNull((String)arrCol.get(4)) %>&nbsp;</td>
                <td rowspan="<%=introwspan%>"> <%=Helper.correctNull((String)arrCol.get(5)) %>&nbsp;</td>
                
                <%
                  ArrayList arrSecCol= new ArrayList();
                  ArrayList arrSecRow=new ArrayList();
                  arrSecRow=(ArrayList) arrCol.get(10);
                  String strBorder="";
                  
                   if(arrSecRow != null && arrSecRow.size()>0)
                   {
                	   for(int j=0;j<arrSecRow.size();j++)
                	   {
                		   arrSecCol = new ArrayList();
                		   arrSecCol=(ArrayList)arrSecRow.get(j);
                		   if ((introwspan - 1) == j && j != 0) {
								strBorder = "\"border-top-width:0\";";
							} else if (j == 0) {
								strBorder = "\"border-bottom-width:0\";";
							} else {
								strBorder = "\"border-bottom-width:0;border-top-width:0\"";
							}
                 
                    if (j == 0) {%> 
               <td  style="<%=strBorder%>"><%=Helper.correctNull((String)arrSecCol.get(0)) %>&nbsp;</td>
                <td  style="<%=strBorder%>"><%=Helper.correctNull((String)arrSecCol.get(1)) %>&nbsp;</td>
                <%if(i==0){ %>  
                 <td rowspan="<%=(arrRow.size()+Integer.parseInt(strmaxrowspan))%>"><%=Helper.correctNull((String)hshValues.get("subamt")) %>&nbsp;</td>
                 <%} %>
                <td rowspan="<%=introwspan%>"><%=Helper.correctNull((String)arrCol.get(9)) %>&nbsp;</td>
                <td rowspan="<%=introwspan%>"><%=Helper.correctNull((String)arrCol.get(8)) %>&nbsp;</td>
                <td rowspan="<%=introwspan%>"><%=Helper.correctNull((String)arrCol.get(7)) %>&nbsp;</td>
                
             
                <% }else{%>
                 </tr><tr><td style="<%=strBorder%>"><%=Helper.correctNull((String)arrSecCol.get(0)) %>&nbsp;</td>
                <td  style="<%=strBorder%>"><%=Helper.correctNull((String)arrSecCol.get(1)) %>&nbsp;</td>
                
           		     <% }}
                	   }   else{
               %>
              	<td >&nbsp;</td>
                <td >&nbsp;</td> 
                <%if(i==0){ %>  
                 <td rowspan="<%=(arrRow.size()+Integer.parseInt(strmaxrowspan))%>"><%=Helper.correctNull((String)hshValues.get("subamt")) %>&nbsp;</td>
                 <%} %>
                 <td><%=Helper.correctNull((String)arrCol.get(9)) %>&nbsp;</td>
                <td ><%=Helper.correctNull((String)arrCol.get(8)) %>&nbsp;</td>
                <td ><%=Helper.correctNull((String)arrCol.get(7)) %>&nbsp;</td>
                
               <%} %>
            
                 <%
											}
										}
                %>
               </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td colspan="3"><b>7. Processing officer's comment</b></td>
        </tr>
        <tr> 
          <td colspan="3"><%=Helper.correctNull((String)hshValues.get("process_comments"))%></td>
        </tr>
        <tr> 
          <td colspan="3"><b>8. Remarks on technical report, if obtained</b></td>
        </tr>
        <tr> 
          <td colspan="3"><%=Helper.correctNull((String)hshValues.get("techreportcomments"))%>&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="2"><b>9. Date of Review/Renewal</b></td>
          <td width="59%"><%=Helper.correctNull((String)hshValues.get("REVIEW"))%></td>
        </tr>
        <tr> 
          <td colspan="3"><b>10. Security document to be obtained</b></td>
        </tr>
		 <%ArrayList docs1 = new ArrayList();

			ArrayList docs2 = new ArrayList();

			if (hshValues != null) {
				docs1 = (ArrayList) hshValues.get("arrDocs2");

				if (docs1 != null && docs1.size()>0) {
				%>
        <tr> 
          <td colspan="3"><b>Document Name (General)</b></td>
        </tr>
       <%

					for (int i = 0; i < docs1.size(); i++) {
						docs2 = (ArrayList) docs1.get(i);
						%>
        <tr> 
          <td width="7%">&nbsp;<%=i+1%></td>
          <td colspan="2">&nbsp;<%=Helper.correctNull((String) docs2.get(0))%></td>
        </tr>
        <%}}}%>
		<%ArrayList docs3 = new ArrayList();

			ArrayList docs4 = new ArrayList();

			if (hshValues != null) {
				docs3 = (ArrayList) hshValues.get("arrDocs4");

				if (docs3 != null && docs3.size()>0) {
				%>
        <tr> 
          <td colspan="3"><b>Document Name(Attached on Application side)</b></td>
        </tr>
        
<%
					for (int i = 0; i < docs3.size(); i++) {
						docs4 = (ArrayList) docs3.get(i);
						%>
        <tr> 
          <td width="7%">&nbsp;<%=i+1%></td>
          <td colspan="2">&nbsp;<%=Helper.correctNull((String) docs4.get(0))%></td>
        </tr>
       
        <%}}}%>
		 <tr>
          <td colspan="3"><b>Facility Based Documents</b></td>
        </tr>
		<%ArrayList docs5 = new ArrayList();

			ArrayList docs6 = new ArrayList();

			if (hshValues != null) {
				docs5 = (ArrayList) hshValues.get("arrDocs6");

				if (docs5 != null && docs5.size()>0) {
				%>
        <tr> 
          <td colspan="3"><b>Document Name</b></td>
        </tr>
        <%

					for (int i = 0; i < docs5.size(); i++) {
						docs6 = (ArrayList) docs5.get(i);
						%>
        <tr> 
          <td width="7%">&nbsp;<%=i+1%></td>
          <td colspan="2">&nbsp;<%=Helper.correctNull((String) docs6.get(0))%></td>
        </tr>
        <%}}}%>
		<%ArrayList docs7 = new ArrayList();

			ArrayList docs8 = new ArrayList();

			if (hshValues != null) {
				docs7 = (ArrayList) hshValues.get("arrDocs10");

				if (docs7 != null && docs7.size()>0) {
				%>
		<tr> 
          <td colspan="3"><b>Document Name(Attached on Application side)</b></td>
        </tr>
        <%

					for (int i = 0; i < docs7.size(); i++) {
						docs8 = (ArrayList) docs7.get(i);
						%>
        <tr> 
          <td width="7%">&nbsp;<%=i+1%></td>
          <td colspan="2">&nbsp;<%=Helper.correctNull((String) docs8.get(0))%></td>
        </tr>
        <%}}}%>
        <tr> 
          <td colspan="3"><b>11. Terms and conditions</b></td>
        </tr>
        <%ArrayList factory = new ArrayList();

			ArrayList fact = new ArrayList();

			if (hshValues != null) {
				factory = (ArrayList) hshValues.get("arrVec13");

				if (factory != null) {

					for (int i = 0; i < factory.size(); i++) {
						fact = (ArrayList) factory.get(i);
						%>
        <tr> 
          <td width="7%">&nbsp;<%=i+1%></td>
          <td colspan="2">&nbsp;<%=Helper.correctNull((String) fact.get(0))%></td>
        </tr>
        <%}}}%>
        <tr> 
          <td colspan="3"><b>12. Comments of the sanctioning authority</b></td>
        </tr>
        <tr> 
          <td colspan="3"><%=Helper.correctNull((String)hshValues.get("Sanction_Comments"))%></td>
        </tr>
        <tr> 
          <td colspan="3">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="3">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="3"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="3">
              <tr> 
                <td width="49%">&nbsp;</td>
                <td width="51%" align="right"><b>Signature</b></td>
              </tr>
              <tr> 
                <td width="49%">&nbsp;</td>
                <td width="51%" align="center"></td>
              </tr>
              <tr > 
                <td width="49%" align="left"><b>Date:</b></td>
                <td width="51%" align="right"><b>Name and designation of the Sanctioning Authority</b></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
