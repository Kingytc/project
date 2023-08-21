<%@include file="../share/directives.jsp"%>
<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<laps:handleerror />
<%
	String appstatus = Helper.correctNull((String) session
			.getAttribute("appstatus"));
	String strappno = Helper.correctNull((String) session
			.getAttribute("strappno"));
	String schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
	String strAnimaltype =Helper.correctNull((String)hshValues.get("animaltype"));
	
	int iarrSize = 0;
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	
	if(hshValues!=null && hshValues.size()>0)
	{
		arrRow=(ArrayList)hshValues.get("arrRow");
	}
	if(arrRow!=null && arrRow.size()>0)
	{
		iarrSize=arrRow.size();
	}
	String strDesc[] = { "On hand at the beginning",
			"Heifers grown  into "+strAnimaltype+"",
			"Less "+strAnimaltype+" sold",
			"On hand at the end of year",
			"On hand at the beginning",
			"Less died",
			"Less grown into "+strAnimaltype,
			"On hand at the end of year",
			"On hand at the beginning",
			"Less died",
			"Balance",
			"of which female calves on hand at the year"};
	String strFacSNo=Helper.getfacilitySno(schemetype);

%>
<html>
<head>
<title>HERD PROJECTION CHART</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>

<Script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request
							.getParameter("appstatus"))%>";
