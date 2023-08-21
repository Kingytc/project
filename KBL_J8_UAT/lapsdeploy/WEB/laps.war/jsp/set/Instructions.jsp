<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) 
{
	hshValues = (java.util.HashMap) objValues;
}
ArrayList g1 =  new ArrayList();
%>
<html>
<head>
<title>Bulletin Information</title>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	

<SCRIPT Language="javascript">		
var appURL="<%=ApplicationParams.getAppUrl()%>";
var currentdate= "<%=Helper.getCurrentDateTime()%>";
var clientName = "<%=Helper.correctNull((String)hshValues.get("clntname"))%>";
var BulletinStatus = "<%=Helper.correctNull((String)hshValues.get("BULL_DISP"))%>";
var date = "<%=Helper.correctNull((String)hshValues.get("evtdate"))%>";		
	   
function callonLoad()
{
   	disableFields(true);
   	enableButtons(false,true,true,true,true,false);     
} 

function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;	
	document.forms[0].cmdclose.disabled=bool6;
}

function doNew()
	{    
	document.forms[0].hidAction.value ="New";
 	enableButtons(true,true,false,false,true,true);
 	disableFields(false);
 	ClearFields();
 	}
	
function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=val;	
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			  document.forms[0].elements[i].readOnly=val;		  
		}
		else if (document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;	
		}	
		else if (document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=(!val);	
		}		
	}
}

function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			  document.forms[0].elements[i].value="";		  
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			  document.forms[0].elements[i].value="";		  
		}
		else if (document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].value="1";	
		}	
	}	
}

function doEdit()
{
  	if(document.forms[0].txr_Instructions.value == "")
    {
        alert("Select the Announcement");
    }
    else
    {  
		document.forms[0].hidAction.value ="Edit";
	 	enableButtons(true,true,false,false,true,true);
	 	disableFields(false);
	} 	
}

