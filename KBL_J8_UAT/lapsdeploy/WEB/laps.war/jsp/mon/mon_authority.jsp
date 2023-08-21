<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

 <% 
 String strWrkflowtype=Helper.correctNull((String)request.getParameter("wrk_flowtype"));
 if(strWrkflowtype.equalsIgnoreCase(""))
 {
	 strWrkflowtype="w";
 }
 String prdCode=Helper.correctNull((String)request.getParameter("prd_code"));
 if(prdCode.equalsIgnoreCase(""))
 {
	 prdCode=Helper.correctNull((String)hshValues.get("mon_module"));
 }
 String npa_reject=Helper.correctNull((String)hshValues.get("mon_reject"));
 String npa_skip=Helper.correctNull((String)hshValues.get("mon_skip"));
 String npa_approve=Helper.correctNull((String)hshValues.get("mon_approve"));
%>
<html>
<head>
<title>Limit Master</title>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
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
		document.forms[0].hidBeanGetMethod.value="getMONAuthority";
		document.forms[0].action=path+"action/mon_authority.jsp";	
		document.forms[0].submit();
	}
}

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
	}
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmdapply.disabled=false;
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

function onEdit()
{
	disableCommandButtons("edit");
}

function doSave()
{
		document.forms[0].hidBeanId.value="setproducts";	
		document.forms[0].hidBeanGetMethod.value="updateMONAuthority";
		document.forms[0].action=path+"action/mon_authority.jsp";	
		document.forms[0].submit();
}

function onCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidBeanId.value="setproducts";	
		document.forms[0].hidBeanGetMethod.value="getMONAuthority";
		document.forms[0].action=path+"action/mon_authority.jsp";	
		document.forms[0].submit();
	}
}

function onClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].hidBeanId.value="";	
		document.forms[0].hidBeanGetMethod.value="";
		document.forms[0].action=path+"action/monitoring_main.jsp";
		document.forms[0].submit();
	}
}


