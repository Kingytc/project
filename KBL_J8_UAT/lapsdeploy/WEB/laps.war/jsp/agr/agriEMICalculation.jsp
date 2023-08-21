<%@include file = "../share/directives.jsp"%>
<lapschoice:handleerror/>

<%

String margincom="";
%>
<html>
<head>
<title>Appraisal - ELIGIBILITY Calculation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var strAction ="<%=Helper.correctNull((String)hshValues.get("hidAction"))%>";
var loan_amount_kh="<%=Helper.correctNull((String)hshValues.get("loan_amount_kh"))%>";
var loan_amount_rb="<%=Helper.correctNull((String)hshValues.get("loan_amount_rb"))%>";
var loan_amount_su="<%=Helper.correctNull((String)hshValues.get("loan_amount_su"))%>";
var loan_amount_an="<%=Helper.correctNull((String)hshValues.get("loan_amount_an"))%>";
var loan_amount_pe="<%=Helper.correctNull((String)hshValues.get("loan_amount_pe"))%>";
var adhocval="<%=Helper.correctNull((String)hshValues.get("crop_adhoclimit"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function consumptioncredit()
{
	var consumption_credit = document.forms[0].txt_consumption.value;
	if( consumption_credit > 100000)
	{
		alert("The consuption credit is above 1 lakh rupees");
	}
}

function coffeeloan()
	{
	var coffee_loan=document.forms[0].txt_coffee_assesment.value;
	var inter_loan=document.forms[0].txt_inter_assesment.value;
	//var adhoc="";
	if(eval(coffee_loan)=="")
		{
		coffee_loan="0";
		document.forms[0].txt_coffee_assesment.value="0.00";
		}
	if(eval(inter_loan)=="")
		{
		inter_loan="0";
		document.forms[0].txt_inter_assesment.value="0.00";
		}
	document.forms[0].txt_total_coffee.value=(eval(coffee_loan)+eval(inter_loan));
	roundtxt(document.forms[0].txt_total_coffee);
}

