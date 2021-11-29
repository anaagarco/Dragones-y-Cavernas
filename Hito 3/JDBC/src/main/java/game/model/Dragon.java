package game.model;

/**
 * Modela un dragón. No es necesario modificar esta clase. Pero debe crear tantas clases como entidades
 * necesite para llevar a cabo esta parte del hito 3. Inclúyalas en el paquete "game.model"
 */
public class Dragon {

    private String name;
    private int life_points;
    private String dragon_unlock;

    public Dragon(String name, int life, String dragon_unlock) {
        this.name = name;
        this.life_points = life;
        this.dragon_unlock = dragon_unlock;
    }

    public int getLife() {
        return this.life_points;
    }

    public String getName() {
        return this.name;
    }

    public String getDragon_unlock() {
        return this.dragon_unlock;
    }
}
