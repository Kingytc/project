<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%ArrayList arryRow = (ArrayList) hshValues.get("arrRow");
			ArrayList arryCol = new ArrayList();
			 	
	%>
	<%String strRecommendedby = Helper.correctNull((String) hshValues.get("strRecomendby"));
      String strsno = Helper.correctNull((String) hshValues.get("strSno"));
      String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
      String strTallyFlag = Helper.correctNull((String) hshValues.get("strTallyFlag"));
	%>
<html>
<head>
<title>Proposal</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
	<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
	<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>

<script>
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var strRecomendby="<%=strRecommendedby%>";
var strsno="<%=strsno%>";
var varTallyFlag="<%=strTallyFlag %>";

function placeValues()
{
	
	disableFields(true);
 	
 	if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
	{
		enableButtons(true,true,true,true,true,false);	
	}
	else
	{
		if(strRecomendby =="")
		{
			
			if(document.forms[0].btnenable.value=='Y')
			{
				enableButtons(false,true,true,true,false,false);
			}
			else
			{
				enableButtons(true,true,true,true,true,false);
			}
		}
		else
		{
			if(document.forms[0].btnenable.value=='Y')
			{
				enableButtons(true,false,true,false,false,false);
			}
			else
			{
				enableButtons(true,true,true,true,true,false);
			}
		}
	}
 	if(strRecomendby =="")
	{
 		document.forms[0].sel_recmdby.value="0";
	}
 	else
 	{
 	 	document.forms[0].sel_recmdby.value=strRecomendby;
 	}
 	 document.forms[0].strhidSno.value=strsno;

	  EditorEnableDisable("id_div","block","id_editor","none");
	  if(document.forms[0].hidNonPoolFlag.value=="Y")
	  {
		  enableButtons(true,true,true,true,true,false);
	  }
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		  
		}
	}
}

function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="executive";
		document.forms[0].hidBeanGetMethod.value="getRecommendationData";
		document.forms[0].action=appURL+"action/com_recommendation.jsp";
		document.forms[0].submit();
	 }
	}
function doDelete()
{	
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="executive";
		document.forms[0].hidBeanMethod.value="updateRecommendationData";
		document.forms[0].hidBeanGetMethod.value="getRecommendationData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_recommendation.jsp";
 		document.forms[0].submit();
	 }
	
}
function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{

	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;

}
function doEdit()
{
	disableFields(false);
	enableButtons(true,true,false,false,true);
	
		document.forms[0].hidAction.value ="update";
	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('txt_RecmdComment');
}
function doSave()
{
	if(document.forms[0].sel_recmdby.value=="0")
	{
		alert("Select Recommended By");
		 document.forms[0].sel_recmdby.focus();
		  return;
		}
	if(varTallyFlag=='N')
	{
		alert("Financial -> Assets and Liabilities in not Tally!");
		return;
	}
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidBeanId.value="executive";
		document.forms[0].hidBeanMethod.value="updateRecommendationData";
		document.forms[0].hidBeanGetMethod.value="getRecommendationData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_recommendation.jsp";
		document.forms[0].submit();
}
function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appURL+"action/"+"corppge.jsp";
		document.forms[0].submit();
	}
	
}

function doNew()
{
	disableFields(false);
	enableButtons(true,true,false,false,true,false)
	
	document.forms[0].sel_recmdby.value="0";
	document.forms[0].txt_RecmdComment.value="";
	document.forms[0].hidAction.value ="insert";
	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('txt_RecmdComment');

}
function selectValues(val1,val2)
{	
	document.forms[0].strhidSno.value=val1;
	document.forms[0].sel_recmdby.value=val2;
	document.forms[0].hidRecomNo.value=val2;
	document.forms[0].hidSelectFlag.value="Y";
	document.forms[0].hidBeanId.value="executive";
	document.forms[0].hidBeanGetMethod.value="getRecommendationData";
	document.forms[0].action=appURL+"action/com_recommendation.jsp";
	document.forms[0].submit();
	disableFields(true);
	enableButtons(true,false,true,false,false,false);
}
function callLink(page,bean,method,pageid)
{
	if(document.forms[0].cmdsave.disabled==true)
	{
 	 document.forms[0].hidAction.value="";
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	document.forms[0].hidPage.value=pageid;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
		return;
	}
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">

<STYLE>

DIV.cellContainer {	

  width: 100%; height: 150;
  overflow: auto;
}
</STYLE>
</head>

<body onload="placeValues()">
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
		<td valign="top" colSpan=5><jsp:include
			page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="27" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />

		</jsp:include></td>
	</tr>
	<tr>
		
		 <%if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Agriculture -&gt;&nbsp;Proposal&nbsp;-&gt;&nbsp;Recommendation/Ratification-&gt;Recommendation</td>
	<%}else{%>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Corporate&nbsp; &amp; SME -&gt;&nbsp;Proposal&nbsp;-&gt;&nbsp;Recommendation/Ratification-&gt;Recommendation</td>
		</td>
		<%} %>
	</tr>
