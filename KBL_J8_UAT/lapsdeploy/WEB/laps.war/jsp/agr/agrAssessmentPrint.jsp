<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%@page import="com.sai.fw.management.utils.FwHelper"%>
<%@include file="../share/directives.jsp"%>
<lapschoice:handleerror />
<%

	java.text.NumberFormat nf = java.text.NumberFormat
			.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	String empstatuscode = Helper.correctNull(
			(String) hshValues.get("strEmployeeStatus")).trim();
	String appstatus = Helper.correctNull((String) session
			.getAttribute("appstatus"));
	String prd_type = Helper.correctNull((String) session
			.getAttribute("strProductType"));
	
	String strDesc =Helper.correctNull((String)request.getParameter("pageval"));
	 if (strDesc.equalsIgnoreCase(""))
			 {
		 			strDesc=Helper.correctNull((String)request.getParameter("hidpageval"));
		 			
			 }  if (strDesc.equalsIgnoreCase(""))
			 {
					strDesc=Helper.correctNull((String)request.getParameter("pageval1"));
			 }
	 String cma_amtval= Helper.correctNull((String)hshValues.get("cma_amtval"));
	 
	 ArrayList arrfin=(ArrayList)hshValues.get("arrFin");
	 String arrfin1="";
	
	 
%>
<%
	ArrayList arrFarmMech =new ArrayList();
	arrFarmMech=(ArrayList)hshValues.get("arrFarmMech");
	ArrayList arrMinorIrr =new ArrayList();
	arrMinorIrr=(ArrayList)hshValues.get("arrMinorIrr");
	ArrayList arrPlantation =new ArrayList();
	arrPlantation=(ArrayList)hshValues.get("arrPlantation");
	ArrayList arrLandDev =new ArrayList();
	arrLandDev=(ArrayList)hshValues.get("arrLandDev");
	ArrayList arrAgriLand =new ArrayList();
	arrAgriLand=(ArrayList)hshValues.get("arrAgriLand");
	ArrayList arrAgriMobile =new ArrayList();
	arrAgriMobile=(ArrayList)hshValues.get("arrAgriMobile");
	ArrayList arrWareHouse =new ArrayList();
	arrWareHouse=(ArrayList)hshValues.get("arrWareHouse");
	ArrayList arrRow=new ArrayList();
	ArrayList arrDairyFarm =new ArrayList();
	arrDairyFarm=(ArrayList)hshValues.get("arrDairyFarm");
	ArrayList arrAlliedAss =new ArrayList();
	arrAlliedAss=(ArrayList)hshValues.get("arrAlliedAss");
	ArrayList arrAMTL =new ArrayList();
	arrAMTL=(ArrayList)hshValues.get("arrAMTL");
	ArrayList arrSHG =new ArrayList();
	arrSHG=(ArrayList)hshValues.get("arrSHG");
	
	String StrSchemeType=Helper.correctNull((String)request.getParameter("strschemeType"));
%>
<html>
<head>
<title>Assessment</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT LANGUAGE="JavaScript">

var appURL="<%=ApplicationParams.getAppUrl()%>";
function callTab(str)
{
    document.forms[0].hidBeanId.value="combobassessment"; 
    document.forms[0].hidBeanGetMethod.value="getdataAssement";
    document.forms[0].pageval.value=str;
	document.forms[0].action = appURL+"action/bobassessment.jsp";
	document.forms[0].submit();
}  
function callECF(str)
{
    document.forms[0].hidBeanId.value="combobassessment"; 
    document.forms[0].hidBeanGetMethod.value="getexportcfAssessment";
    document.forms[0].pageval.value=str;
	document.forms[0].action = appURL+"action/com_exportcf.jsp";
	document.forms[0].submit();
}
function callBGST(str)
{
    document.forms[0].hidBeanId.value="combobassessment"; 
    document.forms[0].hidBeanGetMethod.value="getbgstockAssessment";
    document.forms[0].pageval.value=str;
	document.forms[0].action = appURL+"action/com_bgstock.jsp";
	document.forms[0].submit();
}
function callBG(str)
{
    document.forms[0].hidBeanId.value="combobassessment"; 
    document.forms[0].hidBeanGetMethod.value="getBGAssessment";
    document.forms[0].pageval.value="BGASSES";
	document.forms[0].action = appURL+"action/bgassessment.jsp";
	document.forms[0].submit();
} 

function callCashflow(str)
{
    document.forms[0].hidBeanId.value="combobassessment"; 
    document.forms[0].hidBeanGetMethod.value="getCashinflow";
    document.forms[0].pageval.value=str;
	document.forms[0].action = appURL+"action/cashflow.jsp";
	document.forms[0].submit();
}


