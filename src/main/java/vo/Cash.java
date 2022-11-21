package vo;

public class Cash {
	private int cashNo;
	// private Category category; // INNER JOIN -> Cash타입
	private int categoryNo; // FK -> INNER JOIN -> Map타입
	private String cashDate;
	private long cashPrice;
	private String updatedate;
	private String createdate;
	
	public int getCashNo() {
		return cashNo;
	}
	public void setCashNo(int cashNo) {
		this.cashNo = cashNo;
	}
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getCashDate() {
		return cashDate;
	}
	public void setCashDate(String cashDate) {
		this.cashDate = cashDate;
	}
	public long getCashPrice() {
		return cashPrice;
	}
	public void setCashPrice(long cashPrice) {
		this.cashPrice = cashPrice;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
}