function calhighest()
{
    //coffeeloan();
    var len,str1,total,i;
    var total_loan=0.00;
    var total_loan1=0.00;
    var total_loan2=0.00;
    var total_loan6=0.00;
    var total_loan3=0.00;
    var total_loan4=0.00;
    var total_loan5=0.00;

    var txt_amount_an=document.forms[0].txt_amount_an.value;
    var txt_amount_pe= document.forms[0].txt_amount_pe.value;
    var txt_ka_amt=document.forms[0].txt_amount_kh.value;
    var txt_ra_amt=document.forms[0].txt_amount_rb.value;
    var txt_su_amt=document.forms[0].txt_amount_su.value;
    
    var txt_allied=document.forms[0].txt_allied.value;
    var txt_nfs= document.forms[0].txt_nfs.value;
	//var txt_total_coffee= document.forms[0].txt_total_coffee.value;
	
	var txt_consumption="<%=Helper.correctNull((String)hshValues.get("crop_consumption"))%>";
    var txt_operativelimit=document.forms[0].txt_operativelimit.value;
    var txt_documentation=document.forms[0].txt_documentation.value;
   
    if(txt_documentation=="" || txt_documentation=="NaN")
    	{
    	txt_documentation=0.00;
	    }
    if(txt_operativelimit=="")
   	 	{
	    txt_operativelimit=0.00;
   		 }
    if(txt_consumption=="")
    	{
	    txt_consumption=0.00;
    	}
    if(txt_ka_amt=="")
    	{
	    txt_ka_amt=0.00;
    	}
    if(txt_ra_amt=="")
    	{
	    txt_ra_amt=0.00;
    	}
    if(txt_su_amt=="")
    	{
	    txt_su_amt=0.00;
    	}
   	if(txt_amount_an=="")
    	{
   		txt_amount_an=0.00;
    	}
   	if(txt_amount_pe=="")
    	{
    	txt_amount_pe=0.00;
    	}
    if(txt_allied=="")
    	{
   		txt_allied=0.00;
    	}
   	if(txt_nfs=="")
    	{
    	txt_nfs=0.00;
    	}
	/*if(txt_total_coffee=="")
    {
    txt_total_coffee=0.00;
    }*/
    document.forms[0].txt_crop_loan.value=eval(txt_ka_amt)+eval(txt_ra_amt)+eval(txt_su_amt);
    total_loan1=eval(txt_amount_an)+eval(txt_amount_pe)+eval(txt_ka_amt)+eval(txt_ra_amt)+eval(txt_su_amt);
    document.forms[0].txt_total_crop_loan.value=Math.round(total_loan1);
    total_loan2=eval(total_loan1)+eval(txt_nfs)+eval(txt_allied);//+eval(txt_total_coffee)
    
    document.forms[0].txt_prdcredit.value=Math.round(total_loan2);  
	total_loan5=eval(total_loan2)*30;
    total_loan6=eval(total_loan5)/100;  
    document.forms[0].txt_consumption.value=txt_consumption;
    var total1= document.forms[0].txt_consumption.value;
    var len1=total1.length;
    var j= total1.indexOf(".");
    if(j>0)
    {
   		str11=total1.substring(0,j+4);
   	}
   	else
   	{
     	str11=total1;
   	}  
    document.forms[0].txt_consumption.value=Math.round(str11);
    var consumption_credit = document.forms[0].txt_consumption.value;
	 if( consumption_credit > 100000)
	{
	    alert("The consumption credit is above 1 lakh rupees");
		document.forms[0].txt_consumption.value="100000";
	}
	total_loan4=document.forms[0].txt_consumption.value;
	
    document.forms[0].txt_operativelimit.value=Math.round(eval(total_loan2)+eval(total_loan4));
    document.forms[0].txt_documentation.value=eval(total_loan6)+eval(total_loan2)+eval(total_loan4);
    roundtxt(document.forms[0].txt_consumption);
    roundtxt(document.forms[0].txt_prdcredit);
    roundtxt(document.forms[0].txt_operativelimit);
    roundtxt(document.forms[0].txt_documentation);
    roundtxt(document.forms[0].txt_amount_pe);
    roundtxt(document.forms[0].txt_amount_an);
    roundtxt(document.forms[0].txt_amount_kh);
    roundtxt(document.forms[0].txt_amount_rb);
    roundtxt(document.forms[0].txt_amount_su);
    roundtxt(document.forms[0].txt_crop_loan);
}

function callLink(page,bean,method)
{	
	document.forms[0].hidAction.value="";
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appURL+"action/"+page;
	document.forms[0].submit();
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

function callCalender1()
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		showCal(appURL,'appraisaldate');
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
}

function doSave()
{	
	enableButtons( true, true, true, true, false);	
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidSourceUrl.value="/action/agriEMICalculation.jsp";
	document.forms[0].hidBeanMethod.value="updateEMIAGRIData";
	document.forms[0].hidBeanGetMethod.value="getEMIAGRIData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{
	disablefields(true);	
	document.forms[0].cmdsave.disabled=false;
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmdcancel.disabled=false;
	//document.forms[0].cmdclose.disabled=true;
	//document.forms[0].txt_firstHighest.readOnly=true;
	//document.forms[0].txt_secondHighest.readOnly=true;
	document.forms[0].txt_crop_loan.readOnly=true;
	document.forms[0].txt_prdcredit.readOnly=true;
	document.forms[0].txt_consumption.readOnly=false;
	document.forms[0].txt_operativelimit.readOnly=true;
	//document.forms[0].txt_contingency.readOnly=false;
	document.forms[0].txt_documentation.readOnly=true;
	//document.forms[0].txt_adhoclimit.readOnly=false;
	document.forms[0].txt_amount_su.readOnly=true;
	document.forms[0].txt_amount_rb.readOnly=true;
	document.forms[0].txt_amount_kh.readOnly=true;
	document.forms[0].txt_amount_an.readOnly=true;
	document.forms[0].txt_amount_pe.readOnly=true;
	document.forms[0].txt_consumption.focus();
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value="Cancel";
		
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].hidBeanGetMethod.value="getEMIAGRIData";
		document.forms[0].action=appURL+"action/agriEMICalculation.jsp";
		document.forms[0].submit();
		//document.forms[0].cmdclose.disabled=false;
	}
}