function doDelete()
{
    if(document.forms[0].hidsno.value=="")
    {
      ShowAlert('111',"Announcement");      
    }      
	else if(ConfirmMsg(101))
	{
        document.forms[0].hidAction.value="Delete";
        document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanMethod.value="updateInstructions";
		document.forms[0].hidBeanGetMethod.value="getInstructionsData";
		document.forms[0].hidSourceUrl.value="/action/Instructions.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}

function doSave() 
{
	if(trim(document.forms[0].txr_Instructions.value)=="")
    {
        ShowAlert('121'," the Announcement")
    }
    else if(document.forms[0].txt_dateupto.value=="")
    {
        ShowAlert('121'," the date");
    }
    else 
    {
    	document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanGetMethod.value="getInstructionsData";
		document.forms[0].hidBeanMethod.value="updateInstructions";	
		document.forms[0].hidSourceUrl.value="/action/Instructions.jsp";	
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}

function doCancel()
{
	if(ConfirmMsg('102'))
	{	
		document.forms[0].hidSourceUrl.value="/action/Instructions.jsp";
	    document.forms[0].hidAction.value="Cancel";
	
		document.forms[0].hidBeanId.value="staticdata";
  		document.forms[0].hidBeanMethod.value="updateInstructions";
  		document.forms[0].hidBeanGetMethod.value="getInstructionsData";
  		document.forms[0].action=appURL+"controllerservlet";		
		document.forms[0].submit();
	}	
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].hidBeanId.value="";
		document.forms[0].hidBeanGetMethod.value="";
		document.forms[0].hidBeanMethod.value="";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/setupnav.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();  
	}
}

function callCalender()
{
	var action = document.forms[0].hidAction.value;
	if(action=="New" || action=="Edit")
	{
		showCal(appURL, 'txt_dateupto')
	}
}

function selectValues(slno, date, i, size)
{
	document.forms[0].hidAction.value = "Edit";
	document.forms[0].hidsno.value=slno;
   	if(size==1)
	{
		document.forms[0].txr_Instructions.value=document.forms[0].hidannounce.value;
	}
	else
	{
		document.forms[0].txr_Instructions.value=document.forms[0].hidannounce[i].value;
	}
		
   	document.forms[0].txt_dateupto.value=date;	
   	enableButtons(true,false,true,false,false,false);
}
 
</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body  onload="callonLoad()" >

<form class="normal" name="f1" method="post">
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td class="page_flow">Home -&gt; Setup -&gt; Bulletin 
        Info</td>
    </tr>
  </table>
 <TR>
    <td valign="top"> 
      <table class="outertable border1 tableBg" width="100%" border="0" cellspacing="0" cellpadding="5" >
        <tr> 
          <td> 
            <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="2" align="center" height="100%">
              <tr> 
                <td valign="top"> 
                  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="2">
                    <tr> 
                      <td> 
                        <table class="outertable" border="0" cellspacing="0" cellpadding="2"  width="100%">
                          <tr> 
                            <td width="11%">Announcement<span class="mantatory">*</span></td>
                            <td width="70%"> 
                              <textarea name="txr_Instructions" wrap="VIRTUAL" cols="75" rows="4" tabindex="1" readOnly 
                              onKeyPress="notAllowedDouble();notAllowSingleQuote();textlimit(this,1500);" onKeyUp="textlimit(this,1500)">
                                </textarea>
                            </td>
                            <td width="10%" align="right">Show 
                              Upto<b><span class="mantatory">*</span></b></td>
                            <td width="15%"><b> 
                              &nbsp;&nbsp; 
                              <input type="text" name="txt_dateupto" size="11" 
                               maxlength="10" class="txtstyle" tabindex="2" 
                               onBlur="checkDate(this);checkmindate(this,currentdate)"
                               value="">
                              </b></td>
                            <td width="10%">&nbsp;<a href="#" onClick="callCalender()" title="Select the date" border="0"><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif" border="0"></a></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                  <br>
                  <lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
                  <br>
              <tr> 
                <td valign="top"> 
                  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td valign="top" align="center"> 
                        <table class="outertable" width="98.3%" border="0" cellspacing="1" cellpadding="3">
                          <tr class="dataheader"> 
                            <td width="5%" >&nbsp;</td>
                            <td width="70%" ><b>Values</b></td>
                            <td width="20%" ><b>Show Upto</b></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr> 
                      <td valign="top" align="center"> 
                        <DIV class="cellcontainer"> 
                          <table class="outertable" width="98.3%" border="0" cellspacing="1" cellpadding="2"  >
                            <% 
								ArrayList	v = (ArrayList) hshValues.get("vecRow");
							if(v!=null)
							{					
								int vecsize =v.size();
								for(int l=0;l<vecsize;l++)
								{							
									g1 = (ArrayList)v.get(l);
									%>
                            <tr class="datagrid"> 
                              <td width="5%"> 
                                <input type="radio" name="radiobutton"  style="border-style:none"  
                                onClick="selectValues('<%=Helper.correctNull((String)g1.get(0))%>',
                                '<%=Helper.correctNull((String)g1.get(2))%>','<%=l %>','<%=vecsize%>')">
                                 <input type="hidden" name="hidannounce" value="<%=Helper.correctNull((String)g1.get(1))%>">
                              </td>
                              <td width="70%" ><%=Helper.correctNull((String)g1.get(1))%></td>
                              <td width="20%" ><%=Helper.correctNull((String)g1.get(2))%></td>
                            </tr>
                            <%
                    				}
								%>
                            <tr class="datagrid"> 
                              <td width="5%">&nbsp; </td>
                              <td width="70%">&nbsp; </td>
                              <td width="20%">&nbsp; </td>
                            </tr>
                            <%}else{
								 %>
                            <tr> 
                              <td width="5%">&nbsp; </td>
                              <td width="70%">&nbsp; </td>
                              <td width="20%">&nbsp; </td>
                            </tr>
                            <tr> 
                              <td>&nbsp; </td>
                              <td>&nbsp; </td>
                              <td>&nbsp; </td>
                            </tr>
                            <tr> 
                              <td>&nbsp; </td>
                              <td>&nbsp; </td>
                              <td>&nbsp; </td>
                            </tr>
                            <tr> 
                              <td>&nbsp; </td>
                              <td>&nbsp; </td>
                              <td>&nbsp; </td>
                            </tr>
                            <tr> 
                              <td>&nbsp; </td>
                              <td>&nbsp; </td>
                              <td>&nbsp; </td>
                            </tr>
                            <tr> 
                              <td>&nbsp; </td>
                              <td>&nbsp; </td>
                              <td>&nbsp; </td>
                            </tr>
                            <tr> 
                              <td>&nbsp; </td>
                              <td>&nbsp; </td>
                              <td>&nbsp; </td>
                            </tr>
                            <tr> 
                              <td>&nbsp; </td>
                              <td>&nbsp; </td>
                              <td>&nbsp; </td>
                            </tr>
                            <tr> 
                              <td>&nbsp; </td>
                              <td>&nbsp; </td>
                              <td>&nbsp; </td>
                            </tr>
                            <tr> 
                              <td>&nbsp; </td>
                              <td>&nbsp; </td>
                              <td>&nbsp; </td>
                            </tr>
                            <tr> 
                              <td>&nbsp; </td>
                              <td>&nbsp; </td>
                              <td>&nbsp; </td>
                            </tr>
                            <tr> 
                              <td>&nbsp; </td>
                              <td>&nbsp; </td>
                              <td>&nbsp; </td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp; </td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp; </td>
                            </tr>
                            <%} %>
                          </table>
                        </div>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <lapschoice:hiddentag pageid='<%=PageId%>'/> 
      <input type="hidden" name="org_code" value="<%=session.getAttribute("strOrgCode")%>">
      <input type="hidden" name="hidsno" value="<%=Helper.correctNull((String)hshValues.get("bull_id"))%>">
</form>
</body>
</html>
