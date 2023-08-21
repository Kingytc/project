package com.kalyptorisk.www.credit.rating;

public class RatingSoapProxy implements com.kalyptorisk.www.credit.rating.RatingSoap {
  private String _endpoint = null;
  private com.kalyptorisk.www.credit.rating.RatingSoap ratingSoap = null;
  
  public RatingSoapProxy() {
    _initRatingSoapProxy();
  }
  
  public RatingSoapProxy(String endpoint) {
    _endpoint = endpoint;
    _initRatingSoapProxy();
  }
  
  private void _initRatingSoapProxy() {
    try {
      ratingSoap = (new com.kalyptorisk.www.credit.rating.RatingLocator()).getRatingSoap();
      if (ratingSoap != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)ratingSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)ratingSoap)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (ratingSoap != null)
      ((javax.xml.rpc.Stub)ratingSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.kalyptorisk.www.credit.rating.RatingSoap getRatingSoap() {
    if (ratingSoap == null)
      _initRatingSoapProxy();
    return ratingSoap;
  }
  
  public java.lang.String retailEvaluation(java.lang.String proposalID) throws java.rmi.RemoteException{
    if (ratingSoap == null)
      _initRatingSoapProxy();
    return ratingSoap.retailEvaluation(proposalID);
  }
  
  public java.lang.String corporateRating(java.lang.String proposalID) throws java.rmi.RemoteException{
    if (ratingSoap == null)
      _initRatingSoapProxy();
    return ratingSoap.corporateRating(proposalID);
  }
  
  
}