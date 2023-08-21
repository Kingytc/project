<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
//out.println(hshValues);
//String Valuesin=Helper.correctNull((String)hshValues.get("valuesin")); 
String Valuesin="L";
String strValuesin="";

if(Valuesin.equals("L"))
{
	strValuesin="(Rs. in Lacs)";
}
else if(Valuesin.equals("C"))
{
	strValuesin="(Rs. in Crores)";
}
			%>
<html>
<head>
<title>Modification In Sanction Terms Print</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<form name="frmmstprint" method=post>
  <table width="80%" border="0" cellspacing="0" cellpadding="3" bgcolor="#FFFFFF" align="center" >
    <tr> 
      <td colspan="4" align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg"></td>
    </tr>
    <tr> 
      <td colspan="4" align="center"><b>Branch - <%=Helper.correctNull((String)hshValues.get("orgname"))%></b> 
      <hr/>
      </td>
    </tr>
    <%-- 
    <tr> 
      <td colspan="6" align="center"><%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp; 
        <%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp; <%=Helper.correctNull((String)hshValues.get("orgcity"))%>,&nbsp; 
        <%=Helper.correctNull((String)hshValues.get("orgstate"))%>-&nbsp; <%=Helper.correctNull((String)hshValues.get("orgzip"))%>&nbsp; 
        Tel No : <%=Helper.correctNull((String)hshValues.get("orgphone"))%> 
        <hr/>
      </td>
    </tr>
    --%>
    <tr>
    	<td colspan="4" align="center"><B>PROPOSAL FOR: MODIFICATION IN SANCTION TERMS (INCLUDING INTEREST)</B></td>
    </tr>
    <tr> 
      <td align="left" colspan="2"><b>Ref .No </b>&nbsp;&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("refno"))%></td>
      <td >&nbsp;</td>
      <td align="right" ><b>Date </b>&nbsp;&nbsp;&nbsp; <%=Helper.correctNull((String)hshValues.get("remarkdate"))%></td>
    </tr>
    <tr> 
      <td >1.</td>
      <td ><b>Name of the Account</b></td>
      <td ><b>:</b></td>
      <td ><%=Helper.correctNull((String)hshValues.get("comapp_companyname"))%></td>
    </tr>
    <tr> 
      <td>2.</td>
      <td><b>Branch</b></td>
      <td><b>:</b></td>
      <td><%=Helper.correctNull((String)hshValues.get("org_name"))%></td>
    </tr>
    <tr> 
      <td>3.</td>
      <td><b>Line of activity</b></td>
      <td><b>:</b></td>
      <td><%=Helper.correctNull((String)hshValues.get("comapp_businessnature"))%></td>
    </tr>
    <tr> 
      <td>4.</td>
      <td><b>Credit Rating</b></td>
      <td><b>:</b></td>
      <td><%=Helper.correctNull((String)hshValues.get("Creditrating"))%> 
      </td>
    </tr>
    <tr valign="top"> 
      <td>5.</td>
      <td><b>Asset Classification</b></td>
      <td><b>:</b></td>
      <td><%=Helper.correctNull((String)hshValues.get("asset"))%> 
      </td>
    </tr>
    <tr valign="top"> 
      <td>6.</td>
      <td><b>Nature of facilities</b></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    
	 <tr> 
      <td colspan="4" align="right"><b><%=strValuesin%></b></td>
    </tr>
    <tr> 
      <td colspan="4"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr> 
            <td> 
              <div id="top"> 
                <table width="100%" border="0" cellspacing="0" cellpadding="3">
                  <tr> 
                    <td align="center" class="tabactivenew" rowspan="2"><b>Nature of Limit</b></td>
                    <td align="center" class="tabactivenew" rowspan="2"><b>Amount</b></td>
                    <td align="center" class="tabactivenew" rowspan="2"><b>Outstanding as 
                      on <%=Helper.correctNull((String)hshValues.get("outstandingason")) %></b></td>
                    <td align="center" class="tabactivenew" rowspan="2"><b>Margin</b></td>
                    <td align="center" class="tabactivenew" colspan="3" ><b>Interest/Commission</b><br>
                      (With reference to BPLR)</td>
                    <td align="center" class="tabactivenew" ><b>Concession Involved</b></td>
                    <td align="center" class="tabactivenew" ><b>Irregularities 
                      / overdues, if any</b></td>
                  </tr>
                  <tr> 
                    <td align="center" class="tabactivenew"><b>Applicable</b></td>
                    <td align="center" class="tabactivenew"><b>Existing</b></td>
                    <td align="center" class="tabactivenew"><b>Proposed</b></td>
                    <td align="center" class="tabactivenew">&nbsp;</td>
                    <td align="center" class="tabactivenew">&nbsp;</td>
                  </tr>
                  <%
                ArrayList arrRow = new ArrayList();
    			ArrayList arrCol = new ArrayList();
    			arrRow = (ArrayList) hshValues.get("arrFacility");
                double dblamtsanc = 0.0;
			
			if (arrRow != null && arrRow.size() > 0) {
					int count = 0;
					for (int i = 0; i < arrRow.size(); i++) {
						arrCol = (ArrayList) arrRow.get(i);
						if (Helper.correctNull((String) arrCol.get(14)).equalsIgnoreCase("0")) {
						dblamtsanc = dblamtsanc + Double.parseDouble(Helper.correctDouble((String) arrCol.get(2)));
							count = 0;

							%>
                  <tr > 
                    <td align="left" valign="top">&nbsp; <%=Helper.correctNull((String) arrCol.get(17))%></td>
                    <td align="right" valign="top">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(2))))%></td>
                    <td align="right" valign="top">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(3))))%></td>
                    <td align="right" valign="top">&nbsp;<%=Helper.correctNull((String) arrCol.get(4))%></td>
                    <td valign="top">&nbsp;<%=Helper.correctNull((String) arrCol.get(7))%></td>
                    <td valign="top"><%=Helper.correctNull((String) arrCol.get(8))%></td>
                    <td valign="top"><%=Helper.correctNull((String) arrCol.get(9))%></td>
                    <td valign="top">&nbsp;<%=Helper.correctNull((String) arrCol.get(12))%></td>
                    <td valign="top"><%=Helper.correctNull((String) arrCol.get(13))%></td>
                  </tr>
                  <%} else if (!Helper.correctNull((String) arrCol.get(14)).equalsIgnoreCase("0")) 
                            {
							%>
                  <tr> 
                    <%if (count == 0) {

							%>
                    <td colspan="9" ><b>&gt;&gt;Sub Limit</b></td>
                  </tr>
                  <tr> 
                    <%}

							%>
                    <td align="left" valign="top"><%=Helper.correctNull((String) arrCol.get(17))%></td>
                    <td align="right" valign="top"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(2))))%></td>
                    <td align="right" valign="top"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(3))))%></td>
                    <td align="right" valign="top"><%=Helper.correctNull((String) arrCol.get(4))%></td>
                    <td valign="top"><%=Helper.correctNull((String) arrCol.get(7))%></td>
                    <td valign="top"><%=Helper.correctNull((String) arrCol.get(8))%></td>
                    <td valign="top"><%=Helper.correctNull((String) arrCol.get(9))%></td>
                    <td valign="top"><%=Helper.correctNull((String) arrCol.get(12))%></td>
                    <td valign="top"><%=Helper.correctNull((String) arrCol.get(13))%></td>
                  </tr>
                  <%count++;
						}
					}

				%>
                  <tr bgcolor="#FFFFFF"> 
                    <td >><b>Total</b></td>
                    <td align="right"><%=Helper.formatDoubleValue(dblamtsanc)%></td>
                    <td align="right" colspan="7">&nbsp;</td>
                  </tr>
                  <%} else {

			%>
                  <tr> 
                    <td align="center" colspan="10">No Data Found</td>
                  </tr>
                  <%}

		%>
                </table>
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td colspan="4">&nbsp;</td>
    </tr>
    <tr> 
      <td>6.1 </td>
      <td colspan="3" ><b>Collateral Security :</b></td>
    </tr>
    <tr> 
      <td colspan="4" align="right"><b><%=strValuesin%></b></td>
    </tr>
    <tr> 
      <td colspan="4"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3">
            <tr align="center" > 
                  
              <td width="31%"><b>Nature / Description of collateral security </b></td>
                  
              <td width="10%"><b> Value</b></td>
                  
              <td width="19%"><b> Date of Valuation along with name of Valuer</b></td>
                  
              <td width="14%"><b>Insurance Amount &amp; Date of Expiry</b></td>
                  
              <td width="26%"><b> Remarks</b></td>
                </tr>
                <%
                ArrayList arrColldetails=new ArrayList();
				ArrayList arrValues=new ArrayList();
				arrColldetails=(ArrayList)hshValues.get("arrSecurity");
				double dbltotal=0.00;
				if(arrColldetails!=null && arrColldetails.size()!=0)
					{
					for(int i=0;i<arrColldetails.size();i++)
	                	{
						arrValues=(ArrayList)arrColldetails.get(i); 				
						dbltotal = dbltotal+Double.parseDouble(Helper.correctDouble((String) arrValues.get(4)));
				%>
                
            <tr valign="top"> 
              <td width="31%"  class="just"> <%=Helper.correctNull((String)arrValues.get(3))%> 
              </td>
                  
              <td width="10%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrValues.get(4))))%></td>
                  
              <td width="19%" align="center">&nbsp;<%=Helper.correctNull((String)arrValues.get(5))%> 
                - <%=Helper.correctNull((String)arrValues.get(8))%> </td>
                  
              <td width="14%" align="center">&nbsp; 
                <%if(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrValues.get(9)))).equals("0.00"))
				  {
				  out.println("-");
				  }else{%>
                <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrValues.get(9))))%> 
                - <%=Helper.correctNull((String)arrValues.get(10))%></td>
                  <%}%>
                  
              <td width="26%">&nbsp;<%=Helper.correctNull((String)arrValues.get(11))%></td>
                </tr>
                <%}%>
				<tr> 
        	       	<td><b>Total</b></td>
    	            <td align="right"><%=Helper.formatDoubleValue(dbltotal)%></td>
	                <td>&nbsp;</td>
                	<td>&nbsp;</td>
					<td>&nbsp;</td>
              	</tr>
				<%}
				else{
				%>
                <tr> 
                  
              <td width="31%">&nbsp;</td>
                  
              <td width="10%">&nbsp;</td>
                  
              <td width="19%">&nbsp;</td>
                  
              <td width="14%">&nbsp;</td>
                  
              <td width="26%">&nbsp;</td>
                </tr>
                <%} %>
              </table>
            </div>
      </td>
    </tr>
    <tr> 
      <td colspan="4">&nbsp;</td>
    </tr>
    <tr> 
      <td>7.</td>
      <td colspan="3"><b>Financial Highlights :</b></td>
    </tr>
    <tr> 
      <td colspan="4" align="right"><b><%=strValuesin%></b></td>
    </tr>
			<% 
			ArrayList  vecdesc = (ArrayList)hshValues.get("vecdesc");
			ArrayList vectype=(ArrayList)hshValues.get("vectype");
			ArrayList vecCuryear = (ArrayList)hshValues.get("year");
			ArrayList vecPreyear = (ArrayList)hshValues.get("prevyear");
			ArrayList vecNextyear = (ArrayList)hshValues.get("nextyear");
			ArrayList vecNextyear2 = (ArrayList)hshValues.get("nextyear2");
			ArrayList vecPreyearHold1 = (ArrayList)hshValues.get("prevyearhold1");
			
			int vecsize=0;
			
			
			String curYear="",curYearDesc="",pervYear="",prevYearDesc="",nextYear="",nextYearDesc="",pervYear1="",prevYearDesc1="";
			String nextYear2="",nextYearDesc2="";
			
			ArrayList yearval=new ArrayList();
			yearval=(ArrayList)hshValues.get("yearvalue");
			if(yearval.size()>0 && yearval!=null)
			{
			curYear= Helper.correctNull((String)yearval.get(0));
			curYearDesc= Helper.correctNull((String)yearval.get(1));
			
			pervYear= Helper.correctNull((String)yearval.get(2));
			prevYearDesc= Helper.correctNull((String)yearval.get(3));
			
			nextYear= Helper.correctNull((String)yearval.get(4));
			nextYearDesc= Helper.correctNull((String)yearval.get(5));
			
			pervYear1= Helper.correctNull((String)yearval.get(6));
			prevYearDesc1= Helper.correctNull((String)yearval.get(7));
			
			nextYear2= Helper.correctNull((String)yearval.get(8));
			nextYearDesc2= Helper.correctNull((String)yearval.get(9));
			}
			
			String a="",b="",c="",d="",e="";
			
			if(curYearDesc.trim().equals("a"))
			{
			 a="Audited";
			}
			else if(curYearDesc.trim().equals("u"))
			{
			 a="Unaudited";
			}
			else if(curYearDesc.trim().equals("e"))
			{
			 a="Estimated";
			}
			else if(curYearDesc.trim().equals("p"))
			{
			 a="Projection";
			}
			
			if(prevYearDesc.trim().equals("a"))
			{
			 b="Audited";
			}
			else if(prevYearDesc.trim().equals("u"))
			{
			 b="Unaudited";
			}
			else if(prevYearDesc.trim().equals("e"))
			{
			 b="Estimated";
			}
			else if(prevYearDesc.trim().equals("p"))
			{
			 b="Projection";
			}
			
			 if(nextYearDesc.trim().equals("a"))
			{
			 c="Audited";
			}
			else if(nextYearDesc.trim().equals("u"))
			{
			 c="Unaudited";
			}
			else if(nextYearDesc.trim().equals("e"))
			{
			 c="Estimated";
			}
			else if(nextYearDesc.trim().equals("p"))
			{
			 c="Projection";
			}
			 
			if(prevYearDesc1.trim().equals("a"))
			{
			 d="Audited";
			}
			else if(prevYearDesc1.trim().equals("u"))
			{
			 d="Unaudited";
			}
			else if(prevYearDesc1.trim().equals("e"))
			{
			 d="Estimated";
			}
			else if(prevYearDesc1.trim().equals("p"))
			{
			 d="Projection";
			}
			
			if(nextYearDesc2.trim().equals("a"))
			{
			 e="Audited";
			}
			else if(nextYearDesc2.trim().equals("u"))
			{
			 e="Unaudited";
			}
			else if(nextYearDesc2.trim().equals("e"))
			{
			 e="Estimated";
			}
			else if(nextYearDesc2.trim().equals("p"))
			{
			 e="Projection";
			}
			
			if((!pervYear.trim().equalsIgnoreCase("")) || (!pervYear1.trim().equalsIgnoreCase("")))
			{
			%>
	 <tr> 
      <td colspan="4" >
	   <div id="top"> 
	  <table width="100%" border="0" cellspacing="0" cellpadding="3" align="left">
						<tr> 
							 <td align="center">Particulars</td>
							 <td colspan="2" align="center">Last 2 Years</td>
							 <td align="center">Current Year </td>
							 <td colspan="2" align="center">Next  2 Years </td>
						</tr>
						<tr> 
							<td>&nbsp;</td>
							<td align="center"><b><%=pervYear%>&nbsp;</b></td>
							<td align="center"><b><%=pervYear1%></b></td>
							<td align="center"><b><%=curYear%>&nbsp;</b></td>
							<td align="center"><b><%=nextYear%>&nbsp;</b></td>
							<td align="center"><b><%=nextYear2%>&nbsp;</b></td>
 						</tr>
						<tr> 
							<td>&nbsp;</td>
							<td align="center"><b><%=b%>&nbsp;</b></td>
							<td align="center"><b><%=d%></b></td>
							<td align="center"><b><%=a%>&nbsp;</b></td>
							<td align="center"><b><%=c%>&nbsp;</b></td>
							<td align="center"><b><%=e%>&nbsp;</b></td>
						</tr>
                 			<%	  
							if(vecdesc!=null)
							{
								vecsize = vecdesc.size();
							}
							for(int i=0;i<vecsize;i++)
							{
								String desc =Helper.correctNull((String)vecdesc.get(i));
								String type =Helper.correctNull((String)vectype.get(i));
								String col1 =Helper.correctNull((String)vecCuryear.get(i));//3
								String col3 = Helper.correctNull((String)vecPreyear.get(i));//1
								String col5 =Helper.correctNull((String)vecNextyear.get(i));//4
								String col9 =Helper.correctNull((String)vecNextyear2.get(i));//5
								String col8 =Helper.correctNull((String)vecPreyearHold1.get(i));//2
								%>
								<tr> 
								<% 
								if((type.trim().equals("HE")|| type.trim().equals("H")))
								{ 				
								%>
									<td><%=desc%></td>
									<td  align="center">&nbsp;</td>
									<td  align="right">&nbsp;</td>
									<td  align="center">&nbsp;</td>
									<td  align="center">&nbsp;</td>  
									<td  align="right">&nbsp;</td>    
								<% 
								}
								else
								{
								%>
									<td><%=desc%></td>
									<td  align="center">&nbsp;<%=col3%></td>
									<td  align="right" >&nbsp;<%=col8%></td>
									<td  align="center" >&nbsp;<%=col1%></td>
									<td  align="center" >&nbsp;<%=col5%></td>
									<td  align="center" >&nbsp;<%=col9%></td>
								<%
								}%>
								</tr>
							<%}
							   %>
						</table>
</div>
</td>
</tr>
<%} %>
	<tr> 
	<td colspan="4">&nbsp;</td>
	</tr>
	<tr> 
	<td colspan="4"><b>COMMENTS ON FINANCIAL INDICATORS: </b></td>
	</tr>
	<tr> 
	<td colspan="4"> <p><%=Helper.formatTextAreaData((String)hshValues.get("comments"))%></p></td>
	</tr>
	<tr> 
	  <td colspan="4">&nbsp;</td>
	</tr>
	<tr> 
      <td>8. </td>
      <td colspan="3"><b>Modifications in other sanction terms sought:</b></td>
    </tr>
    <tr> 
	  <td colspan="4">&nbsp;</td>
	</tr>
    <tr> 
      <td colspan="4"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3">
            <tr> 
              <td class="tabactivenew" align="center"><b> Existing Terms</b></td>
              <td class="tabactivenew" align="center"><b> Modifications Proposed 
                by Branch</b></td>
              <td class="tabactivenew" align="center"><b> Justification</b></td>
            </tr>
            <%
          
          	 arrRow = new ArrayList();
			 arrCol = new ArrayList();
			 arrRow = (ArrayList) hshValues.get("arrModification");
			 
		if(arrRow!=null && arrRow.size()>0)
		{
			for(int i=0; i<arrRow.size();i++)
			{
				arrCol=(ArrayList)arrRow.get(i);
	%>
            <tr align="left" valign="top" > 
              <td><%=Helper.formatTextAreaData((String)arrCol.get(1))%></td>
              <td><%=Helper.formatTextAreaData((String)arrCol.get(2))%></td>
              <td><%=Helper.formatTextAreaData((String)arrCol.get(3))%></td>
            </tr>
            <%
			}
		}
	 else {

			%>
            <tr> 
              <td align="center" colspan="3">No Data Found</td>
            </tr>
            <%}

		%>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="4">&nbsp;</td>
    </tr>
    <tr> 
      <td>9. </td>
      <td colspan="3"><b>Value of account :</b></td>
    </tr>
   
	 <tr> 
      <td colspan="4" align="right"><b><%=strValuesin%></b></td>
    </tr>
    <tr> 
      <td colspan="4"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3">
            <tr> 
              <td colspan="2">&nbsp;</td>
              <td align="center"><b>Previous Financial Year</b></td>
              <td align="center"><b>Current Financial Year</b></td>
            </tr>
            <%
          int arrsize = 0;
          arrRow = new ArrayList();
		  arrCol = new ArrayList();
		  arrRow = (ArrayList) hshValues.get("arrValueofAcc");
          
          if (arrRow != null) 
		  {
          	arrsize = arrRow.size();

          }
			String[] strdesc = { "Interest Income","Fee Based Income"};
			double dblFinPrev = 0.0;
			double dblFinCurr = 0.0;
			for (int l = 0; l < 2; l++) 
			{

				int arrSize = 0;

				if (l < arrsize) 
				{
					arrCol = (ArrayList) arrRow.get(l);
					dblFinPrev = dblFinPrev + Double.parseDouble(Helper.correctDouble((String) arrCol.get(0)));
					dblFinCurr = dblFinCurr + Double.parseDouble(Helper.correctDouble((String) arrCol.get(1)));
					
					if (arrCol != null) 
					{
						arrSize = arrCol.size();
					}
				}

				if (arrSize > 0) 
				{

						%>
            <tr> 
              <td colspan="2"><%=strdesc[l]%></td>
              <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(0))))%></td>
              <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))%></td>
            </tr>
            <%if(l==1){ %>
            <tr> 
              <td colspan="2">Total Income</td>
              <td align="right"><%=Helper.formatDoubleValue(dblFinPrev)%></td>
              <td align="right"><%=Helper.formatDoubleValue(dblFinCurr)%></td>
            </tr>
            <%
          }
          }
				else
				{
				%>
            <tr> 
              <td colspan="2"><%=strdesc[l]%></td>
              <td align="right">0.00</td>
              <td align="right">0.00</td>
            </tr>
            <%if(l==1){ %>
            <tr> 
              <td colspan="2">Total Income</td>
              <td align="right">0.00</td>
              <td align="right">0.00</td>
            </tr>
            <%}
				}
				}
				%>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="4">&nbsp;</td>
    </tr>
	<tr> 
      <td>10.</td>
      <td colspan="3"><b>RECOMMENDATIONS</b>:</td>
    </tr>
	
	<%if((!Helper.formatTextAreaData((String)hshValues.get("branch_comments")).equals("")))
	{ %>
    <tr> 
      <td>&nbsp;</td>
      <td colspan="3"><b>RECOMMENDATIONS OF BRANCH </b>:</td>
    </tr>
    <tr> 
	<tr> 
	<td>&nbsp;</td>
      <td colspan="3"><p><%=Helper.formatTextAreaData((String)hshValues.get("branch_comments"))%></p></td>
    </tr>
	<%-- 
     <%if(Helper.correctNull((String)hshValues.get("OrgLevel")).equalsIgnoreCase("A"))
    	{%>
		<tr> 
		  <td colspan="4">&nbsp;</td>
		</tr>
		
		<tr> 
		  <td colspan="4">&nbsp;</td>
		</tr>
		<tr> 
			  <td>&nbsp;</td>
		      <td colspan="3"><%=Helper.correctNull((String)hshValues.get("branch_signatures"))%></td>
	    </tr>--%>
    <%//}
    }
	if((!Helper.formatTextAreaData((String)hshValues.get("region_comments")).equals("")))
	{
	%>
	<tr> 
      <td>&nbsp;</td>
      <td colspan="3"><b>RECOMMENDATIONS OF RO : </b></td>
    </tr>	
    <tr>
	<td>&nbsp;</td>
      <td colspan="3"> 
        <p><%=Helper.formatTextAreaData((String)hshValues.get("region_comments"))%></p>
      </td>
    </tr>
     <%-- <%if(Helper.correctNull((String)hshValues.get("OrgLevel")).equalsIgnoreCase("D"))
    	{%>
		<tr> 
		  <td colspan="4">&nbsp;</td>
		</tr>
		<%-- 
		<tr> 
		  <td colspan="4">&nbsp;</td>
		</tr>
	    <tr> 
			<td>&nbsp;</td>
	        <td colspan="3"><%=Helper.correctNull((String)hshValues.get("region_signatures"))%></td>
	    </tr>
	    --%>
    <%//}
    }
	if((!Helper.formatTextAreaData((String)hshValues.get("zonal_comments")).equals("")))
	{
	%>
    <tr> 
      <td>&nbsp;</td>
      <td colspan="3"><b>RECOMMENDATIONS OF FGMO:</b></td>
    </tr>
    <tr> 
	<td>&nbsp;</td>
      <td colspan="3"> 
        <p><%=Helper.formatTextAreaData((String)hshValues.get("zonal_comments"))%></p>
      </td>
    </tr>
   <%--  <%if(Helper.correctNull((String)hshValues.get("OrgLevel")).equalsIgnoreCase("R"))
    	{%>
		<tr> 
		  <td colspan="4">&nbsp;</td>
		</tr>

		<tr> 
		  <td colspan="4">&nbsp;</td>
		</tr>

    <tr> 
	  	<td>&nbsp;</td>
      	<td colspan="3"><p><%=Helper.formatTextAreaData((String)hshValues.get("zonal_signatures"))%></p></td>
    </tr>
    --%>
    <%
    	//}
    }
	if(!Helper.formatTextAreaData((String)hshValues.get("central_comments")).equals(""))
	{
	%>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td colspan="3"><b>RECOMMENDATIONS OF C.O. </b></td>
    </tr>
    <tr> 
	<td>&nbsp;</td>
      <td colspan="3"> 
        <p><%=Helper.formatTextAreaData((String)hshValues.get("central_comments"))%></p>
      </td>
    </tr>
    
    <%} %>
    <tr> 
      <td colspan="4">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="4"><b>11. In veiw of the above, we recommend for concession in 
        interest/commission as under: </b></td>
    </tr>
    <tr> 
      <td colspan="4">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="4">11.1 <b>WITH REGARD TO INTEREST AND COMMISSION</b></td>
    </tr>
     <tr> 
      <td colspan="4" align="right"><b><%=strValuesin%></b></td>
    </tr>
    <tr> 
      <td colspan="4"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr> 
            <td> 
              <div id="top"> 
                <table width="100%" border="0" cellspacing="0" cellpadding="3">
                  <tr> 
                    <td align="center" class="tabactivenew" rowspan="2"><b>Nature 
                      of Limit</b></td>
                    <td align="center"  class="tabactivenew" rowspan="2" ><b>Amount</b></td>
                    <td align="center"  class="tabactivenew" rowspan="2" ><b>Margin</b></td>
                    <td align="center" class="tabactivenew" rowspan="2"><b>Applicable 
                      rate of interest / comission</b></td>
                    <td align="center" class="tabactivenew" colspan="3"><b>Int.
                      / comm. recommended </b></td>
                    <td align="center" class="tabactivenew" rowspan="2"><b>Int.
                      / comm. recommended by C.O.</b></td>
                    <td align="center" class="tabactivenew" rowspan="2"><b>Concession 
                      in int. rate / comm.</b></td>
                    <td align="center" class="tabactivenew" rowspan="2" ><b>Security</b></td>
                  </tr>
                  <tr> 
                    <td align="center" class="tabactivenew"><b>Branch</b></td>
                    <td align="center" class="tabactivenew"><b>RO</b></td>
                    <td align="center" class="tabactivenew"><b>FGMO</b></td>
                  </tr>
                  <%
                                 arrRow = new ArrayList();
                    			 arrCol = new ArrayList();
                    			arrRow = (ArrayList) hshValues.get("arrFacility");
			if (arrRow != null && arrRow.size() > 0) {
					int count = 0;
					for (int i = 0; i < arrRow.size(); i++) {
						arrCol = (ArrayList) arrRow.get(i);
						if (Helper.correctNull((String) arrCol.get(14)).equalsIgnoreCase("0")) {
							count = 0;
							%>
                  <tr > 
                    <td align="left" valign="top" >&nbsp; <%=Helper.correctNull((String) arrCol.get(17))%></td>
                    <td align="right" valign="top">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(2))))%></td>
                    <td align="right" valign="top">&nbsp;<%=Helper.correctNull((String) arrCol.get(4))%></td>
                    <td align="left" valign="top" >&nbsp;<%=Helper.correctNull((String) arrCol.get(7))%></td>
                     <td align="left" valign="top" ><%=Helper.correctNull((String) arrCol.get(9))%></td>
                    <td align="left" valign="top" ><%=Helper.correctNull((String) arrCol.get(10))%></td>
                    <td align="left" valign="top"><%=Helper.correctNull((String) arrCol.get(18))%></td>
                    <td align="left" valign="top"><%=Helper.correctNull((String) arrCol.get(11))%></td>
                    <td align="left" valign="top">&nbsp;<%=Helper.correctNull((String) arrCol.get(12))%></td>
                    <td align="right" valign="top"> 
                      <div id="top1"> 
                        <table width="100%" border="0">
                          <tr> 
                            <td valign="top"> 
                              <%
                  ArrayList arrSec = new ArrayList();
                  arrSec = (ArrayList)arrCol.get(19);
                  int subsecSize = arrSec.size();
  				if(arrSec!=null && subsecSize>0)
              	{
              		for(int j=0;j<subsecSize;j++)
              		{
              			ArrayList arrSecRecords = new ArrayList();
              			arrSecRecords = (ArrayList)arrSec.get(j); %>
                              <b><%=j+1%> .</b> &nbsp;<%=Helper.formatTextAreaData((String) arrSecRecords.get(0))%><br>
                              <%
                  }
              		}
  				%>
                            </td>
                          </tr>
                        </table>
                      </div>
                    </td>
                  </tr>
                  <%} else if (!Helper.correctNull((String) arrCol.get(14)).equalsIgnoreCase("0")) 
                            {
							%>
                  <tr> 
                    <%if (count == 0) {

							%>
                    <td colspan="10" ><b>&gt;&gt;Sub Limit</b></td>
                  </tr>
                  <tr> 
                    <%}

							%>
                    <td align="left" valign="top"><%=Helper.correctNull((String) arrCol.get(17))%></td>
                    <td align="right" valign="top"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(2))))%></td>
                    <td align="right" valign="top"><%=Helper.correctNull((String) arrCol.get(4))%></td>
                    <td align="left" valign="top"><%=Helper.correctNull((String) arrCol.get(7))%></td>
                     <td align="left" valign="top"><%=Helper.correctNull((String) arrCol.get(9))%></td>
                    <td align="left" valign="top"><%=Helper.correctNull((String) arrCol.get(10))%></td>
                    <td align="left" valign="top"><%=Helper.correctNull((String) arrCol.get(18))%></td>
                    <td align="left" valign="top"><%=Helper.correctNull((String) arrCol.get(11))%></td>
                    <td align="left" valign="top">&nbsp;<%=Helper.correctNull((String) arrCol.get(12))%></td>
                    <td align="right" valign="top"> 
                      <div id="top1"> 
                        <table width="100%" border="0">
                          <tr> 
                            <td valign="top"> 
                              <%
                  ArrayList arrSec = new ArrayList();
                  arrSec = (ArrayList)arrCol.get(19);
                  int subsecSize = arrSec.size();
  				if(arrSec!=null && subsecSize>0)
              	{
              		for(int j=0;j<subsecSize;j++)
              		{
              			ArrayList arrSecRecords = new ArrayList();
              			arrSecRecords = (ArrayList)arrSec.get(j); %>
                              <b><%=j+1%> .</b>&nbsp;<%=Helper.formatTextAreaData((String) arrSecRecords.get(0))%><br>
                              <%
                  }
              		}
  				%>
                            </td>
                          </tr>
                        </table>
                      </div>
                    </td>
                  </tr>
                  <%count++;
						}
					}

				%>
                  <%} else {

			%>
                  <tr> 
                    <td align="center" colspan="9">No Data Found</td>
                  </tr>
                  <%}

		%>
                </table>
              </div>
            </td>
          </tr>
          
          
          <%
                    arrRow=new ArrayList();
				    ArrayList  arrData=new ArrayList();
                    arrRow=(ArrayList)hshValues.get("arrSecRemarks");
                    if(arrRow!=null && arrRow.size()!=0){
                
                    %>
      <%  for(int i=0;i<arrRow.size();i++)
      {
    	  arrData=(ArrayList)arrRow.get(i); 
    	  if(!Helper.formatTextAreaData((String)arrData.get(0)).equalsIgnoreCase("")){ %>
		  <tr> 
          <td width="3%">&nbsp;</td>
        </tr>
        <tr> 		
          <td valign="top" class="just" width="97%"><%=Helper.formatTextAreaData((String)arrData.get(0))%>&nbsp;</td>
        </tr>
        
        <%}
	  } %>
		 <%   }
                    %>	
          
          
        </table>
      </td>
    </tr>
     
    <tr> 
      <td colspan="4">&nbsp;</td>
    </tr>
    
    <tr> 
      <td colspan="4">11.2<b> WITH REGARD TO MARGIN AND SECURITIES</b></td>
    </tr>
	<tr> 
	  <td colspan="4">&nbsp;</td>
	</tr>
    <tr> 
      <td colspan="4"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3">
            <tr> 
              <td class="tabactivenew" align="center"><b> Terms of Sanction</b></td>
              <td class="tabactivenew" align="center"><b> Stipulated Earlier</b></td>
              <td class="tabactivenew" align="center"><b> Recommended by Branch/RO/FGMO</b></td>
              <td class="tabactivenew" align="center"><b>Recommended by CO</b></td>
            </tr>
            <%
          arrRow = new ArrayList();
		  arrCol = new ArrayList();
		  arrRow = (ArrayList) hshValues.get("arrMarginSec");
          
		if(arrRow!=null && arrRow.size()>0)
		{
			for(int i=0; i<arrRow.size();i++)
			{
				arrCol=(ArrayList)arrRow.get(i);
				
				String strTerms = Helper.correctNull((String)arrCol.get(0));
				if(strTerms.equalsIgnoreCase("S"))
				{
					strTerms="";
				}
				else if(strTerms.equalsIgnoreCase("1"))
				{
					strTerms="Margin";
				}
				else if(strTerms.equalsIgnoreCase("2"))
				{
				strTerms="Primary security";
				}
				else if(strTerms.equalsIgnoreCase("3"))
				{
					strTerms="Collateral security";
				}
				else if(strTerms.equalsIgnoreCase("4"))
				{
					strTerms="Personal / Corporate Guarantees";
				}
				else if(strTerms.equalsIgnoreCase("5"))
				{
					strTerms="Others";
				}
	%>
            <tr align="left" valign="top"> 
              <td><%=strTerms%></td>
              <td> 
                <p><%=Helper.formatTextAreaData((String)arrCol.get(1))%></p>
              </td>
              <td> 
                <p><%=Helper.formatTextAreaData((String)arrCol.get(2))%></p>
              </td>
              <td> 
                <p><%=Helper.formatTextAreaData((String)arrCol.get(3))%></p>
              </td>
            </tr>
            <%
			}
		
	} else {

			%>
            <tr> 
              <td align="center" colspan="4">No Data Found</td>
            </tr>
            <%}

		%>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="4">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="4">
      <P>12.1 The above interest/commission is valid till further 
        instructions or the next renewal or one year from the date of sanction, 
        whichever is earlier. Branch has to revert to the original interest rate /commission at the 
        end of the period as stated above. </P>
        <P>12.2 All other terms and conditions of sanction remain the 
        same. </P>
        </td>
    </tr>
    <tr> 
      <td colspan="4">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="4">&nbsp;</td>
    </tr>
     <%//if(Helper.correctNull((String)hshValues.get("OrgLevel")).equalsIgnoreCase("C"))
    	//{%>
    <tr> 
      <td colspan="4"> 
         <%=Helper.correctNull((String)hshValues.get("signatures"))%>
      </td>
    </tr>
    <%//} %>
    <tr> 
      <td colspan="4">&nbsp;</td>
    </tr>
    
  </table>
</form>
</body>
</html>

