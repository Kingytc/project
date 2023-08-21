<%@ page import="com.sai.laps.helper.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
String prd_type = Helper.correctNull((String) session.getAttribute("strProductType"));
String stremployment= Helper.correctNull((String) session.getAttribute("perapp_employment"));  

String strvehicleduplikeyobtain=Helper.correctNull((String)hshValues.get("pre_vehicleduplikeyobtain"));
String strpropcompleted=Helper.correctNull((String)hshValues.get("pre_propcompleted"));
String strpermissionobtained=Helper.correctNull((String)hshValues.get("pre_permissionobtained"));
String strpropvalreportobtained=Helper.correctNull((String)hshValues.get("pre_propvalreportobtained"));
String strpropdesc=Helper.correctNull((String)hshValues.get("pre_propdesc"));
String strproptopurchase=Helper.correctNull((String)hshValues.get("pre_proptopurchase"));
String strproposed=Helper.correctNull((String)hshValues.get("pre_proposed"));

String strapplnamedisplayed=Helper.correctNull((String)hshValues.get("pre_applnamedisplayed"));	
String straccdetailsverifyfrom=Helper.correctNull((String)hshValues.get("pre_accdetailsverifyfrom"));	
String strproptype=Helper.correctNull((String)hshValues.get("pre_proptype"));	
String strownernature=Helper.correctNull((String)hshValues.get("pre_ownernature"));	
String strSector=Helper.correctNull((String)request.getParameter("hidsector"));
String strSaral = Helper.correctNull((String) request.getParameter("hidsaral"));
%>
<html>
<head>
<title>Pre Sanction Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">


<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<!-- script language="JavaScript1.2" src="<%//=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script-->
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<script language="javascript">


var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
var varResidence="<%=Helper.correctNull((String)hshValues.get("pre_residence"))%>";
var loan_processdate="<%=Helper.correctNull((String)hshValues.get("loan_processdate"))%>";


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
	if(varResidence!="")
		{
		document.forms[0].sel_residence.value=varResidence;
		}
	else
		{
		document.forms[0].sel_residence.value="S";
		}
	}

function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdapply.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;	
	document.forms[0].cmdclose.disabled=bool4;		
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
		document.forms[0].action=appUrl+"action/presanctionvisit.jsp";	
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
	if(document.forms[0].txt_loanpurpose.value=="")
		{
		ShowAlert(112,"Purpose of loan");
		document.forms[0].txt_loanpurpose.focus();
		return;
		}
	if(document.forms[0].txt_visitofficercomment.value=="")
		{
		ShowAlert(112,"Comments of Visiting Officer");
		document.forms[0].txt_visitofficercomment.focus();
		return;
		}
	if(document.forms[0].txt_signplace.value=="")
		{
		ShowAlert(112,"Place of Visiting Officer");
		document.forms[0].txt_signplace.focus();
		return;
		}
	if(document.forms[0].txt_visitofficername.value=="")
		{
		ShowAlert(112,"Name of Visiting Officer");
		document.forms[0].txt_visitofficername.focus();
		return;
		}
	if(document.forms[0].txt_signdate.value=="")
		{
		ShowAlert(112,"Date of Visit");
		document.forms[0].txt_signdate.focus();
		return;
		}
	if(document.forms[0].txt_visitofficerdesign.value=="")
		{
		ShowAlert(112,"Designation of Visiting Officer");
		document.forms[0].txt_visitofficerdesign.focus();
		return;
		}
	document.forms[0].hidAction.value="update";
	document.forms[0].hidBeanGetMethod.value="getPDCCharges";
	document.forms[0].hidBeanId.value="Inspection";
	document.forms[0].action=appUrl+"action/presanctionvisit.jsp";	
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
	var purl = appUrl+"action/presanction_report.jsp?hidBeanGetMethod=getPDCCharges&hidBeanId=Inspection&appno="+appno;
	prop = "scrollbars=yes,width=700,height=450,statusbar=yes,menubar=yes";	
	xpos = (screen.width - 700) / 2;
	ypos = (screen.height - 650) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	var title = "Print1";	
	window.open(purl,title,prop);
}

function comparedate(date1,date2)
{	
	var pgdt=changeDateformat(date1);
	var maxdt=changeDateformat(date2);
		if(pgdt.value!="")
		{
			if(Date.parse(pgdt) > Date.parse(maxdt))
			{
				alert("Date of Inspection cannot be lesser than Application Process Date");
				document.forms[0].txt_signdate.value="";
				document.forms[0].txt_signdate.focus();								
			}			
		}
}

</script>
</head>
<body>
<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()"> 
  <div class="menuitems" url="">
   <script language="JavaScript1.2">

