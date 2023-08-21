<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<lapschoice:handleerror />
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	String strInitialLoad = Helper.correctNull((String) request
			.getParameter("initial"));
	String applicantid = Helper.correctNull((String) hshValues
			.get("hidApplId"));
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();

	String strapptype = "";
	String apptype = "";
	String app_status = Helper.correctNull((String) hshValues
			.get("app_status"));
	String PageType = Helper.correctNull((String) hshValues
			.get("PageType"));
	String prd_type = Helper.correctNull((String) session
			.getAttribute("strProductType"));

	java.text.NumberFormat nf = java.text.NumberFormat
			.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	
	String schemetype="";
	schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
	String strappno = Helper.correctNull((String) request.getParameter("appno"));
	HashMap hshScheme = new HashMap();
	String facScheme="";
	hshScheme = Helper.splitScheme(schemetype);
	if(hshScheme!=null)
	{
		facScheme = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
	}	
%>
<html>
<head>
<title>LAPS - Agriculture Land Holdings</title>
<style>
.divCellContainer {
	width: 100%;
	height: 100px;
	overflow: auto;
}
</style>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varschemetype="<%=schemetype%>";
var varfacScheme="<%=facScheme%>";
function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12)
{
	
	document.forms[0].selsno.value = val1;
	document.forms[0].txt_plantname.value = val2;  
	document.forms[0].txt_maxplant.value = val3;
	document.forms[0].txt_cost.value = val5;
	document.forms[0].txt_yieldgrow.value = val6;
	document.forms[0].txt_startyield.value = val7;
	document.forms[0].txt_plantvariety.value = val8;
	document.forms[0].txt_saleprice.value = val9;

	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
	disableNewButtons(true, false, true, true, false, false, false);
		}
	document.forms[0].txt_totacre.value = roundVal(val10);
	document.forms[0].txt_incperacre.value = roundVal(val11);
	document.forms[0].sel_yieldunits.value = val12;
	
	// callbuttonStatus(document.forms[0].hidUsrMode, document.forms[0].hidWorkflowStatus, 'radio',document.forms[0].hidWorkflowId);
	//if(document.forms[0].hidMakerFlag.value=="Y")
	//{
