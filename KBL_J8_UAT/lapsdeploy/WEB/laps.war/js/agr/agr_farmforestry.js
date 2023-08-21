function disableCommandButtons(new1,edit,save,cancel,del,close)
{
	document.forms[0].cmdnew.disabled=new1;
  	document.forms[0].cmdedit.disabled=edit;
  	document.forms[0].cmdsave.disabled=save;
  	document.forms[0].cmdcancel.disabled=cancel;
  	document.forms[0].cmddelete.disabled=del;
 	document.forms[0].cmdclose.disabled=close;
}
function disableFields(flag)
{	
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=flag;		  
		}
	}
}
function doNew()
{
	disableFields(false);
	disableCommandButtons(true,true,false,false,true,true);
	document.forms[0].sel_part.disabled=true;
	document.forms[0].hidAction.value="insert";
	document.forms[0].txt_incomemain.readOnly = true;
	document.forms[0].txt_incomeprod.readOnly = true;
	document.forms[0].txt_grossinc.readOnly = true;
	document.forms[0].txt_grossexp.readOnly = true;
	document.forms[0].txt_netinc.readOnly = true;
	document.forms[0].txt_totnetinc.readOnly = true;
}
function doEdit()
{	
	
	document.forms[0].hidAction.value="update";
	document.forms[0].hideditflag.value = "Y";
	disableFields(false);
	disableCommandButtons(true,true,false,false,true,true);
	
}
function doSave()
{	
	//For Making Mandatory while saving the data
	if(trimtxt(document.forms[0].sel_part.value)=="")
	{
	ShowAlert('111','Particulars');
	document.forms[0].sel_part.focus();
	return;
	}
	if(trimtxt(document.forms[0].txt_yieldyear.value)=="")
	{
	ShowAlert('121','Yielding year');
	document.forms[0].txt_yieldyear.focus();
	return;
	}
	document.forms[0].sel_part.disabled=false;
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="agrfarmmachinery";
	document.forms[0].hidBeanMethod.value="updateFarmForestrydet";
	document.forms[0].hidBeanGetMethod.value="getFarmForestrydet";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/agr_farmforestry.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();	

	
}

function doCancel()
{
	if(ConfirmMsg('102'))
	{	  
		document.forms[0].hidBeanId.value="agrfarmmachinery"
		document.forms[0].hidBeanGetMethod.value="getFarmForestrydet"
		document.forms[0].action=appURL+"action/agr_farmforestry.jsp";
		document.forms[0].submit();
	}
}

function doClose()
{	
	var con=ConfirmMsg('100');
	if(con)
	{		
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();		
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="agrfarmmachinery";
		document.forms[0].hidBeanMethod.value="updateFarmForestrydet";
		document.forms[0].hidBeanGetMethod.value="getFarmForestrydet";	
		document.forms[0].hidSourceUrl.value="/action/agr_farmforestry.jsp";
		document.forms[0].submit();
	}
}


function callunitcost()
{
		var varpart = document.forms[0].sel_part.value;
		document.forms[0].hidBeanId.value="agrfarmmachinery"
		document.forms[0].hidBeanGetMethod.value="getFarmForestrydet"
		document.forms[0].action=appURL+"action/agr_farmforestry.jsp?varsno="+varpart;
		document.forms[0].submit();
}
function TotalInccal()
{
	var varyieldno = parseFloat(document.forms[0].txt_yieldno.value);
	var varsalepricemain = parseFloat(document.forms[0].txt_salepricemain.value);
	var varincomemain = parseFloat(document.forms[0].txt_incomemain.value);
	var varyieldnoprod = parseFloat(document.forms[0].txt_yieldnoprod.value);
	var varsalepriceprod = parseFloat(document.forms[0].txt_salepriceprod.value);
	var varincomeprod = parseFloat(document.forms[0].txt_incomeprod.value);
	var vargrossinc = parseFloat(document.forms[0].txt_grossinc.value);
	var vargrossexp = parseFloat(document.forms[0].txt_grossexp.value);
	var varnetinc = parseFloat(document.forms[0].txt_netinc.value);
	var vartotnetinc = parseFloat(document.forms[0].txt_totnetinc.value);
	document.forms[0].txt_incomemain.value =  roundVal(NanNumber(parseFloat(varyieldno)*(varsalepricemain)));
	document.forms[0].txt_incomeprod.value =  roundVal(NanNumber(parseFloat(varyieldnoprod)*(varsalepriceprod)));
	document.forms[0].txt_grossinc.value =  roundVal(NanNumber(parseFloat(document.forms[0].txt_incomemain.value)+parseFloat(document.forms[0].txt_incomeprod.value)));
	document.forms[0].txt_grossexp.value = roundVal(NanNumber(parseFloat(document.forms[0].hidunitcose.value)));
	document.forms[0].txt_netinc.value =  roundVal(NanNumber(parseFloat(document.forms[0].txt_grossinc.value)-parseFloat(document.forms[0].txt_grossexp.value)));
	document.forms[0].txt_totnetinc.value = roundVal(NanNumber(parseFloat(document.forms[0].txt_netinc.value)*(document.forms[0].txt_totareaval.value)));
}
function selectValues(val0,val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13)
{
	document.forms[0].txt_totareaval.value = val0;
	document.forms[0].sel_part.value = trim(val1);
	document.forms[0].txt_yieldyear.value = val2;
	document.forms[0].txt_yieldno.value = val3;
	document.forms[0].txt_salepricemain.value = val4;
	document.forms[0].txt_incomemain.value = val5;
	document.forms[0].txt_yieldnoprod.value = val6;
	document.forms[0].txt_salepriceprod.value = val7;
	document.forms[0].txt_incomeprod.value = val8;
	document.forms[0].txt_grossinc.value = val9;
	document.forms[0].txt_grossexp.value = val10;
	document.forms[0].txt_netinc.value = val11;
	document.forms[0].txt_totnetinc.value = val12;
	document.forms[0].hidsno.value = val13;
	document.forms[0].sel_part.disabled=true;
	disableCommandButtons(true,false,true,true,false,true);
	
}