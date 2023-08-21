package com.sai.laps.ejb.ExcelReader;

/**
 *  @author Arunkumar Subramaniam  
 *  @date  08-JAN-2008
 */

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.naming.NamingException;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.excelfunction.ExcelFunctionBean;
import com.sai.laps.helper.SAILogger;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

import java.io.*;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "ExcelReaderBean", mappedName = "ExcelReaderHome")
@Remote (ExcelReaderRemote.class)

public class ExcelReaderBean extends BeanAdapter {
	//static Logger log=Logger.getLogger(ExcelReaderBean.class);

	/**
	 * 
	 */
	private static final long serialVersionUID = -8878456145368970514L;
	static Logger log=Logger.getLogger(ExcelReaderBean.class);

	/**
	 * @author Arunkumar Subramaniam
	 * @param hshValues
	 * @return
	 * @
	 */

	public HashMap excelParser(HashMap hshValues)  {
		int count = 0;
		ResultSet rs = null;
		String strValue="";
		try {
            boolean isEmpty=false;        
            byte[] byteData=(byte[])hshValues.get("stream");
            if(byteData!=null)
            {
            	ByteArrayInputStream inputStream = new ByteArrayInputStream(byteData);
				Workbook workbook = Workbook.getWorkbook(inputStream);
				Sheet sheet1 = workbook.getSheet(0);
	
				for (int j = 1; j <= sheet1.getRows() - 1; j++) {
					String s1 = "", s2 = "", s3 = "", s4 = "", s5 = "", s6 = "", s7 = "", s8 = "", s9 = "", s10 = "", s11 = "", s12 = "", s13 = "", s14 = "", s15 = "", s16 = "", s17 = "", s18 = "", s19 = "", s20 = "", s21 = "", s22 = "", s23 = "", s24 = "", s25 = "", s26 = "", s27 = "", s28 = "", s29 = "", s30 = "", s31 = "", s32 = "";
					try {
						Cell sctg = sheet1.getCell(0, j);
						s1 = sctg.getContents();
						isEmpty=true;
					} catch (Exception e) {
					}
					try {
						Cell bank = sheet1.getCell(1, j);
						s2 = bank.getContents();
						
					} catch (Exception e) {
					}
					try {
						Cell branch = sheet1.getCell(2, j);
						s3 = branch.getContents();
						
					} catch (Exception e) {
					}
					try {
						Cell state = sheet1.getCell(3, j);
						s4 = state.getContents();
					
					} catch (Exception e) {
					}
					try {
						Cell srno = sheet1.getCell(4, j);
						s5 = srno.getContents();
						
					} catch (Exception e) {
					}
					try {
						Cell prty = sheet1.getCell(5, j);
						s6 = prty.getContents();
						
					} catch (Exception e) {
					}
					try {
						Cell addr = sheet1.getCell(6, j);
						s7 = addr.getContents();
						
					} catch (Exception e) {
					}
					try {
						Cell amt = sheet1.getCell(7, j);
						s8 = amt.getContents();
				
					} catch (Exception e) {
					}
					try {
						Cell suit = sheet1.getCell(8, j);
						s9 = suit.getContents();
						
					} catch (Exception e) {
					}
					try {
						Cell otherbank = sheet1.getCell(9, j);
						s10 = otherbank.getContents();
					
					} catch (Exception e) {
					}
					try {
						Cell dir1 = sheet1.getCell(10, j);
						s11 = dir1.getContents();
						
					} catch (Exception e) {
					}
					try {
						Cell dir2 = sheet1.getCell(11, j);
						s12 = dir2.getContents();
						
					} catch (Exception e) {
					}
					try {
						Cell dir3 = sheet1.getCell(12, j);
						s13 = dir3.getContents();
					
					} catch (Exception e) {
					}
					try {
						Cell dir4 = sheet1.getCell(13, j);
						s14 = dir4.getContents();
					
					} catch (Exception e) {
					}
					try {
						Cell dir5 = sheet1.getCell(14, j);
						s15 = dir5.getContents();
						
					} catch (Exception e) {
					}
					try {
						Cell dir6 = sheet1.getCell(15, j);
						s16 = dir6.getContents();
					
					} catch (Exception e) {
					}
					try {
						Cell dir7 = sheet1.getCell(16, j);
						s17 = dir7.getContents();
					
					} catch (Exception e) {
					}
					try {
						Cell dir8 = sheet1.getCell(17, j);
						s18 = dir8.getContents();
					
					} catch (Exception e) {
					}
					try {
						Cell dir9 = sheet1.getCell(18, j);
						s19 = dir9.getContents();
					
					} catch (Exception e) {
					}
					try {
						Cell dir10 = sheet1.getCell(19, j);
						s20 = dir10.getContents();
					
					} catch (Exception e) {
					}
					try {
						Cell dir11 = sheet1.getCell(20, j);
						s21 = dir11.getContents();
						
					} catch (Exception e) {
					}
					try {
						Cell dir12 = sheet1.getCell(21, j);
						s22 = dir12.getContents();
						
					} catch (Exception e) {
					}
					try {
						Cell dir13 = sheet1.getCell(22, j);
						s23 = dir13.getContents();
					
					} catch (Exception e) {
					}
					try {
						Cell dir14 = sheet1.getCell(23, j);
						s24 = dir14.getContents();
					
					} catch (Exception e) {
					}
	
					if (j == 1) {
						if(isEmpty)
						delete();
					}
	
					try {
						insertDefaulter(s1, s2, s3, s4, s5, s6, s7, s8, s9, s10,
								s11, s12, s13, s14, s15, s16, s17, s18, s19, s20,
								s21, s22, s23, s25, "", "", "", "", "", "", "", rs);
						if (rs != null)
						rs.close();
						count = count + 1;
					} catch (Exception e) {
						log.error(e);
						if (rs != null)
							rs.close();
					}

					hshValues.put("status", "Sucessfully " + count
							+ " Rows  Updated");
				}

				inputStream.close();
				inputStream = null;
				workbook.close();
            }
            else
            {
            	strValue="yes";
            	hshValues.put("status", "Select the file before click upload");
            }
            

		} catch (Exception e) {
			//rollBack();
			hshValues.put("status", "Error.............0 Rows Updated");
			throw new EJBException(e.getMessage());
			

		} finally {
			try {
				if (rs != null) {
					rs.close();
					rs = null;
					System.gc();
				}
			} catch (Exception e1) {
				throw new EJBException("Error closing connection.." + e1);
			}
		}

		return hshValues;
	}

