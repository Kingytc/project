<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%
	ArrayList g1 = new ArrayList();
	ArrayList g2 = new ArrayList();
	ArrayList v1 = (ArrayList) hshValues.get("arrRow");
	ArrayList v = (ArrayList) hshValues.get("arrRow");
	String strFromLink = Helper.correctNull((String) request
			.getParameter("strfrom"));

	if ((v == null)) {
		v = new ArrayList();
	}
	if (v1 == null) {
		v1 = new ArrayList();
	}
	ArrayList arrRow1 = (ArrayList) hshValues.get("arrRow1");
	if ((arrRow1 == null)) {
		arrRow1 = new ArrayList();
	}
	ArrayList arrCol = new ArrayList();
	if (arrCol == null) {
		arrCol = new ArrayList();
	}
	
%>
<html>
<title>Horticulture</title>
<head>
<style type="text/css">
DIV.cellContainer {
	width: 100%;
	height: 200;
	overflow: auto;
}
</style>

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>htm/link.css" type="text/css">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<SCRIPT LANGUAGE="JavaScript">	
var from_link = "<%=strFromLink%>";	
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var state = "<%=Helper.correctNull((String) hshValues.get("strStatId"))%>";
var districtid = "<%=Helper.correctNull((String) hshValues.get("hidslno"))%>";
var varSpacing= "<%=Helper.correctNull((String) hshValues.get("Spacing"))%>";
function callonload()
{
	if(from_link=="horticulture")
	{

		if(varSpacing!="")
		{
			document.forms[0].sel_crop.value=varSpacing;
		}
		else
		{
			document.forms[0].sel_crop.value="s";
		}
		document.all.spacelbl.style.visibility="visible";
		document.all.spacesel.style.visibility="visible";
		document.all.spacelbl.style.position="relative";
		document.all.spacesel.style.position="relative";
	}else{
		document.all.statelbl.style.visibility="visible";
		document.all.statelbl.style.position="relative";
		document.all.statesel.style.visibility="visible";
		document.all.statesel.style.position="relative";
		document.all.districtlbl.style.visibility="visible";
		document.all.districtlbl.style.position="relative";
		document.all.districtsel.style.visibility="visible";
		document.all.districtsel.style.position="relative";
	}

	if(from_link!="horticulture")
	{
		if(state!="")
		{
			document.forms[0].sel_state.value=state;
		}
		else
		{
			//document.forms[0].sel_state.value=s;
		}
		if(districtid!="")
		{
			document.forms[0].sel_district.value=districtid;
		}
		else
		{
			document.forms[0].sel_district.value=0;
		}
	}

	
}

