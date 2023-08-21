<%@ include file="../share/directives.jsp"%>
<% request.setAttribute("_cache_refresh", "true"); %>
<html>
<head>
<title>Setup - Undelete Applications</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
function placeCursor()
	{
		document.frmundelapp.txtsearch.focus();
	}

function frmSubmit()
	{
	var strFormType="";
	var strSearchtype="";
	var strFlag=false;
	var strFfalg = false;
	
	if(document.frmundelapp.optformtype[0].checked==true)
		{
		strFormType="P";
		strFlag=true;
		}
	else if(document.frmundelapp.optformtype[1].checked==true)
		{
		strFormType="C";
		strFlag=true;
		}
	else if(document.frmundelapp.optformtype[2].checked==true)
		{
		strFormType="A";
		strFlag=true;
		}
    else if(document.frmundelapp.optformtype[3].checked==true)
		{
		strFormType="T";
		strFlag=true;
		}
	if(document.frmundelapp.optstype[0].checked==true)
		{
		if(document.frmundelapp.txtsearch.value == "")
			{
			ShowAlert('121',"Application No");
				return;
			}
			strSearchtype="A";
			strFfalg = true;
		}
	else if(document.frmundelapp.optstype[1].checked==true)
		{
		if(document.frmundelapp.txtsearch.value == "")
			{
			if(document.frmundelapp.optformtype[0].checked==true ||document.frmundelapp.optformtype[2].checked==true || document.frmundelapp.optformtype[3].checked==true)
				{
				ShowAlert('121',"Borrower Name");
				return;
				}
			else
				{
				ShowAlert('121',"Company Name");
				return;
				}
			}
			strSearchtype="N";
			strFfalg = true;
		}
	else if(document.frmundelapp.optstype[2].checked==true)
		{
		if(document.frmundelapp.txtsearch.value == "")
			{
			if(document.frmundelapp.optformtype[0].checked==true ||document.frmundelapp.optformtype[2].checked==true || document.frmundelapp.optformtype[3].checked==true)
				{
				ShowAlert('121',"PAN No");
				return;
				}
			else
				{
				ShowAlert('121',"Company ID");
				return;
				}
			}
			strSearchtype="S";
			strFfalg = true;
		}
	if((document.frmundelapp.txtsearch.value!="") && strFfalg==false)
		{
		ShowAlert('111',"Search Type");
		}
	else if(strFlag==true)
		{
		document.frmundelapp.dispData.value="Y";
		parent.frames[1].disp.document.dispundelete.optstype.value=strSearchtype;
		parent.frames[1].disp.document.dispundelete.optformtype.value=strFormType;
		parent.frames[1].disp.document.dispundelete.txtsearch.value=document.frmundelapp.txtsearch.value;
		document.frmundelapp.target="disp";
		document.frmundelapp.action="<%=ApplicationParams.getAppUrl()%>action/dispundelapp.jsp";
		document.frmundelapp.submit();
		}
	else
		{
		ShowAlert('111',"Form Type");
		}
	}
	
function getList()
	{
	var strFormType="";
	var strFlag=false;

	document.frmundelapp.optstype[0].checked=false;
	document.frmundelapp.optstype[1].checked=false;
	document.frmundelapp.optstype[2].checked=false;
	document.frmundelapp.txtsearch.value="";
	if(document.frmundelapp.optformtype[0].checked==true)
		{
		strFormType="P";
		strFlag=true;
		}
	else if(document.frmundelapp.optformtype[1].checked==true)
		{
		strFormType="C";
		strFlag=true;
		}
	else if(document.frmundelapp.optformtype[2].checked==true)
		{
		strFormType="A";
		strFlag=true;
		}
		else if(document.frmundelapp.optformtype[3].checked==true)
		{
		strFormType="T";
		strFlag=true;
		}
		
	if(strFlag==true)
		{
		parent.frames[1].disp.document.dispundelete.optformtype.value=strFormType;
		document.frmundelapp.dispData.value="Y";
		document.frmundelapp.target="disp";
		document.frmundelapp.action="<%=ApplicationParams.getAppUrl()%>action/dispundelapp.jsp";
		document.frmundelapp.submit();
		}
	}
	
