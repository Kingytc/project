<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Sericulture Technical Data</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var txt_mainoccupation= "<%=Helper.correctNull((String)hshValues.get("txt_mainoccupation"))%>"
var txt_subsidaryoccupation= "<%=Helper.correctNull((String)hshValues.get("txt_subsidaryoccupation"))%>" 
var txt_proposedactivity= "<%=Helper.correctNull((String)hshValues.get("txt_proposedactivity"))%>" 
var txt_place= "<%=Helper.correctNull((String)hshValues.get("txt_place"))%>" 
var txt_distance= "<%=Helper.correctNull((String)hshValues.get("txt_distance"))%>" 
var txt_place1= "<%=Helper.correctNull((String)hshValues.get("txt_place1"))%>" 
var txt_distance1= "<%=Helper.correctNull((String)hshValues.get("txt_distance1"))%>" 
var sel_labour = "<%=Helper.correctNull((String)hshValues.get("sel_labour"))%>" 
var txt_labourers = "<%=Helper.correctNull((String)hshValues.get("txt_labourers"))%>"  
var txt_wage = "<%=Helper.correctNull((String)hshValues.get("txt_wage"))%>" 
var txt_area= "<%=Helper.correctNull((String)hshValues.get("txt_area"))%>" 
var txt_guntas = "<%=Helper.correctNull((String)hshValues.get("txt_guntas"))%>" 
var txt_irrigation = "<%=Helper.correctNull((String)hshValues.get("txt_irrigation"))%>" 
var txt_chandrika = "<%=Helper.correctNull((String)hshValues.get("txt_chandrika"))%>" 
var txt_trays = "<%=Helper.correctNull((String)hshValues.get("txt_trays"))%>" 
var txt_stand= "<%=Helper.correctNull((String)hshValues.get("txt_stand"))%>" 
var txt_noeggs= "<%=Helper.correctNull((String)hshValues.get("txt_noeggs"))%>" 
var txt_nocrops = "<%=Helper.correctNull((String)hshValues.get("txt_nocrops"))%>" 
var txt_quantity= "<%=Helper.correctNull((String)hshValues.get("txt_quantity"))%>" 
var txt_avgcost= "<%=Helper.correctNull((String)hshValues.get("txt_avgcost"))%>" 
var txt_income= "<%=Helper.correctNull((String)hshValues.get("txt_income"))%>" 
</script>

<script>


function onloading()
{	  

	disableFields(true);
	document.forms[0].txt_mainoccupation.value=txt_mainoccupation;
	document.forms[0].txt_subsidaryoccupation.value=txt_subsidaryoccupation;
	document.forms[0].txt_proposedactivity.value=txt_proposedactivity;
	document.forms[0].txt_place.value=txt_place;
	document.forms[0].txt_distance.value=txt_distance;
	document.forms[0].txt_place1.value=txt_place1;
	document.forms[0].txt_distance1.value=txt_distance1;
	
	if(sel_labour!="")
	{
		document.forms[0].sel_labour.value=sel_labour;
	}
	
	document.forms[0].txt_labourers.value=txt_labourers;
	document.forms[0].txt_wage.value=txt_wage;
	document.forms[0].txt_area.value=txt_area;
	document.forms[0].txt_guntas.value=txt_guntas;
	document.forms[0].txt_irrigation.value=txt_irrigation;
	document.forms[0].txt_chandrika.value=txt_chandrika;
	document.forms[0].txt_trays.value=txt_trays;
	document.forms[0].txt_stand.value=txt_stand;
	document.forms[0].txt_noeggs.value=txt_noeggs;
	document.forms[0].txt_nocrops.value=txt_nocrops;
	document.forms[0].txt_quantity.value=txt_quantity;
	document.forms[0].txt_avgcost.value=txt_avgcost;
	document.forms[0].txt_income.value=txt_income;
}
function enableButtons(bool1, bool2, bool3, bool4, bool5, bool6)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}
function doSave()
{ 

    if(document.forms[0].txt_place.value=="")
	{
	alert("Enter Place Availability of Eggs");
	document.forms[0].txt_place.focus();
	return;
	}  
	if(document.forms[0].txt_distance.value=="")
	{
	alert("Enter Distance from Farm Under Availability of Eggs");
	document.forms[0].txt_distance.focus();
	return;
	} 
    if(document.forms[0].txt_area.value=="")
	{
	alert("Enter area under mulbery");
	document.forms[0].txt_area.focus();
	return;
	}  
	if(document.forms[0].txt_guntas.value=="")
	{
	alert("Enter area under mulbery");
	document.forms[0].txt_guntas.focus();
	return;
	} 
	var len = document.forms[0].sel_labour.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_labour.options[i].selected==true)
		 {
			 document.forms[0].sel_labourtext.value = document.forms[0].sel_labour.options[i].text; 
			break;
		 }
	}
	
    enableButtons(true, true, true, true, true, false);
	document.forms[0].hidBeanId.value="agrcoffee";		
	document.forms[0].hidSourceUrl.value="/action/agr_seri_techdata.jsp";
	document.forms[0].hidBeanMethod.value="updateseritechdata";
	document.forms[0].hidBeanGetMethod.value="getseritechdata";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doEdit()
{
 	disableFields(false);
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="insert";
	enableButtons(true, true, false, false, false, true);		
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		//document.forms[0].hidSourceUrl.value="/action/agr_seri_techdata.jsp";
		document.forms[0].hidBeanId.value="agrcoffee";
		document.forms[0].hidBeanGetMethod.value="getseritechdata";
		document.forms[0].action=appURL+"action/agr_seri_techdata.jsp";
		document.forms[0].submit(); 		
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
	 	if(document.forms[0].elements[i].type=='checkbox')
	 	{
			document.forms[0].elements[i].disabled=one;
	 	}
		  
	}
}


