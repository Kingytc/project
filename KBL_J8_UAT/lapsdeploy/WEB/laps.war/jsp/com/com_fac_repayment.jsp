<%@include file="../share/directives.jsp"%>
<%@ page import="java.text.DecimalFormat"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
  if(objValues instanceof java.util.HashMap)
   {
	  hshValues=(java.util.HashMap)objValues;
   } 
	ArrayList vecmon = new ArrayList();
	ArrayList vecyear  = new ArrayList();
	int vecsize= 0;   
		
	String strMoratorium = Helper.correctNull((String)hshValues.get("Moratorium"));
	String strInstalment = Helper.correctNull((String)hshValues.get("Instalment"));
	String strPeriodicity = Helper.correctNull((String)hshValues.get("Periodicity"));
	String strDisbursement = Helper.correctNull((String)hshValues.get("Disbursement"));
	String strFacAmt = Helper.correctNull((String)hshValues.get("strDiff"));
	String strAmt = Helper.correctNull((String)hshValues.get("prin"));
	String COM_BANKSCHEME = Helper.correctNull((String)hshValues.get("COM_BANKSCHEME"));
	String strEnd=Helper.correctNull((String)hshValues.get("endon"));
	String strSchedule=Helper.correctNull((String)hshValues.get("comfacrepayment"));
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	
	String StrDigiLoanType=Helper.correctNull((String)session.getAttribute("StrDigiLoanType"));
	ArrayList arryRow=new ArrayList();
	ArrayList arryCol=new ArrayList();
	DecimalFormat dc=new DecimalFormat();
	dc.setGroupingUsed(false);
	dc.setMaximumFractionDigits(2);
	dc.setMinimumFractionDigits(2);
	String loanrepaydate = "0";

if(hshValues!=null)
{	
	vecmon = (ArrayList)hshValues.get("vecmon");
	vecyear = (ArrayList)hshValues.get("vecyear");
	if(vecmon!=null)
	{
		vecsize = vecmon.size();
	}
	 arryRow=(ArrayList)hshValues.get("arryRow");
}
String strBorrowerType =Helper.correctNull((String)request.getParameter("hidBorrowerType"));

String strCatName="";
if(strCategoryType.equals("CORPORATE")||strCategoryType.equals("CORP") )
{
	strCategoryType ="CORP";
	strCatName="Corporate";
	
}
else if(strCategoryType.equals("OPS"))
{
	strCatName="Tertiary";
}else if(strCategoryType.equals("SME") || strCategoryType.equals("SSI"))
{
	strCatName="Corporate";
}%>
<html>
<head>
<title>Repayment Schedule</title>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var facid ="<%=Helper.correctNull((String)hshValues.get("selfacility"))%>"; 
var strPeriodicity="<%=strPeriodicity%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var StrDigiLoanType="<%=StrDigiLoanType%>";

function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}

function doClose()
{
var cattype=document.forms[0].cattype.value;
	var id=document.forms[0].id.value;
 if(cattype=="OPS")
        {
       if(ConfirmMsg(100))
	 { 
		document.forms[0].action=appURL+"action/agrpage.jsp";
		document.forms[0].submit();
	 }
		}
		if((cattype=="CORP")||(cattype=="SME"))
        {
        if(ConfirmMsg(100))
	 {
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	 }
		}
}

function selectValues()
{
	document.forms[0].hidBeanId.value="comrepayschedule";
	document.forms[0].hidSourceUrl.value="/action/com_fac_repayment.jsp";
	document.forms[0].hidBeanMethod.value="updFacRepayment";
	document.forms[0].hidBeanGetMethod.value="getFacRepayment";
	document.forms[0].action=appUrl+"action/com_fac_repayment.jsp";
	document.forms[0].submit();
}

function doSave()
{
	document.forms[0].hidRecordflag.value = varRecordFlag;
	document.forms[0].cattype.value="<%=strCategoryType%>";
	
	if(document.forms[0].txt_moratorium.value=="")
		document.forms[0].txt_moratorium.value=0;
		
	var len = document.forms[0].selfacility.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].selfacility.options[i].selected==true)
		 {
			 document.forms[0].selfacility1.value = document.forms[0].selfacility.options[i].text; 
			break;
		 }
	}	
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="comrepayschedule";
	document.forms[0].hidSourceUrl.value="/action/com_fac_repayment.jsp";
	document.forms[0].hidBeanMethod.value="updFacRepayment";
	document.forms[0].hidBeanGetMethod.value="getFacRepayment";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit(); 
}

