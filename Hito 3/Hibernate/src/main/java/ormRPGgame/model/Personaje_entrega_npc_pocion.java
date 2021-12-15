package ormRPGgame.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.*;

@Entity
@Table(name="personaje_entrega_npc_pocion")
public class Personaje_entrega_npc_pocion implements Serializable {
    @Id
    //@Column(name="id_npc")
    @ManyToOne(optional = false)
    @JoinColumn(name="npcs")
    private Npc id_npc;
    @Id
   // @Column(name="cod_p")
    @ManyToOne(optional = false)
    @JoinColumn(name="pocions")
    private Pocion cod_p;
    @Id
   // @Column(name="nombre_p")
    @ManyToOne(optional = false)
    @JoinColumn(name="personajes")
    private Personaje nombre_p;
    @Column(name = "fecha",nullable = false)
    private Date fecha;

}
