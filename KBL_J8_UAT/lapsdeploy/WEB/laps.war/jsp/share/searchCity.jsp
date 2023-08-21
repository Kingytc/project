<%@include file="../share/directives.jsp"%>
<%	
    String hidcitycontrol = Helper.correctNull((String)request.getParameter("hidcitycontrol"));
    String hidstatecontrol = Helper.correctNull((String)request.getParameter("hidstatecontrol"));
	String hidcitycodecontrol  = Helper.correctNull((String)request.getParameter("hidcitycodecontrol"));
	String hidstatecodecontrol = Helper.correctNull((String)request.getParameter("hidstatecodecontrol"));
	
	String hidzipcontrol = Helper.correctNull((String)request.getParameter("hidzipcontrol"));
	String hidzipvaildatorcontrol = Helper.correctNull((String)request.getParameter("hidzipvaildatorcontrol"));
	ArrayList arrValues=new ArrayList();
	if(hshValues!=null)
	{
		arrValues=(ArrayList)hshValues.get("arrCust");
	}
%>
<html>
<head>
<title>City Search</title>
<SCRIPT LANGUAGE="JavaScript">
function callSearch()
{
	if(document.forms[0].sel_state.value=="0")
	{
		alert("Select State");
		document.forms[0].sel_state.focus();
		return;
	}
	document.forms[0].method="post";
	document.forms[0].hidBeanGetMethod.value="getCitySearchList";
	document.forms[0].strStatId1.value=document.forms[0].sel_state.value;
   	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].action=appURL+"action/searchCity.jsp";	
	document.forms[0].submit();
}
function callcity()
{
	var txt_search=document.forms[0].txt_city_name.value;
	var txtlen=txt_search.length;
	if(txtlen<=2)
	{
		alert("Enter minimum 3 characters");
	    document.forms[0].txt_city_name.value="";
	    return;
	}
}
function setValues(value1,value2,value3,value4,value5,value6,value7)
{
	
	if(document.forms[0].vardemo.value == "DEMO")	
	{
		window.opener.document.forms[0].txtperapp_adminstate.value = value4;
		window.opener.document.forms[0].hidperapp_adminstate.value = value5;
		window.opener.document.forms[0].hidperapp_admincity.value = value2;
	}
    else if(document.forms[0].varsolvecny.value == "SOLVENCY")	
		{
    		window.opener.document.forms[0].txt_state.value = value4;
			window.opener.document.forms[0].hidperapp_state.value = value5;
			window.opener.document.forms[0].txt_city.value = value3;
			window.opener.document.forms[0].hidperapp_city.value = value2;
		}
    else if(document.forms[0].varkpower.value == "Kpower")	
	{
		window.opener.document.forms[0].txt_state.value = value4;
		window.opener.document.forms[0].hidperapp_state.value = value5;
		window.opener.document.forms[0].txt_city.value = value3;
		window.opener.document.forms[0].hidperapp_city.value = value2;
	}
	else if(document.forms[0].varempl.value=="EMPL")
	{
		window.opener.document.forms[0].txtperapp_adminstate.value = value4;
		window.opener.document.forms[0].hidperapp_adminstate.value = value5;
		window.opener.document.forms[0].hidperapp_admincity.value = value2;
	}
	else if(document.forms[0].branch.value=="BRANCH")
	{
		window.opener.document.forms[0].comapp_city.value = value3;
		window.opener.document.forms[0].hid_city.value = value2;
		window.opener.document.forms[0].comapp_state.value = value4;
		window.opener.document.forms[0].hid_state.value = value5;
	}
	else if(document.forms[0].sister.value=="SISTER")
	{
		window.opener.document.forms[0].comapp_div_city.value = value3;
		window.opener.document.forms[0].hid_city.value = value2;
		window.opener.document.forms[0].comapp_div_state.value = value4;
		window.opener.document.forms[0].hid_state.value = value5;
	}
	else if(document.forms[0].inward.value=="INWARD")
	{
		window.opener.document.forms[0].txt_comcustcity.value = value3;
		window.opener.document.forms[0].hidcity.value = value2;
		window.opener.document.forms[0].txtcomcust_state.value = value4;
		window.opener.document.forms[0].hid_state.value = value5;
	}
	else if(document.forms[0].mis.value=="MIS")
	{
		window.opener.document.forms[0].txt_City.value = value3;
		window.opener.document.forms[0].hid_City.value = value2;
		window.opener.document.forms[0].txt_State.value = value4;
		window.opener.document.forms[0].hid_State.value = value5;
		window.opener.document.forms[0].txt_District.value = "";
		window.opener.document.forms[0].hid_District.value = "";
	}
	else if(document.forms[0].mis.value=="VEH1")
	{
		window.opener.document.forms[0].txt_city.value = value3;
		window.opener.document.forms[0].hid_city.value = value2;
		window.opener.document.forms[0].txt_state.value = value4;
		window.opener.document.forms[0].hid_state.value = value5;
		window.opener.document.forms[0].txt_district.value = "";
		window.opener.document.forms[0].hid_district.value = "";
	}
	else if(document.forms[0].mis.value=="VEH")
	{
		window.opener.document.forms[0].txt_dealercity.value = value3;
		window.opener.document.forms[0].hid_dealercity.value = value2;
		window.opener.document.forms[0].txt_dealerstate.value = value4;
		window.opener.document.forms[0].hid_dealerstate.value = value5;
		window.opener.document.forms[0].txt_dealerdistrict.value = "";
		window.opener.document.forms[0].hid_dealerdistrict.value = "";
	}
	else if(document.forms[0].mis.value=="MACH")
	{
		window.opener.document.forms[0].txt_dealercity.value = value3;
		window.opener.document.forms[0].hid_dealercity.value = value2;
		window.opener.document.forms[0].txt_dealerstate.value = value4;
		window.opener.document.forms[0].hid_dealerstate.value = value5;
		window.opener.document.forms[0].txt_dealerdistrict.value = "";
		window.opener.document.forms[0].hid_dealerdistrict.value = "";
	}
	else if(document.forms[0].mis.value=="MACH1" || document.forms[0].mis.value=="FURN")
	{
		window.opener.document.forms[0].txt_locationcity.value = value3;
		window.opener.document.forms[0].hid_locationcity.value = value2;
		window.opener.document.forms[0].txt_locationstate.value = value4;
		window.opener.document.forms[0].hid_locationstate.value = value5;
		window.opener.document.forms[0].txt_locationdistrict.value = "";
		window.opener.document.forms[0].hid_locationdistrict.value = "";
	}
	else if(document.forms[0].vardemo.value=="prophouse")
	{
		window.opener.document.forms[0].txt_addr_city.value = value3;
		window.opener.document.forms[0].hidcity.value = value2;
		window.opener.document.forms[0].txt_addr_state.value = value4;
		window.opener.document.forms[0].hidstate.value = value5;
		window.opener.document.forms[0].txt_addr_district.value = "";
		window.opener.document.forms[0].hid_dist.value = "";
		window.opener.document.forms[0].txt_addr_town.value = "";
		window.opener.document.forms[0].hidtown.value = "";
		window.opener.document.forms[0].txt_addr_pincode.value = "";
		
	}
	else if(document.forms[0].vardemo.value=="livestock")
	{
		window.opener.document.forms[0].txt_addr_city.value = value3;
		window.opener.document.forms[0].hidcity.value = value2;
		window.opener.document.forms[0].txt_addr_state.value = value4;
		window.opener.document.forms[0].hidstate.value = value5;
		window.opener.document.forms[0].txt_addr_district.value = "";
		window.opener.document.forms[0].hid_dist.value = "";
	}
	else if(document.forms[0].vardemo.value=="per_dev")
	{
		window.opener.document.forms[0].txt_appl_city.value = value3;
		window.opener.document.forms[0].hidcity.value = value2;
		window.opener.document.forms[0].txt_appl_state.value = value4;
		window.opener.document.forms[0].hidstate.value = value5;
		window.opener.document.forms[0].txt_appl_district.value = "";
		window.opener.document.forms[0].hid_dist.value = "";
		
	}
	else if(document.forms[0].mis.value=="crop")
	{
		window.opener.document.forms[0].txt_cropcity.value = value3;
		window.opener.document.forms[0].hid_cropcity.value = value2;
		window.opener.document.forms[0].txt_cropstate.value = value4;
		window.opener.document.forms[0].hid_cropstate.value = value5;
		window.opener.document.forms[0].txt_cropdistrict.value = "";
		window.opener.document.forms[0].hid_cropdistrict.value = "";
	}
	else if(document.forms[0].mis.value=="stock")
	{
		window.opener.document.forms[0].txt_city.value = value3;
		window.opener.document.forms[0].hid_city.value = value2;
		window.opener.document.forms[0].txt_state.value = value4;
		window.opener.document.forms[0].hid_state.value = value5;
		window.opener.document.forms[0].txt_district.value = "";
		window.opener.document.forms[0].hid_district.value = "";
	}
	else if(document.forms[0].banker.value=="BANKER")
	{
		window.opener.document.forms[0].txt_benfCity.value = value3;
		window.opener.document.forms[0].hid_City.value = value2;
		window.opener.document.forms[0].txt_benfState.value = value4;
		window.opener.document.forms[0].hid_State.value = value5;
		window.opener.document.forms[0].txt_benfDistrict.value = "";
		window.opener.document.forms[0].hid_District.value = "";
	}
	else
	{
		window.opener.document.forms[0].elements["<%=hidcitycontrol%>"].value = value3;
		window.opener.document.forms[0].elements["<%=hidstatecontrol%>"].value = value4;
	    window.opener.document.forms[0].elements["<%=hidcitycodecontrol%>"].value = value2;
		window.opener.document.forms[0].elements["<%=hidstatecodecontrol%>"].value = value5;
	}
	if(value5=="ZZ"){
		alert("State selected in utilization of credit should not be   " +value5+".Kinldy select any other state")
		return;
	}
	window.close();
}
function callonLoad()
{
	var val=document.forms[0].state_id.value;
	if(val!="")
	{
		document.forms[0].sel_state.value=val;
	}
}
</SCRIPT>
</head>
<body onload="callonLoad()">
<form name="appform" method="post" class="normal">
<table width="98%" border="0" cellpadding="5" cellspacing="0" class="outertable border1" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="1"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
				<tr>
				<td colspan="5" class="datagrid" align="center"><b>City Search</b></td>
				</tr>
				<tr>
						<td width="15%" nowrap style="text-align: center;"><b>Select State</b></td>
						<td width="25%" nowrap><b><select name="sel_state" onClick="">
						<option value="0">--Select--</option>
						<lapschoice:stateflexmaster />
						</select> </b></td>
						<td width="10%" nowrap style="text-align: center;"><b>City</b></td>
						<td width="30%"><input type="text" name="txt_city_name"
							size="20" maxlength="400" value="" onBlur="callcity()"
							onKeyPress="allowAlphabets()"></td>
						<td width="20%"><input type="button" name="cmdsearch"
							value="Search" class="buttonStyle" onClick="callSearch()">
						<input type="hidden" name="strStatId1" size="20"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="1" cellpadding="3"
							class="outertable linebor">
							<tr class="dataheader">
								<td width="10%"><b>Sno</b></td>
								<td width="45%"><b>City Code</b></td>
								<td width="45%"><b>City Name</b></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>

						<td valign="top" align="center"><% if(arrValues!=null)
                        {if(arrValues.size()>6){ %>
								<div class="cellContainer">
								<%}} %>
						<table width="100%" border="0" cellspacing="1" cellpadding="2"
							class="outertable linebor">
							<%
                                      if(arrValues!=null)
                                      {
                                    	  int arrSize=arrValues.size();
                                    	  ArrayList arrCol=null;
                                          for(int i=0;i<arrSize;i++)
                                    	  {
                                        	  arrCol=new ArrayList();
                                        	  arrCol=(ArrayList)arrValues.get(i);
                                       %>
							<tr class="datagrid">
								<td width="10%"><%=i+1%></td>
								<td width="45%"><a 	href="javascript:setValues('<%= Helper.correctNull((String)arrCol.get(0))%>','<%= Helper.correctNull((String)arrCol.get(1))%>','<%= Helper.correctNull((String)arrCol.get(2))%>','<%= Helper.correctNull((String)arrCol.get(3))%>','<%= Helper.correctNull((String)arrCol.get(4))%>','<%= Helper.correctNull((String)arrCol.get(6))%>','<%= Helper.correctNull((String)arrCol.get(7))%>')"><%= Helper.correctNull((String)arrCol.get(1))%></a></td>
								<td width="45%"><a
									href="javascript:setValues('<%= Helper.correctNull((String)arrCol.get(0))%>','<%= Helper.correctNull((String)arrCol.get(1))%>','<%= Helper.correctNull((String)arrCol.get(2))%>','<%= Helper.correctNull((String)arrCol.get(3))%>','<%= Helper.correctNull((String)arrCol.get(4))%>','<%= Helper.correctNull((String)arrCol.get(6))%>','<%= Helper.correctNull((String)arrCol.get(7))%>')"><%= Helper.correctNull((String)arrCol.get(2))%></a></td>
							</tr>
							<%}}%>
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
<input type="hidden" name="hidcitycontrol" 	value="<%=Helper.correctNull((String)request.getParameter("hidcitycontrol")) %>">
<input type="hidden" name="hidstatecontrol" value="<%=Helper.correctNull((String)request.getParameter("hidstatecontrol")) %>">
<input type="hidden" name="hidcitycodecontrol" value="<%=Helper.correctNull((String)request.getParameter("hidcitycodecontrol")) %>">
<input type="hidden" name="hidstatecodecontrol" value="<%=Helper.correctNull((String)request.getParameter("hidstatecodecontrol")) %>">
<input type="hidden" name="hidzipcontrol" value="<%=Helper.correctNull((String)request.getParameter("hidzipcontrol")) %>">
<input type="hidden" name="hidzipvaildatorcontrol" value="<%=Helper.correctNull((String)request.getParameter("hidzipvaildatorcontrol")) %>">
<input type="hidden" name="hidzipdiffcode" value="">
<input type="hidden" name="hidstatuscode" value="">	
<input type="hidden" name="vardemo" value="<%=Helper.correctNull((String)request.getParameter("vardemo")) %>">
<input type="hidden" name="varempl" value="<%=Helper.correctNull((String)request.getParameter("employer")) %>">
<input type="hidden" name="branch" value="<%=Helper.correctNull((String)request.getParameter("hidcitycontrol")) %>">
<input type="hidden" name="sister" value="<%=Helper.correctNull((String)request.getParameter("sister")) %>">
<input type="hidden" name="varsolvecny" value="<%=Helper.correctNull((String)request.getParameter("varsolvecny")) %>">
<input type="hidden" name="varkpower" value="<%=Helper.correctNull((String)request.getParameter("varkpower")) %>">
<input type="hidden" name="inward" value="<%=Helper.correctNull((String)request.getParameter("inward")) %>">
<input type="hidden" name="mis" value="<%=Helper.correctNull((String)request.getParameter("mis")) %>">
<input type="hidden" name="banker" value="<%=Helper.correctNull((String)request.getParameter("banker")) %>">

<lapschoice:hiddentag /> 
<input type="hidden" name="state_id" value="<%=Helper.correctNull((String)hshValues.get("strStatId"))%>">
</form>
</body>
</html>
