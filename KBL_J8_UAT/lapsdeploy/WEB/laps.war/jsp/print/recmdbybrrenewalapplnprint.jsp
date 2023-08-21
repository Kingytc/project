<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<jsp:useBean id="strOrgLevel" class="java.lang.String" scope="session" />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<laps:handleerror />

<%
ArrayList OperationalarrRow= new ArrayList();
ArrayList arrCol= new ArrayList();
ArrayList BusinessarrRow= new ArrayList();
ArrayList BusinessarrCol= new ArrayList();


OperationalarrRow =(ArrayList)hshValues.get("OperationalDetails");

//String strSector=Helper.correctNull((String)request.getParameter("hidsector"));
//String strSaral = Helper.correctNull((String) request.getParameter("hidsaral"));
//String strApploantype = Helper.correctNull((String) request.getParameter("apploantype"));
//String strApplevel=Helper.correctNull((String)request.getParameter("applevel"));

String strValuesin=Helper.correctNull((String)request.getParameter("valuesin"));
//System.out.println(strValuesin);

%>

<html>
<head>
<title>Facility For Recommendation</title>
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varOrgLevel="<%=strOrgLevel%>";
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<form method="post" name="frmbrrecmd">
<table width="100%" border="0" cellspacing="0" cellpadding="0"	bgcolor="#FFFFFF">
<tr>
<td>
<table width="80%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td valign="top">
              <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr> 
                  <td colspan="4" align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg"></td>
                </tr>
                <tr> 
                  <td colspan="4" align="center"><b>Branch - <%=Helper.correctNull((String)hshValues.get("orgname"))%></b> 
                  </td>
                </tr>
                <tr> 
                  <td colspan="4" align="center"><%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp; 
                    <%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp; 
                    <%=Helper.correctNull((String)hshValues.get("orgcity"))%>,&nbsp; 
                    <%=Helper.correctNull((String)hshValues.get("orgstate"))%>-&nbsp; 
                    <%=Helper.correctNull((String)hshValues.get("orgzip"))%>&nbsp; 
                    <hr/>
                  </td>
                </tr>
                <tr> 
                  <td colspan="4" align="center" height="38" valign="middle"><b><u>Recommendation 
                    form for renewal / enhancement / adhoc</u></b></td>
                </tr>
                <tr> 
                  <td width="5%"><b>1. </b></td>
                  <td width="44%"><b>Name of the Borrower </b> </td>
                  <td colspan="2" width="51%"><b>:</b> &nbsp;<%=Helper.decodeAmpersand(Helper.correctNull((String)request.getParameter("appname")))%></td>
                </tr>
                <tr> 
                  <td width="5%"><b>2. </b></td>
                  <td colspan="3"><b>Review Period &nbsp; : &nbsp; </b><b>From</b> 
                    &nbsp;<%=Helper.correctNull((String)hshValues.get("brrecmdreviewfrom"))%> 
                    &nbsp;<b>to</b> &nbsp;<%=Helper.correctNull((String)hshValues.get("brrecmdreviewto"))%> 
                  </td>
                </tr>
                <tr> 
                  <td width="5%"><b>3. </b></td>
                  <td colspan="3"><b>Account Operational Details &nbsp; :&nbsp; </b> 
                  &nbsp; 
                  &nbsp;
                  </td>
                </tr>
                <tr> 
                  <td valign="top" colspan="4"> 
                <tr> 
                  <td colspan="4"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                      <tr> 
                        <td align="right"><b>( <%=ApplicationParams.getCurrency()%> 
                          <%=strValuesin %> )</b> </td>
                      </tr>
                      <tr> 
                        <td> 
                          <div id="top"> 
                            <table width="100%" border="0" cellspacing="0" cellpadding="3">
                              <tr> 
                                <td width="11%" rowspan="2"><b>Facility</b></td>
                                <td colspan="4"  align="center"><b>As On: </b><%=Helper.correctNull((String)hshValues.get("accoprationalasondate"))%></td>
                                <td colspan="5" align="center"><b>From : </b> <%=Helper.correctNull((String)hshValues.get("accoprationalfromdate"))%>&nbsp;&nbsp;&nbsp; <b>To : </b> <%=Helper.correctNull((String)hshValues.get("accoprationaltodate"))%> </td>
                              </tr>
                              <tr>
                                <td align="center" width="8%" ><b>Limit</b> </td>
                                <td align="center" width="11%" ><b>Out Standing 
                                  </b> </td>
                                <td align="center" width="11%" ><b>Total Value 
                                  of Security</b></td>
                                <td align="center" width="7%" ><b>Drawing Power</b></td>
                                <td align="center" width="9%"  ><b>Maximum Avail 
                                  ment </b></td>
                                <td align="center" width="9%"  ><b>Minimum Avail 
                                  ment </b></td>
                                <td align="center" width="9%"  ><b>Turn over Debit</b></td>
                                <td align="center" width="12%"  ><b>Turn over 
                                  Credit</b></td>
                                <td align="center" width="13%"  ><b>Average Utilization</b></td>
                              </tr>
                              <%
			if(OperationalarrRow!=null && OperationalarrRow.size() > 0){
			if (OperationalarrRow.size() > 0) {
			for (int i = 0; i < OperationalarrRow.size(); i++) {
			arrCol = (ArrayList) OperationalarrRow.get(i);

	//

	//
	
	
			%>
                              <tr> 
                                <td width="11%" ><%=Helper.correctNull((String)arrCol.get(3))%> 
                                </td>
                                <td width="8%" align="right" ><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%></td>
                                <td width="11%" align="right" ><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))%></td>
                                <td width="11%" align="right" ><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))%></td>
                                <td align="right" width="7%" ><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7))))%></td>
                                <td align="right" width="9%" ><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(8))))%></td>
                                <td align="right" width="9%" ><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(9))))%></td>
                                <td align="right" width="9%" ><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(10))))%></td>
                                <td align="right" width="12%" ><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(11))))%></td>
                                <td align="right" width="13%" ><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(12))))%></td>
                              </tr>
                              <%}
			}}else{

			    %>
                              <tr> 
                                <td align="center" colspan="10">Not Applicable</td>
                              </tr>
                              <%} %>
                            </table>
                          </div>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td width="5%" valign="top"><b>4.</b></td>
                  <td width="44%" valign="top"><b>Business Operations </b><br/>
                   <b>From&nbsp;</b> <%=Helper.correctNull((String)hshValues.get("bussoprns_fromdate"))%>
                  &nbsp; <b>To </b> <%=Helper.correctNull((String)hshValues.get("bussoprns_todate"))%></td>
                </tr>
                
                <tr> 
				  <td width="5%">&nbsp;</td>
                  <td colspan="3"> 
				    <table width="60%" border="0">
                      <tr> 
                        
                        <td  align="right"><b>( <%=ApplicationParams.getCurrency()%> 
                          <%=strValuesin %> )</b></td>
                      </tr>
                    </table>
                    <div id="top"> 
                      <table width="60%" border="0" cellspacing="0" cellpadding="3">
                        <tr> 
                          <td align="center" width="70%" ><b>Business Operations</b></td>
                          <td align="center" width="15%" ><b>Number</b></td>
                          <td align="center" width="15%" ><b>Amount</b></td>
                        </tr>
                        <%
                        BusinessarrRow =(ArrayList)hshValues.get("BusinessOperation");
                        if(BusinessarrRow!=null && BusinessarrRow.size() > 0){
                			if (BusinessarrRow.size() > 0) {
                			for (int i = 0; i < BusinessarrRow.size(); i++) {
                				BusinessarrCol = (ArrayList) BusinessarrRow.get(i);
                        
                        %>
                        <tr > 
                          <td align="left"><%=Helper.correctNull((String)BusinessarrCol.get(3))%></td>
                          <td align="left"><%=Helper.correctNull((String)BusinessarrCol.get(4))%></td>
                          <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)BusinessarrCol.get(5))))%></td>
                        </tr>
                         <%}
			}}else{

			    %>
                              <tr> 
                                <td align="center" colspan="3">Not Applicable</td>
                              </tr>
                              <%} %>
                      </table>
                    </div>
                  </td>
                </tr>
                <tr> 
                  <td width="5%" valign="top"><b>5.</b></td>
                  <td colspan="3" valign="top"><b>Fee Income /Commission generated from the 
                    account </b><br>
                     <b>From &nbsp;</b> <%=Helper.correctNull((String)hshValues.get("accoprationalfromdate"))%>
                  &nbsp; <b>To </b> <%=Helper.correctNull((String)hshValues.get("accoprationalasondate"))%>
                    </td>
                </tr>
                <tr> 
				  <td width="5%">&nbsp;</td>
                  <td colspan="3"> 
				    <table width="60%" border="0">
                      <tr>
                        
                        <td align="right"><b>( <%=ApplicationParams.getCurrency()%> 
                          <%=strValuesin %> )</b></td>
  </tr>
