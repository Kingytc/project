<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
 if(objValues instanceof java.util.HashMap)
 {
	  hshValues=(java.util.HashMap)objValues;
 }	
	HashMap ht=(HashMap)hshValues.get("hsh4");
ArrayList vec = null;
int vecsize=0;
 if (ht != null)
 {  
	 vec = (ArrayList)ht.get("vecVal");  
 }
if(vec!=null)
{
	vecsize =vec.size();	
}
%>
<html>
<head>
<title>Small Scale Industries</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="file:///C|/tomcat/webapps/boblaps/css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="javascript" >
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varRecordflag = "<%=Helper.correctNull((String)ht.get("recordflag"))%>";
function whileLoading()
{
	disableFields(true);
	document.forms[0].hidOtherMethod.value="getProductInformData";
}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;	
	document.forms[0].cmddelete.disabled=bool4
	document.forms[0].cmdclose.disabled=bool5;
}
function disableFields(val)
{		
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}			
	}
}
function doDelete()
{
	document.forms[0].hidVal.value="Delete";
	
	if(ConfirmMsg("101"))
  {
	document.forms[0].hidAction.value="Delete";
	document.forms[0].hidBeanId.value="arrears";
	document.forms[0].hidBeanMethod.value="updateSSIAB10Data";
	document.forms[0].hidSourceUrl.value="/action/ssiab10_product_info.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
 
}
}
  function doCancel()
	{	
		if(ConfirmMsg(102))
	{					
			document.forms[0].hidBeanGetMethod.value="getData";
			document.forms[0].hidBeanId.value="arrears";
			document.forms[0].action=appUrl+"action/ssiab10_product_info.jsp";			
			document.forms[0].submit();
	}				
	}
function doClose()
{
	if(ConfirmMsg(100))
	{ 
		document.forms[0].action=appUrl+"action/agrpage.jsp";
		document.forms[0].submit();
	}
}
 function doEdit()
  { 	
	disableFields(false);
	enableButtons(true,false,false,false,true);	
	document.forms[0].hidAction.value="Update";
	document.forms[0].hideditflag.value="Y";
 }
function doSave()
 {
 	var varsubmit;
	var i=0;
	if(trim(document.forms[0].prodname[i].value)=="")
	{
		ShowAlert('121','Name of item');
		document.forms[0].prodname[i].focus();
		return;
	}
	else 
		{
		for(var i=0;i<8;i++)
			{
			if(trim(document.forms[0].prodname[i].value)!="")
				{
				if(trim(document.forms[0].quantreq[i].value)=="")
					{
					ShowAlert('121','quantity required');
					document.forms[0].quantreq[i].focus();
					return;
					}				
				}
			else
				{				
				if(trim(document.forms[0].quantreq[i].value)!="")
					{
					ShowAlert('121','Name of item');
					document.forms[0].prodname[i].focus();
					return;
					}				
				}
			}
		}
	        for(var i=0;i<8;i++)
	        {
			if(trim(document.forms[0].source[i].value)!="")
			{
				if(trim(document.forms[0].prodname[i].value)=="")
				{
					ShowAlert('121','Name of item');
					document.forms[0].prodname[i].focus();
					return;
				}
				else if(trim(document.forms[0].quantreq[i].value)=="")
				{
					ShowAlert('121','quantity required');
					document.forms[0].quantreq[i].focus();
					return;
				}
					
			}
			if(trim(document.forms[0].minquant[i].value)!="")
			{
				if(trim(document.forms[0].prodname[i].value)=="")
				{
					ShowAlert('121','Name of item');
					document.forms[0].prodname[i].focus();
					return;
				}
				else if(trim(document.forms[0].quantreq[i].value)=="")
				{
					ShowAlert('121','quantity required');
					document.forms[0].quantreq[i].focus();
					return;
				}
			}
			if(trim(document.forms[0].leadprotime[i].value)!="")
			{
				if(trim(document.forms[0].prodname[i].value)=="")
				{
					ShowAlert('121','Name of item');
					document.forms[0].prodname[i].focus();
					return;
				}
				else if(trim(document.forms[0].quantreq[i].value)=="")
				{
					ShowAlert('121','quantity required');
					document.forms[0].quantreq[i].focus();
					return;
				}
			}
			if(trim(document.forms[0].availableyr[i].value)!="")
			{
				if(trim(document.forms[0].prodname[i].value)=="")
				{
					ShowAlert('121','Name of item');
					document.forms[0].prodname[i].focus();
					return;
				}
				else if(trim(document.forms[0].quantreq[i].value)=="")
				{
					ShowAlert('121','quantity required');
					document.forms[0].quantreq[i].focus();
					return;
				}
			}
			if(trim(document.forms[0].noofmonths[i].value)!="")
			{
				if(trim(document.forms[0].prodname[i].value)=="")
				{
					ShowAlert('121','Name of item');
					document.forms[0].prodname[i].focus();
					return;
				}
				else if(trim(document.forms[0].quantreq[i].value)=="")
				{
					ShowAlert('121','quantity required');
					document.forms[0].quantreq[i].focus();
					return;
				}
			}
	        }
			
		
				document.forms[0].hidRecordflag.value = varRecordflag;
				document.forms[0].hidBeanGetMethod.value="updateSSIAB10Data";
				document.forms[0].hidBeanId.value="arrears";
				document.forms[0].action=appUrl+"action/ssiab10_product_info.jsp";	
				document.forms[0].submit();		
 }
