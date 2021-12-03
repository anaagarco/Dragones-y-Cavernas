package ormRPGgame.model;

import javax.persistence.*;
import java.util.*;
@Entity
@Table(name="escuadron_vence_dragon")
public class Escuadron_vence_dragon {
    @Column(name="fecha")
    private Date fecha;
    @ManyToOne(optional = false)
    @JoinColumn(name ="id_e" )
    private Escuadron id_e;
    @ManyToOne(optional = false)
    @JoinColumn(name ="nombre_d" )
    private Dragon nombre_d;
}