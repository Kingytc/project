function showPeriod()
{
	document.forms[0].txtDate.value="";
	var purl = path+"jsp/share/repdateselect.jsp";
	var title = "ListofPeriod";
	var prop = "scrollbars=no,width=400,height=400";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}
function selectValues()
{
	document.forms[0].rpselect1.selectedIndex =-1;
	var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
 document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;
}

function doClose()
{
	if (ConfirmMsg("100"))
	{
	document.forms[0].hidBeanId.disabled=true;
	document.forms[0].action=path+"action/apprepnav.jsp";
	document.forms[0].submit();
	}
}

function callonLoad()
{
	document.forms[0].hidBeanId.value="perrepappstatus";
}
function doRunReport()
{
	var param = setParam();
	var outf =document.forms[0].hidOpFields.value;
	var dbf =document.forms[0].hidSelFields.value;	 
	var code =document.forms[0].hidOrgCode.value;
	var orglevel=document.forms[0].sellevel.value;
	var dt=document.forms[0].txtDate.value;
	var sdt=document.forms[0].txtSaveDate.value;

	var orgname = document.forms[0].hidOrgName.value;
	var stat= document.forms[0].sel_reporttype.value;
	if (document.forms[0].txtDate.value == "")
	{
		ShowAlert('121',"Period");
		document.forms[0].txtDate.focus();
		return false;
	}
	if (param !="")
	{
		window.open(path+"action/perrepappemandatereport.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getemandateDetails&hidStatus="+stat+"&txtDate="+dt+"&txtSaveDate="+sdt+"&hidOrgCode="+code+"&hidOpFields="+outf+"&hidSelFields="+dbf+"&orglevel="+orglevel+"&hidOrgName="+orgname,"stat","scrollbars=Yes,toolbars=No,menubar=no ,width=850 , height=550,top=10,left=10");
	}
}

function setParam()
{
	var opfields="";
	var dbfields="";
	var orgcode="";
	var orgname="";
	var count=0;
	var org="";
	var org_name="";
	param="";
	var stat=""
	if(document.forms[0].sellevel.selectedIndex != 0 &&	document.forms[0].rpselect1.selectedIndex != -1 ) 
	{
		var dt =document.forms[0].txtDate.value;
		for (i=0;i<document.forms[0].rpselect2.length;i++)
        {
			if (document.forms[0].rpselect2.options[i].selected == true)
			{
				count++;
			}		
        }
		if(count == 0)
		{
			for(i=0;i<8;i++)
			{
				document.forms[0].rpselect2.options[i].selected = true;
			}
		}
		orgcode =document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].text;
        count =0;
		for(x=0;x<document.forms[0].rpselect1.length;x++)
		{
			if (document.forms[0].rpselect1[x].selected)
			{
				count++;
				var c = document.forms[0].rpselect1.options[x].value;
				c = c.substring(2,c.length);
				org =org + "'"+c+"'"+",";
				c = document.forms[0].rpselect1.options[x].text;
				org_name =org_name + "," + c ;				
			}
		}
		if (count > 0)
		{
			org= org.substring(0,org.length-1);
			org_name= org_name.substring(1,org_name.length);
		}
		param =orgcode+";"+org+";"+stat+";"+dt+";";
		count =0;
		for(x=0;x<document.forms[0].rpselect2.length;x++)
		{
			if (document.forms[0].rpselect2[x].selected)
			{
				count++;
				dbfields =dbfields +document.forms[0].rpselect2.options[x].text+",";
				opfields =opfields +document.forms[0].rpselect2.options[x].value+",";
			}
		}
		if (count > 0)
		{
			dbfields= dbfields.substring(0,dbfields.length-1);
			opfields= opfields.substring(0,opfields.length-1);
		}
	param +=opfields+";";
	param +=dbfields;
	document.forms[0].hidParam.value=param;
	document.forms[0].hidOrgCode.value =org;	
	document.forms[0].hidOpFields.value =opfields;	
	document.forms[0].hidSelFields.value =dbfields;	
	document.forms[0].hidOrgName.value =org_name;	
	}
	else if(document.forms[0].sellevel.selectedIndex == 0)
	{
		ShowAlert('111',"Organisation Level");
		document.forms[0].sellevel.focus();
		return false;
	}
	else if(document.forms[0].rpselect1.selectedIndex == -1)
	{
		ShowAlert('111','Organisation');
		document.forms[0].rpselect1.focus();
		return false;
	}
	
	return param;
}
function doExcelImport()
{
	var param = setParam();
	var outf =document.forms[0].hidOpFields.value;
	var dbf =document.forms[0].hidSelFields.value;	 
	var code =document.forms[0].hidOrgCode.value;
	var orglevel=document.forms[0].sellevel.value;
	var dt=document.forms[0].txtDate.value;
	var sdt=document.forms[0].txtSaveDate.value;

	var orgname = document.forms[0].hidOrgName.value;
	var stat= document.forms[0].sel_reporttype.value;
	if (document.forms[0].txtDate.value == "")
	{
		ShowAlert('121',"Period");
		document.forms[0].txtDate.focus();
		return false;
	}
	if (param !="")
	{
		var FileName='Pending Digital Loan Application Report';
		var prop="scrollbars=yes,menubar=yes,width=1400, height=650, top=10, left=10";
        if (param !="")
        {
        	window.open(path+"action/"+FileName+".xls?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getemandateDetailsExcel&hidStatus="+stat+"&txtDate="+dt+"&txtSaveDate="+sdt+"&hidOrgCode="+code+"&hidOpFields="+outf+"&hidSelFields="+dbf+"&orglevel="+orglevel+"&hidOrgName="+orgname,"BuilderReport",prop);
        }
	}
}