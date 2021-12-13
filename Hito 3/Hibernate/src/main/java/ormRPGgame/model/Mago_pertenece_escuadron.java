package ormRPGgame.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name="mago_pertenece_escuadron")
public class Mago_pertenece_escuadron {
    @Id
    //@Column(name = "id_e",nullable = false)
    @ManyToOne(optional = false)
    @JoinColumn(name="id_e")
    private Escuadron id_e;
    @Id
    //@Column(name="id_m",nullable = false)
    @ManyToOne(optional = false)
    @JoinColumn(name="id_m")
    private Mago id_m;
    @Column(name="fecha_inicio")
    private Date fecha_inicio;
    @Column(name="fecha_fin")
    private Date fecha_fin;
}
