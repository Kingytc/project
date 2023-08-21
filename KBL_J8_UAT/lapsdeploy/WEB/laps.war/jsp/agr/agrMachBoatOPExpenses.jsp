<%@include file="../share/directives.jsp"%>
<%
String schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
%>
<%String rowEcoVal[] = new String[14];

			String rowOP1[] = new String[13];
			String rowOP2[] = new String[13];
			String rowOP3[] = new String[13];
			String rowOP4[] = new String[13];
			String rowOP5[] = new String[13];
			String rowOP6[] = new String[13];

			ArrayList vecDataOPExp = new ArrayList();
			ArrayList vecDataEcoValues = new ArrayList();
			int vecsize = 0;
			if (hshValues != null) {
				if (hshValues.size() > 0) {
					vecDataEcoValues = (ArrayList) hshValues
							.get("vecDataEcoValues");
					vecDataOPExp = (ArrayList) hshValues.get("vecDataOPExp");
					vecsize = vecDataEcoValues.size();

					ArrayList c1 = new ArrayList();
					for (int i = 0; i < vecsize; i++) {
						c1 = (ArrayList) vecDataEcoValues.get(i);
						rowEcoVal[0] = (String) c1.get(0);
						rowEcoVal[1] = (String) c1.get(1);
						rowEcoVal[2] = (String) c1.get(2);
						rowEcoVal[3] = (String) c1.get(3);
						rowEcoVal[4] = (String) c1.get(4);
						rowEcoVal[5] = (String) c1.get(5);
						rowEcoVal[6] = (String) c1.get(6);
						rowEcoVal[7] = (String) c1.get(7);
						rowEcoVal[8] = (String) c1.get(8);
						//rowEcoVal[9] = (String) c1.get(9);
						//rowEcoVal[10] = (String) c1.get(10);
						//rowEcoVal[11] = (String) c1.get(11);
						//rowEcoVal[12] = (String) c1.get(12);
						//rowEcoVal[13] = (String) c1.get(13);
					}
					ArrayList s1 = new ArrayList();
					vecsize = vecDataOPExp.size();
					for (int i = 0; i < vecsize; i++) {
						s1 = (ArrayList) vecDataOPExp.get(i);
						rowOP1[i] = (String) s1.get(0);
						rowOP2[i] = (String) s1.get(1);
						rowOP3[i] = (String) s1.get(2);
						rowOP4[i] = (String) s1.get(3);
						rowOP5[i] = (String) s1.get(4);
						rowOP6[i] = (String) s1.get(5);
					}
				}
			}
%>
<html>
<head>
<title>Mechanised Boat1</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var schemetype="<%=schemetype%>";
function callLink(page,bean,method)
{	
	 document.forms[0].hidAction.value="";
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}
function callLink1(page,bean,method,hidcroptype)
{	
	 document.forms[0].hidAction.value="";
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].hidcroptype.value=hidcroptype;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}
function callonload()
{
	disableFields(true);
	calTotal();
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=schemetype;

	
	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
			enableButtons(false, true, true, true, false);
		}
		else
		{
			enableButtons(true, true, true, true, false);
		}
	}
	else
	{
		enableButtons(true, true, true, true, false);
	}
			
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text'  )
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one'  )
		{
			document.forms[0].elements[i].disabled=val;
		}	
		document.forms[0].txt_total_exp1.readOnly=true; 
		document.forms[0].txt_total_exp2.readOnly=true; 
		document.forms[0].txt_total_exp3.readOnly=true; 
		document.forms[0].txt_total_exp4.readOnly=true; 
		document.forms[0].txt_exp1[0].readOnly=true;
		document.forms[0].txt_exp1[1].readOnly=true;
	}
}

function doClose()
{
	if( ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/retailpge.jsp";				
		document.forms[0].submit();

	}
}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;	
	document.forms[0].cmddelete.disabled=bool4;	
	document.forms[0].cmdclose.disabled=bool5;		
}


