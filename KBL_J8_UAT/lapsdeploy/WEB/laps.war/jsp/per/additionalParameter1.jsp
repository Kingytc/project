<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<laps:handleerror />
<%

String flag="false";
if(hshValues.get("flag")!=null)
{

	flag="true";
	
}
%>
<html>
<script type="text/javascript">
var appUrl =  "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";



function placevalues()
{
	    disableFields(true);
		enableButtons(false,true,true,false,false,true);
//		document.forms[0].appno1.value=<%//=Helper.correctNull((String)hshValues.get("hidappno")))%>;
	
	
	var a="<%=Helper.correctNull((String)hshValues.get("sel_subsector"))%>";
	
	if(a!="")
	{
		document.forms[0].sel_subsector.value=a;
	}
	else
	{
		document.forms[0].sel_subsector.value="0";
	}
	var b="<%=Helper.correctNull((String)hshValues.get("sel_advance"))%>";
	
	if(b!="")
	{
		document.forms[0].sel_advance.value=b;
	}
	else
	{
		document.forms[0].sel_advance.value="0";
	}
	var c="<%=Helper.correctNull((String)hshValues.get("sel_statusflag"))%>";
	
	if(c!="")
	{
		document.forms[0].sel_statusflag.value=c;
	}
	else
	{
		document.forms[0].sel_statusflag.value="0";
	}
	var d="<%=Helper.correctNull((String)hshValues.get("sel_occpcode"))%>";
	
	if(d!="")
	{
		document.forms[0].sel_occpcode.value=d;
	}
	else
	{
		document.forms[0].sel_occpcode.value="0";
	}
	var e="<%=Helper.correctNull((String)hshValues.get("sel_sanctionlevel"))%>";
	
	if(e!="")
	{
		document.forms[0].sel_sanctionlevel.value=e;
	}
	else
	{
		document.forms[0].sel_sanctionlevel.value="0";
	}
	var f="<%=Helper.correctNull((String)hshValues.get("sel_oprationmode"))%>";
	
	if(f!="")
	{
		document.forms[0].sel_oprationmode.value=f;
	}
	else
	{
		document.forms[0].sel_oprationmode.value="0";
	}
	var g="<%=Helper.correctNull((String)hshValues.get("sel_sanctionauthority"))%>";
	
	if(g!="")
	{
		document.forms[0].sel_sanctionauthority.value=g;
	}
	else
	{
		document.forms[0].sel_sanctionauthority.value="0";
	}
	var h="<%=Helper.correctNull((String)hshValues.get("sel_sectorcode"))%>";
	
	if(h!="")
	{
		document.forms[0].sel_sectorcode.value=h;
	}
	else
	{
		document.forms[0].sel_sectorcode.value="0";
	}
	var i="<%=Helper.correctNull((String)hshValues.get("sel_DP"))%>";
	
	if(i!="")
	{
		document.forms[0].sel_DP.value=i;
	}
	else
	{
		document.forms[0].sel_DP.value="0";
	}
	var j="<%=Helper.correctNull((String)hshValues.get("sel_intrrate"))%>";
	
	if(j!="")
	{
		document.forms[0].sel_intrrate.value=j;
	}
	else
	{
		document.forms[0].sel_intrrate.value="0";
	}
	
	var k="<%=Helper.correctNull((String)hshValues.get("txt_solid"))%>";
	if(k!="")
	{
		document.forms[0].txt_solid.value=k;
	}
	else
	{
		document.forms[0].txt_solid.value="0";
	}
	
	var l="<%=Helper.correctNull((String)hshValues.get("sel_cust_status"))%>";
	if(l!="")
	{
		document.forms[0].sel_cust_status.value=l;
	}
	else
	{
		document.forms[0].sel_cust_status.value="0";
	}
	
	var m="<%=Helper.correctNull((String)hshValues.get("sel_purpose_advance"))%>";
	if(l!="")
	{
		document.forms[0].sel_purpose_advance.value=m;
	}
	else
	{
		document.forms[0].sel_purpose_advance.value="0";
	}
}

