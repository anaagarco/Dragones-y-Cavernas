package ormRPGgame.model;

import javax.persistence.*;
import java.util.Set;


@Entity
@Table(name="forja")
public class Forja {
    @Id
    @Column(name="nombre_f",nullable = false)
    private String nombre_f;
    @Column(name="id_npc",nullable = false)
    private Npc id_npc;
    //Forja se encuentra en ciudad
    @ManyToMany(mappedBy ="forjas" )
    private Set<Ciudad> ciudades;


}
