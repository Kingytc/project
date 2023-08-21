<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if(objValues instanceof java.util.HashMap)
   {
	  hshValues=(java.util.HashMap)objValues;
   }
String strBorrowerType =Helper.correctNull((String)request.getParameter("hidBorrowerType"));

String strcat="";
if(!strCategoryType.equalsIgnoreCase(null))
{
	if(strCategoryType.equalsIgnoreCase("OPS"))
	{
		strcat="Tertiary";
	}
	else 
	{
		strcat="Corporate";
	}		
}%>
<html>
<head>
<title>Small Scale Industries</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="javascript" >
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varRecordflag = "<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
function doHelp1()
{
	  var varString = appUrl+"jsp/sethlp/hlp_ssiab10arrears.jsp"
	   var title = "Documents";
		var prop = "scrollbars=no,width=600,height=450";	
		prop = prop + ",left=50,top=150";
		window.open(varString,title,prop);
}
function whileLoading()
{
	disableFields(true);
	document.forms[0].hidOtherMethod.value="hidGetData";
}


function enableButtons(bool1,bool2,bool3,bool4,bool5)
	{	
		document.forms[0].cmdedit.disabled=bool1;
		document.forms[0].cmdsave.disabled=bool2;
		document.forms[0].cmdcancel.disabled=bool3;	
		document.forms[0].cmddelete.disabled=bool4;	
		document.forms[0].cmdclose.disabled=bool5;
	}
function disableFields(val)
	{		
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
				document.forms[0].elements[i].readOnly=val;		  
			}
			if(document.forms[0].elements[i].type=="textarea")
			{
				document.forms[0].elements[i].readOnly=val;		  
			}
		}
	}
function changeTab(page)
  { 
 if (!document.forms[0].cmdsave.disabled)
	{
		ShowAlert(103);
		return;
	}
	  if(page=="demograph")
	  { 
		  document.forms[0].hidBeanId.value="ssidemographics";
		  document.forms[0].hidBeanGetMethod.value="getCorresRec";
		  document.forms[0].action=appUrl+"action/demograph.jsp?prinname="+pnameexp;	document.forms[0].submit();
	  }
	  if(page=="activities")
	  {   
				
		  document.forms[0].action=appUrl+"action/activities.jsp?prinname="+pnameexp;
		  document.forms[0].submit();
	  }
  }

function callpast()
{
	myappno = "<%=request.getParameter("appno")%>";
	var varbtnenable = document.forms[0].btnenable.value;
	var url=appUrl+"action/ssi_pastperf.jsp?hidBeanGetMethod=getSSIpastData&hidBeanId=arrears&appno="+myappno+"&btnenable="+varbtnenable;
	var title = "SSIPastPerformance";
	var prop = "menubar=no,scrollbars=yes,width=800,height=600";	
	var xpos = (screen.width - 800) / 2;
	var ypos = (screen.height - 600) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}

  function doCancel()
	{		
		if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].hidBeanId.value="arrears";
		document.forms[0].action=appUrl+"action/ssiab10_arrears.jsp";				
		document.forms[0].submit();
	}	
	}  
