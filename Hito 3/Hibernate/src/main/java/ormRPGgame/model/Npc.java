package ormRPGgame.model;
import javax.persistence.*;

@Entity
@Table(name="Npc")
public class Npc {
    @Id
    @Column(name="ID_NPC")
    private String ID_NPC;
    @Column(name="tipo",nullable = false)
    private String tipo;
}
