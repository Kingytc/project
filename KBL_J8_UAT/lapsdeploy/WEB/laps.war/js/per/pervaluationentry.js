function ClearFields()
{
	document.forms[0].hidsno.value = "";
	document.forms[0].txt_name.value="";
	document.forms[0].txt_dateofentry.value="";
	document.forms[0].txt_refrate.value="";
	document.forms[0].txt_Certificationno.value="";
	document.forms[0].txt_CertDate.value="";
	document.forms[0].txt_landvalue.value="";
	if("<%=prd_type%>"=="pH")
		document.forms[0].txt_buildervalue.value="";
	document.forms[0].txt_estimatedvalue.value="";
	document.forms[0].txt_comments.value="";
	document.forms[0].txt_dateofvaluation.value="";
	document.forms[0].txt_guirate.value="";
	document.forms[0].txt_dateofsent.value="";
}

function doNew() 
{	
	document.forms[0].hidAction.value="New"	
	enableButtons(true, true, false, false, true,true);
	disablefields(false);
	ClearFields();
	document.forms[0].hideditflag.value="Y";
}

function doEdit() 
{
	var varsecID=document.forms[0].hidsecID.value;
	if(varsecID==null || varsecID==""){
		disablefields(false);
	}else{
		disablefields(true);
		document.forms[0].txt_refrate.readOnly=false;
		document.forms[0].txt_guirate.readOnly=false;
		document.forms[0].txt_Certificationno.readOnly=false;
		if(varprdtype=="pH"){
			document.forms[0].txt_buildervalue.readOnly=false;
			document.forms[0].txt_estimatedvalue.readOnly=true;
			document.forms[0].txt_landvalue.readOnly=false;
		}
		if(varprdtype=="pA"){
			document.forms[0].txt_landvalue.readOnly=true;
			document.forms[0].txt_estimatedvalue.readOnly=false;
		}
		document.forms[0].txt_comments.readOnly=false;
	}
	document.forms[0].hidAction.value="Edit"
	enableButtons(true, true, false, false, true,true);
	document.forms[0].hideditflag.value="Y";
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="perpropertydetails";
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanMethod.value="updateValuerEntryData";
	  	document.forms[0].hidBeanGetMethod.value="getValuerEntryData";
		document.forms[0].hidSourceUrl.value="/action/valuation_entry.jsp";
		document.forms[0].submit();
	}		
}



function doCancel()
{
	var varconfirm=ConfirmMsg('102');	
	if(varconfirm)
	{
		document.forms[0].hidBeanGetMethod.value="getValuerEntryData";
		document.forms[0].hidBeanId.value="perpropertydetails";
		document.forms[0].action=appURL+"action/valuation_entry.jsp";	
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
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=!one;
		}
	}
	document.forms[0].txt_name.readOnly=true;

	if(document.forms[0].sel_branchpanel.value=="Y")
	{	
		document.all.b1.style.visibility="visible";
		document.forms[0].txt_name.readOnly=true;
		
	}
	else if(document.forms[0].sel_branchpanel.value=="N")
	{
		document.all.b1.style.visibility="hidden";
		document.forms[0].txt_name.readOnly=false;
	}
}

function enableButtons(bool1, bool2, bool3, bool4, bool5, bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}
function compareDate()
{
	var d1 = document.forms[0].txt_dateofsent.value;
	d1 = changeDateformat(d1);
	var d2 = document.forms[0].txt_dateofvaluation.value;
	d2 = changeDateformat(d2);
	if(document.forms[0].txt_dateofvaluation.value != "")
	{
		if( d1 > d2 )
		{
			alert("Date of Received should not less than Date of Sent");
			document.forms[0].txt_dateofvaluation.focus();	
			document.forms[0].txt_dateofvaluation.value="";
		}
	}
}
function callCalender(fname)
{
	var action  =document.forms[0].hidAction.value;
	if(document.forms[0].hidsecID.value=="" || document.forms[0].hidsecID.value==null){
		if(action =="New" || action =="Edit")
		{
			showCal(appURL,fname);
	    }
		if(document.forms[0].cmdsave.disabled==false)
		{
			showCal(appURL,fname);
		}
	}
}