</script>
</head>
<body onload="javascript:whileLoading()">
<form name="productinform" method="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
  <tr> 
  <td> 
    <jsp:include page="../share/applurllinkscom.jsp" flush="true">
    <jsp:param name="pageid" value="5" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
	  <jsp:param name="ssitype" value="<%=strSSIType%>" />
    </jsp:include>
  </td>
  </tr>
  <tr> 
    <td class="page_flow">Home -&gt; Tertiary -&gt; Application -&gt; Tech. Feasibility  -&gt; Raw Materials
 </td>
    </tr>
   </table>  
  
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/> 
<lapschoice:Techfeasibilitytab tabid="3" typessi='<%=strSSIType%>'/>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
  <tr> 
  <td valign="top"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
      <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
        <tr> 
        <td> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
          <tr class="dataheader"> 
          <td colspan="7"><b>How 
            Activity was carried out so far ( to be filled up 
            in case of existing units only)</b></td>
          </tr>
          <tr class="dataheader"> 
          <td width="15%" align="center" >Name/Brief Desc of item (<span class="mantatory">*</span>)</td>
          <td width="16%" align="center" >Quantity Required (<span class="mantatory">*</span>)</td>
          <td width="12%" align="center" >Source of Supply</td>
          <td width="13%" align="center" >Min. Purchase Quantity</td>
          <td width="13%" align="center" >Lead/Procurement Time </td>
          <td width="11%" align="center" >Available throughout<br>Year </td>
          <td width="20%" align="center" >If the answer to the<br>previous is no, then No.<br>of months it is available</td>
          </tr>
          <%
					ArrayList g1=null;					
					 for (int l=0;l<10;l++)
					 {							
							int colSize=0;						 
						 if(l<vecsize)
						 {
							 g1 = (ArrayList)vec.get(l);
							if(g1!=null)
							{
							 colSize = g1.size();
   						}
						 }											
						 if(colSize>0)	
						  {%>
          <tr class="datagrid"> 
          <td width="15%"  align="center"> 
            <input type="text" name="prodname" size="15" maxlength="50" value="<%=Helper.correctNull((String)g1.get(2))%>" >
          </td>
          <td width="16%"  align="center"> 
            <input type="text" name="quantreq" size="15" maxlength="20" value="<%=Helper.correctNull((String)g1.get(3))%>" onKeyPress="allowNumber(this)">
          </td>
          <td width="12%" align="center" > 
            <input type="text" name="source" size="15" maxlength="50" value="<%=Helper.correctNull((String)g1.get(4))%>" onKeyPress="notAllowSplChar()">
          </td>
          <td width="13%" align="center" > 
            <input type="text" name="minquant" size="15" maxlength="20" value="<%=Helper.correctNull((String)g1.get(5))%>" onKeyPress="allowNumber(this)">
          </td>
          <td width="13%" align="center" > 
            <input type="text" name="leadprotime" size="15" maxlength="20" value="<%=Helper.correctNull((String)g1.get(6))%>" onKeyPress="notAllowSplChar()">
          </td>
          <td width="11%" align="center" > 
            <input type="text" name="availableyr" size="15" maxlength="50" value="<%=Helper.correctNull((String)g1.get(7))%>" onKeyPress="notAllowSplChar()">
          </td>
          <td width="20%" align="center" > 
            <input type="text" name="noofmonths" size="20" maxlength="3" value="<%=Helper.correctNull((String)g1.get(8))%>" onKeyPress="allowInteger(this)">
          </td>
          </tr>
          <%}else{%>
          <tr class="datagrid"> 
          <td width="15%"  align="center"> 
            <input type="text" name="prodname" size="15" maxlength="50" >
          </td>
          <td width="16%"  align="center"> 
            <input type="text" name="quantreq" size="15" maxlength="20"  onKeyPress="allowNumber(this)">
          </td>
          <td width="12%" align="center" > 
            <input type="text" name="source" size="15" maxlength="50"  onKeyPress="notAllowSplChar()">
          </td>
          <td width="13%" align="center" > 
            <input type="text" name="minquant" size="15" maxlength="20"  onKeyPress="allowNumber(this)">
          </td>
          <td width="13%" align="center" > 
            <input type="text" name="leadprotime" size="15"  maxlength="20"  onKeyPress="notAllowSplChar()">
          </td>
          <td width="11%" align="center" > 
            <input type="text" name="availableyr" size="15" maxlength="50"  onKeyPress="notAllowSplChar()">
          </td>
          <td width="20%" align="center" > 
            <input type="text" name="noofmonths" size="20" maxlength="3"  onKeyPress="allowInteger(this)">
          </td>
          </tr>
          <%}}%>
          <table width="100%" border="0" cellspacing="1" cellpadding="1" class="outertable">
          <tr> 
            <td colspan="7"><b><span class="mantatory">*&nbsp;Enter 
            Name /Brief Desc of item  and Quantity Required before saving the record</span></b></td></tr>
          </table>
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
   <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
   <br> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="genTable" value="no">
<input type="hidden" name="otherGenTable" value="UpdateSSIProductInformData">
<INPUT type="hidden" name="hidVal">
</form>
</body>
</html>
