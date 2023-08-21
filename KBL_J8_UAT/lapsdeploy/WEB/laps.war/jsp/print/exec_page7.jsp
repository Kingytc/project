<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<laps:handleerror />
<%

String strStatus1="";
strStatus1=Helper.correctNull((String)hshValues.get("exec_status"));

if (strStatus1.equalsIgnoreCase("op"))
{
	strStatus1="Open Pending";
}
else if(strStatus1.equalsIgnoreCase("pa"))
{
	strStatus1="Process Approved";
}
else if(strStatus1.equalsIgnoreCase("pr"))
{
	strStatus1="Process Rejected";
}
else if(strStatus1.equalsIgnoreCase("ca"))
{
	strStatus1="Closed Approved";
}

%>
<%
//-------------------------operational information-----------------------------------
ArrayList arryCol_grpcon=null;
ArrayList operinfo =(ArrayList) hshValues.get("oper_info");
%>




<html>
<head>
<title>Executive Summary</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
a:hover {  color: #FF3300}
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>jsp/htm/link.css" type="text/css">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">



<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js">
</script>

<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function callCalender(fname)
 {
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 }
 
function callLink(page,bean,method)
{		
	 document.forms[0].hidSourceUrl.value=page;
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;	
	 document.forms[0].hidCategoryType.value="CORP"; 
 	 document.forms[0].action=appUrl+"action/"+page;
	 document.forms[0].submit(); 
	

}

function calTotal1()
{
	var varTotal=0.00;
	for(var i=0;i<3;i++)
	{
	
	var vartxt_climit=document.forms[0].txt_climit[i].value;
	
	if(document.forms[0].txt_climit[i].value=="")
			{
			vartxt_climit="0";
			}
			
	varTotal=eval(varTotal)+eval(vartxt_climit);
	}
	
	document.forms[0].txt_climittotal.value=NanNumber(varTotal);
	roundtxt(document.forms[0].txt_climittotal);
}

function calTotal2()
{
	var varTotal=0.00;
	for(var i=0;i<3;i++){
	var vartxt_cos=document.forms[0].txt_cos[i].value;
	if(document.forms[0].txt_cos[i].value=="")
			{
			vartxt_cos="0";
			}
			
	varTotal=eval(varTotal)+eval(vartxt_cos);
	}
	document.forms[0].txt_costotal.value=NanNumber(varTotal);
		roundtxt(document.forms[0].txt_costotal);

}

function calTotal3()
{
	var varTotal=0.00;
	for(var i=0;i<3;i++){
	var vartxt_fbwclim=document.forms[0].txt_fbwclim[i].value;
	if(document.forms[0].txt_fbwclim[i].value=="")
			{
			vartxt_fbwclim="0";
			}
			
	varTotal=eval(varTotal)+eval(vartxt_fbwclim);
	}
	document.forms[0].txt_fbwclimtotal.value=NanNumber(varTotal);
	roundtxt(document.forms[0].txt_fbwclimtotal);

}

function calTotal4()
{
	var varTotal=0.00;
	for(var i=0;i<3;i++){
	var vartxt_fbwcdp=document.forms[0].txt_fbwcdp[i].value;
	if(document.forms[0].txt_fbwcdp[i].value=="")
			{
			vartxt_fbwcdp="0";
			}
	varTotal=eval(varTotal)+eval(vartxt_fbwcdp);
	}
	document.forms[0].txt_fbwcdptotal.value=NanNumber(varTotal);
	roundtxt(document.forms[0].txt_fbwcdptotal);

}
function calTotal5()
{
	var varTotal=0.00;
	for(var i=0;i<3;i++){
	var vartxt_fbwcos1=document.forms[0].txt_fbwcos1[i].value;
	if(document.forms[0].txt_fbwcos1[i].value=="")
			{
			vartxt_fbwcos1="0";
			}
	varTotal=eval(varTotal)+eval(vartxt_fbwcos1);
	}
	document.forms[0].txt_fbwcos1total.value=NanNumber(varTotal);
	roundtxt(document.forms[0].txt_fbwcos1total);
	

}
function calTotal6()
{
	var varTotal=0.00;
	for(var i=0;i<3;i++){
	var vartxt_tllimit=document.forms[0].txt_tllimit[i].value;
	if(document.forms[0].txt_tllimit[i].value=="")
			{
			vartxt_tllimit="0";
			}
	varTotal=eval(varTotal)+eval(vartxt_tllimit);
	}
	document.forms[0].txt_tllimittotal.value=NanNumber(varTotal);
	roundtxt(document.forms[0].txt_tllimittotal);
	

}
function calTotal7()
{
	var varTotal=0.00;
	for(var i=0;i<3;i++){
	var vartxt_tlos=document.forms[0].txt_tlos[i].value;
	if(document.forms[0].txt_tlos[i].value=="")
			{
			vartxt_tlos="0";
			}
	varTotal=eval(varTotal)+eval(vartxt_tlos);
	}
	document.forms[0].txt_tlostotal.value=NanNumber(varTotal);
	roundtxt(document.forms[0].txt_tlostotal);

}
function calTotal8()
{
	var varTotal=0.00;
	for(var i=0;i<3;i++){
	var vartxt_inv=document.forms[0].txt_inv[i].value;
	if(document.forms[0].txt_inv[i].value=="")
			{
			vartxt_inv="0";
			}
	varTotal=eval(varTotal)+eval(vartxt_inv);
	}
	document.forms[0].txt_invtotal.value=NanNumber(varTotal);
	roundtxt(document.forms[0].txt_invtotal);

}
function placevalues()
{
	disableFields(true);
	if(appstatus=="Process Rejected" ||appstatus=="Processed/Rejected" || appstatus=="Process Approved" || appstatus=="Processed/Approved" || appstatus=="Closed Approved" || appstatus=="Closed/Approved" || appstatus=="Closed Rejected")	 
		{
			enableButtons(true,true,true,true,false,true);	
		}
		else
		{
			enableButtons(false,true,true,false,false,true);	
		}
	
	
	   /* var exec_summ_indlevelrbiY="<%=Helper.correctNull((String)hshValues.get("exec_summ_indlevelrbiY"))%>";
	var exec_summ_indlevelbankY="<%=Helper.correctNull((String)hshValues.get("exec_summ_indlevelbankY"))%>";
	
	var credit_appr_sancauthority="<%=Helper.correctNull((String)hshValues.get("credit_appr_sancauthority"))%>";
	
	
	if (exec_summ_indlevelrbiY!="")
	{
	document.forms[0].exec_summ_indlevelrbiY.value=exec_summ_indlevelrbiY;
	}
	else 
	{
	document.forms[0].exec_summ_indlevelrbiY.value="0";
	}
	
	if (exec_summ_indlevelbankY!= "")
	{
	document.forms[0].exec_summ_indlevelbankY.value=exec_summ_indlevelbankY;
    }else
   {

	document.forms[0].exec_summ_indlevelbankY.value="0";
	}

   if (!credit_appr_sancauthority == "")
	{
	document.forms[0].credit_appr_sancauthority.value=credit_appr_sancauthority;
	}
	
	else 
	{
	document.forms[0].credit_appr_sancauthority.value="0";
	}*/
	
}
function PrintReport()
{
		
		appno="<%=Helper.correctNull((String)hshValues.get("exec_no"))%>";
					
		var purl ="<%=ApplicationParams.getAppUrl()%>action/executiveprint.jsp?hidBeanGetMethod=getExecutivePrint&hidBeanId=executive&appno="+appno;
		var prop = 'scrollbars=yes,menubar=yes,width=750,height=520';	
		var xpos = (screen.width - 750) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);
}
function disableFields(val)

	{
	
//	alert(document.forms[0].elements.length);
	
	for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
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
	document.forms[0].txt_climittotal.readOnly=true;
	document.forms[0].txt_costotal.readOnly=true;
	document.forms[0].txt_fbwclimtotal.readOnly=true;
	document.forms[0].txt_fbwcdptotal.readOnly=true;
	document.forms[0].txt_fbwcos1total.readOnly=true;
	document.forms[0].txt_tllimittotal.readOnly=true;
	document.forms[0].txt_tlostotal.readOnly=true;
	document.forms[0].txt_invtotal.readOnly=true;
	enableButtons(true,false,false,false,false,true)
}

