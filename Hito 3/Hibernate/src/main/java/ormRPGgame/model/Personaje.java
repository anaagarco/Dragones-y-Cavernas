package ormRPGgame.model;

import ormRPGgame.model.Guerrero;

import javax.persistence.*;

@Entity
@Table(name="ormRPGgame.model.Personaje")
public class Personaje {
    @Id
    @Column(name="nombre_p",nullable = false)
    private String nombre_p;
    @Column(name="fuerza",nullable = false)
    private Integer fuerza;
    @ManyToOne(optional=false)
    @JoinColumn(name="mail")
    private Jugador mail;
    @ManyToOne(optional=false)
    @JoinColumn(name="id_m")
    private Mago id_m;
    @ManyToOne(optional=false)
    @JoinColumn(name="id_g")
    private Guerrero id_g;
    @ManyToOne(optional=false)
    @JoinColumn(name="id_t")
    private Tanque id_t;


}
