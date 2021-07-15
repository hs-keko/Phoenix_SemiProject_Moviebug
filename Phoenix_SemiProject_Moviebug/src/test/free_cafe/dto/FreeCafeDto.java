package test.free_cafe.dto;

public class FreeCafeDto {
	private int free_idx;
	private String free_writer;
	private String free_title;
	private String free_content;
	private String free_file;
	private String free_regdate;
	private int startRowNum;
	private int endRowNum;
	private int prevNum;
	private int nextNum;

	public FreeCafeDto(int free_idx, String free_writer, String free_title, String free_content, String free_file,
			String free_regdate, int startRowNum, int endRowNum, int prevNum, int nextNum) {
		super();
		this.free_idx = free_idx;
		this.free_writer = free_writer;
		this.free_title = free_title;
		this.free_content = free_content;
		this.free_file = free_file;
		this.free_regdate = free_regdate;
		this.startRowNum = startRowNum;
		this.endRowNum = endRowNum;
		this.prevNum = prevNum;
		this.nextNum = nextNum;
	}

	public int getFree_idx() {
		return free_idx;
	}

	public void setFree_idx(int free_idx) {
		this.free_idx = free_idx;
	}

	public String getFree_writer() {
		return free_writer;
	}

	public void setFree_writer(String free_writer) {
		this.free_writer = free_writer;
	}

	public String getFree_title() {
		return free_title;
	}

	public void setFree_title(String free_title) {
		this.free_title = free_title;
	}

	public String getFree_content() {
		return free_content;
	}

	public void setFree_content(String free_content) {
		this.free_content = free_content;
	}

	public String getFree_file() {
		return free_file;
	}

	public void setFree_file(String free_file) {
		this.free_file = free_file;
	}

	public String getFree_regdate() {
		return free_regdate;
	}

	public void setFree_regdate(String free_regdate) {
		this.free_regdate = free_regdate;
	}

	public int getStartRowNum() {
		return startRowNum;
	}

	public void setStartRowNum(int startRowNum) {
		this.startRowNum = startRowNum;
	}

	public int getEndRowNum() {
		return endRowNum;
	}

	public void setEndRowNum(int endRowNum) {
		this.endRowNum = endRowNum;
	}

	public int getPrevNum() {
		return prevNum;
	}

	public void setPrevNum(int prevNum) {
		this.prevNum = prevNum;
	}

	public int getNextNum() {
		return nextNum;
	}

	public void setNextNum(int nextNum) {
		this.nextNum = nextNum;
	}

	public FreeCafeDto() {}
}