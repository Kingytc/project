<%@include file="../share/directives.jsp"%>
    
    <%
    
    ArrayList arrRow=(ArrayList)hshValues.get("arrRow");
    ArrayList arrCol=new ArrayList();
    
    
    String DEV_DEVPARAM= Helper.correctNull((String)hshValues.get("DEV_DEVPARAM"));
	String strpermission_Freezeflag =Helper.correctNull((String)session.getAttribute("strpremission_freezeflag")).trim();

    %>
<html>
<head>
<title>Insert title here</title>
<script type="text/javascript">
var curdate = "<%=Helper.getCurrentDateTime()%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varDEV_DEVPARAM="<%=DEV_DEVPARAM%>";
var varPermType="<%=Helper.correctNull((String)hshValues.get("DEV_TYPE"))%>";
var varPermSubType="<%=Helper.correctNull((String)hshValues.get("DEV_SUBTYPE"))%>";

var varperm="<%=Helper.correctNull((String)hshValues.get("ParamA"))%>";

var varpermission_Freezeflag="<%=strpermission_Freezeflag%>";


function callLink(url,bean,method)
{
	if(document.forms[0].cmdsave.disabled == false)
	{
		ShowAlert(103);
		return;
	}
	if(url=="permissiongist_addDetails.jsp" && varpermission_Freezeflag!="Y")
	{	
	 	alert("Kindly click on freeze button in Permission Tab");
		return;
	}
	else
	{
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
		document.forms[0].submit();
	}
}

function loadValue()
{
	var len = document.forms[0].chkFac.length;
	if(len != null)
	{
		for(i=0;i<len;i++)
		{
				document.forms[0].chkFac[i].disabled = true;
		}
	}
	else
	{
		document.forms[0].chkFac.disabled = true;
	}
	document.forms[0].sel_perm_type.disabled=true;
	document.forms[0].sel_devSubType.disabled=true;
	if(varPermType!="")
	{
		document.forms[0].sel_perm_type.value=varPermType;
	}
	loadPermSubtype();
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
function loadPermSubtype()
{
	var varpermissionType = document.forms[0].sel_perm_type.options[document.forms[0].sel_perm_type.selectedIndex].value;
	document.all.ifrmpermissiontype.src = appURL
			+ "action/ifrmDeviationdataload.jsp?hidBeanGetMethod=getPermissiontypeData&hidBeanId=perDeviation&permtype="
			+ varpermissionType+"&pagefrom=permParam1&sectype="+varPermSubType;
}

function callFacsnoChk()
{
	var varParam="";
	var varParameters="";
	if(document.forms[0].chkFac.length!=undefined)
	{
		var vararrsize=eval(document.forms[0].chkFac.length);
		for(var j=0;j<vararrsize;j++)
		{
			var vartemp2="document.forms[0].chkFac"+"["+j+"]";
			if(eval(vartemp2).checked)
			{
				varParam1=eval(vartemp2).value;
				varParameters=varParameters+varParam1+"@";
			}
		}
	}
	else
	{
		if(document.forms[0].chkFac.checked)
		{
			varParameters=document.forms[0].chkFac.value+"@";
		}
	}
	if(varParameters=="")
	{
		alert("Please Select Any one Parameter");
		document.forms[0].hidParameter.value="";
		return false;
	}
	document.forms[0].hidParameter.value=varParameters;
}

function doSave()
{
	var varpara=document.forms[0].hidParameter.value;
	if(document.forms[0].hidParameter.value=="")
	{
		alert("Please select atleast one Parameter");
		return;
	}
	document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].hidBeanMethod.value="updatePermissionParamData";
	document.forms[0].hidBeanGetMethod.value="getPermissionData";
	document.forms[0].hidSourceUrl.value="/action/permission_parameters.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();	
}

function doEdit()
{
	callDisableControls(true,false,false,true);
	var len = document.forms[0].chkFac.length;
	if(len != undefined)
	{
		for(i=0;i<len;i++)
		{
				document.forms[0].chkFac[i].disabled = false;
		}
	}
	else
	{
		document.forms[0].chkFac.disabled = false;
	}
}

