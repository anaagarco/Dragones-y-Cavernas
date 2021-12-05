package ormRPGgame.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name="personaje_entrega_npc_pocion")
public class Personaje_entrega_npc_pocion {
    @Id
    @Column(name="id_npc")
    @ManyToOne(optional = false)
    @JoinColumn(name="id_npc")
    private Npc id_npc;
    @Id
    @Column(name="cod_p")
    @ManyToOne(optional = false)
    @JoinColumn(name="cod_p")
    private Pocion cod_p;
    @Id
    @Column(name="nombre_p")
    @ManyToOne(optional = false)
    @JoinColumn(name="nombre_p")
    private Personaje nombre_p;
    @Column(name = "fecha",nullable = false)
    private Date fecha;

}
