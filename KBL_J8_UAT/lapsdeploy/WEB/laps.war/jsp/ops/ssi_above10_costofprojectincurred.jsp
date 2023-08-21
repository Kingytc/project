<%@include file="../share/directives.jsp"%>
<%
ArrayList vecRow = new ArrayList();
ArrayList vecCol = new ArrayList();
String strgenid="";
int vecrowsize =0;
if(hshValues.size()>0 && hshValues != null)
{
	vecRow = (ArrayList)hshValues.get("vecRow");
	vecrowsize = vecRow.size();	
	if(vecrowsize>0)
	for(int i=0;i<14;i++)
	{	vecCol =(ArrayList)vecRow.get(i);
		strgenid=strgenid+Helper.correctNull((String)vecCol.get(0))+",";
	}
	if(!strgenid.equals(""))
	{
	strgenid=strgenid.substring(0,(strgenid.length())-1);	
	}
}
else
{
	strgenid ="0.00";
}
String strcat="";
if(!strCategoryType.equalsIgnoreCase(""))
{
	if(strCategoryType.equalsIgnoreCase("OPS"))
	{
		strcat="Tertiary";
	}
	else 
	{
		strcat="Corporate";
	}		
}%>
<html>
<head>
<title>Small Scale Industries</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript"src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var genid = "<%=strgenid%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function callDisable(one)
{
	for( i=1;i<=14;i++)		
	{
		document.forms[0].elements["txt_costofprojectincurred1"+i].readOnly=one;
		document.forms[0].elements["txt_costofprojectincurred2"+i].readOnly=one;
		document.forms[0].elements["txt_costofprojectincurred3"+i].readOnly=true;
	}
	
	document.forms[0].elements["txt_costofprojectincurred115"].readOnly=true;
	document.forms[0].elements["txt_costofprojectincurred215"].readOnly=true;
	document.forms[0].elements["txt_costofprojectincurred315"].readOnly=true;
		
	for(var i=0;i<document.forms[0].length;i++)
	  {		  
		  if(document.forms[0].elements[i].type=="textarea")
		  {
			  document.forms[0].elements[i].readOnly=one;			  
		  }
	  }			
}
function disableControls(bcmdEdit,bcmdApply,bcmdCancel,bcmddelete,bcmdClose)
{
	document.forms[0].cmdedit.disabled=bcmdEdit;
	document.forms[0].cmdsave.disabled=bcmdApply;
	document.forms[0].cmdcancel.disabled=bcmdCancel;
	document.forms[0].cmddelete.disabled=bcmddelete;
	document.forms[0].cmdclose.disabled=bcmdClose;
}
function onloading()
{	
	document.forms[0].hidGenID.value=genid;
	callDisable(true);
	document.forms[0].hidparam.value="LAND^BULIDING^INDIGENOUSPLANTMC^IMPORTEDPLANTMC^TOOLSSPARES^TESTEQUIPMENTS^MISCFIXEDASSETS^INSTALLATIONCHRG^PRELIMEXPEMSES^PREOPTEXPENSES^BUILDINGCONTINGENCIES^PLANTMACHCONTINGENCIES^FIXEDASSETSCONTINGENCIES^MARGINWCREQ";
	document.forms[0].hidTabName.value="getCostofProject";
	document.forms[0].hidMethod.value="getCostofProject";
}
function doEdit()
{
	callDisable(false);
	disableControls(true,false,false,false,true);
	document.forms[0].hideditflag.value="Y";
}
function doSave()
{	
	document.forms[0].hidBeanGetMethod.value="updateCostofProjectData";
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].action=appUrl+"action/ssi_above10_costofprojectincurred.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
function doDelete()
{
	document.forms[0].hidAction.value="Delete";
	if(!ConfirmMsg("101"))
    {
		return false;
	}
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].hidBeanMethod.value="updateCostofProjectData";
	document.forms[0].hidSourceUrl.value="/action/ssi_above10_costofprojectincurred.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doCancel()
{	
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidMethod.value="getCostofProject";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].action=appUrl+"action/ssi_above10_costofprojectincurred.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/agrpage.jsp";
		document.forms[0].submit();
	}
}
</script>
</head>
<body onload="onloading()">
<form name="fininc" method="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 		
      <td> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true">
        <jsp:param name="pageid" value="20" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
	    <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
    <tr> 
            <td class="page_flow">Home -&gt; <%=strcat%> -&gt; Application -&gt; Cost &amp; Means -&gt; Cost of Project</td>
          </tr>
	</table>
 <span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/>  
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="70%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr align="center"> 
            <td class="sub_tab_active"><b>Cost of Project </b></td>
            <td class="sub_tab_inactive"><b><a href="javascript:callFunction('ssi_above10_accrualsexpenditure.jsp','getGeneralDetails','InternalAccruals^FinanceOfExpenditureIncurred^PromotersPercentToTheProject','AccrualsExpenditure')">Accruals 
                </a></b>
            </td>
            <td class="sub_tab_inactive"><b><a href="javascript:callFunction('ssi_above10_meansoffinancing.jsp','getCostofProject','CAPITAL^RESERVES^TERMLOANS^UNSECUREDLOANS^DEFERREDPAYMENTS^SUBSIDYGOVT^SEEDCAPITAL^INTERNALCASHACCRUALS^OTHERSOURCES','MeansOfFinancing')"> 
                Means of Financing </a></b>
            </td>
            <td class="sub_tab_inactive"><b><a href="javascript:callFunction('Ssi_schdu.jsp','','','')"> 
                Schedule of Implementation </a></b>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
              	<tr> 
          	 <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr class="dataheader">              
		            <td width="50%" colspan="2"><b>INVESTMENT/ EXPANSION REQUIRED IN FIXED ASSETS FOR THE ANTICIPATED TURNOVER (to be filled in where term-loans are required)</b>
		            </td>		                  
                </tr>
                <tr class="datagrid">              
		            <td width="50%">Purpose for which the term loan is required
		            </td>
		            <td><textarea name="txt_PurposeForTL" cols="50" wrap="VIRTUAL" rows="5" onKeyPress="textlimit(document.forms[0].txt_PurposeForTL,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("PurposeForTL"))%></textarea></td>            
                </tr>
                <tr class="datagrid">              
		            <td width="50%">By whom were the estimates prepared ?
		            </td>
		            <td><textarea name="txt_EstimatePreparedBy" cols="50" wrap="VIRTUAL" rows="5" onKeyPress="textlimit(document.forms[0].txt_EstimatePreparedBy,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("EstimatePreparedBy"))%></textarea> </td>            
                </tr>
                <tr class="datagrid">              
		            <td width="50%">Has provision for possible escalation in prices been made in the estimates ?
		            </td>
		            <td><textarea name="txt_EscalationInEstimates" cols="50" wrap="VIRTUAL" rows="5" onKeyPress="textlimit(document.forms[0].txt_EscalationInEstimates,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("EscalationInEstimates"))%></textarea> </td>            
                </tr>                
              </table>
              </td> 
             </tr>    
                <tr> 
                  <td>                   
					<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
                      <%				
					if(hshValues.size()>0 && hshValues != null && vecrowsize >0)
					{				
							vecCol =(ArrayList)vecRow.get(0);%>
                      <tr > 
                        <td colspan="6"><b>Cost 
                          of Project (Please furnish estimates of cost of project 
                          under the following heads. Indicate the basis for arriving 
                          at the cost of project).</b><b>(<%=ApplicationParams.getCurrency()%>)</b> </td>
                      </tr>
                     
                      <tr class="dataheader"> 
                        <td align="center"  width="7%">S.No</td>
                        <td align="center"  width="40%" >Particulars</td>
                        <td  align="center" colspan="2">Already 
                          Incurred </td>
                        <td width="18%" align="center" >To 
                          be incurred</td>
                        <td width="17%" align="center" >Total 
                          cost </td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">1.</td>
                        <td width="40%">Land 
                          including development</td>
                        <td align="center" colspan="2"> 
						<lapschoice:CurrencyTag name="txt_costofprojectincurred11"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(2))%>' 
									     
										   size="15" />  
                          
                        </td>
                        <td width="18%" align="center"> 
						<lapschoice:CurrencyTag name="txt_costofprojectincurred21"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(3))%>' 
									     
										   size="15" />  
                          
                        </td>
                        <td width="17%" align="center">
						<lapschoice:CurrencyTag name="txt_costofprojectincurred31"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(4))%>' 
									     
										   size="15" />  
                         
                        </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(1);%>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">2.</td>
                        <td width="40%">Building 
                          &amp; Other Civil Works</td>
                        <td align="center" colspan="2"> 
                          
						  <lapschoice:CurrencyTag name="txt_costofprojectincurred12"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(2))%>' 
									     
										   size="15" />  
                        </td>
                        <td width="18%" align="center"> 
                          <lapschoice:CurrencyTag name="txt_costofprojectincurred22"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(3))%>' 
									     
										   size="15" />  
                        </td>
                        <td width="17%" align="center"><lapschoice:CurrencyTag name="txt_costofprojectincurred32"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(4))%>' 
									     
										   size="15" />   </td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">3.</td>
                        <td width="40%">Plant 
                          &amp; Machinery</td>
                        <td align="center" colspan="2" > </td>
                        <td width="18%" align="center"> </td>
                        <td width="17%" align="center"> </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(2);%>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">&nbsp;</td>
                        <td width="40%">a) 
                          Indigenous</td>
                        <td align="center" colspan="2"> 
                         <lapschoice:CurrencyTag name="txt_costofprojectincurred13"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(2))%>' 
									     
										   size="15" />  
						  
                        </td>
                        <td width="18%" align="center"> 
                          <lapschoice:CurrencyTag name="txt_costofprojectincurred23"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(3))%>' 
									     
										   size="15" />  
                        </td>
                        <td width="17%" align="center"> 
                          <lapschoice:CurrencyTag name="txt_costofprojectincurred33"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(4))%>' 
									     
										   size="15" />  
                        </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(3);%>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">&nbsp;</td>
                        <td width="40%">b) 
                          Imported</td>
                        <td align="center" colspan="2"> 
                          
						  <lapschoice:CurrencyTag name="txt_costofprojectincurred14"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(2))%>' 
									     
										   size="15" /> 
						  
                        </td>
                        <td width="18%" align="center"> 
                          <lapschoice:CurrencyTag name="txt_costofprojectincurred24"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(3))%>' 
									     
										   size="15" />  
                        </td>
                        <td width="17%" align="center">
						<lapschoice:CurrencyTag name="txt_costofprojectincurred34"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(4))%>' 
									     
										   size="15" />   </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(4);%>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">4.</td>
                        <td width="40%">Essential 
                          Tools, Spares &amp; Accessories</td>
                        <td align="center" colspan="2">
						<lapschoice:CurrencyTag name="txt_costofprojectincurred15"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(2))%>' 
									     
										   size="15" />  
                         
                        </td>
                        <td width="18%" align="center"><lapschoice:CurrencyTag name="txt_costofprojectincurred25"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(3))%>' 
									     
										   size="15" />   </td>
                        <td width="17%" align="center"><lapschoice:CurrencyTag name="txt_costofprojectincurred35"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(4))%>' 
									     
										   size="15" />   </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(5);%>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">5.</td>
                        <td width="40%">Testing 
                          Equipment </td>
                        <td align="center" colspan="2">
						<lapschoice:CurrencyTag name="txt_costofprojectincurred16"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(2))%>' 
									     
										   size="15" />  
                          
                        </td>
                        <td width="18%" align="center"> 
                          <lapschoice:CurrencyTag name="txt_costofprojectincurred26"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(3))%>' 
									     
										   size="15" />  
                        </td>
                        <td width="17%" align="center"> 
                          <lapschoice:CurrencyTag name="txt_costofprojectincurred36"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(4))%>' 
									     
										   size="15" />  
                        </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(6);%>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">6.</td>
                        <td width="40%">Miscellaneous 
                          Fixed Assets</td>
                        <td align="center" colspan="2">
						<lapschoice:CurrencyTag name="txt_costofprojectincurred17"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(2))%>' 
									     
										   size="15" />  </td>
                        <td width="18%" align="center"> 
                          <lapschoice:CurrencyTag name="txt_costofprojectincurred27"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(3))%>' 
									     
										   size="15" />  
                        </td>
                        <td width="17%" align="center">
						<lapschoice:CurrencyTag name="txt_costofprojectincurred37"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(4))%>' 
									     
										   size="15" />  </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(7);%>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">7.</td>
                        <td width="40%">Erection 
                          / Installation charges</td>
                        <td align="center" colspan="2"> 
						<lapschoice:CurrencyTag name="txt_costofprojectincurred18"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(2))%>' 
									     
										   size="15" />  
                          
                        </td>
                        <td width="18%" align="center"> 
                          <lapschoice:CurrencyTag name="txt_costofprojectincurred28"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(3))%>' 
									     
										   size="15" />  
                        </td>
                        <td width="17%" align="center">
						<lapschoice:CurrencyTag name="txt_costofprojectincurred38"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(4))%>' 
									     
										   size="15" />  
						 </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(8);%>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">8.</td>
                        <td width="40%">Preliminary 
                          Expenses</td>
                        <td align="center" colspan="2"> 
						<lapschoice:CurrencyTag name="txt_costofprojectincurred19"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(2))%>' 
									     
										   size="15" />  
                          
                        </td>
                        <td width="18%" align="center">
						<lapschoice:CurrencyTag name="txt_costofprojectincurred29"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(3))%>' 
									     
										   size="15" />   </td>
                        <td width="17%" align="center"><lapschoice:CurrencyTag name="txt_costofprojectincurred39"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(4))%>' 
									     
										   size="15" />   </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(9);%>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">9.</td>
                        <td width="40%">Pre-Operative 
                          Expenses </td>
                        <td align="center" colspan="2"> 
						<lapschoice:CurrencyTag name="txt_costofprojectincurred110"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(2))%>' 
									     
										   size="15" />  
                          
                        </td>
                        <td width="18%" align="center"> 
						<lapschoice:CurrencyTag name="txt_costofprojectincurred210"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(3))%>' 
									     
										   size="15" />
                          
                        </td>
                        <td width="17%" align="center"> 
                         <lapschoice:CurrencyTag name="txt_costofprojectincurred310"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(4))%>' 
									     
										   size="15" />  
                        </td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">10.</td>
                        <td width="40%">Provision 
                          for Contingencies</td>
                        <td align="center" colspan="2"> </td>
                        <td width="18%" align="center"> </td>
                        <td width="17%" align="center"> </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(10);%>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">&nbsp;</td>
                        <td width="40%">a) 
                          Building </td>
                        <td align="center" colspan="2"> 
						<lapschoice:CurrencyTag name="txt_costofprojectincurred111"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(2))%>' 
									     
										   size="15" />  
                         
                        </td>
                        <td width="18%" align="center">
						<lapschoice:CurrencyTag name="txt_costofprojectincurred211"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(3))%>' 
									     
										   size="15" /> 
                          
                        </td>
                        <td width="17%" align="center"> 
                          <lapschoice:CurrencyTag name="txt_costofprojectincurred311"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(4))%>' 
									     
										   size="15" />  
                        </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(11);%>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">&nbsp;</td>
                        <td width="40%">b) 
                          Plant &amp; Machinery</td>
                        <td align="center" colspan="2"> 
						<lapschoice:CurrencyTag name="txt_costofprojectincurred112"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(2))%>' 
									     
										   size="15" />  
                          
                        </td>
                        <td width="18%" align="center"> 
                         <lapschoice:CurrencyTag name="txt_costofprojectincurred212"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(3))%>' 
									     
										   size="15" /> 
                        </td>
                        <td width="17%" align="center">  
						<lapschoice:CurrencyTag name="txt_costofprojectincurred312"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(4))%>' 
									     
										   size="15" />   </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(12);%>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">&nbsp;</td>
                        <td width="40%">c) 
                          Other Fixed Assets</td>
                        <td align="center" colspan="2"> 
                          <lapschoice:CurrencyTag name="txt_costofprojectincurred113"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(2))%>' 
									     
										   size="15" />  
                        </td>
                        <td width="18%" align="center"> 
                          <lapschoice:CurrencyTag name="txt_costofprojectincurred213"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(3))%>' 
									     
										   size="15" /> 
                        </td>
                        <td width="17%" align="center"> 
                          <lapschoice:CurrencyTag name="txt_costofprojectincurred313"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(4))%>' 
									     
										   size="15" /> 
                        </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(13);%>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">11.</td>
                        <td width="40%">Margin 
                          for Working Capital Required</td>
                        <td align="center" colspan="2"> 
						<lapschoice:CurrencyTag name="txt_costofprojectincurred114"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(2))%>' 
									     
										   size="15" />  
                          
                        </td>
                        <td width="18%" align="center"> 
                          <lapschoice:CurrencyTag name="txt_costofprojectincurred214"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(3))%>' 
									     
										   size="15" /> 
                        </td>
                        <td width="17%" align="center">
						<lapschoice:CurrencyTag name="txt_costofprojectincurred314"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(4))%>' 
									     
										   size="15" />  </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(14);%>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">12.</td>
                        <td width="40%"><b>Total</b></td>
                        <td align="center" colspan="2"> 
						<lapschoice:CurrencyTag name="txt_costofprojectincurred115"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(2))%>' 
									     
										   size="15" />  
                          
                        </td>
                        <td width="18%" align="center"> 
                          <lapschoice:CurrencyTag name="txt_costofprojectincurred215"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(3))%>' 
									     
										   size="15" /> 
                        </td>
                        <td width="17%" align="center"><lapschoice:CurrencyTag name="txt_costofprojectincurred315"  maxlength="12" value='<%=Helper.correctNull((String)vecCol.get(4))%>' 
									     
										   size="15" />  </td>
                      </tr>
                      <%
					  }
					  else
					  {
					  %>
                      <tr > 
                        <td colspan="5"><b>Cost 
                          of Project (Please furnish estimates of cost of project 
                          under the following heads. Indicate the basis for arriving 
                          at the cost of project).</b> </td>                     
                      </tr>
                      <tr class="dataheader"> 
                        <td align="center"  width="7%" >S.No</td>
                        <td align="center"  width="40%" >Particulars</td>
                        <td  align="center" colspan="2" >Already 
                          Incurred </td>
                        <td width="18%" align="center"  >To 
                          be incurred</td>
                        <td width="17%" align="center"  >Total 
                          cost </td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">1.</td>
                        <td width="40%">Land 
                          including development</td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="txt_costofprojectincurred11" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="18%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred21" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="17%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred31" size="15" onKeyPress="allowDecimals(this)"  onBlur="" readOnly="readonly" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">2.</td>
                        <td width="40%">Building 
                          &amp; Other Civil Works</td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="txt_costofprojectincurred12" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="18%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred22" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="17%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred32" size="15" onKeyPress="allowDecimals(this)"  onBlur="" readOnly="readonly" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">3.</td>
                        <td width="40%">Plant 
                          &amp; Machinery</td>
                        <td align="center" colspan="2"> </td>
                        <td width="18%" align="center"> </td>
                        <td width="17%" align="center"> </td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">&nbsp;</td>
                        <td width="40%">a) 
                          Indigenous</td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="txt_costofprojectincurred13" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="18%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred23" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="17%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred33" size="15" onKeyPress="allowDecimals(this)"  onBlur="" readOnly="readonly"  maxlength="8" style="text-align:right" value="0.00">
                        </td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">&nbsp;</td>
                        <td width="40%">b) 
                          Imported</td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="txt_costofprojectincurred14" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="18%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred24" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="17%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred34" size="15" onKeyPress="allowDecimals(this)"  onBlur="" readOnly="readonly"  maxlength="8" style="text-align:right" value="0.00">
                        </td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">4.</td>
                        <td width="40%">Essential 
                          Tools, Spares &amp; Accessories</td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="txt_costofprojectincurred15" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="18%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred25" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="17%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred35" size="15" onKeyPress="allowDecimals(this)"  onBlur="" readOnly="readonly"  maxlength="8" style="text-align:right" value="0.00">
                        </td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">5.</td>
                        <td width="40%">Testing 
                          Equipment </td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="txt_costofprojectincurred16" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="18%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred26" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="17%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred36" size="15" onKeyPress="allowDecimals(this)"  onBlur="" readOnly="readonly"  maxlength="8" style="text-align:right" value="0.00">
                        </td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">6.</td>
                        <td width="40%">Miscellaneous 
                          Fixed Assets</td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="txt_costofprojectincurred17" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="18%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred27" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="17%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred37" size="15" onKeyPress="allowDecimals(this)" onBlur="" readOnly="readonly"  maxlength="8" style="text-align:right" value="0.00">
                        </td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">7.</td>
                        <td width="40%">Erection 
                          / Installation charges</td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="txt_costofprojectincurred18" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="18%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred28" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="17%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred38" size="15" onKeyPress="allowDecimals(this)"  onBlur="" readOnly="readonly"  maxlength="8" style="text-align:right" value="0.00">
                        </td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">8.</td>
                        <td width="40%">Preliminary 
                          Expenses</td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="txt_costofprojectincurred19" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="18%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred29" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="17%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred39" size="15" onKeyPress="allowDecimals(this)"  onBlur="" readOnly="readonly" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">9.</td>
                        <td width="40%">Pre-Operative 
                          Expenses </td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="txt_costofprojectincurred110" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="18%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred210" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="17%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred310" size="15" onKeyPress="allowDecimals(this)"  onBlur="" readOnly="readonly"  maxlength="8" style="text-align:right" value="0.00">
                        </td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">10.</td>
                        <td width="40%">Provision 
                          for Contingencies</td>
                        <td align="center" colspan="2"> </td>
                        <td width="18%" align="center"> </td>
                        <td width="17%" align="center"> </td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">&nbsp;</td>
                        <td width="40%">a) 
                          Building </td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="txt_costofprojectincurred111" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="18%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred211" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="17%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred311" size="15" onKeyPress="allowDecimals(this)"  onBlur="" readOnly="readonly"  maxlength="8" style="text-align:right" value="0.00">
                        </td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">&nbsp;</td>
                        <td width="40%">b) 
                          Plant &amp; Machinery</td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="txt_costofprojectincurred112" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="18%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred212" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="17%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred312" size="15" onKeyPress="allowDecimals(this)"  onBlur="" readOnly="readonly"  maxlength="8" style="text-align:right" value="0.00">
                        </td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">&nbsp;</td>
                        <td width="40%">c) 
                          Other Fixed Assets</td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="txt_costofprojectincurred113" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="18%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred213" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="17%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred313" size="15" onKeyPress="allowDecimals(this)"  onBlur="" readOnly="readonly"  maxlength="8" style="text-align:right" value="0.00">
                        </td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">11.</td>
                        <td width="40%">Margin 
                          for Working Capital Required</td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="txt_costofprojectincurred114" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="18%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred214" size="15" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="17%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred314" size="15" onKeyPress="allowDecimals(this)"  onBlur="" readOnly="readonly"  maxlength="8" style="text-align:right" value="0.00">
                        </td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="7%">12.</td>
                        <td width="40%"><b>Total</b></td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="txt_costofprojectincurred115" size="15" onKeyPress="allowDecimals(this)" onBlur="" readOnly="readonly"  maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="18%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred215" size="15" onKeyPress="allowDecimals(this)" onBlur="" readOnly="readonly"  maxlength="8" style="text-align:right" value="0.00">
                        </td>
                        <td width="17%" align="center"> 
                          <input type="text" name="txt_costofprojectincurred315" size="15" onKeyPress="allowDecimals(this)" onBlur="" readOnly="readonly" maxlength="8" style="text-align:right" value="0.00">
                        </td>
                      </tr>
                      <%
					  }
					  %>
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
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidDesc1"  value="LAND">
<input type="hidden" name="hidDesc2"  value="BULIDING">
<input type="hidden" name="hidDesc3"  value="INDIGENOUSPLANTMC">
<input type="hidden" name="hidDesc4"  value="IMPORTEDPLANTMC">
<input type="hidden" name="hidDesc5"  value="TOOLSSPARES">
<input type="hidden" name="hidDesc6"  value="TESTEQUIPMENTS">
<input type="hidden" name="hidDesc7"  value="MISCFIXEDASSETS">
<input type="hidden" name="hidDesc8"  value="INSTALLATIONCHRG"> 
<input type="hidden" name="hidDesc9"  value="PRELIMEXPEMSES">
<input type="hidden" name="hidDesc10" value="PREOPTEXPENSES">
<input type="hidden" name="hidDesc11" value="BUILDINGCONTINGENCIES">
<input type="hidden" name="hidDesc12" value="PLANTMACHCONTINGENCIES">
<input type="hidden" name="hidDesc13" value="FIXEDASSETSCONTINGENCIES">
<input type="hidden" name="hidDesc14" value="MARGINWCREQ">

<input type="hidden" name="hidTotalDesc" value="14">
<input type="hidden" name="hidFieldPrefix" value="txt_costofprojectincurred">
<INPUT TYPE="hidden" NAME="hidGenID" VALUE="">
<input type="hidden" name="otherGenTable" value="">
</form>
</body>
</html>

