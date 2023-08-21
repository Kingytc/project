<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<lapschoice:handleerror />
<%if (objValues instanceof java.util.HashMap)
	{
		hshValues = (java.util.HashMap) objValues;
	}
	ArrayList g1 = new ArrayList();
	String strStatId = Helper.correctNull((String) hshValues.get("strStatId"));
	String strtypeadv = Helper.correctNull((String) hshValues.get("sch_typeadv"));
%>
<html>
<head>
<title>Personal - Applicant </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function SearchData()
{
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanGetMethod.value="getInterfaceSchemeData";
	document.forms[0].action=appURL+"action/setintrfschemes.jsp";
	document.forms[0].submit();
}
function onLoad()
{	
	var varstrStatId ="<%=Helper.correctNull((String) hshValues.get("strStatId"))%>"; 	
	disablefields(true);
	enableButtons(false, true, true, true,true, false);	
	document.forms[0].seldataheadtype.value='<%=strStatId%>';
	document.forms[0].hidRangeExist.value="";
	document.forms[0].hidDescription.value="";
}
function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].value="";		  
		}		
	}
}
function disablefields(one)
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
		if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=!one;
		}
	}
	document.forms[0].sel_typeadvance.disabled=one;
	document.forms[0].sel_SubSector.disabled=one;
}
function doSave()
{
	var str_SubSector="";
	if(trim(document.forms[0].txt_datavalues.value)=="")
	{   
		ShowAlert(121,"Scheme Code");
		document.forms[0].txt_datavalues.focus();
		return ;
	}
	/*if(trim(document.forms[0].txt_tenorfrom.value)=="")
	{   
		ShowAlert(121,"Tenor From");
		document.forms[0].txt_tenorfrom.focus();
		return ;
	}
	if(trim(document.forms[0].txt_tenorto.value)=="")
	{  
		ShowAlert(121,"Tenor To");
		document.forms[0].txt_tenorto.focus();
		return ;
	}
	if(parseInt(document.forms[0].txt_tenorfrom.value)>parseInt(document.forms[0].txt_tenorto.value))
	{  
		alert("Tenor From should be Greater than Tenor To");
		document.forms[0].txt_tenorfrom.focus();
		return ;
	}*/
	if(trim(document.forms[0].sel_SubSector.value)=="")
	{  
		ShowAlert(111,"Sub Sector");
		document.forms[0].sel_SubSector.focus();
		return ;
	}
	if(trim(document.forms[0].txt_datavalues1.value)=="")
	{  
		ShowAlert(121,"GL Sub Head Code");
		document.forms[0].txt_datavalues1.focus();
		return ;
	}
	if(trim(document.forms[0].sel_typeadvance.value)=="")
	{  
		ShowAlert(111,"Type of Advance");
		document.forms[0].sel_typeadvance.focus();
		return ;
	}
	for(var i=0;i<document.forms[0].sel_SubSector.options.length;i++)
	{
	  if(document.forms[0].sel_SubSector.options[i].selected)
		{
		  str_SubSector=str_SubSector+document.forms[0].sel_SubSector.options[i].value+"@";
		}
	}
	document.forms[0].hid_SubSector.value = str_SubSector;
	/*if(document.forms[0].hidAction.value=="New")
	{
		for(var k=0;k<document.forms[0].sel_staticdatalist.length;k++)
		{
		 	var strTxt1=document.forms[0].sel_staticdatalist.options[k].value+"$"+document.forms[0].sel_staticdatalist.options[k].text;
		 	var strTxt2=document.forms[0].txt_datavalues.value+"$"+document.forms[0].txt_tenorfrom.value+"$"+document.forms[0].txt_tenorto.value+"$"+document.forms[0].txt_datavalues1.value;
	        if(strTxt1==strTxt2)
			{
				alert("This data value is already exists, try with different Data value");
				document.forms[0].txt_datavalues.value="";
				document.forms[0].txt_datavalues1.value="";
				document.forms[0].txt_tenorfrom.value="";
				document.forms[0].txt_tenorto.value="";
				document.forms[0].txt_datavalues.focus();
				return;
			}
		}
	}*/
	if(document.forms[0].hidRangeExist.value=="")
	{
		callRangeCheck();
	}
	else if(document.forms[0].hidRangeExist.value=="Y")
	{
		alert("Sub sector already attached with GL Sub Head Code "+document.forms[0].hidDescription.value);
		//document.forms[0].txt_tenorfrom.value="";
		//document.forms[0].txt_tenorto.value="";
		document.forms[0].hidRangeExist.value="";
		document.forms[0].hidDescription.value="";
		return;
	}
	else if(document.forms[0].hidRangeExist.value=="N")
	{
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanMethod.value="updateInterfaceSchemeData";
		document.forms[0].hidBeanGetMethod.value="getInterfaceSchemeData";
		document.forms[0].hidSourceUrl.value="/action/setintrfschemes.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}
function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
	    document.forms[0].hidAction.value="Cancel";
		document.forms[0].hidBeanGetMethod.value="getInterfaceSchemeData";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].action=appURL+"action/setintrfschemes.jsp";	
		document.forms[0].submit();
	}
}
function doNew() 
{
 	if(document.forms[0].seldataheadtype.value=="0")
	{
		ShowAlert(111,"Data Head");
		document.forms[0].seldataheadtype.focus();
		return;
	} 
	ClearFields();
	document.forms[0].hidAction.value="New";
   	enableButtons(true, true, false, false,true, true);
   	disablefields(false);
}
function doEdit() 
{
	if(document.forms[0].seldataheadtype.value=="0" )
	{   ShowAlert(111,"the Data Head");
		document.forms[0].seldataheadtype.focus();
		return false;
	}
	if(document.forms[0].txt_datavalues.value=="")
	{
		ShowAlert(111,"record from the list");
		document.forms[0].txt_datavalues.focus();
		return ;
	}
    document.forms[0].hidAction.value="Edit";
    enableButtons(true, true, false, false,false, true);
	disablefields(false);
    document.forms[0].txt_datavalues.readOnly=true;
}
function enableButtons(bool1, bool2, bool3, bool4, bool5, bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanMethod.value="updateInterfaceSchemeData";
		document.forms[0].hidBeanGetMethod.value="getInterfaceSchemeData";
		document.forms[0].hidSourceUrl.value="/action/setintrfschemes.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
function selectValues(val0,val1,val2,val3,val4,val5,val6,val7)
{
	for(var j=0;j<document.forms[0].sel_SubSector.options.length;j++)
	{
		document.forms[0].sel_SubSector.options[j].selected=false;
	}
	document.forms[0].seldataheadtype.value=val2;  
	document.forms[0].hidsno.value=val0;             
    document.forms[0].txt_datavalues.value=val1;
    document.forms[0].txt_datavalues1.value=val3;     
    document.forms[0].txt_tenorfrom.value=val4;
    document.forms[0].txt_tenorto.value=val5;
	document.forms[0].hidRangeExist.value="";
	document.forms[0].hidDescription.value="";
	document.forms[0].sel_typeadvance.value=val6;
	var varSubSector="";
	var strSubSector="";
	varSubSector=val7;
	strSubSector=varSubSector.split("@");
	for(var s=0;s<strSubSector.length-1;s++)
	{
		var subSectorVal="";
		subSectorVal=strSubSector[s];
		for(var i=0;i<document.forms[0].sel_SubSector.options.length;i++)
		{
			if(document.forms[0].sel_SubSector.options[i].value==subSectorVal)
		  	{
				document.forms[0].sel_SubSector.options[i].selected=true;
			}
		}
	}
	enableButtons(true, false, true, true,true, false);
}
function callRangeCheck()
{
	if(document.forms[0].txt_datavalues.value!="")
	{
		document.all.ifrm1.src=appURL+"action/iframeschemerange.jsp?hidBeanGetMethod=getSchemeCodeRangeCheck&hidBeanId=staticdata&strSchemeCode="+document.forms[0].txt_datavalues.value+"&strLoanType="+document.forms[0].seldataheadtype.value+"&strAction="+document.forms[0].hidAction.value+"&strSno="+document.forms[0].hidsno.value+"&hidSubSector="+document.forms[0].hid_SubSector.value;
	}
}
</SCRIPT>
<style>
DIV.cellContainer {	
  width: 100%; height: 200;
  overflow: auto;
}
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onLoad()">
<form name="appform" method="post" action="" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt;  Setup -&gt; Other Setup -&gt; Scheme Codes</td>
	</tr>
</table>
<br>
<table width="98%" border="0" cellpadding="5" cellspacing="0" class="outertable" align="center">
<tr>
	<td valign="top">
		<table width="80%" border="0" cellspacing="5" cellpadding="5" align="center">
		<tr>
			<td>
				<table width="100%" border="0" cellspacing="5" cellpadding="5" align="center">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1 tableBg">
						<tr>
							<td>
								<table width="90%" border="0" cellspacing="3" cellpadding="3" class="outertable" align="center">
								<tr>
		                        	<td width="12%" nowrap="nowrap">Type of Loan</td>
		                            <td width="28%"> 
		                            	<select name="seldataheadtype" tabindex="1" onChange="SearchData()">
											<option value="0" selected="selected">&lt;----Select----&gt;</option>
											<option value="LAA">Term Loan & Demand Loan</option>
											<option value="ODA">OverDraft Loan</option>
										</select>
									</td>
		                            <td width="25%">Scheme Code&nbsp;<span class="mantatory">*</span></td>
		                            <td width="35%"> 
		                            	<input type="text" name="txt_datavalues" tabindex="2" size="40" maxlength="400" value="" onKeyPress="notAllowSingleAndDoubleQuote()" onBlur="">
									</td>
								</tr>
								<tr style="visibility: hidden; position: absolute">
									<td colspan="2">&nbsp;</td>
		                            <td>Tenor From &nbsp;<span class="mantatory">*</span></td>
		                            <td> 
		                            	<input type="text" name="txt_tenorfrom" tabindex="3" size="5" maxlength="50" value="" onKeyPress="notAllowSingleAndDoubleQuote();allowInteger()" onBlur="">
									</td>
								</tr>
		                        <tr style="visibility: hidden; position: absolute">
		                        	<td colspan="2">&nbsp;</td>
		                            <td>Tenor To &nbsp;<span class="mantatory">*</span></td>
		                            <td> 
		                            	<input type="text" name="txt_tenorto" tabindex="3" size="5" maxlength="50" value="" onKeyPress="notAllowSingleAndDoubleQuote();allowInteger()" onBlur="">
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>Sub sector&nbsp;<span class="mantatory">*</span></td>
									<td>
										<select name="sel_SubSector" style="width: 100%" multiple="multiple">
											<lapschoice:BanksSchemeStaticDataNewTag apptype="7" />
											<lapschoice:BanksSchemeStaticDataNewTag apptype="8" />
										</select>
									</td>
								</tr>
		                        <tr>
		                        	<td>&nbsp;</td>
		                        	<td>
										<%String strvalue=Helper.correctNull((String) hshValues.get("strStatId")); %>
										<select name="sel_staticdatalist" style="Visibility:hidden" tabindex="4">
		                                	<lapschoice:SchemeStaticDataTag apptype='<%=strvalue%>' /> 
										</select>
									</td>
		                            <td>GL Sub Head code&nbsp;<span class="mantatory">*</span></td>
		                            <td> 
		                            	<input type="text" name="txt_datavalues1" tabindex="3" size="40" maxlength="400" value="" onKeyPress="notAllowSingleAndDoubleQuote()">
									</td>
								</tr>
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td width="20%">
										Type of Advance&nbsp;<span class="mantatory">*</span>
										</td>
										<td>
											<select name="sel_typeadvance" style="width: 100%">
											<option value="">--Select--</option>
											<lapschoice:CBSStaticDataNewTag apptype="22"/>
											</select>
										</td>
								</tr>
								</table>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete'
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="1">
						<tr>
							<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td valign="top">
										<table width="98.3%" border="0" cellspacing="1" cellpadding="3">
										<tr class="dataheader">
											<td width="4%">&nbsp;</td>
											<td width="48%">&nbsp;Scheme Code</td>
											<td width="48%">&nbsp;GL Sub Head code</td>
										</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td valign="top" align="center">
									<DIV class="cellContainer">
										<table width="100%" border="0" cellspacing="1" cellpadding="2">
										<%ArrayList v = (ArrayList) hshValues.get("vecRow");
											String inside = "N";
											if (v != null) {
												int vecsize = v.size();
												for (int l = 0; l < vecsize; l++) {
												g1 = (ArrayList) v.get(l);
										%>
										<tr class="datagrid">
											<td width="4%" align="center">
												<input type="radio" name="radiobutton" value="radiobutton" style="border-style:none"
													onClick="selectValues('<%=Helper.correctNull((String)g1.get(0))%>',
																			'<%=Helper.correctNull((String)g1.get(1))%>',
																			'<%=Helper.correctNull((String)g1.get(2))%>',
																			'<%=Helper.correctNull((String)g1.get(3)) %>',
																			'<%=Helper.correctNull((String)g1.get(4)) %>',
																			'<%=Helper.correctNull((String)g1.get(5)) %>',
																			'<%=Helper.correctNull((String)g1.get(6)) %>',
																			'<%=Helper.correctNull((String)g1.get(7)) %>')">
											</td>
											<td width="48%">&nbsp;<%=Helper.correctNull((String) g1.get(1))%></td>
											<td width="48%">&nbsp;<%=Helper.correctNull((String) g1.get(3))%></td>
										</tr>
										<%}}
										else
										{%>
										<tr class="datagrid">
											<td width="4%">&nbsp;</td>
											<td width="48%">&nbsp;</td>
											<td width="48%">&nbsp;</td>
										</tr>
										<tr class="datagrid">
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr class="datagrid">
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr class="datagrid">
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr class="datagrid">
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr class="datagrid">
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr class="datagrid">
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<%} %>
										<tr class="datagrid">
											<td width="4%">&nbsp;</td>
											<td width="48%">&nbsp;</td>
											<td width="48%">&nbsp;</td>
										</tr>
										<tr class="datagrid">
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr class="datagrid">
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
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<iframe src="" id="ifrm1" width="0" height="0"></iframe>
<input type="hidden" name="org_code" value="<%=session.getAttribute("strOrgCode")%>">
<input type="hidden" name="strOrgCode" value="<%=session.getAttribute("strOrgCode")%>">
<input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidSourceUrl" value=""> 
<input type="hidden" name="hidAction" value="">
<input type="hidden" name="hidsno" value="<%=Helper.correctNull((String)hshValues.get("stat_data_sno"))%>">
<input type="hidden" name="hidstate" value="2"> 
<input type="hidden" name="hidstatenew" value="">
<input type="hidden" name="hidBeanGetMethod" value="getInterfaceSchemeData">
<input type="hidden" name="hidRangeExist">
<input type="hidden" name="hidDescription">
<input type="hidden" name="hid_SubSector" value="">
</form>
</body>
</html>
