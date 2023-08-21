<%@include file="../share/directives.jsp"%>
<%ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();
			arrRow=(ArrayList)hshValues.get("arryRow");	
			%>
<html>
<head>
<title>Agriculture Scale of finance</title>
<script>
var varAgriType="<%=Helper.correctNull((String)hshValues.get("agr_typeofagri"))%>";
var varLoanType="<%=Helper.correctNull((String)hshValues.get("agr_typeofloan"))%>";

var varRecurrMargin="<%=Helper.correctNull((String)hshValues.get("dblRecurrexpMargin"))%>";
var varagrDevelopMargin="<%=Helper.correctNull((String)hshValues.get("dblAgridevelopMargin"))%>";
var varLandValue="<%=Helper.correctDouble((String)hshValues.get("dblLandValue"))%>";
function callOnLoad()
{
	if(varAgriType!="")
	{
		document.forms[0].sel_agrtype.value=varAgriType;
	}else{
		document.forms[0].sel_agrtype.value="";
	}
	if(varLoanType!="" && varLoanType!="S")
	{
		document.forms[0].sel_typeofloan.value=varLoanType;
	}else{
		document.forms[0].sel_typeofloan.value="S";
	}
	var table=document.getElementById("idMember1");
	var rowsLength =table.rows.length;
	document.forms[0].hidrow2.value=rowsLength;

	table=document.getElementById("idMember2");
	rowsLength =table.rows.length;
	document.forms[0].hidrow1.value=rowsLength;
	
	callEnableFields();
	callEnableloanfields();
	disablefields(true);
}
function callEnableFields()
{
	if(document.forms[0].sel_agrtype.value=="P"||document.forms[0].sel_agrtype.value=="Q"||document.forms[0].sel_agrtype.value=="S")
	{
		document.all.idloantype.style.visibility	= "visible";
		document.all.idloantype.style.position	= "relative";
		
		document.all.idagriprod1.style.visibility	= "hidden";
		document.all.idagriprod1.style.position	= "absolute";
		
		document.all.idagriprod2.style.visibility	= "hidden";
		document.all.idagriprod3.style.position	= "absolute";
		
		document.all.idagriprod3.style.visibility	= "hidden";
		document.all.idagriprod3.style.position	= "absolute";

		document.all.idagriprod4.style.visibility	= "hidden";
		document.all.idagriprod4.style.position	= "absolute";
		
	}else if(document.forms[0].sel_agrtype.value=="D"){
		document.forms[0].sel_typeofloan.value="S";
		document.all.idagriprod1.style.visibility	= "hidden";
		document.all.idagriprod1.style.position	= "absolute";
		
		document.all.idagriprod3.style.visibility	= "visible";
		document.all.idagriprod3.style.position	= "relative";

		document.all.idagriprod4.style.visibility	= "visible";
		document.all.idagriprod4.style.position	= "relative";
		
		document.all.idagriprod2.style.visibility	= "hidden";
		document.all.idagriprod2.style.position	= "absolute";
		
		document.all.idloantype.style.visibility	= "hidden";
		document.all.idloantype.style.position	= "absolute";
	}else{
		document.forms[0].sel_typeofloan.value="S";
		document.all.idagriprod1.style.visibility	= "hidden";
		document.all.idagriprod1.style.position	= "absolute";

		document.all.idagriprod2.style.visibility	= "hidden";
		document.all.idagriprod2.style.position	= "absolute";

		document.all.idagriprod3.style.visibility	= "hidden";
		document.all.idagriprod3.style.position	= "absolute";

		document.all.idagriprod4.style.visibility	= "hidden";
		document.all.idagriprod4.style.position	= "absolute";
		
		document.all.idloantype.style.visibility	= "hidden";
		document.all.idloantype.style.position	= "absolute";
		
	}
}
function callEnableloanfields()
{
	if(document.forms[0].sel_typeofloan.value=="C")
	{
		document.all.idagriprod1.style.visibility	= "visible";
		document.all.idagriprod1.style.position	= "relative";

		document.all.idagriprod2.style.visibility	= "hidden";
		document.all.idagriprod2.style.position	= "absolute";

		document.all.idagriprod3.style.visibility	= "hidden";
		document.all.idagriprod3.style.position	= "absolute";

		document.all.idagriprod4.style.visibility	= "hidden";
		document.all.idagriprod4.style.position	= "absolute";
	}
	else if(document.forms[0].sel_typeofloan.value=="A")
	{
		document.all.idagriprod1.style.visibility	= "hidden";
		document.all.idagriprod1.style.position	= "absolute";

		document.all.idagriprod2.style.visibility	= "visible";
		document.all.idagriprod2.style.position	= "relative";

		document.all.idagriprod3.style.visibility	= "hidden";
		document.all.idagriprod3.style.position	= "absolute";

		document.all.idagriprod4.style.visibility	= "hidden";
		document.all.idagriprod4.style.position	= "absolute";
	}
	else
	{
		document.all.idagriprod1.style.visibility	= "hidden";
		document.all.idagriprod1.style.position	= "absolute";

		document.all.idagriprod2.style.visibility	= "hidden";
		document.all.idagriprod2.style.position	= "absolute";
	}
}
function processActionNewMember(type)
{
	if (document.forms[0].cmdedit.disabled == true)
	{
		var table='',rowsLength='';

		if(type=='DLP')
		{
			table = document.getElementById("idMember2");
			rowsLength =table.rows.length;
			document.forms[0].hidrow1.value=rowsLength+1;
		}else{
		table = document.getElementById("idMember1");
		rowsLength =table.rows.length;
		document.forms[0].hidrow2.value=rowsLength+1;
		}
	
		var new_Row  = table.insertRow(rowsLength);
		var rwlength=rowsLength-1;
		new_Row.id="row_"+rowsLength;
		var previous_RowCells=table.rows[rowsLength-1].cells;
		rowsLength=rowsLength-2;
		for(i=0;i<previous_RowCells.length;i++)
		{
			var new_RowCell=new_Row.insertCell(i);
			new_RowCell.innerHTML=previous_RowCells[i].innerHTML;
			new_RowCell.align="center";
			new_RowCell.className="datagrid";
			var new_CellElement=new_RowCell.childNodes[0];
			
			for(var j=0;j<new_RowCell.childNodes.length;j++)
			{
				if(new_RowCell.childNodes[j].type=="text")
				{
					new_RowCell.childNodes[j].value="";
				}
				else
				{
					if(type=='DLP') document.all.immsno[rowsLength].innerHTML=rowsLength+1;
					else document.all.liabsno[rowsLength].innerHTML=rowsLength+1;
				}
				
			}
		}
	}
	else
	{
		alert('Please click Edit button');
	}
}
function doButtonDeleteMember(type)
{
	if (document.forms[0].cmdedit.disabled == true)
	{
		var varHidMemberSeqID=5;
	    var varCheckedFlag=false;
		var table='',rowsLength='';
		if(type=='DLP')
		{
			table = document.getElementById("idMember2");
			rowsLength =table.rows.length;
			document.forms[0].hidrow1.value=rowsLength-1;
			//liabilityTotal();
		}else{
			table = document.getElementById("idMember1");
			rowsLength =table.rows.length;
			document.forms[0].hidrow2.value=rowsLength-1;
		}
		var rowsLength = table.rows.length;
		var count = 0;
		if(rowsLength>4){
			table.deleteRow(rowsLength-1);
		}
	}
	else
	{
		alert('Please click Edit button');
	}
}
function doEdit()
{
	disableButtons(true,false,false,false);
	disablefields(false);
	document.forms[0].sel_agrtype.disabled=true;
	document.forms[0].sel_typeofloan.disabled=true;
	document.forms[0].txt_harvestexp.readOnly=true;
	document.forms[0].txt_scaleamt.readOnly=true;
	document.forms[0].txt_recurrexp.readOnly=true;
	document.forms[0].txt_eligibleamt.readOnly=true;
	document.forms[0].txt_totalcost1.readOnly=true;
	document.forms[0].txt_pertotalcost1.readOnly=true;
	document.forms[0].txt_eligibleamt1.readOnly=true;
}
function doSave()
{
	document.forms[0].sel_agrtype.disabled=false;
	document.forms[0].sel_typeofloan.disabled=false;
	if(document.forms[0].sel_agrtype.value=="")
	{
			ShowAlert('111',"Type of Agriculture");
			document.forms[0].sel_agrtype.focus();
			return;
	}
	if((document.forms[0].sel_agrtype.value=="P" ||document.forms[0].sel_agrtype.value=="Q"||document.forms[0].sel_agrtype.value=="S") && document.forms[0].sel_typeofloan.value=="S")
	{
			ShowAlert('111',"Type of Loan");
			document.forms[0].sel_typeofloan.focus();
			return;
	}
	calscaleoffintot();
	calscaleoffintot1();
	calworkingcapitaltot();
	calagriprodtot();
	document.forms[0].hidAction.value="insert";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].hidBeanMethod.value="updateAgricultureGold";
	document.forms[0].hidBeanGetMethod.value="getAgricultureGold";	
	document.forms[0].hidSourceUrl.value="/action/peragriculturegold.jsp";
	document.forms[0].submit();
}
function doDelete()
{
	document.forms[0].hidAction.value="delete";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].hidBeanMethod.value="updateAgricultureGold";
	document.forms[0].hidBeanGetMethod.value="getAgricultureGold";	
	document.forms[0].hidSourceUrl.value="/action/peragriculturegold.jsp";
	document.forms[0].submit();
}
function disableButtons(bool1,bool2,bool3,bool4)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmddelete.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
}
function doCancel()
{
	document.forms[0].hidBeanId.value = "perapplicant";
	document.forms[0].hidBeanGetMethod.value = "getAgricultureGold";
	document.forms[0].action = appURL + "action/peragriculturegold.jsp";
	document.forms[0].submit();
}
function calscaleoffintot()
{
	var varIncExpTot="0.00";
	var Length=document.forms[0].hidrow2.value;
	Length=Length-2;
	for(var i=0;i<Length;i++)
	{
		if(Length == 1)
		{
			var varIncExp = roundVal(NanNumber(parseFloat(document.forms[0].txt_scaleoffinance.value) * parseFloat(document.forms[0].txt_area.value)));
			document.forms[0].txt_amt.value = varIncExp;
			varIncExpTot=	roundVal(NanNumber(parseFloat(varIncExpTot) + parseFloat(varIncExp)));
			document.forms[0].txt_amt.value = roundtxt(document.forms[0].txt_amt);
		}
		else
		{
			var varIncExp = roundVal(NanNumber(parseFloat(document.forms[0].txt_scaleoffinance[i].value) * parseFloat(document.forms[0].txt_area[i].value)));
			document.forms[0].txt_amt[i].value = varIncExp;
			varIncExpTot=	roundVal(NanNumber(parseFloat(varIncExpTot) + parseFloat(varIncExp)));
			document.forms[0].txt_amt[i].value = roundtxt(document.forms[0].txt_amt[i]);
		}
	}
	document.forms[0].txt_harvestexp.value=varIncExpTot;
	calscaleoffintot1();
}
function calscaleoffintot1()
{
	if(document.forms[0].txt_postharvestexp.value=="")
		document.forms[0].txt_postharvestexp.value="0.00";
	document.forms[0].txt_scaleamt.value=roundVal(NanNumber(parseFloat(document.forms[0].txt_harvestexp.value)) + NanNumber(parseFloat(document.forms[0].txt_postharvestexp.value)));
}

