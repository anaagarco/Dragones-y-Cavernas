package ormRPGgame.model;
import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name="mago_crea_en_forja")
public class Mago_crea_en_forja {
    @Id
    @ManyToOne(optional = false)
    @JoinColumn(name="id_m")
    private Mago id_m;
    @Id
    @ManyToOne(optional = false)
    @JoinColumn(name="nombre_f")
    private Forja nombre_f;
    @Column(name="fecha",nullable = false)
    private Date fecha;


}
