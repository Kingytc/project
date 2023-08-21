<%@include file="../share/directives.jsp"%>
<%
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
%>
<html>
<head>
<title>Agriculture Land Holdings</title>
<STYLE>
DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
</STYLE>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varaction="<%=Helper.correctNull((String)hshValues.get("hidAction"))%>";
var id ="";
var apptype="";
var varApptype=new Array();
var area4="";

function mortgage()
{
   if(document.forms[0].security.value == "0")
	{
		document.all.m1.style.visibility="hidden";
		document.all.m2.style.visibility="hidden";
		document.all.m3.style.visibility="hidden";
		document.all.m4.style.visibility="hidden";
		document.all.m1.style.position="absolute";
		document.all.m2.style.position="absolute";
		document.all.m3.style.position="absolute";
		document.all.m4.style.position="absolute";
	}
   if(document.forms[0].security.value == "1")
	{
		document.all.m1.style.visibility="visible";
		document.all.m2.style.visibility="visible";
		document.all.m3.style.visibility="visible";
		document.all.m4.style.visibility="visible";
		document.all.m1.style.position="relative";
		document.all.m2.style.position="relative";
		document.all.m3.style.position="relative";
		document.all.m4.style.position="relative";	
	}
	if(document.forms[0].security.value == "2")
	{
		document.all.m1.style.visibility="hidden";
		document.all.m2.style.visibility="hidden";
		document.all.m3.style.visibility="hidden";
		document.all.m4.style.visibility="hidden";
		document.all.m1.style.position="absolute";
		document.all.m2.style.position="absolute";
		document.all.m3.style.position="absolute";
		document.all.m4.style.position="absolute";	
	}
	if(document.forms[0].security.value == "3")
	{
		document.all.m1.style.visibility="hidden";
		document.all.m2.style.visibility="hidden";
		document.all.m3.style.visibility="hidden";
		document.all.m4.style.visibility="hidden";
		document.all.m1.style.position="absolute";
		document.all.m2.style.position="absolute";
		document.all.m3.style.position="absolute";
		document.all.m4.style.position="absolute";		
	}
}
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

function enableButtons(bool1, bool2, bool3, bool4, bool5,bool6)
{
	document.forms[0].cmdclose.disabled = false;
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/"+"retailpge.jsp";				
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
	document.forms[0].chobank_apptype.disabled=false;
}

function selectValues(val1, val2, val3,val5, val6, val7, val8, val9, val10, val11, val12, val13, val14, val15, val16, val20,val21,val23,val24,val25,val28,val30,val31,val32,val33,val34,val29,totacr)
{
	document.forms[0].selsno.value = val3;
	document.forms[0].txt_acreage.value = val5;
	document.forms[0].village.value = val6;
	document.forms[0].txt_taluk.value = val7;
	document.forms[0].txt_district.value = val8;
	document.forms[0].survey.value = val9;
	document.forms[0].txt_landrevenue.value = val10;
	document.forms[0].txt_value.value = val11;
	document.forms[0].sellease.value =val12;
	checkLease();
	document.forms[0].leaseperiod.value =val13;
	document.forms[0].txt_amtrent.value = val14;
	document.forms[0].farmdistance.value = val20;
	document.forms[0].housedistance.value = val21;
	document.forms[0].txt_acreage1.value = val23;
	document.forms[0].txt_Irrigated.value=val30;
	document.forms[0].txt_nonIrrigated.value=val31;
	document.forms[0].txt_nonCultivable.value=val32;
	document.forms[0].txt_Cultivable.value=val33;
	if(totacr=="Y")
	{	
	 document.forms[0].sel_FarmerCategory.value=val34;
	}
	else
	{
		setFarmerCategory();
	}
	document.forms[0].source.value = document.getElementById("hidsource"+val29).value;
	document.forms[0].encumbrance.value = document.getElementById("hidencumbrance"+val29).value;
	document.forms[0].txr_encroached.value = document.getElementById("hidencroached"+val29).value;
	document.forms[0].txr_fruit.value = document.getElementById("hidtreesfruit"+val29).value;
	document.forms[0].txr_nonfruit.value = document.getElementById("hidtreesnonfruit"+val29).value;
	document.forms[0].txr_address.value = document.getElementById("hidaddress"+val29).value;
	
	roundtxt(document.forms[0].txt_landrevenue);
	roundtxt(document.forms[0].txt_value);
	
	if(document.forms[0].btnenable.value=="Y")
	{			
		disableCommandButtons("radioselect");   
	} 
}
function getgrossdata()
{
	if(document.forms[0].hideditflag.value=="N")
	{
    	document.forms[0].hidAction.value="get";
    	document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidSourceUrl.value="/action/agrlandholdings.jsp";
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].hidBeanGetMethod.value="getData";
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
	if(trim(document.forms[0].survey.value)=="")
	{
		alert('Enter Survey No.');
		document.forms[0].survey.focus();
		return;
	}
	if(document.forms[0].txt_acreage.value == "")
    {
	    alert('Enter the acreage value in acres');
	    document.forms[0].txt_acreage.focus();
	    return;
    }
    if(document.forms[0].txt_acreage1.value == "")
    {
	    document.forms[0].txt_acreage1.value = "0";
		return;
    }
    if(document.forms[0].sellease.value == "0")
    {
	    alert('Enter Whether the land is owned/leased');
	    document.forms[0].sellease.focus();
	    return;
    }
    document.forms[0].hidchobank_apptype.value = document.forms[0].chobank_apptype.options[document.forms[0].chobank_apptype.selectedIndex].text;
	document.forms[0].hidBeanId.value="agrlandholdings";
	document.forms[0].hidSourceUrl.value="/action/agrlandholdings.jsp";
	document.forms[0].hidBeanMethod.value="updateData";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdclose.disabled=false;
	}
	if(val=="approved")
	{  
		disableFields(true);
		document.forms[0].cmdclose.disabled=false;
	}	 
	if(val=="edit")
	{		  
		disableFields(true);
		document.forms[0].cmdclose.disabled=false;	 
		disableFields(false);
	}
	if(val=="radioselect")
	{	  
		disableFields(true);
		document.forms[0].cmdclose.disabled=false;	 
	}	  
}  

