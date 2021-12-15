package ormRPGgame.model;
import javax.persistence.*;
import java.util.*;

@Entity
@Table(name="jugador")
public class Jugador{
    @Id
    @Column(name="mail",nullable = false)
    private String mail;
    @Column(name="pass",nullable = false)
    private String pass;
    @Column(name="nickname",nullable = false)
    private String nickname;
    @OneToMany(mappedBy = "mail")
    private Set<Personaje> personajes;
}
