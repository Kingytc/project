<%@include file = "../share/directives.jsp"%>

<%
String measurement = Helper.correctNull((String) hshValues
					.get("landmeasurement"));
	
%>
<html>
<head>
<title>Farm Mechanisation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var selprop = "<%=Helper.correctNull((String)hshValues.get("agr_selproposed"))%>";
var seldriv = "<%=Helper.correctNull((String)hshValues.get("agr_seldrive"))%>";
var measure = "<%=Helper.correctNull((String)hshValues.get("landmeasurement"))%>";
var selnetamt = "<%=Helper.correctNull((String)hshValues.get("agr_selnetamt"))%>";
var agr_panel = "<%=Helper.correctNull((String)hshValues.get("agr_panel"))%>";
var agr_vehicle="<%=Helper.correctNull((String)hshValues.get("agr_farmvehicle"))%>";

var varmintractorhours="<%=Helper.correctNull((String)hshValues.get("tractorhours"))%>";
var varminharvestorhours="<%=Helper.correctNull((String)hshValues.get("combineharvestorhours"))%>";
var varminpowertillerhours="<%=Helper.correctNull((String)hshValues.get("powertillerhours"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
</script>
<script>


function callLoad()
{	
	document.all.r1.style.visibility="hidden";
	document.all.r2.style.visibility="hidden";
	document.all.r3.style.visibility="hidden";
	document.all.r4.style.visibility="hidden";
	document.all.r5.style.visibility="hidden";
		
	if(selprop!="")
	{
		document.forms[0].sel_proposed.value=selprop;
		document.forms[0].sel_drive.value=seldriv;
	}
	if(selprop=="2")
	{
		document.all.r1.style.visibility="visible";
		document.all.r2.style.visibility="visible";
	}
	if(seldriv=="2")
	{
		document.all.r3.style.visibility="visible";
		document.all.r4.style.visibility="visible";
		document.all.r5.style.visibility="hidden";
	}
	
	if(agr_panel!="")
	{
		document.forms[0].sel_branch.value=agr_panel;
	}
	else
	{
			document.forms[0].sel_branch.value="s";
	}
	if(agr_vehicle!="")
	{
		document.forms[0].sel_vehicle.value=agr_vehicle;
	}
	else
	{
		document.forms[0].sel_vehicle.value="0";
	}
	disablefields(true);
}


function doEdit()
{
 	disablefields(false);
	document.forms[0].hidAction.value ="insert"; 
	document.forms[0].hideditflag.value="Y";
	enableButtons(true, false, false, false, true);
}



function doCancel()
{
if(ConfirmMsg(102))
	{
   	document.forms[0].hidBeanId.value="agreconomic";
	document.forms[0].hidAction.value="cancel";
	document.forms[0].hidBeanGetMethod.value="getfarmMechTechData";
	document.forms[0].action=appURL+"action/agr_farmMechTechAspect.jsp";
	document.forms[0].submit();
	}
}

function doDelete()
{
if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appURL+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updatefarmMechTechData";
	document.forms[0].hidBeanGetMethod.value="getfarmMechTechData";
	document.forms[0].hidBeanId.value="agreconomic";
	document.forms[0].hidSourceUrl.value="action/agr_farmMechTechAspect.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();		
	}
}

function enableButtons(bool1, bool2, bool3, bool4, bool5)
{	
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled = bool5;
}

function doClose()
{
	if( ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/"+"retailpge.jsp";				
		document.forms[0].submit();
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
	 	if(document.forms[0].elements[i].type=='checkbox')
	 	{
			document.forms[0].elements[i].disabled=one;
	 	}
	}
	document.forms[0].txt_cmember.readOnly=true;
}


