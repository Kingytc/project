<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<laps:handleerror />
<%
 if(objValues instanceof java.util.HashMap)
   {
	  hshValues=(java.util.HashMap)objValues;
   }

java.text.NumberFormat nf = java.text.NumberFormat
.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);


String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));
String strSSIType  =Helper.correctNull((String)request.getParameter("hidSSIType"));
String var1=Helper.correctNull((String)hshValues.get("prinfullname"));
//String var2=Helper.correctNull((String)hshValues.get("prinlname"));
String var3=Helper.correctNull((String)hshValues.get("prinmname"));
String prinname  = Helper.correctNull((String)hshValues.get("prinname"));
String proname = var1;
%>
<html>
<head>
<title>Details of Proprietor / Partners / Managing Partner / Promoters / Director 
/ Managing Director</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<STYLE>

DIV.cellContainer {	
  width: 100%; height: 250;
  overflow: auto;
}
</STYLE>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/com/SSIpromoter.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/blackfont.css" type="text/css">
</head>
<script language="javascript" >

var appUrl="<%=ApplicationParams.getAppUrl()%>";
var strvalue ="/jsp/comhlp/hlp_demograph.jsp";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var totalsharevalue="<%=Helper.correctNull((String)hshValues.get("totalsharevalue"))%>";
var comapp_totalshares="<%=Helper.correctNull((String)hshValues.get("comapp_totalshares"))%>";
function callClose()
{

 var cattype=document.forms[0].cattype.value;
 if((cattype=="ASSI")||(cattype=="ASBI"))
        {
        if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/agrborrowersearch.jsp";
		 document.forms[0].submit();
	 }
		}
		if((cattype=="SSI")||(cattype=="CORP")||(cattype=="SME"))
        {
        if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/comborrowersearch.jsp";
		 document.forms[0].submit();
	 }
		}
  
}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{	
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;	  	
	document.forms[0].cmdclose.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdcomments.disabled=bool5;
}

function showdetails()
{
var sharetype=document.forms[0].share_holder.value;

if(sharetype=="Y")
{
document.all.id1.style.visibility="visible";
document.all.id2.style.visibility="visible";
document.all.id3.style.visibility="visible";
}
else
{
document.all.id1.style.visibility="hidden";
document.all.id2.style.visibility="hidden";
document.all.id3.style.visibility="hidden";

}


}
function whileLoading()
{
		
		var val="<%=Helper.correctNull((String)hshValues.get("prinname"))%>";
		
		  		
		if(val == "")
		{
			disableFields(true);
			makeNull();
			if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
		  	{
		  		enableButtons(true,true,true,true,false);	
		  		
		  	}
		  	else
		  	{
			enableButtons(false,true,true,true,false);	
			}
				
		}
		else
		{
			
			document.forms[0].prinfullname.value= val;
			if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
		  	{
		  		enableButtons(true,true,true,true,false);	
		  		
		  	}
		  	else
		  	{	
				enableButtons(false,true,true,false,false);
			}	
			
			disableFields(true);
			
		}
	
	
	//document.forms[0].cmdaudit.disabled=false;
	//document.forms[0].cmddel.disabled=false;
	
	document.forms[0].prinfullname.value= val;
	
	if (document.forms[0].prinname.value =="")
	{
	
		
		document.forms[0].cmdedit.disabled=true;
	
	}
	else
	{
		if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
		  	{
		  		document.forms[0].cmdedit.disabled=true;	
		  		
		  	}
		  	else
		  	{	
				document.forms[0].cmdedit.disabled=false;
			}
	}
	if(document.forms[0].share_holder.value=="Y")
	{
	document.all.id1.style.visibility="visible";
	document.all.id2.style.visibility="visible";
	document.all.id3.style.visibility="visible";
	
	}
	else
	{
	document.all.id1.style.visibility="hidden";
	document.all.id2.style.visibility="hidden";
	document.all.id3.style.visibility="hidden";
	
	}
	
	
}
function calldefaulter()
{
	
	var varQryString = appURL+"action/comrbidefaultersearch.jsp";
	var title = "DefaultersList";
	var prop = "scrollbars=No,width=780,height=550";	
	var xpos = (screen.width - 800) / 2;
	var ypos = (screen.height - 600) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(varQryString,title,prop);
}


