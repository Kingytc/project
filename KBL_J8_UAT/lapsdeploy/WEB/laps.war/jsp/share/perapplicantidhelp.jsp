<%@include file="../share/directives.jsp"%>
<%
	String strAppid=Helper.correctNull(request.getParameter("hidappid"));
	String strAppno=Helper.correctNull(request.getParameter("appno"));
	String strPageType=Helper.correctNull(request.getParameter("PageType"));
	String strhidCategoryType=Helper.correctNull((String)session.getAttribute("sessionModuleType"));
	if(strAppno.equalsIgnoreCase(""))
	{
		strAppno=Helper.correctNull((String)hshValues.get("appno"));
	}
	if(strAppid.trim().equals(""))
	{
		strAppid = Helper.correctNull((String)request.getParameter("appid"));
	}
	ArrayList arrRow= new ArrayList();
	
	if(hshValues!=null)
	{
		arrRow=(ArrayList)hshValues.get("arryRow");
	}
	int intRowSize = 0;
	if(arrRow != null && arrRow.size() > 0)
	{
		intRowSize = arrRow.size();
	}
	else
	{
		intRowSize = 0;
	}
	if(strAppid.trim().equals(""))
	{
		strAppid = Helper.correctNull((String)request.getParameter("appid"));
	}
	String strApptype=Helper.correctNull(request.getParameter("apptype"));
	String strCheckFlag=Helper.correctNull((String)hshValues.get("strCheckFlag"));
	String strGuarcount=Helper.correctNull((String)hshValues.get("guarcount"));
	String strProductType=Helper.correctNull((String)hshValues.get("strProductType"));
	String strmutualguar=Helper.correctNull((String)hshValues.get("mutualguar"));
	String strPageFrom=Helper.correctNull((String)request.getParameter("pageFrom"));
	String prd_cgtmse=Helper.correctNull((String)request.getParameter("prd_cgtmse"));
	%>
