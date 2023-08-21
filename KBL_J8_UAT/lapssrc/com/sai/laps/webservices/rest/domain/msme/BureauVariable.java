package com.sai.laps.webservices.rest.domain.msme;

import java.util.List;

import com.sai.laps.webservices.rest.domain.msme.ExistingFacilityProposal;

public class BureauVariable {

	private String  lastWrittenOffMonth;
	private String  writtenOffAmount;
	private String  lastNPAMonth;
	private String  lastNPAAmount;
	private String  last60DPDMonth;
	private String  commercialScoreCard;   
	private String  last60DPDAmount;
	private String  creditVintageYears;
	private String  oneYearEnquiries;
	private String  accountOpenedOneYear;
	private String  noOfActiveLoans;
	private List<CAMparty> relatedPartyName;
	private List<CAMparty> age;
	private List<CAMparty> netWorth;
	private List<CAMparty> isRelatedKBLStaff;
	private List<CAMparty> cibilScore;
	private List<CAMparty> lastWriteOffMonthCredit;
	private List<CAMparty> lastWriteOffAmount;
	private List<CAMparty> lastWriteOffMonthNonCredit;
	private List<CAMparty> writeOffAmountNonCredit;
	private List<CAMparty> noOfLoansWithSMA1;
	private List<CAMparty> lastSMA1Month;
	private List<CAMparty> lastOneYearEnquiriesConsumer;
	private List<CAMparty> accOpenOneYearConsumer;
	private List<CAMparty> noActiveLoansConsumer;
	
	
	public BureauVariable(){
		super();	
	}
	public BureauVariable(String lastWrittenOffMonth,
			String writtenOffAmount,
			String lastNPAMonth,
			String commercialScoreCard,
			String lastNPAAmount,
			String last60DPDMonth,
			String last60DPDAmount,
			String creditVintageYears,
			String oneYearEnquiries,
			String accountOpenedOneYear,
			String noOfActiveLoans,
			List<CAMparty> relatedPartyName,	
			List<CAMparty> age,
			List<CAMparty> netWorth,
			List<CAMparty> isRelatedKBLStaff,
			List<CAMparty> cibilScore,
			List<CAMparty> lastWriteOffMonthCredit,
			List<CAMparty> lastWriteOffAmount,
			List<CAMparty> lastWriteOffMonthNonCredit,
			List<CAMparty> writeOffAmountNonCredit,
			List<CAMparty> noOfLoansWithSMA1,
			List<CAMparty> lastSMA1Month,
			List<CAMparty> lastOneYearEnquiriesConsumer,
			List<CAMparty> accOpenOneYearConsumer,
			List<CAMparty> noActiveLoansConsumer){
		
		
		this.lastWrittenOffMonth=lastWrittenOffMonth;
		this.writtenOffAmount=writtenOffAmount;
		this.lastNPAMonth=lastNPAMonth;
		this.lastNPAAmount=lastNPAAmount;
		this.last60DPDMonth=last60DPDMonth;
		this.last60DPDAmount=last60DPDAmount;
		this.creditVintageYears=creditVintageYears;
		this.oneYearEnquiries=oneYearEnquiries;
		this.accountOpenedOneYear=accountOpenedOneYear;
		this.noOfActiveLoans=noOfActiveLoans;
		this.relatedPartyName=relatedPartyName;	
		this.age=age;
		this.netWorth=netWorth;
		this.isRelatedKBLStaff=isRelatedKBLStaff;
		this.cibilScore=cibilScore;
		this.lastWriteOffMonthCredit=lastWriteOffMonthCredit;
		this.lastWriteOffAmount=lastWriteOffAmount;
		this.lastWriteOffMonthNonCredit=lastWriteOffMonthNonCredit;
		this.writeOffAmountNonCredit=writeOffAmountNonCredit;
		this.noOfLoansWithSMA1=noOfLoansWithSMA1;
		this.lastSMA1Month=lastSMA1Month;
		this.lastOneYearEnquiriesConsumer=lastOneYearEnquiriesConsumer;
		this.accOpenOneYearConsumer=accOpenOneYearConsumer;
		this.noActiveLoansConsumer=noActiveLoansConsumer;
		this.commercialScoreCard=commercialScoreCard;
	}
	public String getLastWrittenOffMonth() {
		return lastWrittenOffMonth;
	}
	public void setLastWrittenOffMonth(String lastWrittenOffMonth) {
		this.lastWrittenOffMonth = lastWrittenOffMonth;
	}
	public String getWrittenOffAmount() {
		return writtenOffAmount;
	}
	public void setWrittenOffAmount(String writtenOffAmount) {
		this.writtenOffAmount = writtenOffAmount;
	}
	public String getLastNPAMonth() {
		return lastNPAMonth;
	}
	public void setLastNPAMonth(String lastNPAMonth) {
		this.lastNPAMonth = lastNPAMonth;
	}
	
	
	public String getCommercialScoreCard() {
		return commercialScoreCard;
	}
	public void setCommercialScoreCard(String commercialScoreCard) {
		this.commercialScoreCard = commercialScoreCard;
	}
	public String getLastNPAAmount() {
		return lastNPAAmount;
	}
	public void setLastNPAAmount(String lastNPAAmount) {
		this.lastNPAAmount = lastNPAAmount;
	}
	public String getLast60DPDMonth() {
		return last60DPDMonth;
	}
	public void setLast60DPDMonth(String last60DPDMonth) {
		this.last60DPDMonth = last60DPDMonth;
	}
	public String getLast60DPDAmount() {
		return last60DPDAmount;
	}
	public void setLast60DPDAmount(String last60DPDAmount) {
		this.last60DPDAmount = last60DPDAmount;
	}
	public String getCreditVintageYears() {
		return creditVintageYears;
	}
	public void setCreditVintageYears(String creditVintageYears) {
		this.creditVintageYears = creditVintageYears;
	}
	public String getOneYearEnquiries() {
		return oneYearEnquiries;
	}
	public void setOneYearEnquiries(String oneYearEnquiries) {
		this.oneYearEnquiries = oneYearEnquiries;
	}
	public String getAccountOpenedOneYear() {
		return accountOpenedOneYear;
	}
	public void setAccountOpenedOneYear(String accountOpenedOneYear) {
		this.accountOpenedOneYear = accountOpenedOneYear;
	}
	public String getNoOfActiveLoans() {
		return noOfActiveLoans;
	}
	public void setNoOfActiveLoans(String noOfActiveLoans) {
		this.noOfActiveLoans = noOfActiveLoans;
	}
	public List<CAMparty> getRelatedPartyName() {
		return relatedPartyName;
	}
	public void setRelatedPartyName(List<CAMparty> relatedPartyName) {
		this.relatedPartyName = relatedPartyName;
	}
	public List<CAMparty> getAge() {
		return age;
	}
	public void setAge(List<CAMparty> age) {
		this.age = age;
	}
	public List<CAMparty> getNetWorth() {
		return netWorth;
	}
	public void setNetWorth(List<CAMparty> netWorth) {
		this.netWorth = netWorth;
	}
	public List<CAMparty> getIsRelatedKBLStaff() {
		return isRelatedKBLStaff;
	}
	public void setIsRelatedKBLStaff(List<CAMparty> isRelatedKBLStaff) {
		this.isRelatedKBLStaff = isRelatedKBLStaff;
	}
	public List<CAMparty> getCibilScore() {
		return cibilScore;
	}
	public void setCibilScore(List<CAMparty> cibilScore) {
		this.cibilScore = cibilScore;
	}
	public List<CAMparty> getLastWriteOffMonthCredit() {
		return lastWriteOffMonthCredit;
	}
	public void setLastWriteOffMonthCredit(List<CAMparty> lastWriteOffMonthCredit) {
		this.lastWriteOffMonthCredit = lastWriteOffMonthCredit;
	}
	public List<CAMparty> getLastWriteOffAmount() {
		return lastWriteOffAmount;
	}
	public void setLastWriteOffAmount(List<CAMparty> lastWriteOffAmount) {
		this.lastWriteOffAmount = lastWriteOffAmount;
	}
	public List<CAMparty> getLastWriteOffMonthNonCredit() {
		return lastWriteOffMonthNonCredit;
	}
	public void setLastWriteOffMonthNonCredit(
			List<CAMparty> lastWriteOffMonthNonCredit) {
		this.lastWriteOffMonthNonCredit = lastWriteOffMonthNonCredit;
	}
	public List<CAMparty> getWriteOffAmountNonCredit() {
		return writeOffAmountNonCredit;
	}
	public void setWriteOffAmountNonCredit(List<CAMparty> writeOffAmountNonCredit) {
		this.writeOffAmountNonCredit = writeOffAmountNonCredit;
	}
	public List<CAMparty> getNoOfLoansWithSMA1() {
		return noOfLoansWithSMA1;
	}
	public void setNoOfLoansWithSMA1(List<CAMparty> noOfLoansWithSMA1) {
		this.noOfLoansWithSMA1 = noOfLoansWithSMA1;
	}
	public List<CAMparty> getLastSMA1Month() {
		return lastSMA1Month;
	}
	public void setLastSMA1Month(List<CAMparty> lastSMA1Month) {
		this.lastSMA1Month = lastSMA1Month;
	}
	public List<CAMparty> getLastOneYearEnquiriesConsumer() {
		return lastOneYearEnquiriesConsumer;
	}
	public void setLastOneYearEnquiriesConsumer(
			List<CAMparty> lastOneYearEnquiriesConsumer) {
		this.lastOneYearEnquiriesConsumer = lastOneYearEnquiriesConsumer;
	}
	public List<CAMparty> getAccOpenOneYearConsumer() {
		return accOpenOneYearConsumer;
	}
	public void setAccOpenOneYearConsumer(List<CAMparty> accOpenOneYearConsumer) {
		this.accOpenOneYearConsumer = accOpenOneYearConsumer;
	}
	public List<CAMparty> getNoActiveLoansConsumer() {
		return noActiveLoansConsumer;
	}
	public void setNoActiveLoansConsumer(List<CAMparty> noActiveLoansConsumer) {
		this.noActiveLoansConsumer = noActiveLoansConsumer;
	}
	
	
}
