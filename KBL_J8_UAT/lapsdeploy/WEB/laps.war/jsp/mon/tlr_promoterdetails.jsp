<%@include file="../share/directives.jsp"%>
<%
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
arrRow=(ArrayList)hshValues.get("arrRow");
%>
<html>
<head>
<title>Security Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
	
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
function enableButtons(valnew,valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdnew.disabled=valnew;
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		
		}
		else if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=!val;		
		}
	}
	
	
}

function onLoad()
{
	disableFields(true);
	
	
}

function doNew()
{
	document.forms[0].hidAction.value="Insert";
	disableFields(false);
	enableButtons(true,true,false,false,true,true);
}

function doEdit()
{
	document.forms[0].hidAction.value="Update";
	disableFields(false);
	enableButtons(true,true,false,false,true,true);
}

function doSave()
{

	if(document.forms[0].txt_proname.value == ""){
		alert("Enter in the Name Field");	
		return;
	}
	if(document.forms[0].txt_desig.value == ""){
		alert("Enter in the Designation Field");
		return;		
	}
	document.forms[0].hidBeanId.value="reviewtermloan";
	document.forms[0].hidBeanMethod.value="updatePromotersData";
	document.forms[0].hidBeanGetMethod.value="getPromotersData";
	document.forms[0].hidSourceUrl.value="/action/tlr_promoterdetails.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{
	if(ConfirmMsg(102)){
	document.forms[0].hidBeanId.value="reviewtermloan";
	document.forms[0].hidBeanGetMethod.value="getPromotersData";
	document.forms[0].action=appURL+"action/tlr_promoterdetails.jsp";
	document.forms[0].submit();
	}
}

function doDelete()
{
	if(ConfirmMsg(101)){
	document.forms[0].hidAction.value="Delete";
	document.forms[0].hidBeanId.value="reviewtermloan";
	document.forms[0].hidBeanMethod.value="updatePromotersData";
	document.forms[0].hidBeanGetMethod.value="getPromotersData";
	document.forms[0].hidSourceUrl.value="/action/tlr_promoterdetails.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
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

function palceValues(val1,val2,val3)
{
	document.forms[0].hidsno.value=val1;
	document.forms[0].txt_proname.value=val2;
	document.forms[0].txt_desig.value=val3;
	
	if(document.forms[0].btnenable.value=="Y")
		enableButtons(true,false,true,true,false,false);
}

function callOtherLink(page,bean,method)
{
	if(!document.forms[0].reviewYear.value=="")
	{
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

function callCalender(val)
{
	if(document.forms[0].cmdapply.disabled==false)
	{
		 showCal(appURL,val);
	}
}

</script>
</head>
<body onload="onLoad()">
<form name="frmpri" method=post class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	>
	<tr>
		<td>
			<lapschoice:tlrtag pageid="3" reviewof='<%=Helper.correctNull((String)request.getParameter("reviewOf"))%>' valuesin='<%=Helper.correctNull((String)request.getParameter("valuesin"))%>'/>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>

		<td valign="top" colspan="5" class="page_flow">Home -&gt; Term Loan - Review -&gt; Promoter</td>
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
<%if(Helper.correctNull((String)request.getParameter("reviewOf")).equals("2")){ %>	
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
		<tr>
			<td>
			<table width="30%" border="0" cellspacing="1" cellpadding="3" align="left" class="outertable">
				<tr>
					<td width="15%" align="center" class="sub_tab_active"><b>Promoters</b></td>	
				 <td width="15%" align="center" class="sub_tab_inactive">
				 <b> <a href="JavaScript:callOtherLink('tlr_groupconcerns.jsp','reviewtermloan','getGroupConcernData')">Group Concerns</a></b>
				  </td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
<%} %>	
<br>
<table width="65%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable border1">
<tr>
	<td valign="top" align="center" width="60%">
    <table width="90%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
      <tr> 
          <td valign="middle" width="9%" nowrap>Name <span class="mantatory">&nbsp;*</span></td>
          <td valign="top" width="40%" nowrap> 
            <input type="text" name="txt_proname" size="30" maxlength="100">
          </td>
          <td valign="middle" width="22%" nowrap>Designation <span class="mantatory">&nbsp;*</span></td>
          <td valign="top" width="29%" nowrap> 
            <input type="text" name="txt_desig" size="30" maxlength="100">
            </td>
        </tr>
        <tr> 
         
        </tr>
      </table>
     </td>
   </tr>
 </table>
    <br>
	<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
    <br>
  <table width="65%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable linebor">
    <tr class="dataheader">
		<td width="3%">&nbsp;</td>
		<td width="48%"><b>Name</b></td>
		<td width="48%"><b>Designation</b></td>
			
	</tr>
	<%
		if(arrRow!=null && arrRow.size()>0)
		{
			for(int i=0; i<arrRow.size();i++)
			{
				arrCol=(ArrayList)arrRow.get(i);
	%>
	<tr valign="top" class="datagrid">
		<td width="3%"><input type="radio" name="rdosec"
			onclick="palceValues('<%=Helper.correctNull((String)arrCol.get(0))%>',
			'<%=Helper.correctNull((String)arrCol.get(1))%>','<%=Helper.correctNull((String)arrCol.get(2))%>')"
			style="border: none"></td>
		<td width="31%"><%=Helper.correctNull((String)arrCol.get(1))%>&nbsp;</td>
		<td width="34%" class="jsut"><%=Helper.correctNull((String)arrCol.get(2))%>&nbsp;</td>
		
	</tr>
	<%
			}
		}
	else{ %>
	<tr class="datagrid">
		<td colspan="3" align="center">No Data</td>
	</tr>
	<%} %>
</table>
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidsno" />
<input type="hidden" name="reviewOf" value="<%=request.getParameter("reviewOf")%>"></form>
</body>
</html>

