<%@include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<%String strCurModule="";
int  vecModSize = 0,arSize=0;
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
ArrayList arRatRow=new ArrayList();
ArrayList arRatCol=new ArrayList();
if(hshValues!=null)
{
	arrRow=(ArrayList)hshValues.get("arrRow");
	arRatRow=(ArrayList)hshValues.get("arRatRow");
}
ArrayList vecModule = (ArrayList) hshValues.get("tabdetails");
if (vecModule != null) {
	vecModSize = vecModule.size();
}
if(arrRow!=null && arrRow.size()>0)
{
	arSize=arrRow.size();
}
String tagFlag = "";
String strChekFlag=Helper.correctNull((String)hshValues.get("strFlag"));
String strfintype = Helper.correctNull((String)hshValues.get("fintype"));
String strCurrYear=Helper.correctNull((String)hshValues.get("strCurrYear"));
String strBussID=Helper.correctNull((String)hshValues.get("BusRuleID"));
String strChekSendFlag=Helper.correctNull((String)hshValues.get("strSendFlag"));
String strNonPoolEMptyRatingFlag=Helper.correctNull((String)hshValues.get("strNonPoolEMptyRatingFlag"));
String strFinStatus=Helper.correctNull((String)hshValues.get("fin_status"));
String strFinNo=Helper.correctNull((String)hshValues.get("strAppno"));
String strUsrId=(String) session.getAttribute("strUserId");
String StrAppHolder=Helper.correctNull((String)hshValues.get("fin_appholder"));
String strAppholdername=Helper.correctNull((String)hshValues.get("Appholdername"));
String strAppPendingFlag=Helper.correctNull((String)hshValues.get("strAppPendingFlag"));
String strAppno=Helper.correctNull((String)hshValues.get("strAppno"));
%>
<html>
<head>
<title>ONLY FOR RATING</title>
<script>
var cma="<%=strfintype%>";
var finaced_id="<%= Helper.correctNull((String)hshValues.get("finace_id"))%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varBussID="<%=strBussID%>";
var varCheckFlag="<%=strChekFlag%>";
var varSendFlag="<%=strChekSendFlag%>";
var varstrNonPoolEMptyRatingFlag="<%=strNonPoolEMptyRatingFlag%>";
var varFinno="<%=strFinNo %>";
var varAppholdername="<%=strAppholdername%>";
var varWebserviceErrorMessage="<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)hshValues.get("WebserviceErrorMessage")))%>";
var varAppPendingFlag="<%=strAppPendingFlag%>";
var varAppno="<%=strAppno%>";
var varCurrYear="<%=strCurrYear%>";
var varCurrFlag="<%=Helper.correctNull((String)hshValues.get("strCurrFlag"))%>";
var varPartyFileDet="<%=Helper.correctNull((String)hshValues.get("fin_partyfiledet"))%>";

