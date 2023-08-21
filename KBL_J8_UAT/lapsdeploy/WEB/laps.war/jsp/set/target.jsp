<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="objValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<html>
<head>
<title>Target - Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/set/prodmaster.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script>
var mode ="load";
var path ="<%=ApplicationParams.getAppUrl()%>";
var strAction ="<%=(String)objValues.get("action")%>";
var strMsg ="<%=(String)objValues.get("Msg")%>";

function callNew()
{
	mode = "new";
	document.forms[0].txtcat_name.disabled = false;
	document.forms[0].rad[0].disabled = false;
	document.forms[0].rad[1].disabled = false;
	document.forms[0].txtcat_name.focus();
	document.forms[0].butapply.disabled = false;
	document.forms[0].butnew.disabled = true;
	document.forms[0].butedit.disabled = true;
	document.forms[0].butcancel.disabled = false;
	document.forms[0].buthelp.disabled = false;
	document.forms[0].butclose.disabled = true;
	document.forms[0].selProd.disabled = false;
	document.forms[0].selmainhead.disabled = false;
	getFocus();
}

function typevalue()
	{
	document.forms[0].type.value=document.forms[0].selmainhead.value;
	}

function getFocus()
{
	if (document.forms[0].rad[0].checked == true)
	{
		document.forms[0].txtcat_name.focus();
	}
	else if (document.forms[0].rad[1].checked == true)
	{
       document.forms[0].selProd.focus();
	}
}

function callEdit()
{
	mode ="edit";
	document.forms[0].txtcat_name.disabled = true;
	document.forms[0].butnew.disabled = true;
	document.forms[0].butapply.disabled = false;
	document.forms[0].butcancel.disabled = false;
	document.forms[0].butdelete.disabled = false;
	document.forms[0].butedit.disabled = true;
	document.forms[0].butclose.disabled = true;
	document.forms[0].selProd.disabled = false;
	document.forms[0].rad[0].disabled = true;
	document.forms[0].rad[1].disabled = true;
	document.forms[0].selmainhead.disabled = false;
}


function loadPage()
{
	for (i=0;i<document.forms[0].elements.length;i++)
	{
		document.forms[0].elements[i].disabled = true;
	}
	document.forms[0].butnew.disabled = false;
	document.forms[0].butedit.disabled = false;
	document.forms[0].buthelp.disabled = false;
	document.forms[0].butclose.disabled = false;
	document.forms[0].rad[0].disabled = false;
	document.forms[0].rad[1].disabled = false;
	document.forms[0].rad[0].checked = true;
	document.forms[0].selmainhead.disabled = false;
	document.forms[0].txtcat_name.value="";
	showFields1();
}

function showFields1()
{
	if (document.forms[0].rad[0].checked == true)
	{
	  	document.all.categ.style.visibility ="visible";   
		document.all.subcateg.style.visibility="hidden";
		catLabel1();

	}
	else
	{
		document.all.categ.style.visibility ="visible";   
		document.all.subcateg.style.visibility="visible";
		catLabel1();
		document.forms[0].selProd.selectedIndex =0;
	}
	document.forms[0].txtcat_name.value="";
}

function catLabel1()
{
	if(document.forms[0].rad[1].checked==true)
	{
		document.all.catlab.innerHTML="<font size='1' face='MS Sans Serif'>Account Head</font>";
	}
	else if(document.forms[0].rad[0].checked==true)
	{
		document.all.catlab.innerHTML="<font size='1' face='MS Sans Serif'>Sub Head</font>";
	}
}

