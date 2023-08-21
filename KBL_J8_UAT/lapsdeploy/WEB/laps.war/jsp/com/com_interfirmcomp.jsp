<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<%request.setAttribute("_cache_refresh", "true");

			%>
<laps:handleerror />
<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			//out.println(hshValues);
			String strSSIType = Helper.correctNull((String) request
					.getParameter("hidSSIType"));
			int inssitype=Integer.parseInt((Helper.correctInt(strSSIType)));
			String strCategoryType = Helper.correctNull((String) request.getParameter("cattype"));
					String strIndustryType = Helper.correctNull((String) session
					.getAttribute("IndustryType"));
					 String strSessionModule= Helper.correctNull((String)session.getAttribute("sessionModuleType"));
					
					java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
					nf.setGroupingUsed(false);
					nf.setMaximumFractionDigits(2);
					nf.setMinimumFractionDigits(2);
					String strFinvaluesIn = Helper.correctNull((String)hshValues.get("strFinvaluesIn"));
					if(strFinvaluesIn.equalsIgnoreCase("Rs"))
					{
						strFinvaluesIn	= "(Amount in  "+strFinvaluesIn+".)";
					}
					else
					{
						strFinvaluesIn	= "(Rs. in  "+strFinvaluesIn+")";
					}
				%>
<html>
<head>
<title>Proposal</title> <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"> 
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>jsp/htm/link.css"
	type="text/css"> <link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"> 
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script> <script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script> <script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script> 


<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";




function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].disabled=val;		  
			}
			if(document.forms[0].elements[i].type=="select-one")
			{
			  document.forms[0].elements[i].disabled=val;		  
			}
		}
	}
function doEdit()
{
	disableFields(false);
	disableEditButtons(true, false, false, false,  false);	
	document.forms[0].txt_TOTWC1.readOnly=true;
	document.forms[0].txt_TOTWC2.readOnly=true;
	document.forms[0].txt_TOTWC3.readOnly=true;
	document.forms[0].txt_TOTWC4.readOnly=true;
	document.forms[0].txt_TOTWC5.readOnly=true;	
}
function disableEditButtons(bool1, bool2, bool3, bool4, bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdcomments.disabled=false;
	document.forms[0].cmdclose.disabled=bool6;
}
function placeValues()
{
	disableFields(true);
	document.forms[0].cmdcomments.disabled=false;
	document.forms[0].txt_TOTWC1.readOnly=true;
	document.forms[0].txt_TOTWC2.readOnly=true;
	document.forms[0].txt_TOTWC3.readOnly=true;
	document.forms[0].txt_TOTWC4.readOnly=true;
	document.forms[0].txt_TOTWC5.readOnly=true;
	var seltype1="<%=Helper.correctNull((String)hshValues.get("txt_type1"))%>";
	var seltype2="<%=Helper.correctNull((String)hshValues.get("txt_type2"))%>";
    var seltype3="<%=Helper.correctNull((String)hshValues.get("txt_type3"))%>";
	var seltype4="<%=Helper.correctNull((String)hshValues.get("txt_type4"))%>";
	var seltype5="<%=Helper.correctNull((String)hshValues.get("txt_type5"))%>";
	
	if(seltype1!="")
	{
		document.forms[0].txt_type1.value=seltype1;
	}else
	{
		document.forms[0].txt_type1.value="S";
	}

	if(seltype2!="")
	{
		document.forms[0].txt_type2.value=seltype2;
	}else
	{
		document.forms[0].txt_type2.value="S";
	}
	
	if(seltype3!="")
	{
		document.forms[0].txt_type3.value=seltype3;
	}else
	{
		document.forms[0].txt_type3.value="S";
	}

	if(seltype4!="")
	{
		document.forms[0].txt_type4.value=seltype4;
	}else
	{
		document.forms[0].txt_type4.value="S";
	}

	if(seltype5!="")
	{
		document.forms[0].txt_type5.value=seltype5;
	}else
	{
		document.forms[0].txt_type5.value="S";
	}
		
}
function doComments()
{
	var btnenable=document.forms[0].btnenable.value;
	var hidAppNo = document.forms[0].hidAppNo.value;
	var hidCommentPage = document.forms[0].hidCommentPage.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidCommentPage="+hidCommentPage+"&appstatus="+appstatus+"&btnenable="+btnenable;
	window.open(url,"Comments",prop);
}
function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="comassestsliab"
		document.forms[0].hidBeanMethod.value="updateInterFrim";
		document.forms[0].hidBeanGetMethod.value="getInterfirmComp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_interfirmcomp.jsp";
		document.forms[0].submit();
	 }		
}
function doSave()
{
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="comassestsliab"
		document.forms[0].hidBeanMethod.value="updateInterFrim";
		document.forms[0].hidBeanGetMethod.value="getInterfirmComp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_interfirmcomp.jsp";
		document.forms[0].submit();
		

}
function doCancel()
{
	
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="comassestsliab"
		document.forms[0].hidBeanGetMethod.value="getInterfirmComp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_interfirmcomp.jsp";
		document.forms[0].submit();
	 }	
}