function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{

	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdapply.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
	//document.forms[0].cmdaudit.disabled=bool6;
}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="executive";
		document.forms[0].hidBeanMethod.value="getData7";
		document.forms[0].hidBeanGetMethod.value="getData7";
		//document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/exec_page7.jsp";
		document.forms[0].submit();
	 }
	
}
function doClose()
{	
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";	
		document.forms[0].action=appUrl+"action/"+"corppge.jsp";
		//alert(document.forms[0].action);
		document.forms[0].submit();
	}	
}
function doSave()
{
		
		document.forms[0].hidAction.value="edit";		
		document.forms[0].hidBeanId.value="executive";
		document.forms[0].hidBeanMethod.value="updateData7";
		document.forms[0].hidBeanGetMethod.value="getData7";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/exec_page7.jsp";
		document.forms[0].submit();
		
}

function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="executive";
		document.forms[0].hidBeanMethod.value="updateData7";
		document.forms[0].hidBeanGetMethod.value="getData7";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/exec_page7.jsp";
		document.forms[0].submit();
	 }
}
</script>


<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
</head>

<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3" onload="placevalues();calTotal8();calTotal7();calTotal6();calTotal5();
calTotal4();calTotal3();calTotal2();calTotal1()">
<form name="frmpri" method = post>
<div align="right"> </div>
 
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td valign="bottom" align="center" height="49"><b>UBI 
      Head Office<br>
      <br>
        </b></td>
  </tr>
  <tr> 
      <td valign="middle" align="center" bgcolor="#71694F" height="22"><b><font color="#FFFFFF">Executive 
        Summary </font></b></td>
  </tr>
    
  </table>
   
  <table width="100%" border="1" cellspacing="0" cellpadding="0" height="10">
    <tr> 
      <td colspan="6"> 
        <div align="center"> </div>
      </td>
    </tr>
    <tr> 
      <td colspan="6">&nbsp;</td>
    </tr>
    <tr> 
      <td width="14%"> 
        <div align="center"> <b> Application No :</b> </div>
      </td>
      <td width="20%"><b> 
        <input type="text" name="appno" size="20" value="<%=Helper.correctNull((String)hshValues.get("exec_no"))%>" readonly style="border:0;background-color:#DEDACF" maxlength="50">
        </b> </td>
      <td width="14%"> 
        <div align="center"><b>Applicant Name:</b></div>
      </td>
      <td width="27%"><b> 
        <input type="text" name="appname" style="border:0;background-color:#DEDACF" size="35" readonly value="<%=Helper.correctNull((String)hshValues.get("exec_name"))%>" maxlength="50">
        </b> </td>
      <td width="11%"> 
        <div align="center"><b>Status:</b></div>
      </td>
      <td width="19%"><b> 
        <input type="text" name="appstatus" style="border:0;background-color:#DEDACF" size="20" readonly value="<%=strStatus1%>" maxlength="50">
        </b> </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0"   bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
 
 
