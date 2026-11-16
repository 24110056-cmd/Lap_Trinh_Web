package vn.iotstar.entity;

import java.io.Serializable;
import jakarta.persistence.*;

@Entity
@Table(name = "users")
public class User implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(name = "username", unique = true, nullable = false, length = 100)
	private String username;

	@Column(name = "password", nullable = false, length = 100)
	private String password;

	@Column(name = "fullname", columnDefinition = "NVARCHAR(255)")
	private String fullname;

	@Column(name = "email", length = 150)
	private String email;

	@Column(name = "roleid")
	private int roleid; // 1: Admin, 2: User

	public User() {
	}

	public int getId() { return id; }
	public void setId(int id) { this.id = id; }
	public String getUsername() { return username; }
	public void setUsername(String username) { this.username = username; }
	public String getPassword() { return password; }
	public void setPassword(String password) { this.password = password; }
	public String getFullname() { return fullname; }
	public void setFullname(String fullname) { this.fullname = fullname; }
	public String getEmail() { return email; }
	public void setEmail(String email) { this.email = email; }
	public int getRoleid() { return roleid; }
	public void setRoleid(int roleid) { this.roleid = roleid; }
}