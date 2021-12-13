package ormRPGgame.model;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name="hacha")
public class Hacha {
    @Id
    @Column(name="nombre_h",nullable = false)
    private String nombre_h;
    @Column(name="anio")
    private Integer anio;
    @Column(name="peso")
    private Integer peso;
    //Tanque almacena hacha
    @ManyToOne(optional = false)
    @JoinColumn(name="id_t")
    private Tanque id_t;
    @OneToMany(mappedBy = "nombre_f")
    private Set<Forja> nombre_f;


}

