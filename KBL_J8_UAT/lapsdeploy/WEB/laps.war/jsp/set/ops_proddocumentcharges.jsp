<%@include file="../share/directives.jsp"%>
<%
ArrayList vecRow=(ArrayList)hshValues.get("vecRow");
ArrayList vecCol = null;
String strrangefrom ="";
String strrangeto =""; 
String strpercentcharge ="";
String strminactualcharge ="";
String strmaxactualcharge ="";
if(vecRow!=null && vecRow.size()>0)
 {	
	 vecCol =(ArrayList)vecRow.get(0);
		if(vecCol!=null)
		{
			strrangefrom	   =Helper.correctNull((String)vecCol.get(0));
			strrangeto		   =Helper.correctNull((String)vecCol.get(1));
			strpercentcharge   =Helper.correctNull((String)vecCol.get(2));
			strminactualcharge =Helper.correctNull((String)vecCol.get(3));
			strmaxactualcharge =Helper.correctNull((String)vecCol.get(4));			 
		}
 }
String strprdtype=Helper.correctNull((String)request.getParameter("prdtype"));%>
<html>
<head>
<title>Setup(Products - Interest)</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/prdInterest.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript">
var val = "<%=request.getParameter("val")%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script>
var path      ="<%=ApplicationParams.getAppUrl()%>";
var selindex;
var isnew="false";

function processpageClearValues()
{	
	document.forms[0].prd_procrangefrom.value="";
	document.forms[0].prd_procrangeto.value="";
	document.forms[0].prd_procfees.value="";
	document.forms[0].prd_procfees1.value="";
	document.forms[0].prd_procfees2.value="";
}

function processpageDisableField(flag)
{
	document.forms[0].prd_procrangefrom.readOnly=true;
	document.forms[0].prd_procrangeto.readOnly=true;
	document.forms[0].prd_procfees.readOnly=flag;
	document.forms[0].prd_procfees1.readOnly=flag;
	document.forms[0].prd_procfees2.readOnly=flag;
}

function processpageDisableButtons(cmdedit,cmdsave,cmdcancel,cmdclose)
{
	document.forms[0].cmdedit.disabled = cmdedit;
	document.forms[0].cmdsave.disabled = cmdsave;
	document.forms[0].cmdcancel.disabled = cmdcancel;
	document.forms[0].cmdclose.disabled = cmdclose;
}
function onloading()
{   
	if(document.forms[0].prd_procrangefrom.value != ''){
		document.forms[0].prdCode.value = "<%=Helper.correctNull(request.getParameter("prd_code"))%>";
	}else{
		document.forms[0].prdCode.value = '';	
	}
	
	selindex=document.forms[0].prdCode[document.forms[0].prdCode.selectedIndex].value;
	if(selindex=='')
	{
		processpageDisableButtons(true,true,true,false);
	}
	else
	{
		processpageDisableButtons(false,true,true,false);
	}
	processpageDisableField(true);
}

