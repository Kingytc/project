<%@include file="../share/directives.jsp"%>
<%

	ArrayList arrAppRow = null;
	ArrayList arrcourseExpRow = null;
	ArrayList arrCol = new ArrayList();

	if ((ArrayList) hshValues.get("arrAppRow") != null) {
		arrAppRow = (ArrayList) hshValues.get("arrAppRow");
	}
	if ((ArrayList) hshValues.get("arrcourseExpRow") != null) {
		arrcourseExpRow = (ArrayList) hshValues.get("arrcourseExpRow");
	}
	String StrTemp = "";
%>
<html>
<head>
	<script type="text/javascript">
	var appUrl="<%=ApplicationParams.getAppUrl()%>";
	var varChkVal="<%=Helper.correctNull((String)hshValues.get("nsdl_laps_accepted"))%>";
	var varPageFrom="<%=Helper.correctNull((String)request.getParameter("strPageFrom"))%>";
	
	function doSubmit()
	{
		if(document.forms[0].txt_remarks.value=="")
		{
			alert("Please Enter Remarks");
			document.forms[0].txt_remarks.focus();
			return;
		}

		if(varPageFrom=="Inward")
		{
			window.opener.document.forms[0].hidnsdlremarks.value=document.forms[0].txt_remarks.value;
			window.close();
		}
		else
		{
			document.forms[0].hidCloseFlag.value="Y";
			document.forms[0].hidAction.value=document.forms[0].sel_appstatus.value;
			document.forms[0].hidBeanId.value="nsdl";
			document.forms[0].hidBeanMethod.value="updateNSDLApplicationstatus";
			document.forms[0].hidBeanGetMethod.value="getNsdlShowApplicationDetails";
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/nsdlShowAppDetails.jsp";
			document.forms[0].submit();	
		}	
	}
	function doClose()
	{
			window.close();
	}
	function callonLoad()
	{
		if(varChkVal!="")
		{
			document.forms[0].sel_appstatus.value=varChkVal;
		}
		else
		{
			document.forms[0].sel_appstatus.value="0";
		}
		if(varPageFrom=="Inward")
		{
			document.forms[0].txt_remarks.value=window.opener.document.forms[0].hidnsdlremarks.value;
		}
		
	}

</script>

</head>
<body  onload="callonLoad();">
<form method="post" class="normal">
<table width="90%" cellspacing="0" cellpadding="3" align="center" class="outertable">
<tr>
          <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg" width="400px;"></td>          		
        </tr>
 </table>
 <table width="90%" border="0" cellspacing="1" cellpadding="3"
			align="center" class="outertable">
			<tr>
			<td align="center" colspan="4"><b>NSDL Application</b>
			</td>
		</tr>
			<tr>
				<td width="20%" class="dataheader" align="center"><b>Reference ID</b></td>
				<td width="30%" class="datagrid"><b><%=Helper.correctNull((String) hshValues.get("strRefNo"))%>&nbsp;</b></td>
				<td width="20%" class="dataheader" align="center"><b>Organisation</b></td>
				<td width="30%" class="datagrid"><b><%=Helper.correctNull((String) session
							.getAttribute("strOrgName"))%>&nbsp;</b></td>
			</tr>
			<tr><td  colspan="4">&nbsp;</td></tr>
			</table>