function doClose()
{
	if(ConfirmMsg(100))
	{ 
		document.forms[0].action=appUrl+"action/agrpage.jsp";
		document.forms[0].submit();
	}
}
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true);	
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidVal.value ="Edit";	
	document.forms[0].incometax.focus();
} 
function doSave()
{
	var appUrl="<%=ApplicationParams.getAppUrl()%>";
	document.forms[0].hidRecordflag.value=varRecordflag;
	document.forms[0].hidBeanGetMethod.value="UpdateArrearsData";
	document.forms[0].hidBeanId.value="arrears";
	document.forms[0].action=appUrl+"action/ssiab10_arrears.jsp";	
	document.forms[0].submit();
}
function doDelete()
{
	document.forms[0].hidVal.value="Delete";
	if(varRecordflag == "Y"){
	if(ConfirmMsg("101"))
    {
	document.forms[0].hidBeanId.value="arrears";
	document.forms[0].hidBeanMethod.value="UpdateArrearsData";
	document.forms[0].hidSourceUrl.value="/action/ssiab10_arrears.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
    }
}
}
</script>
</head>
<body onload="javascript:whileLoading()">
<form name="arrears" method="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true">
        <jsp:param name="pageid" value="4" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
	    <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
     <tr> 
            <td class="page_flow">Home -&gt; <%=strcat %> -&gt; Application -&gt; Ind. Activity -&gt; Arrears in Statutory Payments 
 </td>
          </tr>
  </table>
	  
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/>  
<lapschoice:Activitytab tabid="4" ssitype='<%=strSSIType%>' />
   <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                <tr> 
                  <td> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="5" class="outertable">
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
                            <tr> 
                              <td colspan="4"><b>Arrears in Statutory Payments (if any)</b>&nbsp;<b>(<%=ApplicationParams.getCurrency()%>)</b></td>
                            </tr>
                            <tr> 
                              <td width="34%">Income Tax </td>
                              <td width="18%"> <lapschoice:CurrencyTag name="incometax"  maxlength="12" value='<%=Helper.correctNull((String)hshValues.get("incometax"))%>' size="15" /> 
                              </td>
                              <td width="27%">Sales Tax</td>
                              <td width="21%"> <lapschoice:CurrencyTag name="salestax"  maxlength="12" value='<%=Helper.correctNull((String)hshValues.get("salestax"))%>' size="15" /> 
                              </td>
                            </tr>
                            <tr> 
                              <td  width="34%">Provident Fund</td>
                              <td width="18%" > <lapschoice:CurrencyTag name="provfund"  maxlength="12" value='<%=Helper.correctNull((String)hshValues.get("provfund"))%>' size="15" /> 
                              </td>
                              <td width="27%" >Employees State Insurance Corporation</td>
                              <td width="21%" > <lapschoice:CurrencyTag name="empstateic"  maxlength="12" value='<%=Helper.correctNull((String)hshValues.get("empstateic"))%>' size="15" /> 
                              </td>
                            </tr>
                            <tr> 
                              <td width="34%">Others (specify) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                                <textarea name="othernew" cols="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("othernew"))%></textarea>
                              </td>
                              <td width="18%"> <lapschoice:CurrencyTag name="others"  maxlength="12" value='<%=Helper.correctNull((String)hshValues.get("others"))%>' size="15" /> 
                              </td>
                              <td width="27%">&nbsp;</td>
                              <td width="21%">&nbsp; </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="5" class="outertable">
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
                            <tr class="dataheader"> 
                              <td colspan="6"><b>Monthly 
                                Turnover for Last Twelve Months </b> <b>(<%=ApplicationParams.getCurrency()%>)</b></td>
                            </tr>
                            <tr class="dataheader"> 
                              <td width="16%" align="center"><b>January</b></td>
                              <td width="16%" align="center"><b>February</b></td>
                              <td width="16%" align="center"><b>March</b></td>
                              <td width="16%" align="center"><b>April</b></td>
                              <td width="16%" align="center"><b>May</b></td>
                              <td width="20%" align="center"><b>June</b></td>
                            </tr>
                            <tr class="datagrid"> 
                              <td width="16%" align="center"><b> 
                              	<lapschoice:CurrencyTag name="jan"  maxlength="12" value='<%=Helper.correctNull((String)hshValues.get("jan"))%>' size="15" />                                
                                </b></td>
                              <td width="16%" align="center"><b> 
                              	<lapschoice:CurrencyTag name="feb"  maxlength="12" value='<%=Helper.correctNull((String)hshValues.get("feb"))%>' size="15" /> 
                                </b></td>
                              <td width="16%" align="center"><b>
                              	<lapschoice:CurrencyTag name="mar"  maxlength="12" value='<%=Helper.correctNull((String)hshValues.get("mar"))%>' size="15" /> 
                                </b></td>
                              <td width="16%" align="center"><b> 
                              	<lapschoice:CurrencyTag name="apr"  maxlength="12" value='<%=Helper.correctNull((String)hshValues.get("apr"))%>' size="15" /> 
                                </b></td>
                              <td width="16%" align="center"><b> 
                              	<lapschoice:CurrencyTag name="may"  maxlength="12" value='<%=Helper.correctNull((String)hshValues.get("may"))%>' size="15" /> 
                                </b></td>
                              <td width="20%" align="center"><b> 
                              	<lapschoice:CurrencyTag name="jun"  maxlength="12" value='<%=Helper.correctNull((String)hshValues.get("jun"))%>' size="15" />  
                                </b></td>
                            </tr>
                            <tr class="dataheader"> 
                              <td width="16%" align="center"><b>July</b></td>
                              <td width="16%" align="center"><b>August</b></td>
                              <td width="16%" align="center"><b>September</b></td>
                              <td width="16%" align="center"><b>October</b></td>
                              <td width="16%" align="center"><b>November</b></td>
                              <td width="20%" align="center"><b>December</b></td>
                            </tr>
                            <tr class="datagrid"> 
                              <td width="16%" align="center"><b> 
                              	<lapschoice:CurrencyTag name="jul"  maxlength="12" value='<%=Helper.correctNull((String)hshValues.get("jul"))%>' size="15" />  
                                </b></td>
                              <td width="16%" align="center"><b> 
                              	<lapschoice:CurrencyTag name="aug"  maxlength="12" value='<%=Helper.correctNull((String)hshValues.get("aug"))%>' size="15" /> 
                                </b></td>
                              <td width="16%" align="center"><b> 
                              	<lapschoice:CurrencyTag name="sep"  maxlength="12" value='<%=Helper.correctNull((String)hshValues.get("sep"))%>' size="15" /> 
                                </b></td>
                              <td width="16%" align="center"><b> 
                              	<lapschoice:CurrencyTag name="oct"  maxlength="12" value='<%=Helper.correctNull((String)hshValues.get("oct"))%>' size="15" />  
                                </b></td>
                              <td width="16%" align="center"><b> 
                              	<lapschoice:CurrencyTag name="nov"  maxlength="12" value='<%=Helper.correctNull((String)hshValues.get("nov"))%>' size="15" />
                                </b></td>
                              <td width="20%" align="center"><b> 
                              	<lapschoice:CurrencyTag name="dec"  maxlength="12" value='<%=Helper.correctNull((String)hshValues.get("dec"))%>' size="15" />  
                                </b></td>
                            </tr>									  
						  </table>
						  <table width="100%" border="0" cellspacing="1" cellpadding="1" class="outertable">
								<tr align="center">
								<td>
								<input type="button" name="cmdpastper" value="Past Performance" style="width:150" class="buttonStyle" onclick="callpast()">
								</td></tr>	
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
  <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidVal">
<input type="hidden" name="genTable" value="no">
<input type="hidden" name="otherGetMethod" value="">
</form>
</body>
</html>
 