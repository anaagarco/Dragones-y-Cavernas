package ormRPGgame.model;

import javax.persistence.*;
import java.util.Set;

// @TODO completar las anotaciones de la clase
@Entity
@Table(name = "daga")
public class Daga {
    // @TODO completar las anotaciones de todos los atributos
    @Id
    @Column(name = "id_daga")
    private Long id_daga;
    @Column(name = "tipo", nullable = false)
    private String tipo;
    //Personaje tiene daga
    @OneToOne
    private Mago mago;
    @OneToOne
    private Guerrero guerrero;
    @OneToOne
    private Tanque tanque;

    //Daga se compra en tienda
    @ManyToMany(mappedBy = "dagas")
    private Set<Tienda> nombre_t;

    public Daga(Long id_daga, String tipo, Mago mago) {
        this.id_daga = id_daga;
        this.tipo = tipo;
        this.mago = mago;
    }

    public Daga(Long id_daga, String tipo, Guerrero guerrero) {
        this.id_daga = id_daga;
        this.tipo = tipo;
        this.guerrero = guerrero;
    }

    public Daga(Long id_daga, String tipo, Tanque tanque) {
        this.id_daga = id_daga;
        this.tipo = tipo;
        this.tanque = tanque;
    }

    public Long getId_daga() {
        return id_daga;
    }

    public String getTipo() {
        return this.tipo;
    }


}