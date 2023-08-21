<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	
	arrRow = ((ArrayList)hshValues.get("arrRow"));
	
	String[] strIncurred1= new String[23];
	String[] strIncurred2= new String[23];
	String[] strIncurred3= new String[23];
	String[] strIncurred4= new String[23];
	
	for(int i=0;i<strIncurred1.length;i++)
	{
		strIncurred1[i]="";
		strIncurred2[i]="";
		strIncurred3[i]="";
		strIncurred4[i]="";
		
	}
	
	if(arrRow!=null)
	{
		for(int i =0;i<arrRow.size();i++)
		{	
			arrCol = (ArrayList) arrRow.get(i);
			
			strIncurred1[i] = Helper.correctNull((String)arrCol.get(0));
			strIncurred2[i] = Helper.correctNull((String)arrCol.get(1));
			strIncurred3[i] = Helper.correctNull((String)arrCol.get(2));
			strIncurred4[i] = Helper.correctNull((String)arrCol.get(3));
		}	
	}
%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
	<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "<%=ApplicationParams.getAppUrl()%>";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js">
</script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var strReviewYear = "<%=Helper.correctNull((String)hshValues.get("strReviewYear"))%>";
var strUserId='<%=(String)session.getAttribute("strUserId")%>';
var strprocessby="<%=Helper.correctNull((String)hshValues.get("MON_TERMLOANREVIEW_TOUSRID"))%>";
var strstatus="<%=Helper.correctNull((String)hshValues.get("review_status"))%>";

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
	}
	
	if(val=="edit")
	{	 

		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	if(val=="new")
	{	 
	
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	

}
function callCalender(fname)
 {
	 if(document.forms[0].cmdsave.disabled==false)
	 {
	 	showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 	 }
 }


function onLoading()
{
	
	//disableCommandButtons("load");
	disableFields(true);
}
function doDelete()
{
	if(ConfirmMsg(101))
		{	
			document.forms[0].hidAction.value ="delete";
			document.forms[0].action=appURL+"action/ControllerServlet";		
			document.forms[0].hidBeanMethod.value="updateReviewFinancial";
			document.forms[0].hidBeanGetMethod.value="getReviewFinancial";
			document.forms[0].hidBeanId.value="reviewtermloan";
			document.forms[0].hidSourceUrl.value="action/reviewnotesmefinancial.jsp";	
			document.forms[0].method="post";			
			document.forms[0].submit();	
		}
}
function doEdit()
{ 	

    document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
}

function doNew()
{ 	
	disableFields(false);
    document.forms[0].hidAction.value ="insert";
	disableCommandButtons("new");	
	document.forms[0].reviewYear.disabled = true;
	clearAll();
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="";
		document.forms[0].hidBeanId.value="reviewtermloan";
		document.forms[0].hidBeanGetMethod.value="getReviewFinancial";
		document.forms[0].action=appURL +"action/reviewnotesmefinancial.jsp";
	    document.forms[0].submit();	
	}	
	
	disableCommandButtons("load");
}

	function doSave()
	{
	    document.forms[0].hidBeanId.value="reviewtermloan";
		document.forms[0].hidBeanMethod.value="updateReviewFinancial";
		document.forms[0].hidBeanGetMethod.value="getReviewFinancial";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/reviewnotesmefinancial.jsp";
		document.forms[0].submit();
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
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].disabled=val;
		}
		 
	}
	
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mon_borrowersearch.jsp?hidmontype=MONITREVIEW";
		document.forms[0].submit();
		
	}
}
function callOtherLink(page,bean,method)
{
	if(!document.forms[0].reviewYear.value=="")
	{
		document.forms[0].reviewOf.disabled=false;
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		alert("Select Review Year");
	}
}

