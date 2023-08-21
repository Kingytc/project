<%@include file="../share/directives.jsp"%>
<%ArrayList vecRow=(ArrayList)hshValues.get("vecRow");
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
<script language="JavaScript">
<!--
var val = "<%=request.getParameter("val")%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
//-->
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var path ="<%=ApplicationParams.getAppUrl()%>";
var selindex;
var isnew="false";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
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
		document.forms[0].hidBeanGetMethod.value="getProcessData";
	//	document.forms[0].hidSourceUrl.value="/action/ops_processcharge.jsp";	
		document.forms[0].action=appURL+"action/ops_processcharge.jsp";
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
	if(checktrim(document.forms[0].prd_procrangefrom.value)=="")
	{
		ShowAlert('121','Range From');
		return false;
	}
	if(checktrim(document.forms[0].prd_procrangeto.value)=="")
	{
		ShowAlert('121','Range To');
		return false;
	}
	if(eval(document.forms[0].prd_procrangefrom.value) >=  eval(document.forms[0].prd_procrangeto.value))
	{
		alert("Range From cannot be greater than Range To");
		return false;
	}		
	if(parseFloat(document.forms[0].prd_procrangeto.value) <  parseFloat(document.forms[0].prd_procrangefrom.value))
	{
		alert("The From Range Should Be Less Than To Range For a Interest Range");
		return;
	}		
	if(checktrim(document.forms[0].prd_procfees.value)=="")
	{
		document.forms[0].prd_procfees.value ="0.00";
		document.forms[0].prd_procfees2.value ="0.00";
	}
	if(checktrim(document.forms[0].prd_procfees1.value)=="")
	{
		ShowAlert('121','Min Processing Fees ');
		return false;
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
	document.forms[0].hidId.value = document.forms[0].prdCode[document.forms[0].prdCode.selectedIndex].value;
	document.forms[0].hiddesc.value = "1";
	document.forms[0].action=path+"controllerservlet";
	document.forms[0].hidRecordflag.value=varRecordFlag;
	
	document.forms[0].hidBeanId.value="setinterest";
	document.forms[0].hidBeanMethod.value="updateProcessChargesData";
	document.forms[0].hidBeanGetMethod.value="getProcessData";
	document.forms[0].hidSourceUrl.value="/action/ops_processcharge.jsp";
	document.forms[0].submit();
}
function doCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidId.value = document.forms[0].prdCode[document.forms[0].prdCode.selectedIndex].value ;
		document.forms[0].hiddesc.value="";
		document.forms[0].action=path+"controllerservlet";
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanMethod.value="getProcessData";
		document.forms[0].hidSourceUrl.value="/action/ops_processcharge.jsp";
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
function showper()
{
	if(document.forms[0].prd_procfees.value >100)
   {
	   alert("Processing Fees should be with in 100 Percentage")
	   document.forms[0].prd_procfees.value=""; 
	   document.forms[0].prd_procfees.focus(); 
   } 
}
function callFunction(pagename)
{
	document.forms[0].action=appURL+"action/"+pagename;
	document.forms[0].submit();
}
</script>
</head>
<body onLoad="onloading()">	
 <form name="prdprocesscharge" method="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; Setup -&gt; Tertiary Products -&gt; Processing Charges</td>
    </tr>    
  </table> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                    <tr> 
                      <td> 
                        <table width="30%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                          <tr align="center"> 
                            <td class="sub_tab_active" id="prm"><b>Processing</b></td>
                            <td class="sub_tab_inactive" id="com2"><a href="JavaScript:callFunction('ops_proddocumentcharges.jsp')"> 
                              <b>Documentation</b></a></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    </table>
                    <br>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                          <tr> 
                            <td>
                              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                                <tr><td>
                                    <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
                                      <tr> 
                                        <td> 
                                          <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                                            <tr class="dataheader" align="center"> 
                                              <td colspan="6"><b>Charges</b></td>
                                            </tr>
                                            <tr> 
                                              <td width="25%">Select Processing Amount Range</td>
                                              <td width="4%">&nbsp; </td>
                                              <td width="20%"> 
                                               <select name="prdCode" onChange="showdata()">
                                                    <option value="" selected>-------Select-------</option>
													 <lapschoice:productcode /> 
                                                  </select>
                                               </td>
                                              <td width="19%">&nbsp; </td>
                                            </tr>
                                            <tr> 
                                              <td width="25%" >Amount Range From <b><span class="mantatory"><span class="mantatory">*&nbsp;</span>&nbsp;</span></b></td>
                                              <td width="4%"><b><%=ApplicationParams.getCurrency()%></b></td>
                                              <td width="20%" ><lapschoice:CurrencyTag name="prd_procrangefrom"  maxlength="14" value='<%=strrangefrom%>' tabindex="11" size="15"/> 
											  </td>
                                              <td width="19%">Amount Range To <b><span class="mantatory">*&nbsp;</span></b></td>
                                              <td width="3%"><b><%=ApplicationParams.getCurrency()%></b></td>
                                               <td width="29%"><lapschoice:CurrencyTag name="prd_procrangeto"  maxlength="14" value='<%=strrangeto%>' tabindex="12" size="15" /> 
											  </td>
                                            </tr>
                                            <tr> 
                                              <td width="25%" >Processing Fees (%) </td>
                                              <td width="4%">&nbsp;</td>
                                              <td width="20%" ><lapschoice:CurrencyTag name="prd_procfees"  maxlength="5" 
												 value='<%=strpercentcharge%>' tabindex="13" size="15" onBlur="showper()"/></td> 
                                              <td width="19%">Min Processing Fees / Flat Processing fee <b><span class="mantatory">*&nbsp;</span></b></td>
                                              <td width="3%"><b><%=ApplicationParams.getCurrency()%></b></td>
                                              <td width="29%"><lapschoice:CurrencyTag name="prd_procfees1"  maxlength="15" 
												 value='<%=strminactualcharge%>'
										 		tabindex="14" size="20" title="Min Processing Fees" onBlur="CheckMax(document.forms[0].prd_procfees2,this,'1')"/> 
											    </td>
                                            </tr>
                                            <tr> 
                                              <td width="25%" >Max Processing Fees </td>
                                              <td width="4%"><b><%=ApplicationParams.getCurrency()%></b></td>
                                              <td width="20%" ><lapschoice:CurrencyTag name="prd_procfees2"  maxlength="15" 
												 value='<%=strmaxactualcharge%>' tabindex="15" size="20" title="Max Processing Fees " onBlur="CheckMax(this,document.forms[0].prd_procfees1,'2')"/> 
												 </td>
                                              <td width="19%">&nbsp;</td>
                                              <td width="3%"></td>
                                              <td width="29%"> </td>
                                            </tr>
                                          </table>
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
      <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
      <br> 
      <lapschoice:hiddentag pageid='<%=PageId%>'/>
      <input type="hidden" name="hidSeldInsti" value="">
      <input type="hidden" name="prd_code" value="<%=Helper.correctNull(request.getParameter("prd_code"))%>">
      <input type="hidden" name="hidId" value="<%=Helper.correctNull((String)hshValues.get("hidId"))%>">
      <input type="hidden" name="hiddesc" value="">
      <input type="hidden" name="prdtype" value="<%=strprdtype%>">     
      <input type="hidden" name ="hidkeyid" >  
</form>
</body>
</html>
  