function callDistrict()
{
	document.forms[0].strStatId1.value=document.forms[0].sel_state.value;
	document.forms[0].hidBeanId.value="staticdata";
    document.forms[0].hidBeanGetMethod.value="getDistrictMasterList1";
	document.forms[0].hidSourceUrl.value="/action/agrnurseryscaleoffinancelist.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function doSearch()
{
	
	document.forms[0].hidBeanId.value="agrnursery";
    document.forms[0].hidBeanGetMethod.value="getHorticultureScaleOfFinance";
	document.forms[0].hidSourceUrl.value="/action/agrnurseryscaleoffinancelist.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();

}


function getSelectedValue(val1,val2,plant,spacing)
{	
	if(from_link == "NurseryMaster")
	{		
		window.opener.document.forms[0].txt_maxunitperacre[<%=Helper.correctNull((String) request
							.getParameter("parentId"))%>].value = val2;	

		
	}
	if(from_link == "horticulture")
	{
     
		//window.opener.document.forms[0].txt_districtName.value = district;
		//window.opener.document.forms[0].txt_state.value =state;
		window.opener.document.forms[0].txt_maxplant.value =val2;
		window.opener.document.forms[0].txt_plantname.value =val1;

		
		
		//window.opener.document.forms[0].txt_spacing.value = document.forms[0].sel_crop.options[spacing].text;
		
	}

	


	window.close();
}
</SCRIPT>
</head>
<body onLoad="callonload()">
<form name="financelisthelp" method="post" class="normal"><br>
<table width="98%" border="0" cellspacing="0" cellpadding="5" class="outertable border1" align="center" >
	<tr>
		<td><br>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr>
				<td>
				<table width="101%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td WIDTH="4%" id="statelbl" style="visibility: hidden;position: absolute;">State</td>
						<td WIDTH="24%" id="statesel" style="visibility: hidden;position: absolute;">
						<%
							if ((v != null) || (v.size() != 0)) {
								v1 = (ArrayList) hshValues.get("arrRow");
						%> <select name="sel_state" style="width: 130"
							onChange="callDistrict()">
							<option value="s">--Select--</option>
							<lapschoice:statemaster />
						</select> <%
 	}
 %>
						</td>
						<td WIDTH="5%" id="districtlbl" style="visibility: hidden;position: absolute;">District</td>
						<td WIDTH="23%" id="districtsel" style="visibility: hidden;position: absolute;" ><select name="sel_district"
							style="width: 200" onChange="">
							<option value="0"><b>--Select--</b></option>
							<%
								if ((arrRow1 != null) && (arrRow1.size() != 0)) {
									arrRow1 = (ArrayList) hshValues.get("arrRow1");
									arrCol = new ArrayList();

									for (int i = 0; i < arrRow1.size(); i++) {
										arrCol = (ArrayList) arrRow1.get(i);
										out.print("<option value=" + arrCol.get(1));
										out.print(">" + arrCol.get(2) + "</option>");
									}
								}
							%>
						</select></td>
						<TD id="spacelbl" WIDTH="11%" style="visibility: hidden;position: absolute;" align="right">Crop Name</TD>
						<TD id="spacesel" WIDTH="13%" style="visibility: hidden;position: absolute;"><SELECT
							NAME="sel_crop" ONCHANGE="doSearch();" TABINDEX="3">
							<option value="s" selected><b>--Select--</b></option>
							<lapschoice:Horticultureplantnames/>
						</SELECT></TD>
						
					</tr>
				</table>
				<b><br>
				</b>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
							<tr class="dataheader">
								<td  width="4%" nowrap="nowrap">Sl. No.</td>
								<td  width="26%" align="center">Crop Name</td>
								<td  width="34%" align="center">Max No of units to	be permitted</td>
								<td  width="36%" align="center">Up to Date</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
					<%
						String inside = "Y";
						if ((v != null) && (v.size() != 0)) {
							v = (ArrayList) hshValues.get("arrRow");
							int vecsize = v.size();
							if (vecsize == 0)
								inside = "N";
							for (int l = 0; l < vecsize; l++) {
								g1 = (ArrayList) v.get(l);
					%>
					
					
					
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
							<tr class="datagrid">
							<td align="center" width="6%"><a
							href="javascript:getSelectedValue('<%=Helper.correctNull((String) g1.get(0))%>','<%=Helper.correctNull((String) g1.get(1))%>','<%=Helper.correctNull((String) g1.get(3))%>')"
							><%=l + 1%></a></td>
						<td align="center" width="26%"><b><a
							href="javascript:getSelectedValue('<%=Helper.correctNull((String) g1.get(0))%>','<%=Helper.correctNull((String) g1.get(1))%>','<%=Helper.correctNull((String) g1.get(3))%>')"
							><%=Helper.correctNull((String) g1.get(0))%></a></b></td>
						<td align="center" width="34%"><b><a
							href="javascript:getSelectedValue('<%=Helper.correctNull((String) g1.get(0))%>','<%=Helper.correctNull((String) g1.get(1))%>','<%=Helper.correctNull((String) g1.get(3))%>')"
							><%=Helper.correctNull((String) g1.get(1))%></a></b></td>
						<td align="center" width="36%"><b><a
							href="javascript:getSelectedValue('<%=Helper.correctNull((String) g1.get(0))%>','<%=Helper.correctNull((String) g1.get(1))%>','<%=Helper.correctNull((String) g1.get(3))%>')"
							><%=Helper.correctNull((String) g1.get(2))%></a></b></td>
							</tr>
						</table>
						</td>
					</tr>
					
					
					
					
					
					
					
					
					
					
					
					<%
						}
						} else {
					%>
					
					
					<tr valign="top" class="datagrid">
						<td colspan="4" align="center"><b>No Data Found for the
						selected criteria</b>
					</tr>
					<%
						}
					%>
					
				</table>
		</table>
		</td>
	</tr>
</table>
<br>
<table width="10%" border="0" cellspacing="0" cellpadding="3" class="outertable"
	align="center">
	<tr valign="top">
		<td width="20%"><input type=button class="buttonClose"
			value="Close" name="closebtn" tabindex="25" onClick=window.close()></td>
	</tr>
</table>
<input type="hidden" name="svalue"
	value="<%=Helper.correctNull((String) hshValues
									.get("svalue"))%>">
<input type="hidden" name="stype"
	value="<%=Helper.correctNull((String) hshValues.get("scode"))%>">
<input type="hidden" name="strfrom" value="<%=strFromLink%>"> <input
	type="hidden" name="hidorg_code"
	value="<%=Helper.correctNull((String) hshValues.get("ORG_CODE"))%>">
<input type="hidden" name="hidsno" value=""> <input
	type="hidden" name="hidAction"> <input type="hidden"
	name="hidBeanMethod" value=""> <input type="hidden"
	name="hidBeanId"> <input type="hidden" name="hidSourceUrl">
<input type="hidden" name="hidBeanGetMethod"> <input
	type="hidden" name="hidcat_parent" value="0"> <input
	type="hidden" name="strStatId1" value=""> <input type="hidden"
	name="parentId"
	value="<%=Helper.correctNull((String) request
							.getParameter("parentId"))%>">
</form>
</body>
</html>

