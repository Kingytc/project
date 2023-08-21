<%@include file="../share/directives.jsp"%>
<%
ArrayList arrCol=new ArrayList();
ArrayList arrRow=new ArrayList();

if(hshValues!=null)
{
	arrRow=(ArrayList)hshValues.get("arrRow");
}
int arSize=0;
if(arrRow!=null && arrRow.size()>0)
{
	arSize=arrRow.size();
}
//out.println(hshValues);

String strChekFlag=Helper.correctNull((String)hshValues.get("strFlag"));
String strChekSendFlag=Helper.correctNull((String)hshValues.get("strSendFlag"));
String strFinalFlag="",strRatType="",strMisFlag="";
ArrayList arRatRow=new ArrayList();
ArrayList arRatCol=new ArrayList();
if(hshValues!=null)
{
	
	strFinalFlag=Helper.correctNull((String)hshValues.get("strFinalFlag"));
	strRatType=Helper.correctNull((String)hshValues.get("strRatType"));	
	strMisFlag=Helper.correctNull((String)hshValues.get("strDataFlag"));
	arRatRow=(ArrayList)hshValues.get("arRatRow");
	
}
String strFreezecoappguar=Helper.correctNull((String)hshValues.get("strPromoFreezeflag"));
String strFreezeSecurity=Helper.correctNull((String)hshValues.get("strSecFreezeflag"));
String strProductType=Helper.correctNull((String)session.getAttribute("strProductType"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>MIS Details</title>

</head>
<body onload="callOnLoad()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">
var varCheckFlag="<%=strChekFlag%>";
//alert(varCheckFlag);
var varSendFlag="<%=strChekSendFlag%>";
var varstrcre_rating="<%=Helper.correctNull((String)hshValues.get("strcre_rating"))%>";
var varstrcre_weight="<%=Helper.correctNull((String)hshValues.get("strcre_weight"))%>";
var varWebserviceErrorMessage="<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)hshValues.get("WebserviceErrorMessage")))%>";
var varFreezecoappguar="<%=strFreezecoappguar%>";
var varFreezeSecurity="<%=strFreezeSecurity%>";
//alert(varSendFlag);
var varProductType="<%=strProductType%>";
var varbtnenable="<%=Helper.correctNull((String)request.getParameter("btnenable"))%>";
var varProductType="<%=strProductType%>";
if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
var varUpdateROIFlag="<%=Helper.correctNull((String)hshValues.get("ROIUpdateFlag"))%>";
var varRMDUserFlag="<%=Helper.correctNull((String)hshValues.get("strRMDUserFlag"))%>";
var varRatingROIFlag="<%=Helper.correctInt((String)hshValues.get("strRatingROI"))%>";
var varAction="<%=Helper.correctNull((String)request.getParameter("hidAction"))%>";
</script>
<script>

function callOnLoad()
{

	disableFields(true);

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

	document.forms[0].roiupdate.disabled=true;
	  if(varCheckFlag=="Y")
	  {
		  if(varSendFlag=="Y")
		  {
		   document.forms[0].doundo.disabled=false;
		   disableCommandButtons(true, true, true, true, false);
		   if(varUpdateROIFlag=="Y" && eval(varRatingROIFlag)>0)
			{
				if(varAction=="send")
				{
					alert("Please Click Update ROI button");
				}
				
				document.forms[0].roiupdate.disabled=false;
			}
		   //document.all.idScore.innerHTML="<b>Score	:	"+varstrcre_rating+"&nbsp;&nbsp;&nbsp;Weight	:	"+varstrcre_weight+"</b>";
		  }
		  else
		  {
			 // document.all.idScore.innerHTML="&nbsp;";
			  document.forms[0].doundo.disabled=true;
			  disableCommandButtons(false, true, true, true, false);
		  }
		  
	  }
	  else
	  {
		  //document.all.idScore.innerHTML="&nbsp;";
		  document.forms[0].doundo.disabled=true;
	  }

	  if(varWebserviceErrorMessage!="")
	  {
		  alert(varWebserviceErrorMessage);
	  }

	  <%if(strMisFlag.equalsIgnoreCase("N")){%>
	    alert("Please Fill the MIS/CBS Details Page");
	    document.forms[0].hidBeanId.value="mis";	
		document.forms[0].hidBeanGetMethod.value="getMISDetails";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/misdetails.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();	

	<%}else{%>	
      
	<%}%>
	if(varbtnenable=="N")
	{
		disableCommandButtons(true, true, true, true, false);
		 document.forms[0].doundo.disabled=true;
		 document.forms[0].send.disabled=true;
		 document.forms[0].roiupdate.disabled=true;
	}


}

function disableFields(bool) {
	for ( var i = 0; i < document.forms[0].elements.length; i++) {
		if (document.forms[0].elements[i].type == "select-one") {
			document.forms[0].elements[i].disabled = bool;
		}
		if (document.forms[0].elements[i].type == "text") {
			document.forms[0].elements[i].readOnly = bool;
		}
	}

}

function doEdit() {
	<%if(arrRow!=null && arrRow.size()>0){
		String strName2="";
		for(int i=0;i<arrRow.size();i++)
		{
			int k=i+1;
			arrCol=(ArrayList)arrRow.get(i);
			strName2="txt_riskparam"+k;
			if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("C")){%>

			 document.forms[0].<%=strName2%>.readOnly=true;
			
			<%}else if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("E")){%>

			 document.forms[0].<%=strName2%>.readOnly=false;
		<%
			}else if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("S")){%>

			 document.forms[0].<%=strName2%>.disabled=false;
		<%
			}
		}
		
	}%>
	
	disableCommandButtons(true, false, false, false, true);
}

