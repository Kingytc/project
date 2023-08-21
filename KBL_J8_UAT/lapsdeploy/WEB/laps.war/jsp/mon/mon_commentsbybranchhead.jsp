<%@include file="../share/directives.jsp"%>

<%

	String stryear=Helper.correctNull((String)request.getParameter("mon_year"));
	if(!stryear.equalsIgnoreCase(""))
	{
		stryear=Helper.correctNull((String)hshValues.get("mon_year"));
	}
	String strmonth=Helper.correctNull((String)request.getParameter("mon_month"));
	
	if(!strmonth.equalsIgnoreCase(""))
	{
		strmonth=Helper.correctNull((String)hshValues.get("mon_month"));
	}
	
	String strcbsname=Helper.correctNull((String)hshValues.get("strcbsname"));
%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<style>
</style>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var select1="<%=Helper.correctNull((String)hshValues.get("mon_operation"))%>";
var select2="<%=Helper.correctNull((String)hshValues.get("mon_sanction"))%>";
var select3="<%=Helper.correctNull((String)hshValues.get("mon_irregular"))%>";
var select4="<%=Helper.correctNull((String)hshValues.get("mon_observation"))%>";
var selectlimits="<%=Helper.correctNull((String)hshValues.get("mon_limits"))%>";
var varorglevel="<%=strOrgLevel%>";

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		if(varorglevel=='A')
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
}

function onLoading()
{
	disableCommandButtons("load");
	
	if(select1!="")
	{
	    document.forms[0].sel_operations.value=select1;	
		
	}
	else
	{
	    document.forms[0].sel_operations.value="y";	
	}
	if(select2!="")
	{
	    document.forms[0].sel_sanction.value=select2;	
		
	}
	else
	{
	    document.forms[0].sel_sanction.value="y";
	}
	if(select3!="")
	{
	    document.forms[0].sel_irregular.value=select3;	
		
	}
	else
	{
	    document.forms[0].sel_irregular.value='y';	
	}
	
	if(selectlimits!="")
	{
	    document.forms[0].sel_limits.value=selectlimits;	
		
	}
	else
	{
	    document.forms[0].sel_limits.value='y';	
	}
	
	showOperation();
	showSanction();
	showIrregular();
	showlimits();
	document.forms[0].sel_mmr.disabled=false;
}
function doDelete()
{
	if(ConfirmMsg(101))
		{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updatebranchcomments";
		document.forms[0].hidBeanGetMethod.value="getbranchcomments";
		document.forms[0].hidBeanId.value="Register";
		document.forms[0].hidSourceUrl.value="action/mon_commentsbybranchhead.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
		}
}
function doEdit()
{ 	
	disableFields(false);
    document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");	
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="mon_commentsbybranchhead.jsp";
		document.forms[0].hidBeanId.value="Register";
		document.forms[0].hidBeanGetMethod.value="getbranchcomments";
		document.forms[0].action=appURL +"action/mon_commentsbybranchhead.jsp";
	    document.forms[0].submit();	
	}	
	
	disableCommandButtons("load");
}
function doSave()
	{
	   if(document.forms[0].txt_observations.value=="")
		{
			alert("Enter ANY OTHER OBSERVATIONS/ ADVERSE FEATURES:");
			return;
		}	   
	   document.forms[0].hidBeanId.value="Register";
		document.forms[0].hidBeanMethod.value="updatebranchcomments";
		document.forms[0].hidBeanGetMethod.value="getbranchcomments";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/mon_commentsbybranchhead.jsp";
		document.forms[0].submit();
	}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}		  
		 
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
		
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
function showOperation()
{
	if(document.forms[0].sel_operations.value=="n")
	{
		document.all.a1.style.visibility="visible";
	}
	else
	{
		document.all.a1.style.visibility="hidden";
		document.forms[0].txt_operations.value="";
	}
}
function showSanction()
{
	if(document.forms[0].sel_sanction.value=="n")
	{
		document.all.b1.style.visibility="visible";
	}
	else
	{
		document.all.b1.style.visibility="hidden";
		document.forms[0].txt_sanction.value="";
	}
}
function showIrregular()
{
	if(document.forms[0].sel_irregular.value=="n")
	{
		document.all.a2.style.visibility="visible";
	}
	else
	{
		document.all.a2.style.visibility="hidden";
		document.forms[0].txt_irregularities.value="";
		
	}
}

