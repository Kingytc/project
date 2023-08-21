function selectValues()
{
	document.forms[0].rpselect1.selectedIndex = -1;
	bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
	document.all.ifrm.src=path+"action/iframeorgrep.jsp?hidBeanMethod=getData&hidMethod=getListValues&hidBeanId=setupreport&bnklevel="+bnkname;
}
function selectAvail()
{
	document.forms[0].rpselect1.selectedIndex = -1;
}
function doRunReport()
{
	var param = setParam();
	var outf =document.forms[0].hidOpFields.value;
	var dbf =document.forms[0].hidSelFields.value;	 
	var code =document.forms[0].hidOrgCode.value;
	var og=document.forms[0].hidOrgCode.value;
	var cls=document.forms[0].hidClass.value;
	var avail =document.forms[0].selavail.options[document.forms[0].selavail.selectedIndex].value;
	var dt =document.forms[0].txtDate.value;
	if (param !="")
	{
		window.open(path+"action/runuserdefrep.jsp?hidBeanId=userdef&hidBeanMethod=getData&hidMethod=getRepDetails&hidAvail="+avail+"&hidOrgCode="+og+"&hidClass="+cls+"&hidOpFields="+outf+"&txtDate="+dt+"&hidSelFields="+dbf,"Prod","scrollbars=Yes,toolbars=No,menubar=no ,width=750 , height=550,top=10,left=10");
	}
		
	
}

function setParam()
{
	var opfields="";
	var dbfields="";
	var og="";
	var cls="";
	var orgcode="";
	var count=0;
	var avail=""
	param="";

	if(document.forms[0].sellevel.selectedIndex != 0 && 
		document.forms[0].selavail.selectedIndex != 0 && 
		document.forms[0].rpselect1.selectedIndex != -1 && 
		document.forms[0].selclass.selectedIndex != -1 	) 
	{
				
		for (i=0;i<document.forms[0].rpselect2.length;i++)
        {
			if (document.forms[0].rpselect2.options[i].selected == true)
			{
				count++;
			}
        }
		if(count < 6)
		{
			for(i=0;i<5;i++)
			{
				document.forms[0].rpselect2.options[i].selected = true;
			}
		}
		orgcode =document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].text;
avail =document.forms[0].selavail.options[document.forms[0].selavail.selectedIndex].value;
	   
		param =orgcode+";";
		param +=avail+";";
		count=0;
		for(x=0;x<document.forms[0].rpselect1.length;x++)
		{
			if (document.forms[0].rpselect1[x].selected)
			{
				count++;
				var code =document.forms[0].rpselect1.options[x].value;
				code = code.substring(2,code.length);
				og =og +"'"+code+"'"+",";
			}
		}
		if (count > 0)
		{
			og= og.substring(0,og.length-1);
		}
		param +=og+";";
		count=0;
		for(x=0;x<document.forms[0].selclass.length;x++)
		{
			if (document.forms[0].selclass[x].selected)
			{
				count++;
				cls =cls +document.forms[0].selclass.options[x].text+",";
							
			}
		}
		if (count > 0)
		{
			cls= cls.substring(0,cls.length-1);
		}
		param +=cls+";";
		for(x=0;x<document.forms[0].rpselect2.length;x++)
		{
			if (document.forms[0].rpselect2[x].selected)
			{
				count++;
				opfields =opfields +document.forms[0].rpselect2.options[x].value+",";
				dbfields =dbfields +document.forms[0].rpselect2.options[x].text+",";
							
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
		document.forms[0].hidOrgCode.value = og;
		document.forms[0].hidClass.value =cls;
		document.forms[0].hidOpFields.value =opfields;	
		document.forms[0].hidSelFields.value =dbfields;	
		
	}
	else if(document.forms[0].sellevel.selectedIndex == 0)
	{
		ShowAlert("111","Organisation Level");
		document.forms[0].sellevel.focus();
		return false;
	}
	else if(document.forms[0].selavail.selectedIndex == 0)
	{
		ShowAlert("111","Availability");
		document.forms[0].selavail.focus();
		return false;
	}
	else if(document.forms[0].rpselect1.selectedIndex == -1)
	{
		 ShowAlert("111","Organisation Name");
		document.forms[0].rpselect1.focus();
		return false;
	}
	else if(document.forms[0].selclass.selectedIndex == -1)
	{
		ShowAlert("111","Class");
		document.forms[0].selclass.focus();
		return false;
	}
	
	return param;
}
function save()
{
	var purl="";
	var title = "SaveReport";
	var prop = "scrollbars=no,width=350,height=320";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	var usrid =userid;
	var beanid ="repData";
	var action="Insert";
	var source="/action/orgdetrep.jsp";
	var repname=document.forms[0].repname.value;
	
	var param = setParam();
	if (param !="")
	{
		purl =path+"action/savereport.jsp?BeanId="+beanid+"&Action="+action;
		purl +="&Source="+source+"&repname="+repname+"&param="+param;
		window.open(purl,title,prop);
	}
}
function browse()
{
	var user=userid;
	var purl="";
	var title = "BrowseReport";
	var prop = "scrollbars=no,width=400,height=300";	
	var xpos = (screen.width - 400) / 2;
	var ypos = (screen.height - 320) / 2;
	var rep=document.forms[0].repname.value;
	prop = prop + ",left="+xpos+",top="+ypos;
	purl =path+"action/browsereport.jsp?BeanId= setupreport&userid="+user+"&method=getProfileNames&repname="+rep;
	window.open(purl,title,prop);
}
function doReset()
{
	document.forms[0].sellevel.options[0].selected =true;
	document.forms[0].rpselect1.length =0;

}
function doClose()
{
	if (ConfirmMsg("100"))
	{
	document.forms[0].reset();
	document.forms[0].action=path+"jsp/set/setuprepnav.jsp";
	document.forms[0].submit();
	}
}