function disableCommandButtons()
{
		//document.forms[0].cmdedit.disabled=true;
		//document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=false;
		//document.forms[0].cmdcancel.disabled=false;		 
		document.forms[0].cmdclose.disabled=true;	 
		disableFields(false); 
}  

 function doEdit()
 {
	if(document.forms[0].selfacility.options[document.forms[0].selfacility.selectedIndex].value>0)
	{
		disableFields(false);
		document.forms[0].hidflag.value ="edit";
		document.forms[0].hidAction.value ="update";
		disableCommandButtons();
		document.forms[0].cmddelete.disabled=false;
	}
	else
	{
		alert("Select facility to edit");
	}
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="comrepayschedule";
		document.forms[0].hidBeanGetMethod.value="getFacRepayment";
		document.forms[0].action=appUrl+"action/com_fac_repayment.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
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
  		if(document.forms[0].elements[i].type=='textarea'  )
  		{
			document.forms[0].elements[i].readOnly=val;
  		}	 
 	} 
}

function doDelete()
{
	document.forms[0].cattype.value="<%=strCategoryType%>";
	if(varRecordFlag=="Y")
	{
	if(document.forms[0].selfacility.options[document.forms[0].selfacility.selectedIndex].value>0)
	{
		if(confirm("Do you want to delete"))
		{
			var len = document.forms[0].selfacility.length;	
			for(i=0;i<len;i++)
			{
				 if(document.forms[0].selfacility.options[i].selected==true)
				 {
					 document.forms[0].selfacility1.value = document.forms[0].selfacility.options[i].text; 
					break;
				 }
			}
			
			document.forms[0].hidAction.value ="delete";
			document.forms[0].hidBeanId.value="comrepayschedule";
			document.forms[0].hidSourceUrl.value="/action/com_fac_repayment.jsp";
			document.forms[0].hidBeanMethod.value="updFacRepayment";
			document.forms[0].hidBeanGetMethod.value="getFacRepayment";
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].submit();
		}
	}
	else
	{
		alert("Select Facilitity to delete");
	}
}
	else
	{
		ShowAlert(158);
	}
}
	
function onloading()
{	  
	disableFields(true);

	len = document.forms[0].selfacility.length;
	for(k=0;k<len;k++)
	{
		val = document.forms[0].selfacility.options[k].value;
		if(val==facid)
		{
			document.forms[0].elements["selfacility"].options[k].selected=true;
			document.forms[0].selperiodicity.disabled=true;
			break;
		}
	}
	if(document.forms[0].readFlag.value.toUpperCase()=="R")
	{
		document.forms[0].selperiodicity.disabled=true;
	}
	if(document.forms[0].selfacility.value=="")
	   document.forms[0].cmdannexture.disabled=true;
	else
		document.forms[0].cmdannexture.disabled=false;
}

function call_page(url,method,type)
{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?type="+type;
	document.forms[0].submit();
}

function call_page_diff(url,bean,method)
{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
	document.forms[0].submit();
}


