<!-- 
author: C.Gokulakrishnan
Bean : SSIAboveTenBean
 -->
<%@include file="../share/directives.jsp"%>
<%

ArrayList vecRecord = new ArrayList();
ArrayList vecValues = new ArrayList();
if(hshValues!=null && hshValues.size()>0)
{
	vecRecord = (ArrayList)hshValues.get("vecRecord");
}
String strcat="";
if(!strCategoryType.equalsIgnoreCase(null))
{
	if(strCategoryType.equalsIgnoreCase("OPS"))
	{
		strcat="Tertiary";
	}
	else 
	{
		strcat="Corporate";
	}		
}%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Vehicle Details -  Tertiary</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>js/share/style.css" type="text/css">
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function disableButtons(newVal,editVal,applyVal,cancelVal,delVal,closeVal)
{
	document.forms[0].cmdnew.disabled=newVal;
	document.forms[0].cmdedit.disabled=editVal;
	document.forms[0].cmdsave.disabled=applyVal;
	document.forms[0].cmdcancel.disabled=cancelVal;
	document.forms[0].cmddelete.disabled=delVal;
	document.forms[0].cmdclose.disabled=closeVal;
}
function onLoad()
{
	disableFields(true);
}
function callOtherDetails()
{
	document.forms[0].hidBeanGetMethod.value="getotherdetailsData1";
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].action=appUrl+"action/ssi_appendix2_otherdetails.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function callFunction(pagename,methodname,param,tabname)
{
	if(methodname=="getGeneralDetails")
	{
		document.forms[0].hidparam.value =param;
	}
	document.forms[0].method="post";	
	document.forms[0].hidTabName.value=tabname;	
	document.forms[0].hidMethod.value=methodname;	
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}

function checkFileDate(obj)
	{
	var pagedate = obj.value;
		
	var currentYear=new Date().getYear();
	if(pagedate.length==4)
	{
	if (parseInt(pagedate)>parseInt(currentYear))
		{
		alert("Year should not be greater than current year");
		document.forms[0].txt_manufact.focus();
		document.forms[0].txt_manufact.value="";
		return;
		}
	}	
	else
	{
		if(pagedate.length!=0)
			{
			alert("Enter Proper Year");
			document.forms[0].txt_manufact.focus();
			document.forms[0].txt_manufact.value="";
			return;
			}
	}
	}

function clearFields()
{
	document.forms[0].sel_veh_virtual.value="0";
	document.forms[0].txt_manufact.value="";
	document.forms[0].txt_cost.value="";
	document.forms[0].txt_est_val.value="";
	document.forms[0].txt_fuel.value="";
	document.forms[0].txt_make.value="";
	document.forms[0].txt_mnth_inc.value="";
	document.forms[0].txt_details.value="";
	document.forms[0].txt_register.value="";
	document.forms[0].txt_persons.value="";
	document.forms[0].txt_load.value="";
	document.forms[0].sel_driven.value="0";
	document.forms[0].sel_permit.value="0";
	document.forms[0].txt_veh_operate.value="";
	document.forms[0].txt_dealer_info.value="";	
}


function doNew()
{
	clearFields();
	disableFields(false);
	disableButtons(true,true,false,false,true,true);
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidVehicleId.value="";
	document.forms[0].hidAction.value="insert";
}

function doEdit()
{
	document.forms[0].hidAction.value="update";
	document.forms[0].hideditflag.value="Y";
	disableButtons(true,true,false,false,true,true);
	disableFields(false);
}

function doSave()
{
	if(document.forms[0].sel_veh_type.value=='0' || document.forms[0].sel_veh_type.value=='')
	{
		alert("Please choose 'Type of Vehicle'");
		return false;
	}
	if(document.forms[0].sel_veh_virtual.value=='0'||document.forms[0].sel_veh_virtual.value=='')
	{
		alert("Please choose 'Vituality of Vehicle'");
		return false;
	}	
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].hidBeanGetMethod.value="getAllVehicleDetails";
	document.forms[0].hidBeanMethod.value="updateVehicleDetails";
	document.forms[0].hidSourceUrl.value="/action/ops_vehicledetails.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidVehicleId.value="";
		document.forms[0].hidBeanGetMethod.value="getAllVehicleDetails";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].hidSourceUrl.value="/action/ops_vehicledetails.jsp";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
}

