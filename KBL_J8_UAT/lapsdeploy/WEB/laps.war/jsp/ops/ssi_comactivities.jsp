<%@include file="../share/directives.jsp"%>
<% request.setAttribute("_cache_refresh", "true"); %>
<%	ArrayList vec = null;
 	int vecsize=0;
 	ArrayList vec1= null;
 	int vecsize1=0;
 	if (hshValues != null)
 		{
   		vec = (ArrayList)hshValues.get("vecVal");
   		vec1 = (ArrayList)hshValues.get("vecVal1");
   		}
	if(vec!=null)
		{
		vecsize =vec.size();
		}
	if(vec1!=null)
		{
		vecsize1 =vec1.size();
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
<title>Activities</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var strvalue="corp_prodact.htm";
var varRecordFlag="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";

function placeValues()
{
	disableFields(true);
	document.forms[0].hidOtherMethod.value="getActivity";
}

function disableFields(val)
	{
		for(var i=0;i<document.frmproactivities.elements.length;i++)
		{
			if(document.frmproactivities.elements[i].type=="textarea")
			{
			  document.frmproactivities.elements[i].readOnly=val;		  
			}
		}
	}
	
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.frmproactivities.cmdedit.disabled=bool1;
	document.frmproactivities.cmdsave.disabled=bool2;
	document.frmproactivities.cmdcancel.disabled=bool3;
	document.frmproactivities.cmddelete.disabled=bool4;
	document.frmproactivities.cmdclose.disabled=bool5;
}

function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true);
	document.forms[0].hideditflag.value="Y";	
}
function doDelete()
	{
	if(varRecordFlag=="Y")
		{
		if(ConfirmMsg(101))
			 {
			document.frmproactivities.hidAction.value="delete"
			document.frmproactivities.hidBeanId.value="compro"
			document.frmproactivities.hidBeanMethod.value="updateActivity";
			document.frmproactivities.hidBeanGetMethod.value="getActivity";
			document.frmproactivities.action=appUrl+"controllerservlet";
			document.frmproactivities.hidSourceUrl.value="/action/ssi_comactivities.jsp";
			document.frmproactivities.submit();
			 }
		}
	else
		{
		ShowAlert(158);
		}
	}

function doSave()
{
		var flag = validate();
			if(flag)
			{
				document.frmproactivities.hidAction.value="update";
				document.frmproactivities.hidBeanId.value="compro";
				document.frmproactivities.hidBeanMethod.value="updateActivity";
				document.frmproactivities.hidBeanGetMethod.value="getActivity";
				document.frmproactivities.action=appUrl+"controllerservlet";
				document.frmproactivities.hidSourceUrl.value="/action/ssi_comactivities.jsp";
				document.frmproactivities.submit();
			}
			else	
			{
				alert("Enter values ");
			}
		}

function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.frmproactivities.hidBeanId.value="compro";
		document.frmproactivities.hidBeanMethod.value="getActivity";
		document.frmproactivities.hidBeanGetMethod.value="getActivity";
		document.frmproactivities.action=appUrl+"controllerservlet";
		document.frmproactivities.hidSourceUrl.value="/action/ssi_comactivities.jsp";
		document.frmproactivities.submit();
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
function  validate()
{ 
	var flag;	
		if(trim(document.frmproactivities.manufacturing.value) != "" || trim(document.frmproactivities.trading.value) != "")
		{			
				return true ;			
		}
		else
			{	flag = false; }	
return flag;
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placeValues()">
<form name="frmproactivities" method="post" class="normal">   
  <table width="100%" border="1" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td valign="top">
        <jsp:include page="../share/applurllinkscom.jsp" flush="true"> 
        <jsp:param name="pageid" value="4" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
    <tr>
    	<td class="page_flow">Home -&gt; <%=strcat %> -&gt;  Application -&gt; Ind. Activity   -&gt; Manufacturing & Trading Activity
    	</td>
    </tr>
  </table>
      <span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/>
<lapschoice:Activitytab tabid="2" ssitype='<%=strSSIType%>' />
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
    <tr> 
      <td valign="top">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                <tr> 
                  <td valign="top"> 
				  
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                      <tr> 
                        <td> 
                          <table width="100%" border="1" cellspacing="0" cellpadding="5" class="outertable">
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                                  <tr> 
                                    <td width="50%"> 
                                      <!-- added -->
                                      <table width="100%" border="0" cellspacing="1" cellpadding="7" class="outertable">
                                        <tr align="center"> 
                                          <td><b>Details of Manufacturing Activities</b></td>
                                        </tr>
                                        <%ArrayList	value =	null;
                                        int value_size	=	0;	
                                        if(hshValues.size()>0 && hshValues != null && vecsize > 0)
                                        {
                                    		value = (ArrayList)vec.get(0);
                                    		if(value != null){
                                    			value_size	=	value.size();
                                    		}
                                    	}
                                        if(value_size  > 0) {%>
	                                        <tr align="center"> 
	                                          <td> 
	                                          	<input type="hidden" name="mfgtype" value="M">
	                                            <textarea name="manufacturing" cols="125" wrap="VIRTUAL" rows="8" onkeypress="validate()" onkeyup="textlimit(this,3999)"  onKeyUp="textlimit(this,3999)"><%= Helper.correctNull((String)value.get(3))%></textarea>
	                                           </td>
	                                        </tr>
                                        <%} else {%>
                                        	<tr align="center"> 
                                          		<td> 
                                          		<input type="hidden" name="mfgtype" value="M">
                                            	<textarea name="manufacturing" cols="125" wrap="VIRTUAL" rows="8" onkeypress="validate()" onkeyup="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea>
                                          		</td>
                                        	</tr>
                                        <%} %>
                                        <tr align="center"> 
                                          <td><b>Details of Trading Activities</b></td>
                                        </tr>
                                        <%
                                        	value =	null;
                                        	value_size	=	0;
                                        	if(hshValues.size()>0 && hshValues != null && vecsize1 > 0 )
                                        	{
                                        		value = (ArrayList)vec1.get(0);
                                        		if(value != null){
                                        			value_size	=	value.size();
                                        		}
                                        	}                                        	
                                        	if(value_size  > 0) {%>
	                                        <tr align="center"> 
	                                          <td> 
	                                          	<input type="hidden" name="trdtype" value="T">
	                                            <textarea name="trading" cols="125" wrap="VIRTUAL" rows="8" onkeypress="validate()" onkeyup="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%= Helper.correctNull((String)value.get(3))%></textarea>
	                                          </td>
	                                        </tr>
                                        <%} else {%>
	                                        <tr align="center"> 
	                                          <td> 
	                                          	<input type="hidden" name="trdtype" value="T">
	                                            <textarea name="trading" cols="125" wrap="VIRTUAL" rows="8" onkeypress="validate()" onkeyup="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea>
	                                          </td>
	                                        </tr>
                                        <%} %>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td width="50%">&nbsp;</td>
                                  </tr>
                                </table>
									  <!--end-->
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
            </td>
          </tr>
        </table>      
  <br>
 <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
 <br> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="genTable" value="no">
<input type="hidden" name="otherGenTable" value="updateActivity">
<input type="hidden" name="otherGetMethod" value="">
<INPUT type="hidden" name="hidVal">
</form>
</body>
</html>
