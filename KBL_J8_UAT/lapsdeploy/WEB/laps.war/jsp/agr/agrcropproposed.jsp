<%@include file = "../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
	<%
	if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			String seasn="";
			ArrayList vecData = new ArrayList();
			ArrayList vecRow = new ArrayList();
			
			if (hshValues != null) {
				vecData = (ArrayList) hshValues.get("vecData");
			}
			String PageType = Helper.correctNull((String) hshValues.get("PageType"));
	%>
<html>
<head>
<title>Proposed To Be Grown Crop Details</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
function callhelp()
{
	var varQryString = appURL+"/jsp/perhlp/hlp_proposedcrops.jsp";
	var title = "ApplicantDemographics";
	var prop = "scrollbars=no,width=600,height=450";	
	prop = prop + ",left=200,top=150";
	window.open(varQryString,title,prop);
}

function enableButtons(bool1, bool2, bool3, bool4, bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
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
		/*document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/persearch.jsp";				
		document.forms[0].submit();*/
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/"+"retailpge.jsp";				
		document.forms[0].submit();
	}
}

function check()
{
	/*var season_val=document.forms[0].season.value;
	var areaval=document.forms[0].txt_area.value;
	var acreval=document.forms[0].txt_acre.value;
	if(areaval=="")
	{
		areaval=0.00;
	}
	if(acreval=="")
	{
		acreval=0.00;
	}
	var acreageval=0;
	var meas=document.forms[0].land_measurement.value;
	if(eval(areaval)=="")
	{
		areaval=0;
	}
	if(eval(acreval)=="")
	{
		acreval=0;
	}
	if(meas=="g")
	{
		if(acreval.length==1)
		{
		 	acreageval= areaval+".0"+acreval;
		}
		else
		{
			acreageval= areaval+"."+acreval;
		}
	}
	if(meas=="c")
	{
	 	if(acreval.length==1)
		{
	 		acreageval= areaval+".0"+acreval;
		}
		else
		{
	 		acreageval= areaval+"."+acreval;
		}
	}
	document.forms[0].txt_total_area1.value=eval(acreageval);
	document.forms[0].season_value.value=eval(season_val);*/
}

function callcost()
{
	var area=document.forms[0].txt_area.value;
	var acre=document.forms[0].txt_acre.value;
	if(area=="")
	{
		area=0.00;
	}
	if(acre=="")
	{
		acre=0.00;
	}
	var area1=area+"."+acre;
	var req=document.forms[0].txt_irrigated.value;
	if(req=="")
	{
		req=0;
	}
	if(document.forms[0].txt_irrigated.value=="")
	{
		document.forms[0].txt_irrigated.value ="0.00";
	}
	if(document.forms[0].land_measurement.value == 'g')
	{
		var areaval1=eval(area)*eval(req);	
		if(eval(acre)>0)
		{
			var ff=eval(acre)/40;
			var areaval2=eval(ff)*eval(req);
		}
		else
		{
			var areaval2=0;
		}
		var cost_val=eval(areaval1)+eval(areaval2);	
		
	  document.forms[0].txt_cost.value=eval(cost_val);
	  cost_val= document.forms[0].txt_cost.value;
	  var pos= cost_val.indexOf(".");
		if(pos>0)
		{
		cost_val= cost_val.substring(0,pos+3);
     			
		}
		document.forms[0].txt_cost.value=Math.round(eval(cost_val));
	  
	}
	if(document.forms[0].land_measurement.value == 'c')
	{
		var val1=eval(area1)*eval(req);
		
		document.forms[0].txt_cost.value=Math.round(eval(val1));
	}
}

