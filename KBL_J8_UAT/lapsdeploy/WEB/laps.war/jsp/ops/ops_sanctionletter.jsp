<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@page import="java.text.*"%>

<%//out.println(hshValues);
			

			

			String strborrowername = Helper.correctNull((String) request
					.getParameter("borrowername"));
			String strprocesseddate = Helper.correctNull((String) hshValues
					.get("processeddate"));
			ArrayList arrFac=new ArrayList();
        	ArrayList arrFac1=new ArrayList();
        	arrFac=(ArrayList)hshValues.get("arrFac1");
			double dblloanproposed=0.00,dblexistinglimit=0.00,dblproposed=0.00;
			
			java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			nf.setGroupingUsed(false);
%>


<html>
<head>
<title>KARNATAKA BANK LTD.</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>


<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0" font-family="arial" font-size="11px">
<table width="75%" border="0" cellspacing="0" cellpadding="2"
	align="center">
	<tr>
		<td valign="top">
		
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td align="right" colspan="4">&nbsp;</td>
        </tr>
        <tr> 
         <!--  <td align="center" colspan="4"><img
					src="<%//=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"
					width="50" height="35"></td>-->
        </tr>
        <tr> 
          <td align="center" colspan="4"><b>KARNATAKA BANK LTD. </b></td>
        </tr>
        
        <tr> 
          <td align="center" colspan="4"><B><%=Helper.correctNull((String) hshValues.get("org_name"))%>&nbsp;&nbsp;Branch</B></td>
        </tr>
        <tr>
				<td align="center" colspan="4"><%=Helper.correctNull((String)hshValues.get("org_add1"))%>,&nbsp; 
      <%=Helper.correctNull((String)hshValues.get("org_add2"))%>,&nbsp; <%=Helper.correctNull((String)hshValues.get("org_cityname"))%>,&nbsp; 
      <%=Helper.correctNull((String)hshValues.get("org_statename"))%>-&nbsp; <%=Helper.correctNull((String)hshValues.get("org_zip"))%>&nbsp; 
      . Tel No : <%=Helper.correctNull((String)hshValues.get("org_phone"))%>
      <hr/>
		</td>
			</tr>
        <tr> 
          <td align="center" colspan="4"><b><U>LETTER OF SANCTION</U></b></td>
        </tr>
        <tr> 
          <td align="center" colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td ALIGN="LEFT" colspan="3">REFERENCE :</td>
          <td ALIGN="RIGHT" width="36%">DATE:<%=strprocesseddate%></td>
        </tr>
        
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="3">&nbsp;</td>
          <td width="36%">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" colspan="4">TO :<br>
            <%=Helper.correctNull((String) hshValues
							.get("perapp_title"))%>&nbsp;.&nbsp;<%=Helper.correctNull((String) hshValues
							.get("perapp_fname"))%><br>
            <%=Helper.correctNull((String) hshValues
							.get("perapp_address1"))%>,<br>
            <%=Helper.correctNull((String) hshValues
							.get("perapp_address2"))%>,<br>
            <%=Helper.correctNull((String) hshValues.get("city_name"))%>,<br>
            <%=Helper.correctNull((String) hshValues.get("state_name"))%>,<br>
            <%=Helper.correctNull((String) hshValues
							.get("perapp_zip"))%></td>
        </tr>
        <tr> 
          <td colspan="3"> 
            <%//=strborrowername%>
          </td>
        </tr>
        <tr> 
          <td colspan="3">&nbsp;</td>
          <td width="36%">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;Dear Sir / Madam,</td>
        </tr>
        <tr> 
          <td colspan="4"><b>Subject : Credit facility under Priority Sector</b></td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="4"><p>With reference to your application dated <%=Helper.correctNull((String) hshValues.get("appcreatedate"))%> &nbsp;, we 
            are pleased to inform you that following credit facility/ies are sanctioned 
            to you. </p></td>
        </tr>
        <tr> 
          <td colspan="4"> 
            <table width="100%" border="1" cellspacing="0" cellpadding="2">
              <tr> 
                <td>Facility</td>
                <td>Loan Applied(<%=ApplicationParams.getCurrency()%>)</td>
                <td>Existing Limit(<%=ApplicationParams.getCurrency()%>)</td>
                <td>Proposed Limit(<%=ApplicationParams.getCurrency()%>)</td>
                <td>Subsidy(<%=ApplicationParams.getCurrency()%>)</td>
                <td>Margin(%)</td>
                <td>Repayment Schedule</td>
              </tr>
              <%
        	
        	int fsize=0;
        	fsize=arrFac.size();
        	//out.print(fsize);
        	if(arrFac!=null || arrFac.size()>0 )
        	{
        		for(int i=0;i<fsize;i++)
        		{
        			arrFac1=(ArrayList)arrFac.get(i);
        			dblloanproposed=dblloanproposed+Double.parseDouble(Helper.correctDouble((String)arrFac1.get(2)));
        			//out.print(dblloanproposed);
        			dblexistinglimit=dblexistinglimit+Double.parseDouble(Helper.correctDouble((String)arrFac1.get(1)));
        			//out.print(dblexistinglimit);
        			dblproposed=dblproposed+Double.parseDouble(Helper.correctDouble((String)arrFac1.get(6)));
                %>
              
              
              <tr> 
                <td>&nbsp;<%=arrFac1.get(0) %></td>
                <td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrFac1.get(2)))) %></td>
                <td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrFac1.get(1)))) %></td>
                <td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrFac1.get(6)))) %></td>
                <td>&nbsp;</td>
               	<td>&nbsp;<%=arrFac1.get(4) %></td>
                <td>&nbsp;<%=arrFac1.get(5) %></td>
              </tr>
              
              <%
             
              }
        		
              }%>
              <tr> 
                <td><b>Total</b></td>
                <td align="right"><b>&nbsp;<%=nf.format(dblloanproposed) %></b></td>
                <td align="right"><b>&nbsp;<%=nf.format(dblexistinglimit) %></b></td>
                <td align="right"><b>&nbsp;<%=nf.format(dblproposed )%></b></td>
                <td align="right"><b>&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("subsidy"))))%></b></td>
               	<td></td>
                <td></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="4"><b>The Facility/ies is/are sanctioned on the following 
            terms and conditions.</b></td>
        </tr>
        <%
        	ArrayList arrRow=new ArrayList();
        	ArrayList arrCol=new ArrayList();
        	arrRow=(ArrayList)hshValues.get("arrRow");
        	int size=0;
        	size=arrRow.size();
        	if(arrRow!=null || arrRow.size()>0 )
        	{
        		for(int i=0;i<size;i++)
        		{
        			arrCol=(ArrayList)arrRow.get(i);
        		    		
        	
        
        
        %>
        <tr>
			 
          <td colspan="4"><%=i+1%>.<%=arrCol.get(0) %></td>
        </tr>
        <%
        }
        }%>
        <tr> 
          <td colspan="4"><p>We 
            now request you to convey your acceptance (or) otherwise of the above 
            terms and conditions and call on us any working day to enable us to 
            disburse the loan after proper documentation. </p></td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td width="8%">&nbsp;</td>
          <td width="8%">&nbsp;</td>
          <td width="48%">&nbsp;</td>
          <td width="36%">For Karnataka Bank Ltd.</td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>Chief / Branch Manager</td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="4">Accepted the above terms and conditions</td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="4">Signature of the Applicant/s and Guarantors</td>
        </tr>
        <tr> 
          <td colspan="4">Date:</td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr>
          <td colspan="4">&nbsp;</td>
        </tr>
      </table>
		</td>
	</tr>
</table>
</body>
</html>
