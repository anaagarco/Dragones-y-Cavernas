package ormRPGgame.model;

import javax.persistence.*;
import java.util.Set;

// @TODO completar las anotaciones de la clase
    @Entity
    @Table(name="Daga")
    public class Daga {
        // @TODO completar las anotaciones de todos los atributos
        @Id
        @Column(name="ID_Daga")
        private Long id_daga;
        @Column(name="tipo",nullable=false)
        private Integer tipo;
        //Personaje tiene daga
        private Personaje nombre_p;
        //
        @ManyToMany(mappedBy="id_daga")
        private Set<Tienda> nombre_t;
        //falta 1:1

    public Daga(String nombre){
        // @TODO completar el constructor de la clase.
    }

    public String getnombre(){ return this.id_daga;}
}
