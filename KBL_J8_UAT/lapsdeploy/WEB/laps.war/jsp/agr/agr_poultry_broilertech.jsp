<%@include file="../share/directives.jsp"%>

<%
	ArrayList arryCol = new ArrayList();
	ArrayList arryRow = new ArrayList();
	ArrayList arryColumn = new ArrayList();
	arryRow = (ArrayList) hshValues.get("arryRow");
	if (arryRow == null) 
	{
		arryRow = new ArrayList();
	}
	else
	{
		if (arryRow.size() > 0) 
		{
			arryColumn = (ArrayList) arryRow.get(0);
		}
		
	}
	String l1="",d1="",u1="",w1="",us1="",ds1="";
	String l2="",d2="",u2="",w2="",us2="",ds2="";
    String strappno =Helper.correctNull((String)request.getParameter("appno"));
	if (strappno.equalsIgnoreCase("new")) 
	{
		strappno = "";
	}
	
	String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
	if(schemetype. trim().equalsIgnoreCase(""))
		{
			schemetype="0";
		}
	
	String strFacSNo=Helper.getfacilitySno(schemetype);
	String strTypeofpoultry=Helper.correctNull((String)hshValues.get("poultry_poultrytype"));
	
	
%>
<html>
<head>
<title></title>


<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>

<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var id ="";
var txt_distbranch= "<%=Helper.correctNull((String)hshValues.get("txt_distbranch"))%>";
//var sel_farm= "<%=Helper.correctNull((String)hshValues.get("sel_farm"))%>" ;
var txr_location = "<%=Helper.correctNull((String)hshValues.get("txr_location" ))%>" ;
var sel_mortorable= "<%=Helper.correctNull((String)hshValues.get("txt_mortorable"))%>";

var txt_environment= "<%=Helper.correctNull((String)hshValues.get("txt_environment"))%>" ;
var txt_aidloc = "<%=Helper.correctNull((String)hshValues.get("txt_aidloc"))%>" ; //chk
var txt_distfarm = "<%=Helper.correctNull((String)hshValues.get("txt_distfarm"))%>" ;
var sel_watersrc= "<%=Helper.correctNull((String)hshValues.get("txt_watersrc"))%>" ;
var txt_waterloc= "<%=Helper.correctNull((String)hshValues.get("txt_waterloc"))%>" ;
var sel_electricity = "<%=Helper.correctNull((String)hshValues.get("sel_electricity"))%>" ;
var txr_electricity = "<%=Helper.correctNull((String)hshValues.get("txr_electricity"))%>" ;
var txt_marketingegg = "<%=Helper.correctNull((String)hshValues.get("txt_marketingegg"))%>" ;
var txt_distegg = "<%=Helper.correctNull((String)hshValues.get("txt_distegg"))%>" ;
var txt_feed= "<%=Helper.correctNull((String)hshValues.get("txt_feed"))%>" ;
var txt_distfeed= "<%=Helper.correctNull((String)hshValues.get("txt_distfeed"))%>" ;
var txt_chicks= "<%=Helper.correctNull((String)hshValues.get("txt_chicks"))%>" ;
var txt_distchicks = "<%=Helper.correctNull((String)hshValues.get("txt_distchicks"))%>" ;
var txr_farm = "<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)hshValues.get("txr_farm")))%>" ;
var sel_shed= "<%=Helper.correctNull((String)hshValues.get("sel_shed"))%>" ;
var txt_specify1= "<%=Helper.correctNull((String)hshValues.get("txt_specify1"))%>" ;
var txt_specify2= "<%=Helper.correctNull((String)hshValues.get("txt_specify2"))%>" ;
var sel_rearing= "<%=Helper.correctNull((String)hshValues.get("sel_rearing"))%>" ;
var txt_broodershed= "<%=Helper.correctNull((String)hshValues.get("txt_broodershed"))%>" ;
var txt_growershed= "<%=Helper.correctNull((String)hshValues.get("txt_growershed"))%>" ;
var txt_bgshed = "<%=Helper.correctNull((String)hshValues.get("txt_bgshed"))%>" ;
var txt_layershed= "<%=Helper.correctNull((String)hshValues.get("txt_layershed"))%>" ;
var sel_ashed= "<%=Helper.correctNull((String)hshValues.get("sel_ashed"))%>" ;
var txt_time= "<%=Helper.correctNull((String)hshValues.get("txt_time"))%>" ;
var txt_breed= "<%=Helper.correctNull((String)hshValues.get("txt_breed"))%>" ;
var varsel_Poultry="<%=Helper.correctNull((String)hshValues.get("poultry_poultrytype"))%>" ;
var schemetype="<%=schemetype%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varPoulrtyFlag="<%=Helper.correctNull((String)hshValues.get("strPolutryFlag"))%>";
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
		document.all.r2.style.position="relative";
		document.all.k2.style.visibility="visible";
		document.all.k2.style.position="relative";
		document.all.e1.style.visibility="hidden";
		document.all.e1.style.position="absolute";
				
	}
	else
	{
		document.all.r2.style.visibility="hidden";
		document.all.r2.style.position="absolute";
		document.all.k2.style.visibility="hidden";
		document.all.k2.style.position="absolute";
		document.all.e1.style.visibility="visible";
		document.all.e1.style.position="relative";
		
		document.forms[0].txt_specify2.value="";
	}
    if(document.forms[0].sel_electricity.value == "2")
	{
		document.all.r3.style.visibility="visible";
				
	}
	else
	{
		document.all.r3.style.visibility="hidden";		
		//document.forms[0].txr_electricity.value="";
	}
}


