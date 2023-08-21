<%@include file="../share/directives.jsp"%>

<%
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=new ArrayList();
	if(hshValues!=null)
	{
	arrRow = (ArrayList)hshValues.get("arrRow");
	}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Pan Mandate</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" href="../htm/link.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>


<script>	
var currentDate="<%=Helper.getCurrentDateTime()%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var maxval="<%=Helper.correctNull((String)hshValues.get("maxval"))%>"



function callCalender1(name)
{	
	if(document.forms[0].cmdnew.disabled==true && document.forms[0].cmdedit.disabled==true)
	{
		showCal(appURL,name);
	}
}
	function doNew() 
	{
		callDisable(false);
		disableControls(true,true,false,false,false);
		document.forms[0].hidAction.value="Insert";
		document.forms[0].txt_proposalno.readOnly=true;
		document.forms[0].txt_proposalcreatedt.readOnly=true;
		document.forms[0].txt_custid.readOnly=true;
		document.forms[0].txt_Name.readOnly=true;	

	}
	function doEdit() 
	{
		callDisable(false);
		disableControls(true,true,false,false,false);
		document.forms[0].hidAction.value="Update";
		document.forms[0].txt_proposalno.readOnly=true;
		document.forms[0].txt_proposalcreatedt.readOnly=true;
		document.forms[0].txt_custid.readOnly=true;
		document.forms[0].txt_Name.readOnly=true;
		document.forms[0].choose_type.disabled=true;		
	}
	
	function doCancel()
	{
		
		if(ConfirmMsg('102'))
		{
			document.forms[0].action=appURL+"action/setPancheck.jsp";
			document.forms[0].hidBeanId.value = "PanMandate";
			document.forms[0].hidBeanGetMethod.value = "getProposaldetails";
			document.forms[0].submit();
		}
		
	}
	function callonLoad()
	{
			callDisable(true);
			disableControls(false,true,true,true,false);		
	
	}
	
	function disableControls(cmdNew,cmdEdit,cmdApply,cmdcancle,cmdClose)
	{
		document.forms[0].cmdnew.disabled=cmdNew;
		document.forms[0].cmdedit.disabled=cmdEdit;
		document.forms[0].cmdsave.disabled=cmdApply;
		document.forms[0].cmdcancel.disabled=cmdApply;
		document.forms[0].cmdclose.disabled=cmdClose;
	}

	function callDisable(one)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=one;
			}
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=one;
			}
			if(document.forms[0].elements[i].type=="select-one")
			{
				document.forms[0].elements[i].disabled=one;
			}
			
		}
		
		
	}

function doClose()
{
	   if(ConfirmMsg(100))
		 {
		   document.forms[0].action=appURL+"action/mainnav.jsp";
			document.forms[0].submit();
		 }
}

function doSave()  
{
	
	if(document.forms[0].txt_effectivetilldate.value=="")
	{
		ShowAlert(121,"Effective Tille date");
		document.forms[0].txt_effectivetilldate.focus();
		return;
	}	
	document.forms[0].cmdsave.disabled = true;	
	document.forms[0].hidBeanId.value="PanMandate";	
	document.forms[0].hidBeanMethod.value="updatedetails";
	document.forms[0].hidBeanGetMethod.value="getProposaldetails";
	document.forms[0].hidSourceUrl.value="/action/setPancheck.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();

}

function allow()
{
	var key = window.event.keyCode;
	if(!(key>47 && key<58))
	{
		window.event.returnValue = false;
	}
}
function placeValues(val0,val1,val2,val3,val4,val5)
{
	document.forms[0].txt_proposalno.value=val0;
	document.forms[0].choose_type.value=val1;	
	//document.forms[0].txt_LAR.value=val2;
	document.forms[0].txt_custid.value=val2;
	document.forms[0].txt_Name.value=val3;
	document.forms[0].txt_proposalcreatedt.value=val4;
	document.forms[0].txt_effectivetilldate.value=val5;			
	disableControls(true,false,true,true,false);
}
function searchProposal()
{
	if(document.forms[0].cmdnew.disabled==true && document.forms[0].cmdedit.disabled==true)
		{
   var varQryString = appURL+"action/searchproposalno.jsp?hidBeanId=PanMandate&hidBeanGetMethod=getproposalist&par="+document.forms[0].choose_type.value;
   var title = "Acknowledgement";
   var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
   var xpos = (screen.width - 350) / 2;
   var ypos = (screen.height - 120) / 2;
    prop = prop + ",left=50,top=50";
    window.open(varQryString,title,prop);	
		}
}

