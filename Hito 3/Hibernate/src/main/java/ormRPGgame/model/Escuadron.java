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
    @ManyToMany(mappedBy = "id_e")
    private Set<Mago> id_m;
    @ManyToMany(mappedBy = "id_e")
    private Set<Guerrero> id_g;
    @ManyToMany(mappedBy = "id_e")
    private Set<Tanque> id_t;
    //FALTA REVISAR
    @OneToMany(mappedBy = "id_e")
    private Set<Escuadron_vence_dragon> nombre_d;

}