function onloading()
{	  
	
	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
	     enableButtons(false, true, true, true, false);
		}
		else
		{
			enableButtons(true, true, true, true, false);
		}
	}
	else
	{
		enableButtons(true, true, true, true, false);
	}
	var strUserMode="";
	strUserMode=document.forms[0].hidUsrMode.value;
	document.forms[0].txt_distbranch.value=txt_distbranch;
	document.forms[0].txr_location.value=txr_location;
	
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
	if(sel_ashed!="")
	{
		document.forms[0].sel_ashed.value=sel_ashed;
	}
	
	document.forms[0].sel_mortorable.value=sel_mortorable;
	document.forms[0].txt_environment.value=txt_environment;
	document.forms[0].txt_aidloc.value=txt_aidloc;
	document.forms[0].txt_distfarm.value=txt_distfarm;
	document.forms[0].sel_watersrc.value=sel_watersrc;
	document.forms[0].txt_waterloc.value=txt_waterloc;
	document.forms[0].txr_electricity.value=txr_electricity;
	document.forms[0].txt_marketingegg.value=txt_marketingegg;
	document.forms[0].txt_distegg.value=txt_distegg;
	document.forms[0].txt_feed.value=txt_feed;
	document.forms[0].txt_distfeed.value=txt_distfeed;

    document.forms[0].txt_chicks.value=txt_chicks;
	document.forms[0].txt_distchicks.value=txt_distchicks;
	if(txr_farm=="")
	{
		document.forms[0].txr_farm.value="0";
	}
	else
	{
		document.forms[0].txr_farm.value=txr_farm;
	}
	//document.forms[0].txr_farm.value=txr_farm;
	document.forms[0].txt_specify1.value=txt_specify1;
    document.forms[0].txt_specify2.value=txt_specify2;
	document.forms[0].txt_broodershed.value=txt_broodershed;
	document.forms[0].txt_growershed.value=txt_growershed;
	document.forms[0].txt_bgshed.value=txt_bgshed;
    document.forms[0].txt_layershed.value=txt_layershed;
	document.forms[0].sel_ashed.value=sel_ashed;
	document.forms[0].txt_time.value=txt_time;
	document.forms[0].txt_breed.value=txt_breed;

	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=schemetype;
	disableFields(true); 
	document.all.id_type.style.visibility="hidden";
	document.all.id_type.style.position="absolute";//Prakash
	document.forms[0].txtperapp_permdistrict.readOnly=true;
	document.forms[0].txtperapp_district.readOnly=true;

	 
	document.forms[0].sel_poultry.value=varsel_Poultry;

	if(varPoulrtyFlag=="Y")
	{
		enableButtons(true, true, true, true, false);
	}
	
	
}
function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled = bool5;
}
function doSave()
{   
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
	
	if(document.forms[0].sel_poultry.value=="")
	{
		alert("Select the Type of Poultry");
		document.forms[0].sel_poultry.focus();
        return;
	
	}
	else
	{
    enableButtons(true, true, false, false, true, true);
	document.forms[0].hidBeanId.value="agriloanassessment";		
	document.forms[0].hidSourceUrl.value="/action/agr_poultry_broilertech.jsp";
	document.forms[0].hidBeanMethod.value="updatepoultrytechdata";
	document.forms[0].hidBeanGetMethod.value="getpoultrytechdata";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
	}
}
function doEdit()
{
 	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	enableButtons(true, false, false, false, false);	
	document.forms[0].txtperapp_permdistrict.readOnly=true;
	document.forms[0].txtperapp_district.readOnly=true;	
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		//document.forms[0].hidSourceUrl.value="/action/agr_poultry_broilertech.jsp";
		document.forms[0].hidBeanId.value="agriloanassessment";
		document.forms[0].hidBeanGetMethod.value="getpoultrytechdata";
		document.forms[0].action=appUrl +"action/agr_poultry_broilertech.jsp";
		document.forms[0].submit(); 		
	}	

}



