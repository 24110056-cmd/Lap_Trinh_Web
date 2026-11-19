package vn.iotstar.entity;

import java.io.Serializable;
import java.util.List;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "users")
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @NotBlank(message = "Tên đăng nhập không được để trống!")
    @Size(min = 4, max = 100, message = "Tên đăng nhập phải từ 4 đến 100 ký tự!")
    @Column(name = "username", unique = true, nullable = false, length = 100)
    private String username;

    @NotBlank(message = "Mật khẩu không được để trống!")
    @Size(min = 6, max = 255, message = "Mật khẩu phải có ít nhất 6 ký tự!")
    @Column(name = "password", nullable = false, length = 255)
    private String password;

    @NotBlank(message = "Họ và tên không được để trống!")
    @Size(min = 2, max = 255, message = "Họ và tên phải từ 2 đến 255 ký tự!")
    @Column(name = "fullname", columnDefinition = "NVARCHAR(255)")
    private String fullname;

    @NotBlank(message = "Email không được để trống!")
    @Email(message = "Định dạng email không hợp lệ!")
    @Column(name = "email", length = 150)
    private String email;

    @Column(name = "roleid")
    private int roleid; // 1: Admin, 2: User

    // Các trường bổ sung cho OTP và kích hoạt tài khoản
    @Column(name = "code", length = 10)
    private String code;

    // false: Chưa kích hoạt, true: Đã kích hoạt
    // Mặc định tài khoản mới chưa được kích hoạt
    @Column(name = "enabled", nullable = false)
    private boolean enabled = false;

    // Quan hệ 1 - N với bảng videos
    @OneToMany(
        mappedBy = "user",
        cascade = CascadeType.ALL,
        fetch = FetchType.LAZY
    )
    private List<Video> videos;

    // Constructor mặc định
    public User() {
    }

    // Constructor có tham số
    public User(String username, String password, String fullname,
                String email, int roleid) {

        this.username = username;
        this.password = password;
        this.fullname = fullname;
        this.email = email;
        this.roleid = roleid;
        this.enabled = false;
    }

    // Getter và Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getRoleid() {
        return roleid;
    }

    public void setRoleid(int roleid) {
        this.roleid = roleid;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public List<Video> getVideos() {
        return videos;
    }

    public void setVideos(List<Video> videos) {
        this.videos = videos;
    }
}
