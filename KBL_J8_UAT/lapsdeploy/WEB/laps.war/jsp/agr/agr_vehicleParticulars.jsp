<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>particulars of vehicles</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var selvehicletype = "<%=Helper.correctNull((String)hshValues.get("sel_vehicletype"))%>";
var selrepay = "<%=Helper.correctNull((String)hshValues.get("sel_repay"))%>";
var agr_panel = "<%=Helper.correctNull((String)hshValues.get("agr_panel"))%>";

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
		document.forms[0].action=appUrl+"action/"+"retailpge.jsp";				
		document.forms[0].submit();
	}
}

function doSave()
{
       if(document.forms[0].sel_vehicletype.value == "0")
		{
			alert("select Vehicle to be Purchased     ");
			document.forms[0].sel_vehicletype.focus();
			return;
		} 
			
		if(document.forms[0].txt_particulars.value == "")
		  {
		  alert("Particulars of Vehicle");
		  document.forms[0].txt_particulars.focus();
		  return;
		  }	
			
		enableButtons(true, true, true, true, false);
	document.forms[0].hidBeanId.value="agreconomic";		
	document.forms[0].hidSourceUrl.value="/action/agr_vehicleParticulars.jsp";
	document.forms[0].hidBeanMethod.value="updateVehicleParticulars";
	document.forms[0].hidBeanGetMethod.value="getVehicleParticulars";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();	
}

function doEdit()
{
	disableFields(false);
	document.forms[0].hidAction.value ="update"; 
	document.forms[0].hideditflag.value="Y";
	document.forms[0].txt_totestimcost.readOnly=true;
	document.forms[0].txt_totmargin.readOnly=true;
	document.forms[0].txt_totloanamt.readOnly=true;
	enableButtons(true, false, false, false, true);
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidBeanGetMethod.value="getVehicleParticulars";
		document.forms[0].action=appUrl +"action/agr_vehicleParticulars.jsp";
		document.forms[0].submit(); 	
	}
}

function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updateVehicleParticulars";
		document.forms[0].hidBeanGetMethod.value="getVehicleParticulars";
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidSourceUrl.value="/action/agr_vehicleParticulars.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	} 
}
	
function disableFields(one)
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

function onloading()
{
	disableFields(true);
	if(selvehicletype!="")
	{
		document.forms[0].sel_vehicletype.value=selvehicletype;
	}
	else
	{
		document.forms[0].sel_vehicletype.value="0";
	}
	if(agr_panel!="")
	{
		document.forms[0].sel_branch.value=agr_panel;
	}
	else
	{
		document.forms[0].sel_branch.value="s";
	}	
}

function totalEstim()
{
	var estimtemp1 = document.forms[0].txt_estimcost.value;
	var estimtemp2 = document.forms[0].txt_estimcost1.value;
	if(estimtemp1=="")
	{
		estimtemp1=0;
	}
	if(estimtemp2=="")
	{
		estimtemp2=0;
	}
	totestimcost = eval(estimtemp1) + eval(estimtemp2);
	document.forms[0].txt_totestimcost.value=totestimcost;
}

function totalMargin()
{
	var margintemp1 = document.forms[0].txt_margin.value;
	var margintemp2 = document.forms[0].txt_margin1.value;
	if(margintemp1=="")
	{
		margintemp1=0;
	}
	if(margintemp2=="")
	{
		margintemp2=0;
	}
	totmargincost = eval(margintemp1) + eval(margintemp2);
	document.forms[0].txt_totmargin.value=totmargincost;
}

function totalLoanAmount()
{
	var loantemp1 = document.forms[0].txt_loanamt.value;
	var loantemp2 = document.forms[0].txt_loanamt1.value;
	if(loantemp1=="")
	{
		loantemp1=0;
	}
	if(loantemp2=="")
	{
		loantemp2=0;
	}
	totloancost = eval(loantemp1) + eval(loantemp2);
	document.forms[0].txt_totloanamt.value=totloancost;
}

