<%@include file="../share/directives.jsp"%>
<%String strtype[]={"Cheques Drawn of Borrower","Cheques Drawn by Borrower","Bills Drawn on Borrower","Bills Drawn by Borrower"};
	ArrayList arrRow = new ArrayList();
	ArrayList arrdata = new ArrayList(); 	
	String selhundi=Helper.correctNull((String)hshValues.get("adv_dishundi"));
	String seltype1=Helper.correctNull((String)hshValues.get("adv_distype"));	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var selhundi="<%=selhundi%>";
var seltype1="<%=seltype1%>";
function callload() {

    document.forms[0].sel_hundi.value=selhundi;
    document.forms[0].sel_type.value=seltype1;
    
    disableFields(true);
    callhundi();
}

function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appUrl+"action/agrborrowersearch.jsp";
		document.forms[0].submit();
	}
}

function disableFields(one)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=one;
		}       
		if(document.forms[0].elements[i].type=="textarea")
		{
		  document.forms[0].elements[i].readOnly=one;
		}
	} 	
}	

function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if( ConfirmMsg(101))
		{
			document.forms[0].hidAction.value ="delete";		
			document.forms[0].action=appUrl+"action/ControllerServlet";	
			document.forms[0].hidBeanMethod.value="updatedishonours";
			document.forms[0].hidBeanGetMethod.value="getdishonours";
			document.forms[0].hidBeanId.value="ADV1151";
			document.forms[0].hidSourceUrl.value="/action/adv_dishonours.jsp";			
			document.forms[0].submit();	
		} 
	}
	else
	{
		
		ShowAlert(158);
	}
}
function callLink(page,bean,method)
{
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit();
}
function doSave()
{
	for(var i=0;i<4;i++)
	{
		var txt_noofdishonours=document.forms[0].txt_noofdishonours[i].value;
		var txt_rangeofamt=document.forms[0].txt_rangeofamt[i].value;
		var txt_reasons=document.forms[0].txt_reasons[i].value;
		
		
	   if (txt_noofdishonours=="")
		{
		   txt_noofdishonours=0;
		}
		if (txt_rangeofamt=="")
		{
		   txt_rangeofamt=0;
		}
		if (txt_reasons=="")
		{
		   txt_reasons=0;
		}	
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidBeanId.value="ADV1151";		
	document.forms[0].hidSourceUrl.value="/action/adv_dishonours.jsp";
	document.forms[0].hidBeanMethod.value="updatedishonours";
	document.forms[0].hidBeanGetMethod.value="getdishonours";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();	
}
function doEdit()
{
 	disableFields(false);
	document.forms[0].hidAction.value ="insert";	
	enableButtons(true, false, false, false, true);	
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="cancel"; 
		document.forms[0].hidSourceUrl.value="/action/adv_dishonours.jsp";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidBeanMethod.value="updatedishonours";
		document.forms[0].hidBeanGetMethod.value="getdishonours";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 	
	}
}
function callhundi()
{
	if(document.forms[0].sel_hundi.value=="1")
	{
		document.all.hundi.style.visibility="visible";
		document.all.hundi.style.position="relative";
	}
	else
	{
		document.all.hundi.style.visibility="hidden";
		document.all.hundi.style.position="absolute";
		document.forms[0].sel_type.value="";
	}
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callload()">
<form name="finForm" action="" method="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td> <jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="19" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Proposal -&gt; ADV1151 -&gt; Dishonours</td>
	</tr>
</table>
<lapschoice:borrowertype /> <lapschoice:application />
<br>				
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
<tr>
               <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
				 	 <tr class="dataheader">
				 		 <td align="center"><b>DISHONOURS</b>
				 		 </td>
				 	 </tr>
				 </table>                  
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor" align="center">
          <tr class="datagrid"> 
            <td colspan="2">Does the borrower borrow on Hundi</td>
            <td colspan="2"> 
              <select name="sel_hundi" tabindex="1" onChange="callhundi()">
                <option value="" selected="selected">--Select--</option>
                <option value="1">Yes</option>
                <option value="2">No</option>
              </select>
            </td>
          </tr>
          <tr id="hundi" class="datagrid"> 
            <td  colspan="2">If yes</td>
            <td  colspan="2"> 
              <select name="sel_type" tabindex="2">
                <option value="" selected="selected">--Select--</option>
                <option value="1">Regularly</option>
                <option value="2">Occasionaly</option>
              </select>
            </td>
          </tr>
          <tr class="dataheader"> 
            <td colspan="4"><b>Details of cheques &amp; or acceptances 
              dishonored for lack of funds &amp; Bills purchased returned unpaid 
              during past one year</b> </td>
          </tr>
          <tr class="dataheader"> 
            <td >&nbsp;</td>
            <td  >No. of Dishonours</td>
            <td  >Range of Amount</td>
            <td  >Reasons</td>
          </tr>
          <%arrRow = (ArrayList) hshValues.get("arrRow");
                        if(arrRow!=null && arrRow.size()>0)
                 		{
                        	for(int i=0;i<arrRow.size();i++)
                   			{
                        		arrdata = (ArrayList) arrRow.get(i);%>
          <tr class="datagrid"> 
            <td ><%=Helper.correctNull((String)arrdata.get(0))%>
            	<input type="hidden" name="txt_dishonortype" value="<%=Helper.correctNull((String)arrdata.get(0))%>" />
            	</td>           
            <td > 
              <input type="text" name="txt_noofdishonours" size="16"  maxlength="12" onKeyPress="allowNumber(document.forms[0].txt_noofdishonours)" value="<%=Helper.correctNull((String)arrdata.get(1)) %>">
            </td>
            <td > 
	    <input type="text"  name="txt_rangeofamt"  maxlength="13" onkeypress="allowDecimals(this)" onblur="roundtxt(this);" style="text-align:right" value="<%=Helper.correctNull((String)arrdata.get(2)) %>"> 
            </td>
            <td > 
              <input type="text" name="txt_reasons"  value="<%=Helper.correctNull((String)arrdata.get(3)) %>" maxlength="500">
            </td>
          </tr>
          <%}}else {for(int i=0;i<4;i++){%>
          <tr class="datagrid"> 
            <td ><%=strtype[i]%><input type="hidden" name="txt_dishonortype" value="<%=strtype[i]%>" /></td>
            <td ><input type="text" name="txt_noofdishonours"  size="16" maxlength="12" onKeyPress="allowNumber(document.forms[0].txt_noofdishonours)"></td>
            <td ><input type="text" name="txt_rangeofamt"  maxlength="13" onblur="roundtxt(this);" onkeypress="allowDecimals(this)"  style="text-align:right" ></td>
            <td ><input type="text" name="txt_reasons"  tabindex="5" maxlength="500" ></td>
          </tr>
          <%}
          }%>
		  <tr valign="top" class="datagrid"> 
      <td colspan="4" valign="top"> Comments
        <textarea rows="5" name="txt_sanction" cols="150" maxlength="4000" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("adv_discomments"))%></textarea>
      </td>
    </tr>
        </table>
               </td>
              </tr>
             </table>
             <br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr> 
      <td width="20%" ><b>&nbsp; 
        <a href="javascript:callLink('adv_generalcomments.jsp','ADV1151','getGeneralComments')" > 
        &lt;&lt; Previous </a>&nbsp;</b> </td>
      <td width="60%" align="center"><b> 
        <jsp:include page="../ADV11-51/adv_links.jsp" flush="true"> </jsp:include>
        </b></td>
      <td width="20%">&nbsp; 
        <div align="right"><b>Pg.4/19&nbsp;<a href="javascript:callLink('adv_legalheirs.jsp','ADV1151','getLegalheirs')" > 
          Next &gt;&gt; </a></b></div>
      </td>
    </tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>


