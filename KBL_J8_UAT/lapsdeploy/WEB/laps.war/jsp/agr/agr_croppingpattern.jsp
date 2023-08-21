<%@include file="../share/directives.jsp"%>
<%String app_status = Helper.correctNull((String) hshValues
					.get("app_status"));
String PageType = Helper.correctNull((String)hshValues.get("PageType"));
ArrayList arryCol = null;
ArrayList arryRow = (ArrayList) hshValues.get("arryRow");
String schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
String strAppno=Helper.correctNull((String)request.getParameter("appno")) ;
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String employmentstatus=Helper.correctNull((String)request.getParameter("Employmentstatus"));
%>
<%
String[] strSeason={"Karif","Rabi"};
String[] strDevelopmentType={"pre","post"};
String strCropName="";
String[] arrCropName=null;
String strIrrigatedArea="";
String[] arrIrrigatedArea=null;
String strUnIrrigatedArea="";
String[] arrUnIrrigatedArea=null;

ArrayList vecData = new ArrayList();
ArrayList vecData1 = new ArrayList();
ArrayList vecRow = new ArrayList();
if (hshValues != null) {
	vecData = (ArrayList) hshValues.get("vecData1");
	vecData1 = (ArrayList) hshValues.get("vecData");
	if(vecData!=null){
		arrCropName=new String[vecData.size()];
		arrIrrigatedArea=new String[vecData.size()];
		arrUnIrrigatedArea=new String[vecData.size()];
		for(int i=0;i<vecData.size();i++){
			vecRow=(ArrayList)vecData.get(i);
			if(vecRow!=null){
				strCropName=Helper.correctNull((String)vecRow.get(3));
				arrCropName[i]=strCropName;
				strIrrigatedArea=Helper.correctNull((String)vecRow.get(4));
				arrIrrigatedArea[i]=strIrrigatedArea;
				strUnIrrigatedArea=Helper.correctNull((String)vecRow.get(5));
				arrUnIrrigatedArea[i]=strUnIrrigatedArea;
			}
		}
	}
}

%>
<html>
<head>
<title>Live Stock Details</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var schemetype="<%=schemetype%>";
var varfinancialyr="<%=Helper.correctNull((String)hshValues.get("sel_finyr"))%>";
var varcroptype="<%=Helper.correctNull((String)hshValues.get("sel_type"))%>";
var loantype="<%=Helper.correctNull((String)request.getParameter("apploantype"))%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varGrpRights="<%=(Helper.correctNull((String)session.getAttribute("strGroupRights"))).charAt(18)%>";
function callLink3(page,bean,method,pagetype)
{	
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidAction.value="";
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].hidpagetype.value=pagetype;
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}	
function callhelp()
{
	var varQryString = appUrl+"/jsp/perhlp/hlp_educourse.jsp";
	var title = "ApplicantDemographics";
	var prop = "scrollbars=no,width=600,height=450";	
	prop = prop + ",left=200,top=150";
	window.open(varQryString,title,prop);
}

function enableButtons(bool1,bool2, bool3, bool4, bool5, bool6,bool7)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
	document.forms[0].cmdcomments.disabled=bool7;
}

