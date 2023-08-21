<%@include file="../share/CKEditor.jsp"%>
<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<jsp:useBean id="PageId" class="java.lang.String" scope="request" />
<laps:handleerror />

<%
String strSSIType = Helper.correctNull((String) request.getParameter("hidSSIType"));
int inssitype=Integer.parseInt((Helper.correctInt(strSSIType)));
			String strSessionModule="";
			strSessionModule=Helper.correctNull((String)session.getAttribute("sessionModuleType"));
			String strCategoryType = Helper.correctNull((String) request
					.getParameter("cattype"));
			%>

<html>
<head>
<title>Ratification</title>
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
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var selswot="<%=Helper.correctNull((String)hshValues.get("selswot"))%>";
function disablefields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
	}
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
function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].value="";		  
		}
		else if (document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].value="0";	
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
}
function enableButtons2(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
	document.forms[0].cmdcomments.disabled=bool6;
}

function callonLoad()
{
	//disableCommandButtons("load");
	if(selswot=="")
	{
		document.forms[0].sel_swot.value="0";
		selswot=document.forms[0].sel_swot.value;
	}
	else
	{
		document.forms[0].sel_swot.value=selswot;
		
	}
 	disablefields(true);
 	if(selswot!="0")
 	{
 		if(appstatus=="Open/Pending")
		{
 			if(document.forms[0].btnenable.value=="Y")
 			{
 				enableButtons2(false,true,true,false,true,false);
 			
 			}
 			else
 			{
 				enableButtons2(true,true,true,true,false,false);
 			}
		}
		else
		{
			enableButtons2(true,true,true,true,false,false);
		}
 	}else{
 		enableButtons2(true,true,true,true,false,false);
 	}
 	 EditorEnableDisable1("id_div","block","id_editor","none");
 	document.forms[0].sel_swot.disabled=false;
}

function doSave()
{	
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].sel_swot.disabled=false;
	document.forms[0].hidAction.value="update";
	document.forms[0].hidBeanId.value="compro";
	document.forms[0].hidBeanMethod.value="update_swotanalysis";
	document.forms[0].hidBeanGetMethod.value="get_swotanalysis";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_swotanalysis.jsp";
	document.forms[0].submit();
	
}
function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="compro";
		document.forms[0].hidBeanMethod.value="update_swotanalysis";
		document.forms[0].hidBeanGetMethod.value="get_swotanalysis";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_swotanalysis.jsp";
		document.forms[0].submit();
	 }
		
}
function doCancel()
{	
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanGetMethod.value="get_swotanalysis";
		document.forms[0].action=appURL+"action/com_swotanalysis.jsp";
		document.forms[0].submit();
	}
}
function callNew() 
{
	ClearFields();
	document.forms[0].hidAction.value="New";
   	enableButtons1(true, false, false, true);
   	disablefields(false);   	
}
function doEdit()
{
	disablefields(false);
	document.forms[0].sel_swot.disabled=true;
	enableButtons2(true,false,false,false,false,true);
	EditorEnableDisable1("id_div","none","id_editor","block");
	editor_generate('txt_comments');
}
function showAction()
{
	if(document.forms[0].appstatus.value == "Closed/Approved")
	{
		document.all.action.style.visibility = "hidden";
	}
}

function callHelp()
{

}

function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appURL+"action/"+"comsearch.jsp?id=<%=session.getAttribute("comappid")%>";
		document.forms[0].submit();
	}
}

function callLink(page,bean,method)
{
	if(document.forms[0].cmdsave.disabled==true)
	{
	 	document.forms[0].hidAction.value="";
	 	document.forms[0].hidBeanGetMethod.value=method;
	 	document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].action=appURL+"action/"+page;
	 	document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
		return;
	}
	
}
function callLink1(page,bean,method,pagetype)
{
	
	if(document.forms[0].cmdsave.disabled==true)
	{
	 	document.forms[0].hidAction.value="";
	 	document.forms[0].hidBeanGetMethod.value=method;
	 	document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].hidpage.value=pagetype;
	 	document.forms[0].action=appURL+"action/"+page;
	 	document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
		return;
	}
	
}
function callprint()
{
	var appno=document.forms[0].appno.value;
	var purl ="<%=ApplicationParams.getAppUrl()%>action/per_cheklistprint.jsp?hidBeanGetMethod=getDataQuestParameters&hidBeanId=appraisal&hidAppType=R&appno="+appno;		
	var prop = 'scrollbars=yes,menubar=yes,width=775,height=520';	
	var xpos = (screen.width - 775) / 2;
	var ypos = (screen.height - 520) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);	
}	
function doComments()
{
	var btnenable=document.forms[0].btnenable.value;
	var hidAppNo = document.forms[0].hidAppNo.value;
	var hidCommentPage = document.forms[0].hidCommentPage.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=facilities&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidCommentPage="+hidCommentPage+"&hidPage="+hidCommentPage+"&appstatus="+appstatus+"&btnenable="+btnenable;
	window.open(url,"Comments",prop);
}
function callindOverview()
{
	var btnenable=document.forms[0].btnenable.value;
	var hidAppNo = document.forms[0].hidAppNo.value;
	var hidCommentPage = "swotind";
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=facilities&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidCommentPage="+hidCommentPage+"&hidPage="+hidCommentPage+"&appstatus="+appstatus+"&btnenable="+btnenable;
	window.open(url,"Comments",prop);
}
function EditorEnableDisable1(name1,val1,name2,val2)
{
	document.getElementById(name1).style.display=val1;
	document.getElementById(name2).style.display=val2;
}
function getData()
{
	if(document.forms[0].sel_swot.value!="0")
	{
			document.forms[0].hidBeanId.value="compro"
			document.forms[0].hidBeanGetMethod.value="get_swotanalysis";
			document.forms[0].action=appURL+"action/com_swotanalysis.jsp";
			document.forms[0].submit();
			disablefields(true);
			enableButtons2(false,true,true,true,true,false);	
	}		
	else
	{
		ClearFields();
		enableButtons2(true,true,true,true,false);
		disablefields(true);
		document.forms[0].action=appURL+"action/com_swotanalysis.jsp";
		document.forms[0].submit();
	}
}

