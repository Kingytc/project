<%@include file="../share/directives.jsp"%>
<%ArrayList arryRow=new ArrayList();
arryRow=(ArrayList)hshValues.get("arryRow");
ArrayList arryCol;%>
<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<script language="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varEditFlag = "";
</script>
<script language="javascript">
function getNewComment(strCom)
{	
	if(strCom!="")
	{	
		var str = new String(strCom);
		var myexp = /~/g;
		strCom=str.replace(myexp,"\n");		
	}
	return strCom;
}
var appurl="<%=ApplicationParams.getAppUrl()%>";
var doc_num="<%=Helper.correctNull((String)hshValues.get("doc_code"))%>";
var doc_type="<%=Helper.correctNull((String)hshValues.get("doc_type"))%>";
var sec_code="<%=Helper.correctNull((String)hshValues.get("sec_code"))%>";
var doc_primary="<%=Helper.correctDoubleQuotesHtml(Helper.correctNull((String)hshValues.get("doc_primary")))%>";
var doc_desc="<%=Helper.correctNull((String)hshValues.get("doc_desc"))%>";
var doc_prule=getNewComment("<%=Helper.correctDoubleQuotesHtml(Helper.correctNull((String)hshValues.get("doc_prule")))%>");
var reqdcode="<%=Helper.correctNull((String)hshValues.get("reqdcode"))%>";
var reqddate="<%=Helper.correctNull((String)hshValues.get("reqddate"))%>";
var reqdvalue="<%=Helper.correctNull((String)hshValues.get("reqdvalue"))%>";
var reqdmdate="<%=Helper.correctNull((String)hshValues.get("reqdmdate"))%>";
var docreqfl="<%=Helper.correctNull((String)hshValues.get("docreqfl"))%>";
var docmanfl="<%=Helper.correctNull((String)hshValues.get("docmanfl"))%>";
var doc_scode="<%=Helper.correctNull((String)hshValues.get("doc_scode"))%>";
var doc_codename="<%=Helper.correctNull((String)hshValues.get("doc_codename"))%>";