function showParticulars()
{
	if(document.forms[0].sel_vehicletype.value=="1" || document.forms[0].sel_vehicletype.value=="0")
	{
		document.all.part1.style.visibility="visible";
		document.all.part2.style.visibility="hidden";
		
		document.all.reg1.style.visibility="hidden";
		document.all.reg2.style.visibility="hidden";
		document.all.reg3.style.visibility="hidden";
			
		document.all.second1.style.visibility="hidden";
		document.all.second1.style.position="absolute";
		document.all.second2.style.visibility="hidden";
		document.all.second2.style.position="absolute";
		document.all.second3.style.visibility="hidden";
		document.all.second3.style.position="absolute";
		document.all.second4.style.visibility="hidden";
		document.all.second4.style.position="absolute";
		document.all.second5.style.visibility="hidden";
		document.all.second5.style.position="absolute";
		document.all.repair1.style.visibility="hidden";
		document.all.repair1.style.position="absolute";
		document.all.repair2.style.visibility="hidden";
		document.all.repair2.style.position="absolute";
		document.forms[0].txt_regno.value="";
		document.forms[0].txt_age.value="";
		document.forms[0].txt_chasisno.value="";
		document.forms[0].txt_engineno.value="";
		document.forms[0].txt_owner.value="";
		document.forms[0].txt_valuationdone.value="";
		document.forms[0].txt_leastvalue.value="";
		document.forms[0].txt_originalcost.value="";
		document.forms[0].txt_valuationvechi.value="";
		document.forms[0].sel_branch.value="s";
		document.forms[0].txt_mechanic.value="";
		document.forms[0].txt_mechdistance.value="";
	}
	else if(document.forms[0].sel_vehicletype.value=="2")
	{
		document.all.part1.style.visibility="hidden";
		document.all.part2.style.visibility="visible";
		
		document.all.reg1.style.visibility="visible";
		document.all.reg2.style.visibility="visible";
		document.all.reg3.style.visibility="visible";
			
		document.all.second1.style.visibility="visible";
		document.all.second1.style.position="relative";
		document.all.second2.style.visibility="visible";
		document.all.second2.style.position="relative";
		document.all.second3.style.visibility="visible";
		document.all.second3.style.position="relative";
		document.all.second4.style.visibility="visible";
		document.all.second4.style.position="relative";
		document.all.second5.style.visibility="visible";
		document.all.second5.style.position="relative";
		document.all.repair1.style.visibility="hidden";
		document.all.repair1.style.position="absolute";
		document.all.repair2.style.visibility="hidden";
		document.all.repair2.style.position="absolute";
		document.forms[0].txt_mechanic.value="";
		document.forms[0].txt_mechdistance.value="";
	}
	else if(document.forms[0].sel_vehicletype.value=="3")
	{
		document.all.part1.style.visibility="hidden";
		document.all.part2.style.visibility="visible";
		
		document.all.reg1.style.visibility="visible";
		document.all.reg2.style.visibility="visible";
		document.all.reg3.style.visibility="visible";
			
		document.all.second1.style.visibility="hidden";
		document.all.second1.style.position="absolute";
		document.all.second2.style.visibility="hidden";
		document.all.second2.style.position="absolute";
		document.all.second3.style.visibility="hidden";
		document.all.second3.style.position="absolute";
		document.all.second4.style.visibility="hidden";
		document.all.second4.style.position="absolute";
		document.all.second5.style.visibility="hidden";
		document.all.second5.style.position="absolute";
		document.all.repair1.style.visibility="visible";
		document.all.repair1.style.position="relative";
		document.all.repair2.style.visibility="visible";
		document.all.repair2.style.position="relative";
		document.forms[0].txt_regno.value="";
		document.forms[0].txt_age.value="";
		document.forms[0].txt_chasisno.value="";
		document.forms[0].txt_engineno.value="";
		document.forms[0].txt_owner.value="";
		document.forms[0].txt_valuationdone.value="";
		document.forms[0].txt_leastvalue.value="";
		document.forms[0].txt_originalcost.value="";
		document.forms[0].txt_valuationvechi.value="";
		document.forms[0].sel_branch.value="s";
	}
}

function totalLoanAmt()
{
	var estimcost =  document.forms[0].txt_estimcost.value;
	if(estimcost=="")
	{
		estimcost=0;
	}
	var estimcost1 =  document.forms[0].txt_estimcost1.value;
	if(estimcost1=="")
	{
		estimcost1=0;
	}
	var margincost =  document.forms[0].txt_margin.value;
	if(margincost=="")
	{
		margincost=0;
	}
	var margincost1 =  document.forms[0].txt_margin1.value;
	if(margincost1=="")
	{
		margincost1=0;
	}
	
	var loanamt = eval(estimcost) - eval(margincost);
	var loanamt1 =  eval(estimcost1) - eval(margincost1);
	
	document.forms[0].txt_loanamt.value=loanamt;
	document.forms[0].txt_loanamt1.value=loanamt1;
}

