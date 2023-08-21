<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
 
<%
   String strPage = "";
   String beanid = "";
   String meth = "";
   String strTagValue ="";
   HashMap h = new HashMap();
   HashMap hp1 = new HashMap();
   String strListName="";
   String strV="";
   String strMsg="";
%>
<%
   strPage = (String)request.getParameter("page");
	String corpcheck=(String)request.getParameter("cat");
   beanid = (String)request.getParameter("beanid");
   meth = (String)request.getParameter("method");


   if (strPage.equalsIgnoreCase("product"))
   {
	   strV = (String)request.getParameter("cat");
	   String strV1 = (String)request.getParameter("select");
	   strTagValue = strV+"~"+strV1;
	   h.put("value",strV);
	   h.put("parent",strV1);
	   h.put("hidMethod",(String)request.getParameter("hidMethod"));	
  
	   
	   if (strV.equalsIgnoreCase("subsel"))
	   {
		   strListName = "Sub Category List";
		   strMsg ="Sub Category";
	   }
	   else
	   {
		   strListName = "Category List";
   		   strMsg ="Category";
	   }
   }
   else if (strPage.equalsIgnoreCase("workflow"))
   {
	   strListName = "List of Workflow Action";
	   strMsg ="Workflow";
	   strTagValue = (String)request.getParameter("select");
	   h.put("hidMethod",(String)request.getParameter("hidMethod"));	
	   h.put("select",strTagValue);
		
   }
      else  if (strPage.equalsIgnoreCase("facility"))
   {
	   strV = (String)request.getParameter("cat");
	   String strV1 = (String)request.getParameter("select");
	   //System.out.println("================>>>>>>"+strV1);
	   strTagValue = strV+"~"+strV1;
	   h.put("value",strV);
	   h.put("parent",strV1);
	   h.put("hidMethod",(String)request.getParameter("hidMethod"));	
	   h.put("page",(String)request.getParameter("page"));
	   h.put("setid",Helper.correctNull((String)request.getParameter("setid")));
  
	   
	   if (strV.equalsIgnoreCase("subsel"))
	   {
		   strListName = "Facility List";
		   strMsg ="Facility";
	   }
	   else
	   {
		   strListName = "Head of the Facility List";
   		   strMsg ="Head of the Facility";
	   }
   
   }
      else  if (strPage.equalsIgnoreCase("corpfacility"))
      {
   	   strV = (String)request.getParameter("cat");
   	   String strV1 = (String)request.getParameter("select");
   	   String strModType = (String)request.getParameter("modType");
   	   
   	   strTagValue = strV+"~"+strV1;
   	   h.put("value",strV);
   	   h.put("parent",strV1);
   	   h.put("hidMethod",(String)request.getParameter("hidMethod"));
   	   h.put("hidModType", strModType);
     
   	   
   	   if (strV.equalsIgnoreCase("subsel"))
   	   {
   		   strListName = "Facility List";
   		   strMsg ="Facility";
   	   }
   	   else
   	   {
   		   strListName = "Head of the Facility List";
      		   strMsg ="Head of the Facility";
   	   }
      }
   hp1.put("BeanId",beanid);
   hp1.put("MethodName",meth);
   hp1.put("BeanParam",h);
%>

<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script>
var msgname="<%=strMsg%>";
var corpcheck="<%=corpcheck%>";
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

