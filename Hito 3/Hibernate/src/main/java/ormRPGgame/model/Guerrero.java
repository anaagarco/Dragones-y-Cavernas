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
}
