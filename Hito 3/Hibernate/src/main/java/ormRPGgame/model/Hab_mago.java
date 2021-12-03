package ormRPGgame.model;
import java.util.*;
import javax.persistence.*;

@Entity
@Table(name="hab_mago")
public class Hab_mago {
    @Id
    @Column(name="nombre_hm",nullable = false)
    private String nombre_hm;
    @Column(name="descripcion",nullable = false)
    private String descripcion;
    //Hab_mago es la clase no poseedora o inversa ya que el mago es el que posee la habilidad y no la habilidad quien posee al mago
    @ManyToMany(mappedBy = "hab_mago")
    private Set<Mago> id_m;
}
