<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="strGroupRights" class="java.lang.String" scope="session" />

<laps:handleerror />

<%
   ArrayList arrFromUsr=(ArrayList)hshValues.get("arrFromUsr");
   ArrayList arrToUsr=(ArrayList)hshValues.get("arrToUsr");
   ArrayList arrFromflow=(ArrayList)hshValues.get("arrFromflow");
   ArrayList arrToflow=(ArrayList)hshValues.get("arrToflow");
   ArrayList arrDate=(ArrayList)hshValues.get("arrDate");
   ArrayList arrMailtype=(ArrayList)hshValues.get("arrMailType");
  String strPgDist=Helper.correctNull(request.getParameter("hiPgDist"));
  String strSSIType  =Helper.correctNull((String)session.getAttribute("hidSSIType"));
String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));

String acccountNo=Helper.correctNull((String)hshValues.get("handoffCBSAccno"));

String link1 = Helper.correctNull((String) hshValues.get("pagelink"));
String strlink = Helper.correctNull((String) hshValues.get("proplink"));
String strPageEnableFrom=Helper.correctNull((String)hshValues.get("strPageEnable"));		



String finallink = "";



if((link1!=null)&&(link1.equalsIgnoreCase("PROP")))
{
	finallink = link1;
}
else
{
	finallink = strlink;
}



session.setAttribute("link", finallink);






String bgcol="";
String strOrgLevel=Helper.correctNull((String)hshValues.get("strOrgLevel"));

String strmsmeflag;
String moduletype=Helper.correctNull((String)session.getAttribute("moduletype"));
if(moduletype.equals("MSME"))
{
	strmsmeflag="Y";
}
else
{
	strmsmeflag="N";
}
String Orglel= Helper.correctNull((String) hshValues.get("orglevel"));	
String OrgCPC= Helper.correctNull((String) hshValues.get("orgcpc"));	
	


%>

<html>
<head>
<title>Personal - Work Flow</title>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
 var appUrl="<%=ApplicationParams.getAppUrl()%>";
 var appURL="<%=ApplicationParams.getAppUrl()%>";
 var auditorrights="<%=((String)session.getAttribute("strGroupRights")).substring(7,8)%>";
 var varPageEnableFrom="<%=Helper.correctNull((String)hshValues.get("strPageEnable"))%>";
 var varStrUserId="<%=Helper.correctNull((String)hshValues.get("strUserId"))%>";
 var varAppType="<%=Helper.correctNull((String)hshValues.get("AppType"))%>";
function callhelp()
{
		   var varQryString = appUrl+"/jsp/perhlp/hlp_appworkflowhistory.jsp"
		   var title = "ApplicantDemographics";
			var prop = "scrollbars=no,width=600,height=450";	
			prop = prop + ",left=200,top=150";
			window.open(varQryString,title,prop);
}

