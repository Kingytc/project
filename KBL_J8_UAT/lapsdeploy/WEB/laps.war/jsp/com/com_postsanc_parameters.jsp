<%@include file="../share/directives.jsp"%>
<% 

ArrayList arrFacRow = new ArrayList();
ArrayList arrFacCol = new ArrayList();
int intarrsize=0;
String strStaffPrd="";
if(hshValues!=null);
	arrFacRow = (ArrayList) hshValues.get("arrFacRow");
	
	if(arrFacRow!=null && arrFacRow.size()>0)
		intarrsize=arrFacRow.size();


%>

<html>
<head>
<script src="<%=ApplicationParams.getAppUrl()%>js/com/comloanhistory.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<title>Post Sanction Parameters</title>
<STYLE>
DIV.cellContainer {	
  width: 100%; height: 200;
  overflow: auto;
}
.dhtmlgoodies_question{	/* Styling question */
	/* Start layout CSS */
	font-size:11px;;
	font-family:Trebuchet MS;
	background-color:#FFFFFF;
	/*width:1000px;*/
	margin-bottom:2px;
	/*background-image: url(laps/img/line.gif);*/
	margin-top:2px;
	padding-left:2px;
	
	background-repeat:repeat;
	
	height:25px;

	/* End layout CSS */

	overflow:hidden;
	cursor:pointer;
}
.dhtmlgoodies_answer{	/* Parent box of slide down content */
	/* Start layout CSS */
	border:1px solid ;
	background-color:#FFFFFF;
	/*background-image: url(laps/img/tab_back.png);*/
	/*width:1000px;*/
	/*background-repeat:repeat;*/
	font-family:Trebuchet MS;
	/* End layout CSS */
	visibility:hidden;
	height:100px;
	overflow:hidden;
	position:relative;

}
.dhtmlgoodies_answer_content{	/* Content that is slided down */
	padding:1px;
	font-size:0.9em;
	font-family:Trebuchet MS;
	position:relative;
}
</STYLE>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varId='';
var xmlHttp=null;
var varParameters="";
var varsize="<%=intarrsize%>";
var varCategoryType="<%=Helper.correctNull((String) request.getParameter("hidCategoryType"))%>";
var varFlag=true;
var varAppCnt="<%=Helper.correctNull((String)hshValues.get("strAppCount"))%>";
var varAllowedCnt="<%=Helper.correctNull((String)hshValues.get("strAppMaxCount"))%>";
function callNext()
{
	varFlag=callFacsnoSaveChk();
	if(varFlag==false)
	{
		//if(document.forms[0].hidParameters.value=="")
		{
			//alert("Please select atleast one Parameter");
			return;
		}
	}
	var varpara=document.forms[0].hidParameters.value;
	//if(document.forms[0].hidParameters.value=="")
	//{
		//alert("Please select atleast one Parameter");
		//return;
	//}
	if(varCategoryType=="RET")
	{
		document.forms[0].hidAction.value="updateparams";
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].action=appURL+"action/appworkflowhistory.jsp?ModuleType=RET";
		document.forms[0].hidBeanGetMethod.value="getHistory";		
		document.forms[0].submit();
	}
	else
	{
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].action=appURL+"action/postsancparameters.jsp";
		document.forms[0].hidBeanGetMethod.value="getFacilityData";		
		document.forms[0].submit();
	}
}
function callFacsnoChk(staff)
{
	var varParam="";
	var varParameters="";
	var boolflag=true;
	for(var i=0;i<varsize;i++)
	{
		boolflag=true;
		if(varsize==1)
		{
			
			var vararrsize=eval(document.forms[0].chkFac0.length);
			for(var j=0;j<vararrsize;j++)
			{
				
				var vartemp1="document.forms[0].chkFac0"+"["+j+"]";
				if(eval(vartemp1).checked)
				{
					if(document.forms[0].txtloantype.value!="pE" && varCategoryType=="RET" && (eval(vartemp1).value=="MOEX" || eval(vartemp1).value=="COEX"))
					{
						alert("Applicable only for Education Loan");
						eval(vartemp1).checked=false;
						return;
					}

					if(eval(vartemp1).value=="MOEX" && (parseInt(varAppCnt)== parseInt(varAllowedCnt)))
					{
						alert("Maximum spells of moratorium for unemployment/underemployment exceed.\n User can select any other post sanction parameter if required or click on close  button to delete the proposal");
						eval(vartemp1).checked=false;
						return;
					}
					
					//if((varCategoryType=="RET") && (eval(vartemp1).value!="SLILA"))
					{
						//alert("This Post Sanction Modification is Currently Not Available");
						//eval(vartemp1).checked=false;
						//return;
					}
					if(boolflag)
					{
						varParameters=varParameters+document.forms[0].hidSno.value+"^";
					}
					boolflag=false;
					varParam=eval(vartemp1).value;
					varParameters=varParameters+varParam+"@";
				}
			}

			if(varCategoryType=="RET")
			{
				if(document.forms[0].chkFac0[4].checked==true && document.forms[0].chkFac0[6].checked==false)
				{
					alert("Loan Amount changes will cause MIS Calculation also,\n Kindly select 'Change in MIS details including RBI industry codes' Parameter also");
					return false;
				}
			}
			else
			{
				if((document.forms[0].chkFac0[0].checked==true||document.forms[0].chkFac0[7].checked==true) && document.forms[0].chkFac0[3].checked==false)
				{
					alert("Loan Amount changes will cause MIS Calculation also,\n Kindly select 'Change in MIS details & Activity code details' Parameter also");
					return false;
				}
			}

			
		}
		else
		{
			var varTemp="document.forms[0].chkFac"+i;
		
			var vararrsize=eval(varTemp).length;
			for(var j=0;j<vararrsize;j++)
			{
				var vartemp1=varTemp+"["+j+"]";
				if(eval(vartemp1).checked)
				{
					if(boolflag)
					{
						varParameters=varParameters+document.forms[0].hidSno[i].value+"^";
					}
					boolflag=false;
					varParam=eval(vartemp1).value;
					varParameters=varParameters+varParam+"@";
				}
			}

			if((eval(varTemp+"[0]").checked==true||eval(varTemp+"[7]").checked==true) && eval(varTemp+"[3]").checked==false)
			{
				alert("Loan Amount changes will cause MIS Calculation also,\n Kindly select 'Change in MIS details & Activity code details' Parameter also");
				return false;
			}
		}
		if(varParameters!="")
		{
			varParameters=varParameters+"~";	
		}
	}
	document.forms[0].hidParameters.value=varParameters;

	if(varCategoryType == "RET")
	{
		if(staff == "Y")
		{
			if(document.forms[0].chkFac0[13].checked==true)
			{
				for(var j=0;j<vararrsize-1;j++)
				{
					if(j!=13)
					{
						document.forms[0].chkFac0[j].checked = false;
						document.forms[0].chkFac0[j].disabled = true;
					}
				}
			}
			else if(document.forms[0].chkFac0[13].checked==false)
			{
				for(var j=0;j<vararrsize-1;j++)
				{
					document.forms[0].chkFac0[j].disabled = false;
				}
			}
			for(var j=0;j<vararrsize-1;j++)
			{
				if(document.forms[0].chkFac0[j].checked==true && j!=13)
				{
					document.forms[0].chkFac0[13].checked = false;
					document.forms[0].chkFac0[13].disabled = true;
					break;
				}
				else
				{
					document.forms[0].chkFac0[13].disabled = false;
				}
			}

			if(document.forms[0].hidScheme.value=="N")
			{
				document.forms[0].chkFac0[16].disabled = true;
				document.forms[0].chkFac0[16].checked = false;
			}
			if(document.forms[0].hidDP.value=="N")
			{
				document.forms[0].chkFac0[15].disabled = true;
				document.forms[0].chkFac0[15].checked = false;
			}
		}
	}
}