function callLC(str)
{
    document.forms[0].hidBeanId.value="combobassessment"; 
    document.forms[0].hidBeanGetMethod.value="getLCAssessment";
    document.forms[0].pageval.value=str;
	document.forms[0].action = appURL+"action/com_lcassessment.jsp";
	document.forms[0].submit();
} 
function callWC(str)
{
    document.forms[0].hidBeanId.value="combobassessment"; 
    document.forms[0].hidBeanGetMethod.value="getWCAssessment";
    document.forms[0].pageval.value=str;
	document.forms[0].action = appURL+"action/com_wccontractorsassesment.jsp";
	document.forms[0].submit();
} 
function callOther(str)
{
	document.forms[0].hidBeanId.value="combobassessment"; 
    document.forms[0].hidBeanGetMethod.value="getotherAssessment";
	document.forms[0].pageval.value=str;
	document.forms[0].action = appURL+"action/com_otherassessment.jsp";
	document.forms[0].submit();
}
function callRepaymentSchedule(str)
{
	document.forms[0].hidBeanId.value="agrfarmmachinery"; 
    document.forms[0].hidBeanGetMethod.value="getCashFlowData";
	document.forms[0].pageval.value=str;
	document.forms[0].action = appURL+"action/agr_farmMechcashflow.jsp";
	document.forms[0].submit();
}
function callHomesteadfarm(str)
{
	document.forms[0].hidBeanId.value="agriloanassessment"; 
    document.forms[0].hidBeanGetMethod.value="gethomesteadassesmentdata";
	document.forms[0].pageval.value=str;
	document.forms[0].action = appURL+"action/agr_homesteadassessmentprint.jsp";
	document.forms[0].submit();
}
function callDSCR(str)
{
	document.forms[0].hidBeanId.value="agrfarmmachinery"; 
    document.forms[0].hidBeanGetMethod.value="getDSCRData";
	document.forms[0].pageval.value=str;
	document.forms[0].action = appURL+"action/agrDSCR.jsp";
	document.forms[0].submit();
}
function callIRR(str)
{
	document.forms[0].hidBeanId.value="agrfarmmachinery"; 
    document.forms[0].hidBeanGetMethod.value="getIRRDetails";
	document.forms[0].pageval.value="IRR";
	document.forms[0].action = appURL+"action/agr_minorirrigationIRR.jsp";
	document.forms[0].submit();
}
function call_page_diff1(url,bean,method)
{
	document.forms[0].hid_namepage.value="rbipolicy";
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
	document.forms[0].submit();
	
}
function callFKCC(str)
{
	document.forms[0].hidBeanId.value="agrfarmmachinery"; 
    document.forms[0].hidBeanGetMethod.value="getFKCCDetails";
	document.forms[0].pageval.value="FKCC";
	document.forms[0].action = appURL+"action/agr_FKCCAssessment.jsp";
	document.forms[0].submit();
}
function callcomments()
{
	
		var appno="<%=(String) request.getParameter("appno")%>";
		var pagetype = "MPBFAGR";
		var appstatus="<%=appstatus%>";
		var purl ="<%=ApplicationParams.getAppUrl()%>action/com_commentpage.jsp?hidBeanGetMethod=getDataComments&hidBeanId=comassestsliab&pagetype="+pagetype+"&appno="+appno+"&appstatus="+appstatus;				
		var prop = 'scrollbars=yes,menubar=no,width=700,height=450';	
		var xpos = (screen.width - 600) / 2;
		var ypos = (screen.height - 450) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);	
}

</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<!--<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>-->
<form method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"	class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="41" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
          	<td class="page_flow">
          		Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Financial Analysis -&gt; Assessment -&gt; Agri Mpbf
      			<span style="display:none"><lapschoice:borrowertype /></span> 
      			<lapschoice:application/>
          	</td>
          </tr>
</table>
 <jsp:include
	page="../com/com_commentstab.jsp" flush="true">
	<jsp:param name="tabid" value="30" />
