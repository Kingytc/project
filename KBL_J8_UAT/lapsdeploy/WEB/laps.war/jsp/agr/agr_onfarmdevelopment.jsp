<%@include file="../share/directives.jsp"%>

<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<%request.setAttribute("_cache_refresh", "true");%>
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
	int yield_period=0;
			
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	int arrSize=0;
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	ArrayList arrRowland = new ArrayList();
	ArrayList arrColPlant = new ArrayList();
	HashMap hshlanddevelop=new HashMap();
	int arrPlantDetSize=0;

	if(hshValues!=null)
	{
		arrRow=(ArrayList)hshValues.get("arrFarm");
		hshlanddevelop=(HashMap)hshValues.get("hshlanddevelop");
		arrRowland=(ArrayList)hshValues.get("arrRowland");
		//out.println("hshlanddevelop====="+hshlanddevelop);
	}
	String landdevelopslope="";
	landdevelopslope=Helper.correctNull((String)hshValues.get("agr_landdevelop_slope"));
	//out.println("arrRow==="+arrRow);
	if(arrRow!=null)
	{
		arrSize=arrRow.size();
	}
	String strMaintenance=Helper.correctNull((String)hshValues.get("maintenance"));
	
	String strDesc[]={"Construction of new bunds","Land grading",
					"Loosening of soils","Dismantling of old bunds","Field channel(earth work)",
					"Drains(earth work)","Field channels",
					"Field drains","Other civil constructions","Roads","Total",
					"@ " +strMaintenance+"% on the items 2,3,4,5,6,7 & 10","Total cost involvement per hectare",
					"Less:Subsidy/Margin Money","Bank loan per hectare"};
	String strslno[]={"1","2","3",
			"4","5","6",
			"7","8","9",
			"10","",
			"","","","",""};
	
	String schemetype="";
	schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
	String strschemetypeno=Helper.getfacilitySno(schemetype);
	String strpagename=Helper.correctNull((String)request.getParameter("pagehiden"));
	out.println(strpagename);
%>
<html>
<head>
<title>On-Farm Development</title>
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
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varmaintenance = "<%=Helper.correctNull((String)hshValues.get("maintenance"))%>";

var varschemetype="<%=schemetype%>";
var varlanddevelopslope="<%=Helper.correctNull((String)hshValues.get("agr_landdevelop_slope"))%>";
function onloading()
{	  
	disabledFields(true);// callbuttonStatus(document.forms[0].hidUsrMode, document.forms[0].hidWorkflowStatus, 'Edit',document.forms[0].hidWorkflowId);
	
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=varschemetype;
	
	disableEditButtons(false,true,true,true,false);	
		
if(varlanddevelopslope=="")
{
	alert("Please Fill the Land Development Details ");

	
}
}
function disableEditButtons(bool1, bool2, bool3, bool4, bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	
	document.forms[0].cmdclose.disabled=bool6;
}
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
function doSave()
{   
	disableEditButtons(true, true, true, true,  false);	
	document.forms[0].hidBeanId.value="agrlandholdings";
	document.forms[0].hidBeanMethod.value="updateOnFarmDevelopment";
	document.forms[0].hidBeanGetMethod.value="getOnFarmDevelopment";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/agr_onfarmdevelopment.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();	
}
function doEdit()
{
	
	document.forms[0].hidAction.value="Edit";
	disabledFields(false);
	
	disableEditButtons(true, false, false, false,  false);	
	document.forms[0].txt_slope1[10].readOnly=true;
	
}



