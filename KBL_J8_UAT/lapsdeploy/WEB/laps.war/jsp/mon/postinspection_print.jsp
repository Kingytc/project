<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%
java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
nf.setMinimumFractionDigits(2);
nf.setMaximumFractionDigits(2);
nf.setGroupingUsed(false);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Post Inspection -  PrintOut</title>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/executivereport.css"
	type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="25px" topmargin="25px" marginwidth="25px" marginheight="25px">
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td align="center"><img
					src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg"></td>
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
			
			
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="6" align="center"><b>Post Inspection Report</b></td>
        </tr>
        <tr> 
          <td colspan="6">&nbsp;</td>
        </tr>
        <tr> 
          <td width="26%"><b>Date of Inspection&nbsp;&nbsp;:</b></td>
          <td width="25%"><%=Helper.correctNull((String)hshValues.get("inspec_date"))%></td>
          <td width="36%"><b>Date of Previous Inspection&nbsp;&nbsp;:</b></td>
          <td width="13%"><%=Helper.correctNull((String)hshValues.get("previous_inspecdate"))%></td>
        </tr>
        <tr> 
          <td colspan="6">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="6">&nbsp;</td>
        </tr>
        <tr> 
          <td height="18" colspan="6"><b>Name of Inspecting Officials:</b></td>
        </tr>
        <tr> 
          <td colspan="6"> 
            <div id="top"> 
              <table border="0" width="100%" cellspacing="0" cellpadding="0">
                <tr  class="tblhead"> 
                  <td width="5%" align="center"><strong>S.No.</strong></td>
                  <td width="45%" align="center"><strong>Name</strong></td>
                  <td width="50%" align="center"><strong>Designation</strong></td>
                </tr>
                <%if(!Helper.correctNull((String)hshValues.get("inspec_official1")).equals("")){
            	   if(!Helper.correctNull((String)hshValues.get("inspec_official1")).equals("")){ %>
                <tr> 
                  <td width="5%">1.</td>
                  <td width="45%"><%=Helper.correctNull((String)hshValues.get("inspec_official1"))%>&nbsp;	
                  </td>
                  <td width="50%"><%=Helper.correctNull((String)hshValues.get("inspec_officialdesig1"))%>&nbsp;</td>
                </tr>
                <%}%>
                <%if(!Helper.correctNull((String)hshValues.get("inspec_official2")).equals("")){ %>
                <tr> 
                  <td width="5%">2.</td>
                  <td width="45%"><%=Helper.correctNull((String)hshValues.get("inspec_official2"))%>&nbsp;</td>
                  <td width="50%"><%=Helper.correctNull((String)hshValues.get("inspec_officialdesig2"))%>&nbsp;</td>
                </tr>
                <%}%>
                <%if(!Helper.correctNull((String)hshValues.get("inspec_official3")).equals("")){ %>
                <tr> 
                  <td width="5%">3.</td>
                  <td width="45%"><%=Helper.correctNull((String)hshValues.get("inspec_official3"))%>&nbsp;</td>
                  <td width="50%"><%=Helper.correctNull((String)hshValues.get("inspec_officialdesig3"))%>&nbsp;</td>
                </tr>
                <%}%>
                <%}%>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td colspan="6">&nbsp;</td>
        </tr>
        <tr> 
		<td colspan="6">
		    <table width="100%">
              <tr>
                <td width="24%"><b>Name of Borrower</b></td>
                <td width="2%"><b><b>:</b></b></td>
                <td colspan="4" width="74%"><%=Helper.correctNull((String)hshValues.get("personal_custname"))%>&nbsp;</td>
		  </tr>
		  
		  </table>
        </tr>
        <tr> 
          <td colspan="6">&nbsp;</td>
        </tr>
        <tr> 
		<td colspan="6">
		    <table width="100%">
              <tr>
                <td valign="top" width="24%"><b>Address</b></td>
                <td width="2%" valign="top"><b><b>:</b></b></td>
                <td colspan="4" width="74%"><%=Helper.correctNull((String) hshValues
							.get("personal_address"))%>-<%=Helper.correctNull((String) hshValues
							.get("personal_address1"))%><br>
            <%=Helper.correctNull((String) hshValues
									.get("city_name"))%> <br>
            <%=Helper.correctNull((String) hshValues
							.get("state_name"))%> <br>
            Pin:<%=Helper.correctNull((String) hshValues
							.get("personal_pincode"))%><br>
			</td>
			</tr>
			</table>
          </td>
        </tr>
        <tr> 
          <td colspan="6">&nbsp;</td>
        </tr>
      </table>
		</td>
	</tr>