function doEdit()
{
 	disableFields(false);
 	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
	document.forms[0].village.focus();
}

function doNew()
{
	disableFields(false);
	disableCommandButtons("edit");
	document.forms[0].hideditflag.value="Y";
	document.forms[0].source.readonly =false;
	document.forms[0].hidAction.value ="insert";
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].checked=false;
		}	  
	}
	document.forms[0].village.focus();
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appURL+"action/agrlandholdings.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidSourceUrl.value="action/agrlandholdings.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();		
	}
}
	
function onloading()
{	
	if(varaction=="get")
	{
		document.forms[0].chobank_apptype.value="<%=chobankapptype%>";	  
	}
	else
	{
		document.forms[0].chobank_apptype.value="s";
	}
	disableFields(true);
	checkLease();
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value="<%=schemetype%>";
	setFarmerCategory();
}

function checkLease()
{
	if(document.forms[0].sellease.value == "2")
	{
		document.all.r1.style.visibility="visible";		
		document.all.r1.style.position="relative";	
	}
	else
	{
		document.all.r1.style.visibility="hidden";	
		document.all.r1.style.position="absolute";
		document.forms[0].leaseperiod.value="";
	}
}

function getChange()
{
	id =document.forms[0].chobank_apptype.value
}

function callCalender(name)
{
if(document.forms[0].cmdedit.disabled==true)
	{
		showCal(appURL,name);
	}
}

