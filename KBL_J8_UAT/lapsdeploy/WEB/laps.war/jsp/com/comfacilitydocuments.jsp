<%/*
	 Module Name:Documents
	 Page Name:	comfacilitydocuments.jsp
	 Descripion:		
	 Created By:Pradeep Kumar V
	 Modified By:	murali
*/%>
<%@include file="../share/directives.jsp"%>
<%
  ArrayList arrFacDocDesc = (ArrayList) hshValues.get("arrFacDocDesc");
  ArrayList arrFacDocType = (ArrayList) hshValues.get("arrFacDocType");
  ArrayList arrFacDocNo = (ArrayList) hshValues.get("arrFacDocNo");
  ArrayList arrFacDocdate = (ArrayList) hshValues.get("arrFacDocdate");
  ArrayList arrFacDoccode = (ArrayList) hshValues.get("arrFacDoccode");
  String strCatName="";
  if(strCategoryType.equals("CORPORATE")||strCategoryType.equals("CORP"))
  {
  		strCatName="Corporate";
  	
  }
  else if(strCategoryType.equals("OPS"))
  {
  	strCatName="Tertiary";
  }
  ArrayList arrFacDocDescMaster = (ArrayList) hshValues.get("arrFacDocDescMaster");
  ArrayList arrFacDoccodeMaster = (ArrayList) hshValues.get("arrFacDoccodeMaster");
  String strBorrowerType =Helper.correctNull((String)request.getParameter("hidBorrowerType"));
  String strIpAddress=Helper.correctNull((String)hshValues.get("ipaddress"));
  String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
%>
<html>
<head>
<title>Documents</title>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var flag= "<%= Helper.correctNull((String)hshValues.get("arrFacilityId")) %>";
var varipaddress="<%=strIpAddress%>";
var varApplHolder = "<%=Helper.correctNull((String)request.getParameter("appholder"))%>";
var varUserId = "<%=Helper.correctNull((String)session.getAttribute("strUserId"))%>";

function showCal(path,fname)
{
	var url = path+"action/Calendar.jsp?fname="+fname;
	var title = "Calendar";
	var prop = "scrollbars=no,width=260,height=240";	
	var xpos = (screen.width - 260) / 2;
	var ypos = (screen.height - 250) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop,"pop");
}

function callCalender(fname)
{if(document.forms[0].cmdedit.disabled==true)
	{
	showCal(appURL,fname);
}
}
function setData()
{
	
	var len = document.forms[0].apdoc_del.length;
	if(len!=null)
	{
	for(i=0;i<len;i++)
	{
		if(document.forms[0].apdoc_del[i].checked == true)
		{  
		    document.forms[0].hid_no.value=document.forms[0].hidsno[i].value;
		    document.forms[0].hidtermid.value = document.forms[0].apdoc_del[i].value;
			document.forms[0].hidterms.value = document.forms[0].hidtermtype[i].value;
		}
	}
	}
	else
	{
	
			document.forms[0].hidtermid.value = document.forms[0].apdoc_del.value;
			document.forms[0].hidterms.value = document.forms[0].hidtermtype.value;
	}

	if(varApplHolder==varUserId)
	{
	disableButton(true,false,true,true,false,false);
	}else{
	disableButton(true,true,true,true,true,false);
	}	
}


function doNew()
{
	if (document.forms[0].seltermid.value=='s')
	{
		alert("Select the Facility");
		return;
	}
	
	
	
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidtermid.value="";
	
	disableButton(true,true,false,false,true,true)
	document.all.t1.style.visibility="visible";
	document.all.t2.style.visibility="visible";
	callDocList(document.forms[0].hidComDocType.value);		
}

function callDocList(doctype)
{
	if(document.forms[0].cmdnew.disabled == true)
	{
		var prop = "scrollbars=no,width=700,height=350,top=100,left=80,menubar=yes,statusbar=yes";
		var url=appURL+"action/appdoclist.jsp?doc_type="+doctype;
		window.open(url,"",prop);
	}
}

function doEdit()
{
	var len = document.forms[0].apdoc_del.length;
	var temp=false;
	for(var i=0;i<len;i++)
	{
		if(document.forms[0].apdoc_del[i].checked == true)
		{
			temp=true;
		}
	}
	if(temp==false)
	{
		alert("Select Document");
		return false;
	}
	if (document.forms[0].seltermid.value=='s')
	{
		alert("Select the Facility");
		return;
	}
	document.forms[0].hidAction.value="update";		
	var len = document.forms[0].apdoc_del.length;
	if(len != null)
	{
		for(i=0;i<len;i++)
		{
			document.forms[0].apdoc_del[i].disabled =false;
		}
	}
	else
	{
		document.forms[0].apdoc_del.disabled = true;
	}

	disableButton(true,true,false,false,false,true)		
}


