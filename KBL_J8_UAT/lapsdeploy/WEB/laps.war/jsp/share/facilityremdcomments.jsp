<%@include file="../share/directives.jsp"%>
<%ArrayList arrRow= new ArrayList();
ArrayList arrCol= new ArrayList();
arrRow =(ArrayList)hshValues.get("arrRow");
String strSector=Helper.correctNull((String)request.getParameter("hidsector"));
String strSaral = Helper.correctNull((String) request.getParameter("hidsaral"));
String strApploantype = Helper.correctNull((String) request.getParameter("apploantype"));
String strApplevel=Helper.correctNull((String)request.getParameter("applevel"));
String strProposal=Helper.correctNull((String)request.getParameter("hidproposal"));
String strValuesin=Helper.correctNull((String)request.getParameter("valuesin"));
if(strValuesin.equals("L"))
{
	strValuesin=" in Lacs";
}
else
{
	strValuesin="";
}
String strappholder =Helper.correctNull((String)request.getParameter("appholder"));
String strappliedfor=Helper.correctNull((String)request.getParameter("appliedfor"));%>
<html>
<head>
<title>Facility For Recommendation</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varOrgLevel="<%=strOrgLevel%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text'  )
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=='textarea'  )
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=='select-one'  )
		{
			document.forms[0].elements[i].disabled=val;
		}
	}
}
function onloading()
{	  
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A")
	{
		disableCommandButtons(false,true,true,true,false);
	}
	else
	{
		disableCommandButtons(true,true,true,true,false);
	}
	disableFields(true);
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons(true,false,false,false,true);
}
function doSave()
{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="inwardRegister";		
	document.forms[0].hidSourceUrl.value="/action/facilityremdcomments.jsp";	
	document.forms[0].hidBeanMethod.value="updatebrrecmd";
	document.forms[0].hidBeanGetMethod.value="getbrrecmd";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanMethod.value="updatebrrecmd";
	    document.forms[0].hidBeanGetMethod.value="getbrrecmd";
		document.forms[0].hidBeanId.value="inwardRegister";
		document.forms[0].hidSourceUrl.value="action/facilityremdcomments.jsp";	
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();	
	}	
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="inwardRegister";
		document.forms[0].hidBeanGetMethod.value="getbrrecmd";
		document.forms[0].action=appURL+"action/facilityremdcomments.jsp";
		document.forms[0].submit();
	}
}   
 function disableCommandButtons(cmdedit,cmdsave,cmddel,cmdcancel,cmdclose)
 {  
	 
	  document.forms[0].cmdedit.disabled=cmdedit;	  
	  document.forms[0].cmdsave.disabled=cmdsave;
	  document.forms[0].cmddelete.disabled=cmddel;
	  document.forms[0].cmdcancel.disabled=cmdcancel;
	  document.forms[0].cmdclose.disabled=cmdclose;
 }
 function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function enableButtons(valnew,valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdnew.disabled=valnew;
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
}
function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
		{
	 		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	 	}
}
function doPrint()
{
if (("<%=strSaral%>"=="saral"))
	{
	var ackno = document.forms[0].inwardno.value;
	var appname=document.forms[0].appname.value;
	var varvaluesin ="<%=strValuesin%>";
	var varsaral="<%=strSaral%>";
	var purl ="<%=ApplicationParams.getAppUrl()%>action/recmdbybrrenewalapplnprint.jsp?hidBeanId=inwardRegister&hidBeanGetMethod=getRenewalLimitsRecommendationPrint&inwardno="+ackno+"&valuesin="+varvaluesin+"&appname="+appname+"&hidsaral="+varsaral;
	}
	else
	{
	var appno=document.forms[0].appno.value;
	var appname=document.forms[0].appname.value;
	var ackno = document.forms[0].inwardno.value;
	var purl ="<%=ApplicationParams.getAppUrl()%>action/recmdbybrrenewalapplnprint.jsp?hidBeanId=inwardRegister&hidBeanGetMethod=getRenewalLimitsRecommendationPrint&inwardno="+ackno+"&valuesin="+varvaluesin+"&appname="+appname+"&appno="+appno;
	}
	var prop = 'scrollbars=yes,menubar=yes,width=775,height=520';	
	var xpos = (screen.width - 775) / 2;
	var ypos = (screen.height - 520) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'RECOMMENDATIONBYBRANCHFORNEWAPPLN',prop);
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form method="post" name="frmbrrecmd" class="normal">
 <%if (strSaral.equalsIgnoreCase("saral")) {%>
<lapschoice:saralreportTag tabid="5" sector='<%=strSector%>' applied='<%=strappliedfor%>'  proposal='<%=strProposal%>'/> <lapschoice:inward />
<%} else if(strApploantype.equalsIgnoreCase("c")){%>

<lapstab:ComReportTab tabid="4" applevel='<%=Helper.correctNull((String)request.getParameter("applevel"))%>' applied='<%=strappliedfor%>'/>
<span style="display:none"><lapschoice:borrowertype /></span>
 <lapschoice:application /> 
<%} else if(strApploantype.equalsIgnoreCase("T")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
    <tr> 
      <td valign="top">
        <jsp:include page="../share/applurllinkscom.jsp" flush="true">
        <jsp:param name="pageid" value="10" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
    <tr><td class="page_flow"> Home -&gt; Tertiary -&gt; Application -&gt; Reports -&gt; Recommendation by Branch</td></tr>
  </table>	
  <span style="display:none"><lapschoice:borrowertype /></span>
	<lapschoice:application /> 
	<lapstab:TerReportTab tabid="1" applevel='<%=strApplevel%>' applied='<%=strappliedfor%>' />
<%} else if(strApploantype.equalsIgnoreCase("P")){%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable border1">
	<tr>
		<td id="mainlnk1"><jsp:include page="../share/Applurllinkper.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail -&gt; <%=(String) session.getAttribute("pgeLabel")%> -&gt; Appraisal -&gt; Recommendation by Branch</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td id="mainlnk1"><lapschoice:application /></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable border1">
	<tr>
		<td><jsp:include page="../share/apprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="12" />
		</jsp:include></td>
	</tr>
</table>
<%}
 // This is only for saral application when they create in saral level