function callFacsnoSaveChk()
{
	var varParam1="";
	var varParameters1="",varParameters2="";
	var boolflag1=true,bool2flag2=true;
	for(var i=0;i<varsize;i++)
	{
		boolflag1=true;
		if(varsize==1)
		{
			
			var vararrsize1=eval(document.forms[0].chkFac0.length);
			varParameters2="";
			for(var j=0;j<vararrsize1;j++)
			{
				
				var vartemp2="document.forms[0].chkFac0"+"["+j+"]";
				if(eval(vartemp2).checked)
				{
					if(boolflag1)
					{
						varParameters2=varParameters2+document.forms[0].hidSno.value+"^";
					}
					boolflag1=false;
					varParam1=eval(vartemp2).value;
					varParameters2=varParameters2+varParam1+"@";
				}
			}
			if(varParameters2!="")
			{
				varParameters2=varParameters2+"~";	
			}
			else
			{
				if(document.forms[0].hidSubFacchk.value=="Y")
				{
					alert("Please Select atleast one Parameter");
					return false;
				}
			}

			if(varCategoryType=="RET")
			{
				if(document.forms[0].chkFac0[4].checked==true && document.forms[0].chkFac0[6].checked==false)
				{
					alert("Loan Amount changes will cause MIS Calculation also,\n Kindly select 'Change in MIS details including RBI industry codes' Parameter also");
					return false;
				}
			}
			else
			{
				if((document.forms[0].chkFac0[0].checked==true||document.forms[0].chkFac0[7].checked==true) && document.forms[0].chkFac0[3].checked==false)
				{
					alert("Loan Amount changes will cause MIS Calculation also,\n Kindly select 'Change in MIS details & Activity code details' Parameter also");
					return false;
				}
			}
		}
		else
		{
			var varTemp="document.forms[0].chkFac"+i;
			varParameters1="";
			var vararrsize1=eval(varTemp).length;
			for(var j=0;j<vararrsize1;j++)
			{
				var vartemp2=varTemp+"["+j+"]";
				if(eval(vartemp2).checked)
				{
					if(boolflag1)
					{
						varParameters1=varParameters1+document.forms[0].hidSno[i].value+"^";
					}
					boolflag1=false;
					varParam1=eval(vartemp2).value;
					varParameters1=varParameters1+varParam1+"@";
				}
			}
			if((eval(varTemp+"[0]").checked==true||eval(varTemp+"[7]").checked==true) && eval(varTemp+"[3]").checked==false)
			{
				alert("Loan Amount changes will cause MIS Calculation also,\n Kindly select 'Change in MIS details & Activity code details' Parameter also");
				return false;
			}
			if(varParameters1!="")
			{
				varParameters2=varParameters2+varParameters1+"~";	
			}
			else
			{
				if(document.forms[0].hidSubFacchk[i].value=="Y")
				{
					alert("Please Select atleast one Parameter");
					return false;
				}
			}
		}
	}
	document.forms[0].hidParameters.value=varParameters2;
	return true;
}