function specialcharalert(event) {	
	  var x = event.which || event.keyCode;	
	  
	     if(x==34||x==39)
		  {
		   alert("Double or single quotes not allowed");
		   return false;
		  }
       else
    	   {
    	   return true;
    	   }
	  
	}
function callDescCBS()
{	
	if(document.forms[0].cmdnew.disabled==true && document.forms[0].cmdedit.disabled==true)
	{
	var varQryString = appURL+"action/CBSIDhelp.jsp?hidPagename=inward";
	var title = "SelectCBSID";
	var prop = "scrollbars=yes,menubar=yes,status=yes,width=500,height=400";
	prop = prop + ",left=50,top=150";
    window.open(varQryString,title,prop);
	}
}
function allowalwysFutureDate(obj,currentdate)
{
	var pagedate=obj.value;
	var pgdt=changeDateformat(pagedate);
	var currentdt=changeDateformat(currentdate);
	if(obj.value!="")
	{
		if(Date.parse(pgdt) < Date.parse(currentdt))
		{
			alert("Date always be greater than or equal to " +currentdate);
			obj.value="";
			obj.focus();
			return false;
		}
		
	}
	return true;
}
function settype(cat_type)
{
	if(cat_type == "Retail")
	{
		document.forms[0].hidtype.value="P";
		document.forms[0].hidtype_text.value="P";
	}
	else if(cat_type == "Agri")
	{
		document.forms[0].hidtype.value="A";
		document.forms[0].hidtype_text.value="A";
	}
	else if(cat_type == "Corp")
	{
		document.forms[0].hidtype.value="C";
		document.forms[0].hidtype_text.value="C";
	}
	alert(document.forms[0].hidtype.value)
}	
</script>
</head>
<body onload="callonLoad();">
<form class="normal" method="post">


<table width="95%" border="1" cellspacing="0" cellpadding="3"
	class="outertable" align="center" style="margin-left: 20px; margin-right: 20px; margin-top: 5px;">
<tr>
<td>
<table class="outertable" width="100%"  border="0" cellspacing="0" cellpadding="3" align="center">

	<tr class="dataheader" style="text-align: center">
		<td style="text-align: center;width:100%;">PAN check</td><td></td>	
	</tr>
</table>	
<table class="outertable" width="100%"  border="0" cellspacing="0" cellpadding="3" align="center">	
	<tr>
						<td width="6%"><b>Sectors</b><span class="mantatory">*</span></td>
						<!-- <td width="8%" nowrap><input type="radio"
							name="choose_type" style="border-style: none"
							onClick="settype('Retail');">
						&nbsp;<b>Retail</b></td>
						<td width="10%" nowrap><input type="radio"
							name="choose_type" style="border-style: none"
							onClick="settype('Agri');">
						&nbsp;<b>Agriculture</b></td>						 
						<td width="68%" nowrap><input type="radio"
							name="choose_type" style="border-style: none"
							onClick="settype('Corp');">
						&nbsp;<b>Corporate</b> </td>
						<td width="86">&nbsp;</td>-->
				<td><select name="choose_type" onChange="">				
				<option value="R">Retail</option>
				<option value="A">Agriculture</option>
				<option value="C">Corporate</option>				
				</select></td>		
		</tr>	
		<tr>
		<td width="10%">Proposal Number <b><span class="mantatory">*</span></b></td>
		 <td width="15%"><input type="text" name="txt_proposalno" value="" readonly="true">
		  <span id="applsearch" onClick="searchProposal()"
													style="cursor:hand"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" ></span>
		</td>
		</tr>
		<tr>
			<td>Cust ID</td>
			 <td><input type="text" name="txt_custid"  value="" readonly="true">
			  <span id="idforcustomer"  onClick="javascript:callDescCBS()" style="cursor: hand" id="idsearch"><img
						src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
						border="0"></span></td>
			<td>Name<b><span class="mantatory">*</span></b></td>
			 <td><input type="text" name="txt_Name" value="" readonly="true"></td>
		</tr>
		<tr>
			<td>Proposal Creation Date</td>
			 <td><input type="text" name="txt_proposalcreatedt"  value=""  readonly="true"> </td>
		</tr>
		<tr>
		 <td>Effective Till Date<b></td>
			 <td><input type="text" name="txt_effectivetilldate"   value="" onBlur="allowalwysFutureDate(this,currentDate);">
			 <a href="#" onClick="callCalender1('txt_effectivetilldate')"
								onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a></td>
		</tr>