function callyield()
{
	var val1="";
	var area=document.forms[0].txt_area.value;
	var acre=document.forms[0].txt_acre.value;
	if(area=="")
	{
		area=0;
	}
	if(acre=="")
	{
		acre=0;
	}
	var area1=area+"."+acre;
	var value=document.forms[0].txt_value.value;
	if(value=="")
	{
		value=0;
	}
	if(document.forms[0].txt_value.value=="")
	{
		document.forms[0].txt_value.value ="0";
	}
	var yield=document.forms[0].txt_avg_yield.value;
	if(yield=="")
	{
		yield=0;
	}
	if(document.forms[0].txt_avg_yield.value=="")
	{
		document.forms[0].txt_avg_yield.value ="0";
	}
	if(document.forms[0].land_measurement.value == 'g')
	{
		var areaval1=parseFloat(area)*parseFloat(value);	
		if(parseFloat(acre)>0)
		{
			var ff=parseFloat(acre)/40;
			var areaval2=parseFloat(ff)*parseFloat(value);
		}
		else
		{
			var areaval2=0;
		}
		var val=parseFloat(areaval1)+parseFloat(areaval2);	
		document.forms[0].txt_grossincome.value = parseFloat(val)*parseFloat(yield);
		 var gross_inc= document.forms[0].txt_grossincome.value;
	  var pos= gross_inc.indexOf(".");
		if(pos>0)
		{
		gross_inc =gross_inc.substring(0,pos+3);
     			
		}
		document.forms[0].txt_grossincome.value=NanNumber(gross_inc);
	  
	}
	if(document.forms[0].land_measurement.value == 'c')
	{
		if(parseFloat(acre)>0)
		{
			val1=parseFloat(area1)*parseFloat(value);
		}
		else
		{
	 		val1=parseFloat(area)*parseFloat(value);
		}
		document.forms[0].txt_grossincome.value =parseFloat(val1)*parseFloat(yield);
		roundtxt(document.forms[0].txt_grossincome);
	}
}

function callTotal()
{	
	var netincome=0.00;
	
	if(document.forms[0].txt_grossincome.value=="")
	{
		document.forms[0].txt_grossincome.value ="0.00";
	}
	
	if(document.forms[0].txt_cost.value =="")
	{
		document.forms[0].txt_cost.value ="0.00";
	}
	if(document.forms[0].txt_irrigated.value=="")
	{
		document.forms[0].txt_irrigated.value ="0.00";
	}
	
	netincome=Math.round((document.forms[0].txt_grossincome.value)- (document.forms[0].txt_cost.value));
	
	document.forms[0].txt_netincome.value=NanNumber(netincome);
	roundtxt(document.forms[0].txt_netincome);
	
}

function selectValues(val1, val2, val3, val4, val5, val6, val7, val8, val9,val10,val11,val12,val14,val15,val16,val17,val18,val19)
{

	var temp=val15;
 
	var index=val15.lastIndexOf(".");
	
	if(index != -1){
		temp = temp.substring(0,index); 
	}
	else {
		temp=temp;
	}
	
	document.forms[0].selsno.value = val3;
	document.forms[0].hidcroptype.value = val2;  
	document.forms[0].txt_crop.value = val4;  
	//document.forms[0].txt_area.value = val5;
	document.forms[0].txt_area.value = temp;
	document.forms[0].txt_avg_yield.value = val6;
	document.forms[0].txt_cost.value = val7;
	document.forms[0].txt_grossincome.value = val8;
	document.forms[0].txt_netincome.value = val9;
	document.forms[0].season.value = val10;
	document.forms[0].sel_irrigated.value = val11;
	document.forms[0].txt_irrigated.value = val12;
	document.forms[0].txt_acre.value = val14;
	//document.forms[0].txt_acre.value = val15;
	//document.forms[0].txt_total_area.value = val15;
	document.forms[0].txt_value.value = val16;
	document.forms[0].txt_month_sowing.value=val18;
	document.forms[0].txt_month_harvesting.value=val19;
	
	/*if(eval(document.forms[0].season.value)=="3")
	{
		document.forms[0].land_holdings_su.value=eval(document.forms[0].land_holdings_su.value)-eval(document.forms[0].txt_total_area.value);
	}
	if(eval(document.forms[0].season.value)=="1")
	{
		document.forms[0].land_holdings_kh.value=eval(document.forms[0].land_holdings_kh.value)-eval(document.forms[0].txt_total_area.value);
	}
	if(eval(document.forms[0].season.value)=="2")
	{
		document.forms[0].land_holdings_rb.value=eval(document.forms[0].land_holdings_rb.value)-eval(document.forms[0].txt_total_area.value);
	}
	if(eval(document.forms[0].season.value)=="4")
	{
		document.forms[0].land_holdings_an.value=eval(document.forms[0].land_holdings_an.value)-eval(document.forms[0].txt_total_area.value);
	}
	if(eval(document.forms[0].season.value)=="5")
	{

		document.forms[0].land_holdings_pe.value=eval(document.forms[0].land_holdings_pe.value)-eval(document.forms[0].txt_total_area.value);
	}*/
	if(document.forms[0].btnenable.value=="Y")
	{
		enableButtons(true,false,true,false,false,true);	
	}
}

