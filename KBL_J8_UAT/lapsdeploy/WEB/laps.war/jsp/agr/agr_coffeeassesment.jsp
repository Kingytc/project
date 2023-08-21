<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%ArrayList arryRow = new ArrayList();
			arryRow = (ArrayList) hshValues.get("arryRow");

			if (arryRow == null) {
				arryRow = new ArrayList();
			}
			ArrayList arryRow1 = new ArrayList();

			arryRow1 = (ArrayList) hshValues.get("arryRow1");

			if (arryRow1 == null) {
				arryRow1 = new ArrayList();
			}
			ArrayList arryColplant = new ArrayList();
			ArrayList arryRowplant = new ArrayList();

			arryRowplant = (ArrayList) hshValues.get("arryRowplant");

			if (arryRowplant == null) {
				arryRowplant = new ArrayList();
			}

			String d3 = "", d4 = "", d5 = "", d6 = "";
			String d9 = "", d10 = "", d11 = "", d12 = "";
			String m1 = "", m2 = "", m3 = "", m4 = "", m5 = "";
			String m6 = "", m7 = "", m8 = "";
			ArrayList arryColval = new ArrayList();
			ArrayList arryRowval = new ArrayList();
			arryRowval = (ArrayList) hshValues.get("arryRowval");

			if (arryRowval == null) {
				arryRowval = new ArrayList();
			}

			%>
