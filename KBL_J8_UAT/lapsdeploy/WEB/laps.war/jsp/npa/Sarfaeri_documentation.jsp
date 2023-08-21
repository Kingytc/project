<%@include file="../share/directives.jsp"%>
<%
ArrayList vecRow=(ArrayList)hshValues.get("arrRow");
ArrayList vecCol=new ArrayList();	
java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);
%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/link.css" type="text/css"/>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
function disableCommandButtons(cmdedit,cmddelete,cmdsave,cmdcancel,cmdclose)
{
	document.forms[0].cmdedit.disabled=cmdedit;
	document.forms[0].cmddelete.disabled=cmddelete;
	document.forms[0].cmdsave.disabled=cmdsave;
	document.forms[0].cmdcancel.disabled=cmdcancel;	
	document.forms[0].cmdclose.disabled=cmdclose;
}
function selectValues(val1,val2,val3,val4,val5,val6,val7)
{
	
	document.forms[0].hid_strsno.value=val1;
	document.forms[0].txt_documentname.value=val2;
	document.forms[0].txt_documentdate.value=val3;
	document.forms[0].txt_expirydocumentdate.value=val4;
	document.forms[0].doc_enforce.value=val5;
	document.forms[0].txt_certificationdate.value=val6;
	document.forms[0].sel_field.value=val7;
	if(document.forms[0].readFlag.value.toUpperCase()=="W" && document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		disableCommandButtons(false,false,true,true,false);
	}
}
function doNew()
{
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidmoduletype.value="SARFI";
	disableCommandButtons(true,true,false,false,true);
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	document.forms[0].hidmoduletype.value="SARFI";
	disableCommandButtons(true,true,false,false,true);	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/Sarfaeri_documentation.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanGetMethod.value="getSarfaesiDocument";
		document.forms[0].hidBeanMethod.value="updateSarfaesiDocument";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 		
	}	
	
	disableCommandButtons(false,true,true,true,false);
}

