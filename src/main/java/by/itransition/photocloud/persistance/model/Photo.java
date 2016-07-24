package by.itransition.photocloud.persistance.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "photos", catalog = "auth")
public class Photo {

    @Id
    @Column(name = "photo_id", nullable = false)
    private String id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_email", nullable = false)
    private User user;

    @Column(name = "upload_date", nullable = false)
    private Date uploadDate;

    @Column
    private boolean deleted;

    @Column(name = "func")
    private boolean reserved;

    public Photo() {
    }

    public Photo(String id, User user, boolean deleted) {
        this.id = id;
        this.user = user;
        this.deleted = deleted;
    }

    public Photo(String id, User user, Date uploadDate, boolean deleted, boolean reserved) {
        this.id = id;
        this.user = user;
        this.uploadDate = uploadDate;
        this.deleted = deleted;
        this.reserved = reserved;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(Date uploadDate) {
        this.uploadDate = uploadDate;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    public boolean isReserved() {
        return reserved;
    }

    public void setReserved(boolean reserved) {
        this.reserved = reserved;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Photo photo = (Photo) o;

        return id.equals(photo.id);

    }

    @Override
    public int hashCode() {
        return id.hashCode();
    }

    @Override
    public String toString() {
        return "Photo{" +
                "id='" + id + '\'' +
                ", deleted=" + deleted +
                '}';
    }
}
