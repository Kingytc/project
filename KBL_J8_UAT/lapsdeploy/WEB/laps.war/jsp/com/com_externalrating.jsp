<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>External Rating</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/com/comorg.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
	
	
	<%ArrayList vecRow = new ArrayList();
	ArrayList vecCol= new ArrayList();
	
		if(hshValues !=null)
	{
		vecRow = (ArrayList) hshValues.get("vecRow");
		
		
		
	//	out.println(vecRow.size());
	}
	int vsize=vecRow.size();
	String strappno = Helper.correctNull((String) hshValues.get("appno"));
	String appstatus = Helper.correctNull((String)request.getParameter("strappstatus"));
	if(appstatus.equalsIgnoreCase(""))
	{
		appstatus = Helper.correctNull((String)request.getParameter("appstatus"));
	}
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	%>
	
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var appstatus = "<%=appstatus%>";

function placeValues()
{
	if(document.forms[0].appstatus.value=="Open/Pending")
	{
		enableButtons(false,true,true,true,false,false);
	}
	else
	{
		enableButtons(true,true,true,true,false,false);
	}
disableFields(true);
}

function callCalender(val)
{
	
	if(document.forms[0].cmdsave.disabled==false)
	{
		 showCal(appURL,val);
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
	}
}

function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanGetMethod.value="getcom_externalratingdata";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_externalrating.jsp";
		document.forms[0].submit();
	 }
	
}

function doDelete()
{
	
	
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanMethod.value="updatecom_externalratingdata";
		document.forms[0].hidBeanGetMethod.value="getcom_externalratingdata";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_externalrating.jsp";
 		document.forms[0].submit();
	 }
	   }	 

function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmddelete.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdcomments.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}

function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,false,true)
	
}

function doSave()
{	
 
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanMethod.value="updatecom_externalratingdata";
		document.forms[0].hidBeanGetMethod.value="getcom_externalratingdata";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_externalrating.jsp";
		document.forms[0].submit();
}


function showAgency(val,num,field,len)
{
	
	if(document.forms[0].cmdsave.disabled==false)
	{
		/*if(val == "C")
		{
			document.forms[0].txt_cur_shortsymbol.value="";
			document.forms[0].txt_cur_longsymbol.value="";
		}
		else if(val == "P")
		{
			document.forms[0].txt_pre_shortsymbol.value="";
			document.forms[0].txt_pre_longsymbol.value="";
		}*/
		  
		
	
	   
		var varQryString =appURL+"action/searchagencylist.jsp?hidBeanGetMethod=getAgencyandSymbolList&hidBeanId=limitmaster&hidvalue=agency&yeartype="+val+"&num="+num+"&field="+field+"&len="+len;
		var title = "Agencylist";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
		
	   
	}
	 
}

function doComments()
{
	var hidAppNo = document.forms[0].hidappno.value;
	var prop = "scrollbars=no,width=750,height=550,top=25,left=180";
	var url=appURL+"action/com_bankingcomments.jsp?hidBeanId=facilities&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidPage1=extrating";
	window.open(url,"Comments",prop);
}

function callKalyptoRating()
{
	document.forms[0].hidBeanId.value="compro";
	document.forms[0].action=appURL+"action/com_kalyptorating.jsp?hidBeanGetMethod=getcom_externalratingdata&appStatus="+document.forms[0].appstatus.value;
	document.forms[0].method="post";
	document.forms[0].submit();
}

function callCorpRating()
{
	
	document.forms[0].hidBeanId.value="perapplicant";	
	//document.forms[0].hidBeanGetMethod.value="getRetailrating";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comrating.jsp";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
	
}

