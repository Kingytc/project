<%@include file="../share/directives.jsp"%>
<%
ArrayList arryRow = new ArrayList();
			
			arryRow = (ArrayList) hshValues.get("arryRow");
		
			if (arryRow == null) {
				arryRow = new ArrayList();
			}
	//String l1="",d1="",u1="",w1="",m1="",id="";
	//String l2="",d2="",u2="",w2="",m2="";
	//String l3="",d3="",u3="",w3="",m3="";	
	//String l4="",d4="",u4="",w4="",m4="";	
	//String l5="",d5="",u5="",w5="",m5="";	
	%>
	
<html>
<head>
<title>Gobar Gas tech/economic data</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/Validation.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var txt_sizeplant = "<%=Helper.correctNull((String)hshValues.get("txt_sizeplant"))%>" 
var txt_investment= "<%=Helper.correctNull((String)hshValues.get("txt_investment"))%>"  
var txt_subsidy = "<%=Helper.correctNull((String)hshValues.get("txt_subsidy"))%>"  
var txt_subsidyper = "<%=Helper.correctNull((String)hshValues.get("txt_subsidyper"))%>"  
var txt_margin = "<%=Helper.correctNull((String)hshValues.get("txt_margin"))%>"   
var txt_marginper = "<%=Helper.correctNull((String)hshValues.get("txt_marginper"))%>"   
var txt_animalsowned= "<%=Helper.correctNull((String)hshValues.get("txt_animalsowned"))%>"
var txt_animalsnorms = "<%=Helper.correctNull((String)hshValues.get("txt_animalsnorms"))%>"   
var txt_shortfall= "<%=Helper.correctNull((String)hshValues.get("txt_shortfall"))%>"
var txt_agency= "<%=Helper.correctNull((String)hshValues.get("txt_agency"))%>"   
var txt_persons = "<%=Helper.correctNull((String)hshValues.get("txt_persons"))%>"  
var txt_purpose1 = "<%=Helper.correctNull((String)hshValues.get("txt_purpose1"))%>"   
var txt_hrs1 = "<%=Helper.correctNull((String)hshValues.get("txt_hrs1"))%>"   
var txt_purpose2= "<%=Helper.correctNull((String)hshValues.get("txt_purpose2"))%>"
var txt_hrs2 = "<%=Helper.correctNull((String)hshValues.get("txt_hrs2"))%>"   
var txt_purpose3= "<%=Helper.correctNull((String)hshValues.get("txt_purpose3"))%>"
var txt_hrs3 = "<%=Helper.correctNull((String)hshValues.get("txt_hrs3"))%>"  
var txt_savings= "<%=Helper.correctNull((String)hshValues.get("txt_savings"))%>";
var txt_netannualincome = "<%=Helper.correctNull((String)hshValues.get("txt_netannualincome"))%>"  
var sel_payment = "<%=Helper.correctNull((String)hshValues.get("sel_payment" ))%>" 
</script>

<script>
function callCalender(name)
{
	if(document.forms[0].hideditflag.value=="Y")
	{
		showCal(appUrl,name);
		
	}
}
function callLink(page,bean,method)
{	
	 document.forms[0].hidAction.value="";
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}

function onloading()
{	  
	disableFields(true);

	document.forms[0].txt_sizeplant.value=txt_sizeplant;
	//document.forms[0].txt_investment.value=txt_investment;
	//document.forms[0].txt_subsidy.value=txt_subsidy;
	//document.forms[0].txt_subsidyper.value=txt_subsidyper;
	//document.forms[0].txt_margin.value=txt_margin;
	//document.forms[0].txt_marginper.value=txt_marginper;
	document.forms[0].txt_animalsowned.value=txt_animalsowned;
	document.forms[0].txt_animalsnorms.value=txt_animalsnorms;
	document.forms[0].txt_shortfall.value=txt_shortfall;
	document.forms[0].txt_agency.value=txt_agency;
	document.forms[0].txt_persons.value=txt_persons;
	document.forms[0].txt_purpose1.value=txt_purpose1;
	document.forms[0].txt_hrs1.value=txt_hrs1;
	document.forms[0].txt_purpose2.value=txt_purpose2;
	document.forms[0].txt_hrs2.value=txt_hrs2;
	document.forms[0].txt_purpose3.value=txt_purpose3;
	document.forms[0].txt_hrs3.value=txt_hrs3;
	document.forms[0].txt_savings.value=txt_savings;
	document.forms[0].txt_netannualincome.value=txt_netannualincome;
}

