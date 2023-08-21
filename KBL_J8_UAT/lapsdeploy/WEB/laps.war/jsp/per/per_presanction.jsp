<%@ page import="com.sai.laps.helper.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%

	String per_residence = Helper.correctNull((String) hshValues.get("per_residence"));
	String per_accdetails = Helper.correctNull((String) hshValues.get("per_accdetails"));
	String per_engineer = Helper.correctNull((String) hshValues.get("per_engineer"));
	String per_request = Helper.correctNull((String) hshValues.get("per_request"));
	String prop_type=Helper.correctNull((String)hshValues.get("proptype"));
	String duplicate=Helper.correctNull((String)hshValues.get("duplicate"));

%>

<html>
<head>
<title>Pre Sanction Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<script language="javascript">


var appUrl="<%=ApplicationParams.getAppUrl()%>";
var sel_complete1="<%=Helper.correctNull((String)hshValues.get("per_comp1"))%>";
var sel_complete2="<%=Helper.correctNull((String)hshValues.get("per_comp2"))%>";
var sel_complete3="<%=Helper.correctNull((String)hshValues.get("per_comp3"))%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
function callresi()
{
if(document.forms[0].sel_residence.value=="Others")
{
       document.all.od1.style.visibility="visible";
		document.all.od2.style.visibility="visible";
}	
else
{
 document.all.od1.style.visibility="hidden";
		document.all.od2.style.visibility="hidden";

}
}	

function whileLoading()
{	
	disableFields(true);	
	if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
	{
	enableButtons(true,true,true,false,false);
	}
	else
	{	
	enableButtons(false,true,true,false,false);
	}
	var varper_residence="<%=per_residence%>";
	var varper_proptype="<%=prop_type%>";
	var varper_duplicate="<%=duplicate%>";
	
	
	  if(varper_residence!="")
	  {
	   	document.forms[0].sel_residence.value =varper_residence;
	  }
 	  else
      {
      document.forms[0].sel_residence.value=="S";    
	  }
	  if(varper_duplicate!="")
	  {
	   	document.forms[0].txt_duplicate.value =varper_duplicate;
	  }
 	  else
      {
      document.forms[0].txt_duplicate.value=="0";    
	  }
	  if(varper_proptype!="")
	  {
	   	document.forms[0].txt_propytpe.value =varper_proptype;
	  }
 	  else
      {
      document.forms[0].txt_propytpe.value=="0";    
	  }
		
	    document.forms[0].sel_acdetails.value ="<%=per_accdetails%>";
	   
	    if(document.forms[0].sel_acdetails.value=="")
	    {
	      document.forms[0].sel_acdetails.value="S";
	    }
	    document.forms[0].sel_engineer.value ="<%=per_engineer%>";
	
	  if(document.forms[0].sel_engineer.value=="")
	  {
	   document.forms[0].sel_engineer.value="S";
	  }
	  
	   document.forms[0].sel_request.value ="<%=per_request%>";
	
	  if(document.forms[0].sel_request.value=="")
	   {
	    document.forms[0].sel_request.value="S";
	   }
	   
	document.forms[0].sel_compled1.value=sel_complete1;
	if(document.forms[0].sel_compled1.value=="")
	 {
	  document.forms[0].sel_compled1.value="S";
	 }
	document.forms[0].sel_compled2.value=sel_complete2;
	if(document.forms[0].sel_compled2.value=="")
	   {
	    document.forms[0].sel_compled2.value="S";
	   }
	document.forms[0].sel_compled3.value=sel_complete3;
	 if(document.forms[0].sel_compled3.value=="")
	 {
	 document.forms[0].sel_compled3.value="S";
	 }
document.forms[0].txt_othdesc.visible=false;
}

function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdapply.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;	
	document.forms[0].cmdclose.disabled=bool4;		
//	document.forms[0].cmdprint.disabled=bool5;	
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if((document.forms[0].elements[i].type=="text")||(document.forms[0].elements[i].type=="textarea"))
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		 if(document.forms[0].elements[i].type=="select-one")
		 {
		   document.forms[0].elements[i].disabled=val;		  
		  }
		  
	}
}
	
function doCancel()
{
	
	if(ConfirmMsg('102'))
	{	      			
		document.forms[0].action=appUrl+"controllerservlet";
		 document.forms[0].hidBeanId.value="Inspection";		
		document.forms[0].hidBeanGetMethod.value="getPDCCharges";
		document.forms[0].action=appUrl+"action/per_presanction.jsp";	
		document.forms[0].submit();
		
	}	
}

function doEdit()
{
	document.forms[0].hidMethod.value="";
disableFields(false);
enableButtons(true,false,false,true,true);
document.forms[0].txt_applicant.readOnly=true;
document.forms[0].txt_father.readOnly=true;
document.forms[0].txt_address.readOnly=true;	
}

function callCalender(name)
{
	if(document.forms[0].cmdapply.disabled==false)
	{
		showCal(appUrl,name);
	}
}

