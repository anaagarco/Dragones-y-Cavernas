package ormRPGgame.model;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name="baculo")
public class Baculo {
    @Id
    @Column(name="nombre_b",nullable = false)
    private String nombre_b;
    @Column(name="anio")
    private Integer anio;
    @Column(name="peso")
    private Integer peso;
    //Mago almacena baculo
    @ManyToOne(optional = false)
    @JoinColumn(name="id_m")
    private Mago id_m;
    @OneToMany(mappedBy = "nombre_f")
    private Set<Forja> nombre_f;


}