function doSave()
{	
		if(document.forms[0].txt_documentname.value=="")
		{
		ShowAlert('121', 'Document Name');
		return;
		}
		document.forms[0].hidSourceUrl.value="/action/Sarfaeri_documentation.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanMethod.value="updateSarfaesiDocument";
		document.forms[0].hidBeanGetMethod.value="getSarfaesiDocument";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/Sarfaeri_documentation.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanMethod.value="updateSarfaesiDocument";
		document.forms[0].hidBeanGetMethod.value="getSarfaesiDocument";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}
	}	
	document.forms[0].txt_documentdate.readOnly=true;
	document.forms[0].txt_expirydocumentdate.readOnly=true;
	document.forms[0].txt_certificationdate.readOnly=true;
	document.forms[0].txt_documentname.readOnly=true;	
}
function onLoading()
{		
	disableCommandButtons(true,true,true,true,true,false);
}
function doClose()
	{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/npa_mainlinknav.jsp";
		document.forms[0].submit();		
	}
}	
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);		
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
</script>
</head>
<body onload="onLoading()">
<form name="safaeri2" method="post" class="normal">
<lapstab:sarfiurltag pageid="8"/>					
<span class="page_flow">Home -&gt; NPA-&gt; Sarfaesi Proposal -&gt; Documentation 
<lapschoice:npaapplication />
<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />
<br>
<table width="70%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
<tr>
<td>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable linebor">
    <tr class="dataheader"> 
      <td colspan="4" align="center"><b>Documentation</b></td>
    </tr>
    <tr class="datagrid"> 
      <td width="24%">DOCUMENT NAME</td>
      <td width="23%"> &nbsp;
        <input type="text" name="txt_documentname" size="30"
				maxlength="25" tabindex="22" 
				value="" class="interfacefields">
      </td>
      <td width="29%">WHETHER DOCUMENTS ARE ENFORCEABLE</td>
      <td width="24%"> &nbsp;
        <SELECT NAME="doc_enforce" TABINDEX="6">
									
                      <OPTION VALUE="1" SELECTED>---SELECT---</OPTION>
                      <OPTION VALUE="2">YES</OPTION>
                      <OPTION VALUE="3">NO</OPTION>                      
                    </SELECT></td>
    </tr>
    <tr class="datagrid"> 
      <td width="24%" >DATE OF DOCUMENTATION</td>
      <td  width="23%">&nbsp; 
        <input type="text" name="txt_documentdate" size="12"
				maxlength="10" tabindex="22" 
				value="" onBlur="checkDate(this)">
        <a href="#" onClick="callCalender('txt_documentdate')"
				title="Click to view calender" border=0><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="23"></a> </td>
      <td  width="29%">DATE OF CERTIFICATION</td>
      <td  width="24%">&nbsp; 
        <input type="text" name="txt_certificationdate" size="15"
				maxlength="10" tabindex="5" 
				value="" onBlur="checkDate(this)">
        <a href="#" onClick="callCalender('txt_certificationdate')"
				title="Click to view calender" border=0><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="6"></a> </td>
    </tr>
    <tr class="datagrid"> 
      <td width="24%" >EXPIRY DATE OF DOCUMENT</td>
      <td  width="23%">&nbsp; 
        <input type="text" name="txt_expirydocumentdate" size="15"
				maxlength="10" tabindex="7" 
				value="" onBlur="checkDate(this)">
        <a href="#" onClick="callCalender('txt_expirydocumentdate')"
				title="Click to view calender" border=0><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="8"></a> </td>
      <td  width="29%">TYPE OF DOCUMENT</td>
      <td  width="24%"> &nbsp;
        <SELECT NAME="sel_field" TABINDEX="9">									
                      <OPTION VALUE="1" SELECTED>---SELECT---</OPTION>
                      <OPTION VALUE="2">CHARGE</OPTION>
                      <OPTION VALUE="3">HYPOTHECATION</OPTION>
                      <OPTION VALUE="4">MORTGAGE</OPTION>                      
                    </SELECT>
      </td>
    </tr>
  </table>
  </td>
  </tr>
  </table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
                      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
                        <tr> 
                          <td valign="top">                              
                <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">                 
                  <tr class="dataheader"> 
                    <td width="3%" >&nbsp;</td>
                    <td width="14%"  align="center">DOCUMENT NAME</td>
                    <td width="15%"  align="center">DATE OF DOCUMENTATION</td>
                    <td width="23%"  align="center">EXPIRY DATE OF DOCUMENT</td>
                    <td width="16%"  align="center">WHETHER DOCUMENTS ARE ENFORCEABLE</td>
                    <td width="13%"  align="center"> DATE OF CERTIFICATION</td>
                    <td width="16%"  align="center">TYPE OF DOCUMENT</td>
                  </tr>
                  <%vecRow=(ArrayList)hshValues.get("arrRow");
					if(vecRow!=null && vecRow.size()>0)
					{
						for(int i=0;i<vecRow.size();i++)
						{
						vecCol = (ArrayList)vecRow.get(i);
						//System.out.println("==========>"+vecCol);%>
                  <tr class="datagrid"> 
                    <td width="3%" align=center>
                      <input type="radio" style="border:none" name="radiobutton" value="radiobutton"
													onClick="selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
													'<%=Helper.correctNull((String)vecCol.get(1))%>','<%=Helper.correctNull((String)vecCol.get(2))%>',
													'<%=Helper.correctNull((String)vecCol.get(3))%>','<%=Helper.correctNull((String)vecCol.get(4))%>',
                            	'<%=Helper.correctNull((String)vecCol.get(5))%>','<%=Helper.correctNull((String)vecCol.get(6))%>')">
                            
                  </td>                   
                    <td width="14%">&nbsp;<%=Helper.correctNull((String)vecCol.get(1))%></td>
                    <td width="15%">&nbsp;<%=Helper.correctNull((String)vecCol.get(2))%></td>
                    <td width="23%">&nbsp;<%=Helper.correctNull((String)vecCol.get(3))%></td>
                    <%
						String enfor="";
                    String enforce=Helper.correctNull((String)vecCol.get(4));
						if(!enforce.equalsIgnoreCase("null"))
						{
							if(enforce.equalsIgnoreCase("1"))
							{
								enfor="";
							}
							if(enforce.equalsIgnoreCase("2"))
							{
								enfor="YES";
							}
							if(enforce.equalsIgnoreCase("3"))
							{
								enfor="NO";
							}
						}%>
                    <td width="16%">&nbsp;<%=enfor%></td>
                    <td width="13%" >&nbsp;<%=Helper.correctNull((String)vecCol.get(5))%></td>
					<%String typ="";
						String type=Helper.correctNull((String)vecCol.get(6));
						if(!type.equalsIgnoreCase("null"))
						{
							if(type.equalsIgnoreCase("2"))
							{
								typ="CHARGE";
							}
							if(type.equalsIgnoreCase("3"))
							{
								typ="HYPOTHECATION";
							}
							if(type.equalsIgnoreCase("4"))
							{
								typ="MORTGAGE";
							}
						}%>
                    <td width="16%">&nbsp;<%=typ%></td>
                  </tr>
                  <%}}else{%>
                  <tr class="datagrid"> 
                    <td align="center" colspan="9">No Data Found</td>
                  </tr>
                  <%}%>
                </table>
                          </td>
                        </tr>
                      </table>                   
    <lapschoice:hiddentag pageid='<%=PageId%>'/>            
<input type="hidden" name="hid_strsno" value=""/>
</form>
</body>
</html>