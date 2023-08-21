<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<laps:handleerror />
<%
String strCategoryType="";
String strSSIType="";
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
strCategoryType=Helper.correctNull((String) request.getParameter("hidCategoryType"));
strSSIType = Helper.correctNull((String) request.getParameter("hidSSIType"));
arrRow=(ArrayList)hshValues.get("arrRow");

String strAppno=Helper.correctNull((String)request.getParameter("appno"));

%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>

<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varfacility="<%=Helper.correctNull((String)hshValues.get("facilitysno"))%>";
var varcharge="<%=Helper.correctNull((String)hshValues.get("naturecharge"))%>";
var varsecurities="<%=Helper.correctNull((String)hshValues.get("secutities"))%>";

function loadData()
{
	if(document.forms[0].selfacility.value=="s")
	{
		ShowAlert('121','Facility');
		return;
	}
	if(document.forms[0].selcharge.value=="s")
	{
		ShowAlert('121','Nature of Charge');
		return;
	}
	
	document.forms[0].hidBeanId.value="comsecurities";
	document.forms[0].hidBeanGetMethod.value="getChargeData";
	document.forms[0].action=appURL+"action/comsecuritycharges.jsp";
	document.forms[0].submit();
	
}

function onLoad()
{
	if(varfacility!="")
	{
		document.forms[0].selfacility.value=varfacility;
	}
	if(varcharge!="")
	{
		document.forms[0].selcharge.value=varcharge;
	}
	if(varsecurities!="")
	{
		varsecarr=varsecurities.split("@");	
		for(var i=0;i<varsecarr.length-1;i++)
		{
			var selValue=varsecarr[i];
			for(var j=0;j<document.forms[0].selsecurities.length;j++)
			{
				if(document.forms[0].selsecurities.options[j].value==selValue)
				{
					document.forms[0].selsecurities.options[j].selected=true
				}
			}
		}
	}
	
	disableFields(true);	
}


function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="select-multiple")
		{
			document.forms[0].elements[i].disabled=val;		
		}
	}
}

function enableButtons(valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmdapply.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddel.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
}

function doEdit()
{
	document.forms[0].hidAction.value="Update";
	disableFields(false);
	enableButtons(true,false,false,true,true);
}

function doSave()
{
	var varsec="";
	for(var i=0;i<document.forms[0].selsecurities.options.length;i++)
	{
		if(document.forms[0].selsecurities.options[i].selected)
		{				
			varsec=varsec+document.forms[0].selsecurities.options[i].value+"@";
		}		
	}
	document.forms[0].hidsecurities.value = varsec;
	document.forms[0].cmdapply.disabled = true;
	document.forms[0].hidBeanId.value="comsecurities";
	document.forms[0].hidBeanMethod.value="updateChargeData";
	document.forms[0].hidBeanGetMethod.value="getChargeData";
	document.forms[0].hidSourceUrl.value="/action/comsecuritycharges.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{
	document.forms[0].hidBeanId.value="comsecurities";
	document.forms[0].hidBeanGetMethod.value="getChargeData";
	document.forms[0].action=appURL+"action/comsecuritycharges.jsp";
	document.forms[0].submit();
}

function doDelete()
{
	document.forms[0].hidAction.value="Delete";
	document.forms[0].hidBeanId.value="comsecurities";
	document.forms[0].hidBeanMethod.value="updateChargeData";
	document.forms[0].hidBeanGetMethod.value="getChargeData";
	document.forms[0].hidSourceUrl.value="/action/comsecuritycharges.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
	    document.forms[0].action=appURL+"action/"+"comsearch.jsp?id=<%=session.getAttribute("comappid")%>&hidPageType=<%=session.getAttribute("link")%>";	
		document.forms[0].submit();
	}
}
</script>


</head>

<body onload="onLoad()">
<form name="frmpri" method=post>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td valign="top" colspan=5> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true"> 
        <jsp:param name="pageid" value="11" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
  </table>
  <b><i>Home-&gt; 
  <%if(strCategoryType.equalsIgnoreCase("OPS")){ %>
  Tertiary 
  <%}else { %>
  Corporate 
  <%} %>
  -&gt; Applicant -&gt; Security/s</i></b><br>
  <span style="display:none"><laps:borrowertype /></span> <laps:application /> 
  <laps:hiddentag/> <lapstab:ComsecurityTab tabid="2" cattype='<%=strCategoryType%>'/>
  <table width="100%" border="1" cellspacing="0" cellpadding="5"
bgcolor="#DEDACF" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="2" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="18%" align="left">Select Facilities</td>
                  <td width="82%"> 
                    <select name="selfacility" onChange="loadData()">
                      <option value="s" selected>&lt;--- Select ---&gt;</option>
                      <laps:ramfacility /> 
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td width="15%"><b>Nature of Charge</b></td>
                  <td width="28%"> 
                    <select
					name="selcharge" onChange="loadData()">
                      <option value="s" selected>&lt;--Select--&gt;</option>
                      <option value="1">Exclusive</option>
                      <option value="3">First &amp; Parri-passu</option>
                      <option value="2">Second &amp; Exclusive</option>
                      <option value="5">Second &amp; Parri-passu</option>
                      <option value="4">Subservient &amp; Exclusive</option>
                      <option value="5">Subservient &amp; Parri-passu</option>
                      <option value="6">Unsecured</option>
                    </select>
                  </td>
                </tr>
                <tr>
                  <td width="15%">Securities</td>
                  <td width="28%">
                    <select name="selsecurities" size="10" multiple>
                    <laps:comsecurities appno='<%=strAppno%>'/>
                    </select>
                  </td>
                </tr>
              </table>
              <br>
              <laps:combutton btntype="EO" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
 <input type="hidden" name="hidsecurities"/>
</form>
</body>
</html>