else if((strCategoryType.equals("ADC"))||(strCategoryType.equals("STL")||(strCategoryType.equals("SRE")))  &&(strApplevel.equals("S")) )
{
%>
<table border="0" width="100%" class="outertable">
<tr>
 <td valign="top">
<jsp:include page="../share/applurllinkscom.jsp" flush="true">         
<jsp:param name="pageid" value="16" />
<jsp:param name="cattype" value="<%=strCategoryType%>" />
<jsp:param name="ssitype" value="<%=strSSIType%>" />
</jsp:include>
 </td>
</tr>
<tr>
	 <%if(strCategoryType.equals("ADC")) {%>
		 <td class=page_flow>Home -&gt;Corporate &amp; SME -&gt; Adhoc Limit -&gt; Saral -&gt; Recommendation
		 </td>
		 <%}
	     else if(strCategoryType.equals("STL")) {%>
	       <td class=page_flow>Home -&gt;Corporate &amp; SME -&gt; Short Term Loan -&gt; Saral -&gt;Recommendation
		 </td>
		  <%}
	     else if(strCategoryType.equals("SRE")) {%>
	       <td class=page_flow>Home -&gt;Corporate &amp; SME -&gt; Short Review Extension -&gt; Saral -&gt; Recommendation
		 </td>
		 <%} %>
	</tr>
 <tr>
<td>
<lapschoice:borrowertype /><lapschoice:application/>
<lapschoice:saralappinwardtag tabid="5" sector='<%=strCategoryType%>'	applied='<%=strappliedfor%>'  />
</td></tr>
  </table>
<%} %><br>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
<td>
<table width="98%" border="0" cellspacing="0" align="center" cellpadding="5" class="outertable border1">
<tr>
<td valign="top">
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
<tr>
	<td valign="top">
		            <table width="90%" border="0" class="outertable">
                      <tr> 
                        <td colspan="4"> 
                          <table width="100%" border="0" class="outertable">
                            <tr> 
                              <td width="20%">&nbsp;</td>
                              <td width="5%">&nbsp;</td>
                              <td width="19%">&nbsp;</td>
                              <td width="11%">&nbsp;</td>
                              <td width="45%">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="20%">Review Period </td>
                              <td width="5%">From</td>
                              <td width="19%" > 
                                <input type="text" name="txt_reviewfrom" size="15"
			maxlength="25"
			value="<%=Helper.correctNull((String)hshValues.get("brrecmdreviewfrom"))%>" onBlur="checkDate(this);checkmaxdate(this,currentDate)">
                                <a href="#" onClick="callCalender('txt_reviewfrom')"
			title="Click to view calender" border=0><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif" tabindex="2" width="0"
			border="0" ></a></td>
                              <td width="11%">To</td>
                              <td width="45%" > 
                                <input type="text" name="txt_reviewto" size="15"
			maxlength="25"
			value="<%=Helper.correctNull((String)hshValues.get("brrecmdreviewto"))%>" onBlur="checkDate(this)">
                                <a href="#" onClick="callCalender('txt_reviewto')"
			title="Click to view calender" border=0><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif" tabindex="2" width="0"
			border="0" ></a></td>
                            </tr>
                            <tr> 
                              <td width="20%">&nbsp;</td>
                              <td width="5%">&nbsp;</td>
                              <td width="19%">&nbsp;</td>
                              <td width="11%">&nbsp;</td>
                              <td width="45%">&nbsp;</td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td height="114" width="29%">Any Other Major Business/ 
                          Income Received</td>
                        <td colspan="3" height="114"> 
                          <textarea name="txt_major" cols="50" rows="5"
                          onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("brrecmdmajor"))%></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td width="29%">Comments On Utilization of Limits</td>
                        <td width="30%"> 
                          <textarea name="txt_utilization" cols="50" rows="5"
                          onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("brrecmdutilization"))%></textarea>
                        </td>
                        <td width="41%"> <span class="mantatory"> 
                          <ul>
                            <li> <b>Comments on excess allowed in the account 
                              and its adjustment/ our experience in Bills portfolio 
                              </b> </li>
                            <li> <b>Funding of L/C / L/G </b></li>
                            <li><b>Servicing of interest</b></li>
                            <li><b>Repayment of installments and routing of foreign 
                              Exchange Business / Other Business through us</b></li>
                          </ul>
                          </span> </td>
                      </tr>
                      <tr> 
                        <td colspan="3">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="29%">Recommendation from the branch side on 
                          renewal / enhancement of limits</td>
                        <td colspan="2"> 
                          <textarea name="txt_brrecomd" cols="50" rows="5"
                          onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("brrecomdations"))%></textarea>
                        </td>
                      </tr>
                    </table>
	<tr>
		          <td>&nbsp; </td>
			</tr>
		</table>
		</td>
			</tr>
		</table>
		</td>
			</tr>
		</table>		
		<br>
		<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Print' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
		<input type="hidden" name="hidsno" value="">
		<lapschoice:hiddentag pageid='<%=PageId%>'/>
		</form>

</body>
</html>
