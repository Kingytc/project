<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />  
<lapschoice:handleerror />
<%
%>

<head>
<title>National Portal  - Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script>
var path="<%=ApplicationParams.getAppUrl()%>";
var param="";
var userid ="<%=(String)session.getAttribute("strUserId")%>";
var rights ="<%=(String)session.getAttribute("strGroupRights")%>";

function closeData()
{
	if (ConfirmMsg("100"))
	{
		document.forms[0].action=path+"action/repnav.jsp";
		document.forms[0].submit();
	}
}

function resetValues()
{
	document.forms[0].sellevel.options[0].selected =true;
	document.forms[0].rpselect1.length =0;
	document.forms[0].txtdfrom.value ="";
	document.forms[0].txtdto.value ="";

}
function showPeriod()
{
	var purl = path+"jsp/share/repdateselect.jsp";
	var title = "ListofPeriod";
	var prop = "scrollbars=no,width=350,height=320";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}
function runrep()
{
	if(document.forms[0].sellevel.value=="")
	{
		alert("Select Organisation Level");
		return;
	}
	
	if(document.forms[0].rpselect1.value=="")
	{
		alert("Select Organisation");
		return;
	}
	if(document.forms[0].txtDate.value=="")
	{
		alert("Select Period");
		return;
	}
	
	if(document.forms[0].sel_status.value=="S")
	{
		alert("Select Status");
		return;
	}
	
	if(document.forms[0].selsegment.value=="0")
	{
		alert("Select Segment");
		return;
	}
	if(document.forms[0].selscheme.value=="0")
	{
		alert("Select National Portal Scheme");
		return;
	}
	
	var level=document.forms[0].sellevel.value;
	var orgselect=document.forms[0].rpselect1.value;
	var org_name="";
	var org="";
	var status=document.forms[0].sel_status.value;
	var dt = document.forms[0].txtDate.value;
	var count =0;
	for(x=0;x<document.forms[0].rpselect1.length;x++)
	{
		if (document.forms[0].rpselect1[x].selected)
		{
			count++;
			var c = document.forms[0].rpselect1.options[x].value;
			c = c.substring(3,c.length);
			org =org+ "'0"+c+"'"+",";
			
				c = document.forms[0].rpselect1.options[x].text;
				org_name =org_name + "," + c ;
		}
	}
	if (count > 0)
	{
		org= org.substring(0,org.length-1);
		org_name= org_name.substring(1,org_name.length);
	}
	document.forms[0].method="post";
	var varscheme=document.forms[0].selscheme.value;
	var varsegment=document.forms[0].selsegment.value;

	window.open(path+"action/NP_Reportlist.jsp?hidBeanId=NationalPortal&hidBeanMethod=getNPReportList&hidMethod=getNPReportList&sellevel="
			+level+"&orgselect="+orgselect+"&org_name="+org+"&txtDate="+dt+"&hidStatus="+status+"&scheme="+varscheme+"&segment="+varsegment
		    +"","scrollbars=Yes,toolbars=NO,menubar=NO ,width=900 , height=500,top=10,left=10");
	
}

function callCalender(fname)
{
	 showCal("<%=ApplicationParams.getAppUrl()%>", fname);
}
function selectValues()
{
	var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
	 document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>

<body>
<form class="normal" name="perappstat" method="post">
<iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
  <br>
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td class="page_flow">Home -&gt;All Report  -&gt;NP Report in LAS</td>
    </tr>
    <tr> 
      <td align="right">&nbsp; </td>
    </tr>
  </table>

  
        <table class="outertable border1 margin1" border="0" cellspacing="0" cellpadding="3" align="center" width="60%" >
          <tr> 
            <td> 
             
                    <table class="outertable" width="95%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td width="30%" align="center">Organisation Level</td>
                       <td width="10%" align="center">Status&nbsp;</td>
                       <td width="30%"  align="center"> Segment </td>
                        <td width="30%"  align="center">National Portal Scheme</td>
                      </tr>
                      <tr> 
                       <td width="30%" align="center"> <select name="sellevel" style="width:100" onChange="selectValues()" tabindex="1" >
                            <option selected>&lt;---Select---&gt;</option>
                            <lapschoice:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                          </select></td>
                          
					         <td width="10%" align="center">    <select name="sel_status">
					              <option value="S">&lt;---Select---&gt;</option>
						             <option value="O">Open /Pending</option>
									 <option value="H">Hold</option>
									 <option value="SA">Sanctioned</option>
									 <option value="R">Reject</option>
				             	</select>
				             </td>
				             <td width="30%"  align="center">
			<select name="selsegment" tabindex="1">
					<option value="0">&lt;---Select---&gt;</option>
					<lapschoice:StaticDataNewTag apptype="262" />
			</select>
	</td>
	<td width="30%"  align="center">
			<select name="selscheme" tabindex="1" >
					<option value="0">&lt;---Select---&gt;</option>
					<option value="1">Dr. Ambedkar Central Sector Scheme</option>
					<!--<option value="2">Padho Pardesh Scheme</option>
			--></select>
	</td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td width="75%" valign="top" colspan="2">
                    <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="4">
	                      <tr align="center"> 
	                        <td align="center" width="96%">Select Organisation </td>
	                        <td align="center" width="4%">&nbsp; </td>
	                  	  </tr>
	                      <tr align="center"> 
	                        <td width="96%"> 
	                          <select name="rpselect1" size="11"  style="width:230" tabindex="4" multiple ></select>
	                        </td>
	                      </tr>
	                    
	                     <tr > 
                                <td width="21%" align="center">Period 
                                   <input type="text" name="txtDate" maxlength="21" readonly size="25" onFocus="document.forms[0].rprunreport.focus();">
                                  <a href="#" onClick="JavaScript:showPeriod()" class="blackfont"><b>?</b></a> 
                                  </td>
                              </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  
            
  <br>
  <table class="outertable" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td> 
        <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top"> 
            <td height="0" width="16%"> 
              <div align="center"> 
                <input type="button" name="rprunreport" value="Run Report" class="buttonothers" onClick="runrep()">
              </div>
            </td>
            <td height="0" width="15%"> 
              <div align="center"> 
                <input type="reset" name="rpreset" value="Reset" class="buttonothers"  onClick="JavaScript:resetValues()">
              </div>
            </td>
            <td height="0" width="21%"> 
              <div align="center"> 
                <input type="button" name="rpclose" value="Close" class="buttonClose" onClick="JavaScript:closeData()">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
</body>
</html>
