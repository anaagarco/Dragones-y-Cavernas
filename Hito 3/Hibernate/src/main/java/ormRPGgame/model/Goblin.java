package ormRPGgame.model;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name="goblin")
public class Goblin {
    @Id
    @Column(name="cod_mg",nullable = false)
    private String cod_mg;
    @Column(name="vida",nullable = false)
    private Integer vida;
    @Column(name="oro_soltado",nullable = false)
    private Integer oro_soltado;
    //Espectro en la clase no poseedora
    @ManyToMany(mappedBy = "cod_mg")
    private Set<Guerrero> id_g;

}

