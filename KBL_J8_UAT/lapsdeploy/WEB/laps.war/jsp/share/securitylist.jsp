<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
 
<html>
<head>

<%
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();
		
		if (hshValues != null) 
		{
			arrRow = (ArrayList) hshValues.get("arrRow2");
		}
		int intarrSize1=0;
		if(arrRow!=null)
		{
			intarrSize1=arrRow.size();
		}
				
%>

<%
	

%>

<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script>

function display()
{
	if(document.forms[0].selProd.length == 0)
	{
		document.forms[0].selProd.disabled = true;
		document.all.dis.style.visibility="visible";
		document.all.unprod.style.visibility="hidden";
	}
	else
	{
		document.forms[0].selProd.disabled = false;
		document.all.dis.style.visibility="hidden";
		document.all.unprod.style.visibility="visible";
	}
}

function selValues(val){

	var len =0;
	var len = document.forms[0].selProd.length;
	var temp = "";
	var temp1="";
	var temp2="";
	var temp3="";
    
	if(len > 0)
	{
		if(document.forms[0].selProd.selectedIndex>=0)
		{			
			temp1=document.forms[0].selProd.options[document.forms[0].selProd.selectedIndex].text;
			temp=document.forms[0].selProd.options[document.forms[0].selProd.selectedIndex].value;
		}
		
		//window.opener.document.forms[0].elements["txtsec_type"].value=trim(temp1);
		//window.opener.document.forms[0].elements["hidsno"].value=trim(temp);
		var myval = trim(temp1);
		if(myval!=null && myval!="")
		{
			var myarr = myval.split("@");
			window.opener.document.forms[0].elements["txtsec_type"].value= myarr[0];
			window.opener.document.forms[0].elements["sel_cbssecurity"].value= myarr[1];
			window.opener.document.forms[0].elements["sel_collatflag"].value= myarr[2];
			//window.opener.showWeatherLiq();
			window.opener.document.forms[0].elements["sel_weathliquid"].value= myarr[3];			
			window.opener.document.forms[0].elements["hidsno"].value=trim(temp);	
			window.opener.document.forms[0].elements["sel_Action"].value=myarr[4];
			window.close();
		}
	}
}
function doOk()
{
	selValues();
}

function doClose()
{
	window.close();
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="display()">
<form name="purge" class="normal">
  <table width="300" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable" >
    <tr> 
      <td valign="top"> 
        <table width="300" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
          <tr> 
            <td align="left" class="datagrid" id="dis" >
              <center>
                No Data Available 
              </center>
        </td>
          </tr>
          <tr id ="unprod" style="visibility:hidden" class="datagrid">
          
             <td>Security List</td>
                    
			</tr>
			<tr >
            <td align="center" > 
              <select name="selProd" size="15" style="width:400"  onDblClick="selValues()">
              <%  intarrSize1= 0;
				  if(arrRow!=null&&arrRow.size()>0){
				  intarrSize1=arrRow.size();
				  for(int i=0;i<intarrSize1;i++){			   	
				  arrCol=(ArrayList)arrRow.get(i);
				  
		    %>
			<option value="<%=Helper.correctNull((String)arrCol.get(0))%>"><%=Helper.correctNull((String)arrCol.get(1))%></option>
												   
			<%}} %>
           </select>

            </td>
          </tr>
          <tr> 
            <td height="17">&nbsp;</td>
          </tr>
          <tr> 
            <td> 
            <lapschoice:combuttonnew btnnames="OK"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
</body>
</html>