function callLink1(page,bean,method,hidcroptype)
{	
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidAction.value="";
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].hidcroptype.value=hidcroptype;
		document.forms[0].action=appUrl+"action/"+page;		
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}
function doNew()
{
	if(document.forms[0].sel_type.value=="")
	{
		alert("Select Type");
		document.forms[0].sel_type.focus();
		return;
	}
	document.forms[0].hidAction.value="insert";
	//clearFields();
	disabledFields(false);
	disablePageFields(true);
	disableEditButtons(true, true, false, false, true,false,false);
}
function disableEditButtons(bool1, bool2, bool3, bool4, bool5, bool6,bool7)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdcomments.disabled=bool6;
	document.forms[0].cmdclose.disabled=bool7;
}
function clearFields()
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].value="";
		}	
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].value="";
		}	   
		if(document.forms[0].elements[i].type=='select-one')
		{
			if(document.forms[0].elements[i].name!='sel_finyr')
			{
				document.forms[0].elements[i].value=0;
			}
		}
	}
}
function disablePageFields(flag)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].name=="txt_totalyield" 
			|| document.forms[0].elements[i].name=="txt_totalinc" ||
			document.forms[0].elements[i].name=="txt_totalcostofcultivation"  ||
			document.forms[0].elements[i].name=="txt_surplus" )
		{
		  document.forms[0].elements[i].readOnly=flag;		  
		}
	}
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
	//document.forms[0].schemetype.value=document.forms[0].sel_scheme.value;

}
function callLink(page,bean,method)
{	
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidAction.value="";
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appUrl+"action/"+page;		
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}

function doClose()
{
	if( ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/"+"persearch.jsp";
		document.forms[0].submit();
	}
}

function doSave()
{
	document.forms[0].sel_type.disabled=false;
	if(document.forms[0].sel_type.value=="")
	{
		alert("Select Type");
		document.forms[0].sel_type.focus();
		return;
	}
	if(document.forms[0].sel_finyr.value=="")
	{
		alert("Select Financial Year");
		return;
	}
	
	if(document.forms[0].sel_units.value=="")
	{
		alert("Select Units");
		document.forms[0].sel_units.focus();
		return;
	}
	if(document.forms[0].sel_unitsy.value=="")
	{
		alert("Select Units");
		document.forms[0].sel_unitsy.focus();
		return;
	}
	enableButtons( true, true, true, true, true,false,false);	
	document.forms[0].hidBeanId.value="agrcrops";
	document.forms[0].hidSourceUrl.value="/action/agr_croppingpattern.jsp";
	document.forms[0].hidBeanMethod.value="updateCroppingPatterns";
	document.forms[0].hidBeanGetMethod.value="getCroppingPatterns";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}


function doEdit()
{
 	disableFields(false);
 	document.forms[0].sel_type.disabled=true;
	document.forms[0].hidflag.value ="edit";
	document.forms[0].hidAction.value ="update";
	enableButtons(true, false, false, false, true,false,false);	
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		disabledFields(false);
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidBeanGetMethod.value="getCroppingPatterns";
		document.forms[0].action=appUrl+"action/agr_croppingpattern.jsp";
		document.forms[0].submit(); 	
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		disabledFields(false);
		document.forms[0].sel_season.disabled=false;
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updateCroppingPatterns";
		document.forms[0].hidBeanGetMethod.value="getCroppingPatterns";
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidSourceUrl.value="action/agr_croppingpattern.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}

function doComments()
{
	var btnenable=document.forms[0].btnenable.value;
	var hidDemoId=document.forms[0].hidDemoId.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidDemoId+"&hidCommentPage=cropincome&btnenable="+btnenable+"&appstatus="+appstatus;
	window.open(url,"Comments",prop);
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
	}	
}	

function onloading()
{	

	disableFields(true);

	if(document.forms[0].sel_type.value=="0")
	{
	enableButtons(true,true,true,true,true,false,false);
	}
	if(loantype=="A"){	
	//enableButtons(false,true,true,true,true);
    document.all.sel_scheme.disabled=false;
    document.all.sel_scheme.value=schemetype;
	}
	document.forms[0].sel_type.disabled=false;
	document.forms[0].cmdcomments.disabled=false;
	if(varcroptype!='')
	{
		document.forms[0].sel_type.value=varcroptype;
	}
	else
	{
		document.forms[0].sel_type.value="";
	}
	
	if(document.forms[0].sel_type.value=="1")
	{
		enableButtons(false,true,true,true,true,false,false);
		<%if(arryRow !=null && arryRow.size()>0){%>
			//document.forms[0].cmdnew.disabled=true;
		<%}%> 
	}
	if(document.forms[0].sel_type.value=="2")
	{
		enableButtons(false,true,true,true,true,false,false);
	}
	if(varGrpRights=='r')
	{
		document.forms[0].cmdnew.disabled = true;
	}
	
}