function doSave()
{   
	for(var i=0;i<12;i++)
	{
		if(document.forms[0].txt_exp1[i].value=="")
		{
			document.forms[0].txt_exp1[i].value="0";
		}
		if(document.forms[0].txt_exp2[i].value=="")
		{
			document.forms[0].txt_exp2[i].value="0";
		}
		if(document.forms[0].txt_exp3[i].value=="")
		{
			document.forms[0].txt_exp3[i].value="0";
		}
		if(document.forms[0].txt_exp4[i].value=="")
		{
			document.forms[0].txt_exp4[i].value="0";
		}
	}
	for(var i=0;i<6;i++)
	{
		if(document.forms[0].txt_eco_value[i].value=="")
		{
			document.forms[0].txt_eco_value[i].value="0";
		}
	}
	enableButtons(true, true, true, true, true, false);
	document.forms[0].hidAction.value ="update";
	document.forms[0].hidBeanId.value="agriculture";		
	document.forms[0].hidSourceUrl.value="/action/agrMachBoatOPExpenses.jsp";
	document.forms[0].hidBeanMethod.value="updateOperatingExpenses";
	document.forms[0].hidBeanGetMethod.value="getOperatingExpenses";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{
 	disableFields(false);
	enableButtons(true, false, false, false, true, true);
	document.forms[0].txt_eco_value[0].focus();
}


function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agriculture";
		document.forms[0].hidBeanGetMethod.value="getOperatingExpenses";
		document.forms[0].action=appURL+"action/agrMachBoatOPExpenses.jsp";
		document.forms[0].submit(); 		
	}	
}

function doDelete()
{
	/*for(var i=0;i<12;i++)
	{
		if(document.forms[0].txt_exp1[i].value=="")
		{
			document.forms[0].txt_exp1[i].value="0";
		}
		if(document.forms[0].txt_exp2[i].value=="")
		{
			document.forms[0].txt_exp2[i].value="0";
		}
		if(document.forms[0].txt_exp3[i].value=="")
		{
			document.forms[0].txt_exp3[i].value="0";
		}
		if(document.forms[0].txt_exp4[i].value=="")
		{
			document.forms[0].txt_exp4[i].value="0";
		}
	}
	for(var i=0;i<6;i++)
	{
		if(document.forms[0].txt_eco_value[i].value=="")
		{
			document.forms[0].txt_eco_value[i].value="0";
		}
	}*/
var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appURL+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updateOperatingExpenses";
	document.forms[0].hidBeanGetMethod.value="getOperatingExpenses";
	document.forms[0].hidBeanId.value="agriculture";
	document.forms[0].hidSourceUrl.value="action/agrMachBoatOPExpenses.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();	
	}
}
		

