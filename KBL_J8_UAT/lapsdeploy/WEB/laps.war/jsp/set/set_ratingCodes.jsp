<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) 
{
	hshValues = (java.util.HashMap) objValues;	
}
ArrayList g1 =  new ArrayList();
%>
<html>
<head>
<title>Personal - Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";

function callonLoad()
{		
	disablefields(true);
	enableButtons(false, true, true, true, false,true);
}

function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			  document.forms[0].elements[i].value="";		  
		}		
		else if(document.forms[0].elements[i].type=="textarea")
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
			document.forms[0].elements[i].disabled=(!one);		  
		}
			
	}
}

function doSave()
	{	
		  if(document.forms[0].txt_code.value=="" )
			{
				ShowAlert(111,"the Rating code");
				document.forms[0].txt_code.focus();
				return false;
			}
		  if(document.forms[0].txt_desc.value=="" )
			{
				ShowAlert(111,"the Description");
				document.forms[0].txt_desc.focus();
				return false;
			}
		  document.forms[0].cmdsave.disabled = true;
			document.forms[0].hidRecordflag.value=varRecordFlag;
			document.forms[0].hidBeanId.value="staticdata";
			document.forms[0].hidBeanMethod.value="updateRatingCode";
			document.forms[0].hidBeanGetMethod.value="getRatingCode";
			document.forms[0].hidSourceUrl.value="/action/set_ratingCodes.jsp";
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
		document.forms[0].hidBeanGetMethod.value="getRatingCode";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].action=appURL+"action/set_ratingCodes.jsp";	
		document.forms[0].submit();
	}
}

function doNew() 
{
	ClearFields();
	document.forms[0].hidAction.value="insert";
   	enableButtons(true, true, false, false, true,true);
   	disablefields(false);   	
}

function doEdit() 
{
    document.forms[0].hidAction.value="update";
    enableButtons(true, true, false, false, true);
	disablefields(false);
}
   
function enableButtons(bool1, bool2, bool3, bool4, bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool6;
	document.forms[0].cmdclose.disabled=bool5;
}

function selectValues(val0,val1,val2)
{
	document.forms[0].txt_code.value=val1;
	document.forms[0].hidsno.value=val0;
	document.forms[0].txt_desc.value=val2;
    enableButtons(true, false, true, false, true,false);
}
function doDelete()
{
	document.forms[0].hidAction.value="delete";
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanMethod.value="updateRatingCode";
	document.forms[0].hidBeanGetMethod.value="getRatingCode";
	document.forms[0].hidSourceUrl.value="/action/set_ratingCodes.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad()">
<form class="normal" name="appform" method="post" action="">
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt; Setup  -&gt; Rating -&gt; Rating Codes</td></tr>
</table>
<br>
<table class="outertable border1 tableBg" width="50%" border="0" cellpadding="5" cellspacing="0" align="center">
	 <tr> 
      <td valign="top">       
              <table class="outertable" border="0" cellspacing="0" cellpadding="0" width="100%">
                <tr> 
                  <td valign="top"> 
                    <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="1">
                      <tr> 
                        <td width="69%" valign="top"> 
                          <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="3">
                            <tr> 
                              <td> 
                                <table class="outertable" width="50%" border="0" cellspacing="0" cellpadding="5" align="center">
                                  <tr valign="middle"> 
                                    <td width="9%" nowrap>Rating Code</td>
                                    <td width="45%"> &nbsp; 
                                      <input type="text" name="txt_code" size="25" maxlength="49" onKeyPress="" value="">
                                    </td>
                                     <td width="9%" nowrap>Description</td>
                                     <td width="45%"> &nbsp; 
                                      <input type="text" name="txt_desc" size="25" align="right" >
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
                            <br>
                                  <lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
                                  <br>                                
                                <table class="outertable" width="60%" border="0" cellspacing="0" cellpadding="0" align="center">
                                  <tr> 
                                    <td valign="top" align="center"> 
                                      <table class="outertable linebor" width="50%" border="0" cellspacing="0" cellpadding="3">
                                        <tr class="dataheader"> 
                                          <td width="3%" >&nbsp;</td>
                                          <td width="3%" align="center" nowrap><b>S No.</b></td>
                                          <td width="40%" align="center"><b>Rating Code</b></td>
                                          <td width="40%" align="center"><b>Description</b></td>
                                        </tr>
                                      <% 
						 				ArrayList	v = (ArrayList) hshValues.get("vecRow");
										String inside="N";
										if(v!=null)
										{					
											int vecsize =v.size();
											for(int l=0;l<vecsize;l++)
											{	
												inside="Y";
												g1 = (ArrayList)v.get(l);
												%>
                                          <tr class="datagrid"> 
                                            <td width="3%"> 
                                              <input type="radio" name="radiobutton" value="radiobutton" style="border-style:none"  onClick="selectValues('<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(1))%>','<%=Helper.correctNull((String)g1.get(2))%>')">
                                            </td>
                                            <td width="3%" ><%=Helper.correctNull((String)g1.get(0))%></td>
                                            <td width="35%" align="left"><%=Helper.correctNull((String)g1.get(1))%></td>
                                            <td width="40%" align="left"><%=Helper.correctNull((String)g1.get(2))%></td>
                                          </tr>
                                          <%}}%>
                                           <tr class="datagrid"> 
                                           <td width="3%">&nbsp; </td>
                                            <td width="3%">&nbsp; </td>
                                            <td width="40%">&nbsp; </td>
                                            <td width="40%">&nbsp; </td>
                                          </tr>
                                           <tr class="datagrid">
                                           <td width="3%">&nbsp; </td>  
                                          <td width="3%">&nbsp; </td>
                                            <td width="40%">&nbsp; </td>
                                            <td width="40%">&nbsp; </td>
                                          </tr>
                                          <%                                      
                                          if(inside=="N")
                                          {%>
													 <tr class="datagrid"> 
													 <td width="3%">&nbsp; </td>
														<td width="3%">&nbsp;</td>
														<td width="40%">&nbsp; </td>
														<td width="40%">&nbsp; </td>
													</tr>
												<tr class="datagrid"> 
													 <td width="3%">&nbsp; </td>
														<td width="3%">&nbsp;</td>
														<td width="40%">&nbsp; </td>
														<td width="40%">&nbsp; </td>
													</tr>
													<tr class="datagrid"> 
													 <td width="3%">&nbsp; </td>
														<td width="3%">&nbsp;</td>
														<td width="40%">&nbsp; </td>
														<td width="40%">&nbsp; </td>
													</tr>
													<tr class="datagrid"> 
													 <td width="3%">&nbsp; </td>
														<td width="3%">&nbsp;</td>
														<td width="40%">&nbsp; </td>
														<td width="40%">&nbsp; </td>
													</tr>
												<%}%>
                                        </table></td></tr></table>
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type ="hidden" name ="hidkeyid" value="set">
  <input type="hidden" name="org_code" value ="<%=session.getAttribute("strOrgCode")%>" >
  <input type="hidden" name="strOrgCode" value ="<%=session.getAttribute("strOrgCode")%>" >
  <input type="hidden" name="hidsno" value="0">
   <iframe height="0" width="0" id="ifrm" frameborder=0 style="border:0"></iframe> 
<br> 
</form>
</body>
</html>
