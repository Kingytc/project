<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Executive Summary</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varpageid="<%=Helper.correctNull((String)hshValues.get("PageId"))%>";
function callLink(page,bean,method)
{
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	<%if(strCategoryType.equalsIgnoreCase("SRE")){%>
	 document.forms[0].hidCategoryType.value="SRE";
	 <%}else if(strCategoryType.equalsIgnoreCase("STL")){%>
	 document.forms[0].hidCategoryType.value="STL";	 
	 <%}else{%> 
	 document.forms[0].hidCategoryType.value="CORP"; 
	 <%}%>
 	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit(); 
}

function placevalues()
{
	disableFields(true);

	var status_acc="<%=Helper.correctNull((String)hshValues.get("status_acc"))%>";
	if (status_acc!="")
	{
		document.forms[0].status_acc.value=status_acc;
	}
	else 
   	{
		document.forms[0].status_acc.value="1";
	}
	<%if(!strCategoryType.equalsIgnoreCase("STL")){ %>
	var company_rbi="<%=Helper.correctNull((String)hshValues.get("company_rbi"))%>";
	if (company_rbi!="")
	{
		document.forms[0].company_rbi.value=company_rbi;
	}
	else 
	{
		document.forms[0].company_rbi.value="0";
	}
	<%}%>
}

function callDefaulter()
{
    var check="applevel";
	var varQryString = appURL+"action/comrbidefaultersearch.jsp?check="+check;
	var title = "Defaulter";
	var prop = "scrollbars=yes,width=800,height=400,menubar=yes";	
	var xpos = (screen.width - 800) / 2;
	var ypos = (screen.height - 400) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(varQryString,title,prop);	
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
	enableButtons(true,false,false,false,false);
}

function enableButtons(bool1,bool2,bool3,bool4,bool5)
{

	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="executive";
		document.forms[0].hidBeanGetMethod.value="getData10";
		document.forms[0].action=appUrl+"action/exec_page10.jsp";
		document.forms[0].submit();
	}
}

function doClose()
{	
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}	
}

function doSave()
{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value="edit";
	document.forms[0].hidBeanId.value="executive";
	document.forms[0].hidBeanMethod.value="updateData10";
	document.forms[0].hidBeanGetMethod.value="getData10";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/exec_page10.jsp";
	document.forms[0].submit();
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="executive";
		document.forms[0].hidBeanMethod.value="updateData10";
		document.forms[0].hidBeanGetMethod.value="getData10";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/exec_page10.jsp";
		document.forms[0].submit();
	}
}
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
</head>

