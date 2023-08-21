<%@include file = "../share/directives.jsp"%>

<%
	String PageType = Helper.correctNull((String) hshValues
			.get("PageType"));
	ArrayList vecRow = (ArrayList) hshValues.get("vecData");
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
	
	if (vecRow != null) {
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
%>
<html>
<head>
<title>Live Stock Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
//var sel_payment="<%//=Helper.correctNull((String)hshValues.get("sel_payment"))%>"

function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
		
	}
}
function checkroi()
{
var txt_roiTL=document.forms[0].txt_roiTL.value;
if(txt_roiTL=="")
{
txt_roiTL="0.00";
}
if(txt_roiTL>100)
{
alert('Rate of Interest cannot exceed 100%');
document.forms[0].txt_roiTL.value="";
return;
}
}
function callhelp()
{
	var varQryString = appURL+"/jsp/perhlp/hlp_croptermloan.jsp";
	var title = "ApplicantDemographics";
	var prop = "scrollbars=no,width=600,height=450";	
	prop = prop + ",left=200,top=150";
	window.open(varQryString,title,prop);
}

function enableButtons(bool1, bool2, bool3, bool4, bool5)
{	
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	//document.forms[0].cmdclose.disabled = bool5;
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

function doSave()
{
	// Live Stock
	for(var i=0; i<3; i++)
	{
		if(document.forms[0].txt_stockpart[i].value!="")
		{
			if(document.forms[0].txt_noofanimal[i].value=="")
			{	
				alert("Enter the No of Animals in Live Stock");
				document.forms[0].txt_noofanimal[i].focus();
				return;
			}
			if(document.forms[0].txt_costanimal[i].value=="")
			{	
				alert("Enter the Cost of Animal in Live Stock");
				document.forms[0].txt_costanimal[i].focus();
				return;
			}
			if(document.forms[0].txt_workcap[i].value=="")
			{	
				alert("Enter the Working Capital in Live Stock");
				document.forms[0].txt_workcap[i].focus();
				return;
			}
			if(document.forms[0].txt_margin[i].value=="")
			{	
				alert("Enter the Margin in Live Stock");
				document.forms[0].txt_margin[i].focus();
				return;
			}
			if(document.forms[0].txt_gross[i].value=="")
			{	
				alert("Enter the Gross in Live Stock");
				document.forms[0].txt_gross[i].focus();
				return;
			}
			if(document.forms[0].txt_totexp[i].value=="")
			{	
				alert("Enter the Total Expenses in Live Stock");
				document.forms[0].txt_totexp[i].focus();
				return;
			}
		} // if
	}// for
	
	// paultry

	for(var i=0; i<5; i++)
	{
		if(document.forms[0].txt_pstockpart[i].value!="")
		{
			if(document.forms[0].txt_pnoofanimal[i].value=="")
			{	
				alert("Enter the No of Birds in Poultry");
				document.forms[0].txt_pnoofanimal[i].focus();
				return;
			}
			if(document.forms[0].txt_pcostanimal[i].value=="")
			{	
				alert("Enter the Cost of Bird in Poultry");
				document.forms[0].txt_pcostanimal[i].focus();
				return;
			}
			if(document.forms[0].txt_pworkcap[i].value=="")
			{	
				alert("Enter the Working Capital in Poultry");
				document.forms[0].txt_pworkcap[i].focus();
				return;
			}
			if(document.forms[0].txt_pmargin[i].value=="")
			{	
				alert("Enter the Margin in Poultry");
				document.forms[0].txt_pmargin[i].focus();
				return;
			}
			if(document.forms[0].txt_pgross[i].value=="")
			{	
				alert("Enter the Gross in Poultry");
				document.forms[0].txt_pgross[i].focus();
				return;
			}
			if(document.forms[0].txt_ptotexp[i].value=="")
			{	
				alert("Enter the Total Expenses in Poultry");
				document.forms[0].txt_ptotexp[i].focus();
				return;
			}
		} // if
	}// for

	// Farm Machinery
	
	for(var i=0; i<3; i++)
	{
		if(document.forms[0].txt_fstockpart[i].value!="")
		{
			if(document.forms[0].txt_farea[i].value=="")
			{	
				alert("Enter the Area Benefited in Farm Machinery");
				document.forms[0].txt_farea[i].focus();
				return;
			}
			if(document.forms[0].txt_fesmcost[i].value=="")
			{	
				alert("Enter the Estimate Cost in Farm Machinery");
				document.forms[0].txt_fesmcost[i].focus();
				return;
			}
			if(document.forms[0].txt_fmargin[i].value=="")
			{	
				alert("Enter the Margin in Farm Machinery");
				document.forms[0].txt_fmargin[i].focus();
				return;
			}
		} // if
	}// for
	
	//Farm House/Shed/Godown/Barn
	
	for(var i=0; i<3; i++)
	{
		if(document.forms[0].txt_ostockpart[i].value!="")
		{
			if(document.forms[0].txt_oestimate[i].value=="")
			{	
				alert("Enter the Estimate in Farm House/Shed/Godown/Barn");
				document.forms[0].txt_oestimate[i].focus();
				return;
			}
			if(document.forms[0].txt_omargin[i].value=="")
			{	
				alert("Enter the Margin in Farm House/Shed/Godown/Barn");
				document.forms[0].txt_omargin[i].focus();
				return;
			}
		} // if
	}// for

	for(var i=0; i<3; i++){
		
		document.forms[0].txt_estimcost[i].readOnly=false;
	}
	for(var i=0; i<5; i++){
		
		document.forms[0].txt_pestimcost[i].readOnly=false;
	}

	document.forms[0].txt_ptotalestimate.readOnly=false;
	document.forms[0].txt_ptotalmargin.readOnly=false;
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidBeanId.value="agreconomic";		
	document.forms[0].hidSourceUrl.value="/action/agr_croptermloan.jsp";
	document.forms[0].hidBeanMethod.value="updatecroptermData";
	document.forms[0].hidBeanGetMethod.value="getcroptermData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();	
}

function doEdit()
{
 	disableFields(false);
	document.forms[0].hidAction.value ="update"; 
	
	enableButtons(true, false, false, false);
	for(var i=0; i<3; i++){
		
		document.forms[0].txt_estimcost[i].readOnly=true;
	}
	
	for(var i=0; i<5; i++){
		
		document.forms[0].txt_pestimcost[i].readOnly=true;
	}
	
	document.forms[0].txt_ptotalestimate.readOnly=true;
	document.forms[0].txt_ptotalmargin.readOnly=true;
	
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		//document.forms[0].hidSourceUrl.value="/action/agr_croptermloan.jsp";
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidBeanGetMethod.value="getcroptermData";
		//document.forms[0].hidBeanMethod.value="updatecroptermData";
		document.forms[0].action=appURL +"action/agr_croptermloan.jsp";
		document.forms[0].submit(); 	
	}
}

