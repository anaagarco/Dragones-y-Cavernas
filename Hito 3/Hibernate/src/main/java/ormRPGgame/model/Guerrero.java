package ormRPGgame.model;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name="ormRPGgame.model.Guerrero")
public class Guerrero {
    @Id
    @Column(name="id_g",nullable = false)
    @OneToMany(mappedBy = "id_g")
    private String id_g;
    @Column(name="mana",nullable = false)
    private Integer mana;
    @Column(name="vida",nullable = false)
    private Integer vida;
    @Column(name="nivel",nullable = false)
    private Integer nivel;
    //Guerrero es la clase poseedora ya que guerrero posee una habilidad
    @ManyToMany
    @JoinTable(name="guerrero_tiene_hab_guerrero")
    private Set<Hab_guerrero> hab_guerrero;
    //Guerrero vencera a los goblins
    @ManyToMany
    @JoinTable(name="guerrero_derrota_goblin")
    private Set<Goblin> cod_mg;
}
