<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%
	request.setAttribute("_cache_refresh", "true");
%>
<laps:handleerror />
<%

	String prd_type = Helper.correctNull((String) session
			.getAttribute("strProductType"));
	String strorgcode = Helper.correctNull((String) session
			.getAttribute("strOrgCode"));
	String appstatus = Helper.correctNull((String) session
			.getAttribute("appstatus"));
	String strappno = Helper.correctNull((String) session
			.getAttribute("strappno"));

	String strCategoryType = Helper.correctNull((String) request
			.getParameter("hidCategoryType"));
	
	String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
	
	String strschemearrtype[]=schemetype.split("-");
	String strschem=strschemearrtype[1];
	if(schemetype. trim().equalsIgnoreCase(""))
	{
		schemetype="0";
	}
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	int arrSize = 0;
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	ArrayList arrPlantDet = new ArrayList();
	ArrayList arrColPlant = new ArrayList();
	int arrPlantDetSize = 0;

	if (hshValues != null) {
		arrRow = (ArrayList) hshValues.get("arrHerdPrjChart");
	}
	if (arrRow != null) {
		arrSize = arrRow.size();
	}
	String strDesc[] = { "No of females at the beginning",
			"No. of young ones produced ",
			"No. of young ones after mortality of ",
			"No of young males produced", "No of young males sold",
			"No of young males retained", "No of young female produced",
			"No of young female  sold", "No of young female retained",
			"No of females added by grown up young female",
			"No of adult females culled out",
			"Total strength of adult females at the end of the year",
			"No of adult males at the beginning", "No of adult males culled out",
			"No of adult males added",
			"Total strength of adult males at the end of the year",
			"Total strength of adult males and females" };

	if (hshValues != null) {
		arrPlantDet = (ArrayList) hshValues.get("arrHortiplant");
	}
	if (arrPlantDet != null) {
		arrPlantDetSize = arrPlantDet.size();
	}
	String strschemetype = Helper.correctNull((String)request.getParameter("schemetype"));
	if(strschemetype. trim().equalsIgnoreCase(""))
	{
		strschemetype="0";
	}
	

	String strSSIType = Helper.correctNull((String) request
			.getParameter("hidSSIType"));
	
%>
<html>
<head>
<title>HERD PROJECTION CHART</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>

<Script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request
							.getParameter("appstatus"))%>";
var plant_name = "<%=Helper.correctNull((String) hshValues.get("strPlantId"))%>";
var yieldingperiod="0";

function disabledFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	   
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=!val;
		}	
	}
	
	
}
function onloading()
{	  
	disabledFields(true);
	

	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
		enableButtons(false, true, true, true,false);
	}
	else
	{
	enableButtons(true,true,true,true,true, false);
	}
	}
	else
	{	enableButtons(true,true,true,true,true, false);
	}
	
	 document.forms[0].sel_scheme.disabled=false;
	document.forms[0].sel_scheme.value="<%=strschemetype%>";
}
function enableButtons(bool1, bool2, bool3, bool4,  bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	
	document.forms[0].cmdclose.disabled=bool6;
}
function doSave()
{   
	calculatecount();
	enableButtons(true, true, true, true, false);
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="agrnursery";
	document.forms[0].hidBeanMethod.value="updateSheepHerdProjectionChart";
	document.forms[0].hidBeanGetMethod.value="getSheepHerdProjectionChart";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/agr_sheepherdprojchart.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();	
}
function doEdit()
{
	
	document.forms[0].hidAction.value="Edit";
	disabledFields(false);
	enableButtons(true, false, false, false, false);
	<%for(int i=1;i<=6;i++){%>
	document.forms[0].txt_year<%=i%>[1].readOnly=true;
	document.forms[0].txt_year<%=i%>[2].readOnly=true;
	document.forms[0].txt_year<%=i%>[5].readOnly=true;
	document.forms[0].txt_year<%=i%>[8].readOnly=true;
	document.forms[0].txt_year<%=i%>[11].readOnly=true;
	document.forms[0].txt_year<%=i%>[15].readOnly=true;
	document.forms[0].txt_year<%=i%>[16].readOnly=true;
	document.forms[0].txt_year<%=i%>[6].readOnly=true;
	<%}%>

}

