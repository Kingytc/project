<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if(objValues instanceof java.util.HashMap)
   {
	  hshValues=(java.util.HashMap)objValues;
   }
HashMap ht=(HashMap)hshValues.get("hsh5");
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
String strcat="";
if(!strCategoryType.equalsIgnoreCase(null))
{
	if(strCategoryType.equalsIgnoreCase("OPS"))
	{
		strcat="Tertiary";
	}
	else 
	{
		strcat="Corporate";
	}		
}%>
<%
HashMap hshMap = new HashMap();
hshMap=(HashMap) hshValues.get("hsh5");
%>

<html>
<head>
<title>Small Scale Industries</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="javascript" >
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varrecordflag="<%=Helper.correctNull((String)hshMap.get("recordflag"))%>";
function doHelp1()
{
	  var varString = appUrl+"jsp/sethlp/hlp_ssiab10source.jsp"
	   var title = "Documents";
		var prop = "scrollbars=no,width=600,height=450";	
		prop = prop + ",left=50,top=150";
		window.open(varString,title,prop);
}
function whileLoading()
{
	disableFields(true);
	document.forms[0].hidOtherMethod.value="getSourcesOfFundsData";
}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;	
	document.forms[0].cmddelete.disabled=bool4;	
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
function checkPer(obj,text)
{	if(parseFloat(obj.value,10) > 100)
	{
		ShowAlert(104,text);
		obj.focus();
		obj.value = "";
		return false;
	}
}
function doCancel()
	{	
		if(ConfirmMsg(102))
	{				
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].hidBeanId.value="arrears";
		document.forms[0].action=appUrl+"action/ssiab10_sourcesoffunds.jsp";			
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
	document.forms[0].hideditflag.value="Y";
}
function doSave()
 {
	var appUrl="<%=ApplicationParams.getAppUrl()%>";	
	if(trim(document.forms[0].sources[0].value)=="")
			{
			ShowAlert('121','source of fund');
			document.forms[0].sources[0].focus();
			return;
			}
	for (var i=0;i<=9;i++)
	{
	if ((document.forms[0].security[i].value !="")||(document.forms[0].rateofInt[i].value != "0.00")||(document.forms[0].repaypermonth[i].value != "0.00")||(document.forms[0].present[i].value != "0.00")||(document.forms[0].amtofdef[i].value != "0.00"))
	{
		if (document.forms[0].sources[i].value == "")
	{
			var rowid = i+1;
			alert("Enter Source of Fund for the Row No : "+rowid);
	    	document.forms[0].sources[i].disabled = false;
			document.forms[0].sources[i].focus();
			return false;
		}
	 } // End of Checking if for Other Fields Null values
	}//End of For
				document.forms[0].hidRecordflag.value=varrecordflag;
				document.forms[0].hidBeanGetMethod.value="updateSSIAB10Data";
				document.forms[0].hidBeanId.value="arrears";
				document.forms[0].action=appUrl+"action/ssiab10_sourcesoffunds.jsp";	
				document.forms[0].submit();		
 }
  function doDelete()
{
	document.forms[0].hidVal.value="Delete";
	if(varrecordflag=="Y"){
	if(ConfirmMsg("101"))
    {
	document.forms[0].hidBeanId.value="arrears";
	document.forms[0].hidBeanMethod.value="updateSSIAB10Data";
	document.forms[0].hidSourceUrl.value="/action/ssiab10_sourcesoffunds.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
    }
	}
}
function make()
 {
	if(document.forms[0].sources.Value=="")
	 {
		alert("Enter the Source of Funds");
	 }
 }
