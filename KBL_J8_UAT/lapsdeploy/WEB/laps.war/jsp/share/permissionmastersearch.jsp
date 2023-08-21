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
<title>LAPS</title>
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

function selValues(){

	
	if(document.forms[0].selProd.value!="")
	{
		var myarr = document.forms[0].selProd.value.split("~");
		window.opener.document.forms[0].elements["txt_details"].value= myarr[0];
		window.opener.document.forms[0].elements["prd_approval"].value= myarr[1];
		window.opener.document.forms[0].elements["prd_skip"].value= myarr[2];
		window.opener.document.forms[0].elements["sel_orgapp"].value= myarr[3];
		window.opener.document.forms[0].elements["sel_orgrej"].value= myarr[4];
		window.opener.document.forms[0].elements["sel_termid"].value= myarr[5];
		window.opener.document.forms[0].elements["sel_status"].value= myarr[6];	
		window.opener.document.forms[0].elements["sel_interest"].value= myarr[7];
		window.opener.document.forms[0].elements["sel_financial"].value= myarr[8];
		window.opener.document.forms[0].elements["hidsno"].value=myarr[9];
		window.opener.showDescApp(window.opener.document.forms[0].prd_approval.value);
		window.opener.showDescSkip(window.opener.document.forms[0].prd_skip.value);
		window.opener.document.forms[0].cmdnew.disabled=true;	
		window.opener.document.forms[0].cmdedit.disabled=false;
		window.opener.document.forms[0].cmdcancel.disabled=false;
		window.close();
	}
}
function doOk(){selValues();}
function doClose()
{
	window.close();
}
</script>
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
          
             <td>Permission List</td>
             </tr>
			<tr >
            <td align="center" > 
              <select name="selProd" size="15" style="width:400"  onDblClick="selValues();">
              <%  intarrSize1= 0;
				  if(arrRow!=null&&arrRow.size()>0){
				  intarrSize1=arrRow.size();
				  for(int i=0;i<intarrSize1;i++){			   	
				  arrCol=(ArrayList)arrRow.get(i);
		    %>
			<option value="<%=Helper.correctNull((String)arrCol.get(1))%>"><%=Helper.correctNull((String)arrCol.get(2))%></option>
												   
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
  	<input type="hidden" name="hidname"  >
</form>
</body>
</html>
