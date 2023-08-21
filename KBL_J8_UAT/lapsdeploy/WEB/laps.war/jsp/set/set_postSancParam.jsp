<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
if (objValues instanceof java.util.HashMap) {
	hshValues = (java.util.HashMap) objValues;
}
ArrayList arrRow = new ArrayList();
ArrayList arrCol = new ArrayList();
arrRow = (ArrayList) hshValues.get("arrRow");

String strForm=Helper.correctNull((String)request.getParameter("hidParam"));
%>
<html>
<head>
<title>Post Sanction Parameters</title>


<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
function callonLoad()
{
	<%for(int j=0;j<arrRow.size();j++){
		arrCol=(ArrayList)arrRow.get(j);%>
			var sel_mul="<%=Helper.correctNull((String)arrCol.get(2))%>";
				 var sml = sel_mul.split("@");
				   for(var i=0;i<sml.length;i++)
				   {
					if(sml[i]=="C")
					{
						document.forms[0].txt_orgLevel[<%=j%>].options[0].selected=true;
					}
					else if(sml[i]=="R")
					{
						document.forms[0].txt_orgLevel[<%=j%>].options[1].selected=true;
					}
					else if(sml[i]=="D")
					{
						document.forms[0].txt_orgLevel[<%=j%>].options[2].selected=true;
					}
					else if(sml[i]=="A")
					{
						document.forms[0].txt_orgLevel[<%=j%>].options[3].selected=true;
					}
				  }
				   document.forms[0].txt_minClass[<%=j%>].value="<%=Helper.correctNull((String)arrCol.get(3))%>";
				   document.forms[0].txt_enabledisable[<%=j%>].value="<%=Helper.correctNull((String)arrCol.get(4))%>"; // added newly
					showDescClass(document.forms[0].txt_minClass[<%=j%>],<%=j%>);

	<%}%>

	disablefields(true);
	enableButtons(false, true, true, false);	
}

function disablefields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	
		if(document.forms[0].elements[i].type=='select-one'||document.forms[0].elements[i].type=='select-multiple')
		{
			document.forms[0].elements[i].disabled=one;
		}	
	}

	for(var i=0;i<document.forms[0].txt_class_desc.length;i++)
	{
		document.forms[0].txt_class_desc[i].readOnly=true;
	}
}

function doSave()
{	
	var count=0;
	for(i=0;i<document.forms[0].txt_orgLevel.length;i++)
    {	count=0;
		for(j=0;j<document.forms[0].txt_orgLevel[i].length;j++)
	   	{     
			if(document.forms[0].txt_orgLevel[i].options[j].selected==true)
     		{
	     		count++;
          	}
		}
		if(count<=0){
				alert("please Select Organisation Level ");
				document.forms[0].txt_orgLevel[i].focus();
				return false;
			}
    }

	for(var i=0;i<document.forms[0].txt_minClass.length;i++)
	{
		if(document.forms[0].txt_minClass[i].value==""){
		alert("Please Select Sanctioning/Approval authority ");	
		document.forms[0].txt_minClass[i].focus();
 		return ;
		}
	}
	//=====for adding multiple select values
	var s1="";
	for(i=0;i<document.forms[0].txt_orgLevel.length;i++)
    {
	  s1="";
		for(j=0;j<document.forms[0].txt_orgLevel[i].length;j++)
	   	{     
			if(document.forms[0].txt_orgLevel[i].options[j].selected==true)
     		{
	     			s1 = s1+ document.forms[0].txt_orgLevel[i].options[j].value+"@"; 
          	}
		}
		document.forms[0].hidtxt_orgLevel[i].value = s1;
	}
	disablefields(false);
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanGetMethod.value="updatePostSancParameters";
	document.forms[0].action=appURL+"action/set_postSancParam.jsp";	
	document.forms[0].submit();
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
		document.forms[0].hidBeanGetMethod.value="getPostSancParameters";
		document.forms[0].action=appURL+"action/set_postSancParam.jsp";	
		document.forms[0].submit();
	}
}