//done by paul

function addGuntas(value3,value4)
{
	var total1="", total2="",total3="",value1="",value2="",tempValue="";
	var a=new Array();
	var b = new Array();
	
	value1 =new String(value3);
	value2 =new String(value4);
	
	if(value1.indexOf(".")!=-1 && value2.indexOf(".")!=-1)
	{	
		a = value1.split(".");
		b = value2.split(".");
		
		total1 = parseFloat(a[0])+parseFloat(b[0]);
		total2 = parseFloat(a[1])+parseFloat(b[1]);
		
		if(eval(total2)>eval(39))
		{
			tempValue = parseInt(total2)%40;
			total3 = parseFloat(total2)/parseFloat(40);
			total1 = parseInt(total1)+parseInt(total3);
			
			if(tempValue.length==1)
			{
				total1 = total1+".0"+tempValue
			}
			else
			{
				total1 = total1+"."+tempValue
			}
		}
		else
		{
			total1 = total1+"."+total2;	
		}
		
		return total1;
	}
	else
	{
		total3 = value1 + value2;
		return total3;
	}
	
}

function checkAreaLength()
{
	
	var alertMsgs = new Array();
	
	alertMsgs[0]="";
	alertMsgs[1]="Kharif";
	alertMsgs[2]="Rabi";
	alertMsgs[3]="Summer";
	alertMsgs[4]="Annual";
	alertMsgs[5]="Perrenial";
	
	var snoLength="",checkedSno="";
	var totalLandHolding="0.00";

	var landHolding = "<%=Helper.correctNull((String)hshValues.get("totLandHolding"))%>";
	var totalAcre = document.forms[0].txt_acre.value;
	var totalArea = document.forms[0].txt_area.value
	if(totalAcre=="")
		totalAcre = "00";
	if(totalArea=="")
		totalArea ="0";	
	
	if(eval(totalAcre)!=0 && eval(totalAcre)<=9)
	{
		totalAcre="0"+totalAcre;
	}
	var textAreaValue = totalArea+"."+totalAcre;
	
	var season = document.forms[0].season.value;
	var meas=document.forms[0].land_measurement.value;
	if(eval(textAreaValue)>eval(landHolding))
	{
	 	alert("Land Holdings of "+alertMsgs[season]+" crops is exceeding total land holdings value");
		return true;
	}
	
	if(document.forms[0].checkArea)
	{
		//this condition to find the data is edited
		if(document.forms[0].sno)
		{
			snoLength = document.forms[0].sno.length;
			if(snoLength==null)
			{
				if(document.forms[0].sno.checked==true)
				{
					checkedSno = "1";
				}
			}
			else
			{
				for(var l =0;l<snoLength;l++)
				{
					if(document.forms[0].sno[l].checked==true)
					{
						checkedSno = ""+l
					}
				}
			}
		}
			
			//ending the loop
		len = document.forms[0].checkArea.length;
		if(len==null)
		{
			var checkArea = document.forms[0].checkArea.value;
		 	var total = document.forms[0].hidSeasonValue.value;
		 	
		 	if(eval(season)==eval(total)) 
		 	{
		 		if(checkedSno=="")
			 	{	
				 	if(meas == 'c')
			 		{
			 			//this addition is for cents
			 			totalLandHolding = eval(textAreaValue) + eval(checkArea);
			 		}
			 		else
			 		{	
			 			//this addition for guntas
			 			totalLandHolding = addGuntas(textAreaValue,checkArea);
			 		}
			 	}
			 	else
			 	{
			 		totalLandHolding = eval(textAreaValue)
			 	}	
		 		if(eval(totalLandHolding)>eval(landHolding))
				{
				 		alert("Land Holdings of "+alertMsgs[season]+" crops is exceeding total land holdings value");
						return true;
				 }
		 		
		 	 }
		 	
		 }
		else
		{
			if(meas == 'c')
			{
				//this addition for cents
				
				totalLandHolding = eval(totalLandHolding) + eval(textAreaValue)
			}
			else
			{
				// this addition for guntas
				
				totalLandHolding = addGuntas(totalLandHolding,textAreaValue);
			}
			for(var i =0;i<len;i++)
			{
				if(checkedSno!=i)
				{
					if(eval(season)==eval(document.forms[0].hidSeasonValue[i].value))
			 		{
			 			if(meas == 'c')
			 			{
			 				totalLandHolding = eval(totalLandHolding)+eval(document.forms[0].checkArea[i].value) 
			 			}
			 			else
			 			{
			 				totalLandHolding = addGuntas(totalLandHolding,document.forms[0].checkArea[i].value);
			 			}
			 		}
			 	}	
			}
			
			if(eval(totalLandHolding)>eval(landHolding))
			{
				alert("Land Holdings of "+alertMsgs[season]+", crops is exceeding total land holdings value");
				return true;
			 }
			
		}
	}	
	
	return false
}

