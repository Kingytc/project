<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>District Master</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>htm/link.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var mode ="load";
var state = "<%=Helper.correctNull((String) hshValues.get("sel_state"))%>";
var district = "<%=Helper.correctNull((String) hshValues.get("district"))%>";
var districtaction = "<%=Helper.correctNull((String) hshValues.get("district_action"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function callonLoad()
{	
   	document.forms[0].txt_district.readOnly=true;	
   	document.forms[0].txt_districtcode.disabled=true;	
	if(state!="")
	{
		document.forms[0].sel_state.value=state;
	}
	
	if(district!="")
	{
		document.forms[0].txt_district.value=district;
	}
	if(districtaction!="")
	{
		document.forms[0].sel_active.value=districtaction;
	}
	document.forms[0].sel_active.disabled=true;
	enableButtons(false,false,true,true,false,false);
	//disablefields(true);
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
		var action=document.forms[0].hidAction.value;
	    document.forms[0].strStatId1.value=document.forms[0].sel_state.value;
	     var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appURL+"action/districtmasterlist.jsp?&strStatId="+document.forms[0].strStatId1.value+"&hidBeanId=staticdata&hidBeanGetMethod=getDistrictMasterList&strfrom=DistrictMaster";
		window.open(url,"",prop);
	}
	
}

function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			  document.forms[0].elements[i].value="";		  
		}		
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
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
	}
}

function doSave()
{		
	if(document.forms[0].sel_state.value=="0")
	{
		ShowAlert(111,'State');
		document.forms[0].sel_state.focus();
		return;
	}
	if(trim(document.forms[0].txt_district.value)=="")
	{
		ShowAlert(121,'District');
		document.forms[0].txt_district.focus();
		return;
	}
	if(trim(document.forms[0].txt_districtcode.value)=="")
	{
		ShowAlert(121,'District Code');
		document.forms[0].txt_districtcode.focus();
		return;
	}
		
	var len1 = document.forms[0].sel_state.length;	
	for(i=0;i<len1;i++)
	{
		 if(document.forms[0].sel_state.options[i].selected==true)
		 {
			 document.forms[0].sel_state1.value = document.forms[0].sel_state.options[i].text; 
			break;
		 }
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanMethod.value="updateDistrictMasterData";
	document.forms[0].hidBeanGetMethod.value="getDistrictMasterList";
	document.forms[0].hidSourceUrl.value="/action/districtmaster.jsp";
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
		document.forms[0].hidAction.value="Cancel";
		document.forms[0].action=appURL+"action/districtmaster.jsp";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanGetMethod.value="getDistrictMasterList";
		document.forms[0].submit();
	}
}

function doNew() 
{
	ClearFields();
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidsno.value="";
   	enableButtons(true, true, false, false, true, true);
   	disablefields(false);   
   	mode = "new";
	document.forms[0].txt_district.disabled = false;
	document.forms[0].txt_districtcode.disabled = false;
	document.forms[0].sel_state.focus();
	document.forms[0].sel_active.disabled=false;
}

function doEdit() 
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
   	document.forms[0].hidAction.value="update"
	enableButtons(true, true, false, false, true, true);
	disablefields(false);
	mode ="edit";
	document.forms[0].txt_district.disabled = false;
	document.forms[0].txt_districtcode.disabled = false;
	document.forms[0].sel_active.disabled=false;
	
}

function enableButtons(bool1, bool2, bool3, bool4, bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool6;
}

function callCalender(fname)
{
	var action  =document.forms[0].hidaction.value;
	if(action =="insert" || action =="update")
	{
		showCal(appURL,fname);
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
		<td class="page_flow">Home -&gt; Setup -&gt; State-City -> District Master </td>
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
						<td><b><select name="sel_state" style="width: 200"
							onClick="">
							<option value="0">--Select--</option>
							<lapschoice:statemaster />
						</select></b></td>
					</tr>
					<tr>
						<td><b>District Code</b></td>
						<td><input type="text" name="txt_districtcode"
							onKeyPress="allowInteger()" maxlength="4"
							value="<%=Helper.correctNull((String) hshValues
									.get("districtcode"))%>">
						</td>
					</tr>
					<tr>
						<td><b>District </b></td>
						<td><input type="text" name="txt_district"
							onKeyPress="notAllowSplChar1(this)" maxlength="20"
							value="<%=Helper.correctNull((String) hshValues.get("district"))%>">
						<b><span onClick="javascript:showSelect()"
							style="cursor: hand"> <img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"> </span></b></td>
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

<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Audit Trail"
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />


<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="sel_state1"> <input type="hidden" name="hidsno"
	value="<%=Helper.correctNull((String) hshValues
									.get("districtsrno"))%>">
<input type="hidden" name="strStatId1" value="">
<input type ="hidden" name ="hidkeyid" value="set">
</form>
</body>
</html>
