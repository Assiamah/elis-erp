package ws.users;

public class Cls_users {
   
	private String userid;
 private String username ;
 private String fullname;
 private String password;
 
/*	public Product(int uid,String user_name,String gender,String password) {
		this.uid= uid;
		this.user_name= user_name;
		this.gender= gender;
		this.password= password;
	}*/
	public String getuserid() {
		return userid;
	}
	public void setuserid(String userid) {
		this.userid = userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getfullname() {
		return fullname;
	}
	public void setfullname(String gender) {
		this.fullname = gender;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}

}
