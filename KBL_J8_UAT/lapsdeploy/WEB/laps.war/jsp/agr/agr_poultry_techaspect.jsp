<%@include file="../share/directives.jsp"%>
<%ArrayList arryCol = new ArrayList();
ArrayList arryRow = new ArrayList();
			
			arryRow = (ArrayList) hshValues.get("arryRow");
		
			if (arryRow == null) {
				arryRow = new ArrayList();
			}
	String l1="",d1="",u1="",w1="";
	String l2="",d2="",u2="",w2="";
		%>
<html>
<head>
<title>Poultry Tech Details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var id ="";
var txt_distbranch= "<%=Helper.correctNull((String)hshValues.get("txt_distbranch"))%>";
var sel_farm= "<%=Helper.correctNull((String)hshValues.get("sel_farm"))%>" ;
var txr_location = "<%=Helper.correctNull((String)hshValues.get("txr_location" ))%>" ;
var txt_mortorable= "<%=Helper.correctNull((String)hshValues.get("txt_mortorable"))%>";
var txt_environment= "<%=Helper.correctNull((String)hshValues.get("txt_environment"))%>" ;
var txt_aidloc = "<%=Helper.correctNull((String)hshValues.get("txt_aidloc"))%>" ; //chk
var txt_distfarm = "<%=Helper.correctNull((String)hshValues.get("txt_distfarm"))%>" ;
var txt_watersrc= "<%=Helper.correctNull((String)hshValues.get("txt_watersrc"))%>" ;
var txt_waterloc= "<%=Helper.correctNull((String)hshValues.get("txt_waterloc"))%>" ;
var sel_electricity = "<%=Helper.correctNull((String)hshValues.get("sel_electricity"))%>" ;
var txr_electricity = "<%=Helper.correctNull((String)hshValues.get("txr_electricity"))%>" ;
var txt_marketingegg = "<%=Helper.correctNull((String)hshValues.get("txt_marketingegg"))%>" ;
var txt_distegg = "<%=Helper.correctNull((String)hshValues.get("txt_distegg"))%>" ;
var txt_feed= "<%=Helper.correctNull((String)hshValues.get("txt_feed"))%>" ;
var txt_distfeed= "<%=Helper.correctNull((String)hshValues.get("txt_distfeed"))%>" ;
var txt_chicks= "<%=Helper.correctNull((String)hshValues.get("txt_chicks"))%>" ;
var txt_distchicks = "<%=Helper.correctNull((String)hshValues.get("txt_distchicks"))%>" ;
var txr_farm = "<%=Helper.correctNull((String)hshValues.get("txr_farm"))%>" ;
var sel_shed= "<%=Helper.correctNull((String)hshValues.get("sel_shed"))%>" ;
var txt_specify1= "<%=Helper.correctNull((String)hshValues.get("txt_specify1"))%>" ;
var txt_specify2= "<%=Helper.correctNull((String)hshValues.get("txt_specify2"))%>" ;
var sel_rearing= "<%=Helper.correctNull((String)hshValues.get("sel_rearing"))%>" ;
var txt_broodershed= "<%=Helper.correctNull((String)hshValues.get("txt_broodershed"))%>" ;
var txt_growershed= "<%=Helper.correctNull((String)hshValues.get("txt_growershed"))%>" ;
var txt_bgshed = "<%=Helper.correctNull((String)hshValues.get("txt_bgshed"))%>" ;
var txt_layershed= "<%=Helper.correctNull((String)hshValues.get("txt_layershed"))%>" ;
var txt_ashed= "<%=Helper.correctNull((String)hshValues.get("txt_ashed"))%>" ;
var txt_time= "<%=Helper.correctNull((String)hshValues.get("txt_time"))%>" ;
var txt_breed= "<%=Helper.correctNull((String)hshValues.get("txt_breed"))%>" ;
</script>

<script>
function check()
{
  	if(document.forms[0].sel_shed.value == "4")
	{
		document.all.r1.style.visibility="visible";
		document.all.k1.style.visibility="visible";		
	}
	else
	{
		document.all.r1.style.visibility="hidden";
		document.all.k1.style.visibility="hidden";		
		document.forms[0].txt_specify1.value="";
	}
	 if(document.forms[0].sel_rearing.value == "3")
	{
		document.all.r2.style.visibility="visible";
		document.all.k2.style.visibility="visible";
				
	}
	else
	{
		document.all.r2.style.visibility="hidden";
		document.all.k2.style.visibility="hidden";		
		document.forms[0].txt_specify2.value="";
	}
    if(document.forms[0].sel_electricity.value == "2")
	{
		document.all.r3.style.visibility="visible";
				
	}
	else
	{
		document.all.r3.style.visibility="hidden";		
		document.forms[0].txr_electricity.value="";
	}
}


