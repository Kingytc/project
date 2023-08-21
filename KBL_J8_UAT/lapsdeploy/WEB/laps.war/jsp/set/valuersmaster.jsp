<%@ include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
%>
<html>
<head>
<title>Valuer Master</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 100%;
	overflow: auto;
}
</STYLE>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/set/valuersmaster.js"> </script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var action ="<%=Helper.correctNull((String) hshValues
							.get("VALUERS_ACTIVE"))%>";
var blacklist ="<%=Helper.correctNull((String) hshValues
							.get("valuers_blacklist"))%>"
var vartrapedit="<%=Helper.correctNull((String) hshValues.get("trapedit"))%>";
var strAppVar="<%=Helper.correctNull((String) hshValues.get("strAppVal"))%>";
function callAppVal()
{
	if(document.forms[0].rad[0].checked==true)
	{
		strAppVar="V";
		ClearFields();
		enableButtons(false,true,true,true,false);
		DisableJewelApprfields();
		document.all.custid.style.display="none";
		document.all.idJewelApp1.style.display="table-cell";
		document.all.id_natureValuation.style.display="table-row";
		document.all.id_locValued.style.display="table-row";
		document.all.jewel_appid_03.style.visibility="visible";
		document.all.jewel_appid_03.style.position="relative";	
		document.all.jewel_appid_04.style.visibility="visible";
		document.all.jewel_appid_04.style.position="relative";
		clearrows("idorgName");
		clearrows("tabid_locvalued");

		var table=document.getElementById("idorgName");
		var rowCount=table.rows.length; 
		if(rowCount==1)
		{
			document.all.idJewelCol.style.display="none";
			document.all.cid.style.display="none";
		}
		else
		{
			for(var i=0;i<rowCount;i++)
			{
				document.all.idJewelCol[i].style.display="none";
				document.all.cid[i].style.display="none";
			}
		}

	}
	else if(document.forms[0].rad[1].checked==true)
	{
		strAppVar="A";
		ClearFields();
		enableButtons(false,true,true,true,false);
		DisableJewelApprfields()
		document.all.custid.style.display="none";
		document.all.idJewelApp1.style.display="none";
		document.all.id_natureValuation.style.display="none";
		document.all.id_locValued.style.display="none";
		document.all.jewel_appid_03.style.visibility="hidden";
		document.all.jewel_appid_03.style.position="absolute";	
		document.all.jewel_appid_04.style.visibility="hidden";
		document.all.jewel_appid_04.style.position="absolute";
		clearrows("idorgName");
		var table=document.getElementById("idorgName");
		var rowCount=table.rows.length; 
		if(rowCount==1)
		{
			document.all.idJewelCol.style.display="none";
			document.all.cid.style.display="none";
		}
		else
		{
			for(var i=0;i<rowCount;i++)
			{
				document.all.idJewelCol[i].style.display="none";
				document.all.cid[i].style.display="none";
			}
		}
	}
	else if(document.forms[0].rad[2].checked==true)
	{
		strAppVar="J";
		ClearFields();	
		enableButtons(false,true,true,true,false);
		EnableJewelApprfields();
		document.all.custid.style.display="table-row";	
		document.all.idJewelApp1.style.display="table-cell";
		document.all.id_natureValuation.style.display="none";
		document.all.id_locValued.style.display="none";
		document.all.jewel_appid_03.style.visibility="hidden";
		document.all.jewel_appid_03.style.position="absolute";	
		document.all.jewel_appid_04.style.visibility="hidden";
		document.all.jewel_appid_04.style.position="absolute"
		clearrows("idorgName");

		var table=document.getElementById("idorgName");
		var rowCount=table.rows.length; 
		if(rowCount==1)
		{
			document.all.idJewelCol.style.display="inline";
			document.all.cid.style.display="inline";
		}
		else
		{
			for(var i=0;i<rowCount;i++)
			{
				document.all.idJewelCol[i].style.display="inline";
				document.all.cid[i].style.display="inline";
			}
		}
	}
}
function clearrows(tabid)
{
	var table=document.getElementById(tabid);
	var rowCount=table.rows.length;
	if(rowCount > 1)
	{
		for(var i=rowCount-1;i>0;i--)
		{
			table.deleteRow(i);      
		}
	}
}

function callDescCBS()
{	
	if(document.forms[0].cmdnew.disabled==true){
	var varQryString = appURL+"action/CBSIDhelp.jsp?strAppVar="+strAppVar;
	var title = "SelectCBSID";
	var prop = "scrollbars=yes,menubar=yes,status=yes,width=500,height=400";
	prop = prop + ",left=50,top=150";
    window.open(varQryString,title,prop);
	}
	else{
		alert("Please Click New and then Continue");
	}	
}

