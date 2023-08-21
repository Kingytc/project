<%@include file="../share/directives.jsp"%>
<%ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();

			%>
<html>
<head>
<title>Live Stock Details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var batchpurchased = "<%=Helper.correctNull((String)hshValues.get("batchpurchased"))%>"; 
  
function enableButtons(bool2, bool3, bool4, bool5, bool6)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}

function doClose()
{
	if( ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/retpge.jsp";
		document.forms[0].submit();
	}
}

function doSave()
{
		if(document.forms[0].selbatch.value=="")
		{
				ShowAlert('112','No of batches purchased');
				document.forms[0].selbatch.focus();
				return;
		}
		
		if(document.forms[0].selbatch.value=="1")
		{
			if(document.forms[0].sellease[0].value=="0")
			{
				ShowAlert('112','Milch Cattle');
				document.forms[0].sellease[0].focus();
				return;
			}
			
			if(document.forms[0].txt_avgmilk[0].value=="")
			{
				ShowAlert('112','Average Yield per milk');
				return;
			}
			
	  		if(document.forms[0].txt_noofanimals[0].value=="")
			{
				ShowAlert('112','Number of animals');
				return;
			}
			
	 		if(document.forms[0].txt_costperanimal[0].value=="")
			{
				ShowAlert('112','Cost per Animal');
				return;
			}
		}
		
		if(document.forms[0].selbatch.value=="2")
		{
			for(var i=0;i<2;i++)
			{
				if(document.forms[0].sellease[i].value=="0")
				{
					ShowAlert('112','Milch Cattle');
					document.forms[0].sellease[i].focus();
					return;
				}
				
				if(document.forms[0].txt_avgmilk[i].value=="")
				{
					ShowAlert('112','Average Yield per milk');
					document.forms[0].txt_avgmilk[i].focus();
					return;
				}
				
		  		if(document.forms[0].txt_noofanimals[i].value=="")
				{
					ShowAlert('112','Number of animals');
					document.forms[0].txt_noofanimals[i].focus();
					return;
				}
				
		 		if(document.forms[0].txt_costperanimal[i].value=="")
				{
					ShowAlert('112','Cost per Animal');
					document.forms[0].txt_costperanimal[i].focus();
					return;
				}
			}
		}
       
       
			
	for(var i=0;i<3;i++)
	{
		if(document.forms[0].txt_present_breed[i].value!="")
		{
			if(document.forms[0].txt_present_age[i].value=="")
			{
				ShowAlert('112','Presently Owned - Age');
				return;
			}
			if(document.forms[0].txt_present_no[i].value=="")
			{
				ShowAlert('112','Presently Owned - Number');
				return;
			}
			if(document.forms[0].txt_present_value[i].value=="")
			{
				ShowAlert('112','Presently Owned - Value');
				return;
			}
			if(document.forms[0].txt_proposed_breed[i].value=="")
			{
				document.forms[0].txt_proposed_age[i].value='0';
				document.forms[0].txt_proposed_no[i].value='0';
			}
			if(document.forms[0].txt_proposed_breed[i].value!="")
			{
				if(document.forms[0].txt_proposed_age[i].value=="")
				{
					ShowAlert('112','Proposed to be Purchased - Age');
					return;
				}
				if(document.forms[0].txt_proposed_no[i].value=="")
				{
					ShowAlert('112','Proposed to be Purchased - Number');
					return;
				}				
			}
		}
		else if(document.forms[0].txt_present_breed[i].value=="" && document.forms[0].txt_proposed_breed[i].value!="")
		{
			if(document.forms[0].txt_proposed_breed[i].value!="")
			{
				if(document.forms[0].txt_proposed_age[i].value=="")
				{
					ShowAlert('112','Proposed to be Purchased - Age');
					return;
				}
				if(document.forms[0].txt_proposed_no[i].value=="")
				{
					ShowAlert('112','Proposed to be Purchased - Number');
					return;
				}
			}
			if(document.forms[0].txt_present_breed[i].value=="")
			{
				document.forms[0].txt_present_age[i].value='0';
				document.forms[0].txt_present_no[i].value='0';
				document.forms[0].txt_present_value[i].value='0';
			}
			if(document.forms[0].txt_proposed_breed[i].value!="")
			{
				if(document.forms[0].txt_present_age[i].value=="")
				{
					ShowAlert('112','Presently Owned - Age');
					return;
				}
				if(document.forms[0].txt_present_no[i].value=="")
				{
					ShowAlert('112','Presently Owned - Number');
					return;
				}
				if(document.forms[0].txt_present_value[i].value=="")
				{
					ShowAlert('112','Presently Owned - Value');
					return;
				}
				
			}
		}
	}
	
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="agrcrops";		
	document.forms[0].hidSourceUrl.value="/action/livestockdetails.jsp";
	document.forms[0].hidBeanMethod.value="updateLiveStock";
	document.forms[0].hidBeanGetMethod.value="getDataLiveStock";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();	
}

