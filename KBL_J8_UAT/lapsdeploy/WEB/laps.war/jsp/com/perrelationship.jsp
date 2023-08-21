<%@include file="../share/directives.jsp"%>
<%ArrayList v = new ArrayList();
	v = (ArrayList) hshValues.get("vecRow");
	ArrayList g1 = new ArrayList();
	
	String strcomid = Helper.correctNull((String) request.getParameter("id1"));
	if (strcomid.equalsIgnoreCase("")) 
	{
		strcomid = Helper.correctNull((String) hshValues.get("hid_comappid2"));
	}%>
<html>
<head>
<title>Relationship details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function selectValues(val1, val2, val3, val4, val5, val6,val7)
{
	document.forms[0].comapp_sno.value =val7;
	document.forms[0].comapp_id.value = val1;
	document.forms[0].txt_empno.value= val2;
	document.forms[0].txt_borrel.value= val3;
	document.forms[0].txt_scale.value= val4;
	document.forms[0].txt_placepost.value = val5;
	document.forms[0].txt_loancomments.value = val6;

	var exist="<%=Helper.correctNull((String)request.getParameter("exist"))%>";
	if(document.forms[0].readFlag.value.toUpperCase()=="W")
	{
	    if(exist=="e")
	    {
	       	disableFields(true);
	    	disableCommandButtons("disableall");
	    }
	    else if(document.forms[0].hidappexist.value=="true")
		{
			disableFields(true);
	    	disableCommandButtons("disableall");
		}
		else
		{
		   	disableFields(true);
	    	disableCommandButtons("radioselect");
		}
	}		
}
function doSave()
{
	if(document.forms[0].txt_empno.value=="")
	{
		alert("Please enter the Employee No.");
		return;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="commappmaster";
	document.forms[0].hidSourceUrl.value="/action/perrelationship.jsp";
	document.forms[0].hidBeanMethod.value="updatereldetails";
	document.forms[0].hidBeanGetMethod.value="getreldetails";
	document.forms[0].action=appURL+"controllerservlet";
	disableCommandButtons("disableall");
	document.forms[0].submit();
}
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		document.forms[0].cmdnew.disabled =false;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}
	if(val=="edit")
	{	 
		 document.forms[0].cmdnew.disabled =true;
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	if(val=="radioselect")
	{	 
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=false;
	}	  
	if(val=="disableall")
	{
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");	
}
function doNew()
{
	disableFields(true);
	disableCommandButtons("edit");		
	document.forms[0].txt_empno.value="";	 
	document.forms[0].txt_borrel.value="";
	document.forms[0].txt_scale.value="";
	document.forms[0].txt_placepost.value="";
	document.forms[0].txt_loancomments.value="";
	document.forms[0].hidAction.value ="insert";
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getreldetails";
		document.forms[0].hidBeanId.value="commappmaster";
		document.forms[0].action=appURL+"action/perrelationship.jsp";	
		document.forms[0].submit();
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
		else if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	  
		else if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}	
		else if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].checked=!val;
		} 
	}
	document.forms[0].txt_loancomments.readOnly = val;
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value="Delete";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidBeanId.value="commappmaster";
			document.forms[0].hidSourceUrl.value="/action/perrelationship.jsp";
			document.forms[0].hidBeanMethod.value="updatereldetails";
			document.forms[0].hidBeanGetMethod.value="getreldetails";	
			document.forms[0].submit();
	   }
    }
	else
	{
		ShowAlert(158);
	}
}
function onloading()
{	 
    var exist="<%=Helper.correctNull((String)request.getParameter("exist"))%>";
    if(exist=="e")
    {
       	disableFields(true);
    	disableCommandButtons("disableall");
    }
    else if(document.forms[0].hidappexist.value=="true")
	{
		disableFields(true);
    	disableCommandButtons("disableall");
	}
    else
    {
      	disableFields(true);
		disableCommandButtons("load");
    }
	document.forms[0].hidAction.value ="";
}
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		window.close();
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Customer Profile -&gt; Demographics -&gt; Company Details -&gt; Relationship Details</td>
	</tr>	
