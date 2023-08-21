<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />
<%
ArrayList arryCol = null;
			ArrayList arryRow = (ArrayList) hshValues.get("arryRow");
			double totaccountbal = 0.00;
		String appstatus= Helper.correctNull((String)session.getAttribute("appstatus"));
%>
<html>
<head>
<title>Personal - Financial Bank Accounts</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>

<script language="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/per/perfinancialbnkacc.js"></script>

<script language="JavaScript">
var varAcctype=new Array();
var varApptype=new Array();
var varchkClick=new Array();
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
var strvalue="loan_appretail_fin_bankacc.htm";

<%
for(int i=1;i<10;i++)
{
	if(arryRow!=null && arryRow.size()>=i)
	{
		arryCol=(ArrayList)arryRow.get(i-1);
		if(arryCol!=null)
		{																				
		%>  
			varAcctype["<%=i-1%>"]="<%=Helper.correctNull((String)arryCol.get(5))%>";
			varApptype["<%=i-1%>"]="<%=Helper.correctNull((String)arryCol.get(1))%>";
			varchkClick["<%=i-1%>"]="<%=Helper.correctNull((String)arryCol.get(7))%>";
		<%
		}
	}
}
%>


function assignData()
{

try
{
 for(var i=0;i<document.forms[0].chobank_apptype.length;i++)
 {
      document.forms[0].hid_chobank_apptype[i].value=document.forms[0].chobank_apptype[i].options[document.forms[0].chobank_apptype[i].selectedIndex].text;
 }
 }
 catch(err){
     document.forms[0].hid_chobank_apptype.value=document.forms[0].chobank_apptype.options[document.forms[0].chobank_apptype.selectedIndex].text;
 }
}
</SCRIPT>
</head>
<body bgcolor="#EEEAE3" leftmargin="0" topmargin="0" marginwidth="0" margin onload="callOnload()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()"> 
  <div class="menuitems" url="">
   <script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div>
  </div>
