<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />        
<lapschoice:handleerror />
<%

session.setAttribute("CURRENT_TAB","");
ArrayList arrRecvRow = (ArrayList)hshValues.get("arrRow"); 
ArrayList arrRecvCol=new ArrayList();
session.setAttribute("hidRefId","");
String strOrgCode	=	Helper.correctNull((String)hshValues.get("strOrgCode"));
String strRadioButValue	=	Helper.correctNull((String)hshValues.get("strRadioButValue"));
String strBranchHeadflag=Helper.correctNull((String)hshValues.get("strBranchHead"));

String closeFlag = Helper.correctNull((String)hshValues.get("closeFlag"));
if(closeFlag=="")
{
session.setAttribute("hidRefId","");
}
String hidRefId =(String) session.getAttribute("hidRefId");
String showAlerMsg = Helper.correctNull((String)hshValues.get("showAlerMsg"));

session.setAttribute("strapprefid", Helper.correctNull((String) hshValues.get("apprefid")));
session.setAttribute("SegType", Helper.correctNull((String) hshValues.get("SegType")));
String strSegType= (String) session.getAttribute("SegType");
String strOrgLevel=Helper.correctNull((String)hshValues.get("strOrgLevel"));
String NPSegment=Helper.correctNull((String) hshValues.get("NPSegment"));
%>

<html>
<head>
<title>National Portal - MailBox</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>	
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var SessrefID = "<%=hidRefId%>";
var closeFlag = "<%=closeFlag%>";
var showAlertMsg = "<%=showAlerMsg%>";
var varUserId = "<%=Helper.correctNull((String) session.getAttribute("strUserId"))%>";

function callclose()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
	document.forms[0].submit();
}

function doLoadPage()
{
	//alert("hello");
	document.forms[0].hidBeanId.value="NationalPortal";
	document.forms[0].hidBeanGetMethod.value="PSB59getApplicationDetailsList";
	document.forms[0].action=appURL+"action/npInbox.jsp"
	document.forms[0].submit();
}


function callOnLoad()
{
	if(closeFlag=="Y")
	{
		callcbsid(SessrefID);
	}
	if(showAlertMsg!="")
	{
    alert(showAlertMsg);
	}
	var  segtypeval="<%=Helper.correctNull((String)hshValues.get("SegType"))%>";
	if(segtypeval==""){
		document.forms[0].sel_nsdlStatus.value = "S";
	}else{
	document.forms[0].sel_nsdlStatus.value = segtypeval;
	}

	/*if(segtypeval!="EDU"){
		document.all.CBSID.style.visibility="visible";
		document.all.CBSID.style.position="relative";

		//document.all.Accept.style.visibility="visible";
		//document.all.Accept.style.position="relative";
	}else{
		document.all.CBSID.style.visibility="hidden";
		document.all.CBSID.style.position="absolute";

		//document.all.Accept.style.visibility="hidden";
		//document.all.Accept.style.position="absolute";

	}*/
}