function checkMargin1()
{
	var estcost = document.forms[0].txt_estimcost.value;
	if(estcost=="")
	{
		estcost=0;
	}
	var marcost = document.forms[0].txt_margin.value;
	if(marcost=="")
	{
		marcost=0;
	}
	if(document.forms[0].sel_vehicletype.value=="1")
	{
		var tempMarg = (eval(estcost) * 10) / 100 ;
		if(eval(marcost) < eval(tempMarg))
		{
			alert("Margin of New Vehicle is Less than 10%");
		}
	}
	else if(document.forms[0].sel_vehicletype.value=="2")
	{
		var tempMarg = (eval(estcost) * 25) / 100 ;
		if(eval(marcost) < eval(tempMarg))
		{
			alert("Margin of Second Hand Vehicle is Less than 25%");
		}
	}
}


function checkMargin2()
{
	var estcost = document.forms[0].txt_estimcost1.value;
	if(estcost=="")
	{
		estcost=0;
	}
	var marcost = document.forms[0].txt_margin1.value;
	if(marcost=="")
	{
		marcost=0;
	}
	if(document.forms[0].sel_vehicletype.value=="1")
	{
		var tempMarg = (eval(estcost) * 10) / 100 ;
		if(eval(marcost) < eval(tempMarg))
		{

			alert("Margin of New Vehicle is Less than 10%");
		}
	}
	else if(document.forms[0].sel_vehicletype.value=="2")
	{
		var tempMarg = (eval(estcost) * 25) / 100 ;
		if(eval(marcost) < eval(tempMarg))
		{
			alert("Margin of Second Hand Vehicle is Less than 25%");
		}
	}
}

