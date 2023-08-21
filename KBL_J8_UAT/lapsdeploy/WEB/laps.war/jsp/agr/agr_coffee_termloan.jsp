<%@include file = "../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
String measurementtype = Helper.correctNull((String)hshValues.get("land_measurement"));

%>
<html>
<head>
<title>Technical Aspects</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var txt_estate="<%=Helper.correctNull((String)hshValues.get("txt_estate"))%>";
var txt_location="<%=Helper.correctNull((String)hshValues.get("txt_location"))%>";
//var txt_route="";
var txt_distance="<%=Helper.correctNull((String)hshValues.get("txt_distance"))%>";
//var txt_plantationcrop="";
var txt_variety="<%=Helper.correctNull((String)hshValues.get("txt_variety"))%>";
var txt_acres="<%=Helper.correctNull((String)hshValues.get("txt_acres"))%>";
var txt_guntas="<%=Helper.correctNull((String)hshValues.get("txt_guntas"))%>";
var txt_annual="<%=Helper.correctNull((String)hshValues.get("txt_annual"))%>";
var sel_rainfall="<%=Helper.correctNull((String)hshValues.get("sel_rainfall"))%>";
var txt_average="<%=Helper.correctNull((String)hshValues.get("txt_average"))%>";
var txt_daterainfall="<%=Helper.correctNull((String)hshValues.get("txt_daterainfall"))%>";
var txt_lastyear="<%=Helper.correctNull((String)hshValues.get("txt_lastyear"))%>";
var txt_irrigation="<%=Helper.correctNull((String)hshValues.get("txt_irrigation"))%>";
//var txr_comments="";
//var txr_technical="";
var sel_sprinkler="<%=Helper.correctNull((String)hshValues.get("sel_sprinkler"))%>";
var sel_powersprayer="<%=Helper.correctNull((String)hshValues.get("sel_powersprayer"))%>";
var sel_pulper="<%=Helper.correctNull((String)hshValues.get("sel_pulper"))%>";
var sel_tractor="<%=Helper.correctNull((String)hshValues.get("sel_tractor"))%>";
var sel_pulp="<%=Helper.correctNull((String)hshValues.get("sel_pulp"))%>";
var sel_drying="<%=Helper.correctNull((String)hshValues.get("sel_drying"))%>";
var sel_drier="<%=Helper.correctNull((String)hshValues.get("sel_drier"))%>";
var sel_farmhouse="<%=Helper.correctNull((String)hshValues.get("sel_farmhouse"))%>";
var sel_staffquarter="<%=Helper.correctNull((String)hshValues.get("sel_staffquarter"))%>";
var sel_officeblog="<%=Helper.correctNull((String)hshValues.get("sel_officeblog"))%>";
var sel_godown="<%=Helper.correctNull((String)hshValues.get("sel_godown"))%>";
var sel_garage="<%=Helper.correctNull((String)hshValues.get("sel_garage"))%>";
var sel_teaunit="<%=Helper.correctNull((String)hshValues.get("sel_teaunit"))%>";
var sel_rubberunit="<%=Helper.correctNull((String)hshValues.get("sel_rubberunit"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function check()
{
if(document.forms[0].sel_rainfall.value=="1")
{
document.forms[0].txt_mm.value="inches";
}
if(document.forms[0].sel_rainfall.value=="2")
{
document.forms[0].txt_mm.value="mm";
}
if(document.forms[0].sel_rainfall.value=="3")
{
document.forms[0].txt_mm.value="cm";
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


function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);		
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

function doSave()
{   

 if(document.forms[0].txt_saplingsno.value == "")
	{
		ShowAlert('121','No. of Saplings per Acre');
		document.forms[0].txt_saplingsno.focus();
		return;
	}
 if(document.forms[0].txt_irrigation.value == "")
	{
		ShowAlert('121','Irrigation Facilities');
		document.forms[0].txt_irrigation.focus();
		return;
	}
 if(document.forms[0].txt_procgrafts.value == "")
	{
		ShowAlert('121','Procuring grafts/ Planting Material');
		document.forms[0].txt_procgrafts.focus();
		return;
	}
 if(document.forms[0].txt_marprod.value == "")
	{
		ShowAlert('121','Marketing of Produce');
		document.forms[0].txt_marprod.focus();
		return;
	}
	
	var len = document.forms[0].sel_rainfall.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_rainfall.options[i].selected==true)
		 {
			 document.forms[0].sel_rainfall_text.value = document.forms[0].sel_rainfall.options[i].text; 
			break;
		 }
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidBeanId.value="agrcoffee";		
	document.forms[0].hidSourceUrl.value="/action/agr_coffee_termloan.jsp";
	document.forms[0].hidBeanMethod.value="updatecoffeetermtechdata";
	document.forms[0].hidBeanGetMethod.value="getcoffeetermtechdata";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{
 	disableFields(false);
	document.forms[0].txt_mm.readOnly =true;
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="insert";
	enableButtons( true, false, false, false);		
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agrcoffee";
		document.forms[0].hidBeanGetMethod.value="getcoffeetermtechdata";
		document.forms[0].action=appURL +"action/agr_coffee_termloan.jsp";
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

function doDelete()
{

var len = document.forms[0].sel_rainfall.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_rainfall.options[i].selected==true)
		 {
			 document.forms[0].sel_rainfall_text.value = document.forms[0].sel_rainfall.options[i].text; 
			break;
		 }
	}

	if(varRecordFlag=="Y") {
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updatecoffeetermtechdata";
		document.forms[0].hidBeanGetMethod.value="getcoffeetermtechdata";
		document.forms[0].hidBeanId.value="agrcoffee";
		document.forms[0].hidSourceUrl.value="action/agr_coffee_termloan.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}
	}else {
		
		ShowAlert(158);
	}		
}
	
