<%@ include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">

<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";

var selsno="<%=Helper.correctNull((String) hshValues.get("selsno"))%>";

function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16)
{
	
	document.forms[0].selsno.value=val1;
	//document.forms[0].sel_activityname.value=val2;
	if(!val2=="")
	 {
	 document.forms[0].hidoldactivity.value="y";
	 document.forms[0].sel_activityname.value=val2;
//document.getElementById("new_Act").style.display="table-row";
//alert("=====111111111111===val2======="+val2);

//alert("=====111111111111===document.forms[0].sel_activityname.value======="+document.forms[0].sel_activityname.value);
//document.getElementById("new_Act").style.display="table-row";
//document.getElementById("new_Act1").style.display="none";
	 }
	
	//alert("========document.forms[0].sel_activityname.value======="+document.forms[0].sel_activityname.value);
	
	//hidoldactivity
	 if(!val3=="")
		 {
		 document.forms[0].hidoldactivity.value="y";
	
	//document.getElementById("old_scheme").style.display="table-row";
//alert("=====111111111111===document.forms[0].txt_activity.value======="+document.forms[0].txt_activity.value);
	
	//document.getElementById("new_scheme").style.display="none";
	
		 }
	document.forms[0].sel_applicable.value=val4;
	document.forms[0].txt_rangefrom.value=val5;
	document.forms[0].txt_rangeto.value=val6;
	document.forms[0].txt_years.value=val7;
	document.forms[0].txt_secondactivity.value=val8;
	document.forms[0].txt_secondunitcost.value=val9;
	document.forms[0].sel_secondyear.value=val10;
	document.forms[0].sel_Action.value=val11;
	
	
	 if(!val12=="")
		 {
		 document.forms[0].hidoldactivity.value="n";
	//document.forms[0].txt_activity.value=val12;
	//document.getElementById("new_scheme").style.display="table-row";
//	alert("=====2222222222222===document.forms[0].txt_activity.value======="+document.forms[0].txt_activity.value);

	//document.getElementById("old_scheme").style.display="none";
		 }
	document.forms[0].txt_rangeper.value=val13;
	document.forms[0].txt_datefrom.value=val14;
	document.forms[0].txt_dateto.value=val15;
	document.forms[0].sel_state.value=val16;
//	alert("document.forms[0].sel_state.value=val16========"+document.forms[0].sel_state.value);
//	alert("=============val3============="+val3);
	onloadvaluesload(val2,val16,val3,val12,'ACT');
	
	if(!val3=="")
	 
	{
		//document.forms[0].txt_activity.text = val3;
		
		
	//	document.getElementById("new_Act1").style.display="table-row";
	//    document.getElementById("new_Act").style.display="none";
	   // showmainactivitylist(val2,val16);
	   
	    document.forms[0].txt_activity.value = val3;
	    
	   // document.forms[0].txt_activity.text=val3;
		//document.forms[0].txt_activity.value=val3;
		
// 		for(var i=0;i<document.forms[0].txt_activity.options.length;i++)
// 		{
// 		if(document.forms[0].txt_activity.options[i].value==val3)
// 			{	
// 			alert("************");
			
// 				document.forms[0].sel_reason.options[i].selected=true;

// 				break;
// 			}
		//}
	    //document.forms[0].txt_activity.text = val3;
//	    alert("document.forms[0].txt_activity.value===="+document.forms[0].txt_activity.value);
	}
	else
	{
		
//		alert("222222222");
		//document.forms[0].txt_activity.value = "0";
	}
//	alert("=====2222222222222===document.forms[0].txt_activity.value======="+document.forms[0].txt_activity.value);
	
	//showmainSpecificationsdetails();
	
//	alert("=============val12============="+val12);
	
	onloadvaluesload(val2,val16,val3,val12,'SPEC');
	if(!val12=="")
		 
	{
		document.forms[0].sel_specifications.value = val12;
		//alert("=======1");
	}
	else
	{
		document.forms[0].sel_specifications.value = "0";
		//alert("=======2");
	}
	//alert("=====2222222222222===document.forms[0].sel_specifications.value======="+document.forms[0].sel_specifications.value);
	
	showranges();
	showranges2();
	disableNewButtons(true,false,true,true,false,false);
	disableFields(true);
}