function EraseValues()
	{	
	var strFormType;
	if(document.frmundelapp.optformtype[0].checked==true)
		{
		strFormType="P";
		}
	else if(document.frmundelapp.optformtype[1].checked==true)
		{
		strFormType="C";
		}
	else if(document.frmundelapp.optformtype[2].checked==true)
		{
		strFormType="A";
		}
		
	var len = parent.frames[1].disp.document.dispundelete.chkappno.length;
		
	if(len == null)
		{
		if(parent.frames[1].disp.document.forms[0].chkappno.checked == false)
			{
			ShowAlert('111',"applications to delete");
			return false;
			}
		}
	else
		{
		var val=0;
		for(i=0;i<len;i++)
			{
			if(parent.frames[1].disp.document.forms[0].chkappno[i].checked == true)
				{
				val = 1;
				break;
				}
			}
		if(val==0)
			{
			ShowAlert('111',"applications to delete");
			return false;
			}
		}
		
	parent.frames[1].disp.document.dispundelete.optformtype.value=strFormType;	
	parent.frames[1].disp.document.dispundelete.hidAction.value="erase";
	parent.frames[1].disp.document.dispundelete.dispData.value='Y';
	parent.frames[1].disp.document.dispundelete.action="<%=ApplicationParams.getAppUrl()%>action/controllerservlet";
  	parent.frames[1].disp.document.dispundelete.hidBeanId.value="undelete";
 	parent.frames[1].disp.document.dispundelete.hidBeanGetMethod.value="updateData";
 	parent.frames[1].disp.document.dispundelete.hidSourceUrl.value="/action/dispundelapp.jsp";
	parent.frames[1].disp.document.dispundelete.submit();
	}
	function doUndelete()
	{	
		var strFormType="";
		var strSearchtype="";
		if(document.frmundelapp.optformtype[0].checked==true)
		{
			strFormType="P";
		}
		else if(document.frmundelapp.optformtype[1].checked==true)
		{
			strFormType="C";
		}
		else if(document.frmundelapp.optformtype[2].checked==true)
		{
			strFormType="A";
		}
		if(document.frmundelapp.optstype[0].checked==true)
		{
			strSearchtype="A";
		}
		else if(document.frmundelapp.optstype[1].checked==true)
		{
			strSearchtype="N";
		}
		else if(document.frmundelapp.optstype[2].checked==true)
		{
			strSearchtype="S";
		}
		parent.frames[1].disp.document.dispundelete.hidAction.value="undelete";
		parent.frames[1].disp.document.dispundelete.dispData.value='Y';
		parent.frames[1].disp.document.dispundelete.optformtype.value=strFormType;	
		parent.frames[1].disp.document.dispundelete.optstype.value=strSearchtype;
		parent.frames[1].disp.document.dispundelete.txtsearch.value=document.frmundelapp.txtsearch.value;
		
  		parent.frames[1].disp.document.dispundelete.hidBeanId.value="undelete";
 		parent.frames[1].disp.document.dispundelete.hidBeanGetMethod.value="updateData";
 		parent.frames[1].disp.document.dispundelete.action="<%=ApplicationParams.getAppUrl()%>action/dispundelapp.jsp";
		parent.frames[1].disp.document.dispundelete.submit();
	}
	
	function changelbl()
	{
	if(document.forms[0].optformtype[0].checked==true)
	{
		document.all.cname1.innerHTML='Borrower Name';
		document.all.cid1.innerHTML='PAN No';
		document.all.cname2.innerHTML='Applicant Name';
		document.all.cid2.innerHTML='PAN No';
	}
	else if(document.forms[0].optformtype[1].checked==true)
	{
			document.all.cname1.innerHTML='Company Name';
		document.all.cid1.innerHTML='Company ID';
		document.all.cname2.innerHTML='Company Name';
		document.all.cid2.innerHTML='Company ID';
	}
	else if(document.forms[0].optformtype[2].checked==true)
	{
		document.all.cname1.innerHTML='Borrower Name';
		document.all.cid1.innerHTML='PAN No';
		document.all.cname2.innerHTML='Applicant Name';
		document.all.cid2.innerHTML='PAN No';
	}
	
	else if(document.forms[0].optformtype[3].checked==true)
	{
		document.all.cname1.innerHTML='Borrower Name';
		document.all.cid1.innerHTML='PAN No';
		document.all.cname2.innerHTML='Applicant Name';
		document.all.cid2.innerHTML='PAN No';
	}
	}
function doClose()
{
	document.frmundelapp.target="mainFrame";
	document.frmundelapp.action="<%=ApplicationParams.getAppUrl()%>action/setupnav.jsp";
	document.frmundelapp.submit();
}

