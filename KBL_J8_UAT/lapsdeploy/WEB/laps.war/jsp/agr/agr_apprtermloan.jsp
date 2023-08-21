<%@include file = "../share/directives.jsp"%>

<%
			String PageType = Helper.correctNull((String) hshValues
					.get("PageType"));
			ArrayList vecRow = (ArrayList) hshValues.get("vecData");
			int vecsize = vecRow.size();
			ArrayList vecCol0 = new ArrayList();
			ArrayList vecCol1 = new ArrayList();
			ArrayList vecCol2 = new ArrayList();
			ArrayList vecCol3 = new ArrayList();
			ArrayList vecCol4 = new ArrayList();
			ArrayList vecCol5 = new ArrayList();
			ArrayList vecCol6 = new ArrayList();
			ArrayList vecCol7 = new ArrayList();
			ArrayList vecCol8 = new ArrayList();
			ArrayList vecCol9 = new ArrayList();
			ArrayList vecCol10 = new ArrayList();
			ArrayList vecCol11 = new ArrayList();
			ArrayList vecCol12 = new ArrayList();
			ArrayList vecCol13 = new ArrayList();
			if (vecsize != 0) {
				vecCol0 = (ArrayList) vecRow.get(0);
				vecCol1 = (ArrayList) vecRow.get(1);
				vecCol2 = (ArrayList) vecRow.get(2);
				vecCol3 = (ArrayList) vecRow.get(3);
				vecCol4 = (ArrayList) vecRow.get(4);
				vecCol5 = (ArrayList) vecRow.get(5);
				vecCol6 = (ArrayList) vecRow.get(6);
				vecCol7 = (ArrayList) vecRow.get(7);
				vecCol8 = (ArrayList) vecRow.get(8);
				vecCol9 = (ArrayList) vecRow.get(9);
				vecCol10 = (ArrayList) vecRow.get(10);
				vecCol11 = (ArrayList) vecRow.get(11);
				vecCol12 = (ArrayList) vecRow.get(12);
				vecCol13 = (ArrayList) vecRow.get(13);
			}
			ArrayList grossexpcol = new ArrayList();
			ArrayList grossexprow = (ArrayList) hshValues.get("grossExpRow");

			Double row0[] = new Double[15];
			Double row1[] = new Double[15];
			Double row2[] = new Double[15];
			Double row3[] = new Double[15];

			for (int i = 0; i < 14; i++) {
				grossexpcol = (ArrayList) grossexprow.get(i);
				row0[i] = (Double) grossexpcol.get(0);
				row1[i] = (Double) grossexpcol.get(1);
				row2[i] = (Double) grossexpcol.get(2);
				row3[i] = (Double) grossexpcol.get(3);
			}
%>
<html>
<head>
<title>Live Stock Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var sel_payment="<%=Helper.correctNull((String)hshValues.get("txt_payment"))%>";

function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updatecroptermassData";
		document.forms[0].hidBeanGetMethod.value="getcroptermData";
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidSourceUrl.value="/action/agr_apprtermloan.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	} 
}
function doSave()
{
	document.forms[0].cmdsave.disabled=true;
    document.forms[0].hidAction.value="insert";	
    document.forms[0].hidBeanId.value="agreconomic";
   	document.forms[0].hidSourceUrl.value="/action/agr_apprtermloan.jsp";
	document.forms[0].hidBeanMethod.value="updatecroptermassData";
	document.forms[0].hidBeanGetMethod.value="getcroptermData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();	
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

function doEdit()
{
 	disableFields(true);
 	/*var roi="<%//=Helper.correctNull((String)hshValues.get("txt_roiTL"))%>";
 	if(roi != "")
 	{
		document.forms[0].txt_roiTL.readOnly=false;
	}
	
	var repay="<%//=Helper.correctNull((String)hshValues.get("txt_repayTL"))%>";
  	if(repay != "")
 	{
		document.forms[0].txt_repayTL.readOnly=false;
	}
	
	var sel_payment="<%//=Helper.correctNull((String)hshValues.get("txt_payment"))%>";
 	if(sel_payment != "")
 	{
		document.forms[0].sel_payment.disabled=false;
	}
	
	var installment="<%//=Helper.correctNull((String)hshValues.get("txt_installment"))%>";
 	if(installment != "")
 	{
		document.forms[0].txt_installment.readOnly=false;
	}
	
	var date="<%//=Helper.correctNull((String)hshValues.get("agr_date"))%>";
 	if(date != "")
 	{
		document.forms[0].txt_date.readOnly=false;
	}
	
	var holiday="<%//=Helper.correctNull((String)hshValues.get("txt_holiday"))%>";
 	if(holiday != "")
 	{
		document.forms[0].txt_holiday.readOnly=false;
	}
	
	document.forms[0].hidAction.value ="insert"; 
	enableButtons(true, false, false, true, true);*/
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidBeanGetMethod.value="getcroptermData";
		document.forms[0].action=appURL +"action/agr_apprtermloan.jsp";
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
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
		
	}
}
function onloading()
{
	var sel_payment="<%=Helper.correctNull((String)hshValues.get("txt_payment"))%>"
	if(sel_payment!="")
	{
		document.forms[0].sel_payment.value=sel_payment;
	}
	document.forms[0].cmdedit.disabled=true;
}