function doSave()
{	
    callTotal();
    callcost();
    callyield();
    
    
    if(checkAreaLength())
    	return true;
		
	if(document.forms[0].season.value==0)
	{
		alert("Select Season");
		return;
	}	
    
	var len = document.forms[0].season.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].season.options[i].selected==true)
		 {
			 document.forms[0].season1.value = document.forms[0].season.options[i].text; 
			break;
		 }
	}
	enableButtons(true, true, true, true, true,false);	
	document.forms[0].hidBeanId.value="agrcrops";		
	document.forms[0].hidSourceUrl.value="/action/agrcropproposed.jsp";
	document.forms[0].hidBeanMethod.value="updatePreviousseasonData";
	document.forms[0].hidBeanGetMethod.value="getPreviousseasonData";
	document.forms[0].hidcroptype.value="PO";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{
 	disableFields(false);
	document.forms[0].txt_netincome.readOnly =true;
	document.forms[0].txt_grossincome.readOnly =true;
	document.forms[0].txt_cost.readOnly =false;
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="update";
	enableButtons(true, true, false, false, true,true);	
	document.forms[0].hidcroptype.value="PO";
}

function doNew()
{
	disableFields(false);
	enableButtons(true, true, false, false, true,true);	
	document.forms[0].hidcroptype.value="PO";
	//document.forms[0].txt_cost_cult.value="";
	document.forms[0].txt_crop.value="";
	document.forms[0].txt_area.value="";
	document.forms[0].txt_avg_yield.value="";
	document.forms[0].txt_cost.value="";
	document.forms[0].txt_cost.readOnly=true;
	document.forms[0].txt_grossincome.value="";
	document.forms[0].txt_grossincome.readOnly=true;
	document.forms[0].txt_irrigated.value="";
	document.forms[0].txt_netincome.value="";
	document.forms[0].txt_netincome.readOnly=true;
	document.forms[0].txt_month_sowing.value="0";
	document.forms[0].txt_month_harvesting.value="0";
	
	
	
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="insert";
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].checked=false;
		}	  
	}
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		disableFields(false);
		enableButtons(false, false, true, true, false);	
		document.forms[0].hidcroptype.value="PO";
		//document.forms[0].txt_cost_cult.value="";
		document.forms[0].txt_crop.value="";
		document.forms[0].txt_area.value="";
		document.forms[0].txt_avg_yield.value="";
		document.forms[0].txt_cost.value="";
		document.forms[0].txt_value.value="";
		document.forms[0].txt_acre.value="";
		document.forms[0].season.value="0";
		document.forms[0].sel_irrigated.value="0";
		document.forms[0].txt_cost.readOnly=true;
		document.forms[0].txt_grossincome.value="";
		document.forms[0].txt_grossincome.readOnly=true;
		document.forms[0].txt_irrigated.value="";
		document.forms[0].txt_netincome.value="";
		document.forms[0].txt_netincome.readOnly=true;
		document.forms[0].txt_month_sowing.value="";
		document.forms[0].txt_month_harvesting.value="";
		document.forms[0].hidAction.value ="insert";
		for(var i=0;i<document.forms[0].length;i++)
		{
			if(document.forms[0].elements[i].type=='radio')
			{
				document.forms[0].elements[i].checked=false;
			}	  
		}
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidBeanGetMethod.value="getPreviousseasonData";
		document.forms[0].action=appURL +"action/agrcropproposed.jsp";
		document.forms[0].submit(); 	
	}
	
	
	
}