function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updatecroptermData";
		document.forms[0].hidBeanGetMethod.value="getcroptermData";
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidSourceUrl.value="/action/agr_croptermloan.jsp";	
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
/*var sel_payment="<%//=Helper.correctNull((String)hshValues.get("sel_payment"))%>"

if(sel_payment!="")
	{
		document.forms[0].sel_payment.value=sel_payment;
	}*/
	disableFields(true);
	
}

function costestimation(obj1, obj2, obj3, obj4)
{
	var obj11=obj1.value;
	if(obj11=="" || obj11==".")
	{
		obj11=0.00;
	}

	if(obj2=="" || obj2==".")
	{
		obj2=0.00;
	}
	
	if(obj3=="" || obj3==".")
	{
		obj3=0.00;
	}
	
	var res=eval((obj2))*eval((obj11));
	var res1=eval(res)+eval(obj3);
	obj4.value=res1;
}

function costestimation1(obj1, obj2, obj3, obj4)
{
	var obj11=obj1.value;
	if(obj11=="" || obj11==".")
	{
		obj11=0.00;
	}

	if(obj2=="" || obj2==".")
	{
		obj2=0.00;
	}
	
	if(obj3=="" || obj3==".")
	{
		obj3=0.00;
	}
	var res=eval((obj2))*eval((obj3));
	var res1=eval(res)+eval(obj11);
	obj4.value=res1;
}

function totpestimatemeth()
{
	var totalpest=0;
	var temp=0;
	for(var i=0; i<5; i++)
	{
		temp=document.forms[0].txt_pestimcost[i].value;
		if(temp=="")
		{
			temp=0.00;
		}
		totalpest=eval(totalpest)+eval(temp);
	}	
	document.forms[0].txt_ptotalestimate.value=totalpest;
}

