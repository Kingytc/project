<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			
			int vecsize = 0;
			int vecsize1 = 0;
			
			String strapptype = "";
			String apptype = "";
			String app_status = Helper.correctNull((String) hshValues
					.get("app_status"));
			 
			%>
           <%ArrayList arryCol1 = new ArrayList();
          ArrayList arryRow1 = new ArrayList();
			
			arryRow1 = (ArrayList) hshValues.get("arryRow1");
		
			if (arryRow1 == null) {
				arryRow1 = new ArrayList();
			}
String u1="",u2="",u3="",u4="",u5="",u6="";
	
		%>
<html>
<head>
<title>SHEEP/GOAT Tech Details</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<STYLE>
DIV.cellContainer {	
  width: 100%; height: 100;
  overflow: auto;
}
</STYLE>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var sel_animal= "<%=Helper.correctNull((String)hshValues.get("sel_animal"))%>"
var txt_breed = "<%=Helper.correctNull((String)hshValues.get("txt_breed"))%>" 
var txt_agem = "<%=Helper.correctNull((String)hshValues.get("txt_agem" ))%>" 
var txt_maleno= "<%=Helper.correctNull((String)hshValues.get("txt_maleno"))%>" 
var txt_malecost= "<%=Helper.correctNull((String)hshValues.get("txt_malecost"))%>" 
var txt_maleamount = "<%=Helper.correctNull((String)hshValues.get("txt_maleamount"))%>"  
var txt_agef= "<%=Helper.correctNull((String)hshValues.get("txt_agef"))%>" 
var txt_femaleno = "<%=Helper.correctNull((String)hshValues.get("txt_femaleno"))%>" 
var txt_femalecost = "<%=Helper.correctNull((String)hshValues.get("txt_femalecost"))%>" 
var txt_femaleamount = "<%=Helper.correctNull((String)hshValues.get("txt_femaleamount"))%>" 
var txt_totalanimalno = "<%=Helper.correctNull((String)hshValues.get("txt_totalanimalno"))%>" 
var txt_totalanimalcost = "<%=Helper.correctNull((String)hshValues.get("txt_totalanimalcost"))%>" 
var txt_totalanimalamount= "<%=Helper.correctNull((String)hshValues.get("txt_totalanimalamount"))%>" 
var txt_marketplace= "<%=Helper.correctNull((String)hshValues.get("txt_marketplace"))%>" 
var txt_marketdistance = "<%=Helper.correctNull((String)hshValues.get("txt_marketdistance"))%>" 
var txt_migrationpattern = "<%=Helper.correctNull((String)hshValues.get("txt_migrationpattern"))%>" 
var txt_grazingpattern = "<%=Helper.correctNull((String)hshValues.get("txt_grazingpattern"))%>" 
var txt_greenfodder = "<%=Helper.correctNull((String)hshValues.get("txt_greenfodder"))%>" 
var txt_vtaidplace= "<%=Helper.correctNull((String)hshValues.get("txt_vtaidplace"))%>" 
var txt_distancefarm = "<%=Helper.correctNull((String)hshValues.get("txt_distancefarm"))%>" 
var txt_woolplace= "<%=Helper.correctNull((String)hshValues.get("txt_woolplace"))%>" 
var txt_distancewool= "<%=Helper.correctNull((String)hshValues.get("txt_distancewool"))%>" 
var sel_care= "<%=Helper.correctNull((String)hshValues.get("sel_care"))%>" 
var sel_flock= "<%=Helper.correctNull((String)hshValues.get("sel_flock"))%>" 
</script>