function EnableJewelApprfields()
{
	document.all.id_jewel_01.style.visibility="hidden";
	document.all.id_jewel_01.style.position="absolute";		
	document.all.id_jewel_02.style.visibility="hidden";
	document.all.id_jewel_02.style.position="absolute";		
	document.all.id_jewel_03.style.visibility="hidden";
	document.all.id_jewel_03.style.position="absolute";		
	document.all.id_jewel_04.style.visibility="hidden";
	document.all.id_jewel_04.style.position="absolute";		
	document.all.id_jewel_05.style.visibility="hidden";
	document.all.id_jewel_05.style.position="absolute";		
	document.all.id_jewel_06.style.visibility="hidden";
	document.all.id_jewel_06.style.position="absolute";		
	document.all.id_jewel_07.style.visibility="hidden";
	document.all.id_jewel_07.style.position="absolute";		
	document.all.id_jewel_08.style.visibility="hidden";
	document.all.id_jewel_08.style.position="absolute";
	document.all.id_jewel_09.style.visibility="hidden";
	document.all.id_jewel_09.style.position="absolute";
	document.all.id_jewel_10.style.visibility="hidden";
	document.all.id_jewel_10.style.position="absolute";
	document.all.id_jewel_11.style.visibility="hidden";
	document.all.id_jewel_11.style.position="absolute";
	document.all.id_jewel_12.style.visibility="hidden";
	document.all.id_jewel_12.style.position="absolute";
	document.all.id_jewel_14.style.visibility="hidden";
	document.all.id_jewel_14.style.position="absolute";
	document.all.id_jewel_15.style.visibility="hidden";
	document.all.id_jewel_15.style.position="absolute";
	document.all.id_jewel_16.style.visibility="hidden";
	document.all.id_jewel_16.style.position="absolute";
	
	document.all.jewel_appid_01.style.visibility="visible";
	document.all.jewel_appid_01.style.position="relative";	
	document.all.jewel_appid_02.style.visibility="visible";
	document.all.jewel_appid_02.style.position="relative";	
	//document.all.jewel_appid_03.style.visibility="visible";
	//document.all.jewel_appid_03.style.position="relative";	
	//document.all.jewel_appid_04.style.visibility="visible";
	//document.all.jewel_appid_04.style.position="relative";	
	document.all.jewel_appid_05.style.visibility="visible";
	document.all.jewel_appid_05.style.position="relative";	
	document.all.jewel_appid_06.style.visibility="visible";
	document.all.jewel_appid_06.style.position="relative";	
	document.all.jewel_appid_07.style.visibility="visible";
	document.all.jewel_appid_07.style.position="relative";	
	document.all.jewel_appid_08.style.visibility="visible";
	document.all.jewel_appid_08.style.position="relative";	
	document.all.jewel_appid_09.style.visibility="visible";
	document.all.jewel_appid_09.style.position="relative";	
//	document.all.jewel_appid_10.style.visibility="visible";
	//document.all.jewel_appid_10.style.position="relative";
	document.all.jewel_appid_11.style.visibility="visible";
	document.all.jewel_appid_11.style.position="relative";	
	document.all.jewel_appid_12.style.visibility="visible";
	document.all.jewel_appid_12.style.position="relative";	
	document.all.jewel_appid_13.style.visibility="visible";
	document.all.jewel_appid_13.style.position="relative";	
}
function DisableJewelApprfields()
{
	document.all.id_jewel_01.style.visibility="visible";
	document.all.id_jewel_01.style.position="relative";		
	document.all.id_jewel_02.style.visibility="visible";
	document.all.id_jewel_02.style.position="relative";		
	document.all.id_jewel_03.style.visibility="visible";
	document.all.id_jewel_03.style.position="relative";		
	document.all.id_jewel_04.style.visibility="visible";
	document.all.id_jewel_04.style.position="relative";		
	document.all.id_jewel_05.style.visibility="visible";
	document.all.id_jewel_05.style.position="relative";		
	document.all.id_jewel_06.style.visibility="visible";
	document.all.id_jewel_06.style.position="relative";		
	document.all.id_jewel_07.style.visibility="visible";
	document.all.id_jewel_07.style.position="relative";		
	document.all.id_jewel_08.style.visibility="visible";
	document.all.id_jewel_08.style.position="relative";
	document.all.id_jewel_09.style.visibility="visible";
	document.all.id_jewel_09.style.position="relative";
	document.all.id_jewel_10.style.visibility="visible";
	document.all.id_jewel_10.style.position="relative";
	document.all.id_jewel_11.style.visibility="visible";
	document.all.id_jewel_11.style.position="relative";
	document.all.id_jewel_12.style.visibility="visible";
	document.all.id_jewel_12.style.position="relative";
	document.all.id_jewel_14.style.visibility="visible";
	document.all.id_jewel_14.style.position="relative";
	document.all.id_jewel_15.style.visibility="visible";
	document.all.id_jewel_15.style.position="relative";
	document.all.id_jewel_16.style.visibility="visible";
	document.all.id_jewel_16.style.position="relative";

	document.all.jewel_appid_01.style.visibility="hidden";
	document.all.jewel_appid_01.style.position="absolute";	
	document.all.jewel_appid_02.style.visibility="hidden";
	document.all.jewel_appid_02.style.position="absolute";	
	//document.all.jewel_appid_03.style.visibility="hidden";
	//document.all.jewel_appid_03.style.position="absolute";	
	//document.all.jewel_appid_04.style.visibility="hidden";
	//document.all.jewel_appid_04.style.position="absolute";	
	document.all.jewel_appid_05.style.visibility="hidden";
	document.all.jewel_appid_05.style.position="absolute";	
	document.all.jewel_appid_06.style.visibility="hidden";
	document.all.jewel_appid_06.style.position="absolute";	
	document.all.jewel_appid_07.style.visibility="hidden";
	document.all.jewel_appid_07.style.position="absolute";	
	document.all.jewel_appid_08.style.visibility="hidden";
	document.all.jewel_appid_08.style.position="absolute";	
	document.all.jewel_appid_09.style.visibility="hidden";
	document.all.jewel_appid_09.style.position="absolute";	
	//document.all.jewel_appid_10.style.visibility="hidden";
	//document.all.jewel_appid_10.style.position="absolute";	
	document.all.jewel_appid_11.style.visibility="hidden";
	document.all.jewel_appid_11.style.position="absolute";	
	document.all.jewel_appid_12.style.visibility="hidden";
	document.all.jewel_appid_12.style.position="absolute";	
	document.all.jewel_appid_13.style.visibility="hidden";
	document.all.jewel_appid_13.style.position="absolute";	
	

	
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
		if(document.forms[0].elements[i].type=='select-multiple')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}	
		if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=(!one);		  
		}		
		if(document.forms[0].elements[i].name=="org_code")
		{
			document.forms[0].elements[i].readOnly=true;
		}
		if(document.forms[0].elements[i].name=='chk')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].name=='txt_district')
		{
			document.forms[0].elements[i].readOnly=true;
		}
	}
	//document.forms[0].txt_desig.readOnly=true;
	//document.forms[0].txt_desig1.readOnly=true;
	document.forms[0].txt_blacklistdate.readOnly=true;
	document.forms[0].txt_city.readOnly=true;
	document.forms[0].txt_state.readOnly=true;
	document.forms[0].org_code.readOnly=true;

}


