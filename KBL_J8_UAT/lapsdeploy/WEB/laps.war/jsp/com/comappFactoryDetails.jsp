<%@include file="../share/directives.jsp"%>
<%
	request.setAttribute("_cache_refresh", "true");
%>
<%
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	arrRow = (ArrayList) hshValues.get("arrRow");
	String existing = Helper.correctNull((String) hshValues.get("existing"));
	request.setAttribute("scode", "yyy");
	String pageid = Helper.correctNull((String) request.getParameter("pageid"));
	String strEmployment=(String)session.getAttribute("strEmployment");
	String strProfilestatus = Helper.correctNull((String) hshValues
			.get("strProfilestatus"));
	String hidfacname=Helper.correctNull(request.getParameter("hidfacname"));
	String strPageName=Helper.correctNull((String)hshValues.get("strIncompletepage"));
%>
<html>
<head>
<title>Factory Details</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var appstatus="<%=Helper.correctNull((String) hshValues.get("appstatus"))%>";

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/mastersearchper.jsp";
		document.forms[0].submit();
	}
}
function callLink(page,bean,method)
{
	if (document.forms[0].cmdsave.disabled == true)
	{
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}
function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16)
{
	document.forms[0].seltype.value=val2;
	document.forms[0].comapp_name.value=val3;
	document.forms[0].comapp_address.value=val4;
	document.forms[0].comapp_pin.value=val9;
	document.forms[0].comapp_ph.value=val10;
	document.forms[0].comapp_fax.value=val11;	
	document.forms[0].comapp_sno.value=val1;
	document.forms[0].comapp_city.value=val6;
	document.forms[0].comapp_state.value=val8;
	document.forms[0].comapp_factpremises.value=val12;
	document.forms[0].hid_city.value = val5;
	document.forms[0].hid_state.value=val7;
	document.forms[0].hid_dist.value = val13;
	document.forms[0].comapp_dist.value = val14;
	if(document.forms[0].readFlag.value.toUpperCase()=="W")
	{
			if(document.forms[0].exist.value=="e")
			{
				disableCommandButtons(true,true,true,true,true,false);
			}
			else if(document.forms[0].hidappexist.value=="true")
			{
				disableCommandButtons(true,true,true,true,true,false);
			}
			else
			{
				disableCommandButtons(false,false,true,false,true,true);
			}
	}

	funPremises();
	document.forms[0].txt_leaserentdate.value = val16;
		
}
function clearfields()
{
	document.forms[0].comapp_name.value="";
	document.forms[0].comapp_address.value="";
	document.forms[0].comapp_city.value="";
	document.forms[0].comapp_state.value="";
	document.forms[0].comapp_pin.value="";
	document.forms[0].comapp_ph.value="";
	document.forms[0].comapp_fax.value="";
	document.forms[0].seltype.value="0";
}

 function doSave()
 {
 	if(document.forms[0].seltype.selectedIndex <= 0)
 	{
 		alert("Select Branch/factory type");
 		document.forms[0].seltype.focus();
 		return;
 	}
 	if(trim(document.forms[0].comapp_name.value) == "")
 	{
 		alert("Enter Name of the Factory/ Branches/ Godown")
 		document.forms[0].comapp_name.focus();
 		return;
 	}
 	if(trim(document.forms[0].comapp_address.value) == "")
 	{
 		ShowAlert(121,'Address');
 		document.forms[0].comapp_address.focus();
 		return;
 	}
 	if(trim(document.forms[0].comapp_city.value) == "")
 	{
 		ShowAlert(121,'City');
 		document.forms[0].comapp_city.focus();
 		return;
 	}
 if(trim(document.forms[0].comapp_state.value) == "")
 	{
 		ShowAlert(121,'State');
 		document.forms[0].comapp_state.focus();
 		return;
 	}
 	if(trim(document.forms[0].comapp_pin.value) == "")
 	{
 		ShowAlert(121,'Pincode');
 		document.forms[0].comapp_pin.focus();
 		return;
 	}

 	 if(trim(document.forms[0].comapp_dist.value) == "")
  	{
  		ShowAlert(111,'District');
  		document.forms[0].comapp_dist.focus();
  		return;
  	}
 	document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidBeanId.value="commappmaster";		
		document.forms[0].hidSourceUrl.value="/action/comappFactoryDetails.jsp";
		document.forms[0].hidBeanMethod.value="updateFactoryDetails";
		document.forms[0].hidBeanGetMethod.value="getFactoryDetails";
		document.forms[0].action=appURL+"controllerservlet";
		/***
			Added by Sureshkumar G for stopping the user to click the save button once again.
		***/
		disableCommandButtons(true,true,true,true,true,false);
		document.forms[0].submit();
 }