<form name="frmfinbank" action="" method="post">
<table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
	<tr>
		<td id="mainlnk" colspan="2"><jsp:include
			page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="3" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		
      <td><font face="Times New Roman" size="3"><b><i>Home -&gt; Retail -&gt; 
        <%=(String) session.getAttribute("pgeLabel")%> -&gt; Credit Information 
        -&gt; </i></b></font><font
					face="Times New Roman" size="3"><b><i>Saving/Current Account 
        maintained with Banks</i></b></font></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
	<tr>
		<td id="mainlnk" colspan="2"><lapschoice:application /></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="90%" valign="bottom">
		<table width="100%" border="0" cellspacing="3" cellpadding="3"
			align="left">
			<tr>
				
            <td width="20%" align="center" bgcolor="#71694F"><font
					face="MS Sans Serif" size="1"><b><font color="#FFFFFF">Saving/Current 
              Account maintained with Banks</font></b></font></td>
				
            <td width="20%" align="center" bgcolor="#EEEAE3"><b><font size="1"
					face="MS Sans Serif"><a href="JavaScript:callInvestment()"
					class="blackfont">Investments/Term Deposits</a></font></b></td>
				<td width="15%" align="center" bgcolor="#EEEAE3" class="blackfont"><b><font
					size="1" face="MS Sans Serif"><a
					href="JavaScript:callInsurancePolicy()" class="blackfont">Insurance
				Policies</a></font></b></td>
				<td width="20%" align="center" bgcolor="#EEEAE3"><b><font size="1"
					face="MS Sans Serif"><a href="JavaScript:callPersonalProp()"
					class="blackfont">Movable/Immovable Assets</a></font></b></td>
				<td width="10%" align="center" bgcolor="#EEEAE3"><b><font size="1"
					face="MS Sans Serif"><a href="JavaScript:callLiabilities()"
					class="blackfont">Liabilities</a></font></b></td>
				<td width="7%" align="center" bgcolor="#EEEAE3"><b><font size="1"
					face="MS Sans Serif"><a href="JavaScript:callLifeStyle()"
					class="blackfont">LifeStyle</a></font></b></td>
				<td width="8%" align="center" bgcolor="#EEEAE3" nowrap><b><font
					size="1" face="MS Sans Serif"><a href="JavaScript:callNetworth()"
					class="blackfont">Net Worth</a></font></b></td>
			</tr>
		</table>
		</td>
		<td width="10%">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="1" cellspacing="0" cellpadding="5"
	height="240" bordercolorlight="#8F8369"
	bordercolordark="#FFFFFB">
	<tr>
		<td valign="top">
		<table width="97.3%" border="0" cellspacing="0" cellpadding="0"
			height="100%">
			<tr>
				<td>
				<table width="98.3%" border="1" cellspacing="0" cellpadding="5"
					height="95%" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
					<tr>
						<td valign="top" align="left"><font color="#CC0000" face="MS Sans Serif"
							size="1">
						Enter Financial details in order. Do not leave any blank lines
						between entries </font>
						<table width="100%" border="1" cellspacing="0" cellpadding="4"
							bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3">
									<tr>
										<td ><font size="1" face="MS Sans Serif"><b>Details
										of Bank Accounts </b></font><font color="#CC0000"
											face="MS Sans Serif" size="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font><font
											color="#FFFFFF"><font size="1" face="MS Sans Serif"
											color="#CC0000">All values are in <%=ApplicationParams.getCurrency()%></font></font></td>
									</tr>
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											bordercolorlight="#EBEBF8" bordercolordark="#82829F">
											<tr valign="top">
												<td colspan="7">
												<table width="100%" border="1" cellspacing="0"
													cellpadding="3" bordercolorlight="#8F8369"
													bordercolordark="#FFFFFB">
													<tr align="center">
														<td width="23%" bgcolor="#71694F"><font size="1"
															face="MS Sans Serif" color="#FFFFFF">Bank/Branch Name &amp;
														Telephone No.</font></td>
														<td width="10%" bgcolor="#71694F"><font size="1"
															face="MS Sans Serif" color="#FFFFFF"> Opened On</font></td>
														<td width="8%" bgcolor="#71694F"><font size="1"
															face="MS Sans Serif" color="#FFFFFF">Type of Account</font></td>
														<td width="7%" bgcolor="#71694F"><font size="1"
															face="MS Sans Serif" color="#FFFFFF">Account Number </font></td>
														<td width="13%" bgcolor="#71694F"><font size="1"
															face="MS Sans Serif" color="#FFFFFF">Account Balance </font></td>
														<td width="10%" bgcolor="#71694F"><font size="1"
															face="MS Sans Serif" color="#FFFFFF">Average Balance &amp;
														Remarks </font></td>
														<td width="23%" bgcolor="#71694F"><font size="1"
															face="MS Sans Serif" color="#FFFFFF">Applicant Type </font></td>
														<td width="6%" bgcolor="#71694F"><font size="1"
															face="MS Sans Serif" color="#FFFFFF">Collateral</font></td>
													</tr>
													<%for (int i = 1; i < 9; i++) {
				if (arryRow != null && arryRow.size() >= i) {
					arryCol = (ArrayList) arryRow.get(i - 1);
					if (arryCol != null) {
						totaccountbal = totaccountbal
								+ Double.parseDouble((String) Helper
										.correctNull((String) arryCol.get(6)));

						%>
													<tr>
														<td><input type="text"
															name="txtbank_name" size="45" 
															maxlength="45"
															value="<%=Helper.correctNull((String)arryCol.get(3))%>"
															onKeyPress="notAllowSingleQuote()"></td>
														<td>
														<table width="55%" border="0" cellspacing="0"
															cellpadding="0">
															<tr>
																<td width="75%"><font size="1" face="MS Sans Serif"> <input
																	type="text" name="txtbank_branchname" size="11"
																	maxlength="11" tabindex="7"
																	value="<%=Helper.correctNull((String)arryCol.get(9))%>"
																	onBlur="checkDate(this);checkmaxdate(this,currentDate)"> </font></td>
																<td align="left" width="25%"><font size="1"
																	face="MS Sans Serif"><a alt="Select date from calender"
																	href="#"
																	onClick="callCalender('txtbank_branchname[<%=i-1%>]')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;">&nbsp;<img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border=0 alt="Select date from calender"></a></font></td>
															</tr>
														</table>
														</td>
														<td><select
															name="chobank_accnttype" style="width:95"
															onchange="chkCollateral(this,document.forms[0].chkbank_iscoll[<%=i-1%>])">
															<option value="s">--Select--</option>
															<option value="AI">Current</option>
															<!-- <option value="AD">Fixed Deposit</option>
															<option value="AC">Cumulative Deposit</option> -->
															<option value="AS">Savings</option>
															<!-- <option value="AM">Recurring Deposit</option> -->
														</select></td>
														<td><input type="text"
															name="txtbank_accntno" size="18"
															style="text-align:left" maxlength="15"
															value="<%=Helper.correctNull((String)arryCol.get(4))%>"
															onKeyPress="notAllowSingleQuote()"></td>
														<td >
														<lapschoice:CurrencyTag name="txtbank_balance" size="18" maxlength="10" 
																 value='<%=Helper.correctNull((String)arryCol.get(6))%>'/>
															
														</td>
														<td ><textarea
															name="remarks" cols="15" rows="2" wrap="VIRTUAL" onKeyPress="textlimit(this,40)" onKeyUp="textlimit(this,40)"><%=Helper.correctNull((String) arryCol.get(8))%></textarea>
														</td>
														<td ><select
															name="chobank_apptype"
															onChange="checkApplicant(<%=i-1%>)" style="width:120">
															<option value="s1">--Select--</option>
															<lapschoice:fincoappguarantor />
														</select>
														<input type="hidden" name="hid_chobank_apptype">
														</td>
														<td  align="center"><input type="checkbox"
															name="chkbank_iscoll" value="Y" style="border-style:none"
															onClick="checkValues(<%=i-1%>)">
															
															</td>
													</tr>
													<input type="hidden" name="hidbank_iscoll" />
													<%}
				} else {

					%>
													<tr>
														
                                          <td >
                                            <input type="text"
															name="txtbank_name" size="45" 
															maxlength="45" value=""
															onKeyPress="notAllowSingleQuote()">
                                          </td>
														<td >
														<table width="55%" border="0" cellspacing="0"
															cellpadding="0">
															<tr>
																<td width="75%"><font size="1" face="MS Sans Serif"> <input
																	type="text" name="txtbank_branchname" size="11"
																	maxlength="11" tabindex="7" value=""
																	onBlur="checkDate(this);checkmaxdate(this,currentDate)"> </font></td>
																<td align="left" width="25%"><font size="1"
																	face="MS Sans Serif"><a alt="Select date from calender"
																	href="#"
																	onClick="callCalender('txtbank_branchname[<%=i-1%>]')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;">&nbsp;<img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border=0 alt="Select date from calender"></a></font></td>
															</tr>
														</table>
														</td>
														<td ><select
															name="chobank_accnttype" style="width:95"
															onchange="chkCollateral(this,document.forms[0].chkbank_iscoll[<%=i-1%>])">
															<option value="s">--Select--</option>
															<option value="AI">Current</option>
															<!-- <option value="AD">Fixed Deposit</option>
															<option value="AC">Cumulative Deposit</option>-->
															<option value="AS">Savings</option>
															<!-- <option value="AM">Recurring Deposit</option>-->
														</select></td>
														<td ><input type="text"
															name="txtbank_accntno" size="18"
															style="text-align:left" maxlength="15" value=""
															onKeyPress="notAllowSingleQuote()"></td>
														<td >
														<lapschoice:CurrencyTag name="txtbank_balance" size="18" maxlength="10" 
																 />
														</td>
														<td ><textarea
															name="remarks" cols="15" rows="2" wrap="VIRTUAL" onKeyPress="textlimit(this,40)" onKeyUp="textlimit(this,40)"></textarea>
														</td>
														<td ><select
															name="chobank_apptype"
															onChange="checkApplicant(<%=i-1%>)" style="width:120">
															<option value="s1">--Select--</option>
															<lapschoice:fincoappguarantor />
														</select>
															<input type="hidden" name="hid_chobank_apptype">
														</td>
														<td  align="center"><input type="checkbox"
															name="chkbank_iscoll" value="Y" style="border-style:none"
															onClick="checkValues(<%=i-1%>)"></td>
													</tr>
													<input type="hidden" name="hidbank_iscoll"/>
													<%}//end of else
			}//end of for statement

			%>
													<tr>
														<td align="center"><b><font size="1"
															face="MS Sans Serif">TOTAL</font></b></td>
														<td >&nbsp;</td>
														<td >&nbsp;</td>
														<td>&nbsp;</td>
														<td align="right"><b><font size="1"
															face="MS Sans Serif"><%=Helper.roundVal(Double.toString(totaccountbal))%>
														</font></b></td>
														<td >&nbsp;</td>
														<td >&nbsp;</td>
														<td>&nbsp;</td>
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
<lapschoice:combutton btntype="EO" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag/>
	<INPUT TYPE="hidden" name="hidAppType"> 
	<INPUT TYPE="hidden" name="radLoan" value="Y">  
	<input type="hidden" name="chkbank_iscoll">
<%--	
<INPUT TYPE="hidden" name="hidDemoId" value="<%=request.getParameter("hidDemoId")%>"> 
<input type="hidden" name="hidappno" value="<%=(String)request.getParameter("appno")%>"> 
 --%>
</form>
</body>
</html>


