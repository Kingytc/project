<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	ArrayList vec1 = null;
	int vecsize1 = 0;
	if (hshValues != null) {
		vec1 = (ArrayList) hshValues.get("vecVal1");
	}
	if (vec1 != null) {
		vecsize1 = vec1.size();
	}
%>

<html>
<head>
<title>Raw Materials / Input</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"> </script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"> </script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/com/comrawmaterialsmajor.js"> </script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var recflag="<%=Helper.correctNull((String) hshValues.get("recflag"))%>";
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onload="placeValues()">
<form method="post" name="fltintrate" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="4" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Products -&gt; Raw Materials -&gt; Other Inputs</td>
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable border1">
	<tr>
		<td>
		<table border="0" cellspacing="2" cellpadding="3" class="outertable"
			WIDTH="70%">
			<tr align="center">
				<td width="10%" class="sub_tab_inactive"><b><a href="#"
					onclick="javascript:callLink('comactivities.jsp','compro','getActivity')">Activities</a></b></td>
				<td width="10%" class="sub_tab_inactive"><b><a href="#"
					onclick="javascript:callLink('comproduction.jsp','combanking','getProductData')">About
				Prod.</a></b></td>
				<td width="10%" class="sub_tab_active"><b>Raw Materials</b></td>
				<td width="10%" class="sub_tab_inactive"><b><a href="#"
					onclick="javascript:callLink('comprocessdesc.jsp','combanking','getDescData')">Manf.Process</a></b></td>
				<td width="10%" class="sub_tab_inactive"><b><a href="#"
					onclick="javascript:callLink('comgovtpolicies.jsp','combanking','getGovtData')">Govt.Policy</a></b></td>
				<td width="10%" class="sub_tab_inactive"><b><a href="#"
					onclick="javascript:callLink('comtransport.jsp','combanking','getTransData')">Transportation</a></b></td>
				<td width="10%" class="sub_tab_inactive"><b><a href="#"
					onclick="javascript:callLink('commarketing.jsp','combanking','getSegmentData')">Marketing</a></b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable">
					<tr>
						<td colspan="2">
						<table border="0" cellspacing="2" cellpadding="3"
							class="outertable" WIDTH="80%">
							<tr align="center">
								<td width="10%" class="sub_tab_inactive" NOWRAP><b><a
									href="#"
									onclick="javascript:callLink('comrawmaterials.jsp','combanking','getRawData')">Raw
								Materials</a></b></td>
								<td width="10%" class="sub_tab_active" NOWRAP><b>Other
								Inputs</b></td>
								<td width="15%" class="sub_tab_inactive" NOWRAP><b><a
									href="#"
									onclick="javascript:callLink('comrawsupply.jsp','combanking','getSupplyData')">Supp.of
								Raw Materials- Imported</a></b></td>
								<td width="15%" class="sub_tab_inactive" NOWRAP><b><a
									href="#"
									onclick="javascript:callLink('comrawsupplyindi.jsp','compro','getSupplyIndiData')">Supp.of
								Raw Materials - Indigenous</a></b></td>
								<td width="10%" class="sub_tab_inactive" NOWRAP><b><a
									href="#"
									onclick="javascript:callLink('comotherdetails.jsp','combanking','getOtherData')">Other
								Details</a></b></td>
								<td width="10%" class="sub_tab_inactive" NOWRAP><b><a
									href="#"
									onclick="javascript:callLink('comotherdetailssubst.jsp','compro','getOtherSubstData')">Substitutes</a></b></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td colspan="2">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable border1">
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="1" cellpadding="3"
									class="outertable">
									<tr class="dataheader">
										<td width="8%" align="center">S.No</td>
										<td width="18%" align="center">List of Major Inputs
										needed viz., Power, Water Fuel</td>
										<td width="15%" align="center">Imported/ Indigenous</td>
										<td align="center" colspan="4">Approximate cost per unit</td>
										<td width="13%" align="center">%to cost of production</td>
										<td width="17%" align="center">%to raw material cost</td>
										<td align="center">Availability along with location</td>
									</tr>
									<tr class="dataheader">
										<td width="8%">&nbsp;</td>
										<td align="center" width="18%">&nbsp;</td>
										<td align="center" width="11%">&nbsp;</td>
										<td width="15%" align="center"><b>Unit</b></td>
										<td width="15%" align="center" nowrap="nowrap">Total
										Quantity of units</td>
										<td width="15%" align="center"><b>Cost per unit</b></td>
										<td width="13%" align="center"><b>Purity Level (%)</b></td>
										<td width="17%" align="center">&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<%
										ArrayList g2 = null;
										//if(vecsize1!=0)
										//{
										for (int j = 0; j < 8; j++) {

											int colSize1 = 0;

											if (j < vecsize1) {
												g2 = (ArrayList) vec1.get(j);

												if (g2 != null) {
													colSize1 = g2.size();
												}
											}

											//String type1=Helper.correctNull((String)g2.get(9));

											if (colSize1 > 0) {
									%>
									<tr>
										<td align="center"><%=j + 1%></td>
										<td align="center"><input type="text" name="inputs"
											size="25"
											value="<%=Helper.correctNull((String) g2
											.get(2))%>"
											maxlength="199" onKeyPress="notAllowSplChar1(this)">
										</td>
										<td align="center"><select name="from">
											<option value="S" selected="selected">Select</option>
											<option value="imp"
												<%if ((Helper.correctNull((String) g2.get(10)))
							.equals("imp"))
						out.println("selected");%>>Imported</option>
											<option value="ind"
												<%if ((Helper.correctNull((String) g2.get(10)))
							.equals("ind"))
						out.println("selected");%>>Indigenous</option>
											<!--   <option value="both" 
								  <%if ((Helper.correctNull((String) g2.get(10)))
							.equals("both"))
						out.println("selected");%>>Both</option> -->
										</select></td>
										<td width="15%" align="center"><select name="inputunit">
											<option value="S" selected="selected">Select</option>
											<option value="Ton"
												<%if ((Helper.correctNull((String) g2.get(3)))
							.equals("Ton"))
						out.println("selected");%>>Ton</option>
											<option value="Litres"
												<%if ((Helper.correctNull((String) g2.get(3)))
							.equals("Litres"))
						out.println("selected");%>>Litres</option>
											<option value="Numbers"
												<%if ((Helper.correctNull((String) g2.get(3)))
							.equals("Numbers"))
						out.println("selected");%>>Numbers</option>
											<option value="Carat"
												<%if ((Helper.correctNull((String) g2.get(3)))
							.equals("Carat"))
						out.println("selected");%>>Carat</option>
											<option value="Metre"
												<%if ((Helper.correctNull((String) g2.get(3)))
							.equals("Metre"))
						out.println("selected");%>>Metre</option>
											<option value="Bales"
												<%if ((Helper.correctNull((String) g2.get(3)))
							.equals("Bales"))
						out.println("selected");%>>Bales</option>
											<option value="Others"
												<%if ((Helper.correctNull((String) g2.get(3)))
							.equals("Others"))
						out.println("selected");%>>Others</option>
										</select></td>
										<td width="15%" align="center"><input type="text"
											name="totalquantity" size="12"
											value="<%=Helper.correctNull((String) g2.get(11))%>"
											onKeyPress="allowNumber(this)" maxlength="12"
											style="text-align: right"></td>
										<td width="15%" align="center"><lapschoice:CurrencyTag
											name="inputcostperunit" size="12"
											value='<%=Helper.correctNull((String) g2
											.get(4))%>'
											maxlength="12" /></td>
										<td width="15%" align="center"><lapschoice:CurrencyTag
											name="inputpurity" size="7"
											value='<%=Helper.correctNull((String) g2
											.get(5))%>'
											onBlur="checkPercentage(this)" maxlength="5" /></td>
										<td width="13%" align="center"><lapschoice:CurrencyTag
											name="inputpercost" size="7"
											value='<%=Helper.correctNull((String) g2
											.get(6))%>'
											onBlur="checkPercentage(this)" maxlength="5" /></td>
										<td width="17%" align="center"><lapschoice:CurrencyTag
											name="inputperrawcost" size="7"
											value='<%=Helper.correctNull((String) g2
											.get(7))%>'
											onBlur="checkPercentage(this)" maxlength="5" /></td>
										<td width="17%" align="center"><input type="text"
											name="inputlocation" size="20" maxlength="49"
											value="<%=Helper.correctNull((String) g2
											.get(9))%>"
											onKeyPress="notAllowSplChar1(this)"> <input
											type="hidden" name="inputtype" size="12" value="type2">
										</td>
									</tr>
									<%
										} else {
									%>
									<tr>
										<td align="center"><%=j + 1%></td>
										<td align="center"><input type="text" name="inputs"
											size="25" maxlength="199" onKeyPress="notAllowSplChar1(this)">
										</td>
										<td align="center"><select name="from">
											<option value="S" selected="selected">Select</option>
											<option value="imp">Imported</option>
											<option value="ind">Indigenous</option>
										</select></td>
										<td width="15%" align="center"><select name="inputunit">
											<option value="S" selected="selected">Select</option>
											<option value="Ton">Ton</option>
											<option value="Litres">Litres</option>
											<option value="Numbers">Numbers</option>
											<option value="Carat">Carat</option>
											<option value="Metre">Metre</option>
											<option value="Bales">Bales</option>
											<option value="Others">Others</option>
										</select></td>
										<td width="15%" align="center"><input type="text"
											name="totalquantity" size="12" onKeyPress="allowNumber(this)"
											maxlength="12" style="text-align: right"></td>
										<td width="15%" align="center"><lapschoice:CurrencyTag
											name="inputcostperunit" size="12" maxlength="12" /></td>
										<td width="15%" align="center"><lapschoice:CurrencyTag
											name="inputpurity" size="7" onBlur="checkPercentage(this)"
											maxlength="5" /></td>
										<td width="13%" align="center"><lapschoice:CurrencyTag
											name="inputpercost" size="7" onBlur="checkPercentage(this)"
											maxlength="5" /></td>
										<td width="17%" align="center"><lapschoice:CurrencyTag
											name="inputperrawcost" size="7"
											onBlur="checkPercentage(this)" maxlength="5" /></td>
										<td width="17%" align="center"><input type="text"
											name="inputlocation" size="20" maxlength="49"
											onKeyPress="notAllowSplChar1(this)"> <input
											type="hidden" name="inputtype" size="12" value="type2">
										</td>
									</tr>
									<%
										}
										}
									%>
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
<table border="0" cellspacing="0" cellpadding="0" align="center"
	class="outertable">
	<tr>
		<td><lapschoice:combuttonnew
			btnnames="Edit_Save_Delete_Cancel_Audit Trail"
			btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
		</td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>' /></form>
</body>
</html>