function callonLoad()
{		
	DisableJewelApprfields();
	disablefields(true);
	document.all.custid.style.display="none";
	document.all.idJewelApp1.style.display="none";
	document.all.id_natureValuation.style.display="none";
	document.all.id_locValued.style.display="none";
	
	if(vartrapedit=="E")
		{
		enableButtons(false,false,true,true,false);
		}
	else
		{
		enableButtons(false,true,true,true,false);
		}
	if(blacklist!="")
	{
		document.forms[0].sel_blacklist.value=blacklist;
	}
	if(strAppVar!="")
	{
		if(strAppVar=="A")
			{
			document.forms[0].rad[1].checked=true;
			document.all.custid.style.display="none";
			}
		else if(strAppVar=="V")
			{
			document.forms[0].rad[0].checked=true;
			document.all.custid.style.display="none";
			}
		else if(strAppVar=="J")
		{
		document.forms[0].rad[2].checked=true;
		document.all.custid.style.display="table-row";
		document.all.idJewelApp1.style.display="table-cell";
		}
		
	}

}


function doSave()
{	   
	if(document.forms[0].txt_name.value == "")
	{
		ShowAlert('121','Appraiser / Valuer Name ');
		document.forms[0].txt_name.focus();
		return;
	}
	if(document.forms[0].txt_address1.value == "")
	{
		ShowAlert('121','Appraiser /Valuer Address ');
		document.forms[0].txt_address1.focus();
		return;
	}
	if(strAppVar =="V")
	{ 
		if(document.forms[0].txt_expdateofsanc.value == "")
		{
			ShowAlert('121','Expiry Date of Sanction');
			document.forms[0].txt_expdateofsanc.focus();
			return;
		}

		var str_type ="";
		for(var i=0;i<document.forms[0].sel_securitytype.options.length;i++)
		{
			if(document.forms[0].sel_securitytype.options[i].selected)
			{				
				str_type=str_type+document.forms[0].sel_securitytype.options[i].value+"@";
			}		
		}
		if(str_type=="")
		{
			ShowAlert('111','Nature of Valuation');
			document.forms[0].sel_securitytype.focus();
			return;
		}
		document.forms[0].hidNatureValuation.value=str_type;

		if(document.forms[0].sel_CategoryCode.value == "")
		{
			ShowAlert('111','Category Code');
			document.forms[0].sel_CategoryCode.focus();
			return;
		}
		var table=document.getElementById("tabid_locvalued");
		var rowCount=table.rows.length; 
		if(rowCount>1)
		{
			for(var i=0;i<rowCount;i++)
			{
				if(document.forms[0].sel_state[i].value=="s" || document.forms[0].sel_state[i].value=="")
				{
					ShowAlert('111','Location / area of the asset to be valued ');
					document.forms[0].sel_state[i].focus();
					return;
				}	
				if(document.forms[0].txt_district[i].value=="")
				{
					ShowAlert('111','Location / area of the asset to be valued ');
					document.forms[0].txt_district[i].focus();
					return;
				}	
			}
		}
		else
		{
			if(document.forms[0].sel_state.value=="s" || document.forms[0].sel_state.value=="")
			{
				ShowAlert('111','Location / area of the asset to be valued ');
				document.forms[0].sel_state.focus();
				return;
			}
			if(document.forms[0].txt_district.value=="")
			{
				ShowAlert('111','Location / area of the asset to be valued ');
				document.forms[0].txt_district.focus();
				return;
			}
		}
	}
	if(strAppVar =="J")
	{ 
		if(document.forms[0].txt_sancrefno.value == "")
		{
			ShowAlert('121','Sanction Reference Number');
			document.forms[0].txt_sancrefno.focus();
			return;
		}
		/*if(document.forms[0].txt_expdateofsanc.value == "")
		{
			ShowAlert('121','Expiry Date of Sanction');
			document.forms[0].txt_expdateofsanc.focus();
			return;
		}*/
		if(document.forms[0].txt_detofsecdep.value == "")
		{
			ShowAlert('121','Details of Security Deposits');
			document.forms[0].txt_detofsecdep.focus();
			return;
		}
		if(document.forms[0].txt_dofjewelappr.value== "")
		{
			ShowAlert('121','Date of Agreement with Jewel Appraiser');
			document.forms[0].txt_dofjewelappr.focus();
			return;
		}
		if(document.forms[0].txt_zip.value == "")
		{
			ShowAlert('121','Pincode');
			document.forms[0].txt_zip.value="";
			document.forms[0].txt_zip.focus();
			return;
		}

	}
	if(document.forms[0].txt_city.value == "")
	{
		ShowAlert('121','Appraiser /Valuer city');
		document.forms[0].txt_city.focus();
		return;
	}
	if(document.forms[0].txt_state.value == "")
	{
		ShowAlert('121','Appraiser /Valuer state');
		document.forms[0].txt_state.focus();
		return;
	}
	if(strAppVar!="J")
	{ 
		if(document.forms[0].txt_desig1.value == "")
		{
			ShowAlert('121','Contact Person Designation');
			return;
		}
	}
	if(strAppVar!="J")
	{ 
		if(document.forms[0].txt_contactperson.value=="")
		{
			ShowAlert('121','Contact Person Name');
			document.forms[0].txt_contactperson.focus();
			return;
		}
	
		if(document.forms[0].txt_zip1.value == "")
		{
			ShowAlert('121','Pincode');
			document.forms[0].txt_zip1.value="";
			document.forms[0].txt_zip1.focus();
			return;
		}
		if(document.forms[0].sel_blacklist.value=="Y")
		{
			if(document.forms[0].txt_blacklistdate.value=="")
			{
				alert("Enter the Black Listed Date");
				document.forms[0].txt_blacklistdate.value="";
				document.forms[0].txt_blacklistdate.focus();
				return;
			}
		}	
	   
		if(document.forms[0].sel_blacklist.value!="Y")
		{
		document.forms[0].sel_blacklist.value="N";
		}
	}
	if(document.forms[0].org_code.value=="")
	{
		ShowAlert('121','Branch Name');
		document.forms[0].org_code.focus();
		return;
	}
	if(document.forms[0].txt_action.value=="")
	{
		ShowAlert('111','active flag');
		document.forms[0].txt_action.focus();
		return;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidAppVal.value=strAppVar;
	document.forms[0].hidBeanMethod.value="updateValuerMasterData";
	document.forms[0].hidBeanGetMethod.value="getValuerMasterList";
	document.forms[0].hidSourceUrl.value="/action/valuersmaster.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}



function callCntrySearch(varTextControl,varHidControl)
{	
	if(document.forms[0].cmdsave.disabled==false)
	{
			var varQryString = appURL+"action/searchCountry.jsp?hidcntrycontrol="+varTextControl+"&hidcntrycodecontrol="+varHidControl;
			var title = "Country";
			var prop = "scrollbars=no,width=750,height=500";	
			prop = prop + ",left=200,top=200";
			window.open(varQryString,title,prop);	
		
			if(!(varTextControl=="txtperapp_country" || varTextControl=="txtperapp_permcountry" ))
			{
				var varQryString = appURL+"action/searchCountry.jsp?hidcntrycontrol="+varTextControl+"&hidcntrycodecontrol="+varHidControl;
				var title = "Country";
				var prop = "scrollbars=no,width=750,height=500";	
				prop = prop + ",left=200,top=200";
				window.open(varQryString,title,prop);	
			}
			else
			{
				//No Function
			}
		
	}
	
}


function showSystem(val,glpsize,rowindex)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var table=document.getElementById("idorgName");
		var rowCount=table.rows.length; 
		prop = "scrollbars=yes,width=500,height=355,statusbar=yes";	
		xpos = (screen.width - 700) / 2;
		ypos = (screen.height - 550) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		var levels="0";
		var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+levels+"&glpsize="+glpsize+"&rowindex="+(rowindex-1)+"&rowcount="+rowCount;
		title="help";
		window.open(purl,title,prop);
	}
}

