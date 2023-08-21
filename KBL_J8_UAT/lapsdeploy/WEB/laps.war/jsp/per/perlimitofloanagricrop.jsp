<%@include file="../share/CKEditor.jsp"%>
<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>

<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="PageId" class="java.lang.String" scope="request" />
<jsp:useBean id="strGroupRights" class="java.lang.String" scope="session" />
<jsp:useBean id="strOrgLevel" class="java.lang.String" scope="session" />
<jsp:useBean id="strIsSaral" class="java.lang.String" scope="session" />
<jsp:useBean id="strUserId" class="java.lang.String" scope="session" />
<jsp:useBean id="strOrgCode" class="java.lang.String" scope="session" />
<jsp:useBean id="strOrgName" class="java.lang.String" scope="session" />
<jsp:useBean id="strUserClass" class="java.lang.String" scope="session" />
<%
response.addHeader("P3P","CP=\"IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT\"");
response.addHeader("X-UA-Compatible","IE=EmulateIE8");

	String appno = Helper.correctNull((String) request.getParameter("appno"));
	if (appno.equalsIgnoreCase("")) 
	{
		appno = Helper.correctNull((String) hshValues.get("strAppno"));
	}
	if(appno.equalsIgnoreCase("")) 
	{
		appno = Helper.correctNull((String) request.getParameter("Applicationno"));
	}
	String strappno = Helper.correctNull((String) hshValues.get("strAppno"));
	String fac = Helper.correctNull((String) hshValues.get("FACILITY_SN"));
	//out.println(fac);
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	ArrayList arryRow = (ArrayList) hshValues.get("arrRoww");
	ArrayList arryCol = new ArrayList();
	%>