<html>
<head>
<title>Appraisal - EMI Calculation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/agr/coffeeassesment.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var checkSetUpData = "<%=Helper.correctNull((String) hshValues.get("checkSetUpData"))%>";
function calculateleastval()
{
	
	 var firstval = document.forms[0].txt_averagevalper.value;
	 var secondval = document.forms[0].txt_estimatevalper.value;
	 var thirdval = document.forms[0].txt_totalqualamt.value;
	 var fourthval = document.forms[0].txt_totalantamt.value;
	 var fifthval = document.forms[0].txt_loanamount.value;
	 if(eval(fifthval)=="")
	 {
	 fifthval="0";
	 }
	 var leastval = "0";
	 
	 if(eval(firstval) < eval(secondval))
	 {
	  	leastval = firstval;
	  	
	 }
	 else
	 {
	 	leastval = secondval;
	 	
	 }
	 if(eval(leastval) < eval(thirdval))
	 {
	   	leastval =  leastval;
	   	
	 }
	 else
	 {
	   	leastval = thirdval;
	   	
	 }
	 if(eval(leastval) < eval(fourthval))
	 {
	  	leastval = leastval;
	 }
	 else
	 {
	 	 leastval = fourthval;
	 	 
	 }
	 if(eval(leastval) < eval(fifthval))
	 {
	  	leastval = leastval;
	 }
	 else
	 {
	 	 leastval = fifthval;
	 	 
	 }
	 document.forms[0].txt_leastamount.value = leastval;
	 
	 
	 	
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body
	onload="onloading();callAverage();callAverage1();callEligibility();callEligibility1();callEligibility3();callEligibility4();callTotal();calculateleastval();">

<form name="appform" method="post" action="">
<table width="100%" border="0" cellpadding="3" cellspacing="0"
	class="outertable border1"
	align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr bgcolor="#71694F">
				<td colspan="5"><font color="#FFFFFF"><strong>Average crop picked
				for 4 seasons</strong></font></td>
			</tr>
			<tr>
				<td width="100%">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td align="center">
						<table width="100%" border="2" cellspacing="0" cellpadding="3">
							<tr>
								<td colspan="4" align="center"><b>Crop picked in
								Tonnes</b></td>
							</tr>
							<tr>
								<td colspan="2" align="center">Arabica</td>
								<td colspan="2" align="center">Robusta</td>
							</tr>
							<tr>
								<td align="center">Parachment</td>
								<td align="center">Cherry</td>
								<td align="center">Parachment</td>
								<td align="center">Cherry</td>
							</tr>
							<tr>
								<td align="center"><input type="text" name="txt_parachmentarb"
									maxlenght="10" size="15" style="text-align:Left"
									value="<%=Helper.correctNull((String)hshValues.get("netarea1"))%>"
									onBlur="callAverage()"></td>
								<td align="center"><input type="text" name="txt_cherryarb"
									maxlenght="10" size="15" style="text-align:Left"
									value="<%=Helper.correctNull((String)hshValues.get("netarea2"))%>"
									onBlur="callAverage()"></td>
								<td align="center"><input type="text" name="txt_parachmentrob"
									maxlenght="10" size="15" style="text-align:Left"
									value="<%=Helper.correctNull((String)hshValues.get("netarea3"))%>"
									onBlur="callAverage()"></td>
								<td align="center"><input type="text" name="txt_cherryrob"
									maxlenght="10" size="15" style="text-align:Left"
									value="<%=Helper.correctNull((String)hshValues.get("netarea4"))%>"
									onBlur="callAverage()"></td>
							</tr>
						</table>
						</td>
						<td align="center">
						<table width="100%" border="2" cellspacing="0" cellpadding="3">
							<tr>
								<td colspan="4" align="center"><b>Value as per
								our Norms(Rs.)</b></td>
							</tr>
							<tr>
								<td width="50%" colspan="2" align="center">Arabica</td>
								<td width="50%" colspan="2" align="center">Robusta</td>
							</tr>
							<tr>
								<td align="center">Parachment</td>
								<td align="center">Cherry</td>
								<td align="center">Parachment</td>
								<td align="center">Cherry</td>
							</tr>
							<tr>
								<%if (arryRowval.size() != 0) {
				arryColval = (ArrayList) arryRowval.get(0);
				if (arryColval.size() != 0) {
					m1 = Helper.correctNull((String) arryColval.get(2));
				}
			} else if (arryRowplant.size() == 0) {
				m1 = "";

			}

			%>

								<%if (arryRowval.size() > 1) {
				arryColval = (ArrayList) arryRowval.get(1);

				if (arryColval.size() != 0) {

					m2 = Helper.correctNull((String) arryColval.get(2));

				}

			} else if (arryRowplant.size() == 0) {
				m2 = "";

			}

			%>
								<%if (arryRowval.size() > 2) {
				arryColval = (ArrayList) arryRowval.get(2);

				if (arryColval.size() != 0) {

					m3 = Helper.correctNull((String) arryColval.get(2));

				}

			} else if (arryRowplant.size() == 0) {
				m3 = "";

			}

			%>
								<%if (arryRowval != null && arryRowval.size() > 3) {
				arryColval = (ArrayList) arryRowval.get(3);

				if (arryColval.size() > 2) {

					m4 = Helper.correctNull((String) arryColval.get(2));

				}

			} else if (arryRowplant.size() == 0) {
				m4 = "";

			}

			%>


								<td align="center"><input type="text"
									name="txt_parachmentarbval" maxlenght="10" size="15"
									style="text-align:Left" value="<%=m1%>"
									onBlur="callAverage();calculateleastval()"
									onKeyPress="allowInteger()"></td>
								<td align="center"><input type="text" name="txt_cherryarbval"
									maxlenght="10" size="15" style="text-align:Left"
									value="<%=m2%>" onBlur="callAverage();calculateleastval()"
									onKeyPress="allowInteger()"></td>
								<td align="center"><input type="text"
									name="txt_parachmentrobval" maxlenght="10" size="15"
									style="text-align:Left" value="<%=m3%>"
									onBlur="callAverage();calculateleastval()"
									onKeyPress="allowInteger()"></td>
								<td align="center"><input type="text" name="txt_cherryrobval"
									maxlenght="10" size="15" style="text-align:Left"
									value="<%=m4%>" onBlur="callAverage();calculateleastval()"
									onKeyPress="allowInteger()"></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
					<tr>
						<td colspan="4" align="center"><b>Total Value</b></td>
					</tr>
					<tr>
						<td colspan="2" align="center">Arabica</td>
						<td colspan="2" align="center">Robusta</td>
					</tr>
					<tr>
						<td align="center">Parachment</td>
						<td align="center">Cherry</td>
						<td align="center">Parachment</td>
						<td align="center">Cherry</td>
					</tr>
					<tr>
						<td align="center"><input type="text"
							name="txt_totparachmentarbval" maxlenght="10" size="15"
							style="text-align:Left" value=""></td>
						<td align="center"><input type="text" name="txt_totcherryarbval"
							maxlenght="10" size="15" style="text-align:Left" value=""></td>
						<td align="center"><input type="text"
							name="txt_totparachmentrobval" maxlenght="10" size="15"
							style="text-align:Left" value=""></td>
						<td align="center"><input type="text" name="txt_totcherryrobval"
							maxlenght="10" size="15" style="text-align:Left" value=""></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr bgcolor="#71694F">

				<td><font color="#FFFFFF"><strong>Total amount for Average crop
				picked for 4 seasons </strong> <input type="text"
					name="txt_averageval" maxlenght="10" size="15"
					style="text-align:Left" value=""> <strong> <input type="text"
					name="txt_averagevalper" maxlenght="10" size="15"
					style="text-align:left" value=""> (75%)(A) </strong></td>

			</tr>
			<tr bgcolor="#71694F">
				<td><font color="#FFFFFF"><strong>Estimated Crop for the Current
				season</strong></td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
							<tr>
								<td colspan="4" align="center"><b>Crop picked in
								Tonnes </b></td>
							</tr>
							<tr>
								<td colspan="2" align="center">Arabica</td>
								<td colspan="2" align="center">Robusta</td>
							</tr>
							<tr>
								<td align="center">Parachment</td>
								<td align="center">Cherry</td>
								<td align="center">Parachment</td>
								<td align="center">Cherry</td>
							</tr>
							<tr>
								<td align="center"><input type="text" name="txtparachmentarb"
									maxlenght="10" size="15" style="text-align:Left"
									value="<%=Helper.correctNull((String)hshValues.get("netitem"))%>"
									onBlur="callAverage1()"></td>
								<td align="center"><input type="text" name="txtcherryarb"
									maxlenght="10" size="15" style="text-align:Left"
									value="<%=Helper.correctNull((String)hshValues.get("netcherry1"))%>"
									onBlur="callAverage1()"></td>
								<td align="center"><input type="text" name="txtparachmentrob"
									maxlenght="10" size="15" style="text-align:Left"
									value="<%=Helper.correctNull((String)hshValues.get("netitem1"))%>"
									onBlur="callAverage1()"></td>
								<td align="center"><input type="text" name="txtcherryrob"
									maxlenght="10" size="15" style="text-align:Left"
									value="<%=Helper.correctNull((String)hshValues.get("netcherry2"))%>"
									onBlur="callAverage1()"></td>
							</tr>
						</table>
						</td>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
							<tr>
								<td colspan="4" align="center"><b>Value as per
								our Norms (Rs.)</b></td>
							</tr>
							<tr>
								<td colspan="2" align="center">Arabica</td>
								<td colspan="2" align="center">Robusta</td>
							</tr>
							<tr>
								<td  align="center">Parachment</td>
								<td align="center">Cherry</td>
								<td align="center">Parachment</td>
								<td align="center">Cherry</td>
							</tr>
							<tr>
								<%if (arryRowval != null && arryRowval.size() != 0) {
				arryColval = (ArrayList) arryRowval.get(0);

				if (arryColval.size() > 2) {

					m5 = Helper.correctNull((String) arryColval.get(2));

				}

			} else if (arryRowplant.size() == 0) {
				m5 = "";

			}

			%>

								<%if (arryRowval != null && arryRowval.size() > 2) {
				arryColval = (ArrayList) arryRowval.get(1);

				if (arryColval.size() != 0) {

					m6 = Helper.correctNull((String) arryColval.get(2));

				}

			} else if (arryRowplant.size() == 0) {
				m6 = "";

			}

			%>
								<%if (arryRowval != null && arryRowval.size() > 3) {
				arryColval = (ArrayList) arryRowval.get(2);

				if (arryColval.size() != 0) {

					m7 = Helper.correctNull((String) arryColval.get(2));

				}

			} else if (arryRowplant.size() == 0) {
				m7 = "";

			}

			%>
								<%if (arryRowval.size() != 0 && arryRowval.size() > 3) {
				arryColval = (ArrayList) arryRowval.get(3);

				if (arryColval.size() != 0) {

					m8 = Helper.correctNull((String) arryColval.get(2));

				}

			} else if (arryRowplant.size() == 0) {
				m8 = "";

			}

			%>


								<td align="center"><input type="text" name="txtparachmentarbval"
									maxlenght="10" size="15" style="text-align:Left"
									value="<%=m5%>" onBlur="callAverage1();calculateleastval()"
									onKeyPress="allowInteger()"></td>
								<td align="center"><input type="text" name="txtcherryarbval"
									maxlenght="10" size="15" style="text-align:Left"
									value="<%=m6%>" onBlur="callAverage1();calculateleastval()"
									onKeyPress="allowInteger()"></td>
								<td align="center"><input type="text" name="txtparachmentrobval"
									maxlenght="10" size="15" style="text-align:Left"
									value="<%=m7%>" onBlur="callAverage1();calculateleastval()"
									onKeyPress="allowInteger()"></td>
								<td align="center"><input type="text" name="txtcherryrobval"
									maxlenght="10" size="15" style="text-align:Left"
									value="<%=m8%>" onBlur="callAverage1();calculateleastval()"
									onKeyPress="allowInteger()"></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
					<tr>
						<td colspan="4" align="center"><b>Total Value</b></font></td>
					</tr>
					<tr>
						<td colspan="2" align="center">Arabica</font></td>
						<td colspan="2" align="center">Robusta</font></td>
					</tr>
					<tr>
						<td align="center">Parachment</font></td>
						<td align="center">Cherry</font></td>
						<td align="center">Parachment</font></td>
						<td align="center">Cherry</font></td>
					</tr>
					<tr>
						<td align="center"><input type="text"
							name="txttotparachmentarbval" maxlenght="10" size="15"
							style="text-align:Left" value=""></td>
						<td align="center"><input type="text" name="txttotcherryarbval"
							maxlenght="10" size="15" style="text-align:Left" value=""></td>
						<td align="center"><input type="text"
							name="txttotparachmentrobval" maxlenght="10" size="15"
							style="text-align:Left" value=""></td>
						<td align="center"><input type="text" name="txttotcherryrobval"
							maxlenght="10" size="15" style="text-align:Left" value=""></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr bgcolor="#71694F">

				<td><font color="#FFFFFF"><strong>Total amount for Estimated Crop
				for the Current season <font color="#FFFFFF"><strong>(Rs.) </strong></font></strong>
				<input type="text" name="txt_estimateval" maxlenght="10" size="15"
					style="text-align:left" value=""> <input type="text"
					name="txt_estimatevalper" maxlenght="10" size="15"
					style="text-align:left" value=""> <strong>(75%)(B) </strong></font></td>

			</tr>
			<tr bgcolor="#71694F">
				<td><font color="#FFFFFF"><strong>Qualifying Amount as per DCC
				Scale of Finance</strong></font></td>
			</tr>
			<tr>
				<%String measurementtype = Helper.correctNull((String) hshValues
					.get("land_measurement"));
			String measurementval = "";
			if (measurementtype.equalsIgnoreCase("c")) {

				measurementval = "Cents";
			} else {
				measurementval = "Guntas";
			}

			%>

				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
					<tr>
						<td width="11%" rowspan="2">&nbsp;</td>
						<td colspan="3" align="center">Bearing</font></td>
						<td colspan="3" align="center">Non-Bearing</font></td>
					</tr>
					<tr>
						<td align="center" width="14%">Area(ac/<font size="1"
							face="MS Sans Serif"><%=measurementval%></font>)</td>
						<td align="center" width="12%">scale of finance</td>
						<td align="center" width="12%">value(Rs.)</td>
						<td align="center" width="12%">Area(ac/<font size="1"
							face="MS Sans Serif"><%=measurementval%></font>)</td>
						<td align="center" width="18%">scale of finance</td>
						<td align="center" width="21%">value(Rs.)</td>
					</tr>
					<tr>
						<%if (arryRowplant.size() != 0) {
				arryColplant = (ArrayList) arryRowplant.get(0);

				if (arryColplant.size() != 0) {

					d3 = Helper.correctNull((String) arryColplant.get(6));
					d4 = Helper.correctNull((String) arryColplant.get(7));
					d5 = Helper.correctNull((String) arryColplant.get(8));
					d6 = Helper.correctNull((String) arryColplant.get(9));

				}

			} else if (arryRowplant.size() == 0) {
				d3 = "0";
				d4 = "0";
				d5 = "0";
				d6 = "0";

			}

			%>
						<td>Arabica</td>
						<td align="center"><input type="text" name="txt_bearingareaarb"
							maxlenght="10" size="15" style="text-align:left"
							value="<%=d3%>.<%=d4%>"
							onBlur="callEligibility();callTotal();calculateleastval()"></td>
						<td><input type="text" name="txt_bearingarbval" maxlenght="10"
							size="15" style="text-align:left"
							value="<%=Helper.correctNull((String)hshValues.get("bearing_ar_ql"))%>"
							onBlur="callEligibility();callTotal()"> <span
							onClick="show_finance()" style="cursor:hand"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span></td>
						<td align="center"><input type="text" name="txt_totbearingarbval"
							maxlenght="10" size="15" style="text-align:left" value=""></td>
						<td align="center"><input type="text" name="txt_bearingarearob"
							maxlenght="10" size="15" style="text-align:left"
							value="<%=d5%>.<%=d6%>"
							onBlur="callEligibility3();callTotal();calculateleastval()"></td>
						<td align="center"><input type="text" name="txt_bearingrobval"
							maxlenght="10" size="15" style="text-align:left"
							value="<%=Helper.correctNull((String)hshValues.get("nonbearing_ar_ql"))%>"
							onBlur="callEligibility3();callTotal()"> <span
							onClick="show_finance2()" style="cursor:hand"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span></td>
						<td align="center"><input type="text" name="txt_totbearingrobval"
							maxlenght="10" size="15" style="text-align:left" value=""></td>
					</tr>
					<tr>
						<%if (arryRowplant.size() != 0) {
				arryColplant = (ArrayList) arryRowplant.get(1);

				if (arryColplant.size() != 0) {

					d9 = Helper.correctNull((String) arryColplant.get(6));
					d10 = Helper.correctNull((String) arryColplant.get(7));
					d11 = Helper.correctNull((String) arryColplant.get(8));
					d12 = Helper.correctNull((String) arryColplant.get(9));

				}

			} else if (arryRowplant.size() == 0) {
				d9 = "0";
				d10 = "0";
				d11 = "0";
				d12 = "0";

			}

			%>
						<td>Robusta</td>
						<td align="center"><input type="text" name="txt_nonbearingareaarb"
							maxlenght="10" size="15" style="text-align:left"
							value="<%=d9%>.<%=d10%>"
							onBlur="callEligibility1();callTotal();calculateleastval()"></td>
						<td><input type="text" name="txt_nonbearingarbval" maxlenght="10"
							size="15" style="text-align:left"
							value="<%=Helper.correctNull((String)hshValues.get("bearing_rb_ql"))%>"
							onBlur="callEligibility1();callTotal()"> <span
							onClick="show_finance1()" style="cursor:hand"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span></td>
						<td align="center"><input type="text"
							name="txt_totnonbearingarbval" maxlenght="10" size="15"
							style="text-align:left" value=""></td>
						<td align="center"><input type="text" name="txt_nonbearingarearob"
							maxlenght="10" size="15" style="text-align:left"
							value="<%=d11%>.<%=d12%>"
							onBlur="callEligibility4();callTotal();calculateleastval()"></td>
						<td align="center"><input type="text" name="txt_nonbearingrobval"
							maxlenght="10" size="15" style="text-align:left"
							value="<%=Helper.correctNull((String)hshValues.get("nonbearing_rb_ql"))%>"
							onBlur="callEligibility4();callTotal()"> <span
							onClick="show_finance3()" style="cursor:hand"><img
							src="<%=ApplicationParams.getAppUrl()%>img/search_corp.gif"
							border="0"></span></td>
						<td align="center"><input type="text"
							name="txt_totnonbearingrobval" maxlenght="10" size="15"
							style="text-align:left" value=""></td>
					</tr>
				</table>
				</td>

			</tr>
			<tr>


				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr bgcolor="#71694F">
						<td width="9%"><font color="#FFFFFF"><strong>Total(Rs.) </strong></font></td>
						<td width="22%">&nbsp;</td>
						<td width="7%">&nbsp;</td>
						<td width="12%"><input type="text" name="txt_total1"
							maxlenght="10" size="15" style="text-align:left" value=""></td>
						<td width="16%">&nbsp;</td>
						<td width="14%">&nbsp;</td>
						<td width="5%">&nbsp;</td>
						<td width="15%"><input type="text" name="txt_total2"
							maxlenght="10" size="15" style="text-align:left" value=""></td>
					</tr>

					<tr bgcolor="#71694F">
						<td><font color="#FFFFFF"><strong>Total(Rs.) </strong></font></td>
						<td colspan="9" align="center"><input type="text"
							name="txt_totalqualamt" maxlenght="10" size="15"
							style="text-align:left" value=""> <font color="#FFFFFF"><strong>(C)</strong></font></td>
					</tr>
				</table>
				</td>
				</tr>
			<tr bgcolor="#71694F">

				<td><font color="#FFFFFF"><strong>Anticipated cost of cultivation</strong></font></td>

			</tr>
			<tr>

				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
					<tr>
						<td width="11%" rowspan="2">&nbsp;</td>
						<td colspan="3" align="center">Bearing</td>
						<td colspan="3" align="center">Non-Bearing</td>
					</tr>
					<tr>
						<td align="center" width="14%">Area(ac/<font size="1"
							face="MS Sans Serif"><%=measurementval%></font>)</td>
						<td align="center" width="12%">cost of cultivation(Rs.)</td>
						<td align="center" width="12%">value(Rs.)</td>
						<td align="center" width="12%">Area(ac/<font size="1"
							face="MS Sans Serif"><%=measurementval%></font>)</td>
						<td align="center" width="18%">cost of cultivation(Rs.)</td>
						<td align="center" width="21%">value(Rs.)</td>
					</tr>
					<tr>
						<%if (arryRowplant.size() != 0) {
				arryColplant = (ArrayList) arryRowplant.get(0);

				if (arryColplant.size() != 0) {

					d3 = Helper.correctNull((String) arryColplant.get(6));
					d4 = Helper.correctNull((String) arryColplant.get(7));
					d5 = Helper.correctNull((String) arryColplant.get(8));
					d6 = Helper.correctNull((String) arryColplant.get(9));

				}

			} else if (arryRowplant.size() == 0) {
				d3 = "0";
				d4 = "0";
				d5 = "0";
				d6 = "0";

			}

			%>
						<td>Arabica</td>
						<td align="center"><input type="text" name="txt_area1"
							maxlenght="10" size="15" style="text-align:left"
							value="<%=d3%>.<%=d4%>" onBlur="callcost1();callTotal()"></td>
						<td align="center"><input type="text" name="txt_cost1"
							maxlenght="10" onKeyPress="allowInteger()" size="15"
							style="text-align:left"
							value="<%=Helper.correctNull((String)hshValues.get("bearing_ar_an"))%>"
							onBlur="callcost1();callTotal();calculateleastval()"></td>
						<td align="center"><input type="text" name="txt_totcost1"
							maxlenght="10" onKeyPress="allowInteger()" size="15"
							style="text-align:left" value=""></td>
						<td align="center"><input type="text" name="txt_area2"
							maxlenght="10" size="15" style="text-align:left"
							value="<%=d5%>.<%=d6%>" onBlur="callcost2();callTotal()"></td>
						<td align="center"><input type="text" name="txt_cost2"
							maxlenght="10" onKeyPress="allowInteger()" size="15"
							style="text-align:left"
							value="<%=Helper.correctNull((String)hshValues.get("nonbearing_ar_an"))%>"
							onBlur="callcost2();callTotal();calculateleastval()"></td>
						<td align="center"><input type="text" name="txt_totcost2"
							maxlenght="10" size="15" style="text-align:left" value=""></td>
					</tr>
					<tr>
						<%if (arryRowplant.size() != 0) {
				arryColplant = (ArrayList) arryRowplant.get(1);

				if (arryColplant.size() != 0) {

					d9 = Helper.correctNull((String) arryColplant.get(6));
					d10 = Helper.correctNull((String) arryColplant.get(7));
					d11 = Helper.correctNull((String) arryColplant.get(8));
					d12 = Helper.correctNull((String) arryColplant.get(9));

				}

			} else if (arryRowplant.size() == 0) {
				d9 = "0";
				d10 = "0";
				d11 = "0";
				d12 = "0";

			}

			%>
						<td>Robusta</td>
						<td align="center"><input type="text" name="txt_area3"
							maxlenght="10" size="15" style="text-align:left"
							value="<%=d9%>.<%=d10%>" onBlur="callcost3();callTotal()"></td>
						<td align="center"><input type="text" name="txt_cost3"
							maxlenght="10" onKeyPress="allowInteger()" size="15"
							style="text-align:left"
							value="<%=Helper.correctNull((String)hshValues.get("bearing_rb_an"))%>"
							onBlur="callcost3();callTotal();calculateleastval()"></td>
						<td align="center"><input type="text" name="txt_totcost3"
							maxlenght="10" size="15" style="text-align:left" value=""></td>
						<td align="center"><input type="text" name="txt_area4"
							maxlenght="10" size="15" style="text-align:left"
							value="<%=d11%>.<%=d12%>" onBlur="callcost4();callTotal()"></td>
						<td align="center"><input type="text" name="txt_cost4"
							maxlenght="10" onKeyPress="allowInteger()" size="15"
							style="text-align:left"
							value="<%=Helper.correctNull((String)hshValues.get("nonbearing_rb_an"))%>"
							onBlur="callcost4();callTotal();calculateleastval()"></td>
						<td align="center"><input type="text" name="txt_totcost4"
							maxlenght="10" size="15" style="text-align:left" value=""></td>
					</tr>
				</table>
				</td>

			</tr>
			<tr>

				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr bgcolor="#71694F">
						<td width="14%"><font color="#FFFFFF"><strong>Total(Rs.) </strong></font></td>
						<td width="14%">&nbsp;</td>
						<td width="10%">&nbsp;</td>
						<td width="17%"><input type="text" name="txt_total3"
							maxlenght="10" size="15" style="text-align:left" value=""></td>
						<td width="16%">&nbsp;</td>
						<td width="14%">&nbsp;</td>
						<td width="15%"><input type="text" name="txt_total4"
							maxlenght="10" size="15" style="text-align:left" value=""></td>
					</tr>
					<tr bgcolor="#71694F">
						<td><font color="#FFFFFF"><strong>Total (Rs.) </strong></font></td>
						<td colspan="6" align="center"><input type="text"
							name="txt_totalantamt" maxlenght="10" size="15"
							style="text-align:left" value=""> <font color="#FFFFFF"><strong>(D)</strong></font>
						</td>
					</tr>
					<tr bgcolor="#71694F">
						<td><font color="#FFFFFF"><strong>Amount Requested </strong></font></td>
						<td colspan="6"><font color="#FFFFFF"><strong> <input type="text"
							name="txt_loanamount" maxlenght="10" onBlur="calculateleastval()"
							size="15" style="text-align:left"
							value="<%=Helper.correctNull((String)hshValues.get("coffee_loanamount"))%>">
						<font color="#FFFFFF"><strong>(E)</strong></font> </strong></font></td>
					</tr>
				</table>
				</td>

			</tr>
			<tr bgcolor="#71694F">
				<td><font color="#FFFFFF"><strong>Least Amount of the A,B,C ,D
				&amp; E (Rs.) <input type="text" name="txt_leastamount"
					maxlenght="10" size="15" style="text-align:left"
					value="<%=Helper.correctNull((String)hshValues.get("coffee_leastamt"))%>">
				</strong></font></td>

			</tr>
		</table>


<lapschoice:combutton btntype="EO" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>

</td>
	</tr>
</table>
<lapschoice:agrihiddentag /></form>
</body>
</html>
