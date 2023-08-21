<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>

<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%//out.println("aaaaaaa "+hshValues);
			ArrayList arryCol = null;
			ArrayList arryRow = (ArrayList) hshValues.get("arryRow");
			double totpurchaseprice = 0.00;
			double totmarketvalue = 0.00;
%>
<html>
<head>
<title>Personal - Financial Movable/Immovable Assets</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<STYLE>
DIV.cellContainer {	
  width: 100%; height: 200;
  overflow: auto;
}
</STYLE>

<link rel="stylesheet" href="../htm/link.css" type="text/css">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/per/perfinancialperpro.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>

<SCRIPT language="JavaScript">
var varApptype  = new Array();
var varchkClick = new Array();
var varCharged  = new Array();
var varAssetType  = new Array();
var varLeasedOwned  = new Array();
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var strvalue="loan_appretail_fin_persprop.htm";

<%
for(int i=1;i<13;i++)
{
	if(arryRow!=null && arryRow.size()>=i)
	{
		arryCol=(ArrayList)arryRow.get(i-1);
		if(arryCol!=null)
		{															
%>  
			varApptype["<%=i-1%>"]="<%=Helper.correctNull((String)arryCol.get(1))%>";
			varchkClick["<%=i-1%>"]="<%=Helper.correctNull((String)arryCol.get(6))%>";
			varCharged["<%=i-1%>"]="<%=Helper.correctNull((String)arryCol.get(9))%>";
			varAssetType["<%=i-1%>"]="<%=Helper.correctNull((String)arryCol.get(10))%>";
			varLeasedOwned["<%=i-1%>"]="<%=Helper.correctNull((String)arryCol.get(11))%>";
<%
			}
		}
}
%>

/*function callPropDtls()
{
	var strappno= "<%//=request.getParameter("appno")%>";
	window.open(appURL+"action/perpropertydetails.jsp?appno="+strappno,"PropertyDetails","scrollbars=no,toolbars=No,menubar=no,width=550,height=500,top=10,left=10");
}*/


function checkFileDate(obj,i)
{
	var pagedate = obj.value;
	var pgdt = pagedate.substring(0,2);
	var pgmon = pagedate.substring(3,5);
	var pgyr = pagedate.substring(6,10);
	var objdate = pgmon+"/"+pgdt+"/"+pgyr;	
	var currdate = currentDate;
	var crdt = currdate.substring(0,2);
	var crmon = currdate.substring(3,5);
	var cryr = currdate.substring(6,10);
	var curdate = crmon+"/"+crdt+"/"+cryr;
	
	if (Date.parse(objdate) > Date.parse(curdate))
	{
		alert("Valuation Date cannot be greater than Current Date");
		obj.value="";
		document.forms[0].txtprop_valuationdate[i].focus();
		return;
	}
}

function assignData()
{

  try
  {
   for(var i=0;i<document.forms[0].choprop_applnt.length;i++)
   {
   document.forms[0].hid_choprop_applnt[i].value=document.forms[0].choprop_applnt[i].options[document.forms[0].choprop_applnt[i].selectedIndex].text;
    document.forms[0].hid_txtprop_assettype[i].value=document.forms[0].txtprop_assettype[i].options[document.forms[0].txtprop_assettype[i].selectedIndex].text;
   }
  }
  catch(er)
  {
 document.forms[0].hid_choprop_applnt.value=document.forms[0].choprop_applnt.options[document.forms[0].choprop_applnt.selectedIndex].text;
 document.forms[0].hid_txtprop_assettype.value=document.forms[0].txtprop_assettype.options[document.forms[0].txtprop_assettype.selectedIndex].text;
 }
 
}

function disableCheckBox(condition)
{
   try{
   for(var i=0;i<document.forms[0].choprop_applnt.length;i++)
   {
     document.forms[0].chkprop_iscoll[i].disabled=condition;
   }
   }
   catch(rr)
   {
        document.forms[0].chkprop_iscoll.disabled=condition;
   
   }

}
</SCRIPT>
<link rel="stylesheet"
	ahref="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body onload="callOnload()">