var varadult= "<%=Helper.correctNull((String) hshValues.get("agr_noofadultanimal"))%>";
var schemetype="<%=schemetype%>";
function onloading()
{	  
	<%for(int i=1;i<7;i++)
	{%>
		document.forms[0].txt_year<%=i%>[0].value=varadult;
	<%}%>
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=schemetype;
	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
	     disableCmdButtons(false, true, true, true, false);	
		}
		else
		{
			disableCmdButtons(true, true, true, true, false);	
		}
	}
	else
	{
		disableCmdButtons(true, true, true, true, false);	
	}
	disabledFields(true);
}
function doEdit()
{
	
	<%for(int i=1;i<7;i++)
	{%>
		document.forms[0].txt_year<%=i%>[0].readOnly=true;
		document.forms[0].txt_year<%=i%>[1].readOnly=true;
		//document.forms[0].txt_year<%=i%>[2].readOnly=true;
		document.forms[0].txt_year<%=i%>[3].readOnly=true;
		if(<%=i%>!=1)
			document.forms[0].txt_year<%=i%>[4].readOnly=true;
			
		document.forms[0].txt_year<%=i%>[7].readOnly=true;
		document.forms[0].txt_year<%=i%>[10].readOnly=true;
		document.forms[0].txt_year<%=i%>[11].readOnly=true;
		if(<%=i%>>3)
		{
			document.forms[0].txt_year<%=i%>[6].readOnly=true;
		}
	<%}%>
	disableCmdButtons(true, false, false, false, true);
	disabledFields(false);	
}
function doSave()
{   
	disableCmdButtons(true, true, true, true, false);	
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="agrnursery";
	document.forms[0].hidBeanMethod.value="updateDairyHerdProductionChart";
	document.forms[0].hidBeanGetMethod.value="getDairyHerdProductionChart";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/agr_dairyherdproductionchart.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();	
}
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanGetMethod.value="getDairyHerdProductionChart";
		document.forms[0].hidBeanId.value="agrnursery";
		document.forms[0].action=appUrl+"action/agr_dairyherdproductionchart.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanId.value="agrnursery";
		document.forms[0].hidSourceUrl.value="action/agr_dairyherdproductionchart.jsp";	
		document.forms[0].hidBeanMethod.value="updateDairyHerdProductionChart";
		document.forms[0].hidBeanGetMethod.value="getDairyHerdProductionChart";
		document.forms[0].submit();		
	}
}	
function calculatecount()
{
	calculateBuffaloesTotal();
	calculateHeifersTotal();
	calculateCalvesTotal();
}
function calculateBuffaloesTotal()
{
	<%for(int i=1;i<7;i++)
	{%>
		document.forms[0].txt_year<%=i%>[1].value=document.forms[0].txt_year<%=i%>[6].value;
		var varbeginyear=NanNumber(parseFloat(document.forms[0].txt_year<%=i%>[0].value));
		var vargrownyear=NanNumber(parseFloat(document.forms[0].txt_year<%=i%>[1].value));
		var varbuffaloessoldyear=NanNumber(parseFloat(document.forms[0].txt_year<%=i%>[2].value));
		document.forms[0].txt_year<%=i%>[3].value=parseFloat(varbeginyear)+parseFloat(vargrownyear)-parseFloat(varbuffaloessoldyear);
	<%}%>
}
function  calculateHeifersTotal()
{
	<%for(int i=1;i<7;i++)
	{%>
		if(<%=i%>!=1)
		{
			var varHeifersendyear=NanNumber(parseFloat(document.forms[0].txt_year<%=i-1%>[7].value));
			var varCalvesendyear=NanNumber(parseFloat(document.forms[0].txt_year<%=i-1%>[11].value));
			document.forms[0].txt_year<%=i%>[4].value=parseFloat(varHeifersendyear)+parseFloat(varCalvesendyear);
		}
		var varbeginyear=NanNumber(parseFloat(document.forms[0].txt_year<%=i%>[4].value));
		var vardiedyear=NanNumber(parseFloat(document.forms[0].txt_year<%=i%>[5].value));
		var vargrownyear=NanNumber(parseFloat(document.forms[0].txt_year<%=i%>[6].value));
		document.forms[0].txt_year<%=i%>[7].value=parseFloat(varbeginyear)-parseFloat(vardiedyear)-parseFloat(vargrownyear);
		if(<%=i%>>3)
		{
			var vargrownyear=NanNumber(parseFloat(document.forms[0].txt_year<%=i-2%>[7].value));
			document.forms[0].txt_year<%=i%>[6].value=vargrownyear;
		}
	<%}%>
}
function calculateCalvesTotal()
{
	<%for(int i=1;i<7;i++)
	{%>
		var varbeginyear=NanNumber(parseFloat(document.forms[0].txt_year<%=i%>[8].value));
		var vardiedyear=NanNumber(parseFloat(document.forms[0].txt_year<%=i%>[9].value));
		document.forms[0].txt_year<%=i%>[10].value=parseFloat(varbeginyear)-parseFloat(vardiedyear);
		document.forms[0].txt_year<%=i%>[11].value=NanNumber(parseFloat(document.forms[0].txt_year<%=i%>[10].value))/2;
	<%}%>
	calculateHeifersTotal();
}
function disableCmdButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled = bool5;
}
function disabledFields(one)
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
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form name="frmDSCR" method="post" class="normal">
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
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Application -&gt; Agriculture -&gt; Herd Production Chart</td>
	</tr>
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="124" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
	<tr>
		<td height="24" valign="top">
		<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr align="center" class="dataheader"> 
            <td WIDTH="18%">Particulars</td>
            <td WIDTH="14%">YEAR I</td>
            <td WIDTH="11%">YEAR II</td>
            <td WIDTH="13%">YEAR III</td>
            <td WIDTH="13%">YEAR IV</td>
            <td WIDTH="12%">YEAR V</td>
            <td WIDTH="12%">YEAR VI</td>
          </tr>
          <%
				for (int i = 0; i < strDesc.length; i++) {
				if(iarrSize>0&&iarrSize>i)
				{
					arrCol=new ArrayList();	
					arrCol=(ArrayList)arrRow.get(i);
					if(arrCol!=null && arrCol.size()>0)
					{
			%>
			
			 <%if(i==0){ %>
          	<tr align="left" class="dataheader"> 
            	<td colspan="7">Buffaloes/Cows</td>
            </tr>
            <%}if(i==4){%>
            <tr align="left" class="dataheader"> 
            	<td colspan="7">Heifers</td>
            </tr>
            <%}if(i==8){%>
            <tr align="left" class="dataheader"> 
            	<td colspan="7">Calves</td>
            </tr>
            <%}%>
            <tr class="datagrid" align="center"> 
            <td align="left" WIDTH="18%"><%=strDesc[i]%></td>
            <td WIDTH="14%">
              <input type="text" maxlength="15" tabindex="1"
					name="txt_year1" size="10" onKeyPress="allowInteger()"
						onblur="calculatecount()"
					style="text-align: right" value="<%=Helper.correctInt((String)arrCol.get(0))%>">
            </td>
            <td WIDTH="11%">
              <input type="text" maxlength="15" tabindex="2"
					name="txt_year2" size="10" onKeyPress="allowInteger()"
						onblur="calculatecount()"
					style="text-align: right" value="<%=Helper.correctInt((String)arrCol.get(1))%>">
            </td>
            <td WIDTH="13%">
              <input type="text" maxlength="15" tabindex="3"
					name="txt_year3" size="10" onKeyPress="allowInteger()"
						onblur="calculatecount()"
					style="text-align: right" value="<%=Helper.correctInt((String)arrCol.get(2))%>">
            </td>
            <td WIDTH="13%">
              <input type="text" maxlength="15" tabindex="4"
					name="txt_year4" size="10" onKeyPress="allowInteger(this)"
						onblur="calculatecount()"
					style="text-align: right" value="<%=Helper.correctInt((String)arrCol.get(3))%>">
            </td>
            <td WIDTH="12%">
              <input type="text" maxlength="15" tabindex="5"
					name="txt_year5" size="10" onKeyPress="allowInteger()"
						onblur="calculatecount()"
					style="text-align: right" value="<%=Helper.correctInt((String)arrCol.get(4))%>">
            </td>
            <td WIDTH="12%">
              <input type="text" maxlength="15" tabindex="6"
					name="txt_year6" size="10" onKeyPress="allowInteger()"
						onblur="calculatecount()"
					style="text-align: right" value="<%=Helper.correctInt((String)arrCol.get(5))%>">
            </td>
          </tr>
            <% }
            }else{%>
            <%if(i==0){ %>
          	<tr align="left" class="dataheader"> 
            	<td colspan="7">Buffaloes/Cows</td>
            </tr>
            <%}if(i==4){%>
            <tr align="left" class="dataheader"> 
            	<td colspan="7">Heifers</td>
            </tr>
            <%}if(i==8){%>
            <tr align="left" class="dataheader"> 
            	<td colspan="7">Calves</td>
            </tr>
            <%}%>
            <tr class="datagrid" align="center"> 
            <td align="left" WIDTH="18%"><%=strDesc[i]%></td>
            <td WIDTH="14%">
              <input type="text" maxlength="15" tabindex="1"
					name="txt_year1" size="10" onKeyPress="allowInteger()"
						onblur="calculatecount()"
					style="text-align: right" value="">
            </td>
            <td WIDTH="11%">
              <input type="text" maxlength="15" tabindex="2"
					name="txt_year2" size="10" onKeyPress="allowInteger()"
						onblur="calculatecount()"
					style="text-align: right" value="">
            </td>
            <td WIDTH="13%">
              <input type="text" maxlength="15" tabindex="3"
					name="txt_year3" size="10" onKeyPress="allowInteger()"
						onblur="calculatecount()"
					style="text-align: right" value="">
            </td>
            <td WIDTH="13%">
              <input type="text" maxlength="15" tabindex="4"
					name="txt_year4" size="10" onKeyPress="allowInteger(this)"
						onblur="calculatecount()"
					style="text-align: right" value="">
            </td>
            <td WIDTH="12%">
              <input type="text" maxlength="15" tabindex="5"
					name="txt_year5" size="10" onKeyPress="allowInteger()"
						onblur="calculatecount()"
					style="text-align: right" value="">
            </td>
            <td WIDTH="12%">
              <input type="text" maxlength="15" tabindex="6"
					name="txt_year6" size="10" onKeyPress="allowInteger()"
						onblur="calculatecount()"
					style="text-align: right" value="">
            </td>
          </tr>
         <%} 
         }%>
        </table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete" btnenable="Y" />
<lapschoice:hiddentag pageid="<%=PageId%>"/>
<input type="hidden"
	name="hid_pagename" value=""> <input type="hidden"
	name="hidAppType"
	value="<%=Helper.correctNull((String) hshValues.get("hidAppType"))%>">
<input type="hidden" name="hidFacSNo" value="<%=strFacSNo%>">
</form>
</body>
</html>