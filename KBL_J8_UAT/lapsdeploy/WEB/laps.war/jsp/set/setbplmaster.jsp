<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Setup-City</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var mode ="load";
var appUrl ="<%=ApplicationParams.getAppUrl()%>";
var appURL ="<%=ApplicationParams.getAppUrl()%>";
var varstate="<%=Helper.correctNull((String)hshValues.get("statename"))%>";
function onloading()
{	 
    if(varstate!="")
	{
		document.forms[0].sel_state.value=varstate;
	}
	disableCommandButtons("load");
}

 function disableFields(val)
  {
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  if(document.forms[0].elements[i].type=='text')
		  {
			document.forms[0].elements[i].readOnly=val;
		  }	
	 }
 }
 
  function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}
	if(val=="edit")
	{	 
		 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	 
	
}  
 

function clearfields()
{
	document.forms[0].txt_amount.value="";
}
function doSave()
{
	if(document.forms[0].sel_state.value=="0")
  	{
  	ShowAlert('111',"State Name");
  	return false;
	}
 	if(trim(document.forms[0].txt_amount.value)=="")
 	{
 		ShowAlert(121,'Amount');
 		document.forms[0].txt_amount.focus();
 		return;
 	}
	
	var len = document.forms[0].sel_state.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_state.options[i].selected==true)
		 {
			 document.forms[0].sel_state1.value = document.forms[0].sel_state.options[i].text; 
			  break;
		 }
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanGetMethod.value="updatebpldetails";	
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].action=appUrl+"action/setbplmaster.jsp";
	document.forms[0].submit();
 }

  function doEdit()
  { 	
 
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");
	
 }

function doCancel()
  {
		if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/setbplmaster.jsp";
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidBeanGetMethod.value="getbpldetails";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 
	}	
  }
 function doDelete()
{
	if(ConfirmMsg(101))
		{
		var len = document.forms[0].sel_state.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].sel_state.options[i].selected==true)
			 {
				 document.forms[0].sel_state1.value = document.forms[0].sel_state.options[i].text; 
				  break;
			 }
		}
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanGetMethod.value="updatebpldetails";
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidSourceUrl.value="action/setbplmaster.jsp";	
		document.forms[0].submit();	
		
		}
		
}
 
 function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appUrl+"action/setstatecity.jsp";
		document.forms[0].submit();
	}
}
function getAmount()
{
	document.forms[0].hidSourceUrl.value="/action/setbplmaster.jsp";
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].hidBeanGetMethod.value="getbpldetails";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
} 
 
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>


<body onLoad="onloading()" >
<form name="workfrm" method="post" class="normal">
	    <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr>
            <td  class="page_flow">Home -&gt; Setup -&gt; BPL Master</td>
          </tr>
        </table>
  <br>  
  <br>  
                                     <table class="outertable border1" width="50%" border="0" cellspacing="0" cellpadding="0" align="center">
                                  <tr> 
                                    <td> 
                                      <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
                                        <tr class="dataheader" align="center"> 
                                          <td  colspan="2"><b>BPL Master </b></td>
                                        </tr>
                                        <tr> 
                                          <td colspan="2"> 
                                            <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="10">
                                              <tr> 
                                                <td>State Name </td>
                                                <td> 
                                                  <select name="sel_state" style="width:200" onChange="getAmount()">
                                                    <option value="0">--Select--</option>
                                                    <lapschoice:statemaster1 /> 
                                                  </select>
                                                </td>
                                              </tr>
                                              <tr> 
                                                <td>Amount per year</td>
                                                <td> 
												<lapschoice:CurrencyTag name="txt_amount" value='<%=Helper.correctNull((String)hshValues.get("stateamt"))%>' maxlength="10" onKeyPress="allowNumber(this);notAllowSplChar();" size="35"/>
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
  <br>
  <lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
  <br>
  <lapschoice:hiddentag pageid='<%=PageId%>'/> 
  <input type="hidden" name="sel_state1">
<input type="hidden" name="hidstateID" value="">
<input type="hidden" name="hidcityID" value="<%=Helper.correctNull((String)hshValues.get("city_id"))%>">
<input type="hidden" name="txt_oldcitycode" >
<input type ="hidden" name ="hidkeyid" value="set">
</form>
<br>
</body>
</html>