function disableCommandButtons(cmdedit, cmdsave, cmdcancel, cmddelete, cmdclose) {
	document.forms[0].cmdedit.disabled = cmdedit;
	document.forms[0].cmdsave.disabled = cmdsave;
	document.forms[0].cmdcancel.disabled = cmdcancel;
	document.forms[0].cmddelete.disabled = cmddelete;
	document.forms[0].cmdclose.disabled = cmdclose;
}

function doSave() {
	

	<%if(arrRow!=null && arrRow.size()>0){
		String strName2="";
		String strName3="";
		for(int i=0;i<arrRow.size();i++)
		{
			int k=i+1;
			arrCol=(ArrayList)arrRow.get(i);
			strName2="txt_riskparam"+k;
			strName3="ratingdesc"+k;%>
			 if(document.forms[0].<%=strName2%>.value=="")
			 {
               alert("Please enter "+document.all.<%=strName3%>.innerHTML);
              <%-- document.forms[0].<%=strName2%>.focus();--%>
               return false;
			 }			
			
	<%}}%>	
	disableFields(false);
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value = "insert";
	document.forms[0].hidBeanId.value = "perapplicant";
	document.forms[0].hidSourceUrl.value = "/action/perrating.jsp";
	document.forms[0].hidBeanGetMethod.value = "getRetailrating";
	document.forms[0].hidBeanMethod.value = "updateRetailRating";
	document.forms[0].action = appURL + "controllerservlet";
	document.forms[0].submit();
}
function doCancel() {
	if (ConfirmMsg('102')) {
		document.forms[0].hidBeanId.value = "perapplicant";
		document.forms[0].hidBeanGetMethod.value = "getRetailrating";
		document.forms[0].action = appURL + "action/perrating.jsp";
		document.forms[0].submit();
	}
}
function doDelete() {
	if (ConfirmMsg('101')) {
		document.forms[0].hidAction.value = "delete";
		document.forms[0].hidBeanId.value = "perapplicant";
		document.forms[0].hidSourceUrl.value = "/action/perrating.jsp";
		document.forms[0].hidBeanGetMethod.value = "getRetailrating";
		document.forms[0].hidBeanMethod.value = "updateRetailRating";
		document.forms[0].action = appURL + "controllerservlet";
		document.forms[0].submit();
	}
}
function doClose() {
	if (ConfirmMsg('100')) {
		window.close();
	}
}