//		disableNewButtons(true, false, true, true, false, false, false);
	//}
	//else
	//{
	//	disableNewButtons(true, true, true, true, true, true, false);
	//}
}
function disableNewButtons(bool1, bool2, bool3, bool4, bool5, bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
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
function callgrowperiod()
{
  if(parseFloat(document.forms[0].txt_yieldgrow.value) > 15)
  {
	  alert("Activity commences Cannot be Greater than 15 years")
	  document.forms[0].txt_yieldgrow.value ="";
	  document.forms[0].txt_yieldgrow.focus();
  }
  if(document.forms[0].txt_startyield.value=="0")
  {
		alert("Yielding Period commences from Should Not be Zero");
	    document.forms[0].txt_startyield.focus();
	    document.forms[0].txt_startyield.value="";
	    return;
  }
}

function doSave()
{   
	if(trim(document.forms[0].txt_plantname.value) == "")
    {
		ShowAlert('121',"Plant Name");
		document.forms[0].txt_plantname.value="";
	    document.forms[0].txt_plantname.focus();
	    return;
    }
	if(trim(document.forms[0].txt_plantvariety.value) == "")
    {
		ShowAlert('121',"Plant Variety");
		document.forms[0].txt_plantvariety.value="";
	    document.forms[0].txt_plantvariety.focus();
	    return;
    }
	if(trim(document.forms[0].txt_saleprice.value) == "")
    {
		ShowAlert('121',"Sale Price");
	    document.forms[0].txt_saleprice.focus();
	    return;
    }
    if(trim(document.forms[0].txt_maxplant.value) == "")
    {
		ShowAlert('121',"Unit cost per acre");
	    document.forms[0].txt_maxplant.focus();
	    return;
    }

    if(trim(document.forms[0].txt_cost.value) == "")
    {
		ShowAlert('121',"Yield per acre");
	    document.forms[0].txt_cost.focus();
	    return;
    }
    
    if(document.forms[0].sel_yieldunits.value == "0")
    {
		ShowAlert('111',"Yield units");
	    document.forms[0].sel_yieldunits.focus();
	    return;
    }
    
      if(trim(document.forms[0].txt_yieldgrow.value) == "")
    {
		ShowAlert('121',"Activity commences from");
	    document.forms[0].txt_yieldgrow.focus();
	    return;
    }
      if(document.forms[0].txt_startyield.value == "")
      {
  		ShowAlert('121',"Yielding Period commences from");
  	    document.forms[0].txt_startyield.focus();
  	    return;
      }
      if(document.forms[0].txt_startyield.value=="0")
      {
  		alert("Yielding Period commences from Should Not be Zero");
  	    document.forms[0].txt_startyield.focus();
  	    return;
      }
	   if(trim(document.forms[0].txt_totacre.value) == "")
		{
			ShowAlert('121',"Total acre");
			document.forms[0].txt_totacre.focus();
			return;
		}
	   document.forms[0].cmdsave.disabled=true; 
  	document.forms[0].hidBeanId.value="agrlandholdings";
	document.forms[0].hidSourceUrl.value="/action/agr_horticultureplantdetails.jsp";
	document.forms[0].hidBeanMethod.value="updateHortiData";
	document.forms[0].hidBeanGetMethod.value="getHortiData";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doEdit()
{
	var plant_name = document.forms[0].txt_plantname.value;
	if(plant_name=="")
	{
		alert("Select a Record ");
		return;
	}
	else
	{
		if(ConfirmMsg('185'))
		{
			for(var i=0;i<document.forms[0].length;i++)
			{
		        if(document.forms[0].elements[i].type=="radio")
		        {
		        	document.forms[0].elements[i].disabled=true;		  
		        }
			}
			disabledFields(false);
			
			document.forms[0].hidAction.value ="update";
			document.forms[0].hiddelete.value ="Y";
			disableNewButtons(true, true, false, false, true, false, false);
			document.forms[0].txt_maxplant.readOnly = true;
			document.forms[0].txt_plantname.readOnly = true;
		}
		else
		{
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].hidBeanGetMethod.value="getHortiData";
			document.forms[0].hidBeanId.value="agrlandholdings";
			document.forms[0].action=appUrl+"action/agr_horticultureplantdetails.jsp";
			document.forms[0].submit(); 
		}
	}
}


function doNew()
{
	disabledFields(false);
	// clearFormFields()
	disableNewButtons(true, true, false, false, true, false, false);
	document.forms[0].hidAction.value ="insert";
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].checked=false;
			document.forms[0].elements[i].disabled=true;	
		}	  
	}
	document.forms[0].txt_maxplant.readOnly = true;
	document.forms[0].txt_plantname.readOnly = true;
	
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getHortiData";
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].action=appUrl+"action/agr_horticultureplantdetails.jsp";
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
		document.forms[0].hidSourceUrl.value="action/agr_horticultureplantdetails.jsp";	
		document.forms[0].hidBeanMethod.value="updateHortiData";
		document.forms[0].hidBeanGetMethod.value="getHortiData";
		document.forms[0].submit();		
	}

}	

function onloading()
{	  
	// callbuttonStatus(document.forms[0].hidUsrMode, document.forms[0].hidWorkflowStatus, 'New',document.forms[0].hidWorkflowId);
	disabledFields(true);
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=varschemetype;
	document.forms[0].cmdcomments.disabled=false;
	//if(document.forms[0].hidMakerFlag.value=="Y")
	//{
	//	disableNewButtons(false, true, true, true, true, true, false);
	//}
	//else
	//{
	//	disableNewButtons(true, true, true, true, true, true, false);
	//}
	
}
function callLandHoldingsSecurity()
{
	if(document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidBeanGetMethod.value="getLandHoldingsSecurity";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrlandholdingssecurity.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
}

function callLink(page,bean,method)
{	
	if (document.forms[0].cmdsave.disabled)
	{
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
function callLink1(page)
{
	 document.forms[0].action=appUrl+"action/"+page;
	 document.forms[0].submit();
}

function calculateincome()
{
	var varyieldperacre = document.forms[0].txt_cost.value;
	var varsaleprice = document.forms[0].txt_saleprice.value;
	var varincperacre = NanNumber(parseFloat(varyieldperacre)) * NanNumber(parseFloat(varsaleprice)); 
	document.forms[0].txt_incperacre.value = roundVal(varincperacre); 
}

function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appUrl,name);
	}
}

function showfinance(flag)
{
	   
	   if(!document.forms[0].cmdsave.disabled)
		{ 
			var action=document.forms[0].hidAction.value;
			var prop = "scrollbars=no,width=650,height=400,top=100,left=250";
			var url=appUrl+"action/agrnurseryscaleoffinancelist.jsp?&strfrom=horticulture&parentId="+flag;
			window.open(url,"",prop);
	
		}else{
			alert('Please click the edit button');
		}  
}

function callActivityHelp(schemeType)
{
	var Type="";
	var appno="<%=strappno%>";
	if(document.forms[0].cmdsave.disabled==false)
	{
		
			var varQryString = appURL+"action/com_activityhelp.jsp?hidBeanId=appeditlock&hidBeanGetMethod=getActivityList&strfrom=plantdet&appno="+appno+"&facscheme="+varfacScheme; 
			var title = "ActivitySearch";
			var prop = "scrollbars=yes,width=700,height=430,status=yes";	
			prop = prop + ",left=50,top=50";		
			window.open(varQryString,title,prop);
		 
	}
}


