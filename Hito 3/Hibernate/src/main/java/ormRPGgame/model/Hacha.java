package ormRPGgame.model;

import javax.persistence.*;

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
    @ManyToOne(optional = false)
    @JoinColumn(name="id_t")
    private Tanque id_t;
    @ManyToMany(mappedBy = "nombre_f")
    private Forja nombre_f;


}

