package ormRPGgame.model;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name="espectro")
public class Espectro {
    @Id
    @Column(name="cod_me",nullable = false)
    private String cod_me;
    @Column(name="vida",nullable = false)
    private Integer vida;
    @Column(name="oro_soltado",nullable = false)
    private Integer oro_soltado;
    //Espectro en la clase no poseedora
    @ManyToMany(mappedBy = "cod_me")
    private Set<Mago> id_m;

}