</jsp:include>	
<table width="80%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr class="dataheader"> 
            <%
               if(arrfin!=null && arrfin.size()>0){ 
				for(int i=0;i<arrfin.size();i++){
			arrfin1=Helper.correctNull((String)arrfin.get(i));		
			
			if( arrfin1.equalsIgnoreCase("MPBF1")){
				if(strDesc.equals("MPBF1"))
				{
			
					%>
            <td width="1%" nowrap  class="lightTabColor"> MPBF 1 </td>
                <%
				  }
				  else
				  {
				  %>
                  
            <td width="1%"   class="darkTabColor" nowrap><a href="javascript:callTab('MPBF1')"  class="darkTabColor">MPBF 
              1 </a></td>
                <%
				}
				}
				%>
                <%
				if(arrfin1.equalsIgnoreCase("MPBF2")){
				if(strDesc.equals("MPBF2") )
				{
					%>
                  
            <td width="1%"   class="lightTabColor" nowrap > MPBF 2 </td>
                <%
				  }
				  else
				  {
				  %>
                  
            <td width="1%"    class="darkTabColor" nowrap><a href="javascript:callTab('MPBF2')"  class="darkTabColor">MPBF 
              2</a> </td>
                <%
				}
				}
				%>
				 <%
				 if(arrfin1.equalsIgnoreCase("MPBF3")){
				if(strDesc.equals("MPBF3") )
				{
					%>
                  
            <td width="1%"    class="lightTabColor" nowrap> MPBF3</td>
                <%
				  }
				  else
				  {
				  %>
                  
            <td width="1%"    class="darkTabColor" nowrap><a href="javascript:callTab('MPBF3')"  class="darkTabColor">MPBF3</a> 
            </td>
                <%
				}
				 }
				%>
                <%
                if(arrfin1.equalsIgnoreCase("MPBF4")){
				if(strDesc.equals("MPBF4"))
				{
					%>
                  
            <td width="1%"   class="lightTabColor" nowrap> MPBF4</td>
                <%
				  }
				  else
				  {
				  %>
                  
            <td width="1%"    class="darkTabColor" nowrap><a href="javascript:callTab('MPBF4')"  class="darkTabColor">MPBF4 
              </a></td>
                <%
				}
                }
				%>
                <%
                if( arrfin1.equalsIgnoreCase("MPBF5")){
				if(strDesc.equals("MPBF5"))
				{
					%>
                  
            <td width="1%"    class="lightTabColor" nowrap> MPBF5</td>
                <%
				  }
				  else
				  {
				  %>
                  
            <td width="1%"    class="darkTabColor" nowrap><a href="javascript:callTab('MPBF5')"  class="darkTabColor">MPBF5</a> 
            </td>
                <%
				}
                }
				%>
                <%
                if(arrfin1.equalsIgnoreCase("MPBF6")){
				if(strDesc.equals("MPBF6"))
				{
					%>
                  
            <td width="1%"    class="lightTabColor" nowrap> MPBF6</td>
                <%
				  }
				  else
				  {
				  %>
                  
            <td width="1%"    class="darkTabColor" nowrap><a href="javascript:callTab('MPBF6')"  class="darkTabColor">MPBF6 
              </a> </td>
                <%
				}
                }
				%>
                <%
                if(arrfin1.equalsIgnoreCase("MPBF7")){
				if(strDesc.equals("MPBF7"))
				{
					%>
                  
            <td width="1%"    class="lightTabColor" nowrap> MPBF7</td>
                <%
				  }
				  else
				  {
				  %>
                  
            <td width="1%"    class="darkTabColor" nowrap><a href="javascript:callTab('MPBF7')"  class="darkTabColor">MPBF7</a> 
            </td>
                <%
				}
                }
				%>
                <%
                if(arrfin1.equalsIgnoreCase("MPBF8")){
				if(strDesc.equals("MPBF8"))
				{
					%>
                  
            <td width="1%"    class="lightTabColor" nowrap> MPBF8</td>
                <%
				  }
				  else
				  {
				  %>
                  
            <td width="1%"    class="darkTabColor" nowrap><a href="javascript:callTab('MPBF8')"  class="darkTabColor">MPBF8</a></td>
                <%
				}}
				%>
                <%
                if(arrfin1.equalsIgnoreCase("MPBF9")){
				if(strDesc.equals("MPBF9"))
				{
					%>
                  
            <td width="1%"    class="lightTabColor" nowrap> MPBF9 </td>
                <%
				  }
				  else
				  {
				  %>
                  
            <td width="1%"    class="darkTabColor" nowrap><a href="javascript:callTab('MPBF9')"  class="darkTabColor">MPBF9</a> 
            </td>
                <%
				}
                }
				%>
                <%
                if(arrfin1.equalsIgnoreCase("PBF1")){
				if(strDesc.equals("PBF1"))
				{
			
					%>
                  
            <td width="0%"    class="lightTabColor" nowrap> PBF1</td>
                <%
				  }
				  else
				  {
				  %>
                  
            <td width="1%"    class="darkTabColor" nowrap><a href="javascript:callTab('PBF1')"  class="darkTabColor">PBF1</a> 
            </td>
                <%
				}
                }
				%>
                <%
                if(arrfin1.equalsIgnoreCase("PBF2")){
				if(strDesc.equals("PBF2"))
				{
					%>
                  
            <td width="0%"   class="lightTabColor" nowrap > PBF2</td>
                <%
				  }
				  else
				  {
				  %>
                  
            <td width="1%"    class="darkTabColor" nowrap><a href="javascript:callTab('PBF2')"  class="darkTabColor">PBF2</a> 
            </td>
                <%
				}}
				%>
                <%
                if(arrfin1.equalsIgnoreCase("PBF3")){
				if(strDesc.equals("PBF3"))
				{
					%>
                  
            <td width="1%"   class="lightTabColor" nowrap > PBF3 </td>
                <%
				  }
				  else
				  {
				  %>
                  
            <td width="1%"    class="darkTabColor" nowrap><a href="javascript:callTab('PBF3')" class="darkTabColor" >PBF3</a> 
            </td>
                <%
				}
                }
				%>
                <%
                if(arrfin1.equalsIgnoreCase("PBF4")){
				if(strDesc.equals("PBF4"))
				{
					%>
                  
            <td width="0%"   class="lightTabColor" nowrap > PBF4</td>
                <%
				  }
				  else
				  {
				  %>
                  
            <td width="1%"    class="darkTabColor" nowrap><a href="javascript:callTab('PBF4')"  class="darkTabColor">PBF4</a> 
            </td>
                <%
				}
                }
				%>
			<!-- 	<td width="15%" nowrap class="darkTabColor"><a
			href="javascript:callLink('com_cashbudgetpage.jsp','ComBobAssessmentBean','getCashBudget')"
			class="darkTabColor">CashBudget</a></td>
			<td width="15%" nowrap class="darkTabColor"><a
			href="javascript:callLink('cashbudgetquarterly.jsp','ComBobAssessmentBean','getCashBudgetQuarterly')"
			class="darkTabColor">CashBudget(Quarterly)</a></td> -->
				
                <%                
                if( arrfin1.equalsIgnoreCase("MPBF")){
    				if(strDesc.equals("MPBF"))
    				{
    			
    					%>
                      
            <td width="1%" nowrap  class="lightTabColor"> MPBF </td>
                    <%
    				  }
    				  else
    				  {
    				  %>
                      
            <td width="1%"   class="darkTabColor" nowrap><a href="javascript:callTab('MPBF')"  class="darkTabColor">MPBF 
              </a></td>
                    <%
    				}
    				}
                if( arrfin1.equalsIgnoreCase("ABF")){
    				if(strDesc.equals("ABF"))
    				{
    			
    					%>
                      
            <td width="4%" nowrap  class="lightTabColor"> Assessed Bank Finance 
            </td>
                    <%
    				  }
    				  else
    				  {
    				  %>
                      
            <td width="1%"   class="darkTabColor" nowrap><a href="javascript:callTab('ABF')"  class="darkTabColor">Assessed 
              Bank Finance</a></td>
                    <%
    				}
    				}
                if(arrfin1.equalsIgnoreCase("BGASSES")){
    				if(strDesc.equals("BGASSES"))
    				{
    					%>
                      
            <td width="3%"  class="lightTabColor" nowrap> BG Assessment </td>
                    <%
    				  }
    				  else
    				  {
    				  %>
                      
            <td width="3%"  class="darkTabColor" nowrap><a href="javascript:callBG('BGASSES')"  class="darkTabColor">BG 
              Assessment </a> </td>
                    <%
    				}
    				}
                if(arrfin1.equalsIgnoreCase("LCASSES")){
    				if(strDesc.equals("LCASSES"))
    				{
    					%>
                      
                  
            <td width="2%"  class="lightTabColor" nowrap> LC Assessment</td>
                    <%
    				  }
    				  else
    				  {
    				  %>
                      
            <td width="3%"  class="darkTabColor" nowrap><a href="javascript:callLC('LCASSES')"  class="darkTabColor">LC 
              Assessment </a> </td>
                    <%
    				}
    				}
				
			   
			    if(arrfin1.equalsIgnoreCase("CSHBUD")){
    				if(strDesc.equals("CSHBUD"))
    				{
    					%>
                      
                  
            <td width="2%"  class="lightTabColor" nowrap> Cash Budget</td>
                    <%
    				  }
    				  else
    				  {
    				  %>
                      
            <td width="2%"  class="darkTabColor" nowrap><a href="javascript:callCashflow('CSHBUD')"  class="darkTabColor">Cash 
              Budget </a> </td>
                    <%
    				}
    				}
			    if(arrfin1.equalsIgnoreCase("WCCONT")){
    				if(strDesc.equals("WCCONT"))
    				{
    					%>
                      
                  
            <td width="3%"  class="lightTabColor" nowrap> Working capital Limits 
              to Contractors</td>
                    <%
    				  }
    				  else
    				  {
    				  %>
                      
            <td width="3%"  class="darkTabColor" nowrap><a href="javascript:callWC('WCCONT')"  class="darkTabColor"> 
              Working capital Limits to Contractors </a> </td>
                    <%
    				}
    				}
			    if(arrfin1.equalsIgnoreCase("EXPORTCF")){
    				if(strDesc.equals("EXPORTCF"))
    				{
    					%>     
            <td width="3%"  class="lightTabColor" nowrap>Export Credit Facilities</td>
                    <%
    				  }
    				  else
    				  {
    				  %>
        
            <td width="3%"  class="darkTabColor" nowrap><a href="javascript:callECF('EXPORTCF')"  class="darkTabColor"> 
              Export Credit Facilities</a> </td>
                    <%
    				}
    				}
			    if(arrfin1.equalsIgnoreCase("BGSTOCK")){
    				if(strDesc.equals("BGSTOCK"))
    				{
    					%>
                      
                  
            <td width="3%"  class="lightTabColor" nowrap>BG for Stock Brokers</td>
                    <%
    				  }
    				  else
    				  {
    				  %>
                      
            <td width="3%"  class="darkTabColor" nowrap><a href="javascript:callBGST('BGSTOCK')"  class="darkTabColor"> 
              BG for Stock Brokers</a> </td>
                    <%
    				}
    				}
				
				if( arrfin1.equalsIgnoreCase("OTHER")){
				if (strDesc.equals("OTHER")) {
					%>
					<td width="1%" class="lightTabColor" nowrap>Other Assessment</td>
					<%
						} else {
					%>
					<td width="0%" class="darkTabColor" nowrap><a
						href="javascript:callOther('OTHER')" class="darkTabColor"> Other Assessment</a></td>
						</tr>
					<%
						}
               }
				//if (arrfin1.equalsIgnoreCase("MPBFAGR")) {
				//		if (strDesc.equals("MPBFAGR")) {
							%>
<!--							<tr>-->
<!--							<td width="0%" align="center" class="lightTabColor" nowrap>Agri-MPBF</td>-->
							<%
					//			} else {
							%>
<!--							<td width="0%" class="darkTabColor" nowrap align="center"><a-->
<!--								href="javascript:callMPBFAGR('MPBFAGR')" class="darkTabColor">Agri-MPBF</a></td>-->
<!--								-->
							<%
					//			}
					//}
					if (arrfin1.equalsIgnoreCase("RPSCHE")) {
						if (strDesc.equals("RPSCHE")) {
							%>
							<td width="0%" align="center" class="lightTabColor" nowrap>HomeStead Farming
</td>
							<%
								} else {
							%>
							<td width="0%" class="darkTabColor" nowrap align="center"><a
								href="javascript:callHomesteadfarm('RPSCHE')" class="darkTabColor"> HomeStead Farming
</a></td>
								
							<%
								}
					}
					//if (arrfin1.equalsIgnoreCase("DSCR")) {
						//if (strDesc.equals("DSCR")) {
							%>
							<!-- <td width="0%" align="center" class="lightTabColor" nowrap>DSCR</td> -->
							<%
								//} else {
							%>
							<!--<td width="0%" class="darkTabColor" nowrap align="center"><a
								href="javascript:callDSCR('DSCR')" class="darkTabColor"> DSCR</a></td>-->
								
							<%
								//}
					//}
					if (arrfin1.equalsIgnoreCase("IRR")) {
						if (strDesc.equals("IRR")) {
							%>
							<td width="0%" align="center" class="lightTabColor" nowrap>Agri-IRR</td>
							<%
								} else {
							%>
							<td width="0%" class="darkTabColor" nowrap align="center"><a
								href="javascript:callIRR('IRR')" class="darkTabColor">Agri-IRR</a></td>
		
							<%
								}
					}
					if (arrfin1.equalsIgnoreCase("FKCC")) {
						if (strDesc.equals("FKCC")) {
							%>
							<td width="0%" align="center" class="lightTabColor" nowrap>FKCC</td>
							<%
								} else {
							%>
							<td width="0%" class="darkTabColor" nowrap align="center"><a
								href="javascript:callFKCC('FKCC')" class="darkTabColor"> FKCC</a></td>
								</tr>
							<%
								}
					}
               }
               }
				%>
				
		
              </table>
