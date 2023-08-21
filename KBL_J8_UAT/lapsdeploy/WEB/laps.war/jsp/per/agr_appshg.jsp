<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) {
	hshValues = (java.util.HashMap) objValues;
}

String strModuleType="";
	strModuleType=Helper.correctNull((String) session.getAttribute("sessionModuleType"));
	
	String strEmployment="";
	strEmployment=(String)session.getAttribute("strEmployment");

	String strProfilestatus = Helper.correctNull((String) hshValues.get("strProfilestatus"));
	String strPageName=Helper.correctNull((String)hshValues.get("strIncompletepage"));


ArrayList vecData = new ArrayList();
ArrayList vecRow = new ArrayList();
int vecsize = 0;
int vecsize2 = 0;
if (hshValues != null) 
{
	vecData = (ArrayList) hshValues.get("vecData");
}
double acreval = 0.00;
double centguntval = 0.00;
double totalacreval = 0.00;
double totalcentgunt =0.00; 
double guntasrealq = 0.00; 
double guntasrealr = 0.00;
String strapptype = "";
String apptype = "";

String chobankapptype = Helper.correctNull((String)hshValues.get("chobank_apptype"));

	String strAcres="";
	strAcres= Helper.correctNull((String) hshValues.get("strAcress"));
	
	if(strAcres.trim().equals(""))
	{
		strAcres="0";
	}
	
	
	String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
	if(schemetype. trim().equalsIgnoreCase(""))
	{
		schemetype="0";
	}

	String strFarmcategory=Helper.correctNull((String)hshValues.get("strFarmcategory"));
	
String strProfilestatus1=request.getParameter("strProfilestatus");
	
	String Status="";
	
	if(strProfilestatus.equalsIgnoreCase("Y"))
	{
		Status="Completed";
	}
	else
	{
		Status="Not Completed";
	}
	
	String pageid = request.getParameter("pageid");
	 strapptype = Helper.correctNull((String)request.getParameter("corp"));
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Land Holdings</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>
DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varaction="<%=Helper.correctNull((String)hshValues.get("hidAction"))%>";
var id ="";
var apptype="";
var varApptype=new Array();
var area4="";
var appstatus ="<%=Helper.correctNull((String) hshValues.get("appstatus"))%>";
var varsel_revolving = "<%=Helper.correctNull((String)hshValues.get("perapp_shgrevolving"))%>";
var varshgselmember="<%=Helper.correctNull((String)hshValues.get("perapp_shgselmember"))%>";
var varshgtype="<%=Helper.correctNull((String)hshValues.get("perapp_shgtype"))%>";
var varshgsreeshakti="<%=Helper.correctNull((String)hshValues.get("perapp_shgsreeshakti"))%>";
var varshgrevolving="<%=Helper.correctNull((String)hshValues.get("perapp_shgrotation"))%>";
var varSHGMembers="<%=Helper.correctNull((String)hshValues.get("SHGMembers"))%>";


function chkcentgunt() 
{
	if(document.forms[0].land_measurement.value == 'g')
	{
		if(document.forms[0].txt_acreage1.value > 39)
		{
		 	alert("Guntas value cannot be greater than 39");
		 	document.forms[0].txt_acreage1.value = "";
		 	document.forms[0].txt_acreage1.focus();
		}
	}
}

function enableButtons(bool2, bool3, bool4, bool5,bool6)
{
	
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mastersearchper.jsp";
		document.forms[0].submit();
	}
}

function disableFields(one)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=one;		  
		}		
	}
	document.forms[0].txt_shgname.readOnly=true;
	document.forms[0].txt_village.readOnly=true;
	document.forms[0].txt_taluk.readOnly=true;
	document.forms[0].txt_district.readOnly=true;	
	document.forms[0].txt_pinno.readOnly=true;
}

function getgrossdata()
{
	if(document.forms[0].hideditflag.value=="N")
	{
    	document.forms[0].hidAction.value="get";
    	document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidSourceUrl.value="/action/agr_landholdingscust.jsp";
		document.forms[0].hidBeanMethod.value="updateLandbuild";
		document.forms[0].hidBeanGetMethod.value="getLandbuild";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('');
		return;
	}
}

