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
    @OneToOne(mappedBy = "mago")
    private Daga daga;


    public Mago(String id_m, Integer mana, Integer vida, Integer nivel) {
        this.id_m = id_m;
        this.mana = mana;
        this.vida = vida;
        this.nivel = nivel;
    }

    public String getId_m() {
        return id_m;
    }

    public Integer getMana() {
        return mana;
    }

    public Integer getVida() {
        return vida;
    }

    public Integer getNivel() {
        return nivel;
    }
}
