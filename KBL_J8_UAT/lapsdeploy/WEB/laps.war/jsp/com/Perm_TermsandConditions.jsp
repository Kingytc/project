<%@include file="../share/directives.jsp"%>
<%
ArrayList arrRow=new ArrayList();

ArrayList arrCol = new ArrayList();
arrRow = (ArrayList) hshValues.get("arrRow");
int intLength=0;
if(hshValues!=null&&hshValues.size()>0)
{
	arrRow=(ArrayList)hshValues.get("arrRow");
}
if(arrRow!=null)
	intLength=arrRow.size();
%>

<html>
<head>
<title>Terms and Conditions</title>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varpageid="<%=Helper.correctNull((String) hshValues.get("PageId"))%>";
function setData(val,val2)
{
	if(document.forms[0].btnenable.value=="Y")
	{
		disableButton(true,false,true,true,false,false);
	}
	document.forms[0].txttrmdesc.value=val;
	document.forms[0].hidsno.value=val2;
	document.forms[0].hidAction.value="update";
}


function doAdd()
{
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidtermid.value="";
	document.forms[0].txttrmdesc.value="";
	document.forms[0].txttrmdesc.readOnly=false;
	disableButton(true,true,false,false,true,true);
}
function doEdit()
{
	if(document.forms[0].hidAction.value!="update")
	document.forms[0].hidAction.value="Print";
	document.forms[0].txttrmdesc.readOnly=false;
	if(document.forms[0].sno!=undefined)
	{
		var len = document.forms[0].sno.length;

		if(len != undefined)
		{
			for(i=0;i<len;i++)
			{
				document.forms[0].sno[i].disabled = true;
			}
		}
		else
		{
			document.forms[0].sno.disabled = true;
		}
	}
	
	disableButton(true,true,false,false,true,true);
	disableFields(false);
}
function doSave()
{
	if(document.forms[0].hidAction.value!="Print")
	{
		
		if(trimtxt(document.forms[0].txttrmdesc.value)=="")
		{
			alert("Enter Terms Description");
			document.forms[0].txttrmdesc.focus();
			return false;
		}
	}
	document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].hidBeanMethod.value="UpdateTerms";
	document.forms[0].hidBeanGetMethod.value="getTerms";		
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/Perm_TermsandConditions.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}	
function doDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{
	if(trimtxt(document.forms[0].hidcomments.value)=="")
	{
		var url = "<%=ApplicationParams.getAppUrl()%>action/Perm_delete_remarks.jsp";
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
		document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].hidBeanMethod.value="UpdateTerms";
		document.forms[0].hidBeanGetMethod.value="getTerms";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/Perm_TermsandConditions.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
}
function disableButton(b1,b2,b3,b4,b5,b6)
{
	document.forms[0].cmdadd.disabled = b1;
	document.forms[0].cmdedit.disabled = b2;
	document.forms[0].cmdsave.disabled = b3;
	document.forms[0].cmdcancel.disabled = b4;
	document.forms[0].cmddelete.disabled = b5;
	document.forms[0].cmdclose.disabled = b6;
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].hidBeanGetMethod.value="getTerms";
		document.forms[0].action=appURL+"action/Perm_TermsandConditions.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}

function doClose()
{
   if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appURL+"action/mainnav.jsp";
		 document.forms[0].submit();
	 }
}

function deleteTerms()
{
	var appno = document.forms[0].appno.value;
	var url = "<%=ApplicationParams.getAppUrl()%>action/Perm_dlt_termsandconditems.jsp?appno="+appno+"&hidBeanId=perDeviation&hidBeanGetMethod=getDeletedTerms&hidAction=Retail";
	var title1 = "";
	var prop = "scrollbars=yes,width=775,height=500,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title1,prop);
}
function callTerms()
{
	document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].hidBeanGetMethod.value="getTerms";
	document.forms[0].action=appURL+"action/Perm_TermsandConditions.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
function chkdetails(i)
{
	var len = "<%=intLength%>";
	if(len>1)
	{
		if(document.forms[0].chk_print[i].checked == true)
		{
			document.forms[0].txt_print[i].value="Y";
		}
		else
		{
			document.forms[0].txt_print[i].value="N";
		}
	}
	else 
	{
		if(document.forms[0].chk_print.checked == true)
		{
			document.forms[0].txt_print.value="Y";
		}
		else
		{
			document.forms[0].txt_print.value="N";
		}
	}
}

