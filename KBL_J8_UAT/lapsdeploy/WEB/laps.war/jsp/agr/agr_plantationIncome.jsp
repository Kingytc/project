<%@include file = "../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%ArrayList arryCol= new ArrayList();
ArrayList arryRow = new ArrayList();
arryRow=(ArrayList)hshValues.get("arryRow");
if(arryRow == null)
{
	arryRow = new ArrayList();
}
			
%>	
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
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
}
function onLoading()
{
	for(var i=0;i<10;i++)
	{
	Rowtotal(i);
	}
	disableFields(true);
}
var type1="";
function doEdit()
{ 	
	var type1=document.forms[0].type1.value;
	disableFields(false);
	document.forms[0].hidAction.value ="U";
	disableCommandButtons("edit");	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		 var type1=document.forms[0].type1.value;
		 document.forms[0].hidBeanId.value="agrcrops";		
		document.forms[0].hidBeanGetMethod.value="getplantationExpenses";
		document.forms[0].action=appURL+"action/agr_plantationIncome.jsp";	
		document.forms[0].submit();

	}	
	
}
function doDelete()
{	
	if(varRecordFlag=="Y") {
	if(ConfirmMsg(101))
		
		{	
			var type1=document.forms[0].type1.value;
			document.forms[0].hidAction.value ="D";
			document.forms[0].hidSourceUrl.value="/action/agr_plantationIncome.jsp";
			document.forms[0].hidBeanId.value="agrcrops";
			document.forms[0].hidBeanMethod.value="insertPlantationExpenses";
			document.forms[0].hidBeanGetMethod.value="getplantationExpenses";
			document.forms[0].action=appURL +"controllerservlet";
			document.forms[0].submit(); 
		}}
	
}