</script>

</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onload="callonLoad()">
	
<jsp:include page="../share/help.jsp" flush="true"/>
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="22" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<%if(strSessionModule.equalsIgnoreCase("corp")){ %>
	<tr>
		
      <td class="page_flow" >Home -&gt; Corporate & SME  -&gt; Proposal -&gt; Exposure to Industry / Other Info  -&gt; SWOT 
        Analysis </td>
	</tr>
	<%}else{ %>
	<tr>
		
      <td class="page_flow" >Home -&gt; Agriculture  -&gt; Proposal -&gt; Exposure to Industry / Other Info  -&gt; SWOT 
        Analysis </td>
	</tr>
	<%} %>
</table>
  <span style="display:none"><laps:borrowertype /></span> <laps:application />
  
<table width="50%" border="0" cellspacing="1" cellpadding="3"> 
	<tr align="center">
	<td width="13%" height="14" class="sub_tab_inactive" nowrap="nowrap"> <a href="javascript:callLink1('com_Exposuretoindustry.jsp','comproposal','getExposureIndustry')">Exposure to Industry</a></td>
	  <td width="13%" class="sub_tab_inactive" nowrap="nowrap">
		<a href="javascript:callLink1('com_industryanalysis.jsp','compro','get_Others','Industry')">Industry analysis</a></td>
	  <td width="12%" class="sub_tab_active" nowrap="nowrap">Swot Analysis</td>
      <td width="13%" class="sub_tab_inactive" nowrap="nowrap">
        <a href="javascript:callLink('com_interfirmcomp.jsp','comassestsliab','getInterfirmComp')">Inter Firm Comparsion</a></td>
	 <td width="12%" height="14" class="sub_tab_inactive" nowrap="nowrap">
		 <a href="javascript:callLink('com_management.jsp','compro','get_Management')">Other Details</a></td> 
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
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center" >
                            <tr> 
                             
                                <table width="90%" border="0" cellspacing="0" cellpadding="4" class="outertable border1" align="center" >
                                  <tr class="outertable">
                                  <td>Swot Analysis
                                  <select name="sel_swot" onchange="getData()">
								   <option value="0" selected="selected">--Select--</option>
                      			    <option value="1">Strength</option>
							        <option value="2">Weakness</option>
							        <option value="3">Opportunities</option>
							        <option value="4">Threats</option>	
							        <option value="5">Mitigation of Weakness & Threats</option>
                      			   </select></td>
							</tr>
                                  <tr class="dataheader"> 
                                    <td>Comments</td>
                                  </tr>
                                  <tr> 
                                   <td>
            <div id="id_div"><div class="EditorClassNew"><%=Helper.correctNull((String)hshValues.get("com_comments")) %></div></div>
             <div id="id_editor"> <textarea name="txt_comments" cols="110" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">
         		       <%=Helper.correctNull((String)hshValues.get("com_comments")) %>
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
<br>
 		<table  border="0" cellspacing="0" cellpadding="0" align="center">
			<tr>
				 <td>
                              <%String strappno = request.getParameter("appno");%> 
                             <lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Comments_Audit Trail"
	btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' /></td>
			
				<td><input type="hidden" name="cmdprint" value="Print"
					onClick="callprint()" class="buttonStyle"></td>
			</tr>
		</table>
		<table width="0%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
		<tr style="visibility: hidden;">
		<td>
		<table border="0" width="0%" cellspacing="0" cellpadding="0">
			<tr>
				<td width="25%" align="center"> 
                	<input type="button" name="cmdIndOverview" value="Industry Overview" onClick="callindOverview()" class="buttonStyle" style="width:120" />
            	</td>		
			</tr>
		</table>
		</td>
		</tr>
		</table>
	<lapschoice:hiddentag pageid='<%=PageId%>' />
	<input type="hidden" name="PageType" value="swot">
	<input type="hidden" name="hidpage" value="swot">
	<input type="hidden" name="hidCommentPage" value="swot"> 
	<input type="hidden" name="hidAppNo" value="<%=Helper.correctNull((String)request.getParameter("appno"))%>">
	<input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
</form>
</body>
<script language="javascript1.2">

</script>
</html>