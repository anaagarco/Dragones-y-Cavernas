package game.model;

public class Espada {

    private String nombre_e;
    private int anio;
    private int peso;
    private String id_g;
    private String nombre_f;

    public Espada(String nombre_e){
        this.nombre_e = nombre_e;
    }

    public String getNombre_e() {
        return nombre_e;
    }

    public void setNombre_e(String nombre_e) {
        this.nombre_e = nombre_e;
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

    public String getId_g() {
        return id_g;
    }

    public void setId_g(String id_g) {
        this.id_g = id_g;
    }

    public String getNombre_f() {
        return nombre_f;
    }

    public void setNombre_f(String nombre_f) {
        this.nombre_f = nombre_f;
    }
}