function calculatecount()
{
	if(document.forms[0].cmdedit.disabled==true)
	{
	var varadultpercentage=document.forms[0].txt_adultpercent.value;
	var varmortalitypercent=document.forms[0].txt_mortalitypercent.value;
	if(trim(varadultpercentage)=="")
		varadultpercentage="0.00";
	if(trim(varmortalitypercent)=="")
		varmortalitypercent="0.00";
	varmortalitypercent=100-parseFloat(varmortalitypercent);
	
	<%for(int i=1;i<=6;i++)
	{%>
		var varewesno =document.forms[0].txt_year<%=i%>[0].value;
		if(trim(varewesno)=="")
			varewesno=0;
		var varlambsno=document.forms[0].txt_year<%=i%>[1].value;
		if(trim(varlambsno)=="")
			varlambsno=0;
		if(trim(document.forms[0].txt_year<%=i%>[12].value)=="")
				document.forms[0].txt_year<%=i%>[12].value="0";
		if(trim(document.forms[0].txt_year<%=i%>[13].value)=="")
				document.forms[0].txt_year<%=i%>[13].value="0";
		if(trim(document.forms[0].txt_year<%=i%>[14].value)=="")
				document.forms[0].txt_year<%=i%>[14].value="0";
		if(trim(document.forms[0].txt_year<%=i%>[3].value)=="")
				document.forms[0].txt_year<%=i%>[3].value="0";
		if(trim(document.forms[0].txt_year<%=i%>[4].value)=="")
				document.forms[0].txt_year<%=i%>[4].value="0";
		if(trim(document.forms[0].txt_year<%=i%>[6].value)=="")
				document.forms[0].txt_year<%=i%>[6].value="0";
		if(trim(document.forms[0].txt_year<%=i%>[7].value)=="")
				document.forms[0].txt_year<%=i%>[7].value="0";
		if(trim(document.forms[0].txt_year<%=i%>[9].value)=="")
				document.forms[0].txt_year<%=i%>[9].value="0";
		if(trim(document.forms[0].txt_year<%=i%>[10].value)=="")
				document.forms[0].txt_year<%=i%>[10].value="0";

		var varlambscount=parseFloat(varewesno)*parseFloat(varadultpercentage)/100;
		if(varlambscount.toString().split(".").length>1)
		{
			varlambscount=round(varlambscount,1);
			var temp=varlambscount.toString().split(".");
			if(parseFloat(temp[1])>=5)
				varlambscount=parseFloat(temp[0])+1;
			else
				varlambscount=parseFloat(temp[0]);
		}
		var varlambsno=parseFloat(varlambsno)*parseFloat(varmortalitypercent)/100;
		if(varlambsno.toString().split(".").length>1)
		{
			varlambsno=round(varlambsno,1);
			var temp=varlambsno.toString().split(".");
			if(parseFloat(temp[1])>=5)
				varlambsno=parseFloat(temp[0])+1;
			else
				varlambsno=parseFloat(temp[0]);
		}					
		document.forms[0].txt_year<%=i%>[1].value=varlambscount;
		document.forms[0].txt_year<%=i%>[2].value=varlambsno;
		document.forms[0].txt_year<%=i%>[5].value=parseFloat(document.forms[0].txt_year<%=i%>[3].value)-parseFloat(document.forms[0].txt_year<%=i%>[4].value);
		document.forms[0].txt_year<%=i%>[8].value=parseFloat(document.forms[0].txt_year<%=i%>[6].value)-parseFloat(document.forms[0].txt_year<%=i%>[7].value);
		document.forms[0].txt_year<%=i%>[11].value=parseFloat(varewesno)+parseFloat(document.forms[0].txt_year<%=i%>[9].value)-parseFloat(document.forms[0].txt_year<%=i%>[10].value);
		document.forms[0].txt_year<%=i%>[15].value=parseFloat(document.forms[0].txt_year<%=i%>[12].value)-parseFloat(document.forms[0].txt_year<%=i%>[13].value)+parseFloat(document.forms[0].txt_year<%=i%>[14].value);
		document.forms[0].txt_year<%=i%>[16].value=parseFloat(document.forms[0].txt_year<%=i%>[15].value)+parseFloat(document.forms[0].txt_year<%=i%>[11].value);
		document.forms[0].txt_year<%=i%>[6].value=parseFloat(document.forms[0].txt_year<%=i%>[2].value)-parseFloat(document.forms[0].txt_year<%=i%>[3].value);

		<%}%>
	}

}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getSheepHerdProjectionChart";
		document.forms[0].hidBeanId.value="agrnursery";
		document.forms[0].action=appUrl+"action/agr_sheepherdprojchart.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	
	if(ConfirmMsg(101))
	{
		
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanId.value="agrnursery";
		document.forms[0].hidSourceUrl.value="action/agr_sheepherdprojchart.jsp";	
		document.forms[0].hidBeanMethod.value="updateSheepHerdProjectionChart";
		document.forms[0].hidBeanGetMethod.value="getSheepHerdProjectionChart";
		document.forms[0].submit();		
	}
}	