function callAppraisal()
{	//alert("callapp");
	var appno= document.forms[0].appno.value;
	if(appno.length!=0)
	{		
	window.open(appURL+"action/perappsanctionsanction.jsp?appno="+appno,"AppraisalSanction", "scrollbars=yes,toolbars=No,menubar=no,width=600,height=450,top=0,left=0");
	}
}


 function callOnload()
 {
	 
	if(parseInt(auditorrights)==1)
	{
		//document.forms[0].adreport1.disabled=false;
	}
	else
	{
		//document.forms[0].adreport1.disabled=true;
		
	}

	
	<% if(strPgDist.equalsIgnoreCase("P"))
	  {
		
		if(Orglel.equalsIgnoreCase("BRN")){
    		
    		
    		if(OrgCPC.equalsIgnoreCase("Y")){
		
	  %>
    if (document.forms[0].appstatus.value=="Processed/Approved" || document.forms[0].appstatus.value=="Closed/Approved")
    {
   		document.forms[0].but_branchletter.disabled=false;  
    }else{
    	document.forms[0].but_branchletter.disabled=true;  
    }
    <%}}   else {
    %>	
    
    if (document.forms[0].appstatus.value=="Processed/Approved" || document.forms[0].appstatus.value=="Closed/Approved")
    {
   		document.forms[0].but_branchletter.disabled=false;  
    }else{
    	document.forms[0].but_branchletter.disabled=true;  
    }
    
   <% }
    }%>


    

    <%if(strPgDist.equalsIgnoreCase("P")){%>
    if (document.forms[0].appstatus.value=="Processed/Approved" || document.forms[0].appstatus.value=="Closed/Approved")
    {
   		document.forms[0].clickHere2.disabled=false;  
    }else{
    	document.forms[0].clickHere2.disabled=true;  
    }
    <%}%>

    if(document.forms[0].appstatus.value=="Processed/Rejected")
	{
		document.forms[0].cmdsanc.disabled=true;
	
	}
 }
 function callOtherTab(val)
 {
	 if(val=="action" )
	 {
		 document.forms[0].hidBeanId.value="NationalPortal";
		 document.forms[0].hidBeanGetMethod.value="getAction";
		 document.forms[0].action=appUrl+"action/NP_appworkflowaction.jsp";
		 document.forms[0].submit();
	 }
	 if(val=="sanc")
	 {
		 document.forms[0].hidBeanId.value="comproposal";
		 document.forms[0].hidBeanGetMethod.value="getSancLetterdata";
		 document.forms[0].action=appUrl+"action/com_msme_sanctionletter.jsp";
		 document.forms[0].submit();
	 }
	 if(val=="process")
	 {
		 document.forms[0].hidBeanId.value="applicantreport";
		 document.forms[0].hidBeanGetMethod.value="getProcessnotedata";
		 document.forms[0].action=appUrl+"action/com_msme_processnote.jsp";
		 document.forms[0].submit();
	 }
	 if(val=="review")
	 {
		 document.forms[0].hidBeanId.value="commworkflow";
		 document.forms[0].hidBeanGetMethod.value="getReviewDocumentData";
		 document.forms[0].action=appUrl+"action/reviewDocumentsMSME.jsp";
		 document.forms[0].submit();	 
	 }	 
 }

	
function doClose()
{
	if(ConfirmMsg(100))
		{
			
			if("<%=strPgDist%>"=="P")
			{
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perexisting.jsp";
			}else
			{
			document.forms[0].action ="<%=ApplicationParams.getAppUrl()%>action/comsearch.jsp";
			}
			
			document.forms[0].submit();
		}

}
 function ShowReport(page)
  {
	  
	var appno = document.forms[0].appno.value;
/*	var hidModule = document.forms[0].hidModule.value;
	var url = "<%=ApplicationParams.getAppUrl()%>action/"+page+"?hidBeanId=appraisalsanc&hidBeanGetMethod=getsanctionletterforborrower&appno="+appno+"&hidModule="+hidModule;
	var title = "FairReport";
	var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop); */

	var hidModule = document.forms[0].hidModule.value;
	var url = "<%=ApplicationParams.getAppUrl()%>action/APPENDIX-85.jsp?hidBeanId=appraisalsanc&hidBeanGetMethod=getsanctionletterforborrower&appno="+appno+"&hidModule="+hidModule;
	var title = "FairReport";
	var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);		
}
  
  function menuOptionDivMouseDown (url) {
		//if (! isMac) {
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			//window.location=url;
			document.forms[0].action=url;
			document.forms[0].submit();
			//}
		}

function ShowCheckList()
{	
	var appno = document.forms[0].appno.value;
	var appname=document.forms[0].appname.value;
	var url = "<%=ApplicationParams.getAppUrl()%>action/checklist.jsp?appno="+appno+"&appname="+appname;
	var title = "CheckListReport";
	var prop = "scrollbars=yes,width=395,height=420";
	var xpos = 170;
	var ypos = 100;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}
