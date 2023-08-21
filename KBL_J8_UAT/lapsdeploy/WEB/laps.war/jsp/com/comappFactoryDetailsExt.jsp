<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	arrRow = (ArrayList) hshValues.get("arrRow");
%>
<html>
<head>
<title>Factory Details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
	function doClose() {
		if (ConfirmMsg(100)) {
			window.close();
		}
	}
	function disableFields(val) {
		for ( var i = 0; i < document.forms[0].length; i++) {
			if (document.forms[0].elements[i].type == 'text') {
				document.forms[0].elements[i].readOnly = val;
			}
			if (document.forms[0].elements[i].type == 'textarea') {
				document.forms[0].elements[i].readOnly = val;
			}
			if (document.forms[0].elements[i].type == 'select-one') {
				document.forms[0].elements[i].disabled = val;
			}
		}
	}
	function selectValues(sno, dettype, name, address, city, state, pin, ph,fax,premises) {
		document.forms[0].seltype.value = dettype;
		document.forms[0].comapp_name.value = name;
		document.forms[0].comapp_address.value = address;
		document.forms[0].comapp_city.value = city;
		document.forms[0].comapp_state.value = state;
		document.forms[0].comapp_pin.value = pin;
		document.forms[0].comapp_ph.value = ph;
		document.forms[0].comapp_fax.value = fax;
		document.forms[0].comapp_sno.value=sno;
		document.forms[0].comapp_factpremises.value=premises;
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body class="bgcolor" onload="disableFields(true)">
<form name="frmpri" method=post class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Commercial(Applicant Master) -&gt;
		Customer Master Details -&gt; Company Details -&gt; Factory/Branches/Godowns details/sales depots/outlets</td>
	</tr>	
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5"
	align="center" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5"
					class="outertable border1">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="5"
							class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="2"
									class="outertable">
									<tr>
										<td width="10%">Select</td>
										<td width="20%"><select name="seltype">
											<option value="0">---Select--</option>
											<option value="1">Factory</option>
											<option value="2">Branches</option>
											<option value="3">Godown</option>
											<option value="4">Sales depots/ Outlets</option>
										</select></td>
										<td width="15%" nowrap>Name of the Factory/ <br>
										Branches/ Godown</td>
										<td width="20%"><input type="text" name="comapp_name"
											size="25" maxlength="75" style="text-align: left;"></td>
										<td width="6%">Address</td>
										<td width="15%"><textarea name="comapp_address" cols="25"
											rows="2" style="text-align: left;"  onkeypress="textlimit(this,999)" onKeyUp="textlimit(this,999)" wrap="VIRTUAL"></textarea></td>

									</tr>
									<tr>
										<td>City</td>
										<td><input type="text" name="comapp_city" size="20"
											maxlength="100" style="text-align: left;"></td>
										<td>State</td>
										<td><input type="text" name="comapp_state" size="15"
											maxlength="50" style="text-align: left;"></td>
										<td>Pincode</td>
										<td><input type="text" name="comapp_pin" size="25"
											maxlength="6" style="text-align: left;" allowInteger()"></td>

									</tr>
									<tr>
										<td>Phone No.</td>
										<td><input type="text" name="comapp_ph" size="20"
											maxlength="20" style="text-align: left;"></td>
										<td>Fax</td>
										<td><input type="text" name="comapp_fax" size="20"
											maxlength="20" style="text-align: left;"></td>
										<td>Premises</td>
										<td align="left"><select name="comapp_factpremises"
											size="1">
											<option Selected="selected" value="0">--Select--</option>
											<option value="1">Owned</option>
											<option value="2">Leased</option>
											<option value="3">Rented</option>
										</select></td>

									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable linebor">
			<tr class="dataheader" align="center">
				<td width="10%">Select</td>
				<td width="20%">Name of the Factory/ Branches/ Godown Details</td>
				<td width="25%">Address</td>
				<td width="10%">City</td>
				<td width="10%">State</td>
				<td width="10%">Phone No</td>
				<td width="15%">Premises</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<%if(arrRow.size()>6){ %>
		<div class="cellContainer">
		<%} %>
		<table width="100%" border="0" cellspacing="1" cellpadding="3">
			<%
				if (arrRow != null && arrRow.size() > 0) {
					String temp = "";
					String strpremises = "";
					for (int i = 0; i < arrRow.size(); i++) {
						arrCol = (ArrayList) arrRow.get(i);
			%>
			<tr class="datagrid">
				<td width="10%" align="center">
				<%
					if (!(temp.equals(Helper
									.correctNull((String) arrCol.get(2))))) {
								temp = Helper.correctNull((String) arrCol.get(2));
								if (temp.equals("1")) {
									out.println("Factory");
								} else if (temp.equals("2")) {
									out.println("Branches");
								} else if (temp.equals("3")) {
									out.println("Godown");
								} else if (temp.equals("4")) {
									out.println("Sales depots/ Outlets");
								}
							}
				%> &nbsp;
				<td width="20%"><B><A
					HREF="javascript:selectValues('<%=Helper.correctNull((String) arrCol.get(1))%>','<%=Helper.correctNull((String) arrCol.get(2))%>'
                            	,'<%=Helper.correctNull((String) arrCol.get(3))%>','<%=Helper.correctNull((String) arrCol.get(4))%>'
                            	,'<%=Helper.correctNull((String) arrCol.get(5))%>','<%=Helper.correctNull((String) arrCol.get(6))%>',
                            	'<%=Helper.correctNull((String) arrCol.get(7))%>','<%=Helper.correctNull((String) arrCol.get(8))%>',
                            	'<%=Helper.correctNull((String) arrCol.get(9))%>','<%=Helper.correctNull((String) arrCol.get(10))%>')"><%=Helper.correctNull((String) arrCol.get(3))%></A></B>
				<td width="25%"><%=Helper.correctNull((String) arrCol.get(4))%>
				</td>
				<td width="10%"><%=Helper.correctNull((String) arrCol.get(5))%>&nbsp;</td>
				<td width="10%"><%=Helper.correctNull((String) arrCol.get(6))%>&nbsp;</td>
				<td width="10%"><%=Helper.correctNull((String) arrCol.get(8))%>&nbsp;</td>
				<td width="15%">
				<%
					strpremises = Helper.correctNull((String) arrCol.get(10));
							{
								if (strpremises.equals("1")) {
									out.println("Owned");
								} else if (strpremises.equals("2")) {
									out.println("Leased");
								} else if (strpremises.equals("3")) {
									out.println("Rented");
								}
							}
				%>&nbsp;</td>
			</tr>

			<%
				}
			%>
			
			<%
				} else {
			%>
			<tr class="datagrid">
				<td align="center" colspan="8">No Data Found</td>
			</tr>
			<%
				}
			%>
		</table>
		<%if(arrRow.size()>6){ %>
		</div>
		<%} %>
		</td>
	</tr>
</table>

<br>
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="comapp_sno" value=""> <input type="hidden"
	name="comapp_id"
	value="<%=Helper.correctNull((String) hshValues.get("comapp_id"))%>">

</form>
</body>
</html>
