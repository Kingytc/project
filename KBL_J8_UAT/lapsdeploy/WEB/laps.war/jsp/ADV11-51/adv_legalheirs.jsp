<%@include file="../share/directives.jsp"%>
<%
ArrayList arrCol = new ArrayList();
ArrayList arrRow = new ArrayList();
%>
<html>
<head>
<title>ADV1151 - Legal Heirs</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";

function placevalues()
{
	disableCommandButtons("load");
}
function doNew()
{
	disableFields(false);
	disableCommandButtons("new");
	document.forms[0].hidAction.value ="insert";
	document.forms[0].txtname.value ="";
	document.forms[0].sel_gender.value="S";
	document.forms[0].txt_age.value="";
	document.forms[0].txt_relation.value="";
	document.forms[0].txt_maritalstatus.value="";
	document.forms[0].txtname.focus();	
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
	document.forms[0].txtname.focus();		
}
function doSave()
{
	if(document.forms[0].txtname.value=="")
	{
		ShowAlert('121',"Name");
		document.forms[0].txtname.focus();
		return;
	}
	else
	{
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidRecordflag.value=varRecordFlag;
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidSourceUrl.value="/action/adv_legalheirs.jsp";
		document.forms[0].hidBeanMethod.value="updateLegalheirs";
		document.forms[0].hidBeanGetMethod.value="getLegalheirs";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getLegalheirs";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].action=appURL+"action/adv_legalheirs.jsp";	
		document.forms[0].submit();
	}	
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
		document.forms[0].hidAction.value="Delete";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidBeanMethod.value="updateLegalheirs";
		document.forms[0].hidBeanGetMethod.value="getLegalheirs";	
		document.forms[0].hidSourceUrl.value="/action/adv_legalheirs.jsp";
		document.forms[0].submit();
		}
	}
	else
	{		
		ShowAlert(158);
	}
}
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/agrpage.jsp";
		document.forms[0].submit();
	}
}
function selectValues(val1, val2, val3, val4, val5, val6)
{

    document.forms[0].hidsno.value =val1;
	document.forms[0].txtname.value =val2;
	document.forms[0].sel_gender.value=val3;
	document.forms[0].txt_age.value=val4;
	document.forms[0].txt_relation.value=val5;
	document.forms[0].txt_maritalstatus.value=val6;
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		disableCommandButtons("radioselect");
	}
}
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		if(document.forms[0].appstatus.value=="Open/Pending")
		{
			document.forms[0].cmdnew.disabled =false;
			document.forms[0].cmdedit.disabled=true;
		}
		else
		{
			document.forms[0].cmdnew.disabled =true;
			document.forms[0].cmdedit.disabled=true;
		}	
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}
	if(val=="edit")
	{	 
		 document.forms[0].cmdnew.disabled =true;
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	if(val=="radioselect")
	{	 
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=false;
	}	  
	if(val=="disableall")
	{
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
	if(val=="new")
	{	 
		 document.forms[0].cmdnew.disabled =true;
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
}  
	
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=!val;
		}	 
	}
}

function clearfields()
{
	document.forms[0].txtname.value="";
	document.forms[0].sel_gender.value="S";
	document.forms[0].txt_age.value="";
	document.forms[0].txt_relation.value="";
	document.forms[0].txt_maritalstatus.value="";
}

function callCalender(fname)
{
	 showCal(appURL,fname);
}

function callLink(page,bean,method)
{
	if (document.forms[0].cmdapply.disabled)
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}

function onloading()
{	  
	document.forms[0].hidAction.value ="";
	document.forms[0].sel_gender.value="S";
	disableFields(true);
}
function callLink(page,bean,method)
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
	<form name="frmdocumentregister" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td> <jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="19" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Proposal -&gt; ADV1151 -&gt; Legal Heirs</td>
	</tr>
