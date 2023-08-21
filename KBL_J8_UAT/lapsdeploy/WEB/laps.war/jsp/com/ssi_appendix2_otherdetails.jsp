<% /**
*author:S.SATHYA MOORTHY.
*CREATED FOR OTHER DETAILS
*
**/
%>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%

String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));
String strSSIType  =Helper.correctNull((String)request.getParameter("hidSSIType"));
String strBorrowerType =Helper.correctNull((String)request.getParameter("hidBorrowerType"));

%>
<html>
<head>
<title>Raw Materials / Input</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<style type="text/css">
<!--
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
a:hover {  color: #FF3300}
-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 380;
  overflow: auto;
}
</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript"src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function Help()
{
	  var varString =appUrl+"jsp/sethlp/hlp_ssiappendix2ma.jsp"
	   var title = "Documents";
		var prop = "scrollbars=no,width=600,height=450";	
		prop = prop + ",left=50,top=150";
		window.open(varString,title,prop);
}


function callDisable(one)
{
	
}

function disableControls(bcmdEdit,bcmdApply,bcmdCancel,bcmddelete,bcmdClose)
{

	document.forms[0].cmdedit.disabled=bcmdEdit;
	document.forms[0].cmdapply.disabled=bcmdApply;
	document.forms[0].cmdcancel.disabled=bcmdCancel;
	document.forms[0].cmddelete.disabled=bcmddelete;
	document.forms[0].cmdclose.disabled=bcmdClose;
}


function onloading()
{	
	if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
		{
			disableControls(true,true,true,true,false);
		}else {
			disableControls(false,true,true,true,false);
	
			document.forms[0].txt_avgmonthlysales.disabled=true;
			document.forms[0].txt_electricpowerrequired.disabled=true;
			document.forms[0].txt_unskilledlabour.disabled=true;
			document.forms[0].txt_skilledlabour.disabled=true;
			document.forms[0].txt_supervisor.disabled=true;
			document.forms[0].txt_officers.disabled=true;

	
	callDisable(true);
	}
}

function onEdit()
{
	callDisable(false);
	disableControls(true,false,false,false,true);
	document.forms[0].txt_avgmonthlysales.disabled=false;
	document.forms[0].txt_electricpowerrequired.disabled=false;
	document.forms[0].txt_unskilledlabour.disabled=false;
	document.forms[0].txt_skilledlabour.disabled=false;
	document.forms[0].txt_supervisor.disabled=false;
	document.forms[0].txt_officers.disabled=false;

}


function doSave()
{	
	disableControls(true,true,true,true,false);
	document.forms[0].hidAction.value="update";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].hidBeanMethod.value="updateotherdetails1";
		document.forms[0].hidBeanGetMethod.value="getotherdetailsData1";
		document.forms[0].hidSourceUrl.value="/action/ssi_appendix2_otherdetails.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
}

function OnDelete()
{
	document.forms[0].hidAction.value="delete";
	if(!ConfirmMsg("101"))
    {
		return false;
	}
	   document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].hidBeanMethod.value="updateotherdetails1";
		document.forms[0].hidBeanGetMethod.value="getotherdetailsData1";
		document.forms[0].hidSourceUrl.value="/action/ssi_appendix2_otherdetails.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
}

function onCancel()
{	
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidBeanGetMethod.value="getotherdetailsData1";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].action=appUrl+"action/ssi_appendix2_otherdetails.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}


function onClose()
{
var cattype=document.forms[0].cattype.value;
	var id=document.forms[0].id.value;
 if((cattype=="ASSI")||(cattype=="ASBI")||(cattype=="OPS"))
        {
       if(ConfirmMsg(100))
	 { 
		//document.forms[0].action=appURL+"action/agrsearch.jsp?&id="+document.forms[0].id.value;
		document.forms[0].action=appUrl+"action/agrborrowersearch.jsp";
		document.forms[0].submit();
	 }
		}
		if((cattype=="SSI")||(cattype=="CORP")||(cattype=="SME"))
        {
        if(ConfirmMsg(100))
	 {
		document.forms[0].action=appURL+"action/comsearch.jsp?&id="+document.forms[0].id.value;
		document.forms[0].submit();
	 }
		}

}

