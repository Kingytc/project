function mortgage()
{
   if(document.forms[0].security.value == "0")
	{
		document.all.m1.style.visibility="hidden";
		document.all.m2.style.visibility="hidden";
		document.all.m3.style.visibility="hidden";
		document.all.m4.style.visibility="hidden";
		document.all.m1.style.position="absolute";
		document.all.m2.style.position="absolute";
		document.all.m3.style.position="absolute";
		document.all.m4.style.position="absolute";
	}
   if(document.forms[0].security.value == "1")
	{
		document.all.m1.style.visibility="visible";
		document.all.m2.style.visibility="visible";
		document.all.m3.style.visibility="visible";
		document.all.m4.style.visibility="visible";
		document.all.m1.style.position="relative";
		document.all.m2.style.position="relative";
		document.all.m3.style.position="relative";
		document.all.m4.style.position="relative";	
	}
	 if(document.forms[0].security.value == "2")
	{
		document.all.m1.style.visibility="hidden";
		document.all.m2.style.visibility="hidden";
		document.all.m3.style.visibility="hidden";
		document.all.m4.style.visibility="hidden";
		document.all.m1.style.position="absolute";
		document.all.m2.style.position="absolute";
		document.all.m3.style.position="absolute";
		document.all.m4.style.position="absolute";	
	}
	if(document.forms[0].security.value == "3")
	{
		document.all.m1.style.visibility="hidden";
		document.all.m2.style.visibility="hidden";
		document.all.m3.style.visibility="hidden";
		document.all.m4.style.visibility="hidden";
		document.all.m1.style.position="absolute";
		document.all.m2.style.position="absolute";
		document.all.m3.style.position="absolute";
		document.all.m4.style.position="absolute";		
	}
}
function chkcentgunt() 
{
	if(document.forms[0].land_measurement.value == 'g')
	{
		if(document.forms[0].txt_acreage1.value > 39)
		{
		 	alert("Guntas value cannot be greater than 39");
		 	document.forms[0].txt_acreage1.value = "";
		 	document.forms[0].txt_acreage1.focus();
		}
	}
}
function enableButtons(bool1, bool2, bool3, bool4, bool5,bool6)
{
	document.forms[0].cmdclose.disabled = false;
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/"+"retailpge.jsp";				
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
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=one;		  
		}		
	}	
}
function selectValues(val1, val2, val3,val5, val6, val7, val8, val9, val10, val11, val12, val13, val14, val15, val16, val20,val21,val23,val24,val25,val28,val30,val31,val32,val33,val34,val29,totacr)
{
	document.forms[0].selsno.value = val3;
	document.forms[0].txt_acreage.value = val5;
	document.forms[0].village.value = val6;
	document.forms[0].txt_taluk.value = val7;
	document.forms[0].txt_district.value = val8;
	document.forms[0].survey.value = val9;
	document.forms[0].txt_landrevenue.value = val10;
	document.forms[0].txt_value.value = val11;
	document.forms[0].sellease.value =val12;
	checkLease();
	document.forms[0].leaseperiod.value =val13;
	document.forms[0].txt_amtrent.value = val14;
	document.forms[0].farmdistance.value = val20;
	document.forms[0].housedistance.value = val21;
	document.forms[0].txt_acreage1.value = val23;
	document.forms[0].txt_Irrigated.value=val30;
	document.forms[0].txt_nonIrrigated.value=val31;
	document.forms[0].txt_nonCultivable.value=val32;
	document.forms[0].txt_Cultivable.value=val33;
	if(totacr=="Y")
	{	
	 document.forms[0].sel_FarmerCategory.value=val34;
	}
	document.forms[0].source.value = document.getElementById("hidsource"+val29).value;
	document.forms[0].encumbrance.value = document.getElementById("hidencumbrance"+val29).value;
	document.forms[0].txr_encroached.value = document.getElementById("hidencroached"+val29).value;
	document.forms[0].txr_fruit.value = document.getElementById("hidtreesfruit"+val29).value;
	document.forms[0].txr_nonfruit.value = document.getElementById("hidtreesnonfruit"+val29).value;
	document.forms[0].txr_address.value = document.getElementById("hidaddress"+val29).value;
	roundtxt(document.forms[0].txt_landrevenue);
	roundtxt(document.forms[0].txt_value);
	if(document.forms[0].btnenable.value=="Y")
	{			
		disableCommandButtons("radioselect");   
	} 
}
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdclose.disabled=false;
	}
	if(val=="approved")
	{  
		disableFields(true);
		document.forms[0].cmdclose.disabled=false;
	}	 
	if(val=="edit")
	{		  
		document.forms[0].cmdclose.disabled=false;	 
		disableFields(false);
	}
	if(val=="radioselect")
	{	  
		disableFields(true);
		document.forms[0].cmdclose.disabled=false;	 
	}	  
}  
function onloading()
{	
	disableFields(true);
	checkLease();	
}
function checkLease()
{
	if(document.forms[0].sellease.value == "2")
	{
		document.all.r1.style.visibility="visible";		
		document.all.r1.style.position="relative";	
	}
	else
	{
		document.all.r1.style.visibility="hidden";	
		document.all.r1.style.position="absolute";
		document.forms[0].leaseperiod.value="";
	}
}
function getChange()
{
	id =document.forms[0].chobank_apptype.value
}
function callCalender(name)
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		showCal(appURL,name);
	}
}