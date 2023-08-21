<%@include file="../share/directives.jsp"%>
<%ArrayList vec = new ArrayList();
			ArrayList vecrec = new ArrayList();
			int vecsize = 0;
			int vecrecsize = 0;
			if (hshValues != null) {
				vec = (ArrayList) hshValues.get("vecData");
				vecrec = (ArrayList) hshValues.get("vecData2");
			}
			if (vecrec != null) {
				vecsize = vec.size();
			}
			if (vecrec != null) {
				vecrecsize = vecrec.size();
			}
			ArrayList g1 = new ArrayList();
			ArrayList g2 = new ArrayList();
			ArrayList vecgua = new ArrayList();
			vecgua = (ArrayList) hshValues.get("vecReport12");

			String prd_type = Helper.correctNull((String) session
					.getAttribute("strProductType"));
			String sel_payment = Helper.correctNull((String) hshValues
					.get("loan_periodicity"));

			%>
<%String loanrepaydate = "0";
			String duedate = "";
			String installment = Helper.correctInt((String) hshValues
					.get("loan_noofinstallment"));
			duedate = Helper.correctNull((String) hshValues.get("txt_date"));
			if (duedate.equalsIgnoreCase("")) {
				int x = 0;

				if (sel_payment.equalsIgnoreCase("m")) {
					x = Integer.parseInt(installment) + 1;

				} else if (sel_payment.equalsIgnoreCase("q")) {
					x = Integer.parseInt(installment) + 3;
				} else if (sel_payment.equalsIgnoreCase("h")) {
					x = Integer.parseInt(installment) + 6;
				} else if (sel_payment.equalsIgnoreCase("y")) {
					x = Integer.parseInt(installment) + 12;
				}

				//  String pdate = Helper.correctNull((String)hshValues.get("app_processdate"));
				String pdate = Helper.correctNull((String) hshValues
						.get("loanfiledon"));

				if (!pdate.equalsIgnoreCase("")) {
					int pdays = Integer.parseInt(pdate.substring(0, 2));
					int pdays1 = pdays;
					int leaps = 0;
					int pmonths = Integer.parseInt(pdate.substring(3, 5));

					int pyears = Integer.parseInt(pdate.substring(6, 10));

					pmonths = pmonths + x;

					if (pmonths > 12) {
						int tempyear = pmonths / 12;

						pmonths = pmonths % 12;
						if (pmonths == 0) {
							pmonths = 12;
							tempyear--;
						}
						pyears = pyears + tempyear;
					}

					if (pmonths == 1 || pmonths == 3 || pmonths == 5
							|| pmonths == 7 || pmonths == 8 || pmonths == 10
							|| pmonths == 12) {

						if (pdays == 31) {
							pdays = pdays + 0;
							pdays1 = 31;
						} else {
							pdays1 = pdays;
						}

					} else if (pmonths == 4 || pmonths == 6 || pmonths == 9
							|| pmonths == 11) {
						if (pdays == 31 || pdays1 == 30) {
							pdays = pdays + 0;
							pdays1 = 30;
						} else {
							pdays1 = pdays;
						}

					}
					leaps = pyears % 4;
					if ((pmonths == 2) && (leaps == 0))

					{
						if (pdays == 31 || pdays == 30 || pdays == 29) {
							pdays1 = 29;
						} else {
							pdays1 = pdays;
						}
					} else if (pmonths == 2) {
						if (pdays == 31 || pdays == 30 || pdays == 29
								|| pdays == 28) {
							pdays1 = 28;
						} else {
							pdays1 = pdays;
						}
					}

					if (pmonths < 10) {
						duedate = Integer.toString(pdays1) + "/0"
								+ Integer.toString(pmonths) + "/"
								+ Integer.toString(pyears);
					} else {
						duedate = Integer.toString(pdays1) + "/"
								+ Integer.toString(pmonths) + "/"
								+ Integer.toString(pyears);
					}

					pmonths = pmonths + 1;
					if (pmonths > 12) {
						pmonths = 1;
						pyears = pyears + 1;
					}
					loanrepaydate = duedate;

					if (sel_payment.equalsIgnoreCase("n")) {
						duedate = "";
					}

				}
			}

			%>

