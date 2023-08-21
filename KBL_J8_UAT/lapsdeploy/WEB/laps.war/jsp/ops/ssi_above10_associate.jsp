<%@include file="../share/directives.jsp"%>
<%
ArrayList vecRow = new ArrayList();
ArrayList vecCol = new ArrayList();
String strgenid="";
int vecrowsize =0;
if(hshValues.size()>0 && hshValues != null)
{
	vecRow = (ArrayList)hshValues.get("vecRow");
	vecrowsize = vecRow.size();
	if(vecrowsize>0)

	for(int i=0;i<4;i++)
	{	vecCol =(ArrayList)vecRow.get(i);
		strgenid=strgenid+Helper.correctNull((String)vecCol.get(0))+",";
	}

	if(!strgenid.equals(""))
	{
	strgenid=strgenid.substring(0,(strgenid.length())-1);	
	}
}
else
{
	strgenid ="0";
}
String strBorrowerType =Helper.correctNull((String)request.getParameter("hidBorrowerType"));
String strcat="";
if(!strCategoryType.equalsIgnoreCase(null))
{
	if(strCategoryType.equalsIgnoreCase("OPS"))
	{
		strcat="Tertiary";
	}
	else 
	{
		strcat="Corporate";
	}		
}%>
<html>
<head>
<title>Small Scale Industries</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript"src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var genid = "<%=strgenid%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function callDisable(one)
{
	for( i=1;i<=4;i++)		
	{	
		document.forms[0].elements["txt_association"+i].readOnly=one;	
		}		
}

function disableControls(bcmdEdit,bcmdApply,bcmdCancel,bcmddel,bcmdClose)
{
	document.forms[0].cmdedit.disabled=bcmdEdit;
	document.forms[0].cmdsave.disabled=bcmdApply;
	document.forms[0].cmdcancel.disabled=bcmdCancel;
	document.forms[0].cmddelete.disabled=bcmddel;
	document.forms[0].cmdclose.disabled=bcmdClose;
}
function onloading()
{	
	document.forms[0].hidGenID.value=genid;
	document.forms[0].txt_association1.readOnly=true;
	document.forms[0].hidparam.value="NatureofAssociationandAmountInvested^NatureofActivity^ItemsTraded/Manufactured^TurnoverandProfitduringpreceding3years";
	document.forms[0].hidTabName.value="Associate";
	document.forms[0].hidMethod.VALUE="getGeneralDetails";
	callDisable(true);
}
function doEdit()
{
	callDisable(false);
	disableControls(true,false,false,false,true);
	document.forms[0].hideditflag.value="Y";
}
function doDelete()
{
	document.forms[0].hidAction.value="Delete";
	if(!ConfirmMsg("101"))
	{
		return false;
	}
	document.forms[0].hidBeanGetMethod.value="removeUtillitiesData";
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].action=appURL+"action/ssi_above10_associate.jsp";	
	document.forms[0].submit();
	
}
function doSave()
{	
	if(<%=vecrowsize%> >0)
	{
		document.forms[0].hidAction.value="update";
	}
	else
	{
		document.forms[0].hidAction.value="insert";
	}
	document.forms[0].hidMethod.value="getGeneralDetails";
	document.forms[0].hidBeanGetMethod.value="updateGeneralData";
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].action=appUrl+"action/ssi_above10_associate.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
function doCancel()
{	
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidMethod.value="getGeneralDetails";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].action=appUrl+"action/ssi_above10_associate.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{ 
		document.forms[0].action=appUrl+"action/agrpage.jsp";
		document.forms[0].submit();
	 }
}
</script>
</head>

