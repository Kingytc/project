 <%@include file="../share/CKEditor.jsp"%>
 <%@include file="../share/directives.jsp"%>
 <%
 String strDesination_user=Helper.correctNull((String)session.getAttribute("strUserDesignation")).trim();
String strDesination_basic=Helper.correctNull((String)hshValues.get("strDepartment"));
 %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script>
var  Designation_user="<%=strDesination_user%>";
var  varSTATIC_DATA_CODE="<%=Helper.correctNull((String)hshValues.get("CBS_STATIC_DATA_CODE"))%>";
var  varSTATIC_DATA_PASSINGCODE="<%=Helper.correctNull((String)hshValues.get("CBS_STATIC_DATA_PASSING_CODE"))%>";
var  varSTATIC_CGTMSE="<%=Helper.correctNull((String)hshValues.get("CBS_STATIC_CGTMSE"))%>";
var varusr_department="<%=Helper.correctNull((String)session.getAttribute("strUserDepartment"))%>";
var strOrgLevel="<%=Helper.correctNull((String)hshValues.get("strOrgLevel"))%>";
var varBasicInfoFlag="<%=Helper.correctNull((String)hshValues.get("strBasicInfoFlag"))%>";
var strOrgCode="<%=Helper.correctNull((String)session.getAttribute("strOrgCode"))%>";
var usr_rlpftype="<%=Helper.correctNull((String)session.getAttribute("strRLPFUser"))%>";
var strUserClass="<%=Helper.correctNull((String)hshValues.get("strUserClass"))%>";

var sessionModuleType="<%=Helper.correctNull((String)hshValues.get("sessionModuleType"))%>";

var rightstousercheck="<%=Helper.correctNull((String)hshValues.get("rightstousercheck"))%>";




function onload()
{
	if(varBasicInfoFlag!="Y")
	{
		alert("Please Fill Basic Information tab");
		document.forms[0].cmdedit.disabled=true;
	}
	if(sessionModuleType=="PERM")	 
	 {
		if(rightstousercheck=="Y")	
		{
			document.forms[0].cmdedit.disabled=false;	
		} 
	 }
	EditorEnableDisable1("id_div1","block","id_editor1","none","id_div2","block","id_editor2","none","id_div3","block","id_editor3","none");
	 
}

function EditorEnableDisable1(name1,val1,name2,val2,name3,val3,name4,val4,name5,val5,name6,val6)
{
	document.getElementById(name1).style.display=val1;
	document.getElementById(name2).style.display=val2;
	document.getElementById(name3).style.display=val3;
	document.getElementById(name4).style.display=val4;
	document.getElementById(name5).style.display=val5;
	document.getElementById(name6).style.display=val6;
	
}
function callOtherTab(val)
{
if(document.forms[0].cmdsave.disabled == true)
{
	if(val=="action")
	{
		document.forms[0].hidBeanGetMethod.value="getAction";
		document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].action=appURL+"action/permworkflowaction.jsp";
		document.forms[0].submit();
	}
	if(val=="history")
	 {
		 document.forms[0].hidBeanGetMethod.value="getHistory";
		 document.forms[0].hidBeanId.value="perDeviation";
		 document.forms[0].action=appURL+"action/permworkflowhistory.jsp";
		 document.forms[0].submit();
	 }
}
else
{
	ShowAlert(103);
	return;
}	
}

