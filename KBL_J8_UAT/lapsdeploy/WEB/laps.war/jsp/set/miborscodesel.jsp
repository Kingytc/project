<%@include file="../share/directives.jsp"%>
<html>
<%
ArrayList arrRow = new ArrayList();
ArrayList arrCol = new ArrayList();

int intLength=0;
if(hshValues!=null&&hshValues.size()>0)
{
	arrRow=(ArrayList)hshValues.get("arrRow");
}

if(arrRow!=null)
	intLength=arrRow.size();
%>
<head>
<title>Re Appraiser Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<SCRIPT LANGUAGE="JavaScript">


var appURL="<%=ApplicationParams.getAppUrl()%>";

function chkdetails(i)
{
	var len = "<%=intLength%>";
	if(len>1)
	{
		if(document.forms[0].chk_mibor1[i].checked == true)
		{
			document.forms[0].chk_mibor2[i].value="Y";
		}
		else
		{
			document.forms[0].chk_mibor2[i].value="N";
		}
	}
	else 
	{
		if(document.forms[0].chk_mibor1.checked == true)
		{
			document.forms[0].chk_mibor2.value="Y";
		}
		else
		{
			document.forms[0].chk_mibor2.value="N";
		}
	}
}
function onloading()
{
	disableFields(true);
	//document.forms[0].cmdselectall.disabled=false;
	enableButtons(false,true,true,true,false,true)
}
function disableFields(one)
{
	

	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=="checkbox")
		{	
			document.forms[0].elements[i].disabled=one;		  
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=one;		  
		} 
	}
	
}
function doSelectAll()
{
	enableButtons(true,true,false,false,true,false)
	for(var i=0;i<document.forms[0].chk_mibor1.length;i++)
	{
		document.forms[0].chk_mibor1[i].checked = true;
		document.forms[0].chk_mibor2[i].value="Y";
	}

}

function doDeselectAll()
{
	enableButtons(true,false,false,false,true,true)
	for(var i=0;i<document.forms[0].chk_mibor1.length;i++)
	{
		document.forms[0].chk_mibor1[i].checked = false;
		document.forms[0].chk_mibor2[i].value="N";
	}
}

function doEdit()
{
	enableButtons(true,false,false,false,true,false)
	disableFields(false);
}

function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdselectall.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;	
	document.forms[0].cmdcancel.disabled=bool4;  	
	document.forms[0].cmdclose.disabled=bool5;
	document.forms[0].cmddeselectall.disabled=bool6;
	

}
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanGetMethod.value="getmiborbranchlist";
		document.forms[0].action=appURL+"action/miborscodesel.jsp";	
		document.forms[0].submit();
	}
}
function doSave()
{
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanMethod.value="updatemiborbranchlist";
	document.forms[0].hidBeanGetMethod.value="getmiborbranchlist";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/miborscodesel.jsp";
	document.forms[0].submit();
}

</SCRIPT>
<style>


select::-ms-expand {
    display: none;
    
}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading();">
<form name="appform" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
	
		<td class="page_flow">Home
		-&gt; Setup -&gt; Admin Level Controls -&gt; MIBOR Branch Selection </td>
	</tr>
</table>
<table align="center" width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr class="dataheader">
 <th width="10%">Sl.no</th>
		<td align="center" width="20%">Organization</td>
		<td align="center" width="20%">Organization scode</td>
		<td align="center"  width="20%">MIBOR Required or not check box</td>
</tr>
<%
			if (arrRow != null && arrRow.size() > 0) {
				if (arrRow.size() > 0) {
					for (int i = 0; i < arrRow.size(); i++) {
						arrCol = (ArrayList) arrRow.get(i);
						%>
			<tr class="datagrid">
			
				<td width="20%" align="center"><%=i+1%></td>
				<td width="20%" align="center"><%=Helper.correctNull((String)arrCol.get(0))%></td>
				<td width="20%" align="center"><%=Helper.correctNull((String)arrCol.get(2))%></td> 
				
				<td width="20%" align="center"><input type="checkbox" name="chk_mibor1" style="border: none;" onclick="chkdetails(<%=i%>)"
                        <%if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Y")){ %>checked<%} %>>
                        <input type="hidden" name="chk_mibor2" value="<%=Helper.correctNull((String)arrCol.get(4))%>">
                        <input type="hidden" name="org_name" value="<%=Helper.correctNull((String)arrCol.get(0))%>">
                        <input type="hidden" name="org_code" value="<%=Helper.correctNull((String)arrCol.get(1))%>">
                        <input type="hidden" name="org_scode" value="<%=Helper.correctNull((String)arrCol.get(2))%>">
                        <input type="hidden" name="org_level" value="<%=Helper.correctNull((String)arrCol.get(3))%>"></td>

			<%}
				}%>
			</tr>
			<%}%>
			<tr >
			<td colspan="4">
			<br>
			<lapschoice:combuttonnew 	btnnames='Edit_Select All_Deselect All_Save_Cancel' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
			</td>
			</tr>
</table>
<lapschoice:hiddentag  pageid="<%=PageId%>"/> 
</form>
</body>
</html>
