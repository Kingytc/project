<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%

ArrayList vecRow = new ArrayList();
ArrayList vecCol = new ArrayList();
String strgenid="";

int vecrowsize =0;

if(hshValues.size()>0 && hshValues != null)
{
	vecRow = (ArrayList)hshValues.get("vecRow");
	vecrowsize = vecRow.size();
	if(vecrowsize>0)

	//for(int i=0;i<4;i++)
	{//	vecCol =(ArrayList)vecRow.get(i);
		//strgenid=strgenid+Helper.correctNull((String)vecCol.get(0))+",";
	}

	if(!strgenid.equals(""))
	{
	strgenid=strgenid.substring(0,(strgenid.length())-1);	
	}

}
else
{
	strgenid ="0";
}

String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));
String strSSIType  =Helper.correctNull((String)request.getParameter("hidSSIType"));
String strBorrowerType =Helper.correctNull((String)request.getParameter("hidBorrowerType"));
String strcat="";
if(!strCategoryType.equalsIgnoreCase(""))
{
	if(strCategoryType.equalsIgnoreCase("OPS"))
	{
		strcat="Tertiary";
	}
	else 
	{
		strcat="Corporate";
	}
		
}
%>
<html>
<head>
<title>Small Scale Industries</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}

-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 250;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
.tabfont {  font-family: "MS Sans Serif"; font-size: 10px; color: #000000; text-decoration: none}
a:hover {  color: #FF3300}
</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript"src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var genid = "<%=strgenid%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function doHelp1()
{
	  var varString = appUrl+"jsp/sethlp/hlp_ssiappendix2str.jsp"
	   var title = "Documents";
		var prop = "scrollbars=no,width=600,height=450";	
		prop = prop + ",left=50,top=150";
		window.open(varString,title,prop);
}

function callDisable(one)
{
	for( i=1;i<=4;i++)		
	{	

		document.forms[0].elements["txt_structure1"+i].readOnly=one;
		document.forms[0].elements["txt_structure2"+i].readOnly=one;
		document.forms[0].elements["txt_structure3"+i].readOnly=one;
		document.forms[0].elements["txt_structure4"+i].readOnly=one;
		document.forms[0].elements["txt_structure5"+i].readOnly=one;
	}		
		
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
			document.forms[0].hidGenID.value=genid;
			disableControls(false,true,true,true,false);
			callDisable(true);
		}
}

function onEdit()
{
	callDisable(false);
	disableControls(true,false,false,false,true);

}


function doSave()
{	
//	for( i=1;i<=4;i++)		
//	{	
//
//		if(checktrim(document.forms[0].elements["txt_structure1"+i].value)=="" || checktrim(document.forms[0].elements["txt_structure5"+i].value)=="")
//		{
//			alert("Enter Date of Erection "+i);
//			return false;
//		}
//		
//	}		
	
	disableControls(true,true,true,true,false);
	document.forms[0].hidBeanGetMethod.value="updateAnnexure2StructureData";
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].action=appUrl+"action/ssi_appendix2_structure.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function OnDelete()
{
	document.forms[0].hidAction.value="Delete";
	if(!ConfirmMsg("101"))
    {
		return false;
	}
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].hidBeanMethod.value="updateAnnexure2StructureData";
	document.forms[0].hidSourceUrl.value="/action/ssi_appendix2_structure.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function onCancel()
{	
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidMethod.value="getAnnexure2Structure";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].action=appUrl+"action/ssi_appendix2_structure.jsp";
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

function callFunction(pagename,methodname,param,tabname)
{
	if(methodname=="getGeneralDetails")
	{
		document.forms[0].hidparam.value =param;
	}
	document.forms[0].method="post";	
	document.forms[0].hidTabName.value=tabname;	
	document.forms[0].hidMethod.value=methodname;	
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}


//added by s.sathya moorthy

function callOtherDetails()
{
		document.forms[0].hidBeanGetMethod.value="getotherdetailsData1";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].action=appUrl+"action/ssi_appendix2_otherdetails.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();

}