function onloading()
{	  
	disableFields(true);
	document.forms[0].txt_estate.value=txt_estate;
	document.forms[0].txt_location.value=txt_location;
	//document.forms[0].txt_route.value=txt_route;
	document.forms[0].txt_distance.value=txt_distance;
	//document.forms[0].txt_plantationcrop.value=txt_plantationcrop;
	document.forms[0].txt_variety.value=txt_variety;
	document.forms[0].txt_acres.value=txt_acres;
	document.forms[0].txt_guntas.value=txt_guntas;
	document.forms[0].txt_annual.value=txt_annual;
	document.forms[0].txt_average.value=txt_average;
	document.forms[0].txt_daterainfall.value=txt_daterainfall;
	document.forms[0].txt_lastyear.value=txt_lastyear;
	document.forms[0].txt_irrigation.value=txt_irrigation;
	//document.forms[0].txr_comments.value=txr_comments;
	//document.forms[0].txr_technical.value=txr_technical;
	if(sel_rainfall!="")
	{
		document.forms[0].sel_rainfall.value=sel_rainfall;
	}
	if(sel_sprinkler!="")
	{
		document.forms[0].sel_sprinkler.value=sel_sprinkler;
	}
	if(sel_powersprayer!="")
	{
		document.forms[0].sel_powersprayer.value=sel_powersprayer;
	}
	if(sel_pulper!="")
	{
		document.forms[0].sel_pulper.value=sel_pulper;
		
	}
	if(sel_tractor!="")
	{
		document.forms[0].sel_tractor.value=sel_tractor;
	}
	if(sel_pulp!="")
	{
		document.forms[0].sel_pulp.value=sel_pulp;
	}
	if(sel_drying!="")
	{
		document.forms[0].sel_drying.value=sel_drying;
	}
	if(sel_drier!="")
	{
		document.forms[0].sel_drier.value=sel_drier;
	}
	if(sel_farmhouse!="")
	{
		document.forms[0].sel_farmhouse.value=sel_farmhouse;
	}	
	if(sel_staffquarter!="")
	{
		document.forms[0].sel_staffquarter.value=sel_staffquarter;
	}
	if(sel_officeblog!="")
	{
		document.forms[0].sel_officeblog.value=sel_officeblog;
	}
	if(sel_godown!="")
	{
		document.forms[0].sel_godown.value=sel_godown;
	}
	if(sel_garage!="")
	{
		document.forms[0].sel_garage.value=sel_garage;
	}
		if(sel_teaunit!="")
	{
		document.forms[0].sel_teaunit.value=sel_teaunit;
	}
	if(sel_rubberunit!="")
	{
		document.forms[0].sel_rubberunit.value=sel_rubberunit;
	}
	
			
}

function enableButtons(bool2, bool3, bool4, bool5, bool6)
{	
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}

</script>

