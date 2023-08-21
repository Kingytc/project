<%@ include file="../share/directives.jsp"%>
<%
ArrayList v = new ArrayList();
v = (ArrayList) hshValues.get("vecRow");
ArrayList g1 = new ArrayList();
%>
<html>
<head>
<title>Setup-State</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
DIV.cellContainer 
{	
  width: 100%; height: 150;
  overflow: auto;
}
</style>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var mode ="load";
var appURL ="<%=ApplicationParams.getAppUrl()%>";

function onloading()
{	 
   	disableFields(true);
	disableCommandButtons("load");
	document.forms[0].hidAction.value ="";
}
function selectValues(val1, val2, val3, val4, val5)
{
  	document.forms[0].txt_value.value = val1;
	document.forms[0].hidslno.value = val2;
	document.forms[0].txt_acronym.value = val3;
	document.forms[0].txt_acctype.value = val4;
	document.forms[0].sel_loantype.value = val5;
	
	document.forms[0].cmdedit.disabled=false;
	document.forms[0].cmdnew.disabled =true;
	document.forms[0].cmdcancel.disabled=true;
	document.forms[0].cmddelete.disabled=false;
}
function disableFields(val)
 {
  for(var i=0;i<document.forms[0].length;i++)
  {
	  if(document.forms[0].elements[i].type=='text')
	  {
		document.forms[0].elements[i].readOnly=val;
	  }
	  if(document.forms[0].elements[i].type=='radio')
	  {
		document.forms[0].elements[i].disabled=(!val);
	  }		
 }
}
 
  function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdnew.disabled =false;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}
	if(val=="edit")
	{
		 disableFields(false);
		 document.forms[0].cmdnew.disabled =true;
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	
         
	}
	if(val=="radioselect")
	{	 
		document.forms[0].cmdnew.disabled =false;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
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
}  
 

function clearfields()
{
	document.forms[0].txt_value.value="";
	document.forms[0].txt_acronym.value="";
	document.forms[0].txt_acctype.value="";
	document.forms[0].sel_loantype.value="0";
}
function doSave()
 {
	 if(document.forms[0].sel_loantype.value == "0"){
		 alert("Select Loan Type");
		 return;
	 }
	 document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidBeanId.value="setstatecity"
		document.forms[0].hidBeanMethod.value="updateCibilDetails";
		document.forms[0].hidBeanGetMethod.value="getDataCibilDetails";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/set_cibilinterface.jsp";
		document.forms[0].submit();
 }

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="Update";
	disableCommandButtons("edit");
}

function doNew()
{
	disableFields(true);
	disableCommandButtons("edit");		
	document.forms[0].hidAction.value ="insert";
	clearfields();
}

 function doCancel()
  {
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="setstatecity"
		document.forms[0].hidBeanGetMethod.value="getDataCibilDetails";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/set_cibilinterface.jsp";
		document.forms[0].submit();
	}
 }
 
function doDelete()
{
if (ConfirmMsg("101"))
	{
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="setstatecity"
		document.forms[0].hidBeanMethod.value="updateCibilDetails";
		document.forms[0].hidBeanGetMethod.value="getDataCibilDetails";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/set_cibilinterface.jsp";
 		document.forms[0].submit();
	}
	
}
 
 function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/interfacenav.jsp";
		document.forms[0].submit();
	}
}
 
 
 
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>