function doSave()
{  
    if(document.forms[0].txt_shgname.value=="")
	{
		alert('Enter Name of SHG');
		document.forms[0].txt_shgname.focus();
		return;
	}
    if(document.forms[0].txt_member.value=="" || document.forms[0].txt_member.value=="0")
	{
		alert('Enter Number of members');
		document.forms[0].txt_member.focus();
		return;
	}
    if(eval(document.forms[0].txt_member.value)<2)
	{
		alert("Number of members cannot be 1");
		return;
	}
	if(eval(varSHGMembers)>eval(document.forms[0].txt_member.value))
	{
		alert("Details of "+varSHGMembers+" members were already added. So you cannot reduce the members count as "+document.forms[0].txt_member.value);
		return;
	}
	
    document.forms[0].cmdsave.disabled = true;
    document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].hidSourceUrl.value="/action/agr_appshg.jsp";
	document.forms[0].hidBeanMethod.value="updateShgdetails";
	document.forms[0].hidBeanGetMethod.value="getShgdetails";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
	}
	if(val=="approved")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
	}	 
	if(val=="edit")
	{		  
		disableFields(false);
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=false;
		document.forms[0].cmdcancel.disabled=false;	
		document.forms[0].cmdclose.disabled=true;	 
	}
	if(val=="radioselect")
	{	
		disableFields(true);  
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=false;	 
	}	  
}  

function doEdit()
{
 	disableFields(false);
 	document.forms[0].hidEdit.value=="Y";
 	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].hidBeanGetMethod.value="getShgdetails";
		document.forms[0].action=appURL+"action/agr_appshg.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";		
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].hidBeanMethod.value="updateShgdetails";
		document.forms[0].hidSourceUrl.value="/action/agr_appshg.jsp";
		document.forms[0].method="post";			
		document.forms[0].submit();		
	}
}
	
function onloading()
{	
	disableFields(true);
	if(appstatus=="true")
  	{
		enableButtons(true,true,true,true,true,false);
  	}
  	else
  	{
  		enableButtons(false,true,true,true,true,false);
  	}

  	document.forms[0].sel_revolving.value=varsel_revolving;
	document.forms[0].sel_membershg.value=varshgselmember;
	document.forms[0].type_shg.value=varshgtype;
	document.forms[0].sel_sreeshakti.value=varshgsreeshakti;
	document.forms[0].sel_rotation.value=varshgrevolving;
	showComment();
	showAmount();
}

function callCalender(name)
{
if(document.forms[0].cmdedit.disabled==true)
	{
	showCal(appURL,name);
	}
}

function setFarmerCategory() {
	document.all.ifrm1.src = appURL+ "action/iframefarmcat.jsp?hidBeanGetMethod=getAppFarmersCategory&hidBeanId=mis&strTotLandVal="+document.forms[0].txt_TotLandHold.value;
	
}

function showAmount()
{
   if(document.forms[0].sel_revolving.value=="y")
   {
		document.all.amt1.style.visibility="visible";
		document.all.amt1.style.position="relative";
		document.all.amt2.style.visibility="visible";
		document.all.amt2.style.position="relative";
	
   }
   else
   {
	   document.all.amt1.style.visibility="hidden";
	   document.all.amt1.style.position="absolute";
	   document.all.amt2.style.visibility="hidden";
	   document.all.amt2.style.position="absolute";
	   document.forms[0].txt_amount.value="";
   }
}
function showComment()
{
	 if(document.forms[0].sel_rotation.value=="n")
	   {
			document.all.cmnt1.style.visibility="visible";
			document.all.cmnt1.style.position="relative";
			
		
	   }
	   else
	   {
		   document.all.cmnt1.style.visibility="hidden";
		   document.all.cmnt1.style.position="absolute";
		   document.forms[0].rotation_comments.value="";
		  
	   }
}
</script>
</head>
<body onLoad="onloading();">
<form class="normal" method="post">