<br>
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<%
		if (prd_type.equalsIgnoreCase("aO")) {
	%>
	<tr align="center" class="darkTabColor">
		<td width="17%" nowrap class="darkTabColor"><a
			href="javascript:callLink('agr_farmMechcashflow.jsp','agrfarmmachinery','getCashFlowData')"
			class="darkTabColor">Repayment Schedule </a></td>
		<td width="14%" nowrap class="menus"><a
			href="JavaScript:callOtherTab('DSCR')" class="darkTabColor">DSCR</a></td>
		<td width="17%" nowrap class="darkTabColor"><a
			href="javascript:callLink('agr_minorirrigationIRR.jsp','agrfarmmachinery','getIRRDetails')"
			class="darkTabColor">IRR </a></td>


	</tr>
	<%
		}
	%>

</table>
<table width="55%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
	<tr class="datagrid">
		<td align="center">
			<table width="98%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
				<tr> <td align="center"><u><b>Assessment Method</b></u></td></tr>
				<%if(arrSHG !=null && arrSHG.size() >0){ %>
				<tr>
					<td>
					<table width="98%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
					
						<%for(int i=0;i<arrSHG.size();i++)
						{	
							arrRow=new ArrayList();
							arrRow= (ArrayList)arrSHG.get(i);%>
							
						<tr class="dataheader">
							<td colspan="2"><%=Helper.correctNull((String)arrRow.get(0))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(1))%></td>
							<td align="right" width="40%"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(5))))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(2))%></td>
							<td align="right" width="40%"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(6))))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(3))%></td>
							<td align="right" width="40%"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(7))))%></td>
						</tr>
						<tr>
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<b><%=Helper.correctNull((String)arrRow.get(4))%></b></td>
							<td align="right" width="40%"><b><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(8))))%></b></td>
						</tr>
						<%} %>
						</table>
					</td>
				</tr><%} %>
				<%if(arrMinorIrr !=null && arrMinorIrr.size() >0){ %>
				<tr class="datagrid">
					<td>
					<table width="98%" border="0" cellspacing="2" cellpadding="3" align="center" class="outertable">
					
						<%for(int i=0;i<arrMinorIrr.size();i++)
						{	
							arrRow=new ArrayList();
							arrRow= (ArrayList)arrMinorIrr.get(i);%>
							
						<tr class="dataheader">
							<td colspan="2"><%=Helper.correctNull((String)arrRow.get(0))%></td>
						</tr>
						<tr>
							<td colspan="2"><b><%=Helper.correctNull((String)arrRow.get(1))%></b></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(2))%></td>
							<td align="right" width="40%"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(3))))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(4))%></td>
							<td align="right" width="40%"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(5))))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(6))%></td>
							<td align="right" width="40%"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(7))))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(8))%></td>
							<td align="right" width="40%"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(9))))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(10))%></td>
							<td align="right" width="40%"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(11))))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(12))%></td>
							<td align="right" width="40%"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(13))))%></td>
						</tr>
						<tr>
							<td colspan="2"><b><%=Helper.correctNull((String)arrRow.get(14))%></b></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(15))%></td>
							<td align="right" width="40%"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(16))))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(17))%>&nbsp;<%=Helper.checkPercentageDecimalPoint(Helper
							.correctDouble((String) arrRow.get(18)))%>&nbsp;<%=Helper.correctNull((String)arrRow.get(19))%></td>
							<td align="right" width="40%"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(20))))%></td>
						</tr>
						<tr>
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<b><%=Helper.correctNull((String)arrRow.get(21))%></b></td>
							<td align="right" width="40%"><b><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(22))))%></b></td>
						</tr>
						<%} %>
						</table>
					</td>
				</tr><%} %>
				<%if(arrFarmMech !=null && arrFarmMech.size() >0){ %>
 			<tr>
					<td>
					<table width="98%" border="0" cellspacing="2" cellpadding="3" align="center" class="outertable">
					
						<%for(int i=0;i<arrFarmMech.size();i++)
						{	
							arrRow=new ArrayList();
							arrRow= (ArrayList)arrFarmMech.get(i);%>
						<tr class="dataheader">
							<td colspan="2"><%=Helper.correctNull((String)arrRow.get(0))%></td>
						</tr>
						<tr>
							<td colspan="2" align="left">&nbsp;<b><%=Helper.correctNull((String)arrRow.get(1))%></b></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(2))%></td>
							<td align="right" width="40%"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(3))))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(4))%></td>
							<td align="right" width="40%"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(5))))%></td>
						</tr>
						<!-- <tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(6))%></td>
							<td align="right" width="40%"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(7))))%></td>
						</tr> -->
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(8))%>&nbsp;<%=Helper.checkPercentageDecimalPoint((String)arrRow.get(9))%> %</td>
							<td align="right" width="40%"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(10))))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(11))%></td>
							<td align="right" width="40%"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(12))))%></td>
						</tr>
						<tr>
						<td colspan="2" align="left">&nbsp;<b><%=Helper.correctNull((String)arrRow.get(13))%></b></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(14))%></td>
							<td align="right" width="40%"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(15))))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(16))%></td>
							<td align="right" width="40%"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(17))))%></td>
						</tr>
						<tr>
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<b><%=Helper.correctNull((String)arrRow.get(18))%></b></td>
							<td align="right" width="40%"><b><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(19))))%></b></td>
						</tr>
						<%} %>
						</table>
					</td>
				</tr><%} %>
					<%if(arrPlantation !=null && arrPlantation.size() >0){ %>
				<tr>
					<td>
					<table width="98%" border="0" cellspacing="2" cellpadding="3" align="center" class="outertable">
				
						<%for(int i=0;i<arrPlantation.size();i++)
						{	
							arrRow=new ArrayList();
							arrRow= (ArrayList)arrPlantation.get(i);%>
							
						<tr class="dataheader">
							<td colspan="2"><%=Helper.correctNull((String)arrRow.get(0))%></td>
						</tr>
						<tr>
							<td width="60%" align="left">&nbsp;<%=Helper.correctNull((String)arrRow.get(1))%></td>
							<td width="40%" align="right""><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(2))))%></td>
						</tr>
						<tr>
							<td width="60%" align="left">&nbsp;<%=Helper.correctNull((String)arrRow.get(3))%></td>
							<td width="40%" align="right""><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(4))))%></td>
						</tr>
						<tr>
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<td width="60%" align="left">&nbsp;<b><%=Helper.correctNull((String)arrRow.get(5))%></b></td>
							<td width="40%" align="right""><b><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(6))))%></b></td>
						</tr>
						<%}%>
						</table>
					</td>
				</tr><%} %>
				<%if(arrLandDev !=null && arrLandDev.size() >0){ %>
				<tr>
					<td>
					<table width="98%" border="0" cellspacing="2" cellpadding="3" align="center" class="outertable">
					
						<%for(int i=0;i<arrLandDev.size();i++)
						{	
							arrRow=new ArrayList();
							arrRow= (ArrayList)arrLandDev.get(i);%>
							
						<tr class="dataheader">
							<td colspan="2"><%=Helper.correctNull((String)arrRow.get(0))%></td>
						</tr>
						<tr>
							<td colspan="2"><b><%=Helper.correctNull((String)arrRow.get(1))%></b></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(2))%></td>
							<td align="right" width="40%"><%=nf.format(Math.round(FwHelper.parseDouble(Helper.correctDouble((String) arrRow.get(20)))))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.checkPercentageDecimalPoint(Helper
							.correctDouble((String) arrRow.get(19)))%>&nbsp;<%=Helper.correctNull((String)arrRow.get(3))%></td>
							<td align="right" width="40%"><%=nf.format(Math.round(FwHelper.parseDouble(Helper.correctDouble((String) arrRow.get(24)))))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(4))%></td>
							<td align="right" width="40%"><%=nf.format(Math.round(FwHelper.parseDouble(Helper.correctDouble((String) arrRow.get(25)))))%></td>
						</tr>
						<tr>
							<td colspan="2"><b><%=Helper.correctNull((String)arrRow.get(5))%></b></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(6))%></td>
							<td align="right" width="40%"><%=nf.format(Math.round(FwHelper.parseDouble(Helper.correctDouble((String) arrRow.get(21)))))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.checkPercentageDecimalPoint(Helper
							.correctDouble((String) arrRow.get(19)))%>&nbsp;<%=Helper.correctNull((String)arrRow.get(3))%></td>
							<td align="right" width="40%"><%=nf.format(Math.round(FwHelper.parseDouble(Helper.correctDouble((String) arrRow.get(26)))))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(7))%></td>
							<td align="right" width="40%"><%=nf.format(Math.round(FwHelper.parseDouble(Helper.correctDouble((String) arrRow.get(27)))))%></td>
						</tr>
						<!--  
						<tr>
							<td colspan="2"><b><%=Helper.correctNull((String)arrRow.get(8))%></b></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(9))%></td>
							<td align="right" width="40%"><%=nf.format(Math.round(FwHelper.parseDouble(Helper.correctDouble((String) arrRow.get(23)))))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.checkPercentageDecimalPoint(Helper
							.correctDouble((String) arrRow.get(19)))%>&nbsp;<%=Helper.correctNull((String)arrRow.get(3))%></td>
							<td align="right" width="40%"><%=nf.format(Math.round(FwHelper.parseDouble(Helper.correctDouble((String) arrRow.get(28)))))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(10))%></td>
							<td align="right" width="40%"><%=nf.format(Math.round(FwHelper.parseDouble(Helper.correctDouble((String) arrRow.get(29)))))%></td>
						</tr>-->
						
						<tr>
							<td colspan="2"><b><%=Helper.correctNull((String)arrRow.get(11))%></b></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(12))%></td>
							<td align="right" width="40%"><%=nf.format(Math.round(FwHelper.parseDouble(Helper.correctDouble((String) arrRow.get(22)))))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.checkPercentageDecimalPoint(Helper
							.correctDouble((String) arrRow.get(19)))%>&nbsp;<%=Helper.correctNull((String)arrRow.get(3))%></td>
							<td align="right" width="40%"><%=nf.format(Math.round(FwHelper.parseDouble(Helper.correctDouble((String) arrRow.get(30)))))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(13))%></td>
							<td align="right" width="40%"><%=nf.format(Math.round(FwHelper.parseDouble(Helper.correctDouble((String) arrRow.get(31)))))%></td>
						</tr>
						<tr>
							<td colspan="2"><b><%=Helper.correctNull((String)arrRow.get(34))%></b></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(35))%></td>
							<td align="right" width="40%"><%=nf.format(Math.round(FwHelper.parseDouble(Helper.correctDouble((String) arrRow.get(37)))))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.checkPercentageDecimalPoint(Helper
							.correctDouble((String) arrRow.get(19)))%>&nbsp;<%=Helper.correctNull((String)arrRow.get(3))%></td>
							<td align="right" width="40%"><%=nf.format(Math.round(FwHelper.parseDouble(Helper.correctDouble((String) arrRow.get(38)))))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(36))%></td>
							<td align="right" width="40%"><%=nf.format(Math.round(FwHelper.parseDouble(Helper.correctDouble((String) arrRow.get(39)))))%></td>
						</tr>
						<tr>
							<td colspan="2"><b><%=Helper.correctNull((String)arrRow.get(40))%></b></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(41))%></td>
							<td align="right" width="40%"><%=nf.format(Math.round(FwHelper.parseDouble(Helper.correctDouble((String) arrRow.get(43)))))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.checkPercentageDecimalPoint(Helper
							.correctDouble((String) arrRow.get(19)))%>&nbsp;<%=Helper.correctNull((String)arrRow.get(3))%></td>
							<td align="right" width="40%"><%=nf.format(Math.round(FwHelper.parseDouble(Helper.correctDouble((String) arrRow.get(44)))))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(42))%></td>
							<td align="right" width="40%"><%=nf.format(Math.round(FwHelper.parseDouble(Helper.correctDouble((String) arrRow.get(45)))))%></td>
						</tr>
						<tr>
							<td colspan="2"><b><%=Helper.correctNull((String)arrRow.get(14))%></b></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(15))%></td>
							<td align="right" width="40%"><%=nf.format(Math.round(FwHelper.parseDouble(Helper.correctDouble((String) arrRow.get(18)))))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(16))%></td>
							<td align="right" width="40%"><%=nf.format(Math.round(FwHelper.parseDouble(Helper.correctDouble((String) arrRow.get(32)))))%></td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<b><%=Helper.correctNull((String)arrRow.get(17))%></b></td>
							<td align="right" width="40%"><b><%=nf.format(Math.round(FwHelper.parseDouble(Helper.correctDouble((String) arrRow.get(33)))))%></b></td>
						</tr>
						<%} %>
						</table>
					</td>
				</tr><%}%>
				<%if(arrAgriLand !=null && arrAgriLand.size() >0){ %>
			<tr>
					<td>
					<table width="98%" border="0" cellspacing="2" cellpadding="3" align="center" class="outertable">
					
						<%for(int i=0;i<arrAgriLand.size();i++)
						{	
							arrRow=new ArrayList();
							arrRow= (ArrayList)arrAgriLand.get(i);%>
							
						<tr class="dataheader">
							<td colspan="2"><%=Helper.correctNull((String)arrRow.get(0))%></td>
						</tr>
						<tr>
							<td align="left" width="60%"><%=Helper.correctNull((String)arrRow.get(1))%></td>
							<td width="40%" align="right""><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(2))))%></td>
							
						</tr>
						<tr>
							<td align="left" width="60%"><%=Helper.correctNull((String)arrRow.get(3))%></td>
							<td width="40%" align="right""><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(4))))%></td>
							
						</tr>
						<tr>
							<td align="left" width="60%"><%=Helper.correctNull((String)arrRow.get(5))%></td>
							<td width="40%" align="right""><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(6))))%></td>
							
						</tr>
						<tr>
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<td align="left" width="60%"><b><%=Helper.correctNull((String)arrRow.get(7))%></b></td>
							<td width="40%" align="right""><b><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrRow.get(8))))%></b></td>
							
						</tr>
						<%} %>
						</table>
					</td>
				</tr>
				<%} %>
				
				<%if(arrAgriMobile !=null && arrAgriMobile.size() >0){ %>
				
				<tr>
					<td>
					<table width="98%" border="0" cellspacing="2" cellpadding="3" align="center" class="outertable">
					
					<% 	for(int i=0;i<arrAgriMobile.size();i++)
						{	
							arrRow=new ArrayList();
							arrRow= (ArrayList)arrAgriMobile.get(i);%>
							
						<tr class="dataheader">
							<td colspan="2"><%=Helper.correctNull((String)arrRow.get(0))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(1))%></td>
							<td align="right" width="40%">&nbsp;<%=nf.format(Double.parseDouble((String)arrRow.get(2)))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(3))%></td>
							<td align="right" width="40%">&nbsp;<%=nf.format(Double.parseDouble((String)arrRow.get(4)))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.checkPercentageDecimalPoint(Helper.correctDouble((String)arrRow.get(5)))%><%=Helper.correctNull((String)arrRow.get(6))%></td>
							<td align="right" width="40%">&nbsp;<%=nf.format(Double.parseDouble((String)arrRow.get(7)))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(17))%></td>
							<td align="right" width="40%">&nbsp;<%=nf.format(Double.parseDouble((String)arrRow.get(18)))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(12))%></td>
							<td align="right" width="40%">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrRow.get(13))))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(8))%></td>
							<td align="right" width="40%">&nbsp;<%=nf.format(Double.parseDouble((String)arrRow.get(9)))%></td>
						</tr>
						<tr>
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<b><%=Helper.correctNull((String)arrRow.get(10))%></b></td>
							<td align="right" width="40%">&nbsp;<b><%=nf.format(Double.parseDouble((String)arrRow.get(11)))%></b></td>
						</tr>
						<tr>
						<td align="left" width="60%">&nbsp;<b><%=Helper.correctNull((String)arrRow.get(14))%></b></td>
						<td align="right" width="40%">&nbsp;</td>
						</tr>
						<tr>
						<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(15))%></td>
						<td align="right" width="40%">&nbsp;</td>
						</tr>
						<tr>
						<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(16))%></td>
						<td align="right" width="40%">&nbsp;</td>
						</tr>
						<%}%>
						</table>
					</td>
				</tr><%} %>
				<%if(arrWareHouse !=null && arrWareHouse.size() >0){ %>
				<tr>
					<td>
					<table width="98%" border="0" cellspacing="2" cellpadding="3" align="center" class="outertable">
					
						<%for(int i=0;i<arrWareHouse.size();i++)
						{	
							arrRow=new ArrayList();
							arrRow= (ArrayList)arrWareHouse.get(i);%>
							
						<tr class="dataheader">
							<td colspan="2"><%=Helper.correctNull((String)arrRow.get(0))%></td>
						</tr>
						<tr>
							<td colspan="2"><b><%=Helper.correctNull((String)arrRow.get(1))%></b></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(2))%></td>
							<td align="right" width="40%">&nbsp;<%=nf.format(Double.parseDouble((String)arrRow.get(3)))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(4))%></td>
							<td align="right" width="40%">&nbsp;<%=nf.format(Double.parseDouble((String)arrRow.get(5)))%></td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<%=Helper.correctNull((String)arrRow.get(6))%>&nbsp;<%=Helper.checkPercentageDecimalPoint(Helper
							.correctDouble((String) arrRow.get(7)))%>&nbsp;<%=Helper.correctNull((String)arrRow.get(8))%></td>
							<td align="right" width="40%">&nbsp;<%=nf.format(Double.parseDouble((String)arrRow.get(9)))%></td>
						</tr>
						<tr>
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<td align="left" width="60%">&nbsp;<b><%=Helper.correctNull((String)arrRow.get(10))%></b></td>
							<td align="right" width="40%">&nbsp;<b><%=nf.format(Double.parseDouble((String)arrRow.get(11)))%></b></td>
						</tr>
						<% } %>
						</table>
					</td>
				</tr>
				<%  } %>
				<%if(arrDairyFarm !=null && arrDairyFarm.size() >0){ %>
				<tr>
					<td>
					<table width="98%" border="0" cellspacing="2" cellpadding="3" align="center" class="outertable">
						<% for(int i=0;i<arrDairyFarm.size();i++)
						{	
							arrRow=new ArrayList();
							arrRow= (ArrayList)arrDairyFarm.get(i);%>
							<tr class="dataheader">
							<td colspan="2"><%=Helper.correctNull((String)arrRow.get(12))%></td>
						</tr>
						<tr >
							<td colspan="2"><B><%=Helper.correctNull((String)arrRow.get(0))%></B></td>
						</tr>
						<tr>
							<td><%=Helper.correctNull((String)arrRow.get(1))%><B>(A)</B></td>
							<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrRow.get(2))))%></td>
						</tr>
						<tr>
							<td ><%=Helper.correctNull((String)arrRow.get(3))%></td>
							<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrRow.get(4))))%></td>
						</tr>
						<tr>
							<td><%=Helper.correctNull((String)arrRow.get(5))%> <%=Helper.correctNull((String)arrRow.get(6))%></td>
							<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrRow.get(7))))%></td>
						</tr>
						<tr>
							<td><%=Helper.correctNull((String)arrRow.get(8))%><b>(B)</b></td>
							<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrRow.get(9))))%></td>
						</tr>
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr >
							<td><b><%=Helper.correctNull((String)arrRow.get(10))%></b></td>
							<td align="right"><b><%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrRow.get(11))))%></b></td>
						</tr>
						
						<%}%>
						</table>
					</td>
				</tr><%}%>
				<%if(arrAMTL!=null && arrAMTL.size() >0){ %>
				<tr>
					<td>
					<table width="98%" border="0" cellspacing="2" cellpadding="3" align="center" class="outertable">
						<% for(int i=0;i<arrAMTL.size();i++)
						{	
							arrRow=new ArrayList();
							arrRow= (ArrayList)arrAMTL.get(i);%>
							<tr class="dataheader">
							<td colspan="2"><%=Helper.correctNull((String)arrRow.get(0))%></td>
						</tr>
						<tr >
							<td colspan="2"><B><%=Helper.correctNull((String)arrRow.get(1))%></B></td>
						</tr>
						<tr>
							<td><%=Helper.correctNull((String)arrRow.get(2))%><B>(A)</B></td>
							<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrRow.get(3))))%></td>
						</tr>
						<tr>
							<td ><%=Helper.correctNull((String)arrRow.get(4))%> <%=Helper.correctNull((String)arrRow.get(5))%>
							<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrRow.get(6))))%></td>
							<td align="right"></td>
						</tr>
						<%}%>
						</table>
					</td>
				</tr><%}%>
		<%if(arrAlliedAss !=null && arrAlliedAss.size() >0){ %>
				<tr>
					<td>
					<table width="98%" border="0" cellspacing="2" cellpadding="3" align="center" class="outertable">
						<% for(int i=0;i<arrAlliedAss.size();i++)
						{	
							arrRow=new ArrayList();
							arrRow= (ArrayList)arrAlliedAss.get(i);%>
							<tr class="dataheader">
							<td colspan="2"><%=Helper.correctNull((String)arrRow.get(0))%></td>
						</tr>
						<tr>
							<td><%=Helper.correctNull((String)arrRow.get(1))%></td>
							<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrRow.get(5))))%></td>
						</tr>
						<tr>
							<td><%=Helper.correctNull((String)arrRow.get(2))%></td>
							<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrRow.get(6))))%></td>
						</tr>
						<tr>
							<td><%=Helper.correctNull((String)arrRow.get(3))%></td>
							<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrRow.get(7))))%></td>
						</tr>
						
						<tr>
							<td><B><%=Helper.correctNull((String)arrRow.get(4))%></B></td>
							<td align="right"><b><%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrRow.get(8))))%></b></td>
						</tr>
						<%}%>
						</table>
					</td>
				</tr><%}%>
					<tr>
					<table width="98%" border="0" cellspacing="2" cellpadding="3" align="center" class="outertable">
					<tr>
							<td colspan="2">&nbsp;</td>
					</tr>
				<tr>
					<td align="left" width="60%">&nbsp;<b><%=Helper.correctNull((String)hshValues.get("Total Eligible Loan Amount"))%></b></td>
					<td align="right" width="40%">&nbsp;<b><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblTotalEligibleLoanAmount"))))%></b></td>
				</tr>
				</table>
				</tr>
			</table>
		</td>
	</tr>