function sharePercentage()
{

if(document.forms[0].prinfullname.selectedIndex=="1")
{
var sharehold=eval(totalsharevalue)+eval(document.forms[0].txt_sharesheld.value);
}
else
{
var sharehold=eval(totalsharevalue)+eval(document.forms[0].txt_sharesheld.value)-eval(document.forms[0].hidsharevalue.value);
}
//var sharehold=eval(totalsharevalue)+eval(document.forms[0].txt_sharesheld.value);
var shareheldind=document.forms[0].txt_sharesheld.value;
var sharepercent="";

if(eval(shareheldind)>eval(comapp_totalshares))
	 {
	     alert("Enter proper share held");
		  document.forms[0].txt_sharesheld.value="";
		 // document.forms[0].txt_sharesheld.focus();
		  return;
	}
	else if(eval(sharehold)>eval(comapp_totalshares))
 {

	  alert("Enter proper share held");
	  document.forms[0].txt_sharesheld.value="";
	  document.forms[0].txt_sharepercent.value="";
	 // document.forms[0].txt_sharesheld.focus();
	  return;
 }
else
 { 
	sharepercent=(eval(shareheldind)/eval(comapp_totalshares))*100;
	if(sharepercent!="Nan")
	{
	document.forms[0].txt_sharepercent.value=NanNumber(sharepercent);
	var share=document.forms[0].txt_sharepercent.value;
	document.forms[0].txt_sharepercent.value=roundVal(share);
	}
	else
	{
	document.forms[0].txt_sharepercent.value="";
	}

 }

}

</script>
<body class="bgcolor" onload="javascript:whileLoading();sharePercentage()" text="#000000">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()"> 
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
</div>
<form name="fininc" method="post">
  <jsp:include page="../share/help.jsp" flush="true"/> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertablecolor" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr>
      <td> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true"> 
        <jsp:param name="pageid" value="2" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
          <jsp:include page="../share/menus.jsp" flush="true"/> 
       
     
      </td>
    </tr>
  </table>

  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colspan=5> <b><i>Home 
