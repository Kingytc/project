<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<lapschoice:handleerror />
<%
//out.print(hshValues.get("bank_charges"));
			ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();
			

			String strCons_Owner = Helper.correctNull((String) request
					.getParameter("hidCostitution"));

			
			java.text.NumberFormat nf = java.text.NumberFormat
					.getNumberInstance();
			nf.setGroupingUsed(false);
			nf.setMinimumFractionDigits(2);
			nf.setMaximumFractionDigits(2);

			String[] location = new String[5];
			String[] descript = new String[5];
			String[] owner = new String[5];
			String[] date = new String[5];
			location = (String[]) hshValues.get("fil_location");
			descript = (String[]) hshValues.get("fil_descript");
			owner = (String[]) hshValues.get("fil_owner");
			date = (String[]) hshValues.get("fil_date");

			String[] regname = new String[5];
			String[] regdate = new String[5];
			String[] regamount = new String[5];
			String[] regcharges = new String[5];
			regname = (String[]) hshValues.get("fil_regname");
			regdate = (String[]) hshValues.get("fil_regdate");
			regamount = (String[]) hshValues.get("fil_regamount");
			regcharges = (String[]) hshValues.get("fil_regcharges");

			%>

<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<style>
.td,tr{font-family: "MS Sans Serif";
	font-size: 11px;
	}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/link.css" type="text/css" />
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css" />
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>

<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var rbutton="<%=hshValues.get("terms_condts")%>";
var constitution="<%=strCons_Owner%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";

var bank_charges="<%=Helper.correctNull((String)hshValues.get("bank_charges"))%>";
var terms_condts="<%=Helper.correctNull((String)hshValues.get("terms_condts"))%>";

function detailsRegister()
{
if(constitution=="OLP")
   
		{
			document.all.a6.style.visibility="visible";
			document.all.a7.style.visibility="hidden";
			document.all.a6.style.position="relative";
			
		}
		else
		{
			document.all.a6.style.visibility="hidden";
			document.all.a7.style.visibility="visible";
			document.all.a6.style.position="absolute";
			
		}

}


function clearValues()
{
	
	if(bank_charges=="n")
	for( i=0;i<=4;i++)		
	{	
		    document.forms[0].txt_location[i].value="";
			document.forms[0].txt_descript[i].value="";
			document.forms[0].txt_owner[i].value="";
			document.forms[0].txt_date[i].value="";
		
	}
	if(terms_condts=="0")
	document.forms[0].txt_reason.value="";
	
}

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		
		
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddel.disabled=true;
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
		showReason();
		disableFields(true);		 
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddel.disabled=false;
		 document.forms[0].cmdapply.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=false;	 
		 disableFields(false);
	}
}

function onLoading()
{
	
	disableCommandButtons("load");
	if(bank_charges !=null)
	{
		if(bank_charges=="y")
		{
		  
		  document.forms[0].sel_colbutton.value=bank_charges;	
		  document.all.a5.style.visibility="visible";	
		  document.all.a5.style.position="relative";
		}
		else if(bank_charges=="n")
		{
			
			document.forms[0].sel_colbutton.value='n'	
			document.all.a5.style.visibility="hidden";
			document.all.a5.style.position="absolute";
			
		}
		else
		{
			document.forms[0].sel_colbutton.value='y';	
		  	document.all.a5.style.visibility="visible";	
		  	document.all.a5.style.position="relative";
		}
	}
	
	if(terms_condts=="1")
	{
	  document.forms[0].sel_rbutton.value=terms_condts;	
	  document.all.a1.style.visibility="visible"
	}
	
	else
	{
		document.forms[0].sel_rbutton.value='0'
	}
	

	<%for(int b=0;b<5;b++)
	{
		location[b]=Helper.correctNull((String)location[b]);
		descript[b]=Helper.correctNull((String)descript[b]);
		owner[b]=Helper.correctNull((String)owner[b]);
		date[b]=Helper.correctNull((String)date[b]);
		
		if(!location[b].equalsIgnoreCase(""))
		{
		%>
			var location="<%=location[b]%>";
			var descript="<%=descript[b]%>";
			var owner="<%=owner[b]%>";
			var date="<%=date[b]%>";
			var sel="<%=b%>";
			
			document.forms[0].txt_location[sel].value=location;
			document.forms[0].txt_descript[sel].value=descript;
			document.forms[0].txt_owner[sel].value=owner;
			document.forms[0].txt_date[sel].value=date;
		<%}
	}%>
	
	<%for(int d=0;d<5;d++)
	{
		regname[d]=Helper.correctNull((String)regname[d]);
		regdate[d]=Helper.correctNull((String)regdate[d]);
		regamount[d]=Helper.correctDouble((String)regamount[d]);
		regcharges[d]=Helper.correctNull((String)regcharges[d]);

		if(!regname[d].equalsIgnoreCase(""))
		{
		%>
			var regname="<%=regname[d]%>";
			var regdate="<%=regdate[d]%>";
			var regamount="<%=Helper.formatDoubleValue(Double.parseDouble(regamount[d]))%>";
			var regcharges="<%=regcharges[d]%>";
			var sel1="<%=d%>";
			
			document.forms[0].txt_regname[sel1].value=regname;
			document.forms[0].txt_regdate[sel1].value=regdate;
			document.forms[0].txt_regamount[sel1].value=regamount;
			document.forms[0].txt_regcharges[sel1].value=regcharges;
		<%}
	}%>
	detailsRegister();
	clearValues();
	
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");	
}
function doDelete()
{
if(ConfirmMsg(101))
		{	
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidSourceUrl.value="/action/34PointsFormat_page2.jsp";
			document.forms[0].hidBeanId.value="npa";
			document.forms[0].hidBeanMethod.value="update34pointspage2Data";
			document.forms[0].hidBeanGetMethod.value="get34pointspage2Data";
			document.forms[0].action=appUrl +"controllerservlet";
			document.forms[0].submit(); 
		}


}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
	    document.forms[0].hidSourceUrl.value="/action/34PointsFormat_page2.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanGetMethod.value="get34pointspage2Data";
		document.forms[0].hidBeanMethod.value="get34pointspage2Data";
		document.forms[0].action=appUrl +"controllerservlet"; 
		document.forms[0].submit(); 		
	}	
	
	disableCommandButtons("load");
}