function addorgnamesearch()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
	var table=document.getElementById("idorgName");
	var rowCount=table.rows.length; 
	var row=table.insertRow(rowCount++);

	var cell1=row.insertCell(0);
	var cell2=row.insertCell(1);
	var cell3=row.insertCell(2);

	cell1.innerHTML="<tr><td><input type='checkbox' name='chk' style='border: none;'></td>";
	cell2.innerHTML="<td><input type='text' name='org_code'	value='' size='30'><input type='hidden' name='hidarea' value=''><span id='"+rowCount+"' onClick='showSystem(66,66,this.id)' style='cursor: hand'> <img src='<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif' border='0'></span></td>";
	if(document.forms[0].rad[2].checked==true)
	{
		cell3.innerHTML="<td ><input type='text' name='txt_Jexpdateofsanc' value='' id='idJewelCol' size='15' onBlur='checkDate(this)'>&nbsp;&nbsp;<span id='cid' onClick='callCalender1(this)'><img src='<%=ApplicationParams.getAppUrl()%>img/calen.gif' border='0'></span></td></tr>";
	}
	else
	{
		cell3.innerHTML="<td><input type='hidden' name='txt_Jexpdateofsanc' id='idJewelCol' value='' size='15' onBlur='checkDate(this)'><span id='cid'></span></td></tr>";
	}
	}
}

function addLocValued()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var table=document.getElementById("tabid_locvalued");
		var rowCount=table.rows.length; 
		var row=table.insertRow(rowCount++);
	
		var cell1=row.insertCell(0);
		var cell2=row.insertCell(1);
		var cell3=row.insertCell(2);
		var cell4=row.insertCell(3);
		var cell5=row.insertCell(4);
		
		cell1.innerHTML="<tr><td WIDTH='10%'><input type='checkbox' name='chk1' style='border: none;'></td>";
		cell2.innerHTML="<td WIDTH='15%'>State</td>";
		cell3.innerHTML="<td WIDTH='30%'><select name='sel_state' id='"+rowCount+"' onchange='changeState(this.id)' ><option value='s'>--Select--</option><lapschoice:statemaster apptype='Code'/></select></td>";
		cell4.innerHTML="<td WIDTH='15%'>District</td>";
		cell5.innerHTML="<td WIDTH='30%' nowrap='nowrap'><input type='text' name='txt_district' value='' readonly='readonly'> <input type='hidden' name='txt_districtcode' value=''><span id='"+rowCount+"' onClick='showDistrict(this.id)'><img src='<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif' border=0></span></td></tr>";
	}
}

function deleteRow(tableid)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var table=document.getElementById(tableid);
		var rowCount=table.rows.length; 
		
		if(rowCount==1){
	       alert("Atleast one data is needed");
	       return;
		}
		else{
			 table.deleteRow(rowCount-1);
		}
	}
}

function orgnamesearchdisp(val1,val2,val3)
{
	if(document.forms[0].rad[2].checked==false)
	{
		var  branchCode=document.forms[0].hidbranchCode.value;
		var  branchname=document.forms[0].hidbranchname.value;
		var var_arr= branchname.split("@");
		var var_arrcode= branchCode.split("@");
		var length=var_arr.length;
		for(var i=0;i<length;i++)
		{
			var table=document.all.idorgName;
			var rowCount=table.rows.length;
	
			var row=table.insertRow(rowCount-1);
			var varName=var_arr[i];
			
			var cell1=row.insertCell(0);
			var cell2=row.insertCell(1);
			var cell3=row.insertCell(2);
	
			cell1.innerHTML="<tr><td><input type='checkbox' name='chk' style='border: none;'></td>";
			cell2.innerHTML="<td><input type='text' name='org_code'	value='"+varName+"' readonly='readonly' size='30'><input type='hidden' name='hidarea' value="+var_arrcode[i]+"><span id='"+rowCount+"' onClick='showSystem(66,66,this.id)' style='cursor: hand'> <img src='<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif' border='0'></span></td></tr>";
			cell3.innerHTML="<td><input type='hidden' name='txt_Jexpdateofsanc' value='' size='15' onBlur='checkDate(this)'  id='idJewelCol'><span id='cid'></span></td></tr>";
		}
	}
	else
	{
		var var_arr= val1.split("~");
		var var_arrcode= val2.split("~");
		var var_arrcode1= val3.split("~");
		var length=var_arr.length;
		for(var i=0;i<length;i++)
		{
			var table=document.all.idorgName;
			var rowCount=table.rows.length;
	
			var row=table.insertRow(rowCount-1);
			var varName=var_arr[i];
			
			var cell1=row.insertCell(0);
			var cell2=row.insertCell(1);
			var cell3=row.insertCell(2);
	
			cell1.innerHTML="<tr><td><input type='checkbox' name='chk' style='border: none;'></td>";
			cell2.innerHTML="<td><input type='text' name='org_code'	value='"+varName+"' size='30' readonly='readonly'><input type='hidden' name='hidarea' value='"+var_arrcode[i]+"'><span id='"+rowCount+"' onClick='showSystem(66,66,this.id)' style='cursor: hand'> <img src='<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif' border='0'></span></td>";
			cell3.innerHTML="<td><input type='text' name='txt_Jexpdateofsanc' value='"+var_arrcode1[i]+"' size='15' onBlur='checkDate(this)'  id='idJewelCol'>&nbsp;&nbsp;<span id='cid' onClick='callCalender1(this)'><img src='<%=ApplicationParams.getAppUrl()%>img/calen.gif' border='0'></span></td></tr>";
		}
	}
	deleteRowdisabled('idorgName');
}