function doComments()
{
	var btnenable=document.forms[0].btnenable.value;
	var appno="<%=strappno%>";
	var pagetype = "PLANTDE";
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/com_bankingcomments.jsp?hidBeanId=facilities&hidBeanGetMethod=getComments&hidAppNo="+appno+"&hidPage1="+pagetype+"&btnenable="+btnenable+"&appstatus="+appstatus;
	window.open(url,"Comments",prop);
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
<body onLoad="onloading()">
<form name="frmpri" method=post class="normal">
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
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
      <td class="page_flow">Home -> Agriculture -> Plant Details</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="70" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>
<br>
<table width="98%" border="0" cellspacing="0" cellpadding="5"
	align="center" class="shadow outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				
              <table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
                <tr class="datagrid"> 
                  <td width="15%">Plant Name&nbsp;<span class="mantatory">*</span></td>
                  <td width="18%">
                    <input type="text" name="txt_plantname"
							size="25"
							onKeyPress="allowAlphabets();notAllowSingleAndDoubleQuote()"
							maxlength="40">&nbsp;
							<b><span onClick="callActivityHelp()" style="cursor: hand"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0"></span></b> 
                  </td>
				   <td width="15%">Plant Variety&nbsp;<span class="mantatory">*</span></td>
                  <td width="19%">
                    <input type="text" name="txt_plantvariety"
							size="25"
							onKeyPress="notAllowSingleAndDoubleQuote()"
							maxlength="40">
                  </td>
				  <td width="15%">Sale Price&nbsp;<span class="mantatory">*</span></td>
                  <td width="18%">
                    <input type="text" name="txt_saleprice"
							size="20" style="text-align:right"
							onKeyPress="allowNumber(this);" onBlur="roundtxt(this);calculateincome()"
							maxlength="40">
                  </td>
				  </tr>
				 <tr class="datagrid">
				  <td>Unit cost per acre&nbsp;<span class="mantatory">*</span></td>
                  <td> 
                    <input type="text" name="txt_maxplant"
									style="text-align: right" size="10"
									onKeyPress="allowNumber(this)" maxlength="20">
                  </td>
				  <TD>Yield per acre&nbsp;<SPAN CLASS="mantatory">*</SPAN></TD>
                  <TD>
                    <INPUT TYPE="text"
							NAME="txt_cost" MAXLENGTH="20" STYLE="text-align: right"
							onKeyPress="notAllowSingleAndDoubleQuote();allowNumber(this)"
							onblur="roundtxt(this);calculateincome()"
							SIZE="10">&nbsp;
							<select name="sel_yieldunits">
							<option value="0">--Select--</option>
							<%String apptypecon = "136";%>
                    		<lapschoice:StaticDataNewTag apptype='<%=apptypecon%>' />
							</select>
                  </TD>
                  <TD>Income per acre</TD>
                  <TD>
                    <INPUT TYPE="text"
							NAME="txt_incperacre" MAXLENGTH="20" STYLE="text-align: right"
							readonly=readonly onblur="roundtxt(this);calculateincome()" onKeyPress="allowNumber(this);"
							SIZE="20">
				</TD>
                  
                </tr>
                
                <tr class="datagrid"> 
                  <TD nowrap>Activity commences from&nbsp;<SPAN
							CLASS="mantatory">*</SPAN></TD>
                  <TD nowrap>
                    <INPUT TYPE="text"
							NAME="txt_yieldgrow" SIZE="10" ONKEYPRESS="allowInteger(this)"
							MAXLENGTH="3" STYLE="text-align: right" onBlur=callgrowperiod()>
                  </TD>
                  <TD nowrap>Yielding period commences from&nbsp;<SPAN
							CLASS="mantatory">*</SPAN></TD>
                  <TD nowrap>
                    <INPUT TYPE="text"
							NAME="txt_startyield" SIZE="10" ONKEYPRESS="allowInteger(this)"
							MAXLENGTH="3" STYLE="text-align: right" ONBLUR=callgrowperiod()>
                  </TD>
                  <TD>Total acre&nbsp;<SPAN CLASS="mantatory">*</SPAN></TD>
                  <TD>
                    <INPUT TYPE="text"
							NAME="txt_totacre" MAXLENGTH="15" STYLE="text-align: right"
							onKeyPress="allowNumber(this)"
							onblur="roundtxt(this)"
							SIZE="20">
                  </TD>
                </tr>
              </table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
	<br>
<lapschoice:combuttonnew
	btnnames="New_Edit_Save_Delete_Cancel_Comments_Audit Trail"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<br>

		<table width="96%" border="0" cellspacing="1" cellpadding="3" align="center">
			<tr class="dataheader">
				<td width="5%">&nbsp;</td>
				<td align="center" nowrap width="13%">Plant Name</td>
				<td align="center" nowrap width="13%">Plant Variety</td>
				<td align="center" nowrap width="13%">Sale Price</td>
				<td align="center" nowrap width="13%">Unit cost per acre</td>
				<td align="center" nowrap width="13%">Yield per acre</td>				
            <td align="center" nowrap width="13%">Activity commences from</td>
            <td align="center" nowrap width="13%">Total acre</td>
			</tr>
		
			<%
				arrCol = new ArrayList();
				if (hshValues != null) {
					arrRow = (ArrayList) hshValues.get("arrRow");
				}
				if (arrRow != null && arrRow.size() > 0) {

					for (int i = 0; i < arrRow.size(); i++) {
						arrCol = (ArrayList) arrRow.get(i);
			%>
			<tr class="datagrid">
				<td width="5%" align="center"><input type="radio"
					style="border: none" name="radiobutton" value="radiobutton"
					onClick="javascript:selectValues(
												'<%=Helper.correctNull((String) arrCol.get(1))%>',
												'<%=Helper.correctNull((String) arrCol.get(2))%>',
											    '<%=Helper.formatDoubleValue(Double.parseDouble(Helper
											    		.correctNull((String) arrCol.get(3))))%>',
												'<%=Helper.correctNull((String) arrCol.get(4))%>',
												'<%=nf.format(Double.parseDouble(Helper
									.correctNull((String) arrCol.get(5))))%>',
												'<%=Helper.correctNull((String) arrCol.get(6))%>',
												'<%=Helper.correctNull((String) arrCol.get(7))%>',
												'<%=Helper.correctNull((String) arrCol.get(8))%>',
												'<%=Helper.formatDoubleValue(Double.parseDouble(Helper
														.correctNull((String) arrCol.get(9))))%>',
												'<%=Helper.correctNull((String) arrCol.get(10))%>',
												'<%=Helper.formatDoubleValue(Double.parseDouble(Helper
														.correctNull((String) arrCol.get(11))))%>',
												'<%=Helper.correctNull((String) arrCol.get(12))%>')">
				</td>
				<td width="13%"><%=Helper.correctNull((String) arrCol.get(2))%></td>
				<td width="13%"><%=Helper.correctNull((String) arrCol.get(8))%></td>
				<td width="13%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(9))))%></td>
				<td width="13%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(3))))%></td>
				<td width="13%" align="right"><%=nf.format(Double.parseDouble(Helper
									.correctNull((String) arrCol.get(5))))%></td>
				<td align="right" width="13%"><%=Helper.correctNull((String) arrCol
											.get(6))%></td>
				<td align="right" width="13%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol
											.get(10))))%></td>
			</tr>
			<%
				}
				}
				for (int j = 0; j < 6; j++) {
			%>
			<tr class="dataGridColor">
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				
			</tr>
			<%
				}
			%>
		</table>
	