function doSave()
	{
		var type1=document.forms[0].type1.value;
		var i=0;
		if(trimtxt(document.forms[0].item[0].value)=="")
		{
			ShowAlert(121,'Item of Development');
			document.forms[0].item[0].focus();
			return;
		}
		for(var i=0;i<10;i++)
		{	
		
		if(trimtxt(document.forms[0].item[i].value)=="")
			{
				if(trimtxt(document.forms[0].txt_year1[i].value)!="" && trimtxt(document.forms[0].txt_year1[i].value)!="0.00")
				{
				ShowAlert(121,'Item of Development');
				document.forms[0].item[i].focus();
				return;
				}
				if(trimtxt(document.forms[0].txt_year2[i].value)!="" && trimtxt(document.forms[0].txt_year2[i].value)!="0.00")
				{
				ShowAlert(121,'Item of Development');
				document.forms[0].item[i].focus();
				return;
				}
				if(trimtxt(document.forms[0].txt_year3[i].value)!="" && trimtxt(document.forms[0].txt_year3[i].value)!="0.00")
				{
				ShowAlert(121,'Item of Development');
				document.forms[0].item[i].focus();
				return;
				}
				if(trimtxt(document.forms[0].txt_year4[i].value)!="" && trimtxt(document.forms[0].txt_year4[i].value)!="0.00")
				{
				ShowAlert(121,'Item of Development');
				document.forms[0].item[i].focus();
				return;
				}
				if(trimtxt(document.forms[0].txt_year5[i].value)!="" && trimtxt(document.forms[0].txt_year5[i].value)!="0.00")
				{
				ShowAlert(121,'Item of Development');
				document.forms[0].item[i].focus();
				return;
				}
				if(trimtxt(document.forms[0].txt_year6[i].value)!="" && trimtxt(document.forms[0].txt_year6[i].value)!="0.00")
				{
				ShowAlert(121,'Item of Development');
				document.forms[0].item[i].focus();
				return;
				}
				if(trimtxt(document.forms[0].txt_year7[i].value)!="" && trimtxt(document.forms[0].txt_year7[i].value)!="0.00")
				{
				ShowAlert(121,'Item of Development');
				document.forms[0].item[i].focus();
				return;
				}
				if(trimtxt(document.forms[0].txt_year8[i].value)!="" && trimtxt(document.forms[0].txt_year8[i].value)!="0.00")
				{
				ShowAlert(121,'Item of Development');
				document.forms[0].item[i].focus();
				return;
				}
				if(trimtxt(document.forms[0].txt_year9[i].value)!="" && trimtxt(document.forms[0].txt_year9[i].value)!="0.00")
				{
				ShowAlert(121,'Item of Development');
				document.forms[0].item[i].focus();
				return;
				}
				if(trimtxt(document.forms[0].txt_year10[i].value)!="" && trimtxt(document.forms[0].txt_year10[i].value)!="0.00")
				{
				ShowAlert(121,'Item of Development');
				document.forms[0].item[i].focus();
				return;
				}
				if(trimtxt(document.forms[0].txt_year11[i].value)!="" && trimtxt(document.forms[0].txt_year11[i].value)!="0.00")
				{
				ShowAlert(121,'Item of Development');
				document.forms[0].item[i].focus();
				return;
				}
				if(trimtxt(document.forms[0].txt_year12[i].value)!="" && trimtxt(document.forms[0].txt_year12[i].value)!="0.00")
				{
				ShowAlert(121,'Item of Development');
				document.forms[0].item[i].focus();
				return;
				}
				if(trimtxt(document.forms[0].txt_year13[i].value)!="" && trimtxt(document.forms[0].txt_year13[i].value)!="0.00")
				{
				ShowAlert(121,'Item of Development');
				document.forms[0].item[i].focus();
				return;
				}
				if(trimtxt(document.forms[0].txt_year14[i].value)!="" && trimtxt(document.forms[0].txt_year14[i].value)!="0.00")
				{
				ShowAlert(121,'Item of Development');
				document.forms[0].item[i].focus();
				return;
				}
				if(trimtxt(document.forms[0].txt_year15[i].value)!="" && trimtxt(document.forms[0].txt_year15[i].value)!="0.00")
				{
				ShowAlert(121,'Item of Development');
				document.forms[0].item[i].focus();
				return;
				}
				if(trimtxt(document.forms[0].txt_year16[i].value)!="" && trimtxt(document.forms[0].txt_year16[i].value)!="0.00")
				{
				ShowAlert(121,'Item of Development');
				document.forms[0].item[i].focus();
				return;
				}
				if(trimtxt(document.forms[0].txt_year17[i].value)!="" && trimtxt(document.forms[0].txt_year17[i].value)!="0.00")
				{
				ShowAlert(121,'Item of Development');
				document.forms[0].item[i].focus();
				return;
				}
				if(trimtxt(document.forms[0].txt_year18[i].value)!="" && trimtxt(document.forms[0].txt_year18[i].value)!="0.00")
				{
				ShowAlert(121,'Item of Development');
				document.forms[0].item[i].focus();
				return;
				}
				if(trimtxt(document.forms[0].txt_year19[i].value)!="" && trimtxt(document.forms[0].txt_year19[i].value)!="0.00")
				{
				ShowAlert(121,'Item of Development');
				document.forms[0].item[i].focus();
				return;
				}
				if(trimtxt(document.forms[0].txt_year20[i].value)!="" && trimtxt(document.forms[0].txt_year20[i].value)!="0.00")
				{
				ShowAlert(121,'Item of Development');
				document.forms[0].item[i].focus();
				return;
				}
				if(trimtxt(document.forms[0].txt_year21[i].value)!="" && trimtxt(document.forms[0].txt_year21[i].value)!="0.00")
				{
				ShowAlert(121,'Item of Development');
				document.forms[0].item[i].focus();
				return;
				}
				if(trimtxt(document.forms[0].txt_year22[i].value)!="" && trimtxt(document.forms[0].txt_year22[i].value)!="0.00")
				{
				ShowAlert(121,'Item of Development');
				document.forms[0].item[i].focus();
				return;
				}
				if(trimtxt(document.forms[0].txt_year23[i].value)!="" && trimtxt(document.forms[0].txt_year23[i].value)!="0.00")
				{
				ShowAlert(121,'Item of Development');
				document.forms[0].item[i].focus();
				return;
				}
				if(trimtxt(document.forms[0].txt_year24[i].value)!="" && trimtxt(document.forms[0].txt_year24[i].value)!="0.00")
				{
				ShowAlert(121,'Item of Development');
				document.forms[0].item[i].focus();
				return;
				}
				if(trimtxt(document.forms[0].txt_year25[i].value)!="" && trimtxt(document.forms[0].txt_year25[i].value)!="0.00")
				{
				ShowAlert(121,'Item of Development');
				document.forms[0].item[i].focus();
				return;
				}
			}
			
		}
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidRecordflag.value=varRecordFlag;	
	document.forms[0].hidSourceUrl.value="/action/agr_plantationIncome.jsp";
	document.forms[0].hidBeanId.value="agrcrops";
	document.forms[0].hidBeanMethod.value="insertPlantationExpenses";
	document.forms[0].hidBeanGetMethod.value="getplantationExpenses";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{	
		if(document.forms[0].elements[i].type=='text')
	 	{
			
			if(document.forms[0].elements[i].name=='txt_total')
			{
				document.forms[0].elements[i].readOnly=true;
		
			}
			else
			{
			document.forms[0].elements[i].readOnly=val;	
			}
		}	
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}	
		
		
	}
	document.forms[0].txt_year1total.readOnly=true;
	document.forms[0].txt_year2total.readOnly=true;
	document.forms[0].txt_year3total.readOnly=true;
	document.forms[0].txt_year4total.readOnly=true;
	document.forms[0].txt_year5total.readOnly=true;
	document.forms[0].txt_year6total.readOnly=true;
	document.forms[0].txt_year7total.readOnly=true;
	document.forms[0].txt_year8total.readOnly=true;
	document.forms[0].txt_year9total.readOnly=true;
	document.forms[0].txt_year10total.readOnly=true;
	document.forms[0].txt_year11total.readOnly=true;
	document.forms[0].txt_year12total.readOnly=true;
	document.forms[0].txt_year13total.readOnly=true;
	document.forms[0].txt_year14total.readOnly=true;
	document.forms[0].txt_year15total.readOnly=true;
	document.forms[0].txt_year16total.readOnly=true;
	document.forms[0].txt_year17total.readOnly=true;
	document.forms[0].txt_year18total.readOnly=true;
	document.forms[0].txt_year19total.readOnly=true;
	document.forms[0].txt_year20total.readOnly=true;
	document.forms[0].txt_year21total.readOnly=true;
	document.forms[0].txt_year22total.readOnly=true;
	document.forms[0].txt_year23total.readOnly=true;
	document.forms[0].txt_year24total.readOnly=true;
	document.forms[0].txt_year25total.readOnly=true;
	
		
}

