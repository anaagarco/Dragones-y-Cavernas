package ormRPGgame.model;

import javax.persistence.*;
import java.util.Set;


@Entity
@Table(name="forja")
public class Forja {
    @Id
    @Column(name="nombre_f",nullable = false)
    private String nombre_f;
    //NPC dueño de forja
    //@Column(name="id_npc",nullable = false)
    @OneToOne
    private Npc id_npc;
    //Forja se encuentra en ciudad
    @ManyToMany(mappedBy ="forjas" )
    private Set<Ciudad> ciudades;
    //Roles crean en forjas
    @OneToMany(mappedBy = "nombre_f")
    private Set<Mago_crea_en_forja> forjasM;
    @OneToMany(mappedBy = "nombre_f")
    private Set<Guerrero_crea_en_forja> forjasG;
    @OneToMany(mappedBy = "nombre_f")
    private Set<Tanque_crea_en_forja> forjasT;



}
