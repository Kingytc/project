<%@include file="../share/directives.jsp"%>
<%String strSector = Helper.correctNull((String) request.getParameter("hidsector"));
ArrayList arrRow=(ArrayList)hshValues.get("arrRow");
String strappliedfor = Helper.correctNull((String) request.getParameter("appliedfor"));
String strProposal=Helper.correctNull((String)request.getParameter("hidproposal"));%>
<html>
<head>
<title>Personal - Work Flow</title>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varappstatus="";
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function callOtherTab(val)
{
	if(val=="action")
	{
		document.forms[0].action=appURL+"action/inwardworflowaction.jsp";
		document.forms[0].submit();
	}
}
function callRemarks()
{
	var varinwardno = document.forms[0].inwardno.value;
	var varsector = document.forms[0].hidsector.value;
	var varappname = document.forms[0].appname.value;
	var prop = "scrollbars=no,width=650,height=600,top=25,left=180";
	var url=appURL+"action/saralworkflow_comments.jsp?inwardno="+varinwardno+"&hidsector="+varsector+"&appname="+varappname+"&editoption=N"+"&hidBeanId=inwardRegister&hidBeanGetMethod=getInwardremarks";
	window.open(url,"remarks",prop);
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="frmworkflow" method="post" class="normal"> 
<lapschoice:saralreportTag tabid="1" sector='<%=strSector%>' applied='<%=strappliedfor%>' proposal='<%=strProposal%>'/> 
<lapschoice:inward />
<lapstab:SaralworkflowTag tabid="1"/>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
	<tr> 
    	<td valign="top"> 
    		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
        		<tr> 
          			<td> 
            			<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1">
              			<tr> 
                			<td valign="top"><br>
                    				<b>History</b><br>
                  				<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
                    				<tr> 
                      					<td width="47%" valign="top"> 
                        					<table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
                          						<tr> 
                            						<td valign="top"> 
                              							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
                                							<tr class="dataheader">                                  								
                                    								<td width="37%" align="center">Sent By </td>                                  								
                                    								<td width="26%" align="center"> Sent On </td>
                                    								<td width="37%" align="center"> Sent To </td>                                  					
                                							</tr>
                                									<%if(arrRow!=null && arrRow.size()>0)
                                       									 {
                                       									 	for(int i=0;i<arrRow.size();i++){ 
                                       									 	ArrayList arrCol=new ArrayList();
                                       									 	arrCol=(ArrayList)arrRow.get(i);%>
                                        									<tr class="datagrid">                                          										
                                            					<td width="37%">&nbsp;<%=Helper.correctNull((String)arrCol.get(0))%></td>                                          										
                                            					<td width="26%" align="center"> <%=Helper.correctNull((String)arrCol.get(1))%></td>
                                          						<td width="37%"> <%=Helper.correctNull((String)arrCol.get(2))%></td>
                                        									</tr>
                                        									<%}}%>
                                      									</table>
                                  								</td>
                                							</tr>
                              							</table>
                            						</td>
                          						</tr>
                        					</table>
                      					</td>
                    				</tr>
                  				</table></td>
                  				</tr>
                  				</table>
                  				</td>
                  				</tr>
                  				</table>
                  				<br>
                  				<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
                  				<br> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
