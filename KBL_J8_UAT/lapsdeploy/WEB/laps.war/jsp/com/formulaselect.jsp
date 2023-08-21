<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>

<%
	String strvalue="";
	strvalue=request.getParameter("cmano");
	String strCategory = Helper.correctNull((String)request.getParameter("lst_formula"));
	//out.println(strvalue);
	String strTextControl = Helper.correctNull((String)request.getParameter("TextControl"));
	String strHiddenControl = Helper.correctNull((String)request.getParameter("HiddenControl"));

%>

<HTML>
<HEAD>
<TITLE> List Of <%//=strvalue.substring(0,1).toUpperCase()+strvalue.substring(1,strvalue.length())%> </TITLE>
<META NAME="Generator" CONTENT="EditPlus">

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";


function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	window.opener.document.forms[0].cmdnew.disabled=bool1;
	window.opener.document.forms[0].cmdedit.disabled=bool2;
	window.opener.document.forms[0].cmdsave.disabled=bool3;
	window.opener.document.forms[0].cmdcancel.disabled=bool4;
	window.opener.document.forms[0].cmdclose.disabled=bool5;

}

function getFormula()
{
	document.forms[0].submit();
}

function doOk()
{
		
	if(document.forms[0].cho_rate.value!="")
	{
	;
		if(document.forms[0].HiddenControl.value!="" && document.forms[0].TextControl.value!="")
		{
		if(document.forms[0].cho_rate.value!="0")
		{
			window.opener.document.forms[0].elements["<%=strHiddenControl%>"].value = document.forms[0].cho_rate.value;
			window.opener.document.forms[0].elements["<%=strTextControl%>"].value = document.forms[0].cho_rate.options[document.forms[0].cho_rate.selectedIndex].text;
		}
		else
		{
		window.opener.document.forms[0].elements["<%=strHiddenControl%>"].value ="";
		window.opener.document.forms[0].elements["<%=strTextControl%>"].value ="";
		
		}	
			window.close();
		}
		else
		{
			show();
		}
	}
	else
	{
		alert("Select a value");
	}
}

function show()
{
	var val="";
	var id="";
	if (document.forms[0].cho_rate.value != "")
	{
		val=document.forms[0].cho_rate.options[document.forms[0].cho_rate.selectedIndex].text;
		id=document.forms[0].cho_rate.options[document.forms[0].cho_rate.selectedIndex].value;
		window.opener.document.forms[0].forname.value = val;	
		
		arr=id.split("::");
		window.opener.document.forms[0].rowid.value =arr[0];	
		window.opener.document.forms[0].txtformula.value=arr[1];
		window.opener.document.forms[0].formuladesc.value=arr[2];
		val=arr[3];
		
		if (val=="FI")
		{
			//window.opener.document.forms[0].choformula.selectedIndex=1;
			
			window.opener.document.forms[0].choformulatype.length=3;
			window.opener.document.forms[0].choformulatype.options[0].value="S";
			window.opener.document.forms[0].choformulatype.options[0].text="<-- Select -->";
			window.opener.document.forms[0].choformulatype.options[1].value="H";
			window.opener.document.forms[0].choformulatype.options[1].text="Higher";
			window.opener.document.forms[0].choformulatype.options[2].value="L";
			window.opener.document.forms[0].choformulatype.options[2].text="Lower";
			window.opener.document.forms[0].choformula.value=val;
		}
		else if(val=="RA")
		{
			//window.opener.document.forms[0].choformula.selectedIndex=2;
			window.opener.document.forms[0].choformulatype.length=3;
			window.opener.document.forms[0].choformulatype.options[0].value="S";
			window.opener.document.forms[0].choformulatype.options[0].text="<-- Select -->";
			window.opener.document.forms[0].choformulatype.options[1].value="H";
			window.opener.document.forms[0].choformulatype.options[1].text="Higher";
			window.opener.document.forms[0].choformulatype.options[2].value="L";
			window.opener.document.forms[0].choformulatype.options[2].text="Lower";
			window.opener.document.forms[0].choformula.value=val;
		}
		else if(val=="CA")
		{
			//window.opener.document.forms[0].choformula.selectedIndex=3;
			window.opener.document.forms[0].choformulatype.length=6;
			window.opener.document.forms[0].choformulatype.options[0].value="S";
			window.opener.document.forms[0].choformulatype.options[0].text="<-- Select -->";
			window.opener.document.forms[0].choformulatype.options[1].value="I";
			window.opener.document.forms[0].choformulatype.options[1].text="Increase";
			window.opener.document.forms[0].choformulatype.options[2].value="D";
			window.opener.document.forms[0].choformulatype.options[2].text="Decrease";
			window.opener.document.forms[0].choformulatype.options[3].value="GT";
			window.opener.document.forms[0].choformulatype.options[3].text="Group-Total";
			window.opener.document.forms[0].choformulatype.options[4].value="H";
			window.opener.document.forms[0].choformulatype.options[4].text="Higher";
			window.opener.document.forms[0].choformulatype.options[5].value="L";
			window.opener.document.forms[0].choformulatype.options[5].text="Lower";
			window.opener.document.forms[0].choformula.value=val;
		}
		else if(val=="FU")
		{
			//window.opener.document.forms[0].choformula.selectedIndex=4;

			window.opener.document.forms[0].choformulatype.length=9;
			window.opener.document.forms[0].choformulatype.options[0].value="S";
			window.opener.document.forms[0].choformulatype.options[0].text="<-- Select -->";
			window.opener.document.forms[0].choformulatype.options[1].value="I";
			window.opener.document.forms[0].choformulatype.options[1].text="Increase";
			window.opener.document.forms[0].choformulatype.options[2].value="D";
			window.opener.document.forms[0].choformulatype.options[2].text="Decrease";
			window.opener.document.forms[0].choformulatype.options[3].value="GT";
			window.opener.document.forms[0].choformulatype.options[3].text="Group-Total";
			window.opener.document.forms[0].choformulatype.options[4].value="NFL";
			window.opener.document.forms[0].choformulatype.options[4].text="Net Funds Lost";
			window.opener.document.forms[0].choformulatype.options[5].value="LTS";
			window.opener.document.forms[0].choformulatype.options[5].text="Long Term Sources";
			window.opener.document.forms[0].choformulatype.options[6].value="H";
			window.opener.document.forms[0].choformulatype.options[6].text="Higher";
			window.opener.document.forms[0].choformulatype.options[7].value="L";
			window.opener.document.forms[0].choformulatype.options[7].text="Lower";
			window.opener.document.forms[0].choformulatype.options[8].value="ID";
			window.opener.document.forms[0].choformulatype.options[8].text="Increase/Decrease";
			window.opener.document.forms[0].choformula.value=val;
		}
		else if(val=="MPBF1" || val=="MPBF2" || val=="PBF1" || val=="PBF2" || val=="PBF3" || val=="PBF4" || val=="TO")
		{
			//window.opener.document.forms[0].choformula.selectedIndex=5;
			window.opener.document.forms[0].choformulatype.length=6;
			window.opener.document.forms[0].choformulatype.options[0].value="S";
			window.opener.document.forms[0].choformulatype.options[0].text="<-- Select -->";
			window.opener.document.forms[0].choformulatype.options[1].value="I";
			window.opener.document.forms[0].choformulatype.options[1].text="Increase";
			window.opener.document.forms[0].choformulatype.options[2].value="D";
			window.opener.document.forms[0].choformulatype.options[2].text="Decrease";
			window.opener.document.forms[0].choformulatype.options[3].value="GT";
			window.opener.document.forms[0].choformulatype.options[3].text="Group-Total";
			window.opener.document.forms[0].choformulatype.options[4].value="H";
			window.opener.document.forms[0].choformulatype.options[4].text="Higher";
			window.opener.document.forms[0].choformulatype.options[5].value="L";
			window.opener.document.forms[0].choformulatype.options[5].text="Lower";
			window.opener.document.forms[0].choformula.value=val;
		}
		else
		{
			window.opener.document.forms[0].choformula.selectedIndex=0;
		}
	/*	if (val=="cv")
		{
			window.opener.document.forms[0].choformula.selectedIndex=0;
		}
		else
		{
			window.opener.document.forms[0].choformula.selectedIndex=1;
		}*/
		//window.opener.document.forms[0].choformula.value=val;//commented by mck
		window.opener.document.forms[0].choformulatype.value=arr[6];
		window.opener.document.forms[0].forcode.value=arr[4];
		window.close();
	}
	
	else
	{
		alert("Select a value");
	}
	
}