function doSave()
	{
	 document.forms[0].hidSourceUrl.value="/action/34PointsFormat_page2.jsp";
	document.forms[0].hidBeanId.value="npa";
	document.forms[0].hidBeanMethod.value="update34pointspage2Data";
	document.forms[0].hidBeanGetMethod.value="get34pointspage2Data";
	document.forms[0].action=appUrl+"controllerservlet"; 
	document.forms[0].submit();
	
	showcolReason();
	showReason();
	}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	
		if(document.forms[0].elements[i].type=='radio')
	 	{
			document.forms[0].elements[i].disabled=val;
		}  
		
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}  
		if(document.forms[0].elements[i].type=='select-one' )
		  {
 				document.forms[0].elements[i].disabled=val;
		  }
		 
	}
	for(var i=0;i<5;i++)
	{
	document.forms[0].txt_date[i].readOnly=true;
	document.forms[0].txt_regdate[i].readOnly=true;
	
	}
	
}
function doClose()
	{
	if(ConfirmMsg('100'))
		{
		document.forms[0].method="post";	
		document.forms[0].action=appUrl+"action/"+"mainnav.jsp";
		document.forms[0].submit();
		}
	}

function callLink(page,bean,method)
		{
		if (document.forms[0].cmdapply.disabled)
	{
		 document.forms[0].hidSourceUrl.value=page;
		 document.forms[0].hidBeanGetMethod.value=method;
		 document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
			 }
	else
	{
		ShowAlert(103);
	}
		}
function showReason()
{

		if(document.forms[0].sel_rbutton.value=='1')
		{
			document.all.a1.style.visibility="visible";
			
		}
		else
		{
			document.all.a1.style.visibility="hidden";
			
		}
	
}
function showcolReason()
{

    if(document.forms[0].sel_colbutton.value=='y')
		{
			document.all.a5.style.visibility="visible";
			document.all.a5.style.position="relative";
			
		}
	/*	else if(document.forms[0].sel_colbutton.value==true) 
		{
			document.all.a5.style.visibility="hidden";
			document.all.a5.style.position="absolute";
			
		}*/
		else
		{
			document.all.a5.style.visibility="hidden";
			document.all.a5.style.position="absolute";
			
		}

	
	
}
function callCalender(name)
{
	
	if(document.forms[0].cmdapply.disabled==false)
	{
		showCal(appUrl,name);
		
	}
}
</script>
</head>
<body text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0" font-family="arial" font-size="11px"
	onload="onLoading()">
<form name="34pointsFormatpage2" method="post">
<table width="100%" border="1" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
				<tr>
					<td>
						<lapstab:suiturltag pageid="2"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><lapschoice:npaapplication />
		<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />
		</td>
	</tr>
