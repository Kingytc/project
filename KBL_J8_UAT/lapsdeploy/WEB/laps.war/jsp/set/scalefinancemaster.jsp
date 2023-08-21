<%@ include file="../share/directives.jsp"%>
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
	String strSOFType=Helper.correctInt((String) hshValues.get("strSOFType"));
%>
<html>
<head>
<title>Finance Details</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
//var mode ="load";
var state = "<%=Helper.correctNull((String) hshValues.get("sel_state"))%>";
var district = "<%=Helper.correctNull((String) hshValues
									.get("txt_district"))%>";
var txt_crop = "<%=Helper.correctNull((String) hshValues.get("txt_crop"))%>";
var txt_finance= "<%=Helper.correctNull((String) hshValues
									.get("txt_finance"))%>";
var txt_fromdate="<%=Helper.correctNull((String) hshValues
									.get("txt_fromdate"))%>";
var txt_todate="<%=Helper.correctNull((String) hshValues.get("txt_todate"))%>";
var selsno="<%=Helper.correctNull((String) hshValues
									.get("selsno"))%>";
var hidslno="<%=Helper.correctNull((String) hshValues.get("hidslno"))%>";
var varSOFType="<%=Helper.correctNull((String) hshValues.get("strSOFType"))%>";

function selectValues(val1, val2, val3, val4, val5, val6, val7, val8, val9, val10, val11)
{
	document.forms[0].sel_state.value = val1;
    if(val1!="")
	{
		document.forms[0].sel_state.value=val1;
	}
    document.forms[0].strStatId1.value = val1;    
    document.forms[0].hidsno.value = val2;	
    document.forms[0].txt_crop.value = val3;  
    //document.forms[0].sel_scale.value = val4; 
	document.forms[0].selsno.value = val4;
	document.forms[0].txt_district.value = val5;
	document.forms[0].type.value = val6;
    document.forms[0].txt_finance.value = val7;
  //  document.forms[0].txt_rangefrom.value = val11;   
 //   document.forms[0].txt_rangeto.value = val12;  
    document.forms[0].txt_fromdate.value = val8;
	document.forms[0].txt_todate.value = val9;
	document.forms[0].txt_noofplants.value = val10;
	document.forms[0].txt_scaleoffinperplant.value = val11;

	enableButtons(true,false,true,true,false,false);
}
function showDistrict()
{
	if(document.forms[0].sel_state.value=="s")
	{
		alert('Select the State');
		document.forms[0].sel_state.focus();
		return;
	}
	if(document.forms[0].sel_state.disabled==false) {
		var action=document.forms[0].hidAction.value;
	    document.forms[0].strStatId1.value=document.forms[0].sel_state.value;
	    var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appURL+"action/districtmasterlist.jsp?&strStatId="+document.forms[0].strStatId1.value+"&hidBeanId=staticdata&hidBeanGetMethod=getDistrictMasterList&strfrom=DistrictMaster&pagename=scalefinancemaster";
		window.open(url,"",prop);
		enableButtons(false,false,true,true,false,false);
	}
}