function callTermAssesement(beanid,methodname,pagename,type)
{
		
	if(type=="COP")
	{
	document.forms[0].hidBeanId.value=beanid;
	document.forms[0].hidBeanGetMethod.value=methodname;
	document.forms[0].action=appURL+"action/"+pagename+"?hidPageSource="+type;
	document.forms[0].submit();
	}
	else
	{
	document.forms[0].hidBeanId.value=beanid;
	document.forms[0].hidBeanGetMethod.value=methodname;
	document.forms[0].action=appURL+"action/"+pagename;
	document.forms[0].flowtype.value=type;
	document.forms[0].submit();
	}
	
}
function gototab(beanid,methodname,pagename,type)
{
		
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].flowtype.value=type;
		document.forms[0].submit();
	
} 
function callcopmof()
{
	
		document.forms[0].method="post";
		document.forms[0].action=appUrl+"action/com_termloanassesment.jsp";
		document.forms[0].submit();
	
}
function callReleasePattern(beanid,methodname,pagename)
{
	document.forms[0].hidBeanId.value=beanid;
	document.forms[0].hidBeanGetMethod.value=methodname;
	document.forms[0].action=appURL+"action/"+pagename;
	document.forms[0].submit();
}
function doAnnexture()
{
	var varQryString = appURL+"action/Amortization_NonEmi.jsp?hidBeanGetMethod=getFacRepayment&hidBeanId=comrepayschedule&hidrepaymenttype=amort&pageFrom=emi&appno="+document.forms[0].appno.value+"&selfacility="+document.forms[0].selfacility.value;
	var title = "Amortization";
	var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString,title,prop);
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
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
<form name="frmpri" method = "post" class="normal">
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="28" />
			<jsp:param name="subpageid" value="108" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%}else{ %>
<%if(strCategoryType.equalsIgnoreCase("OPS")){
%>
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
	<tr>
	 <td class=page_flow>Home -&gt; Tertiary -&gt; Application  -&gt; Securities -&gt; Repayment Schedule </td>
	 </tr>
</table>	
 <span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/>
<%} else{ %>
              <jsp:include page="../com/proposallinks.jsp" flush="true"> 
              <jsp:param name="pageid" value="28" />
			   <jsp:param name="cattype" value="<%=strCategoryType%>" />
			  <jsp:param name="ssitype" value="<%=strSSIType%>" />

	           </jsp:include>   
	           
	           
	           
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
		<tr>
  <%if(strSessionModuleType.equalsIgnoreCase("AGR")){%>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Proposal -&gt;Repayment Schedule -&gt; Repayment Schedule for EMI</td>
	<%}else{%>
		<td class="page_flow">Home -&gt; Corporate &amp; SME-&gt;Proposal -&gt;Repayment Schedule  -&gt; Repayment Schedule for EMI</td>
		<%} %>	
		</tr>
</table>	

	            
	           
	          
 
  
<span style="display:none;"><lapschoice:borrowertype /></span> <lapschoice:application/>
<%} %>
	        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	          <tr>
				<td> 
			<table width="50%" border="0" cellspacing="1" cellpadding="3" class="outertable">
				<tr>					
		            <td align="center" class="sub_tab_active"><b>Repayment Schedule for EMI</b></td>
		            <td class="sub_tab_inactive" align="center"><a
					href="javascript:gotoTab(appUrl,'comrepayschedule','getFacNonEMIRepayment','com_fac_repaymentnonemi.jsp')"><b>Repayment Schedule for Non-EMI</b></a></td>
					<%if(StrDigiLoanType.equals("") && COM_BANKSCHEME.equalsIgnoreCase("052")){%>	
					<td class="sub_tab_inactive" align="center"><a 	href="javascript:gotoTab(appUrl,'appraisal','getCreditSalesData','com_creditsales.jsp')"><b>Reason for Manual Processing</b></a></td>
					<%} %>	
				 <td class="sub_tab_inactive" align="center"><a
					href="javascript:gotoTab(appURL,'comproposal','getDataComments','com_repaycomment.jsp')"><b>Terms of Repayment</b></a></td>
				</tr>
			</table>
				</td>
			</tr>
	        </table>
	        <%} %>
     <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
    <td>
   <table width="100%" border="0" cellspacing="2" cellpadding="2" class="outertable border1">
        <tr> 
        <td>
      <table width="100%" border="0" cellspacing="2" cellpadding="2" class="outertable">
      <tr>
      <td colspan="7" class="mantatory"><b>Note : All values are in Rupees</b></td>
      </tr>
        <tr> 
          <td width="25%">Term Finance Facilities</td>
          <td width="27%"> 
            <select name="selfacility" onchange="selectValues()">
              <option value="">---Select---</option>
              <lapschoice:termfinancefac pagename="EMI"/> 
            </select>
          </td>
          <td width="30%">Loan amount</td>
          <td colspan="4"><B>&nbsp;</B>&nbsp;<%=strFacAmt%></td>
        </tr>
        <tr> 
          <td width="25%">Moratorium (Months)</td>
          <td width="27%"> 
            <input type="text" name="txt_moratorium" value="<%=strMoratorium%>" onkeypress="allowInteger()">
          </td>
          <td width="30%">No of Installments</td>
          <td width="18%" colspan="4"> 
            <input type="text" name="txt_noofinstalmt" value="<%=strInstalment%>" onkeypress="allowInteger()">
          </td>
        </tr>
        <tr> 
          <td width="25%">Repayment Periodicity</td>
          <td width="27%"> 
            <select name="selperiodicity">
              <option value="">Select </option>
              <%	if(strPeriodicity.trim().equalsIgnoreCase("M")) 
				{
			%>
              <option selected value="M">Monthly</option>
              <%	}
				else 
				{
			%>
              <option value="M">Monthly</option>
              <%	}
				if(strPeriodicity.trim().equalsIgnoreCase("Q")) 
				{	
			%>
              <option selected value="Q">Quarterly</option>
              <%	}
				else 
				{
			%>
              <option value="Q">Quarterly</option>
              <%	}
				if(strPeriodicity.trim().equalsIgnoreCase("H")) 
				{	
			%>
              <option selected value="H">Half-Yearly</option>
              <%	}
				else 
				{
			%>
              <option  value="H">Half-Yearly</option>
              <%	}
				if(strPeriodicity.trim().equalsIgnoreCase("Y")) 
				{	
			%>
              <option selected value="Y">Yearly</option>
              <%	}
				else 
				{
			%>
              <option  value="Y">Yearly</option>
              <%	}
				if(strPeriodicity.trim().equalsIgnoreCase("C")) 
				{	
			%>
              <option value="C" selected>Customise</option>
              <%	}
				else 
				{
			%>
              <option  value="C">Customise</option>
              <%	}
			
			
			%>
            </select>
          </td>
          <td width="30%">First disbursement on</td>
          <td width="18%" colspan="4"> 
            <input type="text" name="txt_disbursement" value="<%=strDisbursement%>" onblur="checkDate(this)" readOnly>
            <a alt="Select date from calender"  href="javascript:callCalender('txt_disbursement')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0" ></a> 
          </td>
        </tr>
