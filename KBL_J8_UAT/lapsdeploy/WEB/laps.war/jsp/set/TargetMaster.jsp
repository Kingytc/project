<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<% String strOrgcode = (String)session.getAttribute("strOrgCode");%>
 <%
			ArrayList vecData = new ArrayList();
			ArrayList vecRow = new ArrayList();
			int vecsize = 0;
			int vecsize1 = 0;
			if (hshValues != null) {
				vecData = (ArrayList) hshValues.get("vecData");

			}
			String strapptype = "";
			String apptype = "";
			String app_status = Helper.correctNull((String) hshValues
					.get("app_status"));
%>
<%
String strDOW = "";
String strMonth = "";
String strYear="";	
String strMonthnm = "";
String strMonnum = "";	
int intYear = 0;
int curYear = 0;
int intMonth = 0;	
int intStartYear;	
int intStopYear;				
int noDays=0;					
int intDOW= 0;					
int intLCount = 0;	

if (!(request.getParameter("month") == null) || !(request.getParameter("year") == null))
{
	strMonth=request.getParameter("month");
	strYear=request.getParameter("year");
}
else
{
	strMonth = null;
	strYear = null;
}

Calendar calen = Calendar.getInstance();
//first time when the Calendar.jsp invoked
if(strMonth==null || strYear==null)						
{
	strYear = String.valueOf(calen.get(Calendar.YEAR));  // calculate the year
	curYear = calen.get(Calendar.YEAR);					 // calculate the current year
	
}
// when the user select particular year or month from the calendar window
else			
{
	strMonth = strMonth;
	intMonth = Integer.parseInt(strMonth);				// conver the string parameter to integer  	
	intYear = Integer.parseInt(strYear);				// conver the string parameter to integer	
	curYear = calen.get(Calendar.YEAR);					// calculate the current year
	
	strMonth = String.valueOf(calen.get(Calendar.MONTH));
	strYear = String.valueOf(calen.get(Calendar.YEAR));
	intYear = calen.get(Calendar.YEAR);
	
	intDOW = calen.get(Calendar.DAY_OF_WEEK);			//	calculate the Day of Week
	intMonth = Integer.parseInt(strMonth);
}
intStartYear = 1930;
intStopYear = 2100;
strMonnum = strMonth;
strMonth  = strMonthnm ;
%>

<html>
<head>
<title>Target Master</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script language="JavaScript" type="text/javascript">

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var path      ="<%=ApplicationParams.getAppUrl()%>";
var taxyear = "<%=Helper.correctNull((String)hshValues.get("taxyear"))%>";
var quarter = "<%=Helper.correctNull((String)hshValues.get("sel_quarter"))%>";
var accountheld = "<%=Helper.correctNull((String)hshValues.get("accountheld"))%>";
function NoallowEnterandDoubleQuote()
{
	var key=window.event.keyCode;
	if(key == 13 || key==34)
	{
		window.event.returnValue = false;
	}
}