function disableCommandButtons(cmdnew,cmdedit,cmdsave,cmddel,cmdcancel,cmdclose)
{  
	document.forms[0].cmdnew.disabled =cmdnew;
	document.forms[0].cmdedit.disabled=cmdedit;	  
	document.forms[0].cmdsave.disabled=cmdsave;
	document.forms[0].cmddelete.disabled=cmddel;
	document.forms[0].cmdcancel.disabled=cmdcancel;
	document.forms[0].cmdclose.disabled=cmdclose;
} 
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="Update";
	disableCommandButtons(true,true,false,false,false,true);
	document.forms[0].comapp_city.readOnly = true;
	document.forms[0].comapp_state.readOnly = true;
	document.forms[0].comapp_dist.readOnly = true;

}
function doNew()
{
  	disableFields(false);
  	document.forms[0].hidAction.value ="Insert";
  	disableCommandButtons(true,true,false,true,false,true);
  	clearfields();
	document.forms[0].comapp_city.readOnly = true;
	document.forms[0].comapp_state.readOnly = true;
	document.forms[0].comapp_dist.readOnly = true;
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="commappmaster";
		document.forms[0].hidBeanGetMethod.value="getFactoryDetails";
		document.forms[0].action=appURL+"action/comappFactoryDetails.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
  function disableFields(val)
  {
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  if(document.forms[0].elements[i].type=='text'  )
		  {
			document.forms[0].elements[i].readOnly=val;
		  }	 
		   if(document.forms[0].elements[i].type=='textarea'  )
		  {
			document.forms[0].elements[i].readOnly=val;
		  }	 
		  if(document.forms[0].elements[i].type=='select-one'  )
		  {
			document.forms[0].elements[i].disabled=val;
		  }	 
	  }
  }  
function doDelete()
{
	if(varRecordFlag=="Y")
	{
	 if(ConfirmMsg(101))
	  {
		document.forms[0].hidAction.value ="Delete";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updateFactoryDetails";
		document.forms[0].hidBeanGetMethod.value="getFactoryDetails";	
		document.forms[0].hidBeanId.value="commappmaster";
		document.forms[0].hidSourceUrl.value="action/comappFactoryDetails.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	 }	
    }
	else
	{
		ShowAlert(158);
	}
}
function onloading()
{	  
	disableFields(true);
	
	if(appstatus=="true")
    {
		disableCommandButtons(true,true,true,true,true,false);
    }
    else
    {
    	disableCommandButtons(false,true,true,true,true,false);
    }
	document.forms[0].hidAction.value ="";
}

function showCitySearch(val1)
{
	if(val1 == "BRANCH")
	{
	var varQryString = appURL+"action/searchCity.jsp?branch="+val1;
	var title = "City";
	var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString,title,prop);
	}
}
function showDistSearch(val)
{  
	var varstate = document.forms[0].hid_state.value;
	if(document.forms[0].comapp_city.value=="")
	{
		ShowAlert(112,"City");
		document.forms[0].comapp_city.focus();
		return;
	}
	else		
	{
    var varQryString = appURL+"action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="+varstate+"&code="+val;
	var title = "District";
	var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
	prop = prop + ",left=200,top=200";
	window.open(varQryString,title,prop);
	}
	
	
}

function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}