<!--        <tr id="show"> -->
<!--          <td align="center">Repay end on Date-->
<!--              <input type="text" name="txt_endon" onBlur="checkDate(txt_endon)" value="<%=strEnd%>">-->
<!--          </td>-->
<!--          <td  id="showtext">Repayment Schedule -->
<!--            </td>-->
<!--          <td colspan="4"> -->
<!--            <textarea name="txt_schedule" cols="60" rows="5"><%=strSchedule%></textarea>-->
<!--          </td>-->
<!--        </tr>-->
      </table>
      </td>
      </tr>
      </table>
    <br>
    <table width="1%" border="0" cellspacing="0" cellpadding="2" align="center" class="">
    <tr> 
    <!--   <td >
          <input type="button" name="Annexture" value="Annexture" class="buttonStyle"  onClick="doAnnexture();">
      </td> -->
      <td >
	<lapschoice:combuttonnew  btnnames='Annexture' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
	</td></tr></table>
        <br>
<table width="70%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor" align="center">
          <tr class="dataheader"> 
            <td width="9%" align="center"> 
              <b>Month</b>
            </td>
            <td width="16%" align="center"> 
              <b>Loan Amount OS</b>
            </td>
            <td width="15%" align="center"> 
              <b>Interest Amt</b>
            </td>
            <td width="15%" align="center"> 
              <b>Principal Amt</b>
            </td>
            <td width="10%" align="center"> 
              <b>EMI</b>
            </td>
            <td width="15%" align="center"> 
             <b>Actual Amt Due</b>
            </td>
             <td width="22%" align="center" nowrap="nowrap"> 
              <b>Due Date of Installment</b>
            </td>
            
          </tr>
          <% 
        if(arryRow!=null && arryRow.size()>0)
		  {
			  String Datevalue="";
              String installment=Helper.correctNull((String)hshValues.get("loan_noofinstallment"));
              String strInterestcharged=Helper.correctNull((String)hshValues.get("sel_interestcharge"));
              int x=0;
               x=Integer.parseInt(installment)+1;
             
			  String pdate = Helper.correctNull((String)hshValues.get("txt_date"));
			
	  		  String duedate = "";
	  		  int  pdays =  Integer.parseInt(pdate.substring(0,2));
	  		  int pdays1=pdays;
	  		  int leaps = 0;
			  int  pmonths= Integer.parseInt(pdate.substring(3,5));
			 
	  		 int  pyears = Integer.parseInt(pdate.substring(6,10));
	  		if(!strInterestcharged.equalsIgnoreCase("2"))
	  			pmonths=pmonths+x;
	  		else
	  			pmonths=pmonths+1;
	  		if(pmonths>12)
			{
	  			int tempyear=pmonths/12;
	  			
	  			
				pmonths =pmonths%12;
				if(pmonths==0)
				{
					pmonths=12;
					tempyear--;
				}
				pyears = pyears +tempyear;
			}          
			for(int i=0;i<arryRow.size()-1;i++)
			{
				arryCol=(ArrayList)arryRow.get(i);
				if(arryCol!=null)
				{
					
					if(pmonths==1 || pmonths==3 || pmonths==5 || pmonths==7 || pmonths==8 || pmonths==10 || pmonths==12)
					{
						
							if(pdays==31)
						{
			 			pdays = pdays+0;
			 			pdays1=31;
						}
						else
						{
							pdays1=pdays;
						}
						
					}
					else if(pmonths==4 || pmonths==6 || pmonths==9 || pmonths==11)
					{
						if( pdays==31 || pdays1==30 )
						{
			 			pdays = pdays+0;
			 			pdays1=30;
						}
						else
						{
							pdays1=pdays;
						}
						
					
					}	
						leaps = pyears%4;
						 if((pmonths==2)&& (leaps==0))
							
						{	if(pdays==31 || pdays==30 || pdays==29 )
							{
							pdays1=29;
							}
						else
							{
								pdays1=pdays;
							}
						}
						else if(pmonths==2)
						{
							if(pdays==31 || pdays==30 || pdays==29 || pdays==28)
							{
							pdays1=28;
							}
							else
							{
								pdays1=pdays;
							}
						}
		
					if (pmonths<10)
					{
							duedate = Integer.toString(pdays1)+"/0"+Integer.toString(pmonths)+"/"+Integer.toString(pyears);
					}
					else
					{
							duedate = Integer.toString(pdays1)+"/"+Integer.toString(pmonths)+"/"+Integer.toString(pyears);
					}
					
					pmonths = pmonths + 1;
					if (pmonths>12)
					{
						pmonths = 1;
						pyears = pyears + 1;
					}
					loanrepaydate=duedate;
					if(i==0)
		 			{
		 				Datevalue = duedate; 
		 			}
					
		  %>
          <tr class="datagrid"> 
            <td width="9%" align="center"><%=(Integer)arryCol.get(0)%></td>
            <td width="16%" align="right"><%=dc.format((Double)arryCol.get(1))%></td>
            <td width="15%" align="right"><%=dc.format((Double)arryCol.get(2))%></td>
            <td width="15%" align="right"><%=dc.format((Double)arryCol.get(3))%></td>
            <td width="10%" align="right"><%=dc.format((Double)arryCol.get(4))%></td>
            <td width="10%" align="right"><%=dc.format((Double)arryCol.get(5))%></td>
            <td width="22%" align="center"><%=duedate%></td>
            
          </tr>
          <%
				}
			}
			arryCol=(ArrayList)arryRow.get(arryRow.size()-1);
			if(arryCol!=null)
			{
			%>
          <tr class="dataheader"> 
            <td width="9%" align="center"><%=(String)arryCol.get(0)%></td>
            <td width="17%">&nbsp;</td>
            <td width="15%" align="right"><%=dc.format((Double)arryCol.get(1))%></td>
            <td width="15%" align="right"><%=dc.format((Double)arryCol.get(2))%></td>
            <td width="10%" align="right"><%=dc.format((Double)arryCol.get(3))%></td>
            <td width="10%">&nbsp;</td>
			<td width="18%">&nbsp;</td>
          </tr>
          <%
			}
	
		  }
		  %>
        </table>
    </td>
    </tr>
    </table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="selfacility1">
<input type="hidden" name="hidflag" value="">
<input type="hidden" name="selsno" value="">
<input type="hidden" name="hidval" >
<input type="hidden" name="hiddesc" >
<input type="hidden" name="flowtype"/>
<input type="hidden" name="cattype" value=""/>
<input type="hidden" name="pagefrom">
<input type="hidden" name="pagetype" value="repaycomment">
<INPUT TYPE="hidden" name="strAssessment" value = "<%=request.getParameter("strAssessment")%>">
<input type="hidden" name="cmdsave" disabled="disabled">
</form>
</body>
</html>
