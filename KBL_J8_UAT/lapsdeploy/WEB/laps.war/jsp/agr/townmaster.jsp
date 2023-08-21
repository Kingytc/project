<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Town Master</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>htm/link.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>

<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function callonLoad()
{	   	
	enableButtons(false,true,true,true);
	disablefields(true);
	document.forms[0].sel_state.disabled=false;
	
	
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
				
	}
}

function doSave()
{	
	
	if(trim(document.forms[0].txt_town.value)=="")
	{
		ShowAlert(121,'Town');
		document.forms[0].txt_town.focus();
		return;
	}
	if(trim(document.forms[0].txt_towncode.value)=="")
	{
		ShowAlert(121,'Town Code');
		document.forms[0].txt_towncode.focus();
		return;
	}
	disablefields(false); 
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanMethod.value="updateTownMasterData";
	document.forms[0].hidBeanGetMethod.value="getTownMasterList";
	document.forms[0].hidSourceUrl.value="/action/townmaster.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/setstatecity.jsp";
		document.forms[0].submit();
	}
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].action=appURL+"action/townmaster.jsp";
		document.forms[0].submit();
	}
}

function doNew() 
{
	if(document.forms[0].sel_state.value=="0")
	{
		ShowAlert(111,'State');
		document.forms[0].sel_state.focus();
		return;
	}
	if(trim(document.forms[0].txt_district.value)=="")
	{
		ShowAlert(111,'District');
		document.forms[0].txt_district.focus();
		return;
	}
	document.forms[0].hidAction.value="insert";
	enableButtons(true, true, false, false);
   	disablefields(false);   
   	document.forms[0].sel_state.disabled=true;
    document.forms[0].txt_district.disabled=true;
	
}

function doEdit() 
{
	document.forms[0].hidAction.value="update";
	document.forms[0].txt_town.readOnly=false;
    document.forms[0].sel_active.disabled=false;
    document.forms[0].sel_state.disabled=true;
    document.forms[0].txt_district.disabled=true;
	enableButtons(true, true, false, false);
}

function enableButtons(bool1, bool2, bool3, bool4)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
}

function showSelect()
{
	if(document.forms[0].sel_state.value=="0")
   { 
    ShowAlert(111,'State');
    document.forms[0].sel_state.focus();
    return;
   }
  else
   {
       showDistrict();
   }
   
}

function showDistrict()
{
	if(document.forms[0].cmdsave.disabled==true)
	{
		document.forms[0].strStatId1.value=document.forms[0].sel_state.value;
	    document.all.ifrm.src=appURL+"action/iframedistrictmasterlist.jsp?&strStatId="+document.forms[0].strStatId1.value+"&hidBeanId=staticdata&hidBeanGetMethod=getDistrictMasterList";
	    //document.forms[0].sel_state.disabled=true;
	    document.forms[0].txt_district.disabled=false;
	}
}

function showtown()
{
  if(document.forms[0].sel_state.value=="0")
	  { 
	    ShowAlert(111,'State');
	    document.forms[0].sel_state.focus();
	    return;
	  }
  if(document.forms[0].txt_district.value=="")
	  { 
	    ShowAlert(111,'District');
	    document.forms[0].txt_district.focus();
	    return;
	  }
  
	
	/*if(document.forms[0].cmdedit.disabled==false)
	{
   		alert("Please enable the Edit mode");
	} 
	else*/
	{
	       showtowndesc();
	}
}

function showtowndesc()
{
	if(document.forms[0].cmdsave.disabled==true)
	{
		if(document.forms[0].sel_state.value=="" || document.forms[0].sel_state.value=="0")
		{
			ShowAlert('111',"State Name");
			return false;
		}	
		if(document.forms[0].txt_district.value=="" || document.forms[0].txt_district.value=="0")
		{
			ShowAlert('111',"District Name");
			return false;
		}	
		//if(document.forms[0].hidAction.value=="update")
		{
			
			document.forms[0].strdistId1.value=document.forms[0].txt_district.value;
			var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
		    var url=appURL+"action/townmasterlist.jsp?&strdistId="+document.forms[0].strdistId1.value+"&hidBeanId=staticdata&hidBeanGetMethod=getTownMasterList&mastername=masterpage";
			window.open(url,"",prop);
			disablefields(true); 
		}	
	}
}


</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
</head>
<body onload="callonLoad()">
<form name="appform" method="post" action="" class="normal">
<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; State-City -> Town Master </td>
	</tr>
</table>
<br>
<br>
		<table class="outertable border1 tableBg" border="0" cellspacing="0" cellpadding="3"
			width="35%" align="center">
			<tr align="center">
				<td><br>
				<table class="outertable" width="100%" border="0" cellspacing="0"
					cellpadding="3" align="center">
					<tr>
						<td><b>State </b></td>
						<td><b><select name="sel_state" style="width: 200" onchange="showSelect()">
							<option value="0">--Select--</option>
							<lapschoice:statemaster />
						</select></b></td>
					</tr>
					<tr>
						<td><b>District </b></td>
						<td><select name="txt_district" tabindex="2" style="width: 90%">
		      					<option value="0" selected="selected" >--Select--</option>
							</select>
						</td>
					</tr>
					<tr>
						<td><b>Town Description</b></td>
						<td><input type="text" name="txt_town" onKeyPress="allowAlphabetsForName()" onKeyPress="notAllowSplChar1(this)" maxlength="20" 
							value="<%=Helper.correctNull((String) hshValues.get("txt_town"))%>">
							<b><span onClick="javascript:showtown()" style="cursor: hand"> 
								<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"> 
								</span>
							</b>
						</td>
					</tr>
					
					<tr>
						<td><b>Town Code</b></td>
						<td><input type="text" name="txt_towncode" onKeyPress="allowInteger()" maxlength="6"
							value="<%=Helper.correctNull((String) hshValues.get("txt_towncode"))%>">
							
						</td>
					</tr>
					
					 <tr>
                      	<td>Active</td>
                        <td><select name="sel_active">
                            <option value="E" selected="selected">Enable</option>
                            <option value="D">Disable</option>
                            </select>
                        </td>
                    </tr>
					
				</table>
				<br>
				<br>
				</td>
			</tr>

		</table>
<br>
<iframe height="0" width="0" id="ifrm" frameborder="0" style="border:0" ></iframe>
<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel"
	btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />


<lapschoice:hiddentag pageid='<%=PageId%>' /> 
<input type="hidden" name="sel_state1"> 
<input type="hidden" name="hidsno" value="<%=Helper.correctNull((String) hshValues.get("districtsrno"))%>">
<input type="hidden" name="strStatId1" value="">
<input type="hidden" name="strdistId1" value="">

<input type="hidden" name ="hidtownid" value="">
</form>
</body>
</html>