function funPremises()
{
	var varPremises=document.forms[0].comapp_factpremises.value;

	if((varPremises=="2") ||(varPremises=="3"))
	{
	document.all.ID1.style.visibility="visible";
	document.all.ID1.style.position="relative";
	document.all.ID2.style.visibility="visible";
	document.all.ID2.style.position="relative";

	}
	else
	{
		document.all.ID1.style.visibility="hidden";
		document.all.ID1.style.position="absolute";
		document.all.ID2.style.visibility="hidden";
		document.all.ID2.style.position="absolute";
	}
		
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading();funPremises()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Customer Profile
		-&gt; Branches</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
			<tr>
		<td><jsp:include page="../share/Cusurllink.jsp" flush="true">
			<jsp:param name="pageid" value="8"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="strProfilestatus" value="<%=strProfilestatus%>" />
			<jsp:param name="hidincompletedpagename" value="<%=strPageName%>" />
			
		</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5"
	class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="5"
							class="outertable border1">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="2"
									class="outertable">
									<tr>
										<td width="10%">Select Branch/<br>Factory type<span class="mantatory"><b>*</b></span></td>
										<td align="left" width="20%"><select name="seltype">
											<option value="0">---Select--</option>
											<option value="1">Factory</option>
											<option value="2">Branch</option>
											<option value="3">Godown</option>
											<option value="4">Sales depot/ Outlet</option>
											<option value="5">Plant</option>
										</select></td>
										<td width="15%" nowrap="nowrap">Name of the Factory/ <br>
										Branches/ Godown<span class="mantatory"><b>*</b></span></td>
										<td width="20%"><input type="text" name="comapp_name"
											size="35" maxlength="75" style="text-align: left;"
											onKeyPress="notAllowSplChar()"></td>
										<td width="6%">Address<span class="mantatory"><b>*</b></span></td>
										<td align="left" width="15%"><textarea
											name="comapp_address" cols="40" rows="4"
											style="text-align: left;" onkeypress="notAllowSplChar();textlimit(this,999)" onKeyUp="textlimit(this,999)"
											wrap="VIRTUAL"> 
									</textarea></td>
									</tr>
									<tr>
										<td align="left">City<span class="mantatory"><b>*</b></span></td>
										<td><input type="text" name="comapp_city" size="30" maxlength="30" value="" onKeyPress="">
										<input type="hidden" name="hid_city" size="5" value="<%=Helper.correctNull((String)hshValues.get(""))%>">
										<a href="#" onClick="showCitySearch('BRANCH')" style="cursor:hand" tabindex="22">
										<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"></a></td>




										<td>District<span class="mantatory"><b>*</b></span></td>
										<td><input type="text" name="comapp_dist" size="25"
											maxlength="30" style="text-align: left;"
											onKeyPress="notAllowSplChar();allowAlphabets()">
										&nbsp;<a href="#"
													onClick="showDistSearch('BRANCH');"
													style="cursor:hand" tabindex="22"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" ></a>
											<input type="hidden" name="hid_dist" size="5" value="<%=Helper.correctNull((String)hshValues.get(""))%>"></td>
										<td nowrap="nowrap"><%=ApplicationParams.getZipName()%><span
											class="mantatory"><b>*</b></span></td>
										<td align="left"><input type="text" name="comapp_pin"
											size="12" maxlength="<%=ApplicationParams.getZipValue()%>"
											style="text-align: left;" onKeyPress="allowInteger()"
											OnBlur="zipvalidate(this,'<%=ApplicationParams.getZipValue()%>')">
										</td>
									</tr>
									<tr>
										
											
										<td>State<span class="mantatory"><b>*</b></span></td>
										<td><input type="text" name="comapp_state" size="25"
											maxlength="30" style="text-align: left;"
											onKeyPress="notAllowSplChar();allowAlphabets()"><input type="hidden" name="hid_state" size="5" value="<%=Helper.correctNull((String)hshValues.get(""))%>"></td>
										
										
										<td align="left">Phone No.</td>
										<td><input type="text" name="comapp_ph" size="25"
											maxlength="20" style="text-align: left;"
											onKeyPress="allowPhone()"></td>
										<td>Fax</td>
										<td><input type="text" name="comapp_fax" size="20"
											maxlength="20" style="text-align: left;"
											onKeyPress="allowPhone()"></td>
									
									</tr>
									<tr>
										<td>Premises</td>
										<td align="left"><select name="comapp_factpremises"
											size="1" onchange="funPremises()">
											<option Selected="selected" value="0">--Select--</option>
											<option value="1">Owned</option>
											<option value="2">Leased</option>
											<option value="3">Rented</option>
										</select></td>
										<td  id="ID1">Lease / Rent Agreement<br> valid Upto</td>
										<td id="ID2">
										<table>
										<tr>
											<td>
												<input type="text" name="txt_leaserentdate" tabindex="9"
													onBlur="checkDate(this);" size="12" maxlength="11">
											</td>
											<td width="34%"><a alt="Select date from calender" tabindex="8"
												href="javascript:callCalender('txt_leaserentdate')"><img
												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
												border="0"></a>
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
						<lapschoice:combuttonnew
							btnnames='New_Edit_Save_Cancel_Delete_Audit Trail'
							btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
						<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3"
									class="outertable linebor">
									<tr class="dataheader" align="center">
										<td width="10%">Select</td>
										<td width="20%">Name of the Factory/ Branches/ Godown
										Details</td>
										<td width="25%">Address</td>
										<td width="10%">City</td>
										<td width="10%">State</td>
										<td width="10%">Phone No</td>
										<td width="15%">Premises</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td>
								<%if(arrRow.size()>6){ %>
								<div class="cellContainer">
								<%} %>
								<table width="100%" border="0" cellspacing="1" cellpadding="3">
									<%
										if (arrRow != null && arrRow.size() > 0) {
											String temp = "";
											String strpremises = "";
											for (int i = 0; i < arrRow.size(); i++) {
												arrCol = (ArrayList) arrRow.get(i);
									%>
									<tr class="datagrid">
										<td width="10%" align="center">
										<%
											if (!(temp.equals(Helper
															.correctNull((String) arrCol.get(2))))) {
														temp = Helper.correctNull((String) arrCol.get(2));
														if (temp.equals("1")) {
															out.println("Factory");
														} else if (temp.equals("2")) {
															out.println("Branch");
														} else if (temp.equals("3")) {
															out.println("Godown");
														} else if (temp.equals("4")) {
															out.println("Sales depot/ Outlet");
														} else if (temp.equals("5")) {
															out.println("Plant");
														}
													}
										%> &nbsp;
										<td width="20%"><B><A
											HREF="javascript:selectValues('<%=Helper.correctNull((String) arrCol.get(1))%>','<%=Helper.correctNull((String) arrCol.get(2))%>'
                            	,'<%=Helper.correctNull((String) arrCol.get(3))%>','<%=Helper.correctNull((String) arrCol.get(4))%>'
                            	,'<%=Helper.correctNull((String) arrCol.get(5))%>','<%=Helper.correctNull((String) arrCol.get(6))%>',
                            	'<%=Helper.correctNull((String) arrCol.get(7))%>','<%=Helper.correctNull((String) arrCol.get(8))%>',
                            	'<%=Helper.correctNull((String) arrCol.get(9))%>','<%=Helper.correctNull((String) arrCol.get(10))%>','<%=Helper.correctNull((String) arrCol.get(11))%>','<%=Helper.correctNull((String) arrCol.get(12))%>','<%=Helper.correctNull((String) arrCol.get(13))%>','<%=Helper.correctNull((String) arrCol.get(14))%>','<%=Helper.correctNull((String) arrCol.get(14))%>','<%=Helper.correctNull((String) arrCol.get(15))%>')"><%=Helper.correctNull((String) arrCol.get(3))%></A></B>
										<td width="25%"><%=Helper.correctNull((String) arrCol.get(4))%>
										</td>
										<td width="10%"><%=Helper.correctNull((String) arrCol.get(6))%>&nbsp;</td>
										<td width="10%"><%=Helper.correctNull((String) arrCol.get(8))%>&nbsp;</td>
										<td width="10%"><%=Helper.correctNull((String) arrCol.get(10))%>&nbsp;</td>
										<td width="15%">
										<%
											strpremises = Helper.correctNull((String) arrCol.get(12));
													{
														if (strpremises.equals("1")) {
															out.println("Owned");
														} else if (strpremises.equals("2")) {
															out.println("Leased");
														} else if (strpremises.equals("3")) {
															out.println("Rented");
														}
													}
										%>&nbsp;</td>
									</tr>
									
									<%
										}
										%>
										
										<%}else {
									%>
									<tr class="datagrid">
										<td align="center" colspan="8">No Data Found</td>
									</tr>
									<%
										}
									%>
								</table>
								<%if(arrRow.size()>6){ %></div><%} %>
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
<lapschoice:hiddentag pageid='<%=PageId%>' /> 
<%String strappno = request.getParameter("appno");%> 

<input type="hidden" name="txtperapp_appid" value="<%=Helper.correctNull((String) hshValues.get("comapp_id"))%>">
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)hshValues.get("comapp_id"))%>"> 

<input type="hidden" name="comapp_sno" value=""> 
	
	
<input type="hidden" name="exist"
	value="<%=Helper.correctNull((String) hshValues.get("existing"))%>">
<input type="hidden" name="scode" value="yy"> <input
	type="hidden" name="hidappexist"
	value="<%=Helper.correctNull((String) request
							.getParameter("hidappexist"))%>">
<input type="hidden" name="readFlag"
	value="<%=Helper.correctNull(
							(String) session.getAttribute("strGroupRights"))
							.charAt(18)%>">
<input type="hidden" name="hidappstatus" value="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>">  
<input type="hidden" name="hidfacname"	value="<%=hidfacname%>">
</form>
</body>
</html>
