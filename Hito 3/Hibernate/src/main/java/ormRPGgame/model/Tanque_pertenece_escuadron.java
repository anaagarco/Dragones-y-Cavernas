package ormRPGgame.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.*;

@Entity
@Table(name="Tanque_pertenece_escuadron")
public class Tanque_pertenece_escuadron implements Serializable {
    @Id
    //@Column(name = "id_e",nullable = false)
    @ManyToOne(optional = false)
    @JoinColumn(name="id_e")
    private Escuadron id_e;
    @Id
   // @Column(name="id_t",nullable = false)
    @ManyToOne(optional = false)
    @JoinColumn(name="id_t")
    private Tanque id_t;
    @Column(name="fecha_inicio")
    private Date fecha_inicio;
    @Column(name="fecha_fin")
    private Date fecha_fin;
}
