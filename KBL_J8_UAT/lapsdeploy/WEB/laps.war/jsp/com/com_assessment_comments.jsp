<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Financial Position Comments</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var selcomments="<%=Helper.correctNull((String) hshValues.get("selcoment"))%>";
var appno="<%=request.getParameter("appno")%>";

function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
        document.forms[0].hidBeanId.value="";
	    document.forms[0].action=appURL+"action/"+"corppge.jsp";	
		document.forms[0].submit();
	}
}
function doDelete()
{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].hidBeanId.value="compro";
    document.forms[0].hidBeanMethod.value="updateFinancialComments";
	document.forms[0].hidBeanGetMethod.value="getFinancialComments";
	document.forms[0].hidSourceUrl.value="action/com_assessment_comments.jsp";	
	document.forms[0].action=appURL+"action/controllerservlet";	
	document.forms[0].submit();
}
function doSave()
{ 	
	if(document.forms[0].sel_commentstype.value =="s")
	{
		alert("Please Select comment on");
		document.forms[0].sel_commentstype.focus();
		document.forms[0].txt_comments.value="";
		EditorEnableDisable("id_div","block","id_editor","none");
		return;
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="compro";
	document.forms[0].hidBeanMethod.value="updateFinancialComments";
	document.forms[0].hidBeanGetMethod.value="getFinancialComments";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_assessment_comments.jsp";
	document.forms[0].submit();
}
function disableCommandButtons(val)
{
	if(val=="load")
	{
		if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
	  	{
		if(document.forms[0].btnenable.value =='N')
	  	{
			document.forms[0].cmdnew.disabled=true;
		  	document.forms[0].cmdedit.disabled=true;
		  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
	 	}
	  	}
	 	else
	 	{
	 		document.forms[0].cmdedit.disabled=false;
	 	  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
		  	//document.forms[0].cmdcomments.disabled=false;
	 	}
	}
	if(val=="edit")
	{
		if(document.forms[0].btnenable.value =='N')
	  	{
			document.forms[0].cmdnew.disabled=true;
		  	document.forms[0].cmdedit.disabled=true;
		  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
	 	}
	 	else
	 	{
			document.forms[0].cmdedit.disabled=true;
			document.forms[0].cmddelete.disabled=false;
			document.forms[0].cmdsave.disabled=false;
			document.forms[0].cmdcancel.disabled=false;
			//document.forms[0].cmdcomments.disabled=false;
			if(document.forms[0].appno.value != "new")
			{
				document.forms[0].cmdclose.disabled=true;
			}
			else
			{
				document.forms[0].cmdclose.disabled=false;
				document.forms[0].cmddelete.disabled=true;
				document.forms[0].cmdcancel.disabled=true;
			}
		}
		disableFields(false);
	}
}
function onLoading()
{
	if(selcomments=="")
	{
		document.forms[0].sel_commentstype.value="s";
	}
	else
	{
		document.forms[0].sel_commentstype.value=selcomments;
		
	}				
	 //disableCommandButtons("load");
	 disableFields(true);
	 EditorEnableDisable("id_div","block","id_editor","none");

	 if(document.forms[0].sel_commentstype.value=="15")
	 {
		 document.all.idtable.style.display="table";
	 }
	 else
	 {
		 document.all.idtable.style.display="none"; 
	 }
}
function doEdit()
{

	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('txt_comments');
	document.forms[0].txt_amt[3].readOnly=true;
	document.forms[0].txt_amt[6].readOnly=true;
	document.forms[0].txt_amt[8].readOnly=true;
}
function disableFields(val)
{
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  if(document.forms[0].elements[i].type=='textarea'  )
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
	  }
}
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="compro";
		document.forms[0].hidBeanMethod.value="updateFinancialComments";
		document.forms[0].hidBeanGetMethod.value="getFinancialComments";
		document.forms[0].action=appURL+"action/com_assessment_comments.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}

