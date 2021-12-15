package ormRPGgame.model;

import ormRPGgame.model.Guerrero;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name="personaje")
public class Personaje {
    @Id
    @Column(name="nombre_p",nullable = false)
    private String nombre_p;
    @Column(name="fuerza",nullable = false)
    private Integer fuerza;
    @ManyToOne(optional=false)
    //Jugador crea personaje
    @JoinColumn(name="mail")
    private Jugador mail;
    //Personaje es un rol
    @ManyToOne(optional=false)
    @JoinColumn(name="id_m")
    private Mago id_m;
    @ManyToOne(optional=false)
    @JoinColumn(name="id_g")
    private Guerrero id_g;
    @ManyToOne(optional=false)
    @JoinColumn(name="id_t")
    private Tanque id_t;
    //Persona entrega npc pocion
    @OneToMany(mappedBy = "nombre_p")
    private Set<Personaje_entrega_npc_pocion> personajes;

    public String getNombre_p() {
        return nombre_p;
    }
}