function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updateseritechdata";
		document.forms[0].hidBeanGetMethod.value="getseritechdata";
		document.forms[0].hidBeanId.value="agrcoffee";
		document.forms[0].hidSourceUrl.value="action/agr_seri_techdata.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}
function checklabour()
{
	if(document.forms[0].sel_labour.value == "2")
	{
		document.all.r1.style.visibility="visible";
		document.all.r2.style.visibility="visible";		
	}
	else
	{
		document.all.r1.style.visibility="hidden";
		document.all.r2.style.visibility="hidden";		
		document.forms[0].txt_labourers.value="";
		document.forms[0].txt_wage.value="";
	}
}
function chkcentgunt() 
{
	if(document.forms[0].land_measurement.value == 'g')
	{
		if(document.forms[0].txt_guntas.value > 39)
		{
		 	alert("The Data you entered is not valid");
		 	document.forms[0].txt_guntas.value = "";
		 	document.forms[0].txt_guntas.focus();
		}
	}
}

</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body  onload="onloading();checklabour()">
<form name="frmpri" method="post" class="normal">
<br/>
<table width="100%"  border="0" cellpadding="1" cellspacing="3" class="outertable border1">
    <tr> 
    <td>
  <table width="100%"  border="0" cellpadding="1" cellspacing="3" class="outertable">
    <tr> 
      <td>Main Occupation</td>
      <td> 
        <input type="text" name="txt_mainoccupation"  value="<%=Helper.correctNull((String)hshValues.get("txt_mainoccupation"))%>"  size="30%" onKeyPress="notAllowSplChar()" maxlength="30">
        <br>
         </td>
      <td colspan="2">Subsidary Occupation</td>
      <td nowrap> 
        <input type="text" name="txt_subsidaryoccupation"  onKeyPress="notAllowSplChar()" value="<%=Helper.correctNull((String)hshValues.get("txt_subsidaryoccupation"))%>"  size="30%"  maxlength="30">
        <br>
         </td>
    </tr>
    <tr> 
      <td>Knowledge &amp; Experience in proposed 
        activity </td>
      <td> 
        <input type="text" name="txt_proposedactivity"  onKeyPress="notAllowSplChar()" value="<%=Helper.correctNull((String)hshValues.get("txt_proposedactivity"))%>"  size="30%"  maxlength="30">
        </td>
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr class="dataheader"> 
      <td colspan="5" align="center"> <strong>Availability 
        of Eggs</strong></td>
    </tr>
    <tr> 
      <td>Place<b class="mantatory">*</b></td>
      <td>&nbsp;  
        <input type="text" name="txt_place"  value="<%=Helper.correctNull((String)hshValues.get("txt_place"))%>"  size="30%" onKeyPress="notAllowSplChar()"maxlength="30">
        </td>
      <td colspan="2">Distance from Farm<b class="mantatory">*</b></td>
      <td ><b> 
        <input type="text" name="txt_distance"  value="<%=Helper.correctNull((String)hshValues.get("txt_distance"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="5">
        (Km) </b></td>
      
    <tr class="dataheader"> 
      <td colspan="12" align="center"><strong>Marketing 
        of Cocoons</strong></td>
    <tr> 
      <td>Place</td>
      <td> 
        <input type="text" name="txt_place1"  value="<%=Helper.correctNull((String)hshValues.get("txt_place1"))%>"  size="30%" onKeyPress="notAllowSplChar()"maxlength="30">
        </td>
      <td colspan="2">Distance from Farm</td>
      <td  ><b> 
        <input type="text" name="txt_distance1"  value="<%=Helper.correctNull((String)hshValues.get("txt_distance1"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="5">
        (Km) </b></td>
    <tr> 
      <td>Labourers to be Employed<b></b></td>
      <td><select value="0"
											name="sel_labour" onChange="checklabour()">
          <option value="0" selected>--Select--</option>
          <option value="1">Family Labour</option>
          <option value="2">Labour Employed</option>
        </select></td>
      <td colspan="2" id="r1">No of labourers<b> 
        <input type="text" name="txt_labourers"  value="<%=Helper.correctNull((String)hshValues.get("txt_labourers"))%>"  size="20%" onKeyPress="allowInteger()" maxlength="5">
        </b></td>
      <td id="r2">Wages per Employee(Rs.)<b> 
        <input type="text" name="txt_wage"  value="<%=Helper.correctNull((String)hshValues.get("txt_wage"))%>" onBlur="roundtxt(this);" size="15" onKeyPress="allowNumber(this)"  maxlength="12" >
        per month</b></td>
    <tr class="dataheader"> 
      <td colspan="5" align="center"><strong>Existing 
        Arrangements for Cocoon Production</strong></td>
    <tr> 
      <td>Area under Mulbery Plantation<b class="mantatory">*</b></td>
      <td><b> 
        <input type="text" name="txt_area"  value="<%=Helper.correctNull((String)hshValues.get("txt_area"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="4">
        </b><strong>(Acres)</strong></td>
      <td colspan="2"><b> 
        <input type="text" name="txt_guntas"  value="<%=Helper.correctNull((String)hshValues.get("txt_guntas"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="2" onBlur="chkcentgunt()">
        <% 	String measurementtype = Helper.correctNull((String)hshValues.get("land_measurement"));
                              	String measurementval="";
                            	if(measurementtype.equalsIgnoreCase("c"))
                      	  		{
                      	 
                      	  			 measurementval = "Cents";
                      	 		 }
                      	 		 else
                      	  			{
                      					measurementval = "Guntas";
                      	 			}
                                %>
        <strong>(</strong></b><strong><%=measurementval%>) 
        </strong></td>
      <td  >&nbsp;</td>
    <tr> 
      <td>Irrigation Facility(Specify)</td>
      <td> 
        <input type="text" name="txt_irrigation"  value="<%=Helper.correctNull((String)hshValues.get("txt_irrigation"))%>"  size="30%" onKeyPress="notAllowSplChar()"maxlength="30">
        </td>
      <td colspan="3">&nbsp;</td>
    <tr> 
      <td>Chandrika(Nos &amp; Condition)</td>
      <td> 
        <input type="text" name="txt_chandrika"  value="<%=Helper.correctNull((String)hshValues.get("txt_chandrika"))%>"  size="30%" onKeyPress="notAllowSplChar()"  maxlength="30">
        </td>
      <td colspan="2">Trays(Nos &amp; Condition)</td>
      <td  > 
        <input type="text" name="txt_trays"  value="<%=Helper.correctNull((String)hshValues.get("txt_trays"))%>"  size="30%" onKeyPress="notAllowSplChar()" maxlength="30">
        </td>
    <tr> 
      <td>Stand(Nos &amp; Condition)</td>
      <td> 
        <input type="text" name="txt_stand"  value="<%=Helper.correctNull((String)hshValues.get("txt_stand"))%>"  size="30%" onKeyPress="notAllowSplChar()" maxlength="30">
        </td>
      <td colspan="3">&nbsp;</td>
    <tr> 
      <td>No of Eggs reared(DFLs)<b></b></td>
      <td><b> 
        <input type="text" name="txt_noeggs"  value="<%=Helper.correctNull((String)hshValues.get("txt_noeggs"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="5">
        </b></td>
      <td colspan="2">No. of successful Crops 
        per year</td>
      <td  ><b> 
        <input type="text" name="txt_nocrops"  value="<%=Helper.correctNull((String)hshValues.get("txt_nocrops"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="8">
        </b></td>
    <tr> 
      <td>Average Quantity of 
        cocoons produced per crop</td>
      <td><b> 
        <input type="text" name="txt_quantity"  value="<%=Helper.correctNull((String)hshValues.get("txt_quantity"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="8">
        (Kg) </b></td>
      <td colspan="2">Average 
        Cost of cocoons produced per Kg(Rs.)</td>
      <td  ><b> <lapschoice:CurrencyTag name="txt_avgcost"  value='<%=Helper.correctNull((String)hshValues.get("txt_avgcost"))%>'  size="20%" maxlength="9" /> 
        </b></td>
    <tr> 
      <td>Net annual income from existing 
        arrangements(Rs.)</td>
      <td><b> 
        <lapschoice:CurrencyTag name="txt_income"  value='<%=Helper.correctNull((String)hshValues.get("txt_income"))%>'  size="20%" maxlength="9" />
        </b></td>
      <td colspan="3">&nbsp;</td>
  </table>
  </td>
 </tr>
</table>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<input type ="hidden" name="land_measurement" value ="<%=Helper.correctNull((String)hshValues.get("land_measurement"))%>">
<input type="hidden" name="sel_labourtext">
<lapschoice:agrihiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("auditFlag"))%>">
</form>
</body>
</html>


