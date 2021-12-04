package ormRPGgame.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name="escuadron")
public class Escuadron {
    @Id
    @Column(name="id_e",nullable = false)
    //La key es de tipo string pero es un numero ,la dejo de string o
    //por ser un numero deberia ponerla de long
    private long id_e;
    //No poseedora
    @OneToMany(mappedBy = "id_m")
    private Set<Mago_pertenece_escuadron> id_m;
    @OneToMany(mappedBy = "id_g")
    private Set<Guerrero_pertenece_escuadron> id_g;
    @OneToMany(mappedBy = "id_t")
    private Set<Tanque_pertenece_escuadron> id_t;
    //FALTA REVISAR
    @OneToMany(mappedBy = "id_e")
    private Set<Escuadron_vence_dragon> dragonesE;

}