</table>                                   
  <table width="100%" border="1" cellspacing="0" cellpadding="5" height="380" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr> 
      <td valign="top"> 
        <div align="left"> </div>
        
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
          <tr> 
            <td valign="top" colspan="2">&nbsp; </td>
          </tr>
          <tr> 
            <td valign="top" colspan="2"><b>OPERATIONAL EXPERIENCE WITH REGARD 
              TO GROUP CONCERNS</b></td>
          </tr>
          <tr> 
            <td valign="top" colspan="2" height="2"> <b></b></td>
          </tr>
          <tr> 
            <td valign="top" colspan="2"> 
              <table width="100%" border="1" cellspacing="0" cellpadding="3">
                <tr> 
                  <td width="14%" rowspan="2" nowrap> 
                    <div align="center">Name of the Concern</div>
                  </td>
                  <td rowspan="2" width="6%"> 
                    <div align="center">Branch</div>
                  </td>
                  <td rowspan="2" width="6%"> 
                    <div align="center">CoA</div>
                  </td>
                  <td colspan="2"> 
                    <div align="center">Contin-gent</div>
                  </td>
                  <td colspan="3" align="center"> 
                    <div align="center">FBWC</div>
                  </td>
                  <td colspan="2" align="center"> 
                    <div align="center">Term Loan</div>
                  </td>
                  <td width="7%" rowspan="2" align="center"> 
                    <div align="center">Invest-ment</div>
                  </td>
                  <td width="12%" rowspan="2" align="center"> MOR</td>
                  <td width="23%" rowspan="2" align="center"> Irregularity,if 
                    any</td>
                </tr>
                <tr> 
                  <td width="4%" height="20"> 
                    <div align="center">Limit</div>
                  </td>
                  <td width="5%" height="20"> 
                    <div align="center">O/s</div>
                  </td>
                  <td width="4%" height="20"> 
                    <div align="center">Limit</div>
                  </td>
                  <td width="4%" height="20"> 
                    <div align="center">DP</div>
                  </td>
                  <td width="5%" height="20"> 
                    <div align="center">O/s</div>
                  </td>
                  <td width="4%" height="20"> 
                    <div align="center">Limit</div>
                  </td>
                  <td width="6%" height="20"> 
                    <div align="center">O/s</div>
                  </td>
                </tr>
                <%
				for(int j=1;j<4;j++)
				{
					 if(operinfo!=null && operinfo.size()>=j)
						{
						 arryCol_grpcon=(ArrayList)operinfo.get(j-1);

				%>
                <tr> 
                  <td width="14%"> 
                    <div align="center"> 
                      <input type="text" name="txt_concern" size="15" value="<%=arryCol_grpcon.get(0)%>" maxlength="50">
                    </div>
                  </td>
                  <td width="6%"> 
                    <div align="center"> 
                      <input type="text" name="txt_brch" size="10" value="<%=arryCol_grpcon.get(1)%>" maxlength="20">
                    </div>
                  </td>
                  <td width="6%"> 
                    <div align="center"> 
                      <input type="text" name="txt_coa" size="10" value="<%=arryCol_grpcon.get(2)%>" maxlength="20">
                    </div>
                  </td>
                  <td width="4%"> 
                    <div align="center"> 
                      <input type="text" name="txt_climit" size="10" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);calTotal1()" value="<%=arryCol_grpcon.get(3)%>" maxlength="9">
                    </div>
                  </td>
                  <td width="5%"> 
                    <div align="center"> 
                      <input type="text" name="txt_cos" size="10" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);calTotal2()" value="<%=arryCol_grpcon.get(4)%>" maxlength="9">
                    </div>
                  </td>
                  <td width="4%"> 
                    <div align="center"> 
                      <input type="text" name="txt_fbwclim" size="10" value="<%=arryCol_grpcon.get(5)%>" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);calTotal3()" maxlength="9">
                    </div>
                  </td>
                  <td width="4%"> 
                    <div align="center"> 
                      <input type="text" name="txt_fbwcdp" size="10" value="<%=arryCol_grpcon.get(6)%>" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);calTotal4()" maxlength="9">
                    </div>
                  </td>
                  <td width="5%"> 
                    <div align="center"> 
                      <input type="text" name="txt_fbwcos1" size="10" value="<%=arryCol_grpcon.get(7)%>" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);calTotal5()" maxlength="9">
                    </div>
                  </td>
                  <td width="4%"> 
                    <div align="center"> 
                      <input type="text" name="txt_tllimit" size="10" value="<%=arryCol_grpcon.get(8)%>" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);calTotal6()" maxlength="9">
                    </div>
                  </td>
                  <td width="6%"> 
                    <div align="center"> 
                      <input type="text" name="txt_tlos" size="10" value="<%=arryCol_grpcon.get(9)%>" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);calTotal7()" maxlength="9">
                    </div>
                  </td>
                  <td width="7%"> 
                    <div align="center"> 
                      <input type="text" name="txt_inv" size="10" value="<%=arryCol_grpcon.get(10)%>" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);calTotal8()" maxlength="9">
                    </div>
                  </td>
                  <td width="12%"> 
                    <input type="text" name="txt_mor" size="10" value="<%=arryCol_grpcon.get(11)%>" maxlength="9">
                  </td>
                  <td width="23%"> 
                    <input type="text" name="txt_irr" size="15" value="<%=arryCol_grpcon.get(12)%>" maxlength="50">
                  </td>
                </tr>
                <%
												}else
									{
													
									%>
                <tr> 
                  <td width="14%"> 
                    <div align="center"> 
                      <input type="text" name="txt_concern2" size="15" maxlength="50">
                    </div>
                  </td>
                  <td width="6%"> 
                    <div align="center"> 
                      <input type="text" name="txt_brch" size="10" maxlength="20">
                    </div>
                  </td>
                  <td width="6%"> 
                    <div align="center"> 
                      <input type="text" name="txt_coa" size="10" maxlength="20">
                    </div>
                  </td>
                  <td width="4%"> 
                    <div align="center"> 
                      <input type="text" name="txt_climit" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);calTotal1()" size="10" maxlength="9">
                    </div>
                  </td>
                  <td width="5%"> 
                    <div align="center"> 
                      <input type="text" name="txt_cos" size="10" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);calTotal2()" maxlength="9">
                    </div>
                  </td>
                  <td width="4%"> 
                    <div align="center"> 
                      <input type="text" name="txt_fbwclim" size="10" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);calTotal3()" maxlength="9">
                    </div>
                  </td>
                  <td width="4%"> 
                    <div align="center"> 
                      <input type="text" name="txt_fbwcdp" size="10" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);calTotal4()" maxlength="9">
                    </div>
                  </td>
                  <td width="5%"> 
                    <div align="center"> 
                      <input type="text" name="txt_fbwcos1" size="10" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);calTotal5()" maxlength="9">
                    </div>
                  </td>
                  <td width="4%"> 
                    <div align="center"> 
                      <input type="text" name="txt_tllimit" size="10" maxlength="9" onKeyPress="allowDecimals(this);" onBlur="roundtxt(this);calTotal6()">
                    </div>
                  </td>
                  <td width="6%"> 
                    <div align="center"> 
                      <input type="text" name="txt_tlos" size="10" maxlength="9" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);calTotal7()">
                    </div>
                  </td>
                  <td width="7%"> 
                    <div align="center"> 
                      <input type="text" name="txt_inv" size="10" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);calTotal8()" maxlength="9">
                    </div>
                  </td>
                  <td width="12%"> 
                    <input type="text" name="txt_mor" size="10" maxlength="9">
                  </td>
                  <td width="23%"> 
                    <input type="text" name="txt_irr" size="15" maxlength="50">
                  </td>
                </tr>
                <%
								
									}
										}
									
										%>
                <tr> 
                  <td width="14%"><b>TOTAL EXPOSURE</b></td>
                  <td width="6%">&nbsp;</td>
                  <td width="6%">&nbsp;</td>
                  <td width="4%">
				  <div align="center"> 
                      <input type="text" name="txt_climittotal" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);calTotal1()" size="10" value="<%=Helper.correctNull((String)hshValues.get("EXEC_GCCOMLIMIT"))%>" maxlength="9" >
                    </div>
					</td>
                  <td width="5%"><div align="center"> 
                      <input type="text" name="txt_costotal" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);calTotal2()" size="10" value="<%=Helper.correctNull((String)hshValues.get("EXEC_GCCOMOS"))%>" maxlength="9">
                    </div></td>
                  <td width="4%"><div align="center"> 
                      <input type="text" name="txt_fbwclimtotal" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);calTotal3()" size="10" value="<%=Helper.correctNull((String)hshValues.get("EXEC_GCFBWCLT"))%>" maxlength="9">
                    </div></td>
                  <td width="4%"><div align="center"> 
                      <input type="text" name="txt_fbwcdptotal" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);calTotal4()" size="10" value="<%=Helper.correctNull((String)hshValues.get("EXEC_GCFBWCDP"))%>" maxlength="9">
                    </div></td>
                  <td width="5%"><div align="center"> 
                      <input type="text" name="txt_fbwcos1total" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);calTotal5()" size="10" value="<%=Helper.correctNull((String)hshValues.get("EXEC_GCFBWCOS"))%>" maxlength="9">
                    </div></td>
                  <td width="4%"><div align="center"> 
                      <input type="text" name="txt_tllimittotal" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);calTotal6()" size="10" value="<%=Helper.correctNull((String)hshValues.get("EXEC_GCTLLT"))%>" maxlength="9">
                    </div></td>
                  <td width="6%"><div align="center"> 
                      <input type="text" name="txt_tlostotal" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);calTotal7()" size="10" value="<%=Helper.correctNull((String)hshValues.get("EXEC_GCTLOS"))%>" maxlength="9">
                    </div></td>
                  <td width="7%"><div align="center"> 
                      <input type="text" name="txt_invtotal" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);calTotal8()" size="10" value="<%=Helper.correctNull((String)hshValues.get("EXEC_GCINS"))%>" maxlength="9">
                    </div></td>
                  <td width="12%">&nbsp;</td>
                  <td width="23%">&nbsp;</td>
                </tr>
              
                
              </table>
            </td>
          </tr>
          <tr> 
            <td valign="top" colspan="2">&nbsp; </td>
          </tr>
          <tr> 
            <td valign="top" colspan="2">&nbsp;</td>
          </tr>
          
          <tr> 
            <td valign="top" width="41%"><b>COMMENTS ON OTHER BANK'S CREDIT REPORT 
              ON SISTER CONCERNS</b></td>
            <td valign="top" width="59%"> 
              <textarea name="exec_comments"  cols="75" rows="6" onKeyPress="textlimit(document.forms[0].exec_comments,250)" onKeyUp="textlimit(this,250)"><%=Helper.correctNull((String)hshValues.get("exec_comments"))%></textarea>
                         </td>
          </tr>
          
         
          <tr> 
            <td valign="top" colspan="2">&nbsp;</td>
          </tr>
          <tr> 
            <td valign="top" colspan="2">&nbsp;</td>
          </tr>
        </table>
    </td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
    <tr> 
      <td colspan="3"> 
        <%
		String strappno = request.getParameter("appno");
	//	out.println(strappno);
		%>
        <laps:combuttons  apporgcode='<%=strappno%>' strSource=""/> </td>
    </tr>
    <tr> 
      <td colspan="3"></td>
    </tr>
    <tr> 
      <td width="33%">&nbsp; 
        <div align="left"><b> <a href="javascript:callLink('exec_page6.jsp','executive','getData6')" class="blackfont"> 
          &lt;&lt;&nbsp; Previous</a></b> </div>
      </td>
      <td width="33%" align="center"><b> 
        <jsp:include page="../com/link1.jsp" flush="true"/> 
        </b></td>
      <td width="33%">&nbsp; 
        <div align="right"><b>Pg.7/8 &nbsp;<a href="javascript:callLink('exec_page8.jsp','executive','getData8')" class="blackfont"> 
          Next &gt;&gt; </a></b> </div>
    </td>
    </tr>
</table>
  <input type="hidden" name="hidAction">
  <input type="hidden" name="hidBeanId">
  <input type="hidden" name="hidBeanMethod" value="">
  <input type="hidden" name="hidBeanGetMethod" value="" >
  <input type="hidden" name="hidSourceUrl" value="">
  <input type="hidden" name="pageval" value="FI">
  <input type="hidden" name="hidappno" value="<%=request.getParameter("hidappno")%>"> 
  <input type="hidden" name="hidCategoryType" value="<%//=Helper.correctNull((String)session.getAttribute("hidCategoryType"))%>">
          
   </form>  
 </body>         
</html>