function callonLoad()
{	
	enableButtons(true,true,true,true,true,false);	
	disableFields(true);
	document.forms[0].sel_type.disabled=false;
	document.forms[0].txt_district.value=district;
	if(state=='') {
		document.forms[0].sel_state.value='s';
	}
	else {
		document.forms[0].sel_state.value=state;
		enableButtons(false,true,true,true,true,false);
	}
	if(hidslno=='')
		document.all.gridvalues.style.display='none';
	else
		document.all.gridvalues.style.display='block';

	document.forms[0].sel_type.value=varSOFType;

	if(document.forms[0].sel_type.value=="130")
	{
		document.all.idcrop1.style.display="table-cell";
		document.all.idcrop2.style.display="table-cell";
		document.all.idcrop3.style.display="table-cell";
		document.all.idcrop4.innerText="Crop Name";
		document.all.idcrop6.style.display="table-cell";
		document.all.idcrop7.style.display="table-cell";
		document.all.idcrop8.style.display="table-cell";
		document.forms[0].sel_state.disabled=false;
	}
	else
	{
		document.all.idcrop1.style.display="none";
		document.all.idcrop2.style.display="none";
		document.all.idcrop3.style.display="none";
		document.all.idcrop4.innerText="Nature of Activity";
		document.all.idcrop6.style.display="none";
		document.all.idcrop7.style.display="none";
		document.all.idcrop8.style.display="none";
		enableButtons(false,true,true,true,true,false);
	}
}
function disableFields(one)
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
		if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=(!one);		  
		}	
	}
}
function callsupnam()
{
	var action=document.forms[0].hidAction.value;
	if(document.forms[0].cmdsave.disabled==true)
	{
		var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appURL+"action/companymastlist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getCompanyMasterList&strfrom=CompanyMaster";
		window.open(url,"",prop);
	}
	else
	{
		ShowAlert(152);
	}
}

function callDesignation1()
{
	var action=document.forms[0].hidAction.value;
	if(document.forms[0].cmdsave.disabled==false)
	{
		var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appURL+"action/designationlist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getDesignationMasterList&strfrom=companymaster";
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
	if(document.forms[0].sel_type.value=="")
	{
		alert("select type");
		document.forms[0].sel_type.focus();
		return;
	}
	if(document.forms[0].txt_crop.value==""||document.forms[0].txt_crop.value=="0")
	{
		if(document.forms[0].sel_type.value=="130")
		{
			alert("select Crop Name");
		}
		else
		{
			alert("select Nature of Activity");
		}
		document.forms[0].txt_crop.focus();
		return;
	}
	if(document.forms[0].txt_finance.value=="" || document.forms[0].txt_finance.value==" ")
	{
		alert("Enter Scale of Finance per acre");
		document.forms[0].txt_finance.focus();
		return;
	}
	if(document.forms[0].txt_fromdate.value=="")
	{
		alert("Enter From Date");
		document.forms[0].txt_fromdate.focus();
		return false;
	}
	if(document.forms[0].txt_todate.value=="")
	{
		alert("Enter ToDate");
		document.forms[0].txt_todate.focus();
		return false;
	}
	if(document.forms[0].sel_type.value=="130" && document.forms[0].txt_noofplants.value=="" || document.forms[0].txt_noofplants.value==" ")
	{
		alert("Enter No of plants per acre");
		document.forms[0].txt_noofplants.focus();
		return;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].txt_district.disabled= false;
	document.forms[0].sel_state.disabled=false;
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanMethod.value="updateFinanceData";
	document.forms[0].hidBeanGetMethod.value="getFinanceData";
	document.forms[0].hidSourceUrl.value="/action/scalefinancemaster.jsp";
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
		document.forms[0].txt_district.disabled= false;
		document.forms[0].sel_state.disabled=false;
		//document.forms[0].txt_district.value='';
		document.forms[0].hidAction.value="Cancel";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanGetMethod.value="getFinanceData";
		document.forms[0].hidSourceUrl.value="/action/scalefinancemaster.jsp";		
		document.forms[0].submit();
	}
}

function doNew() 
{
	//ClearFields();
	document.forms[0].hidAction.value="insert";
   	enableButtons(true, true, false, false, true, true);
   	disablefields(false);   
   	//mode = "new";
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].checked=false;
		}	  
	}
	document.forms[0].txt_district.disabled= true;
	document.forms[0].sel_state.disabled=true;	
	document.forms[0].txt_scaleoffinperplant.readOnly=true;	
}

