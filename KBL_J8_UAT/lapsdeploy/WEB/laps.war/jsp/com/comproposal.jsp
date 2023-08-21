<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="strGroupRights" class="java.lang.String" scope="session" />
<laps:handleerror />

<html>
<head>
<title>Commercial-Applicant</title>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/menudropdown.js"></script>
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appno="<%=hshValues.get("prop_appno")%>";
var rdate="<%=Helper.correctNull((String)hshValues.get("prop_receptdate"))%>";
var propno="<%=Helper.correctNull((String)hshValues.get("prop_crdpropno"))%>";
var propdate="<%=Helper.correctNull((String)hshValues.get("prop_crdpropdate"))%>";
var branch="<%=Helper.correctNull((String)hshValues.get("prop_orgbranch"))%>";
var relmgr="<%=Helper.correctNull((String)hshValues.get("prop_relmanager"))%>";
var psource="<%=Helper.correctNull((String)hshValues.get("prop_source"))%>";
var loantype="<%=Helper.correctNull((String)hshValues.get("prop_loantype"))%>";
var presdate="<%=Helper.correctNull((String)hshValues.get("prop_presentdate"))%>";
var sancby="<%=Helper.correctNull((String)hshValues.get("prop_sanctionedby"))%>";
var crr="<%=Helper.correctNull((String)hshValues.get("prop_crrreason"))%>";
var idate="<%=Helper.correctNull((String)hshValues.get("prop_incdate"))%>";
var sdet="<%=Helper.correctNull((String)hshValues.get("prop_sectordetails"))%>";
var ftype="<%=Helper.correctNull((String)hshValues.get("prop_facilitytype"))%>";
var maxusg="<%=Helper.correctNull((String)hshValues.get("prop_maxusage"))%>";
var minusg="<%=Helper.correctNull((String)hshValues.get("prop_minusage"))%>";
var avgusg="<%=Helper.correctNull((String)hshValues.get("prop_avgusage"))%>";
var curusg="<%=Helper.correctNull((String)hshValues.get("prop_curusage"))%>";
var overdue="<%=Helper.correctNull((String)hshValues.get("prop_overdue"))%>";
var curyr="<%=Helper.correctNull((String)hshValues.get("prop_curyear"))%>";
var nxtyr="<%=Helper.correctNull((String)hshValues.get("prop_nextyear"))%>";
var oduersn="<%=Helper.correctNull((String)hshValues.get("prop_overduereason"))%>";
var cdate="<%=Helper.correctNull((String)hshValues.get("app_compdate"))%>";
var appdate="<%=Helper.correctNull((String)hshValues.get("app_appdate"))%>";
var appby="<%=Helper.correctNull((String)hshValues.get("app_appby"))%>";


var editflag=1;
var editlockflag="<%=hshValues.get("editlock")%>";
function placeValues()
{
	
	if(appno == null || appno == "")
	{
		doAfterEdit();
        return;
	}
    if(rdate!="01/01/1900")
		document.forms[0].prop_receptdate.value=rdate;
	document.forms[0].prop_crdpropno.value=propno;
	if(propdate!="01/01/1900")
		document.forms[0].prop_crdpropdate.value=propdate;
	
	document.forms[0].prop_orgbranch.value=branch;
	document.forms[0].prop_relmanager.value=relmgr;
	document.forms[0].prop_source.value=psource;
	document.forms[0].prop_loantype.value=loantype;
	if(presdate!="01/01/1900")
		document.forms[0].prop_presentdate.value=presdate;
	document.forms[0].prop_sanctionedby.value=sancby;
	document.forms[0].prop_crrreason.value=crr;
	if(idate!="01/01/1900")
		document.forms[0].prop_incdate.value=idate;
	document.forms[0].prop_sectordetails.value=sdet;
	document.forms[0].prop_facilitytype.value=ftype;
	document.forms[0].prop_maxusage.value=maxusg;
	document.forms[0].prop_minusage.value=minusg;
	document.forms[0].prop_avgusage.value=avgusg;
	document.forms[0].prop_curusage.value=curusg;
	document.forms[0].prop_overdue.value=overdue;
	document.forms[0].prop_curyear.value=curyr;
	document.forms[0].prop_nextyear.value=nxtyr;
	document.forms[0].prop_overduereason.value=oduersn;
	document.forms[0].app_closedate.value=cdate;
	document.forms[0].prop_sanctionedby.value =appby;
	document.forms[0].txtappdate.value = appdate;
	doAfterEdit();

}
 function callCalender(tname)
 {
	 if(document.forms[0].cmdedit.disabled)
		 showCal(appUrl,tname);
 }