function callCalender1(fname)
{
	var action  =document.forms[0].hidAction.value;
	
		if(action =="New" || action =="Edit")
		{
			showCal(appURL,fname);
	    }
		if(document.forms[0].cmdsave.disabled==false)
		{
			showCal(appURL,fname);
		}
	
}
function doSave()
{
	document.forms[0].hidRecordflag.value=varRecordFlag;
	if(trim(document.forms[0].txt_dateofsent.value)=="")
	{
		ShowAlert('121','Date Sent');
		document.forms[0].txt_dateofsent.focus();
		return;
	}	
	//if(document.forms[0].txt_name.value=="")
	//{
	//	alert("Select the Valuer Name");
	//	return;
	//}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="perpropertydetails";
	document.forms[0].hidBeanMethod.value="updateValuerEntryData";
	document.forms[0].hidBeanGetMethod.value="getValuerEntryData";
	document.forms[0].hidSourceUrl.value="/action/valuation_entry.jsp";	
	document.forms[0].submit();
}

function onloading()
{	
	ClearFields();
	disablefields(true);
	if(varprdtype=="pH" ||varprdtype=="pA" ||!(varprdtype=="pU" && varProAvailableFor=="V")){
		document.forms[0].cmdnew.disabled=true;
	}
}

function getSelectedValue(val1, val2, val3, val4, val5, val6, val7, val8, val9, val10, val11, val12, val13, val14, val15, val16,val17,val18,val19)
{	

	//document.forms[0].appno1.value=val1;
	document.forms[0].hidslno.value=val2;
	document.forms[0].txt_dateofentry.value=val3;
	document.forms[0].hidsno.value=val4;
	document.forms[0].txt_Certificationno.value=val5;
	document.forms[0].txt_CertDate.value=val6;
	document.forms[0].txt_landvalue.value=val7;
	if(varprdtype=="pH")
		document.forms[0].txt_buildervalue.value=val8;
	document.forms[0].txt_estimatedvalue.value=val9;
	document.forms[0].txt_comments.value=val10;
	document.forms[0].txt_dateofsent.value=val14;
	document.forms[0].hidsmno.value=val15;
	document.forms[0].txt_name.value=val16;
	document.forms[0].txt_dateofvaluation.value=val19;
	document.forms[0].txt_refrate.value=val12;
	document.forms[0].txt_guirate.value=val13;
	if(val17=="")
	{
		val17="Y";
	}
	document.forms[0].sel_branchpanel.value=val17;
	document.forms[0].hidsecID.value=val18;
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		enableButtons(true,false,true,false,false,false);
	}
	
	if(document.forms[0].sel_branchpanel.value=="Y")
	{	
		document.all.b1.style.visibility="visible";
	}
	else if(document.forms[0].sel_branchpanel.value=="N")
	{
		document.all.b1.style.visibility="hidden";
	}
}


function gototab(beanid,methodname,pagename)
{
	if(document.forms[0].hideditflag.value.toUpperCase()=="N")
	{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function selLawyerNme()
{
	if(document.forms[0].sel_branchpanel.value=="Y")
	{	
		document.all.b1.style.visibility="visible";
		document.forms[0].txt_name.readOnly=true;
		document.forms[0].txt_name.value="";
		document.forms[0].hidsno.value="";
		
	}
	else if(document.forms[0].sel_branchpanel.value=="N")
	{
		document.all.b1.style.visibility="hidden";
		document.forms[0].txt_name.readOnly=false;
		
		document.forms[0].txt_name.value="";
		document.forms[0].hidsno.value="";
	}
}

function callvaluerName()
{	
	var varsecID=document.forms[0].hidsecID.value;
	var action=document.forms[0].hidAction.value;
	if(document.forms[0].hideditflag.value=="Y" && (varsecID==""||varsecID==null))
	{
		var prop = "scrollbars=yes,width=500,height=400,top=100,left=250";
		var url=appURL+"action/valuerslist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getValuerMasterList&strfrom=ValuerEntry&hidAction=search&hidAppVal=V";
		//var url=appURL+"action/valuerslist.jsp?strfrom=ValuerEntry&hidAppVal=V";
		window.open(url,"",prop);
	}
}