function doSave()
{
	if(document.forms[0].sel_vehicle.value=="0")
	{
		ShowAlert(111,'Farm Machinery to be purchased');
		document.forms[0].sel_vehicle.focus();
		return;
	}
	
	var len = document.forms[0].sel_vehicle.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_vehicle.options[i].selected==true)
		 {
			 document.forms[0].sel_vehicle1.value = document.forms[0].sel_vehicle.options[i].text; 
			break;
		 }
	}
	var ownacre=document.forms[0].txt_olandacre.value;
	var owncents=document.forms[0].txt_ocents.value;
	
	var famacre=document.forms[0].txt_omember.value;
	var famcents=document.forms[0].txt_omembercents.value;
	
	var leasacre=document.forms[0].txt_clandacre.value;
	var leascents=document.forms[0].txt_ccents.value;
	
	if(ownacre=="0" && owncents=="0" && famacre=="0" && famcents=="0" && leasacre=="0" && leascents=="0" ||
		 ownacre=="" && owncents=="" && famacre=="" && famcents=="" && leasacre=="" && leascents=="")
	{
		alert("Enter values for Total acreage to be covered");
		return false;	
	} 
	
	var onfarm=document.forms[0].txt_omachinery.value;
	var offfarm=document.forms[0].txt_cmachinery.value;
	if(	onfarm=="0" &&offfarm=="0" ||onfarm=="" && offfarm=="")
	{
		alert("Enter no. of hours to be used manually");
		return false;
	}

	var totfarm=eval(onfarm)+eval(offfarm);
	
	if(document.forms[0].sel_vehicle.value=="1")
	{
		if(totfarm < varmintractorhours)
		{
			alert("Total working Hours of Tractor should be greater than Minimum Hours ");
			return false;
		}
	}
	
	if(document.forms[0].sel_vehicle.value=="2")
	{
		if(totfarm < varminpowertillerhours)
		{
			alert("Total working Hours of power tiller should be greater than Minimum Hours ");
			return false;
		}
	}
	if(document.forms[0].sel_vehicle.value=="5")
	{
		if(totfarm < varminharvestorhours)
		{
			alert("Total working Hours of combine harvestors should be greater than Minimum Hours ");
			return false;
		}
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidBeanId.value="agreconomic";		
	document.forms[0].hidSourceUrl.value="/action/agr_farmMechTechAspect.jsp";
	document.forms[0].hidBeanMethod.value="updatefarmMechTechData";
	document.forms[0].hidBeanGetMethod.value="getfarmMechTechData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function propreason()
{
	if(document.forms[0].sel_proposed.value=="2")
	{
		document.all.r1.style.visibility="visible";
		document.all.r2.style.visibility="visible";
	}
	else
	{
		document.all.r1.style.visibility="hidden";
		document.all.r2.style.visibility="hidden";
		document.forms[0].txt_reason.value="";
	}
	
}

function seldrive()
{
	if(document.forms[0].sel_drive.value=="2")
	{
		document.all.r3.style.visibility="visible";
		document.all.r4.style.visibility="visible";
		document.all.r5.style.visibility="visible";
	}
	else
	{
		document.all.r3.style.visibility="hidden";
		document.all.r4.style.visibility="hidden";
		document.all.r5.style.visibility="hidden";
		document.forms[0].txt_salary.value="";
	}
	
}

function measurecalc(obj)
{
	if(measure=="g")
	{	
		if(obj.value > 39)
		{
			alert("Enter below 39");
			obj.focus();
			return;
		}
	}
	else if(measure=="c")
	{	
		
		if(obj.value > 99)
		{
			alert("Enter below 99");	
			obj.focus();
			return;
		}
	}
}

function calcIncome(val1,val2)
{	
	var total;
	var value1=val1.value;
	var value2=val2.value;
	total=eval(value1)*eval(value2);
	document.forms[0].txt_cmember.value=NanNumber(total);
	roundtxt(document.forms[0].txt_cmember);
	
}

function checkOriginalCostLeast()
{
	var txt_originalcost = document.forms[0].txt_originalcost.value;
	var txt_valuationvechi = document.forms[0].txt_valuationvechi.value;
	if(txt_originalcost=="")
		txt_originalcost="0";
	if(txt_valuationvechi=="")
		txt_valuationvechi="0";
	if(eval(txt_originalcost)<eval(txt_valuationvechi))
		document.forms[0].txt_leastvalue.value=txt_originalcost;
	else
		document.forms[0].txt_leastvalue.value=txt_valuationvechi;
				
}

</script>

</head>
<body onload="callLoad()">
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellpadding="5" cellspacing="0" class="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td colspan="9"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
              
                <tr> 
                  <td width="23%" colspan="2">Farm Machinery to be purchased
                  	<b><span class="mantatory">*</font></b></td>
                  <td colspan="6"> 
                    <select name="sel_vehicle">
                      <option value="0">--select-- </option>
                      <option value="1">Tractor</option>
                      <option value="2">Power Tiller</option>
                      <option value="3">Harvestor</option>
                      <option value="4">Dust sprayers</option>
                      <option value="5">Combine Harvestor</option>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td colspan="8"><b>Total 
                    acreage to be covered</b></td>
                </tr>
                <tr> 
                  <td width="23%" colspan="2">Own 
                    Land</td>
                  <td width="11%"> 
                    <input type="text" name="txt_olandacre"
							value="<%=Helper.correctNull((String)hshValues.get("agr_olandacre"))%>"
							size="10" onKeyPress="allowInteger()" maxlength="4"
							style="text-align:right">
                    Acre</td>
                  <td nowrap colspan="2"> 
                    <input type="text" name="txt_ocents"
							value="<%=Helper.correctNull((String)hshValues.get("agr_oguntas"))%>"
							size="10" maxlength="2" onKeyPress="allowDecimals(this)"
							onBlur="measurecalc(this)" style="text-align:right">
                    <%if (measurement.equalsIgnoreCase("g")) {
				out.println("Guntas");
			} else {
				out.println("Cents");
			}

			%>
                  </td>
                  <td width="21%">&nbsp;</td>
                  <td width="11%">&nbsp;</td>
                  <td width="17%">&nbsp;</td>
                </tr>
                <tr> 
                  <td nowrap width="23%" colspan="2">Family 
                    Holding</td>
                  <td width="11%"> 
                    <input type="text" name="txt_omember"
							value="<%=Helper.correctNull((String)hshValues.get("agr_omember"))%>"
							size="10" onKeyPress="allowInteger()" maxlength="4"
							style="text-align:right">
                     Acre</td>
                  <td colspan="2"> 
                    <input type="text" name="txt_omembercents"
							value="<%=Helper.correctNull((String)hshValues.get("agr_omem_guntas"))%>"
							size="10" maxlength="2" onKeyPress="allowDecimals(this)"
							onBlur="measurecalc(this)" style="text-align:right">
                    <%if (measurement.equalsIgnoreCase("g")) {
				out.println("Guntas");
			} else {
				out.println("Cents");
			}

			%>
                  </td>
                  <!--<td>Usage of Tractor / Machinery(Hrs/Year)</font><font size="1"
			face="MS Sans Serif"> </font></td>
                  <td width="10%"><font size="1"
			face="MS Sans Serif"> 
                    <input type="text" name="txt_omembermachin"
			value="<%=Helper.correctNull((String)hshValues.get("agr_omem_machinery"))%>" size="10"
			onKeyPress="allowInteger()" maxlength="5" 	style="text-align:right">
                    </font></td>-->
                  <td width="21%">&nbsp;</td>
                  <td width="11%">&nbsp;</td>
                  <td width="17%">&nbsp;</td>
                </tr>
                <tr> 
                  <td nowrap width="23%" colspan="2">Leased/Share 
                    cropper</td>
                  <td width="11%"> 
                    <input type="text" name="txt_clandacre"
							value="<%=Helper.correctNull((String)hshValues.get("agr_clandacre"))%>"
							size="10" onKeyPress="allowInteger()" maxlength="4"
							style="text-align:right">
                    Acre</td>
                  <td colspan="2"> 
                    <input type="text" name="txt_ccents"
							value="<%=Helper.correctNull((String)hshValues.get("agr_cguntas"))%>"
							size="10" maxlength="2" onKeyPress="allowDecimals(this)"
							onBlur="measurecalc(this)" style="text-align:right">
                    <%if (measurement.equalsIgnoreCase("g")) {
				out.println("Guntas");
			} else {
				out.println("Cents");
			}

			%>
                  </td>
                  <td width="21%">&nbsp;</td>
                  <td width="11%">&nbsp;</td>
                  <td width="17%">&nbsp;</td>
                </tr>
                <tr> 
                  <td nowrap width="23%" colspan="2">&nbsp;</td>
                  <td width="11%">&nbsp;</td>
                  <td colspan="2">&nbsp;</td>
                  <td width="21%">&nbsp;</td>
                  <td width="11%">&nbsp;</td>
                  <td width="17%">&nbsp;</td>
                </tr>
                <tr> 
                  <td colspan="3"><b>No. of hours to be used annually</b></td>
                  <td colspan="2">&nbsp;</td>
                  <td colspan="3">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="23%" colspan="2">On 
                    farm operations (Hrs/Year)</td>
                  <td width="11%">
                    <input
							type="text" name="txt_omachinery"
							value="<%=Helper.correctNull((String)hshValues.get("agr_omachinery"))%>"
							size="10" onKeyPress="allowInteger()" maxlength="5"
							style="text-align:right">
                    </td>
                  <td colspan="2">&nbsp;</td>
                  <td colspan="3">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="23%" colspan="2">Off 
                    farm operations (Hrs/Year)</td>
                  <td width="11%">
                    <input
							type="text" name="txt_cmachinery"
							value="<%=Helper.correctNull((String)hshValues.get("agr_cmachinery"))%>"
							size="10" onKeyPress="allowInteger()" maxlength="5"
							style="text-align:right"
							onchange="calcIncome(document.forms[0].txt_cmachinery,document.forms[0].txt_ratehour)">
                   </td>
                  <td width="15%">Rate/hour</td>
                  <td width="2%"><b><%=ApplicationParams.getCurrency()%></b> 
                    </td>
                  <td colspan="3"><lapschoice:CurrencyTag
							name="txt_ratehour"
							value='<%=Helper.correctNull((String)hshValues.get("agr_ratehour"))%>'
							size="10" maxlength="5" onChange="calcIncome(document.forms[0].txt_cmachinery,document.forms[0].txt_ratehour)" /> 
                   </td>
                </tr>
                <tr> 
                  <td nowrap width="21%">Income 
                    from Hiring</td>
                  <td nowrap width="2%"><b><%=ApplicationParams.getCurrency()%></b></td>
                  <td width="11%"> <lapschoice:CurrencyTag name="txt_cmember"
							value='<%=Helper.correctNull((String)hshValues.get("agr_cmember"))%>'
							size="10" maxlength="8" /> </td>
                  <td colspan="2">&nbsp;</td>
                  <td colspan="3">&nbsp;</td>
                </tr>
                <tr> 
                  <td colspan="2">Whether 
                    agri implements are proposed to be purchase along with Tractor 
                    / Power Tiller</td>
                  <td>
                    <select
							name="sel_proposed" onChange="propreason()">
                      <option value="1" selected>Yes</option>
                      <option value="2">No</option>
                    </select>
                    </td>
                        <td id="r1">Reason</td>
                        <td id="r2" colspan="2"> 
                          <textarea name="txt_reason" rows="2"
									cols="25" onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues.get("agr_reason"))%> </textarea>
                        </td>
                      </tr>
                <tr> 
                  <td width="23%" colspan="2">Who 
                    will drive the Tractor / Power Tiller/Agricultural Machinary</td>
                  <td width="11%">
                    <select name="sel_drive"
							onChange="seldrive()">
                      <option value="1" selected>Self</option>
                      <option value="2">Others</option>
                    </select>
                    </td>
                  <td id="r3" width="20%">Salary 
                    / Year</td>
                  <td id="r5" width="2%"><b><%=ApplicationParams.getCurrency()%></b></td>
                  <td id="r4" width="21%">
                    <lapschoice:CurrencyTag name="txt_salary"
							value='<%=Helper.correctNull((String)hshValues.get("agr_salary"))%>'
							size="10" maxlength="9" /></td>
                  <td width="11%">&nbsp;</td>
                  <td width="17%">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="23%" colspan="2">Whether 
                    Driving License is held</td>
                  <td width="11%"> 
                    <select
							name="sel_license" onChange="">
                      <option value="1" selected>Yes</option>
                      <option value="2">No</option>
                    </select>
                    </td>
                  <td nowrap colspan="2">&nbsp;</td>
                  <td width="21%">&nbsp; </td>
                  <td width="11%">&nbsp;</td>
                  <td width="17%">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="21%">Cost of 
                    Maintanence of bullocks per annum (<b>BM</b>)</td>
                  <td width="2%"><b><%=ApplicationParams.getCurrency()%></b></td>
                  <td width="11%"> <lapschoice:CurrencyTag name="txt_bullckbm" size="10" maxlength="8"
							value='<%=Helper.correctNull((String)hshValues.get("agr_bullock_costbm"))%>'/> 
                  </td>
                  <td>Cost of Maintanence 
                    of bullocks per annum (<b>AM</b>)</td>
                  <td><b><%=ApplicationParams.getCurrency()%></b></td>
                  <td width="21%"> <lapschoice:CurrencyTag name="txt_bullck" size="10" maxlength="8"
							value='<%=Helper.correctNull((String)hshValues.get("agr_bullock_cost"))%>'/> 
                  </td>
                  <td width="11%">&nbsp;</td>
                  <td width="17%">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="21%">Interest 
                    on Crop Loan (<b>BM</b>)</td>
                  <td width="2%"><b><%=ApplicationParams.getCurrency()%></b></td>
                  <td width="11%"> <lapschoice:CurrencyTag name="txt_interestbm" size="10" maxlength="10"
							value='<%=Helper.correctNull((String)hshValues.get("agr_interestbm"))%>'/> 
                  </td>
                  <td>Interest on Crop Loan 
                    (<b>AM</b>)</td>
                  <td><b><%=ApplicationParams.getCurrency()%></b></td>
                  <td width="21%"> <lapschoice:CurrencyTag name="txt_interest" size="10" maxlength="10"
							value='<%=Helper.correctNull((String)hshValues.get("agr_interest"))%>'/> 
                  </td>
                  <td width="11%">&nbsp;</td>
                  <td width="17%">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="21%">Cost of 
                    Repairs of Machinery/year (<b>AM</b>)</td>
                  <td width="2%"><b><%=ApplicationParams.getCurrency()%></b></td>
                  <td width="11%"> <lapschoice:CurrencyTag name="txt_costrepair" size="10"
							maxlength="8"
							value='<%=Helper.correctNull((String)hshValues.get("agr_repair_cost"))%>'/> 
                  </td>
                  <td>Cost of fuel for Machinery/year (<b>AM</b>)</td>
                  <td><b><%=ApplicationParams.getCurrency()%></b></td>
                  <td width="21%"> <lapschoice:CurrencyTag name="txt_costfuel" size="10" maxlength="8"
							value='<%=Helper.correctNull((String)hshValues.get("agr_fuel_cost"))%>' /> 
                  </td>
                  <td width="11%">&nbsp;</td>
                  <td width="17%">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="21%">Insurance 
                    and Taxes/year (<b>AM</b>)</td>
                  <td width="2%"><b><%=ApplicationParams.getCurrency()%></b></td>
                  <td width="11%"> <lapschoice:CurrencyTag name="txt_insurence" size="10"
							maxlength="8"
							value='<%=Helper.correctNull((String)hshValues.get("agr_insurence"))%>' /> 
                  </td>
                  <td>Others (<b>AM</b>)</td>
                  <td><b><%=ApplicationParams.getCurrency()%></b></td>
                  <td width="21%"> <lapschoice:CurrencyTag name="txt_others" size="10" maxlength="8"
							value='<%=Helper.correctNull((String)hshValues.get("agr_other_cost"))%>' /> 
                  </td>
                  <td width="11%">&nbsp;</td>
                  <td width="17%">&nbsp;</td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td colspan="9"><b>If Second Hand 
              </b></td>
          </tr>
          <tr> 
            <td width="14%" colspan="2">Age 
              of Vehicle</td>
            <td width="18%"> 
              <input type="text" name="txt_age" size="5"
					maxlength="2"
					value="<%=Helper.correctNull((String)hshValues.get("agr_age"))%>"
					onKeyPress="allowInteger()">
            </td>
            <td width="16%" colspan="2">&nbsp;</td>
            <td width="17%">&nbsp;</td>
            <td width="19%" colspan="2">&nbsp;</td>
            <td width="16%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="12%">Original Cost 
              </td>
            <td width="2%"><b><%=ApplicationParams.getCurrency()%></b></td>
            <td width="18%"><lapschoice:CurrencyTag name="txt_originalcost" maxlength="10"
					value='<%=Helper.correctNull((String)hshValues.get("agr_originalcost"))%>' onBlur='checkOriginalCostLeast()' /> 
            </td>
            <td width="14%">Value as per valuer's 
              report</td>
            <td width="2%"><b><%=ApplicationParams.getCurrency()%></b></td>
            <td width="17%"><lapschoice:CurrencyTag name="txt_valuationvechi" maxlength="10"
					value='<%=Helper.correctNull((String)hshValues.get("agr_valuercost"))%>' onBlur='checkOriginalCostLeast()' /> 
            </td>
            <td width="17%">Least Value of 
              the above </td>
            <td width="2%"><b><%=ApplicationParams.getCurrency()%></b></td>
            <td width="16%"><lapschoice:CurrencyTag name="txt_leastvalue" maxlength="10"
					value='<%=Helper.correctNull((String)hshValues.get("agr_leastvalue"))%>' /> 
            </td>
          </tr>
          <tr> 
            <td width="14%" colspan="2">Registration 
              No.</td>
            <td width="18%"> 
              <input type="text" name="txt_regno" maxlength="23"
					value="<%=Helper.correctNull((String)hshValues.get("agr_regno"))%>">
            </td>
            <td width="16%" colspan="2">Chasis 
              No.</td>
            <td width="17%"> 
              <input type="text" name="txt_chasisno" maxlength="23"
					value="<%=Helper.correctNull((String)hshValues.get("agr_chasisno"))%>">
            </td>
            <td width="19%" colspan="2">Engine 
              No. </td>
            <td width="16%"> 
              <input type="text" name="txt_engineno" maxlength="23"
					value="<%=Helper.correctNull((String)hshValues.get("agr_engineno"))%>">
            </td>
          </tr>
          <tr> 
            <td width="14%" colspan="2">Name 
              of the Owner</td>
            <td width="18%"> 
              <input type="text" name="txt_owner" maxlength="40"
					value="<%=Helper.correctNull((String)hshValues.get("agr_owner"))%>"
					onKeyPress="notAllowSplChar()">
            </td>
            <td width="16%" colspan="2">Valuation 
              done by</td>
            <td width="17%"> 
              <input type="text" name="txt_valuationdone" maxlength="40"
					value="<%=Helper.correctNull((String)hshValues.get("agr_valuationdoneby"))%>"
					onKeyPress="notAllowSplChar()">
            </td>
            <td width="19%" colspan="2">Whether 
              valuer on the branch panel</td>
            <td width="16%">
              <select name="sel_branch">
                <option value="s">--select--</option>
                <option value="y">Yes</option>
                <option value="n">No</option>
              </select>
             </td>
          </tr>
          <tr> 
            <td colspan="9"><b>If Repair</b></td>
          </tr>
          <tr> 
            <td width="14%" colspan="2">Name of Garage/Mechanic</td>
            <td width="18%"> 
              <input type="text" name="txt_mechanic" size="30" maxlength="40"
					value="<%=Helper.correctNull((String)hshValues.get("txt_mechanic"))%>"
					onKeyPress="notAllowSplChar()">
            </td>
            <td width="16%" colspan="2">Distance from Village</td>
            <td width="17%">
              <input
							type="text" name="txt_mechdistance"
							value="<%=Helper.correctNull((String)hshValues.get("txt_mechdistance"))%>"
							size="10" maxlength="9" onKeyPress="allowNumber(this)"
							onBlur="" style="text-align:right">
              Km</td>
            <td width="19%" colspan="2">&nbsp;</td>
            <td width="16%">&nbsp;</td>
          </tr>
        </table>

		</td>
	</tr>
</table>
<br>
 <lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
 
<br>
<lapschoice:agrihiddentag pageid="<%=PageId%>"/>
<input type="hidden" name="sel_vehicle1"> 
<input type="hidden" name="radLoan" value="Y">
<input type="hidden" name="txtlandmeasurement" value="<%=Helper.correctNull((String)hshValues.get("landmeasurement"))%>">
<input type="hidden" name="hidRecordflag" > 
</form>


</body>
</html>

