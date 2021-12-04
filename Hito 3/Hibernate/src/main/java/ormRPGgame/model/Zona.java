package ormRPGgame.model;
import javax.persistence.*;
import java.util.*;

@Entity
@Table(name="zona")
public class Zona {
    @Id
    @Column(name="id_zona")
    private Long id_zona;
    @OneToMany(mappedBy ="id_zonac")
    private Set<Ciudad> ciudades;

}
