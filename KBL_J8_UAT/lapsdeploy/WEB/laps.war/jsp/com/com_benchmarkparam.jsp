<%@include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%request.setAttribute("_cache_refresh", "true");

			%>
<laps:handleerror />
<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			ArrayList vec = new ArrayList();
			ArrayList vecrec = new ArrayList();
			ArrayList vecBench = new ArrayList();
			ArrayList vecBenchrec = new ArrayList();
			int vecsize = 0;
			int vecrecsize = 0;
			int vecBenchsize = 0;
			int vecBenchrecsize = 0;
			if (hshValues != null) {
				vec = (ArrayList) hshValues.get("vecData");
					//vecrec = (ArrayList) hshValues.get("vecData1");
					
			}
			if (vec != null) {
				vecsize = vec.size();
			}
			
			//if (vecrec != null) {
			//	vecrecsize = vecrec.size();
			//	}
			ArrayList g1 = new ArrayList();
			ArrayList g2 = new ArrayList();

			String pageval = "";

			pageval = Helper.correctNull((String) hshValues.get("page"));
			
			String strIndType = Helper.correctNull((String) request
					.getParameter("hidIndType"));
						
			java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			nf.setGroupingUsed(false);
			
			ArrayList arrfin = new ArrayList();
			String arrfin1 = "",Asspageval="";
			arrfin=(ArrayList)hshValues.get("arrFin");
			String strSessionModule="";
			strSessionModule=Helper.correctNull((String)session.getAttribute("sessionModuleType"));
			String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();

%>
<html>
<head>
<title>Financial Analysis - Benchmark Ratio</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/com/finmain.js">
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<Script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var appno="<%=request.getParameter("appno")%>";
function callLoad()
{
	disableFields(true);
	if(appstatus=="Open/Pending")
	{
	   if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	   {
		 disableCommandButtons(false, true, true, true, false,false);	
	 }
	   else
	   {
		   disableCommandButtons(true, true, true, true, false,false);	
	   }
	}
	 else
	 {
		 		 disableCommandButtons(true, true, true, true, false,false);	
		 }
 }


function disableCommandButtons(blEdit, blApply, blCancel, blDelete, blClose,blComments)
{
	document.forms[0].cmdedit.disabled=blEdit;
	document.forms[0].cmdsave.disabled=blApply;
	document.forms[0].cmdcancel.disabled=blCancel;
	document.forms[0].cmddelete.disabled=blDelete;
	document.forms[0].cmdclose.disabled=blClose;
	document.forms[0].cmdcomments.disabled=blComments;
}

function doEdit()
{
	disableCommandButtons(true, false, false, false, true,false);
	disableFields(false);
}

function doSave()
{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidAction.value="Insert";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanMethod.value="updateBenchMarkParam";
	document.forms[0].hidBeanGetMethod.value="getBenchMarkParam";
	document.forms[0].hidSourceUrl.value="/action/com_benchmarkparam.jsp";
	document.forms[0].submit();
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
	document.forms[0].hidAction.value="Cancel";
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanGetMethod.value="getBenchMarkParam";
	document.forms[0].action=appUrl+"action/com_benchmarkparam.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
	}
}

function doDelete()
{
	document.forms[0].hidAction.value="Delete";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanMethod.value="updateBenchMarkParam";
	document.forms[0].hidBeanGetMethod.value="getBenchMarkParam";
	document.forms[0].hidSourceUrl.value="/action/com_benchmarkparam.jsp";
	document.forms[0].submit();
}

function doClose()
{
	document.forms[0].action=appUrl+"action/comborrowersearch.jsp?hidPageType=PROP";
	document.forms[0].method="post";
	document.forms[0].submit(); 
}


function disableFields(val)
  {
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  if(document.forms[0].elements[i].type=='text'  )
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
		  if(document.forms[0].elements[i].type=='textarea'  )
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
		  if(document.forms[0].elements[i].type=='select-one' )
		  {
 				document.forms[0].elements[i].disabled=val;
		  }
		  if(document.forms[0].elements[i].type=='radio' )
		  {
			  if((document.forms[0].appstatus.value=="Processed/Approved")||(document.forms[0].appstatus.value=="Processed/Rejected")||
			  (document.forms[0].appstatus.value=="Closed/Approved")||(document.forms[0].appstatus.value=="Closed/Rejected"))
			  {
 				document.forms[0].elements[i].disabled=val;
			  }
		  }

	  } 
	 } 
function doComments()
{
	var btnenable=document.forms[0].btnenable.value;
	var strAppno =appno;
	var pagetype = document.forms[0].hidCommentPage.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/com_comments.jsp?hidBeanId=comproposal&hidBeanGetMethod=getDataComments&pagetype="+pagetype+"&strAppno="+strAppno+"&btnenable="+btnenable+"&btnenable="+btnenable;
	window.open(url,"Comments",prop);
}
</script>
</head>
<body onLoad="callLoad()">
		<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
	
	
	