function doSendApp()
{
	if(varProductType!="pU" && varFreezecoappguar=="N")
	  {
		 alert("Co-Applicant / Guarantor Freeze not yet done. Please Click on Freeze button in Loan Particulars  -> Co-Applicant / Guarantor tab");
		 return false;
	  }
	if(varFreezeSecurity=="N")
	  {
		 alert("Security Freeze not yet done.Please click on Freeze button in Security Master -> Attached Securities tab");
		 return false;
	  }
	disableFields(false);
	document.forms[0].send.disabled = true;
	document.forms[0].hidAction.value = "send";
	document.forms[0].hidBeanId.value = "perapplicant";
	document.forms[0].hidSourceUrl.value = "/action/perrating.jsp?sendButtonFlag=Y";
	document.forms[0].hidBeanGetMethod.value = "getRetailrating";
	document.forms[0].hidBeanMethod.value = "updateRetailRating";
	document.forms[0].action = appURL + "controllerservlet";
	document.forms[0].submit();
	
}

function doUndoApp()
{

	document.forms[0].hidAction.value = "undo";
	document.forms[0].hidBeanId.value = "perapplicant";
	document.forms[0].hidSourceUrl.value = "/action/perrating.jsp?sendButtonFlag=N";
	document.forms[0].hidBeanGetMethod.value = "getRetailrating";
	document.forms[0].hidBeanMethod.value = "updateRetailRating";
	document.forms[0].action = appURL + "controllerservlet";
	document.forms[0].submit();
	
}
function callAmnt(val)
{


 alert(val);
	
}
function doROIUpdate()
{
	document.forms[0].hidAction.value = "updateRoi";
	document.forms[0].hidBeanId.value = "perapplicant";
	document.forms[0].hidSourceUrl.value = "/action/perrating.jsp?strFromN=T";
	document.forms[0].hidBeanGetMethod.value = "getRetailrating";
	document.forms[0].hidBeanMethod.value = "updateRetailRating";
	document.forms[0].action = appURL + "controllerservlet";
	document.forms[0].submit();
}
</script>
</div></div>
<form name="misdet" method="post" class="normal">
<jsp:include page="../share/Applurllinkper.jsp" flush="true">
<jsp:param name="pageid" value="18" /></jsp:include>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Rating</td>
	</tr>
</table>
<lapschoice:application />

<br>
<table align="center" border="0" cellpadding="3" cellspacing="3" class="outertable" width="90%">