function calworkingcapitaltot()
{
	document.forms[0].txt_recurrexp.value=roundVal(NanNumber(parseFloat(document.forms[0].txt_recurramt.value) * parseFloat(varRecurrMargin)/100));
	if(parseFloat(document.forms[0].txt_recurramt.value)>parseFloat(document.forms[0].txt_recurrexp.value))
	{
		document.forms[0].txt_eligibleamt.value=roundVal(document.forms[0].txt_recurrexp.value);
	}else{
		document.forms[0].txt_eligibleamt.value=roundVal(document.forms[0].txt_recurramt.value);
	}
}
function calagriprodtot()
{
	var varIncExpTot="0.00";
	var Length=document.forms[0].hidrow1.value;
	Length=Length-2;
	for(var i=0;i<Length;i++)
	{
		if(Length==1)
		{
			var varIncExp = roundVal(NanNumber(parseFloat(document.forms[0].txt_unitcost.value) * parseFloat(document.forms[0].txt_noofunits.value)));
			document.forms[0].txt_totalcost.value = varIncExp;
			varIncExpTot=	roundVal(NanNumber(parseFloat(varIncExpTot) + parseFloat(varIncExp)));
			document.forms[0].txt_totalcost.value = roundtxt(document.forms[0].txt_totalcost);
		}
		else
		{
			var varIncExp = roundVal(NanNumber(parseFloat(document.forms[0].txt_unitcost[i].value) * parseFloat(document.forms[0].txt_noofunits[i].value)));
			document.forms[0].txt_totalcost[i].value = varIncExp;
			varIncExpTot=	roundVal(NanNumber(parseFloat(varIncExpTot) + parseFloat(varIncExp)));
			document.forms[0].txt_totalcost[i].value = roundtxt(document.forms[0].txt_totalcost[i]);
		}
	}
	document.forms[0].txt_totalcost1.value=varIncExpTot;
	document.forms[0].txt_pertotalcost1.value=roundVal(NanNumber(parseFloat(document.forms[0].txt_totalcost1.value) * parseFloat(varagrDevelopMargin)/100));
	if(parseFloat(document.forms[0].txt_totalcost1.value)>parseFloat(document.forms[0].txt_pertotalcost1.value))
	{
		document.forms[0].txt_eligibleamt1.value=roundVal(document.forms[0].txt_pertotalcost1.value);
	}else{
		document.forms[0].txt_eligibleamt1.value=roundVal(document.forms[0].txt_totalcost1.value);
	}
}
function callIFrame()
{
	document.forms[0].hidBeanId.value = "perapplicant";
	document.forms[0].hidBeanGetMethod.value = "getAgricultureGold";
	document.forms[0].action = appURL + "action/peragriculturegold.jsp";
	document.forms[0].submit();
}

