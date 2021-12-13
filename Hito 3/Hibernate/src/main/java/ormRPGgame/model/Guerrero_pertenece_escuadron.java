package ormRPGgame.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name="guerrero_pertenece_escuadron")
public class Guerrero_pertenece_escuadron {
    @Id
    //@Column(name = "id_e",nullable = false)
    @ManyToOne(optional = false)
    @JoinColumn(name="id_e")
    private Escuadron id_e;
    @Id
   // @Column(name="id_g",nullable = false)
    @ManyToOne(optional = false)
    @JoinColumn(name="id_g")
    private Guerrero id_g;
    @Column(name="fecha_inicio")
    private Date fecha_inicio;
    @Column(name="fecha_fin")
    private Date fecha_fin;
}