<body onLoad="onloading()" >
<form name="workfrm" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr>
            <td valign="top" class="page_flow">Home 
              -&gt; Setup -&gt; Interface -&gt; 
              CIBIL Interface </td>
          </tr>
        </table>		
      </td>
    </tr>
 </table>
  
  <table width="47%" border="0" cellspacing="0" cellpadding="15" align="center" class="outertable border1">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1">
          <tr> 
            <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="0" height="8" align="center" class="outertable">
                <tr> 
                  <td height="7"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                      <tr> 
                        <td colspan="4" height="2"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                            <tr> 
                              <td colspan="10"> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" height="67" class="outertable">
                                  <tr> 
                                    <td> 
                                      <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                                        <tr> 
                                          <td class="dataheader" colspan="2"><b><i>CIBIL Interface</i></b></td>
                                        </tr>
                                        <tr> 
                                          <td colspan="2"> 
                                            <table width="100%" border="0" cellspacing="0" cellpadding="10" class="outertable">
                                              <tr> 
                                                <td>Value</td>
                                                <td> 
                                                  <input type="text" name="txt_value" value=""  onKeyPress="notAllowSplChar();allowInteger();" maxlength="4" size="35" >
                                                </td>
                                              </tr>
                                              <tr> 
                                                <td>Acronym</td>
                                                <td> 
                                                  <input type="text" name="txt_acronym" value="" maxlength="20"  onKeyPress="notAllowSplChar();notAllowSplChar();" size="35" >
                                                </td>
                                              </tr>
                                              <tr> 
                                                <td>Account Type</td>
                                                <td><input type="text" name="txt_acctype" value="" maxlength="200"  onKeyPress="notAllowSplChar();notAllowSplChar();" size="35" ></td>
                                              </tr>
                                              <tr> 
                                                <td>Loan Type <span class="mantatory">*</span></td>
                                                <td>
												<select name="sel_loantype">
												<option value="0" selected>---Select---</option>
												<option value="1">Secured</option>
                     							<option value="2">Unsecured</option>
												</select>
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
<lapschoice:combuttonnew btnnames="New_Edit_Save_Delete_Cancel_Audit Trail"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
							<br>
  <table width="60%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
    <tr>
		<td>
        <table width="96.7%" border="0" cellspacing="1" cellpadding="0" class="outertable">
          <tr class="dataheader"> 
            <td width="6%" align="center">&nbsp;</td>
            <td width="30%" align="center"><b>Acronym</b></td>
            <td width="30%" align="center"><b>Account Type</b></td>
			 <td width="30%" align="center"><b>Loan Type</b></td>
                                  </tr>
                                </table>
										</td>
									</tr>
									<tr>
										
                              <td width="11%"> 
                                <div class="cellcontainer">
                                  <table width="100%" border="0" cellspacing="3" cellpadding="3" class="outertable">
                                    
                                     <%
			String inside = "N";
			if (v != null) {
				int vecsize = v.size();
				for (int l = 0; l < vecsize; l++) {
					g1 = (ArrayList) v.get(l);
					String Strloan_type= Helper.correctNull((String)g1.get(4));
					if(Strloan_type.equalsIgnoreCase("1"))
					{
						Strloan_type="Secured";
					}
					else
					{
						Strloan_type="Unsecured";
					}
					%>
                                    <tr class="datagrid"> 
             <td width="6%" align="center"> 
					<input type="radio" name="rdoUser" style="border-style:none" 
					onClick="selectValues('<%=Helper.correctNull((String)g1.get(0))%>',
                   						  '<%=Helper.correctNull((String)g1.get(1))%>',
                   						  '<%=Helper.correctNull((String)g1.get(2))%>',
                   						  '<%=Helper.correctNull((String)g1.get(3))%>',
                   						  '<%=Helper.correctNull((String)g1.get(4))%>')">
              </td>
              <td width="30%" align="left"><%=Helper.correctNull((String)g1.get(2))%></td>
              <td width="30%" align="left"><%=Helper.correctNull((String)g1.get(3))%></td>
			  <td align="left" width="30%"><%=Strloan_type%></td>
                                    </tr>
                                    <%}
			}%>
                                   
                                    <tr class="datagrid"> 
              <td align="center" width="6%">&nbsp;</td>
              <td align="left" width="30%">&nbsp;</td>
              <td align="left" width="30%">&nbsp;</td>
              <td align="center" width="30%">&nbsp;</td>
                                    </tr>
                                     <tr class="datagrid"> 
              <td align="center" width="6%">&nbsp;</td>
              <td align="left" width="30%">&nbsp;</td>
              <td align="left" width="30%">&nbsp;</td>
              <td align="center" width="30%">&nbsp;</td>
                                    </tr>
                                     <tr class="datagrid"> 
              <td align="center" width="6%">&nbsp;</td>
              <td align="left" width="30%">&nbsp;</td>
              <td align="left" width="30%">&nbsp;</td>
              <td align="center" width="30%">&nbsp;</td>
                                    </tr>
                                     <tr class="datagrid"> 
              <td align="center" width="6%">&nbsp;</td>
              <td align="left" width="30%">&nbsp;</td>
              <td align="left" width="30%">&nbsp;</td>
              <td align="center" width="30%">&nbsp;</td>
                                    </tr>
                                     <tr class="datagrid"> 
              <td align="center" width="6%">&nbsp;</td>
              <td align="left" width="30%">&nbsp;</td>
              <td align="left" width="30%">&nbsp;</td>
              <td align="center" width="30%">&nbsp;</td>
                                    </tr>
                                  </table>
										</div>
										</td>
									</tr>
								</table>
								<br>

<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidslno" >
<input type="hidden" name="hidstatecode" >
<input type ="hidden" name ="hidkeyid" value="set">
</form>
<br>
</body>
</html>