function doDelete()
{
	if(document.forms[0].sel_accounthead.value == "0" && document.forms[0].txt_target.value == "" && document.forms[0].txt_actual.value == "")  
    	{
    	ShowAlert(149,"Radio Button");
   		return;
    	}
	if(ConfirmMsg(101))
	{
        document.forms[0].hidAction.value="delete";
        document.forms[0].hidBeanId.value="targetmaster";
		document.forms[0].hidBeanMethod.value="updateaccountdetails";
		document.forms[0].hidBeanGetMethod.value="getaccountdetails";
		document.forms[0].hidSourceUrl.value="/action/TargetMaster.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}

function doSave()
{
		
	  if(document.forms[0].taxyear.value=="0" )
	{
		
		document.forms[0].taxyear.focus();
		ShowAlert('111',"Business Year");
		return false;
	}
	
	 if (document.forms[0].sel_quarter.value=="0")
	{
		document.forms[0].sel_quarter.focus();
		ShowAlert('111',"During Type");
		return false;
	}
	if (document.forms[0].sel_accounthead.value=="0")
	{
		document.forms[0].sel_accounthead.focus();
		ShowAlert('111',"During Type");
		return false;
	}
	
		document.forms[0].cmdapply.disabled = true;
        document.forms[0].hidBeanId.value="targetmaster";
		document.forms[0].hidBeanMethod.value="updateaccountdetails";
		document.forms[0].hidBeanGetMethod.value="getaccountdetails";
		document.forms[0].hidSourceUrl.value="/action/TargetMaster.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	
}

function callonLoad()
{
	disableFields(true);
	if("<%=vecData.size()%>"=="0"){
	enableButtons(false,true,true,true,false,false);
	}else{
	enableButtons(false,false,true,true,false,false);
	}
	document.forms[0].taxyear.disabled=false;
	document.forms[0].sel_quarter.disabled=false;
	if(taxyear!="")
 	{
 		document.forms[0].taxyear.value=taxyear;
 	}
 	if(quarter!="")
 	{
 		document.forms[0].sel_quarter.value=quarter;
 	}
 	else{
 		document.forms[0].sel_quarter.value='0';
 	}
 	if(accountheld!="")
 	{
 		document.forms[0].sel_accounthead.value=accountheld;
 	}
 	else{
 		document.forms[0].sel_accounthead.value='0';
 	}
	
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].readOnly=val;		  
		}
		else if (document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;	
		}
		else if (document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].disabled=val;	
		}
	}
}
		
function disableradio(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		 if (document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=val;	
		}
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].value="";		  
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
		  document.forms[0].elements[i].value="";		  
		}
	}
}
	
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}

function doEdit() 
{	
	if(document.forms[0].sel_accounthead.value == "0" && document.forms[0].txt_target.value == "" && document.forms[0].txt_actual.value == "")  
    	{
    	ShowAlert(149,"Radio Button");
   		return;
    	}
    disableFields(false);	
	document.forms[0].hidAction.value="Edit";
   	enableButtons(true,true,false,false,true,true);
}

function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
    document.forms[0].cmdNew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdapply.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddel.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}

function doNew() 
{
	document.forms[0].txt_target.value="";
	document.forms[0].sel_accounthead.value="0";
	document.forms[0].sel_quarter.value="0";
	document.forms[0].hidAction.value="New";
   	enableButtons(true,true,false,false,true,true);
   	disableFields(false);
	disableradio(true);	
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
	    document.forms[0].hidAction.value="cancel";
		document.forms[0].hidBeanGetMethod.value="getaccountdetails";
		document.forms[0].hidBeanId.value="targetmaster";
		document.forms[0].action=appURL+"action/TargetMaster.jsp";	
		document.forms[0].submit();
	}
}

function callCalender(val)
{
	var action  =document.forms[0].hidAction.value;
	if(action =="New" || action =="Edit")
	{
		showCal(appURL,val);
	}
}

function selectValues(val1, val2, val3, val4, val5, val6, val7,val8)
{
document.forms[0].selsno.value = val2;
document.forms[0].taxyear.value = val3;  
document.forms[0].sel_quarter.value = val4;  
document.forms[0].sel_accounthead.value = val5;
document.forms[0].txt_target.value = val7;
document.forms[0].txt_actual.value = val8;
document.forms[0].txt_account.value = val6;
enableButtons(false,false,true,true,false,false);

}
function calc(month,year)
{
	var selyr = document.forms[0].taxyear.selectedIndex;
    var yr = document.forms[0].taxyear.options[selyr].value;
}
function formattext()
{
	var key = window.event.keyCode;
	if(key==34 || key==39 ||  key == 38 || key == 13)
	{
		window.event.returnValue = false;
	}
}

function NoallowEnterandDoubleQuote()
{
	var key=window.event.keyCode;
	if(key == 13 || key==34)
	{
		window.event.returnValue = false;
	}
}