function menuOptionDivMouseDown (url) 
{
	document.currentMenu.style.display='none';
	document.currentMBarOpt.style.border='1px solid lightgrey';
	document.menuIsActive = false;
	document.frmundelapp.action=url;
	document.frmundelapp.submit();
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="frmundelapp" method="post" class="normal">
<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td>
	    <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr>
            <td class="page_flow">Home -&gt; Setup -&gt; Restore Deleted Applications</td>
          </tr>
        </table>		
      </td>
    </tr>
 </table>
<input type="hidden" name="dispData">
  <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td>&nbsp; </td>
    </tr>
  </table>
  <table class="outertable"  width="100%" border="1" cellspacing="0" cellpadding="3" >
    <tr> 
      <td valign="top">
        <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0" height="392" align="center">
          <tr> 
            <td height="231" valign="top"> 
              <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="2" height="387">
                <tr> 
                  <td height="15" valign="top"> 
                    <table class="outertable"  width="100%" border="1" cellspacing="0" cellpadding="2">
                      <tr> 
                        <td height="97" valign="top"> 
                          <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="5">
                            <tr> 
                              <td height="20"><b>Get all deleted forms</b></td>
                            </tr>
                            <tr> 
                              <td valign="top" > 
                                <table class="outertable"  width="85%" border="1" cellspacing="0" cellpadding="0" >
                                  <tr> 
                                    <td> 
                                      <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="5">
                                        <tr> 
                                          <td colspan="2"><b>Form Type</b></td>
                                          <td width="4%"></td>
                                          <td>&nbsp;</td> <td>&nbsp;</td> <td>&nbsp;</td> <td>&nbsp;</td>
                                        </tr>
                                        <tr> 
                                          <td width="4%"> 
                                            <input type="radio" name="optformtype" style="border-style:none" value="P" onClick="changelbl();">
                                            </td>
                                          <td width="20%">Retail</td>
                                          <td width="4%">  
                                            <input type="radio" name="optformtype" style="border-style:none" value="C" onClick="changelbl();" >
                                            </td>
                                          <td width="20%">Corporate</td>
                                          <td width="4%">  
                                            <input type="radio" name="optformtype" style="border-style:none" value="A" onClick="changelbl();" >
                                            </td>
                                          <td width="21%">Agriculture</td>
                                          <td width="6%"> 
                                            <input type="radio" name="optformtype" style="border-style:none" value="T" onClick="changelbl();" >
                                            </td>
                                          <td width="21%">Tertiary</td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr> 
                              <td width="84%"> 
                                <table class="outertable"  width="100%" border="1" cellspacing="0" cellpadding="0" >
                                  <tr> 
                                    <td> 
                                      <table class="outertable"  width="85%" border="0" cellspacing="0" cellpadding="5">
                                        <tr> 
                                          <td colspan="2"><b>Search by </b></td>
                                          <td width="4%"></td>
                                          <td width="24%"></td>
                                          <td width="5%"></td>
                                          <td width="24%"></td>
                                          <td width="10%"></td>
                                          <td width="17%">&nbsp;</td>
                                          <td width="17%">&nbsp;</td>
                                          <td width="17%"></td>
                                        </tr>
                                        <tr> 
                                          <td width="5%">  
                                            <input type="radio" name="optstype" value="A" style="border-style:none" onClick="placeCursor()">
                                            </td>
                                          <td width="30%">Application 
                                            No.</td>
                                          <td width="5%">  
                                            <input type="radio" name="optstype" value="N" style="border-style:none" onClick="placeCursor()">
                                            </td>
                                          <td width="26%" id="cname1">Borrower 
                                            Name</td>
                                          <td width="5%">  
                                            <input type="radio" name="optstype" value="S"  style="border-style:none" onClick="placeCursor()">
                                            </td>
                                          <td width="22%" id="cid1">PAN 
                                            No.</td>
                                          <td colspan="2"> 
                                            <input type="text" name="txtsearch" maxlength="50" size="20" style="border-style:groove"  >
                                            </td>
                                          <td colspan="2"> 
                                              
                                            <input type="button" name="cmdSearch" value="Search" class="buttonstyle"  onclick="javascript:frmSubmit()">
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
                <tr> 
                  <td valign="top"> 
                    <table class="outertable linebor"  width="98%" cellspacing="0" cellpadding="0">
                      <tr class="dataheader"> 
                        <th>Application No.</th>
                        <th id="cid2">PAN No</th>
                        <th  id="cname2">Applicant Name</th>
                        <th>Organisation</th>
                        <th>Deleted 
                          By</th>
                    </table>
                    <IFRAME name="disp" SRC="<%=ApplicationParams.getAppUrl()%>action/dispundelapp.jsp" WIDTH="100%" HEIGHT=220 frameborder="no"></IFRAME> 
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
  <lapschoice:combuttonnew btnnames="Undelete" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />							
   <lapschoice:hiddentag pageid='<%=PageId%>'/> 
  </form>
</body>
</html>