function call_page(url)
{	
	document.forms[0].action=appUrl+"action/"+url;
	document.forms[0].submit();	
}
function calculateTotalYield()
{
	document.forms[0].txt_totalyield.value = parseFloat(document.forms[0].txt_area.value)*
   											 parseFloat(document.forms[0].txt_yieldperacre.value);
	roundtxt(document.forms[0].txt_totalyield);
	document.forms[0].txt_totalyield.value=NanNumber(document.forms[0].txt_totalyield.value);
	calculateTotalIncome();
	calculateTotalCostOfCultivation();
	calculateSurplus();
	callTotincome();
}
function calculateTotalIncome()
{
	
	document.forms[0].txt_totalinc.value = parseFloat(document.forms[0].txt_totalyield.value)*
										   parseFloat(document.forms[0].txt_priceperquin.value);
	roundtxt(document.forms[0].txt_totalinc);
	document.forms[0].txt_totalinc.value=NanNumber(document.forms[0].txt_totalinc.value);
	
}
function callTotincome()
{
	document.forms[0].txt_totalincome.value=0;
	
		if(trim(document.forms[0].txt_totalinc.value)!="")
			document.forms[0].txt_totalincome.value= parseFloat(document.forms[0].txt_totalincome.value)+parseFloat(document.forms[0].txt_surplus.value);		
	
	roundtxt(document.forms[0].txt_totalincome);
	document.forms[0].txt_totalincome.value=NanNumber(document.forms[0].txt_totalincome.value);
}
function calculateTotalCostOfCultivation()
{
	
	document.forms[0].txt_totalcostofcultivation.value = parseFloat(document.forms[0].txt_costofcultivation.value)*
	  													 parseFloat(document.forms[0].txt_area.value);
	roundtxt(document.forms[0].txt_totalcostofcultivation);
	document.forms[0].txt_totalcostofcultivation.value=NanNumber(document.forms[0].txt_totalcostofcultivation.value);
	
	
}
function calculateSurplus()
{
	
	document.forms[0].txt_surplus.value = parseFloat(document.forms[0].txt_totalinc.value)-
										  parseFloat(document.forms[0].txt_totalcostofcultivation.value);
	roundtxt(document.forms[0].txt_surplus);
	document.forms[0].txt_surplus.value=NanNumber(document.forms[0].txt_surplus.value);
	
}
function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val13,val14,val15)
{
	disabledFields(true);
	disableEditButtons(true,false,true,true,false,false,false);

	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
	disableEditButtons(true,false,true,false,false,false,false);
		}
	document.forms[0].hid_sno.value=val11;
	document.forms[0].sel_season.value=val1;
	document.forms[0].txt_cropname.value=val2;
	document.forms[0].txt_area.value=val3;
	document.forms[0].txt_yieldperacre.value=val4;
	document.forms[0].txt_totalyield.value=val5;
	document.forms[0].txt_priceperquin.value=val6;
	document.forms[0].txt_totalinc.value=val7;
	document.forms[0].txt_costofcultivation.value=val8;
	document.forms[0].txt_totalcostofcultivation.value=val9;
	document.forms[0].txt_surplus.value=val10;
	document.forms[0].sel_type.disabled=false;
	if(loantype=="A")
	{
	document.all.sel_scheme.disabled=false;
	}
	document.forms[0].sel_finyr.value=val13;
	document.forms[0].sel_units.value=val14;
	changeLabel();
	document.forms[0].sel_unitsy.value=val15;
	changeLabel1();	
	if(varGrpRights=='r')
	{
		disableEditButtons(true,true,true,true,true,false,false);
	}
	
}
function callValues()
{
	document.forms[0].hidBeanId.value="agrcrops";
	document.forms[0].hidBeanGetMethod.value="getCroppingPatterns";
	document.forms[0].action=appUrl+"action/agr_croppingpattern.jsp";
	document.forms[0].submit(); 	
}