function addLocValuedDisp()
{
	var valValuerLocation=document.forms[0].hidValuerLocation.value;
	var var_arr= valValuerLocation.split("@");
	var length=var_arr.length;
	for(var i=0;i<length;i++)
	{
		var temp=var_arr[i].split("~");
		var statecode=temp[0];
		var districtname=temp[1];
		var districtDesc=temp[2]+"-"+temp[1];
		var table=document.getElementById("tabid_locvalued");
		var rowCount=table.rows.length; 
		var row=table.insertRow(rowCount-1);
	
		var cell1=row.insertCell(0);
		var cell2=row.insertCell(1);
		var cell3=row.insertCell(2);
		var cell4=row.insertCell(3);
		var cell5=row.insertCell(4);

		
		cell1.innerHTML="<tr><td WIDTH='10%'><input type='checkbox' name='chk1' style='border: none;'></td>";
		cell2.innerHTML="<td WIDTH='15%'>State</td>";
		cell3.innerHTML="<td WIDTH='30%'><select name='sel_state' id='"+rowCount+"' onchange='changeState(this.id)' disabled><option value='s'>--Select--</option><lapschoice:statemaster apptype='Code'/></select></td>";
		cell4.innerHTML="<td WIDTH='15%'>District</td>";
		cell5.innerHTML="<td WIDTH='30%'  nowrap='nowrap'><input type='text' name='txt_district' value='"+districtDesc+"' readonly='readonly'> <input type='hidden' name='txt_districtcode' value='"+districtname+"'><span id='"+rowCount+"' onClick='showDistrict(this.id)'><img src='<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif' border=0></span></td></tr>";
		document.forms[0].sel_state[i].value=statecode;
	}
	deleteRowdisabled('tabid_locvalued');
}

function deleteRowdisabled(tableid)
{
		var table=document.getElementById(tableid);
		var rowCount=table.rows.length; 
		
		if(rowCount==1){
	       alert("Atleast one data is needed");
	       return;
		}
		else{
			 table.deleteRow(rowCount-1);
		}
}


function deleteRow1(tabid,tdcount)
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		var tab = document.getElementById(tabid);
		var rowsLength = tab.rows.length;
		var varCheckedFlag=false;
		if(rowsLength>=1)
		{
			for(var i=0;i<rowsLength;i++)
			{
				var current_row = tab.rows[i];
				var chkbox = current_row.cells[tdcount].childNodes[0];
				if(chkbox != null && chkbox.checked == true)
				{
					if(tabid=="idorgName" && rowsLength=="1")
					{
					    	 document.forms[0].org_code.value="";  
					    	 document.forms[0].hidarea.value="";
					    	 document.forms[0].txt_Jexpdateofsanc.value="";
					    	 chkbox.checked=false; 
					    	 return;
					}
					else if(tabid=="tabid_locvalued" && rowsLength=="1")
					{
					    	 document.forms[0].sel_state.value="";  
					    	 document.forms[0].txt_district.value="";  
					    	 document.forms[0].txt_districtcode.value="";
					    	 chkbox.checked=false; 
					    	 return;
					}
					else
					{
						tab.deleteRow(i);
						rowsLength--;
						i--;
					}

					if(!varCheckedFlag)
					{
						varCheckedFlag=true;
					}
				}
			}
			if(!varCheckedFlag)
			{
				alert("please select the check box for deletion");
			}
		}
	}
}

function callCalender1(obj)
{
	var action  =document.forms[0].hidAction.value;
	if(action =="insert" || action =="update")
	{
		var table=document.getElementById("idorgName");
		var rowCount=table.rows.length; 
		if(rowCount==1)
		{
			showCal(appURL,'txt_Jexpdateofsanc');
		}
		else
		{
			for(var i=0;i<rowCount;i++)
			{
				var varValue1=eval("document.all.cid["+i+"]");
				if(varValue1==obj)
				{
					var varValue="txt_Jexpdateofsanc["+i+"]";
					showCal(appURL,varValue);
				}
			}
		}
		
	}
}


