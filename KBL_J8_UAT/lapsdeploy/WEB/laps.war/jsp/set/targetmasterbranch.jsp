<%@ include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}%>
<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var win=null;

function disableButtons(val2,val3,val4,val5,val6)
{
	document.forms[0].cmdedit.disabled=val2;
	document.forms[0].cmdsave.disabled=val3;
	document.forms[0].cmdcancel.disabled=val4;
	document.forms[0].cmddelete.disabled=val5;
	document.forms[0].cmdclose.disabled=val6;
}

function display_branch_names()
{
	var bnkname = "A";
	document.all.ifrm.src=appUrl+"action/iframetargetmasterbranch.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname; 
}
 
function doClose()
{
 	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}
 
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appUrl+"action/targetmasterbranch.jsp";
		document.forms[0].submit();
	}
}

function doNew()
{
	disableButtons(true,false,false,true,true);
	for(var i=0;i<document.forms[0].txt_target_noofaccounts.length;i++)
	{
		document.forms[0].txt_target_noofaccounts[i].value="";
		document.forms[0].txt_target_amount[i].value="";
		
		document.forms[0].txt_sanctioned_noofaccounts[i].value="";
		document.forms[0].txt_sanctioned_amount[i].value="";
		
		document.forms[0].txt_outstanding_noofaccounts[i].value="";
		document.forms[0].txt_outstanding_amount[i].value="";
	}
	for(var i=0;i<document.forms[0].txt_target_noofaccounts_calculated.length;i++)
	{
		document.forms[0].txt_target_noofaccounts_calculated[i].value="";
		document.forms[0].txt_target_amount_calculated[i].value="";
		
		document.forms[0].txt_sanctioned_noofaccounts_calculated[i].value="";
		document.forms[0].txt_sanctioned_amount_calculated[i].value="";
		
		document.forms[0].txt_outstanding_noofaccounts_calculated[i].value="";
		document.forms[0].txt_outstanding_amount_calculated[i].value="";
	}
	
}

function doSave()
{
	
	if(document.forms[0].sel_branch.selectedIndex=="0")
 	{
 		alert("Select the Branch");
 	}
 	else if(document.forms[0].sel_target.value=="0")
 	{
 		alert("Select Existing Target ");
 	}
 	else if(document.forms[0].sel_target.value=="new" && document.forms[0].sel_month.value=="0")
 	{
 		alert("Select Month");
 	}
  	else
 	{
  		document.forms[0].cmdsave.disabled = true;
 		document.forms[0].sel_branch.disabled=false;
 		document.forms[0].sel_target.disabled=false;
		document.forms[0].hidAction.value="insert";
		document.forms[0].hidBeanId.value="targetmaster";
		document.forms[0].hidBeanMethod.value="updateTargetMasterData";
		document.forms[0].hidSourceUrl.value="/action/targetmasterbranch.jsp";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].sel_branch.disabled=false;
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="targetmaster";
		document.forms[0].hidBeanMethod.value="updateTargetMasterData";
		document.forms[0].hidSourceUrl.value="/action/targetmasterbranch.jsp";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
}


function doEdit()
{
	document.forms[0].sel_branch.disabled=true;
	document.forms[0].sel_target.disabled=true;
	document.forms[0].txt_yearfrom.readOnly=true;
	disableButtons(true,false,false,false,true);
	validatefields();
	setTextBoxColor();
	settabindex();
}

function settabindex()
{
	var tab = 0;
	for(var i=0;i<document.forms[0].txt_target_noofaccounts.length;i++)
	{	
		tab = tab+1;
		if(document.forms[0].txt_target_noofaccounts[i].readOnly==false)
		{	
			document.forms[0].txt_target_noofaccounts[i].tabIndex = tab;
		}
		if(document.forms[0].txt_target_amount[i].readOnly==false)
		{	
			tab=tab+1;
			document.forms[0].txt_target_amount[i].tabIndex = tab;	
		}
		if(document.forms[0].txt_sanctioned_noofaccounts[i].readOnly==false)
		{	tab=tab+1;
			document.forms[0].txt_sanctioned_noofaccounts[i].tabIndex =  tab;
		}
		if(document.forms[0].txt_sanctioned_amount[i].readOnly==false)
		{	tab=tab+1;
			document.forms[0].txt_sanctioned_amount[i].tabIndex = tab;
		}
			
				
		if(document.forms[0].txt_outstanding_noofaccounts[i].readOnly==false)
		{	tab=tab+1;
			document.forms[0].txt_outstanding_noofaccounts[i].tabIndex = tab;
		}
		
					
		if(document.forms[0].txt_outstanding_amount[i].readOnly==false)
		{	tab=tab+1;
			document.forms[0].txt_outstanding_amount[i].tabIndex = tab;	
		}
	}
	document.forms[0].txt_target_noofaccounts[0].focus();
}