function getCollData()
{
	document.forms[0].hidBeanId.value="compro";
	document.forms[0].hidBeanGetMethod.value="getFinancialComments";
	document.forms[0].action=appURL+"action/com_assessment_comments.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
	onLoading();
}
function doComments()
{
	var strAppno =appno;
	var pagetype = document.forms[0].hidCommentPage.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/com_comments.jsp?hidBeanId=comproposal&hidBeanGetMethod=getDataComments&pagetype="+pagetype+"&strAppno="+strAppno;
	window.open(url,"Comments",prop);
}
function calTotal()
{
	if(document.forms[0].txt_amt[0].value=="")
		document.forms[0].txt_amt[0].value="0.00";
	if(document.forms[0].txt_amt[1].value=="")
		document.forms[0].txt_amt[1].value="0.00";
	if(document.forms[0].txt_amt[2].value=="")
		document.forms[0].txt_amt[2].value="0.00";
	if(document.forms[0].txt_amt[4].value=="")
		document.forms[0].txt_amt[4].value="0.00";
	if(document.forms[0].txt_amt[5].value=="")
		document.forms[0].txt_amt[5].value="0.00";
	if(document.forms[0].txt_amt[7].value=="")
		document.forms[0].txt_amt[7].value="0.00";
	document.forms[0].txt_amt[3].value=eval(document.forms[0].txt_amt[0].value)+eval(document.forms[0].txt_amt[1].value)+eval(document.forms[0].txt_amt[2].value);
	document.forms[0].txt_amt[3].value=roundVal(document.forms[0].txt_amt[3].value);
	document.forms[0].txt_amt[6].value=eval(document.forms[0].txt_amt[3].value)-eval(document.forms[0].txt_amt[4].value)-eval(document.forms[0].txt_amt[5].value);
	document.forms[0].txt_amt[6].value=roundVal(document.forms[0].txt_amt[6].value);
	document.forms[0].txt_amt[8].value=eval(document.forms[0].txt_amt[6].value)-eval(document.forms[0].txt_amt[7].value);
	document.forms[0].txt_amt[8].value=roundVal(document.forms[0].txt_amt[8].value);
}
</script>
</head>
<body onload="onLoading()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">
if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>
	<form method = post class="normal">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"	flush="true">
			<jsp:param name="pageid" value="41" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
		</tr>          
       <tr>
 	   <td class="page_flow">
 		Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Assessment -&gt; Assessment Comments
	   </td>
       </tr>         
        </table>
<span style="display:none;"><lapschoice:borrowertype /></span><lapschoice:application />
<jsp:include page="../com/com_commentstab.jsp" flush="true">
		<jsp:param name="tabid" value="34" />
	</jsp:include>	
 <table width="98%" align="center" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
<tr>
<td>
    <table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
  <tr> 
    <td width="20%" nowrap="nowrap"><br><b>Justification for Assessment <span class="mantatory">*</span></b>&nbsp;
    <select name="sel_commentstype" tabindex="1" onchange="getCollData()">
		<option value="s" selected>----select----</option>
		<option value="1">Break up of limits</option>
		<option value="13">Comment on Stock of Work in Process/Progress</option>
		<option value="14" title="Comment on Comparison with Peer Concerns in the Industry with particular reference to Working Capital Cycle as well as comments on bank's exposure to the Sector (Industry Exposure) and experience">Comment on Comparison with Peer Concerns in the Industry with particular reference to Working Capital Cycle as well as comments on bank's exposure to the Sector (Industry Exposure) and experience </option>
        <option value="15" title="Availability of drawing power/ calculation of DP for the assessment period">Availability of drawing power/ calculation of DP for the assessment period</option>
<!--  	<option value="2">Bank Guarantee</option>	-->					<!-- Commented by Dinesh on 23/04/2014 as per Banker req. -->
		<option value="2">Cash Margin</option>
		<option value="3">Inventory</option>
		<option value="4">Expenditure</option>
		<option value="5">Receivables</option>
		<option value="16">Age wise Debtor Analysis</option>
		<option value="6">Turnover</option>
		<option value="7">Creditors</option>
		<option value="17" title="Capacity to retire the obligations under LC/BG/Buyers">Capacity to retire the obligations under LC/BG/Buyers</option>
		<option value="18" >Capacity to Perform under Bank Guarantee</option>
		<option value="19">Offer comments about Cash margin</option>
		<option value="20">Comments on Expired BG's</option>
		<option value="8">Profit and Loss</option>					
		<option value="9">Other Current Assets and Liabilities</option>