function disableFields(val)
	{
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
enableButtons(true,false,false,false,true,true)
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
		
		document.forms[0].hidBeanId.value="additionalParameter";
		document.forms[0].hidBeanGetMethod.value="getadditionalParameter1";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/additionalParameter1.jsp";
		document.forms[0].submit();
	 }
	
}
function doClose()
{	
	this.close();
	
}
function doSave()
{
		
		if("<%=flag%>"=="false")
		{
		document.forms[0].hidAction.value="insert";
		}else
		{
		
		document.forms[0].hidAction.value="update";
		
		}
		document.forms[0].cmdapply.disabled = true;
		document.forms[0].hidBeanId.value="additionalParameter";
		document.forms[0].hidBeanMethod.value="updateadditionalParameter1";
		document.forms[0].hidBeanGetMethod.value="getadditionalParameter1";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/additionalParameter1.jsp";
		document.forms[0].submit();
		
}

function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="additionalParameter";
		document.forms[0].hidBeanMethod.value="updateadditionalParameter1";
		document.forms[0].hidBeanGetMethod.value="getadditionalParameter1";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/additionalParameter1.jsp";
		document.forms[0].submit();
	 }
}

function sendToCBS()
{
	    document.forms[0].hidBeanId.value="FinacleBean";
		document.forms[0].hidBeanMethod.value="SanctionDetails";
		document.forms[0].hidBeanGetMethod.value="SanctionDetails";
		document.forms[0].hidSourceUrl.value="/action/appworkflowhistory.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();

}
</script>
<script  src= "<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src= "<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script  src= "<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>


<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000" onload="placevalues()">
<form  method = post>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td valign="bottom" align="center" height="49"><b>Sanction Particulars<br>
      <br>
      </b></td>
  </tr>
  
  </table>
