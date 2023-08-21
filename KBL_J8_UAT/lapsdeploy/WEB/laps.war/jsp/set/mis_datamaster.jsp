<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) 
{
	hshValues = (java.util.HashMap) objValues;	
}
String strStatId=Helper.correctNull((String)hshValues.get("strStatId"));
String strStatsno=Helper.correctNull((String)hshValues.get("stat_data_sno"));
String strDataDesc=Helper.correctNull((String) hshValues.get("strSelDataHeads"));
if(strStatsno=="")
{
	strStatsno="0";
}
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
if(hshValues!=null)
{
arrRow = (ArrayList)hshValues.get("arrRow");
}
%>
<html>
<head>
<title>MIS - Data Master</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var statno=<%=strStatsno%>;
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varDataHeads="<%=Helper.correctNull((String) hshValues.get("strSelDataHeads"))%>";


function callonLoad()
{		
	disablefields(true);
	enableButtons(false, true, true, true, false,true);	
	document.forms[0].seldataheadtype.value = varDataHeads;
	document.forms[0].sel_visibility.disabled = true;
	document.forms[0].sel_weathersche.disabled = true;
	document.forms[0].sel_whtrmclr.disabled = true;
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
	}
	
}

function doSave()
{	
    if((document.forms[0].seldataheadtype.value == "" ) || (document.forms[0].seldataheadtype.value == "0" ))
	{
	ShowAlert(111,"the Data Heads");
	document.forms[0].seldataheadtype.focus();
	return false;
	}
    if(trim(document.forms[0].txt_datavalues.value)=="")
	{
	ShowAlert(121,"the Data Values");
	document.forms[0].txt_datavalues.focus();
	return ;
	}
    if(trim(document.forms[0].txt_datacode.value)=="")
	{
	ShowAlert(121,"the Data Code");
	document.forms[0].txt_datacode.focus();
	return ;
	}
    if(trim(document.forms[0].sel_visibility.value)=="")
	{
	ShowAlert(111,"Visibility");
	document.forms[0].sel_visibility.focus();
	return ;
	}	
	if(document.forms[0].seldataheadtype.value == "1")
	{
	 if(document.forms[0].sel_weathersche.value=="s")
	 {
		ShowAlert(111,"Whether Schematic");
		document.forms[0].sel_weathersche.focus();
		return ;
	 }
	 if(document.forms[0].sel_whtrmclr.value=="s")
	 {
		ShowAlert(111,"Whether to be considered for MSME exposure");
		document.forms[0].sel_whtrmclr.focus();
		return ;
	 }
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="mis";
	document.forms[0].hidBeanMethod.value="updateMISstaticdata";
	document.forms[0].hidBeanGetMethod.value="getMISstaticdata";
	document.forms[0].hidSourceUrl.value="/action/mis_datamaster.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();			
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
		document.forms[0].hidBeanGetMethod.value="getMISstaticdata";
		document.forms[0].hidBeanId.value="mis";
		document.forms[0].action=appURL+"action/mis_datamaster.jsp";	
		document.forms[0].submit();
	}
}

function doDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{
	    document.forms[0].hidAction.value="Delete";
		document.forms[0].hidBeanId.value="mis";
		document.forms[0].hidBeanMethod.value="updateMISstaticdata";
		document.forms[0].hidBeanGetMethod.value="getMISstaticdata";
		document.forms[0].hidSourceUrl.value="/action/mis_datamaster.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}

function doNew() 
{
	if(document.forms[0].seldataheadtype.value=="0")
	{
		ShowAlert(111,"Data Heads");
		document.forms[0].seldataheadtype.focus();
		return ;
	}
	ClearFields();
	document.forms[0].hidAction.value="insert";
   	enableButtons(true, true, false, false, true,true);
   	disablefields(false);   	
   	document.forms[0].sel_visibility.disabled = false;
   	document.forms[0].sel_weathersche.disabled = false;
   	document.forms[0].sel_whtrmclr.disabled = false;
}

function doEdit() 
{
	if(document.forms[0].txt_datavalues.value=="")
	{
		ShowAlert(111,"Data Values Sno from the list");
		document.forms[0].txt_datavalues.focus();
		return ;
	}
    document.forms[0].hidAction.value="update";
    enableButtons(true, true, false, false, true,true);
	disablefields(false);
	document.forms[0].sel_visibility.disabled = false;
	document.forms[0].sel_weathersche.disabled = false;
	document.forms[0].sel_whtrmclr.disabled = false;
}
   
function enableButtons(bool1, bool2, bool3, bool4, bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
	//document.forms[0].cmddelete.disabled=bool6;
}

function selectValues(val0,val1,val2,val3,val4,val5,val6)
{
	document.forms[0].txt_datacode.value = val0;
	document.forms[0].txt_datavalues.value = val1;
	document.forms[0].sel_visibility.value = val2;
	document.forms[0].txt_hidsno.value = val3;
	document.forms[0].seldataheadtype.value = val4;
	showWeather();
	if(val5!="")
	{
		document.forms[0].sel_weathersche.value = val5;	
		document.forms[0].sel_whtrmclr.value = val6;	
	}
	else
	{
		document.forms[0].sel_weathersche.value = "s";
		document.forms[0].sel_whtrmclr.value = "s";
	}
	enableButtons(true, false, true, false, true,false);
	document.forms[0].sel_weathersche.disabled = true;	
	document.forms[0].sel_whtrmclr.disabled = true;	
}

function selvalues()
{	
	document.forms[0].hidBeanId.value="mis";
	document.forms[0].hidBeanGetMethod.value="getMISstaticdata";
	document.forms[0].action=appURL+"action/mis_datamaster.jsp?DataHeads="+document.forms[0].seldataheadtype.value;
	document.forms[0].submit();
} 

function showWeather()
{
 if(document.forms[0].seldataheadtype.value=="1")
 {
   document.all.wse.style.visibility="visible";
   document.all.wse.style.position="relative";
   document.all.mclr.style.visibility="visible";
   document.all.mclr.style.position="relative";
 }
 else
 {
	 document.all.wse.style.visibility="hidden";
	 document.all.wse.style.position="absolute";  
	 document.all.mclr.style.visibility="hidden";
	 document.all.mclr.style.position="absolute";  
 }
	
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad();showWeather()">
<form class="normal" name="appform" method="post" action="">
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt; Setup  -&gt; MIS Data Master</td></tr>
</table>
<br>
<table class="outertable border1 tableBg" width="98%" border="0" cellpadding="5" cellspacing="0" align="center">
	 <tr> 
      <td valign="top">       
              <table class="outertable" border="0" cellspacing="0" cellpadding="0" width="100%" align="center">
                <tr> 
                  <td valign="top"> 
                    <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="1">
                      <tr> 
                        <td width="69%" valign="top"> 
                          <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="3">
                            <tr> 
                              <td> 
                                <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5">
                                  <tr> 
                                    <td width="8%" nowrap="nowrap">Data Heads</td>
                                    <td width="13%"> 
                                      <select name="seldataheadtype" tabindex="2" onchange="selvalues();showWeather()">
                                        <option value="" selected="selected">&lt;----Select----&gt;</option>
                                        <lapschoice:MISStaticDataTag/> 
                                      </select>
                                    </td>
                                    <td width="9%" nowrap="nowrap">Data Values</td>
                                    <td width="70%"> 
                                      <input type="text" name="txt_datavalues" size="80" maxlength="50" onKeyPress="notAllowSplChar()" value="<%=Helper.correctNull((String)hshValues.get("stat_data_desc"))%>">
                                    </td>
                                  </tr>
								  <tr> 
                                    <td width="8%" nowrap="nowrap">Data Code</td>
                                    <td width="13%"> <input type="text" name="txt_datacode" size="50" maxlength="50" onKeyPress="notAllowSplChar()" value=""> </td>
                                    <td width="9%" nowrap="nowrap">Visibility</td>
                                    <td width="70%"><select name="sel_visibility">
                                      	<option value="E" selected>Enable</option>
                                      	<option value="D">Disable</option>
                                      </select></td>
                                  </tr>
                                  <tr id="wse">
                                    <td nowrap="nowrap">Whether Schematic&nbsp;<b><span class="mantatory">*</span></b></td>
                                    <td><select name="sel_weathersche">
                                    <option value="s">--Select--</option>
                                    <option value="y">Yes</option>
                                    <option value="n">No</option>
                                    </select></td>
                                  </tr>
                                  <tr id="mclr">
                                    <td nowrap="nowrap">Whether to be considered for MSME exposure&nbsp;<b><span class="mantatory">*</span></b></td>
                                    <td><select name="sel_whtrmclr">
                                    <option value="s">--Select--</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                    </select></td>
                                  </tr>
                                <tr><td width="8%" nowrap="nowrap">&nbsp;</td><td width="13%">&nbsp;</td><td width="9%" nowrap="nowrap">&nbsp;</td><td width="70%">&nbsp;</td></tr>
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
                                  <lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
                                  <br>                                
                                <table class="outertable" width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
                                  <tr> 
                                    <td valign="top" align="center"> 
                                      <table class="outertable linebor" width="100%" border="0" cellspacing="0" cellpadding="3">
                                        <tr class="dataheader"> 
                                          <td width="3%" >&nbsp;</td>
                                          <td width="7%" align="center" ><b>S No.</b></td>
                                          <td width="35%"  align="center"><b>Data Values</b></td>
										  <td width="27%"  align="center"><b>Data Code</b></td>
										  <td width="10%"  align="center"><b>Visibility</b></td>
										  <%if(strDataDesc.equalsIgnoreCase("1")){ %>
										  <td width="18%"  align="center" id="s1"><b>Schematic</b></td>
										  <%}%>
                                        </tr>
                                      	<%
											if (arrRow != null && arrRow.size() > 0) 
											{
											for (int i = 0; i < arrRow.size(); i++) 
											{
											arrCol = (ArrayList) arrRow.get(i);
											
											String strVisibility = Helper.correctNull((String)arrCol.get(2));
											String strWeatherSchem=Helper.correctNull((String)arrCol.get(5));
											String strVisibility1= "",strWeatherSchem1="";
											if(strVisibility.equalsIgnoreCase("E"))
											{
												strVisibility1 = "Enable";
											}
											if(strVisibility.equalsIgnoreCase("D"))
											{
												strVisibility1 = "Disable";
											}
											if(strWeatherSchem.equalsIgnoreCase("y"))
											{
												strWeatherSchem1="Yes";
											}
											else if(strWeatherSchem.equalsIgnoreCase("n"))
											{
												strWeatherSchem1="No";
											}
										%>
                                          <tr class="datagrid"> 
                                            <td width="3%"> 
                                              <input type="radio" name="radiobutton" value="radiobutton" style="border-style:none"  onClick="selectValues('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(1))%>','<%=Helper.correctNull((String)arrCol.get(2))%>','<%=Helper.correctNull((String)arrCol.get(3))%>','<%=Helper.correctNull((String)arrCol.get(4))%>','<%=Helper.correctNull((String)arrCol.get(5))%>','<%=Helper.correctNull((String)arrCol.get(6))%>')">
                                            </td>
                                            <td width="7%" align="center"><%=i+1%></td>
                                            <td width="35%" align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(1))%></td>
											<td width="27%" align="center"><%=Helper.correctNull((String)arrCol.get(0))%></td>
											<td width="10%" align="center"><%=strVisibility1%></td>
											<%if(strDataDesc.equalsIgnoreCase("1")){ %>
											<td width="18%" align="center" id="s2"><%=strWeatherSchem1%></td>
											<%} %>										
									       </tr>
                                          <%}}%>
                                           <tr class="datagrid"> 
                                            <td width="3%">&nbsp; </td>
                                            <td width="7%">&nbsp; </td>
                                            <td width="35%">&nbsp; </td>
											<td width="27%">&nbsp; </td>
											<td width="10%">&nbsp; </td>
											<%if(strDataDesc.equalsIgnoreCase("1")){ %>
											<td width="18%">&nbsp; </td>
											<%} %>
                                          </tr>
                                        </table>
                                        </td>
                                        </tr>
                                        </table>
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type ="hidden" name ="hidkeyid" value="set">
   <input type="hidden" name="seldataheadtype1">
  <input type="hidden" name="org_code" value ="<%=session.getAttribute("strOrgCode")%>" >
  <input type="hidden" name="strOrgCode" value ="<%=session.getAttribute("strOrgCode")%>" >
  <input type="hidden" name="hidsno" value="<%=Helper.correctNull((String)hshValues.get("stat_data_sno"))%>">
  <input type="hidden" name="hidstate" value="2">
  <input type="hidden" name="hidstatenew" value="">
  <input type="hidden" name="txt_hidsno" value="">  
<br> 
</form>
</body>
</html>
