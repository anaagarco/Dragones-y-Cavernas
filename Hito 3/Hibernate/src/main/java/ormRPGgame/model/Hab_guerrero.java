package ormRPGgame.model;
import java.util.*;
import javax.persistence.*;

@Entity
@Table(name="hab_guerrero")
public class Hab_guerrero {
    @Id
    @Column(name="nombre_hm",nullable = false)
    private String nombre_hg;
    @Column(name="descripcion",nullable = false)
    private String descripcion;
    //Hab_guerrero es la clase no poseedora o inversa ya que el guerrero es el que posee la habilidad y no la habilidad quien posee al guerrero
    @ManyToMany(mappedBy = "hab_guerrero")
    private Set<Guerrero> id_g;
}
