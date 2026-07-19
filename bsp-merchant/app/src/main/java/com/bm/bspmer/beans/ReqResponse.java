package com.bm.bspmer.beans;

public class ReqResponse {

    private String VCD;
    private String TCD;
    private String TMG;
    private String RCD;
    private String RMG;
    private String SID;
    private String responseData;

    public String getVCD() { return VCD; }
    public void setVCD(String VCD) { this.VCD = VCD; }

    public String getTCD() { return TCD; }
    public void setTCD(String TCD) { this.TCD = TCD; }

    public String getTMG() { return TMG; }
    public void setTMG(String TMG) { this.TMG = TMG; }

    public String getRCD() { return RCD; }
    public void setRCD(String RCD) { this.RCD = RCD; }

    public String getRMG() { return RMG; }
    public void setRMG(String RMG) { this.RMG = RMG; }

    public String getSID() { return SID; }
    public void setSID(String SID) { this.SID = SID; }

    public String getResponseData() { return responseData; }
    public void setResponseData(String responseData) { this.responseData = responseData; }

    public boolean isSuccess() {
        return "000".equals(RCD);
    }
}