function goBusineeData()
{
		document.forms[0].hidBeanId.value="financial";	
		document.forms[0].hidBeanGetMethod.value="getFinRating";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/FinancialOFRating.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	
}
function getSection(modid)
{	
	document.forms[0].hidcmasno.value=cma;
	document.forms[0].hidfinanceid.value=finaced_id;
    if(document.forms[0].cmdsave.disabled == false)
	{
		ShowAlert('103');
		return;
	}	
	document.forms[0].pageval.value = modid;
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action = appUrl+"action/com_FinancialTemp.jsp";
	document.forms[0].submit();
}
function doSave()
{
	if(document.forms[0].sel_corpbusinessid.value=="")
	{
      alert("Select Business Rule");
      document.forms[0].sel_corpbusinessid.focus();
      return false;
	}	
	if(document.forms[0].sel_curryear.value=="")
	{
      alert("Select Current year");
      document.forms[0].sel_curryear.focus();
      return false;
	}
	if(document.forms[0].sel_partyfiledet.value=="")
	{
      alert("Select Party File Presently at ");
      document.forms[0].sel_partyfiledet.focus();
      return false;
	}
	
	disableFields(false);

	<%if(arrRow!=null && arrRow.size()>0){
		String strName2="";
		for(int i=0;i<arrRow.size();i++)
		{
			int k=i+1;
			arrCol=(ArrayList)arrRow.get(i);
			strName2="txt_riskparam"+k;
			%>
			
			 if(document.forms[0].<%=strName2%>.value=="")
			 {
				 var varalert="<%=Helper.correctNull((String)arrCol.get(1))%>";
               alert("Please fill "+varalert);
               document.forms[0].<%=strName2%>.focus();
               return false;
			 }			
			
		<%
		}
		
	}%>	
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value = "insert";
	document.forms[0].hidnewapp.value = "";
	document.forms[0].sel_corpbusinessid.disabled=false;	
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanGetMethod.value="updateFinRating";
	document.forms[0].action=appUrl+"action/FinancialOFRating.jsp"; 
	document.forms[0].submit();
}
function doEdit()
{
	if(document.forms[0].sel_corpbusinessid.value=="")
	{
		alert("Please select the Business rule");
		return;
	}
	disableFields(false);
	document.forms[0].sel_corpbusinessid.disabled=true;
	disableCommandButtons(true,false,false,false,false);	
}
function callonLoad()
{
	//if(varAppPendingFlag=="Y")
	//{
		//alert("You can't create Proposal because Corporate Proposal Pending for this Applicant");
		//document.forms[0].hidcmasno.value=cma;
		//document.forms[0].hidfinanceid.value=finaced_id;
		//document.forms[0].hidBeanId.value="financial"
		//document.forms[0].hidBeanGetMethod.value="getFinancialType";
		//document.forms[0].hidBeanGetMethod.value="getData";
		//document.forms[0].action=appURL+"action/com_FinancialTemp.jsp";
		//document.forms[0].hidSourceUrl.value="/action/com_FinancialTemp.jsp";
		//document.forms[0].submit();
	//}
	if(varCurrFlag=="N" && document.forms[0].hidRatAppNo.value=="new")
	{
		alert("You are not allowed to Create New Proposal, \nPlease select KALYPTO Rating Year in Liabilities tab.");
		document.forms[0].hidBeanId.value="financial";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action = appUrl+"action/com_FinancialTemp.jsp";
		document.forms[0].submit();
		return;
	}
	
	if(varWebserviceErrorMessage!="")
	  {
		  alert(varWebserviceErrorMessage);
	  }
	if(varCheckFlag=="Y")
	{
		if(varSendFlag=="Y")
		{
		document.forms[0].send.disabled=true;
		disableCommandButtons(true, true, true, true, false);		
		}
		else
		{
			document.forms[0].send.disabled=false;
			disableCommandButtons(false, true, true, true, false);
		}
	}
	else
	{
		document.forms[0].send.disabled=true;
	}


	  if(varCheckFlag=="Y")
	  {
		  if(varSendFlag=="Y")
		  {
			  if(varstrNonPoolEMptyRatingFlag=="Y")
			  {
		        document.forms[0].doundo.disabled=true;
		        disableCommandButtons(true, true, true, true, false);
			  }
			  else
			  {
				    document.forms[0].doundo.disabled=false;
			        disableCommandButtons(true, true, true, true, false);
               
			  }
		   
		  }
		  else
		  {
			  if(varstrNonPoolEMptyRatingFlag=="Y")
			  {
				  document.forms[0].doundo.disabled=false;
			      disableCommandButtons(true, true, true, true, false);
			  }
			  else
			  {
				  document.forms[0].doundo.disabled=true;
				  disableCommandButtons(false, true, true, true, false);
               
			  }
		  }
		  
	  }
	  else
	  {
		document.forms[0].doundo.disabled=true;
	  }
	  if(varCheckFlag=="Y")
	  {
		  if(varSendFlag=="Y")
		  {
			  if(varstrNonPoolEMptyRatingFlag=="Y")
			  {
		
		       document.forms[0].docheck.disabled=false;
		       alert("Rating still not done");
			  }
			  else
			  {
				  document.forms[0].docheck.disabled=true;
			  }
		  }
		  else
		  {
			  document.forms[0].docheck.disabled=true;
		  }
	  }	
	else
	{
		document.forms[0].docheck.disabled=true;
		
	}
	if(varBussID!="")
	{
		document.forms[0].sel_corpbusinessid.value=varBussID;	
	}else{
		document.forms[0].sel_corpbusinessid.value="0";	
	}
	disableFields(true);
	document.forms[0].sel_corpbusinessid.disabled=false;
	<%if(arrRow!=null && arrRow.size()>0){
		String strName2="",stValue="";
		int j=0;
		for(int i=0;i<arrRow.size();i++)
		{
			int k=i+1;
			arrCol=(ArrayList)arrRow.get(i);
			strName2="txt_riskparam"+k;
			j=Integer.parseInt(Helper.correctInt((String)arrCol.get(0)));
			stValue="rskvalue"+j;
			if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("C")){
			if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("EXISTING-01") || Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("FOREXBOR-01")
					|| Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Type of Business") || Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("FACILITY-01") || Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("INDUSTRY-01"))
			{
			%>
			<%if(strChekFlag.equalsIgnoreCase("Y")){%>
			 document.forms[0].<%=strName2%>.value="<%=Helper.correctNull((String)hshValues.get(stValue))%>";
			 <%}else if(strChekFlag.equalsIgnoreCase("N")){%>
			 document.forms[0].<%=strName2%>.value="<%=Helper.correctNull((String)arrCol.get(3))%>";
			 <%}%>
			 document.forms[0].<%=strName2%>.disabled=true;
			 
			 <%}else{%>			 

			 document.forms[0].<%=strName2%>.readOnly=true;
			
			<%}}else if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("E")){%>

			 document.forms[0].<%=strName2%>.readOnly=false;
		<%
			}
		}
		
	}%>

	   <%if (strFinStatus.equalsIgnoreCase("PR")|| strFinStatus.equalsIgnoreCase("PA") || strFinStatus.equalsIgnoreCase("CA") || strFinStatus.equalsIgnoreCase("CR")) {%>
			 disableCommandButtons(true, true, true, true, false);
			 document.forms[0].send.disabled=true;
			 document.forms[0].doundo.disabled=true;
			 document.forms[0].docheck.disabled=true;
			 document.forms[0].sel_corpbusinessid.disabled=true;
			 alert("This Proposal is already Approved/Rejected, user cannot modify data in this proposal. Kindly create a New/Fresh Only for Rating Proposal");
        <%}else{%>
        <%if((!strUsrId.equalsIgnoreCase(StrAppHolder))&& !StrAppHolder.equalsIgnoreCase("")){%>
        alert("The Application is with "+(varAppholdername.toUpperCase())+", So you cannot modify data in this application");
        disableCommandButtons(true, true, true, true, false);
        document.forms[0].send.disabled=true;
		 document.forms[0].doundo.disabled=true;
		 document.forms[0].docheck.disabled=true;
		 document.forms[0].sel_corpbusinessid.disabled=true;
       <% }}%>

      if(varCurrYear!="")
 	  {
 		  document.forms[0].sel_curryear.value=varCurrYear;
 	  }
 	  else
 	  {
 		  document.forms[0].sel_curryear.value=""; 
 	  }
      if(varPartyFileDet!="")
 	  {
 		  document.forms[0].sel_partyfiledet.value=varPartyFileDet;
 	  }
 	  else
 	  {
 		  document.forms[0].sel_partyfiledet.value=""; 
 	  }


 	  if(document.forms[0].hidnewapp.value=="Y")
 	  {
 	 	  document.forms[0].cmdedit.disabled=true;
 	 	  document.forms[0].cmdsave.disabled=false;
 	 	  document.forms[0].cmdcancel.disabled=false;

 	 	for(var i=0;i<document.forms[0].length;i++)
 		  {
 			  if(document.forms[0].elements[i].type=='select-one' )
 			  {
 					document.forms[0].elements[i].disabled=false;
 			  }
 		  }
 	  }
	
}
function disableFields(val)
{
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  if(document.forms[0].elements[i].type=='text'  )
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
		  if(document.forms[0].elements[i].type=='select-one' )
		  {
				document.forms[0].elements[i].disabled=val;
		  }
	  }
}
function disableCommandButtons(bool,bool1,bool2,bool3,bool4)
{
	document.forms[0].cmdedit.disabled=bool;
	document.forms[0].cmddelete.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;
}
function doCancel()
{
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanGetMethod.value="getFinRating";
	document.forms[0].action=appUrl+"action/FinancialOFRating.jsp"; 
	document.forms[0].method="post";
	document.forms[0].submit();
}
function doDelete()
{
	document.forms[0].hidAction.value = "delete";
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].sel_corpbusinessid.disabled=false;	
	document.forms[0].hidBeanGetMethod.value="updateFinRating";
	document.forms[0].action=appUrl+"action/FinancialOFRating.jsp"; 
	document.forms[0].submit();	
}
function doClose()
{
 	if(ConfirmMsg(100))
 	{
		document.forms[0].action=appUrl+"action/financialsrch.jsp";
	 	document.forms[0].submit();
	}
}
function doSendApp()
{
	if(document.forms[0].sel_corpbusinessid.value=="")
	{
      alert("Select Business Rule");
      document.forms[0].sel_corpbusinessid.focus();
      return false;
	}	
	if(document.forms[0].sel_curryear.value=="")
	{
      alert("Select Current year");
      document.forms[0].sel_curryear.focus();
      return false;
	}
	disableFields(false);
	document.forms[0].hidAction.value = "send";
	document.forms[0].sel_corpbusinessid.disabled=false;	
	document.forms[0].hidSourceUrl.value="/action/FinancialOFRating.jsp"; 
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanMethod.value="updateOnlyforRating";
	document.forms[0].hidBeanGetMethod.value="getFinRating";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doUndoApp()
{
	disableFields(false);
	document.forms[0].hidAction.value = "undo";
	document.forms[0].hidSourceUrl.value="/action/FinancialOFRating.jsp"; 
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanMethod.value="updateOnlyforRating";
	document.forms[0].hidBeanGetMethod.value="getFinRating";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function doCheckResponse()
{
	disableFields(false);
	document.forms[0].hidAction.value = "check";
	document.forms[0].hidSourceUrl.value="/action/FinancialOFRating.jsp"; 
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanMethod.value="updateOnlyforRating";
	document.forms[0].hidBeanGetMethod.value="getFinRating";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function callFinancialWorkflow()
{
	if(varFinno=="new")
	{
		alert("Please Enter the this tab details to proceed further ");
	return;
	}
	document.forms[0].hidBeanId.value = "financial";
	document.forms[0].hidBeanGetMethod.value="getHistroy";
	document.forms[0].action=appUrl+"action/com_financialratingworkflow.jsp";
	document.forms[0].submit();
}
function doNewOnlyForRating()
{
	if(varCurrFlag=="N")
	{
		alert("You are not allowed to Create New Proposal, \nPlease select KALYPTO Rating Year in Liabilities tab.");
		document.forms[0].hidBeanId.value="financial";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action = appUrl+"action/com_FinancialTemp.jsp";
		document.forms[0].submit();
		return;
	}
	if(confirm("Do you want to create new Proposal?"))
	{
		document.forms[0].hidRatAppNo.value="new";
		document.forms[0].hidnewapp.value="Y";
		document.all.idappno.innerText="new";
		document.all.idstatus.innerText="";
		document.forms[0].cmdnewonlyforrating.disabled=true;
		document.forms[0].cmdsave.disabled=false;
		for(var i=0;i<document.forms[0].length;i++)
		  {
			  if(document.forms[0].elements[i].type=='select-one' )
			  {
					document.forms[0].elements[i].value="";
					document.forms[0].elements[i].disabled=false;
			  }
		  }
	}
}

function gototab(beanid, methodname, pagename,pagefrom) 
{
	 if(document.forms[0].cmdsave.disabled == false)
		{
			ShowAlert('103');
			return;
		}
	document.forms[0].hidBeanId.value = beanid;
	document.forms[0].hidBeanGetMethod.value = methodname;
	document.forms[0].action = appURL + "action/" + pagename+"?pageFrom="+pagefrom;
	document.forms[0].submit();
}
function getdigirating()
{ 
    
		document.forms[0].hidcmasno.value=cma;
		document.forms[0].hidfinanceid.value=finaced_id;
		document.forms[0].hidBeanId.value="financial";	
		document.forms[0].hidBeanGetMethod.value="getDigiRating";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/digiRatingFin.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
}
</script>
</head>
<body onload="callonLoad()">
<form name="misdet" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"class="outertable">
		<tr>
		<td class="page_flow">Home -&gt;Financial / Rating</td>
	</tr>
</table>
<lapschoice:finapptype  appid='<%=Helper.correctNull((String)hshValues.get("appidnew"))%>' financeid='<%=Helper.correctInt((String)hshValues.get("finace_id"))%>'/>
<table width="100%" cellspacing="0" cellpadding="0" class="outertable">				
					<tr>
						<td><%boolean pflag = false;
			boolean base_year = false;
			int strWidth;
			int tabWidth;
			strWidth = vecModSize;%>
						<table border="0" cellspacing="1" cellpadding="3" class="outertable">
							<tr>
								<%for (int i = 0; i < vecModSize; i++) {
				ArrayList vecVal = (ArrayList) vecModule.get(i);
					if(i==0)
					{
						tagFlag = Helper.correctNull((String)vecVal.get(0));
					}
				   String str1=Helper.correctNull((String)vecVal.get(0));					
				   String strClass;				  
     	 		 if(strWidth == 1)
					{
					tabWidth = 5;
					}
				else if(strWidth == 2)
				{
				tabWidth = 20;
				}
				else
				{
				   tabWidth=80/strWidth;
				}
				if(i==0 && strCurModule.trim().equals(""))
				{
					str1="";
				}
				   
				  strClass="sub_tab_inactive";
				   if (!Helper.correctNull((String) vecVal.get(0))
							.equals("Project Financial Input")) {
				  %> <td  align="center" class="<%=strClass%>">
				<a href="#" onclick="getSection('<%=Helper.correctNull((String)vecVal.get(0))%>')">
				<b><%=Helper.correctNull((String) vecVal.get(0))%></b></a>
								<%
					if (Helper.correctNull((String) hshValues.get("tabname"))
							.equalsIgnoreCase("Project Financial Input")
							|| Helper.correctNull(
									(String) hshValues.get("tabname"))
									.equalsIgnoreCase("INFRA STRUCTURE MODEL")
							|| Helper.correctNull(
									(String) hshValues.get("tabname"))
									.equalsIgnoreCase("OPERATIONS PHASE")) {
						/*if (Helper.correctNull(
								(String) hshValues.get("sel_divID"))
								.equalsIgnoreCase("0")) {
							pflag = true;
						}*/
					}
				}%>
				</td>
								<%}%>
							  	<td align="center" class="sub_tab_inactive" nowrap><b><a href="#" onclick="gototab('financial','getDataRatio','finratio.jsp','RA1&pagetype1=OFR')">FINANCIAL RATIOS</a></b></td>  
								<td align="center" class="sub_tab_active" nowrap><b>ONLY FOR RATING</b></td>
								<% if(Helper.correctNull((String)hshValues.get("digiflag")).equalsIgnoreCase("Y")){ %>
								<td align="center" class="sub_tab_inactive" nowrap><b><a href="#" onclick="getdigirating()">DIGI RATING</a></b></td>  
								<%} %>
								<td align="center" class="sub_tab_inactive" nowrap><b><a href="#" onclick="gototab('perDeviation','getpermDocumentDetails','perm_docAttachment.jsp')">Document Attachment</a></b></td>
								<td align="center" class="sub_tab_inactive"><a
									href="javascript:callFinancialWorkflow();"
									onMouseOut="window.status='';return true;"
									onMouseOver="window.status='Applicant';return true;"> <b>
							         FINANCIAL/RATING WORKFLOW </b></a></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
<table align="center" border="0" cellpadding="3" cellspacing="3" class="outertable" width="80%">
<tr>
	<td>
		<table align="center" border="0" cellpadding="2" cellspacing="0" class="outertable" width="90%">
				
				<tr><td colspan="3">&nbsp;</td></tr>			
				<tr>
				 <td nowrap="nowrap"  colspan="3">Select Business Rule&nbsp;<b><span class="mantatory">*</span></b>
				&nbsp;&nbsp;&nbsp;&nbsp;	<select name="sel_corpbusinessid" onchange="goBusineeData()">
				 	<option value="" selected>--Select--</option>
					<lapschoice:BusinessRuleTag apptype="1" page='app'/>		
				 </select>
				 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				 Select Current year&nbsp;<b><span class="mantatory">*</span></b>
				 &nbsp;&nbsp;<select name="sel_curryear">
				 <option value="" selected>--Select--</option>
					<laps:AgrFinancialYear appno='<%=Helper.correctInt((String)hshValues.get("finace_id"))%>' page="RO" />		
				 </select></td>
				</tr>
				<tr>
				<td>Party File Presently at&nbsp;<b><span class="mantatory">*</span></b>&nbsp;&nbsp;	
				<select name="sel_partyfiledet">
				 	<option value="" selected>--Select--</option>
					<lapschoice:StaticDataNewTag apptype="216"/>		
				 </select></td>
				</tr>
				<tr><td colspan="3">&nbsp;</td></tr>
		</table>
		<table align="center" border="0" cellpadding="2" cellspacing="0" class="outertable border1" width="90%">
		<tr class="dataheader"> 		
		  <td align="center" width="5%"><b>S.No</b></td>		
		  <td align="center" width="35%"><b>Description</b></td>
		  <td align="center" width="50%"><b>Value</b></td>		
		</tr>
		   <%if(arrRow!=null && arrRow.size()>0){
			   String strName="";
			   String strName2="";
			   String strName3="";
			   int j=0;
			   String stValue="",strCIBIL="",strExisting="";;
			   for(int i=0;i<arrRow.size();i++)
			   {
				   arrCol=(ArrayList)arrRow.get(i);
				   int k=i+1;
				   strName="hid_riskparam"+k;
				   strName2="txt_riskparam"+k;
				   strName3="ratingdesc"+k;
				   j=Integer.parseInt(Helper.correctInt((String)arrCol.get(0)));
				   stValue="rskvalue"+j;
				   
				   String apptype="";%>
		   
			<tr class="datagrid"> 		
		  <td align="center" width="10%"><%=i+1%></td>		
		  <td align="left" width="30%"><span id="<%=strName3%>"><%=Helper.correctNull((String)arrCol.get(1))%></span>
		  <input type="hidden" name="<%=strName%>" value="<%=Helper.correctNull((String)arrCol.get(0))%>"/>
		  </td>
          <%if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("EXISTING-01"))
        		  {
        	  %>
        	    <td align="center"><select name="<%=strName2%>"  style=" width:40%">
        	    <option value="">--Select--</option>
        	    <option value="1">Yes</option>
        	    <option value="0">No</option>
        	    </select></td>	
        	    <%}else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Nature of Current Ratio_LCM")){%>
        	     <td align="center"><select name="<%=strName2%>"  style=" width:40%">
        	    <option value="">--Select--</option>
        	    <option value="Forex">Forex</option>
        	    <option value="Other than Forex">Other than Forex</option>
        	    </select></td>
        	    <%}else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Type of Loan_LCM_V2.0")){%>
        	    <td align="center"><select name="<%=strName2%>"  style=" width:40%">
        	    <%String apptypecon="29"; %>
        	     <option value="">---Select-----</option>                
                   <lapschoice:CBSStaticDataNewTag apptype='<%=apptypecon%>' />
        	    </select></td>        	    
        	     <%}else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("INDUSTRY-01")){%>
        	     <td align="center"><select name="<%=strName2%>"  style=" width:40%">
        	     <%String apptypecon="30"; %>
        	    <option value="">---Select-----</option>                
                   <lapschoice:CBSStaticDataNewTag apptype='<%=apptypecon%>' />
        	    </select></td>
        	     <%}else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Type of Business")){%>
        	     <td align="center"><select name="<%=strName2%>"  style=" width:40%">
        	     <%String apptypecon="181"; %>
        	    <option value="">---Select-----</option>                
                   <lapschoice:StaticDataNewTag apptype='<%=apptypecon%>' />
        	    </select></td>
        	     <%}else{%>        	  	 
		   <td align="center"><input type="text" name="<%=strName2%>" value="<%=Helper.correctNull((String)arrCol.get(3))%>" size="50" class="finaclefieldsbgcolor"/></td>	
		  <%}if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Nature of Current Ratio_LCM")||Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("EXISTING-01")
				  ||Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Type of Loan_LCM_V2.0")||Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("INDUSTRY-01")
				  ||Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Type of Business")){%>
			  <script language="JavaScript">
			  	document.forms[0].<%=strName2%>.value = "<%=Helper.correctNull((String)hshValues.get(stValue))%>";
			  </script>
		  
		<%} }}%>
		</tr>
				
		<% if(arRatRow!=null)
		  {
			if(arRatRow.size()>0)
			{%>
			
			<tr class="dataheader">
			<td colspan="3"><b>List of the Ratings done by the Users</b></td>
			</tr>
				
				<%int count=0;
				for(int b=0;b<arRatRow.size();b++)
				{
				 arRatCol=(ArrayList)arRatRow.get(b);
		  		%>
		  		<tr class="datagrid">
		<td align="center"><%=++count%></td>
		<td align="left"><b>User ID</b></td>
		<td align="left"><b><%=Helper.correctNull((String)arRatCol.get(2))%></b></td>
		</tr>
		<tr class="datagrid">
		<td>&nbsp;</td>
		<td align="left">&nbsp;<b>Score</b></td>
		<td align="left">&nbsp;<b><%=Helper.correctNull((String)arRatCol.get(0))%></b></td>
		</tr>
		<tr class="datagrid">
		<td>&nbsp;</td>
		<td align="left">&nbsp;<b>Weight</b></td>
		<td align="left">&nbsp;<b><%=Helper.correctNull((String)arRatCol.get(1))%></b></td>
		</tr>
		<tr class="datagrid">
		<td>&nbsp;</td>
		<td align="left">&nbsp;<b>Rating Done on</b></td>
		<td align="left">&nbsp;<b><%=Helper.correctNull((String)arRatCol.get(4))%></b></td>
		</tr>
		<%if(Helper.correctNull((String)arRatCol.get(3)).equalsIgnoreCase("N")){%>
			<tr class="datagrid">
			<td>&nbsp;</td>
			<td align="left">&nbsp;<b><span  class="mantatory">Status</span></b></td>
			<td align="left">&nbsp;<b><span  class="mantatory">Rejected</span></b></td>
			</tr>
			<tr class="datagrid">
			<td>&nbsp;</td>
			<td align="left">&nbsp;<b><span  class="mantatory">Reason for Rejection</span></b></td>
			<td align="left">&nbsp;<b><span  class="mantatory"><%=Helper.correctNull((String)arRatCol.get(5))%></span></b></td>
			</tr>
		<%} %>
		<%}}else{ %>
		<tr class="dataheader">
		<td colspan="3">&nbsp;</td>
		</tr>
		<tr class="datagrid">
		<td colspan="3" align="center"><font color="red"><b>None of the Users rated this Proposal</b></font></td>
		</tr>
		<%} }%>		
		</table>
	</td>
