package game.model;
/**
 * Modela un hacha
 */
public class Hacha {
    private String nombre_h;
    private int anio;
    private int peso;
    private String id_t;
    private String nombre_f;

    public Hacha(String nombre_h, int anio, int peso, String id_t, String nombre_f){
        this.nombre_h = nombre_h;
        this.anio = anio;
        this.peso = peso;
        this.id_t = id_t;
        this.nombre_f = nombre_f;
    }
    public Hacha(String nombre_h, String nombre_f){
        this.nombre_h = nombre_h;
        this.nombre_f = nombre_f;
    }

    public String getNombre_h() {
        return nombre_h;
    }

    public void setNombre_h(String nombre_h) {
        this.nombre_h = nombre_h;
    }

    public int getAnio() {
        return anio;
    }

    public void setAnio(int anio) {
        this.anio = anio;
    }

    public int getPeso() {
        return peso;
    }

    public void setPeso(int peso) {
        this.peso = peso;
    }

    public String getId_t() {
        return id_t;
    }

    public void setId_t(String id_t) {
        this.id_t = id_t;
    }
}
