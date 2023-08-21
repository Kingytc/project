<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>

<lapschoice:handleerror />

<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<% String stroptions=" "; %>
<%


if(objValues instanceof java.util.HashMap)
   {
	  hshValues=(java.util.HashMap)objValues;
   }
	//out.println("hshValues-ttetetet--"+hshValues);
	ArrayList vecData = new ArrayList();
	ArrayList vecRow  = new ArrayList();
	ArrayList vecData1 = new ArrayList();
	ArrayList vecRow1  = new ArrayList();
	ArrayList vecData2= new ArrayList();
	ArrayList vecRow2 = new ArrayList();
	int vecsize=0;
	int vecsize1=0;
	int vecsize2=0;
	if(hshValues!=null)
	{
		vecData = (ArrayList)hshValues.get("vecData");
		vecData1 = (ArrayList)hshValues.get("vecData1");
		vecData2 = (ArrayList)hshValues.get("vecData2");


	}
java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
	//out.println(hshValues);
String strVal=Helper.correctNull((String)hshValues.get("edu_partfull"));
//out.println(strVal);
String strMatVal=Helper.correctNull((String)hshValues.get("edu_status"));
String strProposed=Helper.correctNull((String)hshValues.get("edu_proposed"));
//out.println("strProposed==>"+strProposed);

//out.println(strMatVal);
if(strMatVal.equals("0"))
{
	strMatVal ="";
}

