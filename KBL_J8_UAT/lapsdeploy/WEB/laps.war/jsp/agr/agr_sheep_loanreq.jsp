<%@include file="../share/directives.jsp"%>
<%ArrayList arryCol = new ArrayList();
			ArrayList arryRow = new ArrayList();
			arryRow = (ArrayList) hshValues.get("arryRow");
			ArrayList arryCol1 = new ArrayList();
			ArrayList arryRow1 = new ArrayList();
			arryRow1 = (ArrayList) hshValues.get("arryRow1");

			if (arryRow == null) {
				arryRow = new ArrayList();
			}
			if (arryRow1 == null) {
				arryRow1 = new ArrayList();
			}
			String l1 = "", l2 = "", l3 = "", l4 = "", l5 = "", l6 = "", l7 = "", l8 = "", l9 = "", l10 = "";
			String l11 = "", l12 = "", l13 = "", l14 = "", l15 = "", l16 = "", l17 = "", l18 = "", l19 = "", l20 = "";
			String m1 = "", m2 = "", m3 = "", m4 = "", m5 = "", m6 = "", m7 = "", m8 = "";
			String r1 = "", r2 = "", r3 = "", r4 = "", r5 = "", r6 = "", r7 = "", r8 = "", r9 = "", r10 = "", r11 = "", r12 = "";
			String r13 = "", r14 = "", r15 = "";
%>
<html>
<head>
<title>LAPS -Assesment Form Details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var id ="";
var apptype="";

var currentDate = "<%=Helper.getCurrentDateTime()%>";
var  strid="<%=Helper.correctNull((String)hshValues.get("strid"))%>";
var  strAction="<%=Helper.correctNull((String)hshValues.get("strAction"))%>";
function costval()
{
	var  txt_markettranscost="<%=Helper.correctNull((String)hshValues.get("txt_markettranscost"))%>";
	if(txt_markettranscost=="0")
	{
		document.forms[0].txt_unit[2].value="0";
	}
	else
	{
		document.forms[0].txt_unit[2].value="<%=Helper.correctNull((String)hshValues.get("txt_totalanimalno"))%>";
	}
	
	
	
	
	var  txt_feedadult="<%=Helper.correctNull((String)hshValues.get("txt_feedadult"))%>";
	if(txt_feedadult=="0")
	{
		document.forms[0].txt_unit[3].value="0";
	}
	else
	{
		document.forms[0].txt_unit[3].value="<%=Helper.correctNull((String)hshValues.get("txt_maleno"))%>";
	}
	
	var  txt_feedadult="<%=Helper.correctNull((String)hshValues.get("txt_feedadult"))%>";
	if(txt_feedadult=="0")
	{
		document.forms[0].txt_unit[4].value="0";
	}
	else
	{
		document.forms[0].txt_unit[4].value="<%=Helper.correctNull((String)hshValues.get("txt_femaleno"))%>";
	}
	
	var  txt_vtaidprice="<%=Helper.correctNull((String)hshValues.get("txt_vtaidprice"))%>";
	if(txt_vtaidprice=="0")
	{
		document.forms[0].txt_unit[5].value="0";
	}
	else
	{
		document.forms[0].txt_unit[5].value="<%=Helper.correctNull((String)hshValues.get("txt_totalanimalno"))%>";
	}
	var  txt_inspremium="<%=Helper.correctNull((String)hshValues.get("txt_inspremium"))%>";
	if(txt_inspremium=="0")
	{
	document.forms[0].txt_unit[6].value="0";
	}
	else
	{
	document.forms[0].txt_unit[6].value="<%=Helper.correctNull((String)hshValues.get("txt_totalanimalno"))%>";
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/retailpge.jsp";	
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


function doEdit()
{
/*
for(var k=0;k<document.forms[0].txt_specify.length;k++)
 	{
 	document.forms[0].txt_specify[k].value = k;
 	}
 	return;
*/
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="insert";
 	disableFields(false);
 	for(var i=0;i<=7;i++)
 	{
		document.forms[0].txt_unit[i].readOnly =true;
   		document.forms[0].txt_cost[i].readOnly =true;
    	document.forms[0].txt_amount[i].readOnly =true;
 	}
	for(var i=8;i<=14;i++)
 	{
		document.forms[0].txt_cost[i].readOnly =true;
 	}
 	for(var k=14;k<=18;k++)
 	{
		document.forms[0].txt_unit[k].readOnly =true;
	    document.forms[0].txt_cost[k].readOnly =true;
	    document.forms[0].txt_amount[k].readOnly =true;
	    document.forms[0].txt_specify[k].readOnly =true;
 	}
 	for(var k=0;k<=22;k++)
 	{
		document.forms[0].txt_amount[k].readOnly =true;
 	}
	document.forms[0]. txt_totalamount.readOnly =true; 
	document.forms[0]. txt_totalloanamount.readOnly =true; 
	enableButtons(true,false,false,false,true);
}

function callhelp()
{
	var varQryString = appURL+"/jsp/perhlp/hlp_edueducational.jsp"
	var title = "ApplicantDemographics";
	var prop = "scrollbars=no,width=600,height=450";	
	prop = prop + ",left=200,top=150";
	window.open(varQryString,title,prop);
}
 
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agrpoultry";
		document.forms[0].hidBeanGetMethod.value="getsheeploanreq";
		document.forms[0].action=appURL+"action/agr_sheep_loanreq.jsp";
		document.forms[0].submit(); 		
	}
	//disableCommandButtons("load");
}

function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updatesheeploanreq";
		document.forms[0].hidBeanGetMethod.value="getsheeploanreq";
		document.forms[0].hidBeanId.value="agrpoultry";
		document.forms[0].hidSourceUrl.value="action/agr_sheep_loanreq.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}

function onloading()
{
	disableFields(true);
}

function enableButtons( bool2, bool3, bool4, bool5, bool6)
{	
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}