function doEdit()
{
 	disableFields(false);
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="update";
	enableButtons(true, false, false, false, true);	
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidBeanGetMethod.value="getDataLiveStock";
		document.forms[0].action=appURL +"action/livestockdetails.jsp";
		document.forms[0].submit(); 		
	}
}

function calTotalanimal()
{
	var animal ="0";
	var totalanimal = "0";
	for(var i=0; i<3; i++)
	{
		animal = eval(document.forms[0].txt_noofanimals[i].value);
		alert(animal);
		totalanimal = eval(totalanimal) + eval(animal);
	}
	document.forms[0].txt_totalanimal.value = eval(totalanimal);
}

function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updateLiveStock";
		document.forms[0].hidBeanGetMethod.value="getDataLiveStock";
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidSourceUrl.value="action/livestockdetails.jsp";	
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
	
	document.forms[0].txt_total.readOnly=true;
	document.forms[0].txt_totalvalue.readOnly=true;
}	

function onloading()
{	
	
	disableFields(true);
	showrows();
}

function totequip()
{
   for(var g=0;g<2;g++)
	{
       
        var value11=document.forms[0].txt_noofanimals[g].value;
		 var value12=document.forms[0].txt_costperanimal[g].value;
       if(value11=="")
		{
			value11=0;
		}
		if(value12=="")
		{
			value12=0.00;
		}
 document.forms[0].txt_totalcost[g].value= eval(value11)*eval(value12);
 	
}
}



function totalcostofanimal()
{
	var firstval = document.forms[0].txt_totalcost[0].value ;
	var secondval = document.forms[0].txt_totalcost[1].value;
	var totalcostfinal= 0;
	if(firstval =="")
	{
		firstval = 0;
	}
	if(secondval =="")
	{
		secondval = 0;
	}
	totalcostfinal = eval(firstval) + eval(secondval);
	document.forms[0].txt_total.value = totalcostfinal;
	roundtxt(document.forms[0].txt_total);
}

function totalanimals()
{
	var firstval = document.forms[0].txt_noofanimals[0].value;
	var secondval = document.forms[0].txt_noofanimals[1].value;
	var totalfinalanimals = 0;
	if(firstval == "")
	{
		firstval = 0.00;
	}
	if (secondval == "")
	{
		secondval = 0.00;
	}
	totalfinalanimals = eval(firstval) + eval(secondval);
	document.forms[0].txt_totalanimal.value = totalfinalanimals;
}

function calTotalValue()
{
	var firstval = document.forms[0].txt_present_value[0].value; 
	var secondval = document.forms[0].txt_present_value[1].value; 
	var thirdval = document.forms[0].txt_present_value[2].value; 
	var totalvalue = 0;
	if(firstval == "")
	{
		firstval = 0.00;
	}
	if(secondval =="")
	{
		secondval =  0.00;
	}
	if(thirdval == "")
	{
		thirdval = 0.00;
	}
	totalvalue = eval(firstval) + eval(secondval) + eval(thirdval)
	document.forms[0].txt_totalvalue.value = totalvalue;
	roundtxt(document.forms[0].txt_totalvalue);
}