//if (document.all && window.print)
//{
	//ie5menu.className = menuskin;
	//document.oncontextmenu = showmenuie5;
	//document.body.onclick = hidemenuie5;
//}
</script>
</div>
  </div>
<form name="existpropos" method="post">

<table width="100%" border="0" cellspacing="0" cellpadding="3">
	<tr>
		<td>
		<table width="100%" border="0" align="center">
		<tr> 
	<td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg" /></td>
</tr>
<tr> 
    			<td align="center"><b>Branch - <%=Helper.correctNull((String)hshValues.get("orgname"))%></b></td>
			</tr>
<tr> 
  			<td align="center"><%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp; 
		<%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp; <%=Helper.correctNull((String)hshValues.get("orgcity"))%>,&nbsp; 
		<%=Helper.correctNull((String)hshValues.get("orgstate"))%>-&nbsp; <%=Helper.correctNull((String)hshValues.get("orgzip"))%>&nbsp; 
 			<hr/>
		</td>
</tr>
			<tr>
				<td colspan="3" align="center"><b>PRE-SANCTION
				VISIT REPORT</b>
				</td>
			</tr>
		</table>
		</td>
		
	</tr>
	<tr>
		</tr>
		<tr>
		</tr>
	<tr>
		<td><div id="top">
		<table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">
          <tr> 
            <td width="30%" ><b> NAME OF THE APPLICANT</b></td>
            <td width="30%" ><b>FATHER&#146;S 
              /HUSBAND&#146;S NAME</b></td>
            <td colspan="2" ><b>RESIDENTIAL ADDRESS</b></td>
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
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_name"))%> 
            </td>
            <td bordercolor="0" width="30%">
              <%=Helper.correctNull((String)fat_hus_name)%> </td>
            <td colspan="2" bordercolor="0"> <%=Helper.correctNull((String) hshValues
							.get("pre_address"))%>
              
            </td>
          </tr>
          <tr> 
            <td width="30%">DISTANCE FROM 
              BRANCH (KMS)</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_distance"))%> 
            </td>
            <td width="20%">DATE OF VISIT</td>
            <td width="20%"> 
              <table>
                <tr> 
                  <td> <%=Helper.correctNull((String)hshValues.get("pre_visitdate"))%>
                    
                  </td>
                  
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td bordercolor="0" width="30%">PURPOSE 
              OF LOAN </td>
            <td bordercolor="0" width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_loanpurpose"))%> 
            </td>
            <td bordercolor="0" width="20%">
              NAME OF THE NEAREST BRANCH OF OUR BANK </td>
            <td bordercolor="0" width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_nearestbranch"))%> 
            </td>
          </tr>
          
          
          <%
          String resi="";
          String residence=Helper.correctNull((String)hshValues.get("pre_residence"));
          if(residence.equalsIgnoreCase("1"))
          {
        	  resi="Owned";
          }
          if(residence.equalsIgnoreCase("2"))
          {
        	  resi="Rented";
          }
          if(residence.equalsIgnoreCase("3"))
          {
        	  resi="Leased";
          }
          if(residence.equalsIgnoreCase("4"))
          {
        	  resi="Others";
          }
          if(residence.equalsIgnoreCase("5"))
          {
        	  resi="Provided by Employer";
          }
          
          %>
          <tr> 
            <td bordercolor="0" width="30%">RESIDENCE 
              IS </td>
            <td bordercolor="0" width="30%"> <%=resi %> </td>
            <td bordercolor="0" width="20%">
              STAYING SINCE</td>
            <td bordercolor="0" width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_stayingsince"))%> 
            </td>
          </tr>
          <tr> 
            <td width="30%">&nbsp;</td>
            <td width="30%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="4"><b>NEARBY LANDMARK 
              FOR IDENTIFICATION : </b></td>
          </tr>
          <tr> 
            <td width="30%">EAST</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_homeaddreastlandmark"))%> 
            </td>
            <td width="20%">WEST</td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_homeaddrwestlandmark"))%> 
            </td>
          </tr>
          <tr> 
            <td width="30%">NORTH</td>
            <td width="30%"><%=Helper.correctNull((String)hshValues.get("pre_homeaddrnorthlandmark"))%> 
            </td>
            <td width="20%">SOUTH</td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_homeaddrsouthlandmark"))%> 
            </td>
          </tr>
          <tr> 
            <td colspan="4" bordercolor="0">PROOF 
              FOR VERIFICATION OF RESIDENTIAL ADDRESS --- Ration Card No., Voters 
              ID Card No., Passport No./PAN Card No.,Rent Agreement, Electricity/Telephone 
              6 months and -1-latest bill). Whether residing with parents/relatives</td>
          </tr>
          <tr> 
            <td bordercolor="0" width="30%">&nbsp;</td>
            <td bordercolor="0" width="30%">&nbsp;</td>
            <td bordercolor="0" width="20%">&nbsp;</td>
            <td bordercolor="0" width="20%">&nbsp;</td>
          </tr>
          <tr> 
            <td bordercolor="0" width="30%">
              NAME OF THE SUPPLIER</td>
            <td bordercolor="0" width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_supplier"))%> 
            </td>
            <td bordercolor="0" width="20%">PURCHASE 
              PRICE (incl Tax) </td>
            <td bordercolor="0" width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_purchaseprice"))%> 
            </td>
          </tr>
          <tr> 
            <td width="30%">&nbsp;</td>
            <td width="30%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
          </tr>
          <tr > 
            <td colspan="4" ><b>GENUINENESS OF QUOTATION VERIFIED 
              </b></td>
          </tr>
          <tr> 
            <td height="19" bordercolor="0" width="30%">OVER 
              PHONE NO.</td>
            <td height="19" bordercolor="0" width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_genuinessphone"))%> 
            </td>
            <td height="19" bordercolor="0" width="20%">NAME 
              OF THE PERSON CONTACTED</td>
            <td height="19" bordercolor="0" width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_genphcontperson"))%> 
            </td>
          </tr>
          <tr> 
            <td bordercolor="0" width="30%">BY 
              PERSONAL VISIT</td>
            <td bordercolor="0" width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_genuinesspersonal"))%> 
            </td>
            <td bordercolor="0" width="20%">NAME 
              OF THE PERSON CONTACTED</td>
            <td bordercolor="0" width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_genpercontperson"))%> 
            </td>
          </tr>
          <tr> 
            <td width="30%">&nbsp;</td>
            <td width="30%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="4" ><b>OCCUPATION OF APPLICANT (GIVE 
              DETAILS) :</b></td>
          </tr>
		   <%
          if((strSaral.equalsIgnoreCase("saral")) || stremployment.equalsIgnoreCase("1")){
          %>
          <tr> 
            <td colspan="2"  bordercolor="0"><b>SERVICE </b></td>
            <td colspan="2" bordercolor="0"><b>EMPLOYMENT 
              DETAILS </b></td>
          </tr>
          <tr> 
            <td bordercolor="0" width="30%">NAME 
              OF EMPLOYER</td>
            <td bordercolor="0" width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_employername"))%> 
            </td>
            <td bordercolor="0" width="20%">DETAILS 
              VERIFIED BY/THROUGH <br>
              PERSONAL VISIT TO OFFICE ON </td>
            <td bordercolor="0" width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_employerverify"))%> 
            </td>
          </tr>
          <tr> 
            <td bordercolor="0" width="30%">ADDRESS</td>
            <td bordercolor="0" width="30%"> <%=Helper.correctNull((String) hshValues.get("pre_employeraddress"))%> 
            </td>
            <td bordercolor="0" width="20%">NAME 
              OF PERSON CONTACTED </td>
            <td bordercolor="0" width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_emppersoncontact"))%> 
            </td>
          </tr>
          <tr> 
            <td bordercolor="0" width="30%">DESIGNATION	
              </td>
            <td bordercolor="0" width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_employeedesig"))%> 
            </td>
            <td bordercolor="0" width="20%">GROSS 
              ANNUAL/MONTHLY INCOME<br>
              IF ANY DEVIATION FOUND </td>
            <td bordercolor="0" width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_employeeincome"))%> 
            </td>
          </tr>
          <tr> 
            <td width="30%">WORKING SINCE</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_employeeworksince"))%> 
            </td>
            <td width="20%">EMPLOYEE NO.</td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_employeeno"))%> 
            </td>
          </tr>
          <tr> 
            <td width="30%">WHETHER CONFIRMED/PROBATION/OR 
              ON CONTRACT BASIS</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_employerconfirm"))%> 
            </td>
            <td width="20%">&nbsp; </td>
            <td width="20%">&nbsp;</td>
          </tr>
          <tr> 
            <td bordercolor="0" width="30%">Phone 
              No.</td>
            <td bordercolor="0" width="30%">
              OFFICE</td>
            <td bordercolor="0" width="20%">RESIDENCE</td>
            <td bordercolor="0" width="20%">MOBILE</td>
          </tr>
          <tr> 
            <td bordercolor="0" width="30%">&nbsp;</td>
            <td bordercolor="0" width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_employerofficephone"))%> 
            </td>
            <td bordercolor="0" width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_employerresiphone"))%> 
            </td>
            <td bordercolor="0" width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_employermobile"))%> 
            </td>
          </tr>
          <tr> 
            <td width="30%">&nbsp;</td>
            <td width="30%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
          </tr>
          <%} if((strSaral.equalsIgnoreCase("saral")) ||  stremployment.equalsIgnoreCase("2")){ %>
          <tr > 
            <td colspan="4" bordercolor="0" ><b>BUSINESS</b></td>
          </tr>
          <tr> 
            <td bordercolor="0" width="30%">NAME 
              OF THE FIRM</td>
            <td bordercolor="0" width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_businessfirmname"))%> 
            </td>
            <td bordercolor="0" width="20%">ADDRESS</td>
            <td bordercolor="0" width="20%"> <%=Helper.correctNull((String) hshValues.get("pre_businessfirmaddr"))%> 
            </td>
          </tr>
          <tr> 
            <td bordercolor="0" width="30%">REGISTRATION 
              NO.</td>
            <td bordercolor="0" width="30%"><%=Helper.correctNull((String)hshValues.get("pre_businessfirmregno"))%> 
            </td>
            <td bordercolor="0" width="20%">LICENCE 
              NO.</td>
            <td bordercolor="0" width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_busifirmlicenceno"))%> 
            </td>
          </tr>
          <tr > 
            <td colspan="4"><b>NEARBY LANDMARK 
              FOR IDENTIFICATION : </b></td>
          </tr>
          <tr> 
            <td width="30%">EAST</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_busifirmeastlandmark"))%> 
            </td>
            <td width="20%">WEST</td>
            <td width="20%"><%=Helper.correctNull((String)hshValues.get("pre_busifirmwestlandmark"))%> 
            </td>
          </tr>
          <tr> 
            <td width="30%">NORTH</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_busifirmnorthlandmark"))%> 
            </td>
            <td width="20%">SOUTH</td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_busifirmsouthlandmark"))%> 
            </td>
          </tr>
          <tr> 
            <td bordercolor="0" colspan="4">&nbsp;</td>
          </tr>
          <tr> 
            <td bordercolor="0" width="30%">APPLICANTS 
              POSITION IN THE FIRM</td>
            <td bordercolor="0" width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_busifirmposition"))%> 
            </td>
            <td bordercolor="0" width="20%">YEAR 
              OF ESTABLISHMENT</td>
            <td bordercolor="0" width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_busifirmestabyr"))%> 
            </td>
          </tr>
          <tr> 
            <td bordercolor="0" width="30%">NATURE 
              OF BUSINESS</td>
              
              
            <td bordercolor="0" width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_busifirmnature"))%> 
            </td>
            <%
            String app_name_disp="";
            if(strapplnamedisplayed.equalsIgnoreCase("Y"))
            {
            	app_name_disp="Yes";
            }
            if(strapplnamedisplayed.equalsIgnoreCase("N"))
            {
            	app_name_disp="No";
            }
            %>
            <td bordercolor="0" width="20%">APPLICANTS 
              NAME BOARD DISPLAYED</td>
            <td bordercolor="0" width="20%"> <%=app_name_disp %> </td>
          </tr>
          
          <tr> 
            <td colspan="4"><b>SELF-EMPLOYED &amp; PROFESSIONAL 
              </b></td>
          </tr>
          <tr> 
            <td bordercolor="0" width="30%">OCCUPATION</td>
            <td bordercolor="0" width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_selfoccupation"))%> 
            </td>
            <td bordercolor="0" width="20%">BUSINESS 
              ADDRESS</td>
            <td bordercolor="0" width="20%"> <%=Helper.correctNull((String) hshValues.get("pre_selfempaddress"))%> 
            </td>
          </tr>
          <tr> 
            <td bordercolor="0" width="30%">REGISTRATION 
              NO.</td>
            <td bordercolor="0" width="30%"><%=Helper.correctNull((String)hshValues.get("pre_selfempregno"))%> 
            </td>
            <td bordercolor="0" width="20%">LICENCE 
              NO.</td>
            <td bordercolor="0" width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_selfemplicenceno"))%> 
            </td>
          </tr>
          <tr> 
            <td colspan="4"><b>NEARBY LANDMARK 
              FOR IDENTIFICATION : </b></td>
          </tr>
          <tr> 
            <td width="30%">EAST</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_selfempeastlandmark"))%> 
            </td>
            <td width="20%">WEST</td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_selfempwestlandmark"))%> 
            </td>
          </tr>
          <tr> 
            <td width="30%">NORTH</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_selfempnorthlandmark"))%> 
            </td>
            <td width="20%">SOUTH</td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_selfempsouthlandmark"))%> 
            </td>
          </tr>
          <tr> 
            <td bordercolor="0" width="30%">Phone 
              No.</td>
            <td bordercolor="0" width="30%">OFFICE</td>
            <td bordercolor="0" width="20%">RESIDENCE</td>
            <td bordercolor="0" width="20%">MOBILE</td>
          </tr>
          <tr> 
            <td bordercolor="0" width="30%">&nbsp;</td>
            <td bordercolor="0" width="30%"><%=Helper.correctNull((String)hshValues.get("pre_selfempofficephone"))%> 
            </td>
            <td bordercolor="0" width="20%"><%=Helper.correctNull((String)hshValues.get("pre_selfempresiphone"))%> 
            </td>
            <td bordercolor="0" width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_selfempmobile"))%> 
            </td>
          </tr>
          <tr> 
            <td width="30%">&nbsp;</td>
            <td width="30%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
          </tr>
          <%}if(strSaral.equalsIgnoreCase("saral") || stremployment.equalsIgnoreCase("3") || stremployment.equalsIgnoreCase("2") || stremployment.equalsIgnoreCase("1") ){ %>
          <tr> 
            <td colspan="4" bordercolor="0"><b>DETAILS 
              VERIFIED FROM: </b> </td>
          </tr>
          <tr> 
            <td bordercolor="0" width="30%">a. 
              FORM NO.16 (FOR THE FINANCIAL YEAR ENDED MARCH 200...) </td>
            <td bordercolor="0" width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_form16"))%> 
            </td>
            <td bordercolor="0" width="20%">b. 
              LAST SALARY SLIP (FOR THE MONTH OF </td>
            <td bordercolor="0" width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_salslip"))%> 
            </td>
          </tr>
          <tr> 
            <td bordercolor="0" width="30%" >c. 
              INCOME TAX RETURN FOR A.Y. (ALONG WITH ORIGINAL COPY OF TAX CHALLAN 
              PERIOD</td>
            <td bordercolor="0" width="30%"><%=Helper.correctNull((String)hshValues.get("pre_taxreturn"))%> 
            </td>
            <td bordercolor="0" width="20%">&nbsp;</td>
            <td bordercolor="0" width="20%">&nbsp;</td>
          </tr>
          <%} %>
          <tr> 
            <td width="30%">&nbsp;</td>
            <td width="30%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="30%"><b>PRESENT BANKERS</b></td>
            <td width="30%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="30%">NAME OF THE BANK</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_presentbank"))%> 
            </td>
            <td width="20%">BRANCH</td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_presentbankbranch"))%> 
            </td>
          </tr>
          <tr> 
            <td width="30%">TYPE OF A/C.</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_presentbankactype"))%> 
            </td>
            <td width="20%">A/C NO.</td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_presentbankaccno"))%> 
            </td>
          </tr>
          <%
          String accdet="";
          if(straccdetailsverifyfrom.equalsIgnoreCase("1"))
          {
        	  accdet="Bank Statement";
          }
          if(straccdetailsverifyfrom.equalsIgnoreCase("2"))
          {
        	  accdet="Pass Book";
          }
          
          
          %>
          
          
          
          
          <tr> 
            <td width="30%">DETAILS OF A/C 
              VERIFIED FROM</td>
            <td width="30%"><%=accdet %> </td>
            <td width="20%">&nbsp;</td>
            <td width="20%">&nbsp; </td>
          </tr>
          <tr> 
            <td width="30%">&nbsp;</td>
            <td width="30%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="30%"><b>LOAN OUTSTANDING 
              </b></td>
            <td width="30%"><b>WITH OUR BANK 
              </b></td>
            <td width="20%"><b>WITH OTHER 
              BANK</b></td>
            <td width="20%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="30%">NAME OF THE BRANCH</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_ourbankname"))%> 
            </td>
            <td width="20%"><%=Helper.correctNull((String)hshValues.get("pre_otherbankname"))%> 
              </td>
            <td width="20%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="30%">TYPE OF LOAN</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_ourbankloantype"))%> 
            </td>
            <td width="20%"><%=Helper.correctNull((String)hshValues.get("pre_otherbankloantype"))%> 
              </td>
            <td width="20%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="30%">AMOUNT SANCTIONED</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_ourbanksancamt"))%> 
            </td>
            <td width="20%"><%=Helper.correctNull((String)hshValues.get("pre_otherbanksancamt"))%> 
              </td>
            <td width="20%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="30%">BALANCE OUTSTANDING</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_ourbankosamt"))%> 
            </td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_otherbankosamt"))%> 
            </td>
            <td width="20%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="30%">OVERDUE AMOUNT, 
              IF ANY </td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_ourbankoverdueamt"))%> 
            </td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_otherbankoverdueamt"))%> 
            </td>
            <td width="20%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="30%">&nbsp;</td>
            <td width="30%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
          </tr>
          <%if((strSaral.equalsIgnoreCase("saral")) || stremployment.equalsIgnoreCase("9")){ %>
          <tr> 
            <td width="30%"><b>Pension </b></td>
            <td width="30%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="30%">PENSION ACCOUNT 
              NO.</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_pensionaccno"))%> 
            </td>
            <td width="20%">NAME OF THE BRANCH</td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_pensionaccbranch"))%> 
            </td>
          </tr>
          <tr> 
            <td width="30%">MONTHLY PENSION 
              AMOUNT</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_pensionamt"))%> 
            </td>
            <td width="20%">PPO NO.</td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_pensionpayorderno"))%> 
            </td>
          </tr>
          <tr> 
            <td width="30%">NAME OF NOMINEE 
              FOR PENSION</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_pensionnominee"))%> 
            </td>
            <td width="20%">&nbsp;</td>
            <td width="20%">&nbsp; </td>
          </tr>
          <tr> 
            <td width="30%">&nbsp;</td>
            <td width="30%">&nbsp; </td>
            <td width="20%">&nbsp;</td>
            <td width="20%">&nbsp; </td>
          </tr>
          <%} %>
          <tr> 
            <td colspan="4"><b>INSPECTION 
              DETAILS</b></td>
          </tr>
          <tr> 
            <td width="30%">TITLE DEED</td>
            <td colspan="3"> <%=Helper.correctNull((String)hshValues.get("pre_titledeed"))%>
              
            </td>
          </tr>
          <tr> 
            <td width="30%">DEED NO.</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_titledeedno"))%> 
            </td>
            <td width="20%">NAME OF SUB-REGISTRAR 
              OFFICE</td>
            <td width="20%"><%=Helper.correctNull((String)hshValues.get("pre_subregoffice"))%> 
            </td>
          </tr>
          <tr> 
            <td width="30%">NAME OF OWNER/S 
              OF THE PROPERTY</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_propownername"))%> 
            </td>
            <%
            String prop_type="";
            if(strproptype.equalsIgnoreCase("1"))
            {
            	prop_type="Residential";
            }
            if(strproptype.equalsIgnoreCase("2"))
            {
            	prop_type="Commerical";
            }
            
            	 %>
            
            <td width="20%">PROPERTY TYPE</td>
            <td width="20%"> <%=prop_type %> </td>
            
            
            <%
            
            String owner="";
            if(strownernature.equalsIgnoreCase("1"))
            {
            	owner="FREE HOLD";
            }
            if(strownernature.equalsIgnoreCase("2"))
            {
            	owner="LEASE HOLD";
            }
            if(strownernature.equalsIgnoreCase("3"))
            {
            	owner="LICENCE";
            }
            if(strownernature.equalsIgnoreCase("4"))
            {
            	owner="UNDIVIDED INTEREST ( GIVE DETAILS OF SHARE)";
            }
            if(strownernature.equalsIgnoreCase("5"))
            {
            	owner="TRUST PROPERTY";
            }
            if(strownernature.equalsIgnoreCase("6"))
            {
            	owner="ASSIGNEE";
            }
            if(strownernature.equalsIgnoreCase("7"))
            {
            	owner="TITLE ONLY BY POSSESSION";
            }
            if(strownernature.equalsIgnoreCase("8"))
            {
            	owner="AS A MEMBER / SHARE HOLDER OF SOCIETY";
            }
            
            %>
          <tr> 
            <td width="30%">NATURE OF OWNERSHIP</td>
            <td width="30%"> <%=owner %> </td>
            <td width="20%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="30%">&nbsp;</td>
            <td width="30%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
          </tr>
		   <%
          if((strSaral.equalsIgnoreCase("saral")) || prd_type.equalsIgnoreCase("pH")){
          %>
          <tr> 
            <td colspan="4"><b>DETAILS OF 
              PROPERTY </b></td>
          </tr>
        <%  
          
          
          String StrPurchase="";
          if(strproptopurchase.equalsIgnoreCase("Y"))
          {
        	  StrPurchase="Yes";
          }
          if(strproptopurchase.equalsIgnoreCase("N"))
          {
        	  StrPurchase="No";
          }  
        	  
        	  %> 
          <tr> 
            <td width="30%">TO BE PURCHASED 
              - PLOT, HOUSE, FLAT</td>
            <td width="30%"> <%=StrPurchase %> </td>
            <% String proposed="";
            if(strproposed.equalsIgnoreCase("Y"))
            {
            	proposed="Yes";
            }
            if(strproposed.equalsIgnoreCase("N"))
            {
            	proposed="No";
            }
            %>
            
            <td width="20%">PROPOSED</td>
            <td width="20%"> <%=proposed %> </td>
          </tr>
          <tr> 
            <td width="30%">ADDRESS</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_propaddress"))%> 
            </td>
            <% 
            String desc="";
            if(strpropdesc.trim().equalsIgnoreCase("R"))
            {
            	desc="RESIDENTIAL";
            }
            if(strpropdesc.trim().equalsIgnoreCase("C"))
            {
            	desc="COMMERCIAL";
            }
            if(strpropdesc.trim().equalsIgnoreCase("M"))
            {
            	desc="MIXED";
            }
            
            %>
            
            <td width="20%">DESCRIPTION OF 
              PROPERTY</td>
            <td width="20%"> <%=desc %> </td>
          </tr>
          <tr> 
            <td width="30%">PLOT NO.</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_propplotno"))%> 
            </td>
            <td width="20%">SURVEY NO.</td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_propsurveyno"))%> 
            </td>
          </tr>
          <tr> 
            <td width="30%">STREET NO.</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_propstreetno"))%> 
            </td>
            <td width="20%">WARD NO.</td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_propwardno"))%> 
            </td>
          </tr>
          <tr> 
            <td colspan="4"><b>NEARBY LANDMARK 
              FOR IDENTIFICATION : </b></td>
          </tr>
          <tr> 
            <td width="30%">EAST</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_propeastlandmark"))%> 
            </td>
            <td width="20%">WEST</td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_propwestlandmark"))%> 
            </td>
          </tr>
          <tr> 
            <td width="30%">NORTH</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_propnorthlandmark"))%> 
            </td>
            <td width="20%">SOUTH</td>
            <td width="20%"><%=Helper.correctNull((String)hshValues.get("pre_propsouthlandmark"))%> 
            </td>
          </tr>
        
          <tr> 
            <td width="30%">NO. OF FLOORS 
            </td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_propnooffloors"))%> 
            </td>
            <td width="20%">PROPOSED FLAT 
              ON FLOOR NO.</td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_propfloorno"))%> 
            </td>
          </tr>
          <tr> 
            <td width="30%">AGE OF BUILDING</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_propage"))%> 
            </td>
            <td width="20%">BALANCE LIFE OF 
              BUILDING </td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_propagebalance"))%> 
            </td>
          </tr>
          <tr> 
            <td width="30%">ANY PRIOR CHARGES</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_proppriorcharges"))%> 
            </td>
            <% 
            String valuation="";
            if(strpropvalreportobtained.trim().equalsIgnoreCase("Y"))
            {
            	valuation="Yes";
            }if(strpropvalreportobtained.trim().equalsIgnoreCase("N"))
            {
            	valuation="No";
            }
            
            %>
            
            <td width="20%">VALUATION REPORT 
              FROM ARCHITECT/ENGINEER OBTAINED</td>
            <td width="20%"><%=valuation%> </td>
          </tr>
          <tr> 
            <td width="30%">SALE AMOUNT</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_propsaleamt"))%> 
            </td>
            <td width="20%">FACILITIES AVAILABLE</td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_propfacilityavailable"))%> 
            </td>
          </tr>
          <tr> 
            <td width="30%">VALUE AS PER VALUATION 
              REPORT, VALUE INDICATED IN THE SALE DEED MAY ALSO BE TAKEN INTO 
              ACCOUNT IN CASE OF WIDE VARIATION, COMMENTS REQUIRED</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_propvalreport"))%> 
            </td>
            <td width="20%">NAME OF THE PERSON 
              REPRESENTING SELLER/BUILDER</td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_proprepresentative"))%> 
            </td>
          </tr>
          <tr> 
            <td width="30%">AREA IN SQ.FT.AS 
              PER SALE AGREEMENT</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_proparea"))%> 
            </td>
            <td width="20%">WHETHER OWNER 
              OCCUPIED/ RENTED/LEASED</td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_propowner"))%> 
            </td>
          </tr>
          <tr> 
            <td width="30%">COMMENTS ON TAXES 
              PAID</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_proptaxpaidcomments"))%> 
            </td>
            <td width="20%">MAINTENANCE OF 
              BUILDING</td>
            <td width="20%"><%=Helper.correctNull((String)hshValues.get("pre_propmaintanance"))%> 
            </td>
          </tr>
          <tr> 
            <td colspan="2">VALUATION OF PROPERTY 
              AS PER INSPECTING OFFICIAL</td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_propvalasperinsofficial"))%> 
            </td>
            <td width="20%">&nbsp;</td>
          </tr>
          <tr>
            <td colspan="4">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="4"><b>CONSTRUCTION 
              / REPAIRS / IMPROVEMENT / EXTENTION OF HOUSE / FLAT</b></td>
          </tr>
          <% 
          String permission="";
          if(strpermissionobtained.equalsIgnoreCase("Y"))
          {
        	  permission="Yes";
          }
          if(strpermissionobtained.equalsIgnoreCase("n"))
          {
        	  permission="No";
          }
          
          
          %>
          <tr> 
            <td width="30%">PERMISSION FOR 
              CONSTRUCTION /REPAIR OBTAINED?</td>
            <td width="30%"> <%=permission %> </td>
            <td width="20%">HOUSE/FLAT IS 
              COMPLETED?</td>
            <% String compl="";
          if(strpropcompleted.trim().equalsIgnoreCase("Y"))
          {
        	  compl="Yes";
          }
          if(strpropcompleted.trim().equalsIgnoreCase("N"))
          {
        	  compl="No";
          } 
            %>
            <td width="20%"> <%=compl %> </td>
          </tr>
          <tr> 
            <td width="30%">PRESENT STATUS 
              OF CONSTRUCTION</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_propconstructstatus"))%> 
            </td>
            <td width="20%">COMMENTS ON ADVERSE 
              FEATURES</td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_propfeatures"))%> 
            </td>
          </tr>
          <tr> 
            <td width="30%">&nbsp;</td>
            <td width="30%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
          </tr>
          <%
          }if((strSaral.equalsIgnoreCase("saral")) || prd_type.equalsIgnoreCase("pA")){
          %>
          <tr> 
            <td width="30%"><b>OLD VEHICLES</b></td>
            <td width="30%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="30%">TYPE OF VEHICLE</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_vechicletype"))%> 
            </td>
            <td width="20%">AGE OF VEHICLE</td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_vehicleage"))%> 
            </td>
          </tr>
          <tr> 
            <td width="30%">VALUE OF THE VEHICLE</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_vehiclevalue"))%> 
            </td>
            <td width="20%">VALUED BY &amp; 
              DATE </td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_valueby"))%> 
            </td>
          </tr>
          <tr> 
            <td width="30%">ANY PRIOR CHARGES</td>
            <td width="30%"> <%=Helper.correctNull((String) hshValues
							.get("pre_vehiclepriorcharges"))%> </td>
            <td width="20%">REGISTRATION NO.</td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_vehicleregno"))%> 
            </td>
          <tr> 
            <td width="30%">CHASSIS NO.</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_vehiclechasisno"))%> 
            </td>
            <td width="20%">ENGINE NO.</td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_vehicleengineno"))%> 
            </td>
          </tr>
          <% 
		  String keys ="";
		  if(strvehicleduplikeyobtain.equalsIgnoreCase("1"))
		  {
		  	keys="Yes";
		  }
		  if(strvehicleduplikeyobtain.equalsIgnoreCase("2"))
		  {
		  	keys="No";
		  }
		  %>
          <tr> 
            <td width="30%">DUPLICATE KEYS 
              OBTAINED BY THE BANK</td>
            <td width="30%"> <%=keys%> </td>
            <td width="20%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="30%"></td>
            <td width="30%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
          </tr>
          <%
          }
          %>
          <tr> 
            <td width="30%"><b>COMMENTS OF 
              VISITING OFFICER</b></td>
            <td width="30%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="2">GENERAL REMARKS 
              / OBSERVATIONS / COMMENTS OF VISTING OFFICER </td>
            <td colspan="2"> <%=Helper.correctNull((String) hshValues
									.get("pre_visitofficercomment"))%>
              
            </td>
          </tr>
          <tr> 
            <td width="30%">Place</td>
            <td width="30%"> <%=Helper.correctNull((String)hshValues.get("pre_signplace"))%> 
            </td>
            <td width="20%">Name </td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_visitofficername"))%> 
            </td>
          </tr>
          <tr> 
            <td width="30%">Date </td>
            <td width="30%"> 
              <table>
                <tr> 
                  <td> <%=Helper.correctNull((String)hshValues.get("pre_signdate"))%>
                    
                  </td>
                  <td></td>
                </tr>
              </table>
            </td>
            <td width="20%">Designation with 
              PA No </td>
            <td width="20%"> <%=Helper.correctNull((String)hshValues.get("pre_visitofficerdesign"))%> 
            </td>
          </tr>
        </table>
        </div>
		</td>
	</tr>
</table>
<br>

<lapschoice:hiddentag/>
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)session.getAttribute("hidDemoId"))%>">
 
<%-- 
<input type="hidden" name="hid_pagename" value="" />
--%>
</form>
</body>
</html>