function callDisableControls(cmdEdit,cmdSave,cmdCancel,cmdClose)
{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdSave;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
}
	

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
	document.forms[0].hidBeanGetMethod.value="getPermissionData";
	document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].action=appUrl+"action/permission_parameters.jsp";
	document.forms[0].submit();
	}
}

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

</script>


</head>
<body onload="loadValue()">
<form method="post" class="normal">

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
		Home -&gt; Permission -&gt;Permission Gist
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
			<td class="sub_tab_inactive" id="prin" width="200px;" align="center"><b><a	href="#" onclick="javascript:callLink('perm_appbackground_info.jsp','perDeviation','get_PermApplBackgroundData')">Background of the Applicant</a></b></td>
			<td class="sub_tab_inactive" id="idAssessment" width="200px" align="center" style="display: none;"><b><a href="#" onclick="javascript:callLink('perdeviationassessment.jsp','perDeviation','getAssessment')">Interest concession Assessment</a></b></td>
			<td class="sub_tab_active" id="prin" nowrap width="150px;" align="center"><b>Permission Parameters</b></td>
			<td class="sub_tab_inactive" id="idFinancial" width="200px;" align="center" style="display: none;"><b><a href="#" onclick="javascript:callLink('perm_financial.jsp','perDeviation','getdataFinancial')">Gist of Balance Sheet Analysis</a></b></td>
			</tr>
			</table>
  			</td>
  		</tr>
  </table>


	<table width="100%"  border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr> 
	<td valign="middle"> 
		<table width="100%" border="0" cellspacing="1" cellpadding="3" id="tab_permParam">
		<tr>
				<td width="25%">Permission Type </td>		
				<td width="25%">
					<select name="sel_perm_type">
							<option selected value="S">--Select--</option>
									<%
							String parentType="0";
							%>
							<lapschoice:PermPmayMaster  value='<%=parentType %>'/>
					</select>
				</td>
			</tr>
			<tr>
				<td>Permission Subtype </td>
				<td>
					<select name="sel_devSubType">
						<option selected value="S">--Select--</option>
					</select>
				</td>
			</tr>
			<tr class="dataheader">
				<td colspan="2">PERMISSION PARAMETERS&nbsp;&nbsp;<input type="hidden"  name="hidSno" value=""></td>
			</tr>
						
				<%
	 if (arrRow!=null && arrRow.size() > 0)
	 {			
			for(int i=0;i<arrRow.size();i++)
			{
				arrCol=new ArrayList();
				arrCol=(ArrayList)arrRow.get(i);
				String strCode=Helper.correctNull((String)arrCol.get(0));
				String strClassificationDesc=Helper.correctNull((String)arrCol.get(1));
				
				String[] paramvalues=DEV_DEVPARAM.split("@");
				int checkFlag=0;
				for(int j=0;j<paramvalues.length;j++)
				{
					if(strCode.equals(paramvalues[j]))
					{
						checkFlag++;
					}
				}
				
				if(checkFlag>0)
				{
			 %>		
				<tr class="datagrid"> 
					<td width="5%"><input type="checkbox" name="chkFac" onClick="callFacsnoChk()" style="border-style:none" value="<%=strCode%>" checked="checked" > </td>
					<td width="95%"><%=strClassificationDesc%></td>
				</tr>
			
			<%} else { %>
				 <tr class="datagrid"> 
					<td><input type="checkbox" name="chkFac" onClick="callFacsnoChk()" style="border-style:none" value="<%=strCode%>"  > </td>
					<td><%=strClassificationDesc%></td>
				 </tr>
			 <% }  %>	
			<%  }	%>
				
		  <% } %>
						
						
						
		</table>
	</td>
</tr>
</table>

<input type="hidden" name="hidParameter" value="<%=Helper.correctNull((String)hshValues.get("DEV_DEVPARAM"))%>">
<lapschoice:hiddentag pageid='<%=PageId%>' />
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<iframe	height="0" width="0" id="ifrmpermissiontype" frameborder=0 style="border: 0"></iframe>

</form>
</body>
</html>