function totpmargin()
{
	var totalpmargin=0;
	var temp=0;
	for(var i=0; i<5; i++)
	{
		temp=document.forms[0].txt_pmargin[i].value;
		if(temp=="")
		{
			temp=0.00;
		}
			totalpmargin=eval(totalpmargin)+eval(temp);
	}	
	document.forms[0].txt_ptotalmargin.value=totalpmargin;
}

function checkMargin(obj)
{
	if(obj.value!="")
	{
		if(parseFloat(obj.value) >100)
		{
			alert("Margin amount cannot be greater than 100");
			obj.value="";
			obj.focus();
			return;
		}
		if(parseFloat(obj.value) < parseFloat(varMarginPercent))
		{
			alert("Margin should not be less than the Product margin percentage");
			obj.value="";
			obj.focus();
			return;
		}
	}
}

function calculateMargin(obj, value, section)
{
	if(value!="")
	{
		var varMargin;
		if(section=="live")
		{
			varMargin = document.forms[0].txt_marginpercent.value;
		}
		else if(section=="poultry")
		{
			varMargin = document.forms[0].txt_marginpercent2.value;
		}
		else if(section=="machine")
		{
			varMargin = document.forms[0].txt_marginpercent3.value;
		}
		else if(section=="others")
		{
			varMargin = document.forms[0].txt_marginpercent4.value;
		}

		obj.value = parseFloat(value)*parseFloat(varMargin)/100;	
	}
}

</script>

</head>
<body  onload="onloading()">
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellpadding="5" cellspacing="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>

								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="3"
									class="outertable">
									<tr class="dataheader">
										<td colspan="8" align="center" ><b>Live Stock</b>
										</td>
									</tr>
									<tr class="dataheader">
										<td width="14%" align="center" >Live Stock
										Particulars</td>
										<td width="12%" align="center">No of Animal</td>
										
                        <td width="12%" align="center">Cost 
                          per Animal(Rs.)</td>
										
                        <td width="13%" align="center" >Working 
                          Capital (Feed + Vet.Care+Ins)(Rs.)</td>
                        <td width="12%" align="center" >Estimated 
                          Cost (Rs.) </td>
										
                        <td width="12%" align="center" >Margin 
                                                   Money (Rs.)</td>
										
                        <td width="12%" align="center" >&nbsp;Income 
                          (Monthly)(Rs.)</td>
										
                        <td width="13%" align="center" >
                          Expenses (Monthly)(Rs.)</td>
									</tr>
									<tr >
										<td align="center"><input type="text" name="txt_stockpart"
											value="<%=vecCol0.get(2)%>" size="15" maxlength="30"
											style="text-align:left"></td>
										<td align="center"><input type="text"
											name="txt_noofanimal" value="<%=vecCol0.get(3)%>" size="10"
											maxlength="6" onKeyPress="allowInteger()"
											onBlur="costestimation(this, document.forms[0].txt_costanimal[0].value,document.forms[0].txt_workcap[0].value,document.forms[0].txt_estimcost[0])"
											style="text-align:right"> </td>
										<td align="center"><input type="text" name="txt_costanimal"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol0.get(4))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this)"
											onBlur="costestimation(this, document.forms[0].txt_noofanimal[0].value,document.forms[0].txt_workcap[0].value,document.forms[0].txt_estimcost[0]);roundtxt(this);"
											style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_workcap"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol0.get(5))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this)"
											onBlur="costestimation1(this, document.forms[0].txt_noofanimal[0].value,document.forms[0].txt_costanimal[0].value,document.forms[0].txt_estimcost[0]);roundtxt(this);"
											style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_estimcost"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol0.get(9))))%>" size="10" maxlength="6" 
onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this)" style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_margin" 
onBlur = "roundtxt(this);"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol0.get(10))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this)" style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_gross"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol0.get(11))))%>" size="10" maxlength="6" 
onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this)" style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_totexp"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol0.get(12))))%>" size="10" maxlength="6" 
onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this)" style="text-align:right"></td>
									</tr>
									<tr >
										

                              <td align="center"><input type="text" name="txt_stockpart"
											value="<%=vecCol1.get(2)%>" size="15" maxlength="30"
											style="text-align:left"></td>
										<td align="center"> <input type="text"
											name="txt_noofanimal" value="<%=vecCol1.get(3)%>" size="10"
											maxlength="6" onKeyPress="allowInteger()"
											onBlur="costestimation(this, document.forms[0].txt_costanimal[1].value,document.forms[0].txt_workcap[1].value,document.forms[0].txt_estimcost[1])"
											style="text-align:right"> </td>
										<td align="center"><input type="text" name="txt_costanimal"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol1.get(4))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this)"
											onBlur="costestimation(this, document.forms[0].txt_noofanimal[1].value,document.forms[0].txt_workcap[1].value,document.forms[0].txt_estimcost[1]);roundtxt(this);"
											style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_workcap"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol1.get(5))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this)"
											onBlur="costestimation1(this, document.forms[0].txt_noofanimal[1].value,document.forms[0].txt_costanimal[1].value,document.forms[0].txt_estimcost[1]);roundtxt(this);"
											style="text-align:right"></td>
										
                        <td align="center">
                          <input type="text" name="txt_estimcost" 
onBlur = "roundtxt(this);"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol1.get(9))))%>" size="10" maxlength="6" 
											onKeyPress="allowNumber(this)" style="text-align:right">
                        </td>
										<td align="center"><input type="text" name="txt_margin" 
onBlur = "roundtxt(this);"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol1.get(10))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this)" style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_gross"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol1.get(11))))%>" size="10" maxlength="6" 
onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this)" style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_totexp"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol1.get(12))))%>" size="10" maxlength="6" 
onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this)" style="text-align:right"></td>
									</tr>
									<tr >
										<td align="center"><input type="text" name="txt_stockpart"
											value="<%=vecCol2.get(2)%>" size="15" maxlength="30"
											style="text-align:left"></td>
										<td align="center"> <input type="text"
											name="txt_noofanimal" value="<%=vecCol2.get(3)%>" size="10"
											maxlength="6" onKeyPress="allowInteger()"
											onBlur="costestimation(this, document.forms[0].txt_costanimal[2].value,document.forms[0].txt_workcap[2].value,document.forms[0].txt_estimcost[2])"
											style="text-align:right"> </td>
										<td align="center"><input type="text" name="txt_costanimal"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol2.get(4))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this)"
											onBlur="costestimation(this, document.forms[0].txt_noofanimal[2].value,document.forms[0].txt_workcap[2].value,document.forms[0].txt_estimcost[2]);roundtxt(this);"
											style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_workcap"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol2.get(5))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this)"
											onBlur="costestimation1(this, document.forms[0].txt_noofanimal[2].value,document.forms[0].txt_costanimal[2].value,document.forms[0].txt_estimcost[2]);roundtxt(this);"
											style="text-align:right"></td>
										
                        <td align="center">
                          <input type="text" name="txt_estimcost" 
onBlur = "roundtxt(this);"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol2.get(9))))%>" size="10" maxlength="6" 
											onKeyPress="allowNumber(this)" style="text-align:right">
                        </td>
										<td align="center"><input type="text" name="txt_margin"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol2.get(10))))%>" size="10" maxlength="6" 
onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this)" style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_gross"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol2.get(11))))%>" size="10" maxlength="6" 
onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this)" style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_totexp"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol2.get(12))))%>" size="10" maxlength="6" 
onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this)" style="text-align:right"></td>
									</tr>
								</table>

								<table width="100%" border="0" cellspacing="1" cellpadding="3"
									class="outertable">
									<tr class="dataheader">
										<td colspan="8" align="center" ><b>Poultry</b></td>
									</tr>
									<tr class="dataheader">
										<td width="14%"  align="center"> Particulars</td>
										<td width="12%"  align="center">No of Birds</td>
										
                        <td width="12%"  align="center">Cost 
                          per Bird(Rs.)</td>
										
                        <td width="13%"align="center">Working 
                          Capital (Feed + Vet.Care+Ins)(Rs.)</td>
										
                        <td width="12%"  align="center">Estimated 
                          Cost (Rs.) </td>
										
                        <td width="12%" align="center">Margin 
                                                   money (Rs.)</td>
										
                        <td width="12%"  align="center">&nbsp;Income 
                          (Monthly)(Rs.)</td>
										
                        <td width="13%" align="center">
                          Expenses (Monthly)(Rs.)</td>
									</tr>
									<tr >
										<td align="center"><input type="text" name="txt_pstockpart"
											value="<%=vecCol3.get(2)%>" size="15" maxlength="30"
											style="text-align:left"></td>
										<td align="center"> <input type="text"
											name="txt_pnoofanimal" value="<%=vecCol3.get(3)%>" size="10"
											maxlength="6" onKeyPress="allowInteger();"
											onBlur="costestimation(this, document.forms[0].txt_pcostanimal[0].value,document.forms[0].txt_pworkcap[0].value,document.forms[0].txt_pestimcost[0]);totpestimatemeth()"
											style="text-align:right"> </td>
										<td align="center"><input type="text" name="txt_pcostanimal"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol3.get(4))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);"
											onBlur="costestimation(this, document.forms[0].txt_pnoofanimal[0].value,document.forms[0].txt_pworkcap[0].value,document.forms[0].txt_pestimcost[0]);totpestimatemeth();roundtxt(this);"
											style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_pworkcap"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol3.get(5))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);"
											onBlur="costestimation1(this, document.forms[0].txt_pnoofanimal[0].value,document.forms[0].txt_pcostanimal[0].value,document.forms[0].txt_pestimcost[0]);totpestimatemeth();roundtxt(this);"
											style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_pestimcost"

											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol3.get(9))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_pmargin"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol3.get(10))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" onBlur="totpmargin();roundtxt(this);"
											style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_pgross"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol3.get(11))))%>" size="10" maxlength="6" 
onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_ptotexp"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol3.get(12))))%>" size="10" maxlength="6" onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
									</tr>
									<tr >
										<td align="center"><input type="text" name="txt_pstockpart"
											value="<%=vecCol4.get(2)%>" size="15" maxlength="30"
											style="text-align:left"></td>
										<td align="center"> <input type="text"
											name="txt_pnoofanimal" value="<%=vecCol4.get(3)%>" size="10"
											maxlength="6" onKeyPress="allowInteger();"
											onBlur="costestimation(this, document.forms[0].txt_pcostanimal[1].value,document.forms[0].txt_pworkcap[1].value,document.forms[0].txt_pestimcost[1]);totpestimatemeth()"
											style="text-align:right"> </td>
										<td align="center"><input type="text" name="txt_pcostanimal"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol4.get(4))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);"
											onBlur="costestimation(this, document.forms[0].txt_pnoofanimal[1].value,document.forms[0].txt_pworkcap[1].value,document.forms[0].txt_pestimcost[1]);totpestimatemeth();roundtxt(this);"
											style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_pworkcap"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol4.get(5))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);"
											onBlur="costestimation1(this, document.forms[0].txt_pnoofanimal[1].value,document.forms[0].txt_pcostanimal[1].value,document.forms[0].txt_pestimcost[1]);totpestimatemeth();roundtxt(this);"
											style="text-align:right"></td>
										
                        <td align="center">
                          <input type="text" name="txt_pestimcost"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol4.get(9))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" style="text-align:right">
                        </td>
										<td align="center"><input type="text" name="txt_pmargin"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol4.get(10))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" onBlur="totpmargin();roundtxt(this);"
											style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_pgross"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol4.get(11))))%>" size="10" maxlength="6" onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_ptotexp"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol4.get(12))))%>" size="10" maxlength="6" onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
									</tr>
									<tr >
										<td align="center"><input type="text" name="txt_pstockpart"
											value="<%=vecCol5.get(2)%>" size="15" maxlength="30"
											style="text-align:left"></td>
										<td align="center"> <input type="text"
											name="txt_pnoofanimal" value="<%=vecCol5.get(3)%>" size="10"
											maxlength="6" onKeyPress="allowInteger();"
											onBlur="costestimation(this, document.forms[0].txt_pcostanimal[2].value,document.forms[0].txt_pworkcap[2].value,document.forms[0].txt_pestimcost[2]);totpestimatemeth()"
											style="text-align:right"> </td>
                              <td align="center"><input type="text" name="txt_pcostanimal"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol5.get(4))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);"
											onBlur="costestimation(this, document.forms[0].txt_pnoofanimal[2].value,document.forms[0].txt_pworkcap[2].value,document.forms[0].txt_pestimcost[2]);totpestimatemeth();roundtxt(this);"
											style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_pworkcap"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol5.get(5))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);"
											onBlur="costestimation1(this, document.forms[0].txt_pnoofanimal[2].value,document.forms[0].txt_pcostanimal[2].value,document.forms[0].txt_pestimcost[2]);totpestimatemeth();roundtxt(this);"
											style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_pestimcost"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol5.get(9))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_pmargin"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol5.get(10))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" onBlur="totpmargin();roundtxt(this);"
											style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_pgross"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol5.get(11))))%>" size="10" maxlength="6" onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_ptotexp"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol5.get(12))))%>" size="10" maxlength="6" onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
									</tr>
									<tr >
										<td height="31" align="center"><input type="text"
											name="txt_pstockpart" value="<%=vecCol6.get(2)%>" size="15"
											maxlength="30" style="text-align:left"></td>
										<td align="center"> <input type="text"
											name="txt_pnoofanimal" value="<%=vecCol6.get(3)%>" size="10"
											maxlength="6" onKeyPress="allowInteger();"
											onBlur="costestimation(this, document.forms[0].txt_pcostanimal[3].value,document.forms[0].txt_pworkcap[3].value,document.forms[0].txt_pestimcost[3]);totpestimatemeth()"
											style="text-align:right"> </td>
										<td align="center"><input type="text" name="txt_pcostanimal"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol6.get(4))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);"
											onBlur="costestimation(this, document.forms[0].txt_pnoofanimal[3].value,document.forms[0].txt_pworkcap[3].value,document.forms[0].txt_pestimcost[3]);totpestimatemeth();roundtxt(this);"
											style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_pworkcap"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol6.get(5))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);"
											onBlur="costestimation1(this, document.forms[0].txt_pnoofanimal[3].value,document.forms[0].txt_pcostanimal[3].value,document.forms[0].txt_pestimcost[3]);totpestimatemeth();roundtxt(this);"
											style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_pestimcost"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol6.get(9))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_pmargin"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol6.get(10))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" onBlur="totpmargin();roundtxt(this);"
											style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_pgross"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol6.get(11))))%>" size="10" maxlength="6" 