function onloading()
{	  
	document.forms[0].txt_distbranch.value=txt_distbranch;
	document.forms[0].txr_location.value=txr_location;
	
	if(sel_farm!="")
	{
		document.forms[0].sel_farm.value=sel_farm;
	}
	if(sel_electricity!="")
	{
		document.forms[0].sel_electricity.value=sel_electricity;
	}
	if(sel_shed!="")
	{
		document.forms[0].sel_shed.value=sel_shed;
	}
	if(sel_rearing!="")
	{
		document.forms[0].sel_rearing.value=sel_rearing;
	}
	document.forms[0].txt_mortorable.value=txt_mortorable;
	document.forms[0].txt_environment.value=txt_environment;
	document.forms[0].txt_aidloc.value=txt_aidloc;
	document.forms[0].txt_distfarm.value=txt_distfarm;
	document.forms[0].txt_watersrc.value=txt_watersrc;
	document.forms[0].txt_waterloc.value=txt_waterloc;
	document.forms[0].txr_electricity.value=txr_electricity;
	document.forms[0].txt_marketingegg.value=txt_marketingegg;
	document.forms[0].txt_distegg.value=txt_distegg;
	document.forms[0].txt_feed.value=txt_feed;
	document.forms[0].txt_distfeed.value=txt_distfeed;

   	document.forms[0].txt_chicks.value=txt_chicks;
	document.forms[0].txt_distchicks.value=txt_distchicks;
	document.forms[0].txr_farm.value=txr_farm;
	document.forms[0].txt_specify1.value=txt_specify1;
   	document.forms[0].txt_specify2.value=txt_specify2;
	document.forms[0].txt_broodershed.value=txt_broodershed;
	document.forms[0].txt_growershed.value=txt_growershed;
	document.forms[0].txt_bgshed.value=txt_bgshed;
   	document.forms[0].txt_layershed.value=txt_layershed;
	document.forms[0].txt_ashed.value=txt_ashed;
	document.forms[0].txt_time.value=txt_time;
	document.forms[0].txt_breed.value=txt_breed;

	disableFields(true);
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

    if(document.forms[0].txt_aidloc.value=="")
	{
	alert("Enter Veterinary Aid facility");
	document.forms[0].txt_aidloc.focus();
	return;
	}  
	if(document.forms[0].txt_watersrc.value=="")
	{
	alert("Enter Water arrangement");
	document.forms[0].txt_watersrc.focus();
	return;
	} 
    if(document.forms[0].sel_electricity.value=="0")
	{
	alert("Select Electricity ");
	document.forms[0].sel_electricity.focus();
	return;
	}  
	if(document.forms[0].txt_marketingegg.value=="")
	{
	alert("Enter Marketing of Egg/Birds");
	document.forms[0].txt_marketingegg.focus();
	return;
	}  
	if(document.forms[0].txt_feed.value=="")
	{
	alert("Enter MAvalibility of Feed");
	document.forms[0].txt_feed.focus();
	return;
	}  
	if(document.forms[0].txt_chicks.value=="")
	{
	alert("Enter Avalibility of Chicks");
	document.forms[0].txt_chicks.focus();
	return;
	}  
   var len = document.forms[0].sel_farm.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_farm.options[i].selected==true)
		 {
			 document.forms[0].sel_farm1.value = document.forms[0].sel_farm.options[i].text; 
			break;
		 }
	}
	len = document.forms[0].sel_electricity.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_electricity.options[i].selected==true)
		 {
			 document.forms[0].sel_electricity1.value = document.forms[0].sel_electricity.options[i].text; 
			break;
		 }
	}	
	len = document.forms[0].sel_shed.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_shed.options[i].selected==true)
		 {
			 document.forms[0].sel_shed1.value = document.forms[0].sel_shed.options[i].text; 
			break;
		 }
	}	
	len = document.forms[0].sel_rearing.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_rearing.options[i].selected==true)
		 {
			 document.forms[0].sel_rearing1.value = document.forms[0].sel_rearing.options[i].text; 
			break;
		 }
	}	
	
	
    enableButtons(true, true, true, true, true, false);
	document.forms[0].hidBeanId.value="agrpoultry";		
	document.forms[0].hidSourceUrl.value="/action/agr_poultry_techaspect.jsp";
	document.forms[0].hidBeanMethod.value="updatepoultrytechdata";
	document.forms[0].hidBeanGetMethod.value="getpoultrytechdata";
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
		document.forms[0].hidBeanId.value="agrpoultry";
		document.forms[0].hidBeanGetMethod.value="getpoultrytechdata";
		document.forms[0].action=appURL +"action/agr_poultry_techaspect.jsp";
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
	  var len = document.forms[0].sel_farm.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_farm.options[i].selected==true)
		 {
			 document.forms[0].sel_farm1.value = document.forms[0].sel_farm.options[i].text; 
			break;
		 }
	}
	len = document.forms[0].sel_electricity.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_electricity.options[i].selected==true)
		 {
			 document.forms[0].sel_electricity1.value = document.forms[0].sel_electricity.options[i].text; 
			break;
		 }
	}	
	len = document.forms[0].sel_shed.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_shed.options[i].selected==true)
		 {
			 document.forms[0].sel_shed1.value = document.forms[0].sel_shed.options[i].text; 
			break;
		 }
	}	
	len = document.forms[0].sel_rearing.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_rearing.options[i].selected==true)
		 {
			 document.forms[0].sel_rearing1.value = document.forms[0].sel_rearing.options[i].text; 
			break;
		 }
	}	
	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updatepoultrytechdata";
		document.forms[0].hidBeanGetMethod.value="getpoultrytechdata";
		document.forms[0].hidBeanId.value="agrpoultry";
		document.forms[0].hidSourceUrl.value="action/agr_poultry_techaspect.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}