function doSave()
{
	disableFields(false);
	if(document.forms[0].txt_applicant.value=="")
	{
		ShowAlert(112,"'Name of the Applicant");
		document.forms[0].txt_applicant.focus();
		return;
	}
	if(document.forms[0].txt_duedelisenddate.value=="")
	{
		ShowAlert(112,"Due Duediligence Send Date");
		document.forms[0].txt_duedelisenddate.focus();
		return;
	}
	if(document.forms[0].txt_duedelirecedate.value=="")
	{
		ShowAlert(112,"Due Duediligence Received Date");
		document.forms[0].txt_duedelirecedate.focus();
		return;
	}
	if(document.forms[0].txt_purpose.value=="")
	{
		ShowAlert(112,"Purpose of loan");
		document.forms[0].txt_purpose.focus();
		return;
	}
	if(document.forms[0].txt_comments.value=="")
	{
		ShowAlert(112,"Comments of Visiting Officer");
		document.forms[0].txt_comments.focus();
		return;
	}
	if(document.forms[0].txt_signplace.value=="")
	{
		ShowAlert(112,"Place of Visiting Officer");
		document.forms[0].txt_signplace.focus();
		return;
	}
		if(document.forms[0].txt_signname.value=="")
	{
		ShowAlert(112,"Name of Visiting Officer");
		document.forms[0].txt_signname.focus();
		return;
	}
	if(document.forms[0].txt_signdate.value=="")
	{
		ShowAlert(112,"Date of Visit");
		document.forms[0].txt_signdate.focus();
		return;
	}
	if(document.forms[0].txt_signdesig.value=="")
	{
		ShowAlert(112,"Designation of Visiting Officer");
		document.forms[0].txt_signdesig.focus();
		return;
	}
	document.forms[0].cmdapply.disabled = true;
	document.forms[0].hidAppType.value="update";
	document.forms[0].hidBeanGetMethod.value="getPDCCharges";
	document.forms[0].hidBeanId.value="Inspection";
	document.forms[0].action=appUrl+"action/per_presanction.jsp";	
	document.forms[0].submit();
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{		
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>"+"action/perpropertydetails.jsp";
		document.forms[0].submit();
	}
}
function printreport()
{
	appno = document.forms[0].appno.value;	
	var purl = appUrl+"action/presanction_print.jsp?hidBeanGetMethod=getPDCCharges&hidBeanId=Inspection&appno="+appno;
	prop = "scrollbars=yes,width=700,height=450,statusbar=yes,menubar=yes";	
	xpos = (screen.width - 700) / 2;
	ypos = (screen.height - 650) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	var title = "Print1";	
	window.open(purl,title,prop);
}
function callland()
{
    appno = document.forms[0].appno.value;	
	var purl = appUrl+"action/presanction_land.jsp?hidBeanGetMethod=getlandCharges&hidBeanId=insreport&appno="+appno;
	prop = "scrollbars=no,width=700,height=450,statusbar=yes,menubar=no";	
	xpos = (screen.width - 700) / 2;
	ypos = (screen.height - 650) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	var title = "Print1";	
	window.open(purl,title,prop);


}



</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	bgcolor="#EEEAE3" onload="javascript:whileLoading();callresi();">
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
<form name="existpropos" method="post">
<table width="100%" border="1" cellpadding="0" cellspacing="0"
	bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
	<tr>
		<td id="mainlnk1"><jsp:include page="../share/Applurllinkper.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		
      <td><b><i>Home -&gt; Retail -&gt; 
        <%=(String) session.getAttribute("pgeLabel")%> -&gt; Appraisal -&gt; Pre-Sanction 
        Report </i></b></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td id="mainlnk1"><lapschoice:application /></td>
	</tr>
</table>

