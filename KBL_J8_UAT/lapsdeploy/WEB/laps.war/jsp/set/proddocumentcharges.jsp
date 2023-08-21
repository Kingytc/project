<%@ include file="../share/directives.jsp"%>
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
String hidProductType=Helper.correctNull((String)request.getParameter("hidProductType"));
 %>
<html>
<head>
<title>Setup(Products - Interest)</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/prdInterest.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript">
<!--
var val = "<%=request.getParameter("val")%>";
//-->

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script>
var path      ="<%=ApplicationParams.getAppUrl()%>";
var appURL  ="<%=ApplicationParams.getAppUrl()%>";
var selindex;
var isnew="false";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
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
	document.forms[0].prd_procrangefrom.disabled=flag;
	document.forms[0].prd_procrangeto.disabled=flag;
	document.forms[0].prd_procfees.disabled=flag;
	document.forms[0].prd_procfees1.disabled=flag;
	document.forms[0].prd_procfees2.disabled=flag;
}

function processpageDisableButtons(cmdedit,cmdsave,cmdcancel,cmddelete,cmdclose)
{
	document.forms[0].cmdedit.disabled = cmdedit;
	document.forms[0].cmdsave.disabled = cmdsave;
	document.forms[0].cmdcancel.disabled = cmdcancel;
	document.forms[0].cmddelete.disabled = cmddelete;
	document.forms[0].cmdclose.disabled = cmdclose;
}

function onloading()
{
	for(i=0;i<document.forms[0].selectterm.length;i++)
	{	if(document.forms[0].hidId.value == document.forms[0].selectterm[i].value)
		{
			if(document.forms[0].hidId.value==0)
			{
				document.forms[0].selectterm.selectedIndex=0;
			}
			else
			{
			document.forms[0].selectterm.selectedIndex=i;
			}
		}
	}	
	selindex=document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
	if(selindex=='')
	{
		processpageDisableButtons(true,true,true,true,false);
	}
	else
	{
		if(document.forms[0].checkApp.value=="No")
		{
			processpageDisableButtons(false,true,true,true,false);			
		}
		else
		{
			processpageDisableButtons(true,true,true,true,false);
		}
	}
	processpageDisableField(true);
}

function getValue()
{
	document.forms[0].hidBeanGetMethod.value="getDocumentData";
	selindex=document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
	
			if(selindex=='')		
		{	
			processpageClearValues();
			processpageDisableField(true);
			processpageDisableButtons(true,true,true,true,false);
		}
		else if(selindex==0)
		{
			onNew();
		}
		else
		{
			if(document.forms[0].checkApp.value=="No")
			{	processpageDisableField(false);
			}
			document.forms[0].hidId.value = 
			document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value ;
			document.forms[0].hiddesc.value=selindex;
			document.forms[0].action=path+"controllerservlet";
			document.forms[0].hidBeanId.value="setinterest";
			document.forms[0].hidBeanMethod.value="getDocumentData";
			document.forms[0].hidSourceUrl.value="/action/proddocumentcharges.jsp";
			document.forms[0].submit();
		}
}

function onNew()
{	
	isnew="true";
	if(document.forms[0].checkApp.value=="No" || document.forms[0].checkApp.value=="null" || document.forms[0].checkApp.value=="")
	{
		processpageClearValues();
		processpageDisableField(false);
		processpageDisableButtons(true,false,false,true,true);
	}
	else
	{
		processpageDisableField(true);
		document.forms[0].selectterm.selectedIndex=0;
		ShowAlert(144);
	}	
}

function doEdit()
{
	processpageDisableField(false);
	processpageDisableButtons(true,false,false,false,true);
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
		
	if(parseFloat(document.forms[0].prd_procrangefrom.value) > parseFloat(document.forms[0].prdRangeTo.value) || parseFloat(document.forms[0].prd_procrangefrom.value) < parseFloat(document.forms[0].prdRangeFrom.value) )
		{
		alert("Amount Range Should Be Between Product Amount Range");
		return;
		}
	if(parseFloat(document.forms[0].prd_procrangeto.value) > parseFloat(document.forms[0].prdRangeTo.value) )
		{
		alert("Amount Range Should Be Between Product Amount Range");
		return;
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

		var maxvalue = parseFloat(document.forms[0].prd_procfees2.value);
		var minvalue = parseFloat(document.forms[0].prd_procfees1.value);
		if(maxvalue != '0.00' && minvalue!= '0.00'){
		if(minvalue >=  maxvalue){
			
			alert("Min Documentation Fees / Flat Documentation fee should be lesser than Max Documentation Fees");
			return;		
		}
		}
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidRecordflag.value=varRecordFlag;
		document.forms[0].hidId.value =
		document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
		document.forms[0].hiddesc.value = document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
		document.forms[0].action=path+"controllerservlet";
		
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanMethod.value="updateDocumentChargesData";
		document.forms[0].hidSourceUrl.value="/action/proddocumentcharges.jsp";
		document.forms[0].submit();

		
}

function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg('101')){
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidId.value =
		document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
		document.forms[0].hiddesc.value = document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
		document.forms[0].action=path+"controllerservlet";
	
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanMethod.value="updateDocumentChargesData";
		document.forms[0].hidSourceUrl.value="/action/proddocumentcharges.jsp";
		document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert(158);
	}
}