function callDisableControls(cmdEdit,cmdSave,cmdCancel,cmddelete,cmdClose)
{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdSave;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmddelete.disabled=cmddelete;
	document.forms[0].cmdclose.disabled=cmdClose;
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

function doEdit()
{	
	if(strOrgLevel!=varSTATIC_CGTMSE)
	{
		alert("You are not authorised to enter the Recommendations");
		return false;
	}
	if(strOrgLevel=="C")
	{
		if(varusr_department!=varSTATIC_DATA_PASSINGCODE)
		{
			if(rightstousercheck!="Y")
			{
			alert("You are not authorised to enter the Recommendations");
			return false;
			}
		}
	}
	else if(strOrgLevel=="D")
	{
		if(usr_rlpftype!="012")
		{
			alert("You are not authorised to enter the Recommendations");
			return false;
		}
	}
	else if(strOrgLevel=="R" && varSTATIC_DATA_CODE=="011")
	{
		var orgcode=strOrgCode.substring(0,5);
		if(orgcode!="001001")
		{
			alert("You are not authorised to enter the Recommendations");
			return false;
		}
	}
	else if(strOrgLevel=="R" && varSTATIC_DATA_CODE=="006")
	{
		var orgcode=strOrgCode.substring(0,5);
		if(orgcode=="001001")
		{
			alert("You are not authorised to enter the Recommendations");
			return false;
		}
	}
	
	disableFields(false);
	callDisableControls(true,false,false,false,true);
	EditorEnableDisable1("id_div1","none","id_editor1","block","id_div2","none","id_editor2","block","id_div3","none","id_editor3","block");
	editor_generate('txt_comments1');
	editor_generate('txt_comments2');
	editor_generate('txt_comments3');
	
}
function doSave()
{ 	


	var messageLength = CKEDITOR.instances['txt_comments1'].getData().replace(/<[^>]*>/gi, '').length;
    if( !messageLength ) {
        alert( 'Enter Permission letter subject' );
        return;
    }else if(!CKEDITOR.instances['txt_comments3'].getData().replace(/<[^>]*>/gi, '').length){
    	alert("Enter Sanction Department View");
		return;
    }else if(!CKEDITOR.instances['txt_comments2'].getData().replace(/<[^>]*>/gi, '').length){
    	alert("Enter Sanction Department Recommendation");
		return;
    } 

    
	document.forms[0].cmdsave.disabled = true;
    document.forms[0].hidAction.value="update";
    document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].hidBeanMethod.value="updateRecommendations";
	document.forms[0].hidBeanGetMethod.value="getRecommendations";
	document.forms[0].hidSourceUrl.value="/action/permworkflowrecomments.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	
}

function doDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].hidBeanMethod.value="updateRecommendations";
		document.forms[0].hidBeanGetMethod.value="getRecommendations";
		document.forms[0].hidSourceUrl.value="action/permworkflowrecomments.jsp";	
		document.forms[0].action=appURL+"action/controllerservlet";	
		document.forms[0].submit();
	}
}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
	document.forms[0].hidBeanGetMethod.value="getRecommendations";
	document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].action=appURL+"action/permworkflowrecomments.jsp";
	document.forms[0].submit();
}
}

function doClose()
{
	if( ConfirmMsg(100) )
	{
	    document.forms[0].action=appURL+"action/"+"mainnav.jsp";	
		document.forms[0].submit();
	}
}

</script>
</head>
<body onload="onload();">
<form name="frmworkflow" method="post" class="normal">
<jsp:include page="../share/devurllinker.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
		</jsp:include>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td class="page_flow">Home -&gt; Permission -&gt; Proposal -&gt; WorkFlow -&gt; Recommendation</td>
	</tr>

</table>
<lapschoice:ApplDevHeaderTag/>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="50%" border="0" cellspacing="1" cellpadding="3"
			class="outertable">
			<tr align="center">
				<td class="sub_tab_inactive"><a href="javascript:callOtherTab('history')">History</a></td>
				<td class="sub_tab_active">Permitting Department Recommendations</td>
				<td class="sub_tab_inactive"><a href="javascript:callOtherTab('action')">Action</a></td>
				<td class="sub_tab_inactive"><a href="javascript:callOtherTab('remarks')">Remarks</a></td>
			</tr>
		</table>
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
                        
                            	<td>
                                <table width="90%" border="0" cellspacing="0" cellpadding="4" class="outertable" align="center" >
                                  <tr class="dataheader"><td>Subject (Permission Letter)</td></tr>
                                  <tr> 
                                   <td>
						            <div id="id_div1"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("strComments1")) %></div></div>
						            <div id="id_editor1"> <textarea name="txt_comments1" cols="110" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("strComments1")) %></textarea></div>
						            </td>
                                  </tr>
                                  <tr class="dataheader"><td>Permitting Department View</td></tr>
                                  <tr> 
                                   <td>
						            <div id="id_div3"><div class="EditorClassNew"><%=Helper.correctNull((String)hshValues.get("strComments3")) %> </div></div>
						            <div id="id_editor3"> <textarea name="txt_comments3" cols="110" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("strComments3")) %></textarea></div>
						            </td>
                                  </tr>
                                  <tr class="dataheader"><td>Permitting Department Recommendation</td></tr>
                                  <tr> 
                                   <td>
						            <div id="id_div2"><div class="EditorClassNew"><%=Helper.correctNull((String)hshValues.get("strComments2")) %> </div></div>
						            <div id="id_editor2"> <textarea name="txt_comments2" cols="110" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("strComments2")) %></textarea></div>
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
  <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
  <lapschoice:hiddentag pageid='<%=PageId%>' />
  </form>
</body>
</html>