function doClose()
{
if( ConfirmMsg(100))
	{
		parent.menuFrame.doWindowClose();
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
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=one;
		}	   
	}
}


function doDelete()
{
	if(<%=arryRow.size()%> != 0 && <%=arryColumn.size()%> !=0)
	{
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
		if( ConfirmMsg(101))
		{
			document.forms[0].hidAction.value ="delete";
			document.forms[0].action=appUrl+"action/ControllerServlet";	
			document.forms[0].hidBeanMethod.value="updatepoultrytechdata";
			document.forms[0].hidBeanGetMethod.value="getpoultrytechdata";
			document.forms[0].hidBeanId.value="agriloanassessment";
			document.forms[0].hidSourceUrl.value="action/agr_poultry_broilertech.jsp";	
			document.forms[0].method="post";			
			document.forms[0].submit();	
		}	
	}
	else
	{
		ShowAlert("167");
		return;
	}
	
}


function showDistSearch(val)
{ 
vreg = "REG";
vcorp = "CORP";
vadm = "ADM";
varreg = document.forms[0].hidperapp_state.value;  
varcorp = document.forms[0].hidperapp_permstate.value;
varadm = document.forms[0].hidperapp_adminstate.value;	
if(val == "REG")
{
var varQryString = appURL+"action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="+varreg+"&code="+vreg;
var title = "District";
var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
prop = prop + ",left=200,top=200";
window.open(varQryString,title,prop);
}
if(val == "CORP")
{
var varQryString = appURL+"action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="+varcorp+"&code="+vcorp;
var title = "District";
var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
prop = prop + ",left=200,top=200";
window.open(varQryString,title,prop);
}
if(val == "ADM")
{
if(document.forms[0].txtperapp_admincity.value=="")
{
	ShowAlert(112,"City");
	document.forms[0].txtperapp_admincity.focus();
	return;
}
else		
{
var varQryString = appURL+"action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="+varadm+"&code="+vadm;
var title = "District";
var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
prop = prop + ",left=200,top=200";
window.open(varQryString,title,prop);
}
}
}

function fununits()
{

	var varhidunits =document.forms[0].hidunits.value;
	var varhidunits1 =document.forms[0].hidunits1.value;

	if(varhidunits!="0")
	{
		document.forms[0].sel_units[0].value=varhidunits;
	}
	else
	{
		document.forms[0].sel_units[0].value="0";
	}

	if(varhidunits1!="0")
	{	
	document.forms[0].sel_units[1].value=varhidunits1;
	}
	else
	{
		document.forms[0].sel_units.value="0";
		
	}
	
}