function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].sel_veh_type.disabled=false;
			document.forms[0].sel_veh_virtual.disabled=false;
			document.forms[0].sel_driven.disabled=false;
			document.forms[0].sel_permit.disabled=false;
			
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanId.value="comssiaboveten";
			document.forms[0].hidBeanGetMethod.value="getAllVehicleDetails";
			document.forms[0].hidBeanMethod.value="updateVehicleDetails";
			document.forms[0].hidSourceUrl.value="/action/ops_vehicledetails.jsp";
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert(158);
	}
}

function doClose()
{
	if(ConfirmMsg(100))
	{ 
		document.forms[0].action=appUrl+"action/agrpage.jsp";
		document.forms[0].submit();
	}
}

function vehicleType(val)
{
	if(val=="1")
	{
		document.all["month_inc_exist"].style.visibility="visible";
		document.all["month_inc_exist"].style.position="relative";
		document.all["month_inc_prop"].style.visibility="hidden";
		document.all["month_inc_prop"].style.position="absolute";
		document.all["details"].style.visibility="visible";
		document.all["details"].style.position="relative";
		document.all["dealer"].style.visibility="hidden";
		document.all["dealer"].style.position="absolute";
		document.all["dealer_txt"].style.visibility="hidden";
		document.all["dealer_txt"].style.position="absolute";
	}else if(val=="2")
	{
		document.all["month_inc_exist"].style.visibility="hidden";
		document.all["month_inc_exist"].style.position="absolute";
		document.all["month_inc_prop"].style.visibility="visible";
		document.all["month_inc_prop"].style.position="relative";
		document.all["details"].style.visibility="hidden";
		document.all["details"].style.position="absolute";
		document.all["dealer"].style.visibility="visible";
		document.all["dealer"].style.position="relative";
		document.all["dealer_txt"].style.visibility="visible";
		document.all["dealer_txt"].style.position="relative";
		document.forms[0].txt_details.value="";
		document.forms[0].txt_register.value="";
	}
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	  
		else if(document.forms[0].elements[i].type=='text') 
		{
			document.forms[0].elements[i].readOnly=val;
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;
		}
	}
}

function  selectValues(appno,id,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16,val17)
{
	document.forms[0].hidVehicleId.value=id;
	document.forms[0].sel_veh_type.value=val2;
	document.forms[0].sel_veh_virtual.value=val3;
	document.forms[0].txt_manufact.value=val4;
	document.forms[0].txt_cost.value=val5;
	document.forms[0].txt_est_val.value=val6;
	document.forms[0].txt_fuel.value=val7;
	document.forms[0].txt_make.value=val8;
	document.forms[0].txt_mnth_inc.value=val9;
	vehicleType(val3);
	if(val3!='2')
	{
		document.forms[0].txt_details.value=val10;
		document.forms[0].txt_register.value=val11;
	}
	document.forms[0].txt_persons.value=val12;
	document.forms[0].txt_load.value=val13;
	document.forms[0].sel_driven.value=val14;
	document.forms[0].sel_permit.value=val15;
	document.forms[0].txt_veh_operate.value=val16;
	document.forms[0].txt_dealer_info.value=val17;
	if(document.forms[0].btnenable.value=="Y")
	{
		disableButtons(true,false,true,false,false,true);
	}
}

function callopeviability()
{
	var varappno = document.forms[0].appno.value;
	var varbtnenable = document.forms[0].btnenable.value;
	var prop = "scrollbars=yes,width=575,height=550,menubar=yes";
	var title = "";
	var xpos = 4;
	var ypos = 4;
	prop = prop + ",left="+xpos+",top="+ypos;
	var url=appURL+"action/operationalviability.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getOpeViability&appno="+varappno+"&btnenable="+varbtnenable;
	window.open(url,title,prop);
}

