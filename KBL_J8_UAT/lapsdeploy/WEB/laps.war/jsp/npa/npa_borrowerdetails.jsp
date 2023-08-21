<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />
<%
ArrayList vecRow=(ArrayList)hshValues.get("vecRow");
ArrayList vecCol=new ArrayList();	
java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);
%>

<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<style>
.td,tr{font-family: "MS Sans Serif";
	font-size: 11px;
	}


</style>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/link.css" type="text/css"/>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>

<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
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
	}
	if(val=="radioselect")
	{	 
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddel.disabled=false;
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}	  
}
function selectValues(val1,val2,val3,val4,val5,val6,val7,val8)
{
	document.forms[0].hid_strsno.value=val1;
	document.forms[0].sel_type_applicant.value=val2;
	document.forms[0].txt_name_applicant.value=val3;
	document.forms[0].txt_present_activity.value=val4;
	document.forms[0].txt_renew_means.value=val5;
	document.forms[0].txt_renew_date.value=val6;
	document.forms[0].txt_present_means.value=val7;
	document.forms[0].txt_present_date.value=val8;
	
    disableCommandButtons("radioselect");
	
}
function doNew()
{
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");	
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/npa_borrowerdetails.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getBorrowerDetails";
		document.forms[0].hidBeanMethod.value="updateBorrwerDetails";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 		
	}	
	
	disableCommandButtons("load");
}

function doSave()
{
		document.forms[0].hidSourceUrl.value="/action/npa_borrowerdetails.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updateBorrwerDetails";
		document.forms[0].hidBeanGetMethod.value="getBorrowerDetails";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/npa_borrowerdetails.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updateBorrwerDetails";
		document.forms[0].hidBeanGetMethod.value="getBorrowerDetails";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
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
function onLoading()
{
		
		disableCommandButtons("load");
}
function doClose()
	{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/corppge.jsp";
		document.forms[0].submit();
		
	}
}	
function callCalender(name)
{
	if(document.forms[0].cmdapply.disabled==false)
	{
		showCal(appUrl,name);
		
	}
}

</script>

</head>
<body text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" font-family="arial" font-size="11px" onload="onLoading()">
<form name="safaeri2" method="post">


<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><lapschoice:application /></td>
	</tr>