function ShowCasfFlow()
{	
	var appno = document.forms[0].appno.value;
	var appname=document.forms[0].appname.value;
	//var url = "<%=ApplicationParams.getAppUrl()%>action/checklist.jsp?appno="+appno+"&appname="+appname;
	
	var url = "<%=ApplicationParams.getAppUrl()%>action/comruncashflowbob.jsp?hidBeanId=comrepcashflowbob&hidBeanMethod=getData&hidMethod=getRowsCols&hidAppno="+appno
	var title = "CashFlow";
	var prop = "scrollbars=yes,width=800,height=550";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}

function AudBankReprt()
{	
	var appno = document.forms[0].appno.value;
	var appname=document.forms[0].appname.value;
	var url = "<%=ApplicationParams.getAppUrl()%>action/auditorbankrep.jsp?appno="+appno+"&appname="+appname;
	var title = "";
	var prop = "scrollbars=yes,width=1395,height=1420";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
	}
function ShowPrint(page)
  {
	
	appno=document.forms[0].appno.value;
		
var purl ="<%=ApplicationParams.getAppUrl()%>action/eduprint.jsp?hidBeanGetMethod=getPrintData&hidBeanId=edustudent&appno="+appno;

		
		var prop = 'scrollbars=yes,menubar=yes,width=800,height=600';	
		var xpos = (screen.width - 775) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);
  }
