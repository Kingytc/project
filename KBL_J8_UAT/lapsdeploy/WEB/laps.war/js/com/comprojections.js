	function doAfterEdit()
	{
		
		if( editcheck == "yes" )
		{
			//if( editlockflag == "y" )
			{
				disableCommandButtons("edit");
			}
			/*else
			{
				disableFields(true);
				disableCommandButtons("load");
				ShowAlert(128);
			}*/
		}
		else
		{
			disableFields(true);
			disableCommandButtons("load");
		}
	}
	function disableCommandButtons(val)
	{
	  if(val=="load")
	  {
		  if(editflag==1)
			  document.forms[0].cmdedit.disabled=false;
		  document.forms[0].cmddel.disabled=true;
		  document.forms[0].cmdapply.disabled=true;
		  document.forms[0].cmdcancel.disabled=true;
		  document.forms[0].cmdaudit.disabled=false;
		  document.forms[0].cmdclose.disabled=false;
	  }
	  if(val=="edit")
	  {
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddel.disabled=false;
		 document.forms[0].cmdapply.disabled=false;
		 document.forms[0].cmdaudit.disabled=true;
		 document.forms[0].cmdcancel.disabled=false;
		 document.forms[0].cmdclose.disabled=true;
	  }
	}
	function editDatas()
	{
		setFocus();
		loadValues();
	}
	function doEdit()
	{

		document.forms[0].hidBeanId.value="comprojtechswd";
		document.forms[0].hideditflag.value = "yes";
		document.forms[0].hidBeanGetMethod.value = "getData";
		document.forms[0].action = path+"action/comprojections.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
	function getComment(strCom)
	{
		if(strCom!="")
		{	
			var str = new String(strCom);
			var myexp = /~/g;
			strCom=str.replace(myexp,"\n");
		}
		return strCom;
	}
	function disableFields(val)
	{
		document.forms[0].taaproj_comment1.readOnly = val;
		document.forms[0].taaproj_comment2.readOnly = val;
	}

	function checkTextArea(comment)
	{
		if(comment!="")
		{
			for(var i=0;i<comment.length;i++)
			{
				if (comment.charAt(i)=="\n")
				{
					comment = comment.substring(0,i-1) + "~" + comment.substring(i+1,comment.length);
				}
			}
		}
		if(comment.length>2000)
		{
			comment=comment.substring(0,2000);
		}
		return comment;	
	}
	function setFocus()
	{
		document.forms[0].taaproj_comment1.focus();
	}
	function doSave()
	{
		if (trim(document.forms[0].taaproj_comment1.value)!="" || 
			trim(document.forms[0].taaproj_comment2.value) !="" )
		{
			document.forms[0].taaproj_comment1.value=checkTextArea(trim(document.forms[0].taaproj_comment1.value));
			document.forms[0].taaproj_comment2.value=checkTextArea(trim(document.forms[0].taaproj_comment2.value));
			
			document.forms[0].hidBeanId.value="comprojtechswd";
			document.forms[0].hidBeanMethod.value="updateData";
			document.forms[0].hidSourceUrl.value="/action/comprojections.jsp";
			document.forms[0].action=path+"controllerservlet";
			document.forms[0].submit();
		}
		else
		{
			ShowAlert("121","Values");
			setFocus();
			return false;
		}
		
	}

	function doCancel()
	{
		if(ConfirmMsg(102))
		{
			document.forms[0].hideditflag.value = "no";
			document.forms[0].hidBeanGetMethod.value = "getData";
			document.forms[0].action = path+"action/comprojections.jsp";
			document.forms[0].method="post";
			document.forms[0].submit();
		}
	}

	function doRecord()
	{

	}

	function doHelp()
	{

	}
	function loadValues()
	{
		document.forms[0].taaproj_comment1.value=getComment(document.forms[0].hidproj_comment1.value);
		document.forms[0].taaproj_comment2.value=getComment(document.forms[0].hidproj_comment2.value);
		
	}
	function doClose()
	{
		if( ConfirmMsg(100) )
		{
			document.forms[0].hidBeanGetMethod.value = "getCollateral";
			document.forms[0].action =path+"action/commcollateral.jsp";
			document.forms[0].submit();
		}
	}

	function gotoPage(pagename,methname)
	{
		if(document.forms[0].cmdedit.disabled == true)
		{
			ShowAlert(103);
		}
		else
		{
			document.forms[0].hidBeanGetMethod.value=methname;
			document.forms[0].action=path+"action/"+pagename;
			document.forms[0].submit();
		}
	}