function submitData1()
{
if(document.forms[0].selmainhead.value=="0")
{
ShowAlert("111","Main Head");
document.forms[0].selmainhead.focus();
return;
}
else
{
  if(document.forms[0].rad[0].checked == true)
  {
     if (document.forms[0].txtcat_name.value !="")
	 {
		doSave();
	 }
	 else
	 {
		if (mode == "edit")
		{
			ShowAlert("111","Sub Head");
		}
		else if (mode == "new")
		{
			ShowAlert("112","Sub Head");
			document.forms[0].txtcat_name.disabled = false;
			document.forms[0].txtcat_name.focus();
		}
	 }
  }
  else if(document.forms[0].rad[1].checked == true)
  {
	 if (document.forms[0].txtcat_name.value !="" && document.forms[0].selProd.selectedIndex != 0)
	 {
		doSave();
	 }
	 else if (document.forms[0].selProd.selectedIndex == 0)
	 {
		ShowAlert("111","Sub Head");
		document.forms[0].selProd.disabled = false;
		document.forms[0].selProd.focus();
	 }
	 else if (document.forms[0].txtcat_name.value =="")
	 {
		if (mode == "edit")
		{
			ShowAlert("111","Account Head");
		}
		else if (mode == "new")
		{
			ShowAlert("112","Account Head");
			document.forms[0].txtcat_name.disabled = false;
			document.forms[0].txtcat_name.focus();
		}
	 }	
  }
 }
}


function doSave()
{
	for (i=0;i<document.forms[0].elements.length;i++)
	{
		document.forms[0].elements[i].disabled = false;
	}
	document.forms[0].action=path+"controllerservlet";
	if (mode == "new")
	{
		document.forms[0].hidAction.value="INSERT";
		if (document.forms[0].rad[0].checked == true)
		{
			document.forms[0].hidcat_parent.value ="0";
		}
	}
	else if (mode == "edit")
	{
		document.forms[0].hidAction.value="UPDATE";
	}
	document.forms[0].butapply.disabled = true;
	document.forms[0].hidBeanId.value="targetmaster";
	document.forms[0].hidBeanMethod.value="updateData";
	document.forms[0].hidSourceUrl.value="/action/target.jsp";
	document.forms[0].submit();
}

