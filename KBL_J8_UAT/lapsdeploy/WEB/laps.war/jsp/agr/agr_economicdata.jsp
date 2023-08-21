<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Economic Data</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var modeofpur = "<%=Helper.correctNull((String)hshValues.get("agr_modeofpurchase"))%>"
var houseproposed = "<%=Helper.correctNull((String)hshValues.get("agr_houseproposed"))%>" 
var provis = "<%=Helper.correctNull((String)hshValues.get("agr_provisionmode"))%>" 
var elect = "<%=Helper.correctNull((String)hshValues.get("agr_electricity"))%>" 
var grazefacility = "<%=Helper.correctNull((String)hshValues.get("agr_grazefacility"))%>" 
var grazeforest = "<%=Helper.correctNull((String)hshValues.get("agr_grazeforest"))%>"  //chk
var grazepasture = "<%=Helper.correctNull((String)hshValues.get("agr_grazepastureland"))%>" 
var grazeown = "<%=Helper.correctNull((String)hshValues.get("agr_grazeownfield"))%>" 
var consumer = "<%=Helper.correctNull((String)hshValues.get("agr_consumer"))%>"  
var society = "<%=Helper.correctNull((String)hshValues.get("agr_society"))%>"  
var recovery = "<%=Helper.correctNull((String)hshValues.get("agr_recovery"))%>"  
var animals = "<%=Helper.correctNull((String)hshValues.get("agr_animals"))%>"  
var equipment = "<%=Helper.correctNull((String)hshValues.get("agr_equipments"))%>"   
var acquisition = "<%=Helper.correctNull((String)hshValues.get("agr_acquisition"))%>"   
var borrow = "<%=Helper.correctNull((String)hshValues.get("agr_borrower"))%>";
var sel_ver = "<%=Helper.correctNull((String)hshValues.get("sel_ver"))%>";
</script>

<script>
function callLoad()
{
	
 	disablefields(true);
 	check();
 	Grafacility();
 	TieRecovery();
	seladequ()
	modepurchase();
	seladequa();
	selEquipment();
	if(sel_ver!="")
	{
		document.forms[0].sel_ver.value=sel_ver;
	}
	else
	{
		document.forms[0].sel_ver.value ="0";
	}
	if(modeofpur!="")
	{
		document.forms[0].Modepurchase.value=modeofpur;
	}
	else
	{
		document.forms[0].Modepurchase.value ="0";
	}
	if(borrow!="")
	{
		document.forms[0].Borrower.value=borrow;
	}
	else
	{
		document.forms[0].Borrower.value ="0";
	}
	if(houseproposed!="")
	{
		document.forms[0].adequ.value=houseproposed;
	}
	else
	{
		document.forms[0].adequ.value ="0";
	}
	if(provis!="")
	{
		document.forms[0].Provision.value=provis;
	}
	else
	{
		document.forms[0].Provision.value ="0";
	}
	if(elect!="")
	{
		document.forms[0].Electricity.value=elect;
	}
	else
	{
		document.forms[0].Electricity.value ="0";
	}
	if(grazefacility!="")
	{
		document.forms[0].Grazing.value=grazefacility;
	}
	else
	{
		document.forms[0].Grazing.value ="0";
	}
	if(consumer!="")
	{
		document.forms[0].consumer.value=consumer;
	}
	else
	{
		document.forms[0].consumer.value ="0";
	}
	if(society!="")
	{
		document.forms[0].Society.value=society;
	}
	else
	{
		document.forms[0].Society.value ="0";
	}
	if(recovery!="")
	{
		document.forms[0].Recovery.value=recovery;
	}
	else
	{
		document.forms[0].Recovery.value ="0";
	}
	if(animals!="")
	{
		document.forms[0].animals.value=animals;
	}
	else
	{
		document.forms[0].animals.value ="0";
	}
	if(equipment!="")
	{
		document.forms[0].Equipment.value=equipment;
	}
	else
	{
		document.forms[0].Equipment.value ="0";
	}
	if(acquisition!="")
	{
		document.forms[0].acquisition.value=acquisition;
	}
	else
	{
		document.forms[0].acquisition.value ="0";
	}
	if(modeofpur=="2")
	{
	 	document.all.r17.style.visibility="visible";
		document.all.r18.style.visibility="visible";
	}
	if(recovery=="1")
	{
		document.all.r11.style.visibility="visible";
		document.all.r12.style.visibility="visible";
	}
	if(equipment=="2")
	{
		document.all.r25.style.visibility="visible";
		document.all.r26.style.visibility="visible";	
	}
	if(grazefacility=="1")
	{
		document.all.r3.style.visibility="visible";
		document.all.r4.style.visibility="visible";
		document.all.r6.style.visibility="visible";
	}
	if(grazeforest=="Y")
	{
	 	document.forms[0].chkForest.checked=true;
	}
	else
	{
	 	document.forms[0].chkForest.checked=false;
	}
	if(grazepasture=="Y")
	{
	 	document.forms[0].chkParticulars.checked=true;
	}
	else
	{
	 	document.forms[0].chkParticulars.checked=false;
	}
	if(grazeown=="Y")
	{
		document.forms[0].chkfield.checked=true;
	}
	else
	{
	  	document.forms[0].chkfield.checked=false;
	}
	if(acquisition=="2")
	{
		document.all.r14.style.visibility="visible";
		document.all.r15.style.visibility="visible";
	}
	if(borrow=="1")
	{
		document.all.r1.style.visibility="visible";
		document.all.r2.style.visibility="visible";
	}
	if(sel_ver=="1")
	{
		document.all.v1.style.visibility="visible";
		document.all.v2.style.visibility="visible";
		document.all.v3.style.visibility="visible";
	}
	else{
	    document.all.v1.style.visibility="hidden";
		document.all.v2.style.visibility="hidden";
		document.all.v3.style.visibility="hidden";
		document.forms[0].txt_veterinary.value="";
		document.forms[0].txt_disunit.value="";
	}
}
function checkveterinary()
{

if(document.forms[0].sel_ver.value=="1")
	{
		document.all.v1.style.visibility="visible";
		document.all.v2.style.visibility="visible";
		document.all.v3.style.visibility="visible";
	}
	else{
	    document.all.v1.style.visibility="hidden";
		document.all.v2.style.visibility="hidden";
		document.all.v3.style.visibility="hidden";
		document.forms[0].txt_veterinary.value="";
		document.forms[0].txt_disunit.value="";
	}
}
function enableButtons(bool1, bool2, bool3, bool4, bool5, bool6)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}

