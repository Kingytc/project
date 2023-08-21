<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<lapschoice:handleerror />
<%
    ArrayList gridData= new ArrayList();
    if(hshValues.get("vecData")!=null)
    	gridData=(ArrayList)hshValues.get("vecData");
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	String strInitialLoad = Helper.correctNull((String) request
			.getParameter("initial"));
	String applicantid = Helper.correctNull((String) hshValues
			.get("hidApplId"));
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();

	String strapptype = "";
	String apptype = "";
	String app_status = Helper.correctNull((String) hshValues
			.get("app_status"));
	String PageType = Helper.correctNull((String) hshValues
			.get("PageType"));
	String prd_type = Helper.correctNull((String) session
			.getAttribute("strProductType"));
	String schemetype="";
	schemetype = Helper.correctNull((String) request.getParameter("schemetype"));

	String cattype = Helper.correctNull((String) request.getParameter("cattype"));
	String applevel = Helper.correctNull((String) request.getParameter("applevel"));
	//System.out.println("applevel==="+applevel);			
	cattype = Helper.correctNull((String) request.getParameter("cattype1"));
	if (cattype.equals(""))
	{
		cattype = Helper.correctNull((String) session.getAttribute("cattype"));
	}
	String ssitype = (String) request.getParameter("ssitype");
	if (ssitype.equalsIgnoreCase("")) {
		ssitype = Helper.correctNull((String) hshValues	.get("hidSSIType"));
	}
	String strType = Helper.correctNull((String) session.getAttribute("link"));
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
%>

<html>
<head>
<title>LAPS - Agriculture Technical Details</title>
<style>
.divCellContainer {
	width: 100%;
	height: 100px;
	overflow: auto;
}
</style>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
	<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varschemetype="<%=schemetype%>";
function disableCommandButtons(val)
{	 
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdnew.disabled =false;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}	 
	if(val=="edit")
	{		  
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdcancel.disabled=false;		 
		document.forms[0].cmdclose.disabled=true;	 
		disableFields(false);
	}
	if(val=="radioselect")
	{	  
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdcancel.disabled=true;
		//document.forms[0].cmdclose.disabled=false;
	}	 
	if(val=="disableall")
	{	  
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		//document.forms[0].cmdclose.disabled=false;
	}	  
}  
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/perborrowersearch.jsp?hidPageType=EXI";	
		document.forms[0].submit();
	}
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	
		if(document.forms[0].elements[i].type=='textarea')
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
function selectValues(sno,val1,val2,val3,val4,val5,val6,val7,val8,val9,val10)
{
	document.forms[0].hidAction.value = "update";	
	document.forms[0].txt_agr_common_incomeandexpense.value=val2;
	document.forms[0].txt_agr_common_year1.value=val3;
	document.forms[0].txt_agr_common_year2.value=val4;
	document.forms[0].txt_agr_common_year3.value=val5;
	document.forms[0].txt_agr_common_year4.value=val6;
	document.forms[0].txt_agr_common_year5.value=val7;
	document.forms[0].txt_agr_common_year6.value=val8;
	document.forms[0].txt_agr_common_year7.value=val9;
	document.forms[0].txt_agr_common_year8.value=val10;
	document.forms[0].seqno.value=sno;
		
	appno=document.forms[0].appno.value;
	if(sno!="")
	{	
		document.all.ifrm.src=appURL+"action/iframeagr_common_income.jsp?hidBeanId=agrlandholdings&appno="+appno+"&seqno="+sno+"&hidBeanGetMethod=getExpense&hidAction=edit";
	}
	disableCommandButtons("radioselect");
	
}

function onloading()
{	
	disableFields(true);
	disableCommandButtons("load");
	
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=varschemetype;
}