function selectProducts(catname,page)
{
	var len =0;
	var len = document.forms[0].selProd.length;
	var temp = "";
	var temp0= "";
	var temp1="";
	var temp2="";
	var temp3="";
	var temp4="";
    
	if(len > 0)
	{
		if(document.forms[0].selProd.selectedIndex>=0)
		{
			temp1=document.forms[0].selProd.options[document.forms[0].selProd.selectedIndex].text;
			temp=document.forms[0].selProd.options[document.forms[0].selProd.selectedIndex].value;
		}
		temp0=temp.split('-');
		for(var i=0;i<temp0.length;i++)
		{temp2 =temp0[0];
		temp3 = temp0[1];
		temp4 = temp0[2];}
		//temp2 = temp.substring(0,temp.indexOf('-'));
		//temp3 = temp.substring(temp.indexOf('-')+1,temp.length);
			if (page == "parameter")
		{
			window.opener.document.forms[0].elements["txt_loantype"].value=trim(temp1);
			window.opener.document.forms[0].elements["loantype"].value=trim(temp2);
			window.opener.document.forms[0].elements["loancode"].value=trim(temp3);
		}
		if (page =="product")
		{	
			window.opener.document.forms[0].elements["txtcat_name"].value=trim(temp1);
			window.opener.document.forms[0].elements["hidcat_id"].value=trim(temp2);
			window.opener.document.forms[0].elements["hidcat_parent"].value=trim(temp3);
			window.opener.document.forms[0].elements["sel_active"].value=trim(temp4);	
			var v = window.opener.document.forms[0].elements["selProd"].length;
			
			for(i=0;i<v;i++)
			{
		 		var t= window.opener.document.forms[0].selProd.options[i].value;
				t = t.substring(0,t.indexOf('-'));				
				if(t==temp3)
				{
					window.opener.document.forms[0].selProd.options[i].selected = true; 					
				}
			}
			if (window.opener.document.forms[0].elements["txtcat_name"].value !="")
			{
				window.opener.document.forms[0].elements["txtcat_name"].disabled = false;
			}
			else
			{
				if (len > 0)
				{
					ShowAlert("111",msgname);
					document.forms[0].selProd.focus();
				}
				else
				{
					window.opener.document.forms[0].elements["txtcat_name"].disabled = true;
					window.opener.document.forms[0].elements["selprod"].options[0].selected = true;
				}
			}
		}
		else if (page =="facility") 
		{
			window.opener.document.forms[0].elements["txtcat_name"].value=trim(temp1);
			window.opener.document.forms[0].elements["hidcat_id"].value=trim(temp2);			
			arr = temp3.split("~");
			if(arr)
			{
				window.opener.document.forms[0].elements["hidcat_parent"].value=trim(arr[0]);		
				window.opener.document.forms[0].elements["txt_code"].value=trim(arr[1]);
				window.opener.document.forms[0].elements["txt_seqorder"].value=trim(arr[2]);
				if(!trim(arr[3])=='')
				{
					if(trim(arr[3])=='F')
					{
						window.opener.document.forms[0].elements["seltype"].selectedIndex=1;
					}
					else if(trim(arr[3])=='NF')
					{
						window.opener.document.forms[0].elements["seltype"].selectedIndex=2;
					}
				}
				window.opener.document.forms[0].elements["facility1"].value=trim(arr[4]);
				window.opener.document.forms[0].elements["txt_schemecode"].value=trim(arr[5]);
				window.opener.document.forms[0].elements["sel_facilityfor"].value=trim(arr[6]);
				if(!trim(arr[7])=='')
				{
				window.opener.document.forms[0].elements["sel_active"].value=trim(arr[7]);
				}
				else
					window.opener.document.forms[0].elements["sel_active"].value="S";
			}
			var v = window.opener.document.forms[0].elements["selProd"].length;
			for(i=0;i<v;i++)
			{
		 		var t= window.opener.document.forms[0].selProd.options[i].value;
				t = t.substring(0,t.indexOf('-'));
				if(t==temp3)
				{
					window.opener.document.forms[0].selProd.options[i].selected = true; 					
				}
			}
			if (window.opener.document.forms[0].elements["txtcat_name"].value !="")
			{
				window.opener.document.forms[0].elements["txtcat_name"].disabled = false;
				window.opener.document.forms[0].elements["txt_code"].disabled = false;
				window.opener.document.forms[0].elements["seltype"].disabled = false;
				window.opener.document.forms[0].elements["txt_seqorder"].disabled = false;
				window.opener.document.forms[0].elements["sel_facilityfor"].disabled=false;			     
			  						     	
			}
			else
			{
				if (len > 0)
				{
					ShowAlert("111",msgname);
					document.forms[0].selProd.focus();
				}
				else
				{
					window.opener.document.forms[0].elements["txtcat_name"].disabled = true;
					window.opener.document.forms[0].elements["txt_code"].disabled = true;
					window.opener.document.forms[0].elements["selprod"].options[0].selected = true;
					window.opener.document.forms[0].elements["sel_facilityfor"].disabled=true;
				}
			}
		}
		else if (page == "workflow")
		{
			window.opener.document.forms[0].elements["txtwrk_flowname"].value=trim(temp1);
			window.opener.document.forms[0].elements["hidwrk_flowid"].value=trim(temp2);
	 		window.opener.document.forms[0].elements["hidwrk_flowtype"].value=trim(temp3);

			var v = window.opener.document.forms[0].elements["selwork"].length;
			for(i=0;i<v;i++)
			{
				var t= window.opener.document.forms[0].selwork.options[i].value;
				t = t.substring(0,t.indexOf('-'));				
			}
			if (window.opener.document.forms[0].elements["txtwrk_flowname"].value !="")
			{
				window.opener.document.forms[0].elements["txtwrk_flowname"].disabled = false;
			}
			else
			{
				if (len > 0)
				{
					ShowAlert("111","Workflow Action");
					document.forms[0].selProd.focus();
				}
				else
				{
					window.opener.document.forms[0].elements["txtwrk_flowname"].disabled = true;
					window.opener.document.forms[0].elements["selwork"].selectedIndex="0";
				}
			}
		}
		else if (page =="corpfacility") 
		{
			if(corpcheck=="parent")
			{
				window.opener.document.forms[0].elements["txtcat_name"].value=trim(temp1);
				window.opener.document.forms[0].elements["hidcat_id"].value=trim(temp2);
				//alert("temp2----"+temp2);
				arr = temp3.split("~");
				//window.opener.document.forms[0].elements["txt_code"].value=trim(arr[1]);
				//alert("arr---"+arr);
				if(!trim(arr[3])=='')
			    {    
				 if(trim(arr[3])=='F')
				 {
					window.opener.document.forms[0].elements["seltype"].selectedIndex=1;
				 }
				 else if(trim(arr[3])=='NF')
				 {
					window.opener.document.forms[0].elements["seltype"].selectedIndex=2;
				 }
			    } 
				window.opener.document.forms[0].elements["facility1"].value=trim(arr[4]);
			}else{
			
			arr = temp3.split("~");
			if(arr)
			{
			//alert("temp2----"+temp2);
			//alert("arr---"+arr);
				window.opener.document.forms[0].elements["txt_facility"].value=trim(temp1);
				window.opener.document.forms[0].elements["hidcat_parent"].value=trim(temp2);		
				window.opener.document.forms[0].elements["txt_code"].value=trim(arr[1]);
			}
			
			}
			
		}
		if (document.forms[0].selProd.selectedIndex != -1)
		{
			window.close();
		}
	}
	else 
	{
		window.close();
	}
}
function doOk()
{
	selectProducts('<%=strTagValue%>','<%=strPage%>');
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
          
             <%=strListName%>
         
           
			</tr><tr >
            <td align="center" > 
              <select name="selProd" size=15 style="width:400"  onDblClick="selectProducts('<%=strTagValue%>','<%=strPage%>')">
                <laps:selecttag value='<%=hp1%>' /> 
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


