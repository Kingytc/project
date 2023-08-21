<%@include file="../share/directives.jsp"%>
<%
String schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
%>
<%

			String rowSurplus1[] = new String[6];
			String rowSurplus2[] = new String[6];
			String rowSurplus3[] = new String[6];
			String rowSurplus4[] = new String[6];
			String rowSurplus5[] = new String[6];
			String rowSurplus6[] = new String[6];
			String rowSurplus7[] = new String[6];
			String rowSurplus8[] = new String[6];
			String rowSurplus9[] = new String[6];
			String rowSurplus10[] = new String[6];
			String rowSurplus11[] = new String[6];
			String rowSurplus12[] = new String[6];
			String rowSurplus13[] = new String[6];

			ArrayList vecDataSur = new ArrayList();

			int vecsize = 0;
			if (hshValues != null) {
				vecDataSur = (ArrayList) hshValues.get("vecDataSurplus");

				ArrayList s1 = new ArrayList();
				if (vecDataSur != null && vecDataSur.size() != 0) {
					vecsize = vecDataSur.size();
					for (int i = 0; i < vecsize; i++) {
						s1 = (ArrayList) vecDataSur.get(i);
						rowSurplus1[i] = (String) s1.get(2);
						rowSurplus2[i] = (String) s1.get(3);
						rowSurplus3[i] = (String) s1.get(4);
						rowSurplus4[i] = (String) s1.get(5);
						rowSurplus5[i] = (String) s1.get(6);
						rowSurplus6[i] = (String) s1.get(7);
						rowSurplus7[i] = (String) s1.get(8);
						rowSurplus8[i] = (String) s1.get(9);
						rowSurplus9[i] = (String) s1.get(10);
						rowSurplus10[i] = (String) s1.get(11);
						rowSurplus11[i] = (String) s1.get(12);
						rowSurplus12[i] = (String) s1.get(13);
						rowSurplus13[i] = (String) s1.get(14);
					}

				}
			}
%>
<html>
<head>
<title>Mechanised Boat1</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var schemetype="<%=schemetype%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function callonload()
{
	disableFields(true);
	calquantitytotal();
	caltotal();
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=schemetype;
	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
			enableButtons(false, true, true, true, true, false);
		}
		else
		{
			enableButtons(true, true, true, true, true, false);
		}
	}
	else
	{
		enableButtons(true, true, true, true, true, false);
	}

}