function hidefields()
{
	if(document.forms[0].sel_poultry.value=="1")
	{
		document.all.Hatching1.style.visibility="visible";
		document.all.Hatching1.style.position="relative";
		document.all.Hatching2.style.visibility="visible";
		document.all.Hatching2.style.position="relative";
		document.all.Hatching.style.visibility="visible";
		document.all.Hatching.style.position="relative";
		document.all.Hatching5.style.visibility="visible";
		document.all.Hatching5.style.position="relative";
		document.all.Hatching6.style.visibility="visible";
		document.all.Hatching6.style.position="relative";
		document.all.Hatching7.style.visibility="visible";
		document.all.Hatching7.style.position="relative";
		
		document.all.Hatching3.style.visibility="hidden";
		document.all.Hatching3.style.position="absolute";
		document.all.Hatching4.style.visibility="hidden";
		document.all.Hatching4.style.position="absolute";
	}
	else
	{
		document.all.Hatching1.style.visibility="hidden";
		document.all.Hatching1.style.position="absolute";
		document.all.Hatching2.style.visibility="hidden";
		document.all.Hatching2.style.position="absolute";
		document.all.Hatching.style.visibility="hidden";
		document.all.Hatching.style.position="absolute";
		document.all.Hatching5.style.visibility="hidden";
		document.all.Hatching5.style.position="absolute";
		document.all.Hatching6.style.visibility="hidden";
		document.all.Hatching6.style.position="absolute";
		document.all.Hatching7.style.visibility="hidden";
		document.all.Hatching7.style.position="absolute";
		
		
		document.all.Hatching3.style.visibility="visible";
		document.all.Hatching3.style.position="relative";
		document.all.Hatching4.style.visibility="visible";
		document.all.Hatching4.style.position="relative";
	}
}
function callCalender(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		 showCal(appUrl,val);
	}
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
	
</head>
<body onload="onloading();check();fununits();hidefields()">
	
<form name="frmpri1" method="post" class="normal">

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

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
            <td class="page_flow">Home -> Agriculture -> Tech Data</td>
	</tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="97" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>
<br>

<table width="45%" border="0" cellspacing="1" cellpadding="5"  class="outertable">
<tr>
<td>Type of Poultry &nbsp;<span class="mantatory">*</span></td>
<td> <select name="sel_poultry" onChange="hidefields()">
<option value="">---Select---</option>
<option value="1">Poultry Breeding Firm (Hatcheries)</option>
<option value="2">Layers (1+1+5)</option>
<option value="4">Layers(1+1+3)</option>
<option value="3">Broiler</option>
</select>
</td>
</tr>
</table>

<table width="100%" border="0" cellspacing="1" cellpadding="5"  align="center" class="outertable">
 <tr>
 
 <td width="100%">
 	<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">	
     
	<tr class="dataheader">		
            <td width="4%" align="center">S.No</td>		
            <td width="32%" align="center">Particulars</td>
			<td width="22%" align="center">Breed</td>		
            <td width="20%" align="center">No</td>		
     </tr>
	
	<tr class="datagrid">		
            <td width="4%" align="center">1.</td>		
            <td width="32%">Birds - Presently owned</td>
            <td width="22%" align="center"> 
              <input type="text" name="txt_breed_owned" size="30" maxlength="50"  onKeyPress="allowAlphabets()" value="<%=Helper.correctNull((String)hshValues.get("txt_breed_owned"))%>"></td>		
            <td width="20%" align="center"> 
              <input type="text" name="txt_noofunits_owned" size="15" maxlength="15" onKeyPress="allowDecimals(this)" style="text-align: right" value="<%=Helper.correctNull((String)hshValues.get("txt_noofunits_owned"))%>"></td>
	</tr>
	<tr class="datagrid">
		    <td width="4%" align="center">2.</td>
		    <td width="32%">Birds Proposed to be purchased</td>
		    <td width="22%" align="center"> 
              <input type="text" name="txt_breed" size="30" maxlength="9"  onKeyPress="allowAlphabets()" value="<%=Helper.correctNull((String)hshValues.get("txt_breed"))%>"></td>
            <td width="20%" align="center"> 
              <input type="text" name="txt_noofunits_purchased" size="15" maxlength="15"  onKeyPress="allowDecimals(this)" style="text-align: right" value="<%=Helper.correctNull((String)hshValues.get("txt_noofunits_purchased"))%>"></td>
	</tr>