function callcomments()
{
	
		var appno=document.forms[0].appno.value;
		var pagetype = "interfirm";
		var purl ="<%=ApplicationParams.getAppUrl()%>action/com_commentpage.jsp?hidBeanGetMethod=getDataComments&hidBeanId=comassestsliab&pagetype="+pagetype+"&appno="+appno+"&appstatus="+appstatus;		
		var prop = 'scrollbars=yes,menubar=no,width=650,height=355';	
		var xpos = (screen.width - 600) / 2;
		var ypos = (screen.height - 450) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);	 
}

function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appURL+"action/"+"comsearch.jsp";
		document.forms[0].submit();
	}
	
}

function callLink1(page,bean,method)
{
	if(document.forms[0].cmdsave.disabled==true)
	{
	 document.forms[0].hidAction.value="";
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
		return;
	}
}

function callLink(page,bean,method,pagetype)
{

	if(document.forms[0].cmdsave.disabled==true)
	{
	 	document.forms[0].hidAction.value="";
	 	document.forms[0].hidBeanGetMethod.value=method;
	 	document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].action=appURL+"action/"+page;
	 	document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
		return;
	}
	
}

function getValues()
{
    document.forms[0].hidBeanId.value="comassestsliab";
	document.forms[0].hidBeanGetMethod.value="getAppraisalData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].action=appURL+"action/com_interfirmcomp.jsp";	
	document.forms[0].submit();
}

function setTotval(val)
{
	var obj1="document.forms[0].txt_FBWC"+val;
	var obj2="document.forms[0].txt_NFBWC"+val;
	var obj3="document.forms[0].txt_TOTWC"+val;
	var total="";
	total=parseFloat(eval(obj1).value)+parseFloat(eval(obj2).value);
	eval(obj3).value=roundVal(total);
}

 
</script> 
</head>

<body leftmargin="0" topmargin="0" margin marginheight="0"
	onLoad="placeValues()">
	
			<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
	<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url=""><script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>

<form name="frmothers" method=post class="normal"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="22" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="1" cellpadding="3"> 
<%if(strSessionModule.equalsIgnoreCase("corp")){ %>
	<tr>
		 <td class="page_flow">Home -&gt; Corporate & SME  -&gt; Proposal -&gt; Exposure to Industry / Other Info -&gt; Inter Firm Comparsion
		</td>
	</tr> 
	<%}else{ %>
	<tr>
		 <td class="page_flow">Home -&gt; Agriculture  -&gt; Proposal -&gt; Exposure to Industry / Other Info -&gt; Inter Firm Comparsion
		</td>
	</tr> 
	<%} %>
</table>
<span style="display:none"><laps:borrowertype /></span> <laps:application /> 
<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr> <td>
 	<table width="50%" border="0" cellspacing="1" cellpadding="3"> 
	<tr align="center">
