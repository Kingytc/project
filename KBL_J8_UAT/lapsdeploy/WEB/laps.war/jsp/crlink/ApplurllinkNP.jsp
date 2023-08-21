<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
int pageid = Integer.parseInt(Helper.correctInt((String)request.getParameter("pageid")));
String credate = Helper.correctNull((String)session.getAttribute("createdate"));
String strdate = Helper.correctNull((String)ApplicationParams.getAppcreatedate());
long diff_intime = 0;
String prodcode = Helper.correctNull((String)session.getAttribute("productcode"));
String pagefromROInbox =Helper.correctNull((String)session.getAttribute("pagefromROInbox"));
String strOrgLevel = Helper.correctNull((String)session.getAttribute("strOrgLevel"));
String status  =Helper.correctNull((String)session.getAttribute("status"));

diff_intime = Helper.dateDiff(credate,strdate);
String strMisEnable=Helper.correctNull((String)hshValues.get("misenable"));
if(!strMisEnable.equalsIgnoreCase("")){
session.setAttribute("strMisEnable",strMisEnable);
}
String strnewscheme =Helper.correctNull((String)session.getAttribute("strnewscheme"));
String strAmountReq=Helper.correctNull((String)session.getAttribute("TabAmountRequest"));
String cicAmountCheck=Helper.correctNull((String)session.getAttribute("cicAmountCheck"));
String strLoanFor=Helper.correctNull((String)session.getAttribute("strLoanFor"));

//Added on 17-06-2021 CoBorrower Multiple Cic Check Section Starts
	ArrayList EducationCoBorrowerCICDataListRows=new ArrayList();
	ArrayList EducationCoBorrowerCICDataListCols=new ArrayList();
	EducationCoBorrowerCICDataListRows=(ArrayList)session.getAttribute("EducationCoBorrowerCICDataList");
//Added on 17-06-2021 CoBorrower Multiple Cic Check Section Ends
String CourseExpFlag=Helper.correctNull((String)session.getAttribute("CourseExpFlag"));
String CourseGrandTotal=Helper.correctNull((String)session.getAttribute("CourseGrandTotal"));
%>