</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body  onload="onloading();check()">
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable border1">
<tr>
 <td>
  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
    <tr class="dataheader"> 
      <td colspan="4" align = "center">Location of proposed farm</td>
    </tr>
    <tr class="dataheader"> 
      <td width="14%" align = "center">Survey Number </td>
      <td width="14%" align = "center">Extent 
        of land  in acres/cents</td>
      <td width="10%" align="center">village</td>
      <td width="15%" align="center">Taluk/District</td>
    </tr>
    <tr> 
      <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(0);
				
				if (arryCol.size() != 0) {
					 
					l1 = Helper.correctNull((String) arryCol.get(2));
					d1 = Helper.correctNull((String) arryCol.get(3));
					u1 = Helper.correctNull((String) arryCol.get(4));
					w1 = Helper.correctNull((String) arryCol.get(5));
					
				}
			
			} else if (arryRow.size() == 0) {
				l1 = "";
				d1 = "";
				u1 = "";
				w1 = "";
				
			}

			%>
      <td align="center"><input type="text" name="txt_syno"  value="<%=l1%>"  size="40%" onKeyPress=""  maxlength="40"></td>
      <td align="center"><input type="text" name="txt_land"  value="<%=d1%>"  size="20%"  maxlength="40" onkeypress="allowNumber(this);"></td>
      <td align="center"><input type="text" name="txt_village"  value="<%=u1%>"  size="20%" onKeyPress="" maxlength="40"></td>
      <td align="center"><input type="text" name="txt_taluk"  value="<%=w1%>"  size="20%" onKeyPress="" maxlength="40"></td>
    </tr>
    <tr> 
      <% 	if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(1);

				if (arryCol.size() != 0) {

					l2= Helper.correctNull((String) arryCol.get(2));
					d2 = Helper.correctNull((String) arryCol.get(3));
					u2 = Helper.correctNull((String) arryCol.get(4));
					w2= Helper.correctNull((String) arryCol.get(5));
					
				}
				

			} else if (arryRow.size() == 0) {
				l2="";
				d2 = "";
				u2 = "";
				w2 = "";
				
			}

			%>
      <td align="center"><input type="text" name="txt_syno"  value="<%=l2%>"  size="40%" onKeyPress="" maxlength="40"></td>
      <td align="center"><input type="text" name="txt_land"  value="<%=d2%>"  size="20%" onkeypress="allowNumber(this);"  maxlength="40"></td>
      <td align="center"><input type="text" name="txt_village"  value="<%=u2%>"  size="20%" onKeyPress="" maxlength="40"></td>
      <td align="center"><input type="text" name="txt_taluk"  value="<%=w2%>"  size="20%" onKeyPress="" maxlength="40"></td>
    </tr>
  </table>

  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
    <tr class="dataheader"> 
      <td colspan="6" align="center">Technical 
        Aspect</td>
    </tr>
    <tr > 
      <td width="16%">Distance from the Branch</td>
      <td width="34%"> 
        <input type="text" name="txt_distbranch"  value="<%=Helper.correctNull((String)hshValues.get("txt_distbranch"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="6">
        (KM)</td>
      <td colspan="4">Whether the proposed 
        farm  
        <select name="sel_farm" onChange="">
          <option value="0" selected>select</option>
          <option value="1">Layer Farming</option>
          <option value="2">Broiler Farming</option>
		   <option value="3">Breeder Farm</option>
		    <option value="4">Hatchery Unit</option>
        </select> </td>
    </tr>
    <tr > 
      <td>Whether the location of the farm is ideal for development</td>
      <td><textarea
											name="txr_location" cols="40" style="text-align:left"
											wrap="VIRTUAL" rows="2" onKeyPress="textlimit(txr_location,3999);notAllowSingleAndDoubleQuote()" onKeyUp="textlimit(this,3999)"></textarea></td>
      <td colspan="4">&nbsp;</td>
    </tr>
    <tr > 
      <td colspan="6" align="left"><strong><b>Whether 
        the proposed farm has as follows:</b></strong></td>
    </tr>
    <tr > 
      <td>Good Mortorable road to farm</td>
      <td><input type="text" name="txt_mortorable"  value="<%=Helper.correctNull((String)hshValues.get("txt_mortorable"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="40"></td>
      <td  >Calm Environment</td>
      <td colspan="3" ><input type="text" name="txt_environment"  value="<%=Helper.correctNull((String)hshValues.get("txt_environment"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="40"></td>
    </tr>
    <tr > 
      <td>Veterinary Aid facility( location)<b class="mantatory">*</b></td>
      <td><input type="text" name="txt_aidloc"  value="<%=Helper.correctNull((String)hshValues.get("txt_aidloc"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="40"></td>
      <td>Distance from farm</td>
      <td colspan="3"> <input type="text" name="txt_distfarm"  value="<%=Helper.correctNull((String)hshValues.get("txt_distfarm"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="6" >
        (KM)</td>
    </tr>
    <tr > 
      <td>Water arrangement(Source)<b class="mantatory">*</b></td>
      <td><input type="text" name="txt_watersrc"  value="<%=Helper.correctNull((String)hshValues.get("txt_watersrc"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="40"></td>
      <td>Location</td>
      <td colspan="3"><input type="text" name="txt_waterloc"  value="<%=Helper.correctNull((String)hshValues.get("txt_waterloc"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="40"></td>
    </tr>
    <tr > 
      <td>Electricity<b class="mantatory">*</b></td>
      <td><select name="sel_electricity" onChange="check()">
          <option value="0" selected>select</option>
          <option value="1">Available</option>
          <option value="2">Not Available</option>
        </select></td>
      <td colspan="4" id="r3"><textarea
											name="txr_electricity" cols="20" style="text-align:left"
											wrap="VIRTUAL" rows="2" onKeyPress="textlimit(txr_electricity,3999);notAllowSingleAndDoubleQuote()"  onKeyUp="textlimit(this,3999)"></textarea></td>
    </tr>
    <tr > 
      <td>Marketing of Egg/Birds(place)<b class="mantatory">*</b></td>
      <td><input type="text" name="txt_marketingegg"  value="<%=Helper.correctNull((String)hshValues.get("txt_marketingegg"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="40"></td>
      <td colspan="3">Distance</td>
      <td width="18%" > 
        <input type="text" name="txt_distegg"  value="<%=Helper.correctNull((String)hshValues.get("txt_distegg"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="6" >
        (KM)</td>
    </tr>
    <tr > 
      <td>Avalibility of Feed(Place)<b class="mantatory">*</b></td>
      <td><input type="text" name="txt_feed"  value="<%=Helper.correctNull((String)hshValues.get("txt_feed"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="40"></td>
      <td colspan="3">Distance</td>
      <td ><input type="text" name="txt_distfeed"  value="<%=Helper.correctNull((String)hshValues.get("txt_distfeed"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="6" >
        (KM)</td>
    </tr>
    <tr > 
      <td>Avalibility of Chicks(Place)<b class="mantatory">*</b></td>
      <td><input type="text" name="txt_chicks"  value="<%=Helper.correctNull((String)hshValues.get("txt_chicks"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="40"></td>
      <td colspan="3">Distance</td>
      <td ><input type="text" name="txt_distchicks"  value="<%=Helper.correctNull((String)hshValues.get("txt_distchicks"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="6" >
        (KM)</td>
    </tr>
    <tr > 
      <td>Who takes care of the farm</td>
      <td><textarea
											name="txr_farm" cols="20" style="text-align:left"
											wrap="VIRTUAL" rows="2" onKeyPress="textlimit(txr_farm,3999);notAllowSingleAndDoubleQuote()"  onKeyUp="textlimit(this,3999)"></textarea></td>
      <td colspan="4">&nbsp;</td>
    </tr>
    <tr > 
      <td>Type of Shed</td>
      <td><select name="sel_shed" onChange="check()">
          <option value="0" selected>select</option>
          <option value="1">Thatched Roof Shed</option>
          <option value="2">Mangalore Tile roof shed</option>
          <option value="3">Asbestos roof shed</option>
          <option value="4">Any other</option>
        </select></td>
      <td colspan="3" id="r1">specify</td>
      <td id="k1"><input type="text" name="txt_specify1"  value="<%=Helper.correctNull((String)hshValues.get("txt_specify1"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="40"></td>
    </tr>
    <tr > 
      <td>Type of rearing</td>
      <td><select name="sel_rearing" onChange="check()">
          <option value="0" selected>select</option>
          <option value="1">Deep Tiler</option>
          <option value="2">Cage System</option>
		   <option value="3">other</option>
        </select></td>
      <td colspan="3" id="r2">specify</td>
      <td id="k2"><input type="text" name="txt_specify2"  value="<%=Helper.correctNull((String)hshValues.get("txt_specify2"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="40"></td>
    </tr>
    <tr class="dataheader"> 
      <td colspan="6" align="center">Ratio 
        between sheds</td>
    </tr>
    <tr class="dataheader"> 
      <td align="center">Type 
        of sheds</td>
      <td align="center">No. 
        of sheds</td>
      <td colspan="3" align="center">Type 
        of sheds</td>
      <td align="center">No. 
        of sheds</td>
    </tr>
    <tr > 
      <td>Brooder Shed</td>
      <td><input type="text" name="txt_broodershed"  value="<%=Helper.correctNull((String)hshValues.get("txt_broodershed"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="3"></td>
      <td colspan="3">Grower Shed</td>
      <td ><input type="text" name="txt_growershed"  value="<%=Helper.correctNull((String)hshValues.get("txt_growershed"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="3"></td>
    </tr>
    <tr > 
      <td>Brooder cum Grower Shed</td>
      <td><input type="text" name="txt_bgshed"  value="<%=Helper.correctNull((String)hshValues.get("txt_bgshed"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="3"></td>
      <td colspan="3">Layer Shed</td>
      <td >
        <input type="text" name="txt_layershed"  value="<%=Helper.correctNull((String)hshValues.get("txt_layershed"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="3">
      </td>
    </tr>
    <tr > 
      <td>All in all out system</td>
      <td><input type="text" name="txt_ashed"  value="<%=Helper.correctNull((String)hshValues.get("txt_ashed"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="3"></td>
      <td colspan="4">&nbsp;</td>
    </tr>
    <tr > 
      <td colspan="2">Time required to complete civil works and purchase of first 
        batch of bird</td>
      <td colspan="4"><input type="text" name="txt_time"  value="<%=Helper.correctNull((String)hshValues.get("txt_time"))%>"  size="20%" onKeyPress="allowNumber(this);" maxlength="6">
        Months</td>
    </tr>
    <tr >
      <td colspan="2">Breed of Birds to be purchased</td>
      <td colspan="4"><input type="text" name="txt_breed"  value="<%=Helper.correctNull((String)hshValues.get("txt_breed"))%>"  size="40%" onKeyPress="allowInteger();" maxlength="8"></td>
    </tr>
  </table>
  </td>
 </tr>
</table>
<br/>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:agrihiddentag pageid="<%=PageId%>"/>
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("recordFlag"))%>">
<input type="hidden" name="sel_farm1" value="">
<input type="hidden" name="sel_electricity1" value="">
<input type="hidden" name="sel_shed1" value="">
<input type="hidden" name="sel_rearing1" value="">
</form>
</body>
</html>