function calquantitytotal()
    {
	for(var i=0; i<6; i++)
	{
		if(document.forms[0].txt_qty1[i].value == "")
		{
			document.forms[0].txt_qty1[i].value ="0";
		}
		if(document.forms[0].txt_value1[i].value  =="")
		{
			document.forms[0].txt_value1[i].value ="0";
		}
		
		document.forms[0].txt_income1[i].value = eval(document.forms[0].txt_qty1[i].value) * eval(document.forms[0].txt_value1[i].value);
		roundtxt(document.forms[0].txt_income1[i]);
		roundtxt(document.forms[0].txt_value1[i]);
	   
		
		if(document.forms[0].txt_qty2[i].value == "")
		{
			document.forms[0].txt_qty2[i].value ="0";
		}
		if(document.forms[0].txt_value2[i].value  =="")
		{
			document.forms[0].txt_value2[i].value ="0";
		}
		
		document.forms[0].txt_income2[i].value = eval(document.forms[0].txt_qty2[i].value) * eval(document.forms[0].txt_value2[i].value);
		roundtxt(document.forms[0].txt_income2[i]);
		roundtxt(document.forms[0].txt_value2[i]);
		
		if(document.forms[0].txt_qty3[i].value == "")
		{
			document.forms[0].txt_qty3[i].value ="0";
		}
		if(document.forms[0].txt_value3[i].value  =="")
		{
			document.forms[0].txt_value3[i].value ="0";
		}
		
		document.forms[0].txt_income3[i].value = eval(document.forms[0].txt_qty3[i].value) * eval(document.forms[0].txt_value3[i].value);
		roundtxt(document.forms[0].txt_income3[i]);
		roundtxt(document.forms[0].txt_value3[i]);
		
		
		
		if(document.forms[0].txt_qty4[i].value == "")
		{
			document.forms[0].txt_qty4[i].value ="0";
		}
		if(document.forms[0].txt_value4[i].value  =="")
		{
			document.forms[0].txt_value4[i].value ="0";
		}
		
		document.forms[0].txt_income4[i].value = eval(document.forms[0].txt_qty4[i].value) * eval(document.forms[0].txt_value4[i].value);
		roundtxt(document.forms[0].txt_income4[i]);
		//roundtxt(document.forms[0].txt_qty4[i]);
		roundtxt(document.forms[0].txt_value4[i]);
		
		}
	
}
function caltotal()
{
var totalquantity1=0;
var totalquantity2=0;
var totalquantity3=0;
var totalquantity4=0;

var totalvalue1=0;
var totalvalue2=0;
var totalvalue3=0;
var totalvalue4=0;

var totalincome1=0;
var totalincome2=0;
var totalincome3=0;
var totalincome4=0;

 for(var i=0; i<6; i++)
	{
	var varquantity1=document.forms[0].txt_qty1[i].value;
	if(varquantity1=="")
		{
		varquantity1=0;
		}
	totalquantity1=eval(totalquantity1)+eval(varquantity1);
	

	
	
	
	var varquantity2=document.forms[0].txt_qty2[i].value;
	if(varquantity2=="")
		{
		varquantity2=0;
		}
	totalquantity2=eval(totalquantity2)+eval(varquantity2);
	//	roundtxt(document.forms[0].totalquantity2);
	
	var varquantity3=document.forms[0].txt_qty3[i].value;
	if(varquantity3=="")
		{
		varquantity3=0;
		}
	totalquantity3=eval(totalquantity3)+eval(varquantity3);
	//	roundtxt(document.forms[0].totalquantity3);
	
	var varquantity4=document.forms[0].txt_qty4[i].value;
	if(varquantity4=="")
		{
		varquantity4=0;
		}
	totalquantity4=eval(totalquantity4)+eval(varquantity4);
		//roundtxt(document.forms[0].totalquantity4);
	
	
	var varvalue1=document.forms[0].txt_value1[i].value;
	if(varvalue1=="")
		{
		varvalue1=0;
		}
	totalvalue1=eval(totalvalue1)+eval(varvalue1);
	//	roundtxt(document.forms[0].totalvalue1);
	
	var varvalue2=document.forms[0].txt_value2[i].value;
	if(varvalue2=="")
		{
		varvalue2=0;
		}
	totalvalue2=eval(totalvalue2)+eval(varvalue2);
//	roundtxt(document.forms[0].totalvalue2);
	
	var varvalue3=document.forms[0].txt_value3[i].value;
	if(varvalue3=="")
		{
		varvalue3=0;
		}
	totalvalue3=eval(totalvalue3)+eval(varvalue3);
	//roundtxt(document.forms[0].totalvalue3);
	
	var varvalue4=document.forms[0].txt_value4[i].value;
	if(varvalue4=="")
		{
		varvalue4=0;
		}
	totalvalue4=eval(totalvalue4)+eval(varvalue4);
	//roundtxt(document.forms[0].totalvalue4);
	
	
	var varincome1=document.forms[0].txt_income1[i].value;
	if(varincome1=="")
		{
		varincome1=0;
		}
	totalincome1=eval(totalincome1)+eval(varincome1);
	//roundtxt(document.forms[0].totalincome1);
	
	var varincome2=document.forms[0].txt_income2[i].value;
	if(varincome2=="")
		{
		varincome2=0;
		}
	totalincome2=eval(totalincome2)+eval(varincome2);
//roundtxt(document.forms[0].totalincome2);
	
	var varincome3=document.forms[0].txt_income3[i].value;
	if(varincome3=="")
		{
		varincome3=0;
		}
	totalincome3=eval(totalincome3)+eval(varincome3);
	//roundtxt(document.forms[0].totalincome3);
	
	var varincome4=document.forms[0].txt_income4[i].value;
	if(varincome4=="")
		{
		varincome4=0;
		}
	totalincome4=eval(totalincome4)+eval(varincome4);
//	roundtxt(document.forms[0].totalincome4);
    
    }
   	document.forms[0].txt_total_qty1.value=totalquantity1;
    document.forms[0].txt_total_qty2.value=totalquantity2;
    document.forms[0].txt_total_qty3.value=totalquantity3;
	document.forms[0].txt_total_qty4.value=totalquantity4;
    document.forms[0].txt_total_value1.value=totalvalue1;
    document.forms[0].txt_total_value2.value=totalvalue2;
    document.forms[0].txt_total_value3.value=totalvalue3;
	document.forms[0].txt_total_value4.value=totalvalue4;
	document.forms[0].txt_total_income1.value=totalincome1;
    document.forms[0].txt_total_income2.value=totalincome2;
    document.forms[0].txt_total_income3.value=totalincome3;
	document.forms[0].txt_total_income4.value=totalincome4;
	roundtxt(document.forms[0].txt_total_income1);
    roundtxt(document.forms[0].txt_total_income2);
    roundtxt(document.forms[0].txt_total_income3);
	roundtxt(document.forms[0].txt_total_income4);
	roundtxt(document.forms[0].txt_total_value1);
    roundtxt(document.forms[0].txt_total_value2);
    roundtxt(document.forms[0].txt_total_value3);
	roundtxt(document.forms[0].txt_total_value4);
	//roundtxt(document.forms[0].txt_value1[i]);
   // roundtxt(document.forms[0].txt_value2[i]);
   // roundtxt(document.forms[0].txt_value3[i]);
	//roundtxt(document.forms[0].txt_value4[i]);
	
	
	
	
	
}