function callLink(page,bean,method)
		{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
		}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/"+"retailpge.jsp";				
		document.forms[0].submit();
	}
}
function Rowtotal(i)
{
var totalyear1=0.00;
var totalyear2=0.00;
var totalyear3=0.00;
var totalyear4=0.00;
var totalyear5=0.00;
var totalyear6=0.00;
var totalyear7=0.00;
var totalyear8=0.00;
var totalyear9=0.00;
var totalyear10=0.00;
var totalyear11=0.00;
var totalyear12=0.00;
var totalyear13=0.00;
var totalyear14=0.00;
var totalyear15=0.00;
var totalyear16=0.00;
var totalyear17=0.00;
var totalyear18=0.00;
var totalyear19=0.00;
var totalyear20=0.00;
var totalyear21=0.00;
var totalyear22=0.00;
var totalyear23=0.00;
var totalyear24=0.00;
var totalyear25=0.00;

var total=0.00;
var rowtotal=0.00;
	for(var i=0;i<10;i++)
	{
		var year1=document.forms[0].txt_year1[i].value;
		
		var year2=document.forms[0].txt_year2[i].value;
		var year3=document.forms[0].txt_year3[i].value;
		var year4=document.forms[0].txt_year4[i].value;
		var year5=document.forms[0].txt_year5[i].value;
		var year6=document.forms[0].txt_year6[i].value;
		var year7=document.forms[0].txt_year7[i].value;
		var year8=document.forms[0].txt_year8[i].value;
		var year9=document.forms[0].txt_year9[i].value;
		var year10=document.forms[0].txt_year10[i].value;
		var year11=document.forms[0].txt_year11[i].value;
		var year12=document.forms[0].txt_year12[i].value;
		var year13=document.forms[0].txt_year13[i].value;
		var year14=document.forms[0].txt_year14[i].value;
		var year15=document.forms[0].txt_year15[i].value;
		
		var year16=document.forms[0].txt_year16[i].value;
		var year17=document.forms[0].txt_year17[i].value;
		var year18=document.forms[0].txt_year18[i].value;
		var year19=document.forms[0].txt_year19[i].value;
		var year20=document.forms[0].txt_year20[i].value;
		var year21=document.forms[0].txt_year21[i].value;
		var year22=document.forms[0].txt_year22[i].value;
		var year23=document.forms[0].txt_year23[i].value;
		var year24=document.forms[0].txt_year24[i].value;
		var year25=document.forms[0].txt_year25[i].value;
		if(year1=="")
		{
			year1=0.00;
		}
		if(year2=="")
		{
			year2=0.00;
		}
		if(year3=="")
		{
			year3=0.00;
		}
		if(year4=="")
		{
			year4=0.00;
		}
		if(year5=="")
		{
			year5=0.00;
		}
		if(year6=="")
		{
			year6=0.00;
		}
		if(year7=="")
		{
			year7=0.00;
		}
		if(year8=="")
		{
			year8=0.00;
		}
		if(year9=="")
		{
			year9=0.00;
		}
		if(year10=="")
		{
			year10=0.00;
		}
		if(year11=="")
		{
			year11=0.00;
		}
		if(year12=="")
		{
			year12=0.00;
		}
		if(year13=="")
		{
			year13=0.00;
		}
		if(year14=="")
		{
			year14=0.00;
		}
		if(year15=="")
		{
			year15=0.00;
		}
		if(year16=="")
		{
			year16=0.00;
		}
		if(year17=="")
		{
			year17=0.00;
		}
		if(year18=="")
		{
			year18=0.00;
		}
		if(year19=="")
		{
			year19=0.00;
		}
		if(year20=="")
		{
			year20=0.00;
		}
		if(year21=="")
		{
			year21=0.00;
		}
		if(year22=="")
		{
			year22=0.00;
		}
		if(year23=="")
		{
			year23=0.00;
		}
		if(year24=="")
		{
			year24=0.00;
		}
		if(year25=="")
		{
			year25=0.00;
		}
		
		
		totalyear1=eval(totalyear1)+eval(year1);
		
		
		totalyear2=eval(totalyear2)+eval(year2);
		
		totalyear3=eval(totalyear3)+eval(year3);
		
		totalyear4=eval(totalyear4)+eval(year4);
		
		totalyear5=eval(totalyear5)+eval(year5);
		
		totalyear6=eval(totalyear6)+eval(year6);
		
		totalyear7=eval(totalyear7)+eval(year7);
		
		totalyear8=eval(totalyear8)+eval(year8);
		
		totalyear9=eval(totalyear9)+eval(year9);
		
		totalyear10=eval(totalyear10)+eval(year10);
		
		totalyear11=eval(totalyear11)+eval(year11);
		
		totalyear12=eval(totalyear12)+eval(year12);
		
		totalyear13=eval(totalyear13)+eval(year13)
		
		totalyear14=eval(totalyear14)+eval(year14);
		
		totalyear15=eval(totalyear15)+eval(year15);
		
		totalyear16=eval(totalyear16)+eval(year16);
		
		totalyear17=eval(totalyear17)+eval(year17);
		
		totalyear18=eval(totalyear18)+eval(year18);
		totalyear19=eval(totalyear19)+eval(year19);
		totalyear20=eval(totalyear20)+eval(year20);
		totalyear21=eval(totalyear21)+eval(year21);
		totalyear22=eval(totalyear22)+eval(year22);
		totalyear23=eval(totalyear23)+eval(year23);
		totalyear24=eval(totalyear24)+eval(year24);
		totalyear25=eval(totalyear25)+eval(year25);
	
	rowtotal=eval(year1)+eval(year2)+eval(year3)+eval(year4)+eval(year5)+eval(year6)+eval(year7)+eval(year8)+eval(year9)+eval(year10)+eval(year11)+eval(year12)+eval(year13)+eval(year14)+eval(year15)+
	eval(year16)+eval(year17)+eval(year18)+eval(year19)+eval(year20)+eval(year21)+eval(year22)+eval(year23)+eval(year24)+eval(year25);
	document.forms[0].txt_total[i].value=rowtotal;
	roundtxt(document.forms[0].txt_total[i]);
	total=eval(total)+eval(rowtotal);
	document.forms[0].txtcol_total.value=total;
	roundtxt(document.forms[0].txtcol_total);
	
			
	}
	document.forms[0].txt_year1total.value=totalyear1;
	roundtxt(document.forms[0].txt_year1total);
	document.forms[0].txt_year2total.value=totalyear2;
	roundtxt(document.forms[0].txt_year2total);
	document.forms[0].txt_year3total.value=totalyear3;
	roundtxt(document.forms[0].txt_year3total);
	document.forms[0].txt_year4total.value=totalyear4;
	roundtxt(document.forms[0].txt_year4total);
	document.forms[0].txt_year5total.value=totalyear5;
	roundtxt(document.forms[0].txt_year5total);
	document.forms[0].txt_year6total.value=totalyear6;
	roundtxt(document.forms[0].txt_year6total);
	document.forms[0].txt_year7total.value=totalyear7;
	roundtxt(document.forms[0].txt_year7total);
	document.forms[0].txt_year8total.value=totalyear8;
	roundtxt(document.forms[0].txt_year8total);
	document.forms[0].txt_year9total.value=totalyear9;
	roundtxt(document.forms[0].txt_year9total);
	document.forms[0].txt_year10total.value=totalyear10;
	roundtxt(document.forms[0].txt_year10total);
	document.forms[0].txt_year11total.value=totalyear11;
	roundtxt(document.forms[0].txt_year11total);
	document.forms[0].txt_year12total.value=totalyear12;
	roundtxt(document.forms[0].txt_year12total);
	document.forms[0].txt_year13total.value=totalyear13;
	roundtxt(document.forms[0].txt_year13total);
	document.forms[0].txt_year14total.value=totalyear14;
	roundtxt(document.forms[0].txt_year14total);
	document.forms[0].txt_year15total.value=totalyear15;
	roundtxt(document.forms[0].txt_year15total);
	document.forms[0].txt_year16total.value=totalyear16;
	roundtxt(document.forms[0].txt_year16total);
	document.forms[0].txt_year17total.value=totalyear17;
	roundtxt(document.forms[0].txt_year17total);
	document.forms[0].txt_year18total.value=totalyear18;
	roundtxt(document.forms[0].txt_year18total);
	document.forms[0].txt_year19total.value=totalyear19;
	roundtxt(document.forms[0].txt_year19total);
	document.forms[0].txt_year20total.value=totalyear20;
	roundtxt(document.forms[0].txt_year20total);
	document.forms[0].txt_year21total.value=totalyear21;
	roundtxt(document.forms[0].txt_year21total);
	document.forms[0].txt_year22total.value=totalyear22;
	roundtxt(document.forms[0].txt_year15total);
	document.forms[0].txt_year23total.value=totalyear23;
	roundtxt(document.forms[0].txt_year23total);
	document.forms[0].txt_year24total.value=totalyear24;
	roundtxt(document.forms[0].txt_year24total);
	document.forms[0].txt_year25total.value=totalyear25;
	roundtxt(document.forms[0].txt_year25total);
		
		
}
</script>
</head>
		
