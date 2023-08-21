<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>

<jsp:useBean id="objValues" class="java.lang.Object" scope="request" /> 
<%
String appnoval = Helper.correctNull((String)request.getParameter("appno"));;
String StrSchemeType=request.getParameter("strschemeType");
%>
<laps:handleerror />
<html>
<head>
<title></title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>
<script type="text/javascript">

	var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
	var Facilityid="<%=Helper.correctNull((String) hshValues.get("hshFacility"))%>";
	var total="<%=Helper.correctNull((String) hshValues.get("TotalCostofProject"))%>";
	var currentDate="<%=Helper.getCurrentDateTime()%>";
	var varPostSanc="<%=Helper.correctNull((String)session.getAttribute("strAppType"))%>";
	var varProjectLoan="<%=Helper.correctNull((String) hshValues.get("com_projectloan"))%>";
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
		else
		{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
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
	function disableCommandButtons(cmdEdit,cmdSave,cmdCancel,cmdDelete,cmdClose,cmdComments)
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
		document.forms[0].sel_facility.disabled=false;  
	}
	function callOnload()
	{
		if(Facilityid=="")
		{
			document.forms[0].sel_facility.value ="s";
			disableCommandButtons(true,true,true,true,false);
		}
		else
		{	
			if(varProjectLoan=="" || varProjectLoan=="s")
			{
				document.forms[0].sel_projectloan.value ="s";
			}
			else
			{
				document.forms[0].sel_projectloan.value =varProjectLoan;
			}
				
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

   			enablecal();
		}		
		EditorEnableDisable1("id_div","block","id_editor","none");

		if(document.forms[0].btnenable.value=="Y")
		{
			if(varPostSanc=="P")
			{
				var boolflag=false;
				var varPSterms = document.forms[0].hidPostSancParams.value.split("@");
				for(var i=0;i<varPSterms.length;i++)
				{
					if(varPSterms[i] == "CHDCCO"||varPSterms[i] == "DCCO")
					{
						boolflag=true;
					}
					
				}
				if( varEditFlag=="N" && document.forms[0].hidPostSancParams.value=="" && document.forms[0].sel_facility.value!="s")
				{
					boolflag=true;
				}
				if(boolflag)
				{
					disableCommandButtons(false,true,true,true,false);
				}
				else
				{
					disableCommandButtons(true,true,true,true,false);
				}
			}
		}
    }
	function doEdit()
	{		
		document.forms[0].hidAction.value ="insert";
		disableFields(false);
		disableCommandButtons(true,false,false,false,false);
		EditorEnableDisable1("id_div","none","id_editor","block");
		editor_generate('txt_comments');
		document.forms[0].txt_commercialdate.readOnly=true;
		if(document.forms[0].btnenable.value=="Y")
		{
			if(varPostSanc=="P")
			{
				document.forms[0].sel_projectloan.disabled=true;
				document.forms[0].txt_actualcommercialdate.readOnly=true;
				document.forms[0].txt_commercialdate.readOnly=true;
				document.all.iddcco.style.display="none";
				document.all.iddacco.style.display="none";
				var varPSterms = document.forms[0].hidPostSancParams.value.split("@");
				for(var i=0;i<varPSterms.length;i++)
				{
					if(varPSterms[i] == "CHDCCO")
					{
						document.forms[0].sel_projectloan.disabled=false;
						document.all.iddcco.style.display="inline";
					}
					if(varPSterms[i] == "DCCO")
					{
						document.all.iddacco.style.display="inline";
						document.forms[0].hidChk.value="N";
					}
					
				}
			}
		}
	}
	function getvalues()
	{
		if(document.forms[0].sel_facility.value!="s")
		{
			document.forms[0].hidBeanId.value="bankapp";
			document.forms[0].hidBeanGetMethod.value="getBreifDetailOfProject";	
			document.forms[0].action=appURL+"action/com_BreifDetailOfProject.jsp";					
			document.forms[0].submit();
			disableFields(true);
			disableCommandButtons(false,true,true,true,false);	
		}		
		else
		{
			clearFields();
			disableCommandButtons(true,true,true,true,false);
			disableFields(true);
			document.forms[0].submit();
		}
	}		
	function doSave()
	{
		if(document.forms[0].sel_facility.value=="s")
		{
			alert("Please select faciliy");
			return;
		}
		if(document.forms[0].hidChk.value=="Y")
		{
			if(document.forms[0].sel_projectloan.value =="s")
			{
				alert("Select Whether Project Loan");
				document.forms[0].sel_projectloan.focus();
				return;
			}
			else if(document.forms[0].sel_projectloan.value =="y" && document.forms[0].txt_commercialdate.value=="")
			{
				alert("Select Estimated Date of commencement of commercial operation");
				document.forms[0].txt_commercialdate.focus();
				return;
			}
		}
		disableFields(false);
		disableCommandButtons(true,true,true,true,false);
		document.forms[0].hidBeanId.value="bankapp";
		document.forms[0].hidBeanMethod.value="updateBreifDetailOfProject";
		document.forms[0].hidBeanGetMethod.value="getBreifDetailOfProject";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_BreifDetailOfProject.jsp";
		document.forms[0].submit();		
	}
	function doDelete() 
	{
	   	if(ConfirmMsg(101))
		{
	   		disableFields(false);
	   		document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanId.value="bankapp";
			document.forms[0].hidBeanMethod.value="updateBreifDetailOfProject";
			document.forms[0].hidBeanGetMethod.value="getBreifDetailOfProject";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/com_BreifDetailOfProject.jsp";
			document.forms[0].submit();
		}
	}
	function doCancel()
	{
		document.forms[0].hidBeanId.value="bankapp";
		document.forms[0].hidBeanGetMethod.value="getBreifDetailOfProject";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_BreifDetailOfProject.jsp";
		document.forms[0].submit();
	}
	function doComments()
	{
		var hidAppNo = document.forms[0].hidAppNo.value;
		var PageType = document.forms[0].PageType.value;
		var facility=document.forms[0].sel_facility.value;
		var prop = "scrollbars=no,width=750,height=550,top=25,left=180";
		var url=appURL+"action/com_realsemargincomment.jsp?hidBeanId=bankapp&hidBeanGetMethod=getCopMofComments&hidAppNo="+hidAppNo+"&PageType="+PageType+"&facilitysno="+facility;
		window.open(url,"Comments",prop);
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

	function EditorEnableDisable1(name1,val1,name2,val2)
	{
		document.getElementById(name1).style.display=val1;
		document.getElementById(name2).style.display=val2;
	}
	function callCalender(val)
	{
		if(val=="txt_actualcommercialdate")
		{
			if(document.forms[0].txt_actualcommercialdate.value!="")
			{
				return;
			}
		}
		if(document.forms[0].cmdsave.disabled==false)
		{
			 showCal(appUrl,val);
		}
	}
	function enablecal()
	{
		if(document.forms[0].sel_projectloan.value=="n")
		{
			document.all.iddcco.style.display="none";
			document.forms[0].txt_commercialdate.value="";
		}
		else
		{
			document.all.iddcco.style.display="inline";
		}
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<%	
String category = Helper.correctNull((String) request.getParameter("hidcatory"));
String Valuesin = Helper.correctNull((String) request.getParameter("valuesin"));
%>
</head>	
<body onload="callOnload()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">

<script language="JavaScript">
if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div>
</div>
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
<%}else{
	if (category.equalsIgnoreCase("bst")) 
	{
	%> 
	<lapstab:applurllinkbst pageid="3" category="<%=category%>" valuesin="<%=Valuesin%>" />

    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
		<tr>
			<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Broad Terms of Proposal -&gt; Cost of the project</td>
		</tr>
    </table>
    <lapschoice:BST /> 
    <%
    } 
	else 
	{
	%>
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
    <span class="page_flow">Home -&gt; Corporate &amp; SME -&gt;Proposal -&gt; Financial Analysis -&gt; Assessment -&gt; Term Loan Assessment -&gt; Brief Details of the project</span><br>
    <span style="display: none;"><lapschoice:borrowertype /></span> 
    <lapschoice:application />
    <%}%> 
    <%if (!(category.equalsIgnoreCase("bst"))) 
    {%>  
    <jsp:include page="../com/com_commentstab.jsp" flush="true">
	<jsp:param name="tabid" value="3" /></jsp:include>
    <%appnoval = Helper.correctNull((String)request.getParameter("appno"));%>
     
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="90%" border="0" cellspacing="1" cellpadding="3"
			class="outertable">
			<tr align="center">
			<td class="sub_tab_inactive" align="center"><a
							href="javascript:callReleasePattern('bankapp','getSourceOfMargin','com_existingtermloan.jsp','ExistingTerm')"><b>Existing Term Loan (Review)</b></a></td>
			    <td align="center" class="sub_tab_active"><b>Brief Details of the project</b></td>			    
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
<%}}%>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="5"
									class="outertable">
	<tr>
	<td>
	<table width="60%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center">
			<tr class="dataGrid">
			    <td width="30%" align="center">Facility<span class="mantatory">*</span></td>
				<td width="70%" align="left">
					<SELECT NAME="sel_facility" onchange="getvalues();" TABINDEX="1" STYLE="width: 500">
						<OPTION VALUE="s" selected>--Select--</OPTION>
						<laps:TermLoanFund appno="<%=appnoval%>" />
					</SELECT>
				</td>				
			</tr>		
			
			<tr>
			    <td colspan="2">
			    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			    <tr>
			    <td width="70%" >
			    Whether Project Loan&nbsp;&nbsp;
			    </td>
			    <td width="30%">
			    <select name="sel_projectloan" onchange="enablecal();">
			    <option value="s"><--Select--></option>
			    <option value="y">Yes</option>
			    <option value="n">No</option>
			    </select>
			      </td>
			</tr>
			    <tr id="iddccoval">
			    <td>
			    Estimated Date of commencement of commercial operation (DCCO / COD)&nbsp;&nbsp;
			    </td>
			    <td width="30%">
			    <input type="text" name="txt_commercialdate" size="11" value="<%=Helper.correctNull((String)hshValues.get("COM_DATE")) %>" maxlength="10" 
			    onBlur="checkmindate(this,currentDate)">
                <span id="iddcco"><a style="vertical-align: middle" alt="Select date from calender" href="#"
				onClick="callCalender('txt_commercialdate')"
				onMouseOver="window.status='Date Picker';return true;"
				onMouseOut="window.status='';return true;"><img
				src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
				border='0' alt="Select date from calender"></a></span>
			    
			      </td>
			    				
			</tr>
			<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
			 <tr>
			    <td>
			    Date of Actual commencement of commercial operation (DACCO)&nbsp;&nbsp;
			    </td>
			    <td width="30%" nowrap="nowrap">
			    <input type="text" name="txt_actualcommercialdate" size="11" value="<%=Helper.correctNull((String)hshValues.get("com_daccodate")) %>" maxlength="10" 
			    onBlur="checkmaxdate(this,currentDate)">
               <span id="iddacco"> <a style="vertical-align: middle" alt="Select date from calender" href="#"
				onClick="callCalender('txt_actualcommercialdate')"
				onMouseOver="window.status='Date Picker';return true;"
				onMouseOut="window.status='';return true;"><img
				src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
				border='0' alt="Select date from calender"></a></span>
			    
			      </td>
			    				
			</tr>
			<%} %>
			</table>
			</td>
			</tr>
			
