<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<% 
String strBorrowerType =Helper.correctNull((String)request.getParameter("hidBorrowerType"));
String strAssessmentType= Helper.correctNull((String)hshValues.get("assessmenttype"));
%>
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	String cattype = (String) request.getParameter("cattype");
	String ssitype = (String) request.getParameter("ssitype");
	String strSessionModule="";
	strSessionModule=Helper.correctNull((String)request.getParameter("sessionModuleType"));
	if(strSessionModule.equalsIgnoreCase("")){
		strSessionModule=Helper.correctNull((String)session.getAttribute("sessionModuleType"));
	}
	String[] rowVal1=null;
	String[] rowVal2=null;
	String[] rowVal3=null;
	String[] rowVal4=null;
	String[] rowVal5=null;
	String[] rowVal6=null;
	String[] rowVal7=null;
	String[] rowVal8=null;
	
	String[] rowVal9=null;
	String[] rowVal10=null;
	
	String[] rowVal11=null;
	String[] rowVal12=null;
	String[] rowVal13=null;
	String[] rowVal14=null;
	String[] rowVal15=null;
	String[] rowVal16=null;
	String[] rowVal17=null;
	String[] rowVal18=null;
	String[] rowVal19=null;
	String[] rowVal20=null;
	String[] rowVal21=null;
	String[] rowVal22=null;
	String[] particulars=null;
	int colCount=1;
	colCount=Integer.parseInt(Helper.correctInt((String)hshValues.get("YearlyType")));

	String maxDeficit="";
	maxDeficit=Helper.correctNull((String)hshValues.get("maxDeficit"));
	
	particulars=(String[])(hshValues.get("particulars"));
	rowVal1=(String[])(hshValues.get("rowVal1"));
	rowVal2=(String[])(hshValues.get("rowVal2"));
	rowVal3=(String[])(hshValues.get("rowVal3"));
	rowVal4=(String[])(hshValues.get("rowVal4"));
	rowVal5=(String[])(hshValues.get("rowVal5"));
	rowVal6=(String[])(hshValues.get("rowVal6"));
	rowVal7=(String[])(hshValues.get("rowVal7"));
	rowVal8=(String[])(hshValues.get("rowVal8"));
	rowVal9=(String[])(hshValues.get("rowVal9"));
	rowVal10=(String[])(hshValues.get("rowVal10"));
	rowVal11=(String[])(hshValues.get("rowVal11"));
	rowVal12=(String[])(hshValues.get("rowVal12"));
	rowVal13=(String[])(hshValues.get("rowVal13"));
	rowVal14=(String[])(hshValues.get("rowVal14"));
	rowVal15=(String[])(hshValues.get("rowVal15"));
	rowVal16=(String[])(hshValues.get("rowVal16"));
	rowVal17=(String[])(hshValues.get("rowVal17"));
	rowVal18=(String[])(hshValues.get("rowVal18"));
	rowVal19=(String[])(hshValues.get("rowVal19"));
	rowVal20=(String[])(hshValues.get("rowVal20"));
	rowVal21=(String[])(hshValues.get("rowVal21"));
	rowVal22=(String[])(hshValues.get("rowVal22"));
	
	ArrayList Lastyear=new ArrayList();
	Lastyear=(ArrayList)hshValues.get("Lastyear");
	
	ArrayList TotalValues=new ArrayList();
	TotalValues=(ArrayList)hshValues.get("TotalValues");
	%>
<html>
<head>

<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
	<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";

var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var appno="<%=request.getParameter("appno")%>";
function doSave() {
	document.forms[0].sel_ass_type.disabled=false;
	var flag=true;
<%if(colCount>1)
{
	
	for(int i=0;i<colCount;i++){
%>
	if(trim(document.forms[0].txt_particulars["<%=i%>"].value)!="")
	{
		flag=false;
	}
<%}
%>
if(flag)
{
	alert("Enter Year Details");
	return false;
}


<%	
}
else if(colCount==1)
{%>
	if(document.forms[0].txt_particulars.value=="")
	{
		alert("Enter Year Details");
		return false;
	}
<%}%>
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidBeanId.value = "repappcredit";
		document.forms[0].hidBeanMethod.value = "updateCashFlowBudget";
		document.forms[0].hidBeanGetMethod.value = "getCashFlowBudget";
		document.forms[0].action = appUrl + "controllerservlet";
		document.forms[0].hidSourceUrl.value = "/action/com_CashBudgetMethod.jsp";
		document.forms[0].method = "post";
		document.forms[0].submit();

}
function doEdit() {
	document.forms[0].hidAction.value = "Edit";
	disabledFields(false);
	enableButtons(true,false,false,false,true,false);
}

function doCancel() {
	if (ConfirmMsg(102)) {
		document.forms[0].action = appUrl + "controllerservlet";
		document.forms[0].hidBeanGetMethod.value = "getCashFlowBudget";
		document.forms[0].hidBeanId.value = "repappcredit";
		document.forms[0].action = appUrl+ "action/com_CashBudgetMethod.jsp";
		document.forms[0].submit();
	}
}

