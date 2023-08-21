<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>

<%
String appnoval = Helper.correctNull((String)request.getParameter("appno"));;
String StrSchemeType=request.getParameter("strschemeType");
%>
<html>
<head>
<title></title>
<script type="text/javascript">

	var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
	var Facilityid="<%=Helper.correctNull((String) hshValues.get("hshFacility"))%>";
	var varPostSanc="<%=Helper.correctNull((String)session.getAttribute("strAppType"))%>";
	var varEditFlag="<%=Helper.correctNull((String) hshValues.get("strEditFlag"))%>";
	
	function callTermAssesement(beanid,methodname,pagename,type)
	{			
		if(type=="COP")
		{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename+"?hidPageSource="+type;
		document.forms[0].submit();
		}
		else if(type=="SOM")
		{
			document.forms[0].hidBeanId.value=beanid;
			document.forms[0].hidBeanGetMethod.value=methodname;
			document.forms[0].action=appURL+"action/"+pagename+"?hidPageSource="+type;
			document.forms[0].submit();
		}
		else if(type=="CommentsProj")
		{
			document.forms[0].hidBeanId.value=beanid;
			document.forms[0].hidBeanGetMethod.value=methodname;
			document.forms[0].action=appURL+"action/"+pagename+"?hidPageSource="+type;
			document.forms[0].submit();
		}
		else if(type=="ExistingTerm")
		{
			document.forms[0].hidBeanId.value=beanid;
			document.forms[0].hidBeanGetMethod.value=methodname;
			document.forms[0].action=appURL+"action/"+pagename+"?hidPageSource="+type;
			document.forms[0].submit();
		}
		else
		{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].pageType.value=ptype;
		document.forms[0].flowtype.value=type;
		document.forms[0].submit();
		}
	}
	
	function callReleasePattern(beanid,methodname,pagename)
	{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].submit();
	}
	function callcopmof()
	{		
			document.forms[0].method="post";
			document.forms[0].action=appUrl+"action/com_termloanassesment.jsp";
			document.forms[0].submit();
	} 
	function gototab(beanid,methodname,pagename,type)
	{
			document.forms[0].hidBeanId.value=beanid;
			document.forms[0].hidBeanGetMethod.value=methodname;
			document.forms[0].action=appURL+"action/"+pagename;
			document.forms[0].flowtype.value=type;
			document.forms[0].submit();
	} 
	function disableCommandButtons(cmdEdit,cmdSave,cmdCancel,cmdDelete,cmdClose)
	{	  
	      document.forms[0].cmdedit.disabled=cmdEdit;
	  	  document.forms[0].cmdsave.disabled=cmdSave;
		  document.forms[0].cmdcancel.disabled=cmdCancel;
		  document.forms[0].cmddelete.disabled=cmdDelete;	
		  document.forms[0].cmdclose.disabled=cmdClose; 		 
	}
	function disableFields(val)
    {
		for(var i=0;i<document.forms[0].length;i++)
		{
		    if(document.forms[0].elements[i].type=='text')
			{
				document.forms[0].elements[i].disabled=val;
			}	  
			if(document.forms[0].elements[i].type=='textarea')
			{
				document.forms[0].elements[i].readOnly=val;
			}
			if(document.forms[0].elements[i].type=='select-one')
			{
				document.forms[0].elements[i].disabled=val;
			}	  
		}	
		//document.forms[0].sel_facility.disabled=false;  
	}

	function callOnload()
	{
		if(Facilityid=="")
		{
			document.forms[0].sel_facility.value ="s";
			disableCommandButtons(true,true,true,true,false);
		}
		else{
			document.forms[0].sel_facility.value =Facilityid;
   			disableFields(true);
   			
		if(appstatus=="Open/Pending")
		{
			if(document.forms[0].btnenable.value.toUpperCase()=="Y")
			{
		 	disableCommandButtons(false,true,true,true,false);
			}
			else
			{
				disableCommandButtons(true,true,true,true,false);
			}
		}
		else
		{
			disableCommandButtons(true,true,true,true,false);
		}	
		}
		EditorEnableDisable1("id_div","block","id_editor","none");
		document.forms[0].sel_facility.disabled=false;
	}
	function EditorEnableDisable1(name1,val1,name2,val2)
	{
		document.getElementById(name1).style.display=val1;
		document.getElementById(name2).style.display=val2;
	}		
	

function doEdit()
{		
	document.forms[0].hidAction.value ="insert";
	disableFields(false);
	disableCommandButtons(true,false,false,false,false);
	EditorEnableDisable1("id_div","none","id_editor","block");
	editor_generate('txt_termloan');
	document.forms[0].sel_facility.disabled=true;
}
	