<body onload="onloading()">
<form name="fininc" method="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true">
        <jsp:param name="pageid" value="4" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
	    <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
    <tr> 
            <td class="page_flow">Home -&gt; <%=strcat %> -&gt;  Application -&gt; Ind. Activity -&gt; Name of Associate Concern(s)
 	</td>
          </tr>
  </table>  
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/>    
<lapschoice:Activitytab tabid="5" ssitype='<%=strSSIType%>' />      
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                <tr> 
                  <td> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="3" class="outertable">                    
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
                            <tr> 
                              <td colspan="4">Name of the associate concern(s), if any </td>
                            </tr>
					<%
					if(hshValues.size()>0 && hshValues != null && vecrowsize >0)
					{
							vecCol =(ArrayList)vecRow.get(0);
					%>
                            <tr> 
                              <td colspan="4">Nature 
                                of association and amount invested
                                <input type="hidden" name="hidtxt1" value="<%=vecCol.get(0)%>">
                                </td>
                            </tr>
                            <tr> 
						
                              <td colspan="4" align="right"> 
                                <textarea name="txt_association1" cols="130" wrap="VIRTUAL" rows="8"><%=vecCol.get(1)%></textarea>
                              </td>
                            </tr>
						<% vecCol =(ArrayList)vecRow.get(1);%>
                            <tr> 
                              <td colspan="4" height="18">Nature 
                                of activity
                                <input type="hidden" name="hidtxt2" value="<%=vecCol.get(0)%>">
                                </td>
                            </tr>
                            <tr> 
							
                              <td colspan="4" align="right"> 
                                <textarea name="txt_association2" cols="130" wrap="VIRTUAL" rows="8"><%=vecCol.get(1)%></textarea>
                              </td>
                            </tr>
						<% vecCol =(ArrayList)vecRow.get(2);%>
                            <tr> 
                              <td colspan="4">Items 
                                traded / manufactured
                                <input type="hidden" name="hidtxt3" value="<%=vecCol.get(0)%>">
                                </td>
                            </tr>
                            <tr> 
							
                              <td colspan="4" align="right"> 
                                <textarea name="txt_association3" cols="130" wrap="VIRTUAL" rows="8"><%=vecCol.get(1)%></textarea>
                              </td>
                            </tr>
						<% vecCol =(ArrayList)vecRow.get(3); %>
                            <tr> 
                              <td colspan="4">Turnover 
                                and profit during preceding three years
                                <input type="hidden" name="hidtxt4" value="<%=vecCol.get(0)%>">
                                </td>
                            </tr>
                            <tr>							
                              <td colspan="4" align="right"> 
                                <textarea name="txt_association4" cols="130" wrap="VIRTUAL" rows="8"><%=vecCol.get(1)%></textarea>
                              </td>
	                         </tr>
					<%}else{%>       <tr> 
                              <td colspan="4">Nature 
                                of association and amount invested</td>
                            </tr>
                            <tr> 
								

                              <td colspan="4" align="right"> 
                                <textarea name="txt_association1" cols="130" wrap="VIRTUAL" rows="8"></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td colspan="4">Nature 
                                of activity</td>
                            </tr>
                            <tr> 
							   
                              <td colspan="4" align="right"> 
                                <textarea name="txt_association2" cols="130" wrap="VIRTUAL" rows="8"></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td colspan="4">Items 
                                traded / manufactured</td>
                            </tr>
                            <tr> 
							     
                              <td colspan="4" align="right"> 
                                <textarea name="txt_association3" cols="130" wrap="VIRTUAL" rows="8"></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td colspan="4">Turnover 
                                and profit during preceding three years</td>
                            </tr>
                            <tr> 
							  <td colspan="4" align="right"> 
                                <textarea name="txt_association4" cols="130" wrap="VIRTUAL" rows="8"></textarea>
                              </td>
	                         </tr>
					<%}%>
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
        </td>
    </tr>
  </table>
<br>
 <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
 <br> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidDesc1" value="NatureofAssociationandAmountInvested">
<input type="hidden" name="hidDesc2" value="NatureofActivity">
<input type="hidden" name="hidDesc3" value="ItemsTraded/Manufactured">
<input type="hidden" name="hidDesc4" value="TurnoverandProfitduringpreceding3years">
<input type="hidden" name="hidTotalDesc" value="4">
<input type="hidden" name="hidFieldPrefix" value="txt_association">
<input type="hidden" name="hidGenID" value="">
<input type="hidden" name="otherGetMethod" value="">
</form>
</body>
</html>
