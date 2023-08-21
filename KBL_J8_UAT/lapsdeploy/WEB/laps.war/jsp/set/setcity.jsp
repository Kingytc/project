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

function onloading()
{	 
    var exist="<%=Helper.correctNull((String)request.getParameter("exist"))%>";
    if(exist=="e")
    {
       	disableFields(true);
    	disableCommandButtons("disableall");
    }
    else
    {
    	disableFields(true);
		disableCommandButtons("load");
    }
	document.forms[0].hidAction.value ="";
	document.forms[0].sel_state.disabled =false;
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
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	if(val=="radioselect")
	{	 
		document.forms[0].cmdnew.disabled =false;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}	  
	if(val=="disableall")
	{
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
}  
 
function clearfields()
{
document.forms[0].txt_cityname.value="";
document.forms[0].txt_citycode.value="";
document.forms[0].cmdnew.disabled=false;
}
function doSave()
{
	if(document.forms[0].sel_state.value=="0")
  	{
  	ShowAlert('111',"State Name");
  	return false;
	}
 	if(trim(document.forms[0].txt_cityname.value) == "")
 	{
 		ShowAlert(121,'City Name');
 		document.forms[0].txt_cityname.focus();
 		return;
 	}
 	if(trim(document.forms[0].txt_citycode.value)=="")
 	{
 		ShowAlert(121,'City Code');
 		document.forms[0].txt_citycode.focus();
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
	document.forms[0].hidBeanGetMethod.value="updateCityDetails";	
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].action=appUrl+"action/setcity.jsp";
	document.forms[0].submit();
 }

  function doEdit()
  { 	
 
	disableFields(false);
	document.forms[0].hidAction.value ="Update";
	disableCommandButtons("edit");
	document.forms[0].txt_citycode.readOnly =true;
	
 }

  function doNew()
  {
  if(document.forms[0].sel_state.value=="0")
  {
  	ShowAlert('111',"State Name");
  	return false;
  }
	disableFields(true);
		
	
	document.forms[0].hidAction.value ="insert";
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='radio')
	 	{
			document.forms[0].elements[i].checked=false;
		}	  
	}
 
  clearfields();
  disableCommandButtons("edit");	
   }

function doCancel()
{
	if(ConfirmMsg(102))
	{
	clearfields();
	disableCommandButtons("load");
	document.forms[0].sel_state.disabled =false;
	}
}
  
function doDelete()
{
if( ConfirmMsg(101))
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
	document.forms[0].hidAction.value ="Delete";
	
	document.forms[0].hidBeanGetMethod.value="updateCityDetails";
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].hidSourceUrl.value="action/setcity.jsp";	
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
 
 function doCityWindow()
 {
 	
	if(document.forms[0].sel_state.value=="" || document.forms[0].sel_state.value=="0")
	{
		ShowAlert('111',"State Name");
		return false;
	}	
	else
	{ 
	if(document.forms[0].cmdnew.disabled==false)
 	{
	var purl = appUrl+"action/citydetails.jsp?hidBeanGetMethod=getCityDetails&hidBeanId=mastapplicant&strstate="+document.forms[0].sel_state.value;
	var prop = 'scrollbars=no,width=380,height=350';	
	var xpos = (screen.width - 450) / 2;
	var ypos = (screen.height - 450) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);
	}
	return false;
	}
 
 }
 
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading()" >
<form name="workfrm" method="post" class="normal">
	    <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0" >          
          <tr>
            <td class="page_flow">Home -&gt; Setup -&gt; City</td>
          </tr>
        </table><br> 
  <br>
  <table class="outertable border1 tableBg" width="47%" border="0" cellspacing="0" cellpadding="15" align="center" >
    <tr> 
      <td valign="top"> 
       
              <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                <tr> 
                  <td> 
                    <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr> 
                        <td> 
                          <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr> 
                              <td> 
                                <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tr> 
                                    <td> 
                                      <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5">
                                        <tr class="dataheader" align="center"> 
                                          <td  colspan="2"><b>City</b></td>
                                        </tr>
                                        <tr> 
                                          <td colspan="2"> 
                                            <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="10">
                                              <tr> 
                                                <td>State Name</td>
                                                <td>
												<select name="sel_state" style="width:200" onChange="clearfields()">
            									<option value="0">--Select--</option>
           										  <lapschoice:statemaster1 /> 
         										 </select>
												 </td>
                                              </tr>
                                              <tr>
                                                <td>City Name </td>
                                                <td>
                                                  <input type="text" name="txt_cityname" value="" maxlength="30" onKeyPress="notAllowSplChar();allowAlphabetsForName();" size="35"><b><span onClick="JavaScript:doCityWindow()" style="cursor:hand"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
												 border="0"></span></b>
                                                </td>
                                              </tr>
                                              <tr> 
                                                <td>City Code  </td>
                                                <td>
                                                  <input type="text" name="txt_citycode" value="" maxlength="5" onKeyPress="notAllowSplChar();notAllowSplChar();" size="35">
                                               </td>
                                              </tr>
                                              <tr>
                                              <td>Active</td>
                                              <td>
                                              <select name="sel_active">
                                              <option value="E" selected="selected">Enable</option>
                                      		  <option value="D">Disable</option>
                                              </select>
                                              </td>
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
   <lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="sel_state1">
<input type="hidden" name="hidstateID" value="">
<input type="hidden" name="hidcityID" value="<%=Helper.correctNull((String)hshValues.get("city_id"))%>">
<input type="hidden" name="txt_oldcitycode" >
<input type ="hidden" name ="hidkeyid" value="set">
</form>
</body>
</html>


