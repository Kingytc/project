<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>

<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<%
  if(objValues instanceof java.util.HashMap)
   {
	  hshValues=(java.util.HashMap)objValues;
   }
	//out.println("hshValues-ttetetet--"+hshValues);
	Vector vecData = new Vector();
	Vector vecRow  = new Vector();
	int vecsize=0;
	if(hshValues!=null)
	{
		vecData = (Vector)hshValues.get("vecData");
	}

	java.text.DecimalFormat nf = new java.text.DecimalFormat();
	nf.setGroupingUsed(true);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	String CourseExpFlag=Helper.correctNull((String)hshValues.get("CourseExpFlag"));
	session.setAttribute("CourseExpFlag",CourseExpFlag);
	String CourseGrandTotal=Helper.correctNull((String)hshValues.get("CourseGrandTotal"));
	session.setAttribute("CourseGrandTotal",CourseGrandTotal);
	String strCheck=Helper.correctNull((String)hshValues.get("strCheck"));

%>


<html>

<head>
<title>Commercial-Principal (s)</title>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var strappeditsameregbranch="<%=session.getAttribute("HRBranchUserEdit")%>";
var varAppholder="<%=session.getAttribute("AppHolder")%>";
var varUserId= "<%=session.getAttribute("strUserId")%>";
var varAppno= "<%=request.getParameter("appno")%>";
var varCostOfProj="<%=Helper.correctNull((String) hshValues.get("loan_costloanprd"))%>";
function callhelp()
{
		   var varQryString = appUrl+"/jsp/perhlp/hlp_educourse.jsp";
		   var title = "ApplicantDemographics";
			var prop = "scrollbars=no,width=600,height=450";	
			prop = prop + ",left=200,top=150";
			window.open(varQryString,title,prop);
}
function callLink(page,bean,method)
{	
	
	if (document.forms[0].cmdapply.disabled)
	{
	 //document.forms[0].hidAction.value="";
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
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
		document.forms[0].action=appURL+"action/"+"comsearch.jsp";
		document.forms[0].submit();
	}

}
function selectValues(sno)
{
	document.forms[0].hidAction.value = "edit";	
	document.forms[0].selsno.value = sno;
	//document.forms[0].chkbob.checked=false;
	document.forms[0].selyear.disbled=true;
	appno=document.forms[0].appno.value;
	//alert("sno---"+sno);
	if(sno!="")
	{	document.all.ifrm.src=appUrl+"action/iframeeducourse_NP.jsp?hidBeanId=NationalPortal&appno="+appno+"&selsno="+sno+"&hidBeanGetMethod=getCourseExpensesData&hidAction=edit";
	}
	disableCommandButtons("radioselect")
}

 function doSave()
 {

	 if(varAppholder!=varUserId&&varAppno!="")
		{	
			alert("Your Not The Holder of the Application to Modify The Application");
			return;
		}	
	 else{
		 
 	if(checktrim(document.forms[0].selyear.value)=="0")
	{
		  ShowAlert(111,'Year');
	}
	

	
	else
	 {
		
		document.forms[0].selyear.disabled=false;
		document.forms[0].hidBeanId.value="NationalPortal";
		
		document.forms[0].hidSourceUrl.value="/action/np_educourse.jsp";
		document.forms[0].hidBeanMethod.value="updateCourseExpensesData";
		document.forms[0].hidBeanGetMethod.value="getCourseExpensesData";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
 }
 }
  function disableCommandButtons(val)
  {
	  
	  if(val=="load")
	  {  
		  disableFields(true);
		  document.forms[0].cmdnew.disabled =false;
		  document.forms[0].cmdedit.disabled=true;
		  document.forms[0].cmddel.disabled=true;
		  document.forms[0].cmdapply.disabled=true;
		  document.forms[0].cmdcancel.disabled=true;
		  document.forms[0].cmdclose.disabled=false;
		  //
	  }
	 
	  if(val=="edit")
	  {
		  
		  document.forms[0].cmdnew.disabled =true;
		  document.forms[0].cmdedit.disabled=true;
		  document.forms[0].cmddel.disabled=true;
		  document.forms[0].cmdapply.disabled=false;
		  document.forms[0].cmdcancel.disabled=false;		 
		  document.forms[0].cmdclose.disabled=true;	 
		  disableFields(false);
		// document.forms[0].bank.disabled=true;
		//  document.forms[0].bank.focus();
	  }

	  if(val=="radioselect")
	  {	  document.forms[0].cmdnew.disabled =false;
		  document.forms[0].cmdedit.disabled=false;
		  document.forms[0].cmddel.disabled=false;
		  document.forms[0].cmdapply.disabled=true;
		  document.forms[0].cmdcancel.disabled=true;
		  document.forms[0].cmdclose.disabled=false;
	  }	  
 }  

  function doEdit()
  {
 	
	disableFields(false);
	document.forms[0].hidflag.value ="edit";
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
	//document.forms[0].bank.disbled=true;
	

 }

  function doNew()
  {
	  disableFields(false);
	  disableCommandButtons("edit");
	  document.forms[0].selyear.value="0";
	   document.forms[0].selyear.disabled=false;
	 
	  document.forms[0].tution.value="";
	  document.forms[0].exam.value="";
	  document.forms[0].books.value="";
	  document.forms[0].lodge.value="";
	  document.forms[0].lab.value="";
	  document.forms[0].scholar.value="";
 	  document.forms[0].trvexp.value="";
	
	  document.forms[0].selyear.focus();
	  document.forms[0].hidflag.value ="new";
	  document.forms[0].hidAction.value ="insert";
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  if(document.forms[0].elements[i].type=='radio'  )
		  {
			document.forms[0].elements[i].checked=false;
		  }	  
	  }
   }

