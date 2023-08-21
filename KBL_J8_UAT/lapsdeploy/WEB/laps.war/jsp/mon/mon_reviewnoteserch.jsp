<%@ page import="com.sai.laps.helper.*,java.util.ArrayList" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="strGroupRights" class="java.lang.String" scope="session"/>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror/>
<html>
<head>
<title>Commercial-Existing Application form</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>

var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varmontype="<%=Helper.correctNull((String)request.getParameter("strhidmontype"))%>";

function doClose()
{
	if(ConfirmMsg(100))
	{
		 	document.forms[0].action=appUrl+"action/mon_borrowersearch.jsp?hidmontype=MONITREVIEW";
			document.forms[0].submit();
	}
}

function doSearch()
{
	var strOpt="";
	var strForm="";
	var strSrch="";
	var strMailbox="";
   	hidmontype = document.forms[0].hidmontype.value;
   
	appno = document.forms[0].srchvalue.value;	
	document.all.result.src="<%=ApplicationParams.getAppUrl()%>action/monresult.jsp?hidBeanGetMethod=getMonitoringData&hidBeanId=borrowersearch&hidmontype=<%=Helper.correctNull((String)request.getParameter("id"))%>&id=<%=Helper.correctNull((String)request.getParameter("id"))%>";
}

/* modification end */

function callPage(year,appstatus,statusflag)
{
	document.forms[0].reviewYear.value=year;
	document.forms[0].appstatus.value=appstatus;
	document.forms[0].statusflag.value=statusflag;
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/reviewnotetypeofreview.jsp";
	document.forms[0].target="mainFrame";
	document.forms[0].hidBeanId.value="reviewtermloantwo";
	document.forms[0].hidBeanGetMethod.value="getTypeReviewTermLoan";
	document.forms[0].submit();
}

function doNew()
{
	document.all["yearid"].style.display="table-row";
	document.forms[0].cmdapply.disabled=false;
	document.all["existingid"].style.display="none";
}

function onLoading()
{
	
	document.forms[0].cmdapply.disabled=false;
	document.forms[0].cmdnew[1].checked=true;
	doExisting();
	<%if(strGroupRights.charAt(18)=='r')
	{%>
		document.forms[0].cmdnew[0].disabled=true;
	<%}
	if(!Helper.correctNull((String)hshValues.get("newButtonDisable")).equals(""))
	{%>
		document.forms[0].cmdnew[0].disabled=true;
	<%} %>

	
}

function doExisting()
{
	document.all["yearid"].style.display="none";
	document.forms[0].cmdapply.disabled=true;
	document.all["existingid"].style.display="table";
}

function doSave()
{
	if(document.forms[0].txt_year.value=="")
	{
		alert("Year cannot be Empty");
		return;
	}
	if(document.forms[0].hidYear)
	{
		
		for(i=0;i<document.forms[0].hidYear.length-1;i++)
		{
			
			if(document.forms[0].txt_year.value==document.forms[0].hidYear[i].value)
			{
				alert("Review note already prepared");
				return;
			}
		}
	}
	document.forms[0].reviewYear.value=document.forms[0].txt_year.value;
	document.forms[0].action=appUrl+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updateReviewTermLoanYear";
	document.forms[0].hidBeanGetMethod.value="getTypeReviewTermLoan";
	document.forms[0].hidBeanId.value="reviewtermloan";
	document.forms[0].hidSourceUrl.value="action/reviewnotetypeofreview.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();		
}

