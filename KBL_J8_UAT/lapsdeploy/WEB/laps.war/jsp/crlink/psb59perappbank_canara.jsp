<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
//out.println(hshValues);

//Vector vecRow = (Vector)hshValues.get("vecRow");
//Vector vecCol =  null;
ArrayList arrRow = (ArrayList)hshValues.get("arrRow");
ArrayList arrCol =  null;
String chkpage= (String)hshValues.get("chkpage");
String term ="";
%>
<html>
<head>
<title>Search Product</title>
<script>
var chkpage = "<%=chkpage%>"
function  show_submit(a,b,c,d,e,f)
{

//window.opener.document.forms[0].textto.value=loantype[0];
//window.opener.document.forms[0].txtbank_branchcode.value=a;
//window.opener.document.forms[0].txtbank_name.value=b;
//window.opener.document.forms[0].hidprddesc.value=loantype[2];
window.opener.document.forms[0].txtperapp_accno.value=d;
window.opener.document.forms[0].txtperapp_acctype.value=e;
//window.opener.document.forms[0].temp.value=e;
//window.opener.document.forms[0].txtbank_balance.value=f;
window.close();
}


function showtxt()
{
	if(document.forms[0].prd_range[0].checked == true)
	{
		document.all.range1.style.visibility="hidden";
		document.all.range2.style.visibility="hidden";
		document.all.range3.style.visibility="visible";
		document.all.range4.style.visibility="hidden";
		document.forms[0].textrng.maxLength = 30;
		document.forms[0].textrng.style.textAlign = "left";
		document.forms[0].textrng.focus();
	//	document.forms[0].hidprd_rng.value = "cat";
		
		
	}
	else if(document.forms[0].prd_range[1].checked == true)
	{
		document.all.range1.style.visibility="visible";
		document.all.range2.style.visibility="visible";
		document.all.range3.style.visibility="visible";
		document.all.range4.style.visibility="visible";
		document.forms[0].textrng.maxLength = 15;
		document.forms[0].textto.maxLength = 15;
		document.forms[0].textrng.style.textAlign = "right";
		document.forms[0].textto.style.textAlign = "right";
		document.forms[0].textrng.focus();
	//	document.forms[0].hidprd_cat.value = "";
	//	document.forms[0].hidprd_rng.value = "rng";
	
	}

}

function clears()
{
	document.forms[0].textrng.value ="";
	document.forms[0].textto.value ="";
}

function allowEntry(tmptxt)
{
	if(document.forms[0].prd_range[0].checked == true)
	{
		allowAlphabetsAndSpace();
	}
	else if(document.forms[0].prd_range[1].checked == true)
	{
		allowDecimals(tmptxt);
	}
}

function onClose()
{
	if( ConfirmMsg(100) )
	{
		window.close();
	}
}

</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 250;
  overflow: auto;
}
td{
	color:blue;
	font-family:"Ms sans serif";
	font-size:10;
}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
</head>

<body  text="#000000"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" class="bgcolor">
<form name="amtfrm">
   <table width="50%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#FFFFFB" bordercolordark="#8F8369" class="outertablecolor" >
    <tr> 
      <td > 
        <table width="50%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" >
          <tr> 
            <td valign="top"> 
              <table width="50%" border="0" cellspacing="0" cellpadding="5" align="center">
                <tr> 
                  <td colspan="3"> 
                    <table width="72%" border="0" cellspacing="0" cellpadding="0"  >
                      <tr> 
                        <td> 
                          <table width="50%" border="0" cellspacing="0" cellpadding="3">
                            <tr> 

<div>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" class="outertablecolor">
    <tr> 
      <td>  <fieldset style="width:800">
        <table width="100%" border="0" cellspacing="0" cellpadding="3"   bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
          <tr>
		     <td width="19%" class="tabactive">  
              <div  align="left"><b><font size="1" face="MS Sans Serif" color="#FFFFFF">Branch Code
			  </font></b></div>
            </td>
            <td width="19%" class="tabactive"> 
              <div  align="left"><b><font size="1" face="MS Sans Serif" color="#FFFFFF">Branch Name 
					</font></b></div>
            </td>
            <td width="19%" class="tabactive"> 
              <div  align="left"><b><font size="1" face="MS Sans Serif" color="#FFFFFF">Account No</font></b></div>
            </td>
			<td width="19%" class="tabactive"> 
              <div align="right"><b><font size="1" face="MS Sans Serif" color="#FFFFFF">Account Type</font></b></div>
            </td>
			<td width="19%" class="tabactive"> 
              <div align="right"><b><font size="1" face="MS Sans Serif" color="#FFFFFF">Balance</font></b></div>
            </td>
		</tr>
		</table></fieldset></td></tr></table></div>
		<div class="cellcontainer">
		  <table width="100%" border="0" cellspacing="0" cellpadding="3"   bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
	         <%
	 if(arrRow!=null && arrRow.size()>0)
		 {
			for(int i=0;i<arrRow.size();i++)
			{
				ArrayList	v = (ArrayList)arrRow.get(i);
				if(v.size() >0)
				{ 
			  %>
	
           <tr> 
		    <td width="0%" align="left" height="23"><b>
		    <a href = "javascript:show_submit('<%=Helper.correctNull((String)v.get(0))%>','<%=Helper.correctNull((String)v.get(1))%>',
		    								  '<%=Helper.correctNull((String)v.get(2))%>','<%=Helper.correctNull((String)v.get(3))%>',
		    								  '<%=Helper.correctNull((String)v.get(4))%>','<%=Helper.correctNull((String)v.get(5))%>')" 
		    					class = "blackfont"><%=Helper.correctNull((String)v.get(0))%>
		    </a></b></td>
		    <td width="19%" align="left" height="23"><%=Helper.correctNull((String)v.get(1))%></td>
		    <td width="19%" align="left" height="23"><%=Helper.correctNull((String)v.get(3))%></td>
			<td width="19%" align="right" height="23"><%=Helper.correctNull((String)v.get(4))%></td>
		   <td width="19%" align="right" height="23"><%=Helper.correctNull((String)v.get(5))%></td>
           </tr> 
			   <%
				}
			}
		}else
		{
			%>
				<tr>
			<td ><center><font face="MS Sans Serif" size="2" color="blue"><----- NO ACCOUNT INFO -----></font></center></td>
				</tr>
			<%
		}
			%>
         
		</table>
</div>

<!-- ssss- -->
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
                  </td>
                </tr>
              </table>
<br>
<table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr bordercolordark="#FFFFFB" bordercolorlight="#8F8369"> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertablecolor" >
          <tr valign="top">   
		   <td width="15%"> 
              <div align="center"> 
                <input type="button" name="cmdclose" value="Close" onClick="onClose()" style="width:50" class="buttoncolorclose">
              </div>
            </td>
          </tr>
        </table>
		</td>
		</tr>
		</table>
		<!--aaaa-->
		 
<input type="hidden" name="hidBeanId" value = "" >
<input type="hidden" name="hidSourceUrl"  value= "/action/perfinancialbnkacc.jsp">
<!-- <input type="hidden" name="hidBeanId" value = "" >
<input type="hidden" name="hidSourceUrl"  value=""> -->
<input type="hidden" name="hidBeanGetMethod" value ="">
<input type ="hidden" name="hidtype" value ="">
<input type ="hidden" name="hidrngfrom" value ="">
<input type ="hidden" name="hidrngto" value ="">
<input type ="hidden" name="hidflag" value ="">
<input type ="hidden" name="hidchkpage">
 </form>
</body>
</html>
