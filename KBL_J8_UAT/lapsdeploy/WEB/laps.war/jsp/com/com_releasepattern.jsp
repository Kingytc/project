<%@include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>

<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%String appnoval = "";
ArrayList arrRow = new ArrayList();
ArrayList arrRowMOF = new ArrayList();
ArrayList arrCol = new ArrayList();
arrRow = (ArrayList) hshValues.get("arrRow");
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
	var total="<%=Helper.correctNull((String) hshValues.get("TotalCostofProject"))%>";
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
			disableCommandButtons(true,true,true,true,false,false);
		}
		else
		{		
   		 	document.forms[0].sel_facility.value =Facilityid;
   			disableFields(true);
   			if(appstatus=="Open/Pending")
   			{
   			if(document.forms[0].btnenable.value.toUpperCase()=="Y")
   			{
   				disableCommandButtons(false,true,true,true,false,false);
   			}
   			else
   			{
   				disableCommandButtons(true,true,true,true,false,false);
   			}
   			}
   		else
   		{
   			disableCommandButtons(true,true,true,true,false,false);
   		}
   		 	
		}		
    }
	function doEdit()
	{		
		document.forms[0].hidAction.value ="insert";
		disableFields(false);
		disableCommandButtons(true,false,false,false,false,false);
	}
	function getvalues()
	{
		if(document.forms[0].sel_facility.selectedIndex>0)
		{
			document.forms[0].hidBeanId.value="bankapp";
			document.forms[0].hidBeanGetMethod.value="updateReleasePattern";
			document.forms[0].hidBeanGetMethod.value="getReleasePattern";
			//document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/com_releasepattern.jsp";
			document.forms[0].submit();
			disableFields(true);
			disableCommandButtons(false,true,true,true,false,false);	
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
		var amounttotal="<%=Helper.checkDecimal(Helper.correctDouble((String) hshValues.get("TotalCostofProject")))%>";
		var totalmargin=document.forms[0].hidmargintotal.value;
		var totalloan=document.forms[0].hidloantotal.value;
		var total=roundVal(parseFloat(totalmargin)+parseFloat(totalloan));
		if(eval(amounttotal)==eval(total))
		{
			document.forms[0].cmdsave.disabled = true;
			document.forms[0].hidBeanId.value="bankapp";
			document.forms[0].hidBeanMethod.value="updateReleasePattern";
			document.forms[0].hidBeanGetMethod.value="getReleasePattern";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/com_releasepattern.jsp";
			document.forms[0].submit();
		}else
		{
			alert("Sum of Margin and Bank Loan should be equal to Total Amount");
		}
		
	}
	function doDelete() 
	{
	   	if(ConfirmMsg(101))
		{
	   		disableFields(false);
	   		document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanId.value="bankapp";
			document.forms[0].hidBeanMethod.value="updateReleasePattern";
			document.forms[0].hidBeanGetMethod.value="getReleasePattern";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/com_releasepattern.jsp";
			document.forms[0].submit();
		}
	}
	function doCancel()
	{
		document.forms[0].hidBeanId.value="bankapp";
		document.forms[0].hidBeanGetMethod.value="getReleasePattern";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_releasepattern.jsp";
		document.forms[0].submit();
	}
	function doComments()
	{
		var btnenable=document.forms[0].btnenable.value;
		var hidAppNo = document.forms[0].hidAppNo.value;
		var PageType = document.forms[0].PageType.value;
		var facility=document.forms[0].sel_facility.value;
		var prop = "scrollbars=no,width=750,height=550,top=25,left=180";
		var url=appURL+"action/com_realsemargincomment.jsp?hidBeanId=bankapp&hidBeanGetMethod=getCopMofComments&hidAppNo="+hidAppNo+"&PageType="+PageType+"&facilitysno="+facility+"&appstatus="+appstatus+"&btnenable="+btnenable;
		window.open(url,"Comments",prop);
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
		
	}
	
	function MarginAmount()
	{
		 <%
   		 if(arrRow != null && arrRow.size()>0)
   		 {
   		   	 for(int i=0;i<arrRow.size();i++)
   		   	 {
   		   		 if(arrRow.size()==1)
   		   		 	{
   		   		 		%>
   		   		 	var varMargin=document.forms[0].txt_margin.value;
   		   		 	var amount=document.forms[0].hid_margin.value;
   		   		 	if(varMargin=="")
   	   	    			varMargin="0";
   	   	    	if(amount=="")
   	    			amount="0";
   	   	    		var varMarginAmt=(varMargin*100)/amount;
   	   	    		document.forms[0].txt_marginamt.value = varMarginAmt;
   	   	    		roundtxt(document.forms[0].txt_marginamt);
   		   		 		<%
   		   		 	}
   		   		 	else
   		   		 	{
   		  %>
   		   		 
   	 	  		var varMargin=document.forms[0].txt_margin[<%=i%>].value;
   	 	  		var amount=document.forms[0].hid_margin[<%=i%>].value;
   	    		if(varMargin=="")
   	    			varMargin="0";
   	    		if(amount=="")
   	    			amount="0";
   	    		var varMarginAmt=(varMargin*100)/amount;
   	    		document.forms[0].txt_marginamt[<%=i%>].value = varMarginAmt;
   	    		roundtxt(document.forms[0].txt_marginamt[<%=i%>]);
   	    <% }
   		   		 	}
   	    		
   	     }%>
   	}
   	function totalmargin()
   	{
   	   	var totalmargin="0";
   	   	<%if(arrRow != null && arrRow.size()>0)
  		 {
  		   	 for(int i=0;i<arrRow.size();i++)
  		   	 {
  		   		 if(arrRow.size()==1)
  		   		 	{%>
  		   				var varMargin=document.forms[0].txt_margin.value;
  		   				
  		   				totalmargin=parseFloat(varMargin);
  		   		 	<%}else{%>
  		   		 		var varMargin=document.forms[0].txt_margin[<%=i%>].value;
  		   		 		totalmargin=parseFloat(totalmargin)+parseFloat(varMargin);
  		   			<%}
  		   	 	}
  		   	}%>
  		  
  		  document.forms[0].hidmargintotal.value=roundVal(totalmargin);
  		  document.all.margintotal.innerText=roundVal(totalmargin);
   	}

	function totalbankloan()
   	{
   	   	var totalbankloan="0";
   		<%if(arrRow != null && arrRow.size()>0)
  		 {
  		   	 for(int i=0;i<arrRow.size();i++)
  		   	 {
  		   		 if(arrRow.size()==1)
  		   		 	{%>
  		   				var varMargin=document.forms[0].txt_bankloan.value;
  		   				totalbankloan=parseFloat(varMargin);
  		   		 	<%}else{%>
  		   		 		var varMargin=document.forms[0].txt_bankloan[<%=i%>].value;
  		   		 		totalbankloan=parseFloat(totalbankloan)+parseFloat(varMargin);
  		   			<%}
  		   	 	}
  		   	}%>
  		  document.forms[0].hidloantotal.value=roundVal(totalbankloan);
  		  document.all.loantotal.innerText=roundVal(totalbankloan);
   	}
	function BankloanAmount()
	{
		 <%
   		 if(arrRow != null && arrRow.size()>0)
   		 {
   		   	 for(int i=0;i<arrRow.size();i++)
   		   	 { 
   		   		 if(arrRow.size()==1)
   		   		 {
   		   		%>
   		   		var varBankloan=document.forms[0].txt_bankloan.value;
   		   		var amount=document.forms[0].hid_margin.value;
	    		if(varBankloan=="")
	    			varBankloan="0";
	    		if(amount=="")
	    			amount="0";
	    		var varBankloanAmt=(varBankloan*100)/amount;
	    		document.forms[0].txt_bankloanamt.value = varBankloanAmt;
	    		roundtxt(document.forms[0].txt_bankloanamt);
   		   		<%	 
   		   		 }
   		   		 else
   		   		 {
   		   			%>

   	   	 	  		var varBankloan=document.forms[0].txt_bankloan[<%=i%>].value;
   	   	 	 		var amount=document.forms[0].hid_margin[<%=i%>].value;
   	   	    		if(varBankloan=="")
   	   	    			varBankloan="0";
   	   	    	if(amount=="")
	    			amount="0";
   	   	    		var varBankloanAmt=(varBankloan*100)/amount;
   	   	    		document.forms[0].txt_bankloanamt[<%=i%>].value = varBankloanAmt;
   	   	    		roundtxt(document.forms[0].txt_bankloanamt[<%=i%>]);
   		   			<% 
   		   		 }
   		  
   	    	}
   	    		
   	     } %>
   	}
	
	</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<%	String category = Helper.correctNull((String) request.getParameter("hidcatory"));
			String Valuesin = Helper.correctNull((String) request.getParameter("valuesin"));%>
</head>	
<body onload="callOnload();totalmargin();totalbankloan();">
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
Assessment -&gt; Release Pattern/ Margin</span><br>
<span style="display: none;"><lapschoice:borrowertype /></span> <lapschoice:application />
<%}%> <%if (!(category.equalsIgnoreCase("bst"))) { %>  <jsp:include page="../com/com_commentstab.jsp"
	flush="true">
	<jsp:param name="tabid" value="3" />
</jsp:include>
<%appnoval = Helper.correctNull((String)request.getParameter("appno"));

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
							href="javascript:gotoTab(appUrl,'bankapp','getBreifDetailOfProject','com_BreifDetailOfProject.jsp')"><b>Brief Details of the project</b></a></td>					    
				<td class="sub_tab_inactive" align="center"><a
							href="javascript:callcopmof()"><b>Term loan Assessment</b></a></td>
		       <td class="sub_tab_inactive" align="center"><a
					href="javascript:callTermAssesement('bankapp','getSourceOfMargin','com_contlimitcomment.jsp','SOM')"><b>Source of Margin</b></a></td>
				<td class="sub_tab_inactive" align="center"><a
							href="javascript:callReleasePattern('bankapp','getSourceOfMargin','com_commenstonproj.jsp','CommentsProj')"><b>Comments on the project</b></a></td>
				<td align="center" class="sub_tab_active"><b>Release Pattern/ Margin</b></td>
				
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
	<table width="60%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
			<tr class="dataGrid">
			<td width="30%" align="center">Facility<span class="mantatory">*</span>
				</td>
				<td width="70%" align="left"><SELECT NAME="sel_facility" onchange="getvalues();"
									TABINDEX="1" STYLE="width: 500">
									<OPTION VALUE="s" selected>--Select--</OPTION>
								<laps:TermLoanFund appno="<%=appnoval%>" />
									</SELECT></td>
				
			</tr>
			
		
</table>	
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" CLASS="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="2">
	<tr class="dataheader"><td align="right" colspan="7"><b>All Values are in <%=Helper.correctNull((String)hshValues.get("strValuesin")) %></b></td></tr>
			<tr class="dataheader">
				<td width="25%" align="center">Particulars</td>
				<td width="25%" align="center">Description</td>
				<td width="10%" align="center">Amount</td>
				<td width="10%" align="center">Margin</td>
				<td width="10%" align="center">Margin(%)</td>
				<td width="10%" align="center">Bank Loan</td>
				<td width="10%" align="center">Bank Loan (%)</td>
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
				
				<input type="hidden" name="hiddescsno" value="<%=Helper.correctNull((String) arrCol.get(2))%>">			
				<input type="hidden" name="hidtotal" value="<%=Helper.correctNull((String) arrCol.get(1))%>">
				<input type="hidden" name="hidcopmofsno" value="<%=Helper.correctNull((String) arrCol.get(8))%>">
										
				<td width="25%" class="datagrid"><B><%=Helper.correctNull((String) arrCol.get(3))%></B></td>
				<td width="25%" class="datagrid" align="left"><B><%=Helper.correctDouble((String) arrCol.get(0))%></B></td>
				<td width="10%" class="datagrid" align="right"><B><%=Helper.correctNull((String) arrCol.get(1))%></B>
				<input type="hidden" name="hid_margin" value="<%=Helper.correctDouble((String) arrCol.get(1))%>">
				</td>
				<td width="10%" align="right"><input type="text" name="txt_margin" size="10" style="text-align:right" maxlength="10" onkeypress="allowDecimals(this)" onBlur="roundtxt(this);MarginAmount();totalmargin();" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(4))))%>"></td>
				<td width="10%" align="right"><input type="text" readonly="readonly" name="txt_marginamt" size="10" style="text-align:right" maxlength="100" onkeypress="allowDecimals(this)" onBlur="roundtxt(this)" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(5))))%>"></td>
				<td width="10%" align="right"><input type="text" name="txt_bankloan" size="10" style="text-align:right" maxlength="10" onkeypress="allowDecimals(this)" onBlur="roundtxt(this);BankloanAmount();totalbankloan()" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(6))))%>"></td>
				<td width="10%" align="right"><input type="text" readonly="readonly" name="txt_bankloanamt" size="10" style="text-align:right" maxlength="10" onkeypress="allowDecimals(this)" onBlur="roundtxt(this)" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(7))))%>"></td>
			</tr>
			
			
	<%
	}}%>
	
			<tr class="dataGrid">
				
				<td width="50%" align="right" colspan="2"><b>Total</b>&nbsp;</td>
				<td align="right" width="10%"><b><%=Helper.checkDecimal(Helper
							.correctDouble((String) hshValues
									.get("TotalCostofProject")))%></b></td>
				<td width="10%" align="right"><span id="margintotal">&nbsp;</span></td>
				<td width="10%">&nbsp;</td>
				<td width="10%" align="right"><span id="loantotal">&nbsp;</span></td>
				<td width="10%">&nbsp;</td>	
						
			</tr>
		</table>
	
		
	
		</td>
	</tr>
</table>	
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail_Comments'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />

<lapschoice:hiddentag pageid='<%=PageId%>'/>

<input type="hidden" name="hidAppNo" value="<%=Helper.correctNull((String) hshValues.get("com_appno"))%>"> 
<input type="hidden" name="PageType" value="release">
<input type="hidden" name="hidsno" value="">
<input type="hidden" name="hidflag" value="">
<input type="hidden" name="selsno" value="">
<input type="hidden" name="hidval" >
<input type="hidden" name="hiddesc" >
<input type="hidden" name="hidmargintotal" >
<input type="hidden" name="hidloantotal" >
<input type="hidden" name="flowtype"/>
<input type="hidden" name="cattype" value=""/>
<input type="hidden" name="pagefrom">
<INPUT TYPE="hidden" name="strAssessment" value = "<%=request.getParameter("strAssessment")%>">
</form>
</body>
</html>
	