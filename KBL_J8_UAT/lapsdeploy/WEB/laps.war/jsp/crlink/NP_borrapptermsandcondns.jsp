<%/*
	Module Name:	Terms and Conditions
	Page Name:	borrapptermsandcondns.jsp
	Descripion:		
	Created By:		 Modified By Soma Sundaram
*/%>


<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
//out.println("hshValues"+hshValues);
	ArrayList arrTermData=(ArrayList)hshValues.get("arrTerms");
	ArrayList arrTermId=(ArrayList)hshValues.get("arrTermsId");
	ArrayList arrTermsType=(ArrayList)hshValues.get("arrTermsType");
	ArrayList arrTermsFor=(ArrayList)hshValues.get("arrTermsFor");
	String strPgDist=Helper.correctNull(request.getParameter("hiPgDist"));
	String edu_coursdetails=Helper.correctNull((String)hshValues.get("edu_coursdetails"));
		
%>

<html>
<head>
<title>Terms and Conditions</title>

<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var strappeditsameregbranch="<%=session.getAttribute("HRBranchUserEdit")%>";
var varAppHolder="<%=Helper.correctNull((String) hshValues.get("strAppHolder"))%>";
var varUserId="<%=Helper.correctNull((String) hshValues.get("strUsrid"))%>";
var varAppNo="<%=Helper.correctNull((String) hshValues.get("strAppno"))%>";	
function callhelp()
{
		   var varQryString = appUrl+"/jsp/perhlp/hlp_apptermsandcond.jsp";
		   var title = "ApplicantDemographics";
			var prop = "scrollbars=no,width=600,height=450";	
			prop = prop + ",left=200,top=150";
			window.open(varQryString,title,prop);
}
	function setData()
	{
		
		var varAppStatus = document.forms[0].appstatus.value;
		var len = document.forms[0].sno.length;
		if(len >0)
		{
			document.forms[0].cmddelete.disabled=false
		}
		
		if(len!=null)
		{
		for(i=0;i<len;i++)
		{
			if(document.forms[0].sno[i].checked == true)
			{
				document.forms[0].txttrmdesc.value = document.forms[0].hidText[i].value;
				document.forms[0].hidtermid.value = document.forms[0].sno[i].value;
				document.forms[0].hidterms.value = document.forms[0].hidtermtype[i].value;
			}
		}
		}
		else
		{
				document.forms[0].txttrmdesc.value = document.forms[0].hidText.value;
				document.forms[0].hidtermid.value = document.forms[0].sno.value;
				document.forms[0].hidterms.value = document.forms[0].hidtermtype.value;
		}

		document.forms[0].hidcomments.value="";
		if(varAppStatus != "Open/Pending")
		{
		 document.forms[0].cmddelete.disabled = true;
		}
		else{
			document.forms[0].cmdedit.disabled = false;
			document.forms[0].cmdadd2.disabled=false;
			document.forms[0].cmdadd.disabled=true;
			}
	}