function callVehicleDetails()
{
//	document.forms[0].hidBeanGetMethod.value="getAllVehicleDetails";
//	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].action=appUrl+"action/ops_vehicledetails.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}

</script>
</head>

<body class="bgcolor" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="onloading()" bgcolor="#EEEAE3">
<form method="post" name="fltintrate">
<jsp:include page="../share/help.jsp" flush="true"/> 

  <table width="100%" border="1" cellspacing="0" cellpadding="0" class="outertablecolor" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  >
    <tr> 
      <td> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true">
        <jsp:param name="pageid" value="9" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
	    <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
	</table>
   
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colspan=5><b><i><font face="Times New Roman, Times, serif" size="3">Home 
				-&gt;  Application-&gt; Appendix    -&gt;Other Details
 
 </font></i></b></td>
          </tr>
        </table>
<span style="display:none"><laps:borrowertype /></span> <laps:application/>   <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td valign="top" class="outertablecolor"> 
        <table width="65%" border="0" cellspacing="3" cellpadding="2">
          <tr> 
            <td width="20%" height="20" class="tabinactive"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="javascript:callFunction('ssi_appendix2_landbuilding.jsp','getGeneralDetails','LandLocation^LandArea^LandFreeHoldLeaseHold^PurchasePriceOfLand^RentForLeaseLand^LandTermsOfLease^LandYearlyGroundRent^BuildingLocation^BuildingOwnedOrLease^PurchasePriceOfBuilding^RentForLeaseOrRentedBuilding^BuildingTermsOfLease','AppendixIILandAndBuilding')"class="blackfont"> 
                Land &amp; Building </a></font></b></font></div>
            </td>
            <td width="20%" height="20" class="tabinactive"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="javascript:callFunction('ssi_appendix2_structure.jsp','getAnnexure2Structure','','AppendixIIStructure')"class="blackfont"> 
                Structure </a></font></b></font></div>
            </td>
            <td width="20%" height="20" class="tabinactive"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="javascript:callFunction('ssi_appendix2_proposedbuilding.jsp','getAnnexure2ProposedBuilding','','AppendixIIProposedBuilding')"class="blackfont">Building 
                Proposed </a></font></b></font></div>
            </td>
             <td width="20%" height="20" class="tabinactive"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="javascript:callFunction('ssi_appendix2_machinerydetails.jsp','getAnnexure2MachineryDetails','','AnnexureIIMachineryDetails')"class="blackfont">Machinery 
                Details </a></font></b></font></div>
            </td>
            <td width="20%" height="20" class="tabinactive">
            	<div align="center"><font face="MS Sans Serif" size="1"><b><a href="javascript:callVehicleDetails()" class="blackfont">Vehicle Details</a></b></font></div>
            </td>
            <td width="20%" height="20" class="tabactive" bgcolor="#71694F"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1" color="#FFFFFF">Other
                Details</font></b></font></div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" class="outertablecolor">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" align="center" height="139%">
          <tr> 
            <td valign="top" height="177"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr> 
                  <td colspan="2"> 
                    <table width="100%" border="0" cellspacing="3" cellpadding="0" height="417">
                      <tr> 
                        <td width="19%"><b>Average Monthly Sales </b></td>
                        <td width="30%"> 
                          <input type="text" name="txt_avgmonthlysales" value="<%=Helper.correctNull((String)hshValues.get("txt_avgmonthlysales"))%>" ONKEYPRESS="allowNumber(this)">
                        </td>
                        <td width="17%"><b>Electric Power Required </b></td>
                        <td width="34%"> 
                          <input type="text" name="txt_electricpowerrequired"  value="<%=Helper.correctNull((String)hshValues.get("txt_electricpowerrequired"))%>">
                        </td>
                      </tr>
                      <tr> 
                        <td width="19%" height="51"><b>Un Skilled Labour</b></td>
                        <td width="30%" height="51"> 
                          <textarea name="txt_unskilledlabour" rows=4 cols=25 onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)"><%=Helper.correctNull((String)hshValues.get("txt_unskilledlabour"))%></textarea>
                        </td>
                        <td width="17%" height="51"><b>Skilled Labour </b></td>
                        <td width="34%" height="51"> 
                          <textarea name="txt_skilledlabour" rows=4 cols=25 onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)"><%=Helper.correctNull((String)hshValues.get("txt_skilledlabour"))%></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td width="19%"><b>Supervisor</b></td>
                        <td width="30%"> 
                          <textarea name="txt_supervisor" rows=4 cols=25 onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)"><%=Helper.correctNull((String)hshValues.get("txt_supervisor"))%></textarea>
                        </td>
                        <td width="17%"><b>Officer</b></td>
                        <td width="34%"> 
                          <textarea name="txt_officers" rows=4 cols=25  onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)"><%=Helper.correctNull((String)hshValues.get("txt_officers"))%></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td width="19%">&nbsp;</td>
                        <td width="30%">&nbsp;</td>
                        <td width="17%">&nbsp;</td>
                        <td width="34%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="19%" height="47">&nbsp;</td>
                        <td width="30%" height="47">&nbsp;</td>
                        <td width="17%" height="47">&nbsp;</td>
                        <td width="34%" height="47">&nbsp;</td>
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

  <table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center" class="outertablecolor">
    <tr  bordercolordark="#FFFFFB" bordercolorlight="#8F8369"> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2" align="center" >
          <tr valign="top"> 
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdedit" value="Edit" onClick="onEdit()"  class="buttonStyle">
              </div>
            </td>
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdapply" value="Apply" onClick="doSave()"  class="buttonStyle">
              </div>
            </td>
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdcancel" value="Cancel" onClick="onCancel()"  class="buttonStyle">
              </div>
            </td>
			 <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmddelete" value="Delete" onClick="OnDelete()"  class="buttonStyle">
              </div>
            </td>
            <td width="15%"> 
              <div align="center"> 
                <input type="button" name="cmdhelp" value="Help"  onClick="Help()" class="buttonHelp">
              </div>
            </td>
            <td width="15%"> 
              <div align="center"> 
                <input type="button" name="cmdclose" value="Close" onClick="onClose()" class="buttonClose">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>

<input type="hidden" name="hidTabName" value="AnnexureIIMachineryDetails">

<input type="hidden" name="hidTotalDesc" value="4">
<input type="hidden" name="hidFieldPrefix" value="">
<INPUT TYPE="hidden" NAME="hidparam" VALUE="">
<INPUT TYPE="hidden" NAME="hidMethod" VALUE="">

<INPUT TYPE="hidden" NAME="hidGenID" VALUE="">

<input type="hidden" name="hidAction" value="">
<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidSourceUrl" value="">
<input type="hidden" name="comapp_id" value="<%=request.getParameter("comapp_id")%>">
<input type="hidden" name="otherGenTable" value="">
<input type="hidden" name="hidOtherMethod" value="">
<input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
<input type="hidden" name="ssitype" value="<%=strSSIType%>"> 
 <input type="hidden" name="id" value="<%=strBorrowerType%>">	

</form>
</body>
</html>