function costfeed()
{
	for(var m=3;m<5;m++)
	{
		var value=document.forms[0].txt_value[m].value;		
		var unit=document.forms[0].txt_unit[m].value;
		var cost=document.forms[0].txt_cost[m].value;
		
		if(unit=="")
		{
			unit=0;					
		}
		if(document.forms[0].txt_value[m].value=="")
		{
			value=0;
			document.forms[0].txt_value[m].value="";				
		}
		if(cost=="")
		{
			cost=0;				
		}
		var amount0=eval(cost)*eval(value)*eval(unit);
		document.forms[0].txt_amount[m].value=Math.round(eval(amount0));
		document.forms[0].txt_value1.value=document.forms[0].txt_value[m].value;		
		
		roundtxt(document.forms[0].txt_amount[m]);
		roundtxt(document.forms[0].txt_cost[m]);
		roundtxt(document.forms[0].txt_value1);
	}

	for(var m=5;m<6;m++)
	{
		var value=document.forms[0].txt_value[m].value;		
		var unit=document.forms[0].txt_unit[m].value;
		var cost=document.forms[0].txt_cost[m].value;
		
		if(unit=="")
		{
			unit=0;
					
		}
		if(document.forms[0].txt_value[m].value=="")
		{
			value=0;
			document.forms[0].txt_value[m].value="";	
		}
		if(cost=="")
		{
			cost=0;
				
		}
		var amount1=eval(cost)*eval(value)*eval(unit);
		document.forms[0].txt_amount[m].value=Math.round(eval(amount1));
		document.forms[0].txt_value2.value=document.forms[0].txt_value[m].value;		
		
		roundtxt(document.forms[0].txt_amount[m]);
		roundtxt(document.forms[0].txt_cost[m]);
		roundtxt(document.forms[0].txt_value2);
	}

	for(var m=7;m<8;m++)
	{
		var value=document.forms[0].txt_value[m].value;
		var unit=document.forms[0].txt_unit[m].value;
		var cost=document.forms[0].txt_cost[m].value;
	
	 	if(unit=="")
		{
			unit=0;			
		}
		if(document.forms[0].txt_value[m].value=="")
		{
			value=0;
			document.forms[0].txt_value[m].value="";	
		}
		if(cost=="")
		{
			cost=0;		
		}
	 	var amount2=eval(cost)*eval(value)*eval(unit);
		document.forms[0].txt_amount[m].value=Math.round(eval(amount2));
		document.forms[0].txt_value3.value=document.forms[0].txt_value[m].value;
		
		roundtxt(document.forms[0].txt_amount[m]);
		roundtxt(document.forms[0].txt_cost[m]);
		roundtxt(document.forms[0].txt_value3);
	}
}

function amount()
{
	for(var m=8;m<=13;m++)
	{
		var sqft=document.forms[0].txt_sq[m].value;
		var value=document.forms[0].txt_value[m].value;
		var unit=document.forms[0].txt_unit[m].value;
	 	if(sqft=="")
		{
			sqft=0;			
		}
		if(value=="")
		{
			value=1;		
		}
		if(unit=="")
		{
			unit=1;		
		}
		var amount=eval(sqft)*eval(value)*eval(unit);
		var amount1 = eval(sqft)*eval(value);
		document.forms[0].txt_amount[m].value=Math.round(eval(amount));
		document.forms[0].txt_cost[m].value=Math.round(eval(amount1));
		//document.forms[0].txt_cost[m].value="0";			
		
		roundtxt(document.forms[0].txt_amount[m]);
		roundtxt(document.forms[0].txt_cost[m]);
	}
}

function calunits(i)
{
	var varsqft=document.forms[0].txt_sq[i].value;
	var varcostpersqft=document.forms[0].txt_value[i].value;
	var varcostperunit;
	if(varsqft=="")
		varsqft=0;
	if(varcostpersqft=="")
		varcostpersqft=0;
	
	varcostperunit=eval(varsqft)*eval(varcostpersqft);
	document.forms[0].txt_cost[i].value=varcostperunit;
	roundtxt(document.forms[0].txt_cost[i]);
}

function callamount()
{
	for(var m=0;m<=2;m++)
	{
		var unit=document.forms[0].txt_unit[m].value;
		var cost=document.forms[0].txt_cost[m].value;
		if(unit=="")
		{
			unit=1;					
		}
		if(cost=="")
		{
			cost=0;			
		}
			
		var amount=eval(cost)*eval(unit);
		document.forms[0].txt_amount[m].value=Math.round(eval(amount));
		
		roundtxt(document.forms[0].txt_cost[m]);
		roundtxt(document.forms[0].txt_amount[m]);
	
	}

	for(var m=6;m<7;m++)
	{
		var unit=document.forms[0].txt_unit[m].value;
		var cost=document.forms[0].txt_cost[m].value;
	 	if(unit=="")
		{
			unit=1;				
		}
		if(cost=="")
		{
			cost=0;			
		}
		
		var amount=eval(cost)*eval(unit);
		document.forms[0].txt_amount[m].value=Math.round(eval(amount));
		
		roundtxt(document.forms[0].txt_cost[m]);
		roundtxt(document.forms[0].txt_amount[m]);
	
	}

	for(var m=14;m<=22;m++)
	{
		 var unit=document.forms[0].txt_unit[m].value;
		 var cost=document.forms[0].txt_cost[m].value;
		 if(unit=="")
		 {
			unit=1;				
		 }
		 if(cost=="")
		 {
			cost=0;		
		 }
			
		var amount=eval(cost)*eval(unit);
		document.forms[0].txt_amount[m].value=Math.round(eval(amount));
		
		roundtxt(document.forms[0].txt_cost[m]);
		roundtxt(document.forms[0].txt_amount[m]);
	}

}

function callTotal()
{
	var totalvalue1=0.00;
	for(var m=0;m<=22;m++)
	 {
		var loan=document.forms[0].txt_amount[m].value;
		roundtxt(document.forms[0].txt_amount[m]);	      
		if(loan=="")
		{
			loan =0.00;			
		}
	    totalvalue1 = eval(loan)+eval(totalvalue1);	
	  }
	     
	   document.forms[0].txt_totalamount.value= eval(totalvalue1);
	   
	   roundtxt(document.forms[0].txt_totalamount);
}

function marginper()
{
	var totalamount=document.forms[0].txt_totalamount.value;
	var marginper=document.forms[0].txt_marginper.value;
	if(eval(marginper)=="")
	{
		marginper="0";
		document.forms[0].txt_marginper.value="0";
	}
	var margin=eval(marginper)/100*eval(totalamount);
	document.forms[0].txt_margin.value=Math.round(eval(margin));
	
	roundtxt(document.forms[0].txt_totalamount);
	roundtxt(document.forms[0].txt_marginper);
}

