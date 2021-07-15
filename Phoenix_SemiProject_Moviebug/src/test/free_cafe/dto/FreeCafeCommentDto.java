package test.free_cafe.dto;

public class FreeCafeCommentDto {
	private int free_comment_idx;
	private String free_comment_writer;
	private String free_comment_content;
	private String free_comment_target_id;
	private int free_comment_ref_group;
	private int free_comment_group;
	private String free_comment_deleted;
	private String free_comment_regdate;
	private String profile;
	private int StartRowNum;
	private int EndRowNum;
	
	public FreeCafeCommentDto() {}

	public FreeCafeCommentDto(int free_comment_idx, String free_comment_writer, String free_comment_content,
			String free_comment_target_id, int free_comment_ref_group, int free_comment_group, String free_comment_deleted,
			String free_comment_regdate, String profile, int startRowNum, int endRowNum) {
		super();
		this.free_comment_idx = free_comment_idx;
		this.free_comment_writer = free_comment_writer;
		this.free_comment_content = free_comment_content;
		this.free_comment_target_id = free_comment_target_id;
		this.free_comment_ref_group = free_comment_ref_group;
		this.free_comment_group = free_comment_group;
		this.free_comment_deleted = free_comment_deleted;
		this.free_comment_regdate = free_comment_regdate;
		this.profile = profile;
		StartRowNum = startRowNum;
		EndRowNum = endRowNum;
	}

	public int getFree_comment_idx() {
		return free_comment_idx;
	}

	public void setFree_comment_idx(int free_comment_idx) {
		this.free_comment_idx = free_comment_idx;
	}

	public String getFree_comment_writer() {
		return free_comment_writer;
	}

	public void setFree_comment_writer(String free_comment_writer) {
		this.free_comment_writer = free_comment_writer;
	}

	public String getFree_comment_content() {
		return free_comment_content;
	}

	public void setFree_comment_content(String free_comment_content) {
		this.free_comment_content = free_comment_content;
	}

	public String getFree_comment_target_id() {
		return free_comment_target_id;
	}

	public void setFree_comment_target_id(String free_comment_target_id) {
		this.free_comment_target_id = free_comment_target_id;
	}

	public int getFree_comment_ref_group() {
		return free_comment_ref_group;
	}

	public void setFree_comment_ref_group(int free_comment_ref_group) {
		this.free_comment_ref_group = free_comment_ref_group;
	}

	public int getFree_comment_group() {
		return free_comment_group;
	}

	public void setFree_comment_group(int free_comment_group) {
		this.free_comment_group = free_comment_group;
	}

	public String getFree_comment_deleted() {
		return free_comment_deleted;
	}

	public void setFree_comment_deleted(String free_comment_deleted) {
		this.free_comment_deleted = free_comment_deleted;
	}

	public String getFree_comment_regdate() {
		return free_comment_regdate;
	}

	public void setFree_comment_regdate(String free_comment_regdate) {
		this.free_comment_regdate = free_comment_regdate;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public int getStartRowNum() {
		return StartRowNum;
	}

	public void setStartRowNum(int startRowNum) {
		StartRowNum = startRowNum;
	}

	public int getEndRowNum() {
		return EndRowNum;
	}

	public void setEndRowNum(int endRowNum) {
		EndRowNum = endRowNum;
	}

}