function enableButtons(bool1, bool2, bool3, bool4, bool5, bool6)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}
function doSave()
{   
    enableButtons(true, true, false, false, true, true);
	document.forms[0].hidBeanId.value="agriculture";		
	document.forms[0].hidSourceUrl.value="/action/agr_gg_eligibility.jsp";
	document.forms[0].hidBeanMethod.value="updategobarseligibilitydata";
	document.forms[0].hidBeanGetMethod.value="getgobartechdata";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doEdit()
{
 	disableFields(true);
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="insert";
	enableButtons(true, true, false, false, false, true);		
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agriculture";
		document.forms[0].hidBeanGetMethod.value="getgobartechdata";
		document.forms[0].action=appUrl+"action/agr_gg_eligibility.jsp";
		document.forms[0].submit(); 		
	}	
}



function doClose()
{
	if( ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appUrl+"action/"+"retailpge.jsp";				
		document.forms[0].submit();

	}
}
function disableFields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	
		
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=one;
	 	}
	 	if(document.forms[0].elements[i].type=='checkbox')
	 	{
			document.forms[0].elements[i].disabled=one;
	 	}
		  
	}
}


function doDelete()
{
	if( ConfirmMsg(101))
	{
	
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidSourceUrl.value="/action/agr_gg_eligibility.jsp";
		document.forms[0].hidBeanId.value="agriculture";
		document.forms[0].hidBeanMethod.value="updategobarseligibilitydata";
		document.forms[0].hidBeanGetMethod.value="getgobartechdata";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 	
	}	
}

function check1()
{
   var animalsowned=document.forms[0].txt_animalsowned.value;
   var animalsnorms= document.forms[0].txt_animalsnorms.value;
	if(eval(animalsowned)<eval(animalsnorms))
	{
		document.all.r3.style.visibility="visible";
		document.all.r4.style.visibility="visible";
	}
	else
	{
		document.all.r3.style.visibility="hidden";
		document.all.r4.style.visibility="hidden";
		document.forms[0].txt_shortfall.value="";
	}

}

function subsidyper()
{
//var investment=document.forms[0].txt_investment.value;
//var subsidy=document.forms[0].txt_subsidy.value;
if(eval(investment)=="")
{
investment="0";
}
if(eval(subsidy)=="")
{
subsidy="0";
document.forms[0].txt_subsidy.value="0";
document.forms[0].txt_subsidyper.value="0";
}
var subsidyper=Math.round((eval(subsidy)/eval(investment))*100);
document.forms[0].txt_subsidyper.value=NanNumber(eval(subsidyper));
}
function subsidy()
{
//var investment=document.forms[0].txt_investment.value;
//var subsidyper=document.forms[0].txt_subsidyper.value;
if(eval(investment)=="")
{
investment="0";
}
if(eval(subsidyper)=="")
{
subsidyper="0";
document.forms[0].txt_subsidyper.value="0";
document.forms[0].txt_subsidy.value="0";
}
var subsidy=Math.round((eval(subsidyper)*eval(investment))/100);
document.forms[0].txt_subsidy.value=NanNumber(eval(subsidy));
}