function  callAppStatusPopUp(Id,refId,varPopSchemeId)
{
var varsegment="<%=Helper.correctNull((String)hshValues.get("SegType"))%>";
	var Refno = refId;
	
	if(varsegment=="EDU"  ){
	
	document.forms[0].hidRefId.value=Refno;
	document.forms[0].hidBeanId.value="NationalPortal";
	document.forms[0].hidBeanGetMethod.value="getNP_ApplicantDeatis";
	document.forms[0].action=appUrl+"action/NP_applicantDetails.jsp";
	document.forms[0].submit();
		}else if(varsegment == "HL")
		{
			
	document.forms[0].hidRefId.value=Refno;
	document.forms[0].hidApplicantId.value = Refno;
	document.forms[0].hidBeanId.value="NationalPortal";
	document.forms[0].hidBeanGetMethod.value="getPSB59ApplicantListDtls";
	document.forms[0].action=appUrl+"action/psb59ApplicantDetails.jsp";
	document.forms[0].submit();
	}else if(varsegment == "AGRI")
		{
		document.forms[0].hidRefId.value=Refno;
		document.forms[0].hidrefId.value=Refno;
		document.forms[0].hidApplicantId.value = Refno;
		document.forms[0].hidBeanId.value="NationalPortal";
		document.forms[0].hidBeanGetMethod.value="getAGRIPersonalDetails";
		document.forms[0].action=appUrl+"action/PSB59PersonalDetails_Agri.jsp";
		document.forms[0].submit();
		}
		else if(varsegment == "BS" && varPopSchemeId == "PMMY")
		{
		document.forms[0].hidRefId.value=Refno;
		document.forms[0].hidApplicantId.value = Refno;
		document.forms[0].hidpopSchemeId.value = varPopSchemeId;
		document.forms[0].hidBeanId.value="NationalPortal";
		document.forms[0].hidBeanGetMethod.value="getBusmudrapersdetails";
		document.forms[0].action = appURL+"action/PSB59PersonalDetails_Mudra.jsp";
		document.forms[0].submit();
		}
		else if(varsegment == "BS" && varPopSchemeId == "SWMS")
		{
			
			document.forms[0].hidRefId.value=Refno;
			document.forms[0].hidApplicantId.value = Refno;
			document.forms[0].hidpopSchemeId.value = varPopSchemeId;
		document.forms[0].hidBeanId.value="NationalPortal";
		document.forms[0].hidBeanGetMethod.value="getBusSWMSpersonaldetails";
		document.forms[0].action = appURL+"action/PSB59PersonalDetails_SWMS.jsp";
		document.forms[0].submit();
		}
		else if(varsegment == "BS" && varPopSchemeId == "SRMS")
		{
			
		document.forms[0].hidRefId.value=Refno;
		document.forms[0].hidApplicantId.value = Refno;
		document.forms[0].hidpopSchemeId.value = varPopSchemeId;
		document.forms[0].hidBeanId.value="NationalPortal";
		document.forms[0].hidBeanGetMethod.value="getNULMPersonalDetails";
		document.forms[0].action = appURL+"action/PSB59PersonalDetails.jsp";
		document.forms[0].submit();
		}
		else if(varsegment == "BS" && (varPopSchemeId == "STANDUP"||varPopSchemeId == "STD"))
		{
		document.forms[0].hidRefId.value=Refno;
		document.forms[0].hidApplicantId.value = Refno;
		document.forms[0].hidpopSchemeId.value = varPopSchemeId;
		document.forms[0].hidBeanId.value="NationalPortal";
		document.forms[0].hidBeanGetMethod.value="getBusstandindiapersonaldet";
		document.forms[0].action = appURL+"action/PSB59PersonalDetails_STANDUP.jsp";
		document.forms[0].submit();
		}
		else if(varsegment == "LHD" ) 
		{
			
		document.forms[0].hidRefId.value=Refno;
		document.forms[0].hidpopSchemeId.value = varPopSchemeId;
		document.forms[0].hidApplicantId.value = Refno;
		document.forms[0].hidBeanId.value="NationalPortal";
		document.forms[0].hidBeanGetMethod.value="getNULMPersonalDetails";
		document.forms[0].action = appURL+"action/PSB59PersonalDetails.jsp";
		document.forms[0].submit();
		}


}