<table width="90%" cellspacing="0" cellpadding="3" align="center" class="datagrid">
	<%
			if (arrAppRow != null && arrAppRow.size() > 0) {
				for (int i = 0; i < arrAppRow.size(); i++) {
					arrCol = (ArrayList) arrAppRow.get(i);
					if (arrCol != null && arrCol.size() > 0) {
						if (Helper.correctNull((String) arrCol.get(0))
								.equalsIgnoreCase("a")) {
							StrTemp = "APPLICANT";
						} else if (Helper.correctNull((String) arrCol.get(0))
								.equalsIgnoreCase("c")) {
							StrTemp = "CO - APPLICANT";
						} else if (Helper.correctNull((String) arrCol.get(0))
								.equalsIgnoreCase("g")) {
							StrTemp = "GUARANTOR";
						}
						
		%>
			<tr>
	<td  class="dataheader">
	<b><%=StrTemp%> DETAILS :</b></td></tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3"
			align="center" class="outertable linebor">
			<tr class="datagrid">
				<td width="20%"><b>Customer Name</b></td>
				
				
				<td width="30%"><%=Helper.correctNull((String) arrCol.get(1))
										.trim()%></td>
				<td width="25%"><b>Customer Email</b></td>
				<td width="25%" nowrap><%=Helper.correctNull((String) arrCol.get(15))%></td>
			</tr>
			<tr class="datagrid">
				<td><b>Father/Husband Name</b></td>
				<td ><%=Helper.correctNull((String) arrCol.get(2))%></td>
				<td ><b>Date of Birth</b></td>
				<td ><%=Helper.correctNull((String) arrCol.get(3))%></td>
			</tr>
			<tr class="datagrid">
				<td ><b>Gender</b></td>
				<td ><%=Helper.correctNull((String) arrCol.get(9))%>
				</td>
				<td ><b>Marital Status</b></td>
				<td ><%=Helper.correctNull((String) arrCol.get(10))%></td>
			</tr>
			<tr class="datagrid">
				<td><b>Qualification</b></td>
				<td><%=Helper.correctNull((String) arrCol.get(11))%></td>
				<td><b>Occupation</b></td>
				<td><%=Helper.correctNull((String) arrCol.get(16))%></td>
			</tr>
			<tr class="datagrid">
				
				<td><b>Income Sources</b></td>
				<td><%=Helper.correctNull((String) arrCol.get(17))%></td>
				<td><b>Pan No</b></td>
				<td><%=Helper.correctNull((String) arrCol.get(12))%></td>
			</tr>
			<tr class="datagrid">
				
				<td><b>Aadhaar No</b></td>
				<td><%=Helper.correctNull((String) arrCol.get(13))%></td>
				<td><b>Mobile No</b></td>
				<td><%=Helper.correctNull((String) arrCol.get(14))%></td>
			</tr>
			<tr class="datagrid">
				
				<td><b>Bank Name</b></td>
				<td><%=Helper.correctNull((String) arrCol.get(18))%></td>
				<td><b>Branch Name</b></td>
				<td><%=Helper.correctNull((String) arrCol.get(19))%></td>
			</tr>
			<tr class="datagrid">
				
				<td><b>Account No</b></td>
				<td><%=Helper.correctNull((String) arrCol.get(20))%></td>
				<td><b>Account Type</b></td>
				<td><%=Helper.correctNull((String) arrCol.get(21))%></td>
			</tr>
			<tr class="datagrid">
				
				<td><b>Liability</b></td>
				<td><%=Helper.correctNull((String) arrCol.get(22))%></td>
				
				<td><b>IFSC Code</b></td>
				<td><%=Helper.correctNull((String) arrCol.get(24))%></td>
			</tr>
			<tr class="datagrid">
			<td><b>Address</b>
			</td>
			<td colspan="3"><%=Helper.correctNull((String) arrCol.get(4))%>,<br>
			<%if(!Helper.correctNull((String) arrCol.get(5)).equalsIgnoreCase("")){ %>
			<%=Helper.correctNull((String) arrCol.get(5))%>,<br>
			<%} %>
			<%=Helper.correctNull((String) arrCol.get(6))%>,<br>
			<%=Helper.correctNull((String) arrCol.get(7))%> - <%=Helper.correctNull((String) arrCol.get(8))%>;
			</td>
			</tr>
			
		</table>
		</td>
	</tr>
	<%
		}
			}
		}
	%>
	<tr>
	<td class="dataheader" width="60%"><b>STUDENT DETAILS :</b></td></tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3"
			 class="outertable linebor" align="center">
			<tr class="datagrid">
				<td  width="30%"><b>Student ID</b></td>
				<td width="20%"><%=Helper.correctNull((String) hshValues
							.get("LN_STUDENT_ID"))%></td>
			
				<td width="30"><b>Student AppID</b></td>
				<td width="20"><%=Helper.correctNull((String) hshValues
							.get("LN_STUD_APPID"))%></td>
			</tr>
			<tr class="datagrid">
				<td><b>If Related To Employee OfBank</b></td>
				<td><%=Helper.correctNull((String) hshValues
									.get("LN_IFBANKER"))%></td>
				<td><b>Relationship Description</b></td>
				<td><%=Helper.correctNull((String) hshValues
									.get("LN_RELATION"))%></td>
			</tr>
			<tr class="datagrid">
				<td><b>Security</b></td>
				<td><%=Helper.correctNull((String) hshValues
									.get("LN_SECURITY"))%></td>
				<td><b>Scheme Code</b></td>
				<td><%=Helper.correctNull((String) hshValues
							.get("LN_SCHEMECODE"))%></td>
			</tr>
			<tr class="datagrid">
				<td><b>Project Cost</b></td>
				<td align="right"><%=Helper.correctNull((String) hshValues
							.get("LN_PROJECTCOST"))%></td>
				<td><b>Tenor</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("LN_TENURE"))%></td>
			</tr>
			<tr class="datagrid">
			<td><b>Requested Amount</b></td>
				<td align="right"><%=Helper.correctNull((String) hshValues
							.get("LN_REQUESTEDAMT"))%></td>
				<td><b>EMI</b></td>
				<td align="right"><%=Helper.correctNull((String) hshValues
									.get("LN_EMI"))%></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
	<td class="dataheader" width="60%"><b>COURSE DETAILS :</b></td></tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3"
			 class="outertable linebor" align="center">

			<tr class="datagrid">

				<td width="40%"><b>Institution Name</b></td>
				<td width="60%"><%=Helper.correctNull((String) hshValues
							.get("LN_INSTITUTIONNAME"))%></td>

			</tr>

			<tr class="datagrid">

				<td><b>Course Name</b></td>
				<td><%=Helper.correctNull((String) hshValues
							.get("LN_COURSENAME"))%></td>
			</tr>
			<tr class="datagrid">

				<td><b>Admission Quota</b></td>
				<td><%=Helper.correctNull((String) hshValues
							.get("LN_ADMISSIONQUOTA"))%></td>
			</tr>
			<tr class="datagrid">
				<td><b>Course Duration (in Years)</b></td>
				<td><%=Helper.correctNull((String) hshValues
									.get("LN_DURATION"))%></td>

			</tr>
			<tr class="datagrid">
				<td><b>Commence Date</b></td>
				<td><%=Helper.correctNull((String) hshValues
									.get("cuscourseDOJ"))%></td>

			</tr>

			<tr class="datagrid">
				<td><b>Completion Date</b></td>
				<td><%=Helper.correctNull((String) hshValues
							.get("cuscoursecompletion"))%></td>

			</tr>
		</table>
		</td>
	</tr>

