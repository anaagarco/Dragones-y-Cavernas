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
    @ManyToMany()
    @JoinTable(name="forja_se_encuentra_ciudad")
    private Set<Forja> forjas;
}

