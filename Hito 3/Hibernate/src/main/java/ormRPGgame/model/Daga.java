package ormRPGgame.model;

import javax.persistence.*;
import java.util.Set;

// @TODO completar las anotaciones de la clase
    @Entity
    @Table(name="Daga")
    public class Daga {
    // @TODO completar las anotaciones de todos los atributos
    @Id
    @Column(name = "ID_Daga")
    private Long id_daga;
    @Column(name = "tipo", nullable = false)
    private String tipo;
    //Personaje tiene daga
    private Personaje nombre_p;
    //Daga se compra en tienda
    @ManyToMany(mappedBy = "dagas")
    private Set<Tienda> nombre_t;

    public Daga(Long id_daga, String tipo) {
        this.id_daga = id_daga;
        this.tipo = tipo;
    }

    public Long getnombre() {
        return this.id_daga;
    }

    public Long getId_daga() {
        return id_daga;
    }

    public String getTipo() {
        return this.tipo;
    }
}