</script>
</head>
<body onload="javascript:whileLoading()">
<form name="productinform" method="post" class="normal">
  <table width="100%" border="1" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true">
        <jsp:param name="pageid" value="4" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
	    <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
    <tr> 
            <td class="page_flow">Home -&gt;  <%=strcat %> -&gt; Application -&gt; Ind. Activity   -&gt; Existing Finance
 		</td>
          </tr>
  </table>
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/> 
<lapschoice:Activitytab tabid="3" ssitype='<%=strSSIType%>' />
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                <tr> 
                  <td> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="3" class="outertable">
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable linebor">
                            <tr> 
                              <td colspan="7"><b>How 
                                Activity was financed so far ( to be filled up 
                                in case of existing units only)</b></td>
                            </tr>
                            <tr class="dataheader"> 
                              <td width="14%" align="center">Source of funds(<span class="mantatory">*&nbsp;</span>) </td>
                              <td width="16%" align="center">Security</td>
                              <td width="16%" align="center">Rate of Interest (%)</td>
                              <td width="16%" align="center">Repayment per month &nbsp;<b>(<%=ApplicationParams.getCurrency()%>)</b></td>
                              <td width="20%" align="center">Present O/s &nbsp;<b>(<%=ApplicationParams.getCurrency()%>)</b></td>
                              <td width="18%" align="center">Amount of Default (if any) &nbsp;<b>(<%=ApplicationParams.getCurrency()%>)</b></td>
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
                              <td width="14%"align="center"> 
                                <input type="text" name="sources" size="15" maxlength="50" value="<%=Helper.correctNull((String)g1.get(2))%>" onchange="make()">
                              </td>
                              <td width="16%"align="center"> 
                                <input type="text" name="security" size="15" maxlength="50" value="<%=Helper.correctNull((String)g1.get(3))%>" >
                              </td>
                              <td width="16%" align="center"> 
                                <input type="text" name="rateofInt" size="15" maxlength="5" style="text-align:right"  value="<%=Helper.checkDecimal((String)g1.get(4))%>" onKeyPress="allowNumber(this)" onBlur="checkPer(this,'rate of Interest')">
                              </td>
                              <td width="16%" align="center"> 
                                <input type="text" name="repaypermonth" size="15" maxlength="8" style="text-align:right" value="<%=Helper.checkDecimal((String)g1.get(5))%>" onKeyPress="allowDecimals(this)" >
                              </td>
                              <td width="20%" align="center"> 
                                <input type="text" name="present" size="15" maxlength="8" style="text-align:right" value="<%=Helper.checkDecimal((String)g1.get(6))%>" onKeyPress="allowDecimals(this)">
                              </td>
                              <td width="18%" align="center"> 
                                <input type="text" name="amtofdef" size="15" maxlength="8" style="text-align:right" value="<%=Helper.checkDecimal((String)g1.get(7))%>" onKeyPress="allowNumber(this)">
                              </td>
                            </tr>
                            <%}else{%>
                            <tr class="datagrid"> 
                              <td width="14%"align="center"> 
                                <input type="text" name="sources" size="15" value="" maxlength="50">
                              </td>
                              <td width="16%" align="center"> 
                                <input type="text" name="security" size="15" value="" maxlength="50">
                              </td>
                              <td width="16%" align="center"> 
                                <input type="text" name="rateofInt" size="15" value="0.00" maxlength="5" style="text-align:right" onKeyPress="allowNumber(this)"  onBlur="checkPer(this,'rate of Interest')">
                              </td>
                              <td width="16%" align="center"> 
                                <input type="text" name="repaypermonth" size="15" value="0.00" maxlength="8" style="text-align:right" onKeyPress="allowDecimals(this)">
                              </td>
                              <td width="20%" align="center"> 
                                <input type="text" name="present" size="15" value="0.00" maxlength="8" style="text-align:right" onKeyPress="allowDecimals()">
                              </td>
                              <td width="18%" align="center"> 
                                <input type="text" name="amtofdef" size="15" value="0.00" maxlength="8" style="text-align:right" onKeyPress="allowNumber(this)">
                              </td>
                            </tr>
                            <%}}%>
                            <table width="100%" border="0" cellspacing="1" cellpadding="1" class="outertable">
                              <tr> 
                                <td colspan="7"><b><span class="mantatory">*&nbsp;Enter 
                                  Source of funds before saving the record</span></b></td>
                                  </tr>
                            </TABLE>
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
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="genTable" value="no">
<input type="hidden" name="otherGenTable" value="UpdateSSISourcesOfFundsData">
<input type="hidden" name="otherGetMethod" value="">
<INPUT type="hidden" name="hidVal">
</form>
</body>
</html>