<html>
<head>
<title>Appraisal Confirmation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var strAction="<%=request.getParameter("hidAction")%>";
var strOption ="<%=Helper.correctNull((String)hshValues.get("strOption"))%>";
var strDet ="<%=Helper.correctNull((String)hshValues.get("strDet"))%>";
var stat_data_sno ="<%=Helper.correctNull((String)hshValues.get("stat_data_sno"))%>";
var str="<%=Helper.correctNull((String)hshValues.get("str"))%>";
var str1="<%=vecsize%>";
var sel_payment="<%=Helper.correctNull((String)hshValues.get("loan_periodicity"))%>";
var sel_insurance="<%=Helper.correctNull((String)hshValues.get("sel_insurance"))%>";
var sanction_amt="<%=Helper.correctNull((String)hshValues.get("eliAmount"))%>" ;
var sel_sec1="<%=Helper.correctNull((String)hshValues.get("sel_sec1"))%>";
var sel_sec2="<%=Helper.correctNull((String)hshValues.get("sel_sec2"))%>";
var sel_sec3="<%=Helper.correctNull((String)hshValues.get("sel_sec3"))%>";
var varproducttype="<%=prd_type%>";


function callCalender(name)
{
if(document.forms[0].cmdsave.disabled==false)
	{
	showCal(appURL,name);
	}
}

function dayscalc(fromdt,todt)
{

	var fmonth = eval(fromdt.substring(3, 5)); 
	var fday = eval(fromdt.substring(0, 2));
	var fyear = eval(fromdt.substring(6, 10));
	var tmonth = eval(todt.substring(3, 5));
	var tday = eval(todt.substring(0, 2));
	var tyear = eval(todt.substring(6, 10));
	var totdays = (((eval(tday) + (eval(tmonth) * 30)) + (eval(tyear) * 365)) - ((eval(fday) + (eval(fmonth) * 30)) + (eval(fyear) * 365)));
	return totdays;
	
}

function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].value="";		  
		}
		else if (document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].value="0";	
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
}

function disablefields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
	}
	document.forms[0].txt_holiday.readOnly=true;
	document.forms[0].txt_installment.readOnly=true;
	document.forms[0].sel_payment.disabled=true;
}

function getAllData()
{
	document.forms[0].hid_option.value="";
	if(document.forms[0].sel_option.selectedIndex == "1")
	{
		document.forms[0].hid_option.value = document.forms[0].sel_option.value;
	}
	else
	{
		for(var i = 0; i <= document.forms[0].sel_option.length - 1; i++)
		{
			if(document.forms[0].sel_option[i].selectedIndex == "1")



			{
				document.forms[0].hid_option.value = document.forms[0].sel_option[i].value;
			}
			if(document.forms[0].sel_option[i].selectedIndex == "1")
			{
				document.forms[0].hid_option.value = document.forms[0].hid_option.value + "," + document.forms[0].sel_option[i].value;			
			}
			if(document.forms[0].sel_option[i].selectedIndex == "2")
			{
				document.forms[0].hid_option.value = document.forms[0].sel_option[i].value;
			}
			if(document.forms[0].sel_option[i].selectedIndex == "2")
			{
				document.forms[0].hid_option.value = document.forms[0].hid_option.value + "," + document.forms[0].sel_option[i].value;			
			}
		}
	}
}

function getcall()
{
	document.forms[0].hid_option.value = "";	
	if(document.forms[0].sel_option.selectedIndex == "1")
	{
		document.forms[0].hid_option.value = document.forms[0].sel_option.value;
	}	
	else
	{
		for(var i = 0; i <= document.forms[0].sel_option.length - 1; i++)
		{
			if(document.forms[0].sel_option[i].selectedIndex == "1")
			{
				if(document.forms[0].hid_option.value == "")
				{
					document.forms[0].hid_option.value = document.forms[0].sel_option[i].value;
				}
				else
				{
					document.forms[0].hid_option.value= document.forms[0].hid_option.value + "," + document.forms[0].sel_option[i].value;
				}
			}
		}
	}
}