<script>
function checkflock()
{
	if(document.forms[0].sel_flock.value == "1")
	{
	    
	    document.all.r1.style.visibility="visible";
		document.all.r2.style.visibility="hidden";
		document.all.r3.style.visibility="hidden";
		document.forms[0].txt_grazingpattern.value="";
		document.forms[0].txt_greenfodder.value="";		
	}
	if(document.forms[0].sel_flock.value == "2")
	{
	  document.all.r2.style.visibility="visible";
		document.all.r1.style.visibility="hidden";
		document.all.r3.style.visibility="hidden";
		document.forms[0].txt_migrationpattern.value="";
		document.forms[0].txt_greenfodder.value="";		
	}
	if(document.forms[0].sel_flock.value == "3")
	{
	     
		document.all.r3.style.visibility="visible";
		document.all.r1.style.visibility="hidden";
		document.all.r2.style.visibility="hidden";
		document.forms[0].txt_grazingpattern.value="";
		document.forms[0].txt_migrationpattern.value="";		
	}
	if(document.forms[0].sel_flock.value == "0")
	{
		document.all.r3.style.visibility="hidden";
		document.all.r1.style.visibility="hidden";
		document.all.r2.style.visibility="hidden";
		document.forms[0].txt_grazingpattern.value="";
		document.forms[0].txt_migrationpattern.value="";
		document.forms[0].txt_greenfodder.value="";
		
	}
}
function callamount()
{
var maleno=document.forms[0].txt_maleno.value;
var malecost=document.forms[0].txt_malecost.value;
if(eval(maleno)=="")
{
maleno="0";
}
if(eval(malecost)=="")
{
malecost="0";
}
document.forms[0].txt_maleamount.value=eval(maleno)*eval(malecost);
var femaleno=document.forms[0].txt_femaleno.value;
var femalecost=document.forms[0].txt_femalecost.value;
if(eval(femaleno)=="")
{
femaleno="0";
}
if(eval(femalecost)=="")
{
femalecost="0";
}
document.forms[0].txt_femaleamount.value=eval(femaleno)*eval(femalecost);
}
function calltotal()
{
var maleno=document.forms[0].txt_maleno.value;
var femaleno=document.forms[0].txt_femaleno.value;
if(eval(maleno)=="")
{
maleno="0";
}
if(eval(femaleno)=="")
{
femaleno="0";
}
document.forms[0].txt_totalanimalno.value=eval(maleno)+eval(femaleno);

var malecost=document.forms[0].txt_malecost.value;
var femalecost=document.forms[0].txt_femalecost.value;
if(eval(malecost)=="")
{
malecost="0";
}
if(eval(femalecost)=="")
{
femalecost="0";
}
document.forms[0].txt_totalanimalcost.value=eval(malecost)+eval(femalecost);
var maleamount=document.forms[0].txt_maleamount.value;
var femaleamount=document.forms[0].txt_femaleamount.value;
if(eval(maleamount)=="")
{
maleamount="0";
}
if(eval(femaleamount)=="")
{
femaleamount="0";
}
document.forms[0].txt_totalanimalamount.value=eval(maleamount)+eval(femaleamount);

}
function onloading()
{	  
	if (document.forms[0].app_status.value!="")
	{
		if (document.forms[0].app_status.value=="pa")
		{	
			 document.forms[0].cmdnew.disabled = true;
			 document.forms[0].cmdedit.disabled = true;
			 alert("unable to modify APPROVED APPLICATION !!!")
		}
	}
	if(sel_animal!="")
	{
		document.forms[0].sel_animal.value=sel_animal;
	}
	document.forms[0].txt_breed.value=txt_breed;
	document.forms[0].txt_agem.value=txt_agem;
	document.forms[0].txt_maleno.value=txt_maleno;
	document.forms[0].txt_malecost.value=txt_malecost;
	document.forms[0].txt_maleamount.value=txt_maleamount;
	document.forms[0].txt_agef.value=txt_agef;
    document.forms[0].txt_femaleno.value=txt_femaleno;
	document.forms[0].txt_femalecost.value=txt_femalecost;
	document.forms[0].txt_femaleamount.value=txt_femaleamount;
	document.forms[0].txt_totalanimalno.value=txt_totalanimalno;
	document.forms[0].txt_totalanimalcost.value=txt_totalanimalcost;
	document.forms[0].txt_totalanimalamount.value=txt_totalanimalamount;
	document.forms[0].txt_marketplace.value=txt_marketplace;
	document.forms[0].txt_marketdistance.value=txt_marketdistance;
	   if(sel_flock!="")
	{
		document.forms[0].sel_flock.value=sel_flock;
	}
	document.forms[0].txt_migrationpattern.value=txt_migrationpattern;
	document.forms[0].txt_grazingpattern.value=txt_grazingpattern;
	document.forms[0].txt_greenfodder.value=txt_greenfodder;
	document.forms[0].txt_vtaidplace.value=txt_vtaidplace;
   	document.forms[0].txt_distancefarm.value=txt_distancefarm;
    document.forms[0].txt_woolplace.value=txt_woolplace;
   	document.forms[0].txt_distancewool.value=txt_distancewool;
      if(sel_care!="")
	{
		document.forms[0].sel_care.value=sel_care;
	}
	disableFields(true);
	enableButtons(true, true, true, true, true, false);
		
}
function enableButtons(bool1, bool2, bool3, bool4, bool5, bool6)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdapply.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddel.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}
function doSave()
{   
   callamount();calltotal();
    enableButtons(true, true, true, true, true, false);
	document.forms[0].hidBeanId.value="agrpoultry";		
	document.forms[0].hidSourceUrl.value="/action/agr_sheep_techdata.jsp";
	document.forms[0].hidBeanMethod.value="updatesheeptechdata";
	document.forms[0].hidBeanGetMethod.value="getsheeptechdata";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doEdit()
{
 	disableFields(true);
	enableButtons(true, true, false, false, true, true);		
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/agr_sheep_techdata.jsp";
		document.forms[0].hidBeanId.value="agrpoultry";
		document.forms[0].hidBeanGetMethod.value="getsheeptechdata";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 		
	}	
}



