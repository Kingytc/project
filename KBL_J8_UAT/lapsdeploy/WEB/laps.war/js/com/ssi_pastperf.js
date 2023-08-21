
 function doNew()
  {
		disableFields(false);
		document.forms[0].hidAction.value		  = "new";
		document.forms[0].txt_part.disabled		  = false;
		document.forms[0].txt_year1.readOnly        = false;
		document.forms[0].txt_year2.readOnly	    = false;
		document.forms[0].txt_year3.readOnly        = false;
		document.forms[0].txt_part.value		  = "S";
		document.forms[0].txt_year1.value		  = "";
		document.forms[0].txt_year2.value	      = "";
		document.forms[0].txt_year3.value	      = "";
		document.forms[0].cmdedit.disabled = true;
		document.forms[0].cmdnew.disabled = true;
		document.forms[0].cmdcancel.disabled = false;
		document.forms[0].cmddelete.disabled = true;
		document.forms[0].cmdclose.disabled = true;
		document.forms[0].cmdedit.disabled = true;
		document.forms[0].cmdsave.disabled = false;
	
  }



function doClose()
 {
	if (ConfirmMsg("100"))
   {
	self.close();
   }
 }

function doSave()
{
	if(document.forms[0].txt_part.value=="S")
	{
		alert("Select Particulars");
		document.forms[0].txt_part.focus();
		return false;
	}
	
	/*else
	{*/
		if(document.forms[0].hidAction.value=="new")
		{
			if(cntT==1  && document.forms[0].txt_part.value=="T") 
			{
				alert("Cannot insert particulars already selected. If you want to change go for Edit Mode");
				return false;
			}
			else if (cntR==1  && document.forms[0].txt_part.value=="R")
			{
				alert("Cannot insert particulars already selected. If you want to change go for Edit Mode");
				return false;
			}
			else if (cntN==1 && document.forms[0].txt_part.value=="N")
			{
				alert("Cannot insert particulars already selected. If you want to change go for Edit Mode");
				return false;
			}
		
			else
			{
					document.forms[0].cmdsave.disabled=true;
					document.forms[0].hidBeanId.value="arrears";
					document.forms[0].hidBeanMethod.value="updateSSIpastData";
					document.forms[0].hidBeanGetMethod.value="getSSIpastData";
					document.forms[0].action=appUrl+"controllerservlet";
					document.forms[0].hidSourceUrl.value="/action/ssi_pastperf.jsp";
					document.forms[0].submit();
			}
		}
		else
		{
				document.forms[0].cmdsave.disabled=true;
				document.forms[0].hidBeanId.value="arrears";
				document.forms[0].hidBeanMethod.value="updateSSIpastData";
				document.forms[0].hidBeanGetMethod.value="getSSIpastData";
				document.forms[0].action=appUrl+"controllerservlet";
				document.forms[0].hidSourceUrl.value="/action/ssi_pastperf.jsp";
				document.forms[0].submit();

		}
	//}
		  
}

  function disableCommandButtons(val)
  {
	  if(val=="load")
	  {  
		  document.forms[0].cmdnew.disabled		= false;
		  document.forms[0].cmdedit.disabled	= true;
		  document.forms[0].cmddelete.disabled		= true;
		  document.forms[0].cmdsave.disabled	= true;
		  document.forms[0].cmdcancel.disabled	= true;
		  document.forms[0].cmdclose.disabled	= false;
	  }
	 
	  if(val=="edit")
	  {
		  document.forms[0].cmdnew.disabled		= true;
		  document.forms[0].cmdedit.disabled	= true;
		  document.forms[0].cmddelete.disabled		= true;
		  document.forms[0].cmdsave.disabled	= false;
		  document.forms[0].cmdcancel.disabled	= false;		 
		  document.forms[0].cmdclose.disabled	= false;	 
		  disableFields(false);
	  }

 }  

  
  
  function doEdit()
  {	  
	  /*if(document.forms[0].txt_part.value=="S")
	  {
		alert("Select a record");
		return false;
	  }
	  else
	  {*/
		document.forms[0].hidAction.value ="edit";
		disableFields(false);
		
		document.forms[0].txt_year1.readOnly        = false;
		document.forms[0].txt_year2.readOnly	    = false;
		document.forms[0].txt_year3.readOnly        = false;
		document.forms[0].txt_part.disabled        = true;
		
		document.forms[0].cmdedit.disabled    = true;
		document.forms[0].cmdnew.disabled     = true;
		document.forms[0].cmdclose.disabled   = true;
		document.forms[0].cmdsave.disabled    = false;
		document.forms[0].cmdcancel.disabled  = false;
		document.forms[0].cmddelete.disabled     = true;
	  //}
 }


 

 function doCancel()
{
   if (ConfirmMsg("102"))
   {
   		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="arrears";
		document.forms[0].hidBeanGetMethod.value="getSSIpastData";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/ssi_pastperf.jsp";
		document.forms[0].submit();
	 }
}
	
