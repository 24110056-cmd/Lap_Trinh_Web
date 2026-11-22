package vn.iotstar.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import java.io.Serializable;

@Entity
@Table(name = "Videos")
public class Video implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @NotBlank(message = "Mã Video không được để trống!")
    @Size(max = 50, message = "Mã Video tối đa 50 ký tự!")
    @Column(name = "VideoId")
    private String videoId;

    @NotBlank(message = "Tiêu đề Video không được để trống!")
    @Size(min = 3, max = 255, message = "Tiêu đề Video phải từ 3 đến 255 ký tự!")
    @Column(name = "Title", columnDefinition = "NVARCHAR(255)")
    private String title;

    @Column(name = "Poster")
    private String poster;

    @NotBlank(message = "Đường dẫn Video (URL) không được để trống!")
    @Column(name = "VideoUrl")
    private String videoUrl;

    @Column(name = "Views")
    private int views;

    @Column(name = "Description", columnDefinition = "NVARCHAR(MAX)")
    private String description;

    @Column(name = "Active")
    private boolean active;

    @ManyToOne
    @JoinColumn(name = "CategoryId")
    private Category category;

    @ManyToOne
    @JoinColumn(name = "UserId")
    private User user;

    public Video() {
    }

    public String getVideoId() { return videoId; }
    public void setVideoId(String videoId) { this.videoId = videoId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getPoster() { return poster; }
    public void setPoster(String poster) { this.poster = poster; }

    public String getVideoUrl() { return videoUrl; }
    public void setVideoUrl(String videoUrl) { this.videoUrl = videoUrl; }

    public int getViews() { return views; }
    public void setViews(int views) { this.views = views; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
}
