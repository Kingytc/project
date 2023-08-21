<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%@page import="com.sai.fw.management.utils.FwHelper"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	ArrayList arrData = new ArrayList();
	ArrayList arrRow = new ArrayList();
	int vecsize = 0;
	int vecsize1 = 0;
	if (hshValues != null) {
		arrData = (ArrayList) hshValues.get("arrData");
	}
	String strapptype = "";
	String apptype = "";
%>
<html>
<head>
<style>
.divCellContainer {
	width: 100%;
	height: 100px;
	overflow: auto;
}
</style>
<title>SOF HORTI/PLANT</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var mode ="load";
var state = "<%=Helper.correctNull((String) hshValues.get("sel_state"))%>";
var district = "<%=Helper.correctNull((String) hshValues
									.get("txt_district"))%>";
var txt_plant = "<%=Helper.correctNull((String) hshValues.get("txt_plant"))%>";
var txt_todate="<%=Helper.correctNull((String) hshValues.get("txt_todate"))%>";
var selsno="<%=Helper.correctNull((String) hshValues
									.get("selsno"))%>";


function doCallOwnHelp(strHelpID)
{
	var hlpvar = appUrl+"action/HelpFrame.jsp?strHelpid="+strHelpID;
  	var title = "FinanceMaster";
  	var prop = "scrollbars=yes,width=600,height=450";	
  	prop = prop + ",left=50,top=150";
  	window.open(hlpvar,title,prop);
}

function callDistrictmaster()
{
       document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanGetMethod.value=" getDistrictMasterList";		
		document.forms[0].action=appURL+"action/districtmaster.jsp";	
		document.forms[0].submit();
}

function selectValues(val1,val3, val4, val5)
{
	document.forms[0].selsno.value = val1; //serial no
    document.forms[0].txt_plant.value = val3;   
    document.forms[0].txt_maxnoofunits.value = val4;  
	document.forms[0].txt_todate.value = val5;
	disableNewButtons(false,false,true,true,false,false);
	
}



function callonLoad()
{	
	disableNewButtons(false,false,true,true,false);	
	disableFields(true);
}
function disableFields(one)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].disabled=one;
		}	  
	
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

function doSave()
{		
	
	if(document.forms[0].txt_plant.value=="")
	{
		alert("Enter Plant Name");
		document.forms[0].txt_plant.focus();
		return false;
	}
	if(document.forms[0].txt_maxnoofunits.value=="")
	{
		alert("Enter Maximum No of units to be permitted");
		document.forms[0].txt_maxnoofunits.focus();
		return false;
	}
	if(document.forms[0].txt_todate.value=="")
	{
		alert("Enter Upto date");
		document.forms[0].txt_todate.focus();
		return false;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanMethod.value="updateHorticultureFinanceMasterData";
	document.forms[0].hidBeanGetMethod.value="getHorticultureFinanceMasterData";
	document.forms[0].hidSourceUrl.value="/action/agrscaleoffinancehoriculture.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
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

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidAction.value="Cancel";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanGetMethod.value="getHorticultureFinanceMasterData";
		document.forms[0].hidSourceUrl.value="/action/agrscaleoffinancehoriculture.jsp";		
		document.forms[0].submit();
	}
}

function doNew() 
{
	document.forms[0].hidAction.value="insert";
	disableNewButtons(true, true, false, false, true, true);
	disableFields(false);   
}

function doEdit() 
{
	if(document.forms[0].txt_plant.value=="")
	{
		alert("Select a record");
		return;
	}
	else
	{
			 for(var i=0;i<document.forms[0].length;i++){
			           if(document.forms[0].elements[i].type=="radio")
			            {
				          document.forms[0].elements[i].disabled=true;		  
			            }
				}
	}
   	document.forms[0].hidAction.value="update"
   	disableNewButtons(true, true, false, false, true, true);
   	disableFields(false);
	
}
 function doDelete() 
   {
   	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updateHorticultureFinanceMasterData";
		document.forms[0].hidBeanGetMethod.value="getHorticultureFinanceMasterData";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidSourceUrl.value="action/agrscaleoffinancehoriculture.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}
}  
 function disableNewButtons(bool1, bool2, bool3, bool4, bool5, bool6, bool7)
 {
 	document.forms[0].cmdnew.disabled=bool1;
 	document.forms[0].cmdedit.disabled=bool2;
 	document.forms[0].cmdsave.disabled=bool3;
 	document.forms[0].cmdcancel.disabled=bool4;
 	document.forms[0].cmddelete.disabled=bool5;
 	document.forms[0].cmdclose.disabled=bool6;
 }

function callCalender(fname)
{
	var action  =document.forms[0].hidAction.value;
	if(action =="insert" || action =="update")
	{
		showCal(appURL,fname);
	}
}