function setFarmerCategory()
{
	document.all.ifrm1.src = appURL+ "action/iframefarmcat.jsp?hidBeanGetMethod=getAppFarmersCategory&hidBeanId=mis&strTotLandVal="+document.forms[0].txt_TotLandHold.value;
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading();">
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="999" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
      <td class="page_flow">Home -> Agriculture -> Application -> General Details</td>
	</tr>
</table>
<span style="display:none;"> <lapschoice:borrowertype /> </span> <lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="50" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
                        <td> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
					<tr> 
                        <td width="18%">Applicant 
                          Type &amp; Name <b class="mantatory">*</b></td>
                        <td width="16%"> 
                          <select name="chobank_apptype" style="width:120px" onChange="getgrossdata()">
                            <option value="" selected>--Select--</option>
                            	<%String appidval = request.getParameter("appno");
									String strcompanyname = request.getParameter("appname");%>
                            <option value="0"><%=strcompanyname%></option>
                            <lapschoice:compromoter />
                          </select>
                          </td>
                        <td width="15%">&nbsp;</td>
                        <td width="17%">&nbsp;</td>
                        <td width="16%">&nbsp;</td>
                        <td width="18%">&nbsp; </td>
                      </tr>
                      <tr> 
                        <td nowrap width="18%">Village</td>
                        <td nowrap width="16%"> 
                          <input type="text" name="village" size="20" onKeyPress="notAllowSplChar()" maxlength="50">
                        </td>
                        <td nowrap width="15%">Taluk</td>
                        <td nowrap width="17%"> 
                          <input type="text" name="txt_taluk" size="20" onKeyPress="notAllowSplChar()" maxlength="50">
                        </td>
                        <td nowrap width="16%">District</td>
                        <td nowrap width="18%"><input type="text" onKeyPress="notAllowSplChar()" name="txt_district" value="" maxlength="50" size="20">
                        </td>
                      </tr>
                      <tr> 
                        <td width="18%">Land Holding<b class="mantatory">*</b></td>
                        <td width="16%"> 
                          <input type="text" name="txt_acreage" value="" size="15" maxlength="3" onKeyPress="allowNumber()" style="text-align:right">
                          Acre&nbsp;&nbsp; 
                          <input type="hidden" name="txt_acreage1" value="" size="5" maxlength="2" onKeyPress="allowInteger()" style="text-align:right" onBlur="chkcentgunt()">
                        </td>
                        <td nowrap width="15%">Land 
                          revenue (Rs)</td>
                        <td width="17%"><lapschoice:CurrencyTag name="txt_landrevenue" size="20"	style="text-align:right" maxlength="10" /></td>
                        <td nowrap width="16%">Value 
                          (Rs in Lakh)</td>
                        <td width="18%"><lapschoice:CurrencyTag name="txt_value" size="20" maxlength="10" /></td>
                      </tr>
                       <tr>
                      <td width="18%">Irrigated</td>
                      <td width="16%"><input type="text" name="txt_Irrigated" size="20" maxlength="7" onKeyPress="allowDecimal(this,'4')" style="text-align:right" onBlur="roundtxt(this);" value="" tabindex="7"></td>
						<td width="15%">Non-Irrigated</td>
                      <td width="17%"><input type="text" name="txt_nonIrrigated" size="20" maxlength="7" onKeyPress="allowDecimal(this,'4')" style="text-align:right"  value="" onBlur="roundtxt(this);" tabindex="8"></td>
					<td nowrap width="16%">Farm distance from our branch</td>
                    <td width="18%"><input type="text" name="farmdistance" size="20" maxlength="5" onKeyPress="allowNumber(this)" tabindex="9">Kms</td>																
					</tr>
                      <tr>
                      <td width="18%">Cultivatable</td>
                      <td width="16%"><input type="text" name="txt_Cultivable" size="20" maxlength="7" onKeyPress="allowDecimal(this,'4')"
						style="text-align:right"  value="" onBlur="roundtxt(this);" tabindex="10"></td>
					 <td width="15%">Non-Cultivatable</td>
                      <td width="17%"><input type="text" name="txt_nonCultivable" size="20" maxlength="7" onKeyPress="allowDecimal(this,'4')"
						style="text-align:right"  value="" onBlur="roundtxt(this);" tabindex="11"></td>
						 <td width="16%">House distance from our branch</td>
                        <td width="18%"><input type="text" name="housedistance" maxlength="5" size="20" onKeyPress="allowNumber(this)" tabindex="12">Kms</td>
                      </tr>
                      <tr> 
                       <td nowrap width="18">Survey&nbsp;No<b class="mantatory">*</b></td>
                        <td nowrap width="16%"> 
                          <input type="text" name="survey" value="" maxlength="20" size="20">
                        </td>
                        <td width="15%">Whether 
                          Owned/Leased<b class="mantatory">*</b> 
                          </td>
                        <td width="17%"> 
                          <select name="sellease" onChange="checkLease()" style="width: 120px;">
                            <option value="1">Owned</option>
                            <option value="2">Leased</option>
                            <option value="3">Share cropper</option>
                            <option value="4">others</option>
                          </select>
                        </td>
                        <td width="16%">&nbsp;</td>
                        <td width="18%">&nbsp; </td>
                      </tr>
                      <tr id="r1"> 
                        <td nowrap width="18%">Unexpired Lease / Rent period</td>
                        <td width="16%"> 
                          <input type="text" name="leaseperiod" value="" size="20" maxlength="100" style="text-align:left">
                        </td>
                        <td width="15%">Annual rent payable (Rs)
                          </td>
                        <td width="17%"> 
                          <input type="text" name="txt_amtrent" size="20" onKeyPress="allowNumber(document.forms[0].txt_amtrent)" maxlength="10" style="text-align:right">
                        </td>
                        <td width="16%">Name and Address of landLord with lease deed details</td>
                        <td width="18%"> 
                          <textarea name="txr_address" cols="20" style="text-align:left" rap="VIRTUAL" rows="2" onKeyPress="textlimit(txr_address,3999)" onKeyUp="textlimit(this,3999)"></textarea>
                        </td>
                      </tr>
                    </table>
                          
                    <table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
                      <tr> 
                        <td width="18%">Source of Irrigation</td>
                        <td > 
                          <textarea name="source" onBlur="" cols="50" style="text-align:left" wrap="VIRTUAL" rows="4" onKeyPress="textlimit(source,3999);notAllowSingleAndDoubleQuote()" onKeyUp="textlimit(this,3999)"></textarea>
                        </td>
                        <!-- <td>&nbsp;</td>
                        <td>&nbsp;</td> -->
                      </tr>
                      <tr> 
                        <td>Encumbrance</td>
                        <td > 
                          <textarea name="encumbrance" cols="50" style="text-align:left" wrap="VIRTUAL" rows="4" onKeyPress="textlimit(encumbrance,3999);notAllowSingleAndDoubleQuote()" onKeyUp="textlimit(this,3999)"></textarea>
                        </td>
                        <td>Encroached Land particulars 
                          if any</td>
                        <td  > 
                          <textarea name="txr_encroached" onBlur="" cols="50" style="text-align:left" wrap="VIRTUAL" rows="4" onKeyPress="textlimit(txr_encroached,3999);notAllowSingleAndDoubleQuote()" onKeyUp="textlimit(this,3999)"></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td>Details of Trees-Fruit</td>
                        <td> 
                          <textarea name="txr_fruit" cols="50" style="text-align:left" wrap="VIRTUAL" rows="4" onKeyPress="textlimit(txr_fruit,3999);notAllowSingleAndDoubleQuote()" onKeyUp="textlimit(this,3999)"></textarea>
                        </td>
                        <td>Details 
                          of Trees- Non Fruit</td>
                        <td> 
                          <textarea name="txr_nonfruit" onBlur="" cols="50" style="text-align:left" wrap="VIRTUAL" rows="4" onKeyPress="textlimit(txr_nonfruit,3999);notAllowSingleAndDoubleQuote()" onKeyUp="textlimit(this,3999)"></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td> Total Acreage</td>
                        <td> 
                          <%
                          	String strVal="N"; 
                          	if(vecData!=null&&vecData.size()>0)
                          	{
                          		vecsize = vecData.size();
                          	}
                          	if(vecData!=null && vecData.size()>0)
                          	{
                              	vecsize2 = vecData.size();
                  				for (int j = 0; j < vecsize2; j++) 
                  				{
                  					vecRow = (ArrayList) vecData.get(j);
                  					if (vecRow != null)
									{
					                    acreval = Double.parseDouble(Helper.correctDouble((String) vecRow.get(3)));
										centguntval = Double.parseDouble(Helper.correctDouble((String)vecRow.get(21)));
										totalacreval = totalacreval + acreval;
										totalcentgunt = totalcentgunt + centguntval;	
									}
                  				}
                  			}
                  			%>
                          	<%
		                   	guntasrealq  = totalcentgunt % 100;
		   					guntasrealr   = totalcentgunt / 100 ;
		   					if(guntasrealr >= 1)
		   					{
		   						totalacreval = 	totalacreval + guntasrealr;
		   					}
		   					totalacreval = Math.floor(totalacreval);
		   					if((totalacreval==0.00) || (totalacreval==0))
		   					{
		   						strVal="Y";
		   					}
							%>
                          <%=totalacreval%>&nbsp;&nbsp;Acres&nbsp;</td>
                          
                          <td  nowrap>Farmer's Category<b><span class="mantatory" id="id_Farm">&nbsp;*</span></b>
                          <input type="hidden" name="txt_TotLandHold" size="15" maxlength="100" value="<%=totalacreval%>">
                          </td>
                        <td>
						<select name="sel_FarmerCategory" style="width: 80%" tabindex="23">
						<option value="" selected="selected">--Select--</option>
						<lapschoice:BanksSchemeStaticDataNewTag apptype="13" />
						</select>
						</td>
                        <td>&nbsp;</td>
                      </tr>
                    </table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<lapschoice:combuttonnew btnnames="" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
					<tr>
						<td width="10%" align="center" >Particulars of land Holdings</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
                <%if (vecData != null)
                {
				%>
                <tr class="dataheader"> 
                  <td width="6%" align="center">&nbsp;</td>
                  <td width="7%" align="center">Applicant Name</td>
                  <td width="10%" align="center">Village</td>
                  <td width="6%" align="center">Survey No.</td>
                  <td width="8%" align="center"> Acreage</td>
                  <td width="9%" align="center">Source of Irrigation</td>
                  <td width="9%" align="center">Encumbrance</td>
                  <td width="9%" align="center">Whether Owned/Leased</td>
                  <td width="9%" align="center">Lease Period</td>
                  <td width="9%" align="center">Farm Distance - In 
                    Kms </td>
                </tr>
                <%
            }
			String strSno = "";
			String leased = "";			
			String strapptype1="",strapptype2="";
			String strparicularland = "";

			for (int i = 0; i < vecsize; i++) 
			{
				vecRow = (ArrayList) vecData.get(i);
				if (vecRow != null) 
				{
					strSno 				= Helper.correctNull((String) vecRow.get(2));			
					acreval 			= Double.parseDouble(Helper.correctDouble((String) vecRow.get(3)));
					centguntval 		= Double.parseDouble(Helper.correctDouble((String)vecRow.get(21)));
					totalacreval 		= totalacreval + acreval;
					totalcentgunt 		= totalcentgunt + centguntval;					
					leased 				= Helper.correctNull((String) vecRow.get(10));
					strparicularland 	= Helper.correctNull((String) vecRow.get(13));	
					
					if (leased.equals("1")) 
					{
						leased = "Owned";
					} 
					if(leased.equals("2"))
					{
						leased = "Leased";
					}
					if(leased.equals("3"))
					{
						leased = "Share cropper";
					}
					if(leased.equals("4"))
					{
						leased = "Others";
					}
					strapptype 	= Helper.correctNull((String) vecRow.get(1));
					strapptype2 = Helper.correctNull((String) vecRow.get(24));
							
					if (strparicularland.equals("1")) 
					{
						strparicularland = "Irrigated";
					} 
					if(strparicularland.equals("2"))
					{
						strparicularland = "Dry Land";
					}
					if(strparicularland.equals("3"))
					{
						strparicularland = "Non-Cultivable";
					}
					%>
					 
                <tr class="datagrid"> 
                  <td><input type="radio" name="sno"
					style="border-style:none"
					onClick="selectValues(
					'<%=Helper.correctNull((String) vecRow.get(0))%>','<%=Helper.correctNull((String) vecRow.get(1))%>',
					'<%=Helper.correctNull((String) vecRow.get(2))%>','<%=Helper.correctNull((String) vecRow.get(3))%>',
					'<%=Helper.correctNull((String) vecRow.get(4))%>','<%=Helper.correctNull((String) vecRow.get(5))%>',
					'<%=Helper.correctNull((String) vecRow.get(6))%>','<%=Helper.correctNull((String) vecRow.get(7))%>',
					'<%=Helper.correctNull((String) vecRow.get(8)) %>','<%=Helper.correctNull((String) vecRow.get(9))%>',
					'<%=Helper.correctNull((String) vecRow.get(10))%>','<%=Helper.correctNull((String) vecRow.get(11))%>',
					'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) vecRow.get(12))))%>','<%=Helper.correctNull((String) vecRow.get(13))%>',
					'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) vecRow.get(14))))%>',
					'<%=Helper.correctNull((String) vecRow.get(18))%>','<%=Helper.correctNull((String) vecRow.get(19))%>',
					'<%=Helper.correctNull((String) vecRow.get(21))%>',
					'<%=Helper.correctNull((String) vecRow.get(22))%>','<%=Helper.correctNull((String) vecRow.get(23))%>',
					'<%=Helper.correctNull((String) vecRow.get(27))%>','<%=Helper.correctNull((String) vecRow.get(28))%>',
					'<%=Helper.correctNull((String) vecRow.get(29))%>','<%=Helper.correctNull((String) vecRow.get(30))%>',
					'<%=Helper.correctNull((String) vecRow.get(31))%>','<%=strFarmcategory%>','<%=i%>','<%=strVal%>')"> 
                  <input type="hidden" name="hid" value="<%=strSno%>">
                  
                  <input type="hidden" name="hidsource<%=i%>" value="<%=Helper.correctDoubleQuotesHtml((String) vecRow.get(15))%>">
                  <input type="hidden" name="hidencumbrance<%=i%>" value="<%=Helper.correctDoubleQuotesHtml((String) vecRow.get(16))%>">
                  <input type="hidden" name="hidencroached<%=i%>" value="<%=Helper.correctDoubleQuotesHtml((String) vecRow.get(17))%>">
                  <input type="hidden" name="hidtreesfruit<%=i%>" value="<%=Helper.correctDoubleQuotesHtml((String) vecRow.get(25))%>">
                  <input type="hidden" name="hidtreesnonfruit<%=i%>" value="<%=Helper.correctDoubleQuotesHtml((String) vecRow.get(26))%>">
                  <input type="hidden" name="hidaddress<%=i%>" value="<%=Helper.correctDoubleQuotesHtml((String) vecRow.get(20))%>">
                  </td>
                  <td align="left">&nbsp;<%=strapptype2%> </td>
                  <td align="left">&nbsp;<%=Helper.correctNull((String) vecRow.get(4))%>&nbsp; &nbsp; &nbsp; &nbsp;</td>
                  <td align="left">&nbsp; <%=Helper.correctNull((String) vecRow.get(7))%></td>
                  <td align="right"> &nbsp; <%=Helper.correctNull((String) vecRow.get(3))%></td>
                  <td><%=Helper.correctNull((String) vecRow.get(15))%></td>
                  <td align="left"><%=Helper.correctNull((String) vecRow.get(16))%></td>
                  <td><%=leased%></td>
                  <td align="left"><%=Helper.correctNull((String) vecRow.get(11))%></td>
                  <td><%=Helper.correctNull((String) vecRow.get(18))%></td>
                </tr>
                <%}
			           }%>
				<tr align="center"> 
                  <td>&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td>&nbsp;</td>
                  <td align="right">&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td align="right">&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr align="center"> 
                  <td>&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td>&nbsp;</td>
                  <td align="right">&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td align="right">&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr align="center"> 
                  <td>&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td>&nbsp;</td>
                  <td align="right">&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td align="right">&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr align="center">
                  <td>&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td>&nbsp;</td>
                  <td align="right">&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td align="right">&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
              </table>
			</td>
		</tr>
		</table>
      </td>
			</tr>
		</table>
