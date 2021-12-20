package ormRPGgame.model;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name="guerrero")
public class Guerrero {
    @Id
    @Column(name="id_g",nullable = false)
    private String id_g;
    @Column(name="mana",nullable = false)
    private Integer mana;
    @Column(name="vida",nullable = false)
    private Integer vida;
    @Column(name="nivel",nullable = false)
    private Integer nivel;
    //Guerrero almacena y porta espada
    @OneToMany(mappedBy = "id_g")
    private Set<Espada> espadas;
    //Guerreros crea en forja
    @OneToMany (mappedBy="id_g")
    private Set<Guerrero_crea_en_forja> guerreros;
    //Guerrero es la clase poseedora ya que guerrero posee una habilidad
    @ManyToMany
    @JoinTable(name="guerrero_tiene_hab_guerrero")
    private Set<Hab_guerrero> hab_guerrero;
    //Guerrero vencera a los goblins
    @ManyToMany
    @JoinTable(name="guerrero_derrota_goblin")
    private Set<Goblin> cod_mg;
    //Rol pertenece a escuadron
    @OneToMany (mappedBy="id_g")
    private Set<Guerrero_pertenece_escuadron> id_gp;
    @OneToOne(mappedBy = "guerrero")
    private Daga daga;
}