<!-- 	<option value="10">Justification for sales</option>		-->
<!-- 	<option value="11">Estimates of sales</option>		-->
		<option value="12">Others</option>
		</select>
    </td>
  </tr>  
  <tr><td>&nbsp;</td> </tr>  
  <tr>
  <td>
  <table width="90%"  border="0"   cellpadding="4"  class="outertable" align="center"  style="border: 1px solid #bbb;" id="idtable">
							  <tr class="dataheader">
									<td width="20%" align="center"> Particulars</td>
									<td  width="25%" align="center"> Amount</td>
							</tr>
							<tr class="datagrid">
							<td><input type="hidden" name="txt_desc" value="PIA">Projected Inventories (Accepted) </td>
							<td align="center"><input type="text" name="txt_amt"  style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strCommentsPIA")) %>"  onblur="roundtxt(this);calTotal();" size="15" onkeypress="allowInteger()" maxlength="12"></td>
							</tr>
							<tr class="datagrid">
							<td><input type="hidden" name="txt_desc" value="PR">Projected Receivables</td>
							<td align="center"><input type="text" name="txt_amt"  style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strCommentsPR")) %>" onblur="roundtxt(this);calTotal();" size="15" onkeypress="allowInteger()" maxlength="12"></td>
							</tr>
							<tr class="datagrid">
							<td><input type="hidden" name="txt_desc" value="PAPS">Projected Advance paid to suppliers</td>
							<td align="center"><input type="text" name="txt_amt" style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strCommentsPAPS")) %>"  onblur="roundtxt(this);calTotal();" size="15" onkeypress="allowInteger()" maxlength="12"></td>
							</tr>
							<tr class="datagrid">
							<td><input type="hidden" name="txt_desc" value="TOT1">Total</td>
							<td align="center"><input type="text" name="txt_amt" style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strCommentsTOT1")) %>"  onblur="roundtxt(this);calTotal();" size="15" onkeypress="allowInteger()" maxlength="12"></td>
							</tr>
							<tr class="datagrid">
							<td><input type="hidden" name="txt_desc" value="TC">Less: Trade Creditors (Accepted)</td>
							<td align="center"><input type="text" name="txt_amt" style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strCommentsTC")) %>"  onblur="roundtxt(this);calTotal();" size="15" onkeypress="allowInteger()" maxlength="12"></td>
							</tr>
							<tr class="datagrid">
							<td><input type="hidden" name="txt_desc" value="PARC">Less: Projected Advance received from customers</td>
							<td align="center"><input type="text" name="txt_amt" style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strCommentsPARC")) %>"  onblur="roundtxt(this);calTotal();" size="15" onkeypress="allowInteger()" maxlength="12"></td>
							</tr>
							<tr class="datagrid">
							<td><input type="hidden" name="txt_desc" value="TOT2">Total</td>
							<td align="center"><input type="text" name="txt_amt" style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strCommentsTOT2")) %>"  onblur="roundtxt(this);calTotal();" size="15" onkeypress="allowInteger()" maxlength="12"></td>
							</tr>
							<tr class="datagrid">
							<td><input type="hidden" name="txt_desc" value="LM">Less Margin</td>
							<td align="center"><input type="text" name="txt_amt" style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strCommentsLM")) %>"  onblur="roundtxt(this);calTotal();" size="15" onkeypress="allowInteger()" maxlength="12"></td>
							</tr>
							<tr class="datagrid">
							<td><input type="hidden" name="txt_desc" value="DPA">Drawing Power Available</td>
							<td align="center"><input type="text" name="txt_amt" style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strCommentsDPA")) %>"  onblur="roundtxt(this);calTotal();" size="15" onkeypress="allowInteger()" maxlength="12"></td>
							</tr>
							<tr class="datagrid">
							<td><input type="hidden" name="txt_desc" value="LR">Limit Recommended</td>
							<td align="center"><input type="text" name="txt_amt" style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strCommentsLR")) %>"  onblur="roundtxt(this);calTotal();" size="15" onkeypress="allowInteger()" maxlength="12"></td>
							</tr>
							</table>
  </td>
  </tr>
  <tr class="dataheader"> 
    <td width="20%">&nbsp;Comments</td>
    </tr>
   <tr class="datagrid"> 
    <td width="60%"> 
      <div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("comments")) %></div></div>
					 <div id="id_editor">
				
      <textarea name="txt_comments" cols="100"  onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" rows="8" tabindex="2" wrap="VIRTUAL"><%=Helper.correctNull((String)hshValues.get("comments"))%></textarea></div>
 </td>
 </tr>
 </table>
  <br>

 </td>
 </tr>
 </table>
 <br> 
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' btnnames='Edit_Save_Cancel_Delete_Audit Trail'/>
<input type="hidden" name="hidPage" value="assmntcomments">
<input type="hidden" name="hidBeanId" value="">
 <input type="hidden" name="hidBeanMethod" value=""> 
 <input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidAction" value="">
<input type="hidden" name="hidSourceUrl" value=""> 
<input type="hidden" name="hidCommentPage" value="">
<INPUT TYPE="hidden" name="strAssessment" value = "<%=request.getParameter("strAssessment")%>">
<br>
</form>
</body>
</html>