</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad();getdate()">
<form name="appform" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Master -&gt; Appraiser/Valuer's Master</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/mastertab.jsp" flush="true">
			<jsp:param name="tabid" value="3" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable border1 tableBg">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable">
				   <tr>
				   <td colspan="7"><input type="radio" name="rad"
							value="radiobutton" onClick="callAppVal()"
							style="border-style: none" maxlength="75"> Valuer
						Details &nbsp; <input type="radio" name="rad" value="radiobutton"
							onClick="callAppVal()" style="border-style: none" maxlength="75">
						Appraiser Details &nbsp; <input type="radio" name="rad" value="radiobutton"
							onClick="callAppVal()" style="border-style: none" maxlength="75">
						Jewel Appraiser Details
				   </td>
					</tr>
						<tr>
						<td colspan="7" class="setuphead">&nbsp;&nbsp;&nbsp;&nbsp;<b><u>Present Address</u></b></td>
					</tr>
					<tr id="custid">
					<td>&nbsp;</td>
				    <td>&nbsp;</td>
				    <td>&nbsp;</td>
				    <td>&nbsp;</td>
				      <td>&nbsp;</td>
				   
						
						<td  id="custid1">CBS Cust ID<span class="mantatory">*</span></td>
					<td  id="custid2"><input type="text"
						name="txt_cbscustid" size="12" maxlength="10" onBlur="readOnly" 
						value="<%=Helper.correctNull((String)hshValues.get("valuer_cbsid"))%>">
					<b><span onClick="javascript:callDescCBS()" style="cursor: hand;display: none;" id="idsearch"><img
						src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
						border="0"></span></b></td>
								
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td valign="top">Appraiser / Valuer Name <b><span class="mantatory">*</span></b></td>
						<td colspan="3" valign="top"><input type="text"
							name="txt_name" size="38" maxlength="50" tabindex="1"
							value="<%=Helper.correctNull((String) hshValues
									.get("VALUERS_NAME"))%>"
							onKeyPress="notAllowSplChar()"> &nbsp;&nbsp;<b><span
							onClick="callsupnam()" style="cursor: hand" id="idsearch1"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span></b></td>
					
						
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					  		<tr>	
								<td>Branch &nbsp;</td>
								<td id="idJewelApp1"> <a onClick="addorgnamesearch();"><img
												src="<%=ApplicationParams.getAppUrl()%>img/add.png"
												width="10" height="10" border="0" tabindex="38"></a>&nbsp;&nbsp;&nbsp;
									<a onClick="deleteRow1('idorgName','0');"><img
											src="<%=ApplicationParams.getAppUrl()%>img/cancel.png"
											width="10" height="10" border="0" tabindex="38"></a>
								</td>
							</tr>
						</table>
						</td> 
                   		
                   		<td width="25%" >
                   		<table width="100%" border="0" cellspacing="0" cellpadding="2" id="idorgName" >
					  	  <tr>	
					  	  	<td width="5%"><input type="checkbox" name="chk" style="border: none;"></td>
							<td width="60%">
								<input type="text" name="org_code"	size='30' readonly="readonly"> 
                   				<input type="hidden"" name="hidarea"><span id="1"
 															onClick="showSystem('66','66',this.id)"
															style="cursor: hand"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"></span></b>
				 			</td>
				 			<td width="35%">
				 			<input type="text"
							name="txt_Jexpdateofsanc" size="15" maxlength="15"
							tabindex="6"
							value=""
							onBlur="checkDate(this);"  id="idJewelCol">
							<span id="cid"
									onClick="callCalender1(this)"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
									alt="Select date from calender"></span>
				 			</td>
                          </tr>
					  	</table>
						</td>
                   		</tr>
                   				<!--<td><select name="org_code"
									disabled="disabled">
									<option value="">---Select---</option>
									<lapschoice:organizations />
								 </select></td>
								-->
					
					<tr>
						<td>&nbsp;</td>
						<td>Appraiser /Valuer Address <b><span class="mantatory">*</span></b>
						</td>
						<td colspan="3" valign="top"><input type="text"
							name="txt_address1" size="38" maxlength="100" tabindex="2"
							value="<%=Helper.correctNull((String) hshValues
							.get("VALUERS_ADDRESS1"))%>"
							onKeyPress="notAllowedDouble()"></td>
						<td valign="top" id="id_jewel_01">Contact Person Name<b><span
							class="mantatory">*</span></b></td>					
							
						<td valign="top"  id="id_jewel_02"><input type="text" name="txt_contactperson"
							size="25" maxlength="50" tabindex="5"
							value="<%=Helper.correctNull((String) hshValues
							.get("VALUERS_CONTPER"))%>"
							onKeyPress="notAllowSplChar()"></td>
							
						<td valign="top" id="jewel_appid_01">Sanction Reference Number <b><span
							class="mantatory">*</span></b></td>					
							
						<td valign="top"  id="jewel_appid_02"><input type="text" name="txt_sancrefno"
							size="25" maxlength="15" tabindex="5"
							value="<%=Helper.correctDouble((String) hshValues
							.get("VALUERS_SANCREFNO"))%>"></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td colspan="3" valign="top"><input type="text"
							name="txt_address2" size="38" maxlength="100" tabindex="3"
							value="<%=Helper.correctNull((String) hshValues
							.get("VALUERS_ADDRESS2"))%>"
							onKeyPress="notAllowedDouble()"></td>
						<td valign="top"  id="id_jewel_03">Contact Person Mobile /Phone No.</td>
						<td valign="top"  id="id_jewel_04"><input type="text"
							name="txt_contactmobilephone" size="18" maxlength="15"
							tabindex="6"
							value="<%=Helper.correctNull((String) hshValues
							.get("VALUERS_CONTPER_PHMOBNO"))%>"
							onKeyPress="allowPhone()"></td>
									
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td colspan="3" valign="top"><input type="text"
							name="txt_address3" size="38" maxlength="50" tabindex="4"
							value="<%=Helper.correctNull((String) hshValues
							.get("VALUERS_ADDRESS3"))%>"
							onKeyPress="notAllowedDouble()"></td>
						<td  id="id_jewel_05">Contact Person's Designation<b><span
							class="mantatory">*</span></b></td>
						<td  id="id_jewel_06"><input type="hidden" name="txt_desig" size="25"
							maxlength="10" tabindex="7"
							value="<%=Helper.correctNull((String) hshValues
							.get("VALUERS_DESIGN"))%>"
							onKeyPress="notAllowSplChar()"> <input type="text"
							name="txt_desig1" size="25" maxlength="60" tabindex="8"
							value="<%=Helper.correctNull((String) hshValues
							.get("VALUERS_DESIGN"))%>"
							onKeyPress="notAllowSplChar()"> &nbsp;&nbsp; <!--<b><span onClick="callDesignation1()" style="cursor:hand"><img src="<%//=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
												 border="0" tabindex="9"></span></b> --></td>
												 
					
					
					
					   <td id="jewel_appid_05">Details of Security Deposits<b><span
							class="mantatory">*</span></b></td>
						<td id="jewel_appid_06"> <input type="text"
							name="txt_detofsecdep" size="25" maxlength="25" tabindex="8"
							value="<%=Helper.correctNull((String) hshValues
							.get("VALUERS_DETOFSECDEP"))%>"
						 onKeyPress="allowAlphaNumeric();" style="text-align: right"></td>
					
					
											 
					
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td align="left">City <b><span class="mantatory">*</span></b>
						</td>
						<td><input type="text" name="txt_city" size="25"
							maxlength="25" tabindex="10"
							value="<%=Helper.correctNull((String) hshValues
									.get("VALUERS_CITY"))%>"
							onKeyPress="notAllowSplChar()"> <b><a id="idsearch2"
							href="javascript:showCitySearch('txt_city','txt_state','hidcity','hidstate','txt_zip','hidzip')"
							tabindex="5"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></a></b> <input type="hidden" name="hidcity"
							value="<%=Helper.correctNull((String) hshValues
							.get("VALUERS_CITY_CODE"))%>" />
						</td>
						
                  <td>&nbsp;</td>
						
				<td id="jewel_appid_07">&nbsp;</td>
						<td id="jewel_appid_08">Date of Agreement with Jewel Appraiser<b><span class="mantatory">*</span></b></td>
						<td id="jewel_appid_09"><input type="text" name="txt_dofjewelappr" size="15"
							maxlength="25" tabindex="12"
							value="<%=Helper.correctNull((String) hshValues
							.get("VALUERS_JEWAPPDATEOFAGR"))%>"
							onKeyPress="notAllowSplChar()"
							onBlur="checkDate(this);">							
							<a alt="Select date from calender"
									href="#" onClick="callCalender('txt_dofjewelappr')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
									alt="Select date from calender"></a>
						</td>
						
