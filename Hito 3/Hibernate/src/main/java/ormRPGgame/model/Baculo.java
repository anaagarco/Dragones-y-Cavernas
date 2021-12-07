package ormRPGgame.model;

import javax.persistence.*;

@Entity
@Table(name="baculo")
public class Baculo {
    @Id
    @Column(name="nombre_b",nullable = false)
    private String nombre_b;
    @Column(name="danio")
    private Integer danio;
    @Column(name="peso")
    private Integer peso;
    //Mago almacena baculo
    @ManyToOne(optional = false)
    @JoinColumn(name="id_m")
    private Mago id_m;
    @OneToMany(mappedBy = "nombre_f")
    private Forja nombre_f;


}