function doSave()
{

var doc_newcode=document.forms[0].hidNewDocCode.value.split("#");
var hidNewDocCode=document.forms[0].hidNewDocCode.value.split("#");


if(doc_newcode!="")
{

    document.forms[0].hidtermid.value=document.forms[0].hidNewDocCode.value.split("#");
}

	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="commdocument";
	document.forms[0].hidBeanMethod.value="updateComFacilityDocuments";
	document.forms[0].hidBeanGetMethod.value="getComFacDocuments";		
	document.forms[0].action=appURL+"controllerservlet";

	if (flag=="0^0")
	{	
	
		document.forms[0].general.value="general";
		document.forms[0].hidSourceUrl.value="/action/comfacilitydocuments.jsp";
	}
	else
	{
	
		document.forms[0].hidSourceUrl.value="/action/comfacilitydocuments.jsp";
	}

	document.forms[0].method="post";
	document.forms[0].submit();
}
	

function loadData()
{
	if(document.forms[0].seltermid.value=="0^0")
	{
		document.forms[0].hidBeanId.value="commdocument";
		document.forms[0].action=appURL+"action/comfacilitydocuments.jsp";
		document.forms[0].hidBeanGetMethod.value="getComFacDocuments";
		document.forms[0].general.value="general";
		document.forms[0].method="post";
		document.forms[0].submit();
	}

	else
	{
     document.forms[0].hidBeanId.value="commdocument";
	document.forms[0].action=appURL+"action/comfacilitydocuments.jsp";
	document.forms[0].hidBeanGetMethod.value="getComFacDocuments";
	document.forms[0].method="post";
	document.forms[0].submit();
	}
}

function doDelete()
{
	if(document.forms[0].hidtermid.value=="")
	{
		alert("Select Document to delete");
		return false;
	}
	
	if(trimtxt(document.forms[0].hidcomments.value)=="")
	{
		var url = "<%=ApplicationParams.getAppUrl()%>action/deletedtermremarks.jsp";
		var title1 = "";
		var prop = "scrollbars=no,width=600,height=450,menubar=no";
		var xpos = 20;
		var ypos = 20;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(url,title1,prop);
		
	}
	else
	{
	document.forms[0].hidAction.value="delete";
	document.forms[0].hidBeanId.value="commdocument";
	document.forms[0].hidBeanMethod.value="updateComFacilityDocuments";
	document.forms[0].hidBeanGetMethod.value="getComFacDocuments";
	document.forms[0].action=appURL+"controllerservlet";
	
	if (flag=="0^0")
	{	
		document.forms[0].general.value="general";
		document.forms[0].hidSourceUrl.value="/action/comfacilitydocuments.jsp";
	}
	else
	{
		document.forms[0].hidSourceUrl.value="/action/comfacilitydocuments.jsp";
	}

	document.forms[0].method="post";
	document.forms[0].submit();
	}
}

function disableButton(b1,b2,b3,b4,b5,b6)
{
	document.forms[0].cmdnew.disabled = b1;
	document.forms[0].cmdedit.disabled = b2;
	document.forms[0].cmdsave.disabled = b3;
	document.forms[0].cmdcancel.disabled = b4;
	document.forms[0].cmddelete.disabled = b5;
	document.forms[0].cmdclose.disabled = b6;
}

function doCancel(type)
{
	loadData();
}

function callClose()
{
	var cattype=document.forms[0].cattype.value;
	var id=document.forms[0].id.value;
 if((cattype=="ASSI")||(cattype=="ASBI")||(cattype=="OPS"))
        {
       if(ConfirmMsg(100))
	 { 
		document.forms[0].action=appURL+"action/agrborrowersearch.jsp";
		document.forms[0].submit();
	 }
		}
		if((cattype=="SSI")||(cattype=="CORP")||(cattype=="SME"))
        {
        if(ConfirmMsg(100))
	 {
		document.forms[0].action=appURL+"action/comsearch.jsp?&id="+document.forms[0].id.value;
		document.forms[0].submit();
	 }
		}
}

function callDocuments(type)
{
	document.forms[0].action=appURL+"action/comfacilitydocuments.jsp?hidComDocType="+type;
	document.forms[0].method="post";
	document.forms[0].submit();
}
	