function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidcroptype.value="PO";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidBeanMethod.value="updatePreviousseasonData";
		document.forms[0].hidBeanGetMethod.value="getPreviousseasonData";		
		document.forms[0].hidSourceUrl.value="action/agrcropproposed.jsp";	
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
	document.forms[0].hidcroptype.value="PO";
}

function call_page(url)
{	
	document.forms[0].action=appURL+"action/"+url;
	document.forms[0].submit();	
}

function checkguntcent()
{
	if(document.forms[0].land_measurement.value == 'g')
	{
		if(document.forms[0].txt_acre.value > 39)
		{
		 	alert("Guntas value cannot be greater than 39");
		 	document.forms[0].txt_acre.value = "";
		 	document.forms[0].txt_acre.focus();
		}
	}
}
</script>


</head>
<body onload="onloading();callTotal()" >
<form name="frmpri" method="post" class="normal">
<br>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1" align="center">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="2"
									class="outertable">
                            <tr align="center" class="dataheader"> 
                              <%String measurementtype = Helper.correctNull((String) hshValues
					.get("land_measurement"));
			String measurementval = "";
			if (measurementtype.equalsIgnoreCase("c")) {

				measurementval = "Cents";
			} else {
				measurementval = "Guntas";
			}

			%>
                              <td width="12%" >Season <span class="mantatory">*</span></td>
                              <td width="21%" >Crop</td>
                              <td width="16%" align="center" valign="middle"
											>Area in <br>
                                Acre<br>
                                </td>
                              <td width="16%" >Area 
                                in <%=measurementval%> <br>
                               </td>
                              <td width="16%" >Irrigated/Rainfed</td>
                              <td width="16%" >Loan Required/acre(Rs.)</td>
                              <td width="16%" >Total Amount                                
                                of loan(Rs.)</td>
                               
                                 <td width="16%" >Month of Sowing                              
                                </td>
                               <td width="16%" >Month of Harvesting                              
                                </td>
                              
                              
                              <td width="10%" >Average Yield/acre 
                                Qntal</td><!--/Tons /B/N-->
                              <td width="14%" >Value of 
                                Produce/Qntal(Rs)</td>
                              <td width="14%" >Gross Income 
                                (Expected)</td>
                              <td width="11%" >Net Income 
                                (Expected)</td>
                            </tr>
                            <tr align="center" > 
                              <td width="12%" align="center"><select
											name="season">
                                  <option value="0" selected>---Select---</option>
                                  <option value="1">Kharif</option>
                                  <option value="2">Rabi</option>
                                  <option value="3">Summer</option>
                                  <option value="4">Annual</option>
                                  <option value="5">Perrenial</option>
                                </select></td>
                              <td width="21%" align="center"><input
											type="text" name="txt_crop" value="" maxlength="60" size="20"></td>
                              <td width="16%" align="center" valign="middle"
											>
                                <input type="text" name="txt_area"
											 value="" maxlength="3" size="10"
											style="text-align:right" onKeyPress="allowInteger()" onBlur="check()">
                              </td>
                              <td width="16%"><input type="text"
											name="txt_acre" value="" maxlength="2" size="10"
											style="text-align:right" onKeyPress="allowInteger()"
											onBlur="checkguntcent();check()"></td>
                              <td width="16%"><select name="sel_irrigated"
											onChange="">
                                  <option value="0" selected>---Select---</option>
                                  <option value="1">Irrigated</option>
                                  <option value="2">Rainfed</option>
                                </select></td>
                              <td width="16%"><input type="text"
											name="txt_irrigated" value="" size="15" maxlength="7"
											onKeyPress="allowInteger()" style="text-align:right"
											onBlur="callcost();check()"></td>
                              <td width="16%">
                                <input type="text"
											name="txt_cost" value="" size="12" maxlength="9"
											onKeyPress="allowNumber(this)" style="text-align:right"
											onBlur="">
                              </td>
                             <!--  <td width="10%"><input type="text"
											name="txt_cost_cult" value="" size="12" maxlength="9"
											onKeyPress="allowNumber(this)" style="text-align:right"
											onBlur=""></td> -->
                              
                               <td width="10%">
                                <select name="txt_month_sowing"
											onChange="">
                                  <option value="0" selected>---Select---</option>
                                  <option value="1">Jan</option>
                                  <option value="2">Feb</option>
                                  <option value="3">Mar</option>
                                  <option value="4">April</option>
                                  <option value="5">May</option>
                                  <option value="6">Jun</option>
                                  <option value="7">Jul</option>
                                  <option value="8">Aug</option>
                                  <option value="9">Sep</option>
                                  <option value="10">Oct</option>
                                  <option value="11">Nov</option>
                                  <option value="12">Dec</option>
                                </select>
                              </td>
										   
                              <td width="10%">
                                <select name="txt_month_harvesting"
											onChange="">
                                  <option value="0" selected>---Select---</option>
                                  <option value="1">Jan</option>
                                  <option value="2">Feb</option>
                                  <option value="3">Mar</option>
                                  <option value="4">April</option>
                                  <option value="5">May</option>
                                  <option value="6">Jun</option>
                                  <option value="7">Jul</option>
                                  <option value="8">Aug</option>
                                  <option value="9">Sep</option>
                                  <option value="10">Oct</option>
                                  <option value="11">Nov</option>
                                  <option value="12">Dec</option>
                                </select>
                              </td>	
                                                        
                              
							<td width="10%"><input type="text"
											name="txt_avg_yield" value="" size="12" maxlength="6"
											onKeyPress="allowNumber(this)" style="text-align:right"
											onBlur=""></td>
								<td width="14%"><lapschoice:CurrencyTag
											name="txt_value" value='' size="12" maxlength="7"
											
											onBlur="callyield();callTotal()"/></td>
                              <td width="14%"><lapschoice:CurrencyTag
											name="txt_grossincome" value='' size="12" maxlength="9" onBlur="callyield();callTotal()"
											/></td>
                              <td width="11%"><input type="text"
											name="txt_netincome" value="" onKeyPress=""  onBlur="callyield();callTotal()" size="12"
											maxlength="9" style="text-align:right" readOnly></td>
                            </tr>
                          </table>
								
							
			<br>				
	<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
		<br>				
							

								<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
									<tr class="dataheader">
										
                              <td width="2%" >&nbsp;</td>
										
                              <td width="8%" align="center" >Season</td>
										
                              <td width="11%" align="center" >Crop</td>
										
                              <td width="10%" align="center" >Irrigated/Rainfed</td>
										
                              <td width="11%" align="center" >Area 
                                </td>
                              <td width="14%" align="center" >Average 
                                Yield </td>
										
                              <td width="13%" align="center" >Gross 
                                Income </td>
										
                              <td width="13%" align="center" >Total 
                                Amount of loan</td>
										
                              <td width="18%" align="center" >
                              Net 
                                Income </td>
									</tr>
									<%if (vecData != null) {

				%>
									<%

			}
			String strSno = "";

			double dblTotcost = 0.00;
			double dblTotcost1 = 0.00;
			double dblTotcost2 = 0.00;
			for (int i = 0; i < vecData.size(); i++) {
				vecRow = (ArrayList) vecData.get(i);
				if (vecRow != null) {
					strSno = Helper.correctNull((String) vecRow.get(2));

					dblTotcost = dblTotcost
							+ Double.parseDouble((String) vecRow.get(8));
					dblTotcost1 = dblTotcost1
							+ Double.parseDouble((String) vecRow.get(7));
					dblTotcost2 = dblTotcost2
							+ Double.parseDouble((String) vecRow.get(6));
					String strcroptype = Helper.correctNull((String) vecRow.get(1));

					%>
									<tr align="center"class="datagrid" >
										
                              <td width="2%"> 
								<input type="radio"
								name="sno" style="border-style:none"
								onClick="selectValues('<%=Helper.correctNull((String) vecRow.get(0))%>', 
								'<%=Helper.correctNull((String) vecRow.get(1)) %>',
								'<%=Helper.correctNull((String) vecRow.get(2))%>',
								'<%=Helper.correctNull((String) vecRow.get(3))%>', 
								'<%=Helper.correctNull((String) vecRow.get(4))%>',
								'<%=Helper.correctNull((String) vecRow.get(5))%>',
								'<%=Helper.correctNull((String) vecRow.get(6))%>',
								'<%=Helper.correctNull((String) vecRow.get(7))%>',
                              	'<%=Helper.correctNull((String) vecRow.get(8))%>', 
                              	'<%=Helper.correctNull((String) vecRow.get(11))%>',
                              	'<%=Helper.correctNull((String) vecRow.get(14))%>',
                              	'<%=Helper.correctNull((String) vecRow.get(15))%>',
                              	'<%=Helper.correctNull((String) vecRow.get(16))%>',
                              	'<%=Helper.correctNull((String) vecRow.get(17))%>',
                              	'<%=Helper.correctNull((String) vecRow.get(18))%>',
                              	'<%=Helper.correctNull((String) vecRow.get(19))%>',
                           		'<%=Helper.correctNull((String) vecRow.get(20))%>', 
                           		'<%=Helper.correctNull((String) vecRow.get(21))%>');">
								<input type="hidden" name="hid" value="<%=strSno%>"></td>
								<td align="center" valign="middle">
								<% seasn = Helper.correctNull((String) vecRow.get(11));
					if (seasn.equalsIgnoreCase("1"))
						out.println("Kharif");
					else if (seasn.equalsIgnoreCase("2"))
						out.println("Rabi");
					else if (seasn.equalsIgnoreCase("3"))
						out.println("Summer");
					else if (seasn.equalsIgnoreCase("4"))
						out.println("Annual");
					else if (seasn.equalsIgnoreCase("5"))
						out.println("Perrenial");
						
						%>
						<input type=hidden name="hidSeasonValue" value="<%=seasn%>">
						</td>
										<td align="center" valign="middle"
											style="text-align:left">&nbsp;<%=Helper.correctNull((String) vecRow.get(3))%></td>
										<td align="center" valign="middle"
											style="text-align:left">&nbsp; <%String irri = Helper.correctNull((String) vecRow
							.get(14));
					if (irri.equalsIgnoreCase("1"))
						out.println("Irrigated");
					else if (irri.equalsIgnoreCase("2"))
						out.println("Rainfed");

					%></td>
										<td valign="middle" style="text-align:right">&nbsp;
										<%=Helper.correctNull((String) vecRow.get(17))%>
										<input type=hidden name="checkArea" value="<%=Helper.correctNull((String) vecRow.get(17))%>">	
											</td>
										<td valign="middle" style="text-align:right">&nbsp;
										<%=Helper.correctNull((String) vecRow.get(5))%></td>
										<td valign="middle" style="text-align:right"><%=Helper.correctNull((String) vecRow.get(7))%></td>
										<td valign="middle" style="text-align:right"><%=Helper.correctNull((String) vecRow.get(6))%></td>
										<td valign="middle" style="text-align:right"><%=Helper.correctNull((String) vecRow.get(8))%></td>
									</tr>
									<%}
			}

			%>
									<tr align="center" class="datagrid">
										<td colspan="6" align="right" ><b>
											Total</b>&nbsp;: </td>
										<td style="text-align:right">&nbsp; <%=Helper.formatDoubleValue(dblTotcost1)%></td>
										<td style="text-align:right">&nbsp;<%=Helper.formatDoubleValue(dblTotcost2)%></td>
										<td style="text-align:right">&nbsp;<%=Helper.formatDoubleValue(dblTotcost)%></td>
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
<lapschoice:agrihiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="season1"> 
<input type="hidden" name="land_measurement" value="<%=Helper.correctNull((String)hshValues.get("land_measurement"))%>">
<input type="hidden" name="hidcroptype" value=""> 
<input type="hidden" name="hidmeasurementval" value="<%=measurementval%>">
<input type="hidden" name="selsno" value=""> 
<input type="hidden" name="hidRecordflag" > 
</form>
</body>
</html>