</tr>
</table>
<br>
<%if(strFinStatus.equalsIgnoreCase("PR")||strFinStatus.equalsIgnoreCase("cR")) {%>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_New Only for Rating_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<%}else{ %>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<%} %>
<br>
  <table border="1" align="center">
   <tr>
   
    <td><input type="button" name="send" value="Send To Kalypto" class="buttonStyle" onclick="doSendApp()"></td>
    <td><input type="button" name="doundo" value="Undo" class="buttonStyle"  onclick="doUndoApp()"></td>
     <td><input type="button" name="docheck" value="Check for Response" class="buttonStyle" onclick="doCheckResponse()"></td>
      </tr>
  
  </table>
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<INPUT TYPE="hidden" NAME="hidfinanceid" value="<%=Helper.correctInt((String)hshValues.get("finace_id"))%>">
<INPUT TYPE="hidden" NAME="hidcmasno" value="<%=Helper.correctInt((String)hshValues.get("fintype"))%>">
<input type="hidden" name="hbusid">
<input type="hidden" name="hid_appid" value="<%=Helper.correctInt((String)hshValues.get("appidnew"))%>">
<input type="hidden" name="pageval">
<input type="hidden" name="hidrowsize" value="<%=arSize%>">
<input type="hidden" name="hidModelCode" value="<%=Helper.correctNull((String)hshValues.get("strModelCode"))%>">
<INPUT TYPE="hidden" NAME="hidfinid" value="<%=Helper.correctInt((String)hshValues.get("finace_id"))%>">
<input type="hidden" name="AssetandLiab" value="<%=Helper.correctNull((String)hshValues.get("AssetandLiab"))%>">
<input type="hidden" name="hidnewapp" value="<%=Helper.correctNull((String)request.getParameter("hidnewapp"))%>">
</form>
</body>
</html>