function doEdit()
{
	disablefields(false);
	enableButtons(true, true, false, false, false, true);	
}

function doSave()
{
	if(document.forms[0].txt_place.value=="")
  	{
   		alert(" Enter Market where animals to be purchased - Place");
   		document.forms[0].txt_place.focus();
   		return;
  	}
  	if(document.forms[0].txt_distance.value=="")
  	{
	    alert("Enter Distance from Unit ");
	    document.forms[0].txt_distance.focus();
	    return;
  	}
  	if(document.forms[0].txt_trans.value=="")
  	{
	   	alert("Enter Mode of Transportation");
	   	document.forms[0].txt_trans.focus();
	   	return;
  	}
  	if(document.forms[0].txt_trans.value=="")
  	{
   		alert("Enter Cost of Transportation");
   		document.forms[0].txt_trans.focus();
   		return;
  	}
   	if(document.forms[0].Modepurchase.value=="0")
   	{
	    alert("Select Mode of Purchase");
	    document.forms[0].Modepurchase.focus();
	    return;
   	}
   	
   if(document.forms[0].Modepurchase.value=="2")
   	{
   	 if(document.forms[0].txt_commitee.value=="")
    {
     	alert("Enter Purchase Commitee Name");
     	document.forms[0].txt_commitee.focus();
     	return;
    }
    }
   	if(document.forms[0].Borrower.value=="0")
   	{
    	alert("select Borrower is selected by any Agency");
    	document.forms[0].Borrower.focus();
    	return;
   	}
   	if(document.forms[0].Borrower.value=="1")
   	{
   	 if(document.forms[0].txt_agency.value=="")
    {
     	alert("Enter Name of Agency");
     	document.forms[0].txt_agency.focus();
     	return;
    }
   	
   	}
   	
    if(document.forms[0].txt_cattle.value=="")
    {
     	alert("Enter Space in Cattle Shed");
     	document.forms[0].txt_cattle.focus();
     	return;
    }
    if(document.forms[0].adequ.value=="0")
    {
     	alert("Adequate for Housing proposed animals");
     	document.forms[0].adequ.focus();
     	return;
    }
     if(document.forms[0].adequ.value=="2")
    {
    if(document.forms[0].Provision.value=="0")
    {
     	alert("Select Whether Provision Now Made");
     	document.forms[0].Provision.focus();
     	return;
    }
     }
      if(document.forms[0].adequ.value=="2")
    {
    if(document.forms[0].Provision.value=="2")
    {
     if(document.forms[0].txt_givereason.value=="")
    {
        alert("Enter Reason");
     	document.forms[0].txt_givereason.focus();
     	return;
     	}
    }
    }
     
    if(document.forms[0].Electricity.value=="0")
    {
    	alert("select Electricity Type");
      	document.forms[0].Electricity.focus();
      	return false;
    }
	if(document.forms[0].txt_water.value=="")
    {
    	alert("Enter Water Facility");
      	document.forms[0].txt_water.focus();
      	return false;
    }
    if(document.forms[0].txt_dry.value=="")
    {
      	alert("Dry/Green fodder Source");
      	document.forms[0].txt_dry.focus();
      	return false;
    }
   
  	if(document.forms[0].Grazing.value=="0")
    {
       	alert("select Grazing Facility Type");
       	document.forms[0].Grazing.focus();
       	return false;
     } 
     if(document.forms[0].txt_markplace.value=="")
     {
       	alert("Enter Market for sale of by products-Place"); 
       	document.forms[0].txt_markplace.focus();
       	return false;
     }
     if(document.forms[0].txt_dsunit.value=="")
     {
      	alert("Enter Distance from Unit");
      	document.forms[0].txt_dsunit.focus();
      	return;
     }
     if(document.forms[0].consumer.value=="0")
     {
      	alert("Select Directly to consumer Type");
      	document.forms[0].consumer.focus();
      	return false;
     }
     if(document.forms[0].Society.value=="")
     {
      	alert("Select Society Type");
      	document.forms[0].Society.focus();
      	return;
     }
     if(document.forms[0].Recovery.value=="0")
     {
      	alert("enter Tie up for Recovery");
      	document.forms[0].Recovery.focus();
      	return false;
     }
     if(document.forms[0].Recovery.value=="1")
     {
     if(document.forms[0].txt_agen.value=="")
     {
      	alert("Enter Agency");
      	document.forms[0].txt_agen.focus();
      	return false;
     }
     
     }
     if(document.forms[0].txt_numunits.value=="")
     {
      	alert("enter Number of similar units");
      	document.forms[0].txt_numunits.focus();
      	return false;
     }
     if(document.forms[0].txt_financing.value=="")
     {
      	alert("Enter Scope for further financing");
      	document.forms[0].txt_financing.focus();
     	return false;
     }
     if(document.forms[0].Equipment.value=="0")
     {
      	alert("Enter Equipments / Utensils -Available");
      	document.forms[0].Equipment.focus();
      	return false;
	}
	 if(document.forms[0].txt_cost.value=="0")
     {
      	alert("Enter Cost of Transportation ");
      	document.forms[0].txt_cost.focus();
      	return false;
	}
	 if(document.forms[0].Society.value=="0")
     {
      	alert("Select Society ");
      	document.forms[0].Society.focus();
      	return false;
	}
	 if(document.forms[0].animals.value=="0")
     {
      	alert("select animals care taker ");
      	document.forms[0].animals.focus();
      	return false;
	}
	 if(document.forms[0].sel_ver.value=="0")
     {
      	alert("Select Veterinary Aid ");
      	document.forms[0].sel_ver.focus();
      	return false;
	}
	if(document.forms[0].sel_ver.value=="1")
     {
	     if(document.forms[0].txt_veterinary.value=="")
	     {
	      	alert("Enter place ");
	      	document.forms[0].txt_veterinary.focus();
	      	return false;
		}
	     
	      if(document.forms[0].txt_disunit.value=="")
	     {
	      	alert("Enter Distance from Unit ");
	      	document.forms[0].txt_disunit.focus();
	      	return false;
		}
     
     }
	var len = document.forms[0].Modepurchase.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].Modepurchase.options[i].selected==true)
		 {
			 document.forms[0].Modepurchase_text.value = document.forms[0].Modepurchase.options[i].text; 
			break;
		 }
	}
	
	len = document.forms[0].animals.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].animals.options[i].selected==true)
		 {
			 document.forms[0].animals_text.value = document.forms[0].animals.options[i].text; 
			break;
		 }
	}
	getValues()
	enableButtons(true, true, false, false, true, true);
	document.forms[0].hidBeanId.value="agreconomic";
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidSourceUrl.value="/action/agr_economicdata.jsp";
	document.forms[0].hidBeanMethod.value="updateEconomicData";
	document.forms[0].hidBeanGetMethod.value="getEconomicData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{