function lettertobranch()
{
	var appno = document.forms[0].appno.value;
	var hidModule = document.forms[0].hidModule.value;
	var url = "<%=ApplicationParams.getAppUrl()%>action/perlettertobranch.jsp?hidBeanId=appraisalsanc&hidBeanGetMethod=getLettertoBranchData&appno="+appno+"&hidModule="+hidModule;
	var title = "Letter to Branch";
	var prop = 'scrollbars=yes,menubar=yes,width=800,height=600';	
	var xpos = (screen.width - 775) / 2;
	var ypos = (screen.height - 520) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,'title',prop);
}
function callsancLetter()
{
	if(varAppType=="M")
	{
		if(document.forms[0].appstatus.value == "Closed/Approved" || document.forms[0].appstatus.value == "Processed/Approved")
		{
	
			var page = "com_msme_sanctionletter.jsp";
			var appno	= document.forms[0].hidapno.value;
			var appid	= document.forms[0].hidDemoId.value;
			url="<%=ApplicationParams.getAppUrl()%>action/"+page+"?appno="+appno+"&hidBeanId=comproposal&hidBeanGetMethod=getSancLetterdata"+"&hidDemoId="+appid;
			var title = "ProcessNote10Lacsto2Crore";
			var prop = "scrollbars=yes,width=900,height=600,menubar=yes";
			var xpos = 5;
			var ypos = 5;
			prop = prop + ",left="+xpos+",top="+ypos;
			window.open(url,title,prop);
		}	
		else
		{
			document.forms[0].cmdsanc.disabled=true;
		}	
	}	
	
}
function callRemarks()
{
		appno = document.forms[0].hidapno.value;
		var strPgDist =document.forms[0].strPgDist.value;
		var prop = "scrollbars=no,width=550,height=550,top=25,left=180";
		var url=appUrl+"action/workflowcomm.jsp?hidappno="+appno+"&hiduserid="+varStrUserId+"&strPgDist="+strPgDist;
		window.open(url,"remarks",prop);
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/blackfont.css" type="text/css">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 250;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
a:hover {  color: #FF3300}
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
</STYLE>
</head>
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  onLoad="callOnload()" class="bgcolor">

<!-- <div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5();"> 
  <div class="menuitems" url="">
    <script language="JavaScript1.2">
if (document.all && window.print)
{
ie5menu.className = menuskin;
document.oncontextmenu = showmenuie5;
document.body.onclick = hidemenuie5;
}
</script>
  </div>
</div> -->

<jsp:include page="../share/help.jsp" flush="true"> 
</jsp:include>

<form name="frmworkflow" method="post">
  <table width="100%" border="1" cellspacing="0" cellpadding="0"  bordercolorlight="#8F8369" bordercolordark="#FFFFFB" height="20">
    <tr> 
      <td> 
        <%
   //out.println("EEEEEEE "+session.getAttribute("link"));
        
       	if(!session.getAttribute("link").equals("PROP"))
		{
		if(strPgDist.equalsIgnoreCase("P"))
							{
						%>
						<jsp:include page="../nationalportal/ApplurllinkNP.jsp" flush="true"> 
						<jsp:param name="pageid" value="7" />
						</jsp:include>
						<%
							}
							else
							{
							%>
						<jsp:include page="../com/proposallinks.jsp" flush="true"> 
						<jsp:param name="pageid" value="7" />
						<jsp:param name="cattype" value="<%=strCategoryType%>" />
				        <jsp:param name="ssitype" value="<%=strSSIType%>" />
							</jsp:include>
						<%
							}
}
		else
		{
			%>
			<tr> 
      <td valign="top" > 
        <jsp:include page="../share/menus.jsp" flush="true"> </jsp:include>
        <jsp:include page="../com/proposallinks.jsp" flush="true"> 
				<jsp:param name="cattype" value="<%=strCategoryType%>" />
				        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        <jsp:param name="pageid" value="7" />
         </jsp:include>
      </td>
	  <span style="visibility:hidden"><laps:borrowertype /></span> 
    </tr>
	<%
		}
	%> 
		
		
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td>
       <%if(strPgDist.equalsIgnoreCase("P")){ %>
       <font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>Home 
        </i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt; 
        Retail</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        <font face="Times New Roman" size="3"><b><i>-&gt; Existing </i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt;</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        </i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font face="Times New Roman" size="3"><b><i>Workflow -> History</i></b></font>
        <%}else { %>
        <font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>Home 
        </i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt; 
         MSME</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        <font face="Times New Roman" size="3"><b><i>-&gt; Existing </i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt;</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        </i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font face="Times New Roman" size="3"><b><i>Workflow -> History</i></b></font>
        <%} %></td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="0" bgcolor="#E4E2ED" bordercolorlight="#EBEBF8" bordercolordark="#82829F" height="20">
    <laps:application/> 
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td height="20" width="50%" valign="bottom" class="outertablecolor"> 
        <table width="40%" border="0" cellspacing="3" cellpadding="3" align="left">
          <tr align="center"> 
            <td width="33%" class="tabactive"><b><font size="1" face="MS Sans Serif" color="#FFFFFF">History</font></b></td>
            <td width="33%" class="tabinactive" id="action"><b><a href="javascript:callOtherTab('action')" class="blackfont"><font size="1" face="MS Sans Serif">Action</font></a></b></td>
            <% if (session.getAttribute("link").equals("PROP"))
            		{
            	if(strPageEnableFrom.equals("frominboxmail")&& strOrgLevel.equalsIgnoreCase("R"))
            	{
            		%>
            <td width="33%" class="tabinactive" id="reviewdoc"><b><a href="javascript:callOtherTab('review')" class="blackfont"><font size="1" face="MS Sans Serif">Review Document</font></a></b></td>
          	<%}
            	}%>
           <td width="33%" class="tabinactive" ><b><a href="javascript:callRemarks()" class="blackfont"><font size="1" face="MS Sans Serif">Remarks</font></a></b></td>
           	
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="5" height="10%" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center" class="outertablecolor">
    <tr> 
      <td valign="top"> 
        <div align="left"></div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
          <tr> 
            <td height="260"> 
              <table width="100%" border="1" cellspacing="0" cellpadding="5" height="100%" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
                <tr> 
                  <td height="0" valign="top"> 
                    <div align="left"><font size="1" face="MS Sans Serif"><br>
                      <b>History</b></font> <br>
                    </div>
                    <table width="100%" border="0" cellspacing="0" cellpadding="2">
                      <tr> 
                        <td width="47%" valign="top"> 
                          <table width="100%" border="1" cellspacing="0" cellpadding="4" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" height="285">
                            <tr> 
                              <td valign="top"> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
                                  <tr> 
                                    <td width="10%" height="22" class="tabactive"> 
                                      <div align="center"><font size="1" face="MS Sans Serif" color="#FFFFFF">From 
                                        Flowpoint</font></div>
                                    </td>
                                    <td width="19%" height="22" class="tabactive"> 
                                      <div align="center"><font size="1" face="MS Sans Serif" color="#FFFFFF">Sent 
                                        By</font></div>
                                    </td>
                                    <td width="16%" height="22" class="tabactive"> 
                                      <div align="center"><font size="1" face="MS Sans Serif" color="#FFFFFF">Sent 
                                        On</font></div>
                                    </td>
                                    <td width="15%" height="22" class="tabactive"> 
                                      <div align="center"><font size="1" face="MS Sans Serif" color="#FFFFFF">To 
                                        Flowpoint</font></div>
                                    </td>
                                    <td width="21%" height="22" class="tabactive"> 
                                      <div align="center"><font size="1" face="MS Sans Serif" color="#FFFFFF">Sent 
                                        To</font></div>
                                    </td>
                                    <td width="19%" height="22" class="tabactive"> 
                                      <div align="center"><font size="1" face="MS Sans Serif" color="#FFFFFF">Mail 
                                        Type</font></div>
                                    </td>
                                  </tr>

                                  <tr align="center"> 
                                    <td colspan="6"> 
                                      <DIV CLASS="cellContainer"> 
                                        <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
                                          <% 
                                          if((arrFromUsr!=null)&& (arrFromflow.size()>0)){
                                          for(int i=0;i<arrFromUsr.size();i++){
                     
											  if(bgcol.equals("#F0F0FF"))
					{
					bgcol = "#FFFFFF";
					}
					else
					{
					bgcol ="#F0F0FF";
					}%>
										  <tr bgcolor="<%=bgcol%>"> 
                                            <td height="22" width="10%" align="center"> 
                                              <font color="#003399" size="1" face="MS Sans Serif"><%=arrFromflow.get(i)%> 
                                              </font></td>
                                            <td height="22" width="23%"> <font color="#003399" size="1" face="MS Sans Serif"> 
                                              &nbsp;<%=arrFromUsr.get(i)%></font></td>
                                            <td height="22" width="11%" align="center"> 
                                              <font color="#003399" size="1" face="MS Sans Serif"><%=arrDate.get(i)%> 
                                              </font></td>
                                            <td height="22" width="16%" align="center"> 
                                              <font color="#003399" size="1" face="MS Sans Serif"><%=arrToflow.get(i)%> 
                                              </font></td>
                                            <td height="22" width="21%"> <font color="#003399" size="1" face="MS Sans Serif"><%=arrToUsr.get(i)%> 
                                              </font></td>
                                            <td height="22" width="19%"> <font color="#003399" size="1" face="MS Sans Serif"> 
                                              <%=arrMailtype.get(i) %> &nbsp;</font></td>
                                          </tr>
                                          <%}
                                          }
                                          
                                          %>
                                        </table>
                                      </div>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                    <table border="0" cellspacing="0" align="center">
                      <tr> 
                        <td width="98%" align="center">
<table width="50%" border="0" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" class="outertablecolor" align="right">
                            <tr> 
                            <%if(strPgDist.equalsIgnoreCase("P")) {
                            if(Orglel.equalsIgnoreCase("BRN")){
                                		if(OrgCPC.equalsIgnoreCase("Y")){
                                			%>
                            
                            <td>
                          		<font size="1" face="MS Sans Serif"> 
                                <input type="button" name="but_branchletter" value="Letter of Sanction to Branch" style="width:200" class="buttoncolor" onClick="lettertobranch()">
                             	</font>
                            </td>
                            <%}}  else{%>
                            
                            
                             <td>
                          		<font size="1" face="MS Sans Serif"> 
                                <input type="button" name="but_branchletter" value="Letter of Sanction to Branch" style="width:200" class="buttoncolor" onClick="lettertobranch()">
                             	</font>
                            </td>
                            
                           <% } }%>
                              <td> 
                                <% if(strPgDist.equalsIgnoreCase("P"))
				  {
                                                            	
                                		
				  %>
                              <!--   <input type="button" name="cmdHcopy" value="Print Application" style="width:125" class="buttoncolor" onClick="ShowReport('applicantreport.jsp')" style="visibility:hidden">  -->
                              </td>
                              <td>&nbsp;&nbsp;&nbsp;</td>
						      <td ><font size="1" face="MS Sans Serif"> 
                                <input type="button" name="clickHere2" value="Letter of Sanction to Borrower" style="width:200" class="buttoncolor" onClick="ShowReport('perloanreqletter.jsp')">
                                <!--<input type="button" name="cmdedit" value="AuditorsBankDocument" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" onClick="AudBankReprt()">-->
                                </font></td>
                                
                                 <%
				  }
                                		%>
                                		
                                		 
						   
                            </tr>
                          </table>
                          <font size="1" face="MS Sans Serif">&nbsp; </font> </td>
                      </tr>
                       <tr> 
                        <td> &nbsp;<font face="MS Sans Serif" size="1" color="#FF0033"><b></b></font></td>
                        <td width="50%" > 
                          <table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" class="outertablecolor" align="center">
                          <!--   <tr>
                              <td><input type="button" name="cmdcancel3" value="Print For Education" onClick="ShowPrint('eduprint.jsp')" style="width:130" class="buttoncolor">-->
                               
                             <!--  </td>
                            </tr> -->
                          </table>
                          
                        </td>
                      </tr>
                    </table></td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
        
      </td>
    </tr>
  </table>
  <br>
  <table width="0%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center" class="outertablecolor">
    <tr> 
      <td> 
        <table width="0%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top"> 
            <td height="2"> 
             <!--  <input type="button" name="adreport1" value="Auditor's Report" style="background-color:#8F8369;color:white;font-size=10;font-family:mssansserif;width:110;font-weight:bold" onClick="doAudit()"> -->
            </td>
            <td height="2"> 
              <input type="button" name="cmdclose3" value="Help" style="background-color:#009966;cursor:help;;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" onClick="callhelp()">
            </td>
            <td height="2"> 
                         <input type="button" name="cmdclose" value="Close"  onclick = "doClose()" style="background-color:#CC3300;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold">
            
            </td>
            
              <% 
            
              if(!strPgDist.equalsIgnoreCase("P"))
				  {
            	
				  %>
            
            
            
            <td width="15%">
              <div align="center"> 
			  	<input type="button" name="cmdsanc" value="Sanction Letter" style="width:100"  class="buttoncolor"  onClick="callsancLetter()">
			  </div>	
			</td>
			
			
			   <%
				  }
                    %>
			
          </tr>
          
        </table>
      </td>
    </tr>
  </table>
  <input type="hidden" name="hidBeanGetMethod">
  <input type="button" name="cmdapply" disabled="disabled" style="visibility:hidden">
  <INPUT TYPE="hidden" name="hidBeanId">
   <input type="hidden" name="hidSourceUrl">
  <INPUT TYPE="hidden" name="hidCoDemoId" value="<%=request.getParameter("hidCoDemoId")%>" >
  <INPUT TYPE="hidden" name="hidDemoId" value="<%=request.getParameter("hidDemoId")%>">
  <INPUT TYPE="hidden" name="hidGuaDemoId" value="<%=request.getParameter("hidGuaDemoId")%>">
  <INPUT TYPE="hidden" name="hidAppType">
  <INPUT TYPE="hidden" name="radLoan" value="Y">
  <INPUT TYPE="hidden" name="hiPgDist" value="<%=Helper.correctNull(request.getParameter("hiPgDist"))%>">
  <input type="hidden" name="hidapno" value="<%=request.getParameter("appno")%>">
  <input type="hidden" name="hidPageEnableFrom" value="<%=Helper.correctNull((String)hshValues.get("strPageEnable"))%>">
  <input type="hidden" name="strPgDist" value="<%=strPgDist%>">  
  <input type="hidden" name="hidModule" value="Edu"> 
</form>
</body>
</html>