function disablefields(bool)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=bool;
		}
	}
}
function chkLandValue(val)
{
	var varLen=document.forms[0].txt_area.length;	
	var varLandVal=0.0;
	for(var i=0;i<varLen;i++)
	{
		var value=document.forms[0].txt_area[i].value;
		if(value=="")
			value=0.0;
		
		varLandVal=parseFloat(varLandVal)+parseFloat(value);
	}
	if(parseFloat(varLandVal)>parseFloat(varLandValue))
	{
		//alert("Total acre should not greater than "+varLandValue +" acre");
		//val.value="";
		//val.focus();
		//return;
	}
}
</script>
</head>
<body onload="callOnLoad();">
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/Applurllinkper.jsp">
			<jsp:param name="pageid" value="1" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" class="page_flow">Home -&gt; Retail -&gt; Loan
		Particulars -&gt; Agriculture</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><lapschoice:application /></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="bottom">
		<table width="93%" border="0" cellspacing="0" cellpadding="0" class="outertable"
			align="left">
			<tr align="center">
				<td><jsp:include page="../per/applicanttab.jsp" flush="true">
					<jsp:param name="linkid" value="10" />
				</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="98%" border="0" cellpadding="0" cellspacing="0" class="outertable"
	align="center">
	<tr>
		<td>
		<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="3" class="outertable">
			<TR>
			<td>
			<table WIDTH="60%" BORDER="0" CELLSPACING="0" CELLPADDING="3" class="outertable" align="center">
			<tr>
				<TD align="center">Type of Agriculture</TD>
				<td><select name="sel_agrtype" onchange="callEnableFields();callIFrame();">
				<option value=""><--Select--></option>
				<option value="P">Agri-Production</option>
				<option value="Q">Agri-Quick</option>
				<option value="S">Agri-Subvention</option>