function callonLoad()
{
	if(sel_payment!="")
	{
		document.forms[0].sel_payment.value=sel_payment;
	}
	if(sel_insurance!="")
	{
		document.forms[0].sel_insurance.value=sel_insurance;
	}
	if(sel_sec1!="")
	{
		document.forms[0].sel_sec1.value=sel_sec1;
	}
	if(sel_sec2!="")
	{
		document.forms[0].sel_sec2.value=sel_sec2;
	}
	if(sel_sec3!="")
	{
		document.forms[0].sel_sec3.value=sel_sec3;
	}
	document.forms[0].hidAction.value="select";	
	if(varproducttype=="aC")
	{
		document.all.idcrop1.style.visibility="hidden";
		document.all.idcrop1.style.position="absolute";
		document.all.idcrop2.style.visibility="hidden";
		document.all.idcrop2.style.position="absolute";
		document.all.idcrop3.style.visibility="hidden";
		document.all.idcrop3.style.position="absolute";
	}
	else
	{
		document.all.idcrop1.style.visibility="visible";
		document.all.idcrop1.style.position="relative";
		document.all.idcrop2.style.visibility="visible";
		document.all.idcrop2.style.position="relative";
		document.all.idcrop3.style.visibility="visible";
		document.all.idcrop3.style.position="relative";
		
	}
		
	disablefields(true);	
}

function doSave()
{	
	var varloanrecomend=document.forms[0].txt_loanamount.value;
	
	if(varloanrecomend!="")
	{
		if( varloanrecomend=="0.00")
		{
			alert("Loan Recommended Amount Cannot be 0.00");
			document.forms[0].txt_loanamount.focus();
			return;
		}
	}
	else
	{
		alert("Enter loan recommended");
		document.forms[0].txt_loanamount.focus();
		return;
	}
	if(document.forms[0].sel_sec1.value!="s")
	{
		if(document.forms[0].txt_hypo.value=="")
		{
			alert("Enter the Value in Security Proposed");
			document.forms[0].txt_hypo.focus();
			return;
		}
	}
	if(document.forms[0].sel_sec1.value=="s")
	{
		if(document.forms[0].txt_hypo.value!="")
		{
			alert("Select the  Security Proposed");
			document.forms[0].sel_sec1.focus();
			return;
		}
	}	
	if(document.forms[0].sel_sec2.value!="s")
	{
		if(document.forms[0].txt_hypo2.value=="")
		{
			alert("Enter the Value in Security Proposed");
			document.forms[0].txt_hypo2.focus();
			return;
		}
	}
	if(document.forms[0].sel_sec2.value=="s")
	{
		if(document.forms[0].txt_hypo2.value!="")
		{
			alert("Select the  Security Proposed");
			document.forms[0].sel_sec2.focus();
			return;
		}
	}	
	if(document.forms[0].sel_sec3.value!="s")
	{
		if(document.forms[0].txt_hypo3.value=="")
		{
			alert("Enter the Value in Security Proposed");
			document.forms[0].txt_hypo3.focus();
			return;
		}
	}
	if(document.forms[0].sel_sec3.value=="s")
	{
		if(document.forms[0].txt_hypo3.value!="")
		{
			alert("Select the  Security Proposed");
			document.forms[0].sel_sec3.focus();
			return;
		}
	}
	document.forms[0].cmdsave.disabled = true;	
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanMethod.value="updateDataQuestParameters";
	document.forms[0].hidBeanGetMethod.value="getDataQuestParameters";
	document.forms[0].hidSourceUrl.value="/action/appraisalconfirmagr.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/"+"retailpge.jsp";				
		document.forms[0].submit();

	}
}

function doDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].hidBeanMethod.value="updateDataQuestParameters";
		document.forms[0].hidBeanGetMethod.value="getDataQuestParameters";
		document.forms[0].hidSourceUrl.value="/action/appraisalconfirmagr.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}

function doCancel()
{	
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].hidBeanGetMethod.value="getDataQuestParameters";
		document.forms[0].action=appURL+"action/appraisalconfirmagr.jsp";	
		document.forms[0].submit();
	}
}