function showlimits()
{
	if(document.forms[0].sel_limits.value=="n")
	{
		document.all.limit1.style.visibility="visible";
	}
	else
	{
		document.all.limit1.style.visibility="hidden";
		document.forms[0].txt_limits.value="";
		
	}
}

function doPrint()
{		
	if(document.forms[0].sel_mmr.value=="1")
	{		
		var purl ="<%=ApplicationParams.getAppUrl()%>action/mmr_reportprint.jsp?hidBeanGetMethod=getMMRReportPrint&hidBeanId=mmrcommon&cbsid="+document.forms[0].hidcbsid.value+"&mon_year="+document.forms[0].strYear.value+"&mon_month="+document.forms[0].mmr_month.value+"&strcbsname="+document.forms[0].strcbsname.value+"&mmrno="+document.forms[0].mmrno.value;
		var prop = 'scrollbars=yes,menubar=yes,width=750,height=520';	
		var xpos = (screen.width - 750) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'MMRPRINTOUT',prop);
	}
	else if(document.forms[0].sel_mmr.value=="2")
	{
		var purl ="<%=ApplicationParams.getAppUrl()%>action/mmr_reportprint_April2012.jsp?hidBeanGetMethod=getMMRReportApril2012Print&hidBeanId=mmrcommon&cbsid="+document.forms[0].hidcbsid.value+"&mon_year="+document.forms[0].strYear.value+"&mon_month="+document.forms[0].mmr_month.value+"&strcbsname="+document.forms[0].strcbsname.value+"&mmrno="+document.forms[0].mmrno.value;
		var prop = 'scrollbars=yes,menubar=yes,width=750,height=520';	
		var xpos = (screen.width - 750) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'MMRPRINTOUT',prop);
	}
	else
	{
		alert("Please Select Print Format");
		document.forms[0].sel_mmr.focus();
		return;
	}
}


</script>

</head>