function subsidyper()
{
	var totalamount=document.forms[0].txt_totalamount.value;
	var subsidyper=document.forms[0].txt_subsidyper.value;
	if(eval(subsidyper)=="")
	{
		subsidyper="0";
		document.forms[0].txt_subsidyper.value="0";
	}
	var subsidy=eval(subsidyper)/100*eval(totalamount);
	document.forms[0].txt_subsidy.value=Math.round(eval(subsidy));
	
	roundtxt(document.forms[0].txt_totalamount);
	roundtxt(document.forms[0].txt_subsidy);
}

function margin()
{
	var totalamount=document.forms[0].txt_totalamount.value;
	var margin=document.forms[0].txt_margin.value;
	if(eval(margin)=="")
	{
		margin="0";
		document.forms[0].txt_margin.value="0";
	}
	var marginper=(eval(margin)*100)/eval(totalamount);
	document.forms[0].txt_marginper.value=Math.round(eval(marginper));
}

function subsidy()
{
	var totalamount=document.forms[0].txt_totalamount.value;
	var subsidy=document.forms[0].txt_subsidy.value;
	if(eval(subsidy)=="")
	{
		subsidy="0";
		document.forms[0].txt_subsidy.value="0";
	}
	var subsidyper=(eval(subsidy)*100)/eval(totalamount);
	document.forms[0].txt_subsidyper.value=Math.round(eval(subsidyper));
}

function loanamount()
{
	var totalamount=document.forms[0].txt_totalamount.value;
	
	
	if(document.forms[0].txt_subsidy.value=="NaN.00")
	{
		document.forms[0].txt_subsidy.value="0";
		document.forms[0].txt_subsidyper.value="0";
	}
	var subsidy=document.forms[0].txt_subsidy.value;
	
	if(document.forms[0].txt_margin.value=="NaN.00")
	{
		document.forms[0].txt_margin.value="0";
		document.forms[0].txt_marginper.value="0";
	}
	var margin=document.forms[0].txt_margin.value;
	
	var total=eval(totalamount)-(eval(margin)+eval(subsidy));
	document.forms[0].txt_totalloanamount.value=total;
	if(document.forms[0].txt_totalloanamount.value == "NaN")
		document.forms[0].txt_totalloanamount.value = 0;
		
	roundtxt(document.forms[0].txt_totalloanamount);
}

