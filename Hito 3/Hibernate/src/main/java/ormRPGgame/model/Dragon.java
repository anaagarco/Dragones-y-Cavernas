package ormRPGgame.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name="dragon")
public class Dragon {
    @Id
    @Column(name="nombre_d",nullable = false)
    private String nombre_d;
    @Column(name="vida",nullable = false)
    private Integer vida;
    @Column(name="nombre_d_desbloqueado",nullable = false)
    private Dragon  nombre_d_desbloqueado;
    //FALTA REVISAR
    @OneToMany(mappedBy = "nombre_d")
    private Set<Escuadron_vence_dragon> dragonesD;




}
