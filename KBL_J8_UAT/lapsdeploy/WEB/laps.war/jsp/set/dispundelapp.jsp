<%@ include file="../share/directives.jsp"%>

<%
ArrayList vecVal = (ArrayList)hshValues.get("vecVal");
System. out.println(vecVal);
ArrayList vecR = null;
int count =0;

String strMessage="";
String strStatus="";
if(hshValues!=null)
{
	strMessage=Helper.correctNull((String)hshValues.get("Message"));
	strStatus=Helper.correctNull((String)hshValues.get("status"));
	
}
////System.out.println(strStatus);
%>
<html>
<head>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script>
function unselectAppno()
{	//parent.document.frmundelapp.cmderase.disabled=true;

	if("<%=strStatus%>"=="Sucess")
	{
		alert("<%=strMessage%>");
	}

	parent.document.frmundelapp.cmdundelete.disabled=true;
}

function chkAppno(inwardno)

{

	var strDisp = false;
	var strNo=0;
	if(document.dispundelete.chkboxno.value>1)
	{
		for(var i=0;i<document.dispundelete.chkappno.length;i++)
		{
			if(document.dispundelete.chkappno[i].checked==true)
			{
				strNo = strNo+1;
				strDisp = true;
			}
		}
		document.dispundelete.selAppno.value = strNo;
		document.dispundelete.hidinwardno.value = inwardno;
		if(strDisp==true)
		{
			//parent.document.frmundelapp.cmderase.disabled=false;
			parent.document.frmundelapp.cmdundelete.disabled=false;
		}
		else
		{
			//parent.document.frmundelapp.cmderase.disabled=true;
			parent.document.frmundelapp.cmdundelete.disabled=true;
		}
	}
	else
	{
		if(document.dispundelete.chkappno.checked==true)
		{
			strNo = strNo+1;
			strDisp = true;
		}

		document.dispundelete.selAppno.value = strNo;
		document.dispundelete.hidinwardno.value = inwardno;
		if(strDisp==true)
		{
			//parent.document.frmundelapp.cmderase.disabled=false;
			parent.document.frmundelapp.cmdundelete.disabled=false;
		}
		else
		{
			//parent.document.frmundelapp.cmderase.disabled=true;
			parent.document.frmundelapp.cmdundelete.disabled=true;
		}


	}

}
</script>
<body onload="unselectAppno()" >
<form name="dispundelete" method="post" class="normal">
<input type="hidden"  name="dispData">
<input type="hidden" name="optformtype" >
<input type="hidden" name="optstype" >
<input type="hidden" name="txtsearch" >

<input type="hidden" name="selAppno">
 </b> 
  <table class="outertable"  width="100%" cellpadding="3" cellspacing="1">
    <% 
  if(vecVal!=null)
  {
	  int vecsize=vecVal.size();
	  if (vecsize != 0) 
		{ //out.println(vecVal);
  		for(int i=0;i<vecsize;i++)
 			 {
  				vecR = new ArrayList();
				vecR  =(ArrayList)vecVal.get(i);


 	 %>
    <tr class="datagrid"> 
      <td width="3%"><b> 
        <input type="radio" style="border:none;" name="chkappno" onClick="javascript:chkAppno(<%=Helper.correctNull((String)vecR.get(6))%>)" value="<%=vecR.get(0)%>" >
        </b></td>
      <td width="20%" align="center"> <b> 
        <%=vecR.get(0)%></b></td>
      <td width="15%"><b><%=Helper.correctNull((String)vecR.get(1))%></b></td>
      <td width="26%"><b><%=Helper.correctNull((String)vecR.get(2))%></b></td>
      <td width="23%"><b><%=Helper.correctNull((String)vecR.get(3))%></b></td>
      <td width="13%"><b><%=Helper.correctNull((String)vecR.get(4))%></b></td>
    </tr>
    <% count++;
				}
			}
	  else
		{
		//out.println("123456");
		%>
	 	<tr class="datagrid">
				<td width="41%" >&nbsp;</td>
				<td width="20%" align="center"></td>
				<td width="15%" align="left"></td>
				<td width="21%" align="center"></td>
				<td width="21%" align="center"></td>
			</tr>
			<tr class="datagrid">
				<td width="41%" >&nbsp;</td>
				<td width="20%" align="center"></td>
				<td width="15%" align="left"></td>
				<td width="21%" align="center"></td>
				<td width="21%" align="center"></td>
			</tr>
			<tr class="datagrid">
				<td width="41%" >&nbsp;</td>
				<td width="20%" align="center">No Data Found</td>
				<td width="15%" align="left"></td>
				<td width="21%" align="center"></td>
				<td width="21%" align="center"></td>
			</tr>
	   		<%
		   }
	  }
	    %>
  </table>
     <lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="chkboxno" value="<%=count%>" >
<input type="hidden" name="hidinwardno" value="" >
</form>
</body>
</html>