function marginper()
{
//var investment=document.forms[0].txt_investment.value;
//var margin=document.forms[0].txt_margin.value;
if(eval(investment)=="")
{
investment="0";
}
if(eval(margin)=="")
{
margin="0";
document.forms[0].txt_margin.value="0";
document.forms[0].txt_marginper.value="0";
}
var marginper=Math.round((eval(margin)/eval(investment))*100);
document.forms[0].txt_marginper.value=NanNumber(eval(marginper));
}
function margin()
{
//var investment=document.forms[0].txt_investment.value;
//var marginper=document.forms[0].txt_marginper.value;
if(eval(investment)=="")
{
investment="0";
}
if(eval(marginper)=="")
{
marginper="0";
document.forms[0].txt_marginper.value="0";
document.forms[0].txt_margin.value="0";
}
var margin=Math.round((eval(marginper)*eval(investment))/100);
document.forms[0].txt_margin.value=NanNumber(eval(margin));
}
function loanamount()
{
//var investment=document.forms[0].txt_investment.value;
//var subsidy=document.forms[0].txt_subsidy.value;
//var margin=document.forms[0].txt_margin.value;
if(eval(subsidy)=="")
{
subsidy="0";
document.forms[0].txt_subsidy.value="0";
}
if(eval(margin)=="")
{
margin="0";
document.forms[0].txt_margin.value="0";
}
//document.forms[0].txt_loanamount.value=NanNumber((eval(investment)-(eval(subsidy)+eval(margin))));
}

</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="onloading();check1();loanamount()">
	<form name="frmpri" class="normal" method="post">
	 <table class="outertable border1" width="98%"  border="0" cellpadding="3" cellspacing="0" align="center">
    <tr> 
      <td>
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="3">
    <tr> 
      <td>Size of the Plant</td>
      <td colspan="3"><input type="text" name="txt_sizeplant"  value="<%=Helper.correctNull((String)hshValues.get("txt_sizeplant"))%>"  size="15%" onKeyPress="" maxlength="8">
        (cu ft) </td>
    </tr>
    <tr> 
      <td>Technical feasibility held:</td>
      <td width="20%">Name of agency </td>
      <td colspan="2"  ><input type="text" name="txt_agency"  value="<%=Helper.correctNull((String)hshValues.get("txt_agency"))%>"  size="25%" onKeyPress="" maxlength="30"></td>
    </tr>
    <tr> 
      <td>No. of Animals Owned</td>
      <td colspan="3"> 
        <input type="text" name="txt_animalsowned"  value="<%=Helper.correctNull((String)hshValues.get("txt_animalsowned"))%>"  size="15%" onKeyPress="" maxlength="10">
        </td>
    </tr>
    <tr> 
      <td>No. of Animals as per Norms</td>
      <td> 
        <input type="text" name="txt_animalsnorms"  value="<%=Helper.correctNull((String)hshValues.get("txt_animalsnorms"))%>"  size="15%" onKeyPress="" maxlength="10" onBlur="check1()">
        </td>
      <td width="29%" id="r3">How the shortfall 
        has met</td>
      <td width="28%" id="r4">
        <input type="text" name="txt_shortfall"  value="<%=Helper.correctNull((String)hshValues.get("txt_shortfall"))%>"  size="25%" onKeyPress="" maxlength="50"></td>
    </tr>
    <tr> 
      <td>No. of persons benefited by the 
        construction of proposed plant</td>
      <td colspan="3"> 
        <input type="text" name="txt_persons"  value="<%=Helper.correctNull((String)hshValues.get("txt_persons"))%>"  size="15%" onKeyPress="" maxlength="10">
        </td>
    </tr>
    <tr> 
      <td width="23%" rowspan="3">Purpose 
        and No. of Hrs. gas is used for</td>
      <td colspan="3"> 
        <input type="text" name="txt_purpose1"  value="<%=Helper.correctNull((String)hshValues.get("txt_purpose1"))%>"  size="25%" onKeyPress="" maxlength="50">
         
        <input type="text" name="txt_hrs1"  value="<%=Helper.correctNull((String)hshValues.get("txt_hrs1"))%>"  size="5%" onKeyPress="" maxlength="10">
        Hrs.   </td>
    </tr>
    <tr> 
      <td colspan="3"><input type="text" name="txt_purpose2"  value="<%=Helper.correctNull((String)hshValues.get("txt_purpose2"))%>"  size="25%" onKeyPress="" maxlength="50"> 
         
        <input type="text" name="txt_hrs2"  value="<%=Helper.correctNull((String)hshValues.get("txt_hrs2"))%>"  size="5%" onKeyPress="" maxlength="10">
        Hrs. </td>
    </tr>
    <tr> 
      <td colspan="3"><input type="text" name="txt_purpose3"  value="<%=Helper.correctNull((String)hshValues.get("txt_purpose3"))%>"  size="25%" onKeyPress="" maxlength="50"> 
         
        <input type="text" name="txt_hrs3"  value="<%=Helper.correctNull((String)hshValues.get("txt_hrs3"))%>"  size="5%" onKeyPress="" maxlength="10">
        Hrs. </td>
    </tr>
    <tr> 
      <td>Savings on fuel due to implementation 
        of G.G Plant</td>
      <td>Rs. 
        <input type="text" name="txt_savings"  value="<%=Helper.correctNull((String)hshValues.get("txt_savings"))%>"  size="15%" onKeyPress="" maxlength="10">
        per Month</td>
      <td  >Net Annual Income </td>
      <td  >Rs. 
        <input type="text" name="txt_netannualincome"  value="<%=Helper.correctNull((String)hshValues.get("txt_netannualincome"))%>"  size="15%" onKeyPress="" maxlength="10">
        </td>
    </tr>
   
