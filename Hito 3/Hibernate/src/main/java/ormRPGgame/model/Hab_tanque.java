package ormRPGgame.model;
import java.util.*;
import javax.persistence.*;

@Entity
@Table(name="hab_tanque")
public class Hab_tanque {
    @Id
    @Column(name="nombre_ht",nullable = false)
    private String nombre_ht;
    @Column(name="descripcion",nullable = false)
    private String descripcion;
    //Hab_tanque es la clase no poseedora o inversa ya que el tanque es el que posee la habilidad y no la habilidad quien posee al tanque
    @ManyToMany(mappedBy = "hab_tanque")
    private Set<Tanque> id_t;
}