<%if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equals("")) { %>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		
      <td class="page_flow">Home -&gt; Customer Profile -&gt;SHG</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
			<tr>
		<td><jsp:include page="../share/Cusurllink.jsp" flush="true">
			<jsp:param name="pageid" value="12"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="strProfilestatus" value="<%=strProfilestatus%>" />
			<jsp:param name="hidincompletedpagename" value="<%=strPageName%>" />
		</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<% } else {  %>


<%
if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ 
if(!strSessionModuleType.equalsIgnoreCase("RET")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="subpageid" value="115" />
			<jsp:param name="subsubpageid" value="12" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<% }else{%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="subsubpageid" value="12"/>
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %>
<jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value=""/>
			<jsp:param name="subsubpageid" value="12"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include>
<%}else{ %>
<%if(strapptype.equalsIgnoreCase("C")){ %>
 <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="cattype" value="CORP" />
			<jsp:param name="ssitype" value="" />
			<jsp:param name="applevel" value="A" />
		</jsp:include>
		</td>
	</tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Application -&gt; Applicant -&gt; Customer Profile -&gt; SHG </td>
	</tr>
  </table>
  <%} else if(strapptype.equalsIgnoreCase("R")){ %>
 <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="<%=pageid%>" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; 
       Retail -&gt; Application -&gt; Applicant/Guarantor -&gt; SHG </td>
    </tr>
  </table> 
  <%} %>
<lapschoice:application />
	
 <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
	<%if(strapptype.equalsIgnoreCase("C")){ %>
		<tr>
		<lapstab:ComfacilityTab tabid="2" />
		</tr>
		<%}%>
		<%if(strapptype.equalsIgnoreCase("C") || strapptype.equalsIgnoreCase("R")){ %>
			<tr>
		<td><jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value="12"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include></td>
			</tr>
			<%} %>
		</table>
		</td>
	</tr>
</table>
<%} %>

<% } %>

<table width="50%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<tr>
	<td>
	<table width="40%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
			<tr>
		<td class="sub_tab_active" nowrap align="center">SHG Group info.</td>
										
         <td class="sub_tab_inactive" nowrap align="center"><a href="#" onclick="callMembers()"
							onMouseOut="window.status='';return true;" onMouseOver="window.status='Members Details';return true;"> 
           	 				Members Detail</a>
           </td>
         <td class="sub_tab_inactive" nowrap align="center"><a href="#" onclick="callFin()"
							onMouseOut="window.status='';return true;" onMouseOver="window.status='Financial Details';return true;"> 
           	 				Financial Particulars</a>
           </td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="97%" border="1" cellspacing="0" cellpadding="3" class="outertable" align="center">