function deleteTerms()
{
	var url;	
	if(document.forms[0].seltermid.selectedIndex==0)
	{
		alert("Select Facilities");
		return;
	}
	var appno = document.forms[0].appno.value;
	var seltermid = document.forms[0].seltermid.value;
	var hidComDocType = document.forms[0].hidComDocType.value;
	var seltermvalue = document.forms[0].seltermid.options[document.forms[0].seltermid.selectedIndex].text;

	if (flag=="0^0")
	{	
		url = "<%=ApplicationParams.getAppUrl()%>action/apptermsandcondexcep.jsp?appno="+appno+"&hidBeanId=commdocument&hidBeanGetMethod=getDeletedDocument&seltermid="+seltermid+"&seltermvalue="+seltermvalue+"&hidComDocType="+hidComDocType+"&page_from=documents";
	}
	else
	{
		url = "<%=ApplicationParams.getAppUrl()%>action/apptermsandcondexcep.jsp?appno="+appno+"&hidBeanId=commdocument&hidBeanGetMethod=getDeletedDocument&seltermid="+seltermid+"&seltermvalue="+seltermvalue+"&hidComDocType="+hidComDocType+"&page_from=documents";
	}

	var title1 = "Documents";
	var prop = "scrollbars=yes,width=775,height=500,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title1,prop);
}

function setSelect()
{
	if("<%=Helper.correctNull((String)hshValues.get("arrFacilityId"))%>"=="")
	{
		document.forms[0].seltermid.value="s";
	}
	else
	{
	document.forms[0].seltermid.value="<%=(String)hshValues.get("arrFacilityId")%>";
	}
	document.all.t2.style.visibility="hidden";
}