function doSave()
{
        if(isComplete())
        {
        	document.forms[0].cmdsave.disabled=true;
			document.forms[0].hidBeanId.value="agrcommon";
			document.forms[0].hidBeanGetMethod.value="getExpense";	
		    document.forms[0].hidBeanMethod.value="updateIncomeandExpense";
			document.forms[0].action=appURL+"controllerservlet";
		    document.forms[0].hidSourceUrl.value="/action/agr_expense.jsp";
			document.forms[0].submit();		
		}
}
function doDelete()
{     
 	if(ConfirmMsg(101))
	{
        document.forms[0].hidAction.value = "delete";		
        document.forms[0].hidBeanId.value="agrcommon";
		document.forms[0].hidBeanGetMethod.value="getExpense";	
	    document.forms[0].hidBeanMethod.value="deleteIncomeAndExpense";
		document.forms[0].action=appURL+"controllerservlet";
	    document.forms[0].hidSourceUrl.value="/action/agr_expense.jsp";
		document.forms[0].submit();	
	}	
		
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="agrcommon";
		document.forms[0].hidBeanGetMethod.value="getExpense";
		document.forms[0].action=appURL+"action/agr_expense.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function doEdit(){
   document.forms[0].hidAction.value = "update";
   disableCommandButtons("edit");  
}
function doNew()
{
	disableFields(false);
	disableCommandButtons("edit");
    document.forms[0].hidAction.value = "insert";	
    document.forms[0].seqno.value="";
   
	for(var i=0;i<document.forms[0].length;i++)
	{
	 	if(document.forms[0].elements[i].type=='radio')
	 	{
			document.forms[0].elements[i].checked=false;
	 	}	  
	}
}