</table>
				<!--  <td><input type="button" name="cmdPrint" value="Print"
					onClick="doPrint()" class="buttonStyle"></td>-->
			<lapschoice:combuttonnew btnnames="" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
               
<!--			<input type="button" name="cmdcomment" value="Comments"	onClick="callcomments()" class="buttonStyle"></td>-->

<br>
<input type="hidden" name="hidBeanMethod" value=""> <input
	type="hidden" name="hidBeanId" value=""> <input type="hidden"
	name="hidSourceUrl" value=""> <input type="hidden"
	name="hidBeanGetMethod" value=""> <input type="hidden"
	name="hidAction" value=""> <input type="hidden"
	name="hid_pagename" value=""> <INPUT TYPE="hidden"
	name="hidAppType" value=""> <input type="hidden"
	name="comappid"
	value="<%=Helper.correctNull((String) session
							.getAttribute("comappid"))%>">
<input type="hidden" name="bowid"
	value="<%=Helper.correctNull((String) session
									.getAttribute("bowid"))%>">
<input type="hidden" name="hidDemoId"
	value="<%=Helper.correctNull((String) session
							.getAttribute("hidDemoId"))%>">
<input type="hidden" name="hidEMI" value=""> 
<input type="hidden" name="pageval">
   <input type="hidden" name="pageval1" value="<%=request.getParameter("pageval")%>">
 <input type="hidden" name="cmdapply" value="disabled" disabled="disabled">
<input type="hidden" name="cmdsave" disabled>
<INPUT TYPE="hidden" name="strAssessment" value = "<%=request.getParameter("strAssessment")%>">
<INPUT TYPE="hidden" name="strschemeType" value = "<%=StrSchemeType%>">
 </form>
</body>
</html>