function fill()
{
	if (document.forms[0].chkbob.checked==true)
	{
		
		document.forms[0].lmtfunded.value=document.forms[0].aa.value;
		document.forms[0].lmtnonfunded.value=document.forms[0].cc.value;
		document.forms[0].lmtfundedprop.value=document.forms[0].bb.value;
		document.forms[0].lmtnonfundedprop.value=document.forms[0].dd.value;
		document.forms[0].bank.value="1";
		disableCommandButtons("edit");
		document.forms[0].lmtfunded.readOnly=true;
		document.forms[0].lmtnonfunded.readOnly=true;
		document.forms[0].lmtfundedprop.readOnly=true;
		document.forms[0].lmtnonfundedprop.readOnly=true;
		document.forms[0].bank.disabled=true;
		document.forms[0].osfunded.value="";
		document.forms[0].osnonfunded.value="";
		document.forms[0].osfundedprop.value="";
		document.forms[0].osnonfundedprop.value="";
		
			
		document.forms[0].overdue.value="";
		document.forms[0].osdate.value="";
		
	 for(var i=0;i<document.forms[0].length;i++)
	  {
		  if(document.forms[0].elements[i].type=='radio'  )
		  {
			document.forms[0].elements[i].checked=false;
			
						
		  }	  
	  }
	 for(var i=0;i<document.forms[0].length;i++)
	  {
		  if(document.forms[0].elements[i].name=='hid'  )
		  {
			//alert(document.forms[0].elements[i].value);
			if(document.forms[0].elements[i].value==1)
			{
				document.forms[0].hidAction.value ="update";
				
				break;
			}
			else
			{
				document.forms[0].hidAction.value ="insert";	
			}
									
		  }	  
	  }	
	
			
		
		
	}
	else

	{
		doNew();
		disableCommandButtons("load");
		document.forms[0].idno.value="";
		document.forms[0].osdate.value="";
	}
	
}

  function doCancel()
  {
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="NationalPortal";
		document.forms[0].hidBeanGetMethod.value="getCourseExpensesData";
		document.forms[0].action=appUrl+"action/np_educourse.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
  }

  function disableFields(val)
  {
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  if(document.forms[0].elements[i].type=='text')
		  {
			document.forms[0].elements[i].readOnly=val;
		  }	  
		  if(document.forms[0].elements[i].type=='select-one')
		  {
			document.forms[0].elements[i].disabled=val;
		  }	 
	  }
	  
  }

  function doDelete()
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updateCourseExpensesData";
		document.forms[0].hidBeanId.value="NationalPortal";
		document.forms[0].hidSourceUrl.value="action/np_educourse.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();		
	}


	
function onloading()
{	  
	disableCommandButtons("load");
	
	document.forms[0].selyear.readOnly=true;
	if (document.forms[0].appstatus.value != "Open/Pending")
	{
		alert("Cannot modify --> APPROVED APPLICATION !!!")
		callDisableControls(true,true,true,true,true,false)
	}else{
		if(strappeditsameregbranch!="")
		{
			if(strappeditsameregbranch=="disablefalse")
			{
				callDisableControls(false,true,true,true,true,false);
			}
			else if(strappeditsameregbranch=="disabletrue")
			{
				callDisableControls(true,true,true,true,true,false);
			}
		}
		}

}

