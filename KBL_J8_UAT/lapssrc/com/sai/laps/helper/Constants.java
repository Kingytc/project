/**
 * @author: S.SATHYA MOORTHY
 * @since : 20/03/2009
 * @purpose : FOR APPLICATION GLOBAL CONSTANTS;
 */
package com.sai.laps.helper;

/**
 *@author : S.SATHYA MOORTHY
 *@date   :May 4, 2009 :11:55:01 AM
 *@purpose:FOR LAPS GLOBAL CONSTANTS
 *@description :
 *@todo :
 */
public class Constants {
	

	public final static String CONTENT_TYPE_FORCEDOWNLOAD="application/force-download";
	public final static String CONTENT_TYPE_MSWORD="application/ms-word";
	public final static String CONTENT_TYPE_PDF="application/pdf";
	
	public final static String FILE_SEPERATOR="\\";
	public final static String DRIVE_SPECIFIER=":";
	
	//FOR DUE DILIGENCE AND FILE UPLOADING CONSTANTS
	public final static String UPLOAD_FILE_DD_FILE_SEPERATOR="\\";
	public final static String TEMP_DIR="LAPS_TEMP";
	public final static String UPLOAD_FILE_DD_DIR=TEMP_DIR+UPLOAD_FILE_DD_FILE_SEPERATOR+"DUEDILIGENCE";
	public final static String UPLOAD_FILE_DD_DATA_DIR=UPLOAD_FILE_DD_DIR+UPLOAD_FILE_DD_FILE_SEPERATOR+"Data";
	
	public final static String UPLOAD_FILE_DD_LOG_DIR=UPLOAD_FILE_DD_DIR+UPLOAD_FILE_DD_FILE_SEPERATOR+"Log";
	public final static String UPLOAD_FILE_DD_DONE_DIR=UPLOAD_FILE_DD_DIR+UPLOAD_FILE_DD_FILE_SEPERATOR+"Done";
	public final static String UPLOAD_FILE_DD_BAD_DIR=UPLOAD_FILE_DD_DIR+UPLOAD_FILE_DD_FILE_SEPERATOR+"Bad";
	public final static String UPLOAD_FILE_DRIVE="UF_DRIVE";
	public final static String UPLOAD_FILE_PATH="UF_PATH";
	public final static String UPLOAD_FILE_STREAM_KEY="UF_FILE_STREAM";
	public final static String UPLOAD_FILE_NAME="UF_FILE_NAME";
	public final static String UPLOAD_FILE_EXT="UF_FILE_EXT";
	public final static String IMPORT_FILE_BY_BINARY_STREAM="READ_BY_STREAM";
	public final static String IMPORT_FILE_FROM_REQUEST="READ_BY_REQUEST";
	public final static String IMPORT_FILE_BY_REQUEST_AND_STREAM="READ_BY_REQUEST_STREAM";
	public final static String HTML_FILE_CONTROL="fileUpload";
	public final static String UPLOAD_FOR_DUE_DILIGENCE="DUE_DILIGENCE_UPLOAD";
	public final static String UPLOAD_FILE_LOCATION="DUE_DILEIGENCE_FILE_LOCATION";
	
	public final static String MAIL_DIR="MAIL_ATTACHMENT";
	public final static String MAIL_ATTACHMENT_DIR=TEMP_DIR+FILE_SEPERATOR+MAIL_DIR;
	
	public final static String MULTIPART_ENCTYPE="multipart/form-data";
	public final static String HTML_UPLOAD_TYPE="hidUploadType";
	public final static String HTML_UPLOAD_MODE="hidUploadMode";
	
	
	
	
	
	
	
	
	/** BEAN CONSTANTS **/
	public final static String CONST_STRQUERYID="strQueryId";
	public final static String CONST_HIDACTION="hidAction";
	public final static String CONST_INSERT="insert";
	public final static String CONST_UPDATE="update";
	public final static String CONST_DELETE="delete";
	public final static String CONST_ARRVALUES="arrValues";
	public final static String CONST_QUERY_SIZE="size";
	