<body onload="onLoading()">
<form name="form1" method="post" class="normal">
  <table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
    <tr class="dataheader"> 
      <td  width="18%" ><b>Income 
        Items </b></td>
      <td  width="5%" ><b>Year1</b></td>
      <td  width="5%" ><b>Year2</b></td>
      <td  width="5%" ><b>Year3</b></td>
      <td  width="5%" ><b>Year4</b></td>
      <td  width="5%" ><b>Year5</b></td>
      <td  width="5%" ><b>Year6</b></td>
      <td  width="5%" ><b>Year7</b></td>
      <td  width="5%" ><b>Year8</b></td>
      <td  width="5%" ><b>Year9</b></td>
      <td  width="5%" ><b>Year10</b></td>
      <td  width="5%" ><b>Year11</b></td>
      <td  width="5%" ><b>Year12</b></td>
      <td  width="5%" ><b>Year13</b></td>
      <td  width="5%" ><b>Year14</b></td>
      <td  width="5%" ><b>Year15</b></td>
      <td  width="5%" ><b>Year16</b></td>
      <td  width="5%" ><b>Year17</b></td>
      <td  width="5%" ><b>Year18</b></td>
      <td  width="5%" ><b>Year19</b></td>
      <td  width="5%" ><b>Year20</b></td>
      <td  width="5%" ><b>Year21</b></td>
      <td  width="5%" ><b>Year22</b></td>
      <td  width="5%" ><b>Year23</b></td>
      <td  width="5%" ><b>Year24</b></td>
      <td  width="5%" ><b>Year25</b></td>
      <td  width="7%"  ><b>Total 
        </b></td>
    </tr>
    <%
	for(int i=1; i<=10;i++)
		{
		if (arryRow != null && arryRow.size()>=i) 
			{
			arryCol = (ArrayList) arryRow.get(i-1); 
			if (arryCol != null) {
			%>
    <tr> 
      <td width="18%"> 
        <input type="text" name="item" size="33" maxlength="30" value='<%=Helper.correctNull((String)arryCol.get(2))%>' onKeyPress="allowAlphaSpaIntPunct()">
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year1" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value='<%=Helper.correctNull((String)arryCol.get(3))%>'/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year2" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8"  value='<%=Helper.correctNull((String)arryCol.get(4))%>'/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year3" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value='<%=Helper.correctNull((String)arryCol.get(5))%>'/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year4" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value='<%=Helper.correctNull((String)arryCol.get(6))%>'/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year5" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value='<%=Helper.correctNull((String)arryCol.get(7))%>'/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year6" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value='<%=Helper.correctNull((String)arryCol.get(8))%>'/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year7" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value='<%=Helper.correctNull((String)arryCol.get(9))%>'/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year8" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value='<%=Helper.correctNull((String)arryCol.get(10))%>'/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year9" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value='<%=Helper.correctNull((String)arryCol.get(11))%>'/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year10" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value='<%=Helper.correctNull((String)arryCol.get(12))%>'/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year11" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value='<%=Helper.correctNull((String)arryCol.get(13))%>'/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year12" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value='<%=Helper.correctNull((String)arryCol.get(14))%>'/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year13" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value='<%=Helper.correctNull((String)arryCol.get(15))%>'/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year14" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value='<%=Helper.correctNull((String)arryCol.get(16))%>'/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year15" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value='<%=Helper.correctNull((String)arryCol.get(17))%>'/> 
      </td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year16" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value='<%=Helper.correctNull((String)arryCol.get(17))%>'/> </td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year17" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value='<%=Helper.correctNull((String)arryCol.get(17))%>'/> </td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year18" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value='<%=Helper.correctNull((String)arryCol.get(17))%>'/> </td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year19" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value='<%=Helper.correctNull((String)arryCol.get(17))%>'/> </td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year20" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value='<%=Helper.correctNull((String)arryCol.get(17))%>'/> </td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year21" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value='<%=Helper.correctNull((String)arryCol.get(17))%>'/> </td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year22" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value='<%=Helper.correctNull((String)arryCol.get(17))%>'/> </td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year23" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value='<%=Helper.correctNull((String)arryCol.get(17))%>'/> </td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year24" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value='<%=Helper.correctNull((String)arryCol.get(17))%>'/> </td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year25" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value='<%=Helper.correctNull((String)arryCol.get(17))%>'/> </td>
      <td width="7%"> <lapschoice:CurrencyTag name="txt_total" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/> 
      </td>
    </tr>
    <%}}
  else
  {
%>
    <tr> 
      <td width="18%"> 
        <input type="text" name="item" size="33" maxlength="30" onKeyPress="allowAlphaSpaIntPunct()">
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year1" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year2" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year3" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year4" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year5" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year6" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year7" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year8" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year9" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year10" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year11" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year12" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year13" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year14" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year15" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/> 
      </td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year16" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/></td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year17" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/></td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year18" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/></td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year19" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/></td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year20" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/></td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year21" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/></td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year22" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/></td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year23" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/></td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year24" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/></td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year25" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/></td>
      <td width="7%"> <lapschoice:CurrencyTag name="txt_total" onBlur="Rowtotal('<%=i%>')" size="12" maxlength="8" value=""/> 
      </td>
    </tr>
    <%}
  }%>
    <tr class="dataheader"> 
      <td  width="18%"  ><b>Total</b> 
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year1total" size="12" maxlength="8"/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year2total" size="12" maxlength="8"/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year3total" size="12" maxlength="8"/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year4total" size="12" maxlength="8"/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year5total" size="12" maxlength="8"/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year6total" size="12" maxlength="8"/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year7total" size="12" maxlength="8"/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year8total" size="12" maxlength="8"/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year9total" size="12" maxlength="8"/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year10total" size="12" maxlength="8"/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year11total" size="12" maxlength="8"/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year12total" size="12" maxlength="8"/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year13total" size="12" maxlength="8"/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year14total" size="12" maxlength="8"/> 
      </td>
      <td width="5%"> <lapschoice:CurrencyTag name="txt_year15total" size="12" maxlength="8"/> 
      </td>
     <td width="5%"><lapschoice:CurrencyTag name="txt_year16total" size="12" maxlength="8"/> </td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year17total" size="12" maxlength="8"/> </td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year18total" size="12" maxlength="8"/> </td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year19total" size="12" maxlength="8"/> </td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year20total" size="12" maxlength="8"/> </td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year21total" size="12" maxlength="8"/> </td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year22total" size="12" maxlength="8"/> </td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year23total" size="12" maxlength="8"/> </td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year24total" size="12" maxlength="8"/> </td>
      <td width="5%"><lapschoice:CurrencyTag name="txt_year25total" size="12" maxlength="8"/> </td>
      <td width="7%"> <lapschoice:CurrencyTag name="txtcol_total" size="12" maxlength="8"/> 
      </td>
    </tr>
  </table>
  <lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
 
	<input type="hidden" name="hidRecordflag" > 
	<lapschoice:agrihiddentag pageid="<%=PageId%>"/>
	<input
	type="hidden" name="type1" value="INC">
</form>
</body>
</html>