<tr>
<td> 
    <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
      <tr> 
      <td nowrap width="16%">Name of SHG<span class="mantatory">*&nbsp;</span></td>
      <td nowrap width="18%"> 
              <input type="text" name="txt_shgname" value="<%=Helper.correctNull((String) hshValues.get("perapp_shgname"))%>" size="40"  maxlength="100">
      </td>
      <td nowrap width="17%">No. of members <span class="mantatory">*&nbsp;</span></td>
      <td nowrap width="16%" colspan="2"> <input type="text" name="txt_member" size="15" maxlength="6" value="<%=Helper.correctNull((String) hshValues.get("perapp_shgmember"))%>"
					     	style="text-align:right"  tabindex="1"></td>
     
      </tr>
	  <tr>
	  <td nowrap width="16%">Village</td>
      <td nowrap width="18%"><input type="text" name="txt_village" size="20" value="<%=Helper.correctNull((String) hshValues.get("perapp_shgvillage"))%>"	maxlength="50" >
      </td>
       
           <td nowrap width="15%">Representative 1</td>
                        <td nowrap width="17%"> 
                          <input type="text" name="txt_represent1" size="20" value="<%=Helper.correctNull((String) hshValues.get("perapp_shgrepresent1"))%>"	style="text-align:left" maxlength="50" tabindex="2"/>
                        </td>
						<td nowrap width="16%">Representative 2</td>
                        <td nowrap width="18%"> 
                          <input type="text" name="txt_represent2"  value="<%=Helper.correctNull((String) hshValues.get("perapp_shgrepresent2"))%>" size="20" maxlength="50" tabindex="3"/>
                        </td>
                      </tr>
                      <tr>
                      <td nowrap="" width="16%">Taluk</td>
                      <td nowrap="" width="18%"> 
                      <input type="text" name="txt_taluk" value="<%=Helper.correctNull((String) hshValues.get("perapp_shgtaluk"))%>" maxlength="50" size="20"/></td>
                       <td width="15%">Date of Establishment of SHG/Account opening</td>
            <td width="17%">
              <input type="text" name="txt_datestablish" size="12" maxlength="10" onBlur="checkDate(this);" style="text-align:right"  value="<%=Helper.correctNull((String) hshValues.get("perapp_shgdatestablish"))%>"tabindex="4">
            <a href="#"
							onClick="callCalender('txt_datestablish')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a>
            </td>
            <td width="16%">Type of SHG</td>
            <td width="18%"> 
              <select name="type_shg"  style="width: 120px;" tabindex="5">
               <option value=""> <------Select------> </option>
                <option value="w">Women</option>
                <option value="m">Men</option>
              </select>
            </td>
                      </tr>
             <tr>
           	<td nowrap width="16%">District</td>
            <td nowrap width="18%"><input type="text" 	name="txt_district" value="<%=Helper.correctNull((String) hshValues.get("perapp_shgdistrict"))%>" maxlength="50" size="20"> </td>
             <td width="15%">Whether Member of SHG
            </td>
            <td width="17%"> 
              <select name="sel_membershg" style="width: 120px;" tabindex="6">
                <option value=""><------Select------></option>
                <option value="y">Yes</option>
                <option value="n">No</option>
              </select>
		  <td nowrap width="16%">Details of Weekly meeting - Place </td>
            <td width="18%">
              <input type="text" name="txt_place" value="<%=Helper.correctNull((String) hshValues.get("perapp_shgplace"))%>" size="20" maxlength="50"  tabindex="7">
            </td>
            
            </tr>
            <tr><td nowrap width="16%">Pin Code</td>
            <td nowrap width="18%"><input type="text" name="txt_pinno" value="<%=Helper.correctNull((String) hshValues.get("perapp_shgpinno"))%>" maxlength="6" size="20">
                        </td>
            <td width="15%">Time
            </td>
            <td width="17%">
              <input type="text" name="txt_time" size="20" maxlength="25" onKeyPress="allowAlphaNumeric()"
						style="text-align:left"  value="<%=Helper.correctNull((String) hshValues.get("perapp_shgtime"))%>"  tabindex="8">
            </td>
            <td width="16%">Day</td>
            <td width="18%">
              <input type="text" name="txt_day"  size="20" maxlength="25" onkeypress="allowAlphaNumeric();" 
						style="text-align:left" value="<%=Helper.correctNull((String) hshValues.get("perapp_shgday"))%>"  tabindex="9">
            </td>
            </tr>
      	    <tr> 
            <td nowrap width="16%">Name of contact person
            </td>
            <td nowrap width="18%"> 
              <input type="text" name="txt_personname" value="<%=Helper.correctNull((String) hshValues.get("perapp_shgpersoname"))%>"
											maxlength="20" size="20" tabindex="10">
            </td>
           
            <td width="16%">Contact Telephone no.</td>
            <td width="17%">
              <input type="text" name="txt_telno" maxlength="15" value="<%=Helper.correctNull((String) hshValues.get("perapp_shgtelno"))%>" size="20" onKeyPress="allowNumber(this)" tabindex="11">
            </td>
            <td width="16%">Name of person maintaining the Books
            </td>
            <td width="18%"> 
              <input type="text" name="txt_personbook" value="<%=Helper.correctNull((String) hshValues.get("perapp_shgpersonbook"))%>" maxlength="50" size="20" onkeypress="allowAlphaNumericSpace();" tabindex="12">
            </td>
          </tr>
          <tr id="r1"> 
            <td nowrap width="16%">Bank SB Account No.
            </td>
            <td width="18%"> 
              <input type="text" name="txt_sbaccno" value="<%=Helper.correctNull((String) hshValues.get("perapp_shgsbaccno"))%>" size="20" maxlength="100"
				style="text-align:left" tabindex="13">
            </td>
            <td width="15%">Total Savings( Corpus)
              
            </td>
            <td width="17%"> 
               <lapschoice:CurrencyTag name="txt_totsavings" value='<%=Helper.correctNull((String) hshValues.get("perapp_shgtotsavings"))%>' size="20" maxlength="12"
			         style="text-align:right" tabindex="14"/>
            </td>
            <td width="16%">Wheteher SHG is Stree Shakti
            </td>
            <td width="18%"> 
              <select name="sel_sreeshakti"  style="width: 120px;" tabindex="15">
                <option value=""><------Select------></option>
                <option value="y">Yes</option>
                <option value="n">No</option>
              </select>
            </td>
            
          </tr>
          <tr id="r1"> 
            <td nowrap width="16%">Min Savings per/member/week
            </td>
            <td width="18%"> 
              <lapschoice:CurrencyTag name="txt_minsavings" value='<%=Helper.correctNull((String) hshValues.get("perapp_shgminsavings"))%>' size="20" maxlength="15"
				style="text-align:right" tabindex="16"/>
            </td>
          <td nowrap width="15%">Revolving fund </td>
            <td width="17%"> 
              <select name="sel_revolving"  style="width: 120px;" tabindex="17" onchange="showAmount();">
                <option value=""><------Select------></option>
                <option value="y">Yes</option>
                <option value="n">No</option>
              </select>
            </td>
            <td width="16%" id="amt1">Amount
              
            </td>
            <td width="18%" id="amt2"> 
              <lapschoice:CurrencyTag name="txt_amount" value='<%=Helper.correctNull((String) hshValues.get("perapp_shgamount"))%>' size="20" maxlength="12"
											 tabindex="18" style="text-align:right"/>
            </td>
          
          </tr>
          <tr id="r1"> 
           
            <td width="16%">Present activity of the group
            </td>
            <td width="18%"> 
              <input type="text" name="txt_activitygroup" value="<%=Helper.correctNull((String) hshValues.get("perapp_shgactygroup"))%>" size="20" maxlength="100"
				style="text-align:left" tabindex="19">
            </td>
			
			  <td width="15%">Wheteher Rotation of Representative happened 
            </td>
            <td width="17%"> 
              <select name="sel_rotation" style="width: 120px;" tabindex="20" onchange="showComment();">
                <option value=""><------Select------></option>
                <option value="y">Yes</option>
                <option value="n">No</option>
              </select>
            </td>
            <td width="16%">Recovery Percentage</td>
            <td width="18%"> 
               <lapschoice:CurrencyTag name="txt_recpercent" value='<%=Helper.correctNull((String) hshValues.get("perapp_shgrecpercent"))%>' size="20" maxlength="6" onBlur="checkPercentage(this)"
				style="text-align:right" tabindex="21"/>&nbsp;%				
            </td>
             </tr>
              <tr id="cmnt1"> 
           
            <!-- <td width="16%">&nbsp;
            </td> -->
            <td width="18%" align="left"> Comments
             
            </td>
			
			  <td width="15%" colspan="2"> <textarea name="rotation_comments" cols="50" style="text-align:left" tabindex="22"
											wrap="VIRTUAL" rows="3"
											onKeyPress="textlimit(rotation_comments,3999)"  onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("perapp_shgrotcomment"))%></textarea>
					
            </td>
            
            <td width="16%">&nbsp;</td>
            <td width="18%">&nbsp;</td>
             </tr>
        </table>		
                          
     	<%if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equals("")) { %>	
                  
		   <lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
		<% }  else { %>
				<span style="display: none; "><div >
			 <lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
				</div> </span>
					<lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
	   	<% } %>	
			
					
<input type="hidden" name="selsno"/>
<input type="hidden" name="hidcroptype" value="PR">
<input type="hidden" name="hidchobank_apptype">
<input type ="hidden" name="land_measurement" value ="">
<lapschoice:hiddentag pageid="<%=PageId%>"/>
</tr>
</table>		
<input type="hidden" name="app_constitution" value="<%=Helper.correctNull((String)hshValues.get("app_constitution"))%>">
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)request.getParameter("hidDemoId"))%>"> 
<input type="hidden" name="txtperapp_appid" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>">
<input type="hidden" name="hidappstatus" value="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>">
<input type="hidden" name="hid_FarmCat" value="">
<input type="hidden" name="hidEdit" value="">
<iframe height="0" width="0" id="ifrm1" frameborder="0" style="border: 0"></iframe>
</form>
</body>
</html>