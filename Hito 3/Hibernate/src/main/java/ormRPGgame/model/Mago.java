package ormRPGgame.model;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

// @TODO completar las anotaciones de la clase
@Entity
@Table(name="mago")
public class Mago {
    // @TODO completar las anotaciones de todos los atributos
    @Id
    @Column(name = "id_m", nullable = false)
    private String id_m;
    @Column(name = "mana", nullable = false)
    private Integer mana;
    @Column(name = "vida", nullable = false)
    private Integer vida;
    @Column(name = "nivel", nullable = false)
    private Integer nivel;
    //Mago almacena  Y porta baculo
    @OneToMany(mappedBy = "id_m")
    private Set<Baculo> baculos;
    //Mago crea en forja
    @OneToMany (mappedBy="id_m")
    private Set<Mago_crea_en_forja> magos;
    //Mago es la clase poseedora ya que mago posee una habilidad
    @ManyToMany
    @JoinTable(name="mago_tiene_hab_mago")
    private Set<Hab_mago> hab_mago;
    //Mago vencera a los espectros
    @ManyToMany
    @JoinTable(name="mago_derrota_espectro")
    private Set<Espectro> cod_me;
    //Rol pertenece a escuadron
    @OneToMany (mappedBy="id_m")
    private Set<Mago_pertenece_escuadron> id_mp;


    public Mago(String nombre, Daga daga){
        // @TODO completar el constructor de la clase.
        //  Para ello es necesario un string con el nombre del mago y un objeto de la clase daga
        //  Inicialice el resto de atributos a los valores que considere oportunos
    }

    public String getnombre(){ return this.id_m;}
}