-&gt;  Application-&gt; Promoter  -&gt;Demographics </i></b></td>
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
            <td width="20%" height="20" class="tabactive" bgcolor="#71694F"> 
              <div align="center"><b>Demographics</b></div>
            </td>
            <td width="18%" height="20" class="tabinactive" bgcolor="#EEEAE3"> 
              <div align="center"><b><a href="javascript:changeTab('experience')" class="blackfont">Experience</a></b></div>
            </td>
            <td width="30%" height="20" class="tabinactive" bgcolor="#EEEAE3"> 
              <div align="center"><b><a href="javascript:changeTab('activities')" class="blackfont">Functions 
                / Activities</a></b></div>
            </td>
            <td width="15%" height="20" class="tabinactive" align="center" bgcolor="#EEEAE3"><b><a href="javascript:changeTab('bankaccount')" class="blackfont"> 
              Assets </a></b></td>
            <td width="17%" align="center" class="tabinactive" bgcolor="#EEEAE3"><b><a href="JavaScript:changeTab('liabilities')" class="blackfont">Liabilities</a></b></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="5" class="outertablecolor" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" onMouseOver=" " height="350">
    <tr> 
      <td valign="top" height="548"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" height="100%" >
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" height="100%">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="5">
                      <tr> 
                        <td width="31%">&nbsp;</td>
                        <td colspan="2">&nbsp; </td>
                        <td width="31%">&nbsp; </td>
                        <td width="22%" colspan="2"> 
                          <!-- <input type="button" name="cmdDefault" value="Defaulters List" style="width:100" class= "buttoncolor" onClick="calldefaulter()"> -->
                        </td>
                      </tr>
                      <tr> 
                        <td width="31%">Select 
                          Proprietor / Partner / Director <b>&nbsp;*</b></td>
                        <td colspan="5">  
                          <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr> 
                              <td> 
                                <select name="prinfullname" onChange="javascript:displayData()">
                                  <option selected value =''>----Select----</option>
                                  <option value ='new'>New</option>
                                  <laps:getprinNames/> 
                                </select>
                                </td>
                              <td>Type<b>&nbsp;*</b></td>
                              <td> 
                                <select name="printype">
                                  <option value="" >----Select----</option>
                                  <option value="PR" <%if(Helper.correctNull((String)hshValues.get("printype")).equals("PR")) out.println("selected"); %>>Proprietor</option>
                                  <option value="PT" <%if(Helper.correctNull((String)hshValues.get("printype")).equals("PT")) out.println("selected"); %>>Partners</option>
                                  <option value="MP" <%if(Helper.correctNull((String)hshValues.get("printype")).equals("MP")) out.println("selected"); %>>Managing 
                                  Partner</option>
                                  <option value="PM" <%if(Helper.correctNull((String)hshValues.get("printype")).equals("PM")) out.println("selected"); %>>Promoters</option>
                                  <option value="D" <%if(Helper.correctNull((String)hshValues.get("printype")).equals("D")) out.println("selected"); %>>Director</option>
                                  <option value="MD" <%if(Helper.correctNull((String)hshValues.get("printype")).equals("MD")) out.println("selected"); %>>Managing</option>
                                  <option value="ED" <%if(Helper.correctNull((String)hshValues.get("printype")).equals("ED")) out.println("selected"); %>>Executive</option>
                                  Director</option>
                                  <option value="PD" <%if(Helper.correctNull((String)hshValues.get("printype")).equals("PD")) out.println("selected"); %>>Professional 
                                  Director</option>
                                  <option value="JMD" <%if(Helper.correctNull((String)hshValues.get("printype")).equals("JMD")) out.println("selected"); %>>Joint 
                                  Managing Director</option>
                                  <option value="ND" <%if(Helper.correctNull((String)hshValues.get("printype")).equals("ND")) out.println("selected"); %>>Nominee 
                                  Director</option>
                                </select>
                                </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td width="31%">First 
                          Name <b>&nbsp;*</b></td>
                        <td colspan="2"> 
                          <input type="text" name="prinfname" size="25" value="<%=Helper.correctNull((String)hshValues.get("prinfname"))%>" maxlength="30"onKeyPress="notAllowSplChar()" >
                        </td>
                        <td width="31%">Middle 
                          Name </td>
                        <td width="22%" colspan="2"> 
                          <input type="text" name="prinmname" size="25" value="<%=Helper.correctNull((String)hshValues.get("prinmname"))%>" onKeyPress="notAllowSplChar()" maxlength="30">
                           </td>
                      </tr>
                      <tr> 
                        <td width="31%">Last 
                          Name</td>
                        <td colspan="2"> 
                          <input type="text" name="prinlname" size="25" value="<%=Helper.correctNull((String)hshValues.get("prinlname"))%>" onKeyPress="notAllowSplChar()" maxlength="30">
                        </td>
                        <td width="31%">Father's 
                          / Husband's Name</td>
                        <td width="22%" colspan="2"> 
                          <input type="text" name="prinfhname" size="25" value="<%=Helper.correctNull((String)hshValues.get("prinfhname"))%>" onKeyPress="notAllowSplChar()" maxlength="90">
                        </td>
                      </tr>
                      <tr> 
                        <td width="31%">Age</td>
                        <td colspan="2"> 
                          <input type="text" name="prinage" size="5" value="<%=Helper.correctNull((String)hshValues.get("prinage"))%>" onKeyPress="allowNumber(this)" maxlength="3">
                        </td>
                        <td width="31%">Sex</td>
                        <td width="22%" colspan="2"> 
                          <select name="prinsex">
                            <option value="S">----Select----</option>
                            <option  value="M" <%if(Helper.correctNull((String)hshValues.get("prinsex")).equals("M")) out.println("selected"); %>>Male</option>
                            <option value="F" <%if(Helper.correctNull((String)hshValues.get("prinsex")).equals("F")) out.println("selected"); %>>Female</option>
                          </select>
                        </td>
                      </tr>
                      <tr> 
                        <td width="31%">Category 
                          </td>
                        <td colspan="2"> 
                          <select name="princaste" readOnly>
                            <option value="S">----Select----</option>
                            <option  value="C" <%if(Helper.correctNull((String)hshValues.get("princaste")).equals("C")) out.println("selected"); %>>Scheduled 
                            Castes </option>
                            <option value="T" <%if(Helper.correctNull((String)hshValues.get("princaste")).equals("T")) out.println("selected"); %>>Scheduled 
                            Tribes </option>
                            <option value="M" <%if(Helper.correctNull((String)hshValues.get("princaste")).equals("M")) out.println("selected"); %>>Minority 
                            Community </option>
                            <option value="O" <%if(Helper.correctNull((String)hshValues.get("princaste")).equals("O")) out.println("selected"); %>>Others</option>
                          </select>
                        </td>
                        <td width="31%">Are 
                          you an Ex-Serviceman</td>
                        <td width="22%" colspan="2"> 
                          <select name="prinexser">
                            <option value="Y" <%if(Helper.correctNull((String)hshValues.get("prinexser")).equals("Y")) out.println("selected"); %> >Yes</option>
                            <option value="N" <%if(Helper.correctNull((String)hshValues.get("prinexser")).equals("N")) out.println("selected"); %> >No</option>
                          </select>
                        </td>
                      </tr>
                      <tr> 
                        <td width="31%">Ration 
                          Card No. and Name of the Issuing Office</td>
                        <td colspan="2"> 
                          <input type="text" name="prinracno" size="25" value="<%=Helper.correctNull((String)hshValues.get("prinracno"))%>" onKeyPress="notAllowSplChar()" maxlength="200">
                        </td>
                        <td width="31%">Academic 
                          Qualification</td>
                        <td width="22%" colspan="2"> 
                          <input type="text" name="prinqualif" size="25" value="<%=Helper.correctNull((String)hshValues.get("prinqualif"))%>" maxlength="50">
                        </td>
                      </tr>
                      <tr> 
                        <td width="31%" height="36">Passport 
                          No.</td>
                        <td height="36" colspan="2"> 
                          <input type="text" name="ssi_prinpassportno" size="25" value="<%=Helper.correctNull((String)hshValues.get("ssi_prinpassportno"))%>" onKeyPress="notAllowSplChar()" maxlength="30">
                        </td>
                        <td width="31%" height="36">&nbsp;</td>
                        <td width="22%" height="36" colspan="2">&nbsp; </td>
                      </tr>
                      <tr> 
                        <td width="31%"><b>Address</b></td>
                        <td colspan="2">&nbsp;</td>
                        <td width="31%">&nbsp;</td>
                        <td width="22%" colspan="2">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td colspan="3">Office 
                          </td>
                        <td colspan="3">Residence</td>
                      </tr>
                      <tr> 
                        <td width="31%"> 
                          <textarea name="prinoff" cols="50" wrap="VIRTUAL" rows="5" onKeyPress="notAllowSingleQuote()" maxlength="200"><%=Helper.correctNull((String)hshValues.get("prinoff"))%></textarea>
                        </td>
                        <td width="6%">Tel.No</td>
                        <td width="10%"> 
                          <input type="text" name="ssi_officetelno" size="25" style="text-align:left"  value="<%=Helper.correctNull((String)hshValues.get("ssi_officetelno"))%>" onKeyPress="allowPhone()" maxlength="18">
                        </td>
                        <td width="31%"> 
                          <textarea name="prinres" cols="50" wrap="VIRTUAL" rows="5" onKeyPress="notAllowSingleQuote()" maxlength="200"><%=Helper.correctNull((String)hshValues.get("prinres"))%></textarea>
                        </td>
                        <td width="11%">Tel.No</td>
                        <td width="11%">
                          <input type="text" name="ssi_residencetelno" style="text-align:left" size="25" value="<%=Helper.correctNull((String)hshValues.get("ssi_residencetelno"))%>" onKeyPress="allowPhone()" maxlength="18">
                        </td>
                      </tr>
                      <tr> 
                        <td width="31%"> Whether he is a share Holder</td>
                        <td colspan="2"> 
                          <select name="share_holder" onChange="showdetails()">
                            <option value="Y" <%if(Helper.correctNull((String)hshValues.get("share_type")).equals("Y")) out.println("selected"); %> >Yes</option>
                            <option value="N" <%if(Helper.correctNull((String)hshValues.get("share_type")).equals("N")) out.println("selected"); %> >No</option>
                          </select>
                        </td>
                      </tr>
                      <tr id="id1"> 
                        <td width="31%">Share(%)</td>
                        <td colspan="2"> 
                          <input type="text" name="txt_sharepercent" size="25" onKeyPress="allowNumber(this)" value="<%//=Helper.correctNull((String)hshValues.get("shareper"))%>" onblur="checkper()" readOnly >
                        </td>
                      </tr>
                      <tr id="id2"> 
                        <td width="31%">Shares Held</td>
                        <td colspan="2"> 
                          <input type="text" name="txt_sharesheld" size="25" onKeyPress="allowNumber(this)" onBlur="sharePercentage()" value="<%=Helper.correctNull((String)hshValues.get("shareheld"))%>">
                        </td>
                        <td width="31%">&nbsp;</td>
                        <td width="22%" colspan="2">&nbsp;</td>
                      </tr>
                      <tr id="id3"> 
                        <td width="31%">Face Value</td>
                        <td colspan="2"> 
                          <input type="text" name="txt_facevalue" size="25" onKeyPress="allowNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("faceval"))%>">
                        </td>
                        <td width="31%">&nbsp;</td>
                        <td width="22%" colspan="2">&nbsp;</td>
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
  <table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr class="outertablecolor" bordercolordark="#FFFFFB" bordercolorlight="#8F8369"> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2" align="center" class="outertablecolor" >
          <tr valign="top"> 
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdedit" value="Edit" class="buttonStyle" onClick="doEdit()">
              </div>
            </td>
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdapply" value="Save" class="buttonStyle" onClick="doSave()">
              </div>
            </td>
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdcancel" value="Cancel" class="buttonStyle" onClick="doCancel()">
              </div>
            </td>
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmddel" value="Delete" class="buttonStyle" onClick="doDelete()">
              </div>
            </td>
            <td width="15%"> 
              <div align="center"> 
                <input type="button" name="cmdhelp" value="Help" class="buttonHelp" onClick="Help()">
              </div>
            </td>
            <td width="15%"> 
              <div align="center"> 
                <input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="callClose()">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <%
  //String strappno=Helper.correctNull((String)hshValues.get("appno"));
  %>
    
  </table>
  <input type="hidden" name="hidBeanId" >
  <input type="hidden" name="hidVal">
  <input type="hidden" name="hidBeanMethod" value="">
  <input type="hidden" name="hidBeanGetMethod" value="">
  <input type="hidden" name="comapp_id" value="<%=Helper.correctNull((String)request.getParameter("comapp_id"))%>">
  <input type="hidden" name="hidTabName" value="">
  <input type="hidden" name="hidTotalDesc" value="4">
  <INPUT TYPE="hidden" NAME="hidparam" VALUE="">
  <INPUT TYPE="hidden" NAME="hidMethod" VALUE="">
  <input type="hidden" name="hidOtherMethod" value="">
  <input type="hidden" name="otherGetMethod" value="">
  <input type="hidden" name="hidSourceUrl" value="">
  <input type="hidden" name="frompage" value="P">
<input type="hidden" name="pname" value="P">
<input type="hidden" name="prinname" value ="<%=prinname%>">
<input type="hidden" name="proname" value ="<%=proname%>">
 <input type="hidden" name="prinname1" value ="<%=prinname%>">
 <input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
  <input type="hidden" name="hidsharevalue" value="<%=Helper.correctNull((String)hshValues.get("shareheld"))%>"> 						


  <!--// forPromoter/ Guarantor -->
</form>
</body>
</html>
