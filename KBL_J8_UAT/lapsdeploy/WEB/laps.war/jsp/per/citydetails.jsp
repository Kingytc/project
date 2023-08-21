<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
ArrayList v= new ArrayList();
String strFromLink =Helper.correctNull((String)request.getParameter("strfrom"));
//out.println(hshValues);
%>
<html>
<head>
<title>Branch Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" type="text/javascript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var path      ="<%=ApplicationParams.getAppUrl()%>";
var from_link = "<%=strFromLink%>";

function showLink(val1, val2,val3,val4)
{
		
		window.opener.document.forms[0].txt_cityname.value = val1;
		window.opener.document.forms[0].txt_citycode.value =val2;

		window.opener.document.forms[0].hidcityID.value =val3;
        window.opener.document.forms[0].txt_oldcitycode.value =val2;
        window.opener.document.forms[0].sel_active.value =val4;
		window.opener.document.forms[0].cmdnew.disabled =true;
		window.opener.document.forms[0].cmdedit.disabled=false;
		window.opener.document.forms[0].cmdsave.disabled=true;
		window.opener.document.forms[0].cmdnew.disabled =true;
		window.opener.document.forms[0].cmdcancel.disabled=false;
		window.opener.document.forms[0].cmdclose.disabled=false;
		window.close();
}
function doClose()
{
	window.close();}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<style> 
Div.cellContainer
{
	width:100%;
	Height:250px;
    overflow: auto;
}
</style>

<body>
<FORM name="" method="post" class="normal">
   <table class="outertable" border="0" cellspacing="1" cellpadding="3" width="98.3%">
   <tr>
   <td>
     <table class="outertable" border="0" cellspacing="1" cellpadding="3" width="98.3%">
       <tr > 
       <td width="10%" class="dataheader">&nbsp;</td>  
         <td width="90%" class="dataheader"><b>City Names</b></td>
       </tr>
     </table>
   </td>
 </tr>
 <tr> 
   <td> 
     <div class="cellcontainer"> 
       <table class="outertable" width="100%" border="0" cellspacing="1" cellpadding="3" align="center">
       	<%
       	ArrayList VecCityRow = (ArrayList)hshValues.get("VecCityRow");      
       	
       	if(VecCityRow!=null && VecCityRow.size()>0)
		{
			for(int i=0;i<VecCityRow.size();i++)
			{
				ArrayList vecData = (ArrayList) VecCityRow.get(i);
			   %>
	                 <tr class="datagrid"> 
	                 <td width="10%"  ><%=i+1%></td>
                     <td width="90%">
                     <a href="javascript:showLink('<%=Helper.correctNull((String)vecData.get(0))%>',
                     '<%=Helper.correctNull((String)vecData.get(1))%>',
                     '<%=Helper.correctNull((String)vecData.get(2))%>','<%=Helper.correctNull((String)vecData.get(3))%>')">
                     <b><%=Helper.correctNull((String)vecData.get(0))%></b></a></td>
               	<%
			}
		}
		v = (ArrayList) hshValues.get("VecCityRow");
	     
		if((v==null)||(v.size()==0))
		{	
			
			 
				%>
          <tr class="datagrid"> 
           <td>&nbsp;</td> 
           <td>&nbsp;</td>
          </tr> 
          <tr class="datagrid"> 
           <td>&nbsp;</td> 
           <td>&nbsp;</td>
          </tr>  
         <tr valign="top" > 
           <td  colspan="2"width="15%" align="center"><b>No 
             Data Found for the selected criteria</b> </td> 
         </tr>
                      
                                 
         
           <tr class="datagrid"> 
           <td width="3%">&nbsp;</td> 
           <td width="32%">&nbsp;</td>
          </tr>                         
          <tr class="datagrid"> 
           <td>&nbsp;</td> 
           <td>&nbsp;</td>
          </tr> 
          <tr class="datagrid"> 
           <td>&nbsp;</td> 
           <td>&nbsp;</td>
          </tr>  
           <tr class="datagrid"> 
           <td width="3%">&nbsp;</td> 
           <td width="32%">&nbsp;</td>
          </tr>                         
          <tr class="datagrid"> 
           <td>&nbsp;</td> 
           <td>&nbsp;</td>
          </tr> 
          <tr class="datagrid"> 
           <td>&nbsp;</td> 
           <td>&nbsp;</td>
          </tr>   
          <tr class="datagrid"> 
           <td width="3%">&nbsp;</td> 
           <td width="32%">&nbsp;</td>
          </tr>                         
          <tr class="datagrid"> 
           <td>&nbsp;</td> 
           <td>&nbsp;</td>
          </tr> 
          <tr class="datagrid"> 
           <td>&nbsp;</td> 
           <td>&nbsp;</td>
          </tr>  
                                   
          
          <%
		
		}%>
             
        </table>
      </div>
      </td>
      </tr>
      </table>
   
<br>
<lapschoice:combuttonnew btnnames="" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>

  <lapschoice:hiddentag pageid='<%=PageId%>'/> 
</FORM>
</body>
</html> 