function seldatevalue()
{
	if(document.forms[0].taxyear.value == "0")
    	{
    	ShowAlert(111,"Business Year");
   		return;
    	}
    if(document.forms[0].sel_quarter.value == "0")
    	{
    	ShowAlert(111,"During");
   		return;
    	}
	if(document.forms[0].hidAction.value!="Edit" && document.forms[0].hidAction.value!="New")
    {
       	document.forms[0].hidBeanId.value="targetmaster";
		document.forms[0].hidBeanGetMethod.value="getaccountdetails";
		document.forms[0].hidSourceUrl.value="/action/TargetMaster.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}

</script>
<style>
Div.Cellcontainer
{
 height:160px; overflow:auto
}
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body class="bgcolor" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="callonLoad()">
<form name="colForm" method="post"><iframe height="0" width="0" id="ifrm" frameborder=0 style="border:0"></iframe> <br>
<table width="98%" border="1" cellspacing="0" cellpadding="5" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
	<tr>
		<td valign="top">
		<table width="100%" border="1" cellspacing="0" cellpadding="5"
			bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
			<tr>
				<td valign="top">
			</tr>
			<tr>
				<td valign="top">

				<table border="0" cellspacing="0" cellpadding="0" width="100%">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="1">
						  <tr>
						     
                        <td>Business Year <b><font size="1"
											face="MS Sans Serif" color="#FF0000">*</font></b></td>
						     
                        <td><select name="taxyear" onChange="calc(<%=strMonnum%>,this.value);seldatevalue();" style="FONT-FAMILY: Arial; FONT-SIZE: 8pt;COLOR: #000099">
                        <option value="0"><--select--></option>
                <%
                 for(int i=intStartYear;i<=intStopYear;i++)
                  {
                %>
                    <option value="<%=i%>" 
                <%
              	    if(i==Integer.parseInt(strYear)) 
	       			out.println("selected");
	        %> ><%=i%></option>
                <%
                 }
                %>
              </select></td>
						     
                        <td> During <b><font size="1"
											face="MS Sans Serif" color="#FF0000">*</font></b></td>
						     
                        <td><select name="sel_quarter" onChange="seldatevalue()" tabindex="2">
						   <option value="0" selected>&lt;---- Select ----&gt;</option>
                            <option value="1">I Quarter</option>
                            <option value="2">II Quarter</option>
                            <option value="3">III Quarter</option>
                            <option value="4">IV Quarter</option>
                          </select></td>
						     
                        <td>Main Head</td>
						     <td><select name="sel_accounthead" tabIndex="4">
                            
                            <option value="0" selected>&lt;---- Select ----&gt;</option>
                            
                            <lapschoice:accountheld /> 
                          </select></td>
                          
                          <td>Sub Head</td>
						     <td><select name="sel_accounthead" tabIndex="4">
                            
                            <option value="0" selected>&lt;---- Select ----&gt;</option>
                            
                            <lapschoice:accountheld /> 
                          </select></td>
                          
                          <td>Account Head</td>
						     <td><select name="sel_accounthead" tabIndex="4">
                            
                            <option value="0" selected>&lt;---- Select ----&gt;</option>
                            
                            <lapschoice:accountheld /> 
                          </select></td>
					</tr>
					<tr>  
                        <td>Target</td>
						     <td><input type="text" name="txt_target" size="15" style="text-align:right"
											maxlength="9" onKeyPress="allowNumber(this)" tabindex="9"
											value="<%=Helper.correctNull((String)hshValues.get("target")) %>"></td>
						     
                        <td>Actuals</td>
						     <td><input type="text" name="txt_actual" size="15" style="text-align:right"
											maxlength="9" onKeyPress="allowNumber(this)" tabindex="9"
											value="<%=Helper.correctNull((String)hshValues.get("actual")) %>"></td>
						  </tr>
						</table>

						</td>
					</tr>
					<tr>
						<td><br>
						<table width="12%" border="1" cellspacing="0" cellpadding="0"
							bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
							class="outertablecolor" align="center">
							<tr>
								<td>
								<table width="43%" border="0" cellspacing="0" cellpadding="2">
									<tr valign="top">
										<td><input type="button" name="cmdNew" value="New"
											style="width:50" class="buttonStyle" onClick="doNew()"></td>
										<td><input type="button" name="cmdedit" value="Edit"
											style="width:50" class="buttonStyle" onClick="doEdit()"></td>
										<td><input type="button" name="cmdapply" value="Save"
											style="width:50" class="buttonStyle" onClick="doSave()"></td>
										<td><input type="button" name="cmdcancel" value="Cancel"
											style="width:50" class="buttonStyle" onClick="doCancel()"></td>
										<td><input type="button" name="cmddel" value="Delete"
											style="width:50" class="buttonStyle" onClick="doDelete()"></td>
										<td><input type="button" name="cmdHelp" value="Help"
											class="buttonHelp"
											onClick="doHelp()"></td>
										<td height="0">
										<div align="center"><input type="button" name="cmdclose"
											value="Close" onClick="doClose()"
											class="buttonClose">
										</div>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						<br>
						</td>
					</tr>
					<tr>
						<td>
						<table width="98.3%" border="0" cellspacing="1" cellpadding="3">
							<tr class="dataheadcolor">
								<td width="5%">&nbsp;</td>
								
                        <td width="55%"><b>Account Head</b></td>
								
                        <td width="20%"><b>Target</b></td>
								
                        <td width="20%"><b>Actuals</b></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td valign="top">
						<DIV class="cellcontainer">
						<table width="100%" border="0" cellspacing="1" cellpadding="2">
							<%vecsize = vecData.size();
						
			             String strSno = "";
			
			
			for (int i = 0; i < vecsize; i++) {
				vecRow = (ArrayList) vecData.get(i);
				if (vecRow != null) {
					strSno = Helper.correctNull((String) vecRow.get(1));
					
					%>
							<tr class="datagridcolor">
								<td width="5%"><input type="radio" name="sno"
								value="<%=strSno%>"
											<%
											out.println("strSno"+strSno);
                               		if(Helper.correctNull((String)hshValues.get("selsno")).trim().equalsIgnoreCase(strSno)){
                               			out.println("Checked");
                               		}
                                %> 
									style="border-style:none"
									onClick="selectValues('<%=Helper.correctNull((String) vecRow.get(0))%>', '<%=Helper.correctNull((String) vecRow.get(1)) %>','<%=Helper.correctNull((String) vecRow.get(2))%>','<%=Helper.correctNull((String) vecRow.get(3))%>', '<%=Helper.correctNull((String) vecRow.get(4))%>','<%=Helper.correctNull((String) vecRow.get(5))%>','<%=Helper.correctNull((String) vecRow.get(6))%>','<%=Helper.correctNull((String) vecRow.get(7))%>');">
										
								<input type="hidden" name="hid" value="<%=strSno%>"></td>
								
								<td width="55%"><%=Helper.correctNull((String) vecRow.get(5))%></td>
								<td width="20%"><%=Helper.correctNull((String) vecRow.get(6))%></td>
								<td width="20%"><%=Helper.correctNull((String) vecRow.get(7))%></td>
								
							</tr>
							    <%}
			                         }%>

							<tr class="datagridcolor">
								<td width="5%">&nbsp;</td>
								<td width="55%">&nbsp;</td>
								<td width="20%">&nbsp;</td>
								<td width="20%">&nbsp;</td>
							</tr>
							<tr class="datagridcolor">
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<tr class="datagridcolor">
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<tr class="datagridcolor">
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<tr class="datagridcolor">
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<tr class="datagridcolor">
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<tr class="datagridcolor">
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<tr class="datagridcolor">
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<tr class="datagridcolor">
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<tr class="datagridcolor">
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<tr class="datagridcolor">
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<tr class="datagridcolor">
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
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
<input type="hidden" name="org_code"
	value="<%=session.getAttribute("strOrgCode")%>"> <input type="hidden"
	name="strOrgCode" value="<%=session.getAttribute("strOrgCode")%>"> <input
	type="hidden" name="hidBeanMethod" value=""> <input type="hidden"
	name="hidBeanId"> <input type="hidden" name="hidSourceUrl"> <input
	type="hidden" name="hidAction"> <input type="hidden" name="hidslno"
	value=""> <input
	type="hidden" name="hidstate" value=""> <input type="hidden"
	name="hidBeanGetMethod" value=""> <input
			type="hidden" name="selsno" value="<%=Helper.correctNull((String)hshValues.get("selsno")) %>">
			<input
			type="hidden" name="txt_account" value=""></form>
</body>
</html>