%>
<html>
<head>
<title>Proposed Asset</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
a:hover {  color: #FF3300}
-->
</style>

<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT   LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/per/perpropertydetails.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>

<script>


var appUrl = "<%=ApplicationParams.getAppUrl()%>";
/*function onloading()
{
	disableCommandButtons("load");
}

function onSelect()
{
	var selVall = "<%//=strVal%>" ;
	var strMatVal1 = "<%//=strMatVal%>" ;  
	if(selVall != "")
	{
		document.forms[0].nameof.value = selVall ;
	}
	if(strMatVal1!="")
	{
		document.forms[0].mstatus.value = strMatVal1 ;
	}
}

function doAfterEdit()
{
	
}
function doEdit()
{
		
		document.forms[0].hidflag.value ="edit";
		document.forms[0].hidAction.value ="update";
		disableCommandButtons("edit");
}

function doSave()
{
		
		document.forms[0].cmdapply.disabled = true;
		document.forms[0].hidAction.value="update";
		document.forms[0].hidBeanId.value="edustudent"
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/edustudent.jsp";
		document.forms[0].submit();
	
}
function doCancel()
  {
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="edustudent";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appUrl+"action/edustudent.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
  }

function doDelete()
  {
		if(ConfirmMsg(101))
		 {
			document.forms[0].hidAction.value ="delete";
			document.forms[0].action=appUrl+"action/ControllerServlet";	
			document.forms[0].hidBeanMethod.value="updateData";
			document.forms[0].hidBeanId.value="edustudent";
			document.forms[0].hidSourceUrl.value=appUrl+"action/edustudent.jsp";	
			document.forms[0].method="post";			
			document.forms[0].submit();	
		 }
  }

function disableCommandButtons(val)
{
  if(val=="load")
  {
	  disableFields(true);
	  document.forms[0].cmdedit.disabled=false;
	  document.forms[0].cmdapply.disabled=true;
	  document.forms[0].cmdcancel.disabled=true;
	  document.forms[0].cmddel.disabled=true;
	  document.forms[0].cmdclose.disabled=false;
  }
  if(val=="edit")
  {

	 document.forms[0].cmdedit.disabled=true;
	 document.forms[0].cmdapply.disabled=false;
	 document.forms[0].cmdcancel.disabled=false;
	 document.forms[0].cmddel.disabled=false;
	 document.forms[0].cmdclose.disabled=true;
	 disableFields(false);
  }
}
function Calleduparticulars()
{
	document.forms[0].hidBeanId.value="eduparticulars"
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action="http://172.16.2.193:8080/boblaps/action/eduparticulars.jsp"; 
	document.forms[0].hidSourceUrl.value="/action/eduparticulars.jsp";
	document.forms[0].submit()
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
function callLink(page,bean,method)
{	
	if (document.forms[0].cmdapply.disabled)
	{
	 document.forms[0].hidAction.value="";
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
	 }
	else
	{
		ShowAlert(103);
	}
}*/

</script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<jsp:include page="../share/help.jsp" flush="true"/> 


<form method="post" >
<%
if (hshValues!=null)
{
%>
  <table width="100%" border="0" cellspacing="0" cellpadding="2" bgcolor="#FFFFFF">
    <tr>
      <td width="25%">&nbsp;</td>
      <td colspan="2" align="center"><font face="MS Sans Serif" size="3"><b>EDUCATION 
        LOAN</b></font></td>
      <td width="25%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="25%"><font face="MS Sans Serif" size="2"><b>Student Information</b></font></td>
      <td colspan="2">&nbsp;</td>
      <td width="25%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="25%"><font size="2" face="MS Sans Serif" color="#000000">Name 
        of Student</font></td>
      <td colspan="2"> <font face="MS Sans Serif" size="2" color="#000000"><%=Helper.correctNull((String)hshValues.get("edu_name"))%> 
        </font></td>
      <td width="25%">&nbsp; 
      </td>
    </tr>
    <tr> 
      <td width="25%"><font size="2" face="MS Sans Serif" color="#000000">Name 
        of <%=Helper.correctNull((String)hshValues.get("edu_relation"))%> </font></td>
      <td width="25%"> <font face="MS Sans Serif" size="2" color="#000000">
        <%=Helper.correctNull((String)hshValues.get("edu_relname"))%> </font></td>
      <td width="25%"><font size="2" face="MS Sans Serif" color="#000000">If Guardian 
        state relationship</font></td>
      <td width="25%"> <font face="MS Sans Serif" size="2" color="#000000"><%=Helper.correctNull((String)hshValues.get("edu_relgauratian"))%> 
        </font></td>
    </tr>
    <tr> 
      <td width="25%"><font size="2" face="MS Sans Serif" color="#000000">Date 
        of Birth </font></td>
      <td width="25%"> <font face="MS Sans Serif" size="2" color="#000000"><%if(!(Helper.correctNull((String)hshValues.get("edu_dob")).equals("01/01/1900")))
						{
							out.println(Helper.correctNull((String)hshValues.get("edu_dob")));
						}
						%> 
        </font></td>
      <td width="25%"><font size="2" face="MS Sans Serif" color="#000000">Age</font></td>
      <td width="25%"> <font face="MS Sans Serif" size="2" color="#000000"><%=Helper.correctNull((String)hshValues.get("edu_age"))%> 
        </font></td>
    </tr>
    <tr> 
      <td width="25%"><font size="2" face="MS Sans Serif" color="#000000">Caste</font></td>
      <td width="25%"> <font face="MS Sans Serif" size="2" color="#000000"><%=Helper.correctNull((String)hshValues.get("edu_caste"))%> 
        </font></td>
      <td width="25%"><font size="2" face="MS Sans Serif" color="#000000">Religion</font></td>
      <td width="25%"> <font face="MS Sans Serif" size="2" color="#000000"><%=Helper.correctNull((String)hshValues.get("edu_religion"))%> 
        </font></td>
    </tr>
    <tr> 
      <td width="25%"><font size="2" face="MS Sans Serif" color="#000000">Marital 
        Status </font></td>
      <td width="25%"> <font face="MS Sans Serif" size="2" color="#000000"><%=strMatVal%> 
        </font></td>
      <td width="25%"><font size="2" face="MS Sans Serif" color="#000000">No of 
        Children if any</font></td>
      <td width="25%"> <font face="MS Sans Serif" size="2" color="#000000"><%=Helper.correctNull((String)hshValues.get("edu_child"))%> 
        </font></td>
    </tr>
    <tr> 
      <td width="25%"><font size="2" face="MS Sans Serif" color="#000000">Address1</font></td>
      <td width="25%"> <font face="MS Sans Serif" size="2" color="#000000"><%=Helper.correctNull((String)hshValues.get("edu_addr1"))%> 
        </font></td>
      <td width="25%"><font size="2" face="MS Sans Serif" color="#000000">Address2</font></td>
      <td width="25%"> <font face="MS Sans Serif" size="2" color="#000000"><%=Helper.correctNull((String)hshValues.get("edu_addr2"))%> 
        </font></td>
    </tr>
    <tr> 
      <td width="25%"><font size="2" face="MS Sans Serif" color="#000000">City</font></td>
      <td width="25%"> <font face="MS Sans Serif" size="2" color="#000000"><%=Helper.correctNull((String)hshValues.get("edu_city"))%> 
        </font></td>
      <td width="25%"><font size="2" face="MS Sans Serif" color="#000000">State</font></td>
      <td width="25%"> <font face="MS Sans Serif" size="2" color="#000000"><%=Helper.correctNull((String)hshValues.get("edu_state"))%> 
        </font></td>
    </tr>
    <tr> 
      <td width="25%"><font size="2" face="MS Sans Serif" color="#000000">Pincode</font></td>
      <td width="25%"> <font face="MS Sans Serif" size="2" color="#000000"><%=Helper.correctNull((String)hshValues.get("edu_pincode"))%> 
        </font></td>
      <td width="25%">&nbsp;</td>
      <td width="25%">&nbsp;</td>
    </tr>
  </table>
  <font size="2" face="MS Sans Serif" color="#000000"><b>Educational Details (<font size="2">SSLC 
  &amp; Upward)</font></b></font><BR>
  <table width="100%" border="0" cellspacing="1" cellpadding="2">
    <tr bgcolor="#FFFFFF"> 
 
      <td width="7%" height="21"><font face="MS Sans Serif" size="2" color="#000000">Examination</font></td>
      <td align="center" width="24%" height="21"><font face="MS Sans Serif" size="2" color="#000000">Institution/University 
        </font></td>
      <td width="15%" align="center" height="21"> 
        <p><font face="MS Sans Serif" size="2">Year of passing</font></p>
      </td>
      <td width="15%" align="center" height="21"><font face="MS Sans Serif" size="2">Attempts 
        made </font></td>
      <td width="15%" align="center" height="21"><font face="MS Sans Serif" size="2">Percentage 
        of marks</font></td>
      <td width="21%" align="center" height="21"><font face="MS Sans Serif" size="2">Class 
        obtained </font></td>
    </tr>
    <%
	if(vecData1!=null)
	{
	%>
    <%
				vecsize1 = vecData1.size();
	//out.println("vecsize"+vecsize);
			}
			String strSno="";
			
		
			
			for(int i=0;i<vecsize1;i++)
			{				
				vecRow1 = (ArrayList)vecData1.get(i);
				if(vecRow1!=null)
				{	strSno = Helper.correctNull((String)vecRow1.get(0));

					

					
					
		%>
    <tr align="center" bgcolor="#FFFFFF"> 
      
      <td width="7%"><font face="MS Sans Serif" size="2">&nbsp;<%=Helper.correctNull((String)vecRow1.get(1))%> 
        </font></td>
      <td valign="middle" align="center" width="24%"><font face="MS Sans Serif" size="2">&nbsp;<%=Helper.correctNull((String)vecRow1.get(2))%> 
        &nbsp; &nbsp; &nbsp; &nbsp; </font></td>
      <td valign="middle" width="15%"><font face="MS Sans Serif" size="2">&nbsp; 
        <%=Helper.correctNull((String)vecRow1.get(3))%></font></td>
      <td valign="middle" width="15%"><font face="MS Sans Serif" size="2">&nbsp; 
        <%=Helper.correctNull((String)vecRow1.get(4))%></font></td>
      <td valign="middle" width="15%"><font face="MS Sans Serif" size="2"><%=Helper.correctNull((String)vecRow1.get(5))%></font></td>
      <td valign="middle" width="21%"><font face="MS Sans Serif" size="2">&nbsp; 
        <%=Helper.correctNull((String)vecRow1.get(6))%></font></td>
    </tr>
    <%		}
			 }
		  %>
  </table> 
     
  <font size="2" face="MS Sans Serif" color="#000000"><b>Particulars of Scholarships/Prizes 
  won for Academic Distinction</b></font><br>
  <table width="100%" border="0" cellspacing="1" cellpadding="2">
    <%
	if(vecData2!=null)
	{
	%>
    <tr bgcolor="#FFFFFF"> 
     
      <td width="6%"><font face="MS Sans Serif" size="2" color="#000000">Examination</font></td>
      <td align="center"><font face="MS Sans Serif" size="2" color="#000000">Academic 
        distinction for which scholarship awarded</font></td>
      <td width="16%" align="center"> 
        <p><font face="MS Sans Serif" size="2" color="#000000">Name of the Scholarship 
          prize</font></p>
      </td>
      <td width="16%" align="center"><font face="MS Sans Serif" size="2" color="#000000">Amount 
        of scholarship</font></td>
      <td width="16%" align="center"><font face="MS Sans Serif" size="2" color="#000000">Duration 
        From </font></td>
      <td width="16%" align="center"><font face="MS Sans Serif" size="2" color="#000000">Duration 
        To </font></td>
    </tr>
    <%
				vecsize2 = vecData2.size();
	//out.println("vecsize"+vecsize);
			}
			String strSno1="";
			
		
			
			for(int i=0;i<vecsize2;i++)
			{				
				vecRow2 = (ArrayList)vecData2.get(i);
				if(vecRow2!=null)
				{	strSno1 = Helper.correctNull((String)vecRow2.get(0));

					

					
					
		%>
    <tr align="center" bgcolor="#EEEAE3"> 
     
      <td bgcolor="#FFFFFF"><font face="MS Sans Serif" size="2">&nbsp;<%=Helper.correctNull((String)vecRow2.get(1))%> 
        </font></td>
      <td valign="middle" align="center" bgcolor="#FFFFFF"><font face="MS Sans Serif" size="2">&nbsp;<%=Helper.correctNull((String)vecRow2.get(2))%> 
        &nbsp; &nbsp; &nbsp; &nbsp; </font></td>
      <td valign="middle" bgcolor="#FFFFFF"><font face="MS Sans Serif" size="2">&nbsp; 
        <%=Helper.correctNull((String)vecRow2.get(3))%></font></td>
      <td valign="middle" bgcolor="#FFFFFF"><font face="MS Sans Serif" size="2">&nbsp; 
        <%=Helper.correctNull((String)vecRow2.get(4))%></font></td>
      <td valign="middle" bgcolor="#FFFFFF"><font face="MS Sans Serif" size="2"><%=Helper.correctNull((String)vecRow2.get(5))%></font></td>
      <td valign="middle" bgcolor="#FFFFFF"><font face="MS Sans Serif" size="2">&nbsp; 
        <%=Helper.correctNull((String)vecRow2.get(6))%></font></td>
    </tr>
    <%		}
			 }
		  %>
  </table>
  <font face="MS Sans Serif" size="2"><b>University 
              Info</b></font>                    
  <table border="1" cellspacing="0" cellpadding="3" width="100%" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
    <tr> 
                        
      <td> 
        <table width="100%" border="0" cellspacing="1" cellpadding="2">
          <tr bgcolor="#FFFFFF"> 
            <td width="25%"><font size="2" face="MS Sans Serif">Name of course</font></td>
            <td> <font face="MS Sans Serif" size="2"><%=Helper.correctNull((String)hshValues.get("edu_coursename"))%> 
              </font></td>
            <td><font size="2" face="MS Sans Serif">Name of University/Institutuion</font></td>
            <td width="25%"> <font face="MS Sans Serif" size="2"><%=Helper.correctNull((String)hshValues.get("edu_university"))%> 
              </font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td width="25%"><font size="2" face="MS Sans Serif">Duration of course</font></td>
            <td width="25%"> <font face="MS Sans Serif" size="2"><%=Helper.correctNull((String)hshValues.get("edu_duration"))%> 
              </font></td>
            <td width="25%"><font size="2" face="MS Sans Serif">Type of Course</font></td>
            <td width="25%"> <font face="MS Sans Serif" size="2"><%=strVal%> </font></td>
          </tr>
		  <tr bgcolor="#FFFFFF"> 
            <td width="25%"><font size="2" face="MS Sans Serif">Educational Qulification 
              Proposed </font></td>
            <td colspan="3"> <font face="MS Sans Serif" size="2"><%=Helper.correctNull((String)hshValues.get("edu_proposed"))%> 
              </font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td width="25%"><font size="2" face="MS Sans Serif">Other information 
              in case of studies aboved</font></td>
            <td colspan="3"> <font face="MS Sans Serif" size="2"><%=Helper.correctNull((String)hshValues.get("edu_other"))%> 
              </font></td>
          </tr>		   
          <tr bgcolor="#FFFFFF"> 
            <td width="25%"><font size="2" face="MS Sans Serif">Any Other Information 
              </font></td>
            <td colspan="3"> <font face="MS Sans Serif" size="2"><%=Helper.correctNull((String)hshValues.get("edu_any"))%> 
              </font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td width="25%" height="21"><font size="2" face="MS Sans Serif">Insurance 
              Details</font></td>
            <td colspan="3" height="21"> <font face="MS Sans Serif" size="2"><%=Helper.correctNull((String)hshValues.get("edu_insurance"))%> 
              </font></td>
          </tr>
        </table>
                        
      </td>
                      </tr>
                    </table>
			
  <font size="2" face="MS Sans Serif" color="#000000"><b>Estimate of Course Expenses</b></font><BR>
					 
  <table width="100%" border="0" cellspacing="1" cellpadding="2">
    <%
	if(vecData!=null)
	{
	%>
    <tr bgcolor="#FFFFFF"> 
      <td width="1%" height="22"><font color="#000000"></font></td>
      <td width="6%" height="22"><font color="#000000" face="MS Sans Serif" size="2">Year</font></td>
      <td colspan="5" align="center" height="22"><font face="MS Sans Serif" size="2" color="#000000">Purpose</font></td>
      <td width="15%" align="center" height="22"> 
        <p><font size="2" face="MS Sans Serif" color="#000000">Total Expenses 
          </font></p>
      </td>
      <td width="15%" align="center" height="22"><font size="2" face="MS Sans Serif" color="#000000">Scholarship</font></td>
      <td width="12%" align="center" height="22"><font color="#000000" face="MS Sans Serif" size="2">Total 
        Loan Required</font></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="1%"><font color="#000000"></font></td>
      <td width="6%"><font color="#000000"></font></td>
      <td width="15%" align="center"><font face="MS Sans Serif" size="2" color="#000000">Tution 
        Fee </font></td>
      <td align="center" width="10%"><font size="2" face="MS Sans Serif" color="#000000">Exam 
        Fees</font></td>
      <td align="center" width="12%"><font size="2" face="MS Sans Serif" color="#000000">Cost 
        of Books</font></td>
      <td align="center" width="10%"><font size="2" face="MS Sans Serif" color="#000000">Lodging</font></td>
      <td align="center" width="13%"><font size="2" face="MS Sans Serif" color="#000000">Lab 
        Fees,Equip fees etc</font></td>
      <td width="16%" align="center">&nbsp;</td>
      <td width="16%" align="center">&nbsp;</td>
      <td width="16%" align="center">&nbsp;</td>
    </tr>
    <%
				vecsize = vecData.size();
	//out.println("vecsize"+vecsize);
			}
			String strSno2="";
			
		
			double dblTottution=0.00;
			double dblTotexam=0.00;
			double dblTotbook=0.00;
			double dblTotlodge=0.00;

			double dblTotlab=0.00;
			double dblTotexp=0.00;
			double dblTotscholar=0.00;
			double dblTotreq=0.00;
			for(int i=0;i<vecsize;i++)
			{				
				vecRow = (ArrayList)vecData.get(i);
				if(vecRow!=null)
				{	strSno2 = Helper.correctNull((String)vecRow.get(0));

					dblTottution=dblTottution+Double.parseDouble((String)vecRow.get(2));
					dblTotexam=dblTotexam+Double.parseDouble((String)vecRow.get(3));
					dblTotbook=dblTotbook+Double.parseDouble((String)vecRow.get(4));
					dblTotlodge=dblTotlodge+Double.parseDouble((String)vecRow.get(5));
					dblTotlab=dblTotlab+Double.parseDouble((String)vecRow.get(6));
					dblTotexp=dblTotexp+Double.parseDouble((String)vecRow.get(7));
					dblTotscholar=dblTotscholar+Double.parseDouble((String)vecRow.get(8));
					dblTotreq=dblTotreq+Double.parseDouble((String)vecRow.get(9));
					

					
					
		%>
    <tr align="center" bgcolor="#FFFFFF"> 
      <td>&nbsp; </td>
      <td><font face="MS Sans Serif" size="2">&nbsp;<%=Helper.correctNull((String)vecRow.get(1))%> 
        </font></td>
      <td valign="middle" align="center" width="15%"><font face="MS Sans Serif" size="2">&nbsp;<%=Helper.correctNull((String)vecRow.get(2))%> 
        </font></td>
      <td><font face="MS Sans Serif" size="2">&nbsp; <%=Helper.correctNull((String)vecRow.get(3))%> 
        </font></td>
      <td><font face="MS Sans Serif" size="2">&nbsp; <%=Helper.correctNull((String)vecRow.get(4))%> 
        </font></td>
      <td><font face="MS Sans Serif" size="2">&nbsp; <%=Helper.correctNull((String)vecRow.get(5))%> 
        </font></td>
      <td><font face="MS Sans Serif" size="2">&nbsp; <%=Helper.correctNull((String)vecRow.get(6))%> 
        </font></td>
      <td valign="middle"><font face="MS Sans Serif" size="2">&nbsp; <%=Helper.correctNull((String)vecRow.get(7))%> 
        </font></td>
      <td valign="middle"><font face="MS Sans Serif" size="2">&nbsp; <%=Helper.correctNull((String)vecRow.get(8))%></font></td>
      <td valign="middle"><font face="MS Sans Serif" size="2">&nbsp; <%=Helper.correctNull((String)vecRow.get(9))%></font></td>
    </tr>
    <%		}
			 }
		  %>
    <tr align="center" bgcolor="#FFFFFF"> 
      <td>&nbsp;</td>
      <td><b><font size="2" face="MS Sans Serif">Total</font></b></td>
      <td valign="middle" align="center"><font face="MS Sans Serif" size="2"><%=dblTottution%></font></td>
      <td><font face="MS Sans Serif" size="2">&nbsp;<%=dblTotexam%></font></td>
      <td><font face="MS Sans Serif" size="2">&nbsp;<%=dblTotbook%></font></td>
      <td><font face="MS Sans Serif" size="2">&nbsp;<%=dblTotlodge%></font></td>
      <td><font face="MS Sans Serif" size="2">&nbsp;<%=dblTotlab%></font></td>
      <td valign="middle"><font face="MS Sans Serif" size="2">&nbsp;<%=dblTotexp%></font></td>
      <td valign="middle"><font face="MS Sans Serif" size="2">&nbsp;<%=dblTotscholar%></font></td>
      <td valign="middle"><font face="MS Sans Serif" size="2">&nbsp;<%=dblTotreq%></font></td>
    </tr>
  </table>
					
  <br>

 
<input type="hidden" name="hidAction" >
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidSourceUrl">
<INPUT TYPE="hidden" name="hidBeanGetMethod">
<input type="hidden" name="hidflag" value="">
 <INPUT TYPE="hidden" name="page">
</form>
<%
}
%>
</body>
</html>

