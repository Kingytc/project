<%@include file="../share/directives.jsp"%>
<%ArrayList arryCol = null;
			ArrayList arryRow = (ArrayList) hshValues.get("arryRow");
%>
<html>
<head>
<title>LAPS -Assesment Form Details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var id ="";
var apptype="";

var currentDate = "<%=Helper.getCurrentDateTime()%>";
var  strid="<%=Helper.correctNull((String)hshValues.get("strid"))%>";
var  strAction="<%=Helper.correctNull((String)hshValues.get("strAction"))%>";

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/retailpge.jsp";	
		document.forms[0].submit();
	}
}

function disableFields(one)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
	}	
}

function doSave()
{	
   
	enableButtons( true, true, false, true, true);	
	document.forms[0].hidAction.value ="insert";
    document.forms[0].hidBeanId.value="agrpoultry";
	document.forms[0].hidSourceUrl.value="/action/agr_layerflockrep.jsp";
	document.forms[0].hidBeanMethod.value="updateagrflock";
	document.forms[0].hidBeanGetMethod.value="getagrflock";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{
 	disableFields(false);
     document.forms[0].hideditflag.value ="Y";
	 document.forms[0].hidAction.value ="insert";
     enableButtons(true, false, false, false, true);	
}

function callhelp()
{
	var varQryString = appURL+"/jsp/perhlp/hlp_edueducational.jsp"
	var title = "ApplicantDemographics";
	var prop = "scrollbars=no,width=600,height=450";	
	prop = prop + ",left=200,top=150";
	window.open(varQryString,title,prop);
}
 
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agrpoultry";
		document.forms[0].hidBeanGetMethod.value="getagrflock";
		document.forms[0].action=appURL+"action/agr_layerflockrep.jsp";
		document.forms[0].submit(); 		
	}

}

function doDelete()
{
if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appURL+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updateagrflock";
	document.forms[0].hidBeanId.value="agrpoultry";
	document.forms[0].hidSourceUrl.value="action/agr_layerflockrep.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();	
	}	
}

function onloading()
{	  
	disableFields(true);
}

function enableButtons( bool2, bool3, bool4, bool5, bool6)
{	
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading()">
<form name="frmpri" method="post" class="normal"> 
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
        <tr> 
          <td> 
            <table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
              <tr> 
                <td> 
                  <table width="90%" border="0" cellspacing="0" cellpadding="1" class="outertable border1" align="center">
                    <tr> 
                      <td colspan="13"> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                          <tr> 
                            <td valign="top"> 
                              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                                <tr> 
                                  <td>&nbsp;</td>
                                </tr>
                                <tr> 
                                  <td> 
                                    <table width="99%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
                                      <tr class="dataheader"> 
                                        <td width="9%" align="center" nowrap="nowrap">Project Year</td>
                                        <td colspan="5" align="center">Replacement Particulars</td>
                                      </tr>
                                      <tr class="dataheader"> 
                                        <td align="center">&nbsp;</td>
                                        <td width="16%" align="center" nowrap>No.of 
                                          Batches of chicks purchased</td>
                                        <td width="19%" align="center">No.of 
                                          Brooder batches</td>
                                        <td width="12%" align="center">No.of 
                                          Grower batches</td>
                                        <td width="14%" align="center">No.of 
                                          Layer batches</td>
                                        <td width="30%" align="center">No.of 
                                          culls</td>
                                      </tr>
                                      <%for (int i = 1; i <9; i++) {
				if (arryRow != null && arryRow.size() >= i) {
					arryCol = (ArrayList) arryRow.get(i - 1);
					%>
                                      <tr align="center"> 
                                        <td><%=i%> 
                                          year </td>
                                        <td>
                                          <input type="text" name="txt_batch"
									value="<%=arryCol.get(1)%>" size="15" maxlength="15" onKeyPress="allowInteger()">
                                        </td>
                                        <td>
                                          <input type="text" name="txt_broodermon" maxlength="3"
									value="<%=arryCol.get(2)%>" size="15" onKeyPress="allowInteger()">
                                        </td>
                                        <td>
                                          <input type="text" name="txt_growermon" size="15" maxlength="3"
									value="<%=arryCol.get(3)%>" onKeyPress="allowInteger()">
                                        </td>
                                        <td>
                                          <input type="text" name="txt_layermon" size="15" maxlength="3"
									value="<%=arryCol.get(4)%>" onKeyPress="allowInteger()"
									>
                                        </td>
                                        <td>
                                          <input type="text" name="txt_culls" size="15" maxlength="3"
									value="<%=arryCol.get(5)%>" onKeyPress="allowInteger()"
									>
                                        </td>
                                      </tr>
                                      <%} else {
					%>
                                      <tr align="center"> 
                                        <td><%=i%> 
                                          year</td>
                                        <td>
                                          <input type="text" name="txt_batch" size="15" maxlength="3" onKeyPress="allowInteger()">
                                        </td>
                                        <td>
                                          <input type="text" name="txt_broodermon" size="15" maxlength="3" onKeyPress="allowInteger()">
                                        </td>
                                        <td>
                                          <input type="text" name="txt_growermon" size="15" maxlength="3" onKeyPress="allowInteger()">
                                        </td>
                                        <td>
                                          <input type="text" name="txt_layermon" size="15" maxlength="3"
									  onKeyPress="allowInteger()">
                                        </td>
                                        <td>
                                          <input type="text" name="txt_culls" size="15" maxlength="3"
									onKeyPress="allowInteger()">
                                        </td>
                                      </tr>
                                      <%}//end of else
			}//end of for statement
			%>
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
<br/>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' /> 
<lapschoice:agrihiddentag pageid="<%=PageId%>"/>
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("auditFlag"))%>">
</form>
</body>
</html>