function doClose()
{
	var con = ConfirmMsg('100');
	if(con)
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/retailpge.jsp";
		document.forms[0].submit();
	}
}

function onloading()
{	  
	disablefields(true);
	//highestAmount();
	calhighest();
	//coffeeloan();
	total();
}

function enableButtons( bool2, bool3, bool4,bool6)
{	
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	//document.forms[0].cmdclose.disabled = bool6;
}
function callConsumption()
{
var txt_prdcredit=document.forms[0].txt_prdcredit.value;
if(eval(txt_prdcredit)=="")
{
txt_prdcredit="0";
document.forms[0].txt_prdcredit.value="0";
}
var txt_consumption=document.forms[0].txt_consumption.value;
if(eval(txt_consumption)=="")
{
txt_consumption="0";
document.forms[0].txt_consumption.value="0";
}
document.forms[0].txt_operativelimit.value=eval(txt_prdcredit)+eval(txt_consumption);
}

function total()
	{
	var txt_operativelimit=document.forms[0].txt_operativelimit.value;
	if(eval(txt_operativelimit)=="")
		{
		txt_operativelimit="0";
		document.forms[0].txt_operativelimit.value="0";
		}
	/*var txt_contingency="";
	if(eval(txt_contingency)=="")
		{
		txt_contingency="0";
		//document.forms[0].txt_contingency.value="0";
		}
	var adhoc_value="";
	if(eval(adhoc_value)=="")
		{
		adhoc_value="0";
		//document.forms[0].txt_adhoclimit.value="0";
		}*/
	document.forms[0].txt_documentation.value=eval(txt_operativelimit);//+eval(txt_contingency)+eval(adhoc_value);
	roundtxt(document.forms[0].txt_documentation);
}

</SCRIPT>

