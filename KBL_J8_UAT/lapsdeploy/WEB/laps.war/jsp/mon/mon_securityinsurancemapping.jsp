
<%@include file="../share/directives.jsp"%>
<%
String strCbsid=Helper.correctNull((String)hshValues.get("Cbsid"));
if(strCbsid.equals(""))
	strCbsid =  Helper.correctNull(request.getParameter("hidcbsid"));%>

<html>
<head>
<title>Document Register</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script><!--
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var path      ="<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var securitynature = "<%=Helper.correctNull((String)hshValues.get("securitynature"))%>";
var Insurance = "<%=Helper.correctNull((String)hshValues.get("Insurance"))%>"; 
var securitynature = "<%=Helper.correctNull((String)hshValues.get("securitynature"))%>";
var straccno = "<%=Helper.correctNull((String)hshValues.get("straccno"))%>";
var varorglevel="<%=strOrgLevel%>";

function placevalues()
{
	if(straccno != "")
	{
		document.forms[0].sel_account.value=straccno;
		getData();
	}
	if(document.forms[0].btnenable.value=="Y" && varorglevel=='A')
	{
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
	else
	{
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
	disableFields(true);
}

function doNew()
{
	disableFields(false);
	disableCommandButtons("edit");
	document.forms[0].hidAction.value ="insert";
}

function doEdit()
{ 	
	if(document.forms[0].sel_account.value=="0")
	{
		alert("Select Account Number");
		document.forms[0].sel_account.focus();
		return;
	}
	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");	
}

function doSave()
{
	
	document.forms[0].sel_account.disabled=false;
	var varsec="";
		for(var i=0;i<document.forms[0].selinsurance.options.length;i++)
		{
			if(document.forms[0].selinsurance.options[i].selected)
			{				
				varsec=varsec+document.forms[0].selinsurance.options[i].value+"@";
			}		
		}
	if(document.forms[0].sel_securitynature.value=="0")
	{
		alert("Select  Type of security");
		document.forms[0].sel_securitynature.focus();
		return;
	}
	if(varsec=="")
	{
		alert("Select Insurance type");
		document.forms[0].selinsurance.focus();
		return;
	}
		
	document.forms[0].hidinsurance.value = varsec;
	
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="Register";
	document.forms[0].hidSourceUrl.value="/action/mon_securityinsurancemapping.jsp";
	document.forms[0].hidBeanMethod.value="updateSecuInsuranceMapping";
	document.forms[0].hidBeanGetMethod.value="getSecuInsuranceMapping";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{	document.forms[0].sel_account.disabled=false;	
		document.forms[0].hidBeanGetMethod.value="getSecuInsuranceMapping";
		document.forms[0].hidBeanId.value="Register";
		document.forms[0].action=appURL+"action/mon_securityinsurancemapping.jsp";
		document.forms[0].submit();
	}	
}


function doDelete()
{
	var type_of_sec=document.forms[0].sel_securitynature.value;

	if(type_of_sec=="" || type_of_sec=='0')
	{
		alert("Please Select Type of Security");
			
	}
	else
	{	
	if(ConfirmMsg(101))
	{	document.forms[0].sel_account.disabled=false;
		document.forms[0].hidAction.value="Delete";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="Register";
		document.forms[0].hidSourceUrl.value="/action/mon_securityinsurancemapping.jsp";
		document.forms[0].hidBeanMethod.value="updateSecuInsuranceMapping";
		document.forms[0].hidBeanGetMethod.value="getSecuInsuranceMapping";	
		document.forms[0].submit();
	}
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

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	if(val=="radioselect")
	{	 
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}	  
	if(val=="disableall")
	{
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
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
		else if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		else if(document.forms[0].elements[i].type=="select-multiple")
		{
			document.forms[0].elements[i].disabled=val;
		}	 
	}
	document.forms[0].sel_account.disabled=false;
	document.forms[0].sel_securitynature.disabled=false;
	    
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


function displayData()
{		
	
		var accno=document.forms[0].sel_account.value;
		var secur=document.forms[0].sel_securitynature.value;
		var mmr_no="<%=Helper.correctNull(request.getParameter("mmrno"))%>";
		document.all.ifrm2.src=path+"action/iframedisplayinsusecmap.jsp?hidBeanGetMethod=getSecuInsuranceMapping&hidBeanId=Register&acc_no="+accno+"&cbsid="+<%=strCbsid%>+"&securitynature="+secur+"&mmr_no="+mmr_no;
}
function getData()
{
if( document.forms[0].sel_account.value  !="0")
	{
		
		var accno=document.forms[0].sel_account.value;
		
		
		if(accno !='') 
		{
			
			document.all.ifrm1.src=path+"action/iframeinsusecmap.jsp?hidBeanGetMethod=getSecurityInsuranceDetail&hidBeanId=Register&acc_no="+accno+"&cbsid="+<%=strCbsid%>+"&securitynature="+securitynature+"&=insurance"+Insurance;
			
		}
		
	}


}

--></script>
<style>
Div.cellcontainer
{
	height:150px;
	overflow:auto;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="placevalues()">
<form name="frmdocumentregister" method=post class="normal">
<iframe height="0" width="0" id="ifrm1" frameborder=0 style="border:0"></iframe>
<iframe  height="0" width="0" id="ifrm2" frameborder=0 style="border:0" ></iframe> 
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left" class="outertable">
			<tr>
				<td><lapschoice:monthlymonitortag pageid="6" /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="98%" border="0" cellpadding="5" cellspacing="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td class="page_flow">Home -&gt; Monitoring-&gt; Monthly Monitoring -&gt;Ins - Security Details</td>
			</tr>
		</table>
		</td>
	</tr>
	
		<tr>
					<td>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
				<tr>
					<td>
						<lapschoice:MonthlyMonitor />
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>   
	<tr>
		<td>
		<table width="60%" border="0" cellspacing="0" cellpadding="2" align="center" class="outertable border1">
			<tr>
				<td>
				
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
              	<tr> 
                  <td width="19%">&nbsp;&nbsp;Account Number</td>
                  <td width="29%"> 
                    <select name="sel_account" tabindex="1" onchange="getData()">
                      <option value="0">---Select-----</option>
                      <lapschoice:GetMonAccountNumberTag/>
                    </select>
                  </td>
                  <td> </td>
                </tr>
                <tr> 
                  <td colspan="3">&nbsp; </td>
                </tr>
                <tr> 
                  <td width="19%">&nbsp;&nbsp;Type of security</td>
                  <td width="29%"> 
                    <select name="sel_securitynature" tabindex="2" onchange="displayData()">
                      <option value="0">---Select-----</option>
                      
                    </select>
                  </td>
                  <td> </td>
                </tr>
                <tr> 
                  <td colspan="3">&nbsp; </td>
                </tr>
                <tr> 
                  <td width="25%">&nbsp;&nbsp;Insurance </td>
                  <td colspan="3">
                    <select name="selinsurance" size="10" multiple>
                    
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td> </td>
                </tr>
               
              </table>
				</td>
			</tr>
		</table>
		</td>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidsno" >
<input type="hidden" name="hidinsurance"/>
<input type="hidden" name="hidinsuranceno"/>
<input type="hidden" name="hidAuditFlag">
</form>
</body>
</html>