<tr>
	<td class="dataheader"><b>COURSE EXPENSES :</b></td></tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3"
			align="center" class="outertable linebor">
			<tr align="center"  class="dataheader">
				<td width="5%"><b>Year</b></td>
				<td width="12%"><b>Tution Fees</b></td>
				<td width="12%"><b>Exam Fees</b></td>
				<td width="12%"><b>Books/Stationary</b></td>
				<td width="12%" nowrap="nowrap"><b>Computer &<br>
				other equipment</b></td>
				<td width="12%"><b>Hostel Fees</b></td>
				<td width="12%"><b>Sundries</b></td>
				<td width="10%"><b>Total</b></td>
				<td width="10%"><b>Loan Required</b></td>
				<td width="10%"><b>Scholarship Amount</b></td>
			</tr>
				<% 
					if (arrcourseExpRow != null && arrcourseExpRow.size() > 0) {
						for (int i = 0; i < arrcourseExpRow.size(); i++) {
							arrCol = (ArrayList) arrcourseExpRow.get(i);
							if (arrCol != null && arrCol.size() > 0) {
								if (Helper.correctNull((String) arrCol.get(0))
										.equalsIgnoreCase("Total")) {%>
										
				<tr  class="datagrid">
				<td align="center"><b><%=Helper
													.correctNull((String) arrCol
															.get(0)) %> </b></td>
				<td align="right"><b><%=Helper
													.correctNull((String) arrCol
															.get(1)) %> </b></td>
				<td align="right"><b><%=Helper
													.correctNull((String) arrCol
															.get(2)) %> </b></td>
				<td align="right"><b><%=Helper
													.correctNull((String) arrCol
															.get(3))%> </b></td>
				<td align="right"><b><%=Helper
													.correctNull((String) arrCol
															.get(4))%></b></td>
				<td align="right"><b><%=Helper
													.correctNull((String) arrCol
															.get(5))%></b></td>
				<td align="right"><b><%=Helper
													.correctNull((String) arrCol
															.get(6))%></b></td>
				<td align="right"><b><%=Helper
													.correctNull((String) arrCol
															.get(7))%></b></td>
				<td align="right"><b><%=Helper
													.correctNull((String) arrCol
															.get(9))%></b></td>
				<td align="right"><b><%=Helper
													.correctNull((String) arrCol
															.get(8))%></b></td>
			</tr>

								<% } else {
									%>
				<tr class="datagrid">
				<td align="center"><%=Helper
													.correctNull((String) arrCol
															.get(0))%></td>
				<td align="right"><%=Helper
													.correctNull((String) arrCol
															.get(1))%></td>
				<td align="right"><%=Helper
													.correctNull((String) arrCol
															.get(2))%></td>
				<td align="right"><%=Helper
													.correctNull((String) arrCol
															.get(3))%></td>
				<td align="right"><%=Helper
													.correctNull((String) arrCol
															.get(4))%> </td>
				<td align="right"><%=Helper
													.correctNull((String) arrCol
															.get(5))%></td>
				<td align="right"><%=Helper
													.correctNull((String) arrCol
															.get(6))%></td>
				<td align="right"><%=Helper.correctNull((String) arrCol.get(7))%></td>
				<td align="right"><%=Helper.correctNull((String) arrCol.get(9))%></td>
				<td align="right"><%=Helper.correctNull((String) arrCol.get(8))%></td>
			</tr>
			<% 
				}
						}
					}
				}
			%>
		</table>
		</td>
	</tr>
	<tr>
	<td>&nbsp;</td>
	</tr>
	<tr>
	<td>
	<table width="100%" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
         <td>Remarks</td>
         </tr>
         <tr  class="datagrid" style="display: none;">
         <td width="10%">Status</td>  
         <td>
         <select name="sel_appstatus"  style="font-size:11px;text-decoration:none;">
			<option value="0"><---Select--></option>
			<option value="NP">In Process</option>
		    <option value="NA">Approved</option>
		    <option value="NR">Rejected</option>
		</select>
		</td>        		
       </tr>
       <tr  class="datagrid">
       <td align="center">
		<TEXTAREA name="txt_remarks" COLS="120" ROWS="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("nsdl_remarks")) %></TEXTAREA>
		</td>
       </tr>
	 </table>
 </td>
	</tr>
	
</table>
<br>
<%if(!Helper.correctNull((String)request.getParameter("strPageFrom")).equalsIgnoreCase("Loan") && !Helper.correctNull((String)request.getParameter("paramtype")).equalsIgnoreCase("Update_App")){ %>
<lapschoice:combuttonnew
	btnnames='Submit' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	<%}else{%>
	<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	<%} %>
<lapschoice:hiddentag pageid='<%=PageId%>' />
	<input type="hidden" name="hidRefNo" value="<%=Helper.correctNull((String) hshValues.get("strRefNo")) %>">
	<input type="hidden" name="hidCloseFlag" value="N">
	<input type="hidden" name="strPageFrom" value="<%=Helper.correctNull((String)request.getParameter("strPageFrom")) %>">
	</form>
	</body>
</html>