<HTML>
<HEAD>
<TITLE> Application Form Navigation </TITLE>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript">
var pageid=parseInt("<%=pageid%>");
var pagefromROInbox= "<%=pagefromROInbox%>";
var varcicScoreCount="<%=Helper.correctNull((String)session.getAttribute("cicScoreCount"))%>";
var varstrAmountReq="<%=strAmountReq%>";
var varcicAmountCheck="<%=cicAmountCheck%>";
var varstrLoanFor="<%=strLoanFor%>";
var varAppStatus="<%=status%>";
var CourseExpFlag="<%=CourseExpFlag%>";
var CourseGrandTotal="<%=CourseGrandTotal%>";
//var selecttype="<%//=session.getAttribute("selecttype")%>";
//var selectpurpose="<%//=session.getAttribute("selectpurpose")%>";
	function gotoPage(pagename)
	{	 
			if(document.forms[0].cmdapply.disabled == false)
			{
				ShowAlert(103);
				return;
			}		
			if(pagename=="retailpge.jsp")
			{
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/retailpge.jsp"
			document.forms[0].submit();
			}
			if(pagename=="psb59perapplicantdispco.jsp")
			{
				//document.forms[0].hidBeanGetMethod.value="getDemographics";			
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/psb59perapplicantdispco.jsp?applnt=C&pageid=2";
				document.forms[0].method="post";
				document.forms[0].hidAppType.value="";
				document.forms[0].submit();
			}
			if(pagename=="perapplicantdispgua.jsp")
			{
			//document.forms[0].hidBeanGetMethod.value="getDemographics";			
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perapplicantdispco.jsp?applnt=G&pageid=9";
				document.forms[0].method="post";
				document.forms[0].hidAppType.value="";
				document.forms[0].submit();
			}
			else if(pagename=="NP_Perloandetails.jsp")
			{				
				document.forms[0].hidBeanGetMethod.value="getLoanProducts";
				document.forms[0].hidBeanId.value="NationalPortal";
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/NP_Perloandetails.jsp";
				document.forms[0].hidAppType.value="";
				document.forms[0].submit();
			}
			else if(pagename=="perfinancialbnkacc.jsp")
			{					
				document.forms[0].hidBeanGetMethod.value="getData";
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
				document.forms[0].hidAppType.value="";
				document.forms[0].submit();
			}
			else if(pagename=="percollateralhome.jsp")
			{					
				
				document.forms[0].hidBeanGetMethod.value="getData";
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
				document.forms[0].hidAppType.value="P";
				document.forms[0].submit();
				
			}
			else if(pagename=="perriskrating.jsp")
			//else if(pagename=="perriskanalysis.jsp")
			{
			if("<%=diff_intime%>" <= 0)
				{
				document.forms[0].hidBeanId.value="perrskana";
				document.forms[0].hidBeanGetMethod.value="getRiskAnalysis";
				//document.forms[0].hidBeanGetMethod.value="getData";
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
				document.forms[0].submit();	
			}
				else if("<%=diff_intime%>" > 0)
				{
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+"perriskanalysis.jsp";
				document.forms[0].submit();
				}				
			}
			else if(pagename=="NP_borrapptermsandcondns.jsp")
			{					
							
				//document.forms[0].hidBeanId.value="NationalPortal";

				if(varAppStatus == "op"){
					if(CourseExpFlag == "Y")
					{
						//alert("Proposed Loan Amount in LoanProduct page should be equal to Sum of Eligible Loan Amount in Course Expenses page");
						//return;
					}
					if(CourseGrandTotal == "Y")
					{
						//alert("Cost of Project in LoanProduct page should be equal to Sum of Grand Total(INR) in Course Expenses page");
						//return;
					}
				}
				document.forms[0].hidBeanGetMethod.value="getTerms";
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename+"?hidBeanId=NationalPortal&sel_termstype=C";
				document.forms[0].hidAppType.value="";
				document.forms[0].submit()
			}
			//added by kannan
		else if(pagename=="rskdynuserapp.jsp")
		{
			document.forms[0].hidBeanId.value="perglobalopt";
			document.forms[0].hidBeanGetMethod.value="getRiskApplicationData";		
			//document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
			document.forms[0].action="<%//=ApplicationParams.getAppUrl()%>action/rskdynuserapp.jsp?hidBeanGetMethod=getRiskApplicationData&hidBeanId=perglobalopt";
			document.forms[0].target="mainFrame";
			document.forms[0].submit();			
		}
		//end		
			else if(pagename=="comdocuments.jsp")
			{
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appdocumentsappl.jsp?hidBeanGetMethod=getData&hidAppDoc=A";
				document.forms[0].method="post";
				document.forms[0].submit();
	
			}
			else if(pagename=="NP_appworkflowhistory.jsp")
			{
				document.forms[0].hidBeanGetMethod.value="NationalPortal";
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
				document.forms[0].submit();
			}
			else if(pagename=="comnotes.jsp")
			{
				document.forms[0].hidBeanGetMethod.value="getData";
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appnotes.jsp";
				document.forms[0].submit();
				
			}
			else if(pagename=="np_edustudent.jsp")
			{
				
				if(varAppStatus!="pa" && varAppStatus!="ca")
				{
					if(varstrLoanFor=="EDU")
					{
						//added on 17-06-2021 for co-borrower Multiple CIC Check Section Starts
						<%
							if (EducationCoBorrowerCICDataListRows != null && EducationCoBorrowerCICDataListRows.size() > 0) {
								if (EducationCoBorrowerCICDataListRows.size() > 0) {
									for (int i = 0; i < EducationCoBorrowerCICDataListRows.size(); i++) {
										EducationCoBorrowerCICDataListCols = (ArrayList) EducationCoBorrowerCICDataListRows.get(i);
						%>
										var cicScoreCountForCoborrowerID="<%=Helper.correctNull((String) EducationCoBorrowerCICDataListCols.get(0))%>";
										var cicScoreCountForCoborrower="<%=Helper.correctNull((String) EducationCoBorrowerCICDataListCols.get(1))%>";
										if(parseInt(varstrAmountReq)<=parseInt(varcicAmountCheck))
										{
											if(cicScoreCountForCoborrower<1){
												//alert("Kindle obtain CIC score for at least one CIC as per circular 165/2020 in CIC Check available in LAPS Home Page and Link it in Education Loan-> Applicant-> Co-Applicant/Guarantor page for ID"+cicScoreCountForCoborrowerID);
												//return;
											}
										}
										if(parseInt(varstrAmountReq)>parseInt(varcicAmountCheck))
										{
											if(cicScoreCountForCoborrower<2){
												//alert("Kindle obtain CIC score for at least two CICs as per circular 165/2020 in CIC Check available in LAPS Home Page and Link it in Education Loan-> Applicant-> Co-Applicant/Guarantor page for ID"+cicScoreCountForCoborrowerID);
												//return;
											}
										}
						<%}}}%>
						//added on 17-06-2021 for co-borrower Multiple CIC Check Section ends
						if(parseInt(varstrAmountReq)<=parseInt(varcicAmountCheck))
						{
							if(varcicScoreCount<1){
								//alert("Kindle obtain CIC score for at least one CIC as per circular 165/2020 in CIC Check available in LAPS Home Page and Link it in Education Loan-> Applicant-> Co-Applicant/Guarantor page. ");
								//return;
							}
						}
						if(parseInt(varstrAmountReq)>parseInt(varcicAmountCheck))
						{
							if(varcicScoreCount<2){
								//alert("Kindle obtain CIC score for at least two CICs as per circular 165/2020 in CIC check available in LAPS Home Page and Link it in Education Loan-> Applicant-> Co-Applicant/Guarantor page. ");
								//return;
							}
						}
					}
				}
				document.forms[0].hidBeanGetMethod.value="getStudentParticularsData";
				document.forms[0].hidBeanId.value="NationalPortal";

				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/np_edustudent.jsp";
				document.forms[0].submit();
				
			}

			if( pagename=="reviewDocuments.jsp")
			{
				document.forms[0].hidBeanGetMethod.value="getReviewDocumentCibilData";
				document.forms[0].hidBeanId.value="commworkflow";
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/reviewDocuments.jsp";
				document.forms[0].submit();
			}
		
	}

	function menuOptionDivMouseDown (url) 
		{
			if(document.forms[0].cmdapply.disabled == true)
			{
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			document.forms[0].action=url;
			document.forms[0].submit();
			}
			else
			{
				ShowAlert(103);
			}
		}