</script>

</head>
<body onload="onloading()">
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellpadding="5" cellspacing="1" class="outertable">

	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="2"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="1" cellpadding="0" class="outertable">
					<tr>
						<td>

						<table width="100%" border="0" cellspacing="1" cellpadding="3"
							class="outertable">
                      <tr> 
                        <td> <table width="100%" border="0" cellspacing="1" cellpadding="3"
									class="outertable">
                            <tr class="dataheader"> 
                              <td colspan="10" align="center" ><b>Live 
                                Stock</b> </td>
                            </tr>
                            <tr class="dataheader"> 
                              <td width="12%" align="center" >Live 
                                Stock Particulars</td>
                              <td width="9%" align="center" >No 
                                of Animal</td>
                              <td width="10%" align="center" >Cost 
                                per Animal(<%=ApplicationParams.getCurrency()%>)</td>
                              <td width="10%" align="center" >Working 
                                Capital (Feed + Vet.Care+Ins)(<%=ApplicationParams.getCurrency()%>)</td>
                              <td width="10%" align="center">Estimated 
                                Cost (<%=ApplicationParams.getCurrency()%>)</td>
                              <td width="9%" align="center" >Margin(<%=ApplicationParams.getCurrency()%>)</td>
                              <td width="10%" align="center">Loan 
                                Amount (<%=ApplicationParams.getCurrency()%>)</td>
                              <td width="10%" align="center" >&nbsp;Income 
                                / Year(<%=ApplicationParams.getCurrency()%>)</td>
                              <td width="10%" align="center" >
                                Expenses / Year(<%=ApplicationParams.getCurrency()%>)</td>
                              <td width="10%" align="center" >Net 
                                Income / Year(<%=ApplicationParams.getCurrency()%>)</td>
                            </tr>
                            <tr > 
                              <td align="center"><input type="text" name="txt_stockpart"
											value="<%=vecCol0.get(2)%>" size="15" maxlength="30"
											style="text-align:left"></td>
                              <td align="center">
                                <input type="text"
											name="txt_noofanimal" value="<%=vecCol0.get(3)%>" size="10"
											maxlength="9" onKeyPress="allowDecimals()"
											style="text-align:right">
                               </td>
                              <td align="center"><input type="text" name="txt_costanimal"
											value="<%=vecCol0.get(4)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_workcap"
											value="<%=vecCol0.get(5)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_estimcost"
											value="<%=vecCol0.get(9)%>" size="13" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_margin"
											value="<%=vecCol0.get(10)%>" size="13" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_loanamt"
											value="<%=row3[0]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_gross"
											value="<%=row0[0]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_totexp"
											value="<%=row1[0]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_netamt"
											value="<%=row2[0]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                            </tr>
                            <tr > 
                              <td align="center"><input type="text" name="txt_stockpart"
											value="<%=vecCol1.get(2)%>" size="15" maxlength="30"
											style="text-align:left"></td>
                              <td align="center">
                                <input type="text"
											name="txt_noofanimal" value="<%=vecCol1.get(3)%>" size="10"
											maxlength="9" onKeyPress="allowDecimals()"
											style="text-align:right">
                                </td>
                              <td align="center"><input type="text" name="txt_costanimal"
											value="<%=vecCol1.get(4)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_workcap"
											value="<%=vecCol1.get(5)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_estimcost"
											value="<%=vecCol1.get(9)%>" size="13" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_margin"
											value="<%=vecCol1.get(10)%>" size="13" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_loanamt"
											value="<%=row3[1]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_gross"
											value="<%=row0[1]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_totexp"
											value="<%=row1[1]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_netamt"
											value="<%=row2[1]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                            </tr>
                            <tr > 
                              <td align="center"><input type="text" name="txt_stockpart"
											value="<%=vecCol2.get(2)%>" size="15" maxlength="30"
											style="text-align:left"></td>
                              <td align="center">
                                <input type="text"
											name="txt_noofanimal" value="<%=vecCol2.get(3)%>" size="10"
											maxlength="9" onKeyPress="allowDecimals()"
											style="text-align:right">
                                </td>
                              <td align="center"><input type="text" name="txt_costanimal"
											value="<%=vecCol2.get(4)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_workcap"
											value="<%=vecCol2.get(5)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_estimcost"
											value="<%=vecCol2.get(9)%>" size="13" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_margin"
											value="<%=vecCol2.get(10)%>" size="13" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_loanamt"
											value="<%=row3[2]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_gross"
											value="<%=row0[2]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_totexp"
											value="<%=row1[2]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_netamt"
											value="<%=row2[2]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                            </tr>
                          </table>
                          <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                            <tr class="dataheader"> 
                              <td colspan="10" align="center" ><b>Poultry</b></td>
                            </tr>
                            <tr class="dataheader"> 
                              <td width="12%" align="center">
                                Particulars</td>
                              <td width="9%" align="center">No 
                                of Birds</td>
                              <td width="10%"  align="center">Cost 
                                per Bird(<%=ApplicationParams.getCurrency()%>)</td>
                              <td width="10%"  align="center">Working 
                                Capital (Feed + Vet.Care+Ins)(<%=ApplicationParams.getCurrency()%>)</td>
                              <td width="10%"  align="center">Estimated 
                                Cost (<%=ApplicationParams.getCurrency()%>)</td>
                              <td width="9%"  align="center">Margin(<%=ApplicationParams.getCurrency()%>)</td>
                              <td width="10%" align="center">Loan 
                                Amount(<%=ApplicationParams.getCurrency()%>)</td>
                              <td width="10%" align="center">&nbsp;&nbsp;Income 
                                / Year(<%=ApplicationParams.getCurrency()%>)</td>
                              <td width="10%" align="center">
                                Expenses / Year(<%=ApplicationParams.getCurrency()%>)</td>
                              <td width="10%"  align="center">Net 
                                Income / Year(<%=ApplicationParams.getCurrency()%>)</td>
                            </tr>
                            <tr > 
                              <td align="center"><input type="text" name="txt_pstockpart"
											value="<%=vecCol3.get(2)%>" size="15" maxlength="30"
											style="text-align:left"></td>
                              <td align="center">
                                <input type="text"
											name="txt_pnoofanimal" value="<%=vecCol3.get(3)%>" size="10"
											maxlength="9" onKeyPress="allowDecimals()"
											style="text-align:right">
                               </td>
                              <td align="center"><input type="text" name="txt_pcostanimal"
											value="<%=vecCol3.get(4)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_pworkcap"
											value="<%=vecCol3.get(5)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_pestimcost"
											value="<%=vecCol3.get(9)%>" size="13" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_pmargin"
											value="<%=vecCol3.get(10)%>" size="13" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_ploanamt"
											value="<%=row3[3]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_pgross"
											value="<%=row0[3]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_ptotexp"
											value="<%=row1[3]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_pnetamt"
											value="<%=row2[3]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                            </tr>
                            <tr > 
                              <td align="center"><input type="text" name="txt_pstockpart"
											value="<%=vecCol4.get(2)%>" size="15" maxlength="30"
											style="text-align:left"></td>
                              <td align="center">
                                <input type="text"
											name="txt_pnoofanimal" value="<%=vecCol4.get(3)%>" size="10"
											maxlength="9" onKeyPress="allowDecimals()"
											style="text-align:right">
                               </td>
                              <td align="center"><input type="text" name="txt_pcostanimal"
											value="<%=vecCol4.get(4)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_pworkcap"
											value="<%=vecCol4.get(5)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_pestimcost"
											value="<%=vecCol4.get(9)%>" size="13" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_pmargin"
											value="<%=vecCol4.get(10)%>" size="13" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_ploanamt"
											value="<%=row3[4]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_pgross"
											value="<%=row0[4]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_ptotexp"
											value="<%=row1[4]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_pnetamt"
											value="<%=row2[4]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                            </tr>
                            <tr > 
                              <td align="center"><input type="text" name="txt_pstockpart"
											value="<%=vecCol5.get(2)%>" size="15" maxlength="30"
											style="text-align:left"></td>
                              <td align="center">
                                <input type="text"
											name="txt_pnoofanimal" value="<%=vecCol5.get(3)%>" size="10"
											maxlength="9" onKeyPress="allowDecimals()"
											style="text-align:right">
                                </td>
                              <td align="center"><input type="text" name="txt_pcostanimal"
											value="<%=vecCol5.get(4)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_pworkcap"
											value="<%=vecCol5.get(5)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_pestimcost"
											value="<%=vecCol5.get(9)%>" size="13" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_pmargin"
											value="<%=vecCol5.get(10)%>" size="13" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_ploanamt"
											value="<%=row3[5]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_pgross"
											value="<%=row0[5]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_ptotexp"
											value="<%=row1[5]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_pnetamt"
											value="<%=row2[5]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                            </tr>
                            <tr > 
                              <td height="31" align="center"><input type="text"
											name="txt_pstockpart" value="<%=vecCol6.get(2)%>" size="15"
											maxlength="30" style="text-align:left"></td>
                              <td align="center">
                                <input type="text"
											name="txt_pnoofanimal" value="<%=vecCol6.get(3)%>" size="10"
											maxlength="9" onKeyPress="allowDecimals()"
											style="text-align:right">
                               </td>
                              <td align="center"><input type="text" name="txt_pcostanimal"
											value="<%=vecCol6.get(4)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_pworkcap"
											value="<%=vecCol6.get(5)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_pestimcost"
											value="<%=vecCol6.get(9)%>" size="13" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_pmargin"
											value="<%=vecCol6.get(10)%>" size="13" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_ploanamt"
											value="<%=row3[6]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_pgross"
											value="<%=row0[6]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_ptotexp"
											value="<%=row1[6]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_pnetamt"
											value="<%=row2[6]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                            </tr>
                            <tr > 
                              <td align="center"><input type="text" name="txt_pstockpart"
											value="<%=vecCol7.get(2)%>" size="15" maxlength="30"
											style="text-align:left"></td>
                              <td align="center">
                                <input type="text"
											name="txt_pnoofanimal" value="<%=vecCol7.get(3)%>" size="10"
											maxlength="9" onKeyPress="allowDecimals()"
											style="text-align:right">
                              </td>
                              <td align="center"><input type="text" name="txt_pcostanimal"
											value="<%=vecCol7.get(4)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_pworkcap"
											value="<%=vecCol7.get(5)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_pestimcost"
											value="<%=vecCol7.get(9)%>" size="13" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_pmargin"
											value="<%=vecCol7.get(10)%>" size="13" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_ploanamt"
											value="<%=row3[7]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_pgross"
											value="<%=row0[7]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_ptotexp"
											value="<%=row1[7]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_pnetamt"
											value="<%=row2[7]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                            </tr>
                            <tr > 
                              <td align="center">&nbsp;</td>
                              <td align="center">&nbsp;</td>
                              <td align="center">&nbsp;</td>
                              <td align="center">&nbsp;</td>
                              <td align="center"><input type="text"
											name="txt_ptotalestimate" value="<%=vecCol4.get(14)%>"
											size="13" maxlength="9" onKeyPress="allowDecimals()"
											style="text-align:right" readonly="readonly"></td>
                              <td align="center"><input type="text" name="txt_ptotalmargin"
											value="<%=vecCol4.get(15)%>" size="13" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"
											readonly="readonly"></td>
                              <td align="center">&nbsp;</td>
                              <td align="center">&nbsp;</td>
                              <td align="center">&nbsp;</td>
                              <td align="center">&nbsp;</td>
                            </tr>
                          </table>
                          <table width="100%" border="0" cellspacing="1" cellpadding="3"
									class="outertable">
                            <tr class="dataheader"> 
                              <td colspan="8" align="center" ><b>Farm 
                                Machinery (Power Tiller/Pump Set/Sprinkler/Etc.)</b></td>
                            </tr>
                            <tr class="dataheader">  
                              <td width="13%"  align="center">
                                Particulars</td>
                              <td width="12%"  align="center">Area 
                                Benefited (Own + Other lands)</td>
                              <td width="12%" align="center">Estimated 
                                Cost (<%=ApplicationParams.getCurrency()%>)</td>
                              <td width="12%"  align="center" nowrap="nowrap">Margin(<%=ApplicationParams.getCurrency()%>)</td>
                              <td width="12%" align="center">Loan 
                                Amount(<%=ApplicationParams.getCurrency()%>)</td>
                              <td width="12%"  align="center">&nbsp;Income 
                                / Year(<%=ApplicationParams.getCurrency()%></td>
                              <td width="12%" align="center">Expenses 
                                / Year(<%=ApplicationParams.getCurrency()%>)</td>
                              <td width="15%"  align="center">Net 
                                Income / Year(<%=ApplicationParams.getCurrency()%>)</td>
                            </tr>
                            <tr > 
                              <td align="center" width="13%">
<input type="text" name="txt_fstockpart"
											value="<%=vecCol8.get(2)%>" size="15" maxlength="30"
											style="text-align:left"></td>
                              <td align="center" width="12%">
                                <input type="text"
											name="txt_farea" value="<%=vecCol8.get(6)%>" size="10"
											maxlength="9" onKeyPress="allowDecimals()"
											style="text-align:right">
                                </td>
                              <td align="center" width="12%">
<input type="text" name="txt_fesmcost"
											value="<%=vecCol8.get(9)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center" width="12%">
<input type="text" name="txt_fmargin"
											value="<%=vecCol8.get(10)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center" width="12%">
<input type="text" name="txt_floanamt"
											value="<%=row3[8]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center" width="12%">
<input type="text" name="txt_fgrossinc"
											value="<%=row0[8]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center" width="12%">
<input type="text" name="txt_ftotexpend"
											value="<%=row1[8]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center" width="15%">
<input type="text" name="txt_fnetamt"
											value="<%=row2[8]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                            </tr>
                            <tr > 
                              <td align="center" width="13%">
<input type="text" name="txt_fstockpart"
											value="<%=vecCol9.get(2)%>" size="15" maxlength="30"
											style="text-align:left"></td>
                              <td align="center" width="12%">
                                <input type="text"
											name="txt_farea" value="<%=vecCol9.get(6)%>" size="10"
											maxlength="9" onKeyPress="allowDecimals()"
											style="text-align:right">
                                </td>
                              <td align="center" width="12%">
<input type="text" name="txt_fesmcost"
											value="<%=vecCol9.get(9)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center" width="12%">
<input type="text" name="txt_fmargin"
											value="<%=vecCol9.get(10)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center" width="12%">
<input type="text" name="txt_floanamt"
											value="<%=row3[9]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center" width="12%">
<input type="text" name="txt_fgrossinc"
											value="<%=row0[9]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center" width="12%">
<input type="text" name="txt_ftotexpend"
											value="<%=row1[9]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center" width="15%">
<input type="text" name="txt_fnetamt"
											value="<%=row2[9]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                            </tr>
                            <tr > 
                              <td align="center" width="13%">
<input type="text" name="txt_fstockpart"
											value="<%=vecCol10.get(2)%>" size="15" maxlength="30"
											style="text-align:left"></td>
                              <td align="center" width="12%">
                                <input type="text"
											name="txt_farea" value="<%=vecCol10.get(6)%>" size="10"
											maxlength="9" onKeyPress="allowDecimals()"
											style="text-align:right">
                                </td>
                              <td align="center" width="12%">
<input type="text" name="txt_fesmcost"
											value="<%=vecCol10.get(9)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center" width="12%">
<input type="text" name="txt_fmargin"
											value="<%=vecCol10.get(10)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center" width="12%">
<input type="text" name="txt_floanamt"
											value="<%=row3[10]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center" width="12%">
<input type="text" name="txt_fgrossinc"
											value="<%=row0[10]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center" width="12%">
<input type="text" name="txt_ftotexpend"
											value="<%=row1[10]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center" width="15%">
<input type="text" name="txt_fnetamt"
											value="<%=row2[10]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                            </tr>
                          </table>
                          <table width="100%" border="0" cellspacing="1" cellpadding="3"
									class="outertable">
                            <tr class="dataheader"> 
                              <td colspan="9" align="center"><b>Farm 
                                House/Shed/Godown/Barn/Well digging/Deepening/Fencing/Binding/Land 
                                Development / Etc</b></td>
                            </tr>
                            <tr class="dataheader"> 
                              <td width="12%" align="center">
                                Particulars</td>
                              <td width="14%"  align="center">Total 
                                Dimension (L X B)</td>
                              <td width="15%"  align="center" nowrap="nowrap">Total 
                                Volume (L X B X H)</td>
                              <td width="8%"  align="center">Estimated 
                                Cost (<%=ApplicationParams.getCurrency()%>)</td>
                              <td width="8%"  align="center">Margin(<%=ApplicationParams.getCurrency()%>)</td>
                              <td width="11%"  align="center">Loan 
                                Amount(<%=ApplicationParams.getCurrency()%>)</td>
                              <td width="14%"  align="center">&nbsp;Income 
                                / Year(<%=ApplicationParams.getCurrency()%>)</td>
                              <td width="7%" align="center">Expenses 
                                / Year(<%=ApplicationParams.getCurrency()%>)</td>
                              <td width="11%"  align="center">Net 
                                Income / Year(<%=ApplicationParams.getCurrency()%>)</td>
                            </tr>
                            <tr > 
                              <td align="center"><input type="text" name="txt_ostockpart"
											value="<%=vecCol11.get(2)%>" size="15" maxlength="30"
											style="text-align:left"></td>
                              <td align="center">
                                <input type="text"
											name="txt_odimension" value="<%=vecCol11.get(7)%>" size="10"
											maxlength="9" onKeyPress="allowDecimals()"
											style="text-align:right">
                               </td>
                              <td align="center"><input type="text" name="txt_ovolume"
											value="<%=vecCol11.get(8)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_oestimate"
											value="<%=vecCol11.get(9)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_omargin"
											value="<%=vecCol11.get(10)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_oloanamt"
											value="<%=row3[11]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_ogrossinc"
											value="<%=row0[11]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_ototexp"
											value="<%=row1[11]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_onetamt"
											value="<%=row2[11]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                            </tr>
                            <tr > 
                              <td align="center"><input type="text" name="txt_ostockpart"
											value="<%=vecCol12.get(2)%>" size="15" maxlength="30"
											style="text-align:left"></td>
                              <td align="center">
                                <input type="text"
											name="txt_odimension" value="<%=vecCol12.get(7)%>" size="10"
											maxlength="9" onKeyPress="allowDecimals()"
											style="text-align:right">
                               </td>
                              <td align="center"><input type="text" name="txt_ovolume"
											value="<%=vecCol12.get(8)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_oestimate"
											value="<%=vecCol12.get(9)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_omargin"
											value="<%=vecCol12.get(10)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_oloanamt"
											value="<%=row3[12]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_ogrossinc"
											value="<%=row0[12]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_ototexp"
											value="<%=row1[12]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_onetamt"
											value="<%=row2[12]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                            </tr>
                            <tr > 
                              <td align="center"><input type="text" name="txt_ostockpart"
											value="<%=vecCol13.get(2)%>" size="15" maxlength="30"
											style="text-align:left"></td>
                              <td align="center">
                                <input type="text"
											name="txt_odimension" value="<%=vecCol13.get(7)%>" size="10"
											maxlength="9" onKeyPress="allowDecimals()"
											style="text-align:right">
                             </td>
                              <td align="center"><input type="text" name="txt_ovolume"
											value="<%=vecCol13.get(8)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_oestimate"
											value="<%=vecCol13.get(9)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_omargin"
											value="<%=vecCol13.get(10)%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_oloanamt"
											value="<%=row3[13]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_ogrossinc"
											value="<%=row0[13]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_ototexp"
											value="<%=row1[13]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals()" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_onetamt"
											value="<%=row2[13]%>" size="10" maxlength="9"
											onKeyPress="allowDecimals(this)" style="text-align:right"></td>
                            </tr>
                            <tr > 
                              <td colspan="9" align="right">&nbsp;</td>
                            </tr>
                            <tr > 
                              <td colspan="9" align="center">
											<b>Total Margin Amount &nbsp;</b><b>
<input
											type="text" name="txt_totmaramt"
											value="<%=Helper.correctNull((String)hshValues.get("totmaramt"))%>"
											size="10" maxlength="9" onKeyPress="allowDecimals(this)"
											style="text-align:right" readonly="readonly">
                                </b></td>
                            </tr>
                            <tr > 
                              <td colspan="9" align="center"><b>Total Loan Amount</b>&nbsp;&nbsp;
                                <input type="text" name="txt_totloanamt"
											value="<%=Helper.correctNull((String)hshValues.get("totloanamt"))%>"
											size="10" maxlength="9" onKeyPress="allowDecimals(this)"
											style="text-align:right">
                               </td>
                            </tr>
                            
  <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
                           
                          </table></td>
                      </tr>
                      <tr class="outertable"> 
                        <td> </td>
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
<input type="hidden" name="hidAction" value="insert"> 
<input type="hidden" name="hidcroptype"> 
<laps:agrihiddentag/>
</form>
</body>
</html>