</table>
<table width="98%" border="0" cellpadding="5" cellspacing="0" class="outertable" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable" >
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" >
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" >
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
									<tr align="center" class="dataheader">
										<td width="16%"  >Employee No<span class="mantatory"><b>*</b></span></td>
										<td width="24%"  >Relationship with the Borrower</td>
										<td width="13%"  >Scale/Grade</td>
										<td width="16%"  >Place of posting</td>
										<td width="31%"  >
											Whether the loan given to relatives of
										Staff</td>
									</tr>
									<tr class="datagrid">
										<td bgcolor="" width="16%"><input type="text" name="txt_empno"
											size="20" maxlength="18" onKeyPress="allowInteger()">
										</td>
										<td bgcolor="" width="24%"><input type="text"
											name="txt_borrel" size="30" maxlength="30"
											onKeyPress="notAllowSplChar()"></td>
										<td bgcolor="" width="13%"><input type="text" name="txt_scale"
											size="15" maxlength="15" onKeyPress="allowAlphaNumeric()"
											style="{text-align=left}">
										</td>
										<td bgcolor="" width="16%"><INPUT TYPE="text"
											NAME="txt_placepost" SIZE="15" MAXLENGTH="15"
											ONKEYPRESS="notAllowSplChar()"></td>
										<td bgcolor="" width="31%"><textarea name="txt_loancomments"
											onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)"
											notAllowSingleQuote()"
											rows="3" cols="50"
											wrap="virtual" maxlength="500"><%=Helper.correctNull((String) hshValues
									.get("strDet"))%></textarea></td>
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
							<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
							<br>
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" >
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor" >
											<tr class="dataheader">
												<td width="20%" align="center" >Employee No</td>
												<td width="18%" align="center" >Relationship with the applicant</td>
												<td width="19%" align="center" >Scale/Grade</td>
												<td width="18%" align="center" >Place of posting</td>
												<td width="25%" align="center" >Whether the loan given to relatives of Staff</td>
											</tr>
										</table>
										</td>

					  </tr>
					  <tr>
					  <td><%if(v.size()>6){ %><div class="cellContainer"><%} %>
                      <table width="100%" border="0" cellspacing="1" cellpadding="3">
										<%v = (ArrayList) hshValues.get("vecRow");			
			if (v != null) {
				int vecsize = v.size();
				for (int l = 0; l < vecsize; l++) {
					g1 = (ArrayList) v.get(l);

					%>
											<tr class="datagrid">
												<td width="20%" ><b><a
													href="javascript:selectValues('<%=Helper.correctNull((String)g1.get(0))%>',
                                            '<%=Helper.correctNull((String)g1.get(1))%>','<%=Helper.correctNull((String)g1.get(2))%>',
                                            '<%=Helper.correctNull((String)g1.get(3))%>','<%=Helper.correctNull((String)g1.get(4))%>',
                                             '<%=Helper.correctNull((String)g1.get(5))%>','<%=Helper.correctNull((String)g1.get(6))%>');"
													class="blackfont"> <%=Helper.correctNull((String) g1
											.get(1))%></a></b></td>
												<td width="18%" >&nbsp;<%=Helper.correctNull((String) g1
											.get(2))%></td>
												<td width="19%">&nbsp;<%=Helper.correctNull((String) g1
											.get(3))%></td>
												<td width="18%" >&nbsp;<%=Helper.correctNull((String) g1
											.get(4))%></td>
												<td width="25%" >&nbsp;<%=Helper.correctNull((String) g1
											.get(5))%></td>
											</tr>
											<%}}%>
											
										</table><%if(v.size()>6){ %></div><%} %>
										</td>
									</tr>
								</table>
								
								<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="comapp_id" value="<%=Helper.correctNull((String)hshValues.get("comapp_id"))%>">
<input type="hidden" name="comapp_sno" value="<%=Helper.correctNull((String)hshValues.get("comapp_relsno"))%>">
<input type="hidden" name="hidappexist" value="<%=Helper.correctNull((String)request.getParameter("hidappexist"))%>">
<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
</form>
</body>
</html>
