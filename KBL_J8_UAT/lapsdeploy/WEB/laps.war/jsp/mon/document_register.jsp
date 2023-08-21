<%@include file="../share/directives.jsp"%>
<%	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
		arrRow=(ArrayList)hshValues.get("arrRow");
		int intarrRowSize =arrRow.size(); %>

<html>
<head>
<title>Document Register</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>		
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var path      ="<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varOrgLev = "<%=strOrgLevel%>";
function placevalues()
{
	disableFields(true);
	if(varOrgLev != 'A')
	{
		disableCommandButtons(true,true,true,true,true,false);
	}
	else
	{
		disableCommandButtons(false,true,true,true,true,false);
		if(<%=intarrRowSize%>==0)
		{
			document.forms[0].cmdedit.disabled = true;
		}
	}
	
}

function doEdit()
{ 	
	disableFields(true);
	document.forms[0].hidAction.value ="update";
	document.forms[0].sel_type_applicant.disabled=false;	
	document.forms[0].txtdoccreatedby.readOnly=false;
	document.forms[0].txtdocvettedby.readOnly=false;
	document.forms[0].txtdocdatevetted.readOnly=false;
	document.forms[0].txtdocname.readOnly=false;
	document.forms[0].sel_docsigned.disabled=false;	
	document.forms[0].txtdocsignatoryname.readOnly=false;
	disableCommandButtons(true,false,false,true,true,true);
}

function doSave()
{	
	if(document.forms[0].txtdocname.value=="")
	{
		ShowAlert('121','Document Taken');
		return;
	}
	if(document.forms[0].sel_type_applicant.value=="" || document.forms[0].sel_type_applicant.value=="0")
	{
		ShowAlert('111','Applicant Type');
		document.forms[0].sel_type_applicant.focus();
		return;
	}	
	document.forms[0].hid_apptype.value = document.forms[0].sel_type_applicant[document.forms[0].sel_type_applicant.selectedIndex].text;
	document.forms[0].hidBeanId.value="Register";
	document.forms[0].hidSourceUrl.value="/action/document_register.jsp";
	document.forms[0].hidBeanMethod.value="updateDocumentRegister";
	document.forms[0].hidBeanGetMethod.value="getDocumentRegister";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getDocumentRegister";
		document.forms[0].hidBeanId.value="Register";
		document.forms[0].action=appURL+"action/document_register.jsp";	
		document.forms[0].submit();
	}	
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value="Delete";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="Register";
	document.forms[0].hidSourceUrl.value="/action/document_register.jsp";
	document.forms[0].hidBeanMethod.value="updateDocumentRegister";
	document.forms[0].hidBeanGetMethod.value="getDocumentRegister";	
	document.forms[0].submit();
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

function selectValues(val1, val2, val3, val4, val5, val6, val7, val8, val9,val10,val11)
{
   	document.forms[0].hidsno.value =val1;
	document.forms[0].txtdocaccountno.value =val2;
	document.forms[0].txtdocname.value=val3;
	document.forms[0].txtdocexecuteddate.value=val4;
	document.forms[0].txtdoccreatedby.value=val5;
	document.forms[0].txtdocsignatoryname.value=val6;
	document.forms[0].txtdocexpirydate.value=val7;
	document.forms[0].txtdocvettedby.value=val8;
	document.forms[0].txtdocdatevetted.value=val9;
	document.forms[0].sel_type_applicant.value=val10;
	document.forms[0].sel_docsigned.value=val11;
	if(document.forms[0].statusflag.value=="O" && document.forms[0].readFlag.value.toUpperCase()=="W")
	{
		disableCommandButtons(false,true,false,false,false,true);
	}
}

function disableCommandButtons(cmdedit,cmdsave,cmdcancel,cmddelete,cmdmask,cmdclose)
{
	document.forms[0].cmdedit.disabled=cmdedit;
	document.forms[0].cmddelete.disabled=cmddelete;
	document.forms[0].cmdsave.disabled=cmdsave;
	document.forms[0].cmdcancel.disabled=cmdcancel;
	document.forms[0].cmdclose.disabled=cmdclose;	
	document.forms[0].cmdmask.disabled=cmdmask;	
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

function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
	 {
		showCal(appURL,fname);
	 }
}