function isComplete(){
//alert("hi");
  if(document.forms[0].txt_agr_common_incomeandexpense.value==""){
       ShowAlert(121,"Expense Details");
       return false;
  }
  
  if((document.forms[0].txt_agr_common_year1.value=="0.00")||(document.forms[0].txt_agr_common_year1.value=="")){
    ShowAlert(121,"I Year");
    return false;
  }
  
  if((document.forms[0].txt_agr_common_year2.value=="0.00")||(document.forms[0].txt_agr_common_year2.value=="")){
	 // alert("hi2");
    ShowAlert(121,"II Year");
    return false;
  }
  
  return true;
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
DIV.cellContainer {
	width: 100%;
	height: 250;
	overflow: auto;
}
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading();">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="999" />
			<jsp:param name="cattype" value="<%=cattype%>" />
			<jsp:param name="ssitype" value="<%=ssitype%>" />
		</jsp:include></td>
	</tr>
</table>

<table>
	
	<tr>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Expense</td>
	</tr>
	
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="118" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>
<br>
<table width="95%" border="0" cellspacing="0" cellpadding="5" class="shadow" align="center" class="outertable border1">
	<tr>
		<td>
		 <table width="98%" border="0" cellspacing="1" cellpadding="2" class="outertable">
          <tr> 
            <td width="44%"  align="center"><b>Expenditure 
              Details </b></td>
            <td width="7%"  align="center"><b>I 
              Year</b></td>
            <td width="7%"  align="center"><b>II 
              Year</b></td>
            <td width="7%"  align="center"><b>III 
              Year</b></td>
            <td width="7%"  align="center"><b>IV 
              Year</b></td>
            <td width="7%"  align="center"><b>V 
              Year</b></td>
            <td width="7%"  align="center"><b>VI 
              Year</b></td>
            <td width="7%"  align="center"><b>VII 
              Year</b></td>
            <td width="7%"  align="center"><b>VIII 
              Year</b></td>
          </tr>
          <tr> 
            <td width="44%" align="center"> 
              <input type="text" name="txt_agr_common_incomeandexpense" size="50" maxlength="100">
            </td>
            <td width="7%">
              <input type="text" name="txt_agr_common_year1" size="11" maxlength="8" onblur="roundtxt(this)" onKeyPress="allowDecimals(this)" style="text-align: right">
            </td>
            <td width="7%"> 
              <input type="text" name="txt_agr_common_year2" size="11" maxlength="8" onblur="roundtxt(this)" onKeyPress="allowDecimals(this)" style="text-align: right">
            </td>
            <td width="7%"> 
              <input type="text" name="txt_agr_common_year3" size="11" maxlength="8" onblur="roundtxt(this)"onKeyPress="allowDecimals(this)"  style="text-align: right">
            </td>
            <td width="7%"> 
              <input type="text" name="txt_agr_common_year4" size="11" maxlength="8" onblur="roundtxt(this)" onKeyPress="allowDecimals(this)" style="text-align: right">
            </td>
            <td width="7%"> 
              <input type="text" name="txt_agr_common_year5" size="11" maxlength="8" onblur="roundtxt(this)" onKeyPress="allowDecimals(this)" style="text-align: right">
            </td>
            <td width="7%" align="center"> 
              <input type="text" name="txt_agr_common_year6" size="11" maxlength="8" onblur="roundtxt(this)" onKeyPress="allowDecimals(this)" style="text-align: right">
            </td>
            <td width="7%" align="center"> 
              <input type="text" name="txt_agr_common_year7" size="11" maxlength="8" onblur="roundtxt(this)" onKeyPress="allowDecimals(this)" style="text-align: right">
            </td>
            <td width="7%" align="center"> 
              <input type="text" name="txt_agr_common_year8" size="11" maxlength="8"  onblur="roundtxt(this)" onKeyPress="allowDecimals(this)" style="text-align: right">
            </td>
          </tr>
        </table>
          </td>
          </tr>
          </table>
          <br>
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>

<br>
          <table width="98%" border="0" cellspacing="1" cellpadding="2" bordercolordark="#B6C1D2" bordercolorlight="#FFFFFF">
        <tr class="dataheader">    
          
		  <td width="4%">&nbsp;</td>
            <td width="50%"  align="center"><b>Expenditure 
              Details </b></td>
            <td   align="center"><b>I 
              Year</b></td>
            <td   align="center"><b>II 
              Year</b></td>
            <td   align="center"><b>III 
              Year</b></td>
            <td   align="center"><b>IV 
              Year</b></td>
            <td   align="center"><b>V 
              Year</b></td>
            <td   align="center"><b>VI 
              Year</b></td>
            <td   align="center"><b>VII 
              Year</b></td>
            <td   align="center"><b>VIII 
              Year</b></td>
          </tr>
                
        <%for(int i=0;i<=gridData.size()-1;i++){ 
           ArrayList data=(ArrayList)gridData.get(i);        
        %>
           
        <tr class="datagrid"> 
         
          <td width="4%">
              <input type="radio" name="radio_seqno" onclick="selectValues('<%=Helper.correctNull((String) data.get(1))%>', 
					'<%=Helper.correctNull((String) data.get(2))%>','<%=Helper.correctNull((String) data.get(3))%>',
					'<%=Helper.correctNull((String) data.get(4))%>','<%=Helper.correctNull((String) data.get(5))%>',
					'<%=Helper.correctNull((String) data.get(6))%>','<%=Helper.correctNull((String) data.get(7))%>',
					'<%=Helper.correctNull((String) data.get(8))%>','<%=Helper.correctNull((String) data.get(9))%>',
					'<%=Helper.correctNull((String) data.get(10))%>','<%=Helper.correctNull((String) data.get(11))%>')" style="border-style:none"></td>
			
          <td width="50%"><%=data.get(3)%> </td>
          <td   align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(4).toString())))%></td>
          <td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(5).toString())))%> </td>
          <td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(6).toString())))%> </td>
          <td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(7).toString())))%> </td>
          <td   align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(8).toString())))%></td>
          <td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(9).toString())))%> </td>
          <td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(10).toString())))%> </td>
          <td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(11).toString())))%> </td>
         
        </tr>
        <%} %>
         <tr class="datagrid">
            <td width="4%">&nbsp;</td>
            <td width="50%">Total</td>
            <td   align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_agr_total_year1"))))%></td>
            <td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_agr_total_year2"))))%> </td>
            <td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_agr_total_year3"))))%></td>
            <td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_agr_total_year4"))))%></td>
            <td   align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_agr_total_year5"))))%></td>
            <td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_agr_total_year6"))))%></td>
            <td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_agr_total_year7"))))%></td>
            <td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_agr_total_year8"))))%></td>
          </tr>
      </table>
      
<input type="hidden" name="hidAction" value=""> 
<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidSourceUrl" value=""> 
<input type="hidden" name="hidApp_type" value="A"> 
<input type="hidden" name="page" value=""> 
<INPUT TYPE="hidden" name="hidEditMode" value="<%=Helper.correctNull((String) hshValues.get("hidEditMode"))%>">
<input type="hidden" name="hidCoDemoId" value="<%=request.getParameter("hidCoDemoId")%>"> 
<input type="hidden" name="hidDemoId" value="<%=request.getParameter("hidDemoId")%>"> 
<input type="hidden" name="hidAppType" value="<%=Helper.correctNull((String) hshValues.get("hidAppType"))%>">
<input type="hidden" name="hidGuaDemoId" value="<%=request.getParameter("hidGuaDemoId")%>"> 
<input type="hidden" name="hidpagetype" value="<%=PageType%>">
<INPUT TYPE="hidden" name="seqno" > 
<INPUT TYPE="hidden" name="agr_common_producttype" > 
<INPUT TYPE="hidden" name="type"  value="E">  
 <iframe height="0" width="0" id="ifrm" frameborder=0
	style="border:0"></iframe> 
          </form>

</body>
</html>