function callCalender(fname)
{
 	if(document.forms[0].cmdedit.disabled)
 	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}

function callVehicleDetails()
{
	document.forms[0].hidBeanGetMethod.value="getAllVehicleDetails";
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].action=appUrl+"action/ops_vehicledetails.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
</script>


</head>

<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" class="bgcolor" onload="onloading()" bgcolor="#EEEAE3">
<form name="fininc" method="post">
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
  
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colspan=5><b><i><font face="Times New Roman, Times, serif" size="3">Home 
				-&gt;<%=strcat %>-&gt; Application-&gt; Appendix    -&gt;Structure  
 
 </font></i></b></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
<span style="display:none"><laps:borrowertype /></span> <laps:application/> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td valign="top" class="outertablecolor"> 
        <table width="65%" border="0" cellspacing="3" cellpadding="2">
          <tr> 
            <td width="20%" height="20" class="tabinactive"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="javascript:callFunction('ssi_appendix2_landbuilding.jsp','getGeneralDetails','LandLocation^LandArea^LandFreeHoldLeaseHold^PurchasePriceOfLand^RentForLeaseLand^LandTermsOfLease^LandYearlyGroundRent^BuildingLocation^BuildingOwnedOrLease^PurchasePriceOfBuilding^RentForLeaseOrRentedBuilding^BuildingTermsOfLease','AppendixIILandAndBuilding')"class="blackfont"> 
                Land &amp; Building </a></font></b></font></div>
            </td>
            <td width="20%" height="20" class="tabactive" bgcolor="#71694F"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1" color="#FFFFFF">Structure</font></b></font></div>
            </td>
            <td width="20%" height="20" class="tabinactive" align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="javascript:callFunction('ssi_appendix2_proposedbuilding.jsp','getAnnexure2ProposedBuilding','','AppendixIIProposedBuilding')"class="blackfont"> 
              Building Proposed </a></font></b></font></td>
            <td width="20%" height="20" class="tabinactive"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="javascript:callFunction('ssi_appendix2_machinerydetails.jsp','getAnnexure2MachineryDetails','','AnnexureIIMachineryDetails')"class="blackfont">Machinery 
                Details </a></font></b></font></div>
            </td>
            <td width="20%" height="20" class="tabinactive">
            	<div align="center"><font face="MS Sans Serif" size="1"><b><a href="javascript:callVehicleDetails()" class="blackfont">Vehicle Details</a></b></font></div>
            </td><!--
            <td width="20%" height="20" class="tabinactive"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="javascript:callOtherDetails()"class="blackfont">Other Details </a></font></b></font></div>
            </td>
          --></tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" onMouseOver=" " class="outertablecolor">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" height="100%" >
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5">
                <tr> 
                  <td> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="1" cellpadding="3">
                            <tr bgcolor="#71694F"> 
                              <td width="16%" align="center" class="tabactive"><font  color="#FFFFFF">Structure</font></td>
                              <td width="16%" align="center" class="tabactive"><font  color="#FFFFFF">Type 
                                of Structure(indicate P if permanent)</font></td>
                              <td width="16%" align="center" class="tabactive"><font  color="#FFFFFF">Dimension</font></td>
                              <td width="16%" align="center" class="tabactive"><font  color="#FFFFFF">Area 
                                (in sq.mts)</font></td>
                              <td width="16%" align="center" class="tabactive"><font  color="#FFFFFF">Actual 
                                Cost </font></td>
                              <td width="15%" align="center" class="tabactive"><font  color="#FFFFFF">Date 
                                of Erection</font></td>
                            </tr>
                            <%
					if(hshValues.size()>0 && hshValues != null && vecrowsize >0)
					{
						
						if(vecrowsize>=1)
						{
							vecCol =(ArrayList)vecRow.get(0);
					%>
                            <tr> 
                              <td width="16%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">1) 
                                Workshop</font></td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure11" size="15" maxlength="50" VALUE="<%=vecCol.get(1)%>" >
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure21" size="15" maxlength="50" VALUE="<%=vecCol.get(2)%>"> 
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure31" size="15" maxlength="10" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" VALUE="<%=vecCol.get(3)%>">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure41" size="15" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10" VALUE="<%=vecCol.get(4)%>" >
                              </td>
                              <td width="15%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure51" size="15"  onBlur="checkDate(this)" VALUE="<%=vecCol.get(5)%>" >
                                <a alt="Select date from calender"  href="javascript:callCalender('txt_structure51')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
                              </td>
                            </tr>
                            <%
								}
							else
							{
							%>
                            <tr> 
                              <td width="16%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">1) 
                                Workshop</font></td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure11" size="15" maxlength="50" >
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure21" size="15" maxlength="50">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure31" size="15" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure41" size="15" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)"  maxlength="10">
                              </td>
                              <td width="15%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure51" size="15"  onBlur="checkDate(this)" >
                                <a alt="Select date from calender"  href="javascript:callCalender('txt_structure51')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
                              </td>
                            </tr>
                            <%
							}
							if(vecrowsize >=2)
							{
							vecCol =(ArrayList)vecRow.get(1);
							%>
                            <tr> 
                              <td width="16%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">2) 
                                Godown </font></td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure12" size="15" VALUE="<%=vecCol.get(1)%>" maxlength="50" >
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure22" size="15" VALUE="<%=vecCol.get(2)%>" maxlength="50">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure32" size="15" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10" VALUE="<%=vecCol.get(3)%>" >
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure42" size="15" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10" VALUE="<%=vecCol.get(4)%>" >
                              </td>
                              <td width="15%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure52" size="15" onBlur="checkDate(this)" VALUE="<%=vecCol.get(5)%>" >
                                <a alt="Select date from calender"  href="javascript:callCalender('txt_structure52')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
                              </td>
                            </tr>
                            <%
							}
							else
							{
						   %>
                            <tr> 
                              <td width="16%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">2) 
                                Godown </font></td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure12" size="15" maxlength="50">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure22" size="15" maxlength="50" >
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure32" size="15" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure42" size="15" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10" >
                              </td>
                              <td width="15%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure52" size="15" onBlur="checkDate(this)"  >
                                <a alt="Select date from calender"  href="javascript:callCalender('txt_structure52')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
                              </td>
                            </tr>
                            <%
							}
							if(vecrowsize >=3)
							{
							vecCol =(ArrayList)vecRow.get(2);
							%>
                            <tr> 
                              <td width="16%" bgcolor="#EEEAE3"><font face="MS Sans Serif" size="1">3) 
                                Administrative </font></td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure13" size="15" maxlength="50" VALUE="<%=vecCol.get(1)%>" >
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure23" size="15" maxlength="50" VALUE="<%=vecCol.get(2)%>" >
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure33" size="15" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10" VALUE="<%=vecCol.get(3)%>" >
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure43" size="15" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10" VALUE="<%=vecCol.get(4)%>" >
                              </td>
                              <td width="15%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure53" size="15" onBlur="checkDate(this)" VALUE="<%=vecCol.get(5)%>"  >
                                <a alt="Select date from calender"  href="javascript:callCalender('txt_structure53')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
                              </td>
                            </tr>
                            <%
							}
							else
							{
							%>
                            <tr> 
                              <td width="16%" bgcolor="#EEEAE3"><font face="MS Sans Serif" size="1">3) 
                                Administrative </font></td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure13" size="15"  maxlength="50">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure23" size="15" maxlength="50">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure33" size="15" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure43" size="15" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10">
                              </td>
                              <td width="15%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure53" size="15" onBlur="checkDate(this)" >
                                <a alt="Select date from calender"  href="javascript:callCalender('txt_structure53')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
                              </td>
                            </tr>
                            <%
							}
							if(vecrowsize >=4)
							{
							vecCol =(ArrayList)vecRow.get(3);
							%>
                            <tr> 
                              <td width="16%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">4) 
                                Other Buildings</font></td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure14" size="15" VALUE="<%=vecCol.get(1)%>" maxlength="50">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure24" size="15" VALUE="<%=vecCol.get(2)%>" maxlength="50">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure34" size="15" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10" VALUE="<%=vecCol.get(3)%>" >
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure44" size="15" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10" VALUE="<%=vecCol.get(4)%>" >
                              </td>
                              <td width="15%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure54" size="15" onBlur="checkDate(this)" VALUE="<%=vecCol.get(5)%>" >
                                <a alt="Select date from calender"  href="javascript:callCalender('txt_structure54')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
                              </td>
                            </tr>
                            <%
							}
							else
							{
							%>
                            <tr> 
                              <td width="16%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">4) 
                                Other Buildings</font></td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure14" size="15" maxlength="50">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure24" size="15" maxlength="50">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure34" size="15" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure44" size="15" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10">
                              </td>
                              <td width="15%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure54" size="15" onBlur="checkDate(this)">
                                <a alt="Select date from calender"  href="javascript:callCalender('txt_structure54')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
                              </td>
                            </tr>
                            <%
							}
						  }
						  else
						  {
						%>
                            <tr> 
                              <td width="16%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">1) 
                                Workshop</font></td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure11" size="15" value="" maxlength="50">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure21" size="15" value="" maxlength="50">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure31" size="15" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" value="" maxlength="10">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure41" size="15" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)"  value="" maxlength="10">
                              </td>
                              <td width="15%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure51" size="15"  onBlur="checkDate(this)" value="">
                                <a alt="Select date from calender"  href="javascript:callCalender('txt_structure51')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
                              </td>
                            </tr>
                            <tr> 
                              <td width="16%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">2) 
                                Godown </font></td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure12" size="15" value="" maxlength="50">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure22" size="15" value="" maxlength="50">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure32" size="15" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" value="" maxlength="10">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure42" size="15" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" value="" maxlength="10">
                              </td>
                              <td width="15%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure52" size="15" onBlur="checkDate(this)"  value="" maxlength="12">
                                <a alt="Select date from calender"  href="javascript:callCalender('txt_structure52')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
                              </td>
                            </tr>
                            <tr> 
                              <td width="16%" bgcolor="#EEEAE3"><font face="MS Sans Serif" size="1">3) 
                                Administrative </font></td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure13" size="15" maxlength="50" value="">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure23" size="15" value="" maxlength="50">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure33" size="15" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" value="" maxlength="10">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure43" size="15" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" value="" maxlength="10">
                              </td>
                              <td width="15%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure53" size="15" onBlur="checkDate(this)" value="">
                                <a alt="Select date from calender"  href="javascript:callCalender('txt_structure53')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
                              </td>
                            </tr>
                            <tr> 
                              <td width="16%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">4) 
                                Other Buildings</font></td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure14" size="15" value="" maxlength="50">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure24" size="15" value="" maxlength="50">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure34" size="15" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" value="" maxlength="10">
                              </td>
                              <td width="16%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure44" size="15" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" value="" maxlength="10">
                              </td>
                              <td width="15%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="txt_structure54" size="15" onBlur="checkDate(this)" value="" maxlength="12">
                                <a alt="Select date from calender"  href="javascript:callCalender('txt_structure54')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
                              </td>
                            </tr>
                            <%
						  }
						%>
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
                <input type="button" name="cmdapply" value="Save" onClick="doSave()"  class="buttonStyle">
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
                <input type="button" name="cmdhelp" value="Help"  onClick="doHelp1()" class="buttonHelp">
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


<input type="hidden" name="hidTabName" value="AppendixIIStructure">


<input type="hidden" name="hidTotalDesc" value="4">
<input type="hidden" name="hidFieldPrefix" value="txt_structure">
<INPUT TYPE="hidden" NAME="hidparam" VALUE="">
<INPUT TYPE="hidden" NAME="hidMethod" VALUE="getAnnexure2Structure">

<INPUT TYPE="hidden" NAME="hidGenID" VALUE="">
<INPUT TYPE="hidden" NAME="hidAction" VALUE="">

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