function callcbsid(refId)
{
	/*var	varQryString = appUrl+"action/psb59CBSIDfetch.jsp?;	
	var title = "ApplicationDetails";
	var prop = "scrollbars=yes,width=850,height=550";	
	var xpos = (screen.width - 500) / 2;
	var ypos = (screen.height - 400) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(varQryString,title,prop);
	document.forms[0].hidrefId.value = refId;
    document.forms[0].hidBeanId.value="PSB59";
   	document.forms[0].hidSourceUrl.value="/action/psb59CBSIDfetch.jsp";
	//document.forms[0].hidBeanMethod.value="PSB59updatenpinbox";
	document.forms[0].hidBeanGetMethod.value="PSB59getcbsidrecord";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();	
*/

	//var appno = "<%=Helper.correctNull((String)hshValues.get("strAppno"))%>";
	//var cbsccid = document.forms[0].txt_cbsid_msme.value;
	//var val_appID = document.forms[0].val_appID.value;
	document.forms[0].hidRefId.value = refId;
	
	var varQryString = appUrl+"action/psb59CBSIDfetch.jsp?hidBeanId=NationalPortal&hidBeanGetMethod=PSB59getcbsidrecord&RefId="+refId+"&hidRefId="+refId;
	//var	varQryString = appUrl+"action/psb59CBSIDfetch.jsp?hidBeanId=PSB59&hidBeanGetMethod=PSB59getcbsidrecord&RefId="+refId;
	var title = "CBSIDSerach";
	var prop = "scrollbars=yes,width=800,height=500,menubar=no";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=20,top=20";
	window.open(varQryString,title,prop);
}

/*function callhold(appStatus,refId)
{
	document.forms[0].hidAppStatus.value = appStatus;
	document.forms[0].hidApplicantId.value = refId;
	var varQryString=appURL+"action/psb59HoldReject.jsp?hidBeanId=PSB59&hidApplicantId="+refId+"&hidBeanGetMethod=PSB59getHoldRejStatus";
	var title = "HoldStatus";
	var prop = "scrollbars=yes,width=850,height=400";
	var xpos = (screen.width - 500) / 2;
	var ypos = (screen.height - 400) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(varQryString,title,prop);
}*/

function callreject(appStatus,refId,lapStatus)
{
	document.forms[0].hidAppStatus.value = appStatus;
	document.forms[0].hidApplicantId.value = refId;
	document.forms[0].hidUserId.value = varUserId;
	document.forms[0].hidlapstatus.value = lapStatus;
	
	var varQryString=appURL+"action/psb59HoldReject.jsp?hidBeanId=NationalPortal&hidApplicantId="+refId+"&hidBeanGetMethod=PSB59getHoldRejStatus&hidUserId="+document.forms[0].hidUserId.value+"&HidLapsStatus="+lapStatus;
	var title = "RejectStatus";
	var prop = "scrollbars=yes,width=850,height=400";
	var xpos = (screen.width - 500) / 2;
	var ypos = (screen.height - 400) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(varQryString,title,prop);
}

function callupdate(refId,schId,schName)
{
	
	var segType="<%=strSegType%>";
	if(segType=="EDU"){
		alert("Kindly Accept The Applicaion Before Proceeding for Status Update");
		return;
	}
	document.forms[0].hidApplicantId.value = refId;
	document.forms[0].hidschemeId.value = schId;
	document.forms[0].hidschemeName.value = schName;
	var varQryString = appURL+"action/psb59SancDisb.jsp?strRefId="+refId+"&hidschemeName="+schName;
	var title = "UpdateDetails";
	var prop = "scrollbars=yes,width=1150,height=450";
	window.open(varQryString,title,prop);
}

function docalReload()
{
	document.forms[0].hidBeanId.value="NationalPortal";
	document.forms[0].hidBeanGetMethod.value="PSB59updatenpinbox";
	document.forms[0].action=appURL+"action/npInbox.jsp";
	document.forms[0].submit();

}
function callaccept(Id,refId,appCode,schId,schName)
{
	
	document.forms[0].hidId.value = Id;
	document.forms[0].hidrefId.value = refId;
	document.forms[0].hidappCode.value = appCode;
	document.forms[0].hidschId.value = schId;
	document.forms[0].hidschName.value = schName;

    document.forms[0].hidBeanId.value="NationalPortal";
	document.forms[0].hidBeanGetMethod.value="PSB59updatenpinbox";
	//document.forms[0].hidBeanGetMethod.value="PSB59getApplicationDetailsList";
	document.forms[0].action = appURL+ "action/npInbox.jsp";
	document.forms[0].submit();
}