<body text="#000000"  onload="onLoading()">
<form name="safaeri3" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapschoice:monthlymonitortag pageid="10"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
        <tr>         	
      <td class="page_flow">Home-&gt; Monitoring-&gt; Monthly Monitoring Reports-&gt; Branch Head Comments</td>
          </tr>
  </table>
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapschoice:MonthlyMonitor />
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>   
  
        
  <table width="79%" border="0" cellspacing="0" cellpadding="4" align="center"  height="406" class="outertable ">
    <tr> 
            
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="4" align="center"  height="389" class="outertable border1">
          <tr> 
            <td colspan="2">PRINT FORMAT</td>
            <td colspan="2"> 
              <SELECT NAME="sel_mmr"  TABINDEX="11">
                <OPTION VALUE="0">--Select--</OPTION>
                <OPTION VALUE="1">MMR UPTO MARCH-2012</OPTION>
                <OPTION VALUE="2">MMR FROM APRIL-2012</OPTION>
              </SELECT>
            </td>
          </tr>
          <tr> 
            <td colspan="2">WHETHER LIMITS ARE VALID AND IN FORCE </td>
            <td width="13%" align="center"> 
              <select name="sel_limits" tabindex="9" onChange="showlimits()">
                <option value="y">Yes</option>
                <option value="n">No</option>
              </select>
            </td>
            <td width="35%" id="limit1"> 
              <textarea rows="4" name="txt_limits" cols="50" tabindex="10" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("mon_limitsreason"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td colspan="2">ARE YOU SATISFIED WITH THE OPERATIONS IN THE ACCOUNT 
            </td>
            <td width="13%" align="center"> 
              <select name="sel_operations" tabindex="1" onChange="showOperation()">
                <option value="y">Yes</option>
                <option value="n">No</option>
              </select>
            </td>
            <td width="35%" id="a1"> 
              <textarea rows="4" name="txt_operations" cols="50" tabindex="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("mon_operationdetails"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td colspan="2">WHETHER ALL THE SANCTION STIPULATIONS INCLUDING CREATION 
              OF EM/ROC ARE COMPLIED WITH</td>
            <td width="13%" align="center"> 
              <select name="sel_sanction"  tabindex="3" onChange="showSanction()">
                <option value="y">Yes</option>
                <option value="n">No</option>
              </select>
            </td>
            <td id="b1" width="35%"> 
              <textarea rows="4" name="txt_sanction" cols="50" tabindex="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("mon_sanctiondetails"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td colspan="2">WHETHER IRREGULARITIES OF EARLIER MONITORING REPORT 
              OBSERVED BY YOU AND POINTED OUT BY RO/FGMO/CO ARE RECTIFIED. IF 
              NOT, REASONS THEREOF.</td>
            <td width="13%" align="center"> 
              <select name="sel_irregular"  tabindex="5" onChange="showIrregular()">
                <option value="y">Yes</option>
                <option value="n">No</option>
              </select>
            </td>
            <td id="a2" width="35%"> 
              <textarea rows="4" name="txt_irregularities" cols="50" tabindex="6" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("mon_irregulardetails"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td colspan="2">ANY OTHER OBSERVATIONS/ ADVERSE FEATURES:<span class="mantatory">*&nbsp;</span></td>
            <td colspan="2"> 
              <textarea rows="4" name="txt_observations" cols="50" tabindex="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("mon_observationdetails"))%></textarea>
            </td>
          </tr>
		  <tr><td colspan="4">Nominated Officer</td></tr>
          <tr>
		    <td width="25%">Name</td>
            <td width="25%"><input type="text" name="txt_noname" maxlength="25" size="15" onKeyPress="allowAlphabetsForName()" value="<%=Helper.correctNull((String)hshValues.get("mon_noname"))%>"></td>
            <td width="25%">Designation</td>
            <td width="25%"><input type="text" name="txt_nodesgn" maxlength="25" size="15" onKeyPress="allowAlphabetsForName()" value="<%=Helper.correctNull((String)hshValues.get("mon_nodesgn"))%>"></td>
          </tr>
		   <tr><td colspan="4">Advances Incharge/Accountant</td></tr>
          <tr>
             
            <td width="25%">Name</td>
            <td width="25%"><input type="text" name="txt_ainame" maxlength="25" size="15" onKeyPress="allowAlphabetsForName()" value="<%=Helper.correctNull((String)hshValues.get("mon_ainame"))%>"></td>
            <td width="25%">Designation</td>
            <td width="25%"><input type="text" name="txt_aidesgn" maxlength="25" size="15" onKeyPress="allowAlphabetsForName()" value="<%=Helper.correctNull((String)hshValues.get("mon_aidesgn"))%>"></td>
          </tr>
		   <tr><td colspan="4">Branch Head</td></tr>
          <tr>
            <td width="25%">Name</td>
            <td width="25%"><input type="text" name="txt_bhname" maxlength="25" size="15" onKeyPress="allowAlphabetsForName()" value="<%=Helper.correctNull((String)hshValues.get("mon_bhname"))%>"></td>
            <td width="25%">Designation</td>
            <td width="25%"><input type="text" name="txt_bhdesgn" maxlength="25" size="15" onKeyPress="allowAlphabetsForName()" value="<%=Helper.correctNull((String)hshValues.get("mon_bhdesgn"))%>"></td>
          </tr>
        </table>
      </td>
          </tr>
          
        </table>
    
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail_Print' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>">
</form>
</body>
</html>
