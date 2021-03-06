package ormRPGgame.model;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name="espada")
public class Espada {
    @Id
    @Column(name="nombre_e",nullable = false)
    private String nombre_e;
    @Column(name="anio")
    private Integer anio;
    @Column(name="peso")
    private Integer peso;
    //Guerrero almacena espada
    @ManyToOne(optional = false)
    @JoinColumn(name="id_g")
    private Guerrero id_g;
    @OneToMany(mappedBy = "nombre_f")
    private Set<Forja> nombre_f;


}