function callLink(page,bean,method)
{
	if (document.forms[0].cmdsave.disabled)
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
function doMask()
{
	
		document.forms[0].hidAction.value ="Mask";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="Register";
		document.forms[0].hidSourceUrl.value="/action/document_register.jsp";
		document.forms[0].hidBeanMethod.value="updateDocumentRegister";
		document.forms[0].hidBeanGetMethod.value="getDocumentRegister";	
		document.forms[0].submit();
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placevalues()">
<form name="frmdocumentregister" method="post" class="normal">
<lapschoice:monitortag pageid="5" />
<table width="100%" border="0" cellpadding="5" cellspacing="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td class="page_flow">Home -&gt;Monitoring -&gt;Monitoring Register-&gt; Document Register</td>
			</tr>
		</table>
		</td>
				</tr>
			</table>
		<lapschoice:Monitor strSource="MREG"/>
		<br>
		<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
					<tr>
						<td>						
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                      <tr> 
                        <td>Applicant Type</td>
                        <td>						
					<select name="sel_type_applicant" tabindex="1">
				<option value="0">---Select-----</option>
				<%String apptype="44"; %>
				<lapschoice:StaticDataNewTag apptype='<%=apptype%>'/> 
			  </select>                        
                        </td>
                        <td  width="14%">Document Taken<span class="mantatory">*&nbsp;</span></td>
                        <td  width="34%">
                          <input type="text" name="txtdocname" onKeyPress="" maxlength="10" >
                        </td>
                      </tr>
                      <tr> 
                        <td  width="18%">Name of Signatory</td>
                        <td  width="34%"> 
                          <input type="text"
									name="txtdocsignatoryname" tabindex="2" maxlength="50"
									onKeyPress="notAllowSplChar()">
                        </td>
                        <td  width="18%">Date of Document</td>
                        <td  width="34%"> 
                          <table width="43%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                            <tr> 
                              <td>
                                <input type="text" size="13" name="txtdocexecuteddate" >
                              </td>
                              
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td  width="14%">Created By</td>
                        <td  width="34%">
                          <input type="text"
									name="txtdoccreatedby" maxlength="45" onKeyPress="notAllowSplChar()"
									value="">
                        </td>
                        <td  width="18%">Expiry Date</td>
                        <td  width="34%"> 
                          <table width="43%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                            <tr> 
                              <td>
                                <input type="text" name="txtdocexpirydate" size="13" value="" >
                              </td>                             
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td  width="14%">Vetted By</td>
                        <td  width="34%">
                          <input type="text"
									name="txtdocvettedby" onKeyPress="notAllowSplChar()"
									value="">
                        </td>
                        <td  width="18%">Vetted Date</td>
                        <td  width="34%"> 
                          <table width="53%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                            <tr> 
                              <td width="53%"> 
                                <input type="text" name="txtdocdatevetted" size="13"
											value="">                                
                              </td>
                              <td width="47%"><a alt="Select date from calender" href="#" 
																	onClick="callCalender('txtdocdatevetted')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border="0" alt="Select date from calender"></a> 
                              </td>
                            </tr>
                          </table>
                          </td>
                      </tr>
                      <tr>
                        <td  width="14%">Whether Signatory signed 
                          the document</td>
                        <td  width="34%">
                          <select name="sel_docsigned" tabindex="3">
                            <option value="0">--select --</option>
                            <option value="1">Yes</option>
                            <option value="2">No</option>
                          </select>
                        </td>
                        <td  width="18%">&nbsp;</td>
                        <td  width="34%">&nbsp;</td>
                      </tr>
                    </table>
						</td>
					</tr>
					
						</table>
						<br>
						<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail_Mask' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
						<br>

						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
							<tr>
								<td>
								<table width="98.3%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
									<tr class="dataheader">
										<td width="3%" align="center"></td>
										<td width="13%" align="center"><b>DocumentTaken</b></td>
										<td width="14%" align="center"><b>Signatory Name</b></td>
										<td width="14%" align="center"><B>Date of Document</B></td>
										<td width="14%" align="center"><B> Created by</B></td>
										<td width="14%" align="center"><b>Expiry Date</b></td>
										<td width="14%" align="center"><b>Vetted By</b></td>
										<td width="14%" align="center"><b>Vetted Date</b></td>
									</tr>
								        <%
										arrCol=new ArrayList();
									
										if(arrRow!=null && arrRow.size()>0)
										{
 							    			for(int i=0;i<arrRow.size();i++)
											{
 							    				arrCol=(ArrayList)arrRow.get(i);%>
                              <tr>										
                                <td width="3%" align="center"> 
                                  <input type="radio"
											style="border:none" name="radiobutton" value="radiobutton"
											onClick="javascript:selectValues(
												'<%=Helper.correctNull((String)arrCol.get(0))%>',
												'<%=Helper.correctNull((String)arrCol.get(1))%>',
												'<%=Helper.correctNull((String)arrCol.get(2))%>',
												'<%=Helper.correctNull((String)arrCol.get(3))%>',
												'<%=Helper.correctNull((String)arrCol.get(4))%>',
												'<%=Helper.correctNull((String)arrCol.get(5))%>',
												'<%=Helper.correctNull((String)arrCol.get(6))%>',
												'<%=Helper.correctNull((String)arrCol.get(7))%>',
												'<%=Helper.correctNull((String)arrCol.get(8))%>',
												'<%=Helper.correctNull((String)arrCol.get(9))%>',
												'<%=Helper.correctNull((String)arrCol.get(10))%>')">
											
                                          </td>										
                                <td width="13%" >&nbsp;<%=Helper.correctNull((String)arrCol.get(2))%></td>										
                                <td width="14%" >&nbsp;<%=Helper.correctNull((String)arrCol.get(5))%></td>										
                                <td width="14%" >&nbsp;<%=Helper.correctNull((String)arrCol.get(3))%></td>										
                                <td width="14%" >&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%></td>										
                                <td width="14%" >&nbsp;<%=Helper.correctNull((String)arrCol.get(6))%></td>										
                                <td width="14%" >&nbsp;<%=Helper.correctNull((String)arrCol.get(7))%></td>										
                                <td width="14%" >&nbsp;<%=Helper.correctNull((String)arrCol.get(8))%></td>
									</tr>
									<%
									}
									}
									%>
									<tr class="datagrid">										
                                <td width="3%" align="center">&nbsp;</td>										
                                <td width="13%" >&nbsp;</td>										
                                <td width="14%" >&nbsp;</td>										
                                <td width="14%" >&nbsp;</td>										
                                <td width="14%" >&nbsp;</td>										
                                <td width="14%" >&nbsp;</td>										
                                <td width="14%" >&nbsp;</td>										
                                <td width="14%" >&nbsp;</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidsno" >
<input type="hidden" name="txtdocaccountno">
<input type="hidden" name="hid_apptype">
<input type="hidden" name="hidkeyid" value ="<%=Helper.correctNull((String)hshValues.get("strcbsaccno")) %>">

</form>
</body>
</html>
