<%@include file="../share/directives.jsp"%>

<%
	
	String schemetype="";
	schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
	String strschemetype="",strfacsno="",stragrschemetype="";
	HashMap hshScheme = new HashMap();
	hshScheme = Helper.splitScheme(schemetype);
	if(hshScheme!=null)
	{
		strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
		if(strfacsno.equalsIgnoreCase(""))
			strfacsno = Helper.correctNull((String)hshValues.get("facsno"));
		stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
		if(stragrschemetype.equalsIgnoreCase(""))
			stragrschemetype = Helper.correctNull((String)hshValues.get("schemetype"));
	}
	
	java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMinimumFractionDigits(2);
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	
	if(hshValues!=null)
	{
		arrRow = (ArrayList)hshValues.get("arrRow");
	}
%>
<html>
<head>
<title>CAPL Goods Details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var varschemetype="<%=schemetype%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
</script>

<script>
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appUrl,name);
	}
}

function onloading()
{	
	disableFields(true);
	document.forms[0].sel_scheme.disabled=false;
	document.forms[0].sel_scheme.value=varschemetype;

	if(appstatus=="Open/Pending")
	{
		
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
	     enableButtons(false, true, true, true, true,true,false);
		}
		else
		{
			enableButtons(true, true, true, true, true,true,false);
		}
	}
		else
		{
			enableButtons(true, true, true, true, true,true,false);
		}
		
}

function enableButtons(bool1, bool2, bool3, bool4, bool5, bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}

function doSave()
{   
   if(document.forms[0].txt_namewarehouse.value!="")
   {
        if(document.forms[0].txt_warehousedoc.value=="")
 		{
	  		alert("Enter warehouse Receipts No");
	  		document.forms[0].txt_warehousedoc.focus();
	  		return;
 		}
 		if(document.forms[0].txt_marketrate.value=="" || document.forms[0].txt_marketrate.value=="0.00")
 		{
	  		alert("Enter Market rate per unit");
	  		document.forms[0].txt_marketrate.focus();
	  		return;
 		}
 		if(document.forms[0].txt_invoiceval.value=="")
 		{
	  		alert("Enter Value as per warehouse receipt");
	  		document.forms[0].txt_invoiceval.focus();
	  		return;
 		}
 		if(document.forms[0].txt_invoicedate.value=="")
 		{
	  		alert("Enter Date of Receipt");
	  		document.forms[0].txt_invoicedate.focus();
	  		return;
 		}
     }
   	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="agriculture";		
	document.forms[0].hidSourceUrl.value="/action/agr_capl_goodsdetails.jsp";
	document.forms[0].hidBeanMethod.value="updatecaplGoodsdata";
	document.forms[0].hidBeanGetMethod.value="getcaplGoodsdata";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doEdit()
{
 	disableFields(false);
 	document.forms[0].hidAction.value ="update";
 	enableButtons(true, true, false, false, false,false,true);
 	document.forms[0].txt_loanAmount.readOnly=true;
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agriculture";
		document.forms[0].hidBeanGetMethod.value="getcaplGoodsdata";
		document.forms[0].action=appUrl +"action/agr_capl_goodsdetails.jsp";
		document.forms[0].submit(); 		
	}	
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

function disableFields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
			if(document.forms[0].elements[i].type=='text') 
			{
				document.forms[0].elements[i].readOnly=one;
				
				if(document.forms[0].elements[i].name=='txt_invoicedate1')
				{
					document.forms[0].elements[i].readOnly=true;
				}
				if(document.forms[0].elements[i].name=='txt_marketval1')
				{
					document.forms[0].elements[i].readOnly=true;
				}
			
			}
			if(document.forms[0].elements[i].type=='select-one')
	 		{
			document.forms[0].elements[i].disabled=one;
	 		}
		 	if(document.forms[0].elements[i].type=='checkbox')
		 	{
				document.forms[0].elements[i].disabled=one;
		 	}
		    if(document.forms[0].elements[i].type=='textarea')
		 	{
				document.forms[0].elements[i].readOnly=one;
			}
	}

	document.forms[0].txt_marketval.readOnly=true;
	document.forms[0].txt_loanAmount.readOnly=true;
}


function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updatecaplGoodsdata";
		document.forms[0].hidBeanGetMethod.value="getcaplGoodsdata";
		document.forms[0].hidBeanId.value="agriculture";
		document.forms[0].hidSourceUrl.value="action/agr_capl_goodsdetails.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}
	

function doNew()
{
	document.forms[0].hidAction.value="insert";
	clearFields();
	disabledFields(false);
	enableButtons(true, true, false, false, true,false,false);
	
}
function clearFields()
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].value="";
		}	
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].value="";
		}	   
	}
}

