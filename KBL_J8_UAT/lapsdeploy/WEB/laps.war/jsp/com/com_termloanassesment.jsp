<%@include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>

<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%String appnoval = "";
ArrayList arrRow = new ArrayList();
ArrayList arrRowMOF = new ArrayList();
ArrayList arrCol = new ArrayList();

ArrayList vecCopRow=new ArrayList();
ArrayList vecCopCol=new ArrayList();
ArrayList vecMofRow=new ArrayList();
ArrayList vecMofCOl=new ArrayList();

arrRow = (ArrayList) hshValues.get("arrRow");
if(hshValues!=null)
{
	vecCopRow=(ArrayList)hshValues.get("vecCopRow");
	vecMofRow=(ArrayList)hshValues.get("vecMofRow");	
}

%> 
<laps:handleerror />
<html>
<head>
<title>Commercial-Principal (s)</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>	

	<script type="text/javascript">
	var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
	var Facilityid="<%=Helper.correctNull((String) hshValues.get("hshFacility"))%>";
	
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
	function gototab(beanid,methodname,pagename,type)
	{
			document.forms[0].hidBeanId.value=beanid;
			document.forms[0].hidBeanGetMethod.value=methodname;
			document.forms[0].action=appURL+"action/"+pagename;
			document.forms[0].flowtype.value=type;
			document.forms[0].submit();
	} 
	function disableCommandButtons(cmdNew,cmdEdit,cmdSave,cmdCancel,cmdDelete,cmdClose,cmdComments)
	{
		  document.forms[0].cmdnew.disabled=cmdNew;
	      document.forms[0].cmdedit.disabled=cmdEdit;
	  	  document.forms[0].cmdsave.disabled=cmdSave;
		  document.forms[0].cmdcancel.disabled=cmdCancel;
		  document.forms[0].cmddelete.disabled=cmdDelete;	
		  document.forms[0].cmdclose.disabled=cmdClose; 
		  document.forms[0].cmdcomments.disabled=cmdComments; 	
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
			document.forms[0].cmdnew.disabled=true;
			document.forms[0].cmdcomments.disabled=true;
		}
		else
		{		
    	document.forms[0].sel_facility.value =Facilityid;
    	document.forms[0].cmdnew.disabled=false;
    	
		}
    	document.forms[0].sel_operation.disabled=true;
		document.forms[0].sel_description.disabled=true;
		document.forms[0].txt_description.disabled=true;
		document.forms[0].txt_procostinc.disabled=true;
		document.forms[0].txt_procosttobeinc.disabled=true;
		document.forms[0].txt_total.disabled=true;
    	document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
		document.forms[0].cmdcomments.disabled=false;
		document.forms[0].sel_descriptionmof.disabled=true;
		
	}
	function doNew()
	{			
		disableFields(false);
		document.forms[0].hidAction.value ="insert";
		disableCommandButtons(true,true,false,false,true,true,false);
	
	}
	function doEdit()
	{		
		document.forms[0].hidAction.value ="update";
		disableFields(false);
		disableCommandButtons(true,true,false,false,false,false,false);
	}
	function getvalues()
	{
		if(document.forms[0].sel_facility.selectedIndex>0)
		{
			document.forms[0].hidBeanId.value="bankapp";
			document.forms[0].hidBeanGetMethod.value="updateTermLoanAssesment";
			document.forms[0].hidBeanGetMethod.value="getTermLoanAssesment";
			//document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/com_termloanassesment.jsp";
			document.forms[0].submit();
		}
		else
		{
			clearFields();
			disableCommandButtons(true,true,true,true,true,false,false);
			disableFields(true);
			document.forms[0].submit();
		}
	}		
	function doSave()
	{

		if(document.forms[0].sel_operation.value=="s")
		{
			alert("Please select Type");
			document.forms[0].sel_operation.focus();
			return;
		}
		
		if(document.forms[0].txt_description.value=="")
		{
			alert("Please Enter the Description");
			document.forms[0].txt_description.focus();
			return;
		}
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidBeanId.value="bankapp";
		document.forms[0].hidBeanMethod.value="updateTermLoanAssesment";
		document.forms[0].hidBeanGetMethod.value="getTermLoanAssesment";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_termloanassesment.jsp";
		document.forms[0].submit();
	}
	function doDelete() 
	{
	   	if(ConfirmMsg(101))
		{
	   		disableFields(false);
	   		document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanId.value="bankapp";
			document.forms[0].hidBeanMethod.value="updateTermLoanAssesment";
			document.forms[0].hidBeanGetMethod.value="getTermLoanAssesment";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/com_termloanassesment.jsp";
			document.forms[0].submit();
		}
	}
	function doCancel()
	{
		document.forms[0].hidBeanId.value="bankapp";
		document.forms[0].hidBeanGetMethod.value="getTermLoanAssesment";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_termloanassesment.jsp";
		document.forms[0].submit();
	}
	function doComments()
	{
		var btnenable=document.forms[0].btnenable.value;
		var appno=document.forms[0].appno.value;
		var facility=document.forms[0].sel_facility.value;
		var url=appURL+"action/com_copmofcomments.jsp?hidBeanId=bankapp&hidBeanGetMethod=getCopMofComments&hidAppNo="+appno+"&facilitysno="+facility+"&PageType=COPMOF"+"&appstatus="+appstatus+"&btnenable="+btnenable;
		var prop = "scrollbars=no,menubar=no,width=750,height=550,top=25,left=180";
		window.open(url,'title',prop);	
	}
	function totalcostofproject()
	{
		var varincur=NanNumber(document.forms[0].txt_procostinc.value);
		var vartobeincur=NanNumber(document.forms[0].txt_procosttobeinc.value);
		if(varincur=="")
			varincur="0";
		if(vartobeincur=="")
			vartobeincur="0";
		var total = parseFloat(varincur) + parseFloat(vartobeincur);
		document.forms[0].txt_total.value = total;
		roundtxt(document.forms[0].txt_total);
	}
	function selectValues(val1,val2,val3,val4,val5,val6,val7,val8)
	{
		document.forms[0].sel_facility.value =val1;
		document.forms[0].sel_operation.value=val2;
		changeValues();
		if(val2=="C")
		{
			document.forms[0].sel_description.value=val3;
		}
		else if(val2=="M")
		{
			document.forms[0].sel_descriptionmof.value=val3;
		}		
		document.forms[0].txt_description.value=val4;
		document.forms[0].txt_procostinc.value=val5;
		document.forms[0].txt_procosttobeinc.value=val6;
		document.forms[0].txt_total.value =val7;
		document.forms[0].hidsno.value =val8;
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
		disableCommandButtons(true,false,true,false,false,false,false);		
		}
	}
	function clearFields()
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
				document.forms[0].elements[i].value="";		  
			}
		/*	else if (document.forms[0].elements[i].type=="select-one")
			{
				document.forms[0].elements[i].value="s";	
			}*/
			else if(document.forms[0].elements[i].type=="textarea")
			{
				document.forms[0].elements[i].value="";		  
			}
		}
		document.forms[0].sel_operation.value="s";
		document.forms[0].sel_description.value="s";
		
	}

	function changeValues()
	{
      if(document.forms[0].sel_operation.value=="C")
      {
     /*   document.all.selcop.style.visibility="visible";
        document.all.selcop.style.position="relative";
        document.all.selmof.style.visibility="hidden";
        document.all.selmof.style.position="absolute";*/

        document.all.selcop.style.display="table-cell";
        document.all.selmof.style.display="none";
        document.all.id_cop.innerHTML="Already incurred";
        document.all.id_mof.innerHTML="To be incurred";
      }
      else if(document.forms[0].sel_operation.value=="M")
      {
/*    	  document.all.selmof.style.visibility="visible";
          document.all.selmof.style.position="relative";
          document.all.selcop.style.visibility="hidden";
          document.all.selcop.style.position="absolute";*/

          document.all.selmof.style.display="table-cell";
          document.all.selcop.style.display="none";
          document.all.id_cop.innerHTML="Already brought in";
          document.all.id_mof.innerHTML="To be brought in";
      }
      else
      {
/*    	  document.all.selcop.style.visibility="visible";
          document.all.selcop.style.position="relative";
          document.all.selmof.style.visibility="hidden";
          document.all.selmof.style.position="absolute";*/

          document.all.selcop.style.display="table-cell";
          document.all.selmof.style.display="none";
      } 


	}
	</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<%	String category = Helper.correctNull((String) request.getParameter("hidcatory"));
			String Valuesin = Helper.correctNull((String) request.getParameter("valuesin"));%>