function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getOnFarmDevelopment";
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].action=appUrl+"action/agr_onfarmdevelopment.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidSourceUrl.value="action/agr_onfarmdevelopment.jsp";	
		document.forms[0].hidBeanMethod.value="updateOnFarmDevelopment";
		document.forms[0].hidBeanGetMethod.value="getOnFarmDevelopment";
		document.forms[0].submit();		
	}
}	
function computeTotal()
{
	var tot1=0.0,tot2=0.0,tot3=0.0,totmaintenance1=0.0,totmaintenance2=0.0,totmaintenance3=0.0;
	for(i=0;i<10;i++)
	{
		var slope1 = document.forms[0].txt_slope1[i].value;
		if(slope1=="")
			slope1=0;
		tot1=eval(tot1)+eval(slope1);
		
	}
	document.forms[0].txt_slope1[10].value = roundVal(tot1);
	//document.forms[0].txt_slope1[12].value = roundVal(totmaintenance1);
	/*if(trim(document.forms[0].txt_slope1[14].value)=="")
		document.forms[0].txt_slope1[14].value="0.00";
	document.forms[0].txt_slope1[11].value = roundVal(tot1);
	document.forms[0].txt_slope1[12].value = roundVal(totmaintenance1);
	document.forms[0].txt_slope1[13].value = roundVal(eval(totmaintenance1)+eval(tot1));
	document.forms[0].txt_slope1[15].value = parseFloat(document.forms[0].txt_slope1[13].value)
											-parseFloat(document.forms[0].txt_slope1[14].value);
	
	document.forms[0].txt_slope1[15].value=NanNumber(document.forms[0].txt_slope1[15].value);
	roundtxt(document.forms[0].txt_slope1[15]);*/
	
	/**for(i=0;i<10;i++)
	{
		var slope2 = document.forms[0].txt_slope2[i].value;
		if(slope2=="")
			slope2=0;
		tot2=eval(tot2)+eval(slope2);
		if(i==1 ||i==2||i==3 ||i==4 ||i==5||i==6||i==9)
		{
			totmaintenance2=eval(totmaintenance2)+((eval(varmaintenance)/100)*eval(slope2));
		}
	}
	if(trim(document.forms[0].txt_slope2[13].value)=="")
		document.forms[0].txt_slope2[13].value="0.00";
	
	document.forms[0].txt_slope2[10].value = roundVal(tot2);
	document.forms[0].txt_slope2[11].value = roundVal(totmaintenance2);
	document.forms[0].txt_slope2[12].value = roundVal(eval(totmaintenance2)+eval(tot2));
	document.forms[0].txt_slope2[14].value = eval(document.forms[0].txt_slope2[12].value)
											-eval(document.forms[0].txt_slope2[13].value);

	document.forms[0].txt_slope2[14].value=NanNumber(document.forms[0].txt_slope2[14].value);
	roundtxt(document.forms[0].txt_slope2[14]);
	
	for(i=0;i<10;i++)
	{
		var slope3 = document.forms[0].txt_slope3[i].value;
		if(slope3=="")
			slope3=0;
		tot3=eval(tot3)+eval(slope3);
		if(i==1 ||i==2||i==3 ||i==4 ||i==5||i==6||i==9)
		{
			totmaintenance3=eval(totmaintenance3)+((eval(varmaintenance)/100)*eval(slope3));
		}
	}
	if(trim(document.forms[0].txt_slope3[13].value)=="")
		document.forms[0].txt_slope3[13].value="0.00";
	
	document.forms[0].txt_slope3[10].value = roundVal(tot3);
	document.forms[0].txt_slope3[11].value = roundVal(totmaintenance3);
	document.forms[0].txt_slope3[12].value = roundVal(eval(totmaintenance3)+eval(tot3));
	document.forms[0].txt_slope3[14].value = eval(document.forms[0].txt_slope3[12].value)
											-eval(document.forms[0].txt_slope3[13].value);

	document.forms[0].txt_slope3[14].value=NanNumber(document.forms[0].txt_slope3[14].value);

	roundtxt(document.forms[0].txt_slope3[14]);**/
	
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading();">

<form name="frmDSCR" method=post class="normal">
  <div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()"> 
  <div class="menuitems" >
   <script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div>
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
	<td class="page_flow">Home -> Agriculture ->  Application -> Land Levelling </td>
	
	</tr>
	</table>
<span style="display:none;"> <lapschoice:borrowertype /> </span> <lapschoice:application />
 
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="84" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>
<br>
<table width="70%" border="0" cellspacing="0" cellpadding="5" class="outertable border1" align="center" >

    <tr> 
      <td height="24" valign="top"> 
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr> 
            <td colspan="11">&nbsp;</td>
          </tr>
          <tr align="center"  class="dataheader"> 
            <td rowspan="2" width="3%">Sl.No</td>
            <td rowspan="2" width="13%">Particulars</td>
            <td >Slopes</td>
          </tr>
          <tr align="center"  class="dataheader"> 
          <%if(landdevelopslope !=null){
          if(landdevelopslope.equalsIgnoreCase("1"))
        	  {
        	  landdevelopslope="0-1%";
        	  }
        	  else if(landdevelopslope.equalsIgnoreCase("2"))
        	  {
        		  landdevelopslope="1-2%";
        	  }
        	  else if(landdevelopslope.equalsIgnoreCase("3"))
        	  {
        		  landdevelopslope="Above 2 to 3%";
        	  }
        	  else 
        	  {
        		  landdevelopslope="";
        	  }
        	  }%>
            <td width="7%" > <%=landdevelopslope%></td>
<!--            <td width="7%" id="slope2">1-2%</td>-->
<!--            <td width="16%" id="slope3">Above 2 to 3%</td>-->
          </tr>
          
          
          <tr class="dataheader" align="center"> 
           
           <td colspan="5" align="center"><b> Cost / Acre</b></td>
          </tr>
          
          <%for(int i=0;i<11;i++)
				{ 
        	  
        	  	int arrColSize=0;
				if(i<arrSize)
				{
					arrCol=(ArrayList)arrRow.get(i);
					if(arrCol!=null)
						arrColSize=arrCol.size();
					//out.println("arrCol===="+arrCol);
				}
        	  if(arrColSize>0)
        	  {%>
          <tr class="dataGridColor" align="center"> 
            <td nowrap align="center" width="3%"><%= strslno[i]%> </td>
            <td nowrap align="left" width="7%" ><%= strDesc[i]%> 
              <input type="hidden" name="txt_desc" value="<%= strDesc[i]%>">
            </td>
            <td width="15%"> 
              <input type="text" maxlength="15" name="txt_slope1"  onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeTotal();"
													<%if(i==11 || i==12 || i==13 || i==15){%>
													size="13"  style="text-align: right;background-color:#e7edf8;border-style:none; color:#000000;font-weight:bold;"
													<% }else{%> 
													style="text-align: right" size="15"
													<%} %>
													value="<%=Helper.checkDecimal((String)arrCol.get(2))%>">
            </td>
<!--            <td width="15%"> 
              <input type="text" maxlength="15" name="txt_slope2" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeTotal();"
													<%//if(i==10 || i==11 || i==12 || i==14){%>
													size="13"  style="text-align: right;background-color:#e7edf8;border-style:none; color:#000000;font-weight:bold;"
													<% //}else{%> 
													style="text-align: right" size="15"
													<%//} %>
													
													 value="">
          </td>
           <td width="15%"> 
             <input type="text" maxlength="15" name="txt_slope3" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeTotal();"
													<%//if(i==10 || i==11 || i==12 || i==14){%>
													size="13"  style="text-align: right;background-color:#e7edf8;border-style:none; color:#000000;font-weight:bold;"
													<%// }else{%> 
													style="text-align: right" size="15"
													<%//} %> value="">
          </td>-->
          </tr>
          <%   if(i==6) {
				%>
          <tr class="dataGridColor" align="center"> 
            <td>&nbsp;</td>
            <td colspan="4" align="left"><b>Structures</b></td>
          </tr>
          <%}  %>
          <%}else{
        %>
          <tr class="dataGridColor" align="center"> 
            <td nowrap align="center" width="3%"><%= strslno[i]%> </td>
            <td nowrap align="left" width="7%" ><%= strDesc[i]%> 
              <input type="hidden" name="txt_desc" value="<%= strDesc[i]%>">
            </td>
            <td width="15%"> 
              <input type="text" maxlength="15" name="txt_slope1" size="15" onKeyPress="allowNumber(this)"
														 onBlur="roundtxt(this);computeTotal();"
													style="text-align: right" value="">
            </td>
            <!--  <td width="15%"> 
              <input type="text" maxlength="15" name="txt_slope2" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeTotal();"
													style="text-align: right" value="">
            </td>
            <td width="15%"> 
              <input type="text" maxlength="15" name="txt_slope3" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeTotal();"
													style="text-align: right" value="">
            </td>-->
          </tr>
          <%   if(i==6) {
				%>
          <tr class="dataGridColor" align="center"> 
            <td>&nbsp;</td>
            <td colspan="4" align="left"><b>Structures</b></td>
          </tr>
          <%}   %>
          
          <%} %>
          <%}
       %>
	 
        </table>
      </td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="1">
    <tr valign="top"> 
      <td><lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' btnnames='Edit_Save_Cancel_Delete'/></td>
    </tr>
  </table>
  <br>
  <input type=hidden name="hidBeanId">
  <input type=hidden name="hidBeanMethod">
  <input type=hidden name="hidBeanGetMethod">
  <input type=hidden name="hidSourceUrl">
  <input type="hidden" name="hidAction">
  <input type="hidden" name="hid_pagename" value="">
  <input type="hidden" name="hidAppType" value="<%=Helper.correctNull((String) hshValues.get("hidAppType"))%>">
 <input type="hidden" name="landdevelopslope" value="<%=Helper.correctNull((String) hshValues.get("agr_landdevelop_slope"))%>"></input>
 <input type="hidden" name="strschemetypeno" value="<%=strschemetypeno%>"> 
</form>
</body>
</html>