onBlur = "roundtxt(this);" onKeyPress="allowNumber(this);" style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_ptotexp"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol6.get(12))))%>" size="10" maxlength="6" onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
									</tr>
									<tr >
										<td align="center"><input type="text" name="txt_pstockpart"
											value="<%=vecCol7.get(2)%>" size="15" maxlength="30"
											style="text-align:left"></td>
										<td align="center"><input type="text"
											name="txt_pnoofanimal" value="<%=vecCol7.get(3)%>" size="10"
											maxlength="6" onKeyPress="allowInteger();"
											onBlur="costestimation(this, document.forms[0].txt_pcostanimal[4].value,document.forms[0].txt_pworkcap[4].value,document.forms[0].txt_pestimcost[4]);totpestimatemeth()"
											style="text-align:right"> </td>
										<td align="center"><input type="text" name="txt_pcostanimal"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol7.get(4))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);"
											onBlur="costestimation(this, document.forms[0].txt_pnoofanimal[4].value,document.forms[0].txt_pworkcap[4].value,document.forms[0].txt_pestimcost[4]);totpestimatemeth();roundtxt(this);"
											style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_pworkcap"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol7.get(5))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);"
											onBlur="costestimation1(this, document.forms[0].txt_pnoofanimal[4].value,document.forms[0].txt_pcostanimal[4].value,document.forms[0].txt_pestimcost[4]);totpestimatemeth();roundtxt(this);"
											style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_pestimcost"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol7.get(9))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_pmargin"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol7.get(10))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" onBlur="totpmargin();roundtxt(this);"
											style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_pgross"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol7.get(11))))%>" size="10" maxlength="6" 
