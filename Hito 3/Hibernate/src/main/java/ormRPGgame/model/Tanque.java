package ormRPGgame.model;

import ormRPGgame.model.Personaje;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name="ormRPGgame.model.Tanque")
public class Tanque {
        @Id
        @Column(name="id_t",nullable = false)
        @OneToMany(mappedBy = "id_t")
        private String id_t;
        @Column(name="mana",nullable = false)
        private Integer mana;
        @Column(name="vida",nullable = false)
        private Integer vida;
        @Column(name="nivel",nullable = false)
        private Integer nivel;
}
