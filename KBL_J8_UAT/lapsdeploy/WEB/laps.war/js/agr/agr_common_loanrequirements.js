function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/perborrowersearch.jsp?hidPageType=EXI";
		document.forms[0].submit();
	}
}


function disableCommandButtons(val)
{	 
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdnew.disabled =false;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}	 
	if(val=="edit")
	{		  
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=false;
		document.forms[0].cmdcancel.disabled=false;		 
		document.forms[0].cmdclose.disabled=true;	 
		disableFields(false);
	}
	if(val=="radioselect")
	{	  
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=false;
		//document.forms[0].cmdclose.disabled=false;
	}	  
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
			document.forms[0].elements[i].disabled=!val;
		}	 
	}	  
}



function doSave()
{
var len = document.forms[0].sel_agrcommon_type.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_agrcommon_type.options[i].selected==true)
		 {
			 document.forms[0].sel_agrcommon_type_text.value = document.forms[0].sel_agrcommon_type.options[i].text; 
			break;
		 }
	}

        if(isComplete())
        {
        	document.forms[0].cmdsave.disabled=true;
			document.forms[0].hidBeanId.value="agrcommon";
			document.forms[0].hidBeanGetMethod.value="getLoanRequirementsData";	
		    document.forms[0].hidBeanMethod.value="updateLoanRequirements";
			document.forms[0].action=appURL+"controllerservlet";
		    document.forms[0].hidSourceUrl.value="/action/agr_common_loanrequirements.jsp";
			document.forms[0].submit();		
		}
}

function selectValues(sno)
{
	document.forms[0].hidAction.value = "edit";		
	appno=document.forms[0].appno.value;
	if(sno!="")
	{	
		document.all.ifrm.src=appURL+"action/iframeargcommonloanrequirements.jsp?hidBeanId=agrcommon&appno="+appno+"&seqno="+sno+"&hidBeanGetMethod=getLoanRequirementsData&hidAction=edit&schemetype="+schemetype;
	}
	if(document.forms[0].btnenable.value=="Y")
	{
	   	disableCommandButtons("radioselect");   
	}
}

function doEdit(){
   document.forms[0].hidAction.value = "update";	
   disableCommandButtons("edit");
   document.forms[0].hideditflag.value="Y";
   document.forms[0].txt_agrcommon_amount.readOnly=true;
   document.forms[0].txt_agrcommon_particulars.focus();
}

function doDelete()
{      
var len = document.forms[0].sel_agrcommon_type.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_agrcommon_type.options[i].selected==true)
		 {
			 document.forms[0].sel_agrcommon_type_text.value = document.forms[0].sel_agrcommon_type.options[i].text; 
			break;
		 }
	}

	if(ConfirmMsg(101))
	{
        document.forms[0].hidAction.value = "delete";		
        document.forms[0].hidBeanId.value="agrcommon";
		document.forms[0].hidBeanGetMethod.value="getLoanRequirementsData";	
	    document.forms[0].hidBeanMethod.value="deleteLoanRequirements";
		document.forms[0].action=appURL+"controllerservlet";
	    document.forms[0].hidSourceUrl.value="/action/agr_common_loanrequirements.jsp";
		document.forms[0].submit();	
	}	
		
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="agrcommon";
		document.forms[0].hidBeanGetMethod.value="getLoanRequirementsData";
		document.forms[0].action=appURL+"action/agr_common_loanrequirements.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}

function onloading()
{
 	disableFields(true);
 	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=schemetype;
}

function doNew()
{
	disableFields(false);
	disableCommandButtons("edit");
	document.forms[0].hideditflag.value="Y";
   document.forms[0].txt_agrcommon_particulars.value="";  
   document.forms[0].txt_agrcommon_units.value="";
   document.forms[0].txt_agrcommon_unitcost.value="";
   document.forms[0].txt_agrcommon_amount.value="";
   document.forms[0].seqno.value="";
   
	for(var i=0;i<document.forms[0].length;i++)
	{
	 	if(document.forms[0].elements[i].type=='radio')
	 	{
			document.forms[0].elements[i].checked=false;
	 	}	  
	}
	
	document.forms[0].txt_agrcommon_amount.readOnly=true;
	document.forms[0].txt_agrcommon_particulars.focus();
	
}
function doCal(){
   
   var unit=document.forms[0].txt_agrcommon_units.value;
   var cost=document.forms[0].txt_agrcommon_unitcost.value;
   var total=0;
   if(unit==""){
      unit="1";
   }
   if(cost==""){
      cost="0";
   }
        
   total=eval(cost)*eval(unit);
   document.forms[0].txt_agrcommon_amount.value=total;
   roundtxt(document.forms[0].txt_agrcommon_amount); 
    
}

 
function isComplete(){
 
 
  if(document.forms[0].txt_agrcommon_particulars.value==""){
       ShowAlert(121,"Particulars");
       document.forms[0].txt_agrcommon_particulars.focus();
       return false;
  }
  if(document.forms[0].txt_agrcommon_units.value==""){
	    ShowAlert(121,"No. of Units");
	    document.forms[0].txt_agrcommon_units.focus();
	    return false;
	  }
  
  if(document.forms[0].txt_agrcommon_unitcost.value==""){
    ShowAlert(121,"Unit Cost");
    document.forms[0].txt_agrcommon_unitcost.focus();
    return false;
  }
  
  return true;
}
