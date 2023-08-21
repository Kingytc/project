package com.sai.laps.taglib;

import java.text.NumberFormat;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

/*
 * This tag is used to get number inputs.
 * Can be used to get either whole numbers or real numbers based on fractionDigits values
 * This is also used for getting the currency values
 */

public class CurrencyTag extends TagSupport
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(CurrencyTag.class);
	private static final long serialVersionUID = 1L;

	private String name = "";

	private String value = null;

	private String precision = null;

	private String size = null;

	private String maxlength = null;

	private String maxvalue = null;

	private String minvalue = null;

	private String style = null;
	
	private String styleClass = null;

	private String tabindex = null;

	private String onKeyUp = null;

	private String onKeyDown = null;

	private String onBlur = null;

	private String onKeyPress = null;

	private String onChange = null;

	private String other = null;
	
	private String title = null;

	public int doEndTag() throws JspException
	{

		JspWriter out = null;
		
		StringBuffer content = new StringBuffer();

		String strOnKeyPress = "";
		String strOnBlur = "";
		String strStyle = "text-align:right;";

		try
		{
			out=pageContext.getOut();
			content.append("<INPUT TYPE=\"text\" NAME=\"" + name + "\"");

			if(precision==null || precision.trim().equals(""))
				precision = "2";
			
			if (value != null)
			{
				NumberFormat nf = NumberFormat.getInstance();
				nf.setGroupingUsed(false);
				
				nf.setMaximumFractionDigits(Integer.parseInt(precision));
				nf.setMinimumFractionDigits(Integer.parseInt(precision));
				
				String strValue = "";
				strValue = (value != null && !value.trim().equals("")) ? value : "";
				if (!strValue.trim().equals(""))
					strValue = nf.format(Double.parseDouble(strValue));
				content.append(" VALUE=\"" + strValue + "\" ");

			}
			
			if (precision.trim().equals("0"))
			{
				strOnKeyPress = "allowInteger();";
			}
			else
			{
				strOnKeyPress = "allowDecimal(this, '"+precision+"');";
				strOnBlur = "roundNumber(this, '"+precision+"');";
			}

			if (tabindex != null)
			{
				content.append(" TABINDEX=\"" + tabindex + "\" ");
			}
			if (size != null)
			{
				content.append(" SIZE=\"" + size + "\" ");
			}
			if (maxlength != null)
			{
				content.append(" MAXLENGTH=\"" + maxlength + "\" ");
			}
			if (styleClass != null)
			{
				content.append(" CLASS=\"" + styleClass + "\" ");
			}
			
			if (onKeyUp != null)
			{
				content.append(" onKeyUp=\"" + onKeyUp + "\" ");
			}

			if (onKeyDown != null)
			{
				content.append(" onKeyDown=\"" + onKeyDown + "\" ");
			}

			if(title!=null)
			{
				content.append(" Title=\"" + title + "\" ");
			}
			if (onChange != null)
			{
				content.append(" onChange=\"" + onChange + "\" ");
			}

			if (onKeyPress != null)
			{
				strOnKeyPress = strOnKeyPress + onKeyPress;
			}
			if (!strOnKeyPress.trim().equals(""))
			{
				content.append(" onKeyPress=\"" + strOnKeyPress + "\" ");
			}

			if (minvalue != null && !minvalue.trim().equals(""))
			{
				strOnBlur = strOnBlur + "validateMinimum(this,'" + minvalue + "'); ";
			}
			if (maxvalue != null && !maxvalue.trim().equals(""))
			{
				strOnBlur = strOnBlur + "validateMaximum(this,'" + maxvalue + "');";
			}

			if (onBlur != null)
			{
				strOnBlur = strOnBlur + onBlur;
			}
			if (!strOnBlur.trim().equals(""))
			{
				content.append(" onBlur=\"" + strOnBlur + "\" ");
			}

			if(style!=null)
			{
				strStyle = strStyle + style;
			}
			if(!strStyle.trim().equals(""))
			{
				content.append(" STYLE = \"" + strStyle + "\"");
			}
			
			if (other != null)
			{
				content.append(other);
			}

			content.append(" FIELDTYPE=\"NUMBER\">");
			out.println(content.toString());

		}
		catch (Exception ioe)
		{
			log.error("Exception in NumberTag " + ioe.getMessage());
		}
		return EVAL_PAGE;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}
	
	public String getValue()
	{
		return value;
	}

	public void setValue(String value)
	{
		this.value = value;
	}

	public String getOnChange()
	{
		return onChange;
	}

	public void setOnChange(String onChange)
	{
		this.onChange = onChange;
	}

	public String getOnKeyPress()
	{
		return onKeyPress;
	}

	public void setOnKeyPress(String onKeyPress)
	{
		this.onKeyPress = onKeyPress;
	}

	public String getOnBlur()
	{
		return onBlur;
	}

	public void setOnBlur(String onBlur)
	{
		this.onBlur = onBlur;
	}

	public String getOnKeyUp()
	{
		return onKeyUp;
	}

	public void setOnKeyUp(String onKeyUp)
	{
		this.onKeyUp = onKeyUp;
	}

	public String getOnKeyDown()
	{
		return onKeyDown;
	}

	public void setOnKeyDown(String onKeyDown)
	{
		this.onKeyDown = onKeyDown;
	}

	public String getPrecision()
	{
		return precision;
	}

	public void setPrecision(String precision)
	{
		this.precision = precision;
	}

	public String getSize()
	{
		return size;
	}

	public void setSize(String size)
	{
		this.size = size;
	}

	public String getMinvalue()
	{
		return minvalue;
	}

	public void setMinvalue(String minvalue)
	{
		this.minvalue = minvalue;
	}

	public String getMaxvalue()
	{
		return maxvalue;
	}

	public void setMaxvalue(String maxvalue)
	{
		this.maxvalue = maxvalue;
	}

	public String getMaxlength()
	{
		return maxlength;
	}

	public void setMaxlength(String maxlength)
	{
		this.maxlength = maxlength;
	}

	public String getStyle()
	{
		return style;
	}

	public void setStyle(String style)
	{
		this.style = style;
	}

	public String getStyleClass()
	{
		return styleClass;
	}

	public void setStyleClass(String styleClass)
	{
		this.styleClass = styleClass;
	}

	public String getTabindex()
	{
		return tabindex;
	}

	public void setTabindex(String tabindex)
	{
		this.tabindex = tabindex;
	}
	
	public String getOther()
	{
		return other;
	}

	public void setOther(String other)
	{
		this.other = other;
	}

	public String getTitle()
	{
		return title;
	}
	public void setTitle(String title)
	{
		this.title = title;
	}
}