</table>	
<br>
<table width="90%" border="0" cellspacing="0" cellpadding="0"
	align="center" CLASS="outertable border1">
	 <tr class="dataheader"> <td>&nbsp;Comments</td> </tr>
     <tr> 
          <td>
	          <div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("COM_COMMENTS")) %></div></div>
	          <div id="id_editor"> 
	               <textarea name="txt_comments" cols="110" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">
	                    <%=Helper.correctNull((String)hshValues.get("COM_COMMENTS")) %>
	               </textarea>
	          </div>
          </td>
     </tr>
</table>
</table>	
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />

<lapschoice:hiddentag pageid='<%=PageId%>'/>

<input type="hidden" name="hidAppNo" value="<%=Helper.correctNull((String) hshValues.get("com_appno"))%>"> 
<input type="hidden" name="hidsno" value="">
<input type="hidden" name="hidflag" value="">
<input type="hidden" name="selsno" value="">
<input type="hidden" name="hidval" >
<input type="hidden" name="hiddesc" >
<input type="hidden" name="cattype" value=""/>
<input type="hidden" name="pagefrom">
<INPUT TYPE="hidden" name="strschemeType" value = "<%=StrSchemeType%>">
<INPUT TYPE="hidden" name="strAssessment" value = "<%=request.getParameter("strAssessment")%>">
<input type="hidden" name="hidPostSancParams" value="<%=Helper.correctNull((String)hshValues.get("strPostSancParam"))%>">
<input type="hidden" name="hidChk" value="Y">
</form>
</body>
</html>
	