<tr>
	<td>
		<table align="center" border="1" cellpadding="2" cellspacing="0" class="outertable" width="90%">
		<tr class="dataheader"> 		
		  <td align="center" width="5%"><b>S.No</b></td>		
		  <td align="center" width="35%"><b>Description</b></td>
		  <td align="center" width="50%"><b>Value</b></td>		
		</tr>
		   <%if(arrRow!=null && arrRow.size()>0){
			   String strName="";
			   String strName2="";
			   String strName3="";
			   String strcode = "";
			   int j=0;
			   String stValue="",strCIBIL="",strExisting="";
			   for(int i=0;i<arrRow.size();i++)
			   {
				   arrCol=(ArrayList)arrRow.get(i);
				   int k=i+1;
				   strName="hid_riskparam"+k;
				   strName2="txt_riskparam"+k;
				   strName3="ratingdesc"+k;
				   j=Integer.parseInt(Helper.correctInt((String)arrCol.get(0)));
				   stValue="rskvalue"+j;
				   strcode = Helper.correctNull((String)arrCol.get(4));
				   
				   
				   String apptype="";
				   if(strcode.equalsIgnoreCase("RE80_Counterparty_with_Credit History"))
				   {
					   if(strChekFlag.equalsIgnoreCase("N"))
					   		strCIBIL = Helper.correctNull((String)arrCol.get(3));
					   else if(strChekFlag.equalsIgnoreCase("Y"))
						   strCIBIL = Helper.correctNull((String)hshValues.get(stValue));
				   }
				   if(strcode.equalsIgnoreCase("RE82_Existing _Loan_ Account_ with_ Bank"))
					   strExisting = Helper.correctNull((String)arrCol.get(3));
				  
				   if(strcode.equalsIgnoreCase("RE25_Occupation_Grps_Individual"))
					   apptype = "155";
				   if(strcode.equalsIgnoreCase("RE85_CREDIT_HISTORY_OF _BORROWER"))
					   apptype = "156";
				   if(strcode.equalsIgnoreCase("RE40_Edu_qualification"))
					   apptype = "157";
				   if(strcode.equalsIgnoreCase("RE65_Stability_of_Income") || strcode.equalsIgnoreCase("RE31_Stability_of_income_indiv"))
					   apptype = "158";
				   if(strcode.equalsIgnoreCase("RE04_Literacy_Level"))
					   apptype = "159";
				   if(strcode.equalsIgnoreCase("RE06_Conduct_on_previous/existing_loan_Acc") && strExisting.equalsIgnoreCase("1"))
					   apptype = "160";
				   if(strcode.equalsIgnoreCase("RE06_Conduct_on_previous/existing_loan_Acc") && strExisting.equalsIgnoreCase("0"))
					   apptype = "161";
				   if(strcode.equalsIgnoreCase("RE11_Subsidy/othr_concessions_frm_Govt_avail"))
					   apptype = "162";
				   if(strcode.equalsIgnoreCase("RE14_Support_Price_Availibility"))
					   apptype = "163";
				   if(strcode.equalsIgnoreCase("RE15_App_of_Advan_Tech"))
					   apptype = "164";
				   if(strcode.equalsIgnoreCase("RE16_Avail_of_Insurn"))
					   apptype = "165";
				   if(strcode.equalsIgnoreCase("RE17_Type_of_Crop"))
					   apptype = "166";
				   if(strcode.equalsIgnoreCase("RE18_Cropping_Pattern"))
					   apptype = "167";
				   if(strcode.equalsIgnoreCase("RE19_Avail_of_Irrigation_Water"))
					   apptype = "168";
				   if(strcode.equalsIgnoreCase("RE20_Location_of_Farm"))
					   apptype = "169";
				   if(strcode.equalsIgnoreCase("RE32_Revenue_Growth_Non-individual"))
					   apptype = "170";
				   if(strcode.equalsIgnoreCase("RE35_Track_Record_non-indiv"))
					   apptype = "171";
				   if(strcode.equalsIgnoreCase("RE38_Age_of_the_Vehicle_only_for_4_wheelers"))
					   apptype = "172";
				   if(strcode.equalsIgnoreCase("RE46_Course_applied_for"))
					   apptype = "173";
				   if(strcode.equalsIgnoreCase("RE51_College_Ranking_(India)"))
					   apptype = "174";
				   if(strcode.equalsIgnoreCase("RE52_College_Ranking_(Abroad)"))
					   apptype = "175";
				   if(strcode.equalsIgnoreCase("RE59_Locality_whr_Property_is_located"))
					   apptype = "176";
				   if(strcode.equalsIgnoreCase("RE62_Stage_of_Construction"))
					   apptype = "177";
				   if(strcode.equalsIgnoreCase("RE68_Infrastructure_Facilities"))
					   apptype = "178";
				   if(strcode.equalsIgnoreCase("RE69_Vintage"))
					   apptype = "179";
				   if(strcode.equalsIgnoreCase("RE_Collateral_guarantor_required"))
					   apptype = "182";

			   %>
		   
			<tr class="datagrid"> 		
		  <td align="center"><%=i+1%></td>		
		  <td align="left"><span id="<%=strName3%>"><%=Helper.correctNull((String)arrCol.get(1))%></span>
		  <input type="hidden" name="<%=strName%>" value="<%=Helper.correctNull((String)arrCol.get(0))%>"/>
		  </td>
          <%if(strChekFlag.equalsIgnoreCase("N")){
        	  if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("C")){
        	  %>	 
		  <td align="left"><input type="text" name="<%=strName2%>" value="<%=Helper.correctNull((String)arrCol.get(3))%>" size="50"  class="finaclefieldsbgcolor"/></td>	
		  <%}else if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("E")){%>
		  <td align="left"><input type="text" name="<%=strName2%>" readonly="readonly" value="<%=Helper.correctNull((String)arrCol.get(3))%>" size="50" onKeyPress="allowAlphaNumeric();"/></td>			  
		  <%}else if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("S")){%>
		  <td align="left"><select name="<%=strName2%>"><option value="">--Select--</option><lapschoice:StaticDataNewTag apptype='<%=apptype%>' /></select></td>
		  <script language="JavaScript">
		  	document.forms[0].<%=strName2%>.value = "<%=Helper.correctNull((String)arrCol.get(3))%>";
		  </script>			  
		   <%} } else if(strChekFlag.equalsIgnoreCase("Y")){
		       if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("C")){%>
		  <td align="left"><input type="text" name="<%=strName2%>" value="<%=Helper.correctNull((String)hshValues.get(stValue))%>" size="50"  class="finaclefieldsbgcolor"/></td>
		  <%}else if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("E")){ %>
		   <td align="left"><input type="text" name="<%=strName2%>" value="<%=Helper.correctNull((String)hshValues.get(stValue))%>" size="50" onKeyPress="allowAlphaNumeric();"/></td>
		    <%}else if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("S")){ %>
		  <td align="left"><select name="<%=strName2%>"><option value="">--Select--</option><lapschoice:StaticDataNewTag apptype='<%=apptype%>' /></select></td>
		  <script language="JavaScript">
		  	document.forms[0].<%=strName2%>.value = "<%=Helper.correctNull((String)hshValues.get(stValue))%>";
		  </script>
		  <%} }%>
		</tr>
		<%}} %>
		<%
		 if(arRatRow!=null)
		  {
			if(arRatRow.size()>0)
			{%>
			
		<tr class="dataheader">
		<td colspan="3"><b>List of the Ratings done by the Users</b></td>
		</tr>
			
			<%	int count=0;
				for(int b=0;b<arRatRow.size();b++)
				{
				 	arRatCol=(ArrayList)arRatRow.get(b);%>
		
		<tr class="datagrid">
		<td align="center"><%=++count%></td>
		<td align="left"><b>User ID:</b></td>
		<td align="left"><b><%=Helper.correctNull((String)arRatCol.get(2))%></b></td>
		</tr>
		<tr class="datagrid">
		<td>&nbsp;</td>
		<td align="left">&nbsp;&nbsp;<b>Score</b></td>
		<td align="left">&nbsp;&nbsp;<b><%=Helper.correctNull((String)arRatCol.get(0))%></b></td>
		</tr>
		<tr class="datagrid">
		<td>&nbsp;</td>
		<td align="left">&nbsp;&nbsp;<b>Weight</b></td>
		<td align="left">&nbsp;&nbsp;<b><%=Helper.correctNull((String)arRatCol.get(1))%></b></td>
		</tr>
		<tr class="datagrid">
		<td>&nbsp;</td>
		<td align="left">&nbsp;&nbsp;<b>Rating Done on</b></td>
		<td align="left">&nbsp;&nbsp;<b><%=Helper.correctNull((String)arRatCol.get(4))%></b></td>
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
		<%}} %>
		</table>
	</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>
  <table border="1" align="center">
  
   <tr>
   
    <td><input type="button" name="send" value="Send To Kalypto" class="buttonStyle" onclick="doSendApp()"></td>
    <td><input type="button" name="doundo" value="Undo" class="buttonStyle" onclick="doUndoApp()"></td>
   <td><input type="button" name="roiupdate" value="Update ROI" class="buttonStyle" onclick="doROIUpdate()"></td>
   </tr>
  
  </table>
<br>
<table width="100%">
  
   <tr>
   
   <td align="center"><span class="mantatory">For car loans - In case after creation of proposal, CIBIL score is modified in Customer profile, then loan product needs to be re-selected in Loan Particulars - Loan product tab. In case ROI is based on internal rating then click on "Update ROI" button in Rating Tab after receiving response from Kalypto, by each user</span></td>
      </tr>
  
  </table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidrowsize" value="<%=arSize%>">
<input type="hidden" name="hidModelCode" value="<%=Helper.correctNull((String)hshValues.get("strModelCode"))%>">
<input type="hidden" name="hidBusiId" value="<%=Helper.correctNull((String)hshValues.get("RSK_RULE_ID"))%>">
<input type="hidden" name="hdCheckFlag" value="<%=strChekFlag%>">
<input type="hidden" name="hidFinalFlag" value="<%=strFinalFlag%>">
<input type="hidden" name="hidstrRatType" value="<%=strRatType%>">
</form>
</body>
</html>