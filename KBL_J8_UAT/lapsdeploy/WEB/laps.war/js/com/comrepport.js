function showPeriod()
{
	document.forms[0].txtDate.value="";
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
	if(document.forms[0].cattype.selectedIndex == 2 && document.forms[0].sellevel.selectedIndex == 0)
	{
		ShowAlert('111',"Organisation Level");
		document.forms[0].sellevel.focus();
		return false;
	}
	if(document.forms[0].sellevel.disabled == false && document.forms[0].rpselect1.selectedIndex == -1)
	{
		ShowAlert('111','Organisation');
		document.forms[0].rpselect1.focus();
		return false;
	}
	var param = setParam();
	var outf =document.forms[0].hidOpFields.value;
	var dbf =document.forms[0].hidSelFields.value;	 
	var code =document.forms[0].hidOrgCode.value;
	var dt=document.forms[0].txtDate.value;
	var sdt =document.forms[0].txtSaveDate.value;
    var cat =document.forms[0].hidcat.value;
	if (param !="")
	{
		//alert(path+"action/comrunport.jsp?hidBeanId=comrepport&hidBeanMethod=getData&hidMethod=getRepDetails&txtDate="+dt+"&hidOrgCode="+code+"&txtSaveDate="+sdt+"&hidOpFields="+outf+"&hidSelFields="+dbf,"Prod","scrollbars=Yes,toolbars=No,menubar=no ,width=750 , height=550,top=10,left=10");
		window.open(path+"action/comrunport.jsp?hidBeanId=comrepport&hidBeanMethod=getData&hidMethod=getRepDetails&txtDate="+dt+"&hidOrgCode="+code+"&txtSaveDate="+sdt+"&cattype="+cat+"&hidOpFields="+outf+"&hidSelFields="+dbf,"Prod","scrollbars=Yes,toolbars=No,menubar=no ,width=750 , height=550,top=10,left=10");
	}
		
	
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
	var source="/action/comrepport.jsp";
	var repname=document.forms[0].repname.value;
	
	var param = setParam();
	if (param !="")
	{
		purl =path+"action/savereport.jsp?BeanId="+beanid+"&Action="+action;
		purl +="&Source="+source+"&repname="+repname+"&param="+param;
		//alert(purl);
		window.open(purl,title,prop);
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
	param="";
	 
	if(document.forms[0].cattype.value != "")
	{
	
	if (document.forms[0].txtDate.value == "")
	{
		document.forms[0].txtDate.value="All";
	}
   var dt =document.forms[0].txtDate.value;

		for (i=0;i<document.forms[0].rpselect2.length;i++)
        {
			if (document.forms[0].rpselect2.options[i].selected == true)
			{
				count++;
			}
        }
		
		if(count < 4)
		{
			for(i=0;i<4;i++)
			{
				document.forms[0].rpselect2.options[i].selected = true;
			}
		}
		count=0;
		for(x=0;x<document.forms[0].rpselect1.length;x++)
		{
			if (document.forms[0].rpselect1[x].selected)
			{
				count++;
				var val = document.forms[0].rpselect1.options[x].value;
				val = val.substring(2,val.length);
				orgcode =orgcode +"'"+val+"'"+",";
			}
		}
		if (count > 0)
		{
			orgcode= orgcode.substring(0,orgcode.length-1);
		}
		
		count=0;
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
		org =document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].text;
		catval=document.forms[0].cattype.value; 
			
		param =org+";"+orgcode+";"+dt+";";
		param +=opfields+";";
		param +=dbfields+";";
		param +=catval;
	

		document.forms[0].hidParam.value=param;
		document.forms[0].hidOrgCode.value =orgcode;
		document.forms[0].hidOpFields.value =opfields;	
		document.forms[0].hidSelFields.value =dbfields;
		document.forms[0].hidcat.value =catval;

	}
	
	
	return param;
}

function browse()
{     var cat =document.forms[0].hidcat.value;

	var user=userid;
	var rep=document.forms[0].repname.value;
	var purl="";
	var title = "BrowseReport";
	var prop = "scrollbars=no,width=400,height=300";	
	var xpos = (screen.width - 400) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	purl =path+"action/browsereport.jsp?BeanId= repData&userid="+user+"&method=getProfileNames&repname="+rep;
	window.open(purl,title,prop);
}

function resetValues()
{
	document.forms[0].sellevel.options[0].selected =true;
	document.forms[0].rpselect1.length =0;
	document.forms[0].txtDate.value="";
	//document.all.rangetd.style.visibility="hidden";
}
function closeWindow()
{
	if (ConfirmMsg("100"))
	{
	document.forms[0].hidBeanId.disabled=true;
	document.forms[0].action=path+"action/comrepappnav.jsp";
	document.forms[0].submit();
	}
}


function selectValues()
{
	document.forms[0].rpselect1.selectedIndex =-1;
	if (document.forms[0].sellevel.selectedIndex != 0)
	{
	bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].text;
    bnkname = bnkname.substring(0,1); document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;
	}
	else if (document.forms[0].sellevel.selectedIndex == 0)
	{
		resetValues();
	}
}


function callCalender(fname)
 {
	 showCal(path,fname);
 }
