package test.cafe.dto;

public class CafeDto {
	private int qna_idx;
	private String qna_writer;
	private String qna_title;
	private String qna_content;
	private String qna_file;
	private String qna_regdate;
	private int startRowNum;
	private int endRowNum;
		
	public CafeDto(int qna_idx, String qna_writer, String qna_title, String qna_content, String qna_file,
			String qna_regdate, int startRowNum, int endRowNum) {
		super();
		this.qna_idx = qna_idx;
		this.qna_writer = qna_writer;
		this.qna_title = qna_title;
		this.qna_content = qna_content;
		this.qna_file = qna_file;
		this.qna_regdate = qna_regdate;
		this.startRowNum = startRowNum;
		this.endRowNum = endRowNum;
	}

	public int getQna_idx() {
		return qna_idx;
	}

	public void setQna_idx(int qna_idx) {
		this.qna_idx = qna_idx;
	}

	public String getQna_writer() {
		return qna_writer;
	}

	public void setQna_writer(String qna_writer) {
		this.qna_writer = qna_writer;
	}

	public String getQna_title() {
		return qna_title;
	}

	public void setQna_title(String qna_title) {
		this.qna_title = qna_title;
	}

	public String getQna_content() {
		return qna_content;
	}

	public void setQna_content(String qna_content) {
		this.qna_content = qna_content;
	}

	public String getQna_file() {
		return qna_file;
	}

	public void setQna_file(String qna_file) {
		this.qna_file = qna_file;
	}

	public String getQna_regdate() {
		return qna_regdate;
	}

	public void setQna_regdate(String qna_regdate) {
		this.qna_regdate = qna_regdate;
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

	public CafeDto() {}
}