<table width="100%" border="1" cellspacing="0" cellpadding="5" height="10%" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">

  <tr> 
    <td width="25%">Sol Id</td>
    <td width="20%">
      <select name="txt_solid">
      <%String apptype="10"; %>
      <laps:StaticDataNewTag apptype='<%=apptype%>'/>
      </select>
    </td>
    <td width="18%">Sub Sector Code</td>
    <td width="37%">
      <select name="sel_subsector">
      <%apptype="19"; %>
      <laps:StaticDataNewTag apptype='<%=apptype%>'/>
      </select>
    </td>
  </tr>
  <tr> 
    <td width="25%">Document Date</td>
    <td width="20%">
      <input type="text" name="txt_documentdate" value="<%=Helper.correctNull((String)hshValues.get("txt_documentdate"))%>">
    </td>
    <td width="18%">Occupation Code</td>
    <td width="37%">
      <select name="sel_occpcode">
      <%apptype="13"; %>
      <laps:StaticDataNewTag apptype='<%=apptype%>'/>
      </select>
    </td>
  </tr>
  <tr> 
    <td width="25%">Total EMI flows</td>
    <td width="20%">
      <input type="text" name="txt_emiflows" value="<%=Helper.correctNull((String)hshValues.get("txt_emiflows"))%>">
    </td>
    <td width="18%">Name of Advance</td>
    <td width="37%">
      <select name="sel_advance">
        <option value="S" selected>Secured</option>
        <option value="U">Unsecured</option>
        <option value="P">Partially Secured</option>
      </select>
    </td>
  </tr>
  <tr> 
    <td width="25%">Operative Account Number</td>
    <td width="20%">
      <input type="text" name="txt_opraccno" value="<%=Helper.correctNull((String)hshValues.get("txt_opraccno"))%>">
    </td>
    <td width="18%">Expiry Date</td>
    <td width="37%">
      <input type="text" name="txt_expirydate" value="<%=Helper.correctNull((String)hshValues.get("txt_expirydate"))%>">
    </td>
  </tr>
  <tr> 
    <td width="25%">Customer Status Flag</td>
    <td width="20%">
      <select name="sel_statusflag">
        <option value="O" selected>O</option>
        <option value="N">N</option>
      </select>
    </td>
    <td width="18%">Sanction Level</td>
    <td width="37%">
      <select name="sel_sanctionlevel">
      <%apptype="20"; %>
      <laps:StaticDataNewTag apptype='<%=apptype%>'/>
      </select>
    </td>
  </tr>
  <tr> 
    <td width="25%">Operation Mode</td>
    <td width="20%">
      <select name="sel_oprationmode">
      <% apptype="16"; %>
      <laps:StaticDataNewTag apptype='<%=apptype%>'/>
      </select>
    </td>
    <td width="18%">Sanction Authority</td>
    <td width="37%">
      <select name="sel_sanctionauthority">
      <% apptype="21"; %>
      <laps:StaticDataNewTag apptype='<%=apptype%>'/>
      </select>
    </td>
  </tr>
  <tr> 
    <td width="25%">Address Type</td>
    <td width="20%">
      <input type="text" name="txt_addrtype" value="<%=Helper.correctNull((String)hshValues.get("txt_addrtype"))%>">
    </td>
    <td width="18%">Sanction Reference</td>
    <td width="37%">
      <input type="text" name="txt_sanctionref" value="<%=Helper.correctNull((String)hshValues.get("txt_sanctionref"))%>">
    </td>
  </tr>
  <tr> 
    <td width="25%">Tax Slab</td>
    <td width="20%">
      <input type="text" name="txt_taxslab" value="<%=Helper.correctNull((String)hshValues.get("txt_taxslab"))%>">
    </td>
    <td width="18%">Drawing Power Indicator</td>
    <td width="37%">
      <select name="sel_DP">
        <option value="D" selected>Derived</option>
        <option value="E">Equal</option>
        <option value="M">Maintained</option>
        <option value="P">Parent</option>
      </select>
    </td>
  </tr>
  <tr> 
    <td width="25%">Interest Rate Code</td>
    <td width="20%">
      <select name="sel_intrrate">
      <% apptype="17"; %>
      <laps:StaticDataNewTag apptype='<%=apptype%>'/>
      </select>
    </td>
    <td width="18%">Customer Status</td>
    <td width="37%">
      <select name="sel_cust_status">
      <% apptype="15"; %>
      <laps:StaticDataNewTag apptype='<%=apptype%>'/>
      </select>
    </td>
  </tr>
  <tr> 
    <td width="25%">Sector Code</td>
    <td width="20%">
      <select name="sel_sectorcode">
      <% apptype="18"; %>
      <laps:StaticDataNewTag apptype='<%=apptype%>'/>
      </select>
    </td>
     <td width="18%">Customer Status</td>
    <td width="37%">
      <select name="sel_purpose_advance">
      <% apptype="22"; %>
      <laps:StaticDataNewTag apptype='<%=apptype%>'/>
      </select>
    </td>
  </tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
    
   
           
    <tr> 
      <td colspan="3"> 
        <%
		String strappno = request.getParameter("appno");		
		%>
        <laps:combuttons  apporgcode='<%=strappno%>' strSource=""/>
        </td>       
    </tr>
    <tr>
    <td colspan="3" align="center">
       <input type="button" value="SEND TO CBS" onClick="sendToCBS()"> 
       </td>
    </tr>
   </table>
   <input type="hidden" name="hidAction" value="">
  <input type="hidden" name="hidBeanId" value="">
  <input type="hidden" name="hidBeanMethod" value="">
  <input type="hidden" name="hidBeanGetMethod"  value="">
  <input type="hidden" name="hidSourceUrl" value="">
    <input type="hidden" name="hidAppType" value="R">
   <input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)hshValues.get("hidDemoId"))%>">
   </form>
</body>

</html>