<!--				<option value="D">Agri-Development</option>-->
				</select></td>
			</TR>
			<TR id="idloantype" style="visibility: hidden;position: absolute;">
				<TD align="center">Type of Loan</TD>
				<td>
				<select name="sel_typeofloan" onchange="callEnableloanfields();callIFrame();">
				<option value="S"><--Select--></option>
				<option value="C">Crop Loan</option>
				<option value="A">Working Capital</option>
				</select>
				</td>
			</TR>
			</table>
			</td>
			</TR>
		</TABLE>
		</td>
	</tr>
	<tr id="idagriprod1" style="visibility: hidden;position: absolute;">
	<td>
	<table WIDTH="90%" BORDER="0" CELLSPACING="0" CELLPADDING="0" class="outertable" align="center" >
			<tr>
			<td>
			<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3" class="outertable" align="center" id="idMember1">
			<tr class="dataheader">
			<td colspan="4">Crop Production</td>
			<td align="center">
			<table  BORDER="0" CELLSPACING="0" CELLPADDING="3" class="outertable" align="right">
			<tr  align="right"> 
			<td>
			<img alt="Click to Add new row" 
			src="<%=ApplicationParams.getAppUrl()%>img/add.png" 
			onclick="processActionNewMember('PROD')" style="cursor:hand"/>
			</td>
			<td >
			<img alt="Click to Delete row" 
			src="<%=ApplicationParams.getAppUrl()%>img/cancel.png" 
			onclick="doButtonDeleteMember('PROD')" style="cursor:hand"/>
			</td>
			</tr>
			</table>
			</td>
			</tr>
			<tr class="dataheader">
			<td width="5%" align="center">S.No</td>
			<td width="25%" align="center">Area Under Cultivation(in acres)</td>
			<td width="35%" align="center">Nature of crops grown</td>
			<td width="20%" align="center">Scale of Finance</td>
			<td width="15%" align="center">Eligible loan amount</td>
			</tr>
			<%if(arrRow!=null && arrRow.size()>0){
			for(int j=0;j<arrRow.size();j++){
			arrCol=(ArrayList)arrRow.get(j);%>
			<tr  class="datagrid">
			<td width="5%" align="center" height="30">	<span id="liabsno"> <%=j+1%> <span></td>
													
			<td width="25%" align="center" height="30">
			<input	type="text" name="txt_area" size="20" maxlength="100"
				onKeyPress="allowNumber(this)"  value="<%=Helper.correctNull((String)arrCol.get(1)) %>" onblur="calscaleoffintot();roundtxt(this);" style="text-align: right" onchange="chkLandValue(this);"></td>
			<td width="35%" align="center" height="30">
			<input	type="text" name="txt_natureofcrops" size="35" maxlength="100"
				onKeyPress="allowAlphaNumeric()"  value="<%=Helper.correctNull((String)arrCol.get(2)) %>">
			</td>
			<td width="20%" align="center" height="30">
			<input	type="text" name="txt_scaleoffinance" size="15" maxlength="50"
				 value="<%=Helper.correctNull((String)arrCol.get(3)) %>" onKeyPress="allowNumber(this)" onblur="calscaleoffintot();roundtxt(this);" style="text-align: right"></td>
			<td width="15%" align="center" height="30">
			<input type="text" name="txt_amt" size="15" maxlength="50"
				tabindex="16" value="<%=Helper.correctNull((String)arrCol.get(4)) %>" style="text-align: right"></td>
			</tr>
		
			<% }}else{
			for(int i=0;i<5;i++){%>
			<tr  class="datagrid">
			<td width="5%" align="center" height="30">	<span id="liabsno"> <%=i+1 %> <span></td>
													
			<td width="25%" align="center" height="30">
			<input	type="text" name="txt_area" size="20" maxlength="100"
				onKeyPress="allowNumber(this)"  value="" onblur="calscaleoffintot();roundtxt(this);" style="text-align: right" onchange="chkLandValue(this);"></td>
			<td width="35%" align="center" height="30">
			<input	type="text" name="txt_natureofcrops" size="35" maxlength="100"
				onKeyPress="allowAlphaNumeric()"  value="">
			</td>
			<td width="20%" align="center" height="30">
			<input	type="text" name="txt_scaleoffinance" size="15" maxlength="50"
				 value="" onKeyPress="allowNumber(this)" onblur="calscaleoffintot();roundtxt(this);" style="text-align: right"></td>
			<td width="15%" align="center" height="30">
			<input type="text" name="txt_amt" size="15" maxlength="50"
				tabindex="16" value="" style="text-align: right"></td>
			</tr>
			<%} }%>
			</table>
			</td>
			</tr>
			<tr>
			<td>
			<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3" class="outertable" align="center">
			<tr  class="datagrid">
			<td width="85%" ><b>A) Total </b>
			</td>
			<td width="15%" align="center">
			<input type="text" name="txt_harvestexp" value="<%=Helper.correctNull((String)hshValues.get("agr_totalamt"))%>" size="15"  style="text-align: right" onblur="calscaleoffintot1();">
			</td>
			</tr>
			<tr  class="datagrid">
			<td width="85%" ><b>B) Loan for Post harvest Expenses</b> 
			</td>
			<td width="15%" align="center">
			<input type="text" name="txt_postharvestexp" value="<%=Helper.correctNull((String)hshValues.get("agr_margin_amt"))%>" size="15" style="text-align: right" onblur="roundtxt(this);calscaleoffintot1();">
			</td>
			</tr>
			<tr  class="datagrid">
			<td width="85%" ><b>Total Eligible Loan amount as per Scale of Finance/Cropping Pattern [A+B]</b>
			</td>
			<td width="15%" align="center">
			<input type="text" name="txt_scaleamt" value="<%=Helper.correctNull((String)hshValues.get("agr_eligible_amt"))%>" size="15"  style="text-align: right">
			</td>
			</tr>
			</table>
			</td>
			</tr>
	</table>
	</td>
	</tr>
	<tr id="idagriprod2" style="visibility: hidden;position: absolute;">
	<td>
	<table WIDTH="90%" BORDER="0" CELLSPACING="1" CELLPADDING="3" class="outertable" align="center" >
	<tr class="dataheader">
	<td> WORKING CAPITAL REQUIREMENT OF ALLIED ACTIVITIES
	</td>
	</tr>
	<tr class="dataheader">
	<td> Loan Amount Eligible as per Expenditure per Operating Cycle (Amount in Rs)
	</td>
	</tr>
	<tr>
	<td>
	<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3" class="outertable" align="center">
	<tr class="dataheader" align="center">
	<td width="5%" >Sl.No</td>
	<td width="70%">Description</td>
	<td width="25%">Amount</td>
	</tr>
	<tr class="datagrid">
	<td align="center"> 1
	</td>
	<td>Total Recurring Expenses for One Year/Cycle 
	</td>
	<td align="center"><input type="text" name="txt_recurramt" value="<%=Helper.correctNull((String)hshValues.get("agr_totalamt"))%>" onkeypress="allowNumber(this);" size="15" onblur="calworkingcapitaltot();roundtxt(this);" style="text-align: right">
	</td>
	</tr>
	<tr class="datagrid">
	<td align="center"> 2
	</td>
	<td> <%=Helper.correctNull((String)hshValues.get("dblRecurrexpMargin"))%> % of the Recurring expenses  
	</td>
	<td align="center"><input type="text" name="txt_recurrexp" value="<%=Helper.correctNull((String)hshValues.get("agr_margin_amt"))%>" onkeypress="allowNumber(this);"  size="15" onblur="roundtxt(this);" style="text-align: right">
	</td>
	</tr>
	<tr class="datagrid">
	<td align="center"> 3
	</td>
	<td> Eligible Loan Amount (Least of 1 and 2)
	</td>
	<td align="center"><input type="text" name="txt_eligibleamt" value="<%=Helper.correctNull((String)hshValues.get("agr_eligible_amt"))%>" onkeypress="allowNumber(this);" size="15" onblur="roundtxt(this);" style="text-align: right">
	</td>
	</tr>
	</table>
	</td>
	</tr>
	</table>
	</td>
	</tr>
	<tr id="idagriprod3" style="visibility: hidden;position: absolute;">
	<td>
	<%int j=0; %>
	<table WIDTH="90%" BORDER="0" CELLSPACING="1" CELLPADDING="3" class="outertable" align="center" id="idMember2">
			<tr class="dataheader">
			<td colspan="4">Agri Development</td>
			<td align="right">
			<table  BORDER="0" CELLSPACING="0" CELLPADDING="3" class="outertable" align="right">
			<tr align="right">
			<td>
			<img alt="Click to Add new row" 
			src="<%=ApplicationParams.getAppUrl()%>img/add.png" 
			onclick="processActionNewMember('DLP')" style="cursor:hand"/>
			</td>
			<td>
			<img alt="Click to Delete row" 
			src="<%=ApplicationParams.getAppUrl()%>img/cancel.png" 
			onclick="doButtonDeleteMember('DLP')" style="cursor:hand"/>
			</td>
			</tr>
			</table>
			</td>
			</tr>
			<tr class="dataheader">
			<td width="5%" align="center">S.No</td>
			<td width="40%" align="center">Activity</td>
			<td width="20%" align="center">Unit cost/Cost</td>
			<td width="20%" align="center">No. of units/Area</td>
			<td width="15%" align="center">Total cost</td>
			</tr>
			<%if(arrRow!=null && arrRow.size()>0){
			for(int k=0;k<arrRow.size();k++){
			arrCol=(ArrayList)arrRow.get(k);%>
			<tr  class="datagrid">
			<td  align="center" height="30">	<span id="immsno"> <%=k+1 %> <span></td>
													
			<td  align="center" height="30">
			<input	type="text" name="txt_activity" size="40" maxlength="100"
				onKeyPress="allowAlphaNumeric(this)"  value="<%=Helper.correctNull((String)arrCol.get(2)) %>"></td>
			<td  align="center" height="30">
			<input	type="text" name="txt_unitcost" size="15" maxlength="100"
				onKeyPress="allowNumber(this)"  value="<%=Helper.correctNull((String)arrCol.get(1)) %>" onblur="calagriprodtot();roundtxt(this);" style="text-align: right">
			</td>
			<td align="center" height="30">
			<input	type="text" name="txt_noofunits" size="15" maxlength="50"
				 value="<%=Helper.correctNull((String)arrCol.get(3)) %>" onKeyPress="allowNumber(this)" onblur="calagriprodtot();" style="text-align: right"></td>
			<td align="center" height="30">
			<input type="text" name="txt_totalcost" size="15" maxlength="50"
				tabindex="16" value="<%=Helper.correctNull((String)arrCol.get(4)) %>" style="text-align: right"></td>
			</tr>
		
			<% }}else{
			for(int i=0;i<5;i++){%>
			<tr  class="datagrid">
			<td  align="center" height="30">	<span id="immsno"> <%=i+1 %> <span></td>
													
			<td  align="center" height="30">
			<input	type="text" name="txt_activity" size="40" maxlength="100"
				onKeyPress="allowAlphaNumeric(this)"  value=""></td>
			<td  align="center" height="30">
			<input	type="text" name="txt_unitcost" size="15" maxlength="100"
				onKeyPress="allowNumber(this)"  value="" onblur="calagriprodtot();roundtxt(this);" style="text-align: right">
			</td>
			<td align="center" height="30">
			<input	type="text" name="txt_noofunits" size="15" maxlength="50"
				 value="" onKeyPress="allowNumber(this)" onblur="calagriprodtot();" style="text-align: right"></td>
			<td align="center" height="30">
			<input type="text" name="txt_totalcost" size="15" maxlength="50"
				tabindex="16" value="" style="text-align: right"></td>
			</tr>
			<%}} %>
			</table>
	</td>
	</tr>
	<tr id="idagriprod4" style="visibility: hidden;position: absolute;">
			<td>
			<table WIDTH="90%" BORDER="0" CELLSPACING="1" CELLPADDING="3" class="outertable" align="center">
			<tr  class="datagrid">
			<td width="85%" ><b>A) Total </b>
			</td>
			<td width="15%" align="center">
			<input type="text" name="txt_totalcost1" value="<%=Helper.correctNull((String)hshValues.get("agr_totalamt"))%>" size="15"  style="text-align: right" onblur="roundtxt(this);">
			</td>
			</tr>
			<tr  class="datagrid">
			<td width="85%" ><b>B)<%=Helper.correctNull((String)hshValues.get("dblAgridevelopMargin"))%> % of Total Cost</b> 
			</td>
			<td width="15%" align="center">
			<input type="text" name="txt_pertotalcost1" value="<%=Helper.correctNull((String)hshValues.get("agr_margin_amt"))%>" size="15" style="text-align: right" onblur="roundtxt(this);">
			</td>
			</tr>
			<tr  class="datagrid">
			<td width="85%" ><b>Eligible loan amount  [Least of A and B]</b>
			</td>
			<td width="15%" align="center">
			<input type="text" name="txt_eligibleamt1" value="<%=Helper.correctNull((String)hshValues.get("agr_eligible_amt"))%>" size="15"  style="text-align: right" onblur="roundtxt(this);">
			</td>
			</tr>
			</table>
			</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
</table>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail'
											btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<input type="hidden" name="hidgoldsno">
<input type="hidden" name="hidGRSNo">
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="radLoan" value="Y">
<input type="hidden" name="hidrow2" value="">
<input type="hidden" name="hidrow1" value="">
</form>
</body>
</html>