function doClose()
{
	window.close();
}

</script>
</HEAD>

<body >
<form name="selection" method="post" class="normal">

  <table border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
    <tr> 
        <td valign="top">
          <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
            <tr class="dataheader"> 
              
            <td colspan="2">
				<table width="100%" cellpadding="0" cellspacing="0" border="0" class="outertable">
					<tr>
					<td width="28%"><b>Formula For</b></td>
					
                  <td width="72%">
						<select name="lst_formula" onChange="getFormula()">
                                 <option value="" <%=strCategory.trim().equals("")?"selected":""%>><--Select--></option>
                                 <option value="FI" <%=strCategory.trim().equals("FI")?"selected":""%>>Financial</option>
                                 <option value="CA" <%=strCategory.trim().equals("CA")?"selected":""%>>CashFlow</option>
                                 <option value="FU" <%=strCategory.trim().equals("FU")?"selected":""%>>FundFlow</option>
                                 <option value="RA" <%=strCategory.trim().equals("RA")?"selected":""%>>Ratios</option>
                                 <option value="DSCR" <%=strCategory.trim().equals("DSCR")?"selected":""%>>DSCR</option>
                                 <option value="INV" <%=strCategory.trim().equals("INV")?"selected":""%>>Assessment - Inventory Norms</option>
                                 <option value="MU" <%=strCategory.trim().equals("MU")?"selected":""%>>Assessment - MPBF UPTO 25 CRORES</option>
                                 <option value="MA" <%=strCategory.trim().equals("MA")?"selected":""%>>Assessment - MPBF ABOVE 25 CRORES</option>
                                 <option value="FL" <%=strCategory.trim().equals("FL")?"selected":""%>>Assessment - Forex Limits</option> 							
						</select>
                  </td>
					
					</tr>
				</table>
			</td>
            </tr>
			<tr> 
                                <td align=center> 
                                  
              <select name="cho_rate" size=15 style="width:400" onDblClick="javascript:doOk()">
              <option value="0"><-------------------------------------------------------------DeSelect-----------------------------------------------></option>
                <laps:comFormula /> 
              </select>
                                  </td>
                              </tr></table></td></tr></table>
							  
<lapschoice:combuttonnew btnnames="Ok"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />	

<!-- <INPUT TYPE="hidden" name="cmano" value="<%//=strvalue%>"> -->
<input type="hidden" name="TextControl" value = "<%=strTextControl %>">
<input type="hidden" name="HiddenControl" value = "<%=strHiddenControl %>">
</form>
</BODY>
</HTML>
