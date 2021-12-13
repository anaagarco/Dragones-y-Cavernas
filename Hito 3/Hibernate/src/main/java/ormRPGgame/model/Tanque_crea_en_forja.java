package ormRPGgame.model;
import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name="tanque_crea_en_forja")
public class Tanque_crea_en_forja {
    @Id
    @ManyToOne(optional = false)
    @JoinColumn(name="id_t")
    private Tanque id_t;
    @Id
    @ManyToOne(optional = false)
    @JoinColumn(name="nombre_f")
    private Forja nombre_f;
    @Column(name="fecha",nullable = false)
    private Date fecha;


}