function callonLoad()
{	
	document.getElementById("range").style.display="none";
	disableNewButtons(false,true,true,true,true);	
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
	document.forms[0].sel_activityname.disabled=one;
	document.forms[0].sel_applicable.disabled=one;
	document.forms[0].sel_secondyear.disabled=one;
	document.forms[0].sel_Action.disabled=one;
	
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
	
	if(document.forms[0].sel_activityname.value=="0")
	{
		alert("Select a Scheme");
		document.forms[0].sel_activityname.focus();
		return false;
	}
	if(document.forms[0].txt_activity.value=="")
	{
		alert("Enter Activity Name");
		document.forms[0].txt_activity.focus();
		return false;
	}
	if(document.forms[0].sel_applicable.value=="0")
	{
		alert("Select Whether Applicable");
		document.forms[0].sel_applicable.focus();
		return false;
	}
	if(document.forms[0].sel_applicable.value=="Y")
	{
		if(document.forms[0].txt_rangefrom.value=="")
		{
			alert("Enter Range From");
			document.forms[0].txt_rangefrom.focus();
			return false;
		}
		if(document.forms[0].txt_rangeto.value=="")
		{
			alert("Enter Range to");
			document.forms[0].txt_rangeto.focus();
			return false;
		}
		if(document.forms[0].sel_secondyear.value=="0")
		{
			alert("Select Whether Unit cost available from 2nd Year");
			document.forms[0].sel_secondyear.focus();
			return false;
		}
	}
	if(document.forms[0].sel_secondyear.value=="Y")
	{
		if(document.forms[0].txt_years.value=="")
		{
			alert("Enter Years upto");
			document.forms[0].txt_years.focus();
			return false;
		}
		if(document.forms[0].txt_secondunitcost.value=="")
		{
			alert("Enter Unit cost from 2nd Year");
			document.forms[0].txt_secondunitcost.focus();
			return false;
		}
	}
	if(document.forms[0].sel_Action.value=="")
	{
		alert("Select Action");
		return;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanMethod.value="updateActivityMasterData";
	document.forms[0].hidBeanGetMethod.value="getActivityMasterData";
	document.forms[0].hidSourceUrl.value="/action/activitymaster.jsp";
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
// 		document.forms[0].action=appURL+"controllerservlet";
// 		document.forms[0].hidBeanId.value="staticdata";
// 		document.forms[0].hidBeanGetMethod.value="getActivityMasterData";
// 		document.forms[0].hidSourceUrl.value="/action/activitymaster.jsp";		
// 		document.forms[0].submit();
		
		document.forms[0].hidBeanId.value="staticdata";
		//document.forms[0].hidBeanMethod.value="updateActivityMasterData";
		document.forms[0].hidBeanMethod.value="getActivityMasterData";
		document.forms[0].hidSourceUrl.value="/action/activitymaster.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
		
	}
}

function doNew() 
{
	document.forms[0].hidAction.value="insert";
	disableNewButtons(true, true, false, true, false, true);
	disableFields(false);   
}