function disablebutton()
{

	var varTermsId = "<%=arrTermId.size()%>";
	if (document.forms[0].appstatus.value != "Open/Pending")
	{
		disableButton(true,true,true,true,true,false);
		alert("cannot modify APPROVED APPLICATION !!!")
		document.forms[0].cmdadd2.disabled=true;
	}
	else if(strappeditsameregbranch!="")
	{
	
		if(strappeditsameregbranch=="disablefalse")
		{
			disableButton(false,true,true,true,true,false);
			document.forms[0].cmdadd2.disabled=false;
		}
		else if(strappeditsameregbranch=="disabletrue")
		{
			disableButton(true,true,true,true,true,false);
			document.forms[0].cmdadd2.disabled=true;
		}
	}
	else{
		disableButton(false,true,true,true,true,false);
		document.forms[0].cmdadd2.disabled=false;
		}

	//if(varTermsId == "0")
	//{
	//	document.forms[0].cmdedit.disabled = true;
	//}else{
	//	
	//	document.forms[0].cmdedit.disabled = false;
	//}
}
function doNew()
	{
		document.forms[0].sel_termstype.value="C";
		document.forms[0].hidAction.value="insert";
		document.forms[0].hidtermid.value="";
		document.forms[0].txttrmdesc.value="";
		document.forms[0].txttrmdesc.readOnly=false;
		disableButton(true,true,false,false,true,true)
		
	}

	function doEdit()
	{
	document.forms[0].sel_termstype.value="C";
		document.forms[0].hidAction.value="update";
		document.forms[0].txttrmdesc.readOnly=false;

		var len = document.forms[0].sno.length;

		if(len != null)
		{
		for(i=0;i<len;i++)
		{
			document.forms[0].sno[i].disabled = true;
		}
		}
		else
		{
			document.forms[0].sno.disabled = true;
		}
	
		
			disableButton(true,true,false,false,true,true)
	}


	function doApply()
	{
		
		if(varAppHolder!=varUserId&&varAppNo!="")
		{
			
			alert("Your Not The Holder of the Application to Modify The Application");
			return;

		}
		else{
		
		if(trimtxt(document.forms[0].txttrmdesc.value)=="")
		{
		alert("Enter Terms Description");
		return false;
		}
		document.forms[0].sel_termstype.value="C";
		document.forms[0].hidBeanId.value="NationalPortal";
		document.forms[0].hidBeanMethod.value="updateTerms";
		document.forms[0].hidBeanGetMethod.value="getTerms";		
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/NP_borrapptermsandcondns.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
	}
	function doDelete()
	{
		if(document.forms[0].hidtermid.value=="")
		{
		alert("Select Terms to delete");
		return false;
		}
		
	//	if(trimtxt(document.forms[0].hidcomments.value)=="")
	//	{
	//		var url = "<%=ApplicationParams.getAppUrl()%>action/deletedtermremarks.jsp";
	//		var title1 = "";
	//		var prop = "scrollbars=no,width=600,height=450,menubar=no";
	//		var xpos = 20;
	//		var ypos = 20;
	//		prop = prop + ",left="+xpos+",top="+ypos;
	//		window.open(url,title1,prop);
	//		
	//	}
		else
		{
		document.forms[0].sel_termstype.value="C";
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="NationalPortal";
		document.forms[0].hidBeanMethod.value="updateTerms";
		document.forms[0].hidBeanGetMethod.value="getTerms";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/NP_borrapptermsandcondns.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
		}
	}
	function disableButton(b1,b2,b3,b4,b5,b6)
	{
		document.forms[0].cmdadd.disabled = b1;
		document.forms[0].cmdedit.disabled = b2;
		document.forms[0].cmdapply.disabled = b3;
		document.forms[0].cmdcancel.disabled = b4;
		document.forms[0].cmddelete.disabled = b5;
		document.forms[0].cmdclose.disabled = b6;

	}

	function doCancel()
	{
		document.forms[0].sel_termstype.value="C";
		document.forms[0].hidBeanId.value="NationalPortal";
		document.forms[0].hidBeanGetMethod.value="getTerms";
		document.forms[0].action=appUrl+"action/NP_borrapptermsandcondns.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}

	function doClose()
	{
		alert("close");
	if("<%=strPgDist%>"=="P")
	{
		document.forms[0].action=appUrl+"action/perexisting.jsp";
	}else
	{
		document.forms[0].action=appUrl+"action/comsearch.jsp";
	}
	document.forms[0].method="post";
	document.forms[0].submit();
	}

	function callAppraisal()
	{
		
	if(!document.forms[0].cmdapply.disabled)
		{
			ShowAlert('103');
			return;
		}
		else
		{
		document.forms[0].hidBeanId.value="NationalPortal";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/NP_perappsanctionsanction.jsp";
		document.forms[0].hidAppType.value="";
		document.forms[0].submit();
		}
		
	}
	

	function callprocess()
	{
		
		/*if(!document.forms[0].cmdapply.disabled)
		{
			ShowAlert('103');
			return;
		}*/
		//else
		{
		document.forms[0].hidBeanId.value="NationalPortal";
		document.forms[0].hidBeanGetMethod.value="getprocessData1";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/NP_perprocessnotedata.jsp";
		document.forms[0].hidAppType.value="";
		document.forms[0].submit();
		}
		
	}

	function deleteTerms()
	{
	var appno = document.forms[0].appno.value;
	var url = "<%=ApplicationParams.getAppUrl()%>action/apptermsandcondexcep.jsp?appno="+appno+"&hidBeanId=apptermscond&hidBeanGetMethod=getDeletedTerms&hidAction=Retail&hidPageValue=Retail&sel_termstype=C";	
	var title1 = "";
	var prop = "scrollbars=yes,width=775,height=500,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title1,prop);
  	}
	function callBranchTerms()
	{
		if(!document.forms[0].cmdapply.disabled)
		{
			ShowAlert('103');
			return;
		}
	document.forms[0].sel_termstype.value="B";
	document.forms[0].hidBeanId.value="NationalPortal";
	document.forms[0].hidBeanGetMethod.value="getTerms";
	document.forms[0].action=appURL+"action/NP_apptermsandcond.jsp";
	document.forms[0].submit();

	}


	function funEDappstatusnew()
	{
		<%if(edu_coursdetails.equalsIgnoreCase("N")){%>
		alert("Please Enter Course Details under Edu Loan Tab.");
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].hidBeanId.value="edustudent";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/edustudent.jsp";
		document.forms[0].submit();
		<%}%>
		if((document.forms[0].hid_appholder.value=="N") || (document.forms[0].appstatus.value=="Processed/Rejected") || (document.forms[0].appstatus.value=="Processed/Approved"))
		{
			disableButton(true,true,true,true,true,false);
			
		}	
		
	}
</script>

<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/set/navigate.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
DIV.cellContainer {	
  width: 100%; height: 250;
  overflow: auto;
}
DIV.cellContainer2 {	
  width: 100%; height: 200;
  overflow: auto;
}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body class="bgcolor" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad = "disablebutton();funEDappstatusnew()" >
<form name="frm1" method="post" >
  <table width="100%" border="1" cellspacing="0" cellpadding="0" class="outertablecolor" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
    <tr> 
      <td  colspan="2"> 
        <jsp:include page="../nationalportal/ApplurllinkNP.jsp" flush="true"> 
        <jsp:param name="pageid" value="10" />
        </jsp:include>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td valign="bottom"><b><i><font face="Times New Roman" size="3"><b><i>Home 
        </i><font face="Times New Roman" size="3"><b><font face="MS Sans Serif">-&gt;</font> 
        Existing -&gt; Retail</b></font> <font face="MS Sans Serif">-&gt;</font> 
        </b></font></i><font face="Times New Roman" size="3"><b> </b></font><i> 
        <font face="Times New Roman" size="3"><b><font face="Times New Roman" size="3"><b>Terms and Conditions</b></font></b></font></i></b></td>
      <td width="280">&nbsp; </td>
    </tr>
  </table>
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr> 
      <td > <laps:application /> </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td height="20" class="outertablecolor"> 
        <table width="50%" border="0" cellspacing="3" cellpadding="3" align="left">
          <tr align="center"> 
            <td width="50%" class="tabactive"><b><font size="1" face="MS Sans Serif" color="#FFFFFF">Terms 
              and Conditions</font></b></td>
            <td width="30%" class="tabinactive"><b><font size="1" face="MS Sans Serif"><a href="javascript:callAppraisal()" class="blackfont">Appraisal</a></font></b></td>
		    <td width="30%" class="tabinactive"><b><font size="1" face="MS Sans Serif"><a href="javascript:callprocess()" class="blackfont">Process Note</a></font></b></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td height="20" class="outertablecolor"> 
        <table width="50%" border="0" cellspacing="3" cellpadding="3" align="left">
          <tr align="center"> 
            
            <td width="25%" class="tabactive"><b><font size="1" face="MS Sans Serif"> Terms &amp; Conditions For Borrower</font></b></td>
            
            
            
            <%
            

            String Orglel= Helper.correctNull((String) hshValues.get("orglevel"));	
            String OrgCPC= Helper.correctNull((String) hshValues.get("orgcpc"));	
            	
            
            
            
            if(Orglel.equalsIgnoreCase("BRN")){
    		
    		
    		if(OrgCPC.equalsIgnoreCase("Y")){
        		
		
    			 %>
            
            
            <td width="25%" class="tabinactive"><b><font size="1" face="MS Sans Serif" color="#FFFFFF"><a href="javascript:callBranchTerms()" class="blackfont"> Terms &amp; Conditions For Branch</a></font></b></td>
        
        
        <%}} else{%>
        
           <td width="25%" class="tabinactive"><b><font size="1" face="MS Sans Serif" color="#FFFFFF"><a href="javascript:callBranchTerms()" class="blackfont"> Terms &amp; Conditions For Branch</a></font></b></td>
        <%} %>
        
        
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" height="400" border="1" align="center" cellpadding="5" cellspacing="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" class="outertablecolor">
    <tr> 
      <td valign="top" align="center"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" align="center" height="100%">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5">
                <tr> 
                  <td colspan="2" valign="top"> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="5">
                            <tr> 
                              <td width="29%" align="center"><font size="1" face="MS Sans Serif">Add 
                                Terms and Conditions</font></td>
                              <td width="71%"> 
                                <input type="hidden" name="hidtermid">
                                <input type="hidden" name="hidterms">
                                <textarea name="txttrmdesc" cols="100" readonly="readOnly" wrap="VIRTUAL" rows="5"></textarea>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td colspan="2" valign="middle"> 
                  <div Class = "cellContainer">
                    <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center">
                      <tr class="tabactive"> 
                        <td width="3%">&nbsp;</td>
                        <td width="97%" align="center"> <font size="1" face="MS Sans Serif"><b><font color="#FFFFFF">Terms 
                          and Conditions Description</font></b></font></td>
                      </tr>
                      <%
					  for(int i=0;i<arrTermId.size();i++)
					  {
					   if(Helper.correctNull((String)arrTermsFor.get(0)).trim().equalsIgnoreCase("C"))
						  {
					  %>
                      <tr bgcolor="#FFFFFF"> 
                        <td width="3%"> 
                          <input type="radio" name="sno" style="border-style:none" value="<%=arrTermId.get(i)%>" onClick="setData()">
                        </td>
                        <input type="hidden" name="hidsno" style="border-style:none" value="<%=arrTermId.get(i)%>">
						  <input type="hidden" name="hidText" style="border-style:none" value="<%=arrTermData.get(i)%>">
                        <input type="hidden" name="hidtermtype" style="border-style:none" value="<%=arrTermsType.get(i)%>">
                        <td width="97%" align="center"> 
                          <div align="left"><font size="1" face="MS Sans Serif"> 
                            <%=Helper.breakText((String)arrTermData.get(i),30)%></font></div>
                        </td>
                      </tr>
                      <%
                      }
					  }
					  %>
                    </table>
                    </div>
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
  <table border="1" align="center" cellpadding="0" cellspacing="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" class="outertablecolor">
    <tr bordercolordark="#FFFFFB" bordercolorlight="#8F8369"> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" >
          <tr valign="top">
            <td width="0">
              <input type="button" name="cmdadd2" value="Deleted Terms" style="width:150" class="buttoncolor" onClick="deleteTerms()">
            </td>
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdadd" value="Add" style="width:50" class="buttoncolor" onClick="doNew()">
              </div>
            </td>
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdedit" value="Edit" style="width:50" class="buttoncolor" onClick="doEdit()">
              </div>
            </td>
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdapply" value="Apply" style="width:50" class="buttoncolor" onClick="doApply()" disabled>
              </div>
            </td>
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdcancel" value="Cancel" style="width:50" class="buttoncolor" onClick="doCancel()" disabled>
              </div>
            </td>
            <td width="15%"> 
              <input type="button" name="cmddelete" value="Delete" style="width:50" class="buttoncolor" onClick="doDelete()">
            </td>
            <td width="15%"> 
              <div align="center"> 
                <input type="button" name="cmdhelp" value="Help" onClick="callhelp()" style="background-color:#009966;cursor:help;;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
              </div>
            </td>
            <td width="15%"> 
              <div align="center"> 
                <input type="button" name="cmdclose" value="Close" style="background-color:#CC3300;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="doClose()">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <%String strappno = request.getParameter("appno");%>
 
  <INPUT TYPE="hidden" name="hidCoDemoId" value="<%=request.getParameter("hidCoDemoId")%>" >
  <INPUT TYPE="hidden" name="hidDemoId" value="<%=request.getParameter("hidDemoId")%>">
  <INPUT TYPE="hidden" name="hidGuaDemoId" value="<%=request.getParameter("hidGuaDemoId")%>">
  <input type="hidden" name="hidBeanId" value="">
  <input type=hidden name="hidBeanMethod" value="">
  <input type="hidden" name="hidBeanGetMethod">
  <input type="hidden" name="hidSourceUrl" value="" >
  <input type="hidden" name="hidAction" value="" >
  <INPUT TYPE="hidden" name="hiPgDist" value="<%=Helper.correctNull(request.getParameter("hiPgDist"))%>">
    <input TYPE="hidden" name="hidAppType"value="<%=Helper.correctNull((String)hshValues.get("hidAppType"))%>">
  <input TYPE="hidden" name="radLoan" value="Y">
  <input TYPE="hidden" name="hidauto_type">
    <input type="hidden" name="hidEditLock">
	<input TYPE="hidden" name="trapEdit"  value="<%=Helper.correctNull((String)hshValues.get("trapEdit"))%>">
  <input TYPE="hidden" name="hidEditMode" value="<%=Helper.correctNull((String)hshValues.get("hidEditMode"))%>">
  <input TYPE="hidden" name="hidcomments">
<input type="hidden" name="hidLoanType">
<input type="hidden" name="rdtermid">
<input type="hidden" name="seltermid">
<input type="hidden" name="sel_termstype" value="">
<input type="hidden" name="appno"  value="<%=Helper.correctNull(request.getParameter("appno"))%>">
<input type="hidden" name="hidPageValue" value="Retail">
<input type="hidden" name="hidPageName" value="C">
</form>
</body>
</html>