</head>
<body onLoad="onloading();consumptioncredit()">
<form name="appform" method="post" action="" class="normal">
<table width="100%" border="0" cellpadding="5" cellspacing="0"
	class="outertable border1" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1"
					align="center">
					<tr>
						<td>

						<table width="98%" border="0" cellspacing="0" cellpadding="2"
							align="center" class="outertable">
							<tr>
								<td>

								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="2"
											class="outertable">
											<tr>
												<td valign="top" align="center">
												<table width="100%%" border="0" cellspacing="0"
													cellpadding="4" class="outertable">
													<tr>
														<td>
														<table width="100%" border="0" cellspacing="0"
															cellpadding="4" class="outertable">
                                              <tr> 
                                                <td width="43%">Crop 
                                                  Loan Eligible for different 
                                                  Perennial Crops</td>
                                                <td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
                                                <td width="52%"> 
                                                  <input type="text" name="txt_amount_pe" size="25"
																	 style="text-align:right"
																	value="<%=Helper.correctNull((String)hshValues.get("loan_amount_pe"))%>"
																	onKeyPress="allowNumber(this)" onBlur=""> 
                                                  
                                                  <b>(A)</b> </td>
                                              </tr>
                                              <tr> 
                                                <td>Crop 
                                                  Loan Eligible for different 
                                                  Annual Crops</td>
                                                <td><b><%=ApplicationParams.getCurrency()%></b></td>
                                                <td> <input type="text" name="txt_amount_an" size="25"
																 style="text-align:right"
																	value="<%=Helper.correctNull((String)hshValues.get("loan_amount_an"))%>"
																	onKeyPress="allowNumber(this)" onBlur=""> 
                                                 
                                                  <b>(B)</b> </td>
                                              </tr>
                                              <tr> 
                                                <td>Crop 
                                                  Loan Eligible for different 
                                                  Khariff Crops</td>
                                                <td><b><%=ApplicationParams.getCurrency()%></b></td>
                                                <td> <input type="text" name="txt_amount_kh" size="25"
																 style="text-align:right"
																	value="<%=Helper.correctNull((String)hshValues.get("loan_amount_kh"))%>"
																	onKeyPress="allowNumber(this)"
																	onBlur=""> 
                                                  
                                                  <b>(C1)</b> </td>
                                              </tr>
                                              <tr> 
                                                <td>Crop 
                                                  Loan Eligible for different 
                                                  Rabi Crops</td>
                                                <td><b><%=ApplicationParams.getCurrency()%></b></td>
                                                <td> <input type="text" name="txt_amount_rb" size="25"
																	style="text-align:right"
																	value="<%=Helper.correctNull((String)hshValues.get("loan_amount_rb"))%>"
																	onKeyPress="allowNumber(this)"
																	onBlur=""> 
                                                 
                                                  <b>(C2)</b> </td>
                                              </tr>
                                              <tr> 
                                                <td>Crop 
                                                  Loan Eligible for different 
                                                  Summer Crops</td>
                                                <td><b><%=ApplicationParams.getCurrency()%></b></td>
                                                <td> <input type="text" name="txt_amount_su" size="25"
																	 style="text-align:right"
																	value="<%=Helper.correctNull((String)hshValues.get("loan_amount_su"))%>"
																	onKeyPress="allowNumber(this)"
																	onBlur=""> 
                                                 
                                                  <b>(C3)</b></td>
                                              </tr>
                                              
                                              <tr> 
                                                <td>Loan 
                                                  Amount for Seasonal Crops</td>
                                                <td><b><%=ApplicationParams.getCurrency()%></b></td>
                                                <td> <input type="text" name="txt_crop_loan" size="25"
																	readonly style="text-align:right" value=""
																	onKeyPress="allowNumber(this)">
                                                 <b>C=(C1+C2+C3)</b> 
                                                  </td>
                                              </tr>
                                              <tr> 
                                                <td>Total 
                                                  Crop Loan</td>
                                                <td><b><%=ApplicationParams.getCurrency()%></b></td>
                                                <td> <input type="text" name="txt_total_crop_loan"
																	style="text-align:right" readonly
																	onKeyPress="allowNumber(this)" onBlur="" size="25"
																	value=""> 
                                                 
                                                  <b>(A+B+C)</b> </td>
                                              </tr>
                                              <tr> 
                                                <td>Working 
                                                  Capital (Allied/Activity/Activities 
                                                  per Cycle)</td>
                                                <td><b><%=ApplicationParams.getCurrency()%></b></td>
                                                <td> <input type="text" name="txt_allied" readonly value="<%=Helper.correctNull((String)hshValues.get("totworkcap"))%>"
																	style="text-align:right" onKeyPress="allowNumber(this)"
																	size="25" onBlur=""> 
                                                  <b>(D)</b></td>
                                              </tr>
                                              <tr> 
                                                <td>Term 
                                                  Loan</td>
                                                <td><b><%=ApplicationParams.getCurrency()%></b></td>
                                                <td> <input type="text" name="txt_nfs"
																	style="text-align:right" onKeyPress="allowNumber(this)"
																	value="<%=Helper.correctNull((String)hshValues.get("totloanamt"))%>" size="25" onBlur="" readonly> 
                                                  <b>(E) 
                                                  </b> </td>
                                              </tr>
                                              <!--  <tr> 
                                                <td><font size="1" face="MS Sans Serif">Total 
                                                  Loan Amount </font></td>
                                                <td><font size="1" face="MS Sans Serif">&nbsp;<b><%=ApplicationParams.getCurrency()%></b></font></td>
                                                <td>
