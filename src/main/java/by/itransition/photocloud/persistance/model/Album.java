package by.itransition.photocloud.persistance.model;

import javax.persistence.*;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "albums", catalog = "auth")
public class Album {

    @Id
    @Column(nullable = false)
    private int id;

    @Column(nullable = false)
    private String name;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_email", nullable = false)
    private User user;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "album_photo", catalog = "auth",
            joinColumns = {@JoinColumn(name = "id", nullable = false)},
            inverseJoinColumns = {@JoinColumn(name = "photo_id", nullable = false)})
    private Set<Photo> photos = new HashSet<>(0);

    @Column(name = "create_date", nullable = false)
    private Date date;

    @Column
    private boolean deleted;

    @Column
    private String effects;

    @Column
    private int speed;

    @Column(name = "effect_speed")
    private int effectSpeed;

    @Column(name = "p_order")
    private boolean randonOrder;

    public Album() {
    }

    public Album(String name, User user, boolean deleted, String effects) {
        this.name = name;
        this.user = user;
        this.deleted = deleted;
        this.effects = effects;
    }

//    public Album(String name, User user, boolean deleted, String effects,
//                 int speed, int effectSpeed, boolean randonOrder) {
//        this.name = name;
//        this.user = user;
//        this.deleted = deleted;
//        this.photos = photos;
//        this.speed = speed;
//        this.effectSpeed = effectSpeed;
//        this.randonOrder = randonOrder;
//    }

    public Album(int id, String name, User user, Set<Photo> photos, Date date,
                 boolean deleted, String effects, int speed, int effectSpeed, boolean randonOrder) {
        this.id = id;
        this.name = name;
        this.user = user;
        this.photos = photos;
        this.date = date;
        this.deleted = deleted;
        this.effects = effects;
        this.speed = speed;
        this.effectSpeed = effectSpeed;
        this.randonOrder = randonOrder;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    public Set<Photo> getPhotos() {
        return photos;
    }

    public void setPhotos(Set<Photo> photos) {
        this.photos = photos;
    }

    public String getEffects() {
        return effects;
    }

    public void setEffects(String effects) {
        this.effects = effects;
    }

    public int getSpeed() {
        return speed;
    }

    public void setSpeed(int speed) {
        this.speed = speed;
    }

    public int getEffectSpeed() {
        return effectSpeed;
    }

    public void setEffectSpeed(int effectSpeed) {
        this.effectSpeed = effectSpeed;
    }

    public boolean isRandonOrder() {
        return randonOrder;
    }

    public void setRandonOrder(boolean randonOrder) {
        this.randonOrder = randonOrder;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Album album = (Album) o;

        if (id != album.id) return false;
        if (deleted != album.deleted) return false;
        if (!name.equals(album.name)) return false;
        return date.equals(album.date);

    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + name.hashCode();
        result = 31 * result + date.hashCode();
        result = 31 * result + (deleted ? 1 : 0);
        return result;
    }

    @Override
    public String toString() {
        return "Album{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", date=" + date +
                ", deleted=" + deleted +
                '}';
    }
}