function doEdit() 
{
	if(document.forms[0].sel_state.value=="0")
	{
		ShowAlert(156);
		return;
	}
	else
	{
		for(var i=0;i<document.forms[0].length;i++) {
			if(document.forms[0].elements[i].type=="radio") {
				document.forms[0].elements[i].disabled=true;		  
			}
		}
	}
   	document.forms[0].hidAction.value="update"
	enableButtons(true, true, false, false, true, true);
	disablefields(false);
	//mode ="edit";
	document.forms[0].txt_district.readOnly= true;
	document.forms[0].sel_state.disabled=true;
	document.forms[0].txt_scaleoffinperplant.readOnly=true;	 
}

function doDelete() 
{
   	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updateFinanceData";
		document.forms[0].hidBeanGetMethod.value="getFinanceData";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidSourceUrl.value="action/scalefinancemaster.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}
}  

function enableButtons(bool1, bool2, bool3, bool4,bool5,bool6)
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

function callFromDate(obj)
{
	var pagedate=obj.value;
	var pgdt=pagedate.substring(0,2);
	var pgmon=pagedate.substring(3,5);
	var pgyear=pagedate.substring(6,10);
	var pgdt=pgmon+"/"+pgdt+"/"+pgyear;
	
	var received=document.forms[0].txt_fromdate.value;
		if(received!="")
		{
			var curdt=received.substring(0,2);
			var curmon=received.substring(3,5);
			var curyear=received.substring(6,10);
			var AppRecdt=curmon+"/"+curdt+"/"+curyear;
			
			if(Date.parse(pgdt) < Date.parse(AppRecdt))
	        {
				alert("To date should not be Less than From date");
		        document.forms[0].txt_todate.value="";
				document.forms[0].txt_todate.focus();
				return true;
			} 

	  } 
}
function calcPlants()
{
	if(document.forms[0].cmdsave.disabled==false) {
		var varsof=document.forms[0].txt_finance.value;
		var varnoofplants=document.forms[0].txt_noofplants.value;
		var sofperplant='';
		if(varnoofplants!='' && varnoofplants!='0') {
			sofperplant=parseInt(varsof)/parseInt(varnoofplants);
			document.forms[0].txt_scaleoffinperplant.value=round(NanNumber(parseFloat(sofperplant)));
		}
		else {
			document.forms[0].txt_scaleoffinperplant.value='0';
		}
	}
}
function enablefields()
{
	document.forms[0].sel_state.value="s";
	document.forms[0].txt_district.value="";
	document.forms[0].txt_districtcode.value="";
	document.forms[0].type.value="0";
	document.forms[0].txt_crop.value="0";
	document.forms[0].txt_finance.value="";
	document.forms[0].txt_fromdate.value="";
	document.forms[0].txt_todate.value="";
	document.forms[0].txt_noofplants.value="";
	document.forms[0].txt_scaleoffinperplant.value="";
	if(document.forms[0].sel_type.value=="130")
	{
		document.all.idcrop1.style.display="table-cell";
		document.all.idcrop2.style.display="table-cell";
		document.all.idcrop3.style.display="table-cell";
		document.all.idcrop4.innerText="Crop Name";
		document.all.idcrop6.style.display="table-cell";
		document.all.idcrop7.style.display="table-cell";
		document.all.idcrop8.style.display="table-cell";
		document.forms[0].sel_state.disabled=false;
	}
	else
	{
		document.forms[0].action=appUrl+"action/scalefinancemaster.jsp";	
		document.forms[0].hidBeanGetMethod.value="getFinanceData";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].submit();	
	}
	
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
DIV.cellContainer {
	width: 100%;
	height: 150;
	overflow: auto;
}
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad()">
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Master -&gt; Scale Finance
		Master</td>
	</tr>
