package ormRPGgame.model;
import javax.persistence.*;
import java.util.*;

@Entity
@Table(name="Pocion")
public class Pocion {
    @Id
    @Column(name="cod_p")
    private Integer cod_p;
    @Column(name="tipo",nullable=false)
    private String tipo;
    @Column(name="valores_regeneracion")
    private Integer valores_regeneracion;
    @ManyToMany(mappedBy="cod_p")
    private Set<Personaje> nombre_p;
}