function doCancel()
{
	if(ConfirmMsg('102'))
	{		
		if(document.forms[0].checkApp.value=="No")
			{	processpageDisableField(false);
			}
			document.forms[0].hidId.value = 
			document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value ;
			document.forms[0].hiddesc.value="";
			document.forms[0].action=path+"controllerservlet";
			document.forms[0].hidBeanId.value="setinterest";
			document.forms[0].hidBeanMethod.value="getDocumentData";
			document.forms[0].hidSourceUrl.value="/action/proddocumentcharges.jsp";
			document.forms[0].submit();	
	}
}
function doClose()
{	
	if( ConfirmMsg(100) )
	{		
		document.forms[0].hidBeanGetMethod.value = "";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/setsearchproducts.jsp";
		document.forms[0].submit();
	}
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
function checkmax(){
	var maxvalue = parseFloat(document.forms[0].prd_procfees2.value);
	var minvalue = parseFloat(document.forms[0].prd_procfees1.value);
	if(minvalue >=  maxvalue){
		
		alert("Min Documentation Fees / Flat Documentation fee should be lesser than Max Documentation Fees");
		return;		
	}
}
</script>
</head>
<body onLoad="onloading()">
<form name="prdinterestfrm" method="post" action="<%=ApplicationParams.getAppUrl()%>controllerservlet" class="normal"> 
<lapstab:setproductstab tabid="6" prdtype='<%=hidProductType%>'/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; Setup -&gt; Retail &amp; Agriculture Products -&gt; Products -&gt; Charges -&gt; Documentation</td>
    </tr>   
  </table>
 <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3"  align="center" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                <tr> 
                  <td>
                    <table width="60%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                      <tr> 
                        <td width="34%" align="center" id="com2" class="sub_tab_inactive"><a href="JavaScript:callOtherTab('prodprocesscharges.jsp')" > 
                          <b>Processing</b></a></td>
                        <!-- <td width="25%" align="center" id="com2" class="sub_tab_active"><b>Documentation</b></td>-->
                        <%if(hidProductType.equalsIgnoreCase("pG")||hidProductType.equalsIgnoreCase("aH")){%>
                        <td width="33%" align="center" class="sub_tab_inactive"> 
                        <a href="JavaScript:callOtherTab('prodrentinsurcharges.jsp')" > 
                        Rent & Insurance</a></td>
                       	<td width="33%" align="center" class="sub_tab_inactive"> 
                        <a href="JavaScript:callOtherTab('prodjewelappraisalcharges.jsp')" > 
                        Jewel Appraisal</a></td>
                         <%} %>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                      <tr> 
                        <td> <fieldset> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                            <tr> 
                              <td> <lapschoice:products /> </td>
                            </tr>
                          </table>
                          </fieldset> <br>
                          <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
                            <tr> 
                              <td colspan="6"> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                                  <tr> 
                                    <td colspan="6"><b> 
                                      Charges</b></td>
                                  </tr>
                                  <tr>
                                    <td width="30%">Select 
                                      Charges </td></tr>
                                  <tr> 
                                    <td width="30%">Select 
                                      Documentation Amount Range </td>
                                    <td width="4%">&nbsp; </td>
                                    <td width="23%"> 
                                      <select name="selectterm" onChange="getValue()" >
                                        <lapschoice:documentchargetag/> 
                                      </select>
                                    </td>
                                    <td width="19%"></td>
                                    <td width="4%"></td>
                                    <td width="20%"></td>
                                  </tr>
                                  <tr> 
                                    <td width="30%" >Amount 
                                      Range From </td>
                                    <td width="4%">&nbsp;</td>
                                    <td width="23%"> 
                                       
                               	   <lapschoice:CurrencyTag name="prd_procrangefrom" size="16" maxlength="16" value='<%=strrangefrom%>' onBlur="roundtxt(this);"/> 
									 
									</td>
                                    <td width="19%">Amount 
                                      Range To </td>
                                    <td width="4%">&nbsp;</td>
                                    <td width="20%"> 
                                       
									  <lapschoice:CurrencyTag name="prd_procrangeto" size="16" maxlength="16" value='<%=strrangeto%>' onBlur="roundtxt(this);"/> 
									
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="30%" >Documentation 
                                      Fees (%) </td>
                                    <td width="4%">&nbsp;</td>
                                    <td width="23%" > 
                                      
									   <lapschoice:CurrencyTag name="prd_procfees"  onBlur="callper()"  
										 maxlength="5" size="8" value='<%=strpercentcharge%>' /> 
									  
									  </td>
                                    <td width="19%">&nbsp;</td>
                                    <td width="4%">&nbsp;</td>
                                    <td width="20%">&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td width="30%" >Min 
                                      Documentation Fees / Flat Documentation fee</td>
                                    <td width="4%"><b><%=ApplicationParams.getCurrency()%></b></td>
                                    <td width="23%" >
                                       
									    <lapschoice:CurrencyTag name="prd_procfees1" tabindex="4"
										 maxlength="15" size="20"  value='<%=strminactualcharge%>' onBlur ="checkmax();"/> 
									  
									</td>
                                    <td width="19%">Max 
                                      Documentation Fees</td>
                                    <td width="4%"><b><%=ApplicationParams.getCurrency()%></b></td>
                                    <td width="20%">
                                      
									  <lapschoice:CurrencyTag name="prd_procfees2"  tabindex="4"
										 maxlength="15" size="20" value='<%=strmaxactualcharge%>' onBlur ="checkmax();"/> 
									 
									  </td>
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
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <div align="center"><br>
    <lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
  </div>
	 <lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type="hidden" name="hidSeldInsti" value="">
  <input type="hidden" name="checkApp" value="<%=request.getParameter("checkApp")%>">
  <input type="hidden" name="hidId" value="<%=Helper.correctNull((String)hshValues.get("hidId"))%>">
  <input type="hidden" name="hiddesc" value="">
  <input type="hidden" name="prd_code" value="<%=Helper.correctNull((String)request.getParameter("prdCode")) %>"/>
  <input type="hidden" name="hidProductType" value="<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>">
</form>
</body>
</html>
  