function calTotal()
{   
	var first=0.00;
	var second=0.00;
	var third=0.00;
	var fourth=0.00;
	for(var i=0;i<13;i++)
	{
		if(document.forms[0].txt_exp1[i].value=="")
		{
			document.forms[0].txt_exp1[i].value="0";
		}
		if(document.forms[0].txt_exp2[i].value=="")
		{
			document.forms[0].txt_exp2[i].value="0";
		}
		if(document.forms[0].txt_exp3[i].value=="")
		{
			document.forms[0].txt_exp3[i].value="0";
		}
		if(document.forms[0].txt_exp4[i].value=="")
		{
			document.forms[0].txt_exp4[i].value="0";
		}
		if(document.forms[0].txt_total_exp1.value=="")
		{
			document.forms[0].txt_total_exp1.value="0";
		}
		if(document.forms[0].txt_total_exp2.value=="")
		{
			document.forms[0].txt_total_exp2.value="0";
		}
		if(document.forms[0].txt_total_exp3.value=="")
		{
			document.forms[0].txt_total_exp3.value="0";
		}
		if(document.forms[0].txt_total_exp4.value=="")
		{
			document.forms[0].txt_total_exp4.value="0";
		}
		
		
		first=eval(first)+eval(document.forms[0].txt_exp1[i].value)
		second=eval(second)+eval(document.forms[0].txt_exp2[i].value)
		third=eval(third)+eval(document.forms[0].txt_exp3[i].value)
		fourth=eval(fourth)+eval(document.forms[0].txt_exp4[i].value)
		
		
		roundtxt(document.forms[0].txt_exp1[i]);
		roundtxt(document.forms[0].txt_exp2[i]);
		roundtxt(document.forms[0].txt_exp3[i]);
		roundtxt(document.forms[0].txt_exp4[i]);
	}	
		document.forms[0].txt_total_exp1.value=first;
		document.forms[0].txt_total_exp2.value=second;
		document.forms[0].txt_total_exp3.value=third;
		document.forms[0].txt_total_exp4.value=fourth;
		roundtxt(document.forms[0].txt_total_exp1);
		roundtxt(document.forms[0].txt_total_exp2);
		roundtxt(document.forms[0].txt_total_exp3);
		roundtxt(document.forms[0].txt_total_exp4);

}
function calFirstyear()
{
	var total=0.00;
	var val1=document.forms[0].txt_eco_value[0].value;
	var val2=document.forms[0].txt_eco_value[1].value;
	var val3=document.forms[0].txt_eco_value[2].value;
	if(val1=="")
	{
		val1=0.00;
	}
	if(val2=="")
	{
		val2=0.00;
	}
	if(val3=="")
	{
		val3=0.00;
	}
	total=eval(val1)*eval(val2)*eval(val3);
	document.forms[0].txt_exp1[0].value=NanNumber(total);
	roundtxt(document.forms[0].txt_exp1[0]);
	//roundtxt(document.forms[0].txt_eco_value[2]);
	
	
}
function calFirstyear1()
{
	var total=0.00;
	var val1=document.forms[0].txt_eco_value[3].value;
	var val2=document.forms[0].txt_eco_value[4].value;
	var val3=document.forms[0].txt_eco_value[5].value;
	if(val1=="")
	{
		val1=0.00;
	}
	if(val2=="")
	{
		val2=0.00;
	}
	if(val3=="")
	{
		val3=0.00;
	}
	total=eval(val1)*eval(val2)*eval(val3);
	document.forms[0].txt_exp1[1].value=NanNumber(total);
	roundtxt(document.forms[0].txt_exp1[1]);
	
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonload()">
<form method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="999" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
      <td><i><b>Home -> Agriculture -> Cropping 
        Pattern Details</b></i></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="206" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="3" cellspacing="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
					<tr>
						<td colspan="3">
						<table border="0" align="center" cellspacing="1" cellpadding="3" width="100%" class="outertable">
							<tr class="dataheader">
								<td align="center">
								<div align="center">Sl.No</div>
								</td>
								<td align="center">Particulars</td>
								<td align="center">I Year Rs.</td>
								<td align="center">II Year Rs.</td>
								<td align="center">III Year Rs..</td>
								<td align="center">IV Year till the end of loan period Rs.</td>
							</tr>
							<tr>
								<td align="center">01</td>
								<td align="left">Diesel at <input type="text"
									name="txt_eco_value" tabindex="1"
									value="<%=Helper.correctNull((String)rowEcoVal[3])%>" size="10"
									maxlength="3" onKeyPress="allowNumber(this)"
									style="text-align:left" onBlur="calFirstyear()"> litres per day
								for <input type="text" name="txt_eco_value" tabindex="2"
									value="<%=Helper.correctNull((String)rowEcoVal[4])%>" size="10"
									maxlength="3" onKeyPress="allowNumber(this)"
									style="text-align:left" onBlur="calFirstyear()"> days at Rs. <lapschoice:CurrencyTag
									name="txt_eco_value" tabindex='3'
									value='<%=Helper.correctNull((String)rowEcoVal[5])%>' size="10"
									maxlength="3" onBlur="calFirstyear()" /> per litre</td>
								<td align="center"><input type="text" name="txt_exp1"
									value="<%=Helper.correctNull((String)rowOP3[0])%>" size="15"
									maxlength="9" onKeyPress="allowNumber(this)"
									onBlur="calTotal()" style="text-align:right" tabindex="4"></td>
								<td align="center"><input type="text" name="txt_exp2"
									tabindex="4" value="<%=Helper.correctNull((String)rowOP4[0])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									style="text-align:right" onBlur="calTotal()"  tabindex="5"></td>
								<td align="center"><input type="text" name="txt_exp3"
									tabindex="5" value="<%=Helper.correctNull((String)rowOP5[0])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									style="text-align:right" onBlur="calTotal()"  tabindex="6"></td>
								<td height="39">
								<div align="center"><input type="text" name="txt_exp4"
									tabindex="6" value="<%=Helper.correctNull((String)rowOP6[0])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									style="text-align:right" onBlur="calTotal()"  tabindex="7"></div>
								</td>
							</tr>
							<tr>
								<td align="center">02</td>
								<td align="left">Oil at <input type="text" name="txt_eco_value"
									tabindex="8"
									value="<%=Helper.correctNull((String)rowEcoVal[6])%>" size="10"
									maxlength="3" onKeyPress="allowNumber(this)"
									style="text-align:left" onBlur="calFirstyear1()"> litres per
								day for <input type="text" name="txt_eco_value" tabindex="9"
									value="<%=Helper.correctNull((String)rowEcoVal[7])%>" size="10"
									maxlength="3" onKeyPress="allowNumber(this)"
									style="text-align:left" onBlur="calFirstyear1()"> Days at Rs. <lapschoice:CurrencyTag
									name="txt_eco_value" tabindex='10'
									value='<%=Helper.correctNull((String)rowEcoVal[8])%>' size="10"
									maxlength="3" onBlur="calFirstyear1()" /> per litre</td>
								<td>
								<div align="center"><input type="text" name="txt_exp1"
									tabindex="11"
									value="<%=Helper.correctNull((String)rowOP3[1])%>" size="15"
									maxlength="9" onKeyPress="allowNumber(this)"
									style="text-align:right" onBlur="calTotal()"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_exp2"
									tabindex="12"
									value="<%=Helper.correctNull((String)rowOP4[1])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_exp3"
									tabindex="13"
									value="<%=Helper.correctNull((String)rowOP5[1])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_exp4"
									tabindex="14"
									value="<%=Helper.correctNull((String)rowOP6[1])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
							</tr>
							<tr>
								<td align="center">03</td>
								<td height="28">&nbsp; Repairs and maintenance of hull. Net and
								engine <!--( 
                          <input type="text"
													name="txt_eco_value" tabindex="40" 
													value="<%=Helper.correctNull((String)rowEcoVal[9])%>"  
													size="10"
													maxlength="3"  onKeyPress="checkPercentage(this)" 
													style="text-align:right">
                          % of capital cost)--></td>
								<td height="28">
								<div align="center"><input type="text" name="txt_exp1"
									tabindex="15"
									value="<%=Helper.correctNull((String)rowOP3[2])%>" size="15"
									maxlength="9" onKeyPress="allowNumber(this)"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
								<td height="28">
								<div align="center"><input type="text" name="txt_exp2"
									tabindex="16"
									value="<%=Helper.correctNull((String)rowOP4[2])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
								<td height="28">
								<div align="center"><input type="text" name="txt_exp3"
									tabindex="17"
									value="<%=Helper.correctNull((String)rowOP5[2])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
								<td height="28">
								<div align="center"><input type="text" name="txt_exp4"
									tabindex="18"
									value="<%=Helper.correctNull((String)rowOP6[2])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
							</tr>
							<tr>
								<td align="center">04</td>
								<td>Taxes and insurance</td>
								<td>
								<div align="center"><input type="text" name="txt_exp1"
									tabindex="19"
									value="<%=Helper.correctNull((String)rowOP3[3])%>" size="15"
									maxlength="9" onKeyPress="allowNumber(this)"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_exp2"
									tabindex="20"
									value="<%=Helper.correctNull((String)rowOP4[3])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_exp3"
									tabindex="21"
									value="<%=Helper.correctNull((String)rowOP5[3])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_exp4"
									tabindex="22"
									value="<%=Helper.correctNull((String)rowOP6[3])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
							</tr>
							<tr>
								<td align="center">05</td>
								<td>Incidental and miscellaneous charges</td>
								<td>
								<div align="center"><input type="text" name="txt_exp1"
									tabindex="23" style="text-align:right"
									value="<%=Helper.correctNull((String)rowOP3[4])%>" size="15"
									maxlength="9" onKeyPress="allowNumber(this)"
									onBlur="calTotal()"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_exp2"
									tabindex="24"
									value="<%=Helper.correctNull((String)rowOP4[4])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_exp3"
									tabindex="25"
									value="<%=Helper.correctNull((String)rowOP5[4])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_exp4"
									tabindex="26"
									value="<%=Helper.correctNull((String)rowOP6[4])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
							</tr>
							<tr>
								<td align="center">06</td>
								<td>Provision for contingencies</td>
								<td>
								<div align="center"><input type="text" name="txt_exp1"
									value="<%=Helper.correctNull((String)rowOP3[5])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									tabindex="27" onBlur="calTotal()" style="text-align:right"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_exp2"
									tabindex="28"
									value="<%=Helper.correctNull((String)rowOP4[5])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_exp3"
									tabindex="29"
									value="<%=Helper.correctNull((String)rowOP5[5])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_exp4"
									tabindex="30"
									value="<%=Helper.correctNull((String)rowOP6[5])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
							</tr>
							<tr>
								<td align="center">07</td>
								<td nowrap>Depreciation : <!--<br>
                          On hull at 
                          <input type="text"
													name="txt_eco_value" tabindex="40" 
													value="<%=Helper.correctNull((String)rowEcoVal[10])%>" 
													size="10"
													maxlength="3"  onKeyPress="checkPercentage(this)" 
													style="text-align:right">
                          % On Engine 
                          <input type="text"
													name="txt_eco_value" tabindex="40" 
													value="<%=Helper.correctNull((String)rowEcoVal[11])%>" 
													size="10"
													maxlength="3"  onKeyPress="checkPercentage(this)" 
													style="text-align:right">
                          % On tackles and gears at 
                          <input type="text"
													name="txt_eco_value" tabindex="40" 
													value="<%=Helper.correctNull((String)rowEcoVal[12])%>" 
													size="10"
													maxlength="3"  onKeyPress="checkPercentage(this)" 
													style="text-align:right">
                          %--></td>
								<td>
								<div align="center"><input type="text" name="txt_exp1"
									tabindex="31"
									value="<%=Helper.correctNull((String)rowOP3[6])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_exp2"
									tabindex="32"
									value="<%=Helper.correctNull((String)rowOP4[6])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_exp3"
									tabindex="33"
									value="<%=Helper.correctNull((String)rowOP5[6])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_exp4"
									tabindex="34"
									value="<%=Helper.correctNull((String)rowOP6[6])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
							</tr>
							<tr>
								<td align="center">08</td>
								<td>Transport cost for marketing fish</td>
								<td>
								<div align="center"><input type="text" name="txt_exp1"
									tabindex="35"
									value="<%=Helper.correctNull((String)rowOP3[7])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_exp2"
									tabindex="36"
									value="<%=Helper.correctNull((String)rowOP4[7])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_exp3"
									tabindex="37"
									value="<%=Helper.correctNull((String)rowOP5[7])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_exp4"
									tabindex="38"
									value="<%=Helper.correctNull((String)rowOP6[7])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
							</tr>
							<tr>
								<td align="center">09</td>
								<td>Sales commission <!-- at 
                          <input type="text"
													name="txt_eco_value" tabindex="40" 
													value="<%=Helper.correctNull((String)rowEcoVal[13])%>" 
													 size="10"
													maxlength="3"  onKeyPress="checkPercentage(this)" 
													style="text-align:right">
                          %--></td>
								<td>
								<div align="center"><input type="text" name="txt_exp1"
									tabindex="39"
									value="<%=Helper.correctNull((String)rowOP3[8])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									style="text-align:right"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_exp2"
									tabindex="40"
									value="<%=Helper.correctNull((String)rowOP4[8])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_exp3"
									tabindex="41"
									value="<%=Helper.correctNull((String)rowOP5[8])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_exp4"
									tabindex="42"
									value="<%=Helper.correctNull((String)rowOP6[8])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
							</tr>
							<tr>
								<td align="center">10</td>
								<td>Other expenses like port charges, registration etc,</td>
								<td>
								<div align="center"><input type="text" name="txt_exp1"
									tabindex="43"
									value="<%=Helper.correctNull((String)rowOP3[9])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_exp2"
									tabindex="44"
									value="<%=Helper.correctNull((String)rowOP4[9])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_exp3"
									tabindex="45"
									value="<%=Helper.correctNull((String)rowOP5[9])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_exp4"
									tabindex="46"
									value="<%=Helper.correctNull((String)rowOP6[9])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div>
								</td>
							</tr>
							<tr>
								<td align="center">11</td>
								<td>cost of purchase of fingerling's</td>
								<td><div align="center"><input type="text" name="txt_exp1" tabindex="47"
									value="<%=Helper.correctNull((String)rowOP3[10])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div></td>
								<td><div align="center"><input type="text" name="txt_exp2" tabindex="48"
									value="<%=Helper.correctNull((String)rowOP4[10])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div></td>
								<td><div align="center"><input type="text" name="txt_exp3" tabindex="49"
									value="<%=Helper.correctNull((String)rowOP5[10])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div></td>
								<td align="center"><input type="text" name="txt_exp4"
									tabindex="50"
									value="<%=Helper.correctNull((String)rowOP6[10])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></td>
							</tr>
							<tr>
								<td align="center">12</td>
								<td>Cost of feeding for fingerling's</td>
								<td><div align="center"><input type="text" name="txt_exp1" tabindex="51"
									value="<%=Helper.correctNull((String)rowOP3[11])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div></td>
								<td><div align="center"><input type="text" name="txt_exp2" tabindex="52"
									value="<%=Helper.correctNull((String)rowOP4[11])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div></td>
								<td><div align="center"><input type="text" name="txt_exp3" tabindex="53"
									value="<%=Helper.correctNull((String)rowOP5[11])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div></td>
								<td align="center"><input type="text" name="txt_exp4"
									tabindex="54"
									value="<%=Helper.correctNull((String)rowOP6[11])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></td>
							</tr>
							
							<tr>
								<td align="center">13</td>
								<td>Other Expenses</td>
								<td><div align="center"><input type="text" name="txt_exp1" tabindex="55"
									value="<%=Helper.correctNull((String)rowOP3[12])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div></td>
								<td><div align="center"><input type="text" name="txt_exp2" tabindex="56"
									value="<%=Helper.correctNull((String)rowOP4[12])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div></td>
								<td><div align="center"><input type="text" name="txt_exp3" tabindex="57"
									value="<%=Helper.correctNull((String)rowOP5[12])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></div></td>
								<td align="center"><input type="text" name="txt_exp4"
									tabindex="58"
									value="<%=Helper.correctNull((String)rowOP6[12])%>"
									onKeyPress="allowNumber(this)" size="15" maxlength="9"
									onBlur="calTotal()" style="text-align:right"></td>
							</tr>
							<tr>
								<td align="center">&nbsp;</td>
								<td><b>Total expenditure</b></td>
								<td>
								<div align="center"><input type="text" name="txt_total_exp1"
									value="" readOnly size="15" maxlength="9"
									style="text-align:right"  tabindex="59"> </div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_total_exp2"
									value="" onKeyPress="allowNumber(this)" size="15" maxlength="9"
									style="text-align:right"  tabindex="60"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_total_exp3"
									value="" onKeyPress="allowNumber(this)" size="15" maxlength="9"
									style="text-align:right"  tabindex="61"></div>
								</td>
								<td>
								<div align="center"><input type="text" name="txt_total_exp4"
									value="" onKeyPress="allowNumber(this)" size="15" maxlength="9"
									style="text-align:right"  tabindex="62"></div>
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
<BR>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid="<%=PageId%>"/>
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("auditFlag"))%>">
</form>
</body>
</html>