onBlur = "roundtxt(this);" onKeyPress="allowNumber(this);" style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_ptotexp"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol7.get(12))))%>" size="10" maxlength="6" onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
									</tr>
									<tr >
										<td align="center">&nbsp;</td>
										<td align="center">&nbsp;</td>
										<td align="center">&nbsp;</td>
										<td align="center">&nbsp;</td>
										<td align="center"><input type="text"
											name="txt_ptotalestimate" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol4.get(14))))%>"
											size="10" maxlength="6" onKeyPress="allowNumber(this);"
											style="text-align:right" readonly="readonly"></td>
										<td align="center"><input type="text" name="txt_ptotalmargin"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol4.get(15))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" style="text-align:right"
											readonly="readonly"></td>
										<td align="center">&nbsp;</td>
										<td align="center">&nbsp;</td>
									</tr>
								</table>
								<table width="100%" border="0" cellspacing="1" cellpadding="3"
									class="outertable">
									<tr class="dataheader">
										<td colspan="6" align="center" ><b>Farm
										Machinery (Power Tiller/Pump Set/Sprinkler/Etc.)</b></td>
									</tr>
									<tr class="dataheader">
										<td width="17%" align="center"> Particulars</td>
										<td width="16%"  align="center">Area Benefited
										(Own + Other lands)</td>
										
                        <td width="16%"  align="center">Estimated 
                          Cost (Rs.) </td>
										
                        <td width="16%"  align="center" nowrap="nowrap">Margin 
                                                   money (Rs.)</td>
										
                        <td width="16%"  align="center">Gross 
                          Income (Monthly)(Rs.)</td>
										
                        <td width="16%"  align="center">Total 
                          Expenditure (Monthly)(Rs.)</td>
									</tr>
									<tr >
										<td align="center"><input type="text" name="txt_fstockpart"
											value="<%=vecCol8.get(2)%>" size="15" maxlength="30"
											style="text-align:left"></td>
										<td align="center"><input type="text"
											name="txt_farea" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol8.get(6))))%>" size="10"
											maxlength="6" onKeyPress="allowNumber(this);" onBlur = "roundtxt(this);"
											style="text-align:right"> </td>
										<td align="center"><input type="text" name="txt_fesmcost"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol8.get(9))))%>" size="10" maxlength="6" onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_fmargin"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol8.get(10))))%>" size="10" maxlength="6" onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_fgrossinc"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol8.get(11))))%>" size="10" maxlength="6" onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_ftotexpend"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol8.get(12))))%>" size="10" maxlength="6" onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
									</tr>
									<tr >
										<td align="center"><input type="text" name="txt_fstockpart"
											value="<%=vecCol9.get(2)%>" size="15" maxlength="30"
											style="text-align:left"></td>
										<td align="center"> <input type="text"
											name="txt_farea" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol9.get(6))))%>" size="10"
											maxlength="6" onKeyPress="allowNumber(this);" onBlur = "roundtxt(this);"
											style="text-align:right"> </td>
										<td align="center"><input type="text" name="txt_fesmcost"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol9.get(9))))%>" size="10" maxlength="6" onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_fmargin"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol9.get(10))))%>" size="10" maxlength="6" onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_fgrossinc"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol9.get(11))))%>" size="10" maxlength="6" onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
                              <td align="center"><input type="text" name="txt_ftotexpend"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol9.get(12))))%>" size="10" maxlength="6" onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
									</tr>
									<tr >
										<td align="center"><input type="text" name="txt_fstockpart"
											value="<%=vecCol10.get(2)%>" size="15" maxlength="30"
											style="text-align:left"></td>
										<td align="center"> <input type="text"
											name="txt_farea" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol10.get(6))))%>" size="10"
											maxlength="6" onKeyPress="allowNumber(this);" onBlur = "roundtxt(this);"
											style="text-align:right"> </td>
										<td align="center"><input type="text" name="txt_fesmcost"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol10.get(9))))%>" size="10" maxlength="6" onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_fmargin"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol10.get(10))))%>" size="10" maxlength="6" onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_fgrossinc"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol10.get(11))))%>" size="10" maxlength="6" onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_ftotexpend"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol10.get(12))))%>" size="10" maxlength="6" onBlur = "roundtxt(this);"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
									</tr>
								</table>
								
                    <table width="100%" border="0" cellspacing="1" cellpadding="3"
									class="outertable">
                      <tr class="dataheader"> 
                        <td colspan="7" align="center" ><b>Farm 
                          House/Shed/Godown/Barn/Well digging/Deepening/Fencing/Binding/Land 
                          Development / Etc</b></td>
                      </tr>
                      <tr class="dataheader"> 
                        <td width="15%"  align="center">
                          Particulars</td>
                        <td width="15%"  align="center">Total 
                          Dimension (L X B) </td>
                        <td width="17%"  align="center" nowrap="nowrap">Total 
                          Volume (L X B X H)</td>
                        <td width="13%"  align="center">Estimated 
                          Cost (Rs.)</td>
                        <td width="16%"  align="center">Margin 
                                                   money(Rs.)</td>
                        <td width="12%"  align="center">Gross 
                          Income (Monthly)(Rs.)</td>
                        <td width="12%"  align="center">Total 
                          Expenditure (Monthly)(Rs.)</td>
                      </tr>
                      <tr > 
                        <td align="center"><input type="text" name="txt_ostockpart"
											value="<%=vecCol11.get(2)%>" size="15" maxlength="30"
											style="text-align:left"></td>
                        <td align="center">
                          <input type="text" onBlur = "roundtxt(this);"
											name="txt_odimension" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol11.get(7))))%>" size="10"
											maxlength="6" onKeyPress="allowNumber(this);"
											style="text-align:right">
                          </td>
                        <td align="center"><input type="text" name="txt_ovolume" onBlur = "roundtxt(this);"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol11.get(8))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
                        <td align="center"><input type="text" name="txt_oestimate" onBlur = "roundtxt(this);"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol11.get(9))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
                        <td align="center"><input type="text" name="txt_omargin" onBlur = "roundtxt(this);"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol11.get(10))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
                        <td align="center"><input type="text" name="txt_ogrossinc" onBlur = "roundtxt(this);"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol11.get(11))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
                        <td align="center"><input type="text" name="txt_ototexp" onBlur = "roundtxt(this);"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol11.get(12))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
                      </tr>
                      <tr > 
                        <td align="center"><input type="text" name="txt_ostockpart"
											value="<%=vecCol12.get(2)%>" size="15" maxlength="30"
											style="text-align:left"></td>
                        <td align="center">
                          <input type="text" onBlur = "roundtxt(this);"
											name="txt_odimension" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol12.get(7))))%>" size="10"
											maxlength="6" onKeyPress="allowNumber(this);"
											style="text-align:right">
                          </td>
                        <td align="center"><input type="text" name="txt_ovolume" onBlur = "roundtxt(this);"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol12.get(8))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
                        <td align="center">
                          <input type="text" name="txt_oestimate" onBlur = "roundtxt(this);"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol12.get(9))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" style="text-align:right">
                        </td>
                        <td align="center"><input type="text" name="txt_omargin" onBlur = "roundtxt(this);"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol12.get(10))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
                        <td align="center"><input type="text" name="txt_ogrossinc" onBlur = "roundtxt(this);"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol12.get(11))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
                        <td align="center"><input type="text" name="txt_ototexp" onBlur = "roundtxt(this);"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol12.get(12))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
                      </tr>
                      <tr > 
                        <td align="center"><input type="text"
											name="txt_ostockpart" value="<%=vecCol13.get(2)%>" size="15"
											maxlength="30" style="text-align:left"></td>
                        <td align="center">
                          <input type="text" onBlur = "roundtxt(this);"
											name="txt_odimension" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol13.get(7))))%>" size="10"
											maxlength="6" onKeyPress="allowNumber(this);"
											style="text-align:right">
                          </td>
                        <td align="center"><input type="text" name="txt_ovolume" onBlur = "roundtxt(this);"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol13.get(8))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
                        <td align="center"><input type="text" name="txt_oestimate" onBlur = "roundtxt(this);"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol13.get(9))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
                        <td align="center"><input type="text" name="txt_omargin" onBlur = "roundtxt(this);"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol13.get(10))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
                        <td align="center"><input type="text" name="txt_ogrossinc" onBlur = "roundtxt(this);"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol13.get(11))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
                        <td align="center"><input type="text" name="txt_ototexp" onBlur = "roundtxt(this);"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol13.get(12))))%>" size="10" maxlength="6"
											onKeyPress="allowNumber(this);" style="text-align:right"></td>
                      </tr>
                      <tr > 
                      <br>
                        <td align="left" colspan="4" > <font color="red" size="4 px">NOTE : Give the unit along 
                          with particulars F-Feet M-Metre</font></td>
                       
                       
                        <td align="center">&nbsp;</td>
                        <td align="center">&nbsp;</td>
                        <td align="center">&nbsp;</td>
                      </tr>
                 
                    </table>
								<br></td>
							</tr>
							
					 <lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
 
		</table>
		</td>
	</tr>
</table>
</td>
</tr>
</table>

<input type="hidden" name="hidcroptype"> 
<input type="hidden" name="payment" value="<%=vecCol13.get(18)%>">
<input type="hidden" name="hidRecordflag" > 
<lapschoice:agrihiddentag pageid="<%=PageId%>"/>
</form>
</body>
</html>

