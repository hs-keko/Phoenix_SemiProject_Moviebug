package test.users.dto;

public class UsersDto {
	private String name;
	private String pwd;
	private String email;
	private String addr;
	private String profile;
	private String regdate;
	
	public UsersDto(String name, String pwd, String email, String addr, String profile, String regdate) {
		super();
		this.name = name;
		this.pwd = pwd;
		this.email = email;
		this.addr = addr;
		this.profile = profile;
		this.regdate = regdate;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public UsersDto() {}
}