function showSymbol(val,val1,num,field,len)
{
	
	if(document.forms[0].cmdsave.disabled==false)
	{

		if(eval(len)>1)
		{
		if(val1 == "P")
		{
			if(document.forms[0].txt_pre_agency[num].value != "")
			{
				var agency = document.forms[0].txt_pre_agency[num].value;
			}
			else
			{
				alert("Please select Rating Agency");
				return;
			}
		}
		else if(val1 == "C")
		{
			if(document.forms[0].txt_cur_agency.value != "")
			{
				var agency = document.forms[0].txt_cur_agency.value;
			}
			else
			{
				alert("Please select current year Agency Name");
				return;
			}
		}

		}
		else if(eval(len)==1)
		{

			if(val1 == "P")
			{
				if(document.forms[0].txt_pre_agency.value != "")
				{
					var agency = document.forms[0].txt_pre_agency.value;
				}
				else
				{
					alert("Please select Rating Agency");
					return;
				}
			}
			else if(val1 == "C")
			{
				if(document.forms[0].txt_cur_agency.value != "")
				{
					var agency = document.forms[0].txt_cur_agency.value;
				}
				else
				{
					alert("Please select current year Agency Name");
					return;
				}
			}
		}
		else 
		{

			if(val1 == "P")
			{
				if(document.forms[0].txt_pre_agency.value != "")
				{
					var agency = document.forms[0].txt_pre_agency.value;
				}
				else
				{
					alert("Please select Rating Agency");
					return;
				}
			}
			else if(val1 == "C")
			{
				if(document.forms[0].txt_cur_agency.value != "")
				{
					var agency = document.forms[0].txt_cur_agency.value;
				}
				else
				{
					alert("Please select current year Agency Name");
					return;
				}
			}
		}
	
		
		var type = val;
		var varQryString = appURL+"action/searchsymbollist.jsp?hidBeanGetMethod=getAgencyandSymbolList&hidBeanId=limitmaster&agency="+agency+"&type="+type+"&yeartype="+val1+"&num="+num+"&field="+field+"&len="+len+"&hidvalue=symbol";
		var title = "Symbollist";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
	
}

function callotherTab()
{
	document.forms[0].action=appURL+"action/com_internalrating.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
</script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>

<body onload="placeValues()">

<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">
if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>

<form name="frmpri" method="post" class="normal">
<%if(strCategoryType.equalsIgnoreCase("CORP") || strCategoryType.equalsIgnoreCase("SME") ){ %>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable"> 
			<tr> 
				<td valign="top" colSpan="5"> 
					<jsp:include page="../com/proposallinks.jsp" flush="true"> 
						<jsp:param name="pageid" value="21" /> 
						<jsp:param name="cattype" value="<%=strCategoryType%>" /> 
						<jsp:param name="ssitype" value="<%=strSSIType%>" /> 
					</jsp:include> 
				</td>
			</tr> 
		</table>
		<%}
 else if (strCategoryType.equalsIgnoreCase("SRE") || strCategoryType.equalsIgnoreCase("OPS") || strCategoryType.equals("STL")){ %>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	    <tr> 
	      <td valign="top"> 
	        <jsp:include page="../share/applurllinkscom.jsp" flush="true">         
	        <jsp:param name="pageid" value="14" />
	        <jsp:param name="cattype" value="<%=strCategoryType%>" />
	        <jsp:param name="ssitype" value="<%=strSSIType%>" />
	        </jsp:include>
	      </td>
	    </tr>
  </table>
  <% }%>

<table width="100%" border="0" cellspacing="0" cellpadding="0"class="outertable">
		<tr>
		 <%if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Proposal -&gt; Rating </td>
	<%}else{%>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Rating </td> 
		<%} %>		
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<br>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
    <tr> 
      <td >
         <table border="0" cellspacing="1" cellpadding="3" align="left" class="outertable" width="30%">
                <tr align="center"> 
                  <td width="15%" class="sub_tab_active">External Rating</td>
                  <td width="15%" class="sub_tab_inactive"><a href="#" onclick="javascript:callKalyptoRating()">Kalypto Rating</a></td>
                  <td width="15%" class="sub_tab_inactive"><a href="#" onclick="javascript:callCorpRating()">Corporate Rating</a></td>
                  </tr>
              </table>
        </td>
    </tr>
  </table>

<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center" >
			
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="1" cellpadding="0" class="outertable" align="center" >
					
					<tr class="dataheader" align="center">
						<td >Facility</td>
						<td>Rating Agency</td>
						<td>Rated Amount</td>
						<td>Rating Assigned</td>
						<td>Description</td>
						<td>Due Date</td>
					</tr>
				
	
	
	<%
			if(vecRow!=null && vsize>0)
			{
				for (int i = 0; i < vsize; i++) 
					{
						vecCol = (ArrayList) vecRow.get(i);
						
						
			%>
			
			<tr class="datagrid">	
			
		
	<td width="30%"><input type="hidden" name="txt_facility" size="30" 
													value="<%=Helper.correctNull((String) vecCol.get(2)) %>"><%=Helper.correctNull((String) vecCol.get(0)) %> </td>
	
	<td width="20%" align="center"><input type="text" name="txt_pre_agency" size="20" maxlength="50"
													value="<%=Helper.correctNull((String) vecCol.get(4)) %>" >
							
												<b><span onClick="showAgency('P','<%=i %>','CEXR','<%=vsize%>');" style="cursor: hand"><font
													size="1" face="MS Sans Serif"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0"></font></span></b>&nbsp;</td>
	<td align="center" width="10%"> <input type="text" name="txt_ratingamt" size="13" maxlength="10" onkeypress="allowDecimals(this)"  style="text-align: right" value="<%=Helper.checkDecimal((String) vecCol.get(5)) %>" onblur="roundtxt(this)"></td>
	<td width="10%" nowrap="nowrap" align="center"><input type="text" name="txt_pre_longsymbol"
													size="15"  maxlength="50" value="<%=Helper.correctNull((String) vecCol.get(6)) %>">
												<b><span onClick="showSymbol('L','P','<%=i %>','CEXR','<%=vsize%>');"
													style="cursor: hand"><font size="1"
													face="MS Sans Serif"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0"></font></span></b>&nbsp;</td>
	<td width="20%" align="center"><textarea rows="2" cols="30" name="txt_description" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) vecCol.get(7))%></textarea>  </td>
	<%if(vsize>1) {%>
    <td width="18%" nowrap="nowrap" align="center"><input type="text" name="txt_deleteondate1" size="11"
							onBlur="checkDate(this);"value="<%=Helper.correctNull((String) vecCol.get(8)) %>" maxlength="12">   <a alt="Select date from calender" href="#"
											onClick="callCalender('txt_deleteondate1[<%=i %>]')"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											border=0 alt="Select date from calender"></a></td>
	<%}else if(vsize==1)
	{
	
			%>
			 <td width="18%" nowrap="nowrap" align="center"><input type="text" name="txt_deleteondate1" size="11"
							onBlur="checkDate(this);"value="<%=Helper.correctNull((String) vecCol.get(8)) %>" maxlength="12">   <a alt="Select date from calender" href="#"
											onClick="callCalender('txt_deleteondate1')"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											border=0 alt="Select date from calender"></a></td>
		
			<%}%>
			

											<tr>	
											<%
		
		
			}}else{ %>
			<tr class="datagrid">	
			<td colspan="6" align="center">No Data Found</td></tr>
			<%} %>
			
				</table>
				
				</td>
				</tr>
				</table>
			</td>
		</tr>
</table>

				
		<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel_Comments_Audit Trail"
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<input type="hidden" name="hidappno" value="<%=strappno%>">
<lapschoice:hiddentag pageid="<%=PageId%>" /></form>
<br>

		</body>
		</html>
		


