package ormRPGgame.model;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

// @TODO completar las anotaciones de la clase
@Entity
@Table(name="Mago")
public class Mago {
    // @TODO completar las anotaciones de todos los atributos
    @Id
    @Column(name = "id_g", nullable = false)
    @OneToMany(mappedBy = "id_g")
    private String id_g;//pongo set para representar que personaje es el many
    @Column(name = "mana", nullable = false)
    private Integer mana;
    @Column(name = "vida", nullable = false)
    private Integer vida;
    @Column(name = "nivel", nullable = false)
    private Integer nivel;
    //Mago es la clase poseedora ya que mago posee una habilidad
    @ManyToMany
    @JoinTable(name="mago_tiene_hab_mago")
    private Set<Hab_mago> hab_mago;
    //Mago vencera a los espectros
    @ManyToMany
    @JoinTable(name="mago_derrota_espectro")
    private Set<Espectro> cod_me;
    @ManyToMany
    @JoinTable(name="mago_pertenece_escuadron")
    private Set<Escuadron> id_e;


    public Mago(String nombre, Daga daga){
        // @TODO completar el constructor de la clase.
        //  Para ello es necesario un string con el nombre del mago y un objeto de la clase daga
        //  Inicialice el resto de atributos a los valores que considere oportunos
    }

    public String getnombre(){ return this.id_g;}
}
