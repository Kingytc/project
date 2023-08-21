<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.ArrayList"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<laps:handleerror />
<%ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();
			String strbanktype = "";
			strbanktype = Helper.correctNull((String) request
					.getParameter("banktype"));
			if (strbanktype.equals("")) {
				strbanktype = Helper.correctNull((String) request
						.getParameter("hidbanktype"));
			}
%>

<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/link.css" type="text/css" />
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css" />
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>

<script>

var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";

function disableCommandButtons(valnew,valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdnew.disabled=valnew;
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmddel.disabled=valdel;
	document.forms[0].cmdapply.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmdclose.disabled=valclose;		 
}

function doNew()
{
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons(true,true,false,false,true,true);
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons(true,true,false,false,false,true);
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getdepaccountdata";
		document.forms[0].action=appUrl +"action/npa_otherdepositaccountdetails.jsp";
		document.forms[0].submit(); 		
	}	
}

function doSave()
{
	document.forms[0].hidSourceUrl.value="/action/npa_otherdepositaccountdetails.jsp";
	document.forms[0].hidBeanId.value="npacommon";
	document.forms[0].hidBeanMethod.value="updatedepaccountdata";
	document.forms[0].hidBeanGetMethod.value="getdepaccountdata";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}


function callLink(page,bean,method)
	{
	if (document.forms[0].cmdapply.disabled)
			{
			document.forms[0].hidBeanGetMethod.value=method;
			document.forms[0].hidBeanId.value=bean;
			document.forms[0].action=appUrl+"action/"+page;
			document.forms[0].submit();
			}
			else
			{
				ShowAlert(103);
			}
	}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/npa_otherdepositaccountdetails.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updatedepaccountdata";
		document.forms[0].hidBeanGetMethod.value="getdepaccountdata";
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
		if(document.forms[0].elements[i].type=='radio')
	 	{
			document.forms[0].elements[i].disabled=!val;
		}		  
		 
	}
	
	
}
function onLoading()
{
	disableCommandButtons(false,true,true,true,true,false);
	disableFields(true);
}
function doClose()
	{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/npa_mainlinknav.jsp";
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


function selectValues(val1,val2,val3,val4,val5,val6)
{
	document.forms[0].hidsno.value=val1;
	document.forms[0].txt_concern.value=val2;
	document.forms[0].txt_partners.value=val3;
	document.forms[0].txt_bankers.value=val4;
	document.forms[0].txt_limit.value=val5;
	document.forms[0].status.value=val6;
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
    	disableCommandButtons(true,false,true,false,false,true);
    }
}
</script>
</head>
<body onload="onLoading()">
<form name="prudential_appltmeans" method="post">
<lapstab:suiturltag pageid="1"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td valign="top" class='page_flow'>Home -&gt; NPA-&gt;
		Suit File -&gt; Banking Details -&gt; Deposit Accounts</td>
	</tr>
</table>
<laps:npaapplication />
<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />
<lapstab:npabankingdetails module='<%=Helper.correctNull((String)request.getParameter("hidmoduletype"))%>' pageid="6" bankarrangement='<%=Helper.correctNull((String)request.getParameter("hidbankarrangement"))%>'/>
  <table width="100%" border="1" cellspacing="0" cellpadding="4"
	bordercolordark="#DEDACF" bordercolorlight="#FFFFFB">
    <tr> 
      <td><b>Name of Account Holder</b></td>
      <td> 
        <input type="text" name="txt_acctholdname" size="35" maxlength="30" tabindex="10">
      </td>
      <td><b>Relation</b></td>
      <td> 
        <input type="text" name="txt_relation" size="35" maxlength="30" tabindex="10">
      </td>
    </tr>
    <tr> 
      <td><b>Type Of Account</b></td>
      <td> 
        <input type="text" name="txt_accnttype" size="35" maxlength="30" tabindex="10">
      </td>
      <td><b>Outstanding Amount<%=ApplicationParams.getCurrency()%></b></td>
      <td><laps:CurrencyTag name="txt_osamt" size="25" tabindex="12" maxlength="15" /></td>
    </tr>
    
  </table>
  <laps:combutton btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' btntype="NO"/> 
  <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
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
                      <td width="17%" class="tabactive" align="center"><b>Name 
                        of Account Holder</b></td>
                      <td width="20%" class="tabactive" align="center"><b>Relation</b></td>
                      <td width="20%" class="tabactive" align="center"><b>Type 
                        Of Account</b></td>
                      <td class="tabactive" align="center"><b>Outstanding Amoun</b></td>
                     
                    </tr>
                    <%
                     
                  arrRow=(ArrayList)hshValues.get("arrRow");
					if(arrRow.size()>0 && arrRow!=null)
					{
						for(int i=0;i<arrRow.size();i++)
						{
						arrCol = (ArrayList)arrRow.get(i);
					%>
                    <tr> 
                      <td width="3%" align=center> 
                        <input type="radio" 
													style="border:none" name="radiobutton" value="radiobutton"
													onClick="selectValues('<%=Helper.correctNull((String)arrCol.get(0))%>',
													'<%=Helper.correctNull((String)arrCol.get(1))%>',
													'<%=Helper.correctNull((String)arrCol.get(2))%>',
													'<%=Helper.correctNull((String)arrCol.get(3))%>',
													'<%=Helper.correctNull((String)arrCol.get(4))%>',
													'<%=Helper.correctNull((String)arrCol.get(6))%>')">
                      </td>
                      <td width="17%">&nbsp;<%=Helper.correctNull((String)arrCol.get(1))%></td>
                      <td width="20%"><%=Helper.correctNull((String)arrCol.get(2))%></td>
                      <td width="20%">&nbsp;<%=Helper.correctNull((String)arrCol.get(3))%></td>
                      <td width="15%" align="right">&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%></td>
                     
                    </tr>
                    <%
					 }
					 }
				  	else
                	{
               %>
                    <tr> 
                      <td align center colspan="5">No Data Found</td>
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
  </table>
<laps:hiddentag/>
<input type="hidden" name="hidsno" value="<%=Helper.correctNull((String)hshValues.get("PRE_SNO"))%>" /> 
<input type="hidden" name="hidbanktype" value="<%=strbanktype%>"/>  
<input type="hidden" name="hidclaimsettled" value="<%=Helper.correctNull((String)request.getParameter("hidclaimsettled"))%>" />
<input type="hidden" name="hidbankarrangement" value="<%=Helper.correctNull((String)request.getParameter("hidbankarrangement"))%>">
</form>
</body>
</html>