function callPrint()
{
	if(document.forms[0].sel_target.value=='0' || document.forms[0].sel_target.value=='')
	{
		alert("Select an Existing Target");
		return;
	}
	if(document.forms[0].cmdsave.disabled==false)
	{
		alert("Cannot Print in edit mode");
		return;
	}
	if(win!=null && win.closed==false)
	{
		win.close();
	}
	win=window.open("","title","scrollbars=yes,menubar=yes,width=950,height=520");
	win.document.write("<html>");
	win.document.write("<head>");
	win.document.write("<title>LAPS</title>");
	win.document.write("<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>");
	win.document.write("</head>");
	win.document.write("<body>");
	win.document.write("<form name= 'orgfrm' method='post' class='normal'>");
	win.document.write("<div id='top'>");
 	win.document.write("<table width='100%' border='0' cellspacing='0' cellpadding='3' class='outertable'>");
    win.document.write("<tr>");
    win.document.write("<td align='center'><img src='<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg'></td>");       		
    win.document.write("</tr>");
    win.document.write("<tr>"); 
    win.document.write("<td align='center'><strong>Karnataka Bank Ltd.</strong></td>");
    win.document.write("</tr>");
    win.document.write("<tr>"); 
    win.document.write("<td align='center'><%=Helper.correctNull((String)session.getAttribute("strOrgName"))%></td>");
    win.document.write("</tr>");
    win.document.write("<tr>"); 
    win.document.write("<td align='center'> Target Master Report </td>");
    win.document.write("</tr>");
    win.document.write("</table>");
	win.document.write("<TABLE border='0' width='100%' class='outertable'>");
	win.document.write("<TR>");
	win.document.write("<TD width='20%' align='right'><B>Generated By :</B></TD>");
	win.document.write("<TD width='30%'>"+'<%=session.getAttribute("strUserName")%>'+"</TD>");
	win.document.write("<TD width='20%' align='right'><B>Branch :</B></TD>");
	win.document.write("<TD width='30%'>"+document.forms[0].sel_branch.options[document.forms[0].sel_branch.selectedIndex].text+"</TD>");
	win.document.write("</TR>");
	win.document.write("<TR>");
	win.document.write("<TD width='20%' align='right'><B>Generated On :</B></TD>");
	win.document.write("<TD width='30%'>"+'<%=Helper.getCurrentDateTime()%>'+"</TD>");
	win.document.write("<TD width='20%' align='right'><B>Period :</B></TD>");
	win.document.write("<TD width='30%'>"+document.forms[0].txt_periodfrom.value+" - "+document.forms[0].txt_periodto.value+"</TD>");
	win.document.write("</TR>");
	win.document.write("<TR>");
	win.document.write("<TD >&nbsp; </TD>");
	win.document.write("<TD >&nbsp; </TD>");
	win.document.write("</TR>");
	win.document.write("<TR>");
	win.document.write("<TD > &nbsp;</TD>");
	win.document.write("<TD >&nbsp; </TD>");
	win.document.write("</TR>");
	win.document.write("<TR>");
	win.document.write("<TD >&nbsp; </TD>");
	win.document.write("<TD >&nbsp; </TD>");
	win.document.write("</TR>");
	win.document.write("<tr> ");
    win.document.write("<td colspan='4' align='center'> ");
    win.document.write("<b> Note : All Amounts are in Lakhs </b>");
    win.document.write("</td> ");
    win.document.write("</tr> ");
	win.document.write("</TABLE>");
	win.document.write("<div id='top'>");
    win.document.write("<table width='100%' border='0' cellspacing='0' cellpadding='0' align='center' class='outertable'>");
    win.document.write("<tr>"); 
    win.document.write("<td height='3'>"); 
    win.document.write("<div id='top'>");
    win.document.write("<table width='100%' border='1' cellspacing='0' cellpadding='3' class='outertable'>");
    win.document.write("<tr> ");
    win.document.write("<td> ");
	win.document.write("<div align='center'><B>"+ "&nbsp;" + "</B></div>");
	win.document.write("</td>");
	win.document.write("<td colspan='2'> ");
	win.document.write("<div align='center'><B>"+document.forms[0].txt_label1.value + "</B></div>");
	win.document.write("</td>");
	win.document.write("<td colspan='2'> ");
	win.document.write("<div align='center'><B>"+document.forms[0].txt_label2.value + "</B></div>");
	win.document.write("</td>");
	win.document.write("<td colspan='2'> ");
	win.document.write("<div align='center'><B>"+document.forms[0].txt_label3.value + "</B></div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write("<div align='center'><B>"+ "&nbsp;" + "</B></div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='center'><B>"+ "No of Accounts " + "</B></div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='center'><B>"+ "Amount " + "</B></div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='center'><B>"+ "No of Accounts " + "</B></div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='center'><B>"+ "Amount " + "</B></div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='center'><B>"+ "No of Accounts " + "</B></div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='center'><B>"+ "Amount " + "</B></div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	
	<%
		int j=0,txtbox_count=0,calculatedbox_count=0;
		ArrayList array=new ArrayList();
		array.add("Total Deposits ");
		array.add("Gross Advances ");
		array.add("Export Advances ");
		for(j=0;j<array.size();j++)
		{
	%>
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write(""+'<%=array.get(j)%>');
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	<%
		txtbox_count++;
		}
		array=null;
	%>
	
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write("<B>Priority Sector Advances</B>");
	win.document.write("</td>");
	win.document.write("<td colspan='6'>  ");
	win.document.write("<div align='right'>&nbsp;</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write("<B> &nbsp; &nbsp; Agriculture </B>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> "); 
	<%
		calculatedbox_count++;
	%>
	
	<%
		array=new ArrayList();
		array.add("Direct");
		array.add("Indirect");
		for(j=0;j<array.size();j++)
		{
	%>
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write(" &nbsp; &nbsp; &nbsp; &nbsp;"+'<%=array.get(j)%>');
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	<%
		txtbox_count++;
		}
		array=null;
	%>
	
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write("<B> &nbsp; &nbsp;  MSME Enterprises  </B>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> "); 
	<%
		calculatedbox_count++;
	%>
	
	<%
		array=new ArrayList();
		array.add("Direct");
		array.add("Indirect");
		for(j=0;j<array.size();j++)
		{
	%>
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write(" &nbsp; &nbsp; &nbsp; &nbsp;"+'<%=array.get(j)%>');
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	<%
		txtbox_count++;
		}
		array=null;
	%>
	
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write("<B> &nbsp; &nbsp;  MSME Manufacturing </B>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> "); 
	<%
		calculatedbox_count++;
	%>
	
	<%
		array=new ArrayList();
		array.add("Micro");
		array.add("Small");
		array.add("Medium");
		for(j=0;j<array.size();j++)
		{
	%>
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write(" &nbsp; &nbsp; &nbsp; &nbsp;"+'<%=array.get(j)%>');
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	<%
		txtbox_count++;
		}
		array=null;
	%>
	
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write("<B>MSME Services </B>");
	win.document.write("</td>");
	win.document.write("<td colspan='6'>  ");
	win.document.write("<div align='right'>&nbsp;</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write("<B> &nbsp; &nbsp;  Micro  </B>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> "); 
	<%
		calculatedbox_count++;
	%>
	
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write("<B> &nbsp; &nbsp; &nbsp; &nbsp; W/W  </B></div>");
	win.document.write("</td>");
	win.document.write("<td colspan='6'>  ");
	win.document.write("<div align='right'>&nbsp;</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	
	<%
		array=new ArrayList();
		array.add("Road Transport Operator");
		array.add("Small Business");
		array.add("Retail Trade");
		array.add("Prof. & Self Employees");
		array.add("Others");
		for(j=0;j<array.size();j++)
		{
	%>
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write(" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"+'<%=array.get(j)%>');
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	<%
		txtbox_count++;
		}
		array=null;
	%>
	
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write("<B> &nbsp; &nbsp;  Small  </B>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> "); 
	<%
		calculatedbox_count++;
	%>
	
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write("<B> &nbsp; &nbsp; &nbsp; &nbsp; W/W  </B>");
	win.document.write("</td>");
	win.document.write("<td colspan='6'>  ");
	win.document.write("<div align='right'>&nbsp;</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	
	<%
		array=new ArrayList();
		array.add("Road Transport Operator");
		array.add("Small Business");
		array.add("Retail Trade");
		array.add("Prof. & Self Employees");
		array.add("Others");
		for(j=0;j<array.size();j++)
		{
	%>
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write(" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"+'<%=array.get(j)%>');
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	<%
		txtbox_count++;
		}
		array=null;
	%>
	
	
	<%
		array=new ArrayList();
		array.add("Khadi & Village Industries ");
		array.add("Medium ");
		array.add("Indirect ");
		array.add("NBFC (Manufacturing & Service) ");
		for(j=0;j<array.size();j++)
		{
	%>
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write(" <B>&nbsp; &nbsp; &nbsp; &nbsp;"+'<%=array.get(j)%>' + "</B>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	<%
		txtbox_count++;
		}
		array=null;
	%>
	
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write("<B> &nbsp; &nbsp; &nbsp; &nbsp; Total Indirect MSME  </B>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> "); 
	<%
		calculatedbox_count++;
	%>
	
	<%
		array=new ArrayList();
		array.add("Micro Credit");
		array.add("SCS/STS State Sponsored Organisations");
		for(j=0;j<array.size();j++)
		{
	%>
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write(" <B>&nbsp; &nbsp; &nbsp; &nbsp;"+'<%=array.get(j)%>' + "</B>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	<%
		txtbox_count++;
		}
		array=null;
	%>
	
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write("<B> &nbsp; &nbsp;  Union Education   </B>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> "); 
	<%
		calculatedbox_count++;
	%>
	
	<%
		array=new ArrayList();
		array.add("Rural & Semi-Urban Areas");
		array.add("Urban Areas");
		for(j=0;j<array.size();j++)
		{
	%>
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write(" &nbsp; &nbsp; &nbsp; &nbsp;"+'<%=array.get(j)%>');
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	<%
		txtbox_count++;
		}
		array=null;
	%>
	
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write("<B> &nbsp; &nbsp;  Union Home   </B>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> "); 
	<%
		calculatedbox_count++;
	%>
	
	<%
		array=new ArrayList();
		array.add("Rural & Semi-Urban Areas");
		array.add("Urban Areas");
		for(j=0;j<array.size();j++)
		{
	%>
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write(" &nbsp; &nbsp; &nbsp; &nbsp;"+'<%=array.get(j)%>');
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	<%
		txtbox_count++;
		}
		array=null;
	%>	
	
	<%
		array=new ArrayList();
		array.add("Union Trade");
		for(j=0;j<array.size();j++)
		{
	%>
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write(" <B>&nbsp; &nbsp;"+'<%=array.get(j)%>' + "</B>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	<%
		txtbox_count++;
		}
		array=null;
	%>	
	
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write("<B> &nbsp; &nbsp;Total Of Priority Sector</B>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> "); 
	<%
		calculatedbox_count++;
	%>
	
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write("<B> &nbsp; &nbsp; Retail Lending</B>");
	win.document.write("</td>");
	win.document.write("<td colspan='6'>  ");
	win.document.write("<div align='right'>&nbsp;</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	
	<%
		array=new ArrayList();
		array.add("Union Education");
		array.add("Union Home");
		for(j=0;j<array.size();j++)
		{
	%>
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write(" &nbsp; &nbsp; &nbsp; &nbsp;"+'<%=array.get(j)%>');
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	<%
		txtbox_count++;
		}
		array=null;
	%>	
	
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write(" &nbsp; &nbsp; &nbsp; &nbsp; Union Comfort");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> "); 
	<%
		calculatedbox_count++;
	%>
	
	<%
		array=new ArrayList();
		array.add("i) Clean ");
		array.add("ii) Secured ");
		for(j=0;j<array.size();j++)
		{
	%>
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write(" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"+'<%=array.get(j)%>');
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	<%
		txtbox_count++;
		}
		array=null;
	%>
	
	<%
		array=new ArrayList();
		array.add("Union Miles");
		array.add("Union Health");
		array.add("Union Smile");
		array.add("Union Cash");
		array.add("Union Mortgage");
		array.add("Union Shares");
		for(j=0;j<array.size();j++)
		{
	%>
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write(" &nbsp; &nbsp; &nbsp; &nbsp;"+'<%=array.get(j)%>');
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	<%
		txtbox_count++;
		}
		array=null;
	%>
	
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write("<B> &nbsp; &nbsp; GOVT. SPONSORED SCHEMES </B>");
	win.document.write("</td>");
	win.document.write("<td colspan='6'>  ");
	win.document.write("<div align='right'>&nbsp;</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	
	<%
		array=new ArrayList();
		array.add("P. M. R. Y.");
		array.add("P.M.E.G.P.");
		array.add("S.G.S.Y.");
		array.add("S.J.S.R.Y.");
		array.add("G.J.R.H.F.S.");
		array.add("S.L.R.S.");
		array.add("S.R.M.S.");
		array.add("U.L.U.C.C.");
		array.add("U.A.C.C.");
		array.add("S.C.C.");
		array.add("SCP / Scheme by SC/ST Corporation (Excluding SLRS)");
		array.add("S.A.C.P.");
		for(j=0;j<array.size();j++)
		{
	%>
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write(" &nbsp; &nbsp; &nbsp; &nbsp;"+'<%=array.get(j)%>');
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	<%
		txtbox_count++;
		}
		array=null;
	%>
	
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write("<B> &nbsp; &nbsp; WEAKER SECTION</B>");
	win.document.write("</td>");
	win.document.write("<td colspan='6'>  ");
	win.document.write("<div align='right'>&nbsp;</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	
	<%
		array=new ArrayList();
		array.add("Small & Marginal Farmers");
		array.add("Village & Cottage Industries");
		array.add("SGSY Beneficiaries");
		array.add("SC/ST Beneficiaries");
		array.add("DRI Beneficiaries");
		array.add("SJSRY Beneficiaries");
		array.add("SLRS / SRMS Beneficiaries");
		array.add("Self Help Groups");
		array.add("Loans to Distressed Poor");
		array.add("Minority Communities");
		array.add("Women Beneficiaries");
		for(j=0;j<array.size();j++)
		{
	%>
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write(" &nbsp; &nbsp; &nbsp; &nbsp;"+'<%=array.get(j)%>');
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	<%
		txtbox_count++;
		}
		array=null;
	%>
	
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write("<B> &nbsp; &nbsp; NPA</B>");
	win.document.write("</td>");
	win.document.write("<td colspan='6'>  ");
	win.document.write("<div align='right'>&nbsp;</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	
	<%
		array=new ArrayList();
		array.add("Op. Balance as on Beginning Of Period");
		array.add("Cash Recovery");
		array.add("Upgradation");
		array.add("Write off");
		array.add("Slippage");
		for(j=0;j<array.size();j++)
		{
	%>
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write(" &nbsp; &nbsp; &nbsp; &nbsp;"+'<%=array.get(j)%>');
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	<%
		txtbox_count++;
		}
		array=null;
	%>
	
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write(" <b>&nbsp; &nbsp; NPA as on End of Period</b>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount_calculated[<%=calculatedbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> "); 
	<%
		calculatedbox_count++;
	%>
	
	<%
		array=new ArrayList();
		array.add("Recovery in Written- off A/cs");
		array.add("Profit");
		array.add("Non Interest Income");
		array.add("Non Interest Expenditure");
		for(j=0;j<array.size();j++)
		{
	%>
	win.document.write("<tr> ");
	win.document.write("<td> ");
	win.document.write(" &nbsp; &nbsp; &nbsp; &nbsp;"+'<%=array.get(j)%>');
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_target_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_sanctioned_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_noofaccounts[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("<td> ");
	win.document.write("<div align='right'>"+ document.forms[0].txt_outstanding_amount[<%=txtbox_count%>].value + "</div>");
	win.document.write("</td>");
	win.document.write("</tr> ");
	<%
		txtbox_count++;
		}
		array=null;
	%>
	
	win.document.write("</table> ");
	   win.document.write("</div>"); 
	win.document.write("</td>");
	win.document.write("</tr> ");
	win.document.write("</table> ");
	win.document.write("</div>");
}

function validatefields()
{
	for(var i=0;i<3;i++)
	{
		document.forms[0].txt_sanctioned_noofaccounts[i].readOnly=false;
		document.forms[0].txt_sanctioned_amount[i].readOnly=false;
		document.forms[0].txt_outstanding_noofaccounts[i].readOnly=false;
		document.forms[0].txt_outstanding_amount[i].readOnly=false;
	}
	/* for(var i=5;i<7;i++)
	{
		document.forms[0].txt_sanctioned_noofaccounts[i].readOnly=false;
		document.forms[0].txt_sanctioned_amount[i].readOnly=false;
		// document.forms[0].txt_outstanding_noofaccounts[i].readOnly=false;
		// document.forms[0].txt_outstanding_amount[i].readOnly=false;
	} */
	for(var i=9;i<10;i++)
	{
		// document.forms[0].txt_sanctioned_noofaccounts[i].readOnly=false;
		// document.forms[0].txt_sanctioned_amount[i].readOnly=false;
		document.forms[0].txt_outstanding_noofaccounts[i].readOnly=false;
		document.forms[0].txt_outstanding_amount[i].readOnly=false;
	}
	for(var i=20;i<21;i++)
	{
		document.forms[0].txt_sanctioned_noofaccounts[i].readOnly=false;
		document.forms[0].txt_sanctioned_amount[i].readOnly=false;
		// document.forms[0].txt_outstanding_noofaccounts[i].readOnly=false;
		// document.forms[0].txt_outstanding_amount[i].readOnly=false;
	}
	for(var i=21;i<22;i++)
	{
		document.forms[0].txt_sanctioned_noofaccounts[i].readOnly=false;
		document.forms[0].txt_sanctioned_amount[i].readOnly=false;
		document.forms[0].txt_outstanding_noofaccounts[i].readOnly=false;
		document.forms[0].txt_outstanding_amount[i].readOnly=false;
	}
	for(var i=22;i<26;i++)
	{
		document.forms[0].txt_sanctioned_noofaccounts[i].readOnly=false;
		document.forms[0].txt_sanctioned_amount[i].readOnly=false;
		// document.forms[0].txt_outstanding_noofaccounts[i].readOnly=false;
		// document.forms[0].txt_outstanding_amount[i].readOnly=false;
	}
	for(var i=53;i<64;i++)
	{
		document.forms[0].txt_sanctioned_noofaccounts[i].readOnly=false;
		document.forms[0].txt_sanctioned_amount[i].readOnly=false;
		// document.forms[0].txt_outstanding_noofaccounts[i].readOnly=false;
		// document.forms[0].txt_outstanding_amount[i].readOnly=false;
	}
	for(var i=64;i<document.forms[0].txt_target_noofaccounts.length;i++)
	{
		document.forms[0].txt_sanctioned_noofaccounts[i].readOnly=false;
		document.forms[0].txt_sanctioned_amount[i].readOnly=false;
		document.forms[0].txt_outstanding_noofaccounts[i].readOnly=false;
		document.forms[0].txt_outstanding_amount[i].readOnly=false;
	}
	for(var i=0;i<document.forms[0].txt_target_noofaccounts.length;i++)
	{
		document.forms[0].txt_target_noofaccounts[i].readOnly=false;
		document.forms[0].txt_target_amount[i].readOnly=false;
	}
	setTextBoxColor();
}

function setTextBoxColor()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			if(document.forms[0].elements[i].readOnly==true)
			{
				document.forms[0].elements[i].style.background='#F2F9FF';
			}
			else
			{
				document.forms[0].elements[i].style.background='#ffffff';
			}
		}
	} 
	// document.forms[0].txt_yearfrom.style.background='#ffffff';
}

function onloading()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=true;
		}
	}
	disableButtons(true,true,true,true,false);
	setTextBoxColor();
	display_branch_names();
	document.forms[0].sel_year.disabled=true;
	document.forms[0].sel_target.disabled=true;
	document.forms[0].sel_month.disabled=true;
}

function branch_selected()
{
	if( document.forms[0].sel_branch.value  !="0")
	{
		document.forms[0].sel_year.disabled=false;
	
		var selindex=document.forms[0].sel_branch[document.forms[0].sel_branch.selectedIndex].value;
		
		if(selindex !='') 
		{
			var varbranch=document.forms[0].sel_branch.value;
			varbranch = varbranch.split("-");
 			var branch_val = varbranch[1];
			document.all.ifrm2.src=appUrl+"action/iframebranchtarget.jsp?hidBeanGetMethod=getBranchTarget&hidBeanId=targetmaster&branch="+branch_val;
		}
		
	}
	else 
	{
		document.forms[0].sel_year.selectedIndex="0";
		document.forms[0].sel_year.disabled=true;
		document.forms[0].sel_target.selectedIndex="0";
		document.forms[0].sel_target.disabled=true;
		document.forms[0].sel_month.selectedIndex="0";
		document.forms[0].sel_month.disabled=true;
		document.forms[0].txt_yearfrom.value="";
		document.forms[0].txt_yearto.value="";
		document.forms[0].txt_yearfrom.readOnly=true;
		document.forms[0].txt_yearfrom.style.background='#DEDACF';
		
		/* document.forms[0].sel_branch.selectedIndex="0";
		document.forms[0].sel_target.selectedIndex="0";
		document.all.ifrm2.src=appUrl+"action/iframebranchtarget.jsp?hidBeanGetMethod=getBranchTarget&hidBeanId=targetmaster&branch="+"0";
		document.forms[0].sel_target.disabled=true;
		document.forms[0].sel_type.selectedIndex="0";
		document.forms[0].sel_type.disabled=true;
		document.forms[0].txt_yearfrom.value="";
		document.forms[0].txt_yearfrom.readOnly=true; */
	}
}

function year_selected()
{
	if(document.forms[0].sel_year.value=="0")
	{	
		document.forms[0].sel_target.selectedIndex="0";
		document.forms[0].sel_target.disabled=true;
		document.forms[0].sel_month.selectedIndex="0";
		document.forms[0].sel_month.disabled=true;
		document.forms[0].txt_yearfrom.value="";
		document.forms[0].txt_yearto.value="";
		document.forms[0].txt_yearfrom.readOnly=true;
		document.forms[0].txt_yearfrom.style.background='#DEDACF';
	}	
	else if(document.forms[0].sel_year.value=="new")
	{
		document.forms[0].txt_yearfrom.value="";
		document.forms[0].txt_yearto.value="";
		document.forms[0].txt_yearfrom.readOnly=false;
		document.forms[0].txt_yearfrom.style.background='#ffffff';
		document.forms[0].sel_target.disabled=true;
		document.forms[0].sel_target.value="0";
		document.forms[0].sel_month.selectedIndex="0";
		document.forms[0].sel_month.disabled=true;
	}
	else
	{
		document.forms[0].txt_yearfrom.value=document.forms[0].sel_year.value;
		document.forms[0].txt_yearto.value=eval(document.forms[0].sel_year.value)+1;
		document.forms[0].txt_yearfrom.readOnly=true;
		document.forms[0].txt_yearfrom.style.background='#DEDACF';
		document.forms[0].sel_target.disabled=false;
		call_iframe_target();
		
	}
}

function set_yearto()
{
	if(document.forms[0].txt_yearfrom.readOnly==false)
	{
		if(eval(document.forms[0].txt_yearfrom.value)+eval(1)!=document.forms[0].txt_yearto.value)
		{
			document.forms[0].sel_target.disabled=true;
			document.forms[0].sel_target.value="0";
			document.forms[0].sel_month.disabled=true;
			document.forms[0].sel_month.value="0";
			if(document.forms[0].txt_yearfrom.value.length==0)
			{
				alert("Financial year cannot be left empty");
				document.forms[0].txt_yearto.value="";
				return;
			}
			else if(document.forms[0].txt_yearfrom.value.length!=4)
			{
				alert("Financial year should be in 4 digits");
				document.forms[0].txt_yearfrom.value="";
				document.forms[0].txt_yearto.value="";
				return;
			}
			
			if(document.forms[0].sel_year.selectedIndex==1)
			{
				for(var i=0;i<document.forms[0].sel_year.length;i++)
				{
					var opt = document.forms[0].sel_year[i].value;
					if(opt != "" && opt != "0")
					{
						var type = opt.split("-");
						var fin="";
						fin = type[0];
						if(fin != "")
						{
							if(fin == document.forms[0].txt_yearfrom.value)
							{
								document.forms[0].txt_yearfrom.value="";
								document.forms[0].txt_yearto.value="";
								alert("Target is already defined");
								return;
							}
						}
					}
				}
	
			}
			
			document.forms[0].txt_yearto.value=eval(document.forms[0].txt_yearfrom.value)+eval(1);
			document.forms[0].sel_target.disabled=false;
			call_iframe_target();
		}
	}
}

function call_iframe_target()
{
	
	var varbranch=document.forms[0].sel_branch.value;
	varbranch = varbranch.split("-");
	var branch_val = varbranch[1];
	document.all.ifrm1.src=appUrl+"action/iframetargetbranchsearch.jsp?hidBeanGetMethod=getBranchTarget&hidBeanId=targetmaster&branch="+branch_val;
}
function target_selected()
{	
	var max_date=new Array("31","28","31","30","31","30","31","31","30","31","30","31");
	if(document.forms[0].sel_target.value=="0")
	{
		document.forms[0].sel_month.value="0";
		document.forms[0].sel_month.disabled=true;
		//onNew();
		disableButtons(true,true,true,true,false);
	}	
	else if(document.forms[0].sel_target.value=="new")
	{
		document.forms[0].sel_month.disabled=false;
		//onNew();
		disableButtons(true,false,false,true,true);
	}
	
	else
	{
		//validatefields();
		document.forms[0].sel_branch.disabled=true;
		document.forms[0].sel_year.disabled=true;
		document.forms[0].txt_yearfrom.readOnly=true;
		document.forms[0].txt_yearfrom.style.background='#F2F9FF';
		//document.forms[0].sel_target.disabled=true;
		document.forms[0].sel_month.disabled=true;
		disableButtons(false,true,true,true,false);
		document.forms[0].txt_periodfrom.value="01/";
		if(document.forms[0].sel_target.value==2)// for february
		{
			if(eval(document.forms[0].txt_yearto.value)%4==0)
			{
				document.forms[0].txt_periodto.value="29/";
			}
			else
			{
				document.forms[0].txt_periodto.value="28/";
			}
		}
		else
		{
			document.forms[0].txt_periodto.value=max_date[eval(document.forms[0].sel_target.value)-1]+"/";
		}
		if(document.forms[0].sel_target.value.length==1)
		{
			document.forms[0].txt_periodfrom.value=document.forms[0].txt_periodfrom.value+"0"+document.forms[0].sel_target.value+"/";
			document.forms[0].txt_periodto.value=document.forms[0].txt_periodto.value+"0"+document.forms[0].sel_target.value+"/";
		}
		else
		{
			document.forms[0].txt_periodfrom.value=document.forms[0].txt_periodfrom.value+document.forms[0].sel_target.value+"/";
			document.forms[0].txt_periodto.value=document.forms[0].txt_periodto.value+document.forms[0].sel_target.value+"/";
		}
		if(document.forms[0].sel_target.value<=3)
		{
			document.forms[0].txt_periodfrom.value=document.forms[0].txt_periodfrom.value+document.forms[0].txt_yearto.value;
			document.forms[0].txt_periodto.value=document.forms[0].txt_periodto.value+document.forms[0].txt_yearto.value;
		}
		else
		{
			document.forms[0].txt_periodfrom.value=document.forms[0].txt_periodfrom.value+document.forms[0].txt_yearfrom.value;
			document.forms[0].txt_periodto.value=document.forms[0].txt_periodto.value+document.forms[0].txt_yearfrom.value;
		}
		
	}
	
	
	
	/* selindex=document.forms[0].sel_target[document.forms[0].sel_target.selectedIndex].value;	
	if(selindex=='')
	{
		for(var i=0;i<document.forms[0].txt_target_noofaccounts.length;i++)
		{
			document.forms[0].txt_target_noofaccounts[i].value="";
			document.forms[0].txt_target_amount[i].value="";
			
			document.forms[0].txt_sanctioned_noofaccounts[i].value="";
			document.forms[0].txt_sanctioned_amount[i].value="";
			
			document.forms[0].txt_outstanding_noofaccounts[i].value="";
			document.forms[0].txt_outstanding_amount[i].value="";
		}
		for(var i=0;i<document.forms[0].txt_target_noofaccounts_calculated.length;i++)
	{
		document.forms[0].txt_target_noofaccounts_calculated[i].value="";
		document.forms[0].txt_target_amount_calculated[i].value="";
		
		document.forms[0].txt_sanctioned_noofaccounts_calculated[i].value="";
		document.forms[0].txt_sanctioned_amount_calculated[i].value="";
		
		document.forms[0].txt_outstanding_noofaccounts_calculated[i].value="";
		document.forms[0].txt_outstanding_amount_calculated[i].value="";
	}
		
		disableButtons(true,true,true,true,false);
		document.forms[0].sel_branch.disabled=false;
		document.forms[0].sel_type.selectedIndex="0";
		document.forms[0].sel_type.disabled=false;
		document.forms[0].txt_yearfrom.value="";
		document.forms[0].txt_yearfrom.readOnly=false;
		document.forms[0].txt_yearto.value="";
		document.forms[0].txt_periodfrom.value="";
		document.forms[0].txt_periodto.value="";
		
		
	}
	else if(selindex==0)
	{
		document.forms[0].sel_type.selectedIndex="0";
		document.forms[0].sel_type.disabled=false;
		document.forms[0].txt_yearfrom.value="";
		document.forms[0].txt_yearto.value="";
		document.forms[0].txt_yearfrom.readOnly=false;
		document.forms[0].txt_periodfrom.value="";
		document.forms[0].txt_periodto.value="";
		
		onNew();
	}
	else
	{
		disableButtons(false,true,true,true,false);
		var peroid = selindex.split(":");
		
		if(peroid[0]=="y")
		{
			var year=peroid[1].split("-");
			document.forms[0].sel_type.selectedIndex="1";
			document.forms[0].txt_yearfrom.value=year[0];
			document.forms[0].txt_yearto.value=year[1];
			document.forms[0].txt_periodfrom.value="01/04/"+year[0];
			document.forms[0].txt_periodto.value="31/03/"+year[1];
			document.forms[0].cmdedit.disabled=false;
			
		}
		if(peroid[0]=="qi")
		{
			var year=peroid[1].split("-");
			document.forms[0].sel_type.selectedIndex="2";
			document.forms[0].txt_yearfrom.value=year[0];
			document.forms[0].txt_yearto.value=year[1];
			document.forms[0].txt_periodfrom.value="01/04/"+year[0];
			document.forms[0].txt_periodto.value="30/06/"+year[0];
			document.forms[0].cmdedit.disabled=false;
			
		}
		if(peroid[0]=="qii")
		{
			var year=peroid[1].split("-");
			document.forms[0].sel_type.selectedIndex="3";
			document.forms[0].txt_yearfrom.value=year[0];
			document.forms[0].txt_yearto.value=year[1];
			document.forms[0].txt_periodfrom.value="01/07/"+year[0];
			document.forms[0].txt_periodto.value="30/09/"+year[0];
			document.forms[0].cmdedit.disabled=false;
			
		}
		if(peroid[0]=="qiii")
		{
			var year=peroid[1].split("-");
			document.forms[0].sel_type.selectedIndex="4";
			document.forms[0].txt_yearfrom.value=year[0];
			document.forms[0].txt_yearto.value=year[1];
			document.forms[0].txt_periodfrom.value="01/10/"+year[0];
			document.forms[0].txt_periodto.value="31/12/"+year[0];
			document.forms[0].cmdedit.disabled=false;
			
		}
		if(peroid[0]=="qiv")
		{
			var year=peroid[1].split("-");
			document.forms[0].sel_type.selectedIndex="5";
			document.forms[0].txt_yearfrom.value=year[0];
			document.forms[0].txt_yearto.value=year[1];
			document.forms[0].txt_periodfrom.value="01/01/"+year[1];
			document.forms[0].txt_periodto.value="31/03/"+year[1];
			document.forms[0].cmdedit.disabled=false;
			
		}
		year_selected();
		
		var varbranch=document.forms[0].sel_branch.value;
		varbranch = varbranch.split("-");
		var branch_val = varbranch[1];
		periodfrom=document.forms[0].txt_periodfrom.value;
		periodto=document.forms[0].txt_periodto.value;
		
		//document.all.ifrm1.src=appUrl+"action/iframetargetmastersearch.jsp?hidBeanGetMethod=getTargetMasterData&hidBeanId=targetmaster&branch="+branch_val+"&fromdate="+periodfrom+"&todate="+periodto; 
		
 		if(document.forms[0].sel_type.value=="1")
 		{
 			
 			document.all.ifrm1.src=appUrl+"action/iframetargetmastersearch.jsp?hidBeanGetMethod=getTargetMasterData&hidBeanId=targetmaster&branch="+branch_val+"&fromdate="+periodfrom+"&todate="+periodto; 
 		}
 		else if(document.forms[0].sel_type.value=="2" || document.forms[0].sel_type.value=="3"  || document.forms[0].sel_type.value=="4" || document.forms[0].sel_type.value=="5")
 		{
 			
 			document.all.ifrm1.src=appUrl+"action/iframetargetbranchsearch.jsp?hidBeanGetMethod=getTargetBranchMasterData&hidBeanId=targetmaster&branch="+branch_val+"&fromdate="+periodfrom+"&todate="+periodto; 
 		}
	} */
	if(document.forms[0].sel_target.value != "0" && document.forms[0].sel_target.value != "new" )
	{
		var varbranch=document.forms[0].sel_branch.value;
		varbranch = varbranch.split("-");
		var branch_val = varbranch[1];
		periodfrom=document.forms[0].txt_periodfrom.value;
		periodto=document.forms[0].txt_periodto.value;
		document.all.ifrm1.src=appUrl+"action/iframetargetmastersearch.jsp?hidBeanGetMethod=getTargetMasterData&hidBeanId=targetmaster&branch="+branch_val+"&fromdate="+periodfrom+"&todate="+periodto; 
	}
}

function month_selected()
{
	var max_date=new Array("31","28","31","30","31","30","31","31","30","31","30","31");
	if(document.forms[0].sel_month.value!="0")
	{
		validatefields();
		document.forms[0].sel_branch.disabled=true;
		document.forms[0].sel_year.disabled=true;
		document.forms[0].txt_yearfrom.readOnly=true;
		document.forms[0].txt_yearfrom.style.background='#F2F9FF';
		document.forms[0].sel_target.disabled=true;
		document.forms[0].sel_month.disabled=true;
		disableButtons(true,false,false,true,true);
		document.forms[0].txt_periodfrom.value="01/";
		if(document.forms[0].sel_target.value==2)// for february
		{
			if(eval(document.forms[0].txt_yearto.value)%4==0)
			{
				document.forms[0].txt_periodto.value="29/";
			}
			else
			{
				document.forms[0].txt_periodto.value="28/";
			}
		}
		else
		{
			document.forms[0].txt_periodto.value=max_date[eval(document.forms[0].sel_month.value)-1]+"/";
		}
		if(document.forms[0].sel_month.value.length==1)
		{
			document.forms[0].txt_periodfrom.value=document.forms[0].txt_periodfrom.value+"0"+document.forms[0].sel_month.value+"/";
			document.forms[0].txt_periodto.value=document.forms[0].txt_periodto.value+"0"+document.forms[0].sel_month.value+"/";
		}
		else
		{
			document.forms[0].txt_periodfrom.value=document.forms[0].txt_periodfrom.value+document.forms[0].sel_month.value+"/";
			document.forms[0].txt_periodto.value=document.forms[0].txt_periodto.value+document.forms[0].sel_month.value+"/";
		}
		if(document.forms[0].sel_month.value<=3)
		{
			document.forms[0].txt_periodfrom.value=document.forms[0].txt_periodfrom.value+document.forms[0].txt_yearto.value;
			document.forms[0].txt_periodto.value=document.forms[0].txt_periodto.value+document.forms[0].txt_yearto.value;
		}
		else
		{
			document.forms[0].txt_periodfrom.value=document.forms[0].txt_periodfrom.value+document.forms[0].txt_yearfrom.value;
			document.forms[0].txt_periodto.value=document.forms[0].txt_periodto.value+document.forms[0].txt_yearfrom.value;
		}
		settabindex();
	}
}

</script>
</head>

<body onload="onloading()">
<form name="targetform" method="post" class="normal">
<iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
<iframe  height="0" width="0" id="ifrm1" frameborder=0 style="border:0" ></iframe> 
<iframe  height="0" width="0" id="ifrm2" frameborder=0 style="border:0" ></iframe> 
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
      <tr> 
        <td class="page_flow">Home -&gt; Master -&gt; Target 
          Master -&gt; Target Data</td>
      </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
		<tr>
			<td>
				<jsp:include page="../set/mastertab.jsp" flush="true">
				<jsp:param name="tabid" value="10" />
				</jsp:include>
			</td>
		</tr>
	</table>
	<table width="100%" class="outertable">
	<tr>
	<td>
    <table width="35%" border="0" cellspacing="1" cellpadding="3" class="outertable">
    
				<tr> 
					<td width="50%" align="center" class="sub_tab_active" nowrap>
						<b>
							Target Data</b>
					</td>
       				<td width="50%" class="sub_tab_inactive" align="center" nowrap>
      					<b>
      						<a class="navigationLinks" href="JavaScript:gotoTab('','','targetreport.jsp')">
      						Target Report</a>
      					</b>
      				</td>
      				
       			</tr>
     </table>
     </td>
     </tr>
     </table>
     
  	
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" >
    <tr>
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
		
		
		 <tr>
		  	<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="2"  class="outertable linebor">
					<tr>
						<td align="center" width="24%">
              				Branch
            			</td>
						<td align="center" width="19%">
							Select Financial Year
               			</td>
               			<td align="center" width="19%">
               				Financial Year
               			</td>
            			<td align="center" width="19%">
            				Select Existing Target
             			</td>
            			<td align="center" width="19%">
            				Select Month
             			</td>
   					</tr>
						
					<tr>
						<td colspan="5">
							&nbsp;
						</td>
					</tr>
					         
			         <tr>
						<td align="center" >
			           				<select name="sel_branch" onchange="branch_selected()">
			           					<option value="0">--Select--</option>
			           				</select>
			         			</td>
			         			
						<td align="center" >
							<select name="sel_year" onChange="year_selected()">
			             			<option value="0">--Select--</option>
			             			<option value="new" >--New--</option>
			            			</select>
			               		</td>
			               		
			         			<td align="center" >
			         				<input type="text" style="text-align:center" name="txt_yearfrom" size="4" maxlength="4" onBlur="set_yearto()" onKeyPress="allowInteger(this)"> 
			          				&nbsp; - &nbsp;
			          				<input type="text"  readOnly style="text-align:center" name="txt_yearto" size="4" maxlength="4" style="text-align:center;color:'#000000';border:0">
			          			 	
			         			</td>
			         			
			         			<td align="center"> 
			                       <select name="sel_target" onChange="target_selected()" >
			                        	<option value="0" selected>----Select----</option>
			                         <option value="new">----New----</option>
			                       </select>
			                     </td>
			                     
			                     <td align="center"> 
			                       <select name="sel_month" onChange="month_selected()" >
			                        	<option value="0" selected>----Select----</option>
			                       </select>
			                     </td>
			            			     
			           		</tr>
						  </table>
          </td>
          </tr>
						  <tr>
						  	<td align="center">
								<table width="35%" border="0" cellspacing="0" cellpadding="2"  class="outertable linebor">
									<tr>
										<td align="center" width="50%">
				              			Period From
				            			</td>
										<td align="center" width="50%">
											Period To
				               			</td>
				              		</tr>
								</table>
							</td>
				          </tr>
          
		  <tr>
		  	<td align="center">
				<table width="35%" border="0" cellspacing="0" cellpadding="2"  class="outertable  linebor">
					<tr>
						<td align="center" width="50%">
              			<input type="text" style="text-align:center"  readOnly name="txt_periodfrom" size="13" onBlur="checkDate(this);checkmaxdate(this,document.forms[0].txt_periodto.value)">
             				&nbsp;
             				<!-- 
             				<a alt="Select date from calender"  href="javascript:callCalender('txt_periodfrom')"><img src ="<%=ApplicationParams.getAppUrl()%>img/calen.gif" width="0" height="22" border="0"></a>
             				 -->
            			</td>
						<td align="center" width="50%">
							<input type="text" style="text-align:center"  readOnly name="txt_periodto" size="13" onBlur="checkDate(this);checkmindate(this,document.forms[0].txt_periodfrom.value)">
             				&nbsp;
             				<!-- 
             				<a alt="Select date from calender"  href="javascript:callCalender('txt_periodto')"><img src ="<%=ApplicationParams.getAppUrl()%>img/calen.gif" width="0" height="22" border="0"></a>
             				-->
               			</td>
              		</tr>
				</table>
			</td>
          </tr>
          
          
          <tr>
          <td align="center">
          		<span class="mantatory"><b>All Amounts are in lakhs</b></span>
          </td>
          </tr>
          
		  <tr>
		  	<td>
				<table width="100%"border="0" cellspacing="0" cellpadding="2" class="outertable linebor">
		
					<tr>
						<td width="22%" rowspan="2">
							&nbsp;
						</td>
						<td width="26%" align="center" colspan="2">
							<input type="text" name="txt_label1" value="Target" style="text-align:center;color:'#000000';border:0;font-weight:bold;" readOnly>	
						</td>
						<td width="26%" align="center" colspan="2">
							<input type="text" name="txt_label2" value="Sanctioned" style="text-align:center;color:'#000000';border:0;font-weight:bold;" readOnly>	
						</td>
						<td width="26%" align="center" colspan="2">
							<input type="text" name="txt_label3" value="Outstanding" style="text-align:center;color:'#000000';border:0;font-weight:bold;" readOnly>		
						</td>
					</tr>
					
					<tr>
						<td width="13%" align="center" >
							<b>No of Accounts</b>
						</td>
						<td width="13%" align="center" >
							<b>Amount</b>
						</td>
						<td width="13%" align="center" >
							<b>No of Accounts</b>
						</td>
						<td width="13%" align="center" >
							<b>Amount</b>
						</td>
						<td width="13%" align="center" >
							<b>No of Accounts</b>
						</td>
						<td width="13%" align="center" >
							<B>Amount</B>
						</td>
					</tr>
					
					<tr>
						<td width="22%">
							Total Deposits
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  name="txt_target_noofaccounts" onKeyPress="allowInteger(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  name="txt_target_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_sanctioned_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_sanctioned_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_outstanding_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_outstanding_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
					</tr>
					
					<tr>
						<td width="22%">
							Gross Advances
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  name="txt_target_noofaccounts" onKeyPress="allowInteger(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  name="txt_target_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_sanctioned_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_sanctioned_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_outstanding_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_outstanding_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
					</tr>
					
					<tr>
						<td width="22%">
							Export Advances
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  name="txt_target_noofaccounts" onKeyPress="allowInteger(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  name="txt_target_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_sanctioned_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_sanctioned_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_outstanding_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_outstanding_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
					</tr>
					
					<tr>
						<td width="22%">
							<b>Priority Sector Advances</b>
						</td>
						<td colspan="6">
							&nbsp;
						</td>
					</tr>
					
					<tr>
						<td width="22%">
							<b title="   = Direct + Indirect"> &nbsp; &nbsp; Agriculture</b>
						</td>
						<td align="center">
							<input type="text" name="txt_target_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0;" readOnly>
						</td>
						<td align="center"> 
							<input type="text" name="txt_target_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_sanctioned_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_sanctioned_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_outstanding_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_outstanding_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
					</tr>
					
					<tr>
						<td width="22%">
							&nbsp; &nbsp; &nbsp; &nbsp; Direct
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  name="txt_target_noofaccounts" onKeyPress="allowInteger(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  name="txt_target_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_sanctioned_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_sanctioned_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_outstanding_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_outstanding_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
					</tr>
					
					<tr>
						<td width="22%">
							&nbsp; &nbsp; &nbsp; &nbsp; Indirect
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  name="txt_target_noofaccounts" onKeyPress="allowInteger(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  name="txt_target_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_sanctioned_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_sanctioned_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_outstanding_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_outstanding_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
					</tr>
					
					<tr>
						<td width="22%">
							<b title="   = Direct + Indirect" > &nbsp; &nbsp; MSME Enterprises</b>
						</td>
						<td align="center">
							<input type="text" name="txt_target_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center"> 
							<input type="text" name="txt_target_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_sanctioned_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_sanctioned_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_outstanding_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_outstanding_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
					</tr>
					
					<tr>
						<td width="22%">
							&nbsp; &nbsp; &nbsp; &nbsp; Direct
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  name="txt_target_noofaccounts" onKeyPress="allowInteger(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  name="txt_target_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_sanctioned_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_sanctioned_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_outstanding_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_outstanding_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
					</tr>
					
					<tr>
						<td width="22%">
							&nbsp; &nbsp; &nbsp; &nbsp; Indirect
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  name="txt_target_noofaccounts" onKeyPress="allowInteger(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  name="txt_target_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_sanctioned_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_sanctioned_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_outstanding_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_outstanding_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
					</tr>
					
					<tr>
						<td width="22%">
							<b title="   = Micro + Small + Medium"> &nbsp; &nbsp; MSME Manufacturing</b>
						</td>
						<td align="center">
							<input type="text" name="txt_target_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0;" readOnly>
						</td>
						<td align="center"> 
							<input type="text" name="txt_target_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_sanctioned_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_sanctioned_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_outstanding_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_outstanding_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
					</tr>
					
					<%
						int i=0;
						ArrayList arraydesc=new ArrayList(3);
						arraydesc.add("Micro");
						arraydesc.add("Small");
						arraydesc.add("Medium");
						for(i=0;i<arraydesc.size();i++)
						{
					%>
					<tr>
						<td width="22%">
							&nbsp; &nbsp; &nbsp; &nbsp; <%=arraydesc.get(i)%>
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  name="txt_target_noofaccounts" onKeyPress="allowInteger(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  name="txt_target_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_sanctioned_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_sanctioned_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_outstanding_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_outstanding_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
					</tr>
					<%
						}
						arraydesc=null;
					%>
					
					<tr>
						<td width="22%">
							<b > &nbsp; &nbsp; MSME Services</b>
						</td>
						<td colspan="6">
							&nbsp;
						</td>
					</tr>
					
					<tr>
						<td width="22%">
							<b title="   = Road Transport Operator + Small Business + Retail Trade + Prof. & Self Employees + Others "> &nbsp; &nbsp; Micro</b>
						</td>
						<td align="center">
							<input type="text" name="txt_target_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0;" readOnly>
						</td>
						<td align="center"> 
							<input type="text" name="txt_target_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_sanctioned_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_sanctioned_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_outstanding_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_outstanding_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
					</tr>
					
					<tr>
						<td width="22%">
							<b> &nbsp; &nbsp; W/W</b>
						</td>
						<td colspan="6">
							&nbsp;
						</td>
					</tr>
					
							
					
					
					
					<%
					arraydesc=new ArrayList(5);
					arraydesc.add("Road Transport Operator");
					arraydesc.add("Small Business");
					arraydesc.add("Retail Trade");
					arraydesc.add("Prof. & Self Employees");
					arraydesc.add("Others");
					for(i=0;i<arraydesc.size();i++)
					{
					%>
					<tr>
						<td width="22%">
							&nbsp; &nbsp; &nbsp; &nbsp; <%=arraydesc.get(i)%>
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  name="txt_target_noofaccounts" onKeyPress="allowInteger(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  name="txt_target_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_sanctioned_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_sanctioned_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_outstanding_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_outstanding_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
					</tr>
					<%
					}
					%>
					
					<tr>
						<td width="22%">
							<b title="   = Road Transport Operator + Small Business + Retail Trade + Prof. & Self Employees + Others "> &nbsp; &nbsp; Small</b>
						</td>
						<td align="center">
							<input type="text" name="txt_target_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0;" readOnly>
						</td>
						<td align="center"> 
							<input type="text" name="txt_target_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_sanctioned_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_sanctioned_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_outstanding_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_outstanding_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
					</tr>
					
					<tr>
						<td width="22%">
							<b> &nbsp; &nbsp; W/W</b>
						</td>
						<td colspan="6">
							&nbsp;
						</td>
					</tr>
					
					<%
					for(i=0;i<arraydesc.size();i++)
					{
					%>
					<tr>
						<td width="22%">
							&nbsp; &nbsp; &nbsp; &nbsp; <%=arraydesc.get(i)%>
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  name="txt_target_noofaccounts" onKeyPress="allowInteger(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  name="txt_target_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_sanctioned_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_sanctioned_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_outstanding_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_outstanding_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
					</tr>
					<%
					}
					arraydesc=null;
					%>
					
					
					<%
					arraydesc=new ArrayList();
					arraydesc.add("Khadi & Village Industries");
					arraydesc.add("Medium");
					arraydesc.add("Indirect");
					arraydesc.add("NBFC (Manufacturing & Service)");
					for(i=0;i<arraydesc.size();i++)
					{
					%>
					<tr>
						<td width="22%">
							<b>&nbsp; &nbsp;  <%=arraydesc.get(i)%></b>
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  name="txt_target_noofaccounts" onKeyPress="allowInteger(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  name="txt_target_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_sanctioned_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_sanctioned_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_outstanding_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_outstanding_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
					</tr>
					<%
					}
					%>
					
					<tr>
						<td width="22%">
							<b title="   = Indirect + NBFC (Manufacturing & Service)"> &nbsp; &nbsp; Total Indirect MSME</b>
						</td>
						<td align="center">
							<input type="text" name="txt_target_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0;" readOnly>
						</td>
						<td align="center"> 
							<input type="text" name="txt_target_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_sanctioned_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_sanctioned_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_outstanding_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_outstanding_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
					</tr>
					
					<%
					arraydesc=new ArrayList();
					arraydesc.add("Micro Credit");
					arraydesc.add("SCS/STS State Sponsored Organisations");
					for(i=0;i<arraydesc.size();i++)
					{
					%>
					<tr>
						<td width="22%">
							<b>&nbsp; &nbsp;  <%=arraydesc.get(i)%></b>
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  name="txt_target_noofaccounts" onKeyPress="allowInteger(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  name="txt_target_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_sanctioned_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_sanctioned_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_outstanding_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_outstanding_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
					</tr>
					<%
					}
					%>
					
					<tr>
						<td width="22%">
							<b title="    =  Rural & Semi-Urban Areas  + Urban Areas "> &nbsp; &nbsp;Union Education </b>
						</td>
						<td align="center">
							<input type="text" name="txt_target_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0;" readOnly>
						</td>
						<td align="center"> 
							<input type="text" name="txt_target_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_sanctioned_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_sanctioned_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_outstanding_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_outstanding_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
					</tr>
					
					<%
					arraydesc=new ArrayList(2);
					arraydesc.add("Rural & Semi-Urban Areas");
					arraydesc.add("Urban Areas");
					for(i=0;i<arraydesc.size();i++)
					{
					%>
					<tr>
						<td width="22%">
							&nbsp; &nbsp; &nbsp; &nbsp; <%=arraydesc.get(i)%>
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  name="txt_target_noofaccounts" onKeyPress="allowInteger(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  name="txt_target_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_sanctioned_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_sanctioned_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_outstanding_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_outstanding_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
					</tr>
					<%
					}
					%>
					
					<tr>
						<td width="22%">
							<b title="    =  Rural & Semi-Urban Areas  + Urban Areas ">  &nbsp; &nbsp;Union Home </b>
						</td>
						<td align="center">
							<input type="text" name="txt_target_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0;" readOnly>
						</td>
						<td align="center"> 
							<input type="text" name="txt_target_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_sanctioned_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_sanctioned_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_outstanding_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_outstanding_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
					</tr>
					
					<%
					arraydesc=new ArrayList(2);
					arraydesc.add("Rural & Semi-Urban Areas");
					arraydesc.add("Urban Areas");
					for(i=0;i<arraydesc.size();i++)
					{
					%>
					<tr>
						<td width="22%">
							&nbsp; &nbsp; &nbsp; &nbsp; <%=arraydesc.get(i)%>
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  name="txt_target_noofaccounts" onKeyPress="allowInteger(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  name="txt_target_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_sanctioned_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_sanctioned_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_outstanding_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_outstanding_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
					</tr>
					<%
					}
					%>
					
					<tr>
						<td width="22%">
							<b>&nbsp; &nbsp; Union Trade </b>
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  name="txt_target_noofaccounts" onKeyPress="allowInteger(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  name="txt_target_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_sanctioned_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_sanctioned_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_outstanding_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_outstanding_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
					</tr>
					
					<tr>
						<td width="22%">
							<b title="   = Agriculture + MSME Manufacturing(micro,small,medium)+ MSME Services(micro) + MSME Services(small) + khadi & village industries + medium + indirect + NBFC(Manufacturing & service) + Micro Credit+ SCS/STS State sponsored Organisations + Union education (Rural,semi-urban,urban)+ Union home (Rural,semi-urban,urban)+ Union Trade"> &nbsp; &nbsp;Total Of Priority Sector </b>
						</td>
						<td align="center">
							<input type="text" name="txt_target_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0;" readOnly >
						</td>
						<td align="center"> 
							<input type="text" name="txt_target_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_sanctioned_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_sanctioned_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_outstanding_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_outstanding_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
					</tr>
					
					<tr>
						<td width="22%">
							<b> &nbsp; &nbsp;Retail Lending </b>
						</td>
						<td colspan="6">
							&nbsp;
						</td>
					</tr>
					
					<%
					arraydesc=new ArrayList(2);
					arraydesc.add("Union Education");
					arraydesc.add("Union Home");
					for(i=0;i<arraydesc.size();i++)
					{
					%>
					<tr>
						<td width="22%">
							&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <%=arraydesc.get(i)%>
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  name="txt_target_noofaccounts" onKeyPress="allowInteger(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  name="txt_target_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_sanctioned_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_sanctioned_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_outstanding_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_outstanding_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
					</tr>
					<%
					}
					arraydesc=null;
					%>
					
					<tr>
						<td width="22%">
							<p title="   = Clean + Secured"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Union Comfort</p>
						</td>
						<td align="center">
							<input type="text" name="txt_target_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0;" readOnly>
						</td>
						<td align="center"> 
							<input type="text" name="txt_target_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_sanctioned_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_sanctioned_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_outstanding_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_outstanding_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
					</tr>
					
					<%
					arraydesc=new ArrayList(2);
					arraydesc.add("i) Clean");
					arraydesc.add("ii) Secured");
					for(i=0;i<arraydesc.size();i++)
					{
					%>
					<tr>
						<td width="22%">
							&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <%=arraydesc.get(i)%>
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  name="txt_target_noofaccounts" onKeyPress="allowInteger(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  name="txt_target_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_sanctioned_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_sanctioned_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_outstanding_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_outstanding_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
					</tr>
					<%
					}
					arraydesc=null;
					%>
					
					<%
					arraydesc=new ArrayList(6);
					arraydesc.add("Union Miles");
					arraydesc.add("Union Health");
					arraydesc.add("Union Smile");
					arraydesc.add("Union Cash");
					arraydesc.add("Union Mortgage");
					arraydesc.add("Union Shares");
					for(i=0;i<arraydesc.size();i++)
					{
					%>
					<tr>
						<td width="22%">
							 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <%=arraydesc.get(i)%>
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  name="txt_target_noofaccounts" onKeyPress="allowInteger(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  name="txt_target_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_sanctioned_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_sanctioned_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_outstanding_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_outstanding_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
					</tr>
					<%
					}
					arraydesc=null;
					%>
					
					<tr>
						<td width="22%" nowrap>
							<b>  &nbsp; &nbsp; GOVT. SPONSORED SCHEMES </b>
						</td>
						<td colspan="6">
							&nbsp;
						</td>
					</tr>
					
					<%
					arraydesc=new ArrayList(12);
					arraydesc.add("P. M. R. Y.");
					arraydesc.add("P.M.E.G.P.");
					arraydesc.add("S.G.S.Y.");
					arraydesc.add("S.J.S.R.Y.");
					arraydesc.add("G.J.R.H.F.S.");
					arraydesc.add("S.L.R.S.");
					arraydesc.add("S.R.M.S.");
					arraydesc.add("U.L.U.C.C.");
					arraydesc.add("U.A.C.C.");
					arraydesc.add("S.C.C.");
					arraydesc.add("SCP / Scheme by SC/ST Corporation (Excluding SLRS)");
					arraydesc.add("S.A.C.P.");
					for(i=0;i<arraydesc.size();i++)
					{
					%>
					<tr>
						<td width="22%">
							 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <%=arraydesc.get(i)%>
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  name="txt_target_noofaccounts" onKeyPress="allowInteger(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  name="txt_target_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_sanctioned_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_sanctioned_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_outstanding_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_outstanding_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
					</tr>
					<%
					}
					arraydesc=null;
					%>
					
					<tr>
						<td width="22%">
							<b>&nbsp; &nbsp; WEAKER SECTION </b>
						</td>
						<td colspan="6">
							&nbsp;
						</td>
					</tr>
					
					<%
					arraydesc=new ArrayList(11);
					arraydesc.add("Small & Marginal Farmers");
					arraydesc.add("Village & Cottage Industries");
					arraydesc.add("SGSY Beneficiaries");
					arraydesc.add("SC/ST Beneficiaries");
					arraydesc.add("DRI Beneficiaries");
					arraydesc.add("SJSRY Beneficiaries");
					arraydesc.add("SLRS / SRMS Beneficiaries");
					arraydesc.add("Self Help Groups");
					arraydesc.add("Loans to Distressed Poor");
					arraydesc.add("Minority Communities");
					arraydesc.add("Women Beneficiaries");
					for(i=0;i<arraydesc.size();i++)
					{
					%>
					<tr>
						<td width="22%">
							 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <%=arraydesc.get(i)%>
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  name="txt_target_noofaccounts" onKeyPress="allowInteger(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  name="txt_target_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_sanctioned_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_sanctioned_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_outstanding_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_outstanding_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
					</tr>
					<%
					}
					arraydesc=null;
					%>
					
					<tr>
						<td width="22%">
							<b>&nbsp; &nbsp; NPA </b>
						</td>
						<td colspan="6">
							&nbsp;
						</td>
					</tr>
					
					<tr>
						<td width="22%">
							<b>&nbsp; &nbsp; &nbsp; &nbsp; Op. Balance as on Beginning Of Period </b>
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  name="txt_target_noofaccounts" onKeyPress="allowInteger(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  name="txt_target_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_sanctioned_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_sanctioned_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_outstanding_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_outstanding_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
					</tr>
					
					<%
					arraydesc=new ArrayList(4);
					arraydesc.add("Cash Recovery");
					arraydesc.add("Upgradation");
					arraydesc.add("Write off");
					arraydesc.add("Slippage");
					for(i=0;i<arraydesc.size();i++)
					{
					%>
					<tr>
						<td width="22%">
							 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <%=arraydesc.get(i)%>
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  name="txt_target_noofaccounts" onKeyPress="allowInteger(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  name="txt_target_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_sanctioned_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_sanctioned_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_outstanding_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_outstanding_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
					</tr>
					<%
					}
					arraydesc=null;
					%>
					
					<tr>
						<td width="22%">
							<b title="   = Op. Balance as on Beginning Of Period - Cash Recovery - Upgradation  - Write off  + Slippage "> &nbsp; &nbsp; NPA as on End of Period </b>
						</td>
						<td align="center">
							<input type="text" name="txt_target_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0;" readOnly>
						</td>
						<td align="center"> 
							<input type="text" name="txt_target_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_sanctioned_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_sanctioned_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_outstanding_noofaccounts_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
						<td align="center">
							<input type="text" name="txt_outstanding_amount_calculated" style="text-align:right;color:'#000000';border:0" readOnly>
						</td>
					</tr>
					
					<%
					arraydesc=new ArrayList(4);
					arraydesc.add("Recovery in Written- off A/cs");
					arraydesc.add("Profit");
					arraydesc.add("Non Interest Income");
					arraydesc.add("Non Interest Expenditure");
					for(i=0;i<arraydesc.size();i++)
					{
					%>
					<tr>
						<td width="22%">
							 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <%=arraydesc.get(i)%>
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  name="txt_target_noofaccounts" onKeyPress="allowInteger(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  name="txt_target_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" >
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_sanctioned_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_sanctioned_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="10"  style="text-align:right"  readOnly name="txt_outstanding_noofaccounts" onKeyPress="allowInteger(this)">
						</td>
						<td width="13%" align="center" >
							<input type="text" maxlength="15"  style="text-align:right"  readOnly name="txt_outstanding_amount" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
						</td>
					</tr>
					<%
					}
					arraydesc=null;
					%>
			
					
				</table>
			</td>
		  </tr>
		 </table>
			</td>
		  </tr>
		  <tr>
		  	<td align="center">
			<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
      </td>
    </tr>
  </table>
    <input type="hidden" name="hidorg_code" value="<%=Helper.correctNull((String)hshValues.get("ORG_CODE"))%>">
 	<lapschoice:hiddentag pageid='<%=PageId%>'/> 
  <input type="hidden" name="hid_type">
</form>
</body>
</html>
