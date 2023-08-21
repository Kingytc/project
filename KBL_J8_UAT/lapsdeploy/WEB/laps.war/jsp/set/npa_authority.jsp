<%@include file="../share/directives.jsp"%>

 <% 
 String strWrkflowtype=Helper.correctNull((String)request.getParameter("wrk_flowtype"));
 if(strWrkflowtype.equalsIgnoreCase(""))
 {
	 strWrkflowtype="w";
 }
 String prdCode=Helper.correctNull((String)request.getParameter("prd_code"));
 if(prdCode.equalsIgnoreCase(""))
 {
	 prdCode=Helper.correctNull((String)hshValues.get("npa_module"));
 }
 String npa_reject=Helper.correctNull((String)hshValues.get("npa_reject"));
 String npa_skip=Helper.correctNull((String)hshValues.get("npa_skip"));
 String npa_approve=Helper.correctNull((String)hshValues.get("npa_approve"));
%>
<html>
<head>
<title>Limit Master</title>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/set/navigate.js"></script>
<script>

var path ="<%=ApplicationParams.getAppUrl()%>";
var prdcode="<%=prdCode%>";
var approve="<%=npa_approve%>";
var reject="<%=npa_reject%>";
var skip="<%=npa_skip%>";

function showdata()
{
	if(document.forms[0].prdCode.value != "")
	{
		document.forms[0].prd_code.value = document.forms[0].prdCode.value;
		document.forms[0].action=path+"controllerservlet";
		document.forms[0].method="post";
		document.forms[0].hidBeanId.value="setproducts";		
		document.forms[0].hidBeanGetMethod.value="getNPAAuthority";
		document.forms[0].action=path+"action/npa_authority.jsp";	
		document.forms[0].submit();
	}
}

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
	}
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
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
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one' )
		  {
 				document.forms[0].elements[i].disabled=val;
		  }
		 if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}  
	}
}

function onloading()
{   
	disableCommandButtons("load");
	if(prdcode!="")
	{
		document.forms[0].prdCode.value=prdcode;
		document.forms[0].prdCode.disabled=false;
	}
	else
	{
		document.forms[0].prdCode.value="S";
		document.forms[0].prdCode.disabled=false;
	}
	if(approve!="")
	{
		document.forms[0].prd_appclass.value=approve;
	}
	else
	{
		document.forms[0].prd_appclass.value="";
	}
	if(reject!="")
	{
		document.forms[0].prd_rejclass.value=reject;
	}
	else
	{
		document.forms[0].prd_rejclass.value="";
	}
	if(skip!="")
	{
		document.forms[0].prd_skipclass.value=skip;
	}
	else
	{
		document.forms[0].prd_skipclass.value="";
	}
}

function doEdit()
{
	disableCommandButtons("edit");
}

function doSave()
{
	if(document.forms[0].prd_appclass.value=="")
	{
		alert("Select Minimum Class for Approval");
		return;
	}
	if(document.forms[0].prd_rejclass.value=="")
	{
		alert("Select MMinimum Class for Rejection");
		return;
	}
	if(document.forms[0].prd_skipclass.value=="")
	{
		alert("Select Minimum Class for Skip flowpoints");
		return;
	}
	var appclass = document.forms[0].prd_appclass.length;	
	for(i=0;i<appclass;i++)
	{
		 if(document.forms[0].prd_appclass.options[i].selected==true)
		 {
			 document.forms[0].hid_prd_appclass.value = document.forms[0].prd_appclass.options[i].text; 
			break;
		 }
	}
	
var rejclass = document.forms[0].prd_rejclass.length;	
	for(i=0;i<rejclass;i++)
	{
		 if(document.forms[0].prd_rejclass.options[i].selected==true)
		 {
			 document.forms[0].hid_prd_rejclass.value = document.forms[0].prd_rejclass.options[i].text; 
			break;
		 }
	}
	
var skipclass = document.forms[0].prd_skipclass.length;	
	for(i=0;i<skipclass;i++)
	{
		 if(document.forms[0].prd_skipclass.options[i].selected==true)
		 {
			 document.forms[0].hid_prd_skipclass.value = document.forms[0].prd_skipclass.options[i].text; 
			break;
		 }
	}
	
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidBeanId.value="setproducts";	
		document.forms[0].hidBeanGetMethod.value="updateNPAAuthority";
		document.forms[0].action=path+"action/npa_authority.jsp";	
		document.forms[0].submit();
}

function doCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidBeanId.value="setproducts";	
		document.forms[0].hidBeanGetMethod.value="getNPAAuthority";
		document.forms[0].action=path+"action/npa_authority.jsp";	
		document.forms[0].submit();
	}
}

function doClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].hidBeanId.value="";	
		document.forms[0].hidBeanGetMethod.value="";
		document.forms[0].action=path+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}