<td width="13%" height="14" class="sub_tab_inactive" nowrap="nowrap"> <a href="javascript:callLink1('com_Exposuretoindustry.jsp','comproposal','getExposureIndustry')">Exposure to Industry</a></td>
	   <td width="13%" height="14" class="sub_tab_inactive" nowrap="nowrap">
		<a href="javascript:callLink('com_industryanalysis.jsp','compro','get_Others','Industry')">Industry analysis</a></td>
 <td width="12%" height="14" class="sub_tab_inactive" nowrap="nowrap">
	  <a href="javascript:callLink1('com_swotanalysis.jsp','compro','get_swotanalysis')">Swot Analysis</a></td> 
 <td width="13%" height="14" class="sub_tab_active" nowrap="nowrap">Inter Firm Comparsion</td>
  <td width="12%" height="14" class="sub_tab_inactive" nowrap="nowrap">
		 <a href="javascript:callLink1('com_management.jsp','compro','get_Management')">Other Details</a></td> 
	</tr> 
	</table>
</td></tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="5"
	align=center class="outertable"> <tr> <td valign="top"> 
	
	<table width="100%" border="0" cellspacing="0" cellpadding="1" align="center" height="100%" class="outertable "> 
		<tr>
            <td valign="top">
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" >
                <tr  class="dataheader"> 
                  <td width="20%" height="54">Name of the Company</td>
                  <td width="15%" height="54" align="center"> 
                    <div align="center"> 
                      <input type="text" name="txt_compname1" size="20"
						style="border:0;text-align:left;" maxlength="20"
						value="<%=Helper.correctNull((String)hshValues.get("txt_compname1"))%>" onKeyPress="notAllowSplChar()" >
                      <table width="89%" border="0" cellspacing="0" cellpadding="0" height="37">
                      </table>
                    </div>
                  </td>
                  <td width="15%" height="54" align="center"> 
                    <div align="center"> 
                      <input type="text" name="txt_compname2" size="20"
						style="border:0;text-align:left;" maxlength="20"
						value="<%=Helper.correctNull((String)hshValues.get("txt_compname2"))%>" onKeyPress="notAllowSplChar()" >
                      <table width="89%" border="0" cellspacing="0" cellpadding="0" height="37">
                      </table>
                    </div>
                  </td>
                  <td width="15%" height="54" align="center"> 
                    <div align="center"> 
                      <input type="text" name="txt_compname3" size="20"
						style="border:0;text-align:left;" maxlength="20"
						value="<%=Helper.correctNull((String)hshValues.get("txt_compname3"))%>" onKeyPress="notAllowSplChar()" >
                      <table width="89%" border="0" cellspacing="0" cellpadding="0" height="37">
                      </table>
                    </div>
                  </td>
                  <td width="15%" height="54" align="center"> 
                    <div align="center"> 
                      <input type="text" name="txt_compname4" size="20"
						style="border:0;text-align:left;" maxlength="20"
						value="<%=Helper.correctNull((String)hshValues.get("txt_compname4"))%>" onKeyPress="notAllowSplChar()" >
                      <table width="89%" border="0" cellspacing="0" cellpadding="0" height="37">
                      </table>
                    </div>
                  </td>
                  <td width="15%" height="54" align="center"> 
                    <div align="center"> 
                      <input type="text" name="txt_compname5" size="20"
						style="border:0;text-align:left;" maxlength="20"
						value="<%=Helper.correctNull((String)hshValues.get("txt_compname5"))%>" onKeyPress="notAllowSplChar()" >
                      <table width="89%" border="0" cellspacing="0" cellpadding="0" height="37">
                      </table>
                    </div>
                  </td>
                 <!--   <td width="17%" height="54"> 
                    <div align="center"> 
                      <table width="82%" border="0" cellspacing="0" cellpadding="0" height="25">
                        <tr> 
                          <td width="72%"> 
                            <div align="center"> 
                              <input type="text" name="txt_compname2" size="20"	style="border:0;text-align:left;" maxlength="20"
							value="<%=Helper.correctNull((String)hshValues.get("txt_compname2"))%>"	onKeyPress="notAllowSplChar()">
                            
                            </div>
                          </td>
                        </tr>
                      </table>
                    </div>
                  </td>
                  <td width="16%" height="54"> 
                    <div align="center"> 
                      <table width="90%" border="0" cellspacing="0" cellpadding="0">
                        <tr class="datagrid"> 
                          <td width="59%"> 
                            <div align="center"> 
                              <input type="text" name="txt_compname3" size="20"	style="border:0;text-align:left;" maxlength="20"
								value="<%=Helper.correctNull((String)hshValues.get("txt_compname3"))%>" onKeyPress="notAllowSplChar()">
                            </div>
                          </td>
                        </tr>
                      </table>
                    </div>
                  </td>
                  <td width="16%" height="54"> 
                    <div align="center"> 
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="73%"> 
                            <div align="center"> 
                              <input type="text"
															name="txt_compname4" size="20"
															style="border:0;text-align:left;" maxlength="20"
															value="<%=Helper.correctNull((String)hshValues.get("txt_compname4"))%>"
															onKeyPress="notAllowSplChar()">
                            </div>
                          </td>
                        </tr>
                      </table>
                    </div>
                  </td>
                  <td width="16%" height="54"> 
                    <div align="center"> 
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="78%"> 
                            <div align="center"> 
                              <input type="text"
															name="txt_compname5" size="15"
															style="border:0;text-align:left;" maxlength="20"
															value="<%=Helper.correctNull((String)hshValues.get("txt_compname5"))%>" onKeyPress="notAllowSplChar()">
                            </div>
                          </td>
                        </tr>
                      </table>
                    </div>
                  </td>-->
                </tr>
                <tr class="datagrid"><td colspan="6" align="right"><%=strFinvaluesIn %></td></tr>
                <tr class="datagrid"> 
                  <td width="20%">Year</td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text" name="txt_year1" size="10"
						style="border:0;text-align:left;" maxlength="20"
						value="<%=Helper.correctNull((String)hshValues.get("txt_year1"))%>"
						 onKeyPress="notAllowSplChar()">
                    </div>
                  </td>
                  <td width="17%"> 
                    <div align="center"> 
                      <input type="text" name="txt_year2" size="10"		style="border:0;text-align:left;" maxlength="20"
					value="<%=Helper.correctNull((String)hshValues.get("txt_year2"))%>"	onKeyPress="notAllowSplChar()">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text" name="txt_year3" size="10"	style="border:0;text-align:left;" maxlength="20"
						value="<%=Helper.correctNull((String)hshValues.get("txt_year3"))%>" onKeyPress="notAllowSplChar()">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text" name="txt_year4" size="10" style="border:0;text-align:left;" maxlength="20"
						value="<%=Helper.correctNull((String)hshValues.get("txt_year4"))%>" onKeyPress="notAllowSplChar()">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text" name="txt_year5" size="10" style="border:0;text-align:left;" maxlength="20"
						value="<%=Helper.correctNull((String)hshValues.get("txt_year5"))%>" onKeyPress="notAllowSplChar()">
                    </div>
                  </td>
                </tr>
                <tr class="datagrid"> 
                  <td width="20%" height="38">Type</td>
                  <td width="15%" height="38"> 
                    <div align="center"> 
                      <select name="txt_type1" style="width:80">
                        <option value="S" selected>--Select--</option>
                        <option value="Audit">Audited</option>
                        <option value="Unaudit">Unaudited</option>
                        <option value="Estimated">Estimated</option>
                        <option value="Projection">Projection</option>
                        <!--<lapschoice:StaticDataQuestionMastTag apptype="26"/> -->
                      </select>
                    </div>
                  </td>
                  <td width="17%" height="38"> 
                    <div align="center"> 
                      <select name="txt_type2" style="width:80">
                        <option value="S" selected>--Select--</option>
                        <option value="Audit">Audited</option>
                        <option value="Unaudit">Unaudited</option>
                        <option value="Estimated">Estimated</option>
                        <option value="Projection">Projection</option>
                        <!--<lapschoice:StaticDataQuestionMastTag apptype="26"/> -->
                      </select>
                    </div>
                  </td>
                  <td width="16%" height="38"> 
                    <div align="center"> 
                      <select name="txt_type3" style="width:80">
                        <option value="S" selected>--Select--</option>
                        <option value="Audit">Audited</option>
                        <option value="Unaudit">Unaudited</option>
                        <option value="Estimated">Estimated</option>
                        <option value="Projection">Projection</option>
                        <!--<lapschoice:StaticDataQuestionMastTag apptype="26"/> -->
                      </select>
                    </div>
                  </td>
                  <td width="16%" height="38"> 
                    <div align="center"> 
                      <select name="txt_type4" style="width:80">
                        <option value="S" selected>--Select--</option>
                        <option value="Audit">Audited</option>
                        <option value="Unaudit">Unaudited</option>
                        <option value="Estimated">Estimated</option>
                        <option value="Projection">Projection</option>
                        <!--<lapschoice:StaticDataQuestionMastTag apptype="26"/> -->
                      </select>
                    </div>
                  </td>
                  <td width="16%" height="38"> 
                    <div align="center"> 
                      <select name="txt_type5" style="width:80">
                        <option value="S" selected>--Select--</option>
                        <option value="a">Audit</option>
                        <option value="u">unaudit</option>
                        <option value="e">Estimated</option>
                        <option value="p">Projection</option>
                        <!--<lapschoice:StaticDataQuestionMastTag apptype="26"/> -->
                      </select>
                    </div>
                  </td>
                </tr>
                <tr class="datagrid">
                <td width="20%">1) Fund Based Working Captial limits availed</td>
                <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_FBWC1" size="10" onblur="roundtxt(this);setTotval('1');"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_FBWC1"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_FBWC2" size="10" onblur="roundtxt(this);setTotval('2');"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_FBWC2"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_FBWC3" size="10" onblur="roundtxt(this);setTotval('3');"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_FBWC3"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_FBWC4" size="10" onblur="roundtxt(this);setTotval('4');"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_FBWC4"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_FBWC5" size="10" onblur="roundtxt(this);setTotval('5');"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_FBWC5"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                </tr>
                 <tr class="datagrid">
                <td width="20%">2) NonFund Based Working Captial limits availed</td>
                <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_NFBWC1" size="10" onblur="roundtxt(this);setTotval('1');"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_NFBWC1"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_NFBWC2" size="10" onblur="roundtxt(this);setTotval('2');"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_NFBWC2"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_NFBWC3" size="10" onblur="roundtxt(this);setTotval('3');"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_NFBWC3"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_NFBWC4" size="10" onblur="roundtxt(this);setTotval('4');"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_NFBWC4"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_NFBWC5" size="10" onblur="roundtxt(this);setTotval('5');"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_NFBWC5"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                </tr>
                <tr class="datagrid">
                <td width="20%">3) Total Working Captial limits availed</td>
                <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_TOTWC1" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_TOTWC1"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_TOTWC2" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_TOTWC2"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_TOTWC3" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_TOTWC3"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_TOTWC4" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_TOTWC4"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_TOTWC5" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_TOTWC5"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                </tr>
                <tr class="datagrid">
                <td width="20%">4) Term Loan limits availed</td>
                <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_termava1" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_termava1"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_termava2" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_termava2"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_termava3" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_termava3"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_termava4" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_termava4"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_termava5" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_termava5"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                </tr>
                <tr class="datagrid"> 
                  <td width="20%">5) Sales</td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_netsales1" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netsales1"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="17%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_netsales2" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netsales2"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_netsales3" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netsales3"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_netsales4" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netsales4"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_netsales5" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netsales5"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                </tr>
                <tr class="datagrid"> 
                  <td width="20%">6) Net Profit</td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_netprofit1" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netprofit1"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="17%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_netprofit2" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netprofit2"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_netprofit3" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netprofit3"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_netprofit4" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netprofit4"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_netprofit5" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netprofit5"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                </tr>
               
                <tr class="datagrid"> 
                  <td width="20%">7) Net Worth</td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_tangnet1" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_tangnet1"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="17%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_tangnet2" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_tangnet2"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_tangnet3" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_tangnet3"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_tangnet4" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_tangnet4"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_tangnet5" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_tangnet5"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                </tr>
                
                <tr class="datagrid"> 
                  <td width="20%">8) Debt-Equity Ratio</td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_toltnw1" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_toltnw1"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="17%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_toltnw2" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_toltnw2"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text" 
															name="txt_toltnw3" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_toltnw3"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_toltnw4" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_toltnw4"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_toltnw5" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_toltnw5"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                </tr>
                <tr class="datagrid"> 
                  <td width="20%">9) TOL/TNW</td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_currratio1" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_currratio1"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="17%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_currratio2" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_currratio2"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_currratio3" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_currratio3"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_currratio4" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_currratio4"))))%>" onKeyPress="allowNegtiveNumber(this)">

                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_currratio5" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_currratio5"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                </tr>
                <tr class="datagrid"> 
                  <td width="20%">10) Current Ratio</td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_estproturn1" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_estproturn1"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="17%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_estproturn2" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_estproturn2"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_estproturn3" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_estproturn3"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_estproturn4" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_estproturn4"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_estproturn5" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_estproturn5"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                </tr>
                
                <tr class="datagrid"> 
                  <td width="20%"> 11) 
                    <input type="text" name="txt_freetxtfield1" size="20"
						style="border:0;text-align:left;" maxlength="20"
						value="<%=Helper.correctNull((String)hshValues.get("intcompfreetxt_txt1"))%>" onKeyPress="notAllowSplChar()">
                  </td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_freetext1" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext1"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="17%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_freetext2" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext2"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_freetext3" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext3"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_freetext4" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext4"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_freetext5" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext5"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                </tr>
                <tr class="datagrid"> 
                  <td width="20%"> 12) 
                    <input type="text" name="txt_freetxtfield2" size="20"
						style="border:0;text-align:left;" maxlength="20"
						value="<%=Helper.correctNull((String)hshValues.get("intcompfreetxt_txt2"))%>" onKeyPress="notAllowSplChar()">
                  </td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_freetext11" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext11"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="17%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_freetext12" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext12"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_freetext13" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext13"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_freetext14" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext14"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text" name="txt_freetext15" size="10" onblur="roundtxt(this)" style="border:0;text-align:right;" maxlength="20"
						value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext15"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                </tr>
                <tr class="datagrid"> 
                  <td width="20%"> 13) 
                    <input type="text" name="txt_freetxtfield3" size="20"
						style="border:1;text-align:left;" maxlength="20"
						value="<%=Helper.correctNull((String)hshValues.get("intcompfreetxt_txt3"))%>" onKeyPress="notAllowSplChar()">
                  </td>
                  <td width="15%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_freetext21" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext21"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="17%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_freetext22" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext22"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_freetext23" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext23"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_freetext24" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext24"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="text"
															name="txt_freetext25" size="10" onblur="roundtxt(this)"
															style="border:0;text-align:right;" maxlength="20"
															value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext25"))))%>" onKeyPress="allowNegtiveNumber(this)">
                    </div>
                  </td>
                </tr>
              </table>
            </td>
          </tr> 
		</table>
		</tr> 
		</table>
		 <br>
		 	<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' btnnames='Edit_Save_Cancel_Delete_Comments_Audit Trail'/>
		<input type="hidden" name="hidAction"> 
		<input type="hidden" name="hidBeanId">
		<input type="hidden" name="hidBeanMethod" > 
		<input type="hidden" name="hidBeanGetMethod">
		<input type="hidden" name="hidSourceUrl">
		<input type="hidden" name="hidpage" value="Industry">
		<input type="hidden" name="hidCommentPage" value="InterFirmComparsion">  
		<input type="hidden" name="hidAppNo" value="<%=Helper.correctNull((String)request.getParameter("appno"))%>">
		<input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
		</form>
</body>
</html>