</table>
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application />
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center" >
    <tr class="dataheader"> 
    <td align="center"><b>LEGAL HEIRS</b>
    </td>
    </tr>
    </table>
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3"  class="outertable linebor" align="center">
                      <tr class="datagrid"> 
                        <td  width="18%">Name<span class="mantatory">*&nbsp;</span></td>
                        <td  width="34%"> 
                          <input type="text" tabindex="1" name="txtname"
									onKeyPress="notAllowSplChar()" maxlength="100">
                        </td>
                        <td  width="18%">Gender</td>
                        <td  width="34%"> 
                          <table width="43%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                            <tr> 
                              <td> 
                                <select name="sel_gender" tabindex="2">
                                  <option value="S" selected="selected">Select</option>
                                  <option value="M" selected="selected">Male</option>
                                  <option value="F">Female</option>
                                  <option value="O">Others</option>
                                </select>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr class="datagrid"> 
                        <td  width="14%">Age (YEARS)</td>
                        <td  width="34%"> 
                          <input type="text" tabindex="3"
									name="txt_age" onKeyPress="allowInteger()"
									value="" maxlength="3" >
                        </td>
                        <td  width="18%">Relationship</td>
                        <td  width="34%"> 
                          <table width="43%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                            <tr> 
                              <td> 
                                <input type="text" name="txt_relation" tabindex="4" value="" onKeyPress="allowAlphabets()" maxlength="50">
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr class="datagrid"> 
                        <td  width="14%">Marital Status</td>
                        <td  width="34%"> 
                          <input type="text" tabindex="5" name="txt_maritalstatus" onKeyPress="allowAlphabets()""
									value="" maxlength="50">
                        </td>
                        <td  width="18%">&nbsp;</td>
                        <td  width="34%">&nbsp;</td>                         
                      </tr>
                    </table>
                  </td>
                </tr>
               </table>
               </td>
               </tr>
               </table>
               <br>
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable linebor">
                            <tr class="dataheader"> 
                              <td width="3%" align="center"></td>
                              <td width="13%" align="center"><b>NAME</b></td>
                              <td width="14%" align="center"><b>GENDER</b></td>
                              <td width="14%" align="center"><b>AGE (YEARS)</b></td>
                              <td width="14%" align="center"><b> RELATIONSHIP</b></td>
                              <td width="14%" align="center"><b>MARITAL STATUS</b></td>
                            </tr>
                                    <%arrCol=new ArrayList();
										arrRow=(ArrayList)hshValues.get("arrRow");
										
										if(arrRow!=null && arrRow.size()>0)
										{
 							    			for(int i=0;i<arrRow.size();i++)
											{
 							    				arrCol=(ArrayList)arrRow.get(i);%>
                              <tr class="datagrid"> 
                                <td width="3%" align="center"> 
                                  <input type="radio"
											style="border:none" name="radiobutton" value="radiobutton"
											onClick="javascript:selectValues(
											    '<%=Helper.correctNull((String)arrCol.get(0))%>',
												'<%=Helper.correctNull((String)arrCol.get(2))%>',
												'<%=Helper.correctNull((String)arrCol.get(3))%>',
												'<%=Helper.correctNull((String)arrCol.get(4))%>',
												'<%=Helper.correctNull((String)arrCol.get(5))%>',
												'<%=Helper.correctNull((String)arrCol.get(6))%>')">
                                </td>
                                <% String gender=Helper.correctNull((String)arrCol.get(3));
                                if(gender.equalsIgnoreCase("m"))
                                {
                             	   gender="male";
                                }
                                else if(gender.equalsIgnoreCase("f"))
                                {
                             	   gender="female";
                                }
                                else if(gender.equalsIgnoreCase("O"))
                                {
                                	gender="others";
                                }
                                else
                                {
                                	gender="";
                                }
                                %>
                                <td width="13%" align="center">&nbsp;<%=Helper.correctNull((String)arrCol.get(2))%></td>
                                <td width="14%" align="center">&nbsp;<%=gender%></td>
                                <td width="14%" align="center">&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%></td>
                                <td width="14%" align="center">&nbsp;<%=Helper.correctNull((String)arrCol.get(5))%></td>
                                <td width="14%" align="center">&nbsp;<%=Helper.correctNull((String)arrCol.get(6))%></td>
                              </tr>
                              <%}}%>
                              <tr class="datagrid"> 
                                <td width="3%" align="center">&nbsp;</td>
                                <td width="13%" >&nbsp;</td>
                                <td width="14%" >&nbsp;</td>
                                <td width="14%" >&nbsp;</td>
                                <td width="14%" >&nbsp;</td>
                                <td width="14%" >&nbsp;</td>
                              </tr>
                            </table>
                        </td>
                      </tr>
                    </table>
                    <br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr> 
      <td width="20%" ><b>&nbsp;
        <a href="javascript:callLink('adv_dishonours.jsp','ADV1151','getdishonours')"> 
           &lt;&lt; Previous </a>&nbsp;</b>
      </td>
      <td width="60%" align="center"><b> 
        <jsp:include page="../ADV11-51/adv_links.jsp" flush="true" /> 
       </b></td>
      <td width="20%"> 
        <div align="right"><b> Pg.5/19&nbsp; 
        <a href="javascript:callLink('adv_guarantorsdetails.jsp','ADV1151','getGuranteedetails')"> 
		Next &gt;&gt;
          </a></b></div>
      </td> 
    </tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidsno">
</form>
</body>
</html>