<form name="frmfinprop" method="post">
<table width="100%" border="1" cellspacing="0" cellpadding="0"
	bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
	<tr>
		<td id="mainlnk" colspan="2"><jsp:include
			page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="3" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>

		<td><font face="Times New Roman" size="3"><b><i>Home -&gt; Existing
		-&gt; <%=(String) session.getAttribute("pgeLabel")%> -&gt; Credit
		Information -&gt; Movable/Immovable Assets </i></b></font></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
	<tr>
		<td id="mainlnk" colspan="2"><lapschoice:application /></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	bgcolor="#DEDACF">
	<tr>
		<td width="70%" valign="bottom">
		<table width="100%" border="0" cellspacing="3" cellpadding="3"
			align="left">
			<tr>
				<%-- <td width="20%" align="center" bgcolor="#EEEAE3"><b><a
					href="JavaScript:callBankAccounts()" class="blackfont">Saving/Current 
              Account maintained with Banks</a></b></td>--%>
				<td width="25%" align="center" bgcolor="#EEEAE3"><b><a
					href="JavaScript:callInvestment()" class="blackfont">Investments/Term
				Deposits</a></b></td>
				<td width="20%" align="center" bgcolor="#EEEAE3"><b><a
					href="JavaScript:callInsurancePolicy()" class="blackfont">Insurance
				Policies</a></b></td>
				<td width="25%" align="center" bgcolor="#71694F" nowrap><b><font
					color="#FFFFFF">Movable/Immovable Assets </b></td>
				<td width="10%" align="center" bgcolor="#EEEAE3"><b><a
					href="JavaScript:callLiabilities()" class="blackfont">Liabilities</a></b></td>
				<td width="10%" align="center" bgcolor="#EEEAE3"><b><a
					href="JavaScript:callLifeStyle()" class="blackfont">LifeStyle</a></b></td>
				<%-- <td width="8%" align="center" bgcolor="#EEEAE3" nowrap><b><font
					 ><a href="JavaScript:callNetworth()"
					class="blackfont">Net Worth</a></font></b></td>--%>
			</tr>
		</table>
		</td>
		<td width="30%">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="1" cellspacing="0" cellpadding="5"
	height="380" bordercolorlight="#8F8369"
	bordercolordark="#FFFFFB">
	<tr>
		<td valign="top">
		<div align="left"></div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			height="100%">
			<tr>
				<td>
				<table width="100%" border="1" cellspacing="0" cellpadding="3"
					height="100%" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="2">
							<tr>
								<td width='75%' height='23'><font color="#CC0000">Enter
								Financial details in order. Do not leave any blank lines between
								entries </font> <%-- <input
									type="hidden" name="cmdLife" value="Life Style"
									style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:100"
									onClick="callLifeStyle()"> 
									<!-- <input type="button" name="cmdProp"
									value="Proposed Assets"
									style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:100"
									onClick="callPropDtls()">
									--%></td>
								<td><font color="#CC0000">All values are in <%=ApplicationParams.getCurrency()%>
								</font></td>
							</tr>
						</table>

						<table width="100%" border="1" cellspacing="0" cellpadding="0"
							bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="3"
											bordercolorlight="#EBEBF8" bordercolordark="#82829F">
											<tr>
												<td colspan="7">
												<table width="100%" border="1" cellspacing="0"
													cellpadding="3" bordercolorlight="#8F8369"
													bordercolordark="#FFFFFB">
													<tr align="center">
														<td width="23%" height="20" bgcolor="#71694F"><font
															color="#FFFFFF">Description / Address Details</font></td>
														<td width="21%" height="20" bgcolor="#71694F"><font
															color="#FFFFFF">Purchase Value </font></td>
														<td width="21%" height="20" bgcolor="#71694F"><font
															color="#FFFFFF">Present Value/Market Value </font></td>
														<td width="20%" height="20" bgcolor="#71694F"><font
															color="#FFFFFF">Valuation Date </font></td>
														<td width="20%" height="20" bgcolor="#71694F"><font
															color="#FFFFFF">Valuation done by</font></td>
														<td width="20%" height="20" bgcolor="#71694F"><font
															color="#FFFFFF">whether leaseholder or ownership </font></td>
														<td width="20%" height="20" bgcolor="#71694F"><font
															color="#FFFFFF">&nbsp;Applicant Type </font></td>
														<td width="10%" height="20" bgcolor="#71694F"><font
															color="#FFFFFF">Already Charged</font></td>
														<td width="10%" height="20" bgcolor="#71694F"><font
															color="#FFFFFF"> Asset Type</font></td>
														<td width="15%" height="20" bgcolor="#71694F"><font
															color="#FFFFFF">&nbsp;Collateral.</font></td>
													</tr>
													<%for (int i = 1; i < 13; i++) {
				if (arryRow != null && arryRow.size() >= i) {
					arryCol = (ArrayList) arryRow.get(i - 1);
					if (arryCol != null) {
						totpurchaseprice = totpurchaseprice
								+ Double.parseDouble((String) Helper
										.correctNull((String) arryCol.get(4)));
						totmarketvalue = totmarketvalue
								+ Double.parseDouble((String) Helper
										.correctNull((String) arryCol.get(5)));

						%>
													<tr>
														<td width="23%" align="left"><%--<input
															type="text" name="txtprop_desc" size="50"
															 maxlength="40"
															value="<%=Helper.correctNull((String)arryCol.get(3))%>"
															onKeyPress="notAllowSingleQuote()"> --%> <textarea
															name="txtprop_desc" cols="20" rows="3" wrap="VIRTUAL"
															onKeyPress="textlimit(this,40)"><%=Helper.correctNull((String) arryCol.get(3))%></textarea>

														</td>
														<td width="21%" align="center"><lapschoice:CurrencyTag
															name="txtprop_purchaseval" size="16" maxlength="12"
															value='<%=Helper.correctNull((String)arryCol.get(4))%>' />

														</td>
														<td width="21%" align="center"><lapschoice:CurrencyTag
															name="txtprop_marketval" size="16" maxlength="12"
															value='<%=Helper.correctNull((String)arryCol.get(5))%>' />
														</td>
														<%String strTemp = "";
						strTemp = Helper.correctNull((String) arryCol.get(7));

						%>

														<td width="20%" align="center">
														<table width="100%" border="0" cellspacing="0"
															cellpadding="0">
															<tr>
																<td><input type="text" name="txtprop_valuationdate"
																	size="12" value="<%=strTemp%>" style="text-align:right"
																	onBlur="checkDate(this);checkFileDate(this,<%=i-1 %>)"
																	maxlength="10"></td>
																<td><a
																	alt="Select date from calender" href="#"
																	onClick="callCalender('txtprop_valuationdate[<%=i-1%>]')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;">&nbsp;<img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border=0 alt="Select date from calender"></a></td>
															</tr>
														</table>

														</td>
														<td width="20%" align="left"><input type="text"
															name="txtprop_valuationdoneby" size="30"
															style="text-align:left" maxlength="25"
															value="<%=Helper.correctNull((String)arryCol.get(8))%>"
															onKeyPress="notAllowSingleQuote()"></td>
														<td width="20%" align="left"><select
															name="txtpro_whether_leased">
															<option value="s">--Select--</option>
															<option value="0">LEASED</option>
															<option value="1">OWNED</option>
														</select></td>
														<td width="20%" align="center"><select
															name="choprop_applnt" style=width:70>
															<option value="s1">--Select--</option>
															<lapschoice:fincoappguarantor />
														</select> <input type="hidden" name="hid_choprop_applnt">
														</td>
														<td width="20%" align="center"><select
															name="txtprop_charged">
															<option value="s2">--Select--</option>
															<option value="Y">Yes</option>
															<option value="N">No</option>
														</select></td>

														<td width="20%" align="center"><select
															name="txtprop_assettype" style=width:160>
															<option value="s3">--Select--</option>
															<option value="M">Movable</option>
															<option value="2">House Building</option>
															<option value="3">Land in Metro/Urban</option>
															<option value="4">Land in Rural</option>
															<option value="5">Agricultural Land</option>
															<option value="6">Plough cattle</option>
															<option value="7">Milch Cattle</option>
															<option value="8">Poultry birds</option>
															<option value="9">Oil Engine/Electric/Motor/Pumpsets</option>
															<option value="10">Power tiller</option>
															<option value="11">Tractor</option>
															<option value="12">Transport Vehicles</option>
															<option value="13">Other Implements</option>
															<option value="14">commercial property</option>
															<option value="15">Tractor shed/farm shed</option>
															<option value="16">Fishing ponds/tank</option>
														</select> <input type="hidden"
															name="hid_txtprop_assettype"></td>

														<td width="15%" align="center"><input type="checkbox"
															name="chkprop_iscoll" value="Y" style="border-style:none"
															onClick="checkValues(<%=i-1%>)"></td>
													</tr>
													<INPUT TYPE="hidden" name="hidprop_iscoll">
													<%}
				} else {

					%>
													<tr>

														<td width="23%"><!-- <input type="text" name="txtprop_desc"
															size="50"  maxlength="40"
															onKeyPress="notAllowSingleQuote()">--> <textarea
															name="txtprop_desc" cols="20" rows="3" wrap="VIRTUAL"
															onKeyPress="textlimit(this,40)"></textarea></td>
														<td width="21%" align="center"><lapschoice:CurrencyTag
															name="txtprop_purchaseval" size="16" maxlength="12" />
														</td>
														<td width="21%" align="center"><lapschoice:CurrencyTag
															name="txtprop_marketval" size="16" maxlength="12" />
														</td>

														<td width="20%" align="center">
														<table width="100%" border="0" cellspacing="0"
															cellpadding="0">
															<tr>
																<td><input type="text" name="txtprop_valuationdate"
																	size="12" value="" style="text-align:right"
																	onBlur="checkDate(this);checkFileDate(this,<%=i-1 %>)"
																	maxlength="10"></td>
																<td><a
																	alt="Select date from calender" href="#"
																	onClick="callCalender('txtprop_valuationdate[<%=i-1%>]')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;">&nbsp;<img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border=0 alt="Select date from calender"></a></td>
															</tr>
														</table>

														</td>
														<td width="20%" align="left"><input type="text"
															name="txtprop_valuationdoneby" size="30"
															style="text-align:left" maxlength="25"
															onKeyPress="notAllowSingleQuote()"></td>
														<td width="20%" align="left"><select
															name="txtpro_whether_leased">
															<option value="s">--Select--</option>
															<option value="0">LEASED</option>
															<option value="1">OWNED</option>
														</select></td>
														<td width="20%" align="center"><select
															name="choprop_applnt" style="width:70">
															<option value="s1">--Select--</option>
															<lapschoice:fincoappguarantor />
														</select> <input type="hidden" name="hid_choprop_applnt"></td>
														<td width="20%" align="center"><select
															name="txtprop_charged">
															<option value="s2">--Select--</option>
															<option value="Y">Yes</option>
															<option value="N">No</option>
														</select></td>
														<td width="20%" align="center"><select
															name="txtprop_assettype" style=width:160>
															<option value="s3">--Select--</option>
															<option value="M">Movable</option>
															<option value="2">House Building</option>
															<option value="3">Land in Metro/Urban</option>
															<option value="4">Land in Rural</option>
															<option value="5">Agricultural Land</option>
															<option value="6">Plough cattle</option>
															<option value="7">Milch Cattle</option>
															<option value="8">Poultry birds</option>
															<option value="9">Oil Engine/Electric/Motor/Pumpsets</option>
															<option value="10">Power tiller</option>
															<option value="11">Tractor</option>
															<option value="12">Transport Vehicles</option>
															<option value="13">Other Implements</option>
															<option value="14">commercial property</option>
															<option value="15">Tractor shed/farm shed</option>
															<option value="16">Fishing ponds/tank</option>

														</select><input type="hidden" name="hid_txtprop_assettype"></td>

														<td width="15%" align="center"><input type="checkbox"
															name="chkprop_iscoll" value="Y" style="border-style:none"
															onClick="checkValues(<%=i-1%>)"></td>
													</tr>
													<INPUT TYPE="hidden" name="hidprop_iscoll">
													<%}

			}

			%>
													<tr>
														<td width="23%" align="center">&nbsp;<b>TOTAL</b></td>
														<td width="21%" align="right"><b><%=Helper.roundVal(Double.toString(totpurchaseprice))%></b></td>
														<td width="21%" align="right"><b><%=Helper.roundVal(Double.toString(totmarketvalue))%></b></td>
														<td width="20%" align="right">&nbsp;</td>
														<td width="20%">&nbsp;</td>
														<td width="20%">&nbsp;</td>
														<td width="20%">&nbsp;</td>
														<td width="15%">&nbsp;</td>
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
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
 <lapschoice:combutton
	btntype="EO"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag />  <INPUT TYPE="hidden"
	name="hidAppType"> <INPUT TYPE="hidden" name="radLoan" value="Y"> 
<%-- 
<INPUT TYPE="hidden" name="hidDemoId" value="<%=request.getParameter("hidDemoId")%>">
<input type="hidden" name="hidappno" value="<%=(String)request.getParameter("appno")%>">
--%>
</form>
</body>
</html>