if(ConfirmMsg(102))
  {
   	document.forms[0].hidBeanId.value="agreconomic";
	document.forms[0].hidBeanGetMethod.value="getEconomicData";
	document.forms[0].action=appURL +"action/agr_economicdata.jsp";
	document.forms[0].submit();	 	
  }
}

function doDelete()
{
	var len = document.forms[0].Modepurchase.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].Modepurchase.options[i].selected==true)
		 {
			 document.forms[0].Modepurchase_text.value = document.forms[0].Modepurchase.options[i].text; 
			break;
		 }
	}
	
	len = document.forms[0].animals.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].animals.options[i].selected==true)
		 {
			 document.forms[0].animals_text.value = document.forms[0].animals.options[i].text; 
			break;
		 }
	}
	if(ConfirmMsg(101))
	{
	   	document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidSourceUrl.value="/action/agr_economicdata.jsp";
		document.forms[0].hidBeanMethod.value="updateEconomicData";
		document.forms[0].hidBeanGetMethod.value="getEconomicData";
		document.forms[0].action=appURL+"controllerservlet";
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

function disablefields(one)
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

function selEquipment()
{
 	if(document.forms[0].Equipment.value == "2")
	{
		document.all.r25.style.visibility="visible";
		document.all.r26.style.visibility="visible";
	}
	 else
	{
	  document.all.r25.style.visibility="hidden";
		document.all.r26.style.visibility="hidden";
	}
}

function selProvision()
{
	if(document.forms[0].Provision.value == "2")
	{
		document.all.r32.style.visibility="visible";
		document.all.r33.style.visibility="visible";
	}
	else
	{
	  	document.all.r32.style.visibility="hidden";
		document.all.r33.style.visibility="hidden";
	}
}

function check()
{
	if(document.forms[0].Borrower.value == "1")
	{
		document.all.r1.style.visibility="visible";
		document.all.r2.style.visibility="visible";
	}
	else
	{
	    document.all.r1.style.visibility="hidden";
		document.all.r2.style.visibility="hidden";
	}
}

function Grafacility()
{
  	if(document.forms[0].Grazing.value=="1")
  	{
	    document.all.r3.style.visibility="visible";
	    document.all.r4.style.visibility="visible";
	    document.all.r5.style.visibility="visible";
	    document.all.r6.style.visibility="visible";
  	}
   	else
   	{
     	document.all.r3.style.visibility="hidden";
     	document.all.r4.style.visibility="hidden";
     	document.all.r5.style.visibility="hidden";
     	document.all.r6.style.visibility="hidden";
    }
}

function TieRecovery()
{
  	if(document.forms[0].Recovery.value=="1")
  	{
    	document.all.r11.style.visibility="visible";
    	document.all.r12.style.visibility="visible";
  	}
  	else
  	{
   		document.all.r11.style.visibility="hidden";
   		document.all.r12.style.visibility="hidden";
  	}
}

function seladequa()
{
	if(document.forms[0].acquisition.value=="2")
  	{
   		document.all.r14.style.visibility="visible";
   		document.all.r15.style.visibility="visible";
  	}
 	else
  	{
    	document.all.r14.style.visibility="hidden";
    	document.all.r15.style.visibility="hidden";
  	}
}

function modepurchase()
{
  	if(document.forms[0].Modepurchase.value=="2")
  	{
   		document.all.r17.style.visibility="visible";
   		document.all.r18.style.visibility="visible";
  	}
  	else
  	{
  		document.all.r17.style.visibility="hidden";
   		document.all.r18.style.visibility="hidden";
  	}
}

function seladequ()
{ 
	if(document.forms[0].adequ.value=="1")
  	{
   		document.all.r40.style.visibility="hidden";
   		document.all.r41.style.visibility="hidden";
  	}
  	else
  	{
   		document.all.r40.style.visibility="visible";
   		document.all.r41.style.visibility="visible";
  	}
}

function getValues()
{
	if(document.forms[0].chkForest.checked==true)
	{
		document.forms[0].hid_forest.value="Y";
	}
	else
	{
		document.forms[0].hid_forest.value="N";
	}
	if(document.forms[0].chkParticulars.checked==true)
	{
		document.forms[0].hid_pastureland.value="Y";
	}
	else
	{
		document.forms[0].hid_pastureland.value="N";
	}
	if(document.forms[0].chkfield.checked==true)
	{
		document.forms[0].hid_ownfield.value="Y";
	}
	else
	{
		document.forms[0].hid_ownfield.value="N";
	}
}

function Manditory()
{
 	
     
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callLoad()">
<form name="frmpri" method="post" class="normal">
<br>
  <table width="100%" border="0" cellpadding="5" cellspacing="1" class="outertable border1">
    <tr>
      <td><table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
          <tr> 
            <td colspan="6"><b>All Fields are Mandatory.</b></td>
          </tr>
          <tr> 
            <td width="18%">Market where animals to be purchased - Place<b class="mantatory">*</b></td>
            <td width="15%"> 
            <input type="text" name="txt_place" value="<%=Helper.correctNull((String)hshValues.get("agr_place"))%>"
			onKeyPress="notAllowSplChar()" maxlength="30"></td>
            <td width="17%">Distance from Unit <b class="mantatory">*</b></td>
            <td width="18%"> 
            <input type="text" name="txt_distance" value="<%=Helper.correctNull((String)hshValues.get("agr_distancefrom"))%>"
			size="10%" onKeyPress="allowDecimals(this)" maxlength="8"> KM </td>
            <td width="18%">Mode of Transportation<b class="mantatory">*</b></td>
            <td width="14%"> 
              <input type="text" name="txt_trans"
			value="<%=Helper.correctNull((String)hshValues.get("agr_modeoftransport"))%>"
			onKeyPress="notAllowSplChar()" maxlength="30"></td>
          </tr>
          <tr> 
            <td width="18%">Cost of Transportation Rs<b class="mantatory">*</b><br>
              </td>
            <td width="15%"> 
              <input type="text" name="txt_cost"
			value="<%=Helper.correctNull((String)hshValues.get("agr_costoftransport"))%>"
			onKeyPress="allowInteger()" style="text-align:right"
			 maxlength="9"></td>
            <td nowrap="nowrap" width="17%">Mode of Purchase<b class="mantatory">*</b><br>
              </td>
            <td width="18%"> 
              <select name="Modepurchase" onChange="modepurchase()">
                <option value="0" selected="selected">select</option>
                <option value="1">own arrangements</option>
                <option value="2">Purchase Commitee</option>
              </select></td>
            <td id="r17" width="18%">Purchase Commitee Name<b class="mantatory">*</b></td>
            <td nowrap="nowrap" id="r18" width="14%"> 
              <input type="text" name="txt_commitee"
			value="<%=Helper.correctNull((String)hshValues.get("agr_purcommiteename"))%>"
			onKeyPress="notAllowSplChar()" maxlength="30"></td>
          </tr>
          <tr> 
            <td width="18%">Whether the Borrower is selected by any Agency<b class="mantatory">*</b></td>
            <td width="15%"> 
              <select name="Borrower" onChange="check()">
                <option value="0" selected="selected">select</option>
                <option value="1">Yes</option>
                <option value="2">No</option>
              </select></td>
            <td nowrap="nowrap" id="r1" width="17%">Name of Agency<b class="mantatory">*</b></td>
            <td nowrap="nowrap" id="r2" width="18%"> 
              <input type="text" name="txt_agency"
			value="<%=Helper.correctNull((String)hshValues.get("agr_agency"))%>"
			onKeyPress="notAllowSplChar()" maxlength="20"></td>
            <td width="18%">&nbsp;</td>
            <td width="14%">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="6"><b>Whether Following Infrastructure facility available</b></td>
          </tr>
          <tr> 
            <td width="18%">Space in Cattle Shed<b class="mantatory">*</b></td>
            <td width="15%"> 
              <input type="text" name="txt_cattle"
			value="<%=Helper.correctNull((String)hshValues.get("agr_cattleshed"))%>"
			maxlength="9" size="10" onKeyPress="allowInteger()">Sq/ft </td>
            <td width="17%">Adequate for Housing proposed animals<b class="mantatory">*</b></td>
            <td width="18%"> 
              <select name="adequ" onChange="seladequ()">
                <option value="0">select</option>
                <option value="1">Yes</option>
                <option value="2">No</option>
              </select></td>
            <td nowrap="nowrap" id="r40" width="18%">Whether Provision Now Made<b class="mantatory">*</b></td>
            <td nowrap="nowrap" id="r41" width="14%"> 
              <select name="Provision" onChange="selProvision()">
                <option value="0">select</option>
                <option value="1">Yes</option>
                <option value="2">No</option>
              </select></td>
          </tr>
          <tr> 
            <td nowrap="nowrap" id="r32" width="18%">Reason<b class="mantatory">*</b></td>
            <td nowrap="nowrap" id="r33" width="15%"> 
              <textarea name="txt_givereason" rows="2" cols="20"
			 onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("agr_reason"))%> </textarea> 
            </td>
            <td width="17%">Electricity <b class="mantatory">*</b></td>
            <td width="18%"> 
              <select name="Electricity">
                <option value="0">select</option>
                <option value="1">Available</option>
                <option value="2">Not Available</option>
              </select></td>
            <td width="18%">Water Facility<b class="mantatory">*</b></td>
            <td width="14%"> 
              <input type="text" name="txt_water"
			value="<%=Helper.correctNull((String)hshValues.get("agr_water_facility"))%>"
			maxlength="30" onKeyPress="notAllowSplChar()"></td>
          </tr>
          <tr> 
            <td width="18%">Dry/Green fodder Source<b class="mantatory">*</b></td>
            <td width="15%"> 
              <input type="text" name="txt_dry"
			value="<%=Helper.correctNull((String)hshValues.get("agr_foddersource"))%>"
			maxlength="30" onKeyPress="notAllowSplChar()"></td>
            <td nowrap="nowrap" width="17%">Veterinary Aid<b class="mantatory">*</b>
              <select name="sel_ver" onChange="checkveterinary()">
                <option value="0">select</option>
                <option value="1">Available</option>
                <option value="2">Not Available</option>
              </select>
              </td>
            <td id="v1" width="18%">place<b class="mantatory">*</b>
              <input type="text" name="txt_veterinary"
			value="<%=Helper.correctNull((String)hshValues.get("agr_veterinaryaid"))%>"
			onKeyPress="notAllowSplChar()" maxlength="30">
            </td>
            <td width="18%" id="v2">Distance 
              from Unit<b class="mantatory">*</b></td>
            <td width="14%" id="v3"> 
              <input type="text" name="txt_disunit" size="10"
			value="<%=Helper.correctNull((String)hshValues.get("agr_veterinarydistance"))%>"
			onKeyPress="allowDecimals(this)" maxlength="9">KM </td>
          </tr>
          <tr> 
            <td width="18%">Grazing Facility<b class="mantatory">*</b></td>
            <td width="15%"> 
              <select name="Grazing" onChange="Grafacility()">
                <option value="0" selected="selected">select</option>
                <option value="1">Available</option>
                <option value="2">Not Available</option>
              </select></td>
            <td nowrap="nowrap" id="r3" width="17%"> 
              <input
			type="checkbox" name="chkForest" value="checkbox" style="border:none"
			onclick="getValues()">
              &nbsp; Forest</td>
            <td nowrap="nowrap" id="r4" width="18%"> 
              <input type="checkbox" name="chkParticulars"
			value="checkbox" style="border:none" onclick="getValues()">&nbsp;Pasture Land</td>
            <td nowrap="nowrap" id="r5" width="18%">&nbsp;</td>
            <td id="r6" width="14%"> 
              <input type="checkbox" name="chkfield" value="checkbox"
			style="border:none" onclick="getValues()"> &nbsp; Own field</td>
          </tr>
          <tr> 
            <td nowrap="nowrap" width="18%">Market for sale of by products-Place<b class="mantatory">*</b></td>
            <td width="15%"> 
              <input type="text" name="txt_markplace"
			value="<%=Helper.correctNull((String)hshValues.get("agr_marketsale"))%>"
			onKeyPress="notAllowSplChar()" maxlength="30"></td>
            <td width="17%">Distance from Unit<b class="mantatory">*</b></td>
            <td width="18%"> 
              <input type="text" name="txt_dsunit"
			value="<%=Helper.correctNull((String)hshValues.get("agr_marketdistancefrom"))%>"
			onKeyPress="allowDecimals(this)" maxlength="9"></td>
            <td width="18%">Directly to consumer<b class="mantatory">*</b></td>
            <td width="14%"> 
              <select name="consumer">
                <option value="0">select</option>
                <option value="1">Yes</option>
                <option value="2">No</option>
              </select></td>
          </tr>
          <tr> 
            <td width="18%">Society<b class="mantatory">*</b></td>
            <td width="15%"> 
              <select name="Society">
                <option value="0">select</option>
                <option value="1">Yes</option>
                <option value="2">No</option>
              </select></td>
            <td width="17%">Tie up for Recovery<b class="mantatory">*</b></td>
            <td width="18%"> 
              <select name="Recovery" onChange="TieRecovery()">
                <option value="0">select</option>
                <option value="1">Yes</option>
                <option value="2">No</option>
              </select></td>
            <td nowrap="nowrap" id="r11" width="18%">Agency<b class="mantatory">*</b></td>
            <td nowarp="nowrap" id="r12" width="14%"> 
              <input type="text" name="txt_agen"
			value="<%=Helper.correctNull((String)hshValues.get("agr_recoveryagency"))%>"
			onKeyPress="notAllowSplChar()" maxlength="30"></td>
          </tr>
          <tr> 
            <td width="18%">Who is the care 
              taker of animals<b class="mantatory">*</b></td>
            <td width="15%"> 
              <select name="animals">
                <option value="0">select</option>
                <option value="1">Self/Members of Family</option>
                <option value="2">Labourer</option>
                <option value="3">Both</option>
              </select></td>
            <td nowrap width="17%">Number 
              of similar units<b class="mantatory">*</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td width="18%"> 
              <input type="text" name="txt_numunits"
			value="<%=Helper.correctNull((String)hshValues.get("agr_noofunits"))%>"
			onKeyPress="allowInteger()" maxlength="9"></td>
            <td width="18%">Scope for further 
              financing<b class="mantatory">*</b></td>
            <td width="14%"> 
              <input type="text" name="txt_financing"
			value="<%=Helper.correctNull((String)hshValues.get("agr_scopefinance"))%>"
			onKeyPress="notAllowSplChar()" maxlength="30"></td>
          </tr>
          <tr> 
            <td width="18%">Equipments / Utensils 
              -Available<b class="mantatory">*</b></td>
            <td width="15%"> 
              <select name="Equipment" onChange="selEquipment()">
                <option value="0">select</option>
                <option value="1">Yes</option>
                <option value="2">No</option>
              </select></td>
            <td id="r25" width="17%">Whether 
              provision made for acquisition<b class="mantatory">*</b></td>
            <td id="r26" width="18%"> 
              <select name="acquisition" onChange="seladequa()">
                <option value="0">Select</option>
                <option value="1">Yes</option>
                <option value="2">No</option>
              </select></td>
            <td nowrap="nowrap" id="r14" width="18%">Reason<b class="mantatory">*</b></td>
            <td nowrap="nowrap" id="r15" width="14%"> 
              <textarea name="txt_reason" rows="2" cols="20"
		onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"> <%=Helper.correctNull((String) hshValues.get("agr_acq_reason"))%>  </textarea></td>
          </tr>
        </table></td>
    </tr>
  </table>
  <br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
 
<br>
<input type="hidden" name="hid_forest" value="">
<input type="hidden" name="hid_pastureland" value="">
<input type="hidden" name="hid_ownfield" value=""> 
<input type="hidden" name="Modepurchase_text" value="">
<input type="hidden" name="animals_text" value="">
<lapschoice:agrihiddentag pageid="<%=PageId%>"/>
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("auditFlag"))%>">	
</form>
</body>
</html>