</head>	
<body onload="callOnload();changeValues()">
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
<form  method="post" class="normal">
	<%if (category.equalsIgnoreCase("bst")) {%> <lapstab:applurllinkbst
		pageid="3" category="<%=category%>" valuesin="<%=Valuesin%>" />

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Broad
		Terms of Proposal -&gt; Cost of the project</td>
	</tr>
</table>
<lapschoice:BST /> <%} else {%>
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
<span class="page_flow">Home -&gt; Corporate &amp; SME -&gt;
Proposal -&gt; Financial Analysis -&gt; Assessment -&gt; Term Loan
Assessment -&gt; Cost of Project</span><br>
<span style="display: none;"><lapschoice:borrowertype /></span> <lapschoice:application />
<%}%> <%if (!(category.equalsIgnoreCase("bst"))) { %>  <jsp:include page="../com/com_commentstab.jsp"
	flush="true">
	<jsp:param name="tabid" value="3" />
</jsp:include>
<%appnoval = Helper.correctNull((String)request.getParameter("appno"));
//System.out.println("appnoval==> "+appnoval);
%> 
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="90%" border="0" cellspacing="1" cellpadding="3"
			class="outertable">
			<tr align="center">
			<td class="sub_tab_inactive" align="center"><a
							href="javascript:callReleasePattern('bankapp','getSourceOfMargin','com_existingtermloan.jsp','ExistingTerm')"><b>Existing Term Loan (Review)</b></a></td>
			     <td class="sub_tab_inactive" align="center"><a
							href="javascript:callTermAssesement('bankapp','getBreifDetailOfProject','com_BreifDetailOfProject.jsp','')"><b>Brief Details of the project</b></a></td>					    
				<td class="sub_tab_active" align="center"><b>Term loan Assessment</b></td>
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
									class="outertable linebor">
	<tr>
	<td>
	<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<%if(!Helper.correctNull((String)hshValues.get("strValuesin")).equalsIgnoreCase("")) {%>
	<tr class="dataheader"><td align="right" colspan="4"><b>All Values are in <%=Helper.correctNull((String)hshValues.get("strValuesin")) %></b></td></tr>
	<%} %>
			<tr align="center" class="dataheader">
			<td width="12%" align="center">Facility<span class="mantatory">*</span>
				</td>
				<td width="12%" align="center">Type<span class="mantatory">*</span>
				</td>
				<td width="15%" align="center">Particulars<span class="mantatory">*</span><b><font
					color=red></font></b></td>
				<td width="20%" align="center">Description<span
					class="mantatory">*</span><b><font color=red></font></b></td>
			</tr>
			
			<tr align="center" class="datagrid">
				<TD WIDTH="9%"><SELECT NAME="sel_facility" onchange="getvalues();"
									TABINDEX="1" STYLE="width: 200">
									<OPTION VALUE="s" selected>--Select--</OPTION>
								<laps:TermLoanFund appno="<%=appnoval%>" />
									</SELECT></TD>
				
				<td width="12%"><select name="sel_operation" style="width: 160" onchange="changeValues()">
					<option value="s" selected>-- Select --</option>
					<option value="C">Cost of Project</option>
					<option value="M">Means of Finance</option>
				</select></td>
				<td width="15%"  id="selcop"><select name="sel_description" style="width: 200">
					<option value="s" selected>-- Select --</option>
					<%if(vecCopRow!=null && vecCopRow.size()>0){ 
					  for(int i=0;i<vecCopRow.size();i++){
						  vecCopCol=(ArrayList)vecCopRow.get(i);						  
					  %>
					  <option value="<%=Helper.correctNull((String)vecCopCol.get(1))%>"><%=Helper.correctNull((String)vecCopCol.get(2))%></option>					
					<%}} %>														
				</select>
				</td>
				<td width="15%" id="selmof">
				<select name="sel_descriptionmof" style="width: 200">
					<option value="s" selected>-- Select --</option>
					<%if(vecMofRow!=null && vecMofRow.size()>0){ 
					  for(int i=0;i<vecMofRow.size();i++){
						  vecMofCOl=(ArrayList)vecMofRow.get(i);						  
					  %>
					  <option value="<%=Helper.correctNull((String)vecMofCOl.get(1))%>"><%=Helper.correctNull((String)vecMofCOl.get(2))%></option>					
					<%}} %>														
				</select></td>
				<td width="20%"><input type="text" name="txt_description"
					onBlur="" size="50" maxlength="100" style="text-align: left"
					value="" onKeyPress=""></td>
				</tr>
				<tr class="dataheader">
				<td align="center" width="10%" id="id_cop">Already incurred</td>
				<td align="center" width="10%" id="id_mof">To be incurred</td>
				<td align="center" width="10%">Total</td>
			</tr>
				<tr align="center" class="datagrid">
				
				<td width="10%"><input type="text" name="txt_procostinc"
					onBlur="roundtxt(this);totalcostofproject()" size="12"
					maxlength="10" style="text-align: right" value=""
					onKeyPress="allowNumber(this)"></td>
				<td width="10%"><input type="text" name="txt_procosttobeinc"
					onBlur="roundtxt(this);totalcostofproject()" size="12"
					maxlength="10" style="text-align: right" value=""
					onKeyPress="allowNumber(this)"></td>
				<td width="10%"><input type="text" name="txt_total" readOnly
					size="12" maxlength="12" style="text-align: right"></td>
			</tr>
		</table>
				</td>
	</tr>
</table>	
<br>
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail_Comments'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
		
<br>

<table width="75%" border="0" cellspacing="0" cellpadding="0"
	align="center" CLASS="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="2">
			<tr class="dataheader">
				<td width="4%">&nbsp;</td>
				
				<td width="36%" align="center">Particulars</td>
				<td width="40%" align="center">Description</td>
				<td width="20%" align="center">Total</td>
			</tr>
			<tr class="dataheader">
				<td colspan="4" align="center">Cost of Project</td>
			</tr>
		</table>
		<table width="100%" cellspacing="1" cellpadding="2" align="center">
		<%
				arrCol = new ArrayList();
				arrRow = (ArrayList) hshValues.get("arrRow");
				
				if (arrRow != null && arrRow.size() > 0) {
					for (int i = 0; i < arrRow.size(); i++) {
						
						arrCol = (ArrayList) arrRow.get(i);	
						
			%>
				<tr class="dataGrid">
		<td width="4%" align="center"><input type="radio"
			style="border: none" name="radiobutton" value="radiobutton"
			onClick="javascript:selectValues('<%=Helper.correctNull((String) arrCol.get(8))%>',
												'<%=Helper.correctNull((String) arrCol.get(1))%>',
												'<%=Helper.correctNull((String) arrCol.get(2))%>',
												'<%=Helper.correctNull((String) arrCol.get(3))%>',
												'<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(4)))%>',
												'<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(5)))%>',
												'<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(6)))%>',
												'<%=Helper.correctNull((String) arrCol.get(0))%>')">
		</td>
					
				<td width="36%" class="datagrid"><B><%=Helper.correctNull((String) arrCol.get(7))%></B></td>
				<td width="40%" class="datagrid" align="left"><B><%=Helper.correctNull((String) arrCol.get(3))%></B></td>
				<td width="20%" class="datagrid" align="right"><B><%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(6)))%></B></td>
				
			</tr>
			
			
	<%
	}}%>
	
			<tr class="dataGrid">
				<td width="4%" align="center">&nbsp;</td>
				<td width="66%" align="right" colspan="2"><b>Total</b>&nbsp;</td>
				<td align="right" width="30%"><b><%=Helper.checkDecimal(Helper
							.correctDouble((String) hshValues
									.get("TotalCostofProject")))%></b></td>
			</tr>
		</table>
	
		<table width="100%" border="0" cellspacing="0" cellpadding="2"
			align="center" CLASS="dataheader outertable border1">
			<tr class="dataheader">
				<td colspan="4" align="center">Means of Finance</td>
			</tr>
		</table>
		<table width="100%" cellspacing="1" cellpadding="2" align="center" >

			<%
				arrCol = new ArrayList();
				arrRowMOF = (ArrayList) hshValues.get("arrRowMOF");
				
				if (arrRow != null && arrRowMOF.size() > 0) {
					for (int i = 0; i < arrRowMOF.size(); i++) {
						
						arrCol = (ArrayList) arrRowMOF.get(i);	
						
			%>
				<tr class="datagrid">
				<td width="4%" align="center"><input type="radio"
					style="border: none" name="radiobutton" value="radiobutton"
					onClick="javascript:selectValues('<%=Helper.correctNull((String) arrCol.get(8))%>',
												'<%=Helper.correctNull((String) arrCol.get(1))%>',
												'<%=Helper.correctNull((String) arrCol.get(2))%>',
												'<%=Helper.correctNull((String) arrCol.get(3))%>',
												'<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(4)))%>',
												'<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(5)))%>',
												'<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(6)))%>',
												'<%=Helper.correctNull((String) arrCol.get(0))%>')">
				</td>
					
				<td width="36%" class="datagrid"><B><%=Helper.correctNull((String) arrCol.get(7))%></B></td>
				<td width="40%" class="datagrid" align="left"><B><%=Helper.correctNull((String) arrCol.get(3))%></B></td>
				<td width="20%" class="datagrid" align="right"><B><%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(6)))%></B></td>

			</tr>
			
			
	<%
	}}%>
	
			<tr class="dataGrid">
				<td width="4%" align="center">&nbsp;</td>
				<td width="66%" align="right" colspan="2"><b>Total</b>&nbsp;</td>
				<td align="right" width="53%">&nbsp;<b><%=Helper.checkDecimal(Helper
							.correctDouble((String) hshValues
									.get("TotalMeansofFinance")))%></b></td>
			</tr>

		</table>
		
		
		<table width="100%" cellspacing="1" cellpadding="2" align="center" >
		
			<%
		double projectMOF = 0.0;
		double meansMOF = 0.0;
		String eligibleMOF = "";

		projectMOF = Double
				.parseDouble(Helper.correctDouble((String) hshValues
						.get("TotalCostofProject")));
		meansMOF = Double.parseDouble(Helper
				.correctDouble((String) hshValues
						.get("TotalMeansofFinance")));
		if (projectMOF == meansMOF) {
			eligibleMOF = "1";
		} else {
			eligibleMOF = "2";
		}
		if (eligibleMOF.equalsIgnoreCase("1")) {
	%>
	<tr class="dataGrid">
		<td colspan="2" align="right"><b>Status</b>&nbsp;</td>
		<td align="right" width="40%"><font color="green"> &nbsp;<b>Cost
		of Project & Means of Finance are Equal</b></font></td>
	</tr>
	<%
		} else if (eligibleMOF.equalsIgnoreCase("2")) {
	%>
	<tr class="dataGrid">
		<td colspan="2" align="right"><b>Status</b>&nbsp;</td>
		<td align="right" width="40%"><font color="red"> &nbsp;<b>Cost
		of Project & Means of Finance are not Equal</b></font></td>
	</tr>
	<%
		}
	%>	
	
	<tr class="dataGrid">
		<td colspan="2" align="right"><b>Debt:Equity</b>&nbsp;</td>
		<td align="right" width="40%"><%=Helper.checkDecimal(Helper.correctDouble((String) hshValues.get("dbl_Debit")))%></td>
	</tr>
	
			</table>
		</td>
	</tr>
</table>
<br>

<lapschoice:hiddentag pageid='<%=PageId%>'/>

<input type="hidden" name="hidsno" value="">
<input type="hidden" name="hidflag" value="">
<input type="hidden" name="selsno" value="">
<input type="hidden" name="hidval" >
<input type="hidden" name="hiddesc" >
<input type="hidden" name="flowtype"/>
<input type="hidden" name="cattype" value=""/>
<input type="hidden" name="pagefrom">
<INPUT TYPE="hidden" name="strAssessment" value = "<%=request.getParameter("strAssessment")%>">
</form>
</body>
</html>
	