function doDelete() {
	if (ConfirmMsg(101)) {
		document.forms[0].hidAction.value = "delete";
		document.forms[0].action = appUrl + "action/ControllerServlet";
		document.forms[0].hidBeanId.value = "repappcredit";
		document.forms[0].hidSourceUrl.value = "action/com_CashBudgetMethod.jsp";
		document.forms[0].hidBeanMethod.value = "deleteCashFlowBudget";
		document.forms[0].hidBeanGetMethod.value = "getCashFlowBudget";
		document.forms[0].submit();
	}

}
function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{

	//document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
	document.forms[0].cmdcomments.disabled=bool6;

}
function disabledFields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].disabled=one;		  
		}
	}
}
function placeValues() 
{
	document.forms[0].sel_ass_type.value="<%=colCount%>";
	document.forms[0].sel_year.value="<%=Helper.correctNull((String)hshValues.get("WhichYear"))%>";
	document.forms[0].txt_finYear.value="<%=Helper.correctNull((String)hshValues.get("finYear"))%>";
		<%
		if(colCount>1)
		{
		for(int i=0;i<colCount;i++)
		{
			
		%>
			document.forms[0].txt_particulars[<%=i%>].value="<%=particulars[i]%>"
			document.forms[0].txt_row1[<%=i%>].value="<%=rowVal1[i]%>";
			document.forms[0].txt_row2[<%=i%>].value="<%=rowVal2[i]%>";
			document.forms[0].txt_row3[<%=i%>].value="<%=rowVal3[i]%>";
			document.forms[0].txt_row4[<%=i%>].value="<%=rowVal4[i]%>";
			document.forms[0].txt_row5[<%=i%>].value="<%=rowVal5[i]%>";
			document.forms[0].txt_row6[<%=i%>].value="<%=rowVal6[i]%>";
			document.forms[0].txt_row7[<%=i%>].value="<%=rowVal7[i]%>";
			document.forms[0].txt_row8[<%=i%>].value="<%=rowVal8[i]%>";
			document.forms[0].txt_row9[<%=i%>].value="<%=rowVal9[i]%>";
			document.forms[0].txt_row10[<%=i%>].value="<%=rowVal10[i]%>";
			document.forms[0].txt_row11[<%=i%>].value="<%=rowVal11[i]%>";
			document.forms[0].txt_row12[<%=i%>].value="<%=rowVal12[i]%>";
			document.forms[0].txt_row13[<%=i%>].value="<%=rowVal13[i]%>";
			document.forms[0].txt_row14[<%=i%>].value="<%=rowVal14[i]%>";
			document.forms[0].txt_row15[<%=i%>].value="<%=rowVal15[i]%>";
			document.forms[0].txt_row16[<%=i%>].value="<%=rowVal16[i]%>";
			document.forms[0].txt_row17[<%=i%>].value="<%=rowVal17[i]%>";
			document.forms[0].txt_row18[<%=i%>].value="<%=rowVal18[i]%>";
			document.forms[0].txt_row19[<%=i%>].value="<%=rowVal19[i]%>";
			document.forms[0].txt_row20[<%=i%>].value="<%=rowVal20[i]%>";
			document.forms[0].txt_row21[<%=i%>].value="<%=rowVal21[i]%>";
			document.forms[0].txt_row22[<%=i%>].value="<%=rowVal22[i]%>";
		<%}}
		else{ int i=0;
		%>
		document.forms[0].txt_particulars.value="<%=particulars[i]%>"
			document.forms[0].txt_row1.value="<%=rowVal1[i]%>";
			document.forms[0].txt_row2.value="<%=rowVal2[i]%>";
			document.forms[0].txt_row3.value="<%=rowVal3[i]%>";
			document.forms[0].txt_row4.value="<%=rowVal4[i]%>";
			document.forms[0].txt_row5.value="<%=rowVal5[i]%>";
			document.forms[0].txt_row6.value="<%=rowVal6[i]%>";
			document.forms[0].txt_row7.value="<%=rowVal7[i]%>";
			document.forms[0].txt_row8.value="<%=rowVal8[i]%>";
			document.forms[0].txt_row9.value="<%=rowVal9[i]%>";
			document.forms[0].txt_row10.value="<%=rowVal10[i]%>";
			document.forms[0].txt_row11.value="<%=rowVal11[i]%>";
			document.forms[0].txt_row12.value="<%=rowVal12[i]%>";
			document.forms[0].txt_row13.value="<%=rowVal13[i]%>";
			document.forms[0].txt_row14.value="<%=rowVal14[i]%>";
			document.forms[0].txt_row15.value="<%=rowVal15[i]%>";
			document.forms[0].txt_row16.value="<%=rowVal16[i]%>";
			document.forms[0].txt_row17.value="<%=rowVal17[i]%>";
			document.forms[0].txt_row18.value="<%=rowVal18[i]%>";
			document.forms[0].txt_row19.value="<%=rowVal19[i]%>";
			document.forms[0].txt_row20.value="<%=rowVal20[i]%>";
			document.forms[0].txt_row21.value="<%=rowVal21[i]%>";
			document.forms[0].txt_row22.value="<%=rowVal22[i]%>";
	<%}%>

	document.forms[0].txt_lastYear0.value="<%=Lastyear.get(0)%>";
	document.forms[0].txt_lastYear1.value="<%=Lastyear.get(1)%>";
	document.forms[0].txt_lastYear2.value="<%=Lastyear.get(2)%>";
	document.forms[0].txt_lastYear3.value="<%=Lastyear.get(3)%>";
	document.forms[0].txt_lastYear4.value="<%=Lastyear.get(4)%>";
	document.forms[0].txt_lastYear5.value="<%=Lastyear.get(5)%>";
	document.forms[0].txt_lastYear6.value="<%=Lastyear.get(6)%>";
	document.forms[0].txt_lastYear7.value="<%=Lastyear.get(7)%>";
	document.forms[0].txt_lastYear8.value="<%=Lastyear.get(8)%>";
	document.forms[0].txt_lastYear9.value="<%=Lastyear.get(9)%>";
	document.forms[0].txt_lastYear10.value="<%=Lastyear.get(10)%>";
	document.forms[0].txt_lastYear11.value="<%=Lastyear.get(11)%>";
	document.forms[0].txt_lastYear12.value="<%=Lastyear.get(12)%>";
	document.forms[0].txt_lastYear13.value="<%=Lastyear.get(13)%>";
	document.forms[0].txt_lastYear14.value="<%=Lastyear.get(14)%>";
	document.forms[0].txt_lastYear15.value="<%=Lastyear.get(15)%>";
	document.forms[0].txt_lastYear16.value="<%=Lastyear.get(16)%>";
	document.forms[0].txt_lastYear17.value="<%=Lastyear.get(17)%>";
	document.forms[0].txt_lastYear18.value="<%=Lastyear.get(18)%>";
	document.forms[0].txt_lastYear19.value="<%=Lastyear.get(19)%>";
	document.forms[0].txt_lastYear20.value="<%=Lastyear.get(20)%>";
	document.forms[0].txt_lastYear21.value="<%=Lastyear.get(21)%>";
	document.forms[0].txt_lastYear22.value="<%=Lastyear.get(22)%>";

	
	document.forms[0].txt_totyear1.value="<%=TotalValues.get(1)%>";
	document.forms[0].txt_totyear2.value="<%=TotalValues.get(2)%>";
	document.forms[0].txt_totyear3.value="<%=TotalValues.get(3)%>";
	document.forms[0].txt_totyear4.value="<%=TotalValues.get(4)%>";
	document.forms[0].txt_totyear5.value="<%=TotalValues.get(5)%>";
	document.forms[0].txt_totyear6.value="<%=TotalValues.get(6)%>";
	document.forms[0].txt_totyear7.value="<%=TotalValues.get(7)%>";
	document.forms[0].txt_totyear8.value="<%=TotalValues.get(8)%>";
	document.forms[0].txt_totyear9.value="<%=TotalValues.get(9)%>";
	document.forms[0].txt_totyear10.value="<%=TotalValues.get(10)%>";
	document.forms[0].txt_totyear11.value="<%=TotalValues.get(11)%>";
	document.forms[0].txt_totyear12.value="<%=TotalValues.get(12)%>";
	document.forms[0].txt_totyear13.value="<%=TotalValues.get(13)%>";
	document.forms[0].txt_totyear14.value="<%=TotalValues.get(14)%>";
	document.forms[0].txt_totyear15.value="<%=TotalValues.get(15)%>";
	document.forms[0].txt_totyear16.value="<%=TotalValues.get(16)%>";
	document.forms[0].txt_totyear17.value="<%=TotalValues.get(17)%>";
	document.forms[0].txt_totyear18.value="<%=TotalValues.get(18)%>";
	document.forms[0].txt_totyear19.value="<%=TotalValues.get(19)%>";
	document.forms[0].txt_totyear20.value="<%=TotalValues.get(20)%>";
	document.forms[0].txt_totyear21.value="<%=TotalValues.get(21)%>";
	document.forms[0].txt_totyear22.value="<%=TotalValues.get(22)%>";
	
	disabledFields(true);
	document.forms[0].sel_ass_type.disabled=<%=(hshValues.get("DisableYear"))%>;
	document.forms[0].txt_lastYear0.readOnly=<%=hshValues.get("ReadOnlyLastYearFields")%>;
	document.forms[0].txt_lastYear1.readOnly=<%=hshValues.get("ReadOnlyLastYearFields")%>;
	document.forms[0].txt_lastYear2.readOnly=<%=hshValues.get("ReadOnlyLastYearFields")%>;
	document.forms[0].txt_lastYear3.readOnly=<%=hshValues.get("ReadOnlyLastYearFields")%>;
	document.forms[0].txt_lastYear5.readOnly=<%=hshValues.get("ReadOnlyLastYearFields")%>;
	document.forms[0].txt_lastYear6.readOnly=<%=hshValues.get("ReadOnlyLastYearFields")%>;
	document.forms[0].txt_lastYear7.readOnly=<%=hshValues.get("ReadOnlyLastYearFields")%>;
	document.forms[0].txt_lastYear8.readOnly=<%=hshValues.get("ReadOnlyLastYearFields")%>;
	document.forms[0].txt_lastYear9.readOnly=<%=hshValues.get("ReadOnlyLastYearFields")%>;
	document.forms[0].txt_lastYear10.readOnly=<%=hshValues.get("ReadOnlyLastYearFields")%>;
	document.forms[0].txt_lastYear11.readOnly=<%=hshValues.get("ReadOnlyLastYearFields")%>;
	document.forms[0].txt_lastYear12.readOnly=<%=hshValues.get("ReadOnlyLastYearFields")%>;
	document.forms[0].txt_lastYear13.readOnly=<%=hshValues.get("ReadOnlyLastYearFields")%>;
	document.forms[0].txt_lastYear14.readOnly=<%=hshValues.get("ReadOnlyLastYearFields")%>;
	document.forms[0].txt_lastYear15.readOnly=<%=hshValues.get("ReadOnlyLastYearFields")%>;
	document.forms[0].txt_lastYear16.readOnly=<%=hshValues.get("ReadOnlyLastYearFields")%>;
	document.forms[0].txt_lastYear17.readOnly=<%=hshValues.get("ReadOnlyLastYearFields")%>;
	document.forms[0].txt_lastYear20.readOnly=<%=hshValues.get("ReadOnlyLastYearFields")%>;
	document.forms[0].txt_lastYear21.readOnly=<%=hshValues.get("ReadOnlyLastYearFields")%>;



	if(appstatus=="Open/Pending")
	{
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		enableButtons(false,true,true,true,false,false);
	}
	else
	{
		enableButtons(true,true,true,true,false,false);
		
	}
	}
	else
	{
		enableButtons(true,true,true,true,false,false);
	}
	
}
function callcomments()
{
	    var btnenable=document.forms[0].btnenable.value;
	   
		var appno="<%=(String) request.getParameter("appno")%>";
		var pagetype = "wccomm";
		var purl ="<%=ApplicationParams.getAppUrl()%>action/com_commentpage.jsp?hidBeanGetMethod=getDataComments&hidBeanId=comassestsliab&pagetype="+pagetype+"&appno="+appno+"&appstatus="+appstatus+"&btnenable="+btnenable;				
		var prop = 'scrollbars=yes,menubar=no,width=650,height=355';	
		var xpos = (screen.width - 600) / 2;
		var ypos = (screen.height - 450) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);	
}
function ChangeColumns()
{
		var assesmentType=document.forms[0].sel_ass_type.value;
		document.forms[0].hidBeanId.value="repappcredit"
		document.forms[0].hidBeanGetMethod.value="getCashFlowBudget";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_CashBudgetMethod.jsp";
		document.forms[0].submit();
		disabledFields(false);
				
}
function callFormula()
{
	var a="<%=colCount%>";
	var tot1=0,tot2=0,tot3=0,tot4=0,tot5=0,tot6=0,tot7=0,tot8=0,tot9=0,tot10=0,tot11=0,tot12=0,tot13=0,tot14=0;
	var tot15=0,tot16=0,tot17=0,tot18=0,tot19=0,tot20=0,tot21=0,tot22=0;

	document.forms[0].txt_lastYear4.value=roundVal(eval(document.forms[0].txt_lastYear1.value)+eval(document.forms[0].txt_lastYear2.value)+eval(document.forms[0].txt_lastYear3.value));
	document.forms[0].txt_lastYear18.value=roundVal(eval(document.forms[0].txt_lastYear5.value)+eval(document.forms[0].txt_lastYear6.value)+
													eval(document.forms[0].txt_lastYear7.value)+eval(document.forms[0].txt_lastYear8.value)+
													eval(document.forms[0].txt_lastYear9.value)+eval(document.forms[0].txt_lastYear10.value)+
													eval(document.forms[0].txt_lastYear11.value)+eval(document.forms[0].txt_lastYear12.value)+
													eval(document.forms[0].txt_lastYear13.value)+eval(document.forms[0].txt_lastYear14.value)+
													eval(document.forms[0].txt_lastYear15.value)+eval(document.forms[0].txt_lastYear16.value)+
													eval(document.forms[0].txt_lastYear17.value));

	document.forms[0].txt_lastYear19.value=roundVal(eval(document.forms[0].txt_lastYear4.value)-eval(document.forms[0].txt_lastYear18.value));
	document.forms[0].txt_lastYear22.value=roundVal(eval(document.forms[0].txt_lastYear19.value)+eval(document.forms[0].txt_lastYear20.value)+eval(document.forms[0].txt_lastYear21.value));
	if(a>1)
	{
		<%for(int i=0;i<colCount;i++)
		{
		%>
			var tot_recp=eval(document.forms[0].txt_row1[<%=i%>].value)+eval(document.forms[0].txt_row2[<%=i%>].value)+eval(document.forms[0].txt_row3[<%=i%>].value);
			document.forms[0].txt_row4[<%=i%>].value=roundVal(tot_recp);
			var tot_outflows=eval(document.forms[0].txt_row5[<%=i%>].value)+eval(document.forms[0].txt_row6[<%=i%>].value)+
			eval(document.forms[0].txt_row7[<%=i%>].value)+eval(document.forms[0].txt_row8[<%=i%>].value)+
			eval(document.forms[0].txt_row9[<%=i%>].value)+
			eval(document.forms[0].txt_row10[<%=i%>].value)+eval(document.forms[0].txt_row11[<%=i%>].value)+
			eval(document.forms[0].txt_row12[<%=i%>].value)+eval(document.forms[0].txt_row13[<%=i%>].value)+
			eval(document.forms[0].txt_row14[<%=i%>].value)+eval(document.forms[0].txt_row15[<%=i%>].value)+
			eval(document.forms[0].txt_row16[<%=i%>].value)+eval(document.forms[0].txt_row17[<%=i%>].value);
		document.forms[0].txt_row18[<%=i%>].value=roundVal(tot_outflows);
		document.forms[0].txt_row19[<%=i%>].value=roundVal(roundVal(tot_recp)-roundVal(tot_outflows));

		<%if(i==0)
		{%>
		document.forms[0].txt_row20[<%=i%>].value=document.forms[0].txt_lastYear22.value;
		<%}
		else
		{
		%>
		document.forms[0].txt_row20[<%=i%>].value=document.forms[0].txt_row21[<%=(i-1)%>].value;
		<%}%>
		document.forms[0].txt_row21[<%=i%>].value=roundVal(eval(document.forms[0].txt_row19[<%=i%>].value)+eval(document.forms[0].txt_row20[<%=i%>].value)+eval(document.forms[0].txt_row22[<%=i%>].value));

		tot1=eval(tot1)+eval(document.forms[0].txt_row1[<%=i%>].value);
		tot2=eval(tot2)+eval(document.forms[0].txt_row2[<%=i%>].value);
		tot3=eval(tot3)+eval(document.forms[0].txt_row3[<%=i%>].value);
		tot4=eval(tot4)+eval(document.forms[0].txt_row4[<%=i%>].value);
		tot5=eval(tot5)+eval(document.forms[0].txt_row5[<%=i%>].value);
		tot6=eval(tot6)+eval(document.forms[0].txt_row6[<%=i%>].value);
		tot7=eval(tot7)+eval(document.forms[0].txt_row7[<%=i%>].value);
		tot8=eval(tot8)+eval(document.forms[0].txt_row8[<%=i%>].value);
		tot9=eval(tot9)+eval(document.forms[0].txt_row9[<%=i%>].value);
		tot10=eval(tot10)+eval(document.forms[0].txt_row10[<%=i%>].value);
		tot11=eval(tot11)+eval(document.forms[0].txt_row11[<%=i%>].value);
		tot12=eval(tot12)+eval(document.forms[0].txt_row12[<%=i%>].value);
		tot13=eval(tot13)+eval(document.forms[0].txt_row13[<%=i%>].value);
		tot14=eval(tot14)+eval(document.forms[0].txt_row14[<%=i%>].value);
		tot15=eval(tot15)+eval(document.forms[0].txt_row15[<%=i%>].value);
		tot16=eval(tot16)+eval(document.forms[0].txt_row16[<%=i%>].value);
		tot17=eval(tot17)+eval(document.forms[0].txt_row17[<%=i%>].value);
		tot18=eval(tot18)+eval(document.forms[0].txt_row18[<%=i%>].value);
		tot19=eval(tot19)+eval(document.forms[0].txt_row19[<%=i%>].value);
		tot20=eval(tot20)+eval(document.forms[0].txt_row20[<%=i%>].value);
		tot21=eval(tot21)+eval(document.forms[0].txt_row22[<%=i%>].value);
		tot22=eval(tot22)+eval(document.forms[0].txt_row21[<%=i%>].value);
		<%}%>

		document.forms[0].txt_totyear1.value=roundVal(tot1);
		document.forms[0].txt_totyear2.value=roundVal(tot2);
		document.forms[0].txt_totyear3.value=roundVal(tot3);
		document.forms[0].txt_totyear4.value=roundVal(tot4);
		document.forms[0].txt_totyear5.value=roundVal(tot5);
		document.forms[0].txt_totyear6.value=roundVal(tot6);
		document.forms[0].txt_totyear7.value=roundVal(tot7);
		document.forms[0].txt_totyear8.value=roundVal(tot8);
		document.forms[0].txt_totyear9.value=roundVal(tot9);
		document.forms[0].txt_totyear10.value=roundVal(tot10);
		document.forms[0].txt_totyear11.value=roundVal(tot11);
		document.forms[0].txt_totyear12.value=roundVal(tot12);
		document.forms[0].txt_totyear13.value=roundVal(tot13);
		document.forms[0].txt_totyear14.value=roundVal(tot14);
		document.forms[0].txt_totyear15.value=roundVal(tot15);
		document.forms[0].txt_totyear16.value=roundVal(tot16);
		document.forms[0].txt_totyear17.value=roundVal(tot17);
		document.forms[0].txt_totyear18.value=roundVal(tot18);
		document.forms[0].txt_totyear19.value=roundVal(tot19);
		//document.forms[0].txt_totyear20.value=roundVal(tot20);
		//document.forms[0].txt_totyear21.value=roundVal(tot21);
		document.forms[0].txt_totyear22.value=roundVal(tot22);
		
	}
	else
	{
		var tot_recp=eval(document.forms[0].txt_row1.value)+eval(document.forms[0].txt_row2.value)+eval(document.forms[0].txt_row3.value);
		document.forms[0].txt_row4.value=roundVal(tot_recp);
		var tot_outflows=eval(document.forms[0].txt_row5.value)+eval(document.forms[0].txt_row6.value)+
						eval(document.forms[0].txt_row7.value)+eval(document.forms[0].txt_row8.value)+
						eval(document.forms[0].txt_row9.value)+
						eval(document.forms[0].txt_row10.value)+eval(document.forms[0].txt_row11.value)+
						eval(document.forms[0].txt_row12.value)+eval(document.forms[0].txt_row13.value)+
						eval(document.forms[0].txt_row14.value)+eval(document.forms[0].txt_row15.value)+
						eval(document.forms[0].txt_row16.value)+eval(document.forms[0].txt_row17.value);
		document.forms[0].txt_row18.value=roundVal(tot_outflows);
		document.forms[0].txt_row19.value=roundVal(roundVal(tot_recp)-roundVal(tot_outflows));

		document.forms[0].txt_row20.value=document.forms[0].txt_lastYear22.value;
		
		document.forms[0].txt_row21.value=roundVal(eval(document.forms[0].txt_row19.value)+eval(document.forms[0].txt_row20.value)+eval(document.forms[0].txt_row22.value));

		

		document.forms[0].txt_totyear1.value=document.forms[0].txt_row1.value;
		document.forms[0].txt_totyear2.value=document.forms[0].txt_row2.value;
		document.forms[0].txt_totyear3.value=document.forms[0].txt_row3.value;
		document.forms[0].txt_totyear4.value=document.forms[0].txt_row4.value;
		document.forms[0].txt_totyear5.value=document.forms[0].txt_row5.value;
		document.forms[0].txt_totyear6.value=document.forms[0].txt_row6.value;
		document.forms[0].txt_totyear7.value=document.forms[0].txt_row7.value;
		document.forms[0].txt_totyear8.value=document.forms[0].txt_row8.value;
		document.forms[0].txt_totyear9.value=document.forms[0].txt_row9.value;
		document.forms[0].txt_totyear10.value=document.forms[0].txt_row10.value;
		document.forms[0].txt_totyear11.value=document.forms[0].txt_row11.value;
		document.forms[0].txt_totyear12.value=document.forms[0].txt_row12.value;
		document.forms[0].txt_totyear13.value=document.forms[0].txt_row13.value;
		document.forms[0].txt_totyear14.value=document.forms[0].txt_row14.value;
		document.forms[0].txt_totyear15.value=document.forms[0].txt_row15.value;
		document.forms[0].txt_totyear16.value=document.forms[0].txt_row16.value;
		document.forms[0].txt_totyear17.value=document.forms[0].txt_row17.value;
		document.forms[0].txt_totyear18.value=document.forms[0].txt_row18.value;
		document.forms[0].txt_totyear19.value=document.forms[0].txt_row19.value;
		//document.forms[0].txt_totyear20.value=document.forms[0].txt_row20.value;
		//document.forms[0].txt_totyear21.value=document.forms[0].txt_row22.value;
		document.forms[0].txt_totyear22.value=document.forms[0].txt_row21.value;
	}
}
function doComments()
{
	var btnenable=document.forms[0].btnenable.value;
	var strAppno =appno;
	var pagetype = document.forms[0].hidCommentPage.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/com_comments.jsp?hidBeanId=comproposal&hidBeanGetMethod=getDataComments&pagetype="+pagetype+"&strAppno="+strAppno+"&appstatus="+appstatus+"&btnenable="+btnenable;
	window.open(url,"Comments",prop);
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placeValues()">
  <div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>
<form  method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"	class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="41" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<span class="page_flow">Home -&gt; Corporate &amp; SME -&gt;Proposal -&gt; Assessment -&gt; Cash Flow Budget</span><br>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
 <jsp:include
	page="../com/com_commentstab.jsp" flush="true">
	<jsp:param name="tabid" value="18" />
</jsp:include>


<br>
<table width="70%" cellpadding="5" cellspacing="0"  class="outertable"  border="0" align="left">
			<tr>
				<td width="21%">
					&nbsp;Whether the Assessment is 
				</td>
				<td width="10%">
				<select name="sel_ass_type" onchange="ChangeColumns()">
					
					<option value="12" >Monthly</option>
					<option value="4">Quarterly</option>
					<option value="2">Half-Yearly</option>
					<option value="1">Yearly</option>
				</select>
				</td>

				<td width="15%">
					Select the year
				</td>
				<td width="6%">	
					<select name="sel_year" onchange="ChangeColumns()">
						<option value="y1">Year 1</option>
						<option value="y2">Year 2</option>
						<option value="y3">Year 3</option>
						<option value="y4">Year 4</option>
						<option value="y5">Year 5</option>
						<option value="y6">Year 6</option>
						<option value="y7">Year 7</option>
						<option value="y8">Year 8</option>
						<option value="y9">Year 9</option>
						<option value="y10">Year 10</option>
					</select>&nbsp;
					<input type="text" name="txt_finYear" size="10" onKeyPress="allowAlpaNumeric(this)" maxlength="9" >
				</td>
				
			</tr>
		</table><br><br>
		<table id="table_monthly" cellpadding="3" cellspacing="1" width="98%" class="outertable" border="0" align="center">
		<tr class="dataheader"><td align="right" colspan="5"><b>All Values are in <%=Helper.correctNull((String)hshValues.get("strValuesin")) %></b></td></tr>
			<tr class="dataheader">
				<td width="1%">
					&nbsp;
				</td>
				<td width="20%" align="center">
				Particulars
				</td>
				<td width="6%" align="center" style="visibility: hidden;position: absolute;">
				
					<input type="text" name="txt_lastYear0" size="18" maxlength="45">
					
				</td>
				<%for(int i=0;i<colCount;i++)
					{
					%>
				<td width="6%" align="center">
					<input type="text" name="txt_particulars" size="18" maxlength="45">
				</td>
				<%} %>
				<td width="8%" align="center">
				 Total
				</td>
				
			</tr>
			<tr class="applicationheader">
				<td width="1%">
				&nbsp;
				</td>
				<td width="18%" >
				Cash Inflows
				</td>
				<td style="visibility: hidden;position: absolute;">
				&nbsp;
				</td>
				<td colspan="<%=colCount %>">
				&nbsp;
				</td>
				<td>
				&nbsp;
				</td>
				</tr>
			<tr class="datagrid">
				<td width="1%" align="center">
				1.
				</td>
				<td width="18%">
					Net contract receipts 
				</td>
				<td align="center" style="visibility: hidden;position: absolute;">
					<input type="text" name="txt_lastYear1" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" maxlength="10">
				</td>
				<%for(int i=0;i<colCount;i++)
					{
					%>
				<td width="6%" align="center">
					<input type="text" name="txt_row1" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" maxlength="10">
				</td>
				<%} %>
				<td width="8%" align="center">
				<input type="text" name="txt_totyear1" size="15"  style="text-align:right;border-style=groove;color:blue;border: 0" readonly="readonly"> 
				</td>
				
			</tr>
			<tr class="datagrid">
				<td width="1%" align="center">
				2.
				</td>
				<td width="18%">
					Sub contrcat Receipts
				</td>
				<td align="center" style="visibility: hidden;position: absolute;">
					<input type="text" name="txt_lastYear2" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" maxlength="10">
				</td>
				<%for(int i=0;i<colCount;i++)
					{
					%>
				<td width="6%" align="center">
					<input type="text" name="txt_row2"  size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" maxlength="10"> 
				</td>
				<%} %>
				<td width="8%" align="center">
				<input type="text" name="txt_totyear2" size="15"  style="text-align:right;border-style=groove;color:blue;border: 0" readonly="readonly" >
				</td>
				
			</tr>
			<tr class="datagrid">
				<td width="1%" align="center">
				3.
				</td>
				<td width="18%">
					Other Receipts
				</td>
				<td align="center" style="visibility: hidden;position: absolute;">
					<input type="text" name="txt_lastYear3" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" maxlength="10">
				</td>
				<%for(int i=0;i<colCount;i++)
					{
					%>
				<td width="6%" align="center">
					<input type="text" name="txt_row3"  size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" maxlength="10">
				</td>
				<%} %>
				<td width="8%" align="center">
				<input type="text" name="txt_totyear3" size="15"  style="text-align:right;border-style=groove;color:blue;border: 0" readonly="readonly">
				</td>
				
			</tr>
			<tr class="datagrid">
				<td width="1%" align="center">
				4.
				</td>
				<td width="18%">
					Total Receipts
				</td>
				<td align="center" style="visibility: hidden;position: absolute;">
					<input type="text" name="txt_lastYear4" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;color:blue;border: 0" onblur="roundtxt(this);" readonly="readonly" >
				</td>
				<%for(int i=0;i<colCount;i++)
					{
					%>
				<td width="6%" align="center">
					<input type="text" name="txt_row4"  size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;border-style=groove;color:blue;border: 0" onblur="roundtxt(this)" readonly="readonly">
				</td>
				<%} %>
				<td width="8%" align="center">
					<input type="text" name="txt_totyear4" size="15"  style="text-align:right;border-style=groove;color:blue;border: 0" readonly="readonly">
				</td>
				
			</tr>
			<tr class="applicationheader">
				<td width="1%">
				&nbsp;
				</td>
				<td width="18%">
					Cash Outflows
				</td>
				<td style="visibility: hidden;position: absolute;">
				&nbsp;
				</td>
				<td width="6%" colspan="<%=colCount %>">
					&nbsp;
				</td>
				<td>
				&nbsp;
				</td>
				
			</tr>
			<tr class="datagrid">
				<td width="1%" align="center">
				5.
				</td>
				<td width="18%">
					Materials
				</td>
				<td align="center" style="visibility: hidden;position: absolute;">
					<input type="text" name="txt_lastYear5" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" maxlength="10">
				</td>
				<%for(int i=0;i<colCount;i++)
					{
					%>
				<td width="6%" align="center">
					<input type="text" name="txt_row5"  size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" maxlength="10">
				</td>
				<%} %>
				<td width="8%" align="center">
					<input type="text" name="txt_totyear5" size="15"  style="text-align:right;border-style=groove;color:blue;border: 0" readonly="readonly" onchange="callFormula()">
				</td>
				
			</tr>
			<tr class="datagrid">
				<td width="1%" align="center">
				6.
				</td>
				<td width="18%">
					Salaries &amp; Wages
				</td>
				<td align="center" style="visibility: hidden;position: absolute;">
					<input type="text" name="txt_lastYear6" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" maxlength="10">
				</td>
				<%for(int i=0;i<colCount;i++)
					{
					%>
				<td width="6%" align="center">
					<input type="text" name="txt_row6"  size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" maxlength="10">
				</td>
				<%} %>
				<td width="8%" align="center">
					<input type="text" name="txt_totyear6" size="15"  style="text-align:right;border-style=groove;color:blue;border: 0" readonly="readonly">
				</td>
				
			</tr>
			<tr class="datagrid">
				<td width="1%" align="center">
				7.
				</td>
				<td width="18%">
					Sub Contractors
				</td>
				<td align="center" style="visibility: hidden;position: absolute;">
					<input type="text" name="txt_lastYear7" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" maxlength="10">
				</td>
				<%for(int i=0;i<colCount;i++)
					{
					%>
				<td width="6%" align="center">
					<input type="text" name="txt_row7"  size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" maxlength="10">
				</td>
				<%} %>
				<td width="8%" align="center">
					<input type="text" name="txt_totyear7" size="15"  style="text-align:right;border-style=groove;color:blue;border: 0" readonly="readonly">
				</td>
				
			</tr>
			<tr class="datagrid">
				<td width="1%" align="center">
				8.
				</td>
				<td width="18%">
					Hire Charges
				</td>
				<td align="center" style="visibility: hidden;position: absolute;">
					<input type="text" name="txt_lastYear8" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" maxlength="10">
				</td>
				<%for(int i=0;i<colCount;i++)
					{
					%>
				<td width="6%" align="center">
					<input type="text" name="txt_row8"  size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" maxlength="10">
				</td>
				<%} %>
				<td width="8%" align="center">
					<input type="text" name="txt_totyear8" size="15"  style="text-align:right;border-style=groove;color:blue;border: 0" readonly="readonly">
				</td>
				
			</tr>
			<tr class="datagrid">
				<td width="1%" align="center">
				9.
				</td>
				<td width="18%">
					Labour Charges
				</td>
				<td align="center" style="visibility: hidden;position: absolute;">
					<input type="text" name="txt_lastYear9" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" maxlength="10">
				</td>
				<%for(int i=0;i<colCount;i++)
					{
					%>
				<td width="6%" align="center">
					<input type="text" name="txt_row9"  size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" maxlength="10">
				</td>
				<%} %>
				<td width="8%" align="center">
					<input type="text" name="txt_totyear9" size="15"  style="text-align:right;border-style=groove;color:blue;border: 0" readonly="readonly">
				</td>
				
			</tr>
			<tr class="datagrid">
				<td width="1%" align="center">
				10.
				</td>
				<td width="18%">
					Diesel &amp; Petrol Charges
				</td>
				<td align="center" style="visibility: hidden;position: absolute;">
					<input type="text" name="txt_lastYear10" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" maxlength="10">
				</td>
				<%for(int i=0;i<colCount;i++)
					{
					%>
				<td width="6%" align="center">
					<input type="text" name="txt_row10"  size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" maxlength="10">
				</td>
				<%} %>
				<td width="8%" align="center">
					<input type="text" name="txt_totyear10" size="15"  style="text-align:right;border-style=groove;color:blue;border: 0" readonly="readonly" maxlength="10">
				</td>
				
			</tr>
			<tr class="datagrid">
				<td width="1%" align="center">
				11.
				</td>
				<td width="18%">
					Repair &amp; Maintenance
				</td>
				<td align="center" style="visibility: hidden;position: absolute;">
					<input type="text" name="txt_lastYear11" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()"  maxlength="10">
				</td>
				<%for(int i=0;i<colCount;i++)
					{
					%>
				<td width="6%" align="center">
					<input type="text" name="txt_row11"  size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" maxlength="10">
				</td>
				<%} %>
				<td width="8%" align="center">
					<input type="text" name="txt_totyear11" size="15"  style="text-align:right;border-style=groove;color:blue;border: 0" readonly="readonly">
				</td>
				
			</tr>
			<tr class="datagrid">
				<td width="1%" align="center">
				12.
				</td>
				<td width="18%">
					Travelling Expenses
				</td>
				<td align="center" style="visibility: hidden;position: absolute;">
					<input type="text" name="txt_lastYear12" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" maxlength="10">
				</td>
				<%for(int i=0;i<colCount;i++)
					{
					%>
				<td width="6%" align="center">
					<input type="text" name="txt_row12"  size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" maxlength="10">
				</td>
				<%} %>
				<td width="8%" align="center">
					<input type="text" name="txt_totyear12" size="15"  style="text-align:right;border-style=groove;color:blue;border: 0" readonly="readonly">
				</td>
				
			</tr>
			<tr class="datagrid">
				<td width="1%" align="center">
				13.
				</td>
				<td width="18%">
					Other Operating Expenses
				</td>
				<td align="center" style="visibility: hidden;position: absolute;">
					<input type="text" name="txt_lastYear13" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" maxlength="10">
				</td>
				<%for(int i=0;i<colCount;i++)
					{
					%>
				<td width="6%" align="center">
					<input type="text" name="txt_row13"  size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" maxlength="10">
				</td>
				<%} %>
				<td width="8%" align="center">
					<input type="text" name="txt_totyear13" size="15"  style="text-align:right;border-style=groove;color:blue;border: 0" readonly="readonly">
				</td>
				
			</tr>
			<tr class="datagrid">
				<td width="1%" align="center">
				14.
				</td>
				<td width="18%">
					Bank Interest &amp; Charges
				</td>
				<td align="center" style="visibility: hidden;position: absolute;">
					<input type="text" name="txt_lastYear14" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" >
				</td>
				<%for(int i=0;i<colCount;i++)
					{
					%>
				<td width="6%" align="center">
					<input type="text" name="txt_row14"  size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()">
				</td>
				<%} %>
				<td width="8%" align="center">
					<input type="text" name="txt_totyear14" size="15"  style="text-align:right;border-style=groove;color:blue;border: 0" readonly="readonly">
				</td>
				
			</tr>
			<tr class="datagrid">
				<td width="1%" align="center">
				15.
				</td>
				<td width="18%">
					Tax payable
				</td>
				<td align="center" style="visibility: hidden;position: absolute;">
					<input type="text" name="txt_lastYear15" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" >
				</td>
				<%for(int i=0;i<colCount;i++)
					{
					%>
				<td width="6%" align="center">
					<input type="text" name="txt_row15"  size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()">
				</td>
				<%} %>
				<td width="8%" align="center">
					<input type="text" name="txt_totyear15" size="15"  style="text-align:right;border-style=groove;color:blue;border: 0" readonly="readonly">
				</td>
				
			</tr>
			<tr class="datagrid">
				<td width="1%" align="center">
				16.
				</td>
				<td width="18%">
					Administrative expenses
				</td>
				<td align="center" style="visibility: hidden;position: absolute;">
					<input type="text" name="txt_lastYear16" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" >
				</td>
				<%for(int i=0;i<colCount;i++)
					{
					%>
				<td width="6%" align="center">
					<input type="text" name="txt_row16"  size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()">
				</td>
				<%} %>
				<td width="8%" align="center">
					<input type="text" name="txt_totyear16" size="15"  style="text-align:right;border-style=groove;color:blue;border: 0" readonly="readonly">
				</td>
				
			</tr>
			<tr class="datagrid">
				<td width="1%" align="center">
				17.
				</td>
				<td width="18%">
					Other expenses
				</td>
				<td align="center" style="visibility: hidden;position: absolute;">
					<input type="text" name="txt_lastYear17" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" >
				</td>
				<%for(int i=0;i<colCount;i++)
					{
					%>
				<td width="6%" align="center">
					<input type="text" name="txt_row17"  size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()">
				</td>
				<%} %>
				<td width="8%" align="center">
					<input type="text" name="txt_totyear17" size="15"  style="text-align:right;border-style=groove;color:blue;border: 0" readonly="readonly">
				</td>
				
			</tr>
			<tr class="datagrid">
				<td width="1%" align="center">
				18.
				</td>
				<td width="18%" >
					Total Outflows
				</td>
				<td align="center" style="visibility: hidden;position: absolute;">
					<input type="text" name="txt_lastYear18" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;border-style=groove;color:blue;border: 0" onblur="roundtxt(this);"  readonly="readonly">
				</td>
				<%for(int i=0;i<colCount;i++)
					{
					%>
				<td width="6%" align="center">
					<input type="text" name="txt_row18"  size="15"  onKeyPress="allowNegtiveNumber(this)" style="text-align:right;border-style=groove;color:blue;border: 0" onblur="roundtxt(this);" readonly="readonly">
				</td>
				<%} %>
				<td width="8%" align="center">
					<input type="text" name="txt_totyear18" size="15"  style="text-align:right;border-style=groove;color:blue;border: 0" readonly="readonly">
				</td>
				
			</tr>
			<tr class="datagrid">
				<td width="1%" align="center">
				19.
				</td>
				<td width="18%">
					Surplus (+) / Deficit (-)
				</td>
				<td align="center" style="visibility: hidden;position: absolute;">
					<input type="text" name="txt_lastYear19" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;border-style=groove;color:blue;border: 0" onblur="roundtxt(this);" >
				</td>
				<%for(int i=0;i<colCount;i++)
					{
					%>
				<td width="6%" align="center">
					<input type="text" name="txt_row19"  size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;border-style=groove;color:blue;border: 0" onblur="roundtxt(this)" readonly="readonly">
				</td>
				<%} %>
				<td width="8%" align="center">
					<input type="text" name="txt_totyear19" size="15"  style="text-align:right;border-style=groove;color:blue;border: 0;visibility: hidden;position: absolute;" readonly="readonly">
				</td>
				
			</tr>
			<tr class="datagrid" style="visibility: hidden;position: absolute;">
				<td width="1%" align="center" >
				20.
				</td>
				<td width="18%">
					Opening Cash Credit
				</td>
				<td align="center" style="visibility: hidden;position: absolute;">
					<input type="text" name="txt_lastYear20" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);" >
				</td>
				<%for(int i=0;i<colCount;i++)
					{
					%>
				<td width="6%" align="center">
					<input type="text" name="txt_row20"  size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;border-style=groove;color:blue" onblur="roundtxt(this);callFormula()" readonly="readonly">
				</td>
				<%} %>
				<td width="8%" align="center">
					<input type="text" name="txt_totyear20" size="15"  style="text-align:right;" onblur="roundtxt(this);callFormula()">
				</td>
				
			</tr>
			
			<tr class="datagrid" style="visibility: hidden;position: absolute;">
				<td width="1%" align="center">
				21.
				</td>
				<td width="18%">
					Bank finance
				</td>
				<td align="center" style="visibility: hidden;position: absolute;">
					<input type="text" name="txt_lastYear21" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()" >
				</td>
				<%for(int i=0;i<colCount;i++)
					{
					%>
				<td width="6%" align="center">
					<input type="text" name="txt_row22"  size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;" onblur="roundtxt(this);callFormula()">
				</td>
				<%} %>
				<td width="8%" align="center">
					<input type="text" name="txt_totyear21" size="15"  style="text-align:right;" onblur="roundtxt(this);callFormula()">
				</td>
				
			</tr>
			
			<tr class="datagrid" style="visibility: hidden;position: absolute;">
				<td width="1%" align="center">
				22.
				</td>
				<td width="18%">
					Surplus / Deficit
				</td>
				<td align="center" style="visibility: hidden;position: absolute;">
					<input type="text" name="txt_lastYear22" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;border-style=groove;color:blue;border: 0" onchange="callFormula()" readonly="readonly">
				</td>
				<%for(int i=0;i<colCount;i++)
					{
					%>
				<td width="6%" align="center">
					<input type="text" name="txt_row21"  size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;border-style=groove;color:blue;border: 0" onblur="roundtxt(this)" readonly="readonly">
				</td>
				<%} %>
				<td width="8%" align="center">
					<input type="text" name="txt_totyear22" size="15"  style="text-align:right;border-style=groove;color:blue;border: 0" readonly="readonly">
				</td>
				
			</tr>
			<tr class="datagrid">
				<td width="1%" align="center">
				20.
				</td>
				<td width="18%">
					Peak Deficit
				</td>
				<td align="center" style="visibility: hidden;position: absolute;">
					<input type="text" name="txt_lastYear23" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right;border-style=groove;color:blue;border: 0" onchange="callFormula()" readonly="readonly">
				</td>
				<td width="6%" align="center">
					<input type="text" name="txt_row23"  size="15" onKeyPress="allowNegtiveNumber(this)" value="<%=maxDeficit%>" style="text-align:right;border-style=groove;color:blue;border: 0" onblur="roundtxt(this)" readonly="readonly">
				</td>
				<%for(int i=1;i<colCount;i++)
					{
					%>
				<td width="6%" align="center">
					<input type="text" name="txt_row23"  size="15" onKeyPress="allowNegtiveNumber(this)" style="visibility: hidden;position: absolute;" onblur="roundtxt(this)" readonly="readonly">
				</td>
				<%} %>
				<td width="8%" align="center">
					<input type="text" name="txt_totyear23" size="15"  style="visibility: hidden;position: absolute;" readonly="readonly">
				</td>
				
			</tr>
		</table>
		<br/>
<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Comments_Cancel"	btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<br/>
<input type="hidden" name="hidAction">
<input type="hidden"	name="hidBeanId">
<input type="hidden" name="hidBeanMethod"value="">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidSourceUrl"> 
<input type="hidden" name="hidassesttype"> 
<input type="hidden" name="strappno" value="<%=Helper.correctNull(request.getParameter("appno"))%>">
<input type="hidden" name="hidvarid">
<INPUT TYPE="hidden" name="pageval" value = "">
<input type="hidden" name="colspanval" value="1">
<input type="hidden" name="pagefrom">
<INPUT TYPE="hidden" name="strAssessment" value = "<%=request.getParameter("strAssessment")%>">
<input type="hidden" name="hidCommentPage" value="cashbudget">
</form>
</body>
</html>	