function callNew() 
{
	ClearFields();
	document.forms[0].hidAction.value="New";
	enableButtons(true,false, false, false, true);
	disablefields(false);	
}

function doEdit() 
{
   document.all.ifrm.src=appURL+"action/iframeagrtabcheck.jsp?hidBeanGetMethod=checkMandatoryPages&hidBeanId=agrcommon&appno="+document.forms[0].strappno.value+"&prdtype="+"<%=prd_type%>";
}

function enableButtons(bool1,bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function callLink(page,bean,method)
{	
	 document.forms[0].hidAction.value="";
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}

function callHelp()
{
}
function doPrint()
{
	var appno="<%=hshValues.get("strappno")%>";
	var purl="";
	<%if (prd_type.equalsIgnoreCase("aH")) {

			%>
	purl="<%=ApplicationParams.getAppUrl()%>action/agr_goldprint.jsp?hidBeanGetMethod=getgolddetailsprint&hidBeanId=agrotherassets&appno="+appno;
	<%}else{%>
	purl="<%=ApplicationParams.getAppUrl()%>action/agr_memorandumprint.jsp?hidBeanGetMethod=getDataQuestParameters&hidBeanId=appraisal&appno="+appno+"&prdtype="+"<%=prd_type%>";;
	<%}%>
	prop='scrollbars=yes,menubar=yes,width=750,height=520';
	xpos=(screen.width-750)/2;
	ypos=(screen.height-520)/2;
	prop=prop+",xpos="+xpos+",ypos="+ypos;
	window.open(purl,'Memorandam_of_Sanction',prop);
}

function printreport1()
{
	var appno="<%=hshValues.get("strappno")%>";
	
	prop='scrollbars=yes,menubar=yes,width=750,height=520';
	xpos=(screen.width-750)/2;
	ypos=(screen.height-520)/2;
	prop=prop+",xpos="+xpos+",ypos="+ypos;
	window.open(purl,'Goldloan_Appraiser_form',prop);
}
function checkamt()
{
	var varloanrecomend=document.forms[0].txt_loanamount.value;
	
	if(varloanrecomend=="")
	{
		varloanrecomend=0;
	}
		
	if(eval(sanction_amt)<eval(varloanrecomend))
	{
		alert("Loan Recommended cannot be greater than Eligible Loan Amount");
		document.forms[0].txt_loanamount.value="";
		document.forms[0].txt_loanamount.focus();
		return;
	}
}


</SCRIPT>
<STYLE>
.cellContainer1 
{
	width: 100%;
	height: auto;
	overflow: auto;
}
</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad()">
<form name="appform" method="post" action="" class="normal">
					
						<table class="outertable border1" width="90%" align="center" border="0" cellspacing="1" cellpadding="3">
							<tr>
								<td valign="top" >
									<div class="cellContainer1">
								<table class="outertable" width="100%" border="0" cellspacing="1" cellpadding="0">
									<tr class="dataheader" align="center">
										<td nowrap width="60%"><b>Appraisal</b></td>
										<td nowrap width="10%"><b>Value</b></td>
										<td nowrap width="30%"><b>Remarks</b></td>
									</tr>
									<%if (vecrecsize != 0 && vecsize != 0) {
				if (vecrecsize == vecsize) {
					for (int l = 0; l < vecsize; l++) {
						if (l < vecsize) {
							g1 = (ArrayList) vec.get(l);
							g2 = (ArrayList) vecrec.get(l);

							%>
									<tr  class="datagrid" >
										<td><br>
										<%=l + 1%>. <%=Helper.correctNull((String) g1
											.get(1))%><br>
										<input type="hidden" name="txt_staticdataid"
											value="<%=Helper.correctNull((String)g2.get(0))%>"></td>
										<td align="center" align="center"><%String str11 = Helper.correctNull((String) g2
									.get(0));

							%> <select name="sel_option" value="">
											<%if (str11.equals("1")) {

							%>
											<option value="1" selected>Yes</option>
											<%} else {

							%>
											<option value="1">Yes</option>
											<%}

							%>
											<%if (str11.equals("2")) {

							%>
											<option value="2" selected>No</option>
											<%} else {

							%>
											<option value="2">No</option>
											<%}

							%>
											<%if (str11.equals("3")) {

							%>
											<option value="3" selected>Not Applicable</option>
											<%} else {

							%>
											<option value="3">Not Applicable</option>
											<%}

							%>
										</select></td>
										<td valign="top" align="center"><textarea name="txt_comments"
											onKeyPress="notAllowSingleQuote();textlimit(this,299)" onKeyUp="textlimit(this,299)"
											rows="2" cols="25" wrap="virtual"><%=Helper.correctNull((String) g2
											.get(1))%></textarea></td>
											</tr>
										<%}
					}
				}
			}
			if (vecsize == 0) {

			%>
									<tr>
										<td><br>
										<br>
										<input type="hidden" name="txt_staticdataid" value=""></td>
										<td align="center"><input type="hidden" name="sel_option"></td>
										<td align="center" align="right"><input type="hidden"
											name="txt_comments"
											onKeyPress="notAllowSingleQuote()"
											rows="2" cols="25" wrap="virtual"></td>
									</tr>
										
										<%}

			%>
								</table>
								</div>
								</td>
							</tr>
						</table>
						
						
<table class="outertable" width="90%" border="0" align="center" cellspacing="2" cellpadding="3">
	<tr>
		<td colspan="3">Recommendations of the Appraising Officer:</td>
	</tr>
	<tr>
		<td colspan="3">The relevant Land record/documents have been obtained
		and verified and found correct.The farm was visited by me on <input
			type="text" name="txt_farmdate" size="12" maxlength="10"
			onKeyPress="" onBlur="checkDate(this);checkmaxdate(this,currdate)"
			value="<%=Helper.correctNull((String)hshValues.get("txt_farmdate"))%>">
		<a href="#" onClick="callCalender('txt_farmdate')"
			title="Click to view calender" border=0><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif" width="0"
			border="0" tabindex="7"></a></td>
	</tr>
	<tr>
		<td width="21%">Loan Recommended</td>
		<td width="26%">Rs. <lapschoice:CurrencyTag name="txt_loanamount"
			value='<%=Helper.correctNull((String)hshValues.get("txt_loanamount"))%>'
			size="13" maxlength="9" onBlur="checkamt();" /></td>
		<td width="53%">&nbsp;</td>
	</tr>
	<tr>
		<td width="21%">Security Proposed</td>
		<td colspan="2"><select name="sel_sec1" onChange="">
			<option value="s" selected>Select</option>
			<option value="h">Hypothecation of</option>
			<option value="m">Mortgage of</option>
			<option value="l">Lien of</option>
			<option value="a">Assignment of</option>
			<option value="p">Pledge of</option>
		</select> <input type="text" name="txt_hypo"
			value="<%=Helper.correctNull((String)hshValues.get("txt_securityval1"))%>"
			size="50" maxlength="99" style="text-align:left"></td>
	</tr>
	<tr>
		<td width="21%"></td>
		<td colspan="2"><select name="sel_sec2" onChange="">
			<option value="s" selected>Select</option>
			<option value="h">Hypothecation of</option>
			<option value="m">Mortgage of</option>
			<option value="l">Lien of</option>
			<option value="a">Assignment of</option>
			<option value="p">Pledge of</option>
		</select> <input type="text" name="txt_hypo2"
			value="<%=Helper.correctNull((String)hshValues.get("txt_securityval2"))%>"
			size="50" maxlength="99" style="text-align:left"></td>
	</tr>
	<tr>
		<td width="21%">&nbsp;</td>
		<td colspan="2"><select name="sel_sec3" onChange="">
			<option value="s" selected>Select</option>
			<option value="h">Hypothecation of</option>
			<option value="m">Mortgage of</option>
			<option value="l">Lien of</option>
			<option value="a">Assignment of</option>
			<option value="p">Pledge of</option>
		</select> <input type="text" name="txt_hypo3"
			value="<%=Helper.correctNull((String)hshValues.get("txt_securityval3"))%>"
			size="50" maxlength="99" style="text-align:left"></td>
	</tr>
	<tr>
		<td colspan="3"><%ArrayList vecgua10 = new ArrayList();
			vecgua = (ArrayList) hshValues.get("vecReport12");

			%> <%if (vecgua.size() != 0) {

				%>
		<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="18%"><b>Name of the Guarantor</b></td>
			</tr>
			<%if (vecgua != null) {
					vecgua10 = new ArrayList();
					vecgua = (ArrayList) hshValues.get("vecReport12");
					for (int q = 0; q < vecgua.size(); q++) {
						vecgua10 = (ArrayList) vecgua.get(q);

						%>
			<tr>
				<td width="18%"><%=Helper.correctNull((String) vecgua10
										.get(1))%></td>
				<td width="82%">S/o ,<%=Helper.correctNull((String) vecgua10
										.get(2))%></td>
			</tr>
			<%}
				}%>
		</table>
		<%}

			%></td>
	</tr>
	<%double noofinstallment = 0;
			noofinstallment = Double.parseDouble(Helper
					.correctDouble((String) hshValues
							.get("loan_noofinstallment")));
			String lreqterms = Helper.correctNull((String) hshValues
					.get("lreqterms"));

			double repay = 0;
			repay = Double.parseDouble(lreqterms);

			if (sel_payment.equalsIgnoreCase("m")) {
				repay = (repay - noofinstallment) / 1;
			}
			if (sel_payment.equalsIgnoreCase("q")) {
				repay = (repay - noofinstallment) / 3;
			}
			if (sel_payment.equalsIgnoreCase("h")) {
				repay = (repay - noofinstallment) / 6;
			}
			if (sel_payment.equalsIgnoreCase("y")) {
				repay = (repay - noofinstallment) / 12;
			}%>
	<tr id="idcrop1">
		<td width="21%">Entire loan amount to be repaid in:</td>
		<td colspan="2"><input type="text" name="txt_holiday"
			value="<%=Helper.formatDoubleValue(repay)%>" size="7" maxlength="5"
			onKeyPress="allowInteger()" style="text-align:right"> No. of
		Installments in <select name="sel_payment" onChange="">
			<option value="s" selected>Select</option>
			<option value="m" selected>Monthly</option>
			<option value="q">Quarterly</option>
			<option value="h">Half-Yearly</option>
			<option value="y">Yearly</option>
			<option value="n">Not Applicable</option>
		</select> <input type="hidden" name="hidpayment"
			value="<%=Helper.correctNull((String)hshValues.get("loan_periodicity"))%>">
		Periodicity of installments</td>
	</tr>
	<tr  id="idcrop2">
		<td width="21%">Gestation Period:</td>
		<td colspan="2"><input type="text" name="txt_installment"
			value="<%=Helper.correctNull((String)hshValues.get("loan_noofinstallment"))%>"
			size="7" maxlength="5" onKeyPress="allowInteger()"
			style="text-align:right"> (Number of Months)Therefore the first
		installment will become due on <input type="text" name="txt_date"
			size="12" maxlength="10" onKeyPress="" value="<%=duedate%>"></td>
	</tr>
	<tr  id="idcrop3">
		<td width="21%">Insurance wherever applicable:</td>
		<td colspan="2"><select name="sel_insurance" onChange="">
			<option value="1" selected>Yes</option>
			<option value="2">No</option>
		</select></td>
	</tr>

</table>
<br>
<lapschoice:combuttonnew  btnnames='Edit_Save_Cancel_Delete_Audit Trail_Print' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />

<lapschoice:agrihiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="txt_staticdataid">
<input type="hidden" name="hidslno" value="<%=Helper.correctNull((String)hshValues.get("stat_data_sno"))%>">
<input type="hidden" name="hidstate" value="2">
<input type="hidden" name="hidstatenew" value=""> 
<input type="hidden" name="hid_option" value="<%=Helper.correctNull((String)hshValues.get("strOption"))%>"> 
<input type="hidden" name="strappno" value="<%=Helper.correctNull((String)hshValues.get("strappno"))%>"> 
<iframe name="ifrm" width="0" height="0" border="0"></iframe>
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("auditFlag"))%>">
</form>
</body>
</html>
