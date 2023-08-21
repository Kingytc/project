<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>

<%
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String strsecID = Helper.correctNull((String) request.getParameter("hidsecid"));
String strAdditionalSec=Helper.correctNull((String) hshValues.get("COMSEC_GROUPSTATUS"));
String appidval = Helper.correctNull((String)request.getParameter("appno"));
String strbtnenable=Helper.correctNull((String)request.getParameter("btnenable"));
String strHidpage=Helper.correctNull((String)request.getParameter("hidpage"));
String strgoupid=Helper.correctNull((String) hshValues.get("COMSEC_GROUPAPPID"));
if(appidval.equalsIgnoreCase("")){
	appidval=Helper.correctNull((String) hshValues.get("appno"));
}
if(strHidpage.equalsIgnoreCase("")){
	strHidpage=Helper.correctNull((String) hshValues.get("strPage"));
}
if(strbtnenable.equalsIgnoreCase("")){
	strbtnenable=Helper.correctNull((String) hshValues.get("btnenable"));
}
%>
<html>
<head>
<title>Group Concerns</title>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var varAdditionalSec="<%=strAdditionalSec%>";
var varbtnenable="<%=strbtnenable%>";
var vargoupid="<%=strgoupid%>";
function doClose()
{
		if( ConfirmMsg(100) )
		{
			window.close();
		}
}


function doDelete()
{
	if(ConfirmMsg(101))
	{
	disableFields(false);
	document.forms[0].hidAction.value ="delete";
	document.forms[0].hidBeanId.value="facilities";
	document.forms[0].hidBeanMethod.value="updateComments";
	document.forms[0].hidBeanGetMethod.value="getComments";
	document.forms[0].hidSourceUrl.value="action/securitygroupconcerns.jsp";	
	document.forms[0].method="post";
	document.forms[0].action=appURL+"action/controllerservlet";	
	document.forms[0].submit();
	}
}
function doSave()
{ 	
		disableFields(false);
		document.forms[0].cmdsave.disabled=true;
	    document.forms[0].hidAction.value="update"
	    document.forms[0].hidBeanId.value="facilities";
		document.forms[0].hidBeanMethod.value="updateComments";
		document.forms[0].hidBeanGetMethod.value="getComments"
		document.forms[0].hidSourceUrl.value="/action/securitygroupconcerns.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
}

function doEdit()
{
	disableFields(false);
	disableCommandButtons("edit");
	EditorEnableDisable1("id_div2","none","id_editor2","block");
	editor_generate('txt_comments2');
	 document.forms[0].sel_groupname.disabled=true;
}
function disableCommandButtons(val)
{
	if(val=="load")
	{
		if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
	  	{
			if(varbtnenable =='N')
		  	{
			  	document.forms[0].cmdedit.disabled=true;
			  	document.forms[0].cmddelete.disabled=true;
			  	document.forms[0].cmdsave.disabled=true;
			  	document.forms[0].cmdcancel.disabled=true;
			  	document.forms[0].cmdclose.disabled=false;
		 	}
	  	}
	}
	if(val=="edit")
	{
		if(varbtnenable =='N')
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
			document.forms[0].cmdclose.disabled=false;
		}
		disableFields(false);
	}
}

function onLoading()
{
	 disableFields(true);
	 EditorEnableDisable1("id_div2","block","id_editor2","none");
	 if(varAdditionalSec!="")
	 {
		 document.forms[0].sel_Additionalsec.value=varAdditionalSec;
	 }
	 if(vargoupid!="" && vargoupid!="0")
	 {
		 document.forms[0].sel_groupname.value=vargoupid;
	 }else{
		 document.forms[0].sel_groupname.value="";
		 document.forms[0].cmdedit.disabled=true;
	 }
	 document.forms[0].sel_groupname.disabled=false;
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
		document.forms[0].hidBeanGetMethod.value="getComments";
		document.forms[0].action=appURL+"action/securitygroupconcerns.jsp";
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
	if(document.forms[0].sel_Additionalsec.value=="M")
	{
		document.all.idgroupcoverage2.style.display="table-row";
	}else
	{
		document.all.idgroupcoverage2.style.display="none";
	}
}
function getvalues()
{
	document.forms[0].hidBeanId.value="facilities";
	document.forms[0].hidBeanGetMethod.value="getComments";
	document.forms[0].action=appURL+"action/securitygroupconcerns.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
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
  <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
    <tr> 
      <td valign="top" align="center"> 
        	<table width="90%" border="0" cellspacing="0" cellpadding="3" class="outertable">
        	<%if(strHidpage.equalsIgnoreCase("existingsecurity")) {%>
          <tr  class="dataheader"><td colspan="2">Existing Securities for Group Concerns :</td></tr>
          <%} else{%>
         <tr  class="dataheader"><td colspan="2">Existing Facilities with our Bank for Group Concerns : </td></tr>
          <%} %>
          <tr> 
          <%if(strHidpage.equalsIgnoreCase("existingsecurity")) {%>
            <td valign="top">Whether the Existing Securities for Group Concerns should be shown from </td>
            <%} else{%>
         <td valign="top"> Whether the Existing Facilities with our Bank for Group Concerns should be shown from </td>
          <%} %>
            <td  align="right">
            <table width="100%" border="0px" cellspacing="0" cellpadding="3" class="outertable">
            <tr>
            <td>
            <select name="sel_groupname" onchange="getvalues()">
                    <option value="">--Select--</option>
                 	<lapschoice:divisionslistid appid="<%=appidval%>" />
				</select>
				</td>
            <td  align="right"><select name="sel_Additionalsec" onchange="enabletexteditor();">
            <option value="0"><---Select---></option>
            <option value="S">System</option>
            <option value="M">Manual</option>
            </select>
            </td>
            </tr>
            </table>
            </td>
          </tr>
          <tr id="idgroupcoverage2">
          <td colspan="2">
            <div id="id_div2"><div class="EditorClassNew"><%=Helper.correctNull((String)hshValues.get("COMSEC_COMMENTS")) %></div></div>
             <div id="id_editor2"> <textarea name="txt_comments2" cols="110" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("COMSEC_COMMENTS")) %>
              </textarea></div>
            </td>
          </tr>
        </table>
        </td>
    </tr>
  </table>
<lapschoice:combuttonnew btnenable='<%=strbtnenable%>' btnnames='Edit_Save_Cancel_Delete'/>
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="hidsecid" value="<%=strsecID%>"> 
<input type="hidden" name="hidappno" value="<%=appidval %>">
<input type="hidden" name="appno" value="<%=appidval %>">
<input type="hidden" name="hidPage" value="<%=strHidpage %>">
<input type="hidden" name="hidbutton" value="N">

</form>  
</body>
</html>