function doCal()
{
	var unit=0.00,cost=0.00;
	var unit=document.forms[0].txt_units.value;
	var cost=document.forms[0].txt_marketrate.value;
	var total=0;
  	if(unit=="")
  	{
   		unit="1";
   	}
  	if(cost=="")
  	{
      	cost="0";
	}
   	total=eval(cost)*eval(unit);
   	document.forms[0].txt_marketval.value=total;
	roundtxt(document.forms[0].txt_marketval); 
}
function selectvalues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13)
{
	document.forms[0].hidsno.value=val1;
	document.forms[0].txt_namewarehouse.value=val2;
	document.forms[0].txt_warehousedoc.value=val3;
	document.forms[0].txt_units.value=val4;
	document.forms[0].txt_weight.value=val5;
	document.forms[0].sel_units.value=val6;
	document.forms[0].txt_marketrate.value=val7;
	document.forms[0].txt_marketval.value=val8;
	document.forms[0].txt_invoiceval.value=val9;
	document.forms[0].txt_invoicedate.value=val10;
	document.forms[0].txt_loanAmount.value=roundVal(val12);	
	document.forms[0].txt_margin.value=roundVal(val13);	
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
	enableButtons(true, false, true, false, false,false,false);
	}
	
}
function doCalculation()
{
	var varToatlAmt=document.forms[0].txt_marketval.value;
	var varWarhouse=document.forms[0].txt_invoiceval.value;
	var varMargin=document.forms[0].txt_margin.value;
	var minAmt = roundVal(Math.min(varToatlAmt,varWarhouse));
	document.forms[0].txt_loanAmount.value = minAmt - (minAmt*(varMargin/100));
}
</script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading();">
<form name="frmpri" class="normal" method="post">
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
      <td class="page_flow">Home -> Agriculture -> Goods Details</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="212" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>
<br>
<table class="outertable border1" align="center" width="98%" border="0" cellpadding="3" cellspacing="0">
	<tr>
		<td>
		<table class="outertable" align="center" width="100%" border="0" cellspacing="1" cellpadding="3">
			<tr class="dataheader">
				<td width="10%" align="center"> Name &amp; Description of the goods to be pledged</td>
				<td width="14%" align="center"> Document of title to goods &amp; or warehouse Receipts<b><span class="mantatory">*</span></b></td>
				<td width="9%" align="center"> No. of units to be Pledged</td>
				<td width="15%" align="center"> Weight / Measurement units</td>
				<td width="9%" align="center"> Market rate per unit<b><span class="mantatory">*</span></b></td>
				<td width="9%" align="center"> Total Market Value</td>
				<!-- <td width="9%" align="center" style="visibility:hidden;position:absolute"> Loan Amount requested</td> -->
		      	<td width="9%" align="center"> Value as per warehouse receipt<b><span class="mantatory">*</span></b></td>
		      	<td width="9%" align="center"> Margin (%)</td>
		      	<td width="9%" align="center"> Bank Loan</td>
				<td width="18%" align="center"> Date of Receipt<b><span class="mantatory">*</span></b></td>
			</tr>
			<tr class="datagrid">
				
				<td align="center"><input type="text" name="txt_namewarehouse"
					value="" size="13%" onKeyPress="notAllowSplChar()"
					maxlength=50"></td>
				<td align="center"><input type="text" name="txt_warehousedoc"
					value="" size="25" onKeyPress="notAllowSplChar()"
					maxlength="50" onBlur=""></td>
				<td align="center"><input type="text" name="txt_units"
					value="" size="10" onKeyPress="allowNumber(this)" onBlur="doCal();doCalculation();"
					maxlength="8"></td>
				<td align="center"><input type="text" name="txt_weight"
					value="" size="10%" onKeyPress="allowNumber(this)"
					maxlength="8">&nbsp;<select name="sel_units" >
		                    			 <option value="">--Select--</option>
		                    			 <lapschoice:StaticDataNewTag apptype="136"/></select></td>
				<td align="center"><lapschoice:CurrencyTag name="txt_marketrate"
					value='' size="13%" maxlength="8"
					onBlur="doCal();doCalculation()" /></td>
				<td align="center"><lapschoice:CurrencyTag name="txt_marketval"
					value='' size="13%" maxlength="8"
					onBlur="doCal();doCalculation();" /></td>
				<td align="center"><lapschoice:CurrencyTag name="txt_invoiceval"
					value="" size="13%" onKeyPress="allowNumber(this)"
					maxlength="8" onBlur="doCalculation();" /></td>
				<td align="center"><input type="text" name="txt_margin"
					value="" size="13%" onKeyPress="allowNumber(this)"
					maxlength="6" onBlur="roundtxt(this);checkPercentage(this);doCalculation();"/></td>
				<td align="center"><lapschoice:CurrencyTag name="txt_loanAmount"
					value="" size="13%" onKeyPress="allowNumber(this)"
					maxlength="8" onBlur=""/></td>
				<td align="center" nowrap><input type="text" name="txt_invoicedate"
					value="" size="10%" onKeyPress="" maxlength="10"
					onBlur="checkDate(this);checkmaxdate(this,currdate)"> <a href="#"
					onClick="callCalender('txt_invoicedate')"
					title="Click to view calender" border=0><img
					src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
					height="23" border="0"></a></td>
			</tr>
			
		</table>
	</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>