function callFlowtype(type)
{
	if(type!="w")
	{
		if (document.forms[0].prdCode.value != "")
		{
		if(!document.forms[0].cmdsave.disabled)
		{
			ShowAlert(103);
			return;
		}
		document.forms[0].method="post";
		document.forms[0].wrk_flowtype.value=type;
		document.forms[0].hidBeanGetMethod.value="getWorkflowNPA";
		document.forms[0].prd_code.value=document.forms[0].prdCode.value;	
		document.forms[0].action=path+"action/setprdworkflowcomnpa.jsp";
		document.forms[0].submit();
		}
		else
		{
			alert("select a Product To view its details");
		}
	}
}

 
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body  onload="onloading()">
<form class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">      
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td valign="bottom" class="page_flow">Home 
        -&gt; Setup -&gt; NPA -&gt; Authority </td>
      <td>&nbsp; </td>
    </tr>
  </table>
  <br/>
  <table  border="0" cellspacing="0" cellpadding="2" class="outertable">
    <tr> 
      <td align="center" >Select 
        NPA Module</td>
      <td width="49%"> 
        <select name="prdCode" onChange="showdata()">
          <option value="S" selected>-------SELECT-------</option>
          <option value="OTSCO">COMPROMISE PROPOSAL</option>
          <option value="PAWO">PRUDENTIAL WRITE OFF/ABSOLUTE WRITE OFF</option>
          <option value="SUIT">FILING OF SUIT</option>
          <option value="STAT">STATUS NOTE</option>
          <option value="SARFI">SARFAESI ACT</option>
        </select>
      </td>
    </tr>
  </table>
 <BR/>
  <table width="100%" border="0" cellspacing="0" cellpadding="5"  height="390" class="outertable">
    <tr>
      <td height="56"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center"  height="100%" class="outertable">
          <tr> 
            <td height="7" valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                <tr> 
                  <td colspan="4" height="2" valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                      <tr> 
                        <td colspan="10" valign="top"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                            <tr> 
                              <td valign="top"> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
                                  <tr> 
                                    <td> 
                                      <table width="70%" border="0" cellspacing="0" cellpadding="3"  class="outertable">
                                        <tr> 
                                          <td colspan="6"></td>
                                        </tr>
                                        <tr> 
                                          <td colspan="6"> 
                                            <table width="37%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                                              <tr > 
                                                <td width="27%" align="center" class="main_tab_inactive"<%if(strWrkflowtype.equals("p")){%>
                                                  <%}%> > <%if(strWrkflowtype.equals("p")){%>
                                                  <%}%> <b> 
                                                  <%if (!strWrkflowtype.equals("p")){%>
                                                  <a href="javascript:callFlowtype('p')" > 
                                                  <%}%>
                                                  In Process</a></b></td>
                                                <td width="35%" align="center"  class="main_tab_inactive"<%if(strWrkflowtype.equals("a")){%>
                                                 <%}%>><%if(strWrkflowtype.equals("a")){%>
                                                  <%}%><b> 
                                                  <%if (!strWrkflowtype.equals("a")){%>
                                                  <a href="javascript:callFlowtype('a')" > 
                                                  <%}%>
                                                  Post Approval </a></b></td>
                                                <td width="38%" align="center"  class="main_tab_inactive"<%if(strWrkflowtype.equals("r")){%>
                                                 <%}%>> <%if(strWrkflowtype.equals("r")){%>
                                                 <%}%><b> 
                                                  <%if (!strWrkflowtype.equals("r")){%>
                                                  <a href="javascript:callFlowtype('r')" > 
                                                  <%}%>
                                                  Post Rejection </a></b></td>
                                                <td width="38%" align="center" class="main_tab_active"<%if(strWrkflowtype.equals("w")){%>
                                                 <%}%>><%if(strWrkflowtype.equals("w")){%>
                                                 <%}%><b> 
                                                  <%if (!strWrkflowtype.equals("w")){%>
                                                  <a href="javascript:callFlowtype('w')" > 
                                                  <%}%>
                                                 Authority</a></b></td> </tr>
                                            </table>
                                          </td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td valign="top"> 
                                      <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
                                        <tr> 
                                          <td colspan="5" height="18">Select 
                                            the Class values for Approval/Rejection 
                                            and Skip</td>
                                        </tr>
                                      </table>
                                      <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable border1">
                                        <tr> 
                                          <td> 
                                            <table width="100%" border="0" cellspacing="0" cellpadding="8" align="center" class="outertable">
                                              <tr> 
                                                <td colspan="2" align ="left" valign="middle">Minimum 
                                                  Class for Approval <span class="mantatory">*</span></td>
                                                <td width="64%"> 
                                                  <select name="prd_appclass">
                                                    <option value="">----Select----</option>
                                                    <%String apptype="7"; %>
                                                    <lapschoice:StaticDataNewTag apptype='<%=apptype%>'/> 
                                                  </select>
                                                </td>
                                              </tr>
                                              <tr> 
                                                <td colspan="2" valign="middle"> 
                                                  Minimum Class for Rejection <span class="mantatory">*</span></td>
                                                <td width="64%"> 
                                                  <select name="prd_rejclass">
                                                    <option value="">----Select----</option>
                                                    <%apptype="7"; %>
                                                    <lapschoice:StaticDataNewTag apptype='<%=apptype%>'/> 
                                                  </select>
                                                </td>
                                              </tr>
                                              <tr> 
                                                <td colspan="2" valign="middle">Minimum 
                                                  Class for Skip flowpoints <span class="mantatory">*</span></td>
                                                <td> 
                                                  <select name="prd_skipclass">
                                                    <option value="">----Select----</option>
                                                    <%apptype="7"; %>
                                                    <lapschoice:StaticDataNewTag apptype='<%=apptype%>'/> 
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
  <lapschoice:combuttonnew btnnames='Edit_Save_Cancel' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
  <lapschoice:hiddentag pageid='<%=PageId%>'/>

  <input type="hidden" name="txt_facility" value="0">
  <input type="hidden" name="wrk_flowtype">
  <input type="hidden" name="prd_code">
  <input type="hidden" name="hid_prd_appclass">
  <input type="hidden" name="hid_prd_rejclass">
  <input type="hidden" name="hid_prd_skipclass">
</form>
</body>
</html>