function menuOptionDivMouseDown (url)
{		
	if(!document.forms[0].applybtn.disabled)
	{
		ShowAlert(103);
		return;
	}
	document.currentMenu.style.display='none';
	document.currentMBarOpt.style.border='1px solid lightgrey';
	document.menuIsActive = false;
	document.forms[0].action=url;
	document.forms[0].submit();					
}
function chngApptype()
{
	if(document.forms[0].chodoc_type.selectedIndex==1)
	{
		document.all.dtypeid.innerText="Primary";
	}
	else
	{
		document.all.dtypeid.innerText="LDOC Number";
	}
}
function getDocCode()
{
	if(document.forms[0].chkdoccode.checked==true)
	{
		document.forms[0].hid_doccode.value="Y";
	}
	else
	{
		document.forms[0].hid_doccode.value="N";
	}
}
function getDocDate()
{
	if(document.forms[0].chkdocdate.checked==true)
	{
		document.forms[0].hid_docdate.value="Y";
	}
	else 
	{
		document.forms[0].hid_docdate.value="N";
	}
}
function getDocValue()
{
	if(document.forms[0].chkdocvalue.checked==true)
	{
		document.forms[0].hid_docvalue.value="Y";
	}
	else
	{
		document.forms[0].hid_docvalue.value="N";
	}
}
function getMaturityDate()
{
	if(document.forms[0].chkmaturitydate.checked==true)
	{
		document.forms[0].hid_docmaturitydate.value="Y";
	}
	else
	{
		document.forms[0].hid_docmaturitydate.value="N";
	}
}
function getDocRequired()
{
	if(document.forms[0].chksocreq.checked==true)
	{
		document.forms[0].hid_docrequired.value="Y";
	}
	else
	{
		document.forms[0].hid_docrequired.value="N";
	}
}
function getDocMandatory()
{
	if(document.forms[0].chkmandatory.checked==true)
	{
		document.forms[0].hid_docmandatory.value="Y";
	}
	else
	{
		document.forms[0].hid_docmandatory.value="N";
	}
}
</script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/set/documentjs.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callSelect();getDocDate();getDocCode();getDocValue();getMaturityDate();getDocRequired();getDocMandatory();">
<form name="editdetails" method="post"  class="normal"> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; Setup -&gt; Documents</td>
    </tr>    
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable border1">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="4" align="center" class="outertable">
          <tr valign="top"> 
            <td colspan="7">Check to delete all</td>
          </tr>
          <tr> 
            <td width="3%">&nbsp;</td>
            <td align="center" width="15%">Document type</td>
            <td align="center" width="32%">Description<span id="dtypeid"></span></td>
            <td align="center" width="6%">Security Code </td>
            <td align="center" width="15%">Document Code</td>
            <td align="center" width="19%">Primary Rules </td>
	      </tr>
          <tr> 
            <td width="3%" valign="top" align="center"><b> 
                <input type="checkbox" name="chkParent"  onClick="callParent()" style="border-style:none">
                </b>
            </td>
            <td align="center" width="14%" valign="top"><b> 
              <select  name="chodoc_type"  tabindex="1"  style="width:100" onBlur="document.forms[0].txtdoc_desc.focus()" onChange="checkval()">
                <option  value ="" selected>--Select--</option>
                <option value="A">By the Applicant</option>
                <option value="I">By the Bank</option>
              </select>
              </b></td>
            <td width="21%" align="center" valign="top"> 
              <table border="0" cellpadding="0" class="outertable">
                <tr>
                  <td valign="top"><input type="text" name="txtdoc_desc" maxlength="100" tabindex="1" value="<%=Helper.correctNull((String)hshValues.get("doc_desc"))%>" onKeyPress="notAllowSingleQuote()" size="50"></td>
                  <td><span onClick="callDescHelp()" style="cursor:hand"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"></span></td>
                </tr>
              </table> </td>
            <td align="center" valign="top"> 
                <select name="sec_code"  tabindex="2"  style="width:150" >
                 <option value="" selected>--Select--</option>
                  <%String apptype="1"; %>
                <lapschoice:StaticDataNewTag apptype='<%=apptype%>'/> 
              </select>
            </td>
            <td width="20%" align="center" valign="top">
            	<select name="txtdoc_docsp" tabindex="3" style="width:95">
            		<option value="0" selected>&lt;---Select---&gt;</option>
            		<lapschoice:StaticDataNewTag apptype="40"/>
            	</select></td>
            <td align="center" valign="top">
              <textarea name="taadoc_rulesp" cols="25" rows="2" tabindex="4" wrap="VIRTUAL" 		  
			  ><%=Helper.correctDoubleQuotesHtml(Helper.formatComment(Helper.correctNull((String)hshValues.get("doc_prule"))))%> </textarea>
           </td>
          </tr>
          <tr> 
            <td colspan="8" align="center" id="doc"> 
              <font size="2" color="red"><u>Required<br>
                <br>
                </u>Document Code&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b> 
                <input type="checkbox" name="chkdoccode"  onClick="getDocCode()" style="border-style:none">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>Document Date&nbsp;&nbsp;&nbsp;&nbsp;<b> 
                <input type="checkbox" name="chkdocdate"  onClick="getDocDate()" style="border-style:none">
                </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Document Value&nbsp;&nbsp;&nbsp;&nbsp;<b> 
                <input type="checkbox" name="chkdocvalue"  onClick="getDocValue()" style="border-style:none">
                </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Maturity Date &nbsp;&nbsp;&nbsp;&nbsp;<b> 
                <input type="checkbox" name="chkmaturitydate"  onClick="getMaturityDate()" style="border-style:none">
                </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Document is Required&nbsp;&nbsp;&nbsp;&nbsp;<b> 
                <input type="checkbox" name="chksocreq"  onClick="getDocRequired()" style="border-style:none">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>Document is Mandatory&nbsp;&nbsp;&nbsp;&nbsp;<b> 
                <input type="checkbox" name="chkmandatory"  onClick="getDocMandatory()" style="border-style:none">
                </b>
            </td>
          </tr>
          <tr>
            <td width="3%">&nbsp;</td>
            <td align="center" width="14%">Alternate</td>
            <td align="center" width="14%"></td>
            <td align="center" width="21%">Alternate Rules </td>
            <td align="center" width="11%">&nbsp;</td>
            <td align="center" width="20%">&nbsp;</td>
           </tr>
          <%			
		  for(int i=1;i<6;i++)
		  {
			 		 
			 if(arryRow!=null && arryRow.size()>=i)
			  {
				 arryCol=(ArrayList)arryRow.get(i-1);
				
				 if(arryCol!=null)
				 {%>
          <tr> 
            <td width="3%" align="center"> 
              <input type="checkbox" name="chkChild" value="checkbox" tabindex="<%=(3*i)+2%>" style="border-style:none" onClick="callChild(<%=i-1%>,<%=i%>,'<%=Helper.correctNull((String)arryCol.get(3))%>')">
            </td>
            <td align="center" width="17%">
              <input type="text" name="txtdoc_subalternate" tabindex="<%=(3*i)+3%>" value="<%=Helper.correctDoubleQuotesHtml(Helper.correctNull((String)arryCol.get(1)))%>" maxlength="100" 
						onKeyPress="notAllowSingleQuote()">
              <input type="hidden" name="hidalternate" value="<%=Helper.correctDoubleQuotesHtml(Helper.correctNull((String)arryCol.get(1)))%>">
            </td>
            <td colspan="3" align="center" >
              <textarea name="taadoc_subrule" cols="60" rows="2" tabindex="<%=(3*i)+4%>"  wrap="VIRTUAL" onKeyPress="callValidateRules(document.forms[0].txtdoc_subalternate[<%=i-1%>],document.forms[0].taadoc_subrule[<%=i-1%>]);NoallowEnterandDoubleQuote();notAllowSingleQuote()" ><%=Helper.formatComment(Helper.correctDoubleQuotesHtml(Helper.correctNull((String)arryCol.get(2))))%></textarea>
              <input type="hidden" name="hidaltrules" value="<%=Helper.correctDoubleQuotesHtml(Helper.formatComment(Helper.correctNull((String)arryCol.get(2))))%>">
              </td>
            <input type="hidden" name="hiddoc_subidentify" value="A<%=i%>"  >
          </tr>
          <%}}else{%>
          <tr> 
            <td width="10%" align="center"> 
              <input type="checkbox" name="chkChild" value="checkbox" tabindex="<%=(3*i)+2%>" style="border-style:none">
            </td>
            <td align="center" width="17%">
              <input type="text" name="txtdoc_subalternate" tabindex="<%=(3*i)+3%>"  onKeyPress="notAllowSingleQuote()" maxlength="100">
              </td>
            <input type="hidden" name="hidalternate" >
            <td colspan="3" align="center" >
              <textarea name="taadoc_subrule" cols="60" rows="2" tabindex="<%=(3*i)+4%>"  wrap="VIRTUAL" onKeyPress="callValidateRules(document.forms[0].txtdoc_subalternate[<%=i-1%>],document.forms[0].taadoc_subrule[<%=i-1%>])" ></textarea>
            </td>
            <input type="hidden" name="hidaltrules" value="A<%=i%>" >
            <input type="hidden" name="hiddoc_subidentify" value="A<%=i%>" >
          </tr>
          <%}}%>
        </table>
      </td>
    </tr>
  </table>
  <br>  
  <lapschoice:combuttonnew btnnames='Create_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type="hidden" name="hiddocrow" >
  <input type="hidden" name="hiddocsubrow1" >
  <input type="hidden" name="hiddocsubrow2" >
  <input type="hidden" name="hiddocsubrow3" >
  <input type="hidden" name="hiddocsubrow4" >
  <input type="hidden" name="hiddocsubrow5" >
  <input type="hidden" name="hidalternate">
  <input type="hidden" name="hidDocId" value="<%=Helper.correctNull((String)hshValues.get("doc_code"))%>">
  <input type="hidden" name="hidUsedFor"  >
  <input type="hidden" name="hidHelpMode" >
  <input type="hidden" name="hid_doccode" >
  <input type="hidden" name="hid_docdate" >
  <input type="hidden" name="hid_docvalue" >
  <input type="hidden" name="hid_docmaturitydate" >
  <input type="hidden" name="hid_docrequired" >
  <input type="hidden" name="hid_docmandatory" >
   <input type="hidden" name="txtdoc_doccode" >
   <input type="hidden" name="hidProducttype" value="<%=session.getAttribute("strProductType")%>">
     <input type="hidden" name="hid_value" >
      <input type="hidden" name="hid_oldvalue" >
      <input type="hidden" name="hidkeyid" value="set">
</form>
</body>
</html>