</head>
<body onload="onloading();check()">
<form name="frmpri" method="post" class="normal">
<br> 
  <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
    <tr>
      <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
          <tr> 
            <td width="29%">Name of the Estate</td>
            <td width="26%"> 
              <input type="text" name="txt_estate" size='20'
					maxlength='30'
					value="<%=Helper.correctNull((String)hshValues.get("txt_estate"))%>">
            </td>
            <td width="15%"> Location(Zone)</td>
            <td width="30%"> 
              <input type="text" name="txt_location" size='20'
					maxlength='18'
					value="<%=Helper.correctNull((String)hshValues.get("txt_location"))%>">
            </td>
          </tr>
          <tr> 
            <td width="29%">Nearest Route</td>
            <td width="26%"> 
              <!--<input type="text" name="txt_route" size='20'
					maxlength='100'
					value="<%//=Helper.correctNull((String)hshValues.get("txt_route"))%>">-->
				 <textarea name="txt_route" cols="20" rows="5" 
									onKeyPress="notAllowSingleQuote();textlimit(txt_route,100)"  onKeyUp="textlimit(this,100)"><%=Helper.correctNull((String)hshValues.get("txt_route"))%>
									</textarea>	
            </td>
            <td width="15%">Distance from 
              the branch</td>
            <td width="30%"> 
              <input type="text" name="txt_distance" size='10' maxlength='5'
					value="<%=Helper.correctNull((String)hshValues.get("txt_distance"))%>"  onKeyPress="allowInteger()">
              (Km)</td>
          </tr>
          <tr> 
            <td width="29%">Name of the Plantation 
              Crop </td>
            <td width="26%"> 
              <textarea name="txt_plantationcrop" cols="20" rows="5" 
									onKeyPress="notAllowSingleQuote();textlimit(txt_plantationcrop,200)"  onKeyUp="textlimit(this,200)"><%=Helper.correctNull((String)hshValues.get("txt_plantationcrop"))%></textarea>
            </td>
            <td width="15%">Variety</td>
            <td width="30%"> 
              <input type="text" name="txt_variety" size='20'
					maxlength='20'
					value="<%=Helper.correctNull((String)hshValues.get("txt_variety"))%>">
              </td>
          </tr>
          <tr> 
            <td  width="29%">No. of Saplings 
              per Acre<b>*</b></td>
            <td  width="26%"> 
              <input type="text" name="txt_saplingsno" size='20'
					maxlength='9' onKeyPress="allowNumber(this)"
					value="<%=Helper.correctNull((String)hshValues.get("txt_saplingsno"))%>">
            </td>
            <td height="60" width="15%">Spacings 
              to be adopted</td>
            <td height="60" width="30%"> 
              <input type="text" name="txt_spacings" size='20'
					maxlength='12'
					value="<%=Helper.correctNull((String)hshValues.get("txt_spacings"))%>">
              </td>
          </tr>
          <tr> 
            <td width="29%">Survey no. in which 
              crops being cultivated / to be cultivated</td>
            <td width="26%"> 
              <input type="text" name="txt_syno" size='20'
					maxlength='40'
					value="<%=Helper.correctNull((String)hshValues.get("txt_syno"))%>">
               </td>
            <td width="15%">Extent of the 
              Land to be brought under development</td>
            <td width="30%"> 
              <input type="text" name="txt_acres" size='10'
					maxlength='4' onKeyPress="allowInteger()"
					value="<%=Helper.correctNull((String)hshValues.get("txt_acres"))%>">
               (Acres) 
              <input type="text" name="txt_guntas" size='10'
					maxlength='2'  onKeyPress="allowInteger()"
					value="<%=Helper.correctNull((String)hshValues.get("txt_guntas"))%>" onBlur="chkcentgunt()">
              <% 	measurementtype = Helper.correctNull((String)hshValues.get("land_measurement"));
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
              (<%=measurementval%>)&nbsp; 
              </td>
          </tr>
          <tr> 
            <td width="29%">Rainfall (Annual)</td>
            <td width="26%"> 
              <input type="text" name="txt_annual" size='10'
					maxlength='4' onKeyPress="allowNumber(this)"
					value="<%=Helper.correctNull((String)hshValues.get("txt_annual"))%>">
              <select name="sel_rainfall" onChange="check()">
                <option value="0" selected="selected">----Select----</option>
                <option value="1">inches</option>
                <option value="2">mm</option>
                <option value="3">cm</option>
              </select>
            </td>
            <td width="15%">average of</td>
            <td width="30%"> 
              <input type="text" name="txt_average" size='15' maxlength='5' onKeyPress="allowInteger()"
					value="<%=Helper.correctNull((String)hshValues.get("txt_average"))%>">
              (Years)</td>
          </tr>
          <tr> 
            <td width="29%">Till Date(from 
              1st Jan)</td>
            <td width="26%"> 
              <input type="text" name="txt_daterainfall" size='15'
					maxlength='10' onKeyPress="allowNumber(this)"
					value="<%=Helper.correctNull((String)hshValues.get("txt_daterainfall"))%>">
              <input type="text" name="txt_mm" size='10'
					maxlength='4' onKeyPress=""
					value="">
            </td>
            <td width="15%">Corresponding 
              Last year</td>
            <td width="30%"> 
              <lapschoice:CurrencyTag name="txt_lastyear"  size='15' maxlength='6' value='<%=Helper.correctNull((String)hshValues.get("txt_lastyear"))%>' onKeyPress="allowDecimals(this)"/> 
            </td>
          </tr>
          <tr> 
            <td width="29%">Irrigation Facilities(Specify)<b>*</b> 
            </td>
            <td width="26%"> 
              <input type="text" name="txt_irrigation" size='35'
					maxlength='50'
					value="<%=Helper.correctNull((String)hshValues.get("txt_irrigation"))%>">
            </td>
            <td colspan="2">&nbsp;</td>
          </tr>
          <tr> 
            <td width="29%">Comments on the 
              Standard of Cultivation,slope,shade,pattern,plant condition,presence 
              of pests &amp; Diseases,Crop prospects etc</td>
            <td width="26%"> 
              <textarea name="txr_comments" cols="15" rows="2" 
									onKeyPress="notAllowSingleQuote();textlimit(txr_comments,200)"  onKeyUp="textlimit(this,200)"><%=Helper.correctNull((String)hshValues.get("txr_comments"))%></textarea>
            </td>
            <td width="15%">Technical Know 
              how &amp; capability of the applicant to implement the scheme and 
              to manage the Estate</td>
            <td width="30%"> 
              <textarea name="txr_technical" cols="15" rows="2" 
									onKeyPress="notAllowSingleQuote();textlimit(txr_technical,200)"  onKeyUp="textlimit(this,200)"><%=Helper.correctNull((String)hshValues.get("txr_technical"))%></textarea>
            </td>
          </tr>
          <tr>
            <td width="29%" >Procurring grafts/ 
              Planting Material<b>*</b></td>
            <td width="26%" >
              <input type="text" name="txt_procgrafts" size='35'
					maxlength='40'
					value="<%=Helper.correctNull((String)hshValues.get("txt_procgrafts"))%>">
            </td>
            <td width="15%" >Procuring inputs 
              / such as farm yard manure/fertilizer/insecticide</td>
            <td width="30%" >
              <input type="text" name="txt_procinputs" size='35'
					maxlength='40'
					value="<%=Helper.correctNull((String)hshValues.get("txt_procinputs"))%>">
            </td>
          </tr>
          <tr> 
            <td width="29%" >Marketing of Produce<b>*</b></td>
            <td width="26%" >
              <input type="text" name="txt_marprod" size='35'
					maxlength='40'
					value="<%=Helper.correctNull((String)hshValues.get("txt_marprod"))%>">
            </td>
            <td width="15%" >&nbsp;</td>
            <td width="30%" >&nbsp; </td>
          </tr>
          <tr> 
            <td colspan="4" align="center"><strong>Infrastructure 
              Available </strong></td>
          </tr>
          <tr> 
            <td width="29%">Sprinkler Unit</td>
            <td width="26%"> 
              <select name="sel_sprinkler" onChange="">
                <option value="0" selected="selected">----Select----</option>
                <option value="1">Available</option>
                <option value="2">Provision made in Proposed Scheme</option>
                <option value="3">Shall be purchased/devloped in later date</option>
              </select>
            </td>
            <td width="15%">Power Sprayer</td>
            <td width="30%"> 
              <select name="sel_powersprayer" onChange="">
                <option value="0" selected="selected">----Select----</option>
                <option value="1">Available</option>
                <option value="2">Provision made in Proposed Scheme</option>
                <option value="3">Shall be purchased/devloped in later date</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td width="29%">Pulper Machinery</td>
            <td width="26%"> 
              <select name="sel_pulper" onChange="">
                <option value="0" selected="selected">----Select----</option>
                <option value="1">Available</option>
                <option value="2">Provision made in Proposed Scheme</option>
                <option value="3">Shall be purchased/devloped in later date</option>
              </select>
            </td>
            <td width="15%">Tractor/Power 
              Triller</td>
            <td width="30%"> 
              <select name="sel_tractor" onChange="">
                <option value="0" selected="selected">----Select----</option>
                <option value="1">Available</option>
                <option value="2">Provision made in Proposed Scheme</option>
                <option value="3">Shall be purchased/devloped in later date</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td width="29%">Smoke/Pulp House</td>
            <td width="26%"> 
              <select name="sel_pulp" onChange="">
                <option value="0" selected="selected">----Select----</option>
                <option value="1">Available</option>
                <option value="2">Provision made in Proposed Scheme</option>
                <option value="3">Shall be purchased/devloped in later date</option>
              </select>
            </td>
            <td width="15%">Drying Yard</td>
            <td width="30%"> 
              <select name="sel_drying" onChange="">
                <option value="0" selected="selected">----Select----</option>
                <option value="1">Available</option>
                <option value="2">Provision made in Proposed Scheme</option>
                <option value="3">Shall be purchased/devloped in later date</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td id="r1" width="29%">Cardamom 
              Drier/Kiln</td>
            <td id="r2" width="26%"> 
              <select name="sel_drier" onChange="">
                <option value="0" selected="selected">----Select----</option>
                <option value="1">Available</option>
                <option value="2">Provision made in Proposed Scheme</option>
                <option value="3">Shall be purchased/devloped in later date</option>
              </select>
            </td>
            <td id="r2" width="15%">Bungalow/Farm 
              House</td>
            <td id="r2" width="30%"> 
              <select name="sel_farmhouse" onChange="">
                <option value="0" selected="selected">----Select----</option>
                <option value="1">Available</option>
                <option value="2">Provision made in Proposed Scheme</option>
                <option value="3">Shall be purchased/devloped in later date</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td width="29%">Staff Quarter</td>
            <td width="26%"> 
              <select name="sel_staffquarter" onChange="">
                <option value="0" selected="selected">----Select----</option>
                <option value="1">Available</option>
                <option value="2">Provision made in Proposed Scheme</option>
                <option value="3">Shall be purchased/devloped in later date</option>
              </select>
            </td>
            <td width="15%">Office Block</td>
            <td width="30%"> 
              <select name="sel_officeblog" onChange="">
                <option value="0" selected="selected">----Select----</option>
                <option value="1">Available</option>
                <option value="2">Provision made in Proposed Scheme</option>
                <option value="3">Shall be purchased/devloped in later date</option>
              </select>
            </td>
          </tr>
           <tr> 
            <td  id="r3" width="29%">Godown</td>
            <td width="26%" > 
              <select name="sel_godown" onChange="">
                <option value="0" selected="selected">----Select----</option>
                <option value="1">Available</option>
                <option value="2">Provision made in Proposed Scheme</option>
                <option value="3">Shall be purchased/devloped in later date</option>
              </select>
            </td>
            <td width="15%" >Garage</td>
            <td width="30%" > 
              <select name="sel_garage" onChange="">
                <option value="0" selected="selected">----Select----</option>
                <option value="1">Available</option>
                <option value="2">Provision made in Proposed Scheme</option>
                <option value="3">Shall be purchased/devloped in later date</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td  id="r4" width="29%">Tea manufacturing unit</td>
            <td width="26%" > 
              <select name="sel_teaunit" onChange="">
                <option value="0" selected="selected">----Select----</option>
                <option value="1">Available</option>
                <option value="2">Provision made in Proposed Scheme</option>
                <option value="3">Shall be purchased/devloped in later date</option>
              </select>
            </td>
            <td width="15%" > Rubber pressing/Sheeting unit</td>
            <td width="30%" > 
              <select name="sel_rubberunit" onChange="">
                <option value="0" selected="selected">----Select----</option>
                <option value="1">Available</option>
                <option value="2">Provision made in Proposed Scheme</option>
                <option value="3">Shall be purchased/devloped in later date</option>
              </select>
            </td>
          </tr>
          
        </table>
      </td>
    </tr>
  </table><br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
  
<lapschoice:agrihiddentag pageid='<%=PageId%>'/>
	<input type="hidden" name="sel_rainfall_text" value="">
	<input type="hidden" name="land_measurement">
	<input type="hidden" name="hidRecordflag" > 

	</form>
</body>

</html>