</table>
<span style="display:none"><lapschoice:borrowertype /></span><lapschoice:application />
<table width="50%" border="0" cellspacing="1" cellpadding="3"> 
	<tr align="center">
		 <td width="9%" height="14" class="sub_tab_active" nowrap="nowrap">Recommendation</td>
		 <td width="9%" height="14" class="sub_tab_inactive" nowrap="nowrap">
		 <a href="javascript:callLink('com_ratification.jsp','executive','getRatificationComments','ratification')">Ratification</a></td> 
		 
	</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
          <tr> 
            <td valign="top"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
          <tr> 
            <td valign="top"> 
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
  <tr> 
    <td width="20%" nowrap="nowrap">Recommended By <b><span class="mantatory">*</span></b>&nbsp;
     
      <select name="sel_recmdby" tabindex="1">
        <option value="0" selected="selected">--Select--</option>
        <option value="1">HO Recommendation</option>
        <option value="2">HO Observation</option>
        <option value="3">CPC Recommendation</option>
        <option value="4">CPC Observation</option>
         <option value="5">RO Recommendation</option>
          <option value="6">RO Observation</option>
           <option value="7">CLPU Recommendation</option>
            <option value="8">CLPU Observation</option>
             <option value="9">BRANCH Recommendation</option>
              <option value="10">BRANCH Observation</option>
      </select>
    </td>
  </tr>  
  <tr><td>&nbsp;</td> </tr>  
  <tr class="dataheader"> 
    <td width="20%"> Recommendation</td>
    </tr>
   <tr class="datagrid"> 
    <td width="65%"> 
      <div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("strRecomendations")) %></div></div>
					 <div id="id_editor">
				
      <textarea name="txt_RecmdComment" cols="100"  rows="8" tabindex="2" wrap="VIRTUAL" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("strRecomendations"))%></textarea></div>
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
<lapschoice:combuttonnew btnnames="New_Edit_Save_Delete_Cancel_Audit Trail"
	btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
 						

	<DIV class="cellContainer"> 
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
	<tr class="dataheader">
		<td>&nbsp;</td>
		
		<td align="center" style="width:30%;"><b>User ID</b></td>
		<td align="center" style="width:16%;"><b>User Designation</b></td>
		<td align="center" style="width:12%;"><b>Recommended Date</b></td>
		
	</tr>
	   <%
						//ArrayList arryRow=new ArrayList();
						String strSno = "";
			if(hshValues!=null)
			{
				arryRow=(ArrayList)hshValues.get("arrRow");
				
			}
			//int size=arryRow.size();
			if(arryRow!=null && arryRow.size()>0)
					{
							for(int i=0;i<arryRow.size();i++)
							{
								arryCol=(ArrayList)arryRow.get(i); 
								//out.println(arryCol);
								%>
	
	<tr valign="top"  class="datagrid">
		<td width="3%"><input type="radio" name="radio_recmd" style="border: none"
			onclick="javascript:selectValues('<%=Helper.correctNull((String)arryCol.get(1))%>',
								'<%=Helper.correctNull((String)arryCol.get(2))%>')"> 
		 
		<td style="width:30%;"><%=Helper.correctNull((String)arryCol.get(4))%></td>
		<td style="width:16%;"><%=Helper.correctNull((String)arryCol.get(6))%></td>
		<td style="width:12%;"><%=Helper.correctNull((String)arryCol.get(3))%></td>

			
	</tr>
	<%}}%>
	<tr class="datagrid">
	
	  <td  style="width:3%;">&nbsp;</td>
	  
			   <td  style="width:30%;">&nbsp;</td>
			    <td  style="width:16%;">&nbsp;</td>
			   <td style="width:12%;">&nbsp;</td>
 </tr>
</table>
</DIV>
<br>
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="strhidSno" value="">
<input type="hidden" name="hiduserid" value="">
<input type="hidden" name="hidrecmddate" value="">
<input type="hidden" name="hiduserdesign" value="">
<input type="hidden" name="txt_usrid" value="<%=session.getAttribute("strUserId") %>"> 
<input type="hidden" name="org_code" value="<%=strOrgCode%>"> 
 <input type="hidden" name="txtRecmdDate" value="<%=Helper.getCurrentDateTime()%>">
  <input type="hidden" name="txtRecmdDesign" value="">
  <input type="hidden" name="hidRecomNo" value="">
  <input type="hidden" name="hidPage" value="ratification">
<input type="hidden" name="hidSelectFlag" value=""> 
<input type="hidden" name="hidTallyFlag" value="<%=strTallyFlag %>"> 

</form>
</body>
</html>