function changeLabel()
{
	if(document.forms[0].sel_units.selectedIndex == "")
	{
		document.all.al.innerHTML="Area<br>";
		document.all.cc.innerHTML="Cost of cultivation per ";
	}
	else
	{
		var varselunits = document.forms[0].sel_units.options[document.forms[0].sel_units.selectedIndex].text;
		document.all.al.innerHTML="Area<br>"+varselunits;
		document.all.cc.innerHTML="Cost of cultivation per "+varselunits;
	}
     	
}
function changeLabel1()
{


	if(document.forms[0].sel_unitsy.selectedIndex == "")
	{
		document.all.y1.innerHTML="Yield in<br>";
		document.all.y2.innerHTML="Total Yield<br>";
		document.all.y3.innerHTML="Price per<br>";
	}
	else
	{
		var varselunitsy = document.forms[0].sel_unitsy.options[document.forms[0].sel_unitsy.selectedIndex].text;
		document.all.y1.innerHTML="Yield in<br>"+varselunitsy;
		document.all.y2.innerHTML="Total Yield<br>"+varselunitsy;
		document.all.y3.innerHTML="Price per<br>"+varselunitsy;
	}
	
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
DIV.cellContainer {	
  width: 100%; height: 250;
  overflow: auto;
}
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onload="onloading()">
<form name="frmpri" method="post" class="normal">
<%
if(strSessionModuleType.equalsIgnoreCase("AGR"))
{ 
%>
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
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
      <td class="page_flow">Home -> Agriculture -> Application -> Income from Crops</td>
	</tr>
</table>
<span style="display:none;"> <lapschoice:borrowertype /> </span> <lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="60" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>
<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="8" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
      <td class="page_flow">Home -> Retail -> Application -> Income from Crops</td>
	</tr>
</table>
<span style="display:none;"> <lapschoice:borrowertype /> </span> <lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="60" />
		</jsp:include></td>
	</tr>
</table>
<%} %>
<jsp:include page="../share/help.jsp" flush="true"/>
<iframe height="0" width="0" id="ifrm" frameborder="0"
	style="border:0"></iframe> <span style="visibility:hidden"></span>
<table width="98%" border="0" cellspacing="0" cellpadding="5" align="center"  class="outertable border1">
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
			height="100%">
			<tr>
			<td valign="top">
			<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
			<tr>
			<td width="15%">
				Type
			</td>
			<td width="85%">
			<select name="sel_type" onchange="callValues();">
							<option value="" >--Select--</option>
							<option value="1">Existing</option>
							<option value="2">proposed</option>
							</select>
			</td>
			</tr>
			</table>
			</td>
		</tr>
		</table>
</td>
</tr>
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			height="100%">
			<tr>
				<td valign="top">
				
						<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
							<tr class="dataheader">
						        <td width="8%" align="Center" HEIGHT="56">Year&nbsp;<b><span class="mantatory">*&nbsp;</span></b></td>
								<td width="8%" align="Center" HEIGHT="56">Season</td>
								<td width="13%" align="Center" HEIGHT="56">Crop
								Name</td>
								<td width="5%" align="Center" HEIGHT="56">Units<br>&nbsp;&nbsp;&nbsp;(Area)&nbsp;<b><span class="mantatory">*&nbsp;</span></b></td>
								<td align="Center" WIDTH="8%" HEIGHT="56"><span id="al">Area</span></td>
								<td width="5%" align="Center" HEIGHT="56">Units<br>&nbsp;&nbsp;&nbsp;(Yield)&nbsp;<b><span class="mantatory">*&nbsp;</span></b></td>
								<td width="6%" align="Center" HEIGHT="56">
								<P><span id="y1">Yield in</span></P>
								</td>
								<td width="6%" align="Center" HEIGHT="56"><span id="y2">Total
								Yield</span></td>
								<td width="6%" align="Center" HEIGHT="56"><span id="y3">Price per
								</span> </td>
								<TD WIDTH="6%" ALIGN="Center" HEIGHT="56">Total
								Income </TD>
								<td width="9%" align="Center" HEIGHT="56"><span id="cc">Cost
								of cultivation</span></td>
								<td width="12%" align="Center" HEIGHT="56">Total
								cost of cultivation </td>
								<td width="16%" align="Center" HEIGHT="56">Surplus</td>
							</tr>
						
							<tr class="datagrid" align="center">
							<td align="center" WIDTH="8%">
							<select name="sel_finyr" >
							<% if(strSessionModuleType.equalsIgnoreCase("AGR"))
								{ %>
							 <lapschoice:FinYearTenorTag/>
							 <%}else{ %>
							 <option value="0">--Select--</option>
							 <option value="1">Year1</option>
							 <option value="2">Year2</option>
							 <option value="3">Year3</option>
							 <option value="4">Year4</option>
							 <option value="5">Year5</option>
							 <%} %>
							</select>
							</td>							
								<td align="center" WIDTH="8%"><select name="sel_season">
								   <option value="0" selected="selected" >--Select--</option>
                      				<lapschoice:StaticDataTag apptype="131"/> 
								</select></td>
								<td WIDTH="16%">
									<select name="txt_cropname" style="width:200" TABINDEX="22">
                      				<option value="0" selected="selected" >--Select--</option>
                     				 <lapschoice:StaticDataTag apptype="130"/> 
                    			</select></td>
                    			 <td align="center"><select name="sel_units" onchange="changeLabel()">
                    			 <option value="">--Select--</option>
                    			 <lapschoice:StaticDataNewTag apptype="135"/></select></td>
								<td WIDTH="8%"><INPUT TYPE="text" NAME="txt_area" SIZE="10" 
									VALUE=""
									ONKEYPRESS="allowNumber(this)" STYLE="text-align: right"
									onBlur="roundtxt(this);calculateTotalYield();"></td>
									 <td align="center"><select name="sel_unitsy" onchange="changeLabel1()">
                    			 <option value="">--Select--</option>
                    			 <lapschoice:StaticDataNewTag apptype="136"/></select></td>
								<td WIDTH="6%"><input type="text" name="txt_yieldperacre" 
									size="10"
									value=""
									onKeyPress="allowNumber(this)" style="text-align: right"
									onBlur="roundtxt(this);calculateTotalYield();"></td>
								<td WIDTH="6%"><input type="text" name="txt_totalyield"
									size="10"
									value=""
									onBlur="roundtxt(this);calculateTotalYield();"
									onKeyPress="allowNumber(this)" style="text-align: right"></td>
								<td WIDTH="6%"><input type="text" name="txt_priceperquin" 
									size="10"
									value=""
									onKeyPress="allowNumber(this)" style="text-align: right"
									onBlur="roundtxt(this);calculateTotalYield();"></td>
								<TD WIDTH="6%"><INPUT TYPE="text" NAME="txt_totalinc"
									SIZE="10"
									VALUE=""
									ONKEYPRESS="allowNumber(this)" STYLE="text-align: right"
									ONBLUR="roundtxt(this);calculateTotalYield();"></TD>
								<td WIDTH="6%"><INPUT TYPE="text" 
									NAME="txt_costofcultivation" SIZE="10" 
									VALUE=""
									ONKEYPRESS="allowNumber(this)" STYLE="text-align: right"
									onBlur="roundtxt(this);calculateTotalYield();callTotincome();"></td>
								<td WIDTH="15%"><INPUT TYPE="text"
									NAME="txt_totalcostofcultivation" SIZE="15"
									VALUE=""
									ONKEYPRESS="allowNumber(this)" STYLE="text-align: right"
									onBlur="roundtxt(this);calculateTotalYield();"></td>
								<td WIDTH="16%"><INPUT TYPE="text" NAME="txt_surplus"
									SIZE="15" VALUE="" ONKEYPRESS="allowNumber(this)" STYLE="text-align: right"
									onBlur="roundtxt(this);calculateTotalYield();"></td>
							</tr>
							
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr class="dataGridColor" >
								
								<td width="16%"><input type="hidden" name="txt_totalincome"
									size="15" onKeyPress="allowNumber(this)"
									style="text-align: right;background-color:#e7edf8;border-style: none;color:#000000;font-weight:bold;"
									value="<%=Helper.checkDecimal(Helper.correctNull((String) hshValues
							.get("total")))%>"
									onBlur=""></td>
								<td width="30%">&nbsp;</td>
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
	btnnames="New_Edit_Save_Cancel_Delete_Comments_Audit Trail"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<br>
