<%@include file="../share/directives.jsp"%>
<%int intcount=2;
ArrayList listRow=(ArrayList)hshValues.get("listRow");
ArrayList listCol=new ArrayList();
if(listRow!=null && listRow.size()>0)
{
	intcount=listRow.size();
}
%>
<html>
<head>
<title>GST Details</title>
<script language="JavaScript1.2">
var varCount="<%=intcount%>";
function disablefields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=val;
		}	  
	}
}
function disableCommandButtons(valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmdclose.disabled=valclose;
}
function doEdit()
{
	disablefields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons(true,false,false,false,true);
}
function doSave()
{

	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanMethod.value="updateGSTDetails";
	document.forms[0].hidBeanGetMethod.value="getGSTDetails";
	document.forms[0].hidSourceUrl.value="/action/pergstdetails.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}


function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].hidBeanGetMethod.value="getGSTDetails";
		document.forms[0].action=appURL+"action/pergstdetails.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";		
		document.forms[0].hidBeanMethod.value="updateGSTDetails";
		document.forms[0].hidBeanGetMethod.value="getGSTDetails";
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidSourceUrl.value="/action/pergstdetails.jsp";			
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}

function callonLoad()
{
	disablefields(true);
}
function chkYearVal(obj)
{
	for(var i=1;i<=varCount;i++)
	{
		if((obj!=document.forms[0].txt_year[i-1]) &&(obj.value==document.forms[0].txt_year[i-1].value))
		{
			alert("Year already exists");
			obj.value="";
			obj.focus();
			return;
		}
	}
}
</script>
</head>
<body onload="callonLoad()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url=""><script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>
<form class="normal">
<% if(strCategoryType.equals("DIGI")){  %>
      
    <table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkerdigi.jsp" flush="true" > 
        <jsp:param name="pageid" value="1" />
        </jsp:include></td>
	</tr>
    <tr> 
		 <td class="page_flow">Home -&gt; Digi Retail -&gt; Application -&gt; Loan Particulars -&gt; GST Return Details</td>
    </tr>
    </table>  
      <lapschoice:application />
      <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="bottom">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left" class="outertable">
			<tr align="center">
				<td><jsp:include page="../per/applicantTabDigi.jsp" flush="true">
					<jsp:param name="linkid" value="25" />
				</jsp:include></td>
			</tr>
		</table>
		<br/><br/>
		</td>
	</tr>
</table>
      <% } else { %>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Retail -&gt; Application -&gt;
		Loan Particulars -&gt; GST Return Details</td>
	</tr>
</table>
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="bottom">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left" class="outertable">
			<tr align="center">
				<td><jsp:include page="../per/applicanttab.jsp" flush="true">
					<jsp:param name="linkid" value="25" />
				</jsp:include></td>
			</tr>
		</table>
		<br/><br/>
		</td>
	</tr>
</table>
 <% }%>
<table width="80%" border="1" cellspacing="0" cellpadding="5"
	class="outertable" align="center">
	<tr>
		<td>
		<br/>
		<table width="40%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr class="dataheader" align="center">
			<td width="50%">Year</td>
			<td width="50%">Amount</td>
			</tr>
			<%if(listRow!=null && listRow.size()>0)
			{
				for(int i=0;i<listRow.size();i++)
				{
					listCol=(ArrayList)listRow.get(i);%>
					
					<tr class="datagrid" align="center">
						<td><input type="text" name="txt_year" size="6" onkeypress="allowWholeNumber(this)" title="Year" maxlength="4" onblur="checkcurrentyear(this);chkYearVal(this);"
						value="<%=Helper.correctNull((String)listCol.get(0)) %>"></td>
						<td><input type="text" name="txt_amt"  style="text-align: right;" value="<%=Helper.correctNull((String)listCol.get(1)) %>"  
						onblur="roundtxt(this);" size="15" onkeypress="allowNegtiveNumber(this)" maxlength="12">
					</tr>
				
			<%	}
			}
			else
			{ %>
				<%for(int i=0;i<intcount;i++){ %>
			<tr class="datagrid" align="center">
			<td><input type="text" name="txt_year" size="6" onkeypress="allowWholeNumber(this)" title="Year" maxlength="4" onblur="checkcurrentyear(this);chkYearVal(this);"></td>
			<td><input type="text" name="txt_amt"  style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("")) %>"  
			onblur="roundtxt(this);" size="15" onkeypress="allowNegtiveNumber(this)" maxlength="12">
			</tr>
				<%}
			} %>

		</table>
		<br/>
		</td>
	</tr>
</table>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' /></form>
</body>
</html>