function showdata()
{
	if(document.forms[0].prdCode.value != "")
	{
		document.forms[0].prd_code.value = document.forms[0].prdCode.value;
		document.forms[0].hiddesc.value="1";
		document.forms[0].method="post";
		document.forms[0].hidBeanId.value="setinterest";		
		document.forms[0].hidBeanGetMethod.value="getDocumentData";
		document.forms[0].hidSourceUrl.value="/action/ops_proddocumentcharges.jsp";	
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}

function doEdit()
{
	processpageDisableField(false);
	processpageDisableButtons(true,false,false,true);
}

function doSave()
{	
	if(document.forms[0].prd_procrangefrom.value == "")
	{
		alert("Enter Range From");
		return false;			
	}
	if(document.forms[0].prd_procrangeto.value == "")
	{
		alert("Enter Range To");
		return false;			
	}
		
	if(parseFloat(document.forms[0].prd_procrangeto.value) <  parseFloat(document.forms[0].prd_procrangefrom.value))
	{
		alert("The From Range Should Be Less Than To Range For a Interest Range");
		return;
	}
				
	if(document.forms[0].prd_procfees.value == "")
	{
		document.forms[0].prd_procfees.value = "0.00";
	}
	
	if(document.forms[0].prd_procfees1.value == "")
	{
		document.forms[0].prd_procfees1.value = "0.00";
	}
	
	if(document.forms[0].prd_procfees2.value == "")
	{
		document.forms[0].prd_procfees2.value = "0.00";
	}
	
	if(isnew=="true")
	{
		document.forms[0].hidAction.value="insert";
	}
	else
	{
		document.forms[0].hidAction.value="update";
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidId.value =
	document.forms[0].prdCode[document.forms[0].prdCode.selectedIndex].value;
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hiddesc.value = "1";
	document.forms[0].action=path+"controllerservlet";	
	document.forms[0].hidBeanId.value="setinterest";
	document.forms[0].hidBeanMethod.value="updateDocumentChargesData";
	document.forms[0].hidSourceUrl.value="/action/ops_proddocumentcharges.jsp";
	document.forms[0].submit();
}

function doDelete()
{
	document.forms[0].hidAction.value="delete";
	document.forms[0].hidId.value =
	document.forms[0].prdCode[document.forms[0].prdCode.selectedIndex].value;
	document.forms[0].hiddesc.value = "1";
	document.forms[0].action=path+"controllerservlet";

	document.forms[0].hidBeanId.value="setinterest";
	document.forms[0].hidBeanMethod.value="updateDocumentChargesData";
	document.forms[0].hidSourceUrl.value="/action/ops_proddocumentcharges.jsp";
	document.forms[0].submit();
}

function doCancel()
{
	if(ConfirmMsg('102'))
	{
		if(document.forms[0].checkApp.value=="No")
		{	
			processpageDisableField(false);
		}
		document.forms[0].hidId.value = 
		document.forms[0].prdCode[document.forms[0].prdCode.selectedIndex].value ;
		document.forms[0].hiddesc.value="";
		document.forms[0].action=path+"controllerservlet";
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanMethod.value="getDocumentData";
		document.forms[0].hidSourceUrl.value="/action/ops_proddocumentcharges.jsp";
		document.forms[0].submit();	
	}
}

function doClose()
{	
	if( ConfirmMsg(100) )
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/setupnav.jsp";
		document.forms[0].submit();
	}
}
	
function callFunction(pagename)
{
	document.forms[0].action=appURL+"action/"+pagename;
	document.forms[0].submit();
}
function callper()
{ 
	if(document.forms[0].prd_procfees.value >100)
	{
		alert("Documentation Fees should be with in 100 Percentage")
		document.forms[0].prd_procfees.value=""; 
		document.forms[0].prd_procfees.focus(); 
	}
}
</script>
</head>
<body onLoad="onloading()">
<form name="prdinterestfrm" method="post" action="<%=ApplicationParams.getAppUrl()%>controllerservlet" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; Setup -&gt; Tertiary Products -&gt; Documentation Charges </td>
    </tr>   
  </table> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                <tr> 
                  <td> 
                    <table width="30%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                      <tr align="center"> 
                        <td id="com2" class="sub_tab_inactive"><a href="JavaScript:callFunction('ops_processcharge.jsp')"><b>Processing</b></a></td>
                        <td id="com2" class="sub_tab_active"><b>Documentation</b></td>
                      </tr>
                    </table>
                  </td>
                </tr>
                </table>
                <br> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
                            <tr> 
                              <td colspan="6"> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                                  <tr class="dataheader"> 
                                    <td colspan="6"><b>Charges</b></td>
                                  </tr><tr>
                                    <td width="30%"> Select Charges </td>
                                      </tr>
                                  <tr> 
                                    <td width="30%"> Select Documentation Amount Range </td>
                                    <td width="4%">&nbsp; </td>
                                    <td width="23%"> 
                                  <select name="prdCode" onChange="showdata()">
                                                    <option value="" selected>-------Select-------</option>
													 <lapschoice:productcode /> 
                                                  </select>
                                   </td>
                                    <td width="19%"></td>
                                    <td width="4%"></td>
                                    <td width="20%"></td>
                                  </tr>
                                  <tr> 
                                    <td width="30%" > Amount Range From </td>
                                    <td width="4%"> <b><%=ApplicationParams.getCurrency()%></b></td>
                                    <td width="23%"><lapschoice:CurrencyTag name="prd_procrangefrom" size="16" value='<%=strrangefrom%>'/> 
									</td>
                                    <td width="19%">Amount Range To </td>
                                    <td width="4%"><b><%=ApplicationParams.getCurrency()%></b></td>
                                    <td width="20%"><lapschoice:CurrencyTag name="prd_procrangeto" size="16"  value='<%=strrangeto%>' /> 
									</td>
                                  </tr>
                                  <tr> 
                                    <td width="30%" >Documentation Fees (%) </td>
                                    <td width="4%">&nbsp;</td>
                                    <td width="23%" ><lapschoice:CurrencyTag name="prd_procfees"  onBlur="callper()"  
										 maxlength="5" size="8" value='<%=strpercentcharge%>' />
									  </td>
                                    <td width="19%">&nbsp;</td>
                                    <td width="4%">&nbsp;</td>
                                    <td width="20%">&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td width="30%" >Min Documentation Fees / Flat Documentation fee </td>
                                    <td width="4%"><b><%=ApplicationParams.getCurrency()%></b></td>
                                    <td width="23%" ><lapschoice:CurrencyTag name="prd_procfees1" tabindex="4"
										 maxlength="15" size="20"  value='<%=strminactualcharge%>' title="Min Documentation Fees" onBlur="CheckMax(document.forms[0].prd_procfees2,this,'1')"/> 
									  </td>
                                    <td width="19%">Max Documentation Fees</td>
                                    <td width="4%"><b><%=ApplicationParams.getCurrency()%></b></td>
                                    <td width="20%"> 
                                     <lapschoice:CurrencyTag name="prd_procfees2"  tabindex="4"
										 maxlength="15" size="20" value='<%=strmaxactualcharge%>' title="Max Documentation Fees " onBlur="CheckMax(this,document.forms[0].prd_procfees1,'2')"/> 
									 </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table><br>
   <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
     <lapschoice:hiddentag pageid='<%=PageId%>'/> 
  <input type="hidden" name="hidSeldInsti" value="">
   <input type="hidden" name="prd_code" value="<%=Helper.correctNull(request.getParameter("prd_code"))%>">
  <input type="hidden" name="checkApp" value="<%=request.getParameter("checkApp")%>">
  <input type="hidden" name="hidId" value="<%=Helper.correctNull((String)hshValues.get("hidId"))%>">
  <input type="hidden" name="hiddesc" value="">
   <input type="hidden" name="prdtype" value="<%=strprdtype%>">
</form>
</body>
</html>
  