	/**
	 * @author Arunkumar Subramaniam
	 * @param strSctg
	 * @param strBank
	 * @param strBranch
	 * @param strState
	 * @param strSrno
	 * @param strParty
	 * @param strAddr
	 * @param strOSAmount
	 * @param strSuit
	 * @param strOtherbank
	 * @param strDir1
	 * @param strDir2
	 * @param strDir3
	 * @param strDir4
	 * @param strDir5
	 * @param strDir6
	 * @param strDir7
	 * @param strDir8
	 * @param strDir9
	 * @param strDir10
	 * @param strDir11
	 * @param strDir12
	 * @param strDir13
	 * @param strDir14
	 * @param strBIFR
	 * @param strCDR
	 * @param strGCDR
	 * @param strOTS
	 * @param strBANK
	 * @param strRBINSF
	 * @param strRBIWILL
	 * @param rs
	 * @throws Exception
	 */
	private void insertDefaulter(String strSctg, String strBank,
			String strBranch, String strState, String strSrno, String strParty,
			String strAddr, String strOSAmount, String strSuit,
			String strOtherbank, String strDir1, String strDir2,
			String strDir3, String strDir4, String strDir5, String strDir6,
			String strDir7, String strDir8, String strDir9, String strDir10,
			String strDir11, String strDir12, String strDir13, String strDir14,
			String strBIFR, String strCDR, String strGCDR, String strOTS,
			String strBANK, String strRBINSF, String strRBIWILL, ResultSet rs)

	throws Exception {
		HashMap hshQuery = null, hshQueryValues = new HashMap();
		ArrayList arrValues = null;
		String strQuery = SQLParser.getSqlQuery("rbidefaultermax");
		rs = DBUtils.executeQuery(strQuery);
		int termId = 0;
		if (rs.next()) {
			termId = Integer.parseInt(rs.getString(1));
		}
		hshQuery = new HashMap();
		arrValues = new ArrayList();
		hshQuery.put("strQueryId", "rbidefaultinsert1");
		arrValues.add(strSctg);
		arrValues.add(strBank);
		arrValues.add(strBranch);
		arrValues.add(strState);
		arrValues.add(strSrno);
		arrValues.add(strParty);
		arrValues.add(strAddr);
		arrValues.add(strOSAmount);
		arrValues.add(strSuit);
		arrValues.add(strOtherbank);
		arrValues.add(strDir1);
		arrValues.add(strDir2);
		arrValues.add(strDir3);
		arrValues.add(strDir4);
		arrValues.add(strDir5);
		arrValues.add(strDir6);
		arrValues.add(strDir7);
		arrValues.add(strDir8);
		arrValues.add(strDir9);
		arrValues.add(strDir10);
		arrValues.add(strDir11);
		arrValues.add(strDir12);
		arrValues.add(strDir13);
		arrValues.add(strDir14);
		arrValues.add(strBIFR);
		arrValues.add(strCDR);
		arrValues.add(strGCDR);
		arrValues.add(strOTS);
		arrValues.add(strBANK);
		arrValues.add(strRBINSF);
		arrValues.add(strRBIWILL);
		arrValues.add(String.valueOf(termId));
		hshQueryValues.put("size", "1");
		hshQuery.put("arrValues", arrValues);
		hshQueryValues.put("1", hshQuery);
		EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
	}

	private void delete() throws Exception {
		HashMap hshQuery = null, hshQueryValues = new HashMap();
		ArrayList arrValues = null;
		hshQuery = new HashMap();
		arrValues = new ArrayList();
		hshQuery.put("strQueryId", "delete_rbidefault");
		hshQueryValues.put("size", "1");
		hshQuery.put("arrValues", arrValues);
		hshQueryValues.put("1", hshQuery);
		EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");

	}
}
