<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	arrRow = (ArrayList) hshValues.get("arrRow");
	String strSector = Helper.correctNull((String) request
			.getParameter("hidsector"));
	String strSaral = Helper.correctNull((String) request
			.getParameter("hidsaral"));
	String strApploantype = Helper.correctNull((String) request
			.getParameter("apploantype"));
	String strApplevel = Helper.correctNull((String) request
			.getParameter("applevel"));

	String strValuesin = Helper.correctNull((String) request
			.getParameter("valuesin"));
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	if (strValuesin.equals("L")) {
		strValuesin = " in Lacs";
	} else {
		strValuesin = "";
	}
	String strappholder = Helper.correctNull((String) request
			.getParameter("appholder"));
	String strappliedfor = Helper.correctNull((String) request
			.getParameter("appliedfor"));
	String strProposal = Helper.correctNull(request
			.getParameter("hidproposal"));
	
	
    String strapplevel = Helper.correctNull((String)request.getParameter("applevel"));
	String strstatus = Helper.correctNull((String) request.getParameter("hidstatus"));
	if (strstatus.equals(""))
		strstatus = Helper.correctNull((String) hshValues.get("status"));
%>

<html>
<head>
<title>Term Loan Comments</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

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
    document.forms[0].hidPage.value="commentsTrans";
	document.forms[0].hidBeanMethod.value="updateComments";
	document.forms[0].hidBeanGetMethod.value="getComments";
	document.forms[0].hidSourceUrl.value="action/comments_transaction.jsp";	
	document.forms[0].method="post";
	document.forms[0].action=appURL+"action/controllerservlet";	
	document.forms[0].submit();
	 }
}
function doSave()
{ 	
		document.forms[0].cmdsave.disabled = true;
	    document.forms[0].hidAction.value="update"
	    document.forms[0].hidBeanId.value="facilities";
	    document.forms[0].hidPage.value="commentsTrans";
		document.forms[0].hidBeanMethod.value="updateComments";
		document.forms[0].hidBeanGetMethod.value="getComments"
		document.forms[0].hidSourceUrl.value="/action/comments_transaction.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
}

function doEdit()
{

	disableFields(false);
	//document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
	EditorEnableDisable("id_div","none","id_editor","block");
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
	 //disableCommandButtons("load");
	    disableFields(true);
		EditorEnableDisable("id_div","block","id_editor","none");
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
	    document.forms[0].hidPage.value="commentsTrans";
		document.forms[0].hidBeanGetMethod.value="getComments";
		document.forms[0].action=appURL+"action/comments_transaction.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
</script>

</head>
<body onload="onLoading()">
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
<%
if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
class="outertable">
<tr>
	<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
		<jsp:param name="pageid" value="9" />
		<jsp:param name="subpageid" value="129" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
		<jsp:param name="ssitype" value="<%=strSSIType%>" />
	</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
	</td>
</tr>
</table>
<%}else{
	if (strSaral.equalsIgnoreCase("saral")) {
%> <lapschoice:saralreportTag tabid="8" sector="<%=strSector%>"
	applied="<%=strappliedfor%>" proposal="<%=strProposal%>" /> <lapschoice:inward />
<%
	} else if (strApploantype.equalsIgnoreCase("c")||strApploantype.equalsIgnoreCase("a")) {
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="15" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<%if(strSessionModuleType.equals("AGR")){%>
	<tr>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Proposal -&gt;Business Turn
		Over&nbsp;-&gt;&nbsp;Comments on Transaction in the existing accounts </td>
	</tr>
	<%}else{ %>
	<tr>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Corporate&nbsp;&amp;
		SME -&gt;&nbsp;Proposal&nbsp;-&gt; &nbsp;Business Turn
		Over&nbsp;-&gt;&nbsp;Comments on Transaction in the existing accounts </td>
	</tr>
	<%} %>	
	
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%
	} else if (strApploantype.equalsIgnoreCase("T")) {
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top"><jsp:include
			page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="10" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<b><i>Home -&gt; Tertiary -&gt; Application -&gt; Reports -&gt;
Recommendation by Branch</i></b> 
<span style="display: none"><lapschoice:borrowertype /></span>
<lapschoice:application /> <lapstab:TerReportTab tabid="3"
	applevel="<%=strApplevel%>" applied="<%=strappliedfor%>" /> <%
 	} else if ((strCategoryType.equals("ADC"))) {
 %>
<table border="0" width="100%" class="outertable">
	<tr>
		<td valign="top"><jsp:include
			page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="12" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Adhoc
		Limit -&gt; Business Turn Over -&gt; Term Loan </td>
	</tr>
	<tr>
		<td><span style="display: none"><lapschoice:borrowertype /></span><lapschoice:application />
		</td>
	</tr>
</table>
<%
	}}
%>
<table border="0" cellspacing="1" cellpadding="3" class="outertable"
	width="90%">
	<tr>
		<td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getOthersDetails','com_others.jsp')"
			onMouseOut="window.status='';return true;">Business Operation</a> </b></td>			
    	<td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','facilities','getComments','com_termloancomments.jsp?hidPage1=term')"
			onMouseOut="window.status='';return true;">Term Loan</a> </b></td>	
		<td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getOdCcLimits','facilityremdforbusiess.jsp')"
			onMouseOut="window.status='';return true;">Conduct of Working Capital Facilities</a> </b></td>
		<td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','compro','getcom_nonfundloanlcdata','facilityremdforadverse.jsp')"
			onMouseOut="window.status='';return true;">Non Funded Loans</a> </b></td>
		<td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','compro','getOtherLimits','com_OtherLimits.jsp')"
			onMouseOut="window.status='';return true;">Others</a> </b></td>
		<td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','compro','getFinancialComments','com_otherfaccomments.jsp?hidPage1=otherfac')"
			onMouseOut="window.status='';return true;">Overall Comments</a> </b></td>
		
		<td class="sub_tab_active" align="center"><b>
		  Comments on Transaction in the existing accounts</b></td>
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
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable " align="center" >
                            <tr> 
                             
                                <table width="95%" border="0" cellspacing="0" cellpadding="4" class="outertable border1" align="center" >
                                  <tr class="dataheader"> 
                                    <td>Comments</td>
                                  </tr>
                                  <tr> 
                                   <td>
            <div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("COM_COMMENTS")) %></div></div>
             <div id="id_editor"> <textarea name="txt_comments" cols="150" rows="12" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">
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
</form>  
</body>
</html>