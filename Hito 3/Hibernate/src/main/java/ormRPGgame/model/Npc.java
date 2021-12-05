package ormRPGgame.model;
import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name="npc")
public class Npc {
    @Id
    @Column(name="ID_NPC")
    private String id_npc;
    @Column(name="tipo",nullable = false)
    private String tipo;
    //NPC trabaja en tienda
    @ManyToMany(mappedBy = "npcs")
    private Set<Tienda> tiendas;
}