</table>



<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top"><div id="top">
			<table  width="100%" cellspacing="0"  cellpadding="0">
      <tr class="tblhead">
        <td width="4%"><strong>S.No.</strong></td>
        <td width="36%" align="center"><strong>Purpose of Loan</strong></td>
        <td width="20%" align="center"><strong>Limit Sanction</strong></td>
        <td width="20%" align="center" ><strong>Outstanding</strong></td>
        <td width="20%" align="center"><strong>Overdue ,if any</strong></td>
      </tr>
       <% 
    ArrayList arrRow = (ArrayList)hshValues.get("arrRow");
    if(arrRow != null && arrRow.size()>0){
    	
    	
    	for(int i=0;i<arrRow.size();i++){
    		ArrayList arrCol = (ArrayList)arrRow.get(i);
    		if(arrCol != null){
    %>
    <tr> 
      <td><%=i+1%>.</td>
      <td><%=Helper.correctNull((String)arrCol.get(2))%>&nbsp;</td>
      <td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))%>&nbsp;</td>
      <td align="right"> <%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%>&nbsp;</td>
      <td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))%>&nbsp;</td>
    </tr>
   <%}}}%><%-- else{ %>
   <tr>
   <td colspan="6" align="center">&nbsp;</td>
   </tr>
   <%} %>--%>
    </table>
		</div>
		</td>
	</tr>
</table>

<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">&nbsp;</td>
	</tr>
</table>


<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
		<tr>	
		<td valign="top" colspan="2"><b>Observation of Inspecting Officials:</b></td>
	</tr>
	<tr>
		<td valign="top" width="3%">&nbsp;</td>
		<td><%=Helper.correctEditor((String)hshValues.get("official_observation"))%>&nbsp;</td>
	</tr>
</table>


<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>

		
		<td valign="top" colspan="2"><b>Any adverse features observed during visit:</b></td>
	</tr>
	<tr>
		<td valign="top" width="3%">&nbsp;</td>
		<td class="just"><%=Helper.formatTextAreaData((String)hshValues.get("shortfall"))%>&nbsp;</td>
	</tr>
</table>

<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">&nbsp;</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top" width="79%"><b>Place:</b><%=Helper.correctNull((String)hshValues.get("from_place"))%>&nbsp;</td>
    <td valign="top" width="21%" ><b>Name:</b><%=Helper.correctNull((String)hshValues.get("user_name"))%></td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top" width="79%"><b>Date:</b><%=Helper.correctNull((String)hshValues.get("filled_date"))%>&nbsp;</td>
    <td valign="top" width="21%" ><b>Desgination:</b><%=Helper.correctNull((String)hshValues.get("user_desig"))%></td>
  </tr>
</table>

<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">&nbsp;</td>
	</tr>
</table>

<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">&nbsp;</td>
	</tr>
</table>

<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
<tr> 
      <td width="43%"><b>Comments / observations of the Approving Authority:</b></td>
      <td width="4%">&nbsp;</td>
      <td width="50%">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="3"><%=Helper.formatTextAreaData((String)hshValues.get("sanccomments")) %></td>
    </tr>
    <tr> 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr> 
      <td width="43%"><b>Date : <%=Helper.correctNull((String)hshValues.get("approvedate")) %> </b></td>
      <td width="4%">&nbsp;</td>
      <td width="50%" align="center"> <b>Signature of Approving Authority</b></td>
    </tr>
</table>
</body>
</html>