function doSave()
{	
   costfeed();amount();callamount();callTotal();loanamount();
	enableButtons( true, true, true, true, false);	
    document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="agrpoultry";
	document.forms[0].hidSourceUrl.value="/action/agr_sheep_loanreq.jsp";
	document.forms[0].hidBeanMethod.value="updatesheeploanreq";
	document.forms[0].hidBeanGetMethod.value="getsheeploanreq";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body
	onLoad="onloading();costval();costfeed();amount();callamount();callTotal();margin();subsidy();marginper();subsidyper();loanamount();">
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
					<tr>
   						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable border1">
							<tr>
								<td colspan="13">
								<table width="100%" border="0" cellspacing="2" cellpadding="1" class="outertable">
									<tr class="dataheader">
										<td><b>Particulars</b></td>
										<td align="center"><b>No.
										of units</b></td>
										<td align="center"><b>Cost
										per unit(Rs.)</b></td>
										<td align="center"><b>Amount(Rs.)</b></td>
									</tr>
									<tr>
										<td width="72%" height="26">Purchase of Goat/Sheep/Rabbit/Pig
										(Male) <input type="hidden" name="txt_specify" size="15"
											maxlength="100" value="" onKeyPress=""
											style="text-align:right;"> <input type="hidden" name="txt_sq"
											size="10" maxlength="10" value="" onKeyPress="allowInteger()"
											onBlur="callTotal()" style="text-align:right;"> <input
											type="hidden" name="txt_value" onFocus="" size="10"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
										<td width="8%"><input type="text" name="txt_unit" size="10"
											maxlength="15"
											value="<%=Helper.correctNull((String)hshValues.get("txt_maleno"))%>"
											onKeyPress="allowInteger()" style="text-align:right;"></td>
										<td width="11%"><input type="text" name="txt_cost" size="10"
											maxlength="15"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_malecost"))))%>"
											onKeyPress="allowInteger()" style="text-align:right;"></td>
										<td width="9%"><input type="text" name="txt_amount" size="15"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
									</tr>
									<tr>
										<td>Purchase of Goat/Sheep/Rabbit/Pig (Female) <input
											type="hidden" name="txt_specify" size="15" maxlength="100"
											value="" onKeyPress="" style="text-align:right;"> <input
											type="hidden" name="txt_sq" size="10" maxlength="10" value=""
											onKeyPress="allowInteger()" onBlur="callTotal()"
											style="text-align:right;"> <input type="hidden"
											name="txt_value" onFocus="" size="10" maxlength="15" value=""
											onKeyPress="allowInteger()" style="text-align:right;"></td>
										<td><input type="text" name="txt_unit" onFocus="" size="10"
											maxlength="15"
											value="<%=Helper.correctNull((String)hshValues.get("txt_femaleno"))%>"
											onKeyPress="allowInteger()" style="text-align:right;"></td>
										<td><input type="text" name="txt_cost" size="10"
											maxlength="15"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_femalecost"))))%>"
											onKeyPress="allowInteger()" style="text-align:right;"></td>
										<td><input type="text" name="txt_amount" size="15"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
									</tr>
									<tr>
										<td>Cost of transportation of Animals <input type="hidden"
											name="txt_specify" size="15" maxlength="100" value=""
											onKeyPress="" style="text-align:right;"> <input type="hidden"
											name="txt_sq" size="10" maxlength="10" value=""
											onKeyPress="allowInteger()" onBlur="callTotal()"
											style="text-align:right;"> <input type="hidden"
											name="txt_value" onFocus="" size="10" maxlength="15" value=""
											onKeyPress="allowInteger()" style="text-align:right;"></td>
										<td><input type="text" name="txt_unit" onFocus="" size="10"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
										<td><input type="text" name="txt_cost" size="10"
											maxlength="15"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_markettranscost"))))%>"
											onKeyPress="allowInteger()" style="text-align:right;"></td>
										<td><input type="text" name="txt_amount" size="15"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
									</tr>
									<tr>
										<td>Cost of Feeding of Breeding Stock(No.of Male adults*cost
										of feeding/animal/day* <input type="text" name="txt_value"
											onFocus="" size="10" maxlength="4"
											value="<%=Helper.correctNull((String)hshValues.get("txt_value1"))%>"
											onKeyPress="allowInteger()" style="text-align:right;"
											onBlur="costfeed()"> days ) <input type="hidden"
											name="txt_specify" size="15" maxlength="100" value=""
											onKeyPress="" style="text-align:right;"> <input type="hidden"
											name="txt_sq" size="10" maxlength="10" value=""
											onKeyPress="allowInteger()" onBlur="callTotal()"
											style="text-align:right;"></td>
										<td><input type="text" name="txt_unit" onFocus="" size="10"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
										<td><input type="text" name="txt_cost" size="10"
											maxlength="15"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_feedadult"))))%>"
											onKeyPress="allowInteger()" style="text-align:right;"></td>
										<td><input type="text" name="txt_amount" size="15"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
									</tr>
									<tr>
										<td>Cost of Feeding of Breeding Stock(No.of Female adults*cost
										of feeding/animal/day* <input type="text" name="txt_value"
											onFocus="" size="10" maxlength="4"
											value="<%=Helper.correctNull((String)hshValues.get("txt_value1"))%>"
											onKeyPress="allowInteger()" style="text-align:right;"
											onBlur="costfeed()"> days ) <input type="hidden"
											name="txt_specify" size="15" maxlength="100" value=""
											onKeyPress="" style="text-align:right;"> <input type="hidden"
											name="txt_sq" size="10" maxlength="10" value=""
											onKeyPress="allowInteger()" onBlur="callTotal()"
											style="text-align:right;"></td>
										<td><input type="text" name="txt_unit" onFocus="" size="10"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
										<td><input type="text" name="txt_cost" size="10"
											maxlength="15"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_feedadult1"))))%>"
											onKeyPress="allowInteger()" style="text-align:right;"></td>
										<td><input type="text" name="txt_amount" size="15"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
									</tr>

									<tr>
										<td>Veterinary Aid(No.of adults*cost of vt aid/month/animal* <input
											type="text" name="txt_value" onFocus="" size="10"
											maxlength="4"
											value="<%=Helper.correctNull((String)hshValues.get("txt_value2"))%>"
											onKeyPress="allowInteger()" style="text-align:right;"
											onBlur="costfeed()"> months) <input type="hidden"
											name="txt_specify" size="15" maxlength="100" value=""
											onKeyPress="" style="text-align:right;"> <input type="hidden"
											name="txt_sq" size="10" maxlength="10" value=""
											onKeyPress="allowInteger()" onBlur="callTotal()"
											style="text-align:right;"></td>
										<td><input type="text" name="txt_unit" onFocus="" size="10"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
										<td><input type="text" name="txt_cost" size="10"
											maxlength="15"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_vtaidprice"))))%>"
											onKeyPress="allowInteger()" style="text-align:right;"></td>
										<td><input type="text" name="txt_amount" size="15"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
									</tr>
									<tr>
										<td>Insurance Premium(No.of adults*cost of
										insurance/animal/year) <input type="hidden" name="txt_specify"
											size="15" maxlength="100" value="" onKeyPress=""
											style="text-align:right;"> <input type="hidden"
											name="txt_value" onFocus="" size="10" maxlength="15" value=""
											onKeyPress="allowInteger()" style="text-align:right;"> <input
											type="hidden" name="txt_sq" size="10" maxlength="10" value=""
											onKeyPress="allowInteger()" onBlur="callTotal()"
											style="text-align:right;"></td>
										<td><input type="text" name="txt_unit" onFocus="" size="10"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
										<td><input type="text" name="txt_cost" size="10"
											maxlength="15"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_inspremium"))))%>"
											onKeyPress="allowInteger()" style="text-align:right;"></td>
										<td><input type="text" name="txt_amount" size="15"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
									</tr>
									<tr>
										<td>Labour(no.of labourers*wages/month* <input type="hidden"
											name="txt_specify" size="15" maxlength="100" value=""
											onKeyPress="" style="text-align:right;"> <input type="text"
											name="txt_value" onFocus="" size="10" maxlength="4"
											value="<%=Helper.correctNull((String)hshValues.get("txt_value3"))%>"
											onKeyPress="allowInteger()" style="text-align:right;"
											onBlur="costfeed()"> months) <input type="hidden"
											name="txt_sq" size="10" maxlength="10" value=""
											onKeyPress="allowInteger()" onBlur="callTotal()"
											style="text-align:right;"></td>
										<td><input type="text" name="txt_unit" onFocus="" size="10"
											maxlength="15"
											value="<%=Helper.correctNull((String)hshValues.get("txt_employee"))%>"
											onKeyPress="allowInteger()" style="text-align:right;"></td>
										<td><input type="text" name="txt_cost" size="10"
											maxlength="15"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_wageemployee"))))%>"
											onKeyPress="allowInteger()" style="text-align:right;"></td>
										<td><input type="text" name="txt_amount" size="15"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
									</tr>
									<tr>
										<td colspan="4"><b>Other
										Civil Works</b></td>
									</tr>
									<tr>
										<%if (arryRow.size() != 0) {

				arryCol = (ArrayList) arryRow.get(4);

				if (arryCol.size() != 0) {

					l13 = Helper.correctNull((String) arryCol.get(4));
					l14 = Helper.correctNull((String) arryCol.get(5));
					m1 = Helper.correctNull((String) arryCol.get(3));
					m5 = Helper.correctNull((String) arryCol.get(6));

				}
			} else if (arryRow.size() == 0) {

				l13 = "";
				l14 = "";
				m1 = "";
				m5 = "";
			}

			%>
										<td>Construction of <input type="text" name="txt_specify"
											size="30" maxlength="25" value="<%=m1%>" onKeyPress="">
										shed measuring <input type="text" name="txt_sq" size="10"
											maxlength="5" value="<%=l13%>" onKeyPress="allowNumber(this)"
											onBlur="calunits('8');amount();callTotal()"
											style="text-align:right;"> sq ft @ Rs. <input type="text"
											name="txt_value" size="10" maxlength="5" value="<%=l14%>"
											onKeyPress="allowInteger()"
											onBlur="calunits('8');amount();callTotal()"
											style="text-align:right;"> per sq ft</td>
										<td><input type="text" name="txt_unit" onFocus="" size="10"
											maxlength="7" value="<%=m5%>" onKeyPress="allowInteger()"
											style="text-align:right;" onBlur="amount();callTotal()"></td>
										<td><input type="text" name="txt_cost" size="10"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
										<td><input type="text" name="txt_amount" size="15"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
									</tr>
									<tr>
										<%if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(5);

				if (arryCol.size() != 0) {

					l15 = Helper.correctNull((String) arryCol.get(4));
					l16 = Helper.correctNull((String) arryCol.get(5));
					m2 = Helper.correctNull((String) arryCol.get(3));
					m6 = Helper.correctNull((String) arryCol.get(6));

				}

			} else if (arryRow.size() == 0) {

				l15 = "";
				l16 = "";
				m2 = "";
				m6 = "";
			}

			%>
										<td>Construction of <input type="text" name="txt_specify"
											size="30" maxlength="25" value="<%=m2%>" onKeyPress="">
										shed measuring <input type="text" name="txt_sq" size="10"
											maxlength="5" value="<%=l15%>" onKeyPress="allowNumber(this)"
											onBlur="calunits('9');amount();callTotal()"
											style="text-align:right;"> sq ft @ Rs. <input type="text"
											name="txt_value" size="10" maxlength="5" value="<%=l16%>"
											onKeyPress="allowInteger()"
											onBlur="calunits('9');amount();callTotal()"
											style="text-align:right;"> per sq ft</td>
										<td><input type="text" name="txt_unit" onFocus="" size="10"
											maxlength="7" value="<%=m6%>" onKeyPress="allowInteger()"
											style="text-align:right;" onBlur="amount();callTotal()"></td>
										<td><input type="text" name="txt_cost" size="10"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
										<td><input type="text" name="txt_amount" size="15"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
									</tr>
									<tr>
										<%if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(6);

				if (arryCol.size() != 0) {

					l17 = Helper.correctNull((String) arryCol.get(4));
					l18 = Helper.correctNull((String) arryCol.get(5));
					m3 = Helper.correctNull((String) arryCol.get(3));
					m7 = Helper.correctNull((String) arryCol.get(6));

				}
			} else if (arryRow.size() == 0) {
				l17 = "";
				l18 = "";
				m3 = "";
				m7 = "";

			}

			%>
										<td>Construction of <input type="text" name="txt_specify"
											size="30" maxlength="25" value="<%=m3%>" onKeyPress="">
										shed measuring <input type="text" name="txt_sq" size="10"
											maxlength="5" value="<%=l17%>" onKeyPress="allowNumber(this)"
											onBlur="calunits('10');amount();callTotal()"
											style="text-align:right;"> sq ft @ Rs. <input type="text"
											name="txt_value" size="10" maxlength="5" value="<%=l18%>"
											onKeyPress="allowInteger()"
											onBlur="calunits('10');amount();callTotal()"
											style="text-align:right;"> per sq ft</td>
										<td><input type="text" name="txt_unit" size="10"
											maxlength="7" value="<%=m7%>" onKeyPress="allowInteger()"
											style="text-align:right;" onBlur="amount();callTotal()"></td>
										<td><input type="text" name="txt_cost" size="10"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
										<td><input type="text" name="txt_amount" size="15"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
									</tr>
									<tr>
										<%if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(7);

				if (arryCol.size() != 0) {

					l19 = Helper.correctNull((String) arryCol.get(4));
					l20 = Helper.correctNull((String) arryCol.get(5));
					m4 = Helper.correctNull((String) arryCol.get(3));
					m8 = Helper.correctNull((String) arryCol.get(6));

				}

			} else if (arryRow.size() == 0) {
				l19 = "";
				l20 = "";
				m4 = "";
				m8 = "";
			}

			%>
										<td>Construction of <input type="text" name="txt_specify"
											size="30" maxlength="25" value="<%=m4%>" onKeyPress="">
										shed measuring <input type="text" name="txt_sq" size="10"
											maxlength="5" value="<%=l19%>" onKeyPress="allowNumber(this)"
											onBlur="calunits('11');amount();callTotal()"
											style="text-align:right;"> sq ft @ Rs. <input type="text"
											name="txt_value" size="10" maxlength="5" value="<%=l20%>"
											onKeyPress="allowInteger()"
											onBlur="calunits('11');amount();callTotal()"
											style="text-align:right;"> per sq ft</td>
										<td><input type="text" name="txt_unit" size="10"
											maxlength="7" value="<%=m8%>" onKeyPress="allowInteger()"
											style="text-align:right;" onBlur="amount();callTotal()"></td>
										<td><input type="text" name="txt_cost" size="10"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
										<td><input type="text" name="txt_amount" size="15"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
									</tr>
									<tr>
										<%if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(8);

				if (arryCol.size() != 0) {

					l19 = Helper.correctNull((String) arryCol.get(4));
					l20 = Helper.correctNull((String) arryCol.get(5));
					m4 = Helper.correctNull((String) arryCol.get(3));
					m8 = Helper.correctNull((String) arryCol.get(6));

				}

			} else if (arryRow.size() == 0) {
				l19 = "";
				l20 = "";
				m4 = "";
				m8 = "";
			}

			%>
										<td>Construction of <input type="text" name="txt_specify"
											size="30" maxlength="25" value="<%=m4%>" onKeyPress="">
										shed measuring <input type="text" name="txt_sq" size="10"
											maxlength="5" value="<%=l19%>" onKeyPress="allowNumber(this)"
											onBlur="calunits('12');amount();callTotal()"
											style="text-align:right;"> sq ft @ Rs. <input type="text"
											name="txt_value" size="10" maxlength="5" value="<%=l20%>"
											onKeyPress="allowInteger()"
											onBlur="calunits('12');amount();callTotal()"
											style="text-align:right;"> per sq ft</td>
										<td><input type="text" name="txt_unit" size="10"
											maxlength="7" value="<%=m8%>" onKeyPress="allowInteger()"
											style="text-align:right;" onBlur="amount();callTotal()"></td>
										<td><input type="text" name="txt_cost" size="10"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
										<td><input type="text" name="txt_amount" size="15"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
									</tr>
									<tr>
										<%if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(9);

				if (arryCol.size() != 0) {

					l19 = Helper.correctNull((String) arryCol.get(4));
					l20 = Helper.correctNull((String) arryCol.get(5));
					m4 = Helper.correctNull((String) arryCol.get(3));
					m8 = Helper.correctNull((String) arryCol.get(6));

				}

			} else if (arryRow.size() == 0) {
				l19 = "";
				l20 = "";
				m4 = "";
				m8 = "";
			}

			%>
										<td>Construction of <input type="text" name="txt_specify"
											size="30" maxlength="25" value="<%=m4%>" onKeyPress="">
										shed measuring <input type="text" name="txt_sq" size="10"
											maxlength="5" value="<%=l19%>" onKeyPress="allowNumber(this)"
											onBlur="calunits('13');amount();callTotal()"
											style="text-align:right;"> sq ft @ Rs. <input type="text"
											name="txt_value" size="10" maxlength="5" value="<%=l20%>"
											onKeyPress="allowInteger()"
											onBlur="calunits('13');amount();callTotal()"
											style="text-align:right;"> per sq ft</td>
										<td><input type="text" name="txt_unit" size="10"
											maxlength="7" value="<%=m8%>" onKeyPress="allowInteger()"
											style="text-align:right;" onBlur="amount();callTotal()"></td>
										<td><input type="text" name="txt_cost" size="10"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
										<td><input type="text" name="txt_amount" size="15"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;"></td>
									</tr>
								</table>
								<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
									<tr class="dataheader">
										<td colspan="4"><b>Purchase of
										Equipments</b></td>
									</tr>
									<tr class="dataheader">
										<td width="73%"><b>Name of equipments
										with specifications</b></td>
										<td width="8%"><b>No of units</b></td>
										<td width="9%"><b>Cost per unit(Rs.)</b></td>
										<td width="10%"><b>Amount(Rs.)</b></td>
									</tr>
									<tr>
										<%if (arryRow1.size() != 0) {

				arryCol1 = (ArrayList) arryRow1.get(0);

				if (arryCol1.size() != 0) {

					r1 = Helper.correctNull((String) arryCol1.get(3));
					r2 = Helper.correctNull((String) arryCol1.get(4));
					r3 = Helper.correctNull((String) arryCol1.get(5));

				}
			} else if (arryRow1.size() == 0) {

				r1 = "";
				r2 = "";
				r3 = "";
			}

			%>
										<td><input type="text" name="txt_specify" size="70"
											maxlength="100" value="<%=r1%>" onKeyPress=""
											style="text-align:left;"> <input type="hidden"
											name="txt_value" onFocus="" size="10" maxlength="15" value=""
											onKeyPress="allowInteger()" style="text-align:right;"> <input
											type="hidden" name="txt_sq" size="10" maxlength="10" value=""
											onKeyPress="allowInteger()" onBlur="callTotal()"
											style="text-align:right;"></td>
										<td><input type="text" name="txt_unit" size="10"
											maxlength="10" value="<%=r2%>" onKeyPress="allowInteger()"
											onBlur="callTotal()" style="text-align:right;"></td>
										<td><input type="text" name="txt_cost" size="10"
											maxlength="10" value="<%=r3%>" onKeyPress="allowInteger()"
											onBlur="callTotal()" style="text-align:right;"></td>
										<td><input type="text" name="txt_amount" size="15"
											maxlength="10" value="" onKeyPress="allowInteger()" onBlur=""
											style="text-align:right;"></td>
									</tr>
									<tr>
										<%if (arryRow1.size() != 0) {

				arryCol1 = (ArrayList) arryRow1.get(1);

				if (arryCol1.size() != 0) {

					r4 = Helper.correctNull((String) arryCol1.get(3));
					r5 = Helper.correctNull((String) arryCol1.get(4));
					r6 = Helper.correctNull((String) arryCol1.get(5));

				}
			} else if (arryRow1.size() == 0) {

				r4 = "";
				r5 = "";
				r6 = "";
			}

			%>
										<td><input type="text" name="txt_specify" size="70"
											maxlength="100" value="<%=r4%>" onKeyPress=""
											style="text-align:left;"> <input type="hidden"
											name="txt_value" onFocus="" size="10" maxlength="15" value=""
											onKeyPress="allowInteger()" style="text-align:right;"> <input
											type="hidden" name="txt_sq" size="10" maxlength="10" value=""
											onKeyPress="allowInteger()" onBlur="callTotal()"
											style="text-align:right;"></td>
										<td><input type="text" name="txt_unit" size="10"
											maxlength="10" value="<%=r5%>" onKeyPress="allowInteger()"
											onBlur="callTotal()" style="text-align:right;"></td>
										<td><input type="text" name="txt_cost" size="10"
											maxlength="10" value="<%=r6%>" onKeyPress="allowInteger()"
											onBlur="callTotal()" style="text-align:right;"></td>
										<td><input type="text" name="txt_amount" size="15"
											maxlength="10" value="" onKeyPress="allowInteger()" onBlur=""
											style="text-align:right;"></td>
									</tr>
									<tr>
										<%if (arryRow1.size() != 0) {

				arryCol1 = (ArrayList) arryRow1.get(2);

				if (arryCol1.size() != 0) {

					r7 = Helper.correctNull((String) arryCol1.get(3));
					r8 = Helper.correctNull((String) arryCol1.get(4));
					r9 = Helper.correctNull((String) arryCol1.get(5));

				}
			} else if (arryRow1.size() == 0) {

				r7 = "";
				r8 = "";
				r9 = "";
			}

			%>
										<td><input type="text" name="txt_specify" size="70"
											maxlength="100" value="<%=r7%>" onKeyPress=""
											style="text-align:left;"> <input type="hidden"
											name="txt_value" onFocus="" size="10" maxlength="15" value=""
											onKeyPress="allowInteger()" style="text-align:right;"> <input
											type="hidden" name="txt_sq" size="10" maxlength="10" value=""
											onKeyPress="allowInteger()" onBlur="callTotal()"
											style="text-align:right;"></td>
										<td><input type="text" name="txt_unit" size="10"
											maxlength="10" value="<%=r8%>" onKeyPress="allowInteger()"
											onBlur="callTotal()" style="text-align:right;"></td>
										<td><input type="text" name="txt_cost" size="10"
											maxlength="10" value="<%=r9%>" onKeyPress="allowInteger()"
											onBlur="callTotal()" style="text-align:right;"></td>
										<td><input type="text" name="txt_amount" size="15"
											maxlength="10" value="" onKeyPress="allowInteger()" onBlur=""
											style="text-align:right;"></td>
									</tr>
									<tr>
										<%if (arryRow1.size() != 0) {

				arryCol1 = (ArrayList) arryRow1.get(3);

				if (arryCol1.size() != 0) {

					r10 = Helper.correctNull((String) arryCol1.get(3));
					r11 = Helper.correctNull((String) arryCol1.get(4));
					r12 = Helper.correctNull((String) arryCol1.get(5));

				}
			} else if (arryRow1.size() == 0) {

				r10 = "";
				r11 = "";
				r12 = "";
			}

			%>
										<td><input type="text" name="txt_specify" size="70"
											maxlength="100" value="<%=r10%>" onKeyPress=""
											style="text-align:left;"> <input type="hidden"
											name="txt_value" onFocus="" size="10" maxlength="15" value=""
											onKeyPress="allowInteger()" style="text-align:right;"> <input
											type="hidden" name="txt_sq" size="10" maxlength="10" value=""
											onKeyPress="allowInteger()" onBlur="callTotal()"
											style="text-align:right;"></td>
										<td><input type="text" name="txt_unit" size="10"
											maxlength="10" value="<%=r11%>" onKeyPress="allowInteger()"
											onBlur="callTotal()" style="text-align:right;"></td>
										<td><input type="text" name="txt_cost" size="10"
											maxlength="10" value="<%=r12%>" onKeyPress="allowInteger()"
											onBlur="callTotal()" style="text-align:right;"></td>
										<td><input type="text" name="txt_amount" size="15"
											maxlength="10" value="" onKeyPress="allowInteger()" onBlur=""
											style="text-align:right;"></td>
									</tr>
									<tr>
										<%if (arryRow1.size() != 0) {

				arryCol1 = (ArrayList) arryRow1.get(4);

				if (arryCol1.size() != 0) {

					r13 = Helper.correctNull((String) arryCol1.get(3));
					r14 = Helper.correctNull((String) arryCol1.get(4));
					r15 = Helper.correctNull((String) arryCol1.get(5));

				}
			} else if (arryRow1.size() == 0) {

				r13 = "";
				r14 = "";
				r15 = "";
			}

			%>
										<td><input type="text" name="txt_specify" size="70"
											maxlength="100" value="<%=r13%>" onKeyPress=""
											style="text-align:left;"> <input type="hidden"
											name="txt_value" onFocus="" size="10" maxlength="15" value=""
											onKeyPress="allowInteger()" style="text-align:right;"> <input
											type="hidden" name="txt_sq" size="10" maxlength="10" value=""
											onKeyPress="allowInteger()" onBlur="callTotal()"
											style="text-align:right;"></td>
										<td><input type="text" name="txt_unit" size="10"
											maxlength="10" value="<%=r14%>" onKeyPress="allowInteger()"
											onBlur="callTotal()" style="text-align:right;"></td>
										<td><input type="text" name="txt_cost" size="10"
											maxlength="10" value="<%=r15%>" onKeyPress="allowInteger()"
											onBlur="callTotal()" style="text-align:right;"></td>
										<td><input type="text" name="txt_amount" size="15"
											maxlength="10" value="" onKeyPress="allowInteger()" onBlur=""
											style="text-align:right;"></td>
									</tr>
									<tr class="dataheader">
										<td><b>Others Specify </b></td>
										<td><b>No of units</b></td>
										<td><b>Cost per unit(Rs.)</b></td>
										<td><b>Amount(Rs.)</b></td>
									</tr>
									<tr>
										<%if (arryRow.size() != 0) {

				arryCol = (ArrayList) arryRow.get(0);

				if (arryCol.size() != 0) {

					l1 = Helper.correctNull((String) arryCol.get(3));
					l2 = Helper.correctNull((String) arryCol.get(4));
					l3 = Helper.correctNull((String) arryCol.get(5));

				}
			} else if (arryRow.size() == 0) {

				l1 = "";
				l2 = "";
				l3 = "";
			}

			%>
										<td><input type="text" name="txt_specify" size="70"
											maxlength="100" value="<%=l1%>" onKeyPress=""
											style="text-align:left;"> <input type="hidden"
											name="txt_value" onFocus="" size="10" maxlength="15" value=""
											onKeyPress="allowInteger()" style="text-align:right;"> <input
											type="hidden" name="txt_sq" size="10" maxlength="10" value=""
											onKeyPress="allowInteger()" onBlur="callTotal()"
											style="text-align:right;"></td>
										<td><input type="text" name="txt_unit" size="10"
											maxlength="7" value="<%=l2%>" onKeyPress="allowInteger()"
											onBlur="callTotal();callamount()" style="text-align:right;">
										</td>
										<td><input type="text" name="txt_cost" size="10"
											maxlength="7" value="<%=l3%>" onKeyPress="allowInteger()"
											onBlur="callTotal();callamount()" style="text-align:right;">
										</td>
										<td><input type="text" name="txt_amount" size="15"
											maxlength="7" value="" onKeyPress="allowInteger()" onBlur=""
											style="text-align:right;"></td>
									</tr>
									<tr>
										<%if (arryRow.size() != 0) {

				arryCol = (ArrayList) arryRow.get(1);

				if (arryCol.size() != 0) {

					l4 = Helper.correctNull((String) arryCol.get(3));
					l5 = Helper.correctNull((String) arryCol.get(4));
					l6 = Helper.correctNull((String) arryCol.get(5));

				}
			} else if (arryRow.size() == 0) {

				l4 = "";
				l5 = "";
				l6 = "";
			}

			%>
										<td><input type="text" name="txt_specify" size="70"
											maxlength="100" value="<%=l4%>" onKeyPress=""
											style="text-align:left;"> <input type="hidden"
											name="txt_avlue" onFocus="" size="10" maxlength="15" value=""
											onKeyPress="allowInteger()" style="text-align:right;"> <input
											type="hidden" name="txt_sq" size="10" maxlength="10" value=""
											onKeyPress="allowInteger()" onBlur="callTotal()"
											style="text-align:right;"></td>
										<td><input type="text" name="txt_unit" size="10"
											maxlength="7" value="<%=l5%>" onKeyPress="allowInteger()"
											onBlur="callTotal();callamount()" style="text-align:right;">
										</td>
										<td><input type="text" name="txt_cost" size="10"
											maxlength="7" value="<%=l6%>" onKeyPress="allowInteger()"
											onBlur="callTotal();callamount()" style="text-align:right;">
										</td>
										<td><input type="text" name="txt_amount" size="15"
											maxlength="10" value="" onKeyPress="allowInteger()" onBlur=""
											style="text-align:right;"></td>
									</tr>
									<tr>
										<%if (arryRow.size() != 0) {

				arryCol = (ArrayList) arryRow.get(2);

				if (arryCol.size() != 0) {

					l7 = Helper.correctNull((String) arryCol.get(3));
					l8 = Helper.correctNull((String) arryCol.get(4));
					l9 = Helper.correctNull((String) arryCol.get(5));

				}
			} else if (arryRow.size() == 0) {

				l7 = "";
				l8 = "";
				l9 = "";
			}

			%>
										<td><input type="text" name="txt_specify" size="70"
											maxlength="100" value="<%=l7%>" onKeyPress=""
											style="text-align:left;"> <input type="hidden"
											name="txt_value" onFocus="" size="10" maxlength="15" value=""
											onKeyPress="allowInteger()" style="text-align:right;"> <input
											type="hidden" name="txt_sq" size="10" maxlength="10" value=""
											onKeyPress="allowInteger()" onBlur="callTotal()"
											style="text-align:right;"></td>
										<td><input type="text" name="txt_unit" size="10"
											maxlength="7" value="<%=l8%>" onKeyPress="allowInteger()"
											onBlur="callTotal();callamount()" style="text-align:right;">
										</td>
										<td><input type="text" name="txt_cost" size="10"
											maxlength="7" value="<%=l9%>" onKeyPress="allowInteger()"
											onBlur="callTotal();callamount()" style="text-align:right;">
										</td>
										<td><input type="text" name="txt_amount" size="15"
											maxlength="10" value="" onKeyPress="allowInteger()" onBlur=""
											style="text-align:right;"></td>
									</tr>
									<tr>
										<%if (arryRow.size() != 0) {

				arryCol1 = (ArrayList) arryRow.get(3);

				if (arryCol.size() != 0) {

					l10 = Helper.correctNull((String) arryCol1.get(3));
					l11 = Helper.correctNull((String) arryCol1.get(4));
					l12 = Helper.correctNull((String) arryCol1.get(5));

				}
			} else if (arryRow.size() == 0) {

				l10 = "";
				l11 = "";
				l12 = "";
			}

			%>
										<td><input type="text" name="txt_specify" size="70"
											maxlength="100" value="<%=l10%>" onKeyPress=""
											style="text-align:left;"> <input type="hidden"
											name="txt_value" onFocus="" size="10" maxlength="15" value=""
											onKeyPress="allowInteger()" style="text-align:right;"> <input
											type="hidden" name="txt_sq" size="10" maxlength="10" value=""
											onKeyPress="allowInteger()" onBlur="callTotal()"
											style="text-align:right;"></td>
										<td><input type="text" name="txt_unit" size="10"
											maxlength="7" value="<%=l11%>" onKeyPress="allowInteger()"
											onBlur="callTotal();callamount()" style="text-align:right;">
										</td>
										<td><input type="text" name="txt_cost" size="10"
											maxlength="7" value="<%=l12%>" onKeyPress="allowInteger()"
											onBlur="callTotal();callamount()" style="text-align:right;">
										</td>
										<td><input type="text" name="txt_amount" size="15"
											maxlength="10" value="" onKeyPress="allowInteger()" onBlur=""
											style="text-align:right;"></td>
									</tr>
									<tr class="dataheader">
										<td><b>Total(Amount)(Rs.)</b></td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										
                              <td>
                                <input type="text" name="txt_totalamount" size="15"
											maxlength="10" value="" onKeyPress="allowInteger()" readOnly
											style="text-align:right;">
                                <b></b></td>
									</tr>


									<tr style="display:none">
										<td colspan="3" align="right"><b> Rs.</b></td>
										<td><input type="hidden" name="txt_totalloanamount" size="10"
											maxlength="8" value="" onKeyPress="allowInteger()" onBlur=""
											style="text-align:right;"> or say <input type="hidden"
											name="txt_totalloanamount1" size="10" maxlength="8"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_totalloanamount1"))))%>"
											onKeyPress="allowInteger()" onBlur=""
											style="text-align:right;"></td>
									</tr>
									<tr style="display:none">
										<td colspan="3" align="right"><b></b><b> <input type="hidden"
											name="txt_marginper" size="10" maxlength="3"
											value="<%=Helper.correctNull((String)hshValues.get("txt_margin"))%>"
											onKeyPress="allowInteger()" onBlur="marginper();loanamount()"
											style="text-align:right;"> </b></td>
										<td nowrap><input type="hidden" name="txt_margin" size="10"
											maxlength="8"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_marginper"))))%>"
											onKeyPress="allowInteger()"
											onBlur="margin();loanamount();roundtxt(this)"
											style="text-align:right;"></td>
									</tr>
									<tr style="display:none">
										<td colspan="3" align="right">&nbsp;<strong> <input
											type="hidden" name="txt_subsidyper" size="10" maxlength="3"
											value="<%=Helper.correctNull((String)hshValues.get("txt_subsidyper"))%>"
											onKeyPress="allowInteger()"
											onBlur="subsidyper();loanamount()" style="text-align:right;">
										</strong></td>
										<td><input type="hidden" name="txt_subsidy" size="10"
											maxlength="8"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_subsidy"))))%>"
											onKeyPress="allowInteger()"
											onBlur="subsidy();loanamount();roundtxt(this)"
											style="text-align:right;"></td>
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
<br/>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:agrihiddentag pageid='<%=PageId%>' />
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("auditFlag"))%>">
<input type="hidden" name="txt_value1" value="<%=Helper.correctNull((String)hshValues.get("txt_value1"))%>"> 
<input type="hidden" name="txt_value2" value="<%=Helper.correctNull((String)hshValues.get("txt_value2"))%>"> 
<input type="hidden" name="txt_value3" value="<%=Helper.correctNull((String)hshValues.get("txt_value3"))%>"></form>
</body>
</html>