function callValuationEntry()
{
	document.forms[0].hidBeanGetMethod.value="getValuerEntryData";
	document.forms[0].hidBeanId.value="perpropertydetails";
	document.forms[0].action=appUrl+"action/ops_valuationentry.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
</script>
</head>
<body onload="onLoad()">
<form name="vehdetails" method="post" action="<%=ApplicationParams.getAppUrl()%>controllerservlet" class="normal">

  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true">
        <jsp:param name="pageid" value="12" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
			  <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
     <tr> 
            <td class="page_flow">Home -&gt;<%=strcat %> -&gt;  Application -&gt; Proposed / Offered Asset -&gt;Vehicle Details 
 </td>
          </tr>
	</table>
  
 <span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/> 
<lapschoice:ssiassestdetails tabid="5"/>  
<table border="0" width="100%" cellspacing="0" cellpadding="0" class="outertable">
 <tr>
  <td>
   <table border="1" width="100%" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
     <td>
      <table border="0"  width="100%" cellspacing="0" cellpadding="3" class="outertable">
       <tr>
        <td width="25%">Type of Vehicle</td>
        <td width="25%"><select name="sel_veh_type">
        	<option value="0">-- select --</option>
        	<option value="1">New Vehicle</option>
        	<option value="2">Second Hand Vehicle</option>
        	</select>
        </td>
        <td width="25%">Virtuality of Vehicle</td>
        <td width="25%"><select name="sel_veh_virtual" onchange="vehicleType(this.value)">
        	<option value="0">-- select --</option>
        	<option value="1">Existing</option>
        	<option value="2">Proposed</option>
        	</select>
        </td>
       </tr>
       <tr>
        <td>Year of Manufacture</td>
        <td><input type="text" name="txt_manufact" maxlength="4" onkeypress="allowNumber(document.forms[0].txt_manufact)"
		onBlur="checkFileDate(document.forms[0].txt_manufact)"></td>
        <td>Cost Price</td>
        <td><input type="text" name="txt_cost" maxlength="20" onkeypress="allowNumber(document.forms[0].txt_cost)"></td>
       </tr>
       <tr>
        <td>Present Estimated Value</td>
        <td><input type="text" name="txt_est_val" maxlength="20" onkeypress="allowNumber(document.forms[0].txt_est_val)"></td>
        <td>Fuel Used</td>
        <td><input type="text" name="txt_fuel" maxlength="40"></td>
       </tr>
       <tr>
        <td>Make</td>
        <td><input type="text" name="txt_make" maxlength="40"></td>
        <td id="month_inc_exist" style="visibility:visible;position:relative">Average Monthly Income Derived</td>
                  <td id="month_inc_prop" style="visibility:hidden;position:absolute">Anticipated 
                    Income Monthly</td>
        <td><input type="text" name="txt_mnth_inc" maxlength="20" onkeypress="allowNumber(document.forms[0].txt_mnth_inc)"></td>
       </tr>
       <tr id="details">
        <td>Details of Loan</td>
        <td><textarea name="txt_details" rows="3" cols="30" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea></td>
        <td>Registration and Chassis no:</td>
        <td><textarea name="txt_register" rows="3" cols="30" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea></td>
       </tr>
       <tr>
        <td colspan="4">
         <table border="0" width="100%" cellspacing="0" cellpadding="3" class="outertable linebor">
          <tr class="dataheader">
           <td colspan="4"><b>Carrying Capacity of the Vehicle</b></td>
          </tr>
          <tr class="datagrid">
           <td width="25%">Persons</td>
           <td width="25%"><input type="text" name="txt_persons" maxlength="20"  onkeypress="allowNumber(document.forms[0].txt_persons)"></td>
           <td width="25%">Load&nbsp;(in kgs)</td>
           <td width="25%"><input type="text" name="txt_load" maxlength="20" onkeypress="allowNumber(document.forms[0].txt_load)"></td>
          </tr>
         </table>
        </td>
       </tr>
       <tr>
        <td>Whether the vehicle to be driven by the applicant</td>
        <td><select name="sel_driven">
        	<option value="0">-- select --</option>
        	<option value="1">Yes</option>
        	<option value="2">No</option>
        	</select></td>
        <td>Necessary permit/License obtained</td>
        <td><select name="sel_permit">
        	<option value="0">-- select--</option>
        	<option value="1">Yes</option>
        	<option value="2">No</option>
        	</select></td>
       </tr>
       <tr>
        <td>Route/Area where vehicle will operate</td>
        <td><textarea name="txt_veh_operate" cols="30" rows="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea></td>
                  <td id="dealer" style="visibility:hidden;position:absolute">Dealer's 
                    Name and Address</td>
                  <td id="dealer_txt" style="visibility:hidden;position:absolute"> 
                    <textarea name="txt_dealer_info" cols="30" rows="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea>
                  </td>
       </tr>
      </table>
     </td>
    </tr>
   </table>
<br>
 <lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
 <br>
  <table border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
          <tr valign="top"> 
            <td id="opervia">
					<input type="button" name="operationalviability" value="Operational Viability" onClick="callopeviability()" class="buttonStyle">
					</td> 
          </tr>
        </table>
      </td>
    </tr>
  </table>
     <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
      <tr>
       <td valign="top">
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
         <tr align="center" class="dataheader">
          <td width="3%"></td>
          <td>Type</td>
          <td>Virtuality</td>
          <td>Make</td>
          <td>Year of Manufacture</td>
         </tr>
<%
if(vecRecord!=null && vecRecord.size()>0)
{
	String strType= "";
	String strVirtual = "";
	for(int i=0;i<vecRecord.size();i++)
	{
		vecValues = new ArrayList();
		vecValues = (ArrayList)vecRecord.get(i);
		if(Helper.correctNull((String)vecValues.get(2)).trim().equalsIgnoreCase("1"))
			strType = "New";
		else if(Helper.correctNull((String)vecValues.get(2)).trim().equalsIgnoreCase("2"))
			strType = "Second Hand";
		if(Helper.correctNull((String)vecValues.get(3)).trim().equalsIgnoreCase("1"))
			strVirtual = "Existing";
		else if(Helper.correctNull((String)vecValues.get(3)).trim().equalsIgnoreCase("2"))
			strVirtual = "Proposed";%>         
         <tr class="datagrid">
          <td width="3%">&nbsp;<input type="radio" style="border:none" name="radiobutton" value="radiobutton" 
                      onClick="selectValues('<%=Helper.correctNull((String)vecValues.get(0))%>','<%=Helper.correctNull((String)vecValues.get(1))%>',
                      '<%=Helper.correctNull((String)vecValues.get(2))%>','<%=Helper.correctNull((String)vecValues.get(3))%>','<%=Helper.correctNull((String)vecValues.get(4))%>',
                      '<%=Helper.correctNull((String)vecValues.get(5))%>','<%=Helper.correctNull((String)vecValues.get(6))%>','<%=Helper.correctNull((String)vecValues.get(7))%>','<%=Helper.correctNull((String)vecValues.get(8))%>',
                      '<%=Helper.correctNull((String)vecValues.get(9))%>','<%=Helper.correctNull((String)vecValues.get(10))%>','<%=Helper.correctNull((String)vecValues.get(11))%>','<%=Helper.correctNull((String)vecValues.get(12))%>',
                      '<%=Helper.correctNull((String)vecValues.get(13))%>','<%=Helper.correctNull((String)vecValues.get(14))%>','<%=Helper.correctNull((String)vecValues.get(15))%>','<%=Helper.replaceForJavaScriptString((String)vecValues.get(16))%>',
                      '<%=Helper.replaceForJavaScriptString((String)vecValues.get(17))%>')"></td>
          <td>&nbsp;<%=strType%></td>
          <td>&nbsp;<%=strVirtual%></td>
          <td>&nbsp;<%=Helper.correctNull((String)vecValues.get(8))%></td>
          <td>&nbsp;<%=Helper.correctNull((String)vecValues.get(4))%></td>
         </tr>
<%}}for(int k=0;k<6;k++){%>
		<tr class="datagrid">
		 <td width="3%">&nbsp;</td>
		 <td>&nbsp;</td>
		 <td>&nbsp;</td>
		 <td>&nbsp;</td>
		 <td>&nbsp;</td>
		</tr>
<%}%>		
        </table>
       </td>
      </tr>
     </table>
    </td>
   </tr>
  </table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidVehicleId">
 <input type="hidden" name="otherGenTable" value="">
</form>
</body>
</html>