package by.itransition.photocloud.persistance.dto;

import java.util.Arrays;

public class AlbumDto {

    private int id;

    private String name;

    private String[] effects;

    private int speed;

    private int effectsSpeed;

    private boolean random;

    public AlbumDto() {
    }

    public AlbumDto(int id, String name, String[] effects, int speed, int effectsSpeed, boolean random) {
        this.id = id;
        this.name = name;
        this.effects = effects;
        this.speed = speed;
        this.effectsSpeed = effectsSpeed;
        this.random = random;
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

    public String[] getEffects() {
        return effects;
    }

    public void setEffects(String[] effects) {
        this.effects = effects;
    }

    public int getSpeed() {
        return speed;
    }

    public void setSpeed(int speed) {
        this.speed = speed;
    }

    public int getEffectsSpeed() {
        return effectsSpeed;
    }

    public void setEffectsSpeed(int effectsSpeed) {
        this.effectsSpeed = effectsSpeed;
    }

    public boolean isRandom() {
        return random;
    }

    public void setRandom(boolean random) {
        this.random = random;
    }

    @Override
    public String toString() {
        return "AlbumDto{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", effects=" + Arrays.toString(effects) +
                ", speed=" + speed +
                ", effectsSpeed=" + effectsSpeed +
                ", random=" + random +
                '}';
    }
}