</table>
<table width="100%" border="1" cellspacing="0" cellpadding="2">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="1" cellspacing="0" cellpadding="2">
					<tr>
						<td width="50%">8. Sanctioning Authority(ies)</td>
						<td width="50%">MCM/MD/ED/GM/DGM</td>
					</tr>
					<tr>
					<td colspan="" height="25">9. Whether Collateral security(ies)
						held </td>
					 <td width="50%"> 
                    <select name="sel_colbutton" onchange="showcolReason()">
                      <option value="y">Yes</option>
                      <option value="n">No</option>
                    </select>
                  </td>
					<!--  	<td colspan="2" height="25">9. Whether Collateral security(ies)
						held <input type="radio" name="sel_colbutton" value="0"
							onClick="showcolReason()"> yes <input type="radio"
							name="sel_colbutton" value="1" onClick="showcolReason()"> No
						(Tick suitably)</td>-->
					</tr>
					<!--   <tr> 
                <td colspan="2">If held, give detailed particulars there of here 
                  below: -<br>
                  Details of Coll. Sec. (Location; owner of the property; description, 
                  Date of EM etc): -<br>
                  <br>
                  <br>
		  
                </td>
              </tr>-->
				</table>
				</td>
			</tr>
			<tr>
				<td id="a5">
				<table width="100%" border="1" cellspacing="0" cellpadding="5">
					<tr bgcolor="#71694F">
						<td colspan="4">Details of Collateral Security</td>
					</tr>
					<tr align="center" bgcolor="#71694F">
						<td width="5%">Location</td>
						<td>Description</td>
						<td width="30%">Owner of the Property</td>
						<td width="30%">Date of EM</td>
					</tr>
					<%for (int i = 0; i < 5; i++) {

				if (location[i] != null && location[i] != "") {
					//System.out.println("==-=-=-=-=-=-0=-=" + location[i]);

					%>
					<tr>
						<td width="20%"><input type="text" name="txt_location" size="35"
							maxlength="50" value="<%//=Helper.correctNull(location[i])%>""></td>
						<td width="20%"><input type="text" name="txt_descript" size="35"
							maxlength="75" value="<%//=Helper.correctNull(descript[i])%>""></td>
						<td width="20%"><input type="text" name="txt_owner"
							 size="35" maxlength="50"
							value="<%//=Helper.correctNull(owner[i])%>""></td>
						<td width="20%"><input type="text" name="txt_date" size="15"
							maxlength="25" value="<%//=Helper.correctNull(date[i])%>"">
							<a href="#" onClick="callCalender('txt_date[<%=i%>]')"
							TITLE="Click to view calender" BORDER=0><IMG
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							BORDER="0" TABINDEX="23"></a></td>
					</tr>
					<%}

				else {%>
					<tr>
						<td width="20%"><input type="text" name="txt_location" size="35"
							maxlength="50" value="<%//=Helper.correctNull(location[i])%>""></td>
						<td width="20%"><input type="text" name="txt_descript" size="35"
							maxlength="75" value="<%//=Helper.correctNull(descript[i])%>""></td>
						<td width="20%" ><input type="text" name="txt_owner"
							size="35" maxlength="50"
							value="<%//=Helper.correctNull(owner[i])%>""></td>
						<td width="20%" ><input type="text" name="txt_date" size="15"
							maxlength="25" value="<%//=Helper.correctNull(date[i])%>"">
							<a href="#" onClick="callCalender('txt_date[<%=i%>]')"
							TITLE="Click to view calender" BORDER=0><IMG
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							BORDER="0" TABINDEX="23"></a></td>
					</tr>
					<%}
			}

			%>
				</table>
				</td>
			</tr>
			<tr>
				<td id="a6">
				<table width="100%" border="1" cellspacing="0" cellpadding="3">
					<tr>
					<td>
						<!--  <p>10.In case of Private Limited and Corporate Bodies. please
						inform whether our Bank's charge/s is / are registered with the
						Registrar of Companies and the nature thereof:-</p>-->
						<table width="100%" border="1" cellspacing="0" cellpadding="5">
							<tr>
								<td colspan="4">10. Details of registration</td>
							</tr>
							<tr align="center">
								<td width="5%">Name of ROC</td>
								<td>Date of Registration</td>
								<td width="30%">Amount of Charges</td>
								<td width="30%">Type of Charges</td>
							</tr>
							<%for (int i = 0; i < 5; i++) {
				if (regname[i] != null && regname[i] != "") {

					%>
							<tr>
								<td width="20%"><input type="text" name="txt_regname" size="35"
									maxlength="50" value=""></td>
								<td width="20%"><input type="text" name="txt_regdate" size="15"
									maxlength="10" value=""> <a href="#"
									onClick="callCalender('txt_regdate[<%=i%>]')"
									title="Click to view calender" border=0> <img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0"> </a></td>
								<td width="20%"><input type="text" name="txt_regamount"
									onKeyPress="allowInteger()" size="35" maxlength="9" style="text-align:right" value=""></td>
								<td width="20%"><input type="text" name="txt_regcharges"
									onKeyPress="allowInteger()" size="35" maxlength="30" value=""></td>
							</tr>
							<%}

				else {%>
							<tr>
								<td width="20%"><input type="text" name="txt_regname" size="35"
									maxlength="50" value=""></td>
								<td width="20%"><input type="text" name="txt_regdate" size="15"
									maxlength="10" value=""> <a href="#"
									onClick="callCalender('txt_regdate[<%=i%>]')"
									title="Click to view calender" border=0> <img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0"> </a></td>
								<td width="20%"><input type="text" name="txt_regamount" style="text-align:right"
									onKeyPress="allowInteger()" size="35" maxlength="9" value=""></td>
								<td width="20%"><input type="text" name="txt_regcharges"
									onKeyPress="allowInteger()" size="35" maxlength="30" value=""></td>
							</tr>
							<%}
			}

			%>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td id="a7">10. Registration charge is not applicable for this
				aplication.</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="1" cellspacing="0" cellpadding="5">
					<tr>
						<td colspan="4">11. Name/s and Address/es of the Guarantor(s)
						Surety (ies) with their occupation and Means ;</td>
					</tr>
					<tr align="center">
						<td width="5%">No</td>
						<td>Name of the Guarantor</td>
						<td width="30%">Address</td>
						<td width="30%">Means</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="1" cellspacing="0" cellpadding="2">
					<tr>
						<td WIDTH="47%">12.Whether the terms and conditions are stipulated in the
						Sanction Advice and/or as required for while granting credit
						facility(ies) to the borrower(s) originally and<br>
						subsequently were fulfilled or not: - (Tick Suitably)<br>
						<!--<input type="radio" name="sel_rbutton" value="0"
							onClick="showReason()"> yes <input type="radio"
							name="sel_rbutton" value="1" onClick="showReason()"> No.<br>-->
						<br>
						</td>
						
						<td WIDTH="30%"><select name="sel_rbutton"
					onChange="showReason();">
					<option value="0">Yes</option>
					<option value="1">No</option>
				</select></td>
						
					
						
					</tr>
					<tr id="a1">
						<td>if no, brief reasons:-<br>
						<br>
						<textarea rows="4" name="txt_reason" cols="55"
							onKeyPress="textlimit(this,300)"><%=Helper.correctNull((String) hshValues.get("reasons"))%></textarea>
						<br>
						<br>
						
						</td>
						<td>&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="12%" border="1" cellspacing="0" cellpadding="0"
	bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
	align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2">
			<tr>
				<td align="center"><input type="button" name="cmdedit" value="Edit"
					class="buttonStyle"
					onclick="doEdit()"></td>
				<td align="center"><input type="button" name="cmdapply"
					value="Save"
					class="buttonStyle"
					onclick="doSave()"></td>
				<td align="center"><input type="button" name="cmdcancel"
					value="Cancel"
					class="buttonStyle"
					onclick="doCancel()"></td>
				<td align="center"><input type="button" name="cmddel" value="Delete"
					class="buttonStyle"
					onclick="doDelete()"></td>
				<!-- <td align="center"><input type="button" name="cmdhelp" value="Help"
					style="background-color:#009966;cursor:help;;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
					onclick="doHelp()"></td> -->
				<td align="center"><input type="button" name="cmdclose"
					value="Close"
					style="background-color:#CC3300;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
					onclick="doClose()"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<input type="hidden" name="hidappno" value="<%=(String)request.getParameter("appno")%>">
<input type="hidden" name="comapp_id" value="<%=(String)request.getParameter("comapp_id")%>">
<input type="hidden" name="hidAction" />
<input type="hidden" name="hidBeanId" /> 
<input type="hidden" name="hidBeanMethod" value="" />
<input type="hidden" name="hidBeanGetMethod" value="" />
<input type="hidden" name="hidCostitution" value="<%=strCons_Owner%>" /> 
<input type="hidden" name="hidSourceUrl" />
<input type="hidden" name="hidmoduletype" value="SUIT" />

</form>
</body>
</html>
