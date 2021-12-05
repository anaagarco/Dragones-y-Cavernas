package ormRPGgame.model;
import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name="tienda")
public class Tienda {
    @Id
    @Column(name="nombre_t")
    private String nombre_t;
    //Ciudad hay tienda
    @Column(name="nombre_c")
    @ManyToOne(optional = false)
    @JoinColumn(name="nombre_c")
    private Ciudad nombre_c;
    //NPC trabaja en tienda
    @ManyToMany()
    @JoinTable(name="")
    private Set<Npc> npcs;
}