function doEdit() 
{
   	document.forms[0].hidAction.value="update";
	enableButtons(true, false, false, true);
	disablefields(false);
}
   
function enableButtons(bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}
function showDescClass(id,value)
{
	var val=id.value;
	for(i=0;i<document.forms[0].prd_class_value.length;i++)
		{
			if(val == document.forms[0].prd_class_value[i].value)
			{
				document.forms[0].prd_class_value.selectedIndex=i;
				if(document.forms[0].prd_class_value.options[document.forms[0].prd_class_value.selectedIndex].text == "Select")
					document.forms[0].txt_class_desc[value].value="";
				else
					document.forms[0].txt_class_desc[value].value=document.forms[0].prd_class_value.options[document.forms[0].prd_class_value.selectedIndex].text
			}
		}
}


</SCRIPT>
</head>
<body onload="callonLoad()">

<form name="appform" method="post" action="" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
	<%if(strForm.equalsIgnoreCase("P")){ %>
		<td class="page_flow">Home
		-&gt; Setup -&gt; Admin Level Controls -&gt; Post Sanction Retail Parameters </td>
		<%}else{ %>
		<td class="page_flow">Home
		-&gt; Setup -&gt; Admin Level Controls -&gt; Post Sanction Corporate/Agri Parameters </td>
		<%} %>
	</tr>
</table>
<table width="90%" border="0" cellpadding="5" cellspacing="0"
	 align="center" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable">

			<tr>
				<td valign="top">
				<table width="85%" border="0" cellspacing="0" cellpadding="5"
					align="center" class="outertable">
					<tr>
						<td valign="top" height="100px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="3"
								class="outertable border1 tableBg"	>
									<tr height="25" align="center" class="dataheader">
										<td nowrap width="5%"><b>
											Sl. no</b></td>
										<td nowrap width="50%"><b>
											Post Sanction Parameters</b></td>
										<td nowrap width="20%">
											<b>Organisation Level</b></td>
										<td nowrap width="25%"> 
										<b>Sanctioning/Approval authority</b></td>
											<td nowrap width="25%"> 
										<b>Enable/Disable</b></td>
									</tr>
								<%if(arrRow!=null && arrRow.size()>0){ 
									for(int i=0;i<arrRow.size();i++){
									arrCol=(ArrayList)arrRow.get(i);
								%>
									<tr>
										<td align="center"><%=i+1%>&nbsp;</td>
										<td><b><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;</b>
										<input type="hidden" name="hidparam_desc" value="<%=Helper.correctNull((String)arrCol.get(1))%>"></td>
										<td> <select name="txt_orgLevel" multiple>
											<option value="C">HEAD OFFICE</option>
											<option value="R">REGIONAL OFFICE</option>
											<option value="D">CLPU</option>
											<option value="A">BRANCH</option>
											</select> 
											<input type="hidden" name="hidtxt_orgLevel">
									 	</td>
										<td>
											<select
											name="txt_minClass"
											onChange=showDescClass(this,<%=i%>)>
											<option value="">Select</option>
											<lapschoice:usersclass />
											</select> &nbsp;&nbsp;&nbsp;
											<input type="text" name="txt_class_desc"><input type="hidden"  name="txt_id" value="">&nbsp;
										</td>
										<td> <select name="txt_enabledisable">
										<option value="S" Selected>Select</option>
											<option value="E">Enable</option>
											<option value="D">Disable</option>
											</select> 
									 	</td>
										<%}} %>
										<td style="visibility: hidden;position: absolute;"><select name="prd_class_value"
											style="width: 20">
											<option value="">Select</option>
											<lapschoice:usersclassdesc />
										</select></td>
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
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name=hidParam value="<%=Helper.correctNull((String)request.getParameter("hidParam")) %>" >
</form>
</body>
</html>