</script>
</head>
<body  onload="onLoading()">
<form name="safaeri3" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<lapschoice:tlrtag pageid="6" reviewof='<%=Helper.correctNull((String)request.getParameter("reviewOf"))%>' valuesin='<%=Helper.correctNull((String)request.getParameter("valuesin"))%>' />
		</td>
	</tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
           
      <td valign="top" colspan="5" class="page_flow">Home -&gt; Term Loan - Review -&gt; Financial</td>
          </tr>
        </table>
 
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapschoice:MonitorReview />
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>   
<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		
          <tr> 
            <td width="30%">&nbsp;</td>
            <td width="18%"> 
              <input type="text" name="txt_incurred1" size="13" maxlength="12" style= "border-style=groove" border=1 value="<%=strIncurred1[0]%>" onBlur="checkDate(txt_incurred1[0])" readOnly>
              <a alt="Select date from calender"  href="javascript:callCalender('txt_incurred1[0]')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0" ></a></td>
            <td width="17%"> 
              <input type="text" name="txt_incurred2" size="13" maxlength="12" style= "border-style=groove" border=1 value="<%=strIncurred2[0]%>" onBlur="checkDate(txt_incurred2[0])" readOnly>
              <a alt="Select date from calender"  href="javascript:callCalender('txt_incurred2[0]')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0" ></a></td>
            <td width="18%"> 
              <input type="text" name="txt_incurred3" size="13" maxlength="12" style= "border-style=groove" border=1 value="<%=strIncurred3[0]%>" onBlur="checkDate(txt_incurred3[0])" readOnly>
              <a alt="Select date from calender"  href="javascript:callCalender('txt_incurred3[0]')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0" ></a></td>
           
          </tr>
          <tr> 
            <td width="30%">Paid-Up Capital</td>
            <td width="18%"> <lapschoice:CurrencyTag  name="txt_incurred1" size="12"   value='<%=strIncurred1[1]%>' maxlength="11" /> 
            </td>
            <td width="17%"> <lapschoice:CurrencyTag  name="txt_incurred2" size="12"   value='<%=strIncurred2[1]%>' maxlength="11" /> 
            </td>
            <td width="18%"> <lapschoice:CurrencyTag  name="txt_incurred3" size="12"   value='<%=strIncurred3[1]%>' maxlength="11" /> 
            </td>
          </tr>
          <tr> 
            <td width="30%">Tangible Net Worth (TNW)</td>
            <td width="18%"> <lapschoice:CurrencyTag  name="txt_incurred1" size="12"   value='<%=strIncurred1[2]%>' maxlength="11" /> 
            </td>
            <td width="17%"> <lapschoice:CurrencyTag  name="txt_incurred2" size="12"   value='<%=strIncurred1[2]%>' maxlength="11" /> 
            </td>
            <td width="18%"> <lapschoice:CurrencyTag  name="txt_incurred3" size="12"   value='<%=strIncurred1[2]%>' maxlength="11" /> 
            </td>
           
          </tr>
          <tr> 
            <td width="30%">Sales</td>
            <td width="18%"> <lapschoice:CurrencyTag  name="txt_incurred1" size="12"   value='<%=strIncurred1[3]%>' maxlength="11" /> 
            </td>
            <td width="17%"> <lapschoice:CurrencyTag  name="txt_incurred2" size="12"   value='<%=strIncurred2[3]%>' maxlength="11" /> 
            </td>
            <td width="18%"> <lapschoice:CurrencyTag  name="txt_incurred3" size="12"   value='<%=strIncurred3[3]%>' maxlength="11" /> 
            </td>
            
          </tr>
          <tr> 
            <td width="30%">Profit Before Tax (PBT)</td>
            <td width="18%"> <lapschoice:CurrencyTag  name="txt_incurred1" size="12"   value='<%=strIncurred1[4]%>' maxlength="11" /> 
            </td>
            <td width="17%"> <lapschoice:CurrencyTag  name="txt_incurred2" size="12"   value='<%=strIncurred2[4]%>' maxlength="11" /> 
            </td>
            <td width="18%"> <lapschoice:CurrencyTag  name="txt_incurred3" size="12"   value='<%=strIncurred3[4]%>' maxlength="11" /> 
            </td>
            
          </tr>
          <tr> 
            <td width="30%">Profit After Tax (PAT)</td>
            <td width="18%"> <lapschoice:CurrencyTag  name="txt_incurred1" size="12"   value='<%=strIncurred1[5]%>' maxlength="11" /> 
            </td>
            <td width="17%"> <lapschoice:CurrencyTag  name="txt_incurred2" size="12"   value='<%=strIncurred2[5]%>' maxlength="11" /> 
            </td>
            <td width="18%"> <lapschoice:CurrencyTag  name="txt_incurred3" size="12"   value='<%=strIncurred3[5]%>' maxlength="11" /> 
            </td>
          
          </tr>
          <tr> 
            <td width="30%">Current Ratio (CR)</td>
            <td width="18%"> <lapschoice:CurrencyTag  name="txt_incurred1" size="12"   value='<%=strIncurred1[6]%>' maxlength="11" /> 
            </td>
            <td width="17%"> <lapschoice:CurrencyTag  name="txt_incurred2" size="12"   value='<%=strIncurred2[6]%>' maxlength="11" /> 
            </td>
            <td width="18%"> <lapschoice:CurrencyTag  name="txt_incurred3" size="12"   value='<%=strIncurred3[6]%>' maxlength="11" /> 
            </td>
           
          </tr>
          <tr> 
            <td width="30%">Debit Equity Ratio [DER]</td>
            <td width="18%"> <lapschoice:CurrencyTag  name="txt_incurred1" size="12"   value='<%=strIncurred1[7]%>' maxlength="11" /> 
            </td>
            <td width="17%"> <lapschoice:CurrencyTag  name="txt_incurred2" size="12"   value='<%=strIncurred2[7]%>' maxlength="11" /> 
            </td>
            <td width="18%"> <lapschoice:CurrencyTag  name="txt_incurred3" size="12"   value='<%=strIncurred3[7]%>' maxlength="11" /> 
            </td>
          
          </tr>
          <tr> 
            <td width="30%">Ratio of Total Outside liabilities to TNW</td>
            <td width="18%"> <lapschoice:CurrencyTag  name="txt_incurred1" size="12"   value='<%=strIncurred1[8]%>' maxlength="11" /> 
            </td>
            <td width="17%"> <lapschoice:CurrencyTag  name="txt_incurred2" size="12"   value='<%=strIncurred2[8]%>' maxlength="11" /> 
            </td>
            <td width="18%"> <lapschoice:CurrencyTag  name="txt_incurred3" size="12"   value='<%=strIncurred3[8]%>' maxlength="11" /> 
            </td>
          
          </tr>
          <tr> 
            <td width="30%">&nbsp;</td>
            <td width="18%">&nbsp;</td>
            <td width="17%">&nbsp;</td>
            <td width="18%">&nbsp;</td>
          </tr>
          
		  
        	<tr>
				<td colspan="5"><b>Comments on Financial Highlights</b>&nbsp;</td>
			</tr>
			<tr>
				
				<td colspan="5">
				 <textarea name="txt_fincomments" cols="120" rows="10" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%= Helper.correctNull((String)hshValues.get("comments"))%></textarea>
                   </td>
			</tr>
        </table>
      </td>
     </tr>
  </table><br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br><iframe id="ifrm" src="" width="100%" height="0" border=no > </iframe>  
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="org_code" value="<%=strOrgCode%>"> 
<input type="hidden" name="remarksFlag" value="false"> 
<input type="hidden" name="hideditoption" value="N"> 
<input type="hidden" name="txt_usrid" value="<%=session.getAttribute("strUserId") %>"> 
<input type="hidden" name="Stateflag"> 
<input type="hidden" name="reviewOf" value="<%=request.getParameter("reviewOf")%>">
<input type="hidden" name="mail_touserclass">
</form>
</body>
<script language="javascript1.2">
editor_generate('txt_fincomments');
</script>
</html>