<tr> 
    <%--  
      <td colspan="4"><table class="outertable border1" width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr bgcolor="#71694F"> 
            <td width="14%" align = "center"><font	size="2" face="MS Sans Serif" color="#FFFFFF">Nature 
              of Limit</td>
            <td width="14%" align = "center"><font	size="2" face="MS Sans Serif" color="#FFFFFF">Amount</td>
            <td width="10%" align="center"><font	size="2" face="MS Sans Serif" color="#FFFFFF">Date 
              of Sanction</td>
            <td width="15%" align="center"><font	size="2" face="MS Sans Serif" color="#FFFFFF">Balance 
              o/s as on 
              <input type="text" name="txt_date1"  value="<%=Helper.correctNull((String)hshValues.get("txt_date1"))%>"  size="10%" onKeyPress="" maxlength="10">
              <a href="#" onClick="callCalender('txt_date1')"
											title="Click to view calender" border=0><img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											width="0" height="23" border="0"></a> 
              </td>
            <td width="10%" align="center"><font	size="2" face="MS Sans Serif" color="#FFFFFF">Comments 
              on regularity of the account</td>
          </tr>
          <tr> 
            <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(0);
				
				if (arryCol.size() != 0) {
					 
					l1 = Helper.correctNull((String) arryCol.get(3));
					d1 = Helper.correctNull((String) arryCol.get(4));
					u1 = Helper.correctNull((String) arryCol.get(5));
					w1 = Helper.correctNull((String) arryCol.get(6));
					m1 = Helper.correctNull((String) arryCol.get(7));
					
				}
			
			} else if (arryRow.size() == 0) {
				l1 = "";
				d1 = "";
				u1 = "";
				w1 = "";
				m1= "";
				
			}

			%>
            <td align="center"><input type="text" name="txt_limit"  value="<%=l1%>"  size="13%" onKeyPress="" maxlength="15"></td>
            <td align="center"><input type="text" name="txt_amount"  value="<%=d1%>"  size="13%" onKeyPress="allowNumber(this)" maxlength="10"></td>
            <td align="center"><input type="text" name="txt_date"  value="<%=u1%>"  size="10%" onKeyPress="" maxlength="10"> 
              <a href="#" onClick="callCalender('txt_date[0]')"
											title="Click to view calender" border=0><img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											width="0" height="23" border="0"></a></td>
            <td align="center"><input type="text" name="txt_balance"  value="<%=w1%>"  size="13%" onKeyPress="allowNumber(this)" maxlength="15"></td>
            <td align="center"><textarea name="txt_comments"
											onKeyPress="NoallowEnterandDoubleQuote();notAllowSingleQuote();textlimit(txt_comments[0],200)"
											rows="2" cols="25" wrap="virtual"><%=m1%></textarea></td>
          </tr>
          <tr> 
            <% 	if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(1);

				if (arryCol.size() != 0) {

					l2= Helper.correctNull((String) arryCol.get(3));
					d2 = Helper.correctNull((String) arryCol.get(4));
					u2 = Helper.correctNull((String) arryCol.get(5));
					w2= Helper.correctNull((String) arryCol.get(6));
					m2 = Helper.correctNull((String) arryCol.get(7));
					
				}
				

			} else if (arryRow.size() == 0) {
				l2="";
				d2 = "";
				u2 = "";
				w2 = "";
				m2 = "";
				
			}

			%>
            <td align="center"><input type="text" name="txt_limit"  value="<%=l2%>"  size="13%" onKeyPress="notAllowSplChar()" maxlength="15"></td>
            <td align="center"><input type="text" name="txt_amount"  value="<%=d2%>"  size="13%" onKeyPress="allowNumber(this)" maxlength="10"></td>
            <td align="center"><input type="text" name="txt_date"  value="<%=u2%>"  size="10%" onKeyPress="allowNumber(this)" maxlength="15"> 
              <a href="#" onClick="callCalender('txt_date[1]')"
											title="Click to view calender" border=0><img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											width="0" height="23" border="0"></a></td>
            <td align="center"><input type="text" name="txt_balance"  value="<%=w2%>"  size="13%" onKeyPress="allowNumber(this)" maxlength="15"></td>
            <td align="center"><textarea name="txt_comments"
											onKeyPress="NoallowEnterandDoubleQuote();notAllowSingleQuote();textlimit(txt_comments[1],200)"
											rows="2" cols="25" wrap="virtual"><%=m2%></textarea></td>
          </tr>
          <tr> 
            <% 	if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(2);

				if (arryCol.size() != 0) {

					l3= Helper.correctNull((String) arryCol.get(3));
					d3 = Helper.correctNull((String) arryCol.get(4));
					u3 = Helper.correctNull((String) arryCol.get(5));
					w3= Helper.correctNull((String) arryCol.get(6));
					m3 = Helper.correctNull((String) arryCol.get(7));
					
				}
				

			} else if (arryRow.size() == 0) {
				l3="";
				d3 = "";
				u3 = "";
				w3= "";
				m3 = "";
				
			}

			%>
            <td align="center"><input type="text" name="txt_limit"  value="<%=l3%>"  size="13%" onKeyPress="notAllowSplChar()" maxlength="15"></td>
            <td align="center"><input type="text" name="txt_amount"  value="<%=d3%>"  size="13%" onKeyPress="allowNumber(this)" maxlength="50"></td>
            <td align="center"><input type="text" name="txt_date"  value="<%=u3%>"  size="10%" onKeyPress="allowNumber(this)" maxlength="15"> 
              <a href="#" onClick="callCalender('txt_date[2]')"
											title="Click to view calender" border=0><img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											width="0" height="23" border="0"></a></td>
            <td align="center"><input type="text" name="txt_balance"  value="<%=w3%>"  size="13%" onKeyPress="allowNumber(this)" maxlength="15"></td>
            <td align="center"><textarea name="txt_comments"
											onKeyPress="NoallowEnterandDoubleQuote();notAllowSingleQuote();textlimit(txt_comments[2],200)"
											rows="2" cols="25" wrap="virtual"><%=m3%></textarea></td>
          </tr>
          <tr> 
            <% 	if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(3);

				if (arryCol.size() != 0) {

					l4= Helper.correctNull((String) arryCol.get(3));
					d4 = Helper.correctNull((String) arryCol.get(4));
					u4 = Helper.correctNull((String) arryCol.get(5));
					w4= Helper.correctNull((String) arryCol.get(6));
					m4 = Helper.correctNull((String) arryCol.get(7));
					
				}
				

			} else if (arryRow.size() == 0) {
				l4="";
				d4 = "";
				u4 = "";
				w4= "";
				m4 = "";
				
			}

			%>
            <td align="center"><input type="text" name="txt_limit"  value="<%=l4%>"  size="13%" onKeyPress="notAllowSplChar()" maxlength="15"></td>
            <td align="center"><input type="text" name="txt_amount"  value="<%=d4%>"  size="13%" onKeyPress="allowNumber(this)" maxlength="50"></td>
            <td align="center"><input type="text" name="txt_date"  value="<%=u4%>"  size="10%" onKeyPress="allowNumber(this)" maxlength="15"> 
              <a href="#" onClick="callCalender('txt_date[3]')"
											title="Click to view calender" border=0><img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											width="0" height="23" border="0"></a></td>
            <td align="center"><input type="text" name="txt_balance"  value="<%=w4%>"  size="13%" onKeyPress="allowNumber(this)" maxlength="15"></td>
            <td align="center"><textarea name="txt_comments"
											onKeyPress="NoallowEnterandDoubleQuote();notAllowSingleQuote();textlimit(txt_comments[3],200)"
											rows="2" cols="25" wrap="virtual"><%=m4%></textarea></td>
          </tr>
          <tr> 
            <% 	if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(4);

				if (arryCol.size() != 0) {

					l5= Helper.correctNull((String) arryCol.get(3));
					d5 = Helper.correctNull((String) arryCol.get(4));
					u5 = Helper.correctNull((String) arryCol.get(5));
					w5= Helper.correctNull((String) arryCol.get(6));
					m5 = Helper.correctNull((String) arryCol.get(7));
					
				}
				

			} else if (arryRow.size() == 0) {
				l5="";
				d5 = "";
				u5 = "";
				w5= "";
				m5 = "";
				
			}

			%>
            <td align="center"><input type="text" name="txt_limit"  value="<%=l5%>"  size="13%" onKeyPress="notAllowSplChar()" maxlength="15"></td>
            <td align="center"><input type="text" name="txt_amount"  value="<%=d5%>"  size="13%" onKeyPress="allowNumber(this)" maxlength="50"></td>
            <td align="center"><input type="text" name="txt_date"  value="<%=u5%>"  size="10%" onKeyPress="allowNumber(this)" maxlength="15"> 
              <a href="#" onClick="callCalender('txt_date[4]')"
											title="Click to view calender" border=0><img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											width="0" height="23" border="0"></a></td>
            <td align="center"><input type="text" name="txt_balance"  value="<%=w5%>"  size="13%" onKeyPress="allowNumber(this)" maxlength="15"></td>
            <td align="center"><textarea name="txt_comments"
											onKeyPress="NoallowEnterandDoubleQuote();notAllowSingleQuote();textlimit(txt_comments[4],200)"
											rows="2" cols="25" wrap="virtual"><%=m5%></textarea></td>
          </tr>
        </table>
		
		<table class="outertable border1" width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr> 
            <td width="17%" rowspan="2">Cost 
              of Investment</td>
            <td width="27%" rowspan="2">Rs. 
              <input type="text" name="txt_investment"  value="<%=Helper.correctNull((String)hshValues.get("txt_investment"))%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="10">
              (A) </td>
            <td width="23%">Subsidy Available</td>
            <td width="33%">Rs. 
              <input type="text" name="txt_subsidy"  value="<%=Helper.correctNull((String)hshValues.get("txt_subsidy"))%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="10" onBlur="subsidyper()">
              <input type="text" name="txt_subsidyper"  value="<%=Helper.correctNull((String)hshValues.get("txt_subsidyper"))%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="5" onBlur="subsidy()">
              % (B)</td>
          </tr>
          <tr> 
            <td>Margin Money</td>
            <td width="33%">Rs. 
              <input type="text" name="txt_margin"  value="<%=Helper.correctNull((String)hshValues.get("txt_margin"))%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="10" onBlur="marginper()">
              <input type="text" name="txt_marginper"  value="<%=Helper.correctNull((String)hshValues.get("txt_marginper"))%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="5" onBlur="margin()">
              % (C)</td>
          </tr>
          <tr> 
            <td colspan="4">Loan Amount Rs. 
              <input type="text" name="txt_loanamount"  value="<%=Helper.correctNull((String)hshValues.get("txt_loanamount"))%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="10">
              (A-B)/(A-C)/A-(B+C)</td>
          </tr>
         
        </table>

	
		</td>
    </tr>
    
    --%>	
  </table></td></tr></table>

<br>
<table  align="center" style="visibility:hidden;position:absolute">
<tr>
<td align="center" >
<input type="button" name="cmdsave" value="Save" class="buttonStyle" disabled>
</td>
</tr>
</table>
<!--<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>-->
<lapschoice:agrihiddentag pageid="<%=PageId%>"/>
	<input type ="hidden" name="land_measurement" value ="<%=Helper.correctNull((String)hshValues.get("land_measurement"))%>">
<br>

</form>

</body>
</html>