function callFlowtype(type)
{
	if(type!="w")
	{
		if (document.forms[0].prdCode.value != "")
		{
		if(!document.forms[0].cmdapply.disabled)
		{
			ShowAlert(103);
			return;
		}
		document.forms[0].method="post";
		document.forms[0].wrk_flowtype.value=type;
		document.forms[0].hidBeanGetMethod.value="getWorkflowmonitoring";
		document.forms[0].prd_code.value=document.forms[0].prdCode.value;	
		document.forms[0].action=path+"action/setprdworkflowcommon.jsp";
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
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
DIV.cellContainer {	
  width: 100%; height: 130;
  overflow: auto;
}
DIV.cellContainer2 {	
  width: 100%; height: 200;
  overflow: auto;
}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="onloading()">
<form>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colspan=5> 
              <jsp:include page="../share/help.jsp" flush="true"/> 
              <jsp:include page="../share/menus.jsp" flush="true"/> 
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td valign="bottom"><b><font face="Times New Roman" size="3"><b><i><font face="Times New Roman" size="3"><b><i>Home 
        </i><font face="MS Sans Serif">-&gt;</font> <i>Setup </i><font face="MS Sans Serif"> 
        -&gt;</font></b></font> Monitoring Flowpoints</i></b></font></b></td>
      <td width="280">&nbsp; </td>
    </tr>
  </table>
  <table width="41%" border="0" cellspacing="0" cellpadding="2">
    <tr> 
      <td align="center" width="51%"><font size="1" face="MS Sans Serif">Select 
        Module</font></td>
       <td width="49%">
         <select name="prdCode" onChange="showdata()">
          <option value="S" selected>-------SELECT-------</option>
		  <option value="MON">MONITORING</option>
        <!--   <option value="PAWO">PRUDENTIAL WRITE OFF/ABSOLUTE WRITE OFF</option>
          <option value="SUIT">FILING OF SUIT</option>
          <option value="STAT">STATUS NOTE</option>
          <option value="SARFI">SARFAESI ACT</option>--> 
        </select>
      </td>
    </tr>
  </table>
 
  <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" height="390">
    <tr>
      <td height="56"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="3" align="center" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" height="100%">
          <tr> 
            <td height="7" valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td colspan="4" height="2" valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr> 
                        <td colspan="10" valign="top"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr> 
                              <td valign="top"> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" bordercolorlight="#EBEBF8" bordercolordark="#82829F">
                                  <tr> 
                                    <td> 
                                      <table width="100%" border="0" cellspacing="0" cellpadding="3" height="0">
                                        <tr> 
                                          <td colspan="6"></td>
                                        </tr>
                                        <tr> 
                                          <td colspan="6"> 
                                            <table width="37%" border="0" cellspacing="3" cellpadding="3">
                                              <tr bgcolor="#EEEAE3"> 
                                                <td width="27%" align="center" <%if(strWrkflowtype.equals("p")){%>
                                                  bgcolor="#71694F"<%}%> ><font size="1" face="MS Sans Serif" <%if(strWrkflowtype.equals("p")){%>
                                                  color="#Ffffff"<%}%> ><b> 
                                                  <%if (!strWrkflowtype.equals("p")){%>
                                                  <a href="javascript:callFlowtype('p')" class="blackfont"> 
                                                  <%}%>
                                                  In Process</a></b></font></td><!--
                                                <td width="35%" align="center" <%if(strWrkflowtype.equals("a")){%>
                                                  bgcolor="#71694F"<%}%>><font size="1" face="MS Sans Serif" <%if(strWrkflowtype.equals("a")){%>
                                                  color="#Ffffff"<%}%>><b> 
                                                  <%if (!strWrkflowtype.equals("a")){%>
                                                  <a href="javascript:callFlowtype('a')" class="blackfont"> 
                                                  <%}%>
                                                  Post Approval </a></b></font></td>
                                                <td width="38%" align="center" <%if(strWrkflowtype.equals("r")){%>
                                                  bgcolor="#71694F"<%}%>><font size="1" face="MS Sans Serif" <%if(strWrkflowtype.equals("r")){%>
                                                  color="#Ffffff"<%}%>><b> 
                                                  <%if (!strWrkflowtype.equals("r")){%>
                                                  <a href="javascript:callFlowtype('r')" class="blackfont"> 
                                                  <%}%>
                                                  Post Rejection </a></b></font></td>
                                                --><td width="38%" align="center" <%if(strWrkflowtype.equals("w")){%>
                                                  bgcolor="#71694F"<%}%>><font size="1" face="MS Sans Serif" <%if(strWrkflowtype.equals("w")){%>
                                                  color="#Ffffff"<%}%>><b> 
                                                  <%if (!strWrkflowtype.equals("w")){%>
                                                  <a href="javascript:callFlowtype('w')" class="blackfont"> 
                                                  <%}%>
                                                 Authority</a></b></font></td> </tr>
                                            </table>
                                          </td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td valign="top"> 
                                      <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
                                        <tr> 
                                          <td colspan="5" height="18"><font face="MS Sans Serif" size="1" color="#CC0000">Select 
                                            the Class values for Approval/Rejection 
                                            and Skip</font></td>
                                        </tr>
                                      </table>
                                      <table width="100%" border="1" cellspacing="0" cellpadding="5" align="center" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
                                        <tr> 
                                          <td> 
                                            <table width="100%" border="0" cellspacing="0" cellpadding="8" align="center" >
                                              <tr> 
                                                <td colspan="2" align ="left" valign="middle"><font size="1" face="MS Sans Serif">Minimum 
                                                  Class for Approval</font></td>
                                                <td width="64%"> 
                                                  <select name="prd_appclass">
                                                    <option value="">----Select----</option>
                                                    <%String apptype="7"; %>
                                                    <laps:StaticDataNewTag apptype='<%=apptype%>'/> 
                                                  </select>
                                                </td>
                                              </tr>
                                              <tr> 
                                                <td colspan="2" valign="middle"><font size="1" face="MS Sans Serif"> 
                                                  Minimum Class for Rejection</font></td>
                                                <td width="64%"> 
                                                  <select name="prd_rejclass">
                                                    <option value="">----Select----</option>
                                                    <%apptype="7"; %>
                                                    <laps:StaticDataNewTag apptype='<%=apptype%>'/> 
                                                  </select>
                                                </td>
                                              </tr>
                                              <tr> 
                                                <td colspan="2" valign="middle"><font size="1" face="MS Sans Serif">Minimum 
                                                  Class for Skip flowpoints</font></td>
                                                <td> 
                                                  <select name="prd_skipclass">
                                                    <option value="">----Select----</option>
                                                    <%apptype="7"; %>
                                                    <laps:StaticDataNewTag apptype='<%=apptype%>'/> 
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
  <table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr bordercolordark="#FFFFFB" bordercolorlight="#8F8369"> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" >
          <tr valign="top"> 
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdedit" value="Edit"  onClick="onEdit()" class="buttonStyle">
              </div>
            </td>
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdapply" value="Save" onClick="doSave()" class="buttonStyle">
              </div>
            </td>
            
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdcancel" value="Cancel" onClick="onCancel()" class="buttonStyle">
              </div>
            </td>
           
            <td width="15%"> 
              <div align="center"> 
                <input type="button" name="cmdhelp" value="Help" onClick="dohlp()" class="buttonHelp">
              </div>
            </td>
            <td width="15%"> 
              <div align="center"> 
                <input type="button" name="cmdclose" value="Close" onClick="onClose()" class="buttonClose">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>

  <input type="hidden" name="hidAction" >
  <input type="hidden" name="txt_facility" value="0">
  <input type="hidden" name="hidBeanId" value="setproducts">
  <input type="hidden" name="hidBeanMethod">
  <input type="hidden" name="hidBeanGetMethod">
  <input type="hidden" name="hidSourceUrl">
  <input type="hidden" name="wrk_flowtype">
  <input type="hidden" name="prd_code">
</form>
</body>
</html>