<!--                  <td id="jewel_appid_10">&nbsp;</td>-->
                  
                  <td id="id_jewel_14">&nbsp;</td>
						<td id="id_jewel_15"><%=ApplicationParams.getZipName()%><b><span
							class="mantatory">*</span></b></td>
						<td id="id_jewel_16"><input type="text" name="txt_zip1" size="12"
							maxlength="<%=ApplicationParams.getZipValue()%>" tabindex="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("VALUERS_PINCODE"))%>"
							onKeyPress="allowInteger()"
							onBlur="zipvalidate(this,'<%=ApplicationParams.getZipValue()%>');"
							style="text-align: left"></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>State <b><span class="mantatory">*</span></b></td>
						<td><input type="text" name="txt_state" size="25"
							maxlength="25" tabindex="12"
							value="<%=Helper.correctNull((String) hshValues
							.get("VALUERS_STATE"))%>"
							onKeyPress="notAllowSplChar()"
							onBlur="changecase(document.forms[0].txt_state)"> <input
							type="hidden" name="hidstate"
							value="<%=Helper.correctNull((String) hshValues
							.get("VALUERS_STATE_CODE"))%>" />
						</td>
						
                  <td>&nbsp;</td>
                                       
                  <td id="jewel_appid_11">&nbsp;</td>
						<td id="jewel_appid_12"><%=ApplicationParams.getZipName()%><b><span
							class="mantatory">*</span></b></td>
						<td id="jewel_appid_13"><input type="text" name="txt_zip" size="12"
							maxlength="<%=ApplicationParams.getZipValue()%>" tabindex="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("VALUERS_PINCODE"))%>"
							onKeyPress="allowInteger()"
							onBlur="zipvalidate(this,'<%=ApplicationParams.getZipValue()%>');"
							style="text-align: left"></td>
						
                  <td id="id_jewel_07">&nbsp;</td>
						<td  id="id_jewel_08">Empanelled on</td>
						<td  id="id_jewel_09">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td><input type="text" name="txt_empaneledon" size="11"
									tabindex="14" maxlength="11"
									value="<%=Helper.correctNull((String) hshValues
							.get("VALUERS_EMPANELEDDT"))%>"
									onBlur="checkDate(document.forms[0].txt_empaneledon);checkmaxdate(this,currdate)"
									Readonly> &nbsp;&nbsp;</td>
								<td align="left"><a alt="Select date from calender"
									href="#" onClick="callCalender('txt_empaneledon')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
									alt="Select date from calender"></a></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
					<td>&nbsp;</td>
					<td>Country</td>
					<td><input type="text" name="txt_country" size="15"
							maxlength="20" tabindex="13"
							value="<%=Helper.correctNull((String) hshValues
							.get("VALUERS_COUNTRY"))%>"
							onKeyPress="notAllowSplChar()">
							<input type="hidden"
													name="hidperapp_country"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_country"))%>"><a href="#"  id="idsearch3"
													onClick="callCntrySearch('txt_country','hidperapp_country')"
													style="cursor:hand" tabindex="8"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="21"></a> 
							
							
							
							</td>
							
							
							 <td></td>
							  <td>&nbsp;</td>
							 <td  id="id_jewel_10">Office Fax No.</td>
						 
                  <td  id="id_jewel_11"><input type="text" name="txt_offfaxno" size="18"
							maxlength="15" tabindex="19"
							value="<%=Helper.correctNull((String) hshValues
							.get("VALUERS_OFF_FAXNO"))%>"
							onKeyPress="allowPhone()"></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>Residential Phone No</td>
						<td><input type="text" name="txt_resphone" size="18"
							maxlength="15" tabindex="16"
							value="<%=Helper.correctNull((String) hshValues
							.get("VALUERS_RES_PHONENO"))%>"
							onKeyPress="allowPhone()"></td>
						
                  <td>&nbsp;</td>
						
                  <td>&nbsp;</td>
						<td>Mobile No.</td>
						<td><input type="text" name="txt_resmobileno" size="15"
							maxlength="10" tabindex="17"
							value="<%=Helper.correctNull((String) hshValues
							.get("VALUERS_RES_MOBNO"))%>"
							onKeyPress="allowPhone()"></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>Office Phone No.</td>
						<td><input type="text" name="txt_offphone" size="18"
							maxlength="15" tabindex="18"
							value="<%=Helper.correctNull((String) hshValues
							.get("VALUERS_OFF_PHONENO"))%>"
							onKeyPress="allowPhone()"></td>
						
                  <td>&nbsp;</td>
						
                  <td>&nbsp;</td>
						<td>Action</td>
						<td><select name="txt_action" tabindex="20">
							<option value="1" selected="selected">Enabled</option>
							<option value="2">Disabled</option>
						</select></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>Email Id</td>
						<td colspan="3"><input type="text" name="txt_emailid"
							size="38" maxlength="50" tabindex="21"
							value="<%=Helper.correctNull((String) hshValues
							.get("VALUERS_EMAIL"))%>"
							onKeyPress=""
							onBlur="isEmailAddr(document.forms[0].txt_emailid.value,document.forms[0].txt_emailid)">
						</td>
						
                  <td>Comments</td>
						<td ><textarea name="txt_comments"
							onKeyPress="notAllowedDouble();notAllowSingleQuote()" rows="3"
							cols="40" tabIndex="22"
							onkeyup="textlimitcorp1(this,300);" onkeydown="textlimitcorp1(this,300);"><%=Helper.correctNull((String) hshValues
							.get("VALUERS_COMMENTS"))%></textarea>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td valign="top" id="jewel_appid_03">Expiry Date of Sanction<span class="mantatory">*</span></td>
						<td valign="top" id="jewel_appid_04"><input type="text"
							name="txt_expdateofsanc" size="15" maxlength="15"
							tabindex="6"
							value="<%=Helper.correctNull((String) hshValues
							.get("VALUERS_EXPDATEOFSANC"))%>"
							onBlur="checkDate(this);">
							<a alt="Select date from calender"
									href="#" onClick="callCalender('txt_expdateofsanc')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
									alt="Select date from calender"></a>
						</td>
					</tr>
					
						<tr id="id_jewel_12">
						<td>&nbsp;</td>
						<td>If he is Black Listed</td>
						<td colspan="3"><select name="sel_blacklist"
							onChange="getdate()" tabindex="23">
							<option value="N">No</option>
							<option value="Y">Yes</option>
						</select></td>
						<td id="t1">Black Listed Date<span class="mantatory">*</span></td>
						<td id="t2">
						<table border="0" cellspacing="0" cellpadding="4">
							<tr>
								<td><input type="text" name="txt_blacklistdate" size="11"
									tabindex="24" maxlength="10"
									onBlur="checkmaxdate(this,currdate);checkDate(document.forms[0].txt_blacklistdate);"
									value="<%=Helper.correctNull((String) hshValues
							.get("apprisal_Date"))%>">
								</td>
								<td><a href="#" alt="Select date from calender"
									onClick="callCalender('txt_blacklistdate')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"> <img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
									alt="Select date from calender" tabindex="24"></a></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr id="id_natureValuation">
						<td>&nbsp;</td>
						<td valign="top"> Nature of Valuation <span class="mantatory">*</span></td>
						<td> 
							<select name="sel_securitytype" size="8" multiple="multiple">
                  				  <lapschoice:staticdatasecuritiestag parenttype='!0' />
							</select>
						</td>
						<td>&nbsp;</td><td>&nbsp;</td>
						<td valign="top">Category Code <span class="mantatory">*</span></td>
						<td valign="top" > 
							<select name="sel_CategoryCode">
								<option value="">---Select---</option>
								<lapschoice:StaticDataTag apptype="205"/> 
							</select>
						</td>
					</tr>
						<tr id="id_locValued">
							<td>&nbsp;</td>
							<td  valign="top">  
							<table border="0" cellspacing="0" cellpadding="4" class="outertable">
								<tr>
									<td>Location / area of the asset to be valued </td>
									<td> <a onClick="addLocValued();"><img
												src="<%=ApplicationParams.getAppUrl()%>img/add.png"
												width="10" height="10" border="0" tabindex="38"></a>&nbsp;&nbsp;&nbsp;
									<a onClick="deleteRow1('tabid_locvalued','0');"><img
											src="<%=ApplicationParams.getAppUrl()%>img/cancel.png"
											width="10" height="10" border="0" tabindex="38"></a>
									</td>
								 </tr>
							</table>
							</td>
							<td  colspan="3"> 
								<table border="0" cellspacing="0" cellpadding="4" class="outertable" id="tabid_locvalued" width="80%">
									<tr>
									 		<td width="5%"><input type="checkbox" name="chk1" style="border: none;"></td>
											<td width="22%">State</td>
											<td width="23%"><b><select name="sel_state" id="1" onchange="changeState(this.id)" >
												<option value="s">--Select--</option>
												<lapschoice:statemaster apptype="Code"/>
											</select> </b></td>
											<td width="23%">District</td>
											<td width="27%" nowrap="nowrap"><input type="text" name="txt_district"
												value="" readonly="readonly"> <input type="hidden"
												name="txt_districtcode"
												value="<%=Helper.correctNull((String) hshValues.get("txt_districtcode"))%>"> <span id="1" onClick="showDistrict(this.id)" style="cursor: hand"><img	src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
												border="0"></span></td>
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
<br>
<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Audit Trail"
btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<input type="hidden" name="hidorg_code"
	value="<%=Helper.correctNull((String) hshValues.get("ORG_CODE"))%>">
<input type="hidden" name="hidsno"
	value="<%=Helper.correctNull((String) hshValues
									.get("VALUERS_CODE"))%>">
<input type="hidden" name="hidmastid"/>
 <input	type="hidden" name="hidAppVal"> 
 <input type="hidden" name="hidseqno"
	value="<%=Helper.correctNull((String) hshValues.get("valuers_seqno"))%>">
	<input type="hidden" name="hidzip">
 <lapschoice:hiddentag pageid='<%=PageId%>'/> 
 <input type="hidden" name="hidExorgcode">
 <input type="hidden" name="hidCBSID">
 <input type="hidden" name="hidbranchCode">
 <input type="hidden" name="hidbranchname">
 <input type="hidden" name="hidNatureValuation">
 <input type="hidden" name="hidValuerLocation">
 
</form>
</body>
</html>