function callDisableControls(cmdNew,cmdEdit,cmdApply,cmdDelete,cmdCancel,cmdClose)
{
	document.forms[0].cmdnew.disabled=cmdNew;
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdapply.disabled=cmdApply;
	document.forms[0].cmddel.disabled=cmdDelete;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
}
function call_page(url)
{
	
	document.forms[0].action=appUrl+"action/"+url;
	document.forms[0].submit();
	
}

function showappholder()
{
	if((document.forms[0].hid_appholder.value=="N") || (document.forms[0].appstatus.value=="Processed/Rejected") || (document.forms[0].appstatus.value=="Processed/Approved"))
	{
		callDisableControls(true,true,true,true,true,false);
	}	
}


</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
a:hover {  color: #FF3300}
td{font-family: "MS Sans Serif"; font-size: 10px;}

-->
DIV.cellContainer {	
  width: 100%; height: 250;
  overflow: auto;
}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" class="bgcolor" onload="onloading();showappholder();">
<form name="frmpri" method = post>
  <jsp:include page="../share/help.jsp" flush="true"> </jsp:include>
  <iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
  <table width="100%" border="1" cellspacing="0" cellpadding="0" class="outertablecolor"  bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colSpan=5> 
              <jsp:include page="../share/menus.jsp" flush="true"> </jsp:include>
                <jsp:include page="../nationalportal/ApplurllinkNP.jsp" flush="true"> 
				 <jsp:param name="pageid" value="12" />
				 </jsp:include>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <font face="Times New Roman" size="3"><b><i>Home  -&gt; Retail -&gt; Existing -&gt; Educational Course  
  Loans</i></b></font><br>
  <span style="visibility:hidden"><laps:borrowertype /></span> <laps:application/>
  
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertablecolor">
  
    <tr> 
      <td> 
       <table width="100%" border="0" cellspacing="3" cellpadding="3" align="left">
          <tr> 
              <td width="20%" align="center" class="tabinactive" id="prm"> <b><font size="1" face="MS Sans Serif" color="#FFFFFF"><a href="javascript:callLink('np_edustudent.jsp','NationalPortal','getStudentParticularsData')" class="blackfont">Particulars of Student</a></font></b> </td>
            <td width="20%" align="center" class="tabinactive" id="com2"><a href="javascript:callLink('np_edueducational.jsp','NationalPortal','getEducationalDetailsData')" class="blackfont"><b><font size="1" face="MS Sans Serif">Educational Details</font></b></a></td>
            <td width="20%" align="center" class="tabinactive" id="com2"> <a href="javascript:callLink('np_eduscholarship.jsp','NationalPortal','getScholarshipData')" class="blackfont"><b><font size="1" face="MS Sans Serif">Scholarship </font></b></a></td>
            <td width="20%" align="center" class="tabinactive" id="com2"><a href="javascript:callLink('np_eduparticulars.jsp','NationalPortal','getCourseDetailsData')" class="blackfont"><b><font size="1" face="MS Sans Serif">Course Details </font></b></a></td>
            <td width="20%" align="center" class="tabactive" id="com2"><font size="1" face="MS Sans Serif"><b>Course Expenses </b</font></td>
                      </tr>
                    </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="1" cellpadding="5" cellspacing="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" class="outertablecolor">
    <tr> 
      <td> 
        <table width="100%" border="1" cellspacing="0" cellpadding="2" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
                      <tr> 
                        <td> 
                          <table width="100%" border="1" cellspacing="0" cellpadding="2" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
                            <tr align="center" class="tabactive"> 
                              <td width="8%"><font face="MS Sans Serif" size="1" color="#FFFFFF">Year</font></td>
                              <td colspan="6	"><font face="MS Sans Serif" size="1" color="#FFFFFF">Purpose</font></td>
                              <td width="11%"><font size="1" face="MS Sans Serif" color="#FFFFFF">Scholarship/Stipend</font></td>
                              <td width="11%"><font size="1" face="MS Sans Serif" color="#FFFFFF">own source/Student Margin</font></td>
                            </tr>
                            <tr align="center" bgcolor="#FFFFFF"> 
                              <td width="8%">&nbsp;</td>
                              <td width="13%" align="center" valign="middle"> 
                                Tution fees 
                                <input type="hidden" name="idno" value="">
                              </td>
                              <td width="15%"><font face="MS Sans Serif" size="1">Exam fee</font></td>
                              <td width="11%"><font face="MS Sans Serif" size="1">Equipment</font></td>
                              <td width="11%"><font face="MS Sans Serif" size="1">Boarding/Lodging</font></td>
								<td width="11%"><font face="MS Sans Serif" size="1">Other Expenses</font></td>
								<td width="11%"><font face="MS Sans Serif" size="1">Cost 
                                of books etc</font></td>
                              <td width="11%" valign="middle">&nbsp; </td>
                              <td width="11%" valign="middle">&nbsp; </td>
                            </tr>
                            <tr align="center" bgcolor="#FFFFFF"> 
                              <td width="8%"> 
                                <select name="selyear">
                                  <option value="0" selected>Select</option>
                                  <option value="1">1 st year</option>
                                  <option value="2">2 nd year</option>
                                  <option value="3">3 rd year</option>
                                  <option value="4">4 th year</option>
                                  <option value="5">5 th year</option>
                                  <option value="6">6 th year</option>
                                </select>
                              </td>
                              <td width="13%" align="center" valign="middle"> 
                                <input type="text" name="tution" value="" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" maxlength="15"  size="15" style="text-align:right">
                              </td>
                              <td width="15%"> 
                                <input type="text" name="exam" value="" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" size="12" maxlength="12" style="text-align:right" >
                              </td>
                              <td width="11%"> 
                                <input type="text" name="lab" value="" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" size="12" maxlength="12" style="text-align:right"  >
                              </td>
                              <td width="11%"> 
                                <input type="text" name="lodge" value="" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" size="12" maxlength="12" style="text-align:right" >
                              </td>
							   <td width="11%" valign="middle"> 
                                <input type="text" name="trvexp" value="" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" size="12" maxlength="12" style="text-align:right"  >
                              </td>
                              <td width="11%"> 
                                <input type="text" name="books" value="" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" size="12" maxlength="12" style="text-align:right" >
                              </td>
							  <td width="11%" valign="middle"> 
                                <input type="text" name="scholar" value="" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" size="12" maxlength="12" style="text-align:right"  >
                              </td>
                              <td width="11%" valign="middle"> 
                                <input type="text" name="ownSource" value="" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" size="12" maxlength="12" style="text-align:right"  >
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td> 
                          <table width="12%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" class="outertablecolor">
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="2">
                                  <tr valign="top"> 
                                    <td width="0"> 
                                      <div align="center"> 
                                        <input type="button" name="cmdnew" value="New" style="width:50" class="buttoncolor" onClick="doNew()">
                                      </div>
                                    </td>
                                    <td width="0"> 
                                      <div align="center"> 
                                        <input type="button" name="cmdedit" value="Edit" style="width:50" class="buttoncolor" onClick="doEdit()">
                                      </div>
                                    </td>
                                    <td width="0"> 
                                      <div align="center"> 
                                        <input type="button" name="cmdapply" value="Apply" style="width:50" class="buttoncolor" onClick="doSave()">
                                      </div>
                                    </td>
                                    <td width="0"> 
                                      <div align="center"> 
                                        <input type="button" name="cmdcancel" value="Cancel"  style="width:50" class="buttoncolor" onClick="doCancel()">
                                      </div>
                                    </td>
                                    <td width="0"> 
                                      <input type="button" name="cmddel" value="Delete"  style="width:50" class="buttoncolor" onClick="doDelete()">
                                    </td>
                                    <td width="0"> 
                                      <input type="button" name="cmdhelp2" value="Help"  style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="callhelp()">
                                    </td>
                                    <td width="0"> 
                                      <input type="button" name="cmdclose" value="Close"  style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="doClose()">
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="1" cellpadding="2" >
                            <%
	if(vecData!=null)
	{
	%>
                            <tr class="tabactive"> 
                              <td width="3%">&nbsp;</td>
                              <td width="6%" align="center"><font color="#FFFFFF">Year</font></td>
                              <td colspan="6" align="center"><font face="MS Sans Serif" size="1" color="#FFFFFF">Purpose</font></td>
                              <td width="10%" align="center"> 
                                <p><font size="1" face="MS Sans Serif" color="#FFFFFF">Grand total (INR)</font></p>
                              </td>
                              <td width="10%" align="center"><font size="1" face="MS Sans Serif" color="#FFFFFF">Scholarship/Stipend</font></td>
                              <td width="10%" align="center"><font size="1" face="MS Sans Serif" color="#FFFFFF">Own Source/Student Margin</font></td>
                              <td width="10%" align="center"><font color="#FFFFFF">Amount of Eligible Loan</font></td>
                            </tr>
                            <tr class="tabactive"> 
                              <td width="3%">&nbsp;</td>
                              <td width="6%">&nbsp;</td>
                              <td width="10%" align="center"><font face="MS Sans Serif" size="1" color="#FFFFFF">Tution 
                                Fee </font></td>
                              <td align="center" width="8%"><font size="1" face="MS Sans Serif" color="#FFFFFF">Exam Fee</font></td>
                              <td align="center" width="8%"><font size="1" face="MS Sans Serif" color="#FFFFFF">Equipment</font></td>
                              <td align="center" width="8%"><font size="1" face="MS Sans Serif" color="#FFFFFF">Boarding/Lodging</font></td>
								 <td align="center" width="8%"><font size="1" face="MS Sans Serif" color="#FFFFFF">Other Expenses</font></td>
								 <td align="center" width="8%"><font size="1" face="MS Sans Serif" color="#FFFFFF">Cost 
                                of books etc</font></td>
                              <td width="10%" align="center">&nbsp;</td>
                              <td width="10%" align="center">&nbsp;</td>
                              <td width="10%" align="center">&nbsp;</td>
                              <td width="10%" align="center">&nbsp;</td>
                            </tr>
                           
                            <%
				vecsize = vecData.size();
	//out.println("vecsize"+vecsize);
			}
			String strSno="";
			
		java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
			double dblTottution=0.00;
			double dblTotexam=0.00;
			double dblTotbook=0.00;
			double dblTotlodge=0.00;

			double dblTotlab=0.00;
			double dblTotexp=0.00;
			double dblTotscholar=0.00;
			double dblTotreq=0.00;

			double dbltrvexp =0.00;
			double dblTotOwnSource =0.00;
			for(int i=0;i<vecsize;i++)
			{				
				vecRow = (Vector)vecData.elementAt(i);
				if(vecRow!=null)
				{	strSno = Helper.correctNull((String)vecRow.elementAt(0));

					dblTottution=dblTottution+Double.parseDouble(Helper.correctDouble((String)vecRow.elementAt(2)));
					dblTotexam=dblTotexam+Double.parseDouble(Helper.correctDouble((String)vecRow.elementAt(3)));
					dblTotlab=dblTotlab+Double.parseDouble(Helper.correctDouble((String)vecRow.elementAt(4)));
					dblTotlodge=dblTotlodge+Double.parseDouble(Helper.correctDouble((String)vecRow.elementAt(5)));
					dblTotbook=dblTotbook+Double.parseDouble(Helper.correctDouble((String)vecRow.elementAt(7)));
					dbltrvexp = dbltrvexp +Double.parseDouble(Helper.correctDouble((String)vecRow.elementAt(6)));
					dblTotexp=dblTotexp+Double.parseDouble(Helper.correctDouble((String)vecRow.elementAt(8)));
					dblTotscholar=dblTotscholar+Double.parseDouble(Helper.correctDouble((String)vecRow.elementAt(9)));
					dblTotreq=dblTotreq+Double.parseDouble(Helper.correctDouble((String)vecRow.elementAt(10)));
					
					dblTotOwnSource=dblTotOwnSource+Double.parseDouble(Helper.correctDouble((String)vecRow.elementAt(11)));
					

					
					
		%>
                            <tr align="center" bgcolor="#FFFFFF"> 
                              <td> 
                                <input type="radio" name="sno" style="border-style:none" onClick="selectValues(<%=strSno%>)">
                                <input type="hidden" name="hid"  value="<%=strSno%>">
                              </td>
                              <td>&nbsp;<%=Helper.correctNull((String)vecRow.elementAt(1))%> 
                              </td>
                              <td width="10%" align="center" valign="middle">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.elementAt(2))))%> 
                              </td>
                              <td>&nbsp; <%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.elementAt(3))))%> 
                              </td>
                              <td>&nbsp; <%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.elementAt(4))))%> 
                              </td>
                              <td>&nbsp; <%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.elementAt(5))))%> 
                              </td>
                              <td>&nbsp; <%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.elementAt(6))))%>  
                              </td>
			                   <td>&nbsp; <%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.elementAt(7))))%>  
                              </td>
                              <td valign="middle">&nbsp; <%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.elementAt(8))))%> 
                              </td>
                              <td valign="middle">&nbsp; <%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.elementAt(9))))%></td>
                              <td valign="middle">&nbsp; <%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.elementAt(11))))%></td>
                              <td valign="middle">&nbsp; <%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.elementAt(10))))%></td>
                            </tr>
                            <%		}
			 }
		  %>
                            <tr align="center"> 
                              <td bgcolor="#FFFFFF">&nbsp;</td>
                              <td bgcolor="#FFFFFF"><b><font size="1" face="MS Sans Serif">Total</font></b></td>
                              <td align="center" valign="middle" bgcolor="#FFFFFF"><font size="1" face="MS Sans Serif" color="Blue">&nbsp;<%=nf.format(dblTottution)%></font></td>
                              <td bgcolor="#FFFFFF"><font size="1" face="MS Sans Serif" color="Blue">&nbsp;<%=nf.format(dblTotexam)%></font></td>
                              <td bgcolor="#FFFFFF"><font size="1" face="MS Sans Serif" color="Blue">&nbsp;<%=nf.format(dblTotlab)%></font></td>
                              <td bgcolor="#FFFFFF"><font size="1" face="MS Sans Serif" color="Blue">&nbsp;<%=nf.format(dblTotlodge)%></font></td>
                              <td bgcolor="#FFFFFF"><font size="1" face="MS Sans Serif" color="Blue">&nbsp;<%=nf.format(dbltrvexp)%></font></td>
							  <td bgcolor="#FFFFFF"><font size="1" face="MS Sans Serif" color="Blue">&nbsp;<%=nf.format(dblTotbook)%></font></td>
                              <td valign="middle" bgcolor="#FFFFFF"><font size="1" face="MS Sans Serif" color="Blue">&nbsp;<%=nf.format(dblTotexp)%></font></td>
                              <td valign="middle" bgcolor="#FFFFFF"><font size="1" face="MS Sans Serif" color="Blue">&nbsp;<%=nf.format(dblTotscholar)%></font></td>
                              <%if(strCheck.equalsIgnoreCase("Y")){ %>
                              <td valign="middle" bgcolor="#FFFFFF"><font size="1" face="MS Sans Serif" color="Blue">&nbsp;<%=nf.format(dblTotOwnSource)%></font></td>
                              <%}else{ %>
                               <td valign="middle" bgcolor="#FFFFFF"><font size="1" face="MS Sans Serif" color="Blue">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("NPCD_APPLICANT_CONTRIBUTION"))))%></font></td>
                              <%} %>
                              <td valign="middle" bgcolor="#FFFFFF"><font size="1" face="MS Sans Serif" color="Blue">&nbsp;<%=nf.format(dblTotreq)%></font></td>
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
  <br>
  <p>&nbsp;</p>
  <%
		String strappno = request.getParameter("appno");
		%>
  <input type="hidden" name="hidAction" >
  <input type="hidden" name="hidBeanId">
  <input type="hidden" name="hidBeanMethod" value="">
  <input type="hidden" name="hidBeanGetMethod" value="getData" >
  <input type="hidden" name="hidSourceUrl" value="">
  <INPUT TYPE="hidden" name="hidApp_type" value="A">
    <INPUT TYPE="hidden" name="hidAppType" >


  <input type="hidden" name="hidflag" value="">
  <input type="hidden" name="hideditflag">
  <input type="hidden" name="selsno" value="">
  <input type="hidden" name="hidval" >
  <input type="hidden" name="hiddesc" >
     <INPUT TYPE="hidden" name="trapEdit" >
 <INPUT TYPE="hidden" name="page">

 <INPUT TYPE="hidden" name="hidCoDemoId" value="<%=request.getParameter("hidCoDemoId")%>" >
  <INPUT TYPE="hidden" name="hidDemoId" value="<%=request.getParameter("hidDemoId")%>">
  <INPUT TYPE="hidden" name="hidAppType" value="<%=Helper.correctNull((String)hshValues.get("hidAppType"))%>">
  <INPUT TYPE="hidden" name="hidGuaDemoId" value="<%=request.getParameter("hidGuaDemoId")%>">
  <INPUT TYPE="hidden" name="radLoan" value="Y">
  <INPUT TYPE="hidden" name="hiPgDist" value="P">
</form>
</body>
</html>