function callTerms()
{
	document.forms[0].action=appURL+"action/comtermsandcond.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function dohlp()     
{
  var hlpvar = appURL+"phlp/corp_propoother_doc.htm";
  var title = "Documents";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}


function callPrint(page,i)
{	
	var pagename=page;
	
	var i=0;
	var page1="";
	for(;i<pagename.length;i++)
	{
		if(pagename.charAt(i)==" ")
			{
			}
		else
			{
			page1=page1+pagename.charAt(i);
			
			}
		
	}
	/*var appno = document.forms[0].appno.value;
	var url = "<%=ApplicationParams.getAppUrl()%>action/"+page1+".jsp";
	var title = "Documents";
	var prop = "scrollbars=yes,width=775,height=450,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);*/
	var appURL="<%=ApplicationParams.getAppUrl()%>";
	var prop = "scrollbars=yes,width=750,height=550,,top=10,left=20,menubar=yes";
	var url=appURL+"action/printpdfviewdocument.jsp?&document_code="+page1;
	window.open(url,"viewdoc",prop);
}
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/navigate.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onLoad="setSelect()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="frm1" method="post" class="normal">
<%if (strCategoryType.equalsIgnoreCase("SRE") || strCategoryType.equalsIgnoreCase("STL") || strCategoryType.equalsIgnoreCase("ADC") || strCategoryType.equalsIgnoreCase("OPS")){ %>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	    <tr> 
	      <td valign="top"> 
	        <jsp:include page="../share/applurllinkscom.jsp" flush="true">         
	        <jsp:param name="pageid" value="9" />
	        <jsp:param name="cattype" value="<%=strCategoryType%>" />
	        <jsp:param name="ssitype" value="<%=strSSIType%>" />
	        </jsp:include>
	      </td>
	    </tr>
  </table>
  <%}else { %>
  
   <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
			<td valign="top"> 
              <jsp:include page="../com/proposallinks.jsp" flush="true"> 
              <jsp:param name="pageid" value="9" />
			   <jsp:param name="cattype" value="<%=strCategoryType%>" />
			  <jsp:param name="ssitype" value="<%=strSSIType%>" />
			
              </jsp:include>
            </td>
          </tr>
  </table>
  <%} %>


 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
   <%if(strSessionModuleType.equals("AGR")){%>
	 <tr>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Proposal -&gt; T&C / Sec. Documents -&gt; Documents</td>
	</tr>
	<%}else if(strCategoryType.equalsIgnoreCase("SRE"))
		{%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short Review/Extension -&gt; Documents</td>
	</tr>
	<%}else if(strCategoryType.equalsIgnoreCase("STL")){ %>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short Term Loan -&gt; Documents</td>
	</tr>
	<%}else if(strCategoryType.equalsIgnoreCase("ADC")){ %>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Ad hoc Limit -&gt; Documents</td>
	</tr>
	<%}else if(strCategoryType.equalsIgnoreCase("CORP")){ %>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; T&C / Sec. Documents -&gt; Documents</td>
	</tr>
	<%}else{ %>
    <tr> 
	    <td class="page_flow">Home -&gt; <%=strCatName %> -&gt; Application -&gt; Documents</td>
    </tr>
    
    <%} %>
  </table>
<span style="display:none"><lapschoice:borrowertype /></span><lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
    <tr> 
      <td >
         <table border="0" cellspacing="1" cellpadding="3" align="left" class="outertable" width="30%">
                <tr align="center"> 
                  <td width="15%" class="sub_tab_inactive"><b><a href="#" onclick="javascript:callTerms()">Terms and Conditions</a></b></td>
                  <td width="15%" class="sub_tab_active"><b>Documents</b></td>
                  </tr>
              </table>
        </td>
    </tr>
  </table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
	<tr>
		<td valign="top" align="center">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td colspan="2" valign="top">
						<table width="30%" border="0" cellspacing="3" cellpadding="3" align="left" class="outertable">
							<tr align="center">
								<%if (request.getParameter("hidComDocType").equals("a")) {

								%>
								<td width="50%" class="sub_tab_active"><b>By the Applicant</b></td>
								<%} else {

								%>
								<td width="50%" class="sub_tab_inactive"><b><a
									href="#" onclick="javascript:callDocuments('a')">By the Applicant</a></b></td>
								<%}
								if (request.getParameter("hidComDocType").equals("i")) {

								%>
								<td width="50%" class="sub_tab_active"><b>By the Bank</b></td>
								<%} else {

								%>
								<td width="50%" class="sub_tab_inactive"><a
									href="#" onclick="javascript:callDocuments('i')"><b>By the Bank </b></a></td>
								<%}%>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td colspan="2" valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td width="18%" align="center">Select Facilities</td>
										<td width="82%"><select name="seltermid" onChange="loadData()">
											<option value='s'>&lt;-- Select --&gt;</option>
											<lapschoice:comtermscond />
										</select></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						<tr>
						<td colspan="2" valign="middle">

						<table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
							<%String check = Helper.correctNull((String) hshValues.get("arrFacilityId"));
			if (!check.equals("")) {
							%>
							<tr class="dataheader">
								<td width="3%">&nbsp;</td>
								<td width="3%">&nbsp;</td>
								<td align="center" width="80%"><b>Document Name</b></td>
									<% if (request.getParameter("hidComDocType").equals("i")) {

								%>
								<td align="center" width="17%" ><b>Print</b></td>
									<%}%>
								<td align="center" width="17%">&nbsp;</td>
							</tr>
							<%}
			if (arrFacDocDescMaster != null && arrFacDocDescMaster.size() != 0) {

				for (int i = 0; i < arrFacDocDescMaster.size(); i++) {
					int j = i;

							%>
							<tr class="datagrid">
								<td width="3%">&nbsp;</td>

								<td width="3%"> <%=++j%> </td>
								<td width="80%"><%=arrFacDocDescMaster.get(i)%></td>
							<%	if (request.getParameter("hidComDocType").equals("i")) {

								%>
								<td width="17%" align="center" ><input type="button"
									name="appdoc_print2" value="Print"
									style="width:30;border:0;cursor:hand;font-weight:bold"
									class="buttonPrint" onClick="callPrint('<%=arrFacDoccodeMaster.get(i)%>',<%=i%>)">
								</td>
								<%} %>
								<td width="17%" align="center">
								</td>
							</tr>
							<%}
			}

			String check1 = Helper.correctNull((String) hshValues.get("arrFacilityId"));
			if (!check1.equals(""))
			{
			%>
							<tr class="dataheader">
								<td width="3%">&nbsp;</td>
								<td width="3%">&nbsp;</td>
								<td align="center" width="80%"><b>Document Name (Attached on Application Side)</b></td>
								<td align="center" width="17%">&nbsp;</td>
							</tr>
							<%}
			if (arrFacDocDesc != null && arrFacDocDesc.size() != 0) {
				int j = 1;
				for (int i = 0; i < arrFacDocDesc.size(); i++) {

					%>
							<tr class="datagrid">
								<td width="3%">&nbsp;</td>


								<td width="3%"><input type="radio" name="apdoc_del"
									style="border-style:none" value="<%=arrFacDocNo.get(i)%>"
									onClick="setData()"></td>
								<td width="80%" align="left"><%=arrFacDocDesc.get(i)%></td>
								<%if (request.getParameter("hidComDocType").equals("i")) {

								%>
								<td width="17%" align="center"><input type="button"
									name="appdoc_print" value="Print" class="buttonPrint"
									style="width:30;border:0;cursor:hand;font-weight:bold"
									onClick="callPrint('<%=arrFacDoccode.get(i)%>',<%=i%>)"></td>
									<%} %>
								<input type="hidden" name="hidsno" style="border-style:none"
									value="<%=i%>">
								<input type="hidden" name="hidText" style="border-style:none"
									value="<%=arrFacDocDesc.get(i)%>">
								<input type="hidden" name="hidtermtype" style="border-style:none"
									value="<%=arrFacDocType.get(i)%>">
								<td width="17%" align="center">
								<div align="left">
								<TABLE WIDTH="40%" BORDER="0" CELLSPACING="0" CELLPADDING="3">
									<TR>
										<TD><INPUT TYPE="hidden" SIZE="11" NAME="txt_expdate1<%=i%>"
											value="<%=arrFacDocdate.get(i)%>"></TD>
										<TD></TD>
									</TR>
								</TABLE>
								</div>
								</td>
							</tr>
							<%}
			} else {

				check = Helper.correctNull((String) hshValues
						.get("arrFacilityId"));
				if (!check.equals("")) {

				%>
							<tr class="dataheader">
								<td width="3%">&nbsp;</td>
								<td width="3%"><input type="hidden" name="apdoc_del"
									style="border-style:none" value="" onClick=""></td>
								<td width="80%" align="center">&nbsp;</td>
								<td width="17%" align="center">&nbsp;</td>
								<td width="17%" align="center">
								<div align="left"> &nbsp; </div>
								</td>
							</tr>
							<%}
			}

			%>
						</table>
						</td>
					</tr>
					<tr>
						<td align="center"><a href="#" onClick="openFolderView('<%=Helper.correctNull((String)request.getParameter("inwardno"))%>','')"><b>Link for DMS</b></a></td>
					</tr>
					<tr>
						<td>
						<table width="50%" border="0" cellspacing="0" cellpadding="0" align="center" id="t1" style="visibility:hidden" class="outertable">
								<input type="hidden" name="hidNewDocCode"> 
							    <input type="hidden" name="txtDocuments" size="50"	style="border-style:groove" readOnly="readonly"> 
								
						</table>

						<table width="50%" border="0" cellspacing="0" cellpadding="0" align="center" id="t2" style="visibility:hidden" class="outertable">
							<TR>
								<td width="20%">&nbsp;</td>
								<TD WIDTH="40%">&nbsp;</TD>
							</TR>
							<TR>
								
								<TD WIDTH="40%"><INPUT TYPE="hidden" SIZE="11"
									NAME="txt_exp_date1" align="center"></TD>
									
							</TR>
						</TABLE>
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
<table border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			align="center">
			<tr>
				<td>
					 <lapschoice:combuttonnew btnnames="New_Edit_Save_Delete_Cancel_Audit Trail"
        btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
				</td>
			</tr>
			<tr valign="top" align="center">
				<td width="0"><input type="button" name="cmdadd2"
					value="Deleted Documents" class="buttonStyle"
					style="font-weight:bold;font-size=10;width:150" onClick="deleteTerms()"></td>
				
			</tr>
		</table>
		</td>
	</tr>
</table>
<input type="hidden" name="hidBeanId" value=""> <input type="hidden"
	name="hidBeanMethod" value=""> <input type="hidden"
	name="hidBeanGetMethod"> <input type="hidden" name="hidSourceUrl"
	value=""> <input type="hidden" name="hidAction" value=""> <input
	TYPE="hidden" name="hidcomments"> <input type="hidden"
	name="hidComDocType"
	value="<%=Helper.correctNull((String)request.getParameter("hidComDocType"))%>">
<input type="hidden" name="hidtermid"> <input type="hidden"
	name="hidterms"> <input type="hidden" name="page_from"
	value="documents"> <input type="hidden" name="general"> <input
	type="hidden" name="rdtermid"> <input type="hidden"
	name="hidNewDocDate"> <!--<input type="hidden" name="hidtermtype">--> <input
	type="hidden" name="hid_no"> <input type="hidden" name="cattype"
	value="<%=strCategoryType%>"> <input type="hidden" name="ssitype"
	value="<%=strSSIType%>"> <input type="hidden" name="id"
	value="<%=strBorrowerType%>"></form>
</body>
</html>