	public final static String PART_NAME_DELIM="~";
	public final static String PART_YEAR_DELIM="#";
	public final static String PART_YEAR_KEY="strPartitionYear";
	
	public final static String ERROR_RESPONSE_DATA="{\"data\":{},\"resp_code\":\"500\",\"resp_msg\":\"Internal server error\"}";
	public final static String BAD_REQEST_DATA="{\"data\":{},\"resp_code\":\"200\",\"resp_msg\":\"Bad Request\"}";
	public final static String ERROR_RESPONSE_MANDATORY="{\"data\":{},\"resp_code\":\"LAPS-2000\",\"resp_msg\":\"Mandatory Field Missing\"}";
	public final static String ERROR_RESPONSE_INVALID_DATEFORMAT="{\"data\":{},\"resp_code\":\"LAPS-2001\",\"resp_msg\":\"Invalid Date Format. Valid Format-DD/MM/YYYY\"}";
	public final static String ERROR_RESPONSE_LARmandtory="{\"data\":{},\"resp_code\":\"LAPS-2002\",\"resp_msg\":\"LAPS LAR Number is Mandatory\"}";
	public final static String ERROR_RESPONSE_INVALID_PANNO="{\"data\":{},\"resp_code\":\"LAPS-2004\",\"resp_msg\":\"Invalid PAN format\"}";
	public final static String ERROR_INVALID_LAPS_ID="{\"data\":{},\"resp_code\":\"LAPS-2000\",\"resp_msg\":\"Invalid Laps Id\"}";
	public final static String Date_validation="{\"data\":{},\"resp_code\":\"LAPS-1016\",\"resp_msg\":\"Difference between Process date should be within 7 days\"}";
	public final static String DigiRenew_proposalblock="{\"data\":{},\"resp_code\":\"LAPS-2015\",\"resp_msg\":\"Given renewProposalNumber already taken for Renew or postsanction or Restructure and kept pending\"}";
	public final static String Digifacdescmismatchforrenew="{\"data\":{},\"resp_code\":\"LAPS-2016\",\"resp_msg\":\"Facility mismatch\"}";
	public final static String DupFacilitySno="{\"data\":{},\"resp_code\":\"LAPS-2016\",\"resp_msg\":\"Duplicate Facilities are present\"}";
	public final static String goldpropsalchk="{\"data\":{},\"resp_code\":\"LAPS-2023\",\"resp_msg\":\" Proposal should be a sanctioned gold loan proposal and same should be availed in Finacle  \"}";
	public final static String goldreappraiserchk="{\"data\":{},\"resp_code\":\"LAPS-2023\",\"resp_msg\":\" Goldreappraiser sholuld be enable for particular Branch, Appraiser can't be reappraiser , Re-Appraisal Date Can not be less than or equal to previous appraisal date and Date Can not be future date also \"}";
	public final static String Goldreappraiserstatus="{\"data\":{},\"resp_code\":\"LAPS-2023\",\"resp_msg\":\"Given Application number is already Process Approved\"}";
	public final static String organisationchk="{\"data\":{},\"resp_code\":\"LAPS-2023\",\"resp_msg\":\"Invalid Sol ID \"}";
	public final static String userchk="{\"data\":{},\"resp_code\":\"LAPS-2023\",\"resp_msg\":\"Invalid User ID \"}";
	public final static String groupidchk="{\"data\":{},\"resp_code\":\"LAPS-2023\",\"resp_msg\":\"Invalid Group Code \"}";
	public final static String designatechk="{\"data\":{},\"resp_code\":\"LAPS-2023\",\"resp_msg\":\"Invalid Designation Code \"}";
	public final static String USERVALID="{\"data\":{},\"resp_code\":\"LAPS-2023\",\"resp_msg\":\"User ID already exits \"}";
	
}