<table width="98%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
	<tr class="dataheader">
		<td width="5%" align="center">&nbsp;</td>
		<td width="10%" align="center"> Name &amp; Description of the goods to be pledged</td>
		<td width="14%" align="center"> Document of title to goods &amp; or warehouse Receipts</td>
		<td width="9%" align="center"> No. of units to be Pledged</td>
		<td width="15%" align="center"> Weight / Measurement units </td>
		<td width="9%" align="center"> Market rate per unit</td>
		<td width="9%" align="center"> Total Market Value</td>
		<td width="9%" align="center"> Value as per warehouse receipt</td>
      	<td width="9%" align="center"> Margin (%)</td>
      	<td width="9%" align="center"> Bank Loan</td>
      	<td width="9%" align="center">  Date of Receipt</td>
		<!-- <td width="18%" align="center"> Date of Receipt</td> -->
	</tr>
	<%
	
	if(arrRow!=null && arrRow.size()>0)
	{
		for(int i=0;i<arrRow.size();i++)
		{
		arrCol = (ArrayList)arrRow.get(i);
		
	%>

	<tr class="datagrid">
		<td width="5%" align="center">
		
		<input type="radio" name="rd_butt" value="" border="0" style="border: none;"
		onclick="selectvalues('<%=Helper.correctNull((String)arrCol.get(0))%>',
		'<%=Helper.correctNull((String)arrCol.get(1))%>',
		'<%=Helper.correctNull((String)arrCol.get(2))%>',
		'<%=Helper.correctNull((String)arrCol.get(3))%>',
		'<%=Helper.correctNull((String)arrCol.get(4))%>',
		'<%=Helper.correctNull((String)arrCol.get(5))%>',
		'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))%>',
		'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7))))%>',
		'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(8))))%>',
		'<%=Helper.correctNull((String)arrCol.get(9))%>',
		'<%=Helper.correctNull((String)arrCol.get(10))%>',
		'<%=Helper.correctNull((String)arrCol.get(11))%>',
		'<%=Helper.correctNull((String)arrCol.get(12))%>')"></td>
		<td  align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(1))%></td>
		<td  align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(2))%></td>
		<td align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(3))%></td>
		<td align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%> &nbsp; &nbsp; &nbsp;<%=Helper.correctNull((String)arrCol.get(10))%></td>
		<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))%></td>
		<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7))))%></td>
		<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(8))))%></td>
		<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(12))))%></td>
		<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(11))))%></td>
		<td align="center">&nbsp;<%=Helper.correctNull((String)arrCol.get(9))%></td>	
	</tr>
	<%} %>
	<tr class="datagrid">
		<td width="14%" align="center" colspan="5">&nbsp;</td>
		<td width="10%" align="center"><b>Total</b></td>
		<td align="right" ><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("totmarketval"))))%></td>
		<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("totwarehouseval"))))%></td>
		<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dbltotalMargin"))))%></td>
		<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dbltotalLoanAmt"))))%></td>
		<td>&nbsp;</td>
	</tr>
	<%} else
		{ %>
		<tr class="datagrid">
		<td width="14%" align="center" colspan="11">No Data Found</td>
		</tr>
		<%} %>
	
	
</table>
<input type="hidden" name="hidAction"> 
<input type="hidden" name="hidBeanId"> 
<INPUT TYPE="hidden" NAME="hidscheme" VALUE="<%=stragrschemetype%>">
<input type="hidden" name="hidsno">
<input type="hidden" name="hidBeanMethod" value=""> 
<input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidSourceUrl"> 
<INPUT TYPE="hidden" NAME="hidPageSource" VALUE=""> 
<INPUT TYPE="hidden" NAME="hidMethod" VALUE="">
<input type="hidden" name="hidappno" value="<%=request.getParameter("appno")%>">
<INPUT TYPE="hidden" NAME="hidOtherMethod" VALUE=""> 
<input type="hidden" name="hidAppType">
</form>
</body>
</html>