function doEdit() 
{
	if(document.forms[0].sel_activityname.value=="0")
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
   	disableNewButtons(true, true, false, false, false, true);
   	disableFields(false);
	
}
 function doDelete() 
   {
   	if( ConfirmMsg(101))
	{
   		document.forms[0].hidAction.value="delete";
   		document.forms[0].hidBeanId.value="staticdata";
   		document.forms[0].hidBeanMethod.value="updateActivityMasterData";
   		document.forms[0].hidBeanGetMethod.value="getActivityMasterData";
   		document.forms[0].hidSourceUrl.value="/action/activitymaster.jsp";
   		document.forms[0].action=appURL+"controllerservlet";
   		document.forms[0].submit();
	}
}  
 function disableNewButtons(bool1, bool2, bool3, bool4, bool5, bool6, bool7)
 {
 	document.forms[0].cmdnew.disabled=bool1;
 	document.forms[0].cmdedit.disabled=bool2;
 	document.forms[0].cmdsave.disabled=bool3;
 	document.forms[0].cmdcancel.disabled=bool5;
 	document.forms[0].cmddelete.disabled=bool4;
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

function showranges()
{
	if(document.forms[0].sel_applicable.value=="Y")
	{
		document.getElementById("range").style.display="table-row";
	}
	else
	{
		document.getElementById("range").style.display="none";
	}
}

function showranges2()
{
	if(document.forms[0].sel_secondyear.value=="Y")
	{
		document.getElementById("yr1").style.display="table-row";
		document.getElementById("yr2").style.display="table-row";
	}
	else
	{
		document.getElementById("yr1").style.display="none";
		document.getElementById("yr2").style.display="none";
	}
}

function checkranges()
{
	var rangefrom = document.forms[0].txt_rangefrom.value;
	var rangeto = document.forms[0].txt_rangeto.value;
	if((eval(rangeto)<eval(rangefrom))&&eval(rangefrom!=""))
	{
		alert("Range to value should be greater than Range from value");
		document.forms[0].txt_rangeto.value="";
		//document.forms[0].txt_rangeto.focus();
		return;
	}
}



function showmainactivitylist(val2,val16)
{	
	
	//txt_activity sel_activityname sel_state sel_specifications
	//alert("inside 2222222222222222222222");
	//alert("val2========="+val2+"====val16======"+val16);
	var sel_activityname=val2;
	var sel_state=val16;
	
	
	document.all.ifrm1.src=appURL+"action/agr_activityname.jsp?hidBeanId=staticdata&hidBeanGetMethod=getActivityDetails&strtype=Actname&sel_activityname="+sel_activityname+"&sel_state="+sel_state;
	
	//document.all.ifrmcheckduplicate.src = appURL+"action/ifrmcersaiIDcheckduplicate.jsp?hidBeanGetMethod=getcersaiIDCheckDuplicate&hidBeanId=securitymaster&strPage=Prop&strrowindexname=txt_operativeaccno&strAccNo="+document.forms[0].txt_existacc.value;
	//alert("end");
 }
 
function showmainactivitylist()
{	
	
	//txt_activity sel_activityname sel_state sel_specifications
	//alert("inside");
	var sel_activityname=document.forms[0].sel_activityname.value;
	var sel_state=document.forms[0].sel_state.value;
	
	
	document.all.ifrm1.src=appURL+"action/agr_activityname.jsp?hidBeanId=staticdata&hidBeanGetMethod=getActivityDetails&strtype=Actname&sel_activityname="+sel_activityname+"&sel_state="+sel_state;
	
	//document.all.ifrmcheckduplicate.src = appURL+"action/ifrmcersaiIDcheckduplicate.jsp?hidBeanGetMethod=getcersaiIDCheckDuplicate&hidBeanId=securitymaster&strPage=Prop&strrowindexname=txt_operativeaccno&strAccNo="+document.forms[0].txt_existacc.value;
	//alert("end");
 }
 
function showmainSpecificationsdetails()
{	
	
	//txt_activity sel_activityname sel_state sel_specifications
	//alert("inside");
	var sel_activityname=document.forms[0].sel_activityname.value;
	var sel_state=document.forms[0].sel_state.value;
	var txt_activity=document.forms[0].txt_activity.value;
	document.all.ifrm1.src=appURL+"action/agr_activityname.jsp?hidBeanId=staticdata&hidBeanGetMethod=getActivityDetails&strtype=Specname&sel_activityname="+sel_activityname+"&sel_state="+sel_state+"&txt_activity="+txt_activity;
	
	
 }    
function showactivitydetails()
{
	var sel_activityname=document.forms[0].sel_activityname.value;
	var sel_state=document.forms[0].sel_state.value;
	var txt_activity=document.forms[0].txt_activity.value;
			var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
			var url=appURL+"action/ActivityMasterList.jsp?hidBeanId=staticdata&hidBeanGetMethod=getActivitySpecificationbtdetails&hidAction=search&strfrom=activityname&sel_activityname="+sel_activityname+"&sel_state="+sel_state+"&txt_activity="+txt_activity;
			window.open(url,"",prop);	
}
	
function showSpecificationsdetails()
{
	var sel_activityname=document.forms[0].sel_activityname.value;
	var sel_state=document.forms[0].sel_state.value;
	var txt_activity=document.forms[0].txt_activity.value;
	var sel_specifications=document.forms[0].sel_specifications.value;
	var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
	var url=appURL+"action/Specificationmasterlist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getActivitySpecificationbtdetails&hidAction=search&strfrom=specifications&sel_activityname="+sel_activityname+"&sel_state="+sel_state+"&txt_activity="+txt_activity+"&sel_specifications="+sel_specifications;
	window.open(url,"",prop);		
		
}

function onloadvaluesload(val1,val2,val3,val4,val5)
{
	var sel_activityname=val1;
	var sel_state=val2;
	var txt_activity=val3;
	var sel_specifications=val4;
	var flagfor=val5;
	
	document.all.ifrmsancbranch.src=appURL+"action/iframeagrimastervaluesselect.jsp?hidBeanId=staticdata&hidBeanGetMethod=getDetailsActivitySpecifications&sel_activityname="+sel_activityname+"&sel_state="+sel_state+"&txt_activity="+txt_activity+"&sel_specifications="+sel_specifications+"&stype="+flagfor;
}

</script>



</head>
<body onload="callonLoad()">
<form name="frmgoldrate" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td class="page_flow">Home -&gt; Master -&gt; Activity Master</td>
</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
<tr>
	<td>
		<jsp:include page="../set/mastertab.jsp" flush="true">
		<jsp:param name="tabid" value="20" />
		</jsp:include>
	</td>
</tr>
</table>
<br>


<table width="95%" border="0" cellpadding="2" cellspacing="0"
	align="center" class="outertable border1 tableBg">
	<tr>
		<td>
		<br>
		<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td width="30%">Scheme<span class="mantatory">*</span></td>
<!-- 				<td   width="70%"  id="old_scheme"> -->
<!-- 				<select name="sel_activityname"> -->
<!-- 			<option value="0" selected>--- Select ---</option> -->
<!-- 				<option title="Kisan Credit Card Scheme" value="aQ">Kisan Credit Card Scheme</option>  -->
<!-- 				<option title="Farm Development" value="aV">Farm Development</option> -->
<!--  				<option title="Minor Irrigation" value="aO">Minor Irrigation</option>  -->
<!--  				<option title="Farm Mechanisation" value="aM">Farm Mechanisation</option>  -->
<!-- 				<option title="Financing of Bullock Cart" value="aT">Financing of Bullock / Cart</option>  -->
<!-- 				<option title="Sericulture" value="aI">Sericulture</option> -->
<!--  				<option title="Tobacco Financing" value="aB">Tobacco Financing</option>  -->
<!--  				<option title="Plantation & Horticulture" value="aH">Plantation & Horticulture</option>  -->
<!-- 				<option title="Farm Forestry" value="aY">Farm Forestry</option>  -->
<!--  				<option title="Diary Farming" value="aD">Diary Farming</option>  -->
<!-- 				<option title="Poultry Development" value="aE">Poultry Development</option>  -->
<!--  				<option title="Allied Activity" value="aR">Allied Activity</option> -->
<!--  				<option title="Gobar Gas plant" value="aN">Gobar Gas plant</option> -->
<!-- 				<option title="Financing Fisheries" value="aJ">Financing Fisheries</option>  -->
<!--  				<option title="Self Help Group" value="aS">Self Help Group</option>  -->
<!--  				<option title="Advance Against Warehouse Receipt" value="aK">Advance Against Warehouse Receipt</option> -->
<!-- 				<option title="KCC (Restructure)" value="aC">KCC (Restructure)</option>  -->
<!-- 				</select>  -->
<!-- </td> -->
<!-- <td width="70%"  id="new_scheme"> -->
<td width="70%">
<select name="sel_activityname">
 <option selected value="0">-------------------Select---------------------</option>
                                                   
														 <%String apptypecon = "285";%>
                                                   <lapschoice:StaticDataNewTag apptype='<%=apptypecon%>' />
                                                  </select>
				</td>
			</tr>
			<tr>
			<td>Select State</td>
						<td width="25%" nowrap><b><select name="sel_state" onchange="showmainactivitylist();">
						 <option value="" selected="selected">&lt;----Select----&gt;</option>  
						<lapschoice:stateflexmaster />                   
						</select> </b></td>
			</tr>
			<tr>
				<td>Activity Name<span class="mantatory">*</span></td>
				
				
				<td>
				
				<select  name="txt_activity" onclick="showmainSpecificationsdetails()">
				 <option value="0" selected="selected">&lt;----Select----&gt;</option>  
<%-- 				 <lapschoice:StaticDataAgriUnitCostMastTag apptype='document.forms.sel_activityname.value'  page='document.forms.sel_state.value'/> --%>
                                </select>
                       
                          
				
				<input type="button"   
					name="bt1" value="Add New Activity Name" size="35" onclick="showactivitydetails();"></td>
					
<!-- 					<td id="new_Act1"> -->
<!-- 														<select name="txt_activity"> -->
<!-- 														<option value="0">--Select--</option> -->
<%-- 														 <% apptypecon = "286";%> --%>
<%--                                                    <lapschoice:StaticDataAgriUnitCostMastTag apptype='<%=apptypecon%>' /> --%>
<!-- 														</select> -->
														
<!-- 														<input type="button"    -->
<!-- 					name="bt1" value="Add New Activity Name" size="35" onclick="showactivitydetails();"></td> -->
													
					
<!-- 					<td id="new_Act1"> -->
<!-- 					<input type="text"   -->
<!-- 								name="txt_activity" value="" /> -->
								
<!-- 								<input type="button"    -->
<!-- 					name="bt1" value="Add New Activity Name" size="35" onclick="showactivitydetails();"></td> -->
													   
			</tr>
			
			<tr>
				<td>Specifications<span class="mantatory">*</span></td>
				<td>
 				<select name="sel_specifications"> 
 				 <option value="" selected="selected">&lt;----Select----&gt;</option>  
<!-- 				<option value="0" selected>--- Select ---</option> -->
<!-- 				<option title="Kisan Credit Card Scheme" value="aQ">Kisan Credit Card Scheme</option> -->
<!-- 				<option title="Farm Development" value="aV">Farm Development</option> -->
<!-- 				<option title="Minor Irrigation" value="aO">Minor Irrigation</option> -->
<!-- 				<option title="Farm Mechanisation" value="aM">Farm Mechanisation</option> -->
<!-- 				<option title="Financing of Bullock Cart" value="aT">Financing of Bullock / Cart</option> -->
<!-- 				<option title="Sericulture" value="aI">Sericulture</option> -->
<!-- 				<option title="Tobacco Financing" value="aB">Tobacco Financing</option> -->
<!-- 				<option title="Plantation & Horticulture" value="aH">Plantation & Horticulture</option> -->
<!-- 				<option title="Farm Forestry" value="aY">Farm Forestry</option> -->
<!-- 				<option title="Diary Farming" value="aD">Diary Farming</option> -->
<!-- 				<option title="Poultry Development" value="aE">Poultry Development</option> -->
<!-- 				<option title="Allied Activity" value="aR">Allied Activity</option> -->
<!-- 				<option title="Gobar Gas plant" value="aN">Gobar Gas plant</option> -->
<!-- 				<option title="Financing Fisheries" value="aJ">Financing Fisheries</option> -->
<!-- 				<option title="Self Help Group" value="aS">Self Help Group</option> -->
<!-- 				<option title="Advance Against Warehouse Receipt" value="aK">Advance Against Warehouse Receipt</option> -->
<!-- 				<option title="KCC (Restructure)" value="aC">KCC (Restructure)</option> -->

														
				</select>
				
				<input type="button"
					name="bt2" value="Add New Specifications" size="35" onclick="showSpecificationsdetails();"></td>
			</tr>
			
			<tr>
				<td>Whether Unit cost available<span class="mantatory">*</span></td>
				<td>
				<select name="sel_applicable" onChange="showranges()">
				<option value="0" selected>- Select -</option>
				<option value="Y">Yes</option>
				<option value="N">No</option>
				</select>
				</TD>
		  	</tr>
		  	<tr id="range">
		  		<td colspan="2">
					<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
		  				<tr>
		  					<td width="30%">Unit Cost for 1st Year<span class="mantatory">*</span></td>
		  					<td width="20%"><input type="text" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);checkranges();"
								name="txt_rangefrom" value="" style="text-align: right"></td>
		  					<td width="15%">Range to<span class="mantatory">*</span></td>
		  					<td width="35%"><input type="text" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);checkranges()"
								name="txt_rangeto" value="" style="text-align: right"></td>
								
								<td width="15%">Range (%)<span class="mantatory">*</span></td>
		  					<td width="35%"><input type="text" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);checkPercentage(this);"
								name="txt_rangeper" style="text-align: right" value=""> (%)</td>
						</tr>
						<tr>
						
						</tr>
						<tr>
							<td>Whether Unit cost available from 2nd Year <span class="mantatory">*</span> </td>
								<td colspan="3">
								<select name="sel_secondyear" onChange="showranges2()">   
									<option value="0" selected>- Select -</option>
									<option value="Y">Yes</option>
									<option value="N">No</option>
								</select>
							</td>						
						</tr>
						<tr id="yr1">
							<td>Years Upto<span class="mantatory">*</span></td>
							<td> <input type="text" name="txt_years"></td>
							<td>Unit cost from 2nd Year<span class="mantatory">*</span></td>
							<td> <input type="text" name="txt_secondunitcost" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"
							value="" style="text-align: right"></td>
						</tr>
						<tr id="yr2">
							<td> Activity name from 2nd Year</td>
							<td colspan="3"><input type="text" name="txt_secondactivity" size="35"></td>
						</tr>
		  </table>
		  
		  <tr>
		  					<td width="30%">Start Date<span class="mantatory">*</span></td>
		  					<td width="20%"><input type="text" 
								name="txt_datefrom" value="" onBlur="checkDate(this);checkmaxdate(this,currentDate);">
                      <a href="#"
							onClick="callCalender('txt_datefrom')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a></td>
		  					<td width="15%">End Date<span class="mantatory">*</span></td>
		  					<td width="35%"><input type="text" 
								name="txt_dateto" value="" onBlur="checkDate(this);checkminequaldate(this,currentDate);">
                      </td>
                      <td><a href="#"
							onClick="callCalender('txt_dateto')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"    
							border="0"></a></td>
						
						</tr>
						
		  <tr>
                     <td>Action<span class="mantatory">*</span></td>
                     <td><select name="sel_Action">
                     <option value="">--Select--</option>
                     <option value="E">Enabled</option>
                     <option value="D">Disabled</option></select></td>
                     </tr>
		  <br>
		  </td>
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