<table>
	<tr>
<td>
<input type="hidden" name="selsno"/>
<input type="hidden" name="hidcroptype" value="PR">
<input type="hidden" name="hidchobank_apptype">
<input type="hidden" name="cmdsave" disabled="disabled">
<input type ="hidden" name="land_measurement" value ="<%=Helper.correctNull((String)hshValues.get("land_measurement"))%>">
<input type="hidden" name="hid_FarmCat" value="">
<input type="hidden" name="hid_subvention" value="<%=Helper.correctNull((String)hshValues.get("com_subvention"))%>">
<iframe height="0" width="0" id="ifrm1" frameborder="0" style="border: 0"></iframe>
<lapschoice:hiddentag pageid="<%=PageId%>"/>
</td>
</tr>
</table>
</form>
</body>
<script>
if(parent.menuFrame && parent.mainFrame)
{
	if(parent.menuFrame.document.forms[0].btnenable && parent.mainFrame.document.forms[0].btnenable)
	{
		parent.mainFrame.document.forms[0].btnenable.value=parent.menuFrame.document.forms[0].btnenable.value;
	}
}

if(document.forms[0].btnenable.value=="N")
	{//For the users, in the application created organisation other than SARAL throgh link
		enableButtons(true,true,true,true,true,false);
	}
</script>
</html>