function callNpsegment(val) {
	
	document.forms[0].hidsegtype.value=val;
	if(document.forms[0].sel_nsdlStatus.value=="EDU" ||document.forms[0].sel_nsdlStatus.value=="HL" || document.forms[0].sel_nsdlStatus.value=="AGRI" || document.forms[0].sel_nsdlStatus.value=="LHD" ){
		document.forms[0].action=appUrl+"action/NP_Mailbox.jsp";
		document.forms[0].hidBeanGetMethod.value="getNpMailbox";
		document.forms[0].hidBeanId.value="NationalPortal";
	}else{
		document.forms[0].hidBeanGetMethod.value="PSB59getApplicationDetailsList";
		document.forms[0].hidBeanId.value="NationalPortal";
		document.forms[0].action=appUrl+"action/npInbox.jsp";
	}
	document.forms[0].submit();
}
function callNPReallocation()
{
	document.forms[0].action = appURL+"action/np_reallocation.jsp";
	document.forms[0].submit();
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/NationalPortal.css"
	type="text/css">
<style>
.mailbox_container
{
	width: 100%;
	height: 350px;
	overflow: auto;
}
</style>
</head>
<body onload="callOnLoad()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="path">Home -&gt; National Portal Group Inbox</td>
	</tr>
</table>
<form name="nsdlrecvapp" method="post">
<table width="25%" align="center" border="0" class="outertable">
	<tr height="50px">
	<td>
	National Portal Segment
	</td>
	<td>
	<select name="sel_nsdlStatus" onchange="callNpsegment(this);">
	    <option value="S">--Select--</option>
	    <option value="EDU">Educational Loan</option>
	    <option value="BS">Business Loan </option>
	    <option value="AGRI">Agricultural Loan</option>
	    <option value="HL">Housing Loan</option>
	    <option value="LHD">Livelihood Loan</option>
	</select>
	</td>
	</tr>
</table>
<table width="95%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
	<tr><td>
<table width="95%"  border="0" cellspacing="0" cellpadding="0" align="center">
<tr class="dataheader" >
<td width="10%"  nowrap="nowrap" align="center"> Application Reference ID</td>
<td width="10%" nowrap="nowrap"  align="center"> Application Code</td>
<td width="6%" nowrap="nowrap"  align="center"> Scheme ID</td>
<td width="20%" nowrap="nowrap"  align="center"> Scheme Name</td>
<td width="10%" nowrap="nowrap"  align="center"> Application Date</td>
<td width="10%" nowrap="nowrap"  align="center"> Applicant Name</td>
<td width="6%" nowrap="nowrap"  align="center"> Laps Status</td>
<td width="10%" nowrap="nowrap"  align="center">Authorized Status</td>
<td width="10%" nowrap="nowrap"  align="center"> Actions</td>
<%if(strSegType.equalsIgnoreCase("EDU")){%>
<td width="10%" nowrap="nowrap"  align="center"></td>
<%}%>
</tr>
<%if(arrRecvRow!=null && arrRecvRow.size()>0)
{ 
for(int k=0;k<arrRecvRow.size();k++)
{
	arrRecvCol=(ArrayList)arrRecvRow.get(k);
%>
<tr class="datagrid"> 
<td align="center" nowrap="nowrap">
<a href="#" onClick="javascript:callAppStatusPopUp('<%=Helper.correctNull((String)arrRecvCol.get(0))%>','<%=Helper.correctNull((String)arrRecvCol.get(3))%>','<%=Helper.correctNull((String)arrRecvCol.get(9)) %>')"><%=Helper.correctNull((String)arrRecvCol.get(3)) %>&nbsp;</a>
</td>
<td align="center"><%=Helper.correctNull((String)arrRecvCol.get(1)) %>&nbsp;</td>
<td align="center"><%=Helper.correctNull((String)arrRecvCol.get(4)) %>&nbsp;</td>
<td align="center"><%=Helper.correctNull((String)arrRecvCol.get(5)) %>&nbsp;</td>
<td align="center"><%=Helper.correctNull((String)arrRecvCol.get(2)) %>&nbsp;</td>
<td align="center"><%=Helper.correctNull((String)arrRecvCol.get(7)) %> &nbsp;</td>
<td align="center"><%=Helper.correctNull((String)arrRecvCol.get(6)) %>&nbsp;</td>
<td align="center"><%=Helper.correctNull((String)arrRecvCol.get(8)) %>&nbsp;</td>
<%if(strSegType.equalsIgnoreCase("EDU")){%>
<td align="center">
<a href="#" onClick="javascript:callcbsid('<%=Helper.correctNull((String)arrRecvCol.get(3))%>')">CBS ID</a>&emsp;
<%if(strOrgLevel.equalsIgnoreCase("A")){%>
<a href="#" onClick="javascript:callaccept('<%=Helper.correctNull((String)arrRecvCol.get(0))%>',
                                           '<%=Helper.correctNull((String)arrRecvCol.get(3))%>',
                                           '<%=Helper.correctNull((String)arrRecvCol.get(1))%>',
                                           '<%=Helper.correctNull((String)arrRecvCol.get(4))%>',
										   '<%=Helper.correctNull((String)arrRecvCol.get(5))%>')">Accept</a>
</td>
<%}%>
<%}%>
<td>
&nbsp;<a href="#" onClick="javascript:callreject('R','<%=Helper.correctNull((String)arrRecvCol.get(3))%>',
													 '<%=Helper.correctNull((String)arrRecvCol.get(6))%>')">Status</a>&emsp;
<%if(!strSegType.equalsIgnoreCase("EDU")){%>												 
<a href="#" onClick="javascript:callupdate('<%=Helper.correctNull((String)arrRecvCol.get(3))%>',
										   '<%=Helper.correctNull((String)arrRecvCol.get(4))%>',
										   '<%=Helper.correctNull((String)arrRecvCol.get(5))%>')">Update</a>&emsp;
<%}%>
</td>
</tr>
<%}}else{ %>
<%for(int i=0;i<3;i++){ %>
<tr class="datagrid">
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
</tr>
<%if(i==1) {%>
<tr class="datagrid">
<td colspan="8" align="center">&nbsp;-- No Record Found --&nbsp;</td>
</tr>
<%}}%>
<%}%>
</table>
</td></tr></table>