function disableFields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=="checkbox")
		{	
			document.forms[0].elements[i].disabled=one;		  
		}
	}
}
function callOnLoad()
{
	document.forms[0].txttrmdesc.readOnly=true;
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		disableButton(false,false,true,true,true,false);
	}
}
</script>
</head>
<body onLoad="callOnLoad();disableFields(true);">
<form name="frm1" method="post" class="normal">

        <jsp:include page="../share/devurllinker.jsp" flush="true">
			<jsp:param name="pageid" value="4" />
		</jsp:include>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">  
    <tr> 
      <td class="page_flow">Home -&gt; Permission -&gt; Proposal -&gt; Terms and Conditions</td>
    </tr>
  </table>
<lapschoice:ApplDevHeaderTag />
 


 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td colspan="2" valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                        
                            <tr> 
                              <td width="29%" align="center">Add Terms and Conditions</td>
                              <td width="71%"> 
                                <input type="hidden" name="hidtermid">
                                <input type="hidden" name="hidterms">
                                <textarea name="txttrmdesc" cols="100"  wrap="VIRTUAL" rows="5" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ></textarea>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
               <tr> 
                <td colspan="2">
                 <lapschoice:combuttonnew 	btnnames='Add_Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/><br>
				  <table border="1" cellspacing="0" cellpadding="3" align="center" class="outertable">
				    <tr> 
				      <td><input type="button" name="cmdadd2" value="Deleted Terms" class="buttonOthers" onClick="deleteTerms()"></td>
				          </tr>
				   </table>
				   
                </td>
                </tr>
               <tr> 
                  <td colspan="2" valign="middle"> 
                    <table width="98%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
                      <tr class="dataheader"> 
                        <td width="3%">&nbsp;</td>
                        <td align="center">Terms and Conditions</td>
                        <td align="center">Print</td>
                      </tr>
                     
                      <%
							if (arrRow != null && arrRow.size() > 0) {
								for (int i = 0; i < arrRow.size(); i++) {
									arrCol = (ArrayList) arrRow.get(i);
									if((Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("P"))){
						%>
                       <tr class="datagrid"> 
                         <td width="3%"> <input type="hidden" name="hidsno1" style="border-style:none" value="<%=arrCol.get(0)%>"> &nbsp;</td>
                        <td align="center" width="90%"> 
                          <div align="justify"><%=Helper.correctNull((String) arrCol.get(1))%></div>
                        </td>
                         <td align="center"><input type="checkbox" name="chk_print" style="border: none;" onclick="chkdetails(<%=i %>)" 
                        <%if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("Y")){ %>checked<%} %>>
                        <input type="hidden" name="txt_print" value="<%=Helper.correctNull((String)arrCol.get(2))%>"></td>
                         <%}
									}%>
									<%} %>
                        </tr>
                        </table>
                        </td>
                      </tr>
                      
                     
                <tr> 
                  <td colspan="2" valign="middle"> 
                    <table width="98%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable linebor">
                      <tr class="dataheader" align="center"> 
                        <td width="3%">&nbsp;</td>
                        <td align="center" width="90%" class="tabactivenew">Terms and Conditions Description</td>
                        <td width="7%">&nbsp;</td>
                      </tr>
                      <%
							if (arrRow != null && arrRow.size() > 0) {
								for (int i = 0; i < arrRow.size(); i++) {
									arrCol = (ArrayList) arrRow.get(i);
									if((Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("A"))){
						%>
                      <tr  class="datagrid"> 
                        <td width="3%"> 
                          <input type="radio" name="sno" style="border-style:none" value="" onClick="setData('<%=arrCol.get(1)%>','<%=arrCol.get(0)%>')"  >
                          <input type="hidden" name="hidsno1" style="border-style:none" value="<%=arrCol.get(0)%>">
                         </td>
                        <td> 
                          <%=Helper.correctNull((String) arrCol.get(1))%>
                        </td>
                        <td align="center"><input type="checkbox" name="chk_print" style="border: none;" onclick="chkdetails(<%=i %>)" 
                        <%if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("Y")){ %>checked<%} %>>
                        <input type="hidden" name="txt_print" value="<%=Helper.correctNull((String)arrCol.get(2))%>"></td>
                       
                     
                      </tr>
                    <%}
								}%>
								<%} %>
                    </table>
                  </td>
                </tr>
              </table>
  <br>
 
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input TYPE="hidden" name="hidcomments" value="">
  <input type="hidden" name="hidsno" value="">
        
      <input type="hidden" name="rdtermid">
 
 
  
     
</form>
</body>
</html>