function displayFishName()
{
	for(var i=0; i<5; i++)
	{
		document.forms[0].txt_fish_name_disp[i].value=document.forms[0].txt_fish_type[i].value;
	}
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text'  )
	 	{
	 		if(document.forms[0].elements[i].name=='txt_income1' || document.forms[0].elements[i].name=='txt_income2' || document.forms[0].elements[i].name=='txt_income3' || document.forms[0].elements[i].name=='txt_income4')
	 			{
	 			document.forms[0].elements[i].readOnly=true;
	 			}
	 		else
	 			{
				document.forms[0].elements[i].readOnly=val;
				}
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		 document.forms[0].txt_total_income1.readOnly=true;
         document.forms[0].txt_total_income2.readOnly=true;
         document.forms[0].txt_total_income3.readOnly=true;
	     document.forms[0].txt_total_income4.readOnly=true;
		 
		 
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
	var varbstate=false;
	for(var j=0;j<document.forms[0].txt_fish_type.length;j++)
	{
		if(document.forms[0].txt_fish_type[j].value == "")
		{
			varbstate=true;
		}
		else
		{
			varbstate=false;
			break;
		}
	}
	if(varbstate)
	{
		alert("Enter atleast one value");
		document.forms[0].txt_fish_type[0].focus();
		return;
	}
	for(var i=0;i<5;i++)
	{
		if(document.forms[0].txt_qty1[i].value=="")
		{
			document.forms[0].txt_qty1[i].value="0";
		}
		if(document.forms[0].txt_value1[i].value=="")
		{
			document.forms[0].txt_value1[i].value="0";
		}
		
		if(document.forms[0].txt_qty2[i].value=="")
		{
			document.forms[0].txt_qty2[i].value="0";
		}
		if(document.forms[0].txt_value2[i].value=="")
		{
			document.forms[0].txt_value2[i].value="0";
		}
		
		if(document.forms[0].txt_qty3[i].value=="")
		{
			document.forms[0].txt_qty3[i].value="0";
		}
		if(document.forms[0].txt_value3[i].value=="")
		{
			document.forms[0].txt_value3[i].value="0";
		}
		
		if(document.forms[0].txt_qty4[i].value=="")
		{
			document.forms[0].txt_qty4[i].value="0";
		}
		if(document.forms[0].txt_value4[i].value=="")
		{
			document.forms[0].txt_value4[i].value="0";
		}
		
	}
	enableButtons(true, true, true, true, true, false);
	document.forms[0].hidAction.value ="update";
	document.forms[0].hidBeanId.value="agriculture";		
	document.forms[0].hidSourceUrl.value="/action/agrMachBoatSurplus.jsp";
	document.forms[0].hidBeanMethod.value="updateCatchesSurplusList";
	document.forms[0].hidBeanGetMethod.value="getCatchesSurplusList";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	
}

function doEdit()
{
 	disableFields(false);
	enableButtons(true, false, false, false, true, true);
	
	   
		
		
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agriculture";
		document.forms[0].hidBeanGetMethod.value="getCatchesSurplusList";
		document.forms[0].action=appURL+"action/agrMachBoatSurplus.jsp";
		document.forms[0].submit(); 		
	}	
}
function doDelete()
{
var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appURL+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updateCatchesSurplusList";
	document.forms[0].hidBeanGetMethod.value="getCatchesSurplusList";
	document.forms[0].hidBeanId.value="agriculture";
	document.forms[0].hidSourceUrl.value="action/agrMachBoatSurplus.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();	
	}
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
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
      <td class="page_flow">Home -> Agriculture -> Income
        </td>
	</tr>
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="205" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellpadding="5" cellspacing="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td> 
						<table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable border1">
							<tr>
								<td colspan="3">
								<table border="0" align="center" cellspacing="1" cellpadding="3" width="100%" class="outertable">
									<tr class="dataheader">
										<td colspan="14"><b>Computation of Income </b></td>
									</tr>
									<tr class="dataheader">
										<td width="3%">&nbsp;</td>
										<td width="11%">&nbsp;</td>
										<td colspan="3">
										<div align="center">I Year</div>
										</td>
										<td colspan="3">
										<p align="center">II Year</p>
										</td>
										<td colspan="3">
										<div align="center">III Year</div>
										</td>
										<td colspan="3">
										<div align="center">IV Year</div>
										</td>
									</tr>
									<tr class="dataheader">
										<td width="3%">
										<div align="center">Sl.No</div>
										</td>
										<td width="11%">
										<div align="left">Particulars (Type of Fish )</div>
										</td>
										<td width="7%" align="center">Quantity in Kgs</td>
										<td width="6%" align="center">Value per Kg in Rs.</td>
										<td width="7%" align="center">Income in Rs</td>
										<td width="8%" align="center">Quantity in Kgs</td>
										<td width="6%" align="center">Value per Kg in Rs.</td>
										<td width="7%" align="center">Income in Rs</td>
										<td width="8%" align="center">Quantity in Kgs</td>
										<td width="6%" align="center">Value per Kg in Rs.</td>
										<td width="8%" align="center" nowrap="nowrap">Income in Rs</td>
										<td width="8%" align="center">Quantity in Kgs</td>
										<td width="6%" align="center">Value per Kg in Rs.</td>
										<td width="9%" align="center">Income in Rs</td>
									</tr>
									<!--<tr> 
                                    <td width="2%"> 
                                      <div align="center">01</div>
                                    </td>
                                    <td width="11%" align="left"> Income 
                                    </td>
                                    <td width="8%" align="center">  
                                      <input type="text"
													name="txt_qty1" tabindex="40"  
													value="<%=Helper.correctNull((String)rowSurplus3[0])%>" 
													 size="12"
													maxlength="9"  onKeyPress="allowNumber(this)"
													style="text-align:right">
                                       </td>
                                    <td width="8%" align="center">  
                                      <input type="text"
													name="txt_value1" tabindex="40"  
													value="<%=Helper.correctNull((String)rowSurplus4[0])%>"
													size="12"
													maxlength="9"  onKeyPress="allowNumber(this)"
													style="text-align:right">
                                       </td>
                                    <td width="8%" align="center">  
                                      <input type="text"
													name="txt_qty2" tabindex="40"  
													value="<%=Helper.correctNull((String)rowSurplus5[0])%>"
													size="12"
													maxlength="9"  onKeyPress="allowNumber(this)"
													style="text-align:right">
                                       </td>
                                    <td width="8%"> 
                                      <div align="center"> 
                                        <input type="text"
													name="txt_value2" tabindex="40"  
													value="<%=Helper.correctNull((String)rowSurplus6[0])%>"
													size="12"
													maxlength="9"  onKeyPress="allowNumber(this)"
													style="text-align:right">
                                        </div>
                                    </td>
                                    <td width="9%"> 
                                      <div align="center"> 
                                        <input type="text"
													name="txt_qty3" tabindex="40"  
													value="<%=Helper.correctNull((String)rowSurplus7[0])%>"
													size="12"
													maxlength="9"  onKeyPress="allowNumber(this)"
													style="text-align:right">
                                        </div>
                                    </td>
                                    <td width="11%"> 
                                      <div align="center"> 
                                        <input type="text"
													name="txt_value3" tabindex="40"  
													value="<%=Helper.correctNull((String)rowSurplus8[0])%>"
													size="12"
													maxlength="9" onKeyPress="allowNumber(this)" 
													style="text-align:right">
                                        </div>
                                    </td>
                                    <td width="8%"> 
                                      <div align="center"> 
                                        <input type="text"
													name="txt_qty4" tabindex="40"  
													value="<%=Helper.correctNull((String)rowSurplus9[0])%>"
													size="12"
													maxlength="9"  
													onKeyPress="allowNumber(this)"
													style="text-align:right">
                                        </div>
                                    </td>
                                    <td width="27%"> 
                                      <div align="center"> 
                                        <input type="text"
													name="txt_value4" tabindex="40" 
													value="<%=Helper.correctNull((String)rowSurplus10[0])%>"
													onKeyPress="allowNumber(this)" size="12" maxlength="9"
													 
													style="text-align:right">
                                        </div>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="2%"> 
                                      <div align="center">02</div>
                                    </td>
                                    <td width="11%" nowrap> 
                                      <div align="left">Gross 
                                        Receipts</div>
                                    </td>
                                    <td width="8%" align="center"> 
                                      <div align="center"> 
                                        <input type="text" name="txt_qty1" 
												value="<%=Helper.correctNull((String)rowSurplus3[1])%>"
												tabindex="42" size="12"
												maxlength="9"  onKeyPress="allowNumber(this)"
												style="text-align:right">
                                        </div>
                                    </td>
                                    <td width="8%"> 
                                      <div align="center"> 
                                        <input type="text" name="txt_value1" 
													value="<%=Helper.correctNull((String)rowSurplus4[1])%>"
													tabindex="42" size="12"
													maxlength="12"  onKeyPress="allowNumber(this)"
													style="text-align:right">
                                      </div>
                                    </td>
                                    <td width="8%"> 
                                      <div align="center"> 
                                        <input type="text" name="txt_qty2" 
													value="<%=Helper.correctNull((String)rowSurplus5[1])%>"
													" tabindex="42" size="12"
													maxlength="9"  onKeyPress="allowNumber(this)"
													style="text-align:right">
                                        </div>
                                    </td>
                                    <td width="8%"> 
                                      <div align="center"> 
                                        <input type="text" name="txt_value2" 
													value="<%=Helper.correctNull((String)rowSurplus6[1])%>"
													tabindex="42" size="12"
													maxlength="12"  onKeyPress="allowNumber(this)"
													style="text-align:right">
                                      </div>
                                    </td>
                                    <td width="9%"> 
                                      <div align="center"> 
                                        <input type="text" name="txt_qty3" 
													value="<%=Helper.correctNull((String)rowSurplus7[1])%>"
													 tabindex="42" size="12"
													maxlength="9"  onKeyPress="allowNumber(this)"
													style="text-align:right">
                                        </div>
                                    </td>
                                    <td width="11%"> 
                                      <div align="center"> 
                                        <input type="text" name="txt_value3" 
													value="<%=Helper.correctNull((String)rowSurplus8[1])%>"
													tabindex="42" size="12"
													maxlength="12" onKeyPress="allowNumber(this)" 
													style="text-align:right">
                                      </div>
                                    </td>
                                    <td width="8%"> 
                                      <div align="center"> 
                                        <input type="text" name="txt_qty4" 
													value="<%=Helper.correctNull((String)rowSurplus9[1])%>"
													 tabindex="42" size="12"
													maxlength="9" 
													onKeyPress="allowNumber(this)" 
													style="text-align:right">
                                        </div>
                                    </td>
                                    <td width="27%"> 
                                      <div align="center"> 
                                        <input type="text"
													name="txt_value4" tabindex="40" 
													value="<%=Helper.correctNull((String)rowSurplus10[1])%>"
													onKeyPress="allowNumber(this)" size="12" maxlength="9"
													 
													style="text-align:right">
                                        </div>
                                    </td>
                                  </tr>-->
									<tr>
										<td width="3%">
										<div align="center">01</div>
										</td>
										<td width="11%" nowrap="nowrap">
										<div align="left"><input type="text" name="txt_fish_type"
											tabindex="40"
											value="<%=Helper.correctNull((String)rowSurplus9[0])%>"
											size="15" maxlength="50" style="text-align:left"></div>
										</td>
										<td width="7%" align="center">
										<div align="center"><input type="text" name="txt_qty1"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus1[0])%>"
											size="6" maxlength="10" onKeyPress="allowNumber(this)"
											style="text-align:left"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="6%">
										<div align="center"><lapschoice:CurrencyTag name="txt_value1"
											tabindex="45"
											value='<%=Helper.correctNull((String)rowSurplus2[0])%>'
											size="10" maxlength="8"
											onBlur="caltotal(),calquantitytotal()" /></div>
										</td>
										<td width="7%"><input type="text" name="txt_income1"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus10[0])%>"
											size="12" maxlength="12" onKeyPress="allowNumber(this)"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></td>
										<td width="8%">
										<div align="center"><input type="text" name="txt_qty2"
											value="<%=Helper.correctNull((String)rowSurplus3[0])%>"
											" tabindex="42" size="6" maxlength="10"
											onKeyPress="allowNumber(this)" style="text-align:left"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="6%">
										<div align="center"><lapschoice:CurrencyTag name="txt_value2"
											tabindex="45"
											value='<%=Helper.correctNull((String)rowSurplus4[0])%>'
											size="10" maxlength="8"
											onBlur="caltotal(),calquantitytotal()" /></div>
										</td>
										<td width="7%"><input type="text" name="txt_income2"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus11[0])%>"
											size="12" maxlength="12" onKeyPress="allowNumber(this)"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></td>
										<td width="8%">
										<div align="center"><input type="text" name="txt_qty3"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus5[0])%>"
											size="6" maxlength="10" onKeyPress="allowNumber(this)"
											style="text-align:left"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="6">
										<div align="center"><lapschoice:CurrencyTag name="txt_value3"
											tabindex="45"
											value='<%=Helper.correctNull((String)rowSurplus6[0])%>'
											size="10" maxlength="8"
											onBlur="caltotal(),calquantitytotal()" /></div>
										</td>
										<td width="8%"><input type="text" name="txt_income3"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus12[0])%>"
											size="12" maxlength="12" onKeyPress="allowNumber(this)"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></td>
										<td width="8%">
										<div align="center"><input type="text" name="txt_qty4"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus7[0])%>"
											size="6" maxlength="10" onKeyPress="allowNumber(this)"
											style="text-align:left"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="6%">
										<div align="center"><lapschoice:CurrencyTag name="txt_value4"
											tabindex="40"
											value='<%=Helper.correctNull((String)rowSurplus8[0])%>'
											size="10" maxlength="8"
											onBlur="caltotal(),calquantitytotal()" /></div>
										</td>
										<td width="9%"><input type="text" name="txt_income4"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus13[0])%>"
											size="12" maxlength="12" onKeyPress="allowNumber(this)"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></td>
									</tr>
									<tr>
										<td width="3%">
										<div align="center">02</div>
										</td>
										<td width="11%">
										<div align="left"><input type="text" name="txt_fish_type"
											value="<%=Helper.correctNull((String)rowSurplus9[1])%>"
											tabindex="42" size="15" maxlength="50"
											style="text-align:left"></div>
										</td>
										<td width="7%" align="center">
										<div align="center"><input type="text" name="txt_qty1"
											value="<%=Helper.correctNull((String)rowSurplus1[1])%>"
											onKeyPress="allowNumber(this)" size="6" maxlength="10"
											tabindex="50" style="text-align:left"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="6%">
										<div align="center"><input type="text" name="txt_value1"
											value="<%=Helper.correctNull((String)rowSurplus2[1])%>"
											size="10" maxlength="8" tabindex="50"
											onKeyPress="allowNumber(this)" style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="7%"><input type="text" name="txt_income1"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus10[1])%>"
											size="12" maxlength="12" onKeyPress="allowNumber(this)"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></td>
										<td width="8%">
										<div align="center"><input type="text" name="txt_qty2"
											value="<%=Helper.correctNull((String)rowSurplus3[1])%>"
											size="6" maxlength="10" tabindex="50"
											onKeyPress="allowNumber(this)" style="text-align:left"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="6%">
										<div align="center"><input type="text" name="txt_value2"
											value="<%=Helper.correctNull((String)rowSurplus4[1])%>"
											size="10" maxlength="8" tabindex="50"
											onKeyPress="allowNumber(this)" style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="7%"><input type="text" name="txt_income2"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus11[1])%>"
											size="12" maxlength="12" onKeyPress="allowNumber(this)"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></td>
										<td width="8%">
										<div align="center"><input type="text" name="txt_qty3"
											value="<%=Helper.correctNull((String)rowSurplus5[1])%>"
											size="6" maxlength="10" tabindex="50"
											onKeyPress="allowNumber(this)" style="text-align:left"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="6%">
										<div align="center"><input type="text" name="txt_value3"
											value="<%=Helper.correctNull((String)rowSurplus6[1])%>"
											size="10" maxlength="8" tabindex="50"
											onKeyPress="allowNumber(this)" style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="8%"><input type="text" name="txt_income3"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus12[1])%>"
											size="12" maxlength="12" onKeyPress="allowNumber(this)"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></td>
										<td width="8%">
										<div align="center"><input type="text" name="txt_qty4"
											value="<%=Helper.correctNull((String)rowSurplus7[1])%>"
											size="6" maxlength="10" tabindex="50"
											onKeyPress="allowNumber(this)" style="text-align:left"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="6%">
										<div align="center"><input type="text" name="txt_value4"
											tabindex="40"
											value="<%=Helper.correctNull((String)rowSurplus8[1])%>"
											onKeyPress="allowNumber(this)" size="10" maxlength="8"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="9%"><input type="text" name="txt_income4"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus13[1])%>"
											size="12" maxlength="12" onKeyPress="allowNumber(this)"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></td>
									</tr>
									<tr>
										<td width="3%">
										<div align="center">03</div>
										</td>
										<td width="11%">
										<div align="left"><input type="text" name="txt_fish_type"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus9[2])%>"
											size="15" maxlength="50" style="text-align:left"></div>
										</td>
										<td width="7%" align="center">
										<div align="center"><input type="text" name="txt_qty1"
											value="<%=Helper.correctNull((String)rowSurplus1[2])%>"
											onKeyPress="allowNumber(this)" size="6" maxlength="10"
											tabindex="50" style="text-align:left"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="6%">
										<div align="center"><input type="text" name="txt_value1"
											style="text-align:right"
											value="<%=Helper.correctNull((String)rowSurplus2[2])%>"
											size="10" maxlength="8" tabindex="53"
											onKeyPress="allowInteger()"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="7%"><input type="text" name="txt_income1"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus10[2])%>"
											size="12" maxlength="12" onKeyPress="allowNumber(this)"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></td>
										<td width="8%">
										<div align="center"><input type="text" name="txt_qty2"
											style="text-align:left"
											value="<%=Helper.correctNull((String)rowSurplus3[2])%>"
											size="6" maxlength="10" tabindex="53"
											onKeyPress="allowInteger()"></div>
										</td>
										<td width="6%">
										<div align="center"><input type="text" name="txt_value2"
											style="text-align:right"
											value="<%=Helper.correctNull((String)rowSurplus4[2])%>"
											size="10" maxlength="8" tabindex="53"
											onKeyPress="allowInteger()"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="7%"><input type="text" name="txt_income2"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus11[2])%>"
											size="12" maxlength="12" onKeyPress="allowNumber(this)"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></td>
										<td width="8%">
										<div align="center"><input type="text" name="txt_qty3"
											style="text-align:left"
											value="<%=Helper.correctNull((String)rowSurplus5[2])%>"
											size="6" maxlength="10" tabindex="53"
											onKeyPress="allowInteger()"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="6%">
										<div align="center"><input type="text" name="txt_value3"
											style="text-align:right"
											value="<%=Helper.correctNull((String)rowSurplus6[2])%>"
											size="10" maxlength="8" tabindex="53"
											onKeyPress="allowInteger()"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="8%"><input type="text" name="txt_income3"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus12[2])%>"
											size="12" maxlength="12" onKeyPress="allowNumber(this)"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></td>
										<td width="8%">
										<div align="center"><input type="text" name="txt_qty4"
											style="text-align:left"
											value="<%=Helper.correctNull((String)rowSurplus7[2])%>"
											size="6" maxlength="10" tabindex="53"
											onKeyPress="allowInteger()"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="6%">
										<div align="center"><input type="text" name="txt_value4"
											tabindex="40"
											value="<%=Helper.correctNull((String)rowSurplus8[2])%>"
											onKeyPress="allowNumber(this)" size="10" maxlength="8"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="9%"><input type="text" name="txt_income4"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus13[1])%>"
											size="12" maxlength="12" onKeyPress="allowNumber(this)"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></td>
									</tr>
									<tr>
										<td width="3%">
										<div align="center">04</div>
										</td>
										<td width="11%">
										<div align="left"><input type="text" name="txt_fish_type"
											value="<%=Helper.correctNull((String)rowSurplus9[3])%>"
											size="15" maxlength="50" tabindex="50"
											style="text-align:left"></div>
										</td>
										<td width="7%" align="center">
										<div align="center"><input type="text" name="txt_qty1"
											value="<%=Helper.correctNull((String)rowSurplus1[3])%>"
											onKeyPress="allowNumber(this)" readonly="readonly" size="6"
											maxlength="10" tabindex="56" style="text-align:left"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="6%">
										<div align="center"><input type="text" name="txt_value1"
											value="<%=Helper.correctNull((String)rowSurplus2[3])%>"
											onKeyPress="allowNumber(this)" readonly="readonly" size="10"
											maxlength="8" tabindex="56" style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="7%"><input type="text" name="txt_income1"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus10[3])%>"
											size="12" maxlength="12" onKeyPress="allowNumber(this)"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></td>
										<td width="8%">
										<div align="center"><input type="text" name="txt_qty2"
											value="<%=Helper.correctNull((String)rowSurplus3[3])%>"
											onKeyPress="allowNumber(this)" readonly="readonly" size="6"
											maxlength="10" tabindex="56" style="text-align:left"></div>
										</td>
										<td width="6%">
										<div align="center"><input type="text" name="txt_value2"
											value="<%=Helper.correctNull((String)rowSurplus4[4])%>"
											onKeyPress="allowNumber(this)" readonly="readonly" size="10"
											maxlength="8" tabindex="56" style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="7%"><input type="text" name="txt_income2"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus11[3])%>"
											size="12" maxlength="12" onKeyPress="allowNumber(this)"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></td>
										<td width="8%">
										<div align="center"><input type="text" name="txt_qty3"
											value="<%=Helper.correctNull((String)rowSurplus5[3])%>"
											onKeyPress="allowNumber(this)" readonly="readonly" size="6"
											maxlength="10" tabindex="56" style="text-align:left"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="6%">
										<div align="center"><input type="text" name="txt_value3"
											value="<%=Helper.correctNull((String)rowSurplus6[3])%>"
											onKeyPress="allowNumber(this)" readonly="readonly" size="10"
											maxlength="8" tabindex="56" style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="8%"><input type="text" name="txt_income3"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus12[3])%>"
											size="12" maxlength="12" onKeyPress="allowNumber(this)"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></td>
										<td width="8%">
										<div align="center"><input type="text" name="txt_qty4"
											value="<%=Helper.correctNull((String)rowSurplus7[3])%>"
											onKeyPress="allowNumber(this)" readonly="readonly" size="6"
											maxlength="10" tabindex="56" style="text-align:left"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="6%">
										<div align="center"><input type="text" name="txt_value4"
											tabindex="40"
											value="<%=Helper.correctNull((String)rowSurplus8[3])%>"
											onKeyPress="allowNumber(this)" size="10" maxlength="8"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="9%"><input type="text" name="txt_income4"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus13[3])%>"
											size="12" maxlength="12" onKeyPress="allowNumber(this)"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></td>
									</tr>
									<tr>
										<td width="3%">
										<div align="center">05</div>
										</td>
										<td width="11%"><input type="text" name="txt_fish_type"
											style="text-align:left"
											value="<%=Helper.correctNull((String)rowSurplus9[4])%>"
											size="15" maxlength="50" tabindex="53"></td>
										<td width="7%" align="center">
										<div align="center"><input type="text" name="txt_qty1"
											value="<%=Helper.correctNull((String)rowSurplus1[4])%>"
											onKeyPress="allowNumber(this)" readOnly size="6"
											maxlength="10" tabindex="56" style="text-align:left"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="6%">
										<div align="center"><input type="text" name="txt_value1"
											value="<%=Helper.correctNull((String)rowSurplus2[4])%>"
											onKeyPress="allowNumber(this)" readOnly size="10"
											maxlength="8" tabindex="56" style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="7%"><input type="text" name="txt_income1"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus10[4])%>"
											size="12" maxlength="12" onKeyPress="allowNumber(this)"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></td>
										<td width="8%">
										<div align="center"><input type="text" name="txt_qty2"
											value="<%=Helper.correctNull((String)rowSurplus3[4])%>"
											onKeyPress="allowNumber(this)" readOnly size="6"
											maxlength="10" tabindex="56" style="text-align:left"></div>
										</td>
										<td width="6%">
										<div align="center"><input type="text" name="txt_value2"
											value="<%=Helper.correctNull((String)rowSurplus4[4])%>"
											onKeyPress="allowNumber(this)" readOnly size="10"
											maxlength="8" tabindex="56" style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="7%"><input type="text" name="txt_income2"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus11[4])%>"
											size="12" maxlength="12" onKeyPress="allowNumber(this)"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></td>
										<td width="8%">
										<div align="center"><input type="text" name="txt_qty3"
											value="<%=Helper.correctNull((String)rowSurplus5[4])%>"
											onKeyPress="allowNumber(this)" readOnly size="6"
											maxlength="10" tabindex="56" style="text-align:left"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="6%">
										<div align="center"><input type="text" name="txt_value3"
											value="<%=Helper.correctNull((String)rowSurplus6[4])%>"
											onKeyPress="allowNumber(this)" readOnly size="10"
											maxlength="8" tabindex="56" style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="8%"><input type="text" name="txt_income3"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus12[4])%>"
											size="12" maxlength="12" onKeyPress="allowNumber(this)"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></td>
										<td width="8%">
										<div align="center"><input type="text" name="txt_qty4"
											value="<%=Helper.correctNull((String)rowSurplus7[4])%>"
											onKeyPress="allowNumber(this)" readOnly size="6"
											maxlength="10" tabindex="56" style="text-align:left"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="6%">
										<div align="center"><input type="text" name="txt_value4"
											tabindex="40"
											value="<%=Helper.correctNull((String)rowSurplus8[4])%>"
											onKeyPress="allowNumber(this)" size="10" maxlength="8"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="9%"><input type="text" name="txt_income4"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus13[4])%>"
											size="12" maxlength="12" onKeyPress="allowNumber(this)"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></td>
									</tr>
									<tr>
										<td width="3%">
										<div align="center">06</div>
										</td>
										<td width="11%">
										<div align="left"><input type="text" name="txt_fish_type"
											value="<%=Helper.correctNull((String)rowSurplus9[5])%>"
											readonly size="15" maxlength="50" tabindex="56"
											style="text-align:left"></div>
										</td>
										<td width="7%" align="center">
										<div align="center"><input type="text" name="txt_qty1"
											value="<%=Helper.correctNull((String)rowSurplus1[5])%>"
											onKeyPress="allowNumber(this)" readOnly size="6"
											maxlength="10" tabindex="56" style="text-align:left"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="6%">
										<div align="center"><input type="text" name="txt_value1"
											value="<%=Helper.correctNull((String)rowSurplus2[5])%>"
											onKeyPress="allowNumber(this)" readOnly size="10"
											maxlength="8" tabindex="56" style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="7%"><input type="text" name="txt_income1"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus10[5])%>"
											size="12" maxlength="12" onKeyPress="allowNumber(this)"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></td>
										<td width="8%">
										<div align="center"><input type="text" name="txt_qty2"
											value="<%=Helper.correctNull((String)rowSurplus3[5])%>"
											onKeyPress="allowNumber(this)" readOnly size="6"
											maxlength="10" tabindex="56" style="text-align:left"></div>
										</td>
										<td width="6%">
										<div align="center"><input type="text" name="txt_value2"
											value="<%=Helper.correctNull((String)rowSurplus4[5])%>"
											onKeyPress="allowNumber(this)" readOnly size="10"
											maxlength="8" tabindex="56" style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="7%"><input type="text" name="txt_income2"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus11[5])%>"
											size="12" maxlength="12" onKeyPress="allowNumber(this)"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></td>
										<td width="8%">
										<div align="center"><input type="text" name="txt_qty3"
											value="<%=Helper.correctNull((String)rowSurplus5[5])%>"
											onKeyPress="allowNumber(this)" readOnly size="6"
											maxlength="10" tabindex="56" style="text-align:left"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="6%">
										<div align="center"><input type="text" name="txt_value3"
											value="<%=Helper.correctNull((String)rowSurplus6[5])%>"
											onKeyPress="allowNumber(this)" readOnly size="10"
											maxlength="8" tabindex="56" style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="8%"><input type="text" name="txt_income3"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus12[5])%>"
											size="12" maxlength="12" onKeyPress="allowNumber(this)"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></td>
										<td width="8%">
										<div align="center"><input type="text" name="txt_qty4"
											value="<%=Helper.correctNull((String)rowSurplus7[5])%>"
											onKeyPress="allowNumber(this)" readOnly size="6"
											maxlength="10" tabindex="56" style="text-align:left"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="6%">
										<div align="center"><input type="text" name="txt_value4"
											tabindex="40"
											value="<%=Helper.correctNull((String)rowSurplus8[5])%>"
											onKeyPress="allowNumber(this)" size="10" maxlength="8"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></div>
										</td>
										<td width="9%"><input type="text" name="txt_income4"
											tabindex="45"
											value="<%=Helper.correctNull((String)rowSurplus13[5])%>"
											size="12" maxlength="12" onKeyPress="allowNumber(this)"
											style="text-align:right"
											onBlur="caltotal(),calquantitytotal()"></td>
									</tr>
									<tr>
										<td width="3%" height="30">&nbsp;</td>
										<td width="11%" align="center" height="30"><b>Total</b></td>
										<td width="7%" align="center" height="30">
										<div align="center"><input type="text" name="txt_total_qty1"
											value="" onKeyPress="allowNumber(this)" readOnly size="6"
											maxlength="10" tabindex="56" style="text-align:left"></div>
										</td>
										<td width="6%" height="30">
										<div align="center"><input type="hidden"
											name="txt_total_value1" value=""
											onKeyPress="allowNumber(this)" readOnly size="10"
											maxlength="8" tabindex="56" style="text-align:right"></div>
										</td>
										<td width="7" height="30"><lapschoice:CurrencyTag
											name="txt_total_income1" tabindex="45" value='' size="12"
											maxlength="12" /></td>
										<td width="8%" height="30">
										<div align="center"><input type="text" name="txt_total_qty2"
											value="" onKeyPress="allowNumber(this)" readOnly size="6"
											maxlength="10" tabindex="56" style="text-align:left"></div>
										</td>
										<td width="6%" height="30">
										<div align="center"><input type="hidden"
											name="txt_total_value2" value=""
											onKeyPress="allowNumber(this)" readOnly size="10"
											maxlength="8" tabindex="56" style="text-align:right"></div>
										</td>
										<td width="7" height="30"><lapschoice:CurrencyTag
											name="txt_total_income2" tabindex="45" value='' size="12"
											maxlength="12" /></td>
										<td width="8%" height="30">
										<div align="center"><input type="text" name="txt_total_qty3"
											value="" onKeyPress="allowNumber(this)" readOnly size="6"
											maxlength="10" tabindex="56" style="text-align:left"></div>
										</td>
										<td width="6%" height="30">
										<div align="center"><input type="hidden"
											name="txt_total_value3" value=""
											onKeyPress="allowNumber(this)" readOnly size="10"
											maxlength="8" tabindex="56" style="text-align:right"></div>
										</td>
										<td width="8" height="30"><lapschoice:CurrencyTag
											name="txt_total_income3" tabindex="45" value='' size="12"
											maxlength="12" /></td>
										<td width="8%" height="30">
										<div align="center"><input type="text" name="txt_total_qty4"
											value="" onKeyPress="allowNumber(this)" readOnly size="6"
											maxlength="10" tabindex="56" style="text-align:left"></div>
										</td>
										<td width="6%" height="30">
										<div align="center"><input type="hidden"
											name="txt_total_value4" tabindex="40" value=""
											onKeyPress="allowNumber(this)" size="10" maxlength="8"
											style="text-align:right"></div>
										</td>
										<td width="9" height="30"><lapschoice:CurrencyTag
											name="txt_total_income4" tabindex="45" value='' size="12"
											maxlength="12" /></td>
									</tr>
								</table>
								<br>
								</td>
							</tr>
							<tr>
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