<input type="text" name="txt_nfs2"
																	style="text-align:right" onKeyPress="allowNumber(this)"
																	value="" size="25" onBlur="calhighest()" readonly></td>
                                              </tr>
                                              <tr> 
                                                <td><font size="1" face="MS Sans Serif">Coffee 
                                                  Loan </font></td>
                                                <td><font size="1" face="MS Sans Serif"><b><%//=ApplicationParams.getCurrency()%></b></font></td>
                                                <td><input type="text" name="txt_coffee_assesment"
																	style="text-align:right" readonly
																	onKeyPress="allowNumber(this)" onBlur="" size="25"
																	value="<%//=Helper.correctNull((String)hshValues.get("coffee_leastamt"))%>">
                                                  <font size="1" face="MS Sans Serif"><b>(E1) 
                                                  </b></font> <font size="1" face="MS Sans Serif"><b> 
                                                  </b></font></td>
                                              </tr>
                                              <tr> 
                                                <td><font size="1" face="MS Sans Serif">Inter 
                                                  Crop Loan</font></td>
                                                <td><font size="1" face="MS Sans Serif"><b><%//=ApplicationParams.getCurrency()%></b></font></td>
                                                <td><input type="text" name="txt_inter_assesment"
																	style="text-align:right" readonly
																	onKeyPress="allowNumber(this)" onBlur="" size="25"
																	value="<%//=Helper.correctNull((String)hshValues.get("crop_leastamt"))%>">
                                                  <font size="1" face="MS Sans Serif"><b>(E2) 
                                                  </b></font></td>
                                              </tr>
                                              <tr> 
                                                <td><font size="1" face="MS Sans Serif">Total 
                                                  Coffee Loan</font></td>
                                                <td><font size="1" face="MS Sans Serif"><b><%//=ApplicationParams.getCurrency()%></b></font></td>
                                                <td><input type="text" name="txt_total_coffee"
																	style="text-align:right" readonly
																	onKeyPress="allowNumber(this)" onBlur="" size="25"
																	value="">
                                                  <font size="1" face="MS Sans Serif"><b>(E1+E2)=(F) 
                                                  </b></font></td>
                                              </tr>-->
                                              <tr> 
                                                <td>Total UGC limit </td>
                                                <td><b><%=ApplicationParams.getCurrency()%></b></td>
                                                <td><input type="text" name="txt_prdcredit"
																	style="text-align:right" size="25" value=""> 
                                                  <b>I(A+B+C+D+E)</b> 
                                                </td>
                                              </tr>
                                              <tr> 
                                                <td>
                                                 <b>I</b>  Consumption 
                                                  Credit</td>
                                                <td><b><%=ApplicationParams.getCurrency()%></b></td>
                                                <td> 
                                                  <lapschoice:CurrencyTag name="txt_consumption" size="25" value='' maxlength="15"
																	 onBlur="" />
                                                  
                                                  <b><%=Helper.correctNull((String)hshValues.get("crop_consumption"))%> 
                                                  <%
												margincom=Helper.correctNull((String)hshValues.get("margincom"));
												
												%>
                                                  (Edited Value)</b><b>(G)</b></td>
                                              </tr>
                                              <tr> 
                                                <td>Operative 
                                                  Limit </td>
                                                <td><b><%=ApplicationParams.getCurrency()%></b></td>
                                                <td>
                                                	<input type="text" onKeyPress="allowNumber(this)"
																	name="txt_operativelimit" value="" size="25" onBlur=""
																	style="text-align:right">
                                                  
                                                  	<b>(II)(I+G)</b></td>
                                              </tr>
                                              
                                              <tr> 
                                                <td>Overall 
                                                  Limit for Documentation</td>
                                                <td><b><%=ApplicationParams.getCurrency()%></b></td>
                                                <td><input type="text" name="txt_documentation" onBlur=""
																	onKeyPress="allowNumber(this)" style="text-align:right"
																	size="25" value="">
                                                 <strong>(II)</strong>
                                                   </td>
                                              </tr>
                                              <tr> 
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
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
  <lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
							
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
<lapschoice:agrihiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidRecordflag" > 
</form>
</body>
</html>