<html>
<head>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var varapptype="<%=strApptype%>";
var varGuarcount="<%=strGuarcount%>";
var varProductType="<%=strProductType%>";
var varmutualguar="<%=strmutualguar%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varPageFrom = "<%=strPageFrom%>";
var varprd_cgtmse="<%=prd_cgtmse%>";
var varpageID="<%=Helper.correctNull((String)request.getParameter("pageID"))%>";
function doSearch()
{
	var txtval=document.forms[0].bow_name.value;
	var txtlen=txtval.length;
	var rdovalue="";
	for(var i=0;i<document.forms[0].radiobutton.length;i++)
	{
		if(document.forms[0].radiobutton[i].checked==true)
		{
			rdovalue=document.forms[0].radiobutton[i].value;
		}
	}
	if(rdovalue==""||rdovalue==null)
	{
		alert("Please choose the Search Criteria");
		document.forms[0].bow_name.value="";
		return;
	}
    if(txtlen==0)
	{
		alert("Enter ID");
	    document.forms[0].bow_name.focus();
	    return;
	}
	document.forms[0].hidBeanGetMethod.value="getApplicantIDHelp";
	document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].action=appURL+"action/perapplicantidhelp.jsp?pageID=CoApp_Gua";
	document.forms[0].submit();
}
function getSelectedValue()
{
	var varValue=document.forms[0].appidhelp.value;
	if(varValue!="")
	{
		if(varstrworkflow=="PER")
		{
		var varArr= varValue.split("$");
		if(varArr[0].toUpperCase()!="NODATA")
		{
			if(varapptype.toUpperCase()=="A")
			{
				window.opener.document.forms[0].hidDemoId.value=varArr[0];
				window.opener.document.forms[0].txtloan_aname.value=varArr[1];
				if(varArr[1]!="")
				{
					window.opener.document.forms[0].cmdcheck.disabled=false;
				}
			}else if(varapptype.toUpperCase()=="C")
			{
				window.opener.document.forms[0].hidCoDemoId.value=varArr[0];
				window.opener.document.forms[0].txtloan_cname.value=varArr[1];
				if(varArr[1]!="")
				{
					window.opener.document.forms[0].cmdcheck.disabled=false;
				}
			}
			else
			{
				window.opener.document.forms[0].hidCoDemoId.value=varArr[0];
				window.opener.document.forms[0].txtloan_cname.value=varArr[1];
				if(varArr[1]!="")
				{
					window.opener.document.forms[0].cmdcheck.disabled=false;
				}
			}
		}	
		}
		else if(varstrworkflow=="COM")
		{
			var varArr= varValue.split("$");
			if(varArr[0].toUpperCase()!="NODATA")
			{
				window.opener.document.forms[0].cmdcheck.disabled=false;
				window.opener.document.forms[0].hidCoDemoId.value=varArr[0];
				window.opener.document.forms[0].hidAction.value="news";
				window.opener.document.forms[0].hidBeanId.value="compro";
				window.opener.document.forms[0].hidBeanMethod.value="updatePromoter";
				window.opener.document.forms[0].hidBeanGetMethod.value="getProData";
				window.opener.document.forms[0].action=appURL+"controllerservlet";
				window.opener.document.forms[0].hidSourceUrl.value="/action/compromoters.jsp";
				window.opener.document.forms[0].submit();
			}
		}
		window.close();
	}
	else
	{
		alert("select a particular description");
	}
}
function doOk()
{	
	/*if(varProductType=="pP" && varGuarcount>=2)
	{
		alert("Applicant is already attached as Guarantor for two Salaried loans");
		return;
	}
	if(varmutualguar=="Y" && window.opener.document.forms[0].seltype.value=="g")
	{
		alert("Mutual Guarantor policy is not allowed for salaried loan");
		return;
	}*/
	var varCheckFlag="<%=strCheckFlag%>";
	var varValue=document.forms[0].appidhelp.value;
	if(varCheckFlag=="Y")
	{
		alert("Applicant is already attached to this application");
		return;
	}
	if(varValue!="")
	{
		var varArr= varValue.split("$");
		if(varapptype=="promoter")
		{
			var varCoApp_check=varArr[19];
			if(varpageID=="CoApp_Gua"){
				if(varCoApp_check=="Y"){
				alert("Kindly click on modify in customer profile and update latest details before proceeding");
				return;
				}
			}
			/*if(varprd_cgtmse=="Y" && varArr[15]!="Y")
			{
				alert("Co-applicant/Guarantor/Coobligant cannot be attached if borrower has CGTMSE coverage");
				return;
			}*/
			var nriResident=varArr[18];
			var permcity=varArr[16];
			var permState=varArr[17];
			if(nriResident=="Y")
			{
				if(permcity=="" || permState=="")
				{
					alert("Please fill Communication Details Tab in Customer Profile");
	        		return;
				}
			}
			window.opener.document.forms[0].hidDemoId.value=varArr[0];
			window.opener.document.forms[0].fname.value=varArr[1];
			window.opener.document.forms[0].lname.value=varArr[2];
			window.opener.document.forms[0].dob.value=varArr[3];
			if(varArr[4]!="")
			{
				window.opener.document.forms[0].selemp.value=varArr[4];
			}
			else
			{
				window.opener.document.forms[0].selemp.value="S";
			}
			window.opener.document.forms[0].addr1.value=varArr[5];
			window.opener.document.forms[0].addr2.value=varArr[6]+", "+varArr[7];
			window.opener.document.forms[0].city.value=varArr[8];
			window.opener.document.forms[0].state.value=varArr[9];
			window.opener.document.forms[0].pin.value=varArr[10];
			window.opener.document.forms[0].phone.value=varArr[11];
			window.opener.document.forms[0].fax.value=varArr[12];
			window.opener.document.forms[0].email.value=varArr[13];
			window.opener.document.forms[0].hidOldId.value=varArr[14];
			window.opener.disablefields(false);
			window.opener.enableButtons(true,true,false,false,true,true);
			window.opener.document.forms[0].cho_promoter.disabled=true;
			window.opener.document.forms[0].fname.readOnly=true;
			window.close();
		}
		else if(varPageFrom=="SOC")
		{
			window.opener.document.forms[0].txt_newsecownerid.value=varArr[3];
			window.opener.document.forms[0].txt_newsecowner.value=varArr[1];
			window.opener.document.forms[0].txt_newsecownerCBSID.value=varArr[2];
			window.opener.document.forms[0].cmdchangeownershiprequest.disabled=false;
			window.close();
		}
		else
		{
			if(varArr[0].toUpperCase()!="NODATA")
			{
				var varCoApp_check=varArr[8];
				if(varpageID=="CoApp_Gua"){
					if(varCoApp_check=="Y"){
					alert("Kindly click on modify in customer profile and update latest details before proceeding");
					return;
					}
				}
				/*if(varprd_cgtmse=="Y" && varArr[4]!="Y")
				{
					alert("Co-applicant/Guarantor/Coobligant cannot be attached if borrower has CGTMSE coverage");
					return;
				}*/
				var nriResident=varArr[5];
				var permcity=varArr[6];
				var permState=varArr[7];
				if(nriResident=="Y")
				{
					if(permcity=="" || permState=="")
					{
						alert("Please fill Communication Details Tab in Customer Profile");
		        		return;
					}
				}
				if(varapptype.toUpperCase()=="A")
				{
					window.opener.document.forms[0].hidDemoId.value=varArr[0];
					window.opener.document.forms[0].txtloan_aname.value=varArr[1];
					if(varArr[1]!="")
					{
						window.opener.document.forms[0].cmdcheck.disabled=false;
					}				
				}else if(varapptype.toUpperCase()=="C")
				{
					
					window.opener.document.forms[0].hidCoDemoId.value=varArr[0];
					window.opener.document.forms[0].txtloan_cname.value=varArr[1];
					if(varArr[1]!="")
					{
						window.opener.document.forms[0].cmdcheck.disabled=false;
					}				
				}
				else
				{
					window.opener.document.forms[0].hidCoDemoId.value=varArr[0];
					window.opener.document.forms[0].txtloan_cname.value=varArr[1];
					if(varArr[1]!="")
					{
						window.opener.document.forms[0].cmdcheck.disabled=false;
					}				
				}
				
				window.close();
			}
		}
	}
	else
	{
		alert("select a particular description")
	}	
}
function onRadioClick()
{
	document.forms[0].bow_name.readOnly=false;			
	document.forms[0].bow_name.value="";
	document.forms[0].bow_name.focus();
}
function enableSearch(myform)
{
	if(window.event && window.event.keyCode==13)
		doSearch();
	else
		return true;
}
function doClose()
{
	<%if(!(strhidCategoryType.equalsIgnoreCase("RET")||strhidCategoryType.equalsIgnoreCase("LAD"))){%>
	if(varapptype=="promoter")
	{
	window.opener.document.forms[0].hidBeanId.value="compro";
	window.opener.document.forms[0].hidBeanGetMethod.value="getValues";
	window.opener.document.forms[0].action=appURL+"action/compromoters.jsp";
	window.opener.document.forms[0].submit();
	}
	window.close();
	<%}else{%>
	window.close();
	<%}%>
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="productlisthelp" method="post" class="normal">
<!-- <i><b>Joint-Applicant/Guarantor Search</b></i> -->
<br>
<table width="80%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
<tr> 
	<td>
		<table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="1">
		<tr>
          	<td>
          		<table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
				<tr class="datagrid">
					<td width="16%" nowrap="nowrap"> 
						<input type="radio" name="radiobutton" value="LAPSID" style="border-style:none" onClick="onRadioClick()">
						LAPS Applicant ID</td>
					<td width="16%" nowrap="nowrap"> 
						<input type="radio" name="radiobutton" value="CBSID" style="border-style:none" onClick="onRadioClick()">
						CBS Applicant ID</td>
					<td width="16%" nowrap="nowrap"> 
						<input type="radio" name="radiobutton" value="NAME" style="border-style:none" onClick="onRadioClick()">
						Name</td>
	                <td width="16%">
						<input type="text" name="bow_name" onKeypress="enableSearch(this.form)">
					</td>
					<td>&nbsp;&nbsp;&nbsp;
						<input type="button" name="Submit" value="Search" class="buttonStyle" onClick="doSearch();">
					</td>
				</tr>
				<tr class="dataheader">
					<td colspan="5">Select  Applicant (Applicant - Applicant ID)</td>
				</tr>
				<tr>
					<td colspan="5" align="center">
						<select name="appidhelp" size="20" onDblClick="doOk()" style="width:100%">
                 				<%if(strApptype.equalsIgnoreCase("noData")){%>
                					<option value="<%=strApptype %>"> Enter Values in Applicant Master </option>
                					<%}else if(strApptype.equalsIgnoreCase("promoter")){
                						if(arrRow!=null){
                						ArrayList arrCol=new ArrayList();
            							if(arrRow.size()>0){
            								for(int i=0;i<arrRow.size();i++){
            									arrCol=new ArrayList();
            									arrCol=(ArrayList)arrRow.get(i);%>
            				<option value="<%=Helper.correctDoubleQuotesScript(Helper.correctNull((String)arrCol.get(2)))+"$"+Helper.correctNull((String)arrCol.get(9))%>">
              				<%=Helper.correctNull((String)arrCol.get(3))+" - "+Helper.correctNull((String)arrCol.get(1))%></option>
						<%}}}}else{
			                  if(arrRow!=null){
                						ArrayList arrCol=new ArrayList();
            							if(arrRow.size()>0){
            								for(int i=0;i<arrRow.size();i++){
            									arrCol=new ArrayList();
            									arrCol=(ArrayList)arrRow.get(i);%>
							<option value="<%=Helper.correctNull((String)arrCol.get(0))+"$"+Helper.correctNull((String)arrCol.get(1))+"$"+Helper.correctNull((String)arrCol.get(3))+"$"+Helper.correctNull((String)arrCol.get(4))+"$"+Helper.correctNull((String)arrCol.get(5))+"$"+Helper.correctNull((String)arrCol.get(6))+"$"+Helper.correctNull((String)arrCol.get(7))+"$"+Helper.correctNull((String)arrCol.get(8))+"$"+Helper.correctNull((String)arrCol.get(9))%>">
              				<%=Helper.correctNull((String)arrCol.get(3))+" - "+Helper.correctNull((String)arrCol.get(1))%></option> 
						<%}}}}%>
						</select>
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
<lapschoice:combuttonnew btnnames='Ok' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidid">
<input type="hidden" name="apptype" value="<%=Helper.correctNull(request.getParameter("apptype"))%>">
<input type="hidden" name="appid" value="<%=Helper.correctNull(request.getParameter("appid"))%>">
<input type="hidden" name="strappno" value="<%=strAppno%>">
<input type="hidden" name="appno" value="<%=strAppno%>">
<input type="hidden" name="strfacno" value="<%=Helper.correctNull(request.getParameter("strFacno"))%>">
<input type="hidden" name="pageFrom" value="<%=Helper.correctNull(request.getParameter("pageFrom"))%>">
<input type="hidden" name="prd_cgtmse" value="<%=Helper.correctNull(request.getParameter("prd_cgtmse"))%>">
<input type="hidden" name="PageType" value="<%=strPageType%>">

</form>
</body>
</html>