<html>
<head>
<title>Deviation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" href="../htm/link.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var individualschk="<%=Helper.correctNull((String)hshValues.get("individuals"))%>";
var FAC_AGE_DEV="<%=Helper.correctNull((String)hshValues.get("FAC_AGE_DEV"))%>";
var FAC_AGE_APPROV="<%=Helper.correctNull((String)hshValues.get("FAC_AGE_APPROV"))%>";
var lpdev="<%=Helper.correctNull((String)hshValues.get("FAC_LP_DEV"))%>";
var lpapprove="<%=Helper.correctNull((String)hshValues.get("FAC_LP_APPROV"))%>";
var ladev="<%=Helper.correctNull((String)hshValues.get("FAC_LA_DEV"))%>";
var laapprove="<%=Helper.correctNull((String)hshValues.get("FAC_LA_APPROV"))%>";
var FAC_REP_DEV="<%=Helper.correctNull((String)hshValues.get("FAC_REP_DEV"))%>";
var FAC_REP_APPROV="<%=Helper.correctNull((String)hshValues.get("FAC_REP_APPROV"))%>";
var FAC_CIBIL_DEV="<%=Helper.correctNull((String)hshValues.get("FAC_CIBIL_DEV"))%>";
var FAC_CIBIL_APPROV="<%=Helper.correctNull((String)hshValues.get("FAC_CIBIL_APPROV"))%>";
var FAC_TOLTOW_DEV="<%=Helper.correctNull((String)hshValues.get("FAC_TOLTOW_DEV"))%>";
var FAC_TOLTOW_APPROV="<%=Helper.correctNull((String)hshValues.get("FAC_TOLTOW_APPROV"))%>";
var FAC_NWC_DEV="<%=Helper.correctNull((String)hshValues.get("FAC_NWC_DEV"))%>";
var FAC_NWC_APPROV = "<%=Helper.correctNull((String)hshValues.get("FAC_NWC_APPROV"))%>";
var FAC_CURR_RAT_DEV="<%=Helper.correctNull((String)hshValues.get("FAC_CURR_RAT_DEV"))%>";
var FAC_CURR_RAT_APPROV="<%=Helper.correctNull((String)hshValues.get("FAC_CURR_RAT_APPROV"))%>";
var FAC_DEBT_EQ_RAT_DEV="<%=Helper.correctNull((String)hshValues.get("FAC_DEBT_EQ_RAT_DEV"))%>";
var FAC_DEBT_EQ_RAT_APPROV="<%=Helper.correctNull((String)hshValues.get("FAC_DEBT_EQ_RAT_APPROV"))%>";
var FAC_DV_DEV="<%=Helper.correctNull((String)hshValues.get("FAC_DV_DEV"))%>";
var FAC_DV_APPROV="<%=Helper.correctNull((String)hshValues.get("FAC_DV_APPROV"))%>";
var FAC_NETW_DEV="<%=Helper.correctNull((String)hshValues.get("FAC_NETW_DEV"))%>";
var FAC_NETW_APPROV="<%=Helper.correctNull((String)hshValues.get("FAC_NETW_APPROV"))%>";
var FAC_SELANDOTH_DEV="<%=Helper.correctNull((String)hshValues.get("FAC_SELANDOTH_DEV"))%>";
var FAC_SELANDOTH_APPROV="<%=Helper.correctNull((String)hshValues.get("FAC_SELANDOTH_APPROV"))%>";
var FAC_ACC_STMNT_CHQRTN_APPROV="<%=Helper.correctNull((String)hshValues.get("FAC_ACC_STMNT_CHQRTN_APPROV"))%>";
var FAC_FRAUD_CHK_APPROV="<%=Helper.correctNull((String)hshValues.get("FAC_FRAUD_CHK_APPROV"))%>";
var FAC_IN_TAX_RTN_APPROV="<%=Helper.correctNull((String)hshValues.get("FAC_IN_TAX_RTN_APPROV"))%>";
var FAC_ANY_OTH_DEV_APPROV="<%=Helper.correctNull((String)hshValues.get("FAC_ANY_OTH_DEV_APPROV"))%>";
var FAC_ADD_INT_IF="<%=Helper.correctNull((String)hshValues.get("FAC_ADD_INT_IF"))%>";
var FAC_HAND_CHA_IF="<%=Helper.correctNull((String)hshValues.get("FAC_HAND_CHA_IF"))%>";
var facility= "<%=fac%>";
var sancauthority="<%=Helper.correctNull((String)hshValues.get("FAC_PERMIT_AUT"))%>";
var approverights="<%=Helper.correctNull((String)hshValues.get("deviationapproverights"))%>";
var applholdercheck="<%=Helper.correctNull((String)hshValues.get("appholdercheck"))%>";
var nodatachk="<%=Helper.correctNull((String)hshValues.get("nodata"))%>";
function selfacility()
{	
	//var fac=document.forms[0].sel_facility.value;
	document.forms[0].action=appURL+"action/perlimitofloanagricrop.jsp?hidBeanId=perlimitofloan&hidBeanGetMethod=getDeviationData";
	document.forms[0].submit();
	
	
}
function doEdit()
{
	document.forms[0].cmdsave.disabled = false;
	document.forms[0].cmdedit.disabled = true;
	document.forms[0].cmdcancel.disabled = false;
	document.forms[0].cmddelete.disabled = false;
	disableFields(false);
	document.forms[0].sel_facility.disabled=true;
	if(document.forms[0].sel_facility.value!="")
	{
	if(approverights=="Y"&&applholdercheck=="Y"&&nodatachk=="N")	
	{
	document.forms[0].ageapprov.disabled=false;
	document.forms[0].ageapprovremark.readOnly=false;
	document.forms[0].lpapprove.disabled=false;
	document.forms[0].lpapproveremarks.readOnly=false;
	document.forms[0].laapprove.disabled=false;
	document.forms[0].laapproveremark.readOnly=false;
	document.forms[0].repayapprove.disabled=false;
	document.forms[0].repayapproveremark.readOnly=false;
	document.forms[0].cibilapprove.disabled=false;
	document.forms[0].cibilapproveremark.readOnly=false;
	document.forms[0].toltowapprove.disabled=false;
	document.forms[0].toltowapproveremark.readOnly=false;
	document.forms[0].nwcapprove.disabled=false;
	document.forms[0].nwcapproveremark.readOnly=false;
	document.forms[0].crrapprove.disabled=false;
	document.forms[0].currapproveremark.readOnly=false;
	document.forms[0].derapprove.disabled=false;
	document.forms[0].derapproveremarks.readOnly=false;
	document.forms[0].dvapprove.disabled=false;
	document.forms[0].dvapproveremark.readOnly=false;
	document.forms[0].netwapprove.disabled=false;
	document.forms[0].netwapproveremark.readOnly=false;
	document.forms[0].saoapprove.disabled=false;
	document.forms[0].saoapproveremarks.readOnly=false;
	document.forms[0].accstachkapprove.disabled=false;
	document.forms[0].accstachkapproveremarks.readOnly=false;
	document.forms[0].fraudchkapprove.disabled=false;
	document.forms[0].fraudchkapproveremark.readOnly=false;
	document.forms[0].taxapprove.disabled=false;
	document.forms[0].taxapproveremarks.readOnly=false;
	document.forms[0].anyotherapprove.disabled=false;
	document.forms[0].anyotherapproveremarks.readOnly=false;
	}
	else
	{
		document.forms[0].ageapprov.disabled=true;
		document.forms[0].ageapprovremark.readOnly=true;
		document.forms[0].lpapprove.disabled=true;
		document.forms[0].lpapproveremarks.readOnly=true;
		document.forms[0].laapprove.disabled=true;
		document.forms[0].laapproveremark.readOnly=true;
		document.forms[0].repayapprove.disabled=true;
		document.forms[0].repayapproveremark.readOnly=true;
		document.forms[0].cibilapprove.disabled=true;
		document.forms[0].cibilapproveremark.readOnly=true;
		document.forms[0].toltowapprove.disabled=true;
		document.forms[0].toltowapproveremark.readOnly=true;
		document.forms[0].nwcapprove.disabled=true;
		document.forms[0].nwcapproveremark.readOnly=true;
		document.forms[0].crrapprove.disabled=true;
		document.forms[0].currapproveremark.readOnly=true;
		document.forms[0].derapprove.disabled=true;
		document.forms[0].derapproveremarks.readOnly=true;
		document.forms[0].dvapprove.disabled=true;
		document.forms[0].dvapproveremark.readOnly=true;
		document.forms[0].netwapprove.disabled=true;
		document.forms[0].netwapproveremark.readOnly=true;
		document.forms[0].saoapprove.disabled=true;
		document.forms[0].saoapproveremarks.readOnly=true;
		document.forms[0].accstachkapprove.disabled=true;
		document.forms[0].accstachkapproveremarks.readOnly=true;
		document.forms[0].fraudchkapprove.disabled=true;
		document.forms[0].fraudchkapproveremark.readOnly=true;
		document.forms[0].taxapprove.disabled=true;
		document.forms[0].taxapproveremarks.readOnly=true;
		document.forms[0].anyotherapprove.disabled=true;
		document.forms[0].anyotherapproveremarks.readOnly=true;
	}
		
	}
	
}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].sel_facility.disabled=false;
		document.forms[0].hidBeanId.value="perlimitofloan"
		document.forms[0].hidBeanGetMethod.value="getDeviationData";
		document.forms[0].action=appURL+"action/perlimitofloanagricrop.jsp";
		document.forms[0].submit();
	 }
}
function doSave()
{
	
	var strflagcheck="N";
	var strsanccheck="N";
	<%if(arryRow!=null && arryRow.size()>0){
		if(arryRow.size()==1){%>

		if(document.forms[0].hiduserID.value==document.forms[0].txtuserID.value){
			alert("User Already Exists");
			return;
		}
		
		<%}else{%>

		for(var i=0;i<document.forms[0].hiduserID.length;i++)
		{
			if(document.forms[0].hiduserID[i].value==document.forms[0].txtuserID.value){
				alert("User Already Exists");
				return;
			}
			else
			{
				
					if(document.forms[0].hidDetails[i].value=="A" && document.forms[0].sel_details.value=="A"){
						strflagcheck="Y";
					}
				
			}
		}
		
		<%}
		}%>
		if(strflagcheck=="Y"){
			alert(" Multiple Appraised by User cannot be entered in single proposal");
			return;
		}
		

	if(document.forms[0].sel_details.value=="V")
	{
		document.forms[0].vettedby.value=document.forms[0].vettedby.value + document.forms[0].txtuserID.value+"@";
	}
	
	document.forms[0].hidfacility.value=document.forms[0].sel_facility.value;
	document.forms[0].hidAction.value ="insert";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="perlimitofloan";
	document.forms[0].hidBeanMethod.value="updateDeviationDataforcorpandagri";
	document.forms[0].hidBeanGetMethod.value="getDeviationData";
	document.forms[0].hidSourceUrl.value="/action/perlimitofloanagricrop.jsp";
	document.forms[0].submit();
}
function doClose()
{
	
   if(ConfirmMsg(100))
	 {
		window.close();
	 }
  
}
function placeValues()
{
	if(facility!="")
	{
		
		document.forms[0].sel_facility.value=facility;
		document.forms[0].cmdedit.disabled=false;
	}
	else
	{
		
		document.forms[0].cmdedit.disabled=true;
	}
	document.forms[0].cmdundo.disabled=true;
	document.forms[0].cmdpermit.disabled=true;
	disableFields(true);
	document.forms[0].sel_facility.disabled=false;
	
	if(individualschk=="Y")
	{
		document.forms[0].agelimit.disabled=true;
	}
	if(FAC_AGE_DEV!="")
	{
	document.forms[0].agedeviation.value=FAC_AGE_DEV;
	}
	if(FAC_AGE_APPROV!="")
	{
		document.forms[0].ageapprov.value=FAC_AGE_APPROV;
	}
	if(lpdev!="")
	{
	document.forms[0].lpdev.value=lpdev;
	}
	if(lpapprove!="")
	{
	document.forms[0].lpapprove.value=lpapprove;
	}
	if(ladev!="")
	{
	document.forms[0].ladev.value=ladev;
	}
	if(laapprove!="")
	{
	document.forms[0].laapprove.value=laapprove;
	}
	if(FAC_REP_DEV!="")
	{
	document.forms[0].repaydev.value=FAC_REP_DEV;
	}
	if(FAC_REP_APPROV!="")
	{
	document.forms[0].repayapprove.value=FAC_REP_APPROV;
	}
	if(FAC_CIBIL_DEV!="")
	{
	document.forms[0].cibildev.value=FAC_CIBIL_DEV;
	}
	if(FAC_CIBIL_APPROV!="")
	{
	document.forms[0].cibilapprove.value=FAC_CIBIL_APPROV;
	}
	if(FAC_TOLTOW_DEV!="")
	{
	document.forms[0].toltowdev.value=FAC_TOLTOW_DEV;
	}
	if(FAC_TOLTOW_APPROV!="")
	{
	document.forms[0].toltowapprove.value=FAC_TOLTOW_APPROV;
	}
	if(FAC_NWC_DEV!="")
	{
	document.forms[0].nwcdev.value=FAC_NWC_DEV;
	}
	if(FAC_NWC_APPROV!="")
	{
	document.forms[0].nwcapprove.value=FAC_NWC_APPROV;
	}
	if(FAC_CURR_RAT_DEV!="")
	{
	document.forms[0].crdev.value=FAC_CURR_RAT_DEV;
	}
	if(FAC_CURR_RAT_APPROV!="")
	{
	document.forms[0].crrapprove.value=FAC_CURR_RAT_APPROV;
	}
	if(FAC_DEBT_EQ_RAT_DEV!="")
	{
	document.forms[0].derdev.value=FAC_DEBT_EQ_RAT_DEV;
	}
	if(FAC_DEBT_EQ_RAT_APPROV!="")
	{
	document.forms[0].derapprove.value=FAC_DEBT_EQ_RAT_APPROV;
	}
	if(FAC_DV_DEV!="")
	{
	document.forms[0].dvdev.value=FAC_DV_DEV;
	}
	if(FAC_DV_APPROV!="")
	{
	document.forms[0].dvapprove.value=FAC_DV_APPROV;
	}
	if(FAC_NETW_DEV!="")
	{
	document.forms[0].netwdev.value=FAC_NETW_DEV;
	}
	if(FAC_NETW_APPROV!="")
	{
	document.forms[0].netwapprove.value=FAC_NETW_APPROV;
	}
	if(FAC_SELANDOTH_DEV!="")
	{
	document.forms[0].saodev.value=FAC_SELANDOTH_DEV;
	}
	if(FAC_SELANDOTH_APPROV!="")
	{
	document.forms[0].saoapprove.value=FAC_SELANDOTH_APPROV;
	}
	if(FAC_ACC_STMNT_CHQRTN_APPROV!="")
	{
	document.forms[0].accstachkapprove.value=FAC_ACC_STMNT_CHQRTN_APPROV;
	}
	if(FAC_FRAUD_CHK_APPROV!="")
	{
	document.forms[0].fraudchkapprove.value=FAC_FRAUD_CHK_APPROV;
	}
	if(FAC_IN_TAX_RTN_APPROV!="")
	{
	document.forms[0].taxapprove.value=FAC_IN_TAX_RTN_APPROV;
	}
	if(FAC_ANY_OTH_DEV_APPROV!="")
	{
	document.forms[0].anyotherapprove.value=FAC_ANY_OTH_DEV_APPROV;
	}
	if(FAC_ADD_INT_IF!="")
	{
	document.forms[0].additint.value=FAC_ADD_INT_IF;
	}
	if(FAC_HAND_CHA_IF!="")
	{
	document.forms[0].handcharge.value=FAC_HAND_CHA_IF;
	}
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}	
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
	}	
}
function callSearch()
{
	if(document.forms[0].cmdsave.disabled == false)
	{
		if(document.forms[0].sel_details.value=="")
		{
			alert("Select User Details");
			document.forms[0].sel_details.focus();
			return;
		}
		
	    var varQryString = appURL+"action/userselectfordev.jsp?appno="+document.forms[0].appno.value+"&hidDetails="+document.forms[0].sel_details.value;
		var title = "Users";
		var prop = "scrollbars=yes,width=650,height=400,menubar=no";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
}
function selectValues(val1, val2, val3,val4)
{
	if(val4=="V")
	{
	if(applholdercheck=="Y")
	{
	document.forms[0].txtuserID.value=val1;
	document.forms[0].txt_name.value=val2;
	document.forms[0].txt_desig1.value=val3;
	document.forms[0].sel_details.value=val4;
	document.forms[0].cmddelete.disabled = false;
	document.forms[0].fordelete.value="Y";
	}
	}
	else
	{
		var le = document.forms[0].radio_impln.length;
		for(var i=0;i<le;i++)
		{
			document.forms[0].radio_impln[i].checked = false;
		}
		document.forms[0].radio_impln.checked=false;
		alert("Delect allow only for vetted by");
		return;
	}
	
}
function doDelete()
{
	if(document.forms[0].fordelete.value =="Y")
	{
		if(document.forms[0].sel_details.value=="V")
		{
	if(confirm("Do you really want to delete this record"))
	 {
		document.forms[0].hidfacility.value=document.forms[0].sel_facility.value;
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="perlimitofloan"
		document.forms[0].hidBeanMethod.value="updateDeviationDataforcorpandagri";
		document.forms[0].hidBeanGetMethod.value="getDeviationData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/perlimitofloanagricrop.jsp";
 		document.forms[0].submit();
	 }
		}
		else
		{
			alert("Delect allow only for vetted by");
			return;
		}
	}
	else
	{
		if(confirm("Do you really want to delete this record"))
		 {
		document.forms[0].hidfacility.value=document.forms[0].sel_facility.value;
		document.forms[0].hidAction.value="deleteall"
	 	document.forms[0].hidBeanId.value="perlimitofloan"
		document.forms[0].hidBeanMethod.value="updateDeviationDataforcorpandagri";
		document.forms[0].hidBeanGetMethod.value="getDeviationData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/perlimitofloanagricrop.jsp";
 		document.forms[0].submit();
		 }
	}	  		
}
function doPermit()
{
	
}
function appholdercheck()
{
	if(applholdercheck=="N")
	{
		document.forms[0].cmdedit.disabled = true;
		document.forms[0].cmdundo.disabled = true;
		document.forms[0].cmdpermit.disabled = true;
	}
}
function checkRange()
{
	
}
</script>
</head>
<body onLoad="placeValues();appholdercheck();">
<form method="post" class="normal">
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
                      
                <tr>
				<td>
				Facility &nbsp;<select name="sel_facility"  onchange="selfacility()">
				<option value="" selected>--Select--</option>
				<%
					String parent=appno;
				%>
				<lapschoice:ComMisDetailsTag apptype='<%= parent%>' />
				</select>
				</td>
				</tr>
				</table>
		<table  width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td valign="top">
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr class="dataheader"> 
            <td width="20%">Deviation</td>
            <td width="10%">Defined Value</td>
            <td width="10%" nowrap="nowrap">Deviation</td>
            <td width="10%">New Value</td>
            <td width="30%">Remarks / Comments</td>
            <td width="10%" align="center">Approval</td>
            <td width="10%" align="center">Remarks</td>
          </tr>
          <tr class="datagrid"> 
            <td width="20%">Age Limit 
             
            </td>
            <td width="10%"> 
              <input type="text" size='15' name="agelimit" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("agelimitforind"))%>">
            </td>
            <td align="center" width="10%"> 
              <select name="agedeviation" >
                <option value="N" selected="selected">No</option>
                <option value="Y">Yes</option>
              </select>
            </td>
            <td width="10%"> 
              <input type="text" size='15' maxlength="18" name="agenewval" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("FAC_AGE_NEW"))%>" onKeyPress="allowNumber(document.forms[0].txt_loanamountnew)">
            </td>
            <td width="30%"> 
              <textarea name="ageremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_AGE_REMARKS"))%></textarea>
            </td>
            <td width="10%" align="center"> 
              <select name="ageapprov">
			  <option value='S' selected="selected">-- Select --</option>
			  <option value='A'>Approve</option>
			  <option value='R'>Reject</option>
              </select>
            </td>
           
            <td width="30%"> 
              <textarea name="ageapprovremark" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_AGE_APPREMARK"))%></textarea>
            </td>
          </tr>
          <tr class="datagrid"> 
            <td width="20%">
           Loan period 
             
            </td>
            <td width="10%"> 
              <input type="text" size='15' name="lpdif" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("FAC_LP_DEF"))%>">
            </td>
            <td align="center" width="10%"> 
              <select name="lpdev">
                <option value="N" selected="selected">No</option>
                <option value="Y">Yes</option>
              </select>
            </td>
            <td width="10%"> 
              <input type="text" size='15' maxlength="18" name="lpnew" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("FAC_LP_NEW"))%>">
            </td>
            <td width="30%"> 
              <textarea name="lpremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_LP_REMARKS"))%></textarea>
            </td>
            <td width="10%" align="center"> 
              <select name="lpapprove">
			  <option value='S' selected="selected">-- Select --</option>
			  <option value='A'>Approve</option>
			  <option value='R'>Reject</option>
              </select>
            </td>
            
            <td width="30%"> 
              <textarea name="lpapproveremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_LP_APPREMARK"))%></textarea>
            </td>
          </tr>
          <tr class="datagrid"> 
            <td width="20%">Limit Advance
            </td>
            <td width="10%"> 
              
              <input type="text" size='5' name="ladef" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("FAC_LA_DEF"))%>">
            </td>
            <td align="center" width="10%"> 
              <select name="ladev">
                <option value="N" selected="selected">No</option>
                <option value="Y">Yes</option>
              </select>
            </td>
            <td width="10%"> 
              <input type="text" size='5' name="lanew" onBlur="checkRange();" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("FAC_LA_NEW"))%>" onKeypress="allowInteger()">
            </td>
            <td width="30%"> 
              <textarea name="laremark" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_LA_REMARKS"))%></textarea>
            </td>
            <td width="10%" align="center"> 
              <select name="laapprove">
                <option value='S' selected="selected">-- Select --</option>
                <option value='A'>Approve</option>
                <option value='R'>Reject</option>
              </select>
            </td>
              <td width="30%"> 
              <textarea name="laapproveremark" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_LA_APPREMARK"))%></textarea>
            </td>
          </tr>
          <tr class="datagrid"> 
            <td width="20%"> Repayment (obligation/FOIR)
            </td>
            <td width="10%"> 
              <input type="text" size='5' name="repaydef" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("FAC_REP_DEF"))%>">
            </td>
            <td align="center" width="10%"> 
              <select name="repaydev" onClick="disablefields()">
                <option value="N" selected="selected">No</option>
                <option value="Y">Yes</option>
              </select>
            </td>
            <td width="10%"> 
              <input type="text" size='5' name="repaynew" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("FAC_REP_NEW"))%>" onKeyPress="allowNumber(document.forms[0].txt_marginnew);" onblur="checkPercentage(document.forms[0].txt_marginnew);">
            </td>
            <td width="30%"> 
              <textarea name="repayremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_REP_REMARKS"))%></textarea>
            </td>
            <td width="10%" align="center"> 
              <select name="repayapprove">
                <option value='S' selected="selected">-- Select --</option>
                <option value='A'>Approve</option>
                <option value='R'>Reject</option>
              </select>
            </td>
             <td width="30%"> 
              <textarea name="repayapproveremark" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_REP_APPREMARK"))%></textarea>
            </td>
          </tr>
          <tr class="datagrid" > 
            <td width="20%">CIBIL/CRIF Score Deviation of Applicant
            </td>
            <td width="10%"> 
              <%=Helper.correctNull((String) hshValues.get("cibilorcrifofapplicant"))%>
            </td>
            <td align="center" width="10%"> 
              <select name="cibildev">
                <option value="N" selected="selected">No</option>
                <option value="Y">Yes</option>
              </select>
            </td>
            <td>
            </td>
            <td width="30%"> 
              <textarea name="cibilremark" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_CIBIL_REMARKS"))%></textarea>
            </td>
            <td width="10%" align="center"> 
              <select name="cibilapprove">
                <option value='S' selected="selected">-- Select --</option>
                <option value='A'>Approve</option>
                <option value='R'>Reject</option>
              </select>
            </td>
           
              <td width="30%"> 
              <textarea name="cibilapproveremark" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_CIBIL_APPREMARK"))%></textarea>
            </td>
          </tr>
          <% if(hshValues!=null&&hshValues.size()>0)
			{
				arrRow = (ArrayList) hshValues.get("ArrRow");
				if (arrRow != null && arrRow.size() > 0) {
					
					for (int l = 0; l < arrRow.size(); l++) {
						arrCol = (ArrayList) arrRow.get(l);
			%><TR valign="top" class="dataheader">
			<td><%=Helper.correctNull((String)arrCol.get(0))%></td>
			<td><%=Helper.correctNull((String)arrCol.get(1))%></td>
			<td></td>
			<td></td>
			<td></td>
			<td ></td>
			</TR>
			<%}}} %>
          <tr class="dataheader"> 
            <td nowrap="nowrap" width="20%">Financial Covenant </td>
               <td nowrap="nowrap" width="10%">Prescribed Bench Mark</td>
               <td nowrap="nowrap" width="10%">Actual</td>
               <td>Deviation</td>
             
            </tr>
            <tr class="datagrid">
             <td nowrap="nowrap" width="20%">&nbsp&nbsp&nbsp&nbsp TOL:TNW 
              
            </td>
            <td width="10%"> 
              <input type="text" size='5' name="toltowpbm" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("FAC_TOLTOW_PBM"))%>">
            </td>
            <td width="10%"> 
              <input type="text" size='5' name="toltowact" onKeypress="allowInteger()" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("FAC_TOLTOW_ACT"))%>">
            </td>
            <td align="center" width="10%"> 
              <select name="toltowdev">
                <option value="N" selected="selected">No</option>
                <option value="Y">Yes</option>
              </select>
            </td>
            
            <td width="30%"> 
              <textarea name="toltowremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_TOLTOW_REMARKS"))%></textarea>
            </td>
            <td width="10%" align="center"> 
              <select name="toltowapprove">
                <option value='S' selected="selected">-- Select --</option>
                <option value='A'>Approve</option>
                <option value='R'>Reject</option>
              </select>
            </td>
            
             <td width="30%"> 
              <textarea name="toltowapproveremark" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_TOLTOW_APPREMARK"))%></textarea>
            </td>
          </tr>         
         <tr class="datagrid">
             <td nowrap="nowrap" width="20%">&nbsp&nbsp&nbsp&nbsp NWC 
              
            </td>
            <td width="10%"> 
              <input type="text" size='5' name="nwcpbm" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("FAC_NWC_PBM"))%>">
            </td>
            <td width="10%"> 
              <input type="text" size='5' name="nwcact" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("FAC_NWC_ACT"))%>">
            </td>
            <td align="center" width="10%"> 
              <select name="nwcdev">
                <option value="N" selected="selected">No</option>
                <option value="Y">Yes</option>
              </select>
            </td>
            
            <td width="30%"> 
              <textarea name="nwcremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_NWC_REMARKS"))%></textarea>
            </td>
            <td width="10%" align="center"> 
              <select name="nwcapprove">
                <option value='S' selected="selected">-- Select --</option>
                <option value='A'>Approve</option>
                <option value='R'>Reject</option>
              </select>
            </td>
          
              <td width="30%"> 
              <textarea name="nwcapproveremark" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_NWC_APPREMARK"))%></textarea>
            </td>
          </tr> 
           <tr class="datagrid">
             <td nowrap="nowrap" width="20%">&nbsp&nbsp&nbsp&nbsp Current Ratio 
              
            </td>
            <td width="10%"> 
              <input type="text" size='5' name="crpbm" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("FAC_CURR_RAT_PBM"))%>">
            </td>
            <td width="10%"> 
              <input type="text" size='5' name="crpact" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("FAC_CURR_RAT_ACT"))%>">
            </td>
            <td align="center" width="10%"> 
              <select name="crdev">
                <option value="N" selected="selected">No</option>
                <option value="Y">Yes</option>
              </select>
            </td>
            
            <td width="30%"> 
              <textarea name="crremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_CURR_RAT_REMARKS"))%></textarea>
            </td>
            <td width="10%" align="center"> 
              <select name="crrapprove">
                <option value='S' selected="selected">-- Select --</option>
                <option value='A'>Approve</option>
                <option value='R'>Reject</option>
              </select>

            </td>
        
              <td width="30%"> 
              <textarea name="currapproveremark" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_CURR_RAT_APPREMARK"))%></textarea>
            </td>
          </tr>  
                     <tr class="datagrid">
             <td nowrap="nowrap" width="20%">&nbsp&nbsp&nbsp&nbsp Debt Equity Ratio 
              
            </td>
            <td width="10%"> 
              <input type="text" size='5' name="derpbm" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("FAC_DEBT_EQ_RAT_PBM"))%>">
            </td>
             <td width="10%"> 
              <input type="text" size='5' name="deract" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("FAC_DEBT_EQ_RAT_ACT"))%>">
            </td>
            <td align="center" width="10%"> 
              <select name="derdev">
                <option value="N" selected="selected">No</option>
                <option value="Y">Yes</option>
              </select>
            </td>
           
            <td width="30%"> 
              <textarea name="derremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_DEBT_EQ_RAT_REMARKS"))%></textarea>
            </td>
            <td width="10%" align="center"> 
              <select name="derapprove">
                <option value='S' selected="selected">-- Select --</option>
                <option value='A'>Approve</option>
                <option value='R'>Reject</option>
              </select>
            </td>
           
             <td width="30%"> 
              <textarea name="derapproveremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_DEBT_EQ_RAT_APPREMARK"))%></textarea>
            </td>
          </tr>  
                     <tr class="datagrid">
             <td nowrap="nowrap" width="20%"> &nbsp&nbsp&nbsp&nbsp Debtor velocity
              
            </td>
            <td width="10%"> 
              <input type="text" size='5' name="dvpbm" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("FAC_DV_PBM"))%>">
            </td>
            <td width="10%"> 
              <input type="text" size='5' name="dvact" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("FAC_DV_ACT"))%>">
            </td>
            <td align="center" width="10%"> 
              <select name="dvdev" >
                <option value="N" selected="selected">No</option>
                <option value="Y">Yes</option>
              </select>
            </td>
            
            <td width="30%"> 
              <textarea name="dvremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_DV_REMARKS"))%></textarea>
            </td>
            <td width="10%" align="center"> 
              <select name="dvapprove">
                <option value='S' selected="selected">-- Select --</option>
                <option value='A'>Approve</option>
                <option value='R'>Reject</option>
              </select>
            </td>
           
              <td width="30%"> 
              <textarea name="dvapproveremark" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_DV_APPREMARK"))%></textarea>
            </td>
          </tr>  
                     <tr class="datagrid">
             <td nowrap="nowrap" width="20%">&nbsp&nbsp&nbsp&nbsp Networth
              
            </td>
            <td width="10%"> 
              <input type="text" size='5' name="netwpbm" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("FAC_NETW_PBM"))%>">
            </td>
             <td width="10%"> 
              <input type="text" size='5' name="netwact" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("FAC_NETW_ACT"))%>">
            </td>
            <td align="center" width="10%"> 
              <select name="netwdev">
                <option value="N" selected="selected">No</option>
                <option value="Y">Yes</option>
              </select>
            </td>
           
            <td width="30%"> 
              <textarea name="netwremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_NETW_REMARKS"))%></textarea>
            </td>
            <td width="10%" align="center"> 
              <select name="netwapprove">
                <option value='S' selected="selected">-- Select --</option>
                <option value='A'>Approve</option>
                <option value='R'>Reject</option>
              </select>
            </td>
           
              <td width="30%"> 
              <textarea name="netwapproveremark" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_NETW_APPREMARK"))%></textarea>
            </td>
          </tr>  
                     <tr class="datagrid">
             <td nowrap="nowrap" width="20%"> &nbsp&nbsp&nbsp&nbsp Sales&Others
              
            </td>
            <td width="10%"> 
              
              <input type="text" size='5' name="saopbm" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("FAC_SELANDOTH_PBM"))%>">
            </td>
            <td width="10%"> 
              <input type="text" size='5' name="saoact" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("FAC_SELANDOTH_ACT"))%>">
            </td>
            <td align="center" width="10%"> 
              <select name="saodev">
                <option value="N" selected="selected">No</option>
                <option value="Y">Yes</option>
              </select>
            </td>
            
            <td width="30%"> 
              <textarea name="saoremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_SELANDOTH_REMARKS"))%></textarea>
            </td>
            <td width="10%" align="center"> 
              <select name="saoapprove">
                <option value='S' selected="selected">-- Select --</option>
                <option value='A'>Approve</option>
                <option value='R'>Reject</option>
              </select>
              
            </td>
            
            <td width="30%"> 
              <textarea name="saoapproveremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_SELANDOTH_APPREMARK"))%></textarea>
            </td>
          </tr>         
          <tr class="datagrid"> 
            <td width="20%">Account statement and cheque Returns <span class="mantatory">*</span>
            </td>
            <td >
            </td>
            <td >
            </td>
            <td >
            </td>
      
           <td width="30%"> 
              <textarea name="accstachkremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_SELANDOTH_APPREMARK"))%></textarea>
            </td>
            <td width="10%" align="center"> 
              <select name="accstachkapprove">
                <option value='S' selected="selected">-- Select --</option>
                <option value='A'>Approve</option>
                <option value='R'>Reject</option>
              </select>
            </td>
           
            <td width="30%"> 
              <textarea name="accstachkapproveremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_ACC_STMNT_CHQRTN_APPREMARK"))%></textarea>
            </td>
          </tr>
   
          <tr class="datagrid"> 
            <td width="20%">Fraud check - CFR Hunter ,Jacota  <span class="mantatory">*</span>
            </td>
           </td>
            <td >
            </td>
            <td>
            </td>
            <td>
            </td>
      
           <td width="30%"> 
              <textarea name="fraudchkremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_FRAUD_CHK_REMARKS"))%></textarea>
            </td>
            <td width="10%" align="center"> 
              <select name="fraudchkapprove">
                <option value='S' selected="selected">-- Select --</option>
                <option value='A'>Approve</option>
                <option value='R'>Reject</option>
              </select>
            </td>
           
            <td width="30%"> 
              <textarea name="fraudchkapproveremark" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_FRAUD_CHK_APPREMARK"))%></textarea>
            </td>
          </tr>
          <tr class="datagrid"> 
            <td width="20%">Income Tax Return<span class="mantatory">*</span>
              <input type="hidden" size='10' name="txt_otherdivtype" style="text-align:right" value="OD">
            </td>
            </td>
            <td>
            </td>
            <td >
            </td>
            <td >
            </td>
      
           <td width="30%"> 
              <textarea name="taxremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_IN_TAX_RTN_REMARKS"))%></textarea>
            </td>
            <td width="10%" align="center"> 
              <select name="taxapprove">
                <option value='S' selected="selected">-- Select --</option>
                <option value='A'>Approve</option>
                <option value='R'>Reject</option>
              </select>
            </td>
            
            <td width="30%"> 
              <textarea name="taxapproveremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_IN_TAX_RTN_APPREMARK"))%></textarea>
            </td>
          </tr>
          <tr class="datagrid"> 
            <td width="10%">Any other deviations<span class="mantatory" >*</span>
            </td>
            </td>
            <td >
            </td>
            <td >
            </td>
            <td >
            </td>
      
           <td width="30%"> 
              <textarea name="anyotherremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_ANY_OTH_DEV_REMARKS"))%></textarea>
            </td>
            <td width="10%" align="center"> 
              <select name="anyotherapprove">
                <option value='S' selected="selected">-- Select --</option>
                <option value='A'>Approve</option>
                <option value='R'>Reject</option>
              </select>
            </td>
            
            <td width="30%"> 
              <textarea name="anyotherapproveremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_ANY_OTH_DEV_APPREMARK"))%></textarea>
            </td>
          </tr>
        </table>
				</td>
			</tr>
		</table>
		<br>
		<table  class="outertable" align="center">
		<tr class="datagrid">
		<td>
		Permitting Autarity Remarks
		</td>
		<td>
		 <textarea name="perauttremar" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("FAC_PERMIT_AUT_REM"))%></textarea>
		</td>
		</tr>
		<tr class="datagrid">
		<td>
		Additional interest if any :
		</td>
		<td align="center" width="10%"> 
              <select name="additint">
                <option value='S' selected="selected">-- Select --</option>
                <option value='Y'>Yes</option>
                <option value='N'>No</option>
              </select>
            </td>
            <td>
            <input type="text" name="additintval" value="<%=Helper.correctNull((String)hshValues.get("FAC_ADD_INT_VAL"))%>">
            </td>
		</tr>
		<tr class="datagrid">
		<td>
		Handling charges if any :
		</td>
		<td align="center" width="10%"> 
              <select name="handcharge">
                <option value='S' selected="selected">-- Select --</option>
                <option value='Y'>Yes</option>
                <option value='N'>No</option>
              </select>
            </td>
            <td>
            <input type="text" name="handchargesval" value="<%=Helper.correctNull((String)hshValues.get("FAC_HAND_CHA_VAL"))%>">
            </td>
		</tr>
		</table>
  <br>
  <table width="98%" border="0" cellspacing="0" cellpadding="5" class="shadow" align="center" bordercolordark="#B6C1D2" bordercolorlight="#FFFFFF">
	<tr>
		<td valign="top">
		<table width="90%" border="0" align="center" cellspacing="0" cellpadding="5">
          <tr> 
            <td valign="top" colspan="3"> 
         
              <table width="100%" border="0" class="outertable border1" align="center" cellspacing="0" cellpadding="4">
              <tr>
              <td>
              <table width="100%" border="0" align="center" cellspacing="3" cellpadding="3" >
                <tr align="center" > 
                  <td  nowrap="nowrap" class="dataheader">Details</td>
                  <td  class="dataheader"><b>Name</b></td>
                  <td  class="dataheader"><b>Designation</b></td>
                </tr>
                <tr> 
                <td width="25%" align="center"><select name="sel_details"  style="width:150px" onchange="checkval();">
											<option value="" selected="selected">----Select----</option>
											<option value="V"> Vetted By</option>
											<option value="A"> Appraised By</option>
										</select></td>	
                   <td width="25%" align="center"><input type="text" name="txt_name" size="35"
									maxlength="15"  readonly> <span
									onClick="callSearch()" style="cursor: hand"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0"></span></td>
                  <td width="25%" align="center"> 
                    <input type="hidden" name="txt_desig" maxlength="40" size="40" readOnly>
                    <input type="text" name="txt_desig1" maxlength="40" size="40" readOnly></td>
										
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
							<DIV class="cellContainer"> 