function disableFields(val)
{
  for(var i=0;i<document.forms[0].length;i++)
  {
	  if((document.forms[0].elements[i].type=='text' || document.forms[0].elements[i].type=="textarea") && document.forms[0].elements[i].name!="appno" && document.forms[0].elements[i].name!="appname" && document.forms[0].elements[i].name!= "appstatus")
	  {
		  document.forms[0].elements[i].readOnly=val;
	  }
  }
  
}

function disableCommandButtons(val)
{
  if(val=="load")
  {
	  if(editflag==1)
	  document.forms[0].cmdapply.disabled=true;
	  document.forms[0].cmdcancel.disabled=true;
	  document.forms[0].cmdclose.disabled=false;
  }
  if(val=="edit")
  {
	 document.forms[0].cmdedit.disabled=true;
	 document.forms[0].cmdapply.disabled=false;
	 document.forms[0].cmdaudit.disabled=true;
	 document.forms[0].cmdcancel.disabled=false;
	 document.forms[0].cmdclose.disabled=true;
  }
}

function doEdit()
{
	document.forms[0].hideditflag.value="yes";
	document.forms[0].hidBeanGetMethod.value="getProposal";
	document.forms[0].action=appUrl+"action/comproposal.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function doCancel()
{
	document.forms[0].hideditflag.value="no";
	document.forms[0].hidBeanGetMethod.value="getProposal";
	document.forms[0].action=appUrl+"action/comproposal.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();

}

function doSave()
{
	if(!checkDate(document.forms[0].prop_receptdate))
		 return;
	if(!checkDate(document.forms[0].app_closedate))
		 return;
	 if(!checkDate(document.forms[0].prop_crdpropdate))
		 return;
	 if(!checkDate(document.forms[0].prop_presentdate))
		 return;
	 if(!checkDate(document.forms[0].prop_incdate))
		 return;
	 document.forms[0].cmdapply.disabled = true;
	document.forms[0].app_no.value=document.forms[0].appno.value;
	document.forms[0].hidBeanGetMethod.value="getProposal";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].cmdapply.disabled=true;
	document.forms[0].submit();
}

 function doClose()
 {
	document.forms[0].action=appUrl+"action/comsearch.jsp";
	document.forms[0].submit();
 }

 function callApplicantTab(page)
 {
 	if(document.forms[0].cmdapply.disabled)
	{
	  if(page=="company")
	  {
		  document.forms[0].hidBeanGetMethod.value="getData";
		  document.forms[0].action=appUrl+"action/comcompany.jsp";
	  }
	  if(page=="facilities")
	  {
		  document.forms[0].hidBeanMethod.value="getFacilityData";
		  document.forms[0].hidBeanId.value="facilities";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/facilities.jsp";
	  }
	  document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}

 }

function doAfterEdit()
{
  var editcheck="<%=request.getParameter("hideditflag")%>";
  if(editcheck=="yes")
  {
	  if(editlockflag=="y")
	  {
		  disableCommandButtons("edit");
	  }
	  else
	  {
		  disableFields(true);
		  ShowAlert(128);
		  disableCommandButtons("load");
	  }
  }
  else
  {
	  disableFields(true);
	  disableCommandButtons("load");
  }

}

function callLCLimit()
{
var appno = document.forms[0].appno.value;
var url = "<%=ApplicationParams.getAppUrl()%>action/lccalculator.jsp?hidBeanId=lccalculator&hidBeanGetMethod=getData&hidAppno="+appno;
var title = "FacilitiesRequired";
var prop = "scrollbars=no,width=500,height=400";
var xpos = 5;
var ypos = 5;
prop = prop + ",left="+xpos+",top="+ypos;
window.open(url,title,prop);

}

