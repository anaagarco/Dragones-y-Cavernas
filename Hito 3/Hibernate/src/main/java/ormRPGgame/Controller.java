package ormRPGgame;

import ormRPGgame.model.Mago;
import ormRPGgame.model.Daga;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

import java.sql.*;


/**
 * Controlador de la aplicación. Por favor, revise detenidamente la clase y complete las partes omitidas
 * atendiendo a los comentarios indicados mediante @TODO
 */
public class Controller {

    private Session session;

    /**
     * Crea un nuevo controlador
     */
    public Controller () {

        StandardServiceRegistry registry = new StandardServiceRegistryBuilder()
                .configure()
                .build();

        SessionFactory sessionFactory = new MetadataSources(registry)
                .buildMetadata()
                .buildSessionFactory();

        this.session = sessionFactory.openSession();
    }

    /**
     * Crea un nuevo mago
     * param nickname nombre de usuario
     * @return el nuevo usuario creado
     */
    public Daga createDaga(Long id_daga, String tipo){
        // @TODO complete este metodo para crear de forma presistente una daga
    Daga daga= new Daga(id_daga,tipo);
        session.beginTransaction();
        session.saveOrUpdate(daga);
        session.getTransaction().commit();
        return daga;
    }

    public Mago createMago(String id_m, Integer mana,Integer vida,Integer nivel){
        // @TODO complete este metodo para crear de forma presistente un mago
        Mago mago= new Mago(id_m,mana,vida,nivel);
        session.beginTransaction();
        session.saveOrUpdate(mago);
        session.getTransaction().commit();
        return mago;
    }

}