</table>

</td>
</tr>

<!-- Button Portion in table -->
<tr>
<td>
		<table width="12%" border="0" cellspacing="0" cellpadding="0"	align="center" class="outertable">
			<tr>
				<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />	
			</tr>
		</table>
		
</td>
</tr>
<table class="outertable linebor" width="100%" border="0" cellspacing="0" cellpadding="3">
	<tr align="center">
		<td class="tabactivenew" width="2%">&nbsp;</td>
		<td class="tabactivenew" width="10%"><b>Proposal No</b></td>
		<td class="tabactivenew" width="10%"><b>Module</b></td>
		<td class="tabactivenew" width="10%"><b>CBS Cust Id</b></td>
		<td class="tabactivenew" width="10%"><b>Name</b></td>
		<td class="tabactivenew" width="20%"><b>Effective From date</b></td>
		<td class="tabactivenew" width="20%"><b>Effective Till date</b></td>
	</tr>
	<%if (arrRow != null && arrRow.size() > 0) {
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);

					%>
	<tr bgcolor="#EAE4DB" valign="top">
		<td width="2%"><input type="radio" name="rdosec"
			onclick="placeValues('<%=Helper.correctNull((String)arrCol.get(0))%>',
			'<%=Helper.correctNull((String)arrCol.get(1))%>','<%=Helper.correctNull((String)arrCol.get(2))%>',
			'<%=Helper.correctNull((String)arrCol.get(3))%>',
			'<%=Helper.correctNull((String)arrCol.get(4))%>',
			'<%=Helper.correctNull((String)arrCol.get(5))%>')"
			style="border: none">
		</td>
		 <td width="10%%" align="center"><%=Helper.correctNull((String)arrCol.get(0))%></td>
		 <%if(Helper.correctNull((String)arrCol.get(1)).equalsIgnoreCase("P")){ %>
	     <td width="10%" align="center">Retail</td>
	     <%}else if(Helper.correctNull((String)arrCol.get(1)).equalsIgnoreCase("A")){ %>
	      <td width="10%" align="center">Agri</td>
	      <%}else if(Helper.correctNull((String)arrCol.get(1)).equalsIgnoreCase("C")) {%>
	       <td width="10%" align="center">Corporate</td>
	      <%}%>
                 
	     <td width="10%" align="center"><%=Helper.correctNull((String)arrCol.get(2))%></td>
         <td width="20%" align="center"><%=Helper.correctNull((String)arrCol.get(3))%></td>      
	     <td width="20%" align="center"><%=Helper.correctNull((String)arrCol.get(4))%></td>
	     <td width="20%" align="center"><%=Helper.correctNull((String)arrCol.get(5))%></td>
	</tr>
	<%}
			}

			%>
</table>
</table>
			
<lapschoice:hiddentag pageid="<%=PageId %>" /> 
<input type="hidden" name="hidUsername" value="<%=Helper.correctNull((String)session.getAttribute("strUserName"))%>"> 
<input type="hidden" name="hidOrgcode" value="<%=Helper.correctNull((String)session.getAttribute("strOrgCode"))%>">
<input type ="hidden" name="hidtype" value="">
<input type ="hidden" name="hidtype_text" value="">


</form>
</body>
</html>