function doClose()
{
	if( ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/"+"agr_sheep_techdata.jsp";
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
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updatesheeptechdata";
		document.forms[0].hidBeanGetMethod.value="getsheeptechdata";
		document.forms[0].hidBeanId.value="agrpoultry";
		document.forms[0].hidSourceUrl.value="action/agr_sheep_techdata.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}


</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
DIV.cellContainer {	
  width: 100%; height: 250;
  overflow: auto;
}
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" vlink="#330000" alink="#330000"
	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="onloading();checkflock();">
	<form name="frmpri" method="post">
  <table width="100%"  border="0" cellpadding="3" cellspacing="0">
    <tr> 
      <td width="19%"></td>
      <td width="17%"></td>
      <td width="8%"></td>
      <td width="6%"></td>
      <td width="6%"> </td>
      <td width="26%"> </td>
      <td width="3%"></td>
      <td width="15%"></td>
    </tr>
    <tr> 
      <td colspan="9"><font	size="2" face="MS Sans Serif" >Particulars of Animals 
        <select name="sel_animal" onChange="checkanimal()">
          <option >--select--</option>
          <option value="1">Goat</option>
          <option value="2">Sheep</option>
          <option value="3">Duck</option>
          <option value="4">Rabbit</option>
          <option value="5">Pig</option>
          <option value="6">Quail</option>
          <option value="7">Birds</option>
          <option value="8">Others</option>
        </select>
        </font></td>
    </tr>
    <tr> 
      <td colspan="9"><table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
          <tr > 
            <td width="31%" >Breed</td>
            <td width="13%">Type</td>
            <td width="17%">Age(Months)</td>
            <td width="13%">No. of Animals<font face="MS Sans Serif" size="1"
											color="#000000"><b></b></font></td>
            <td width="8%">Cost per Animal(Rs.)<font face="MS Sans Serif" size="1"
											color="#000000"><b></b></font></td>
            <td width="18%">Amount(Rs.)</td>
          </tr>
          <tr> 
            <td rowspan="2"><input type="text" name="txt_breed"  value="<%=Helper.correctNull((String)hshValues.get("txt_breed"))%>"  size="40%" onKeyPress="notAllowSplChar()" maxlength="50"></td>
            <td>Male</td>
            <td><input type="text" name="txt_agem"  value="<%=Helper.correctNull((String)hshValues.get("txt_agem"))%>"  size="12%" onKeyPress="allowInteger()" maxlength="3"></td>
            <td><input type="text" name="txt_maleno"  value="<%=Helper.correctNull((String)hshValues.get("txt_maleno"))%>"  size="12%" onKeyPress="allowInteger()" maxlength="9" onBlur="callamount();calltotal()"></td>
            <td><input type="text" name="txt_malecost"  value="<%=Helper.correctNull((String)hshValues.get("txt_malecost"))%>"  size="12%" onKeyPress="allowNumber(this)" maxlength="9" onBlur="callamount();calltotal()"></td>
            <td><input type="text" name="txt_maleamount"  value="<%=Helper.correctNull((String)hshValues.get("txt_maleamount"))%>"  size="12%" onKeyPress="allowNumber(this)" maxlength="9" onBlur="calltotal()"></td>
          </tr>
          <tr> 
            <td>Female</td>
            <td><input type="text" name="txt_agef"  value="<%=Helper.correctNull((String)hshValues.get("txt_agef"))%>"  size="12%" onKeyPress="allowInteger()" maxlength="3"></td>
            <td><input type="text" name="txt_femaleno"  value="<%=Helper.correctNull((String)hshValues.get("txt_femaleno"))%>"  size="12%" onKeyPress="allowInteger()" maxlength="9" onBlur="callamount();calltotal()"></td>
            <td><input type="text" name="txt_femalecost"  value="<%=Helper.correctNull((String)hshValues.get("txt_femalecost"))%>"  size="12%" onKeyPress="allowNumber(this)" maxlength="9" onBlur="callamount();calltotal()"></td>
            <td><input type="text" name="txt_femaleamount"  value="<%=Helper.correctNull((String)hshValues.get("txt_femaleamount"))%>"  size="12%" onKeyPress="allowNumber(this)" maxlength="9" onBlur="calltotal()"></td>
          </tr>
          <tr> 
            <td>Total</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td><input type="text" name="txt_totalanimalno"  value=""  size="12%" onKeyPress="allowNumber(this)" maxlength="9"></td>
            <td><input type="text" name="txt_totalanimalcost"  value=""  size="12%" onKeyPress="allowNumber(this)" maxlength="9"></td>
            <td><input type="text" name="txt_totalanimalamount"  value=""  size="12%" onKeyPress="allowNumber(this)" maxlength="9"></td>
          </tr>
        </table></td>
    </tr>
    <tr> 
      <td colspan="9"><font	size="2" face="MS Sans Serif" >Market where animals 
        are proposed to be purchased</font></td>
    </tr>
    <tr> 
      <td colspan="9"><table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr> 
            <td width="8%"><font	size="2" face="MS Sans Serif" >Place</font></td>
            <td width="16%"> 
              <input type="text" name="txt_marketplace"  value="<%=Helper.correctNull((String)hshValues.get("txt_marketplace"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="25"></td>
            <td width="18%"><font	size="2" face="MS Sans Serif" >Distance from 
              the Farm</font></td>
            <td width="58%"> 
              <input type="text" name="txt_marketdistance"  value="<%=Helper.correctNull((String)hshValues.get("txt_marketdistance"))%>"  size="12%" onKeyPress="allowNumber(this)" maxlength="5">
              (KM)</td>
          </tr>
        </table></td>
    </tr>
    <tr> 
      <td rowspan="3"><font	size="2" face="MS Sans Serif" >Whether the Flock is 
        <select name="sel_flock" onChange="checkflock()">
          <option value="0" selected>select</option>
          <option value="1">Migratory</option>
          <option value="2">Range Fed</option>
          <option value="3">Stall Fed</option>
        </select>
        </font></td>
      <td colspan="8" id="r1"><font	size="2" face="MS Sans Serif" > Migration 
        Pattern 
        <input type="text" name="txt_migrationpattern"  value="<%=Helper.correctNull((String)hshValues.get("txt_migrationpattern"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="40">
        </font></td>
    </tr>
    <tr> 
      <td colspan="8" id="r2"><font	size="2" face="MS Sans Serif" > availibility 
        of Grazing Land 
<input type="text" name="txt_grazingpattern"  value="<%=Helper.correctNull((String)hshValues.get("txt_grazingpattern"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="40">
        </font></td>
    </tr>
    <tr> 
      <td colspan="8" id="r3"><font	size="2" face="MS Sans Serif" > Arrangement 
        for supply of Green Fodder 
<input type="text" name="txt_greenfodder"  value="<%=Helper.correctNull((String)hshValues.get("txt_greenfodder"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="40">
        </font></td>
    </tr>
    <tr> 
      <td><font	size="2" face="MS Sans Serif" >Veterinary Aid Expenses</font></td>
      <td colspan="8"><font	size="2" face="MS Sans Serif" >Place 
        <input type="text" name="txt_vtaidplace"  value="<%=Helper.correctNull((String)hshValues.get("txt_vtaidplace"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="20">
        Distance From Farm 
        <input type="text" name="txt_distancefarm"  value="<%=Helper.correctNull((String)hshValues.get("txt_distancefarm"))%>"  size="12%" onKeyPress="allowNumber(this)" maxlength="9">
        (KM)</font></td>
    </tr>
    <tr> 
      <td nowrap><font	size="2" face="MS Sans Serif" >Marketing of Animals/wool</font></td>
      <td colspan="8"><font	size="2" face="MS Sans Serif" >Place 
        <input type="text" name="txt_woolplace"  value="<%=Helper.correctNull((String)hshValues.get("txt_woolplace"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="20">
        Distance From Farm 
        <input type="text" name="txt_distancewool"  value="<%=Helper.correctNull((String)hshValues.get("txt_distancewool"))%>"  size="12%" onKeyPress="allowNumber(this)" maxlength="9">
        (KM) </font></td>
    </tr>
    <tr> 
      <td colspan="9"><font	size="2" face="MS Sans Serif" >Who Will take care 
        of the Animal 
        <select name="sel_care" onChange="">
          <option value="0" selected>select</option>
          <option value="1">Self with Family members</option>
          <option value="2">Employees/Labourers</option>
        </select>
        </font></td>
    </tr>
    <tr>
      <td colspan="9"><table width="100%" border="1" cellspacing="0" cellpadding="3">
          <tr> 
            <td colspan="4" align="center"><font	size="2" face="MS Sans Serif" ><strong>No. 
              of Animals sold each year</strong></font></td>
          </tr>
          <tr> 
            <td width="28%"><font	size="2" face="MS Sans Serif" ><strong>Project 
              Year</strong></font></td>
            <td width="27%"><strong>No. of Units</strong></td>
            <td width="20%"><font	size="2" face="MS Sans Serif" ><strong>Project 
              Year</strong></font></td>
            <td width="25%"><strong>No. of Units</strong></td>
          </tr>
          <tr> 
            <%
						
				if (arryRow1.size() != 0) {
				arryCol1 = (ArrayList) arryRow1.get(1);
				
				if (arryCol1.size() != 0) {
					 
					u1 = Helper.correctNull((String) arryCol1.get(0));
				
				}
			
			} else if (arryRow1.size() == 0) {
				u1 = "";
			
			
			}

			%>
            <td>1 <font	size="2" face="MS Sans Serif" >Year</font></td>
            <td><font	size="2" face="MS Sans Serif" ><%=u1%></font></td>
            <%
						
				if (arryRow1.size() != 0) {
				arryCol1= (ArrayList) arryRow1.get(4);
				
				if (arryCol1.size() != 0) {
					 
					u4 = Helper.correctNull((String) arryCol1.get(0));
				
				}
			
			} else if (arryRow1.size() == 0) {
				u4 = "";
			
			
			}

			%>
            <td>4 <font	size="2" face="MS Sans Serif" >Year</font></td>
            <td><font	size="2" face="MS Sans Serif" ><%=u4%></font></td>
          </tr>
          <tr> 
            <%
						
				if (arryRow1.size() != 0) {
				arryCol1= (ArrayList) arryRow1.get(2);
				
				if (arryCol1.size() != 0) {
					 
					u2 = Helper.correctNull((String) arryCol1.get(0));
				
				}
			
			} else if (arryRow1.size() == 0) {
				u2 = "";
			
			
			}

			%>
            <td>2 <font	size="2" face="MS Sans Serif" >Year</font></td>
            <td><font	size="2" face="MS Sans Serif" ><%=u2%></font></td>
            <td>5 <font	size="2" face="MS Sans Serif" >Year</font></td>
            <%
						
				if (arryRow1.size() != 0) {
				arryCol1 = (ArrayList) arryRow1.get(5);
				
				if (arryCol1.size() != 0) {
					 
					u5 = Helper.correctNull((String) arryCol1.get(0));
				
				}
			
			} else if (arryRow1.size() == 0) {
				u5 = "";
			
			
			}

			%>
            <td><font	size="2" face="MS Sans Serif" ><%=u5%></font></td>
          </tr>
          <tr> 
            <%
						
				if (arryRow1.size() != 0) {
				arryCol1 = (ArrayList) arryRow1.get(3);
				
				if (arryCol1.size() != 0) {
					 
					u3= Helper.correctNull((String) arryCol1.get(0));
				
				}
			
			} else if (arryRow1.size() == 0) {
				u3 = "";
			
			
			}

			%>
            <td>3 <font	size="2" face="MS Sans Serif" >Year</font></td>
            <td><font	size="2" face="MS Sans Serif" ><%=u3%></font></td>
            <td>6 <font	size="2" face="MS Sans Serif" >Year</font></td>
            <%
						
				if (arryRow1.size() != 0) {
				arryCol1 = (ArrayList) arryRow1.get(6);
				
				if (arryCol1.size() != 0) {
					 
					u6 = Helper.correctNull((String) arryCol1.get(0));
				
				}
			
			} else if (arryRow1.size() == 0) {
				u6 = "";
			
			
			}

			%>
            <td><font	size="2" face="MS Sans Serif" ><%=u6%></font></td>
          </tr>
          <tr> 
            <td colspan="4" align="center"><font	size="2" face="MS Sans Serif" ><strong>Net 
              Income from the unit</strong></font></td>
          </tr>
          <tr> 
            <td ><font	size="2" face="MS Sans Serif" ><strong>Project Year</strong></font></td>
            <td ><font	size="2" face="MS Sans Serif" ><strong>Amount(Rs.)</strong></font></td>
            <td ><font	size="2" face="MS Sans Serif" ><strong>Project Year</strong></font></td>
            <td ><font	size="2" face="MS Sans Serif" ><strong>Amount(Rs.)</strong></font></td>
          </tr>
          <tr> 
            <td >1 <font	size="2" face="MS Sans Serif" >Year</font></td>
            <td ><%=Helper.correctNull((String)hshValues.get("totiyearincome"))%></td>
            <td >4 <font	size="2" face="MS Sans Serif" >Year</font></td>
            <td ><%=Helper.correctNull((String)hshValues.get("totivyearincome"))%></td>
          </tr>
          <tr> 
            <td >2 <font	size="2" face="MS Sans Serif" >Year</font></td>
            <td ><%=Helper.correctNull((String)hshValues.get("totiiyearincome"))%></td>
            <td >5 <font	size="2" face="MS Sans Serif" >Year</font></td>
            <td ><%=Helper.correctNull((String)hshValues.get("totvyearincome"))%></td>
          </tr>
          <tr>
            <td >3 <font	size="2" face="MS Sans Serif" >Year</font></td>
            <td ><%=Helper.correctNull((String)hshValues.get("totiiiyearincome"))%></td>
            <td >6 <font	size="2" face="MS Sans Serif" >Year</font></td>
            <td ><%=Helper.correctNull((String)hshValues.get("totviyearincome"))%></td>
          </tr>
        </table></td>
    </tr>
  </table>
  <br>
<br>
						<table width="12%" border="1" align="center" cellpadding="0"
							cellspacing="0" bordercolorlight="#8F8369"
							bordercolordark="#FFFFFB" class="outertablecolor">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="2">
									<tr valign="top">
																				<td align="center"><input type="button" name="cmdedit"
											value="Edit"
											style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
											class="buttoncolor" onClick="doEdit()">
										</td>
										<td align="center">
										<input type="button" name="cmdapply" value="Save" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
											class="buttoncolor" onClick="doSave()">
										</td>
										<td align="center"><input type="button" name="cmdcancel"
											value="Cancel"
											style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
											class="buttoncolor" onClick="doCancel()" >
										</td>
										<td><input type="button" name="cmddel"
											value="Delete"
											style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
											class="buttoncolor"  onClick="doDelete()"></td>
										<td><input type="button" name="cmdhelp2"
											value="Help"
											style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
											 ></td>
										<td><input type="button" name="cmdclose"
											value="Close"
											style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
											onClick="doClose()" ></td>
										 
									</tr>
								</table>
								</td>
							</tr>
						</table>
		<%String strappno = request.getParameter("appno");%>

		<td><input type="hidden" name="hidAction">
		<input type="hidden" name="hidAction1"> 
			<input type="hidden" name="hidAction2">
		<input type="hidden"
			name="hidBeanId" value=""> <input type="hidden"
			name="hidBeanMethod" value=""> <input type="hidden"
			name="hidBeanGetMethod" value=""> <input type="hidden"
			name="hidSourceUrl" value=""> <input type="hidden" name="hidApp_type"
			value="A"> <input type="hidden" name="hidflag" value=""> <input
			type="hidden" name="hideditflag"> <input type="hidden" name="selsno"
			value=""> <input type="hidden" name="hidval">  <input
			type="hidden" name="page">  
		 <input
			type="hidden" name="radLoan" value="Y">  <input
			type="hidden" name="app_status" value="<%=app_status%>">  <input type="hidden"
			name="hid_sno"
			value="<%=Helper.correctNull((String)hshValues.get("strid"))%>">
</form>
</body>
</html>


