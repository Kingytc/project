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
		document.forms[0].cmdclose.disabled=true;
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
        if(isComplete())
        {
        	document.forms[0].cmdsave.disabled=true;
			document.forms[0].hidBeanId.value="agrcommon";
			document.forms[0].hidBeanGetMethod.value="getExpense";	
		    document.forms[0].hidBeanMethod.value="updateIncomeandExpense";
			document.forms[0].action=appURL+"controllerservlet";
		    document.forms[0].hidSourceUrl.value="/action/agr_common_expense.jsp";
			document.forms[0].submit();		
		}
}

function selectValues(sno)
{
	document.forms[0].hidAction.value = "edit";		
	appno=document.forms[0].appno.value;
	if(sno!="")
	{	
		document.all.ifrm.src=appURL+"action/ifagr_common_income.jsp?hidBeanId=agrcommon&appno="+appno+"&seqno="+sno+"&hidBeanGetMethod=getExpense&hidAction=edit";
	}
	if(document.forms[0].btnenable.value=="Y")
	{
	   disableCommandButtons("radioselect");   
	}
}

function onloading()
{	
	disableFields(true);
}

function doEdit()
{
   document.forms[0].hidAction.value = "update";	
   document.forms[0].hideditflag.value="Y";
   disableCommandButtons("edit");     
}

function doDelete()
{     
 	if(ConfirmMsg(101))
	{
        document.forms[0].hidAction.value = "delete";		
        document.forms[0].hidBeanId.value="agrcommon";
		document.forms[0].hidBeanGetMethod.value="getExpense";	
	    document.forms[0].hidBeanMethod.value="deleteIncomeAndExpense";
		document.forms[0].action=appURL+"controllerservlet";
	    document.forms[0].hidSourceUrl.value="/action/agr_common_expense.jsp";
		document.forms[0].submit();	
	}	
		
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="agrcommon";
		document.forms[0].hidBeanGetMethod.value="getExpense";
		document.forms[0].action=appURL+"action/agr_common_expense.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}


function doNew()
{
	disableFields(false);
	disableCommandButtons("edit");
	document.forms[0].hideditflag.value="Y";
    document.forms[0].hidAction.value = "insert";	
    document.forms[0].seqno.value="";
   
	for(var i=0;i<document.forms[0].length;i++)
	{
	 	if(document.forms[0].elements[i].type=='radio')
	 	{
			document.forms[0].elements[i].checked=false;
	 	}	  
	}
}

function isComplete(){

  if(document.forms[0].txt_agr_common_incomeandexpense.value==""){
       ShowAlert(121,"Expense Details");
       return false;
  }
  
  if(document.forms[0].txt_agr_common_year1.value==""){
    ShowAlert(121,"I Year");
    return false;
  }
  
  if(document.forms[0].txt_agr_common_year2.value==""){
    ShowAlert(121,"II Year");
    return false;
  }
  
  return true;
}


