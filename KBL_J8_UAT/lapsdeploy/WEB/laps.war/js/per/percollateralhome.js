function callOnload()
{
	/*disableCommandButtons(false,true,true,true,true,false); 
	if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
	{
		document.forms[0].cmdnew.disabled =true;
	}*/
	document.forms[0].selapptype.value=selappvalue;
	disableFields(true);
	
}
function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,
			val13,val14,val15,val16,val17,val18,val19,val20,val21,val22,val23,val24)
	{
	var apptype=val2+val3
    //document.forms[0].selapptype.value=apptype;
    document.forms[0].hid_sino.value =val4 ;
	document.forms[0].txthome_contperson.value= val5;
	document.forms[0].hidcity.value= val6;
	document.forms[0].hidstate.value= val7;
    document.forms[0].txthome_titlezip.value=val8;
    document.forms[0].txthome_titleadd1.value=val9;
	document.forms[0].txthome_titleadd2.value=val10;
	document.forms[0].txthome_yrbuilt.value=val11;
	document.forms[0].txthome_purchaseval.value=val12;
	document.forms[0].txthome_appval.value=val13;
	document.forms[0].txthome_mortval.value=val14;
	document.forms[0].txthome_extent.value=val15;
	document.forms[0].txthome_surveyno.value=val16;
	document.forms[0].txthome_propertytax.value=val17;
	document.forms[0].txthome_watertax.value=val18; 
	document.forms[0].txthome_other.value=val19;
	document.forms[0].txthome_desc.value=val20;
	document.forms[0].txthome_titlecity.value= val21;
	document.forms[0].txthome_titlestate.value= val22;
	document.forms[0].txthome_contperson2.value= val23;
	document.forms[0].txthome_contperson3.value= val24;
	if(document.forms[0].readFlag.value.toUpperCase()=="W" && document.forms[0].btnenable.value=="Y")
	{
		disableCommandButtons(true,false,true,false,false,true); 
	}
}
function doNew()
{
	if(document.forms[0].selapptype.value=="")
	{
		alert("Select Applicant Type");
		document.forms[0].selapptype.focus();
		return;
	}
	disableFields(false);
	disableCommandButtons(true,true,false,false,true,true); 
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value="insert";
	document.forms[0].txthome_contperson.value="";	 
	document.forms[0].txthome_titleadd1.value="";
	document.forms[0].txthome_titleadd2.value="";
	document.forms[0].txthome_titlecity.value="";
	document.forms[0].txthome_titlestate.value="";
	document.forms[0].txthome_titlezip.value="";
	document.forms[0].txthome_other.value="";
	document.forms[0].txthome_yrbuilt.value="";
	document.forms[0].txthome_extent.value="";
	document.forms[0].txthome_surveyno.value="";
	document.forms[0].txthome_purchaseval.value="";
	document.forms[0].txthome_mortval.value="";
	document.forms[0].txthome_desc.value="";
	document.forms[0].txthome_appval.value="";
	document.forms[0].txthome_propertytax.value="";
	document.forms[0].txthome_watertax.value=""; 
	document.forms[0].txthome_titlecity.readOnly=true;
	document.forms[0].txthome_titlestate.readOnly=true;
}
function doSave()
{	
	var selapptype=document.forms[0].selapptype.options[document.forms[0].selapptype.selectedIndex].value;
	if(selapptype=='')
	{
		alert("select Applicant Type");
		document.forms[0].selapptype.focus();
		return ;
	}
	var title=document.forms[0].txthome_contperson.value;
	if(title=='')
	{
		alert("Enter the Title Holder");
		document.forms[0].txthome_contperson.focus();
		return ;
	}
	
	var len = document.forms[0].selapptype.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].selapptype.options[i].selected==true)
		 {
			 document.forms[0].selapptype1.value = document.forms[0].selapptype.options[i].text; 
			break;
		 }
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanMethod.value="updatehome";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].hidBeanId.value="percollateral";
	document.forms[0].hidSourceUrl.value="/action/percollateralhome.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=(!val);
		}	
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		} 
	}
	document.forms[0].selapptype.disabled=false;
}
  
function doHelp()     
{
	var hlpvar = appURL+"phlp/loan_appretail_colsec_imoprop.htm";
	var title = "ImmovableProperty";
    var prop = "scrollbars=yes,width=600,height=450";	
    prop = prop + ",left=50,top=150";
    window.open(hlpvar,title,prop);
}
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
	}
}

function checkFileDate1(obj)
{
	var pagedate = obj.value;
	var pgdt = pagedate.substring(0,2);
	var pgmon = pagedate.substring(3,5);
	var pgyr = pagedate.substring(6,10);
	var objdate = pgmon+"/"+pgdt+"/"+pgyr;
	var currdate = currentDate;
	var crdt = currdate.substring(0,2);
	var crmon = currdate.substring(3,5);
	var cryr = currdate.substring(6,10);
	var curdate = crmon+"/"+crdt+"/"+cryr;		
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/persearch.jsp";
		document.forms[0].submit();
	}
}
function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].hidBeanId.value="percollateral";
		document.forms[0].action=appURL+"action/percollateralhome.jsp";	
		document.forms[0].submit();
	}
}
function doEdit()
{
	if(document.forms[0].selapptype.value=="")
	{
		alert("Select Applicant Type");
		return;
	}
	document.forms[0].hideditflag.value="Y";
	disableFields(false);
	disableCommandButtons(true,true,false,false,true,true); 
	document.forms[0].txthome_titlecity.readOnly=true;
	document.forms[0].txthome_titlestate.readOnly=true;
	document.forms[0].hidAction.value="update";
}
function doDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{
		var len = document.forms[0].selapptype.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].selapptype.options[i].selected==true)
			 {
				 document.forms[0].selapptype1.value = document.forms[0].selapptype.options[i].text; 
				break;
			 }
		}
	
		
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanMethod.value="updatehome";
	    document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].hidBeanId.value="percollateral";
		document.forms[0].hidSourceUrl.value="/action/percollateralhome.jsp";
	    document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].method="post";	
		document.forms[0].submit();
	
	}
}
function disableCommandButtons(cmdnew,cmdEdit,cmdSave,cmdCancel,cmdDelete,cmdClose)
{
	document.forms[0].cmdnew.disabled=cmdnew;
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdSave;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmddelete.disabled=cmdDelete;
	document.forms[0].cmdclose.disabled=cmdClose;
}  

function callCar()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		//document.forms[0].hidauto_type.value="C";
		document.forms[0].hidBeanGetMethod.value="getCollVehicleData";
		document.forms[0].hidBeanId.value="percollateral";
		document.forms[0].action=appURL+"action/percollateralcar.jsp";	
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}	
}


function callotherassets()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		//document.forms[0].hidauto_type.value="B";
		document.forms[0].hidBeanId.value="agrotherassets";
		document.forms[0].hidBeanGetMethod.value="getagrassets";		
		document.forms[0].action=appURL+"action/collotherassets.jsp";	
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function getCollData()
{
	if(document.forms[0].selapptype.value!="")
	{
		document.forms[0].hidBeanId.value="percollateral";
		document.forms[0].hidBeanGetMethod.value="getData";
	}
	document.forms[0].action=appURL+"action/percollateralhome.jsp";	
	document.forms[0].submit();
}