<jsp:include page="../share/help.jsp" flush="true"/>
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form method="post" class="normal">
<%
if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
class="outertable">
<tr>
	<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
		<jsp:param name="pageid" value="11" />
		<jsp:param name="subpageid" value="132" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
		<jsp:param name="ssitype" value="<%=strSSIType%>" />
	</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
	</td>
</tr>
</table>
<%}else{%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="">
  <tr> 
	<td valign="top" colSpan=5>
           	<jsp:include page="../com/proposallinks.jsp" flush="true"> 
			<jsp:param name="pageid" value="8" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />			
			</jsp:include>
   </td>
 </tr>
 <tr>
    <%if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">
 		Home -&gt; Agriculture -&gt; Financial Analysis -&gt; Deviation from Loan Policy 
<span style="display:none"><lapschoice:borrowertype /></span> 
<lapschoice:application/>
	</td>
	<%}else{%>
		<td class="page_flow">
 		Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Financial Analysis -&gt; Deviation from Loan Policy 
<span style="display:none"><lapschoice:borrowertype /></span> 
<lapschoice:application/>
	</td>
		<%} %> 	
</tr>
</table>
<%} %>
  	 <lapschoice:FinAnalysisTag tabid="11" /> 

<br>
<table width="98%" border="0" cellspacing="0" cellpadding="3" align="center" >
	<tr>
		<td valign="top">
		<table width="98%" border="0" cellspacing="0" cellpadding="5" align="center" >
			<tr>
				<td valign="top" height="76">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
					<tr>
						<td>
						
                    <table width="100%" border="0" cellspacing="1" cellpadding="1">
                      <tr class="dataheader"> 
                        <td nowrap colspan="4" align="right">&nbsp;Values in <b><%=Helper.correctNull((String)hshValues.get("cma_amtval"))%> &nbsp;&nbsp;</b></td>
                      </tr>
                      <tr class="dataheader"> 
                        <td nowrap width="30%" align="center">Parameters</td>
                        <td nowrap width="15%" align="center">Benchmark Level</td>
                        <td nowrap width="18%" align="center">As per proposal</td>
                        <td nowrap width="37%" align="center">Status of compliance</td>
                      </tr>
                      <%if (vecsize != 0 && vec != null) 
                      {
						for (int l = 0; l < vecsize; l++) 
						{
						if (l < vecsize) {
						g2 = (ArrayList) vec.get(l);
						%>
                      <tr class="datagrid"> 
                        <td nowrap WIDTH="30%">&nbsp;<%=Helper.correctNull((String) g2.get(2))%>
                          <input type="hidden" name="txt_id" maxlength="4" value="<%=Helper.correctNull((String)g2.get(0))%>">
                        </td>
                        <td align="center" nowrap WIDTH="15%"><%=Helper.correctNull((String) g2.get(3))%></td>
                        <% String StrMan = Helper.correctNull((String) g2.get(5));
                        if(StrMan.equalsIgnoreCase("M")){ 
                        %>
                        <td align="center" nowrap WIDTH="18%">
                        <input type="text" name="txt_Actual" value="<%=Helper.correctNull((String)g2.get(7))%>"></td>
                        <%}else{%>
                         
                        <td align="center" nowrap WIDTH="18%"> <input type="hidden" name="txt_Actual" value="<%=Helper.correctNull((String)g2.get(7))%>"><%=Helper.correctNull((String) g2.get(5))%></td>
                         <%} %>
                        <td valign="top" align="center"> 
                          <textarea name="txt_status" onBlur="textlimit(this,3999)"
											onKeyPress="notAllowSingleAndDoubleQuote();textlimitcorp1(this,400)"
											rows="2" cols="25" wrap="virtual" onkeyup="textlimitcorp1(this,400);" onkeydown="textlimitcorp1(this,400);"><%=Helper.correctNull((String)g2.get(6))%></textarea>
                        </td>
                        <%}
						}
					} else {
						for (int l = 0; l < vecrecsize; l++) {
							if (l < vecrecsize) {
								g2 = (ArrayList) vecrec.get(l);
		
								%>
		                      <tr class="datagrid"> 
		                        <td nowrap WIDTH="30%"></td>
		                        <td align="center" nowrap WIDTH="15%"></td>
		                        <td align="center" nowrap WIDTH="18%"></td>
		                        <td align="center" nowrap WIDTH="18%"></td>
		                        <%}
						}
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
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Comments_Audit Trail" btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' />
	<INPUT TYPE="hidden" value="<%=pageval%>" name="pageval"> 
	<input type="hidden" name="flowtype" value="RA"> 
	<input type="hidden" name="yearfrom"> 
	<INPUT TYPE="hidden" value = "" name="pagetype">
	<input type="hidden" name="hidCommentPage" value="benchmark">
</form>
</body>
</html>                       