</script>
<style type="text/css">
DIV.cellContainer {	
  width: 100%; height: 250;
  overflow: auto;
}
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="onloading();showParticulars()">
<form class="normal" name="frmpri" method="post">
<table class="outertable border1" align="center" width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr> 
                  <td> 
              <table class="outertable" align="center" width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr> 
                  <td colspan="6"> 
                    <table class="outertable"  align="center" width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td height="22" colspan="6" align="center"><b>Particulars 
                          of Vehicle</b></font></td>
                      </tr>
                      <tr> 
                        <td colspan="6" align="center" > 
                          <table class="outertable" width="55%" border="0">
                            <tr> 
                              <td width="53%" align="center">Vehicle 
                                to be Purchased</td>
                              <td width="47%"> 
                                <select name="sel_vehicletype" onChange="showParticulars()">
                                  <option value="0" selected>---Select---</option>
                                  <option value="1">Brand New</option>
                                  <option value="2">Second Hand</option>
                                  <option value="3">Repairs</option>
                                </select>
                                </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr class="dataheader"> 
                        <td width="14%" align="center" ><font
									id="part1"> 
                          Particulars of Brand New Vehicle</font> <font	id="part2"> 
                          Particulars of Second Hand Vehicle</font></td>
                        <td align="center" >Model 
                          </td>
                        <td align="center"  ><font id="reg1">&nbsp;Year 
                          of First Registration</font></td>
                        <td width="12%" align="center" >Estimated 
                          Cost / Value As Per Valuation Report</td>
                        <td width="12%" align="center" >Margin</td>
                        <td width="12%" align="center" >Loan 
                          Amount </td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center"> 
                          <input type="text" name="txt_particulars"
									value="<%=Helper.correctNull((String)hshValues.get("agr_particulars"))%>" size="20" maxlength="30" style="text-align:left">
                        </td>
                        <td width="12%" align="center"> 
                          <input type="text"
									name="txt_make" value="<%=Helper.correctNull((String)hshValues.get("agr_make"))%>" size="10" maxlength="4"
									onKeyPress="allowInteger()" style="text-align:right">
                          </td>
                        <td width="12%" align="center"> &nbsp; 
                          <input type="text" name="txt_registration"  id="reg2" value="<%=Helper.correctNull((String)hshValues.get("agr_registration"))%>"
									size="10" maxlength="4" onBlur="checkcurrentyear(this)" onkeyPress="allowInteger()"
									style="text-align:right">
                        </td>
                        <td align="center"><lapschoice:CurrencyTag name="txt_estimcost"
									value='<%=Helper.correctNull((String)hshValues.get("agr_estimcost"))%>' size="15" maxlength="9"   onBlur="totalEstim();totalLoanAmt();totalLoanAmount()"
									/></td>
                        <td align="center"> 
                          <input type="text" name="txt_margin" value="<%=Helper.correctNull((String)hshValues.get("agr_margin"))%>"
									size="15" maxlength="9" onKeyPress="allowInteger()"   onBlur="checkMargin1();totalMargin();totalLoanAmt();totalLoanAmount()"
									style="text-align:right">
                        </td>
                        <td align="center"><lapschoice:CurrencyTag name="txt_loanamt"
									value='<%=Helper.correctNull((String)hshValues.get("agr_loanamt"))%>' size="15" maxlength="9"
									 onBlur="totalLoanAmount()" /></td>
                      </tr>
                      <tr  class="datagrid"> 
                        <td align="center"> 
                          <input type="text" name="txt_particulars1"
									value="<%=Helper.correctNull((String)hshValues.get("agr_particulars1"))%>" size="20" maxlength="20" style="text-align:left">
                        </td>
                        <td align="center"> 
                          <input type="text"
									name="txt_make1" value="<%=Helper.correctNull((String)hshValues.get("agr_make1"))%>" size="10" maxlength="4"
									onKeyPress="allowInteger()" style="text-align:right">
                         </td>
                        <td align="center" >&nbsp; 
                          <input type="text" name="txt_registration1" id="reg3" value="<%=Helper.correctNull((String)hshValues.get("agr_registration1"))%>"
									size="10" maxlength="4" onKeyPress="allowInteger()" onBlur="checkcurrentyear(this)"
									style="text-align:right">
                        </td>
                        <td align="center"><lapschoice:CurrencyTag name="txt_estimcost1"
									value='<%=Helper.correctNull((String)hshValues.get("agr_estimcost1"))%>' size="15" maxlength="9"   onBlur="totalEstim();totalLoanAmt();totalLoanAmount()"
									/></td>
                        <td align="center"> 
                          <input type="text" name="txt_margin1" value="<%=Helper.correctNull((String)hshValues.get("agr_margin1"))%>"
									size="15" maxlength="9" onKeyPress="allowInteger()"  onBlur="checkMargin2();totalMargin();totalLoanAmt();totalLoanAmount()"
									style="text-align:right">
                        </td>
                        <td align="center"><lapschoice:CurrencyTag name="txt_loanamt1"
									value='<%=Helper.correctNull((String)hshValues.get("agr_loanamt1"))%>' size="15" maxlength="9"
									 onBlur="totalLoanAmount()" /></td>
                      </tr>
                      <tr  class="datagrid"> 
                        <td colspan="3" align="right">&nbsp;</td>
                        <td align="center"><lapschoice:CurrencyTag name="txt_totestimcost"
									value='<%=Helper.correctNull((String)hshValues.get("totestimcost"))%>' size="15" maxlength="9" 
									/></td>
                        <td align="center"> 
                          <input type="text" name="txt_totmargin"
									value="<%=Helper.correctNull((String)hshValues.get("totmarginamt"))%>" size="15" maxlength="9"
									onKeyPress="allowInteger()" style="text-align:right">
                        </td>
                        <td align="center"><lapschoice:CurrencyTag name="txt_totloanamt"
									value='<%=Helper.correctNull((String)hshValues.get("totloanamt"))%>' size="15" maxlength="9"
									 /></td>
                      </tr>
                      <tr > 
                        <td colspan="3" align="">Whether 
                          proposed vehicle will be used for transportation of 
                          Agricultural Goods</td>
                        <td colspan="3" align=""> 
                          <select value="0"
													name="sel_goods" onChange="">
                            <option value="1" selected>Yes</option>
                            <option value="2">No</option>
                          </select>
                          </td>
                      </tr>
                      <tr> 
                        <td colspan="3" align="">Who 
                          will Drive the Vehicle</td>
                        <td colspan="3" align=""> 
                          <input type="text" name="txt_vehicledrive"
									value="<%=Helper.correctNull((String)hshValues.get("txt_vehicledrive"))%>" size="30" maxlength="25" style="text-align:left">
                        </td>
                      </tr>
                      <tr> 
                        <td colspan="6" align="left"> </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr id="second1"> 
                  <td colspan="6"><b>If Second 
                    Hand </b></td>
                </tr>
                <tr id="second2"> 
                  <td width="12%">Age of Vehicle 
                    </td>
                  <td width="16%"> 
                    <input type="text" name="txt_age" size="5"
					maxlength="2"
					value="<%=Helper.correctNull((String)hshValues.get("agr_age"))%>"
					onKeyPress="allowInteger()">
                  </td>
                  <td width="15%">&nbsp;</td>
                  <td width="13%">&nbsp; </td>
                  <td width="26%">&nbsp;</td>
                  <td width="18%">&nbsp; </td>
                </tr>
                <tr id="second3"> 
                  <td width="12%">Original 
                    Cost Rs. </td>
                  <td width="16%"><lapschoice:CurrencyTag name="txt_originalcost" maxlength="10"
					value='<%=Helper.correctNull((String)hshValues.get("agr_originalcost"))%>' /> 
                  </td>
                  <td width="15%">Registration 
                    No. </td>
                  <td width="13%"> 
                    <input type="text" name="txt_regno" maxlength="14"
					value="<%=Helper.correctNull((String)hshValues.get("agr_regno"))%>">
                  </td>
                  <td width="26%">Name of 
                    the Owner</td>
                  <td width="18%"> 
                    <input type="text" name="txt_owner" maxlength="40"
					value="<%=Helper.correctNull((String)hshValues.get("agr_owner"))%>"
					onKeyPress="notAllowSplChar()">
                  </td>
                </tr>
                <tr id="second4"> 
                  <td width="12%" nowrap>value 
                    as per valuer's report Rs.</td>
                  <td width="16%"><lapschoice:CurrencyTag name="txt_valuationvechi" maxlength="10"
					value='<%=Helper.correctNull((String)hshValues.get("agr_valuercost"))%>' /> 
                  </td>
                  <td width="15%">Chasis No.</td>
                  <td width="13%"> 
                    <input type="text" name="txt_chasisno" maxlength="24"
					value="<%=Helper.correctNull((String)hshValues.get("agr_chasisno"))%>">
                  </td>
                  <td width="26%">Valuation 
                    done by</td>
                  <td width="18%"> 
                    <input type="text" name="txt_valuationdone" maxlength="40"
					value="<%=Helper.correctNull((String)hshValues.get("agr_valuationdoneby"))%>"
					onKeyPress="notAllowSplChar()">
                  </td>
                </tr>
                <tr id="second5"> 
                  <td width="12%" nowrap>Least 
                    Value of the above Rs.</td>
                  <td width="16%"><lapschoice:CurrencyTag name="txt_leastvalue" maxlength="10"
					value='<%=Helper.correctNull((String)hshValues.get("agr_leastvalue"))%>' /> 
                  </td>
                  <td width="15%">Engine No. 
                   </td>
                  <td width="13%"> 
                    <input type="text" name="txt_engineno" maxlength="23"
					value="<%=Helper.correctNull((String)hshValues.get("agr_engineno"))%>">
                  </td>
                  <td width="26%">Whether 
                    valuer on the branch panel</td>
                  <td width="18%"> 
                    <select name="sel_branch">
                      <option value="s">--select--</option>
                      <option value="y">Yes</option>
                      <option value="n">No</option>
                    </select>
                    </td>
                </tr>
                <tr id="repair1"> 
                  <td width="12%"><b>If Repair</b></td>
                  <td width="16%">&nbsp;</td>
                  <td width="15%">&nbsp;</td>
                  <td width="13%">&nbsp;</td>
                  <td width="26%">&nbsp;</td>
                  <td width="18%">&nbsp;</td>
                </tr>
                <tr id="repair2"> 
                  <td width="12%">Name of 
                    Garage/Mechanic</td>
                  <td width="16%"> 
                    <input type="text" name="txt_mechanic" size="30" maxlength="40"
					value="<%=Helper.correctNull((String)hshValues.get("txt_mechanic"))%>"
					onKeyPress="notAllowSplChar()">
                  </td>
                  <td width="15%">Distance 
                    from Village</td>
                  <td width="13%"> 
                    <input
							type="text" name="txt_mechdistance"
							value="<%=Helper.correctNull((String)hshValues.get("txt_mechdistance"))%>"
							size="10" maxlength="9" onKeyPress="allowNumber(this)"
							onBlur="" style="text-align:left">
                   Km</td>
                  <td width="26%">&nbsp;</td>
                  <td width="18%">&nbsp;</td>
                </tr>
           
              </table></td></tr></table>
				<br>
<lapschoice:combuttonnew  btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<br>
<lapschoice:agrihiddentag pageid='<%=PageId%>' />
</form>
</body>
</html>

