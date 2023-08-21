<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>

<%
String strvalue="";
strvalue =request.getParameter("val");
String strCategory = Helper.correctNull((String)request.getParameter("lst_formula"));
String par =Helper.correctNull((String)request.getParameter("par"));
%>
<HTML>
<HEAD>
<TITLE> List Of <%=strvalue.substring(0,1).toUpperCase()+strvalue.substring(1,strvalue.length())%> </TITLE>
<META NAME="Generator" CONTENT="EditPlus">

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


function doOk()
{
var val="";
var id="";
var opt="<%=strvalue%>";
var par ="<%=par%>";
if (document.forms[0].cho_rate.value != "")
	{
	val=document.forms[0].cho_rate.options[document.forms[0].cho_rate.selectedIndex].text;

	id=document.forms[0].cho_rate.options[document.forms[0].cho_rate.selectedIndex].value;
	

	if ( id == "0")
		{
		if (opt == "rowdesc")
			{ 
			window.opener.document.forms[0].rowdesc.value = "";	
			window.opener.document.forms[0].formula.value = "";	
			window.opener.document.forms[0].formulano.value = "";
			window.opener.document.forms[0].select_type.value = "S";	
			window.opener.document.forms[0].sno.value = "";	
			enableButtons(false,false,true,true,false,false);
			}

			if (opt == "formula")
			{
			window.opener.document.forms[0].formula.value = "";	
			window.opener.document.forms[0].formulano.value="";
			}
			if (opt == "formula2")
			{
			window.opener.document.forms[0].formula2.value = "";	
			window.opener.document.forms[0].formulano2.value="";
			} 

			if (opt == "cma")
			{
			window.opener.document.forms[0].cmaformat.value = "";	
			window.opener.document.forms[0].cmano.value="";
			window.opener.document.forms[0].tabtitle.value="";
			window.opener.document.forms[0].rowdesc.value="";
			window.opener.document.forms[0].select_type.value="S";
			window.opener.document.forms[0].formula.value="";
			window.opener.document.forms[0].formulano.value="";
			window.opener.document.forms[0].txtorder.value="";
			window.opener.document.forms[0].formulano2.value="";
			window.opener.document.forms[0].formula2.value="";
			
			window.opener.document.all.showfinind.style.visibility = "hidden";
			window.opener.document.forms[0].sel_finind.value = "S";
			window.opener.document.forms[0].sel_attach.value = "0";
			
			}
			if (opt == "tabtitle")
			{
			window.opener.document.forms[0].tabtitle.value = "";	
			window.opener.document.forms[0].select_type.value="S";
			window.opener.document.forms[0].formula.value="";
			window.opener.document.forms[0].formulano.value="";
			window.opener.document.forms[0].rowdesc.value="";
			window.opener.document.forms[0].txtorder.value="";
			window.opener.document.forms[0].formulano2.value="";
			window.opener.document.forms[0].formula2.value="";
			}
			if (opt == "ratingcma")
			{
				
			window.opener.document.forms[0].cmadesc.value = "";	
			window.opener.document.forms[0].cmano.value="";
			}

		}
	else
		{
		if (opt == "rowdesc")
		{
			
			window.opener.document.forms[0].rowdesc.value = val;	
			arr=id.split("^");
			if (arr[0] == "0")
			{
				arr[0]=""
			}
			if (arr[4] == "null")
			{
				arr[4]=""
			}
			window.opener.document.forms[0].formula.value = arr[0];	
			window.opener.document.forms[0].formulano.value = arr[1];
			window.opener.document.forms[0].select_type.value = arr[2];	
			window.opener.document.forms[0].sno.value = arr[3];	
			window.opener.document.forms[0].txtorder.value = arr[4];
			window.opener.document.forms[0].formulano2.value = arr[7];
			window.opener.document.forms[0].formula2.value = arr[8];
			enableButtons(false,false,true,true,false,false);

			
			if (arr[5] == "FI")
			{
				
				window.opener.document.all.attachid.style.visibility = "visible";
				window.opener.document.all.attachid.style.position="relative";
				window.opener.document.all.show_attach.style.visibility = "visible";
				
				if(arr[9] =="1")
				{	
					window.opener.document.all.showfinind.style.visibility = "visible";
					window.opener.document.forms[0].sel_attach.value = arr[9];
					window.opener.document.forms[0].sel_finind.value = arr[10];
				}
				else if(arr[9] =="" || arr[9] =="0")
				{	
					window.opener.document.all.showfinind.style.visibility = "hidden";
					window.opener.document.forms[0].sel_finind.value = "S";
					window.opener.document.forms[0].sel_attach.value = "0";
				}
			}
			else
			{	
				window.opener.document.all.attachid.style.visibility = "hidden";
				window.opener.document.all.attachid.style.position="absolute";
				window.opener.document.all.show_attach.style.visibility = "hidden";
				window.opener.document.all.showfinind.style.visibility = "hidden";
				window.opener.document.forms[0].sel_attach.value = "0";
				window.opener.document.forms[0].sel_finind.value = "S";
	
			}
				
				
		
				
				
			if (arr[6] != "FI" || arr[6] != "RA")
			{
				window.opener.document.forms[0].tabtitle.disabled=true;
			}	
			
	}

		if (opt == "formula")
			{
			if(id !="")
			{
			var idVal=id.indexOf("::");
			idVal=id.substr(0,idVal);
				window.opener.document.forms[0].formula.value = val;	
				window.opener.document.forms[0].formulano.value=idVal;
				}
			}
		if (opt == "formula2")
			{
				if(id !="")
			{
			var idVal2=id.indexOf("::");
			idVal2=id.substr(0,idVal2);
				window.opener.document.forms[0].formula2.value = val;	
				window.opener.document.forms[0].formulano2.value=idVal2;
				}
			}
		if (opt == "cma")
			{
				window.opener.document.forms[0].cmaformat.value = val;	
				window.opener.document.forms[0].cmano.value=id;
				window.opener.document.forms[0].tabtitle.value="";
				window.opener.document.forms[0].rowdesc.value="";
				window.opener.document.forms[0].select_type.value="S";
				window.opener.document.forms[0].formula.value="";
				window.opener.document.forms[0].formulano.value="";
				window.opener.document.forms[0].txtorder.value="";
				window.opener.document.forms[0].formulano2.value="";
				window.opener.document.forms[0].formula2.value="";
				
				window.opener.document.all.showfinind.style.visibility = "hidden";
				window.opener.document.forms[0].sel_finind.value = "S";
				window.opener.document.forms[0].sel_attach.value = "0";
				
			}
			if (opt == "ratingcma")
			{
				window.opener.document.forms[0].cmadesc.value = val;	
				window.opener.document.forms[0].cmano.value=id;

				
			}
		if (opt == "cma1")
		{
				window.opener.document.forms[0].cmaformat.value = val;	
				window.opener.document.forms[0].cmano.value=id;
				window.opener.document.forms[0].hidMode.value="edit";
				window.opener.document.forms[0].method="post";
				window.opener.document.forms[0].hidBeanId.value="formula";
				window.opener.document.forms[0].hidBeanMethod.value="updateCMA";
				window.opener.document.forms[0].action=appURL+"controllerservlet";
				window.opener.document.forms[0].hidSourceUrl.value="/action/com_cma_master.jsp";
				window.opener.document.forms[0].submit();
		}
		if (opt == "tabtitle")
			{
				window.opener.document.forms[0].tabtitle.value = val;	
				window.opener.document.forms[0].rowdesc.value="";
				window.opener.document.forms[0].select_type.value="S";
				window.opener.document.forms[0].formula.value="";
				window.opener.document.forms[0].formulano.value="";
				window.opener.document.forms[0].rowdesc.value="";
				window.opener.document.forms[0].txtorder.value="";
				window.opener.document.forms[0].formulano2.value="";
				window.opener.document.forms[0].formula2.value="";
			}
		}						
		window.close();
}

 else 
	{
		alert("Select a value");
		return;
	}

}

