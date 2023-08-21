<%@include file="../share/directives.jsp"%>
<%
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
arrRow=(ArrayList)hshValues.get("arrRow");
String Valuesin=Helper.correctNull((String) request.getParameter("valuesin"));
%>
<html>
<head>
<title>Modification in Sanction Terms</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varorg_level="<%=Helper.correctNull((String)hshValues.get("remarksorglevel"))%>";

function placeValues()
{
	disableFields(true);
	if(varorg_level!="")
	{
		document.forms[0].sel_sanction.value=varorg_level;
	}
	else
	{
		document.forms[0].sel_sanction.value="S";
	}
	
	  enableButtons(false,true,true,true,true,false);
	
}

function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			 if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			else if(document.forms[0].elements[i].type=="select-one")
			{
			  document.forms[0].elements[i].disabled=val;		  
			}
		}
	}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="modsancterms"
		document.forms[0].hidBeanGetMethod.value="getRecommendationData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/commst_recommendations.jsp";
		document.forms[0].submit();
	 }
	
}
function doDelete()
{
	
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="modsancterms"
		document.forms[0].hidBeanMethod.value="updateRecommendationData";
		document.forms[0].hidBeanGetMethod.value="getRecommendationData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/commst_recommendations.jsp";
 		document.forms[0].submit();
	 }
}
function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;

}

function doNew()
{
		disableFields(false);
		enableButtons(true,true,false,false,false,false);
		document.forms[0].hidAction.value="insert";
}

function doEdit()
{
	disableFields(false);
	enableButtons(true,true,false,false,false,true)
	document.forms[0].hidAction.value="update";
}


function doSave()
{
	if(document.forms[0].sel_sanction.value=="S")
	{
		alert('Select Terms of Sanction');
		document.forms[0].sel_sanction.focus();
		return;
	}
	if(trim(document.forms[0].txt_stipulated.value)=="")
	{
		alert('Enter Stipulated Earlier');
		document.forms[0].txt_stipulated.focus();
		return;
	}
	document.forms[0].hidBeanId.value="modsancterms"
	document.forms[0].hidBeanMethod.value="updateRecommendationData";
	document.forms[0].hidBeanGetMethod.value="getRecommendationData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/commst_recommendations.jsp";
	document.forms[0].submit();
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
	
}


function palceValues(val1,val2,val3)
{
	document.forms[0].sel_sanction.value=val1;
	document.forms[0].hidsno.value=val2;
	document.forms[0].txt_stipulated.value=document.getElementById("hidstipulated"+val3).value;
	document.forms[0].txt_ROrecmd.value=document.getElementById("hidROrecmd"+val3).value;
	document.forms[0].txt_COrecmd.value=document.getElementById("hidCOrecmd"+val3).value;
	
	if(document.forms[0].btnenable.value=='Y')
	{
		enableButtons(true,false,true,true,true,false);
	}
	else
	{
		enableButtons(true,true,true,true,true,false);
	}
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onload="placeValues()">
<form name="recommendation" method="post" class="normal">
<lapstab:applurllinksmst pageid="7"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1"><tr><td class="page_flow">
Corporate &amp; SME -&gt;  Modification in Sanction Terms -&gt; Recommendations
</td>
</tr>
</table>
<lapschoice:MSTApplications/>
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
<tr>
<td valign="top"> 
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable border1">
<tr>
<td valign="top"> 
  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
    <tr align="center">
      <td colspan="2" align="center" class="mantatory"><b>With Regard to Margin and Securities</b></td>
    </tr>
    <tr>
    	<td colspan="2">&nbsp;</td>
    </tr>
    <tr> 
      <td width="52%">Terms of Sanction&nbsp;
              <select name="sel_sanction" >
          <option value="S" selected="selected">&lt;---Select---&gt;</option>
          <option value="1">Margin</option>
          <option value="2">Primary security</option>
          <option value="3">Collateral security</option>
          <option value="4">Personal / Corporate Guarantees</option>
          <option value="5">Others</option>
        </select>
      
      
      </td>
      <td width="48%">&nbsp;</td> 
    </tr>
    <tr> 
      <td  colspan="2">&nbsp;</td>
    </tr>
    <tr>
	    <td width="52%">Stipulated Earlier</td> 
		<td>&nbsp;</td>
     </tr>
    <tr> 
	  <td width="52%"> 
        <textarea name="txt_stipulated" cols="80" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea>
      </td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr> 
      <td>Recommended by Branch/RO/FGMO</td>
      <td>Recommended by CO</td>
    </tr>
    <tr> 
      <td> 
        <textarea name="txt_ROrecmd" cols="80" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ></textarea>
      </td>
      <td> 
        <textarea name="txt_COrecmd" cols="80" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ></textarea>
      </td>
    </tr>
    <tr> 
      <td colspan="2">&nbsp;</td>
    </tr>
   </table>
   </td>
   </tr>
   </table>
   <br>

<lapschoice:combuttonnew btnnames="New_Edit_Save_Delete_Cancel" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<br> 
     <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr class="dataheader"> 
            <td width="2%">&nbsp; </td>
            <td width="12%" align="center"><b> Terms of Sanction</b></td>
            <td width="28%" align="center"><b> Stipulated 
              Earlier</b></td>
            <td width="31%" align="center"><b> Recommended 
              by Branch/RO/FGMO</b></td>
            <td width="27%" align="center"><b>Recommended 
              by CO</b></td>
          </tr>
          <%
		if(arrRow!=null && arrRow.size()>0)
		{
			for(int i=0; i<arrRow.size();i++)
			{
				arrCol=(ArrayList)arrRow.get(i);
				
				String strTerms = Helper.correctNull((String)arrCol.get(0));
				if(strTerms.equalsIgnoreCase("S"))
				{
					strTerms="";
				}
				else if(strTerms.equalsIgnoreCase("1"))
				{
					strTerms="Margin";
				}
				else if(strTerms.equalsIgnoreCase("2"))
				{
					strTerms="Primary security";
				}
				else if(strTerms.equalsIgnoreCase("3"))
				{
					strTerms="Collateral security";
				}
				else if(strTerms.equalsIgnoreCase("4"))
				{
					strTerms="Personal / Corporate Guarantees";
				}
				else if(strTerms.equalsIgnoreCase("5"))
				{
					strTerms="Others";
				}	
				
	%>
          <tr  valign="top" class="outertable"> 
            <td width="2%"> 
              <input type="radio" name="rdosec" onclick="palceValues('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(1))%>','<%=i%>')" style="border:none">
              <input type="hidden" name="hidstipulated<%=i%>" value="<%=Helper.correctDoubleQuotesHtml((String)arrCol.get(2))%>">
              <input type="hidden" name="hidROrecmd<%=i%>" value="<%=Helper.correctDoubleQuotesHtml((String)arrCol.get(3))%>">
              <input type="hidden" name="hidCOrecmd<%=i%>" value="<%=Helper.correctDoubleQuotesHtml((String)arrCol.get(4))%>">
            </td>
            <td width="12%"><%=strTerms%></td>
            <td width="28%"><%=Helper.correctNull((String)arrCol.get(2))%></td>
            <td width="31%" ><%=Helper.correctNull((String)arrCol.get(3))%></td>
            <td width="27%"><%=Helper.correctNull((String)arrCol.get(4))%></td>
          </tr>
          <%
			}
		}
	%>
        </table>
      </td>
    </tr>
    </table>
                              
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
 <input type="hidden" name="hidsno" />
</form>
</body>
</html>

