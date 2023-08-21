<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String strsecID = Helper.correctNull((String) request.getParameter("hidsecid"));
String strAppcoverage=Helper.correctNull((String) hshValues.get("COMSEC_APPCOVERAGE"));
String strGroupcoverage=Helper.correctNull((String) hshValues.get("COMSEC_GROUPCOVERAGE"));
String strSecType=Helper.correctNull((String) hshValues.get("COMSEC_SECTYPE"));
String appidval = request.getParameter("appno");
String sectype = Helper.correctNull((String) request.getParameter("hidsectype"));

%>
<html>
<head>
<title>Brief History</title>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var varappCoverage="<%=strAppcoverage%>";
var vargroupcoverage="<%=strGroupcoverage%>";
var varProposedSecurity="<%=Helper.correctNull((String)hshValues.get("strProposedSecurity"))%>";
var varSecType="<%=strSecType%>";
var appno="";
var btnenable="";
function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
        document.forms[0].hidBeanId.value="facilities";
	    document.forms[0].action=appURL+"action/"+"corppge.jsp";	
		document.forms[0].submit();
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].hidBeanId.value="facilities";
    document.forms[0].hidPage.value="secoveragecmts";
	document.forms[0].hidBeanMethod.value="updateComments";
	document.forms[0].hidBeanGetMethod.value="getComments";
	document.forms[0].hidSourceUrl.value="action/securitycoveragecommentsnew.jsp";	
	document.forms[0].method="post";
	document.forms[0].action=appURL+"action/controllerservlet";	
	document.forms[0].submit();
	}
}
function doSave()
{ 	

		document.forms[0].cmdsave.disabled=true;
	    document.forms[0].hidAction.value="update"
	    document.forms[0].hidBeanId.value="facilities";
	    document.forms[0].hidPage.value="secoveragecmts";
		document.forms[0].hidBeanMethod.value="updateComments";
		document.forms[0].hidBeanGetMethod.value="getComments"
		document.forms[0].hidSourceUrl.value="/action/securitycoveragecommentsnew.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
}

function doEdit()
{
	disableFields(false);
	disableCommandButtons("edit");
	EditorEnableDisable1("id_div","none","id_editor","block");
	EditorEnableDisable1("id_div1","none","id_editor1","block");
	EditorEnableDisable1("id_div2","none","id_editor2","block");
	editor_generate('txt_comments');
	editor_generate('txt_comments1');
	editor_generate('txt_comments2');
}
function disableCommandButtons(val)
{
	if(val=="load")
	{
		if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
	  	{
		if(document.forms[0].btnenable.value =='N')
	  	{
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
	 	  	document.forms[0].cmddelete.disabled=false;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
	 	}
	}
	if(val=="edit")
	{
		if(document.forms[0].btnenable.value =='N')
	  	{
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
	 disableFields(true);
	 EditorEnableDisable1("id_div","block","id_editor","none");
	 EditorEnableDisable1("id_div1","block","id_editor1","none");
	 EditorEnableDisable1("id_div2","block","id_editor2","none");
	 if(varappCoverage!="")
	 {
		 document.forms[0].sel_seccoverageApp.value=varappCoverage;
	 }
	 if(vargroupcoverage!="")
	 {
		 document.forms[0].sel_seccoverageGroup.value=vargroupcoverage;
	 }
	 if(varSecType!="")
	 {
		 document.forms[0].sel_sectype.value=varSecType;
	 }
	 if(varProposedSecurity!="")
	 {
		 document.forms[0].sel_proposedsec.value=varProposedSecurity;
	 }
}

function disableFields(val)
{
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  if(document.forms[0].elements[i].type=='select-one')
		  {
				document.forms[0].elements[i].disabled=val;
		  }
		  if(document.forms[0].elements[i].type=='textarea')
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
		  
	  }
	  
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="facilities";
	    document.forms[0].hidPage.value="secoveragecmts";
		document.forms[0].hidBeanGetMethod.value="getComments";
		document.forms[0].action=appURL+"action/securitycoveragecommentsnew.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function EditorEnableDisable1(name1,val1,name2,val2)
{
	document.getElementById(name1).style.display=val1;
	document.getElementById(name2).style.display=val2;
}
function enabletexteditor()
{
	if(document.forms[0].sel_seccoverageApp.value=="M")
	{
		document.all.idgroupcoverage.style.display="table-row";
		document.all.idgroupcoverage3.style.display="table-row";
	}
	else{
		document.all.idgroupcoverage.style.display="none";
		document.all.idgroupcoverage3.style.display="none";
	}
	if(document.forms[0].sel_seccoverageGroup.value=="M")
	{
		document.all.idgroupcoverage1.style.display="table-row";
	}else
	{
		document.all.idgroupcoverage1.style.display="none";
	}
	if(document.forms[0].sel_proposedsec.value=="M")
	{
		document.all.idgroupcoverage2.style.display="table-row";
	}else
	{
		document.all.idgroupcoverage2.style.display="none";
	}
}
function callExistingSec()
{
	appno=document.forms[0].hidappno.value;
	btnenable=document.forms[0].btnenable.value;
	var varQryString = appURL + "action/securitygroupconcerns.jsp?appno="+appno+"&btnenable="+btnenable+"&appstatus="+appstatus+"&hidpage=existingsecurity";
	var title = "Securities";
	var prop = "scrollbars=yes,width=850,height=500,menubar=yes";
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString, title, prop);	
}
function callExistingFac()
{
	btnenable=document.forms[0].btnenable.value;
	appno=document.forms[0].hidappno.value;
	
	var varQryString = appURL + "action/securitygroupconcerns.jsp?appno="+appno+"&btnenable="+btnenable+"&appstatus="+appstatus+"&hidpage=existingfacility";
	var title = "Securities";
	var prop = "scrollbars=yes,width=850,height=500,menubar=yes";
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString, title, prop);
}
</script>

</head>
<body onload="onLoading();enabletexteditor();">
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
	<form method = post class="normal">
	<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
 <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="33" />
			<jsp:param name="subpageid" value="138" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%}else{ %>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="33" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
			
			
		</jsp:include>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
	 <%if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home -&gt; Agriculture -&gt;Application -&gt; Security Master -&gt; Security coverage Comments</td>
	<%}else{%>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt; Security coverage Comments</td>
		<%} %>			
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../set/appurlsectabs.jsp" flush="true">
			<jsp:param name="pageid" value="100"/>		
		</jsp:include>
		</td>
	</tr>