function doClose()
{
	window.close();
	
}
function getFormula()
{
	
	document.forms[0].submit();
}


</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</HEAD>

<body>


<form name="selection" method="post" class="normal">


    
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="3"  width="300" align="center">
    <tr> 
        <td valign="top">
          <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5">
            <tr> 
              <td  width="50%"><b>
               Select <%=strvalue.substring(0,1).toUpperCase()+strvalue.substring(1,strvalue.length())%> </b></td>
                 
                  <td width="50%"><%String strVal=strvalue.substring(0,1).toUpperCase()+strvalue.substring(1,strvalue.length());
             
              if((strVal.equalsIgnoreCase("Formula"))||(strVal.equalsIgnoreCase("Formula2") ))
               {%>
                 
						<select name="lst_formula" onChange="getFormula()">
                                  <option value="" <%=strCategory.trim().equals("")?"selected":""%>><--Select--></option>
                                  <option value="FI" <%=strCategory.trim().equals("FI")?"selected":""%>>Financials</option>
                                  <option value="RA" <%=strCategory.trim().equals("RA")?"selected":""%>>Ratios</option>
                                  <option value="CA" <%=strCategory.trim().equals("CA")?"selected":""%>>Cash Flow</option>
                                  <option value="FU" <%=strCategory.trim().equals("FU")?"selected":""%>>Fund Flow</option>
                                  <option value="MPBF1" <%=strCategory.trim().equals("MPBF1")?"selected":""%>>Assessment - MPBF1</option>
                                  <option value="MPBF2" <%=strCategory.trim().equals("MPBF2")?"selected":""%>>Assessment - MPBF2</option>
                                  <option value="PBF1" <%=strCategory.trim().equals("PBF1")?"selected":""%>>Assessment - PBF1</option>
                                  <option value="PBF2" <%=strCategory.trim().equals("PBF2")?"selected":""%>>Assessment - PBF2</option>
                                  <option value="PBF3" <%=strCategory.trim().equals("PBF3")?"selected":""%>>Assessment - PBF3</option>
                                  <option value="PBF4" <%=strCategory.trim().equals("PBF4")?"selected":""%>>Assessment - PBF4</option>
                                  <option value="TO" <%=strCategory.trim().equals("TO")?"selected":""%>>Assessment - Turn Over</option>
								  <option value="RHP" <%=strCategory.trim().equals("RHP")?"selected":""%>>Ratios - Holding Period</option>								
						</select>
                  
                  <%} %></td>
            </tr>
			<tr> 
                                <td align=center colspan="2"> 
                                <%String strVal1=strvalue.substring(0,1).toUpperCase()+strvalue.substring(1,strvalue.length());
             
                                if((strVal.equalsIgnoreCase("Formula"))||(strVal.equalsIgnoreCase("Formula2") ))
               {%><select name="cho_rate" size=15 style="width:400" onDblClick="javascript:doOk()">
                <option value = "0">----Deselect-----</option>
                <laps:comFormula /> 
              </select>
              <%} else{%>
                                  
              <select name="cho_rate" size=15 style="width:400" >
                <option value = "0">----Deselect-----</option>
                                    <laps:notefinmaster /> 
									
								</select>
								<%} %>
                                  
                                  </td>
                              </tr>
                              </table>
                              </td>
                              </tr></table>
							  <br>
							  
<lapschoice:combuttonnew
	btnnames="Ok"
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
			
</form>
<INPUT TYPE="hidden" name="val" value="category">
</BODY>
</HTML>