function showrows()
{
	if(document.forms[0].selbatch.value=="1")
	{
		document.all.headrow.style.visibility="visible";
		document.all.headrow.style.position="relative";
		document.all.firstrow.style.visibility="visible";
		document.all.firstrow.style.position="relative";
		
		document.all.secondrow.style.visibility="hidden";
		document.all.secondrow.style.position="absolute";
		
		document.all.totalrow.style.visibility="visible";
		document.all.totalrow.style.position="relative";
		
		
		document.forms[0].sellease[1].value="0";
		document.forms[0].txt_avgmilk[1].value="";
		document.forms[0].txt_noofanimals[1].value="";
		document.forms[0].txt_costperanimal[1].value="";
		document.forms[0].txt_totalcost[1].value="";
		
	}
	else if(document.forms[0].selbatch.value=="2")
	{
		document.all.headrow.style.visibility="visible";
		document.all.headrow.style.position="relative";
		document.all.firstrow.style.visibility="visible";
		document.all.firstrow.style.position="relative";
		document.all.secondrow.style.visibility="visible";
		document.all.secondrow.style.position="relative";
		
		document.all.totalrow.style.visibility="visible";
		document.all.totalrow.style.position="relative";
		
	}
	else
	{
	    document.all.headrow.style.visibility="hidden";
		document.all.headrow.style.position="absolute";
		document.all.firstrow.style.visibility="hidden";
		document.all.firstrow.style.position="absolute";
		document.all.secondrow.style.visibility="hidden";
		document.all.secondrow.style.position="absolute";
		document.all.totalrow.style.visibility="hidden";
		document.all.totalrow.style.position="absolute";
	}
	totequip();
	totalcostofanimal();
	totalanimals();
	
	if(batchpurchased!='')
	{
		if(document.forms[0].selbatch.value!=batchpurchased)
		{
		    alert("This will delete the records in Milk Flow Chart");
			document.forms[0].hid_selbatch.value='Y';
		}
		else
		{
			document.forms[0].hid_selbatch.value='';
		}
	}
	
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading();totalcostofanimal();totalanimals();calTotalValue()">
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellpadding="5" cellspacing="0" class="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
							<tr class="dataheader">
								<td align="center">Details of LiveStock</td>
								<td align="center" colspan="4">Presently
								Owned</td>
								<td align="center" colspan="3">Proposed
								to be Purchased</td>
							</tr>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center">Breed</td>
								<td align="center">Age</td>
								<td align="center">Number</td>

								<td align="center">Value in <b>Rs.</b></td>
								<td align="center">Breed</td>
								<td align="center">Age</td>
								<td align="center">Lactation
								No</td>
							</tr>
							<%arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrlivestock");

			if (arrRow != null && arrRow.size() > 0) {
				//System.out.println("arrRow.size()  : " + arrRow.size());
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);

					%>
							<tr>
								<td align="center"><input type="hidden" name="hid_livestockslno"
									value="<%=i+1%>" size="25" maxlength="9"> <input type="text"
									name="txt_livestock"
									value="<%=Helper.correctNull((String)arrCol.get(2))%>"
									size="25" maxlength="20"></td>
								<td align="center"><input type="text" name="txt_present_breed"
									value="<%=Helper.correctNull((String)arrCol.get(3))%>"
									size="20" maxlength="15"></td>
								<td align="center"><input type="text" name="txt_present_age"
									value="<%=Helper.correctNull((String)arrCol.get(4))%>" size="5"
									maxlength="2" onKeyPress="allowInteger()"
									style="text-align:left"></td>
								<td align="center"><input type="text" name="txt_present_no"
									value="<%=Helper.correctNull((String)arrCol.get(5))%>" size="5"
									maxlength="3" onKeyPress="allowInteger()"
									style="text-align:left"></td>
								<td align="center"><lapschoice:CurrencyTag name="txt_present_value"
									value='<%=Helper.correctNull((String)arrCol.get(6))%>'
									size="18" maxlength="12" onBlur="calTotalValue()" /></td>
								<td align="center"><input type="text" name="txt_proposed_breed"
									value="<%=Helper.correctNull((String)arrCol.get(7))%>"
									size="20" maxlength="15"></td>
								<td align="center"><input type="text" name="txt_proposed_age"
									value="<%=Helper.correctNull((String)arrCol.get(8))%>" size="5"
									maxlength="2" onKeyPress="allowInteger()"
									style="text-align:left"></td>
								<td align="center"><input type="text" name="txt_proposed_no"
									value="<%=Helper.correctNull((String)arrCol.get(9))%>" size="5"
									maxlength="3" onKeyPress="allowInteger()"
									style="text-align:left"></td>
							</tr>
							<%}
			} else {
				for (int i = 0; i < 3; i++) {%>

							<tr>
								<td align="center"><input type="hidden" name="hid_livestockslno"
									value="<%=i+1%>" size="25" maxlength="9"> <input type="text"
									name="txt_livestock" value="" size="25" maxlength="20"></td>
								<td align="center"><input type="text" name="txt_present_breed"
									value="" size="20" maxlength="15"></td>
								<td align="center"><input type="text" name="txt_present_age"
									value="" size="5" maxlength="2" onKeyPress="allowInteger()"
									style="text-align:left"></td>
								<td align="center"><input type="text" name="txt_present_no"
									value="" size="5" maxlength="3" onKeyPress="allowInteger()"
									style="text-align:left"></td>
								<td align="center"><lapschoice:CurrencyTag name="txt_present_value"
									value='' size="18" maxlength="12" onBlur="calTotalValue()" /></td>
								<td align="center"><input type="text" name="txt_proposed_breed"
									value="" size="20" maxlength="15"></td>
								<td align="center"><input type="text" name="txt_proposed_age"
									value="" size="5" maxlength="2" onKeyPress="allowInteger()"
									style="text-align:left"></td>
								<td align="center"><input type="text" name="txt_proposed_no"
									value="" size="5" maxlength="3" onKeyPress="allowInteger()"
									style="text-align:left"></td>
							</tr>
							<%}
			}%>
							<tr>
								<td>&nbsp;</td>

								<td align="right" colspan="3"><b>Total <%=ApplicationParams.getCurrency()%>
								</b></td>
								<td align="center"><lapschoice:CurrencyTag name="txt_totalvalue"
									value='<%=Helper.correctNull((String)hshValues.get("TotalValue"))%>'
									size="18" maxlength="12" /></td>

								<td align="right" colspan="3">&nbsp;</td>
							</tr>
							<tr>
								<td>No of batches purchased</td>
								<td align="center" colspan="3"><select value="0"
									name="selbatch" onChange="showrows()">
									<option value="" selected
										<%if(Helper.correctNull((String)hshValues.get("batchpurchased")).equalsIgnoreCase("")){out.println("Selected");} %>>--Select--</option>
									<option value="1"
										<%if(Helper.correctNull((String)hshValues.get("batchpurchased")).equalsIgnoreCase("1")){out.println("Selected");} %>>I</option>
									<option value="2"
										<%if(Helper.correctNull((String)hshValues.get("batchpurchased")).equalsIgnoreCase("2")){out.println("Selected");} %>>II</option>
								</select></td>
								<td align="center">&nbsp;</td>
								<td align="right" colspan="3">&nbsp;</td>
							</tr>
						</table>
						</td>
						</tr>
						<tr>
						<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
							<tr id="headrow" class="dataheader">
								<td align="center">Stages
								of Particulars</td>
								<td align="center">Milch Cattle</td>
								<td align="center">Average Milk yield /
								Day / Animal</td>
								<td align="center">No of Animals</td>

								<td align="center">Cost Per Animal in <b>Rs.</b>
								</td>
								<td align="center">Total
								Cost in <b>Rs.</b></td>
							</tr>
							<%arrRow = new ArrayList();

			arrRow = (ArrayList) hshValues.get("arrstockdetails");
			//System.out.println("--------->>>>>>>>>>............."+arrRow.size());
			if (arrRow != null && arrRow.size() > 0) {
				//System.out.println("--------->>>>>>>>>>.............huhuhuh");
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);
					String label1 = "";
					String id="";
					if (i == 0) {
						label1 = "I Batch";
						id = "firstrow";
					} else {
						label1 = "II Batch";
						id = "secondrow";
					}

					%>
							<tr id=<%=id%>>

								<td align="center"> <%=label1%></td>
								<td align="center">
								 <select name="sellease">
									<option value="0" selected="selected"
										<%if(Helper.correctNull((String)arrCol.get(0)).equalsIgnoreCase("0")){out.println("Selected");} %>>--Select--</option>
									<option value="1"
										<%if(Helper.correctNull((String)arrCol.get(0)).equalsIgnoreCase("1")){out.println("Selected");} %>>Cows</option>
									<option value="2"
										<%if(Helper.correctNull((String)arrCol.get(0)).equalsIgnoreCase("2")){out.println("Selected");} %>>Buffalo/es</option>
								</select> </td>
								<td align="center"><input type="text" name="txt_avgmilk"
									value="<%=Helper.correctNull((String)arrCol.get(1))%>"
									size="10" maxlength="3" onKeyPress="allowNumber(this)"
									style="text-align:right"> Litres</td>

								<td align="center"><input type="text" name="txt_noofanimals"
									value="<%=Helper.correctNull((String)arrCol.get(2))%>"
									onBlur="totequip();totalcostofanimal();totalanimals()"
									size="10" maxlength="5" onKeyPress="allowInteger()"
									style="text-align:right"></td>
								<td align="center"><lapschoice:CurrencyTag name="txt_costperanimal"
									value='<%=Helper.correctNull((String)arrCol.get(3))%>'
									onBlur="totequip();totalcostofanimal()" size="18"
									maxlength="12" /></td>
								<td align="center"><lapschoice:CurrencyTag name="txt_totalcost"
									value='<%=Helper.correctNull((String)arrCol.get(4))%>'
									size="18" maxlength="12" /></td>
							</tr>
							<%}
			} else {
				for (int i = 0; i < 2; i++) {
					String label1 = "";
					String id="";
					if (i == 0) {
						label1 = "I Batch";
						id = "firstrow";
					} else {
						label1 = "II Batch";
						id = "secondrow";
					}

					%>

							<tr id=<%=id%>>
								<td align="center"><%=label1%></td>
								<td align="center"> <select value="0"
									name="sellease" onChange="">
									<option value="0" selected>--Select--</option>
									<option value="1">Cow/s</option>
									<option value="2">Buffalo/es</option>
								</select> </td>
								<td align="center"><input type="text" name="txt_avgmilk"
									value="" size="10" maxlength="3" onKeyPress="allowNumber(this)"
									style="text-align:right"> Litres</td>
								<td align="center"><input type="text" name="txt_noofanimals"
									value="" size="10" maxlength="5" onKeyPress="allowInteger()"
									onblur="totequip();totalanimals()" style="text-align:right"></td>
								<td align="center"><lapschoice:CurrencyTag name="txt_costperanimal"
									onBlur="totequip();totalcostofanimal()" value='' size="18"
									maxlength="12" /></td>
								<td align="center"><lapschoice:CurrencyTag name="txt_totalcost"
									value='' size="18" maxlength="12" /></td>
							</tr>
							
							<%}
			}

			%>
							<tr id="totalrow">

								<td colspan="3" align="right"><b>Total </b></td>
								<td align="center"><input type="text" name="txt_totalanimal"
									value="<%=Helper.correctNull((String)hshValues.get("Totalnoofanimal"))%>"
									size="10" maxlength="10" style="text-align:right" readonly></td>
								<td align="right" colspan="2">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
									<tr>

										<td width="53%" align="right"><b>Total <%=ApplicationParams.getCurrency()%>
										</b></td>
										<td width="47%" align="center"><lapschoice:CurrencyTag
											name="txt_total"
											value='<%=Helper.correctNull((String)hshValues.get("TotalCost"))%>'
											size="18" maxlength="12" /></td>
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
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:agrihiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hid_livestocksize"> 
<input type="hidden" name="sellease_text">
<input type="hidden" name="hid_selbatch">
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("auditFlag"))%>">
</form>
</body>
</html>
