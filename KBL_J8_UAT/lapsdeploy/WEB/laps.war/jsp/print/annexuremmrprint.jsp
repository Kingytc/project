<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" type="java.util.HashMap" scope="request" />

<%
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=null;
%>
<html>
<head>
<title>Monitoring Report Print</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css"
	type="text/css">

</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="40"> 
            <div align="center"><img
					src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg" ></div>
          </td>
        </tr>
        <tr> 
          <td> 
            <div align="center"><b>KARNATAKA BANK LTD.</b></div>
          </td>
        </tr>
        <tr> 
          <td>
            <div align="center">Branch : <%=Helper.correctNull((String)hshValues.get("org_name"))%></div>
          </td>
        </tr>
        <tr> 
          <td align="center"><b>Annexure for Sub limits and Ad - hoc Limits</b></td>
        </tr>
        <tr> 
          <td align="right">Amount in Lacs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
        <tr> 
          <td> <br />
            <div id="top"> 
			
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr> 
                  <td width="22%" align="center"><strong> Nature of Facility</strong></td>
                  <td width="12%" align="center"><strong> Amount of Limit</strong></td>
                  <td width="11%" align="center"><strong> <font
											  >D.P.</font></strong></td>
                  <td width="8%" align="center"><strong> <font
											  >Outstanding</font></strong></td>
                  <td width="10%" align="center"><strong> <font   >Excess 
                    / Overdue</font>&nbsp; </strong></td>
                  <td width="12%" align="center"><strong> Remarks</strong></td>
                </tr>
               
                <%
					
					int mainfacility = 0,adhocfacility=0,subFacility=0,mainfacilityid=0;
					arrRow = (ArrayList) hshValues.get("arrRow");
				
					if(arrRow!=null)
					{
						for(int i=0;i<arrRow.size();i++)
						{
							arrCol = (ArrayList) arrRow.get(i);
							
							if(arrCol!=null)
							{
			if(mainfacility==0 && Helper.correctNull((String)arrCol.get(5)).equals("r") )
		   	{%>
                <tr bgcolor="#FFFFFF"> 
                  <td colspan="6"><b>Main Limit 
                    Facilities :</b></td>
                </tr>
                <%mainfacility++;}%>
				<%if(adhocfacility==0 && Helper.correctNull((String)arrCol.get(5)).equals("a") )
		   	{%>
          <tr bgcolor="#FFFFFF"> 
            <td colspan="6"><b>Adhoc facilities :</b></td>
          </tr>
		  <%adhocfacility++;}%>
				
				 <%if(Integer.parseInt(Helper.correctInt((String)arrCol.get(4)))==(Integer.parseInt(Helper.correctInt((String)arrCol.get(12)))))
		  		{
					subFacility = 0;
					%>
					
                <tr> 
                  <td width="22%" align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(0))%> <%=Helper.correctNull((String)arrCol.get(1))%>
					<%if(Helper.correctNull((String)arrCol.get(5)).equals("a"))
		   	{%><br>(upto <%=Helper.correctNull((String)arrCol.get(13))%>)
              <%}%> 
				  </td>
                  <td width="12%" align="right">&nbsp;<%=Helper.converToLakhs((String)arrCol.get(6))%>&nbsp;</td>
                  <td width="11%" align="right">&nbsp;<%=Helper.converToLakhs((String)arrCol.get(9))%>&nbsp;</td>
                  <td width="8%" align="right">&nbsp;<%=Helper.converToLakhs((String)arrCol.get(7))%>&nbsp;</td>
                  <td width="10%" align="right">&nbsp;<%=Helper.converToLakhs((String)arrCol.get(8))%>&nbsp;</td>
                  <td width="12%" align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(11))%>&nbsp;</td>
                </tr>
				<%}else{%>
                	<% if(subFacility==0){%>
         	<tr bgcolor="#FFFFFF">
                <td  align="center">&nbsp;<b>&gt;&gt;Sub-Limit</b></td>
				<td colspan="5">&nbsp;</td>
                </tr>
         
           <%subFacility++;} %>	
				
				
				 <tr> 
                  <td width="22%" align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(0))%> <%=Helper.correctNull((String)arrCol.get(1))%></td>
                  <td width="12%" align="right">&nbsp;<%=Helper.converToLakhs((String)arrCol.get(6))%>&nbsp;</td>
                  <td width="11%" align="right">&nbsp;<%=Helper.converToLakhs((String)arrCol.get(9))%>&nbsp;</td>
                  <td width="8%" align="right">&nbsp;<%=Helper.converToLakhs((String)arrCol.get(7))%>&nbsp;</td>
                  <td width="10%" align="right">&nbsp;<%=Helper.converToLakhs((String)arrCol.get(8))%>&nbsp;</td>
                  <td width="12%" align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(11))%></td>
                </tr>
				<%}}}}%>
				<tr>
				<td align="right"><b>Total</b>&nbsp;</td>
				<td align="right"><%=Helper.converToLakhs((String)hshValues.get("totalSanction"))%>&nbsp;</td>
				<td align="right">&nbsp;</td>
				<td align="right"><%=Helper.converToLakhs((String)hshValues.get("totalOS"))%>&nbsp;</td>
				<td align="right"><%=Helper.converToLakhs((String)hshValues.get("totalOverDue"))%>&nbsp;</td>
				<td align="right">&nbsp;</td>
              </table>
				</div>
				</td>
        </tr>
      </table>
        </td>
        </tr>
        </table>
 </body>
 </html>       
        