var strvalue="comapp.htm";
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #333399; border-style: groove}
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #333399; border-style: groove}
a:hover {  color: #FF3300}
</STYLE>
</head>
<body bgcolor="#EEEAE3" text="#000000" link="#000000" vlink="#330000" alink="#330000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="placeValues()">
<jsp:include page="../share/help.jsp" flush="true"/> 

<form name="appform" method="post">
 <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
    <tr> 
      <td id="unlinktable2"> 
        <jsp:include page="../share/ApplURLLinks.jsp" flush="true" > 
        <jsp:param name="pageid" value="1" />
        </jsp:include>
      </td>
    </tr>
    <tr> 
      <td  id="linktable2" style="visibility:hidden">&nbsp; </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="0"  bordercolorlight="#EBEBF8" bordercolordark="#82829F" height="20">
          <laps:application/> 
        </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  
    <tr> 
      <td height="2" colspan="2"> 
        <table width="40%" border="0" cellspacing="3" cellpadding="3">
          <tr align="center"> 
            <td width="36%" bgcolor="#EEEAE3"><font face="MS Sans Serif" size="1"><b><a href="javascript:callApplicantTab('facilities')" class="blackfont">Loan 
              Product</a></b></font></td>
            <td width="34%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"><b><a href="javascript:callApplicantTab('company')" class="blackfont">Company</a></b></font></td>
            <td width="30%" bgcolor="#71694F"><font size="1" face="MS Sans Serif"><b><font color="#FFFFFF">Proposal</font></b></font></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="5" height="300" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr> 
      <td valign="top"> 
        <div align="left"></div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
          <tr> 
            <td height="260"> 
              <table width="100%" border="1" cellspacing="0" cellpadding="5" height="100%" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
                <tr> 
                  <td valign="top"> 
                    <div align="left"></div>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                      <tr> 
                        <td width="20%"><font size="1" face="MS Sans Serif">Date 
                          of Receipt</font></td>
                        <td width="9%"> 
                          <input type="text" name="prop_receptdate" size="12" maxlength="10"  style= text-align:left;border-style=groove onBlur="checkDate(this)">
                        </td>
                        <td width="8%"><a alt="Select date from calender"  href="#" onClick="javascript:callCalender('prop_receptdate')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0></a></td>
                        <td width="30%" align="left"> 
                          <div align="left"></div>
                        </td>
                        <td width="20%"><font face="MS Sans Serif" size="1">Date 
                          of completion</font></td>
                        <td width="15%"> 
                          <input type="text" name="app_closedate" size="12" maxlength="10"  style= text-align:left;border-style=groove  onBlur="checkDate(this)">
                        </td>
                        <td width="10%"> 
                          <div align="left"><a alt="Select date from calender"  href="#" onClick="javascript:callCalender('app_closedate')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0></a></div>
                        </td>
                      </tr>
                      <tr> 
                        <td width="12%"><font size="1" face="MS Sans Serif">Credit 
                          Proposal No.</font></td>
                        <td colspan="3"> 
                          <input type="text" name="prop_crdpropno" size="40" maxlength="25"  style= text-align:left;border-style=groove>
                        </td>
                        <td width="10%"><font size="1" face="MS Sans Serif">Date</font></td>
                        <td width="15%"> 
                          <input type="text" name="prop_crdpropdate" size="12" maxlength="10"  style= text-align:left;border-style=groove onBlur="checkDate(this)">
                        </td>
                        <td width="15%"> 
                          <div align="left"><a alt="Select date from calender"  href="#" onClick="javascript:callCalender('prop_crdpropdate')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0></a></div>
                        </td>
                      </tr>
                      <tr> 
                        <td width="12%"><font size="1" face="MS Sans Serif">Decision 
                          required </font></td>
                        <td width="20%" colspan="2"> 
                          <h3> 
                            <textarea name="prop_decision" rows="2" cols="30" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("prop_decision"))%></textarea>
                          </h3>
                        </td>
                        <td width="10%" valign="top"> &nbsp;&nbsp; 
                          <input type="button" name="cmdlc" value="LC Calculator" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;font-weight:bold;width:85" onClick="callLCLimit()">
                        </td>
                        <td width="10%"><font size="1" face="MS Sans Serif">Originating 
                          Branch </font></td>
                        <td width="30%" colspan="2"> 
                          <input type="text" name="prop_orgbranch" size="20" maxlength="25"   style= text-align:left;border-style=groove>
                        </td>
                      </tr>
                      <tr> 
                        <td width="12%"><font size="1" face="MS Sans Serif">Relationship 
                          Manager </font></td>
                        <td colspan="3"> 
                          <input type="text" size="25" maxlength="20"   style= text-align:left;border-style=groove name="prop_relmanager">
                        </td>
                        <td width="10%"><font size="1" face="MS Sans Serif">Source</font></td>
                        <td width="30%" colspan="2"> 
                          <input type="text" name="prop_source" size="20" maxlength="25"  style= text-align:left;border-style=groove>
                        </td>
                      </tr>
                      <tr> 
                        <td width="12%"><font size="1" face="MS Sans Serif">Type 
                          of Loan</font></td>
                        <td colspan="3"> 
                          <input type="text" name="prop_loantype" size="25" maxlength="10"   style= text-align:left;border-style=groove>
                        </td>
                        <td width="10%"><font size="1" face="MS Sans Serif">Date 
                          Presented </font></td>
                        <td width="15%"> 
                          <input type="text" name="prop_presentdate" size="12" maxlength="10"  style= text-align:left;border-style=groove onBlur="checkDate(this)" >
                        </td>
                        <td width="15%"><a alt="Select date from calender"  href="#" onClick="javascript:callCalender('prop_presentdate')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0></a></td>
                      </tr>
                      <tr> 
                        <td width="12%"><font size="1" face="MS Sans Serif">Last 
                          Approval By</font></td>
                        <td colspan="3"> 
                          <input type="text" name="prop_sanctionedby" size="25" maxlength="10"   style= text-align:left;border-style=groove readonly>
                        </td>
                        <td width="10%"><font size="1" face="MS Sans Serif">Last 
                          Approval Date </font></td>
                        <td width="30%" colspan="2"> 
                          <input type="text" name="txtappdate" size="12" maxlength="10"  style= text-align:left;border-style=groove readonly>
                        </td>
                      </tr>
                      <tr> 
                        <td width="12%"><font size="1" face="MS Sans Serif">Reason 
                          for change in CRR</font></td>
                        <td colspan="3"> 
                          <input type="text" name="prop_crrreason" size="35" maxlength="100"  style= text-align:left;border-style=groove>
                        </td>
                        <td width="10%"><font size="1" face="MS Sans Serif">Date 
                          of Incorporation</font></td>
                        <td width="15%"> 
                          <input type="text" name="prop_incdate" size="12" maxlength="10"   style= text-align:left;border-style=groove onBlur="checkDate(this)" >
                        </td>
                        <td width="15%"><a alt="Select date from calender"  href="#" onClick="javascript:callCalender('prop_incdate')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0></a></td>
                      </tr>
                      <tr> 
                        <td width="12%"><font size="1" face="MS Sans Serif">Deviations 
                          from Credit Policy</font></td>
                        <td colspan="3"> 
                          <textarea name="prop_crpolicydev" cols="30" style="text-align:left;border-style=flat" rows="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("prop_crpolicydev"))%></textarea>
                        </td>
                        <td width="10%"><font size="1" face="MS Sans Serif"> Priority 
                          Sector?If so,details</font></td>
                        <td width="30%" colspan="2"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr> 
                              <td> 
                                <input type="text" name="prop_sectordetails" size="25" maxlength="200"  style= text-align:left;border-style=groove>
                              </td>
                              <td><a href="#" onClick="javascript:doHelp('rbi/rbi.htm')"><img src="<%=ApplicationParams.getAppUrl()%>img/rbirules.gif" width="25" height="28" border=0></a></td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td> 
                          <div align="center"><font size="1" face="MS Sans Serif"></font></div>
                        </td>
                        <td colspan="3" align="center"><font size="1" face="MS Sans Serif"><b>Usage 
                          &amp; Earnings Summary</b></font></td>
                        <td colspan="3"><font color="#FFFFFF"><font size="1" face="MS Sans Serif" color="#CC0000">All 
                          values are in <%=ApplicationParams.getCurrency()%> ' 
                          lacs '</font></font></td>
                      </tr>
                      <tr> 
                        <td width="12%" align="center"> <font size="1" face="MS Sans Serif"><b>Type 
                          of facility</b></font></td>
                        <td colspan="3" align="center"> <font size="1" face="MS Sans Serif"><b>Usage 
                          for past months</b></font></td>
                        <td width="10%">&nbsp;</td>
                        <td width="30%" colspan="2"> 
                          <div align="center"><font face="MS Sans Serif" size="1"><b>Earnings</b></font></div>
                        </td>
                      </tr>
                    </table>
                    <table width="100%" border="1" cellspacing="0" cellpadding="2" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
                      <tr> 
                        <td>
                          <table width="100%" border="0" cellspacing="1" align="center" height="75" cellpadding="0">
                            <tr> 
                              <td width="16%">&nbsp;</td>
                              <td width="11%"> 
                                <div align="center"><font size="1" face="MS Sans Serif">Max</font></div>
                              </td>
                              <td width="11%"> 
                                <div align="center"><font size="1" face="MS Sans Serif">Min</font></div>
                              </td>
                              <td width="11%"> 
                                <div align="center"><font size="1" face="MS Sans Serif">Avg</font></div>
                              </td>
                              <td width="11%"> 
                                <div align="center"><font face="MS Sans Serif" size="1">Current</font></div>
                              </td>
                              <td width="15%"> 
                                <div align="center"><font size="1" face="MS Sans Serif">Overdue</font></div>
                              </td>
                              <td width="13%"> 
                                <div align="center"><font size="1" face="MS Sans Serif">Current 
                                  Year </font></div>
                              </td>
                              <td width="12%"> 
                                <div align="center"><font size="1" face="MS Sans Serif">Next 
                                  Year </font></div>
                              </td>
                            </tr>
                            <tr bgcolor="#EEEAE3"> 
                              <td width="16%" bgcolor="#EEEAE3" align="center"> 
                                <input type="text" name="prop_facilitytype" size="15" maxlength="25" style= text-align:left;border-style=groove onKeyPress="notAllowSingleQuote()">
                              </td>
                              <td width="11%"> 
                                <div align="center"> 
                                  <input type="text" name="prop_maxusage" size="6" maxlength="9"  onKeyPress="allowNumber(this)" style= text-align:right;border-style=groove onBlur="roundtxt(this)">
                                </div>
                              </td>
                              <td width="11%"> 
                                <div align="center"> 
                                  <input type="text" name="prop_minusage" size="6" maxlength="9"  onKeyPress="allowNumber(this)" style= text-align:right;border-style=groove onBlur="roundtxt(this)">
                                </div>
                              </td>
                              <td width="11%"> 
                                <div align="center"> 
                                  <input type="text" name="prop_avgusage" size="6" maxlength="9"  onKeyPress="allowNumber(this)" style= text-align:right;border-style=groove onBlur="roundtxt(this)">
                                </div>
                              </td>
                              <td width="11%"> 
                                <div align="center"> 
                                  <input type="text" name="prop_curusage" size="6" onKeyPress="allowNumber(this)" style="text-align:right;border-style=groove" maxlength="9" onBlur="roundtxt(this)">
                                </div>
                              </td>
                              <td width="15%"> 
                                <div align="center"> 
                                  <input type="text" name="prop_overdue" size="6" maxlength="9"  onKeyPress="allowNumber(this)" style= text-align:right;border-style=groove onBlur="roundtxt(this)">
                                </div>
                              </td>
                              <td width="13%"> 
                                <div align="center"> 
                                  <input type="text" name="prop_curyear" size="6" maxlength="5"   style= text-align:right;border-style=groove onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
                                </div>
                              </td>
                              <td width="12%"> 
                                <div align="center"> 
                                  <input type="text" name="prop_nextyear" size="6" maxlength="5"   style= text-align:right;border-style=groove onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
                                </div>
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td colspan="8"> 
                                <div align="left"><font size="1" face="MS Sans Serif">Age 
                                  of and reasons for overdues and expected date 
                                  of regularisation: 
                                  <input type="text" name="prop_overduereason" size="75" maxlength="60"  style= text-align:left;border-style=groove>
                                  </font></div>
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
      </td>
    </tr>
  </table>
  <br>
  <table width="0%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr> 
      <td> 
        <%
		String strappno = request.getParameter("appno");
		%>
        <laps:combuttons  apporgcode='<%=strappno%>' strSource=""/> </td>
    </tr>
  </table>
  <input type="hidden" name="hidBeanId" value="commapplicant">
  <input type=hidden name="hidBeanMethod" value="updateData">
  <input type="hidden" name="hidBeanGetMethod">
  <input type="hidden" name="hidSourceUrl" value="/action/comproposal.jsp" >
  <input type="hidden" name="hideditflag">
  <input type="hidden" name="app_no">
  <input type="hidden" name="comapp_id" value="<%=request.getParameter("comapp_id")%>">
  <input type="hidden" name="tabflag" value="proposal">
</form>
</body>
</html>