<table width="58%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor" align="center">
	<tr class="dataheader">
		<td>&nbsp;</td>
		
		<td align="center" style="width:30%;"><b>Name</b></td>
		<td align="center" style="width:16%;"><b>Designation</b></td>
		<td align="center" style="width:16%;"><b>Details</b></td>
		
	
	</tr>
	 <%
						//ArrayList arryRow=new ArrayList();
						String strSno = "",Strdetails="";
			if(hshValues!=null)
			{
				arryRow=(ArrayList)hshValues.get("arrRoww");
				
			}
			
			if(arryRow!=null && arryRow.size()>0)
					{
			
				
				
			for(int i=0;i<arryRow.size();i++)
							{
								arryCol=(ArrayList)arryRow.get(i); 
								
%>
	
	<tr valign="top"  class="datagrid">
		<td width="3%"><input type="radio" name="radio_impln"
			onclick="selectValues('<%=Helper.correctNull((String)arryCol.get(0))%>',
					'<%=Helper.correctNull((String)arryCol.get(1))%>',
					'<%=Helper.correctNull((String)arryCol.get(2))%>',
					'<%=Helper.correctNull((String)arryCol.get(3))%>'
					
					)"
			style="border: none"> 
			 
		<td style="width:30%; m" ><input type="hidden" name="hiduserID" value="<%=Helper.correctNull((String)arryCol.get(0))%>">
		<input type="hidden" name="hidDetails" value="<%=Helper.correctNull((String)arryCol.get(3))%>"><%=Helper.correctNull((String)arryCol.get(1))%></td>
		<td style="width:16%;"><%=Helper.correctNull((String)arryCol.get(2))%></td>
			<td style="width:16%;" ><%if(Helper.correctNull((String)arryCol.get(3)).equalsIgnoreCase("S")){ %>Permitted By<%}else if(Helper.correctNull((String)arryCol.get(3)).equalsIgnoreCase("A")){ %>Appraised By<%}
					else if(Helper.correctNull((String)arryCol.get(3)).equalsIgnoreCase("V")){ %>Vetted By<%}else{%>&nbsp;<%} %></td>
			
	
	</tr>
	<%}}%>
	
	
	
</table>
</DIV>
  <br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Undo_Permit' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 

<lapschoice:hiddentag pageid='<%=PageId%>' />
<br>

<input type="hidden" name="txtuserID" value="">

<input type="hidden" name="appraisedby" value="<%=Helper.correctNull((String)hshValues.get("appraised"))%>">
<input type="hidden" name="vettedby" value="<%=Helper.correctNull((String)hshValues.get("vetted"))%>">
<input type ="hidden" name="hidfacility" value="">
<input type ="hidden" name="fordelete" value="">
<input type ="hidden" name="limitamountfrom" value="<%=Helper.correctNull((String)hshValues.get("limitamtfrom"))%>">
<input type ="hidden" name="limitamountto" value="<%=Helper.correctNull((String)hshValues.get("limitamtto"))%>">
<input type ="hidden" name="monmin" value="<%=Helper.correctNull((String)hshValues.get("limitmonmin"))%>">
<input type ="hidden" name="monmax" value="<%=Helper.correctNull((String)hshValues.get("limitmonmax"))%>">
</form>
</body>
</html>