function doClose()
{

	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
		appname=document.forms[0].appname.value;
		if("<%=session.getAttribute("link")%>" == "NEW")
		{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perborrowersearch.jsp?hidPageType=<%=session.getAttribute("link")%>";
		document.forms[0].submit();
		}
		else
		{
		document.forms[0].action=appURL+"action/"+"persearch.jsp?id=<%=session.getAttribute("comappid")%>&hidPageType=EXI&comapp_compname="+appname;
		document.forms[0].submit();
		}
	}

}
function onclose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
		appname=document.forms[0].appname.value;
		document.forms[0].action=appURL+"action/"+"persearch.jsp?id=<%=session.getAttribute("comappid")%>&hidPageType=<%=session.getAttribute("link")%>&comapp_compname="+appname;
		//alert(document.forms[0].action);
		document.forms[0].submit();
	}
}
var appUrl="<%=ApplicationParams.getAppUrl()%>";
function callMISBam()
{
	 document.forms[0].hidBeanId.value="HEVPCommWorkflow";
	 document.forms[0].hidBeanGetMethod.value="gethevpmisbam";
	 document.forms[0].action=appUrl+"action/misforall.jsp";
	 document.forms[0].submit();
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<style type="text/css">
<!--
a:hover {  color: #FF0000}
-->
</style>
</HEAD>
<BODY leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td valign="top" colSpan="5"> 
      <jsp:include page="../share/menus.jsp" flush="true"> </jsp:include>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" height="24" class="tabsBg">
  <tr> 
        <%if(pageid==1)
		  {%>
           
    <td width="4%" class="tabactive" align="center" nowrap> <font color="#FFFFFF"> <b><font size="1" face="MS Sans Serif">Applicant</font></b> 
      </font> </td>
      <%}
		  else
		  {%>
    <td width="4%" align="center" nowrap> <font color="#000000" class="unnamed1"> 
      <a href="javascript:gotoPage('NP_Perloandetails.jsp')" class="bluefont"> <b>Applicant 
      </b></a> </font> <b> 
      <%}%>
      </b> </td>
   
        <%if(pageid == 2)
		   {%>
         
    <td width="5%" class="tabactive" align="center" nowrap> <font color="#FFFFFF"> <b><font size="1" face="MS Sans Serif">Borrower's Profile 
      </font></b> </font> </td>
      <%}
			else
			{%>
    <td width="5%" align="center" nowrap> <font color="#000000" class="unnamed1"> 
      <a href="javascript:gotoPage('psb59perapplicantdispco.jsp')" class="bluefont"><b>Borrower's Profile 
      </b></a> </font> <b> 
      <%}%>
      </b> </td>
  <!--
        <%if(pageid == 3)
			{%>
	 
    <td width="4%" class="tabactive" align="center" nowrap> <font color="#FFFFFF"> <b><font size="1" face="MS Sans Serif">Asset & Liabilities/NF589</font></b> 
      </font> </td>
      <%}
			else
			{%>
    <td width="4%" align="center" nowrap> <font color="#000000" class="unnamed1"> 
      <a href="javascript:gotoPage('perfinancialbnkacc.jsp')" class="bluefont"><b>Asset & Liabilities/NF589 </b></a> 
      </font> <b> 
      <%}%>
      </b> </td>-->
       <%if(pageid == 12)
			{%>
		
    <td width="4%" class="tabactive" align="center" nowrap> <font color="#FFFFFF"> 
      <b><font size="1" face="MS Sans Serif">Edu Loan</font></b> </font> </td>
      <%}
			else
			{   // out.println(session.getAttribute("selecttypeedu"));
			 //out.println(session.getAttribute("selectpurposeedu"));
			
				
					
			%>
    <td width="4%" align="center" nowrap> <font color="#000000" class="unnamed1"> 
      <b><a href="javascript:gotoPage('np_edustudent.jsp')" class="bluefont">Edu 
      Loan</a></b> </font> 
      <%	
			} 
      %>
    </td>
         <%if(pageid == 10)
			{%>
			
    <td width="5%" class="tabactive" align="center" nowrap> <font color="#FFFFFF"> <b><font size="1" face="MS Sans Serif">Appraisal</font></b> 
      </font> </td>
      <%}
			else
			{%>
    <td width="5%" ALIGN="CENTER" nowrap> <font color="#000000" class="unnamed1"> 
      <a href="javascript:gotoPage('NP_borrapptermsandcondns.jsp')" class="bluefont"> 
      <b>Appraisal</b></a> </font> 
      <%}%>
    </td>

   <% if(diff_intime <=0){%>
       <% if(!(prodcode.equals("975"))&&!(prodcode.equals("935"))&&!(strnewscheme.equals("Y")) ){%> 
   <%if(pageid == 6)
			{%>
        		
    <td width="4%" class="tabactive" align="center" nowrap> <font color="#FFFFFF"> 
      <b><font size="1" face="MS Sans Serif">Risk Analysis</font></b> </font> </td>
      <%}else{%>
    <td width="6%" align="center" nowrap> <font color="#000000" class="unnamed1"> 
      <a href="javascript:gotoPage('rskdynuserapp.jsp')" class="bluefont"> <b>Risk 
      Analysis</b></a> </font> 
      <%}%>
    </td>
    <%} %>
    <!--<%if(pageid == 5)
			{%>
			
    <td width="4%" class="tabactive" align="center" nowrap> <font color="#FFFFFF"> 
      <b><font size="1" face="MS Sans Serif">Documents</font></b> </font> </td>
      <%}
			else
			{%>
    <td width="5%" align="center" nowrap> <font color="#000000" class="unnamed1"> 
      <a href="javascript:gotoPage('comdocuments.jsp')" class="bluefont"> <b>Documents</b></a> 
      </font> <b> 
      <%}%>
      </b> </td>
      --><%if(pageid == 7)
			{%>
		
    <td width="4%" class="tabactive" align="center" nowrap> <font color="#FFFFFF"> <b><font size="1" face="MS Sans Serif">Workflow</font></b> 
      </font> </td>
      <%}
		else
		{%>
    <td width="5%" align="center" nowrap> <font color="#000000" class="unnamed1"> 
      <a href="javascript:gotoPage('NP_appworkflowhistory.jsp')" class="bluefont"><b>Workflow</b></a> 
      </font> 
      <%}%>
    </td> 
    <%if(Helper.correctNull((String)session.getAttribute("strMisEnable")).equalsIgnoreCase("Y")){ %>
     <%if(pageid == 20)
			{%>
		
    <td width="4%" class="tabactive" align="center" nowrap> <font color="#FFFFFF"> <b><font size="1" face="MS Sans Serif">MIS BAM Details</font></b> 
      </font> </td>
      <%}
		else
		{%>
    <td width="5%" align="center" nowrap> <font color="#000000" class="unnamed1"> 
<!--       <a href="javascript:callMISBam()" class="bluefont"><b>MIS BAM Details</b></a>  -->
      </font> </td> 
      <%}}%>
  <%} %>   
  <!-- end --> 
    <!--  
       <%if(pageid == 4)
			{%>
       	 <td width="12%" class="tabactive" align="center"> <font color="#FFFFFF"> 
		<b><font size="1" face="MS Sans Serif">Coll.Security</font></b> 
        </font> 
        <%}
			else
			{%>
          <td width="12%" align="center"> 
		<font color="#000000" class="unnamed1"> <a href="javascript:gotoPage('percollateralhome.jsp')" class="blackfont"> 
        <b>Coll.Security</b></a> </font> <b> 
        <%}%>
        </b>
    </td> -->

        <!--<%if(pageid == 8)
			{%>
    <td width="3%" class="tabactive" align="center" nowrap> <font color="#FFFFFF"> <b><font size="1" face="MS Sans Serif">Notes</font></b> 
      </font> 
      <%}
			else
			{%>
    <td width="4%" align="center" nowrap> <font color="#000000" class="unnamed1"> <b><a href="javascript:gotoPage('comnotes.jsp')" class="bluefont">Notes</a></b> 
      </font> 
      <%}%>
    </td>
 	--><% if(pagefromROInbox.equals("fromROInbox") && strOrgLevel.equalsIgnoreCase("R"))
		{ 
		if(pageid==13)
		{%>
           
    <td width="4%" class="tabactive" align="center" nowrap> <font color="#FFFFFF"> <b><font size="1" face="MS Sans Serif">Review Documents</font></b> 
      </font> </td>
      <%}
		  else
		  {%>
    <td width="4%" align="center" nowrap> <font color="#000000" class="unnamed1"> 
      <a href="javascript:gotoPage('reviewDocuments.jsp')" class="bluefont"> <b>Review Documents 
      </b></a> </font> <b> 
      <%}}%>
      </b> </td>
	
	
	 <!--  
	   -->
  </tr>
  <tr> 
  
  </tr>
  
  
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td valign="top" colSpan="5" align="center"><font color="green" face="MS Sans Serif" size="2"><b>(ALL VALUES SHOULD BE IN RUPEES ONLY)</b></font>
    
    </td>
  </tr>
</table>


<input type="hidden" name="hiPgDist" value="P">
<INPUT TYPE="hidden" name="bowid" value="<%=Helper.correctNull((String)session.getAttribute("bowid"))%>">  
  
<input type="hidden" name="appno" value ="<%=session.getAttribute("appno")%>" >
</BODY>
</HTML>
