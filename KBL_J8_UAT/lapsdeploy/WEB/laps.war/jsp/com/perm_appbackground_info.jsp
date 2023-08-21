<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>

<%
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String strFreezeflag =Helper.correctNull((String)session.getAttribute("strFrzfalgnew")).trim();

String strpermission_Freezeflag =Helper.correctNull((String)session.getAttribute("strpremission_freezeflag")).trim();


%>

<html>
<head>
<title>Comments</title>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var varpermission_Freezeflag="<%=strpermission_Freezeflag%>";

function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
        //document.forms[0].hidBeanId.value="facilities";
	    document.forms[0].action=appURL+"action/"+"mainnav.jsp";	
		document.forms[0].submit();
	}
}

function doDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].hidBeanMethod.value="update_PermApplBackgroundData";
		document.forms[0].hidBeanGetMethod.value="get_PermApplBackgroundData";
		document.forms[0].hidSourceUrl.value="action/perm_appbackground_info.jsp";	
		//document.forms[0].method="post";
		document.forms[0].action=appURL+"action/controllerservlet";	
		document.forms[0].submit();
	}
}
function doSave()
{ 	
	document.forms[0].cmdsave.disabled = true;
	
    document.forms[0].hidAction.value="update"
    document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].hidBeanMethod.value="update_PermApplBackgroundData";
	document.forms[0].hidBeanGetMethod.value="get_PermApplBackgroundData"
	document.forms[0].hidSourceUrl.value="/action/perm_appbackground_info.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	
}

function doEdit()
{
	disableFields(false);
	callDisableControls(true,false,false,false,true);
	EditorEnableDisable1("id_div","none","id_editor","block");
	editor_generate('txt_comments');
}

function callDisableControls(cmdEdit,cmdSave,cmdCancel,cmddelete,cmdClose)
{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdSave;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmddelete.disabled=cmddelete;
	document.forms[0].cmdclose.disabled=cmdClose;
}

function onLoading()
{    
	
	 disableFields(false);
	 EditorEnableDisable1("id_div","block","id_editor","none");
	 var AssessmentParam=document.forms[0].hidassessment.value;
	 var FinancialParam=document.forms[0].hidfinancial.value;	 
			if(AssessmentParam=="Y")
			{			
				document.all.idAssessment.style.display="table-cell";
			}
			else
			{
				document.all.idAssessment.style.display="none";
			}
			if(FinancialParam=="Y")
			{
				document.all.idFinancial.style.display="table-cell";
			}
			else
			{				
				document.all.idFinancial.style.display="none";				
			}	
			
	if(document.forms[0].hidDevCat.value=="7")
	{
		document.all.more_det.style.display="none";
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
  }
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].hidBeanGetMethod.value="get_PermApplBackgroundData";
		document.forms[0].action=appURL+"action/perm_appbackground_info.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function EditorEnableDisable1(name1,val1,name2,val2)
{
	document.getElementById(name1).style.display=val1;
	document.getElementById(name2).style.display=val2;
}
function callLink(page,bean,method)
{ 
	if (document.forms[0].cmdsave.disabled)
	{
		if(page=="permissiongist_addDetails.jsp" && varpermission_Freezeflag!="Y")
		{	
		 	alert("Kindly click on freeze button in Permission Tab");
			return;
		}
		else
		{
			document.forms[0].hidAction.value="";
		 	document.forms[0].hidBeanGetMethod.value=method;
		 	document.forms[0].hidBeanId.value=bean;
		 	document.forms[0].action=appURL+"action/"+page;
		 	document.forms[0].submit();
		}		
	}
	else 
	{
		ShowAlert(103);
		return;
	}
}
function callalert()
{
	alert("Click Freeze to view Security Coverage");
	return;
}

</script>

</head>
<body onload="onLoading()">

<form method = post class="normal">

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/devurllinker.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td class="page_flow">  
		Home -&gt; Permission -&gt;Background of the Applicant 
		</td>
	</tr>
</table>
		<lapschoice:ApplDevHeaderTag />
	

<table width="100%">
  		
  		<tr>
  			<td>
  			<table border="0" cellspacing="2" cellpadding="3" align="left" class="outertable">
			<tr>
			<td class="sub_tab_inactive" id="prin" width="150px;" align="center"><b><a href="#" onclick="javascript:callLink('permission_gist.jsp','perDeviation','getPermissionGistData')">Permission Gist</a></b></td>
			<td class="sub_tab_inactive" id="more_det" align="center" width="250px;"><b><a href="#" onclick="javascript:callLink('permissiongist_addDetails.jsp','perDeviation','getPermissionGistMoreDet')">Permission Gist- More Information</a></b></td>	
			<td class="sub_tab_active" id="prin" width="200px;" align="center"><b>Background of the Applicant</b></td>
			<td class="sub_tab_inactive" id="idAssessment" width="200px" align="center" style="display: none;"><b><a href="#" onclick="javascript:callLink('perdeviationassessment.jsp','perDeviation','getAssessment')">Interest concession Assessment</a></b></td>
			<td class="sub_tab_inactive" id="prin" width="150px;" align="center"><b><a href="#" onclick="javascript:callLink('permission_parameters.jsp','perDeviation','getPermissionData')">Permission Paramters</a></b></td>
			<td class="sub_tab_inactive" id="idFinancial" width="200px;" align="center" style="display: none;"><b><a href="#" onclick="javascript:callLink('perm_financial.jsp','perDeviation','getdataFinancial')">Gist of Balance Sheet Analysis</a></b></td>
			</tr>
			</table>
  			</td>
  		</tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
                <tr> 
                <td valign="top">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                      <tr> 
                        
                            	<td>
                                <table width="90%" border="0" cellspacing="0" cellpadding="4" class="outertable" align="center" >
                                  <tr class="dataheader"><td>Comments</td></tr>
                                  <tr> 
                                   <td>
						            <div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("CONTENT")) %></div></div>
						            <div id="id_editor"> <textarea name="txt_comments" cols="110" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("CONTENT")) %></textarea></div>
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
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />

<input type="hidden" name="hidPage" value="">
<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidBeanMethod" value=""> 
<input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidAction" value="">
<input type="hidden" name="hidSourceUrl" value=""> 
<input type="hidden" name="hidPageId">
</form>  
</body>
</html>