</table>
  <table width="100%" border="0" cellspacing="1" cellpadding="3">
    <tr> 
      <td colspan="4" align="center"><b>MEANS</b></td>
    </tr>
    <tr> 
      <td>TYPE OF APPLICANT</td>
      <td> 
        <select  name="sel_type_applicant" >
          <option value="s">--SELECT--</option>
          <option value="a">APPLICANT(S)</option>
          <option value="g">GUARANTOR</option>
        </select>
      </td>
      <td>NAME OF APPLICANT</td>
      <td> 
        <input type="text" name="txt_name_applicant" size="30"
				maxlength="25" tabindex="22" 
				value="<%//=Helper.correctNull((String)hshValues.get("date_documents"))%>">
      </td>
    </tr>
    <tr> 
      <td>PRESENT ACTIVITY OF APPLICANT</td>
      <td> 
        <textarea rows="2" name="txt_present_activity" cols="50" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%//=Helper.correctNull((String)hshValues.get("complaint_received"))%></textarea>
      </td>
      <td>&nbsp;</td>
      <td>&nbsp; </td>
    </tr>
    <tr> 
      <td colspan="4">: <b>AT THE TIME OF RENEWAL </b></td>
    </tr>
    <tr> 
      <td>MEANS</td>
      <td> 
        <input type="text" name="txt_renew_means" size="20"
				maxlength="15" tabindex="22" 
				value="<%//=Helper.correctNull((String)hshValues.get("date_documents"))%>" >
      </td>
      <td>DATE</td>
      <td> 
        <input type="text" name="txt_renew_date" size="20"
				maxlength="10" tabindex="22" 
				value="<%//=Helper.correctNull((String)hshValues.get("date_documents"))%>" onBlur="checkDate(this)">
        <a href="#" onClick="callCalender('txt_renew_date')"
				title="Click to view calender" border=0><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="23"></a> </td>
    </tr>
    <tr> 
      <td ><b>PRESENT POSITION</b></td>
      <td >&nbsp; </td>
      <td >&nbsp;</td>
      <td >&nbsp; </td>
    </tr>
    <tr> 
      <td > MEANS </td>
      <td > 
        <input type="text" name="txt_present_means" size="20"
				maxlength="15" tabindex="22" 
				value="<%//=Helper.correctNull((String)hshValues.get("date_documents"))%>" >
      </td>
      <td > DATE</td>
      <td > 
        <input type="text" name="txt_present_date" size="20"
				maxlength="10" tabindex="22" 
				value="<%//=Helper.correctNull((String)hshValues.get("date_documents"))%>" onBlur="checkDate(this)" >
        <a href="#" onClick="callCalender('txt_present_date')"
				title="Click to view calender" border=0><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="23"></a> </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td>&nbsp; </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table>
 <table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
                      <tr> 
                        <td> 
                          <table border="0" cellspacing="0" cellpadding="2" align="center">
                            <tr valign="top"> 
                              <td> 
                                <input type="button" name="cmdnew" value="New" class="buttonStyle" onClick="doNew()">
                              </td>
                              <td> 
                                <input type="button" name="cmdedit" value="Edit" class="buttonStyle" onClick="doEdit()">
                              </td>
                              <td> 
                                <input type="button" name="cmdapply" value="Save" class="buttonStyle"  onClick="doSave()" >
                              </td>
                              <td> 
                                <input type="button" name="cmdcancel" value="Cancel" class="buttonStyle" onClick="doCancel()" >
                              </td>
                              <td> 
                                <input type="button" name="cmddel" value="Delete" class="buttonStyle"  onClick="doDelete()" >
                              </td>
                              <td> 
                                <input type="button" name="cmdhelp" value="Help" class="buttonHelp" onClick="dohlpp()">
                              </td>
                              <td align="center"> 
                                <input type="button" name="cmdclose" value="Close" onClick="doClose()" class="buttonClose">
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
  <tr align="center"> 
                  <td colspan="2"> 
                    <div class="cellContainer"> 
                      <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
                        <tr> 
                          <td valign="top"> 
                            <div align="left"> 
                              
                <table width="100%" border="1" cellspacing="0" cellpadding="0">
                  <tr> 
                    <td width="3%" class="tabactive">&nbsp;</td>
                    <td width="17%" class="tabactive" align="center">&nbsp;</td>
                    <td width="20%" class="tabactive" align="center">&nbsp;</td>
                    <td colspan="2" class="tabactive" align="center"><b>AT THE 
                      TIME OF RENEWAL</b></td>
                    <td class="tabactive" align="center" colspan="2"><b>PRESENT 
                      POSITION</b></td>
                  </tr>
                  <tr> 
                    <td width="3%" class="tabactive">&nbsp;</td>
                    <td width="17%" class="tabactive" align="center"><b>TYPE OF 
                      APPLICANT</b></td>
                    <td width="20%" class="tabactive" align="center"><b>NAME OF 
                      APPLICANT</b></td>
                    <td width="15%" class="tabactive" align="center">&nbsp;</td>
                    <td width="16%" class="tabactive" align="center">&nbsp;</td>
                    <td width="13%" class="tabactive" align="center"> <b> </b></td>
                    <td width="16%" class="tabactive" align="center">&nbsp;</td>
                  </tr>
                  <%
                     
                  vecRow=(ArrayList)hshValues.get("vecRow");
					if(vecRow.size()>0 && vecRow!=null)
					{
						for(int i=0;i<vecRow.size();i++)
						{
						vecCol = (ArrayList)vecRow.get(i);
					%>
                  <tr> 
                     <td width="3%" align=center><font size="1" face="MS Sans Serif"> 
                      <input type="radio" 
													style="border:none" name="radiobutton" value="radiobutton"
													onClick="selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
													'<%=Helper.correctNull((String)vecCol.get(1))%>','<%=Helper.correctNull((String)vecCol.get(2))%>',
													'<%=Helper.correctNull((String)vecCol.get(3))%>','<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(4))))%>',
                            	'<%=Helper.correctNull((String)vecCol.get(5))%>','<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(6))))%>',
                            	'<%=Helper.correctNull((String)vecCol.get(7))%>')">
                      </font></td>
                      <%String applicant=Helper.correctNull((String)vecCol.get(1));
                      if(applicant.equalsIgnoreCase("a"))
                      {
                    	  applicant="APPLICANT"; 
                      }
                      else if(applicant.equalsIgnoreCase("g"))
                      {
                    	  applicant="GUARANTOR";
                      }%>
                    <td width="17%">&nbsp;<%=applicant%></td>
                    <td width="20%">&nbsp;<%=Helper.correctNull((String)vecCol.get(2))%></td>
                    <td width="15%">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(4))))%></td>
                    <td width="16%">&nbsp;<%=Helper.correctNull((String)vecCol.get(5))%></td>
                    <td width="13%" align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(6))))%></td>
                    <td width="16%" align="right"><%=Helper.correctNull((String)vecCol.get(7))%></td>
                  </tr>
                  <%
					 }
					 }
				  	else
                	{
               %>
                  <tr> 
                    <td align center colspan="9"><font size="1" face="MS Sans Serif">No 
                      Data Found</font></td>
                  </tr>
                  <%
                	}
                %>
                </table>
                            </div>
                          </td>
                        </tr>
                      </table>
                    </div>
                  </td>
                </tr>
<input type="hidden" name="hidAction" />
<input type="hidden" name="hidBeanId" />
<input type="hidden" name="hidBeanMethod" value="" />
<input type="hidden" name="hidBeanGetMethod" value="" />
<input type="hidden" name="hidSourceUrl" />
<input type="hidden" name="hid_strsno" value="<%=Helper.correctNull((String)hshValues.get("PRE_SNO"))%>"/>

</form>
</body>
</html>