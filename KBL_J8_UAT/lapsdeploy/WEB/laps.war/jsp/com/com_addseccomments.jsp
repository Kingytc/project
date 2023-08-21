<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String strsecID = Helper.correctNull((String) request.getParameter("hidsecid"));
String sectype = Helper.correctNull((String) request.getParameter("hidsectype"));

%>

<html>
<head>
<title>Security Comments</title>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
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
    document.forms[0].hidPage.value="seccomments";
	document.forms[0].hidBeanMethod.value="updateComments";
	document.forms[0].hidBeanGetMethod.value="getComments";
	document.forms[0].hidSourceUrl.value="action/com_addseccomments.jsp";	
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
	    document.forms[0].hidPage.value="seccomments";
		document.forms[0].hidBeanMethod.value="updateComments";
		document.forms[0].hidBeanGetMethod.value="getComments"
		document.forms[0].hidSourceUrl.value="/action/com_addseccomments.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
}

function doEdit()
{
	disableFields(false);
	disableCommandButtons("edit");
	EditorEnableDisable1("id_div","none","id_editor","block");
	editor_generate('txt_comments');
	
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
}

function disableFields(val)
{
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  
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
	    document.forms[0].hidPage.value="seccomments";
		document.forms[0].hidBeanGetMethod.value="getComments";
		document.forms[0].action=appURL+"action/com_addseccomments.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function EditorEnableDisable1(name1,val1,name2,val2)
{
	document.getElementById(name1).style.display=val1;
	document.getElementById(name2).style.display=val2;
}
</script>

</head>
<body onload="onLoading()">
<form method = post class="normal">
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
		<td class="page_flow">Home -&gt; Agriculture -&gt;Application -&gt; Security Master -&gt; Additional securities offered for the proposed facilities</td>
	<%}else{%>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt;  Additional securities offered for the proposed facilities</td>
		<%} %>			
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../set/appurlsectabs.jsp" flush="true">
			<jsp:param name="pageid" value="99"/>		
		</jsp:include>
		</td>
	</tr>
</table>	
  <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
                <tr> 
                <td valign="top">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                      <tr> 
                        <td valign="top"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center" >
                            <tr> 
                             <td>
                                <table width="90%" border="0" cellspacing="0" cellpadding="4" class="outertable border1" align="center" >
                                  <tr class="dataheader"> 
                                    <td>Comments</td>
                                  </tr>
                                  <tr> 
                                   <td>
				            <div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("COM_COMMENTS")) %></div></div>
				             <div id="id_editor"> <textarea name="txt_comments" cols="110" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">
				         		     <%=Helper.correctNull((String)hshValues.get("COM_COMMENTS")) %>
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
			</td>
			</tr>
          </table>
       </td>
     </tr>
   </table>
  </td>
 </tr>
</table>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' btnnames='Edit_Save_Cancel_Delete_Audit Trail'/>
<input type="hidden" name="hidPage" value="">
<input type="hidden" name="hidBeanId" value="">
 <input type="hidden" name="hidBeanMethod" value=""> 
 <input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidAction" value="">
<input type="hidden" name="hidSourceUrl" value=""> 
<input type="hidden" name="hidPageId">
<input type="hidden" name="hidsecid" value="<%=strsecID%>"> 
<input type="hidden" name="hidsectype" value="<%=sectype%>">

</form>  
</body>
</html>