function GetXmlHttpObject()
{
	
	try
	{
		xmlHttp=new XMLHttpRequest();
	}
	catch(e)	
	{
		try
		{
			xmlHttp= new ActiveXObject("Msxml12.XMLHTTP");
		}
		catch(e)
		{
			xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
	}
	
	return xmlHttp;
	
}
 var dhtmlgoodies_slideSpeed = 10;	// Higher value = faster
var dhtmlgoodies_timer = 10;	// Lower value = faster

var objectIdToSlideDown = false;
var dhtmlgoodies_activeId = false;
var dhtmlgoodies_slideInProgress = false;
var dhtmlgoodies_slideInProgress = false;
var dhtmlgoodies_expandMultiple = false; // true if you want to be able to have multiple items expanded at the same time.

function showHideContent(e,inputId)
{
	if(dhtmlgoodies_slideInProgress)return;
	dhtmlgoodies_slideInProgress = true;
	if(!inputId)inputId = this.id;
	inputId = inputId + '';
	var numericId = inputId.replace(/[^0-9]/g,'');
	var answerDiv = document.getElementById('dhtmlgoodies_a' + numericId);

	objectIdToSlideDown = false;

	if(!answerDiv.style.display || answerDiv.style.display=='none'){
		if(dhtmlgoodies_activeId &&  dhtmlgoodies_activeId!=numericId && !dhtmlgoodies_expandMultiple){
			objectIdToSlideDown = numericId;
			slideContent(dhtmlgoodies_activeId,(dhtmlgoodies_slideSpeed*-1));
		}else{

			answerDiv.style.display='block';
			answerDiv.style.visibility = 'visible';

			slideContent(numericId,dhtmlgoodies_slideSpeed);
		}
	}else{
		slideContent(numericId,(dhtmlgoodies_slideSpeed*-1));
		dhtmlgoodies_activeId = false;
	}
}

function slideContent(inputId,direction)
{

	var obj =document.getElementById('dhtmlgoodies_a' + inputId);
	var contentObj = document.getElementById('dhtmlgoodies_ac' + inputId);
	height = obj.clientHeight;
	if(height==0)height = obj.offsetHeight;
	height = height + direction;
	rerunFunction = true;
	if(height>contentObj.offsetHeight){
		height = contentObj.offsetHeight;
		rerunFunction = false;
	}
	if(height<=1){
		height = 1;
		rerunFunction = false;
	}

	obj.style.height = height + 'px';
	var topPos = height - contentObj.offsetHeight;
	if(topPos>0)topPos=0;
	contentObj.style.top = topPos + 'px';
	if(rerunFunction){
		setTimeout('slideContent(' + inputId + ',' + direction + ')',dhtmlgoodies_timer);
	}else{
		if(height<=1){
			obj.style.display='none';
			if(objectIdToSlideDown && objectIdToSlideDown!=inputId){
				document.getElementById('dhtmlgoodies_a' + objectIdToSlideDown).style.display='block';
				document.getElementById('dhtmlgoodies_a' + objectIdToSlideDown).style.visibility='visible';
				slideContent(objectIdToSlideDown,dhtmlgoodies_slideSpeed);
			}else{
				dhtmlgoodies_slideInProgress = false;
			}
		}else{
			dhtmlgoodies_activeId = inputId;
			dhtmlgoodies_slideInProgress = false;
		}
	}
}

function IntrateBRTOMCLR()
{
	if(varMCLRMigReq != "Y")
	{
		document.forms[0].chkFac[17].disabled=true;
	}
	else
	{
		document.forms[0].chkFac[15].disabled=true;
	}
}

function initShowHideDivs()
{
	 
		var divs = document.getElementsByTagName('DIV');
		var divCounter = 1;
		for(var no=0;no<divs.length;no++){
			if(divs[no].className=='dhtmlgoodies_question'){
				divs[no].onclick = showHideContent;
				divs[no].id = 'dhtmlgoodies_q'+divCounter;
				var answer = divs[no].nextSibling;
				while(answer && answer.tagName!='DIV'){
					answer = answer.nextSibling;
				}
				answer.id = 'dhtmlgoodies_a'+divCounter;
				contentDiv = answer.getElementsByTagName('DIV')[0];
				contentDiv.style.top = 0 - contentDiv.offsetHeight + 'px';
				contentDiv.className='dhtmlgoodies_answer_content';
				contentDiv.id = 'dhtmlgoodies_ac' + divCounter;
				answer.style.display='none';
				answer.style.height='1px';
				divCounter++;
			}
		}
	
}
function callclose()
{
	if(ConfirmMsg('197'))
	{
		if(varCategoryType == "RET")
		{
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanGetMethod.value="updateLoanProducts";
			document.forms[0].hidBeanId.value="perapplicant";
			document.forms[0].action=appURL+"action/retailpge.jsp";	
			document.forms[0].submit();
		}
		else
		{
			document.forms[0].hidAction.value ="deleteapplication";
			document.forms[0].hidBeanId.value="facilities";
			document.forms[0].hidSourceUrl.value="/action/corppge.jsp";
			document.forms[0].hidBeanMethod.value="updateCompanyData";
			document.forms[0].hidBeanGetMethod.value="getFacilityData";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();
		}
	}
}

function chkIntratemodify(param,obj)
{
	var TempVal = "document.forms[0].chkFac"+param;
	if(eval(TempVal+"[17]").checked && eval(TempVal+"[15]").checked)
	{
		alert("Combination of both Interest rate modification and Migration from Base rate/PLR to Other Reference Rate is not allowed for post sanction modification.");
		obj.checked=false;
	}
}

function chkIntratemodifyRet(param,obj)
{
	var TempVal = "document.forms[0].chkFac"+param;
	if(eval(TempVal+"[7]").checked && eval(TempVal+"[9]").checked)
	{
		alert("Combination of both Interest rate modification and Migration from Base rate/PLR to Other Reference Rate is not allowed for post sanction modification.");
		obj.checked=false;
	}
}
function chkduedate(param,obj)
{
	var TempVal = "document.forms[0].chkFac"+param;
	if(eval(TempVal+"[1]").checked && eval(TempVal+"[22]").checked)
	{
		alert("Both Due Date Extension and Short Review (Only for Working Capital Limits) post sanction parameters cannot be selected together.");
		obj.checked=false;
	}
}


function chkIntratemodifyPostSanction(param,obj)
{
	alert("inside");
	//var TempVal = "document.forms[0].chkFac"+param;
	var TempVal = "document.forms[0].chkFac"+param;
	if(eval(TempVal+"[15]").checked && (eval(TempVal+"[0]").checked||eval(TempVal+"[1]").checked|| eval(TempVal+"[2]").checked
			||eval(TempVal+"[3]").checked || eval(TempVal+"[4]").checked ||eval(TempVal+"[5]").checked || eval(TempVal+"[6]").checked
			|| eval(TempVal+"[9]").checked || eval(TempVal+"[8]").checked || eval(TempVal+"[10]").checked
			||eval(TempVal+"[11]").checked || eval(TempVal+"[12]").checked ||eval(TempVal+"[13]").checked || eval(TempVal+"[14]").checked
			||eval(TempVal+"[7]").checked || eval(TempVal+"[16]").checked || eval(TempVal+"[17]").checked || eval(TempVal+"[18]").checked
			||eval(TempVal+"[19]").checked ||eval(TempVal+"[20]").checked ||eval(TempVal+"[21]").checked ||eval(TempVal+"[22]").checked
			||eval(TempVal+"[23]").checked))
		//alert("obj===="+obj);
	{
		
		alert("Combination of both Interest rate modification and Others Parameters is not allowed for post sanction modification.");
		obj.checked=false;
	
}
}


</script>
</head>

<body text="#000000"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="javascript:initShowHideDivs()">
<form name="mails" method="post" class="normal">

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
        <tr>
          <td class="page_flow">
          <% if(Helper.correctNull((String) request.getParameter("hidCategoryType")).equalsIgnoreCase("CORP")){%>
            Home -&gt; Corporate & SME -&gt; Post sanction Parameter 
            <%}else if(Helper.correctNull((String) request.getParameter("hidCategoryType")).equalsIgnoreCase("AGR")){%>
            Home -&gt; Agriculture -&gt; Post sanction Parameter 
            <%}else{ %>
            Home -&gt; Retail -&gt; Post sanction Parameter 
            <%} %>
            </td>
        </tr>
      </table>		
      </td>
    </tr>
 </table>
 	<table valign="middle" width="100%" border="0" cellspacing="1" cellpadding="0"   class="outertable" >
 	<% if(!Helper.correctNull((String) request.getParameter("hidCategoryType")).equalsIgnoreCase("RET")){%>
				<tr class="dataheader">			
				<td width="10%" align="center">Proposal No..</td>
				<td width="10%" align="center">CBS Account No.</td>
				<td width="15%" align="center">Existing Proposal No.</td>
				<td width="20%" align="center">Facility Head</td>
				<td width="20%" align="center">Facility</td>
				<td width="15%" align="center">Limit</td>
				<td width="10%" align="center">Limit Type</td>
				</tr>
				<%}else{ %>
				<tr class="dataheader">			
				<td width="10%" align="center">Proposal No.</td>
				<td width="10%" align="center">CBS Account No.</td>
				<td width="15%" align="center">Existing Proposal No.</td>
				<td width="20%" align="center">Product Head Description</td>
				<td width="20%" align="center">Product Description</td>
				<td width="15%" align="center">Limit</td>
				</tr>
				<%} %>
	</table>
<table width="100%"  border="0" cellspacing="0" cellpadding="0" >
<tr> 
	<td valign="middle"> 
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
	<%if(arrFacRow!=null && arrFacRow.size()>0){ 
			for(int i=0;i<arrFacRow.size();i++){
					arrFacCol = (ArrayList) arrFacRow.get(i);	
					String strFacGroup=Helper.correctNull((String)arrFacCol.get(5));
					if(strFacGroup.equalsIgnoreCase("Sub Limit"))
						strFacGroup="disabled=disabled";
					else
						strFacGroup="";
					%>

		<tr>
			<td valign="middle"> 
		 	 <div class="dhtmlgoodies_question"> 
				<table valign="middle" width="100%" border="0" cellspacing="1" cellpadding="0"   class="outertable"  height="30">
					<tr class="datagrid">
						 
						<td width="10%" align="center" ><%=Helper.correctNull((String)arrFacCol.get(7))%></td>
						<td width="10%" align="center" ><%=Helper.correctNull((String)arrFacCol.get(0))%></td>
						<td width="15%" align="center"><%=Helper.correctNull((String)arrFacCol.get(1))%></td>
						<td width="20%" align="center"><%=Helper.correctNull((String)arrFacCol.get(2))%></td>
						<td width="20%" align="center"><%=Helper.correctNull((String)arrFacCol.get(3))%></td>
						<td width="15%" align="right"><%=Helper.correctNull((String)arrFacCol.get(4))%>
							<input type="hidden" name="txtloan_sancamt" value="<%=Helper.correctNull((String)arrFacCol.get(4))%>">
							<input type="hidden" name="txtloantype" value="<%=Helper.correctNull((String)arrFacCol.get(9))%>">
						</td>
						<% if(!Helper.correctNull((String) request.getParameter("hidCategoryType")).equalsIgnoreCase("RET")){%>
							<td width="10%" align="center"><%=Helper.correctNull((String)arrFacCol.get(5))%></td>
						<%}else {
							if(Helper.correctNull((String)arrFacCol.get(8)).equalsIgnoreCase("Y") && Helper.correctNull((String)arrFacCol.get(9)).equalsIgnoreCase("pH")){
							strStaffPrd = "Y";}}%>
					</tr>

				</table>

			</div>
			<% if(!Helper.correctNull((String) request.getParameter("hidCategoryType")).equalsIgnoreCase("RET")){ %>
			<div class="dhtmlgoodies_answer"> 
				<div>
					<table width="100%" border="0" cellspacing="1" cellpadding="1">
						<tr class="dataheader">
							<td colspan="8">POSTSANCTION PARAMETERS&nbsp;
							<input type="hidden"  name="hidSno" value="<%=Helper.correctNull((String)arrFacCol.get(6))%>">
							<input type="hidden"  name="hidSubFacchk" value="<%=Helper.correctNull((String)arrFacCol.get(8))%>">
							</td>
						</tr>
						<tr class="datagrid">
							<!-- <td align="center" width="3%" nowrap='nowrap'><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk()" value="COF"> </td>
							<td width="22%" colspan="3">Closure of facilities </td> -->
							
							<td align="center" width="3%" nowrap='nowrap'><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction('<%=i%>',this);" value="DLA"> </td>
							<td width="22%" colspan="3">Decrease of Limit amount</td>
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="chkduedate('<%=i%>',this);callFacsnoChk();chkIntratemodifyPostSanction('<%=i%>',this);" value="DATEEX"> </td>
							<td colspan='3'>
						Due Date Extension (Only for Working Capital Limits)</td>
							
						</tr>
							<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction('<%=i%>',this);" value="MRS"> </td>
							<td colspan='3'>
							Modifications to Repayment Schedule without restructuring (Non-EMI Schedule)</td>
						
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction('<%=i%>',this);" value="MIS"> </td>
							<td colspan='3'>
							Change in MIS details & Activity code details</td>
							
						</tr>
											
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction('<%=i%>',this);" value="CHDCCO"> </td>
							<td colspan='3'>
							Change in DCCO without restructuring</td>
							
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction('<%=i%>',this);" value="DCCO"> </td>
							<td colspan='3'>Capturing Actual Date of Commencement of commercial operation for the first time
							
							</td>
						</tr>
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction('<%=i%>',this);" value="LAD" <%=strFacGroup %>> </td>
							<td colspan='3'>
						Sanctioning LAD / Protested Bills as sub limits of LC/BG/Buyers' Credit</td>
						<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction('<%=i%>',this);" value="INLIM"> </td>
							<td colspan='3'>Increase in Limit of the sub limit
							
							</td>
						</tr>

						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction('<%=i%>',this);" value="SEC"> </td>
							<td colspan='3'>
						Addition/Substitution/Release of security</td>
						<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction('<%=i%>',this);" value="MODSEC" <%=strFacGroup %>> </td>
							<td colspan='3'>Modification of security type (Prime /Collateral) and margin value
							
							</td>
						</tr>
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction('<%=i%>',this);" value="SUBLIMIT" <%=strFacGroup %>> </td>
							<td colspan='3'>
						Sanction of sub-limit for the existing/already sanctioned main limit</td>
						<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction('<%=i%>',this);" value="CHBRANCH"> </td>
							<td colspan='3'>Change of facility availing branch
							
							</td>
						</tr>
						
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction('<%=i%>',this);" value="GUAR" <%=strFacGroup %>> </td>
							<td  colspan="3">Addition/Deletion of Guarantor</td>
							<td align="center" width="3%" nowrap='nowrap'><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction('<%=i%>',this);" value="DLP"> </td>
							<td width="22%" colspan="3"> Decrease of loan period</td>
						</tr>
							<%String strTemp="",strTemp1="";
							if(Helper.correctNull((String)arrFacCol.get(9)).equalsIgnoreCase("Y")){strTemp = "disabled";strTemp1="";}
							else {strTemp = "";strTemp1="disabled";}%>		
													
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction('<%=i%>',this);" value="MARGIN"> </td>
							<td colspan='3'>Modification to primary security margin (stock/book debts/cash margin and other margins)</td>
							<td align="center" width="3%" nowrap='nowrap'><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk();chkIntratemodify('<%=i%>',this);chkIntratemodifyPostSanction('<%=i%>',this);" value="MRI" > </td>
							<td width="22%" colspan="3">Modification in Rate of Interest</td>
						</tr>
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction('<%=i%>',this);chkIntratemodifyPostSanction('<%=i%>',this);" value="MISMOD"> </td>
							<td colspan='3'>Miscellaneous changes / Modifications</td>
							
							<td align="center"><input  type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk();chkIntratemodify('<%=i%>',this);chkIntratemodifyPostSanction('<%=i%>',this);" value="BRTOMCLR" > </td>
							<td colspan='3'>Migration from Base Rate/PLR to Other Reference Rate</td>
						</tr>
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction('<%=i%>',this);" value="MODGSS"> </td>
							<td colspan='3'>Modification in Govt. Sponser scheme</td>
							
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction('<%=i%>',this);" value="MODBA"> </td>
							<td colspan='3'>Modification in Banking Arrangement Type</td>
						</tr>
						<%
						if(Helper.correctNull((String)arrFacCol.get(10)).equalsIgnoreCase("Y")){strTemp = "disabled";}
						else {strTemp = "";} %>
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction('<%=i%>',this);" value="CHDPOWER" <%=strTemp %>> </td>
							<td  colspan="3">Modification in Drawing Power Indicator</td>
						<%
						if(Helper.correctNull((String)arrFacCol.get(11)).equalsIgnoreCase("N")){strTemp = "disabled";}
						else {strTemp = "";} %>	
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction('<%=i%>',this);" value="CHSCHEMECODE" <%=strTemp %>> </td>
							<td  colspan="3">Modifications in GL Sub head code and scheme code in CBS details </td>
						</tr>
						<tr class="datagrid">
						<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="chkduedate('<%=i%>',this);callFacsnoChk();chkIntratemodifyPostSanction('<%=i%>',this);" value="REODWC"> </td>
							<td colspan='3'>Short Review (Only for Working Capital Limits)</td>
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction('<%=i%>',this);" value="CGTMSE" <%=strTemp %>> </td>
							<td  colspan="3">Modification of CGTMSE</td>
						</tr>
							
					</table>
				
				</div>
             </div>
             <%}else{ %>
             <div class="dhtmlgoodies_answer"> 
				<div>
					<table width="100%" border="0" cellspacing="1" cellpadding="3">
						<tr class="dataheader">
							<td colspan="7">POSTSANCTION PARAMETERS&nbsp;</td>
							<td>&nbsp;<input type="hidden"  name="hidSno" value="<%=Helper.correctNull((String)arrFacCol.get(6))%>"><input type="hidden" name="hidSubFacchk" value="Y"></td>
						</tr>
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk('<%=strStaffPrd%>');chkIntratemodifyPostSanction('<%=i%>',this);" value="MRS"> </td>
							<td colspan='3'>
							Modifications to Repayment Schedule without restructuring</td>
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk('<%=strStaffPrd%>');chkIntratemodifyPostSanction('<%=i%>',this);" value="SEC"> </td>
							<td colspan='3'>
						Addition/Substitution/Release of security</td>
							
						</tr>
							<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk('<%=strStaffPrd%>');chkIntratemodifyPostSanction('<%=i%>',this);" value="MODSEC"> </td>
							<td colspan='3'>Modification of security type (Prime /Collateral) and value / Change of security owner
							
							</td>
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk('<%=strStaffPrd%>');chkIntratemodifyPostSanction('<%=i%>',this);" value="CHBRANCH"> </td>
							<td colspan='3'>Change of facility availing branch
							
							</td>
							</tr>
							<tr class="datagrid">
						<td align="center" width="3%" nowrap='nowrap'><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk('<%=strStaffPrd%>');chkIntratemodifyPostSanction('<%=i%>',this);" value="DLA"> </td>
							<td width="22%" colspan="3">Decrease of Limit amount</td>
							<td align="center" width="3%" nowrap='nowrap'><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk('<%=strStaffPrd%>');chkIntratemodifyPostSanction('<%=i%>',this);" value="DLP"> </td>
							<td width="22%" colspan="3"> Decrease of loan period</td>
							
						</tr>
						
						<%String strTemp="",strTemp1="";
							if(Helper.correctNull((String)arrFacCol.get(10)).equalsIgnoreCase("Y")){strTemp = "disabled";strTemp1="";}
							else {strTemp = "";strTemp1="disabled";}%>	
												
						<tr class="datagrid">
						<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk('<%=strStaffPrd%>');chkIntratemodifyPostSanction('<%=i%>',this);" value="MIS"> </td>
							<td colspan='3'>
							Change in MIS details including RBI industry codes</td>
						<td align="center" width="3%" nowrap='nowrap'><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk('<%=strStaffPrd%>');chkIntratemodifyRet('<%=i%>',this);chkIntratemodifyPostSanction('<%=i%>',this);" value="MRI"> </td>
						<td width="22%" colspan="3">Modification in Rate of Interest</td>
						</tr>
						
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk('<%=strStaffPrd%>');chkIntratemodifyPostSanction('<%=i%>',this);" value="GUAR"> </td>
							<td  colspan="3">Addition/Deletion of Guarantor</td>
							<td align="center"><input type="checkbox"  name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk('<%=strStaffPrd%>');chkIntratemodifyRet('<%=i%>',this);chkIntratemodifyPostSanction('<%=i%>',this);" value="BRTOMCLR" > </td>
							<td  colspan="3">Migration from Base Rate/PLR to Other Reference Rate</td>
						</tr>
						
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk('<%=strStaffPrd%>');chkIntratemodifyPostSanction('<%=i%>',this);" value="COEX"> </td>
							<td  colspan="3">Extension of Course period (Only for Education Loans)</td>
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk('<%=strStaffPrd%>');chkIntratemodifyPostSanction('<%=i%>',this);" value="MISMOD"> </td>
							<td  colspan="3">Miscellaneous changes / Modifications</td>
						</tr>
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk('<%=strStaffPrd%>');chkIntratemodifyPostSanction('<%=i%>',this);" value="MOEX"> </td>
							<td  colspan="7">Extension of Moratorium taking into account spells of unemployment/under-employment (Only for education loans) </td>
						</tr>
						
						<tr class="datagrid">
							<%if(strStaffPrd.equalsIgnoreCase("Y")){ %>
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk('<%=strStaffPrd%>');chkIntratemodifyPostSanction('<%=i%>',this);" value="SLILA"> </td>
							<td  colspan="3">Increase in Limit of Staff Housing Loan</td>
							<%}else{ %>
							<td colspan="4">&nbsp;</td>
							<%} %>
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk('<%=strStaffPrd%>');chkIntratemodifyPostSanction('<%=i%>',this);" value="MODGSS"> </td>
							<td colspan='3'>Modification in Govt. Sponser scheme</td>
							
						</tr>
						<tr class="datagrid">
						<%
						if(Helper.correctNull((String)arrFacCol.get(11)).equalsIgnoreCase("Y")){strTemp = "disabled";}
						else {strTemp = "";} %>
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk('<%=strStaffPrd%>');chkIntratemodifyPostSanction('<%=i%>',this);" value="CHDPOWER" <%=strTemp %>> </td>
							<td  colspan="3">Modification in Drawing Power Indicator<input type="hidden" name="hidDP" value="<%=Helper.correctNull((String)arrFacCol.get(11)) %>"></td>
						<%
						if(Helper.correctNull((String)arrFacCol.get(12)).equalsIgnoreCase("N")){strTemp = "disabled";}
						else {strTemp = "";} %>
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk('<%=strStaffPrd%>');chkIntratemodifyPostSanction('<%=i%>',this);" value="CHSCHEMECODE" <%=strTemp %>> </td>
							<td  colspan="3">Modifications in GL Sub head code and scheme code in CBS details <input type="hidden" name="hidScheme" value="<%=Helper.correctNull((String)arrFacCol.get(11)) %>"></td>
						</tr>
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac<%=i %>" style="border-style:none" onClick="callFacsnoChk('<%=strStaffPrd%>');chkIntratemodifyPostSanction('<%=i%>',this);" value="CGTMSE"> </td>
							<td  colspan="7">Modification of CGTMSE </td>
						</tr>
					</table>
				
				</div>
             </div>
             <%} %>
             </td>
            </tr>
      <% }} else { %>
	  		<tr class="datagrid">
				<td align="center">No Details Found</td>
			</tr>
      <%} %>
		</table>
	</td>
</tr>
<tr> 
         <td  align="center" height="32" colspan="3"> 
         <input type="button" name="cmdOK" value="OK" class="buttonStyle"  onClick="callNext()">
         <input type="button" name="cmdCancel" value="Close" class="buttonClose"  onClick="callclose()">	 
        </td>
   </tr>
</table>
<input type="hidden" name="appno" value="<%=Helper.correctNull((String)hshValues.get("strAppno")) %>">
<input type="hidden" name="comappid" value="<%=Helper.correctNull((String)hshValues.get("comapp_id")) %>">
<input type="hidden" name="appid" value="<%=Helper.correctNull((String)hshValues.get("hidapplicantid")) %>">
<input type="hidden" name="comapp_newid" value="<%=Helper.correctNull((String)request.getParameter("comapp_newid")) %>">
<input type="hidden" name="hidParameters">
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanGetMethod">
<input type="hidden" name="hidSourceUrl">
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidAction" value="postsanction">
<input type="hidden" name="hidCategoryType" value="<%=strCategoryType%>"> 
</form>
</body>
</html>