<input type="hidden" name="hidAction" value=""> <input
	type="hidden" name="hidBeanId" value=""> <input type="hidden"
	name="hidBeanMethod" value=""> <input type="hidden"
	name="hidBeanGetMethod" value=""> <input type="hidden"
	name="hidSourceUrl" value=""> <input type="hidden"
	name="hidApp_type" value="A"> <input type="hidden"
	name="selsno" value=""> <input type="hidden" name="page"
	value=""> <INPUT TYPE="hidden" name="trapEdit"
	value="<%=Helper.correctNull((String) hshValues.get("trapEdit"))%>">
<INPUT TYPE="hidden" name="hidEditMode"
	value="<%=Helper.correctNull((String) hshValues
									.get("hidEditMode"))%>">
<input type="hidden" name="hidCoDemoId"
	value="<%=request.getParameter("hidCoDemoId")%>"> <input
	type="hidden" name="hidDemoId"
	value="<%=request.getParameter("hidDemoId")%>"> <input
	type="hidden" name="hidAppType"
	value="<%=Helper.correctNull((String) hshValues.get("hidAppType"))%>">
<input type="hidden" name="hidGuaDemoId"
	value="<%=request.getParameter("hidGuaDemoId")%>"> <input
	type="hidden" name="hidpagetype" value="<%=PageType%>"> <input
	type="hidden" name="hidcroptype" value="PR">
	<input type="hidden" name="hidschemesno" value="">
	<input type="hidden" name="hiddelete" value="">
</form>
</body>
</html>