</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/set/headmenu.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/set/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/set/keytrap.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" onLoad ="loadPage();showMsg()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="myfrm" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colSpan=5> 
              <jsp:include page="../share/help.jsp" flush="true"/>
            </td>
          </tr>
          <tr>
            <!-- <td valign="top" colSpan=5><font face="Times New Roman" size="3"><b><i>Home -&gt; Setup -&gt; Retail Products -&gt; Master </i></b></font></td> -->
          </tr>
        </table>		
      </td>
    </tr>
 </table>
  <br>
  <br>
  <table width="90%" border="1" cellspacing="0" cellpadding="10" align="center" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
    <tr> 
      <td>
        <table width="100%" border="1" cellspacing="0" cellpadding="5" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0" height="8" align="center">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr> 
                        <td colspan="4" height="2"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr> 
                              <td colspan="10"> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" height="67">
                                  <tr> 
                                    <td> 
                                      <table width="100%" border="0" cellspacing="0" cellpadding="3">
                                        <tr> 
                                          <td bgcolor="#71694F" colspan="2"><b><font  color="#FFFFFF">Target Details</font></b></td>
                                        </tr>
                                        <tr> 
                                          <td colspan="2"> 
                                            <table width="100%" border="0" cellspacing="0" cellpadding="5">
                                              <tr> 
                                                <td colspan="2"> 
                                                  <table width="35%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr> 
                                                      <td width="35%">&nbsp;</td>
                                                      <td width="8%">&nbsp;</td>
                                                      <td width="10%" align="right" >&nbsp;</td>
                                                      <td width="35%">&nbsp;</td>
                                                      <td width="12%">&nbsp;</td>
                                                    </tr>
                                                    <tr> 
                                                      <td width="35%"><font size="1" face="MS Sans Serif" >Sub Head</font></td>
                                                      <td width="8%"> 
                                                        <input type="radio" name="rad" value="radiobutton" onClick="showFields1()" style="border-style:none" maxlength="75" >
                                                      </td>
                                                      <td width="10%" align="right" >&nbsp;</td>
                                                      <td width="35%"><font size="1" face="MS Sans Serif">Account Head</font></td>
                                                      <td width="12%"> 
                                                        <input type="radio" name="rad" value="radiobutton" onClick="showFields1()" style="border-style:none" maxlength="75" >
                                                      </td>
                                                    </tr>
                                                  </table>
                                                </td>
                                              </tr>
                                              <tr > 
                                                <td width="28%" >Main Head</td>
                                                <td width="72%">
                                                <select
							name="selmainhead" tabindex="3"
							onchange="getsubhead()">
                        <option value="0" selected><--Select--></option>
                        <option value="E">Export Advance
                        </option>
                        <option value="P">Priortiy Sector Advances
                        </option>
                        <option value="R">Retail Lending
                        </option>
                      </select>
                                                
                                                </td>
                                              </tr>
                                              <tr id ="subcateg" style="visibility:hidden"> 
                                                <td width="28%" id="subcatlab" height="50"><font size="1" face="MS Sans Serif">Sub Head 
                                                  </font></td>
                                                <td width="72%" height="50"> 
                                                  <select name="selProd" style="width:350" onChange="getValue()">
                                                    <option selected value="0">--Select--</option>
                                                    <%
                                                    
											  HashMap h = new HashMap();
											  h.put("value","parent");
											  h.put("parent","0");
											  h.put("hidMethod","getmainhead");
											  
											  HashMap hp1 = new HashMap();
											   hp1.put("BeanId","productcat");
											   hp1.put("MethodName","getData");
											   hp1.put("BeanParam",h);
											  %>
                                                    <laps:selecttag1 value='<%= hp1%>' /> 
                                                  </select>
                                                </td>
                                              </tr>
                                              <tr id="categ"> 
                                                <td width="28%" id="catlab" height="50"><font size="1" face="MS Sans Serif">Sub Head 
                                                  </font></td>
                                                <td width="72%" height="50"> 
                                                  <input type="text" name="txtcat_name" size="75" maxlength="75" onBlur="JavaScript:this.value =trim(this.value)" onKeyPress="notAllowSingleQuote()">
                                                  <b><span onClick="showProduct()" style="cursor:hand"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
												 border="0"></span></b> 
                                                </td>
                                              </tr>
                                              <tr > 
                                                <td width="28%">&nbsp;</td>
                                                <td width="72%">&nbsp;</td>
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
  <br>
  <table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr> 
      <td height="21"> 
        <table width="100%" cellspacing="0" cellpadding="2" align="center">
          <tr valign="top"> 
            <td align="center"> 
                <input type="button" name="butnew" value="New" class="buttonStyle" onClick="callNew()">
            </td>
            <td align="center"> 
                <input type="button" name="butedit" value="Edit" class="buttonStyle" onClick="callEdit()">
            </td>
            <td align="center"> 
                <input type="button" name="butapply" value="Save" class="buttonStyle" onClick="submitData1()">
            </td>
            <td align="center"> 
                <input type="button" name="butcancel" value="Cancel" class="buttonStyle" onClick="callCancel()">
             </td>
            <td align="center"> 
                <input type="button" name="butdelete" value="Delete" class="buttonStyle" onClick="callDelete()">
            </td>
            <td width="9%"> 
              <input type="button" name="buthelp" value="Help" class="buttonHelp" onClick="dohlp()">
            </td>
            <td align="center"> 
                <input type="button" name="butclose" value="Close" class="buttonClose" onClick="doClose()">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <input type="hidden" name="hidBeanId" >
   <input type="hidden" name="hidMethod" >
<input type="hidden" name="hidSourceUrl" >
<input type="hidden" name="hidBeanGetMethod" >
<input type="hidden" name="hidBeanMethod" >
<input type="hidden" name="hidAction" >
<input type="hidden" name="hidcat_id" >
<input type="hidden" name="hidcat_parent" value="0">
<input type="hidden" name="type">
</form>
<br>
</body>
</html>