</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
DIV.cellContainer {
	width: 100%;
	height: 250;
	overflow: auto;
}
</style>

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
</head>
<body onload="callonLoad()">
<form name="frmgoldrate" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td class="page_flow">Home -&gt; Master -&gt; Unit Cost Horti / Plantation</td>
</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
<tr>
	<td>
		<jsp:include page="../set/mastertab.jsp" flush="true">
		<jsp:param name="tabid" value="12" />
		</jsp:include>
	</td>
</tr>
</table>
<br>
<br>
<table width="80%" border="0" cellpadding="0" cellspacing="0"
	align="center" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			
			<tr>
				<td width="8%" nowrap>Plant
				Name<span class="mantatory">*</span></td>
				<td width="19%"><b> <input type="text" onkeypress="allowAlpaNumeric();"
					name="txt_plant" tabindex="4" maxlength="100"> </b></td>
				<td width="17%" nowrap>Maximum
				no. of units to be permitted per hectare<span class="mantatory">*</span></td>
				<td width="14%"><b> <input type="text"
					name="txt_maxnoofunits" value="" tabindex="9" maxlength="10"
					onKeyPress="allowNumber(this)" style="text-align: right"> </b></td>
				<TD WIDTH="17%" nowrap>Upto
				date <span class="mantatory">*</span></TD>
				<TD WIDTH="14%">
				<table width="40%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td><input type="text" size="11" name="txt_todate" maxlength="10"
							tabindex="10" onBlur="checkDate(this);"></td>
						<td><a href="#" onClick="callCalender('txt_todate')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif" border="0"></a></td>
					</tr>
				</table>
				</TD>



			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew
	btnnames="New_Edit_Save_Delete_Cancel_Audit Trail"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<br>
<br>
<table width="80%" border="0" cellspacing="0" cellpadding="1"
	bordercolordark="#9EC0F5" bordercolorlight="#FFFFFF" align="center">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="1" cellpadding="5">
			<tr class="dataheader">
				<td width="10%" class="dataHeadColor">&nbsp;</td>
				<td width="30%" align="center" class="dataHeadColor">Plant Name</td>
				<td width="30%" align="center" class="dataHeadColor">Max No Of
				Units Name</td>
				<td width="30%" align="center" class="dataHeadColor">Upto date</td>
			</tr>
		</table>


		<table width="98%" border="0" cellspacing="1" cellpadding="3" >
			<%
				if (arrData != null) {
			%>
			<%
				vecsize = arrData.size();
				}
				String strSno = "";
				for (int i = 0; i < vecsize; i++) {
					arrRow = (ArrayList) arrData.get(i);
					if (arrRow != null) {
						strSno = Helper.correctNull((String) arrRow.get(0));
			%>
			<tr align="center" class="datagrid">
				<td width="10%"><input type="radio" name="sno"
					style="border-style: none"
					onClick="selectValues(
											'<%=Helper.correctNull((String) arrRow.get(0))%>', 
											'<%=Helper.correctNull((String) arrRow.get(1))%>',
											'<%=Helper.correctNull((String) arrRow.get(2))%>',
											'<%=Helper.correctNull((String) arrRow.get(3))%>')">

				<input type="hidden" name="hid" value="<%=strSno%>"></td>
				<td width="17%" align="left" valign="middle"><%=Helper.correctNull((String) arrRow.get(1))%></td>
				<td width="30%" align="right"><%=Helper.correctNull((String) arrRow.get(2))%></td>
				<td width="30%" align="center" nowrap><%=Helper.correctNull((String) arrRow.get(3))%></td>

			</tr>
			<%
				}
				}
			%>
			<%
				for (int i = 0; i <= 5; i++) {
			%>
			<tr class="dataGridColor">
				<td width="10%">&nbsp;</td>
				<td width="30%" align="center" valign="middle">&nbsp;</td>
				<td width="30%">&nbsp;</td>
				<td width="30%" align="right">&nbsp;</td>
			</tr>
			<%
				}
			%>
		</table>
		</td>
	</tr>
</table>
<br>
<input type="hidden" name="hidorg_code"
	value="<%=Helper.correctNull((String) hshValues.get("ORG_CODE"))%>">
<input type="hidden" name="hidsno" value=""> <input
	type="hidden" name="hidAction"> <input type="hidden"
	name="hidBeanMethod" value=""> <input type="hidden"
	name="hidBeanId"> <input type="hidden" name="hidSourceUrl">
<input type="hidden" name="hidBeanGetMethod"> <input
	type="hidden" name="hidcat_parent" value="0"> <input
	type="hidden" name="strStatId1" value=""> <input type="hidden"
	name="selsno" value=""></form>
</body>
</html>

