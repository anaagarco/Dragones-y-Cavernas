package ormRPGgame.model;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name="troll")
public class Troll {
    @Id
    @Column(name="cod_mt",nullable = false)
    private String cod_mt;
    @Column(name="vida",nullable = false)
    private Integer vida;
    @Column(name="oro_soltado",nullable = false)
    private Integer oro_soltado;
    //Troll en la clase no poseedora
    @ManyToMany(mappedBy = "cod_mt")
    private Set<Tanque> id_t;

}
