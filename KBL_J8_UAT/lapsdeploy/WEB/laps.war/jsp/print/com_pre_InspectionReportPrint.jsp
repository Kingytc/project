<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%
	String strsaral=Helper.correctNull((String)request.getParameter("hidsaral"));	
	String strappname=Helper.correctNull((String)request.getParameter("appname"));
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	ArrayList arr6=new ArrayList();
	ArrayList arr7=new ArrayList();
	int arrSize4=0;
	int intno=1;
	
	
	String strProposalvalue = Helper.correctNull((String) hshValues
			.get("proposalvaluesin"));
	if (strProposalvalue.equalsIgnoreCase("C"))
		strProposalvalue = "Crores";
	else
		strProposalvalue = "Lacs";
%>
<html>
<head>
<title>Pre Sanction Inspection report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>
var insbanknameboard="<%=Helper.correctNull((String)hshValues.get("mmr_insbanknameboard"))%>";
var insborrowernamebord="<%=Helper.correctNull((String)hshValues.get("mmr_insborrowernamebord"))%>";
var insmaintanance="<%=Helper.correctNull((String)hshValues.get("mmr_insmaintanance"))%>";
</script>
</head>
<body text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0" font-size="11px">
<form name="frminspection" method="post">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left">
			<tr> 
				<td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg" /></td>
  			</tr>
  			<tr> 
    			<td align="center"><b>Branch - <%=Helper.correctNull((String)hshValues.get("orgname"))%></b></td>
  			</tr>
  			<tr> 
    			<td align="center"><%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp; 
      			<%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp; <%=Helper.correctNull((String)hshValues.get("orgcity"))%>,&nbsp; 
      			<%=Helper.correctNull((String)hshValues.get("orgstate"))%>-&nbsp; <%=Helper.correctNull((String)hshValues.get("orgzip"))%>&nbsp; 
      			<hr/>
    			</td>
  			</tr>
          	<tr> 
            	<td align="center"><b><br>
              	PRE-SANCTION INSPECTION REPORT</b></td>
          </tr>
          <%if(strsaral.equalsIgnoreCase("saral"))
		{%>
  <tr> 
    <td valign="bottom" align="center" colspan="3"><laps:inward/></td>
  </tr>
  <%}else
	{%>
  <tr> 
    <td valign="bottom" align="center" colspan="3"><div id="top"> <laps:application/></div></td>
  </tr>
  <%}%>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="2" cellpadding="3">
    <tr> 
      <td width="3%">&nbsp;</td>
      <td width="43%">&nbsp;</td>
      <td width="4%">&nbsp;</td>
      <td width="50%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="3%" valign="top"><b><%=Integer.toString(intno++)%></b>.&nbsp;</td>
      <td width="43%" valign="top"><b>Date of Visit</b></td>
      <td width="4%" valign="top"><b>:</b></td>
      <td width="50%" valign="top"><%=Helper.correctNull((String)hshValues.get("visitdate")) %></td>
    </tr>
    <tr> 
      <td width="3%" valign="top"><b><%=Integer.toString(intno++)%></b>.&nbsp;</td>
      <td width="43%" valign="top"><b>Name of the Applicant Borrower</b></td>
      <td width="4%" valign="top"><b>:</b></td>
      <%if(strsaral.equalsIgnoreCase("saral")){ %>
      <td width="50%" valign="top"><%=strappname%></td>
      <%}else{ %>
      <td width="50%"><%=Helper.correctNull((String)hshValues.get("strCompanyName")) %></td>
      <%} %>
    </tr>
    <tr> 
      <td width="3%" valign="top"><b><%=Integer.toString(intno++)%></b>.&nbsp;</td>
      <td width="43%" valign="top"><b>Contact No. of the applicant or key person</b></td>
      <td width="4%" valign="top"><b>:</b></td>
      <td width="50%" valign="top"><%=Helper.correctNull((String)hshValues.get("contact")) %></td>
    </tr>
    <%if(!(strsaral.equalsIgnoreCase("saral"))){ %>
    <tr> 
      <td width="3%" valign="top"><b><%=Integer.toString(intno++)%></b>.&nbsp;</td>
      <td width="43%" valign="top"><b>Residential &amp; / or Business Address</b></td>
      <td width="4%" valign="top"><b>:</b></td>
      <td width="50%" valign="top"><%=Helper.correctNull((String)hshValues.get("strPersonalAddress")) %></td>
    </tr>
    <%} %>
    <tr> 
      <td width="3%" valign="top"><b><%=Integer.toString(intno++)%></b>.&nbsp;</td>
      <td width="43%" valign="top"><b>Distance from branch in KMS</b></td>
      <td width="4%" valign="top"><b>:</b></td>
      <td width="50%" valign="top"><%=Helper.correctNull((String)hshValues.get("distance1")) %></td>
    </tr>
    <%if(!(strsaral.equalsIgnoreCase("saral"))){ %>
    <tr> 
      <td width="3%" valign="top"><b><%=Integer.toString(intno++)%></b>.&nbsp;</td>
      <td width="43%" valign="top"><b>Facility / ies availed from our Bank</b></td>
      <td width="4%" valign="top">&nbsp;</td>
      <td width="50%" valign="top">&nbsp;</td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td colspan="3" valign="top"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr> 
              <td width="7%" height="19"><b>S.No.</b></td>
              <td width="26%" height="19"><b>Nature of Facility</b></td>
              <td width="17%" height="19"><b>Purpose of loan</b></td>
              <td width="18%" height="19"><b>Limit (Rs.)</b></td>
            </tr>
            <%
										arrCol=new ArrayList();
         
										arrRow=(ArrayList)hshValues.get("facility");
										if(arrRow!=null && arrRow.size()>0)
										{
 							    			for(int i=0;i<arrRow.size();i++)
											{
 							    				arrCol=(ArrayList)arrRow.get(i);
									%>
            <tr> 
              <td width="7%">&nbsp;<%=i+1%></td>
              <td width="26%">&nbsp;<%=Helper.correctNull((String)arrCol.get(0))%></td>
              <td width="17%">&nbsp;<%=Helper.correctNull((String)arrCol.get(1))%></td>
              <td width="18%" align="right">&nbsp;<%=Helper.checkDecimal(Helper.correctDouble((String)arrCol.get(2)))%></td>
            </tr>
            <%
									}
									}
									%>
          </table>
        </div>
      </td>
    </tr>
    <%} %>
    <tr> 
      <td width="3%" valign="top"><b><%=Integer.toString(intno++)%></b>.&nbsp;</td>
      <td width="18%" valign="top"><b>Whether new connection or account to be 
        taken-over</b></td>
      <td width="4%" valign="top">:</td>
      <td width="21%" valign="top">&nbsp;<%=Helper.correctNull((String)hshValues.get("taken")) %></td>
    </tr>
    <%if(!(strsaral.equalsIgnoreCase("saral"))){ %>
    <tr> 
      <td width="3%" valign="top"><b><%=Integer.toString(intno++)%></b>.&nbsp;</td>
      <td width="18%" colspan="3" valign="top"><b>Details and present status of 
        credit facilities, if any, availed from other banks / financial institutions</b></td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td colspan="3" valign="top"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr> 
              <td height="5" align="center"><b>S.No.</b></td>
              <td height="32" align="center"><b>Bank Name</b></td>
              <td height="37" align="center" colspan="2"><b>Funded</b></td>
              <td height="37" align="center" colspan="2"><b>Non Funded</b></td>
            </tr>
            <tr> 
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td align="center" ><b>Existing</b></td>
              <td align="center" ><b>Proposed</b></td>
              <td align="center" ><b>Existing</b></td>
              <td align="center" ><b>Proposed</b></td>
            </tr>
            <%
										arrCol=new ArrayList();
           								arrRow=new ArrayList();
										arrRow=(ArrayList)hshValues.get("arrRowArrange");
										
										if(arrRow!=null && arrRow.size()>0)
										{
 							    			for(int i=0;i<arrRow.size();i++)
											{
 							    				arrCol=(ArrayList)arrRow.get(i);
									%>
            <tr> 
              <td>&nbsp;<%=i+1%></td>
              <td>&nbsp;<%=Helper.correctNull((String)arrCol.get(0)) %></td>
              <td align="right">&nbsp;<%=Helper.checkDecimal(Helper.correctDouble((String)arrCol.get(1))) %></td>
              <td align="right">&nbsp;<%=Helper.checkDecimal(Helper.correctDouble((String)arrCol.get(2))) %></td>
              <td align="right">&nbsp;<%=Helper.checkDecimal(Helper.correctDouble((String)arrCol.get(3))) %></td>
              <td align="right">&nbsp;<%=Helper.checkDecimal(Helper.correctDouble((String)arrCol.get(4))) %></td>
            </tr>
            <%
									}
									}
									%>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td width="3%" valign="top"><b><%=Integer.toString(intno++)%>.&nbsp;</b></td>
      <td width="18%" valign="top"><b>Business premises</b></td>
      <td width="4%" valign="top"><b>:</b></td>
      <td width="21%" valign="top">&nbsp; 
        <%if("1".equals(Helper.correctNull((String)hshValues.get("premises")))){
     out.println("Owned");
      }
     else if("2".equals(Helper.correctNull((String)hshValues.get("premises")))){
    	 out.println("Leased");
     }
    	 else if("3".equals(Helper.correctNull((String)hshValues.get("premises")))){
        	 out.println("Rented");
    	 }
    	 else
    		 out.println("");
    	  %>
      </td>
    </tr>
    <%} %>
    <tr> 
      <td width="3%" valign="top"><b><%=Integer.toString(intno++)%>.&nbsp;</b></td>
      <td width="43%" valign="top"><b>Nearby Landmarks for Identification</b></td>
      <td width="4%" valign="top"><b></b></td>
      <td width="50%" valign="top">&nbsp;</td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td colspan="3" valign="top"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr> 
              <td width="15%"><b>East </b></td>
              <td>&nbsp;<%=Helper.formatTextAreaData((String)hshValues.get("north")) %></td>
              <td width="15%"><b>West </b></td>
              <td>&nbsp;<%=Helper.formatTextAreaData((String)hshValues.get("east")) %></td>
            </tr>
            <tr> 
              <td width="15%"><b>North </b></td>
              <td>&nbsp;<%=Helper.formatTextAreaData((String)hshValues.get("west")) %></td>
              <td width="15%"><b>South </b></td>
              <td>&nbsp;<%=Helper.formatTextAreaData((String)hshValues.get("south")) %></td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td width="3%" valign="top"><b><%=Integer.toString(intno++)%>.&nbsp;</b></td>
      <td width="18%" valign="top"><b>Comments on suitability of business premises</b></td>
      <td width="4%" valign="top"><b>:</b></td>
      <td width="21%" valign="top">&nbsp;<%=Helper.formatTextAreaData((String)hshValues.get("suitability")) %></td>
    </tr>
    <%if(!(strsaral.equalsIgnoreCase("saral"))){ %>
    <tr> 
      <td width="3%" valign="top"><b><%=Integer.toString(intno++)%>.&nbsp;</b></td>
      <td width="43%" colspan="3"><b>Security offered</b></td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td colspan="3"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr> 
              <td height="32" align="center"><b>Type of Security</b></td>
              <td height="37" align="center"><b>Details of security </b></td>
              <td height="37" align="center"><b>Value</b></td>
            </tr>
            <%
										arrCol=new ArrayList();
           								arrRow=new ArrayList();
										arrRow=(ArrayList)hshValues.get("primSec");
										
										if(arrRow!=null && arrRow.size()>0)
										{
 							    			for(int i=0;i<arrRow.size();i++)
											{
 							    				arrCol=(ArrayList)arrRow.get(i);
									%>
            <tr> 
              <td><b>Primary</b></td>
              <td >&nbsp;<%=Helper.correctNull((String)arrCol.get(0)) %></td>
              <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)))) %></td>
            </tr>
            <%
									}
									}
									%>
            <%
										arrCol=new ArrayList();
           								arrRow=new ArrayList();
										arrRow=(ArrayList)hshValues.get("arrRowCollSec");
										
										if(arrRow!=null && arrRow.size()>0)
										{
 							    			for(int i=0;i<arrRow.size();i++)
											{
 							    				arrCol=(ArrayList)arrRow.get(i);
									%>
            <tr> 
              <td><b>Collateral</b></td>
              <td >&nbsp;<%=Helper.correctNull((String)arrCol.get(0)) %></td>
              <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)))) %></td>
            </tr>
            <%
									}
									}
									%>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td width="3%" valign="top"><b><%=Integer.toString(intno++)%></b>.&nbsp;</td>
      <td width="43%" colspan="3" valign="top"><b>Personal guarantee offered</b></td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td width="43%" colspan="3" valign="top"> 
        <table width="50%" border="1" cellspacing="0" cellpadding="3">
          <tr align="center"> 
            <td align="left" colspan="2"><b>PERSONAL GUARANTEE</b></td>
          </tr>
          <tr align="center" class="tblhead "> 
            <td width="50%" align="center"><b>Name</b></td>
            <td width="50%" align="center"><b>Means (Rs. In <%=strProposalvalue%>)</b></td>
          </tr>
          <%
                    arr6=new ArrayList();
                    arr7=new ArrayList();
                    arrSize4=0;
                    arr6=(ArrayList)hshValues.get("arrGuarantors");
               
                    if(arr6!=null)
                    {
                        arrSize4=  arr6.size();
                    }
				    if(arrSize4!=0)	
				    {
	                  for(int i=0;i<arrSize4;i++)
	                  {
	                	  arr7=(ArrayList)arr6.get(i); 
                 
                    		
                    %>
          <tr> 
            <td width="50%" align="left"><%=arr7.get(0)%>&nbsp;&nbsp;<%=arr7.get(1)%></td>
            <td width="50%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arr7.get(4))))%></td>
          </tr>
          <%
	                  }
                    }
				    else
				    {
                    %>
          <tr align="center"> 
            <td width="50%" align="center">&nbsp;</td>
            <td width="50%" align="center">&nbsp;</td>
          </tr>
          <%}
              		%>
          <%if(Helper.correctNull((String)hshValues.get("sel_guaranteoffered")).equalsIgnoreCase("Y")) {
              	if(Helper.correctNull((String)hshValues.get("sel_applicantguarantee")).equalsIgnoreCase("Y")){%>
          <tr align="center"> 
            <td align="left" colspan="2"><b>CORPORATE GUARANTEE</b></td>
          </tr>
          <tr align="center"> 
            <td width="50%" align="left"><%=Helper.correctNull((String)hshValues.get("comapp_companyname"))%>&nbsp;</td>
            <td width="50%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("TangibleNetworth"))))%>&nbsp;</td>
          </tr>
          <% }
              	else{%>
          <tr align="center"> 
            <td align="left" colspan="2"><b>CORPORATE GUARANTEE</b></td>
          </tr>
          <%
                    arr6=new ArrayList();
                    arr7=new ArrayList();
                    arrSize4=0;
                    arr6=(ArrayList)hshValues.get("arrCorpguarantee");
               
                   
				    if( arr6!=null && arr6.size()>0)	
				    {
	                  for(int i=0;i< arr6.size();i++)
	                  {
	                	  arr7=(ArrayList)arr6.get(i); 
                 
                    		
                    %>
          <tr align="center"> 
            <td width="50%" align="left"><%=Helper.correctNull((String)arr7.get(0))%>&nbsp;</td>
            <td width="50%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arr7.get(1))))%>&nbsp;</td>
          </tr>
          <%}}} }%>
        </table>
      </td>
    </tr>
    <%} %>
    <tr> 
      <td width="3%" valign="top"><b><%=Integer.toString(intno++)%>.&nbsp;</b></td>
      <td colspan="3" valign="top"><b>Observations / Comments of Inspection officer:</b></td>
    </tr>
    <tr> 
      <td width="3%"><b>&nbsp;</b></td>
      <td width="43%" valign="top"><b>Primary Security</b></td>
      <td width="4%" valign="top"><b>:</b></td>
      <td width="50%" valign="top"><p><%=Helper.formatTextAreaData((String)hshValues.get("primary_security")) %></p></td>
    </tr>
    <tr> 
      <td width="3%"><b>&nbsp;</b></td>
      <td width="43%" valign="top"><b>Collateral Security</b></td>
      <td width="4%" valign="top"><b>:</b></td>
      <td width="50%" valign="top"><p><%=Helper.formatTextAreaData((String)hshValues.get("coll_security")) %></p></td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td width="43%" valign="top"><b>Present status of business activity of applicant 
        borrower</b></td>
      <td width="4%" valign="top"><b>:</b></td>
      <td width="50%" valign="top"><p><%=Helper.formatTextAreaData((String)hshValues.get("present_status")) %></p></td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td width="43%" valign="top"><b>Availability of infrastructure like Road 
        / Water / Electricity etc.</b></td>
      <td width="4%" valign="top"><b>:</b></td>
      <td width="50%" valign="top"><p><%=Helper.formatTextAreaData((String)hshValues.get("availability"))%>&nbsp;</p></td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td width="43%" valign="top"><b>Whether necessary licenses, clearances etc. 
        from statutory Authorities obtained:</b></td>
      <td width="4%" valign="top"><b>:</b></td>
      <td width="50%" valign="top"><p><%=Helper.formatTextAreaData((String)hshValues.get("licenses"))%></p></td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td width="43%" valign="top"><b>Comments of operations in the account</b></td>
      <td width="4%" valign="top"><b>:</b></td>
      <td width="50%" valign="top"><p><%=Helper.formatTextAreaData((String)hshValues.get("operation"))%></p></td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td width="43%" valign="top"><b>Whether borrower's name board is displayed</b></td>
      <td width="4%" valign="top"><b>:</b></td>
      <td width="50%" valign="top"><p><%=Helper.correctNull((String)hshValues.get("borrower_name"))%></p></td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td width="43%" valign="top"><b>Proper maintenance of books of accounts</b></td>
      <td width="4%" valign="top"><b>:</b></td>
      <td width="50%" valign="top"><p><%=Helper.correctNull((String)hshValues.get("proper_main"))%></p></td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td width="43%" valign="top"><b>Comments on credit limits applied for</b></td>
      <td width="4%" valign="top"><b>:</b></td>
      <td width="50%" valign="top"><p><%=Helper.formatTextAreaData((String)hshValues.get("credit_limit")) %></p></td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td width="43%" valign="top"><b>Confirmation on Due Diligence / references 
        in any</b></td>
      <td width="4%" valign="top"><b>:</b></td>
      <td width="50%" valign="top"><p><%=Helper.formatTextAreaData((String)hshValues.get("confirmation")) %></p></td>
    </tr>
    <tr> 
      <td width="3%" valign="top"><%=Integer.toString(intno++)%>.&nbsp;</td>
      <td width="43%" valign="top"><b>Any other features observed during inspection</b></td>
      <td width="4%" valign="top"><b>:</b></td>
      <td width="50%" valign="top"><%=Helper.correctNull((String)hshValues.get("other_features")) %></td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td colspan="3"><br>
        I confirm that I have conducted the inspection and my findings on the 
        applicant borrower are as above.</td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td colspan="3"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="1">
          <tr> 
            <td width="30%" nowrap align="left" valign="bottom"><b>Date :<%=Helper.correctNull((String)hshValues.get("dateofreport")) %></b></td>
             <td width="40%">&nbsp;</td>
            <td width="30%" align="center"><br/><br/><br/><b>
            (<%=Helper.correctNull((String)hshValues.get("visitname1")) %>)<br/>
            <%=Helper.correctNull((String)hshValues.get("visitdes1")) %></b></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
</body>
</html>