function getvalues()
{
	
	if(document.forms[0].sel_facility.value!="s")
	{
		document.forms[0].hidBeanId.value="bankapp";
		document.forms[0].hidBeanGetMethod.value="updateSourceOfMargin";
		document.forms[0].hidBeanGetMethod.value="getSourceOfMargin";						
		document.forms[0].hidSourceUrl.value="/action/com_existingtermloan.jsp";
		document.forms[0].submit();
		disableFields(true);
		disableCommandButtons(false,true,true,true,false);	
	}		
	else
	{
		clearFields();
		enableButtons(true,true,true,true,false);
		disableCommandButtons(true);
		document.forms[0].submit();
	}
}			
			

  function doSave(){
		disableFields(false);
		disableCommandButtons(true,true,true,true,false);
		document.forms[0].hidBeanId.value="bankapp";
		document.forms[0].hidBeanMethod.value="updateSourceOfMargin";
		document.forms[0].hidBeanGetMethod.value="getSourceOfMargin";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_existingtermloan.jsp";
		document.forms[0].submit();	
  }

  
	function doDelete() 
	{
	   	if(ConfirmMsg(101))
		{
	   		disableFields(false);
	   		document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanId.value="bankapp";
			document.forms[0].hidBeanMethod.value="updateSourceOfMargin";
			document.forms[0].hidBeanGetMethod.value="getSourceOfMargin";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/com_existingtermloan.jsp";
			document.forms[0].submit();
		}
	}
	
	
	function doCancel()
	{
		document.forms[0].hidBeanId.value="bankapp";
		document.forms[0].hidBeanGetMethod.value="getSourceOfMargin";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_existingtermloan.jsp";
		document.forms[0].submit();
	}

	
	function clearFields()
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="textarea")
			{
				document.forms[0].elements[i].value="";		  
			}
		}		
	}
</script>

</head>

<body onload="callOnload()">
<form  method="post" class="normal">
<%
if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
class="outertable">
<tr>
	<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
		<jsp:param name="pageid" value="14" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
		<jsp:param name="ssitype" value="<%=strSSIType%>" />
	</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
	</td>
</tr>
</table>
<%}else{%>
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		class="outertable">
		<tr>
			<td valign="top"><jsp:include page="../com/proposallinks.jsp"
				flush="true">
				<jsp:param name="pageid" value="41" />
				<jsp:param name="cattype" value="<%=strCategoryType%>" />
				<jsp:param name="ssitype" value="<%=strSSIType%>" />
			</jsp:include></td>
		</tr>
	</table>
	
	<span class="page_flow">Home -&gt; Corporate &amp; SME -&gt;Proposal -&gt; Financial Analysis -&gt; Assessment -&gt; Term Loan Assessment -&gt; Existing Term Loan (Review)</span><br>
    <span style="display: none;"><lapschoice:borrowertype /></span> 
    <lapschoice:application />
    <jsp:include page="../com/com_commentstab.jsp" flush="true">
	<jsp:param name="tabid" value="3" /></jsp:include>
    
    <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="90%" border="0" cellspacing="1" cellpadding="3"
			class="outertable">
			<tr align="center">
			<td class="sub_tab_active" align="center"><b>Existing Term Loan (Review) </b></td>
			    <td class="sub_tab_inactive" align="center"><a
							href="javascript:gotoTab(appUrl,'bankapp','getBreifDetailOfProject','com_BreifDetailOfProject.jsp')"><b>Brief Details of the project</b></a></td>
				<td class="sub_tab_inactive" align="center"><a
							href="javascript:callcopmof()"><b>Term loan Assessment</b></a></td>						    			
		       <td class="sub_tab_inactive" align="center"><a
					href="javascript:callTermAssesement('bankapp','getSourceOfMargin','com_contlimitcomment.jsp','SOM')"><b>Source of Margin</b></a></td>
				<td class="sub_tab_inactive" align="center"><a
							href="javascript:callReleasePattern('bankapp','getSourceOfMargin','com_commenstonproj.jsp','CommentsProj')"><b>Comments on the project</b></a></td>
				<td class="sub_tab_inactive" align="center"><a
							href="javascript:callReleasePattern('bankapp','getReleasePattern','com_releasepattern.jsp','')"><b>Release Pattern/ Margin</b></a></td>
				
				
			</tr>
		</table>
		</td>
	</tr>
</table>

<%}%>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="5"
									class="outertable">
	<tr>
	<td>
	<table width="60%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center">
			<tr class="dataGrid">
			    <td width="30%" align="center">Facility<span class="mantatory">*</span></td>
				<td width="70%" align="left">
					<SELECT NAME="sel_facility"  onchange="getvalues();" TABINDEX="1" STYLE="width: 500">
						<OPTION VALUE="s" selected>--Select--</OPTION>
						<laps:TermLoanFund appno="<%=appnoval%>" />
					</SELECT>
				</td>
								
			</tr>	
			</table>
			</td>
			</tr>	
</table>

<br>
<table width="90%" border="1" cellspacing="0" cellpadding="0"
	align="center" CLASS="outertable linebor">
	 <tr class="dataheader"> <td>&nbsp;Comments</td> </tr>
     <tr> 
          <td>
	          <div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("com_termloan_comments")) %></div></div>
	          <div id="id_editor"> 
	               <textarea name="txt_termloan" cols="110" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"> 
	                    <%=Helper.correctNull((String)hshValues.get("com_termloan_comments")) %>
	               </textarea>
	          </div>
          </td>
     </tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />

<lapschoice:hiddentag pageid='<%=PageId%>'/>

<input type="hidden" name="hidAppNo" value="<%=Helper.correctNull((String) hshValues.get("com_appno"))%>"> 
<input type="hidden" name="cattype" value=""/>
<input type="hidden" name="pagefrom">
<input type="hidden" name="pageType" value="ExistingTerm">
<INPUT TYPE="hidden" name="strschemeType" value = "<%=StrSchemeType%>">
<INPUT TYPE="hidden" name="strAssessment" value = "<%=request.getParameter("strAssessment")%>">
<input type="hidden" name="hidPostSancParams" value="<%=Helper.correctNull((String)hshValues.get("strPostSancParam"))%>">
<input type="hidden" name="hidChk" value="Y">
</form>
</body>
</html>
	