<table width="98%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
<tr class="dataheader">
<td colspan="14" align="left">
<%if(Helper.correctNull((String)hshValues.get("sel_type")).equalsIgnoreCase("1")) { %>
Existing crops details
<%} else if(Helper.correctNull((String)hshValues.get("sel_type")).equalsIgnoreCase("2")) {%>
Proposed crops details
<%} %>
</td>
</tr>
	<tr class="dataheader">
		<td width="5%" align="center">&nbsp;</td>
		<td width="6%" align="center">&nbsp;Year</td>
		<td width="7%" align="center">&nbsp;Season</td>
		<td width="10%" align="center">&nbsp;Crop Name</td>
		<td width="6%" align="center">&nbsp;Unit</td>
		<td width="5%" align="center">&nbsp;Area</td>
		<td width="6%" align="center">&nbsp;Unit</td>
		<td width="7%" align="center">&nbsp;Yield</td>
		<td width="7%" align="center">&nbsp;Total Yield</td>
		<td width="7%" align="center">&nbsp;Price</td>
		<td width="9%" align="center">&nbsp;Total Income </td>
		<td width="10%" align="center">&nbsp;Cost of cultivation</td>
		<td width="10%" align="center">&nbsp;Total cost of cultivation</td>
		<td width="10%" align="center">&nbsp;Surplus</td>
	</tr>
	<%if(arryRow !=null && arryRow.size()>0){ 
		for(int i=0;i<arryRow.size();i++){
			arryCol=new ArrayList();
			arryCol=(ArrayList)arryRow.get(i);%>
	<tr class="datagrid">
		<td width="5%" align="center">&nbsp;<INPUT TYPE="radio" NAME="rd_butt" VALUE="" border="0" style="border: none;"
		onclick="selectValues('<%=Helper.correctNull((String)arryCol.get(10))%>','<%=Helper.correctNull((String)arryCol.get(1))%>',
		'<%=Helper.checkDecimal((String)arryCol.get(2))%>','<%=Helper.checkDecimal((String)arryCol.get(3))%>'
		,'<%=Helper.checkDecimal((String)arryCol.get(4))%>','<%=Helper.checkDecimal((String)arryCol.get(5))%>'
		,'<%=Helper.checkDecimal((String)arryCol.get(6))%>','<%=Helper.checkDecimal((String)arryCol.get(7))%>'
		,'<%=Helper.checkDecimal((String)arryCol.get(8))%>','<%=Helper.checkDecimal((String)arryCol.get(9))%>','<%=Helper.correctNull((String)arryCol.get(11))%>','<%=Helper.correctNull((String)arryCol.get(13))%>','<%=Helper.correctNull((String)arryCol.get(14))%>','<%=Helper.correctNull((String)arryCol.get(15))%>')"></td>
				
		<%
		String strexitype=Helper.correctNull((String)arryCol.get(13));
		String strexiprotyp=null;
		String strAreUnits="",strYeildUnit="";
		if(!strexitype.equalsIgnoreCase(""))
		{
			strexiprotyp="Year"+strexitype;
		}
		else
		{
			strexiprotyp="";
		}
			
			%>
						
		<td width="6%" align="center">&nbsp;<%=strexiprotyp%></td>
		<td width="7%" align="center">&nbsp;<%=Helper.correctNull((String)arryCol.get(0))%></td>
		<td width="10%" align="center">&nbsp;<%=Helper.correctNull((String)arryCol.get(12))%></td>
		<td width="6%" align="center">&nbsp;<%=Helper.correctNull((String)arryCol.get(16))%></td>
		<td width="5%" align="center">&nbsp;<%=Helper.checkDecimal((String)arryCol.get (2))%></td>
		<td width="6%" align="center">&nbsp;<%=Helper.correctNull((String)arryCol.get(17))%></td>
		<td width="7%" align="center">&nbsp;<%=Helper.checkDecimal((String)arryCol.get(3))%></td>
		<td width="7%" align="center">&nbsp;<%=Helper.checkDecimal((String)arryCol.get(4))%></td>
		<td width="7%" align="right">&nbsp;<%=Helper.checkDecimal((String)arryCol.get(5))%></td>
		<td width="9%" align="right">&nbsp;<%=Helper.checkDecimal((String)arryCol.get(6))%></td>
		<td width="10%" align="right">&nbsp;<%=Helper.checkDecimal((String)arryCol.get(7))%></td>
		<td width="10%" align="right">&nbsp;<%=Helper.checkDecimal((String)arryCol.get(8))%></td>
		<td width="10%" align="right">&nbsp;<%=Helper.checkDecimal((String)arryCol.get(9))%></td>
	</tr>
	<%} }%>
	
	
	<tr class="datagrid">
		<td colspan="12" align="right"><b>&nbsp;&nbsp;Existing Total</b></td>
		<td colspan="2" align="right"><b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues
							.get("Exis_Tootal"))))%></b></td>
	</tr>
	
	
	<tr class="datagrid">
		<td colspan="12" align="right"><b>&nbsp;&nbsp;Proposed Total</b></td>
		<td colspan="2"  align="right"><b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues
							.get("prop_Tootal"))))%></b></td>
	</tr>
	
	<tr class="datagrid">
		<td colspan="12" align="right"><b>&nbsp;&nbsp;Total</b></td>
		<td colspan="2"  align="right"><b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues
							.get("total"))))%></b></td>
	</tr>