function disableFields(val)
  {
	  for(var i=0;i<document.forms[0].length;i++)
	  {		  
		  if(document.forms[0].elements[i].type=="textarea")
		  {
			  document.forms[0].elements[i].readOnly=val;
			  
		   }
	  }
}

function doDelete()
{
	if(document.forms[0].txt_part.value=="S")
	  {
		alert("Select a record");
		return false;
	  }
	  else
	{
	if(ConfirmMsg(101))
	{
		
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanId.value="arrears";
		document.forms[0].hidBeanMethod.value = "updateSSIpastData";
		document.forms[0].hidBeanGetMethod.value = "getSSIpastData";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/ssi_pastperf.jsp";
		document.forms[0].method = "post";
		document.forms[0].submit();
	}
	}
}
	
function onloading()
{	
	  	disableFields(true);
	  	
	  	/*if(document.forms[0].appstatus.value == 'Open/Pending')
	  	{
		document.forms[0].cmdedit.disabled	 = true;
		document.forms[0].cmdsave.disabled	 = true;
		document.forms[0].cmdcancel.disabled = true;
		document.forms[0].cmddelete.disabled = true;
		document.forms[0].cmdclose.disabled  = false;
		document.forms[0].cmdnew.disabled    = false;
		}
		else
		{
		document.forms[0].cmdedit.disabled	 = true;
		document.forms[0].cmdsave.disabled	 = true;
		document.forms[0].cmdcancel.disabled = true;
		document.forms[0].cmddelete.disabled = true;
		document.forms[0].cmdclose.disabled  = false;
		document.forms[0].cmdnew.disabled    = true;
		}*/
		document.forms[0].txt_year1.value        = "";
		document.forms[0].txt_year2.value	     = "";
		document.forms[0].txt_year3.value        = "";
	
		document.forms[0].txt_year1.readOnly        = true;
		document.forms[0].txt_year2.readOnly	    = true;
		document.forms[0].txt_year3.readOnly        = true;
		document.forms[0].txt_part.disabled         = true;


}
 
function placevalue(val1,val2,val3,val4,val5,val6,val7)
{
	document.forms[0].hidAction.value = "edit";
	document.forms[0].seqno.value		= val2;
	document.forms[0].txt_part.value	= val4;
	document.forms[0].txt_year1.value	= val5;
	document.forms[0].txt_year2.value	= val6;
	document.forms[0].txt_year3.value  	= val7;
		
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		document.forms[0].cmdedit.disabled	 = false;
		document.forms[0].cmdsave.disabled	 = true;
		document.forms[0].cmdcancel.disabled = false;
		document.forms[0].cmddelete.disabled    = false;
		document.forms[0].cmdclose.disabled  = true;
		document.forms[0].cmdnew.disabled    = true;
	}
}