<table width="100%" border="1" cellpadding="0" cellspacing="0"
	bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
	<tr>
		<td><jsp:include page="../share/apprlinktab.jsp"
			flush="true">
			<jsp:param name="tabid" value="9" />
		</jsp:include></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="3">
	<tr>
		<td>
		<table width="100%" border="0"
			bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
			<tr>
				<td colspan="3" align="center"><b>PRE-SANCTION
				VISIT DETAILS FOR RETAIL LOANS</b>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">
          <tr> 
            <td width="25%" bgcolor="#CCCCCC" bordercolor="0"><b><font
					face="MS Sans Serif" size="1"> NAME OF THE APPLICANT</b></td>
            <td width="25%" bgcolor="#CCCCCC" bordercolor="0"><b><font	face="MS Sans Serif" size="1">FATHER&#146;S 
              /HUSBAND&#146;S </b></td>
            <td colspan="2" bgcolor="#CCCCCC" bordercolor="0"><font
					face="MS Sans Serif" size="1"><b>RESIDENTIAL ADDRESS</b></td>
          </tr>
          <%String title=Helper.correctNull((String)hshValues.get("perapp_title"));
          		
          		String fat_hus_name="";
          		if(title.equalsIgnoreCase("MRS"))
          		{
          			fat_hus_name =Helper.correctNull((String)hshValues.get("perapp_husname"));
          		}
          		else
          		{
          			fat_hus_name =Helper.correctNull((String)hshValues.get("perapp_fatname"));
          			
          		}
          		
          		%>
          <tr> 
            <td> 
              <input type="text" name="txt_applicant" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("perapp_firstname"))%>" readOnly>
            </td>
            <td width="25%" bordercolor="0">&nbsp; 
              <input type="text" name="txt_father" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)fat_hus_name)%>" readOnly>
              </td>
            <td colspan="2" bordercolor="0"> 
              <textarea name="txt_address"
					cols="50" onKeyPress="textlimit(this,199)" onKeyUp="textlimit(this,199)" ><%=Helper.correctNull((String) hshValues
							.get("perapp_address1"))%>, <%=Helper.correctNull((String) hshValues
							.get("perapp_address2"))%> ,<%=Helper.correctNull((String) hshValues
							.get("perapp_address3"))%>, <%=Helper.correctNull((String) hshValues
									.get("perapp_city"))%>, <%=Helper.correctNull((String) hshValues
									.get("perapp_state"))%> 
		</textarea>
            </td>
          </tr>
          <tr> 
            <td bordercolor="0">DUE DELIGENCE 
              RPT SEND DATE <b>*</b></td>
            <td bordercolor="0"> 
              <table width="40%" border="0" cellspacing="0" cellpadding="3">
                <tr> 
                  <td> 
                    <input type="text" name="txt_duedelisenddate" maxlength="50" onBlur="checkDate(this);checkmaxdate(this,currentDate)"
							value="<%=Helper.correctNull((String)hshValues.get("per_duedeli_send_dt"))%>" >
                  </td>
                  <td><a alt="Select date from calender" href="#"
							onClick="callCalender('txt_duedelisenddate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
							alt="Select date from calender" ></a></td>
                </tr>
              </table>
            </td>
            <td bordercolor="0">DUE DELI RECEIVED 
              DATE <b>*</b></td>
            <td bordercolor="0"> 
              <table width="40%" border="0" cellspacing="0" cellpadding="3">
                <tr> 
                  <td> 
                    <input type="text" name="txt_duedelirecedate" maxlength="50"
							size="11" onBlur="checkDate(this);checkmaxdate(this,currentDate)"
							value="<%=Helper.correctNull((String)hshValues.get("per_duedeli_rece_dt"))%>">
                  </td>
                  <td><a alt="Select date from calender" href="#"
							onClick="callCalender('txt_duedelirecedate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
							alt="Select date from calender"></a></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td width="25%" bordercolor="0">PURPOSE 
              OF LOAN <b>*</b></td>
            <td width="25%" bordercolor="0"> 
              <input type="text"
					name="txt_purpose" maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_purpose"))%>">
            </td>
            <td width="25%" bordercolor="0"> 
              NAME OF THE PRODUCT / ARTICLE TO BE PURCHASED<br>
              </td>
            <td width="25%" bordercolor="0"> 
              <input type="text"
					name="txt_product" maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_product"))%>">
            </td>
          </tr>
          <tr> 
            <td width="25%" bordercolor="0"> 
              NAME OF THE SUPPLIER</td>
            <td width="25%" bordercolor="0"> 
              <input type="text"
					name="txt_supplier" maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_supplier"))%>">
            </td>
            <td width="25%" bordercolor="0">PURCHASE 
              PRICE (incl Tax) </td>
            <td width="25%" bordercolor="0"> <lapschoice:CurrencyTag name="txt_price"
					maxlength="12" 
					value='<%=Helper.correctNull((String)hshValues.get("per_price"))%>'/> 
            </td>
          </tr>
          <tr bgcolor="#CCCCCC"> 
            <td colspan="4" bordercolor="0" bgcolor="#CCCCCC"><font
					face="MS Sans Serif" size="1"><b>GENUINESS OF QUOTATION VERIFIED 
              </b></td>
          </tr>
          <tr> 
            <td height="19" bordercolor="0">OVER 
              PHONE NO.</td>
            <td height="19" bordercolor="0"> 
              <input type="text" name="txt_phone" style="text-align:left"
					maxlength="15" onKeyPress="allowPhone()"
					value="<%=Helper.correctNull((String)hshValues.get("per_phone"))%>">
            </td>
            <td height="19" bordercolor="0">NAME 
              OF THE PERSON CONTACTED</td>
            <td height="19" bordercolor="0"> 
              <input type="text"
					name="txt_contact1" maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_contact1"))%>">
            </td>
          </tr>
          <tr> 
            <td width="25%" bordercolor="0">BY 
              PERSONAL VISIT</td>
            <td width="25%" bordercolor="0"> 
              <input type="text"
					name="txt_personal" onKeyPress="notAllowSplChar()" maxlength="50"
					value="<%=Helper.correctNull((String)hshValues.get("per_personal"))%>">
            </td>
            <td width="25%" bordercolor="0">NAME 
              OF THE PERSON CONTACTED</td>
            <td width="25%" bordercolor="0"> 
              <input type="text"
					name="txt_contact2" maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_contact2"))%>">
            </td>
          </tr>
          <tr> 
            <td width="25%" bordercolor="0">DATE 
              OF VISIT </td>
            <td width="25%" bordercolor="0"> 
              <table>
                <tr> 
                  <td> 
                    <input type="text"
					name="txt_visitdate" maxlength="10" onBlur="checkDate(this)" size="12"
					value="<%=Helper.correctNull((String)hshValues.get("per_visitdate"))%>">
                  </td>
                  <td><a alt="Select date from calender" href="#"
							onClick="callCalender('txt_visitdate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
							alt="Select date from calender"></a> </td>
                </tr>
              </table>
            <td width="25%" bordercolor="0">&nbsp;</td>
            <td width="25%" bordercolor="0">&nbsp; 
              </td>
          </tr>
          <tr align="center"> 
            <td colspan="4" valign="top" bordercolor="0"> 
              <div align="center">PROOF FOR 
                VERIFICATION OF RESIDENTIAL ADDRESS--- Ration Card No.&nbsp;,&nbsp;&nbsp;Voters 
                ID Card No,.Passport No./ PAN Card No ,Rent Agreement,Electricity/Telephone 
                bill (-1- bill older than 6 months and &#150;1- latest bill),Whether 
                residing with parents/relatives<br>
                <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                <textarea name="txt_proof"
					onKeyPress="notAllowSplChar();" cols="50"><%=Helper.correctNull((String) hshValues.get("per_proof"))%></textarea>
                </div>
            </td>

          </tr>
          <tr> 
            <td width="25%" bordercolor="0">Residence 
              is </td>
            <td width="25%" bordercolor="0"> 
              <select name="sel_residence" onChange="callresi()">
                <option value="S" selected>Select</option>
                <option value="Owned">Owned</option>
                <option value="Rented">Rented</option>
                <option value="Leased">Leased</option>
                <option value="Others">Others</option>
                <option value="Provided by Employer">Provided by Employer</option>
              </select>
            </td>
            <td width="25%" bordercolor="0">&nbsp;</td>
            <td width="25%" bordercolor="0">&nbsp;</td>
          </tr>
          <tr> 
            <td id="od1"width="25%" bordercolor="0">Others 
              Description </td>
            <td id="od2"width="25%" bordercolor="0"> 
              <input type="text" name="txt_othdesc" size="18">
            </td>
            <td width="25%" bordercolor="0">Place 
              visited with Identification Landmark.</td>
            <td width="25%" bordercolor="0"> 
              <input type="text"
					name="txt_placevisit" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_placevisit"))%>">
            </td>
          </tr>
          <tr> 
            <td colspan="4" bgcolor="#CCCCCC" bordercolor="0"><font
					face="MS Sans Serif" size="1"><b>OCCUPATION OF APPLICANT (GIVE 
              DETAILS) :</b></td>
          </tr>
          <tr> 
            <td colspan="2" align="center" bordercolor="0"><font
					face="MS Sans Serif" size="1">A) SERVICE </td>
            <td colspan="2" align="center" bordercolor="0"><font
					face="MS Sans Serif" size="1">B) BUSINESS<br>
              </td>
          </tr>
          <tr> 
            <td width="25%" bordercolor="0">Name 
              of employer </td>
            <td width="25%" bordercolor="0"> 
              <input type="text"
					name="txt_employer" maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_employer"))%>">
            </td>
            <td width="25%" bordercolor="0">Name 
              of the firm<br>
              </td>
            <td width="25%" bordercolor="0"> 
              <input type="text"
					name="txt_firmname" maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_firmname"))%>">
            </td>
          </tr>
          <tr> 
            <td width="25%" bordercolor="0">Address</td>
            <td width="25%" bordercolor="0"> 
              <textarea name="txt_add1"
					onKeyPress="notAllowSplChar(); "><%=Helper.correctNull((String) hshValues.get("per_add1"))%></textarea>
            </td>
            <td width="25%" bordercolor="0">Address.</td>
            <td width="25%" bordercolor="0"> 
              <textarea name="txt_add2"
					onKeyPress="notAllowSplChar(); "><%=Helper.correctNull((String) hshValues.get("per_add2"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td bordercolor="0"> Designation 
              with PA No </td>
            <td bordercolor="0"> 
              <input type="text" name="txt_desig"
					maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_desig"))%>">
            </td>
            <td bordercolor="0"> Applicants 
              position in the firm</td>
            <td width="25%" bordercolor="0"> 
              <input type="text"
					name="txt_position" maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_position"))%>">
            </td>
          </tr>
          <tr> 
            <td bordercolor="0">Working since</td>
            <td bordercolor="0"> 
              <input type="text" name="txt_work"
					maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_work"))%>">
            </td>
            <td bordercolor="0">Established 
              since</td>
            <td width="25%" bordercolor="0"> 
              <input type="text"
					name="txt_establish" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_establish"))%>">
            </td>
          </tr>
          <tr> 
            <td bordercolor="0"> Employee No.</td>
            <td bordercolor="0"> 
              <input type="text" name="txt_empno"
					maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_empno"))%>">
            </td>
            <td bordercolor="0">  Nature of 
              Business</td>
            <td width="25%" bordercolor="0"> 
              <input type="text" name="txt_nature"
					maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_nature"))%>">
            </td>
          </tr>
          <tr> 
            <td colspan="2" bordercolor="0">Whether 
              confirmed / probation / or on contract basis</td>
            <td bordercolor="0"> 
              <input type="text" name="txt_confirm"
					maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_confirm"))%>">
            </td>
            <td width="25%" bordercolor="0">&nbsp;</td>
          </tr>
          <tr> 
            <td width="25%" bordercolor="0">Phone 
              No.</td>
            <td width="25%" bordercolor="0"> 
              Office </td>
            <td width="25%" bordercolor="0">Residence</td>
            <td width="25%" bordercolor="0">Mobile</td>
          </tr>
          <tr> 
            <td width="25%" bordercolor="0">&nbsp;</td>
            <td width="25%" bordercolor="0"> 
              <input type="text" name="txt_office"
					maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_office"))%>">
            </td>
            <td width="25%" bordercolor="0"> 
              <input type="text" name="txt_resi"
					maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_resi"))%>">
            </td>
            <td width="25%" bordercolor="0"> 
              <input type="text" name="txt_mobile"
					maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_mobile"))%>">
            </td>
          </tr>
          <tr bgcolor="#CCCCCC"> 
            <td colspan="4" bordercolor="0" bgcolor="#CCCCCC"><font
					face="MS Sans Serif" size="1"><b>SELF-EMPLOYED &amp; PROFESSIONAL 
              </b></td>
          </tr>
          <tr> 
            <td width="25%" bordercolor="0">Occupation</td>
            <td width="25%" bordercolor="0"> 
              <input type="text"
					name="txt_occupation" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_occupation"))%>">
            </td>
            <td width="25%" bordercolor="0">Address</td>
            <td width="25%" bordercolor="0"> 
              <textarea name="txt_add3" rows="3"
					wrap="VIRTUAL" ><%=Helper.correctNull((String) hshValues.get("per_add3"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td width="25%" bordercolor="0">Phone 
              No.</td>
            <td width="25%" bordercolor="0"> 
              Office</td>
            <td width="25%" bordercolor="0">Residence</td>
            <td width="25%" bordercolor="0">Mobile</td>
          </tr>
          <tr> 
            <td width="25%" bordercolor="0">&nbsp;</td>
            <td width="25%" bordercolor="0"> 
              <input type="text"
					name="txt_office2" maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_office2"))%>">
            </td>
            <td width="25%" bordercolor="0"> 
              <input type="text" name="txt_resi2"
					maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_resi2"))%>">
            </td>
            <td width="25%" bordercolor="0"> 
              <input type="text"
					name="txt_mobile2" maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_mobile2"))%>">
            </td>
          </tr>
          <tr bgcolor="#CCCCCC"> 
            <td colspan="4" bordercolor="0"><b>EMPLOYMENT 
              DETAILS </b></td>
          </tr>
          <tr> 
            <td width="25%" bordercolor="0">Details 
              verified by / through<br>
              Personal visit to Office on <br>
              <br>
              </td>
            <td width="25%" bordercolor="0"> 
              <input type="text" name="txt_verify"
					maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_verify"))%>">
            </td>
            <td width="25%" bordercolor="0">Name 
              of person contacted<br>
              </td>
            <td width="25%" bordercolor="0"> 
              <input type="text" name="txt_person"
					maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_person2"))%>">
            </td>
          </tr>
          <tr> 
            <td width="25%" bordercolor="0">Over 
              Tel. No.</td>
            <td width="25%" bordercolor="0"> 
              <input type="text"
					name="txt_overtel" maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_overtel2"))%>">
            </td>
            <td width="25%" bordercolor="0">Name 
              of person contacted </td>
            <td width="25%" bordercolor="0"> 
              <input type="text"
					name="txt_telperson" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_persontel2"))%>">
            </td>
          </tr>
          <tr> 
            <td width="25%" bordercolor="0">Gross 
              Annual/Monthly Income ?- if any deviation found'</td>
            <td width="25%" bordercolor="0"> 
              <input type="text" name="txt_income"
					maxlength="12" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_income"))%>">
            </td>
            <td width="25%" bordercolor="0">&nbsp;</td>
            <td width="25%" bordercolor="0">&nbsp;</td>
          </tr>
          <tr bgcolor="#CCCCCC"> 
            <td colspan="4" bordercolor="0"><b>DETAILS 
              VERIFIED FROM: </b> </td>
          </tr>
          <tr> 
            <td bordercolor="0">a. Form No.16 
              (for the financial year ended March 200 &#133;)<br>
              </td>
            <td bordercolor="0"> 
              <input type="text" name="txt_form16"
					maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_form16"))%>">
            </td>
            <td bordercolor="0">b. Last Salary 
              Slip (for the month of </td>
            <td bordercolor="0"> 
              <input type="text" name="txt_salslip"
					maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_salslip"))%>">
            </td>
          </tr>
          <tr> 
            <td width="25%" bordercolor="0">c. 
              Income tax Return for A.Y. (along with original copy of Tax Challan 
              Period )</td>
            <td width="25%" bordercolor="0"> 
              <input type="text"
					name="txt_taxreturn" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_taxreturn"))%>">
            </td>
            <td width="25%" bordercolor="0">d. 
              Net annual/monthly income</td>
            <td width="25%" bordercolor="0"> 
              <input type="text"
					name="txt_netincome" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_netincome"))%>">
            </td>
          </tr>
          <tr> 
            <td width="25%" bordercolor="0">e. 
              Total annual/monthly deductions Rs:</td>
            <td width="25%" bordercolor="0"> 
              <input type="text"
					name="txt_deductions" maxlength="12"
					ononKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_deductions"))%>">
            </td>
            <td width="25%" bordercolor="0">&nbsp;</td>
            <td width="25%" bordercolor="0"> 
              <input type="hidden"
					name="txt_dependent" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_dependent"))%>">
            </td>
          </tr>
          <tr bgcolor="#CCCCCC"> 
            <td width="25%"><b>PRESENT BANKERS</b></td>
            <td width="25%">&nbsp;</td>
            <td width="25%">&nbsp;</td>
            <td width="25%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="25%">Name of the Bank<br>
              </td>
            <td width="25%"> 
              <input type="text" name="txt_bank" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_bank"))%>">
            </td>
            <td width="25%">Branch</td>
            <td width="25%"> 
              <input type="text" name="txt_branch" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_branch"))%>">
            </td>
          </tr>
          <tr> 
            <td width="25%">Type of A/c.</td>
            <td width="25%"> 
              <input type="text" name="txt_type" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_type"))%>">
            </td>
            <td width="25%">A/c. No.</td>
            <td width="25%"> 
              <input type="text" name="txt_accno" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_accno"))%>">
            </td>
          </tr>
          <tr> 
            <td width="25%">Details of A/c 
              verified from</td>
            <td width="25%"> 
              <select name="sel_acdetails">
                <option value="S" selected>Select</option>
                <option value="Bank Statement">Bank Statement</option>
                <option value="Pass Book">Pass Book</option>
              </select>
            </td>
            <td width="25%">Cheque returned- 
              number of times : </td>
            <td width="25%"> 
              <input type="text" name="txt_chkreturn"
					maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_chkreturn"))%>">
            </td>
          </tr>
          <tr bgcolor="#CCCCCC"> 
            <td width="25%"><b>Pension </b></td>
            <td width="25%">&nbsp;</td>
            <td width="25%">&nbsp;</td>
            <td width="25%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="25%">Pension Account 
              No <br>
              </td>
            <td width="25%"> 
              <input type="text" name="txt_pension" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("pension"))%>">
            </td>
            <td width="25%">Name of the Branch</td>
            <td width="25%"> 
              <input type="text" name="txt_nameofbr" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("nameofbr"))%>">
            </td>
          </tr>
          <tr> 
            <td width="25%">Monthly Pension 
              Amount</td>
            <td width="25%"> 
              <input type="text" name="txt_monthlyamt" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("monthlyamt"))%>">
            </td>
            <td width="25%">&nbsp;</td>
            <td width="25%" height="54">&nbsp; </td>
          </tr>
          <tr bgcolor="#CCCCCC"> 
            <td width="25%"><b>OLD VEHICLES</b></td>
            <td width="25%">&nbsp;</td>
            <td width="25%">&nbsp;</td>
            <td width="25%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="25%">Type of Vehicle<br>
              </td>
            <td width="25%"> 
              <input type="text" name="txt_vechicletype" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("vechicletype"))%>">
            </td>
            <td width="25%">Age of Vehicles</td>
            <td width="25%"> 
              <input type="text" name="txt_age" maxlength="50"
					onKeyPress="allowNumber(this)"
					value="<%=Helper.correctNull((String)hshValues.get("age"))%>">
            </td>
          </tr>
          <tr> 
            <td width="25%">Value of the Vehicles</td>
            <td width="25%"> 
              <input type="text" name="txt_valvec" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("valvec"))%>">
            </td>
            <td width="25%">Value by &amp; 
              date </td>
            <td width="25%"> 
              <input type="text" name="txt_valueby" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("valueby"))%>">
            </td>
          </tr>
          <tr> 
            <td width="25%">Any Prior charges</td>
            <td width="25%"> 
              <textarea name="txt_priorcha"
					><%=Helper.correctNull((String) hshValues
							.get("priorcha"))%></textarea>
            </td>
            <td width="25%">Registration no</td>
            <td width="25%"> 
              <input type="text" name="txt_reg" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("reg"))%>">
            </td>
          <tr> 
            <td width="25%" height="46" rowspan="2">Chassis 
              No</td>
            <td width="25%" height="46" rowspan="2"> 
              <input type="text" name="txt_chasis"
					maxlength="50" onKeyPress="allowNumber(this)"
					value="<%=Helper.correctNull((String)hshValues.get("chasis"))%>">
            </td>
            <td width="25%" height="22">Engine 
              no</td>
            <td width="25%" height="22"> 
              <input type="text" name="txt_engine"
					maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("engine"))%>">
            </td>
          </tr>
          <tr> 
            <td width="25%" height="22">Duplicate Key 
              obtained by the bank</td>
            <td width="25%" height="22">
              <select name="txt_duplicate">
			  <option value="0" selected>select</option>
                <option value="1">Yes</option>
                <option value="2">No</option>
              </select>
            </td>
          </tr>
          <tr bgcolor="#CCCCCC"> 
            <td width="25%"><b>Title Deed</b></td>
            <td width="25%">&nbsp;</td>
            <td width="25%">&nbsp;</td>
            <td width="25%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="25%">Deed no<br>
              </td>
            <td width="25%"> 
              <input type="text" name="txt_sale" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("sale"))%>">
            </td>
            <td width="25%">Name of Sub Registrar</td>
            <td width="25%"> 
              <input type="text" name="txt_sub"
					maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("sub"))%>">
            </td>
          </tr>
          <tr> 
            <td width="25%">Age of the Buliding</td>
            <td width="25%"> 
              <input type="text" name="txt_agebuild" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("agebuild"))%>">
            </td>
            <td width="25%">Any Prior charges</td>
            <td width="25%"> 
              <input type="text" name="txt_prior1" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("prior1"))%>">
            </td>
          </tr>
          <tr> 
            <td width="25%" height="54">Name 
              of Owner of the Property</td>
            <td width="25%" height="54"> 
              <input type="text" name="txt_owner" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("owner"))%>">
            </td>
            <td width="25%" height="54">Property 
              Type</td>
            <td width="25%" height="54"> 
              <select name="txt_propytpe">
                <option value="0" selected>select</option>
                <option value="1">Residential</option>
                <option value="2">Commerical</option>
              </select>
            </td>
          <tr bgcolor="#CCCCCC"> 
            <td width="25%"><b>LOAN OUTSTANDING 
              </b></td>
            <td width="25%"><b> WITH OUR BANK 
              </b></td>
            <td width="25%"><b>WITH OTHER 
              BANK</b></td>
            <td width="25%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="25%">Name of the Branch</td>
            <td width="25%"> 
              <input type="text" name="txt_loan1" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_loan1"))%>">
            </td>
            <td width="25%"> 
              <input
					type="text" name="txt_loan2" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_loan3"))%>">
              </td>
            <td width="25%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="25%">Type of Loan</td>
            <td width="25%"> 
              <input type="text" name="txt_loan3" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_loan3"))%>">
            </td>
            <td width="25%"> 
              <input
					type="text" name="txt_loan4" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_loan4"))%>">
              </td>
            <td width="25%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="25%">Amount sanctioned</td>
            <td width="25%"> 
              <input type="text" name="txt_loan5" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_loan5"))%>">
            </td>
            <td width="25%"> 
              <input
					type="text" name="txt_loan6" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_loan6"))%>">
              </td>
            <td width="25%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="25%">Balance outstanding</td>
            <td width="25%"> 
              <input type="text" name="txt_loan7" maxlength="50"
					oonKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_loan7"))%>">
            </td>
            <td width="25%"> 
              <input type="text" name="txt_loan8" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_loan8"))%>">
            </td>
            <td width="25%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="25%">Amount of Overdues, 
              if any<br>
              </td>
            <td width="25%"> 
              <input type="text" name="txt_loan9" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_loan9"))%>">
            </td>
            <td width="25%"> 
              <input type="text" name="txt_loan10" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_loan10"))%>">
            </td>
            <td width="25%">&nbsp;</td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr bgcolor="#CCCCCC"> 
            <td colspan="4"><b>INSPECTION 
              DETAILS</b></td>
          </tr>
          <tr> 
            <td> Name of the Inspecting Officer</td>
            <td> 
              <input type="text" name="txt_inspector1" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_inspName1"))%>">
            </td>
            <td>Designation with PA No</td>
            <td> 
              <input type="text" name="txt_insdesignation1" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_inspdesign1"))%>">
            </td>
          </tr>
          <tr> 
            <td>Date of Visit</td>
            <td> 
              <table width="30%" border="0">
                <tr> 
                  <td> 
                    <input type="text" name="txt_insvisitdate1" size="11"
							maxlength="50"
							onBlur="checkDate(document.forms[0].txt_insvisitdate1);"
							value="<%=Helper.correctNull((String)hshValues.get("visitdate1"))%>">
                  </td>
                  <td><a alt="Select date from calender" href="#"
							onClick="callCalender('txt_insvisitdate1')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
							alt="Select date from calender"></a></td>
                </tr>
              </table>
              &nbsp; </td>
            <td>House / Flat is Completed 
              ?</td>
            <td> 
              <select name="sel_compled1">
                <option value="S" selected>Select</option>
                <option value="Y">Yes</option>
                <option value="N">No</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td>Comments on site Location</td>
            <td> 
              <textarea name="txt_sitelocation1"
					><%=Helper.correctNull((String) hshValues
							.get("per_site_remarks1"))%></textarea>
            </td>
            <td> Comments on Adverse Features</td>
            <td> 
              <textarea name="txt_Adversefeatures1"
					><%=Helper.correctNull((String) hshValues
							.get("per_advfea_remarks1"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td>Comments on Construction/building 
              Stage</td>
            <td> 
              <textarea name="txt_constructstage1"
					><%=Helper.correctNull((String) hshValues
							.get("per_const_remarks1"))%></textarea>
            </td>
            <td> General Remarks/observations</td>
            <td> 
              <textarea name="txt_remarks1"
					><%=Helper.correctNull((String) hshValues
							.get("per_obser_remarks1"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td> Name of the Inspecting Officer</td>
            <td> 
              <input type="text" name="txt_inspector2" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_inspName2"))%>">
            </td>
            <td>Designation with PA No</td>
            <td> 
              <input type="text" name="txt_insdesignation2" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_inspdesign2"))%>">
            </td>
          </tr>
          <tr> 
            <td>Date of Visit</td>
            <td> 
              <table width="30%" border="0">
                <tr> 
                  <td> 
                    <input type="text" name="txt_insvisitdate2" size="11"
							maxlength="50"
							onBlur="checkDate(document.forms[0].txt_insvisitdate2);"
							value="<%=Helper.correctNull((String)hshValues.get("visitdate2"))%>">
                  </td>
                  <td><a alt="Select date from calender" href="#"
							onClick="callCalender('txt_insvisitdate2')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
							alt="Select date from calender"></a></td>
                </tr>
              </table>
            </td>
            <td>House / Flat is Completed 
              ?</td>
            <td> 
              <select name="sel_compled2">
                <option value="S" selected>Select</option>
                <option value="Y">Yes</option>
                <option value="N">No</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td>Comments on site Location</td>
            <td> 
              <textarea name="txt_sitelocation2"
					 ><%=Helper.correctNull((String) hshValues
							.get("per_site_remarks2"))%></textarea>
            </td>
            <td> Comments on Adverse Features</td>
            <td> 
              <textarea name="txt_Adversefeatures2"
					 ><%=Helper.correctNull((String) hshValues
							.get("per_advfea_remarks2"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td>Comments on Construction Stage</td>
            <td> 
              <textarea name="txt_constructstage2"
					 ><%=Helper.correctNull((String) hshValues
							.get("per_const_remarks2"))%></textarea>
            </td>
            <td> General Remarks/observations</td>
            <td> 
              <textarea name="txt_remarks2"
				 ><%=Helper.correctNull((String) hshValues
							.get("per_obser_remarks2"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td>Name of the Inspecting Officer</td>
            <td> 
              <input type="text" name="txt_inspector3" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_inspName3"))%>">
            </td>
            <td>Designation with PA No</td>
            <td> 
              <input type="text" name="txt_designation3" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_inspdesign3"))%>">
            </td>
          </tr>
          <tr> 
            <td>Date of Visit</td>
            <td> 
              <table width="30%" border="0">
                <tr> 
                  <td> 
                    <input type="text" name="txt_insvisitdate3" size="11"
							maxlength="50"
							onBlur="checkDate(document.forms[0].txt_insvisitdate3);"
							value="<%=Helper.correctNull((String)hshValues.get("visitdate3"))%>">
                  </td>
                  <td><a alt="Select date from calender" href="#"
							onClick="callCalender('txt_insvisitdate3')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
							alt="Select date from calender"></a></td>
                </tr>
              </table>
            </td>
            <td>House / Flat is Completed 
              ?</td>
            <td> 
              <select name="sel_compled3">
                <option value="S" selected>select</option>
                <option value="Y">Yes</option>
                <option value="N">No</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td>Comments on site Location 
              </td>
            <td> 
              <textarea name="txt_sitelocation3"><%=Helper.correctNull((String) hshValues
							.get("per_site_remarks3"))%></textarea>
            </td>
            <td> Comments on Adverse Features</td>
            <td> 
              <textarea name="txt_Adversefeatures3" ><%=Helper.correctNull((String) hshValues
							.get("per_advfea_remarks3"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td>comments on construction/building 
              stage</td>
            <td> 
              <textarea name="txt_constructstage3"><%=Helper.correctNull((String) hshValues
							.get("per_const_remarks3"))%></textarea>
            </td>
            <td> General Remarks/observations</td>
            <td> 
              <textarea name="txt_remarks3"><%=Helper.correctNull((String) hshValues
							.get("per_obser_remarks3"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr bgcolor="#CCCCCC"> 
            <td colspan="4"><b>DETAILS OF 
              PROPERTY TO BE PURCHASED</b></td>
          </tr>
          <tr> 
            <td width="25%">Loan requested 
              for </td>
            <td width="25%"> 
              <select name="sel_request">
                <option value="S" selected>Select</option>
                <option value="Purchase of Land">Purchase of Land &amp; Construction 
                of House</option>
                <option value="Ready Flat">Purchase of Ready Flat</option>
                <option value="Purchase of Old House">Purchase of Ready Built 
                House</option>
                <option value="Repairs and Renovation">Repairs and Renovation</option>
                <option value="Take Over from other bank">Take Over from other 
                bank</option>
                <option value="Construction of house">Construction of House</option>
              </select>
            </td>
            <td width="25%">Sale Amount</td>
            <td width="25%"> 
              <input type="text" name="txt_saleamt" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_saleamt"))%>">
            </td>
          </tr>
          <tr> 
            <td width="25%">Value as per Valuation 
              Report, value indicated in the sale deed may also be taken into 
              account. In case of wide variation, comments required.</td>
            <td width="25%"> 
              <input type="text" name="txt_valreport"
					maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_valreport"))%>">
            </td>
            <td width="25%">Name of the person 
              representing seller/builder</td>
            <td width="25%"> 
              <input type="text" name="txt_represent"
					maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_represent"))%>">
            </td>
          </tr>
          <tr> 
            <td width="25%">Area in sq.ft. 
              as per sale agreement<br>
              </td>
            <td width="25%"> 
              <input type="text" name="txt_area" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_area"))%>">
            </td>
            <td width="25%">Whether owner 
              Occupied/Rented/Leased</td>
            <td width="25%"> 
              <input type="text" name="txt_whether" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_whether"))%>">
            </td>
          </tr>
          <tr> 
            <td width="25%">Present Status 
              of construction</td>
            <td width="25%"> 
              <input type="text" name="txt_constuctions"
					maxlength="50" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_constructions"))%>">
            </td>
            <td width="25%">b. Report / Valuation 
              from Architect / Engineer Obtained </td>
            <td width="25%"> 
              <select name="sel_engineer">
                <option value="S" selected>Select</option>
                <option value="Yes">Yes</option>
                <option value="No">No</option>
              </select>
            </td>
          </tr>
          <tr bgcolor="#CCCCCC"> 
            <td colspan="4"><b>NEARBY LANDMARK 
              FOR IDENTIFICATION : </b></td>
          </tr>
          <tr> 
            <td width="25%">EAST</td>
            <td width="25%"> 
              <input type="text" name="txt_east" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_east"))%>">
            </td>
            <td width="25%">WEST</td>
            <td width="25%"> 
              <input type="text" name="txt_west" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_west"))%>">
            </td>
          </tr>
          <tr> 
            <td width="25%">NORTH</td>
            <td width="25%"> 
              <input type="text" name="txt_north" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_north"))%>">
            </td>
            <td width="25%">SOUTH</td>
            <td width="25%"> 
              <input type="text" name="txt_south" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_south"))%>">
            </td>
          </tr>
          <tr> 
            <td colspan="2">COMMENTS OF VISITING 
              OFFICER <b>*</b></td>
            <td colspan="2"> 
              <textarea name="txt_comments"><%=Helper.correctNull((String) hshValues
									.get("per_comments"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td>Place<b> 
              *</b></td>
            <td> 
              <input type="text" name="txt_signplace" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_signplace"))%>">
            </td>
            <td>Name <b>*</b></td>
            <td> 
              <input type="text" name="txt_signname" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_signname"))%>">
            </td>
          </tr>
          <tr> 
            <td>Date <b>*</b></td>
            <td> 
              <table>
                <tr> 
                  <td> 
                    <input type="text" name="txt_signdate" maxlength="10"
					onBlur="checkDate(this)" size="12"
					value="<%=Helper.correctNull((String)hshValues.get("per_signdate"))%>">
                  </td>
                  <td><a alt="Select date from calender" href="#"
							onClick="callCalender('txt_signdate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
							alt="Select date from calender"></a> </td>
                </tr>
              </table>
            </td>
            <td>Designation with PA No <b>*</b></td>
            <td> 
              <input type="text" name="txt_signdesig" maxlength="50"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("per_signdesig"))%>">
            </td>
          </tr>
        </table>
		</td>
	</tr>
</table>
<br>
<table border="1" cellspacing="0" cellpadding="0"
	bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
	<tr bordercolordark="#FFFFFB"
		bordercolorlight="#8F8369">
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			align="center">
			<tr valign="top">
				<td align="center"><input type="button" name="cmdedit" value="Edit"
					style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
					onclick="doEdit()"></td>
				<td align="center"><input type="button" name="cmdapply"
					value="Save"
					style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
					onclick="doSave()"></td>
				<td align="center"><input type="button" name="cmdcancel"
					value="Cancel"
					style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
					onclick="doCancel()"></td>
				<td align="center"><input type="button" name="cmdhelp" value="Help"
					style="background-color:#009966;cursor:help;;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
					onclick="doHelp()"></td>
				<td align="center"><input type="button" name="cmdclose"
					value="Close"
					style="background-color:#CC3300;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
					onclick="doClose()"></td>
			
			</tr>
			
		</table>
		</td>
	</tr>
</table>
<lapschoice:hiddentag/>
<input type="hidden" name="hidAppType" value="<%=Helper.correctNull((String)hshValues.get("hidAppType"))%>"> 
<input type="hidden" name="radLoan" value="Y"> 
<input type="hidden" name="prdcode" value="<%=Helper.correctNull((String)hshValues.get("prdcode")) %>"> 
<input type="hidden" name="hidValid" value = "Y">
<INPUT TYPE="hidden" NAME="hidMethod">
<input type="hidden" name=hidcity" value="<%=Helper.correctNull((String)hshValues.get("hidcity"))%>"/>
<input type="hidden" name=hidstate" value="<%=Helper.correctNull((String)hshValues.get("hidstate"))%>"/>
<%-- 
<input type="hidden" name="hid_pagename" value=""> 
<input type="hidden" name="hid_id" value="<%=session.getAttribute("strUserId")%>"> 
<input type="hidden" name="comappid" value="<%=Helper.correctNull((String)session.getAttribute("comappid"))%>">
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)session.getAttribute("hidDemoId"))%>">
<input type="hidden" name="applicationnumber" value="<%=(String)request.getParameter("appno")%>"> 
--%>
</form>
</body>
</html>