</table>
<p>&nbsp;</p>
<input type="hidden" name="hidAction"> <input type="hidden"
			name="hidBeanId" value="agrcrops"> <input type="hidden"
			name="hidBeanMethod" value=""> <input type="hidden"
			name="hidBeanGetMethod" value=""> <input type="hidden"
			name="hidSourceUrl" value=""> <INPUT TYPE="hidden" name="hidApp_type"
			value="A">  <input
			type="hidden" name="hidflag" value=""> <input type="hidden"
			name="hideditflag"> <input type="hidden" name="selsno" value=""> <input
			type="hidden" name="hidval"> <input type="hidden" name="hiddesc"> <INPUT
			TYPE="hidden" name="trapEdit"> <INPUT TYPE="hidden" name="page"> <INPUT
			TYPE="hidden" name="hidCoDemoId"
			value="<%=request.getParameter("hidCoDemoId")%>"> <INPUT
			TYPE="hidden" name="hidDemoId"
			value="<%=request.getParameter("appno")%>"> 
		<INPUT
			TYPE="hidden" name="radLoan" value="Y"> 
			 <input type="hidden" name="app_status"
			value="<%=app_status%>">
			 <input type="hidden" name="hidcroptype"
			value="">  <input type="hidden" name="hidpagetype" value="<%=PageType %>">
			<input type="hidden" name="hid_sno" value="">
			<input type="hidden" name="hid_subvention" value="<%=Helper.correctNull((String)request.getParameter("hid_subvention"))%>">
</form>
</body>
</html>