</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form name="frmDSCR" method=post class="normal">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>


<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="999" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
	<tr>
	<td class="page_flow">Home -> Agriculture -> Herd Projection Chart </td>
	
	</tr>
</table>
<laps:borrowertype /> 
<laps:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="123" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>


<br>
<table width="98%" border="0" cellspacing="0" cellpadding="3"
	class="outertable border1" align=center>
	<tr>
		<td height="24" valign="top">
		<table width="100%" border="0" cellspacing="1" cellpadding="3"
			 class="outertable">
			<tr align="center" class="dataHeader">
				<td WIDTH="7%">S.No</td>
				<td WIDTH="18%">Particulars</td>
				<td WIDTH="14%">YEAR I</td>
				<td WIDTH="11%">YEAR II</td>
				<td WIDTH="13%">YEAR III</td>
				<td WIDTH="13%">YEAR IV</td>
				<td WIDTH="12%">YEAR V</td>
				<td WIDTH="12%">YEAR VI</td>
			</tr>
			<%
				for (int i = 0; i < 17; i++) {

					int arrColSize = 0;
					if (i < arrSize) {
						arrCol = (ArrayList) arrRow.get(i);
						if (arrCol != null)
							arrColSize = arrCol.size();
					}
					if (arrColSize > 0) {
			%>
			<tr class="dataGridColor" align="center">
				<td align="center" WIDTH="7%"><%=i + 1%></td>
				
            <td align="left" WIDTH="18%"><%=strDesc[i]%> 
              <%if(i==1) {%>
              (on average of 
              <input type="text" maxlength="5" tabindex="1"
					name="txt_adultpercent" size="8" onKeyPress="allowNumber(this)" 
						onblur="roundtxt(this);calculatecount()"
					style="text-align: right"
					value="<%=(Helper.correctDouble((String) hshValues.get("agr_lambsproducedpercentage")))%>">  % adult strength)
				<%} if(i==2) {%>
                          <input type="text" maxlength="6" tabindex="1"
					name="txt_mortalitypercent" size="8" onKeyPress="allowNumber(this)"
						onblur="roundtxt(this);checkPercentage(this);calculatecount()"
					style="text-align: right"
					value="<%=(Helper.correctDouble((String) hshValues.get("agr_lambsmortalitypercentage")))%>">  % 
				<%} %>
				</td>
				<td WIDTH="14%"><input type="text" maxlength="15" tabindex="1"
					name="txt_year1" size="10" onKeyPress="allowInteger()"
						onblur="calculatecount();"
					style="text-align: right"
					value="<%=Helper.correctNull((String) arrCol.get(0))%>"></td>
				<td WIDTH="11%"><input type="text" maxlength="15" tabindex="2"
					name="txt_year2" size="10" onKeyPress="allowInteger()"
						onblur="calculatecount();"
					style="text-align: right"
					value="<%=Helper.correctNull((String) arrCol.get(1))%>"></td>
				<td WIDTH="13%"><input type="text" maxlength="15" tabindex="3"
					name="txt_year3" size="10" onKeyPress="allowInteger()" 
					style="text-align: right"
					onblur="calculatecount();"
					value="<%=Helper.correctNull((String) arrCol.get(2))%>"></td>
				<td WIDTH="13%"><input type="text" maxlength="15" tabindex="4"
					name="txt_year4" size="10" onKeyPress="allowInteger()"
					style="text-align: right"
					onblur="calculatecount();"
					value="<%=Helper.correctNull((String) arrCol.get(3))%>"></td>
				<td WIDTH="12%"><input type="text" maxlength="15" tabindex="5"
					name="txt_year5" size="10" onKeyPress="allowInteger()"
					style="text-align: right"
					onblur="calculatecount();"
					value="<%=Helper.correctNull((String) arrCol.get(4))%>"></td>
				<td WIDTH="12%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year6" size="10" onKeyPress="allowInteger()"
					style="text-align: right"
					onblur="calculatecount();"
					value="<%=Helper.correctNull((String) arrCol.get(5))%>"></td>
			</tr>
			<%
				} else {
			%>
			<tr class="dataGridColor" align="center">
				<td align="center" WIDTH="7%"><%=i + 1%></td>
				<td align="left" WIDTH="18%"><%=strDesc[i]%> <input
					type="hidden" name="txt_desc" value="<%=strDesc[i]%>">
               <%if(i==1) {%>
              (on average of 
              <input type="text" maxlength="5" tabindex="1"
					name="txt_adultpercent" size="8" onKeyPress="allowNumber(this)"
						onblur="roundtxt(this);calculatecount()"
					style="text-align: right"
					value="<%=(Helper.correctDouble((String) hshValues.get("agr_lambsproducedpercentage")))%>">  % adult strength)
				<%} if(i==2) {%>
                          <input type="text" maxlength="6" tabindex="1"
					name="txt_mortalitypercent" size="8" onKeyPress="allowNumber(this)"
						onblur="roundtxt(this);checkPercentage(this);calculatecount()"
					style="text-align: right"
					value="<%=(Helper.correctDouble((String) hshValues.get("agr_lambsmortalitypercentage")))%>">  % 
				<%} %>
            </td>
				<td WIDTH="14%"><input type="text" maxlength="15" tabindex="1"
					name="txt_year1" size="10" onKeyPress="allowInteger()"
						onblur="calculatecount();"
					style="text-align: right" value=""></td>
				<td WIDTH="11%"><input type="text" maxlength="15" tabindex="2"
					name="txt_year2" size="10" onKeyPress="allowInteger()"
						onblur="calculatecount();"
					style="text-align: right" value=""></td>
				<td WIDTH="13%"><input type="text" maxlength="15" tabindex="3"
					name="txt_year3" size="10" onKeyPress="allowInteger()"
						onblur="calculatecount();"
					style="text-align: right" value=""></td>
				<td WIDTH="13%"><input type="text" maxlength="15" tabindex="4"
					name="txt_year4" size="10" onKeyPress="allowInteger(this)"
						onblur="calculatecount();"
					style="text-align: right" value=""></td>
				<td WIDTH="12%"><input type="text" maxlength="15" tabindex="5"
					name="txt_year5" size="10" onKeyPress="allowInteger()"
						onblur="calculatecount();"
					style="text-align: right" value=""></td>
				<td WIDTH="12%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year6" size="10" onKeyPress="allowInteger()"
						onblur="calculatecount();"
					style="text-align: right" value=""></td>
			</tr>
			<%
				}
				}
			%>
		</table>
		</td>
	</tr>
</table>
<br>
<laps:combuttonnew btnnames='Edit_Save_Cancel_Delete'	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<br>

<input type=hidden name="hidBeanId"> 
<input type=hidden	name="hidBeanMethod">
<input type=hidden	name="hidBeanGetMethod"> 
<input type=hidden   name="hidSourceUrl">
<input type="hidden" name="hidAction"> 
<input type="hidden" name="hid_pagename" value=""> 
<input type="hidden" name="hidAppType" value="<%=Helper.correctNull((String) hshValues.get("hidAppType"))%>">
</form>
</body>
</html>