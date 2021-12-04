package ormRPGgame.model;

import ormRPGgame.model.Personaje;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name="tanque")
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
        //Tanque es la clase poseedora ya que tanque posee una habilidad
        @ManyToMany
        @JoinTable(name="tanque_tiene_hab_tanque")
        private Set<Hab_tanque> hab_tanque;
        //Tanque vencera a los trolls
        @ManyToMany
        @JoinTable(name="tanque_derrota_troll")
        private Set<Goblin> cod_mt;
        //Rol pertenece a escuadron
        @OneToMany(mappedBy = "id_t")
        private Set<Tanque_pertenece_escuadron> id_tp;
}
