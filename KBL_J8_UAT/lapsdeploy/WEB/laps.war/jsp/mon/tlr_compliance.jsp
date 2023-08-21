<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css" />
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script>
var doccheck = "<%= Helper.correctNull((String)hshValues.get("tlr_doccheck"))%>";

function disableCommandButtons(val)
{
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

function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{  
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	} 
}


function onLoading()
{
	
	if(doccheck != "")
	{
		 document.forms[0].sel_docvalid.value=doccheck;
	}else
	{
		 document.forms[0].sel_docvalid.value="S";
	}
	disableFields(true);
}

function doDelete()
{
	if(ConfirmMsg(101))
	{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updateComplianceData";
		document.forms[0].hidBeanGetMethod.value="getComplianceData";
		document.forms[0].hidBeanId.value="reviewtermloantwo";
		document.forms[0].hidSourceUrl.value="action/tlr_compliance.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}
}

function doEdit()
{ 	
	if(document.forms[0].reviewOf.value=="")
	{
		alert("Select Review of");
		return;
	}	
    document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
}

function callDescHelp(page)
{	
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = appURL+"action/comindustrymasterhelp.jsp?page="+page;
		var title = "IndustryHelp";
		var prop = "scrollbars=no,width=650,height=400";	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);	
	}
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="";
		document.forms[0].hidBeanId.value="reviewtermloantwo";
		document.forms[0].hidBeanGetMethod.value="getComplianceData";
		document.forms[0].action=appURL +"action/tlr_compliance.jsp";
	    document.forms[0].submit();	
	}	
}
function doSave()
{
	    document.forms[0].hidBeanId.value="reviewtermloantwo";
   		document.forms[0].hidBeanMethod.value="updateComplianceData";
		document.forms[0].hidBeanGetMethod.value="getComplianceData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/tlr_compliance.jsp";
		document.forms[0].submit();
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}		  
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].disabled=val;
		}
		 
	}

	
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mon_borrowersearch.jsp?hidmontype=MONITREVIEW";
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
function callOtherLink(page,bean,method)
{
	if(!document.forms[0].reviewYear.value=="")
	{
		document.forms[0].reviewOf.disabled=false;
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		alert("Select Review Year");
	}
}
</script>
</head>
<body onload="onLoading()">
<form name="safaeri3" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<lapschoice:tlrtag pageid="11" reviewof='<%=Helper.correctNull((String)request.getParameter("reviewOf"))%>' valuesin='<%=Helper.correctNull((String)request.getParameter("valuesin"))%>'/>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colspan="5" class="page_flow">Home -&gt; Term Loan - Review -&gt; Compliance</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
			<tr>
				<td><lapschoice:MonitorReview /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="1" align="center" class="outertable border1">
	<tr align="center">
		<td valign="top">
<table width="95%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
      <tr> 
        <td>Completion of Mortgage 
          formalities</td>
        <td> 
          <textarea name="txt_mortgageformal" cols="75" rows="4" 
				onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
								.get("tlr_formalities"))%></textarea>
        </td>
      </tr>
      <tr> 
        <td>Registration of Charges 
          with ROC/ Date of last search report held on records</td>
        <td> 
          <textarea name="txt_regcharges" cols="75" rows="4" 
				onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
								.get("tlr_registrationcharge"))%></textarea>
        </td>
      </tr>
      <tr> 
        <td>Whether documents 
          are valid and in force</td>
        <td> 
          <select name="sel_docvalid">
            <option value="S" selected="selected">&lt;---Select---&gt;</option>
            <option value="Y">Yes</option>
            <option value="N">No</option>
          </select>
        </td>
      </tr>
      <tr> 
        <td >Date of last DBC obtained 
          </td>
        <td > 
          <table>
            <tr> 
              <td> 
                <input type="text" name="txt_dbcdate" size="12"
							maxlength="10"
							onBlur="checkDate(this)" value="<%=Helper.correctNull((String)hshValues.get("tlr_dbcdate"))%>">
              </td>
              <td> <a
							alt="Select date from calender" href="#"
							onClick="callCalender('txt_dbcdate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender"></a> </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr> 
        <td >Date of last inspection 
          of securities</td>
        <td > 
          <table>
            <tr> 
              <td> 
                <input type="text" name="txt_inspecdate" size="12"
							maxlength="10"
							onBlur="checkDate(this)" value="<%=Helper.correctNull((String)hshValues.get("tlr_inspectiondate"))%>">
              </td>
              <td> <a
							alt="Select date from calender" href="#"
							onClick="callCalender('txt_inspecdate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender"></a> </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr> 
        <td>Whether securities 
          are adequately insured and valid policy on record.</td>
        <td > 
          <textarea name="txt_adequatesec" cols="75" rows="4" 
				onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
								.get("tlr_secdesc"))%></textarea>
        </td>
      </tr>
      <tr> 
        <td >Observation of the 
          inspecting official/Irregularities if any and compliance thereof</td>
        <td> 
          <textarea name="txt_observ" cols="75" rows="4" 
				onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
								.get("tlr_observ"))%></textarea>
        </td>
      </tr>
      </table>
    </td>
  </tr>
</table><br>    
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
 <input type="hidden" name="reviewOf" value="<%=request.getParameter("reviewOf")%>">
 <input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("AuditFlag"))%>">
 </form>
</body>

</html>