</table>
</td>
 </tr>
 <tr>
 <td>
  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
  	<tr> 
      <td colspan="6" align = "center" class="dataheader">Location 
        of proposed farm</td>
    </tr>
    <tr> 
      <td width="14%" align = "center" class="dataheader">Sy 
        no. </td>
       <td width="14%" align = "center" class="dataheader">Units </td>
      <td width="14%" align = "center" class="dataheader">Extent 
        of land  in hectre/ares</td>
      <td width="10%" align="center" class="dataheader">village</td>
      <td width="15%" align="center" class="dataheader">Taluk</td>
      <td width="15%" align="center" class="dataheader">District</td>
    </tr>
    <tr class="datagrid"> 
      <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(0);
				
				if (arryCol.size() != 0) {
					 
					l1 =Helper.correctNull((String) arryCol.get(2));
					d1 =Helper.correctNull((String) arryCol.get(3));
					u1 =Helper.correctNull((String) arryCol.get(4));
					w1 =Helper.correctNull((String) arryCol.get(5));
					us1=Helper.correctNull((String) arryCol.get(6));
					ds1=Helper.correctNull((String) arryCol.get(7));
					
				}
			
			} else if (arryRow.size() == 0) {
				l1 = "";
				d1 = "";
				u1 = "";
				w1 = "";
				us1="0";
				ds1="";
					
				
			}

			%>
      <td align="center"><input type="text" name="txt_syno"  value="<%=l1%>"  size="40%"   maxlength="50"></td>
      
      <td align="center"><select name="sel_units" onchange="">
       <option value="0">--Select--</option>
       <lapschoice:StaticDataNewTag apptype="121"/></select></td>
       
      <td align="center"><input type="text" name="txt_land"  value="<%=d1%>"  size="20%"  maxlength="10"></td>
      <td align="center"><input type="text" name="txt_village"  value="<%=u1%>"  size="20%"  maxlength="50"></td>
      <td align="center"><input type="text" name="txt_taluk"  value="<%=w1%>"  size="25%"  maxlength="50"></td>
       <td>
          <input type="text" name="txtperapp_district" size="21" maxlength="20" value="<%=ds1%>"
		   onKeyPress="notallowInteger()">&nbsp;<a href="#"	onClick="showDistSearch('REG');"style="cursor:hand" tabindex="22"><img
		   src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex=""></a>
	      <input type="hidden" name="hidperapp_dist" size="5" value="<%=Helper.correctNull((String)hshValues.get(""))%>">		
	      <input type="hidden" name="hidperapp_state" size="5" value="<%=Helper.correctNull((String)hshValues.get(""))%>">
	    		
	  </td>
      
      
      
      
    </tr>
    <tr class="datagrid"> 
      <% 	if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(1);		

				if (arryCol.size() != 0) {

					l2=Helper.correctNull((String) arryCol.get(2));
					d2 =Helper.correctNull((String) arryCol.get(3));
					u2 =Helper.correctNull((String) arryCol.get(4));
					w2=Helper.correctNull((String) arryCol.get(5));
					us2=Helper.correctNull((String) arryCol.get(6));
					ds2=Helper.correctNull((String) arryCol.get(7));
					
				}
				

			} else if (arryRow.size() == 0) {
				l2="";
				d2 = "";
				u2 = "";
				w2 = "";
				us2 = "0";
				ds2="";
				
			}

			%>
      <td align="center"><input type="text" name="txt_syno"  value="<%=l2%>"  size="40%"  maxlength="50"></td>
      
      <td align="center"><select name="sel_units" onchange="">
      <option value="">--Select--</option>
     <lapschoice:StaticDataNewTag apptype="121"/></select></td>
      
      <td align="center"><input type="text" name="txt_land"  value="<%=d2%>"  size="20%"   maxlength="50"></td>
      <td align="center"><input type="text" name="txt_village"  value="<%=u2%>"  size="20%"  maxlength="50"></td>
      <td align="center"><input type="text" name="txt_taluk"  value="<%=w2%>"  size="25%"  maxlength="50"></td>
      <td>
          <input type="text" name="txtperapp_permdistrict" size="21" maxlength="20" value="<%=ds2%>"
		   onKeyPress="notallowInteger()">&nbsp;<a href="#"	onClick="showDistSearch('CORP');"style="cursor:hand" tabindex="22"><img
		   src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex=""></a>
	      <input type="hidden" name="hidperapp_permdist" size="5" value="<%=Helper.correctNull((String)hshValues.get(""))%>">		
	      <input type="hidden" name="hidperapp_permstate" size="5" value="<%=Helper.correctNull((String)hshValues.get(""))%>">
	      <input type="hidden" name="hidperapp_adminstate" size="5" value="<%=Helper.correctNull((String)hshValues.get("perapp_state_code"))%>">		
	  </td>
       
    </tr>
  </table>

  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
    <tr> 
      <td colspan="6" align="center" class="dataheader">Technical 
        Aspect</td>
    </tr>
    <tr class="datagrid"> 
      <td width="16%">Distance from the Branch</td>
      <td width="35%" colspan="5"> <input type="text" name="txt_distbranch"  value="<%=Helper.correctNull((String)hshValues.get("txt_distbranch"))%>" style="text-align:right" size="20%" onKeyPress="allowNumber(this)" maxlength="6">
        (KM)</td>
    </tr>
    <tr class="datagrid"> 
      <td>Whether the location of the farm 
        is ideal for development</td>
      <td><textarea
											name="txr_location" cols="40" style="text-align:left"
											wrap="VIRTUAL" rows="2" onKeyPress="checkEnter();textlimit(txr_location,600);notAllowSingleAndDoubleQuote()"></textarea></td>
    
      <td colspan="4">&nbsp;</td>
    </tr>
    <tr class="datagrid"> 
      <td colspan="6" align="left"><strong>Whether 
        the proposed farm has as follows:</strong></td>
    </tr>
    <tr class="datagrid"> 
      <td>Good Motorable road to farm</td>
      <!--<td><input type="text" name="txt_mortorable"  value="<%=Helper.correctNull((String)hshValues.get("txt_mortorable"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="50"></td>  -->
      <td> <select  name="sel_mortorable">
           <option value="">---Select---</option>
           <option value="1">Yes</option>
           <option   value="2">No</option>
           </select>
      </td>
     
      <td>Calm Environment</td>
      <td colspan="3"><input type="text" name="txt_environment"  value="<%=Helper.correctNull((String)hshValues.get("txt_environment"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="49"></td>
    
   
    </tr>
    <tr class="datagrid"> 
      <td>Veterinary Aid facility( location)</td>
      <td><input type="text" name="txt_aidloc"  value="<%=Helper.correctNull((String)hshValues.get("txt_aidloc"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="49"></td>
      <td>Distance from farm</td>
      <td colspan="3"> <input type="text" name="txt_distfarm"  value="<%=Helper.correctNull((String)hshValues.get("txt_distfarm"))%>" style="text-align:right" size="20%" onKeyPress="allowNumber(this)" maxlength="6">
        (KM)</td>
    </tr>
    <tr class="datagrid"> 
      <td>Water arrangement(Source)</td><!--
      <td><input type="text" name="txt_watersrc"  value="<%=Helper.correctNull((String)hshValues.get("txt_watersrc"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="49"></td>
      -->
      <td><select name="sel_watersrc">
      <option value="">---Select--</option>
      <option value="1">Well</option>
      <option value="2">Tank</option>
      <option value="3">Canal</option>
      <option value="4">Stream</option>
       <option value="5">Others</option>
      
      </select>
      
      <td>Location</td>
            <td colspan="3">
              <input type="text" name="txt_waterloc"  value="<%=Helper.correctNull((String)hshValues.get("txt_waterloc"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="50">
            </td>
    </tr>
    <tr class="datagrid"> 
      <td>Electricity</td>
      <td><select name="sel_electricity" onChange="check()">
          <option value="0" selected>--Select--</option>
          <option value="1">Available</option>
          <option value="2">Not Available</option>
        </select></td>
        <span id="r3">
        	<td>Details</td>
      		<td colspan="3"><textarea name="txr_electricity" cols="20" style="text-align:left" wrap="VIRTUAL" rows="2" onKeyPress="checkEnter();textlimit(txr_electricity,3999);notAllowSingleAndDoubleQuote()" onKeyUp="textlimit(this,3999)"></textarea></td>
      	</span>
      	
    </tr>
    <tr class="datagrid"> 
      <td>Marketing of Egg/Cells(place)</td>
      <td><input type="text" name="txt_marketingegg"  value="<%=Helper.correctNull((String)hshValues.get("txt_marketingegg"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="49"></td>
      <td>Distance</td>
      <td width="18%" colspan="3"> <input type="text" name="txt_distegg"  value="<%=Helper.correctNull((String)hshValues.get("txt_distegg"))%>"  size="20%" style="text-align:right" onKeyPress="allowInteger()" maxlength="7">
        (KM)</td>
    </tr>
    <tr class="datagrid"> 
      <td>Avalibility of Feed(Place)</td>
      <td><input type="text" name="txt_feed"  value="<%=Helper.correctNull((String)hshValues.get("txt_feed"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="50"></td>
      <td>Distance</td>
      <td colspan="3"><input type="text" name="txt_distfeed"  value="<%=Helper.correctNull((String)hshValues.get("txt_distfeed"))%>"  size="20%" style="text-align:right" onKeyPress="allowInteger()" maxlength="7">
        (KM)</td>
    </tr>
    <tr class="datagrid"> 
      <td>Avalibility of Chicks(Place)</td>
      <td><input type="text" name="txt_chicks"  value="<%=Helper.correctNull((String)hshValues.get("txt_chicks"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="50"></td>
      <td>Distance</td>
      <td  colspan="3"><input type="text" name="txt_distchicks"  value="<%=Helper.correctNull((String)hshValues.get("txt_distchicks"))%>"  size="20%" style="text-align:right" onKeyPress="allowInteger()" maxlength="7">
        (KM)</td>
    </tr>
    <tr class="datagrid"> 
      <td>Who takes care of the farm</td>
      <!-- <td><textarea
											name="txr_farm" cols="20" style="text-align:left"
											wrap="VIRTUAL" rows="2" onKeyPress="checkEnter();textlimit(txr_farm,600);notAllowSingleAndDoubleQuote()"></textarea></td>
 -->											
      <td>  <select name="txr_farm" onChange="">
          <option value="0" selected>-- Select --</option>
          <option value="1">Self</option>
          <option value="2">Employee</option>         
        </select>
      </td>
     <td colspan="4">&nbsp;</td>
    </tr>
    <tr id="id_type"> 
      <td>Type of Shed</td>
      <td><select name="sel_shed" onChange="check()">
          <option value="0" selected>--Select--</option>
          <option value="1">Tatched roof shed</option>
          <option value="2">Mangalore Tile roof shed</option>
          <option value="3">Asbestos roof shed</option>
          <option value="4">Any other</option>
        </select></td>
      <td id="r1">specify</td>
      <td  id="k1" colspan="3"><input type="text" name="txt_specify1"  value="<%=Helper.correctNull((String)hshValues.get("txt_specify1"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="100"></td>
    </tr>
    <tr class="datagrid"> 
      <td>Type of rearing</td>
      <td><select name="sel_rearing" onChange="check()">
          <option value="0" selected>--Select--</option>
          <option value="1">Deep Litter</option>
          <option value="2">Cage System</option>
          <option value="3">other</option>
        </select></td>
      <td id="r2">specify</td>
      <td id="k2"  colspan="3"><input type="text" name="txt_specify2"  value="<%=Helper.correctNull((String)hshValues.get("txt_specify2"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="100"></td>
      <td id="e1" colspan="4">&nbsp;</td>
     
    </tr>
    <tr class="datagrid"> 
      <td>Brooder Shed</td>
      <td><input type="text" name="txt_broodershed"  value="<%=Helper.correctNull((String)hshValues.get("txt_broodershed"))%>"  size="20%" onKeyPress="allowInteger()" maxlength="9"></td>
      <td colspan="3">Grower Shed</td>
      <td ><input type="text" name="txt_growershed"  value="<%=Helper.correctNull((String)hshValues.get("txt_growershed"))%>"  size="20%" onKeyPress="allowInteger()" maxlength="9"></td>
    </tr>
    <tr class="datagrid"> 
      <td>system of rearing</td>
      <td><select name="sel_ashed">
          <option value="0" selected>--Select--</option>
          <option value="1">all in</option>
          <option value="2">all out</option>
          <option value="3">batch</option>
        </select></td>
      <!--<td><input type="text" name="txt_ashed"  value="<%=Helper.correctNull((String)hshValues.get("txt_ashed"))%>"  size="20%" onKeyPress="allowInteger()" maxlength="9"></td>-->
      <td colspan="3">No.Of Birds per batch</td>
      <td><input type="text" name="txt_noofbirdsperbatch"  value="<%=Helper.correctNull((String)hshValues.get("txt_noofbirdsperbatch"))%>"  size="20%" onKeyPress="allowInteger()" maxlength="9"></td>
    </tr>
    <tr class="datagrid"> 
      <td >Time required to complete 
        civil works and sale of first batch</td>
      <td ><input type="text" name="txt_time"  value="<%=Helper.correctNull((String)hshValues.get("txt_time"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="6">
        Months</td>
        <td colspan="3" id="Hatching1">Weekly Production capacity of hatchery</td>
        <td id="Hatching2"><input type="text" name="txt_weeklyprodcap"  value="<%=Helper.correctNull((String)hshValues.get("txt_weeklyprodcap"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="6"></td>
        <td colspan="3" id="Hatching3">&nbsp;</td>
        <td id="Hatching4">&nbsp;</td>
    </tr>
    <tr class="datagrid">
    <td id="Hatching">Source of eggs for Hatching</td>
    <td id="Hatching5"><input type="text" name="txt_sourceofeggs"  value="<%=Helper.correctNull((String)hshValues.get("txt_sourceofeggs"))%>"  size="20%" onKeyPress="allowAlpaNumeric()" ></td>
    <td colspan="3" id="Hatching6">Cost of hatchable Eggs</td>
    <td id="Hatching7"><input type="text" name="txt_costofhatcheggs"  value="<%=Helper.correctNull((String)hshValues.get("txt_costofhatchableeggs"))%>"  size="20%" onKeyPress="allowNumber(this)" onblur="roundtxt(this)" maxlength="6"></td>
   </tr> 
    <tr class="datagrid">
    <td >Marketing of chicks</td>
    <td><input type="text" name="txt_marketingofchicks"  value="<%=Helper.correctNull((String)hshValues.get("txt_marketingofchicks"))%>" onKeyPress="allowAlphabets()"  size="20%" ></td>
    <td colspan="3">Sale price of dayold chicks</td>
     <td><input type="text" name="txt_salepriceofdayold"  value="<%=Helper.correctNull((String)hshValues.get("txt_salepriceofdayoldchick"))%>"  size="20%" onKeyPress="allowNumber(this)" onblur="roundtxt(this)" maxlength="6"></td>
    </tr>
    <tr class="datagrid">
    <td >Purchased Date</td>
    <td><input type="text" name="txt_purchasedate"  value="<%=Helper.correctNull((String)hshValues.get("poultry_purchasedate"))%>"  size="20%" onBlur="checkDate(this);"> &nbsp;&nbsp;
    	<a href="#" onClick="callCalender('txt_purchasedate')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a></td>
    <td colspan="4">&nbsp;</td>
    </tr>
  </table>
  <br>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel_Audit Trail"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<br>
					
    <input type="hidden" name="txt_bgshed"  value="<%=Helper.correctNull((String)hshValues.get("txt_bgshed"))%>"  size="20%" onKeyPress="allowInteger()" maxlength="100">
    <input type="hidden" name="txt_layershed"  value="<%=Helper.correctNull((String)hshValues.get("txt_layershed"))%>"  size="20%" onKeyPress="allowInteger()" maxlength="100"> 
    <input type="hidden" name="sel_farm1" value="">
    <input type="hidden" name="sel_electricity1" value="">
	<input type="hidden" name="sel_shed1" value="">
	<input type="hidden" name="sel_rearing1" value="">
	<input type="hidden" name="hidAction">
	<input type="hidden" name="hidBeanId">
	<input type="hidden" name="hidBeanMethod">
	<input type="hidden" name="hidBeanGetMethod">
	<input type="hidden" name="hidSourceUrl">
	<INPUT TYPE="hidden" name="hidAppType" value=""> 
	<input type="hidden" name="hidUsrMode" value="<%=session.getAttribute("strUserMode")%>">
	<input type="hidden" name="hidFacSNo" value="<%=strFacSNo%>">
	<input type="hidden" name="hidunits" value="<%=us1%>">
	<input type="hidden" name="hidunits1" value="<%=us2%>">
	</td>
	</tr>
	</table>
</form>
</body>
</html>

