package ormRPGgame.model;
import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name="ciudad")
public class Ciudad {
    @Id
    @Column(name="nombre_c")
    private String nombre_c;
    @ManyToOne(optional = false)
    @JoinColumn(name="id_zona")
    private Zona id_zonac;
    //Forja se encuentra en ciudad
    @ManyToMany()
    @JoinTable(name="forja_se_encuentra_ciudad")
    private Set<Forja> forjas;
    //Tienda se encuentra en ciudad
    @OneToMany(mappedBy = "nombre_c")
    private Set<Tienda> tiendas;
}

