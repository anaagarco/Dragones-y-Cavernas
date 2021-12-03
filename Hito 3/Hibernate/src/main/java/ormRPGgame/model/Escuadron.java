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
    //Poseedora de relacion vence con dragon
    @Column(name="fecha")
    private Date fecha;
    @ManyToMany
    @JoinTable(name="escuadron_vence_dragon")
    private Set<Dragon> nombre_d;

}