</table>
                    <div id="top"> 
                      <table width="60%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="55%" align="center" ><b>Facility</b></td>
                          <td width="20%" align="center" ><b>Amount of Income 
                            / Commission </b></td>
                        </tr>
                        <%
			if(OperationalarrRow!=null && OperationalarrRow.size() > 0){
			if (OperationalarrRow.size() > 0) {
			for (int i = 0; i < OperationalarrRow.size(); i++) {
			arrCol = (ArrayList) OperationalarrRow.get(i);
			%>
                        <tr> 
                          <td ><%=Helper.correctNull((String)arrCol.get(3))%> 
                          </td>
                          <td align="right" ><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(13))))%></td>
                        </tr>
                        <%}
			}}else{

			    %>
                        <tr> 
                          <td align="center" colspan="2">Not Applicable</td>
                        </tr>
                        <%} %>
                      </table>
                    </div>
                  </td>
                </tr>
                <tr> 
                  <td width="5%"><b>5.1</b></td>
                  <td colspan="3"><b>Any Other major business / income received</b></td>
                </tr>
                <tr> 
                  <td width="5%">&nbsp;</td>
                  <td colspan="3"> 
                    <p><%=Helper.formatTextAreaData((String) hshValues.get("brrecmdmajor"))%></p>
                  </td>
                </tr>
                <tr> 
                  <td width="5%" valign="top"><b>6</b></td>
                  <td colspan="3" valign="top"><b>Adverse features observed in the account</b><br/>
                   <b>From&nbsp;</b> <%=Helper.correctNull((String)hshValues.get("advfeatures_fromdate"))%>
                  &nbsp; <b>To </b> <%=Helper.correctNull((String)hshValues.get("advfeatures_todate"))%></td>
                </tr>
                <tr> 
				  <td width="5%">&nbsp;</td>
                  <td colspan="3"> 
				    <table width="60%" border="0">
                      <tr> 
                        <td align="right"><b>( <%=ApplicationParams.getCurrency()%> 
                          <%=strValuesin %> )</b></td>
                      </tr>
                    </table>
                    
                    <div id="top"> 
                      <table width="60%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="70%" align="center"><b>Particulars</b></td>
                          <td align="center" width="15%" ><b>Number</b></td>
                          <td align="center" width="15%" ><b>Amount </b></td>
                        </tr>
                         <%
                        BusinessarrRow =(ArrayList)hshValues.get("AdverseFeatures");
                        if(BusinessarrRow!=null && BusinessarrRow.size() > 0){
                			if (BusinessarrRow.size() > 0) {
                			for (int i = 0; i < BusinessarrRow.size(); i++) {
                				BusinessarrCol = (ArrayList) BusinessarrRow.get(i);
                        
                        %>
                       <tr > 
                          <td align="left"><%=Helper.correctNull((String)BusinessarrCol.get(3))%></td>
                          <td align="center"><%=Helper.correctNull((String)BusinessarrCol.get(4))%></td>
                          <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)BusinessarrCol.get(5))))%></td>
                        </tr>
                         <%}
			}}else{

			    %>
                              <tr> 
                                <td align="center" colspan="3">Not Applicable</td>
                              </tr>
                              <%} %>
                       
                      </table>
                    </div>
                  </td>
                </tr>
                <tr> 
                  <td width="5%"><b>6.1</b></td>
                  <td colspan="3"><b>Default in Installments</b></td>
                </tr>
                <tr> 
				  <td width="5%">&nbsp;</td>
                  <td colspan="3"> 
				    <table width="60%" border="0">
                      <tr> 
                        <td align="right"><b>( <%=ApplicationParams.getCurrency()%> 
                          <%=strValuesin %> )</b></td>
                      </tr>
                    </table>
                    
                    <div id="top"> 
                      <table width="60%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="70%" align="center"><b>Particulars</b></td>
                          <td align="center" width="15%" ><b>Number</b></td>
                          <td align="center" width="15%" ><b>Amount </b></td>
                        </tr>
                        <%
                        BusinessarrRow =(ArrayList)hshValues.get("DefaultsInstallment");
                        if(BusinessarrRow!=null && BusinessarrRow.size() > 0){
                			if (BusinessarrRow.size() > 0) {
                			for (int i = 0; i < BusinessarrRow.size(); i++) {
                				BusinessarrCol = (ArrayList) BusinessarrRow.get(i);
                        
                        %>
                       <tr > 
                          <td align="left"><%=Helper.correctNull((String)BusinessarrCol.get(3))%></td>
                          <td align="center"><%=Helper.correctNull((String)BusinessarrCol.get(4))%></td>
                          <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)BusinessarrCol.get(5))))%></td>
                        </tr>
                         <%}
			}}else{

			    %>
                              <tr> 
                                <td align="center" colspan="3">Not Applicable</td>
                              </tr>
                              <%} %>
                      </table>
                    </div>
                  </td>
                </tr>
                <tr> 
                  <td width="5%"><b>6.2</b></td>
                  <td colspan="3"><b>Present Overdues/Excess as on :</b> <%=Helper.correctNull((String)hshValues.get("accoprationalasondate"))%></td>
                </tr>
                <tr> 
				  <td width="5%">&nbsp;</td>
                  <td colspan="3"> 
				    <table width="60%" border="0">
                      <tr> 
                        <td align="right"><b>( <%=ApplicationParams.getCurrency()%> 
                          <%=strValuesin %> )</b></td>
                      </tr>
                    </table>
                    
                    <div id="top"> 
                      <table width="60%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="60%" align="center" ><b>Facility</b></td>
                          <td width="20%" align="center" ><b>Present Overdue / 
                            Excess </b></td>
                        </tr>
                        <%
			if(OperationalarrRow!=null && OperationalarrRow.size() > 0){
			if (OperationalarrRow.size() > 0) {
			for (int i = 0; i < OperationalarrRow.size(); i++) {
			arrCol = (ArrayList) OperationalarrRow.get(i);
			%>
                        <tr> 
                          <td><%=Helper.correctNull((String)arrCol.get(3))%> 
                          </td>
                          <td align="right" ><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(14))))%></td>
                        </tr>
                        <%}
			}}else{

			    %>
                        <tr> 
                          <td align="center" colspan="2">Not Applicable</td>
                        </tr>
                        <%} %>
                      </table>
                    </div>
                  </td>
                </tr>
                <tr> 
                  <td width="5%"><b>7.</b></td>
                  <td colspan="3"><b>Comments On Utilization of Limits :</b></td>
                </tr>
                <tr> 
                  <td width="5%">&nbsp;</td>
                  <td colspan="3"><b>(Comments on excess allowed in the account 
                    and its adjustment/ our experience in Bills portfolio,Funding 
                    of L/C / L/G ,Servicing of interest,Repayment of installments 
                    and routing of foreign Exchange Business / Other Business 
                    through us </b></td>
                </tr>
                <tr> 
                  <td width="5%">&nbsp;</td>
                  <td colspan="3"> 
                    <p><%=Helper.formatTextAreaData((String) hshValues.get("brrecmdutilization"))%></p>
                  </td>
                </tr>
                <tr> 
                  <td width="5%"><b>8.</b></td>
                  <td colspan="3"><b>Recommendation from the branch side on renewal 
                    / enhancement of limits</b></td>
                </tr>
                <tr> 
                  
                  <td colspan="4"> 
                   <table width="100%" border="0" cellspacing="0" cellpadding="0"
							align="center">
							<tr>
							<td width="6%">&nbsp;</td>
								<td>
								<table width="60%" border="0">
                      <tr>
                        
                        <td align="right" ><b>( <%=ApplicationParams.getCurrency()%> 
                          <%=strValuesin %> )</b></td>
  </tr>
</table>
                    
                    
						 <div id="top"> 
                          <table width="60%" border="0" cellspacing="0" cellpadding="3">
						  <tr> 
                               
                                <td align="center" width="55%" class="tabactivenew"><b>Facility Type</b></td>
                                <td align="center" width="15%" class="tabactivenew"><b>Existing 
                                  Limits</b></td>
                                <td align="center" width="15%" class="tabactivenew"><b>Limits 
                                  Applied </b></td>
                                <td align="center" width="15%" class="tabactivenew"><b>Limits 
                                  recommended </b></td>
                            </tr>
                            <%
                            //String sel_val;
                            //String strSno="";
                            double dblamtapplied=0.0;
                            double dblamtrecmd=0.0;
                            double dblamtexisting=0.0;
							ArrayList arrRowFac = new ArrayList();
			ArrayList arrColFac = new ArrayList();
			arrRowFac = (ArrayList) hshValues.get("arrRow");
			////System.out.println("1111-->>>> "+arrRowFac);
			if (arrRowFac != null && arrRowFac.size() > 0) {
				if (arrRowFac.size() > 0) {
					int count=0;
					for (int i = 0; i < arrRowFac.size(); i++) {
						arrColFac = (ArrayList) arrRowFac.get(i);
						////System.out.println("-->>>> "+arrColFac);
						//sel_val = "";
						//if (Helper.correctNull((String) arrColFac.get(0)).equals("1"))
							//sel_val = "Contingent Limits";
						//else if (Helper.correctNull((String) arrColFac.get(0)).equals("2"))
							//sel_val = "Working capital Limits";
						//else if (Helper.correctNull((String) arrColFac.get(0)).equals("3"))
							//sel_val = "Term Loan/DPGL Limits";
						//strSno=Helper.correctNull((String)arrColFac.get(5));
						if(Helper.correctNull((String)arrColFac.get(6)).equalsIgnoreCase("0")){
							dblamtexisting=dblamtexisting+Double.parseDouble(Helper.correctDouble((String)arrColFac.get(7)));
							dblamtapplied=dblamtapplied+Double.parseDouble(Helper.correctDouble((String)arrColFac.get(2)));
							dblamtrecmd=dblamtrecmd+Double.parseDouble(Helper.correctDouble((String)arrColFac.get(4)));
							count=0;
						%>
                            <tr > 
                               
                                <td align="left">&nbsp; <%=Helper.correctNull((String) arrColFac.get(1))%></td>
                                <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrColFac.get(7))))%></td>
                                <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrColFac.get(2))))%></td>
                                <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrColFac.get(4))))%></td>
                            </tr>
                            <%}else if(!Helper.correctNull((String)arrColFac.get(6)).equalsIgnoreCase("0")){ 
							
						%>
                            <tr > 
                              <%if(count==0){ %>
                               
                              <td colspan="4" ><b>&gt;&gt;Sub 
                                Limit</b></td>
                            </tr>
                            <tr> 
                              <%} %>
                               
                                <td align="left"><%=Helper.correctNull((String) arrColFac.get(1))%>&nbsp;</td>
                                <td align="right">&nbsp;(<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrColFac.get(7))))%>)</td>
                                <td align="right">&nbsp;(<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrColFac.get(2))))%>)</td>
                                <td align="right">&nbsp;(<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrColFac.get(4))))%>)</td>
                            </tr>
                            <%
						count++;
						}
						}
				}
			 %>
                            <tr bgcolor="#FFFFFF"> 
                              
                                <td align="right"><b>Total</b></td>
                                <td align="right">&nbsp;<%=Helper.formatDoubleValue(dblamtexisting)%></td>
                                <td align="right">&nbsp;<%=Helper.formatDoubleValue(dblamtapplied)%></td>
                                <td align="right">&nbsp;<%=Helper.formatDoubleValue(dblamtrecmd)%></td>
                            </tr>
                            <%}else {

			%>
                            <tr> 
                              <td align="center" colspan="4">Not Applicable</td>
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
                  <td width="5%">&nbsp;</td>
                  <td colspan="3">  <p><%=Helper.formatTextAreaData((String) hshValues.get("brrecomdations"))%></p></td>
                </tr>
                <tr> 
                  <td width="5%">&nbsp;</td>
                  <td colspan="3">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="5%">&nbsp;</td>
                  <td colspan="3">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="5%">&nbsp;</td>
                  <td width="44%"><b>Manager / Sr. Manager / Chief Manager</b></td>
                  <td align="right" colspan="2" width="51%"><b>Branch Head</b></td>
                </tr>
              </table>
		</td>
			</tr>
		</table>
		</td>
			</tr>
		</table>
		
		<br>
		
		</form>

</body>
</html>