</table>
<%} %>	
  <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
    <tr> 
      <td valign="top" align="center"> 
        <table width="90%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
          <tr> 
          <td valign="top" align="center"> 
        	<table width="90%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
        	<tr  class="dataheader"><td colspan="2">Security Coverage :</td></tr>
         	 <tr> 
            <td valign="top"> 1. Whether the Security Coverage should be shown from </td>
            <td align="right"><select name="sel_seccoverageApp" onchange="enabletexteditor();">
            <option value="0"><---Select---></option>
            <option value="S">System</option>
            <option value="M">Manual</option>
            </select></td>
          </tr>
          <tr id="idgroupcoverage3">
          <td valign="top"> Whether the Securities are Exclusive Securities / Common Securities</td>
            <td  align="right"><select name="sel_sectype" onchange="enabletexteditor();">
            <option value="0"><---Select---></option>
            <option value="E">Exclusive</option>
            <option value="C">Common</option>
            </select></td>
          </tr>
          <tr id="idgroupcoverage">
          <td colspan="2">
            <div id="id_div"><div class="EditorClassNew"><%=Helper.correctNull((String)hshValues.get("COMSEC_APPCOMMENTS")) %></div></div>
             <div id="id_editor"> <textarea name="txt_comments" cols="110" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">
             <%=Helper.correctNull((String)hshValues.get("COMSEC_APPCOMMENTS")) %>
              </textarea></div>
            </td>
          </tr>
          <tr  class="dataheader"><td colspan="2">Existing Securities for Applicant :</td></tr>
          <tr> 
            <td valign="top"> 2. Whether the Existing Securities for Applicant should be shown from </td>
            <td  align="right"><select name="sel_seccoverageGroup" onchange="enabletexteditor();">
            <option value="0"><---Select---></option>
            <option value="S">System</option>
            <option value="M">Manual</option>
            </select></td>
          </tr>
          <tr id="idgroupcoverage1">
          <td colspan="2">
            <div id="id_div1"><div class="EditorClassNew"><%=Helper.correctNull((String)hshValues.get("COMSEC_GROUPCOMMENTS")) %></div></div>
             <div id="id_editor1"> <textarea name="txt_comments1" cols="110" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">
             <%=Helper.correctNull((String)hshValues.get("COMSEC_GROUPCOMMENTS")) %>
              </textarea></div>
            </td>
          </tr>
           <tr  class="dataheader"><td colspan="2">Proposed Securities for Applicant :</td></tr>
          <tr> 
            <td valign="top"> 3. Whether the Proposed Securities for Applicant should be shown from </td>
            <td  align="right"><select name="sel_proposedsec" onchange="enabletexteditor();">
            <option value="0"><---Select---></option>
            <option value="S">System</option>
            <option value="M">Manual</option>
            </select></td>
          </tr>
          <tr id="idgroupcoverage2">
          <td colspan="2">
            <div id="id_div2"><div class="EditorClassNew"><%=Helper.correctNull((String)hshValues.get("strProposedSecurityComments")) %></div></div>
             <div id="id_editor2"> <textarea name="txt_comments2" cols="110" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">
             <%=Helper.correctNull((String)hshValues.get("strProposedSecurityComments")) %>
              </textarea></div>
            </td>
          </tr>
        </table>
        </td>
        </tr>
        </table>
        </td>
    </tr>
  </table>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' btnnames='Edit_Save_Cancel_Delete'/>
<input type="hidden" name="hidPage" value="">
<%if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
<table width="40%" align="center" border="0" cellpadding="2" cellspacing="0">
	<tr>
	
		<td>
		<input type="button" name="cmdexisitingsec" class="buttonStyle" 
		value="Existing Securities for Group Concerns" onClick="callExistingSec()">
		</td>
		
		<td>
		<input type="button" name="cmdexisitingfac" class="buttonStyle" 
		value="Existing Facilities with our Bank for Group Concerns" onClick="callExistingFac()">
		</td>
	</tr>
</table>
<%} %>
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="hidsecid" value="<%=strsecID%>"> 
<input type="hidden" name="hidappno" value="<%=Helper.correctNull((String)request.getParameter("appno")) %>">
<input type="hidden" name="hidsectype" value="<%=sectype%>">
</form>  
</body>
</html>