<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  onload="placevalues()">
<form name="frmpri" method = "post" class="normal">
<%if(strCategoryType.equalsIgnoreCase("SRE") || strCategoryType.equalsIgnoreCase("STL")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" >
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="8" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="1" cellspacing="0" cellpadding="0" class="outertable">
		<%if (strCategoryType.equalsIgnoreCase("SRE")) {%>
		<tr>
			<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short Review/Extension -&gt; Process Note </td>
		</tr>
		<%} else if (strCategoryType.equalsIgnoreCase("STL")) {%>
		<tr>
			<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short Term Loan -&gt; Process Note -&gt; Page 2 </td>
		</tr>
		<%} else if (strCategoryType.equalsIgnoreCase("ADC")) {%>
		<tr>
			<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Adhoc Limit -&gt; Process Note -&gt; Page	1  </td>
		</tr>
		
		<%}%>
	</table>
<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />

		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">
			Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Executive Summary -&gt; Page 5
		</td>
	</tr>
</table>
<%} %>
<span style="display:none;">
            				<lapschoice:borrowertype />
            			</span>
  						<lapschoice:application/>
  <table width="100%" border="1" cellspacing="0" cellpadding="5"  align="center" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
        		
        <tr> 
            		<td valign="top" colspan="2"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%" class="outertable">
          <tr> 
            <td valign="top" colspan="2"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td width="30%">STATUS OF ACCOUNT</td>
                  <td width="70%"> 
                    <select name="status_acc">
                      <option value="1" selected="selected">Regular</option>
                      <option value="2">EAS - I</option>
                      <option value="3">EAS - II</option>
                      <option value="4">SMA</option>
                      <option value="5">Not Applicable</option>
                    </select>
                  </td>
                </tr>
               
                <%if(!strCategoryType.equalsIgnoreCase("STL")){ %>
                <tr> 
                  <td width="30%">WHETHER THE NAME OF THE COMPANY / DIRECTORS 
                    FIGURE IN RBI DEFAULTERS'/CAUTION LIST / WILFUL DEFAULTERS 
                    / ECGC.</td>
                  <td width="70%" valign="middle" align="left"> 
                    <select name="company_rbi">
                      <option value="0" selected="selected">select</option>
                      <option value="1">Yes</option>
                      <option value="2">No</option>
                    </select>
                    <input type="button" class="buttonstyle" name="defaulter" value="Defaulter List"  
															onClick="callDefaulter()" tabindex="28">
                  </td>
                </tr>
                <tr> 
                  <td width="30%"> IF YES, PLEASE FURNISH DETAILS.</td>
                  <td width="70%" valign="top" align="left"> 
				    <textarea name="company_rbidesc" size="40" value="" cols="125" rows="10" 
                  onKeyPress="textlimit(document.forms[0].company_rbidesc,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("company_rbidesc"))%></textarea>
                  </td>
                </tr>
                <%} %>
                <tr> 
                  <td width="30%">PRUDENTIAL EXPOSURE NORMS [inclusive of Bank's 
                    exposure in the form of investments like shares, debentures, 
                    CP, etc.]</td>
                  <td width="70%"> 
                    <textarea name="exposure_norms" size="40" value="" cols="105" rows="5" 
                    onKeyPress="textlimit(document.forms[0].exposure_norms,250)" onKeyUp="textlimit(this,250)"><%=Helper.correctNull((String)hshValues.get("exposure_norms"))%></textarea>
                  </td>
                </tr>
                  <%if(!strCategoryType.equalsIgnoreCase("STL")){ %>
                <tr> 
                  <td width="30%">OTHER MATTERS</td>
                  <td width="70%">&nbsp;</td>
                </tr>
                <tr> 
                  <td colspan="2"> 
                    <textarea name="other_matters" size="40" value="" cols="125" rows="10" 
                    onKeyPress="textlimit(document.forms[0].other_matters,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("other_matters"))%></textarea>
                  </td>
                </tr>
                <%
                }
                %>
                <%if(!strCategoryType.equalsIgnoreCase("SRE") && !strCategoryType.equalsIgnoreCase("STL")){ %>
                <tr> 
                  <td width="30%">INDICATE PRODUCTS/SERVICES PROPOSED TO BE MARKETED 
                    TO CUSTOMER</td>
                  <td width="70%"> 
                    <textarea name="ind_services" size="40" value="" cols="105" rows="5" 
                    onKeyPress="textlimit(document.forms[0].ind_services,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("ind_services"))%></textarea>
                  </td>
                </tr>
                 <%} %>
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


<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">


           
    <tr> 
      <td colspan="3"> 
       <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
         
        </td>
    </tr>
       
    <tr> 
      <td colspan="3"></td>
    </tr>
    <tr> 
      <td width="33%">&nbsp; 
      <%if(strCategoryType.equalsIgnoreCase("STL")){ %>
        <div align="left"><a href="javascript:callLink('exec_page1.jsp','executive','getData')" > 
           &lt;&lt;&nbsp; Previous</a> </div>
      <%}else{ %>
        <div align="left"><a href="javascript:callLink('exec_page5.jsp','executive','getData5')" > 
           &lt;&lt;&nbsp; Previous</a> </div>
      <%} %>
      </td>
      <td width="33%" align="center">
        <jsp:include page="../com/link1.jsp" flush="true">
          <jsp:param name="cattype" value="<%=strCategoryType%>" />
          <jsp:param name="tabid" value="4" />
         </jsp:include>
        </td>
      <td width="33%">&nbsp; 
      
      <div align="right">
      <%if(strCategoryType.equalsIgnoreCase("SRE")){ %>
      Pg.4/9     
      <%}else if(strCategoryType.equalsIgnoreCase("STL")){ %>
      Pg.2/5     
      <%}else{ %>
      Pg.5/8
      <%} %>
      
      <%if(strCategoryType.equalsIgnoreCase("STL")){ %>
    	  &nbsp;<a href="javascript:callLink('comstl_comments.jsp?type=9&hidpage=norms~bplr','comproposal','getDataComment')" > 
	      Next &gt;&gt; </a>
      <%} else { %>
          &nbsp;<a href="javascript:callLink('exec_page6.jsp','executive','getData6')" > 
          Next &gt;&gt; </a>
       <% } %> 
        </div>
    </td>
    
    </tr>
</table>
   <lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type="hidden" name="hidCategoryType" value=""/>
   </form>  
 </body>
<%if(!strCategoryType.equalsIgnoreCase("STL")){ %> 
 <script language="javascript1.2">
editor_generate('other_matters');
</script>
<script language="javascript1.2">
editor_generate('company_rbidesc');
</script>
<%} %>
 </html>
