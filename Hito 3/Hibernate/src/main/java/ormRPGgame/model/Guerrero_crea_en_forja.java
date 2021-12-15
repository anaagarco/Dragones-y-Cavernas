package ormRPGgame.model;
import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name="guerrero_crea_en_forja")
public class Guerrero_crea_en_forja implements Serializable {
    @Id
    @ManyToOne(optional = false)
    @JoinColumn(name="id_g")
    private Guerrero id_g;
    @Id
    @ManyToOne(optional = false)
    @JoinColumn(name="nombre_f")
    private Forja nombre_f;
    @Column(name="fecha",nullable = false)
    private Date fecha;


}