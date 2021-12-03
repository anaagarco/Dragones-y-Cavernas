package ormRPGgame.model;

import javax.persistence.*;

@Entity
@Table(name="escuadron")
public class Escuadron {
    @Id
    @Column(name="id_e",nullable = false)
    //La key es de tipo string pero es un numero ,la dejo de string o
    //por ser un numero deberia ponerla de long
    private long id_e;
}
