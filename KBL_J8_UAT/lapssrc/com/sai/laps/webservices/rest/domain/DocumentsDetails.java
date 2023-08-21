package com.sai.laps.webservices.rest.domain;

public class DocumentsDetails {
	private String documentId;
	private String documentCode;
	private String referenceNumber;
	
	public DocumentsDetails() {
		super();
		// TODO Auto-generated constructor stub
	}

	public DocumentsDetails(String documentId, String documentCode,
			String referenceNumber) {
		super();
		this.documentId = documentId;
		this.documentCode = documentCode;
		this.referenceNumber = referenceNumber;
	}

	public String getDocumentId() {
		return documentId;
	}

	public void setDocumentId(String documentId) {
		this.documentId = documentId;
	}

	public String getDocumentCode() {
		return documentCode;
	}

	public void setDocumentCode(String documentCode) {
		this.documentCode = documentCode;
	}

	public String getReferenceNumber() {
		return referenceNumber;
	}

	public void setReferenceNumber(String referenceNumber) {
		this.referenceNumber = referenceNumber;
	}
}