<table border="0" cellspacing="0" cellpadding="0"  align="center">
      <tr valign="middle"> 
       <td> 
		<input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="callclose();">
	
            
        </td>
        <%if(strOrgLevel.equalsIgnoreCase("R") || strOrgLevel.equalsIgnoreCase("C")){%>
        <td>  
            <input type="button" name="cmdRealloaction" value="Reallocation"  onClick="callNPReallocation()"> 
        </td>
        <%}%>
      </tr>
</table>
    <input type="hidden" name="hidBeanId" value="">
    <input type="hidden" name="hidBeanGetMethod" value="">
    <input type="hidden" name="hidSourceUrl" value="">
    <input type="hidden" name="hidBeanMethod" value="">
    <input type="hidden" name="hidApplicantId" value="">
    <input type="hidden" name="hidId" value="">
    <input type="hidden" name="hidrefId" value="">
    <input type="hidden" name="hidRefId" value="">
    <input type="hidden" name="hidappCode" value="">
    <input type="hidden" name="hidschId" value="">
    <input type="hidden" name="hidschName" value="">
    <input type="hidden" name="hidStatusFlag" value="">
    <input type="hidden" name="hidAppStatus" value="">
    <input type="hidden" name="hidUserId" value="">
     <input type="hidden" name="hidsegtype" value="">
     <input type="hidden" name="hidschemeId" value="">
     <input type="hidden" name="hidschemeName" value="">
      <input type="hidden" name="hidlapstatus" value="">
    <input type="hidden" name="hidpopSchemeId" value="">
    <iframe height="0" width="0" id="ifrm" frameborder="0" style="border:0"></iframe>
    </form>
    </body>
    </html>