function callcheckyear()
{
	var  year=document.forms[0].txt_year.value;
 	if(year!="")
 	{
 		if(eval(year)<2008)
 		{
 			alert("Monitoring has started only from 2008");
 			document.forms[0].txt_year.value="";
 			document.forms[0].txt_year.focus();
 		}
 	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="onLoading()">
<form name="exist">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top"> 
              <jsp:include page="../share/help.jsp" flush="true"/> 
            </td>
          </tr>
          <tr>
            <td valign="top"><font face="Times New Roman" size="3"><b><i>Home 
              -&gt; Monitoring -&gt; Accountwise Search </i></b></font></td>
          </tr>
        </table>		
      </td>
    </tr>
 </table>

 <table width="100%" border="1" cellspacing="0" cellpadding="5"  bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr> 
      <td valign="top" height="184"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
          <tr> 
            <td> 
              <table width="100%" border="1" cellspacing="0" cellpadding="4" height="100%" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
                <tr> 
                  <td height="70" valign="top"> 
                    <table width="90%" border="1" cellspacing="0" cellpadding="3" align="center" height="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                      <tr> 
                        </tr>
                    </table>
                    <br>
                    <table width="54%" border="0" cellspacing="0" cellpadding="0" align="center">
                      <tr valign="top"> 
                        <td> 
                          <table width="100%" border="0" cellspacing="1" cellpadding="1">
                            <tr >
                              <td width="49%" align="center">&nbsp;<input type="radio" name="cmdnew" style="border:none" onClick="doNew()">&nbsp;<b>New</b> <br>
							   
							  </td>
                              <td width="51%" align="center">&nbsp;<input type="radio" name="cmdnew" style="border:none" onClick="doExisting()">&nbsp;<b>Existing</b></td>
                            </tr>
							<tr id="yearid"><br>
							  <td width="49%" align="center"> <b>Year</b> &nbsp; 
                                <input type="text" name="txt_year" size="5"
													maxlength="4" onKeyPress="allowInteger()"
													onBlur="callcheckyear();checkcurrentyear(this)"
													onChange="callcheckyear()"></td>
							<td width="51%" align="center">&nbsp;</td>
                               
							</tr>
                          
						    <tr>
							<td colspan="2">
							    <table width="590" id="existingid">
                                  <tr bgcolor="#71694F" bordercolordark="#82829F" bordercolorlight="#EBEBF8"  width="100%">
                                    <td width="49%" height="22" align="center"> <b>Year</b></td>
                                    <td width="51%" height="22" align="center"><b>Status</b></td>
							  </tr>
							    <% 
   ArrayList arrRow = (ArrayList)hshValues.get("arrRow");
    ArrayList arrCol=null;
  	if(arrRow!=null)
	{
	int vecsize =arrRow.size();
	for(int i=0;i<vecsize;i++)
	{ 
		arrCol=(ArrayList)arrRow.get(i);
		%>
                            <tr valign="top"> 
                              <td width="9%" align="center"><font size="1" face="MS Sans Serif" color="#000000" align="center"><a href ="javascript:callPage('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(1))%>','<%=Helper.correctNull((String)arrCol.get(2))%>')"><input type="hidden" name="hidYear" value="<%=Helper.correctNull((String)arrCol.get(0))%>"><%=Helper.correctNull((String)arrCol.get(0))%></a></font></td>
                              <td width="18%" align="center"><font size="1" face="MS Sans Serif" color="#000000" align="center"><%=Helper.correctNull((String)arrCol.get(1))%>&nbsp;</font></td>
                            </tr>
                            <%}
	}%>
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
  <br>
  <table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"align="center">
    <tr> 
      <td> 
        <table width="0%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="middle"> 
		  <td> 
              <input type="button" name="cmdapply" value="Save"
			class="buttonStyle" onClick="doSave()">
            </td>
            <td> 
                <input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="doClose()">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  
<input type="hidden" name="hidYear">
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanGetMethod">
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidSourceUrl">
<input type="hidden" name="cbsaccno" value="<%=Helper.correctNull((String)request.getParameter("cbsaccno"))%>">
<input type="hidden" name="reviewYear" value=""> 
<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)request.getParameter("cbsid"))%>">
<input type="hidden" name="hidmontype" value="<%=request.getParameter("hidmontype")%>">
<input type="hidden" name="hidprinttype" value="<%=request.getParameter("hidprinttype")%>">
<input type="hidden" name="cbsname" value="<%=Helper.correctNull((String)request.getParameter("cbsname"))%>">
 <input type="hidden" name="appstatus" value=""> 
 <input type="hidden" name="statusflag" value="">
</form>
</body>
</html>