<table width="80%" border="0" cellspacing="0" cellpadding="1" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="5">
			<tr class="dataheader">
				<td width="5%">&nbsp;</td>
				<td width="30%" align="center">Scheme</td>
				<td width="25%" align="center">Activity Name</td>
				<td width="10%" align="center">Applicable</td>
				<td width="15%" align="center">Range from</td>
				<td width="15%" align="center">Range to</td>
			</tr>
		</table>
</td></tr>
<tr><td>
		<table width="100%" border="0" cellspacing="1" cellpadding="1" >
			<%if (arrData.size()>0) {
				vecsize = arrData.size();
				String strSno = "";
				String strallow = "";
				String strscheme = "";
				for (int i = 0; i < vecsize; i++) {
					arrRow = (ArrayList) arrData.get(i);
				//	out.println("=========arrRow================"+arrRow);
					if (arrRow != null) {
						strSno = Helper.correctNull((String) arrRow.get(0));
						if(Helper.correctNull((String) arrRow.get(3)).equalsIgnoreCase("Y"))
							strallow="Yes";
						else strallow="No";
						
						if(Helper.correctNull((String) arrRow.get(18)).length()>3)
						{
							strscheme =Helper.correctNull((String) arrRow.get(18));
						}
						
						else
						{
						if(Helper.correctNull((String) arrRow.get(1)).equalsIgnoreCase("aQ"))
							strscheme ="Kisan Credit Card Scheme";
						if(Helper.correctNull((String) arrRow.get(1)).equalsIgnoreCase("aV"))
							strscheme ="Farm Development";
						if(Helper.correctNull((String) arrRow.get(1)).equalsIgnoreCase("aM"))
							strscheme ="Farm Mechanisation";
						if(Helper.correctNull((String) arrRow.get(1)).equalsIgnoreCase("aT"))
							strscheme ="Financing of Bullock Cart";
						if(Helper.correctNull((String) arrRow.get(1)).equalsIgnoreCase("aI"))
							strscheme ="Sericulture";
						if(Helper.correctNull((String) arrRow.get(1)).equalsIgnoreCase("aB"))
							strscheme ="Tobacco Financing";
						if(Helper.correctNull((String) arrRow.get(1)).equalsIgnoreCase("aH"))
							strscheme ="Plantation & Horticulture";
						if(Helper.correctNull((String) arrRow.get(1)).equalsIgnoreCase("aY"))
							strscheme ="Farm Forestry";
						if(Helper.correctNull((String) arrRow.get(1)).equalsIgnoreCase("aD"))
							strscheme ="Diary Farming";
						if(Helper.correctNull((String) arrRow.get(1)).equalsIgnoreCase("aE"))
							strscheme ="Poultry Development";
						if(Helper.correctNull((String) arrRow.get(1)).equalsIgnoreCase("aR"))
							strscheme ="Allied Activity";
						if(Helper.correctNull((String) arrRow.get(1)).equalsIgnoreCase("aN"))
							strscheme ="Gobar Gas plant";
						if(Helper.correctNull((String) arrRow.get(1)).equalsIgnoreCase("aJ"))
							strscheme ="Financing Fisheries";
						if(Helper.correctNull((String) arrRow.get(1)).equalsIgnoreCase("aS"))
							strscheme ="Self Help Group";
						if(Helper.correctNull((String) arrRow.get(1)).equalsIgnoreCase("aO"))
							strscheme ="Minor Irrigation";
						if(Helper.correctNull((String) arrRow.get(1)).equalsIgnoreCase("aK"))
							strscheme ="Advance Against Warehouse Receipt";
						if(Helper.correctNull((String) arrRow.get(1)).equalsIgnoreCase("aC"))
							strscheme ="KCC (Restructure)";
						}
					%>
			<tr align="center" class="datagrid">
				<td width="5%"><input type="radio" name="sno"
					style="border-style: none"
					onClick="selectValues('<%=Helper.correctNull((String) arrRow.get(0))%>', 
											'<%=Helper.correctNull((String) arrRow.get(1))%>',
											'<%=Helper.correctNull((String) arrRow.get(2))%>',
											'<%=Helper.correctNull((String) arrRow.get(3))%>',
											'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrRow.get(4))))%>',
											'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrRow.get(5))))%>',
											'<%=Helper.correctNull((String) arrRow.get(6))%>',
											'<%=Helper.correctNull((String) arrRow.get(7))%>',
											'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrRow.get(8))))%>',
											'<%=Helper.correctNull((String) arrRow.get(9))%>','<%=Helper.correctNull((String) arrRow.get(10))%>',
											'<%=Helper.correctNull((String) arrRow.get(11))%>','<%=Helper.correctNull((String) arrRow.get(12))%>',
											'<%=Helper.correctNull((String) arrRow.get(13))%>','<%=Helper.correctNull((String) arrRow.get(14))%>'
											,'<%=Helper.correctNull((String) arrRow.get(15))%>')">
				<input type="hidden" name="hid" value="<%=strSno%>"></td>
				<td width="30%" align="left"><%=strscheme%></td>
				<td width="25%" align="left"><%=Helper.correctNull((String) arrRow.get(16))%></td>
				<td width="10%" align="center"><%=strallow%></td>
				<td width="15%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrRow.get(4))))%></td>
				<td width="15%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrRow.get(5))))%></td>
			</tr>
			<%}}}
			else 
			{%>
			<tr class="datagrid">
				<td colspan="6" align="center">No Data Found</td>
			</tr>
			<%}	%>
					</table>
		</td>
	</tr>
</table>


<br>
<input type="hidden" name="hidsno" value="">
<input type="hidden" name="hidAction">
<input type="hidden" name="hidBeanMethod" value=""> 
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidSourceUrl">
<input type="hidden" name="hidBeanGetMethod"> 
<input type="hidden" name="hidcat_parent" value="0">
<input type="hidden" name="strStatId1" value=""> 
<input type="hidden" name="selsno" value="">
<input type="hidden" name="hidoldactivity"> 
<iframe	height="0" width="0" id="ifrm1" frameborder=0 style="border:0"></iframe>
<iframe height="0" width="0" id="ifrm2" frameborder=0 style="border:0"></iframe>
<iframe height="0" width="0" name="ifrmsancbranch" frameborder="0"
	style="border: 0"></iframe>
</form>
</body>
</html>