</table>
<iframe height="0" width="0" id="ifrm" frameborder=0 style="border: 0"></iframe>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/mastertab.jsp" flush="true">
			<jsp:param name="tabid" value="9" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="5" cellspacing="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="outertable">
					<tr>
						<td>
						<table width="95%" border="0" cellspacing="0" cellpadding="3"
							class="outertable border1 tableBg">
							<tr>
							<td>
							<table width="100%" border="0" cellspacing="1" cellpadding="2"
									class="outertable">
									<tr>
							<td>Type</td>
							<td><select name="sel_type" onchange="enablefields();">
							<option value=""><--select--></option>
							<lapschoice:StaticDataQuestionMastTag apptype="231" />
							</select></td>
							</tr>
							</table>
							</td>
							</tr>
							<tr id="idcrop1">
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="2"
									class="outertable">
									<tr>
										<td width="9%">State</td>
										<td width="22%"><b> <select name="sel_state"
											onChange="" TABINDEX="1">
											<option value="s">--Select--</option>
											<lapschoice:statemaster />
										</select> </b></td>
										<td width="10%">District</td>
										<td width="15%"><input type="text" name="txt_district"
											value="" tabindex="2"> <input type="hidden"
											name="txt_districtcode"
											value="<%=Helper.correctNull((String) hshValues
							.get("txt_districtcode"))%>">
										<b><span onClick="showDistrict()" style="cursor: hand"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"></span></b></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="2"
									class="outertable">
									<tr>
										<td width="10%"  id="idcrop2">Season</td>
										<td width="13%"  id="idcrop3"><select name="type" style="width: 80"
											TABINDEX="3">
											<option value="0" selected>--Select--</option>
											<lapschoice:StaticDataQuestionMastTag apptype="131" />
										</select></td>
										<td width="5%" ><span id="idcrop4">Crop Name</span></td>
										<td width="16%"  id="idcrop5"><b><select name="txt_crop"
											style="width: 120" TABINDEX="4">
											<option value="0" selected>--Select--</option>
											<lapschoice:StaticDataQuestionMastTag apptype="<%=strSOFType %>" />
										</select></b></td>
										<td nowrap>Scale of Finance per acre</td>

										<td width="14%"><input type="text" name="txt_finance"
											value="" tabindex="6" maxlength="15"
											onKeyPress="allowNumber(this)" onblur="calcPlants();"></td>
									</tr>
									<tr>
										<TD WIDTH="5%">From<SPAN CLASS="mantatory">*</SPAN></TD>
										<TD WIDTH="16%">
										<TABLE WIDTH="40%" BORDER="0" CELLSPACING="0" CELLPADDING="3">
											<TR>
												<TD><INPUT TYPE="text" SIZE="11" NAME="txt_fromdate"
													tabindex="9" onBlur="checkDate(this);"></TD>
												<TD><A HREF="#" ONCLICK="callCalender('txt_fromdate')"
													TITLE="Click to view calender" BORDER=0><IMG
													SRC="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
													BORDER="0"></A></TD>
											</TR>
										</TABLE>
										</TD>
										<TD WIDTH="5%">To<SPAN CLASS="mantatory">*</SPAN></TD>
										<TD WIDTH="16%">
										<TABLE WIDTH="40%" BORDER="0" CELLSPACING="0" CELLPADDING="3">
											<TR>
												<TD><INPUT TYPE="text" SIZE="11" NAME="txt_todate"
													tabindex="10" onBlur="checkDate(this);callFromDate(this)"></TD>
												<TD><A HREF="#" ONCLICK="callCalender('txt_todate')"
													TITLE="Click to view calender" BORDER=0><IMG
													SRC="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
													BORDER="0"></A></TD>
											</TR>
										</TABLE>
										</TD>
										<td WIDTH="5%" nowrap="nowrap"  id="idcrop6">No of plants per acre</td>
										<td WIDTH="16%"  id="idcrop7"><input type="text" name="txt_noofplants"
											onkeypress="allowNumber(this)" onblur="calcPlants();"
											tabindex="11"></td>
									</tr>
									<tr   id="idcrop8">

										<td WIDTH="5%" nowrap>Scale of Finance per Plant</td>
										<td WIDTH="16%"><input type="text"
											name="txt_scaleoffinperplant" onkeypress="allowNumber(this)"
											readonly="readonly" tabindex="11"></td>
										<td nowrap>&nbsp;</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td><br>
						<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete"
							btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
						<br>
						</td>
					</tr>
					<tr id="gridvalues">
						<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="3"
							class="outertable">
							<tr class="dataheader">

								<td width="4%" class="dataheader">&nbsp;</td>
								<td width="17%" align="center" class="dataheader">Nature of Activity</td>
								<%if(strSOFType.equalsIgnoreCase("130")){ %>
								<td width="17%" align="center" class="dataheader">State
								Name</td>
								<td width="16%" align="center" class="dataheader">District
								Name</td>
								<td width="15%" align="center" class="dataheader">Type</td>
								<%} %>
								<td width="15%" align="center" class="dataheader">Value</td>
								
								<td width="15%" align="center" class="dataheader">Validity</td>
							</tr>

							<%
								if (arrData != null && arrData.size() > 0) {
									vecsize = arrData.size();

									String strSno = "";
									for (int i = 0; i < vecsize; i++) {
										arrRow = (ArrayList) arrData.get(i);
										//out.println(arrRow);
										if (arrRow != null) {
											strSno = Helper.correctNull((String) arrRow.get(5));
							%>
							<tr class="dataGrid">
								<td width="4%"><input type="radio" name="sno"
									style="border-style: none"
									onClick="selectValues('<%=Helper.correctNull((String) arrRow.get(0))%>', 
											'<%=Helper.correctNull((String) arrRow.get(1))%>',
											'<%=Helper.correctNull((String) arrRow.get(2))%>',
											'<%=Helper.correctNull((String) arrRow.get(3))%>',
											'<%=Helper.correctNull((String) arrRow.get(4))%>',
											'<%=Helper.correctNull((String) arrRow.get(6))%>',
											'<%=Helper.correctNull((String) arrRow.get(7))%>',
											'<%=Helper.correctNull((String) arrRow.get(8))%>',
											'<%=Helper.correctNull((String) arrRow.get(9))%>',
											'<%=Helper.correctNull((String) arrRow.get(12))%>',
											'<%=Helper.correctNull((String) arrRow.get(13))%>');">
								<input type="hidden" name="hid" value="<%=strSno%>"></td>
								<td width="17%" align="center"><%=Helper.correctNull((String) arrRow.get(11))%></td>
								<%if(strSOFType.equalsIgnoreCase("130")){ %>
								<td width="17%" align="center"><%=Helper.correctNull((String) arrRow.get(5))%></td>
								<td width="16%" align="center"><%=Helper.correctNull((String) arrRow.get(4))%></td>
								<td width="15%" align="center">&nbsp;<%=Helper.correctNull((String) arrRow.get(10))%>&nbsp;</td>
								<%} %>
								<td width="15%" align="right">&nbsp; <%=Helper.checkDecimal(Helper
										.correctNull((String) arrRow.get(7)))%></td>

								<td width="15%" align="center">&nbsp;<%=Helper.correctNull((String) arrRow.get(8))%> - <%=Helper.correctNull((String) arrRow.get(9))%>&nbsp;</td>
							</tr>
							<%
								}
									}
								} else {
							%>
							<tr class="dataGrid">
								<td colspan="7" align="center">No Data Found</td>
							</tr>
							<%
								}
							%>
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
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="sel_state1"> <input type="hidden" name="type1"> <input
	type="hidden" name="hidorg_code"
	value="<%=Helper.correctNull((String) hshValues.get("ORG_CODE"))%>">
<input type="hidden" name="hidsno"
	value="<%=Helper.correctNull((String) hshValues.get("hidslno"))%>">
<input type="hidden" name="hidcat_parent" value="0"> <input
	type="hidden" name="strStatId1" value=""> <input type="hidden"
	name="selsno" value=""></form>
</body>
</html>